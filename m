Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Dec 2012 06:06:22 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:33791 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816206Ab2LOFGVHarlN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Dec 2012 06:06:21 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Tjjwz-0006mh-Er; Fri, 14 Dec 2012 23:06:13 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH v2] MIPS: dsp: Add assembler support for DSP ASEs.
Date:   Fri, 14 Dec 2012 23:06:07 -0600
Message-Id: <1355547967-13779-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35290
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

Newer toolchains support the DSP and DSP Rev2 instructions. This patch
performs a check for that support and adds compiler and assembler
flags for only the files that need use those instructions.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/mipsregs.h |   53 ++++++++++++++++++++++++++------------
 arch/mips/kernel/Makefile        |   27 +++++++++++++++++++
 2 files changed, 63 insertions(+), 17 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index a9ed612..0960d68 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1155,36 +1155,26 @@ do {									\
         : "=r" (__res));                                        \
         __res;})
 
+#ifdef HAVE_AS_DSP
 #define rddsp(mask)							\
 ({									\
-	unsigned int __res;						\
+	unsigned int __dspctl;						\
 									\
 	__asm__ __volatile__(						\
-	"	.set	push				\n"		\
-	"	.set	noat				\n"		\
-	"	# rddsp $1, %x1				\n"		\
-	"	.word	0x7c000cb8 | (%x1 << 16)	\n"		\
-	"	move	%0, $1				\n"		\
-	"	.set	pop				\n"		\
-	: "=r" (__res)							\
+	"	rddsp	%0, %x1					\n"	\
+	: "=r" (__dspctl)						\
 	: "i" (mask));							\
-	__res;								\
+	__dspctl;							\
 })
 
 #define wrdsp(val, mask)						\
 do {									\
 	__asm__ __volatile__(						\
-	"	.set	push					\n"	\
-	"	.set	noat					\n"	\
-	"	move	$1, %0					\n"	\
-	"	# wrdsp $1, %x1					\n"	\
-	"	.word	0x7c2004f8 | (%x1 << 11)		\n"	\
-	"	.set	pop					\n"	\
-        :								\
+	"	wrdsp	%0, %x1					\n"	\
+	:								\
 	: "r" (val), "i" (mask));					\
 } while (0)
 
-#if 0	/* Need DSP ASE capable assembler ... */
 #define mflo0() ({ long mflo0; __asm__("mflo %0, $ac0" : "=r" (mflo0)); mflo0;})
 #define mflo1() ({ long mflo1; __asm__("mflo %0, $ac1" : "=r" (mflo1)); mflo1;})
 #define mflo2() ({ long mflo2; __asm__("mflo %0, $ac2" : "=r" (mflo2)); mflo2;})
@@ -1207,6 +1197,35 @@ do {									\
 
 #else
 
+#define rddsp(mask)							\
+({									\
+	unsigned int __res;						\
+									\
+	__asm__ __volatile__(						\
+	"	.set	push				\n"		\
+	"	.set	noat				\n"		\
+	"	# rddsp $1, %x1				\n"		\
+	"	.word	0x7c000cb8 | (%x1 << 16)	\n"		\
+	"	move	%0, $1				\n"		\
+	"	.set	pop				\n"		\
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
+	"	.word	0x7c2004f8 | (%x1 << 11)		\n"	\
+	"	.set	pop					\n"	\
+        :								\
+	: "r" (val), "i" (mask));					\
+} while (0)
+
 #define mfhi0()								\
 ({									\
 	unsigned long __treg;						\
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 33a96a9..c3c8cba 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -98,4 +98,31 @@ obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event_mipsxx.o
 
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 
+#
+# DSP ASE supported for MIPS32 or MIPS64 Release 2 cores only
+#
+ifeq ($(CONFIG_CPU_MIPSR2), y)
+CFLAGS_DSP 			= -DHAVE_AS_DSP
+
+#
+# Check if assembler supports DSP ASE
+#
+ifeq ($(call cc-option-yn,-mdsp), y)
+CFLAGS_DSP			+= -mdsp
+endif
+
+#
+# Check if assembler supports DSP ASE Rev2
+#
+ifeq ($(call cc-option-yn,-mdspr2), y)
+CFLAGS_DSP			+= -mdspr2
+endif
+
+CFLAGS_signal.o			= $(CFLAGS_DSP)
+CFLAGS_signal32.o		= $(CFLAGS_DSP)
+CFLAGS_process.o		= $(CFLAGS_DSP)
+CFLAGS_branch.o			= $(CFLAGS_DSP)
+CFLAGS_ptrace.o			= $(CFLAGS_DSP)
+endif
+
 CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
-- 
1.7.9.5
