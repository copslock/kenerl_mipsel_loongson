Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Feb 2004 16:59:56 +0000 (GMT)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:980 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225515AbUBJQ7z>;
	Tue, 10 Feb 2004 16:59:55 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id BAA04998;
	Wed, 11 Feb 2004 01:59:51 +0900 (JST)
Received: 4UMDO00 id i1AGxpP09344; Wed, 11 Feb 2004 01:59:51 +0900 (JST)
Received: 4UMRO01 id i1AGxod19261; Wed, 11 Feb 2004 01:59:50 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Wed, 11 Feb 2004 01:59:47 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.4] Added IDE IRQ share support for IBM WorkPad z50
Message-Id: <20040211015947.7ae0f667.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

I made a patch for IBM WorkPad z50.
This patch added IDE IRQ share support for IBM WorkPad z50.

Please apply this patch to v2.4.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/config-shared.in linux/arch/mips/config-shared.in
--- linux-orig/arch/mips/config-shared.in	Fri Feb  6 08:33:13 2004
+++ linux/arch/mips/config-shared.in	Wed Feb 11 01:53:08 2004
@@ -444,6 +444,7 @@
    define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_ISA y
    define_bool CONFIG_SCSI n
+   define_bool CONFIG_IDEPCI_SHARE_IRQ y
 fi
 if [ "$CONFIG_LASAT" = "y" ]; then
    define_bool CONFIG_BOARD_SCACHE y
diff -urN -X dontdiff linux-orig/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-orig/drivers/ide/ide-probe.c	Thu Nov 27 00:29:14 2003
+++ linux/drivers/ide/ide-probe.c	Wed Feb 11 01:53:08 2004
@@ -1077,9 +1077,9 @@
 	 */
 	if (!match || match->irq != hwif->irq) {
 		int sa = SA_INTERRUPT;
-#if defined(__mc68000__) || defined(CONFIG_APUS)
+#if defined(__mc68000__) || defined(CONFIG_APUS) || defined(CONFIG_IBM_WORKPAD)
 		sa = SA_SHIRQ;
-#endif /* __mc68000__ || CONFIG_APUS */
+#endif /* __mc68000__ || CONFIG_APUS || CONFIG_IBM_WORKPAD */
 
 		if (IDE_CHIPSET_IS_PCI(hwif->chipset)) {
 			sa = SA_SHIRQ;
