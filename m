Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Dec 2017 10:36:46 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:54518 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990488AbdLOJgiIHYp1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Dec 2017 10:36:38 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 15 Dec 2017 09:36:29 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Fri, 15 Dec 2017 01:35:22 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <jhogan@kernel.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Dengcheng Zhu <dengcheng.zhu@mips.com>,
        <linux-kernel@vger.kernel.org>,
        "Paul Burton" <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 1/2] MIPS: SMP-CPS: Remove duplicate assignment of core in play_dead
Date:   Fri, 15 Dec 2017 09:34:53 +0000
Message-ID: <1513330494-21249-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1513330589-321458-17146-63023-8
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187999
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61474
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

The merge of commit f875a832d2028 ("MIPS: Abstract CPU core & VP(E) ID
access through accessor functions") ended up creating a duplicate
assignment of core during the rebase on commit bac06cf0fb9d ("MIPS:
smp-cps: Fix potentially uninitialised value of core"). Remove the
duplicate.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/kernel/smp-cps.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index ecc1a853f48d..03f1026ad148 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -439,8 +439,6 @@ void play_dead(void)
 	pr_debug("CPU%d going offline\n", cpu);
 
 	if (cpu_has_mipsmt || cpu_has_vp) {
-		core = cpu_core(&cpu_data[cpu]);
-
 		/* Look for another online VPE within the core */
 		for_each_online_cpu(cpu_death_sibling) {
 			if (!cpus_are_siblings(cpu, cpu_death_sibling))
-- 
2.7.4
