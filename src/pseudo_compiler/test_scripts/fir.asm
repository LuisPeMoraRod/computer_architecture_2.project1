    addi $t0, $zero, 4
    add $t1, $zero, $zero
    lw $t2, $zero, 0
    vld_fp $v0, $t2, 0
loop:
    beq $t0, $t1, eof

    vset_fp $v0, 128
    vset_fp $v1, 256
    vmul_fp $v2, $v0, $v1

    vsum_fp $v3, $v2

    addi $t1, $t1, 1
    jump loop
eof:
    addi $t3, $zero, 3