.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
FindLargest proto aPtr:PTR SDWORD, arraySize:DWORD
INCLUDE Irvine32.inc

.data
tic BYTE "TIC TAC TOE GAME",0dh, 0ah, 0ah,0
player1ptr BYTE "PLAYER 1 (X): ",0
player2ptr BYTE "PLAYER 2 (O): ",0
arr1 BYTE '1' , ' ' , '|' , ' ' , '2' , ' ' , '|' ,' ' ,'3',0dh, 0ah,0
arr2 BYTE '4' , ' ' , '|' , ' ' , '5' , ' ' , '|' ,' ' ,'6',0dh, 0ah,0
arr3 BYTE '7',  ' ' , '|' , ' ' , '8' , ' ' , '|' ,' ' ,'9',0dh, 0ah,0ah,0
err1 BYTE "Don't mess around! No Tic Tak Toe for you... "
choice BYTE ?
player1 BYTE "PLAYER 1 (X) select your position (1-9) ",0dh, 0ah,0
player2 BYTE "Player 2 (O) select your position (1-9) ",0dh, 0ah,0
X DWORD 0
O DWORD 0
tieWord BYTE "TIE! (0 to end the program; any value to continue)",0dh, 0ah,0ah,0ah,0ah,0
player1win BYTE "PLAYER 1 (X) WINS! (0 to end the program; any value to continue)",0dh, 0ah,0ah,0ah,0ah,0
player2win BYTE "PLAYER 2 (O) WINS! (0 to end the program; any value to continue)",0dh, 0ah,0ah,0ah,0ah,0

info BYTE ?
turn BYTE 2

.code 
main PROC
;mov esi, OFFSET arr3
;mov ecx, 9
;push1:

;play
back:

L13:
call BOARD
call GAME
call WIN
call clrscr         
loop L13
call TIE
jmp back

BOARD proc


 mov edx,Offset tic
call WriteString


;TO DISPLAY PLAYER INFO
mov edx,OFFSET player1ptr
call WriteString
mov eax, X
call writeInt
call CRLF


mov edx,OFFSET player2ptr
call WriteString
mov eax, O
call writeInt
call CRLF
call CRLF


;LOOP TO DISPLAY FIRST ARRAY
mov edx,OFFSET arr1
call WriteString

;LOOP TO DISPLAY SECOND ARRAY
mov edx,OFFSET arr2
call WriteString


;LOOP TO DISPLAY THIRD ARRAY
mov edx,OFFSET arr3
call WriteString


ret
BOARD endp

GAME proc

mov ebx, ecx
and ebx, 1
jnz odd
jz eve

odd:
mov edx,OFFSET player1
mov bl,'X'
jmp skip

eve:
mov edx,OFFSET player2
mov bl, 'O'

skip:
call WriteString



call readint
jmp compare

invalid:
mov edx, OFFSET err1
call WriteString
invoke ExitProcess, 0 

compare:

cmp al,1
jb invalid
je one

cmp al,2
je two

cmp al,3
je three

cmp al,4
je four

cmp al,5
je five

cmp al,6
je six

cmp al,7
je seven

cmp al,8
je eight

cmp al,9
je nine
ja invalid


return:
	inc ecx
	ret

one:
	cmp [arr1], 'X'
	je return
	cmp [arr1], 'O'
	je return
xchg bl,[arr1]
ret

two:
	cmp [arr1+4], 'X'
	je return
	cmp [arr1+4], 'O'
	je return
xchg bl,[arr1+4]
ret

three:
	cmp [arr1+8], 'X'
	je return
	cmp [arr1+8], 'O'
	je return
xchg bl,[arr1+8]
ret

four:
	cmp [arr2], 'X'
	je return
	cmp [arr2], 'O'
	je return
xchg bl,[arr2]
ret

five:
	cmp [arr2+4], 'X'
	je return
	cmp [arr2+4], 'O'
	je return
xchg bl,[arr2+4]
ret

six:
	cmp [arr2+8], 'X'
	je return
	cmp [arr2+8], 'O'
	je return
xchg bl,[arr2+8]
ret

seven:
	cmp [arr3], 'X'
	je return
	cmp [arr3], 'O'
	je return
xchg bl,[arr3]
ret

eight:
	cmp [arr3+4], 'X'
	je return
	cmp [arr3+4], 'O'
	je return
xchg bl,[arr3+4]
ret

nine:
	cmp [arr3+8], 'X'
	je return
	cmp [arr3+8], 'O'
	je return
xchg bl,[arr3+8]
ret


GAME endp

WIN proc
mov al,[arr1]
cmp al,[arr1+4]
je next1
ret
next1:
cmp al,[arr1+8]
je who
ret

mov al,[arr2]
cmp al,[arr2+4]
je next2
ret

next2:
cmp al,[arr2+8]

call who
ret

mov al,[arr3]
cmp al,[arr3+4]
je next3
ret
next3:
cmp al,[arr3+8]
je who
ret

who:;determine if X or O wins
cmp al, 'O'
je Owin
mov edx, OFFSET player1win;if not equal, X wins
call WriteString
call readint
cmp al,0
je zero
inc X
mov ecx,0
ret

Owin:
mov edx, OFFSET player2win
call WriteString
call readint
cmp al,0
je zero
inc O
mov ecx,0
ret

zero:
	invoke ExitProcess,0

WIN endp


TIE proc

mov edx, OFFSET tieWord
call WriteString

call readint

cmp al,0
je zero

jmp skip

zero:
invoke ExitProcess,0

skip:
inc X;increase both player's point when tied
inc O
ret

TIE endp

exit
main endp
end main



