Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Oct 2009 16:20:27 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:45028 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492496AbZJYPSI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 25 Oct 2009 16:18:08 +0100
Received: by mail-pw0-f45.google.com with SMTP id 11so939668pwi.24
        for <multiple recipients>; Sun, 25 Oct 2009 08:18:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=+MW3jA3cmP/xILLM7LkL0fOJflZNjdp6aFkgzj00oCE=;
        b=T4ApK0QTOB49narE+9i/a84JHQcm2GRtiV9iy5whQqCDp3L8w+zhHkY2HQ++KgxAbM
         gx7Vh1B3EJWX0895fQeQtB00wuVGXB7z62v91z+UuoT2baPSJis6bCDN55ajcNWO5PSB
         VKoVk2Vb/bAx2HbAqvKXDPD/bjP4wfQH7mL7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=g+WewNaDXOAk88Arc7y1uwkj2P5wC72ilAutiDLGuBTbzBt6HG5D53aMfRroRFhJSx
         qgowgIHNc+Ps90NqaRHkPmH3DSsVDSPMxeaH4LE0r0HTVenhFP0qtH6Ih+N/2jnYuhDK
         +Jl2h0eFBIwJXgweJ5fQAK9h+k0PG2GcmJq9U=
Received: by 10.114.44.14 with SMTP id r14mr20500668war.196.1256483887373;
        Sun, 25 Oct 2009 08:18:07 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm1742515pxi.14.2009.10.25.08.18.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 08:18:06 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, rostedt@goodmis.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>,
	Wu Zhangjin <wuzj@lemote.com>
Subject: [PATCH -v5 07/11] tracing: add dynamic function tracer support for MIPS
Date:	Sun, 25 Oct 2009 23:16:58 +0800
Message-Id: <6140dd8f4e1783e5ac30977cf008bb98e4698322.1256483735.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <72f2270f7b6e01ca7a4cdf4ac8c21778e5d9652f.1256483735.git.wuzhangjin@gmail.com>
References: <cover.1256482555.git.wuzhangjin@gmail.com>
 <028867b99ec532b84963a35e7d552becc783cafc.1256483735.git.wuzhangjin@gmail.com>
 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256483735.git.wuzhangjin@gmail.com>
 <3e0c2d7d8b8f196a8153beb41ea7f3cbf42b3d84.1256483735.git.wuzhangjin@gmail.com>
 <54c417629e91f40b2bbb4e08cda2a4e6527824c0.1256483735.git.wuzhangjin@gmail.com>
 <29bccff04932e993ecd9f516d8b6dcf84e2ceecf.1256483735.git.wuzhangjin@gmail.com>
 <72f2270f7b6e01ca7a4cdf4ac8c21778e5d9652f.1256483735.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1256483735.git.wuzhangjin@gmail.com>
References: <cover.1256483735.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

With dynamic function tracer, by default, _mcount is defined as an
"empty" function, it just return without any more action, just like the
static function tracer does. When enabling it in user-space, it will
jump to a real tracing function(ftrace_caller), and do some real job for
us.

Differ from the static function tracer, dynamic function tracer provides
two functions ftrace_make_call()/ftrace_make_nop() to enable/disable the
tracing of some indicated kernel functions(set_ftrace_filter).

In the -v4 version, the implementation of this support is basically the same as
X86 version does: _mcount is implemented as an empty function and ftrace_caller
is implemented as a real tracing function respectively.

But in this version, to support module tracing with the help of
-mlong-calls. the stuff becomes a little more complex, let's have a look
at the new calling to _mcount with -mlong-calls(result of "objdump -hdr
vmlinux").

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

and the old version without -mlong-calls looks like this:

	108:   03e0082d        move    at,ra
	10c:   0c000000        jal     0 <fpcsr_pending>
                        10c: R_MIPS_26  _mcount
                        10c: R_MIPS_NONE        *ABS*
                        10c: R_MIPS_NONE        *ABS*
	110:   00020021        nop

In the old version, there is only one "_mcount" string for every kernel
function, so, we just need to match this one in mcount_regex of
scripts/recordmcount.pl, but in the new version, we need to choose one
of the two to match. Herein, I choose the first one with "R_MIPS_HI16
_mcount".

and In the old verion, without module tracing support, we just need to replace
"jal _mcount" by "jal ftrace_caller" to do real tracing, and filter the tracing
of some kernel functions via replacing it by a nop instruction.

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

Is there a simpler solution, Yes! Here it is, in this version, we put _mcount
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

what about filtering job? we just need to switching the "jalr v1" and "nop"
instruction.

In linux-mips64, there will be some local symbols, whose name are
prefixed by $L, which need to be filtered. thanks goes to Steven for
writing the mips64-specific function_regex.

In a conclusion, with RISC, things becomes easier with such a "stupid"
trick, RISC is something like K.I.S.S, and also, there are lots of
"simple" tricks in the whole ftrace support, thanks goes to Steven and
the other folks for providing such a wonderful tracing framework!

Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
---
 arch/mips/Kconfig              |    2 +
 arch/mips/include/asm/ftrace.h |   12 ++++++
 arch/mips/kernel/Makefile      |    3 +-
 arch/mips/kernel/ftrace.c      |   76 ++++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/mcount.S      |   29 +++++++++++++++
 scripts/recordmcount.pl        |   38 ++++++++++++++++++++
 6 files changed, 159 insertions(+), 1 deletions(-)
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
index 5f8ebcf..d5771e8 100644
--- a/arch/mips/include/asm/ftrace.h
+++ b/arch/mips/include/asm/ftrace.h
@@ -19,6 +19,18 @@
 extern void _mcount(void);
 #define mcount _mcount
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+static inline unsigned long ftrace_call_adjust(unsigned long addr)
+{
+	/* 12 is the offset of "jalr v1" from the first loading instruction
+	 * "lui v1, HI_16BIT", please get more information from
+	 * scripts/recordmcount.pl */
+	return addr + 12;
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
index 0000000..0be30cf
--- /dev/null
+++ b/arch/mips/kernel/ftrace.c
@@ -0,0 +1,76 @@
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
+
+#ifdef CONFIG_CPU_LOONGSON2F
+static unsigned int ftrace_nop = 0x00020021;
+#else
+static unsigned int ftrace_nop = 0x00000000;
+#endif
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
+int ftrace_make_nop(struct module *mod,
+		    struct dyn_ftrace *rec, unsigned long addr)
+{
+	return ftrace_modify_code(rec->ip, ftrace_nop);
+}
+
+static int modified;	/* initialized as 0 by default */
+#define JALR_V1 0x0060f809
+
+int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+{
+	/* We just need to remove the "j ftrace_stub" at the fist time! */
+	if (modified == 0) {
+		modified = 1;
+		ftrace_modify_code(addr, ftrace_nop);
+	}
+	return ftrace_modify_code(rec->ip, JALR_V1);
+}
+
+#define FTRACE_CALL_IP ((unsigned long)(&ftrace_call))
+#define jump_insn_encode(op_code, addr) \
+	((unsigned int)((op_code) | (((addr) >> 2) & ADDR_MASK)))
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
index 5dfaca8..389be7b 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -63,6 +63,33 @@
 	move ra, AT
 	.endm
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+
+NESTED(ftrace_caller, PT_SIZE, ra)
+	.globl _mcount
+_mcount:
+	j	ftrace_stub
+	nop
+	lw	t0, function_trace_stop
+	bnez	t0, ftrace_stub
+	nop
+
+	MCOUNT_SAVE_REGS
+
+	MCOUNT_SET_ARGS
+	.globl ftrace_call
+ftrace_call:
+	nop	/* a placeholder for the call to a real tracing function */
+	nop	/* Do not touch me, I'm in the dealy slot of "jal func" */
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
@@ -89,5 +116,7 @@ ftrace_stub:
 	RETURN_BACK
 	END(_mcount)
 
+#endif	/* ! CONFIG_DYNAMIC_FTRACE */
+
 	.set at
 	.set reorder
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index daee038..aefe777 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -245,6 +245,44 @@ if ($arch eq "x86_64") {
     $ld .= " -m elf64_sparc";
     $cc .= " -m64";
     $objcopy .= " -O elf64-sparc";
+
+} elsif ($arch eq "mips") {
+    # To enable module support, we need to enable the -mlong-calls option
+    # of gcc for MIPS, after using this option, we can not get the real
+    # offset of the calling to _mcount, but the offset of the first loading
+    # instruction or the second one, here we get the first one, and then,
+    # we plus it with 12 in arch/mips/kernel/asm/ftrace.h.
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
+    $mcount_regex = "^\\s*([0-9a-fA-F]+): R_MIPS_HI16\\s+_mcount\$";
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
