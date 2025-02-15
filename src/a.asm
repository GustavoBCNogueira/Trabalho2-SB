section .data
    ; Buffer para armazenar o valor de retorno como string
    buffer db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  ; 10 bytes para armazenar um número
    newline db 10                           ; Caractere de nova linha (\n)

section .text
    global _start

_start:
    ; Exemplo de uso da função
    push 1000       ; Argumento 3
    push 125        ; Argumento 2
    push 300        ; Argumento 1
    push 1425       ; Número a ser verificado
    call verifica_menor_soma
    add esp, 16     ; Limpa a pilha (4 argumentos * 4 bytes cada)

    ; Agora, eax contém o valor de retorno (0 ou 1)
    ; Vamos convertê-lo para uma string ASCII
    call int_to_string

    ; Imprimir o valor de retorno
    mov eax, 4              ; Syscall para write
    mov ebx, 1              ; File descriptor 1 (stdout)
    lea ecx, [buffer]       ; Endereço do buffer
    mov edx, 1              ; Número de bytes a serem escritos (1 byte para '0' ou '1')
    int 0x80                ; Chamada do sistema

    ; Imprimir uma nova linha
    mov eax, 4              ; Syscall para write
    mov ebx, 1              ; File descriptor 1 (stdout)
    lea ecx, [newline]      ; Endereço do caractere de nova linha
    mov edx, 1              ; Número de bytes a serem escritos (1 byte para '\n')
    int 0x80                ; Chamada do sistema

    ; Fim do programa
    mov eax, 1              ; Syscall para exit
    xor ebx, ebx            ; Código de saída 0
    int 0x80                ; Chamada do sistema

verifica_menor_soma:
    ; Prologue
    push ebp
    mov ebp, esp

    ; Argumentos:
    ; [ebp+8]  -> Número a ser verificado
    ; [ebp+12] -> Argumento 1
    ; [ebp+16] -> Argumento 2
    ; [ebp+20] -> Argumento 3

    ; Inicializa a soma com 0
    xor eax, eax

    ; Soma os argumentos seguintes
    add eax, [ebp+12]     ; Soma o primeiro argumento
    add eax, [ebp+16]     ; Soma o segundo argumento
    add eax, [ebp+20]     ; Soma o terceiro argumento

    ; Compara o número com a soma
    mov edx, [ebp+8]      ; Carrega o número a ser verificado
    cmp edx, eax          ; Compara o número com a soma
    jle menor             ; Se for menor ou igual, pula para 'menor'

    ; Se não for menor ou igual
    xor eax, eax          ; Retorna 0
    jmp fim

menor:
    mov eax, 1            ; Retorna 1

fim:
    ; Epilogue
    mov esp, ebp
    pop ebp
    ret

int_to_string:
    ; Converte o valor em eax para uma string ASCII
    ; O resultado será armazenado no buffer
    add eax, '0'          ; Converte o número (0 ou 1) para seu caractere ASCII
    mov [buffer], al      ; Armazena o caractere no buffer
    ret