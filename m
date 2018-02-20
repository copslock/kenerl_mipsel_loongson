Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2018 11:33:48 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:47849 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994675AbeBTKdZk29hl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Feb 2018 11:33:25 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 20 Feb 2018 10:33:15 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 20 Feb 2018 02:33:11 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "Ying Huang" <ying.huang@intel.com>,
        <linux-kernel@vger.kernel.org>, Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Matija Glavinic Pecotic" <matija.glavinic-pecotic.ext@nokia.com>
Subject: [PATCH 1/2] MIPS: SMP: Group CONFIG_GENERIC_IRQ_IPI together
Date:   Tue, 20 Feb 2018 10:32:22 +0000
Message-ID: <1519122743-4847-2-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519122743-4847-1-git-send-email-matt.redfearn@mips.com>
References: <1519122743-4847-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1519122795-321458-16165-46969-2
X-BESS-VER: 2018.2-r1802152108
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190214
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

In preparation for allowing selection of a single IPI / CPU, group
affected code together to minimise ifdeffery.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/kernel/smp.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index d84b9066b465..5b25e181cefe 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -84,11 +84,6 @@ static cpumask_t cpu_core_setup_map;
 
 cpumask_t cpu_coherent_mask;
 
-#ifdef CONFIG_GENERIC_IRQ_IPI
-static struct irq_desc *call_desc;
-static struct irq_desc *sched_desc;
-#endif
-
 static inline void set_cpu_sibling_map(int cpu)
 {
 	int i;
@@ -157,6 +152,10 @@ void register_smp_ops(const struct plat_smp_ops *ops)
 }
 
 #ifdef CONFIG_GENERIC_IRQ_IPI
+static unsigned int call_virq, sched_virq;
+static struct irq_desc *call_desc;
+static struct irq_desc *sched_desc;
+
 void mips_smp_send_ipi_single(int cpu, unsigned int action)
 {
 	mips_smp_send_ipi_mask(cpumask_of(cpu), action);
@@ -240,8 +239,6 @@ static void smp_ipi_init_one(unsigned int virq,
 	BUG_ON(ret);
 }
 
-static unsigned int call_virq, sched_virq;
-
 int mips_smp_ipi_allocate(const struct cpumask *mask)
 {
 	int virq;
-- 
2.7.4
