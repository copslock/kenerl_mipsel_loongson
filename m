Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2016 05:44:49 +0200 (CEST)
Received: from alexus4.isprime.com ([66.230.158.162]:21270 "EHLO
        antarctida.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026142AbcDTDosMD1x4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Apr 2016 05:44:48 +0200
Received: (qmail 94575 invoked by uid 1041); 20 Apr 2016 03:44:46 -0000
X-Qmail-Scanner-Diagnostics: from 207.38.188.197 (test1@matrixagents.net@207.38.188.197) by alpha.antarctida.com (envelope-from <linux-mips@durdom.com>, uid 82) with qmail-scanner-2.11st 
 (clamdscan: 0.98.4/19613. spamassassin: 3.4.0. perlscan: 2.11st.  
 Clear:RC:0(207.38.188.197):SA:0(-101.0/5.0):. 
 Processed in 0.659591 secs); 20 Apr 2016 03:44:46 -0000
X-Envelope-From: linux-mips@durdom.com
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO book.local) (test1@matrixagents.net@207.38.188.197)
  by antarctida.com with ESMTPS (DHE-RSA-AES128-SHA encrypted); 20 Apr 2016 03:44:45 -0000
From:   Sashka Nochkin <linux-mips@durdom.com>
Subject: [PATCH] mips: mt7620: fallback to SDRAM when syscfg0 does not have a
 valid value for the memory type
Reply-To: linux-mips@durdom.com
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Message-ID: <5716FB2D.1070606@durdom.com>
Date:   Tue, 19 Apr 2016 23:44:45 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:38.0)
 Gecko/20100101 Thunderbird/38.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <linux-mips@durdom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-mips@durdom.com
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

Mediatek MT7620 SoC has syscfg0 bits where it sets the type of memory being used.
However, sometimes those bits are not set properly (reading "11"). In this case, the SoC assumes SDRAM.
The patch below reflects that.

Signed-off-by: Sashka Nochkin <linux-mips@durdom.com>
---
 arch/mips/include/asm/mach-ralink/mt7620.h | 1 +
 arch/mips/ralink/mt7620.c                  | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-ralink/mt7620.h b/arch/mips/include/asm/mach-ralink/mt7620.h
index 455d406..1f5998a 100644
--- a/arch/mips/include/asm/mach-ralink/mt7620.h
+++ b/arch/mips/include/asm/mach-ralink/mt7620.h
@@ -72,6 +72,7 @@
 #define SYSCFG0_DRAM_TYPE_SDRAM		0
 #define SYSCFG0_DRAM_TYPE_DDR1		1
 #define SYSCFG0_DRAM_TYPE_DDR2		2
+#define SYSCFG0_DRAM_TYPE_UNKNOWN	3
 
 #define SYSCFG0_DRAM_TYPE_DDR2_MT7628	0
 #define SYSCFG0_DRAM_TYPE_DDR1_MT7628	1
diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 0d3d1a9..0358ac4d 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -581,11 +581,14 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 		(rev & CHIP_REV_ECO_MASK));
 
 	cfg0 = __raw_readl(sysc + SYSC_REG_SYSTEM_CONFIG0);
-	if (is_mt76x8())
+	if (is_mt76x8()) {
 		dram_type = cfg0 & DRAM_TYPE_MT7628_MASK;
-	else
+	} else {
 		dram_type = (cfg0 >> SYSCFG0_DRAM_TYPE_SHIFT) &
 			    SYSCFG0_DRAM_TYPE_MASK;
+		if (dram_type == SYSCFG0_DRAM_TYPE_UNKNOWN)
+			dram_type = SYSCFG0_DRAM_TYPE_SDRAM;
+	}
 
 	soc_info->mem_base = MT7620_DRAM_BASE;
 	if (is_mt76x8())
