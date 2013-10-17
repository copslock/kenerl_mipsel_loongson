Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Oct 2013 04:16:12 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:52414 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822674Ab3JQCOrRhK8T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Oct 2013 04:14:47 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1VWd6n-00047p-3K; Wed, 16 Oct 2013 21:14:41 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>, ralf@linux-mips.org,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: [PATCH 4/6] MIPS: APRP: Add RTLX API support for CMP platforms.
Date:   Wed, 16 Oct 2013 21:14:28 -0500
Message-Id: <1381976070-8413-5-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1381976070-8413-1-git-send-email-Steven.Hill@imgtec.com>
References: <1381976070-8413-1-git-send-email-Steven.Hill@imgtec.com>
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38360
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

This patch adds RTLX API support for platforms having a CMP.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
Reviewed-by: Qais Yousef <Qais.Yousef@imgtec.com>
---
 arch/mips/include/asm/rtlx.h |    1 +
 arch/mips/kernel/Makefile    |    2 +-
 arch/mips/kernel/rtlx-cmp.c  |  120 ++++++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/rtlx-mt.c   |    4 ++
 4 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/kernel/rtlx-cmp.c

diff --git a/arch/mips/include/asm/rtlx.h b/arch/mips/include/asm/rtlx.h
index 6766026..fa86dfd 100644
--- a/arch/mips/include/asm/rtlx.h
+++ b/arch/mips/include/asm/rtlx.h
@@ -78,6 +78,7 @@ struct rtlx_channel {
 extern struct rtlx_info {
 	unsigned long id;
 	enum rtlx_state state;
+	int ap_int_pending;	/* Status of 0 or 1 for CONFIG_MIPS_CMP only */
 
 	struct rtlx_channel channel[RTLX_CHANNELS];
 } *rtlx;
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 2a8a272..91c8d5b 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -55,7 +55,7 @@ obj-$(CONFIG_MIPS_CMP)		+= smp-cmp.o
 obj-$(CONFIG_CPU_MIPSR2)	+= spram.o
 
 obj-$(CONFIG_MIPS_VPE_LOADER)	+= vpe.o vpe-cmp.o vpe-mt.o
-obj-$(CONFIG_MIPS_VPE_APSP_API) += rtlx.o rtlx-mt.o
+obj-$(CONFIG_MIPS_VPE_APSP_API) += rtlx.o rtlx-cmp.o rtlx-mt.o
 
 obj-$(CONFIG_I8259)		+= i8259.o
 obj-$(CONFIG_IRQ_CPU)		+= irq_cpu.o
diff --git a/arch/mips/kernel/rtlx-cmp.c b/arch/mips/kernel/rtlx-cmp.c
new file mode 100644
index 0000000..0171cb3
--- /dev/null
+++ b/arch/mips/kernel/rtlx-cmp.c
@@ -0,0 +1,120 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2005 MIPS Technologies, Inc.  All rights reserved.
+ * Copyright (C) 2013 Imagination Technologies Ltd.
+ */
+#ifdef CONFIG_MIPS_CMP
+
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/err.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
+
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
+		goto out_class;
+	}
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
+
+#endif /* CONFIG_MIPS_CMP */
diff --git a/arch/mips/kernel/rtlx-mt.c b/arch/mips/kernel/rtlx-mt.c
index 91d61ba..80c408a 100644
--- a/arch/mips/kernel/rtlx-mt.c
+++ b/arch/mips/kernel/rtlx-mt.c
@@ -6,6 +6,8 @@
  * Copyright (C) 2005 MIPS Technologies, Inc.  All rights reserved.
  * Copyright (C) 2013 Imagination Technologies Ltd.
  */
+#ifndef CONFIG_MIPS_CMP
+
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/err.h>
@@ -146,3 +148,5 @@ void __exit rtlx_module_exit(void)
 		device_destroy(mt_class, MKDEV(major, i));
 	unregister_chrdev(major, RTLX_MODULE_NAME);
 }
+
+#endif /* CONFIG_MIPS_CMP */
-- 
1.7.9.5
