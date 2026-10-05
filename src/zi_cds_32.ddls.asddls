@AccessControl.authorizationCheck: #NOT_ALLOWED
@EndUserText.label: 'Transient Analytical Query'
@Metadata.ignorePropagatedAnnotations: true
define transient view entity ZI_CDS_32
  provider contract analytical_query
  as projection on ZI_CDS_31
{
          @AnalyticsDetails.query.axis: #FREE
          SoKey                                                          as SalesOrderKey,

          @AnalyticsDetails.query.axis: #ROWS
          LifecycleStatus,

          @AnalyticsDetails.query.axis: #COLUMNS
          @Semantics.quantity.unitOfMeasure: 'UomSum' // agregué por mi cuenta esta instrucción...

          QuantitySum,
          UomSum,

          @ObjectModel.text.element: ['CurrencyDescription']
          CurrencySum,
          _Currency._Text.CurrencyName                                   as CurrencyDescription : localized,

          @Aggregation.default: #FORMULA
          abap.decfloat34'0.5'                                           as Discount,

          @Aggregation.default: #FORMULA
          @Semantics.quantity.unitOfMeasure: 'AmPerQuanUnit'
          curr_to_decfloat_amount( AmountSum ) / $projection.quantitysum as AmountPerQuantity,

          //      CompanyCode,

  virtual AmPerQuanUnit : dd_cds_calculated_unit,
  
          @Aggregation.default: #FORMULA
          @Semantics.amount.currencyCode: 'TargetCurrency'
          currency_conversion( amount             => curr_to_decfloat_amount( AmountSum ), 
                               source_currency    => CurrencySum, 
                               target_currency    => abap.cuky'EUR', 
                               exchange_rate_date => CreatedOn ) as ConvertedAmount,
                               
  virtual TargetCurrency : abap.cuky 
  

//          CreatedBy,
//          CreatedOn,
//          /* Associations */
//          _Currency
}
