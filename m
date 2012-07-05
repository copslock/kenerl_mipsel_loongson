Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jul 2012 14:11:58 +0200 (CEST)
Received: from mail-gh0-f177.google.com ([209.85.160.177]:36154 "EHLO
        mail-gh0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903721Ab2GEMLw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Jul 2012 14:11:52 +0200
Received: by ghbf11 with SMTP id f11so7901930ghb.36
        for <linux-mips@linux-mips.org>; Thu, 05 Jul 2012 05:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:from:to:cc:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding:x-gm-message-state;
        bh=o6+GPzyMCbi3nqUUAGBjIBjAlayTPOwYkGsMGY9tLoE=;
        b=AcItprrvSCnTTZwLCoLLJv+6VKPlC8Cm7urN3Wy5y2UYmNV11wEFB5jQrfsfwhVTuG
         MoxwBcRUEG7Dvnr+Xz/8uPD6l9nM6lo1ZXz+2F2USum9i67zmA6vWrew7w1MVssyta6s
         ygh0XUWxKh+T4hxw4M+kh00JwClgHyvyhC5vySAtb0YzrZqEih+VZ7WwPACXyyaXvlzu
         3YjWfkgHZltP6Mqq8MXw6cM2GAY/xIbVBOCKldmGq0VOesZAU6PwVp71PTsp1WS4O8Qx
         4QSlYmzF8nlpNK5/NcOdLgNJ+qSdfj9cGIYdIl46ytss1St5W39/hYNRZt9JIW2ax2Gi
         ZI2A==
Received: by 10.66.81.3 with SMTP id v3mr18497497pax.62.1341490305806;
        Thu, 05 Jul 2012 05:11:45 -0700 (PDT)
Received: from [10.162.4.5] ([115.119.134.194])
        by mx.google.com with ESMTPS id og4sm19670023pbb.48.2012.07.05.05.11.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 Jul 2012 05:11:44 -0700 (PDT)
Subject: [PATCH v2] Octeon 6xxx: Add Power Throttling support for CN6xxx
 and above
From:   philby john <pjohn@mvista.com>
To:     linux-mips@linux-mips.org
Cc:     "Daney, David" <David.Daney@caviumnetworks.com>,
        "Kapoor, Prasun" <Prasun.Kapoor@caviumnetworks.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Content-Type: text/plain; charset="ansi_x3.4-1968"
Date:   Thu, 05 Jul 2012 17:40:03 +0530
Message-ID: <1341490203.28372.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-1.fc14) 
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkuC6BESzgKBnZoyCQYzma85ObSU2VFU6keES4+qXIGWqTt/zuLOuxOWAFsEmZBeKbKgSIS
X-archive-position: 33875
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

>From 51898ada30d5eae7bff92dfb774df5a05ff670a4 Mon Sep 17 00:00:00 2001
From: Philby John <pjohn@mvista.com>
Date: Thu, 5 Jul 2012 17:35:45 +0530
Subject: [PATCH v2] Octeon 6xxx: Add Power Throttling support for CN6xxx and above

This patch adds the sysfs primitives for power throttling.

Octeon2 supports dynamic power control which aids to cut down power
consumption. The code exposes a "percentage" power throttling
limiter by means of /sys interface for each available cpu. Setting
this value to 0 will set power consumption to a minimum as it will
only execute a couple instructions every PERIOD as set in the
PowThrottle register. If set to 100% for that particular cpu, it
will consume maximum power.

Functionality tested on an Octeon 63xx.

Signed-off-by: Philby John <pjohn@mvista.com>
---
 arch/mips/cavium-octeon/Makefile            |    1 +
 arch/mips/cavium-octeon/octeon-pwr-throtl.c |  379 +++++++++++++++++++++++++++
 2 files changed, 380 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/cavium-octeon/octeon-pwr-throtl.c

diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
index 19eb043..115ceb5 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -15,3 +15,4 @@ obj-y += octeon-memcpy.o
 obj-y += executive/
 
 obj-$(CONFIG_SMP)                     += smp.o
+obj-$(CONFIG_SYSFS)                   += octeon-pwr-throtl.o
diff --git a/arch/mips/cavium-octeon/octeon-pwr-throtl.c b/arch/mips/cavium-octeon/octeon-pwr-throtl.c
new file mode 100644
index 0000000..5a340f4
--- /dev/null
+++ b/arch/mips/cavium-octeon/octeon-pwr-throtl.c
@@ -0,0 +1,379 @@
+/*
+ * octeon-pwr-throtl.c - interface for controlling power throttling on Octeon
+ * based platforms 6xxx and above.
+ * Octeon2 supports dynamic power control which aids to cut down power
+ * consumption. The code exposes a "percentage" power throttling limiter by
+ * means of /sys interface for each available cpu. Setting this value to 0
+ * will set power consumption to a minimum as it will only execute a couple
+ * instructions every PERIOD as set in the PowThrottle register.
+ * If set to 100% for that particular cpu, it will consume maximum power.
+ *
+ * Copyright (C) 2012 MontaVista LLC.
+ * Author: Philby John <pjohn@mvista.com>
+ * Credits: This driver is derived from Dmitriy Zavin's (dmitriyz@google.com)
+ * thermal throttle event support code.
+ */
+
+#include <linux/notifier.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/cpu.h>
+#include <linux/mutex.h>
+
+#include <asm/octeon/cvmx.h>
+#include <asm/octeon/cvmx-asm.h>
+#include <asm/octeon/octeon.h>
+
+
+enum cvmx_power_throttle_field_index {
+	CVMX_PTH_INDEX_MAXPOW,
+	CVMX_PTH_INDEX_POWER,
+	CVMX_PTH_INDEX_THROTT,
+	CVMX_PTH_INDEX_RESERVED,
+	CVMX_PTH_INDEX_DISTAG,
+	CVMX_PTH_INDEX_PERIOD,
+	CVMX_PTH_INDEX_POWLIM,
+	CVMX_PTH_INDEX_MAXTHR,
+	CVMX_PTH_INDEX_MINTHR,
+	CVMX_PTH_INDEX_HRMPOWADJ,
+	CVMX_PTH_INDEX_OVRRD,
+	CVMX_PTH_INDEX_MAX
+};
+
+#define CVMX_PTH_GET_MASK(len, pos)	\
+	((((uint64_t)1 << (len)) - 1) << (pos))
+
+/*
+ * a field of the POWTHROTTLE register
+ */
+static struct cvmx_power_throttle_rfield_t {
+	char	name[16];	/* the field's name */
+	int32_t	pos;		/* position of the field's LSb */
+	int32_t	len;		/* the field's length */
+	int	present;	/* 1 for present */
+} cvmx_power_throttle_rfield[] = {
+	{"MAXPOW",   56,  8, 0},
+	{"POWER" ,   48,  8, 0},
+	{"THROTT",   40,  8, 0},
+	{"Reserved", 28, 12, 0},
+	{"DISTAG",   27,  1, 0},
+	{"PERIOD",   24,  3, 0},
+	{"POWLIM",   16,  8, 0},
+	{"MAXTHR",    8,  8, 0},
+	{"MINTHR",    0,  8, 0},
+	{"HRMPOWADJ", 32,  8, 0},
+	{"OVRRD",    28,  1, 0}
+};
+
+static uint64_t cvmx_power_throttle_csr_addr(int ppid);
+
+static int cvmx_power_throttle_initialized;
+
+/*
+ * Initialize cvmx_power_throttle_rfield[] based on model.
+ */
+static void cvmx_power_throttle_init(void)
+{
+	int i;
+	struct cvmx_power_throttle_rfield_t *p;
+
+	for (i = 0; i < CVMX_PTH_INDEX_MAX; i++)
+		cvmx_power_throttle_rfield[i].present = 1;
+
+	if (OCTEON_IS_MODEL(OCTEON_CN63XX)) {
+		/*
+		 * These fields do not come with o63
+		 */
+		p = &cvmx_power_throttle_rfield[CVMX_PTH_INDEX_HRMPOWADJ];
+		p->present = 0;
+		p = &cvmx_power_throttle_rfield[CVMX_PTH_INDEX_OVRRD];
+		p->present = 0;
+	} else {
+		/*
+		 * The reserved field shrinks in models newer than o63
+		 */
+		p = &cvmx_power_throttle_rfield[CVMX_PTH_INDEX_RESERVED];
+		p->pos = 29;
+		p->len = 3;
+	}
+}
+
+static uint64_t cvmx_power_throttle_get_field(uint64_t r,
+	enum cvmx_power_throttle_field_index i)
+{
+	uint64_t m;
+	struct cvmx_power_throttle_rfield_t *p;
+
+	if (i > CVMX_PTH_INDEX_MAX)
+		return -EINVAL;
+
+	p = &cvmx_power_throttle_rfield[i];
+	if (!p->present)
+		return (uint64_t) -1;
+	m = CVMX_PTH_GET_MASK(p->len, p->pos);
+
+	return (r & m) >> p->pos;
+}
+
+/*
+ * Set the i'th field of power-throttle register r to v.
+ */
+static int cvmx_power_throttle_set_field(int i, uint64_t r, uint64_t v)
+{
+	uint64_t m;
+	struct cvmx_power_throttle_rfield_t *p;
+
+	if (i > CVMX_PTH_INDEX_MAX)
+		return -EINVAL;
+
+	p = &cvmx_power_throttle_rfield[i];
+	m = CVMX_PTH_GET_MASK(p->len, p->pos);
+
+	return (~m & r) | ((v << p->pos) & m);
+}
+
+static void cvmx_init_throttle_feedback(unsigned int cpu)
+{
+	uint64_t csr_addr, r;
+
+	csr_addr = cvmx_power_throttle_csr_addr(cpu);
+	r = cvmx_read_csr(csr_addr);
+	r = cvmx_power_throttle_set_field(CVMX_PTH_INDEX_MINTHR, r, 0x0);
+	cvmx_write_csr(csr_addr, r);
+	r = cvmx_read_csr(csr_addr);
+	r = cvmx_power_throttle_set_field(CVMX_PTH_INDEX_MAXTHR, r, 0xFF);
+	cvmx_write_csr(csr_addr, r);
+}
+
+/*
+ * Get the POWLIM field as percentage% of the MAXPOW field in r.
+ */
+static int cvmx_power_throttle_get_powlim(unsigned int cpu)
+{
+	uint64_t t, csr_addr, r, s;
+
+	csr_addr = cvmx_power_throttle_csr_addr(cpu);
+	r = cvmx_read_csr(csr_addr);
+	t = cvmx_power_throttle_get_field(r, CVMX_PTH_INDEX_MAXPOW);
+	if (!OCTEON_IS_MODEL(OCTEON_CN63XX)) {
+		s = cvmx_power_throttle_get_field(r, CVMX_PTH_INDEX_HRMPOWADJ);
+		if (t < s)
+			return -EINVAL;
+		t = t - s;
+	}
+	s = cvmx_power_throttle_get_field(r, CVMX_PTH_INDEX_POWLIM);
+	r = (s * 100)/t;
+	return r > 100 ? 100 : r;
+}
+
+/*
+ * Set the POWLIM field as percentage% of the MAXPOW field in r.
+ */
+static uint64_t cvmx_power_throttle_set_powlim(int ppid,
+	uint8_t percentage)
+{
+	uint64_t t, csr_addr, r;
+
+	if (percentage > 101)
+		return -EINVAL;
+	csr_addr = cvmx_power_throttle_csr_addr(ppid);
+	r = cvmx_read_csr(csr_addr);
+	t = cvmx_power_throttle_get_field(r, CVMX_PTH_INDEX_MAXPOW);
+	if (!OCTEON_IS_MODEL(OCTEON_CN63XX)) {
+		uint64_t s;
+		s = cvmx_power_throttle_get_field(r, CVMX_PTH_INDEX_HRMPOWADJ);
+		if (t < s)
+			return -EINVAL;
+		t = t - s;
+	}
+	if (percentage > 0)
+		t = percentage * t / 100;
+	else
+		t = 0;
+	r = cvmx_power_throttle_set_field(CVMX_PTH_INDEX_POWLIM, r, t);
+	cvmx_write_csr(csr_addr, r);
+	return r;
+}
+
+/*
+ * Given ppid, calculate its PowThrottle register's L2C_COP0_MAP CSR
+ * address. (ppid == PTH_PPID_BCAST is for broadcasting)
+ */
+static uint64_t cvmx_power_throttle_csr_addr(int ppid)
+{
+	uint64_t csr_addr, reg_num, reg_reg, reg_sel;
+
+	if (ppid > CVMX_MAX_CORES)
+		return -EINVAL;
+	/*
+	 * register 11 selection 6
+	 */
+	reg_reg = 11;
+	reg_sel = 6;
+	reg_num = (ppid << 8) + (reg_reg << 3) + reg_sel;
+	csr_addr = CVMX_L2C_COP0_MAPX(0) + ((reg_num) << 3);
+	return csr_addr;
+}
+
+static uint64_t cvmx_power_throttle_get_register(int ppid)
+{
+	uint64_t csr_addr;
+
+	if (!cvmx_power_throttle_initialized) {
+		cvmx_power_throttle_init();
+		cvmx_power_throttle_initialized = 1;
+	}
+	csr_addr = cvmx_power_throttle_csr_addr(ppid);
+	if (csr_addr == 0)
+		return -EINVAL;
+
+	return cvmx_read_csr(csr_addr);
+}
+
+#define CVMX_PTH_AVAILABLE		\
+	(cvmx_power_throttle_get_register(0) != (uint64_t)-1)
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
+	cvmx_power_throttle_set_powlim(cpu, val);			\
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
+	int err = 0;
+
+	if (CVMX_PTH_AVAILABLE) {
+#ifdef CONFIG_HOTPLUG_CPU
+		register_hotcpu_notifier(&power_throttle_cpu_notifier);
+		mutex_lock(&pwr_throttl_cpu_lock);
+#endif
+		/* connect live CPUs to sysfs */
+		for_each_online_cpu(cpu) {
+			err = power_throttle_add_dev(get_cpu_device(cpu));
+			WARN_ON(err);
+			cvmx_init_throttle_feedback(cpu);
+		}
+#ifdef CONFIG_HOTPLUG_CPU
+		mutex_unlock(&pwr_throttl_cpu_lock);
+#endif
+		return err;
+	}
+	return 0;
+}
+device_initcall(power_throtl_init);
-- 
1.6.3.3.340.g77d18
