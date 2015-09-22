Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 20:13:37 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56611 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008792AbbIVSNdYvXrU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 20:13:33 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id F0757899D4A9;
        Tue, 22 Sep 2015 19:13:22 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 19:13:26 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 19:13:25 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        "Leonid Yegoshin" <Leonid.Yegoshin@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        "Markos Chandras" <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 03/10] MIPS: CPS: early debug using an ns16550-compatible UART
Date:   Tue, 22 Sep 2015 11:12:11 -0700
Message-ID: <1442945538-26141-4-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1442945538-26141-1-git-send-email-paul.burton@imgtec.com>
References: <1442945538-26141-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Provide support for outputting early debug information, in the form of
various register values should an exception occur, during the early
bringup of secondary cores. This code requires an ns16550-compatible
UART accessible from the secondary core, and is written in assembly due
to the environment in which such early exceptions occur where way may
not have a stack, be coherent or even have initialised caches.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/Kconfig.debug            |  26 +++++
 arch/mips/include/asm/mipsregs.h   |   3 +
 arch/mips/kernel/Makefile          |   1 +
 arch/mips/kernel/cps-vec-ns16550.S | 202 +++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/cps-vec.S         |  20 ++++
 5 files changed, 252 insertions(+)
 create mode 100644 arch/mips/kernel/cps-vec-ns16550.S

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index e250524..7b109cd 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -113,4 +113,30 @@ config SPINLOCK_TEST
 	help
 	  Add several files to the debugfs to test spinlock speed.
 
+menuconfig MIPS_CPS_NS16550
+	bool "CPS SMP NS16550 UART output"
+	depends on MIPS_CPS
+	help
+	  Output debug information via an ns16550 compatible UART if exceptions
+	  occur early in the boot process of a secondary core.
+
+if MIPS_CPS_NS16550
+
+config MIPS_CPS_NS16550_BASE
+	hex "UART Base Address"
+	default 0x1b0003f8 if MIPS_MALTA
+	help
+	  The base address of the ns16550 compatible UART on which to output
+	  debug information from the early stages of core startup.
+
+config MIPS_CPS_NS16550_SHIFT
+	int "UART Register Shift"
+	default 0 if MIPS_MALTA
+	help
+	  The number of bits to shift ns16550 register indices by in order to
+	  form their addresses. That is, log base 2 of the span between
+	  adjacent ns16550 registers in the system.
+
+endif # MIPS_CPS_NS16550
+
 endmenu
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index d3cd8ea..d626d71 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -51,6 +51,7 @@
 #define CP0_WIRED $6
 #define CP0_INFO $7
 #define CP0_BADVADDR $8
+#define CP0_BADINSTR $8, 1
 #define CP0_COUNT $9
 #define CP0_ENTRYHI $10
 #define CP0_COMPARE $11
@@ -58,6 +59,8 @@
 #define CP0_CAUSE $13
 #define CP0_EPC $14
 #define CP0_PRID $15
+#define CP0_EBASE $15, 1
+#define CP0_CMGCRBASE $15, 3
 #define CP0_CONFIG $16
 #define CP0_LLADDR $17
 #define CP0_WATCHLO $18
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index d982be1..68e2b7d 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_MIPS_MT_FPAFF)	+= mips-mt-fpaff.o
 obj-$(CONFIG_MIPS_MT_SMP)	+= smp-mt.o
 obj-$(CONFIG_MIPS_CMP)		+= smp-cmp.o
 obj-$(CONFIG_MIPS_CPS)		+= smp-cps.o cps-vec.o
+obj-$(CONFIG_MIPS_CPS_NS16550)	+= cps-vec-ns16550.o
 obj-$(CONFIG_MIPS_GIC_IPI)	+= smp-gic.o
 obj-$(CONFIG_MIPS_SPRAM)	+= spram.o
 
diff --git a/arch/mips/kernel/cps-vec-ns16550.S b/arch/mips/kernel/cps-vec-ns16550.S
new file mode 100644
index 0000000..6d246ad
--- /dev/null
+++ b/arch/mips/kernel/cps-vec-ns16550.S
@@ -0,0 +1,202 @@
+/*
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <asm/addrspace.h>
+#include <asm/asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/mipsregs.h>
+#include <asm/regdef.h>
+#include <linux/serial_reg.h>
+
+#define UART_TX_OFS	(UART_TX << CONFIG_MIPS_CPS_NS16550_SHIFT)
+#define UART_LSR_OFS	(UART_LSR << CONFIG_MIPS_CPS_NS16550_SHIFT)
+
+/**
+ * _mips_cps_putc() - write a character to the UART
+ * @a0: ASCII character to write
+ * @t9: UART base address
+ */
+LEAF(_mips_cps_putc)
+1:	lw		t0, UART_LSR_OFS(t9)
+	andi		t0, t0, UART_LSR_TEMT
+	beqz		t0, 1b
+	sb		a0, UART_TX_OFS(t9)
+	jr		ra
+	END(_mips_cps_putc)
+
+/**
+ * _mips_cps_puts() - write a string to the UART
+ * @a0: pointer to NULL-terminated ASCII string
+ * @t9: UART base address
+ *
+ * Write a null-terminated ASCII string to the UART.
+ */
+NESTED(_mips_cps_puts, 0, ra)
+	move		s7, ra
+	move		s6, a0
+
+1:	lb		a0, 0(s6)
+	beqz		a0, 2f
+	jal		_mips_cps_putc
+	PTR_ADDIU	s6, s6, 1
+	b		1b
+
+2:	jr		s7
+	END(_mips_cps_puts)
+
+/**
+ * _mips_cps_putx4 - write a 4b hex value to the UART
+ * @a0: the 4b value to write to the UART
+ * @t9: UART base address
+ *
+ * Write a single hexadecimal character to the UART.
+ */
+NESTED(_mips_cps_putx4, 0, ra)
+	andi		a0, a0, 0xf
+	li		t0, '0'
+	blt		a0, 10, 1f
+	li		t0, 'a'
+	addiu		a0, a0, -10
+1:	addu		a0, a0, t0
+	b		_mips_cps_putc
+	END(_mips_cps_putx4)
+
+/**
+ * _mips_cps_putx8 - write an 8b hex value to the UART
+ * @a0: the 8b value to write to the UART
+ * @t9: UART base address
+ *
+ * Write an 8 bit value (ie. 2 hexadecimal characters) to the UART.
+ */
+NESTED(_mips_cps_putx8, 0, ra)
+	move		s3, ra
+	move		s2, a0
+	srl		a0, a0, 4
+	jal		_mips_cps_putx4
+	move		a0, s2
+	move		ra, s3
+	b		_mips_cps_putx4
+	END(_mips_cps_putx8)
+
+/**
+ * _mips_cps_putx16 - write a 16b hex value to the UART
+ * @a0: the 16b value to write to the UART
+ * @t9: UART base address
+ *
+ * Write a 16 bit value (ie. 4 hexadecimal characters) to the UART.
+ */
+NESTED(_mips_cps_putx16, 0, ra)
+	move		s5, ra
+	move		s4, a0
+	srl		a0, a0, 8
+	jal		_mips_cps_putx8
+	move		a0, s4
+	move		ra, s5
+	b		_mips_cps_putx8
+	END(_mips_cps_putx16)
+
+/**
+ * _mips_cps_putx32 - write a 32b hex value to the UART
+ * @a0: the 32b value to write to the UART
+ * @t9: UART base address
+ *
+ * Write a 32 bit value (ie. 8 hexadecimal characters) to the UART.
+ */
+NESTED(_mips_cps_putx32, 0, ra)
+	move		s7, ra
+	move		s6, a0
+	srl		a0, a0, 16
+	jal		_mips_cps_putx16
+	move		a0, s6
+	move		ra, s7
+	b		_mips_cps_putx16
+	END(_mips_cps_putx32)
+
+#ifdef CONFIG_64BIT
+
+/**
+ * _mips_cps_putx64 - write a 64b hex value to the UART
+ * @a0: the 64b value to write to the UART
+ * @t9: UART base address
+ *
+ * Write a 64 bit value (ie. 16 hexadecimal characters) to the UART.
+ */
+NESTED(_mips_cps_putx64, 0, ra)
+	move		sp, ra
+	move		s8, a0
+	dsrl32		a0, a0, 0
+	jal		_mips_cps_putx32
+	move		a0, s8
+	move		ra, sp
+	b		_mips_cps_putx32
+	END(_mips_cps_putx64)
+
+#define _mips_cps_putxlong _mips_cps_putx64
+
+#else /* !CONFIG_64BIT */
+
+#define _mips_cps_putxlong _mips_cps_putx32
+
+#endif /* !CONFIG_64BIT */
+
+/**
+ * mips_cps_bev_dump() - dump relevant exception state to UART
+ * @a0: pointer to NULL-terminated ASCII string naming the exception
+ *
+ * Write information that may be useful in debugging an exception to the
+ * UART configured by CONFIG_MIPS_CPS_NS16550_*. As this BEV exception
+ * will only be run if something goes horribly wrong very early during
+ * the bringup of a core and it is very likely to be unsafe to perform
+ * memory accesses at that point (cache state indeterminate, EVA may not
+ * be configured, coherence may be disabled) let alone have a stack,
+ * this is all written in assembly using only registers & unmapped
+ * uncached access to the UART registers.
+ */
+LEAF(mips_cps_bev_dump)
+	move		s0, ra
+	move		s1, a0
+
+	li		t9, CKSEG1ADDR(CONFIG_MIPS_CPS_NS16550_BASE)
+
+	PTR_LA		a0, str_newline
+	jal		_mips_cps_puts
+	PTR_LA		a0, str_bev
+	jal		_mips_cps_puts
+	move		a0, s1
+	jal		_mips_cps_puts
+	PTR_LA		a0, str_newline
+	jal		_mips_cps_puts
+	PTR_LA		a0, str_newline
+	jal		_mips_cps_puts
+
+#define DUMP_COP0_REG(reg, name, sz, _mfc0)		\
+	PTR_LA		a0, 8f;				\
+	jal		_mips_cps_puts;			\
+	_mfc0		a0, reg;			\
+	jal		_mips_cps_putx##sz;		\
+	PTR_LA		a0, str_newline;		\
+	jal		_mips_cps_puts;			\
+	TEXT(name)
+
+	DUMP_COP0_REG(CP0_CAUSE,    "Cause:    0x", 32, mfc0)
+	DUMP_COP0_REG(CP0_STATUS,   "Status:   0x", 32, mfc0)
+	DUMP_COP0_REG(CP0_EBASE,    "EBase:    0x", long, MFC0)
+	DUMP_COP0_REG(CP0_BADVADDR, "BadVAddr: 0x", long, MFC0)
+	DUMP_COP0_REG(CP0_BADINSTR, "BadInstr: 0x", 32, mfc0)
+
+	PTR_LA		a0, str_newline
+	jal		_mips_cps_puts
+	jr		s0
+	END(mips_cps_bev_dump)
+
+.pushsection	.data
+str_bev: .asciiz "BEV Exception: "
+str_newline: .asciiz "\r\n"
+.popsection
diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 99bf6aa..a9cc16a 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -31,6 +31,20 @@
 # define STATUS_BITDEPS		0
 #endif
 
+#ifdef CONFIG_MIPS_CPS_NS16550
+
+#define DUMP_EXCEP(name)		\
+	PTR_LA	a0, 8f;			\
+	jal	mips_cps_bev_dump;	\
+	 nop;				\
+	TEXT(name)
+
+#else /* !CONFIG_MIPS_CPS_NS16550 */
+
+#define DUMP_EXCEP(name)
+
+#endif /* !CONFIG_MIPS_CPS_NS16550 */
+
 	/*
 	 * Set dest to non-zero if the core supports the MT ASE, else zero. If
 	 * MT is not supported then branch to nomt.
@@ -193,36 +207,42 @@ dcache_done:
 
 .org 0x200
 LEAF(excep_tlbfill)
+	DUMP_EXCEP("TLB Fill")
 	b	.
 	 nop
 	END(excep_tlbfill)
 
 .org 0x280
 LEAF(excep_xtlbfill)
+	DUMP_EXCEP("XTLB Fill")
 	b	.
 	 nop
 	END(excep_xtlbfill)
 
 .org 0x300
 LEAF(excep_cache)
+	DUMP_EXCEP("Cache")
 	b	.
 	 nop
 	END(excep_cache)
 
 .org 0x380
 LEAF(excep_genex)
+	DUMP_EXCEP("General")
 	b	.
 	 nop
 	END(excep_genex)
 
 .org 0x400
 LEAF(excep_intex)
+	DUMP_EXCEP("Interrupt")
 	b	.
 	 nop
 	END(excep_intex)
 
 .org 0x480
 LEAF(excep_ejtag)
+	DUMP_EXCEP("EJTAG")
 	PTR_LA	k0, ejtag_debug_handler
 	jr	k0
 	 nop
-- 
2.5.3
