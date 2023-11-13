org 100h


.DATA
    numeros db 1, 2, 3, 4, 5, 6, 7, 8, 9
    numero db ?
    mensaje db "Ingrese el numero a buscar: ", "$"
    resultado db "El indice del valor ingresado es: ", "$"
    left db 0
    right db 8
    middle db ?
    value db ?


.CODE

MAIN:

    mov ax, numeros
    
    mov dx, offset mensaje
    mov ah, 9h
    int 21h
    
    mov ah, 01h
    int 21h
    sub al, '0'
    mov numero, al
    
    call BINARYSEARCH
    call PRINT
    

PRINT: 
    mov dl, 13
    mov ah, 2
    int 21h
    
    mov dl, 10
    mov ah, 2
    int 21h
    
    mov dx, offset resultado
    mov ah, 9h
    int 21h
     
    mov dl, middle
    add dl, '0'
    mov ah, 02h
    int 21h 
    
    mov ax, 4C00h
    int 21h
  

BINARYSEARCH PROC
    mov ax, 0
    mov bl, left
    mov bh, right
    
    
    SEARCHLOOP:
        cmp bl, bh
        jg SEARCHEND
        
        
        mov al, bh
        add al, bl
        mov cl, 2
        div cl
        
        
        mov cx, 0
        mov cl, numero
        
        mov ah, 0
        mov si, ax
        
        mov middle, al
        mov al, numeros[si]
        mov value, al
        
        
        cmp value, cl
        jne second

        jmp SEARCHEND
        
        second:
            cmp value, cl
            jg third
            
            mov dx, 0
            mov dl, middle
            inc dl
            mov bl, dl
            
            jmp SEARCHLOOP
        
        third:
            mov dx, 0
            mov dl, middle
            dec dl
            mov bh, dl
            
            jmp SEARCHLOOP
            
    SEARCHEND:
    RET

BINARYSEARCH ENDP

END MAIN
