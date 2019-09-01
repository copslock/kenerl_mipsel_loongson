Return-Path: <SRS0=OeKb=W4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2D6C3A5A4
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 16:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525C021874
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 16:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfIAQhG (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 1 Sep 2019 12:37:06 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:33644 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbfIAQhG (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 1 Sep 2019 12:37:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 7E7D83FBF6
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 18:37:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MUIoWlveRTL9 for <linux-mips@vger.kernel.org>;
        Sun,  1 Sep 2019 18:37:03 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id DDA2B3F52B
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 18:37:03 +0200 (CEST)
Date:   Sun, 1 Sep 2019 18:37:03 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     linux-mips@vger.kernel.org
Subject: [PATCH 120/120] MIPS: Fix name of BOOT_MEM_ROM_DATA
Message-ID: <54a08fcb41b12e715529148a6bc11bcb3e2adb4d.1567326213.git.noring@nocrew.org>
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
 arch/mips/kernel/setup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index ab349d2381c3..7d5bf8cb513b 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -870,14 +870,16 @@ static void __init resource_init(void)
 		switch (boot_mem_map.map[i].type) {
 		case BOOT_MEM_RAM:
 		case BOOT_MEM_INIT_RAM:
-		case BOOT_MEM_ROM_DATA:
 			res->name = "System RAM";
 			res->flags |= IORESOURCE_SYSRAM;
 			break;
+		case BOOT_MEM_ROM_DATA:
+			res->name = "System ROM";
+			break;
 		case BOOT_MEM_RESERVED:
 		case BOOT_MEM_NOMAP:
 		default:
-			res->name = "reserved";
+			res->name = "Reserved";
 		}
 
 		request_resource(&iomem_resource, res);
-- 
2.21.0

