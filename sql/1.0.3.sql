SELECT
  'Integrity check',
  'Editorial decision                                     ',
  'AcceptedTaxonID',
  'gsd.Family',
  'col.Family',
  'gsd.SuperFamily*',
  'col.SuperFamily*',
  'gsd.SubGenusname*',
  'col.subgenus*',
  'gsd.Genus',
  'col.genus',
  'gsd.Species',
  'col.species',
  'col.infraspecies',
  'gsd.authorstring',
  'col.author',
  'col.sp2000_status_id'
UNION SELECT
        '1.0.3 GSD missing species data currently in CoL',
        '',
        gsd.`GM_INFRA_AcceptedTaxonID`,
        gsd.`GM_ACC_Family`,
        col.`Family`,
        gsd.`GM_ACC_SuperFamily`,
        col.`SuperFamily`,
        gsd.`GM_ACC_SubGenusName`,
        col.`subgenus`,
        gsd.`GM_ACC_Genus`,
        col.`genus`,
        gsd.`GM_ACC_SpeciesEpithet`,
        col.`species`,
        col.`infraspecies`,
        gsd.`GM_ACC_AuthorString`,
        col.`author`,
        col.`sp2000_status_id`
      FROM (SELECT
              infra.`GM_INFRA_AcceptedTaxonID`,
              `GM_ACC_Family`,
              `GM_ACC_SuperFamily`,
              `GM_ACC_Genus`,
              `GM_ACC_SubGenusName`,
              `GM_ACC_SpeciesEpithet`,
              `GM_INFRA_InfraSpeciesEpithet`,
              `GM_ACC_AuthorString`,
              `GM_INFRA_ParentSpeciesID`
            FROM `GM_GSD`.`GM_AcceptedInfraSpecificTaxa` AS infra INNER JOIN
              `GM_GSD`.`GM_AcceptedSpecies` AS acc
                ON infra.`GM_INFRA_ParentSpeciesID` = acc.`GM_ACC_AcceptedTaxonID`) AS gsd INNER JOIN (SELECT
                                                                                         Kingdom,
                                                                                         Phylum,
                                                                                         Class,
                                                                                         Family,
                                                                                         SuperFamily,
                                                                                         Subgenus,
                                                                                         Genus,
                                                                                         Species,
                                                                                         Infraspecies,
                                                                                         Author,
                                                                                         SN.database_id,
                                                                                         sp2000_status_id
                                                                                       FROM
                                                                                         `Assembly_Global`.scientific_names SN
                                                                                         INNER JOIN
                                                                                         `Assembly_Global`.families AS rank
                                                                                           ON (
                                                                                           SN.family_code
                                                                                           = rank.family_code)) AS col
          ON gsd.`GM_ACC_Genus` = col.`Genus` AND gsd.`GM_ACC_SpeciesEpithet` = col.`Species`
      WHERE ((gsd.`GM_ACC_Family` IS NULL OR gsd.`GM_ACC_Family` = '') AND
             (col.`Family` <> '' AND col.`Family` IS NOT NULL AND col.`Family` <> 'Not assigned') OR
             (gsd.`GM_INFRA_InfraSpeciesEpithet` IS NULL OR gsd.`GM_INFRA_InfraSpeciesEpithet` = '') AND
             (col.infraspecies <> '' AND col.infraspecies IS NOT NULL AND col.infraspecies <> 'Not assigned') OR
             (gsd.`GM_ACC_AuthorString` IS NULL OR gsd.`GM_ACC_AuthorString` = '') AND (col.author <> '' OR col.author IS NOT NULL)) AND
            database_id = '{{DatabaseID}}' AND col.sp2000_status_id = 1;