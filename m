Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Jun 2015 01:27:07 +0200 (CEST)
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33923 "EHLO
        mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008582AbbFSX1F3TRlM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Jun 2015 01:27:05 +0200
Received: by pdbki1 with SMTP id ki1so99839227pdb.1
        for <linux-mips@linux-mips.org>; Fri, 19 Jun 2015 16:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QVMhfib5SakvvKxTJYdfCTST0dOtQ5Z/Udz4RCMTozw=;
        b=IURHALFiFL8g/YgSSPZ99fUeTBXp2IKqhyS24oEnW7360yK0Parj5T9WLD9VH3455e
         ttt7TgmVOaoHNk67yfs0wfc2/a7Xb5sAnzFAVU7ez2IYrDRhL3xsaFECym72VTY52lJp
         +4Na0MU4/y4ekjq3JbfRhuUUCyEfGlYdOJ0uNZzM4VkjKJ0cMshNeSOF4TstP4cO/I48
         r/fHDbpUlgiRzCKbib6xCdB27x72FNwkjvC9JKbMkiQZXfN3kROH+CvZoQBgKOfGkcqL
         lvg4CIHgBWoWz1fsIuG+BvuEvDzEHAgEthf28TKuYoq+fmajDAWriGBwPFb/ChbciP55
         lphA==
X-Received: by 10.70.62.6 with SMTP id u6mr35905634pdr.142.1434756419290;
        Fri, 19 Jun 2015 16:26:59 -0700 (PDT)
Received: from ld-irv-0074.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id tm3sm12390441pac.44.2015.06.19.16.26.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Jun 2015 16:26:58 -0700 (PDT)
From:   Brian Norris <computersforpeace@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH 1/2] genirq: add chip_{suspend,resume} PM support to irq_chip
Date:   Fri, 19 Jun 2015 16:26:42 -0700
Message-Id: <1434756403-379-1-git-send-email-computersforpeace@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20150619224123.GL4917@ld-irv-0074>
References: <20150619224123.GL4917@ld-irv-0074>
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47988
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

This patch adds a second set of suspend/resume hooks to irq_chip, this
time to represent *chip* suspend/resume, rather than IRQ suspend/resume.
These callbacks will always be called for an irqchip and are based on
the per-chip irq_chip_generic struct, rather than the per-IRQ irq_data
struct.

The original problem report is described in extra detail here:
http://lkml.kernel.org/g/20150619224123.GL4917@ld-irv-0074

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 include/linux/irq.h       | 10 ++++++++++
 kernel/irq/generic-chip.c |  6 ++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index de3213d271ff..2a672d2434a5 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -293,6 +293,8 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
 	return d->hwirq;
 }
 
+struct irq_chip_generic;
+
 /**
  * struct irq_chip - hardware interrupt chip descriptor
  *
@@ -317,6 +319,12 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
  * @irq_suspend:	function called from core code on suspend once per chip
  * @irq_resume:		function called from core code on resume once per chip
  * @irq_pm_shutdown:	function called from core code on shutdown once per chip
+ * @chip_suspend:	function called from core code on suspend once per
+ *			chip; for handling chip details even when no interrupts
+ *			are in use
+ * @chip_resume:	function called from core code on resume once per chip;
+ *			for handling chip details even when no interrupts are
+ *			in use
  * @irq_calc_mask:	Optional function to set irq_data.mask for special cases
  * @irq_print_chip:	optional to print special chip info in show_interrupts
  * @irq_request_resources:	optional to request resources before calling
@@ -357,6 +365,8 @@ struct irq_chip {
 	void		(*irq_suspend)(struct irq_data *data);
 	void		(*irq_resume)(struct irq_data *data);
 	void		(*irq_pm_shutdown)(struct irq_data *data);
+	void		(*chip_suspend)(struct irq_chip_generic *gc);
+	void		(*chip_resume)(struct irq_chip_generic *gc);
 
 	void		(*irq_calc_mask)(struct irq_data *data);
 
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index 15b370daf234..fe25e72d5d13 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -553,6 +553,9 @@ static int irq_gc_suspend(void)
 			if (data)
 				ct->chip.irq_suspend(data);
 		}
+
+		if (ct->chip.chip_suspend)
+			ct->chip.chip_suspend(gc);
 	}
 	return 0;
 }
@@ -564,6 +567,9 @@ static void irq_gc_resume(void)
 	list_for_each_entry(gc, &gc_list, list) {
 		struct irq_chip_type *ct = gc->chip_types;
 
+		if (ct->chip.chip_resume)
+			ct->chip.chip_resume(gc);
+
 		if (ct->chip.irq_resume) {
 			struct irq_data *data = irq_gc_get_irq_data(gc);
 
-- 
1.9.1
