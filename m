Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Apr 2015 11:44:49 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28032 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025467AbbDQJo3mQCZp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Apr 2015 11:44:29 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 416B01DDFF4BD;
        Fri, 17 Apr 2015 10:44:23 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 17 Apr 2015 10:44:25 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 17 Apr 2015 10:44:24 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>
CC:     James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 1/2] MIPS: Malta: Make GIC FDC IRQ workaround Malta specific
Date:   Fri, 17 Apr 2015 10:44:15 +0100
Message-ID: <1429263856-30471-2-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1429263856-30471-1-git-send-email-james.hogan@imgtec.com>
References: <1429263856-30471-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46877
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

Wider testing reveals that the Fast Debug Channel (FDC) interrupt is
routed through the GIC just fine on Pistachio SoC, even though it
contains interAptiv cores. Clearly the FDC interrupt routing problems
previously observed on interAptiv and proAptiv cores are specific to the
Malta FPGA bitstreams.

Move the workaround for interAptiv and proAptiv out of
gic_get_c0_fdc_int() in the GIC irqchip driver into Malta's
get_c0_fdc_int() platform callback, to allow the Pistachio SoC to use
the FDC interrupt.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Andrew Bresticker <abrestic@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: linux-mips@linux-mips.org
---
 arch/mips/mti-malta/malta-time.c | 20 +++++++++++++-------
 drivers/irqchip/irq-mips-gic.c   | 10 ----------
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index 185e68261f45..5625b190edc0 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -119,18 +119,24 @@ void read_persistent_clock(struct timespec *ts)
 
 int get_c0_fdc_int(void)
 {
-	int mips_cpu_fdc_irq;
+	/*
+	 * Some cores claim the FDC is routable through the GIC, but it doesn't
+	 * actually seem to be connected for those Malta bitstreams.
+	 */
+	switch (current_cpu_type()) {
+	case CPU_INTERAPTIV:
+	case CPU_PROAPTIV:
+		return -1;
+	};
 
 	if (cpu_has_veic)
-		mips_cpu_fdc_irq = -1;
+		return -1;
 	else if (gic_present)
-		mips_cpu_fdc_irq = gic_get_c0_fdc_int();
+		return gic_get_c0_fdc_int();
 	else if (cp0_fdc_irq >= 0)
-		mips_cpu_fdc_irq = MIPS_CPU_IRQ_BASE + cp0_fdc_irq;
+		return MIPS_CPU_IRQ_BASE + cp0_fdc_irq;
 	else
-		mips_cpu_fdc_irq = -1;
-
-	return mips_cpu_fdc_irq;
+		return -1;
 }
 
 int get_c0_perfcount_int(void)
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index bc48b7dc89ec..6b1ff9ec99be 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -257,16 +257,6 @@ int gic_get_c0_fdc_int(void)
 		return MIPS_CPU_IRQ_BASE + cp0_fdc_irq;
 	}
 
-	/*
-	 * Some cores claim the FDC is routable but it doesn't actually seem to
-	 * be connected.
-	 */
-	switch (current_cpu_type()) {
-	case CPU_INTERAPTIV:
-	case CPU_PROAPTIV:
-		return -1;
-	}
-
 	return irq_create_mapping(gic_irq_domain,
 				  GIC_LOCAL_TO_HWIRQ(GIC_LOCAL_INT_FDC));
 }
-- 
2.0.5
