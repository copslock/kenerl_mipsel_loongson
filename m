Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2005 17:45:04 +0100 (BST)
Received: from mo00.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:61178 "EHLO
	mo00.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225337AbVGVQoq>;
	Fri, 22 Jul 2005 17:44:46 +0100
Received: MO(mo00)id j6MGkmiT022534; Sat, 23 Jul 2005 01:46:48 +0900 (JST)
Received: MDO(mdo00) id j6MGklSb022387; Sat, 23 Jul 2005 01:46:48 +0900 (JST)
Received: from stratos (h009.p499.iij4u.or.jp [210.149.243.9])
	by mbox.iij4u.or.jp (4U-MR/mbox01) id j6MGkkS2017872
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Sat, 23 Jul 2005 01:46:47 +0900 (JST)
Date:	Sat, 23 Jul 2005 01:46:44 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6] vr41xx: add plat_setup
Message-Id: <20050723014644.6baa61a7.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has added to plat_setup for vr41xx.
Please apply this patch.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/init.c a/arch/mips/vr41xx/common/init.c
--- a-orig/arch/mips/vr41xx/common/init.c	2005-04-19 01:07:37.000000000 +0900
+++ a/arch/mips/vr41xx/common/init.c	2005-07-23 01:36:05.000000000 +0900
@@ -58,6 +58,14 @@
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
@@ -71,12 +79,6 @@
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
