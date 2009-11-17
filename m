Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Nov 2009 23:52:15 +0100 (CET)
Received: from www.tglx.de ([62.245.132.106]:42178 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493269AbZKQWwI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Nov 2009 23:52:08 +0100
Received: from localhost.localdomain (www.tglx.de [127.0.0.1])
	by www.tglx.de (8.13.8/8.13.8/TGLX-2007100201) with ESMTP id nAHMp3Pc019218;
	Tue, 17 Nov 2009 23:51:04 +0100
Message-Id: <20091117224916.642102675@linutronix.de>
User-Agent: quilt/0.47-1
Date:	Tue, 17 Nov 2009 22:51:03 -0000
From:	Thomas Gleixner <tglx@linutronix.de>
To:	LKML <linux-kernel@vger.kernel.org>
Cc:	Ingo Molnar <mingo@elte.hu>, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: [patch 08/13] mips: Fixup last users of irq_chip->typename 
References: <20091117224852.846805939@linutronix.de>
Content-Disposition: inline; filename=mips-replace-obsolete-typename.patch
X-Virus-Scanned: clamav-milter 0.95.1 at www.tglx.de
X-Virus-Status:	Clean
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

The typename member of struct irq_chip was kept for migration purposes
and is obsolete since more than 2 years. Fix up the leftovers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/nxp/pnx833x/common/interrupts.c |    4 ++--
 arch/mips/sni/a20r.c                      |    2 +-
 arch/mips/sni/pcimt.c                     |    2 +-
 arch/mips/sni/pcit.c                      |    2 +-
 arch/mips/sni/rm200.c                     |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.6/arch/mips/nxp/pnx833x/common/interrupts.c
===================================================================
--- linux-2.6.orig/arch/mips/nxp/pnx833x/common/interrupts.c
+++ linux-2.6/arch/mips/nxp/pnx833x/common/interrupts.c
@@ -295,7 +295,7 @@ static int pnx833x_set_type_gpio_irq(uns
 }
 
 static struct irq_chip pnx833x_pic_irq_type = {
-	.typename = "PNX-PIC",
+	.name = "PNX-PIC",
 	.startup = pnx833x_startup_pic_irq,
 	.shutdown = pnx833x_shutdown_pic_irq,
 	.enable = pnx833x_enable_pic_irq,
@@ -305,7 +305,7 @@ static struct irq_chip pnx833x_pic_irq_t
 };
 
 static struct irq_chip pnx833x_gpio_irq_type = {
-	.typename = "PNX-GPIO",
+	.name = "PNX-GPIO",
 	.startup = pnx833x_startup_gpio_irq,
 	.shutdown = pnx833x_disable_gpio_irq,
 	.enable = pnx833x_enable_gpio_irq,
Index: linux-2.6/arch/mips/sni/a20r.c
===================================================================
--- linux-2.6.orig/arch/mips/sni/a20r.c
+++ linux-2.6/arch/mips/sni/a20r.c
@@ -188,7 +188,7 @@ static void end_a20r_irq(unsigned int ir
 }
 
 static struct irq_chip a20r_irq_type = {
-	.typename	= "A20R",
+	.name		= "A20R",
 	.ack		= mask_a20r_irq,
 	.mask		= mask_a20r_irq,
 	.mask_ack	= mask_a20r_irq,
Index: linux-2.6/arch/mips/sni/pcimt.c
===================================================================
--- linux-2.6.orig/arch/mips/sni/pcimt.c
+++ linux-2.6/arch/mips/sni/pcimt.c
@@ -214,7 +214,7 @@ static void end_pcimt_irq(unsigned int i
 }
 
 static struct irq_chip pcimt_irq_type = {
-	.typename = "PCIMT",
+	.name = "PCIMT",
 	.ack = disable_pcimt_irq,
 	.mask = disable_pcimt_irq,
 	.mask_ack = disable_pcimt_irq,
Index: linux-2.6/arch/mips/sni/pcit.c
===================================================================
--- linux-2.6.orig/arch/mips/sni/pcit.c
+++ linux-2.6/arch/mips/sni/pcit.c
@@ -176,7 +176,7 @@ void end_pcit_irq(unsigned int irq)
 }
 
 static struct irq_chip pcit_irq_type = {
-	.typename = "PCIT",
+	.name = "PCIT",
 	.ack = disable_pcit_irq,
 	.mask = disable_pcit_irq,
 	.mask_ack = disable_pcit_irq,
Index: linux-2.6/arch/mips/sni/rm200.c
===================================================================
--- linux-2.6.orig/arch/mips/sni/rm200.c
+++ linux-2.6/arch/mips/sni/rm200.c
@@ -449,7 +449,7 @@ void end_rm200_irq(unsigned int irq)
 }
 
 static struct irq_chip rm200_irq_type = {
-	.typename = "RM200",
+	.name = "RM200",
 	.ack = disable_rm200_irq,
 	.mask = disable_rm200_irq,
 	.mask_ack = disable_rm200_irq,
