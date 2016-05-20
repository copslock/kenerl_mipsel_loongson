Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 00:30:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64601 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27031996AbcETW3E6bU1C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 00:29:04 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 350E9FA82EFC7;
        Fri, 20 May 2016 23:28:54 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 20 May 2016 23:28:58 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 20 May 2016 23:28:58 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 5/5] MIPS: Simplify DSP instruction encoding macros
Date:   Fri, 20 May 2016 23:28:41 +0100
Message-ID: <1463783321-24442-6-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 53570
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

Simplify the DSP instruction wrapper macros which use explicit encodings
for microMIPS and normal MIPS by using the new encoding macros and
removing duplication.

To me this makes it easier to read since it is much shorter, but it also
ensures .insn is used, preventing objdump disassembling the microMIPS
code as normal MIPS.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/mipsregs.h | 113 +++++++--------------------------------
 1 file changed, 20 insertions(+), 93 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index e4f6339a60b3..a5951f0981cc 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -2279,7 +2279,6 @@ do {									\
 
 #else
 
-#ifdef CONFIG_CPU_MICROMIPS
 #define rddsp(mask)							\
 ({									\
 	unsigned int __res;						\
@@ -2288,8 +2287,8 @@ do {									\
 	"	.set	push					\n"	\
 	"	.set	noat					\n"	\
 	"	# rddsp $1, %x1					\n"	\
-	"	.hword	((0x0020067c | (%x1 << 14)) >> 16)	\n"	\
-	"	.hword	((0x0020067c | (%x1 << 14)) & 0xffff)	\n"	\
+	_ASM_INSN_IF_MIPS(0x7c000cb8 | (%x1 << 16))			\
+	_ASM_INSN32_IF_MM(0x0020067c | (%x1 << 14))			\
 	"	move	%0, $1					\n"	\
 	"	.set	pop					\n"	\
 	: "=r" (__res)							\
@@ -2304,98 +2303,13 @@ do {									\
 	"	.set	noat					\n"	\
 	"	move	$1, %0					\n"	\
 	"	# wrdsp $1, %x1					\n"	\
-	"	.hword	((0x0020167c | (%x1 << 14)) >> 16)	\n"	\
-	"	.hword	((0x0020167c | (%x1 << 14)) & 0xffff)	\n"	\
+	_ASM_INSN_IF_MIPS(0x7c2004f8 | (%x1 << 11))			\
+	_ASM_INSN32_IF_MM(0x0020167c | (%x1 << 14))			\
 	"	.set	pop					\n"	\
 	:								\
 	: "r" (val), "i" (mask));					\
 } while (0)
 
-#define _umips_dsp_mfxxx(ins)						\
-({									\
-	unsigned long __treg;						\
-									\
-	__asm__ __volatile__(						\
-	"	.set	push					\n"	\
-	"	.set	noat					\n"	\
-	"	.hword	0x0001					\n"	\
-	"	.hword	%x1					\n"	\
-	"	move	%0, $1					\n"	\
-	"	.set	pop					\n"	\
-	: "=r" (__treg)							\
-	: "i" (ins));							\
-	__treg;								\
-})
-
-#define _umips_dsp_mtxxx(val, ins)					\
-do {									\
-	__asm__ __volatile__(						\
-	"	.set	push					\n"	\
-	"	.set	noat					\n"	\
-	"	move	$1, %0					\n"	\
-	"	.hword	0x0001					\n"	\
-	"	.hword	%x1					\n"	\
-	"	.set	pop					\n"	\
-	:								\
-	: "r" (val), "i" (ins));					\
-} while (0)
-
-#define _umips_dsp_mflo(reg) _umips_dsp_mfxxx((reg << 14) | 0x107c)
-#define _umips_dsp_mfhi(reg) _umips_dsp_mfxxx((reg << 14) | 0x007c)
-
-#define _umips_dsp_mtlo(val, reg) _umips_dsp_mtxxx(val, ((reg << 14) | 0x307c))
-#define _umips_dsp_mthi(val, reg) _umips_dsp_mtxxx(val, ((reg << 14) | 0x207c))
-
-#define mflo0() _umips_dsp_mflo(0)
-#define mflo1() _umips_dsp_mflo(1)
-#define mflo2() _umips_dsp_mflo(2)
-#define mflo3() _umips_dsp_mflo(3)
-
-#define mfhi0() _umips_dsp_mfhi(0)
-#define mfhi1() _umips_dsp_mfhi(1)
-#define mfhi2() _umips_dsp_mfhi(2)
-#define mfhi3() _umips_dsp_mfhi(3)
-
-#define mtlo0(x) _umips_dsp_mtlo(x, 0)
-#define mtlo1(x) _umips_dsp_mtlo(x, 1)
-#define mtlo2(x) _umips_dsp_mtlo(x, 2)
-#define mtlo3(x) _umips_dsp_mtlo(x, 3)
-
-#define mthi0(x) _umips_dsp_mthi(x, 0)
-#define mthi1(x) _umips_dsp_mthi(x, 1)
-#define mthi2(x) _umips_dsp_mthi(x, 2)
-#define mthi3(x) _umips_dsp_mthi(x, 3)
-
-#else  /* !CONFIG_CPU_MICROMIPS */
-#define rddsp(mask)							\
-({									\
-	unsigned int __res;						\
-									\
-	__asm__ __volatile__(						\
-	"	.set	push				\n"		\
-	"	.set	noat				\n"		\
-	"	# rddsp $1, %x1				\n"		\
-	"	.word	0x7c000cb8 | (%x1 << 16)	\n"		\
-	"	move	%0, $1				\n"		\
-	"	.set	pop				\n"		\
-	: "=r" (__res)							\
-	: "i" (mask));							\
-	__res;								\
-})
-
-#define wrdsp(val, mask)						\
-do {									\
-	__asm__ __volatile__(						\
-	"	.set	push					\n"	\
-	"	.set	noat					\n"	\
-	"	move	$1, %0					\n"	\
-	"	# wrdsp $1, %x1					\n"	\
-	"	.word	0x7c2004f8 | (%x1 << 11)		\n"	\
-	"	.set	pop					\n"	\
-        :								\
-	: "r" (val), "i" (mask));					\
-} while (0)
-
 #define _dsp_mfxxx(ins)							\
 ({									\
 	unsigned long __treg;						\
@@ -2403,7 +2317,8 @@ do {									\
 	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
 	"	.set	noat					\n"	\
-	"	.word	(0x00000810 | %1)			\n"	\
+	_ASM_INSN_IF_MIPS(0x00000810 | %X1)				\
+	_ASM_INSN32_IF_MM(0x0001007c | %x1)				\
 	"	move	%0, $1					\n"	\
 	"	.set	pop					\n"	\
 	: "=r" (__treg)							\
@@ -2417,18 +2332,31 @@ do {									\
 	"	.set	push					\n"	\
 	"	.set	noat					\n"	\
 	"	move	$1, %0					\n"	\
-	"	.word	(0x00200011 | %1)			\n"	\
+	_ASM_INSN_IF_MIPS(0x00200011 | %X1)				\
+	_ASM_INSN32_IF_MM(0x0001207c | %x1)				\
 	"	.set	pop					\n"	\
 	:								\
 	: "r" (val), "i" (ins));					\
 } while (0)
 
+#ifdef CONFIG_CPU_MICROMIPS
+
+#define _dsp_mflo(reg) _dsp_mfxxx((reg << 14) | 0x1000)
+#define _dsp_mfhi(reg) _dsp_mfxxx((reg << 14) | 0x0000)
+
+#define _dsp_mtlo(val, reg) _dsp_mtxxx(val, ((reg << 14) | 0x1000))
+#define _dsp_mthi(val, reg) _dsp_mtxxx(val, ((reg << 14) | 0x0000))
+
+#else  /* !CONFIG_CPU_MICROMIPS */
+
 #define _dsp_mflo(reg) _dsp_mfxxx((reg << 21) | 0x0002)
 #define _dsp_mfhi(reg) _dsp_mfxxx((reg << 21) | 0x0000)
 
 #define _dsp_mtlo(val, reg) _dsp_mtxxx(val, ((reg << 11) | 0x0002))
 #define _dsp_mthi(val, reg) _dsp_mtxxx(val, ((reg << 11) | 0x0000))
 
+#endif /* CONFIG_CPU_MICROMIPS */
+
 #define mflo0() _dsp_mflo(0)
 #define mflo1() _dsp_mflo(1)
 #define mflo2() _dsp_mflo(2)
@@ -2449,7 +2377,6 @@ do {									\
 #define mthi2(x) _dsp_mthi(x, 2)
 #define mthi3(x) _dsp_mthi(x, 3)
 
-#endif /* CONFIG_CPU_MICROMIPS */
 #endif
 
 /*
-- 
2.4.10
