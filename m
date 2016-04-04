Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 11:05:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31551 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014185AbcDDJFPZu3lS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Apr 2016 11:05:15 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id C54835C456486;
        Mon,  4 Apr 2016 10:05:07 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 4 Apr 2016 10:05:09 +0100
Received: from localhost (10.100.200.28) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Mon, 4 Apr
 2016 10:05:08 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qsyousef@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        "Markos Chandras" <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>
Subject: [PATCH v2] MIPS: Don't BUG_ON when no IPI domain is found
Date:   Mon, 4 Apr 2016 10:04:52 +0100
Message-ID: <1459760692-19325-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1459756773-14889-1-git-send-email-paul.burton@imgtec.com>
References: <1459756773-14889-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.28]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52868
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
code that BUG_ON's in the case of a kernel that supports IPI domains but
does not have one at runtime. This case is possible on Malta where for
IPIs we may use either the GIC (which has an IPI IRQ domain
implementation) or core-local software interrupts between VPEs (which do
not currently have an IPI IRQ domain implementation). We can not know
which will be used until runtime when we know whether a GIC is actually
present, and if we run on a system with multiple VPEs and no GIC then
the BUG_ON is hit.

Commit 19fb5818ed60 ("IPS: Fix broken malta qemu") worked around this
for the single-core single-VPE case typically seen using QEMU, but does
not catch the multi-VPE case. This patch removes the insufficient CPU
presence check that was added and works around the bug differently,
effectively reverting that commit.

A simple way to reproduce this bug is by using QEMU, which partially
implements the MT ASE but does not implement the GIC as of version 2.5.
Using "-cpu 34Kf -smp 2" will present a system with 2 VPEs in one core &
no GIC, hitting the BUG_ON.

Given that we're post-merge-window on the way to v4.6, avoid this by
just returning from mips_smp_ipi_init when no IPI IRQ domain is found.
Ideally at some point all IPI implementations would be converted to the
same IPI IRQ domain interface & we'd be able to restore the check.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Qais Yousef <qsyousef@gmail.com>
Fixes: fbde2d7d8290 ("MIPS: Add generic SMP IPI support")
Fixes: 19fb5818ed60 ("IPS: Fix broken malta qemu")
Reverts: 19fb5818ed60 ("IPS: Fix broken malta qemu")

---

Changes in v2:
- Rebase this workaround atop Qais' workaround at Ralf's request.
- Update the commit message to reflect that.

 arch/mips/kernel/smp.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index c87c0da..630bcfb 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -243,18 +243,6 @@ static int __init mips_smp_ipi_init(void)
 	struct irq_domain *ipidomain;
 	struct device_node *node;
 
-	/*
-	 * In some cases like qemu-malta, it is desired to try SMP with
-	 * a single core. Qemu-malta has no GIC, so an attempt to set any IPIs
-	 * would cause a BUG_ON() to be triggered since there's no ipidomain.
-	 *
-	 * Since for a single core system IPIs aren't required really, skip the
-	 * initialisation which should generally keep any such configurations
-	 * happy and only fail hard when trying to truely run SMP.
-	 */
-	if (cpumask_weight(cpu_possible_mask) == 1)
-		return 0;
-
 	node = of_irq_find_parent(of_root);
 	ipidomain = irq_find_matching_host(node, DOMAIN_BUS_IPI);
 
@@ -266,7 +254,17 @@ static int __init mips_smp_ipi_init(void)
 	if (node && !ipidomain)
 		ipidomain = irq_find_matching_host(NULL, DOMAIN_BUS_IPI);
 
-	BUG_ON(!ipidomain);
+	/*
+	 * There are systems which only use IPI domains some of the time,
+	 * depending upon configuration we don't know until runtime. An
+	 * example is Malta where we may compile in support for GIC & the
+	 * MT ASE, but run on a system which has multiple VPEs in a single
+	 * core and doesn't include a GIC. Until all IPI implementations
+	 * have been converted to use IPI domains the best we can do here
+	 * is to return & hope some other code sets up the IPIs.
+	 */
+	if (!ipidomain)
+		return 0;
 
 	call_virq = irq_reserve_ipi(ipidomain, cpu_possible_mask);
 	BUG_ON(!call_virq);
-- 
2.8.0
