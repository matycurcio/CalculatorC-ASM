# Bot de Consultas Aritméticas en C y Assembly

Profesores :  Ing. Marcos D. Aranda , Tec. Carlos Jimenez ,  Alessia Katerina Lescano Horbik

Alumnos : Matías Curcio , Lautaro Avalos

Comisión :  COM-01

Período lectivo  : 1 / 2024 


## Introducción
Este informe describe el desarrollo de un programa que implementa un bot para responder consultas aritméticas simples. El programa está escrito en C y ensamblador (assembly). El bot puede realizar sumas, restas, multiplicaciones y divisiones de números enteros. En caso de errores en la consulta, el bot responde con mensajes amigables y específicos.
Descripción del Código en C
## Declaraciones Iniciales y Funciones Principales

### El programa en C se estructura de la siguiente manera:

### Importación de bibliotecas necesarias:
```
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
```
### Declaración de una variable utilizada en assembly para el manejo de errores:
```
extern int error_code;
```
### Declaración de la función de assembly encargada de resolver las operaciones aritméticas:
```
extern int recibir_Operacion(int operando1, char operador, int operando2);
```
### Declaración de funciones utilizadas para el manejo de mensajes de error, lectura de entrada del usuario y validación del operador:
```
void LeerPregunta(char *pregunta);
void RespuestaError(int error_code);
bool CheckOperador(char *token);
```
### Ciclo principal del programa:

El programa ejecuta un ciclo que se termina solo cuando se encuentra con un error.
Esta porción de código se encarga de separar la pregunta ingresada por el usuario teniendo en cuenta los espacios:
```
char *token = strtok(pregunta, " ");
if (token == NULL) {
    RespuestaError(-1);
    continue;
}
```
### Verificación de que se ingrese solo números enteros como operadores:
```
int operando1;
if (strchr(token, ',') != NULL || strchr(token, '.') != NULL || sscanf(token, "%d", &operando1) != 1) {
    RespuestaError(-1);
    continue;
}
```
### Comprobación de que el operador sea válido:
```
if (CheckOperador(&operador)) {
    RespuestaError(-1);
    continue;
}
```
### Llamada a la función de ensamblador y manejo de errores:
```
int resultado = recibir_Operacion(operando1, operador, operando2);
if (error_code == 1) {
    RespuestaError(1);
    continue;
} else if (error_code == 2) {
    RespuestaError(2);
    continue;
}
```
### Mostrar el resultado en pantalla si no hay errores:
```
printf("Primer op: %d\n", operando1);
printf("Segundo op: %d\n", operando2);
printf("Operador: %c\n", operador);
printf("Resultado: %d\n", resultado);
```
## Funciones Auxiliares
### LeerPregunta:
### Descripción: Solicita al usuario ingresar una operación aritmética.
### Implementación:
```
void LeerPregunta(char *pregunta) {
    printf("Ingrese su operación (por ejemplo, 10 + 10): ");
    fgets(pregunta, 100, stdin);

    // Eliminar el salto de línea si existe
    size_t len = strlen(pregunta);
    if (len > 0 && pregunta[len - 1] == '\n') {
        pregunta[len - 1] = '\0';
    }
}
```
### RespuestaError:
### Descripción: Muestra el mensaje de error adecuado dependiendo del error.
### Implementación:
```
void RespuestaError(int error_code) {
    if (error_code == 1) {
        printf("Lo siento, mis respuestas son limitadas. División por cero no permitida.\n");
    } else if (error_code == 2) {
        printf("Lo siento, mis respuestas son limitadas. Operador no válido.\n");
    } else {
        printf("Lo siento, mis respuestas son limitadas. Error de formato.\n");
    }
}
```
### CheckOperador:
### Descripción: Verifica que el operador ingresado sea ‘+’, ‘-’, ‘*’ o ‘/’.
### Implementación:
```
bool CheckOperador(char *token) {
    if (token == NULL || (token[0] != '+' && token[0] != '-' && token[0] != '*' && token[0] != '/')) {
        return true;
    }
    return false;
}
```
## Funciones Importadas de Bibliotecas Estándar
```
#include <stdio.h>:
```
printf: Esta función se usa para imprimir mensajes en la consola. En nuestro programa, se utiliza para mostrar los resultados y mensajes de error.

fgets: Se usa para leer una línea de entrada del usuario.
```
#include <string.h>:
```
strtok: Utilizada para dividir la cadena de entrada en tokens, separando los operandos y el operador.

strchr: Se usa para buscar la presencia de caracteres específicos (como ',' o '.') en una cadena.
```
#include <stdbool.h>:
```
bool: Tipo de dato booleano que se utiliza en las funciones que retornan true o false.

Descripción del Código en Assembly:
### Sección .data:
Se define una variable global llamada error_code y se inicializa con 0 utilizando la directiva dd que reserva espacio para un dato de tamaño dword (doble palabra), que es de 4 bytes.
### Sección .text:
Se define la función recibir_Operacion como global para que sea accesible desde fuera del archivo.
### Recibir_Operacion:
Los valores de los operandos y el operador se pasan a la función a través de la pila.
Se cargan los operandos y el operador en los registros eax, ecx y dl respectivamente.
Se compara el operador (dl) con los diferentes operadores (+, -, *, /) utilizando la instrucción cmp (comparación).
Dependiendo del operador, se realiza la operación correspondiente y se salta a la etiqueta adecuada (sum, res, mul, div).
Si el operador no es ninguno de los operadores conocidos, se salta a invalid_operator.
Etiquetas para operaciones:
sum: Realiza la suma de los operandos (eax y ecx), establece el error a 0 y retorna.
res: Realiza la resta de los operandos (ecx se resta de eax), establece el error a 0 y retorna.
mul: Realiza la multiplicación de los operandos (eax por ecx), establece el error a 0 y retorna.
div: Realiza la división de los operandos (eax entre ecx). Antes de la división, verifica si ecx es 0. Si es así, salta a division_by_zero. Luego, establece el error a 0 y retorna.
division_by_zero: Maneja el caso de división por cero estableciendo el resultado a 0 por consistencia y estableciendo el error a 1.
invalid_operator: Maneja el caso de un operador no válido estableciendo el resultado a 0 por consistencia y estableciendo el error a 2.
