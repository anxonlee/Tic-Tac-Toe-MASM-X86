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
arr1d BYTE '1' , ' ' , '|' , ' ' , '2' , ' ' , '|' ,' ' ,'3',0dh, 0ah,0
arr2d BYTE '4' , ' ' , '|' , ' ' , '5' , ' ' , '|' ,' ' ,'6',0dh, 0ah,0
arr3d BYTE '7',  ' ' , '|' , ' ' , '8' , ' ' , '|' ,' ' ,'9',0dh, 0ah,0ah,0
err1 BYTE "Don't mess around! No Tic Tac Toe for you! "
punish BYTE "You entered an obtained number, your turn is skipped!",0dh, 0ah, 0ah,0
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

back:
mov esi, OFFSET arr1d
mov edi, OFFSET arr1
mov ecx, 9

cld

rep movsb;move string byte form esi to edi

mov esi, OFFSET arr2d
mov edi, OFFSET arr2
mov ecx, 9

cld

rep movsb;move string byte form esi to edi

mov esi, OFFSET arr3d
mov edi, OFFSET arr3
mov ecx, 9

cld

rep movsb;move string byte form esi to edi

mov ecx, 9


L13:
call DumpRegs
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
	mov edx,OFFSET punish
	call WriteString
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
jmp no1

next1:
cmp al,[arr1+8]
je who


no1:
mov al,[arr2]
cmp al,[arr2+4]
je next2
jmp no2


next2:
cmp al,[arr2+8]
je who


no2:
mov al,[arr3]
cmp al,[arr3+4]
je next3
jmp no3


next3:
cmp al,[arr3+8]
je who


no3:
mov al,[arr1]
cmp al,[arr2]
je next4
jmp no4


next4:
cmp al,[arr3]
je who


no4:
mov al,[arr1+4]
cmp al,[arr2+4]
je next5
jmp no5


next5:
cmp al,[arr3+4]
je who


no5:
mov al,[arr1+8]
cmp al,[arr2+8]
je next6
jmp no6


next6:
cmp al,[arr3+8]
je who


no6:
mov al,[arr1]
cmp al,[arr2+4]
je next7
jmp no7


next7:
cmp al,[arr3+8]
je who


no7:
mov al,[arr1+8]
cmp al,[arr2+4]
je next8
ret

next8:
cmp al,[arr3]
je who
ret


who:;determine if X or O wins
call BOARD
mov bl,1; bl is 1 when it is a winning condition
cmp al, 'O'
je Owin
mov edx, OFFSET player1win;if not equal, X wins
call WriteString
call readint
cmp al,0
je zero
inc X
mov ecx, 1
;jmp ended
mov bl,1
ret


Owin:
mov edx, OFFSET player2win
call WriteString
call readint
cmp al,0
je zero
inc O
mov ecx, 1
;jmp ended
ret


zero:
	invoke ExitProcess,0

WIN endp


TIE proc

cmp bl, 1; bl is 1 when it is a winning condition, and we do not do anything in the tie function
jz return
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

return:
ret

TIE endp

exit
main endp
end main



