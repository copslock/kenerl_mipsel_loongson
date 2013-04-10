Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Apr 2013 13:53:11 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:41806 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822673Ab3DJLve2D9T7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Apr 2013 13:51:34 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Gabor Juhos <juhosg@openwrt.org>, linux-mips@linux-mips.org,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 04/18] MIPS: ralink: add RT5350 sdram register defines
Date:   Wed, 10 Apr 2013 13:47:13 +0200
Message-Id: <1365594447-13068-5-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1365594447-13068-1-git-send-email-blogic@openwrt.org>
References: <1365594447-13068-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36042
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

Add a few missing defines that are needed to make memory detection work on the
RT5350.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/mach-ralink/rt305x.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/include/asm/mach-ralink/rt305x.h b/arch/mips/include/asm/mach-ralink/rt305x.h
index 7d344f2..4e62cef 100644
--- a/arch/mips/include/asm/mach-ralink/rt305x.h
+++ b/arch/mips/include/asm/mach-ralink/rt305x.h
@@ -97,6 +97,14 @@ static inline int soc_is_rt5350(void)
 #define RT5350_SYSCFG0_CPUCLK_320	0x2
 #define RT5350_SYSCFG0_CPUCLK_300	0x3
 
+#define RT5350_SYSCFG0_DRAM_SIZE_SHIFT  12
+#define RT5350_SYSCFG0_DRAM_SIZE_MASK   7
+#define RT5350_SYSCFG0_DRAM_SIZE_2M     0
+#define RT5350_SYSCFG0_DRAM_SIZE_8M     1
+#define RT5350_SYSCFG0_DRAM_SIZE_16M    2
+#define RT5350_SYSCFG0_DRAM_SIZE_32M    3
+#define RT5350_SYSCFG0_DRAM_SIZE_64M    4
+
 /* multi function gpio pins */
 #define RT305X_GPIO_I2C_SD		1
 #define RT305X_GPIO_I2C_SCLK		2
-- 
1.7.10.4
