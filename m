Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Dec 2012 09:47:56 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:58333 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823911Ab2LMIrzVjRQm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Dec 2012 09:47:55 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Tj4Rz-0004iA-1I; Thu, 13 Dec 2012 02:47:27 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH v2] MIPS: Make CP0 config registers readable via sysfs.
Date:   Thu, 13 Dec 2012 02:47:21 -0600
Message-Id: <1355388441-6762-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35278
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
 arch/mips/kernel/sysfs.c  |   93 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)
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
index 0000000..a64f559
--- /dev/null
+++ b/arch/mips/kernel/sysfs.c
@@ -0,0 +1,93 @@
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
+
+#define __BUILD_CP0_SYSFS(reg)					\
+static DEFINE_PER_CPU(unsigned int, cpu_config##reg);		\
+static ssize_t show_config##reg(struct device *dev,		\
+		struct device_attribute *attr, char *buf)	\
+{								\
+	struct cpu *cpu = container_of(dev, struct cpu, dev);	\
+	int n = snprintf(buf, PAGE_SIZE-2, "%x\n",		\
+		per_cpu(cpu_config##reg, cpu->dev.id));		\
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
+static void read_c0_registers(void *arg)
+{
+	struct device *dev = get_cpu_device(smp_processor_id());
+	struct cpu *cpu;
+	int ok;
+
+	if (dev != NULL) {
+		cpu = container_of(dev, struct cpu, dev);
+		per_cpu(cpu_config0, cpu->dev.id) = read_c0_config();
+		device_create_file(dev, &dev_attr_config0);
+		ok = per_cpu(cpu_config0, cpu->dev.id) & MIPS_CONF_M;
+	} else
+		return;
+
+	if (ok) {
+		per_cpu(cpu_config1, cpu->dev.id) = read_c0_config1();
+		device_create_file(dev, &dev_attr_config1);
+		ok = per_cpu(cpu_config1, cpu->dev.id) & MIPS_CONF_M;
+	}
+	if (ok) {
+		per_cpu(cpu_config2, cpu->dev.id) = read_c0_config2();
+		device_create_file(dev, &dev_attr_config2);
+		ok = per_cpu(cpu_config2, cpu->dev.id) & MIPS_CONF_M;
+	}
+	if (ok) {
+		per_cpu(cpu_config3, cpu->dev.id) = read_c0_config3();
+		device_create_file(dev, &dev_attr_config3);
+		ok = per_cpu(cpu_config3, cpu->dev.id) & MIPS_CONF_M;
+	}
+	if (ok) {
+		per_cpu(cpu_config4, cpu->dev.id) = read_c0_config4();
+		device_create_file(dev, &dev_attr_config4);
+		ok = per_cpu(cpu_config4, cpu->dev.id) & MIPS_CONF_M;
+	}
+	if (ok) {
+		per_cpu(cpu_config5, cpu->dev.id) = read_c0_config5();
+		device_create_file(dev, &dev_attr_config5);
+		ok = per_cpu(cpu_config5, cpu->dev.id) & MIPS_CONF_M;
+	}
+	if (ok) {
+		per_cpu(cpu_config6, cpu->dev.id) = read_c0_config6();
+		device_create_file(dev, &dev_attr_config6);
+		ok = per_cpu(cpu_config6, cpu->dev.id) & MIPS_CONF_M;
+	}
+	if (ok) {
+		per_cpu(cpu_config7, cpu->dev.id) = read_c0_config7();
+		device_create_file(dev, &dev_attr_config7);
+		ok = per_cpu(cpu_config7, cpu->dev.id) & MIPS_CONF_M;
+	}
+}
+
+static int __init mips_sysfs_registers(void)
+{
+	on_each_cpu(read_c0_registers, NULL, 1);
+	return 0;
+}
+late_initcall(mips_sysfs_registers);
-- 
1.7.9.5
