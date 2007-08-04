Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Aug 2007 15:26:16 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:54062 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20024440AbXHDO0N (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 4 Aug 2007 15:26:13 +0100
Received: by mo.po.2iij.net (mo30) id l74EOt47066352; Sat, 4 Aug 2007 23:24:55 +0900 (JST)
Received: from localhost.localdomain (231.26.30.125.dy.iij4u.or.jp [125.30.26.231])
	by mbox.po.2iij.net (po-mbox302) id l74EOpmN023783
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 4 Aug 2007 23:24:51 +0900
Date:	Sat, 4 Aug 2007 23:24:51 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] remove unneeded sni_machine_halt
Message-Id: <20070804232451.14382e50.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Remove unneeded sni_machine_halt

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/sni/reset.c mips/arch/mips/sni/reset.c
--- mips-orig/arch/mips/sni/reset.c	2007-08-04 16:17:56.532228000 +0900
+++ mips/arch/mips/sni/reset.c	2007-08-04 16:23:31.429157750 +0900
@@ -40,10 +40,6 @@ void sni_machine_restart(char *command)
 	}
 }
 
-void sni_machine_halt(void)
-{
-}
-
 void sni_machine_power_off(void)
 {
 	*(volatile unsigned char *)PCIMT_CSWCSM = 0xfd;
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/sni/setup.c mips/arch/mips/sni/setup.c
--- mips-orig/arch/mips/sni/setup.c	2007-08-04 16:17:56.532228000 +0900
+++ mips/arch/mips/sni/setup.c	2007-08-04 16:23:41.309775250 +0900
@@ -26,7 +26,6 @@
 unsigned int sni_brd_type;
 
 extern void sni_machine_restart(char *command);
-extern void sni_machine_halt(void);
 extern void sni_machine_power_off(void);
 
 static void __init sni_display_setup(void)
@@ -87,7 +86,6 @@ void __init plat_mem_setup(void)
 	}
 
 	_machine_restart = sni_machine_restart;
-	_machine_halt = sni_machine_halt;
 	pm_power_off = sni_machine_power_off;
 
 	sni_display_setup();
