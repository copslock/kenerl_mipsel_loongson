Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 May 2013 18:22:34 +0200 (CEST)
Received: from smtp-out-016.synserver.de ([212.40.185.16]:1121 "EHLO
        smtp-out-015.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6824780Ab3E3QWI7GMwE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 May 2013 18:22:08 +0200
Received: (qmail 26392 invoked by uid 0); 30 May 2013 16:22:01 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 26279
Received: from ppp-188-174-155-156.dynamic.mnet-online.de (HELO lars-laptop.fritz.box) [188.174.155.156]
  by 217.119.54.73 with SMTP; 30 May 2013 16:22:01 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Maarten ter Huurne <maarten@treewalker.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 1/6] MIPS: jz4740: Correct clock gate bit for DMA controller
Date:   Thu, 30 May 2013 18:25:00 +0200
Message-Id: <1369931105-28065-2-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1369931105-28065-1-git-send-email-lars@metafoo.de>
References: <1369931105-28065-1-git-send-email-lars@metafoo.de>
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

From: Maarten ter Huurne <maarten@treewalker.org>

Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
---
No changes since v1
---
 arch/mips/jz4740/clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/jz4740/clock.c b/arch/mips/jz4740/clock.c
index 484d38a..1b5f554 100644
--- a/arch/mips/jz4740/clock.c
+++ b/arch/mips/jz4740/clock.c
@@ -687,7 +687,7 @@ static struct clk jz4740_clock_simple_clks[] = {
 	[3] = {
 		.name = "dma",
 		.parent = &jz_clk_high_speed_peripheral.clk,
-		.gate_bit = JZ_CLOCK_GATE_UART0,
+		.gate_bit = JZ_CLOCK_GATE_DMAC,
 		.ops = &jz_clk_simple_ops,
 	},
 	[4] = {
-- 
1.8.2.1
