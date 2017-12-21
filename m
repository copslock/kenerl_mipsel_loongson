Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Dec 2017 12:16:56 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:42624 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990424AbdLULQuOjbRq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Dec 2017 12:16:50 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx4.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 21 Dec 2017 11:16:36 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Thu, 21 Dec 2017 03:16:28 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "stable # v4 . 9+" <stable@vger.kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        <linux-kernel@vger.kernel.org>, Paul Burton <paul.burton@mips.com>
Subject: [PATCH 1/3] MIPS: c-r4k: instruction_hazard should immediately follow cache op
Date:   Thu, 21 Dec 2017 11:16:02 +0000
Message-ID: <1513854965-3880-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1513854995-298555-26276-33723-1
X-BESS-VER: 2017.16-r1712182224
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188217
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
X-archive-position: 61529
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

During ftrace initialisation, placeholder instructions in the prologue
of every kernel function not marked "notrace" are replaced with nops.
After the instructions are written (to the dcache), flush_icache_range()
is used to ensure that the icache will be updated with these replaced
instructions. Currently there is an instruction_hazard guard at the end
of __r4k_flush_icache_range, since a hazard can be created if the CPU
has already begun fetching the instructions that have have been
replaced. The placement, however, ignores the calls to preempt_enable(),
both in __r4k_flush_icache_range and r4k_on_each_cpu. When
CONFIG_PREEMPT is enabled, these expand out to at least calls to
preempt_count_sub(). The lack of an instruction hazard between icache
invalidate and the execution of preempt_count_sub, in rare
circumstances, was observed to cause weird crashes on Ci40, where the
CPU would end up taking a kernel unaligned access exception from the
middle of do_ade(), which it somehow reached from preempt_count_sub
without executing the start of do_ade.

Since the instruction hazard exists immediately after the dcache is
written back and icache invalidated, place the instruction_hazard()
within __local_r4k_flush_icache_range. The one at the end of
__r4k_flush_icache_range is too late, since all of the functions in the
call path of preempt_enable have already been executed, so remove it.

This fixes the crashes during ftrace initialisation on Ci40.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: stable <stable@vger.kernel.org> # v4.9+

---

 arch/mips/mm/c-r4k.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 6f534b209971..ce7a54223504 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -760,6 +760,8 @@ static inline void __local_r4k_flush_icache_range(unsigned long start,
 			break;
 		}
 	}
+	/* Hazard to force new i-fetch */
+	instruction_hazard();
 }
 
 static inline void local_r4k_flush_icache_range(unsigned long start,
@@ -817,7 +819,6 @@ static void __r4k_flush_icache_range(unsigned long start, unsigned long end,
 	}
 	r4k_on_each_cpu(args.type, local_r4k_flush_icache_range_ipi, &args);
 	preempt_enable();
-	instruction_hazard();
 }
 
 static void r4k_flush_icache_range(unsigned long start, unsigned long end)
-- 
2.7.4
