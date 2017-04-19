Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Apr 2017 14:27:27 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6821 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990845AbdDSM05oeX0u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Apr 2017 14:26:57 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C78A037FD9474;
        Wed, 19 Apr 2017 13:26:48 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 19 Apr 2017 13:26:51 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 2/2] Clocksource: mips-gic: Remove redundant non devicetree init
Date:   Wed, 19 Apr 2017 13:26:46 +0100
Message-ID: <1492604806-23420-2-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1492604806-23420-1-git-send-email-matt.redfearn@imgtec.com>
References: <1492604806-23420-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Malta was the only platform probing this driver from platform code
without using device tree. With that code removed, gic_clocksource_init
is redundant so remove it.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

---

 drivers/clocksource/mips-gic-timer.c | 13 -------------
 include/linux/irqchip/mips-gic.h     |  1 -
 2 files changed, 14 deletions(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index d9ef7a61e093..0bce89c1266d 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -154,19 +154,6 @@ static int __init __gic_clocksource_init(void)
 	return ret;
 }
 
-void __init gic_clocksource_init(unsigned int frequency)
-{
-	gic_frequency = frequency;
-	gic_timer_irq = MIPS_GIC_IRQ_BASE +
-		GIC_LOCAL_TO_HWIRQ(GIC_LOCAL_INT_COMPARE);
-
-	__gic_clocksource_init();
-	gic_clockevent_init();
-
-	/* And finally start the counter */
-	gic_start_count();
-}
-
 static int __init gic_clocksource_of_init(struct device_node *node)
 {
 	struct clk *clk;
diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
index 7b49c71c968b..2b0e56619e53 100644
--- a/include/linux/irqchip/mips-gic.h
+++ b/include/linux/irqchip/mips-gic.h
@@ -258,7 +258,6 @@ extern unsigned int gic_present;
 extern void gic_init(unsigned long gic_base_addr,
 	unsigned long gic_addrspace_size, unsigned int cpu_vec,
 	unsigned int irqbase);
-extern void gic_clocksource_init(unsigned int);
 extern u64 gic_read_count(void);
 extern unsigned int gic_get_count_width(void);
 extern u64 gic_read_compare(void);
-- 
2.7.4
