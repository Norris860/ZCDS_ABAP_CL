@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Amount Conversion'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #B,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity ZI_CDS_08
  with parameters pFromCurrency : abap.cuky,
                  pToCurrency : abap.cuky 
                  
//                  @Environment.systemField: #SYSTEM_DATE
//                  pDocumentDate : abap.dats

  as select from /dmo/travel
{
  key travel_id                                                  as TravelID,

      @Semantics.amount.currencyCode: 'OriginalCurrency'
      total_price                                                as OriginalPrice,
      currency_code                                              as OriginalCurrency,

      @Semantics.amount.currencyCode: 'ConvertedCurrency'
      currency_conversion( amount             => total_price,
                           source_currency    => $parameters.pFromCurrency,   // currency_code,
                           target_currency    => $parameters.pToCurrency,  // abap.cuky'USD',      //cast( 'USD'  as abap.cuky ),
                           exchange_rate_date => begin_date,
                           client             => $session.client,
                           error_handling     => 'SET_TO_NULL' ) as ConvertedPrice,
                           $parameters.pToCurrency               as ConvertedCurrency      // cast( 'USD' as abap.cuky )                                 as ConvertedCurrency

}
where
  currency_code = $parameters.pFromCurrency;   // 'EUR';
