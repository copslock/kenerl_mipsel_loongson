Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Apr 2013 18:53:45 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:1381 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825880Ab3DHQxQdgad1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 8 Apr 2013 18:53:16 +0200
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <kevink@paralogos.com>, <macro@linux-mips.org>, <john@phrozen.org>
CC:     <Steven.Hill@imgtec.com>, <dengcheng.zhu@imgtec.com>
Subject: [PATCH v4 1/5] MIPS: APRP (APSP): fix/enrich functionality
Date:   Mon, 8 Apr 2013 09:52:58 -0700
Message-ID: <1365439982-4117-2-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1365439982-4117-1-git-send-email-dengcheng.zhu@imgtec.com>
References: <1365439982-4117-1-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-SEF-Processed: 7_3_0_01181__2013_04_08_17_53_14
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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

From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>

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

Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
 arch/mips/Kconfig            |    9 ++
 arch/mips/include/asm/rtlx.h |    5 +
 arch/mips/kernel/rtlx.c      |  190 ++++++++++++++++++++++------
 arch/mips/kernel/vpe.c       |  296 ++++++++++++++++++++++++++++++------------
 4 files changed, 379 insertions(+), 121 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a6fdd16..6f7c66c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1989,6 +1989,15 @@ config MIPS_VPE_LOADER_TOM
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
index 90985b6..639a494 100644
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
index 93c070b..1e8b6c7 100644
--- a/arch/mips/kernel/rtlx.c
+++ b/arch/mips/kernel/rtlx.c
@@ -1,6 +1,7 @@
 /*
  * Copyright (C) 2005 MIPS Technologies, Inc.  All rights reserved.
  * Copyright (C) 2005, 06 Ralf Baechle (ralf@linux-mips.org)
+ * Copyright (C) 2013 Imagination Technologies Ltd.
  *
  *  This program is free software; you can distribute it and/or modify it
  *  under the terms of the GNU General Public License (Version 2) as
@@ -36,6 +37,7 @@
 #include <asm/mips_mt.h>
 #include <asm/cacheflush.h>
 #include <linux/atomic.h>
+#include <asm/smp.h>
 #include <asm/cpu.h>
 #include <asm/processor.h>
 #include <asm/vpe.h>
@@ -54,15 +56,40 @@ static struct chan_waitqueues {
 
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
@@ -81,12 +108,13 @@ static irqreturn_t rtlx_interrupt(int irq, void *dev_id)
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
@@ -115,8 +143,7 @@ static void __used dump_rtlx(void)
 static int rtlx_init(struct rtlx_info *rtlxi)
 {
 	if (rtlxi->id != RTLX_ID) {
-		printk(KERN_ERR "no valid RTLX id at 0x%p 0x%lx\n",
-			rtlxi, rtlxi->id);
+		pr_err("no valid RTLX id at 0x%p 0x%lx\n", rtlxi, rtlxi->id);
 		return -ENOEXEC;
 	}
 
@@ -157,30 +184,30 @@ int rtlx_open(int index, int can_sleep)
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
@@ -204,16 +231,14 @@ int rtlx_open(int index, int can_sleep)
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
@@ -343,6 +368,25 @@ out:
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
@@ -383,6 +427,8 @@ out:
 	smp_wmb();
 	mutex_unlock(&channel_wqs[index].mutex);
 
+	_interrupt_sp();
+
 	return count;
 }
 
@@ -436,7 +482,6 @@ static ssize_t file_write(struct file *file, const char __user * buffer,
 			  size_t count, loff_t * ppos)
 {
 	int minor = iminor(file_inode(file));
-	struct rtlx_channel *rt = &rtlx->channel[minor];
 
 	/* any space left... */
 	if (!rtlx_write_poll(minor)) {
@@ -465,6 +510,72 @@ static const struct file_operations rtlx_fops = {
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
@@ -472,23 +583,21 @@ static struct irqaction rtlx_irq = {
 
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
@@ -517,11 +626,16 @@ static int __init rtlx_module_init(void)
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
@@ -538,6 +652,7 @@ out_chrdev:
 
 	return err;
 }
+#endif
 
 static void __exit rtlx_module_exit(void)
 {
@@ -547,6 +662,7 @@ static void __exit rtlx_module_exit(void)
 		device_destroy(mt_class, MKDEV(major, i));
 
 	unregister_chrdev(major, module_name);
+	aprp_hook = null_aprp_hook;
 }
 
 module_init(rtlx_module_init);
diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index 1765bab..27d283c 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2004, 2005 MIPS Technologies, Inc.  All rights reserved.
+ * Copyright (C) 2013 Imagination Technologies Ltd.
  *
  *  This program is free software; you can distribute it and/or modify it
  *  under the terms of the GNU General Public License (Version 2) as
@@ -63,6 +64,7 @@ typedef void *vpe_handle;
 /*
  * The number of TCs and VPEs physically available on the core
  */
+static int cpu_idx;
 static int hw_tcs, hw_vpes;
 static char module_name[] = "vpe";
 static int major;
@@ -365,9 +367,8 @@ static int apply_r_mips_gprel16(struct module *me, uint32_t *location,
 	}
 
 	if( (rel > 32768) || (rel < -32768) ) {
-		printk(KERN_DEBUG "VPE loader: apply_r_mips_gprel16: "
-		       "relative address 0x%x out of range of gp register\n",
-		       rel);
+		pr_debug("VPE loader: apply_r_mips_gprel16: relative address 0x%x out of range of gp register\n",
+			 rel);
 		return -ENOEXEC;
 	}
 
@@ -381,12 +382,12 @@ static int apply_r_mips_pc16(struct module *me, uint32_t *location,
 {
 	int rel;
 	rel = (((unsigned int)v - (unsigned int)location));
-	rel >>= 2;		// because the offset is in _instructions_ not bytes.
-	rel -= 1;		// and one instruction less due to the branch delay slot.
+	rel >>= 2; /* because the offset is in _instructions_ not bytes. */
+	rel -= 1;  /* and one instruction less due to the branch delay slot. */
 
 	if( (rel > 32768) || (rel < -32768) ) {
-		printk(KERN_DEBUG "VPE loader: "
-		       "apply_r_mips_pc16: relative address out of range 0x%x\n", rel);
+		pr_debug("VPE loader: apply_r_mips_pc16: relative address out of range 0x%x\n",
+			 rel);
 		return -ENOEXEC;
 	}
 
@@ -407,8 +408,7 @@ static int apply_r_mips_26(struct module *me, uint32_t *location,
 			   Elf32_Addr v)
 {
 	if (v % 4) {
-		printk(KERN_DEBUG "VPE loader: apply_r_mips_26 "
-		       " unaligned relocation\n");
+		pr_debug("VPE loader: apply_r_mips_26 unaligned relocation\n");
 		return -ENOEXEC;
 	}
 
@@ -471,9 +471,7 @@ static int apply_r_mips_lo16(struct module *me, uint32_t *location,
 			 * The value for the HI16 had best be the same.
 			 */
 			if (v != l->value) {
-				printk(KERN_DEBUG "VPE loader: "
-				       "apply_r_mips_lo16/hi16: \t"
-				       "inconsistent value information\n");
+				pr_debug("VPE loader: apply_r_mips_lo16/hi16: \tinconsistent value information\n");
 				goto out_free;
 			}
 
@@ -569,7 +567,7 @@ static int apply_relocations(Elf32_Shdr *sechdrs,
 			+ ELF32_R_SYM(r_info);
 
 		if (!sym->st_value) {
-			printk(KERN_DEBUG "%s: undefined weak symbol %s\n",
+			pr_debug("%s: undefined weak symbol %s\n",
 			       me->name, strtab + sym->st_name);
 			/* just print the warning, dont barf */
 		}
@@ -579,10 +577,9 @@ static int apply_relocations(Elf32_Shdr *sechdrs,
 		res = reloc_handlers[ELF32_R_TYPE(r_info)](me, location, v);
 		if( res ) {
 			char *r = rstrs[ELF32_R_TYPE(r_info)];
-			printk(KERN_WARNING "VPE loader: .text+0x%x "
-			       "relocation type %s for symbol \"%s\" failed\n",
-			       rel[i].r_offset, r ? r : "UNKNOWN",
-			       strtab + sym->st_name);
+			pr_warn("VPE loader: .text+0x%x relocation type %s for symbol \"%s\" failed\n",
+				rel[i].r_offset, r ? r : "UNKNOWN",
+				strtab + sym->st_name);
 			return res;
 		}
 	}
@@ -641,10 +638,9 @@ static void simplify_symbols(Elf_Shdr * sechdrs,
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
@@ -667,14 +663,17 @@ static void dump_elfsymbols(Elf_Shdr * sechdrs, unsigned int symindex,
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
@@ -687,8 +686,7 @@ static int vpe_run(struct vpe * v)
 	local_irq_save(flags);
 	val = read_c0_vpeconf0();
 	if (!(val & VPECONF0_MVP)) {
-		printk(KERN_WARNING
-		       "VPE loader: only Master VPE's are allowed to configure MT\n");
+		pr_warn("VPE loader: only Master VPE's are allowed to configure MT\n");
 		local_irq_restore(flags);
 
 		return -1;
@@ -702,9 +700,8 @@ static int vpe_run(struct vpe * v)
 		emt(dmt_flag);
 		local_irq_restore(flags);
 
-		printk(KERN_WARNING
-		       "VPE loader: No TC's associated with VPE %d\n",
-		       v->minor);
+		pr_warn("VPE loader: No TC's associated with VPE %d\n",
+			v->minor);
 
 		return -ENOEXEC;
 	}
@@ -722,8 +719,7 @@ static int vpe_run(struct vpe * v)
 		emt(dmt_flag);
 		local_irq_restore(flags);
 
-		printk(KERN_WARNING "VPE loader: TC %d is already active!\n",
-		       t->index);
+		pr_warn("VPE loader: TC %d is already active!\n", t->index);
 
 		return -ENOEXEC;
 	}
@@ -795,6 +791,7 @@ static int vpe_run(struct vpe * v)
 
 	return 0;
 }
+#endif /* CONFIG_MIPS_CMP */
 
 static int find_vpe_symbols(struct vpe * v, Elf_Shdr * sechdrs,
 				      unsigned int symindex, const char *strtab,
@@ -845,8 +842,7 @@ static int vpe_elfload(struct vpe * v)
 	    || (hdr->e_type != ET_REL && hdr->e_type != ET_EXEC)
 	    || !elf_check_arch(hdr)
 	    || hdr->e_shentsize != sizeof(*sechdrs)) {
-		printk(KERN_WARNING
-		       "VPE loader: program wrong arch or weird elf version\n");
+		pr_warn("VPE loader: program wrong arch or weird elf version\n");
 
 		return -ENOEXEC;
 	}
@@ -855,8 +851,7 @@ static int vpe_elfload(struct vpe * v)
 		relocate = 1;
 
 	if (len < hdr->e_shoff + hdr->e_shnum * sizeof(Elf_Shdr)) {
-		printk(KERN_ERR "VPE loader: program length %u truncated\n",
-		       len);
+		pr_err("VPE loader: program length %u truncated\n", len);
 
 		return -ENOEXEC;
 	}
@@ -873,7 +868,7 @@ static int vpe_elfload(struct vpe * v)
 		for (i = 1; i < hdr->e_shnum; i++) {
 			if (sechdrs[i].sh_type != SHT_NOBITS
 			    && len < sechdrs[i].sh_offset + sechdrs[i].sh_size) {
-				printk(KERN_ERR "VPE program length %u truncated\n",
+				pr_err("VPE program length %u truncated\n",
 				       len);
 				return -ENOEXEC;
 			}
@@ -913,8 +908,9 @@ static int vpe_elfload(struct vpe * v)
 			/* Update sh_addr to point to copy in image. */
 			sechdrs[i].sh_addr = (unsigned long)dest;
 
-			printk(KERN_DEBUG " section sh_name %s sh_addr 0x%x\n",
-			       secstrings + sechdrs[i].sh_name, sechdrs[i].sh_addr);
+			pr_debug(" section sh_name %s sh_addr 0x%x\n",
+				 secstrings + sechdrs[i].sh_name,
+				 sechdrs[i].sh_addr);
 		}
 
 		/* Fix up syms, so that st_value is a pointer to location. */
@@ -978,21 +974,25 @@ static int vpe_elfload(struct vpe * v)
 
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
@@ -1024,6 +1024,7 @@ static void cleanup_tc(struct tc *tc)
 	emt(mtflags);
 	local_irq_restore(flags);
 }
+#endif
 
 static int getcwd(char *buff, int size)
 {
@@ -1055,7 +1056,8 @@ static int vpe_open(struct inode *inode, struct file *filp)
 		return -ENODEV;
 	}
 
-	if ((v = get_vpe(tclimit)) == NULL) {
+	v = get_vpe(cpu_idx);
+	if (v == NULL) {
 		pr_warning("VPE loader: unable to get vpe\n");
 
 		return -ENODEV;
@@ -1063,14 +1065,14 @@ static int vpe_open(struct inode *inode, struct file *filp)
 
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
@@ -1089,7 +1091,7 @@ static int vpe_open(struct inode *inode, struct file *filp)
 	v->cwd[0] = 0;
 	ret = getcwd(v->cwd, VPE_PATH_MAX);
 	if (ret < 0)
-		printk(KERN_WARNING "VPE loader: open, getcwd returned %d\n", ret);
+		pr_warn("VPE loader: open, getcwd returned %d\n", ret);
 
 	v->shared_ptr = NULL;
 	v->__start = 0;
@@ -1103,7 +1105,8 @@ static int vpe_release(struct inode *inode, struct file *filp)
 	Elf_Ehdr *hdr;
 	int ret = 0;
 
-	v = get_vpe(tclimit);
+	v = get_vpe(cpu_idx);
+
 	if (v == NULL)
 		return -ENODEV;
 
@@ -1112,11 +1115,11 @@ static int vpe_release(struct inode *inode, struct file *filp)
 		if (vpe_elfload(v) >= 0) {
 			vpe_run(v);
 		} else {
-			printk(KERN_WARNING "VPE loader: ELF load failed.\n");
+			pr_warn("VPE loader: ELF load failed.\n");
 			ret = -ENOEXEC;
 		}
 	} else {
-		printk(KERN_WARNING "VPE loader: only elf files are supported\n");
+		pr_warn("VPE loader: only elf files are supported\n");
 		ret = -ENOEXEC;
 	}
 
@@ -1143,7 +1146,8 @@ static ssize_t vpe_write(struct file *file, const char __user * buffer,
 	if (iminor(file_inode(file)) != minor)
 		return -ENODEV;
 
-	v = get_vpe(tclimit);
+	v = get_vpe(cpu_idx);
+
 	if (v == NULL)
 		return -ENODEV;
 
@@ -1169,6 +1173,7 @@ static const struct file_operations vpe_fops = {
 	.llseek = noop_llseek,
 };
 
+#ifndef CONFIG_MIPS_CMP
 /* module wrapper entry points */
 /* give me a vpe */
 vpe_handle vpe_alloc(void)
@@ -1256,6 +1261,7 @@ int vpe_free(vpe_handle vpe)
 }
 
 EXPORT_SYMBOL(vpe_free);
+#endif /* CONFIG_MIPS_CMP */
 
 void *vpe_get_shared(int index)
 {
@@ -1318,18 +1324,62 @@ char *vpe_getcwd(int index)
 
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
 
@@ -1339,7 +1389,7 @@ static ssize_t store_kill(struct device *dev, struct device_attribute *attr,
 static ssize_t show_ntcs(struct device *cd, struct device_attribute *attr,
 			 char *buf)
 {
-	struct vpe *vpe = get_vpe(tclimit);
+	struct vpe *vpe = get_vpe(cpu_idx);
 
 	return sprintf(buf, "%d\n", vpe->ntcs);
 }
@@ -1347,24 +1397,22 @@ static ssize_t show_ntcs(struct device *cd, struct device_attribute *attr,
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
@@ -1386,6 +1434,84 @@ struct class vpe_class = {
 
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
@@ -1395,35 +1521,35 @@ static int __init vpe_module_init(void)
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
 
@@ -1434,7 +1560,7 @@ static int __init vpe_module_init(void)
 	vpe_device.devt = MKDEV(major, minor);
 	err = device_add(&vpe_device);
 	if (err) {
-		printk(KERN_ERR "Adding vpe_device failed\n");
+		pr_err("Adding vpe_device failed\n");
 		goto out_class;
 	}
 
@@ -1451,7 +1577,7 @@ static int __init vpe_module_init(void)
 	hw_tcs = (val & MVPCONF0_PTC) + 1;
 	hw_vpes = ((val & MVPCONF0_PVPE) >> MVPCONF0_PVPE_SHIFT) + 1;
 
-	for (tc = tclimit; tc < hw_tcs; tc++) {
+	for (tc = cpu_idx; tc < hw_tcs; tc++) {
 		/*
 		 * Must re-enable multithreading temporarily or in case we
 		 * reschedule send IPIs or similar we might hang.
@@ -1475,19 +1601,20 @@ static int __init vpe_module_init(void)
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
@@ -1512,7 +1639,7 @@ static int __init vpe_module_init(void)
 		/* TC's */
 		t->pvpe = v;	/* set the parent vpe */
 
-		if (tc >= tclimit) {
+		if (tc >= cpu_idx) {
 			unsigned long tmp;
 
 			settc(tc);
@@ -1565,6 +1692,7 @@ out_chrdev:
 out:
 	return err;
 }
+#endif /* CONFIG_MIPS_CMP */
 
 static void __exit vpe_module_exit(void)
 {
-- 
1.7.1
