.syntax unified
.cpu cortex-a7

.text
.global is_prime
is_prime:                   
    push {r4-r11, lr}       @prolog
    mov fp, sp
    sub sp, sp, #16         @making workspace, allocation for variables
    str r0, [sp, #4]        @value=r0 -> local 1
    mov r3, #0             	@count=0 -> local 2
    str r3, [sp, #8]        
    mov r3, #0             	@i=0 > local 3
    str r3, [sp, #12]       @===> b loop_check

loop_check:                 @for i<=value
    ldr r2, [sp, #4]
    ldr r3, [sp, #12]
    add r3, r3, #1
    str r3, [sp, #12]
    cmp r3, r2
    ble loop_do             @less then & eq
    ldr r3, [sp, #8]
    cmp r3, #2
    beq its_prime
    b its_not_prime

loop_do:                    @if value%i==0 count++
    ldr r1, [sp, #4]
    ldr r2, [sp, #12]
	@MODULO
	udiv r3, r1, r2			@udiv rT,rA,rB 		/* rT = rA / rB      (example: 1 = 17 / 10) */
	mls r3, r3,	r2, r1		@mls rT,rT,rB,rA 	/* rT = rA - rT * rB (example: 7 = 17 - (1 * 10)) */
    cmp r3, #0
    beq count
    b loop_check

count:                      @count++ --> loop_check
    ldr r3, [sp, #8]
    add r3, r3, #1
    str r3, [sp, #8]
    b loop_check
    
its_prime:                  @if prime => count == 2 { return 1 }
    mov r3, #1
    b end

its_not_prime:              @else { return 0 }
    mov r3, #0

end:                        @epilog & return
    mov r0, r3       
    mov sp, fp
    pop {r4-r11, pc}