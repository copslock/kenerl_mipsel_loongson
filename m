Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2016 03:34:42 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:36711 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027079AbcDTBel2Dzdl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Apr 2016 03:34:41 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 45B1E60470;
        Wed, 20 Apr 2016 01:34:40 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3286E601A0; Wed, 20 Apr 2016 01:34:40 +0000 (UTC)
Received: from sboyd-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7F425601A0;
        Wed, 20 Apr 2016 01:34:38 +0000 (UTC)
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: alchemy: Remove CLK_IS_ROOT
Date:   Tue, 19 Apr 2016 18:34:37 -0700
Message-Id: <1461116077-1103-1-git-send-email-sboyd@codeaurora.org>
X-Mailer: git-send-email 2.6.3.369.g91ad409
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53110
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

Cc: Manuel Lauss <manuel.lauss@gmail.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/mips/alchemy/common/clock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/alchemy/common/clock.c b/arch/mips/alchemy/common/clock.c
index bd34f4093cd9..7ba7ea0a22f8 100644
--- a/arch/mips/alchemy/common/clock.c
+++ b/arch/mips/alchemy/common/clock.c
@@ -1043,8 +1043,7 @@ static int __init alchemy_clk_init(void)
 
 	/* Root of the Alchemy clock tree: external 12MHz crystal osc */
 	c = clk_register_fixed_rate(NULL, ALCHEMY_ROOT_CLK, NULL,
-					   CLK_IS_ROOT,
-					   ALCHEMY_ROOTCLK_RATE);
+					   0, ALCHEMY_ROOTCLK_RATE);
 	ERRCK(c)
 
 	/* CPU core clock */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
