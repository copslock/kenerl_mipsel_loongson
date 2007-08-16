Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2007 14:27:57 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:12848 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021952AbXHPN1s (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 16 Aug 2007 14:27:48 +0100
Received: by mo.po.2iij.net (mo32) id l7GDRjPq089562; Thu, 16 Aug 2007 22:27:45 +0900 (JST)
Received: from localhost.localdomain (231.26.30.125.dy.iij4u.or.jp [125.30.26.231])
	by mbox.po.2iij.net (po-mbox301) id l7GDRes4029052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 16 Aug 2007 22:27:40 +0900
Date:	Thu, 16 Aug 2007 22:20:11 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS][1/2] vr41xx: add default restart routine
Message-Id: <20070816222011.496f6eb8.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Add vr41xx default restart routine.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/vr41xx/common/pmu.c mips/arch/mips/vr41xx/common/pmu.c
--- mips-orig/arch/mips/vr41xx/common/pmu.c	2007-08-06 13:07:41.877342750 +0900
+++ mips/arch/mips/vr41xx/common/pmu.c	2007-08-06 13:16:26.430125250 +0900
@@ -25,6 +25,7 @@
 #include <linux/sched.h>
 #include <linux/types.h>
 
+#include <asm/cacheflush.h>
 #include <asm/cpu.h>
 #include <asm/io.h>
 #include <asm/processor.h>
@@ -70,6 +71,11 @@ static inline void software_reset(void)
 		pmu_write(PMUCNT2REG, pmucnt2);
 		break;
 	default:
+		set_c0_status(ST0_BEV | ST0_ERL);
+		change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
+		flush_cache_all();
+		write_c0_wired(0);
+		__asm__("jr     %0"::"r"(0xbfc00000));
 		break;
 	}
 }
@@ -78,7 +84,6 @@ static void vr41xx_restart(char *command
 {
 	local_irq_disable();
 	software_reset();
-	printk(KERN_NOTICE "\nYou can reset your system\n");
 	while (1) ;
 }
 
