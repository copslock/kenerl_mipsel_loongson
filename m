Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 16:21:35 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:35640 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S22301656AbYJXPVc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2008 16:21:32 +0100
Received: by mo.po.2iij.net (mo30) id m9OFLRXN040224; Sat, 25 Oct 2008 00:21:27 +0900 (JST)
Received: from delta (187.24.30.125.dy.iij4u.or.jp [125.30.24.187])
	by mbox.po.2iij.net (po-mbox305) id m9OFLN5O019408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 Oct 2008 00:21:24 +0900
Date:	Sat, 25 Oct 2008 00:21:24 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] fix rb532 build error
Message-Id: <20081025002124.de64b4f4.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips


arch/mips/pci/fixup-rc32434.c: In function 'pcibios_map_irq':
arch/mips/pci/fixup-rc32434.c:46: error: 'GROUP4_IRQ_BASE' undeclared (first use in this function)
arch/mips/pci/fixup-rc32434.c:46: error: (Each undeclared identifier is reported only once
arch/mips/pci/fixup-rc32434.c:46: error: for each function it appears in.)
make[1]: *** [arch/mips/pci/fixup-rc32434.o] Error 1

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/pci/fixup-rc32434.c linux/arch/mips/pci/fixup-rc32434.c
--- linux-orig/arch/mips/pci/fixup-rc32434.c	2008-10-14 11:21:05.637174807 +0900
+++ linux/arch/mips/pci/fixup-rc32434.c	2008-10-14 10:27:15.158974484 +0900
@@ -29,6 +29,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 
+#include <asm/mach-rc32434/irq.h>
 #include <asm/mach-rc32434/rc32434.h>
 
 static int __devinitdata irq_map[2][12] = {
