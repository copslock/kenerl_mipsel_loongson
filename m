Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2007 15:16:00 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:56874 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021968AbXHPOPv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 16 Aug 2007 15:15:51 +0100
Received: by mo.po.2iij.net (mo32) id l7GEFng4000850; Thu, 16 Aug 2007 23:15:49 +0900 (JST)
Received: from localhost.localdomain (231.26.30.125.dy.iij4u.or.jp [125.30.26.231])
	by mbox.po.2iij.net (po-mbox300) id l7GEFho2027320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 16 Aug 2007 23:15:43 +0900
Date:	Thu, 16 Aug 2007 23:15:42 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] fix ABI check in include/asm-mips/arv/hinv.h
Message-Id: <20070816231542.60ab56ee.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Fix ABI check in include/asm-mips/arv/hinv.h

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/arc/hinv.h mips/include/asm-mips/arc/hinv.h
--- mips-orig/include/asm-mips/arc/hinv.h	2007-08-16 23:09:37.983572250 +0900
+++ mips/include/asm-mips/arc/hinv.h	2007-08-16 23:08:37.975822000 +0900
@@ -4,6 +4,7 @@
 #ifndef _ASM_ARC_HINV_H
 #define _ASM_ARC_HINV_H
 
+#include <asm/sgidefs.h>
 #include <asm/arc/types.h>
 
 /* configuration query defines */
@@ -110,7 +111,7 @@ union key_u {
 	ULONG FullKey;
 };
 
-#if _MIPS_SIM == _ABI64
+#if _MIPS_SIM == _MIPS_SIM_ABI64
 #define SGI_ARCS_VERS	64			/* sgi 64-bit version */
 #define SGI_ARCS_REV	0			/* rev .00 */
 #else
