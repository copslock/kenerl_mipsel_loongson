Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 11:05:21 +0100 (CET)
Received: from torg.zytor.com ([198.137.202.12]:44480 "EHLO terminus.zytor.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012712AbcBYKFTOA5Zm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Feb 2016 11:05:19 +0100
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTP id u1PA4t9C002989;
        Thu, 25 Feb 2016 02:05:00 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.14.8/Submit) id u1PA4t9a002986;
        Thu, 25 Feb 2016 02:04:55 -0800
Date:   Thu, 25 Feb 2016 02:04:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qais Yousef <tipbot@zytor.com>
Message-ID: <tip-78930f09b9406db029c69dcebad10cd7b6e06fae@git.kernel.org>
Cc:     tglx@linutronix.de, lisa.parratt@imgtec.com, hpa@zytor.com,
        marc.zyngier@arm.com, ralf@linux-mips.org,
        jiang.liu@linux.intel.com, qsyousef@gmail.com, mingo@kernel.org,
        jason@lakedaemon.net, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, qais.yousef@imgtec.com
Reply-To: mingo@kernel.org, qsyousef@gmail.com, jiang.liu@linux.intel.com,
          qais.yousef@imgtec.com, linux-kernel@vger.kernel.org,
          linux-mips@linux-mips.org, jason@lakedaemon.net, hpa@zytor.com,
          lisa.parratt@imgtec.com, tglx@linutronix.de, ralf@linux-mips.org,
          marc.zyngier@arm.com
In-Reply-To: <1449580830-23652-16-git-send-email-qais.yousef@imgtec.com>
References: <1449580830-23652-16-git-send-email-qais.yousef@imgtec.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] irqchip/mips-gic: Clear percpu_masks correctly when
 mapping
Git-Commit-ID: 78930f09b9406db029c69dcebad10cd7b6e06fae
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
X-archive-position: 52250
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

Commit-ID:  78930f09b9406db029c69dcebad10cd7b6e06fae
Gitweb:     http://git.kernel.org/tip/78930f09b9406db029c69dcebad10cd7b6e06fae
Author:     Qais Yousef <qais.yousef@imgtec.com>
AuthorDate: Tue, 8 Dec 2015 13:20:26 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Feb 2016 10:56:58 +0100

irqchip/mips-gic: Clear percpu_masks correctly when mapping

When setting the mapping for a hwirq, make sure we clear percpu_masks for
all other cpus in case it was set previously.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
Cc: <jason@lakedaemon.net>
Cc: <marc.zyngier@arm.com>
Cc: <jiang.liu@linux.intel.com>
Cc: <linux-mips@linux-mips.org>
Cc: <lisa.parratt@imgtec.com>
Cc: Qais Yousef <qsyousef@gmail.com>
Link: http://lkml.kernel.org/r/1449580830-23652-16-git-send-email-qais.yousef@imgtec.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-mips-gic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 1fe73a1..83395bf 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -773,6 +773,7 @@ static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
 {
 	int intr = GIC_HWIRQ_TO_SHARED(hw);
 	unsigned long flags;
+	int i;
 
 	irq_set_chip_and_handler(virq, &gic_level_irq_controller,
 				 handle_level_irq);
@@ -780,6 +781,8 @@ static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	spin_lock_irqsave(&gic_lock, flags);
 	gic_map_to_pin(intr, gic_cpu_pin);
 	gic_map_to_vpe(intr, vpe);
+	for (i = 0; i < gic_vpes; i++)
+		clear_bit(intr, pcpu_masks[i].pcpu_mask);
 	set_bit(intr, pcpu_masks[vpe].pcpu_mask);
 	spin_unlock_irqrestore(&gic_lock, flags);
 
