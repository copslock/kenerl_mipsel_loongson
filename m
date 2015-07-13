Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 22:48:32 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:56995 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011082AbbGMUqMmO2pV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 22:46:12 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZEkc6-0006WP-UI; Mon, 13 Jul 2015 22:46:11 +0200
Message-Id: <20150713200715.113667554@linutronix.de>
User-Agent: quilt/0.63-1
Date:   Mon, 13 Jul 2015 20:46:04 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        linux-mips@linux-mips.org
Subject: [patch 08/12] MIPS/alchemy: Remove pointless irqdisable/enable
References: <20150713200602.799079101@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline;
 filename=MIPS-alchemy--Remove-pointless-irqdisable-enable.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001,URIBL_BLOCKED=0.001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48240
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

bcsr_csc_handler() is a cascading interrupt handler. It has a
disable_irq_nosync()/enable_irq() pair around the generic_handle_irq()
call. The value of this disable/enable is zero because its a complete
noop:

disable_irq_nosync() merily increments the disable count without
actually masking the interrupt. enable_irq() soleley decrements the
disable count without touching the interrupt chip. The interrupt
cannot arrive again because the complete call chain runs with
interrupts disabled.

Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/alchemy/devboards/bcsr.c |    2 --
 1 file changed, 2 deletions(-)

Index: tip/arch/mips/alchemy/devboards/bcsr.c
===================================================================
--- tip.orig/arch/mips/alchemy/devboards/bcsr.c
+++ tip/arch/mips/alchemy/devboards/bcsr.c
@@ -89,9 +89,7 @@ static void bcsr_csc_handler(unsigned in
 {
 	unsigned short bisr = __raw_readw(bcsr_virt + BCSR_REG_INTSTAT);
 
-	disable_irq_nosync(irq);
 	generic_handle_irq(bcsr_csc_base + __ffs(bisr));
-	enable_irq(irq);
 }
 
 static void bcsr_irq_mask(struct irq_data *d)
