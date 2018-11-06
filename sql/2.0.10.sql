SELECT
  'Integrity check',
  'Editorial decision                                     ',
  'SynonymID',
  'ParentID',
  'Genus',
  'SubGenus',
  'Species',
  'Author',
  'Infraspecies',
  'InfraspeciesMarker',
  'InfraspeciesAuthor'
UNION SELECT
        '2.0.10 Synonym missing SynonymID or ParentID',
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
      WHERE `GM_SYN_AcceptedTaxonID` IS NULL OR `GM_SYN_AcceptedTaxonID` = ''
         OR `GM_SYN_ID` IS NULL OR `GM_SYN_ID` = '';
