@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Association with Parameters'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #A,
    sizeCategory: #S,
    dataClass: #MASTER
}

define view entity ZI_CDS_14
  with parameters
    pCountryCode : land1
  as select from /dmo/travel

  association [1..1] to ZI_CDS_13 as _Agency on _Agency.AgencyId = $projection.AgencyID
{
  key travel_id                                              as TravelID,
      agency_id                                              as AgencyID,
      _Agency(pCountryCode : $parameters.pCountryCode)[City = 'Chicago'].Name as AgencyName
}
