Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2008 14:40:03 +0100 (BST)
Received: from mo32.po.2iij.NET ([210.128.50.17]:56101 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20031722AbYGKNjn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2008 14:39:43 +0100
Received: by mo.po.2iij.net (mo32) id m6BDde5X090118; Fri, 11 Jul 2008 22:39:40 +0900 (JST)
Received: from delta (61.25.30.125.dy.iij4u.or.jp [125.30.25.61])
	by mbox.po.2iij.net (po-mbox304) id m6BDdd2o011986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 11 Jul 2008 22:39:39 +0900
Date:	Fri, 11 Jul 2008 22:39:18 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2/2][MIPS] remove wrppmc_machine_power_off()
Message-Id: <20080711223918.695c5487.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20080711223748.e164b514.yoichi_yuasa@tripeaks.co.jp>
References: <20080711223748.e164b514.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Remove wrppmc_machine_power_off().
It can be replace wrppmc_machine_halt().

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/gt64120/wrppmc/reset.c linux/arch/mips/gt64120/wrppmc/reset.c
--- linux-orig/arch/mips/gt64120/wrppmc/reset.c	2008-07-08 13:33:35.731399494 +0900
+++ linux/arch/mips/gt64120/wrppmc/reset.c	2008-07-08 13:33:45.979983528 +0900
@@ -38,8 +38,3 @@ void wrppmc_machine_halt(void)
 			cpu_wait();
 	}
 }
-
-void wrppmc_machine_power_off(void)
-{
-	wrppmc_machine_halt();
-}
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/gt64120/wrppmc/setup.c linux/arch/mips/gt64120/wrppmc/setup.c
--- linux-orig/arch/mips/gt64120/wrppmc/setup.c	2008-07-08 10:12:29.899943226 +0900
+++ linux/arch/mips/gt64120/wrppmc/setup.c	2008-07-08 13:34:20.305939652 +0900
@@ -98,11 +98,10 @@ void __init plat_mem_setup(void)
 {
 	extern void wrppmc_machine_restart(char *command);
 	extern void wrppmc_machine_halt(void);
-	extern void wrppmc_machine_power_off(void);
 
 	_machine_restart = wrppmc_machine_restart;
 	_machine_halt	 = wrppmc_machine_halt;
-	pm_power_off	 = wrppmc_machine_power_off;
+	pm_power_off	 = wrppmc_machine_halt;
 
 	/* This makes the operations of 'in/out[bwl]' to the
 	 * physical address ( < KSEG0) can work via KSEG1
