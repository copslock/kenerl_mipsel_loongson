Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Nov 2009 07:36:46 +0100 (CET)
Received: from mail-px0-f173.google.com ([209.85.216.173]:43583 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492129AbZKNGfA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 14 Nov 2009 07:35:00 +0100
Received: by mail-px0-f173.google.com with SMTP id 3so2941201pxi.22
        for <multiple recipients>; Fri, 13 Nov 2009 22:34:58 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=ug95bdoZuPAz+VFStmSrXzkn2373MroA/YdJCQtpxWQ=;
        b=BQsixe1U+DJuTB8bF8hJ9XnqF9oVfFfWp3G97evoGcMq9SdpR3D5JLLc0PslUW+HLb
         vZsEXNQ84urDLEyo/qPdPxnUFnK+23EuGxnxPzJRxoaSjv+HgwG/P/u6tq8V9dApbmNK
         AGDyRLYXwaU9uzBOFMLTtddYjpNOEb6pP612w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PZwPuiLtGDuKhinPiEGUUcST/eKQXzjJcxdtMgaO/JOjUUsRzlXciVEt9V7LBO3bzX
         ON5tJCao/iUyhTAddInZJ4CHBo0JEFqZsAvp+bbdjTmDa0EP3UUHoy7fGhggSriLBWDq
         WvfnAkz3NaqpzC3cdLY1J6dqUAPbbhSnqYcMU=
Received: by 10.114.253.24 with SMTP id a24mr9080689wai.201.1258180498662;
        Fri, 13 Nov 2009 22:34:58 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm2668108pzk.5.2009.11.13.22.34.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Nov 2009 22:34:58 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	rostedt@goodmis.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Patrik Kluba <kpajko79@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <monstr@monstr.eu>,
	"Maciej W . Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	zhangfx@lemote.com, zhouqg@gmail.com
Subject: [PATCH v8 07/16] tracing: add dynamic function tracer support for MIPS
Date:	Sat, 14 Nov 2009 14:33:22 +0800
Message-Id: <48676d84140dbafd46e530611766121e18abc4ef.1258177321.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <3fcaffcfb3c8c8cd3015151ed5b7480ccaecde0f.1258177321.git.wuzhangjin@gmail.com>
References: <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1258177321.git.wuzhangjin@gmail.com>
 <b99c08397d9ff92ac5a72bda9131df41b702fc71.1258177321.git.wuzhangjin@gmail.com>
 <8f579e2cece16cd22358a4ec143ef6a8c462639b.1258177321.git.wuzhangjin@gmail.com>
 <ea337742d3ca7eec2825416041a6d4fa917d5cc4.1258177321.git.wuzhangjin@gmail.com>
 <7c7568247ad6cc109ec20387cfc3ca258d1d430f.1258177321.git.wuzhangjin@gmail.com>
 <3fcaffcfb3c8c8cd3015151ed5b7480ccaecde0f.1258177321.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1258177321.git.wuzhangjin@gmail.com>
References: <cover.1258177321.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

With dynamic function tracer, by default, _mcount is defined as an
"empty" function, it returns directly without any more action . When
enabling it in user-space, it will jump to a real tracing
function(ftrace_caller), and do the real job for us.

Differ from the static function tracer, dynamic function tracer provides
two functions ftrace_make_call()/ftrace_make_nop() to enable/disable the
tracing of some indicated kernel functions(set_ftrace_filter).

In the -v4 version, the implementation of this support is basically the same as
X86 version does: _mcount is implemented as an empty function and ftrace_caller
is implemented as a real tracing function respectively.

But in this version, to support module tracing with the help of
-mlong-calls in arch/mips/Makefile:

MODFLAGS += -mlong-calls.

The stuff becomes a little more complex. We need to cope with two
different type of calling to _mcount.

For the kernel part, the calling to _mcount(result of "objdump -hdr
vmlinux"). is like this:

	108:   03e0082d        move    at,ra
	10c:   0c000000        jal     0 <fpcsr_pending>
                        10c: R_MIPS_26  _mcount
                        10c: R_MIPS_NONE        *ABS*
                        10c: R_MIPS_NONE        *ABS*
	110:   00020021        nop

For the module with -mlong-calls, it looks like this:

	c:	3c030000 	lui	v1,0x0
			c: R_MIPS_HI16	_mcount
			c: R_MIPS_NONE	*ABS*
			c: R_MIPS_NONE	*ABS*
	10:	64630000 	daddiu	v1,v1,0
			10: R_MIPS_LO16	_mcount
			10: R_MIPS_NONE	*ABS*
			10: R_MIPS_NONE	*ABS*
	14:	03e0082d 	move	at,ra
	18:	0060f809 	jalr	v1

In the kernel version, there is only one "_mcount" string for every
kernel function, so, we just need to match this one in mcount_regex of
scripts/recordmcount.pl, but in the module version, we need to choose
one of the two to match. Herein, I choose the first one with
"R_MIPS_HI16 _mcount".

and In the kernel verion, without module tracing support, we just need
to replace "jal _mcount" by "jal ftrace_caller" to do real tracing, and
filter the tracing of some kernel functions via replacing it by a nop
instruction.

but as we have described before, the instruction "jal ftrace_caller" only left
32bit length for the address of ftrace_caller, it will fail when calling from
the module space. so, herein, we must replace something else.

the basic idea is loading the address of ftrace_caller to v1 via changing these
two instructions:

	lui	v1,0x0
	addiu	v1,v1,0

If we want to enable the tracing, we need to replace the above instructions to:

	lui	v1, HI_16BIT_ftrace_caller
	addiu	v1, v1, LOW_16BIT_ftrace_caller

If we want to stop the tracing of the indicated kernel functions, we
just need to replace the "jalr v1" to a nop instruction. but we need to
replace two instructions and encode the above two instructions
oursevles.

Is there a simpler solution? Yes! Here it is, in this version, we put _mcount
and ftrace_caller together, which means the address of _mcount and
ftrace_caller is the same:

_mcount:
ftrace_caller:
	j	ftrace_stub
	 nop

	...(do real tracing here)...

ftrace_stub:
	jr	ra
	 move	ra, at

By default, the kernel functions call _mcount, and then jump to ftrace_stub and
return. and when we want to do real tracing, we just need to remove that "j
ftrace_stub", and it will run through the two "nop" instructions and then do
the real tracing job.

what about filtering job? we just need to do this:

	 lui v1, hi_16bit_of_mcount        <--> b 1f (0x10000004)
	 addiu v1, v1, low_16bit_of_mcount
	 move at, ra
	 jalr v1
	 nop
	 				     1f: (rec->ip + 12)

In linux-mips64, there will be some local symbols, whose name are
prefixed by $L, which need to be filtered. thanks goes to Steven for
writing the mips64-specific function_regex.

In a conclusion, with RISC, things becomes easier with such a "stupid"
trick, RISC is something like K.I.S.S, and also, there are lots of
"simple" tricks in the whole ftrace support, thanks goes to Steven and
the other folks for providing such a wonderful tracing framework!

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig              |    2 +
 arch/mips/include/asm/ftrace.h |    9 +++
 arch/mips/kernel/Makefile      |    3 +-
 arch/mips/kernel/ftrace.c      |  112 ++++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/mcount.S      |   29 ++++++++++
 scripts/recordmcount.pl        |   54 +++++++++++++++++++
 6 files changed, 208 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/kernel/ftrace.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a9bd992..147fbbc 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -6,6 +6,8 @@ config MIPS
 	select HAVE_ARCH_KGDB
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_TRACE_MCOUNT_TEST
+	select HAVE_DYNAMIC_FTRACE
+	select HAVE_FTRACE_MCOUNT_RECORD
 	# Horrible source of confusion.  Die, die, die ...
 	select EMBEDDED
 	select RTC_LIB if !LEMOTE_FULOONG2E
diff --git a/arch/mips/include/asm/ftrace.h b/arch/mips/include/asm/ftrace.h
index 5f8ebcf..7094a40 100644
--- a/arch/mips/include/asm/ftrace.h
+++ b/arch/mips/include/asm/ftrace.h
@@ -19,6 +19,15 @@
 extern void _mcount(void);
 #define mcount _mcount
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+static inline unsigned long ftrace_call_adjust(unsigned long addr)
+{
+	return addr;
+}
+
+struct dyn_arch_ftrace {
+};
+#endif /*  CONFIG_DYNAMIC_FTRACE */
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_FUNCTION_TRACER */
 #endif /* _ASM_MIPS_FTRACE_H */
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 38e704a..3cda3ab 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -10,6 +10,7 @@ obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_trace_clock.o = -pg
+CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_early_printk.o = -pg
 endif
 
@@ -30,7 +31,7 @@ obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_MODULES)		+= mips_ksyms.o module.o
 
 obj-$(CONFIG_FTRACE)		+= trace_clock.o
-obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o
+obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
 
 obj-$(CONFIG_CPU_LOONGSON2)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_MIPS32)	+= r4k_fpu.o r4k_switch.o
diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
new file mode 100644
index 0000000..5459a78
--- /dev/null
+++ b/arch/mips/kernel/ftrace.c
@@ -0,0 +1,112 @@
+/*
+ * Code for replacing ftrace calls with jumps.
+ *
+ * Copyright (C) 2007-2008 Steven Rostedt <srostedt@redhat.com>
+ * Copyright (C) 2009 DSLab, Lanzhou University, China
+ * Author: Wu Zhangjin <wuzj@lemote.com>
+ *
+ * Thanks goes to Steven Rostedt for writing the original x86 version.
+ */
+
+#include <linux/uaccess.h>
+#include <linux/init.h>
+#include <linux/ftrace.h>
+
+#include <asm/cacheflush.h>
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+
+#define JAL 0x0c000000		/* jump & link: ip --> ra, jump to target */
+#define ADDR_MASK 0x03ffffff	/*  op_code|addr : 31...26|25 ....0 */
+#define jump_insn_encode(op_code, addr) \
+	((unsigned int)((op_code) | (((addr) >> 2) & ADDR_MASK)))
+
+static unsigned int ftrace_nop = 0x00000000;
+
+static int ftrace_modify_code(unsigned long ip, unsigned int new_code)
+{
+	*(unsigned int *)ip = new_code;
+
+	flush_icache_range(ip, ip + 8);
+
+	return 0;
+}
+
+static int lui_v1;
+static int jal_mcount;
+
+int ftrace_make_nop(struct module *mod,
+		    struct dyn_ftrace *rec, unsigned long addr)
+{
+	unsigned int new;
+	unsigned long ip = rec->ip;
+
+	/* We have compiled module with -mlong-calls, but compiled the kernel
+	 * without it, we need to cope with them respectively. */
+	if (ip & 0x40000000) {
+		/* record it for ftrace_make_call */
+		if (lui_v1 == 0)
+			lui_v1 = *(unsigned int *)ip;
+
+		/* lui v1, hi_16bit_of_mcount        --> b 1f (0x10000004)
+		 * addiu v1, v1, low_16bit_of_mcount
+		 * move at, ra
+		 * jalr v1
+		 * nop
+		 * 				     1f: (ip + 12)
+		 */
+		new = 0x10000004;
+	} else {
+		/* record/calculate it for ftrace_make_call */
+		if (jal_mcount == 0) {
+			/* We can record it directly like this:
+			 *     jal_mcount = *(unsigned int *)ip;
+			 * Herein, jump over the first two nop instructions */
+			jal_mcount = jump_insn_encode(JAL, (MCOUNT_ADDR + 8));
+		}
+
+		/* move at, ra
+		 * jalr v1		--> nop
+		 */
+		new = ftrace_nop;
+	}
+	return ftrace_modify_code(ip, new);
+}
+
+static int modified;	/* initialized as 0 by default */
+
+int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+{
+	unsigned int new;
+	unsigned long ip = rec->ip;
+
+	/* We just need to remove the "b ftrace_stub" at the fist time! */
+	if (modified == 0) {
+		modified = 1;
+		ftrace_modify_code(addr, ftrace_nop);
+	}
+	/* ip, module: 0xc0000000, kernel: 0x80000000 */
+	new = (ip & 0x40000000) ? lui_v1 : jal_mcount;
+
+	return ftrace_modify_code(ip, new);
+}
+
+#define FTRACE_CALL_IP ((unsigned long)(&ftrace_call))
+
+int ftrace_update_ftrace_func(ftrace_func_t func)
+{
+	unsigned int new;
+
+	new = jump_insn_encode(JAL, (unsigned long)func);
+
+	return ftrace_modify_code(FTRACE_CALL_IP, new);
+}
+
+int __init ftrace_dyn_arch_init(void *data)
+{
+	/* The return code is retured via data */
+	*(unsigned long *)data = 0;
+
+	return 0;
+}
+#endif				/* CONFIG_DYNAMIC_FTRACE */
diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index cbb45ed..ffc4259 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -58,6 +58,33 @@
 	 move ra, AT
 	.endm
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+
+NESTED(ftrace_caller, PT_SIZE, ra)
+	.globl _mcount
+_mcount:
+	b	ftrace_stub
+	 nop
+	lw	t0, function_trace_stop
+	bnez	t0, ftrace_stub
+	 nop
+
+	MCOUNT_SAVE_REGS
+
+	move	a0, ra		/* arg1: next ip, selfaddr */
+	.globl ftrace_call
+ftrace_call:
+	nop	/* a placeholder for the call to a real tracing function */
+	 move	a1, AT		/* arg2: the caller's next ip, parent */
+
+	MCOUNT_RESTORE_REGS
+	.globl ftrace_stub
+ftrace_stub:
+	RETURN_BACK
+	END(ftrace_caller)
+
+#else	/* ! CONFIG_DYNAMIC_FTRACE */
+
 NESTED(_mcount, PT_SIZE, ra)
 	lw	t0, function_trace_stop
 	bnez	t0, ftrace_stub
@@ -82,5 +109,7 @@ ftrace_stub:
 	RETURN_BACK
 	END(_mcount)
 
+#endif	/* ! CONFIG_DYNAMIC_FTRACE */
+
 	.set at
 	.set reorder
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 62a0001..d6999a2 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -287,6 +287,60 @@ if ($arch eq "x86_64") {
     $ld .= " -m elf64_sparc";
     $cc .= " -m64";
     $objcopy .= " -O elf64-sparc";
+
+} elsif ($arch eq "mips") {
+    # To enable module support, we need to enable the -mlong-calls option
+    # of gcc for module, after using this option, we can not get the real
+    # offset of the calling to _mcount, but the offset of the lui
+    # instruction or the addiu one. herein, we record the address of the
+    # first one, and then we can replace this instruction by a branch
+    # instruction to jump over the profiling function to filter the
+    # indicated functions, or swith back to the lui instruction to trace
+    # them, which means dynamic tracing.
+    #
+    #       c:	3c030000 	lui	v1,0x0
+    #			c: R_MIPS_HI16	_mcount
+    #			c: R_MIPS_NONE	*ABS*
+    #			c: R_MIPS_NONE	*ABS*
+    #      10:	64630000 	daddiu	v1,v1,0
+    #			10: R_MIPS_LO16	_mcount
+    #			10: R_MIPS_NONE	*ABS*
+    #			10: R_MIPS_NONE	*ABS*
+    #      14:	03e0082d 	move	at,ra
+    #      18:	0060f809 	jalr	v1
+    #
+    # for the kernel:
+    #
+    #     10:   03e0082d        move    at,ra
+    #	  14:   0c000000        jal     0 <loongson_halt>
+    #                    14: R_MIPS_26   _mcount
+    #                    14: R_MIPS_NONE *ABS*
+    #                    14: R_MIPS_NONE *ABS*
+    #	 18:   00020021        nop
+    if ($is_module eq "0") {
+	    $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s_mcount\$";
+    } else {
+	    $mcount_regex = "^\\s*([0-9a-fA-F]+): R_MIPS_HI16\\s+_mcount\$";
+    }
+    $objdump .= " -Melf-trad".$endian."mips ";
+
+    if ($endian eq "big") {
+	    $endian = " -EB ";
+	    $ld .= " -melf".$bits."btsmip";
+    } else {
+	    $endian = " -EL ";
+	    $ld .= " -melf".$bits."ltsmip";
+    }
+
+    $cc .= " -mno-abicalls -fno-pic -mabi=" . $bits . $endian;
+    $ld .= $endian;
+
+    if ($bits == 64) {
+	    $function_regex =
+		"^([0-9a-fA-F]+)\\s+<(.|[^\$]L.*?|\$[^L].*?|[^\$][^L].*?)>:";
+	    $type = ".dword";
+    }
+
 } else {
     die "Arch $arch is not supported with CONFIG_FTRACE_MCOUNT_RECORD";
 }
-- 
1.6.2.1
