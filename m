Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jul 2010 10:57:36 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:35323 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491970Ab0GEI5b (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 5 Jul 2010 10:57:31 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o658vNC9006093;
        Mon, 5 Jul 2010 09:57:24 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o658vKnO006092;
        Mon, 5 Jul 2010 09:57:20 +0100
Date:   Mon, 5 Jul 2010 09:57:20 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Christoph Egger <siccegge@cs.fau.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, vamos@i4.informatik.uni-erlangen.de
Subject: Re: [PATCH 6/9] Removing dead CONFIG_I2C_PNX0105
Message-ID: <20100705085719.GA4461@linux-mips.org>
References: <cover.1275925108.git.siccegge@cs.fau.de>
 <e58860bae0d4571f3932df24fb6db0757bc260fe.1275925108.git.siccegge@cs.fau.de>
 <AANLkTind_RjQ5X2zR1fhTgKuLOU4Kbve3uQlgGMI559X@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTind_RjQ5X2zR1fhTgKuLOU4Kbve3uQlgGMI559X@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 09, 2010 at 01:47:33PM +0200, Manuel Lauss wrote:

> The code should probably just be adjusted to use the i2c-pnx driver.
> According to the comments it supports the pnx0105 i2c cell.

So something like this then.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/pnx833x/common/platform.c |   12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

Index: linux-queue/arch/mips/pnx833x/common/platform.c
===================================================================
--- linux-queue.orig/arch/mips/pnx833x/common/platform.c
+++ linux-queue/arch/mips/pnx833x/common/platform.c
@@ -24,6 +24,7 @@
  */
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
+#include <linux/i2c-pnx.h>
 #include <linux/platform_device.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -33,11 +34,6 @@
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
@@ -134,7 +130,6 @@ static struct platform_device pnx833x_us
 	.resource	= pnx833x_usb_ehci_resources,
 };
 
-#ifdef CONFIG_I2C_PNX0105
 static struct resource pnx833x_i2c0_resources[] = {
 	{
 		.start		= PNX833X_I2C0_PORTS_START,
@@ -188,7 +183,7 @@ static struct platform_device pnx833x_i2
 };
 
 static struct platform_device pnx833x_i2c1_device = {
-	.name		= "i2c-pnx0105",
+	.name		= "pnx-i2c",
 	.id		= 1,
 	.dev = {
 		.platform_data = &pnx833x_i2c_dev[1],
@@ -196,7 +191,6 @@ static struct platform_device pnx833x_i2
 	.num_resources  = ARRAY_SIZE(pnx833x_i2c1_resources),
 	.resource	= pnx833x_i2c1_resources,
 };
-#endif
 
 static u64 ethernet_dmamask = DMA_BIT_MASK(32);
 
@@ -297,10 +291,8 @@ static struct platform_device pnx833x_fl
 static struct platform_device *pnx833x_platform_devices[] __initdata = {
 	&pnx833x_uart_device,
 	&pnx833x_usb_ehci_device,
-#ifdef CONFIG_I2C_PNX0105
 	&pnx833x_i2c0_device,
 	&pnx833x_i2c1_device,
-#endif
 	&pnx833x_ethernet_device,
 	&pnx833x_sata_device,
 	&pnx833x_flash_nand,
