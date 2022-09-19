*&---------------------------------------------------------------------*
*& Report  ZESRA_P0011
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT zesra_p0012.

INCLUDE zesra_p0012_cls.
INCLUDE zesra_p0012_top.
INCLUDE zesra_p0012_pbo.
INCLUDE zesra_p0012_pai.
INCLUDE zesra_p0012_frm.

START-OF-SELECTION.

  PERFORM get_data.
  PERFORM set_fcat.

  CALL SCREEN 0100.
