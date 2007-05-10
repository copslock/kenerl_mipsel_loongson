Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 May 2007 12:01:03 +0100 (BST)
Received: from mo30.po.2iij.NET ([210.128.50.53]:61998 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022785AbXEJLBB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 10 May 2007 12:01:01 +0100
Received: by mo.po.2iij.net (mo30) id l4AB0vLj020623; Thu, 10 May 2007 20:00:57 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox30) id l4AB0t2A018238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 10 May 2007 20:00:55 +0900 (JST)
Date:	Thu, 10 May 2007 20:00:55 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] add extern cobalt_board_id
Message-Id: <20070510200055.4006b423.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has added extern cobalt_board_id.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X cobalt/Documentation/dontdiff cobalt-orig/arch/mips/pci/fixup-cobalt.c cobalt/arch/mips/pci/fixup-cobalt.c
--- cobalt-orig/arch/mips/pci/fixup-cobalt.c	2007-04-05 17:27:48.585423250 +0900
+++ cobalt/arch/mips/pci/fixup-cobalt.c	2007-04-05 18:05:14.340009750 +0900
@@ -17,9 +17,7 @@
 #include <asm/io.h>
 #include <asm/gt64120.h>
 
-#include <asm/mach-cobalt/cobalt.h>
-
-extern int cobalt_board_id;
+#include <cobalt.h>
 
 static void qube_raq_galileo_early_fixup(struct pci_dev *dev)
 {
diff -pruN -X cobalt/Documentation/dontdiff cobalt-orig/include/asm-mips/mach-cobalt/cobalt.h cobalt/include/asm-mips/mach-cobalt/cobalt.h
--- cobalt-orig/include/asm-mips/mach-cobalt/cobalt.h	2007-04-05 17:28:47.529107000 +0900
+++ cobalt/include/asm-mips/mach-cobalt/cobalt.h	2007-04-05 18:04:30.681281250 +0900
@@ -69,6 +69,8 @@
 #define COBALT_BRD_ID_QUBE2    0x5
 #define COBALT_BRD_ID_RAQ2     0x6
 
+extern int cobalt_board_id;
+
 #define PCI_CFG_SET(devfn,where)					\
 	GT_WRITE(GT_PCI0_CFGADDR_OFS, (0x80000000 | (PCI_SLOT (devfn) << 11) |		\
 		(PCI_FUNC (devfn) << 8) | (where)))
