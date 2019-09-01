Return-Path: <SRS0=OeKb=W4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32CBC3A5A8
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 15:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4C021897
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 15:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfIAPq5 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 1 Sep 2019 11:46:57 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:56632 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbfIAPq5 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 1 Sep 2019 11:46:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 6405C3F73E
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 17:40:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cMHQ580nK6w4 for <linux-mips@vger.kernel.org>;
        Sun,  1 Sep 2019 17:40:12 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 6A5503F708
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 17:40:12 +0200 (CEST)
Date:   Sun, 1 Sep 2019 17:40:12 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     linux-mips@vger.kernel.org
Subject: [PATCH 011/120] MIPS: R5900: Avoid pipeline hazard with the TLBP
 instruction
Message-ID: <d3b43e48be1b888c4bd675dc4c0633dc1e8fe791.1567326213.git.noring@nocrew.org>
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

On the R5900, the TLBP instruction must be immediately followed by an
ERET or a SYNC.P instruction[1].

References:

[1] "TX System RISC TX79 Core Architecture" manual, revision 2.0,
    Toshiba Corporation, p. C-37, https://wiki.qemu.org/File:C790.pdf

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 arch/mips/mm/tlbex.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 82136c346885..0519e2eafbb8 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -489,6 +489,19 @@ static void __maybe_unused build_tlb_probe_entry(u32 **p)
 		uasm_i_tlbp(p);
 		break;
 
+	case CPU_R5900:
+		/*
+		 * On the R5900, the TLBWP instruction must be immediately
+		 * followed by an ERET or a SYNC.P instruction.
+		 */
+		uasm_i_tlbp(p);
+		uasm_i_syncp(p);
+		uasm_i_nop(p);
+		uasm_i_nop(p);
+		uasm_i_nop(p);
+		uasm_i_nop(p);
+		break;
+
 	default:
 		uasm_i_tlbp(p);
 		break;
-- 
2.21.0

