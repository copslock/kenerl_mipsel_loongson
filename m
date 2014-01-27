Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 16:28:50 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:4471 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825311AbaA0P14q4OyB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 16:27:56 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 10/15] mips: add MSA register definitions & access
Date:   Mon, 27 Jan 2014 15:23:09 +0000
Message-ID: <1390836194-26286-11-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1390836194-26286-1-git-send-email-paul.burton@imgtec.com>
References: <1390836194-26286-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_27_15_27_51
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39104
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

This patch introduces definitions for the MSA control registers and
functions which allow access to both the control & vector registers. If
the toolchain being used to build the kernel includes support for MSA
then this patch will make use of that support & use MSA instructions
directly. However toolchain support for MSA is very new & far from a
point where it can be reasonably expected that everyone building the
kernel uses a toolchain with support. Thus fallbacks using .word
assembler directives are also provided for now as a temporary measure.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/Makefile               |   5 ++
 arch/mips/include/asm/asmmacro.h | 121 +++++++++++++++++++++++++++
 arch/mips/include/asm/mipsregs.h |   1 +
 arch/mips/include/asm/msa.h      | 171 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 298 insertions(+)
 create mode 100644 arch/mips/include/asm/msa.h

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 873a0ca..86522e5 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -119,6 +119,11 @@ cflags-$(CONFIG_CPU_MICROMIPS) += $(call cc-option,-mmicromips)
 cflags-$(CONFIG_SB1XXX_CORELIS)	+= $(call cc-option,-mno-sched-prolog) \
 				   -fno-omit-frame-pointer
 
+ifeq ($(CONFIG_CPU_HAS_MSA),y)
+toolchain-msa			:= $(call cc-option-yn,-mhard-float -mfp64 -mmsa)
+cflags-$(toolchain-msa)		+= -DTOOLCHAIN_SUPPORTS_MSA
+endif
+
 #
 # CPU-dependent compiler/assembler options for optimization.
 #
diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index 2aa713f..c759501 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -196,4 +196,125 @@
 	 .word	0x41800000 | (\rt << 16) | (\rd << 11) | (\u << 5) | (\sel)
 	.endm
 
+#ifdef TOOLCHAIN_SUPPORTS_MSA
+	.macro	ld_d	wd, off, base
+	.set	push
+	.set	mips32r2
+	.set	msa
+	ld.d	$w\wd, \off(\base)
+	.set	pop
+	.endm
+
+	.macro	st_d	wd, off, base
+	.set	push
+	.set	mips32r2
+	.set	msa
+	st.d	$w\wd, \off(\base)
+	.set	pop
+	.endm
+
+	.macro	copy_u_w	rd, ws, n
+	.set	push
+	.set	mips32r2
+	.set	msa
+	copy_u.w \rd, $w\ws[\n]
+	.set	pop
+	.endm
+
+	.macro	copy_u_d	rd, ws, n
+	.set	push
+	.set	mips64r2
+	.set	msa
+	copy_u.d \rd, $w\ws[\n]
+	.set	pop
+	.endm
+
+	.macro	insert_w	wd, n, rs
+	.set	push
+	.set	mips32r2
+	.set	msa
+	insert.w $w\wd[\n], \rs
+	.set	pop
+	.endm
+
+	.macro	insert_d	wd, n, rs
+	.set	push
+	.set	mips64r2
+	.set	msa
+	insert.d $w\wd[\n], \rs
+	.set	pop
+	.endm
+#else
+	/*
+	 * Temporary until all toolchains in use include MSA support.
+	 */
+	.macro	cfcmsa	rd, cs
+	.set	push
+	.set	noat
+	.word	0x787e0059 | (\cs << 11)
+	move	\rd, $1
+	.set	pop
+	.endm
+
+	.macro	ctcmsa	cd, rs
+	.set	push
+	.set	noat
+	move	$1, \rs
+	.word	0x783e0819 | (\cd << 6)
+	.set	pop
+	.endm
+
+	.macro	ld_d	wd, off, base
+	.set	push
+	.set	noat
+	add	$1, \base, \off
+	.word	0x78000823 | (\wd << 6)
+	.set	pop
+	.endm
+
+	.macro	st_d	wd, off, base
+	.set	push
+	.set	noat
+	add	$1, \base, \off
+	.word	0x78000827 | (\wd << 6)
+	.set	pop
+	.endm
+
+	.macro	copy_u_w	rd, ws, n
+	.set	push
+	.set	noat
+	.word	0x78f00059 | (\n << 16) | (\ws << 11)
+	/* move triggers an assembler bug... */
+	or	\rd, $1, zero
+	.set	pop
+	.endm
+
+	.macro	copy_u_d	rd, ws, n
+	.set	push
+	.set	noat
+	.word	0x78f80059 | (\n << 16) | (\ws << 11)
+	/* move triggers an assembler bug... */
+	or	\rd, $1, zero
+	.set	pop
+	.endm
+
+	.macro	insert_w	wd, n, rs
+	.set	push
+	.set	noat
+	/* move triggers an assembler bug... */
+	or	$1, \rs, zero
+	.word	0x79300819 | (\n << 16) | (\wd << 6)
+	.set	pop
+	.endm
+
+	.macro	insert_d	wd, n, rs
+	.set	push
+	.set	noat
+	/* move triggers an assembler bug... */
+	or	$1, \rs, zero
+	.word	0x79380819 | (\n << 16) | (\wd << 6)
+	.set	pop
+	.endm
+#endif
+
 #endif /* _ASM_ASMMACRO_H */
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index bbc3dd4..f440c27 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1883,6 +1883,7 @@ change_c0_##name(unsigned int change, unsigned int newbits)	\
 __BUILD_SET_C0(status)
 __BUILD_SET_C0(cause)
 __BUILD_SET_C0(config)
+__BUILD_SET_C0(config5)
 __BUILD_SET_C0(intcontrol)
 __BUILD_SET_C0(intctl)
 __BUILD_SET_C0(srsmap)
diff --git a/arch/mips/include/asm/msa.h b/arch/mips/include/asm/msa.h
new file mode 100644
index 0000000..a306ea8
--- /dev/null
+++ b/arch/mips/include/asm/msa.h
@@ -0,0 +1,171 @@
+/*
+ * Copyright (C) 2013 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef _ASM_MSA_H
+#define _ASM_MSA_H
+
+#include <asm/mipsregs.h>
+
+static inline void enable_msa(void)
+{
+	if (cpu_has_msa)
+		set_c0_config5(MIPS_CONF5_MSAEN);
+}
+
+static inline void disable_msa(void)
+{
+	if (cpu_has_msa)
+		clear_c0_config5(MIPS_CONF5_MSAEN);
+}
+
+static inline int is_msa_enabled(void)
+{
+	if (!cpu_has_msa)
+		return 0;
+
+	return read_c0_config5() & MIPS_CONF5_MSAEN;
+}
+
+#ifdef TOOLCHAIN_SUPPORTS_MSA
+
+#define __BUILD_MSA_CTL_REG(name, cs)				\
+static inline unsigned int read_msa_##name(void)		\
+{								\
+	unsigned int reg;					\
+	__asm__ __volatile__(					\
+	"	.set	push\n"					\
+	"	.set	msa\n"					\
+	"	cfcmsa	%0, $" #cs "\n"				\
+	"	.set	pop\n"					\
+	: "=r"(reg));						\
+	return reg;						\
+}								\
+								\
+static inline void write_msa_##name(unsigned int val)		\
+{								\
+	__asm__ __volatile__(					\
+	"	.set	push\n"					\
+	"	.set	msa\n"					\
+	"	cfcmsa	$" #cs ", %0\n"				\
+	"	.set	pop\n"					\
+	: : "r"(val));						\
+}
+
+#else /* !TOOLCHAIN_SUPPORTS_MSA */
+
+/*
+ * Define functions using .word for the c[ft]cmsa instructions in order to
+ * allow compilation with toolchains that do not support MSA. Once all
+ * toolchains in use support MSA these can be removed.
+ */
+
+#define __BUILD_MSA_CTL_REG(name, cs)				\
+static inline unsigned int read_msa_##name(void)		\
+{								\
+	unsigned int reg;					\
+	__asm__ __volatile__(					\
+	"	.set	push\n"					\
+	"	.set	noat\n"					\
+	"	.word	0x787e0059 | (" #cs " << 11)\n"		\
+	"	move	%0, $1\n"				\
+	"	.set	pop\n"					\
+	: "=r"(reg));						\
+	return reg;						\
+}								\
+								\
+static inline void write_msa_##name(unsigned int val)		\
+{								\
+	__asm__ __volatile__(					\
+	"	.set	push\n"					\
+	"	.set	noat\n"					\
+	"	move	$1, %0\n"				\
+	"	.word	0x783e0819 | (" #cs " << 6)\n"		\
+	"	.set	pop\n"					\
+	: : "r"(val));						\
+}
+
+#endif /* !TOOLCHAIN_SUPPORTS_MSA */
+
+#define MSA_IR		0
+#define MSA_CSR		1
+#define MSA_ACCESS	2
+#define MSA_SAVE	3
+#define MSA_MODIFY	4
+#define MSA_REQUEST	5
+#define MSA_MAP		6
+#define MSA_UNMAP	7
+
+__BUILD_MSA_CTL_REG(ir, 0)
+__BUILD_MSA_CTL_REG(csr, 1)
+__BUILD_MSA_CTL_REG(access, 2)
+__BUILD_MSA_CTL_REG(save, 3)
+__BUILD_MSA_CTL_REG(modify, 4)
+__BUILD_MSA_CTL_REG(request, 5)
+__BUILD_MSA_CTL_REG(map, 6)
+__BUILD_MSA_CTL_REG(unmap, 7)
+
+/* MSA Implementation Register (MSAIR) */
+#define MSA_IR_REVB		0
+#define MSA_IR_REVF		(_ULCAST_(0xff) << MSA_IR_REVB)
+#define MSA_IR_PROCB		8
+#define MSA_IR_PROCF		(_ULCAST_(0xff) << MSA_IR_PROCB)
+#define MSA_IR_WRPB		16
+#define MSA_IR_WRPF		(_ULCAST_(0x1) << MSA_IR_WRPB)
+
+/* MSA Control & Status Register (MSACSR) */
+#define MSA_CSR_RMB		0
+#define MSA_CSR_RMF		(_ULCAST_(0x3) << MSA_CSR_RMB)
+#define MSA_CSR_RM_NEAREST	0
+#define MSA_CSR_RM_TO_ZERO	1
+#define MSA_CSR_RM_TO_POS	2
+#define MSA_CSR_RM_TO_NEG	3
+#define MSA_CSR_FLAGSB		2
+#define MSA_CSR_FLAGSF		(_ULCAST_(0x1f) << MSA_CSR_FLAGSB)
+#define MSA_CSR_FLAGS_IB	2
+#define MSA_CSR_FLAGS_IF	(_ULCAST_(0x1) << MSA_CSR_FLAGS_IB)
+#define MSA_CSR_FLAGS_UB	3
+#define MSA_CSR_FLAGS_UF	(_ULCAST_(0x1) << MSA_CSR_FLAGS_UB)
+#define MSA_CSR_FLAGS_OB	4
+#define MSA_CSR_FLAGS_OF	(_ULCAST_(0x1) << MSA_CSR_FLAGS_OB)
+#define MSA_CSR_FLAGS_ZB	5
+#define MSA_CSR_FLAGS_ZF	(_ULCAST_(0x1) << MSA_CSR_FLAGS_ZB)
+#define MSA_CSR_FLAGS_VB	6
+#define MSA_CSR_FLAGS_VF	(_ULCAST_(0x1) << MSA_CSR_FLAGS_VB)
+#define MSA_CSR_ENABLESB	7
+#define MSA_CSR_ENABLESF	(_ULCAST_(0x1f) << MSA_CSR_ENABLESB)
+#define MSA_CSR_ENABLES_IB	7
+#define MSA_CSR_ENABLES_IF	(_ULCAST_(0x1) << MSA_CSR_ENABLES_IB)
+#define MSA_CSR_ENABLES_UB	8
+#define MSA_CSR_ENABLES_UF	(_ULCAST_(0x1) << MSA_CSR_ENABLES_UB)
+#define MSA_CSR_ENABLES_OB	9
+#define MSA_CSR_ENABLES_OF	(_ULCAST_(0x1) << MSA_CSR_ENABLES_OB)
+#define MSA_CSR_ENABLES_ZB	10
+#define MSA_CSR_ENABLES_ZF	(_ULCAST_(0x1) << MSA_CSR_ENABLES_ZB)
+#define MSA_CSR_ENABLES_VB	11
+#define MSA_CSR_ENABLES_VF	(_ULCAST_(0x1) << MSA_CSR_ENABLES_VB)
+#define MSA_CSR_CAUSEB		12
+#define MSA_CSR_CAUSEF		(_ULCAST_(0x3f) << MSA_CSR_CAUSEB)
+#define MSA_CSR_CAUSE_IB	12
+#define MSA_CSR_CAUSE_IF	(_ULCAST_(0x1) << MSA_CSR_CAUSE_IB)
+#define MSA_CSR_CAUSE_UB	13
+#define MSA_CSR_CAUSE_UF	(_ULCAST_(0x1) << MSA_CSR_CAUSE_UB)
+#define MSA_CSR_CAUSE_OB	14
+#define MSA_CSR_CAUSE_OF	(_ULCAST_(0x1) << MSA_CSR_CAUSE_OB)
+#define MSA_CSR_CAUSE_ZB	15
+#define MSA_CSR_CAUSE_ZF	(_ULCAST_(0x1) << MSA_CSR_CAUSE_ZB)
+#define MSA_CSR_CAUSE_VB	16
+#define MSA_CSR_CAUSE_VF	(_ULCAST_(0x1) << MSA_CSR_CAUSE_VB)
+#define MSA_CSR_CAUSE_EB	17
+#define MSA_CSR_CAUSE_EF	(_ULCAST_(0x1) << MSA_CSR_CAUSE_EB)
+#define MSA_CSR_NXB		18
+#define MSA_CSR_NXF		(_ULCAST_(0x1) << MSA_CSR_NXB)
+#define MSA_CSR_FSB		24
+#define MSA_CSR_FSF		(_ULCAST_(0x1) << MSA_CSR_FSB)
+
+#endif /* _ASM_MSA_H */
-- 
1.8.5.3
