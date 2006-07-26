Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jul 2006 15:38:37 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:57348 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133835AbWGZOiZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Jul 2006 15:38:25 +0100
Received: by mo.po.2iij.net (mo32) id k6QEcNxX080597; Wed, 26 Jul 2006 23:38:23 +0900 (JST)
Received: from localhost.localdomain (203.25.30.125.dy.iij4u.or.jp [125.30.25.203])
	by mbox.po.2iij.net (mbox30) id k6QEcHT2089713
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 26 Jul 2006 23:38:18 +0900 (JST)
Date:	Wed, 26 Jul 2006 23:31:02 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] removed unused arc/console.c
Message-Id: <20060726233102.2ae5ba17.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has removed arc/console.c .
This file is not used now.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/arc/console.c mips/arch/mips/arc/console.c
--- mips-orig/arch/mips/arc/console.c	2006-07-26 10:34:31.756177500 +0900
+++ mips/arch/mips/arc/console.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,63 +0,0 @@
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
-
-char prom_getchar(void)
-{
-	ULONG cnt;
-	CHAR c;
-
-	bc_disable();
-	ArcRead(0, &c, 1, &cnt);
-	bc_enable();
-
-	return c;
-}
-
-void prom_printf(char *fmt, ...)
-{
-	va_list args;
-	char ppbuf[1024];
-	char *bptr;
-
-	va_start(args, fmt);
-	vsprintf(ppbuf, fmt, args);
-
-	bptr = ppbuf;
-
-	while (*bptr != 0) {
-		if (*bptr == '\n')
-			prom_putchar('\r');
-
-		prom_putchar(*bptr++);
-	}
-	va_end(args);
-}
