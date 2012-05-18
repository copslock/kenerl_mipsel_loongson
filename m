Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 May 2012 17:44:49 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:60847 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903715Ab2ERPoi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 May 2012 17:44:38 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V3 17/17] MIPS: lantiq: remove orphaned code
Date:   Fri, 18 May 2012 17:44:27 +0200
Message-Id: <1337355867-1803-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
X-archive-position: 33366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Now that all drivers are converted to OF we are able to remove some remaining
pieces of orphaned code.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/mach-lantiq/lantiq.h         |    5 -
 .../mips/include/asm/mach-lantiq/lantiq_platform.h |   33 -------
 .../mips/include/asm/mach-lantiq/xway/lantiq_irq.h |   44 +---------
 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |   90 +-------------------
 arch/mips/lantiq/prom.c                            |    6 --
 arch/mips/lantiq/xway/sysctrl.c                    |    4 +
 6 files changed, 7 insertions(+), 175 deletions(-)

diff --git a/arch/mips/include/asm/mach-lantiq/lantiq.h b/arch/mips/include/asm/mach-lantiq/lantiq.h
index 64fbc3f..5e8a6e9 100644
--- a/arch/mips/include/asm/mach-lantiq/lantiq.h
+++ b/arch/mips/include/asm/mach-lantiq/lantiq.h
@@ -27,9 +27,6 @@
 	ltq_w32_mask(x, y, ltq_ebu_membase + (z))
 extern __iomem void *ltq_ebu_membase;
 
-extern unsigned int ltq_get_cpu_ver(void);
-extern unsigned int ltq_get_soc_type(void);
-
 /* spinlock all ebu i/o */
 extern spinlock_t ebu_lock;
 
@@ -54,7 +51,5 @@ extern int ltq_reset_cause(void);
 #define IOPORT_RESOURCE_END	0xffffffff
 #define IOMEM_RESOURCE_START	0x10000000
 #define IOMEM_RESOURCE_END	0xffffffff
-#define LTQ_FLASH_START		0x10000000
-#define LTQ_FLASH_MAX		0x04000000
 
 #endif
diff --git a/arch/mips/include/asm/mach-lantiq/lantiq_platform.h b/arch/mips/include/asm/mach-lantiq/lantiq_platform.h
index a305f1d..e23bf7c 100644
--- a/arch/mips/include/asm/mach-lantiq/lantiq_platform.h
+++ b/arch/mips/include/asm/mach-lantiq/lantiq_platform.h
@@ -9,41 +9,8 @@
 #ifndef _LANTIQ_PLATFORM_H__
 #define _LANTIQ_PLATFORM_H__
 
-#include <linux/mtd/partitions.h>
 #include <linux/socket.h>
 
-/* struct used to pass info to the pci core */
-enum {
-	PCI_CLOCK_INT = 0,
-	PCI_CLOCK_EXT
-};
-
-#define PCI_EXIN0	0x0001
-#define PCI_EXIN1	0x0002
-#define PCI_EXIN2	0x0004
-#define PCI_EXIN3	0x0008
-#define PCI_EXIN4	0x0010
-#define PCI_EXIN5	0x0020
-#define PCI_EXIN_MAX	6
-
-#define PCI_GNT1	0x0040
-#define PCI_GNT2	0x0080
-#define PCI_GNT3	0x0100
-#define PCI_GNT4	0x0200
-
-#define PCI_REQ1	0x0400
-#define PCI_REQ2	0x0800
-#define PCI_REQ3	0x1000
-#define PCI_REQ4	0x2000
-#define PCI_REQ_SHIFT	10
-#define PCI_REQ_MASK	0xf
-
-struct ltq_pci_data {
-	int clock;
-	int gpio;
-	int irq[16];
-};
-
 /* struct used to pass info to network drivers */
 struct ltq_eth_data {
 	struct sockaddr mac;
diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h
index b4465a8..aa0b3b8 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h
@@ -17,50 +17,8 @@
 #define INT_NUM_IM4_IRL0	(INT_NUM_IRQ0 + 128)
 #define INT_NUM_IM_OFFSET	(INT_NUM_IM1_IRL0 - INT_NUM_IM0_IRL0)
 
-#define LTQ_ASC_TIR(x)		(INT_NUM_IM3_IRL0 + (x * 8))
-#define LTQ_ASC_RIR(x)		(INT_NUM_IM3_IRL0 + (x * 8) + 1)
-#define LTQ_ASC_EIR(x)		(INT_NUM_IM3_IRL0 + (x * 8) + 2)
-
-#define LTQ_ASC_ASE_TIR		INT_NUM_IM2_IRL0
-#define LTQ_ASC_ASE_RIR		(INT_NUM_IM2_IRL0 + 2)
-#define LTQ_ASC_ASE_EIR		(INT_NUM_IM2_IRL0 + 3)
-
-#define LTQ_SSC_TIR		(INT_NUM_IM0_IRL0 + 15)
-#define LTQ_SSC_RIR		(INT_NUM_IM0_IRL0 + 14)
-#define LTQ_SSC_EIR		(INT_NUM_IM0_IRL0 + 16)
-
-#define LTQ_MEI_DYING_GASP_INT	(INT_NUM_IM1_IRL0 + 21)
-#define LTQ_MEI_INT		(INT_NUM_IM1_IRL0 + 23)
-
-#define LTQ_TIMER6_INT		(INT_NUM_IM1_IRL0 + 23)
-#define LTQ_USB_INT		(INT_NUM_IM1_IRL0 + 22)
-#define LTQ_USB_OC_INT		(INT_NUM_IM4_IRL0 + 23)
-
-#define MIPS_CPU_TIMER_IRQ		7
-
 #define LTQ_DMA_CH0_INT		(INT_NUM_IM2_IRL0)
-#define LTQ_DMA_CH1_INT		(INT_NUM_IM2_IRL0 + 1)
-#define LTQ_DMA_CH2_INT		(INT_NUM_IM2_IRL0 + 2)
-#define LTQ_DMA_CH3_INT		(INT_NUM_IM2_IRL0 + 3)
-#define LTQ_DMA_CH4_INT		(INT_NUM_IM2_IRL0 + 4)
-#define LTQ_DMA_CH5_INT		(INT_NUM_IM2_IRL0 + 5)
-#define LTQ_DMA_CH6_INT		(INT_NUM_IM2_IRL0 + 6)
-#define LTQ_DMA_CH7_INT		(INT_NUM_IM2_IRL0 + 7)
-#define LTQ_DMA_CH8_INT		(INT_NUM_IM2_IRL0 + 8)
-#define LTQ_DMA_CH9_INT		(INT_NUM_IM2_IRL0 + 9)
-#define LTQ_DMA_CH10_INT	(INT_NUM_IM2_IRL0 + 10)
-#define LTQ_DMA_CH11_INT	(INT_NUM_IM2_IRL0 + 11)
-#define LTQ_DMA_CH12_INT	(INT_NUM_IM2_IRL0 + 25)
-#define LTQ_DMA_CH13_INT	(INT_NUM_IM2_IRL0 + 26)
-#define LTQ_DMA_CH14_INT	(INT_NUM_IM2_IRL0 + 27)
-#define LTQ_DMA_CH15_INT	(INT_NUM_IM2_IRL0 + 28)
-#define LTQ_DMA_CH16_INT	(INT_NUM_IM2_IRL0 + 29)
-#define LTQ_DMA_CH17_INT	(INT_NUM_IM2_IRL0 + 30)
-#define LTQ_DMA_CH18_INT	(INT_NUM_IM2_IRL0 + 16)
-#define LTQ_DMA_CH19_INT	(INT_NUM_IM2_IRL0 + 21)
-
-#define LTQ_PPE_MBOX_INT	(INT_NUM_IM2_IRL0 + 24)
 
-#define INT_NUM_IM4_IRL14	(INT_NUM_IM4_IRL0 + 14)
+#define MIPS_CPU_TIMER_IRQ	7
 
 #endif
diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
index d0d40a4..6a2df70 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
@@ -44,11 +44,6 @@
 #define SOC_TYPE_VR9_2		0x05 /* v1.2 */
 #define SOC_TYPE_AMAZON_SE	0x06
 
-/* ASC0/1 - serial port */
-#define LTQ_ASC0_BASE_ADDR	0x1E100400
-#define LTQ_ASC1_BASE_ADDR	0x1E100C00
-#define LTQ_ASC_SIZE		0x400
-
 /* BOOT_SEL - find what boot media we have */
 #define BS_EXT_ROM		0x0
 #define BS_FLASH		0x1
@@ -68,23 +63,10 @@ extern __iomem void *ltq_cgu_membase;
  * during early_printk no ioremap is possible
  * lets use KSEG1 instead
  */
+#define LTQ_ASC1_BASE_ADDR	0x1E100C00
 #define LTQ_EARLY_ASC		KSEG1ADDR(LTQ_ASC1_BASE_ADDR)
 
-/* RCU - reset control unit */
-#define LTQ_RCU_BASE_ADDR	0x1F203000
-#define LTQ_RCU_SIZE		0x1000
-
-/* GPTU - general purpose timer unit */
-#define LTQ_GPTU_BASE_ADDR	0x18000300
-#define LTQ_GPTU_SIZE		0x100
-
 /* EBU - external bus unit */
-#define LTQ_EBU_GPIO_START	0x14000000
-#define LTQ_EBU_GPIO_SIZE	0x1000
-
-#define LTQ_EBU_BASE_ADDR	0x1E105300
-#define LTQ_EBU_SIZE		0x100
-
 #define LTQ_EBU_BUSCON0		0x0060
 #define LTQ_EBU_PCC_CON		0x0090
 #define LTQ_EBU_PCC_IEN		0x00A4
@@ -93,85 +75,17 @@ extern __iomem void *ltq_cgu_membase;
 #define LTQ_EBU_ADDRSEL1	0x0024
 #define EBU_WRDIS		0x80000000
 
-/* CGU - clock generation unit */
-#define LTQ_CGU_BASE_ADDR	0x1F103000
-#define LTQ_CGU_SIZE		0x1000
-
-/* ICU - interrupt control unit */
-#define LTQ_ICU_BASE_ADDR	0x1F880200
-#define LTQ_ICU_SIZE		0x100
-
-/* EIU - external interrupt unit */
-#define LTQ_EIU_BASE_ADDR	0x1F101000
-#define LTQ_EIU_SIZE		0x1000
-
-/* PMU - power management unit */
-#define LTQ_PMU_BASE_ADDR	0x1F102000
-#define LTQ_PMU_SIZE		0x1000
-
-#define PMU_DMA			0x0020
-#define PMU_USB			0x8041
-#define PMU_LED			0x0800
-#define PMU_GPT			0x1000
-#define PMU_PPE			0x2000
-#define PMU_FPI			0x4000
-#define PMU_SWITCH		0x10000000
-
-/* ETOP - ethernet */
-#define LTQ_ETOP_BASE_ADDR	0x1E180000
-#define LTQ_ETOP_SIZE		0x40000
-
-/* DMA */
-#define LTQ_DMA_BASE_ADDR	0x1E104100
-#define LTQ_DMA_SIZE		0x800
-
-/* PCI */
-#define PCI_CR_BASE_ADDR	0x1E105400
-#define PCI_CR_SIZE		0x400
-
 /* WDT */
-#define LTQ_WDT_BASE_ADDR	0x1F8803F0
-#define LTQ_WDT_SIZE		0x10
-
 #define LTQ_RST_CAUSE_WDTRST	0x20
 
-/* STP - serial to parallel conversion unit */
-#define LTQ_STP_BASE_ADDR	0x1E100BB0
-#define LTQ_STP_SIZE		0x40
-
-/* GPIO */
-#define LTQ_GPIO0_BASE_ADDR	0x1E100B10
-#define LTQ_GPIO1_BASE_ADDR	0x1E100B40
-#define LTQ_GPIO2_BASE_ADDR	0x1E100B70
-#define LTQ_GPIO_SIZE		0x30
-
-/* SSC */
-#define LTQ_SSC_BASE_ADDR	0x1e100800
-#define LTQ_SSC_SIZE		0x100
-
-/* MEI - dsl core */
-#define LTQ_MEI_BASE_ADDR	0x1E116000
-
-/* DEU - data encryption unit */
-#define LTQ_DEU_BASE_ADDR	0x1E103100
-
 /* MPS - multi processor unit (voice) */
 #define LTQ_MPS_BASE_ADDR	(KSEG1 + 0x1F107000)
 #define LTQ_MPS_CHIPID		((u32 *)(LTQ_MPS_BASE_ADDR + 0x0344))
 
 /* request a non-gpio and set the PIO config */
+#define PMU_PPE			 BIT(13)
 extern void ltq_pmu_enable(unsigned int module);
 extern void ltq_pmu_disable(unsigned int module);
 
-static inline int ltq_is_ar9(void)
-{
-	return (ltq_get_soc_type() == SOC_TYPE_AR9);
-}
-
-static inline int ltq_is_vr9(void)
-{
-	return (ltq_get_soc_type() == SOC_TYPE_VR9);
-}
-
 #endif /* CONFIG_SOC_TYPE_XWAY */
 #endif /* _LTQ_XWAY_H__ */
diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 413ed53..d185e84 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -27,12 +27,6 @@ EXPORT_SYMBOL_GPL(ebu_lock);
  */
 static struct ltq_soc_info soc_info;
 
-unsigned int ltq_get_soc_type(void)
-{
-	return soc_info.type;
-}
-EXPORT_SYMBOL(ltq_get_soc_type);
-
 const char *get_system_type(void)
 {
 	return soc_info.sys_type;
diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 4d6aac6..83780f7 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -42,6 +42,7 @@
 /* clock gates that we can en/disable */
 #define PMU_USB0_P	BIT(0)
 #define PMU_PCI		BIT(4)
+#define PMU_DMA		BIT(5)
 #define PMU_USB0	BIT(6)
 #define PMU_ASC0	BIT(7)
 #define PMU_EPHY	BIT(7)	/* ase */
@@ -49,7 +50,9 @@
 #define PMU_DFE		BIT(9)
 #define PMU_EBU		BIT(10)
 #define PMU_STP		BIT(11)
+#define PMU_GPT		BIT(12)
 #define PMU_AHBS	BIT(13) /* vr9 */
+#define PMU_FPI		BIT(14)
 #define PMU_AHBM	BIT(15)
 #define PMU_ASC1	BIT(17)
 #define PMU_PPE_QSB	BIT(18)
@@ -60,6 +63,7 @@
 #define PMU_PPE_DPLUS	BIT(24)
 #define PMU_USB1_P	BIT(26)
 #define PMU_USB1	BIT(27)
+#define PMU_SWITCH	BIT(28)
 #define PMU_PPE_TOP	BIT(29)
 #define PMU_GPHY	BIT(30)
 #define PMU_PCIE_CLK	BIT(31)
-- 
1.7.9.1
