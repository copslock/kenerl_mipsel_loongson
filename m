Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2009 16:37:10 +0200 (CEST)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:41500 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493559AbZJUOfh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2009 16:35:37 +0200
Received: by bwz21 with SMTP id 21so243449bwz.24
        for <multiple recipients>; Wed, 21 Oct 2009 07:35:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=jH9o3WUbT8LLIvxBoU1kWPUyEA1biQisohprEeY/kMM=;
        b=iEGNxE2BQJs9qsfI4ioTugT8gfZHwmsxdKI3y4xcCloMMjitYnvV1KeOFbdtYaJXUs
         zgkYXQgNZG1fPYE3QIhsBqE52HHpUeKXMlkctyzg/hbk0Ewq8sRFJ3e4kn3cDE6NO80u
         3Y5nq9nTB5YSDki3tcc7FUMmFAulyg+GxF3fQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DEglhmbWIrG5Bm78poVHBmCx0nmfeEbv/yDxoehxX+VBZJzWqRypmhDVEgoQ4JIg0B
         oB7TiTY34oLfLliu4k4P4s0gcM6iw+EoruYhrwrAXIyS7+/t6Robu5ItzeHZaHcUa0Md
         2UgeGlspf1ntVG6EDETb7tw7Di3U/ua7iWtLs=
Received: by 10.204.10.7 with SMTP id n7mr8105734bkn.68.1256135729760;
        Wed, 21 Oct 2009 07:35:29 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 1sm303459fkt.11.2009.10.21.07.35.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Oct 2009 07:35:28 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH -v4 4/9] tracing: add static function tracer support for MIPS
Date:	Wed, 21 Oct 2009 22:34:58 +0800
Message-Id: <ea8aa927fbd184b54941e4c2ae0be8ea0b4f6b8a.1256135456.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>
 <3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1256135456.git.wuzhangjin@gmail.com>
References: <cover.1256135456.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

if -pg of gcc is enabled. a calling to _mcount will be inserted to each
kernel function. so, there is a possibility to trace the functions in
_mcount.

here is the implementation of mips specific _mcount for static function
tracer.

-ffunction-sections option not works with -pg, so disable it if enables
FUNCTION_TRACER.

NOTE: This implementation not support module tracing yet, but you can
try to enable it via adding -mlong-calls to KBUILD_CFLAGS, but this will
made the following dynamic function tracer fail, so, I did not enable the
-mlong-calls by deafult, in the next version, I plan to enable the
module support via making dynamic function tracer work with -mlong-calls
to just enable the long call for modules.

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig              |    1 +
 arch/mips/Makefile             |    2 +
 arch/mips/include/asm/ftrace.h |   25 ++++++++++-
 arch/mips/kernel/Makefile      |    2 +
 arch/mips/kernel/mcount.S      |   94 ++++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/mips_ksyms.c  |    5 ++
 6 files changed, 128 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/kernel/mcount.S

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 03bd56a..6b33e88 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -4,6 +4,7 @@ config MIPS
 	select HAVE_IDE
 	select HAVE_OPROFILE
 	select HAVE_ARCH_KGDB
+	select HAVE_FUNCTION_TRACER
 	# Horrible source of confusion.  Die, die, die ...
 	select EMBEDDED
 	select RTC_LIB if !LEMOTE_FULOONG2E
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 77f5021..0a2073e 100644
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
index f228868..38e704a 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -10,6 +10,7 @@ obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_trace_clock.o = -pg
+CFLAGS_REMOVE_early_printk.o = -pg
 endif
 
 obj-$(CONFIG_CEVT_BCM1480)	+= cevt-bcm1480.o
@@ -29,6 +30,7 @@ obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_MODULES)		+= mips_ksyms.o module.o
 
 obj-$(CONFIG_FTRACE)		+= trace_clock.o
+obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o
 
 obj-$(CONFIG_CPU_LOONGSON2)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_MIPS32)	+= r4k_fpu.o r4k_switch.o
diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
new file mode 100644
index 0000000..5bb8055
--- /dev/null
+++ b/arch/mips/kernel/mcount.S
@@ -0,0 +1,94 @@
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
+	PTR_S	AT, PT_R1(sp)
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
+	PTR_L	AT, PT_R1(sp)
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
+	move	a1, AT		/* arg2: the caller's next ip, parent */
+	PTR_SUBU a0, MCOUNT_INSN_SIZE
+	.endm
+
+	.macro RETURN_BACK
+	jr ra
+	move ra, AT 
+	.endm
+
+NESTED(_mcount, PT_SIZE, ra)
+	RESTORE_SP_FOR_32BIT
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
1.6.2.1
