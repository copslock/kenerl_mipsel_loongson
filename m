Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jun 2014 11:41:53 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19081 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860008AbaFWJjhkn0D6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Jun 2014 11:39:37 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 125E7A3B571FF;
        Mon, 23 Jun 2014 10:39:29 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Mon, 23 Jun 2014 10:39:30 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.28) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Mon, 23 Jun 2014 10:39:30 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <dborkman@redhat.com>,
        "Alexei Starovoitov" <ast@plumgrid.com>, <netdev@vger.kernel.org>
Subject: [PATCH 08/17] MIPS: bpf: Fix branch conditional for BPF_J{GT/GE} cases
Date:   Mon, 23 Jun 2014 10:38:51 +0100
Message-ID: <1403516340-22997-9-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1403516340-22997-1-git-send-email-markos.chandras@imgtec.com>
References: <1403516340-22997-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.28]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40663
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

The sltiu and sltu instructions will set the scratch register
to 1 if A <= X|K so fix the emitted branch conditional to check
for scratch != zero rather than scratch >= zero which would complicate
the resuling branch logic given that MIPS does not have a BGT or BGET
instructions to compare general purpose registers directly.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Daniel Borkmann <dborkman@redhat.com>
Cc: Alexei Starovoitov <ast@plumgrid.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/net/bpf_jit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 8cae27af03da..500f97fdc0e1 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -1127,7 +1127,7 @@ jmp_cmp:
 				}
 				/* A < (K|X) ? r_scrach = 1 */
 				b_off = b_imm(i + inst->jf + 1, ctx);
-				emit_bcond(MIPS_COND_GT, r_s0, r_zero, b_off,
+				emit_bcond(MIPS_COND_NE, r_s0, r_zero, b_off,
 					   ctx);
 				emit_nop(ctx);
 				/* A > (K|X) ? scratch = 0 */
-- 
2.0.0
