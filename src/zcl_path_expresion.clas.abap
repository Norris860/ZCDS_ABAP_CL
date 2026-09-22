CLASS zcl_path_expresion DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_path_expresion IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

  SELECT From zi_cds_19 AS Booking
         Fields Booking~TravelID,
                Booking~BookingID,
                \_Travel-AgencyID,
                \_Travel\_agency-name As AgencyName,
                \_Travel\_Customer-Customer_Id as CustomerID,
                concat_with_space( \_Travel\_Customer-first_name, \_Travel\_Customer-last_name, 1 ) as Customername
       Where Booking~CarrierID EQ 'AA'
       Into Table @data(It_Results)
       UP to 5 rows.

   if syst-subrc = 0.
     out->write( It_Results ).
   endif.

  ENDMETHOD.

endclass.
