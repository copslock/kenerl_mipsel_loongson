Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2016 15:59:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45015 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006549AbcFNN7uWonti (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jun 2016 15:59:50 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 915CA876B4895;
        Tue, 14 Jun 2016 14:59:40 +0100 (IST)
Received: from mredfearn-linux.kl.imgtec.org (192.168.154.116) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Jun 2016 14:59:43 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>, <stable@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: mm: Fix definition of R6 cache instruction
Date:   Tue, 14 Jun 2016 14:59:38 +0100
Message-ID: <1465912778-22097-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.5.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54046
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

Commit a168b8f1cde6 ("MIPS: mm: Add MIPS R6 instruction encodings") added
an incorrect definition of the redefined MIPSr6 cache instruction.

Executing any kernel code including this instuction results in a
reserved instruction exception and kernel panic.

Fix the instruction definition.

Fixes: a168b8f1cde6588ff7a67699fa11e01bc77a5ddd
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: <stable@vger.kernel.org> # 4.x-
---

 arch/mips/mm/uasm-mips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index b4a837893562..5abe51cad899 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -65,7 +65,7 @@ static struct insn insn_table[] = {
 #ifndef CONFIG_CPU_MIPSR6
 	{ insn_cache,  M(cache_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
 #else
-	{ insn_cache,  M6(cache_op, 0, 0, 0, cache6_op),  RS | RT | SIMM9 },
+	{ insn_cache,  M6(spec3_op, 0, 0, 0, cache6_op),  RS | RT | SIMM9 },
 #endif
 	{ insn_daddiu, M(daddiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
 	{ insn_daddu, M(spec_op, 0, 0, 0, 0, daddu_op), RS | RT | RD },
-- 
2.5.0
