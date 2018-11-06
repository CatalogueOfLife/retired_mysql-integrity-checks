SELECT 'Integrity check',
       'Editorial decision                                     ',
       'SynID',
       'ParentID',
       'Genus',
       'Subgenus',
       'Species',
       'Infraspecies',
       'Author',
       'GSDNameStatus',
       'Sp2000Status',
       'SpeciesURL'
UNION ALL
    (SELECT '5.1.2 GSD duplicates ACC-SYN species (same parent, same authors)',
            '',
            SynID,
            ParentID,
            GM_ACC_Genus,
            GM_ACC_SubGenusName,
            GM_ACC_SpeciesEpithet,
            InfraSpecies,
            GM_ACC_AuthorString,
            GM_ACC_GSDNameStatus,
            GM_ACC_Sp2000NameStatus,
            GM_ACC_SpeciesURL
     FROM (SELECT NULL AS SynID,
                  acc.GM_ACC_AcceptedTaxonID AS ParentID,
                  GM_ACC_Genus,
                  GM_ACC_SubGenusName,
                  GM_ACC_SpeciesEpithet,
                  NULL                       AS InfraSpecies,
                  GM_ACC_AuthorString,
                  GM_ACC_GSDNameStatus,
                  GM_ACC_Sp2000NameStatus,
                  GM_ACC_SpeciesURL
           FROM (SELECT concat_ws("_", acc.GM_ACC_Genus, acc.GM_ACC_SubGenusName, acc.GM_ACC_SpeciesEpithet,
                                  acc.GM_ACC_AuthorString) AS DupString
                 FROM GM_GSD.GM_AcceptedSpecies acc
                        INNER JOIN GM_GSD.GM_Synonyms syn ON acc.GM_ACC_Genus = syn.GM_SYN_Genus AND
                                                             acc.GM_ACC_SpeciesEpithet = syn.GM_SYN_SpeciesEpithet AND
                                                             (((syn.GM_SYN_SubGenusName IS NULL OR syn.GM_SYN_SubGenusName = '')
                                                                 AND
                                                               (acc.GM_ACC_SubGenusName IS NULL OR acc.GM_ACC_SubGenusName = ''))
                                                                OR
                                                              syn.GM_SYN_SubGenusName = acc.GM_ACC_SubGenusName) AND
                                                             syn.GM_SYN_AuthorString = acc.GM_ACC_AuthorString AND
                                                             syn.GM_SYN_AcceptedTaxonID = acc.GM_ACC_AcceptedTaxonID
                 WHERE syn.GM_SYN_InfraSpecies IS NULL
                    OR syn.GM_SYN_InfraSpecies = ''

                 GROUP BY acc.GM_ACC_Genus, acc.GM_ACC_SubGenusName, acc.GM_ACC_SpeciesEpithet,
                          acc.GM_ACC_AuthorString) dups
                  INNER JOIN GM_GSD.GM_AcceptedSpecies acc
                    ON concat_ws("_", acc.GM_ACC_Genus, acc.GM_ACC_SubGenusName, acc.GM_ACC_SpeciesEpithet,
                                 acc.GM_ACC_AuthorString) = dups.DupString
           UNION ALL
           SELECT GM_SYN_ID                  AS SynID,
                  syn.GM_SYN_AcceptedTaxonID AS ParentID,
                  GM_SYN_Genus,
                  GM_SYN_SubGenusName,
                  GM_SYN_SpeciesEpithet,
                  GM_SYN_InfraSpecies,
                  GM_SYN_AuthorString,
                  GM_SYN_GSDNameStatus,
                  GM_SYN_Sp2000NameStatus,
                  ''
           FROM (SELECT concat_ws("_", syn.GM_SYN_Genus, syn.GM_SYN_SubGenusName, syn.GM_SYN_SpeciesEpithet,
                                  syn.GM_SYN_AuthorString) AS DupString
                 FROM GM_GSD.GM_AcceptedSpecies acc
                        INNER JOIN GM_GSD.GM_Synonyms syn ON acc.GM_ACC_Genus = syn.GM_SYN_Genus AND
                                                             acc.GM_ACC_SpeciesEpithet = syn.GM_SYN_SpeciesEpithet AND
                                                             (((syn.GM_SYN_SubGenusName IS NULL OR syn.GM_SYN_SubGenusName = '')
                                                                 AND
                                                               (acc.GM_ACC_SubGenusName IS NULL OR acc.GM_ACC_SubGenusName = ''))
                                                                OR
                                                              syn.GM_SYN_SubGenusName = acc.GM_ACC_SubGenusName) AND
                                                             syn.GM_SYN_AuthorString = acc.GM_ACC_AuthorString AND
                                                             syn.GM_SYN_AcceptedTaxonID = acc.GM_ACC_AcceptedTaxonID
                 WHERE syn.GM_SYN_InfraSpecies IS NULL
                    OR syn.GM_SYN_InfraSpecies = ''

                 GROUP BY acc.GM_ACC_Genus, acc.GM_ACC_SubGenusName, acc.GM_ACC_SpeciesEpithet,
                          acc.GM_ACC_AuthorString) dups
                  INNER JOIN GM_GSD.GM_Synonyms syn
                    ON concat_ws("_", syn.GM_SYN_Genus, syn.GM_SYN_SubGenusName, syn.GM_SYN_SpeciesEpithet,
                                 syn.GM_SYN_AuthorString) = dups.DupString
           WHERE GM_SYN_InfraSpecies IS NULL
              OR GM_SYN_InfraSpecies = '') u
     ORDER BY GM_ACC_Genus, GM_ACC_SubGenusName, GM_ACC_SpeciesEpithet, GM_ACC_AuthorString);
