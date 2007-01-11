Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jan 2007 05:56:09 +0000 (GMT)
Received: from mo31.po.2iij.net ([210.128.50.54]:7200 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20039725AbXAKF4D (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 11 Jan 2007 05:56:03 +0000
Received: by mo.po.2iij.net (mo31) id l0B5txu7032532; Thu, 11 Jan 2007 14:55:59 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox33) id l0B5twHe006668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 11 Jan 2007 14:55:58 +0900 (JST)
Message-Id: <200701110555.l0B5twHe006668@mbox33.po.2iij.net>
Date:	Thu, 11 Jan 2007 14:55:58 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] [MIPS] Fixed PCI resource fixup
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has fixed IDE resources problem about Cobalt.

pcibios_fixup_device_resources() changes non-movable resources.
It cannot be changed if there is IORESOURCE_PCI_FIXED in the resource flags. 

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/pci/pci.c mips/arch/mips/pci/pci.c
--- mips-orig/arch/mips/pci/pci.c	2006-12-18 15:53:10.735222250 +0900
+++ mips/arch/mips/pci/pci.c	2006-12-18 15:56:59.805538250 +0900
@@ -232,7 +232,8 @@ static void __init pcibios_fixup_device_
 	int i;
 
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		if (!dev->resource[i].start)
+		if (!dev->resource[i].start ||
+		    dev->resource[i].flags & IORESOURCE_PCI_FIXED)
 			continue;
 		if (dev->resource[i].flags & IORESOURCE_IO)
 			offset = hose->io_offset;
