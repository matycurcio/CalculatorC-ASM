# CalculatorC-ASM
Calculator chat in C with functions in ASM  
nasm -g -f elf32 recibir_Operacion.asm -o recibir_Operacion.o  
gcc -g -m32 -o main_calc main_calc.c recibir_Operacion.o  
