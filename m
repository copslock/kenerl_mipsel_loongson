Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2012 19:11:32 +0200 (CEST)
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:4568 "EHLO
        smtp-vbr6.xs4all.nl" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903603Ab2C2RLJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Mar 2012 19:11:09 +0200
Received: from starbug-2.trinair2002 (dhcp-089-098-069-120.chello.nl [89.98.69.120])
        (authenticated bits=0)
        by smtp-vbr6.xs4all.nl (8.13.8/8.13.8) with ESMTP id q2THB4kn060983;
        Thu, 29 Mar 2012 19:11:09 +0200 (CEST)
        (envelope-from maarten@treewalker.org)
Received: from hyperion.trinair2002 (hyperion.trinair2002 [192.168.0.43])
        by starbug-2.trinair2002 (Postfix) with ESMTP id 9B3CD3DF38;
        Thu, 29 Mar 2012 19:11:03 +0200 (CEST)
From:   Maarten ter Huurne <maarten@treewalker.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: [PATCH 2/2] MIPS: JZ4740: qi_lb60: Look for NAND chip in bank 1.
Date:   Thu, 29 Mar 2012 19:17:02 +0200
Message-Id: <1333041422-20411-2-git-send-email-maarten@treewalker.org>
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1333041422-20411-1-git-send-email-maarten@treewalker.org>
References: <1333041422-20411-1-git-send-email-maarten@treewalker.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
X-archive-position: 32819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maarten@treewalker.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

All NanoNotes have their NAND in bank 1.
Specifying the bank is required since multi-bank support was introduced.

Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
---
 arch/mips/jz4740/board-qi_lb60.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index 9aea1f3..11752ea 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -140,6 +140,7 @@ static void qi_lb60_nand_ident(struct platform_device *pdev,
 static struct jz_nand_platform_data qi_lb60_nand_pdata = {
 	.ident_callback = qi_lb60_nand_ident,
 	.busy_gpio = 94,
+	.banks = { 1 },
 };
 
 /* Keyboard*/
-- 
1.7.7
