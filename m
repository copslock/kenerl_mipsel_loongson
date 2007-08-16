Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2007 14:29:14 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:36631 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021963AbXHPN3F (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 16 Aug 2007 14:29:05 +0100
Received: by mo.po.2iij.net (mo31) id l7GDRmXO019557; Thu, 16 Aug 2007 22:27:48 +0900 (JST)
Received: from localhost.localdomain (231.26.30.125.dy.iij4u.or.jp [125.30.26.231])
	by mbox.po.2iij.net (po-mbox300) id l7GDRgVb031014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 16 Aug 2007 22:27:43 +0900
Date:	Thu, 16 Aug 2007 22:27:05 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: [PATCH][MIPS][2/2] vr41xx: replace infinite loop with hibernate
Message-Id: <20070816222705.35939393.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20070816222011.496f6eb8.yoichi_yuasa@tripeaks.co.jp>
References: <20070816222011.496f6eb8.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Replace infinite loop with hibernate.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/vr41xx/common/pmu.c mips/arch/mips/vr41xx/common/pmu.c
--- mips-orig/arch/mips/vr41xx/common/pmu.c	2007-08-06 13:21:36.621511000 +0900
+++ mips/arch/mips/vr41xx/common/pmu.c	2007-08-06 13:22:17.712079000 +0900
@@ -91,14 +91,7 @@ static void vr41xx_halt(void)
 {
 	local_irq_disable();
 	printk(KERN_NOTICE "\nYou can turn off the power supply\n");
-	while (1) ;
-}
-
-static void vr41xx_power_off(void)
-{
-	local_irq_disable();
-	printk(KERN_NOTICE "\nYou can turn off the power supply\n");
-	while (1) ;
+	__asm__("hibernate;\n");
 }
 
 static int __init vr41xx_pmu_init(void)
@@ -134,7 +127,7 @@ static int __init vr41xx_pmu_init(void)
 	cpu_wait = vr41xx_cpu_wait;
 	_machine_restart = vr41xx_restart;
 	_machine_halt = vr41xx_halt;
-	pm_power_off = vr41xx_power_off;
+	pm_power_off = vr41xx_halt;
 
 	return 0;
 }
