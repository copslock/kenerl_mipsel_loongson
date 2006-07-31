Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jul 2006 15:06:38 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:48967 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8126920AbWGaOFi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 31 Jul 2006 15:05:38 +0100
Received: by mo.po.2iij.net (mo31) id k6VE5YwV082474; Mon, 31 Jul 2006 23:05:34 +0900 (JST)
Received: from localhost.localdomain (8.26.30.125.dy.iij4u.or.jp [125.30.26.8])
	by mbox.po.2iij.net (mbox32) id k6VE5Wlt094537
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 31 Jul 2006 23:05:32 +0900 (JST)
Date:	Mon, 31 Jul 2006 23:01:37 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] changed common definitions to using asm-generic/signal.h
Message-Id: <20060731230137.494dfb3e.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has changed common definitions to using asm-generic/signal.h .
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/signal.h mips/include/asm-mips/signal.h
--- mips-orig/include/asm-mips/signal.h	2006-07-25 14:34:52.507500500 +0900
+++ mips/include/asm-mips/signal.h	2006-07-25 14:49:34.814641250 +0900
@@ -111,14 +111,7 @@ typedef unsigned long old_sigset_t;		/* 
 #define SIG_SETMASK32	256	/* Goodie from SGI for BSD compatibility:
 				   set only the low 32 bit of the sigset.  */
 
-/* Type of a signal handler.  */
-typedef void __signalfn_t(int);
-typedef __signalfn_t __user *__sighandler_t;
-
-/* Fake signal functions */
-#define SIG_DFL	((__sighandler_t)0)	/* default signal handling */
-#define SIG_IGN	((__sighandler_t)1)	/* ignore signal */
-#define SIG_ERR	((__sighandler_t)-1)	/* error return from signal */
+#include <asm-generic/signal.h>
 
 struct sigaction {
 	unsigned int	sa_flags;
