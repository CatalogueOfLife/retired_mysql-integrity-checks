SELECT 'Integrity check',
       'Editorial decision                                     ',
       'AcceptedTaxonID',
       'Order*',
       'Family*',
       'Genus',
       'SubGenusName*',
       'Species',
       'Infraspecies',
       'InfraspeciesAuthorString'
UNION
SELECT '1.0.8 Sensu in infraspecies author string',
       '',
       infra.`GM_ACC_AcceptedTaxonID`,
       `GM_ACC_Order`,
       `GM_ACC_Family`,
       `GM_ACC_Genus`,
       `GM_ACC_SubGenusName`,
       `GM_ACC_SpeciesEpithet`,
       `GM_INFRA_InfraSpeciesEpithet`,
       `GM_INFRA_InfraSpeciesAuthorString`
FROM `GM_GSD`.`GM_AcceptedInfraSpecificTaxa` infra
       INNER JOIN GM_GSD.GM_AcceptedSpecies acc ON acc.GM_ACC_AcceptedTaxonID = infra.GM_INFRA_ParentSpeciesID
WHERE `GM_INFRA_InfraSpeciesAuthorString` LIKE '%sensu%';
