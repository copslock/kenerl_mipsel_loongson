Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Sep 2016 11:48:31 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63323 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992200AbcIGJpstdwcS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Sep 2016 11:45:48 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id D0FA48F2F700F;
        Wed,  7 Sep 2016 10:45:28 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 7 Sep 2016 10:45:31 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 08/12] MIPS: pm-cps: Remove selection of sync types
Date:   Wed, 7 Sep 2016 10:45:16 +0100
Message-ID: <1473241520-14917-9-git-send-email-matt.redfearn@imgtec.com>
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
X-archive-position: 55052
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

Instead of selecting an implementation or vendor specific sync type for
the required sync operations, always use the architecturally mandated
sync types which previous patches have put in place. The selection of
special sync types is now redundant an can be removed.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>

---

Changes in v2:
Use architecturally standard lightweight sync types rather than
selecting CPU specific ones.

 arch/mips/kernel/pm-cps.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index 953ff0db9061..b3a7d36ada5a 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -73,10 +73,6 @@ DEFINE_PER_CPU_ALIGNED(struct mips_static_suspend_state, cps_cpu_state);
 static struct uasm_label labels[32] __initdata;
 static struct uasm_reloc relocs[32] __initdata;
 
-/* CPU dependant sync types */
-static unsigned stype_intervention;
-static unsigned stype_memory;
-
 enum mips_reg {
 	zero, at, v0, v1, a0, a1, a2, a3,
 	t0, t1, t2, t3, t4, t5, t6, t7,
@@ -667,21 +663,6 @@ static int __init cps_pm_init(void)
 	unsigned cpu;
 	int err;
 
-	/* Detect appropriate sync types for the system */
-	switch (current_cpu_data.cputype) {
-	case CPU_INTERAPTIV:
-	case CPU_PROAPTIV:
-	case CPU_M5150:
-	case CPU_P5600:
-	case CPU_I6400:
-		stype_intervention = 0x2;
-		stype_memory = 0x3;
-		break;
-
-	default:
-		pr_warn("Power management is using heavyweight sync 0\n");
-	}
-
 	/* A CM is required for all non-coherent states */
 	if (!mips_cm_present()) {
 		pr_warn("pm-cps: no CM, non-coherent states unavailable\n");
-- 
2.7.4
