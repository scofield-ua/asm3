.386
.model flat, stdcall
option casemap:none
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\user32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\user32.lib
N equ 5
.data
ifmt db '%d',0
stdout dd ?
cWritten dd ?
w db 'word',0
.data?
buf db N dup(?)
.code
start:
invoke GetStdHandle,STD_OUTPUT_HANDLE
mov eax,40 ; число
mov ecx,1
mov ah,N
nxt:
and ecx,00100000b
cmp ecx,0
jnz exit
mov stdout,eax
shl ecx,1
mov edx,0
mov ebx,ecx
div ebx
invoke wsprintf,ADDR buf,ADDR ifmt,eax
invoke WriteConsoleA,stdout,ADDR buf,N,ADDR cWritten,0
jmp nxt
exit:
invoke ExitProcess,0
end start
