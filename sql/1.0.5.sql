SELECT
  'Integrity check',
  'Editorial decision                                     ',
  'gsd.AcceptedTaxonID',
  'gsd.Genus',
  'gsd.Species',
  'gsd.AuthorString',
  'gsd.DistributionElement',
  'col.distribution'
UNION SELECT
        '1.0.5 GSD missing infraspecies distribution data currently in CoL',
        '',
        gsd.GM_INFRA_AcceptedTaxonID,
        gsd.GM_ACC_Genus,
        gsd.GM_ACC_SpeciesEpithet,
        gsd.GM_ACC_AuthorString,
        gsd.GM_DIST_DistributionElement,
        col.distribution
      FROM (SELECT
              ACC.GM_INFRA_AcceptedTaxonID,
              GM_ACC_Genus,
              GM_ACC_SpeciesEpithet,
              GM_ACC_AuthorString,
              GM_DIST_DistributionElement
            FROM (SELECT
                    `GM_AcceptedInfraSpecificTaxa`.GM_INFRA_AcceptedTaxonID,
                    GM_ACC_Genus,
                    GM_ACC_SpeciesEpithet,
                    GM_ACC_AuthorString
                  FROM `GM_GSD`.`GM_AcceptedInfraSpecificTaxa`
                    INNER JOIN `GM_GSD`.`GM_AcceptedSpecies`
                      ON `GM_GSD`.`GM_AcceptedInfraSpecificTaxa`.GM_INFRA_ParentSpeciesID =
                         `GM_GSD`.`GM_AcceptedSpecies`.GM_ACC_AcceptedTaxonID) AS ACC INNER JOIN
              GM_GSD.GM_Distribution AS DIST ON ACC.GM_INFRA_AcceptedTaxonID = DIST.GM_DIST_AcceptedTaxonID) AS gsd INNER JOIN (SELECT
                                                                                                       Assembly_Global.scientific_names.record_id,
                                                                                                       genus,
                                                                                                       species,
                                                                                                       infraspecies,
                                                                                                       author,
                                                                                                       distribution,
                                                                                                       scientific_names.database_id
                                                                                                     FROM
                                                                                                       Assembly_Global.scientific_names
                                                                                                       INNER JOIN
                                                                                                       Assembly_Global.distribution
                                                                                                         ON
                                                                                                           Assembly_Global.scientific_names.name_code
                                                                                                           =
                                                                                                           Assembly_Global.distribution.name_code) AS col
          ON gsd.GM_ACC_Genus = col.Genus AND gsd.GM_ACC_SpeciesEpithet = col.Species
      WHERE (gsd.GM_DIST_DistributionElement IS NULL OR gsd.GM_DIST_DistributionElement = '') AND
            (col.distribution IS NOT NULL OR col.Distribution <> '') AND col.database_id = '{{DatabaseID}}';