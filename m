Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Oct 2013 21:52:27 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:58368 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825697Ab3J3UwYdZCKX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Oct 2013 21:52:24 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1VbckT-0001UG-VX; Wed, 30 Oct 2013 15:52:18 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>, ralf@linux-mips.org,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: [PATCH 2/6] MIPS: APRP: Add VPE loader support for CMP platforms.
Date:   Wed, 30 Oct 2013 15:52:07 -0500
Message-Id: <1383166331-9921-3-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1383166331-9921-1-git-send-email-Steven.Hill@imgtec.com>
References: <1383166331-9921-1-git-send-email-Steven.Hill@imgtec.com>
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38416
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

This patch adds VPE loader support for platforms having a CMP.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
Reviewed-by: Qais Yousef <Qais.Yousef@imgtec.com>
---
 arch/mips/Kconfig          |    5 ++
 arch/mips/kernel/Makefile  |    1 +
 arch/mips/kernel/vpe-cmp.c |  180 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+)
 create mode 100644 arch/mips/kernel/vpe-cmp.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index cc2f283..4c5290e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1919,6 +1919,11 @@ config MIPS_VPE_LOADER
 	  Includes a loader for loading an elf relocatable object
 	  onto another VPE and running it.
 
+config MIPS_VPE_LOADER_CMP
+	bool
+	default "y"
+	depends on MIPS_VPE_LOADER && MIPS_CMP
+
 config MIPS_VPE_LOADER_MT
 	bool
 	default "y"
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 3b9ab45..7f538d1 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_MIPS_CMP)		+= smp-cmp.o
 obj-$(CONFIG_CPU_MIPSR2)	+= spram.o
 
 obj-$(CONFIG_MIPS_VPE_LOADER)	+= vpe.o
+obj-$(CONFIG_MIPS_VPE_LOADER_CMP) += vpe-cmp.o
 obj-$(CONFIG_MIPS_VPE_LOADER_MT) += vpe-mt.o
 obj-$(CONFIG_MIPS_VPE_APSP_API) += rtlx.o
 
diff --git a/arch/mips/kernel/vpe-cmp.c b/arch/mips/kernel/vpe-cmp.c
new file mode 100644
index 0000000..9268ebc
--- /dev/null
+++ b/arch/mips/kernel/vpe-cmp.c
@@ -0,0 +1,180 @@
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
+#include <asm/vpe.h>
+
+static int major;
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
+	struct vpe_notifications *notifier;
+
+	list_for_each_entry(notifier, &vpe->notify, list)
+		notifier->stop(aprp_cpu_index());
+
+	release_progmem(vpe->load_addr);
+	vpe->state = VPE_STATE_UNUSED;
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
+	/* APRP can only reserve one TC in a VPE and no more. */
+	if (new != 1)
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
+		goto out_dev;
+	}
+
+	/* VPE */
+	v = alloc_vpe(aprp_cpu_index());
+	if (v == NULL) {
+		pr_warn("VPE: unable to allocate VPE\n");
+		kfree(t);
+		err = -ENOMEM;
+		goto out_dev;
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
+	list_for_each_entry_safe(v, n, &vpecontrol.vpe_list, list)
+		if (v->state != VPE_STATE_UNUSED)
+			release_vpe(v);
+}
-- 
1.7.9.5
