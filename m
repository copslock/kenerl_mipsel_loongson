Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jul 2006 14:16:48 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:3080 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133491AbWGDNQh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Jul 2006 14:16:37 +0100
Received: by mo.po.2iij.net (mo31) id k64DGWYa027537; Tue, 4 Jul 2006 22:16:33 +0900 (JST)
Received: from localhost.localdomain (225.29.30.125.dy.iij4u.or.jp [125.30.29.225])
	by mbox.po.2iij.net (mbox31) id k64DGTr4012212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 4 Jul 2006 22:16:30 +0900 (JST)
Date:	Tue, 4 Jul 2006 22:16:28 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] fixed build error about mips-mt.c
Message-Id: <20060704221628.4b878943.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has fixed a build error about mips-mt.c .

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>


diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/kernel/mips-mt.c mips/arch/mips/kernel/mips-mt.c
--- mips-orig/arch/mips/kernel/mips-mt.c	2006-07-04 11:54:18.241298000 +0900
+++ mips/arch/mips/kernel/mips-mt.c	2006-07-04 11:28:57.834278500 +0900
@@ -7,6 +7,7 @@
 #include <linux/sched.h>
 #include <linux/cpumask.h>
 #include <linux/interrupt.h>
+#include <linux/security.h>
 
 #include <asm/cpu.h>
 #include <asm/processor.h>
