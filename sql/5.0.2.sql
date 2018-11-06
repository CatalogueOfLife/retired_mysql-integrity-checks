SELECT 'Integrity check',
       'Editorial decision                                     ',
       'InfraID',
       'ParentID',
       'Genus',
       'Subgenus*',
       'Species',
       'Infraspecies',
       'InfraMarker',
       'InfraAuthors',
       'GSDNameStatus',
       'Sp2000Status'
UNION ALL
    (SELECT '5.0.2 GSD duplicates ACC-ACC infraspecies (different authors)',
            '',
            infra.GM_INFRA_AcceptedTaxonID AS InfraID,
            infra.GM_INFRA_ParentSpeciesID AS ParentID,
            GM_ACC_Genus,
            GM_ACC_SubGenusName,
            GM_ACC_SpeciesEpithet,
            GM_INFRA_InfraSpeciesEpithet,
            GM_INFRA_InfraSpeciesMarker,
            GM_INFRA_InfraSpeciesAuthorString,
            infra.GM_INFRA_GSDNameStatus,
            infra.GM_INFRA_Sp2000NameStatus
     FROM GM_GSD.GM_AcceptedSpecies acc
            INNER JOIN GM_GSD.GM_AcceptedInfraSpecificTaxa infra
              ON infra.GM_INFRA_ParentSpeciesID = acc.GM_ACC_AcceptedTaxonID
            INNER JOIN (SELECT concat_ws("_", tb1.GM_ACC_Genus, tb1.GM_ACC_SpeciesEpithet,
                                         infra.GM_INFRA_InfraSpeciesEpithet) AS DupString
                        FROM GM_GSD.GM_AcceptedSpecies tb1
                               INNER JOIN GM_GSD.GM_AcceptedInfraSpecificTaxa infra
                                 ON infra.GM_INFRA_ParentSpeciesID = tb1.GM_ACC_AcceptedTaxonID
                               INNER JOIN GM_GSD.GM_AcceptedSpecies tb2 ON tb1.GM_ACC_Genus = tb2.GM_ACC_Genus AND
                                                                           tb1.GM_ACC_SpeciesEpithet = tb2.GM_ACC_SpeciesEpithet
                        GROUP BY tb1.GM_ACC_Genus, tb1.GM_ACC_SpeciesEpithet, infra.GM_INFRA_InfraSpeciesEpithet
                        HAVING count(*) > 1) dups ON dups.DupString =
                                                     concat_ws("_", acc.GM_ACC_Genus, acc.GM_ACC_SpeciesEpithet,
                                                               infra.GM_INFRA_InfraSpeciesEpithet)
     ORDER BY GM_ACC_Genus, GM_ACC_SpeciesEpithet, GM_INFRA_InfraSpeciesEpithet, GM_INFRA_InfraSpeciesMarker,
              GM_ACC_SubGenusName, GM_INFRA_InfraSpeciesAuthorString);
