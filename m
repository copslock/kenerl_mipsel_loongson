Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 11:05:03 +0100 (CET)
Received: from torg.zytor.com ([198.137.202.12]:44434 "EHLO terminus.zytor.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012712AbcBYKE7C2yHm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Feb 2016 11:04:59 +0100
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTP id u1PA4aj7002919;
        Thu, 25 Feb 2016 02:04:41 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.14.8/Submit) id u1PA4au0002916;
        Thu, 25 Feb 2016 02:04:36 -0800
Date:   Thu, 25 Feb 2016 02:04:36 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qais Yousef <tipbot@zytor.com>
Message-ID: <tip-2a07870511829977d02609dac6450017b0419ea9@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, linux-mips@linux-mips.org,
        jason@lakedaemon.net, ralf@linux-mips.org,
        jiang.liu@linux.intel.com, marc.zyngier@arm.com,
        qsyousef@gmail.com, lisa.parratt@imgtec.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, qais.yousef@imgtec.com
Reply-To: jiang.liu@linux.intel.com, marc.zyngier@arm.com,
          jason@lakedaemon.net, ralf@linux-mips.org, tglx@linutronix.de,
          hpa@zytor.com, linux-mips@linux-mips.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, qais.yousef@imgtec.com,
          lisa.parratt@imgtec.com, qsyousef@gmail.com
In-Reply-To: <1449580830-23652-15-git-send-email-qais.yousef@imgtec.com>
References: <1449580830-23652-15-git-send-email-qais.yousef@imgtec.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] irqchip/mips-gic: Use gic_vpes instead of NR_CPUS
Git-Commit-ID: 2a07870511829977d02609dac6450017b0419ea9
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Precedence: bulk
Return-Path: <tipbot@zytor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tipbot@zytor.com
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

Commit-ID:  2a07870511829977d02609dac6450017b0419ea9
Gitweb:     http://git.kernel.org/tip/2a07870511829977d02609dac6450017b0419ea9
Author:     Qais Yousef <qais.yousef@imgtec.com>
AuthorDate: Tue, 8 Dec 2015 13:20:25 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Feb 2016 10:56:58 +0100

irqchip/mips-gic: Use gic_vpes instead of NR_CPUS

NR_CPUS is set by Kconfig and could be much higher than what actually is in the
system.

gic_vpes should be a true representitives of the number of cpus in the system,
so use it instead.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
Cc: <jason@lakedaemon.net>
Cc: <marc.zyngier@arm.com>
Cc: <jiang.liu@linux.intel.com>
Cc: <linux-mips@linux-mips.org>
Cc: <lisa.parratt@imgtec.com>
Cc: Qais Yousef <qsyousef@gmail.com>
Link: http://lkml.kernel.org/r/1449580830-23652-15-git-send-email-qais.yousef@imgtec.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-mips-gic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 794fc59..1fe73a1 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -465,7 +465,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 	gic_map_to_vpe(irq, mips_cm_vp_id(cpumask_first(&tmp)));
 
 	/* Update the pcpu_masks */
-	for (i = 0; i < NR_CPUS; i++)
+	for (i = 0; i < gic_vpes; i++)
 		clear_bit(irq, pcpu_masks[i].pcpu_mask);
 	set_bit(irq, pcpu_masks[cpumask_first(&tmp)].pcpu_mask);
 
@@ -1098,8 +1098,8 @@ static void __init __gic_init(unsigned long gic_base_addr,
 
 	gic_ipi_domain->bus_token = DOMAIN_BUS_IPI;
 
-	/* Make the last 2 * NR_CPUS available for IPIs */
-	bitmap_set(ipi_resrv, gic_shared_intrs - 2 * NR_CPUS, 2 * NR_CPUS);
+	/* Make the last 2 * gic_vpes available for IPIs */
+	bitmap_set(ipi_resrv, gic_shared_intrs - 2 * gic_vpes, 2 * gic_vpes);
 
 	gic_basic_init();
 
