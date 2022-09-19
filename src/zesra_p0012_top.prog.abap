*&---------------------------------------------------------------------*
*&  Include           ZESRA_P0011_TOP
*&---------------------------------------------------------------------*

TABLES: vbrk, kna1, zesra_vbrk.

TYPES: BEGIN OF gty_vbrk,
*         mark,
         vbeln TYPE vbrk-vbeln,
         fkart TYPE vbrk-fkart,
         waerk TYPE vbrk-waerk,
         vkorg TYPE vbrk-vkorg,
         fkdat TYPE vbrk-fkdat,
         bukrs TYPE vbrk-bukrs,
*         netwr TYPE vbrk-netwr,
*         mwsbk TYPE vbrk-mwsbk,
         kunag TYPE vbrk-kunag,
       END OF gty_vbrk.

TYPES: BEGIN OF gty_kna1,
*         mark,
         vbeln TYPE vbrk-vbeln,
         fkart TYPE vbrk-fkart,
         waerk TYPE vbrk-waerk,
         vkorg TYPE vbrk-vkorg,
         fkdat TYPE vbrk-fkdat,
         bukrs TYPE vbrk-bukrs,
*         netwr TYPE vbrk-netwr,
*         mwsbk TYPE vbrk-mwsbk,
         kunag TYPE vbrk-kunag,
         kunnr TYPE kna1-kunnr,
         adrnr TYPE kna1-adrnr,
       END OF gty_kna1.

DATA: gt_vbrk TYPE TABLE OF gty_kna1,
      gs_vbrk TYPE          gty_kna1.

DATA: gt_kna1 TYPE TABLE OF zesra_s_kna1 ,
      gs_kna1 TYPE          zesra_s_kna1.

DATA: go_alv    TYPE REF TO cl_gui_alv_grid,
*      e_alv TYPE REF TO cl_gui_alv_grid,
      go_cont   TYPE REF TO cl_gui_custom_container,
      lt_row_no TYPE        lvc_t_row.

DATA: gt_fcat TYPE lvc_t_fcat,
      gs_fcat TYPE lvc_s_fcat.

DATA: gv_fm_name    TYPE rs38l_fnam,
      gs_controlp   TYPE ssfctrlop,
      gs_output_opt TYPE ssfcompop.

DATA: gs1_kna1 TYPE          zesra_s_kna1,
      gt1_kna1 TYPE TABLE OF zesra_s_kna1.

*FIELD-SYMBOLS: <gfs_fcat> TYPE lvc_s_fcat.

SELECTION-SCREEN BEGIN OF BLOCK block WITH FRAME TITLE title.
PARAMETERS: p_vbeln TYPE  vbrk-vbeln MODIF ID gr1.
*PARAMETERS: p_vbeln TYPE zesra_vbrk-vbeln MODIF ID gr1.
SELECTION-SCREEN END OF BLOCK block.

*SELECTION-SCREEN BEGIN OF BLOCK block WITH FRAME TITLE title.
*select-options: s_vbeln for vbrk-vbeln modif id gr1.
**PARAMETERS: p_vbeln TYPE zesra_vbrk-vbeln MODIF ID gr1.
*SELECTION-SCREEN END OF BLOCK block.
