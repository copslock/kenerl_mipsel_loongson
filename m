Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 05:54:07 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:60265 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823142Ab2LGEyEz6JYO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Dec 2012 05:54:04 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Tgpwk-0007Kw-Ob; Thu, 06 Dec 2012 22:53:58 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH] MIPS: dsp: Simplify the DSP macros.
Date:   Thu,  6 Dec 2012 22:53:52 -0600
Message-Id: <1354856032-28475-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35210
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

Simplify the DSP macros for vanilla (non-microMIPS) kernels and
toolchains that do not support the DSP ASEs.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/mipsregs.h |  231 +++++---------------------------------
 1 file changed, 30 insertions(+), 201 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index c1e0221..0c0e4a6 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1322,229 +1322,58 @@ do {									\
 	: "r" (val), "i" (mask));					\
 } while (0)
 
-#define mfhi0()								\
+#define _dsp_mfxxx(ins)							\
 ({									\
 	unsigned long __treg;						\
 									\
 	__asm__ __volatile__(						\
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
-({									\
-	unsigned long __treg;						\
-									\
-	__asm__ __volatile__(						\
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
 
-#define mthi1(x)							\
+#define _dsp_mtxxx(val, ins)						\
 do {									\
 	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
 	"	.set	noat					\n"	\
 	"	move	$1, %0					\n"	\
-	"	# mthi	$1, $ac1				\n"	\
-	"	.word	0x00200811				\n"	\
+	"	.word	(0x00200011 | %1)			\n"	\
 	"	.set	pop					\n"	\
 	:								\
-	: "r" (x));							\
+	: "r" (val), "i" (ins));					\
 } while (0)
 
-#define mthi2(x)							\
-do {									\
-	__asm__ __volatile__(						\
-	"	.set	push					\n"	\
-	"	.set	noat					\n"	\
-	"	move	$1, %0					\n"	\
-	"	# mthi	$1, $ac2				\n"	\
-	"	.word	0x00201011				\n"	\
-	"	.set	pop					\n"	\
-	:								\
-	: "r" (x));							\
-} while (0)
+#define _dsp_mflo(reg) _dsp_mfxxx((reg << 21) | 0x0002)
+#define _dsp_mfhi(reg) _dsp_mfxxx((reg << 21) | 0x0000)
 
-#define mthi3(x)							\
-do {									\
-	__asm__ __volatile__(						\
-	"	.set	push					\n"	\
-	"	.set	noat					\n"	\
-	"	move	$1, %0					\n"	\
-	"	# mthi	$1, $ac3				\n"	\
-	"	.word	0x00201811				\n"	\
-	"	.set	pop					\n"	\
-	:								\
-	: "r" (x));							\
-} while (0)
+#define _dsp_mtlo(val, reg) _dsp_mtxxx(val, ((reg << 11) | 0x0002))
+#define _dsp_mthi(val, reg) _dsp_mtxxx(val, ((reg << 11) | 0x0000))
 
-#define mtlo0(x)							\
-do {									\
-	__asm__ __volatile__(						\
-	"	.set	push					\n"	\
-	"	.set	noat					\n"	\
-	"	move	$1, %0					\n"	\
-	"	# mtlo	$1, $ac0				\n"	\
-	"	.word	0x00200013				\n"	\
-	"	.set	pop					\n"	\
-	:								\
-	: "r" (x));							\
-} while (0)
+#define mflo0() _dsp_mflo(0)
+#define mflo1() _dsp_mflo(1)
+#define mflo2() _dsp_mflo(2)
+#define mflo3() _dsp_mflo(3)
 
-#define mtlo1(x)							\
-do {									\
-	__asm__ __volatile__(						\
-	"	.set	push					\n"	\
-	"	.set	noat					\n"	\
-	"	move	$1, %0					\n"	\
-	"	# mtlo	$1, $ac1				\n"	\
-	"	.word	0x00200813				\n"	\
-	"	.set	pop					\n"	\
-	:								\
-	: "r" (x));							\
-} while (0)
+#define mfhi0() _dsp_mfhi(0)
+#define mfhi1() _dsp_mfhi(1)
+#define mfhi2() _dsp_mfhi(2)
+#define mfhi3() _dsp_mfhi(3)
 
-#define mtlo2(x)							\
-do {									\
-	__asm__ __volatile__(						\
-	"	.set	push					\n"	\
-	"	.set	noat					\n"	\
-	"	move	$1, %0					\n"	\
-	"	# mtlo	$1, $ac2				\n"	\
-	"	.word	0x00201013				\n"	\
-	"	.set	pop					\n"	\
-	:								\
-	: "r" (x));							\
-} while (0)
+#define mtlo0(x) _dsp_mtlo(x, 0)
+#define mtlo1(x) _dsp_mtlo(x, 1)
+#define mtlo2(x) _dsp_mtlo(x, 2)
+#define mtlo3(x) _dsp_mtlo(x, 3)
 
-#define mtlo3(x)							\
-do {									\
-	__asm__ __volatile__(						\
-	"	.set	push					\n"	\
-	"	.set	noat					\n"	\
-	"	move	$1, %0					\n"	\
-	"	# mtlo	$1, $ac3				\n"	\
-	"	.word	0x00201813				\n"	\
-	"	.set	pop					\n"	\
-	:								\
-	: "r" (x));							\
-} while (0)
+#define mthi0(x) _dsp_mthi(x, 0)
+#define mthi1(x) _dsp_mthi(x, 1)
+#define mthi2(x) _dsp_mthi(x, 2)
+#define mthi3(x) _dsp_mthi(x, 3)
 
 #endif /* CONFIG_CPU_MICROMIPS */
 #endif
-- 
1.7.9.5
