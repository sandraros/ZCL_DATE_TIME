CLASS zcx_date DEFINITION
  PUBLIC
  INHERITING FROM cx_no_check
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING !message TYPE clike
                msgv1    TYPE clike OPTIONAL
                msgv2    TYPE clike OPTIONAL
                msgv3    TYPE clike OPTIONAL
                msgv4    TYPE clike OPTIONAL.

    METHODS get_text     REDEFINITION.
    METHODS get_longtext REDEFINITION.

  PRIVATE SECTION.
    DATA message TYPE string.
ENDCLASS.


CLASS zcx_date IMPLEMENTATION.
  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).
    me->message = message.
    REPLACE ALL OCCURRENCES OF '&1' IN me->message WITH msgv1.
    REPLACE ALL OCCURRENCES OF '&2' IN me->message WITH msgv2.
    REPLACE ALL OCCURRENCES OF '&3' IN me->message WITH msgv3.
    REPLACE ALL OCCURRENCES OF '&4' IN me->message WITH msgv4.
  ENDMETHOD.

  METHOD get_text.
    result = message.
  ENDMETHOD.

  METHOD get_longtext.
    result = message.
  ENDMETHOD.
ENDCLASS.
