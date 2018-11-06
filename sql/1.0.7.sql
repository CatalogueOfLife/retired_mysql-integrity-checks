SELECT 'Integrity check',
       'Editorial decision                                     ',
       'SynonymID',
       'ParentID',
       'Genus',
       'Subgenus*',
       'Species',
       'AuthorString',
       'ParentGenus',
       'ParentSubgenus',
       'ParentSpecies',
       'ParentAuthor'
UNION
SELECT '1.0.7 Sensu in synonym author string',
       '',
       GM_SYN_ID AS SynID,
       GM_SYN_AcceptedTaxonID AS ParentID,
       syn.GM_SYN_Genus,
       syn.GM_SYN_SubGenusName,
       syn.GM_SYN_SpeciesEpithet,
       syn.GM_SYN_AuthorString,
       acc.GM_ACC_Genus AS ParentGenus,
       acc.GM_ACC_SubGenusName AS ParentSubgenus,
       acc.GM_ACC_SpeciesEpithet AS ParentSpecies,
       acc.GM_ACC_AuthorString AS ParentAuthor
FROM `GM_GSD`.`GM_Synonyms` syn
       INNER JOIN GM_GSD.GM_AcceptedSpecies acc ON syn.GM_SYN_AcceptedTaxonID = acc.GM_ACC_AcceptedTaxonID
WHERE syn.GM_SYN_AuthorString LIKE '%sensu%';
