Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jan 2004 06:46:02 +0000 (GMT)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:26572 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225405AbUAFGp5>;
	Tue, 6 Jan 2004 06:45:57 +0000
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id PAA15609;
	Tue, 6 Jan 2004 15:45:54 +0900 (JST)
Received: 4UMDO01 id i066jrF04737; Tue, 6 Jan 2004 15:45:53 +0900 (JST)
Received: 4UMRO01 id i066jq411433; Tue, 6 Jan 2004 15:45:53 +0900 (JST)
	from rally.montavista.co.jp (sonicwall.montavista.co.jp [202.232.97.131]) (authenticated)
Date: Tue, 6 Jan 2004 15:45:52 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.6] fixed the file name of an include file for
 pci-vr41xx.c
Message-Id: <20040106154552.6650d4ff.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

I made a patch for pci-vr41xx.c.
This patch fixes the file name of an include file.

Please apply this patch.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/pci/pci-vr41xx.c linux/arch/mips/pci/pci-vr41xx.c
--- linux-orig/arch/mips/pci/pci-vr41xx.c	2003-06-13 23:19:56.000000000 +0900
+++ linux/arch/mips/pci/pci-vr41xx.c	2004-01-06 15:24:11.000000000 +0900
@@ -49,7 +49,7 @@
 #include <asm/pci_channel.h>
 #include <asm/vr41xx/vr41xx.h>
 
-#include "pciu.h"
+#include "pci-vr41xx.h"
 
 extern unsigned long vr41xx_vtclock;
 
