CLI_ERROR_CODE = 2

# types
R = 'R'
I = 'I'
J = 'J'

IMM_SIZE = 13
ADDR_SIZE = 21

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
    ADD : {'type': R, 'opcode': '000000', 'funct': '0000000'},
    SUB : {'type': R, 'opcode': '000000', 'funct': '0000001'},
    ADDFP : {'type': R, 'opcode': '000000', 'funct': '0000100'},
    MULFP : {'type': R, 'opcode': '000000', 'funct': '0000110'},
    VADDFP : {'type': R, 'opcode': '001100', 'funct': '1000100'},
    VMULFP : {'type': R, 'opcode': '001100', 'funct': '1000110'},
    VSUMFP : {'type': R, 'opcode': '001100', 'funct': '1100000'},
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
    '$zero': '0000', 
    '$a0': '0001', 
    '$a1': '0010', 
    '$sp': '0011', 
    '$cbh': '0100', 
    '$cbt': '0101', 
    '$b0': '0110', 
    '$b1': '0111', 
    '$b2': '1000', 
    '$b3': '1001', 
    '$b4': '1010', 
    '$b5': '1011', 
    '$b6': '1100', 
    '$b7': '1101', 
    '$b8': '1110', 
    '$b9': '1111'
}
