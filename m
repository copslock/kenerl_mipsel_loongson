Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 01:06:02 +0200 (CEST)
Received: from mail-lb0-f178.google.com ([209.85.217.178]:61137 "EHLO
        mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012108AbaJUXDuAZhgS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 01:03:50 +0200
Received: by mail-lb0-f178.google.com with SMTP id w7so1896580lbi.9
        for <multiple recipients>; Tue, 21 Oct 2014 16:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7dvb969b/pjgAY1Wk0b1e5fiIWWZB9kYiIUyzBiGhPk=;
        b=NkaPYZdsfNhtESzIBqR5yRC/A8SShR4NjgmkQPFnC5Klb6HT6VAvFedmB/Bmtbd9f+
         KjKyXb1emW0sUCFbHmivLD1jSgVRoQGwyESQkQxp3zfgCLnXrnmX0FLt0U2Omx6IGzDl
         XdHEkRTe0YkrUO9wbFMDRDzxKU3ZImA++7a5BEV53uBO4OzgzPzXpdE5xLj/5z6MYqez
         J8tnfma8d1grBx6C2i/hKgX554A6YxRK4bTPnchA8XZx7MHYtcXsiC8kJJyO8jjlDpT7
         21neKYH8srxs4IeOe+Y38QKJ3sW9lg/dy4igbLTP8tmiUwfAFnW8O0Vp8y1DpUdb4Yfv
         bp8A==
X-Received: by 10.152.22.135 with SMTP id d7mr37746428laf.46.1413932624573;
        Tue, 21 Oct 2014 16:03:44 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id lk5sm5077133lac.45.2014.10.21.16.03.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 16:03:43 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH v2 08/13] MIPS: ath25: add SoC type detection
Date:   Wed, 22 Oct 2014 03:03:46 +0400
Message-Id: <1413932631-12866-9-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1413932631-12866-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1413932631-12866-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43455
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

 arch/mips/ath25/ar2315.c  | 22 +++++++++++++++++++++-
 arch/mips/ath25/ar5312.c  | 22 ++++++++++++++++++++++
 arch/mips/ath25/devices.c | 17 ++++++++++++++++-
 arch/mips/ath25/devices.h | 16 ++++++++++++++++
 4 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ath25/ar2315.c b/arch/mips/ath25/ar2315.c
index d3ff812..f239035 100644
--- a/arch/mips/ath25/ar2315.c
+++ b/arch/mips/ath25/ar2315.c
@@ -22,6 +22,7 @@
 #include <asm/time.h>
 
 #include <ar2315_regs.h>
+#include <ath25_platform.h>
 #include <ath25.h>
 
 #include "devices.h"
@@ -237,7 +238,7 @@ void __init ar2315_plat_mem_setup(void)
 
 void __init ar2315_prom_init(void)
 {
-	u32 memsize, memcfg;
+	u32 memsize, memcfg, devid;
 
 	memcfg = ath25_read_reg(AR2315_MEM_CFG);
 	memsize   = 1 + ATH25_REG_MS(memcfg, AR2315_MEM_CFG_DATA_WIDTH);
@@ -245,6 +246,25 @@ void __init ar2315_prom_init(void)
 	memsize <<= 1 + ATH25_REG_MS(memcfg, AR2315_MEM_CFG_ROW_WIDTH);
 	memsize <<= 3;
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
+
+	/* Detect the hardware based on the device ID */
+	devid = ath25_read_reg(AR2315_SREV) & AR2315_REV_CHIP;
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
 }
 
 void __init ar2315_arch_init(void)
diff --git a/arch/mips/ath25/ar5312.c b/arch/mips/ath25/ar5312.c
index 2d66665..faa0633 100644
--- a/arch/mips/ath25/ar5312.c
+++ b/arch/mips/ath25/ar5312.c
@@ -22,6 +22,7 @@
 #include <asm/time.h>
 
 #include <ar5312_regs.h>
+#include <ath25_platform.h>
 #include <ath25.h>
 
 #include "devices.h"
@@ -162,10 +163,25 @@ ar5312_flash_limit = (u8 *)KSEG1ADDR(AR5312_FLASH + 0x800000);
 
 void __init ar5312_init_devices(void)
 {
+	struct ath25_boarddata *config;
+
 	ar5312_flash_init();
 
 	/* Locate board/radio config data */
 	ath25_find_config(ar5312_flash_limit);
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
@@ -262,6 +278,7 @@ void __init ar5312_plat_mem_setup(void)
 void __init ar5312_prom_init(void)
 {
 	u32 memsize, memcfg, bank0_ac, bank1_ac;
+	u32 devid;
 
 	/* Detect memory size */
 	memcfg = ath25_read_reg(AR5312_MEM_CFG1);
@@ -271,6 +288,11 @@ void __init ar5312_prom_init(void)
 		  (bank1_ac ? (1 << (bank1_ac + 1)) : 0);
 	memsize <<= 20;
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
+
+	devid = ath25_read_reg(AR5312_REV);
+	devid >>= AR5312_REV_WMAC_MIN_S;
+	devid &= AR5312_REV_CHIP;
+	ath25_board.devid = (u16)devid;
 }
 
 void __init ar5312_arch_init(void)
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
index 10f196d..8555e32 100644
--- a/arch/mips/ath25/devices.h
+++ b/arch/mips/ath25/devices.h
@@ -3,6 +3,22 @@
 
 #include <linux/cpu.h>
 
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
