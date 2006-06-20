Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2006 11:40:54 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:6362 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S8133545AbWFTKkj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Jun 2006 11:40:39 +0100
Received: from ala-mail04.corp.ad.wrs.com (ala-mail04 [147.11.57.145])
	by mail.wrs.com (8.13.6/8.13.3) with ESMTP id k5KAeWit022596;
	Tue, 20 Jun 2006 03:40:32 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ala-mail04.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 20 Jun 2006 03:40:32 -0700
Received: from [192.168.96.27] ([192.168.96.27]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 20 Jun 2006 03:40:31 -0700
Message-ID: <4497D09D.1040205@windriver.com>
Date:	Tue, 20 Jun 2006 18:40:29 +0800
From:	"Mark.Zhan" <rongkai.zhan@windriver.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To:	"Mark.Zhan" <rongkai.zhan@windriver.com>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Fix the build error of Wind River PPMC board
References: <4497CAA6.1010809@windriver.com>
In-Reply-To: <4497CAA6.1010809@windriver.com>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Jun 2006 10:40:32.0007 (UTC) FILETIME=[F465A170:01C69455]
Return-Path: <rongkai.zhan@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rongkai.zhan@windriver.com
Precedence: bulk
X-list: linux-mips

Hi,

Sorry for the stupid line wrap problem, again.

It is re-posted.

Signed-off-by: Rongkai.Zhan <rongkai.zhan@windriver.com>
------

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 89ec332..e38f0cd 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -360,7 +360,7 @@ config MIPS_SEAD
 	  board.
 
 config WR_PPMC
-	bool "Support for Wind River PPMC board"
+	bool "Wind River PPMC board"
 	select IRQ_CPU
 	select BOOT_ELF32
 	select DMA_NONCOHERENT
diff --git a/arch/mips/gt64120/wrppmc/Makefile b/arch/mips/gt64120/wrppmc/Makefile
index 72606b9..7cf5220 100644
--- a/arch/mips/gt64120/wrppmc/Makefile
+++ b/arch/mips/gt64120/wrppmc/Makefile
@@ -9,6 +9,6 @@
 # Makefile for the Wind River MIPS 4KC PPMC Eval Board
 #
 
-obj-y	+= int-handler.o irq.o reset.o setup.o time.o pci.o
+obj-y += irq.o reset.o setup.o time.o pci.o
 
 EXTRA_AFLAGS := $(CFLAGS)
diff --git a/arch/mips/gt64120/wrppmc/int-handler.S b/arch/mips/gt64120/wrppmc/int-handler.S
deleted file mode 100644
index edee7b3..0000000
--- a/arch/mips/gt64120/wrppmc/int-handler.S
+++ /dev/null
@@ -1,59 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1995, 1996, 1997, 2003 by Ralf Baechle
- * Copyright (C) Wind River System Inc. Rongkai.Zhan <rongkai.zhan@windriver.com>
- */
-#include <asm/asm.h>
-#include <asm/mipsregs.h>
-#include <asm/addrspace.h>
-#include <asm/regdef.h>
-#include <asm/stackframe.h>
-#include <asm/mach-wrppmc/mach-gt64120.h>
-
-	.align	5
-	.set	noat
-NESTED(handle_IRQ, PT_SIZE, sp)
-	SAVE_ALL
-	CLI				# Important: mark KERNEL mode !
-	.set	at
-
-	mfc0	t0, CP0_CAUSE		# get pending interrupts
-	mfc0	t1, CP0_STATUS		# get enabled interrupts
-	and	t0, t0, t1		# get allowed interrupts
-	andi	t0, t0, 0xFF00
-	beqz	t0, 1f
-	move	a1, sp			# Prepare 'struct pt_regs *regs' pointer
-
-	andi	t1, t0, CAUSEF_IP7	# CPU Compare/Count internal timer
-	bnez	t1, handle_cputimer_irq
-	andi	t1, t0, CAUSEF_IP6	# UART 16550 port
-	bnez	t1, handle_uart_irq
-	andi	t1, t0, CAUSEF_IP3	# PCI INT_A
-	bnez	t1, handle_pci_intA_irq
-
-	/* wrong alarm or masked ... */
-1:	j	spurious_interrupt
-	nop
-END(handle_IRQ)
-
-	.align	5
-handle_cputimer_irq:
-	li	a0, WRPPMC_MIPS_TIMER_IRQ
-	jal	do_IRQ
-	j	ret_from_irq
-
-	.align	5
-handle_uart_irq:
-	li	a0, WRPPMC_UART16550_IRQ
-	jal	do_IRQ
-	j	ret_from_irq
-
-	.align	5
-handle_pci_intA_irq:
-	li	a0, WRPPMC_PCI_INTA_IRQ
-	jal	do_IRQ
-	j	ret_from_irq
-
diff --git a/arch/mips/gt64120/wrppmc/irq.c b/arch/mips/gt64120/wrppmc/irq.c
index 8605687..80d6b79 100644
--- a/arch/mips/gt64120/wrppmc/irq.c
+++ b/arch/mips/gt64120/wrppmc/irq.c
@@ -30,7 +30,19 @@
 #include <asm/irq_cpu.h>
 #include <asm/gt64120.h>
 
-extern asmlinkage void handle_IRQ(void);
+asmlinkage void plat_irq_dispatch(struct pt_regs *regs)
+{
+	unsigned int pending = read_c0_status() & read_c0_cause();
+	
+	if (pending & STATUSF_IP7)
+		do_IRQ(WRPPMC_MIPS_TIMER_IRQ, regs);	/* CPU Compare/Count internal timer */
+	else if (pending & STATUSF_IP6)
+		do_IRQ(WRPPMC_UART16550_IRQ, regs);	/* UART 16550 port */
+	else if (pending & STATUSF_IP3)
+		do_IRQ(WRPPMC_PCI_INTA_IRQ, regs);	/* PCI INT_A */
+	else
+		spurious_interrupt(regs);
+}
 
 /**
  * Initialize GT64120 Interrupt Controller
@@ -53,9 +65,6 @@ void __init arch_init_irq(void)
 	/* enable all CPU interrupt bits. */
 	set_c0_status(ST0_IM);	/* IE bit is still 0 */
 
-	/* Install MIPS Interrupt Trap Vector */
-	set_except_vector(0, handle_IRQ);
-
 	/* IRQ 0 - 7 are for MIPS common irq_cpu controller */
 	mips_cpu_irq_init(0);
 
diff --git a/arch/mips/gt64120/wrppmc/setup.c b/arch/mips/gt64120/wrppmc/setup.c
index 20c591e..2db6375 100644
--- a/arch/mips/gt64120/wrppmc/setup.c
+++ b/arch/mips/gt64120/wrppmc/setup.c
@@ -125,7 +125,7 @@ static void wrppmc_setup_serial(void)
 }
 #endif
 
-void __init plat_setup(void)
+void __init plat_mem_setup(void)
 {
 	extern void wrppmc_time_init(void);
 	extern void wrppmc_timer_setup(struct irqaction *);
