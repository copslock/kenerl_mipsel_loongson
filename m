Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Aug 2007 15:28:21 +0100 (BST)
Received: from mo32.po.2iij.NET ([210.128.50.17]:1356 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20024444AbXHDO2S (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 4 Aug 2007 15:28:18 +0100
Received: by mo.po.2iij.net (mo32) id l74ER0Ko046420; Sat, 4 Aug 2007 23:27:00 +0900 (JST)
Received: from localhost.localdomain (231.26.30.125.dy.iij4u.or.jp [125.30.26.231])
	by mbox.po.2iij.net (po-mbox303) id l74EQs3t017054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 4 Aug 2007 23:26:54 +0900
Date:	Sat, 4 Aug 2007 23:26:53 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] remove unused pcimt_scache.c
Message-Id: <20070804232653.603224ab.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Remove unused pcimt_scache.c

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/sni/pcimt_scache.c mips/arch/mips/sni/pcimt_scache.c
--- mips-orig/arch/mips/sni/pcimt_scache.c	2007-08-04 16:17:56.532228000 +0900
+++ mips/arch/mips/sni/pcimt_scache.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,37 +0,0 @@
-/*
- * arch/mips/sni/pcimt_scache.c
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (c) 1997, 1998 by Ralf Baechle
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <asm/bcache.h>
-#include <asm/sni.h>
-
-#define cacheconf (*(volatile unsigned int *)PCIMT_CACHECONF)
-#define invspace (*(volatile unsigned int *)PCIMT_INVSPACE)
-
-void __init sni_pcimt_sc_init(void)
-{
-	unsigned int scsiz, sc_size;
-
-	scsiz = cacheconf & 7;
-	if (scsiz == 0) {
-		printk("Second level cache is deactived.\n");
-		return;
-	}
-	if (scsiz >= 6) {
-		printk("Invalid second level cache size configured, "
-		       "deactivating second level cache.\n");
-		cacheconf = 0;
-		return;
-	}
-
-	sc_size = 128 << scsiz;
-	printk("%dkb second level cache detected, deactivating.\n", sc_size);
-	cacheconf = 0;
-}
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/bcache.h mips/include/asm-mips/bcache.h
--- mips-orig/include/asm-mips/bcache.h	2007-08-04 16:19:08.244709750 +0900
+++ mips/include/asm-mips/bcache.h	2007-08-04 20:40:15.299924250 +0900
@@ -21,7 +21,6 @@ struct bcache_ops {
 };
 
 extern void indy_sc_init(void);
-extern void sni_pcimt_sc_init(void);
 
 #ifdef CONFIG_BOARD_SCACHE
 
