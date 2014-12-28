Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Dec 2014 05:59:14 +0100 (CET)
Received: from SMTPBG221.QQ.COM ([183.60.2.226]:57728 "EHLO smtpbg221.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006975AbaL1E6iC1s1C (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 28 Dec 2014 05:58:38 +0100
X-QQ-mid: bizesmtp5t1419742687t244t271
Received: from localhost.localdomain (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sun, 28 Dec 2014 12:58:03 +0800 (CST)
X-QQ-SSF: 01100000002000F0FI42B00A0000000
X-QQ-FEAT: uQ7zd54tkGz5lhz5YT1h+cjakOmQZjeZLuke2suvI/Komv5vty29sEt10Ji64
        0JvxNoJe60mXDwNiIkwqoSVP81LxY/lStfGOCrN1ptQRuS+zvKJBix+H9A4a7uRVDo0eo7b
        Xyr5VTashduUWPpY16vsLwuglWvCJSDJEw6sK2/W4fgXaICG/21dfEI1AFcONfEM7SD9CN0
        SFGfzZ7CareY4l68y1+BLLoMnYwMOubRazna/QE8tBg==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V6 6/8] MIPS: Loongson-3: Add CPU Hwmon platform driver
Date:   Sun, 28 Dec 2014 12:58:00 +0800
Message-Id: <1419742681-15140-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44945
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
 drivers/platform/mips/cpu_hwmon.c              |  206 ++++++++++++++++++++++++
 7 files changed, 250 insertions(+), 0 deletions(-)
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
index 09fde58..eacabd1 100644
--- a/drivers/platform/Kconfig
+++ b/drivers/platform/Kconfig
@@ -4,5 +4,8 @@ endif
 if GOLDFISH
 source "drivers/platform/goldfish/Kconfig"
 endif
+if MIPS
+source "drivers/platform/mips/Kconfig"
+endif
 
 source "drivers/platform/chrome/Kconfig"
diff --git a/drivers/platform/Makefile b/drivers/platform/Makefile
index 3656b7b..f2dbc00 100644
--- a/drivers/platform/Makefile
+++ b/drivers/platform/Makefile
@@ -5,4 +5,5 @@
 obj-$(CONFIG_X86)		+= x86/
 obj-$(CONFIG_OLPC)		+= olpc/
 obj-$(CONFIG_GOLDFISH)		+= goldfish/
+obj-$(CONFIG_CPU_LOONGSON3)	+= mips/
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
index 0000000..529950a
--- /dev/null
+++ b/drivers/platform/mips/cpu_hwmon.c
@@ -0,0 +1,206 @@
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
-- 
1.7.7.3


3á
