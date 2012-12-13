Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Dec 2012 23:15:54 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:59654 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823110Ab2LMWPwx33lo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Dec 2012 23:15:52 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1TjH3o-0005Th-AF; Thu, 13 Dec 2012 16:15:20 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH v4] MIPS: Make CP0 config registers readable via sysfs.
Date:   Thu, 13 Dec 2012 16:15:15 -0600
Message-Id: <1355436915-24381-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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

From: "Steven J. Hill" <sjhill@mips.com>

Allow reading of CP0 config registers via sysfs for each core
in the system. The registers will show up in sysfs at the path:

   /sys/devices/system/cpu/cpuX/configX

Hotplugging of CPUs is also supported.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/kernel/Makefile |    1 +
 arch/mips/kernel/sysfs.c  |  118 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+)
 create mode 100644 arch/mips/kernel/sysfs.c

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index cc5eec6..0c3eb97 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -97,6 +97,7 @@ obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o
 obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event_mipsxx.o
 
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
+obj-y				+= sysfs.o
 
 ifeq ($(CONFIG_CPU_MIPS32), y)
 #
diff --git a/arch/mips/kernel/sysfs.c b/arch/mips/kernel/sysfs.c
new file mode 100644
index 0000000..1c02471
--- /dev/null
+++ b/arch/mips/kernel/sysfs.c
@@ -0,0 +1,118 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
+ */
+#include <linux/sched.h>
+#include <linux/device.h>
+#include <linux/cpu.h>
+#include <linux/smp.h>
+#include <linux/percpu.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/stat.h>
+
+#include <asm/page.h>
+
+#define read_c0_config0()	read_c0_config()
+
+#define __BUILD_CP0_SYSFS(reg)					\
+static ssize_t show_config##reg(struct device *dev,		\
+		struct device_attribute *attr, char *buf)	\
+{								\
+	int n = snprintf(buf, PAGE_SIZE-2, "%x\n",		\
+		read_c0_config##reg());				\
+	return n;						\
+}								\
+static DEVICE_ATTR(config##reg, S_IRUGO, show_config##reg, NULL);
+
+__BUILD_CP0_SYSFS(0)
+__BUILD_CP0_SYSFS(1)
+__BUILD_CP0_SYSFS(2)
+__BUILD_CP0_SYSFS(3)
+__BUILD_CP0_SYSFS(4)
+__BUILD_CP0_SYSFS(5)
+__BUILD_CP0_SYSFS(6)
+__BUILD_CP0_SYSFS(7)
+
+static DEFINE_PER_CPU(unsigned int, nregs);
+
+#define __CREATE_CONFIG_ENTRY(reg)			\
+if (ok)	{						\
+	device_create_file(dev, &dev_attr_config##reg);	\
+	ok = read_c0_config##reg() & MIPS_CONF_M;	\
+	per_cpu(nregs, cpu)++;				\
+}
+
+#define __DELETE_CONFIG_ENTRY(reg)			\
+if (reg < per_cpu(nregs, cpu))				\
+	device_remove_file(dev, &dev_attr_config##reg);
+
+static void create_cp0_entries(unsigned int cpu)
+{
+	struct device *dev = get_cpu_device(cpu);
+	int ok = 1;
+
+	per_cpu(nregs, cpu) = 0;
+	__CREATE_CONFIG_ENTRY(0);
+	__CREATE_CONFIG_ENTRY(1);
+	__CREATE_CONFIG_ENTRY(2);
+	__CREATE_CONFIG_ENTRY(3);
+	__CREATE_CONFIG_ENTRY(4);
+	__CREATE_CONFIG_ENTRY(5);
+	__CREATE_CONFIG_ENTRY(6);
+	__CREATE_CONFIG_ENTRY(7);
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+static void delete_cp0_entries(unsigned int cpu)
+{
+	struct device *dev = get_cpu_device(cpu);
+
+	__DELETE_CONFIG_ENTRY(0);
+	__DELETE_CONFIG_ENTRY(1);
+	__DELETE_CONFIG_ENTRY(2);
+	__DELETE_CONFIG_ENTRY(3);
+	__DELETE_CONFIG_ENTRY(4);
+	__DELETE_CONFIG_ENTRY(5);
+	__DELETE_CONFIG_ENTRY(6);
+	__DELETE_CONFIG_ENTRY(7);
+}
+#endif
+
+static int __cpuinit sysfs_cpu_notify(struct notifier_block *self,
+				      unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (unsigned int)(long)hcpu;
+
+	switch (action) {
+	case CPU_ONLINE:
+	case CPU_ONLINE_FROZEN:
+		create_cp0_entries(cpu);
+		break;
+#ifdef CONFIG_HOTPLUG_CPU
+	case CPU_DEAD:
+	case CPU_DEAD_FROZEN:
+		delete_cp0_entries(cpu);
+		break;
+#endif
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block __cpuinitdata sysfs_cpu_nb = {
+	.notifier_call	= sysfs_cpu_notify,
+};
+
+static int __init sysfs_mips_config_registers(void)
+{
+	int i;
+
+	for_each_online_cpu(i)
+		create_cp0_entries(i);
+	register_cpu_notifier(&sysfs_cpu_nb);
+	return 0;
+}
+subsys_initcall(sysfs_mips_config_registers);
-- 
1.7.9.5
