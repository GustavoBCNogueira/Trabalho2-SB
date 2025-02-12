#include <stdio.h>

int main(int argc, char* argv[]) {
    int program_size = atoi(argv[1]);
    printf("tamanho do programa: %d\n", program_size);
    for (int i = 2; i < argc; i+=2) 
        printf("espaços disponíveis na memória: %s %s\n", argv[i], argv[i+1]);
    return 0;
}