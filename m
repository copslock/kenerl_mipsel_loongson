Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Sep 2016 11:46:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56519 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992105AbcIGJpnl9WlS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Sep 2016 11:45:43 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B41E2821B13FD;
        Wed,  7 Sep 2016 10:45:23 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 7 Sep 2016 10:45:26 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 02/12] MIPS: CPC: Avoid lock when MIPS CM >= 3 is present
Date:   Wed, 7 Sep 2016 10:45:10 +0100
Message-ID: <1473241520-14917-3-git-send-email-matt.redfearn@imgtec.com>
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
X-archive-position: 55048
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

MIPS CM version 3 removed the CPC_CL_OTHER register and instead the
CM_CL_OTHER register is used to redirect the CPC_OTHER region. As such,
we should not write the unimplmented register and can avoid the
spinlock as well.
These lock functions should aleady be called within the context of a
mips_cm_{lock,unlock}_other pair ensuring the correct CPC_OTHER region
will be accessed.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v2: None

 arch/mips/kernel/mips-cpc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
index 0e337f55ac60..2a45867d3b4f 100644
--- a/arch/mips/kernel/mips-cpc.c
+++ b/arch/mips/kernel/mips-cpc.c
@@ -71,6 +71,11 @@ int mips_cpc_probe(void)
 void mips_cpc_lock_other(unsigned int core)
 {
 	unsigned int curr_core;
+
+	if (mips_cm_revision() >= CM_REV_CM3)
+		/* Systems with CM >= 3 lock the CPC via mips_cm_lock_other */
+		return;
+
 	preempt_disable();
 	curr_core = current_cpu_data.core;
 	spin_lock_irqsave(&per_cpu(cpc_core_lock, curr_core),
@@ -86,7 +91,13 @@ void mips_cpc_lock_other(unsigned int core)
 
 void mips_cpc_unlock_other(void)
 {
-	unsigned int curr_core = current_cpu_data.core;
+	unsigned int curr_core;
+
+	if (mips_cm_revision() >= CM_REV_CM3)
+		/* Systems with CM >= 3 lock the CPC via mips_cm_lock_other */
+		return;
+
+	curr_core = current_cpu_data.core;
 	spin_unlock_irqrestore(&per_cpu(cpc_core_lock, curr_core),
 			       per_cpu(cpc_core_lock_flags, curr_core));
 	preempt_enable();
-- 
2.7.4
