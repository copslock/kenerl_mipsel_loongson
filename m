Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 05:53:14 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:60260 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822126Ab2LGExNMUHpL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Dec 2012 05:53:13 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Tgpvv-0007Kf-5d; Thu, 06 Dec 2012 22:53:07 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH] MIPS: dsp: Add assembler support for DSP ASEs.
Date:   Thu,  6 Dec 2012 22:53:01 -0600
Message-Id: <1354855981-28392-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35208
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
 arch/mips/kernel/Makefile        |   24 +++++++++++++++++
 2 files changed, 60 insertions(+), 17 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index bec253f..5d400d2 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1163,36 +1163,26 @@ do {									\
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
@@ -1215,6 +1205,35 @@ do {									\
 
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
index 99dc7f9..e034ad6 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -99,4 +99,28 @@ obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event_mipsxx.o
 
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 
+ifeq ($(CONFIG_CPU_MIPS32), y)
+#
+# Check if assembler supports DSP ASE
+#
+ifeq ($(call cc-option-yn,-mdsp), y)
+CFLAGS_signal.o			= -mdsp -DHAVE_AS_DSP
+CFLAGS_signal32.o		= -mdsp -DHAVE_AS_DSP
+CFLAGS_process.o		= -mdsp -DHAVE_AS_DSP
+CFLAGS_branch.o			= -mdsp -DHAVE_AS_DSP
+CFLAGS_ptrace.o			= -mdsp -DHAVE_AS_DSP
+endif
+
+#
+# Check if assembler supports DSP ASE Rev2
+#
+ifeq ($(call cc-option-yn,-mdsp2), y)
+CFLAGS_signal.o			= -mdsp2 -DHAVE_AS_DSP
+CFLAGS_signal32.o		= -mdsp2 -DHAVE_AS_DSP
+CFLAGS_process.o		= -mdsp2 -DHAVE_AS_DSP
+CFLAGS_branch.o			= -mdsp2 -DHAVE_AS_DSP
+CFLAGS_ptrace.o			= -mdsp2 -DHAVE_AS_DSP
+endif
+endif
+
 CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
-- 
1.7.9.5
