Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2007 09:27:04 +0100 (BST)
Received: from p549F7FC7.dip.t-dialin.net ([84.159.127.199]:38071 "EHLO
	p549F7FC7.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20021606AbXINIZz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Sep 2007 09:25:55 +0100
Received: from mo31.po.2iij.NET ([210.128.50.54]:19758 "EHLO mo31.po.2iij.net")
	by lappi.linux-mips.net with ESMTP id S1099300AbXINIWY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 14 Sep 2007 10:22:24 +0200
Received: by mo.po.2iij.net (mo31) id l8E8FWrw052202; Fri, 14 Sep 2007 17:15:32 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox301) id l8E8FVWW010147
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 14 Sep 2007 17:15:31 +0900
Message-Id: <200709140815.l8E8FVWW010147@po-mbox301.hop.2iij.net>
Date:	Fri, 14 Sep 2007 17:14:30 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][3/9][MIPS] remove cobalt_machine_power_off
In-Reply-To: <20070914164228.333da5d9.yoichi_yuasa@tripeaks.co.jp>
References: <20070914164228.333da5d9.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Remove cobalt_machine_power_off().
It is same as cobalt_machine_halt().

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/reset.c mips/arch/mips/cobalt/reset.c
--- mips-orig/arch/mips/cobalt/reset.c	2007-09-14 16:07:34.574419250 +0900
+++ mips/arch/mips/cobalt/reset.c	2007-09-14 16:07:40.882813500 +0900
@@ -27,12 +27,3 @@ void cobalt_machine_restart(char *comman
 	/* we should never get here */
 	cobalt_machine_halt();
 }
-
-/*
- * This triggers the luser mode device driver for the power switch ;-)
- */
-void cobalt_machine_power_off(void)
-{
-	printk("You can switch the machine off now.\n");
-	cobalt_machine_halt();
-}
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/setup.c mips/arch/mips/cobalt/setup.c
--- mips-orig/arch/mips/cobalt/setup.c	2007-09-14 15:36:16.516916250 +0900
+++ mips/arch/mips/cobalt/setup.c	2007-09-14 16:07:40.982819750 +0900
@@ -24,7 +24,6 @@
 
 extern void cobalt_machine_restart(char *command);
 extern void cobalt_machine_halt(void);
-extern void cobalt_machine_power_off(void);
 
 const char *get_system_type(void)
 {
@@ -90,7 +89,7 @@ void __init plat_mem_setup(void)
 
 	_machine_restart = cobalt_machine_restart;
 	_machine_halt = cobalt_machine_halt;
-	pm_power_off = cobalt_machine_power_off;
+	pm_power_off = cobalt_machine_halt;
 
 	set_io_port_base(CKSEG1ADDR(GT_DEF_PCI0_IO_BASE));
 
