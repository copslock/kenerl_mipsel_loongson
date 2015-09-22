Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 20:30:29 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32704 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009117AbbIVSa0Nf83P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 20:30:26 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D1F7BEF187C90;
        Tue, 22 Sep 2015 19:30:16 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 19:30:20 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 19:30:18 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] irqchip: mips-gic: fix pending & mask reads for MIPS64 with 32b GIC
Date:   Tue, 22 Sep 2015 11:29:11 -0700
Message-ID: <1442946551-27893-4-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1442946551-27893-1-git-send-email-paul.burton@imgtec.com>
References: <1442946551-27893-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49316
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

gic_handle_shared_int reads the GIC interrupt pending & mask registers
directly into a bitmap, which is defined as an array of unsigned longs.
The GIC pending registers may be 32 bits wide if the CM is older than
CM3, regardless of the bit width of the CPU, but for MIPS64 kernels
the unsigned longs in the bitmap will be 64 bits wide. In this case we
need to perform 2 x 32 bit reads per 64 bit unsigned long in order to
avoid missing interrupts.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 drivers/irqchip/irq-mips-gic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 842a53d..aeaa061 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -320,6 +320,14 @@ static void gic_handle_shared_int(bool chained)
 		intrmask[i] = gic_read(intrmask_reg);
 		pending_reg += gic_reg_step;
 		intrmask_reg += gic_reg_step;
+
+		if (!config_enabled(CONFIG_64BIT) || mips_cm_is64)
+			continue;
+
+		pending[i] |= (u64)gic_read(pending_reg) << 32;
+		intrmask[i] |= (u64)gic_read(intrmask_reg) << 32;
+		pending_reg += gic_reg_step;
+		intrmask_reg += gic_reg_step;
 	}
 
 	bitmap_and(pending, pending, intrmask, gic_shared_intrs);
-- 
2.5.3
