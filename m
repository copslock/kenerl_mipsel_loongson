Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2014 07:16:09 +0100 (CET)
Received: from mail-pd0-f172.google.com ([209.85.192.172]:39640 "EHLO
        mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012575AbaKDGObP7PGU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Nov 2014 07:14:31 +0100
Received: by mail-pd0-f172.google.com with SMTP id r10so13019981pdi.17
        for <multiple recipients>; Mon, 03 Nov 2014 22:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j4jnbZPWchIwYlnICW8zmlZ6A+OIjrxixk9GrbJeaWs=;
        b=JdziO2AdDeeRxypkAqHqpN4zUa60Hm3GzllkJ4BJPi8yHd4cQcqkhJITrzxjpWrwsi
         TfRAsk+3mZm6+BVxGqZIdGxJfOuxaMmNi2CzZ2mkW1s7WQNkV8k9OAftDyUqh0K2po0L
         aFqKwsPvBKe2A7ibBbMmYsRhYIo7VHgKwuKreSd+d8dySLyti7Rb3tf0/5eJ2xc0elIT
         CBY2Fx5Ln20qR42YPR3r0+E79xT6I0gCX9RqDpsEBgCpCXOdGl3lLW0MQgrAsyKqx2t5
         hAzqETm4XTGrDAAwiLf0O0amdvJ+c5oAxZ0Bi5GxZaFfpRedDDBa7CvpdNRtD3Wvgq91
         eSeA==
X-Received: by 10.70.102.103 with SMTP id fn7mr321133pdb.160.1415081665164;
        Mon, 03 Nov 2014 22:14:25 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id cs9sm7712498pac.8.2014.11.03.22.14.21
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 03 Nov 2014 22:14:24 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 08/12] MIPS: Loongson-3: Add CPU Hwmon platform driver
Date:   Tue,  4 Nov 2014 14:13:29 +0800
Message-Id: <1415081610-25639-9-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1415081610-25639-1-git-send-email-chenhc@lemote.com>
References: <1415081610-25639-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43857
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
 drivers/platform/Makefile                      |    1 +
 drivers/platform/mips/Makefile                 |    1 +
 drivers/platform/mips/cpu_hwmon.c              |  206 ++++++++++++++++++++++++
 5 files changed, 221 insertions(+), 0 deletions(-)
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
diff --git a/drivers/platform/mips/Makefile b/drivers/platform/mips/Makefile
new file mode 100644
index 0000000..15723a6
--- /dev/null
+++ b/drivers/platform/mips/Makefile
@@ -0,0 +1 @@
+obj-y += cpu_hwmon.o
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
