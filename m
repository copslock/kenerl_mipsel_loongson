Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2008 14:03:28 +0000 (GMT)
Received: from mo31.po.2iij.net ([210.128.50.54]:37444 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S22734459AbYJ3ODM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2008 14:03:12 +0000
Received: by mo.po.2iij.net (mo31) id m9UE35qB094073; Thu, 30 Oct 2008 23:03:05 +0900 (JST)
Received: from delta (187.24.30.125.dy.iij4u.or.jp [125.30.24.187])
	by mbox.po.2iij.net (po-mbox300) id m9UE32MJ032588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 30 Oct 2008 23:03:03 +0900
Date:	Thu, 30 Oct 2008 23:03:02 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] remove unused ds1286.h
Message-Id: <20081030230302.ae78bf60.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips


Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/include/asm/ds1286.h linux/arch/mips/include/asm/ds1286.h
--- linux-orig/arch/mips/include/asm/ds1286.h	2008-10-30 09:49:14.369198923 +0900
+++ linux/arch/mips/include/asm/ds1286.h	1970-01-01 09:00:00.000000000 +0900
@@ -1,15 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Machine dependent access functions for RTC registers.
- *
- * Copyright (C) 2003 Ralf Baechle (ralf@linux-mips.org)
- */
-#ifndef _ASM_DS1286_H
-#define _ASM_DS1286_H
-
-#include <ds1286.h>
-
-#endif /* _ASM_DS1286_H */
