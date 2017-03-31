Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Mar 2017 13:06:38 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61522 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993302AbdCaLFtOZXNd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Mar 2017 13:05:49 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 2AD081D82660E;
        Fri, 31 Mar 2017 12:05:40 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 31 Mar 2017 12:05:42 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] irqchip/mips-gic: Fix Local compare interrupt
Date:   Fri, 31 Mar 2017 12:05:32 +0100
Message-ID: <1490958332-31094-3-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1490958332-31094-1-git-send-email-matt.redfearn@imgtec.com>
References: <1490958332-31094-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57506
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

Commit 4cfffcfa5106 ("irqchip/mips-gic: Fix local interrupts") added
mapping of several local interrupts during initialisation of the gic
driver. This associates virq numbers with these interrupts.
Unfortunately, as not all of the interrupts are mapped in hardware
order, when drivers subsequently request these interrupts they conflict
with the mappings that have already been set up. For example, this
manifests itself in the gic clocksource driver, which fails to probe
with the message:

clocksource: GIC: mask: 0xffffffffffffffff max_cycles: 0x7350c9738,
max_idle_ns: 440795203769 ns
GIC timer IRQ 25 setup failed: -22

This is because virq 25 (the correct IRQ number specified via device
tree) was allocated to the PERFCTR interrupt (and 24 to the timer, 26 to
the FDC). To fix this, map all of these local interrupts in the hardware
order so as to associate their virq numbers with the correct hw
interrupts.

Fixes: 4cfffcfa5106 ("irqchip/mips-gic: Fix local interrupts")
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

 drivers/irqchip/irq-mips-gic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 11d12bccc4e7..cd20df12d63d 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -991,8 +991,12 @@ static void __init gic_map_single_int(struct device_node *node,
 
 static void __init gic_map_interrupts(struct device_node *node)
 {
+	gic_map_single_int(node, GIC_LOCAL_INT_WD);
+	gic_map_single_int(node, GIC_LOCAL_INT_COMPARE);
 	gic_map_single_int(node, GIC_LOCAL_INT_TIMER);
 	gic_map_single_int(node, GIC_LOCAL_INT_PERFCTR);
+	gic_map_single_int(node, GIC_LOCAL_INT_SWINT0);
+	gic_map_single_int(node, GIC_LOCAL_INT_SWINT1);
 	gic_map_single_int(node, GIC_LOCAL_INT_FDC);
 }
 
-- 
2.7.4
