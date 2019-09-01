Return-Path: <SRS0=OeKb=W4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E412C3A5A4
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 15:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C82233A2
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 15:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfIAPq5 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 1 Sep 2019 11:46:57 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:56634 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbfIAPq5 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 1 Sep 2019 11:46:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 438D93F897
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 17:40:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mfyUCjypZbOB for <linux-mips@vger.kernel.org>;
        Sun,  1 Sep 2019 17:40:26 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 4A01A3F7B1
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 17:40:26 +0200 (CEST)
Date:   Sun, 1 Sep 2019 17:40:26 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     linux-mips@vger.kernel.org
Subject: [PATCH 012/120] MIPS: R5900: Avoid pipeline hazards with the
 TLBW[IR] instructions
Message-ID: <55596f09de274312357656ee483314ec4ef8c51a.1567326213.git.noring@nocrew.org>
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

On the R5900, the TLBWI[1] and TLBWR[2] instructions must be followed by
an ERET or a SYNC.P instruction to ensure a TLB update.

References:

[1] "TX System RISC TX79 Core Architecture" manual, revision 2.0,
    Toshiba Corporation, p. C-39, https://wiki.qemu.org/File:C790.pdf

[2] Ibid. p. C-40.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 arch/mips/mm/tlbex.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 0519e2eafbb8..89ff0eae5397 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -622,6 +622,15 @@ void build_tlb_write_entry(u32 **p, struct uasm_label **l,
 		uasm_i_nop(p);
 		tlbw(p);
 		break;
+	case CPU_R5900:
+		/*
+		 * On the R5900, the TLBWI and TLBWR instructions must be
+		 * followed by an ERET or a SYNC.P instruction to ensure a
+		 * TLB update.
+		 */
+		tlbw(p);
+		uasm_i_syncp(p);
+		break;
 
 	case CPU_JZRISC:
 		tlbw(p);
-- 
2.21.0

