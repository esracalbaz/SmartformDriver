*&---------------------------------------------------------------------*
*&  Include           ZESRA_P0011_PAI
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN '&BCK'.
      SET SCREEN 0.
    WHEN '&SMRF'.
      gs_controlp-no_dialog = abap_true.
      gs_controlp-preview = abap_true.
      gs_output_opt-tddest = 'LP01'.
*      read TABLE gt_kna1 INTO gs_kna1 WITH KEy vbeln = p_vbeln.
*      read TABLE gt_kna1 INTO gs_kna1 WITH TABLE KEy gs_kna1-vbeln = p_vbeln.
*      perform get_data.
      go_alv->get_selected_rows(
        IMPORTING
          et_index_rows = lt_row_no    " Indexes of Selected Rows
*          et_row_no     =     " Numeric IDs of Selected Rows
      ).
*      read table gt_kna1 INTO gs_kna1 INDEX lt_row_no.
      CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
        EXPORTING
          formname           = 'ZESRA_SF_0002'
*         VARIANT            = ' '
*         DIRECT_CALL        = ' '
        IMPORTING
          fm_name            = gv_fm_name
        EXCEPTIONS
          no_form            = 1
          no_function_module = 2
          OTHERS             = 3.
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ENDIF.
*      DATA: ls_output TYPE ssfcrescl.
      CALL FUNCTION gv_fm_name
        EXPORTING
*         ARCHIVE_INDEX      =
*         ARCHIVE_INDEX_TAB  =
*         ARCHIVE_PARAMETERS =
          control_parameters = gs_controlp
*         MAIL_APPL_OBJ      =
*         MAIL_RECIPIENT     =
*         MAIL_SENDER        =
          output_options     = gs_output_opt
          user_settings      = ' '
          it_kna1            = gt1_kna1
*       IMPORTING
**         DOCUMENT_OUTPUT_INFO       =
*         JOB_OUTPUT_INFO    = ls_output
*         JOB_OUTPUT_OPTIONS =
        EXCEPTIONS
          formatting_error   = 1
          internal_error     = 2
          send_error         = 3
          user_canceled      = 4
          OTHERS             = 5.
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ENDIF.

    WHEN 'ADBF'.

  ENDCASE.
ENDMODULE.                 " USER_COMMAND_0100  INPUT
