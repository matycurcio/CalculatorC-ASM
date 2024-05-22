#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdbool.h>

void LeerPregunta(char *pregunta);
int CalcularOperacion(int operando1, char operador, int operando2);
void RespuestaError();
bool CheckOperador(char *token);
bool CheckOperacionCompleta(int operando1, char operador, int operando2);

extern int recibir_Operacion(int operando1, char operador, int operando2);

int main(){

	char pregunta[100];  // Declaración de la variable pregunta
	int error=0;
	
	while(1){
		LeerPregunta(pregunta);
			
		//Separo la pregunta en tokens con strtok (los separo según los espacios)
				
		char *token = strtok(pregunta, " ");	
		if (token == NULL) {
		    RespuestaError();
		    continue;
		}
		
		int operando1;
		if (sscanf(token, "%d", &operando1) != 1) {
		    RespuestaError();
		    continue;
		}
		
		token = strtok(NULL, " ");
		if (token == NULL) {
		    RespuestaError();
		    continue;
		}
		     	
		char operador = token[0];

		token = strtok(NULL, " ");
		if (token == NULL) {
		    RespuestaError();
		    continue;
		}
		
		int operando2;
		if (sscanf(token, "%d", &operando2) != 1) {
		    RespuestaError();
		    continue;
		}

		if (CheckOperador(&operador)) {
		    RespuestaError();
		    continue;
		}
		
		int resultado = recibir_Operacion(operando1, operador, operando2);
		
		printf("Primer op: %d\n", operando1);
		printf("Segundo op: %d\n", operando2);
		printf("Operador: %d\n", operador);
		printf("Resultado: %d\n", resultado);
	}
	
}

void LeerPregunta(char *pregunta) {
	printf("Ingrese su operación (por ejemplo, 10 + 10): ");
	fgets(pregunta, 100, stdin);

	// Eliminar el salto de línea si existe
	size_t len = strlen(pregunta);
		if (len > 0 && pregunta[len - 1] == '\n') {
			pregunta[len - 1] = '\0';
		}
}

void RespuestaError() {
	printf("Lo siento, mis respuestas son limitadas.\n");
}
	
bool CheckOperador(char *token) {
    if (token == NULL || (token[0] != '+' && token[0] != '-' && token[0] != '*' && token[0] != '/')) {
        return true;
    }
    return false;
}











