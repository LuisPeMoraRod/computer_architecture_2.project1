inicie $zero
salte_ig $b0, $zero, complemento_a_dos

multiplicacion:
    mul_fp $b0, $b0, $b1
    salte_me $b0, $zero, guardar_dato

complemento_a_dos:
    suma_fp $b0, $b0, $b0
    suma_fp $b1, $zero, $b0
    suma $b0, $b0, $b1 

guardar_dato:
    v_mul_fp $b2, $zero, $b0
    reste $sp, $sp, $b2
    guarde $b0, $sp
    cargue_fp $b1, $sp
    fin $zero

    
    
