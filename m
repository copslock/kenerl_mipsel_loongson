Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jun 2017 09:04:25 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44478 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990778AbdFIHEPq7UgN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Jun 2017 09:04:15 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B5F7053B96591;
        Fri,  9 Jun 2017 08:04:06 +0100 (IST)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 9 Jun 2017 08:04:08 +0100
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: [PATCH v2] irqchip/mips-gic: mark count and compare accessors notrace
Date:   Fri, 9 Jun 2017 09:04:05 +0200
Message-ID: <1496991845-27031-1-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

gic_read_count(), gic_write_compare() and gic_write_cpu_compare() are
often used in a sequence to update the compare register with a count
value increased by a small offset.
With small delta values used to update the compare register, the time to
update function trace for these operations may be longer than the update
timeout leading to update failure.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>

---
 v2: move notrace attribute after return type
---
 drivers/irqchip/irq-mips-gic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index eb7fbe1..929f855 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -140,7 +140,7 @@ static inline void gic_map_to_vpe(unsigned int intr, unsigned int vpe)
 }
 
 #ifdef CONFIG_CLKSRC_MIPS_GIC
-u64 gic_read_count(void)
+u64 notrace gic_read_count(void)
 {
 	unsigned int hi, hi2, lo;
 
@@ -167,7 +167,7 @@ unsigned int gic_get_count_width(void)
 	return bits;
 }
 
-void gic_write_compare(u64 cnt)
+void notrace gic_write_compare(u64 cnt)
 {
 	if (mips_cm_is64) {
 		gic_write(GIC_REG(VPE_LOCAL, GIC_VPE_COMPARE), cnt);
@@ -179,7 +179,7 @@ void gic_write_compare(u64 cnt)
 	}
 }
 
-void gic_write_cpu_compare(u64 cnt, int cpu)
+void notrace gic_write_cpu_compare(u64 cnt, int cpu)
 {
 	unsigned long flags;
 
-- 
2.7.4
