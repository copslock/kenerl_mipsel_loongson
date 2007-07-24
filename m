Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2007 08:39:27 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:44828 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022940AbXGXHjZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Jul 2007 08:39:25 +0100
Received: by mo.po.2iij.net (mo30) id l6O7c6be030789; Tue, 24 Jul 2007 16:38:06 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox303) id l6O7c3lP031410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 24 Jul 2007 16:38:04 +0900
Date:	Tue, 24 Jul 2007 16:38:04 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] Remove unused arch/mips/arc/console.c
Message-Id: <20070724163804.01073714.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Remove unused arch/mips/arc/console.c

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/arc/console.c mips/arch/mips/arc/console.c
--- mips-orig/arch/mips/arc/console.c	2007-07-23 17:38:10.053280000 +0900
+++ mips/arch/mips/arc/console.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,31 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1996 David S. Miller (dm@sgi.com)
- * Compability with board caches, Ulf Carlsson
- */
-#include <linux/kernel.h>
-#include <asm/sgialib.h>
-#include <asm/bcache.h>
-
-/*
- * IP22 boardcache is not compatible with board caches.  Thus we disable it
- * during romvec action.  Since r4xx0.c is always compiled and linked with your
- * kernel, this shouldn't cause any harm regardless what MIPS processor you
- * have.
- *
- * The ARC write and read functions seem to interfere with the serial lines
- * in some way. You should be careful with them.
- */
-
-void prom_putchar(char c)
-{
-	ULONG cnt;
-	CHAR it = c;
-
-	bc_disable();
-	ArcWrite(1, &it, 1, &cnt);
-	bc_enable();
-}
