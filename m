Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2010 16:07:10 +0100 (CET)
Received: from mail-px0-f181.google.com ([209.85.216.181]:44838 "EHLO
        mail-px0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492556Ab0ACPHF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Jan 2010 16:07:05 +0100
Received: by pxi11 with SMTP id 11so10591212pxi.22
        for <multiple recipients>; Sun, 03 Jan 2010 07:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:cc:content-type;
        bh=pr4gsF5bNgAoWx5NRZHMGZMll3kEyEwhqvmeS30S8ZQ=;
        b=QTfin0152BKLCHdSpZJp6LQuSfCJdYZLaG/LWP1VbMMq++yK6VPbDupvyoaXq/ZwVV
         faOPa/pISHsj+WTi2U3gAZPQdMZQy1FqFczvkm5OZ0ogZXaPQKIsL4s9eV44rs33bv8A
         isvnj27CdVtG4JlqDsWopFckUvLs3y+R9hFFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=adheAyaN4TjAPnbC8heI5qMMsFiwrMBoDSEX/ojZ0wzldd4ElE/XnVsF0cmDptGIcU
         QbDG4ZysTdUhXiCcAz1jdafmSRaLGh+0seQKfDxmCAHqdtF5u5qaSbMheXVAoL6qvGdB
         wUhkWJ2NlOPahCHVJccx8WWwEvrp7o8cdNfvY=
MIME-Version: 1.0
Received: by 10.142.56.11 with SMTP id e11mr14894314wfa.118.1262531215351; 
        Sun, 03 Jan 2010 07:06:55 -0800 (PST)
From:   Hui Zhu <teawater@gmail.com>
Date:   Sun, 3 Jan 2010 23:05:05 +0800
Message-ID: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com>
Subject: [PATCH] stack2core: show stack message and convert it to core file 
        when kernel die
To:     Russell King <linux@arm.linux.org.uk>,
        saeed bishara <saeed.bishara@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
        Chris Dearman <chris@mips.com>,
        Paul Gortmaker <Paul.Gortmaker@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Brian Gerst <brgerst@gmail.com>, Tejun Heo <tj@kernel.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Cc:     Coly Li <coly.li@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 25474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: teawater@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1915

Hello,

For, when the kernel die, the user will get some message like:
PC is at kernel_init+0xd4/0x104
LR is at _atomic_dec_and_lock+0x48/0x6c
pc : [<c0008470>]    lr : [<c01911f8>]    psr: 60000013
sp : c7823fd8  ip : c7823f48  fp : c7823ff4
Stack: (0xc7823fd8 to 0xc7824000)
3fc0:                                                       00000000 00000001
Backtrace:
[<c000839c>] (kernel_init+0x0/0x104) from [<c0042660>] (do_exit+0x0/0x880)
This backtrace have some wrong message sometime and cannot get any
val. Of course, kdump can get more message.  But it need do some a lot
of other config.

The stack2core function, can let kernel show stack message when kernel
die.  This stack message can be convert to core file by program s2c
(tools/s2c).  Then gdb can show the message in this core file.
For example:
When kernel die, show some message:
S2C:elf_class=1
S2C:elf_data=1
S2C:elf_arch=40
S2C:elf_osabi=0
S2C:r0=0x00000000;
S2C:r1=0xc7822000;
S2C:r2=0xc7823f48;
S2C:r3=0x00000003;
S2C:r4=0x00000000;
S2C:r5=0x00000000;
S2C:r6=0x00000000;
S2C:r7=0x00000000;
S2C:r8=0x00000000;
S2C:r9=0x00000000;
S2C:r10=0x00000000;
S2C:fp=0xc7823ff4;
S2C:ip=0xc7823f48;
S2C:sp=0xc7823fd8;
S2C:lr=0xc01911f8;
S2C:pc=0xc0008470;
S2C:cpsr=0x60000013;
S2C:ORIG_r0=0xffffffff;

S2C:stack=0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
S2C:stack=0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
S2C:stack=0x00, 0x00, 0x00, 0x00, 0xf8, 0x3f, 0x82, 0xc7,
S2C:stack=0x60, 0x26, 0x04, 0xc0, 0xa8, 0x83, 0x00, 0xc0,
S2C:stack=0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
S2C:commandline=console=ttyAMA0,115200 ip=dhcp root=/dev/nfs
nfsroot=10.0.2.2:/home/teawater/kernel/arm_versatile_926ejs.glibc_std.standard/export/dist,nfsvers=2,mountprog=21111,nfsprog=11111,udp
rw highres=off UMA=1

Save it to file t.txt.  This is the reg message and stack message.

Get the s2c program.
cd linux-2.6/tools/s2c
sudo make install

Get the core file.
s2c < t.txt >core

Use core file.
gdb ./vmlinux core
Core was generated by `console=ttyAMA0,115200 ip=dhcp root=/dev/nfs
nfsroot=10.0.2.2:/home/teawater/ke'.
[New process 0]
#0  0xc0008470 in kernel_init (unused=<value optimized out>)
    at /home/teawater/kernel/arm_versatile_926ejs.glibc_std.standard/build/linux/init/main.c:916
916		buf[0] = 3;
(gdb) bt
#0  0xc0008470 in kernel_init (unused=<value optimized out>)
    at /home/teawater/kernel/arm_versatile_926ejs.glibc_std.standard/build/linux/init/main.c:916
#1  0xc0042660 in sys_waitid (which=<value optimized out>, upid=<value
optimized out>, infop=0x0, options=0, ru=0x14)
    at /home/teawater/kernel/arm_versatile_926ejs.glibc_std.standard/build/linux/kernel/exit.c:1798
Backtrace stopped: previous frame inner to this frame (corrupt stack?)
(gdb) frame 1
#1  0xc0042660 in sys_waitid (which=<value optimized out>, upid=<value
optimized out>, infop=0x0, options=0, ru=0x14)
    at /home/teawater/kernel/arm_versatile_926ejs.glibc_std.standard/build/linux/kernel/exit.c:1798
1798			pid = find_get_pid(upid);
(gdb) p pid
$1 = (struct pid *) 0x0

It can support lkm:
The stack message will include:
S2C:add-symbol-file e.ko 0xffffffffa0000000
In gdb, use command "add-symbol-file e.ko 0xffffffffa0000000" let gdb
load the symbol of this lkm.


Now, stack2core support x86, x8664, arm, mips.

Thanks,
Hui

---
 arch/arm/kernel/traps.c        |   27 +
 arch/mips/kernel/traps.c       |   20
 arch/x86/kernel/dumpstack_32.c |   27 +
 arch/x86/kernel/dumpstack_64.c |   31 +
 include/linux/module.h         |    4
 include/linux/stack2core.h     |   49 +
 kernel/module.c                |   13
 lib/Kconfig.debug              |    9
 tools/s2c/Makefile             |   15
 tools/s2c/s2c.c                | 1009 +++++++++++++++++++++++++++++++++++++++++
 10 files changed, 1204 insertions(+)

--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -28,6 +28,7 @@
 #include <asm/unistd.h>
 #include <asm/traps.h>
 #include <asm/unwind.h>
+#include <linux/stack2core.h>

 #include "ptrace.h"
 #include "signal.h"
@@ -242,6 +243,32 @@ static void __die(const char *str, int e
 			 THREAD_SIZE + (unsigned long)task_stack_page(tsk));
 		dump_backtrace(regs, tsk);
 		dump_instr(KERN_EMERG, regs);
+
+#ifdef CONFIG_STACK2CORE
+		stack2core_header();
+
+		/* Show the registers */
+		printk(S2CMARK"r0=0x%08x;\n", (unsigned int)regs->ARM_r0);
+		printk(S2CMARK"r1=0x%08x;\n", (unsigned int)regs->ARM_r1);
+		printk(S2CMARK"r2=0x%08x;\n", (unsigned int)regs->ARM_r2);
+		printk(S2CMARK"r3=0x%08x;\n", (unsigned int)regs->ARM_r3);
+		printk(S2CMARK"r4=0x%08x;\n", (unsigned int)regs->ARM_r4);
+		printk(S2CMARK"r5=0x%08x;\n", (unsigned int)regs->ARM_r5);
+		printk(S2CMARK"r6=0x%08x;\n", (unsigned int)regs->ARM_r6);
+		printk(S2CMARK"r7=0x%08x;\n", (unsigned int)regs->ARM_r7);
+		printk(S2CMARK"r8=0x%08x;\n", (unsigned int)regs->ARM_r8);
+		printk(S2CMARK"r9=0x%08x;\n", (unsigned int)regs->ARM_r9);
+		printk(S2CMARK"r10=0x%08x;\n", (unsigned int)regs->ARM_r10);
+		printk(S2CMARK"fp=0x%08x;\n", (unsigned int)regs->ARM_fp);
+		printk(S2CMARK"ip=0x%08x;\n", (unsigned int)regs->ARM_ip);
+		printk(S2CMARK"sp=0x%08x;\n", (unsigned int)regs->ARM_sp);
+		printk(S2CMARK"lr=0x%08x;\n", (unsigned int)regs->ARM_lr);
+		printk(S2CMARK"pc=0x%08x;\n", (unsigned int)regs->ARM_pc);
+		printk(S2CMARK"cpsr=0x%08x;\n", (unsigned int)regs->ARM_cpsr);
+		printk(S2CMARK"ORIG_r0=0x%08x;\n", (unsigned int)regs->ARM_ORIG_r0);
+
+		stack2core_tail((uint8_t *)(regs->ARM_sp));
+#endif	/* CONFIG_STACK2CORE */
 	}
 }

--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -347,6 +347,26 @@ void show_registers(const struct pt_regs
 	show_stacktrace(current, regs);
 	show_code((unsigned int __user *) regs->cp0_epc);
 	printk("\n");
+#ifdef CONFIG_STACK2CORE
+	stack2core_header();
+
+	/* Show the registers */
+	{
+		int	i;
+
+		for (i = 0; i < 32; i++)
+			printk(S2CMARK"r%d=0x%lx;\n", i, regs->regs[i]);
+
+		printk(S2CMARK"cp0_status=0x%lx;\n", regs->cp0_status);
+		printk(S2CMARK"hi=0x%lx;\n", regs->hi);
+		printk(S2CMARK"lo=0x%lx;\n", regs->lo);
+		printk(S2CMARK"cp0_badvaddr=0x%lx;\n", regs->cp0_badvaddr);
+		printk(S2CMARK"cp0_cause=0x%lx;\n", regs->cp0_cause);
+		printk(S2CMARK"cp0_epc=0x%lx;\n", regs->cp0_epc);
+	}
+
+	stack2core_tail((uint8_t *)(regs->regs[29]));
+#endif	/* CONFIG_STACK2CORE */
 }

 static DEFINE_SPINLOCK(die_lock);
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -13,6 +13,7 @@
 #include <linux/sysfs.h>
 #include <linux/bug.h>
 #include <linux/nmi.h>
+#include <linux/stack2core.h>

 #include <asm/stacktrace.h>

@@ -141,6 +142,32 @@ void show_registers(struct pt_regs *regs
 			else
 				printk("%02x ", c);
 		}
+
+#ifdef CONFIG_STACK2CORE
+		printk("\n");
+		stack2core_header();
+
+		/* Show the registers */
+		printk(S2CMARK"bx=0x%08x;\n", (unsigned int)regs->bx);
+		printk(S2CMARK"cx=0x%08x;\n", (unsigned int)regs->cx);
+		printk(S2CMARK"dx=0x%08x;\n", (unsigned int)regs->dx);
+		printk(S2CMARK"si=0x%08x;\n", (unsigned int)regs->si);
+		printk(S2CMARK"di=0x%08x;\n", (unsigned int)regs->di);
+		printk(S2CMARK"bp=0x%08x;\n", (unsigned int)regs->bp);
+		printk(S2CMARK"ax=0x%08x;\n", (unsigned int)regs->ax);
+		printk(S2CMARK"ds=0x%08x;\n", (unsigned int)regs->ds);
+		printk(S2CMARK"es=0x%08x;\n", (unsigned int)regs->es);
+		printk(S2CMARK"fs=0x%08x;\n", (unsigned int)regs->fs);
+		printk(S2CMARK"gs=0x%08x;\n", (unsigned int)regs->gs);
+		printk(S2CMARK"orig_ax=0x%08x;\n", (unsigned int)regs->orig_ax);
+		printk(S2CMARK"ip=0x%08x;\n", (unsigned int)regs->ip);
+		printk(S2CMARK"cs=0x%08x;\n", (unsigned int)regs->cs);
+		printk(S2CMARK"flags=0x%08x;\n", (unsigned int)regs->flags);
+		printk(S2CMARK"sp=0x%08x;\n", (unsigned int)&regs->sp);
+		printk(S2CMARK"ss=0x%08x;\n", (unsigned int)regs->ss);
+
+		stack2core_tail((uint8_t *)(&regs->sp));
+#endif	/* CONFIG_STACK2CORE */
 	}
 	printk("\n");
 }
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -13,6 +13,7 @@
 #include <linux/sysfs.h>
 #include <linux/bug.h>
 #include <linux/nmi.h>
+#include <linux/stack2core.h>

 #include <asm/stacktrace.h>

@@ -328,6 +329,36 @@ void show_registers(struct pt_regs *regs
 			else
 				printk("%02x ", c);
 		}
+
+#ifdef CONFIG_STACK2CORE
+		printk("\n");
+		stack2core_header();
+
+		/* Show the registers */
+		printk(S2CMARK"r15=0x%016x;\n", (unsigned long)regs->r15);
+		printk(S2CMARK"r14=0x%016x;\n", (unsigned long)regs->r14);
+		printk(S2CMARK"r13=0x%016x;\n", (unsigned long)regs->r13);
+		printk(S2CMARK"r12=0x%016x;\n", (unsigned long)regs->r12);
+		printk(S2CMARK"bp=0x%016x;\n", (unsigned long)regs->bp);
+		printk(S2CMARK"bx=0x%016x;\n", (unsigned long)regs->bx);
+		printk(S2CMARK"r11=0x%016x;\n", (unsigned long)regs->r11);
+		printk(S2CMARK"r10=0x%016x;\n", (unsigned long)regs->r10);
+		printk(S2CMARK"r9=0x%016x;\n", (unsigned long)regs->r9);
+ 		printk(S2CMARK"r8=0x%016x;\n", (unsigned long)regs->r8);
+		printk(S2CMARK"ax=0x%016x;\n", (unsigned long)regs->ax);
+		printk(S2CMARK"cx=0x%016x;\n", (unsigned long)regs->cx);
+		printk(S2CMARK"dx=0x%016x;\n", (unsigned long)regs->dx);
+		printk(S2CMARK"si=0x%016x;\n", (unsigned long)regs->si);
+		printk(S2CMARK"di=0x%016x;\n", (unsigned long)regs->di);
+		printk(S2CMARK"orig_ax=0x%016x;\n", (unsigned long)regs->orig_ax);
+		printk(S2CMARK"ip=0x%016x;\n", (unsigned long)regs->ip);
+		printk(S2CMARK"cs=0x%016x;\n", (unsigned long)regs->cs);
+		printk(S2CMARK"flags=0x%016x;\n", (unsigned long)regs->flags);
+		printk(S2CMARK"sp=0x%016x;\n", (unsigned long)regs->sp);
+		printk(S2CMARK"ss=0x%016x;\n", (unsigned long)regs->ss);
+
+		stack2core_tail((uint8_t *)(regs->sp));
+#endif	/* CONFIG_STACK2CORE */
 	}
 	printk("\n");
 }
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -726,4 +726,8 @@ static inline int  module_bug_finalize(c
 static inline void module_bug_cleanup(struct module *mod) {}
 #endif	/* CONFIG_GENERIC_BUG */

+#ifdef CONFIG_STACK2CORE
+extern void module_print_address_for_s2c (void);
+#endif	/* CONFIG_STACK2CORE */
+
 #endif /* _LINUX_MODULE_H */
--- /dev/null
+++ b/include/linux/stack2core.h
@@ -0,0 +1,49 @@
+/*
+ *  Copyright (C) 2009, 2010, Hui Zhu
+ */
+#ifndef _STACK2CORE_H_
+#define _STACK2CORE_H_
+
+#ifdef CONFIG_STACK2CORE
+
+#define S2CMARK	KERN_EMERG "S2C:"
+
+static inline void
+stack2core_header(void)
+{
+	printk(S2CMARK"elf_class=%d\n", ELF_CLASS);
+	printk(S2CMARK"elf_data=%d\n", ELF_DATA);
+	printk(S2CMARK"elf_arch=%d\n", ELF_ARCH);
+	printk(S2CMARK"elf_osabi=%d\n", ELF_OSABI);
+}
+
+static inline void
+stack2core_tail(uint8_t *stack)
+{
+	int	i = 7;
+	uint8_t	*stack_end = (uint8_t *)(((unsigned long)stack &
(~(THREAD_SIZE - 1))) + THREAD_SIZE);
+
+	/* Show stack.  */
+	for (; stack < stack_end; stack++) {
+		if (i > 6) {
+			printk("\n");
+			printk(S2CMARK"stack=0x%02x,", stack[0]);
+			i = 0;
+		}
+		else {
+			printk(" 0x%02x,", stack[0]);
+			i ++;
+		}
+	}
+	printk("\n");
+
+	/* Show the modules.  */
+	module_print_address_for_s2c ();
+
+	/* Show command line.  */
+	printk(S2CMARK"commandline=%s\n", saved_command_line);
+}
+
+#endif	/* CONFIG_STACK2CORE */
+
+#endif /* _STACK2CORE_H_ */
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -55,6 +55,7 @@
 #include <linux/async.h>
 #include <linux/percpu.h>
 #include <linux/kmemleak.h>
+#include <linux/stack2core.h>

 #define CREATE_TRACE_POINTS
 #include <trace/events/module.h>
@@ -3014,3 +3015,15 @@ int module_get_iter_tracepoints(struct t
 	return found;
 }
 #endif
+
+#ifdef CONFIG_STACK2CORE
+void
+module_print_address_for_s2c (void)
+{
+	struct module *mod;
+
+	list_for_each_entry(mod, &modules, list)
+		printk(S2CMARK"add-symbol-file %s.ko 0x%p\n",
+			mod->name, mod->module_core);
+}
+#endif	/* CONFIG_STACK2CORE */
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -322,6 +322,15 @@ config DEBUG_SLAB
 	  allocation as well as poisoning memory on free to catch use of freed
 	  memory. This can make kmalloc/kfree-intensive workloads much slower.

+config STACK2CORE
+	bool "Output stack data when kernel die."
+	depends on DEBUG_KERNEL && (X86 || MIPS || ARM)
+	default y
+	help
+	  If say Y here, kernel will output stack data when it die.  This data
+	  can be convert to core file through program stack2core.  Then GDB can
+	  do clear backtrace with this core file.
+
 config DEBUG_SLAB_LEAK
 	bool "Memory leak debugging"
 	depends on DEBUG_SLAB
--- /dev/null
+++ b/tools/s2c/Makefile
@@ -0,0 +1,15 @@
+TARGET = s2c
+CC = gcc
+CFLAGS = -g
+
+
+all: $(TARGET)
+
+$(TARGET): $(TARGET).c
+	$(CC) $(CFLAGS) $(TARGET).c -o $(TARGET)
+
+clean:
+	rm -rf $(TARGET)
+
+install: $(TARGET)
+	cp $(TARGET) /bin/
--- /dev/null
+++ b/tools/s2c/s2c.c
@@ -0,0 +1,1009 @@
+/*
+ *  Copyright (C) 2009, 2010, Hui Zhu
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdint.h>
+#include <ctype.h>
+#include <byteswap.h>
+
+#define S2CMARK		"S2C:"
+
+#define S2C_ELFCLASS32	1
+#define S2C_ELFCLASS64	2
+
+#define S2C_ELFDATA2LSB	1	/* little endian */
+#define S2C_ELFDATA2MSB	2	/* big endian */
+
+#define S2C_EM_386	3
+#define S2C_EM_X86_64	62
+#define S2C_EM_ARM	40
+#define S2C_EM_MIPS	8
+
+#define NEEDSWAP	((BYTE_ORDER == LITTLE_ENDIAN \
+                          && elf_data == S2C_ELFDATA2MSB) \
+		         || (BYTE_ORDER == BIG_ENDIAN \
+                             && elf_data == S2C_ELFDATA2LSB))
+#define SWAP16(a)	(NEEDSWAP ? bswap_16 (a) : a)
+#define SWAP32(a)	(NEEDSWAP ? bswap_32 (a) : a)
+#define SWAP64(a)	(NEEDSWAP ? bswap_64 (a) : a)
+
+#define GETU32(ul, str) \
+	if (strncmp (line, str, strlen (str)) == 0) { \
+		ul = strtoul (line + strlen (str), NULL, 0); \
+		return 0; \
+	}
+
+#define GETU64(ul, str) \
+	if (strncmp (line, str, strlen (str)) == 0) { \
+		ul = strtoull (line + strlen (str), NULL, 0); \
+		return 0; \
+	}
+
+/* Parse and save the input.  */
+
+uint8_t	elf_class = 0;
+uint8_t	elf_data = 0;
+uint8_t	elf_arch = 0;
+uint8_t	elf_osabi = 0;
+
+#define S2C_ELF_PRARGSZ	(80)
+uint8_t	commandline[S2C_ELF_PRARGSZ];
+
+#define S2C_THREAD_SIZE	8192
+uint8_t	stack[S2C_THREAD_SIZE];
+int stack_len = 0;
+
+uint32_t	sp_32 = 0;
+uint64_t	sp_64 = 0;
+
+/* I386 */
+
+uint32_t	i386_bx = 0;
+uint32_t	i386_cx = 0;
+uint32_t	i386_dx = 0;
+uint32_t	i386_si = 0;
+uint32_t	i386_di = 0;
+uint32_t	i386_bp = 0;
+uint32_t	i386_ax = 0;
+uint32_t	i386_ds = 0;
+uint32_t	i386_es = 0;
+uint32_t	i386_fs = 0;
+uint32_t	i386_gs = 0;
+uint32_t	i386_orig_ax = 0;
+uint32_t	i386_ip = 0;
+uint32_t	i386_cs = 0;
+uint32_t	i386_flags = 0;
+uint32_t	i386_sp = 0;
+uint32_t	i386_ss = 0;
+
+int
+parse_line_i386 (char *line)
+{
+	GETU32 (i386_bx, "bx=");
+	GETU32 (i386_cx, "cx=");
+	GETU32 (i386_dx, "dx=");
+	GETU32 (i386_si, "si=");
+	GETU32 (i386_di, "di=");
+	GETU32 (i386_bp, "bp=");
+	GETU32 (i386_ax, "ax=");
+	GETU32 (i386_ds, "ds=");
+	GETU32 (i386_es, "es=");
+	GETU32 (i386_fs, "fs=");
+	GETU32 (i386_gs, "gs=");
+	GETU32 (i386_orig_ax, "orig_ax=");
+	GETU32 (i386_ip, "ip=");
+	GETU32 (i386_cs, "cs=");
+	GETU32 (i386_flags, "flags=");
+	GETU32 (i386_sp, "sp=");
+	GETU32 (i386_ss, "ss=");
+
+	return 0;
+}
+
+/* x86_64 */
+
+uint64_t	x86_64_r15 = 0;
+uint64_t	x86_64_r14 = 0;
+uint64_t	x86_64_r13 = 0;
+uint64_t	x86_64_r12 = 0;
+uint64_t	x86_64_bp = 0;
+uint64_t	x86_64_bx = 0;
+uint64_t	x86_64_r11 = 0;
+uint64_t	x86_64_r10 = 0;
+uint64_t	x86_64_r9 = 0;
+uint64_t	x86_64_r8 = 0;
+uint64_t	x86_64_ax = 0;
+uint64_t	x86_64_cx = 0;
+uint64_t	x86_64_dx = 0;
+uint64_t	x86_64_si = 0;
+uint64_t	x86_64_di = 0;
+uint64_t	x86_64_orig_ax = 0;
+uint64_t	x86_64_ip = 0;
+uint64_t	x86_64_cs = 0;
+uint64_t	x86_64_flags = 0;
+uint64_t	x86_64_sp = 0;
+uint64_t	x86_64_ss = 0;
+
+int
+parse_line_x86_64 (char *line)
+{
+	GETU64 (x86_64_r15, "r15=");
+	GETU64 (x86_64_r14, "r14=");
+	GETU64 (x86_64_r13, "r13=");
+	GETU64 (x86_64_r12, "r12=");
+	GETU64 (x86_64_bp, "bp=");
+	GETU64 (x86_64_bx, "bx=");
+	GETU64 (x86_64_r11, "r11=");
+	GETU64 (x86_64_r10, "r10=");
+	GETU64 (x86_64_r9, "r9=");
+	GETU64 (x86_64_r8, "r8=");
+	GETU64 (x86_64_ax, "ax=");
+	GETU64 (x86_64_cx, "cx=");
+	GETU64 (x86_64_dx, "dx=");
+	GETU64 (x86_64_si, "si=");
+	GETU64 (x86_64_di, "di=");
+	GETU64 (x86_64_orig_ax, "orig_ax=");
+	GETU64 (x86_64_ip, "ip=");
+	GETU64 (x86_64_cs, "cs=");
+	GETU64 (x86_64_flags, "flags=");
+	GETU64 (x86_64_sp, "sp=");
+	GETU64 (x86_64_ss, "ss=");
+
+	return 0;
+}
+
+/* arm */
+
+uint32_t	arm_r0 = 0;
+uint32_t	arm_r1 = 0;
+uint32_t	arm_r2 = 0;
+uint32_t	arm_r3 = 0;
+uint32_t	arm_r4 = 0;
+uint32_t	arm_r5 = 0;
+uint32_t	arm_r6 = 0;
+uint32_t	arm_r7 = 0;
+uint32_t	arm_r8 = 0;
+uint32_t	arm_r9 = 0;
+uint32_t	arm_r10 = 0;
+uint32_t	arm_fp = 0;
+uint32_t	arm_ip = 0;
+uint32_t	arm_sp = 0;
+uint32_t	arm_lr = 0;
+uint32_t	arm_pc = 0;
+uint32_t	arm_cpsr = 0;
+uint32_t	arm_ORIG_r0 = 0;
+
+int
+parse_line_arm (char *line)
+{
+	GETU32 (arm_r0, "r0=");
+	GETU32 (arm_r1, "r1=");
+	GETU32 (arm_r2, "r2=");
+	GETU32 (arm_r3, "r3=");
+	GETU32 (arm_r4, "r4=");
+	GETU32 (arm_r5, "r5=");
+	GETU32 (arm_r6, "r6=");
+	GETU32 (arm_r7, "r7=");
+	GETU32 (arm_r8, "r8=");
+	GETU32 (arm_r9, "r9=");
+	GETU32 (arm_r10, "r10=");
+	GETU32 (arm_fp, "fp=");
+	GETU32 (arm_ip, "ip=");
+	GETU32 (arm_sp, "sp=");
+	GETU32 (arm_lr, "lr=");
+	GETU32 (arm_pc, "pc=");
+	GETU32 (arm_cpsr, "cpsr=");
+	GETU32 (arm_ORIG_r0, "ORIG_r0=");
+
+	return 0;
+}
+
+/* mips */
+
+uint32_t	mips32_r[32] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+				0, 0};
+uint32_t	mips32_hi = 0;
+uint32_t	mips32_lo = 0;
+uint32_t	mips32_cp0_epc = 0;
+uint32_t	mips32_cp0_badvaddr = 0;
+uint32_t	mips32_cp0_status = 0;
+uint32_t	mips32_cp0_cause = 0;
+
+
+uint64_t	mips64_r[32] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+				0, 0};
+uint64_t	mips64_hi = 0;
+uint64_t	mips64_lo = 0;
+uint64_t	mips64_cp0_epc = 0;
+uint64_t	mips64_cp0_badvaddr = 0;
+uint64_t	mips64_cp0_status = 0;
+uint64_t	mips64_cp0_cause = 0;
+
+int
+parse_line_mips (char *line)
+{
+	int	i;
+	char	str[10];
+
+	if (elf_class == S2C_ELFCLASS32) {
+		for (i = 0; i < 32; i++) {
+			snprintf (str, 10, "r%d=", i);
+			GETU32 (mips32_r[i], str);
+		}
+		GETU32 (mips32_cp0_status, "cp0_status=");
+		GETU32 (mips32_hi, "hi=");
+		GETU32 (mips32_lo, "lo=");
+		GETU32 (mips32_cp0_badvaddr, "cp0_badvaddr=");
+		GETU32 (mips32_cp0_cause, "cp0_cause=");
+		GETU32 (mips32_cp0_epc, "cp0_epc=");
+	}
+	else {
+		for (i = 0; i < 32; i++) {
+			snprintf (str, 10, "r%d=", i);
+			GETU64 (mips64_r[i], str);
+		}
+		GETU64 (mips64_cp0_status, "cp0_status=");
+		GETU64 (mips64_hi, "hi=");
+		GETU64 (mips64_lo, "lo=");
+		GETU64 (mips64_cp0_badvaddr, "cp0_badvaddr=");
+		GETU64 (mips64_cp0_cause, "cp0_cause=");
+		GETU64 (mips64_cp0_epc, "cp0_epc=");
+	}
+
+	return 0;
+}
+
+int
+parse_line (char *line)
+{
+	GETU32 (elf_class, "elf_class=");
+	GETU32 (elf_data, "elf_data=");
+	GETU32 (elf_arch, "elf_arch=");
+	GETU32 (elf_osabi, "elf_osabi=");
+
+	if (strncmp (line, "stack=", sizeof ("stack=") - 1) == 0) {
+		line += sizeof ("stack=") - 1;
+
+		while (stack_len < S2C_THREAD_SIZE && line[0]) {
+			if (isdigit (line[0]))
+				stack[stack_len++] = strtoul (line, &line, 0);
+			else
+				line++;
+		}
+		return 0;
+	}
+
+	if (strncmp (line, "commandline=", sizeof ("commandline=") - 1) == 0) {
+		snprintf ((char *)commandline, S2C_ELF_PRARGSZ, "%s",
+			  line + sizeof ("commandline=") - 1);
+		return 0;
+	}
+
+	switch (elf_arch) {
+		case S2C_EM_386:
+			return parse_line_i386 (line);
+			break;
+		case S2C_EM_X86_64:
+			return parse_line_x86_64 (line);
+			break;
+		case S2C_EM_ARM:
+			return parse_line_arm (line);
+			break;
+		case S2C_EM_MIPS:
+			return parse_line_mips (line);
+			break;
+	}
+
+	return 0;
+}
+
+void
+iterate_over_lines (FILE *fp)
+{
+	char	line[256], *linep;
+
+	if (!fp) {
+		fprintf(stderr, "Parse input error.\n");
+		exit (-1);
+	}
+
+	while(fgets(line, 256, fp) != NULL) {
+		linep = line;
+                linep = strstr (linep, S2CMARK);
+		if (linep) {
+			linep += sizeof (S2CMARK) - 1;
+			if (parse_line (linep)) {
+				fprintf(stderr, "Failied with parse line %s\n", line);
+				exit (-1);
+			}
+		}
+	}
+	if (ferror (fp)) {
+		fprintf(stderr, "Parse input error.\n");
+		exit (-1);
+	}
+}
+
+/* Convert and save to core_buf.  */
+
+uint8_t	core_buf[81920];
+int	core_buf_size = 0;
+
+#define S2C_EI_NIDENT	16
+
+typedef struct s2c_elf32_hdr_s {
+	uint8_t		e_ident[S2C_EI_NIDENT];
+	uint16_t	e_type;
+	uint16_t	e_machine;
+	uint32_t	e_version;
+	uint32_t	e_entry;
+	uint32_t	e_phoff;
+	uint32_t	e_shoff;
+	uint32_t	e_flags;
+	uint16_t	e_ehsize;
+	uint16_t	e_phentsize;
+	uint16_t	e_phnum;
+	uint16_t	e_shentsize;
+	uint16_t	e_shnum;
+	uint16_t	e_shstrndx;
+} s2c_elf32_hdr_t;
+
+typedef struct s2c_elf64_hdr_s {
+	uint8_t		e_ident[S2C_EI_NIDENT];
+	uint16_t	e_type;
+	uint16_t	e_machine;
+	uint32_t	e_version;
+	uint64_t	e_entry;
+	uint64_t	e_phoff;
+	uint64_t	e_shoff;
+	uint32_t	e_flags;
+	uint16_t	e_ehsize;
+	uint16_t	e_phentsize;
+	uint16_t	e_phnum;
+	uint16_t	e_shentsize;
+	uint16_t	e_shnum;
+	uint16_t	e_shstrndx;
+} s2c_elf64_hdr_t;
+
+#define	S2C_ELFMAG	"\177ELF"
+#define S2C_SELFMAG	4
+#define S2C_EI_CLASS	4
+#define S2C_EI_DATA	5
+#define	S2C_EI_VERSION	6
+#define S2C_EV_CURRENT	1
+#define	S2C_EI_OSABI	7
+#define S2C_ET_CORE	4
+
+typedef struct s2c_elf32_phdr_s {
+	uint32_t	p_type;
+	uint32_t	p_offset;
+	uint32_t	p_vaddr;
+	uint32_t	p_paddr;
+	uint32_t	p_filesz;
+	uint32_t	p_memsz;
+	uint32_t	p_flags;
+	uint32_t	p_align;
+} s2c_elf32_phdr_t;
+
+typedef struct s2c_elf64_phdr_s {
+	uint32_t	p_type;
+	uint32_t	p_flags;
+	uint64_t	p_offset;
+	uint64_t	p_vaddr;
+	uint64_t	p_paddr;
+	uint64_t	p_filesz;
+	uint64_t	p_memsz;
+	uint64_t	p_align;
+} s2c_elf64_phdr_t;
+
+#define S2C_PT_NOTE	4
+#define S2C_PT_LOAD	1
+#define S2C_PF_R		0x4
+
+uint8_t	*nhdr;
+uint8_t	*phdr;
+
+void
+elfhdr_32 (void)
+{
+	s2c_elf32_hdr_t	*elf;
+	s2c_elf32_phdr_t	*nhdrp;
+	s2c_elf32_phdr_t	*phdrp;
+
+	elf = (s2c_elf32_hdr_t *)(core_buf + core_buf_size);
+	core_buf_size += sizeof (s2c_elf32_hdr_t);
+	memset(elf, 0, sizeof(*elf));
+	memcpy(elf->e_ident, S2C_ELFMAG, S2C_SELFMAG);
+	elf->e_ident[S2C_EI_CLASS] = elf_class;
+	elf->e_ident[S2C_EI_DATA] = elf_data;
+	elf->e_ident[S2C_EI_VERSION] = S2C_EV_CURRENT;
+	elf->e_ident[S2C_EI_OSABI] = elf_osabi;
+	elf->e_type = SWAP16 (S2C_ET_CORE);
+	elf->e_machine = SWAP16 (elf_arch);
+	elf->e_version = SWAP32 (S2C_EV_CURRENT);
+	elf->e_phoff = SWAP32 (sizeof (s2c_elf32_hdr_t));
+	elf->e_flags = 0;
+	elf->e_ehsize = SWAP16 (sizeof (s2c_elf32_hdr_t));
+	elf->e_phentsize = SWAP16 (sizeof (s2c_elf32_phdr_t));
+	/* segs including notes section (vma + 1) */
+	elf->e_phnum = SWAP16 (1 + 1);
+
+	nhdr = core_buf + core_buf_size;
+	core_buf_size += sizeof (s2c_elf32_phdr_t);
+	nhdrp = (s2c_elf32_phdr_t *) nhdr;
+	nhdrp->p_type = SWAP32 (S2C_PT_NOTE);
+	nhdrp->p_offset = sizeof(s2c_elf32_hdr_t) + sizeof(s2c_elf32_phdr_t) * 2;
+	nhdrp->p_vaddr = 0;
+	nhdrp->p_paddr = 0;
+	nhdrp->p_filesz = 0;
+	nhdrp->p_memsz = 0;
+	nhdrp->p_flags = 0;
+	nhdrp->p_align = 0;
+
+	phdr = core_buf + core_buf_size;
+	core_buf_size += sizeof (s2c_elf32_phdr_t);
+	phdrp = (s2c_elf32_phdr_t *) phdr;
+	phdrp->p_type = SWAP32 (S2C_PT_LOAD);
+	phdrp->p_flags = SWAP32 (S2C_PF_R);
+	phdrp->p_offset = nhdrp->p_offset;
+	phdrp->p_vaddr = sp_32 & ~63;
+	phdrp->p_paddr = 0;
+	phdrp->p_filesz = phdrp->p_memsz = stack_len + (sp_32 - phdrp->p_vaddr);
+	phdrp->p_align = SWAP32 (1);
+}
+
+void
+elfhdr_64 (void)
+{
+	s2c_elf64_hdr_t	*elf;
+	s2c_elf64_phdr_t	*nhdrp;
+	s2c_elf64_phdr_t	*phdrp;
+
+	elf = (s2c_elf64_hdr_t *)(core_buf + core_buf_size);
+	core_buf_size += sizeof (s2c_elf64_hdr_t);
+	memset(elf, 0, sizeof(*elf));
+	memcpy(elf->e_ident, S2C_ELFMAG, S2C_SELFMAG);
+	elf->e_ident[S2C_EI_CLASS] = elf_class;
+	elf->e_ident[S2C_EI_DATA] = elf_data;
+	elf->e_ident[S2C_EI_VERSION] = S2C_EV_CURRENT;
+	elf->e_ident[S2C_EI_OSABI] = elf_osabi;
+	elf->e_type = SWAP16 (S2C_ET_CORE);
+	elf->e_machine = SWAP16 (elf_arch);
+	elf->e_version = SWAP32 (S2C_EV_CURRENT);
+	elf->e_phoff = SWAP64 (sizeof (s2c_elf64_hdr_t));
+	elf->e_flags = 0;
+	elf->e_ehsize = SWAP16 (sizeof (s2c_elf64_hdr_t));
+	elf->e_phentsize = SWAP16 (sizeof (s2c_elf64_phdr_t));
+	/* segs including notes section (vma + 1) */
+	elf->e_phnum = SWAP16 (1 + 1);
+
+	nhdr = core_buf + core_buf_size;
+	core_buf_size += sizeof (s2c_elf64_phdr_t);
+	nhdrp = (s2c_elf64_phdr_t *) nhdr;
+	nhdrp->p_type = SWAP32 (S2C_PT_NOTE);
+	nhdrp->p_offset = sizeof(s2c_elf64_hdr_t) + sizeof(s2c_elf64_phdr_t) * 2;
+	nhdrp->p_vaddr = 0;
+	nhdrp->p_paddr = 0;
+	nhdrp->p_filesz = 0;
+	nhdrp->p_memsz = 0;
+	nhdrp->p_flags = 0;
+	nhdrp->p_align = 0;
+
+	phdr = core_buf + core_buf_size;
+	core_buf_size += sizeof (s2c_elf64_phdr_t);
+	phdrp = (s2c_elf64_phdr_t *) phdr;
+	phdrp->p_type = SWAP32 (S2C_PT_LOAD);
+	phdrp->p_flags = SWAP32 (S2C_PF_R);
+	phdrp->p_offset = nhdrp->p_offset;
+	phdrp->p_vaddr = sp_64 & ~63;
+	phdrp->p_paddr = 0;
+	phdrp->p_filesz = phdrp->p_memsz = stack_len + (sp_64 - phdrp->p_vaddr);
+	phdrp->p_align = 1;
+}
+
+typedef struct elf_note_s {
+	uint32_t	n_namesz;
+	uint32_t	n_descsz;
+	uint32_t	n_type;
+} elf_note_t;
+
+#define roundup(x, y) ((((x) + ((y) - 1)) / (y)) * (y))
+
+int
+fill_elf_note (uint8_t *p, const char *name,
+		int type, void **data, int data_len)
+{
+	int		ret = 0;
+	elf_note_t	*en = (elf_note_t *) p;
+
+	p += sizeof(elf_note_t);
+	ret += sizeof(elf_note_t);
+	en->n_namesz = strlen(name) + 1;
+	en->n_type = SWAP32 (type);
+	en->n_descsz = SWAP32 (data_len);
+
+	memcpy (p, name, en->n_namesz);
+	p += en->n_namesz;
+	p = (uint8_t *) roundup((unsigned long) p, 4);
+	ret += roundup((en->n_namesz), 4);
+
+	*data = p;
+	p += data_len;
+	p = (uint8_t *) roundup((unsigned long) p, 4);
+	ret += roundup(data_len, 4);
+
+	en->n_namesz = SWAP32 (en->n_namesz);
+
+	return ret;
+}
+
+#define S2C_NT_PRSTATUS	1
+
+struct s2c_elf_siginfo
+{
+	uint32_t	si_signo;
+	uint32_t	si_code;
+	uint32_t	si_errno;
+};
+
+struct s2c_timeval_32 {
+	uint32_t	tv_sec;
+	uint32_t	tv_usec;
+};
+
+struct s2c_timeval_64 {
+	uint64_t	tv_sec;
+	uint64_t	tv_usec;
+};
+
+/* i386 */
+
+struct i386_elf_prstatus
+{
+	struct s2c_elf_siginfo	pr_info;
+	uint16_t		pr_cursig;
+	uint32_t		pr_sigpend;
+	uint32_t		pr_sighold;
+	uint32_t		pr_pid;
+	uint32_t		pr_ppid;
+	uint32_t		pr_pgrp;
+	uint32_t		pr_sid;
+	struct s2c_timeval_32	pr_utime;
+	struct s2c_timeval_32	pr_stime;
+	struct s2c_timeval_32	pr_cutime;
+	struct s2c_timeval_32	pr_cstime;
+
+	uint32_t		pr_reg[17];
+
+	uint32_t		pr_fpvalid;
+} __attribute__ ((aligned(4)));
+
+void
+i386_elf_prstatus (void)
+{
+	int				offset;
+	struct i386_elf_prstatus	*pstat;
+
+	offset = fill_elf_note (core_buf + core_buf_size, "CORE",
+				S2C_NT_PRSTATUS,
+				((void **)&pstat),
+				sizeof(struct i386_elf_prstatus));
+	core_buf_size += offset;
+	((s2c_elf32_phdr_t *) nhdr)->p_filesz += offset;
+	memset (pstat, 0, sizeof(struct i386_elf_prstatus));
+	pstat->pr_reg[0] = SWAP32 (i386_bx);
+	pstat->pr_reg[1] = SWAP32 (i386_cx);
+	pstat->pr_reg[2] = SWAP32 (i386_dx);
+	pstat->pr_reg[3] = SWAP32 (i386_si);
+	pstat->pr_reg[4] = SWAP32 (i386_di);
+	pstat->pr_reg[5] = SWAP32 (i386_bp);
+	pstat->pr_reg[6] = SWAP32 (i386_ax);
+	pstat->pr_reg[7] = SWAP32 (i386_ds);
+	pstat->pr_reg[8] = SWAP32 (i386_es);
+	pstat->pr_reg[9] = SWAP32 (i386_fs);
+	pstat->pr_reg[10] = SWAP32 (i386_gs);
+	pstat->pr_reg[11] = SWAP32 (i386_orig_ax);
+	pstat->pr_reg[12] = SWAP32 (i386_ip);
+	pstat->pr_reg[13] = SWAP32 (i386_cs);
+	pstat->pr_reg[14] = SWAP32 (i386_flags);
+	pstat->pr_reg[15] = SWAP32 (i386_sp);
+	pstat->pr_reg[16] = SWAP32 (i386_ss);
+}
+
+/* x86_64 */
+
+struct x86_64_elf_prstatus
+{
+	struct s2c_elf_siginfo	pr_info;
+	uint16_t		pr_cursig;
+	uint64_t		pr_sigpend;
+	uint64_t		pr_sighold;
+	uint32_t		pr_pid;
+	uint32_t		pr_ppid;
+	uint32_t		pr_pgrp;
+	uint32_t		pr_sid;
+	struct s2c_timeval_64	pr_utime;
+	struct s2c_timeval_64	pr_stime;
+	struct s2c_timeval_64	pr_cutime;
+	struct s2c_timeval_64	pr_cstime;
+
+	uint64_t		pr_reg[27];
+
+	uint32_t		pr_fpvalid;
+} __attribute__ ((aligned(8)));
+
+void
+x86_64_elf_prstatus (void)
+{
+	int				offset;
+	struct x86_64_elf_prstatus	*pstat;
+
+	offset = fill_elf_note (core_buf + core_buf_size, "CORE",
+				S2C_NT_PRSTATUS,
+				((void **)&pstat),
+				sizeof(struct x86_64_elf_prstatus));
+	core_buf_size += offset;
+	((s2c_elf64_phdr_t *) nhdr)->p_filesz += offset;
+	memset (pstat, 0, sizeof(struct x86_64_elf_prstatus));
+	pstat->pr_reg[0] = SWAP64 (x86_64_r15);
+	pstat->pr_reg[1] = SWAP64 (x86_64_r14);
+	pstat->pr_reg[2] = SWAP64 (x86_64_r13);
+	pstat->pr_reg[3] = SWAP64 (x86_64_r12);
+	pstat->pr_reg[4] = SWAP64 (x86_64_bp);
+	pstat->pr_reg[5] = SWAP64 (x86_64_bx);
+	pstat->pr_reg[6] = SWAP64 (x86_64_r11);
+	pstat->pr_reg[7] = SWAP64 (x86_64_r10);
+	pstat->pr_reg[8] = SWAP64 (x86_64_r9);
+	pstat->pr_reg[9] = SWAP64 (x86_64_r8);
+	pstat->pr_reg[10] = SWAP64 (x86_64_ax);
+	pstat->pr_reg[11] = SWAP64 (x86_64_cx);
+	pstat->pr_reg[12] = SWAP64 (x86_64_dx);
+	pstat->pr_reg[13] = SWAP64 (x86_64_si);
+	pstat->pr_reg[14] = SWAP64 (x86_64_di);
+	pstat->pr_reg[15] = SWAP64 (x86_64_orig_ax);
+	pstat->pr_reg[16] = SWAP64 (x86_64_ip);
+	pstat->pr_reg[17] = SWAP64 (x86_64_cs);
+	pstat->pr_reg[18] = SWAP64 (x86_64_flags);
+	pstat->pr_reg[19] = SWAP64 (x86_64_sp);
+ 	pstat->pr_reg[20] = SWAP64 (x86_64_ss);
+}
+
+/* arm */
+
+struct arm_elf_prstatus
+{
+	struct s2c_elf_siginfo	pr_info;
+	uint16_t		pr_cursig;
+	uint32_t		pr_sigpend;
+	uint32_t		pr_sighold;
+	uint32_t		pr_pid;
+	uint32_t		pr_ppid;
+	uint32_t		pr_pgrp;
+	uint32_t		pr_sid;
+	struct s2c_timeval_32	pr_utime;
+	struct s2c_timeval_32	pr_stime;
+	struct s2c_timeval_32	pr_cutime;
+	struct s2c_timeval_32	pr_cstime;
+
+	uint32_t		pr_reg[18];
+
+	uint32_t		pr_fpvalid;
+} __attribute__ ((aligned(4)));
+
+void
+arm_elf_prstatus (void)
+{
+	int				offset;
+	struct arm_elf_prstatus		*pstat;
+
+	offset = fill_elf_note (core_buf + core_buf_size, "CORE",
+				S2C_NT_PRSTATUS,
+				((void **)&pstat),
+				sizeof(struct arm_elf_prstatus));
+	core_buf_size += offset;
+	((s2c_elf32_phdr_t *) nhdr)->p_filesz += offset;
+	memset (pstat, 0, sizeof(struct arm_elf_prstatus));
+	pstat->pr_reg[0] = SWAP32 (arm_r0);
+	pstat->pr_reg[1] = SWAP32 (arm_r1);
+	pstat->pr_reg[2] = SWAP32 (arm_r2);
+	pstat->pr_reg[3] = SWAP32 (arm_r3);
+	pstat->pr_reg[4] = SWAP32 (arm_r4);
+	pstat->pr_reg[5] = SWAP32 (arm_r5);
+	pstat->pr_reg[6] = SWAP32 (arm_r6);
+	pstat->pr_reg[7] = SWAP32 (arm_r7);
+	pstat->pr_reg[8] = SWAP32 (arm_r8);
+	pstat->pr_reg[9] = SWAP32 (arm_r9);
+	pstat->pr_reg[10] = SWAP32 (arm_r10);
+	pstat->pr_reg[11] = SWAP32 (arm_fp);
+	pstat->pr_reg[12] = SWAP32 (arm_ip);
+	pstat->pr_reg[13] = SWAP32 (arm_sp);
+	pstat->pr_reg[14] = SWAP32 (arm_lr);
+	pstat->pr_reg[15] = SWAP32 (arm_pc);
+	pstat->pr_reg[16] = SWAP32 (arm_cpsr);
+	pstat->pr_reg[17] = SWAP32 (arm_ORIG_r0);
+}
+
+/* mips */
+
+struct mips32_elf_prstatus
+{
+	struct s2c_elf_siginfo	pr_info;
+	uint16_t		pr_cursig;
+	uint32_t		pr_sigpend;
+	uint32_t		pr_sighold;
+	uint32_t		pr_pid;
+	uint32_t		pr_ppid;
+	uint32_t		pr_pgrp;
+	uint32_t		pr_sid;
+	struct s2c_timeval_32	pr_utime;
+	struct s2c_timeval_32	pr_stime;
+	struct s2c_timeval_32	pr_cutime;
+	struct s2c_timeval_32	pr_cstime;
+
+	uint32_t		pr_reg[45];
+
+	uint32_t		pr_fpvalid;
+} __attribute__ ((aligned(4)));
+
+struct mips64_elf_prstatus
+{
+	struct s2c_elf_siginfo	pr_info;
+	uint16_t		pr_cursig;
+	uint64_t		pr_sigpend;
+	uint64_t		pr_sighold;
+	uint32_t		pr_pid;
+	uint32_t		pr_ppid;
+	uint32_t		pr_pgrp;
+	uint32_t		pr_sid;
+	struct s2c_timeval_64	pr_utime;
+	struct s2c_timeval_64	pr_stime;
+	struct s2c_timeval_64	pr_cutime;
+	struct s2c_timeval_64	pr_cstime;
+
+	uint64_t		pr_reg[45];
+
+	uint32_t		pr_fpvalid;
+} __attribute__ ((aligned(8)));
+
+#define MIPS32_EF_R0		6
+#define MIPS32_EF_LO		38
+#define MIPS32_EF_HI		39
+#define MIPS32_EF_CP0_EPC	40
+#define MIPS32_EF_CP0_BADVADDR	41
+#define MIPS32_EF_CP0_STATUS	42
+#define MIPS32_EF_CP0_CAUSE	43
+
+#define MIPS64_EF_R0		0
+#define MIPS64_EF_LO		32
+#define MIPS64_EF_HI		33
+#define MIPS64_EF_CP0_EPC	34
+#define MIPS64_EF_CP0_BADVADDR	35
+#define MIPS64_EF_CP0_STATUS	36
+#define MIPS64_EF_CP0_CAUSE	37
+
+void
+mips_elf_prstatus (void)
+{
+	int	offset;
+
+	if (elf_class == S2C_ELFCLASS32) {
+		struct mips32_elf_prstatus	*pstat;
+
+		offset = fill_elf_note (core_buf + core_buf_size, "CORE",
+					S2C_NT_PRSTATUS,
+					((void **)&pstat),
+					sizeof(struct mips32_elf_prstatus));
+		core_buf_size += offset;
+		((s2c_elf32_phdr_t *) nhdr)->p_filesz += offset;
+		memset (pstat, 0, sizeof(struct mips32_elf_prstatus));
+
+		for (offset = 0; offset < 32; offset ++)
+			pstat->pr_reg[MIPS32_EF_R0 + offset] = SWAP32 (mips32_r[offset]);
+		pstat->pr_reg[MIPS32_EF_LO] = SWAP32 (mips32_lo);
+		pstat->pr_reg[MIPS32_EF_HI] = SWAP32 (mips32_hi);
+		pstat->pr_reg[MIPS32_EF_CP0_EPC] = SWAP32 (mips32_cp0_epc);
+		pstat->pr_reg[MIPS32_EF_CP0_BADVADDR] = SWAP32 (mips32_cp0_badvaddr);
+		pstat->pr_reg[MIPS32_EF_CP0_STATUS] = SWAP32 (mips32_cp0_status);
+		pstat->pr_reg[MIPS32_EF_CP0_CAUSE] = SWAP32 (mips32_cp0_cause);
+
+	}
+	else {
+		struct mips64_elf_prstatus	*pstat;
+
+		offset = fill_elf_note (core_buf + core_buf_size, "CORE",
+					S2C_NT_PRSTATUS,
+					((void **)&pstat),
+					sizeof(struct mips64_elf_prstatus));
+		core_buf_size += offset;
+		((s2c_elf64_phdr_t *) nhdr)->p_filesz += offset;
+		memset (pstat, 0, sizeof(struct mips64_elf_prstatus));
+
+		for (offset = 0; offset < 32; offset ++)
+			pstat->pr_reg[MIPS64_EF_R0 + offset] = SWAP64 (mips64_r[offset]);
+		pstat->pr_reg[MIPS64_EF_LO] = SWAP64 (mips64_lo);
+		pstat->pr_reg[MIPS64_EF_HI] = SWAP64 (mips64_hi);
+		pstat->pr_reg[MIPS64_EF_CP0_EPC] = SWAP64 (mips64_cp0_epc);
+		pstat->pr_reg[MIPS64_EF_CP0_BADVADDR] = SWAP64 (mips64_cp0_badvaddr);
+		pstat->pr_reg[MIPS64_EF_CP0_STATUS] = SWAP64 (mips64_cp0_status);
+		pstat->pr_reg[MIPS64_EF_CP0_CAUSE] = SWAP64 (mips64_cp0_cause);
+	}
+}
+
+struct s2c_elf_prpsinfo_32
+{
+	uint8_t		pr_state;
+	uint8_t		pr_sname;
+	uint8_t		pr_zomb;
+	uint8_t		pr_nice;
+	uint32_t	pr_flag;
+	uint16_t	pr_uid;
+	uint16_t	pr_gid;
+	uint32_t	pr_pid, pr_ppid, pr_pgrp, pr_sid;
+	uint8_t		pr_fname[16];
+	uint8_t		pr_psargs[S2C_ELF_PRARGSZ];
+};
+
+struct s2c_elf_prpsinfo_64
+{
+	uint8_t		pr_state;
+	uint8_t		pr_sname;
+	uint8_t		pr_zomb;
+	uint8_t		pr_nice;
+	uint64_t	pr_flag;
+	uint32_t	pr_uid;
+	uint32_t	pr_gid;
+	uint32_t	pr_pid, pr_ppid, pr_pgrp, pr_sid;
+	uint8_t		pr_fname[16];
+	uint8_t		pr_psargs[S2C_ELF_PRARGSZ];
+};
+
+#define S2C_NT_PRPSINFO	3
+
+void
+save_pinfo_32 (void)
+{
+	int				offset;
+	struct s2c_elf_prpsinfo_32	*pinfo;
+
+	offset = fill_elf_note (core_buf + core_buf_size, "CORE",
+				S2C_NT_PRPSINFO,
+				((void **)&pinfo),
+				sizeof(struct s2c_elf_prpsinfo_32));
+	core_buf_size += offset;
+	memset (pinfo, 0, sizeof(struct s2c_elf_prpsinfo_32));
+	pinfo->pr_state = 0;
+	pinfo->pr_sname = 'R';
+	pinfo->pr_zomb = 0;
+	strcpy((char *)pinfo->pr_fname, "vmlinux");
+	snprintf((char *)pinfo->pr_psargs, S2C_ELF_PRARGSZ, "%s", commandline);
+	((s2c_elf32_phdr_t *) nhdr)->p_filesz += offset;
+}
+
+void
+save_pinfo_64 (void)
+{
+	int				offset;
+	struct s2c_elf_prpsinfo_64	*pinfo;
+
+	offset = fill_elf_note (core_buf + core_buf_size, "CORE",
+				S2C_NT_PRPSINFO,
+				((void **)&pinfo),
+				sizeof(struct s2c_elf_prpsinfo_64));
+	core_buf_size += offset;
+	memset (pinfo, 0, sizeof(struct s2c_elf_prpsinfo_64));
+	pinfo->pr_state = 0;
+	pinfo->pr_sname = 'R';
+	pinfo->pr_zomb = 0;
+	strcpy((char *)pinfo->pr_fname, "vmlinux");
+	snprintf((char *)pinfo->pr_psargs, S2C_ELF_PRARGSZ, "%s", commandline);
+	((s2c_elf64_phdr_t *) nhdr)->p_filesz += offset;
+}
+
+void
+stack_32 (void)
+{
+	((s2c_elf32_phdr_t *) phdr)->p_offset += ((s2c_elf32_phdr_t *)
nhdr)->p_filesz;
+	memset (core_buf + core_buf_size, 0, (sp_32 - ((s2c_elf32_phdr_t *)
phdr)->p_vaddr));
+	core_buf_size += sp_32 - ((s2c_elf32_phdr_t *) phdr)->p_vaddr;
+	memcpy (core_buf + core_buf_size, stack, stack_len);
+	core_buf_size += stack_len;
+
+	if (NEEDSWAP) {
+		((s2c_elf32_phdr_t *) nhdr)->p_offset = bswap_32(((s2c_elf32_phdr_t
*) nhdr)->p_offset);
+		((s2c_elf32_phdr_t *) nhdr)->p_filesz = bswap_32(((s2c_elf32_phdr_t
*) nhdr)->p_filesz);
+		((s2c_elf32_phdr_t *) phdr)->p_offset = bswap_32(((s2c_elf32_phdr_t
*) phdr)->p_offset);
+		((s2c_elf32_phdr_t *) phdr)->p_vaddr = bswap_32(((s2c_elf32_phdr_t
*) phdr)->p_vaddr);
+		((s2c_elf32_phdr_t *) phdr)->p_filesz = bswap_32(((s2c_elf32_phdr_t
*) phdr)->p_filesz);
+		((s2c_elf32_phdr_t *) phdr)->p_memsz = bswap_32(((s2c_elf32_phdr_t
*) phdr)->p_memsz);
+	}
+}
+
+void
+stack_64 (void)
+{
+	((s2c_elf64_phdr_t *) phdr)->p_offset += ((s2c_elf64_phdr_t *)
nhdr)->p_filesz;
+	memset (core_buf + core_buf_size, 0, (sp_64 - ((s2c_elf64_phdr_t *)
phdr)->p_vaddr));
+	core_buf_size += sp_64 - ((s2c_elf64_phdr_t *) phdr)->p_vaddr;
+	memcpy (core_buf + core_buf_size, stack, stack_len);
+	core_buf_size += stack_len;
+
+	if (NEEDSWAP) {
+		((s2c_elf64_phdr_t *) nhdr)->p_offset = bswap_64(((s2c_elf64_phdr_t
*) nhdr)->p_offset);
+		((s2c_elf64_phdr_t *) nhdr)->p_filesz = bswap_64(((s2c_elf64_phdr_t
*) nhdr)->p_filesz);
+		((s2c_elf64_phdr_t *) phdr)->p_offset = bswap_64(((s2c_elf64_phdr_t
*) phdr)->p_offset);
+		((s2c_elf64_phdr_t *) phdr)->p_vaddr = bswap_64(((s2c_elf64_phdr_t
*) phdr)->p_vaddr);
+		((s2c_elf64_phdr_t *) phdr)->p_filesz = bswap_64(((s2c_elf64_phdr_t
*) phdr)->p_filesz);
+		((s2c_elf64_phdr_t *) phdr)->p_memsz = bswap_64(((s2c_elf64_phdr_t
*) phdr)->p_memsz);
+	}
+}
+
+int
+main(int argc,char *argv[],char *envp[])
+{
+	/* Parse and save the input.  */
+	iterate_over_lines (stdin);
+	/* Set sp.  */
+	switch (elf_arch) {
+		case S2C_EM_386:
+			sp_32 = i386_sp;
+			break;
+		case S2C_EM_X86_64:
+			sp_64 = x86_64_sp;
+			break;
+		case S2C_EM_ARM:
+			sp_32 = arm_sp;
+			break;
+		case S2C_EM_MIPS:
+			if (elf_class == S2C_ELFCLASS32)
+				sp_32 = mips32_r[29];
+			else
+				sp_64 = mips64_r[29];
+			break;
+	}
+
+	/* Convert and save to core_buf.  */
+	/* Elf header */
+	if (elf_class == S2C_ELFCLASS32)
+		elfhdr_32 ();
+	else
+		elfhdr_64 ();
+	/* note0 pstat */
+	switch (elf_arch) {
+		case S2C_EM_386:
+			i386_elf_prstatus ();
+			break;
+		case S2C_EM_X86_64:
+			x86_64_elf_prstatus ();
+			break;
+		case S2C_EM_ARM:
+			arm_elf_prstatus ();
+			break;
+		case S2C_EM_MIPS:
+			mips_elf_prstatus ();
+			break;
+	}
+	/* note1 pinfo */
+	if (elf_class == S2C_ELFCLASS32)
+		save_pinfo_32 ();
+	else
+		save_pinfo_64 ();
+
+	/* stack */
+	if (elf_class == S2C_ELFCLASS32)
+		stack_32 ();
+	else
+		stack_64 ();
+
+	if (write (STDOUT_FILENO, core_buf, core_buf_size) != core_buf_size) {
+		fprintf(stderr, "Output core error.\n");
+		exit (-1);
+	}
+
+	return 0;
+}
