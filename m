Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jan 2004 03:55:18 +0000 (GMT)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:63983 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225367AbUAGDzP>;
	Wed, 7 Jan 2004 03:55:15 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id MAA26448;
	Wed, 7 Jan 2004 12:55:10 +0900 (JST)
Received: 4UMDO00 id i073tAr07336; Wed, 7 Jan 2004 12:55:10 +0900 (JST)
Received: 4UMRO00 id i073t9a18785; Wed, 7 Jan 2004 12:55:09 +0900 (JST)
	from rally.montavista.co.jp (sonicwall.montavista.co.jp [202.232.97.131]) (authenticated)
Date: Wed, 7 Jan 2004 12:55:09 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.6] add smp.h in processor.h
Message-Id: <20040107125509.34cfa9db.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

I made a patch for header file of 2.6.

smp_processor_id() is defined in smp.h.
We need adding #include <linux/smp.h> in processor.h.

Please apply this patch.

Yoichi

diff -urN -X dontdiff linux-orig/include/asm-mips/processor.h linux/include/asm-mips/processor.h
--- linux-orig/include/asm-mips/processor.h	2003-12-04 10:52:06.000000000 +0900
+++ linux/include/asm-mips/processor.h	2004-01-07 12:24:25.000000000 +0900
@@ -13,6 +13,7 @@
 
 #include <linux/config.h>
 #include <linux/cache.h>
+#include <linux/smp.h>
 #include <linux/threads.h>
 
 #include <asm/cachectl.h>
