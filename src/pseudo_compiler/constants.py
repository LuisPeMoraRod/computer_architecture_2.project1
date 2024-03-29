CLI_ERROR_CODE = 2

# types
R = 'R'
I = 'I'
J = 'J'

IMM_SIZE = 16
ADDR_SIZE = 26

#mnemonics
ADD = 'suma'
SUB = 'reste'
ADDFP = 'suma_fp'
MULFP = 'mul_fp'
VADDFP = 'v_suma_fp'
VMULFP = 'v_mul_fp'
VSUMFP = 'v_sumhor_fp'
ADDI = 'suma_in'
BEQ = 'salte_ig'
BLT = 'salte_me'
SW = 'guarde'
LW = 'cargue'
SWFP = 'guarde_fp'
LWFP = 'cargue_fp'
VSETFP = 'set_fp'
VST = 'v_guarde_fp'
VLD = 'v_cargue_fp'
J = 'salte'
END = 'fin'
START = 'inicie'

isa = {
    ADD : {'type': R, 'opcode': '000000', 'funct': '000000'},
    SUB : {'type': R, 'opcode': '000000', 'funct': '000001'},
    ADDFP : {'type': R, 'opcode': '000000', 'funct': '000100'},
    MULFP : {'type': R, 'opcode': '000000', 'funct': '000110'},
    VADDFP : {'type': R, 'opcode': '001100', 'funct': '100100'},
    VMULFP : {'type': R, 'opcode': '001100', 'funct': '100110'},
    VSUMFP : {'type': R, 'opcode': '001100', 'funct': '110000'},
    ADDI : {'type': I, 'opcode': '010000'},
    BEQ : {'type': I, 'opcode': '100000'},
    BLT : {'type': I, 'opcode': '100001'},
    SW : {'type': I, 'opcode': '010001'},
    LW : {'type': I, 'opcode': '010010'},
    SWFP : {'type': I, 'opcode': '010101'},
    LWFP : {'type': I, 'opcode': '010110'},
    VSETFP : {'type': I, 'opcode': '111111'},
    VST : {'type': I, 'opcode': '011101'},
    VLD : {'type': I, 'opcode': '011110'},
    J : {'type': J, 'opcode': '100010'},
    END: {'type': None, 'opcode': '110001'},
    START: {'type': None, 'opcode': '110010'},
}

#Registers names
registers = {
    '$zero': '00000',
    '$a0': '00001', 
    '$a1': '00010', 
    '$sp': '00011', 
    '$cbh': '00100', 
    '$cbt': '00101', 
    '$b0': '00110', 
    '$b1': '00111', 
    '$b2': '01000', 
    '$b3': '01001', 
    '$b4': '01010', 
    '$b5': '01011', 
    '$b6': '01100', 
    '$b7': '01101', 
    '$b8': '01110', 
    '$b9': '01111',
    '$v0': '10000', 
    '$v1': '10001', 
    '$v2': '10010', 
    '$v3': '10011', 
    '$v4': '10100', 
    '$v5': '10101', 
    '$v6': '10110', 
    '$v7': '10111', 
    '$': '01000', 
    '$': '01001', 
    '$': '01010', 
    '$': '01011', 
    '$': '01100', 
    '$': '01101', 
    '$': '01110', 
    '$': '01111',


}
