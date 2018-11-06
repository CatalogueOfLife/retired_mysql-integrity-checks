SELECT 'Integrity check',
       'Editorial decision                                     ',
       'SynID',
       'ParentID',
       'Genus',
       'Subgenus',
       'Species',
       'Infraspecies',
       'InfraMarker',
       'InfraAuthor',
       'GSDNameStatus',
       'Sp2000Status'
UNION ALL
    (SELECT '5.1.3 GSD duplicates ACC-SYN infraspecies (different parent, different authors)',
            '',
            SynID,
            ParentID,
            GM_SYN_Genus,
            GM_SYN_SubGenusName,
            GM_SYN_SpeciesEpithet,
            GM_SYN_InfraSpecies,
            GM_SYN_InfraSpeciesMarker,
            GM_SYN_InfraSpeciesAuthorString,
            GM_SYN_GSDNameStatus,
            GM_SYN_Sp2000NameStatus
     FROM (SELECT GM_SYN_ID              AS SynID,
                  GM_SYN_AcceptedTaxonID AS ParentID,
                  GM_SYN_Genus,
                  GM_SYN_SubGenusName,
                  GM_SYN_SpeciesEpithet,
                  GM_SYN_InfraSpecies,
                  GM_SYN_InfraSpeciesMarker,
                  GM_SYN_InfraSpeciesAuthorString,
                  GM_SYN_GSDNameStatus,
                  GM_SYN_Sp2000NameStatus
           FROM (SELECT concat_ws("_", syn.GM_SYN_Genus, syn.GM_SYN_SubGenusName, syn.GM_SYN_SpeciesEpithet,
                                  syn.GM_SYN_InfraSpecies) AS DupString
                 FROM GM_GSD.GM_AcceptedInfraSpecificTaxa infra
                        INNER JOIN GM_GSD.GM_AcceptedSpecies acc
                          ON infra.GM_INFRA_ParentSpeciesID = acc.GM_ACC_AcceptedTaxonID
                        INNER JOIN GM_GSD.GM_Synonyms syn ON syn.GM_SYN_Genus = acc.GM_ACC_Genus AND
                                                             syn.GM_SYN_SpeciesEpithet = acc.GM_ACC_SpeciesEpithet AND
                                                             syn.GM_SYN_InfraSpecies = infra.GM_INFRA_InfraSpeciesEpithet AND
                                                             (((syn.GM_SYN_SubGenusName IS NULL OR syn.GM_SYN_SubGenusName = '')
                                                                 AND
                                                               (acc.GM_ACC_SubGenusName IS NULL OR acc.GM_ACC_SubGenusName = ''))
                                                                OR
                                                              syn.GM_SYN_SubGenusName = acc.GM_ACC_SubGenusName) AND
                                                             infra.GM_INFRA_AcceptedTaxonID <> syn.GM_SYN_AcceptedTaxonID AND
                                                             infra.GM_INFRA_InfraSpeciesAuthorString <>
                                                             syn.GM_SYN_InfraSpeciesAuthorString AND
                                                             infra.GM_INFRA_InfraSpeciesAuthorString =
                                                             syn.GM_SYN_InfraSpeciesAuthorString AND
                                                             (((syn.GM_SYN_InfraSpeciesMarker IS NULL OR
                                                                syn.GM_SYN_InfraSpeciesMarker = '') AND
                                                               (infra.GM_INFRA_InfraSpeciesMarker IS NULL OR
                                                                infra.GM_INFRA_InfraSpeciesMarker = '')) OR
                                                              syn.GM_SYN_InfraSpeciesMarker = infra.GM_INFRA_InfraSpeciesMarker)
                 GROUP BY syn.GM_SYN_Genus, syn.GM_SYN_SubGenusName, syn.GM_SYN_SpeciesEpithet,
                          infra.GM_INFRA_InfraSpeciesEpithet) dups
                  INNER JOIN GM_GSD.GM_Synonyms syn
                    ON dups.DupString = concat_ws("_", GM_SYN_Genus, GM_SYN_SubGenusName,
                                                  GM_SYN_SpeciesEpithet, GM_SYN_InfraSpecies)
           UNION ALL
           SELECT NULL AS GM_SYN_SynID,
                  infra.GM_INFRA_AcceptedTaxonID AS ParentID,
                  acc.GM_ACC_Genus,
                  GM_ACC_SubGenusName,
                  acc.GM_ACC_SpeciesEpithet,
                  infra.GM_INFRA_InfraSpeciesEpithet,
                  infra.GM_INFRA_InfraSpeciesMarker,
                  infra.GM_INFRA_InfraSpeciesAuthorString,
                  infra.GM_INFRA_GSDNameStatus,
                  infra.GM_INFRA_Sp2000NameStatus
           FROM (SELECT concat_ws("_", acc.GM_ACC_Genus, acc.GM_ACC_SubGenusName, acc.GM_ACC_SpeciesEpithet,
                                  GM_INFRA_InfraSpeciesEpithet) AS DupString,
                        acc.GM_ACC_Genus,
                        acc.GM_ACC_SpeciesEpithet,
                        GM_INFRA_InfraSpeciesEpithet
                 FROM GM_GSD.GM_AcceptedInfraSpecificTaxa infra
                        INNER JOIN GM_GSD.GM_AcceptedSpecies acc
                          ON infra.GM_INFRA_ParentSpeciesID = acc.GM_ACC_AcceptedTaxonID
                        INNER JOIN GM_GSD.GM_Synonyms syn ON syn.GM_SYN_Genus = acc.GM_ACC_Genus AND
                                                             syn.GM_SYN_SpeciesEpithet = acc.GM_ACC_SpeciesEpithet AND
                                                             syn.GM_SYN_InfraSpecies = infra.GM_INFRA_InfraSpeciesEpithet AND
                                                             (((syn.GM_SYN_SubGenusName IS NULL OR syn.GM_SYN_SubGenusName = '')
                                                                 AND
                                                               (acc.GM_ACC_SubGenusName IS NULL OR acc.GM_ACC_SubGenusName = ''))
                                                                OR
                                                              syn.GM_SYN_SubGenusName = acc.GM_ACC_SubGenusName) AND
                                                             infra.GM_ACC_AcceptedTaxonID <> syn.GM_SYN_AcceptedTaxonID AND
                                                             infra.GM_INFRA_InfraSpeciesAuthorString <> syn.GM_SYN_AuthorString AND
                                                             infra.GM_INFRA_InfraSpeciesAuthorString = syn.GM_SYN_AuthorString AND
                                                             (((syn.GM_SYN_InfraSpeciesMarker IS NULL OR
                                                                syn.GM_SYN_InfraSpeciesMarker = '') AND
                                                               (infra.GM_INFRA_InfraSpeciesMarker IS NULL OR
                                                                infra.GM_INFRA_InfraSpeciesMarker = '')) OR
                                                              syn.GM_SYN_InfraSpeciesMarker = infra.GM_INFRA_InfraSpeciesMarker)
                 GROUP BY acc.GM_ACC_Genus, acc.GM_ACC_SubGenusName, acc.GM_ACC_SpeciesEpithet,
                          infra.GM_INFRA_InfraSpeciesEpithet) dups
                  INNER JOIN GM_GSD.GM_AcceptedSpecies acc ON dups.DupString =
                                                              concat_ws("_", acc.GM_ACC_Genus,
                                                                        acc.GM_ACC_SubGenusName,
                                                                        acc.GM_ACC_SpeciesEpithet,
                                                                        dups.GM_INFRA_InfraSpeciesEpithet)
                  INNER JOIN GM_GSD.GM_AcceptedInfraSpecificTaxa infra
                    ON acc.GM_ACC_AcceptedTaxonID = infra.GM_INFRA_ParentSpeciesID
           WHERE acc.GM_ACC_Genus = dups.GM_ACC_Genus
             AND acc.GM_ACC_SpeciesEpithet = dups.GM_ACC_SpeciesEpithet
             AND infra.GM_INFRA_InfraSpeciesEpithet = dups.GM_INFRA_InfraSpeciesEpithet) u
     ORDER BY GM_SYN_Genus, GM_SYN_SubGenusName, GM_SYN_SpeciesEpithet, GM_SYN_InfraSpecies,
              GM_SYN_InfraSpeciesAuthorString);
