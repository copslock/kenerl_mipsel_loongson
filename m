Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2007 15:02:42 +0100 (BST)
Received: from mo30.po.2iij.NET ([210.128.50.53]:15115 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022760AbXEUOCk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 21 May 2007 15:02:40 +0100
Received: by mo.po.2iij.net (mo30) id l4LE2cOF064065; Mon, 21 May 2007 23:02:38 +0900 (JST)
Received: from localhost.localdomain (70.27.30.125.dy.iij4u.or.jp [125.30.27.70])
	by mbox.po.2iij.net (mbox32) id l4LE2Zvr014181
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 21 May 2007 23:02:36 +0900 (JST)
Date:	Mon, 21 May 2007 23:02:34 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] add io_map_base to pci_controller on Cobalt
Message-Id: <20070521230234.41e0c463.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15105
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has added io_map_base to pci_controller on Cobalt.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/pci.c mips/arch/mips/cobalt/pci.c
--- mips-orig/arch/mips/cobalt/pci.c	2007-05-20 19:54:15.700322500 +0900
+++ mips/arch/mips/cobalt/pci.c	2007-05-20 20:57:51.889937250 +0900
@@ -35,6 +35,7 @@ static struct pci_controller cobalt_pci_
 	.mem_resource	= &cobalt_mem_resource,
 	.io_resource	= &cobalt_io_resource,
 	.io_offset	= 0 - GT_DEF_PCI0_IO_BASE,
+	.io_map_base	= CKSEG1ADDR(GT_DEF_PCI0_IO_BASE),
 };
 
 static int __init cobalt_pci_init(void)
