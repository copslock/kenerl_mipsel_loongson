Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Oct 2013 04:15:31 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:52409 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6818323Ab3JQCOqUM0pJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Oct 2013 04:14:46 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1VWd6l-00047p-2u; Wed, 16 Oct 2013 21:14:39 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>, ralf@linux-mips.org,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: [PATCH 1/6] MIPS: APRP: Split VPE loader into separate files.
Date:   Wed, 16 Oct 2013 21:14:25 -0500
Message-Id: <1381976070-8413-2-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1381976070-8413-1-git-send-email-Steven.Hill@imgtec.com>
References: <1381976070-8413-1-git-send-email-Steven.Hill@imgtec.com>
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38358
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

Split the VPE functionality in preparation for adding support
for CMP platforms. Common functions remain in the original file
and a new file contains code specific to platforms that do not
have a CMP present.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
Reviewed-by: Qais Yousef <Qais.Yousef@imgtec.com>
---
 arch/mips/include/asm/vpe.h |  117 +++++++-
 arch/mips/kernel/Makefile   |    2 +-
 arch/mips/kernel/vpe-mt.c   |  523 ++++++++++++++++++++++++++++++++++
 arch/mips/kernel/vpe.c      |  647 ++-----------------------------------------
 4 files changed, 655 insertions(+), 634 deletions(-)
 create mode 100644 arch/mips/kernel/vpe-mt.c

diff --git a/arch/mips/include/asm/vpe.h b/arch/mips/include/asm/vpe.h
index c6e1b96..becd555 100644
--- a/arch/mips/include/asm/vpe.h
+++ b/arch/mips/include/asm/vpe.h
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2005 MIPS Technologies, Inc.  All rights reserved.
+ * Copyright (C) 2013 Imagination Technologies Ltd.
  *
  *  This program is free software; you can distribute it and/or modify it
  *  under the terms of the GNU General Public License (Version 2) as
@@ -19,6 +20,88 @@
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
@@ -26,12 +109,36 @@ struct vpe_notifications {
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
+int __weak vpe_run(struct vpe *v);
+void cleanup_tc(struct tc *tc);
 
+int __init vpe_module_init(void);
+void __exit vpe_module_exit(void);
 #endif /* _ASM_VPE_H */
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 1c1b717..51f9117 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -54,7 +54,7 @@ obj-$(CONFIG_MIPS_MT_SMP)	+= smp-mt.o
 obj-$(CONFIG_MIPS_CMP)		+= smp-cmp.o
 obj-$(CONFIG_CPU_MIPSR2)	+= spram.o
 
-obj-$(CONFIG_MIPS_VPE_LOADER)	+= vpe.o
+obj-$(CONFIG_MIPS_VPE_LOADER)	+= vpe.o vpe-mt.o
 obj-$(CONFIG_MIPS_VPE_APSP_API) += rtlx.o
 
 obj-$(CONFIG_I8259)		+= i8259.o
diff --git a/arch/mips/kernel/vpe-mt.c b/arch/mips/kernel/vpe-mt.c
new file mode 100644
index 0000000..45abe9a
--- /dev/null
+++ b/arch/mips/kernel/vpe-mt.c
@@ -0,0 +1,523 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004, 2005 MIPS Technologies, Inc.  All rights reserved.
+ * Copyright (C) 2013 Imagination Technologies Ltd.
+ */
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
+
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
+	if (list_empty(&v->tc)) {
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
+	t = list_first_entry(&v->tc, struct tc, tc);
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
+	struct vpe_notifications *notifier;
+
+	list_for_each_entry(notifier, &vpe->notify, list)
+		notifier->stop(aprp_cpu_index());
+
+	release_progmem(vpe->load_addr);
+	cleanup_tc(get_tc(aprp_cpu_index()));
+	vpe_stop(vpe);
+	vpe_free(vpe);
+
+	return len;
+}
+static DEVICE_ATTR(kill, S_IWUSR, NULL, store_kill);
+
+static ssize_t ntcs_show(struct device *cd, struct device_attribute *attr,
+			 char *buf)
+{
+	struct vpe *vpe = get_vpe(aprp_cpu_index());
+
+	return sprintf(buf, "%d\n", vpe->ntcs);
+}
+
+static ssize_t ntcs_store(struct device *dev, struct device_attribute *attr,
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
+static DEVICE_ATTR_RW(ntcs);
+
+static struct attribute *vpe_attrs[] = {
+	&dev_attr_kill.attr,
+	&dev_attr_ntcs.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(vpe);
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
+	.dev_groups = vpe_groups,
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
+			goto out_dev;
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
+out_dev:
+	device_del(&vpe_device);
+
+out_class:
+	class_unregister(&vpe_class);
+
+out_chrdev:
+	unregister_chrdev(major, VPE_MODULE_NAME);
+
+	return err;
+}
+
+void __exit vpe_module_exit(void)
+{
+	struct vpe *v, *n;
+
+	device_del(&vpe_device);
+	class_unregister(&vpe_class);
+	unregister_chrdev(major, VPE_MODULE_NAME);
+
+	/* No locking needed here */
+	list_for_each_entry_safe(v, n, &vpecontrol.vpe_list, list) {
+		if (v->state != VPE_STATE_UNUSED)
+			release_vpe(v);
+	}
+}
diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index 59b2b3c..61dfd5b 100644
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
@@ -60,96 +58,15 @@ typedef void *vpe_handle;
 /* If this is set, the section belongs in the init part of the module */
 #define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG-1))
 
-/*
- * The number of TCs and VPEs physically available on the core
- */
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
 
@@ -159,7 +76,7 @@ static struct vpe *get_vpe(int minor)
 	res = NULL;
 	spin_lock(&vpecontrol.vpe_list_lock);
 	list_for_each_entry(v, &vpecontrol.vpe_list, list) {
-		if (v->minor == minor) {
+		if (v->minor == VPE_MODULE_MINOR) {
 			res = v;
 			break;
 		}
@@ -170,7 +87,7 @@ static struct vpe *get_vpe(int minor)
 }
 
 /* get the vpe associated with this minor */
-static struct tc *get_tc(int index)
+struct tc *get_tc(int index)
 {
 	struct tc *res, *t;
 
@@ -188,7 +105,7 @@ static struct tc *get_tc(int index)
 }
 
 /* allocate a vpe and associate it with this minor (or index) */
-static struct vpe *alloc_vpe(int minor)
+struct vpe *alloc_vpe(int minor)
 {
 	struct vpe *v;
 
@@ -201,13 +118,13 @@ static struct vpe *alloc_vpe(int minor)
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
 
@@ -226,7 +143,7 @@ out:
 }
 
 /* clean up and free everything */
-static void release_vpe(struct vpe *v)
+void release_vpe(struct vpe *v)
 {
 	list_del(&v->list);
 	if (v->load_addr)
@@ -234,28 +151,8 @@ static void release_vpe(struct vpe *v)
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
 /* Find some VPE program space	*/
-static void *alloc_progmem(unsigned long len)
+void *alloc_progmem(unsigned long len)
 {
 	void *addr;
 
@@ -274,7 +171,7 @@ static void *alloc_progmem(unsigned long len)
 	return addr;
 }
 
-static void release_progmem(void *ptr)
+void release_progmem(void *ptr)
 {
 #ifndef CONFIG_MIPS_VPE_LOADER_TOM
 	kfree(ptr);
@@ -675,127 +572,6 @@ static void dump_elfsymbols(Elf_Shdr * sechdrs, unsigned int symindex,
 }
 #endif
 
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
-		printk(KERN_WARNING
-		       "VPE loader: only Master VPE's are allowed to configure MT\n");
-		local_irq_restore(flags);
-
-		return -1;
-	}
-
-	dmt_flag = dmt();
-	vpeflags = dvpe();
-
-	if (list_empty(&v->tc)) {
-		evpe(vpeflags);
-		emt(dmt_flag);
-		local_irq_restore(flags);
-
-		printk(KERN_WARNING
-		       "VPE loader: No TC's associated with VPE %d\n",
-		       v->minor);
-
-		return -ENOEXEC;
-	}
-
-	t = list_first_entry(&v->tc, struct tc, tc);
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
-		printk(KERN_WARNING "VPE loader: TC %d is already active!\n",
-		       t->index);
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
-			      | (t->index << VPECONF0_XTC_SHIFT));
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
-
 static int find_vpe_symbols(struct vpe * v, Elf_Shdr * sechdrs,
 				      unsigned int symindex, const char *strtab,
 				      struct module *mod)
@@ -993,38 +769,6 @@ static int vpe_elfload(struct vpe * v)
 	return 0;
 }
 
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
-
 static int getcwd(char *buff, int size)
 {
 	mm_segment_t old_fs;
@@ -1048,14 +792,14 @@ static int vpe_open(struct inode *inode, struct file *filp)
 	struct vpe *v;
 	int ret;
 
-	if (minor != iminor(inode)) {
+	if (VPE_MODULE_MINOR != iminor(inode)) {
 		/* assume only 1 device at the moment. */
 		pr_warning("VPE loader: only vpe1 is supported\n");
 
 		return -ENODEV;
 	}
 
-	if ((v = get_vpe(tclimit)) == NULL) {
+	if ((v = get_vpe(aprp_cpu_index())) == NULL) {
 		pr_warning("VPE loader: unable to get vpe\n");
 
 		return -ENODEV;
@@ -1066,11 +810,11 @@ static int vpe_open(struct inode *inode, struct file *filp)
 		printk(KERN_DEBUG "VPE loader: tc in use dumping regs\n");
 
 		list_for_each_entry(not, &v->notify, list) {
-			not->stop(tclimit);
+			not->stop(aprp_cpu_index());
 		}
 
 		release_progmem(v->load_addr);
-		cleanup_tc(get_tc(tclimit));
+		cleanup_tc(get_tc(aprp_cpu_index()));
 	}
 
 	/* this of-course trashes what was there before... */
@@ -1103,13 +847,13 @@ static int vpe_release(struct inode *inode, struct file *filp)
 	Elf_Ehdr *hdr;
 	int ret = 0;
 
-	v = get_vpe(tclimit);
+	v = get_vpe(aprp_cpu_index());
 	if (v == NULL)
 		return -ENODEV;
 
 	hdr = (Elf_Ehdr *) v->pbuffer;
 	if (memcmp(hdr->e_ident, ELFMAG, SELFMAG) == 0) {
-		if (vpe_elfload(v) >= 0) {
+		if ((vpe_elfload(v) >= 0) && vpe_run) {
 			vpe_run(v);
 		} else {
 			printk(KERN_WARNING "VPE loader: ELF load failed.\n");
@@ -1140,10 +884,10 @@ static ssize_t vpe_write(struct file *file, const char __user * buffer,
 	size_t ret = count;
 	struct vpe *v;
 
-	if (iminor(file_inode(file)) != minor)
+	if (iminor(file_inode(file)) != VPE_MODULE_MINOR)
 		return -ENODEV;
 
-	v = get_vpe(tclimit);
+	v = get_vpe(aprp_cpu_index());
 	if (v == NULL)
 		return -ENODEV;
 
@@ -1161,7 +905,7 @@ static ssize_t vpe_write(struct file *file, const char __user * buffer,
 	return ret;
 }
 
-static const struct file_operations vpe_fops = {
+const struct file_operations vpe_fops = {
 	.owner = THIS_MODULE,
 	.open = vpe_open,
 	.release = vpe_release,
@@ -1169,94 +913,6 @@ static const struct file_operations vpe_fops = {
 	.llseek = noop_llseek,
 };
 
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
-
 void *vpe_get_shared(int index)
 {
 	struct vpe *v;
@@ -1318,271 +974,6 @@ char *vpe_getcwd(int index)
 
 EXPORT_SYMBOL(vpe_getcwd);
 
-static ssize_t store_kill(struct device *dev, struct device_attribute *attr,
-			  const char *buf, size_t len)
-{
-	struct vpe *vpe = get_vpe(tclimit);
-	struct vpe_notifications *not;
-
-	list_for_each_entry(not, &vpe->notify, list) {
-		not->stop(tclimit);
-	}
-
-	release_progmem(vpe->load_addr);
-	cleanup_tc(get_tc(tclimit));
-	vpe_stop(vpe);
-	vpe_free(vpe);
-
-	return len;
-}
-static DEVICE_ATTR(kill, S_IWUSR, NULL, store_kill);
-
-static ssize_t ntcs_show(struct device *cd, struct device_attribute *attr,
-			 char *buf)
-{
-	struct vpe *vpe = get_vpe(tclimit);
-
-	return sprintf(buf, "%d\n", vpe->ntcs);
-}
-
-static ssize_t ntcs_store(struct device *dev, struct device_attribute *attr,
-			  const char *buf, size_t len)
-{
-	struct vpe *vpe = get_vpe(tclimit);
-	unsigned long new;
-	char *endp;
-
-	new = simple_strtoul(buf, &endp, 0);
-	if (endp == buf)
-		goto out_einval;
-
-	if (new == 0 || new > (hw_tcs - tclimit))
-		goto out_einval;
-
-	vpe->ntcs = new;
-
-	return len;
-
-out_einval:
-	return -EINVAL;
-}
-static DEVICE_ATTR_RW(ntcs);
-
-static struct attribute *vpe_attrs[] = {
-	&dev_attr_kill.attr,
-	&dev_attr_ntcs.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(vpe);
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
-	.dev_groups = vpe_groups,
-};
-
-struct device vpe_device;
-
-static int __init vpe_module_init(void)
-{
-	unsigned int mtflags, vpflags;
-	unsigned long flags, val;
-	struct vpe *v = NULL;
-	struct tc *t;
-	int tc, err;
-
-	if (!cpu_has_mipsmt) {
-		printk("VPE loader: not a MIPS MT capable processor\n");
-		return -ENODEV;
-	}
-
-	if (vpelimit == 0) {
-		printk(KERN_WARNING "No VPEs reserved for AP/SP, not "
-		       "initializing VPE loader.\nPass maxvpes=<n> argument as "
-		       "kernel argument\n");
-
-		return -ENODEV;
-	}
-
-	if (tclimit == 0) {
-		printk(KERN_WARNING "No TCs reserved for AP/SP, not "
-		       "initializing VPE loader.\nPass maxtcs=<n> argument as "
-		       "kernel argument\n");
-
-		return -ENODEV;
-	}
-
-	major = register_chrdev(0, module_name, &vpe_fops);
-	if (major < 0) {
-		printk("VPE loader: unable to register character device\n");
-		return major;
-	}
-
-	err = class_register(&vpe_class);
-	if (err) {
-		printk(KERN_ERR "vpe_class registration failed\n");
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
-		printk(KERN_ERR "Adding vpe_device failed\n");
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
-	for (tc = tclimit; tc < hw_tcs; tc++) {
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
-			if ((v = alloc_vpe(tc)) == NULL) {
-				printk(KERN_WARNING "VPE: unable to allocate VPE\n");
-
-				goto out_reenable;
-			}
-
-			v->ntcs = hw_tcs - tclimit;
-
-			/* add the tc to the list of this vpe's tc's. */
-			list_add(&t->tc, &v->tc);
-
-			/* deactivate all but vpe0 */
-			if (tc >= tclimit) {
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
-		if (tc >= tclimit) {
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
1.7.9.5
