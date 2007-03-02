Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Mar 2007 03:44:12 +0000 (GMT)
Received: from mo31.po.2iij.net ([210.128.50.54]:30272 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20039480AbXCBDoH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 2 Mar 2007 03:44:07 +0000
Received: by mo.po.2iij.net (mo31) id l223gbkx015239; Fri, 2 Mar 2007 12:42:37 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox32) id l223gXYP031831
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 2 Mar 2007 12:42:35 +0900 (JST)
Date:	Fri, 2 Mar 2007 12:42:33 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] fix Cobalt early printk
Message-Id: <20070302124233.6b9f2c67.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14306
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has fixed Cobalt early printk.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/Kconfig mips/arch/mips/Kconfig
--- mips-orig/arch/mips/Kconfig	2007-03-02 10:51:23.580547750 +0900
+++ mips/arch/mips/Kconfig	2007-03-02 12:35:15.292826000 +0900
@@ -167,6 +167,7 @@ config MIPS_COBALT
 	select IRQ_CPU
 	select MIPS_GT64111
 	select SYS_HAS_CPU_NEVADA
+	select SYS_HAS_EARLY_PRINTK
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
@@ -837,7 +838,6 @@ source "arch/mips/tx4927/Kconfig"
 source "arch/mips/tx4938/Kconfig"
 source "arch/mips/vr41xx/Kconfig"
 source "arch/mips/philips/pnx8550/common/Kconfig"
-source "arch/mips/cobalt/Kconfig"
 
 endmenu
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/Kconfig mips/arch/mips/cobalt/Kconfig
--- mips-orig/arch/mips/cobalt/Kconfig	2007-03-02 10:51:24.048577000 +0900
+++ mips/arch/mips/cobalt/Kconfig	1970-01-01 09:00:00.000000000 +0900
@@ -1,7 +0,0 @@
-config EARLY_PRINTK
-	bool "Early console support"
-	depends on MIPS_COBALT
-	help
-	  Provide early console support by direct access to the
-	  on board UART. The UART must have been previously
-	  initialised by the boot loader.
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/console.c mips/arch/mips/cobalt/console.c
--- mips-orig/arch/mips/cobalt/console.c	2007-03-02 10:51:24.068578250 +0900
+++ mips/arch/mips/cobalt/console.c	2007-03-02 11:27:01.184311000 +0900
@@ -9,11 +9,8 @@
 #include <asm/addrspace.h>
 #include <asm/mach-cobalt/cobalt.h>
 
-static void putchar(int c)
+void prom_putchar(char c)
 {
-	if(c == '\n')
-		putchar('\r');
-
 	while(!(COBALT_UART[UART_LSR] & UART_LSR_THRE))
 		;
 
