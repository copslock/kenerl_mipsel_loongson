Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Mar 2007 13:51:56 +0000 (GMT)
Received: from mo31.po.2iij.net ([210.128.50.54]:30499 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20039214AbXCANvu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 1 Mar 2007 13:51:50 +0000
Received: by mo.po.2iij.net (mo31) id l21DoTUQ067439; Thu, 1 Mar 2007 22:50:29 +0900 (JST)
Received: from localhost.localdomain (70.27.30.125.dy.iij4u.or.jp [125.30.27.70])
	by mbox.po.2iij.net (mbox32) id l21DoPRx060162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 1 Mar 2007 22:50:26 +0900 (JST)
Date:	Thu, 1 Mar 2007 22:50:25 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] update Cobalt reserved resource
Message-Id: <20070301225025.7612e583.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has removed unused timer resource.
Moreover, the name of reserved resources ware changed.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/setup.c mips/arch/mips/cobalt/setup.c
--- mips-orig/arch/mips/cobalt/setup.c	2006-12-09 21:03:07.860183750 +0900
+++ mips/arch/mips/cobalt/setup.c	2006-12-09 21:44:28.215782000 +0900
@@ -79,37 +79,38 @@ static struct resource cobalt_io_resourc
 	.flags	= IORESOURCE_IO
 };
 
-static struct resource cobalt_io_resources[] = {
-	{
+/*
+ * Cobalt doesn't have PS/2 keyboard/mouse interfaces,
+ * keyboard conntroller is never used.
+ * Also PCI-ISA bridge DMA contoroller is never used.
+ */
+static struct resource cobalt_reserved_resources[] = {
+	{	/* dma1 */
 		.start	= 0x00,
 		.end	= 0x1f,
-		.name	= "dma1",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x40,
-		.end	= 0x5f,
-		.name	= "timer",
-		.flags	= IORESOURCE_BUSY
-	}, {
+		.name	= "reserved",
+		.flags	= IORESOURCE_BUSY | IORESOURCE_IO,
+	},
+	{	/* keyboard */
 		.start	= 0x60,
 		.end	= 0x6f,
-		.name	= "keyboard",
-		.flags	= IORESOURCE_BUSY
-	}, {
+		.name	= "reserved",
+		.flags	= IORESOURCE_BUSY | IORESOURCE_IO,
+	},
+	{	/* dma page reg */
 		.start	= 0x80,
 		.end	= 0x8f,
-		.name	= "dma page reg",
-		.flags	= IORESOURCE_BUSY
-	}, {
+		.name	= "reserved",
+		.flags	= IORESOURCE_BUSY | IORESOURCE_IO,
+	},
+	{	/* dma2 */
 		.start	= 0xc0,
 		.end	= 0xdf,
-		.name	= "dma2",
-		.flags	= IORESOURCE_BUSY
+		.name	= "reserved",
+		.flags	= IORESOURCE_BUSY | IORESOURCE_IO,
 	},
 };
 
-#define COBALT_IO_RESOURCES (sizeof(cobalt_io_resources)/sizeof(struct resource))
-
 static struct pci_controller cobalt_pci_controller = {
 	.pci_ops	= &gt64111_pci_ops,
 	.mem_resource	= &cobalt_mem_resource,
@@ -133,9 +134,9 @@ void __init plat_mem_setup(void)
 	/* I/O port resource must include LCD/buttons */
 	ioport_resource.end = 0x0fffffff;
 
-	/* request I/O space for devices used on all i[345]86 PCs */
-	for (i = 0; i < COBALT_IO_RESOURCES; i++)
-		request_resource(&ioport_resource, cobalt_io_resources + i);
+	/* These resources have been reserved by VIA SuperI/O chip. */
+	for (i = 0; i < ARRAY_SIZE(cobalt_reserved_resources); i++)
+		request_resource(&ioport_resource, cobalt_reserved_resources + i);
 
         /* Read the cobalt id register out of the PCI config space */
         PCI_CFG_SET(devfn, (VIA_COBALT_BRD_ID_REG & ~0x3));
