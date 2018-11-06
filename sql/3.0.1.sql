SELECT 'Integrity check',
       'Editorial decision                                     ',
       'AcceptedTaxonID',
       'Family',
       'Genus',
       'SubGenusName',
       'Species',
       'AuthorString'
UNION
SELECT '3.0.1 Non-standard value in subgenus',
       '',
       `GM_ACC_AcceptedTaxonID`,
       `GM_ACC_Family`,
       `GM_ACC_Genus`,
       `GM_ACC_SubGenusName`,
       `GM_ACC_SpeciesEpithet`,
       `GM_ACC_AuthorString`
FROM `GM_GSD`.`GM_AcceptedSpecies`
WHERE `GM_ACC_SubGenusName` LIKE '%[@]%'
   OR `GM_ACC_SubGenusName` LIKE '%[%]%'
   OR `GM_ACC_SubGenusName` LIKE '%[Vv]ar\.%'
   OR `GM_ACC_SubGenusName` LIKE '%[0-9]%'
   OR `GM_ACC_SubGenusName` LIKE '%[Uu]nknown%'
   OR `GM_ACC_SubGenusName` LIKE '%[?]%';
