Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2007 08:29:43 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:53300 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022040AbXEUH3l (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 21 May 2007 08:29:41 +0100
Received: by mo.po.2iij.net (mo32) id l4L7TcAg056444; Mon, 21 May 2007 16:29:38 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox31) id l4L7TZB3079730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 21 May 2007 16:29:36 +0900 (JST)
Message-Id: <200705210729.l4L7TZB3079730@mbox31.po.2iij.net>
Date:	Mon, 21 May 2007 16:29:35 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, anemo@mba.ocn.ne.jp,
	florian.fainelli@telecomint.eu, linux-mips@linux-mips.org
Subject: [PATCH] Add MIPS generic GPIO support
In-Reply-To: <20070521161303.0d9db8e4.yoichi_yuasa@tripeaks.co.jp>
References: <200705192151.37338.florian.fainelli@telecomint.eu>
	<20070520182301.7d7831e5.yoichi_yuasa@tripeaks.co.jp>
	<20070521.001238.41198930.anemo@mba.ocn.ne.jp>
	<20070521161303.0d9db8e4.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has added support for the generic GPIO API header file to MIPS.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/gpio.h mips/include/asm-mips/gpio.h
--- mips-orig/include/asm-mips/gpio.h	1970-01-01 09:00:00.000000000 +0900
+++ mips/include/asm-mips/gpio.h	2007-05-21 16:19:05.720583500 +0900
@@ -0,0 +1,6 @@
+#ifndef __ASM_MIPS_GPIO_H
+#define __ASM_MIPS_GPIO_H
+
+#include <gpio.h>
+
+#endif /* __ASM_MIPS_GPIO_H */
