.global _start
_start:
    // Inputs: r0 = m, r1 = n
    // r4 = offset (bytes), r5 = computed target address for mov pc, r5

    mov r2, #0          // sum = 0
    mov r3, #4          // bytes-per-word = 4 
    mov r6, r0          // i = m

    // ----- CHECK -----
    cmp   r6, r1
    movle r4, #4        // if i <= n, jump to BODY
    movgt r4, #0x1C     // if i >  n, jump to EXIT
    mov   r5, pc        // r5 = PC + 8 (ARM pipeline behavior)
    add   r5, r5, r4
    mov   pc, r5

    // ----- BODY -----
    add   r2, r2, r6    // sum += i
    add   r6, r6, #1    // i++
    mov   r4, #-44      // jump back to CHECK (offset = -0x2C)
    mov   r5, pc        // r5 = PC + 8
    add   r5, r5, r4
    mov   pc, r5

    // ----- EXIT -----
    svc 2               // terminate 