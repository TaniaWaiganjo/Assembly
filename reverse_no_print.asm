section .data

array db 9,12,15,18,21,24,27
array_size = LENGTHOF array
   value db '  '; value to print. two spaces. the first space will be replaced by the value to print


section .text

    global _start

_start:

    mov eax, array_size
    ;when storing an array, there is an extra space at the end
    dec eax
    mov ebx, 0
    mov ecx, SIZEOF array
    mov edx, array
;ebx and eax keep track of indices of 2 elements to be swapped
    loop_start:
; cmp compares two operands
        cmp ebx, eax
; jge jump if greater
        jge loop_end

        ; Calculate addresses of elements to swap

        mov esi, edx ; currently, edx has array
        add esi, ebx ; add base address (0++)value to esi which has array
        mov esi, [esi] ;
        mov edi, edx
        add edi, eax ; array + array size 7
        mov edi, [edi]

        ; Swap elements
                ;7     , 
        mov [edx + ebx], edi ; moves edi into element at index ebi
        mov [edx + eax], esi
        inc ebx ; increasing counter
        dec eax ; decreasing array size so 7-1
        jmp loop_start ; continues the loop

;print reversed array

    

loop_end:
        mov	eax,1   ; system call to exit
        int 0x80