SELECT
  'Integrity check',
  'Editorial decision                                     ',
  'AcceptedTaxonID',
  'gsd.SuperFamily*',
  'col.SuperFamily*',
  'gsd.Family',
  'col.Family',
  'gsd.Genus',
  'col.genus',
  'gsd.SubGenusName*',
  'col.subgenus*',
  'gsd.Species',
  'col.species',
  'col.infraspecies',
  'gsd.authorstring',
  'col.author',
  'col.sp2000_status_id'
UNION SELECT
        '1.0.2 GSD missing species data currently in CoL',
        '',
        gsd.GM_ACC_AcceptedTaxonID,
        gsd.GM_ACC_SuperFamily,
        col.SuperFamily,
        gsd.GM_ACC_Family,
        col.Family,
        gsd.GM_ACC_Genus,
        col.genus,
        gsd.GM_ACC_SubGenusName,
        col.subgenus,
        gsd.GM_ACC_SpeciesEpithet,
        col.species,
        col.infraspecies,
        gsd.GM_ACC_AuthorString,
        col.author,
        col.sp2000_status_id
      FROM `GM_GSD`.`GM_AcceptedSpecies` AS gsd
      INNER JOIN (SELECT
                      Kingdom,
                      Phylum,
                      Class,
                      Family,
                      SuperFamily,
                      Genus,
                      Subgenus,
                      Species,
                      Infraspecies,
                      Author,
                      SN.database_id,
                      sp2000_status_id
                    FROM `Assembly_Global`.scientific_names AS SN
                      INNER JOIN `Assembly_Global`.families AS rank
                        ON (SN.family_code =
                            rank.family_code)
                    WHERE infraspecies IS NULL) AS col
          ON gsd.GM_ACC_Genus = col.Genus AND gsd.`GM_ACC_SpeciesEpithet` = col.Species
      WHERE ((gsd.GM_ACC_Family IS NULL OR gsd.GM_ACC_Family = '') AND
             (col.Family <> '' AND col.Family IS NOT NULL AND col.Family <> 'Not assigned') OR
             (gsd.GM_ACC_AuthorString IS NULL OR gsd.GM_ACC_AuthorString = '') AND
             (col.author <> '' OR col.author IS NOT NULL)) AND
            database_id = '{{DatabaseID}}' AND col.sp2000_status_id = 1;
