Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jul 2015 01:22:25 +0200 (CEST)
Received: from mail-pd0-f169.google.com ([209.85.192.169]:32866 "EHLO
        mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010688AbbGVXWXs9-w1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jul 2015 01:22:23 +0200
Received: by pdbnt7 with SMTP id nt7so75036131pdb.0
        for <linux-mips@linux-mips.org>; Wed, 22 Jul 2015 16:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xa+7xzgDvjArak/NHBNB3ZDciccYnS88joJlPijMZYs=;
        b=dqngU4tDxx7sp40llTwWE4Km26Y1dZ3HYO3xhJRZwSBNl3JE12TWRBF2RabkSK36fp
         AC8nTT9cdCNTKBdWmnKycW4FYxgbbgIlz5WEV57swP5aRyTnVBtiei4DxG3kARTle+dG
         1un7X2R1aQCCofbC1A6J9W0ni1z8Kwxemn1tphbmh6QmTeq61S84B1Q80LO6eZd1BnIG
         LsDC7P9Vmxe4k7MVfOk4MxJHCXKHOSGn2DTbZNT87UmKmKY8q/VCvprRrlNp4G2I16At
         gJ7EuS1N0LUD05nfjUkquzu/k3WFvXEC3zuCCHhqvwrfmUIpHfBZeDCVmyCD0z/AmLtb
         nI6w==
X-Received: by 10.66.151.133 with SMTP id uq5mr11205033pab.7.1437607337634;
        Wed, 22 Jul 2015 16:22:17 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([172.22.64.120])
        by smtp.gmail.com with ESMTPSA id o7sm5249786pdi.16.2015.07.22.16.22.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Jul 2015 16:22:16 -0700 (PDT)
From:   Brian Norris <computersforpeace@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Kevin Cernekee <cernekee@chromium.org>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v2 1/2] genirq: add chip_{suspend,resume} PM support to irq_chip
Date:   Wed, 22 Jul 2015 16:21:39 -0700
Message-Id: <1437607300-40858-1-git-send-email-computersforpeace@gmail.com>
X-Mailer: git-send-email 2.4.3.573.g4eafbef
In-Reply-To: <1434756403-379-1-git-send-email-computersforpeace@gmail.com>
References: <1434756403-379-1-git-send-email-computersforpeace@gmail.com>
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

Some (admittedly odd) irqchips perform functions that are not directly
related to any of their child IRQ lines, and therefore need to perform
some tasks during suspend/resume regardless of whether there are
any "installed" interrupts for the irqchip. However, the current
generic-chip framework does not call the chip's irq_{suspend,resume}
when there are no interrupts installed (this makes sense, because there
are no irq_data objects for such a call to be made).

More specifically, irq-bcm7120-l2 configures both a forwarding mask
(which affects other top-level GIC IRQs) and a second-level interrupt
mask (for managing its own child interrupts). The former must be
saved/restored on suspend/resume, even when there's nothing to do for
the latter.

This patch adds a new set of suspend/resume hooks to irq_chip_generic,
to help represent *chip* suspend/resume, rather than IRQ suspend/resume.
These callbacks will always be called for an IRQ chip (regardless of the
installed interrupts) and are based on the per-chip irq_chip_generic
struct, rather than the per-IRQ irq_data struct.

The original problem report is described in extra detail here:
http://lkml.kernel.org/g/20150619224123.GL4917@ld-irv-0074

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
---
v1: https://lkml.org/lkml/2015/6/19/760

v1 -> v2:
  * clarify the comments on irq_chip::irq_{suspend,resume}
  * add new suspend/resume hooks to the irq_chip_generic instead of irq_chip,
    since that is the right level of abstraction (see v1 discussion)

 include/linux/irq.h       | 14 ++++++++++++--
 kernel/irq/generic-chip.c |  6 ++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 92188b0225bb..9fd346e605ff 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -324,8 +324,10 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
  * @irq_bus_sync_unlock:function to sync and unlock slow bus (i2c) chips
  * @irq_cpu_online:	configure an interrupt source for a secondary CPU
  * @irq_cpu_offline:	un-configure an interrupt source for a secondary CPU
- * @irq_suspend:	function called from core code on suspend once per chip
- * @irq_resume:		function called from core code on resume once per chip
+ * @irq_suspend:	function called from core code on suspend once per
+ *			chip, when one or more interrupts are installed
+ * @irq_resume:		function called from core code on resume once per chip,
+ *			when one ore more interrupts are installed
  * @irq_pm_shutdown:	function called from core code on shutdown once per chip
  * @irq_calc_mask:	Optional function to set irq_data.mask for special cases
  * @irq_print_chip:	optional to print special chip info in show_interrupts
@@ -761,6 +763,12 @@ struct irq_chip_type {
  * @reg_base:		Register base address (virtual)
  * @reg_readl:		Alternate I/O accessor (defaults to readl if NULL)
  * @reg_writel:		Alternate I/O accessor (defaults to writel if NULL)
+ * @suspend:		Function called from core code on suspend once per
+ *			chip; can be useful instead of irq_chip::suspend to
+ *			handle chip details even when no interrupts are in use
+ * @resume:		Function called from core code on resume once per chip;
+ *			can be useful instead of irq_chip::suspend to handle
+ *			chip details even when no interrupts are in use
  * @irq_base:		Interrupt base nr for this chip
  * @irq_cnt:		Number of interrupts handled by this chip
  * @mask_cache:		Cached mask register shared between all chip types
@@ -787,6 +795,8 @@ struct irq_chip_generic {
 	void __iomem		*reg_base;
 	u32			(*reg_readl)(void __iomem *addr);
 	void			(*reg_writel)(u32 val, void __iomem *addr);
+	void			(*suspend)(struct irq_chip_generic *gc);
+	void			(*resume)(struct irq_chip_generic *gc);
 	unsigned int		irq_base;
 	unsigned int		irq_cnt;
 	u32			mask_cache;
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index 15b370daf234..abd286afbd27 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -553,6 +553,9 @@ static int irq_gc_suspend(void)
 			if (data)
 				ct->chip.irq_suspend(data);
 		}
+
+		if (gc->suspend)
+			gc->suspend(gc);
 	}
 	return 0;
 }
@@ -564,6 +567,9 @@ static void irq_gc_resume(void)
 	list_for_each_entry(gc, &gc_list, list) {
 		struct irq_chip_type *ct = gc->chip_types;
 
+		if (gc->resume)
+			gc->resume(gc);
+
 		if (ct->chip.irq_resume) {
 			struct irq_data *data = irq_gc_get_irq_data(gc);
 
-- 
2.4.3.573.g4eafbef
