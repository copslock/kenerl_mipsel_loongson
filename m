Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2003 03:49:42 +0000 (GMT)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:1519 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225475AbTLSDtV>;
	Fri, 19 Dec 2003 03:49:21 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id MAA13921;
	Fri, 19 Dec 2003 12:49:18 +0900 (JST)
Received: 4UMDO00 id hBJ3nHs28632; Fri, 19 Dec 2003 12:49:17 +0900 (JST)
Received: 4UMRO00 id hBJ3nHu23112; Fri, 19 Dec 2003 12:49:17 +0900 (JST)
	from rally.montavista.co.jp (sonicwall.montavista.co.jp [202.232.97.131]) (authenticated)
Date: Fri, 19 Dec 2003 12:49:17 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.6] add #define for clock of VRC4173
Message-Id: <20031219124917.4dea3d74.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

I made the patch for vrc4173.h.
It add #define for clock of VRC4173.

This patch exists for HEAD of linux-mips.org CVS.
Please apply this patch.

Yoichi

diff -urN -X dontdiff linux-orig/include/asm-mips/vr41xx/vrc4173.h linux/include/asm-mips/vr41xx/vrc4173.h
--- linux-orig/include/asm-mips/vr41xx/vrc4173.h	2003-11-25 15:29:27.000000000 +0900
+++ linux/include/asm-mips/vr41xx/vrc4173.h	2003-12-19 12:29:25.000000000 +0900
@@ -72,6 +72,19 @@
 /*
  * Clock Mask Unit
  */
+#define VRC4173_PIU_CLOCK		0x0001
+#define VRC4173_KIU_CLOCK		0x0002
+#define VRC4173_AIU_CLOCK		0x0004
+#define VRC4173_PS2CH1_CLOCK		0x0008
+#define VRC4173_PS2CH2_CLOCK		0x0010
+#define VRC4173_USBU_PCI_CLOCK		0x0020
+#define VRC4173_CARDU1_PCI_CLOCK	0x0040
+#define VRC4173_CARDU2_PCI_CLOCK	0x0080
+#define VRC4173_AC97U_PCI_CLOCK		0x0100
+#define VRC4173_USBU_48MHz_CLOCK	0x0400
+#define VRC4173_EXT_48MHz_CLOCK		0x0800
+#define VRC4173_48MHz_CLOCK		0x1000
+
 extern void vrc4173_clock_supply(u16 mask);
 extern void vrc4173_clock_mask(u16 mask);
 
