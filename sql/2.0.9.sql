SELECT
  'Integrity check',
  'Editorial decision                                     ',
  'AcceptedTaxonID',
  'Genus',
  'SubGenusName',
  'Species',
  'AuthorString'
UNION SELECT
        '2.0.9 Space in synonym subgenus',
        '',
        `GM_SYN_AcceptedTaxonID`,
        `GM_SYN_Genus`,
        `GM_SYN_SubGenusName`,
        `GM_SYN_SpeciesEpithet`,
        `GM_SYN_AuthorString`
      FROM `GM_GSD`.`GM_Synonyms`
      WHERE `GM_SYN_SubGenusName` LIKE '% %';