Return-Path: <SRS0=OeKb=W4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDD6C3A5A8
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 15:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6408C23429
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 15:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfIAPvL (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 1 Sep 2019 11:51:11 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:41792 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfIAPvK (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 1 Sep 2019 11:51:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 1B13F3F6B8
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 17:41:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BysIxn_d_7g7 for <linux-mips@vger.kernel.org>;
        Sun,  1 Sep 2019 17:41:41 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 7C8AB3F69D
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 17:41:41 +0200 (CEST)
Date:   Sun, 1 Sep 2019 17:41:41 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     linux-mips@vger.kernel.org
Subject: [PATCH 016/120] MIPS: R5900: The ERET instruction has issues with
 delay slot and CACHE
Message-ID: <3a2945e9ac2b70c6f6b14100bf8c805d3ef51ce0.1567326213.git.noring@nocrew.org>
References: <cover.1567326213.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1567326213.git.noring@nocrew.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
The Linux 2.6 port to the PlayStation 2 has this remark. I don't know
where it comes from.
---
 arch/mips/mm/tlbex.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 1bd134b6f033..9d5864b20e9f 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1383,6 +1383,16 @@ static void build_r4000_tlb_refill_handler(void)
 		uasm_l_leave(&l, p);
 		uasm_i_eret(&p); /* return from trap */
 	}
+
+#ifdef CONFIG_CPU_R5900
+	/* There should be nothing which can be interpreted as cache instruction. */
+	uasm_i_nop(&p);
+	uasm_i_nop(&p);
+	uasm_i_nop(&p);
+	uasm_i_nop(&p);
+	uasm_i_nop(&p);
+#endif
+
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 	uasm_l_tlb_huge_update(&l, p);
 	if (htlb_info.need_reload_pte)
@@ -2129,6 +2139,14 @@ build_r4000_tlbchange_handler_tail(u32 **p, struct uasm_label **l,
 	uasm_l_leave(l, *p);
 	build_restore_work_registers(p);
 	uasm_i_eret(p); /* return from trap */
+#ifdef CONFIG_CPU_R5900
+	/* There should be nothing which can be interpreted as cache instruction. */
+	uasm_i_nop(p);
+	uasm_i_nop(p);
+	uasm_i_nop(p);
+	uasm_i_nop(p);
+	uasm_i_nop(p);
+#endif
 
 #ifdef CONFIG_64BIT
 	build_get_pgd_vmalloc64(p, l, r, tmp, ptr, not_refill);
-- 
2.21.0

