Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2010 07:07:32 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:35141 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490991Ab0JTFHD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Oct 2010 07:07:03 +0200
Received: by mail-yw0-f49.google.com with SMTP id 6so1924472ywp.36
        for <multiple recipients>; Tue, 19 Oct 2010 22:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=K5YNFQ/ClCO3ttY0N7UZENynfI/YZOJ68H2XoyNt5/I=;
        b=OZ6E/TmoeMNXcAVhizdM7ZYxipkGmJnk/hnc2cNdMpEym/rmvsL3o3U6OA26DKoony
         +s0zNqEOJPwuyXFEkiOVQmWjo2gnO/UR1NaWbyZ2URD6slBAhjVFG0VYUidxtqp09kYK
         Z+1yM4v7MZVpDlbNyI8f8dySLr+dSBI9HSRKk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OdxOSgmayRsb/RVuUqjw0MqFAtGpjhUNCXszHjQWx0RRdcMBYlvUBlCI3je9kPCExO
         7K/51CRphwu354vPxKZni9okXC51ZA1AjhTUP/T2f0suxjF0juC1XKFZNpK65OuQVn02
         Z/vT+Q6EdTnDV3tu65YZ1hA0nvIHbiACWFWd0=
Received: by 10.151.83.16 with SMTP id k16mr468994ybl.239.1287551222185;
        Tue, 19 Oct 2010 22:07:02 -0700 (PDT)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id v12sm886191ybk.11.2010.10.19.22.06.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 22:07:01 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kevink@paralogos.com
Cc:     eyal@mips.com, dengcheng.zhu@gmail.com
Subject: [PATCH 2/2] MIPS: enable CPS multicore APRP (APSP)
Date:   Wed, 20 Oct 2010 13:10:31 +0800
Message-Id: <1287551431-15737-3-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1287551431-15737-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1287551431-15737-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28167
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

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

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/include/asm/rtlx.h    |    3 +
 arch/mips/kernel/kspd.c         |   26 ++++-
 arch/mips/kernel/rtlx.c         |  129 +++++++++++++++++++++---
 arch/mips/kernel/vpe.c          |  213 ++++++++++++++++++++++++++++++++++++++-
 arch/mips/mti-malta/malta-int.c |   14 ++-
 5 files changed, 356 insertions(+), 29 deletions(-)

diff --git a/arch/mips/include/asm/rtlx.h b/arch/mips/include/asm/rtlx.h
index 4ca3063..adddffe 100644
--- a/arch/mips/include/asm/rtlx.h
+++ b/arch/mips/include/asm/rtlx.h
@@ -58,6 +58,9 @@ struct rtlx_channel {
 struct rtlx_info {
 	unsigned long id;
 	enum rtlx_state state;
+#ifdef CONFIG_MIPS_CMP
+	int ap_int_pending;
+#endif
 
 	struct rtlx_channel channel[RTLX_CHANNELS];
 };
diff --git a/arch/mips/kernel/kspd.c b/arch/mips/kernel/kspd.c
index 29811f0..c76a5d9 100644
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
index 1c2e156..308190e 100644
--- a/arch/mips/kernel/rtlx.c
+++ b/arch/mips/kernel/rtlx.c
@@ -56,18 +56,39 @@ static struct chan_waitqueues {
 
 static struct vpe_notifications notify;
 static int sp_stopping;
-static void (*save_aprp_dispatch)(void);
+static void (*save_aprp_hook)(void);
 
 extern void *vpe_get_shared(int index);
-extern void (*aprp_dispatch)(void);
+extern void (*aprp_hook)(void);
 
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
@@ -86,12 +107,13 @@ static irqreturn_t rtlx_interrupt(int irq, void *dev_id)
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
@@ -160,6 +182,7 @@ int rtlx_open(int index, int can_sleep)
 	struct rtlx_channel *chan;
 	enum rtlx_state state;
 	int ret = 0;
+	int cpu_index;
 
 	if (index >= RTLX_CHANNELS) {
 		printk(KERN_DEBUG "rtlx_open index out of range\n");
@@ -173,11 +196,17 @@ int rtlx_open(int index, int can_sleep)
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
+		if( (p = vpe_get_shared(cpu_index)) == NULL) {
 		    if (can_sleep) {
 			__wait_event_interruptible(channel_wqs[index].lx_queue,
-				(p = vpe_get_shared(tclimit)), ret);
+				(p = vpe_get_shared(cpu_index)), ret);
 			if (ret)
 				goto out_fail;
 		    } else {
@@ -348,6 +377,12 @@ out:
 	return count;
 }
 
+#ifdef CONFIG_MIPS_CMP
+static void _interrupt_sp(void)
+{
+	cmp_send_ipi_single(cpu_idx, SMP_RESCHEDULE_YOURSELF);
+}
+#else
 static void _interrupt_sp(void)
 {
 	unsigned long flags;
@@ -359,6 +394,7 @@ static void _interrupt_sp(void)
 	evpe(EVPE_ENABLE);
 	local_irq_restore(flags);
 }
+#endif
 
 ssize_t rtlx_write(int index, const void __user *buffer, size_t count)
 {
@@ -488,6 +524,75 @@ static const struct file_operations rtlx_fops = {
 	.poll =    file_poll
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
+		printk("VPE loader: not a MIPS MT capable processor\n");
+		return -ENODEV;
+	}
+
+	cpu_idx = setup_max_cpus;
+
+	if (num_possible_cpus() - cpu_idx < 1) {
+		printk(KERN_WARNING "No TCs reserved for AP/SP, not "
+		       "initializing RTLX.\nPass maxcpus=<n> argument as kernel "
+		       "argument\n");
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
+	}
+	else {
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
 	.flags		= IRQF_DISABLED,
@@ -496,9 +601,6 @@ static struct irqaction rtlx_irq = {
 
 static int rtlx_irq_num = MIPS_CPU_IRQ_BASE + MIPS_CPU_RTLX_IRQ;
 
-static char register_chrdev_failed[] __initdata =
-	KERN_ERR "rtlx_module_init: unable to register device\n";
-
 static int __init rtlx_module_init(void)
 {
 	struct device *dev;
@@ -549,8 +651,8 @@ static int __init rtlx_module_init(void)
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
@@ -568,6 +670,7 @@ out_chrdev:
 
 	return err;
 }
+#endif
 
 static void __exit rtlx_module_exit(void)
 {
@@ -577,7 +680,7 @@ static void __exit rtlx_module_exit(void)
 		device_destroy(mt_class, MKDEV(major, i));
 
 	unregister_chrdev(major, module_name);
-	aprp_dispatch = save_aprp_dispatch;
+	aprp_hook = save_aprp_hook;
 }
 
 module_init(rtlx_module_init);
diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index d0e757a..b2e8640 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -53,6 +53,10 @@
 #include <asm/system.h>
 #include <asm/vpe.h>
 #include <asm/kspd.h>
+#ifdef CONFIG_MIPS_CMP
+#include <asm/amon.h>
+#include <asm/mips-boards/launch.h>
+#endif
 
 typedef void *vpe_handle;
 
@@ -66,7 +70,11 @@ typedef void *vpe_handle;
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
@@ -178,7 +186,7 @@ static struct vpe *get_vpe(int minor)
 }
 
 /* get the vpe associated with this minor */
-static struct tc *get_tc(int index)
+static __attribute__((__unused__)) struct tc *get_tc(int index)
 {
 	struct tc *res, *t;
 
@@ -683,6 +691,43 @@ static void dump_elfsymbols(Elf_Shdr * sechdrs, unsigned int symindex,
 }
 #endif
 
+#ifdef CONFIG_MIPS_CMP
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
+#else
 /* We are prepared so configure and start the VPE... */
 static int vpe_run(struct vpe * v)
 {
@@ -812,6 +857,7 @@ static int vpe_run(struct vpe * v)
 
 	return 0;
 }
+#endif /* CONFIG_MIPS_CMP */
 
 static int find_vpe_symbols(struct vpe * v, Elf_Shdr * sechdrs,
 				      unsigned int symindex, const char *strtab,
@@ -1010,6 +1056,7 @@ static int vpe_elfload(struct vpe * v)
 	return 0;
 }
 
+#ifndef CONFIG_MIPS_CMP
 static void cleanup_tc(struct tc *tc)
 {
 	unsigned long flags;
@@ -1041,6 +1088,7 @@ static void cleanup_tc(struct tc *tc)
 	emt(mtflags);
 	local_irq_restore(flags);
 }
+#endif
 
 static int getcwd(char *buff, int size)
 {
@@ -1063,7 +1111,13 @@ static int vpe_open(struct inode *inode, struct file *filp)
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
@@ -1072,7 +1126,7 @@ static int vpe_open(struct inode *inode, struct file *filp)
 		return -ENODEV;
 	}
 
-	if ((v = get_vpe(tclimit)) == NULL) {
+	if ((v = get_vpe(index)) == NULL) {
 		pr_warning("VPE loader: unable to get vpe\n");
 
 		return -ENODEV;
@@ -1083,11 +1137,13 @@ static int vpe_open(struct inode *inode, struct file *filp)
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
@@ -1124,7 +1180,11 @@ static int vpe_release(struct inode *inode, struct file *filp)
 	Elf_Ehdr *hdr;
 	int ret = 0;
 
+#ifdef CONFIG_MIPS_CMP
+	v = get_vpe(cpu_idx);
+#else
 	v = get_vpe(tclimit);
+#endif
 	if (v == NULL)
 		return -ENODEV;
 
@@ -1165,7 +1225,11 @@ static ssize_t vpe_write(struct file *file, const char __user * buffer,
 	if (iminor(file->f_path.dentry->d_inode) != minor)
 		return -ENODEV;
 
+#ifdef CONFIG_MIPS_CMP
+	v = get_vpe(cpu_idx);
+#else
 	v = get_vpe(tclimit);
+#endif
 	if (v == NULL)
 		return -ENODEV;
 
@@ -1195,6 +1259,7 @@ static const struct file_operations vpe_fops = {
 	.write = vpe_write
 };
 
+#ifndef CONFIG_MIPS_CMP
 /* module wrapper entry points */
 /* give me a vpe */
 vpe_handle vpe_alloc(void)
@@ -1282,6 +1347,7 @@ int vpe_free(vpe_handle vpe)
 }
 
 EXPORT_SYMBOL(vpe_free);
+#endif /* CONFIG_MIPS_CMP */
 
 void *vpe_get_shared(int index)
 {
@@ -1344,6 +1410,60 @@ char *vpe_getcwd(int index)
 
 EXPORT_SYMBOL(vpe_getcwd);
 
+#ifdef CONFIG_MIPS_CMP
+#ifdef CONFIG_MIPS_APSP_KSPD
+static void kspd_sp_exit( int sp_id)
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
+	char *endp;
+
+	new = simple_strtoul(buf, &endp, 0);
+	if (endp == buf)
+		goto out_einval;
+
+	if (new != 1)
+		goto out_einval;
+
+	vpe->ntcs = new;
+
+	return len;
+
+out_einval:
+	return -EINVAL;
+}
+#else
 #ifdef CONFIG_MIPS_APSP_KSPD
 static void kspd_sp_exit( int sp_id)
 {
@@ -1398,6 +1518,7 @@ static ssize_t store_ntcs(struct device *dev, struct device_attribute *attr,
 out_einval:
 	return -EINVAL;
 }
+#endif /* CONFIG_MIPS_CMP */
 
 static struct device_attribute vpe_class_attributes[] = {
 	__ATTR(kill, S_IWUSR, NULL, store_kill),
@@ -1419,6 +1540,87 @@ struct class vpe_class = {
 
 struct device vpe_device;
 
+#ifdef CONFIG_MIPS_CMP
+static int __init vpe_module_init(void)
+{
+	struct vpe *v = NULL;
+	struct tc *t;
+	int err;
+
+	if (!cpu_has_mipsmt) {
+		printk("VPE loader: not a MIPS MT capable processor\n");
+		return -ENODEV;
+	}
+
+	cpu_idx = setup_max_cpus;
+
+	if (num_possible_cpus() - cpu_idx < 1) {
+		printk (KERN_WARNING "No VPEs reserved for AP/SP in "
+				"CPS, not initializing VPE loader.\nPass maxcpus=<n> "
+				"argument as kernel argument\n");
+		return -ENODEV;
+	}
+
+	major = register_chrdev(0, module_name, &vpe_fops);
+	if (major < 0) {
+		printk("VPE loader: unable to register character device\n");
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
+	if ((v = alloc_vpe(cpu_idx)) == NULL) {
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
@@ -1601,6 +1803,7 @@ out_chrdev:
 out:
 	return err;
 }
+#endif /* CONFIG_MIPS_CMP */
 
 static void __exit vpe_module_exit(void)
 {
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index 0fec7b2..2f44421 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -119,13 +119,13 @@ static inline int get_int(void)
 }
 
 #ifdef CONFIG_MIPS_VPE_APSP_API
-static void null_aprp_dispatch(void)
+static void null_aprp_hook(void)
 {
 }
 
-void (*aprp_dispatch)(void) = null_aprp_dispatch;
+void (*aprp_hook)(void) = null_aprp_hook;
 
-EXPORT_SYMBOL(aprp_dispatch);
+EXPORT_SYMBOL(aprp_hook);
 #endif
 
 static void malta_hw0_irqdispatch(void)
@@ -140,13 +140,13 @@ static void malta_hw0_irqdispatch(void)
 
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
 
@@ -329,6 +329,10 @@ static void ipi_call_dispatch(void)
 
 static irqreturn_t ipi_resched_interrupt(int irq, void *dev_id)
 {
+#if defined(CONFIG_MIPS_VPE_APSP_API) && defined(CONFIG_MIPS_CMP)
+	aprp_hook();
+#endif
+
 	return IRQ_HANDLED;
 }
 
-- 
1.7.0.4
