SELECT
  'Integrity check',
  'Editorial decision                                     ',
  'AcceptedTaxonID',
  'Genus',
  'Subgenus*',
  'Species',
  'Authors',
  'GSDNameStatus',
  'Sp2000Status',
  'SpeciesURL'
UNION ALL
    (SELECT '5.0.0 GSD duplicates ACC-ACC species (different authors)',
        '',
       GM_ACC_AcceptedTaxonID,
       GM_ACC_Genus,
       GM_ACC_SubGenusName,
       GM_ACC_SpeciesEpithet,
       GM_ACC_AuthorString,
       GM_ACC_GSDNameStatus,
       GM_ACC_Sp2000NameStatus,
       GM_ACC_SpeciesURL
FROM GM_GSD.GM_AcceptedSpecies acc
       INNER JOIN (SELECT concat_ws("_", tb1.GM_ACC_Genus, tb1.GM_ACC_SpeciesEpithet) AS DupString
                   FROM GM_GSD.GM_AcceptedSpecies tb1
                          INNER JOIN GM_GSD.GM_AcceptedSpecies tb2 ON tb1.GM_ACC_Genus = tb2.GM_ACC_Genus AND
                                                                      tb1.GM_ACC_SpeciesEpithet = tb2.GM_ACC_SpeciesEpithet AND
                                                                      tb1.GM_ACC_AuthorString <> tb2.GM_ACC_AuthorString
                   GROUP BY tb1.GM_ACC_Genus, tb1.GM_ACC_SpeciesEpithet
                   HAVING count(*) > 1) dups
         ON dups.DupString = concat_ws("_", acc.GM_ACC_Genus, acc.GM_ACC_SpeciesEpithet)
ORDER BY GM_ACC_Genus, GM_ACC_SpeciesEpithet, GM_ACC_SubGenusName, GM_ACC_AuthorString);
