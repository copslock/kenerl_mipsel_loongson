Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 22:49:48 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:57017 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011092AbbGMUqTQab9V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 22:46:19 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZEkcD-0006Wu-44; Mon, 13 Jul 2015 22:46:17 +0200
Message-Id: <20150713200715.463697490@linutronix.de>
User-Agent: quilt/0.63-1
Date:   Mon, 13 Jul 2015 20:46:10 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        linux-mips@linux-mips.org, Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [patch 12/12] MIPS/PCI/rt3883: Prepare rt3883_pci_irq_handler for irq
 argument removal
References: <20150713200602.799079101@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline;
 filename=MIPS-PCI-rt3883--Prepare-rt3883_pci_irq_handler-for-irq-argument-removal.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001,URIBL_BLOCKED=0.001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

The irq argument of most interrupt flow handlers is unused or merily
used instead of a local variable. The handlers which need the irq
argument can retrieve the irq number from the irq descriptor.

Search and update was done with coccinelle and the invaluable help of
Julia Lawall.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
---
 arch/mips/pci/pci-rt3883.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: tip/arch/mips/pci/pci-rt3883.c
===================================================================
--- tip.orig/arch/mips/pci/pci-rt3883.c
+++ tip/arch/mips/pci/pci-rt3883.c
@@ -129,7 +129,7 @@ static void rt3883_pci_write_cfg32(struc
 	rt3883_pci_w32(rpc, val, RT3883_PCI_REG_CFGDATA);
 }
 
-static void rt3883_pci_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void rt3883_pci_irq_handler(unsigned int __irq, struct irq_desc *desc)
 {
 	struct rt3883_pci_controller *rpc;
 	u32 pending;
@@ -145,7 +145,7 @@ static void rt3883_pci_irq_handler(unsig
 	}
 
 	while (pending) {
-		unsigned bit = __ffs(pending);
+		unsigned irq, bit = __ffs(pending);
 
 		irq = irq_find_mapping(rpc->irq_domain, bit);
 		generic_handle_irq(irq);
