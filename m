Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2017 23:50:10 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19756 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993914AbdFBVtynFv9F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Jun 2017 23:49:54 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 1164E3E04BCDB;
        Fri,  2 Jun 2017 22:49:44 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Jun 2017 22:49:48
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 2/7] MIPS: CM: Avoid per-core locking with CM3 & higher
Date:   Fri, 2 Jun 2017 14:48:50 -0700
Message-ID: <20170602214856.4545-3-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170602214856.4545-1-paul.burton@imgtec.com>
References: <20170602214856.4545-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58156
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

CM3 provides a GCR_CL_OTHER register per VP, rather than only per core.
This means that we don't need to prevent other VPs within a core from
racing with code that makes use of the core-other register region.

Reduce locking overhead by demoting the per-core spinlock providing
protection for CM2.5 & lower to a per-CPU/per-VP spinlock for CM3 &
higher.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/kernel/mips-cm.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index 659e6d3ae335..99bb74dd12ce 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -265,15 +265,34 @@ void mips_cm_lock_other(unsigned int core, unsigned int vp)
 	u32 val;
 
 	preempt_disable();
-	curr_core = current_cpu_data.core;
-	spin_lock_irqsave(&per_cpu(cm_core_lock, curr_core),
-			  per_cpu(cm_core_lock_flags, curr_core));
 
 	if (mips_cm_revision() >= CM_REV_CM3) {
 		val = core << CM3_GCR_Cx_OTHER_CORE_SHF;
 		val |= vp << CM3_GCR_Cx_OTHER_VP_SHF;
+
+		/*
+		 * We need to disable interrupts in SMP systems in order to
+		 * ensure that we don't interrupt the caller with code which
+		 * may modify the redirect register. We do so here in a
+		 * slightly obscure way by using a spin lock, since this has
+		 * the neat property of also catching any nested uses of
+		 * mips_cm_lock_other() leading to a deadlock or a nice warning
+		 * with lockdep enabled.
+		 */
+		spin_lock_irqsave(this_cpu_ptr(&cm_core_lock),
+				  *this_cpu_ptr(&cm_core_lock_flags));
 	} else {
 		BUG_ON(vp != 0);
+
+		/*
+		 * We only have a GCR_CL_OTHER per core in systems with
+		 * CM 2.5 & older, so have to ensure other VP(E)s don't
+		 * race with us.
+		 */
+		curr_core = current_cpu_data.core;
+		spin_lock_irqsave(&per_cpu(cm_core_lock, curr_core),
+				  per_cpu(cm_core_lock_flags, curr_core));
+
 		val = core << CM_GCR_Cx_OTHER_CORENUM_SHF;
 	}
 
@@ -288,10 +307,17 @@ void mips_cm_lock_other(unsigned int core, unsigned int vp)
 
 void mips_cm_unlock_other(void)
 {
-	unsigned curr_core = current_cpu_data.core;
+	unsigned int curr_core;
+
+	if (mips_cm_revision() < CM_REV_CM3) {
+		curr_core = current_cpu_data.core;
+		spin_unlock_irqrestore(&per_cpu(cm_core_lock, curr_core),
+				       per_cpu(cm_core_lock_flags, curr_core));
+	} else {
+		spin_unlock_irqrestore(this_cpu_ptr(&cm_core_lock),
+				       *this_cpu_ptr(&cm_core_lock_flags));
+	}
 
-	spin_unlock_irqrestore(&per_cpu(cm_core_lock, curr_core),
-			       per_cpu(cm_core_lock_flags, curr_core));
 	preempt_enable();
 }
 
-- 
2.13.0
