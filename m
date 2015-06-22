Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jun 2015 13:22:04 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5019 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006587AbbFVLWC72DQ3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Jun 2015 13:22:02 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B03193DE423C6;
        Mon, 22 Jun 2015 12:21:53 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 22 Jun 2015 12:21:56 +0100
Received: from localhost (192.168.37.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 22 Jun
 2015 12:21:55 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH v3 2/3] MIPS: introduce accessors for MSA vector registers
Date:   Mon, 22 Jun 2015 12:20:59 +0100
Message-ID: <1434972060-8865-3-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1434972060-8865-1-git-send-email-paul.burton@imgtec.com>
References: <1434972060-8865-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.37.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47999
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

Introduce accessor functions allowing the kernel to access arbitrary
vector registers using an arbitrary data format. The accessors are
implemented in assembly, using macros to avoid massive duplication, in
order to make use of the existing support for MSA with & without
toolchain support. The accessors will be used in a later patch.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v3:
- New patch

Changes in v2: None

 arch/mips/include/asm/asmmacro.h | 114 +++++++++++++++++++++++++++++++++++++++
 arch/mips/include/asm/msa.h      |  80 +++++++++++++++++++++++++++
 arch/mips/kernel/r4k_fpu.S       |  67 +++++++++++++++++++++++
 3 files changed, 261 insertions(+)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index 6156ac8..de53e13 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -227,6 +227,30 @@
 	.set	pop
 	.endm
 
+	.macro	ld_b	wd, off, base
+	.set	push
+	.set	mips32r2
+	.set	msa
+	ld.b	$w\wd, \off(\base)
+	.set	pop
+	.endm
+
+	.macro	ld_h	wd, off, base
+	.set	push
+	.set	mips32r2
+	.set	msa
+	ld.h	$w\wd, \off(\base)
+	.set	pop
+	.endm
+
+	.macro	ld_w	wd, off, base
+	.set	push
+	.set	mips32r2
+	.set	msa
+	ld.w	$w\wd, \off(\base)
+	.set	pop
+	.endm
+
 	.macro	ld_d	wd, off, base
 	.set	push
 	.set	mips32r2
@@ -235,6 +259,30 @@
 	.set	pop
 	.endm
 
+	.macro	st_b	wd, off, base
+	.set	push
+	.set	mips32r2
+	.set	msa
+	st.b	$w\wd, \off(\base)
+	.set	pop
+	.endm
+
+	.macro	st_h	wd, off, base
+	.set	push
+	.set	mips32r2
+	.set	msa
+	st.h	$w\wd, \off(\base)
+	.set	pop
+	.endm
+
+	.macro	st_w	wd, off, base
+	.set	push
+	.set	mips32r2
+	.set	msa
+	st.w	$w\wd, \off(\base)
+	.set	pop
+	.endm
+
 	.macro	st_d	wd, off, base
 	.set	push
 	.set	mips32r2
@@ -279,7 +327,13 @@
 #ifdef CONFIG_CPU_MICROMIPS
 #define CFC_MSA_INSN		0x587e0056
 #define CTC_MSA_INSN		0x583e0816
+#define LDB_MSA_INSN		0x58000807
+#define LDH_MSA_INSN		0x58000817
+#define LDW_MSA_INSN		0x58000827
 #define LDD_MSA_INSN		0x58000837
+#define STB_MSA_INSN		0x5800080f
+#define STH_MSA_INSN		0x5800081f
+#define STW_MSA_INSN		0x5800082f
 #define STD_MSA_INSN		0x5800083f
 #define COPY_UW_MSA_INSN	0x58f00056
 #define COPY_UD_MSA_INSN	0x58f80056
@@ -288,7 +342,13 @@
 #else
 #define CFC_MSA_INSN		0x787e0059
 #define CTC_MSA_INSN		0x783e0819
+#define LDB_MSA_INSN		0x78000820
+#define LDH_MSA_INSN		0x78000821
+#define LDW_MSA_INSN		0x78000822
 #define LDD_MSA_INSN		0x78000823
+#define STB_MSA_INSN		0x78000824
+#define STH_MSA_INSN		0x78000825
+#define STW_MSA_INSN		0x78000826
 #define STD_MSA_INSN		0x78000827
 #define COPY_UW_MSA_INSN	0x78f00059
 #define COPY_UD_MSA_INSN	0x78f80059
@@ -318,6 +378,33 @@
 	.set	pop
 	.endm
 
+	.macro	ld_b	wd, off, base
+	.set	push
+	.set	noat
+	SET_HARDFLOAT
+	addu	$1, \base, \off
+	.word	LDB_MSA_INSN | (\wd << 6)
+	.set	pop
+	.endm
+
+	.macro	ld_h	wd, off, base
+	.set	push
+	.set	noat
+	SET_HARDFLOAT
+	addu	$1, \base, \off
+	.word	LDH_MSA_INSN | (\wd << 6)
+	.set	pop
+	.endm
+
+	.macro	ld_w	wd, off, base
+	.set	push
+	.set	noat
+	SET_HARDFLOAT
+	addu	$1, \base, \off
+	.word	LDW_MSA_INSN | (\wd << 6)
+	.set	pop
+	.endm
+
 	.macro	ld_d	wd, off, base
 	.set	push
 	.set	noat
@@ -327,6 +414,33 @@
 	.set	pop
 	.endm
 
+	.macro	st_b	wd, off, base
+	.set	push
+	.set	noat
+	SET_HARDFLOAT
+	addu	$1, \base, \off
+	.word	STB_MSA_INSN | (\wd << 6)
+	.set	pop
+	.endm
+
+	.macro	st_h	wd, off, base
+	.set	push
+	.set	noat
+	SET_HARDFLOAT
+	addu	$1, \base, \off
+	.word	STH_MSA_INSN | (\wd << 6)
+	.set	pop
+	.endm
+
+	.macro	st_w	wd, off, base
+	.set	push
+	.set	noat
+	SET_HARDFLOAT
+	addu	$1, \base, \off
+	.word	STW_MSA_INSN | (\wd << 6)
+	.set	pop
+	.endm
+
 	.macro	st_d	wd, off, base
 	.set	push
 	.set	noat
diff --git a/arch/mips/include/asm/msa.h b/arch/mips/include/asm/msa.h
index af5638b..bbb85fe 100644
--- a/arch/mips/include/asm/msa.h
+++ b/arch/mips/include/asm/msa.h
@@ -14,10 +14,90 @@
 
 #ifndef __ASSEMBLY__
 
+#include <asm/inst.h>
+
 extern void _save_msa(struct task_struct *);
 extern void _restore_msa(struct task_struct *);
 extern void _init_msa_upper(void);
 
+extern void read_msa_wr_b(unsigned idx, union fpureg *to);
+extern void read_msa_wr_h(unsigned idx, union fpureg *to);
+extern void read_msa_wr_w(unsigned idx, union fpureg *to);
+extern void read_msa_wr_d(unsigned idx, union fpureg *to);
+
+/**
+ * read_msa_wr() - Read a single MSA vector register
+ * @idx:	The index of the vector register to read
+ * @to:		The FPU register union to store the registers value in
+ * @fmt:	The format of the data in the vector register
+ *
+ * Read the value of MSA vector register idx into the FPU register
+ * union to, using the format fmt.
+ */
+static inline void read_msa_wr(unsigned idx, union fpureg *to,
+			       enum msa_2b_fmt fmt)
+{
+	switch (fmt) {
+	case msa_fmt_b:
+		read_msa_wr_b(idx, to);
+		break;
+
+	case msa_fmt_h:
+		read_msa_wr_h(idx, to);
+		break;
+
+	case msa_fmt_w:
+		read_msa_wr_w(idx, to);
+		break;
+
+	case msa_fmt_d:
+		read_msa_wr_d(idx, to);
+		break;
+
+	default:
+		BUG();
+	}
+}
+
+extern void write_msa_wr_b(unsigned idx, union fpureg *from);
+extern void write_msa_wr_h(unsigned idx, union fpureg *from);
+extern void write_msa_wr_w(unsigned idx, union fpureg *from);
+extern void write_msa_wr_d(unsigned idx, union fpureg *from);
+
+/**
+ * write_msa_wr() - Write a single MSA vector register
+ * @idx:	The index of the vector register to write
+ * @from:	The FPU register union to take the registers value from
+ * @fmt:	The format of the data in the vector register
+ *
+ * Write the value from the FPU register union from into MSA vector
+ * register idx, using the format fmt.
+ */
+static inline void write_msa_wr(unsigned idx, union fpureg *from,
+				enum msa_2b_fmt fmt)
+{
+	switch (fmt) {
+	case msa_fmt_b:
+		write_msa_wr_b(idx, from);
+		break;
+
+	case msa_fmt_h:
+		write_msa_wr_h(idx, from);
+		break;
+
+	case msa_fmt_w:
+		write_msa_wr_w(idx, from);
+		break;
+
+	case msa_fmt_d:
+		write_msa_wr_d(idx, from);
+		break;
+
+	default:
+		BUG();
+	}
+}
+
 static inline void enable_msa(void)
 {
 	if (cpu_has_msa) {
diff --git a/arch/mips/kernel/r4k_fpu.S b/arch/mips/kernel/r4k_fpu.S
index 1d88af2..ca887da 100644
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -13,6 +13,7 @@
  * Copyright (C) 1999, 2001 Silicon Graphics, Inc.
  */
 #include <asm/asm.h>
+#include <asm/asmmacro.h>
 #include <asm/errno.h>
 #include <asm/fpregdef.h>
 #include <asm/mipsregs.h>
@@ -274,6 +275,72 @@ LEAF(_restore_fp_context32)
 	END(_restore_fp_context32)
 #endif
 
+#ifdef CONFIG_CPU_HAS_MSA
+
+	.macro	op_one_wr	op, idx, base
+	.align	4
+\idx:	\op	\idx, 0, \base
+	jr	ra
+	 nop
+	.endm
+
+	.macro	op_msa_wr	name, op
+LEAF(\name)
+	.set		push
+	.set		noreorder
+	sll		t0, a0, 4
+	PTR_LA		t1, 0f
+	PTR_ADDU	t0, t0, t1
+	jr		t0
+	  nop
+	op_one_wr	\op, 0, a1
+	op_one_wr	\op, 1, a1
+	op_one_wr	\op, 2, a1
+	op_one_wr	\op, 3, a1
+	op_one_wr	\op, 4, a1
+	op_one_wr	\op, 5, a1
+	op_one_wr	\op, 6, a1
+	op_one_wr	\op, 7, a1
+	op_one_wr	\op, 8, a1
+	op_one_wr	\op, 9, a1
+	op_one_wr	\op, 10, a1
+	op_one_wr	\op, 11, a1
+	op_one_wr	\op, 12, a1
+	op_one_wr	\op, 13, a1
+	op_one_wr	\op, 14, a1
+	op_one_wr	\op, 15, a1
+	op_one_wr	\op, 16, a1
+	op_one_wr	\op, 17, a1
+	op_one_wr	\op, 18, a1
+	op_one_wr	\op, 19, a1
+	op_one_wr	\op, 20, a1
+	op_one_wr	\op, 21, a1
+	op_one_wr	\op, 22, a1
+	op_one_wr	\op, 23, a1
+	op_one_wr	\op, 24, a1
+	op_one_wr	\op, 25, a1
+	op_one_wr	\op, 26, a1
+	op_one_wr	\op, 27, a1
+	op_one_wr	\op, 28, a1
+	op_one_wr	\op, 29, a1
+	op_one_wr	\op, 30, a1
+	op_one_wr	\op, 31, a1
+	.set		pop
+	END(\name)
+	.endm
+
+	op_msa_wr	read_msa_wr_b, st_b
+	op_msa_wr	read_msa_wr_h, st_h
+	op_msa_wr	read_msa_wr_w, st_w
+	op_msa_wr	read_msa_wr_d, st_d
+
+	op_msa_wr	write_msa_wr_b, ld_b
+	op_msa_wr	write_msa_wr_h, ld_h
+	op_msa_wr	write_msa_wr_w, ld_w
+	op_msa_wr	write_msa_wr_d, ld_d
+
+#endif /* CONFIG_CPU_HAS_MSA */
+
 	.set	reorder
 
 	.type	fault@function
-- 
2.4.2
