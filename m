Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Sep 2017 10:15:19 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13631 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990513AbdI0IPMKLURW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Sep 2017 10:15:12 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id DBC4F47CECF17;
        Wed, 27 Sep 2017 09:15:00 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Wed, 27 Sep 2017 09:15:03 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        "# v4 . 13+" <stable@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Colin Ian King <colin.king@canonical.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH] MIPS: bpf: Fix uninitialised target compiler error
Date:   Wed, 27 Sep 2017 09:14:58 +0100
Message-ID: <1506500098-3723-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <31051d4e-95a1-ec81-7e9e-5cf0f3d752df@imgtec.com>
References: <31051d4e-95a1-ec81-7e9e-5cf0f3d752df@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60171
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

Compiling ebpf_jit.c with gcc 4.9 results in a (likely spurious)
compiler warning, as gcc has detected that the variable "target" may be
used uninitialised. Since -Werror is active, this is treated as an error
and causes a kernel build failure whenever CONFIG_MIPS_EBPF_JIT is
enabled.

arch/mips/net/ebpf_jit.c: In function 'build_one_insn':
arch/mips/net/ebpf_jit.c:1118:80: error: 'target' may be used
uninitialized in this function [-Werror=maybe-uninitialized]
    emit_instr(ctx, j, target);
                                                                                ^
cc1: all warnings being treated as errors

Fix this by initialising "target" to 0. If it really is used
uninitialised this would result in a jump to 0 and a detectable run time
failure.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Fixes: b6bd53f9c4e8 ("MIPS: Add missing file for eBPF JIT.")
Cc: <stable@vger.kernel.org> # v4.13+
---

 arch/mips/net/ebpf_jit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/net/ebpf_jit.c b/arch/mips/net/ebpf_jit.c
index 7646891c4e9b..01b7a87ea678 100644
--- a/arch/mips/net/ebpf_jit.c
+++ b/arch/mips/net/ebpf_jit.c
@@ -667,7 +667,7 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 {
 	int src, dst, r, td, ts, mem_off, b_off;
 	bool need_swap, did_move, cmp_eq;
-	unsigned int target;
+	unsigned int target = 0;
 	u64 t64;
 	s64 t64s;
 	int bpf_op = BPF_OP(insn->code);
-- 
2.7.4
