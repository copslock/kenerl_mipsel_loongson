Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 May 2007 10:23:16 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:45325 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022384AbXETJXO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 20 May 2007 10:23:14 +0100
Received: by mo.po.2iij.net (mo30) id l4K9N8Ff063117; Sun, 20 May 2007 18:23:08 +0900 (JST)
Received: from localhost.localdomain (70.27.30.125.dy.iij4u.or.jp [125.30.27.70])
	by mbox.po.2iij.net (mbox33) id l4K9N3Sm030191
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 20 May 2007 18:23:04 +0900 (JST)
Date:	Sun, 20 May 2007 18:23:01 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Florian Fainelli <florian.fainelli@telecomint.eu>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/2] Add MIPS generic GPIO support
Message-Id: <20070520182301.7d7831e5.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <200705192151.37338.florian.fainelli@telecomint.eu>
References: <200705192151.37338.florian.fainelli@telecomint.eu>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips


On Sat, 19 May 2007 21:51:37 +0200
Florian Fainelli <florian.fainelli@telecomint.eu> wrote:

> This patch adds support for the generic GPIO API to MIPS boards.

Your patch is effective to the target that doesn't support GPIO.
This is better.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X gpio/Documentation/dontdiff gpio-orig/include/asm-mips/gpio.h gpio/include/asm-mips/gpio.h
--- gpio-orig/include/asm-mips/gpio.h	1970-01-01 09:00:00.000000000 +0900
+++ gpio/include/asm-mips/gpio.h	2007-05-20 17:21:36.332456000 +0900
@@ -0,0 +1,6 @@
+#ifndef __ASM_MIPS_GPIO_H
+#define __ASM_MIPS_GPIO_H
+
+#include <gpio.h>
+
+#endif /* __ASM_MIPS_GPIO_H */
diff -pruN -X gpio/Documentation/dontdiff gpio-orig/include/asm-mips/mach-generic/gpio.h gpio/include/asm-mips/mach-generic/gpio.h
--- gpio-orig/include/asm-mips/mach-generic/gpio.h	1970-01-01 09:00:00.000000000 +0900
+++ gpio/include/asm-mips/mach-generic/gpio.h	2007-05-20 17:24:07.401897250 +0900
@@ -0,0 +1,6 @@
+#ifndef __ASM_MACH_GENERIC_GPIO_H
+#define __ASM_MACH_GENERIC_GPIO_H
+
+/* no GPIO support */ 
+
+#endif /* __ASM_MACH_GENERIC_GPIO_H */
