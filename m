Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Sep 2014 20:33:27 +0200 (CEST)
Received: from mail-la0-f44.google.com ([209.85.215.44]:45585 "EHLO
        mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010014AbaI1SbUZYTO0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Sep 2014 20:31:20 +0200
Received: by mail-la0-f44.google.com with SMTP id gi9so6621792lab.3
        for <multiple recipients>; Sun, 28 Sep 2014 11:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ko+8MZyCgIw8gIRWn8uYbCxtQci8ICkEY2k/C4+PZXg=;
        b=yeq4ottM5bC8Mt0cP6rHxttRCuloa0L9FO4rB9r+TmiQyhONbSDkttwcHqwtz1b53g
         StLPhWcJ8qXwz7JkFfo1qn71Aouh0OdleU2cjh5fAcfSPcuEZfBYT+H64I1SKPjhF7tx
         2RdvOQWWL8DeZH1el9ZXOODZ4SwgcEBSF9W7vIAmRZDtSLO9yKJhESNoRkV4mQzML3De
         QCwzPrQ8trbTO4Sh5Ufz/L1detG0CqqLxxosGHPLfzPBFhWucp9oAkcxZTAP5KL5vtzU
         tyDfSshLsbGzZJxr736I3dDqKSRWbI+Bu3sMzvqttBSMMcJ7xSgu2ia6qJThodwR4NKg
         lPTg==
X-Received: by 10.112.142.104 with SMTP id rv8mr31393513lbb.59.1411929075059;
        Sun, 28 Sep 2014 11:31:15 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id je9sm581674lbc.3.2014.09.28.11.31.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Sep 2014 11:31:14 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH 08/16] MIPS: ar231x: add SoC type detection
Date:   Sun, 28 Sep 2014 22:33:07 +0400
Message-Id: <1411929195-23775-9-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42859
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
 arch/mips/ar231x/ar2315.c  | 22 +++++++++++++++++++++-
 arch/mips/ar231x/ar5312.c  | 22 ++++++++++++++++++++++
 arch/mips/ar231x/devices.c |  7 +++++++
 arch/mips/ar231x/devices.h | 11 +++++++++++
 4 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/mips/ar231x/ar2315.c b/arch/mips/ar231x/ar2315.c
index 0b973eb..7791637 100644
--- a/arch/mips/ar231x/ar2315.c
+++ b/arch/mips/ar231x/ar2315.c
@@ -21,6 +21,7 @@
 #include <asm/reboot.h>
 #include <asm/time.h>
 
+#include <ar231x_platform.h>
 #include <ar2315_regs.h>
 #include <ar231x.h>
 
@@ -249,7 +250,7 @@ void __init ar2315_plat_mem_setup(void)
 
 void __init ar2315_prom_init(void)
 {
-	u32 memsize, memcfg;
+	u32 memsize, memcfg, devid;
 
 	if (!is_2315())
 		return;
@@ -260,6 +261,25 @@ void __init ar2315_prom_init(void)
 	memsize <<= 1 + AR231X_REG_MS(memcfg, AR2315_MEM_CFG_ROW_WIDTH);
 	memsize <<= 3;
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
+
+	/* Detect the hardware based on the device ID */
+	devid = ar231x_read_reg(AR2315_SREV) & AR2315_REV_CHIP;
+	switch (devid) {
+	case 0x91:	/* Need to check */
+		ar231x_devtype = DEV_TYPE_AR2318;
+		break;
+	case 0x90:
+		ar231x_devtype = DEV_TYPE_AR2317;
+		break;
+	case 0x87:
+		ar231x_devtype = DEV_TYPE_AR2316;
+		break;
+	case 0x86:
+	default:
+		ar231x_devtype = DEV_TYPE_AR2315;
+		break;
+	}
+	ar231x_board.devid = devid;
 }
 
 void __init ar2315_arch_init(void)
diff --git a/arch/mips/ar231x/ar5312.c b/arch/mips/ar231x/ar5312.c
index 576c790..f207d14 100644
--- a/arch/mips/ar231x/ar5312.c
+++ b/arch/mips/ar231x/ar5312.c
@@ -21,6 +21,7 @@
 #include <asm/reboot.h>
 #include <asm/time.h>
 
+#include <ar231x_platform.h>
 #include <ar5312_regs.h>
 #include <ar231x.h>
 
@@ -165,6 +166,8 @@ ar5312_flash_limit = (u8 *)KSEG1ADDR(AR5312_FLASH + 0x800000);
 
 void __init ar5312_init_devices(void)
 {
+	struct ar231x_boarddata *config;
+
 	if (!is_5312())
 		return;
 
@@ -172,6 +175,19 @@ void __init ar5312_init_devices(void)
 
 	/* Locate board/radio config data */
 	ar231x_find_config(ar5312_flash_limit);
+	config = ar231x_board.config;
+
+	/* AR2313 has CPU minor rev. 10 */
+	if ((current_cpu_data.processor_id & 0xff) == 0x0a)
+		ar231x_devtype = DEV_TYPE_AR2313;
+
+	/* AR2312 shares the same Silicon ID as AR5312 */
+	else if (config->flags & BD_ISCASPER)
+		ar231x_devtype = DEV_TYPE_AR2312;
+
+	/* Everything else is probably AR5312 or compatible */
+	else
+		ar231x_devtype = DEV_TYPE_AR5312;
 }
 
 static void ar5312_restart(char *command)
@@ -274,6 +290,7 @@ void __init ar5312_plat_mem_setup(void)
 void __init ar5312_prom_init(void)
 {
 	u32 memsize, memcfg, bank0_ac, bank1_ac;
+	u32 devid;
 
 	if (!is_5312())
 		return;
@@ -286,6 +303,11 @@ void __init ar5312_prom_init(void)
 		  (bank1_ac ? (1 << (bank1_ac + 1)) : 0);
 	memsize <<= 20;
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
+
+	devid = ar231x_read_reg(AR5312_REV);
+	devid >>= AR5312_REV_WMAC_MIN_S;
+	devid &= AR5312_REV_CHIP;
+	ar231x_board.devid = (u16)devid;
 }
 
 void __init ar5312_arch_init(void)
diff --git a/arch/mips/ar231x/devices.c b/arch/mips/ar231x/devices.c
index 0b7d42b..21f90f2 100644
--- a/arch/mips/ar231x/devices.c
+++ b/arch/mips/ar231x/devices.c
@@ -12,6 +12,13 @@ struct ar231x_board_config ar231x_board;
 int ar231x_devtype = DEV_TYPE_UNKNOWN;
 
 static const char * const devtype_strings[] = {
+	[DEV_TYPE_AR5312] = "Atheros AR5312",
+	[DEV_TYPE_AR2312] = "Atheros AR2312",
+	[DEV_TYPE_AR2313] = "Atheros AR2313",
+	[DEV_TYPE_AR2315] = "Atheros AR2315",
+	[DEV_TYPE_AR2316] = "Atheros AR2316",
+	[DEV_TYPE_AR2317] = "Atheros AR2317",
+	[DEV_TYPE_AR2318] = "Atheros AR2318",
 	[DEV_TYPE_UNKNOWN] = "Atheros (unknown)",
 };
 
diff --git a/arch/mips/ar231x/devices.h b/arch/mips/ar231x/devices.h
index ef50bd0..5ffa091 100644
--- a/arch/mips/ar231x/devices.h
+++ b/arch/mips/ar231x/devices.h
@@ -4,6 +4,17 @@
 #include <linux/cpu.h>
 
 enum {
+	/* handled by ar5312.c */
+	DEV_TYPE_AR2312,
+	DEV_TYPE_AR2313,
+	DEV_TYPE_AR5312,
+
+	/* handled by ar2315.c */
+	DEV_TYPE_AR2315,
+	DEV_TYPE_AR2316,
+	DEV_TYPE_AR2317,
+	DEV_TYPE_AR2318,
+
 	DEV_TYPE_UNKNOWN
 };
 
-- 
1.8.5.5
