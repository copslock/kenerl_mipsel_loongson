Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2006 15:07:57 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:28698 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133759AbWFTOHs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Jun 2006 15:07:48 +0100
Received: by mo.po.2iij.net (mo31) id k5KE7kWb008623; Tue, 20 Jun 2006 23:07:46 +0900 (JST)
Received: from localhost.localdomain (225.29.30.125.dy.iij4u.or.jp [125.30.29.225])
	by mbox.po.2iij.net (mbox30) id k5KE7iVG039709
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 20 Jun 2006 23:07:44 +0900 (JST)
Date:	Tue, 20 Jun 2006 23:07:43 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] remove unused timex.h for vr41xx
Message-Id: <20060620230743.1fe60be5.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch removes unused timex.h for vr41xx.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips-rc6/Documentation/dontdiff mips-rc6-orig/include/asm-mips/mach-vr41xx/timex.h mips-rc6/include/asm-mips/mach-vr41xx/timex.h
--- mips-rc6-orig/include/asm-mips/mach-vr41xx/timex.h	2006-06-09 00:33:01.005450500 +0900
+++ mips-rc6/include/asm-mips/mach-vr41xx/timex.h	1970-01-01 09:00:00.000000000 +0900
@@ -1,18 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2003 by Ralf Baechle
- */
-/*
- * Changes:
- *  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
- *  - CLOCK_TICK_RATE is changed into 32768 from 6144000.
- */
-#ifndef __ASM_MACH_VR41XX_TIMEX_H
-#define __ASM_MACH_VR41XX_TIMEX_H
-
-#define CLOCK_TICK_RATE		32768
-
-#endif /* __ASM_MACH_VR41XX_TIMEX_H */
