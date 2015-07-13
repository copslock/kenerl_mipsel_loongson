Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 22:47:18 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:56970 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011069AbbGMUqGRElXV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 22:46:06 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZEkc0-0006VS-Ro; Mon, 13 Jul 2015 22:46:04 +0200
Message-Id: <20150713200714.765131309@linutronix.de>
User-Agent: quilt/0.63-1
Date:   Mon, 13 Jul 2015 20:45:58 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        linux-mips@linux-mips.org,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [patch 04/12] MIPS/pci-rt3883: Consolidate chained IRQ handler
 install/remove
References: <20150713200602.799079101@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline;
 filename=MIPS-pci-rt3883-Consolidate-chained-IRQ-handler-inst.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001,URIBL_BLOCKED=0.001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48236
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

Chained irq handlers usually set up handler data as well. We now have
a function to set both under irq_desc->lock. Replace the two calls
with one.

Search and conversion was done with coccinelle.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/pci/pci-rt3883.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: tip/arch/mips/pci/pci-rt3883.c
===================================================================
--- tip.orig/arch/mips/pci/pci-rt3883.c
+++ tip/arch/mips/pci/pci-rt3883.c
@@ -225,8 +225,7 @@ static int rt3883_pci_irq_init(struct de
 		return -ENODEV;
 	}
 
-	irq_set_handler_data(irq, rpc);
-	irq_set_chained_handler(irq, rt3883_pci_irq_handler);
+	irq_set_chained_handler_and_data(irq, rt3883_pci_irq_handler, rpc);
 
 	return 0;
 }
