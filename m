Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2003 21:50:59 +0000 (GMT)
Received: from mms3.broadcom.com ([IPv6:::ffff:63.70.210.38]:43012 "EHLO
	mms3.broadcom.com") by linux-mips.org with ESMTP
	id <S8225198AbTCDVu6>; Tue, 4 Mar 2003 21:50:58 +0000
Received: from 63.70.210.1 by mms3.broadcom.com with ESMTP (Broadcom
 MMS1 SMTP Relay (MMS v5.5.0)); Tue, 04 Mar 2003 13:50:53 -0700
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id NAA04019; Tue, 4 Mar 2003 13:50:37 -0800 (PST)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.4/8.12.4/SSF) with ESMTP id
 h24LolER016849; Tue, 4 Mar 2003 13:50:47 -0800 (PST)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id NAA06377; Tue, 4
 Mar 2003 13:50:47 -0800
Message-ID: <3E651FB7.A38AFD3B@broadcom.com>
Date: Tue, 04 Mar 2003 13:50:47 -0800
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
cc: "Ralf Baechle" <ralf@linux-mips.org>
Subject: [PATCH] kernelsp on 64-bit kernel
X-WSS-ID: 127BC0372364117-01-01
Content-Type: multipart/mixed;
 boundary=------------8D168CE492746438F5FDD556
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------8D168CE492746438F5FDD556
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit


Is anyone else interested in having the 64-bit kernel *not* use the CP0
watchpoint registers for storing the kernel stack pointer for the CPU's
current process?

I have a couple problems with this:
 - there are read-only bits in watchhi (according to the MIPS64 spec) so
hoping to save and restore all high 32 bits (as currently coded) seems
unjustified.
 - somebody might want to actually *use* watchpoints (a JTAG debugger,
in my case)

I put together something that works, based on the 32-bit kernel which
has an array of kernelsp's instead of keeping it in CP0.  Some notes
about this solution are:
 - processor id isn't as easy to get in the 64-bit kernel since
CP0_CONTEXT has (&pgd_current[cpu] << 23) instead of (cpu << 23) so in
this patch I use ((&pgd_current[cpu] - &pgd_current[0]) + &kernelsp)
which seems expensive.
 - smp_bootstrap tries to stash the kernelsp away, but won't work
because CP0_CONTEXT on secondary CPUs isn't set up yet.  However, I
don't think this really needs to happen at this time; the first context
switch on the CPU will save the kernelsp without any damage being done
(I think).  So in the patch, I axed this use of set_saved_sp.
 - set_saved_sp implemented using the pointer math needs two temporaries
instead of one (or am I missing a trick?)

2.4 kernel patch included.

Kip
--------------8D168CE492746438F5FDD556
Content-Type: text/plain;
 charset=us-ascii;
 name=kernelsp.diff
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=kernelsp.diff

Index: include/asm-mips64/stackframe.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips64/stackframe.h,v
retrieving revision 1.7.2.4
diff -u -r1.7.2.4 stackframe.h
--- include/asm-mips64/stackframe.h	28 Jan 2003 14:31:33 -0000	1.7.2.4
+++ include/asm-mips64/stackframe.h	4 Mar 2003 21:49:47 -0000
@@ -11,6 +11,7 @@
 #define _ASM_STACKFRAME_H
 
 #include <linux/config.h>
+#include <linux/threads.h>
 
 #include <asm/asm.h>
 #include <asm/offset.h>
@@ -76,33 +77,23 @@
 		.endm
 
 #ifdef CONFIG_SMP
-		.macro	get_saved_sp	/* R10000 variation */
-#ifdef CONFIG_CPU_SB1
-		dmfc0	k1, CP0_WATCHLO
-#else
-		mfc0	k0, CP0_WATCHLO
-		mfc0	k1, CP0_WATCHHI
-		dsll32	k0, k0, 0	/* Get rid of sign extension */
-		dsrl32	k0, k0, 0	/* Get rid of sign extension */
-		dsll32	k1, k1, 0
-		or	k1, k1, k0
-		li	k0, K0BASE
-		or	k1, k1, k0
-#endif
-		.endm
-
-		.macro	set_saved_sp	stackp temp
-#ifdef CONFIG_CPU_SB1
-		dmtc0	\stackp, CP0_WATCHLO
-#else
-		mtc0	\stackp, CP0_WATCHLO
-		dsrl32	\temp, \stackp, 0
-		mtc0	\temp, CP0_WATCHHI
-#endif
+		.macro	get_saved_sp	/* SMP variation */
+		dmfc0	k1, CP0_CONTEXT
+		dsra	k1, 23
+		lui	k0, %hi(pgd_current)
+		daddiu	k0, %lo(pgd_current)
+		dsubu	k1, k0
+		lui	k0, %hi(kernelsp)
+		daddu	k1, k0
+		ld	k1, %lo(kernelsp)(k1)
 		.endm
 
-		.macro	declare_saved_sp
-		# empty, stackpointer stored in a register
+		.macro	set_saved_sp	stackp temp temp2
+		lw	\temp, TASK_PROCESSOR(gp)
+		dsll	\temp, 3
+		lui	\temp2, %hi(kernelsp)
+		daddu	\temp, \temp2
+		sd	\stackp, %lo(kernelsp)(\temp)
 		.endm
 #else
 		.macro	get_saved_sp	/* Uniprocessor variation */
@@ -110,14 +101,13 @@
 		ld	k1, %lo(kernelsp)(k1)
 		.endm
 
-		.macro	set_saved_sp	stackp temp
+		.macro	set_saved_sp	stackp temp temp2
 		sd	\stackp, kernelsp
 		.endm
-
+#endif
 		.macro	declare_saved_sp
-		.comm	kernelsp, 8, 8			# current stackpointer
+		.comm	kernelsp, NR_CPUS * 8, 8
 		.endm
-#endif
 
 		.macro	SAVE_SOME
 		.set	push
Index: arch/mips64/kernel/head.S
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/head.S,v
retrieving revision 1.34.2.10
diff -u -r1.34.2.10 head.S
--- arch/mips64/kernel/head.S	29 Nov 2002 04:02:31 -0000	1.34.2.10
+++ arch/mips64/kernel/head.S	4 Mar 2003 21:49:47 -0000
@@ -107,7 +107,7 @@
 
 	PTR_LA	$28, init_task_union		# init current pointer
 	daddiu	sp, $28, KERNEL_STACK_SIZE-32
-	set_saved_sp	sp, t0
+	set_saved_sp	sp, t0, t1
 
 	/* The firmware/bootloader passes argc/argp/envp
 	 * to us as arguments.  But clear bss first because
@@ -156,8 +156,6 @@
         mfc0	t0, CP0_STATUS
         or	t0, ST0_KX
 	mtc0	t0, CP0_STATUS
-
-	set_saved_sp	sp, t0
 
 	jal	start_secondary			# XXX: IP27: cboot
 
Index: arch/mips64/kernel/r4k_switch.S
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/r4k_switch.S,v
retrieving revision 1.5.2.10
diff -u -r1.5.2.10 r4k_switch.S
--- arch/mips64/kernel/r4k_switch.S	4 Nov 2002 19:39:56 -0000	1.5.2.10
+++ arch/mips64/kernel/r4k_switch.S	4 Mar 2003 21:49:47 -0000
@@ -87,7 +87,7 @@
 	cpu_restore_nonscratch $28
 
 	daddiu	a1, $28, KERNEL_STACK_SIZE-32
-	set_saved_sp	a1 t0
+	set_saved_sp	a1, t0, t1
 
 	mfc0	t1, CP0_STATUS		/* Do we really need this? */
 	li	a3, 0xff00

--------------8D168CE492746438F5FDD556--
