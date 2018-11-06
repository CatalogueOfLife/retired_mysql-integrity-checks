SELECT
  'Integrity check',
  'Editorial decision                                     ',
  'SynonymID',
  'ParentID',
  'Genus',
  'Subgenus',
  'Species',
  'Author',
  'Infraspecies',
  'InfraspeciesMarker',
  'InfraspeciesAuthor'
UNION SELECT
        '2.0.13 Space in synonym species epithet',
        '',
        `GM_SYN_ID` AS SynonymID,
        `GM_SYN_AcceptedTaxonID` AS ParentID,
        GM_SYN_Genus,
        GM_SYN_SubGenusName,
        GM_SYN_SpeciesEpithet,
        GM_SYN_AuthorString,
        GM_SYN_InfraSpecies,
        GM_SYN_InfraSpeciesMarker,
        GM_SYN_InfraSpeciesAuthorString
      FROM `GM_GSD`.`GM_Synonyms`
      WHERE `GM_SYN_SpeciesEpithet` LIKE '% %';
