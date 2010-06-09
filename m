Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jun 2010 13:22:43 +0200 (CEST)
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:37225 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S2097169Ab0FILWP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Jun 2010 13:22:15 +0200
Received: from faui49h (faui49h.informatik.uni-erlangen.de [131.188.42.58])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 1199E5F26E;
        Wed,  9 Jun 2010 13:22:14 +0200 (MEST)
Received: by faui49h (sSMTP sendmail emulation); Wed, 09 Jun 2010 13:22:14 +0200
Date:   Wed, 9 Jun 2010 13:22:14 +0200
From:   Christoph Egger <siccegge@cs.fau.de>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     vamos@i4.informatik.uni-erlangen.de
Subject: [PATCH 6/9] Removing dead CONFIG_I2C_PNX0105
Message-ID: <e58860bae0d4571f3932df24fb6db0757bc260fe.1275925108.git.siccegge@cs.fau.de>
References: <cover.1275925108.git.siccegge@cs.fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1275925108.git.siccegge@cs.fau.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 27106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: siccegge@cs.fau.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6342

CONFIG_I2C_PNX0105 doesn't exist in Kconfig, therefore removing all
references for it from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
 arch/mips/nxp/pnx833x/common/platform.c |   73 -------------------------------
 1 files changed, 0 insertions(+), 73 deletions(-)

diff --git a/arch/mips/nxp/pnx833x/common/platform.c b/arch/mips/nxp/pnx833x/common/platform.c
index 01f8345..2698d19 100644
--- a/arch/mips/nxp/pnx833x/common/platform.c
+++ b/arch/mips/nxp/pnx833x/common/platform.c
@@ -33,11 +33,6 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 
-#ifdef CONFIG_I2C_PNX0105
-/* Until i2c driver available in kernel.*/
-#include <linux/i2c-pnx0105.h>
-#endif
-
 #include <irq.h>
 #include <irq-mapping.h>
 #include <pnx833x.h>
@@ -134,70 +129,6 @@ static struct platform_device pnx833x_usb_ehci_device = {
 	.resource	= pnx833x_usb_ehci_resources,
 };
 
-#ifdef CONFIG_I2C_PNX0105
-static struct resource pnx833x_i2c0_resources[] = {
-	{
-		.start		= PNX833X_I2C0_PORTS_START,
-		.end		= PNX833X_I2C0_PORTS_END,
-		.flags		= IORESOURCE_MEM,
-	},
-	{
-		.start		= PNX833X_PIC_I2C0_INT,
-		.end		= PNX833X_PIC_I2C0_INT,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static struct resource pnx833x_i2c1_resources[] = {
-	{
-		.start		= PNX833X_I2C1_PORTS_START,
-		.end		= PNX833X_I2C1_PORTS_END,
-		.flags		= IORESOURCE_MEM,
-	},
-	{
-		.start		= PNX833X_PIC_I2C1_INT,
-		.end		= PNX833X_PIC_I2C1_INT,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static struct i2c_pnx0105_dev pnx833x_i2c_dev[] = {
-	{
-		.base = PNX833X_I2C0_PORTS_START,
-		.irq = -1, /* should be PNX833X_PIC_I2C0_INT but polling is faster */
-		.clock = 6,	/* 0 == 400 kHz, 4 == 100 kHz(Maximum HDMI), 6 = 50kHz(Prefered HDCP) */
-		.bus_addr = 0,	/* no slave support */
-	},
-	{
-		.base = PNX833X_I2C1_PORTS_START,
-		.irq = -1,	/* on high freq, polling is faster */
-		/*.irq = PNX833X_PIC_I2C1_INT,*/
-		.clock = 4,	/* 0 == 400 kHz, 4 == 100 kHz. 100 kHz seems a safe default for now */
-		.bus_addr = 0,	/* no slave support */
-	},
-};
-
-static struct platform_device pnx833x_i2c0_device = {
-	.name		= "i2c-pnx0105",
-	.id		= 0,
-	.dev = {
-		.platform_data = &pnx833x_i2c_dev[0],
-	},
-	.num_resources  = ARRAY_SIZE(pnx833x_i2c0_resources),
-	.resource	= pnx833x_i2c0_resources,
-};
-
-static struct platform_device pnx833x_i2c1_device = {
-	.name		= "i2c-pnx0105",
-	.id		= 1,
-	.dev = {
-		.platform_data = &pnx833x_i2c_dev[1],
-	},
-	.num_resources  = ARRAY_SIZE(pnx833x_i2c1_resources),
-	.resource	= pnx833x_i2c1_resources,
-};
-#endif
-
 static u64 ethernet_dmamask = DMA_BIT_MASK(32);
 
 static struct resource pnx833x_ethernet_resources[] = {
@@ -297,10 +228,6 @@ static struct platform_device pnx833x_flash_nand = {
 static struct platform_device *pnx833x_platform_devices[] __initdata = {
 	&pnx833x_uart_device,
 	&pnx833x_usb_ehci_device,
-#ifdef CONFIG_I2C_PNX0105
-	&pnx833x_i2c0_device,
-	&pnx833x_i2c1_device,
-#endif
 	&pnx833x_ethernet_device,
 	&pnx833x_sata_device,
 	&pnx833x_flash_nand,
-- 
1.6.3.3
