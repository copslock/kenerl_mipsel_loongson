Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2012 10:14:46 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:38784 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903733Ab2FGIOc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2012 10:14:32 +0200
Received: by mail-pb0-f49.google.com with SMTP id rq13so748925pbb.36
        for <linux-mips@linux-mips.org>; Thu, 07 Jun 2012 01:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:from:to:cc:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding:x-gm-message-state;
        bh=tIr06geBlF1SzOK+743RWpKdvH9XUwPWAAkdz7dmQgQ=;
        b=QbV/x2x3C0vDwDUj+F+qdtijt6FhJVFjXZD3B1a+eK+ZFUoqKATAJjnLu4P0T3p+Pp
         kJEKFvla/Ib0SkBBzVCjk0GnklV0HVeMZDu1oA5iNfiuckvAAWie5hoF6xq0upM7GXWN
         1fBXjbjitd6tTMF+oBubZPNf3+GVvD0CgG5Im8aC3RhvbNVTK9DFTQT8eolz2rq5z4+W
         nwp1NIKgP7UDriTOpH9urNJXpL2kTM2Fw1qh3ejtNJ8gcCR/M7DJzaMNYIkti3HQn+Nj
         7wMT8gUHfxGZliWSn0ztcXARF5WvdlFn2y3K1h4KFeO3OFfxk+X/7cGsWHKzEYiGE+Jh
         Q61Q==
Received: by 10.68.239.164 with SMTP id vt4mr5685875pbc.166.1339056872029;
        Thu, 07 Jun 2012 01:14:32 -0700 (PDT)
Received: from [10.0.0.4] ([115.118.107.144])
        by mx.google.com with ESMTPS id wn3sm3300832pbc.74.2012.06.07.01.14.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jun 2012 01:14:31 -0700 (PDT)
Subject: [PATCH 2/2] Octeon 6xxx: Add Power Throttling support for CN6xxx
 and above
From:   philby john <pjohn@mvista.com>
To:     linux-mips@linux-mips.org
Cc:     david.daney@caviumnetworks.com, prasun.kapoor@caviumnetworks.com,
        ralf@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 07 Jun 2012 13:46:06 +0530
Message-ID: <1339056966.15045.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-1.fc14)
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkTN1MWWlb6/0RpA6fvpGvgqKhWqG3f76u0lvcW4vrIWRG8TqtRHG/44POj4cB3HOTb24vb
X-archive-position: 33596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pjohn@mvista.com
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

>From 9d9f2b330ad635dff9aa141cd96bde2907385032 Mon Sep 17 00:00:00 2001
From: Philby John <pjohn@mvista.com>
Date: Thu, 7 Jun 2012 12:09:31 +0530
Subject: [PATCH] Octeon 6xxx: Add Power Throttling support for CN6xxx and above

This patch adds the sysfs primitives for power throttling.

Octeon2 supports dynamic power control which aids to cut down power
consumption. The code exposes a "percentage" power throttling
limiter by means of /sys interface for each available cpu. Setting
this value to 0 will set power consumption to a minimum as it will
only execute a couple instructions every PERIOD as set in the
PowThrottle register. If set to 100% for that particular cpu, it
will consume maximum power.

Signed-off-by: Philby John <pjohn@mvista.com>
---
 arch/mips/cavium-octeon/Kconfig             |   12 ++
 arch/mips/cavium-octeon/Makefile            |    1 +
 arch/mips/cavium-octeon/octeon_pwr_throtl.c |  177 +++++++++++++++++++++++++++
 3 files changed, 190 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/cavium-octeon/octeon_pwr_throtl.c

diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index f9e275a..7a7f7e7 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -97,5 +97,17 @@ config SWIOTLB
 	select IOMMU_HELPER
 	select NEED_SG_DMA_LENGTH
 
+config CAVIUM_POWER_THROTTLING
+	bool "Enable support for power throttling on Octeon 63xx and above"
+	depends on CPU_CAVIUM_OCTEON
+	default n
+	help
+	  On Octeon 6xxx and above dynamic power can be controlled
+	  by setting the PowThrottle registers for each cpu. This could be
+	  beneficial for lower power consumption requirements.
+
+	  If your application makes extensive use of high-energy instructions
+	  (such as Octeon cryptographic accleration) it's better to leave this
+	  option disabled as it may have slight impact on performance.
 
 endif # CPU_CAVIUM_OCTEON
diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
index 19eb043..912f9bb 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -15,3 +15,4 @@ obj-y += octeon-memcpy.o
 obj-y += executive/
 
 obj-$(CONFIG_SMP)                     += smp.o
+obj-$(CONFIG_CAVIUM_POWER_THROTTLING) += octeon_pwr_throtl.o
diff --git a/arch/mips/cavium-octeon/octeon_pwr_throtl.c b/arch/mips/cavium-octeon/octeon_pwr_throtl.c
new file mode 100644
index 0000000..6348cc1
--- /dev/null
+++ b/arch/mips/cavium-octeon/octeon_pwr_throtl.c
@@ -0,0 +1,177 @@
+/*
+ * octeon_pwr_throtl.c - interface for controlling power throttling on Octeon
+ * based platforms 6xxx and above.
+ * Octeon2 supports dynamic power control which aids to cut down power
+ * consumption. The code exposes a "percentage" power throttling limiter by
+ * means of /sys interface for each available cpu. Setting this value to 0
+ * will set power consumption to a minimum as it will only execute a couple
+ * instructions every PERIOD as set in the PowThrottle register.
+ * If set to 100% for that particular cpu; will consume maximum power.
+ *
+ * Copyright (C) 2012 MontaVista LLC.
+ * Author: Philby John <pjohn@mvista.com>
+ * Credits: This driver is derived from Dmitriy Zavin's (dmitriyz@google.com)
+ * thermal throttle event support code.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/notifier.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/percpu.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/cpu.h>
+#include <linux/mutex.h>
+
+#include <asm/processor.h>
+#include <asm/octeon/cvmx-power-throttle.h>
+
+#define define_pwr_throttle_one_rw(_name)				\
+	static DEVICE_ATTR(_name, 0644, power_throt_show_##_name,	\
+			power_throt_store_##_name)			\
+
+#define define_pwr_throttle_show_func(name)				\
+									\
+static ssize_t power_throt_show_##name(					\
+			struct device *dev,				\
+			struct device_attribute *attr,			\
+			char *buf)					\
+{									\
+	unsigned int cpu = dev->id;					\
+	ssize_t ret;							\
+									\
+	preempt_disable();	/* CPU hotplug */			\
+	if (cpu_online(cpu))						\
+		ret = sprintf(buf, "%d\n",				\
+			cvmx_power_throttle_get_powlim(cpu));		\
+	else								\
+		ret = 0;						\
+	preempt_enable();						\
+									\
+	return ret;							\
+}
+
+#define define_pwr_throttle_store_func(name)				\
+									\
+static ssize_t power_throt_store_##name(				\
+			struct device *dev,				\
+			struct device_attribute *attr,			\
+			const char *buf,				\
+			size_t size)					\
+{									\
+	unsigned int cpu = dev->id;					\
+	unsigned long val;						\
+	int error;							\
+									\
+	error = kstrtoul(buf, 0, &val);					\
+	if (error)							\
+		return error;						\
+									\
+	preempt_disable();						\
+	cvmx_power_throttle(val, cpu);					\
+	preempt_enable();						\
+									\
+	return size;							\
+}
+
+define_pwr_throttle_store_func(percentage);
+define_pwr_throttle_show_func(percentage);
+define_pwr_throttle_one_rw(percentage);
+
+static struct attribute *pwr_throttle_attrs[] = {
+	&dev_attr_percentage.attr,
+	NULL
+};
+
+static struct attribute_group pwr_throttle_attr_group = {
+	.attrs	= pwr_throttle_attrs,
+	.name	= "power_throttle"
+};
+
+#ifdef CONFIG_SYSFS
+
+/* Mutex protecting device creation against CPU hotplug: */
+static DEFINE_MUTEX(pwr_throttl_cpu_lock);
+
+static __cpuinit int power_throttle_add_dev(struct device *dev)
+{
+	int err;
+
+	err =  sysfs_create_group(&dev->kobj, &pwr_throttle_attr_group);
+	if (err)
+		return err;
+	err = sysfs_add_file_to_group(&dev->kobj,
+					&dev_attr_percentage.attr,
+					pwr_throttle_attr_group.name);
+	return err;
+}
+
+static __cpuinit void power_throttle_remove_dev(struct device *dev)
+{
+	sysfs_remove_group(&dev->kobj, &pwr_throttle_attr_group);
+}
+
+static __cpuinit int
+power_throttle_cpu_callback(struct notifier_block *nfb,
+			      unsigned long action,
+			      void *hcpu)
+{
+	unsigned int cpu = (unsigned long)hcpu;
+	struct device *dev;
+	int err = 0;
+
+	dev = get_cpu_device(cpu);
+
+	switch (action) {
+	case CPU_ONLINE:
+	case CPU_DOWN_FAILED:
+	case CPU_UP_PREPARE:
+	case CPU_UP_PREPARE_FROZEN:
+		mutex_lock(&pwr_throttl_cpu_lock);
+		err = power_throttle_add_dev(dev);
+		mutex_unlock(&pwr_throttl_cpu_lock);
+		WARN_ON(err);
+		break;
+	case CPU_UP_CANCELED:
+	case CPU_UP_CANCELED_FROZEN:
+	case CPU_DEAD:
+	case CPU_DEAD_FROZEN:
+	case CPU_DOWN_PREPARE:
+		mutex_lock(&pwr_throttl_cpu_lock);
+		power_throttle_remove_dev(dev);
+		mutex_unlock(&pwr_throttl_cpu_lock);
+		break;
+	}
+	return err ? NOTIFY_BAD : NOTIFY_OK;
+}
+
+static struct notifier_block power_throttle_cpu_notifier = {
+	.notifier_call = power_throttle_cpu_callback,
+};
+
+static __init int power_throtl_init(void)
+{
+	unsigned int cpu = 0;
+	int err;
+
+	register_hotcpu_notifier(&power_throttle_cpu_notifier);
+
+#ifdef CONFIG_HOTPLUG_CPU
+	mutex_lock(&pwr_throttl_cpu_lock);
+#endif
+	/* connect live CPUs to sysfs */
+	for_each_online_cpu(cpu) {
+		err = power_throttle_add_dev(get_cpu_device(cpu));
+		WARN_ON(err);
+		cvmx_init_throttle_feedback(cpu);
+	}
+#ifdef CONFIG_HOTPLUG_CPU
+	mutex_unlock(&pwr_throttl_cpu_lock);
+#endif
+	return 0;
+}
+device_initcall(power_throtl_init);
+
+#endif
-- 
1.6.3.3.338.ge89ce
