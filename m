Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Feb 2004 21:38:57 +0000 (GMT)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:21970 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225517AbUBIVi4>;
	Mon, 9 Feb 2004 21:38:56 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id GAA21985;
	Tue, 10 Feb 2004 06:38:52 +0900 (JST)
Received: 4UMDO00 id i19LcqF28602; Tue, 10 Feb 2004 06:38:52 +0900 (JST)
Received: 4UMRO00 id i19Lcp409316; Tue, 10 Feb 2004 06:38:52 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Tue, 10 Feb 2004 06:38:46 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.4] Fixed configration problem for vr41xx
Message-Id: <20040210063846.66ec64a9.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

I made a patch for configuration problem for vr41xx.
This patch corrects the problem which occurs when CONFIG_SERIAL is n.

Please apply this patch to v2.4.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/casio-e55/setup.c linux/arch/mips/vr41xx/casio-e55/setup.c
--- linux-orig/arch/mips/vr41xx/casio-e55/setup.c	2004-02-06 11:21:47.000000000 +0900
+++ linux/arch/mips/vr41xx/casio-e55/setup.c	2004-02-09 12:11:51.000000000 +0900
@@ -50,5 +50,7 @@
 
 	vr41xx_cmu_init();
 
+#ifdef CONFIG_SERIAL
 	vr41xx_siu_init(SIU_RS232C, 0);
+#endif
 }
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/ibm-workpad/setup.c linux/arch/mips/vr41xx/ibm-workpad/setup.c
--- linux-orig/arch/mips/vr41xx/ibm-workpad/setup.c	2004-02-06 11:21:47.000000000 +0900
+++ linux/arch/mips/vr41xx/ibm-workpad/setup.c	2004-02-09 12:11:51.000000000 +0900
@@ -50,5 +50,7 @@
 
 	vr41xx_cmu_init();
 
+#ifdef CONFIG_SERIAL
 	vr41xx_siu_init(SIU_RS232C, 0);
+#endif
 }
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0226/setup.c linux/arch/mips/vr41xx/tanbac-tb0226/setup.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0226/setup.c	2004-02-09 10:43:38.000000000 +0900
+++ linux/arch/mips/vr41xx/tanbac-tb0226/setup.c	2004-02-09 12:12:36.000000000 +0900
@@ -91,7 +91,9 @@
 
 	vr41xx_cmu_init();
 
+#ifdef CONFIG_SERIAL
 	vr41xx_siu_init(SIU_RS232C, 0);
+#endif
 
 #ifdef CONFIG_PCI
 	vr41xx_pciu_init(&pci_address_map);
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c linux/arch/mips/vr41xx/tanbac-tb0229/setup.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c	2004-02-09 10:43:38.000000000 +0900
+++ linux/arch/mips/vr41xx/tanbac-tb0229/setup.c	2004-02-09 12:11:51.000000000 +0900
@@ -104,8 +104,10 @@
 
 	vr41xx_cmu_init();
 
+#ifdef CONFIG_SERIAL
 	vr41xx_siu_init(SIU_RS232C, 0);
 	vr41xx_dsiu_init();
+#endif
 
 #ifdef CONFIG_PCI
 	vr41xx_pciu_init(&pci_address_map);
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/victor-mpc30x/setup.c linux/arch/mips/vr41xx/victor-mpc30x/setup.c
--- linux-orig/arch/mips/vr41xx/victor-mpc30x/setup.c	2004-02-09 10:43:38.000000000 +0900
+++ linux/arch/mips/vr41xx/victor-mpc30x/setup.c	2004-02-09 12:16:23.000000000 +0900
@@ -96,7 +96,9 @@
 
 	vr41xx_cmu_init();
 
+#ifdef CONFIG_SERIAL
 	vr41xx_siu_init(SIU_RS232C, 0);
+#endif
 
 #ifdef CONFIG_PCI
 	vr41xx_pciu_init(&pci_address_map);
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/zao-capcella/setup.c linux/arch/mips/vr41xx/zao-capcella/setup.c
--- linux-orig/arch/mips/vr41xx/zao-capcella/setup.c	2004-02-09 10:43:38.000000000 +0900
+++ linux/arch/mips/vr41xx/zao-capcella/setup.c	2004-02-09 12:17:10.000000000 +0900
@@ -96,8 +96,10 @@
 
 	vr41xx_cmu_init();
 
+#ifdef CONFIG_SERIAL
 	vr41xx_siu_init(SIU_RS232C, 0);
 	vr41xx_dsiu_init();
+#endif
 
 #ifdef CONFIG_PCI
 	vr41xx_pciu_init(&pci_address_map);
