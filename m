Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Aug 2006 15:02:42 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:6168 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038743AbWHVN6w (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Aug 2006 14:58:52 +0100
Received: by mo.po.2iij.net (mo31) id k7MDwo1k075958; Tue, 22 Aug 2006 22:58:50 +0900 (JST)
Received: from localhost.localdomain (191.28.30.125.dy.iij4u.or.jp [125.30.28.191])
	by mbox.po.2iij.net (mbox33) id k7MDwnCQ012244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 Aug 2006 22:58:49 +0900 (JST)
Date:	Tue, 22 Aug 2006 22:58:00 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 10/12] cleaned up include files of Cobalt's setup.c
Message-Id: <20060822225800.037271fe.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has cleaned up include files of Cobalt's setup.c .

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/cobalt/setup.c mips/arch/mips/gt64120/cobalt/setup.c
--- mips-orig/arch/mips/gt64120/cobalt/setup.c	2006-08-19 00:51:27.328631500 +0900
+++ mips/arch/mips/gt64120/cobalt/setup.c	2006-08-19 01:01:31.880378250 +0900
@@ -9,17 +9,15 @@
  * Copyright (C) 2001, 2002, 2003 by Liam Davies (ldavies@agile.tv)
  *
  */
+#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
-#include <linux/init.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 
 #include <asm/bootinfo.h>
 #include <asm/time.h>
 #include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/processor.h>
 #include <asm/gt64120.h>
 
 #include <cobalt.h>
