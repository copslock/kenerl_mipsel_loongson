Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2007 17:58:58 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:11433 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28576486AbXJaR6z (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 Oct 2007 17:58:55 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9VHwaEl030048;
	Wed, 31 Oct 2007 17:58:36 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9VHwZ3g030047;
	Wed, 31 Oct 2007 17:58:35 GMT
Date:	Wed, 31 Oct 2007 17:58:35 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Hyon Lim <alex@alexlab.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: implementation of software suspend on MIPS.
Message-ID: <20071031175835.GA23557@linux-mips.org>
References: <dd7dc2bc0710301212s7b364392n39a149764a4117cf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd7dc2bc0710301212s7b364392n39a149764a4117cf@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 31, 2007 at 04:12:36AM +0900, Hyon Lim wrote:

> Hello.  I need a help for my implementation work on MIPS software suspend.
> From 3month ago, I've been coding software suspend(swsusp) on MIPS arch.
> I'm developing with MIPS32 4KEc embedded processor for digital appliance.
> 
> Swsusp has two procedure. the one is suspending procedure and other one is
> resume procedure.
> Yesterday, I confirmed suspending procedure working.
> This is a porting guide of swsusp (
> http://tree.celinuxforum.org/CelfPubWiki/SwSuspendPortingNotes)
> I refered this article.

The article is a bit dated and lacking alot of details.

> The problem I faced is assembly language for MIPS.
> Of course, there are many manuals for this work but, I need a help from MIPS
> expert.
> 
> This pseudo code should be implemented by MIPS asm.
> 
>         for (j = nr_copy_pages; j>0; j--) {
>             src = pagedir_nosave[j].src;
>             dst = pagedir_nosave[j].dst;
>             for (i=0;i<1024;i++) {
>                 *dst++ = *src++;
>             }
>         }
> 
> nr_copy_pages is unsigned long variable.

The page is refering to some old code which no longer seems to exist in
this form.  The array pagedir_nosave has now become a chained list.  I
attach a patch for illustration purposes.  It illustrates how things work
on recent kernels; I didn't have a 2.6.10 kernel at hand.

If you have further questions on MIPS assembler then I suggest you get a
copy of Dominik Sweetman's excellent "See MIPS Run Linux" book.

> and pagedir_nosave is a
> suspend_pagedir_t<http://lxr.linux.no/source/kernel/power/ident?v=2.6.10;i=suspend_pagedir_t>type
> structure array(pointer). (you can refer following url. Line 101. :
> http://lxr.linux.no/source/kernel/power/swsusp.c?v=2.6.10)
> code skeleton or useful material will be welcomed. (whatever you have.)
> 
> The second problem is
> " which register should be prevented? "
> 
> I saved $v0-v1. $a0-$a3. $t0-t7. $s0-s7. $t8-t9. $gp,sp,fp,ra.

That sounds about right but I'd need to dive deeper into swsusp to give
you a definitive answer.

Cheers,

  Ralf

[MIPS] Skeleton swsusp implementation.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 3196509..38adf9e 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -75,6 +75,8 @@ obj-$(CONFIG_PCSPEAKER)		+= pcspeaker.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
+obj-$(CONFIG_HIBERNATION)	+= swsusp.o suspend.o
+
 CFLAGS_cpu-bugs64.o	= $(shell if $(CC) $(KBUILD_CFLAGS) -Wa,-mdaddi -c -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-DHAVE_AS_SET_DADDI"; fi)
 
 obj-$(CONFIG_HAVE_STD_PC_SERIAL_PORT)	+= 8250-platform.o
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index ca13629..f3038dc 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
+#include <linux/suspend.h>
 
 #include <asm/ptrace.h>
 #include <asm/processor.h>
@@ -337,3 +338,13 @@ void output_irq_cpustat_t_defines(void)
 	size("#define IC_IRQ_CPUSTAT_T   ", irq_cpustat_t);
 	linefeed;
 }
+
+void output_pbe_defines(void)
+{
+	text("/* Linux struct pbe offsets. */");
+	offset("#define PBE_ADDRESS        ", struct pbe, address);
+	offset("#define PBE_ORIG_ADDRESS   ", struct pbe, orig_address);
+	offset("#define PBE_NEXT           ", struct pbe, next);
+	size("#define PBE_SIZE           ", struct pbe);
+	linefeed;
+}
diff --git a/arch/mips/kernel/suspend.S b/arch/mips/kernel/suspend.S
new file mode 100644
index 0000000..32b3ec0
--- /dev/null
+++ b/arch/mips/kernel/suspend.S
@@ -0,0 +1,20 @@
+#include <asm/asm-offsets.h>
+#include <asm/regdef.h>
+#include <asm/asm.h>
+
+LEAF(swsusp_arch_suspend)
+	END(swsusp_arch_suspend)
+
+LEAF(swsusp_arch_resume)
+	PTR_LA		t0, restore_pblist
+0:	PTR_L		t1, PBE_ADDRESS(t1)
+	PTR_L		t2, PBE_ORIG_ADDRESS(t1)
+	PTR_ADDIU	t3, t1, _PAGE_SIZE
+1:	REG_L		t4, (t1)
+	REG_S		t4, (t1)
+	PTR_ADDIU	t1, t1, SZREG
+	PTR_ADDIU	t2, t2, SZREG
+	bne		t1, t3, 1b
+	PTR_L		t1, PBE_NEXT(t1)
+	bnez		t1, 0
+	END(swsusp_arch_resume)
diff --git a/arch/mips/kernel/swsusp.c b/arch/mips/kernel/swsusp.c
new file mode 100644
index 0000000..864dd49
--- /dev/null
+++ b/arch/mips/kernel/swsusp.c
@@ -0,0 +1,30 @@
+/*
+ * Suspend support specific for power.
+ *
+ * Distribute under GPLv2
+ *
+ * Copyright (c) 2002 Pavel Machek <pavel@suse.cz>
+ * Copyright (c) 2001 Patrick Mochel <mochel@osdl.org>
+ */
+
+#include <asm/page.h>
+
+/* References to section boundaries */
+extern const void __nosave_begin, __nosave_end;
+
+void save_processor_state(void)
+{
+	/* ... */
+}
+
+void restore_processor_state(void)
+{
+	/* ... */
+}
+
+int pfn_is_nosave(unsigned long pfn)
+{
+	unsigned long nosave_begin_pfn = __pa(&__nosave_begin) >> PAGE_SHIFT;
+	unsigned long nosave_end_pfn = PAGE_ALIGN(__pa(&__nosave_end)) >> PAGE_SHIFT;
+	return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
+}
diff --git a/include/asm-mips/suspend.h b/include/asm-mips/suspend.h
index 2562f8f..ee5e679 100644
--- a/include/asm-mips/suspend.h
+++ b/include/asm-mips/suspend.h
@@ -1,6 +1,9 @@
 #ifndef __ASM_SUSPEND_H
 #define __ASM_SUSPEND_H
 
-/* Somewhen...  Maybe :-)  */
+static inline int arch_prepare_suspend(void)
+{
+	return 0;
+}
 
 #endif /* __ASM_SUSPEND_H */
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 4360e08..854b7a9 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -1,7 +1,7 @@
 #ifndef _LINUX_SUSPEND_H
 #define _LINUX_SUSPEND_H
 
-#if defined(CONFIG_X86) || defined(CONFIG_FRV) || defined(CONFIG_PPC32) || defined(CONFIG_PPC64)
+#if defined(CONFIG_X86) || defined(CONFIG_FRV) || defined(CONFIG_PPC32) || defined(CONFIG_PPC64) || defined(CONFIG_MIPS)
 #include <asm/suspend.h>
 #endif
 #include <linux/swap.h>
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 8e186c6..444f835 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -99,13 +99,13 @@ config SUSPEND
 
 config HIBERNATION_UP_POSSIBLE
 	bool
-	depends on X86 || PPC64_SWSUSP || PPC32
+	depends on MIPS || X86 || PPC64_SWSUSP || PPC32
 	depends on !SMP
 	default y
 
 config HIBERNATION_SMP_POSSIBLE
 	bool
-	depends on (X86 && !X86_VOYAGER) || PPC64_SWSUSP
+	depends on MIPS || (X86 && !X86_VOYAGER) || PPC64_SWSUSP
 	depends on SMP
 	default y
 
