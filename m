Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2004 10:13:02 +0000 (GMT)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:38125 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8224858AbUCCKM7>;
	Wed, 3 Mar 2004 10:12:59 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id TAA15821;
	Wed, 3 Mar 2004 19:12:53 +0900 (JST)
Received: 4UMDO00 id i23ACrJ12820; Wed, 3 Mar 2004 19:12:53 +0900 (JST)
Received: 4UMRO00 id i23ACqb21128; Wed, 3 Mar 2004 19:12:52 +0900 (JST)
	from rally.montavista.co.jp (sonicwall.montavista.co.jp [202.232.97.131]) (authenticated)
Date: Wed, 3 Mar 2004 19:12:51 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.6] Fixed PCMCIA configuration about vr41xx
Message-Id: <20040303191251.4af2445c.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch moves the menu about PCMCIA for vr41xx to the right position,
and also fixes depends about VRC4173.

Please apply this patch to v2.6.

Yoichi

diff -urN -X dontdiff linux-orig/drivers/pcmcia/Kconfig linux/drivers/pcmcia/Kconfig
--- linux-orig/drivers/pcmcia/Kconfig	2004-02-25 12:12:08.000000000 +0900
+++ linux/drivers/pcmcia/Kconfig	2004-03-02 14:50:37.000000000 +0900
@@ -105,17 +105,17 @@
 
 	  This driver is also available as a module called sa1111_cs.
 
-config PCMCIA_PROBE
-	bool
-	default y if ISA && !ARCH_SA1100 && !ARCH_CLPS711X
-
 config PCMCIA_VRC4171
 	tristate "NEC VRC4171 Card Controllers support"
 	depends on VRC4171 && PCMCIA
 
 config PCMCIA_VRC4173
-	tristate "NEC VRC4173 CARDU support"
-	depends on CPU_VR41XX && PCI && PCMCIA
+	tristate "NEC VRC4173 Card Uint support"
+	depends on VRC4173 && PCMCIA
+
+config PCMCIA_PROBE
+	bool
+	default y if ISA && !ARCH_SA1100 && !ARCH_CLPS711X
 
 endmenu
 
