*"* use this source file for your ABAP unit test classes

class ltc_date deFINITION dEFERRED.
class zcl_date deFINITION locAL FRIENDS LTC_date.

class ltc_date definition final for testing
  duration short
  risk level harmless.

  private section.
    methods:
      first_test for testing raising cx_static_check.
endclass.


class ltc_date implementation.

  method first_test.
  data(date) = zcl_date=>create_from_type_d( '20251228' ).

  cl_abap_unit_assert=>assert_equals( act = date->get_week_day( )
                                      exp = date->week_day_number-sunday ).

  date->add_days( 10 ).
  cl_abap_unit_assert=>assert_equals( act = date->get_date_as_type_d( )
                                      exp = '20260107' ).

  date->subtract_days( 10 ).
  cl_abap_unit_assert=>assert_equals( act = date->get_date_as_type_d( )
                                      exp = '20251228' ).

    " 0004 returns false (it means that 0004/02/29 doesn't exist)
    " 1580 returns false (it means that 1580/02/29 doesn't exist)
    " 1584 returns true  (it means that 1584/02/29 exists)
    " 1600 returns false (it means that 1600/02/29 exists)
    " 1700 returns true  (it means that 1700/02/29 doesn't exist)
    " 2000 returns true  (it means that 2000/02/29 exists)
    " 2024 returns true  (it means that 2024/02/29 exists)
    " 2100 returns false (it means that 2100/02/29 doesn't exist)
  cl_abap_unit_assert=>assert_equals( act = zcl_date=>class_is_leap_year( '0004' )
                                      exp = abap_false ).
  cl_abap_unit_assert=>assert_equals( act = zcl_date=>class_is_leap_year( '1580' )
                                      exp = abap_false ).
  cl_abap_unit_assert=>assert_equals( act = zcl_date=>class_is_leap_year( '1584' )
                                      exp = abap_true ).
  cl_abap_unit_assert=>assert_equals( act = zcl_date=>class_is_leap_year( '1600' )
                                      exp = abap_true ).
  cl_abap_unit_assert=>assert_equals( act = zcl_date=>class_is_leap_year( '1700' )
                                      exp = abap_false ).
  cl_abap_unit_assert=>assert_equals( act = zcl_date=>class_is_leap_year( '2000' )
                                      exp = abap_true ).
  cl_abap_unit_assert=>assert_equals( act = zcl_date=>class_is_leap_year( '2024' )
                                      exp = abap_true ).
  cl_abap_unit_assert=>assert_equals( act = zcl_date=>class_is_leap_year( '2100' )
                                      exp = abap_false ).
  endmethod.

endclass.

*CLASS zcl_date_test DEFINITION FOR TESTING "#AU Risk_Level Harmless
*RISK LEVEL HARMLESS
*DURATION SHORT
*      INHERITING FROM cl_aunit_assert.  "#AU Duration Short
*
*  PUBLIC SECTION.
*    METHODS class_tests1 FOR TESTING.
*    METHODS class_tests2 FOR TESTING.
*    METHODS class_tests3 FOR TESTING.
*ENDCLASS.
*
*
*CLASS zcl_date_test IMPLEMENTATION.
*
*  DEFINE assert2.
*    CASE &2.
*      WHEN '='.
*        cl_aunit_assert=>assert_equals( act = &1
*                                        exp = &3 ).
*        " if not &1 = &3.
*        "   write : / 'ERROR' color 6, 'IN' color 6,
*        "         '. The test', &1, &2, &3, 'is false'.
*        " endif.
*    ENDCASE.
*  END-OF-DEFINITION.
*
*  " ---------------------------------------------------------------------
*  " Cette méthode teste les valeurs sensées être retournées par les
*  " opérations sur les dates SAP (tests du standard sap)
*  " ---------------------------------------------------------------------
*  METHOD class_tests1.
*    DATA date      TYPE d.
*    DATA increment TYPE n LENGTH 20.
*    DATA i         TYPE i.
*
**    WRITE / 'Test 1 simple addition'.
*    date = '00010101'.
*    date = date + 1000.
*    assert2 date '=' '00030928'.
*
**    WRITE / 'Test 2 huge incrementation, result above year 9999'.
*    date = '00010101'.
*    date = date + 2000000000.
*    assert2 date '=' '00000000'.
*
**    WRITE / 'Test 3 increment  4 bytes-signed-integer '
**          & '( 2,5 billions)'.
*    date = '00010101'.
*    TRY.
*        date = date + 2500000000.
*      CATCH cx_sy_arithmetic_overflow.
*        sy-subrc = 1.
*    ENDTRY.
*    cl_aunit_assert=>assert_subrc( act = sy-subrc
*                                   exp = 1 ).
**    assert2 sy-subrc '=' 1.
*    assert2 date '=' '00010101'.
*
**    WRITE / 'Test 4 same as test 3 but using variable as increment'.
*    date = '00010101'.
*    increment = 2500000000.
*    TRY.
*        date = date + increment.
*      CATCH cx_sy_arithmetic_overflow.
*        sy-subrc = 1.
*    ENDTRY.
*    cl_aunit_assert=>assert_subrc( act = sy-subrc
*                                   exp = 1 ).
**    assert2 sy-subrc '=' 1.
*    assert2 date '=' '00010101'.
*
**    WRITE / 'Test 5 add number expressed as character string'.
*    date = '00010101'.
*    date = date + '5'.
*    assert2 date '=' '00010106'.
*
**    WRITE / 'Test 6 add 5 to date zero'.
*    CLEAR date.
*    date = date + '5'.
*    assert2 date '=' '00010106'.
*
**    WRITE / 'Test 7 add 5 to date 00000505'.
*    date = '00000505'.
*    date = date + '5'.
*    assert2 date '=' '00010106'.
*
**    WRITE / 'Test 8 add 5 to date 20070535'.
*    date = '20070535'.
*    date = date + '5'.
*    assert2 date '=' '00010106'.
*
*    " This test shows that in SAP system, 00010101 corresponds to
*    " day number zero (not one).
*    " 00010131 is day #30
*    " 00010302 is day #60
*    "    WRITE / 'Test 9 multiply by 2'.
*    date = '00010131'.
*    date = date * 2.
*    assert2 date '=' '00010302'.
*
**    WRITE / 'Test 10 00010101 + zero - zero!!!'.
*    date = '00010101'.
*    date = date + 0.
*    assert2 date '=' '00000000'.
*
**    WRITE / 'Test 11 00010101'.
*    date = '00010101'.
*    date = date.
*    assert2 date '=' '00010101'.
*
**    WRITE / 'Test 12 00010102 - 1 - zero!!!'.
*    date = '00010102'.
*    date = date - 1.
*    assert2 date '=' '00000000'.
*
**    WRITE / 'Test 13 00010101 + 36524 - 01001231'.
*    date = '00010101'.
*    date = date + 36524.
*    assert2 date '=' '01001231'.
*
**    WRITE / 'Test 14 00010101 + 36525 - 01010101'.
*    date = '00010101'.
*    date = date + 36525.
*    assert2 date '=' '01010101'.
*
** Gregorian tests
**    WRITE / 'Test 15 15821004 + 1 - 15821015'.
*    date = '15821004'.
*    date = date + 1.
*    assert2 date '=' '15821015'.
*
**    WRITE / 'Test 16 15821004 + 0 - 577736'.
*    date = '15821004'.
*    i = date + 0.
*    assert2 i '=' 577736.
*
**    WRITE / 'Test 17 15821015 + 0 - 577737'.
*    date = '15821015'.
*    i = date + 0.
*    assert2 i '=' 577737.
*  ENDMETHOD.
*
*  " ---------------------------------------------------------------------
*  " Cette méthode teste les valeurs sensées être retournées par les
*  " méthodes de la classe DATE
*  " ---------------------------------------------------------------------
*  METHOD class_tests2.
*    DATA l_year           TYPE zcl_date=>type_year.
*    DATA l_day_number     TYPE i.
*    DATA l_date           TYPE zcl_date=>type_date.
*    DATA string           TYPE string.
*    DATA date             TYPE d.
*    DATA x                TYPE REF TO zcl_date.
*    DATA i                TYPE i.
*    DATA i2               TYPE i.
*    DATA j                TYPE i.
*    DATA l_diff_tolerance TYPE i.
*    DATA l_date2          TYPE zcl_date=>type_date.
*    DATA l_year2          TYPE zcl_date=>type_year.
*    DATA date2            TYPE d.
*
*    " -----------------------
*    " Tests de la méthode get_year_from_day_number
*
*    l_year = zcl_date=>class_get_year_from_day_number( 0 ).
*    assert2 l_year '=' 1.
*    l_year = zcl_date=>class_get_year_from_day_number( 364 ).
*    assert2 l_year '=' 1.
*    l_year = zcl_date=>class_get_year_from_day_number( 365 ).
*    assert2 l_year '=' 2.
*    l_year = zcl_date=>class_get_year_from_day_number( 1460 ).
*    assert2 l_year '=' 4.
*    l_year = zcl_date=>class_get_year_from_day_number( 1461 ).
*    assert2 l_year '=' 5.
*    " 1825 = 0005/12/31
*    l_year = zcl_date=>class_get_year_from_day_number( 1825 ).
*    assert2 l_year '=' 5.
*    " 1826 = 0006/01/01
*    l_year = zcl_date=>class_get_year_from_day_number( 1826 ).
*    assert2 l_year '=' 6.
*
*    " -----------------------
*    " Tests de la méthode DATE_2_DAY_NUMBER
*
*    l_day_number = zcl_date=>class_date_2_day_number( '00040401' ).
*    assert2 l_day_number '=' 1186.
*    l_day_number = zcl_date=>class_date_2_day_number( '15821004' ).
*    assert2 l_day_number '=' 577736.
*    l_day_number = zcl_date=>class_date_2_day_number( '15821015' ).
*    assert2 l_day_number '=' 577737.
*
*    " -----------------------
*    " Tests de la méthode DAY_NUMBER_2_DATE
*    l_date = zcl_date=>class_day_number_2_date( 0 ).
*    assert2 l_date '=' '00010101'.
*    l_date = zcl_date=>class_day_number_2_date( 364 ).
*    assert2 l_date '=' '00011231'.
*    l_date = zcl_date=>class_day_number_2_date( 365 ).
*    assert2 l_date '=' '00020101'.
*
*    " -----------------------
*    " Tests de la méthode class_primitive_write_to
*
*    string = zcl_date=>class_primitive_write_to( date   = '20070515'
*                                                 datfmt = '1'
*                                                 outlen = 10 ).
*    assert2 string '=' '15.05.2007'.
*  ENDMETHOD.
*
*  " ---------------------------------------------------------------------
*  " Cette méthode compare les valeurs retournées par les dates sap et
*  " les valeurs retournées par la classe DATE, pour s'assurer qu'elles
*  " sont identiques
*  " ---------------------------------------------------------------------
*  METHOD class_tests3.
*    DATA i                TYPE i.
*    DATA j                TYPE i.
*    DATA date             TYPE d.
*    DATA l_count          TYPE i.
*    DATA l_date           TYPE zcl_date=>type_date.
*    DATA date2            TYPE d.
*    DATA i2               TYPE i.
*    DATA l_year           TYPE zcl_date=>type_year.
*    DATA l_year2          TYPE zcl_date=>type_year.
*    DATA x                TYPE REF TO zcl_date.
*    DATA l_diff_tolerance TYPE i.
*    DATA l_date2          TYPE zcl_date=>type_date.
*
*    " ---------------------------
*    " Tests des méthodes DAY_NUMBER_2_DATE et DATE_2_DAY_NUMBER par
*    " rapport au traitement des dates SAP
*
*    " ici c'est un peu long
*    CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
*      EXPORTING text = 'Test méthodes DAY_NUMBER_2_DATE et '
*  &
*  'DATE_2_DAY_NUMBER'.
*
*    i = zcl_date=>class_date_2_day_number( '00010102' ).
*    j = zcl_date=>class_date_2_day_number( '20091231' ).
*    date = '00010102'.
*    l_count = 0.
*    WHILE i < j.
*      l_date = zcl_date=>class_day_number_2_date( i ).
*      date2 = date + i - 1.
*      assert2 l_date '=' date2.
*      i2 = zcl_date=>class_date_2_day_number( l_date ).
*      assert2 i '=' i2.
*
*      l_count = l_count + 1.
*      IF l_count = 10000.
*        CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
*          EXPORTING text = l_date.
*        l_count = 0.
*      ENDIF.
*
*      i = i + 1.
*    ENDWHILE.
*
*    " ---------------------------
*    " Tests des méthodes COUNT_DAYS_til_yyyy0101 et get_year_from_day_number
*
*    l_year = 1.
*    DO.
*      i = zcl_date=>class_count_days_til_yyyy0101( l_year ).
*      l_year2 = zcl_date=>class_get_year_from_day_number( i ).
*      assert2 l_year2 '=' l_year.
*      IF l_year = '9999'.
*        EXIT.
*      ENDIF.
*      l_year = l_year + 1.
*    ENDDO.
*  ENDMETHOD.
*ENDCLASS.
