
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h
jmp inizio
stringa1 dw "turno del primo giocatore: inserire un numero da 0 a 9:$"
stringa2 dw "turno del secondo giocatore: inserire un numero da 0 a 9:$" 
stringa3 dw "inserimento errato: inserire un numero:$"
stringa6 dw "il giocatore 1 (X) ha vinto!$"
stringa7 dw "il giocatore 2 (O) ha vinto!$"
stringa8 dw "pareggio!$"
turno db ?
numero db ?
totalegiocate db ?

inizio:
mov turno,1
call assegna
inizio2:
cmp totalegiocate,9
je finegioco
cmp turno,2
je giocatore2
cmp turno,1
je giocatore1
giocatore1:
    call acapo  
    call stampatris
    call acapo
    call acapo
    lea dx,stringa1
    mov ah,9
    int 21h 
    call input
    inc turno
    inc totalegiocate
    call inserimentotabellaX
    jmp inizio2
    
giocatore2:
    call acapo  
    call stampatris
    call acapo
    call acapo
    lea dx,stringa2
    mov ah,9
    int 21h 
    call input
    dec turno
    inc totalegiocate 
    call inserimentotabellaO
    jmp inizio2
    
finegioco:
call acapo
call stampatris
call acapo
call acapo
lea dx,stringa8
mov ah,9
int 21h
finegioco1: 
    

     
mov ah,4ch
int 21h
ret

input proc
    
    pusha
    jmp salta
    errato:
    call acapo
    lea dx,stringa3
    mov ah,9
    int 21h
    salta: 
    
    mov ah,1
    int 21h
    cmp al,"9"
    jnbe jmp errato
    cmp al,"0"
    mov cx,0
    jna jmp errato
    mov bx,0500h
    ciclo4:
        cmp al,[bx]
        je esci1
        inc cx
        inc bx
        cmp cx,9
        je esci
    jmp ciclo4
    esci:
    jmp errato
    esci1:

    mov numero,al
    
    
    
    popa
   
    ret 
input endp

stampatris proc
    
    pusha
    jmp inizio1
    stringa4 dw "|$"
    stringa5 dw "-----$" 
    inizio1:
    mov bx,0500h
    call acapo
    mov cl,2
    mov ch,3
    jmp ciclo1
    salta1:
    dec ch
    cmp ch,0
    je fine
    mov cl,2
    call acapo
    lea dx,stringa5
    mov ah,9
    int 21h
    call acapo
    
    ciclo1:
        mov dx,[bx]
        mov ah,6              
        int 21h
        inc bx
        cmp cl,0
        je salta1
        lea dx,stringa4
        mov ah,9
        int 21h
    loop ciclo1
    fine:    
    popa 
    ret
stampatris endp

acapo proc
pusha    
mov dl,13
mov ah,6
int 21h
mov dl,10
mov ah,6
int 21h
popa
ret
acapo endp

assegna proc
    pusha
    mov 0500h,31h
    mov 0501h,32h
    mov 0502h,33h
    mov 0503h,34h
    mov 0504h,35h
    mov 0505h,36h
    mov 0506h,37h
    mov 0507h,38h
    mov 0508h,39h
    popa
    ret
assegna endp

inserimentotabellaX proc
    pusha 
    
    mov bx,0500h
    mov al,numero
    ciclo3:
        cmp al,[bx]
        jne salto
        mov [bx],58h
        jmp fineins
        salto:
        inc bx
    jmp ciclo3
    fineins:
    call controllo 
    popa
    ret
inserimentotabellax endp

inserimentotabellaO proc
    pusha 
    
    mov bx,0500h
    mov al,numero
    ciclo5:
        cmp al,[bx]
        jne salto1
        mov [bx],4Fh
        jmp fineins2
        salto1:
        inc bx
    jmp ciclo5
    fineins2:
    call controllo 
    popa
    ret
inserimentotabellaO endp

controllo proc
    pusha
    mov bl,[0500h]
    cmp bl,[0501h]
    jne salto4
    cmp bl,[0502h]
    jne salto4
    cmp bl,"X"
    jne salto3
    call stampaX
    salto3:
    call stampaO
    salto4:
    
    cmp bl,[0503h]
    jne salto5
    cmp bl,[0506h]
    jne salto5
    cmp bl,"X"
    jne salto6
    call stampaX
    salto6:
    call stampaO
    salto5:
    
    cmp bl,[0504h]
    jne salto7
    cmp bl,[0508h]
    jne salto7
    cmp bl,"X"
    jne salto8
    call stampaX
    salto8:
    call stampaO
    salto7:
    
    mov bl,[0502h]
    cmp bl,[0505h]
    jne salto9
    cmp bl,[0508h]
    jne salto9
    cmp bl,"X"
    jne salto10
    call stampaX
    salto10:
    call stampaO
    salto9:
    
    cmp bl,[0504h]
    jne salto11
    cmp bl,[0506h]
    jne salto11
    cmp bl,"X"
    jne salto12
    call stampaX
    salto12:
    call stampaO
    salto11:
    
    mov bl,[0501h]
    cmp bl,[0504h]
    jne salto13
    cmp bl,[0507h]
    jne salto13
    cmp bl,"X"
    jne salto14
    call stampaX
    salto14:
    call stampaO
    salto13:
    
    mov bl,[0503h]
    cmp bl,[0504h]
    jne salto15
    cmp bl,[0505h]
    jne salto15
    cmp bl,"X"
    jne salto16
    call stampaX
    salto16:
    call stampaO
    salto15:
    
    mov bl,[0506h]
    cmp bl,[0507h]
    jne salto17
    cmp bl,[0508h]
    jne salto17
    cmp bl,"X"
    jne salto18
    call stampaX
    salto18:
    call stampaO
    salto17:
    
    popa
    ret
controllo endp
    
stampaX proc
    pusha
    call acapo
    call stampatris
    call acapo
    lea dx,stringa6
    mov ah,9
    int 21h
    jmp finegioco1
    popa
    ret
stampaX endp
stampaO proc
    pusha
    call acapo 
    call stampatris
    call acapo
    lea dx,stringa7
    mov ah,9
    int 21h
    jmp finegioco1
    ret
    popa
stampaO endp 