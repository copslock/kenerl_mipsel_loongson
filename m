Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jun 2018 20:07:46 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:37248 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994077AbeFVSHjvecWO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jun 2018 20:07:39 +0200
Received: from mipsdag01.mipstec.com (mail1.mips.com [12.201.5.31]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Fri, 22 Jun 2018 18:07:34 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag01.mipstec.com
 (10.20.40.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Fri, 22
 Jun 2018 11:07:34 -0700
Received: from pburton-laptop.mipstec.com (10.20.2.29) by
 mipsdag02.mipstec.com (10.20.40.47) with Microsoft SMTP Server id 15.1.1415.2
 via Frontend Transport; Fri, 22 Jun 2018 11:07:34 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "Ralf Baechle" <ralf@linux-mips.org>
Subject: [PATCH] MIPS: Remove no-op cast in show_regs()
Date:   Fri, 22 Jun 2018 11:07:03 -0700
Message-ID: <20180622180703.18324-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1529690854-321459-16254-7820-1
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.31
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194339
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: linux-mips@linux-mips.org,jhogan@kernel.org,ralf@linux-mips.org
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64417
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

In show_regs() we have a regs argument of type struct pt_regs *, and we
explicitly cast it to that same type as part of calling __show_regs().

Casting regs to the same type that it is declared as does nothing at
all, so remove the useless cast.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 8d505a21396e..6be2337ca224 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -350,7 +350,7 @@ static void __show_regs(const struct pt_regs *regs)
  */
 void show_regs(struct pt_regs *regs)
 {
-	__show_regs((struct pt_regs *)regs);
+	__show_regs(regs);
 	dump_stack();
 }
 
-- 
2.17.1
