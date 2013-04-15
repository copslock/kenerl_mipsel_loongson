Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Apr 2013 12:46:39 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:52562 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835127Ab3DOKpkF1oSb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Apr 2013 12:45:40 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 4/7] MIPS: ralink: add memory definition for RT2880
Date:   Mon, 15 Apr 2013 12:41:31 +0200
Message-Id: <1366022494-8355-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1366022494-8355-1-git-send-email-blogic@openwrt.org>
References: <1366022494-8355-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36172
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

Populate struct soc_info with the data that describes our RAM window.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/mach-ralink/rt288x.h |    4 ++++
 arch/mips/ralink/rt288x.c                  |    4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/mips/include/asm/mach-ralink/rt288x.h b/arch/mips/include/asm/mach-ralink/rt288x.h
index ad8b42d..459059b 100644
--- a/arch/mips/include/asm/mach-ralink/rt288x.h
+++ b/arch/mips/include/asm/mach-ralink/rt288x.h
@@ -46,4 +46,8 @@
 
 #define CLKCFG_SRAM_CS_N_WDT		BIT(9)
 
+#define RT2880_SDRAM_BASE		0x08000000
+#define RT2880_MEM_SIZE_MIN		(2 * 1024 * 1024)
+#define RT2880_MEM_SIZE_MAX		(128 * 1024 * 1024)
+
 #endif
diff --git a/arch/mips/ralink/rt288x.c b/arch/mips/ralink/rt288x.c
index 1e0788e..f87de1a 100644
--- a/arch/mips/ralink/rt288x.c
+++ b/arch/mips/ralink/rt288x.c
@@ -136,4 +136,8 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 		name,
 		(id >> CHIP_ID_ID_SHIFT) & CHIP_ID_ID_MASK,
 		(id & CHIP_ID_REV_MASK));
+
+	soc_info->mem_base = RT2880_SDRAM_BASE;
+	soc_info->mem_size_min = RT2880_MEM_SIZE_MIN;
+	soc_info->mem_size_max = RT2880_MEM_SIZE_MAX;
 }
-- 
1.7.10.4
