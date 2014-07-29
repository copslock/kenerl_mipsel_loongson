Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2014 08:50:43 +0200 (CEST)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:48525 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6862058AbaG2GrN4HQ-W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Jul 2014 08:47:13 +0200
Received: by mail-pa0-f48.google.com with SMTP id et14so11861180pad.35
        for <multiple recipients>; Mon, 28 Jul 2014 23:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=MDJRCR/brpRi23Csx4MfHAHdbR1H+cdIZFQ7QXy2ULM=;
        b=odTOVAfaN5w3OqVzyoM05o/hgjMxSH9FjrDqQa1hjiy4y+PakLmnmPSosaBh8XcYc/
         4p671cByD1ZHxszmYlSNDokBHVlAsKx5AxgIofiQ22Y9wz21IvmhTnmsfSt6y0iXOuVZ
         CVusS0/wKYRVIoE0/TFXnybWKbyym+yLw9FXweUODiuayRvAZkxvMe9jgTreKGnIq/3v
         3bmQ0peSKmKGziOztCUGgATbxJsg2Zz8lf0RgUuleXUr3ekuLoUJc4R683csCYLPaFuM
         xWG7Oed7ubfCFDbkV3R7WqRjHlnDKU+On9HYZWUxZCQhGx1RUYzgdzDoBfCdLKP8E00/
         Y/Ig==
X-Received: by 10.68.69.71 with SMTP id c7mr12555pbu.43.1406616407008;
        Mon, 28 Jul 2014 23:46:47 -0700 (PDT)
Received: from software.domain.org ([222.92.8.142])
        by mx.google.com with ESMTPSA id v8sm27453797pdr.45.2014.07.28.23.46.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jul 2014 23:46:46 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Binbin Zhou <zhoubb@lemote.com>, <stable@vger.kernel.org>
Subject: [PATCH] MIPS: tlbex: fix a missing statement for HUGETLB
Date:   Tue, 29 Jul 2014 14:54:40 +0800
Message-Id: <1406616880-17142-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.9.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

In commit 2c8c53e28f1 (MIPS: Optimize TLB handlers for Octeon CPUs)
build_r4000_tlb_refill_handler() is modified. But it doesn't compatible
with the original code in HUGETLB case. Because there is a copy & paste
error and one line of code is missing. It is very easy to produce a bug
with LTP's hugemmap05 test.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Cc: <stable@vger.kernel.org>
---
 arch/mips/mm/tlbex.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index e80e10b..343fe0f 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1299,6 +1299,7 @@ static void build_r4000_tlb_refill_handler(void)
 	}
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 	uasm_l_tlb_huge_update(&l, p);
+	UASM_i_LW(&p, K0, 0, K1);
 	build_huge_update_entries(&p, htlb_info.huge_pte, K1);
 	build_huge_tlb_write_entry(&p, &l, &r, K0, tlb_random,
 				   htlb_info.restore_scratch);
-- 
1.9.0
