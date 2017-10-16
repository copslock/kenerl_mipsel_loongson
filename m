Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2017 12:08:59 +0200 (CEST)
Received: from 20pmail.ess.barracuda.com ([64.235.154.233]:42937 "EHLO
        20pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990430AbdJPKIw2FGNl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Oct 2017 12:08:52 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 16 Oct 2017 10:07:58 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Mon, 16 Oct 2017 03:07:42 -0700
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        <linux-kernel@vger.kernel.org>, Ying Huang <ying.huang@intel.com>,
        Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH] MIPS: generic: Fix compilation error from include asm/mips-cpc.h
Date:   Mon, 16 Oct 2017 11:06:49 +0100
Message-ID: <1508148409-15864-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1508148478-452059-5284-309088-1
X-BESS-VER: 2017.12.1-r1709122024
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.60
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186023
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.60 MARKETING_SUBJECT      HEADER: Subject contains popular marketing words 
X-BESS-Outbound-Spam-Status: SCORE=0.60 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, MARKETING_SUBJECT
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60407
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

Commit e83f7e02af50c ("MIPS: CPS: Have asm/mips-cps.h include CM & CPC
headers") adds a #error to arch/mips/include/asm/mips-cpc.h if it is
included directly. While this commit replaced almost all direct includes
of mips-cm.h and mips-cpc.h, 2 remain.

With some defconfigs, mips-cps.h is indirectly included before
mips-cpc.h, but in others this results in compilation errors:

In file included from arch/mips/generic/init.c:23:0:
./arch/mips/include/asm/mips-cpc.h:12:3: error: #error Please include
asm/mips-cps.h rather than asm/mips-cpc.h
 # error Please include asm/mips-cps.h rather than asm/mips-cpc.h

In file included from arch/mips/kernel/smp.c:23:0:
./arch/mips/include/asm/mips-cpc.h:12:3: error: #error Please include
asm/mips-cps.h rather than asm/mips-cpc.h
 # error Please include asm/mips-cps.h rather than asm/mips-cpc.h

In both cases, fix this by including mips-cps.h instead.

Fixes: e83f7e02af50c ("MIPS: CPS: Have asm/mips-cps.h include CM & CPC headers")
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/generic/init.c | 2 +-
 arch/mips/kernel/smp.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/generic/init.c b/arch/mips/generic/init.c
index 15a7fb8e2a2e..813c60c73a4c 100644
--- a/arch/mips/generic/init.c
+++ b/arch/mips/generic/init.c
@@ -20,7 +20,7 @@
 #include <asm/fw/fw.h>
 #include <asm/irq_cpu.h>
 #include <asm/machine.h>
-#include <asm/mips-cpc.h>
+#include <asm/mips-cps.h>
 #include <asm/prom.h>
 #include <asm/smp-ops.h>
 #include <asm/time.h>
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index bbe19b64def5..3cd2f70d1c18 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -42,7 +42,7 @@
 #include <asm/processor.h>
 #include <asm/idle.h>
 #include <asm/r4k-timer.h>
-#include <asm/mips-cpc.h>
+#include <asm/mips-cps.h>
 #include <asm/mmu_context.h>
 #include <asm/time.h>
 #include <asm/setup.h>
-- 
2.7.4
