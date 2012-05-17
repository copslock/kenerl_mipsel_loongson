Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2012 10:52:45 +0200 (CEST)
Received: from dns0.mips.com ([12.201.5.70]:53432 "EHLO dns0.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903643Ab2EQIvv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 May 2012 10:51:51 +0200
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns0.mips.com (8.13.8/8.13.8) with ESMTP id q4H8piKY011019;
        Thu, 17 May 2012 01:51:44 -0700
Received: from fun-lab.MIPSCN.CEC (192.168.225.107) by exchhub01.mips.com
 (192.168.36.84) with Microsoft SMTP Server id 14.1.270.1; Thu, 17 May 2012
 01:51:41 -0700
From:   Deng-Cheng Zhu <dczhu@mips.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <kevink@paralogos.com>
CC:     <dczhu@mips.com>
Subject: [PATCH v2 2/2] MIPS: enable CPS multicore APRP (APSP)
Date:   Thu, 17 May 2012 16:51:20 +0800
Message-ID: <1337244680-29968-3-git-send-email-dczhu@mips.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1337244680-29968-1-git-send-email-dczhu@mips.com>
References: <1337244680-29968-1-git-send-email-dczhu@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EMS-Proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
X-EMS-STAMP: yYJfsQocf6nq6wUzfTjzew==
X-archive-position: 33340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dczhu@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Deng-Cheng Zhu <dczhu@mips.com>

Now CPS such as 1004K can run programs in APRP (APSP) model. For example, a
3 core 1004K CPU can run SMVP Linux on the first 2 cores and leave a VPE of
the 3rd core to run RTOS or signal processing program. The kernel command
line option "maxcpus=" needs to be appointed.

Basically I think the way we are doing with rtlx/kspd/vpe_loader can be
extended to other architectures, despite of the low-level register details.

To handle the AP/RP communication interrupt, we hook our ISR into the ipi
resched interrupt.

Known issue: When we define CONFIG_MIPS_CMP to let 1004K run SMVP Linux and
RP program, currently we can only load the RP program 1 time. Loading it
multiple times won't affect the kernel, but only the 1st time works as
expected. This is not a top priority issue I suppose, since normally we
build RP programs to keep alive as kind of server programs -- They wait
for requests in the CPU "wait" mode.

Signed-off-by: Deng-Cheng Zhu <dczhu@mips.com>
---
Changes:
v2 - v1:
o Rebase the patch to the latest kernel, and fix a bunch of warnings and
  errors reported by the current scripts/checkpatch.pl. However, there are
  still 2 warnings that I decide to leave alone for now:
  1) externs should be avoided in .c files
     #261: FILE: arch/mips/kernel/rtlx.c:382:
     +	extern struct plat_smp_ops cmp_smp_ops;
  Currently, in smp-ops.h, {up|cmp|vsmp}_smp_ops are not externed globally.
  Maybe we can do it in a separate patch.
  2) Use of volatile is usually wrong:
     see Documentation/volatile-considered-harmful.txt
     #456: FILE: arch/mips/kernel/vpe.c:698:
     +	volatile struct cpulaunch *launch =
  The volatile is really needed in here. The content pointed to by launch
  will be updated by YAMON.

 arch/mips/include/asm/rtlx.h    |    5 +-
 arch/mips/kernel/kspd.c         |   26 +++-
 arch/mips/kernel/rtlx.c         |  158 ++++++++++++++++++++----
 arch/mips/kernel/vpe.c          |  253 +++++++++++++++++++++++++++++++++++----
 arch/mips/mti-malta/malta-int.c |   16 ++-
 5 files changed, 397 insertions(+), 61 deletions(-)

diff --git a/arch/mips/include/asm/rtlx.h b/arch/mips/include/asm/rtlx.h
index cf23a8c..478349e 100644
--- a/arch/mips/include/asm/rtlx.h
+++ b/arch/mips/include/asm/rtlx.h
@@ -28,7 +28,7 @@ extern ssize_t rtlx_write(int index, const void __user *buffer, size_t count);
 extern unsigned int rtlx_read_poll(int index, int can_sleep);
 extern unsigned int rtlx_write_poll(int index);
 
-extern void (*aprp_dispatch)(void);
+extern void (*aprp_hook)(void);
 
 enum rtlx_state {
 	RTLX_STATE_UNUSED = 0,
@@ -60,6 +60,9 @@ struct rtlx_channel {
 struct rtlx_info {
 	unsigned long id;
 	enum rtlx_state state;
+#ifdef CONFIG_MIPS_CMP
+	int ap_int_pending;
+#endif
 
 	struct rtlx_channel channel[RTLX_CHANNELS];
 };
diff --git a/arch/mips/kernel/kspd.c b/arch/mips/kernel/kspd.c
index 84d0639..bb8d26d 100644
--- a/arch/mips/kernel/kspd.c
+++ b/arch/mips/kernel/kspd.c
@@ -31,6 +31,9 @@
 #include <asm/rtlx.h>
 #include <asm/kspd.h>
 
+#ifdef CONFIG_MIPS_CMP
+static int cpu_idx;
+#endif
 static struct workqueue_struct *workqueue;
 static struct work_struct work;
 
@@ -208,6 +211,7 @@ void sp_work_handle_request(void)
 
 	char *vcwd;
 	int size;
+	int index;
 
 	ret.retval = -1;
 
@@ -230,11 +234,16 @@ void sp_work_handle_request(void)
 		}
 	}
 
+#ifdef CONFIG_MIPS_CMP
+	index = cpu_idx;
+#else
+	index = tclimit;
+#endif
 	/* Run the syscall at the privilege of the user who loaded the
 	   SP program */
 
-	if (vpe_getuid(tclimit)) {
-		err = sp_setfsuidgid(vpe_getuid(tclimit), vpe_getgid(tclimit));
+	if (vpe_getuid(index)) {
+		err = sp_setfsuidgid(vpe_getuid(index), vpe_getgid(index));
 		if (!err)
 			pr_err("Change of creds failed\n");
 	}
@@ -256,7 +265,7 @@ void sp_work_handle_request(void)
 
  	case MTSP_SYSCALL_EXIT:
 		list_for_each_entry(n, &kspd_notifylist, list)
-			n->kspd_sp_exit(tclimit);
+			n->kspd_sp_exit(index);
 		sp_stopping = 1;
 
 		printk(KERN_DEBUG "KSPD got exit syscall from SP exitcode %d\n",
@@ -266,7 +275,7 @@ void sp_work_handle_request(void)
  	case MTSP_SYSCALL_OPEN:
  		generic.arg1 = translate_open_flags(generic.arg1);
 
-		vcwd = vpe_getcwd(tclimit);
+		vcwd = vpe_getcwd(index);
 
 		/* change to cwd of the process that loaded the SP program */
 		old_fs = get_fs();
@@ -294,7 +303,7 @@ void sp_work_handle_request(void)
 		break;
  	} /* switch */
 
-	if (vpe_getuid(tclimit)) {
+	if (vpe_getuid(index)) {
 		err = sp_setfsuidgid(0, 0);
 		if (!err)
 			pr_err("restoring old creds failed\n");
@@ -399,13 +408,18 @@ void kspd_notify(struct kspd_notifications *notify)
 }
 
 static struct vpe_notifications notify;
-static int kspd_module_init(void)
+static int __init kspd_module_init(void)
 {
 	INIT_LIST_HEAD(&kspd_notifylist);
 
 	notify.start = startwork;
 	notify.stop = stopwork;
+#ifdef CONFIG_MIPS_CMP
+	cpu_idx = setup_max_cpus;
+	vpe_notify(cpu_idx, &notify);
+#else
 	vpe_notify(tclimit, &notify);
+#endif
 
 	return 0;
 }
diff --git a/arch/mips/kernel/rtlx.c b/arch/mips/kernel/rtlx.c
index 9522aa5..7c02f02 100644
--- a/arch/mips/kernel/rtlx.c
+++ b/arch/mips/kernel/rtlx.c
@@ -54,17 +54,38 @@ static struct chan_waitqueues {
 
 static struct vpe_notifications notify;
 static int sp_stopping;
-static void (*save_aprp_dispatch)(void);
+static void (*save_aprp_hook)(void);
 
 extern void *vpe_get_shared(int index);
 
+#ifdef CONFIG_MIPS_CMP
+static int cpu_idx;
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
 	if (read_c0_cause() & read_c0_status() & C_SW0)
 		do_IRQ(MIPS_CPU_IRQ_BASE + MIPS_CPU_RTLX_IRQ);
 }
 
-
 /* Interrupt handler may be called before rtlx_init has otherwise had
    a chance to run.
 */
@@ -83,12 +104,13 @@ static irqreturn_t rtlx_interrupt(int irq, void *dev_id)
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
@@ -157,6 +179,7 @@ int rtlx_open(int index, int can_sleep)
 	struct rtlx_channel *chan;
 	enum rtlx_state state;
 	int ret = 0;
+	int cpu_index;
 
 	if (index >= RTLX_CHANNELS) {
 		printk(KERN_DEBUG "rtlx_open index out of range\n");
@@ -170,19 +193,27 @@ int rtlx_open(int index, int can_sleep)
 		goto out_fail;
 	}
 
+#ifdef CONFIG_MIPS_CMP
+	cpu_index = cpu_idx;
+#else
+	cpu_index = tclimit;
+#endif
+
 	if (rtlx == NULL) {
-		if( (p = vpe_get_shared(tclimit)) == NULL) {
-		    if (can_sleep) {
-			__wait_event_interruptible(channel_wqs[index].lx_queue,
-				(p = vpe_get_shared(tclimit)), ret);
-			if (ret)
+		p = vpe_get_shared(cpu_index);
+		if (p == NULL) {
+			if (can_sleep) {
+				__wait_event_interruptible(
+					channel_wqs[index].lx_queue,
+					(p = vpe_get_shared(cpu_index)), ret);
+				if (ret)
+					goto out_fail;
+			} else {
+				printk(KERN_DEBUG
+				       "No SP program loaded, and device opened with O_NONBLOCK\n");
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
@@ -345,6 +376,14 @@ out:
 	return count;
 }
 
+#ifdef CONFIG_MIPS_CMP
+static void _interrupt_sp(void)
+{
+	extern struct plat_smp_ops cmp_smp_ops;
+
+	cmp_smp_ops.send_ipi_single(cpu_idx, SMP_RESCHEDULE_YOURSELF);
+}
+#else
 static void _interrupt_sp(void)
 {
 	unsigned long flags;
@@ -356,6 +395,7 @@ static void _interrupt_sp(void)
 	evpe(EVPE_ENABLE);
 	local_irq_restore(flags);
 }
+#endif
 
 ssize_t rtlx_write(int index, const void __user *buffer, size_t count)
 {
@@ -486,6 +526,75 @@ static const struct file_operations rtlx_fops = {
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
+		printk(KERN_WARNING
+		       "VPE loader: not a MIPS MT capable processor\n");
+		return -ENODEV;
+	}
+
+	cpu_idx = setup_max_cpus;
+
+	if (num_possible_cpus() - cpu_idx < 1) {
+		printk(KERN_WARNING
+		       "No TCs reserved for AP/SP, not initializing RTLX.\n"
+		       "Pass maxcpus=<n> argument as kernel argument\n");
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
+		save_aprp_hook = aprp_hook;
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
@@ -493,23 +602,21 @@ static struct irqaction rtlx_irq = {
 
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
+		printk(KERN_WARNING
+		       "VPE loader: not a MIPS MT capable processor\n");
 		return -ENODEV;
 	}
 
 	if (tclimit == 0) {
-		printk(KERN_WARNING "No TCs reserved for AP/SP, not "
-		       "initializing RTLX.\nPass maxtcs=<n> argument as kernel "
-		       "argument\n");
+		printk(KERN_WARNING
+		       "No TCs reserved for AP/SP, not initializing RTLX.\n"
+		       "Pass maxtcs=<n> argument as kernel argument\n");
 
 		return -ENODEV;
 	}
@@ -546,8 +653,8 @@ static int __init rtlx_module_init(void)
 		 * gets set, a hw interrupt is signaled as well. Here we
 		 * are hooking it into platform specific dispatch.
 		 */
-		save_aprp_dispatch = aprp_dispatch;
-		aprp_dispatch = rtlx_dispatch;
+		save_aprp_hook = aprp_hook;
+		aprp_hook = rtlx_dispatch;
 	} else {
 		pr_err("APRP RTLX init on non-vectored-interrupt processor\n");
 		err = -ENODEV;
@@ -565,6 +672,7 @@ out_chrdev:
 
 	return err;
 }
+#endif
 
 static void __exit rtlx_module_exit(void)
 {
@@ -574,7 +682,7 @@ static void __exit rtlx_module_exit(void)
 		device_destroy(mt_class, MKDEV(major, i));
 
 	unregister_chrdev(major, module_name);
-	aprp_dispatch = save_aprp_dispatch;
+	aprp_hook = save_aprp_hook;
 }
 
 module_init(rtlx_module_init);
diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index b1f69f2..1ac3fd4 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -51,6 +51,10 @@
 #include <asm/processor.h>
 #include <asm/vpe.h>
 #include <asm/kspd.h>
+#ifdef CONFIG_MIPS_CMP
+#include <asm/amon.h>
+#include <asm/mips-boards/launch.h>
+#endif
 
 typedef void *vpe_handle;
 
@@ -64,7 +68,11 @@ typedef void *vpe_handle;
 /*
  * The number of TCs and VPEs physically available on the core
  */
+#ifdef CONFIG_MIPS_CMP
+static int cpu_idx;
+#else
 static int hw_tcs, hw_vpes;
+#endif
 static char module_name[] = "vpe";
 static int major;
 static const int minor = 1;	/* fixed for now  */
@@ -176,7 +184,7 @@ static struct vpe *get_vpe(int minor)
 }
 
 /* get the vpe associated with this minor */
-static struct tc *get_tc(int index)
+static __attribute__((__unused__)) struct tc *get_tc(int index)
 {
 	struct tc *res, *t;
 
@@ -681,6 +689,46 @@ static void dump_elfsymbols(Elf_Shdr * sechdrs, unsigned int symindex,
 }
 #endif
 
+#ifdef CONFIG_MIPS_CMP
+#ifdef CONFIG_MIPS_MALTA
+/* Borrowed from amon_cpu_start() in arch/mips/mti-malta/malta-amon.c */
+static int vpe_run(struct vpe *v)
+{
+	struct vpe_notifications *n;
+	volatile struct cpulaunch *launch =
+		(struct cpulaunch  *)CKSEG0ADDR(CPULAUNCH);
+
+	if (!amon_cpu_avail(cpu_idx))
+		return -1;
+	if (cpu_idx == smp_processor_id()) {
+		printk(KERN_WARNING "launch: I am cpu%d!\n", cpu_idx);
+		return -1;
+	}
+	launch += cpu_idx;
+
+	printk(KERN_INFO "launch: starting cpu%d\n", cpu_idx);
+
+	launch->pc = v->__start;
+	launch->gp = 0;
+	launch->sp = 0;
+	launch->a0 = 0;
+
+	smp_wmb();
+	launch->flags |= LAUNCH_FGO;
+	smp_wmb();
+
+	while ((launch->flags & LAUNCH_FGONE) == 0)
+		;
+	smp_rmb();
+	printk(KERN_INFO "launch: cpu%d gone!\n", cpu_idx);
+
+	list_for_each_entry(n, &v->notify, list)
+		n->start(minor);
+
+	return 0;
+}
+#endif
+#else
 /* We are prepared so configure and start the VPE... */
 static int vpe_run(struct vpe * v)
 {
@@ -810,6 +858,7 @@ static int vpe_run(struct vpe * v)
 
 	return 0;
 }
+#endif /* CONFIG_MIPS_CMP */
 
 static int find_vpe_symbols(struct vpe * v, Elf_Shdr * sechdrs,
 				      unsigned int symindex, const char *strtab,
@@ -1008,6 +1057,7 @@ static int vpe_elfload(struct vpe * v)
 	return 0;
 }
 
+#ifndef CONFIG_MIPS_CMP
 static void cleanup_tc(struct tc *tc)
 {
 	unsigned long flags;
@@ -1039,6 +1089,7 @@ static void cleanup_tc(struct tc *tc)
 	emt(mtflags);
 	local_irq_restore(flags);
 }
+#endif
 
 static int getcwd(char *buff, int size)
 {
@@ -1061,7 +1112,13 @@ static int vpe_open(struct inode *inode, struct file *filp)
 	enum vpe_state state;
 	struct vpe_notifications *not;
 	struct vpe *v;
-	int ret;
+	int ret, index;
+
+#ifdef CONFIG_MIPS_CMP
+	index = cpu_idx;
+#else
+	index = tclimit;
+#endif
 
 	if (minor != iminor(inode)) {
 		/* assume only 1 device at the moment. */
@@ -1070,7 +1127,8 @@ static int vpe_open(struct inode *inode, struct file *filp)
 		return -ENODEV;
 	}
 
-	if ((v = get_vpe(tclimit)) == NULL) {
+	v = get_vpe(index);
+	if (v == NULL) {
 		pr_warning("VPE loader: unable to get vpe\n");
 
 		return -ENODEV;
@@ -1081,11 +1139,13 @@ static int vpe_open(struct inode *inode, struct file *filp)
 		printk(KERN_DEBUG "VPE loader: tc in use dumping regs\n");
 
 		list_for_each_entry(not, &v->notify, list) {
-			not->stop(tclimit);
+			not->stop(index);
 		}
 
 		release_progmem(v->load_addr);
-		cleanup_tc(get_tc(tclimit));
+#ifndef CONFIG_MIPS_CMP
+		cleanup_tc(get_tc(index));
+#endif
 	}
 
 	/* this of-course trashes what was there before... */
@@ -1126,7 +1186,11 @@ static int vpe_release(struct inode *inode, struct file *filp)
 	Elf_Ehdr *hdr;
 	int ret = 0;
 
+#ifdef CONFIG_MIPS_CMP
+	v = get_vpe(cpu_idx);
+#else
 	v = get_vpe(tclimit);
+#endif
 	if (v == NULL)
 		return -ENODEV;
 
@@ -1166,7 +1230,11 @@ static ssize_t vpe_write(struct file *file, const char __user * buffer,
 	if (iminor(file->f_path.dentry->d_inode) != minor)
 		return -ENODEV;
 
+#ifdef CONFIG_MIPS_CMP
+	v = get_vpe(cpu_idx);
+#else
 	v = get_vpe(tclimit);
+#endif
 	if (v == NULL)
 		return -ENODEV;
 
@@ -1192,6 +1260,7 @@ static const struct file_operations vpe_fops = {
 	.llseek = noop_llseek,
 };
 
+#ifndef CONFIG_MIPS_CMP
 /* module wrapper entry points */
 /* give me a vpe */
 vpe_handle vpe_alloc(void)
@@ -1279,6 +1348,7 @@ int vpe_free(vpe_handle vpe)
 }
 
 EXPORT_SYMBOL(vpe_free);
+#endif /* CONFIG_MIPS_CMP */
 
 void *vpe_get_shared(int index)
 {
@@ -1341,8 +1411,59 @@ char *vpe_getcwd(int index)
 
 EXPORT_SYMBOL(vpe_getcwd);
 
+#ifdef CONFIG_MIPS_CMP
 #ifdef CONFIG_MIPS_APSP_KSPD
-static void kspd_sp_exit( int sp_id)
+static void kspd_sp_exit(int sp_id)
+{
+	/* Do nothing to the SP core. */
+}
+#endif
+
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
+#ifdef CONFIG_MIPS_APSP_KSPD
+static void kspd_sp_exit(int sp_id)
 {
 	cleanup_tc(get_tc(sp_id));
 }
@@ -1379,22 +1500,20 @@ static ssize_t store_ntcs(struct device *dev, struct device_attribute *attr,
 {
 	struct vpe *vpe = get_vpe(tclimit);
 	unsigned long new;
-	char *endp;
+	int ret;
 
-	new = simple_strtoul(buf, &endp, 0);
-	if (endp == buf)
-		goto out_einval;
+	ret = kstrtoul(buf, 0, &new);
+	if (ret < 0)
+		return ret;
 
 	if (new == 0 || new > (hw_tcs - tclimit))
-		goto out_einval;
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
@@ -1416,6 +1535,90 @@ struct class vpe_class = {
 
 struct device vpe_device;
 
+#ifdef CONFIG_MIPS_CMP
+static int __init vpe_module_init(void)
+{
+	struct vpe *v = NULL;
+	struct tc *t;
+	int err;
+
+	if (!cpu_has_mipsmt) {
+		printk(KERN_WARNING
+		       "VPE loader: not a MIPS MT capable processor\n");
+		return -ENODEV;
+	}
+
+	cpu_idx = setup_max_cpus;
+
+	if (num_possible_cpus() - cpu_idx < 1) {
+		printk(KERN_WARNING
+		       "No VPEs reserved for AP/SP, not initialize VPE loader\n"
+		       "Pass maxcpus=<n> argument as kernel argument\n");
+		return -ENODEV;
+	}
+
+	major = register_chrdev(0, module_name, &vpe_fops);
+	if (major < 0) {
+		printk(KERN_WARNING
+		       "VPE loader: unable to register character device\n");
+		return major;
+	}
+
+	err = class_register(&vpe_class);
+	if (err) {
+		printk(KERN_ERR "vpe_class registration failed\n");
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
+		printk(KERN_ERR "Adding vpe_device failed\n");
+		goto out_class;
+	}
+
+	t = alloc_tc(cpu_idx);
+	if (!t) {
+		printk(KERN_WARNING "VPE: unable to allocate TC\n");
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/* VPE */
+	v = alloc_vpe(cpu_idx);
+	if (v == NULL) {
+		printk(KERN_WARNING "VPE: unable to allocate VPE\n");
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
+#ifdef CONFIG_MIPS_APSP_KSPD
+	kspd_events.kspd_sp_exit = kspd_sp_exit;
+#endif
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
@@ -1425,29 +1628,31 @@ static int __init vpe_module_init(void)
 	int tc, err;
 
 	if (!cpu_has_mipsmt) {
-		printk("VPE loader: not a MIPS MT capable processor\n");
+		printk(KERN_WARNING
+		       "VPE loader: not a MIPS MT capable processor\n");
 		return -ENODEV;
 	}
 
 	if (vpelimit == 0) {
-		printk(KERN_WARNING "No VPEs reserved for AP/SP, not "
-		       "initializing VPE loader.\nPass maxvpes=<n> argument as "
-		       "kernel argument\n");
+		printk(KERN_WARNING
+		       "No VPEs reserved for AP/SP, not initialize VPE loader\n"
+		       "Pass maxvpes=<n> argument as kernel argument\n");
 
 		return -ENODEV;
 	}
 
 	if (tclimit == 0) {
-		printk(KERN_WARNING "No TCs reserved for AP/SP, not "
-		       "initializing VPE loader.\nPass maxtcs=<n> argument as "
-		       "kernel argument\n");
+		printk(KERN_WARNING
+		       "No TCs reserved for AP/SP, not initialize VPE loader\n"
+		       "Pass maxtcs=<n> argument as kernel argument\n");
 
 		return -ENODEV;
 	}
 
 	major = register_chrdev(0, module_name, &vpe_fops);
 	if (major < 0) {
-		printk("VPE loader: unable to register character device\n");
+		printk(KERN_WARNING
+		       "VPE loader: unable to register character device\n");
 		return major;
 	}
 
@@ -1505,7 +1710,8 @@ static int __init vpe_module_init(void)
 		if (tc < hw_tcs) {
 			settc(tc);
 
-			if ((v = alloc_vpe(tc)) == NULL) {
+			v = alloc_vpe(tc);
+			if (v == NULL) {
 				printk(KERN_WARNING "VPE: unable to allocate VPE\n");
 
 				goto out_reenable;
@@ -1598,6 +1804,7 @@ out_chrdev:
 out:
 	return err;
 }
+#endif /* CONFIG_MIPS_CMP */
 
 static void __exit vpe_module_exit(void)
 {
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index 62d77df..1a15fd6 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -119,12 +119,12 @@ static inline int get_int(void)
 }
 
 #ifdef CONFIG_MIPS_VPE_APSP_API
-static void null_aprp_dispatch(void)
+static void null_aprp_hook(void)
 {
 }
 
-void (*aprp_dispatch)(void);
-EXPORT_SYMBOL(aprp_dispatch);
+void (*aprp_hook)(void);
+EXPORT_SYMBOL(aprp_hook);
 #endif
 
 static void malta_hw0_irqdispatch(void)
@@ -139,13 +139,13 @@ static void malta_hw0_irqdispatch(void)
 
 	do_IRQ(MALTA_INT_BASE + irq);
 
-#ifdef CONFIG_MIPS_VPE_APSP_API
+#if defined(CONFIG_MIPS_VPE_APSP_API) && !defined(CONFIG_MIPS_CMP)
 	/*
 	 * When sw0 gets set, a spurious hw interrupt is signaled as well.
 	 * The sw0 will not be handled until the hw interrupt is cleared.
 	 * We use the hook to handle sw0 and the hw interrupt gets cleared.
 	 */
-	aprp_dispatch();
+	aprp_hook();
 #endif
 }
 
@@ -328,6 +328,10 @@ static void ipi_call_dispatch(void)
 
 static irqreturn_t ipi_resched_interrupt(int irq, void *dev_id)
 {
+#if defined(CONFIG_MIPS_VPE_APSP_API) && defined(CONFIG_MIPS_CMP)
+	aprp_hook();
+#endif
+
 	scheduler_ipi();
 
 	return IRQ_HANDLED;
@@ -640,7 +644,7 @@ void __init arch_init_irq(void)
 	}
 
 #ifdef CONFIG_MIPS_VPE_APSP_API
-	aprp_dispatch = null_aprp_dispatch;
+	aprp_hook = null_aprp_hook;
 #endif
 }
 
-- 
1.7.1
