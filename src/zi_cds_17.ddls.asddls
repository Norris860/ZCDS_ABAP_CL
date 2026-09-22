@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Association'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #A,
    sizeCategory: #S,
    dataClass: #MASTER
}

define view entity ZI_CDS_17
  as select from /dmo/travel as Travel

  association [1..1] to /dmo/customer as _Customer on _Customer.customer_id = $projection.CustomerID // Travel.customer_id
  association [1..1] to /dmo/agency   as _agency   on _agency.agency_id = $projection.AgencyID
{

  key Travel.travel_id                                                  as TravelID,
      Travel.customer_id                                                as CustomerID,
      concat_with_space( _Customer[inner].first_name, _Customer[inner].last_name, 2 ) as CustomerName,
      Travel.agency_id                                                  as AgencyID,
      _agency[inner].name                                                      as AgencyName
}
