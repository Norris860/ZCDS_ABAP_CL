@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cube'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Analytics.dataCategory: #CUBE
define view entity ZI_CDS_31
  as select from zso_tnd as Sales_Orders
  
  association [0..1] to ZI_CDS_30 as _Currency on _Currency.Currency = $projection.CurrencySum
  
{
  key Sales_Orders.so_key           as SoKey,
       
      Sales_Orders.lifecycle_status as LifecycleStatus,
      
      @DefaultAggregation : #SUM
      @Semantics.amount.currencyCode: 'CurrencySum'
      Sales_Orders.amount_sum       as AmountSum,
      company_code     as CompanyCode,
      
      @ObjectModel.foreignKey.association: '_Currency'
      currency_sum     as CurrencySum,

//      created_at       as CreatedAt,
//      buyer_id         as BuyerId,
//      ship_to_id       as ShipToId,
      
      @DefaultAggregation : #SUM
      @Semantics.quantity.unitOfMeasure: 'UomSum'
      quantity_sum     as QuantitySum,
      uom_sum          as UomSum,    
      
      @DefaultAggregation: #NONE
      created_by       as CreatedBy,
      
      @DefaultAggregation: #NONE
      created_on       as CreatedOn,
      
      _Currency
}
