Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jun 2005 04:39:43 +0100 (BST)
Received: from sonicwall.montavista.co.jp ([IPv6:::ffff:202.232.97.131]:54640
	"EHLO yuubin.montavista.co.jp") by linux-mips.org with ESMTP
	id <S8225220AbVFVDj1>; Wed, 22 Jun 2005 04:39:27 +0100
Received: from localhost.localdomain (oreo.jp.mvista.com [10.200.16.31])
	by yuubin.montavista.co.jp (8.12.5/8.12.5) with SMTP id j5M3cIS5027115;
	Wed, 22 Jun 2005 12:38:18 +0900
Date:	Wed, 22 Jun 2005 12:40:04 +0900
From:	Hiroshi DOYU <Hiroshi_DOYU@montavista.co.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, mlachwani@mvista.com
Subject: [patch 2.6.12 1/1] tx4938: Enabled NAND support for Toshiba
 RBHMA4500(TX4938)
Message-Id: <20050622124004.79b09861.Hiroshi_DOYU@montavista.co.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <Hiroshi_DOYU@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Hiroshi_DOYU@montavista.co.jp
Precedence: bulk
X-list: linux-mips

Hello,

This patch is against 2.6.12 and it works fine. 
Please review it.

	Hiroshi DOYU

----
Enabled NAND support for Toshiba RBHMA4500(TX4938)

Signed-off-by: Hiroshi DOYU <Hiroshi_DOYU@montavista.co.jp>
----

 arch/mips/Kconfig                        |    1 +
 arch/mips/tx4938/Kconfig                 |   23 +++++++++++++++++++++++
 arch/mips/tx4938/toshiba_rbtx4938/prom.c |    4 ++--
 3 files changed, 26 insertions(+), 2 deletions(-)

Index: linux/arch/mips/Kconfig
===================================================================
--- linux.orig/arch/mips/Kconfig	2005-06-22 11:29:17.902637344 +0900
+++ linux/arch/mips/Kconfig	2005-06-22 11:29:17.943631112 +0900
@@ -657,6 +657,7 @@
 source "arch/mips/sgi-ip27/Kconfig"
 source "arch/mips/sibyte/Kconfig"
 source "arch/mips/tx4927/Kconfig"
+source "arch/mips/tx4938/Kconfig"
 source "arch/mips/vr41xx/Kconfig"
 
 endmenu
Index: linux/arch/mips/tx4938/Kconfig
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/arch/mips/tx4938/Kconfig	2005-06-22 11:29:17.943631112 +0900
@@ -0,0 +1,23 @@
+comment "Multiplex Pin Select"
+choice
+	prompt "PIO[58:61]"
+	default TOSHIBA_RBTX4938_MPLEX_PIO58_61
+
+config TOSHIBA_RBTX4938_MPLEX_PIO58_61
+	bool "PIO"
+config TOSHIBA_RBTX4938_MPLEX_NAND
+	bool "NAND"
+config TOSHIBA_RBTX4938_MPLEX_ATA
+	bool "ATA"
+
+endchoice
+
+config TX4938_NAND_BOOT
+	depends on EXPERIMENTAL && TOSHIBA_RBTX4938_MPLEX_NAND
+	bool "NAND Boot Support (EXPERIMENTAL)"
+	help
+	  This is only for Toshiba RBTX4938 reference board, which has NAND IPL.
+	  Select this option if you need to use NAND boot.
+
+
+
Index: linux/arch/mips/tx4938/toshiba_rbtx4938/prom.c
===================================================================
--- linux.orig/arch/mips/tx4938/toshiba_rbtx4938/prom.c	2005-06-22 11:29:17.908636432 +0900
+++ linux/arch/mips/tx4938/toshiba_rbtx4938/prom.c	2005-06-22 11:29:17.944630960 +0900
@@ -45,9 +45,9 @@
 {
 	extern int tx4938_get_mem_size(void);
 	int msize;
-
+#ifndef CONFIG_TX4938_NAND_BOOT
 	prom_init_cmdline();
-
+#endif
 	mips_machgroup = MACH_GROUP_TOSHIBA;
 	mips_machtype = MACH_TOSHIBA_RBTX4938;
 
