Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Mar 2004 15:13:48 +0000 (GMT)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:30953 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225579AbUCBPNr>;
	Tue, 2 Mar 2004 15:13:47 +0000
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id AAA04792;
	Wed, 3 Mar 2004 00:13:43 +0900 (JST)
Received: 4UMDO01 id i22FDgM11306; Wed, 3 Mar 2004 00:13:42 +0900 (JST)
Received: 4UMRO01 id i22FDff19318; Wed, 3 Mar 2004 00:13:42 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Wed, 3 Mar 2004 00:13:40 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.6] Change Kconfig about companion chip for vr41xx
Message-Id: <20040303001340.7d1fb289.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch changes Kconfig about companion chip for vr41xx.
Please apply this patch to v2.6.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/Kconfig linux/arch/mips/Kconfig
--- linux-orig/arch/mips/Kconfig	Tue Mar  2 22:58:45 2004
+++ linux/arch/mips/Kconfig	Wed Mar  3 00:04:44 2004
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
@@ -779,14 +791,6 @@
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
