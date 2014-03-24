Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2014 11:22:27 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.89.28.115]:45132 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823120AbaCXKVWnfDr- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Mar 2014 11:21:22 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8A5CEDC3B0F97
        for <linux-mips@linux-mips.org>; Mon, 24 Mar 2014 10:21:15 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Mon, 24 Mar 2014 10:21:16 +0000
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Mon, 24 Mar 2014 10:21:16 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 07/12] MIPS: smp-cps: don't run MT instructions if cpu doesn't have MT
Date:   Mon, 24 Mar 2014 10:19:30 +0000
Message-ID: <1395656375-9300-8-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1395656375-9300-1-git-send-email-paul.burton@imgtec.com>
References: <1395656375-9300-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39567
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

The code already checked for MT in most cases but executed dmt
instructions regardless of whether the CPU implements the MT ASE. This
would lead to a reserved instruction exception on those which do not.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
Feel free to apply this as a fixup to "MIPS: Coherent Processing System
SMP implementation".
---
 arch/mips/kernel/smp-cps.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 4b812c1..536eec0 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -141,7 +141,8 @@ static void __init cps_smp_setup(void)
 	bitmap_set(core_power, 0, 1);
 
 	/* Disable MT - we only want to run 1 TC per VPE */
-	dmt();
+	if (cpu_has_mipsmt)
+		dmt();
 
 	/* Initialise core 0 */
 	init_core();
@@ -268,6 +269,8 @@ static void cps_boot_secondary(int cpu, struct task_struct *idle)
 		return;
 	}
 
+	BUG_ON(!cpu_has_mipsmt);
+
 	/* Boot a VPE on this core */
 	boot_vpe(&cfg);
 }
@@ -275,7 +278,8 @@ static void cps_boot_secondary(int cpu, struct task_struct *idle)
 static void cps_init_secondary(void)
 {
 	/* Disable MT - we only want to run 1 TC per VPE */
-	dmt();
+	if (cpu_has_mipsmt)
+		dmt();
 
 	/* TODO: revisit this assumption once hotplug is implemented */
 	if (cpu_vpe_id(&current_cpu_data) == 0)
-- 
1.8.5.3
