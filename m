Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jul 2016 23:32:12 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:36007 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992472AbcGYVblx7f3k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jul 2016 23:31:41 +0200
Received: from localhost (unknown [104.132.1.103])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 169FA959;
        Mon, 25 Jul 2016 21:31:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harvey Hunt <harvey.hunt@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        linux-mips@linux-mips.org, Qais Yousef <qsyousef@gmail.com>,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.6 066/203] irqchip/mips-gic: Fix IRQs in gic_dev_domain
Date:   Mon, 25 Jul 2016 13:54:41 -0700
Message-Id: <20160725203431.991168511@linuxfoundation.org>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160725203429.221747288@linuxfoundation.org>
References: <20160725203429.221747288@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harvey Hunt <harvey.hunt@imgtec.com>

commit 4b2312bd0592708c85ed94368c874819e7013309 upstream.

When allocating a new device IRQ, gic_dev_domain_alloc() correctly calls
irq_domain_set_hwirq_and_chip(), but gic_irq_domain_alloc() does not. This
means that gic_irq_domain believes all IRQs from the dev domain have an
hwirq of 0 and creates incorrect mappings in the linear_revmap. As
gic_irq_domain is a parent of the gic_dev_domain, this leads to an
inability to boot on devices with a GIC. Excerpt of the error:

[    2.297649] irq 0: nobody cared (try booting with the "irqpoll" option)
...
[    2.436963] handlers:
[    2.439492] Disabling IRQ #0

Fix this by calling irq_domain_set_hwirq_and_chip() for both the dev and
irq domain.

Now that we are modifying the parent domain, be sure to clear it up in
case of an allocation error.

Fixes: c98c1822ee13 ("irqchip/mips-gic: Add device hierarchy domain")
Fixes: 2af70a962070 ("irqchip/mips-gic: Add a IPI hierarchy domain")
Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
Tested-by: Govindraj Raja <Govindraj.Raja@imgtec.com> # On Pistachio SoC
Reviewed-by: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: Qais Yousef <qsyousef@gmail.com>
Cc: jason@lakedaemon.net
Cc: marc.zyngier@arm.com
Link: http://lkml.kernel.org/r/1464001552-31174-1-git-send-email-harvey.hunt@imgtec.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-mips-gic.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -734,6 +734,12 @@ static int gic_irq_domain_alloc(struct i
 		/* verify that it doesn't conflict with an IPI irq */
 		if (test_bit(spec->hwirq, ipi_resrv))
 			return -EBUSY;
+
+		hwirq = GIC_SHARED_TO_HWIRQ(spec->hwirq);
+
+		return irq_domain_set_hwirq_and_chip(d, virq, hwirq,
+						     &gic_level_irq_controller,
+						     NULL);
 	} else {
 		base_hwirq = find_first_bit(ipi_resrv, gic_shared_intrs);
 		if (base_hwirq == gic_shared_intrs) {
@@ -855,10 +861,14 @@ static int gic_dev_domain_alloc(struct i
 						    &gic_level_irq_controller,
 						    NULL);
 		if (ret)
-			return ret;
+			goto error;
 	}
 
 	return 0;
+
+error:
+	irq_domain_free_irqs_parent(d, virq, nr_irqs);
+	return ret;
 }
 
 void gic_dev_domain_free(struct irq_domain *d, unsigned int virq,
