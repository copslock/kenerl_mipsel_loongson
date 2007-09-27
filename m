Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Sep 2007 12:24:54 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:43695 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027260AbXI0LYw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Sep 2007 12:24:52 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8RBOooe019081;
	Thu, 27 Sep 2007 12:24:50 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8RBOmx8019080;
	Thu, 27 Sep 2007 12:24:48 +0100
Date:	Thu, 27 Sep 2007 12:24:48 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Molnar Ingo <mingo@elte.hu>, benh@kernel.crashing.org
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH] Compile handle_percpu_irq even for uniprocessor kernels
Message-ID: <20070927112448.GA16909@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Compiling handle_percpu_irq only on uniprocessor generates an artificial
special case so a typical use like:

  set_irq_chip_and_handler(irq, &some_irq_type, handle_percpu_irq);

needs to be conditionally compiled only on SMP systems as well and an
alternative UP construct is usually needed - for no good reason.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

---
This fixes uniprocessor configurations for some MIPS SMP systems.

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index f1a73f0..9b5dff6 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -503,7 +503,6 @@ out_unlock:
 	spin_unlock(&desc->lock);
 }
 
-#ifdef CONFIG_SMP
 /**
  *	handle_percpu_IRQ - Per CPU local irq handler
  *	@irq:	the interrupt number
@@ -529,8 +528,6 @@ handle_percpu_irq(unsigned int irq, struct irq_desc *desc)
 		desc->chip->eoi(irq);
 }
 
-#endif /* CONFIG_SMP */
-
 void
 __set_irq_handler(unsigned int irq, irq_flow_handler_t handle, int is_chained,
 		  const char *name)
