Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Aug 2006 15:02:14 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:56128 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038742AbWHVN6w (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Aug 2006 14:58:52 +0100
Received: by mo.po.2iij.net (mo31) id k7MDwoci075955; Tue, 22 Aug 2006 22:58:50 +0900 (JST)
Received: from localhost.localdomain (191.28.30.125.dy.iij4u.or.jp [125.30.28.191])
	by mbox.po.2iij.net (mbox33) id k7MDwmWx012235
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 Aug 2006 22:58:48 +0900 (JST)
Date:	Tue, 22 Aug 2006 22:57:55 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 9/12] removed unused resources for Cobalt
Message-Id: <20060822225755.55a055c0.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has removed unused resources for Cobalt.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/cobalt/setup.c mips/arch/mips/gt64120/cobalt/setup.c
--- mips-orig/arch/mips/gt64120/cobalt/setup.c	2006-08-21 23:02:23.229549750 +0900
+++ mips/arch/mips/gt64120/cobalt/setup.c	2006-08-21 23:00:31.314534000 +0900
@@ -49,42 +49,10 @@ void __init plat_timer_setup(struct irqa
 	setup_irq(COBALT_TIMER3_IRQ, irq);
 }
 
-static struct resource cobalt_io_resources[] = {
-	{
-		.start	= 0x00,
-		.end	= 0x1f,
-		.name	= "dma1",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x40,
-		.end	= 0x5f,
-		.name	= "timer",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x60,
-		.end	= 0x6f,
-		.name	= "keyboard",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x80,
-		.end	= 0x8f,
-		.name	= "dma page reg",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0xc0,
-		.end	= 0xdf,
-		.name	= "dma2",
-		.flags	= IORESOURCE_BUSY
-	},
-};
-
-#define COBALT_IO_RESOURCES (sizeof(cobalt_io_resources)/sizeof(struct resource))
-
 void __init plat_mem_setup(void)
 {
 	static struct uart_port uart;
 	unsigned int devfn = PCI_DEVFN(COBALT_PCICONF_VIA, 0);
-	int i;
 
 	gt641xx_disable_alltimers();
 	board_time_init = gt641xx_timer3_init;
@@ -93,10 +61,6 @@ void __init plat_mem_setup(void)
 
 	ioport_resource.end = 0xffff;
 
-	/* request I/O space for devices used on all i[345]86 PCs */
-	for (i = 0; i < COBALT_IO_RESOURCES; i++)
-		request_resource(&ioport_resource, cobalt_io_resources + i);
-
         /* Read the cobalt id register out of the PCI config space */
         PCI_CFG_SET(devfn, (VIA_COBALT_BRD_ID_REG & ~0x3));
         cobalt_board_id = GT_READ(GT_PCI0_CFGDATA_OFS);
