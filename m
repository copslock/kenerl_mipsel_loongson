Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 00:21:14 +0100 (CET)
Received: from mail-lb0-f181.google.com ([209.85.217.181]:34375 "EHLO
        mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011806AbaJ1XTGVDyTl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 00:19:06 +0100
Received: by mail-lb0-f181.google.com with SMTP id w7so1552338lbi.12
        for <multiple recipients>; Tue, 28 Oct 2014 16:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mpc4XW9vXtECjdWLL9F024c3GA+BbVWIeo1k++5ZU38=;
        b=ZXc4POxfIXbRHDmxutBL3qxDnCOWck/VgtylfeJWdT2LbhEsa4437gu+QsXEBGW52x
         4AJd8XV7/HQr73Cp+mIaM1+JFtHplJXEKTk+FoJczbNOPvOoyPR9gkN/SyWsMXYU6FUD
         6EiuWbfjqi0cunhPhtTVnkzOluuht81GHnhIO7R17r+BSvfhlSJbl2Monl6l/X0A/Y43
         SUzjZZMRfyFTKEZvBtC8yRLtUhZOTRmsmxCxMnMO9pwUXgQ2QX1oQi+tA1YL5VbNv/18
         Fr5b7cYmew2TvYO8Wkagf9IRZcUv6HX2oxTXl3R0pfl2pzNzldh3IQN/4XM4JdnmUTR+
         s0Hg==
X-Received: by 10.112.180.198 with SMTP id dq6mr7279718lbc.56.1414538340927;
        Tue, 28 Oct 2014 16:19:00 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id i6sm1173752laf.47.2014.10.28.16.18.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Oct 2014 16:19:00 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH v3 08/13] MIPS: ath25: add SoC type detection
Date:   Wed, 29 Oct 2014 03:18:45 +0400
Message-Id: <1414538330-5548-9-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1414538330-5548-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1414538330-5548-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

Detect SoC type based on device ID and board configuration data.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---

Changes since v1:
  - rename MIPS machine ar231x -> ath25
  - rename dev_type -> soc_type

Changes since v2:
  - move SoC devid reading to plat_mem_setup

 arch/mips/ath25/ar2315.c  | 22 ++++++++++++++++++++++
 arch/mips/ath25/ar5312.c  | 23 +++++++++++++++++++++++
 arch/mips/ath25/devices.c | 17 ++++++++++++++++-
 arch/mips/ath25/devices.h | 16 ++++++++++++++++
 4 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/arch/mips/ath25/ar2315.c b/arch/mips/ath25/ar2315.c
index 3ba8e75..52805b7 100644
--- a/arch/mips/ath25/ar2315.c
+++ b/arch/mips/ath25/ar2315.c
@@ -24,6 +24,8 @@
 #include <asm/reboot.h>
 #include <asm/time.h>
 
+#include <ath25_platform.h>
+
 #include "devices.h"
 #include "ar2315.h"
 #include "ar2315_regs.h"
@@ -249,6 +251,7 @@ void __init ar2315_plat_mem_setup(void)
 {
 	void __iomem *sdram_base;
 	u32 memsize, memcfg;
+	u32 devid;
 	u32 config;
 
 	/* Detect memory size */
@@ -264,6 +267,25 @@ void __init ar2315_plat_mem_setup(void)
 
 	ar2315_rst_base = ioremap_nocache(AR2315_RST_BASE, AR2315_RST_SIZE);
 
+	/* Detect the hardware based on the device ID */
+	devid = ar2315_rst_reg_read(AR2315_SREV) & AR2315_REV_CHIP;
+	switch (devid) {
+	case 0x91:	/* Need to check */
+		ath25_soc = ATH25_SOC_AR2318;
+		break;
+	case 0x90:
+		ath25_soc = ATH25_SOC_AR2317;
+		break;
+	case 0x87:
+		ath25_soc = ATH25_SOC_AR2316;
+		break;
+	case 0x86:
+	default:
+		ath25_soc = ATH25_SOC_AR2315;
+		break;
+	}
+	ath25_board.devid = devid;
+
 	/* Clear any lingering AHB errors */
 	config = read_c0_config();
 	write_c0_config(config & ~0x3);
diff --git a/arch/mips/ath25/ar5312.c b/arch/mips/ath25/ar5312.c
index 41bd56d..26942a2 100644
--- a/arch/mips/ath25/ar5312.c
+++ b/arch/mips/ath25/ar5312.c
@@ -24,6 +24,8 @@
 #include <asm/reboot.h>
 #include <asm/time.h>
 
+#include <ath25_platform.h>
+
 #include "devices.h"
 #include "ar5312.h"
 #include "ar5312_regs.h"
@@ -191,10 +193,25 @@ static void __init ar5312_flash_init(void)
 
 void __init ar5312_init_devices(void)
 {
+	struct ath25_boarddata *config;
+
 	ar5312_flash_init();
 
 	/* Locate board/radio config data */
 	ath25_find_config(AR5312_FLASH_BASE, AR5312_FLASH_SIZE);
+	config = ath25_board.config;
+
+	/* AR2313 has CPU minor rev. 10 */
+	if ((current_cpu_data.processor_id & 0xff) == 0x0a)
+		ath25_soc = ATH25_SOC_AR2313;
+
+	/* AR2312 shares the same Silicon ID as AR5312 */
+	else if (config->flags & BD_ISCASPER)
+		ath25_soc = ATH25_SOC_AR2312;
+
+	/* Everything else is probably AR5312 or compatible */
+	else
+		ath25_soc = ATH25_SOC_AR5312;
 }
 
 static void ar5312_restart(char *command)
@@ -282,6 +299,7 @@ void __init ar5312_plat_mem_setup(void)
 {
 	void __iomem *sdram_base;
 	u32 memsize, memcfg, bank0_ac, bank1_ac;
+	u32 devid;
 
 	/* Detect memory size */
 	sdram_base = ioremap_nocache(AR5312_SDRAMCTL_BASE,
@@ -297,6 +315,11 @@ void __init ar5312_plat_mem_setup(void)
 
 	ar5312_rst_base = ioremap_nocache(AR5312_RST_BASE, AR5312_RST_SIZE);
 
+	devid = ar5312_rst_reg_read(AR5312_REV);
+	devid >>= AR5312_REV_WMAC_MIN_S;
+	devid &= AR5312_REV_CHIP;
+	ath25_board.devid = (u16)devid;
+
 	/* Clear any lingering AHB errors */
 	ar5312_rst_reg_read(AR5312_PROCADDR);
 	ar5312_rst_reg_read(AR5312_DMAADDR);
diff --git a/arch/mips/ath25/devices.c b/arch/mips/ath25/devices.c
index d24dbb1..6218547 100644
--- a/arch/mips/ath25/devices.c
+++ b/arch/mips/ath25/devices.c
@@ -9,10 +9,25 @@
 #include "ar2315.h"
 
 struct ar231x_board_config ath25_board;
+enum ath25_soc_type ath25_soc = ATH25_SOC_UNKNOWN;
+
+static const char * const soc_type_strings[] = {
+	[ATH25_SOC_AR5312] = "Atheros AR5312",
+	[ATH25_SOC_AR2312] = "Atheros AR2312",
+	[ATH25_SOC_AR2313] = "Atheros AR2313",
+	[ATH25_SOC_AR2315] = "Atheros AR2315",
+	[ATH25_SOC_AR2316] = "Atheros AR2316",
+	[ATH25_SOC_AR2317] = "Atheros AR2317",
+	[ATH25_SOC_AR2318] = "Atheros AR2318",
+	[ATH25_SOC_UNKNOWN] = "Atheros (unknown)",
+};
 
 const char *get_system_type(void)
 {
-	return "Atheros (unknown)";
+	if ((ath25_soc >= ARRAY_SIZE(soc_type_strings)) ||
+	    !soc_type_strings[ath25_soc])
+		return soc_type_strings[ATH25_SOC_UNKNOWN];
+	return soc_type_strings[ath25_soc];
 }
 
 void __init ath25_serial_setup(u32 mapbase, int irq, unsigned int uartclk)
diff --git a/arch/mips/ath25/devices.h b/arch/mips/ath25/devices.h
index 65e86cc..55adcf4 100644
--- a/arch/mips/ath25/devices.h
+++ b/arch/mips/ath25/devices.h
@@ -7,6 +7,22 @@
 
 #define ATH25_IRQ_CPU_CLOCK	(MIPS_CPU_IRQ_BASE + 7)	/* C0_CAUSE: 0x8000 */
 
+enum ath25_soc_type {
+	/* handled by ar5312.c */
+	ATH25_SOC_AR2312,
+	ATH25_SOC_AR2313,
+	ATH25_SOC_AR5312,
+
+	/* handled by ar2315.c */
+	ATH25_SOC_AR2315,
+	ATH25_SOC_AR2316,
+	ATH25_SOC_AR2317,
+	ATH25_SOC_AR2318,
+
+	ATH25_SOC_UNKNOWN
+};
+
+extern enum ath25_soc_type ath25_soc;
 extern struct ar231x_board_config ath25_board;
 extern void (*ath25_irq_dispatch)(void);
 
-- 
1.8.5.5
