Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 20:25:08 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:57789 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009731AbcADTYRc3RLw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Jan 2016 20:24:17 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 593B0280660;
        Mon,  4 Jan 2016 20:23:47 +0100 (CET)
Received: from localhost.localdomain (p548C87BE.dip0.t-ipconnect.de [84.140.135.190])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Mon,  4 Jan 2016 20:23:47 +0100 (CET)
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 4/8] MIPS: ralink: fix USB frequency scaling
Date:   Mon,  4 Jan 2016 20:23:57 +0100
Message-Id: <1451935441-40803-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1451935441-40803-1-git-send-email-blogic@openwrt.org>
References: <1451935441-40803-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Commit 418d29c87061 ("MIPS: ralink: Unify SoC id handling") was not fully
correct. The logic for the SoC check got inverted. We need to check if it
is not a MT76x8.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/mt7620.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 733768e..4c17dc6 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -459,7 +459,7 @@ void __init ralink_clk_init(void)
 	ralink_clk_add("10000c00.uartlite", periph_rate);
 	ralink_clk_add("10180000.wmac", xtal_rate);
 
-	if (IS_ENABLED(CONFIG_USB) && is_mt76x8()) {
+	if (IS_ENABLED(CONFIG_USB) && !is_mt76x8()) {
 		/*
 		 * When the CPU goes into sleep mode, the BUS clock will be
 		 * too low for USB to function properly. Adjust the busses
-- 
1.7.10.4
