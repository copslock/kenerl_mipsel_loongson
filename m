Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jan 2013 19:06:35 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:44303 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823003Ab3AGSF4HkSBQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Jan 2013 19:05:56 +0100
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id r07I5mZQ030382;
        Mon, 7 Jan 2013 10:05:49 -0800
X-WSS-ID: 0MG9OXL-01-2WG-02
X-M-MSG: 
Received: from exchdb01.mips.com (unknown [192.168.36.84])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mailgate1.mips.com (Postfix) with ESMTP id 2861536465B;
        Mon,  7 Jan 2013 10:05:45 -0800 (PST)
Received: from fun-lab.mips.com (192.168.52.61) by exchhub01.mips.com
 (192.168.36.84) with Microsoft SMTP Server id 14.2.247.3; Mon, 7 Jan 2013
 10:05:41 -0800
From:   Deng-Cheng Zhu <dczhu@mips.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <kevink@paralogos.com>, <macro@linux-mips.org>, <john@phrozen.org>
CC:     <sjhill@mips.com>, <dczhu@mips.com>
Subject: [RESEND PATCH v3 2/5] MIPS: APRP (APSP): split vpe-loader and rtlx into cmp/mt flavors
Date:   Mon, 7 Jan 2013 10:05:11 -0800
Message-ID: <1357581914-4589-3-git-send-email-dczhu@mips.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1357581914-4589-1-git-send-email-dczhu@mips.com>
References: <1357581914-4589-1-git-send-email-dczhu@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EMS-Proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
X-EMS-STAMP: Rhr5b82P/a0f4fVz8kRsBg==
X-archive-position: 35386
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

Remove CONFIG_MIPS_CMP #ifdef's by using -cmp/-mt files. Coding style
adjustments are made as well.

Cc: Steven J. Hill <sjhill@mips.com>
Signed-off-by: Deng-Cheng Zhu <dczhu@mips.com>
---
 arch/mips/include/asm/rtlx.h |   40 ++-
 arch/mips/include/asm/vpe.h  |  118 ++++++-
 arch/mips/kernel/Makefile    |    9 +-
 arch/mips/kernel/rtlx-cmp.c  |  125 ++++++
 arch/mips/kernel/rtlx-mt.c   |  160 ++++++++
 arch/mips/kernel/rtlx.c      |  285 ++-------------
 arch/mips/kernel/vpe-cmp.c   |  185 +++++++++
 arch/mips/kernel/vpe-mt.c    |  534 ++++++++++++++++++++++++++
 arch/mips/kernel/vpe.c       |  873 +++---------------------------------------
 9 files changed, 1238 insertions(+), 1091 deletions(-)
 create mode 100644 arch/mips/kernel/rtlx-cmp.c
 create mode 100644 arch/mips/kernel/rtlx-mt.c
 create mode 100644 arch/mips/kernel/vpe-cmp.c
 create mode 100644 arch/mips/kernel/vpe-mt.c

diff --git a/arch/mips/include/asm/rtlx.h b/arch/mips/include/asm/rtlx.h
index 478349e..4f27eab 100644
--- a/arch/mips/include/asm/rtlx.h
+++ b/arch/mips/include/asm/rtlx.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2004, 2005 MIPS Technologies, Inc.  All rights reserved.
+ * Copyright (C) 2004, 2005, 2012 MIPS Technologies, Inc.  All rights reserved.
  *
  */
 
@@ -8,6 +8,8 @@
 
 #include <irq.h>
 
+#define RTLX_MODULE_NAME "rtlx"
+
 #define LX_NODE_BASE 10
 
 #define MIPS_CPU_RTLX_IRQ 0
@@ -15,19 +17,31 @@
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
 
+void _interrupt_sp(void);
+
+extern struct vpe_notifications rtlx_notify;
+extern const struct file_operations rtlx_fops;
+static inline void null_aprp_hook(void) { }
 extern void (*aprp_hook)(void);
 
 enum rtlx_state {
@@ -37,7 +51,12 @@ enum rtlx_state {
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
    linux (vpe0) reads lx_buffer  and writes rt_buffer
@@ -57,7 +76,7 @@ struct rtlx_channel {
 	char *lx_buffer;
 };
 
-struct rtlx_info {
+extern struct rtlx_info {
 	unsigned long id;
 	enum rtlx_state state;
 #ifdef CONFIG_MIPS_CMP
@@ -65,6 +84,5 @@ struct rtlx_info {
 #endif
 
 	struct rtlx_channel channel[RTLX_CHANNELS];
-};
-
+} *rtlx;
 #endif /* __ASM_RTLX_H_ */
diff --git a/arch/mips/include/asm/vpe.h b/arch/mips/include/asm/vpe.h
index c6e1b96..4cfc4fd 100644
--- a/arch/mips/include/asm/vpe.h
+++ b/arch/mips/include/asm/vpe.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2005 MIPS Technologies, Inc.  All rights reserved.
+ * Copyright (C) 2005, 2012 MIPS Technologies, Inc.  All rights reserved.
  *
  *  This program is free software; you can distribute it and/or modify it
  *  under the terms of the GNU General Public License (Version 2) as
@@ -19,6 +19,88 @@
 #ifndef _ASM_VPE_H
 #define _ASM_VPE_H
 
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+
+#define VPE_MODULE_NAME "vpe"
+#define VPE_MODULE_MINOR 1
+
+/* grab the likely amount of memory we will need. */
+#ifdef CONFIG_MIPS_VPE_LOADER_TOM
+#define P_SIZE (2 * 1024 * 1024)
+#else
+/* add an overhead to the max kmalloc size for non-striped symbols/etc */
+#define P_SIZE (256 * 1024)
+#endif
+
+#define MAX_VPES 16
+#define VPE_PATH_MAX 256
+
+static inline int aprp_cpu_index(void)
+{
+#ifdef CONFIG_MIPS_CMP
+	return setup_max_cpus;
+#else
+	extern int tclimit;
+	return tclimit;
+#endif
+}
+
+enum vpe_state {
+	VPE_STATE_UNUSED = 0,
+	VPE_STATE_INUSE,
+	VPE_STATE_RUNNING
+};
+
+enum tc_state {
+	TC_STATE_UNUSED = 0,
+	TC_STATE_INUSE,
+	TC_STATE_RUNNING,
+	TC_STATE_DYNAMIC
+};
+
+struct vpe {
+	enum vpe_state state;
+
+	/* (device) minor associated with this vpe */
+	int minor;
+
+	/* elfloader stuff */
+	void *load_addr;
+	unsigned long len;
+	char *pbuffer;
+	unsigned long plen;
+	unsigned int uid, gid;
+	char cwd[VPE_PATH_MAX];
+
+	unsigned long __start;
+
+	/* tc's associated with this vpe */
+	struct list_head tc;
+
+	/* The list of vpe's */
+	struct list_head list;
+
+	/* shared symbol address */
+	void *shared_ptr;
+
+	/* the list of who wants to know when something major happens */
+	struct list_head notify;
+
+	unsigned int ntcs;
+};
+
+struct tc {
+	enum tc_state state;
+	int index;
+
+	struct vpe *pvpe;	/* parent VPE */
+	struct list_head tc;	/* The list of TC's with this VPE */
+	struct list_head list;	/* The global list of tc's */
+};
+
 struct vpe_notifications {
 	void (*start)(int vpe);
 	void (*stop)(int vpe);
@@ -26,12 +108,36 @@ struct vpe_notifications {
 	struct list_head list;
 };
 
+struct vpe_control {
+	spinlock_t vpe_list_lock;
+	struct list_head vpe_list;      /* Virtual processing elements */
+	spinlock_t tc_list_lock;
+	struct list_head tc_list;       /* Thread contexts */
+};
+
+extern unsigned long physical_memsize;
+extern struct vpe_control vpecontrol;
+extern const struct file_operations vpe_fops;
+
+int vpe_notify(int index, struct vpe_notifications *notify);
+
+void *vpe_get_shared(int index);
+int vpe_getuid(int index);
+int vpe_getgid(int index);
+char *vpe_getcwd(int index);
+
+struct vpe *get_vpe(int minor);
+struct tc *get_tc(int index);
+struct vpe *alloc_vpe(int minor);
+struct tc *alloc_tc(int index);
+void release_vpe(struct vpe *v);
 
-extern int vpe_notify(int index, struct vpe_notifications *notify);
+void *alloc_progmem(unsigned long len);
+void release_progmem(void *ptr);
 
-extern void *vpe_get_shared(int index);
-extern int vpe_getuid(int index);
-extern int vpe_getgid(int index);
-extern char *vpe_getcwd(int index);
+int vpe_run(struct vpe *v);
+void cleanup_tc(struct tc *tc);
 
+int __init vpe_module_init(void);
+void __exit vpe_module_exit(void);
 #endif /* _ASM_VPE_H */
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 8b28bc4..16f581a 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -52,8 +52,13 @@ obj-$(CONFIG_MIPS_MT_SMP)	+= smp-mt.o
 obj-$(CONFIG_MIPS_CMP)		+= smp-cmp.o
 obj-$(CONFIG_CPU_MIPSR2)	+= spram.o
 
-obj-$(CONFIG_MIPS_VPE_LOADER)	+= vpe.o
-obj-$(CONFIG_MIPS_VPE_APSP_API)	+= rtlx.o
+ifdef CONFIG_MIPS_CMP
+obj-$(CONFIG_MIPS_VPE_LOADER)	+= vpe.o vpe-cmp.o
+obj-$(CONFIG_MIPS_VPE_APSP_API)	+= rtlx.o rtlx-cmp.o
+else
+obj-$(CONFIG_MIPS_VPE_LOADER)	+= vpe.o vpe-mt.o
+obj-$(CONFIG_MIPS_VPE_APSP_API)	+= rtlx.o rtlx-mt.o
+endif
 
 obj-$(CONFIG_I8259)		+= i8259.o
 obj-$(CONFIG_IRQ_CPU)		+= irq_cpu.o
diff --git a/arch/mips/kernel/rtlx-cmp.c b/arch/mips/kernel/rtlx-cmp.c
new file mode 100644
index 0000000..61d848b
--- /dev/null
+++ b/arch/mips/kernel/rtlx-cmp.c
@@ -0,0 +1,125 @@
+/*
+ * Copyright (C) 2005, 2012 MIPS Technologies, Inc.  All rights reserved.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ */
+
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/err.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
+
+#include <asm/smp.h>
+#include <asm/mips_mt.h>
+#include <asm/vpe.h>
+#include <asm/rtlx.h>
+
+static int major;
+
+static void rtlx_interrupt(void)
+{
+	int i;
+	struct rtlx_info *info;
+	struct rtlx_info **p = vpe_get_shared(aprp_cpu_index());
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
+
+void _interrupt_sp(void)
+{
+	smp_send_reschedule(aprp_cpu_index());
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
+	if (num_possible_cpus() - aprp_cpu_index() < 1) {
+		pr_warn("No TCs reserved for AP/SP, not initializing RTLX.\n"
+			"Pass maxcpus=<n> argument as kernel argument\n");
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
+
+void __exit rtlx_module_exit(void)
+{
+	int i;
+
+	for (i = 0; i < RTLX_CHANNELS; i++)
+		device_destroy(mt_class, MKDEV(major, i));
+
+	unregister_chrdev(major, RTLX_MODULE_NAME);
+	aprp_hook = null_aprp_hook;
+}
diff --git a/arch/mips/kernel/rtlx-mt.c b/arch/mips/kernel/rtlx-mt.c
new file mode 100644
index 0000000..679480a
--- /dev/null
+++ b/arch/mips/kernel/rtlx-mt.c
@@ -0,0 +1,160 @@
+/*
+ * Copyright (C) 2005, 2012 MIPS Technologies, Inc.  All rights reserved.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ */
+
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
+		/*
+		 * set_vi_handler() doesn't work in some cases: When sw0
+		 * gets set, a hw interrupt is signaled as well. Here we
+		 * are hooking it into platform specific dispatch.
+		 */
+		aprp_hook = rtlx_dispatch;
+	} else {
+		pr_err("APRP RTLX init on non-vectored-interrupt processor\n");
+		err = -ENODEV;
+		goto out_chrdev;
+	}
+
+	rtlx_irq.dev_id = rtlx;
+	setup_irq(rtlx_irq_num, &rtlx_irq);
+
+	return 0;
+
+out_chrdev:
+	for (i = 0; i < RTLX_CHANNELS; i++)
+		device_destroy(mt_class, MKDEV(major, i));
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
+
+	unregister_chrdev(major, RTLX_MODULE_NAME);
+	aprp_hook = null_aprp_hook;
+}
diff --git a/arch/mips/kernel/rtlx.c b/arch/mips/kernel/rtlx.c
index eeda8a2..287e244 100644
--- a/arch/mips/kernel/rtlx.c
+++ b/arch/mips/kernel/rtlx.c
@@ -36,105 +36,39 @@
 #include <asm/mips_mt.h>
 #include <asm/cacheflush.h>
 #include <linux/atomic.h>
-#include <asm/smp.h>
 #include <asm/cpu.h>
 #include <asm/processor.h>
 #include <asm/vpe.h>
 #include <asm/rtlx.h>
 
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
-static int cpu_idx;
-static void null_aprp_hook(void) {};
-
-void (*aprp_hook)(void) = null_aprp_hook;
-
-extern void *vpe_get_shared(int index);
-
-#ifdef CONFIG_MIPS_CMP
-static void rtlx_interrupt(void)
-{
-	int i;
-	struct rtlx_info *info;
-	struct rtlx_info **p = vpe_get_shared(cpu_idx);
-
-	if (p == NULL || *p == NULL)
-		return;
-
-	info = *p;
 
-	if (info->ap_int_pending == 1 && smp_processor_id() == 0) {
-		for (i = 0; i < RTLX_CHANNELS; i++) {
-			wake_up(&channel_wqs[i].lx_queue);
-			wake_up(&channel_wqs[i].rt_queue);
-		}
-		info->ap_int_pending = 0;
-	}
-}
-#else
-static void rtlx_dispatch(void)
-{
-	if (read_c0_cause() & read_c0_status() & C_SW0)
-		do_IRQ(MIPS_CPU_IRQ_BASE + MIPS_CPU_RTLX_IRQ);
-}
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
-		wake_up(&channel_wqs[i].lx_queue);
-		wake_up(&channel_wqs[i].rt_queue);
-	}
-
-	return IRQ_HANDLED;
-}
-#endif
+struct rtlx_info *rtlx;
+struct chan_waitqueues channel_wqs[RTLX_CHANNELS];
+struct vpe_notifications rtlx_notify;
+void (*aprp_hook)(void);
+EXPORT_SYMBOL(aprp_hook);
 
 static void __used dump_rtlx(void)
 {
 	int i;
 
-	printk("id 0x%lx state %d\n", rtlx->id, rtlx->state);
+	pr_debug("id 0x%lx state %d\n", rtlx->id, rtlx->state);
 
 	for (i = 0; i < RTLX_CHANNELS; i++) {
 		struct rtlx_channel *chan = &rtlx->channel[i];
 
-		printk(" rt_state %d lx_state %d buffer_size %d\n",
+		pr_debug(" rt_state %d lx_state %d buffer_size %d\n",
 		       chan->rt_state, chan->lx_state, chan->buffer_size);
 
-		printk(" rt_read %d rt_write %d\n",
+		pr_debug(" rt_read %d rt_write %d\n",
 		       chan->rt_read, chan->rt_write);
 
-		printk(" lx_read %d lx_write %d\n",
+		pr_debug(" lx_read %d lx_write %d\n",
 		       chan->lx_read, chan->lx_write);
 
-		printk(" rt_buffer <%s>\n", chan->rt_buffer);
-		printk(" lx_buffer <%s>\n", chan->lx_buffer);
+		pr_debug(" rt_buffer <%s>\n", chan->rt_buffer);
+		pr_debug(" lx_buffer <%s>\n", chan->lx_buffer);
 	}
 }
 
@@ -152,7 +86,7 @@ static int rtlx_init(struct rtlx_info *rtlxi)
 }
 
 /* notifications */
-static void starting(int vpe)
+void rtlx_starting(int vpe)
 {
 	int i;
 	sp_stopping = 0;
@@ -165,7 +99,7 @@ static void starting(int vpe)
 		wake_up_interruptible(&channel_wqs[i].lx_queue);
 }
 
-static void stopping(int vpe)
+void rtlx_stopping(int vpe)
 {
 	int i;
 
@@ -194,12 +128,13 @@ int rtlx_open(int index, int can_sleep)
 	}
 
 	if (rtlx == NULL) {
-		p = vpe_get_shared(cpu_idx);
+		p = vpe_get_shared(aprp_cpu_index());
 		if (p == NULL) {
 			if (can_sleep) {
 				__wait_event_interruptible(
 					channel_wqs[index].lx_queue,
-					(p = vpe_get_shared(cpu_idx)), ret);
+					(p = vpe_get_shared(aprp_cpu_index())),
+					ret);
 				if (ret)
 					goto out_fail;
 			} else {
@@ -238,7 +173,7 @@ int rtlx_open(int index, int can_sleep)
 
 		if ((unsigned int)*p < KSEG0) {
 			pr_warn("vpe_get_shared returned an invalid pointer maybe an error code %d\n",
-			       (int)*p);
+				(int)*p);
 			ret = -ENOSYS;
 			goto out_fail;
 		}
@@ -276,12 +211,12 @@ int rtlx_release(int index)
 
 unsigned int rtlx_read_poll(int index, int can_sleep)
 {
- 	struct rtlx_channel *chan;
+	struct rtlx_channel *chan;
 
- 	if (rtlx == NULL)
- 		return 0;
+	if (rtlx == NULL)
+		return 0;
 
- 	chan = &rtlx->channel[index];
+	chan = &rtlx->channel[index];
 
 	/* data available to read? */
 	if (chan->lx_read == chan->lx_write) {
@@ -367,25 +302,6 @@ out:
 	return count;
 }
 
-#ifdef CONFIG_MIPS_CMP
-static void _interrupt_sp(void)
-{
-	smp_send_reschedule(cpu_idx);
-}
-#else
-static void _interrupt_sp(void)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	dvpe();
-	settc(1);
-	write_vpe_c0_cause(read_vpe_c0_cause() | C_SW0);
-	evpe(EVPE_ENABLE);
-	local_irq_restore(flags);
-}
-#endif
-
 ssize_t rtlx_write(int index, const void __user *buffer, size_t count)
 {
 	struct rtlx_channel *rt;
@@ -473,7 +389,7 @@ static ssize_t file_read(struct file *file, char __user * buffer, size_t count,
 
 	/* data available? */
 	if (!rtlx_read_poll(minor, (file->f_flags & O_NONBLOCK) ? 0 : 1)) {
-		return 0;	// -EAGAIN makes cat whinge
+		return 0; /* -EAGAIN makes cat whinge */
 	}
 
 	return rtlx_read(minor, buffer, count);
@@ -505,7 +421,7 @@ static ssize_t file_write(struct file *file, const char __user * buffer,
 	return rtlx_write(minor, buffer, count);
 }
 
-static const struct file_operations rtlx_fops = {
+const struct file_operations rtlx_fops = {
 	.owner =   THIS_MODULE,
 	.open =    file_open,
 	.release = file_release,
@@ -515,161 +431,6 @@ static const struct file_operations rtlx_fops = {
 	.llseek =  noop_llseek,
 };
 
-static char register_chrdev_failed[] __initdata =
-	KERN_ERR "rtlx_module_init: unable to register device\n";
-
-#ifdef CONFIG_MIPS_CMP
-static int __init rtlx_module_init(void)
-{
-	struct device *dev;
-	int i, err;
-
-	if (!cpu_has_mipsmt) {
-		pr_warn("VPE loader: not a MIPS MT capable processor\n");
-		return -ENODEV;
-	}
-
-	cpu_idx = setup_max_cpus;
-
-	if (num_possible_cpus() - cpu_idx < 1) {
-		pr_warn("No TCs reserved for AP/SP, not initializing RTLX.\n"
-			"Pass maxcpus=<n> argument as kernel argument\n");
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
-	vpe_notify(cpu_idx, &notify);
-
-	if (cpu_has_vint) {
-		aprp_hook = rtlx_interrupt;
-	} else {
-		pr_err("APRP RTLX init on non-vectored-interrupt processor\n");
-		err = -ENODEV;
-		goto out_chrdev;
-	}
-
-	return 0;
-
-out_chrdev:
-	for (i = 0; i < RTLX_CHANNELS; i++)
-		device_destroy(mt_class, MKDEV(major, i));
-
-	return err;
-}
-#else
-static struct irqaction rtlx_irq = {
-	.handler	= rtlx_interrupt,
-	.name		= "RTLX",
-};
-
-static int rtlx_irq_num = MIPS_CPU_IRQ_BASE + MIPS_CPU_RTLX_IRQ;
-
-static int __init rtlx_module_init(void)
-{
-	struct device *dev;
-	int i, err;
-
-	if (!cpu_has_mipsmt) {
-		pr_warn("VPE loader: not a MIPS MT capable processor\n");
-		return -ENODEV;
-	}
-
-	cpu_idx = tclimit;
-
-	if (cpu_idx == 0) {
-		pr_warn("No TCs reserved for AP/SP, not initializing RTLX.\n"
-			"Pass maxtcs=<n> argument as kernel argument\n");
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
-	vpe_notify(cpu_idx, &notify);
-
-	if (cpu_has_vint) {
-		/*
-		 * set_vi_handler() doesn't work in some cases: When sw0
-		 * gets set, a hw interrupt is signaled as well. Here we
-		 * are hooking it into platform specific dispatch.
-		 */
-		aprp_hook = rtlx_dispatch;
-	} else {
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
-#endif
-
-static void __exit rtlx_module_exit(void)
-{
-	int i;
-
-	for (i = 0; i < RTLX_CHANNELS; i++)
-		device_destroy(mt_class, MKDEV(major, i));
-
-	unregister_chrdev(major, module_name);
-	aprp_hook = null_aprp_hook;
-}
-
 module_init(rtlx_module_init);
 module_exit(rtlx_module_exit);
 
diff --git a/arch/mips/kernel/vpe-cmp.c b/arch/mips/kernel/vpe-cmp.c
new file mode 100644
index 0000000..9d0c375
--- /dev/null
+++ b/arch/mips/kernel/vpe-cmp.c
@@ -0,0 +1,185 @@
+/*
+ * Copyright (C) 2004, 2005, 2012 MIPS Technologies, Inc.  All rights reserved.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/export.h>
+
+#include <asm/vpe.h>
+
+static int major;
+
+#error CMP vpe_run() not implemented!
+
+void cleanup_tc(struct tc *tc)
+{
+
+}
+
+static ssize_t store_kill(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t len)
+{
+	struct vpe *vpe = get_vpe(aprp_cpu_index());
+	struct vpe_notifications *not;
+
+	list_for_each_entry(not, &vpe->notify, list) {
+		not->stop(aprp_cpu_index());
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
+	struct vpe *vpe = get_vpe(aprp_cpu_index());
+
+	return sprintf(buf, "%d\n", vpe->ntcs);
+}
+
+static ssize_t store_ntcs(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t len)
+{
+	struct vpe *vpe = get_vpe(aprp_cpu_index());
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
+
+static struct device_attribute vpe_class_attributes[] = {
+	__ATTR(kill, S_IWUSR, NULL, store_kill),
+	__ATTR(ntcs, S_IRUGO | S_IWUSR, show_ntcs, store_ntcs),
+	{}
+};
+
+static void vpe_device_release(struct device *cd)
+{
+	kfree(cd);
+}
+
+static struct class vpe_class = {
+	.name = "vpe",
+	.owner = THIS_MODULE,
+	.dev_release = vpe_device_release,
+	.dev_attrs = vpe_class_attributes,
+};
+
+static struct device vpe_device;
+
+int __init vpe_module_init(void)
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
+	if (num_possible_cpus() - aprp_cpu_index() < 1) {
+		pr_warn("No VPEs reserved for AP/SP, not initialize VPE loader\n"
+			"Pass maxcpus=<n> argument as kernel argument\n");
+		return -ENODEV;
+	}
+
+	major = register_chrdev(0, VPE_MODULE_NAME, &vpe_fops);
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
+	vpe_device.devt = MKDEV(major, VPE_MODULE_MINOR);
+	err = device_add(&vpe_device);
+	if (err) {
+		pr_err("Adding vpe_device failed\n");
+		goto out_class;
+	}
+
+	t = alloc_tc(aprp_cpu_index());
+	if (!t) {
+		pr_warn("VPE: unable to allocate TC\n");
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/* VPE */
+	v = alloc_vpe(aprp_cpu_index());
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
+	unregister_chrdev(major, VPE_MODULE_NAME);
+
+out:
+	return err;
+}
+
+void __exit vpe_module_exit(void)
+{
+	struct vpe *v, *n;
+
+	device_del(&vpe_device);
+	unregister_chrdev(major, VPE_MODULE_NAME);
+
+	/* No locking needed here */
+	list_for_each_entry_safe(v, n, &vpecontrol.vpe_list, list) {
+		if (v->state != VPE_STATE_UNUSED)
+			release_vpe(v);
+	}
+}
diff --git a/arch/mips/kernel/vpe-mt.c b/arch/mips/kernel/vpe-mt.c
new file mode 100644
index 0000000..0f71d30
--- /dev/null
+++ b/arch/mips/kernel/vpe-mt.c
@@ -0,0 +1,534 @@
+/*
+ * Copyright (C) 2004, 2005, 2012 MIPS Technologies, Inc.  All rights reserved.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/export.h>
+
+#include <asm/mipsregs.h>
+#include <asm/mipsmtregs.h>
+#include <asm/mips_mt.h>
+#include <asm/vpe.h>
+
+static int major;
+/* The number of TCs and VPEs physically available on the core */
+static int hw_tcs, hw_vpes;
+
+/* We are prepared so configure and start the VPE... */
+int vpe_run(struct vpe *v)
+{
+	unsigned long flags, val, dmt_flag;
+	struct vpe_notifications *n;
+	unsigned int vpeflags;
+	struct tc *t;
+
+	/* check we are the Master VPE */
+	local_irq_save(flags);
+	val = read_c0_vpeconf0();
+	if (!(val & VPECONF0_MVP)) {
+		pr_warn("VPE loader: only Master VPE's are able to config MT\n");
+		local_irq_restore(flags);
+
+		return -1;
+	}
+
+	dmt_flag = dmt();
+	vpeflags = dvpe();
+
+	if (!list_empty(&v->tc)) {
+		t = list_entry(v->tc.next, struct tc, tc);
+		if (t == NULL) {
+			evpe(vpeflags);
+			emt(dmt_flag);
+			local_irq_restore(flags);
+
+			pr_warn("VPE loader: TC %d is already in use.\n",
+				t->index);
+			return -ENOEXEC;
+		}
+	} else {
+		evpe(vpeflags);
+		emt(dmt_flag);
+		local_irq_restore(flags);
+
+		pr_warn("VPE loader: No TC's associated with VPE %d\n",
+			v->minor);
+
+		return -ENOEXEC;
+	}
+
+	/* Put MVPE's into 'configuration state' */
+	set_c0_mvpcontrol(MVPCONTROL_VPC);
+
+	settc(t->index);
+
+	/* should check it is halted, and not activated */
+	if ((read_tc_c0_tcstatus() & TCSTATUS_A) ||
+	   !(read_tc_c0_tchalt() & TCHALT_H)) {
+		evpe(vpeflags);
+		emt(dmt_flag);
+		local_irq_restore(flags);
+
+		pr_warn("VPE loader: TC %d is already active!\n",
+			t->index);
+
+		return -ENOEXEC;
+	}
+
+	/*
+	 * Write the address we want it to start running from in the TCPC
+	 * register.
+	 */
+	write_tc_c0_tcrestart((unsigned long)v->__start);
+	write_tc_c0_tccontext((unsigned long)0);
+
+	/*
+	 * Mark the TC as activated, not interrupt exempt and not dynamically
+	 * allocatable
+	 */
+	val = read_tc_c0_tcstatus();
+	val = (val & ~(TCSTATUS_DA | TCSTATUS_IXMT)) | TCSTATUS_A;
+	write_tc_c0_tcstatus(val);
+
+	write_tc_c0_tchalt(read_tc_c0_tchalt() & ~TCHALT_H);
+
+	/*
+	 * The sde-kit passes 'memsize' to __start in $a3, so set something
+	 * here...  Or set $a3 to zero and define DFLT_STACK_SIZE and
+	 * DFLT_HEAP_SIZE when you compile your program
+	 */
+	mttgpr(6, v->ntcs);
+	mttgpr(7, physical_memsize);
+
+	/* set up VPE1 */
+	/*
+	 * bind the TC to VPE 1 as late as possible so we only have the final
+	 * VPE registers to set up, and so an EJTAG probe can trigger on it
+	 */
+	write_tc_c0_tcbind((read_tc_c0_tcbind() & ~TCBIND_CURVPE) | 1);
+
+	write_vpe_c0_vpeconf0(read_vpe_c0_vpeconf0() & ~(VPECONF0_VPA));
+
+	back_to_back_c0_hazard();
+
+	/* Set up the XTC bit in vpeconf0 to point at our tc */
+	write_vpe_c0_vpeconf0((read_vpe_c0_vpeconf0() & ~(VPECONF0_XTC))
+			      | (t->index << VPECONF0_XTC_SHIFT));
+
+	back_to_back_c0_hazard();
+
+	/* enable this VPE */
+	write_vpe_c0_vpeconf0(read_vpe_c0_vpeconf0() | VPECONF0_VPA);
+
+	/* clear out any left overs from a previous program */
+	write_vpe_c0_status(0);
+	write_vpe_c0_cause(0);
+
+	/* take system out of configuration state */
+	clear_c0_mvpcontrol(MVPCONTROL_VPC);
+
+	/*
+	 * SMTC/SMVP kernels manage VPE enable independently,
+	 * but uniprocessor kernels need to turn it on, even
+	 * if that wasn't the pre-dvpe() state.
+	 */
+#ifdef CONFIG_SMP
+	evpe(vpeflags);
+#else
+	evpe(EVPE_ENABLE);
+#endif
+	emt(dmt_flag);
+	local_irq_restore(flags);
+
+	list_for_each_entry(n, &v->notify, list)
+		n->start(VPE_MODULE_MINOR);
+
+	return 0;
+}
+
+void cleanup_tc(struct tc *tc)
+{
+	unsigned long flags;
+	unsigned int mtflags, vpflags;
+	int tmp;
+
+	local_irq_save(flags);
+	mtflags = dmt();
+	vpflags = dvpe();
+	/* Put MVPE's into 'configuration state' */
+	set_c0_mvpcontrol(MVPCONTROL_VPC);
+
+	settc(tc->index);
+	tmp = read_tc_c0_tcstatus();
+
+	/* mark not allocated and not dynamically allocatable */
+	tmp &= ~(TCSTATUS_A | TCSTATUS_DA);
+	tmp |= TCSTATUS_IXMT;	/* interrupt exempt */
+	write_tc_c0_tcstatus(tmp);
+
+	write_tc_c0_tchalt(TCHALT_H);
+	mips_ihb();
+
+	clear_c0_mvpcontrol(MVPCONTROL_VPC);
+	evpe(vpflags);
+	emt(mtflags);
+	local_irq_restore(flags);
+}
+
+/* module wrapper entry points */
+/* give me a vpe */
+void *vpe_alloc(void)
+{
+	int i;
+	struct vpe *v;
+
+	/* find a vpe */
+	for (i = 1; i < MAX_VPES; i++) {
+		v = get_vpe(i);
+		if (v != NULL) {
+			v->state = VPE_STATE_INUSE;
+			return v;
+		}
+	}
+	return NULL;
+}
+EXPORT_SYMBOL(vpe_alloc);
+
+/* start running from here */
+int vpe_start(void *vpe, unsigned long start)
+{
+	struct vpe *v = vpe;
+
+	v->__start = start;
+	return vpe_run(v);
+}
+EXPORT_SYMBOL(vpe_start);
+
+/* halt it for now */
+int vpe_stop(void *vpe)
+{
+	struct vpe *v = vpe;
+	struct tc *t;
+	unsigned int evpe_flags;
+
+	evpe_flags = dvpe();
+
+	t = list_entry(v->tc.next, struct tc, tc);
+	if (t != NULL) {
+		settc(t->index);
+		write_vpe_c0_vpeconf0(read_vpe_c0_vpeconf0() & ~VPECONF0_VPA);
+	}
+
+	evpe(evpe_flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(vpe_stop);
+
+/* I've done with it thank you */
+int vpe_free(void *vpe)
+{
+	struct vpe *v = vpe;
+	struct tc *t;
+	unsigned int evpe_flags;
+
+	t = list_entry(v->tc.next, struct tc, tc);
+	if (t == NULL)
+		return -ENOEXEC;
+
+	evpe_flags = dvpe();
+
+	/* Put MVPE's into 'configuration state' */
+	set_c0_mvpcontrol(MVPCONTROL_VPC);
+
+	settc(t->index);
+	write_vpe_c0_vpeconf0(read_vpe_c0_vpeconf0() & ~VPECONF0_VPA);
+
+	/* halt the TC */
+	write_tc_c0_tchalt(TCHALT_H);
+	mips_ihb();
+
+	/* mark the TC unallocated */
+	write_tc_c0_tcstatus(read_tc_c0_tcstatus() & ~TCSTATUS_A);
+
+	v->state = VPE_STATE_UNUSED;
+
+	clear_c0_mvpcontrol(MVPCONTROL_VPC);
+	evpe(evpe_flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(vpe_free);
+
+static ssize_t store_kill(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t len)
+{
+	struct vpe *vpe = get_vpe(aprp_cpu_index());
+	struct vpe_notifications *not;
+
+	list_for_each_entry(not, &vpe->notify, list) {
+		not->stop(aprp_cpu_index());
+	}
+
+	release_progmem(vpe->load_addr);
+	cleanup_tc(get_tc(aprp_cpu_index()));
+	vpe_stop(vpe);
+	vpe_free(vpe);
+
+	return len;
+}
+
+static ssize_t show_ntcs(struct device *cd, struct device_attribute *attr,
+			 char *buf)
+{
+	struct vpe *vpe = get_vpe(aprp_cpu_index());
+
+	return sprintf(buf, "%d\n", vpe->ntcs);
+}
+
+static ssize_t store_ntcs(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t len)
+{
+	struct vpe *vpe = get_vpe(aprp_cpu_index());
+	unsigned long new;
+	int ret;
+
+	ret = kstrtoul(buf, 0, &new);
+	if (ret < 0)
+		return ret;
+
+	if (new == 0 || new > (hw_tcs - aprp_cpu_index()))
+		return -EINVAL;
+
+	vpe->ntcs = new;
+
+	return len;
+}
+
+static struct device_attribute vpe_class_attributes[] = {
+	__ATTR(kill, S_IWUSR, NULL, store_kill),
+	__ATTR(ntcs, S_IRUGO | S_IWUSR, show_ntcs, store_ntcs),
+	{}
+};
+
+static void vpe_device_release(struct device *cd)
+{
+	kfree(cd);
+}
+
+static struct class vpe_class = {
+	.name = "vpe",
+	.owner = THIS_MODULE,
+	.dev_release = vpe_device_release,
+	.dev_attrs = vpe_class_attributes,
+};
+
+static struct device vpe_device;
+
+int __init vpe_module_init(void)
+{
+	unsigned int mtflags, vpflags;
+	unsigned long flags, val;
+	struct vpe *v = NULL;
+	struct tc *t;
+	int tc, err;
+
+	if (!cpu_has_mipsmt) {
+		pr_warn("VPE loader: not a MIPS MT capable processor\n");
+		return -ENODEV;
+	}
+
+	if (vpelimit == 0) {
+		pr_warn("No VPEs reserved for AP/SP, not initialize VPE loader\n"
+			"Pass maxvpes=<n> argument as kernel argument\n");
+
+		return -ENODEV;
+	}
+
+	if (aprp_cpu_index() == 0) {
+		pr_warn("No TCs reserved for AP/SP, not initialize VPE loader\n"
+			"Pass maxtcs=<n> argument as kernel argument\n");
+
+		return -ENODEV;
+	}
+
+	major = register_chrdev(0, VPE_MODULE_NAME, &vpe_fops);
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
+	dev_set_name(&vpe_device, "vpe1");
+	vpe_device.devt = MKDEV(major, VPE_MODULE_MINOR);
+	err = device_add(&vpe_device);
+	if (err) {
+		pr_err("Adding vpe_device failed\n");
+		goto out_class;
+	}
+
+	local_irq_save(flags);
+	mtflags = dmt();
+	vpflags = dvpe();
+
+	/* Put MVPE's into 'configuration state' */
+	set_c0_mvpcontrol(MVPCONTROL_VPC);
+
+	val = read_c0_mvpconf0();
+	hw_tcs = (val & MVPCONF0_PTC) + 1;
+	hw_vpes = ((val & MVPCONF0_PVPE) >> MVPCONF0_PVPE_SHIFT) + 1;
+
+	for (tc = aprp_cpu_index(); tc < hw_tcs; tc++) {
+		/*
+		 * Must re-enable multithreading temporarily or in case we
+		 * reschedule send IPIs or similar we might hang.
+		 */
+		clear_c0_mvpcontrol(MVPCONTROL_VPC);
+		evpe(vpflags);
+		emt(mtflags);
+		local_irq_restore(flags);
+		t = alloc_tc(tc);
+		if (!t) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		local_irq_save(flags);
+		mtflags = dmt();
+		vpflags = dvpe();
+		set_c0_mvpcontrol(MVPCONTROL_VPC);
+
+		/* VPE's */
+		if (tc < hw_tcs) {
+			settc(tc);
+
+			v = alloc_vpe(tc);
+			if (v == NULL) {
+				pr_warn("VPE: unable to allocate VPE\n");
+				goto out_reenable;
+			}
+
+			v->ntcs = hw_tcs - aprp_cpu_index();
+
+			/* add the tc to the list of this vpe's tc's. */
+			list_add(&t->tc, &v->tc);
+
+			/* deactivate all but vpe0 */
+			if (tc >= aprp_cpu_index()) {
+				unsigned long tmp = read_vpe_c0_vpeconf0();
+
+				tmp &= ~VPECONF0_VPA;
+
+				/* master VPE */
+				tmp |= VPECONF0_MVP;
+				write_vpe_c0_vpeconf0(tmp);
+			}
+
+			/* disable multi-threading with TC's */
+			write_vpe_c0_vpecontrol(read_vpe_c0_vpecontrol() &
+						~VPECONTROL_TE);
+
+			if (tc >= vpelimit) {
+				/*
+				 * Set config to be the same as vpe0,
+				 * particularly kseg0 coherency alg
+				 */
+				write_vpe_c0_config(read_c0_config());
+			}
+		}
+
+		/* TC's */
+		t->pvpe = v;	/* set the parent vpe */
+
+		if (tc >= aprp_cpu_index()) {
+			unsigned long tmp;
+
+			settc(tc);
+
+			/* Any TC that is bound to VPE0 gets left as is - in
+			 * case we are running SMTC on VPE0. A TC that is bound
+			 * to any other VPE gets bound to VPE0, ideally I'd like
+			 * to make it homeless but it doesn't appear to let me
+			 * bind a TC to a non-existent VPE. Which is perfectly
+			 * reasonable.
+			 *
+			 * The (un)bound state is visible to an EJTAG probe so
+			 * may notify GDB...
+			 */
+			tmp = read_tc_c0_tcbind();
+			if (tmp & TCBIND_CURVPE) {
+				/* tc is bound >vpe0 */
+				write_tc_c0_tcbind(tmp & ~TCBIND_CURVPE);
+
+				t->pvpe = get_vpe(0);	/* set the parent vpe */
+			}
+
+			/* halt the TC */
+			write_tc_c0_tchalt(TCHALT_H);
+			mips_ihb();
+
+			tmp = read_tc_c0_tcstatus();
+
+			/* mark not activated and not dynamically allocatable */
+			tmp &= ~(TCSTATUS_A | TCSTATUS_DA);
+			tmp |= TCSTATUS_IXMT;	/* interrupt exempt */
+			write_tc_c0_tcstatus(tmp);
+		}
+	}
+
+out_reenable:
+	/* release config state */
+	clear_c0_mvpcontrol(MVPCONTROL_VPC);
+
+	evpe(vpflags);
+	emt(mtflags);
+	local_irq_restore(flags);
+
+	return 0;
+
+out_class:
+	class_unregister(&vpe_class);
+out_chrdev:
+	unregister_chrdev(major, VPE_MODULE_NAME);
+
+out:
+	return err;
+}
+
+void __exit vpe_module_exit(void)
+{
+	struct vpe *v, *n;
+
+	device_del(&vpe_device);
+	unregister_chrdev(major, VPE_MODULE_NAME);
+
+	/* No locking needed here */
+	list_for_each_entry_safe(v, n, &vpecontrol.vpe_list, list) {
+		if (v->state != VPE_STATE_UNUSED)
+			release_vpe(v);
+	}
+}
diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index a558bbe..e84bc7b 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -51,8 +51,6 @@
 #include <asm/processor.h>
 #include <asm/vpe.h>
 
-typedef void *vpe_handle;
-
 #ifndef ARCH_SHF_SMALL
 #define ARCH_SHF_SMALL 0
 #endif
@@ -60,97 +58,15 @@ typedef void *vpe_handle;
 /* If this is set, the section belongs in the init part of the module */
 #define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG-1))
 
-/*
- * The number of TCs and VPEs physically available on the core
- */
-static int cpu_idx;
-static int hw_tcs, hw_vpes;
-static char module_name[] = "vpe";
-static int major;
-static const int minor = 1;	/* fixed for now  */
-
-/* grab the likely amount of memory we will need. */
-#ifdef CONFIG_MIPS_VPE_LOADER_TOM
-#define P_SIZE (2 * 1024 * 1024)
-#else
-/* add an overhead to the max kmalloc size for non-striped symbols/etc */
-#define P_SIZE (256 * 1024)
-#endif
-
-extern unsigned long physical_memsize;
-
-#define MAX_VPES 16
-#define VPE_PATH_MAX 256
-
-enum vpe_state {
-	VPE_STATE_UNUSED = 0,
-	VPE_STATE_INUSE,
-	VPE_STATE_RUNNING
-};
-
-enum tc_state {
-	TC_STATE_UNUSED = 0,
-	TC_STATE_INUSE,
-	TC_STATE_RUNNING,
-	TC_STATE_DYNAMIC
-};
-
-struct vpe {
-	enum vpe_state state;
-
-	/* (device) minor associated with this vpe */
-	int minor;
-
-	/* elfloader stuff */
-	void *load_addr;
-	unsigned long len;
-	char *pbuffer;
-	unsigned long plen;
-	unsigned int uid, gid;
-	char cwd[VPE_PATH_MAX];
-
-	unsigned long __start;
-
-	/* tc's associated with this vpe */
-	struct list_head tc;
-
-	/* The list of vpe's */
-	struct list_head list;
-
-	/* shared symbol address */
-	void *shared_ptr;
-
-	/* the list of who wants to know when something major happens */
-	struct list_head notify;
-
-	unsigned int ntcs;
-};
-
-struct tc {
-	enum tc_state state;
-	int index;
-
-	struct vpe *pvpe;	/* parent VPE */
-	struct list_head tc;	/* The list of TC's with this VPE */
-	struct list_head list;	/* The global list of tc's */
-};
-
-struct {
-	spinlock_t vpe_list_lock;
-	struct list_head vpe_list;	/* Virtual processing elements */
-	spinlock_t tc_list_lock;
-	struct list_head tc_list;	/* Thread contexts */
-} vpecontrol = {
+struct vpe_control vpecontrol = {
 	.vpe_list_lock	= __SPIN_LOCK_UNLOCKED(vpe_list_lock),
 	.vpe_list	= LIST_HEAD_INIT(vpecontrol.vpe_list),
 	.tc_list_lock	= __SPIN_LOCK_UNLOCKED(tc_list_lock),
 	.tc_list	= LIST_HEAD_INIT(vpecontrol.tc_list)
 };
 
-static void release_progmem(void *ptr);
-
 /* get the vpe associated with this minor */
-static struct vpe *get_vpe(int minor)
+struct vpe *get_vpe(int minor)
 {
 	struct vpe *res, *v;
 
@@ -160,7 +76,7 @@ static struct vpe *get_vpe(int minor)
 	res = NULL;
 	spin_lock(&vpecontrol.vpe_list_lock);
 	list_for_each_entry(v, &vpecontrol.vpe_list, list) {
-		if (v->minor == minor) {
+		if (v->minor == VPE_MODULE_MINOR) {
 			res = v;
 			break;
 		}
@@ -171,7 +87,7 @@ static struct vpe *get_vpe(int minor)
 }
 
 /* get the vpe associated with this minor */
-static struct tc *get_tc(int index)
+struct tc *get_tc(int index)
 {
 	struct tc *res, *t;
 
@@ -189,7 +105,7 @@ static struct tc *get_tc(int index)
 }
 
 /* allocate a vpe and associate it with this minor (or index) */
-static struct vpe *alloc_vpe(int minor)
+struct vpe *alloc_vpe(int minor)
 {
 	struct vpe *v;
 
@@ -202,13 +118,13 @@ static struct vpe *alloc_vpe(int minor)
 	spin_unlock(&vpecontrol.vpe_list_lock);
 
 	INIT_LIST_HEAD(&v->notify);
-	v->minor = minor;
+	v->minor = VPE_MODULE_MINOR;
 
 	return v;
 }
 
 /* allocate a tc. At startup only tc0 is running, all other can be halted. */
-static struct tc *alloc_tc(int index)
+struct tc *alloc_tc(int index)
 {
 	struct tc *tc;
 
@@ -227,7 +143,7 @@ out:
 }
 
 /* clean up and free everything */
-static void release_vpe(struct vpe *v)
+void release_vpe(struct vpe *v)
 {
 	list_del(&v->list);
 	if (v->load_addr)
@@ -235,28 +151,8 @@ static void release_vpe(struct vpe *v)
 	kfree(v);
 }
 
-static void __maybe_unused dump_mtregs(void)
-{
-	unsigned long val;
-
-	val = read_c0_config3();
-	printk("config3 0x%lx MT %ld\n", val,
-	       (val & CONFIG3_MT) >> CONFIG3_MT_SHIFT);
-
-	val = read_c0_mvpcontrol();
-	printk("MVPControl 0x%lx, STLB %ld VPC %ld EVP %ld\n", val,
-	       (val & MVPCONTROL_STLB) >> MVPCONTROL_STLB_SHIFT,
-	       (val & MVPCONTROL_VPC) >> MVPCONTROL_VPC_SHIFT,
-	       (val & MVPCONTROL_EVP));
-
-	val = read_c0_mvpconf0();
-	printk("mvpconf0 0x%lx, PVPE %ld PTC %ld M %ld\n", val,
-	       (val & MVPCONF0_PVPE) >> MVPCONF0_PVPE_SHIFT,
-	       val & MVPCONF0_PTC, (val & MVPCONF0_M) >> MVPCONF0_M_SHIFT);
-}
-
 /* Find some VPE program space  */
-static void *alloc_progmem(unsigned long len)
+void *alloc_progmem(unsigned long len)
 {
 	void *addr;
 
@@ -275,7 +171,7 @@ static void *alloc_progmem(unsigned long len)
 	return addr;
 }
 
-static void release_progmem(void *ptr)
+void release_progmem(void *ptr)
 {
 #ifndef CONFIG_MIPS_VPE_LOADER_TOM
 	kfree(ptr);
@@ -317,7 +213,6 @@ static void layout_sections(struct module *mod, const Elf_Ehdr * hdr,
 		for (i = 0; i < hdr->e_shnum; ++i) {
 			Elf_Shdr *s = &sechdrs[i];
 
-			//  || strncmp(secstrings + s->sh_name, ".init", 5) == 0)
 			if ((s->sh_flags & masks[m][0]) != masks[m][0]
 			    || (s->sh_flags & masks[m][1])
 			    || s->sh_entsize != ~0UL)
@@ -332,7 +227,6 @@ static void layout_sections(struct module *mod, const Elf_Ehdr * hdr,
 	}
 }
 
-
 /* from module-elf32.c, but subverted a little */
 
 struct mips_hi16 {
@@ -407,7 +301,7 @@ static int apply_r_mips_26(struct module *me, uint32_t *location,
 			   Elf32_Addr v)
 {
 	if (v % 4) {
-		pr_debug("VPE loader: apply_r_mips_26 unaligned relocation\n");
+		pr_debug("VPE loader: apply_r_mips_26: unaligned relocation\n");
 		return -ENOEXEC;
 	}
 
@@ -469,8 +363,8 @@ static int apply_r_mips_lo16(struct module *me, uint32_t *location,
 			/*
 			 * The value for the HI16 had best be the same.
 			 */
- 			if (v != l->value) {
-				pr_debug("VPE loader: apply_r_mips_lo16/hi16: \tinconsistent value information\n");
+			if (v != l->value) {
+				pr_debug("VPE loader: apply_r_mips_lo16/hi16: inconsistent value information\n");
 				goto out_free;
 			}
 
@@ -567,7 +461,7 @@ static int apply_relocations(Elf32_Shdr *sechdrs,
 
 		if (!sym->st_value) {
 			pr_debug("%s: undefined weak symbol %s\n",
-			       me->name, strtab + sym->st_name);
+				 me->name, strtab + sym->st_name);
 			/* just print the warning, dont barf */
 		}
 
@@ -593,8 +487,6 @@ static inline void save_gp_address(unsigned int secbase, unsigned int rel)
 }
 /* end module-elf32.c */
 
-
-
 /* Change all symbols so that sh_value encodes the pointer directly. */
 static void simplify_symbols(Elf_Shdr * sechdrs,
 			    unsigned int symindex,
@@ -670,136 +562,6 @@ static void dump_elfsymbols(Elf_Shdr * sechdrs, unsigned int symindex,
 }
 #endif
 
-#ifdef CONFIG_MIPS_CMP
-#error CMP vpe_run() not implemented!
-#else
-/* We are prepared so configure and start the VPE... */
-static int vpe_run(struct vpe * v)
-{
-	unsigned long flags, val, dmt_flag;
-	struct vpe_notifications *n;
-	unsigned int vpeflags;
-	struct tc *t;
-
-	/* check we are the Master VPE */
-	local_irq_save(flags);
-	val = read_c0_vpeconf0();
-	if (!(val & VPECONF0_MVP)) {
-		pr_warn("VPE loader: only Master VPE's are allowed to configure MT\n");
-		local_irq_restore(flags);
-
-		return -1;
-	}
-
-	dmt_flag = dmt();
-	vpeflags = dvpe();
-
-	if (!list_empty(&v->tc)) {
-		if ((t = list_entry(v->tc.next, struct tc, tc)) == NULL) {
-			evpe(vpeflags);
-			emt(dmt_flag);
-			local_irq_restore(flags);
-
-			pr_warn("VPE loader: TC %d is already in use.\n",
-				t->index);
-			return -ENOEXEC;
-		}
-	} else {
-		evpe(vpeflags);
-		emt(dmt_flag);
-		local_irq_restore(flags);
-
-		pr_warn("VPE loader: No TC's associated with VPE %d\n",
-			v->minor);
-
-		return -ENOEXEC;
-	}
-
-	/* Put MVPE's into 'configuration state' */
-	set_c0_mvpcontrol(MVPCONTROL_VPC);
-
-	settc(t->index);
-
-	/* should check it is halted, and not activated */
-	if ((read_tc_c0_tcstatus() & TCSTATUS_A) || !(read_tc_c0_tchalt() & TCHALT_H)) {
-		evpe(vpeflags);
-		emt(dmt_flag);
-		local_irq_restore(flags);
-
-		pr_warn("VPE loader: TC %d is already active!\n", t->index);
-
-		return -ENOEXEC;
-	}
-
-	/* Write the address we want it to start running from in the TCPC register. */
-	write_tc_c0_tcrestart((unsigned long)v->__start);
-	write_tc_c0_tccontext((unsigned long)0);
-
-	/*
-	 * Mark the TC as activated, not interrupt exempt and not dynamically
-	 * allocatable
-	 */
-	val = read_tc_c0_tcstatus();
-	val = (val & ~(TCSTATUS_DA | TCSTATUS_IXMT)) | TCSTATUS_A;
-	write_tc_c0_tcstatus(val);
-
-	write_tc_c0_tchalt(read_tc_c0_tchalt() & ~TCHALT_H);
-
-	/*
-	 * The sde-kit passes 'memsize' to __start in $a3, so set something
-	 * here...  Or set $a3 to zero and define DFLT_STACK_SIZE and
-	 * DFLT_HEAP_SIZE when you compile your program
-	 */
-	mttgpr(6, v->ntcs);
-	mttgpr(7, physical_memsize);
-
-	/* set up VPE1 */
-	/*
-	 * bind the TC to VPE 1 as late as possible so we only have the final
-	 * VPE registers to set up, and so an EJTAG probe can trigger on it
-	 */
-	write_tc_c0_tcbind((read_tc_c0_tcbind() & ~TCBIND_CURVPE) | 1);
-
-	write_vpe_c0_vpeconf0(read_vpe_c0_vpeconf0() & ~(VPECONF0_VPA));
-
-	back_to_back_c0_hazard();
-
-	/* Set up the XTC bit in vpeconf0 to point at our tc */
-	write_vpe_c0_vpeconf0( (read_vpe_c0_vpeconf0() & ~(VPECONF0_XTC))
-	                      | (t->index << VPECONF0_XTC_SHIFT));
-
-	back_to_back_c0_hazard();
-
-	/* enable this VPE */
-	write_vpe_c0_vpeconf0(read_vpe_c0_vpeconf0() | VPECONF0_VPA);
-
-	/* clear out any left overs from a previous program */
-	write_vpe_c0_status(0);
-	write_vpe_c0_cause(0);
-
-	/* take system out of configuration state */
-	clear_c0_mvpcontrol(MVPCONTROL_VPC);
-
-	/*
-	 * SMTC/SMVP kernels manage VPE enable independently,
-	 * but uniprocessor kernels need to turn it on, even
-	 * if that wasn't the pre-dvpe() state.
-	 */
-#ifdef CONFIG_SMP
-	evpe(vpeflags);
-#else
-	evpe(EVPE_ENABLE);
-#endif
-	emt(dmt_flag);
-	local_irq_restore(flags);
-
-	list_for_each_entry(n, &v->notify, list)
-		n->start(minor);
-
-	return 0;
-}
-#endif /* CONFIG_MIPS_CMP */
-
 static int find_vpe_symbols(struct vpe * v, Elf_Shdr * sechdrs,
 				      unsigned int symindex, const char *strtab,
 				      struct module *mod)
@@ -835,7 +597,7 @@ static int vpe_elfload(struct vpe * v)
 	long err = 0;
 	char *secstrings, *strtab = NULL;
 	unsigned int len, i, symindex = 0, strindex = 0, relocate = 0;
-	struct module mod;	// so we can re-use the relocations code
+	struct module mod; /* so we can re-use the relocations code */
 
 	memset(&mod, 0, sizeof(struct module));
 	strcpy(mod.name, "VPE loader");
@@ -920,35 +682,36 @@ static int vpe_elfload(struct vpe * v)
 				 sechdrs[i].sh_addr);
 		}
 
- 		/* Fix up syms, so that st_value is a pointer to location. */
- 		simplify_symbols(sechdrs, symindex, strtab, secstrings,
- 				 hdr->e_shnum, &mod);
+		/* Fix up syms, so that st_value is a pointer to location. */
+		simplify_symbols(sechdrs, symindex, strtab, secstrings,
+				 hdr->e_shnum, &mod);
 
- 		/* Now do relocations. */
- 		for (i = 1; i < hdr->e_shnum; i++) {
- 			const char *strtab = (char *)sechdrs[strindex].sh_addr;
- 			unsigned int info = sechdrs[i].sh_info;
+		/* Now do relocations. */
+		for (i = 1; i < hdr->e_shnum; i++) {
+			const char *strtab = (char *)sechdrs[strindex].sh_addr;
+			unsigned int info = sechdrs[i].sh_info;
 
- 			/* Not a valid relocation section? */
- 			if (info >= hdr->e_shnum)
- 				continue;
+			/* Not a valid relocation section? */
+			if (info >= hdr->e_shnum)
+				continue;
 
- 			/* Don't bother with non-allocated sections */
- 			if (!(sechdrs[info].sh_flags & SHF_ALLOC))
- 				continue;
+			/* Don't bother with non-allocated sections */
+			if (!(sechdrs[info].sh_flags & SHF_ALLOC))
+				continue;
 
- 			if (sechdrs[i].sh_type == SHT_REL)
- 				err = apply_relocations(sechdrs, strtab, symindex, i,
- 							&mod);
- 			else if (sechdrs[i].sh_type == SHT_RELA)
- 				err = apply_relocate_add(sechdrs, strtab, symindex, i,
- 							 &mod);
- 			if (err < 0)
- 				return err;
+			if (sechdrs[i].sh_type == SHT_REL)
+				err = apply_relocations(sechdrs, strtab,
+							symindex, i, &mod);
+			else if (sechdrs[i].sh_type == SHT_RELA)
+				err = apply_relocate_add(sechdrs, strtab,
+							 symindex, i, &mod);
+			if (err < 0)
+				return err;
 
-  		}
-  	} else {
-		struct elf_phdr *phdr = (struct elf_phdr *) ((char *)hdr + hdr->e_phoff);
+		}
+	} else {
+		struct elf_phdr *phdr = (struct elf_phdr *) ((char *)hdr +
+							     hdr->e_phoff);
 
 		for (i = 0; i < hdr->e_phnum; i++) {
 			if (phdr->p_type == PT_LOAD) {
@@ -962,16 +725,20 @@ static int vpe_elfload(struct vpe * v)
 		}
 
 		for (i = 0; i < hdr->e_shnum; i++) {
- 			/* Internal symbols and strings. */
- 			if (sechdrs[i].sh_type == SHT_SYMTAB) {
- 				symindex = i;
- 				strindex = sechdrs[i].sh_link;
- 				strtab = (char *)hdr + sechdrs[strindex].sh_offset;
-
- 				/* mark the symtab's address for when we try to find the
- 				   magic symbols */
- 				sechdrs[i].sh_addr = (size_t) hdr + sechdrs[i].sh_offset;
- 			}
+			/* Internal symbols and strings. */
+			if (sechdrs[i].sh_type == SHT_SYMTAB) {
+				symindex = i;
+				strindex = sechdrs[i].sh_link;
+				strtab = (char *)hdr +
+					 sechdrs[strindex].sh_offset;
+
+				/*
+				 * mark the symtab's address for when we try to
+				 * find the magic symbols
+				 */
+				sechdrs[i].sh_addr = (size_t) hdr +
+						     sechdrs[i].sh_offset;
+			}
 		}
 	}
 
@@ -994,45 +761,6 @@ static int vpe_elfload(struct vpe * v)
 	return 0;
 }
 
-#ifdef CONFIG_MIPS_CMP
-static void cleanup_tc(struct tc *tc)
-{
-
-}
-#else
-static void cleanup_tc(struct tc *tc)
-{
-	unsigned long flags;
-	unsigned int mtflags, vpflags;
-	int tmp;
-
-	local_irq_save(flags);
-	mtflags = dmt();
-	vpflags = dvpe();
-	/* Put MVPE's into 'configuration state' */
-	set_c0_mvpcontrol(MVPCONTROL_VPC);
-
-	settc(tc->index);
-	tmp = read_tc_c0_tcstatus();
-
-	/* mark not allocated and not dynamically allocatable */
-	tmp &= ~(TCSTATUS_A | TCSTATUS_DA);
-	tmp |= TCSTATUS_IXMT;	/* interrupt exempt */
-	write_tc_c0_tcstatus(tmp);
-
-	write_tc_c0_tchalt(TCHALT_H);
-	mips_ihb();
-
-	/* bind it to anything other than VPE1 */
-//	write_tc_c0_tcbind(read_tc_c0_tcbind() & ~TCBIND_CURVPE); // | TCBIND_CURVPE
-
-	clear_c0_mvpcontrol(MVPCONTROL_VPC);
-	evpe(vpflags);
-	emt(mtflags);
-	local_irq_restore(flags);
-}
-#endif
-
 static int getcwd(char *buff, int size)
 {
 	mm_segment_t old_fs;
@@ -1056,14 +784,14 @@ static int vpe_open(struct inode *inode, struct file *filp)
 	struct vpe *v;
 	int ret;
 
-	if (minor != iminor(inode)) {
+	if (VPE_MODULE_MINOR != iminor(inode)) {
 		/* assume only 1 device at the moment. */
 		pr_warning("VPE loader: only vpe1 is supported\n");
 
 		return -ENODEV;
 	}
 
-	v = get_vpe(cpu_idx);
+	v = get_vpe(aprp_cpu_index());
 	if (v == NULL) {
 		pr_warning("VPE loader: unable to get vpe\n");
 
@@ -1075,11 +803,11 @@ static int vpe_open(struct inode *inode, struct file *filp)
 		pr_debug("VPE loader: tc in use dumping regs\n");
 
 		list_for_each_entry(not, &v->notify, list) {
-			not->stop(cpu_idx);
+			not->stop(aprp_cpu_index());
 		}
 
 		release_progmem(v->load_addr);
-		cleanup_tc(get_tc(cpu_idx));
+		cleanup_tc(get_tc(aprp_cpu_index()));
 	}
 
 	/* this of-course trashes what was there before... */
@@ -1112,7 +840,7 @@ static int vpe_release(struct inode *inode, struct file *filp)
 	Elf_Ehdr *hdr;
 	int ret = 0;
 
-	v = get_vpe(cpu_idx);
+	v = get_vpe(aprp_cpu_index());
 
 	if (v == NULL)
 		return -ENODEV;
@@ -1150,17 +878,16 @@ static ssize_t vpe_write(struct file *file, const char __user * buffer,
 	size_t ret = count;
 	struct vpe *v;
 
-	if (iminor(file->f_path.dentry->d_inode) != minor)
+	if (iminor(file->f_path.dentry->d_inode) != VPE_MODULE_MINOR)
 		return -ENODEV;
 
-	v = get_vpe(cpu_idx);
+	v = get_vpe(aprp_cpu_index());
 
 	if (v == NULL)
 		return -ENODEV;
 
 	if ((count + v->len) > v->plen) {
-		printk(KERN_WARNING
-		       "VPE loader: elf size too big. Perhaps strip uneeded symbols\n");
+		pr_warn("VPE loader: elf size too big. Perhaps strip uneeded symbols\n");
 		return -ENOMEM;
 	}
 
@@ -1172,7 +899,7 @@ static ssize_t vpe_write(struct file *file, const char __user * buffer,
 	return ret;
 }
 
-static const struct file_operations vpe_fops = {
+const struct file_operations vpe_fops = {
 	.owner = THIS_MODULE,
 	.open = vpe_open,
 	.release = vpe_release,
@@ -1180,96 +907,6 @@ static const struct file_operations vpe_fops = {
 	.llseek = noop_llseek,
 };
 
-#ifndef CONFIG_MIPS_CMP
-/* module wrapper entry points */
-/* give me a vpe */
-vpe_handle vpe_alloc(void)
-{
-	int i;
-	struct vpe *v;
-
-	/* find a vpe */
-	for (i = 1; i < MAX_VPES; i++) {
-		if ((v = get_vpe(i)) != NULL) {
-			v->state = VPE_STATE_INUSE;
-			return v;
-		}
-	}
-	return NULL;
-}
-
-EXPORT_SYMBOL(vpe_alloc);
-
-/* start running from here */
-int vpe_start(vpe_handle vpe, unsigned long start)
-{
-	struct vpe *v = vpe;
-
-	v->__start = start;
-	return vpe_run(v);
-}
-
-EXPORT_SYMBOL(vpe_start);
-
-/* halt it for now */
-int vpe_stop(vpe_handle vpe)
-{
-	struct vpe *v = vpe;
-	struct tc *t;
-	unsigned int evpe_flags;
-
-	evpe_flags = dvpe();
-
-	if ((t = list_entry(v->tc.next, struct tc, tc)) != NULL) {
-
-		settc(t->index);
-		write_vpe_c0_vpeconf0(read_vpe_c0_vpeconf0() & ~VPECONF0_VPA);
-	}
-
-	evpe(evpe_flags);
-
-	return 0;
-}
-
-EXPORT_SYMBOL(vpe_stop);
-
-/* I've done with it thank you */
-int vpe_free(vpe_handle vpe)
-{
-	struct vpe *v = vpe;
-	struct tc *t;
-	unsigned int evpe_flags;
-
-	if ((t = list_entry(v->tc.next, struct tc, tc)) == NULL) {
-		return -ENOEXEC;
-	}
-
-	evpe_flags = dvpe();
-
-	/* Put MVPE's into 'configuration state' */
-	set_c0_mvpcontrol(MVPCONTROL_VPC);
-
-	settc(t->index);
-	write_vpe_c0_vpeconf0(read_vpe_c0_vpeconf0() & ~VPECONF0_VPA);
-
-	/* halt the TC */
-	write_tc_c0_tchalt(TCHALT_H);
-	mips_ihb();
-
-	/* mark the TC unallocated */
-	write_tc_c0_tcstatus(read_tc_c0_tcstatus() & ~TCSTATUS_A);
-
-	v->state = VPE_STATE_UNUSED;
-
-	clear_c0_mvpcontrol(MVPCONTROL_VPC);
-	evpe(evpe_flags);
-
-	return 0;
-}
-
-EXPORT_SYMBOL(vpe_free);
-#endif /* CONFIG_MIPS_CMP */
-
 void *vpe_get_shared(int index)
 {
 	struct vpe *v;
@@ -1331,390 +968,6 @@ char *vpe_getcwd(int index)
 
 EXPORT_SYMBOL(vpe_getcwd);
 
-#ifdef CONFIG_MIPS_CMP
-static ssize_t store_kill(struct device *dev, struct device_attribute *attr,
-			  const char *buf, size_t len)
-{
-	struct vpe *vpe = get_vpe(cpu_idx);
-	struct vpe_notifications *not;
-
-	list_for_each_entry(not, &vpe->notify, list) {
-		not->stop(cpu_idx);
-	}
-
-	release_progmem(vpe->load_addr);
-	vpe->state = VPE_STATE_UNUSED;
-
-	return len;
-}
-
-static ssize_t show_ntcs(struct device *cd, struct device_attribute *attr,
-			 char *buf)
-{
-	struct vpe *vpe = get_vpe(cpu_idx);
-
-	return sprintf(buf, "%d\n", vpe->ntcs);
-}
-
-static ssize_t store_ntcs(struct device *dev, struct device_attribute *attr,
-			  const char *buf, size_t len)
-{
-	struct vpe *vpe = get_vpe(cpu_idx);
-	unsigned long new;
-	int ret;
-
-	ret = kstrtoul(buf, 0, &new);
-	if (ret < 0)
-		return ret;
-
-	if (new != 1)
-		return -EINVAL;
-
-	vpe->ntcs = new;
-
-	return len;
-}
-#else
-static ssize_t store_kill(struct device *dev, struct device_attribute *attr,
-			  const char *buf, size_t len)
-{
-	struct vpe *vpe = get_vpe(cpu_idx);
-	struct vpe_notifications *not;
-
-	list_for_each_entry(not, &vpe->notify, list) {
-		not->stop(cpu_idx);
-	}
-
-	release_progmem(vpe->load_addr);
-	cleanup_tc(get_tc(cpu_idx));
-	vpe_stop(vpe);
-	vpe_free(vpe);
-
-	return len;
-}
-
-static ssize_t show_ntcs(struct device *cd, struct device_attribute *attr,
-			 char *buf)
-{
-	struct vpe *vpe = get_vpe(cpu_idx);
-
-	return sprintf(buf, "%d\n", vpe->ntcs);
-}
-
-static ssize_t store_ntcs(struct device *dev, struct device_attribute *attr,
-			  const char *buf, size_t len)
-{
-	struct vpe *vpe = get_vpe(cpu_idx);
-	unsigned long new;
-	int ret;
-
-	ret = kstrtoul(buf, 0, &new);
-	if (ret < 0)
-		return ret;
-
-	if (new == 0 || new > (hw_tcs - cpu_idx))
-		return -EINVAL;
-
-	vpe->ntcs = new;
-
-	return len;
-}
-#endif /* CONFIG_MIPS_CMP */
-
-static struct device_attribute vpe_class_attributes[] = {
-	__ATTR(kill, S_IWUSR, NULL, store_kill),
-	__ATTR(ntcs, S_IRUGO | S_IWUSR, show_ntcs, store_ntcs),
-	{}
-};
-
-static void vpe_device_release(struct device *cd)
-{
-	kfree(cd);
-}
-
-struct class vpe_class = {
-	.name = "vpe",
-	.owner = THIS_MODULE,
-	.dev_release = vpe_device_release,
-	.dev_attrs = vpe_class_attributes,
-};
-
-struct device vpe_device;
-
-#ifdef CONFIG_MIPS_CMP
-static int __init vpe_module_init(void)
-{
-	struct vpe *v = NULL;
-	struct tc *t;
-	int err;
-
-	if (!cpu_has_mipsmt) {
-		pr_warn("VPE loader: not a MIPS MT capable processor\n");
-		return -ENODEV;
-	}
-
-	cpu_idx = setup_max_cpus;
-
-	if (num_possible_cpus() - cpu_idx < 1) {
-		pr_warn("No VPEs reserved for AP/SP, not initialize VPE loader\n"
-			"Pass maxcpus=<n> argument as kernel argument\n");
-		return -ENODEV;
-	}
-
-	major = register_chrdev(0, module_name, &vpe_fops);
-	if (major < 0) {
-		pr_warn("VPE loader: unable to register character device\n");
-		return major;
-	}
-
-	err = class_register(&vpe_class);
-	if (err) {
-		pr_err("vpe_class registration failed\n");
-		goto out_chrdev;
-	}
-
-	device_initialize(&vpe_device);
-	vpe_device.class	= &vpe_class,
-	vpe_device.parent	= NULL,
-	dev_set_name(&vpe_device, "vpe_sp");
-	vpe_device.devt = MKDEV(major, minor);
-	err = device_add(&vpe_device);
-	if (err) {
-		pr_err("Adding vpe_device failed\n");
-		goto out_class;
-	}
-
-	t = alloc_tc(cpu_idx);
-	if (!t) {
-		pr_warn("VPE: unable to allocate TC\n");
-		err = -ENOMEM;
-		goto out;
-	}
-
-	/* VPE */
-	v = alloc_vpe(cpu_idx);
-	if (v == NULL) {
-		pr_warn("VPE: unable to allocate VPE\n");
-		kfree(t);
-		err = -ENOMEM;
-		goto out;
-	}
-
-	v->ntcs = 1;
-
-	/* add the tc to the list of this vpe's tc's. */
-	list_add(&t->tc, &v->tc);
-
-	/* TC */
-	t->pvpe = v;	/* set the parent vpe */
-
-	return 0;
-
-out_class:
-	class_unregister(&vpe_class);
-out_chrdev:
-	unregister_chrdev(major, module_name);
-
-out:
-	return err;
-}
-#else
-static int __init vpe_module_init(void)
-{
-	unsigned int mtflags, vpflags;
-	unsigned long flags, val;
-	struct vpe *v = NULL;
-	struct tc *t;
-	int tc, err;
-
-	if (!cpu_has_mipsmt) {
-		pr_warn("VPE loader: not a MIPS MT capable processor\n");
-		return -ENODEV;
-	}
-
-	if (vpelimit == 0) {
-		pr_warn("No VPEs reserved for AP/SP, not initialize VPE loader\n"
-			"Pass maxvpes=<n> argument as kernel argument\n");
-
-		return -ENODEV;
-	}
-
-	cpu_idx = tclimit;
-
-	if (cpu_idx == 0) {
-		pr_warn("No TCs reserved for AP/SP, not initialize VPE loader\n"
-			"Pass maxtcs=<n> argument as kernel argument\n");
-
-		return -ENODEV;
-	}
-
-	major = register_chrdev(0, module_name, &vpe_fops);
-	if (major < 0) {
-		pr_warn("VPE loader: unable to register character device\n");
-		return major;
-	}
-
-	err = class_register(&vpe_class);
-	if (err) {
-		pr_err("vpe_class registration failed\n");
-		goto out_chrdev;
-	}
-
-	device_initialize(&vpe_device);
-	vpe_device.class	= &vpe_class,
-	vpe_device.parent	= NULL,
-	dev_set_name(&vpe_device, "vpe1");
-	vpe_device.devt = MKDEV(major, minor);
-	err = device_add(&vpe_device);
-	if (err) {
-		pr_err("Adding vpe_device failed\n");
-		goto out_class;
-	}
-
-	local_irq_save(flags);
-	mtflags = dmt();
-	vpflags = dvpe();
-
-	/* Put MVPE's into 'configuration state' */
-	set_c0_mvpcontrol(MVPCONTROL_VPC);
-
-	/* dump_mtregs(); */
-
-	val = read_c0_mvpconf0();
-	hw_tcs = (val & MVPCONF0_PTC) + 1;
-	hw_vpes = ((val & MVPCONF0_PVPE) >> MVPCONF0_PVPE_SHIFT) + 1;
-
-	for (tc = cpu_idx; tc < hw_tcs; tc++) {
-		/*
-		 * Must re-enable multithreading temporarily or in case we
-		 * reschedule send IPIs or similar we might hang.
-		 */
-		clear_c0_mvpcontrol(MVPCONTROL_VPC);
-		evpe(vpflags);
-		emt(mtflags);
-		local_irq_restore(flags);
-		t = alloc_tc(tc);
-		if (!t) {
-			err = -ENOMEM;
-			goto out;
-		}
-
-		local_irq_save(flags);
-		mtflags = dmt();
-		vpflags = dvpe();
-		set_c0_mvpcontrol(MVPCONTROL_VPC);
-
-		/* VPE's */
-		if (tc < hw_tcs) {
-			settc(tc);
-
-			v = alloc_vpe(tc);
-			if (v == NULL) {
-				pr_warn("VPE: unable to allocate VPE\n");
-
-				goto out_reenable;
-			}
-
-			v->ntcs = hw_tcs - cpu_idx;
-
-			/* add the tc to the list of this vpe's tc's. */
-			list_add(&t->tc, &v->tc);
-
-			/* deactivate all but vpe0 */
-			if (tc >= cpu_idx) {
-				unsigned long tmp = read_vpe_c0_vpeconf0();
-
-				tmp &= ~VPECONF0_VPA;
-
-				/* master VPE */
-				tmp |= VPECONF0_MVP;
-				write_vpe_c0_vpeconf0(tmp);
-			}
-
-			/* disable multi-threading with TC's */
-			write_vpe_c0_vpecontrol(read_vpe_c0_vpecontrol() & ~VPECONTROL_TE);
-
-			if (tc >= vpelimit) {
-				/*
-				 * Set config to be the same as vpe0,
-				 * particularly kseg0 coherency alg
-				 */
-				write_vpe_c0_config(read_c0_config());
-			}
-		}
-
-		/* TC's */
-		t->pvpe = v;	/* set the parent vpe */
-
-		if (tc >= cpu_idx) {
-			unsigned long tmp;
-
-			settc(tc);
-
-			/* Any TC that is bound to VPE0 gets left as is - in case
-			   we are running SMTC on VPE0. A TC that is bound to any
-			   other VPE gets bound to VPE0, ideally I'd like to make
-			   it homeless but it doesn't appear to let me bind a TC
-			   to a non-existent VPE. Which is perfectly reasonable.
-
-			   The (un)bound state is visible to an EJTAG probe so may
-			   notify GDB...
-			*/
-
-			if (((tmp = read_tc_c0_tcbind()) & TCBIND_CURVPE)) {
-				/* tc is bound >vpe0 */
-				write_tc_c0_tcbind(tmp & ~TCBIND_CURVPE);
-
-				t->pvpe = get_vpe(0);	/* set the parent vpe */
-			}
-
-			/* halt the TC */
-			write_tc_c0_tchalt(TCHALT_H);
-			mips_ihb();
-
-			tmp = read_tc_c0_tcstatus();
-
-			/* mark not activated and not dynamically allocatable */
-			tmp &= ~(TCSTATUS_A | TCSTATUS_DA);
-			tmp |= TCSTATUS_IXMT;	/* interrupt exempt */
-			write_tc_c0_tcstatus(tmp);
-		}
-	}
-
-out_reenable:
-	/* release config state */
-	clear_c0_mvpcontrol(MVPCONTROL_VPC);
-
-	evpe(vpflags);
-	emt(mtflags);
-	local_irq_restore(flags);
-
-	return 0;
-
-out_class:
-	class_unregister(&vpe_class);
-out_chrdev:
-	unregister_chrdev(major, module_name);
-
-out:
-	return err;
-}
-#endif /* CONFIG_MIPS_CMP */
-
-static void __exit vpe_module_exit(void)
-{
-	struct vpe *v, *n;
-
-	device_del(&vpe_device);
-	unregister_chrdev(major, module_name);
-
-	/* No locking needed here */
-	list_for_each_entry_safe(v, n, &vpecontrol.vpe_list, list) {
-		if (v->state != VPE_STATE_UNUSED)
-			release_vpe(v);
-	}
-}
-
 module_init(vpe_module_init);
 module_exit(vpe_module_exit);
 MODULE_DESCRIPTION("MIPS VPE Loader");
-- 
1.7.1
