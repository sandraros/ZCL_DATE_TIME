CLASS zcl_date DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES type_date                      TYPE n LENGTH 8.
    TYPES type_year                      TYPE n LENGTH 4.
    TYPES type_month                     TYPE n LENGTH 2.
    TYPES type_day                       TYPE n LENGTH 2.
    "! The numbering of week day numbers is based on SY-FDAYW. The constants for each week day are listed in the structured data object WEEK_DAY_NUMBER.
    "! NB: the week day number is of type INT1 to be consistent with SY-FDAYW.
    "! <ul>
    "! <li>0 : Sunday</li>
    "! <li>1 : Monday</li>
    "! <li>2 : Tuesday</li>
    "! <li>3 : Wednesday</li>
    "! <li>4 : Thursday</li>
    "! <li>5 : Friday</li>
    "! <li>6 : Saturday</li>
    "! </ul>
    TYPES type_week_day_number           TYPE int1.
    TYPES type_day_name                  TYPE string.
    TYPES type_month_name                TYPE string.
    TYPES type_month_name_3_characters   TYPE c LENGTH 3.
    TYPES type_month_name_10_characters  TYPE c LENGTH 10.
    TYPES type_month_names_3_characters  TYPE STANDARD TABLE OF type_month_name_3_characters WITH EMPTY KEY.
    TYPES type_month_names_10_characters TYPE STANDARD TABLE OF type_month_name_10_characters WITH EMPTY KEY.
    TYPES:
      BEGIN OF type_month_names_for_language,
        language                  TYPE sylangu,
        month_names_3_characters  TYPE type_month_names_3_characters,
        month_names_10_characters TYPE type_month_names_10_characters,
      END OF type_month_names_for_language.
    TYPES type_month_names_for_languages TYPE SORTED TABLE OF type_month_names_for_language WITH UNIQUE KEY language.

    CONSTANTS initial_date TYPE d VALUE '00000000'.
    CONSTANTS first_date   TYPE d VALUE '00010101'.
    CONSTANTS last_date    TYPE d VALUE '99991231'.
    CONSTANTS:
      BEGIN OF week_day_number,
        sunday    TYPE type_week_day_number VALUE 0,
        monday    TYPE type_week_day_number VALUE 1,
        tuesday   TYPE type_week_day_number VALUE 2,
        wednesday TYPE type_week_day_number VALUE 3,
        thursday  TYPE type_week_day_number VALUE 4,
        friday    TYPE type_week_day_number VALUE 5,
        saturday  TYPE type_week_day_number VALUE 6,
      END OF week_day_number.
    CONSTANTS:
      BEGIN OF month_number,
        january   TYPE type_month VALUE 1,
        february  TYPE type_month VALUE 2,
        march     TYPE type_month VALUE 3,
        april     TYPE type_month VALUE 4,
        may       TYPE type_month VALUE 5,
        june      TYPE type_month VALUE 6,
        july      TYPE type_month VALUE 7,
        august    TYPE type_month VALUE 8,
        september TYPE type_month VALUE 9,
        october   TYPE type_month VALUE 10,
        november  TYPE type_month VALUE 11,
        december  TYPE type_month VALUE 12,
      END OF month_number.

    CLASS-METHODS class_constructor.

    METHODS add_days
      IMPORTING number_of_days TYPE i
      returning VALUE(date) type ref to zcl_date.

    "! <p class="shorttext synchronized" lang="en"></p>
    "!
    "! @parameter number_of_months | <p class="shorttext synchronized" lang="en"></p>
    "! @parameter set_last_month_day_if_overflow | if current date is 2026/01/31 and one month is added, the new date 2026/02/31 doesn't exist<ul>
    "! <li>'X' (true, default): the new date is 2026/02/28. NB: if the input date was 2024/01/31, the returned date would be 2024/02/29 (leap year)</li>
    "! <li>' ' (false): an exception is raised</li>
    "! </ul>
    METHODS add_months
      IMPORTING number_of_months TYPE i
      set_last_month_day_if_overflow type abap_bool default abap_true
      returning VALUE(date) type ref to zcl_date.

    "! <p class="shorttext synchronized" lang="en"></p>
    "!
    "! @parameter number_of_years | <p class="shorttext synchronized" lang="en"></p>
    "! @parameter set_last_month_day_if_overflow | if current date is 2026/01/31 and one month is added, the new date 2026/02/31 doesn't exist<ul>
    "! <li>'X' (true, default): the new date is 2026/02/28. NB: if the input date was 2024/01/31, the returned date would be 2024/02/29 (leap year)</li>
    "! <li>' ' (false): an exception is raised</li>
    "! </ul>
    METHODS add_years
      IMPORTING number_of_years TYPE i
      set_last_month_day_if_overflow type abap_bool default abap_true
      returning VALUE(date) type ref to zcl_date.

    METHODS constructor
      IMPORTING !date TYPE d.

    CLASS-METHODS create_from_type_d
      IMPORTING abap_date   TYPE d
      RETURNING VALUE(date) TYPE REF TO zcl_date.

    METHODS get_date_as_type_d
      returning VALUE(date) type d.

    METHODS get_day
      RETURNING VALUE(day) TYPE type_day.

    "! <ul>
    "! <li>D : day number, 1 digit from 1 to 9 and 2 digits from 10 to 31</li>
    "! <li>DD : day number on 2 digits, prefixed with 0 for days between 1 and 9</li>
    "! <li>DDD</li>
    "! <li>M : month number, 1 digit from 1 to 9 and 2 digits from 10 to 31</li>
    "! <li>MM : month number on 2 digits, prefixed with 0 for months between 1 and 9</li>
    "! <li>MMM : month abbreviation of 3 characters as per ISO-8601</li>
    "! <li>MMMM : month name with length limited to 10 characters</li>
    "! <li>MMMMM : month name without length limit, lower or upper case depending on the language</li>
    "! <li>YY : year without century</li>
    "! <li>YYYY : year with century</li>
    "! </ul>
    METHODS get_formatted_date
    importing input_format type clike
      returning VALUE(formatted_date) type string.

    METHODS get_month
      RETURNING VALUE(month) TYPE type_month.

    METHODS get_month_name
      RETURNING VALUE(month) TYPE type_month_name.

    METHODS get_month_name_3_characters
      RETURNING VALUE(month_name_3_characters) TYPE type_month_name_3_characters.

    METHODS get_month_name_10_characters
      RETURNING VALUE(month_name_10_characters) TYPE type_month_name_10_characters.

    METHODS get_week_day
      RETURNING VALUE(week_day) TYPE type_week_day_number.

    METHODS get_year
      RETURNING VALUE(year) TYPE type_year.

    METHODS is_leap_year
      RETURNING VALUE(is_leap_year) TYPE abap_bool.

    METHODS set_date
      IMPORTING date TYPE d.

    METHODS set_day
      IMPORTING day TYPE type_day
      returning VALUE(date) type ref to zcl_date.

    METHODS set_day_as_end_of_month.

    METHODS set_month
      IMPORTING month TYPE type_month
      returning VALUE(date) type ref to zcl_date.

*    METHODS set_to_end_of_month.
*
*    METHODS set_to_end_of_year.
*
*    METHODS set_to_previous_day_of_week.

    METHODS set_year
      IMPORTING year TYPE type_year
      returning VALUE(date) type ref to zcl_date.

    METHODS subtract_days
      IMPORTING number_of_days TYPE i
      returning VALUE(date) type ref to zcl_date.

    "! <p class="shorttext synchronized" lang="en"></p>
    "!
    "! @parameter number_of_months | <p class="shorttext synchronized" lang="en"></p>
    "! @parameter set_last_month_day_if_overflow | if current date is 2026/01/31 and one month is added, the new date 2026/02/31 doesn't exist<ul>
    "! <li>'X' (true, default): the new date is 2026/02/28. NB: if the input date was 2024/01/31, the returned date would be 2024/02/29 (leap year)</li>
    "! <li>' ' (false): an exception is raised</li>
    "! </ul>
    METHODS subtract_months
      IMPORTING number_of_months TYPE i
      set_last_month_day_if_overflow type abap_bool default abap_true
      returning VALUE(date) type ref to zcl_date.

    "! <p class="shorttext synchronized" lang="en"></p>
    "!
    "! @parameter number_of_years | <p class="shorttext synchronized" lang="en"></p>
    "! @parameter set_last_month_day_if_overflow | if current date is 2026/01/31 and one month is added, the new date 2026/02/31 doesn't exist<ul>
    "! <li>'X' (true, default): the new date is 2026/02/28. NB: if the input date was 2024/01/31, the returned date would be 2024/02/29 (leap year)</li>
    "! <li>' ' (false): an exception is raised</li>
    "! </ul>
    METHODS subtract_years
      IMPORTING number_of_years TYPE i
      set_last_month_day_if_overflow type abap_bool default abap_true
      returning VALUE(date) type ref to zcl_date.

  PRIVATE SECTION.
    DATA date TYPE d.

    METHODS raise_exception_if_initial.

    METHODS raise_exception_if_initial_2
      imPORTING input_date type d.

    METHODS raise_exception_if_invalid.

    CLASS-DATA modulo_result            TYPE i.
    CLASS-DATA no_of_days_this_month    TYPE TABLE OF int1.
    CLASS-DATA no_of_days_since_jan_1st TYPE TABLE OF int2.
    CLASS-DATA sap_algo TYPE abap_bool VALUE abap_true.

    CLASS-METHODS class_is_leap_year
      IMPORTING year                TYPE gjahr
      RETURNING VALUE(is_leap_year) TYPE flag.
ENDCLASS.                    " lcl_date DEFINITION


CLASS zcl_date IMPLEMENTATION.
  METHOD add_days.
    me->date = me->date + number_of_days.
    raise_exception_if_invalid( ).
    date = me.
  ENDMETHOD.

  METHOD add_months.
    raise_exception_if_initial( ).
    DATA(new_month) = CONV type_month( ( ( me->date+4(2) + number_of_months - 1 ) MOD 12 ) + 1 ).
    set_month( new_month ).
    DATA(number_of_years) = number_of_months DIV 12.
    add_years( number_of_years ).
    date = me.
  ENDMETHOD.

  METHOD add_years.
    DATA(new_year) = CONV type_year( me->date(4) + number_of_years ).
    set_year( new_year ).
    raise_exception_if_invalid( ).
    date = me.
  ENDMETHOD.

  METHOD class_constructor.
    " TODO
    " Month names. Same as table T247 for abbreviations on 3 and 10 characters. Full names to be completed.
    " Classes ZCL_DATE_MONTH_NAMES and ZCL_DATE_DAY_NAMES to be created.
    DATA(month_names) = VALUE type_month_names_for_languages( ( language                  = 'E'
                                                                month_names_3_characters  = VALUE #( ( 'JAN' )
                                                                                                     ( 'FEB' ) )
                                                                month_names_10_characters = VALUE #( ( 'January' )
                                                                                                     ( 'February' ) ) ) ).
  ENDMETHOD.

  METHOD class_is_leap_year.
    " 0004 returns false (it means that 0004/02/29 doesn't exist)
    " 1580 returns false (it means that 1580/02/29 doesn't exist)
    " 1584 returns true  (it means that 1584/02/29 exists)
    " 1600 returns false (it means that 1600/02/29 exists)
    " 1700 returns true  (it means that 1700/02/29 doesn't exist)
    " 2000 returns true  (it means that 2000/02/29 exists)
    " 2024 returns true  (it means that 2024/02/29 exists)
    " 2100 returns false (it means that 2100/02/29 doesn't exist)

    IF year <= 1582.
      " 1582/10/15 = Start of the gregorian calendar
      " (before is the julian calendar)
      is_leap_year = abap_false.
    ELSE.
      is_leap_year = abap_false.
      modulo_result = year MOD 4.
      IF modulo_result = 0.
        modulo_result = year MOD 100.
        IF modulo_result <> 0.
          is_leap_year = abap_true.
        ELSE.
          modulo_result = year MOD 400.
          IF modulo_result = 0.
            is_leap_year = abap_true.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDMETHOD.

  METHOD constructor.
    me->date = date.
  ENDMETHOD.

  METHOD create_from_type_d.
    date = NEW zcl_date( abap_date ).
  ENDMETHOD.

  METHOD get_date_as_type_d.
    date = me->date.
  ENDMETHOD.

  METHOD get_day.
    day = date+6(2).
  ENDMETHOD.

  METHOD get_formatted_date.
  ENDMETHOD.

  METHOD get_month.
    month = date+4(2).
  ENDMETHOD.

  METHOD get_month_name.
  ENDMETHOD.

  METHOD get_month_name_3_characters.
  ENDMETHOD.

  METHOD get_month_name_10_characters.
  ENDMETHOD.

  METHOD get_week_day.
    raise_exception_if_initial( ).
    " +6 or -1 is needed to obtain 0 for Sunday up to 6 for Saturday to be consistent with the constant WEEK_DAY_NUMBER.
    IF date <= '99991225'.
      week_day = ( date + 6 ) MOD 7.
    ELSE.
      week_day = ( date - 1 ) MOD 7.
    ENDIF.
  ENDMETHOD.

  METHOD get_year.
    year = date(4).
  ENDMETHOD.

  METHOD is_leap_year.
    raise_exception_if_invalid( ).
    is_leap_year = class_is_leap_year( date(4) ).
  ENDMETHOD.

  METHOD raise_exception_if_initial.
    raise_exception_if_initial_2( date ).
  ENDMETHOD.

  METHOD raise_exception_if_initial_2.
    IF input_date = initial_date.
      RAISE EXCEPTION TYPE zcx_date
        EXPORTING message = 'Invalid date &1'
                  msgv1   = input_date.
    ENDIF.
  ENDMETHOD.

  METHOD raise_exception_if_invalid.
    DATA local_date TYPE d.

    IF date = last_date.
      RETURN.
    ENDIF.
    local_date = date + 1 - 1.
    raise_exception_if_initial_2( local_date ).
  ENDMETHOD.

  METHOD set_date.
    me->date = date.
  ENDMETHOD.

  METHOD set_day.
    me->date+6(2) = day.
    raise_exception_if_initial( ).
    date = me.
  ENDMETHOD.

  METHOD set_day_as_end_of_month.
    IF me->date+4(2) = '02'.
    ELSE.
    ENDIF.
  ENDMETHOD.

  METHOD set_month.
    me->date+4(2) = month.
    date = me.
  ENDMETHOD.

  METHOD set_year.
    IF year = '0000'.
      RAISE EXCEPTION TYPE zcx_date
        EXPORTING
          message = 'Invalid year &1'
          msgv1   = year.
    ENDIF.
    me->date(4) = year.
    RAIse_exception_if_invalid( ).
    date = me.
  ENDMETHOD.

  METHOD subtract_days.
    date = add_days( - number_of_days ).
  ENDMETHOD.

  METHOD subtract_months.
    date = add_months( - number_of_months ).
  ENDMETHOD.

  METHOD subtract_years.
    date = add_years( - number_of_years ).
  ENDMETHOD.
ENDCLASS.
