Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jun 2018 19:56:28 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:44588 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993874AbeFVR4SHEr2O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jun 2018 19:56:18 +0200
Received: from mipsdag01.mipstec.com (mail1.mips.com [12.201.5.31]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Fri, 22 Jun 2018 17:56:11 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag01.mipstec.com
 (10.20.40.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Fri, 22
 Jun 2018 10:55:49 -0700
Received: from pburton-laptop.mipstec.com (10.20.2.29) by
 mipsdag02.mipstec.com (10.20.40.47) with Microsoft SMTP Server id 15.1.1415.2
 via Frontend Transport; Fri, 22 Jun 2018 10:55:49 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     <linux-mips@linux-mips.org>
CC:     Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 1/3] MIPS: Call dump_stack() from show_regs()
Date:   Fri, 22 Jun 2018 10:55:45 -0700
Message-ID: <20180622175547.17716-2-paul.burton@mips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180622175547.17716-1-paul.burton@mips.com>
References: <20180622175547.17716-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1529690136-321458-14409-5864-8
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.31
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194338
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: linux-mips@linux-mips.org,chenhc@lemote.com,ralf@linux-mips.org,jhogan@kernel.org
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

The generic nmi_cpu_backtrace() function calls show_regs() when a struct
pt_regs is available, and dump_stack() otherwise. If we were to make use
of the generic nmi_cpu_backtrace() with MIPS' current implementation of
show_regs() this would mean that we see only register data with no
accompanying stack information, in contrast with our current
implementation which calls dump_stack() regardless of whether register
state is available.

In preparation for making use of the generic nmi_cpu_backtrace() to
implement arch_trigger_cpumask_backtrace(), have our implementation of
show_regs() call dump_stack() and drop the explicit dump_stack() call in
arch_dump_stack() which is invoked by arch_trigger_cpumask_backtrace().

This will allow the output we produce to remain the same after a later
patch switches to using nmi_cpu_backtrace(). It may mean that we produce
extra stack output in other uses of show_regs(), but this:

  1) Seems harmless.
  2) Is good for consistency between arch_trigger_cpumask_backtrace()
     and other users of show_regs().
  3) Matches the behaviour of the ARM & PowerPC architectures.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: linux-mips@linux-mips.org
---

 arch/mips/kernel/process.c | 4 ++--
 arch/mips/kernel/traps.c   | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 8d85046adcc8..d4cfeb931382 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -663,8 +663,8 @@ static void arch_dump_stack(void *info)
 
 	if (regs)
 		show_regs(regs);
-
-	dump_stack();
+	else
+		dump_stack();
 }
 
 void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index d67fa74622ee..8d505a21396e 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -351,6 +351,7 @@ static void __show_regs(const struct pt_regs *regs)
 void show_regs(struct pt_regs *regs)
 {
 	__show_regs((struct pt_regs *)regs);
+	dump_stack();
 }
 
 void show_registers(struct pt_regs *regs)
-- 
2.17.1
