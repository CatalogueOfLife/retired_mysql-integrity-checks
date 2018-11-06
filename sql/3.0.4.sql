SELECT 'Integrity check',
       'Editorial decision                                     ',
       'AcceptedTaxonID',
       'InfraspeciesEpithet',
       'InfraSpeciesAuthorString'
UNION
SELECT '3.0.4 Non-standard value in infraspecies',
       '',
       `GM_INFRA_AcceptedTaxonID`,
       `GM_INFRA_InfraSpeciesEpithet`,
       `GM_INFRA_InfraSpeciesAuthorString`
FROM `GM_GSD`.`GM_AcceptedInfraSpecificTaxa`
WHERE `GM_INFRA_InfraSpeciesEpithet` LIKE '%[@]%'
   OR `GM_INFRA_InfraSpeciesEpithet` LIKE '%[%]%'
   OR `GM_INFRA_InfraSpeciesEpithet` LIKE '%[Vv]ar\.%'
   OR GM_INFRA_InfraSpeciesEpithet LIKE '%[0-9]%'
   OR `GM_INFRA_InfraSpeciesEpithet` LIKE '%[Uu]nknown%'
   OR `GM_INFRA_InfraSpeciesEpithet` LIKE '%[?]%';
