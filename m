Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2007 09:15:46 +0100 (BST)
Received: from mo32.po.2iij.NET ([210.128.50.17]:54088 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021569AbXINIPi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 14 Sep 2007 09:15:38 +0100
Received: by mo.po.2iij.net (mo32) id l8E8FZLS037354; Fri, 14 Sep 2007 17:15:35 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox302) id l8E8FV2K026455
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 14 Sep 2007 17:15:32 +0900
Message-Id: <200709140815.l8E8FV2K026455@po-mbox302.po.2iij.net>
Date:	Fri, 14 Sep 2007 17:14:35 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][4/9][MIPS] add cpu_wait to cobalt_machine_halt.
In-Reply-To: <20070914164228.333da5d9.yoichi_yuasa@tripeaks.co.jp>
References: <20070914164228.333da5d9.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Add cpu_wait to cobalt_machine_halt.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/reset.c mips/arch/mips/cobalt/reset.c
--- mips-orig/arch/mips/cobalt/reset.c	2007-09-14 16:14:16.279524250 +0900
+++ mips/arch/mips/cobalt/reset.c	2007-09-14 16:15:40.136765000 +0900
@@ -11,13 +11,18 @@
 #include <linux/irqflags.h>
 #include <linux/kernel.h>
 
+#include <asm/processor.h>
+
 #include <cobalt.h>
 
 void cobalt_machine_halt(void)
 {
 	local_irq_disable();
 	printk("You can switch the machine off now.\n");
-	while (1) ;
+	while (1) {
+		if (cpu_wait)
+			cpu_wait();
+	}
 }
 
 void cobalt_machine_restart(char *command)
