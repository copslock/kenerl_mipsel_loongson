Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Jul 2013 10:22:46 +0200 (CEST)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:45163 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817088Ab3GOIWmsXEUJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Jul 2013 10:22:42 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id A381A21B7BA;
        Mon, 15 Jul 2013 11:22:41 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id RIZ-4zG0+DSM; Mon, 15 Jul 2013 11:22:36 +0300 (EEST)
Received: from blackmetal.pp.htv.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp6.welho.com (Postfix) with ESMTP id A98F15BC00B;
        Mon, 15 Jul 2013 11:22:36 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Jayachandran C <jchandra@broadcom.com>,
        linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] MIPS: tlbex: fix broken build in v3.11-rc1
Date:   Mon, 15 Jul 2013 11:21:57 +0300
Message-Id: <1373876517-14646-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.8.3.1
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Commit 6ba045f9fbdafb48da42aa8576ea7a3980443136 (MIPS: Move generated code
to .text for microMIPS) deleted tlbmiss_handler_setup_pgd_array, but some
references were not converted. Fix that to enable building a MIPS kernel.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/mm/tlbex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 9ab0f90..cc34521 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1466,7 +1466,7 @@ static void __cpuinit build_r4000_setup_pgd(void)
 {
 	const int a0 = 4;
 	const int a1 = 5;
-	u32 *p = tlbmiss_handler_setup_pgd_array;
+	u32 *p = tlbmiss_handler_setup_pgd;
 	const int tlbmiss_handler_setup_pgd_size =
 		tlbmiss_handler_setup_pgd_end - tlbmiss_handler_setup_pgd;
 	struct uasm_label *l = labels;
-- 
1.8.3.1
