Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 13:22:08 +0000 (GMT)
Received: from mo31.po.2iij.net ([210.128.50.54]:7468 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S28573724AbWLANVH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Dec 2006 13:21:07 +0000
Received: by mo.po.2iij.net (mo31) id kB1DL46T030724; Fri, 1 Dec 2006 22:21:04 +0900 (JST)
Received: from localhost.localdomain (133.25.30.125.dy.iij4u.or.jp [125.30.25.133])
	by mbox.po.2iij.net (mbox32) id kB1DL16M027748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 1 Dec 2006 22:21:01 +0900 (JST)
Date:	Fri, 1 Dec 2006 22:16:01 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2/5] MIPS: remove unused resources for cobalt
Message-Id: <20061201221601.3aa34024.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20061201221242.261f57b0.yoichi_yuasa@tripeaks.co.jp>
References: <20061201221242.261f57b0.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has removed unused resources for cobalt.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/setup.c mips/arch/mips/cobalt/setup.c
--- mips-orig/arch/mips/cobalt/setup.c	2006-10-12 01:03:59.401472250 +0900
+++ mips/arch/mips/cobalt/setup.c	2006-10-12 01:05:36.454992750 +0900
@@ -79,37 +79,19 @@ static struct resource cobalt_io_resourc
 	.flags	= IORESOURCE_IO
 };
 
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
+/*
+ * Cobalt doesn't have PS/2 keyboard/mouse interfaces,
+ * keyboard conntroller is never used.
+ */
+static struct resource cobalt_reserved_resources[] = {
+	{	/* keyboard */
 		.start	= 0x60,
 		.end	= 0x6f,
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
+		.name	= "reserved",
+		.flags	= IORESOURCE_BUSY,
 	},
 };
 
-#define COBALT_IO_RESOURCES (sizeof(cobalt_io_resources)/sizeof(struct resource))
-
 static struct pci_controller cobalt_pci_controller = {
 	.pci_ops	= &gt64111_pci_ops,
 	.mem_resource	= &cobalt_mem_resource,
@@ -132,9 +114,9 @@ void __init plat_mem_setup(void)
 
 	ioport_resource.end = 0xffff;
 
-	/* request I/O space for devices used on all i[345]86 PCs */
-	for (i = 0; i < COBALT_IO_RESOURCES; i++)
-		request_resource(&ioport_resource, cobalt_io_resources + i);
+	/* These resources have been reserved by VIA SuperI/O chip. */
+	for (i = 0; i < ARRAY_SIZE(cobalt_reserved_resources); i++)
+		request_resource(&ioport_resource, cobalt_reserved_resources + i);
 
         /* Read the cobalt id register out of the PCI config space */
         PCI_CFG_SET(devfn, (VIA_COBALT_BRD_ID_REG & ~0x3));
