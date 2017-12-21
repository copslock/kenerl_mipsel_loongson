Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Dec 2017 12:18:02 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:41319 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990491AbdLULRq3oiyq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Dec 2017 12:17:46 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 21 Dec 2017 11:17:34 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Thu, 21 Dec 2017 03:17:25 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "Paul Burton" <paul.burton@mips.com>,
        James Hogan <james.hogan@mips.com>,
        "stable # v4 . 9+" <stable@vger.kernel.org>,
        Huacai Chen <chenhc@lemote.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] MIPS: Add barrier between icache flush and execution hazard barrier
Date:   Thu, 21 Dec 2017 11:16:04 +0000
Message-ID: <1513854965-3880-3-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1513854965-3880-1-git-send-email-matt.redfearn@mips.com>
References: <1513854965-3880-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1513855054-321459-23116-47110-7
X-BESS-VER: 2017.16-r1712182224
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188216
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
X-archive-position: 61531
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

Hit-based icache operations may complete before the CM completes
intervention with the local L1. Thus code which invalidates the icache
and then attempts to execute those addresses must include a barrier to
prevent the scenario which:

  - icache instruction completes
  - icache fetch occurs
  - core executes icache data
  - CM completes icache invalidate

If the above were allowed to happen then the core would execute stale
instructions from the icache.

A barrier is required to prevent the core i-fetching before the icache
operation has completed. This goes together with the instruction_hazard
to ensure that the pipeline is stalled until the icache operation is
completed and the core will fetch the new instructions.

Suggested-by: Leonid Yegoshin <Leonid.Yegoshin@mips.com>
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <james.hogan@mips.com>
Cc: stable <stable@vger.kernel.org> # v4.9+
---

 arch/mips/mm/c-r4k.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index b7186d47184b..844685e51109 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -763,6 +763,8 @@ static inline void __local_r4k_flush_icache_range(unsigned long start,
 			break;
 		}
 	}
+	/* Ensure icache operation has completed */
+	mb();
 	/* Hazard to force new i-fetch */
 	instruction_hazard();
 }
-- 
2.7.4
