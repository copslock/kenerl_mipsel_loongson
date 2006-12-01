Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 13:23:04 +0000 (GMT)
Received: from mo31.po.2iij.net ([210.128.50.54]:279 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S28573733AbWLANVQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Dec 2006 13:21:16 +0000
Received: by mo.po.2iij.net (mo31) id kB1DLEuB030758; Fri, 1 Dec 2006 22:21:14 +0900 (JST)
Received: from localhost.localdomain (133.25.30.125.dy.iij4u.or.jp [125.30.25.133])
	by mbox.po.2iij.net (mbox32) id kB1DLA84027868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 1 Dec 2006 22:21:10 +0900 (JST)
Date:	Fri, 1 Dec 2006 22:20:21 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 5/5] MIPS: clean up include files for cobalt
Message-Id: <20061201222021.7be0fae6.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20061201221910.56cde68c.yoichi_yuasa@tripeaks.co.jp>
References: <20061201221242.261f57b0.yoichi_yuasa@tripeaks.co.jp>
	<20061201221601.3aa34024.yoichi_yuasa@tripeaks.co.jp>
	<20061201221746.1f45d98c.yoichi_yuasa@tripeaks.co.jp>
	<20061201221910.56cde68c.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13294
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has cleaned up include files for cobalt.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/console.c mips/arch/mips/cobalt/console.c
--- mips-orig/arch/mips/cobalt/console.c	2006-10-12 11:44:59.727188000 +0900
+++ mips/arch/mips/cobalt/console.c	2006-10-12 11:53:43.203903250 +0900
@@ -7,7 +7,7 @@
 #include <linux/console.h>
 #include <linux/serial_reg.h>
 #include <asm/addrspace.h>
-#include <asm/mach-cobalt/cobalt.h>
+#include <cobalt.h>
 
 static void putchar(int c)
 {
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/irq.c mips/arch/mips/cobalt/irq.c
--- mips-orig/arch/mips/cobalt/irq.c	2006-10-12 11:49:45.137025000 +0900
+++ mips/arch/mips/cobalt/irq.c	2006-10-12 11:53:26.330848750 +0900
@@ -17,7 +17,7 @@
 #include <asm/irq_cpu.h>
 #include <asm/gt64120.h>
 
-#include <asm/mach-cobalt/cobalt.h>
+#include <cobalt.h>
 
 /*
  * We have two types of interrupts that we handle, ones that come in through
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/setup.c mips/arch/mips/cobalt/setup.c
--- mips-orig/arch/mips/cobalt/setup.c	2006-10-12 11:49:54.681621500 +0900
+++ mips/arch/mips/cobalt/setup.c	2006-10-12 11:56:31.510421750 +0900
@@ -18,11 +18,9 @@
 #include <asm/bootinfo.h>
 #include <asm/time.h>
 #include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/processor.h>
 #include <asm/gt64120.h>
 
-#include <asm/mach-cobalt/cobalt.h>
+#include <cobalt.h>
 
 extern void cobalt_early_console(void);
 
