#include <stdio.h>
#include <stdlib.h>

// Estrutura para representar um par chave-valor
typedef struct {
    int size;   // Tamanho do segmento (chave)
    int start;  // Endereço inicial do segmento (valor)
} MemorySegment;

int main(int argc, char* argv[]) {
    if (argc < 3 || (argc % 2 != 0)) {
        printf("Uso: %s <tamanho_do_programa> <inicio1> <tamanho1> <inicio2> <tamanho2> ...\n", argv[0]);
        return 1;
    }

    // Tamanho do programa
    int program_size = atoi(argv[1]);
    printf("Tamanho do programa: %d\n", program_size);

    // Número de pares de segmentos de memória
    int num_segments = (argc - 2) / 2;

    // Aloca memória para o map
    MemorySegment* map = (MemorySegment*)malloc(num_segments * sizeof(MemorySegment));
    if (map == NULL) {
        printf("Erro ao alocar memória para o map.\n");
        return 1;
    }

    // Preenche o map com os pares chave-valor
    for (int i = 0; i < num_segments; i++) {
        map[i].start = atoi(argv[2 + 2 * i]);       // Endereço inicial
        map[i].size = atoi(argv[2 + 2 * i + 1]);    // Tamanho do segmento
    }

    // Exibe o map
    printf("Map de segmentos de memória:\n");
    for (int i = 0; i < num_segments; i++) {
        printf("Tamanho: %d -> Endereço inicial: %d\n", map[i].size, map[i].start);
    }

    // Libera a memória alocada para o map
    free(map);

    return 0;
}