Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 13:25:01 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:55310 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6865303Ab3HHLY6kSwXE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Aug 2013 13:24:58 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 1/5] MIPS: ralink: mt7620: add verbose ram info
Date:   Thu,  8 Aug 2013 13:17:48 +0200
Message-Id: <1375960672-32619-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37463
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

Make the code print which of SDRAM, DDR1 or DDR2 was detected.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/mt7620.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 0018b1a..ccdec5a 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -214,16 +214,19 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 
 	switch (dram_type) {
 	case SYSCFG0_DRAM_TYPE_SDRAM:
+		pr_info("Board has SDRAM\n");
 		soc_info->mem_size_min = MT7620_SDRAM_SIZE_MIN;
 		soc_info->mem_size_max = MT7620_SDRAM_SIZE_MAX;
 		break;
 
 	case SYSCFG0_DRAM_TYPE_DDR1:
+		pr_info("Board has DDR1\n");
 		soc_info->mem_size_min = MT7620_DDR1_SIZE_MIN;
 		soc_info->mem_size_max = MT7620_DDR1_SIZE_MAX;
 		break;
 
 	case SYSCFG0_DRAM_TYPE_DDR2:
+		pr_info("Board has DDR2\n");
 		soc_info->mem_size_min = MT7620_DDR2_SIZE_MIN;
 		soc_info->mem_size_max = MT7620_DDR2_SIZE_MAX;
 		break;
-- 
1.7.10.4
