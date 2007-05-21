Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2007 15:00:46 +0100 (BST)
Received: from mo30.po.2iij.NET ([210.128.50.53]:3632 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022754AbXEUOAo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 21 May 2007 15:00:44 +0100
Received: by mo.po.2iij.net (mo30) id l4LE0f0j063640; Mon, 21 May 2007 23:00:41 +0900 (JST)
Received: from localhost.localdomain (70.27.30.125.dy.iij4u.or.jp [125.30.27.70])
	by mbox.po.2iij.net (mbox32) id l4LE0dtW013141
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 21 May 2007 23:00:39 +0900 (JST)
Date:	Mon, 21 May 2007 23:00:38 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] remove unused definitions for Cobalt
Message-Id: <20070521230038.6db3e41c.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has removed unused definitions for Cobalt.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/mach-cobalt/cobalt.h mips/include/asm-mips/mach-cobalt/cobalt.h
--- mips-orig/include/asm-mips/mach-cobalt/cobalt.h	2007-05-20 21:04:15.739105500 +0900
+++ mips/include/asm-mips/mach-cobalt/cobalt.h	2007-05-20 21:18:24.688161500 +0900
@@ -30,7 +30,6 @@
 #define COBALT_CPU_IRQ		MIPS_CPU_IRQ_BASE
 
 #define COBALT_GALILEO_IRQ	(COBALT_CPU_IRQ + 2)
-#define COBALT_SCC_IRQ          (COBALT_CPU_IRQ + 3)	/* pre-production has 85C30 */
 #define COBALT_RAQ_SCSI_IRQ	(COBALT_CPU_IRQ + 3)
 #define COBALT_ETH0_IRQ		(COBALT_CPU_IRQ + 3)
 #define COBALT_QUBE1_ETH0_IRQ	(COBALT_CPU_IRQ + 4)
@@ -71,10 +70,6 @@
 
 extern int cobalt_board_id;
 
-#define PCI_CFG_SET(devfn,where)					\
-	GT_WRITE(GT_PCI0_CFGADDR_OFS, (0x80000000 | (PCI_SLOT (devfn) << 11) |		\
-		(PCI_FUNC (devfn) << 8) | (where)))
-
 #define COBALT_LED_PORT		(*(volatile unsigned char *) CKSEG1ADDR(0x1c000000))
 # define COBALT_LED_BAR_LEFT	(1 << 0)	/* Qube */
 # define COBALT_LED_BAR_RIGHT	(1 << 1)	/* Qube */
