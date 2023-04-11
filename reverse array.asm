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
        jge array_printing

        ; Calculate addresses of elements to swap

        mov esi, edx ; currently, edx has array
        add esi, ebx ; add base address (0++)value to esi which has array
        mov esi, [esi] ;
        mov edi, edx
        add edi, eax
        mov edi, [edi]

        ; Swap elements

        mov [edx + ebx], edi
        mov [edx + eax], esi
        inc ebx ; increasing counter
        dec eax ; decreasing array size so 7-1
        jmp loop_start ; continues the loop

;mov ecx, 7; exc data registers, general registers has ch cl
;mov edi,array; address of array

;print reversed array
array_printing:
   ;edi, esi destination/source index , index registers is used to keep track of the array item positions
   mov esi, ecx ;save ecx so we can use it for output
   mov cl, [edi] ;array item to print in edi
   add cl, '0' ;to ASCII - changes item in register
   mov [value], cl ; store ascii code to print in first byte of value. Second byte has space
   mov ecx, value ; address of value to print. the value and the space
   ;message length 
   mov	edx,2
   mov	ebx,1       ;file descriptor (stdout)
   mov	eax,4       ;system call number (sys_write)
   int	0x80        ;call kernel
   mov ecx, esi ;reset ecx to be used for printing loop
   inc edi ; go to next item of the array
   loop array_printing
   jmp loop_end
    

loop_end:
        mov	eax,1   ; system call to exit
        int 0x80