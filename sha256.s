.LC0: @Location Counter 0
  .ascii "RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR"    .ascii "RRRRRRRRRRjjjjjjjjjjjjjjjjjjj\000" @texto que se convertirá a sha256  
 


msg:
  .word .LC0  @Inicializa la variable msg contenida en LC0
.LC1:
  .ascii "Message: %s\012SHA-256 hash: \000"
.LC2:
  .ascii "%08x \000"
main:
  push {r4, fp, lr}  
  add fp, sp, #8
  sub sp, sp, #52
  str r0, [fp, #-56]  
  str r1, [fp, #-60] @Encabezado del main, recibe parametros
  ldr r3, .L5
  ldr r4, [r3]
  ldr r3, .L5
  ldr r3, [r3]
  mov r0, r3
  bl strlen
  mov r2, r0
  sub r3, fp, #48
  mov r1, r4
  mov r0, r3
  bl sha256_hash @llamada al metodo sha256 y envio de parametros
  ldr r3, .L5
  ldr r3, [r3]
  mov r1, r3
  ldr r0, .L5+4
  bl printf @llamado al metodo para imprimir
  mov r3, #0 
  str r3, [fp, #-16]
  b .L2 @for de 0-7 para imprimir el mensaje en el arreglo
.L3: @imprimir 
  ldr r3, [fp, #-16] 
  lsl r3, r3, #2
  sub r2, fp, #12
  add r3, r2, r3
  ldr r3, [r3, #-36]
  mov r1, r3
  ldr r0, .L5+4
  bl printf @imprime el arreglo de hash
  ldr r3, [fp, #-16]
  add r3, r3, #1
  str r3, [fp, #-16] @for de 0-7 para imprimir el mensaje en el arreglo
.L2:
  ldr r3, [fp, #-16]
  cmp r3, #7
  ble .L3 @for de 0-7 para imprimir el mensaje en el arreglo
  mov r0, #10 
  bl putchar @salto de linea
  mov r3, #0 @ retornar 0
  mov r0, r3
  sub sp, fp, #8
  pop {r4, fp, lr}
  bx lr @parte o fin del metodo main
.L5:
  .word msg @ inicializa el mensaje
  .word .LC1 @ 
  .word .LC2 @
K:  @ bloque arreglo K de constantes 
  .word 1116352408 
  .word 1899447441 
  .word -1245643825 
  .word -373957723 
  .word 961987163 
  .word 1508970993 
  .word -1841331548 
  .word -1424204075
  .word -670586216
  .word 310598401
  .word 607225278
  .word 1426881987
  .word 1925078388
  .word -2132889090
  .word -1680079193
  .word -1046744716
  .word -459576895
  .word -272742522
  .word 264347078
  .word 604807628
  .word 770255983
  .word 1249150122
  .word 1555081692
  .word 1996064986
  .word -1740746414
  .word -1473132947
  .word -1341970488
  .word -1084653625
  .word -958395405
  .word -710438585
  .word 113926993
  .word 338241895
  .word 666307205
  .word 773529912
  .word 1294757372
  .word 1396182291
  .word 1695183700
  .word 1986661051
  .word -2117940946
  .word -1838011259
  .word -1564481375
  .word -1474664885
  .word -1035236496
  .word -949202525
  .word -778901479
  .word -694614492
  .word -200395387
  .word 275423344
  .word 430227734
  .word 506948616
  .word 659060556
  .word 883997877
  .word 958139571
  .word 1322822218
  .word 1537002063
  .word 1747873779
  .word 1955562222
  .word 2024104815
  .word -2067236844
  .word -1933114872
  .word -1866530822
  .word -1538233109
  .word -1090935817
  .word -965641998
init_hash:
  str fp, [sp, #-4]!
  add fp, sp, #0
  sub sp, sp, #12
  str r0, [fp, #-8] @metodo y parametros init_hash 
  ldr r3, [fp, #-8]
  ldr r2, .L8
  str r2, [r3] @arreglo hash[0]
  ldr r3, [fp, #-8]
  add r3, r3, #4
  ldr r2, .L8+4
  str r2, [r3] @arreglo hash[1]
  ldr r3, [fp, #-8]
  add r3, r3, #8
  ldr r2, .L8+8
  str r2, [r3] @arreglo hash[2]
  ldr r3, [fp, #-8]
  add r3, r3, #12
  ldr r2, .L8+12
  str r2, [r3] @arreglo hash[3]
  ldr r3, [fp, #-8]
  add r3, r3, #16
  ldr r2, .L8+16
  str r2, [r3] @arreglo hash[4]
  ldr r3, [fp, #-8]
  add r3, r3, #20
  ldr r2, .L8+20
  str r2, [r3] @arreglo hash[5]
  ldr r3, [fp, #-8]
  add r3, r3, #24
  ldr r2, .L8+24
  str r2, [r3] @arreglo hash[6]
  ldr r3, [fp, #-8]
  add r3, r3, #28
  ldr r2, .L8+28
  str r2, [r3] @arreglo hash[7]
  nop
  add sp, fp, #0
  ldr fp, [sp], #4
  bx lr @metodo init_hash
.L8: @ contenido del arreglo
  .word 1779033703
  .word -1150833019
  .word 1013904242
  .word -1521486534
  .word 1359893119
  .word -1694144372
  .word 528734635
  .word 1541459225
pad_msg: @metodo y recibe parametros
  push {r4, r5, r6, r7, r8, r9, r10, fp, lr}
  add fp, sp, #32
  sub sp, sp, #124
  str r0, [fp, #-96]
  str r1, [fp, #-100]
  str r2, [fp, #-104] @metodo y recibe parametros
  ldmib fp, {r3-r4} 
  str r3, [fp, #-60]
  str r4, [fp, #-56] @variable  uint64_t num_bytes = length
  ldmib fp, {r3-r4}
  lsl r6, r4, #3
  orr r6, r6, r3, lsr #29
  lsl r5, r3, #3
  str r5, [fp, #-68]
  str r6, [fp, #-64] @variable  uint64_t num_bits = length * 8;
  sub r2, fp, #60
  ldmia r2, {r1-r2}
  mov r3, #63
  mov r4, #0
  and r3, r3, r1
  and r4, r4, r2
  cmp r4, #0
  cmpeq r3, #55
  bls .L11 @if(num_bytes % BYTES_PER_BLOCK >= 56)
  sub r4, fp, #60
  ldmia r4, {r3-r4}
  adds r3, r3, #64
  adc r4, r4, #0
  str r3, [fp, #-60]
  str r4, [fp, #-56] @ dentro del if
.L11:
  sub r2, fp, #60
  ldmia r2, {r1-r2}
  mvn r3, #63
  mvn r4, #0
  and r3, r3, r1
  and r4, r4, r2
  adds r3, r3, #64
  adc r4, r4, #0
  str r3, [fp, #-60]
  str r4, [fp, #-56] @num_bytes +=
  sub r4, fp, #60
  ldmia r4, {r3-r4}
  lsr r7, r3, #6
  orr r7, r7, r4, lsl #26
  lsr r8, r4, #6
  ldr r3, [fp, #-100]
  stm r3, {r7-r8} @*num_block
  ldr r3, [fp, #-100]
  ldmia r3, {r3-r4}
  mov r1, #64
  mov r0, r3
  bl calloc
  mov r3, r0
  mov r2, r3
  ldr r3, [fp, #-96]
  str r2, [r3] @*blocks = calloc
  ldr r3, [fp, #-60]
  mov r1, #1
  mov r0, r3
  bl calloc
  mov r3, r0
  str r3, [fp, #-72] @ pmsg = calloc
  ldr r3, [fp, #4]
  mov r2, r3
  ldr r1, [fp, #-104]
  ldr r0, [fp, #-72]
  bl memcpy @ llamado al metodo y envio de parametros
  ldr r2, [fp, #4]
  ldr r3, [fp, #-72]
  add r2, r3, r2
  mvn r3, #127
  strb r3, [r2] @ arreglo pmsg[length] = 0x80;
  ldr r3, [fp, #-60]
  sub r2, r3, #8
  ldr r3, [fp, #-72]
  add r2, r3, r2
  sub r4, fp, #68
  ldmia r4, {r3-r4}
  lsr r3, r4, #24
  str r3, [fp, #-132]
  mov r3, #0
  str r3, [fp, #-128]
  ldr r3, [fp, #-132]
  and r3, r3, #255
  strb r3, [r2]
  ldr r3, [fp, #-60]
  sub r3, r3, #7
  ldr r2, [fp, #-72]
  add r2, r2, r3
  sub r4, fp, #68
  ldmia r4, {r3-r4}
  lsr r3, r4, #16
  str r3, [fp, #-140]
  mov r3, #0
  str r3, [fp, #-136]
  ldr r3, [fp, #-140]
  and r3, r3, #255
  strb r3, [r2]
  ldr r3, [fp, #-60]
  sub r3, r3, #6
  ldr r2, [fp, #-72]
  add r2, r2, r3
  sub r4, fp, #68
  ldmia r4, {r3-r4}
  lsr r3, r4, #8
  str r3, [fp, #-148]
  mov r3, #0
  str r3, [fp, #-144]
  ldr r3, [fp, #-148]
  and r3, r3, #255
  strb r3, [r2]
  ldr r3, [fp, #-60]
  sub r3, r3, #5
  ldr r2, [fp, #-72]
  add r2, r2, r3
  sub r4, fp, #68
  ldmia r4, {r3-r4}
  mov r3, r4
  str r3, [fp, #-156]
  mov r3, #0
  str r3, [fp, #-152]
  ldr r3, [fp, #-156]
  and r3, r3, #255
  strb r3, [r2]
  ldr r3, [fp, #-60]
  sub r3, r3, #4
  ldr r2, [fp, #-72]
  add r2, r2, r3
  sub r4, fp, #68
  ldmia r4, {r3-r4}
  lsr r1, r3, #24
  str r1, [fp, #-116]
  ldr r1, [fp, #-116]
  orr r1, r1, r4, lsl #8
  str r1, [fp, #-116]
  lsr r3, r4, #24
  str r3, [fp, #-112]
  ldr r3, [fp, #-116]
  and r3, r3, #255
  strb r3, [r2]
  ldr r3, [fp, #-60]
  sub r3, r3, #3
  ldr r2, [fp, #-72]
  add r2, r2, r3
  sub r4, fp, #68
  ldmia r4, {r3-r4}
  lsr r1, r3, #16
  str r1, [fp, #-124]
  ldr r1, [fp, #-124]
  orr r1, r1, r4, lsl #16
  str r1, [fp, #-124]
  lsr r3, r4, #16
  str r3, [fp, #-120]
  ldr r3, [fp, #-124]
  and r3, r3, #255
  strb r3, [r2]
  ldr r3, [fp, #-60]
  sub r3, r3, #2
  ldr r2, [fp, #-72]
  add r2, r2, r3
  sub r4, fp, #68
  ldmia r4, {r3-r4}
  lsr r9, r3, #8
  orr r9, r9, r4, lsl #24
  lsr r10, r4, #8
  and r3, r9, #255
  strb r3, [r2]
  ldr r3, [fp, #-60]
  sub r3, r3, #1
  ldr r2, [fp, #-72]
  add r3, r2, r3
  ldrb r2, [fp, #-68] @ zero_extendqisi2
  strb r2, [r3]
  mov r3, #0
  mov r4, #0
  str r3, [fp, #-44]
  str r4, [fp, #-40]
  b .L12
.L15:
  mov r3, #0
  mov r4, #0
  str r3, [fp, #-52]
  str r4, [fp, #-48]
  b .L13
.L14:
  ldr r3, [fp, #-44]
  lsl r2, r3, #4
  ldr r3, [fp, #-52]
  add r3, r2, r3
  lsl r3, r3, #2
  ldr r2, [fp, #-72]
  add r3, r2, r3
  ldrb r3, [r3] @ zero_extendqisi2
  str r3, [fp, #-76]
  ldr r3, [fp, #-44]
  lsl r2, r3, #4
  ldr r3, [fp, #-52]
  add r3, r2, r3
  lsl r3, r3, #2
  add r3, r3, #1
  ldr r2, [fp, #-72]
  add r3, r2, r3
  ldrb r3, [r3] @ zero_extendqisi2
  str r3, [fp, #-80]
  ldr r3, [fp, #-44]
  lsl r2, r3, #4
  ldr r3, [fp, #-52]
  add r3, r2, r3
  lsl r3, r3, #2
  add r3, r3, #2
  ldr r2, [fp, #-72]
  add r3, r2, r3
  ldrb r3, [r3] @ zero_extendqisi2
  str r3, [fp, #-84]
  ldr r3, [fp, #-44]
  lsl r2, r3, #4
  ldr r3, [fp, #-52]
  add r3, r2, r3
  lsl r3, r3, #2
  add r3, r3, #3
  ldr r2, [fp, #-72]
  add r3, r2, r3
  ldrb r3, [r3] @ zero_extendqisi2
  str r3, [fp, #-88]
  ldr r3, [fp, #-96]
  ldr r2, [r3]
  ldr r3, [fp, #-44]
  lsl r3, r3, #6
  add r3, r2, r3
  ldr r2, [fp, #-76]
  lsl r1, r2, #24
  ldr r2, [fp, #-80]
  lsl r2, r2, #16
  orr r1, r1, r2
  ldr r2, [fp, #-84]
  lsl r2, r2, #8
  orr r1, r1, r2
  ldr r2, [fp, #-88]
  orr r1, r1, r2
  ldr r2, [fp, #-52]
  str r1, [r3, r2, lsl #2]
  sub r4, fp, #52
  ldmia r4, {r3-r4}
  adds r3, r3, #1
  adc r4, r4, #0
  str r3, [fp, #-52]
  str r4, [fp, #-48]
.L13:
  sub r4, fp, #52
  ldmia r4, {r3-r4}
  cmp r4, #0
  cmpeq r3, #15
  bls .L14
  sub r4, fp, #44
  ldmia r4, {r3-r4}
  adds r3, r3, #1
  adc r4, r4, #0
  str r3, [fp, #-44]
  str r4, [fp, #-40]
.L12:
  ldr r3, [fp, #-100]
  ldmia r3, {r1-r2}
  sub r4, fp, #44
  ldmia r4, {r3-r4}
  cmp r2, r4
  cmpeq r1, r3
  bhi .L15
  ldr r0, [fp, #-72]
  bl free
  nop
  sub sp, fp, #32
  pop {r4, r5, r6, r7, r8, r9, r10, fp, lr}
  bx lr
expand_blocks:
  str fp, [sp, #-4]!
  add fp, sp, #0
  sub sp, sp, #20
  str r0, [fp, #-16]
  str r1, [fp, #-20]
  mov r3, #0
  str r3, [fp, #-8]
  b .L17
.L20:
  ldr r3, [fp, #-8]
  cmp r3, #15
                                                                                                                                                                                                                                                                                                                 .L18
  ldr r3, [fp, #-8]
  lsl r3, r3, #2
  ldr r2, [fp, #-20]
  add r3, r2, r3
  ldr r2, [fp, #-16]
  ldr r1, [fp, #-8]
  ldr r2, [r2, r1, lsl #2]
  str r2, [r3]
  b .L19
.L18:
  ldr r3, [fp, #-8]
  lsl r3, r3, #2
  ldr r2, [fp, #-20]
  add r3, r2, r3
  ldr r2, [fp, #-8]
  sub r2, r2, #-1073741822
  lsl r2, r2, #2
  ldr r1, [fp, #-20]
  add r2, r1, r2
  ldr r2, [r2]
  ror r1, r2, #17
  ldr r2, [fp, #-8]
  sub r2, r2, #-1073741822
  lsl r2, r2, #2
  ldr r0, [fp, #-20]
  add r2, r0, r2
  ldr r2, [r2]
  ror r2, r2, #19
  eor r1, r1, r2
  ldr r2, [fp, #-8]
  sub r2, r2, #-1073741822
  lsl r2, r2, #2
  ldr r0, [fp, #-20]
  add r2, r0, r2
  ldr r2, [r2]
  lsr r2, r2, #10
  eor r1, r1, r2
  ldr r2, [fp, #-8]
  sub r2, r2, #-1073741817
  lsl r2, r2, #2
  ldr r0, [fp, #-20]
  add r2, r0, r2
  ldr r2, [r2]
  add r1, r1, r2
  ldr r2, [fp, #-8]
  sub r2, r2, #-1073741809
  lsl r2, r2, #2
  ldr r0, [fp, #-20]
  add r2, r0, r2
  ldr r2, [r2]
  ror r0, r2, #7
  ldr r2, [fp, #-8]
  sub r2, r2, #-1073741809
  lsl r2, r2, #2
  ldr ip, [fp, #-20]
  add r2, ip, r2
  ldr r2, [r2]
  ror r2, r2, #18
  eor r0, r0, r2
  ldr r2, [fp, #-8]
  sub r2, r2, #-1073741809
  lsl r2, r2, #2
  ldr ip, [fp, #-20]
  add r2, ip, r2
  ldr r2, [r2]
  lsr r2, r2, #3
  eor r2, r2, r0
  add r1, r1, r2
  ldr r2, [fp, #-8]
  sub r2, r2, #-1073741808
  lsl r2, r2, #2
  ldr r0, [fp, #-20]
  add r2, r0, r2
  ldr r2, [r2]
  add r2, r1, r2
  str r2, [r3]
.L19:
  ldr r3, [fp, #-8]
  add r3, r3, #1
  str r3, [fp, #-8]
.L17:
  ldr r3, [fp, #-8]
  cmp r3, #63
  ble .L20
  nop
  add sp, fp, #0
  ldr fp, [sp], #4
  bx lr
sha256_hash:
  push {r4, fp, lr}
  add fp, sp, #8
  sub sp, sp, #348
  str r0, [fp, #-336]
  str r1, [fp, #-340]
  str r2, [fp, #-348]
  str r3, [fp, #-344]
  sub r3, fp, #332
  mov r2, #256
  mov r1, #0
  mov r0, r3
  bl memset
  ldr r0, [fp, #-336]
  bl init_hash
  sub r1, fp, #76
  sub r0, fp, #64
  sub r4, fp, #348
  ldmia r4, {r3-r4}
  stm sp, {r3-r4}
  ldr r2, [fp, #-340]
  bl pad_msg
  mov r3, #1
  str r3, [fp, #-48]
  b .L22
.L25:
  ldr r3, [fp, #-336]
  ldr r3, [r3]
  str r3, [fp, #-16]
  ldr r3, [fp, #-336]
  ldr r3, [r3, #4]
  str r3, [fp, #-20]
  ldr r3, [fp, #-336]
  ldr r3, [r3, #8]
  str r3, [fp, #-24]
  ldr r3, [fp, #-336]
  ldr r3, [r3, #12]
  str r3, [fp, #-28]
  ldr r3, [fp, #-336]
  ldr r3, [r3, #16]
  str r3, [fp, #-32]
  ldr r3, [fp, #-336]
  ldr r3, [r3, #20]
  str r3, [fp, #-36]
  ldr r3, [fp, #-336]
  ldr r3, [r3, #24]
  str r3, [fp, #-40]
  ldr r3, [fp, #-336]
  ldr r3, [r3, #28]
  str r3, [fp, #-44]
  ldr r2, [fp, #-64]
  ldr r3, [fp, #-48]
  sub r3, r3, #-67108863
  lsl r3, r3, #6
  add r3, r2, r3
  sub r2, fp, #332
  mov r1, r2
  mov r0, r3
  bl expand_blocks
  mov r3, #0
  str r3, [fp, #-52]
  b .L23
.L24:
  ldr r3, [fp, #-32]
  ror r2, r3, #6
  ldr r3, [fp, #-32]
  ror r3, r3, #11
  eor r2, r2, r3
  ldr r3, [fp, #-32]
  ror r3, r3, #25
  eor r2, r2, r3
  ldr r3, [fp, #-44]
  add r2, r2, r3
  ldr r1, [fp, #-32]
  ldr r3, [fp, #-36]
  and r1, r1, r3
  ldr r3, [fp, #-32]
  mvn r0, r3
  ldr r3, [fp, #-40]
  and r3, r3, r0
  eor r3, r3, r1
  add r2, r2, r3
  ldr r1, .L26
  ldr r3, [fp, #-52]
  ldr r3, [r1, r3, lsl #2]
  add r2, r2, r3
  ldr r3, [fp, #-52]
  lsl r3, r3, #2
  sub r1, fp, #12
  add r3, r1, r3
  ldr r3, [r3, #-320]
  add r3, r2, r3
  str r3, [fp, #-56]
  ldr r3, [fp, #-16]
  ror r2, r3, #2
  ldr r3, [fp, #-16]
  ror r3, r3, #13
  eor r2, r2, r3
  ldr r3, [fp, #-16]
  ror r3, r3, #22
  eor r2, r2, r3
  ldr r1, [fp, #-16]
  ldr r3, [fp, #-20]
  and r1, r1, r3
  ldr r0, [fp, #-16]
  ldr r3, [fp, #-24]
  and r3, r3, r0
  eor r1, r1, r3
  ldr r0, [fp, #-20]
  ldr r3, [fp, #-24]
  and r3, r3, r0
  eor r3, r3, r1
  add r3, r2, r3
  str r3, [fp, #-60]
  ldr r3, [fp, #-40]
  str r3, [fp, #-44]
  ldr r3, [fp, #-36]
  str r3, [fp, #-40]
  ldr r3, [fp, #-32]
  str r3, [fp, #-36]
  ldr r2, [fp, #-28]
  ldr r3, [fp, #-56]
  add r3, r2, r3
  str r3, [fp, #-32]
  ldr r3, [fp, #-24]
  str r3, [fp, #-28]
  ldr r3, [fp, #-20]
  str r3, [fp, #-24]
  ldr r3, [fp, #-16]
  str r3, [fp, #-20]
  ldr r2, [fp, #-56]
  ldr r3, [fp, #-60]
  add r3, r2, r3
  str r3, [fp, #-16]
  ldr r3, [fp, #-52]
  add r3, r3, #1
  str r3, [fp, #-52]
.L23:
  ldr r3, [fp, #-52]
  cmp r3, #63
  ble .L24
  ldr r3, [fp, #-336]
  ldr r2, [r3]
  ldr r3, [fp, #-16]
  add r2, r2, r3
  ldr r3, [fp, #-336]
  str r2, [r3]
  ldr r3, [fp, #-336]
  add r3, r3, #4
  ldr r2, [fp, #-336]
  add r2, r2, #4
  ldr r1, [r2]
  ldr r2, [fp, #-20]
  add r2, r1, r2
  str r2, [r3]
  ldr r3, [fp, #-336]
  add r3, r3, #8
  ldr r2, [fp, #-336]
  add r2, r2, #8
  ldr r1, [r2]
  ldr r2, [fp, #-24]
  add r2, r1, r2
  str r2, [r3]
  ldr r3, [fp, #-336]
  add r3, r3, #12
  ldr r2, [fp, #-336]
  add r2, r2, #12
  ldr r1, [r2]
  ldr r2, [fp, #-28]
  add r2, r1, r2
  str r2, [r3]
  ldr r3, [fp, #-336]
  add r3, r3, #16
  ldr r2, [fp, #-336]
  add r2, r2, #16
  ldr r1, [r2]
  ldr r2, [fp, #-32]
  add r2, r1, r2
  str r2, [r3]
  ldr r3, [fp, #-336]
  add r3, r3, #20
  ldr r2, [fp, #-336]
  add r2, r2, #20
  ldr r1, [r2]
  ldr r2, [fp, #-36]
  add r2, r1, r2
  str r2, [r3]
  ldr r3, [fp, #-336]
  add r3, r3, #24
  ldr r2, [fp, #-336]
  add r2, r2, #24
  ldr r1, [r2]
  ldr r2, [fp, #-40]
  add r2, r1, r2
  str r2, [r3]
  ldr r3, [fp, #-336]
  add r3, r3, #28
  ldr r2, [fp, #-336]
  add r2, r2, #28
  ldr r1, [r2]
  ldr r2, [fp, #-44]
  add r2, r1, r2
  str r2, [r3]
  ldr r3, [fp, #-48]
  add r3, r3, #1
  str r3, [fp, #-48]
.L22:
  ldr r3, [fp, #-48]
  mov r1, r3
  asr r2, r1, #31
  sub r4, fp, #76
  ldmia r4, {r3-r4}
  cmp r2, r4
  cmpeq r1, r3
  bls .L25
  ldr r3, [fp, #-64]
  mov r0, r3
  bl free
  nop
  sub sp, fp, #8
  pop {r4, fp, lr}
  bx lr
.L26:
  .word K3
