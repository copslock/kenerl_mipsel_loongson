Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Apr 2004 15:17:05 +0100 (BST)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:23786 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225806AbUDUORD>;
	Wed, 21 Apr 2004 15:17:03 +0100
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id XAA28791;
	Wed, 21 Apr 2004 23:16:59 +0900 (JST)
Received: 4UMDO00 id i3LEGwq03092; Wed, 21 Apr 2004 23:16:59 +0900 (JST)
Received: 4UMRO01 id i3LEGvL09669; Wed, 21 Apr 2004 23:16:58 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Wed, 21 Apr 2004 23:16:56 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [patch][2.6] Kconfig patche for vr41xx's companion chip
Message-Id: <20040421231656.70361328.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

This patch makes vr41xx's companion chip item depend on MACH_VR41XX.

Please apply this patch to cvs.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/Kconfig linux/arch/mips/Kconfig
--- linux-orig/arch/mips/Kconfig	Sun Mar 21 22:06:02 2004
+++ linux/arch/mips/Kconfig	Sun Apr  4 00:14:55 2004
@@ -117,6 +117,18 @@
 	depends on MACH_VR41XX
 	select IRQ_CPU
 
+config VRC4171
+	tristate "add NEC VRC4171 companion chip support"
+	depends on MACH_VR41XX && ISA
+	---help---
+	  The NEC VRC4171/4171A is a companion chip for NEC VR4111/VR4121.
+
+config VRC4173
+	tristate "add NEC VRC4173 companion chip support"
+	depends on MACH_VR41XX && PCI
+	---help---
+	  The NEC VRC4173 is a companion chip for NEC VR4122/VR4131.
+
 config TOSHIBA_JMR3927
 	bool "Support for Toshiba JMR-TX3927 board"
 	depends on MIPS32
@@ -810,14 +822,6 @@
 	bool
 	depends on ZAO_CAPCELLA || VICTOR_MPC30X || SIBYTE_SB1xxx_SOC || NEC_EAGLE || NEC_OSPREY || DDB5477 || CASIO_E55 || TANBAC_TB0226 || TANBAC_TB0229
 	default y
-
-config VRC4171
-	tristate "NEC VRC4171 Support"
-	depends on IBM_WORKPAD
-
-config VRC4173
-	tristate "NEC VRC4173 Support"
-	depends on NEC_EAGLE || VICTOR_MPC30X
 
 config DDB5XXX_COMMON
 	bool
