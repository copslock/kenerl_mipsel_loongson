Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 00:29:40 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47360 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27031995AbcETW3DpyijC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 00:29:03 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 34F2BB2588623;
        Fri, 20 May 2016 23:28:53 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 20 May 2016 23:28:57 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 20 May 2016 23:28:56 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 3/5] MIPS: Fix little endian microMIPS MSA encodings
Date:   Fri, 20 May 2016 23:28:39 +0100
Message-ID: <1463783321-24442-4-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1463783321-24442-1-git-send-email-james.hogan@imgtec.com>
References: <1463783321-24442-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

When the toolchain doesn't support MSA we encode MSA instructions
explicitly in assembly. Unfortunately we use .word for both MIPS and
microMIPS encodings which is wrong, since 32-bit microMIPS instructions
are made up from a pair of halfwords.

- The most significant halfword always comes first, so for little endian
  builds the halves will be emitted in the wrong order.

- 32-bit alignment isn't guaranteed, so the assembler may insert a
  16-bit nop instruction to pad the instruction stream to a 32-bit
  boundary.

Use the new instruction encoding macros to encode microMIPS MSA
instructions correctly.

Fixes: d96cc3d1ec5d ("MIPS: Add microMIPS MSA support.")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <Paul.Burton@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/asmmacro.h | 99 ++++++++++++++++++++--------------------
 arch/mips/include/asm/msa.h      | 21 ++++-----
 2 files changed, 58 insertions(+), 62 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index 6741673c92ca..56584a659183 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -19,6 +19,28 @@
 #include <asm/asmmacro-64.h>
 #endif
 
+/*
+ * Helper macros for generating raw instruction encodings.
+ */
+#ifdef CONFIG_CPU_MICROMIPS
+	.macro	insn32_if_mm enc
+	.insn
+	.hword ((\enc) >> 16)
+	.hword ((\enc) & 0xffff)
+	.endm
+
+	.macro	insn_if_mips enc
+	.endm
+#else
+	.macro	insn32_if_mm enc
+	.endm
+
+	.macro	insn_if_mips enc
+	.insn
+	.word (\enc)
+	.endm
+#endif
+
 #if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	.macro	local_irq_enable reg=t0
 	ei
@@ -341,38 +363,6 @@
 	.endm
 #else
 
-#ifdef CONFIG_CPU_MICROMIPS
-#define CFC_MSA_INSN		0x587e0056
-#define CTC_MSA_INSN		0x583e0816
-#define LDB_MSA_INSN		0x58000807
-#define LDH_MSA_INSN		0x58000817
-#define LDW_MSA_INSN		0x58000827
-#define LDD_MSA_INSN		0x58000837
-#define STB_MSA_INSN		0x5800080f
-#define STH_MSA_INSN		0x5800081f
-#define STW_MSA_INSN		0x5800082f
-#define STD_MSA_INSN		0x5800083f
-#define COPY_SW_MSA_INSN	0x58b00056
-#define COPY_SD_MSA_INSN	0x58b80056
-#define INSERT_W_MSA_INSN	0x59300816
-#define INSERT_D_MSA_INSN	0x59380816
-#else
-#define CFC_MSA_INSN		0x787e0059
-#define CTC_MSA_INSN		0x783e0819
-#define LDB_MSA_INSN		0x78000820
-#define LDH_MSA_INSN		0x78000821
-#define LDW_MSA_INSN		0x78000822
-#define LDD_MSA_INSN		0x78000823
-#define STB_MSA_INSN		0x78000824
-#define STH_MSA_INSN		0x78000825
-#define STW_MSA_INSN		0x78000826
-#define STD_MSA_INSN		0x78000827
-#define COPY_SW_MSA_INSN	0x78b00059
-#define COPY_SD_MSA_INSN	0x78b80059
-#define INSERT_W_MSA_INSN	0x79300819
-#define INSERT_D_MSA_INSN	0x79380819
-#endif
-
 	/*
 	 * Temporary until all toolchains in use include MSA support.
 	 */
@@ -380,8 +370,8 @@
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
-	.insn
-	.word	CFC_MSA_INSN | (\cs << 11)
+	insn_if_mips 0x787e0059 | (\cs << 11)
+	insn32_if_mm 0x587e0056 | (\cs << 11)
 	move	\rd, $1
 	.set	pop
 	.endm
@@ -391,7 +381,8 @@
 	.set	noat
 	SET_HARDFLOAT
 	move	$1, \rs
-	.word	CTC_MSA_INSN | (\cd << 6)
+	insn_if_mips 0x783e0819 | (\cd << 6)
+	insn32_if_mm 0x583e0816 | (\cd << 6)
 	.set	pop
 	.endm
 
@@ -400,7 +391,8 @@
 	.set	noat
 	SET_HARDFLOAT
 	PTR_ADDU $1, \base, \off
-	.word	LDB_MSA_INSN | (\wd << 6)
+	insn_if_mips 0x78000820 | (\wd << 6)
+	insn32_if_mm 0x58000807 | (\wd << 6)
 	.set	pop
 	.endm
 
@@ -409,7 +401,8 @@
 	.set	noat
 	SET_HARDFLOAT
 	PTR_ADDU $1, \base, \off
-	.word	LDH_MSA_INSN | (\wd << 6)
+	insn_if_mips 0x78000821 | (\wd << 6)
+	insn32_if_mm 0x58000817 | (\wd << 6)
 	.set	pop
 	.endm
 
@@ -418,7 +411,8 @@
 	.set	noat
 	SET_HARDFLOAT
 	PTR_ADDU $1, \base, \off
-	.word	LDW_MSA_INSN | (\wd << 6)
+	insn_if_mips 0x78000822 | (\wd << 6)
+	insn32_if_mm 0x58000827 | (\wd << 6)
 	.set	pop
 	.endm
 
@@ -427,7 +421,8 @@
 	.set	noat
 	SET_HARDFLOAT
 	PTR_ADDU $1, \base, \off
-	.word	LDD_MSA_INSN | (\wd << 6)
+	insn_if_mips 0x78000823 | (\wd << 6)
+	insn32_if_mm 0x58000837 | (\wd << 6)
 	.set	pop
 	.endm
 
@@ -436,7 +431,8 @@
 	.set	noat
 	SET_HARDFLOAT
 	PTR_ADDU $1, \base, \off
-	.word	STB_MSA_INSN | (\wd << 6)
+	insn_if_mips 0x78000824 | (\wd << 6)
+	insn32_if_mm 0x5800080f | (\wd << 6)
 	.set	pop
 	.endm
 
@@ -445,7 +441,8 @@
 	.set	noat
 	SET_HARDFLOAT
 	PTR_ADDU $1, \base, \off
-	.word	STH_MSA_INSN | (\wd << 6)
+	insn_if_mips 0x78000825 | (\wd << 6)
+	insn32_if_mm 0x5800081f | (\wd << 6)
 	.set	pop
 	.endm
 
@@ -454,7 +451,8 @@
 	.set	noat
 	SET_HARDFLOAT
 	PTR_ADDU $1, \base, \off
-	.word	STW_MSA_INSN | (\wd << 6)
+	insn_if_mips 0x78000826 | (\wd << 6)
+	insn32_if_mm 0x5800082f | (\wd << 6)
 	.set	pop
 	.endm
 
@@ -463,7 +461,8 @@
 	.set	noat
 	SET_HARDFLOAT
 	PTR_ADDU $1, \base, \off
-	.word	STD_MSA_INSN | (\wd << 6)
+	insn_if_mips 0x78000827 | (\wd << 6)
+	insn32_if_mm 0x5800083f | (\wd << 6)
 	.set	pop
 	.endm
 
@@ -471,8 +470,8 @@
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
-	.insn
-	.word	COPY_SW_MSA_INSN | (\n << 16) | (\ws << 11)
+	insn_if_mips 0x78b00059 | (\n << 16) | (\ws << 11)
+	insn32_if_mm 0x58b00056 | (\n << 16) | (\ws << 11)
 	.set	pop
 	.endm
 
@@ -480,8 +479,8 @@
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
-	.insn
-	.word	COPY_SD_MSA_INSN | (\n << 16) | (\ws << 11)
+	insn_if_mips 0x78b80059 | (\n << 16) | (\ws << 11)
+	insn32_if_mm 0x58b80056 | (\n << 16) | (\ws << 11)
 	.set	pop
 	.endm
 
@@ -489,7 +488,8 @@
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
-	.word	INSERT_W_MSA_INSN | (\n << 16) | (\wd << 6)
+	insn_if_mips 0x79300819 | (\n << 16) | (\wd << 6)
+	insn32_if_mm 0x59300816 | (\n << 16) | (\wd << 6)
 	.set	pop
 	.endm
 
@@ -497,7 +497,8 @@
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
-	.word	INSERT_D_MSA_INSN | (\n << 16) | (\wd << 6)
+	insn_if_mips 0x79380819 | (\n << 16) | (\wd << 6)
+	insn32_if_mm 0x59380816 | (\n << 16) | (\wd << 6)
 	.set	pop
 	.endm
 #endif
diff --git a/arch/mips/include/asm/msa.h b/arch/mips/include/asm/msa.h
index 6e4effa6f626..ddf496cb2a2a 100644
--- a/arch/mips/include/asm/msa.h
+++ b/arch/mips/include/asm/msa.h
@@ -192,13 +192,6 @@ static inline void write_msa_##name(unsigned int val)		\
  * allow compilation with toolchains that do not support MSA. Once all
  * toolchains in use support MSA these can be removed.
  */
-#ifdef CONFIG_CPU_MICROMIPS
-#define CFC_MSA_INSN	0x587e0056
-#define CTC_MSA_INSN	0x583e0816
-#else
-#define CFC_MSA_INSN	0x787e0059
-#define CTC_MSA_INSN	0x783e0819
-#endif
 
 #define __BUILD_MSA_CTL_REG(name, cs)				\
 static inline unsigned int read_msa_##name(void)		\
@@ -207,11 +200,12 @@ static inline unsigned int read_msa_##name(void)		\
 	__asm__ __volatile__(					\
 	"	.set	push\n"					\
 	"	.set	noat\n"					\
-	"	.insn\n"					\
-	"	.word	%1 | (" #cs " << 11)\n"			\
+	"	# cfcmsa $1, $%1\n"				\
+	_ASM_INSN_IF_MIPS(0x787e0059 | %1 << 11)		\
+	_ASM_INSN32_IF_MM(0x587e0056 | %1 << 11)		\
 	"	move	%0, $1\n"				\
 	"	.set	pop\n"					\
-	: "=r"(reg) : "i"(CFC_MSA_INSN));			\
+	: "=r"(reg) : "i"(cs));					\
 	return reg;						\
 }								\
 								\
@@ -221,10 +215,11 @@ static inline void write_msa_##name(unsigned int val)		\
 	"	.set	push\n"					\
 	"	.set	noat\n"					\
 	"	move	$1, %0\n"				\
-	"	.insn\n"					\
-	"	.word	%1 | (" #cs " << 6)\n"			\
+	"	# ctcmsa $%1, $1\n"				\
+	_ASM_INSN_IF_MIPS(0x783e0819 | %1 << 6)			\
+	_ASM_INSN32_IF_MM(0x583e0816 | %1 << 6)			\
 	"	.set	pop\n"					\
-	: : "r"(val), "i"(CTC_MSA_INSN));			\
+	: : "r"(val), "i"(cs));					\
 }
 
 #endif /* !TOOLCHAIN_SUPPORTS_MSA */
-- 
2.4.10
