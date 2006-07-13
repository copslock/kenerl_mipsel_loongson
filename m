Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jul 2006 09:37:30 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:40986 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133577AbWGMIeW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 13 Jul 2006 09:34:22 +0100
Received: by mo.po.2iij.net (mo30) id k6D8YHMq013604; Thu, 13 Jul 2006 17:34:17 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox30) id k6D8YDIT057026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 13 Jul 2006 17:34:13 +0900 (JST)
Date:	Thu, 13 Jul 2006 17:34:13 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] fixed  screen_info build error about Qemu
Message-Id: <20060713173413.1e26694d.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has fixed screen_info build error about Qemu.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/qemu/q-vga.c mips/arch/mips/qemu/q-vga.c
--- mips-orig/arch/mips/qemu/q-vga.c	2006-07-11 23:20:17.050899000 +0900
+++ mips/arch/mips/qemu/q-vga.c	2006-07-12 07:10:50.285183000 +0900
@@ -8,6 +8,7 @@
  * This will eventually go into the qemu firmware.
  */
 #include <linux/init.h>
+#include <linux/screen_info.h>
 #include <linux/tty.h>
 #include <asm/io.h>
 #include <video/vga.h>
