SELECT 'Integrity check',
       'Editorial decision                                     ',
       'AcceptedTaxonID',
       'Family',
       'Genus',
       'SubGenusName',
       'Species',
       'AuthorString'
UNION
SELECT '3.0.2 Non-standard value in species',
       '',
       `GM_ACC_AcceptedTaxonID`,
       `GM_ACC_Family`,
       `GM_ACC_Genus`,
       `GM_ACC_SubGenusName`,
       `GM_ACC_SpeciesEpithet`,
       `GM_ACC_AuthorString`
FROM `GM_GSD`.`GM_AcceptedSpecies`
WHERE `GM_ACC_SpeciesEpithet` LIKE '%[@]%'
   OR `GM_ACC_SpeciesEpithet` LIKE '%[%]%'
   OR `GM_ACC_SpeciesEpithet` LIKE '%[Vv]ar\.%'
   OR `GM_ACC_SpeciesEpithet` LIKE '%[0-9]%'
   OR `GM_ACC_SpeciesEpithet` LIKE '%[Uu]nknown%'
   OR `GM_ACC_SpeciesEpithet` LIKE '%[?]%';