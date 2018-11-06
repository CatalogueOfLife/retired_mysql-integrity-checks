SELECT
  'Integrity check',
  'Editorial decision                                     ',
  'Family'
UNION ALL
SELECT '2.0.2 Space in family',
       '',
       GM_ACC_Family
FROM GM_GSD.GM_AcceptedSpecies
WHERE GM_ACC_Family LIKE '% %' GROUP BY GM_ACC_Family;
