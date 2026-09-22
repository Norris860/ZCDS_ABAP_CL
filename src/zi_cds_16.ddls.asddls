@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Assotiation Filter with Path Expression'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity ZI_CDS_16
  as select from /dmo/travel as Travel
  association [0..*] to I_CurrencyText as _Currency on _Currency.Currency = $projection.Currency // I_Currency
                                                //   and _Currency.Language = $session.system_language

{
  key travel_id     as TravelID,

      @Semantics.amount.currencyCode: 'Currency'
      total_price   as Price,
      currency_code as Currency,
      _Currency[1:Language = $session.system_language ].CurrencyName

}
