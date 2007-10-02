Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Oct 2007 15:22:58 +0100 (BST)
Received: from mo31.po.2iij.NET ([210.128.50.54]:20770 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20024265AbXJBOWn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Oct 2007 15:22:43 +0100
Received: by mo.po.2iij.net (mo31) id l92EMdKP098203; Tue, 2 Oct 2007 23:22:39 +0900 (JST)
Received: from delta (221.25.30.125.dy.iij4u.or.jp [125.30.25.221])
	by mbox.po.2iij.net (po-mbox301) id l92EMb0Z000570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 2 Oct 2007 23:22:38 +0900
Date:	Tue, 2 Oct 2007 23:21:36 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][4/4] remove cobalt_machine_power_off()
Message-Id: <20071002232136.8afe738d.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20071002231738.78779515.yoichi_yuasa@tripeaks.co.jp>
References: <20071002225441.63d935eb.yoichi_yuasa@tripeaks.co.jp>
	<20071002231317.0fbaf7bb.yoichi_yuasa@tripeaks.co.jp>
	<20071002231738.78779515.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.0 (GTK+ 2.10.11; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Remove cobalt_machine_power_off().
It's same as cobalt_machine_halt().

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/reset.c mips/arch/mips/cobalt/reset.c
--- mips-orig/arch/mips/cobalt/reset.c	2007-10-01 17:52:43.870115250 +0900
+++ mips/arch/mips/cobalt/reset.c	2007-10-01 17:52:51.622599750 +0900
@@ -61,12 +61,3 @@ void cobalt_machine_restart(char *comman
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
--- mips-orig/arch/mips/cobalt/setup.c	2007-10-01 17:03:49.370720500 +0900
+++ mips/arch/mips/cobalt/setup.c	2007-10-01 17:52:51.634600500 +0900
@@ -25,7 +25,6 @@
 
 extern void cobalt_machine_restart(char *command);
 extern void cobalt_machine_halt(void);
-extern void cobalt_machine_power_off(void);
 
 const char *get_system_type(void)
 {
@@ -96,7 +95,7 @@ void __init plat_mem_setup(void)
 
 	_machine_restart = cobalt_machine_restart;
 	_machine_halt = cobalt_machine_halt;
-	pm_power_off = cobalt_machine_power_off;
+	pm_power_off = cobalt_machine_halt;
 
 	set_io_port_base(CKSEG1ADDR(GT_DEF_PCI0_IO_BASE));
 
