Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 04:17:15 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27184 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009324AbcBCDRH5HQE0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 04:17:07 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id AE3BD3A4ABB7A;
        Wed,  3 Feb 2016 03:17:00 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 03:17:01 +0000
Received: from localhost (10.100.200.215) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 03:17:00 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 03/15] MIPS: pm-cps: Avoid offset overflow on MIPSr6
Date:   Wed, 3 Feb 2016 03:15:23 +0000
Message-ID: <1454469335-14778-4-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454469335-14778-1-git-send-email-paul.burton@imgtec.com>
References: <1454469335-14778-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.215]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51631
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

From: Markos Chandras <markos.chandras@imgtec.com>

This is similar to commit 934c79231c1b ("MIPS: asm: r4kcache: Add MIPS
R6 cache unroll functions"). The CACHE instruction has been redefined
for MIPSr6 and it reduced its offset field to 8 bits. This leads to
micro-assembler field overflow warnings when booting SMP MIPSr6 cores
like the following one:

Call Trace:
[<ffffffff8010af88>] show_stack+0x68/0x88
[<ffffffff8056ddf0>] dump_stack+0x68/0x88
[<ffffffff801305bc>] warn_slowpath_common+0x8c/0xc8
[<ffffffff80130630>] warn_slowpath_fmt+0x38/0x48
[<ffffffff80125814>] build_insn+0x514/0x5c0
[<ffffffff806ee134>] cps_gen_cache_routine.isra.3+0xe0/0x1b8
[<ffffffff806ee570>] cps_pm_init+0x364/0x9ec
[<ffffffff80100538>] do_one_initcall+0x90/0x1a8
[<ffffffff806e8c14>] kernel_init_freeable+0x160/0x21c
[<ffffffff8056b6a0>] kernel_init+0x10/0xf8
[<ffffffff801059f8>] ret_from_kernel_thread+0x14/0x1c

We fix this by incrementing the base register on every loop.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/pm-cps.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index f63a289..524ba11 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -224,11 +224,18 @@ static void __init cps_gen_cache_routine(u32 **pp, struct uasm_label **pl,
 	uasm_build_label(pl, *pp, lbl);
 
 	/* Generate the cache ops */
-	for (i = 0; i < unroll_lines; i++)
-		uasm_i_cache(pp, op, i * cache->linesz, t0);
+	for (i = 0; i < unroll_lines; i++) {
+		if (cpu_has_mips_r6) {
+			uasm_i_cache(pp, op, 0, t0);
+			uasm_i_addiu(pp, t0, t0, cache->linesz);
+		} else {
+			uasm_i_cache(pp, op, i * cache->linesz, t0);
+		}
+	}
 
-	/* Update the base address */
-	uasm_i_addiu(pp, t0, t0, unroll_lines * cache->linesz);
+	if (!cpu_has_mips_r6)
+		/* Update the base address */
+		uasm_i_addiu(pp, t0, t0, unroll_lines * cache->linesz);
 
 	/* Loop if we haven't reached the end address yet */
 	uasm_il_bne(pp, pr, t0, t1, lbl);
-- 
2.7.0
