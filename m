Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Dec 2003 02:48:50 +0000 (GMT)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:57337 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8224934AbTL1Csp>;
	Sun, 28 Dec 2003 02:48:45 +0000
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id LAA15760;
	Sun, 28 Dec 2003 11:48:42 +0900 (JST)
Received: 4UMDO01 id hBS2mf308021; Sun, 28 Dec 2003 11:48:41 +0900 (JST)
Received: 4UMRO00 id hBS2meQ20543; Sun, 28 Dec 2003 11:48:41 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Sun, 28 Dec 2003 11:48:39 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.6] Add early_initcall for TANBAC TB0226
Message-Id: <20031228114839.445d3b70.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

I made the patch for setup.c of TANBAC TB0226.
I added early_initcall() for tanbac_tb0226_setup().

This patch exists for HEAD of linux-mips.org CVS.
Please apply this patch.

diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0226/setup.c linux/arch/mips/vr41xx/tanbac-tb0226/setup.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0226/setup.c	Fri Oct 31 11:30:39 2003
+++ linux/arch/mips/vr41xx/tanbac-tb0226/setup.c	Sun Dec 28 11:36:26 2003
@@ -111,3 +111,5 @@
 	vr41xx_pciu_init(&pci_address_map);
 #endif
 }
+
+early_initcall(tanbac_tb0226_setup);
