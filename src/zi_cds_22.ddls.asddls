@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck:#NOT_REQUIRED
@EndUserText.label: 'CDS for Hierarchy'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #A,
    sizeCategory: #S,
    dataClass: #MASTER
}

define view entity ZI_CDS_22
  as select from zemployee_lgl
  association [0..1] to ZI_CDS_22 as _Manager on _Manager.Employee = $projection.Manager
{
  key employee as Employee,
      manager  as Manager,
      name     as Name, 
      
      _Manager
}
