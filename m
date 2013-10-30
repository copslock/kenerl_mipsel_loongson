Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Oct 2013 21:53:06 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:58371 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6829936Ab3J3UwZDpVcn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Oct 2013 21:52:25 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1VbckU-0001UG-FI; Wed, 30 Oct 2013 15:52:18 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>, ralf@linux-mips.org,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: [PATCH 3/6] MIPS: APRP: Split RTLX support into separate files.
Date:   Wed, 30 Oct 2013 15:52:08 -0500
Message-Id: <1383166331-9921-4-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1383166331-9921-1-git-send-email-Steven.Hill@imgtec.com>
References: <1383166331-9921-1-git-send-email-Steven.Hill@imgtec.com>
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

Split the RTLX functionality in preparation for adding support
for CMP platforms. Common functions remain in the original file
and a new file contains code specific to platforms that do not
have a CMP.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
Reviewed-by: Qais Yousef <Qais.Yousef@imgtec.com>
---
 arch/mips/Kconfig            |    5 ++
 arch/mips/include/asm/rtlx.h |   43 ++++++++----
 arch/mips/kernel/Makefile    |    1 +
 arch/mips/kernel/rtlx-mt.c   |  148 ++++++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/rtlx.c      |  143 ++++------------------------------------
 5 files changed, 196 insertions(+), 144 deletions(-)
 create mode 100644 arch/mips/kernel/rtlx-mt.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 4c5290e..5b7ce45 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1968,6 +1968,11 @@ config MIPS_VPE_APSP_API
 	depends on MIPS_VPE_LOADER
 	help
 
+config MIPS_VPE_APSP_API_MT
+	bool
+	default "y"
+	depends on MIPS_VPE_APSP_API && !MIPS_CMP
+
 config MIPS_CMP
 	bool "MIPS CMP framework support"
 	depends on SYS_SUPPORTS_MIPS_CMP
diff --git a/arch/mips/include/asm/rtlx.h b/arch/mips/include/asm/rtlx.h
index 90985b6..6766026 100644
--- a/arch/mips/include/asm/rtlx.h
+++ b/arch/mips/include/asm/rtlx.h
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2004, 2005 MIPS Technologies, Inc.  All rights reserved.
- *
+ * Copyright (C) 2013 Imagination Technologies Ltd.
  */
 
 #ifndef __ASM_RTLX_H_
@@ -8,6 +8,8 @@
 
 #include <irq.h>
 
+#define RTLX_MODULE_NAME "rtlx"
+
 #define LX_NODE_BASE 10
 
 #define MIPS_CPU_RTLX_IRQ 0
@@ -15,18 +17,31 @@
 #define RTLX_VERSION 2
 #define RTLX_xID 0x12345600
 #define RTLX_ID (RTLX_xID | RTLX_VERSION)
+#define RTLX_BUFFER_SIZE 2048
 #define RTLX_CHANNELS 8
 
 #define RTLX_CHANNEL_STDIO	0
 #define RTLX_CHANNEL_DBG	1
 #define RTLX_CHANNEL_SYSIO	2
 
-extern int rtlx_open(int index, int can_sleep);
-extern int rtlx_release(int index);
-extern ssize_t rtlx_read(int index, void __user *buff, size_t count);
-extern ssize_t rtlx_write(int index, const void __user *buffer, size_t count);
-extern unsigned int rtlx_read_poll(int index, int can_sleep);
-extern unsigned int rtlx_write_poll(int index);
+void rtlx_starting(int vpe);
+void rtlx_stopping(int vpe);
+
+int rtlx_open(int index, int can_sleep);
+int rtlx_release(int index);
+ssize_t rtlx_read(int index, void __user *buff, size_t count);
+ssize_t rtlx_write(int index, const void __user *buffer, size_t count);
+unsigned int rtlx_read_poll(int index, int can_sleep);
+unsigned int rtlx_write_poll(int index);
+
+int __init rtlx_module_init(void);
+void __exit rtlx_module_exit(void);
+
+void _interrupt_sp(void);
+
+extern struct vpe_notifications rtlx_notify;
+extern const struct file_operations rtlx_fops;
+extern void (*aprp_hook)(void);
 
 enum rtlx_state {
 	RTLX_STATE_UNUSED = 0,
@@ -35,10 +50,15 @@ enum rtlx_state {
 	RTLX_STATE_OPENED
 };
 
-#define RTLX_BUFFER_SIZE 2048
+extern struct chan_waitqueues {
+	wait_queue_head_t rt_queue;
+	wait_queue_head_t lx_queue;
+	atomic_t in_open;
+	struct mutex mutex;
+} channel_wqs[RTLX_CHANNELS];
 
 /* each channel supports read and write.
-   linux (vpe0) reads lx_buffer	 and writes rt_buffer
+   linux (vpe0) reads lx_buffer and writes rt_buffer
    SP (vpe1) reads rt_buffer and writes lx_buffer
 */
 struct rtlx_channel {
@@ -55,11 +75,10 @@ struct rtlx_channel {
 	char *lx_buffer;
 };
 
-struct rtlx_info {
+extern struct rtlx_info {
 	unsigned long id;
 	enum rtlx_state state;
 
 	struct rtlx_channel channel[RTLX_CHANNELS];
-};
-
+} *rtlx;
 #endif /* __ASM_RTLX_H_ */
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 7f538d1..85ee82e 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_MIPS_VPE_LOADER)	+= vpe.o
 obj-$(CONFIG_MIPS_VPE_LOADER_CMP) += vpe-cmp.o
 obj-$(CONFIG_MIPS_VPE_LOADER_MT) += vpe-mt.o
 obj-$(CONFIG_MIPS_VPE_APSP_API) += rtlx.o
+obj-$(CONFIG_MIPS_VPE_APSP_API_MT) += rtlx-mt.o
 
 obj-$(CONFIG_I8259)		+= i8259.o
 obj-$(CONFIG_IRQ_CPU)		+= irq_cpu.o
diff --git a/arch/mips/kernel/rtlx-mt.c b/arch/mips/kernel/rtlx-mt.c
new file mode 100644
index 0000000..91d61ba
--- /dev/null
+++ b/arch/mips/kernel/rtlx-mt.c
@@ -0,0 +1,148 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2005 MIPS Technologies, Inc.  All rights reserved.
+ * Copyright (C) 2013 Imagination Technologies Ltd.
+ */
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/err.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+
+#include <asm/mips_mt.h>
+#include <asm/vpe.h>
+#include <asm/rtlx.h>
+
+static int major;
+
+static void rtlx_dispatch(void)
+{
+	if (read_c0_cause() & read_c0_status() & C_SW0)
+		do_IRQ(MIPS_CPU_IRQ_BASE + MIPS_CPU_RTLX_IRQ);
+}
+
+/*
+ * Interrupt handler may be called before rtlx_init has otherwise had
+ * a chance to run.
+ */
+static irqreturn_t rtlx_interrupt(int irq, void *dev_id)
+{
+	unsigned int vpeflags;
+	unsigned long flags;
+	int i;
+
+	/* Ought not to be strictly necessary for SMTC builds */
+	local_irq_save(flags);
+	vpeflags = dvpe();
+	set_c0_status(0x100 << MIPS_CPU_RTLX_IRQ);
+	irq_enable_hazard();
+	evpe(vpeflags);
+	local_irq_restore(flags);
+
+	for (i = 0; i < RTLX_CHANNELS; i++) {
+		wake_up(&channel_wqs[i].lx_queue);
+		wake_up(&channel_wqs[i].rt_queue);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction rtlx_irq = {
+	.handler	= rtlx_interrupt,
+	.name		= "RTLX",
+};
+
+static int rtlx_irq_num = MIPS_CPU_IRQ_BASE + MIPS_CPU_RTLX_IRQ;
+
+void _interrupt_sp(void)
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
+
+int __init rtlx_module_init(void)
+{
+	struct device *dev;
+	int i, err;
+
+	if (!cpu_has_mipsmt) {
+		pr_warn("VPE loader: not a MIPS MT capable processor\n");
+		return -ENODEV;
+	}
+
+	if (aprp_cpu_index() == 0) {
+		pr_warn("No TCs reserved for AP/SP, not initializing RTLX.\n"
+			"Pass maxtcs=<n> argument as kernel argument\n");
+
+		return -ENODEV;
+	}
+
+	major = register_chrdev(0, RTLX_MODULE_NAME, &rtlx_fops);
+	if (major < 0) {
+		pr_err("rtlx_module_init: unable to register device\n");
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
+				    "%s%d", RTLX_MODULE_NAME, i);
+		if (IS_ERR(dev)) {
+			err = PTR_ERR(dev);
+			goto out_chrdev;
+		}
+	}
+
+	/* set up notifiers */
+	rtlx_notify.start = rtlx_starting;
+	rtlx_notify.stop = rtlx_stopping;
+	vpe_notify(aprp_cpu_index(), &rtlx_notify);
+
+	if (cpu_has_vint) {
+		aprp_hook = rtlx_dispatch;
+	} else {
+		pr_err("APRP RTLX init on non-vectored-interrupt processor\n");
+		err = -ENODEV;
+		goto out_class;
+	}
+
+	rtlx_irq.dev_id = rtlx;
+	err = setup_irq(rtlx_irq_num, &rtlx_irq);
+	if (err)
+		goto out_class;
+
+	return 0;
+
+out_class:
+	for (i = 0; i < RTLX_CHANNELS; i++)
+		device_destroy(mt_class, MKDEV(major, i));
+out_chrdev:
+	unregister_chrdev(major, RTLX_MODULE_NAME);
+
+	return err;
+}
+
+void __exit rtlx_module_exit(void)
+{
+	int i;
+
+	for (i = 0; i < RTLX_CHANNELS; i++)
+		device_destroy(mt_class, MKDEV(major, i));
+	unregister_chrdev(major, RTLX_MODULE_NAME);
+}
diff --git a/arch/mips/kernel/rtlx.c b/arch/mips/kernel/rtlx.c
index d763f11..cd78618 100644
--- a/arch/mips/kernel/rtlx.c
+++ b/arch/mips/kernel/rtlx.c
@@ -42,52 +42,12 @@
 #include <asm/rtlx.h>
 #include <asm/setup.h>
 
-static struct rtlx_info *rtlx;
-static int major;
-static char module_name[] = "rtlx";
-
-static struct chan_waitqueues {
-	wait_queue_head_t rt_queue;
-	wait_queue_head_t lx_queue;
-	atomic_t in_open;
-	struct mutex mutex;
-} channel_wqs[RTLX_CHANNELS];
-
-static struct vpe_notifications notify;
 static int sp_stopping;
-
-extern void *vpe_get_shared(int index);
-
-static void rtlx_dispatch(void)
-{
-	do_IRQ(MIPS_CPU_IRQ_BASE + MIPS_CPU_RTLX_IRQ);
-}
-
-
-/* Interrupt handler may be called before rtlx_init has otherwise had
-   a chance to run.
-*/
-static irqreturn_t rtlx_interrupt(int irq, void *dev_id)
-{
-	unsigned int vpeflags;
-	unsigned long flags;
-	int i;
-
-	/* Ought not to be strictly necessary for SMTC builds */
-	local_irq_save(flags);
-	vpeflags = dvpe();
-	set_c0_status(0x100 << MIPS_CPU_RTLX_IRQ);
-	irq_enable_hazard();
-	evpe(vpeflags);
-	local_irq_restore(flags);
-
-	for (i = 0; i < RTLX_CHANNELS; i++) {
-			wake_up(&channel_wqs[i].lx_queue);
-			wake_up(&channel_wqs[i].rt_queue);
-	}
-
-	return IRQ_HANDLED;
-}
+struct rtlx_info *rtlx;
+struct chan_waitqueues channel_wqs[RTLX_CHANNELS];
+struct vpe_notifications rtlx_notify;
+void (*aprp_hook)(void) = NULL;
+EXPORT_SYMBOL(aprp_hook);
 
 static void __used dump_rtlx(void)
 {
@@ -127,7 +87,7 @@ static int rtlx_init(struct rtlx_info *rtlxi)
 }
 
 /* notifications */
-static void starting(int vpe)
+void rtlx_starting(int vpe)
 {
 	int i;
 	sp_stopping = 0;
@@ -140,7 +100,7 @@ static void starting(int vpe)
 		wake_up_interruptible(&channel_wqs[i].lx_queue);
 }
 
-static void stopping(int vpe)
+void rtlx_stopping(int vpe)
 {
 	int i;
 
@@ -384,6 +344,8 @@ out:
 	smp_wmb();
 	mutex_unlock(&channel_wqs[index].mutex);
 
+	_interrupt_sp();
+
 	return count;
 }
 
@@ -455,7 +417,7 @@ static ssize_t file_write(struct file *file, const char __user * buffer,
 	return rtlx_write(minor, buffer, count);
 }
 
-static const struct file_operations rtlx_fops = {
+const struct file_operations rtlx_fops = {
 	.owner =   THIS_MODULE,
 	.open =	   file_open,
 	.release = file_release,
@@ -465,93 +427,10 @@ static const struct file_operations rtlx_fops = {
 	.llseek =  noop_llseek,
 };
 
-static struct irqaction rtlx_irq = {
-	.handler	= rtlx_interrupt,
-	.name		= "RTLX",
-};
-
-static int rtlx_irq_num = MIPS_CPU_IRQ_BASE + MIPS_CPU_RTLX_IRQ;
-
-static char register_chrdev_failed[] __initdata =
-	KERN_ERR "rtlx_module_init: unable to register device\n";
-
-static int __init rtlx_module_init(void)
-{
-	struct device *dev;
-	int i, err;
-
-	if (!cpu_has_mipsmt) {
-		printk("VPE loader: not a MIPS MT capable processor\n");
-		return -ENODEV;
-	}
-
-	if (tclimit == 0) {
-		printk(KERN_WARNING "No TCs reserved for AP/SP, not "
-		       "initializing RTLX.\nPass maxtcs=<n> argument as kernel "
-		       "argument\n");
-
-		return -ENODEV;
-	}
-
-	major = register_chrdev(0, module_name, &rtlx_fops);
-	if (major < 0) {
-		printk(register_chrdev_failed);
-		return major;
-	}
-
-	/* initialise the wait queues */
-	for (i = 0; i < RTLX_CHANNELS; i++) {
-		init_waitqueue_head(&channel_wqs[i].rt_queue);
-		init_waitqueue_head(&channel_wqs[i].lx_queue);
-		atomic_set(&channel_wqs[i].in_open, 0);
-		mutex_init(&channel_wqs[i].mutex);
-
-		dev = device_create(mt_class, NULL, MKDEV(major, i), NULL,
-				    "%s%d", module_name, i);
-		if (IS_ERR(dev)) {
-			err = PTR_ERR(dev);
-			goto out_chrdev;
-		}
-	}
-
-	/* set up notifiers */
-	notify.start = starting;
-	notify.stop = stopping;
-	vpe_notify(tclimit, &notify);
-
-	if (cpu_has_vint)
-		set_vi_handler(MIPS_CPU_RTLX_IRQ, rtlx_dispatch);
-	else {
-		pr_err("APRP RTLX init on non-vectored-interrupt processor\n");
-		err = -ENODEV;
-		goto out_chrdev;
-	}
-
-	rtlx_irq.dev_id = rtlx;
-	setup_irq(rtlx_irq_num, &rtlx_irq);
-
-	return 0;
-
-out_chrdev:
-	for (i = 0; i < RTLX_CHANNELS; i++)
-		device_destroy(mt_class, MKDEV(major, i));
-
-	return err;
-}
-
-static void __exit rtlx_module_exit(void)
-{
-	int i;
-
-	for (i = 0; i < RTLX_CHANNELS; i++)
-		device_destroy(mt_class, MKDEV(major, i));
-
-	unregister_chrdev(major, module_name);
-}
-
 module_init(rtlx_module_init);
 module_exit(rtlx_module_exit);
 
 MODULE_DESCRIPTION("MIPS RTLX");
 MODULE_AUTHOR("Elizabeth Oldham, MIPS Technologies, Inc.");
 MODULE_LICENSE("GPL");
+
-- 
1.7.9.5
