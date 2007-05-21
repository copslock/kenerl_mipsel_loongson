Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2007 16:07:28 +0100 (BST)
Received: from mo30.po.2iij.NET ([210.128.50.53]:46402 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022753AbXEUPHX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 21 May 2007 16:07:23 +0100
Received: by mo.po.2iij.net (mo30) id l4LF65Av076600; Tue, 22 May 2007 00:06:05 +0900 (JST)
Received: from localhost.localdomain (70.27.30.125.dy.iij4u.or.jp [125.30.27.70])
	by mbox.po.2iij.net (mbox30) id l4LF60LH013896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 May 2007 00:06:01 +0900 (JST)
Date:	Tue, 22 May 2007 00:05:58 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, florian.fainelli@telecomint.eu,
	linux-mips@linux-mips.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: [PATCH UPDATE] Add MIPS generic GPIO support
Message-Id: <20070522000558.7dc5b747.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20070521.231200.74752428.anemo@mba.ocn.ne.jp>
References: <20070521.001238.41198930.anemo@mba.ocn.ne.jp>
	<20070521161303.0d9db8e4.yoichi_yuasa@tripeaks.co.jp>
	<200705210729.l4L7TZB3079730@mbox31.po.2iij.net>
	<20070521.231200.74752428.anemo@mba.ocn.ne.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips


On Mon, 21 May 2007 23:12:00 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> On Mon, 21 May 2007 16:29:35 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> > This patch has added support for the generic GPIO API header file to MIPS.
> 
> With the change, adding these lines to Kconfig would be better.
> 
> config GENERIC_GPIO
>         bool

Atsushi, thank you for your comment.

This patch has added support for the generic GPIO API to MIPS.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/Kconfig mips/arch/mips/Kconfig
--- mips-orig/arch/mips/Kconfig	2007-05-21 16:08:48.846031250 +0900
+++ mips/arch/mips/Kconfig	2007-05-21 23:56:57.784356000 +0900
@@ -778,6 +778,9 @@ config GENERIC_ISA_DMA_SUPPORT_BROKEN
 	bool
 	select ZONE_DMA
 
+config GENERIC_GPIO
+	bool
+
 #
 # Endianess selection.  Sufficiently obscure so many users don't know what to
 # answer,so we try hard to limit the available choices.  Also the use of a
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/gpio.h mips/include/asm-mips/gpio.h
--- mips-orig/include/asm-mips/gpio.h	1970-01-01 09:00:00.000000000 +0900
+++ mips/include/asm-mips/gpio.h	2007-05-21 17:07:51.769161250 +0900
@@ -0,0 +1,6 @@
+#ifndef __ASM_MIPS_GPIO_H
+#define __ASM_MIPS_GPIO_H
+
+#include <gpio.h>
+
+#endif /* __ASM_MIPS_GPIO_H */
