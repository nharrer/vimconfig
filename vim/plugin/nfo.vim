command! SwitchToAsciiNfo call SwitchToAsciiNfo()
command! ReplaceUmlaute call ReplaceUmlaute()

function SwitchToAsciiNfo()
    :e ++enc=cp437
    :set guifont=BlockZone:h12
    :set textwidth=80
endfunction

function ReplaceUmlaute()
    :%s_ö_oe_g
    :%s_ä_ae_g
    :%s_ü_ue_g
    :%s_Ö_Oe_g
    :%s_Ä_Ae_g
    :%s_Ü_Ue_g
    :%s_ß_ss_g
endfunction

