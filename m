Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2012 11:28:15 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:49350 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903523Ab2HPJ07 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Aug 2012 11:26:59 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 4/4] MIPS: lantiq: enable pci clk conditional for xrx200 SoC
Date:   Thu, 16 Aug 2012 11:25:42 +0200
Message-Id: <1345109142-1756-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1345109142-1756-1-git-send-email-blogic@openwrt.org>
References: <1345109142-1756-1-git-send-email-blogic@openwrt.org>
X-archive-position: 34202
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

The xrx200 SoC family has the same PCI clock register layout as the AR9.
Enable the same quirk as for AR9

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/xway/sysctrl.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 8863cca..655c210 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -149,7 +149,8 @@ static int pci_enable(struct clk *clk)
 {
 	unsigned int val = ltq_cgu_r32(ifccr);
 	/* set bus clock speed */
-	if (of_machine_is_compatible("lantiq,ar9")) {
+	if (of_machine_is_compatible("lantiq,ar9") ||
+			of_machine_is_compatible("lantiq,vr9")) {
 		val &= ~0x1f00000;
 		if (clk->rate == CLOCK_33M)
 			val |= 0xe00000;
-- 
1.7.9.1
