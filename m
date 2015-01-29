Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2015 12:15:44 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43123 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012169AbbA2LOjIW7xo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2015 12:14:39 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 74977D0ECD30E;
        Thu, 29 Jan 2015 11:14:31 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 29 Jan 2015 11:14:33 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 29 Jan 2015 11:14:32 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH 4/9] irqchip: mips-gic: Add function for retrieving FDC IRQ
Date:   Thu, 29 Jan 2015 11:14:09 +0000
Message-ID: <1422530054-7976-5-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1422530054-7976-1-git-send-email-james.hogan@imgtec.com>
References: <1422530054-7976-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Add a function to the MIPS GIC driver for retrieving the Fast Debug
Channel (FDC) interrupt number, similar to the existing ones for the
timer and perf counter interrupts. This will be used by platform
implementations of get_c0_fdc_int() if a GIC is present.

A workaround exists for interAptiv and proAptiv which claim to be able
to route the FDC interrupt but don't seem to be able to in practice (at
least on Malta).

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Andrew Bresticker <abrestic@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: linux-mips@linux-mips.org
---
 drivers/irqchip/irq-mips-gic.c   | 23 +++++++++++++++++++++++
 include/linux/irqchip/mips-gic.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index bcfead6e8ae6..00379550cd71 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -234,6 +234,29 @@ int gic_get_c0_perfcount_int(void)
 				  GIC_LOCAL_TO_HWIRQ(GIC_LOCAL_INT_PERFCTR));
 }
 
+int gic_get_c0_fdc_int(void)
+{
+	if (!gic_local_irq_is_routable(GIC_LOCAL_INT_FDC)) {
+		/* Is the FDC IRQ even present? */
+		if (cp0_fdc_irq < 0)
+			return -1;
+		return MIPS_CPU_IRQ_BASE + cp0_fdc_irq;
+	}
+
+	/*
+	 * Some cores claim the FDC is routable but it doesn't actually seem to
+	 * be connected.
+	 */
+	switch (current_cpu_type()) {
+	case CPU_INTERAPTIV:
+	case CPU_PROAPTIV:
+		return -1;
+	}
+
+	return irq_create_mapping(gic_irq_domain,
+				  GIC_LOCAL_TO_HWIRQ(GIC_LOCAL_INT_FDC));
+}
+
 static unsigned int gic_get_int(void)
 {
 	unsigned int i;
diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
index ff0e75f40ef5..8e9940040e6d 100644
--- a/include/linux/irqchip/mips-gic.h
+++ b/include/linux/irqchip/mips-gic.h
@@ -252,4 +252,5 @@ extern unsigned int plat_ipi_resched_int_xlate(unsigned int);
 extern unsigned int gic_get_timer_pending(void);
 extern int gic_get_c0_compare_int(void);
 extern int gic_get_c0_perfcount_int(void);
+extern int gic_get_c0_fdc_int(void);
 #endif /* __LINUX_IRQCHIP_MIPS_GIC_H */
-- 
2.0.5
