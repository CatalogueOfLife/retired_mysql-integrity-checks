SELECT
  'Integrity check',
  'Editorial decision                                     ',
  'gsd.AcceptedTaxonID',
  'gsd.Genus',
  'col.genus',
  'gsd.SubgenusName',
  'col.subgenus',
  'gsd.Species',
  'col.species',
  'gsd.AuthorString',
  'col.author',
  'gsd.DistributionElement',
  'col.distribution'
UNION SELECT
        '1.0.4 GSD missing species distribution data currently in CoL',
        '',
        gsd.GM_ACC_AcceptedTaxonID,
        gsd.GM_ACC_Genus,
        col.genus,
        gsd.GM_ACC_SubGenusName,
        col.subgenus,
        gsd.GM_ACC_SpeciesEpithet,
        col.species,
        gsd.GM_ACC_AuthorString,
        col.author,
        gsd.GM_DIST_DistributionElement,
        col.distribution
      FROM (SELECT
              ACC.GM_ACC_AcceptedTaxonID,
              GM_ACC_Genus,
              GM_ACC_SubGenusName,
              GM_ACC_SpeciesEpithet,
              GM_ACC_AuthorString,
              GM_DIST_DistributionElement
            FROM `GM_GSD`.`GM_AcceptedSpecies` AS ACC INNER JOIN `GM_GSD`.`GM_Distribution` AS DIST
                ON ACC.GM_ACC_AcceptedTaxonID = DIST.GM_DIST_AcceptedTaxonID) AS gsd INNER JOIN (SELECT
                                                                                    SN.record_id,
                                                                                    genus,
                                                                                    subgenus,
                                                                                    species,
                                                                                    infraspecies,
                                                                                    author,
                                                                                    distribution,
                                                                                    SN.database_id
                                                                                  FROM Assembly_Global.scientific_names SN
                                                                                    INNER JOIN
                                                                                    Assembly_Global.distribution DIST2 ON
                                                                                                                   SN.name_code
                                                                                                                   =
                                                                                                                   DIST2.name_code) AS col
          ON gsd.GM_ACC_Genus = col.Genus AND gsd.`GM_ACC_SpeciesEpithet` = col.Species
      WHERE (gsd.GM_DIST_DistributionElement IS NULL OR gsd.GM_DIST_DistributionElement = '') AND
            (col.distribution IS NOT NULL OR col.Distribution <> '') AND col.database_id = '{{DatabaseID}}';