Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2010 17:15:45 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:51576 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493021Ab0LAQPm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Dec 2010 17:15:42 +0100
Received: by gyg4 with SMTP id 4so3783832gyg.36
        for <multiple recipients>; Wed, 01 Dec 2010 08:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=nmsN8bV4OIvGebIUXaCKQc0y2Vo3PV/5GXBvjQvT9sQ=;
        b=InTSHDhbBa0XxLZlBNBt0DNP3bo8seY8vxB5ybHTcJ7u074IWHjMukH0goaEthzTwg
         Vf7h7PrbjWq4f97kPU7+31y3h/fEKWStQ0NaXbvoXR8X0bi15/Va5sxUElvBiFc9JwqO
         ot7kbFL+Q1b9PNPwK9KHhTBSoqZRmXC6eVO/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=Ns8H9luAIJ+47peboyL+JoSjXjA6TKtWpFCnTbK8eMdgIb41mjUZ+LNPQU+dO5s3Ib
         3JZRG7kgN+gTetLDstXO2hi7jQS52ixlj6MP/dUO19giyxYlaxKE14Gy0AVa6xDYgzm7
         zYEWMojHPmUgC2PwC7geW+yxEUKNUWHLtBWl8=
Received: by 10.223.70.194 with SMTP id e2mr982280faj.128.1291220134672;
        Wed, 01 Dec 2010 08:15:34 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id r24sm67329fax.27.2010.12.01.08.15.32
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 08:15:34 -0800 (PST)
Subject: [RFC 1/3] VSMP support for msp71xx family of platforms.
From:   Anoop P A <anoop.pa@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        mcdonald.shane@gmail.com
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 01 Dec 2010 21:48:27 +0530
Message-ID: <1291220307.31413.14.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

>From e5148874243f0b2b610cd6b077084bd782961d94 Mon Sep 17 00:00:00 2001
Message-Id:
<e5148874243f0b2b610cd6b077084bd782961d94.1291219118.git.anoop.pa@gmail.com>
In-Reply-To: <cover.1291219118.git.anoop.pa@gmail.com>
References: <cover.1291219118.git.anoop.pa@gmail.com>
From: Anoop P A <anoop.pa@gmail.com>
Date: Wed, 1 Dec 2010 20:58:28 +0530
Subject: [RFC 1/3] VSMP support for msp71xx family of platforms.
 
Cc: anoop.pa@gmail.com

msp_smp.c initiliase IPI call and resched irq.

Signed-off-by: Anoop P A <anoop.pa@gmail.com>
---
 arch/mips/pmc-sierra/msp71xx/Makefile  |    3 +-
 arch/mips/pmc-sierra/msp71xx/msp_smp.c |   75
++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/pmc-sierra/msp71xx/msp_smp.c

diff --git a/arch/mips/pmc-sierra/msp71xx/Makefile
b/arch/mips/pmc-sierra/msp71xx/Makefile
index e107f79..09627ae 100644
--- a/arch/mips/pmc-sierra/msp71xx/Makefile
+++ b/arch/mips/pmc-sierra/msp71xx/Makefile
@@ -6,7 +6,8 @@ obj-y += msp_prom.o msp_setup.o msp_irq.o \
 obj-$(CONFIG_HAVE_GPIO_LIB) += gpio.o gpio_extended.o
 obj-$(CONFIG_PMC_MSP7120_GW) += msp_hwbutton.o
 obj-$(CONFIG_IRQ_MSP_SLP) += msp_irq_slp.o
-obj-$(CONFIG_IRQ_MSP_CIC) += msp_irq_cic.o
+obj-$(CONFIG_IRQ_MSP_CIC) += msp_irq_cic.o msp_irq_per.o
 obj-$(CONFIG_PCI) += msp_pci.o
 obj-$(CONFIG_MSPETH) += msp_eth.o
 obj-$(CONFIG_USB_MSP71XX) += msp_usb.o
+obj-$(CONFIG_MIPS_MT_SMP) += msp_smp.o
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_smp.c
b/arch/mips/pmc-sierra/msp71xx/msp_smp.c
new file mode 100644
index 0000000..31a6c72
--- /dev/null
+++ b/arch/mips/pmc-sierra/msp71xx/msp_smp.c
@@ -0,0 +1,75 @@
+/*
+ * Copyright (C) 2000, 2001, 2004 MIPS Technologies, Inc.
+ * Copyright (C) 2001 Ralf Baechle
+ * Copyright (C) 2010 PMC-Sierra, Inc.
+ *
+ *  VSMP support for MSP platforms . Derived from malta vsmp support.
+ *
+ *  This program is free software; you can distribute it and/or modify
it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but
WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
along
+ *  with this program; if not, write to the Free Software Foundation,
Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ */
+#include <linux/smp.h>
+#include <linux/interrupt.h>
+
+#ifdef CONFIG_MIPS_MT_SMP
+#define MIPS_CPU_IPI_RESCHED_IRQ 0	/* SW int 0 for resched */
+#define MIPS_CPU_IPI_CALL_IRQ 1		/* SW int 1 for call */
+
+
+static void ipi_resched_dispatch(void)
+{
+	do_IRQ(MIPS_CPU_IPI_RESCHED_IRQ);
+}
+
+static void ipi_call_dispatch(void)
+{
+	do_IRQ(MIPS_CPU_IPI_CALL_IRQ);
+}
+
+static irqreturn_t ipi_resched_interrupt(int irq, void *dev_id)
+{
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ipi_call_interrupt(int irq, void *dev_id)
+{
+	smp_call_function_interrupt();
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction irq_resched = {
+	.handler	= ipi_resched_interrupt,
+	.flags		= IRQF_DISABLED|IRQF_PERCPU,
+	.name		= "IPI_resched"
+};
+
+static struct irqaction irq_call = {
+	.handler	= ipi_call_interrupt,
+	.flags		= IRQF_DISABLED|IRQF_PERCPU,
+	.name		= "IPI_call"
+};
+void __init arch_init_ipiirq(int irq, struct irqaction *action)
+{
+	setup_irq(irq, action);
+	set_irq_handler(irq, handle_percpu_irq);
+}
+void __init msp_vsmp_int_init(void)
+{
+	set_vi_handler (MIPS_CPU_IPI_RESCHED_IRQ, ipi_resched_dispatch);
+	set_vi_handler (MIPS_CPU_IPI_CALL_IRQ, ipi_call_dispatch);
+	arch_init_ipiirq(MIPS_CPU_IPI_RESCHED_IRQ, &irq_resched);
+	arch_init_ipiirq(MIPS_CPU_IPI_CALL_IRQ, &irq_call);
+}
+#endif /* CONFIG_MIPS_MT_SMP */
-- 
1.7.0.4
