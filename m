Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jan 2013 19:06:09 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:44299 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823008Ab3AGSFsHnyGq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Jan 2013 19:05:48 +0100
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id r07I5e0B030379;
        Mon, 7 Jan 2013 10:05:40 -0800
X-WSS-ID: 0MG9OXG-01-2WF-02
X-M-MSG: 
Received: from exchdb01.mips.com (unknown [192.168.36.84])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mailgate1.mips.com (Postfix) with ESMTP id 23DCC36464E;
        Mon,  7 Jan 2013 10:05:40 -0800 (PST)
Received: from fun-lab.mips.com (192.168.52.61) by exchhub01.mips.com
 (192.168.36.84) with Microsoft SMTP Server id 14.2.247.3; Mon, 7 Jan 2013
 10:05:36 -0800
From:   Deng-Cheng Zhu <dczhu@mips.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <kevink@paralogos.com>, <macro@linux-mips.org>, <john@phrozen.org>
CC:     <sjhill@mips.com>, <dczhu@mips.com>
Subject: [RESEND PATCH v3 1/5] MIPS: APRP (APSP): fix/enrich functionality
Date:   Mon, 7 Jan 2013 10:05:10 -0800
Message-ID: <1357581914-4589-2-git-send-email-dczhu@mips.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1357581914-4589-1-git-send-email-dczhu@mips.com>
References: <1357581914-4589-1-git-send-email-dczhu@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EMS-Proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
X-EMS-STAMP: hFvekXq9FRgFo1yTJguSrw==
X-archive-position: 35385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dczhu@mips.com
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

This patch makes 34K and CPS like multicore 1004K APRP (also known as APSP)
work. Also, it allows the RP side to run floating point heavy jobs and uses
interrupt to wake up RP side read. These functionalities need proper RP
code to work correctly.

To run programs in APRP (APSP) mode on CPS, for example, a 3 core 1004K
CPU, one can run SMVP Linux on the first 2 cores and leave a VPE of the 3rd
core to run RTOS or signal processing program. The kernel command line
option "maxcpus=" needs to be appointed.

To run FP intensive RP/SP side program on a Kf CPU, currently we simply
disable the FPU on the AP side. And RP will init it and use it exclusively.

Cc: Steven J. Hill <sjhill@mips.com>
Signed-off-by: Deng-Cheng Zhu <dczhu@mips.com>
---
 arch/mips/Kconfig            |    9 ++
 arch/mips/include/asm/rtlx.h |    5 +
 arch/mips/kernel/rtlx.c      |  190 +++++++++++++++++++++-----
 arch/mips/kernel/vpe.c       |  302 ++++++++++++++++++++++++++++++------------
 4 files changed, 381 insertions(+), 125 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index dba9390..f4d4888 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2036,6 +2036,15 @@ config MIPS_VPE_LOADER_TOM
 	  you to ensure the amount you put in the option and the space your
 	  program requires is less or equal to the amount physically present.
 
+config MIPS_SP_FP_INTENSIVE
+	bool "SP is used for running FP-intensive jobs"
+	depends on MIPS_VPE_LOADER
+	---help---
+	  If you intend to use the SP to run FP-intensive jobs, you probably
+	  want to say yes here. Your FPU will then be exclusively used by the
+	  SP, and the Linux on the AP side will not see the FPU. Make sure you
+	  know what it does when choosing this option.
+
 # this should possibly be in drivers/char, but it is rather cpu related. Hmmm
 config MIPS_VPE_APSP_API
 	bool "Enable support for AP/SP API (RTLX)"
diff --git a/arch/mips/include/asm/rtlx.h b/arch/mips/include/asm/rtlx.h
index 4ca3063..478349e 100644
--- a/arch/mips/include/asm/rtlx.h
+++ b/arch/mips/include/asm/rtlx.h
@@ -28,6 +28,8 @@ extern ssize_t rtlx_write(int index, const void __user *buffer, size_t count);
 extern unsigned int rtlx_read_poll(int index, int can_sleep);
 extern unsigned int rtlx_write_poll(int index);
 
+extern void (*aprp_hook)(void);
+
 enum rtlx_state {
 	RTLX_STATE_UNUSED = 0,
 	RTLX_STATE_INITIALISED,
@@ -58,6 +60,9 @@ struct rtlx_channel {
 struct rtlx_info {
 	unsigned long id;
 	enum rtlx_state state;
+#ifdef CONFIG_MIPS_CMP
+	int ap_int_pending;
+#endif
 
 	struct rtlx_channel channel[RTLX_CHANNELS];
 };
diff --git a/arch/mips/kernel/rtlx.c b/arch/mips/kernel/rtlx.c
index b8c18dc..eeda8a2 100644
--- a/arch/mips/kernel/rtlx.c
+++ b/arch/mips/kernel/rtlx.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2005 MIPS Technologies, Inc.  All rights reserved.
+ * Copyright (C) 2005, 2012 MIPS Technologies, Inc.  All rights reserved.
  * Copyright (C) 2005, 06 Ralf Baechle (ralf@linux-mips.org)
  *
  *  This program is free software; you can distribute it and/or modify it
@@ -36,6 +36,7 @@
 #include <asm/mips_mt.h>
 #include <asm/cacheflush.h>
 #include <linux/atomic.h>
+#include <asm/smp.h>
 #include <asm/cpu.h>
 #include <asm/processor.h>
 #include <asm/vpe.h>
@@ -54,15 +55,40 @@ static struct chan_waitqueues {
 
 static struct vpe_notifications notify;
 static int sp_stopping;
+static int cpu_idx;
+static void null_aprp_hook(void) {};
+
+void (*aprp_hook)(void) = null_aprp_hook;
 
 extern void *vpe_get_shared(int index);
 
+#ifdef CONFIG_MIPS_CMP
+static void rtlx_interrupt(void)
+{
+	int i;
+	struct rtlx_info *info;
+	struct rtlx_info **p = vpe_get_shared(cpu_idx);
+
+	if (p == NULL || *p == NULL)
+		return;
+
+	info = *p;
+
+	if (info->ap_int_pending == 1 && smp_processor_id() == 0) {
+		for (i = 0; i < RTLX_CHANNELS; i++) {
+			wake_up(&channel_wqs[i].lx_queue);
+			wake_up(&channel_wqs[i].rt_queue);
+		}
+		info->ap_int_pending = 0;
+	}
+}
+#else
 static void rtlx_dispatch(void)
 {
-	do_IRQ(MIPS_CPU_IRQ_BASE + MIPS_CPU_RTLX_IRQ);
+	if (read_c0_cause() & read_c0_status() & C_SW0)
+		do_IRQ(MIPS_CPU_IRQ_BASE + MIPS_CPU_RTLX_IRQ);
 }
 
-
 /* Interrupt handler may be called before rtlx_init has otherwise had
    a chance to run.
 */
@@ -81,12 +107,13 @@ static irqreturn_t rtlx_interrupt(int irq, void *dev_id)
 	local_irq_restore(flags);
 
 	for (i = 0; i < RTLX_CHANNELS; i++) {
-			wake_up(&channel_wqs[i].lx_queue);
-			wake_up(&channel_wqs[i].rt_queue);
+		wake_up(&channel_wqs[i].lx_queue);
+		wake_up(&channel_wqs[i].rt_queue);
 	}
 
 	return IRQ_HANDLED;
 }
+#endif
 
 static void __used dump_rtlx(void)
 {
@@ -115,8 +142,7 @@ static void __used dump_rtlx(void)
 static int rtlx_init(struct rtlx_info *rtlxi)
 {
 	if (rtlxi->id != RTLX_ID) {
-		printk(KERN_ERR "no valid RTLX id at 0x%p 0x%lx\n",
-			rtlxi, rtlxi->id);
+		pr_err("no valid RTLX id at 0x%p 0x%lx\n", rtlxi, rtlxi->id);
 		return -ENOEXEC;
 	}
 
@@ -157,30 +183,30 @@ int rtlx_open(int index, int can_sleep)
 	int ret = 0;
 
 	if (index >= RTLX_CHANNELS) {
-		printk(KERN_DEBUG "rtlx_open index out of range\n");
+		pr_debug("rtlx_open index out of range\n");
 		return -ENOSYS;
 	}
 
 	if (atomic_inc_return(&channel_wqs[index].in_open) > 1) {
-		printk(KERN_DEBUG "rtlx_open channel %d already opened\n",
-		       index);
+		pr_debug("rtlx_open channel %d already opened\n", index);
 		ret = -EBUSY;
 		goto out_fail;
 	}
 
 	if (rtlx == NULL) {
-		if( (p = vpe_get_shared(tclimit)) == NULL) {
-		    if (can_sleep) {
-			__wait_event_interruptible(channel_wqs[index].lx_queue,
-				(p = vpe_get_shared(tclimit)), ret);
-			if (ret)
+		p = vpe_get_shared(cpu_idx);
+		if (p == NULL) {
+			if (can_sleep) {
+				__wait_event_interruptible(
+					channel_wqs[index].lx_queue,
+					(p = vpe_get_shared(cpu_idx)), ret);
+				if (ret)
+					goto out_fail;
+			} else {
+				pr_debug("No SP program loaded, and device opened with O_NONBLOCK\n");
+				ret = -ENOSYS;
 				goto out_fail;
-		    } else {
-			printk(KERN_DEBUG "No SP program loaded, and device "
-					"opened with O_NONBLOCK\n");
-			ret = -ENOSYS;
-			goto out_fail;
-		    }
+			}
 		}
 
 		smp_rmb();
@@ -204,16 +230,14 @@ int rtlx_open(int index, int can_sleep)
 				}
 				finish_wait(&channel_wqs[index].lx_queue, &wait);
 			} else {
-				pr_err(" *vpe_get_shared is NULL. "
-				       "Has an SP program been loaded?\n");
+				pr_err(" *vpe_get_shared is NULL. Has an SP program been loaded?\n");
 				ret = -ENOSYS;
 				goto out_fail;
 			}
 		}
 
 		if ((unsigned int)*p < KSEG0) {
-			printk(KERN_WARNING "vpe_get_shared returned an "
-			       "invalid pointer maybe an error code %d\n",
+			pr_warn("vpe_get_shared returned an invalid pointer maybe an error code %d\n",
 			       (int)*p);
 			ret = -ENOSYS;
 			goto out_fail;
@@ -343,6 +367,25 @@ out:
 	return count;
 }
 
+#ifdef CONFIG_MIPS_CMP
+static void _interrupt_sp(void)
+{
+	smp_send_reschedule(cpu_idx);
+}
+#else
+static void _interrupt_sp(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	dvpe();
+	settc(1);
+	write_vpe_c0_cause(read_vpe_c0_cause() | C_SW0);
+	evpe(EVPE_ENABLE);
+	local_irq_restore(flags);
+}
+#endif
+
 ssize_t rtlx_write(int index, const void __user *buffer, size_t count)
 {
 	struct rtlx_channel *rt;
@@ -383,6 +426,8 @@ out:
 	smp_wmb();
 	mutex_unlock(&channel_wqs[index].mutex);
 
+	_interrupt_sp();
+
 	return count;
 }
 
@@ -470,6 +515,72 @@ static const struct file_operations rtlx_fops = {
 	.llseek =  noop_llseek,
 };
 
+static char register_chrdev_failed[] __initdata =
+	KERN_ERR "rtlx_module_init: unable to register device\n";
+
+#ifdef CONFIG_MIPS_CMP
+static int __init rtlx_module_init(void)
+{
+	struct device *dev;
+	int i, err;
+
+	if (!cpu_has_mipsmt) {
+		pr_warn("VPE loader: not a MIPS MT capable processor\n");
+		return -ENODEV;
+	}
+
+	cpu_idx = setup_max_cpus;
+
+	if (num_possible_cpus() - cpu_idx < 1) {
+		pr_warn("No TCs reserved for AP/SP, not initializing RTLX.\n"
+			"Pass maxcpus=<n> argument as kernel argument\n");
+
+		return -ENODEV;
+	}
+
+	major = register_chrdev(0, module_name, &rtlx_fops);
+	if (major < 0) {
+		printk(register_chrdev_failed);
+		return major;
+	}
+
+	/* initialise the wait queues */
+	for (i = 0; i < RTLX_CHANNELS; i++) {
+		init_waitqueue_head(&channel_wqs[i].rt_queue);
+		init_waitqueue_head(&channel_wqs[i].lx_queue);
+		atomic_set(&channel_wqs[i].in_open, 0);
+		mutex_init(&channel_wqs[i].mutex);
+
+		dev = device_create(mt_class, NULL, MKDEV(major, i), NULL,
+				    "%s%d", module_name, i);
+		if (IS_ERR(dev)) {
+			err = PTR_ERR(dev);
+			goto out_chrdev;
+		}
+	}
+
+	/* set up notifiers */
+	notify.start = starting;
+	notify.stop = stopping;
+	vpe_notify(cpu_idx, &notify);
+
+	if (cpu_has_vint) {
+		aprp_hook = rtlx_interrupt;
+	} else {
+		pr_err("APRP RTLX init on non-vectored-interrupt processor\n");
+		err = -ENODEV;
+		goto out_chrdev;
+	}
+
+	return 0;
+
+out_chrdev:
+	for (i = 0; i < RTLX_CHANNELS; i++)
+		device_destroy(mt_class, MKDEV(major, i));
+
+	return err;
+}
+#else
 static struct irqaction rtlx_irq = {
 	.handler	= rtlx_interrupt,
 	.name		= "RTLX",
@@ -477,23 +588,21 @@ static struct irqaction rtlx_irq = {
 
 static int rtlx_irq_num = MIPS_CPU_IRQ_BASE + MIPS_CPU_RTLX_IRQ;
 
-static char register_chrdev_failed[] __initdata =
-	KERN_ERR "rtlx_module_init: unable to register device\n";
-
 static int __init rtlx_module_init(void)
 {
 	struct device *dev;
 	int i, err;
 
 	if (!cpu_has_mipsmt) {
-		printk("VPE loader: not a MIPS MT capable processor\n");
+		pr_warn("VPE loader: not a MIPS MT capable processor\n");
 		return -ENODEV;
 	}
 
-	if (tclimit == 0) {
-		printk(KERN_WARNING "No TCs reserved for AP/SP, not "
-		       "initializing RTLX.\nPass maxtcs=<n> argument as kernel "
-		       "argument\n");
+	cpu_idx = tclimit;
+
+	if (cpu_idx == 0) {
+		pr_warn("No TCs reserved for AP/SP, not initializing RTLX.\n"
+			"Pass maxtcs=<n> argument as kernel argument\n");
 
 		return -ENODEV;
 	}
@@ -522,11 +631,16 @@ static int __init rtlx_module_init(void)
 	/* set up notifiers */
 	notify.start = starting;
 	notify.stop = stopping;
-	vpe_notify(tclimit, &notify);
+	vpe_notify(cpu_idx, &notify);
 
-	if (cpu_has_vint)
-		set_vi_handler(MIPS_CPU_RTLX_IRQ, rtlx_dispatch);
-	else {
+	if (cpu_has_vint) {
+		/*
+		 * set_vi_handler() doesn't work in some cases: When sw0
+		 * gets set, a hw interrupt is signaled as well. Here we
+		 * are hooking it into platform specific dispatch.
+		 */
+		aprp_hook = rtlx_dispatch;
+	} else {
 		pr_err("APRP RTLX init on non-vectored-interrupt processor\n");
 		err = -ENODEV;
 		goto out_chrdev;
@@ -543,6 +657,7 @@ out_chrdev:
 
 	return err;
 }
+#endif
 
 static void __exit rtlx_module_exit(void)
 {
@@ -552,6 +667,7 @@ static void __exit rtlx_module_exit(void)
 		device_destroy(mt_class, MKDEV(major, i));
 
 	unregister_chrdev(major, module_name);
+	aprp_hook = null_aprp_hook;
 }
 
 module_init(rtlx_module_init);
diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index eec690a..a558bbe 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2004, 2005 MIPS Technologies, Inc.  All rights reserved.
+ * Copyright (C) 2004, 2005, 2012 MIPS Technologies, Inc.  All rights reserved.
  *
  *  This program is free software; you can distribute it and/or modify it
  *  under the terms of the GNU General Public License (Version 2) as
@@ -63,6 +63,7 @@ typedef void *vpe_handle;
 /*
  * The number of TCs and VPEs physically available on the core
  */
+static int cpu_idx;
 static int hw_tcs, hw_vpes;
 static char module_name[] = "vpe";
 static int major;
@@ -365,9 +366,8 @@ static int apply_r_mips_gprel16(struct module *me, uint32_t *location,
 	}
 
 	if( (rel > 32768) || (rel < -32768) ) {
-		printk(KERN_DEBUG "VPE loader: apply_r_mips_gprel16: "
-		       "relative address 0x%x out of range of gp register\n",
-		       rel);
+		pr_debug("VPE loader: apply_r_mips_gprel16: relative address 0x%x out of range of gp register\n",
+			 rel);
 		return -ENOEXEC;
 	}
 
@@ -381,12 +381,12 @@ static int apply_r_mips_pc16(struct module *me, uint32_t *location,
 {
 	int rel;
 	rel = (((unsigned int)v - (unsigned int)location));
-	rel >>= 2;		// because the offset is in _instructions_ not bytes.
-	rel -= 1;		// and one instruction less due to the branch delay slot.
+	rel >>= 2; /* because the offset is in _instructions_ not bytes. */
+	rel -= 1;  /* and one instruction less due to the branch delay slot. */
 
 	if( (rel > 32768) || (rel < -32768) ) {
-		printk(KERN_DEBUG "VPE loader: "
- 		       "apply_r_mips_pc16: relative address out of range 0x%x\n", rel);
+		pr_debug("VPE loader: apply_r_mips_pc16: relative address out of range 0x%x\n",
+			 rel);
 		return -ENOEXEC;
 	}
 
@@ -407,8 +407,7 @@ static int apply_r_mips_26(struct module *me, uint32_t *location,
 			   Elf32_Addr v)
 {
 	if (v % 4) {
-		printk(KERN_DEBUG "VPE loader: apply_r_mips_26 "
-		       " unaligned relocation\n");
+		pr_debug("VPE loader: apply_r_mips_26 unaligned relocation\n");
 		return -ENOEXEC;
 	}
 
@@ -471,9 +470,7 @@ static int apply_r_mips_lo16(struct module *me, uint32_t *location,
 			 * The value for the HI16 had best be the same.
 			 */
  			if (v != l->value) {
-				printk(KERN_DEBUG "VPE loader: "
-				       "apply_r_mips_lo16/hi16: \t"
-				       "inconsistent value information\n");
+				pr_debug("VPE loader: apply_r_mips_lo16/hi16: \tinconsistent value information\n");
 				goto out_free;
 			}
 
@@ -569,7 +566,7 @@ static int apply_relocations(Elf32_Shdr *sechdrs,
 			+ ELF32_R_SYM(r_info);
 
 		if (!sym->st_value) {
-			printk(KERN_DEBUG "%s: undefined weak symbol %s\n",
+			pr_debug("%s: undefined weak symbol %s\n",
 			       me->name, strtab + sym->st_name);
 			/* just print the warning, dont barf */
 		}
@@ -579,10 +576,9 @@ static int apply_relocations(Elf32_Shdr *sechdrs,
 		res = reloc_handlers[ELF32_R_TYPE(r_info)](me, location, v);
 		if( res ) {
 			char *r = rstrs[ELF32_R_TYPE(r_info)];
-		    	printk(KERN_WARNING "VPE loader: .text+0x%x "
-			       "relocation type %s for symbol \"%s\" failed\n",
-			       rel[i].r_offset, r ? r : "UNKNOWN",
-			       strtab + sym->st_name);
+			pr_warn("VPE loader: .text+0x%x relocation type %s for symbol \"%s\" failed\n",
+				rel[i].r_offset, r ? r : "UNKNOWN",
+				strtab + sym->st_name);
 			return res;
 		}
 	}
@@ -641,10 +637,9 @@ static void simplify_symbols(Elf_Shdr * sechdrs,
 			break;
 
 		case SHN_MIPS_SCOMMON:
-			printk(KERN_DEBUG "simplify_symbols: ignoring SHN_MIPS_SCOMMON "
-			       "symbol <%s> st_shndx %d\n", strtab + sym[i].st_name,
-			       sym[i].st_shndx);
-			// .sbss section
+			pr_debug("simplify_symbols: ignoring SHN_MIPS_SCOMMON symbol <%s> st_shndx %d\n",
+				 strtab + sym[i].st_name, sym[i].st_shndx);
+			/* .sbss section */
 			break;
 
 		default:
@@ -667,14 +662,17 @@ static void dump_elfsymbols(Elf_Shdr * sechdrs, unsigned int symindex,
 	Elf_Sym *sym = (void *)sechdrs[symindex].sh_addr;
 	unsigned int i, n = sechdrs[symindex].sh_size / sizeof(Elf_Sym);
 
-	printk(KERN_DEBUG "dump_elfsymbols: n %d\n", n);
+	pr_debug("dump_elfsymbols: n %d\n", n);
 	for (i = 1; i < n; i++) {
-		printk(KERN_DEBUG " i %d name <%s> 0x%x\n", i,
-		       strtab + sym[i].st_name, sym[i].st_value);
+		pr_debug(" i %d name <%s> 0x%x\n", i, strtab + sym[i].st_name,
+			 sym[i].st_value);
 	}
 }
 #endif
 
+#ifdef CONFIG_MIPS_CMP
+#error CMP vpe_run() not implemented!
+#else
 /* We are prepared so configure and start the VPE... */
 static int vpe_run(struct vpe * v)
 {
@@ -687,8 +685,7 @@ static int vpe_run(struct vpe * v)
 	local_irq_save(flags);
 	val = read_c0_vpeconf0();
 	if (!(val & VPECONF0_MVP)) {
-		printk(KERN_WARNING
-		       "VPE loader: only Master VPE's are allowed to configure MT\n");
+		pr_warn("VPE loader: only Master VPE's are allowed to configure MT\n");
 		local_irq_restore(flags);
 
 		return -1;
@@ -703,9 +700,8 @@ static int vpe_run(struct vpe * v)
 			emt(dmt_flag);
 			local_irq_restore(flags);
 
-			printk(KERN_WARNING
-			       "VPE loader: TC %d is already in use.\n",
-                               t->index);
+			pr_warn("VPE loader: TC %d is already in use.\n",
+				t->index);
 			return -ENOEXEC;
 		}
 	} else {
@@ -713,9 +709,8 @@ static int vpe_run(struct vpe * v)
 		emt(dmt_flag);
 		local_irq_restore(flags);
 
-		printk(KERN_WARNING
-		       "VPE loader: No TC's associated with VPE %d\n",
-		       v->minor);
+		pr_warn("VPE loader: No TC's associated with VPE %d\n",
+			v->minor);
 
 		return -ENOEXEC;
 	}
@@ -731,8 +726,7 @@ static int vpe_run(struct vpe * v)
 		emt(dmt_flag);
 		local_irq_restore(flags);
 
-		printk(KERN_WARNING "VPE loader: TC %d is already active!\n",
-		       t->index);
+		pr_warn("VPE loader: TC %d is already active!\n", t->index);
 
 		return -ENOEXEC;
 	}
@@ -804,6 +798,7 @@ static int vpe_run(struct vpe * v)
 
 	return 0;
 }
+#endif /* CONFIG_MIPS_CMP */
 
 static int find_vpe_symbols(struct vpe * v, Elf_Shdr * sechdrs,
 				      unsigned int symindex, const char *strtab,
@@ -854,8 +849,7 @@ static int vpe_elfload(struct vpe * v)
 	    || (hdr->e_type != ET_REL && hdr->e_type != ET_EXEC)
 	    || !elf_check_arch(hdr)
 	    || hdr->e_shentsize != sizeof(*sechdrs)) {
-		printk(KERN_WARNING
-		       "VPE loader: program wrong arch or weird elf version\n");
+		pr_warn("VPE loader: program wrong arch or weird elf version\n");
 
 		return -ENOEXEC;
 	}
@@ -864,8 +858,7 @@ static int vpe_elfload(struct vpe * v)
 		relocate = 1;
 
 	if (len < hdr->e_shoff + hdr->e_shnum * sizeof(Elf_Shdr)) {
-		printk(KERN_ERR "VPE loader: program length %u truncated\n",
-		       len);
+		pr_err("VPE loader: program length %u truncated\n", len);
 
 		return -ENOEXEC;
 	}
@@ -882,7 +875,7 @@ static int vpe_elfload(struct vpe * v)
 		for (i = 1; i < hdr->e_shnum; i++) {
 			if (sechdrs[i].sh_type != SHT_NOBITS
 			    && len < sechdrs[i].sh_offset + sechdrs[i].sh_size) {
-				printk(KERN_ERR "VPE program length %u truncated\n",
+				pr_err("VPE program length %u truncated\n",
 				       len);
 				return -ENOEXEC;
 			}
@@ -922,8 +915,9 @@ static int vpe_elfload(struct vpe * v)
 			/* Update sh_addr to point to copy in image. */
 			sechdrs[i].sh_addr = (unsigned long)dest;
 
-			printk(KERN_DEBUG " section sh_name %s sh_addr 0x%x\n",
-			       secstrings + sechdrs[i].sh_name, sechdrs[i].sh_addr);
+			pr_debug(" section sh_name %s sh_addr 0x%x\n",
+				 secstrings + sechdrs[i].sh_name,
+				 sechdrs[i].sh_addr);
 		}
 
  		/* Fix up syms, so that st_value is a pointer to location. */
@@ -987,21 +981,25 @@ static int vpe_elfload(struct vpe * v)
 
 	if ((find_vpe_symbols(v, sechdrs, symindex, strtab, &mod)) < 0) {
 		if (v->__start == 0) {
-			printk(KERN_WARNING "VPE loader: program does not contain "
-			       "a __start symbol\n");
+			pr_warn("VPE loader: program does not contain a __start symbol\n");
 			return -ENOEXEC;
 		}
 
 		if (v->shared_ptr == NULL)
-			printk(KERN_WARNING "VPE loader: "
-			       "program does not contain vpe_shared symbol.\n"
-			       " Unable to use AMVP (AP/SP) facilities.\n");
+			pr_warn("VPE loader: program does not contain vpe_shared symbol.\n"
+				" Unable to use AMVP (AP/SP) facilities.\n");
 	}
 
-	printk(" elf loaded\n");
+	pr_info(" elf loaded\n");
 	return 0;
 }
 
+#ifdef CONFIG_MIPS_CMP
+static void cleanup_tc(struct tc *tc)
+{
+
+}
+#else
 static void cleanup_tc(struct tc *tc)
 {
 	unsigned long flags;
@@ -1033,6 +1031,7 @@ static void cleanup_tc(struct tc *tc)
 	emt(mtflags);
 	local_irq_restore(flags);
 }
+#endif
 
 static int getcwd(char *buff, int size)
 {
@@ -1064,7 +1063,8 @@ static int vpe_open(struct inode *inode, struct file *filp)
 		return -ENODEV;
 	}
 
-	if ((v = get_vpe(tclimit)) == NULL) {
+	v = get_vpe(cpu_idx);
+	if (v == NULL) {
 		pr_warning("VPE loader: unable to get vpe\n");
 
 		return -ENODEV;
@@ -1072,14 +1072,14 @@ static int vpe_open(struct inode *inode, struct file *filp)
 
 	state = xchg(&v->state, VPE_STATE_INUSE);
 	if (state != VPE_STATE_UNUSED) {
-		printk(KERN_DEBUG "VPE loader: tc in use dumping regs\n");
+		pr_debug("VPE loader: tc in use dumping regs\n");
 
 		list_for_each_entry(not, &v->notify, list) {
-			not->stop(tclimit);
+			not->stop(cpu_idx);
 		}
 
 		release_progmem(v->load_addr);
-		cleanup_tc(get_tc(tclimit));
+		cleanup_tc(get_tc(cpu_idx));
 	}
 
 	/* this of-course trashes what was there before... */
@@ -1098,7 +1098,7 @@ static int vpe_open(struct inode *inode, struct file *filp)
 	v->cwd[0] = 0;
 	ret = getcwd(v->cwd, VPE_PATH_MAX);
 	if (ret < 0)
-		printk(KERN_WARNING "VPE loader: open, getcwd returned %d\n", ret);
+		pr_warn("VPE loader: open, getcwd returned %d\n", ret);
 
 	v->shared_ptr = NULL;
 	v->__start = 0;
@@ -1112,7 +1112,8 @@ static int vpe_release(struct inode *inode, struct file *filp)
 	Elf_Ehdr *hdr;
 	int ret = 0;
 
-	v = get_vpe(tclimit);
+	v = get_vpe(cpu_idx);
+
 	if (v == NULL)
 		return -ENODEV;
 
@@ -1121,11 +1122,11 @@ static int vpe_release(struct inode *inode, struct file *filp)
 		if (vpe_elfload(v) >= 0) {
 			vpe_run(v);
 		} else {
- 			printk(KERN_WARNING "VPE loader: ELF load failed.\n");
+			pr_warn("VPE loader: ELF load failed.\n");
 			ret = -ENOEXEC;
 		}
 	} else {
- 		printk(KERN_WARNING "VPE loader: only elf files are supported\n");
+		pr_warn("VPE loader: only elf files are supported\n");
 		ret = -ENOEXEC;
 	}
 
@@ -1152,7 +1153,8 @@ static ssize_t vpe_write(struct file *file, const char __user * buffer,
 	if (iminor(file->f_path.dentry->d_inode) != minor)
 		return -ENODEV;
 
-	v = get_vpe(tclimit);
+	v = get_vpe(cpu_idx);
+
 	if (v == NULL)
 		return -ENODEV;
 
@@ -1178,6 +1180,7 @@ static const struct file_operations vpe_fops = {
 	.llseek = noop_llseek,
 };
 
+#ifndef CONFIG_MIPS_CMP
 /* module wrapper entry points */
 /* give me a vpe */
 vpe_handle vpe_alloc(void)
@@ -1265,6 +1268,7 @@ int vpe_free(vpe_handle vpe)
 }
 
 EXPORT_SYMBOL(vpe_free);
+#endif /* CONFIG_MIPS_CMP */
 
 void *vpe_get_shared(int index)
 {
@@ -1327,18 +1331,62 @@ char *vpe_getcwd(int index)
 
 EXPORT_SYMBOL(vpe_getcwd);
 
+#ifdef CONFIG_MIPS_CMP
 static ssize_t store_kill(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t len)
 {
-	struct vpe *vpe = get_vpe(tclimit);
+	struct vpe *vpe = get_vpe(cpu_idx);
 	struct vpe_notifications *not;
 
 	list_for_each_entry(not, &vpe->notify, list) {
-		not->stop(tclimit);
+		not->stop(cpu_idx);
 	}
 
 	release_progmem(vpe->load_addr);
-	cleanup_tc(get_tc(tclimit));
+	vpe->state = VPE_STATE_UNUSED;
+
+	return len;
+}
+
+static ssize_t show_ntcs(struct device *cd, struct device_attribute *attr,
+			 char *buf)
+{
+	struct vpe *vpe = get_vpe(cpu_idx);
+
+	return sprintf(buf, "%d\n", vpe->ntcs);
+}
+
+static ssize_t store_ntcs(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t len)
+{
+	struct vpe *vpe = get_vpe(cpu_idx);
+	unsigned long new;
+	int ret;
+
+	ret = kstrtoul(buf, 0, &new);
+	if (ret < 0)
+		return ret;
+
+	if (new != 1)
+		return -EINVAL;
+
+	vpe->ntcs = new;
+
+	return len;
+}
+#else
+static ssize_t store_kill(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t len)
+{
+	struct vpe *vpe = get_vpe(cpu_idx);
+	struct vpe_notifications *not;
+
+	list_for_each_entry(not, &vpe->notify, list) {
+		not->stop(cpu_idx);
+	}
+
+	release_progmem(vpe->load_addr);
+	cleanup_tc(get_tc(cpu_idx));
 	vpe_stop(vpe);
 	vpe_free(vpe);
 
@@ -1348,7 +1396,7 @@ static ssize_t store_kill(struct device *dev, struct device_attribute *attr,
 static ssize_t show_ntcs(struct device *cd, struct device_attribute *attr,
 			 char *buf)
 {
-	struct vpe *vpe = get_vpe(tclimit);
+	struct vpe *vpe = get_vpe(cpu_idx);
 
 	return sprintf(buf, "%d\n", vpe->ntcs);
 }
@@ -1356,24 +1404,22 @@ static ssize_t show_ntcs(struct device *cd, struct device_attribute *attr,
 static ssize_t store_ntcs(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t len)
 {
-	struct vpe *vpe = get_vpe(tclimit);
+	struct vpe *vpe = get_vpe(cpu_idx);
 	unsigned long new;
-	char *endp;
+	int ret;
 
-	new = simple_strtoul(buf, &endp, 0);
-	if (endp == buf)
-		goto out_einval;
+	ret = kstrtoul(buf, 0, &new);
+	if (ret < 0)
+		return ret;
 
-	if (new == 0 || new > (hw_tcs - tclimit))
-		goto out_einval;
+	if (new == 0 || new > (hw_tcs - cpu_idx))
+		return -EINVAL;
 
 	vpe->ntcs = new;
 
 	return len;
-
-out_einval:
-	return -EINVAL;
 }
+#endif /* CONFIG_MIPS_CMP */
 
 static struct device_attribute vpe_class_attributes[] = {
 	__ATTR(kill, S_IWUSR, NULL, store_kill),
@@ -1395,6 +1441,84 @@ struct class vpe_class = {
 
 struct device vpe_device;
 
+#ifdef CONFIG_MIPS_CMP
+static int __init vpe_module_init(void)
+{
+	struct vpe *v = NULL;
+	struct tc *t;
+	int err;
+
+	if (!cpu_has_mipsmt) {
+		pr_warn("VPE loader: not a MIPS MT capable processor\n");
+		return -ENODEV;
+	}
+
+	cpu_idx = setup_max_cpus;
+
+	if (num_possible_cpus() - cpu_idx < 1) {
+		pr_warn("No VPEs reserved for AP/SP, not initialize VPE loader\n"
+			"Pass maxcpus=<n> argument as kernel argument\n");
+		return -ENODEV;
+	}
+
+	major = register_chrdev(0, module_name, &vpe_fops);
+	if (major < 0) {
+		pr_warn("VPE loader: unable to register character device\n");
+		return major;
+	}
+
+	err = class_register(&vpe_class);
+	if (err) {
+		pr_err("vpe_class registration failed\n");
+		goto out_chrdev;
+	}
+
+	device_initialize(&vpe_device);
+	vpe_device.class	= &vpe_class,
+	vpe_device.parent	= NULL,
+	dev_set_name(&vpe_device, "vpe_sp");
+	vpe_device.devt = MKDEV(major, minor);
+	err = device_add(&vpe_device);
+	if (err) {
+		pr_err("Adding vpe_device failed\n");
+		goto out_class;
+	}
+
+	t = alloc_tc(cpu_idx);
+	if (!t) {
+		pr_warn("VPE: unable to allocate TC\n");
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/* VPE */
+	v = alloc_vpe(cpu_idx);
+	if (v == NULL) {
+		pr_warn("VPE: unable to allocate VPE\n");
+		kfree(t);
+		err = -ENOMEM;
+		goto out;
+	}
+
+	v->ntcs = 1;
+
+	/* add the tc to the list of this vpe's tc's. */
+	list_add(&t->tc, &v->tc);
+
+	/* TC */
+	t->pvpe = v;	/* set the parent vpe */
+
+	return 0;
+
+out_class:
+	class_unregister(&vpe_class);
+out_chrdev:
+	unregister_chrdev(major, module_name);
+
+out:
+	return err;
+}
+#else
 static int __init vpe_module_init(void)
 {
 	unsigned int mtflags, vpflags;
@@ -1404,35 +1528,35 @@ static int __init vpe_module_init(void)
 	int tc, err;
 
 	if (!cpu_has_mipsmt) {
-		printk("VPE loader: not a MIPS MT capable processor\n");
+		pr_warn("VPE loader: not a MIPS MT capable processor\n");
 		return -ENODEV;
 	}
 
 	if (vpelimit == 0) {
-		printk(KERN_WARNING "No VPEs reserved for AP/SP, not "
-		       "initializing VPE loader.\nPass maxvpes=<n> argument as "
-		       "kernel argument\n");
+		pr_warn("No VPEs reserved for AP/SP, not initialize VPE loader\n"
+			"Pass maxvpes=<n> argument as kernel argument\n");
 
 		return -ENODEV;
 	}
 
-	if (tclimit == 0) {
-		printk(KERN_WARNING "No TCs reserved for AP/SP, not "
-		       "initializing VPE loader.\nPass maxtcs=<n> argument as "
-		       "kernel argument\n");
+	cpu_idx = tclimit;
+
+	if (cpu_idx == 0) {
+		pr_warn("No TCs reserved for AP/SP, not initialize VPE loader\n"
+			"Pass maxtcs=<n> argument as kernel argument\n");
 
 		return -ENODEV;
 	}
 
 	major = register_chrdev(0, module_name, &vpe_fops);
 	if (major < 0) {
-		printk("VPE loader: unable to register character device\n");
+		pr_warn("VPE loader: unable to register character device\n");
 		return major;
 	}
 
 	err = class_register(&vpe_class);
 	if (err) {
-		printk(KERN_ERR "vpe_class registration failed\n");
+		pr_err("vpe_class registration failed\n");
 		goto out_chrdev;
 	}
 
@@ -1443,7 +1567,7 @@ static int __init vpe_module_init(void)
 	vpe_device.devt = MKDEV(major, minor);
 	err = device_add(&vpe_device);
 	if (err) {
-		printk(KERN_ERR "Adding vpe_device failed\n");
+		pr_err("Adding vpe_device failed\n");
 		goto out_class;
 	}
 
@@ -1460,7 +1584,7 @@ static int __init vpe_module_init(void)
 	hw_tcs = (val & MVPCONF0_PTC) + 1;
 	hw_vpes = ((val & MVPCONF0_PVPE) >> MVPCONF0_PVPE_SHIFT) + 1;
 
-	for (tc = tclimit; tc < hw_tcs; tc++) {
+	for (tc = cpu_idx; tc < hw_tcs; tc++) {
 		/*
 		 * Must re-enable multithreading temporarily or in case we
 		 * reschedule send IPIs or similar we might hang.
@@ -1484,19 +1608,20 @@ static int __init vpe_module_init(void)
 		if (tc < hw_tcs) {
 			settc(tc);
 
-			if ((v = alloc_vpe(tc)) == NULL) {
-				printk(KERN_WARNING "VPE: unable to allocate VPE\n");
+			v = alloc_vpe(tc);
+			if (v == NULL) {
+				pr_warn("VPE: unable to allocate VPE\n");
 
 				goto out_reenable;
 			}
 
-			v->ntcs = hw_tcs - tclimit;
+			v->ntcs = hw_tcs - cpu_idx;
 
 			/* add the tc to the list of this vpe's tc's. */
 			list_add(&t->tc, &v->tc);
 
 			/* deactivate all but vpe0 */
-			if (tc >= tclimit) {
+			if (tc >= cpu_idx) {
 				unsigned long tmp = read_vpe_c0_vpeconf0();
 
 				tmp &= ~VPECONF0_VPA;
@@ -1521,7 +1646,7 @@ static int __init vpe_module_init(void)
 		/* TC's */
 		t->pvpe = v;	/* set the parent vpe */
 
-		if (tc >= tclimit) {
+		if (tc >= cpu_idx) {
 			unsigned long tmp;
 
 			settc(tc);
@@ -1574,6 +1699,7 @@ out_chrdev:
 out:
 	return err;
 }
+#endif /* CONFIG_MIPS_CMP */
 
 static void __exit vpe_module_exit(void)
 {
-- 
1.7.1
