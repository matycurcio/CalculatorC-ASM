section .text
global recibir_Operacion

recibir_Operacion:

    mov eax, [esp + 4]      ; Cargar operando1 en eax
    mov ecx, [esp + 12]     ; Cargar operando2 en ecx
    mov dl, [esp + 8]       ; Cargar operador en dl (utilizo dl porque es un solo byte)

    cmp dl, '+'             ; Comparar con '+'
    je sum
    cmp dl, '-'             ; Comparar con '-'
    je res
    cmp dl, '*'             ; Comparar con '*'
    je mul
    cmp dl, '/'             ; Comparar con '/'
    je div
    jmp error               ; Si no es ninguno de los operadores conocidos, saltar a error

sum:
    add eax, ecx            ; Sumar eax y ecx
    ret

res:
    sub eax, ecx            ; Restar ebx de eax
    ret

mul:
    imul eax, ecx           ; Multiplicar eax por ecx
    ret

div:
    ; Manejar división por cero
    cmp dl, 0
    je error                ; Saltar a error si dl es 0
    cdq                     ; Convertir ecx:eax para división
    idiv ebx                ; Dividir eax entre ebx
    ret

error:
    mov eax, 'e'              ; Devolver e en caso de error
    ret
