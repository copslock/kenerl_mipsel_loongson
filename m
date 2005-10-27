Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Oct 2005 16:59:54 +0100 (BST)
Received: from mo01.iij4u.or.jp ([210.130.0.20]:36841 "EHLO mo01.iij4u.or.jp")
	by ftp.linux-mips.org with ESMTP id S8133582AbVJ0P7g (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Oct 2005 16:59:36 +0100
Received: MO(mo01)id j9RFxecv001389; Fri, 28 Oct 2005 00:59:40 +0900 (JST)
Received: MDO(mdo01) id j9RFxegI005503; Fri, 28 Oct 2005 00:59:40 +0900 (JST)
Received: from stratos (h195.p501.iij4u.or.jp [210.149.245.195])
	by mbox.iij4u.or.jp (4U-MR/mbox00) id j9RFxds3023222
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Fri, 28 Oct 2005 00:59:39 +0900 (JST)
Date:	Fri, 28 Oct 2005 00:59:37 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] vr41xx: add plat_setup to -mm queue
Message-Id: <20051028005937.02cb1007.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

Please add this patch to -mm queue.
This has already been included in linux-mips.git. 

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -Npru -X dontdiff mm1-orig/arch/mips/vr41xx/common/init.c mm1/arch/mips/vr41xx/common/init.c
--- mm1-orig/arch/mips/vr41xx/common/init.c	2005-10-20 15:23:05.000000000 +0900
+++ mm1/arch/mips/vr41xx/common/init.c	2005-10-27 23:26:40.000000000 +0900
@@ -58,6 +58,14 @@ static void __init timer_init(void)
 	board_timer_setup = setup_timer_irq;
 }
 
+void __init plat_setup(void)
+{
+	vr41xx_calculate_clock_frequency();
+
+	timer_init();
+	iomem_resource_init();
+}
+
 void __init prom_init(void)
 {
 	int argc, i;
@@ -71,12 +79,6 @@ void __init prom_init(void)
 		if (i < (argc - 1))
 			strcat(arcs_cmdline, " ");
 	}
-
-	vr41xx_calculate_clock_frequency();
-
-	timer_init();
-
-	iomem_resource_init();
 }
 
 unsigned long __init prom_free_prom_memory (void)
