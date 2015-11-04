Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2015 11:51:47 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:37391 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011172AbbKDKudBaLFw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Nov 2015 11:50:33 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 1611A28098D;
        Wed,  4 Nov 2015 11:48:42 +0100 (CET)
Received: from localhost.localdomain (p548C90D8.dip0.t-ipconnect.de [84.140.144.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Wed,  4 Nov 2015 11:48:42 +0100 (CET)
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 6/9] arch: mips: ralink: remove check for CONFIG_PCI on non-PCI SoCs
Date:   Wed,  4 Nov 2015 11:50:11 +0100
Message-Id: <1446634214-11564-6-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1446634214-11564-1-git-send-email-blogic@openwrt.org>
References: <1446634214-11564-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49832
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

The code currently panics if PCI is enabled but the SoC has no PCI bus.
This check is superfluous as the driver only loads if enabled in the
devicetree.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/mt7620.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 55ddf09..dfb04fc 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -535,9 +535,6 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 			ralink_soc = MT762X_SOC_MT7620N;
 			name = "MT7620N";
 			soc_info->compatible = "ralink,mt7620n-soc";
-#ifdef CONFIG_PCI
-			panic("mt7620n is only supported for non pci kernels");
-#endif
 		}
 	} else if (n0 == MT7620_CHIP_NAME0 && n1 == MT7628_CHIP_NAME1) {
 		u32 efuse = __raw_readl(sysc + SYSC_REG_EFUSE_CFG);
-- 
1.7.10.4
