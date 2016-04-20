Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2016 03:33:26 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:36614 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027079AbcDTBdZBTEYl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Apr 2016 03:33:25 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 95FB1601A0;
        Wed, 20 Apr 2016 01:33:23 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 88BD260F70; Wed, 20 Apr 2016 01:33:23 +0000 (UTC)
Received: from sboyd-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 695F8601A0;
        Wed, 20 Apr 2016 01:33:22 +0000 (UTC)
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Antony Pavlov <antonynpavlov@gmail.com>
Subject: [PATCH] MIPS: ath79: Remove CLK_IS_ROOT
Date:   Tue, 19 Apr 2016 18:33:21 -0700
Message-Id: <1461116001-768-1-git-send-email-sboyd@codeaurora.org>
X-Mailer: git-send-email 2.6.3.369.g91ad409
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sboyd@codeaurora.org
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

This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
CLK_IS_ROOT", 2016-02-02) so remove it.

Cc: Antony Pavlov <antonynpavlov@gmail.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/mips/ath79/clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index 3cfc5ecddddf..2e7378467c5c 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -44,7 +44,7 @@ static struct clk *__init ath79_add_sys_clkdev(
 	struct clk *clk;
 	int err;
 
-	clk = clk_register_fixed_rate(NULL, id, NULL, CLK_IS_ROOT, rate);
+	clk = clk_register_fixed_rate(NULL, id, NULL, 0, rate);
 	if (!clk)
 		panic("failed to allocate %s clock structure", id);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
