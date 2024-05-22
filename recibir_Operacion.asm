section .data
global error_code
error_code dd 0            ; Definir la variable global de error y inicializarla a 0

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
    jmp invalid_operator    ; Si no es ninguno de los operadores conocidos, saltar a invalid_operator

sum:
    add eax, ecx            ; Sumar eax y ecx
    mov dword [error_code], 0 ; Establecer error a 0
    ret

res:
    sub eax, ecx            ; Restar ebx de eax
    mov dword [error_code], 0 ; Establecer error a 0
    ret

mul:
    imul eax, ecx           ; Multiplicar eax por ecx
    mov dword [error_code], 0 ; Establecer error a 0
    ret

div:
    ; Manejar división por cero
    cmp ecx, 0
    je division_by_zero     ; Saltar a division_by_zero si ecx es 0
    cdq                     ; Convertir ecx:eax para división
    idiv ecx                ; Dividir eax entre ecx
    mov dword [error_code], 0 ; Establecer error a 0
    ret

division_by_zero:
    mov eax, 0              ; Establecer resultado a 0 (por consistencia)
    mov dword [error_code], 1 ; Establecer error a 1 (división por cero)
    ret

invalid_operator:
    mov eax, 0              ; Establecer resultado a 0 (por consistencia)
    mov dword [error_code], 2 ; Establecer error a 2 (operador no válido)
    ret
