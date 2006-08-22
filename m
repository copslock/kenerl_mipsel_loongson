Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Aug 2006 15:03:07 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:36155 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038746AbWHVN6x (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Aug 2006 14:58:53 +0100
Received: by mo.po.2iij.net (mo31) id k7MDwpOB075961; Tue, 22 Aug 2006 22:58:51 +0900 (JST)
Received: from localhost.localdomain (191.28.30.125.dy.iij4u.or.jp [125.30.28.191])
	by mbox.po.2iij.net (mbox33) id k7MDwo3v012254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 Aug 2006 22:58:50 +0900 (JST)
Date:	Tue, 22 Aug 2006 22:58:05 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 11/12] updated i8259 resources
Message-Id: <20060822225805.7bd8c2e3.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has updated i8259 resources as same as i386.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/kernel/i8259.c mips/arch/mips/kernel/i8259.c
--- mips-orig/arch/mips/kernel/i8259.c	2006-08-19 00:34:52.514459500 +0900
+++ mips/arch/mips/kernel/i8259.c	2006-08-19 00:52:04.506955000 +0900
@@ -302,11 +302,11 @@ static struct irqaction irq2 = {
 };
 
 static struct resource pic1_io_resource = {
-	.name = "pic1", .start = 0x20, .end = 0x3f, .flags = IORESOURCE_BUSY
+	.name = "pic1", .start = 0x20, .end = 0x21, .flags = IORESOURCE_BUSY
 };
 
 static struct resource pic2_io_resource = {
-	.name = "pic2", .start = 0xa0, .end = 0xbf, .flags = IORESOURCE_BUSY
+	.name = "pic2", .start = 0xa0, .end = 0xa1, .flags = IORESOURCE_BUSY
 };
 
 /*
