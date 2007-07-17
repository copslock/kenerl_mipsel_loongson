Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2007 15:06:39 +0100 (BST)
Received: from mo30.po.2iij.NET ([210.128.50.53]:13106 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021547AbXGQOGe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Jul 2007 15:06:34 +0100
Received: by mo.po.2iij.net (mo30) id l6HE6S9E013268; Tue, 17 Jul 2007 23:06:28 +0900 (JST)
Received: from localhost.localdomain (231.26.30.125.dy.iij4u.or.jp [125.30.26.231])
	by mbox.po.2iij.net (po-mbox302) id l6HE6PYM019792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 17 Jul 2007 23:06:25 +0900
Date:	Tue, 17 Jul 2007 23:06:24 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] remove unused ds1216.h
Message-Id: <20070717230624.338f0b7f.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips


Remove unused ds1216.h

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/ds1216.h mips/include/asm-mips/ds1216.h
--- mips-orig/include/asm-mips/ds1216.h	2007-07-17 17:05:12.360906000 +0900
+++ mips/include/asm-mips/ds1216.h	1970-01-01 09:00:00.000000000 +0900
@@ -1,31 +0,0 @@
-#ifndef _DS1216_H
-#define _DS1216_H
-
-extern volatile unsigned char *ds1216_base;
-unsigned long ds1216_get_cmos_time(void);
-int ds1216_set_rtc_mmss(unsigned long nowtime);
-
-#define DS1216_SEC_BYTE		1
-#define DS1216_MIN_BYTE		2
-#define DS1216_HOUR_BYTE	3
-#define DS1216_HOUR_MASK	(0x1f)
-#define DS1216_AMPM_MASK	(1<<5)
-#define DS1216_1224_MASK	(1<<7)
-#define DS1216_DAY_BYTE		4
-#define DS1216_DAY_MASK		(0x7)
-#define DS1216_DATE_BYTE	5
-#define DS1216_DATE_MASK	(0x3f)
-#define DS1216_MONTH_BYTE	6
-#define DS1216_MONTH_MASK	(0x1f)
-#define DS1216_YEAR_BYTE	7
-
-#define DS1216_SEC(buf)		(buf[DS1216_SEC_BYTE])
-#define DS1216_MIN(buf)		(buf[DS1216_MIN_BYTE])
-#define DS1216_HOUR(buf)	(buf[DS1216_HOUR_BYTE] & DS1216_HOUR_MASK)
-#define DS1216_AMPM(buf)	(buf[DS1216_HOUR_BYTE] & DS1216_AMPM_MASK)
-#define DS1216_1224(buf)	(buf[DS1216_HOUR_BYTE] & DS1216_1224_MASK)
-#define DS1216_DATE(buf)	(buf[DS1216_DATE_BYTE] & DS1216_DATE_MASK)
-#define DS1216_MONTH(buf)	(buf[DS1216_MONTH_BYTE] & DS1216_MONTH_MASK)
-#define DS1216_YEAR(buf)	(buf[DS1216_YEAR_BYTE])
-
-#endif
