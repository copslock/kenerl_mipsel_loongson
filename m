Received:  by oss.sgi.com id <S553778AbQJZDCP>;
	Wed, 25 Oct 2000 20:02:15 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:65522 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553652AbQJZDB4>;
	Wed, 25 Oct 2000 20:01:56 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e9Q30L315569;
	Wed, 25 Oct 2000 20:00:21 -0700
Message-ID: <39F79EF8.9029AE6@mvista.com>
Date:   Wed, 25 Oct 2000 20:03:20 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: a REALLY, REALLY nasty bug
Content-Type: multipart/mixed;
 boundary="------------5AC1E941C60B3443C5D0E5E3"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------5AC1E941C60B3443C5D0E5E3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Nasty degree - 3 days of tracking.

The symptom was pthread cannot be created.  In the end the caller will
get a BUS error.

What exactly happened has to do with how registers are saved.  Below
attached is the beginning part of sys_sigsuspend() function.  It is easy
to see that s0 is saved into stack frame AFTER its modified.  Next time
when process returns to userland, the s0 reg will be wrong!

So the bug is either 

1) that we need to save s0 register in SAVE_SOME and not save it in
save_static; or that

2) we fix compiler so that it does not use s0 register in that case (it
does the same thing for sys_rt_sigsuspend)

I am sure Ralf will have something to say about it.  :-)  In any case, I
attached a patch for 1) fix.

Jun

------------



sys_sigsuspend(struct pt_regs regs)
{
    8008e280:   27bdffc0        addiu   $sp,$sp,-64
    8008e284:   afb00030        sw      $s0,48($sp)
        sigset_t *uset, saveset, newset;

        save_static(&regs);
    8008e288:   27b00040        addiu   $s0,$sp,64
    8008e28c:   afbf003c        sw      $ra,60($sp)
    8008e290:   afb20038        sw      $s2,56($sp)
    8008e294:   afb10034        sw      $s1,52($sp)
    8008e298:   afa40040        sw      $a0,64($sp)
    8008e29c:   afa50044        sw      $a1,68($sp)
    8008e2a0:   afa60048        sw      $a2,72($sp)
    8008e2a4:   afa7004c        sw      $a3,76($sp)
    8008e2a8:   ae100058        sw      $s0,88($s0)
    8008e2ac:   ae11005c        sw      $s1,92($s0)
    .....
--------------5AC1E941C60B3443C5D0E5E3
Content-Type: text/plain; charset=us-ascii;
 name="junk"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="junk"

diff -Nru linux/include/asm-mips/stackframe.h.orig linux/include/asm-mips/stackframe.h
--- linux/include/asm-mips/stackframe.h.orig    Wed Oct 25 19:45:50 2000
+++ linux/include/asm-mips/stackframe.h Wed Oct 25 19:47:54 2000
@@ -49,7 +49,6 @@
 
 #define save_static(frame)                               \
        __asm__ __volatile__(                            \
-               "sw\t$16,"__str(PT_R16)"(%0)\n\t"        \
                "sw\t$17,"__str(PT_R17)"(%0)\n\t"        \
                "sw\t$18,"__str(PT_R18)"(%0)\n\t"        \
                "sw\t$19,"__str(PT_R19)"(%0)\n\t"        \
@@ -90,6 +89,7 @@
                mfc0    v1, CP0_EPC;                     \
                sw      $7, PT_R7(sp);                   \
                sw      v1, PT_EPC(sp);                  \
+               sw      $16, PT_R16(sp);                 \
                sw      $25, PT_R25(sp);                 \
                sw      $28, PT_R28(sp);                 \
                sw      $31, PT_R31(sp);                 \


--------------5AC1E941C60B3443C5D0E5E3--
