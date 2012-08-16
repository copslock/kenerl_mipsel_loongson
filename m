Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2012 11:27:50 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:49348 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903515Ab2HPJ06 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Aug 2012 11:26:58 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 3/4] MIPS: lantiq: falcon clocks were not enabled properly
Date:   Thu, 16 Aug 2012 11:25:41 +0200
Message-Id: <1345109142-1756-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1345109142-1756-1-git-send-email-blogic@openwrt.org>
References: <1345109142-1756-1-git-send-email-blogic@openwrt.org>
X-archive-position: 34201
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
Return-Path: <linux-mips-bounce@linux-mips.org>

As a result of a non populated ->bits field inside the clock struct, the clock
domains were never powered on the Falcon. Until now we only used domains that
were also used and powered by the bootloader.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/falcon/sysctrl.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/lantiq/falcon/sysctrl.c b/arch/mips/lantiq/falcon/sysctrl.c
index ba0123d..2d4ced3 100644
--- a/arch/mips/lantiq/falcon/sysctrl.c
+++ b/arch/mips/lantiq/falcon/sysctrl.c
@@ -171,6 +171,7 @@ static inline void clkdev_add_sys(const char *dev, unsigned int module,
 	clk->cl.con_id = NULL;
 	clk->cl.clk = clk;
 	clk->module = module;
+	clk->bits = bits;
 	clk->activate = sysctl_activate;
 	clk->deactivate = sysctl_deactivate;
 	clk->enable = sysctl_clken;
-- 
1.7.9.1
