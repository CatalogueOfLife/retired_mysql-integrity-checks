SELECT
  'Integrity check',
  'Editorial decision                                     ',
  'AcceptedTaxonID',
  'Order',
  'SuperFamily*',
  'Family',
  'Genus',
  'SubgenusName*',
  'Species',
  'AuthorString'
UNION SELECT
        '1.0.0 Missing genus or species epithet',
        '',
        `GM_ACC_AcceptedTaxonID`,
        `GM_ACC_Order`,
        `GM_ACC_SuperFamily`,
        `GM_ACC_Family`,
        `GM_ACC_Genus`,
        `GM_ACC_SubGenusName`,
        `GM_ACC_SpeciesEpithet`,
        `GM_ACC_AuthorString`
      FROM `GM_GSD`.`GM_AcceptedSpecies`
      WHERE (`GM_ACC_Genus` = '' OR `GM_ACC_Genus` IS NULL) OR
            (`GM_ACC_SpeciesEpithet` = '' OR `GM_ACC_SpeciesEpithet` IS NULL);