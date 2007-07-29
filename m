Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jul 2007 13:18:42 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:34322 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022738AbXG2MSk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 29 Jul 2007 13:18:40 +0100
Received: by mo.po.2iij.net (mo31) id l6TCHLgq053370; Sun, 29 Jul 2007 21:17:21 +0900 (JST)
Received: from localhost.localdomain (231.26.30.125.dy.iij4u.or.jp [125.30.26.231])
	by mbox.po.2iij.net (po-mbox301) id l6TCHJMN024825
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 29 Jul 2007 21:17:20 +0900
Date:	Sun, 29 Jul 2007 21:17:18 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] remove unused GROUP_TOSHIBA_NAMES
Message-Id: <20070729211718.4a2b52e2.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Remove unused GROUP_TOSHIBA_NAMES.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/bootinfo.h mips/include/asm-mips/bootinfo.h
--- mips-orig/include/asm-mips/bootinfo.h	2007-07-29 20:36:29.970282000 +0900
+++ mips/include/asm-mips/bootinfo.h	2007-07-29 20:54:33.285985000 +0900
@@ -145,9 +145,6 @@
 #define  MACH_TOSHIBA_RBTX4937	5
 #define  MACH_TOSHIBA_RBTX4938	6
 
-#define GROUP_TOSHIBA_NAMES	{ "Pallas", "TopasCE", "JMR", "JMR TX3927", \
-				  "RBTX4927", "RBTX4937" }
-
 /*
  * Valid machtype for group Alchemy
  */
