Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Dec 2017 10:59:56 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:55027 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992396AbdLLJ7AFAIuC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Dec 2017 10:59:00 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx30.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 12 Dec 2017 09:58:55 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 12 Dec 2017 01:58:54 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
CC:     <linux-mips@linux-mips.org>
Subject: [RFC PATCH 03/16] MIPS: bpf: Use CP0 register for CPU ID
Date:   Tue, 12 Dec 2017 09:57:49 +0000
Message-ID: <1513072682-1371-4-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1513072682-1371-1-git-send-email-matt.redfearn@mips.com>
References: <1513072682-1371-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1513072735-637140-23891-866545-1
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187894
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
X-archive-position: 61433
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

We already keep a copy of the CPU's ID stashed in CP0.Context or
CP0.XContext (defined by SMP_CPUID_REG) for use in exceptions handlers
to restore the correct CPUs state.

Currently, bpf uses the thread_info->cpu field, which will vanish when
CONFIG_THREAD_INFO_IN_TASK is activated.

Switch emit_load_cpu to use the CP0 register. A helper function to emit
mfc0 instructions is also added.

A future commit will perform this same modification for the generic
smp_processor_id() function.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/net/bpf_jit.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index ae2ff1f08d5a..ffdc171ce837 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -234,6 +234,12 @@ static inline void emit_andi(unsigned int dst, unsigned int src,
 	}
 }
 
+static inline void emit_mfc0(unsigned int dst, unsigned int reg,
+			     unsigned int select, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, mfc0, dst, reg, select);
+}
+
 static inline void emit_xor(unsigned int dst, unsigned int src1,
 			    unsigned int src2, struct jit_ctx *ctx)
 {
@@ -520,10 +526,9 @@ static inline void emit_jr(unsigned int reg, struct jit_ctx *ctx)
 
 static inline void emit_load_cpu(unsigned int reg, struct jit_ctx *ctx)
 {
-	/* A = current_thread_info()->cpu */
-	BUILD_BUG_ON(FIELD_SIZEOF(struct thread_info, cpu) != 4);
-	/* $28/gp points to the thread_info struct */
-	emit_load(reg, 28, offsetof(struct thread_info, cpu), ctx);
+	/* A = smp_processor_id() */
+	emit_mfc0(reg, SMP_CPUID_REG, ctx);
+	emit_srl(reg, reg, SMP_CPUID_REGSHIFT, ctx);
 }
 
 static inline u16 align_sp(unsigned int num)
-- 
2.7.4
