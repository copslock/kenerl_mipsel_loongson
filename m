Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Sep 2016 17:32:37 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:58106 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992213AbcILPcHhb9NG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Sep 2016 17:32:07 +0200
Received: from localhost (pes75-3-78-192-101-3.fbxo.proxad.net [78.192.101.3])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 769B2943;
        Mon, 12 Sep 2016 15:32:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.7 41/59] irqchip/mips-gic: Implement activate op for device domain
Date:   Mon, 12 Sep 2016 17:30:01 +0200
Message-Id: <20160912152130.494637903@linuxfoundation.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160912152128.765864031@linuxfoundation.org>
References: <20160912152128.765864031@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55107
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

4.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit 2564970a381651865364974ea414384b569cb9c0 upstream.

If an IRQ is setup using __setup_irq(), which is used by the
request_irq() family of functions, and we are using an SMP kernel then
the affinity of the IRQ will be set via setup_affinity() immediately
after the IRQ is enabled. This call to gic_set_affinity() will lead to
the interrupt being mapped to a VPE. However there are other ways to use
IRQs which don't cause affinity to be set, for example if it is used to
chain to another IRQ controller with irq_set_chained_handler_and_data().
The irq_set_chained_handler_and_data() code path will enable the IRQ,
but will not trigger a call to gic_set_affinity() and in this case
nothing will map the interrupt to a VPE, meaning that the interrupt is
never received.

Fix this by implementing the activate operation for the GIC device IRQ
domain, using gic_shared_irq_domain_map() to map the interrupt to the
correct pin of cpu 0.

Fixes: c98c1822ee13 ("irqchip/mips-gic: Add device hierarchy domain")
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Link: http://lkml.kernel.org/r/20160819170715.27820-2-paul.burton@imgtec.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-mips-gic.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -893,10 +893,17 @@ void gic_dev_domain_free(struct irq_doma
 	return;
 }
 
+static void gic_dev_domain_activate(struct irq_domain *domain,
+				    struct irq_data *d)
+{
+	gic_shared_irq_domain_map(domain, d->irq, d->hwirq, 0);
+}
+
 static struct irq_domain_ops gic_dev_domain_ops = {
 	.xlate = gic_dev_domain_xlate,
 	.alloc = gic_dev_domain_alloc,
 	.free = gic_dev_domain_free,
+	.activate = gic_dev_domain_activate,
 };
 
 static int gic_ipi_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
