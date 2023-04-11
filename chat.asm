section .data
    array db 1, 2, 3, 4, 5, 6, 7
    array_size equ 7
    newline db 10
    newline_len equ 1

section .text
    global _start

_start:
    ; Reverse the array in-place
    mov ecx, array_size       ; counter for the loop
    mov ebx, 0                ; index of first element
    mov edx, array_size - 1   ; index of last element
    
    reverse_loop:
        cmp ebx, edx         ; check if we've swapped all the elements
        jge print_array      ; if so, print the new array and exit
        mov al, [array + ebx] ; get the element at index ebx
        xchg al, [array + edx] ; swap it with the element at index edx
        mov [array + ebx], al ; put the swapped element back at index ebx
        inc ebx              ; move to the next element
        dec edx              ; move to the previous element
        loop reverse_loop    ; loop until all elements have been swapped

    ; Print the new array
    print_array:
        mov ecx, array_size    ; counter for the loop
        mov ebx, 0             ; index of first element
    print_loop:
        mov al, [array + ebx]  ; get the element at index ebx
        mov edx, 1             ; length of the string to print
        mov ecx, array + ebx   ; address of the string to print
        mov ebx, 1             ; file descriptor (stdout)
        int 0x80               ; call the write system call
        mov edx, newline_len   ; length of the newline string to print
        mov ecx, newline       ; address of the newline string to print
        mov ebx, 1             ; file descriptor (stdout)
        int 0x80               ; call the write system call
        inc ebx                ; move to the next element
        loop print_loop        ; loop until all elements have been printed

    ; Exit the program
    mov eax, 1                ; system call for exit
    xor ebx, ebx              ; return code (0)
    int 0x80                  ; call the system call
