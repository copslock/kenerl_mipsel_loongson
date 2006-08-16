Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Aug 2006 15:10:12 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:46896 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20037542AbWHPOKI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Aug 2006 15:10:08 +0100
Received: by mo.po.2iij.net (mo31) id k7GEA6PI060197; Wed, 16 Aug 2006 23:10:06 +0900 (JST)
Received: from localhost.localdomain (191.28.30.125.dy.iij4u.or.jp [125.30.28.191])
	by mbox.po.2iij.net (mbox32) id k7GEA0rs020291
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 16 Aug 2006 23:10:00 +0900 (JST)
Date:	Wed, 16 Aug 2006 23:10:00 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] removed F_SETSIG and F_GETSIG
Message-Id: <20060816231000.0ade8f96.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

F_SETSIG and F_GETSIG are already defined in asm-generic/fcntl.h

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/fcntl.h mips/include/asm-mips/fcntl.h
--- mips-orig/include/asm-mips/fcntl.h	2006-08-07 00:51:04.347826750 +0900
+++ mips/include/asm-mips/fcntl.h	2006-08-07 00:49:09.836670250 +0900
@@ -25,8 +25,6 @@
 
 #define F_SETOWN	24	/*  for sockets. */
 #define F_GETOWN	23	/*  for sockets. */
-#define F_SETSIG	10	/*  for sockets. */
-#define F_GETSIG	11	/*  for sockets. */
 
 #ifndef __mips64
 #define F_GETLK64	33	/*  using 'struct flock64' */
