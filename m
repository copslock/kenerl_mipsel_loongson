Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2016 11:09:03 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39165 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026215AbcDUJJBb1g0Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Apr 2016 11:09:01 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id F1DDE956A067E;
        Thu, 21 Apr 2016 10:08:49 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 21 Apr 2016 10:08:55 +0100
Received: from mredfearn-linux.kl.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 21 Apr 2016 10:08:54 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <lisa.parratt@imgtec.com>, <jason@lakedaemon.net>,
        <ralf@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <jiang.liu@linux.intel.com>, <marc.zyngier@arm.com>,
        <linux-mips@linux-mips.org>, Qais Yousef <qsyousef@gmail.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [PATCH] genirq: Dont allow affinity mask to be updated on IPIs
Date:   Thu, 21 Apr 2016 10:08:32 +0100
Message-ID: <1461229712-13057-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.5.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53141
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

The IPI domain re-purposes the IRQ affinity to signify the mask of CPUs
that this IPI will deliver to. This must not be modified before the IPI
is destroyed again, so set the IRQ_NO_BALANCING flag to prevent the
affinity being overwritten by setup_affinity().

Without this, if an IPI is reserved for a single target CPU, then
allocated using __setup_irq(), the affinity is overwritten with
cpu_online_mask. When ipi_destroy() is subsequently called on a
multi-cpu system, it will attempt to free cpumask_weight() IRQs
that were never allocated, and crash.

Fixes: d17bf24e6952 ("genirq: Add a new generic IPI reservation code to
irq core")
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

 kernel/irq/ipi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/ipi.c b/kernel/irq/ipi.c
index c37f34b00a11..14777af8e097 100644
--- a/kernel/irq/ipi.c
+++ b/kernel/irq/ipi.c
@@ -94,6 +94,7 @@ unsigned int irq_reserve_ipi(struct irq_domain *domain,
 		data = irq_get_irq_data(virq + i);
 		cpumask_copy(data->common->affinity, dest);
 		data->common->ipi_offset = offset;
+		irq_set_status_flags(virq + i, IRQ_NO_BALANCING);
 	}
 	return virq;
 
-- 
2.5.0
