Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2007 14:57:34 +0100 (BST)
Received: from mo30.po.2iij.NET ([210.128.50.53]:30008 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021963AbXHPN5Y (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 16 Aug 2007 14:57:24 +0100
Received: by mo.po.2iij.net (mo30) id l7GDu7X0023968; Thu, 16 Aug 2007 22:56:07 +0900 (JST)
Received: from localhost.localdomain (231.26.30.125.dy.iij4u.or.jp [125.30.26.231])
	by mbox.po.2iij.net (po-mbox300) id l7GDu5t1015865
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 16 Aug 2007 22:56:05 +0900
Date:	Thu, 16 Aug 2007 22:56:04 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] remove unused include/asm-mips/ip32/machine.h
Message-Id: <20070816225604.0e1801a9.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Remove unused include/asm-mips/ip32/machine.h .

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/ip32/machine.h mips/include/asm-mips/ip32/machine.h
--- mips-orig/include/asm-mips/ip32/machine.h	2007-08-05 16:49:44.200511750 +0900
+++ mips/include/asm-mips/ip32/machine.h	1970-01-01 09:00:00.000000000 +0900
@@ -1,20 +0,0 @@
-/*
- * machine.h -- Machine/group probing for ip32
- *
- * Copyright (C) 2001 Keith M Wesolowski
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file COPYING in the main directory of this archive
- * for more details.
- */
-#ifndef _ASM_IP32_MACHINE_H
-#define _ASM_IP32_MACHINE_H
-
-
-#ifdef CONFIG_SGI_IP32
-
-#define SGI_MACH_O2		0x3201
-
-#endif /* CONFIG_SGI_IP32 */
-
-#endif /* _ASM_SGI_MACHINE_H */
