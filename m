Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2008 14:39:44 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:1070 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20031319AbYGKNjm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2008 14:39:42 +0100
Received: by mo.po.2iij.net (mo30) id m6BDdd3G081566; Fri, 11 Jul 2008 22:39:39 +0900 (JST)
Received: from delta (61.25.30.125.dy.iij4u.or.jp [125.30.25.61])
	by mbox.po.2iij.net (po-mbox305) id m6BDdckC014749
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 11 Jul 2008 22:39:38 +0900
Date:	Fri, 11 Jul 2008 22:39:14 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 1/2][MIPS] replace inline assembler to cpu_wait()
Message-Id: <20080711223914.a9db2eca.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Replace inline assembler to cpu_wait().

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/gt64120/wrppmc/reset.c linux/arch/mips/gt64120/wrppmc/reset.c
--- linux-orig/arch/mips/gt64120/wrppmc/reset.c	2008-07-08 10:12:29.899943226 +0900
+++ linux/arch/mips/gt64120/wrppmc/reset.c	2008-07-08 13:32:37.836100230 +0900
@@ -5,10 +5,12 @@
  *
  * Copyright (C) 1997 Ralf Baechle
  */
+#include <linux/irqflags.h>
 #include <linux/kernel.h>
 
 #include <asm/cacheflush.h>
 #include <asm/mipsregs.h>
+#include <asm/processor.h>
 
 void wrppmc_machine_restart(char *command)
 {
@@ -32,11 +34,8 @@ void wrppmc_machine_halt(void)
 
 	printk(KERN_NOTICE "You can safely turn off the power\n");
 	while (1) {
-		__asm__(
-			".set\tmips3\n\t"
-			"wait\n\t"
-			".set\tmips0"
-		);
+		if (cpu_wait)
+			cpu_wait();
 	}
 }
 
