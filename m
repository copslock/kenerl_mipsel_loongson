Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Sep 2016 11:46:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44731 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992104AbcIGJplpDp9S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Sep 2016 11:45:41 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id CD709C94774A1;
        Wed,  7 Sep 2016 10:45:22 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 7 Sep 2016 10:45:25 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 01/12] MIPS: CPC: Convert bare 'unsigned' to 'unsigned int'
Date:   Wed, 7 Sep 2016 10:45:09 +0100
Message-ID: <1473241520-14917-2-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473241520-14917-1-git-send-email-matt.redfearn@imgtec.com>
References: <1473241520-14917-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55046
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

Checkpatch complains about use of bare unsigned type.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v2: None

 arch/mips/kernel/mips-cpc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
index 566b8d2c092c..0e337f55ac60 100644
--- a/arch/mips/kernel/mips-cpc.c
+++ b/arch/mips/kernel/mips-cpc.c
@@ -52,7 +52,7 @@ static phys_addr_t mips_cpc_phys_base(void)
 int mips_cpc_probe(void)
 {
 	phys_addr_t addr;
-	unsigned cpu;
+	unsigned int cpu;
 
 	for_each_possible_cpu(cpu)
 		spin_lock_init(&per_cpu(cpc_core_lock, cpu));
@@ -70,7 +70,7 @@ int mips_cpc_probe(void)
 
 void mips_cpc_lock_other(unsigned int core)
 {
-	unsigned curr_core;
+	unsigned int curr_core;
 	preempt_disable();
 	curr_core = current_cpu_data.core;
 	spin_lock_irqsave(&per_cpu(cpc_core_lock, curr_core),
@@ -86,7 +86,7 @@ void mips_cpc_lock_other(unsigned int core)
 
 void mips_cpc_unlock_other(void)
 {
-	unsigned curr_core = current_cpu_data.core;
+	unsigned int curr_core = current_cpu_data.core;
 	spin_unlock_irqrestore(&per_cpu(cpc_core_lock, curr_core),
 			       per_cpu(cpc_core_lock_flags, curr_core));
 	preempt_enable();
-- 
2.7.4
