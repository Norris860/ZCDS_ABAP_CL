@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Association-Nav. with Path Expression I'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #A,
    sizeCategory: #S,
    dataClass: #MASTER
}

define view entity ZI_CDS_18
  as select from /dmo/travel as Travel

  association [1..1] to /dmo/customer as _Customer on _Customer.customer_id = $projection.CustomerID // Travel.customer_id
  association [1..1] to /dmo/agency   as _agency   on _agency.agency_id = $projection.AgencyID
{

  key Travel.travel_id   as TravelID,
      Travel.customer_id as CustomerID,
      Travel.agency_id   as AgencyID,

      _Customer,
      _agency

}
