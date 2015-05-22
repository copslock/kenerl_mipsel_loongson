Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 17:53:34 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62399 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026803AbbEVPx12otlq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 17:53:27 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7CE51347898AC;
        Fri, 22 May 2015 16:53:21 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 22 May 2015 16:53:24 +0100
Received: from localhost (192.168.159.131) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 22 May
 2015 16:53:23 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "Paul Burton" <paul.burton@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/15] irqchip: mips-gic: register IRQ domain with MIPS_GIC_IRQ_BASE
Date:   Fri, 22 May 2015 16:51:04 +0100
Message-ID: <1432309875-9712-6-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.1
In-Reply-To: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
References: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.131]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47557
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

On Malta, some IRQs are still referenced by hardcoded numbers relative
to MIPS_GIC_IRQ_BASE. When gic_init is called to register the GIC
without using device tree the irqbase argument allows this base to be
used. When the GIC is probed using device tree however the base is not
specified. This leads to conflicts between the GIC interrupts and other
interrupt controllers.

TODO: convert Malta (& SEAD3) to drop the hardcoded numbers instead

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 drivers/irqchip/irq-mips-gic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 57f09cb..697f340 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -858,7 +858,7 @@ static int __init gic_of_init(struct device_node *node,
 		write_gcr_gic_base(gic_base | CM_GCR_GIC_BASE_GICEN_MSK);
 	gic_present = true;
 
-	__gic_init(gic_base, gic_len, cpu_vec, 0, node);
+	__gic_init(gic_base, gic_len, cpu_vec, MIPS_GIC_IRQ_BASE, node);
 
 	return 0;
 }
-- 
2.4.1
