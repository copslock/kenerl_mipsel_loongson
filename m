Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2012 23:41:18 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:49870 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903754Ab2GXVkL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jul 2012 23:40:11 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Stmpp-0003y0-A4; Tue, 24 Jul 2012 16:40:05 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH v2,1/9] MIPS: Add microMIPS breakpoints and DSP support.
Date:   Tue, 24 Jul 2012 16:40:00 -0500
Message-Id: <1343166000-1682-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.11.1
X-archive-position: 33974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/break.h    |   7 +
 arch/mips/include/asm/dsp.h      |   4 +
 arch/mips/include/asm/mipsregs.h | 333 ++++++++++++++++-----------------------
 3 files changed, 143 insertions(+), 201 deletions(-)

diff --git a/arch/mips/include/asm/break.h b/arch/mips/include/asm/break.h
index 9161e68..63fe206 100644
--- a/arch/mips/include/asm/break.h
+++ b/arch/mips/include/asm/break.h
@@ -27,8 +27,15 @@
 #define BRK_STACKOVERFLOW 9	/* For Ada stackchecking */
 #define BRK_NORLD	10	/* No rld found - not used by Linux/MIPS */
 #define _BRK_THREADBP	11	/* For threads, user bp (used by debuggers) */
+
+#ifdef CONFIG_CPU_MICROMIPS
+#define BRK_BUG		12	/* Used by BUG() */
+#define BRK_KDB		13	/* Used in KDB_ENTER() */
+#else
 #define BRK_BUG		512	/* Used by BUG() */
 #define BRK_KDB		513	/* Used in KDB_ENTER() */
+#endif
+#define MM_BRK_MEMU	14	/* Used by FPU emulator (microMIPS) */
 #define BRK_MEMU	514	/* Used by FPU emulator */
 #define BRK_KPROBE_BP	515	/* Kprobe break */
 #define BRK_KPROBE_SSTEPBP 516	/* Kprobe single step software implementation */
diff --git a/arch/mips/include/asm/dsp.h b/arch/mips/include/asm/dsp.h
index e9bfc08..3149b30 100644
--- a/arch/mips/include/asm/dsp.h
+++ b/arch/mips/include/asm/dsp.h
@@ -16,7 +16,11 @@
 #include <asm/mipsregs.h>
 
 #define DSP_DEFAULT	0x00000000
+#ifdef CONFIG_CPU_MICROMIPS
+#define DSP_MASK	0x7f
+#else
 #define DSP_MASK	0x3ff
+#endif
 
 #define __enable_dsp_hazard()						\
 do {									\
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index ba3d53d..1b8db8d 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1148,48 +1148,31 @@ do {									\
 /*
  * Macros to access the floating point coprocessor control registers
  */
-#define read_32bit_cp1_register(source)                         \
-({ int __res;                                                   \
-	__asm__ __volatile__(                                   \
-	".set\tpush\n\t"					\
-	".set\treorder\n\t"					\
-	/* gas fails to assemble cfc1 for some archs (octeon).*/ \
-	".set\tmips1\n\t"					\
-        "cfc1\t%0,"STR(source)"\n\t"                            \
-	".set\tpop"						\
-        : "=r" (__res));                                        \
-        __res;})
-
-#define rddsp(mask)							\
+#define read_32bit_cp1_register(source)					\
 ({									\
-	unsigned int __res;						\
+	int __res;							\
 									\
 	__asm__ __volatile__(						\
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
 	"	.set	push					\n"	\
-	"	.set	noat					\n"	\
-	"	move	$1, %0					\n"	\
-	"	# wrdsp $1, %x1					\n"	\
-	"	.word	0x7c2004f8 | (%x1 << 11)		\n"	\
+	"	.set	reorder					\n"	\
+	"	# gas fails to assemble cfc1 for some archs,	\n"	\
+	"	# like Octeon.					\n"	\
+	"	.set	mips1					\n"	\
+	"	cfc1	%0,"STR(source)"			\n"	\
 	"	.set	pop					\n"	\
-        :								\
-	: "r" (val), "i" (mask));					\
-} while (0)
+	: "=r" (__res));						\
+	__res;								\
+})
 
+/*
+ * Macros to access the DSP ASE registers
+ */
 #if 0	/* Need DSP ASE capable assembler ... */
+#define rddsp(mask)							\
+({ long dspctl; __asm__("rddsp %0, %x1" : "=r" (dspctl) : "i" (mask)); dspctl;})
+
+#define wrdsp(val, mask) (__asm__("wrdsp %0, %x1" : "r" (val) : "i" (mask)))
+
 #define mflo0() ({ long mflo0; __asm__("mflo %0, $ac0" : "=r" (mflo0)); mflo0;})
 #define mflo1() ({ long mflo1; __asm__("mflo %0, $ac1" : "=r" (mflo1)); mflo1;})
 #define mflo2() ({ long mflo2; __asm__("mflo %0, $ac2" : "=r" (mflo2)); mflo2;})
@@ -1212,230 +1195,178 @@ do {									\
 
 #else
 
-#define mfhi0()								\
-({									\
-	unsigned long __treg;						\
-									\
-	__asm__ __volatile__(						\
-	"	.set	push			\n"			\
-	"	.set	noat			\n"			\
-	"	# mfhi	%0, $ac0		\n"			\
-	"	.word	0x00000810		\n"			\
-	"	move	%0, $1			\n"			\
-	"	.set	pop			\n"			\
-	: "=r" (__treg));						\
-	__treg;								\
-})
-
-#define mfhi1()								\
-({									\
-	unsigned long __treg;						\
-									\
-	__asm__ __volatile__(						\
-	"	.set	push			\n"			\
-	"	.set	noat			\n"			\
-	"	# mfhi	%0, $ac1		\n"			\
-	"	.word	0x00200810		\n"			\
-	"	move	%0, $1			\n"			\
-	"	.set	pop			\n"			\
-	: "=r" (__treg));						\
-	__treg;								\
-})
-
-#define mfhi2()								\
-({									\
-	unsigned long __treg;						\
-									\
-	__asm__ __volatile__(						\
-	"	.set	push			\n"			\
-	"	.set	noat			\n"			\
-	"	# mfhi	%0, $ac2		\n"			\
-	"	.word	0x00400810		\n"			\
-	"	move	%0, $1			\n"			\
-	"	.set	pop			\n"			\
-	: "=r" (__treg));						\
-	__treg;								\
-})
-
-#define mfhi3()								\
-({									\
-	unsigned long __treg;						\
-									\
-	__asm__ __volatile__(						\
-	"	.set	push			\n"			\
-	"	.set	noat			\n"			\
-	"	# mfhi	%0, $ac3		\n"			\
-	"	.word	0x00600810		\n"			\
-	"	move	%0, $1			\n"			\
-	"	.set	pop			\n"			\
-	: "=r" (__treg));						\
-	__treg;								\
-})
-
-#define mflo0()								\
-({									\
-	unsigned long __treg;						\
-									\
-	__asm__ __volatile__(						\
-	"	.set	push			\n"			\
-	"	.set	noat			\n"			\
-	"	# mflo	%0, $ac0		\n"			\
-	"	.word	0x00000812		\n"			\
-	"	move	%0, $1			\n"			\
-	"	.set	pop			\n"			\
-	: "=r" (__treg));						\
-	__treg;								\
-})
-
-#define mflo1()								\
-({									\
-	unsigned long __treg;						\
-									\
-	__asm__ __volatile__(						\
-	"	.set	push			\n"			\
-	"	.set	noat			\n"			\
-	"	# mflo	%0, $ac1		\n"			\
-	"	.word	0x00200812		\n"			\
-	"	move	%0, $1			\n"			\
-	"	.set	pop			\n"			\
-	: "=r" (__treg));						\
-	__treg;								\
-})
-
-#define mflo2()								\
-({									\
-	unsigned long __treg;						\
-									\
-	__asm__ __volatile__(						\
-	"	.set	push			\n"			\
-	"	.set	noat			\n"			\
-	"	# mflo	%0, $ac2		\n"			\
-	"	.word	0x00400812		\n"			\
-	"	move	%0, $1			\n"			\
-	"	.set	pop			\n"			\
-	: "=r" (__treg));						\
-	__treg;								\
-})
-
-#define mflo3()								\
+#ifdef CONFIG_CPU_MICROMIPS
+#define rddsp(mask)							\
 ({									\
-	unsigned long __treg;						\
+	unsigned int __res;						\
 									\
 	__asm__ __volatile__(						\
-	"	.set	push			\n"			\
-	"	.set	noat			\n"			\
-	"	# mflo	%0, $ac3		\n"			\
-	"	.word	0x00600812		\n"			\
-	"	move	%0, $1			\n"			\
-	"	.set	pop			\n"			\
-	: "=r" (__treg));						\
-	__treg;								\
-})
-
-#define mthi0(x)							\
-do {									\
-	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
 	"	.set	noat					\n"	\
-	"	move	$1, %0					\n"	\
-	"	# mthi	$1, $ac0				\n"	\
-	"	.word	0x00200011				\n"	\
+	"	# rddsp $1, %x1					\n"	\
+	"	.hword	((0x0020067c | (%x1 << 14)) >> 16)	\n"	\
+	"	.hword	((0x0020067c | (%x1 << 14)) & 0xffff)	\n"	\
+	"	move	%0, $1					\n"	\
 	"	.set	pop					\n"	\
-	:								\
-	: "r" (x));							\
-} while (0)
+	: "=r" (__res)							\
+	: "i" (mask));							\
+	__res;								\
+})
 
-#define mthi1(x)							\
+#define wrdsp(val, mask)						\
 do {									\
 	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
 	"	.set	noat					\n"	\
 	"	move	$1, %0					\n"	\
-	"	# mthi	$1, $ac1				\n"	\
-	"	.word	0x00200811				\n"	\
+	"	# wrdsp $1, %x1					\n"	\
+	"	.hword	((0x0020167c | (%x1 << 14)) >> 16)	\n"	\
+	"	.hword	((0x0020167c | (%x1 << 14)) & 0xffff)	\n"	\
 	"	.set	pop					\n"	\
 	:								\
-	: "r" (x));							\
+	: "r" (val), "i" (mask));					\
 } while (0)
 
-#define mthi2(x)							\
-do {									\
+#define _umips_dsp_mfxxx(ins)						\
+({									\
+	unsigned long __treg;						\
+									\
 	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
 	"	.set	noat					\n"	\
-	"	move	$1, %0					\n"	\
-	"	# mthi	$1, $ac2				\n"	\
-	"	.word	0x00201011				\n"	\
+	"	.hword	0x0001					\n"	\
+	"	.hword	%x1					\n"	\
+	"	move	%0, $1					\n"	\
 	"	.set	pop					\n"	\
-	:								\
-	: "r" (x));							\
-} while (0)
+	: "=r" (__treg)							\
+	: "i" (ins));							\
+	__treg;								\
+})
 
-#define mthi3(x)							\
+#define _umips_dsp_mtxxx(val, ins)					\
 do {									\
 	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
 	"	.set	noat					\n"	\
 	"	move	$1, %0					\n"	\
-	"	# mthi	$1, $ac3				\n"	\
-	"	.word	0x00201811				\n"	\
+	"	.hword	0x0001					\n"	\
+	"	.hword	%x1					\n"	\
 	"	.set	pop					\n"	\
 	:								\
-	: "r" (x));							\
+	: "r" (val), "i" (ins));					\
 } while (0)
 
-#define mtlo0(x)							\
-do {									\
+#define _umips_dsp_mflo(reg) _umips_dsp_mfxxx((reg << 14) | 0x107c)
+#define _umips_dsp_mfhi(reg) _umips_dsp_mfxxx((reg << 14) | 0x007c)
+
+#define _umips_dsp_mtlo(val, reg) _umips_dsp_mtxxx(val, ((reg << 14) | 0x307c))
+#define _umips_dsp_mthi(val, reg) _umips_dsp_mtxxx(val, ((reg << 14) | 0x207c))
+
+#define mflo0() _umips_dsp_mflo(0)
+#define mflo1() _umips_dsp_mflo(1)
+#define mflo2() _umips_dsp_mflo(2)
+#define mflo3() _umips_dsp_mflo(3)
+
+#define mfhi0() _umips_dsp_mfhi(0)
+#define mfhi1() _umips_dsp_mfhi(1)
+#define mfhi2() _umips_dsp_mfhi(2)
+#define mfhi3() _umips_dsp_mfhi(3)
+
+#define mtlo0(x) _umips_dsp_mtlo(x, 0)
+#define mtlo1(x) _umips_dsp_mtlo(x, 1)
+#define mtlo2(x) _umips_dsp_mtlo(x, 2)
+#define mtlo3(x) _umips_dsp_mtlo(x, 3)
+
+#define mthi0(x) _umips_dsp_mthi(x, 0)
+#define mthi1(x) _umips_dsp_mthi(x, 1)
+#define mthi2(x) _umips_dsp_mthi(x, 2)
+#define mthi3(x) _umips_dsp_mthi(x, 3)
+
+#else  /* !CONFIG_CPU_MICROMIPS */
+
+#define rddsp(mask)							\
+({									\
+	unsigned int __res;						\
+									\
 	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
 	"	.set	noat					\n"	\
-	"	move	$1, %0					\n"	\
-	"	# mtlo	$1, $ac0				\n"	\
-	"	.word	0x00200013				\n"	\
+	"	# rddsp $1, %x1					\n"	\
+	"	.word	0x7c000cb8 | (%x1 << 16)		\n"	\
+	"	move	%0, $1					\n"	\
 	"	.set	pop					\n"	\
-	:								\
-	: "r" (x));							\
-} while (0)
+	: "=r" (__res)							\
+	: "i" (mask));							\
+	__res;								\
+})
 
-#define mtlo1(x)							\
+#define wrdsp(val, mask)						\
 do {									\
 	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
 	"	.set	noat					\n"	\
 	"	move	$1, %0					\n"	\
-	"	# mtlo	$1, $ac1				\n"	\
-	"	.word	0x00200813				\n"	\
+	"	# wrdsp $1, %x1					\n"	\
+	"	.word	0x7c2004f8 | (%x1 << 11)		\n"	\
 	"	.set	pop					\n"	\
 	:								\
-	: "r" (x));							\
+	: "r" (val), "i" (mask));					\
 } while (0)
 
-#define mtlo2(x)							\
-do {									\
+#define _dsp_mfxxx(ins)							\
+({									\
+	unsigned long __treg;						\
+									\
 	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
 	"	.set	noat					\n"	\
-	"	move	$1, %0					\n"	\
-	"	# mtlo	$1, $ac2				\n"	\
-	"	.word	0x00201013				\n"	\
+	"	.word	(0x00000810 | %1)			\n"	\
+	"	move	%0, $1					\n"	\
 	"	.set	pop					\n"	\
-	:								\
-	: "r" (x));							\
-} while (0)
+	: "=r" (__treg)							\
+	: "i" (ins));							\
+	__treg;								\
+})
 
-#define mtlo3(x)							\
+#define _dsp_mtxxx(val, ins)						\
 do {									\
 	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
 	"	.set	noat					\n"	\
 	"	move	$1, %0					\n"	\
-	"	# mtlo	$1, $ac3				\n"	\
-	"	.word	0x00201813				\n"	\
+	"	.word	(0x00200011 | %1)			\n"	\
 	"	.set	pop					\n"	\
 	:								\
-	: "r" (x));							\
+	: "r" (val), "i" (ins));					\
 } while (0)
 
+#define _dsp_mflo(reg) _dsp_mfxxx((reg << 21) | 0x0002)
+#define _dsp_mfhi(reg) _dsp_mfxxx((reg << 21) | 0x0000)
+
+#define _dsp_mtlo(val, reg) _dsp_mtxxx(val, ((reg << 11) | 0x0002))
+#define _dsp_mthi(val, reg) _dsp_mtxxx(val, ((reg << 11) | 0x0000))
+
+#define mflo0() _dsp_mflo(0)
+#define mflo1() _dsp_mflo(1)
+#define mflo2() _dsp_mflo(2)
+#define mflo3() _dsp_mflo(3)
+
+#define mfhi0() _dsp_mfhi(0)
+#define mfhi1() _dsp_mfhi(1)
+#define mfhi2() _dsp_mfhi(2)
+#define mfhi3() _dsp_mfhi(3)
+
+#define mtlo0(x) _dsp_mtlo(x, 0)
+#define mtlo1(x) _dsp_mtlo(x, 1)
+#define mtlo2(x) _dsp_mtlo(x, 2)
+#define mtlo3(x) _dsp_mtlo(x, 3)
+
+#define mthi0(x) _dsp_mthi(x, 0)
+#define mthi1(x) _dsp_mthi(x, 1)
+#define mthi2(x) _dsp_mthi(x, 2)
+#define mthi3(x) _dsp_mthi(x, 3)
+
+#endif /* CONFIG_CPU_MICROMIPS */
 #endif
 
 /*
-- 
1.7.11.1
