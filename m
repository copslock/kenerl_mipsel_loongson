Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2006 09:45:41 +0000 (GMT)
Received: from mo31.po.2iij.net ([210.128.50.54]:29002 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20039157AbWKAJpk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Nov 2006 09:45:40 +0000
Received: by mo.po.2iij.net (mo31) id kA19jbJN090582; Wed, 1 Nov 2006 18:45:37 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox32) id kA19jamt074809
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 1 Nov 2006 18:45:36 +0900 (JST)
Date:	Wed, 1 Nov 2006 18:45:36 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] fix warning LOAD_VGA_FONT is not defined
Message-Id: <20061101184536.330411b1.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has fixed the following warning.
 
arch/mips/qemu/q-vga.c:140:5: warning: "LOAD_VGA_FONT" is not defined

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/qemu/q-vga.c mips/arch/mips/qemu/q-vga.c
--- mips-orig/arch/mips/qemu/q-vga.c	2006-10-29 13:07:08.287301500 +0900
+++ mips/arch/mips/qemu/q-vga.c	2006-10-29 13:47:10.125974500 +0900
@@ -137,7 +137,7 @@ void __init qvga_init(void)
 	unsigned int h;
 	int i;
 
-#if LOAD_VGA_FONT
+#ifdef LOAD_VGA_FONT
 	qvga_load_font(vgafont16, 4096);
 #endif
 
