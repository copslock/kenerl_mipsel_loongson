Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2011 11:43:32 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:44389 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491759Ab1HLJkE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2011 11:40:04 +0200
Received: by mail-fx0-f49.google.com with SMTP id 20so2860493fxd.36
        for <multiple recipients>; Fri, 12 Aug 2011 02:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wiWet6uoH10LIU9OomyUuhMkHwXGwMf0x5nZBAlb9v8=;
        b=xupiKNoOCdgP8UU1K1NFGpx9gOdPkj1iBfr02+lvPRmATSzU6ZBAR9FtbqbEmtfkHR
         w2RZ5fPR47odc2+cWfTHUFZNmSYFPwkQSi6ZZmACBYdD/ek4ZZVLeZcRKVQK4u/BQXsQ
         GmfEutI/mQxEN2yPuUTApRkCZgRB2/nhvbfsk=
Received: by 10.223.74.12 with SMTP id s12mr979028faj.103.1313142003742;
        Fri, 12 Aug 2011 02:40:03 -0700 (PDT)
Received: from localhost.localdomain (178-191-11-228.adsl.highway.telekom.at [178.191.11.228])
        by mx.google.com with ESMTPS id s14sm467338fah.29.2011.08.12.02.40.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 12 Aug 2011 02:40:02 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 7/8] MIPS: Alchemy: redo PCI as platform driver
Date:   Fri, 12 Aug 2011 11:39:44 +0200
Message-Id: <1313141985-5830-8-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1313141985-5830-1-git-send-email-manuel.lauss@googlemail.com>
References: <1313141985-5830-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 30862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9268

- Rewrite Alchemy PCI support as a platform driver.
- Fixup boards which have PCI.

Run-tested on DB1500 and DB1550.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/common/Makefile                |    2 -
 arch/mips/alchemy/common/pci.c                   |  104 -----
 arch/mips/alchemy/common/setup.c                 |    6 +-
 arch/mips/alchemy/devboards/db1x00/board_setup.c |   24 -
 arch/mips/alchemy/devboards/db1x00/platform.c    |  123 +++++
 arch/mips/alchemy/devboards/pb1500/board_setup.c |   33 +-
 arch/mips/alchemy/devboards/pb1500/platform.c    |   48 ++-
 arch/mips/alchemy/devboards/pb1550/board_setup.c |    6 -
 arch/mips/alchemy/devboards/pb1550/platform.c    |   48 ++-
 arch/mips/alchemy/gpr/board_setup.c              |   12 -
 arch/mips/alchemy/gpr/platform.c                 |   47 ++
 arch/mips/alchemy/mtx-1/board_setup.c            |   40 --
 arch/mips/alchemy/mtx-1/platform.c               |   62 +++
 arch/mips/alchemy/xxs1500/board_setup.c          |    8 -
 arch/mips/include/asm/mach-au1x00/au1000.h       |  142 ++++--
 arch/mips/pci/Makefile                           |    3 +-
 arch/mips/pci/fixup-au1000.c                     |   43 --
 arch/mips/pci/ops-au1000.c                       |  308 -------------
 arch/mips/pci/pci-alchemy.c                      |  516 ++++++++++++++++++++++
 19 files changed, 950 insertions(+), 625 deletions(-)
 delete mode 100644 arch/mips/alchemy/common/pci.c
 delete mode 100644 arch/mips/pci/fixup-au1000.c
 delete mode 100644 arch/mips/pci/ops-au1000.c
 create mode 100644 arch/mips/pci/pci-alchemy.c

diff --git a/arch/mips/alchemy/common/Makefile b/arch/mips/alchemy/common/Makefile
index 31728e0..3792739 100644
--- a/arch/mips/alchemy/common/Makefile
+++ b/arch/mips/alchemy/common/Makefile
@@ -14,5 +14,3 @@ obj-$(CONFIG_ALCHEMY_GPIOINT_AU1000) += irq.o
 ifeq ($(CONFIG_ALCHEMY_GPIO_INDIRECT),)
  obj-$(CONFIG_GPIOLIB) += gpiolib.o
 endif
-
-obj-$(CONFIG_PCI)		+= pci.o
diff --git a/arch/mips/alchemy/common/pci.c b/arch/mips/alchemy/common/pci.c
deleted file mode 100644
index 7866cf5..0000000
--- a/arch/mips/alchemy/common/pci.c
+++ /dev/null
@@ -1,104 +0,0 @@
-/*
- * BRIEF MODULE DESCRIPTION
- *	Alchemy/AMD Au1x00 PCI support.
- *
- * Copyright 2001-2003, 2007-2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
- *
- * Copyright (C) 2004 by Ralf Baechle (ralf@linux-mips.org)
- *
- *  Support for all devices (greater than 16) added by David Gathright.
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/pci.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-
-#include <asm/mach-au1x00/au1000.h>
-
-/* TBD */
-static struct resource pci_io_resource = {
-	.start	= PCI_IO_START,
-	.end	= PCI_IO_END,
-	.name	= "PCI IO space",
-	.flags	= IORESOURCE_IO
-};
-
-static struct resource pci_mem_resource = {
-	.start	= PCI_MEM_START,
-	.end	= PCI_MEM_END,
-	.name	= "PCI memory space",
-	.flags	= IORESOURCE_MEM
-};
-
-extern struct pci_ops au1x_pci_ops;
-
-static struct pci_controller au1x_controller = {
-	.pci_ops	= &au1x_pci_ops,
-	.io_resource	= &pci_io_resource,
-	.mem_resource	= &pci_mem_resource,
-};
-
-#if defined(CONFIG_SOC_AU1500) || defined(CONFIG_SOC_AU1550)
-static unsigned long virt_io_addr;
-#endif
-
-static int __init au1x_pci_setup(void)
-{
-	extern void au1x_pci_cfg_init(void);
-
-#if defined(CONFIG_SOC_AU1500) || defined(CONFIG_SOC_AU1550)
-	virt_io_addr = (unsigned long)ioremap(Au1500_PCI_IO_START,
-			Au1500_PCI_IO_END - Au1500_PCI_IO_START + 1);
-
-	if (!virt_io_addr) {
-		printk(KERN_ERR "Unable to ioremap pci space\n");
-		return 1;
-	}
-	au1x_controller.io_map_base = virt_io_addr;
-
-#ifdef CONFIG_DMA_NONCOHERENT
-	{
-		/*
-		 *  Set the NC bit in controller for Au1500 pre-AC silicon
-		 */
-		u32 prid = read_c0_prid();
-
-		if ((prid & 0xFF000000) == 0x01000000 && prid < 0x01030202) {
-			au_writel((1 << 16) | au_readl(Au1500_PCI_CFG),
-				  Au1500_PCI_CFG);
-			printk(KERN_INFO "Non-coherent PCI accesses enabled\n");
-		}
-	}
-#endif
-
-	set_io_port_base(virt_io_addr);
-#endif
-
-	au1x_pci_cfg_init();
-
-	register_pci_controller(&au1x_controller);
-	return 0;
-}
-
-arch_initcall(au1x_pci_setup);
diff --git a/arch/mips/alchemy/common/setup.c b/arch/mips/alchemy/common/setup.c
index 1b887c8..37ffd99 100644
--- a/arch/mips/alchemy/common/setup.c
+++ b/arch/mips/alchemy/common/setup.c
@@ -73,8 +73,8 @@ void __init plat_mem_setup(void)
 /* This routine should be valid for all Au1x based boards */
 phys_t __fixup_bigphys_addr(phys_t phys_addr, phys_t size)
 {
-	u32 start = (u32)Au1500_PCI_MEM_START;
-	u32 end   = (u32)Au1500_PCI_MEM_END;
+	unsigned long start = ALCHEMY_PCI_MEMWIN_START;
+	unsigned long end = ALCHEMY_PCI_MEMWIN_END;
 
 	/* Don't fixup 36-bit addresses */
 	if ((phys_addr >> 32) != 0)
@@ -82,7 +82,7 @@ phys_t __fixup_bigphys_addr(phys_t phys_addr, phys_t size)
 
 	/* Check for PCI memory window */
 	if (phys_addr >= start && (phys_addr + size - 1) <= end)
-		return (phys_t)((phys_addr - start) + Au1500_PCI_MEM_START);
+		return (phys_t)(AU1500_PCI_MEM_PHYS_ADDR + phys_addr);
 
 	/* default nop */
 	return phys_addr;
diff --git a/arch/mips/alchemy/devboards/db1x00/board_setup.c b/arch/mips/alchemy/devboards/db1x00/board_setup.c
index 5c956fe..2b2178f 100644
--- a/arch/mips/alchemy/devboards/db1x00/board_setup.c
+++ b/arch/mips/alchemy/devboards/db1x00/board_setup.c
@@ -40,24 +40,6 @@
 
 #include <prom.h>
 
-#ifdef CONFIG_MIPS_DB1500
-char irq_tab_alchemy[][5] __initdata = {
-	[12] = { -1, AU1500_PCI_INTA, 0xff, 0xff, 0xff }, /* IDSEL 12 - HPT371   */
-	[13] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, AU1500_PCI_INTC, AU1500_PCI_INTD }, /* IDSEL 13 - PCI slot */
-};
-
-#endif
-
-
-#ifdef CONFIG_MIPS_DB1550
-char irq_tab_alchemy[][5] __initdata = {
-	[11] = { -1, AU1550_PCI_INTC, 0xff, 0xff, 0xff }, /* IDSEL 11 - on-board HPT371 */
-	[12] = { -1, AU1550_PCI_INTB, AU1550_PCI_INTC, AU1550_PCI_INTD, AU1550_PCI_INTA }, /* IDSEL 12 - PCI slot 2 (left) */
-	[13] = { -1, AU1550_PCI_INTA, AU1550_PCI_INTB, AU1550_PCI_INTC, AU1550_PCI_INTD }, /* IDSEL 13 - PCI slot 1 (right) */
-};
-#endif
-
-
 #ifdef CONFIG_MIPS_BOSPORUS
 char irq_tab_alchemy[][5] __initdata = {
 	[11] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, 0xff, 0xff }, /* IDSEL 11 - miniPCI  */
@@ -91,12 +73,6 @@ const char *get_system_type(void)
 
 
 #ifdef CONFIG_MIPS_MIRAGE
-char irq_tab_alchemy[][5] __initdata = {
-	[11] = { -1, AU1500_PCI_INTD, 0xff, 0xff, 0xff }, /* IDSEL 11 - SMI VGX */
-	[12] = { -1, 0xff, 0xff, AU1500_PCI_INTC, 0xff }, /* IDSEL 12 - PNX1300 */
-	[13] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, 0xff, 0xff }, /* IDSEL 13 - miniPCI */
-};
-
 static void mirage_power_off(void)
 {
 	alchemy_gpio_direction_output(210, 1);
diff --git a/arch/mips/alchemy/devboards/db1x00/platform.c b/arch/mips/alchemy/devboards/db1x00/platform.c
index 70bcfb5..990367f 100644
--- a/arch/mips/alchemy/devboards/db1x00/platform.c
+++ b/arch/mips/alchemy/devboards/db1x00/platform.c
@@ -25,6 +25,8 @@
 #include <asm/mach-db1x00/bcsr.h>
 #include "../platform.h"
 
+struct pci_dev;
+
 /* DB1xxx PCMCIA interrupt sources:
  * CD0/1 	GPIO0/3
  * STSCHG0/1	GPIO1/4
@@ -85,6 +87,127 @@
 #endif
 #endif
 
+#ifdef CONFIG_PCI
+#ifdef CONFIG_MIPS_DB1500
+static int db1xxx_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
+{
+	if ((slot < 12) || (slot > 13) || pin == 0)
+		return -1;
+	if (slot == 12)
+		return (pin == 1) ? AU1500_PCI_INTA : 0xff;
+	if (slot == 13) {
+		switch (pin) {
+		case 1: return AU1500_PCI_INTA;
+		case 2: return AU1500_PCI_INTB;
+		case 3: return AU1500_PCI_INTC;
+		case 4: return AU1500_PCI_INTD;
+		}
+	}
+	return -1;
+}
+#endif
+
+#ifdef CONFIG_MIPS_DB1550
+static int db1xxx_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
+{
+	if ((slot < 11) || (slot > 13) || pin == 0)
+		return -1;
+	if (slot == 11)
+		return (pin == 1) ? AU1550_PCI_INTC : 0xff;
+	if (slot == 12) {
+		switch (pin) {
+		case 1: return AU1550_PCI_INTB;
+		case 2: return AU1550_PCI_INTC;
+		case 3: return AU1550_PCI_INTD;
+		case 4: return AU1550_PCI_INTA;
+		}
+	}
+	if (slot == 13) {
+		switch (pin) {
+		case 1: return AU1550_PCI_INTA;
+		case 2: return AU1550_PCI_INTB;
+		case 3: return AU1550_PCI_INTC;
+		case 4: return AU1550_PCI_INTD;
+		}
+	}
+	return -1;
+}
+#endif
+
+#ifdef CONFIG_MIPS_BOSPORUS
+static int db1xxx_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
+{
+	if ((slot < 11) || (slot > 13) || pin == 0)
+		return -1;
+	if (slot == 12)
+		return (pin == 1) ? AU1500_PCI_INTA : 0xff;
+	if (slot == 11) {
+		switch (pin) {
+		case 1: return AU1500_PCI_INTA;
+		case 2: return AU1500_PCI_INTB;
+		default: return 0xff;
+		}
+	}
+	if (slot == 13) {
+		switch (pin) {
+		case 1: return AU1500_PCI_INTA;
+		case 2: return AU1500_PCI_INTB;
+		case 3: return AU1500_PCI_INTC;
+		case 4: return AU1500_PCI_INTD;
+		}
+	}
+	return -1;
+}
+#endif
+
+#ifdef CONFIG_MIPS_MIRAGE
+static int db1xxx_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
+{
+	if ((slot < 11) || (slot > 13) || pin == 0)
+		return -1;
+	if (slot == 11)
+		return (pin == 1) ? AU1500_PCI_INTD : 0xff;
+	if (slot == 12)
+		return (pin == 3) ? AU1500_PCI_INTC : 0xff;
+	if (slot == 13) {
+		switch (pin) {
+		case 1: return AU1500_PCI_INTA;
+		case 2: return AU1500_PCI_INTB;
+		default: return 0xff;
+		}
+	}
+	return -1;
+}
+#endif
+
+static struct resource alchemy_pci_host_res[] = {
+	[0] = {
+		.start	= AU1500_PCI_PHYS_ADDR,
+		.end	= AU1500_PCI_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct alchemy_pci_platdata db1xxx_pci_pd = {
+	.board_map_irq	= db1xxx_map_pci_irq,
+};
+
+static struct platform_device db1xxx_pci_host_dev = {
+	.dev.platform_data = &db1xxx_pci_pd,
+	.name		= "alchemy-pci",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(alchemy_pci_host_res),
+	.resource	= alchemy_pci_host_res,
+};
+
+static int __init db15x0_pci_init(void)
+{
+	return platform_device_register(&db1xxx_pci_host_dev);
+}
+/* must be arch_initcall; MIPS PCI scans busses in a subsys_initcall */
+arch_initcall(db15x0_pci_init);
+#endif
+
 static int __init db1xxx_dev_init(void)
 {
 #ifdef DB1XXX_HAS_PCMCIA
diff --git a/arch/mips/alchemy/devboards/pb1500/board_setup.c b/arch/mips/alchemy/devboards/pb1500/board_setup.c
index 3b4fa32..37c1883 100644
--- a/arch/mips/alchemy/devboards/pb1500/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1500/board_setup.c
@@ -33,13 +33,6 @@
 
 #include <prom.h>
 
-
-char irq_tab_alchemy[][5] __initdata = {
-	[12] = { -1, AU1500_PCI_INTA, 0xff, 0xff, 0xff },   /* IDSEL 12 - HPT370	*/
-	[13] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, AU1500_PCI_INTC, AU1500_PCI_INTD },   /* IDSEL 13 - PCI slot */
-};
-
-
 const char *get_system_type(void)
 {
 	return "Alchemy Pb1500";
@@ -101,20 +94,18 @@ void __init board_setup(void)
 #endif /* defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE) */
 
 #ifdef CONFIG_PCI
-	/* Setup PCI bus controller */
-	au_writel(0, Au1500_PCI_CMEM);
-	au_writel(0x00003fff, Au1500_CFG_BASE);
-#if defined(__MIPSEB__)
-	au_writel(0xf | (2 << 6) | (1 << 4), Au1500_PCI_CFG);
-#else
-	au_writel(0xf, Au1500_PCI_CFG);
-#endif
-	au_writel(0xf0000000, Au1500_PCI_MWMASK_DEV);
-	au_writel(0, Au1500_PCI_MWBASE_REV_CCL);
-	au_writel(0x02a00356, Au1500_PCI_STATCMD);
-	au_writel(0x00003c04, Au1500_PCI_HDRTYPE);
-	au_writel(0x00000008, Au1500_PCI_MBAR);
-	au_sync();
+	{
+		void __iomem *base =
+				(void __iomem *)KSEG1ADDR(AU1500_PCI_PHYS_ADDR);
+		/* Setup PCI bus controller */
+		__raw_writel(0x00003fff, base + PCI_REG_CMEM);
+		__raw_writel(0xf0000000, base + PCI_REG_MWMASK_DEV);
+		__raw_writel(0, base + PCI_REG_MWBASE_REV_CCL);
+		__raw_writel(0x02a00356, base + PCI_REG_STATCMD);
+		__raw_writel(0x00003c04, base + PCI_REG_PARAM);
+		__raw_writel(0x00000008, base + PCI_REG_MBAR);
+		wmb();
+	}
 #endif
 
 	/* Enable sys bus clock divider when IDLE state or no bus activity. */
diff --git a/arch/mips/alchemy/devboards/pb1500/platform.c b/arch/mips/alchemy/devboards/pb1500/platform.c
index 42b0e6b..9f0b5a0 100644
--- a/arch/mips/alchemy/devboards/pb1500/platform.c
+++ b/arch/mips/alchemy/devboards/pb1500/platform.c
@@ -19,11 +19,56 @@
  */
 
 #include <linux/init.h>
+#include <linux/platform_device.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-db1x00/bcsr.h>
 
 #include "../platform.h"
 
+static int pb1500_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
+{
+	if ((slot < 12) || (slot > 13) || pin == 0)
+		return -1;
+	if (slot == 12)
+		return (pin == 1) ? AU1500_PCI_INTA : 0xff;
+	if (slot == 13) {
+		switch (pin) {
+		case 1: return AU1500_PCI_INTA;
+		case 2: return AU1500_PCI_INTB;
+		case 3: return AU1500_PCI_INTC;
+		case 4: return AU1500_PCI_INTD;
+		}
+	}
+	return -1;
+}
+
+static struct resource alchemy_pci_host_res[] = {
+	[0] = {
+		.start	= AU1500_PCI_PHYS_ADDR,
+		.end	= AU1500_PCI_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct alchemy_pci_platdata pb1500_pci_pd = {
+	.board_map_irq	= pb1500_map_pci_irq,
+	.pci_cfg_set	= PCI_CONFIG_AEN | PCI_CONFIG_R2H | PCI_CONFIG_R1H |
+			  PCI_CONFIG_CH |
+#if defined(__MIPSEB__)
+			  PCI_CONFIG_SIC_HWA_DAT | PCI_CONFIG_SM,
+#else
+			  0,
+#endif
+};
+
+static struct platform_device pb1500_pci_host = {
+	.dev.platform_data = &pb1500_pci_pd,
+	.name		= "alchemy-pci",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(alchemy_pci_host_res),
+	.resource	= alchemy_pci_host_res,
+};
+
 static int __init pb1500_dev_init(void)
 {
 	int swapped;
@@ -41,7 +86,8 @@ static int __init pb1500_dev_init(void)
 
 	swapped = bcsr_read(BCSR_STATUS) &  BCSR_STATUS_DB1000_SWAPBOOT;
 	db1x_register_norflash(64 * 1024 * 1024, 4, swapped);
+	platform_device_register(&pb1500_pci_host);
 
 	return 0;
 }
-device_initcall(pb1500_dev_init);
+arch_initcall(pb1500_dev_init);
diff --git a/arch/mips/alchemy/devboards/pb1550/board_setup.c b/arch/mips/alchemy/devboards/pb1550/board_setup.c
index b790213..0f62d1e 100644
--- a/arch/mips/alchemy/devboards/pb1550/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1550/board_setup.c
@@ -37,12 +37,6 @@
 
 #include <prom.h>
 
-
-char irq_tab_alchemy[][5] __initdata = {
-	[12] = { -1, AU1550_PCI_INTB, AU1550_PCI_INTC, AU1550_PCI_INTD, AU1550_PCI_INTA }, /* IDSEL 12 - PCI slot 2 (left)  */
-	[13] = { -1, AU1550_PCI_INTA, AU1550_PCI_INTB, AU1550_PCI_INTC, AU1550_PCI_INTD }, /* IDSEL 13 - PCI slot 1 (right) */
-};
-
 const char *get_system_type(void)
 {
 	return "Alchemy Pb1550";
diff --git a/arch/mips/alchemy/devboards/pb1550/platform.c b/arch/mips/alchemy/devboards/pb1550/platform.c
index 87c79b7..0c5711f 100644
--- a/arch/mips/alchemy/devboards/pb1550/platform.c
+++ b/arch/mips/alchemy/devboards/pb1550/platform.c
@@ -19,13 +19,56 @@
  */
 
 #include <linux/init.h>
-
+#include <linux/platform_device.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1550.h>
 #include <asm/mach-db1x00/bcsr.h>
 
 #include "../platform.h"
 
+static int pb1550_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
+{
+	if ((slot < 12) || (slot > 13) || pin == 0)
+		return -1;
+	if (slot == 12) {
+		switch (pin) {
+		case 1: return AU1500_PCI_INTB;
+		case 2: return AU1500_PCI_INTC;
+		case 3: return AU1500_PCI_INTD;
+		case 4: return AU1500_PCI_INTA;
+		}
+	}
+	if (slot == 13) {
+		switch (pin) {
+		case 1: return AU1500_PCI_INTA;
+		case 2: return AU1500_PCI_INTB;
+		case 3: return AU1500_PCI_INTC;
+		case 4: return AU1500_PCI_INTD;
+		}
+	}
+	return -1;
+}
+
+static struct resource alchemy_pci_host_res[] = {
+	[0] = {
+		.start	= AU1500_PCI_PHYS_ADDR,
+		.end	= AU1500_PCI_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct alchemy_pci_platdata pb1550_pci_pd = {
+	.board_map_irq	= pb1550_map_pci_irq,
+};
+
+static struct platform_device pb1550_pci_host = {
+	.dev.platform_data = &pb1550_pci_pd,
+	.name		= "alchemy-pci",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(alchemy_pci_host_res),
+	.resource	= alchemy_pci_host_res,
+};
+
 static int __init pb1550_dev_init(void)
 {
 	int swapped;
@@ -57,7 +100,8 @@ static int __init pb1550_dev_init(void)
 
 	swapped = bcsr_read(BCSR_STATUS) & BCSR_STATUS_PB1550_SWAPBOOT;
 	db1x_register_norflash(128 * 1024 * 1024, 4, swapped);
+	platform_device_register(&pb1550_pci_host);
 
 	return 0;
 }
-device_initcall(pb1550_dev_init);
+arch_initcall(pb1550_dev_init);
diff --git a/arch/mips/alchemy/gpr/board_setup.c b/arch/mips/alchemy/gpr/board_setup.c
index 5f8f069..dea45c7 100644
--- a/arch/mips/alchemy/gpr/board_setup.c
+++ b/arch/mips/alchemy/gpr/board_setup.c
@@ -36,10 +36,6 @@
 
 #include <prom.h>
 
-char irq_tab_alchemy[][5] __initdata = {
-	[0] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, 0xff, 0xff },
-};
-
 static void gpr_reset(char *c)
 {
 	/* switch System-LED to orange (red# and green# on) */
@@ -76,12 +72,4 @@ void __init board_setup(void)
 
 	/* Take away Reset of UMTS-card */
 	alchemy_gpio_direction_output(215, 1);
-
-#ifdef CONFIG_PCI
-#if defined(__MIPSEB__)
-	au_writel(0xf | (2 << 6) | (1 << 4), Au1500_PCI_CFG);
-#else
-	au_writel(0xf, Au1500_PCI_CFG);
-#endif
-#endif
 }
diff --git a/arch/mips/alchemy/gpr/platform.c b/arch/mips/alchemy/gpr/platform.c
index 14b4662..982ce85 100644
--- a/arch/mips/alchemy/gpr/platform.c
+++ b/arch/mips/alchemy/gpr/platform.c
@@ -167,6 +167,45 @@ static struct i2c_board_info gpr_i2c_info[] __initdata = {
 	}
 };
 
+
+
+static struct resource alchemy_pci_host_res[] = {
+	[0] = {
+		.start	= AU1500_PCI_PHYS_ADDR,
+		.end	= AU1500_PCI_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static int gpr_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
+{
+	if ((slot == 0) && (pin == 1))
+		return AU1550_PCI_INTA;
+	else if ((slot == 0) && (pin == 2))
+		return AU1550_PCI_INTB;
+
+	return -1;
+}
+
+static struct alchemy_pci_platdata gpr_pci_pd = {
+	.board_map_irq	= gpr_map_pci_irq,
+	.pci_cfg_set	= PCI_CONFIG_AEN | PCI_CONFIG_R2H | PCI_CONFIG_R1H |
+			  PCI_CONFIG_CH |
+#if defined(__MIPSEB__)
+			  PCI_CONFIG_SIC_HWA_DAT | PCI_CONFIG_SM,
+#else
+			  0,
+#endif
+};
+
+static struct platform_device gpr_pci_host_dev = {
+	.dev.platform_data = &gpr_pci_pd,
+	.name		= "alchemy-pci",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(alchemy_pci_host_res),
+	.resource	= alchemy_pci_host_res,
+};
+
 static struct platform_device *gpr_devices[] __initdata = {
 	&gpr_wdt_device,
 	&gpr_mtd_device,
@@ -174,6 +213,14 @@ static struct platform_device *gpr_devices[] __initdata = {
 	&gpr_led_devices,
 };
 
+static int __init gpr_pci_init(void)
+{
+	return platform_device_register(&gpr_pci_host_dev);
+}
+/* must be arch_initcall; MIPS PCI scans busses in a subsys_initcall */
+arch_initcall(gpr_pci_init);
+
+
 static int __init gpr_dev_init(void)
 {
 	i2c_register_board_info(0, gpr_i2c_info, ARRAY_SIZE(gpr_i2c_info));
diff --git a/arch/mips/alchemy/mtx-1/board_setup.c b/arch/mips/alchemy/mtx-1/board_setup.c
index 3ae984c..851a5ab 100644
--- a/arch/mips/alchemy/mtx-1/board_setup.c
+++ b/arch/mips/alchemy/mtx-1/board_setup.c
@@ -38,20 +38,6 @@
 
 #include <prom.h>
 
-char irq_tab_alchemy[][5] __initdata = {
-	[0] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTA, 0xff, 0xff }, /* IDSEL 00 - AdapterA-Slot0 (top) */
-	[1] = { -1, AU1500_PCI_INTB, AU1500_PCI_INTA, 0xff, 0xff }, /* IDSEL 01 - AdapterA-Slot1 (bottom) */
-	[2] = { -1, AU1500_PCI_INTC, AU1500_PCI_INTD, 0xff, 0xff }, /* IDSEL 02 - AdapterB-Slot0 (top) */
-	[3] = { -1, AU1500_PCI_INTD, AU1500_PCI_INTC, 0xff, 0xff }, /* IDSEL 03 - AdapterB-Slot1 (bottom) */
-	[4] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, 0xff, 0xff }, /* IDSEL 04 - AdapterC-Slot0 (top) */
-	[5] = { -1, AU1500_PCI_INTB, AU1500_PCI_INTA, 0xff, 0xff }, /* IDSEL 05 - AdapterC-Slot1 (bottom) */
-	[6] = { -1, AU1500_PCI_INTC, AU1500_PCI_INTD, 0xff, 0xff }, /* IDSEL 06 - AdapterD-Slot0 (top) */
-	[7] = { -1, AU1500_PCI_INTD, AU1500_PCI_INTC, 0xff, 0xff }, /* IDSEL 07 - AdapterD-Slot1 (bottom) */
-};
-
-extern int (*board_pci_idsel)(unsigned int devsel, int assert);
-int mtx1_pci_idsel(unsigned int devsel, int assert);
-
 static void mtx1_reset(char *c)
 {
 	/* Jump to the reset vector */
@@ -74,15 +60,6 @@ void __init board_setup(void)
 	alchemy_gpio_direction_output(204, 0);
 #endif /* defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE) */
 
-#ifdef CONFIG_PCI
-#if defined(__MIPSEB__)
-	au_writel(0xf | (2 << 6) | (1 << 4), Au1500_PCI_CFG);
-#else
-	au_writel(0xf, Au1500_PCI_CFG);
-#endif
-	board_pci_idsel = mtx1_pci_idsel;
-#endif
-
 	/* Initialize sys_pinfunc */
 	au_writel(SYS_PF_NI2, SYS_PINFUNC);
 
@@ -104,23 +81,6 @@ void __init board_setup(void)
 	printk(KERN_INFO "4G Systems MTX-1 Board\n");
 }
 
-int
-mtx1_pci_idsel(unsigned int devsel, int assert)
-{
-	/* This function is only necessary to support a proprietary Cardbus
-	 * adapter on the mtx-1 "singleboard" variant. It triggers a custom
-	 * logic chip connected to EXT_IO3 (GPIO1) to suppress IDSEL signals.
-	 */
-	if (assert && devsel != 0)
-		/* Suppress signal to Cardbus */
-		alchemy_gpio_set_value(1, 0);	/* set EXT_IO3 OFF */
-	else
-		alchemy_gpio_set_value(1, 1);	/* set EXT_IO3 ON */
-
-	udelay(1);
-	return 1;
-}
-
 static int __init mtx1_init_irq(void)
 {
 	irq_set_irq_type(AU1500_GPIO204_INT, IRQF_TRIGGER_HIGH);
diff --git a/arch/mips/alchemy/mtx-1/platform.c b/arch/mips/alchemy/mtx-1/platform.c
index 55628e3..cc47b68 100644
--- a/arch/mips/alchemy/mtx-1/platform.c
+++ b/arch/mips/alchemy/mtx-1/platform.c
@@ -135,7 +135,69 @@ static struct platform_device mtx1_mtd = {
 	.resource	= &mtx1_mtd_resource,
 };
 
+static struct resource alchemy_pci_host_res[] = {
+	[0] = {
+		.start	= AU1500_PCI_PHYS_ADDR,
+		.end	= AU1500_PCI_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static int mtx1_pci_idsel(unsigned int devsel, int assert)
+{
+	/* This function is only necessary to support a proprietary Cardbus
+	 * adapter on the mtx-1 "singleboard" variant. It triggers a custom
+	 * logic chip connected to EXT_IO3 (GPIO1) to suppress IDSEL signals.
+	 */
+	if (assert && devsel != 0)
+		/* Suppress signal to Cardbus */
+		alchemy_gpio_set_value(1, 0);	/* set EXT_IO3 OFF */
+	else
+		alchemy_gpio_set_value(1, 1);	/* set EXT_IO3 ON */
+
+	udelay(1);
+	return 1;
+}
+
+static const char mtx1_irqtab[][5] = {
+	[0] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTA, 0xff, 0xff }, /* IDSEL 00 - AdapterA-Slot0 (top) */
+	[1] = { -1, AU1500_PCI_INTB, AU1500_PCI_INTA, 0xff, 0xff }, /* IDSEL 01 - AdapterA-Slot1 (bottom) */
+	[2] = { -1, AU1500_PCI_INTC, AU1500_PCI_INTD, 0xff, 0xff }, /* IDSEL 02 - AdapterB-Slot0 (top) */
+	[3] = { -1, AU1500_PCI_INTD, AU1500_PCI_INTC, 0xff, 0xff }, /* IDSEL 03 - AdapterB-Slot1 (bottom) */
+	[4] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, 0xff, 0xff }, /* IDSEL 04 - AdapterC-Slot0 (top) */
+	[5] = { -1, AU1500_PCI_INTB, AU1500_PCI_INTA, 0xff, 0xff }, /* IDSEL 05 - AdapterC-Slot1 (bottom) */
+	[6] = { -1, AU1500_PCI_INTC, AU1500_PCI_INTD, 0xff, 0xff }, /* IDSEL 06 - AdapterD-Slot0 (top) */
+	[7] = { -1, AU1500_PCI_INTD, AU1500_PCI_INTC, 0xff, 0xff }, /* IDSEL 07 - AdapterD-Slot1 (bottom) */
+};
+
+static int mtx1_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
+{
+	return mtx1_irqtab[slot][pin];
+}
+
+static struct alchemy_pci_platdata mtx1_pci_pd = {
+	.board_map_irq	 = mtx1_map_pci_irq,
+	.board_pci_idsel = mtx1_pci_idsel,
+	.pci_cfg_set	 = PCI_CONFIG_AEN | PCI_CONFIG_R2H | PCI_CONFIG_R1H |
+			   PCI_CONFIG_CH |
+#if defined(__MIPSEB__)
+			   PCI_CONFIG_SIC_HWA_DAT | PCI_CONFIG_SM,
+#else
+			   0,
+#endif
+};
+
+static struct platform_device mtx1_pci_host = {
+	.dev.platform_data = &mtx1_pci_pd,
+	.name		= "alchemy-pci",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(alchemy_pci_host_res),
+	.resource	= alchemy_pci_host_res,
+};
+
+
 static struct __initdata platform_device * mtx1_devs[] = {
+	&mtx1_pci_host,
 	&mtx1_gpio_leds,
 	&mtx1_wdt,
 	&mtx1_button,
diff --git a/arch/mips/alchemy/xxs1500/board_setup.c b/arch/mips/alchemy/xxs1500/board_setup.c
index 81e57fa..3fa83f7 100644
--- a/arch/mips/alchemy/xxs1500/board_setup.c
+++ b/arch/mips/alchemy/xxs1500/board_setup.c
@@ -70,14 +70,6 @@ void __init board_setup(void)
 	/* Enable DTR (MCR bit 0) = USB power up */
 	__raw_writel(1, (void __iomem *)KSEG1ADDR(AU1000_UART3_PHYS_ADDR + 0x18));
 	wmb();
-
-#ifdef CONFIG_PCI
-#if defined(__MIPSEB__)
-	au_writel(0xf | (2 << 6) | (1 << 4), Au1500_PCI_CFG);
-#else
-	au_writel(0xf, Au1500_PCI_CFG);
-#endif
-#endif
 }
 
 static int __init xxs1500_init_irq(void)
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index bcf3d1e..5da2fd7 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -254,6 +254,14 @@ enum alchemy_usb_block {
 };
 int alchemy_usb_control(int block, int enable);
 
+/* PCI controller platform data */
+struct alchemy_pci_platdata {
+	int (*board_map_irq)(const struct pci_dev *d, u8 slot, u8 pin);
+	int (*board_pci_idsel)(unsigned int devsel, int assert);
+	/* bits to set/clear in PCI_CONFIG register */
+	unsigned long pci_cfg_set;
+	unsigned long pci_cfg_clr;
+};
 
 /* SOC Interrupt numbers */
 
@@ -1309,58 +1317,30 @@ enum soc_au1200_ints {
 #  define AC97C_RS		(1 << 1)
 #  define AC97C_CE		(1 << 0)
 
-#if defined(CONFIG_SOC_AU1500) || defined(CONFIG_SOC_AU1550)
-/* Au1500 PCI Controller */
-#define Au1500_CFG_BASE 	0xB4005000	/* virtual, KSEG1 addr */
-#define Au1500_PCI_CMEM 	(Au1500_CFG_BASE + 0)
-#define Au1500_PCI_CFG		(Au1500_CFG_BASE + 4)
-#  define PCI_ERROR		((1 << 22) | (1 << 23) | (1 << 24) | \
-				 (1 << 25) | (1 << 26) | (1 << 27))
-#define Au1500_PCI_B2BMASK_CCH	(Au1500_CFG_BASE + 8)
-#define Au1500_PCI_B2B0_VID	(Au1500_CFG_BASE + 0xC)
-#define Au1500_PCI_B2B1_ID	(Au1500_CFG_BASE + 0x10)
-#define Au1500_PCI_MWMASK_DEV	(Au1500_CFG_BASE + 0x14)
-#define Au1500_PCI_MWBASE_REV_CCL (Au1500_CFG_BASE + 0x18)
-#define Au1500_PCI_ERR_ADDR	(Au1500_CFG_BASE + 0x1C)
-#define Au1500_PCI_SPEC_INTACK	(Au1500_CFG_BASE + 0x20)
-#define Au1500_PCI_ID		(Au1500_CFG_BASE + 0x100)
-#define Au1500_PCI_STATCMD	(Au1500_CFG_BASE + 0x104)
-#define Au1500_PCI_CLASSREV	(Au1500_CFG_BASE + 0x108)
-#define Au1500_PCI_HDRTYPE	(Au1500_CFG_BASE + 0x10C)
-#define Au1500_PCI_MBAR 	(Au1500_CFG_BASE + 0x110)
-
-#define Au1500_PCI_HDR		0xB4005100	/* virtual, KSEG1 addr */
 
-/*
- * All of our structures, like PCI resource, have 32-bit members.
- * Drivers are expected to do an ioremap on the PCI MEM resource, but it's
- * hard to store 0x4 0000 0000 in a 32-bit type.  We require a small patch
- * to __ioremap to check for addresses between (u32)Au1500_PCI_MEM_START and
- * (u32)Au1500_PCI_MEM_END and change those to the full 36-bit PCI MEM
- * addresses.  For PCI I/O, it's simpler because we get to do the ioremap
- * ourselves and then adjust the device's resources.
+/* The PCI chip selects are outside the 32bit space, and since we can't
+ * just program the 36bit addresses into BARs, we have to take a chunk
+ * out of the 32bit space and reserve it for PCI.  When these addresses
+ * are ioremap()ed, they'll be fixed up to the real 36bit address before
+ * being passed to the real ioremap function.
  */
-#define Au1500_EXT_CFG		0x600000000ULL
-#define Au1500_EXT_CFG_TYPE1	0x680000000ULL
-#define Au1500_PCI_IO_START	0x500000000ULL
-#define Au1500_PCI_IO_END	0x5000FFFFFULL
-#define Au1500_PCI_MEM_START	0x440000000ULL
-#define Au1500_PCI_MEM_END	0x44FFFFFFFULL
+#define ALCHEMY_PCI_MEMWIN_START	(AU1500_PCI_MEM_PHYS_ADDR >> 4)
+#define ALCHEMY_PCI_MEMWIN_END		(ALCHEMY_PCI_MEMWIN_START + 0x0FFFFFFF)
 
-#define PCI_IO_START	0x00001000
-#define PCI_IO_END	0x000FFFFF
-#define PCI_MEM_START	0x40000000
-#define PCI_MEM_END	0x4FFFFFFF
+/* for PCI IO it's simpler because we get to do the ioremap ourselves and then
+ * adjust the device's resources.
+ */
+#define ALCHEMY_PCI_IOWIN_START		0x00001000
+#define ALCHEMY_PCI_IOWIN_END		0x0000FFFF
 
-#define PCI_FIRST_DEVFN (0 << 3)
-#define PCI_LAST_DEVFN	(19 << 3)
+#ifdef CONFIG_PCI
 
 #define IOPORT_RESOURCE_START	0x00001000	/* skip legacy probing */
 #define IOPORT_RESOURCE_END	0xffffffff
 #define IOMEM_RESOURCE_START	0x10000000
 #define IOMEM_RESOURCE_END	0xfffffffffULL
 
-#else /* Au1000 and Au1100 and Au1200 */
+#else
 
 /* Don't allow any legacy ports probing */
 #define IOPORT_RESOURCE_START	0x10000000
@@ -1368,13 +1348,77 @@ enum soc_au1200_ints {
 #define IOMEM_RESOURCE_START	0x10000000
 #define IOMEM_RESOURCE_END	0xfffffffffULL
 
-#define PCI_IO_START	0
-#define PCI_IO_END	0
-#define PCI_MEM_START	0
-#define PCI_MEM_END	0
-#define PCI_FIRST_DEVFN 0
-#define PCI_LAST_DEVFN	0
-
 #endif
 
+/* PCI controller block register offsets */
+#define PCI_REG_CMEM		0x0000
+#define PCI_REG_CONFIG		0x0004
+#define PCI_REG_B2BMASK_CCH	0x0008
+#define PCI_REG_B2BBASE0_VID	0x000C
+#define PCI_REG_B2BBASE1_SID	0x0010
+#define PCI_REG_MWMASK_DEV	0x0014
+#define PCI_REG_MWBASE_REV_CCL	0x0018
+#define PCI_REG_ERR_ADDR	0x001C
+#define PCI_REG_SPEC_INTACK	0x0020
+#define PCI_REG_ID		0x0100
+#define PCI_REG_STATCMD		0x0104
+#define PCI_REG_CLASSREV	0x0108
+#define PCI_REG_PARAM		0x010C
+#define PCI_REG_MBAR		0x0110
+#define PCI_REG_TIMEOUT		0x0140
+
+/* PCI controller block register bits */
+#define PCI_CMEM_E		(1 << 28)	/* enable cacheable memory */
+#define PCI_CMEM_CMBASE(x)	(((x) & 0x3fff) << 14)
+#define PCI_CMEM_CMMASK(x)	((x) & 0x3fff)
+#define PCI_CONFIG_ERD		(1 << 27) /* pci error during R/W */
+#define PCI_CONFIG_ET		(1 << 26) /* error in target mode */
+#define PCI_CONFIG_EF		(1 << 25) /* fatal error */
+#define PCI_CONFIG_EP		(1 << 24) /* parity error */
+#define PCI_CONFIG_EM		(1 << 23) /* multiple errors */
+#define PCI_CONFIG_BM		(1 << 22) /* bad master error */
+#define PCI_CONFIG_PD		(1 << 20) /* PCI Disable */
+#define PCI_CONFIG_BME		(1 << 19) /* Byte Mask Enable for reads */
+#define PCI_CONFIG_NC		(1 << 16) /* mark mem access non-coherent */
+#define PCI_CONFIG_IA		(1 << 15) /* INTA# enabled (target mode) */
+#define PCI_CONFIG_IP		(1 << 13) /* int on PCI_PERR# */
+#define PCI_CONFIG_IS		(1 << 12) /* int on PCI_SERR# */
+#define PCI_CONFIG_IMM		(1 << 11) /* int on master abort */
+#define PCI_CONFIG_ITM		(1 << 10) /* int on target abort (as master) */
+#define PCI_CONFIG_ITT		(1 << 9)  /* int on target abort (as target) */
+#define PCI_CONFIG_IPB		(1 << 8)  /* int on PERR# in bus master acc */
+#define PCI_CONFIG_SIC_NO	(0 << 6)  /* no byte mask changes */
+#define PCI_CONFIG_SIC_BA_ADR	(1 << 6)  /* on byte/hw acc, invert adr bits */
+#define PCI_CONFIG_SIC_HWA_DAT	(2 << 6)  /* on halfword acc, swap data */
+#define PCI_CONFIG_SIC_ALL	(3 << 6)  /* swap data bytes on all accesses */
+#define PCI_CONFIG_ST		(1 << 5)  /* swap data by target transactions */
+#define PCI_CONFIG_SM		(1 << 4)  /* swap data from PCI ctl */
+#define PCI_CONFIG_AEN		(1 << 3)  /* enable internal arbiter */
+#define PCI_CONFIG_R2H		(1 << 2)  /* REQ2# to hi-prio arbiter */
+#define PCI_CONFIG_R1H		(1 << 1)  /* REQ1# to hi-prio arbiter */
+#define PCI_CONFIG_CH		(1 << 0)  /* PCI ctl to hi-prio arbiter */
+#define PCI_B2BMASK_B2BMASK(x)	(((x) & 0xffff) << 16)
+#define PCI_B2BMASK_CCH(x)	((x) & 0xffff) /* 16 upper bits of class code */
+#define PCI_B2BBASE0_VID_B0(x)	(((x) & 0xffff) << 16)
+#define PCI_B2BBASE0_VID_SV(x)	((x) & 0xffff)
+#define PCI_B2BBASE1_SID_B1(x)	(((x) & 0xffff) << 16)
+#define PCI_B2BBASE1_SID_SI(x)	((x) & 0xffff)
+#define PCI_MWMASKDEV_MWMASK(x) (((x) & 0xffff) << 16)
+#define PCI_MWMASKDEV_DEVID(x)	((x) & 0xffff)
+#define PCI_MWBASEREVCCL_BASE(x) (((x) & 0xffff) << 16)
+#define PCI_MWBASEREVCCL_REV(x)  (((x) & 0xff) << 8)
+#define PCI_MWBASEREVCCL_CCL(x)  ((x) & 0xff)
+#define PCI_ID_DID(x)		(((x) & 0xffff) << 16)
+#define PCI_ID_VID(x)		((x) & 0xffff)
+#define PCI_STATCMD_STATUS(x)	(((x) & 0xffff) << 16)
+#define PCI_STATCMD_CMD(x)	((x) & 0xffff)
+#define PCI_CLASSREV_CLASS(x)	(((x) & 0x00ffffff) << 8)
+#define PCI_CLASSREV_REV(x)	((x) & 0xff)
+#define PCI_PARAM_BIST(x)	(((x) & 0xff) << 24)
+#define PCI_PARAM_HT(x)		(((x) & 0xff) << 16)
+#define PCI_PARAM_LT(x)		(((x) & 0xff) << 8)
+#define PCI_PARAM_CLS(x)	((x) & 0xff)
+#define PCI_TIMEOUT_RETRIES(x)	(((x) & 0xff) << 8)	/* max retries */
+#define PCI_TIMEOUT_TO(x)	((x) & 0xff)	/* target ready timeout */
+
 #endif
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 4df8799..bb82cbd 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -18,14 +18,13 @@ obj-$(CONFIG_PCI_TX4927)	+= ops-tx4927.o
 obj-$(CONFIG_BCM47XX)		+= pci-bcm47xx.o
 obj-$(CONFIG_BCM63XX)		+= pci-bcm63xx.o fixup-bcm63xx.o \
 					ops-bcm63xx.o
+obj-$(CONFIG_MIPS_ALCHEMY)	+= pci-alchemy.o
 
 #
 # These are still pretty much in the old state, watch, go blind.
 #
 obj-$(CONFIG_LASAT)		+= pci-lasat.o
 obj-$(CONFIG_MIPS_COBALT)	+= fixup-cobalt.o
-obj-$(CONFIG_SOC_AU1500)	+= fixup-au1000.o ops-au1000.o
-obj-$(CONFIG_SOC_AU1550)	+= fixup-au1000.o ops-au1000.o
 obj-$(CONFIG_SOC_PNX8550)	+= fixup-pnx8550.o ops-pnx8550.o
 obj-$(CONFIG_LEMOTE_FULOONG2E)	+= fixup-fuloong2e.o ops-loongson2.o
 obj-$(CONFIG_LEMOTE_MACH2F)	+= fixup-lemote2f.o ops-loongson2.o
diff --git a/arch/mips/pci/fixup-au1000.c b/arch/mips/pci/fixup-au1000.c
deleted file mode 100644
index e2ddfc4..0000000
--- a/arch/mips/pci/fixup-au1000.c
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * BRIEF MODULE DESCRIPTION
- *	Board specific PCI fixups.
- *
- * Copyright 2001-2003, 2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/pci.h>
-#include <linux/init.h>
-
-extern char irq_tab_alchemy[][5];
-
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	return irq_tab_alchemy[slot][pin];
-}
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
diff --git a/arch/mips/pci/ops-au1000.c b/arch/mips/pci/ops-au1000.c
deleted file mode 100644
index 9a57c5a..0000000
--- a/arch/mips/pci/ops-au1000.c
+++ /dev/null
@@ -1,308 +0,0 @@
-/*
- * BRIEF MODULE DESCRIPTION
- *	Alchemy/AMD Au1xx0 PCI support.
- *
- * Copyright 2001-2003, 2007-2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
- *
- *  Support for all devices (greater than 16) added by David Gathright.
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/types.h>
-#include <linux/pci.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/vmalloc.h>
-
-#include <asm/mach-au1x00/au1000.h>
-
-#undef	DEBUG
-#ifdef	DEBUG
-#define DBG(x...) printk(KERN_DEBUG x)
-#else
-#define DBG(x...)
-#endif
-
-#define PCI_ACCESS_READ  0
-#define PCI_ACCESS_WRITE 1
-
-int (*board_pci_idsel)(unsigned int devsel, int assert);
-
-void mod_wired_entry(int entry, unsigned long entrylo0,
-		unsigned long entrylo1, unsigned long entryhi,
-		unsigned long pagemask)
-{
-	unsigned long old_pagemask;
-	unsigned long old_ctx;
-
-	/* Save old context and create impossible VPN2 value */
-	old_ctx = read_c0_entryhi() & 0xff;
-	old_pagemask = read_c0_pagemask();
-	write_c0_index(entry);
-	write_c0_pagemask(pagemask);
-	write_c0_entryhi(entryhi);
-	write_c0_entrylo0(entrylo0);
-	write_c0_entrylo1(entrylo1);
-	tlb_write_indexed();
-	write_c0_entryhi(old_ctx);
-	write_c0_pagemask(old_pagemask);
-}
-
-static struct vm_struct *pci_cfg_vm;
-static int pci_cfg_wired_entry;
-static unsigned long last_entryLo0, last_entryLo1;
-
-/*
- * We can't ioremap the entire pci config space because it's too large.
- * Nor can we call ioremap dynamically because some device drivers use
- * the PCI config routines from within interrupt handlers and that
- * becomes a problem in get_vm_area().  We use one wired TLB to handle
- * all config accesses for all busses.
- */
-void __init au1x_pci_cfg_init(void)
-{
-	/* Reserve a wired entry for PCI config accesses */
-	pci_cfg_vm = get_vm_area(0x2000, VM_IOREMAP);
-	if (!pci_cfg_vm)
-		panic(KERN_ERR "PCI unable to get vm area\n");
-	pci_cfg_wired_entry = read_c0_wired();
-	add_wired_entry(0, 0, (unsigned long)pci_cfg_vm->addr, PM_4K);
-	last_entryLo0 = last_entryLo1 = 0xffffffff;
-}
-
-static int config_access(unsigned char access_type, struct pci_bus *bus,
-			 unsigned int dev_fn, unsigned char where, u32 *data)
-{
-#if defined(CONFIG_SOC_AU1500) || defined(CONFIG_SOC_AU1550)
-	unsigned int device = PCI_SLOT(dev_fn);
-	unsigned int function = PCI_FUNC(dev_fn);
-	unsigned long offset, status;
-	unsigned long cfg_base;
-	unsigned long flags;
-	int error = PCIBIOS_SUCCESSFUL;
-	unsigned long entryLo0, entryLo1;
-
-	if (device > 19) {
-		*data = 0xffffffff;
-		return -1;
-	}
-
-	local_irq_save(flags);
-	au_writel(((0x2000 << 16) | (au_readl(Au1500_PCI_STATCMD) & 0xffff)),
-			Au1500_PCI_STATCMD);
-	au_sync_udelay(1);
-
-	/*
-	 * Allow board vendors to implement their own off-chip IDSEL.
-	 * If it doesn't succeed, may as well bail out at this point.
-	 */
-	if (board_pci_idsel && board_pci_idsel(device, 1) == 0) {
-		*data = 0xffffffff;
-		local_irq_restore(flags);
-		return -1;
-	}
-
-	/* Setup the config window */
-	if (bus->number == 0)
-		cfg_base = (1 << device) << 11;
-	else
-		cfg_base = 0x80000000 | (bus->number << 16) | (device << 11);
-
-	/* Setup the lower bits of the 36-bit address */
-	offset = (function << 8) | (where & ~0x3);
-	/* Pick up any address that falls below the page mask */
-	offset |= cfg_base & ~PAGE_MASK;
-
-	/* Page boundary */
-	cfg_base = cfg_base & PAGE_MASK;
-
-	/*
-	 * To improve performance, if the current device is the same as
-	 * the last device accessed, we don't touch the TLB.
-	 */
-	entryLo0 = (6 << 26) | (cfg_base >> 6) | (2 << 3) | 7;
-	entryLo1 = (6 << 26) | (cfg_base >> 6) | (0x1000 >> 6) | (2 << 3) | 7;
-	if ((entryLo0 != last_entryLo0) || (entryLo1 != last_entryLo1)) {
-		mod_wired_entry(pci_cfg_wired_entry, entryLo0, entryLo1,
-				(unsigned long)pci_cfg_vm->addr, PM_4K);
-		last_entryLo0 = entryLo0;
-		last_entryLo1 = entryLo1;
-	}
-
-	if (access_type == PCI_ACCESS_WRITE)
-		au_writel(*data, (int)(pci_cfg_vm->addr + offset));
-	else
-		*data = au_readl((int)(pci_cfg_vm->addr + offset));
-
-	au_sync_udelay(2);
-
-	DBG("cfg_access %d bus->number %u dev %u at %x *data %x conf %lx\n",
-	    access_type, bus->number, device, where, *data, offset);
-
-	/* Check master abort */
-	status = au_readl(Au1500_PCI_STATCMD);
-
-	if (status & (1 << 29)) {
-		*data = 0xffffffff;
-		error = -1;
-		DBG("Au1x Master Abort\n");
-	} else if ((status >> 28) & 0xf) {
-		DBG("PCI ERR detected: device %u, status %lx\n",
-		    device, (status >> 28) & 0xf);
-
-		/* Clear errors */
-		au_writel(status & 0xf000ffff, Au1500_PCI_STATCMD);
-
-		*data = 0xffffffff;
-		error = -1;
-	}
-
-	/* Take away the IDSEL. */
-	if (board_pci_idsel)
-		(void)board_pci_idsel(device, 0);
-
-	local_irq_restore(flags);
-	return error;
-#endif
-}
-
-static int read_config_byte(struct pci_bus *bus, unsigned int devfn,
-			    int where,	u8 *val)
-{
-	u32 data;
-	int ret;
-
-	ret = config_access(PCI_ACCESS_READ, bus, devfn, where, &data);
-	if (where & 1)
-		data >>= 8;
-	if (where & 2)
-		data >>= 16;
-	*val = data & 0xff;
-	return ret;
-}
-
-static int read_config_word(struct pci_bus *bus, unsigned int devfn,
-			    int where, u16 *val)
-{
-	u32 data;
-	int ret;
-
-	ret = config_access(PCI_ACCESS_READ, bus, devfn, where, &data);
-	if (where & 2)
-		data >>= 16;
-	*val = data & 0xffff;
-	return ret;
-}
-
-static int read_config_dword(struct pci_bus *bus, unsigned int devfn,
-			     int where, u32 *val)
-{
-	int ret;
-
-	ret = config_access(PCI_ACCESS_READ, bus, devfn, where, val);
-	return ret;
-}
-
-static int write_config_byte(struct pci_bus *bus, unsigned int devfn,
-			     int where, u8 val)
-{
-	u32 data = 0;
-
-	if (config_access(PCI_ACCESS_READ, bus, devfn, where, &data))
-		return -1;
-
-	data = (data & ~(0xff << ((where & 3) << 3))) |
-	       (val << ((where & 3) << 3));
-
-	if (config_access(PCI_ACCESS_WRITE, bus, devfn, where, &data))
-		return -1;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int write_config_word(struct pci_bus *bus, unsigned int devfn,
-			     int where, u16 val)
-{
-	u32 data = 0;
-
-	if (config_access(PCI_ACCESS_READ, bus, devfn, where, &data))
-		return -1;
-
-	data = (data & ~(0xffff << ((where & 3) << 3))) |
-	       (val << ((where & 3) << 3));
-
-	if (config_access(PCI_ACCESS_WRITE, bus, devfn, where, &data))
-		return -1;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int write_config_dword(struct pci_bus *bus, unsigned int devfn,
-			      int where, u32 val)
-{
-	if (config_access(PCI_ACCESS_WRITE, bus, devfn, where, &val))
-		return -1;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int config_read(struct pci_bus *bus, unsigned int devfn,
-		       int where, int size, u32 *val)
-{
-	switch (size) {
-	case 1: {
-			u8 _val;
-			int rc = read_config_byte(bus, devfn, where, &_val);
-
-			*val = _val;
-			return rc;
-		}
-	case 2: {
-			u16 _val;
-			int rc = read_config_word(bus, devfn, where, &_val);
-
-			*val = _val;
-			return rc;
-		}
-	default:
-		return read_config_dword(bus, devfn, where, val);
-	}
-}
-
-static int config_write(struct pci_bus *bus, unsigned int devfn,
-			int where, int size, u32 val)
-{
-	switch (size) {
-	case 1:
-		return write_config_byte(bus, devfn, where, (u8) val);
-	case 2:
-		return write_config_word(bus, devfn, where, (u16) val);
-	default:
-		return write_config_dword(bus, devfn, where, val);
-	}
-}
-
-struct pci_ops au1x_pci_ops = {
-	config_read,
-	config_write
-};
diff --git a/arch/mips/pci/pci-alchemy.c b/arch/mips/pci/pci-alchemy.c
new file mode 100644
index 0000000..4ee5710
--- /dev/null
+++ b/arch/mips/pci/pci-alchemy.c
@@ -0,0 +1,516 @@
+/*
+ * Alchemy PCI host mode support.
+ *
+ * Copyright 2001-2003, 2007-2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
+ *
+ * Support for all devices (greater than 16) added by David Gathright.
+ */
+
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/vmalloc.h>
+
+#include <asm/mach-au1x00/au1000.h>
+
+#ifdef CONFIG_DEBUG_PCI
+#define DBG(x...) printk(KERN_DEBUG x)
+#else
+#define DBG(x...) do {} while (0)
+#endif
+
+#define PCI_ACCESS_READ		0
+#define PCI_ACCESS_WRITE	1
+
+struct alchemy_pci_context {
+	struct pci_controller alchemy_pci_ctrl;	/* leave as first member! */
+	void __iomem *regs;			/* ctrl base */
+	/* tools for wired entry for config space access */
+	unsigned long last_elo0;
+	unsigned long last_elo1;
+	int wired_entry;
+	struct vm_struct *pci_cfg_vm;
+
+	unsigned long pm[12];
+
+	int (*board_map_irq)(const struct pci_dev *d, u8 slot, u8 pin);
+	int (*board_pci_idsel)(unsigned int devsel, int assert);
+};
+
+/* IO/MEM resources for PCI. Keep the memres in sync with __fixup_bigphys_addr
+ * in arch/mips/alchemy/common/setup.c
+ */
+static struct resource alchemy_pci_def_memres = {
+	.start	= ALCHEMY_PCI_MEMWIN_START,
+	.end	= ALCHEMY_PCI_MEMWIN_END,
+	.name	= "PCI memory space",
+	.flags	= IORESOURCE_MEM
+};
+
+static struct resource alchemy_pci_def_iores = {
+	.start	= ALCHEMY_PCI_IOWIN_START,
+	.end	= ALCHEMY_PCI_IOWIN_END,
+	.name	= "PCI IO space",
+	.flags	= IORESOURCE_IO
+};
+
+static void mod_wired_entry(int entry, unsigned long entrylo0,
+		unsigned long entrylo1, unsigned long entryhi,
+		unsigned long pagemask)
+{
+	unsigned long old_pagemask;
+	unsigned long old_ctx;
+
+	/* Save old context and create impossible VPN2 value */
+	old_ctx = read_c0_entryhi() & 0xff;
+	old_pagemask = read_c0_pagemask();
+	write_c0_index(entry);
+	write_c0_pagemask(pagemask);
+	write_c0_entryhi(entryhi);
+	write_c0_entrylo0(entrylo0);
+	write_c0_entrylo1(entrylo1);
+	tlb_write_indexed();
+	write_c0_entryhi(old_ctx);
+	write_c0_pagemask(old_pagemask);
+}
+
+static void alchemy_pci_wired_entry(struct alchemy_pci_context *ctx)
+{
+	ctx->wired_entry = read_c0_wired();
+	add_wired_entry(0, 0, (unsigned long)ctx->pci_cfg_vm->addr, PM_4K);
+	ctx->last_elo0 = ctx->last_elo1 = ~0;
+}
+
+static int config_access(unsigned char access_type, struct pci_bus *bus,
+			 unsigned int dev_fn, unsigned char where, u32 *data)
+{
+	struct alchemy_pci_context *ctx = bus->sysdata;
+	unsigned int device = PCI_SLOT(dev_fn);
+	unsigned int function = PCI_FUNC(dev_fn);
+	unsigned long offset, status, cfg_base, flags, entryLo0, entryLo1, r;
+	int error = PCIBIOS_SUCCESSFUL;
+
+	if (device > 19) {
+		*data = 0xffffffff;
+		return -1;
+	}
+
+	/* YAMON on all db1xxx boards wipes the TLB and writes zero to C0_wired
+	 * on resume, clearing our wired entry.  Unfortunately the ->resume()
+	 * callback is called way way way too late (and ->suspend() too early)
+	 * to have them destroy and recreate it.  Instead just test if c0_wired
+	 * is now lower than the index we retrieved before suspending and then
+	 * recreate the entry if necessary.  Of course this is totally bonkers
+	 * and breaks as soon as someone else adds another wired entry somewhere
+	 * else.  Anyone have any ideas how to handle this better?
+	 */
+	if (unlikely(read_c0_wired() < ctx->wired_entry))
+		alchemy_pci_wired_entry(ctx);
+
+	local_irq_save(flags);
+	r = __raw_readl(ctx->regs + PCI_REG_STATCMD) & 0x0000ffff;
+	r |= PCI_STATCMD_STATUS(0x2000);
+	__raw_writel(r, ctx->regs + PCI_REG_STATCMD);
+	wmb();
+
+	/* Allow board vendors to implement their own off-chip IDSEL.
+	 * If it doesn't succeed, may as well bail out at this point.
+	 */
+	if (ctx->board_pci_idsel(device, 1) == 0) {
+		*data = 0xffffffff;
+		local_irq_restore(flags);
+		return -1;
+	}
+
+	/* Setup the config window */
+	if (bus->number == 0)
+		cfg_base = (1 << device) << 11;
+	else
+		cfg_base = 0x80000000 | (bus->number << 16) | (device << 11);
+
+	/* Setup the lower bits of the 36-bit address */
+	offset = (function << 8) | (where & ~0x3);
+	/* Pick up any address that falls below the page mask */
+	offset |= cfg_base & ~PAGE_MASK;
+
+	/* Page boundary */
+	cfg_base = cfg_base & PAGE_MASK;
+
+	/* To improve performance, if the current device is the same as
+	 * the last device accessed, we don't touch the TLB.
+	 */
+	entryLo0 = (6 << 26) | (cfg_base >> 6) | (2 << 3) | 7;
+	entryLo1 = (6 << 26) | (cfg_base >> 6) | (0x1000 >> 6) | (2 << 3) | 7;
+	if ((entryLo0 != ctx->last_elo0) || (entryLo1 != ctx->last_elo1)) {
+		mod_wired_entry(ctx->wired_entry, entryLo0, entryLo1,
+				(unsigned long)ctx->pci_cfg_vm->addr, PM_4K);
+		ctx->last_elo0 = entryLo0;
+		ctx->last_elo1 = entryLo1;
+	}
+
+	if (access_type == PCI_ACCESS_WRITE)
+		__raw_writel(*data, ctx->pci_cfg_vm->addr + offset);
+	else
+		*data = __raw_readl(ctx->pci_cfg_vm->addr + offset);
+	wmb();
+
+	DBG("alchemy-pci: cfg access %d bus %u dev %u at %x dat %x conf %lx\n",
+	    access_type, bus->number, device, where, *data, offset);
+
+	/* check for errors, master abort */
+	status = __raw_readl(ctx->regs + PCI_REG_STATCMD);
+	if (status & (1 << 29)) {
+		*data = 0xffffffff;
+		error = -1;
+		DBG("alchemy-pci: master abort on cfg access %d bus %d dev %d",
+		    access_type, bus->number, device);
+	} else if ((status >> 28) & 0xf) {
+		DBG("alchemy-pci: PCI ERR detected: dev %d, status %lx\n",
+		    device, (status >> 28) & 0xf);
+
+		/* clear errors */
+		__raw_writel(status & 0xf000ffff, ctx->regs + PCI_REG_STATCMD);
+
+		*data = 0xffffffff;
+		error = -1;
+	}
+
+	/* Take away the IDSEL. */
+	(void)ctx->board_pci_idsel(device, 0);
+
+	local_irq_restore(flags);
+	return error;
+}
+
+static int read_config_byte(struct pci_bus *bus, unsigned int devfn,
+			    int where,	u8 *val)
+{
+	u32 data;
+	int ret = config_access(PCI_ACCESS_READ, bus, devfn, where, &data);
+
+	if (where & 1)
+		data >>= 8;
+	if (where & 2)
+		data >>= 16;
+	*val = data & 0xff;
+	return ret;
+}
+
+static int read_config_word(struct pci_bus *bus, unsigned int devfn,
+			    int where, u16 *val)
+{
+	u32 data;
+	int ret = config_access(PCI_ACCESS_READ, bus, devfn, where, &data);
+
+	if (where & 2)
+		data >>= 16;
+	*val = data & 0xffff;
+	return ret;
+}
+
+static int read_config_dword(struct pci_bus *bus, unsigned int devfn,
+			     int where, u32 *val)
+{
+	return config_access(PCI_ACCESS_READ, bus, devfn, where, val);
+}
+
+static int write_config_byte(struct pci_bus *bus, unsigned int devfn,
+			     int where, u8 val)
+{
+	u32 data = 0;
+
+	if (config_access(PCI_ACCESS_READ, bus, devfn, where, &data))
+		return -1;
+
+	data = (data & ~(0xff << ((where & 3) << 3))) |
+	       (val << ((where & 3) << 3));
+
+	if (config_access(PCI_ACCESS_WRITE, bus, devfn, where, &data))
+		return -1;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int write_config_word(struct pci_bus *bus, unsigned int devfn,
+			     int where, u16 val)
+{
+	u32 data = 0;
+
+	if (config_access(PCI_ACCESS_READ, bus, devfn, where, &data))
+		return -1;
+
+	data = (data & ~(0xffff << ((where & 3) << 3))) |
+	       (val << ((where & 3) << 3));
+
+	if (config_access(PCI_ACCESS_WRITE, bus, devfn, where, &data))
+		return -1;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int write_config_dword(struct pci_bus *bus, unsigned int devfn,
+			      int where, u32 val)
+{
+	return config_access(PCI_ACCESS_WRITE, bus, devfn, where, &val);
+}
+
+static int alchemy_pci_read(struct pci_bus *bus, unsigned int devfn,
+		       int where, int size, u32 *val)
+{
+	switch (size) {
+	case 1: {
+			u8 _val;
+			int rc = read_config_byte(bus, devfn, where, &_val);
+
+			*val = _val;
+			return rc;
+		}
+	case 2: {
+			u16 _val;
+			int rc = read_config_word(bus, devfn, where, &_val);
+
+			*val = _val;
+			return rc;
+		}
+	default:
+		return read_config_dword(bus, devfn, where, val);
+	}
+}
+
+static int alchemy_pci_write(struct pci_bus *bus, unsigned int devfn,
+			     int where, int size, u32 val)
+{
+	switch (size) {
+	case 1:
+		return write_config_byte(bus, devfn, where, (u8) val);
+	case 2:
+		return write_config_word(bus, devfn, where, (u16) val);
+	default:
+		return write_config_dword(bus, devfn, where, val);
+	}
+}
+
+static struct pci_ops alchemy_pci_ops = {
+	.read	= alchemy_pci_read,
+	.write	= alchemy_pci_write,
+};
+
+static int alchemy_pci_def_idsel(unsigned int devsel, int assert)
+{
+	return 1;	/* success */
+}
+
+static int __devinit alchemy_pci_probe(struct platform_device *pdev)
+{
+	struct alchemy_pci_platdata *pd = pdev->dev.platform_data;
+	struct alchemy_pci_context *ctx;
+	void __iomem *virt_io;
+	unsigned long val;
+	struct resource *r;
+	int ret;
+
+	/* need at least PCI IRQ mapping table */
+	if (!pd) {
+		dev_err(&pdev->dev, "need platform data for PCI setup\n");
+		ret = -ENODEV;
+		goto out;
+	}
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx) {
+		dev_err(&pdev->dev, "no memory for pcictl context\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		dev_err(&pdev->dev, "no  pcictl ctrl regs resource\n");
+		ret = -ENODEV;
+		goto out1;
+	}
+
+	if (!request_mem_region(r->start, resource_size(r), pdev->name)) {
+		dev_err(&pdev->dev, "cannot claim pci regs\n");
+		ret = -ENODEV;
+		goto out1;
+	}
+
+	ctx->regs = ioremap_nocache(r->start, resource_size(r));
+	if (!ctx->regs) {
+		dev_err(&pdev->dev, "cannot map pci regs\n");
+		ret = -ENODEV;
+		goto out2;
+	}
+
+	/* map parts of the PCI IO area */
+	/* REVISIT: if this changes with a newer variant (doubt it) make this
+	 * a platform resource.
+	 */
+	virt_io = ioremap(AU1500_PCI_IO_PHYS_ADDR, 0x00100000);
+	if (!virt_io) {
+		dev_err(&pdev->dev, "cannot remap pci io space\n");
+		ret = -ENODEV;
+		goto out3;
+	}
+	ctx->alchemy_pci_ctrl.io_map_base = (unsigned long)virt_io;
+
+#ifdef CONFIG_DMA_NONCOHERENT
+	/* Au1500 revisions older than AD have borked coherent PCI */
+	if ((alchemy_get_cputype() == ALCHEMY_CPU_AU1500) &&
+	    (read_c0_prid() < 0x01030202)) {
+		val = __raw_readl(ctx->regs + PCI_REG_CONFIG);
+		val |= PCI_CONFIG_NC;
+		__raw_writel(val, ctx->regs + PCI_REG_CONFIG);
+		wmb();
+		dev_info(&pdev->dev, "non-coherent PCI on Au1500 AA/AB/AC\n");
+	}
+#endif
+
+	if (pd->board_map_irq)
+		ctx->board_map_irq = pd->board_map_irq;
+
+	if (pd->board_pci_idsel)
+		ctx->board_pci_idsel = pd->board_pci_idsel;
+	else
+		ctx->board_pci_idsel = alchemy_pci_def_idsel;
+
+	/* fill in relevant pci_controller members */
+	ctx->alchemy_pci_ctrl.pci_ops = &alchemy_pci_ops;
+	ctx->alchemy_pci_ctrl.mem_resource = &alchemy_pci_def_memres;
+	ctx->alchemy_pci_ctrl.io_resource = &alchemy_pci_def_iores;
+
+	/* we can't ioremap the entire pci config space because it's too large,
+	 * nor can we dynamically ioremap it because some drivers use the
+	 * PCI config routines from within atomic contex and that becomes a
+	 * problem in get_vm_area().  Instead we use one wired TLB entry to
+	 * handle all config accesses for all busses.
+	 */
+	ctx->pci_cfg_vm = get_vm_area(0x2000, VM_IOREMAP);
+	if (!ctx->pci_cfg_vm) {
+		dev_err(&pdev->dev, "unable to get vm area\n");
+		ret = -ENOMEM;
+		goto out4;
+	}
+	ctx->wired_entry = 8192;	/* impossibly high value */
+
+	set_io_port_base((unsigned long)ctx->alchemy_pci_ctrl.io_map_base);
+
+	/* board may want to modify bits in the config register, do it now */
+	val = __raw_readl(ctx->regs + PCI_REG_CONFIG);
+	val &= ~pd->pci_cfg_clr;
+	val |= pd->pci_cfg_set;
+	val &= ~PCI_CONFIG_PD;		/* clear disable bit */
+	__raw_writel(val, ctx->regs + PCI_REG_CONFIG);
+	wmb();
+
+	platform_set_drvdata(pdev, ctx);
+	register_pci_controller(&ctx->alchemy_pci_ctrl);
+
+	return 0;
+
+out4:
+	iounmap(virt_io);
+out3:
+	iounmap(ctx->regs);
+out2:
+	release_mem_region(r->start, resource_size(r));
+out1:
+	kfree(ctx);
+out:
+	return ret;
+}
+
+
+#ifdef CONFIG_PM
+/* save PCI controller register contents. */
+static int alchemy_pci_suspend(struct device *dev)
+{
+	struct alchemy_pci_context *ctx = dev_get_drvdata(dev);
+
+	ctx->pm[0]  = __raw_readl(ctx->regs + PCI_REG_CMEM);
+	ctx->pm[1]  = __raw_readl(ctx->regs + PCI_REG_CONFIG) & 0x0009ffff;
+	ctx->pm[2]  = __raw_readl(ctx->regs + PCI_REG_B2BMASK_CCH);
+	ctx->pm[3]  = __raw_readl(ctx->regs + PCI_REG_B2BBASE0_VID);
+	ctx->pm[4]  = __raw_readl(ctx->regs + PCI_REG_B2BBASE1_SID);
+	ctx->pm[5]  = __raw_readl(ctx->regs + PCI_REG_MWMASK_DEV);
+	ctx->pm[6]  = __raw_readl(ctx->regs + PCI_REG_MWBASE_REV_CCL);
+	ctx->pm[7]  = __raw_readl(ctx->regs + PCI_REG_ID);
+	ctx->pm[8]  = __raw_readl(ctx->regs + PCI_REG_CLASSREV);
+	ctx->pm[9]  = __raw_readl(ctx->regs + PCI_REG_PARAM);
+	ctx->pm[10] = __raw_readl(ctx->regs + PCI_REG_MBAR);
+	ctx->pm[11] = __raw_readl(ctx->regs + PCI_REG_TIMEOUT);
+
+	return 0;
+}
+
+static int alchemy_pci_resume(struct device *dev)
+{
+	struct alchemy_pci_context *ctx = dev_get_drvdata(dev);
+
+	__raw_writel(ctx->pm[0],  ctx->regs + PCI_REG_CMEM);
+	__raw_writel(ctx->pm[2],  ctx->regs + PCI_REG_B2BMASK_CCH);
+	__raw_writel(ctx->pm[3],  ctx->regs + PCI_REG_B2BBASE0_VID);
+	__raw_writel(ctx->pm[4],  ctx->regs + PCI_REG_B2BBASE1_SID);
+	__raw_writel(ctx->pm[5],  ctx->regs + PCI_REG_MWMASK_DEV);
+	__raw_writel(ctx->pm[6],  ctx->regs + PCI_REG_MWBASE_REV_CCL);
+	__raw_writel(ctx->pm[7],  ctx->regs + PCI_REG_ID);
+	__raw_writel(ctx->pm[8],  ctx->regs + PCI_REG_CLASSREV);
+	__raw_writel(ctx->pm[9],  ctx->regs + PCI_REG_PARAM);
+	__raw_writel(ctx->pm[10], ctx->regs + PCI_REG_MBAR);
+	__raw_writel(ctx->pm[11], ctx->regs + PCI_REG_TIMEOUT);
+	wmb();
+	__raw_writel(ctx->pm[1],  ctx->regs + PCI_REG_CONFIG);
+	wmb();
+
+	return 0;
+}
+
+static const struct dev_pm_ops alchemy_pci_pmops = {
+	.suspend	= alchemy_pci_suspend,
+	.resume		= alchemy_pci_resume,
+};
+
+#define ALCHEMY_PCICTL_PM	(&alchemy_pci_pmops)
+
+#else
+#define ALCHEMY_PCICTL_PM	NULL
+#endif
+
+static struct platform_driver alchemy_pcictl_driver = {
+	.probe		= alchemy_pci_probe,
+	.driver	= {
+		.name	= "alchemy-pci",
+		.owner	= THIS_MODULE,
+		.pm	= ALCHEMY_PCICTL_PM,
+	},
+};
+
+static int __init alchemy_pci_init(void)
+{
+	/* Au1500/Au1550 have PCI */
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1500:
+	case ALCHEMY_CPU_AU1550:
+		return platform_driver_register(&alchemy_pcictl_driver);
+	}
+	return 0;
+}
+arch_initcall(alchemy_pci_init);
+
+
+int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	struct alchemy_pci_context *ctx = dev->sysdata;
+	if (ctx && ctx->board_map_irq)
+		return ctx->board_map_irq(dev, slot, pin);
+	return -1;
+}
+
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
-- 
1.7.6
