Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Mar 2015 04:55:07 +0200 (CEST)
Received: from smtpbg63.qq.com ([103.7.29.150]:20468 "EHLO smtpbg63.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006584AbbC2CyqwhKne (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 29 Mar 2015 04:54:46 +0200
X-QQ-mid: bizesmtp2t1427597663t463t214
Received: from localhost.localdomain (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sun, 29 Mar 2015 10:54:22 +0800 (CST)
X-QQ-SSF: 01100000002000F0FJ52B00A0000000
X-QQ-FEAT: wto48VEmSUEfBZgtGd0SspX96kbsMPXA7wTtWp5qqan56HDpHPwMytgygVlTx
        DSiX8Q+BdF+nN+tmyLHs2nmIxK3mGbXPKCYG6osIlV6CZkUsKRbiN3yxf4v0FDT/68hjBs6
        xuuAiPeJL7C341knIViqcSqJSviyqOPiaa0iZ1RO+WIwR3F44OTAiDO/uqAPmXXXYWL56NR
        HC0OTUo+2dSK3MfvuW3f+4vZtlSKT56mKukIGySi6/q0nMe5HNjcR
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V9 5/7] MIPS: Loongson-3: Add CPU Hwmon platform driver
Date:   Sun, 29 Mar 2015 10:54:09 +0800
Message-Id: <1427597650-2368-6-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1427597650-2368-1-git-send-email-chenhc@lemote.com>
References: <1427597650-2368-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

This add CPU Hwmon (temperature sensor) platform driver for Loongson-3.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/mach-loongson/loongson.h |    4 +
 arch/mips/loongson/common/env.c                |    9 +
 drivers/platform/Kconfig                       |    3 +
 drivers/platform/Makefile                      |    1 +
 drivers/platform/mips/Kconfig                  |   26 +++
 drivers/platform/mips/Makefile                 |    1 +
 drivers/platform/mips/cpu_hwmon.c              |  207 ++++++++++++++++++++++++
 7 files changed, 251 insertions(+), 0 deletions(-)
 create mode 100644 drivers/platform/mips/Kconfig
 create mode 100644 drivers/platform/mips/Makefile
 create mode 100644 drivers/platform/mips/cpu_hwmon.c

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index 5459ac0..9783103 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -255,6 +255,10 @@ static inline void do_perfcnt_IRQ(void)
 extern u64 loongson_chipcfg[MAX_PACKAGES];
 #define LOONGSON_CHIPCFG(id) (*(volatile u32 *)(loongson_chipcfg[id]))
 
+/* Chip Temperature registor of each physical cpu package, PRid >= Loongson-3A */
+extern u64 loongson_chiptemp[MAX_PACKAGES];
+#define LOONGSON_CHIPTEMP(id) (*(volatile u32 *)(loongson_chiptemp[id]))
+
 /* Freq Control register of each physical cpu package, PRid >= Loongson-3B */
 extern u64 loongson_freqctrl[MAX_PACKAGES];
 #define LOONGSON_FREQCTRL(id) (*(volatile u32 *)(loongson_freqctrl[id]))
diff --git a/arch/mips/loongson/common/env.c b/arch/mips/loongson/common/env.c
index 045ea3d..22f04ca 100644
--- a/arch/mips/loongson/common/env.c
+++ b/arch/mips/loongson/common/env.c
@@ -29,6 +29,7 @@ struct efi_memory_map_loongson *loongson_memmap;
 struct loongson_system_configuration loongson_sysconf;
 
 u64 loongson_chipcfg[MAX_PACKAGES] = {0xffffffffbfc00180};
+u64 loongson_chiptemp[MAX_PACKAGES];
 u64 loongson_freqctrl[MAX_PACKAGES];
 
 unsigned long long smp_group[4];
@@ -97,6 +98,10 @@ void __init prom_init_env(void)
 		loongson_chipcfg[1] = 0x900010001fe00180;
 		loongson_chipcfg[2] = 0x900020001fe00180;
 		loongson_chipcfg[3] = 0x900030001fe00180;
+		loongson_chiptemp[0] = 0x900000001fe0019c;
+		loongson_chiptemp[1] = 0x900010001fe0019c;
+		loongson_chiptemp[2] = 0x900020001fe0019c;
+		loongson_chiptemp[3] = 0x900030001fe0019c;
 		loongson_sysconf.ht_control_base = 0x90000EFDFB000000;
 		loongson_sysconf.workarounds = WORKAROUND_CPUFREQ;
 	} else if (ecpu->cputype == Loongson_3B) {
@@ -110,6 +115,10 @@ void __init prom_init_env(void)
 		loongson_chipcfg[1] = 0x900020001fe00180;
 		loongson_chipcfg[2] = 0x900040001fe00180;
 		loongson_chipcfg[3] = 0x900060001fe00180;
+		loongson_chiptemp[0] = 0x900000001fe0019c;
+		loongson_chiptemp[1] = 0x900020001fe0019c;
+		loongson_chiptemp[2] = 0x900040001fe0019c;
+		loongson_chiptemp[3] = 0x900060001fe0019c;
 		loongson_freqctrl[0] = 0x900000001fe001d0;
 		loongson_freqctrl[1] = 0x900020001fe001d0;
 		loongson_freqctrl[2] = 0x900040001fe001d0;
diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
index 09fde58..0adccbf 100644
--- a/drivers/platform/Kconfig
+++ b/drivers/platform/Kconfig
@@ -1,6 +1,9 @@
 if X86
 source "drivers/platform/x86/Kconfig"
 endif
+if MIPS
+source "drivers/platform/mips/Kconfig"
+endif
 if GOLDFISH
 source "drivers/platform/goldfish/Kconfig"
 endif
diff --git a/drivers/platform/Makefile b/drivers/platform/Makefile
index 3656b7b..ca26925 100644
--- a/drivers/platform/Makefile
+++ b/drivers/platform/Makefile
@@ -3,6 +3,7 @@
 #
 
 obj-$(CONFIG_X86)		+= x86/
+obj-$(CONFIG_MIPS)		+= mips/
 obj-$(CONFIG_OLPC)		+= olpc/
 obj-$(CONFIG_GOLDFISH)		+= goldfish/
 obj-$(CONFIG_CHROME_PLATFORMS)	+= chrome/
diff --git a/drivers/platform/mips/Kconfig b/drivers/platform/mips/Kconfig
new file mode 100644
index 0000000..b3ae30a
--- /dev/null
+++ b/drivers/platform/mips/Kconfig
@@ -0,0 +1,26 @@
+#
+# MIPS Platform Specific Drivers
+#
+
+menuconfig MIPS_PLATFORM_DEVICES
+	bool "MIPS Platform Specific Device Drivers"
+	default y
+	help
+	  Say Y here to get to see options for device drivers of various
+	  MIPS platforms, including vendor-specific netbook/laptop/desktop
+	  extension and hardware monitor drivers. This option itself does
+	  not add any kernel code.
+
+	  If you say N, all options in this submenu will be skipped and disabled.
+
+if MIPS_PLATFORM_DEVICES
+
+config CPU_HWMON
+	tristate "Loongson CPU HWMon Driver"
+	depends on LOONGSON_MACH3X
+	select HWMON
+	default y
+	help
+	  Loongson-3A/3B CPU Hwmon (temperature sensor) driver.
+
+endif # MIPS_PLATFORM_DEVICES
diff --git a/drivers/platform/mips/Makefile b/drivers/platform/mips/Makefile
new file mode 100644
index 0000000..8dfd039
--- /dev/null
+++ b/drivers/platform/mips/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_CPU_HWMON) += cpu_hwmon.o
diff --git a/drivers/platform/mips/cpu_hwmon.c b/drivers/platform/mips/cpu_hwmon.c
new file mode 100644
index 0000000..0f6c63e
--- /dev/null
+++ b/drivers/platform/mips/cpu_hwmon.c
@@ -0,0 +1,207 @@
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/reboot.h>
+#include <linux/jiffies.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+
+#include <loongson.h>
+#include <boot_param.h>
+#include <loongson_hwmon.h>
+
+/*
+ * Loongson-3 series cpu has two sensors inside,
+ * each of them from 0 to 255,
+ * if more than 127, that is dangerous.
+ * here only provide sensor1 data, because it always hot than sensor0
+ */
+int loongson3_cpu_temp(int cpu)
+{
+	u32 reg;
+
+	reg = LOONGSON_CHIPTEMP(cpu);
+	if (loongson_sysconf.cputype == Loongson_3A)
+		reg = (reg >> 8) & 0xff;
+	else if (loongson_sysconf.cputype == Loongson_3B)
+		reg = ((reg >> 8) & 0xff) - 100;
+
+	return (int)reg * 1000;
+}
+
+static struct device *cpu_hwmon_dev;
+
+static ssize_t get_hwmon_name(struct device *dev,
+			struct device_attribute *attr, char *buf);
+static SENSOR_DEVICE_ATTR(name, S_IRUGO, get_hwmon_name, NULL, 0);
+
+static struct attribute *cpu_hwmon_attributes[] = {
+	&sensor_dev_attr_name.dev_attr.attr,
+	NULL
+};
+
+/* Hwmon device attribute group */
+static struct attribute_group cpu_hwmon_attribute_group = {
+	.attrs = cpu_hwmon_attributes,
+};
+
+/* Hwmon device get name */
+static ssize_t get_hwmon_name(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "cpu-hwmon\n");
+}
+
+static ssize_t get_cpu0_temp(struct device *dev,
+			struct device_attribute *attr, char *buf);
+static ssize_t get_cpu1_temp(struct device *dev,
+			struct device_attribute *attr, char *buf);
+static ssize_t cpu0_temp_label(struct device *dev,
+			struct device_attribute *attr, char *buf);
+static ssize_t cpu1_temp_label(struct device *dev,
+			struct device_attribute *attr, char *buf);
+
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, get_cpu0_temp, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, cpu0_temp_label, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, get_cpu1_temp, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp2_label, S_IRUGO, cpu1_temp_label, NULL, 2);
+
+static const struct attribute *hwmon_cputemp1[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_label.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute *hwmon_cputemp2[] = {
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_label.dev_attr.attr,
+	NULL
+};
+
+static ssize_t cpu0_temp_label(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "CPU 0 Temprature\n");
+}
+
+static ssize_t cpu1_temp_label(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "CPU 1 Temprature\n");
+}
+
+static ssize_t get_cpu0_temp(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	int value = loongson3_cpu_temp(0);
+	return sprintf(buf, "%d\n", value);
+}
+
+static ssize_t get_cpu1_temp(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	int value = loongson3_cpu_temp(1);
+	return sprintf(buf, "%d\n", value);
+}
+
+static int create_sysfs_cputemp_files(struct kobject *kobj)
+{
+	int ret;
+
+	ret = sysfs_create_files(kobj, hwmon_cputemp1);
+	if (ret)
+		goto sysfs_create_temp1_fail;
+
+	if (loongson_sysconf.nr_cpus <= loongson_sysconf.cores_per_package)
+		return 0;
+
+	ret = sysfs_create_files(kobj, hwmon_cputemp2);
+	if (ret)
+		goto sysfs_create_temp2_fail;
+
+	return 0;
+
+sysfs_create_temp2_fail:
+	sysfs_remove_files(kobj, hwmon_cputemp1);
+
+sysfs_create_temp1_fail:
+	return -1;
+}
+
+static void remove_sysfs_cputemp_files(struct kobject *kobj)
+{
+	sysfs_remove_files(&cpu_hwmon_dev->kobj, hwmon_cputemp1);
+
+	if (loongson_sysconf.nr_cpus > loongson_sysconf.cores_per_package)
+		sysfs_remove_files(&cpu_hwmon_dev->kobj, hwmon_cputemp2);
+}
+
+#define CPU_THERMAL_THRESHOLD 90000
+static struct delayed_work thermal_work;
+
+static void do_thermal_timer(struct work_struct *work)
+{
+	int value = loongson3_cpu_temp(0);
+	if (value <= CPU_THERMAL_THRESHOLD)
+		schedule_delayed_work(&thermal_work, msecs_to_jiffies(5000));
+	else
+		orderly_poweroff(true);
+}
+
+static int __init loongson_hwmon_init(void)
+{
+	int ret;
+
+	pr_info("Loongson Hwmon Enter...\n");
+
+	cpu_hwmon_dev = hwmon_device_register(NULL);
+	if (IS_ERR(cpu_hwmon_dev)) {
+		ret = -ENOMEM;
+		pr_err("hwmon_device_register fail!\n");
+		goto fail_hwmon_device_register;
+	}
+
+	ret = sysfs_create_group(&cpu_hwmon_dev->kobj,
+				&cpu_hwmon_attribute_group);
+	if (ret) {
+		pr_err("fail to create loongson hwmon!\n");
+		goto fail_sysfs_create_group_hwmon;
+	}
+
+	ret = create_sysfs_cputemp_files(&cpu_hwmon_dev->kobj);
+	if (ret) {
+		pr_err("fail to create cpu temprature interface!\n");
+		goto fail_create_sysfs_cputemp_files;
+	}
+
+	INIT_DEFERRABLE_WORK(&thermal_work, do_thermal_timer);
+	schedule_delayed_work(&thermal_work, msecs_to_jiffies(20000));
+
+	return ret;
+
+fail_create_sysfs_cputemp_files:
+	sysfs_remove_group(&cpu_hwmon_dev->kobj,
+				&cpu_hwmon_attribute_group);
+
+fail_sysfs_create_group_hwmon:
+	hwmon_device_unregister(cpu_hwmon_dev);
+
+fail_hwmon_device_register:
+	return ret;
+}
+
+static void __exit loongson_hwmon_exit(void)
+{
+	cancel_delayed_work_sync(&thermal_work);
+	remove_sysfs_cputemp_files(&cpu_hwmon_dev->kobj);
+	sysfs_remove_group(&cpu_hwmon_dev->kobj,
+				&cpu_hwmon_attribute_group);
+	hwmon_device_unregister(cpu_hwmon_dev);
+}
+
+module_init(loongson_hwmon_init);
+module_exit(loongson_hwmon_exit);
+
+MODULE_AUTHOR("Yu Xiang <xiangy@lemote.com>");
+MODULE_AUTHOR("Huacai Chen <chenhc@lemote.com>");
+MODULE_DESCRIPTION("Loongson CPU Hwmon driver");
+MODULE_LICENSE("GPL");
-- 
1.7.7.3
