Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Sep 2017 01:30:48 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15715 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994844AbdIGX23YFdrk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Sep 2017 01:28:29 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id B442F433950A;
        Fri,  8 Sep 2017 00:28:17 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 8 Sep 2017 00:28:22
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     <dianders@chromium.org>, James Hogan <james.hogan@imgtec.com>,
        Brian Norris <briannorris@chromium.org>,
        Jason Cooper <jason@lakedaemon.net>,
        <jeffy.chen@rock-chips.com>, Marc Zyngier <marc.zyngier@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <tfiga@chromium.org>, Paul Burton <paul.burton@imgtec.com>
Subject: [RFC PATCH v1 8/9] irqchip: mips-cpu: Set timer, FDC & perf interrupts percpu_devid
Date:   Thu, 7 Sep 2017 16:25:41 -0700
Message-ID: <20170907232542.20589-9-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170907232542.20589-1-paul.burton@imgtec.com>
References: <1682867.tATABVWsV9@np-p-burton>
 <20170907232542.20589-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The MIPS timer, fast debug channel (FDC) & performance counter overflow
interrupts are all really percpu interrupts. However up until now the
users of these interrupt haven't used the percpu interrupt APIs to
configure & control them; instead using the regular non-percpu APIs such
as request_irq(), enable_irq() etc. This has required hacks elsewhere,
and generally does not fit well with the fact that the interrupts are
actually percpu.

The users of these interrupts are now prepared for them to be used with
the percpu interrupt APIs, so set them up as percpu_devid interrupts in
order to allow these users to begin using the percpu interrupt APIs.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
---

 drivers/irqchip/irq-mips-cpu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mips-cpu.c b/drivers/irqchip/irq-mips-cpu.c
index 66f97fde13d8..8f7de01f6f35 100644
--- a/drivers/irqchip/irq-mips-cpu.c
+++ b/drivers/irqchip/irq-mips-cpu.c
@@ -166,7 +166,14 @@ static int mips_cpu_intc_map(struct irq_domain *d, unsigned int irq,
 	if (cpu_has_vint)
 		set_vi_handler(hw, plat_irq_dispatch);
 
-	irq_set_chip_and_handler(irq, chip, handle_percpu_irq);
+	if ((irq == cp0_compare_irq) ||
+	    (irq == cp0_fdc_irq) ||
+	    (irq == cp0_perfcount_irq)) {
+		irq_set_chip_and_handler(irq, chip, handle_percpu_devid_irq);
+		irq_set_percpu_devid(irq);
+	} else {
+		irq_set_chip_and_handler(irq, chip, handle_percpu_irq);
+	}
 
 	return 0;
 }
-- 
2.14.1
