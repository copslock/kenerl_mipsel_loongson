Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Nov 2017 21:02:14 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.245]:41027 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990489AbdKFUCIN58bm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Nov 2017 21:02:08 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 06 Nov 2017 20:01:40 +0000
Received: from jhogan-linux.mipstec.com (192.168.154.110) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Mon, 6 Nov 2017 12:00:37 -0800
From:   James Hogan <james.hogan@mips.com>
To:     <stable@vger.kernel.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        "James Hogan" <james.hogan@mips.com>,
        "Gustavo A . R . Silva" <garsilva@embeddedor.com>,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH BACKPORT 3.16..4.12] MIPS: microMIPS: Fix incorrect mask in insn_table_MM
Date:   Mon, 6 Nov 2017 20:01:10 +0000
Message-ID: <20171106200110.15343-1-james.hogan@mips.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1509998496-298552-6614-390808-11
X-BESS-VER: 2017.12-r1710252241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186645
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

From: Gustavo A. R. Silva <garsilva@embeddedor.com>

commit 77238e76b9156d28d86c1e31c00ed2960df0e4de upstream.

It seems that this is a typo error and the proper bit masking is
"RT | RS" instead of "RS | RS".

This issue was detected with the help of Coccinelle.

Fixes: d6b3314b49e1 ("MIPS: uasm: Add lh uam instruction")
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Reviewed-by: James Hogan <jhogan@kernel.org>
Patchwork: https://patchwork.linux-mips.org/patch/17551/
Signed-off-by: James Hogan <jhogan@kernel.org>
[jhogan@kernel.org: Backported 3.16..4.12]
---
 arch/mips/mm/uasm-micromips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/uasm-micromips.c b/arch/mips/mm/uasm-micromips.c
index 277cf52d80e1..6c17cba7f383 100644
--- a/arch/mips/mm/uasm-micromips.c
+++ b/arch/mips/mm/uasm-micromips.c
@@ -80,7 +80,7 @@ static struct insn insn_table_MM[] = {
 	{ insn_jr, M(mm_pool32a_op, 0, 0, 0, mm_jalr_op, mm_pool32axf_op), RS },
 	{ insn_lb, M(mm_lb32_op, 0, 0, 0, 0, 0), RT | RS | SIMM },
 	{ insn_ld, 0, 0 },
-	{ insn_lh, M(mm_lh32_op, 0, 0, 0, 0, 0), RS | RS | SIMM },
+	{ insn_lh, M(mm_lh32_op, 0, 0, 0, 0, 0), RT | RS | SIMM },
 	{ insn_ll, M(mm_pool32c_op, 0, 0, (mm_ll_func << 1), 0, 0), RS | RT | SIMM },
 	{ insn_lld, 0, 0 },
 	{ insn_lui, M(mm_pool32i_op, mm_lui_op, 0, 0, 0, 0), RS | SIMM },
-- 
2.14.1
