Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jul 2016 15:27:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49205 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992967AbcGEN1GHtqgl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jul 2016 15:27:06 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 6890EBAE06049;
        Tue,  5 Jul 2016 14:26:46 +0100 (IST)
Received: from localhost (10.100.200.81) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 5 Jul
 2016 14:26:48 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qsyousef@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 2/2] irqchip: mips-gic: Match IPI IRQ domain by bus token only
Date:   Tue, 5 Jul 2016 14:26:00 +0100
Message-ID: <20160705132600.27730-2-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160705132600.27730-1-paul.burton@imgtec.com>
References: <20160705132600.27730-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.81]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54220
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

Commit fbde2d7d8290 ("MIPS: Add generic SMP IPI support") introduced
code which calls irq_find_matching_host with a NULL node parameter in
order to discover IPI IRQ domains which are not associated with the DT
root node's interrupt parent. This suggests that implementations of IPI
IRQ domains should effectively ignore the node parameter if it is NULL
and search purely based upon the bus token. Commit 2af70a962070
("irqchip/mips-gic: Add a IPI hierarchy domain") did not do this when
implementing the GIC IPI IRQ domain, and on MIPS Boston boards this
leads to no IPI domain being discovered and a NULL pointer dereference
when attempting to send an IPI:

  CPU 0 Unable to handle kernel paging request at virtual address 0000000000000040, epc == ffffffff8016e70c, ra == ffffffff8010ff5c
  Oops[#1]:
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.7.0-rc6-00223-gad0d1b6 #945
  task: a8000000ff066fc0 ti: a8000000ff068000 task.ti: a8000000ff068000
  $ 0   : 0000000000000000 0000000000000001 ffffffff80730000 0000000000000003
  $ 4   : 0000000000000000 ffffffff8057e5b0 a800000001e3ee00 0000000000000000
  $ 8   : 0000000000000000 0000000000000023 0000000000000001 0000000000000001
  $12   : 0000000000000000 ffffffff803323d0 0000000000000000 0000000000000000
  $16   : 0000000000000000 0000000000000000 0000000000000001 ffffffff801108fc
  $20   : 0000000000000000 ffffffff8057e5b0 0000000000000001 0000000000000000
  $24   : 0000000000000000 ffffffff8012de28
  $28   : a8000000ff068000 a8000000ff06fbc0 0000000000000000 ffffffff8010ff5c
  Hi    : ffffffff8014c174
  Lo    : a800000001e1e140
  epc   : ffffffff8016e70c __ipi_send_mask+0x24/0x11c
  ra    : ffffffff8010ff5c mips_smp_send_ipi_mask+0x68/0x178
  Status: 140084e2        KX SX UX KERNEL EXL
  Cause : 00800008 (ExcCode 02)
  BadVA : 0000000000000040
  PrId  : 0001a920 (MIPS I6400)
  Process swapper/0 (pid: 1, threadinfo=a8000000ff068000, task=a8000000ff066fc0, tls=0000000000000000)
  Stack : 0000000000000000 0000000000000000 0000000000000001 ffffffff801108fc
            0000000000000000 ffffffff8057e5b0 0000000000000001 ffffffff8010ff5c
            0000000000000001 0000000000000020 0000000000000000 0000000000000000
            0000000000000000 ffffffff801108fc 0000000000000000 0000000000000001
            0000000000000001 0000000000000000 0000000000000000 ffffffff801865e8
            a8000000ff0c7500 a8000000ff06fc90 0000000000000001 0000000000000002
            ffffffff801108fc ffffffff801868b8 0000000000000000 ffffffff801108fc
            0000000000000000 0000000000000003 ffffffff8068c700 0000000000000001
            ffffffff80730000 0000000000000001 a8000000ff00a290 ffffffff80110c50
            0000000000000003 a800000001e48308 0000000000000003 0000000000000008
            ...
  Call Trace:
  [<ffffffff8016e70c>] __ipi_send_mask+0x24/0x11c
  [<ffffffff8010ff5c>] mips_smp_send_ipi_mask+0x68/0x178
  [<ffffffff801865e8>] generic_exec_single+0x150/0x170
  [<ffffffff801868b8>] smp_call_function_single+0x108/0x160
  [<ffffffff80110c50>] cps_boot_secondary+0x328/0x394
  [<ffffffff80110534>] __cpu_up+0x38/0x90
  [<ffffffff8012de4c>] bringup_cpu+0x24/0xac
  [<ffffffff8012df40>] cpuhp_up_callbacks+0x58/0xdc
  [<ffffffff8012e648>] cpu_up+0x118/0x18c
  [<ffffffff806dc158>] smp_init+0xbc/0xe8
  [<ffffffff806d4c18>] kernel_init_freeable+0xa0/0x228
  [<ffffffff8056c908>] kernel_init+0x10/0xf0
  [<ffffffff80105098>] ret_from_kernel_thread+0x14/0x1c

Fix this by allowing the GIC IPI IRQ domain to match purely based upon
the bus token if the node provided is NULL.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 2af70a962070 ("irqchip/mips-gic: Add a IPI hierarchy domain")
Cc: Qais Yousef <qsyousef@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 drivers/irqchip/irq-mips-gic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 69b1b82..70ed1d0 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -959,7 +959,7 @@ int gic_ipi_domain_match(struct irq_domain *d, struct device_node *node,
 	switch (bus_token) {
 	case DOMAIN_BUS_IPI:
 		is_ipi = d->bus_token == bus_token;
-		return to_of_node(d->fwnode) == node && is_ipi;
+		return (!node || to_of_node(d->fwnode) == node) && is_ipi;
 		break;
 	default:
 		return 0;
-- 
2.9.0
