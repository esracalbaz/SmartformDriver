*&---------------------------------------------------------------------*
*&  Include           ZESRA_P0011_PBO
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS '0100'.
  SET TITLEBAR '0100'.
  PERFORM display_alv.
ENDMODULE.                 " STATUS_0100  OUTPUT
