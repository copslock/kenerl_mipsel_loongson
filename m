Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2012 21:44:57 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:47496 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904051Ab2AKUop (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Jan 2012 21:44:45 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH RESEND 01/17] MIPS: lantiq: reorganize xway code
Date:   Wed, 11 Jan 2012 21:44:18 +0100
Message-Id: <1326314674-9899-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
X-archive-position: 32215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Inside the folder arch/mips/lantiq/xway, there were alot of small files with
lots of duplicated code. This patch adds a wrapper function for inserting and
requesting resources and unifies the small files into one bigger file.

This patch makes the xway code consistent with the falcon support added later
in this series.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/mach-lantiq/lantiq.h         |   21 ++---
 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |   30 ++++++++
 arch/mips/lantiq/clk.c                             |   25 +------
 arch/mips/lantiq/devices.c                         |   30 ++------
 arch/mips/lantiq/devices.h                         |    4 +
 arch/mips/lantiq/prom.c                            |   51 +++++++++++--
 arch/mips/lantiq/prom.h                            |    4 +
 arch/mips/lantiq/xway/Makefile                     |    6 +-
 arch/mips/lantiq/xway/devices.c                    |   42 ++---------
 arch/mips/lantiq/xway/dma.c                        |   21 +----
 arch/mips/lantiq/xway/ebu.c                        |   52 -------------
 arch/mips/lantiq/xway/pmu.c                        |   69 -----------------
 arch/mips/lantiq/xway/prom-ase.c                   |    9 ++
 arch/mips/lantiq/xway/prom-xway.c                  |   10 +++
 arch/mips/lantiq/xway/reset.c                      |   21 +----
 arch/mips/lantiq/xway/setup-ase.c                  |   19 -----
 arch/mips/lantiq/xway/setup-xway.c                 |   20 -----
 arch/mips/lantiq/xway/sysctrl.c                    |   78 ++++++++++++++++++++
 drivers/watchdog/lantiq_wdt.c                      |    2 +-
 19 files changed, 219 insertions(+), 295 deletions(-)
 delete mode 100644 arch/mips/lantiq/xway/ebu.c
 delete mode 100644 arch/mips/lantiq/xway/pmu.c
 delete mode 100644 arch/mips/lantiq/xway/setup-ase.c
 delete mode 100644 arch/mips/lantiq/xway/setup-xway.c
 create mode 100644 arch/mips/lantiq/xway/sysctrl.c

diff --git a/arch/mips/include/asm/mach-lantiq/lantiq.h b/arch/mips/include/asm/mach-lantiq/lantiq.h
index ce2f029..daaa3f7 100644
--- a/arch/mips/include/asm/mach-lantiq/lantiq.h
+++ b/arch/mips/include/asm/mach-lantiq/lantiq.h
@@ -9,23 +9,16 @@
 #define _LANTIQ_H__
 
 #include <linux/irq.h>
+#include <linux/ioport.h>
 
-/* generic reg access functions */
+/* generic reg access */
 #define ltq_r32(reg)		__raw_readl(reg)
 #define ltq_w32(val, reg)	__raw_writel(val, reg)
-#define ltq_w32_mask(clear, set, reg)	\
-	ltq_w32((ltq_r32(reg) & ~(clear)) | (set), reg)
 #define ltq_r8(reg)		__raw_readb(reg)
 #define ltq_w8(val, reg)	__raw_writeb(val, reg)
-
-/* register access macros for EBU and CGU */
-#define ltq_ebu_w32(x, y)	ltq_w32((x), ltq_ebu_membase + (y))
-#define ltq_ebu_r32(x)		ltq_r32(ltq_ebu_membase + (x))
-#define ltq_cgu_w32(x, y)	ltq_w32((x), ltq_cgu_membase + (y))
-#define ltq_cgu_r32(x)		ltq_r32(ltq_cgu_membase + (x))
-
-extern __iomem void *ltq_ebu_membase;
-extern __iomem void *ltq_cgu_membase;
+static inline void ltq_w32_mask(u32 c, u32 s, volatile void __iomem * r) {
+	ltq_w32((ltq_r32(r) & ~c) | s, r);
+}
 
 extern unsigned int ltq_get_cpu_ver(void);
 extern unsigned int ltq_get_soc_type(void);
@@ -51,7 +44,9 @@ extern void ltq_enable_irq(struct irq_data *data);
 
 /* find out what caused the last cpu reset */
 extern int ltq_reset_cause(void);
-#define LTQ_RST_CAUSE_WDTRST	0x20
+
+/* helper for requesting and remapping resources */
+extern void __iomem *ltq_remap_resource(struct resource *res);
 
 #define IOPORT_RESOURCE_START	0x10000000
 #define IOPORT_RESOURCE_END	0xffffffff
diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
index 8a3c6be..9ea7043 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
@@ -61,6 +61,8 @@
 #define LTQ_CGU_BASE_ADDR	0x1F103000
 #define LTQ_CGU_SIZE		0x1000
 
+#define CGU_EPHY		0x10
+
 /* ICU - interrupt control unit */
 #define LTQ_ICU_BASE_ADDR	0x1F880200
 #define LTQ_ICU_SIZE		0x100
@@ -97,6 +99,8 @@
 #define LTQ_WDT_BASE_ADDR	0x1F8803F0
 #define LTQ_WDT_SIZE		0x10
 
+#define LTQ_RST_CAUSE_WDTRST	0x20
+
 /* STP - serial to parallel conversion unit */
 #define LTQ_STP_BASE_ADDR	0x1E100BB0
 #define LTQ_STP_SIZE		0x40
@@ -121,11 +125,37 @@
 #define LTQ_MPS_BASE_ADDR	(KSEG1 + 0x1F107000)
 #define LTQ_MPS_CHIPID		((u32 *)(LTQ_MPS_BASE_ADDR + 0x0344))
 
+extern __iomem void *ltq_ebu_membase;
+extern __iomem void *ltq_cgu_membase;
+
+/* ebu access */
+static inline void ltq_ebu_w32(u32 v, u32 r) {
+	ltq_w32(v, ltq_ebu_membase + r);
+};
+static inline u32 ltq_ebu_r32(u32 r) {
+	return ltq_r32(ltq_ebu_membase + r);
+};
+static inline void ltq_ebu_w32_mask(u32 c, u32 s, u32 r) {
+	ltq_ebu_w32((ltq_ebu_r32(r) & ~c) | s, r);
+}
+
+/* cgu access */
+static inline void ltq_cgu_w32(u32 v, u32 r) {
+	ltq_w32(v, ltq_cgu_membase + r);
+};
+static inline u32 ltq_cgu_r32(u32 r) {
+	return ltq_r32(ltq_cgu_membase + r);
+};
+static inline void ltq_cgu_w32_mask(u32 c, u32 s, u32 r) {
+	ltq_cgu_w32((ltq_cgu_r32(r) & ~c) | s, r);
+}
+
 /* request a non-gpio and set the PIO config */
 extern int  ltq_gpio_request(unsigned int pin, unsigned int alt0,
 	unsigned int alt1, unsigned int dir, const char *name);
 extern void ltq_pmu_enable(unsigned int module);
 extern void ltq_pmu_disable(unsigned int module);
+extern void ltq_cgu_enable(unsigned int clk);
 
 static inline int ltq_is_ar9(void)
 {
diff --git a/arch/mips/lantiq/clk.c b/arch/mips/lantiq/clk.c
index 412814f..39eef7f 100644
--- a/arch/mips/lantiq/clk.c
+++ b/arch/mips/lantiq/clk.c
@@ -22,6 +22,7 @@
 #include <lantiq_soc.h>
 
 #include "clk.h"
+#include "prom.h"
 
 struct clk {
 	const char *name;
@@ -46,16 +47,6 @@ static struct clk cpu_clk_generic[] = {
 	},
 };
 
-static struct resource ltq_cgu_resource = {
-	.name	= "cgu",
-	.start	= LTQ_CGU_BASE_ADDR,
-	.end	= LTQ_CGU_BASE_ADDR + LTQ_CGU_SIZE - 1,
-	.flags	= IORESOURCE_MEM,
-};
-
-/* remapped clock register range */
-void __iomem *ltq_cgu_membase;
-
 void clk_init(void)
 {
 	cpu_clk = cpu_clk_generic;
@@ -133,21 +124,11 @@ void __init plat_time_init(void)
 {
 	struct clk *clk;
 
-	if (insert_resource(&iomem_resource, &ltq_cgu_resource) < 0)
-		panic("Failed to insert cgu memory");
-
-	if (request_mem_region(ltq_cgu_resource.start,
-			resource_size(&ltq_cgu_resource), "cgu") < 0)
-		panic("Failed to request cgu memory");
+	ltq_soc_init();
 
-	ltq_cgu_membase = ioremap_nocache(ltq_cgu_resource.start,
-				resource_size(&ltq_cgu_resource));
-	if (!ltq_cgu_membase) {
-		pr_err("Failed to remap cgu memory\n");
-		unreachable();
-	}
 	clk = clk_get(0, "cpu");
 	mips_hpt_frequency = clk_get_rate(clk) / ltq_get_counter_resolution();
 	write_c0_compare(read_c0_count());
+	pr_info("CPU Clock: %ldMHz\n", clk_get_rate(clk) / 1000000);
 	clk_put(clk);
 }
diff --git a/arch/mips/lantiq/devices.c b/arch/mips/lantiq/devices.c
index de1cb2b..7193d78 100644
--- a/arch/mips/lantiq/devices.c
+++ b/arch/mips/lantiq/devices.c
@@ -27,12 +27,8 @@
 #include "devices.h"
 
 /* nor flash */
-static struct resource ltq_nor_resource = {
-	.name	= "nor",
-	.start	= LTQ_FLASH_START,
-	.end	= LTQ_FLASH_START + LTQ_FLASH_MAX - 1,
-	.flags  = IORESOURCE_MEM,
-};
+static struct resource ltq_nor_resource =
+	MEM_RES("nor", LTQ_FLASH_START, LTQ_FLASH_MAX);
 
 static struct platform_device ltq_nor = {
 	.name		= "ltq_nor",
@@ -47,12 +43,8 @@ void __init ltq_register_nor(struct physmap_flash_data *data)
 }
 
 /* watchdog */
-static struct resource ltq_wdt_resource = {
-	.name	= "watchdog",
-	.start  = LTQ_WDT_BASE_ADDR,
-	.end    = LTQ_WDT_BASE_ADDR + LTQ_WDT_SIZE - 1,
-	.flags  = IORESOURCE_MEM,
-};
+static struct resource ltq_wdt_resource =
+	MEM_RES("watchdog", LTQ_WDT_BASE_ADDR, LTQ_WDT_SIZE);
 
 void __init ltq_register_wdt(void)
 {
@@ -61,24 +53,14 @@ void __init ltq_register_wdt(void)
 
 /* asc ports */
 static struct resource ltq_asc0_resources[] = {
-	{
-		.name	= "asc0",
-		.start  = LTQ_ASC0_BASE_ADDR,
-		.end    = LTQ_ASC0_BASE_ADDR + LTQ_ASC_SIZE - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	MEM_RES("asc0", LTQ_ASC0_BASE_ADDR, LTQ_ASC_SIZE),
 	IRQ_RES(tx, LTQ_ASC_TIR(0)),
 	IRQ_RES(rx, LTQ_ASC_RIR(0)),
 	IRQ_RES(err, LTQ_ASC_EIR(0)),
 };
 
 static struct resource ltq_asc1_resources[] = {
-	{
-		.name	= "asc1",
-		.start  = LTQ_ASC1_BASE_ADDR,
-		.end    = LTQ_ASC1_BASE_ADDR + LTQ_ASC_SIZE - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	MEM_RES("asc1", LTQ_ASC1_BASE_ADDR, LTQ_ASC_SIZE),
 	IRQ_RES(tx, LTQ_ASC_TIR(1)),
 	IRQ_RES(rx, LTQ_ASC_RIR(1)),
 	IRQ_RES(err, LTQ_ASC_EIR(1)),
diff --git a/arch/mips/lantiq/devices.h b/arch/mips/lantiq/devices.h
index 2947bb1..18b65df 100644
--- a/arch/mips/lantiq/devices.h
+++ b/arch/mips/lantiq/devices.h
@@ -14,6 +14,10 @@
 
 #define IRQ_RES(resname, irq) \
 	{.name = #resname, .start = (irq), .flags = IORESOURCE_IRQ}
+#define MEM_RES(resname, adr_start, adr_size) \
+	{ .name = resname, .flags = IORESOURCE_MEM, \
+	  .start = CPHYSADDR(adr_start), \
+	  .end = CPHYSADDR(adr_start + adr_size - 1) }
 
 extern void ltq_register_nor(struct physmap_flash_data *data);
 extern void ltq_register_wdt(void);
diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index e34fcfd..528e205 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -16,6 +16,10 @@
 #include "prom.h"
 #include "clk.h"
 
+/* access to the ebu needs to be locked between different drivers */
+DEFINE_SPINLOCK(ebu_lock);
+EXPORT_SYMBOL_GPL(ebu_lock);
+
 static struct ltq_soc_info soc_info;
 
 unsigned int ltq_get_cpu_ver(void)
@@ -55,16 +59,51 @@ static void __init prom_init_cmdline(void)
 	}
 }
 
-void __init prom_init(void)
+void __iomem *ltq_remap_resource(struct resource *res)
 {
-	struct clk *clk;
+	__iomem void *ret = NULL;
+	struct resource *lookup = lookup_resource(&iomem_resource, res->start);
+
+	if (lookup && strcmp(lookup->name, res->name)) {
+		pr_err("conflicting memory range %s\n", res->name);
+		return NULL;
+	}
+	if (!lookup) {
+		if (insert_resource(&iomem_resource, res) < 0) {
+			pr_err("Failed to insert %s memory\n", res->name);
+			return NULL;
+		}
+	}
+	if (request_mem_region(res->start,
+			resource_size(res), res->name) < 0) {
+		pr_err("Failed to request %s memory\n", res->name);
+		goto err_res;
+	}
 
+	ret = ioremap_nocache(res->start, resource_size(res));
+	if (!ret)
+		goto err_mem;
+
+	pr_debug("remap: 0x%08X-0x%08X : \"%s\"\n",
+		res->start, res->end, res->name);
+	return ret;
+
+err_mem:
+	panic("Failed to remap %s memory", res->name);
+	release_mem_region(res->start, resource_size(res));
+
+err_res:
+	release_resource(res);
+	return NULL;
+}
+EXPORT_SYMBOL(ltq_remap_resource);
+
+void __init prom_init(void)
+{
 	ltq_soc_detect(&soc_info);
 	clk_init();
-	clk = clk_get(0, "cpu");
-	snprintf(soc_info.sys_type, LTQ_SYS_TYPE_LEN - 1, "%s rev1.%d",
-		soc_info.name, soc_info.rev);
-	clk_put(clk);
+	snprintf(soc_info.sys_type, LTQ_SYS_TYPE_LEN - 1, "%s rev %s",
+		soc_info.name, soc_info.rev_type);
 	soc_info.sys_type[LTQ_SYS_TYPE_LEN - 1] = '\0';
 	pr_info("SoC: %s\n", soc_info.sys_type);
 	prom_init_cmdline();
diff --git a/arch/mips/lantiq/prom.h b/arch/mips/lantiq/prom.h
index b4229d9..51dba1b 100644
--- a/arch/mips/lantiq/prom.h
+++ b/arch/mips/lantiq/prom.h
@@ -9,17 +9,21 @@
 #ifndef _LTQ_PROM_H__
 #define _LTQ_PROM_H__
 
+#define LTQ_SYS_REV_LEN		0x10
 #define LTQ_SYS_TYPE_LEN	0x100
 
 struct ltq_soc_info {
 	unsigned char *name;
 	unsigned int rev;
+	unsigned char rev_type[LTQ_SYS_REV_LEN];
+	unsigned int srev;
 	unsigned int partnum;
 	unsigned int type;
 	unsigned char sys_type[LTQ_SYS_TYPE_LEN];
 };
 
 extern void ltq_soc_detect(struct ltq_soc_info *i);
+extern void ltq_soc_init(void);
 extern void ltq_soc_setup(void);
 
 #endif
diff --git a/arch/mips/lantiq/xway/Makefile b/arch/mips/lantiq/xway/Makefile
index c517f2e..6678402 100644
--- a/arch/mips/lantiq/xway/Makefile
+++ b/arch/mips/lantiq/xway/Makefile
@@ -1,7 +1,7 @@
-obj-y := pmu.o ebu.o reset.o gpio.o gpio_stp.o gpio_ebu.o devices.o dma.o
+obj-y := sysctrl.o reset.o gpio.o gpio_stp.o gpio_ebu.o devices.o dma.o
 
-obj-$(CONFIG_SOC_XWAY) += clk-xway.o prom-xway.o setup-xway.o
-obj-$(CONFIG_SOC_AMAZON_SE) += clk-ase.o prom-ase.o setup-ase.o
+obj-$(CONFIG_SOC_XWAY) += clk-xway.o prom-xway.o
+obj-$(CONFIG_SOC_AMAZON_SE) += clk-ase.o prom-ase.o
 
 obj-$(CONFIG_LANTIQ_MACH_EASY50712) += mach-easy50712.o
 obj-$(CONFIG_LANTIQ_MACH_EASY50601) += mach-easy50601.o
diff --git a/arch/mips/lantiq/xway/devices.c b/arch/mips/lantiq/xway/devices.c
index d614aa7..f97e565 100644
--- a/arch/mips/lantiq/xway/devices.c
+++ b/arch/mips/lantiq/xway/devices.c
@@ -31,22 +31,9 @@
 
 /* gpio */
 static struct resource ltq_gpio_resource[] = {
-	{
-		.name	= "gpio0",
-		.start  = LTQ_GPIO0_BASE_ADDR,
-		.end    = LTQ_GPIO0_BASE_ADDR + LTQ_GPIO_SIZE - 1,
-		.flags  = IORESOURCE_MEM,
-	}, {
-		.name	= "gpio1",
-		.start  = LTQ_GPIO1_BASE_ADDR,
-		.end    = LTQ_GPIO1_BASE_ADDR + LTQ_GPIO_SIZE - 1,
-		.flags  = IORESOURCE_MEM,
-	}, {
-		.name	= "gpio2",
-		.start  = LTQ_GPIO2_BASE_ADDR,
-		.end    = LTQ_GPIO2_BASE_ADDR + LTQ_GPIO_SIZE - 1,
-		.flags  = IORESOURCE_MEM,
-	}
+	MEM_RES("gpio0", LTQ_GPIO0_BASE_ADDR, LTQ_GPIO_SIZE),
+	MEM_RES("gpio1", LTQ_GPIO1_BASE_ADDR, LTQ_GPIO_SIZE),
+	MEM_RES("gpio2", LTQ_GPIO2_BASE_ADDR, LTQ_GPIO_SIZE),
 };
 
 void __init ltq_register_gpio(void)
@@ -64,12 +51,8 @@ void __init ltq_register_gpio(void)
 }
 
 /* serial to parallel conversion */
-static struct resource ltq_stp_resource = {
-	.name   = "stp",
-	.start  = LTQ_STP_BASE_ADDR,
-	.end    = LTQ_STP_BASE_ADDR + LTQ_STP_SIZE - 1,
-	.flags  = IORESOURCE_MEM,
-};
+static struct resource ltq_stp_resource =
+	MEM_RES("stp", LTQ_STP_BASE_ADDR, LTQ_STP_SIZE);
 
 void __init ltq_register_gpio_stp(void)
 {
@@ -78,12 +61,7 @@ void __init ltq_register_gpio_stp(void)
 
 /* asc ports - amazon se has its own serial mapping */
 static struct resource ltq_ase_asc_resources[] = {
-	{
-		.name	= "asc0",
-		.start  = LTQ_ASC1_BASE_ADDR,
-		.end    = LTQ_ASC1_BASE_ADDR + LTQ_ASC_SIZE - 1,
-		.flags  = IORESOURCE_MEM,
-	},
+	MEM_RES("asc0", LTQ_ASC1_BASE_ADDR, LTQ_ASC_SIZE),
 	IRQ_RES(tx, LTQ_ASC_ASE_TIR),
 	IRQ_RES(rx, LTQ_ASC_ASE_RIR),
 	IRQ_RES(err, LTQ_ASC_ASE_EIR),
@@ -96,12 +74,8 @@ void __init ltq_register_ase_asc(void)
 }
 
 /* ethernet */
-static struct resource ltq_etop_resources = {
-	.name	= "etop",
-	.start	= LTQ_ETOP_BASE_ADDR,
-	.end	= LTQ_ETOP_BASE_ADDR + LTQ_ETOP_SIZE - 1,
-	.flags	= IORESOURCE_MEM,
-};
+static struct resource ltq_etop_resources =
+	MEM_RES("etop", LTQ_ETOP_BASE_ADDR, LTQ_ETOP_SIZE);
 
 static struct platform_device ltq_etop = {
 	.name		= "ltq_etop",
diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
index b210e93..6cf883b 100644
--- a/arch/mips/lantiq/xway/dma.c
+++ b/arch/mips/lantiq/xway/dma.c
@@ -24,6 +24,8 @@
 #include <lantiq_soc.h>
 #include <xway_dma.h>
 
+#include "../devices.h"
+
 #define LTQ_DMA_CTRL		0x10
 #define LTQ_DMA_CPOLL		0x14
 #define LTQ_DMA_CS		0x18
@@ -55,12 +57,8 @@
 #define ltq_dma_w32_mask(x, y, z)	ltq_w32_mask(x, y, \
 						ltq_dma_membase + (z))
 
-static struct resource ltq_dma_resource = {
-	.name	= "dma",
-	.start	= LTQ_DMA_BASE_ADDR,
-	.end	= LTQ_DMA_BASE_ADDR + LTQ_DMA_SIZE - 1,
-	.flags  = IORESOURCE_MEM,
-};
+static struct resource ltq_dma_resource =
+	MEM_RES("dma", LTQ_DMA_BASE_ADDR, LTQ_DMA_SIZE);
 
 static void __iomem *ltq_dma_membase;
 
@@ -220,17 +218,8 @@ ltq_dma_init(void)
 {
 	int i;
 
-	/* insert and request the memory region */
-	if (insert_resource(&iomem_resource, &ltq_dma_resource) < 0)
-		panic("Failed to insert dma memory");
-
-	if (request_mem_region(ltq_dma_resource.start,
-			resource_size(&ltq_dma_resource), "dma") < 0)
-		panic("Failed to request dma memory");
-
 	/* remap dma register range */
-	ltq_dma_membase = ioremap_nocache(ltq_dma_resource.start,
-				resource_size(&ltq_dma_resource));
+	ltq_dma_membase = ltq_remap_resource(&ltq_dma_resource);
 	if (!ltq_dma_membase)
 		panic("Failed to remap dma memory");
 
diff --git a/arch/mips/lantiq/xway/ebu.c b/arch/mips/lantiq/xway/ebu.c
deleted file mode 100644
index 862e3e8..0000000
--- a/arch/mips/lantiq/xway/ebu.c
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- *
- *  EBU - the external bus unit attaches PCI, NOR and NAND
- *
- *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/ioport.h>
-
-#include <lantiq_soc.h>
-
-/* all access to the ebu must be locked */
-DEFINE_SPINLOCK(ebu_lock);
-EXPORT_SYMBOL_GPL(ebu_lock);
-
-static struct resource ltq_ebu_resource = {
-	.name	= "ebu",
-	.start	= LTQ_EBU_BASE_ADDR,
-	.end	= LTQ_EBU_BASE_ADDR + LTQ_EBU_SIZE - 1,
-	.flags	= IORESOURCE_MEM,
-};
-
-/* remapped base addr of the clock unit and external bus unit */
-void __iomem *ltq_ebu_membase;
-
-static int __init lantiq_ebu_init(void)
-{
-	/* insert and request the memory region */
-	if (insert_resource(&iomem_resource, &ltq_ebu_resource) < 0)
-		panic("Failed to insert ebu memory");
-
-	if (request_mem_region(ltq_ebu_resource.start,
-			resource_size(&ltq_ebu_resource), "ebu") < 0)
-		panic("Failed to request ebu memory");
-
-	/* remap ebu register range */
-	ltq_ebu_membase = ioremap_nocache(ltq_ebu_resource.start,
-				resource_size(&ltq_ebu_resource));
-	if (!ltq_ebu_membase)
-		panic("Failed to remap ebu memory");
-
-	/* make sure to unprotect the memory region where flash is located */
-	ltq_ebu_w32(ltq_ebu_r32(LTQ_EBU_BUSCON0) & ~EBU_WRDIS, LTQ_EBU_BUSCON0);
-	return 0;
-}
-
-postcore_initcall(lantiq_ebu_init);
diff --git a/arch/mips/lantiq/xway/pmu.c b/arch/mips/lantiq/xway/pmu.c
deleted file mode 100644
index fe85361..0000000
--- a/arch/mips/lantiq/xway/pmu.c
+++ /dev/null
@@ -1,69 +0,0 @@
-/*
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- *
- *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/ioport.h>
-
-#include <lantiq_soc.h>
-
-/* PMU - the power management unit allows us to turn part of the core
- * on and off
- */
-
-/* the enable / disable registers */
-#define LTQ_PMU_PWDCR	0x1C
-#define LTQ_PMU_PWDSR	0x20
-
-#define ltq_pmu_w32(x, y)	ltq_w32((x), ltq_pmu_membase + (y))
-#define ltq_pmu_r32(x)		ltq_r32(ltq_pmu_membase + (x))
-
-static struct resource ltq_pmu_resource = {
-	.name	= "pmu",
-	.start	= LTQ_PMU_BASE_ADDR,
-	.end	= LTQ_PMU_BASE_ADDR + LTQ_PMU_SIZE - 1,
-	.flags	= IORESOURCE_MEM,
-};
-
-static void __iomem *ltq_pmu_membase;
-
-void ltq_pmu_enable(unsigned int module)
-{
-	int err = 1000000;
-
-	ltq_pmu_w32(ltq_pmu_r32(LTQ_PMU_PWDCR) & ~module, LTQ_PMU_PWDCR);
-	do {} while (--err && (ltq_pmu_r32(LTQ_PMU_PWDSR) & module));
-
-	if (!err)
-		panic("activating PMU module failed!");
-}
-EXPORT_SYMBOL(ltq_pmu_enable);
-
-void ltq_pmu_disable(unsigned int module)
-{
-	ltq_pmu_w32(ltq_pmu_r32(LTQ_PMU_PWDCR) | module, LTQ_PMU_PWDCR);
-}
-EXPORT_SYMBOL(ltq_pmu_disable);
-
-int __init ltq_pmu_init(void)
-{
-	if (insert_resource(&iomem_resource, &ltq_pmu_resource) < 0)
-		panic("Failed to insert pmu memory");
-
-	if (request_mem_region(ltq_pmu_resource.start,
-			resource_size(&ltq_pmu_resource), "pmu") < 0)
-		panic("Failed to request pmu memory");
-
-	ltq_pmu_membase = ioremap_nocache(ltq_pmu_resource.start,
-				resource_size(&ltq_pmu_resource));
-	if (!ltq_pmu_membase)
-		panic("Failed to remap pmu memory");
-	return 0;
-}
-
-core_initcall(ltq_pmu_init);
diff --git a/arch/mips/lantiq/xway/prom-ase.c b/arch/mips/lantiq/xway/prom-ase.c
index ae4959a..3f86a3b 100644
--- a/arch/mips/lantiq/xway/prom-ase.c
+++ b/arch/mips/lantiq/xway/prom-ase.c
@@ -13,6 +13,7 @@
 
 #include <lantiq_soc.h>
 
+#include "devices.h"
 #include "../prom.h"
 
 #define SOC_AMAZON_SE	"Amazon_SE"
@@ -26,6 +27,7 @@ void __init ltq_soc_detect(struct ltq_soc_info *i)
 {
 	i->partnum = (ltq_r32(LTQ_MPS_CHIPID) & PART_MASK) >> PART_SHIFT;
 	i->rev = (ltq_r32(LTQ_MPS_CHIPID) & REV_MASK) >> REV_SHIFT;
+	sprintf(i->rev_type, "1.%d", i->rev);
 	switch (i->partnum) {
 	case SOC_ID_AMAZON_SE:
 		i->name = SOC_AMAZON_SE;
@@ -37,3 +39,10 @@ void __init ltq_soc_detect(struct ltq_soc_info *i)
 		break;
 	}
 }
+
+void __init ltq_soc_setup(void)
+{
+	ltq_register_ase_asc();
+	ltq_register_gpio();
+	ltq_register_wdt();
+}
diff --git a/arch/mips/lantiq/xway/prom-xway.c b/arch/mips/lantiq/xway/prom-xway.c
index 2228133..d823a92 100644
--- a/arch/mips/lantiq/xway/prom-xway.c
+++ b/arch/mips/lantiq/xway/prom-xway.c
@@ -13,6 +13,7 @@
 
 #include <lantiq_soc.h>
 
+#include "devices.h"
 #include "../prom.h"
 
 #define SOC_DANUBE	"Danube"
@@ -28,6 +29,7 @@ void __init ltq_soc_detect(struct ltq_soc_info *i)
 {
 	i->partnum = (ltq_r32(LTQ_MPS_CHIPID) & PART_MASK) >> PART_SHIFT;
 	i->rev = (ltq_r32(LTQ_MPS_CHIPID) & REV_MASK) >> REV_SHIFT;
+	sprintf(i->rev_type, "1.%d", i->rev);
 	switch (i->partnum) {
 	case SOC_ID_DANUBE1:
 	case SOC_ID_DANUBE2:
@@ -52,3 +54,11 @@ void __init ltq_soc_detect(struct ltq_soc_info *i)
 		break;
 	}
 }
+
+void __init ltq_soc_setup(void)
+{
+	ltq_register_asc(0);
+	ltq_register_asc(1);
+	ltq_register_gpio();
+	ltq_register_wdt();
+}
diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
index 8b66bd8..c705bbf 100644
--- a/arch/mips/lantiq/xway/reset.c
+++ b/arch/mips/lantiq/xway/reset.c
@@ -15,6 +15,8 @@
 
 #include <lantiq_soc.h>
 
+#include "../devices.h"
+
 #define ltq_rcu_w32(x, y)	ltq_w32((x), ltq_rcu_membase + (y))
 #define ltq_rcu_r32(x)		ltq_r32(ltq_rcu_membase + (x))
 
@@ -25,12 +27,8 @@
 #define LTQ_RCU_RST_STAT	0x0014
 #define LTQ_RCU_STAT_SHIFT	26
 
-static struct resource ltq_rcu_resource = {
-	.name   = "rcu",
-	.start  = LTQ_RCU_BASE_ADDR,
-	.end    = LTQ_RCU_BASE_ADDR + LTQ_RCU_SIZE - 1,
-	.flags  = IORESOURCE_MEM,
-};
+static struct resource ltq_rcu_resource =
+	MEM_RES("rcu", LTQ_RCU_BASE_ADDR, LTQ_RCU_SIZE);
 
 /* remapped base addr of the reset control unit */
 static void __iomem *ltq_rcu_membase;
@@ -67,17 +65,8 @@ static void ltq_machine_power_off(void)
 
 static int __init mips_reboot_setup(void)
 {
-	/* insert and request the memory region */
-	if (insert_resource(&iomem_resource, &ltq_rcu_resource) < 0)
-		panic("Failed to insert rcu memory");
-
-	if (request_mem_region(ltq_rcu_resource.start,
-			resource_size(&ltq_rcu_resource), "rcu") < 0)
-		panic("Failed to request rcu memory");
-
 	/* remap rcu register range */
-	ltq_rcu_membase = ioremap_nocache(ltq_rcu_resource.start,
-				resource_size(&ltq_rcu_resource));
+	ltq_rcu_membase = ltq_remap_resource(&ltq_rcu_resource);
 	if (!ltq_rcu_membase)
 		panic("Failed to remap rcu memory");
 
diff --git a/arch/mips/lantiq/xway/setup-ase.c b/arch/mips/lantiq/xway/setup-ase.c
deleted file mode 100644
index f6f3267..0000000
--- a/arch/mips/lantiq/xway/setup-ase.c
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- *
- *  Copyright (C) 2011 John Crispin <blogic@openwrt.org>
- */
-
-#include <lantiq_soc.h>
-
-#include "../prom.h"
-#include "devices.h"
-
-void __init ltq_soc_setup(void)
-{
-	ltq_register_ase_asc();
-	ltq_register_gpio();
-	ltq_register_wdt();
-}
diff --git a/arch/mips/lantiq/xway/setup-xway.c b/arch/mips/lantiq/xway/setup-xway.c
deleted file mode 100644
index c292f64..0000000
--- a/arch/mips/lantiq/xway/setup-xway.c
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- *
- *  Copyright (C) 2011 John Crispin <blogic@openwrt.org>
- */
-
-#include <lantiq_soc.h>
-
-#include "../prom.h"
-#include "devices.h"
-
-void __init ltq_soc_setup(void)
-{
-	ltq_register_asc(0);
-	ltq_register_asc(1);
-	ltq_register_gpio();
-	ltq_register_wdt();
-}
diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
new file mode 100644
index 0000000..38c122f
--- /dev/null
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -0,0 +1,78 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2011 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/ioport.h>
+#include <linux/export.h>
+
+#include <lantiq_soc.h>
+
+#include "../devices.h"
+
+/* clock control register */
+#define LTQ_CGU_IFCCR	0x0018
+
+/* the enable / disable registers */
+#define LTQ_PMU_PWDCR	0x1C
+#define LTQ_PMU_PWDSR	0x20
+
+#define ltq_pmu_w32(x, y)	ltq_w32((x), ltq_pmu_membase + (y))
+#define ltq_pmu_r32(x)		ltq_r32(ltq_pmu_membase + (x))
+
+static struct resource ltq_cgu_resource =
+	MEM_RES("cgu", LTQ_CGU_BASE_ADDR, LTQ_CGU_SIZE);
+
+static struct resource ltq_pmu_resource =
+	MEM_RES("pmu", LTQ_PMU_BASE_ADDR, LTQ_PMU_SIZE);
+
+static struct resource ltq_ebu_resource =
+	MEM_RES("ebu", LTQ_EBU_BASE_ADDR, LTQ_EBU_SIZE);
+
+void __iomem *ltq_cgu_membase;
+void __iomem *ltq_ebu_membase;
+static void __iomem *ltq_pmu_membase;
+
+void ltq_cgu_enable(unsigned int clk)
+{
+	ltq_cgu_w32(ltq_cgu_r32(LTQ_CGU_IFCCR) | clk, LTQ_CGU_IFCCR);
+}
+
+void ltq_pmu_enable(unsigned int module)
+{
+	int err = 1000000;
+
+	ltq_pmu_w32(ltq_pmu_r32(LTQ_PMU_PWDCR) & ~module, LTQ_PMU_PWDCR);
+	do {} while (--err && (ltq_pmu_r32(LTQ_PMU_PWDSR) & module));
+
+	if (!err)
+		panic("activating PMU module failed!");
+}
+EXPORT_SYMBOL(ltq_pmu_enable);
+
+void ltq_pmu_disable(unsigned int module)
+{
+	ltq_pmu_w32(ltq_pmu_r32(LTQ_PMU_PWDCR) | module, LTQ_PMU_PWDCR);
+}
+EXPORT_SYMBOL(ltq_pmu_disable);
+
+void __init ltq_soc_init(void)
+{
+	ltq_pmu_membase = ltq_remap_resource(&ltq_pmu_resource);
+	if (!ltq_pmu_membase)
+		panic("Failed to remap pmu memory");
+
+	ltq_cgu_membase = ltq_remap_resource(&ltq_cgu_resource);
+	if (!ltq_cgu_membase)
+		panic("Failed to remap cgu memory");
+
+	ltq_ebu_membase = ltq_remap_resource(&ltq_ebu_resource);
+	if (!ltq_ebu_membase)
+		panic("Failed to remap ebu memory");
+
+	/* make sure to unprotect the memory region where flash is located */
+	ltq_ebu_w32(ltq_ebu_r32(LTQ_EBU_BUSCON0) & ~EBU_WRDIS, LTQ_EBU_BUSCON0);
+}
diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
index 102aed0..179bf98 100644
--- a/drivers/watchdog/lantiq_wdt.c
+++ b/drivers/watchdog/lantiq_wdt.c
@@ -16,7 +16,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <lantiq.h>
+#include <lantiq_soc.h>
 
 /* Section 3.4 of the datasheet
  * The password sequence protects the WDT control register from unintended
-- 
1.7.7.1
