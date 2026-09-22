@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Quantity Conversion'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #B,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity ZI_CDS_09
  with parameters
    pFromUnit : abap.unit(3),
    pToUnit   : abap.unit(3)

  as select from zqty_lgl
{
  key product                                              as ProductID,

      @Semantics.quantity.unitOfMeasure: 'OriginalUnit'
      quantity                                             as OriginalQty,
      unit                                                 as OriginalUnit,

      @Semantics.quantity.unitOfMeasure: 'ConvertedUnit'
      unit_conversion( quantity       => quantity,
                       source_unit    =>  $parameters.pFromUnit,     // unit,
                       target_unit    =>  $parameters.pToUnit,       // abap.unit'MI',
                       error_handling => 'SET_TO_NULL',
                       client         => $session.client ) as ConvertedQty,
      abap.unit'MI'                                        as ConvertedUnit


}
where
  unit = $parameters.pFromUnit;
