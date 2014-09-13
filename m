Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Sep 2014 10:03:43 +0200 (CEST)
Received: from mail-pa0-f44.google.com ([209.85.220.44]:44708 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008121AbaIMIBpboXTi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Sep 2014 10:01:45 +0200
Received: by mail-pa0-f44.google.com with SMTP id kx10so2930977pab.3
        for <multiple recipients>; Sat, 13 Sep 2014 01:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=xYyPelAX5GqULfl3aJ/hFBemHGgWXgo0oAQZfT0OcI0=;
        b=SjmkPn0d4lmIEXoTCI9/GEq/FmceRmmWJdmfMh/mYmm7ZqzDMWLtPtYk149n80u1qw
         2pZLx9szu9AVp3a8C8OUqMZEmHBkhLO6bYKksEi2sppvpyi3AR/A9y3bfvzTewbFLJQi
         BbjKHNl5TmIfZL4p/YucIE/Bn0/Mh2Jp6laTNbRktljl+lNtBu9VIwaPqrMpUv+o1kVr
         yL4uULriY+IJcnxlyHUzYYhgJ47XiIvPMLL+FobLWqXaDcJePm6Gvl5OouuPNchNNOyy
         SPGjTeqSYCoRFeQ1eCCliz9QykIX17GeivcxsffGWXWJx6CU0IAezu6XCZVyPrLmqCFC
         pIbw==
X-Received: by 10.68.133.199 with SMTP id pe7mr4173591pbb.132.1410595298578;
        Sat, 13 Sep 2014 01:01:38 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id vy10sm5883191pbc.5.2014.09.13.01.01.35
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 13 Sep 2014 01:01:38 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>
Subject: [PATCH 10/11] MIPS: Loongson-3: Add RS780/SBX00 HPET support
Date:   Sat, 13 Sep 2014 16:01:20 +0800
Message-Id: <1410595280-11067-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42538
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

CPUFreq driver need external timer, so add hpet at first.

In Loongson 3, only Core-0 can receive external interrupt. As a result,
timekeeping cannot absolutely use HPET timer. We use a hybrid solution:
Core-0 use HPET as its clock event device, but other cores still use
MIPS; clock source is global and doesn't need interrupt, so use HPET.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
---
 arch/mips/include/asm/hpet.h           |   73 +++++++++
 arch/mips/loongson/Kconfig             |   12 ++
 arch/mips/loongson/common/time.c       |    5 +
 arch/mips/loongson/loongson-3/Makefile |    2 +
 arch/mips/loongson/loongson-3/hpet.c   |  257 ++++++++++++++++++++++++++++++++
 arch/mips/loongson/loongson-3/irq.c    |    2 +-
 6 files changed, 350 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/include/asm/hpet.h
 create mode 100644 arch/mips/loongson/loongson-3/hpet.c

diff --git a/arch/mips/include/asm/hpet.h b/arch/mips/include/asm/hpet.h
new file mode 100644
index 0000000..18a8f77
--- /dev/null
+++ b/arch/mips/include/asm/hpet.h
@@ -0,0 +1,73 @@
+#ifndef _ASM_HPET_H
+#define _ASM_HPET_H
+
+#ifdef CONFIG_RS780_HPET
+
+#define HPET_MMAP_SIZE		1024
+
+#define HPET_ID			0x000
+#define HPET_PERIOD		0x004
+#define HPET_CFG		0x010
+#define HPET_STATUS		0x020
+#define HPET_COUNTER	0x0f0
+
+#define HPET_Tn_CFG(n)		(0x100 + 0x20 * n)
+#define HPET_Tn_CMP(n)		(0x108 + 0x20 * n)
+#define HPET_Tn_ROUTE(n)	(0x110 + 0x20 * n)
+
+#define HPET_T0_IRS		0x001
+#define HPET_T1_IRS		0x002
+#define HPET_T3_IRS		0x004
+
+#define HPET_T0_CFG		0x100
+#define HPET_T0_CMP		0x108
+#define HPET_T0_ROUTE	0x110
+#define HPET_T1_CFG		0x120
+#define HPET_T1_CMP		0x128
+#define HPET_T1_ROUTE	0x130
+#define HPET_T2_CFG		0x140
+#define HPET_T2_CMP		0x148
+#define HPET_T2_ROUTE	0x150
+
+#define HPET_ID_REV			0x000000ff
+#define HPET_ID_NUMBER		0x00001f00
+#define HPET_ID_64BIT		0x00002000
+#define HPET_ID_LEGSUP		0x00008000
+#define HPET_ID_VENDOR		0xffff0000
+#define HPET_ID_NUMBER_SHIFT	8
+#define HPET_ID_VENDOR_SHIFT	16
+
+#define HPET_CFG_ENABLE		0x001
+#define HPET_CFG_LEGACY		0x002
+#define HPET_LEGACY_8254		2
+#define HPET_LEGACY_RTC		8
+
+#define HPET_TN_LEVEL		0x0002
+#define HPET_TN_ENABLE		0x0004
+#define HPET_TN_PERIODIC	0x0008
+#define HPET_TN_PERIODIC_CAP	0x0010
+#define HPET_TN_64BIT_CAP	0x0020
+#define HPET_TN_SETVAL		0x0040
+#define HPET_TN_32BIT		0x0100
+#define HPET_TN_ROUTE		0x3e00
+#define HPET_TN_FSB			0x4000
+#define HPET_TN_FSB_CAP		0x8000
+#define HPET_TN_ROUTE_SHIFT	9
+
+/* Max HPET Period is 10^8 femto sec as in HPET spec */
+#define HPET_MAX_PERIOD		100000000UL
+/*
+ * Min HPET period is 10^5 femto sec just for safety. If it is less than this,
+ * then 32 bit HPET counter wrapsaround in less than 0.5 sec.
+ */
+#define HPET_MIN_PERIOD		100000UL
+
+#define HPET_ADDR		0x20000
+#define HPET_MMIO_ADDR	0x90000e0000020000
+#define HPET_FREQ		14318780
+#define HPET_COMPARE_VAL	((HPET_FREQ + HZ / 2) / HZ)
+#define HPET_T0_IRQ		0
+
+extern void __init setup_hpet_timer(void);
+#endif /* CONFIG_RS780_HPET */
+#endif /* _ASM_HPET_H */
diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 72f830ac..156de85 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -108,6 +108,18 @@ config CS5536_MFGPT
 
 	  If unsure, say Yes.
 
+config RS780_HPET
+	bool "RS780/SBX00 HPET Timer"
+	depends on LOONGSON_MACH3X
+	select MIPS_EXTERNAL_TIMER
+	help
+	  This option enables the hpet timer of AMD RS780/SBX00.
+
+	  If you want to enable the Loongson3 CPUFreq Driver, Please enable
+	  this option at first, otherwise, You will get wrong system time.
+
+	  If unsure, say Yes.
+
 config LOONGSON_SUSPEND
 	bool
 	default y
diff --git a/arch/mips/loongson/common/time.c b/arch/mips/loongson/common/time.c
index 262a1f6..e1a5382a 100644
--- a/arch/mips/loongson/common/time.c
+++ b/arch/mips/loongson/common/time.c
@@ -12,6 +12,7 @@
  */
 #include <asm/mc146818-time.h>
 #include <asm/time.h>
+#include <asm/hpet.h>
 
 #include <loongson.h>
 #include <cs5536/cs5536_mfgpt.h>
@@ -21,7 +22,11 @@ void __init plat_time_init(void)
 	/* setup mips r4k timer */
 	mips_hpt_frequency = cpu_clock_freq / 2;
 
+#ifdef CONFIG_RS780_HPET
+	setup_hpet_timer();
+#else
 	setup_mfgpt0_timer();
+#endif
 }
 
 void read_persistent_clock(struct timespec *ts)
diff --git a/arch/mips/loongson/loongson-3/Makefile b/arch/mips/loongson/loongson-3/Makefile
index 69809a3..622fead 100644
--- a/arch/mips/loongson/loongson-3/Makefile
+++ b/arch/mips/loongson/loongson-3/Makefile
@@ -6,3 +6,5 @@ obj-y			+= irq.o cop2-ex.o platform.o
 obj-$(CONFIG_SMP)	+= smp.o
 
 obj-$(CONFIG_NUMA)	+= numa.o
+
+obj-$(CONFIG_RS780_HPET) += hpet.o
diff --git a/arch/mips/loongson/loongson-3/hpet.c b/arch/mips/loongson/loongson-3/hpet.c
new file mode 100644
index 0000000..e898d68
--- /dev/null
+++ b/arch/mips/loongson/loongson-3/hpet.c
@@ -0,0 +1,257 @@
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/percpu.h>
+#include <linux/delay.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+
+#include <asm/hpet.h>
+#include <asm/time.h>
+
+#define SMBUS_CFG_BASE		(loongson_sysconf.ht_control_base + 0x0300a000)
+#define SMBUS_PCI_REG40		0x40
+#define SMBUS_PCI_REG64		0x64
+#define SMBUS_PCI_REGB4		0xb4
+
+static DEFINE_SPINLOCK(hpet_lock);
+DEFINE_PER_CPU(struct clock_event_device, hpet_clockevent_device);
+
+static unsigned int smbus_read(int offset)
+{
+	return *(volatile unsigned int *)(SMBUS_CFG_BASE + offset);
+}
+
+static void smbus_write(int offset, int data)
+{
+	*(volatile unsigned int *)(SMBUS_CFG_BASE + offset) = data;
+}
+
+static void smbus_enable(int offset, int bit)
+{
+	unsigned int cfg = smbus_read(offset);
+
+	cfg |= bit;
+	smbus_write(offset, cfg);
+}
+
+static int hpet_read(int offset)
+{
+	return *(volatile unsigned int *)(HPET_MMIO_ADDR + offset);
+}
+
+static void hpet_write(int offset, int data)
+{
+	*(volatile unsigned int *)(HPET_MMIO_ADDR + offset) = data;
+}
+
+static void hpet_start_counter(void)
+{
+	unsigned int cfg = hpet_read(HPET_CFG);
+
+	cfg |= HPET_CFG_ENABLE;
+	hpet_write(HPET_CFG, cfg);
+}
+
+static void hpet_stop_counter(void)
+{
+	unsigned int cfg = hpet_read(HPET_CFG);
+
+	cfg &= ~HPET_CFG_ENABLE;
+	hpet_write(HPET_CFG, cfg);
+}
+
+static void hpet_reset_counter(void)
+{
+	hpet_write(HPET_COUNTER, 0);
+	hpet_write(HPET_COUNTER + 4, 0);
+}
+
+static void hpet_restart_counter(void)
+{
+	hpet_stop_counter();
+	hpet_reset_counter();
+	hpet_start_counter();
+}
+
+static void hpet_enable_legacy_int(void)
+{
+	/* Do nothing on Loongson-3 */
+}
+
+static void hpet_set_mode(enum clock_event_mode mode,
+				struct clock_event_device *evt)
+{
+	int cfg = 0;
+
+	spin_lock(&hpet_lock);
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		pr_info("set clock event to periodic mode!\n");
+		/* stop counter */
+		hpet_stop_counter();
+
+		/* enables the timer0 to generate a periodic interrupt */
+		cfg = hpet_read(HPET_T0_CFG);
+		cfg &= ~HPET_TN_LEVEL;
+		cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC |
+				HPET_TN_SETVAL | HPET_TN_32BIT;
+		hpet_write(HPET_T0_CFG, cfg);
+
+		/* set the comparator */
+		hpet_write(HPET_T0_CMP, HPET_COMPARE_VAL);
+		udelay(1);
+		hpet_write(HPET_T0_CMP, HPET_COMPARE_VAL);
+
+		/* start counter */
+		hpet_start_counter();
+		break;
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_UNUSED:
+		cfg = hpet_read(HPET_T0_CFG);
+		cfg &= ~HPET_TN_ENABLE;
+		hpet_write(HPET_T0_CFG, cfg);
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		pr_info("set clock event to one shot mode!\n");
+		cfg = hpet_read(HPET_T0_CFG);
+		/* set timer0 type
+		 * 1 : periodic interrupt
+		 * 0 : non-periodic(oneshot) interrupt
+		 */
+		cfg &= ~HPET_TN_PERIODIC;
+		cfg |= HPET_TN_ENABLE | HPET_TN_32BIT;
+		hpet_write(HPET_T0_CFG, cfg);
+		break;
+	case CLOCK_EVT_MODE_RESUME:
+		hpet_enable_legacy_int();
+		break;
+	}
+	spin_unlock(&hpet_lock);
+}
+
+static int hpet_next_event(unsigned long delta,
+		struct clock_event_device *evt)
+{
+	unsigned int cnt;
+	int res;
+
+	cnt = hpet_read(HPET_COUNTER);
+	cnt += delta;
+	hpet_write(HPET_T0_CMP, cnt);
+
+	res = ((int)(hpet_read(HPET_COUNTER) - cnt) > 0) ? -ETIME : 0;
+	return res;
+}
+
+static irqreturn_t hpet_irq_handler(int irq, void *data)
+{
+	int is_irq;
+	struct clock_event_device *cd;
+	unsigned int cpu = smp_processor_id();
+
+	is_irq = hpet_read(HPET_STATUS);
+	if (is_irq & HPET_T0_IRS) {
+		/* clear the TIMER0 irq status register */
+		hpet_write(HPET_STATUS, HPET_T0_IRS);
+		cd = &per_cpu(hpet_clockevent_device, cpu);
+		cd->event_handler(cd);
+		return IRQ_HANDLED;
+	}
+	return IRQ_NONE;
+}
+
+static struct irqaction hpet_irq = {
+	.handler = hpet_irq_handler,
+	.flags = IRQF_DISABLED | IRQF_NOBALANCING | IRQF_TIMER,
+	.name = "hpet",
+};
+
+/*
+ * hpet address assignation and irq setting should be done in bios.
+ * but pmon don't do this, we just setup here directly.
+ * The operation under is normal. unfortunately, hpet_setup process
+ * is before pci initialize.
+ *
+ * {
+ *	struct pci_dev *pdev;
+ *
+ *	pdev = pci_get_device(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS, NULL);
+ *	pci_write_config_word(pdev, SMBUS_PCI_REGB4, HPET_ADDR);
+ *
+ *	...
+ * }
+ */
+static void hpet_setup(void)
+{
+	/* set hpet base address */
+	smbus_write(SMBUS_PCI_REGB4, HPET_ADDR);
+
+	/* enable decodeing of access to HPET MMIO*/
+	smbus_enable(SMBUS_PCI_REG40, (1 << 28));
+
+	/* HPET irq enable */
+	smbus_enable(SMBUS_PCI_REG64, (1 << 10));
+
+	hpet_enable_legacy_int();
+}
+
+void __init setup_hpet_timer(void)
+{
+	unsigned int cpu = smp_processor_id();
+	struct clock_event_device *cd;
+
+	hpet_setup();
+
+	cd = &per_cpu(hpet_clockevent_device, cpu);
+	cd->name = "hpet";
+	cd->rating = 320;
+	cd->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
+	cd->set_mode = hpet_set_mode;
+	cd->set_next_event = hpet_next_event;
+	cd->irq = HPET_T0_IRQ;
+	cd->cpumask = cpumask_of(cpu);
+	clockevent_set_clock(cd, HPET_FREQ);
+	cd->max_delta_ns = clockevent_delta2ns(0x7fffffff, cd);
+	cd->min_delta_ns = 5000;
+
+	clockevents_register_device(cd);
+	setup_irq(HPET_T0_IRQ, &hpet_irq);
+	pr_info("hpet clock event device register\n");
+}
+
+static cycle_t hpet_read_counter(struct clocksource *cs)
+{
+	return (cycle_t)hpet_read(HPET_COUNTER);
+}
+
+static void hpet_suspend(struct clocksource *cs)
+{
+}
+
+static void hpet_resume(struct clocksource *cs)
+{
+	hpet_setup();
+	hpet_restart_counter();
+}
+
+static struct clocksource csrc_hpet = {
+	.name = "hpet",
+	/* mips clocksource rating is less than 300, so hpet is better. */
+	.rating = 300,
+	.read = hpet_read_counter,
+	.mask = CLOCKSOURCE_MASK(32),
+	/* oneshot mode work normal with this flag */
+	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
+	.suspend = hpet_suspend,
+	.resume = hpet_resume,
+	.mult = 0,
+	.shift = 10,
+};
+
+int __init init_hpet_clocksource(void)
+{
+	csrc_hpet.mult = clocksource_hz2mult(HPET_FREQ, csrc_hpet.shift);
+	return clocksource_register_hz(&csrc_hpet, HPET_FREQ);
+}
+
+arch_initcall(init_hpet_clocksource);
diff --git a/arch/mips/loongson/loongson-3/irq.c b/arch/mips/loongson/loongson-3/irq.c
index 5813d94..21221ed 100644
--- a/arch/mips/loongson/loongson-3/irq.c
+++ b/arch/mips/loongson/loongson-3/irq.c
@@ -9,7 +9,7 @@
 
 #include "smp.h"
 
-unsigned int ht_irq[] = {1, 3, 4, 5, 6, 7, 8, 12, 14, 15};
+unsigned int ht_irq[] = {0, 1, 3, 4, 5, 6, 7, 8, 12, 14, 15};
 
 static void ht_irqdispatch(void)
 {
-- 
1.7.7.3
