Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 00:34:39 +0200 (CEST)
Received: from mail-ig0-f169.google.com ([209.85.213.169]:52080 "EHLO
        mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011950AbaJTWegySei2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 00:34:36 +0200
Received: by mail-ig0-f169.google.com with SMTP id uq10so7253312igb.0
        for <multiple recipients>; Mon, 20 Oct 2014 15:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=+lkteHufKcNtpRpVy8cWk6lAEQnV6urPp/Ro+DpC3cY=;
        b=rXm7vIj0QWCkKkvsteA5gFzKJ/SBmpczi6AQuDTPka3KP1UEd/IPlCM6731rxZHCyS
         /6YMS4A7L2rHS57RfwFXP5+vXhLCuURCSCPP/0/JNMn7gAPIThjsWY2KOr/dGBzB9OwS
         /sjL+fAKxE/BmNwa0RduTPzebinSaDZBsmFGrImu7BONMWdTmJjKFFkrlEF2/lRVMc1r
         roJNoQzxUzn19Utk3H5LdmWrbzVbUu7ThN79jXY7Rj3B8Z9DLdLkgDxPJlR9X0QbqHiS
         QPMBk5fUUrtafB2QusoGuyZBH+2TR1BeP5QJmWbWqPSVsnX4biWGoCPKjOCDYbjC3rG7
         XLZQ==
X-Received: by 10.50.21.99 with SMTP id u3mr21477396ige.35.1413844470719;
        Mon, 20 Oct 2014 15:34:30 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id h3sm5174557ioe.44.2014.10.20.15.34.29
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 15:34:30 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id s9KMYS0n030140;
        Mon, 20 Oct 2014 15:34:28 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id s9KMYPjA030139;
        Mon, 20 Oct 2014 15:34:25 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        Huacai Chen <chenhc@lemote.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, <stable@vger.kernel.org>
Subject: [PATCH] MIPS: tlbex: Properly fix HUGE TLB Refill exception handler
Date:   Mon, 20 Oct 2014 15:34:23 -0700
Message-Id: <1413844463-30106-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Cc: <stable@vger.kernel.org>
---
 arch/mips/mm/tlbex.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index a08dd53..b5f228e 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1062,6 +1062,7 @@ static void build_update_entries(u32 **p, unsigned int tmp, unsigned int ptep)
 struct mips_huge_tlb_info {
 	int huge_pte;
 	int restore_scratch;
+	bool need_reload_pte;
 };
 
 static struct mips_huge_tlb_info
@@ -1076,6 +1077,7 @@ build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
 
 	rv.huge_pte = scratch;
 	rv.restore_scratch = 0;
+	rv.need_reload_pte = false;
 
 	if (check_for_high_segbits) {
 		UASM_i_MFC0(p, tmp, C0_BADVADDR);
@@ -1264,6 +1266,7 @@ static void build_r4000_tlb_refill_handler(void)
 	} else {
 		htlb_info.huge_pte = K0;
 		htlb_info.restore_scratch = 0;
+		htlb_info.need_reload_pte = true;
 		vmalloc_mode = refill_noscratch;
 		/*
 		 * create the plain linear handler
@@ -1300,7 +1303,8 @@ static void build_r4000_tlb_refill_handler(void)
 	}
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 	uasm_l_tlb_huge_update(&l, p);
-	UASM_i_LW(&p, K0, 0, K1);
+	if (htlb_info.need_reload_pte)
+		UASM_i_LW(&p, htlb_info.huge_pte, 0, K1);
 	build_huge_update_entries(&p, htlb_info.huge_pte, K1);
 	build_huge_tlb_write_entry(&p, &l, &r, K0, tlb_random,
 				   htlb_info.restore_scratch);
-- 
1.7.11.7
