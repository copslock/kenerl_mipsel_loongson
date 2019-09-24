Return-Path: <SRS0=Yu4+=XT=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8ACC4320D
	for <linux-mips@archiver.kernel.org>; Tue, 24 Sep 2019 15:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455B8214DA
	for <linux-mips@archiver.kernel.org>; Tue, 24 Sep 2019 15:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731759AbfIXPUH (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 24 Sep 2019 11:20:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:57752 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730625AbfIXPUG (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 24 Sep 2019 11:20:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 40175AC93;
        Tue, 24 Sep 2019 15:20:05 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: init: Fix reservation of memory between PHYS_OFFSET and mem start
Date:   Tue, 24 Sep 2019 17:19:56 +0200
Message-Id: <20190924151956.9528-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Fix calculation of the size for reserving memory between PHYS_OFFSET
and real memory start.

Fixes: a94e4f24ec83 ("MIPS: init: Drop boot_mem_map")
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index b8249c233754..f5c6b4c6de24 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -321,7 +321,7 @@ static void __init bootmem_init(void)
 	 * Reserve any memory between the start of RAM and PHYS_OFFSET
 	 */
 	if (ramstart > PHYS_OFFSET)
-		memblock_reserve(PHYS_OFFSET, PFN_UP(ramstart) - PHYS_OFFSET);
+		memblock_reserve(PHYS_OFFSET, ramstart - PHYS_OFFSET);
 
 	if (PFN_UP(ramstart) > ARCH_PFN_OFFSET) {
 		pr_info("Wasting %lu bytes for tracking %lu unused pages\n",
-- 
2.13.7

