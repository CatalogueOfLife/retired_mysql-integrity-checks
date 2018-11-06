SELECT
  'Integrity check',
  'Editorial decision                                     ',
  'AcceptedTaxonID',
  'InfraspeciesEpithet',
  'InfraSpeciesAuthorString'
UNION SELECT
        '2.0.7 Infraspecies space in infraspecies',
        '',
        `GM_INFRA_AcceptedTaxonID`,
        `GM_INFRA_InfraSpeciesEpithet`,
        `GM_INFRA_InfraSpeciesAuthorString`
      FROM `GM_GSD`.`GM_AcceptedInfraSpecificTaxa`
      WHERE `GM_INFRA_InfraSpeciesEpithet` LIKE '% %';
