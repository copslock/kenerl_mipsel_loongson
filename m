Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Jul 2006 15:13:52 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:55598 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133544AbWGBONm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 2 Jul 2006 15:13:42 +0100
Received: by mo.po.2iij.net (mo32) id k62EDcng085474; Sun, 2 Jul 2006 23:13:38 +0900 (JST)
Received: from localhost.localdomain (225.29.30.125.dy.iij4u.or.jp [125.30.29.225])
	by mbox.po.2iij.net (mbox31) id k62EDZfu061870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 2 Jul 2006 23:13:35 +0900 (JST)
Date:	Sun, 2 Jul 2006 23:13:34 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] vr41xx: removed unused definitions for NEC CMBVR4133
Message-Id: <20060702231334.082d5374.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has removed unused definitions for NEC CMBVR4133.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/vr41xx/cmbvr4133.h mips/include/asm-mips/vr41xx/cmbvr4133.h
--- mips-orig/include/asm-mips/vr41xx/cmbvr4133.h	2006-07-01 23:41:40.393059500 +0900
+++ mips/include/asm-mips/vr41xx/cmbvr4133.h	2006-07-01 23:45:11.882276750 +0900
@@ -55,7 +55,4 @@
 #define IDE_SECONDARY_IRQ		I8259_IRQ(15)
 #define I8259_IRQ_LAST			IDE_SECONDARY_IRQ
 
-#define RTC_PORT(x)	(0xaf000100 + (x))
-#define RTC_IO_EXTENT	0x140
-
 #endif /* __NEC_CMBVR4133_H */
