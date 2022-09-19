*&---------------------------------------------------------------------*
*&  Include           ZESRA_P0011_FRM
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_data .

*****  SELECT * FROM vbrk UP TO 50 ROWS INTO CORRESPONDING FIELDS OF TABLE gt_vbrk WHERE vbrk~vbeln EQ p_vbeln.
******  SELECT * FROM vbrk UP TO 50 ROWS INTO CORRESPONDING FIELDS OF TABLE gt_vbrk WHERE vbrk~vbeln IN s_vbeln.
*****  IF gt_vbrk[] IS NOT INITIAL.
******     vbeln fkart waerk vkorg fkdat bukrs netwr mwsbk kunrg
*****    SELECT kunnr adrnr
*****      FROM kna1
*****      INTO CORRESPONDING FIELDS OF TABLE gt_kna1[]
*****      FOR ALL ENTRIES IN gt_vbrk[]
*****      WHERE kunnr EQ gt_vbrk-kunag.
*****
******      IF sy-subrc = '0'.
******        MOVE-CORRESPONDING gt_vbrk to gt_kna1.
******      ENDIF.
*****  ENDIF.
*  a~vbeln a~fkart a~waerk a~vkorg a~fkdat a~bukrs a~netwr a~mwsbk a~kunag b~kunnr b~adrnr, a~netwr a~mwsbk
  SELECT a~vbeln a~fkart a~waerk a~vkorg a~fkdat a~bukrs a~kunag b~kunnr b~adrnr
    FROM vbrk AS a
    INNER JOIN kna1 AS b
    ON a~kunag EQ b~kunnr
    INTO CORRESPONDING FIELDS OF TABLE gt_kna1
    WHERE a~vbeln EQ p_vbeln.

  CLEAR: gs_kna1.
  LOOP AT gt_kna1 INTO gs_kna1.
    gs1_kna1 = gs_kna1.
    APPEND gs1_kna1 TO gt1_kna1.
  ENDLOOP.

ENDFORM.                    " GET_DATA

*&---------------------------------------------------------------------*
*&      Form  DISPLAY_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM display_alv .
  CREATE OBJECT go_cont
    EXPORTING
*     parent         =     " Parent container
      container_name = 'CC_ALV'    " Name of the Screen CustCtrl Name to Link Container To
*     style          =     " Windows Style Attributes Applied to this Container
*     lifetime       = LIFETIME_DEFAULT    " Lifetime
*     repid          =     " Screen to Which this Container is Linked
*     dynnr          =     " Report To Which this Container is Linked
*     no_autodef_progid_dynnr     =     " Don't Autodefined Progid and Dynnr?
*    EXCEPTIONS
*     cntl_error     = 1
*     cntl_system_error           = 2
*     create_error   = 3
*     lifetime_error = 4
*     lifetime_dynpro_dynpro_link = 5
*     others         = 6
    .
  IF sy-subrc <> 0.
*   MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  CREATE OBJECT go_alv
    EXPORTING
*     i_shellstyle      = 0    " Control Style
*     i_lifetime        =     " Lifetime
      i_parent = go_cont    " Parent Container
*     i_appl_events     = SPACE    " Register Events as Application Events
*     i_parentdbg       =     " Internal, Do not Use
*     i_applogparent    =     " Container for Application Log
*     i_graphicsparent  =     " Container for Graphics
*     i_name   =     " Name
*     i_fcat_complete   = SPACE    " Boolean Variable (X=True, Space=False)
*    EXCEPTIONS
*     error_cntl_create = 1
*     error_cntl_init   = 2
*     error_cntl_link   = 3
*     error_dp_create   = 4
*     others   = 5
    .
  IF sy-subrc <> 0.
*   MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  CALL METHOD go_alv->set_table_for_first_display
*    EXPORTING
*      i_buffer_active               =     " Buffering Active
*      i_bypassing_buffer            =     " Switch Off Buffer
*      i_consistency_check           =     " Starting Consistency Check for Interface Error Recognition
*      i_structure_name              = 'GS_VBRK'     " Internal Output Table Structure Name
*      is_variant                    =     " Layout
*      i_save                        =     " Save Layout
*      i_default                     = 'X'    " Default Display Variant
*      is_layout                     =     " Layout
*      is_print                      =     " Print Control
*      it_special_groups             =     " Field Groups
*      it_toolbar_excluding          =     " Excluded Toolbar Standard Functions
*      it_hyperlink                  =     " Hyperlinks
*      it_alv_graphics               =     " Table of Structure DTC_S_TC
*      it_except_qinfo               =     " Table for Exception Quickinfo
*      ir_salv_adapter               =     " Interface ALV Adapter
    CHANGING
      it_outtab       = gt_kna1[]    " Output Table
      it_fieldcatalog = gt_fcat    " Field Catalog
*     it_sort         =     " Sort Criteria
*     it_filter       =     " Filter Criteria
*    EXCEPTIONS
*     invalid_parameter_combination = 1
*     program_error   = 2
*     too_many_lines  = 3
*     others          = 4
    .
  IF sy-subrc <> 0.
*   MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
ENDFORM.                    " DISPLAY_ALV
*&---------------------------------------------------------------------*
*&      Form  SET_FCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM set_fcat .
  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'VBELN'.
  gs_fcat-scrtext_s = 'Billing D'.
  gs_fcat-scrtext_m = 'Billing Doc'.
  gs_fcat-scrtext_l = 'Billing Document'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'FKART'.
  gs_fcat-scrtext_s = 'Billing T'.
  gs_fcat-scrtext_m = 'Billing Ty'.
  gs_fcat-scrtext_l = 'Billing Type'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'WAERK'.
  gs_fcat-scrtext_s = 'SD Document C'.
  gs_fcat-scrtext_m = 'SD Document Curr'.
  gs_fcat-scrtext_l = 'SD Document Currency'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'VKORG'.
  gs_fcat-scrtext_s = 'Sales O'.
  gs_fcat-scrtext_m = 'Sales Org'.
  gs_fcat-scrtext_l = 'Sales Organization'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'FKDAT'.
  gs_fcat-scrtext_s = 'Billing D'.
  gs_fcat-scrtext_m = 'Billing Date'.
  gs_fcat-scrtext_l = 'Billing Date for Billing Index and Printout'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'BUKRS'.
  gs_fcat-scrtext_s = 'Company C'.
  gs_fcat-scrtext_m = 'Company Co'.
  gs_fcat-scrtext_l = 'Company Code'.
  APPEND gs_fcat TO gt_fcat.
*  CLEAR: gs_fcat.
*  gs_fcat-fieldname = 'NETWR'.
*  gs_fcat-scrtext_s = 'Net V'.
*  gs_fcat-scrtext_m = 'Net Val'.
*  gs_fcat-scrtext_l = 'Net Value'.
*  APPEND gs_fcat TO gt_fcat.
*  CLEAR: gs_fcat.
*  gs_fcat-fieldname = 'MWSBK'.
*  gs_fcat-scrtext_s = 'Tax A'.
*  gs_fcat-scrtext_m = 'Tax Amou'.
*  gs_fcat-scrtext_l = 'Tax Amount'.
*  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'KUNNR'.
  gs_fcat-scrtext_s = 'Customer N'.
  gs_fcat-scrtext_m = 'Customer Num'.
  gs_fcat-scrtext_l = 'Customer Number'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'ADRNR'.
  gs_fcat-scrtext_s = 'Address'.
  gs_fcat-scrtext_m = 'Address'.
  gs_fcat-scrtext_l = 'Address'.
  APPEND gs_fcat TO gt_fcat.

*  LOOP AT gt_fcat ASSIGNING <gfs_fcat>.
*    IF <gfs_fcat>-fieldname eq 'VBELN'.
*      <gfs_fcat>-f4availabl = abap_true.
*    ENDIF.
*  ENDLOOP.


ENDFORM.                    " SET_FCAT
