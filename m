Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2015 05:21:03 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:38554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011101AbbA1EUtq5ayC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Jan 2015 05:20:49 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id A662020304;
        Wed, 28 Jan 2015 04:20:47 +0000 (UTC)
Received: from localhost.localdomain (unknown [183.247.163.231])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D84E2034B;
        Wed, 28 Jan 2015 04:20:44 +0000 (UTC)
From:   lizf@kernel.org
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Huacai Chen <chenhc@lemote.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Zefan Li <lizefan@huawei.com>
Subject: [PATCH 3.4 075/177] MIPS: tlbex: Properly fix HUGE TLB Refill exception handler
Date:   Wed, 28 Jan 2015 12:08:36 +0800
Message-Id: <1422418236-12852-149-git-send-email-lizf@kernel.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1422418050-12581-1-git-send-email-lizf@kernel.org>
References: <1422418050-12581-1-git-send-email-lizf@kernel.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <lizf@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lizf@kernel.org
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

From: David Daney <david.daney@cavium.com>

3.4.106-rc1 review patch.  If anyone has any objections, please let me know.

------------------


commit 9e0f162a36914937a937358fcb45e0609ef2bfc4 upstream.

In commit 8393c524a25609 (MIPS: tlbex: Fix a missing statement for
HUGETLB), the TLB Refill handler was fixed so that non-OCTEON targets
would work properly with huge pages.  The change was incorrect in that
it broke the OCTEON case.

The problem is shown here:

    xxx0:	df7a0000 	ld	k0,0(k1)
    .
    .
    .
    xxxc0:	df610000 	ld	at,0(k1)
    xxxc4:	335a0ff0 	andi	k0,k0,0xff0
    xxxc8:	e825ffcd 	bbit1	at,0x5,0x0
    xxxcc:	003ad82d 	daddu	k1,at,k0
    .
    .
    .

In the non-octeon case there is a destructive test for the huge PTE
bit, and then at 0, $k0 is reloaded (that is what the 8393c524a25609
patch added).

In the octeon case, we modify k1 in the branch delay slot, but we
never need k0 again, so the new load is not needed, but since k1 is
modified, if we do the load, we load from a garbage location and then
get a nested TLB Refill, which is seen in userspace as either SIGBUS
or SIGSEGV (depending on the garbage).

The real fix is to only do this reloading if it is needed, and never
where it is harmful.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/8151/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Zefan Li <lizefan@huawei.com>
---
 arch/mips/mm/tlbex.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index f5abdfa..6d64efe 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1041,6 +1041,7 @@ static void __cpuinit build_update_entries(u32 **p, unsigned int tmp,
 struct mips_huge_tlb_info {
 	int huge_pte;
 	int restore_scratch;
+	bool need_reload_pte;
 };
 
 static struct mips_huge_tlb_info __cpuinit
@@ -1055,6 +1056,7 @@ build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
 
 	rv.huge_pte = scratch;
 	rv.restore_scratch = 0;
+	rv.need_reload_pte = false;
 
 	if (check_for_high_segbits) {
 		UASM_i_MFC0(p, tmp, C0_BADVADDR);
@@ -1247,6 +1249,7 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
 	} else {
 		htlb_info.huge_pte = K0;
 		htlb_info.restore_scratch = 0;
+		htlb_info.need_reload_pte = true;
 		vmalloc_mode = refill_noscratch;
 		/*
 		 * create the plain linear handler
@@ -1283,7 +1286,8 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
 	}
 #ifdef CONFIG_HUGETLB_PAGE
 	uasm_l_tlb_huge_update(&l, p);
-	UASM_i_LW(&p, K0, 0, K1);
+	if (htlb_info.need_reload_pte)
+		UASM_i_LW(&p, htlb_info.huge_pte, 0, K1);
 	build_huge_update_entries(&p, htlb_info.huge_pte, K1);
 	build_huge_tlb_write_entry(&p, &l, &r, K0, tlb_random,
 				   htlb_info.restore_scratch);
-- 
1.9.1
