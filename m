Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Dec 2002 14:44:24 +0100 (CET)
Received: from mx2.mips.com ([206.31.31.227]:17292 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S8225196AbSLJNoX>;
	Tue, 10 Dec 2002 14:44:23 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gBADiBNf024148;
	Tue, 10 Dec 2002 05:44:11 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id FAA06087;
	Tue, 10 Dec 2002 05:44:11 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gBADiAb01946;
	Tue, 10 Dec 2002 14:44:10 +0100 (MET)
Message-ID: <3DF5EFA9.B9021FC8@mips.com>
Date: Tue, 10 Dec 2002 14:44:10 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: EJTAG and NMI handler broken
References: <3DEF57C5.172E8E66@mips.com>
Content-Type: multipart/mixed;
 boundary="------------D6449356168C4402DCE212F6"
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------D6449356168C4402DCE212F6
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Ralf, did you ever take a look on my previous mail (patch).
I have added few extra things, used by MIPS32/MIPS64 compliant CPUs.
Please take a look at the attached patch.

/Carsten



Carsten Langgaard wrote:

> The EJTAG and NMI handler are broken in the 32-bit kernel, because they
> are laying in the __INIT section, which is removed after boot.
> The handlers are missing in the 64-bit kernel.
> The attached patch will fix that.
>
> /Carsten
>
> --
> _    _ ____  ___   Carsten Langgaard  Mailto:carstenl@mips.com
> |\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
> | \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
>   TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
>                    Denmark            http://www.mips.com
>
>   ------------------------------------------------------------------------
> Index: arch/mips/kernel/head.S
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/kernel/head.S,v
> retrieving revision 1.29.2.14
> diff -u -r1.29.2.14 head.S
> --- arch/mips/kernel/head.S     5 Aug 2002 23:53:33 -0000       1.29.2.14
> +++ arch/mips/kernel/head.S     5 Dec 2002 13:32:24 -0000
> @@ -92,34 +92,6 @@
>                 END(except_vec_ejtag_debug)
>
>                 /*
> -                * EJTAG debug exception handler.
> -                */
> -               NESTED(ejtag_debug_handler, PT_SIZE, sp)
> -               .set    noat
> -               .set    noreorder
> -               mtc0    k0, CP0_DESAVE
> -               mfc0    k0, CP0_DEBUG
> -
> -               sll     k0, k0, 30      # Check for SDBBP.
> -               bgez    k0, ejtag_return
> -
> -               la      k0, ejtag_debug_buffer
> -               sw      k1, 0(k0)
> -               SAVE_ALL
> -               jal     ejtag_exception_handler
> -                move   a0, sp
> -               RESTORE_ALL
> -               la      k0, ejtag_debug_buffer
> -               lw      k1, 0(k0)
> -
> -ejtag_return:
> -               mfc0    k0, CP0_DESAVE
> -               .word   0x4200001f     # DERET, return from EJTAG debug exception.
> -                nop
> -               .set    at
> -               END(ejtag_debug_handler)
> -
> -               /*
>                 * NMI debug exception handler for MIPS reference boards.
>                 * The NMI debug exception entry point is 0xbfc00000, which
>                 * normally is in the boot PROM, so the boot PROM must do a
> @@ -130,19 +102,6 @@
>                  nop
>                 END(except_vec_nmi)
>
> -               NESTED(nmi_handler, PT_SIZE, sp)
> -               .set    noat
> -               .set    noreorder
> -               .set    mips3
> -               SAVE_ALL
> -               jal     nmi_exception_handler
> -                move   a0, sp
> -               RESTORE_ALL
> -               eret
> -               .set    at
> -               .set    mips0
> -               END(nmi_handler)
> -
>                 /*
>                  * Kernel entry point
>                  */
> @@ -199,10 +158,52 @@
>                 __FINIT
>
>                 /*
> +                * EJTAG debug exception handler.
> +                */
> +               NESTED(ejtag_debug_handler, PT_SIZE, sp)
> +               .set    noat
> +               .set    noreorder
> +               mtc0    k0, CP0_DESAVE
> +               mfc0    k0, CP0_DEBUG
> +
> +               sll     k0, k0, 30      # Check for SDBBP.
> +               bgez    k0, ejtag_return
> +
> +               la      k0, ejtag_debug_buffer
> +               sw      k1, 0(k0)
> +               SAVE_ALL
> +               jal     ejtag_exception_handler
> +                move   a0, sp
> +               RESTORE_ALL
> +               la      k0, ejtag_debug_buffer
> +               lw      k1, 0(k0)
> +
> +ejtag_return:
> +               mfc0    k0, CP0_DESAVE
> +               .word   0x4200001f     # DERET, return from EJTAG debug exception.
> +                nop
> +               .set    at
> +               END(ejtag_debug_handler)
> +
> +               NESTED(nmi_handler, PT_SIZE, sp)
> +               .set    noat
> +               .set    noreorder
> +               .set    mips3
> +               SAVE_ALL
> +               jal     nmi_exception_handler
> +                move   a0, sp
> +               RESTORE_ALL
> +               eret
> +               .set    at
> +               .set    mips0
> +               END(nmi_handler)
> +
> +               /*
>                  * This buffer is reserved for the use of the EJTAG debug
>                  * handler.
>                  */
>                 .data
> +               .align 2
>                 EXPORT(ejtag_debug_buffer)
>                 .fill   4
>
> Index: arch/mips64/kernel/r4k_genex.S
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips64/kernel/r4k_genex.S,v
> retrieving revision 1.7.2.8
> diff -u -r1.7.2.8 r4k_genex.S
> --- arch/mips64/kernel/r4k_genex.S      2 Oct 2002 14:45:46 -0000       1.7.2.8
> +++ arch/mips64/kernel/r4k_genex.S      5 Dec 2002 13:32:25 -0000
> @@ -121,4 +121,72 @@
>  1:     j       1b                      /* Dummy, will be replaced */
>  END(except_vec4)
>
> +/*
> + * EJTAG debug exception handler.
> + * The EJTAG debug exception entry point is 0xbfc00480, which
> + * normally is in the boot PROM, so the boot PROM must do a
> + * unconditional jump to this vector.
> + */
> +NESTED(except_vec_ejtag_debug, 0, sp)
> +       j       ejtag_debug_handler
> +        nop
> +END(except_vec_ejtag_debug)
> +
> +/*
> + * NMI debug exception handler for MIPS reference boards.
> + * The NMI debug exception entry point is 0xbfc00000, which
> + * normally is in the boot PROM, so the boot PROM must do a
> + * unconditional jump to this vector.
> + */
> +NESTED(except_vec_nmi, 0, sp)
> +       j       nmi_handler
> +        nop
> +END(except_vec_nmi)
> +
>         __FINIT
> +
> +/*
> + * EJTAG debug exception handler.
> + */
> +NESTED(ejtag_debug_handler, PT_SIZE, sp)
> +       .set    noat
> +       .set    noreorder
> +       dmtc0   k0, CP0_DESAVE
> +       mfc0    k0, CP0_DEBUG
> +
> +       sll     k0, k0, 30      # Check for SDBBP.
> +       bgez    k0, ejtag_return
> +
> +       dla     k0, ejtag_debug_buffer
> +       sd      k1, 0(k0)
> +       SAVE_ALL
> +       jal     ejtag_exception_handler
> +        move   a0, sp
> +       RESTORE_ALL
> +       dla     k0, ejtag_debug_buffer
> +       ld      k1, 0(k0)
> +
> +ejtag_return:
> +       mfc0    k0, CP0_DESAVE
> +       .word   0x4200001f     # DERET, return from EJTAG debug exception.
> +        nop
> +       .set    at
> +END(ejtag_debug_handler)
> +
> +NESTED(nmi_handler, PT_SIZE, sp)
> +       .set    noat
> +       .set    noreorder
> +       SAVE_ALL
> +       jal     nmi_exception_handler
> +        move   a0, sp
> +       .set    at
> +END(nmi_handler)
> +
> +/*
> + * This buffer is reserved for the use of the EJTAG debug
> + * handler.
> + */
> +       .data
> +       .align 3
> +       EXPORT(ejtag_debug_buffer)
> +       .fill   8
> \ No newline at end of file
> Index: arch/mips64/kernel/traps.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips64/kernel/traps.c,v
> retrieving revision 1.30.2.37
> diff -u -r1.30.2.37 traps.c
> --- arch/mips64/kernel/traps.c  2 Dec 2002 00:24:52 -0000       1.30.2.37
> +++ arch/mips64/kernel/traps.c  5 Dec 2002 13:32:25 -0000
> @@ -638,6 +638,46 @@
>         }
>  }
>
> +/*
> + * SDBBP EJTAG debug exception handler.
> + * We skip the instruction and return to the next instruction.
> + */
> +void ejtag_exception_handler(struct pt_regs *regs)
> +{
> +        unsigned long depc, old_epc;
> +       unsigned int debug;
> +
> +        printk("SDBBP EJTAG debug exception - not handled yet, just ignored!\n");
> +       depc = read_c0_depc();
> +        debug = read_c0_debug();
> +        printk("DEPC = %p, DEBUG = %08x\n", depc, debug);
> +        if (debug & 0x80000000) {
> +                /*
> +                 * In branch delay slot.
> +                 * We cheat a little bit here and use EPC to calculate the
> +                 * debug return address (DEPC). EPC is restored after the
> +                 * calculation.
> +                 */
> +                old_epc = regs->cp0_epc;
> +                regs->cp0_epc = depc;
> +                __compute_return_epc(regs);
> +                depc = regs->cp0_epc;
> +                regs->cp0_epc = old_epc;
> +        } else
> +                depc += 4;
> +       write_c0_depc(depc);
> +}
> +
> +/*
> + * NMI exception handler.
> + */
> +void nmi_exception_handler(struct pt_regs *regs)
> +{
> +       printk("NMI taken: ERROREPC = %p\n", read_c0_errorepc());
> +        die("NMI", regs);
> +        while(1) ;  /* We die here. */
> +}
> +
>  unsigned long exception_handlers[32];
>
>  /*
> @@ -702,6 +742,8 @@
>         extern char except_vec0_generic, except_vec2_generic;
>         extern char except_vec3_generic, except_vec3_r4000;
>         extern char except_vec4;
> +       extern char except_vec_ejtag_debug;
> +       extern char except_vec_nmi;
>         unsigned long i;
>
>         per_cpu_trap_init();
> @@ -716,6 +758,19 @@
>          */
>         for (i = 0; i <= 31; i++)
>                 set_except_vector(i, handle_reserved);
> +
> +       /*
> +        * Copy the EJTAG debug exception vector handler code to it's final
> +        * destination.
> +        */
> +       if (mips_cpu.options & MIPS_CPU_EJTAG)
> +               memcpy((void *)(KSEG0 + 0x300), &except_vec_ejtag_debug, 0x80);
> +
> +       /*
> +         * Copy the NMI exception vector handler code to it's final
> +         * destination.
> +         */
> +        memcpy((void *)(KSEG0 + 0x380), &except_vec_nmi, 0x80);
>
>         /*
>          * Only some CPUs have the watch exceptions or a dedicated

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------D6449356168C4402DCE212F6
Content-Type: text/plain; charset=iso-8859-15;
 name="ejtag_nmi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ejtag_nmi.patch"

Index: arch/mips/kernel/head.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/head.S,v
retrieving revision 1.29.2.14
diff -u -r1.29.2.14 head.S
--- arch/mips/kernel/head.S	5 Aug 2002 23:53:33 -0000	1.29.2.14
+++ arch/mips/kernel/head.S	10 Dec 2002 13:29:55 -0000
@@ -92,34 +92,6 @@
 		END(except_vec_ejtag_debug)
 
 		/*
-		 * EJTAG debug exception handler.
-		 */
-		NESTED(ejtag_debug_handler, PT_SIZE, sp)
-		.set	noat
-		.set	noreorder
-		mtc0	k0, CP0_DESAVE
-		mfc0	k0, CP0_DEBUG
-
-		sll	k0, k0, 30	# Check for SDBBP.
-		bgez	k0, ejtag_return
-
-		la	k0, ejtag_debug_buffer
-		sw	k1, 0(k0)
-		SAVE_ALL
-		jal	ejtag_exception_handler
-		 move	a0, sp
-		RESTORE_ALL
-		la	k0, ejtag_debug_buffer
-		lw	k1, 0(k0)
-
-ejtag_return:
-		mfc0	k0, CP0_DESAVE
-		.word	0x4200001f     # DERET, return from EJTAG debug exception.
-		 nop
-		.set	at
-		END(ejtag_debug_handler)
-
-		/*
 		* NMI debug exception handler for MIPS reference boards.
 		* The NMI debug exception entry point is 0xbfc00000, which
 		* normally is in the boot PROM, so the boot PROM must do a
@@ -130,19 +102,6 @@
 		 nop
 		END(except_vec_nmi)
 
-		NESTED(nmi_handler, PT_SIZE, sp)
-		.set    noat
-		.set    noreorder
-		.set    mips3
-		SAVE_ALL
-		jal     nmi_exception_handler
-		 move   a0, sp
-		RESTORE_ALL
-		eret
-		.set    at
-		.set    mips0
-		END(nmi_handler)
-
 		/*
 		 * Kernel entry point
 		 */
@@ -199,10 +158,52 @@
 		__FINIT
 
 		/*
+		 * EJTAG debug exception handler.
+		 */
+		NESTED(ejtag_debug_handler, PT_SIZE, sp)
+		.set	noat
+		.set	noreorder
+		mtc0	k0, CP0_DESAVE
+		mfc0	k0, CP0_DEBUG
+
+		sll	k0, k0, 30	# Check for SDBBP.
+		bgez	k0, ejtag_return
+
+		la	k0, ejtag_debug_buffer
+		sw	k1, 0(k0)
+		SAVE_ALL
+		jal	ejtag_exception_handler
+		 move	a0, sp
+		RESTORE_ALL
+		la	k0, ejtag_debug_buffer
+		lw	k1, 0(k0)
+
+ejtag_return:
+		mfc0	k0, CP0_DESAVE
+		.word	0x4200001f     # DERET, return from EJTAG debug exception.
+		 nop
+		.set	at
+		END(ejtag_debug_handler)
+
+		NESTED(nmi_handler, PT_SIZE, sp)
+		.set    noat
+		.set    noreorder
+		.set    mips3
+		SAVE_ALL
+		jal     nmi_exception_handler
+		 move   a0, sp
+		RESTORE_ALL
+		eret
+		.set    at
+		.set    mips0
+		END(nmi_handler)
+		
+		/*
 		 * This buffer is reserved for the use of the EJTAG debug
 		 * handler.
 		 */
 		.data
+		.align 2
 		EXPORT(ejtag_debug_buffer)
 		.fill	4
 
Index: arch/mips/kernel/traps.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/traps.c,v
retrieving revision 1.99.2.35
diff -u -r1.99.2.35 traps.c
--- arch/mips/kernel/traps.c	4 Dec 2002 23:50:23 -0000	1.99.2.35
+++ arch/mips/kernel/traps.c	10 Dec 2002 13:29:55 -0000
@@ -733,6 +733,16 @@
 
 asmlinkage void do_mcheck(struct pt_regs *regs)
 {
+	switch(mips_cpu.cputype) {
+	case CPU_4KC:
+	case CPU_4KEC:
+	case CPU_4KSC:
+	case CPU_5KC:
+	case CPU_20KC:
+		/* Clear the TS bit in the status register. */
+		clear_c0_status(0x00200000);
+		break;
+	}
 	show_regs(regs);
 	dump_tlb_all();
 	/*
@@ -777,6 +787,12 @@
 		       "MIPS 5KC CPUs.\n");
 		write_c0_ecc(read_c0_ecc() | 0x80000000);
 		break;
+	case CPU_20KC:
+		/* Clear the DE bit (bit 16) in the CP0_STATUS register. */
+		printk(KERN_INFO "Enable the cache parity detection for "
+		       "MIPS 20KC/25KF CPUs.\n");
+		clear_c0_status(0x0001000);
+		break;
 	default:
 		break;
 	}
@@ -857,7 +873,7 @@
  */
 void nmi_exception_handler(struct pt_regs *regs)
 {
-        printk("NMI taken!!!!\n");
+        printk("NMI taken: ERROREPC = %08x\n", read_c0_errorepc());
         die("NMI", regs);
         while(1) ;  /* We die here. */
 }
@@ -945,6 +961,12 @@
 	 */
 	if (mips_cpu.options & MIPS_CPU_EJTAG)
 		memcpy((void *)(KSEG0 + 0x300), &except_vec_ejtag_debug, 0x80);
+
+	/* 
+         * Copy the NMI exception vector handler code to it's final 
+         * destination.
+         */
+        memcpy((void *)(KSEG0 + 0x380), &except_vec_nmi, 0x80);
 
 	/*
 	 * Only some CPUs have the watch exceptions or a dedicated
Index: arch/mips64/kernel/r4k_genex.S
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/r4k_genex.S,v
retrieving revision 1.7.2.8
diff -u -r1.7.2.8 r4k_genex.S
--- arch/mips64/kernel/r4k_genex.S	2 Oct 2002 14:45:46 -0000	1.7.2.8
+++ arch/mips64/kernel/r4k_genex.S	10 Dec 2002 13:29:57 -0000
@@ -121,4 +121,72 @@
 1:	j	1b			/* Dummy, will be replaced */
 END(except_vec4)
 
+/*
+ * EJTAG debug exception handler.
+ * The EJTAG debug exception entry point is 0xbfc00480, which
+ * normally is in the boot PROM, so the boot PROM must do a
+ * unconditional jump to this vector.
+ */	
+NESTED(except_vec_ejtag_debug, 0, sp)
+	j	ejtag_debug_handler
+	 nop
+END(except_vec_ejtag_debug)
+
+/*
+ * NMI debug exception handler for MIPS reference boards.
+ * The NMI debug exception entry point is 0xbfc00000, which
+ * normally is in the boot PROM, so the boot PROM must do a
+ * unconditional jump to this vector.
+ */
+NESTED(except_vec_nmi, 0, sp)
+	j       nmi_handler
+	 nop
+END(except_vec_nmi)
+	
 	__FINIT
+
+/*
+ * EJTAG debug exception handler.
+ */
+NESTED(ejtag_debug_handler, PT_SIZE, sp)
+	.set	noat
+	.set	noreorder
+	dmtc0	k0, CP0_DESAVE
+	mfc0	k0, CP0_DEBUG	
+
+	sll	k0, k0, 30	# Check for SDBBP.
+	bgez	k0, ejtag_return
+
+	dla	k0, ejtag_debug_buffer
+	sd	k1, 0(k0)
+	SAVE_ALL
+	jal	ejtag_exception_handler
+	 move	a0, sp
+	RESTORE_ALL
+	dla	k0, ejtag_debug_buffer
+	ld	k1, 0(k0)	
+
+ejtag_return:
+	mfc0	k0, CP0_DESAVE	
+	.word	0x4200001f     # DERET, return from EJTAG debug exception.
+	 nop
+	.set	at
+END(ejtag_debug_handler)
+	
+NESTED(nmi_handler, PT_SIZE, sp)
+	.set    noat
+	.set    noreorder
+	SAVE_ALL
+	jal     nmi_exception_handler
+	 move   a0, sp
+	.set    at
+END(nmi_handler)		
+		
+/*
+ * This buffer is reserved for the use of the EJTAG debug 
+ * handler.
+ */
+	.data
+	.align 3
+	EXPORT(ejtag_debug_buffer)
+	.fill	8
\ No newline at end of file
Index: arch/mips64/kernel/traps.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/traps.c,v
retrieving revision 1.30.2.38
diff -u -r1.30.2.38 traps.c
--- arch/mips64/kernel/traps.c	5 Dec 2002 15:01:17 -0000	1.30.2.38
+++ arch/mips64/kernel/traps.c	10 Dec 2002 13:29:59 -0000
@@ -608,6 +608,13 @@
 
 asmlinkage void do_mcheck(struct pt_regs *regs)
 {
+	switch(mips_cpu.cputype) {
+	case CPU_5KC:
+	case CPU_20KC:
+		/* Clear the TS bit in the status register. */
+		clear_c0_status(0x00200000);
+		break;
+	}
 	show_regs(regs);
 	dump_tlb_all();
 	/*
@@ -638,6 +645,46 @@
 	}
 }
 
+/*
+ * SDBBP EJTAG debug exception handler.
+ * We skip the instruction and return to the next instruction.
+ */
+void ejtag_exception_handler(struct pt_regs *regs)
+{
+        unsigned long depc, old_epc;
+	unsigned int debug;
+
+        printk("SDBBP EJTAG debug exception - not handled yet, just ignored!\n");
+	depc = read_c0_depc();
+        debug = read_c0_debug();
+        printk("DEPC = %p, DEBUG = %08x\n", depc, debug); 
+        if (debug & 0x80000000) {
+                /* 
+                 * In branch delay slot.
+                 * We cheat a little bit here and use EPC to calculate the
+                 * debug return address (DEPC). EPC is restored after the
+                 * calculation.
+                 */
+                old_epc = regs->cp0_epc;
+                regs->cp0_epc = depc;
+                __compute_return_epc(regs);
+                depc = regs->cp0_epc;
+                regs->cp0_epc = old_epc;
+        } else
+                depc += 4;
+	write_c0_depc(depc);
+}
+
+/*
+ * NMI exception handler.
+ */
+void nmi_exception_handler(struct pt_regs *regs)
+{
+	printk("NMI taken: ERROREPC = %p\n", read_c0_errorepc());
+        die("NMI", regs);
+        while(1) ;  /* We die here. */
+}
+
 unsigned long exception_handlers[32];
 
 /*
@@ -702,6 +749,8 @@
 	extern char except_vec0_generic, except_vec2_generic;
 	extern char except_vec3_generic, except_vec3_r4000;
 	extern char except_vec4;
+	extern char except_vec_ejtag_debug;
+	extern char except_vec_nmi;
 	unsigned long i;
 
 	per_cpu_trap_init();
@@ -716,6 +765,19 @@
 	 */
 	for (i = 0; i <= 31; i++)
 		set_except_vector(i, handle_reserved);
+
+	/* 
+	 * Copy the EJTAG debug exception vector handler code to it's final 
+	 * destination.
+	 */
+	if (mips_cpu.options & MIPS_CPU_EJTAG)
+		memcpy((void *)(KSEG0 + 0x300), &except_vec_ejtag_debug, 0x80);
+
+	/* 
+         * Copy the NMI exception vector handler code to it's final 
+         * destination.
+         */
+        memcpy((void *)(KSEG0 + 0x380), &except_vec_nmi, 0x80);
 
 	/*
 	 * Only some CPUs have the watch exceptions or a dedicated

--------------D6449356168C4402DCE212F6--
