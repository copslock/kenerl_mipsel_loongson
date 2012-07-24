Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2012 08:57:15 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:47943 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903414Ab2GXG5I (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jul 2012 08:57:08 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH] MIPS: lantiq: explicitly enable clkout generation
Date:   Tue, 24 Jul 2012 08:56:41 +0200
Message-Id: <1343113001-12896-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
X-archive-position: 33959
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

Previously we relied on the bootloader to have enabled this bit. However some
bootloaders seem to not enable this for us.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/xway/sysctrl.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 79887af..8863cca 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -191,10 +191,12 @@ static int clkout_enable(struct clk *clk)
 	for (i = 0; i < 4; i++) {
 		if (clk->rates[i] == clk->rate) {
 			int shift = 14 - (2 * clk->module);
+			int enable = 7 - clk->module;
 			unsigned int val = ltq_cgu_r32(ifccr);
 
 			val &= ~(3 << shift);
 			val |= i << shift;
+			val |= enable;
 			ltq_cgu_w32(val, ifccr);
 			return 0;
 		}
-- 
1.7.9.1
