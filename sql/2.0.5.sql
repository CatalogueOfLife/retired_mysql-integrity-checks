SELECT
  'Integrity check',
  'Editorial decision                                     ',
  'AcceptedTaxonID',
  'InfraspeciesEpithet',
  'InfraSpeciesAuthorString'
UNION SELECT
        '2.0.5 Infraspecies missing ID',
        '',
        `GM_INFRA_AcceptedTaxonID`,
        `GM_INFRA_InfraSpeciesEpithet`,
        `GM_INFRA_InfraSpeciesAuthorString`
      FROM `GM_GSD`.`GM_AcceptedInfraSpecificTaxa`
      WHERE `GM_INFRA_AcceptedTaxonID` IS NULL OR `GM_INFRA_AcceptedTaxonID` = '';
