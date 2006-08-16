Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Aug 2006 15:07:56 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:32033 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20037541AbWHPOHx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Aug 2006 15:07:53 +0100
Received: by mo.po.2iij.net (mo30) id k7GE7n13001296; Wed, 16 Aug 2006 23:07:49 +0900 (JST)
Received: from localhost.localdomain (191.28.30.125.dy.iij4u.or.jp [125.30.28.191])
	by mbox.po.2iij.net (mbox32) id k7GE7lDe019734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 16 Aug 2006 23:07:47 +0900 (JST)
Date:	Wed, 16 Aug 2006 23:07:47 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] removed common definitions in signal.h
Message-Id: <20060816230747.57a1e6d4.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

These definitions are already defined in asm-generic/signal.h .

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
