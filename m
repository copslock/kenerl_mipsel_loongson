Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jun 2010 13:20:32 +0200 (CEST)
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:37107 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491777Ab0FILUY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Jun 2010 13:20:24 +0200
Received: from faui49h (faui49h.informatik.uni-erlangen.de [131.188.42.58])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id F37385F26E;
        Wed,  9 Jun 2010 13:20:22 +0200 (MEST)
Received: by faui49h (sSMTP sendmail emulation); Wed, 09 Jun 2010 13:20:23 +0200
Date:   Wed, 9 Jun 2010 13:20:23 +0200
From:   Christoph Egger <siccegge@cs.fau.de>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     vamos@i4.informatik.uni-erlangen.de
Subject: [PATCH 1/9] Removing dead CONFIG_SOC_AU1000_FREQUENCY
Message-ID: <2bd4314b3380c3c4aedd686f14187a80d00522e7.1275925108.git.siccegge@cs.fau.de>
References: <cover.1275925108.git.siccegge@cs.fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1275925108.git.siccegge@cs.fau.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 27101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: siccegge@cs.fau.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6331

CONFIG_SOC_AU1000_FREQUENCY doesn't exist in Kconfig, therefore
removing all references for it from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
 arch/mips/alchemy/common/clocks.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/mips/alchemy/common/clocks.c b/arch/mips/alchemy/common/clocks.c
index 460c628..af0fe41 100644
--- a/arch/mips/alchemy/common/clocks.c
+++ b/arch/mips/alchemy/common/clocks.c
@@ -89,11 +89,7 @@ unsigned long au1xxx_calc_clock(void)
 	 * over backwards trying to determine the frequency.
 	 */
 	if (au1xxx_cpu_has_pll_wo())
-#ifdef CONFIG_SOC_AU1000_FREQUENCY
-		cpu_speed = CONFIG_SOC_AU1000_FREQUENCY;
-#else
 		cpu_speed = 396000000;
-#endif
 	else
 		cpu_speed = (au_readl(SYS_CPUPLL) & 0x0000003f) * AU1000_SRC_CLK;
 
-- 
1.6.3.3
