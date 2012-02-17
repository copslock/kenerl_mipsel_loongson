Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2012 11:36:59 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:36936 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903696Ab2BQKdh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Feb 2012 11:33:37 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 2/9] MIPS: lantiq: convert to clkdev api
Date:   Fri, 17 Feb 2012 11:33:13 +0100
Message-Id: <1329474800-20979-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1329474800-20979-1-git-send-email-blogic@openwrt.org>
References: <1329474800-20979-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Add clk_activate/clk_deactivate and add better error paths to the clk
api functions.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/Kconfig                          |    3 +-
 arch/mips/include/asm/mach-lantiq/lantiq.h |   17 ++----
 arch/mips/lantiq/clk.c                     |   85 +++++++++++----------------
 arch/mips/lantiq/clk.h                     |   59 ++++++++++++++++++-
 arch/mips/lantiq/prom.c                    |    1 -
 5 files changed, 97 insertions(+), 68 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c4c1312..b106c9e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -228,7 +228,8 @@ config LANTIQ
 	select ARCH_REQUIRE_GPIOLIB
 	select SWAP_IO_SPACE
 	select BOOT_RAW
-	select HAVE_CLK
+	select HAVE_MACH_CLKDEV
+	select CLKDEV_LOOKUP
 	select MIPS_MACHINE
 
 config LASAT
diff --git a/arch/mips/include/asm/mach-lantiq/lantiq.h b/arch/mips/include/asm/mach-lantiq/lantiq.h
index d90eef3..895a346 100644
--- a/arch/mips/include/asm/mach-lantiq/lantiq.h
+++ b/arch/mips/include/asm/mach-lantiq/lantiq.h
@@ -9,6 +9,7 @@
 #define _LANTIQ_H__
 
 #include <linux/irq.h>
+#include <linux/clk.h>
 #include <linux/ioport.h>
 
 /* generic reg access */
@@ -24,18 +25,6 @@ static inline void ltq_w32_mask(u32 c, u32 s, volatile void __iomem *r)
 extern unsigned int ltq_get_cpu_ver(void);
 extern unsigned int ltq_get_soc_type(void);
 
-/* clock speeds */
-#define CLOCK_60M	60000000
-#define CLOCK_83M	83333333
-#define CLOCK_100M	100000000
-#define CLOCK_111M	111111111
-#define CLOCK_133M	133333333
-#define CLOCK_167M	166666667
-#define CLOCK_200M	200000000
-#define CLOCK_266M	266666666
-#define CLOCK_333M	333333333
-#define CLOCK_400M	400000000
-
 /* spinlock all ebu i/o */
 extern spinlock_t ebu_lock;
 
@@ -48,6 +37,10 @@ extern void ltq_disable_irq(struct irq_data *data);
 extern void ltq_mask_and_ack_irq(struct irq_data *data);
 extern void ltq_enable_irq(struct irq_data *data);
 
+/* clock handling */
+extern int clk_activate(struct clk *clk);
+extern void clk_deactivate(struct clk *clk);
+
 /* find out what caused the last cpu reset */
 extern int ltq_reset_cause(void);
 
diff --git a/arch/mips/lantiq/clk.c b/arch/mips/lantiq/clk.c
index 39eef7f..66d1a60 100644
--- a/arch/mips/lantiq/clk.c
+++ b/arch/mips/lantiq/clk.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/clk.h>
+#include <linux/clkdev.h>
 #include <linux/err.h>
 #include <linux/list.h>
 
@@ -24,35 +25,6 @@
 #include "clk.h"
 #include "prom.h"
 
-struct clk {
-	const char *name;
-	unsigned long rate;
-	unsigned long (*get_rate) (void);
-};
-
-static struct clk *cpu_clk;
-static int cpu_clk_cnt;
-
-/* lantiq socs have 3 static clocks */
-static struct clk cpu_clk_generic[] = {
-	{
-		.name = "cpu",
-		.get_rate = ltq_get_cpu_hz,
-	}, {
-		.name = "fpi",
-		.get_rate = ltq_get_fpi_hz,
-	}, {
-		.name = "io",
-		.get_rate = ltq_get_io_region_clock,
-	},
-};
-
-void clk_init(void)
-{
-	cpu_clk = cpu_clk_generic;
-	cpu_clk_cnt = ARRAY_SIZE(cpu_clk_generic);
-}
-
 static inline int clk_good(struct clk *clk)
 {
 	return clk && !IS_ERR(clk);
@@ -61,7 +33,7 @@ static inline int clk_good(struct clk *clk)
 unsigned long clk_get_rate(struct clk *clk)
 {
 	if (unlikely(!clk_good(clk)))
-		return 0;
+		return -1;
 
 	if (clk->rate != 0)
 		return clk->rate;
@@ -69,40 +41,53 @@ unsigned long clk_get_rate(struct clk *clk)
 	if (clk->get_rate != NULL)
 		return clk->get_rate();
 
-	return 0;
+	return -1;
 }
 EXPORT_SYMBOL(clk_get_rate);
 
-struct clk *clk_get(struct device *dev, const char *id)
+int clk_enable(struct clk *clk)
 {
-	int i;
+	if (unlikely(!clk_good(clk)))
+		return -1;
 
-	for (i = 0; i < cpu_clk_cnt; i++)
-		if (!strcmp(id, cpu_clk[i].name))
-			return &cpu_clk[i];
-	BUG();
-	return ERR_PTR(-ENOENT);
+	if (clk->enable)
+		return clk->enable(clk);
+
+	return -1;
 }
-EXPORT_SYMBOL(clk_get);
+EXPORT_SYMBOL(clk_enable);
 
-void clk_put(struct clk *clk)
+void clk_disable(struct clk *clk)
 {
-	/* not used */
+	if (unlikely(!clk_good(clk)))
+		return;
+
+	if (clk->disable)
+		clk->disable(clk);
 }
-EXPORT_SYMBOL(clk_put);
+EXPORT_SYMBOL(clk_disable);
 
-int clk_enable(struct clk *clk)
+int clk_activate(struct clk *clk)
 {
-	/* not used */
-	return 0;
+	if (unlikely(!clk_good(clk)))
+		return -1;
+
+	if (clk->activate)
+		return clk->activate(clk);
+
+	return -1;
 }
-EXPORT_SYMBOL(clk_enable);
+EXPORT_SYMBOL(clk_activate);
 
-void clk_disable(struct clk *clk)
+void clk_deactivate(struct clk *clk)
 {
-	/* not used */
+	if (unlikely(!clk_good(clk)))
+		return;
+
+	if (clk->deactivate)
+		clk->deactivate(clk);
 }
-EXPORT_SYMBOL(clk_disable);
+EXPORT_SYMBOL(clk_deactivate);
 
 static inline u32 ltq_get_counter_resolution(void)
 {
@@ -126,7 +111,7 @@ void __init plat_time_init(void)
 
 	ltq_soc_init();
 
-	clk = clk_get(0, "cpu");
+	clk = clk_get_sys("cpu", NULL);
 	mips_hpt_frequency = clk_get_rate(clk) / ltq_get_counter_resolution();
 	write_c0_compare(read_c0_count());
 	pr_info("CPU Clock: %ldMHz\n", clk_get_rate(clk) / 1000000);
diff --git a/arch/mips/lantiq/clk.h b/arch/mips/lantiq/clk.h
index 3328925..1179bb3 100644
--- a/arch/mips/lantiq/clk.h
+++ b/arch/mips/lantiq/clk.h
@@ -9,10 +9,61 @@
 #ifndef _LTQ_CLK_H__
 #define _LTQ_CLK_H__
 
-extern void clk_init(void);
+#include <linux/clkdev.h>
 
-extern unsigned long ltq_get_cpu_hz(void);
-extern unsigned long ltq_get_fpi_hz(void);
-extern unsigned long ltq_get_io_region_clock(void);
+/* clock speeds */
+#define CLOCK_60M	60000000
+#define CLOCK_62_5M	62500000
+#define CLOCK_83M	83333333
+#define CLOCK_83_5M	83500000
+#define CLOCK_98_304M	98304000
+#define CLOCK_100M	100000000
+#define CLOCK_111M	111111111
+#define CLOCK_125M	125000000
+#define CLOCK_133M	133333333
+#define CLOCK_150M	150000000
+#define CLOCK_166M	166666666
+#define CLOCK_167M	166666667
+#define CLOCK_196_608M	196608000
+#define CLOCK_200M	200000000
+#define CLOCK_250M	250000000
+#define CLOCK_266M	266666666
+#define CLOCK_300M	300000000
+#define CLOCK_333M	333333333
+#define CLOCK_393M	393215332
+#define CLOCK_400M	400000000
+#define CLOCK_500M	500000000
+#define CLOCK_600M	600000000
+
+struct clk {
+	struct clk_lookup cl;
+	unsigned long rate;
+	unsigned long (*get_rate) (void);
+	unsigned int module;
+	unsigned int bits;
+	int (*enable) (struct clk *clk);
+	void (*disable) (struct clk *clk);
+	int (*activate) (struct clk *clk);
+	void (*deactivate) (struct clk *clk);
+	void (*reboot) (struct clk *clk);
+};
+
+static inline void clkdev_add_static(const char *dev, unsigned long rate)
+{
+	struct clk *clk = kzalloc(sizeof(struct clk), GFP_KERNEL);
+
+	clk->cl.dev_id = dev;
+	clk->cl.clk = clk;
+	clk->rate = rate;
+	clkdev_add(&clk->cl);
+}
+
+extern unsigned long ltq_danube_cpu_hz(void);
+extern unsigned long ltq_danube_fpi_hz(void);
+extern unsigned long ltq_danube_io_region_clock(void);
+
+extern unsigned long ltq_vr9_cpu_hz(void);
+extern unsigned long ltq_vr9_fpi_hz(void);
+extern unsigned long ltq_vr9_io_region_clock(void);
 
 #endif
diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index ee63a33..b002bc7 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -103,7 +103,6 @@ EXPORT_SYMBOL(ltq_remap_resource);
 void __init prom_init(void)
 {
 	ltq_soc_detect(&soc_info);
-	clk_init();
 	snprintf(soc_info.sys_type, LTQ_SYS_TYPE_LEN - 1, "%s rev %s",
 		soc_info.name, soc_info.rev_type);
 	soc_info.sys_type[LTQ_SYS_TYPE_LEN - 1] = '\0';
-- 
1.7.7.1
