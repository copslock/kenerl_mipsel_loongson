Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Aug 2004 15:17:59 +0100 (BST)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:47077 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8224911AbUHTORy>;
	Fri, 20 Aug 2004 15:17:54 +0100
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id XAA01789;
	Fri, 20 Aug 2004 23:17:49 +0900 (JST)
Received: 4UMDO01 id i7KEHms28677; Fri, 20 Aug 2004 23:17:49 +0900 (JST)
Received: 4UMRO00 id i7KEHkX3002417; Fri, 20 Aug 2004 23:17:47 +0900 (JST)
	from stratos (localhost [127.0.0.1]) (authenticated)
Date: Fri, 20 Aug 2004 23:17:32 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] vr41xx: arch_init_irq
Message-Id: <20040820231732.5cf3c099.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

The following line isn't needed in arch_init_irq().
Please apply this patch to v2.6 CVS tree.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/icu.c linux/arch/mips/vr41xx/common/icu.c
--- linux-orig/arch/mips/vr41xx/common/icu.c	Fri Aug 20 21:10:27 2004
+++ linux/arch/mips/vr41xx/common/icu.c	Fri Aug 20 22:57:35 2004
@@ -699,8 +699,6 @@
 
 void __init arch_init_irq(void)
 {
-	memset(irq_desc, 0, sizeof(irq_desc));
-
 	mips_cpu_irq_init(MIPS_CPU_IRQ_BASE);
 	init_vr41xx_icu_irq();
 	init_vr41xx_giuint_irq();
