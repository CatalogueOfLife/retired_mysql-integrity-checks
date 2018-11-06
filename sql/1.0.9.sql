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
       'InfraspeciesMarker'
UNION ALL
SELECT '1.0.9 Abberation in infraspecies marker',
       '',
       infra.`GM_ACC_AcceptedTaxonID`,
       `GM_ACC_Order`,
       `GM_ACC_Family`,
       `GM_ACC_Genus`,
       `GM_ACC_SubGenusName`,
       `GM_ACC_SpeciesEpithet`,
       `GM_INFRA_InfraSpeciesEpithet`,
       `GM_INFRA_InfraSpeciesAuthorString`,
       `GM_INFRA_InfraSpeciesMarker`
FROM `GM_GSD`.`GM_AcceptedInfraSpecificTaxa` infra
       INNER JOIN GM_GSD.GM_AcceptedSpecies acc ON acc.GM_ACC_AcceptedTaxonID = infra.GM_INFRA_ParentSpeciesID
WHERE `GM_INFRA_InfraSpeciesMarker` REGEXP '.*[Aa]b.*' OR `GM_INFRA_InfraSpeciesMarker` REGEXP '.*[Aa]berration.*';
