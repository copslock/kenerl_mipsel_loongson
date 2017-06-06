Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jun 2017 05:19:41 +0200 (CEST)
Received: from smtpbgbr2.qq.com ([54.207.22.56]:39350 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992028AbdFFDTbjQepo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Jun 2017 05:19:31 +0200
X-QQ-mid: bizesmtp16t1496719132t7e7sh08
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 06 Jun 2017 11:17:45 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK92000A0000000
X-QQ-FEAT: HqsAE+iGIGj7zcZ9Y7nPOt+eiRjEdCpjRpXNkJ53PziESXkh3+JPwwjZNXbgJ
        lMcNpHtoO9TnDpTzHkjFDOncOX/Crvphd0RirW8QDQLFnTSpDuWPAVF/hGmV6KkeerXxP5r
        YxFvP93mKcQMPiX25cOFhPC1+KjBkG4BHeK2AxzwRXSGKgcA/Tdp/SXgqsnkoTYnyv2DosM
        3yaIFVh4gGKodp4Q6eyTbgPrUNTnnD7mlL4q01BPTG79oSvRS/aq1FNoMu3+KRshNeFMkbK
        O+avBizBz1h7Fdcj7iX/AeGh/dhmtH5QwX88D5Z0SxlCOn
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V4 4/9] MIPS: Loongson-3: Support 4 packages in CPU Hwmon driver
Date:   Tue,  6 Jun 2017 11:14:43 +0800
Message-Id: <1496718888-18324-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1496718888-18324-1-git-send-email-chenhc@lemote.com>
References: <1496718888-18324-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58246
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

Loongson-3 machines may have as many as 4 physical packages.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 drivers/platform/mips/cpu_hwmon.c | 112 +++++++++++++++++++++++++++-----------
 1 file changed, 79 insertions(+), 33 deletions(-)

diff --git a/drivers/platform/mips/cpu_hwmon.c b/drivers/platform/mips/cpu_hwmon.c
index 46ab7d86..0a7529e 100644
--- a/drivers/platform/mips/cpu_hwmon.c
+++ b/drivers/platform/mips/cpu_hwmon.c
@@ -37,6 +37,7 @@ int loongson3_cpu_temp(int cpu)
 	return (int)reg * 1000;
 }
 
+static int nr_packages;
 static struct device *cpu_hwmon_dev;
 
 static ssize_t get_hwmon_name(struct device *dev,
@@ -64,26 +65,49 @@ static ssize_t get_cpu0_temp(struct device *dev,
 			struct device_attribute *attr, char *buf);
 static ssize_t get_cpu1_temp(struct device *dev,
 			struct device_attribute *attr, char *buf);
+static ssize_t get_cpu2_temp(struct device *dev,
+			struct device_attribute *attr, char *buf);
+static ssize_t get_cpu3_temp(struct device *dev,
+			struct device_attribute *attr, char *buf);
 static ssize_t cpu0_temp_label(struct device *dev,
 			struct device_attribute *attr, char *buf);
 static ssize_t cpu1_temp_label(struct device *dev,
 			struct device_attribute *attr, char *buf);
+static ssize_t cpu2_temp_label(struct device *dev,
+			struct device_attribute *attr, char *buf);
+static ssize_t cpu3_temp_label(struct device *dev,
+			struct device_attribute *attr, char *buf);
 
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, get_cpu0_temp, NULL, 1);
 static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, cpu0_temp_label, NULL, 1);
 static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, get_cpu1_temp, NULL, 2);
 static SENSOR_DEVICE_ATTR(temp2_label, S_IRUGO, cpu1_temp_label, NULL, 2);
-
-static const struct attribute *hwmon_cputemp1[] = {
-	&sensor_dev_attr_temp1_input.dev_attr.attr,
-	&sensor_dev_attr_temp1_label.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute *hwmon_cputemp2[] = {
-	&sensor_dev_attr_temp2_input.dev_attr.attr,
-	&sensor_dev_attr_temp2_label.dev_attr.attr,
-	NULL
+static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, get_cpu2_temp, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp3_label, S_IRUGO, cpu2_temp_label, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, get_cpu3_temp, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp4_label, S_IRUGO, cpu3_temp_label, NULL, 2);
+
+static const struct attribute *hwmon_cputemp[4][3] = {
+	{
+		&sensor_dev_attr_temp1_input.dev_attr.attr,
+		&sensor_dev_attr_temp1_label.dev_attr.attr,
+		NULL
+	},
+	{
+		&sensor_dev_attr_temp2_input.dev_attr.attr,
+		&sensor_dev_attr_temp2_label.dev_attr.attr,
+		NULL
+	},
+	{
+		&sensor_dev_attr_temp3_input.dev_attr.attr,
+		&sensor_dev_attr_temp3_label.dev_attr.attr,
+		NULL
+	},
+	{
+		&sensor_dev_attr_temp4_input.dev_attr.attr,
+		&sensor_dev_attr_temp4_label.dev_attr.attr,
+		NULL
+	}
 };
 
 static ssize_t cpu0_temp_label(struct device *dev,
@@ -98,6 +122,18 @@ static ssize_t cpu1_temp_label(struct device *dev,
 	return sprintf(buf, "CPU 1 Temperature\n");
 }
 
+static ssize_t cpu2_temp_label(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "CPU 2 Temperature\n");
+}
+
+static ssize_t cpu3_temp_label(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "CPU 3 Temperature\n");
+}
+
 static ssize_t get_cpu0_temp(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
@@ -112,36 +148,36 @@ static ssize_t get_cpu1_temp(struct device *dev,
 	return sprintf(buf, "%d\n", value);
 }
 
-static int create_sysfs_cputemp_files(struct kobject *kobj)
+static ssize_t get_cpu2_temp(struct device *dev,
+			struct device_attribute *attr, char *buf)
 {
-	int ret;
-
-	ret = sysfs_create_files(kobj, hwmon_cputemp1);
-	if (ret)
-		goto sysfs_create_temp1_fail;
-
-	if (loongson_sysconf.nr_cpus <= loongson_sysconf.cores_per_package)
-		return 0;
+	int value = loongson3_cpu_temp(2);
+	return sprintf(buf, "%d\n", value);
+}
 
-	ret = sysfs_create_files(kobj, hwmon_cputemp2);
-	if (ret)
-		goto sysfs_create_temp2_fail;
+static ssize_t get_cpu3_temp(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	int value = loongson3_cpu_temp(3);
+	return sprintf(buf, "%d\n", value);
+}
 
-	return 0;
+static int create_sysfs_cputemp_files(struct kobject *kobj)
+{
+	int i, ret = 0;
 
-sysfs_create_temp2_fail:
-	sysfs_remove_files(kobj, hwmon_cputemp1);
+	for (i=0; i<nr_packages; i++)
+		ret = sysfs_create_files(kobj, hwmon_cputemp[i]);
 
-sysfs_create_temp1_fail:
-	return -1;
+	return ret;
 }
 
 static void remove_sysfs_cputemp_files(struct kobject *kobj)
 {
-	sysfs_remove_files(&cpu_hwmon_dev->kobj, hwmon_cputemp1);
+	int i;
 
-	if (loongson_sysconf.nr_cpus > loongson_sysconf.cores_per_package)
-		sysfs_remove_files(&cpu_hwmon_dev->kobj, hwmon_cputemp2);
+	for (i=0; i<nr_packages; i++)
+		sysfs_remove_files(kobj, hwmon_cputemp[i]);
 }
 
 #define CPU_THERMAL_THRESHOLD 90000
@@ -149,8 +185,15 @@ static struct delayed_work thermal_work;
 
 static void do_thermal_timer(struct work_struct *work)
 {
-	int value = loongson3_cpu_temp(0);
-	if (value <= CPU_THERMAL_THRESHOLD)
+	int i, value, temp_max = 0;
+
+	for (i=0; i<nr_packages; i++) {
+		value = loongson3_cpu_temp(i);
+		if (value > temp_max)
+			temp_max = value;
+	}
+
+	if (temp_max <= CPU_THERMAL_THRESHOLD)
 		schedule_delayed_work(&thermal_work, msecs_to_jiffies(5000));
 	else
 		orderly_poweroff(true);
@@ -169,6 +212,9 @@ static int __init loongson_hwmon_init(void)
 		goto fail_hwmon_device_register;
 	}
 
+	nr_packages = loongson_sysconf.nr_cpus /
+		loongson_sysconf.cores_per_package;
+
 	ret = sysfs_create_group(&cpu_hwmon_dev->kobj,
 				&cpu_hwmon_attribute_group);
 	if (ret) {
-- 
2.7.0
