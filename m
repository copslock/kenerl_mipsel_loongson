Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Jul 2006 23:14:51 +0100 (BST)
Received: from p549F6FFC.dip.t-dialin.net ([84.159.111.252]:55019 "EHLO
	p549F6FFC.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S8133792AbWGPWNi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 16 Jul 2006 23:13:38 +0100
Received: from mo31.po.2iij.net ([210.128.50.54]:40259 "EHLO mo31.po.2iij.net")
	by lappi.linux-mips.net with ESMTP id S1099323AbWGPOkW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 16 Jul 2006 16:40:22 +0200
Received: by mo.po.2iij.net (mo31) id k6GEe9hq017148; Sun, 16 Jul 2006 23:40:09 +0900 (JST)
Received: from localhost.localdomain (225.29.30.125.dy.iij4u.or.jp [125.30.29.225])
	by mbox.po.2iij.net (mbox31) id k6GEe1dl069793
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 16 Jul 2006 23:40:03 +0900 (JST)
Date:	Sun, 16 Jul 2006 23:40:00 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] removed an undefined config symbol
Message-Id: <20060716234000.6fb28c7e.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has removed an undefined config symbol in arch/mips/Kconfig.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/Kconfig mips/arch/mips/Kconfig
--- mips-orig/arch/mips/Kconfig	2006-07-16 23:19:10.231100750 +0900
+++ mips/arch/mips/Kconfig	2006-07-16 23:22:32.331731250 +0900
@@ -126,7 +126,6 @@ config BASLER_EXCITE
 	select IRQ_CPU
 	select IRQ_CPU_RM7K
 	select IRQ_CPU_RM9K
-	select SERIAL_RM9000
 	select SYS_HAS_CPU_RM9000
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
