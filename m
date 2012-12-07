Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 05:53:42 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:60262 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822126Ab2LGExlmbKqK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Dec 2012 05:53:41 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1TgpwN-0007Kp-I3; Thu, 06 Dec 2012 22:53:35 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH] MIPS: dsp: Support toolchains without DSP ASE and microMIPS.
Date:   Thu,  6 Dec 2012 22:53:29 -0600
Message-Id: <1354856009-28432-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35209
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

Add macros to support the DSP ASE with microMIPS kernels when the
toolchain does not have support.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/mipsregs.h |   89 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 5d400d2..c1e0221 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1205,6 +1205,94 @@ do {									\
 
 #else
 
+#ifdef CONFIG_CPU_MICROMIPS
+#define rddsp(mask)							\
+({									\
+	unsigned int __res;						\
+									\
+	__asm__ __volatile__(						\
+	"	.set	push					\n"	\
+	"	.set	noat					\n"	\
+	"	# rddsp $1, %x1					\n"	\
+	"	.hword	((0x0020067c | (%x1 << 14)) >> 16)	\n"	\
+	"	.hword	((0x0020067c | (%x1 << 14)) & 0xffff)	\n"	\
+	"	move	%0, $1					\n"	\
+	"	.set	pop					\n"	\
+	: "=r" (__res)							\
+	: "i" (mask));							\
+	__res;								\
+})
+
+#define wrdsp(val, mask)						\
+do {									\
+	__asm__ __volatile__(						\
+	"	.set	push					\n"	\
+	"	.set	noat					\n"	\
+	"	move	$1, %0					\n"	\
+	"	# wrdsp $1, %x1					\n"	\
+	"	.hword	((0x0020167c | (%x1 << 14)) >> 16)	\n"	\
+	"	.hword	((0x0020167c | (%x1 << 14)) & 0xffff)	\n"	\
+	"	.set	pop					\n"	\
+	:								\
+	: "r" (val), "i" (mask));					\
+} while (0)
+
+#define _umips_dsp_mfxxx(ins)						\
+({									\
+	unsigned long __treg;						\
+									\
+	__asm__ __volatile__(						\
+	"	.set	push					\n"	\
+	"	.set	noat					\n"	\
+	"	.hword	0x0001					\n"	\
+	"	.hword	%x1					\n"	\
+	"	move	%0, $1					\n"	\
+	"	.set	pop					\n"	\
+	: "=r" (__treg)							\
+	: "i" (ins));							\
+	__treg;								\
+})
+
+#define _umips_dsp_mtxxx(val, ins)					\
+do {									\
+	__asm__ __volatile__(						\
+	"	.set	push					\n"	\
+	"	.set	noat					\n"	\
+	"	move	$1, %0					\n"	\
+	"	.hword	0x0001					\n"	\
+	"	.hword	%x1					\n"	\
+	"	.set	pop					\n"	\
+	:								\
+	: "r" (val), "i" (ins));					\
+} while (0)
+
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
 #define rddsp(mask)							\
 ({									\
 	unsigned int __res;						\
@@ -1458,6 +1546,7 @@ do {									\
 	: "r" (x));							\
 } while (0)
 
+#endif /* CONFIG_CPU_MICROMIPS */
 #endif
 
 /*
-- 
1.7.9.5
