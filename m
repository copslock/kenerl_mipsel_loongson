Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 17:46:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37258 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992583AbcHZPm6CcI0I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 17:42:58 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 43C44529A6468;
        Fri, 26 Aug 2016 16:42:38 +0100 (IST)
Received: from localhost (10.100.200.141) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 26 Aug
 2016 16:42:41 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Hogan <james.hogan@imgtec.com>,
        Qais Yousef <qsyousef@gmail.com>
Subject: [PATCH 19/26] MIPS: Stengthen IPI IRQ domain sanity check
Date:   Fri, 26 Aug 2016 16:37:18 +0100
Message-ID: <20160826153725.11629-20-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160826153725.11629-1-paul.burton@imgtec.com>
References: <20160826153725.11629-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54803
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

Commit fbde2d7d8290 ("MIPS: Add generic SMP IPI support") introduced a
sanity check that an IPI IRQ domain can be found during boot, in order
to ensure that IPIs are able to be set up in systems using such domains.
However it was added at a point where systems may have used an IPI IRQ
domain in some situations but not others, and we could not know which
were the case until runtime, so commit 578bffc82ec5 ("MIPS: Don't BUG_ON
when no IPI domain is found") made that check simply skip IPI init if no
domain were found in order to fix the boot for systems such as QEMU
Malta.

We now use IPI IRQ domains for the MIPS CPU interrupt controller, which
means systems which make use of IPI IRQ domains will always do so when
running on multiple CPUs. As a result we now strengthen the sanity check
to ensure that an IPI IRQ domain is found when multiple CPUs are present
in the system.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/smp.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index f95f094..0155e85 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -257,16 +257,20 @@ static int __init mips_smp_ipi_init(void)
 		ipidomain = irq_find_matching_host(NULL, DOMAIN_BUS_IPI);
 
 	/*
-	 * There are systems which only use IPI domains some of the time,
-	 * depending upon configuration we don't know until runtime. An
-	 * example is Malta where we may compile in support for GIC & the
-	 * MT ASE, but run on a system which has multiple VPEs in a single
-	 * core and doesn't include a GIC. Until all IPI implementations
-	 * have been converted to use IPI domains the best we can do here
-	 * is to return & hope some other code sets up the IPIs.
+	 * There are systems which use IPI IRQ domains, but only have one
+	 * registered when some runtime condition is met. For example a Malta
+	 * kernel may include support for GIC & CPU interrupt controller IPI
+	 * IRQ domains, but if run on a system with no GIC & no MT ASE then
+	 * neither will be supported or registered.
+	 *
+	 * We only have a problem if we're actually using multiple CPUs so fail
+	 * loudly if that is the case. Otherwise simply return, skipping IPI
+	 * setup, if we're running with only a single CPU.
 	 */
-	if (!ipidomain)
+	if (!ipidomain) {
+		BUG_ON(num_present_cpus() > 1);
 		return 0;
+	}
 
 	call_virq = irq_reserve_ipi(ipidomain, cpu_possible_mask);
 	BUG_ON(!call_virq);
-- 
2.9.3
