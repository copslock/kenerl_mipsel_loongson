Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2006 09:40:27 +0000 (GMT)
Received: from mo32.po.2iij.net ([210.128.50.17]:8995 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20039157AbWKAJkZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Nov 2006 09:40:25 +0000
Received: by mo.po.2iij.net (mo32) id kA19eLt8048364; Wed, 1 Nov 2006 18:40:21 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox33) id kA19eFRI099462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 1 Nov 2006 18:40:16 +0900 (JST)
Date:	Wed, 1 Nov 2006 18:40:15 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] remove extra definitions for pb1200
Message-Id: <20061101184015.3187ded8.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has removed extra definitions.
These definitions are defined twice.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/au1000/pb1200/board_setup.c mips/arch/mips/au1000/pb1200/board_setup.c
--- mips-orig/arch/mips/au1000/pb1200/board_setup.c	2006-11-01 14:58:06.339820500 +0900
+++ mips/arch/mips/au1000/pb1200/board_setup.c	2006-11-01 14:57:26.749346250 +0900
@@ -56,7 +56,7 @@
 
 extern char *prom_getcmdline(void);
 extern void _board_init_irq(void);
-extern void	(*board_init_irq)(void);
+extern void (*board_init_irq)(void);
 
 void board_reset (void)
 {
@@ -152,11 +152,7 @@ void __init board_setup(void)
 #endif
 
 	/* Setup Pb1200 External Interrupt Controller */
-	{
-		extern void (*board_init_irq)(void);
-		extern void _board_init_irq(void);
-		board_init_irq = _board_init_irq;
-	}
+	board_init_irq = _board_init_irq;
 }
 
 int
