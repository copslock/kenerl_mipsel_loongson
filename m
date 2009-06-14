Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Jun 2009 17:52:53 +0200 (CEST)
Received: from mail-pz0-f179.google.com ([209.85.222.179]:39529 "EHLO
	mail-pz0-f179.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492173AbZFNPwq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 14 Jun 2009 17:52:46 +0200
Received: by pzk9 with SMTP id 9so1380214pzk.22
        for <multiple recipients>; Sun, 14 Jun 2009 08:52:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=pptlc3sjs0EmAfQtFJUUrasJk4ih2Pd/bLj2BHTlsqo=;
        b=dZbDgEsglajrrGL0YwWD7QGbPXiDY5EIeBZuxPZzt+jX7qmSbut45zUcJfzVHdvgrT
         99dKD+gVcDNK1DR8PwdGTD8GufcUWVjbDJRG4zC5KlkAc+rEdR1Hrl+bkgI2J+Ny9Awx
         MKJ70In55dU9COZt1wgfnNNAD5it1IPXReWHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HUQyUhno9S0rY8ZCtbaF/X4Ao9bbJ3Jz9tNXCEdOPZcElULtn9AmBK4AC9WNI79hzv
         wXttm4aSuPISNaUGaJB4uqz5s+XmvqVG/tOtsl5ajxsEKSWSWo40KiAmqfloDdNWftr0
         AbXPPRTpggNAM5Uai02jUzF/zhtmATCUeIB+8=
Received: by 10.115.14.1 with SMTP id r1mr9952577wai.23.1244994727684;
        Sun, 14 Jun 2009 08:52:07 -0700 (PDT)
Received: from localhost.localdomain ([219.246.59.144])
        by mx.google.com with ESMTPS id g25sm4670299wag.43.2009.06.14.08.52.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Jun 2009 08:52:06 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:	Wang Liming <liming.wang@windriver.com>,
	Wu Zhangjin <wuzj@lemote.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Ingo Molnar <mingo@elte.hu>
Subject: [PATCH v3] mips static function tracer support
Date:	Sun, 14 Jun 2009 23:51:57 +0800
Message-Id: <9bf80ad0c891c470c7563df5c38ff5a2e59e678d.1244994151.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <cover.1244994151.git.wuzj@lemote.com>
References: <cover.1244994151.git.wuzj@lemote.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

if -pg of gcc is enabled. a calling to _mcount will be inserted to each
kernel function. so, there is a possibility to trace the functions in
_mcount.

here is the implementation of mips specific _mcount for static function
tracer.

-ffunction-sections option not works with -pg, so disable it if enables
FUNCTION_TRACER.

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
---
 arch/mips/Kconfig              |    2 +
 arch/mips/Makefile             |    2 +
 arch/mips/include/asm/ftrace.h |   25 ++++++++++-
 arch/mips/kernel/Makefile      |    7 +++
 arch/mips/kernel/mcount.S      |   98 ++++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/mips_ksyms.c  |    5 ++
 6 files changed, 138 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/kernel/mcount.S

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 25f3b0a..2e2fdbe 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -4,6 +4,8 @@ config MIPS
 	select HAVE_IDE
 	select HAVE_OPROFILE
 	select HAVE_ARCH_KGDB
+	select HAVE_FUNCTION_TRACER
+	select HAVE_FUNCTION_TRACE_MCOUNT_TEST
 	# Horrible source of confusion.  Die, die, die ...
 	select EMBEDDED
 	select RTC_LIB
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index c4cae9e..f86fb15 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -48,7 +48,9 @@ ifneq ($(SUBARCH),$(ARCH))
   endif
 endif
 
+ifndef CONFIG_FUNCTION_TRACER
 cflags-y := -ffunction-sections
+endif
 cflags-y += $(call cc-option, -mno-check-zero-division)
 
 ifdef CONFIG_32BIT
diff --git a/arch/mips/include/asm/ftrace.h b/arch/mips/include/asm/ftrace.h
index 40a8c17..5f8ebcf 100644
--- a/arch/mips/include/asm/ftrace.h
+++ b/arch/mips/include/asm/ftrace.h
@@ -1 +1,24 @@
-/* empty */
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive for
+ * more details.
+ *
+ * Copyright (C) 2009 DSLab, Lanzhou University, China
+ * Author: Wu Zhangjin <wuzj@lemote.com>
+ */
+
+#ifndef _ASM_MIPS_FTRACE_H
+#define _ASM_MIPS_FTRACE_H
+
+#ifdef CONFIG_FUNCTION_TRACER
+
+#define MCOUNT_ADDR ((unsigned long)(_mcount))
+#define MCOUNT_INSN_SIZE 4		/* sizeof mcount call */
+
+#ifndef __ASSEMBLY__
+extern void _mcount(void);
+#define mcount _mcount
+
+#endif /* __ASSEMBLY__ */
+#endif /* CONFIG_FUNCTION_TRACER */
+#endif /* _ASM_MIPS_FTRACE_H */
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index e961221..559a820 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -8,6 +8,11 @@ obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
 		   ptrace.o reset.o setup.o signal.o syscall.o \
 		   time.o topology.o traps.o unaligned.o watch.o
 
+ifdef CONFIG_FUNCTION_TRACER
+# Do not profile debug and lowlevel utilities
+CFLAGS_REMOVE_early_printk.o = -pg
+endif
+
 obj-$(CONFIG_CEVT_BCM1480)	+= cevt-bcm1480.o
 obj-$(CONFIG_CEVT_R4K_LIB)	+= cevt-r4k.o
 obj-$(CONFIG_MIPS_MT_SMTC)	+= cevt-smtc.o
@@ -24,6 +29,8 @@ obj-$(CONFIG_SYNC_R4K)		+= sync-r4k.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_MODULES)		+= mips_ksyms.o module.o
 
+obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o
+
 obj-$(CONFIG_CPU_LOONGSON2)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_MIPS32)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_MIPS64)	+= r4k_fpu.o r4k_switch.o
diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
new file mode 100644
index 0000000..268724e
--- /dev/null
+++ b/arch/mips/kernel/mcount.S
@@ -0,0 +1,98 @@
+/*
+ * the mips-specific _mcount implementation
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive for
+ * more details.
+ *
+ * Copyright (C) 2009 DSLab, Lanzhou University, China
+ * Author: Wu Zhangjin <wuzj@lemote.com>
+ */
+
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+#include <asm/ftrace.h>
+
+	.text
+	.set noreorder
+	.set noat
+
+	/* since there is a "addiu sp,sp,-8" before "jal _mcount" in 32bit */
+	.macro RESTORE_SP_FOR_32BIT
+#ifdef CONFIG_32BIT
+	PTR_ADDIU	sp, 8
+#endif
+	.endm
+
+	.macro MCOUNT_SAVE_REGS
+	PTR_SUBU	sp, PT_SIZE
+	PTR_S	ra, PT_R31(sp)
+	PTR_S	$1, PT_R1(sp)
+	PTR_S	a0, PT_R4(sp)
+	PTR_S	a1, PT_R5(sp)
+	PTR_S	a2, PT_R6(sp)
+	PTR_S	a3, PT_R7(sp)
+#ifdef CONFIG_64BIT
+	PTR_S	a4, PT_R8(sp)
+	PTR_S	a5, PT_R9(sp)
+	PTR_S	a6, PT_R10(sp)
+	PTR_S	a7, PT_R11(sp)
+#endif
+	.endm
+
+	.macro MCOUNT_RESTORE_REGS
+	PTR_L	ra, PT_R31(sp)
+	PTR_L	$1, PT_R1(sp)
+	PTR_L	a0, PT_R4(sp)
+	PTR_L	a1, PT_R5(sp)
+	PTR_L	a2, PT_R6(sp)
+	PTR_L	a3, PT_R7(sp)
+#ifdef CONFIG_64BIT
+	PTR_L	a4, PT_R8(sp)
+	PTR_L	a5, PT_R9(sp)
+	PTR_L	a6, PT_R10(sp)
+	PTR_L	a7, PT_R11(sp)
+#endif
+	PTR_ADDIU	sp, PT_SIZE
+.endm
+
+	.macro MCOUNT_SET_ARGS
+	move	a0, ra		/* arg1: next ip, selfaddr */
+	move	a1, $1		/* arg2: the caller's next ip, parent */
+	PTR_SUBU a0, MCOUNT_INSN_SIZE
+	.endm
+
+	.macro RETURN_BACK
+	jr ra
+	move ra, $1
+	.endm
+
+NESTED(_mcount, PT_SIZE, ra)
+	RESTORE_SP_FOR_32BIT
+	PTR_L	t0, function_trace_stop
+	bnez	t0, ftrace_stub
+	nop
+
+	PTR_LA	t0, ftrace_stub
+	PTR_L	t1, ftrace_trace_function /* please don't use t1 later, safe? */
+	bne	t0, t1, static_trace
+	nop
+
+	j	ftrace_stub
+	nop
+
+static_trace:
+	MCOUNT_SAVE_REGS
+
+	MCOUNT_SET_ARGS			/* call *ftrace_trace_function */
+	jalr	t1
+	nop
+
+	MCOUNT_RESTORE_REGS
+	.globl ftrace_stub
+ftrace_stub:
+	RETURN_BACK
+	END(_mcount)
+
+	.set at
+	.set reorder
diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
index 225755d..1d04807 100644
--- a/arch/mips/kernel/mips_ksyms.c
+++ b/arch/mips/kernel/mips_ksyms.c
@@ -13,6 +13,7 @@
 #include <asm/checksum.h>
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
+#include <asm/ftrace.h>
 
 extern void *__bzero(void *__s, size_t __count);
 extern long __strncpy_from_user_nocheck_asm(char *__to,
@@ -51,3 +52,7 @@ EXPORT_SYMBOL(csum_partial_copy_nocheck);
 EXPORT_SYMBOL(__csum_partial_copy_user);
 
 EXPORT_SYMBOL(invalid_pte_table);
+#ifdef CONFIG_FUNCTION_TRACER
+/* _mcount is defined in arch/mips/kernel/mcount.S */
+EXPORT_SYMBOL(_mcount);
+#endif
-- 
1.6.0.4
