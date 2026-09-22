@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Association'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #A,
    sizeCategory: #S,
    dataClass: #MASTER
}

define view entity ZI_CDS_15
  as select from /dmo/travel as Travel

  association [1..1] to /dmo/customer as _Customer on _Customer.customer_id = $projection.CustomerID // Travel.customer_id
  association [1..1] to /dmo/agency   as _Agency   on _Agency.agency_id = $projection.AgencyID
  association [0..*] to /dmo/booking  as _Booking  on _Booking.travel_id = $projection.TravelID

{

  key Travel.travel_id   as TravelID,
      Travel.customer_id as CustomerID,
      Travel.agency_id   as AgencyID,
      
      _Customer,
      _Agency,
      _Booking
}
