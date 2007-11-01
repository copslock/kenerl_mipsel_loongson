Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2007 12:35:55 +0000 (GMT)
Received: from mo32.po.2iij.NET ([210.128.50.17]:5924 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20026738AbXKAMfr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 1 Nov 2007 12:35:47 +0000
Received: by mo.po.2iij.net (mo32) id lA1CZiPI061130; Thu, 1 Nov 2007 21:35:44 +0900 (JST)
Received: from delta (221.25.30.125.dy.iij4u.or.jp [125.30.25.221])
	by mbox.po.2iij.net (po-mbox303) id lA1CZe3S005923
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 1 Nov 2007 21:35:40 +0900
Date:	Thu, 1 Nov 2007 21:35:39 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] clean up au1xxx_irqmap.c include files
Message-Id: <20071101213539.9c47c3e9.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Clean up au1xxx_irqmap.c include files.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/au1000/common/au1xxx_irqmap.c mips/arch/mips/au1000/common/au1xxx_irqmap.c
--- mips-orig/arch/mips/au1000/common/au1xxx_irqmap.c	2007-10-26 23:35:58.350582750 +0900
+++ mips/arch/mips/au1000/common/au1xxx_irqmap.c	2007-10-26 23:54:59.221882750 +0900
@@ -25,27 +25,10 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
-#include <linux/errno.h>
 #include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/kernel_stat.h>
-#include <linux/module.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/timex.h>
-#include <linux/slab.h>
-#include <linux/random.h>
-#include <linux/delay.h>
-#include <linux/bitops.h>
-
-#include <asm/bootinfo.h>
-#include <asm/io.h>
-#include <asm/mipsregs.h>
-#include <asm/system.h>
-#include <asm/mach-au1x00/au1000.h>
+#include <linux/kernel.h>
+
+#include <au1000.h>
 
 /* The IC0 interrupt table.  This is processor, rather than
  * board dependent, so no reason to keep this info in the board
