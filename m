Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jul 2004 17:01:23 +0100 (BST)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:51412 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225208AbUG2QBT>;
	Thu, 29 Jul 2004 17:01:19 +0100
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id BAA15169;
	Fri, 30 Jul 2004 01:01:15 +0900 (JST)
Received: 4UMDO01 id i6TG1Ej13611; Fri, 30 Jul 2004 01:01:14 +0900 (JST)
Received: 4UMRO00 id i6TG1CMR004861; Fri, 30 Jul 2004 01:01:13 +0900 (JST)
	from stratos (localhost [127.0.0.1]) (authenticated)
Date: Fri, 30 Jul 2004 01:01:12 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] vr41xx: remove obsolete flag
Message-Id: <20040730010112.3b54404b.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch removes an obsolete flag in serial driver. 

Please apply this patch to v2.6 CVS tree.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/serial.c linux/arch/mips/vr41xx/common/serial.c
--- linux-orig/arch/mips/vr41xx/common/serial.c	Thu Jul 22 00:29:06 2004
+++ linux/arch/mips/vr41xx/common/serial.c	Thu Jul 29 00:49:32 2004
@@ -160,7 +160,7 @@
 	port.line = vr41xx_serial_ports;
 	port.uartclk = DSIU_BASE_BAUD * 16;
 	port.irq = DSIU_IRQ;
-	port.flags = UPF_RESOURCES | UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
+	port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
 	port.mapbase = DSIU_BASE;
 	port.regshift = 0;
 	port.iotype = UPIO_MEM;
