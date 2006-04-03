Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Apr 2006 14:43:50 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:49359 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133659AbWDCNnj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Apr 2006 14:43:39 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FQPTe-0006bX-W7
	for linux-mips@linux-mips.org; Mon, 03 Apr 2006 15:52:19 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1FQPW5-0000d5-Fd
	for linux-mips@linux-mips.org; Mon, 03 Apr 2006 15:54:49 +0200
Date:	Mon, 3 Apr 2006 15:54:49 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Linux MIPS <linux-mips@linux-mips.org>
Message-ID: <20060403135449.GQ7029@enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bJ3jXuwtxrXxD2iT"
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: [PATCH] Au1xxx Sleeping functions for 2.6
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on goldrake.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--bJ3jXuwtxrXxD2iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

here a patch against Linuxmips-2.6.15 to fix the sleeping functions
for CPUs au1xxx.

Currently the sleep mode works but a lot of internal peripherals'
drivers miss the power management functions so is possibile that the
kernel hangs at wake up if some internal peripherals other than the
first serial line is enabled (expecially for the ethernet)!

However I'm working for a full support of sleep mode and I hope to be
able to send a patch to fix this in the near future...

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--bJ3jXuwtxrXxD2iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-sleeper.S"

--- /home/develop/embedded/mips/linux/linux-mips.git/arch/mips/au1000/common/sleeper.S	2006-03-31 16:57:26.000000000 +0200
+++ arch/mips/au1000/common/sleeper.S	2006-03-31 16:26:35.000000000 +0200
@@ -9,22 +9,54 @@
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
  */
+#include <linux/config.h>
 #include <asm/asm.h>
 #include <asm/mipsregs.h>
 #include <asm/addrspace.h>
 #include <asm/regdef.h>
 #include <asm/stackframe.h>
+#include <asm/mach-au1x00/au1000.h>
+
+/*
+ * Note: This file is *not* conditional on CONFIG_PM since Alchemy sleep 
+ * need not be tied to any particular power management scheme.
+ */
+
+	.extern __flush_cache_all
 
 	.text
-	.set	macro
-	.set	noat
 	.align	5
 
-/* Save all of the processor general registers and go to sleep.
- * A wakeup condition will get us back here to restore the registers.
+/*
+ * Save the processor general registers and go to sleep. A wakeup
+ * condition will get us back here to restore the registers.
  */
-LEAF(save_and_sleep)
 
+/* still need to fix alignment issues here */
+save_and_sleep_frmsz = 48
+NESTED(save_and_sleep, save_and_sleep_frmsz, ra)
+	.set noreorder
+	.set nomacro
+	.set noat
+	subu sp, save_and_sleep_frmsz
+	sw ra, save_and_sleep_frmsz-4(sp)
+	sw s0, save_and_sleep_frmsz-8(sp)
+	sw s1, save_and_sleep_frmsz-12(sp)
+	sw s2, save_and_sleep_frmsz-16(sp)
+	sw s3, save_and_sleep_frmsz-20(sp)
+	sw s4, save_and_sleep_frmsz-24(sp)
+	sw s5, save_and_sleep_frmsz-28(sp)
+	sw s6, save_and_sleep_frmsz-32(sp)
+	sw s7, save_and_sleep_frmsz-36(sp)
+	sw s8, save_and_sleep_frmsz-40(sp)
+	sw gp, save_and_sleep_frmsz-44(sp)
+
+	/* We only need to save the registers that the calling function 
+	 * hasn't saved for us.  0 is always zero.  8 - 15, 24 and 25 are 
+	 * temporaries and can be used without saving. 26 and 27 are reserved 
+	 * for interrupt/trap handling and expected to change.  29 is the 
+	 * stack pointer which is handled as a special case here.
+	 */
 	subu	sp, PT_SIZE
 	sw	$1, PT_R1(sp)
 	sw	$2, PT_R2(sp)
@@ -33,14 +65,6 @@
 	sw	$5, PT_R5(sp)
 	sw	$6, PT_R6(sp)
 	sw	$7, PT_R7(sp)
-	sw	$8, PT_R8(sp)
-	sw	$9, PT_R9(sp)
-	sw	$10, PT_R10(sp)
-	sw	$11, PT_R11(sp)
-	sw	$12, PT_R12(sp)
-	sw	$13, PT_R13(sp)
-	sw	$14, PT_R14(sp)
-	sw	$15, PT_R15(sp)
 	sw	$16, PT_R16(sp)
 	sw	$17, PT_R17(sp)
 	sw	$18, PT_R18(sp)
@@ -49,32 +73,54 @@
 	sw	$21, PT_R21(sp)
 	sw	$22, PT_R22(sp)
 	sw	$23, PT_R23(sp)
-	sw	$24, PT_R24(sp)
-	sw	$25, PT_R25(sp)
-	sw	$26, PT_R26(sp)
-	sw	$27, PT_R27(sp)
 	sw	$28, PT_R28(sp)
-	sw	$29, PT_R29(sp)
 	sw	$30, PT_R30(sp)
 	sw	$31, PT_R31(sp)
+#define PT_C0STATUS PT_LO
+#define PT_CONTEXT PT_HI
+#define PT_PAGEMASK PT_EPC
+#define PT_CONFIG PT_BVADDR
 	mfc0	k0, CP0_STATUS
-	sw	k0, 0x20(sp)
+	sw	k0, PT_C0STATUS(sp) // 0x20
 	mfc0	k0, CP0_CONTEXT
-	sw	k0, 0x1c(sp)
+	sw	k0, PT_CONTEXT(sp) // 0x1c
 	mfc0	k0, CP0_PAGEMASK
-	sw	k0, 0x18(sp)
+	sw	k0, PT_PAGEMASK(sp) // 0x18
 	mfc0	k0, CP0_CONFIG
-	sw	k0, 0x14(sp)
+	sw	k0, PT_CONFIG(sp) // 0x14
+
+#if 0
+        /* Infinite loop to allow JTAG attach before sleep mode (debug only)
+         */
+2:      li      t1, 0
+        beq     t1, zero, 2b
+        nop
+#endif
+
+	.set macro
+	.set at
+
+	li	t0, SYS_SLPPWR
+	sw	zero, 0(t0)	/* Get the processor ready to sleep */
+	sync
 
 	/* Now set up the scratch registers so the boot rom will
 	 * return to this point upon wakeup.
+	 * sys_scratch0 : SP
+	 * sys_scratch1 : RA
 	 */
-	la	k0, 1f
-	lui	k1, 0xb190
-	ori	k1, 0x18
-	sw	sp, 0(k1)
-	ori 	k1, 0x1c
-	sw	k0, 0(k1)
+	li	t0, SYS_SCRATCH0
+	li	t1, SYS_SCRATCH1
+	sw	sp, 0(t0)
+	la	k0, resume_from_sleep
+	sw	k0, 0(t1)
+
+/* Flush DCACHE to make sure context is in memory
+*/
+	la 	t1, __flush_cache_all   /* _flush_cache_all is a function ptr */
+	lw 	t0,0(t1)
+	jal	t0
+	nop
 
 /* Put SDRAM into self refresh.  Preload instructions into cache,
  * issue a precharge, then auto refresh, then sleep commands to it.
@@ -87,30 +133,74 @@
  	cache	0x14, 96(t0)
 	.set	mips0
 
+	/* Put SDRAM to sleep */
 sdsleep:
-	lui 	k0, 0xb400
-	sw	zero, 0x001c(k0)	/* Precharge */
-	sw	zero, 0x0020(k0)	/* Auto refresh */
-	sw	zero, 0x0030(k0)	/* SDRAM sleep */
+	li 	a0, MEM_PHYS_ADDR
+	or 	a0, a0, 0xA0000000
+#if defined(CONFIG_SOC_AU1000) || defined(CONFIG_SOC_AU1100) || defined(CONFIG_SOC_AU1500)
+	lw 	k0, MEM_SDMODE0(a0)
+	sw	zero, MEM_SDPRECMD(a0) 	/* Precharge */
+	sw	zero, MEM_SDAUTOREF(a0)	/* Auto Refresh */
+	sw	zero, MEM_SDSLEEP(a0)  	/* Sleep */
 	sync
-
-	lui 	k1, 0xb190
-	sw	zero, 0x0078(k1)	/* get ready  to sleep */
+#endif
+#if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
+	sw	zero, MEM_SDPRECMD(a0) 	/* Precharge */
+	sw 	zero, MEM_SDSREF(a0)
+	
+	#lw 	t0, MEM_SDSTAT(a0)
+	#and	t0, t0, 0x01000000
+	li 	t0, 0x01000000
+refresh_not_set:
+	lw 	t1, MEM_SDSTAT(a0)
+	and	t2, t1, t0
+	beq	zero, t2, refresh_not_set
+	nop
+
+	li	t0, ~0x30000000
+	lw 	t1, MEM_SDCONFIGA(a0)
+	and	t1, t0, t1
+	sw 	t1, MEM_SDCONFIGA(a0)
 	sync
-	sw	zero, 0x007c(k1)	/* Put processor to sleep */
+#endif
+
+	li	t0, SYS_SLEEP
+	sw	zero, 0(t0)	/* Put processor to sleep */
 	sync
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
 
 	/* This is where we return upon wakeup.
 	 * Reload all of the registers and return.
 	 */
-1:	nop
-	lw	k0, 0x20(sp)
+resume_from_sleep:
+	nop
+	.set nomacro
+	.set noat
+
+#if 0
+        /* Infinite loop to allow JTAG attach before sleep mode (debug only)
+         */
+2:      li      t1, 0
+        beq     t1, zero, 2b
+        nop
+#endif
+
+	/* Restore CPU registers
+	 */
+	lw	k0, PT_C0STATUS(sp) // 0x20
 	mtc0	k0, CP0_STATUS
-	lw	k0, 0x1c(sp)
+	lw	k0, PT_CONTEXT(sp) // 0x1c
 	mtc0	k0, CP0_CONTEXT
-	lw	k0, 0x18(sp)
+	lw	k0, PT_PAGEMASK(sp) // 0x18
 	mtc0	k0, CP0_PAGEMASK
-	lw	k0, 0x14(sp)
+	lw	k0, PT_CONFIG(sp) // 0x14
 	mtc0	k0, CP0_CONFIG
 	lw	$1, PT_R1(sp)
 	lw	$2, PT_R2(sp)
@@ -119,14 +209,6 @@
 	lw	$5, PT_R5(sp)
 	lw	$6, PT_R6(sp)
 	lw	$7, PT_R7(sp)
-	lw	$8, PT_R8(sp)
-	lw	$9, PT_R9(sp)
-	lw	$10, PT_R10(sp)
-	lw	$11, PT_R11(sp)
-	lw	$12, PT_R12(sp)
-	lw	$13, PT_R13(sp)
-	lw	$14, PT_R14(sp)
-	lw	$15, PT_R15(sp)
 	lw	$16, PT_R16(sp)
 	lw	$17, PT_R17(sp)
 	lw	$18, PT_R18(sp)
@@ -135,15 +217,37 @@
 	lw	$21, PT_R21(sp)
 	lw	$22, PT_R22(sp)
 	lw	$23, PT_R23(sp)
-	lw	$24, PT_R24(sp)
-	lw	$25, PT_R25(sp)
-	lw	$26, PT_R26(sp)
-	lw	$27, PT_R27(sp)
 	lw	$28, PT_R28(sp)
-	lw	$29, PT_R29(sp)
 	lw	$30, PT_R30(sp)
 	lw	$31, PT_R31(sp)
+
+	.set macro
+	.set at
+
+	/* Clear the wake source, but save it as the return value of the
+           function */
+	li	t0, SYS_WAKESRC
+	lw	v0, 0(t0)
+	sw	v0, PT_R2(sp)
+	sw	zero, 0(t0)
+
 	addiu	sp, PT_SIZE
 
+	lw gp, save_and_sleep_frmsz-44(sp)
+	lw s8, save_and_sleep_frmsz-40(sp)
+	lw s7, save_and_sleep_frmsz-36(sp)
+	lw s6, save_and_sleep_frmsz-32(sp)
+	lw s5, save_and_sleep_frmsz-28(sp)
+	lw s4, save_and_sleep_frmsz-24(sp)
+	lw s3, save_and_sleep_frmsz-20(sp)
+	lw s2, save_and_sleep_frmsz-16(sp)
+	lw s1, save_and_sleep_frmsz-12(sp)
+	lw s0, save_and_sleep_frmsz-8(sp)
+	lw ra, save_and_sleep_frmsz-4(sp)
+
+	addu sp, save_and_sleep_frmsz
 	jr	ra
+	nop
+	.set reorder
 END(save_and_sleep)
+

--bJ3jXuwtxrXxD2iT--
