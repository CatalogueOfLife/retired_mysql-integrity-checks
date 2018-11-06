SELECT
  'Integrity check',
  'Editorial decision                                     ',
  'AcceptedTaxonID',
  'Order',
  'SuperFamily*',
  'Family+',
  'Genus',
  'SubgenusName*',
  'Species',
  'AuthorString'
UNION ALL
SELECT
        '1.0.1 Missing hierarchy data',
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
      WHERE `GM_ACC_Order` IS NULL OR `GM_ACC_Order` = ''
                                   OR `GM_ACC_Family` IS NULL
                                   OR `GM_ACC_Family` = '';
