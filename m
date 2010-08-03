Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Aug 2010 03:41:35 +0200 (CEST)
Received: from sj-iport-5.cisco.com ([171.68.10.87]:46095 "EHLO
        sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492148Ab0HCBlH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Aug 2010 03:41:07 +0200
Authentication-Results: sj-iport-5.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAB0QV0yrR7Ht/2dsb2JhbACgBnGpIJtnghiDIQSEFg
X-IronPort-AV: E=Sophos;i="4.55,306,1278288000"; 
   d="scan'208";a="234533612"
Received: from sj-core-1.cisco.com ([171.71.177.237])
  by sj-iport-5.cisco.com with ESMTP; 03 Aug 2010 01:40:57 +0000
Received: from dvomlehn-lnx2.corp.sa.net (dhcp-171-71-47-241.cisco.com [171.71.47.241])
        by sj-core-1.cisco.com (8.13.8/8.14.3) with ESMTP id o731evl9024822;
        Tue, 3 Aug 2010 01:40:57 GMT
Date:   Mon, 2 Aug 2010 18:40:58 -0700
From:   David VomLehn <dvomlehn@cisco.com>
To:     linux-mips@linux-mips.org
Cc:     greg@kroah.com, linux-usb@vger.kernel.org, ralf@linux-mips.org
Subject: [PATCH 2/2][MIPS] USB/PowerTV: Separate PowerTV USB support from
        non-USB code
Message-ID: <20100803014058.GA31552@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

Separate USB code into a file separate from asic/asic_devices.

Separating the USB code from everything else in asic/asic_devices.c goes
a long way toward reducing the use of that file as a dumping ground for
everything that didn't seem to fit anywhere else.

Signed-off-by: David VomLehn <dvomlehn@cisco.com>
---
 arch/mips/include/asm/mach-powertv/asic.h      |   17 +-
 arch/mips/include/asm/mach-powertv/asic_regs.h |    1 +
 arch/mips/powertv/Makefile                     |    2 +
 arch/mips/powertv/asic/asic_devices.c          |  238 +-------------
 arch/mips/powertv/powertv-usb.c                |  403 ++++++++++++++++++++++++
 5 files changed, 432 insertions(+), 229 deletions(-)

diff --git a/arch/mips/include/asm/mach-powertv/asic.h b/arch/mips/include/asm/mach-powertv/asic.h
index df33d93..c7077a6 100644
--- a/arch/mips/include/asm/mach-powertv/asic.h
+++ b/arch/mips/include/asm/mach-powertv/asic.h
@@ -20,6 +20,7 @@
 #define _ASM_MACH_POWERTV_ASIC_H
 
 #include <linux/ioport.h>
+#include <linux/platform_device.h>
 #include <asm/mach-powertv/asic_regs.h>
 
 #define DVR_CAPABLE     (1<<0)
@@ -71,16 +72,24 @@ extern int platform_supports_ffs(void);
 extern int platform_supports_pcie(void);
 extern int platform_supports_display(void);
 extern void configure_platform(void);
-extern void platform_configure_usb_ehci(void);
-extern void platform_unconfigure_usb_ehci(void);
-extern void platform_configure_usb_ohci(void);
-extern void platform_unconfigure_usb_ohci(void);
 
 /* Platform Resources */
 #define ASIC_RESOURCE_GET_EXISTS 1
 extern struct resource *asic_resource_get(const char *name);
 extern void platform_release_memory(void *baddr, int size);
 
+/* USB configuration */
+struct usb_hcd;			/* Forward reference */
+extern void platform_configure_usb_ehci(void);
+extern void platform_unconfigure_usb_ehci(void);
+extern void platform_configure_usb_ohci(void);
+extern void platform_unconfigure_usb_ohci(void);
+
+/* Resource for ASIC registers */
+extern struct resource asic_resource;
+extern int platform_usb_devices_init(struct platform_device **echi_dev,
+	struct platform_device **ohci_dev);
+
 /* Reboot Cause */
 extern void set_reboot_cause(char code, unsigned int data, unsigned int data2);
 extern void set_locked_reboot_cause(char code, unsigned int data,
diff --git a/arch/mips/include/asm/mach-powertv/asic_regs.h b/arch/mips/include/asm/mach-powertv/asic_regs.h
index 2657ae6..deecb26 100644
--- a/arch/mips/include/asm/mach-powertv/asic_regs.h
+++ b/arch/mips/include/asm/mach-powertv/asic_regs.h
@@ -101,6 +101,7 @@ static inline void register_map_virtualize(struct register_map *map)
 }
 
 extern struct register_map _asic_register_map;
+extern unsigned long asic_phy_base;
 
 /*
  * Macros to interface to registers through their ioremapped address
diff --git a/arch/mips/powertv/Makefile b/arch/mips/powertv/Makefile
index e9fe1c6..c914c2b 100644
--- a/arch/mips/powertv/Makefile
+++ b/arch/mips/powertv/Makefile
@@ -26,4 +26,6 @@
 obj-y += init.o ioremap.o memory.o powertv_setup.o reset.o time.o \
 	asic/ pci/
 
+obj-$(CONFIG_USB) += powertv-usb.o
+
 EXTRA_CFLAGS += -Wall -Werror
diff --git a/arch/mips/powertv/asic/asic_devices.c b/arch/mips/powertv/asic/asic_devices.c
index 095a887..e56fa61 100644
--- a/arch/mips/powertv/asic/asic_devices.c
+++ b/arch/mips/powertv/asic/asic_devices.c
@@ -33,7 +33,6 @@
 #include <linux/mm.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
-#include <linux/gfp.h>
 #include <asm/page.h>
 #include <linux/swap.h>
 #include <linux/highmem.h>
@@ -68,7 +67,6 @@ unsigned long asic_phy_base;
 unsigned long asic_base;
 EXPORT_SYMBOL(asic_base);			/* Exported for testing */
 struct resource *gp_resources;
-static bool usb_configured;
 
 /*
  * Don't recommend to use it directly, it is usually used by kernel internally.
@@ -91,101 +89,19 @@ struct resource asic_resource = {
 };
 
 /*
- *
- * USB Host Resource Definition
- *
- */
-
-static struct resource ehci_resources[] = {
-	{
-		.parent = &asic_resource,
-		.start  = 0,
-		.end    = 0xff,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.start  = irq_usbehci,
-		.end    = irq_usbehci,
-		.flags  = IORESOURCE_IRQ,
-	},
-};
-
-static u64 ehci_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device ehci_device = {
-	.name = "powertv-ehci",
-	.id = 0,
-	.num_resources = 2,
-	.resource = ehci_resources,
-	.dev = {
-		.dma_mask = &ehci_dmamask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-	},
-};
-
-static struct resource ohci_resources[] = {
-	{
-		.parent = &asic_resource,
-		.start  = 0,
-		.end    = 0xff,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.start  = irq_usbohci,
-		.end    = irq_usbohci,
-		.flags  = IORESOURCE_IRQ,
-	},
-};
-
-static u64 ohci_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device ohci_device = {
-	.name = "powertv-ohci",
-	.id = 0,
-	.num_resources = 2,
-	.resource = ohci_resources,
-	.dev = {
-		.dma_mask = &ohci_dmamask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-	},
-};
-
-static struct platform_device *platform_devices[] = {
-	&ehci_device,
-	&ohci_device,
-};
-
-/*
- *
- * Platform Configuration and Device Initialization
- *
- */
-static void __init fs_update(int pe, int md, int sdiv, int disable_div_by_3)
-{
-	int en_prg, byp, pwr, nsb, val;
-	int sout;
-
-	sout = 1;
-	en_prg = 1;
-	byp = 0;
-	nsb = 1;
-	pwr = 1;
-
-	val = ((sdiv << 29) | (md << 24) | (pe<<8) | (sout<<3) | (byp<<2) |
-		(nsb<<1) | (disable_div_by_3<<5));
-
-	asic_write(val, fs432x4b4_usb_ctl);
-	asic_write(val | (en_prg<<4), fs432x4b4_usb_ctl);
-	asic_write(val | (en_prg<<4) | pwr, fs432x4b4_usb_ctl);
-}
-
-/*
  * Allow override of bootloader-specified model
+ * Returns zero on success, a negative errno value on failure.  This parameter
+ * allows overriding of the bootloader-specified model.
  */
 static char __initdata cmdline[COMMAND_LINE_SIZE];
 
 #define	FORCEFAMILY_PARAM	"forcefamily"
 
+/*
+ * check_forcefamily - check for, and parse, forcefamily command line parameter
+ * @forced_family:	Pointer to two-character array in which to store the
+ *			value of the forcedfamily parameter, if any.
+ */
 static __init int check_forcefamily(unsigned char forced_family[2])
 {
 	const char *p;
@@ -225,14 +141,10 @@ static __init int check_forcefamily(unsigned char forced_family[2])
  */
 static __init noinline void platform_set_family(void)
 {
-#define BOOTLDRFAMILY(byte1, byte0) (((byte1) << 8) | (byte0))
-
 	unsigned char forced_family[2];
 	unsigned short bootldr_family;
 
-	check_forcefamily(forced_family);
-
-	if (forced_family[0] != '\0' && forced_family[1] != '\0')
+	if (check_forcefamily(forced_family) == 0)
 		bootldr_family = BOOTLDRFAMILY(forced_family[0],
 			forced_family[1]);
 	else {
@@ -298,24 +210,9 @@ unsigned int platform_get_family(void)
 EXPORT_SYMBOL(platform_get_family);
 
 /*
- * \brief usb_eye_configure() for optimizing the USB eye on Calliope.
- *
- * \param     unsigned int value saved to the register.
- *
- * \return    none
- *
- */
-static void __init usb_eye_configure(unsigned int value)
-{
-	asic_write(asic_read(crt_spare) | value, crt_spare);
-}
-
-/*
  * platform_get_asic - determine the ASIC type.
  *
- * \param     none
- *
- * \return    ASIC type; ASIC_UNKNOWN if none
+ * Returns the ASIC type, or ASIC_UNKNOWN if unknown
  *
  */
 enum asic_type platform_get_asic(void)
@@ -325,93 +222,10 @@ enum asic_type platform_get_asic(void)
 EXPORT_SYMBOL(platform_get_asic);
 
 /*
- * platform_configure_usb - usb configuration based on platform type.
- * @bcm1_usb2_ctl:	value for the BCM1_USB2_CTL register, which is
- *			quirky
- */
-static void __init platform_configure_usb(void)
-{
-	u32 bcm1_usb2_ctl;
-
-	if (usb_configured)
-		return;
-
-	switch (asic) {
-	case ASIC_ZEUS:
-	case ASIC_CRONUS:
-	case ASIC_CRONUSLITE:
-		fs_update(0x0000, 0x11, 0x02, 0);
-		bcm1_usb2_ctl = 0x803;
-		break;
-
-	case ASIC_CALLIOPE:
-		fs_update(0x0000, 0x11, 0x02, 1);
-
-		switch (platform_family) {
-		case FAMILY_1500VZE:
-			break;
-
-		case FAMILY_1500VZF:
-			usb_eye_configure(0x003c0000);
-			break;
-
-		default:
-			usb_eye_configure(0x00300000);
-			break;
-		}
-
-		bcm1_usb2_ctl = 0x803;
-		break;
-
-	default:
-		pr_err("Unknown ASIC type: %d\n", asic);
-		break;
-	}
-
-	/* turn on USB power */
-	asic_write(0, usb2_strap);
-	/* Enable all OHCI interrupts */
-	asic_write(bcm1_usb2_ctl, usb2_control);
-	/* USB2_STBUS_OBC store32/load32 */
-	asic_write(3, usb2_stbus_obc);
-	/* USB2_STBUS_MESS_SIZE 2 packets */
-	asic_write(1, usb2_stbus_mess_size);
-	/* USB2_STBUS_CHUNK_SIZE 2 packets */
-	asic_write(1, usb2_stbus_chunk_size);
-
-	usb_configured = true;
-}
-
-/*
- * Set up the USB EHCI interface
- */
-void platform_configure_usb_ehci()
-{
-	platform_configure_usb();
-}
-
-/*
- * Set up the USB OHCI interface
- */
-void platform_configure_usb_ohci()
-{
-	platform_configure_usb();
-}
-
-/*
- * Shut the USB EHCI interface down--currently a NOP
+ * set_register_map - set ASIC register configuration
+ * @phys_base:	Physical address of the base of the ASIC registers
+ * @map:	Description of key ASIC registers
  */
-void platform_unconfigure_usb_ehci()
-{
-}
-
-/*
- * Shut the USB OHCI interface down--currently a NOP
- */
-void platform_unconfigure_usb_ohci()
-{
-}
-
 static void __init set_register_map(unsigned long phys_base,
 	const struct register_map *map)
 {
@@ -560,34 +374,8 @@ void __init configure_platform(void)
 	}
 }
 
-/**
- * platform_devices_init - sets up USB device resourse.
- */
-static int __init platform_devices_init(void)
-{
-	pr_notice("%s: ----- Initializing USB resources -----\n", __func__);
-
-	asic_resource.start = asic_phy_base;
-	asic_resource.end += asic_resource.start;
-
-	ehci_resources[0].start = asic_reg_phys_addr(ehci_hcapbase);
-	ehci_resources[0].end += ehci_resources[0].start;
-
-	ohci_resources[0].start = asic_reg_phys_addr(ohci_hc_revision);
-	ohci_resources[0].end += ohci_resources[0].start;
-
-	set_io_port_base(0);
-
-	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
-
-	return 0;
-}
-
-arch_initcall(platform_devices_init);
-
 /*
- *
- * BOOTMEM ALLOCATION
+ * RESOURCE ALLOCATION
  *
  */
 /*
diff --git a/arch/mips/powertv/powertv-usb.c b/arch/mips/powertv/powertv-usb.c
new file mode 100644
index 0000000..6ac85cf
--- /dev/null
+++ b/arch/mips/powertv/powertv-usb.c
@@ -0,0 +1,403 @@
+/*
+ *				powertv-usb.c
+ *
+ * Description:  ASIC-specific USB device setup and shutdown
+ *
+ * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
+ * Copyright (C) 2009 Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ * Author:       Ken Eppinett
+ *               David Schleef <ds@schleef.org>
+ *
+ * NOTE: The bootloader allocates persistent memory at an address which is
+ * 16 MiB below the end of the highest address in KSEG0. All fixed
+ * address memory reservations must avoid this region.
+ */
+
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/platform_device.h>
+#include <asm/mach-powertv/asic.h>
+#include <asm/mach-powertv/interrupts.h>
+
+/* misc_clk_ctl1 values */
+#define MCC1_30MHZ_POWERUP_SELECT	(1 << 14)
+#define MCC1_DIV9			(1 << 13)
+#define MCC1_ETHMIPS_POWERUP_SELECT	(1 << 11)
+#define MCC1_USB_POWERUP_SELECT		(1 << 1)
+#define MCC1_CLOCK108_POWERUP_SELECT	(1 << 0)
+
+/* Possible values for clock select */
+#define MCC1_USB_CLOCK_HIGH_Z		(0 << 4)
+#define MCC1_USB_CLOCK_48MHZ		(1 << 4)
+#define MCC1_USB_CLOCK_24MHZ		(2 << 4)
+#define MCC1_USB_CLOCK_6MHZ		(3 << 4)
+
+#define MCC1_CONFIG	(MCC1_30MHZ_POWERUP_SELECT |		\
+			 MCC1_DIV9 |				\
+			 MCC1_ETHMIPS_POWERUP_SELECT |		\
+			 MCC1_USB_POWERUP_SELECT |		\
+			 MCC1_CLOCK108_POWERUP_SELECT)
+
+/* misc_clk_ctl2 values */
+#define MCC2_GMII_GCLK_TO_PAD		(1 << 31)
+#define MCC2_ETHER125_0_CLOCK_SELECT	(1 << 29)
+#define MCC2_RMII_0_CLOCK_SELECT	(1 << 28)
+#define MCC2_GMII_TX0_CLOCK_SELECT	(1 << 27)
+#define MCC2_GMII_RX0_CLOCK_SELECT	(1 << 26)
+#define MCC2_ETHER125_1_CLOCK_SELECT	(1 << 24)
+#define MCC2_RMII_1_CLOCK_SELECT	(1 << 23)
+#define MCC2_GMII_TX1_CLOCK_SELECT	(1 << 22)
+#define MCC2_GMII_RX1_CLOCK_SELECT	(1 << 21)
+#define MCC2_ETHER125_2_CLOCK_SELECT	(1 << 19)
+#define MCC2_RMII_2_CLOCK_SELECT	(1 << 18)
+#define MCC2_GMII_TX2_CLOCK_SELECT	(1 << 17)
+#define MCC2_GMII_RX2_CLOCK_SELECT	(1 << 16)
+
+#define ETHER_CLK_CONFIG	(MCC2_GMII_GCLK_TO_PAD |	\
+				 MCC2_ETHER125_0_CLOCK_SELECT |	\
+				 MCC2_RMII_0_CLOCK_SELECT |	\
+				 MCC2_GMII_TX0_CLOCK_SELECT |	\
+				 MCC2_GMII_RX0_CLOCK_SELECT |	\
+				 MCC2_ETHER125_1_CLOCK_SELECT |	\
+				 MCC2_RMII_1_CLOCK_SELECT |	\
+				 MCC2_GMII_TX1_CLOCK_SELECT |	\
+				 MCC2_GMII_RX1_CLOCK_SELECT |	\
+				 MCC2_ETHER125_2_CLOCK_SELECT |	\
+				 MCC2_RMII_2_CLOCK_SELECT |	\
+				 MCC2_GMII_TX2_CLOCK_SELECT |	\
+				 MCC2_GMII_RX2_CLOCK_SELECT)
+
+/* misc_clk_ctl2 definitions for Gaia */
+#define FSX4A_REF_SELECT		(1 << 16)
+#define FSX4B_REF_SELECT		(1 << 17)
+#define FSX4C_REF_SELECT		(1 << 18)
+#define DDR_PLL_REF_SELECT		(1 << 19)
+#define MIPS_PLL_REF_SELECT		(1 << 20)
+
+/* Definitions for the QAM frequency select register FS432X4A4_QAM_CTL */
+#define QAM_FS_SDIV_SHIFT		29
+#define QAM_FS_MD_SHIFT			24
+#define QAM_FS_MD_MASK			0x1f	/* Cut down to 5 bits */
+#define QAM_FS_PE_SHIFT			8
+
+#define QAM_FS_DISABLE_DIVIDE_BY_3		(1 << 5)
+#define QAM_FS_ENABLE_PROGRAM			(1 << 4)
+#define	QAM_FS_ENABLE_OUTPUT			(1 << 3)
+#define	QAM_FS_SELECT_TEST_BYPASS		(1 << 2)
+#define	QAM_FS_DISABLE_DIGITAL_STANDBY		(1 << 1)
+#define QAM_FS_CHOOSE_FS			(1 << 0)
+
+/* Definitions for fs432x4a_ctl register */
+#define QAM_FS_NSDIV_54MHZ			(1 << 2)
+
+/* Definitions for bcm1_usb2_ctl register */
+#define BCM1_USB2_CTL_BISTOK				(1 << 11)
+#define BCM1_USB2_CTL_PORT2_SHIFT_JK			(1 << 7)
+#define BCM1_USB2_CTL_PORT1_SHIFT_JK			(1 << 6)
+#define BCM1_USB2_CTL_PORT2_FAST_EDGE			(1 << 5)
+#define BCM1_USB2_CTL_PORT1_FAST_EDGE			(1 << 4)
+#define BCM1_USB2_CTL_EHCI_PRT_PWR_ACTIVE_HIGH		(1 << 1)
+#define BCM1_USB2_CTL_APP_PRT_OVRCUR_IN_ACTIVE_HIGH	(1 << 0)
+
+/* Definitions for crt_spare register */
+#define CRT_SPARE_PORT2_SHIFT_JK			(1 << 21)
+#define CRT_SPARE_PORT1_SHIFT_JK			(1 << 20)
+#define CRT_SPARE_PORT2_FAST_EDGE			(1 << 19)
+#define CRT_SPARE_PORT1_FAST_EDGE			(1 << 18)
+#define CRT_SPARE_DIVIDE_BY_9_FROM_432			(1 << 17)
+#define CRT_SPARE_USB_DIVIDE_BY_9			(1 << 16)
+
+/* Definitions for usb2_stbus_obc register */
+#define USB_STBUS_OBC_STORE32_LOAD32			0x3
+
+/* Definitions for usb2_stbus_mess_size register */
+#define USB2_STBUS_MESS_SIZE_2				0x1	/* 2 packets */
+
+/* Definitions for usb2_stbus_chunk_size register */
+#define USB2_STBUS_CHUNK_SIZE_2				0x1	/* 2 packets */
+
+/* Definitions for usb2_strap register */
+#define USB2_STRAP_HFREQ_SELECT				0x1
+
+/*
+ * USB Host Resource Definition
+ */
+
+static struct resource ehci_resources[] = {
+	{
+		.parent = &asic_resource,
+		.start  = 0,
+		.end    = 0xff,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.start  = irq_usbehci,
+		.end    = irq_usbehci,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static u64 ehci_dmamask = 0xffffffffULL;
+
+static struct platform_device ehci_device = {
+	.name = "powertv-ehci",
+	.id = 0,
+	.num_resources = 2,
+	.resource = ehci_resources,
+	.dev = {
+		.dma_mask = &ehci_dmamask,
+		.coherent_dma_mask = 0xffffffff,
+	},
+};
+
+static struct resource ohci_resources[] = {
+	{
+		.parent = &asic_resource,
+		.start  = 0,
+		.end    = 0xff,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.start  = irq_usbohci,
+		.end    = irq_usbohci,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static u64 ohci_dmamask = 0xffffffffULL;
+
+static struct platform_device ohci_device = {
+	.name = "powertv-ohci",
+	.id = 0,
+	.num_resources = 2,
+	.resource = ohci_resources,
+	.dev = {
+		.dma_mask = &ohci_dmamask,
+		.coherent_dma_mask = 0xffffffff,
+	},
+};
+
+static unsigned usb_users;
+static DEFINE_SPINLOCK(usb_regs_lock);
+
+/*
+ *
+ * fs_update - set frequency synthesizer for USB
+ * @pe_bits		Phase tap setting
+ * @md_bits		Coarse selector bus for algorithm of phase tap
+ * @sdiv_bits		Output divider setting
+ * @disable_div_by_3	Either QAM_FS_DISABLE_DIVIDE_BY_3 or zero
+ * @standby		Either QAM_FS_DISABLE_DIGITAL_STANDBY or zero
+ *
+ * QAM frequency selection code, which affects the frequency at which USB
+ * runs. The frequency is calculated as:
+ *                             2^15 * ndiv * Fin
+ * Fout = ------------------------------------------------------------
+ *        (sdiv * (ipe * (1 + md/32) - (ipe - 2^15)*(1 + (md + 1)/32)))
+ * where:
+ * Fin		54 MHz
+ * ndiv		QAM_FS_NSDIV_54MHZ ? 8 : 16
+ * sdiv		1 << (sdiv_bits + 1)
+ * ipe		Same as pe_bits
+ * md		A five-bit, two's-complement integer (range [-16, 15]), which
+ *		is the lower 5 bits of md_bits.
+ */
+static void fs_update(u32 pe_bits, int md_bits, u32 sdiv_bits,
+	u32 disable_div_by_3, u32 standby)
+{
+	u32 val;
+
+	val = ((sdiv_bits << QAM_FS_SDIV_SHIFT) |
+		((md_bits & QAM_FS_MD_MASK) << QAM_FS_MD_SHIFT) |
+		(pe_bits << QAM_FS_PE_SHIFT) |
+		QAM_FS_ENABLE_OUTPUT |
+		standby |
+		disable_div_by_3);
+	asic_write(val, fs432x4b4_usb_ctl);
+	asic_write(val | QAM_FS_ENABLE_PROGRAM, fs432x4b4_usb_ctl);
+	asic_write(val | QAM_FS_ENABLE_PROGRAM | QAM_FS_CHOOSE_FS,
+		fs432x4b4_usb_ctl);
+}
+
+/*
+ * usb_eye_configure - for optimizing the shape USB eye waveform
+ * @set:	Bits to set in the register
+ * @clear:	Bits to clear in the register; each bit with a one will
+ *		be set in the register, zero bits will not be modified
+ */
+static void usb_eye_configure(u32 set, u32 clear)
+{
+	u32 old;
+
+	old = asic_read(crt_spare);
+	old |= set;
+	old &= ~clear;
+	asic_write(old, crt_spare);
+}
+
+/*
+ * platform_configure_usb - usb configuration based on platform type.
+ */
+static void platform_configure_usb(void)
+{
+	u32 bcm1_usb2_ctl_value;
+	enum asic_type asic_type;
+	unsigned long flags;
+
+	spin_lock_irqsave(&usb_regs_lock, flags);
+	usb_users++;
+
+	if (usb_users != 1) {
+		spin_unlock_irqrestore(&usb_regs_lock, flags);
+		return;
+	}
+
+	asic_type = platform_get_asic();
+
+	switch (asic_type) {
+	case ASIC_ZEUS:
+		fs_update(0x0000, -15, 0x02, 0, 0);
+		bcm1_usb2_ctl_value = BCM1_USB2_CTL_EHCI_PRT_PWR_ACTIVE_HIGH |
+			BCM1_USB2_CTL_APP_PRT_OVRCUR_IN_ACTIVE_HIGH;
+		break;
+
+	case ASIC_CRONUS:
+	case ASIC_CRONUSLITE:
+		usb_eye_configure(0, CRT_SPARE_USB_DIVIDE_BY_9);
+		fs_update(0x8000, -14, 0x03, QAM_FS_DISABLE_DIVIDE_BY_3,
+			QAM_FS_DISABLE_DIGITAL_STANDBY);
+		bcm1_usb2_ctl_value = BCM1_USB2_CTL_EHCI_PRT_PWR_ACTIVE_HIGH |
+			BCM1_USB2_CTL_APP_PRT_OVRCUR_IN_ACTIVE_HIGH;
+		break;
+
+	case ASIC_CALLIOPE:
+		fs_update(0x0000, -15, 0x02, QAM_FS_DISABLE_DIVIDE_BY_3,
+			QAM_FS_DISABLE_DIGITAL_STANDBY);
+
+		switch (platform_get_family()) {
+		case FAMILY_1500VZE:
+			break;
+
+		case FAMILY_1500VZF:
+			usb_eye_configure(CRT_SPARE_PORT2_SHIFT_JK |
+				CRT_SPARE_PORT1_SHIFT_JK |
+				CRT_SPARE_PORT2_FAST_EDGE |
+				CRT_SPARE_PORT1_FAST_EDGE, 0);
+			break;
+
+		default:
+			usb_eye_configure(CRT_SPARE_PORT2_SHIFT_JK |
+				CRT_SPARE_PORT1_SHIFT_JK, 0);
+			break;
+		}
+
+		bcm1_usb2_ctl_value = BCM1_USB2_CTL_BISTOK |
+			BCM1_USB2_CTL_EHCI_PRT_PWR_ACTIVE_HIGH |
+			BCM1_USB2_CTL_APP_PRT_OVRCUR_IN_ACTIVE_HIGH;
+		break;
+
+	case ASIC_GAIA:
+		fs_update(0x8000, -14, 0x03, QAM_FS_DISABLE_DIVIDE_BY_3,
+			QAM_FS_DISABLE_DIGITAL_STANDBY);
+		bcm1_usb2_ctl_value = BCM1_USB2_CTL_BISTOK |
+			BCM1_USB2_CTL_EHCI_PRT_PWR_ACTIVE_HIGH |
+			BCM1_USB2_CTL_APP_PRT_OVRCUR_IN_ACTIVE_HIGH;
+		break;
+
+	default:
+		pr_err("Unknown ASIC type: %d\n", asic_type);
+		bcm1_usb2_ctl_value = 0;
+		break;
+	}
+
+	/* turn on USB power */
+	asic_write(0, usb2_strap);
+	/* Enable all OHCI interrupts */
+	asic_write(bcm1_usb2_ctl_value, usb2_control);
+	/* usb2_stbus_obc store32/load32 */
+	asic_write(USB_STBUS_OBC_STORE32_LOAD32, usb2_stbus_obc);
+	/* usb2_stbus_mess_size 2 packets */
+	asic_write(USB2_STBUS_MESS_SIZE_2, usb2_stbus_mess_size);
+	/* usb2_stbus_chunk_size 2 packets */
+	asic_write(USB2_STBUS_CHUNK_SIZE_2, usb2_stbus_chunk_size);
+	spin_unlock_irqrestore(&usb_regs_lock, flags);
+}
+
+static void platform_unconfigure_usb(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&usb_regs_lock, flags);
+	usb_users--;
+	if (usb_users == 0)
+		asic_write(USB2_STRAP_HFREQ_SELECT, usb2_strap);
+	spin_unlock_irqrestore(&usb_regs_lock, flags);
+}
+
+/*
+ * Set up the USB EHCI interface
+ */
+void platform_configure_usb_ehci()
+{
+	platform_configure_usb();
+}
+EXPORT_SYMBOL(platform_configure_usb_ehci);
+
+/*
+ * Set up the USB OHCI interface
+ */
+void platform_configure_usb_ohci()
+{
+	platform_configure_usb();
+}
+EXPORT_SYMBOL(platform_configure_usb_ohci);
+
+/*
+ * Shut the USB EHCI interface down
+ */
+void platform_unconfigure_usb_ehci()
+{
+	platform_unconfigure_usb();
+}
+EXPORT_SYMBOL(platform_unconfigure_usb_ehci);
+
+/*
+ * Shut the USB OHCI interface down
+ */
+void platform_unconfigure_usb_ohci()
+{
+	platform_unconfigure_usb();
+}
+EXPORT_SYMBOL(platform_unconfigure_usb_ohci);
+
+/**
+ * platform_devices_init - sets up USB device resourse.
+ */
+int __init platform_usb_devices_init(struct platform_device **ehci_dev,
+	struct platform_device **ohci_dev)
+{
+	*ehci_dev = &ehci_device;
+	ehci_resources[0].start = asic_reg_phys_addr(ehci_hcapbase);
+	ehci_resources[0].end += ehci_resources[0].start;
+
+	*ohci_dev = &ohci_device;
+	ohci_resources[0].start = asic_reg_phys_addr(ohci_hc_revision);
+	ohci_resources[0].end += ohci_resources[0].start;
+
+	return 0;
+}
