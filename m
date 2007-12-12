Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2007 13:25:10 +0000 (GMT)
Received: from mo31.po.2iij.NET ([210.128.50.54]:2343 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20032315AbXLLNZC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 12 Dec 2007 13:25:02 +0000
Received: by mo.po.2iij.net (mo31) id lBCDNiUf081457; Wed, 12 Dec 2007 22:23:44 +0900 (JST)
Received: from delta (224.24.30.125.dy.iij4u.or.jp [125.30.24.224])
	by mbox.po.2iij.net (po-mbox303) id lBCDNfmQ028025
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 12 Dec 2007 22:23:41 +0900
Date:	Wed, 12 Dec 2007 22:23:13 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2/2][MIPS] add cpu_wait() to machine_halt()
Message-Id: <20071212222313.92e69c16.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20071212222019.9ab7b2ed.yoichi_yuasa@tripeaks.co.jp>
References: <20071212222019.9ab7b2ed.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Added cpu_wait() to machine_halt().
For the power reduction in halt.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/reset.c mips/arch/mips/cobalt/reset.c
--- mips-orig/arch/mips/cobalt/reset.c	2007-10-22 09:32:10.074729000 +0900
+++ mips/arch/mips/cobalt/reset.c	2007-10-22 09:59:23.092786250 +0900
@@ -12,6 +12,8 @@
 #include <linux/io.h>
 #include <linux/leds.h>
 
+#include <asm/processor.h>
+
 #include <cobalt.h>
 
 #define RESET_PORT	((void __iomem *)CKSEG1ADDR(0x1c000000))
@@ -35,7 +37,10 @@ void cobalt_machine_halt(void)
 
 	local_irq_disable();
 	printk(KERN_INFO "You can switch the machine off now.\n");
-	while (1) ;
+	while (1) {
+		if (cpu_wait)
+			cpu_wait();
+	}
 }
 
 void cobalt_machine_restart(char *command)
