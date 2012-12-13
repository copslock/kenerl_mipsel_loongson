Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Dec 2012 09:53:59 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:58347 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824762Ab2LMIx6ZduUe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Dec 2012 09:53:58 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Tj4Y9-0004iP-AN; Thu, 13 Dec 2012 02:53:49 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH v3] MIPS: Make CP0 config registers readable via sysfs.
Date:   Thu, 13 Dec 2012 02:53:44 -0600
Message-Id: <1355388824-7655-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35279
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

Only CP0 config registers 0 through 7 are currently supported.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/kernel/Makefile |    1 +
 arch/mips/kernel/sysfs.c  |   68 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)
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
index 0000000..4f26349
--- /dev/null
+++ b/arch/mips/kernel/sysfs.c
@@ -0,0 +1,68 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
+ */
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/cpu.h>
+#include <linux/percpu.h>
+
+#include <asm/page.h>
+
+/* Convenience macro */
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
+static DEVICE_ATTR(config##reg, 0444, show_config##reg, NULL);
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
+#define __CHECK_CONFIG_EXIST(reg)			\
+if (ok)	{						\
+	device_create_file(dev, &dev_attr_config##reg);	\
+	ok = read_c0_config##reg() & MIPS_CONF_M;	\
+}
+
+static void read_c0_registers(void *arg)
+{
+	struct device *dev = get_cpu_device(smp_processor_id());
+	int ok = 1;
+
+	__CHECK_CONFIG_EXIST(0);
+	__CHECK_CONFIG_EXIST(1);
+	__CHECK_CONFIG_EXIST(2);
+	__CHECK_CONFIG_EXIST(3);
+	__CHECK_CONFIG_EXIST(4);
+	__CHECK_CONFIG_EXIST(5);
+	__CHECK_CONFIG_EXIST(6);
+	__CHECK_CONFIG_EXIST(7);
+}
+
+static int __init mips_sysfs_registers(void)
+{
+	/* Not CPU hotplug safe. */
+#ifndef CONFIG_HOTPLUG_CPU
+	on_each_cpu(read_c0_registers, NULL, 1);
+	return 0;
+#else
+	return 1;
+#endif
+}
+late_initcall(mips_sysfs_registers);
-- 
1.7.9.5
