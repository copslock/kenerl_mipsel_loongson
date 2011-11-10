Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 00:25:45 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:51691 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904247Ab1KJXZd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Nov 2011 00:25:33 +0100
Received: by ywp31 with SMTP id 31so1882633ywp.36
        for <multiple recipients>; Thu, 10 Nov 2011 15:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ZaGlwNtnaXnWnyhgWY1zxq7gyxm3u0cOYl8zSDBB7vE=;
        b=tQYjwu9DFjR49P6925NX54//N9vaCaeFzR9r2C1yOOSgjm1V7CLXFapW2HetswVLxV
         sjLDrQ41IVR7SOYn4L3qZ/zE+34FjoCavmqN2410ADq5gK1WcVunyyHZ/LzBX7w+K9RG
         n9NXOAUssGRy5Tl2NR/QSqfmbhbQ5UbKFTifg=
Received: by 10.101.42.17 with SMTP id u17mr4514451anj.7.1320967526956;
        Thu, 10 Nov 2011 15:25:26 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id m33sm28246677ann.4.2011.11.10.15.25.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Nov 2011 15:25:26 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAANPOhk005534;
        Thu, 10 Nov 2011 15:25:24 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAANPNR9005533;
        Thu, 10 Nov 2011 15:25:23 -0800
From:   ddaney.cavm@gmail.com
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Update Octeon model detection code for new chips.
Date:   Thu, 10 Nov 2011 15:25:20 -0800
Message-Id: <1320967520-5502-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 31513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9832

From: David Daney <david.daney@cavium.com>

Several newer chips were not covered, update the code to detect them.
This necessitates updating cvmx-mio-defs.h as well, because it has new
and required definitions.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/executive/octeon-model.c |  119 ++-
 arch/mips/include/asm/octeon/cvmx-mio-defs.h     | 1033 +++++++++++++++++++++-
 arch/mips/include/asm/octeon/octeon-model.h      |  215 ++---
 3 files changed, 1179 insertions(+), 188 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/octeon-model.c b/arch/mips/cavium-octeon/executive/octeon-model.c
index c8d3568..f4c1b36 100644
--- a/arch/mips/cavium-octeon/executive/octeon-model.c
+++ b/arch/mips/cavium-octeon/executive/octeon-model.c
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2010 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -25,10 +25,6 @@
  * Contact Cavium Networks for more information
  ***********************license end**************************************/
 
-/*
- * File defining functions for working with different Octeon
- * models.
- */
 #include <asm/octeon/octeon.h>
 
 /**
@@ -69,11 +65,12 @@ const char *octeon_model_get_string_buffer(uint32_t chip_id, char *buffer)
 	char fuse_model[10];
 	uint32_t fuse_data = 0;
 
-	fus3.u64 = cvmx_read_csr(CVMX_L2D_FUS3);
+	fus3.u64 = 0;
+	if (!OCTEON_IS_MODEL(OCTEON_CN6XXX))
+		fus3.u64 = cvmx_read_csr(CVMX_L2D_FUS3);
 	fus_dat2.u64 = cvmx_read_csr(CVMX_MIO_FUS_DAT2);
 	fus_dat3.u64 = cvmx_read_csr(CVMX_MIO_FUS_DAT3);
-
-	num_cores = cvmx_octeon_num_cores();
+	num_cores = cvmx_pop(cvmx_read_csr(CVMX_CIU_FUSE));
 
 	/* Make sure the non existent devices look disabled */
 	switch ((chip_id >> 8) & 0xff) {
@@ -108,7 +105,7 @@ const char *octeon_model_get_string_buffer(uint32_t chip_id, char *buffer)
 	 * Assume pass number is encoded using <5:3><2:0>. Exceptions
 	 * will be fixed later.
 	 */
-	sprintf(pass, "%u.%u", ((chip_id >> 3) & 7) + 1, chip_id & 7);
+	sprintf(pass, "%d.%d", (int)((chip_id >> 3) & 7) + 1, (int)chip_id & 7);
 
 	/*
 	 * Use the number of cores to determine the last 2 digits of
@@ -116,6 +113,12 @@ const char *octeon_model_get_string_buffer(uint32_t chip_id, char *buffer)
 	 * later.
 	 */
 	switch (num_cores) {
+	case 32:
+		core_model = "80";
+		break;
+	case 24:
+		core_model = "70";
+		break;
 	case 16:
 		core_model = "60";
 		break;
@@ -246,8 +249,8 @@ const char *octeon_model_get_string_buffer(uint32_t chip_id, char *buffer)
 		break;
 	case 3:		/* CN58XX */
 		family = "58";
-		/* Special case. 4 core, no crypto */
-		if ((num_cores == 4) && fus_dat2.cn38xx.nocrypto)
+		/* Special case. 4 core, half cache (CP with half cache) */
+		if ((num_cores == 4) && fus3.cn58xx.crip_1024k && !strncmp(suffix, "CP", 2))
 			core_model = "29";
 
 		/* Pass 1 uses different encodings for pass numbers */
@@ -285,6 +288,9 @@ const char *octeon_model_get_string_buffer(uint32_t chip_id, char *buffer)
 				suffix = "NSP";
 				if (fus_dat3.s.nozip)
 					suffix = "SCP";
+
+				if (fus_dat3.s.bar2_en)
+					suffix = "NSPB2";
 			}
 			if (fus3.cn56xx.crip_1024k)
 				family = "54";
@@ -301,6 +307,60 @@ const char *octeon_model_get_string_buffer(uint32_t chip_id, char *buffer)
 		else
 			family = "52";
 		break;
+	case 0x93:		/* CN61XX */
+		family = "61";
+		if (fus_dat2.cn61xx.nocrypto && fus_dat2.cn61xx.dorm_crypto)
+			suffix = "AP";
+		if (fus_dat2.cn61xx.nocrypto)
+			suffix = "CP";
+		else if (fus_dat2.cn61xx.dorm_crypto)
+			suffix = "DAP";
+		else if (fus_dat3.cn61xx.nozip)
+			suffix = "SCP";
+		break;
+	case 0x90:		/* CN63XX */
+		family = "63";
+		if (fus_dat3.s.l2c_crip == 2)
+			family = "62";
+		if (num_cores == 6)	/* Other core counts match generic */
+			core_model = "35";
+		if (fus_dat2.cn63xx.nocrypto)
+			suffix = "CP";
+		else if (fus_dat2.cn63xx.dorm_crypto)
+			suffix = "DAP";
+		else if (fus_dat3.cn63xx.nozip)
+			suffix = "SCP";
+		else
+			suffix = "AAP";
+		break;
+	case 0x92:		/* CN66XX */
+		family = "66";
+		if (num_cores == 6)	/* Other core counts match generic */
+			core_model = "35";
+		if (fus_dat2.cn66xx.nocrypto && fus_dat2.cn66xx.dorm_crypto)
+			suffix = "AP";
+		if (fus_dat2.cn66xx.nocrypto)
+			suffix = "CP";
+		else if (fus_dat2.cn66xx.dorm_crypto)
+			suffix = "DAP";
+		else if (fus_dat3.cn66xx.nozip)
+			suffix = "SCP";
+		else
+			suffix = "AAP";
+		break;
+	case 0x91:		/* CN68XX */
+		family = "68";
+		if (fus_dat2.cn68xx.nocrypto && fus_dat3.cn68xx.nozip)
+			suffix = "CP";
+		else if (fus_dat2.cn68xx.dorm_crypto)
+			suffix = "DAP";
+		else if (fus_dat3.cn68xx.nozip)
+			suffix = "SCP";
+		else if (fus_dat2.cn68xx.nocrypto)
+			suffix = "SP";
+		else
+			suffix = "AAP";
+		break;
 	default:
 		family = "XX";
 		core_model = "XX";
@@ -310,49 +370,40 @@ const char *octeon_model_get_string_buffer(uint32_t chip_id, char *buffer)
 	}
 
 	clock_mhz = octeon_get_clock_rate() / 1000000;
-
 	if (family[0] != '3') {
+		int fuse_base = 384 / 8;
+		if (family[0] == '6')
+			fuse_base = 832 / 8;
+
 		/* Check for model in fuses, overrides normal decode */
 		/* This is _not_ valid for Octeon CN3XXX models */
-		fuse_data |= cvmx_fuse_read_byte(51);
+		fuse_data |= cvmx_fuse_read_byte(fuse_base + 3);
 		fuse_data = fuse_data << 8;
-		fuse_data |= cvmx_fuse_read_byte(50);
+		fuse_data |= cvmx_fuse_read_byte(fuse_base + 2);
 		fuse_data = fuse_data << 8;
-		fuse_data |= cvmx_fuse_read_byte(49);
+		fuse_data |= cvmx_fuse_read_byte(fuse_base + 1);
 		fuse_data = fuse_data << 8;
-		fuse_data |= cvmx_fuse_read_byte(48);
+		fuse_data |= cvmx_fuse_read_byte(fuse_base);
 		if (fuse_data & 0x7ffff) {
 			int model = fuse_data & 0x3fff;
 			int suffix = (fuse_data >> 14) & 0x1f;
 			if (suffix && model) {
-				/*
-				 * Have both number and suffix in
-				 * fuses, so both
-				 */
-				sprintf(fuse_model, "%d%c",
-					model, 'A' + suffix - 1);
+				/* Have both number and suffix in fuses, so both */
+				sprintf(fuse_model, "%d%c", model, 'A' + suffix - 1);
 				core_model = "";
 				family = fuse_model;
 			} else if (suffix && !model) {
-				/*
-				 * Only have suffix, so add suffix to
-				 * 'normal' model number.
-				 */
-				sprintf(fuse_model, "%s%c", core_model,
-					'A' + suffix - 1);
+				/* Only have suffix, so add suffix to 'normal' model number */
+				sprintf(fuse_model, "%s%c", core_model, 'A' + suffix - 1);
 				core_model = fuse_model;
 			} else {
-				/*
-				 * Don't have suffix, so just use
-				 * model from fuses.
-				 */
+				/* Don't have suffix, so just use model from fuses */
 				sprintf(fuse_model, "%d", model);
 				core_model = "";
 				family = fuse_model;
 			}
 		}
 	}
-	sprintf(buffer, "CN%s%sp%s-%d-%s",
-		family, core_model, pass, clock_mhz, suffix);
+	sprintf(buffer, "CN%s%sp%s-%d-%s", family, core_model, pass, clock_mhz, suffix);
 	return buffer;
 }
diff --git a/arch/mips/include/asm/octeon/cvmx-mio-defs.h b/arch/mips/include/asm/octeon/cvmx-mio-defs.h
index 52b14a3..b177412 100644
--- a/arch/mips/include/asm/octeon/cvmx-mio-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-mio-defs.h
@@ -43,6 +43,22 @@
 #define CVMX_MIO_BOOT_REG_CFGX(offset) (CVMX_ADD_IO_SEG(0x0001180000000000ull) + ((offset) & 7) * 8)
 #define CVMX_MIO_BOOT_REG_TIMX(offset) (CVMX_ADD_IO_SEG(0x0001180000000040ull) + ((offset) & 7) * 8)
 #define CVMX_MIO_BOOT_THR (CVMX_ADD_IO_SEG(0x00011800000000B0ull))
+#define CVMX_MIO_EMM_BUF_DAT (CVMX_ADD_IO_SEG(0x00011800000020E8ull))
+#define CVMX_MIO_EMM_BUF_IDX (CVMX_ADD_IO_SEG(0x00011800000020E0ull))
+#define CVMX_MIO_EMM_CFG (CVMX_ADD_IO_SEG(0x0001180000002000ull))
+#define CVMX_MIO_EMM_CMD (CVMX_ADD_IO_SEG(0x0001180000002058ull))
+#define CVMX_MIO_EMM_DMA (CVMX_ADD_IO_SEG(0x0001180000002050ull))
+#define CVMX_MIO_EMM_INT (CVMX_ADD_IO_SEG(0x0001180000002078ull))
+#define CVMX_MIO_EMM_INT_EN (CVMX_ADD_IO_SEG(0x0001180000002080ull))
+#define CVMX_MIO_EMM_MODEX(offset) (CVMX_ADD_IO_SEG(0x0001180000002008ull) + ((offset) & 3) * 8)
+#define CVMX_MIO_EMM_RCA (CVMX_ADD_IO_SEG(0x00011800000020A0ull))
+#define CVMX_MIO_EMM_RSP_HI (CVMX_ADD_IO_SEG(0x0001180000002070ull))
+#define CVMX_MIO_EMM_RSP_LO (CVMX_ADD_IO_SEG(0x0001180000002068ull))
+#define CVMX_MIO_EMM_RSP_STS (CVMX_ADD_IO_SEG(0x0001180000002060ull))
+#define CVMX_MIO_EMM_SAMPLE (CVMX_ADD_IO_SEG(0x0001180000002090ull))
+#define CVMX_MIO_EMM_STS_MASK (CVMX_ADD_IO_SEG(0x0001180000002098ull))
+#define CVMX_MIO_EMM_SWITCH (CVMX_ADD_IO_SEG(0x0001180000002048ull))
+#define CVMX_MIO_EMM_WDOG (CVMX_ADD_IO_SEG(0x0001180000002088ull))
 #define CVMX_MIO_FUS_BNK_DATX(offset) (CVMX_ADD_IO_SEG(0x0001180000001520ull) + ((offset) & 3) * 8)
 #define CVMX_MIO_FUS_DAT0 (CVMX_ADD_IO_SEG(0x0001180000001400ull))
 #define CVMX_MIO_FUS_DAT1 (CVMX_ADD_IO_SEG(0x0001180000001408ull))
@@ -60,6 +76,7 @@
 #define CVMX_MIO_FUS_REPAIR_RES2 (CVMX_ADD_IO_SEG(0x0001180000001568ull))
 #define CVMX_MIO_FUS_SPR_REPAIR_RES (CVMX_ADD_IO_SEG(0x0001180000001548ull))
 #define CVMX_MIO_FUS_SPR_REPAIR_SUM (CVMX_ADD_IO_SEG(0x0001180000001540ull))
+#define CVMX_MIO_FUS_TGG (CVMX_ADD_IO_SEG(0x0001180000001428ull))
 #define CVMX_MIO_FUS_UNLOCK (CVMX_ADD_IO_SEG(0x0001180000001578ull))
 #define CVMX_MIO_FUS_WADR (CVMX_ADD_IO_SEG(0x0001180000001508ull))
 #define CVMX_MIO_GPIO_COMP (CVMX_ADD_IO_SEG(0x00011800000000C8ull))
@@ -68,14 +85,25 @@
 #define CVMX_MIO_NDF_DMA_INT_EN (CVMX_ADD_IO_SEG(0x0001180000000178ull))
 #define CVMX_MIO_PLL_CTL (CVMX_ADD_IO_SEG(0x0001180000001448ull))
 #define CVMX_MIO_PLL_SETTING (CVMX_ADD_IO_SEG(0x0001180000001440ull))
+#define CVMX_MIO_PTP_CKOUT_HI_INCR (CVMX_ADD_IO_SEG(0x0001070000000F40ull))
+#define CVMX_MIO_PTP_CKOUT_LO_INCR (CVMX_ADD_IO_SEG(0x0001070000000F48ull))
+#define CVMX_MIO_PTP_CKOUT_THRESH_HI (CVMX_ADD_IO_SEG(0x0001070000000F38ull))
+#define CVMX_MIO_PTP_CKOUT_THRESH_LO (CVMX_ADD_IO_SEG(0x0001070000000F30ull))
 #define CVMX_MIO_PTP_CLOCK_CFG (CVMX_ADD_IO_SEG(0x0001070000000F00ull))
 #define CVMX_MIO_PTP_CLOCK_COMP (CVMX_ADD_IO_SEG(0x0001070000000F18ull))
 #define CVMX_MIO_PTP_CLOCK_HI (CVMX_ADD_IO_SEG(0x0001070000000F10ull))
 #define CVMX_MIO_PTP_CLOCK_LO (CVMX_ADD_IO_SEG(0x0001070000000F08ull))
 #define CVMX_MIO_PTP_EVT_CNT (CVMX_ADD_IO_SEG(0x0001070000000F28ull))
+#define CVMX_MIO_PTP_PPS_HI_INCR (CVMX_ADD_IO_SEG(0x0001070000000F60ull))
+#define CVMX_MIO_PTP_PPS_LO_INCR (CVMX_ADD_IO_SEG(0x0001070000000F68ull))
+#define CVMX_MIO_PTP_PPS_THRESH_HI (CVMX_ADD_IO_SEG(0x0001070000000F58ull))
+#define CVMX_MIO_PTP_PPS_THRESH_LO (CVMX_ADD_IO_SEG(0x0001070000000F50ull))
 #define CVMX_MIO_PTP_TIMESTAMP (CVMX_ADD_IO_SEG(0x0001070000000F20ull))
+#define CVMX_MIO_QLMX_CFG(offset) (CVMX_ADD_IO_SEG(0x0001180000001590ull) + ((offset) & 7) * 8)
 #define CVMX_MIO_RST_BOOT (CVMX_ADD_IO_SEG(0x0001180000001600ull))
 #define CVMX_MIO_RST_CFG (CVMX_ADD_IO_SEG(0x0001180000001610ull))
+#define CVMX_MIO_RST_CKILL (CVMX_ADD_IO_SEG(0x0001180000001638ull))
+#define CVMX_MIO_RST_CNTLX(offset) (CVMX_ADD_IO_SEG(0x0001180000001648ull) + ((offset) & 3) * 8)
 #define CVMX_MIO_RST_CTLX(offset) (CVMX_ADD_IO_SEG(0x0001180000001618ull) + ((offset) & 1) * 8)
 #define CVMX_MIO_RST_DELAY (CVMX_ADD_IO_SEG(0x0001180000001608ull))
 #define CVMX_MIO_RST_INT (CVMX_ADD_IO_SEG(0x0001180000001628ull))
@@ -183,11 +211,21 @@ union cvmx_mio_boot_bist_stat {
 	struct cvmx_mio_boot_bist_stat_cn52xxp1 cn56xxp1;
 	struct cvmx_mio_boot_bist_stat_cn38xx cn58xx;
 	struct cvmx_mio_boot_bist_stat_cn38xx cn58xxp1;
+	struct cvmx_mio_boot_bist_stat_cn61xx {
+		uint64_t reserved_12_63:52;
+		uint64_t stat:12;
+	} cn61xx;
 	struct cvmx_mio_boot_bist_stat_cn63xx {
 		uint64_t reserved_9_63:55;
 		uint64_t stat:9;
 	} cn63xx;
 	struct cvmx_mio_boot_bist_stat_cn63xx cn63xxp1;
+	struct cvmx_mio_boot_bist_stat_cn66xx {
+		uint64_t reserved_10_63:54;
+		uint64_t stat:10;
+	} cn66xx;
+	struct cvmx_mio_boot_bist_stat_cn66xx cn68xx;
+	struct cvmx_mio_boot_bist_stat_cn66xx cn68xxp1;
 };
 
 union cvmx_mio_boot_comp {
@@ -204,12 +242,16 @@ union cvmx_mio_boot_comp {
 	struct cvmx_mio_boot_comp_cn50xx cn52xxp1;
 	struct cvmx_mio_boot_comp_cn50xx cn56xx;
 	struct cvmx_mio_boot_comp_cn50xx cn56xxp1;
-	struct cvmx_mio_boot_comp_cn63xx {
+	struct cvmx_mio_boot_comp_cn61xx {
 		uint64_t reserved_12_63:52;
 		uint64_t pctl:6;
 		uint64_t nctl:6;
-	} cn63xx;
-	struct cvmx_mio_boot_comp_cn63xx cn63xxp1;
+	} cn61xx;
+	struct cvmx_mio_boot_comp_cn61xx cn63xx;
+	struct cvmx_mio_boot_comp_cn61xx cn63xxp1;
+	struct cvmx_mio_boot_comp_cn61xx cn66xx;
+	struct cvmx_mio_boot_comp_cn61xx cn68xx;
+	struct cvmx_mio_boot_comp_cn61xx cn68xxp1;
 };
 
 union cvmx_mio_boot_dma_cfgx {
@@ -230,8 +272,12 @@ union cvmx_mio_boot_dma_cfgx {
 	struct cvmx_mio_boot_dma_cfgx_s cn52xxp1;
 	struct cvmx_mio_boot_dma_cfgx_s cn56xx;
 	struct cvmx_mio_boot_dma_cfgx_s cn56xxp1;
+	struct cvmx_mio_boot_dma_cfgx_s cn61xx;
 	struct cvmx_mio_boot_dma_cfgx_s cn63xx;
 	struct cvmx_mio_boot_dma_cfgx_s cn63xxp1;
+	struct cvmx_mio_boot_dma_cfgx_s cn66xx;
+	struct cvmx_mio_boot_dma_cfgx_s cn68xx;
+	struct cvmx_mio_boot_dma_cfgx_s cn68xxp1;
 };
 
 union cvmx_mio_boot_dma_intx {
@@ -245,8 +291,12 @@ union cvmx_mio_boot_dma_intx {
 	struct cvmx_mio_boot_dma_intx_s cn52xxp1;
 	struct cvmx_mio_boot_dma_intx_s cn56xx;
 	struct cvmx_mio_boot_dma_intx_s cn56xxp1;
+	struct cvmx_mio_boot_dma_intx_s cn61xx;
 	struct cvmx_mio_boot_dma_intx_s cn63xx;
 	struct cvmx_mio_boot_dma_intx_s cn63xxp1;
+	struct cvmx_mio_boot_dma_intx_s cn66xx;
+	struct cvmx_mio_boot_dma_intx_s cn68xx;
+	struct cvmx_mio_boot_dma_intx_s cn68xxp1;
 };
 
 union cvmx_mio_boot_dma_int_enx {
@@ -260,8 +310,12 @@ union cvmx_mio_boot_dma_int_enx {
 	struct cvmx_mio_boot_dma_int_enx_s cn52xxp1;
 	struct cvmx_mio_boot_dma_int_enx_s cn56xx;
 	struct cvmx_mio_boot_dma_int_enx_s cn56xxp1;
+	struct cvmx_mio_boot_dma_int_enx_s cn61xx;
 	struct cvmx_mio_boot_dma_int_enx_s cn63xx;
 	struct cvmx_mio_boot_dma_int_enx_s cn63xxp1;
+	struct cvmx_mio_boot_dma_int_enx_s cn66xx;
+	struct cvmx_mio_boot_dma_int_enx_s cn68xx;
+	struct cvmx_mio_boot_dma_int_enx_s cn68xxp1;
 };
 
 union cvmx_mio_boot_dma_timx {
@@ -287,8 +341,12 @@ union cvmx_mio_boot_dma_timx {
 	struct cvmx_mio_boot_dma_timx_s cn52xxp1;
 	struct cvmx_mio_boot_dma_timx_s cn56xx;
 	struct cvmx_mio_boot_dma_timx_s cn56xxp1;
+	struct cvmx_mio_boot_dma_timx_s cn61xx;
 	struct cvmx_mio_boot_dma_timx_s cn63xx;
 	struct cvmx_mio_boot_dma_timx_s cn63xxp1;
+	struct cvmx_mio_boot_dma_timx_s cn66xx;
+	struct cvmx_mio_boot_dma_timx_s cn68xx;
+	struct cvmx_mio_boot_dma_timx_s cn68xxp1;
 };
 
 union cvmx_mio_boot_err {
@@ -309,8 +367,12 @@ union cvmx_mio_boot_err {
 	struct cvmx_mio_boot_err_s cn56xxp1;
 	struct cvmx_mio_boot_err_s cn58xx;
 	struct cvmx_mio_boot_err_s cn58xxp1;
+	struct cvmx_mio_boot_err_s cn61xx;
 	struct cvmx_mio_boot_err_s cn63xx;
 	struct cvmx_mio_boot_err_s cn63xxp1;
+	struct cvmx_mio_boot_err_s cn66xx;
+	struct cvmx_mio_boot_err_s cn68xx;
+	struct cvmx_mio_boot_err_s cn68xxp1;
 };
 
 union cvmx_mio_boot_int {
@@ -331,8 +393,12 @@ union cvmx_mio_boot_int {
 	struct cvmx_mio_boot_int_s cn56xxp1;
 	struct cvmx_mio_boot_int_s cn58xx;
 	struct cvmx_mio_boot_int_s cn58xxp1;
+	struct cvmx_mio_boot_int_s cn61xx;
 	struct cvmx_mio_boot_int_s cn63xx;
 	struct cvmx_mio_boot_int_s cn63xxp1;
+	struct cvmx_mio_boot_int_s cn66xx;
+	struct cvmx_mio_boot_int_s cn68xx;
+	struct cvmx_mio_boot_int_s cn68xxp1;
 };
 
 union cvmx_mio_boot_loc_adr {
@@ -353,8 +419,12 @@ union cvmx_mio_boot_loc_adr {
 	struct cvmx_mio_boot_loc_adr_s cn56xxp1;
 	struct cvmx_mio_boot_loc_adr_s cn58xx;
 	struct cvmx_mio_boot_loc_adr_s cn58xxp1;
+	struct cvmx_mio_boot_loc_adr_s cn61xx;
 	struct cvmx_mio_boot_loc_adr_s cn63xx;
 	struct cvmx_mio_boot_loc_adr_s cn63xxp1;
+	struct cvmx_mio_boot_loc_adr_s cn66xx;
+	struct cvmx_mio_boot_loc_adr_s cn68xx;
+	struct cvmx_mio_boot_loc_adr_s cn68xxp1;
 };
 
 union cvmx_mio_boot_loc_cfgx {
@@ -377,8 +447,12 @@ union cvmx_mio_boot_loc_cfgx {
 	struct cvmx_mio_boot_loc_cfgx_s cn56xxp1;
 	struct cvmx_mio_boot_loc_cfgx_s cn58xx;
 	struct cvmx_mio_boot_loc_cfgx_s cn58xxp1;
+	struct cvmx_mio_boot_loc_cfgx_s cn61xx;
 	struct cvmx_mio_boot_loc_cfgx_s cn63xx;
 	struct cvmx_mio_boot_loc_cfgx_s cn63xxp1;
+	struct cvmx_mio_boot_loc_cfgx_s cn66xx;
+	struct cvmx_mio_boot_loc_cfgx_s cn68xx;
+	struct cvmx_mio_boot_loc_cfgx_s cn68xxp1;
 };
 
 union cvmx_mio_boot_loc_dat {
@@ -397,14 +471,19 @@ union cvmx_mio_boot_loc_dat {
 	struct cvmx_mio_boot_loc_dat_s cn56xxp1;
 	struct cvmx_mio_boot_loc_dat_s cn58xx;
 	struct cvmx_mio_boot_loc_dat_s cn58xxp1;
+	struct cvmx_mio_boot_loc_dat_s cn61xx;
 	struct cvmx_mio_boot_loc_dat_s cn63xx;
 	struct cvmx_mio_boot_loc_dat_s cn63xxp1;
+	struct cvmx_mio_boot_loc_dat_s cn66xx;
+	struct cvmx_mio_boot_loc_dat_s cn68xx;
+	struct cvmx_mio_boot_loc_dat_s cn68xxp1;
 };
 
 union cvmx_mio_boot_pin_defs {
 	uint64_t u64;
 	struct cvmx_mio_boot_pin_defs_s {
-		uint64_t reserved_16_63:48;
+		uint64_t reserved_32_63:32;
+		uint64_t user1:16;
 		uint64_t ale:1;
 		uint64_t width:1;
 		uint64_t dmack_p2:1;
@@ -412,7 +491,7 @@ union cvmx_mio_boot_pin_defs {
 		uint64_t dmack_p0:1;
 		uint64_t term:2;
 		uint64_t nand:1;
-		uint64_t reserved_0_7:8;
+		uint64_t user0:8;
 	} s;
 	struct cvmx_mio_boot_pin_defs_cn52xx {
 		uint64_t reserved_16_63:48;
@@ -435,8 +514,23 @@ union cvmx_mio_boot_pin_defs {
 		uint64_t term:2;
 		uint64_t reserved_0_8:9;
 	} cn56xx;
+	struct cvmx_mio_boot_pin_defs_cn61xx {
+		uint64_t reserved_32_63:32;
+		uint64_t user1:16;
+		uint64_t ale:1;
+		uint64_t width:1;
+		uint64_t reserved_13_13:1;
+		uint64_t dmack_p1:1;
+		uint64_t dmack_p0:1;
+		uint64_t term:2;
+		uint64_t nand:1;
+		uint64_t user0:8;
+	} cn61xx;
 	struct cvmx_mio_boot_pin_defs_cn52xx cn63xx;
 	struct cvmx_mio_boot_pin_defs_cn52xx cn63xxp1;
+	struct cvmx_mio_boot_pin_defs_cn52xx cn66xx;
+	struct cvmx_mio_boot_pin_defs_cn52xx cn68xx;
+	struct cvmx_mio_boot_pin_defs_cn52xx cn68xxp1;
 };
 
 union cvmx_mio_boot_reg_cfgx {
@@ -498,8 +592,12 @@ union cvmx_mio_boot_reg_cfgx {
 	struct cvmx_mio_boot_reg_cfgx_s cn56xxp1;
 	struct cvmx_mio_boot_reg_cfgx_cn30xx cn58xx;
 	struct cvmx_mio_boot_reg_cfgx_cn30xx cn58xxp1;
+	struct cvmx_mio_boot_reg_cfgx_s cn61xx;
 	struct cvmx_mio_boot_reg_cfgx_s cn63xx;
 	struct cvmx_mio_boot_reg_cfgx_s cn63xxp1;
+	struct cvmx_mio_boot_reg_cfgx_s cn66xx;
+	struct cvmx_mio_boot_reg_cfgx_s cn68xx;
+	struct cvmx_mio_boot_reg_cfgx_s cn68xxp1;
 };
 
 union cvmx_mio_boot_reg_timx {
@@ -544,8 +642,12 @@ union cvmx_mio_boot_reg_timx {
 	struct cvmx_mio_boot_reg_timx_s cn56xxp1;
 	struct cvmx_mio_boot_reg_timx_s cn58xx;
 	struct cvmx_mio_boot_reg_timx_s cn58xxp1;
+	struct cvmx_mio_boot_reg_timx_s cn61xx;
 	struct cvmx_mio_boot_reg_timx_s cn63xx;
 	struct cvmx_mio_boot_reg_timx_s cn63xxp1;
+	struct cvmx_mio_boot_reg_timx_s cn66xx;
+	struct cvmx_mio_boot_reg_timx_s cn68xx;
+	struct cvmx_mio_boot_reg_timx_s cn68xxp1;
 };
 
 union cvmx_mio_boot_thr {
@@ -574,8 +676,231 @@ union cvmx_mio_boot_thr {
 	struct cvmx_mio_boot_thr_s cn56xxp1;
 	struct cvmx_mio_boot_thr_cn30xx cn58xx;
 	struct cvmx_mio_boot_thr_cn30xx cn58xxp1;
+	struct cvmx_mio_boot_thr_s cn61xx;
 	struct cvmx_mio_boot_thr_s cn63xx;
 	struct cvmx_mio_boot_thr_s cn63xxp1;
+	struct cvmx_mio_boot_thr_s cn66xx;
+	struct cvmx_mio_boot_thr_s cn68xx;
+	struct cvmx_mio_boot_thr_s cn68xxp1;
+};
+
+union cvmx_mio_emm_buf_dat {
+	uint64_t u64;
+	struct cvmx_mio_emm_buf_dat_s {
+		uint64_t dat:64;
+	} s;
+	struct cvmx_mio_emm_buf_dat_s cn61xx;
+};
+
+union cvmx_mio_emm_buf_idx {
+	uint64_t u64;
+	struct cvmx_mio_emm_buf_idx_s {
+		uint64_t reserved_17_63:47;
+		uint64_t inc:1;
+		uint64_t reserved_7_15:9;
+		uint64_t buf_num:1;
+		uint64_t offset:6;
+	} s;
+	struct cvmx_mio_emm_buf_idx_s cn61xx;
+};
+
+union cvmx_mio_emm_cfg {
+	uint64_t u64;
+	struct cvmx_mio_emm_cfg_s {
+		uint64_t reserved_17_63:47;
+		uint64_t boot_fail:1;
+		uint64_t reserved_4_15:12;
+		uint64_t bus_ena:4;
+	} s;
+	struct cvmx_mio_emm_cfg_s cn61xx;
+};
+
+union cvmx_mio_emm_cmd {
+	uint64_t u64;
+	struct cvmx_mio_emm_cmd_s {
+		uint64_t reserved_62_63:2;
+		uint64_t bus_id:2;
+		uint64_t cmd_val:1;
+		uint64_t reserved_56_58:3;
+		uint64_t dbuf:1;
+		uint64_t offset:6;
+		uint64_t reserved_43_48:6;
+		uint64_t ctype_xor:2;
+		uint64_t rtype_xor:3;
+		uint64_t cmd_idx:6;
+		uint64_t arg:32;
+	} s;
+	struct cvmx_mio_emm_cmd_s cn61xx;
+};
+
+union cvmx_mio_emm_dma {
+	uint64_t u64;
+	struct cvmx_mio_emm_dma_s {
+		uint64_t reserved_62_63:2;
+		uint64_t bus_id:2;
+		uint64_t dma_val:1;
+		uint64_t sector:1;
+		uint64_t dat_null:1;
+		uint64_t thres:6;
+		uint64_t rel_wr:1;
+		uint64_t rw:1;
+		uint64_t multi:1;
+		uint64_t block_cnt:16;
+		uint64_t card_addr:32;
+	} s;
+	struct cvmx_mio_emm_dma_s cn61xx;
+};
+
+union cvmx_mio_emm_int {
+	uint64_t u64;
+	struct cvmx_mio_emm_int_s {
+		uint64_t reserved_7_63:57;
+		uint64_t switch_err:1;
+		uint64_t switch_done:1;
+		uint64_t dma_err:1;
+		uint64_t cmd_err:1;
+		uint64_t dma_done:1;
+		uint64_t cmd_done:1;
+		uint64_t buf_done:1;
+	} s;
+	struct cvmx_mio_emm_int_s cn61xx;
+};
+
+union cvmx_mio_emm_int_en {
+	uint64_t u64;
+	struct cvmx_mio_emm_int_en_s {
+		uint64_t reserved_7_63:57;
+		uint64_t switch_err:1;
+		uint64_t switch_done:1;
+		uint64_t dma_err:1;
+		uint64_t cmd_err:1;
+		uint64_t dma_done:1;
+		uint64_t cmd_done:1;
+		uint64_t buf_done:1;
+	} s;
+	struct cvmx_mio_emm_int_en_s cn61xx;
+};
+
+union cvmx_mio_emm_modex {
+	uint64_t u64;
+	struct cvmx_mio_emm_modex_s {
+		uint64_t reserved_49_63:15;
+		uint64_t hs_timing:1;
+		uint64_t reserved_43_47:5;
+		uint64_t bus_width:3;
+		uint64_t reserved_36_39:4;
+		uint64_t power_class:4;
+		uint64_t clk_hi:16;
+		uint64_t clk_lo:16;
+	} s;
+	struct cvmx_mio_emm_modex_s cn61xx;
+};
+
+union cvmx_mio_emm_rca {
+	uint64_t u64;
+	struct cvmx_mio_emm_rca_s {
+		uint64_t reserved_16_63:48;
+		uint64_t card_rca:16;
+	} s;
+	struct cvmx_mio_emm_rca_s cn61xx;
+};
+
+union cvmx_mio_emm_rsp_hi {
+	uint64_t u64;
+	struct cvmx_mio_emm_rsp_hi_s {
+		uint64_t dat:64;
+	} s;
+	struct cvmx_mio_emm_rsp_hi_s cn61xx;
+};
+
+union cvmx_mio_emm_rsp_lo {
+	uint64_t u64;
+	struct cvmx_mio_emm_rsp_lo_s {
+		uint64_t dat:64;
+	} s;
+	struct cvmx_mio_emm_rsp_lo_s cn61xx;
+};
+
+union cvmx_mio_emm_rsp_sts {
+	uint64_t u64;
+	struct cvmx_mio_emm_rsp_sts_s {
+		uint64_t reserved_62_63:2;
+		uint64_t bus_id:2;
+		uint64_t cmd_val:1;
+		uint64_t switch_val:1;
+		uint64_t dma_val:1;
+		uint64_t dma_pend:1;
+		uint64_t reserved_29_55:27;
+		uint64_t dbuf_err:1;
+		uint64_t reserved_24_27:4;
+		uint64_t dbuf:1;
+		uint64_t blk_timeout:1;
+		uint64_t blk_crc_err:1;
+		uint64_t rsp_busybit:1;
+		uint64_t stp_timeout:1;
+		uint64_t stp_crc_err:1;
+		uint64_t stp_bad_sts:1;
+		uint64_t stp_val:1;
+		uint64_t rsp_timeout:1;
+		uint64_t rsp_crc_err:1;
+		uint64_t rsp_bad_sts:1;
+		uint64_t rsp_val:1;
+		uint64_t rsp_type:3;
+		uint64_t cmd_type:2;
+		uint64_t cmd_idx:6;
+		uint64_t cmd_done:1;
+	} s;
+	struct cvmx_mio_emm_rsp_sts_s cn61xx;
+};
+
+union cvmx_mio_emm_sample {
+	uint64_t u64;
+	struct cvmx_mio_emm_sample_s {
+		uint64_t reserved_26_63:38;
+		uint64_t cmd_cnt:10;
+		uint64_t reserved_10_15:6;
+		uint64_t dat_cnt:10;
+	} s;
+	struct cvmx_mio_emm_sample_s cn61xx;
+};
+
+union cvmx_mio_emm_sts_mask {
+	uint64_t u64;
+	struct cvmx_mio_emm_sts_mask_s {
+		uint64_t reserved_32_63:32;
+		uint64_t sts_msk:32;
+	} s;
+	struct cvmx_mio_emm_sts_mask_s cn61xx;
+};
+
+union cvmx_mio_emm_switch {
+	uint64_t u64;
+	struct cvmx_mio_emm_switch_s {
+		uint64_t reserved_62_63:2;
+		uint64_t bus_id:2;
+		uint64_t switch_exe:1;
+		uint64_t switch_err0:1;
+		uint64_t switch_err1:1;
+		uint64_t switch_err2:1;
+		uint64_t reserved_49_55:7;
+		uint64_t hs_timing:1;
+		uint64_t reserved_43_47:5;
+		uint64_t bus_width:3;
+		uint64_t reserved_36_39:4;
+		uint64_t power_class:4;
+		uint64_t clk_hi:16;
+		uint64_t clk_lo:16;
+	} s;
+	struct cvmx_mio_emm_switch_s cn61xx;
+};
+
+union cvmx_mio_emm_wdog {
+	uint64_t u64;
+	struct cvmx_mio_emm_wdog_s {
+		uint64_t reserved_26_63:38;
+		uint64_t clk_cnt:26;
+	} s;
+	struct cvmx_mio_emm_wdog_s cn61xx;
 };
 
 union cvmx_mio_fus_bnk_datx {
@@ -590,8 +915,12 @@ union cvmx_mio_fus_bnk_datx {
 	struct cvmx_mio_fus_bnk_datx_s cn56xxp1;
 	struct cvmx_mio_fus_bnk_datx_s cn58xx;
 	struct cvmx_mio_fus_bnk_datx_s cn58xxp1;
+	struct cvmx_mio_fus_bnk_datx_s cn61xx;
 	struct cvmx_mio_fus_bnk_datx_s cn63xx;
 	struct cvmx_mio_fus_bnk_datx_s cn63xxp1;
+	struct cvmx_mio_fus_bnk_datx_s cn66xx;
+	struct cvmx_mio_fus_bnk_datx_s cn68xx;
+	struct cvmx_mio_fus_bnk_datx_s cn68xxp1;
 };
 
 union cvmx_mio_fus_dat0 {
@@ -611,8 +940,12 @@ union cvmx_mio_fus_dat0 {
 	struct cvmx_mio_fus_dat0_s cn56xxp1;
 	struct cvmx_mio_fus_dat0_s cn58xx;
 	struct cvmx_mio_fus_dat0_s cn58xxp1;
+	struct cvmx_mio_fus_dat0_s cn61xx;
 	struct cvmx_mio_fus_dat0_s cn63xx;
 	struct cvmx_mio_fus_dat0_s cn63xxp1;
+	struct cvmx_mio_fus_dat0_s cn66xx;
+	struct cvmx_mio_fus_dat0_s cn68xx;
+	struct cvmx_mio_fus_dat0_s cn68xxp1;
 };
 
 union cvmx_mio_fus_dat1 {
@@ -632,14 +965,21 @@ union cvmx_mio_fus_dat1 {
 	struct cvmx_mio_fus_dat1_s cn56xxp1;
 	struct cvmx_mio_fus_dat1_s cn58xx;
 	struct cvmx_mio_fus_dat1_s cn58xxp1;
+	struct cvmx_mio_fus_dat1_s cn61xx;
 	struct cvmx_mio_fus_dat1_s cn63xx;
 	struct cvmx_mio_fus_dat1_s cn63xxp1;
+	struct cvmx_mio_fus_dat1_s cn66xx;
+	struct cvmx_mio_fus_dat1_s cn68xx;
+	struct cvmx_mio_fus_dat1_s cn68xxp1;
 };
 
 union cvmx_mio_fus_dat2 {
 	uint64_t u64;
 	struct cvmx_mio_fus_dat2_s {
-		uint64_t reserved_35_63:29;
+		uint64_t reserved_48_63:16;
+		uint64_t fus118:1;
+		uint64_t rom_info:10;
+		uint64_t power_limit:2;
 		uint64_t dorm_crypto:1;
 		uint64_t fus318:1;
 		uint64_t raid_en:1;
@@ -747,6 +1087,23 @@ union cvmx_mio_fus_dat2 {
 		uint64_t pp_dis:16;
 	} cn58xx;
 	struct cvmx_mio_fus_dat2_cn58xx cn58xxp1;
+	struct cvmx_mio_fus_dat2_cn61xx {
+		uint64_t reserved_48_63:16;
+		uint64_t fus118:1;
+		uint64_t rom_info:10;
+		uint64_t power_limit:2;
+		uint64_t dorm_crypto:1;
+		uint64_t fus318:1;
+		uint64_t raid_en:1;
+		uint64_t reserved_29_31:3;
+		uint64_t nodfa_cp2:1;
+		uint64_t nomul:1;
+		uint64_t nocrypto:1;
+		uint64_t reserved_24_25:2;
+		uint64_t chip_id:8;
+		uint64_t reserved_4_15:12;
+		uint64_t pp_dis:4;
+	} cn61xx;
 	struct cvmx_mio_fus_dat2_cn63xx {
 		uint64_t reserved_35_63:29;
 		uint64_t dorm_crypto:1;
@@ -762,6 +1119,38 @@ union cvmx_mio_fus_dat2 {
 		uint64_t pp_dis:6;
 	} cn63xx;
 	struct cvmx_mio_fus_dat2_cn63xx cn63xxp1;
+	struct cvmx_mio_fus_dat2_cn66xx {
+		uint64_t reserved_48_63:16;
+		uint64_t fus118:1;
+		uint64_t rom_info:10;
+		uint64_t power_limit:2;
+		uint64_t dorm_crypto:1;
+		uint64_t fus318:1;
+		uint64_t raid_en:1;
+		uint64_t reserved_29_31:3;
+		uint64_t nodfa_cp2:1;
+		uint64_t nomul:1;
+		uint64_t nocrypto:1;
+		uint64_t reserved_24_25:2;
+		uint64_t chip_id:8;
+		uint64_t reserved_10_15:6;
+		uint64_t pp_dis:10;
+	} cn66xx;
+	struct cvmx_mio_fus_dat2_cn68xx {
+		uint64_t reserved_37_63:27;
+		uint64_t power_limit:2;
+		uint64_t dorm_crypto:1;
+		uint64_t fus318:1;
+		uint64_t raid_en:1;
+		uint64_t reserved_29_31:3;
+		uint64_t nodfa_cp2:1;
+		uint64_t nomul:1;
+		uint64_t nocrypto:1;
+		uint64_t reserved_24_25:2;
+		uint64_t chip_id:8;
+		uint64_t reserved_0_15:16;
+	} cn68xx;
+	struct cvmx_mio_fus_dat2_cn68xx cn68xxp1;
 };
 
 union cvmx_mio_fus_dat3 {
@@ -834,7 +1223,7 @@ union cvmx_mio_fus_dat3 {
 	struct cvmx_mio_fus_dat3_cn38xx cn56xxp1;
 	struct cvmx_mio_fus_dat3_cn38xx cn58xx;
 	struct cvmx_mio_fus_dat3_cn38xx cn58xxp1;
-	struct cvmx_mio_fus_dat3_cn63xx {
+	struct cvmx_mio_fus_dat3_cn61xx {
 		uint64_t reserved_58_63:6;
 		uint64_t pll_ctl:10;
 		uint64_t dfa_info_dte:3;
@@ -853,8 +1242,12 @@ union cvmx_mio_fus_dat3 {
 		uint64_t nozip:1;
 		uint64_t nodfa_dte:1;
 		uint64_t reserved_0_23:24;
-	} cn63xx;
-	struct cvmx_mio_fus_dat3_cn63xx cn63xxp1;
+	} cn61xx;
+	struct cvmx_mio_fus_dat3_cn61xx cn63xx;
+	struct cvmx_mio_fus_dat3_cn61xx cn63xxp1;
+	struct cvmx_mio_fus_dat3_cn61xx cn66xx;
+	struct cvmx_mio_fus_dat3_cn61xx cn68xx;
+	struct cvmx_mio_fus_dat3_cn61xx cn68xxp1;
 };
 
 union cvmx_mio_fus_ema {
@@ -875,8 +1268,12 @@ union cvmx_mio_fus_ema {
 		uint64_t ema:2;
 	} cn58xx;
 	struct cvmx_mio_fus_ema_cn58xx cn58xxp1;
+	struct cvmx_mio_fus_ema_s cn61xx;
 	struct cvmx_mio_fus_ema_s cn63xx;
 	struct cvmx_mio_fus_ema_s cn63xxp1;
+	struct cvmx_mio_fus_ema_s cn66xx;
+	struct cvmx_mio_fus_ema_s cn68xx;
+	struct cvmx_mio_fus_ema_s cn68xxp1;
 };
 
 union cvmx_mio_fus_pdf {
@@ -890,14 +1287,21 @@ union cvmx_mio_fus_pdf {
 	struct cvmx_mio_fus_pdf_s cn56xx;
 	struct cvmx_mio_fus_pdf_s cn56xxp1;
 	struct cvmx_mio_fus_pdf_s cn58xx;
+	struct cvmx_mio_fus_pdf_s cn61xx;
 	struct cvmx_mio_fus_pdf_s cn63xx;
 	struct cvmx_mio_fus_pdf_s cn63xxp1;
+	struct cvmx_mio_fus_pdf_s cn66xx;
+	struct cvmx_mio_fus_pdf_s cn68xx;
+	struct cvmx_mio_fus_pdf_s cn68xxp1;
 };
 
 union cvmx_mio_fus_pll {
 	uint64_t u64;
 	struct cvmx_mio_fus_pll_s {
-		uint64_t reserved_8_63:56;
+		uint64_t reserved_48_63:16;
+		uint64_t rclk_align_r:8;
+		uint64_t rclk_align_l:8;
+		uint64_t reserved_8_31:24;
 		uint64_t c_cout_rst:1;
 		uint64_t c_cout_sel:2;
 		uint64_t pnr_cout_rst:1;
@@ -916,8 +1320,20 @@ union cvmx_mio_fus_pll {
 	struct cvmx_mio_fus_pll_cn50xx cn56xxp1;
 	struct cvmx_mio_fus_pll_cn50xx cn58xx;
 	struct cvmx_mio_fus_pll_cn50xx cn58xxp1;
-	struct cvmx_mio_fus_pll_s cn63xx;
-	struct cvmx_mio_fus_pll_s cn63xxp1;
+	struct cvmx_mio_fus_pll_cn61xx {
+		uint64_t reserved_8_63:56;
+		uint64_t c_cout_rst:1;
+		uint64_t c_cout_sel:2;
+		uint64_t pnr_cout_rst:1;
+		uint64_t pnr_cout_sel:2;
+		uint64_t rfslip:1;
+		uint64_t fbslip:1;
+	} cn61xx;
+	struct cvmx_mio_fus_pll_cn61xx cn63xx;
+	struct cvmx_mio_fus_pll_cn61xx cn63xxp1;
+	struct cvmx_mio_fus_pll_cn61xx cn66xx;
+	struct cvmx_mio_fus_pll_s cn68xx;
+	struct cvmx_mio_fus_pll_s cn68xxp1;
 };
 
 union cvmx_mio_fus_prog {
@@ -941,8 +1357,12 @@ union cvmx_mio_fus_prog {
 	struct cvmx_mio_fus_prog_cn30xx cn56xxp1;
 	struct cvmx_mio_fus_prog_cn30xx cn58xx;
 	struct cvmx_mio_fus_prog_cn30xx cn58xxp1;
+	struct cvmx_mio_fus_prog_s cn61xx;
 	struct cvmx_mio_fus_prog_s cn63xx;
 	struct cvmx_mio_fus_prog_s cn63xxp1;
+	struct cvmx_mio_fus_prog_s cn66xx;
+	struct cvmx_mio_fus_prog_s cn68xx;
+	struct cvmx_mio_fus_prog_s cn68xxp1;
 };
 
 union cvmx_mio_fus_prog_times {
@@ -969,7 +1389,7 @@ union cvmx_mio_fus_prog_times {
 	struct cvmx_mio_fus_prog_times_cn50xx cn56xxp1;
 	struct cvmx_mio_fus_prog_times_cn50xx cn58xx;
 	struct cvmx_mio_fus_prog_times_cn50xx cn58xxp1;
-	struct cvmx_mio_fus_prog_times_cn63xx {
+	struct cvmx_mio_fus_prog_times_cn61xx {
 		uint64_t reserved_35_63:29;
 		uint64_t vgate_pin:1;
 		uint64_t fsrc_pin:1;
@@ -978,8 +1398,12 @@ union cvmx_mio_fus_prog_times {
 		uint64_t sclk_lo:4;
 		uint64_t sclk_hi:15;
 		uint64_t setup:6;
-	} cn63xx;
-	struct cvmx_mio_fus_prog_times_cn63xx cn63xxp1;
+	} cn61xx;
+	struct cvmx_mio_fus_prog_times_cn61xx cn63xx;
+	struct cvmx_mio_fus_prog_times_cn61xx cn63xxp1;
+	struct cvmx_mio_fus_prog_times_cn61xx cn66xx;
+	struct cvmx_mio_fus_prog_times_cn61xx cn68xx;
+	struct cvmx_mio_fus_prog_times_cn61xx cn68xxp1;
 };
 
 union cvmx_mio_fus_rcmd {
@@ -1013,8 +1437,12 @@ union cvmx_mio_fus_rcmd {
 	struct cvmx_mio_fus_rcmd_s cn56xxp1;
 	struct cvmx_mio_fus_rcmd_cn30xx cn58xx;
 	struct cvmx_mio_fus_rcmd_cn30xx cn58xxp1;
+	struct cvmx_mio_fus_rcmd_s cn61xx;
 	struct cvmx_mio_fus_rcmd_s cn63xx;
 	struct cvmx_mio_fus_rcmd_s cn63xxp1;
+	struct cvmx_mio_fus_rcmd_s cn66xx;
+	struct cvmx_mio_fus_rcmd_s cn68xx;
+	struct cvmx_mio_fus_rcmd_s cn68xxp1;
 };
 
 union cvmx_mio_fus_read_times {
@@ -1027,8 +1455,12 @@ union cvmx_mio_fus_read_times {
 		uint64_t sdh:4;
 		uint64_t setup:10;
 	} s;
+	struct cvmx_mio_fus_read_times_s cn61xx;
 	struct cvmx_mio_fus_read_times_s cn63xx;
 	struct cvmx_mio_fus_read_times_s cn63xxp1;
+	struct cvmx_mio_fus_read_times_s cn66xx;
+	struct cvmx_mio_fus_read_times_s cn68xx;
+	struct cvmx_mio_fus_read_times_s cn68xxp1;
 };
 
 union cvmx_mio_fus_repair_res0 {
@@ -1040,8 +1472,12 @@ union cvmx_mio_fus_repair_res0 {
 		uint64_t repair1:18;
 		uint64_t repair0:18;
 	} s;
+	struct cvmx_mio_fus_repair_res0_s cn61xx;
 	struct cvmx_mio_fus_repair_res0_s cn63xx;
 	struct cvmx_mio_fus_repair_res0_s cn63xxp1;
+	struct cvmx_mio_fus_repair_res0_s cn66xx;
+	struct cvmx_mio_fus_repair_res0_s cn68xx;
+	struct cvmx_mio_fus_repair_res0_s cn68xxp1;
 };
 
 union cvmx_mio_fus_repair_res1 {
@@ -1052,8 +1488,12 @@ union cvmx_mio_fus_repair_res1 {
 		uint64_t repair4:18;
 		uint64_t repair3:18;
 	} s;
+	struct cvmx_mio_fus_repair_res1_s cn61xx;
 	struct cvmx_mio_fus_repair_res1_s cn63xx;
 	struct cvmx_mio_fus_repair_res1_s cn63xxp1;
+	struct cvmx_mio_fus_repair_res1_s cn66xx;
+	struct cvmx_mio_fus_repair_res1_s cn68xx;
+	struct cvmx_mio_fus_repair_res1_s cn68xxp1;
 };
 
 union cvmx_mio_fus_repair_res2 {
@@ -1062,8 +1502,12 @@ union cvmx_mio_fus_repair_res2 {
 		uint64_t reserved_18_63:46;
 		uint64_t repair6:18;
 	} s;
+	struct cvmx_mio_fus_repair_res2_s cn61xx;
 	struct cvmx_mio_fus_repair_res2_s cn63xx;
 	struct cvmx_mio_fus_repair_res2_s cn63xxp1;
+	struct cvmx_mio_fus_repair_res2_s cn66xx;
+	struct cvmx_mio_fus_repair_res2_s cn68xx;
+	struct cvmx_mio_fus_repair_res2_s cn68xxp1;
 };
 
 union cvmx_mio_fus_spr_repair_res {
@@ -1084,8 +1528,12 @@ union cvmx_mio_fus_spr_repair_res {
 	struct cvmx_mio_fus_spr_repair_res_s cn56xxp1;
 	struct cvmx_mio_fus_spr_repair_res_s cn58xx;
 	struct cvmx_mio_fus_spr_repair_res_s cn58xxp1;
+	struct cvmx_mio_fus_spr_repair_res_s cn61xx;
 	struct cvmx_mio_fus_spr_repair_res_s cn63xx;
 	struct cvmx_mio_fus_spr_repair_res_s cn63xxp1;
+	struct cvmx_mio_fus_spr_repair_res_s cn66xx;
+	struct cvmx_mio_fus_spr_repair_res_s cn68xx;
+	struct cvmx_mio_fus_spr_repair_res_s cn68xxp1;
 };
 
 union cvmx_mio_fus_spr_repair_sum {
@@ -1104,8 +1552,22 @@ union cvmx_mio_fus_spr_repair_sum {
 	struct cvmx_mio_fus_spr_repair_sum_s cn56xxp1;
 	struct cvmx_mio_fus_spr_repair_sum_s cn58xx;
 	struct cvmx_mio_fus_spr_repair_sum_s cn58xxp1;
+	struct cvmx_mio_fus_spr_repair_sum_s cn61xx;
 	struct cvmx_mio_fus_spr_repair_sum_s cn63xx;
 	struct cvmx_mio_fus_spr_repair_sum_s cn63xxp1;
+	struct cvmx_mio_fus_spr_repair_sum_s cn66xx;
+	struct cvmx_mio_fus_spr_repair_sum_s cn68xx;
+	struct cvmx_mio_fus_spr_repair_sum_s cn68xxp1;
+};
+
+union cvmx_mio_fus_tgg {
+	uint64_t u64;
+	struct cvmx_mio_fus_tgg_s {
+		uint64_t val:1;
+		uint64_t dat:63;
+	} s;
+	struct cvmx_mio_fus_tgg_s cn61xx;
+	struct cvmx_mio_fus_tgg_s cn66xx;
 };
 
 union cvmx_mio_fus_unlock {
@@ -1141,11 +1603,15 @@ union cvmx_mio_fus_wadr {
 	struct cvmx_mio_fus_wadr_cn52xx cn56xxp1;
 	struct cvmx_mio_fus_wadr_cn50xx cn58xx;
 	struct cvmx_mio_fus_wadr_cn50xx cn58xxp1;
-	struct cvmx_mio_fus_wadr_cn63xx {
+	struct cvmx_mio_fus_wadr_cn61xx {
 		uint64_t reserved_4_63:60;
 		uint64_t addr:4;
-	} cn63xx;
-	struct cvmx_mio_fus_wadr_cn63xx cn63xxp1;
+	} cn61xx;
+	struct cvmx_mio_fus_wadr_cn61xx cn63xx;
+	struct cvmx_mio_fus_wadr_cn61xx cn63xxp1;
+	struct cvmx_mio_fus_wadr_cn61xx cn66xx;
+	struct cvmx_mio_fus_wadr_cn61xx cn68xx;
+	struct cvmx_mio_fus_wadr_cn61xx cn68xxp1;
 };
 
 union cvmx_mio_gpio_comp {
@@ -1155,8 +1621,12 @@ union cvmx_mio_gpio_comp {
 		uint64_t pctl:6;
 		uint64_t nctl:6;
 	} s;
+	struct cvmx_mio_gpio_comp_s cn61xx;
 	struct cvmx_mio_gpio_comp_s cn63xx;
 	struct cvmx_mio_gpio_comp_s cn63xxp1;
+	struct cvmx_mio_gpio_comp_s cn66xx;
+	struct cvmx_mio_gpio_comp_s cn68xx;
+	struct cvmx_mio_gpio_comp_s cn68xxp1;
 };
 
 union cvmx_mio_ndf_dma_cfg {
@@ -1174,8 +1644,12 @@ union cvmx_mio_ndf_dma_cfg {
 		uint64_t adr:36;
 	} s;
 	struct cvmx_mio_ndf_dma_cfg_s cn52xx;
+	struct cvmx_mio_ndf_dma_cfg_s cn61xx;
 	struct cvmx_mio_ndf_dma_cfg_s cn63xx;
 	struct cvmx_mio_ndf_dma_cfg_s cn63xxp1;
+	struct cvmx_mio_ndf_dma_cfg_s cn66xx;
+	struct cvmx_mio_ndf_dma_cfg_s cn68xx;
+	struct cvmx_mio_ndf_dma_cfg_s cn68xxp1;
 };
 
 union cvmx_mio_ndf_dma_int {
@@ -1185,8 +1659,12 @@ union cvmx_mio_ndf_dma_int {
 		uint64_t done:1;
 	} s;
 	struct cvmx_mio_ndf_dma_int_s cn52xx;
+	struct cvmx_mio_ndf_dma_int_s cn61xx;
 	struct cvmx_mio_ndf_dma_int_s cn63xx;
 	struct cvmx_mio_ndf_dma_int_s cn63xxp1;
+	struct cvmx_mio_ndf_dma_int_s cn66xx;
+	struct cvmx_mio_ndf_dma_int_s cn68xx;
+	struct cvmx_mio_ndf_dma_int_s cn68xxp1;
 };
 
 union cvmx_mio_ndf_dma_int_en {
@@ -1196,8 +1674,12 @@ union cvmx_mio_ndf_dma_int_en {
 		uint64_t done:1;
 	} s;
 	struct cvmx_mio_ndf_dma_int_en_s cn52xx;
+	struct cvmx_mio_ndf_dma_int_en_s cn61xx;
 	struct cvmx_mio_ndf_dma_int_en_s cn63xx;
 	struct cvmx_mio_ndf_dma_int_en_s cn63xxp1;
+	struct cvmx_mio_ndf_dma_int_en_s cn66xx;
+	struct cvmx_mio_ndf_dma_int_en_s cn68xx;
+	struct cvmx_mio_ndf_dma_int_en_s cn68xxp1;
 };
 
 union cvmx_mio_pll_ctl {
@@ -1220,10 +1702,63 @@ union cvmx_mio_pll_setting {
 	struct cvmx_mio_pll_setting_s cn31xx;
 };
 
+union cvmx_mio_ptp_ckout_hi_incr {
+	uint64_t u64;
+	struct cvmx_mio_ptp_ckout_hi_incr_s {
+		uint64_t nanosec:32;
+		uint64_t frnanosec:32;
+	} s;
+	struct cvmx_mio_ptp_ckout_hi_incr_s cn61xx;
+	struct cvmx_mio_ptp_ckout_hi_incr_s cn66xx;
+	struct cvmx_mio_ptp_ckout_hi_incr_s cn68xx;
+};
+
+union cvmx_mio_ptp_ckout_lo_incr {
+	uint64_t u64;
+	struct cvmx_mio_ptp_ckout_lo_incr_s {
+		uint64_t nanosec:32;
+		uint64_t frnanosec:32;
+	} s;
+	struct cvmx_mio_ptp_ckout_lo_incr_s cn61xx;
+	struct cvmx_mio_ptp_ckout_lo_incr_s cn66xx;
+	struct cvmx_mio_ptp_ckout_lo_incr_s cn68xx;
+};
+
+union cvmx_mio_ptp_ckout_thresh_hi {
+	uint64_t u64;
+	struct cvmx_mio_ptp_ckout_thresh_hi_s {
+		uint64_t nanosec:64;
+	} s;
+	struct cvmx_mio_ptp_ckout_thresh_hi_s cn61xx;
+	struct cvmx_mio_ptp_ckout_thresh_hi_s cn66xx;
+	struct cvmx_mio_ptp_ckout_thresh_hi_s cn68xx;
+};
+
+union cvmx_mio_ptp_ckout_thresh_lo {
+	uint64_t u64;
+	struct cvmx_mio_ptp_ckout_thresh_lo_s {
+		uint64_t reserved_32_63:32;
+		uint64_t frnanosec:32;
+	} s;
+	struct cvmx_mio_ptp_ckout_thresh_lo_s cn61xx;
+	struct cvmx_mio_ptp_ckout_thresh_lo_s cn66xx;
+	struct cvmx_mio_ptp_ckout_thresh_lo_s cn68xx;
+};
+
 union cvmx_mio_ptp_clock_cfg {
 	uint64_t u64;
 	struct cvmx_mio_ptp_clock_cfg_s {
-		uint64_t reserved_24_63:40;
+		uint64_t reserved_42_63:22;
+		uint64_t pps:1;
+		uint64_t ckout:1;
+		uint64_t ext_clk_edge:2;
+		uint64_t ckout_out4:1;
+		uint64_t pps_out:5;
+		uint64_t pps_inv:1;
+		uint64_t pps_en:1;
+		uint64_t ckout_out:4;
+		uint64_t ckout_inv:1;
+		uint64_t ckout_en:1;
 		uint64_t evcnt_in:6;
 		uint64_t evcnt_edge:1;
 		uint64_t evcnt_en:1;
@@ -1234,8 +1769,42 @@ union cvmx_mio_ptp_clock_cfg {
 		uint64_t ext_clk_en:1;
 		uint64_t ptp_en:1;
 	} s;
-	struct cvmx_mio_ptp_clock_cfg_s cn63xx;
-	struct cvmx_mio_ptp_clock_cfg_s cn63xxp1;
+	struct cvmx_mio_ptp_clock_cfg_s cn61xx;
+	struct cvmx_mio_ptp_clock_cfg_cn63xx {
+		uint64_t reserved_24_63:40;
+		uint64_t evcnt_in:6;
+		uint64_t evcnt_edge:1;
+		uint64_t evcnt_en:1;
+		uint64_t tstmp_in:6;
+		uint64_t tstmp_edge:1;
+		uint64_t tstmp_en:1;
+		uint64_t ext_clk_in:6;
+		uint64_t ext_clk_en:1;
+		uint64_t ptp_en:1;
+	} cn63xx;
+	struct cvmx_mio_ptp_clock_cfg_cn63xx cn63xxp1;
+	struct cvmx_mio_ptp_clock_cfg_cn66xx {
+		uint64_t reserved_40_63:24;
+		uint64_t ext_clk_edge:2;
+		uint64_t ckout_out4:1;
+		uint64_t pps_out:5;
+		uint64_t pps_inv:1;
+		uint64_t pps_en:1;
+		uint64_t ckout_out:4;
+		uint64_t ckout_inv:1;
+		uint64_t ckout_en:1;
+		uint64_t evcnt_in:6;
+		uint64_t evcnt_edge:1;
+		uint64_t evcnt_en:1;
+		uint64_t tstmp_in:6;
+		uint64_t tstmp_edge:1;
+		uint64_t tstmp_en:1;
+		uint64_t ext_clk_in:6;
+		uint64_t ext_clk_en:1;
+		uint64_t ptp_en:1;
+	} cn66xx;
+	struct cvmx_mio_ptp_clock_cfg_s cn68xx;
+	struct cvmx_mio_ptp_clock_cfg_cn63xx cn68xxp1;
 };
 
 union cvmx_mio_ptp_clock_comp {
@@ -1244,8 +1813,12 @@ union cvmx_mio_ptp_clock_comp {
 		uint64_t nanosec:32;
 		uint64_t frnanosec:32;
 	} s;
+	struct cvmx_mio_ptp_clock_comp_s cn61xx;
 	struct cvmx_mio_ptp_clock_comp_s cn63xx;
 	struct cvmx_mio_ptp_clock_comp_s cn63xxp1;
+	struct cvmx_mio_ptp_clock_comp_s cn66xx;
+	struct cvmx_mio_ptp_clock_comp_s cn68xx;
+	struct cvmx_mio_ptp_clock_comp_s cn68xxp1;
 };
 
 union cvmx_mio_ptp_clock_hi {
@@ -1253,8 +1826,12 @@ union cvmx_mio_ptp_clock_hi {
 	struct cvmx_mio_ptp_clock_hi_s {
 		uint64_t nanosec:64;
 	} s;
+	struct cvmx_mio_ptp_clock_hi_s cn61xx;
 	struct cvmx_mio_ptp_clock_hi_s cn63xx;
 	struct cvmx_mio_ptp_clock_hi_s cn63xxp1;
+	struct cvmx_mio_ptp_clock_hi_s cn66xx;
+	struct cvmx_mio_ptp_clock_hi_s cn68xx;
+	struct cvmx_mio_ptp_clock_hi_s cn68xxp1;
 };
 
 union cvmx_mio_ptp_clock_lo {
@@ -1263,8 +1840,12 @@ union cvmx_mio_ptp_clock_lo {
 		uint64_t reserved_32_63:32;
 		uint64_t frnanosec:32;
 	} s;
+	struct cvmx_mio_ptp_clock_lo_s cn61xx;
 	struct cvmx_mio_ptp_clock_lo_s cn63xx;
 	struct cvmx_mio_ptp_clock_lo_s cn63xxp1;
+	struct cvmx_mio_ptp_clock_lo_s cn66xx;
+	struct cvmx_mio_ptp_clock_lo_s cn68xx;
+	struct cvmx_mio_ptp_clock_lo_s cn68xxp1;
 };
 
 union cvmx_mio_ptp_evt_cnt {
@@ -1272,8 +1853,55 @@ union cvmx_mio_ptp_evt_cnt {
 	struct cvmx_mio_ptp_evt_cnt_s {
 		uint64_t cntr:64;
 	} s;
+	struct cvmx_mio_ptp_evt_cnt_s cn61xx;
 	struct cvmx_mio_ptp_evt_cnt_s cn63xx;
 	struct cvmx_mio_ptp_evt_cnt_s cn63xxp1;
+	struct cvmx_mio_ptp_evt_cnt_s cn66xx;
+	struct cvmx_mio_ptp_evt_cnt_s cn68xx;
+	struct cvmx_mio_ptp_evt_cnt_s cn68xxp1;
+};
+
+union cvmx_mio_ptp_pps_hi_incr {
+	uint64_t u64;
+	struct cvmx_mio_ptp_pps_hi_incr_s {
+		uint64_t nanosec:32;
+		uint64_t frnanosec:32;
+	} s;
+	struct cvmx_mio_ptp_pps_hi_incr_s cn61xx;
+	struct cvmx_mio_ptp_pps_hi_incr_s cn66xx;
+	struct cvmx_mio_ptp_pps_hi_incr_s cn68xx;
+};
+
+union cvmx_mio_ptp_pps_lo_incr {
+	uint64_t u64;
+	struct cvmx_mio_ptp_pps_lo_incr_s {
+		uint64_t nanosec:32;
+		uint64_t frnanosec:32;
+	} s;
+	struct cvmx_mio_ptp_pps_lo_incr_s cn61xx;
+	struct cvmx_mio_ptp_pps_lo_incr_s cn66xx;
+	struct cvmx_mio_ptp_pps_lo_incr_s cn68xx;
+};
+
+union cvmx_mio_ptp_pps_thresh_hi {
+	uint64_t u64;
+	struct cvmx_mio_ptp_pps_thresh_hi_s {
+		uint64_t nanosec:64;
+	} s;
+	struct cvmx_mio_ptp_pps_thresh_hi_s cn61xx;
+	struct cvmx_mio_ptp_pps_thresh_hi_s cn66xx;
+	struct cvmx_mio_ptp_pps_thresh_hi_s cn68xx;
+};
+
+union cvmx_mio_ptp_pps_thresh_lo {
+	uint64_t u64;
+	struct cvmx_mio_ptp_pps_thresh_lo_s {
+		uint64_t reserved_32_63:32;
+		uint64_t frnanosec:32;
+	} s;
+	struct cvmx_mio_ptp_pps_thresh_lo_s cn61xx;
+	struct cvmx_mio_ptp_pps_thresh_lo_s cn66xx;
+	struct cvmx_mio_ptp_pps_thresh_lo_s cn68xx;
 };
 
 union cvmx_mio_ptp_timestamp {
@@ -1281,14 +1909,52 @@ union cvmx_mio_ptp_timestamp {
 	struct cvmx_mio_ptp_timestamp_s {
 		uint64_t nanosec:64;
 	} s;
+	struct cvmx_mio_ptp_timestamp_s cn61xx;
 	struct cvmx_mio_ptp_timestamp_s cn63xx;
 	struct cvmx_mio_ptp_timestamp_s cn63xxp1;
+	struct cvmx_mio_ptp_timestamp_s cn66xx;
+	struct cvmx_mio_ptp_timestamp_s cn68xx;
+	struct cvmx_mio_ptp_timestamp_s cn68xxp1;
+};
+
+union cvmx_mio_qlmx_cfg {
+	uint64_t u64;
+	struct cvmx_mio_qlmx_cfg_s {
+		uint64_t reserved_12_63:52;
+		uint64_t qlm_spd:4;
+		uint64_t reserved_4_7:4;
+		uint64_t qlm_cfg:4;
+	} s;
+	struct cvmx_mio_qlmx_cfg_cn61xx {
+		uint64_t reserved_12_63:52;
+		uint64_t qlm_spd:4;
+		uint64_t reserved_2_7:6;
+		uint64_t qlm_cfg:2;
+	} cn61xx;
+	struct cvmx_mio_qlmx_cfg_s cn66xx;
+	struct cvmx_mio_qlmx_cfg_cn68xx {
+		uint64_t reserved_12_63:52;
+		uint64_t qlm_spd:4;
+		uint64_t reserved_3_7:5;
+		uint64_t qlm_cfg:3;
+	} cn68xx;
+	struct cvmx_mio_qlmx_cfg_cn68xx cn68xxp1;
 };
 
 union cvmx_mio_rst_boot {
 	uint64_t u64;
 	struct cvmx_mio_rst_boot_s {
-		uint64_t reserved_36_63:28;
+		uint64_t chipkill:1;
+		uint64_t jtcsrdis:1;
+		uint64_t ejtagdis:1;
+		uint64_t romen:1;
+		uint64_t ckill_ppdis:1;
+		uint64_t jt_tstmode:1;
+		uint64_t reserved_50_57:8;
+		uint64_t lboot_ext:2;
+		uint64_t reserved_44_47:4;
+		uint64_t qlm4_spd:4;
+		uint64_t qlm3_spd:4;
 		uint64_t c_mul:6;
 		uint64_t pnr_mul:6;
 		uint64_t qlm2_spd:4;
@@ -1298,32 +1964,168 @@ union cvmx_mio_rst_boot {
 		uint64_t rboot:1;
 		uint64_t rboot_pin:1;
 	} s;
-	struct cvmx_mio_rst_boot_s cn63xx;
-	struct cvmx_mio_rst_boot_s cn63xxp1;
+	struct cvmx_mio_rst_boot_cn61xx {
+		uint64_t chipkill:1;
+		uint64_t jtcsrdis:1;
+		uint64_t ejtagdis:1;
+		uint64_t romen:1;
+		uint64_t ckill_ppdis:1;
+		uint64_t jt_tstmode:1;
+		uint64_t reserved_50_57:8;
+		uint64_t lboot_ext:2;
+		uint64_t reserved_36_47:12;
+		uint64_t c_mul:6;
+		uint64_t pnr_mul:6;
+		uint64_t qlm2_spd:4;
+		uint64_t qlm1_spd:4;
+		uint64_t qlm0_spd:4;
+		uint64_t lboot:10;
+		uint64_t rboot:1;
+		uint64_t rboot_pin:1;
+	} cn61xx;
+	struct cvmx_mio_rst_boot_cn63xx {
+		uint64_t reserved_36_63:28;
+		uint64_t c_mul:6;
+		uint64_t pnr_mul:6;
+		uint64_t qlm2_spd:4;
+		uint64_t qlm1_spd:4;
+		uint64_t qlm0_spd:4;
+		uint64_t lboot:10;
+		uint64_t rboot:1;
+		uint64_t rboot_pin:1;
+	} cn63xx;
+	struct cvmx_mio_rst_boot_cn63xx cn63xxp1;
+	struct cvmx_mio_rst_boot_cn66xx {
+		uint64_t chipkill:1;
+		uint64_t jtcsrdis:1;
+		uint64_t ejtagdis:1;
+		uint64_t romen:1;
+		uint64_t ckill_ppdis:1;
+		uint64_t reserved_50_58:9;
+		uint64_t lboot_ext:2;
+		uint64_t reserved_36_47:12;
+		uint64_t c_mul:6;
+		uint64_t pnr_mul:6;
+		uint64_t qlm2_spd:4;
+		uint64_t qlm1_spd:4;
+		uint64_t qlm0_spd:4;
+		uint64_t lboot:10;
+		uint64_t rboot:1;
+		uint64_t rboot_pin:1;
+	} cn66xx;
+	struct cvmx_mio_rst_boot_cn68xx {
+		uint64_t reserved_59_63:5;
+		uint64_t jt_tstmode:1;
+		uint64_t reserved_44_57:14;
+		uint64_t qlm4_spd:4;
+		uint64_t qlm3_spd:4;
+		uint64_t c_mul:6;
+		uint64_t pnr_mul:6;
+		uint64_t qlm2_spd:4;
+		uint64_t qlm1_spd:4;
+		uint64_t qlm0_spd:4;
+		uint64_t lboot:10;
+		uint64_t rboot:1;
+		uint64_t rboot_pin:1;
+	} cn68xx;
+	struct cvmx_mio_rst_boot_cn68xxp1 {
+		uint64_t reserved_44_63:20;
+		uint64_t qlm4_spd:4;
+		uint64_t qlm3_spd:4;
+		uint64_t c_mul:6;
+		uint64_t pnr_mul:6;
+		uint64_t qlm2_spd:4;
+		uint64_t qlm1_spd:4;
+		uint64_t qlm0_spd:4;
+		uint64_t lboot:10;
+		uint64_t rboot:1;
+		uint64_t rboot_pin:1;
+	} cn68xxp1;
 };
 
 union cvmx_mio_rst_cfg {
 	uint64_t u64;
 	struct cvmx_mio_rst_cfg_s {
+		uint64_t reserved_3_63:61;
+		uint64_t cntl_clr_bist:1;
+		uint64_t warm_clr_bist:1;
+		uint64_t soft_clr_bist:1;
+	} s;
+	struct cvmx_mio_rst_cfg_cn61xx {
 		uint64_t bist_delay:58;
 		uint64_t reserved_3_5:3;
 		uint64_t cntl_clr_bist:1;
 		uint64_t warm_clr_bist:1;
 		uint64_t soft_clr_bist:1;
-	} s;
-	struct cvmx_mio_rst_cfg_s cn63xx;
+	} cn61xx;
+	struct cvmx_mio_rst_cfg_cn61xx cn63xx;
 	struct cvmx_mio_rst_cfg_cn63xxp1 {
 		uint64_t bist_delay:58;
 		uint64_t reserved_2_5:4;
 		uint64_t warm_clr_bist:1;
 		uint64_t soft_clr_bist:1;
 	} cn63xxp1;
+	struct cvmx_mio_rst_cfg_cn61xx cn66xx;
+	struct cvmx_mio_rst_cfg_cn68xx {
+		uint64_t bist_delay:56;
+		uint64_t reserved_3_7:5;
+		uint64_t cntl_clr_bist:1;
+		uint64_t warm_clr_bist:1;
+		uint64_t soft_clr_bist:1;
+	} cn68xx;
+	struct cvmx_mio_rst_cfg_cn68xx cn68xxp1;
+};
+
+union cvmx_mio_rst_ckill {
+	uint64_t u64;
+	struct cvmx_mio_rst_ckill_s {
+		uint64_t reserved_47_63:17;
+		uint64_t timer:47;
+	} s;
+	struct cvmx_mio_rst_ckill_s cn61xx;
+	struct cvmx_mio_rst_ckill_s cn66xx;
+};
+
+union cvmx_mio_rst_cntlx {
+	uint64_t u64;
+	struct cvmx_mio_rst_cntlx_s {
+		uint64_t reserved_13_63:51;
+		uint64_t in_rev_ln:1;
+		uint64_t rev_lanes:1;
+		uint64_t gen1_only:1;
+		uint64_t prst_link:1;
+		uint64_t rst_done:1;
+		uint64_t rst_link:1;
+		uint64_t host_mode:1;
+		uint64_t prtmode:2;
+		uint64_t rst_drv:1;
+		uint64_t rst_rcv:1;
+		uint64_t rst_chip:1;
+		uint64_t rst_val:1;
+	} s;
+	struct cvmx_mio_rst_cntlx_s cn61xx;
+	struct cvmx_mio_rst_cntlx_cn66xx {
+		uint64_t reserved_10_63:54;
+		uint64_t prst_link:1;
+		uint64_t rst_done:1;
+		uint64_t rst_link:1;
+		uint64_t host_mode:1;
+		uint64_t prtmode:2;
+		uint64_t rst_drv:1;
+		uint64_t rst_rcv:1;
+		uint64_t rst_chip:1;
+		uint64_t rst_val:1;
+	} cn66xx;
+	struct cvmx_mio_rst_cntlx_cn66xx cn68xx;
 };
 
 union cvmx_mio_rst_ctlx {
 	uint64_t u64;
 	struct cvmx_mio_rst_ctlx_s {
-		uint64_t reserved_10_63:54;
+		uint64_t reserved_13_63:51;
+		uint64_t in_rev_ln:1;
+		uint64_t rev_lanes:1;
+		uint64_t gen1_only:1;
 		uint64_t prst_link:1;
 		uint64_t rst_done:1;
 		uint64_t rst_link:1;
@@ -1334,7 +2136,19 @@ union cvmx_mio_rst_ctlx {
 		uint64_t rst_chip:1;
 		uint64_t rst_val:1;
 	} s;
-	struct cvmx_mio_rst_ctlx_s cn63xx;
+	struct cvmx_mio_rst_ctlx_s cn61xx;
+	struct cvmx_mio_rst_ctlx_cn63xx {
+		uint64_t reserved_10_63:54;
+		uint64_t prst_link:1;
+		uint64_t rst_done:1;
+		uint64_t rst_link:1;
+		uint64_t host_mode:1;
+		uint64_t prtmode:2;
+		uint64_t rst_drv:1;
+		uint64_t rst_rcv:1;
+		uint64_t rst_chip:1;
+		uint64_t rst_val:1;
+	} cn63xx;
 	struct cvmx_mio_rst_ctlx_cn63xxp1 {
 		uint64_t reserved_9_63:55;
 		uint64_t rst_done:1;
@@ -1346,17 +2160,24 @@ union cvmx_mio_rst_ctlx {
 		uint64_t rst_chip:1;
 		uint64_t rst_val:1;
 	} cn63xxp1;
+	struct cvmx_mio_rst_ctlx_cn63xx cn66xx;
+	struct cvmx_mio_rst_ctlx_cn63xx cn68xx;
+	struct cvmx_mio_rst_ctlx_cn63xx cn68xxp1;
 };
 
 union cvmx_mio_rst_delay {
 	uint64_t u64;
 	struct cvmx_mio_rst_delay_s {
 		uint64_t reserved_32_63:32;
-		uint64_t soft_rst_dly:16;
 		uint64_t warm_rst_dly:16;
+		uint64_t soft_rst_dly:16;
 	} s;
+	struct cvmx_mio_rst_delay_s cn61xx;
 	struct cvmx_mio_rst_delay_s cn63xx;
 	struct cvmx_mio_rst_delay_s cn63xxp1;
+	struct cvmx_mio_rst_delay_s cn66xx;
+	struct cvmx_mio_rst_delay_s cn68xx;
+	struct cvmx_mio_rst_delay_s cn68xxp1;
 };
 
 union cvmx_mio_rst_int {
@@ -1365,12 +2186,25 @@ union cvmx_mio_rst_int {
 		uint64_t reserved_10_63:54;
 		uint64_t perst1:1;
 		uint64_t perst0:1;
-		uint64_t reserved_2_7:6;
+		uint64_t reserved_4_7:4;
+		uint64_t rst_link3:1;
+		uint64_t rst_link2:1;
 		uint64_t rst_link1:1;
 		uint64_t rst_link0:1;
 	} s;
-	struct cvmx_mio_rst_int_s cn63xx;
-	struct cvmx_mio_rst_int_s cn63xxp1;
+	struct cvmx_mio_rst_int_cn61xx {
+		uint64_t reserved_10_63:54;
+		uint64_t perst1:1;
+		uint64_t perst0:1;
+		uint64_t reserved_2_7:6;
+		uint64_t rst_link1:1;
+		uint64_t rst_link0:1;
+	} cn61xx;
+	struct cvmx_mio_rst_int_cn61xx cn63xx;
+	struct cvmx_mio_rst_int_cn61xx cn63xxp1;
+	struct cvmx_mio_rst_int_s cn66xx;
+	struct cvmx_mio_rst_int_cn61xx cn68xx;
+	struct cvmx_mio_rst_int_cn61xx cn68xxp1;
 };
 
 union cvmx_mio_rst_int_en {
@@ -1379,12 +2213,25 @@ union cvmx_mio_rst_int_en {
 		uint64_t reserved_10_63:54;
 		uint64_t perst1:1;
 		uint64_t perst0:1;
-		uint64_t reserved_2_7:6;
+		uint64_t reserved_4_7:4;
+		uint64_t rst_link3:1;
+		uint64_t rst_link2:1;
 		uint64_t rst_link1:1;
 		uint64_t rst_link0:1;
 	} s;
-	struct cvmx_mio_rst_int_en_s cn63xx;
-	struct cvmx_mio_rst_int_en_s cn63xxp1;
+	struct cvmx_mio_rst_int_en_cn61xx {
+		uint64_t reserved_10_63:54;
+		uint64_t perst1:1;
+		uint64_t perst0:1;
+		uint64_t reserved_2_7:6;
+		uint64_t rst_link1:1;
+		uint64_t rst_link0:1;
+	} cn61xx;
+	struct cvmx_mio_rst_int_en_cn61xx cn63xx;
+	struct cvmx_mio_rst_int_en_cn61xx cn63xxp1;
+	struct cvmx_mio_rst_int_en_s cn66xx;
+	struct cvmx_mio_rst_int_en_cn61xx cn68xx;
+	struct cvmx_mio_rst_int_en_cn61xx cn68xxp1;
 };
 
 union cvmx_mio_twsx_int {
@@ -1424,8 +2271,12 @@ union cvmx_mio_twsx_int {
 	struct cvmx_mio_twsx_int_s cn56xxp1;
 	struct cvmx_mio_twsx_int_s cn58xx;
 	struct cvmx_mio_twsx_int_s cn58xxp1;
+	struct cvmx_mio_twsx_int_s cn61xx;
 	struct cvmx_mio_twsx_int_s cn63xx;
 	struct cvmx_mio_twsx_int_s cn63xxp1;
+	struct cvmx_mio_twsx_int_s cn66xx;
+	struct cvmx_mio_twsx_int_s cn68xx;
+	struct cvmx_mio_twsx_int_s cn68xxp1;
 };
 
 union cvmx_mio_twsx_sw_twsi {
@@ -1455,8 +2306,12 @@ union cvmx_mio_twsx_sw_twsi {
 	struct cvmx_mio_twsx_sw_twsi_s cn56xxp1;
 	struct cvmx_mio_twsx_sw_twsi_s cn58xx;
 	struct cvmx_mio_twsx_sw_twsi_s cn58xxp1;
+	struct cvmx_mio_twsx_sw_twsi_s cn61xx;
 	struct cvmx_mio_twsx_sw_twsi_s cn63xx;
 	struct cvmx_mio_twsx_sw_twsi_s cn63xxp1;
+	struct cvmx_mio_twsx_sw_twsi_s cn66xx;
+	struct cvmx_mio_twsx_sw_twsi_s cn68xx;
+	struct cvmx_mio_twsx_sw_twsi_s cn68xxp1;
 };
 
 union cvmx_mio_twsx_sw_twsi_ext {
@@ -1477,8 +2332,12 @@ union cvmx_mio_twsx_sw_twsi_ext {
 	struct cvmx_mio_twsx_sw_twsi_ext_s cn56xxp1;
 	struct cvmx_mio_twsx_sw_twsi_ext_s cn58xx;
 	struct cvmx_mio_twsx_sw_twsi_ext_s cn58xxp1;
+	struct cvmx_mio_twsx_sw_twsi_ext_s cn61xx;
 	struct cvmx_mio_twsx_sw_twsi_ext_s cn63xx;
 	struct cvmx_mio_twsx_sw_twsi_ext_s cn63xxp1;
+	struct cvmx_mio_twsx_sw_twsi_ext_s cn66xx;
+	struct cvmx_mio_twsx_sw_twsi_ext_s cn68xx;
+	struct cvmx_mio_twsx_sw_twsi_ext_s cn68xxp1;
 };
 
 union cvmx_mio_twsx_twsi_sw {
@@ -1499,8 +2358,12 @@ union cvmx_mio_twsx_twsi_sw {
 	struct cvmx_mio_twsx_twsi_sw_s cn56xxp1;
 	struct cvmx_mio_twsx_twsi_sw_s cn58xx;
 	struct cvmx_mio_twsx_twsi_sw_s cn58xxp1;
+	struct cvmx_mio_twsx_twsi_sw_s cn61xx;
 	struct cvmx_mio_twsx_twsi_sw_s cn63xx;
 	struct cvmx_mio_twsx_twsi_sw_s cn63xxp1;
+	struct cvmx_mio_twsx_twsi_sw_s cn66xx;
+	struct cvmx_mio_twsx_twsi_sw_s cn68xx;
+	struct cvmx_mio_twsx_twsi_sw_s cn68xxp1;
 };
 
 union cvmx_mio_uartx_dlh {
@@ -1520,8 +2383,12 @@ union cvmx_mio_uartx_dlh {
 	struct cvmx_mio_uartx_dlh_s cn56xxp1;
 	struct cvmx_mio_uartx_dlh_s cn58xx;
 	struct cvmx_mio_uartx_dlh_s cn58xxp1;
+	struct cvmx_mio_uartx_dlh_s cn61xx;
 	struct cvmx_mio_uartx_dlh_s cn63xx;
 	struct cvmx_mio_uartx_dlh_s cn63xxp1;
+	struct cvmx_mio_uartx_dlh_s cn66xx;
+	struct cvmx_mio_uartx_dlh_s cn68xx;
+	struct cvmx_mio_uartx_dlh_s cn68xxp1;
 };
 
 union cvmx_mio_uartx_dll {
@@ -1541,8 +2408,12 @@ union cvmx_mio_uartx_dll {
 	struct cvmx_mio_uartx_dll_s cn56xxp1;
 	struct cvmx_mio_uartx_dll_s cn58xx;
 	struct cvmx_mio_uartx_dll_s cn58xxp1;
+	struct cvmx_mio_uartx_dll_s cn61xx;
 	struct cvmx_mio_uartx_dll_s cn63xx;
 	struct cvmx_mio_uartx_dll_s cn63xxp1;
+	struct cvmx_mio_uartx_dll_s cn66xx;
+	struct cvmx_mio_uartx_dll_s cn68xx;
+	struct cvmx_mio_uartx_dll_s cn68xxp1;
 };
 
 union cvmx_mio_uartx_far {
@@ -1562,8 +2433,12 @@ union cvmx_mio_uartx_far {
 	struct cvmx_mio_uartx_far_s cn56xxp1;
 	struct cvmx_mio_uartx_far_s cn58xx;
 	struct cvmx_mio_uartx_far_s cn58xxp1;
+	struct cvmx_mio_uartx_far_s cn61xx;
 	struct cvmx_mio_uartx_far_s cn63xx;
 	struct cvmx_mio_uartx_far_s cn63xxp1;
+	struct cvmx_mio_uartx_far_s cn66xx;
+	struct cvmx_mio_uartx_far_s cn68xx;
+	struct cvmx_mio_uartx_far_s cn68xxp1;
 };
 
 union cvmx_mio_uartx_fcr {
@@ -1588,8 +2463,12 @@ union cvmx_mio_uartx_fcr {
 	struct cvmx_mio_uartx_fcr_s cn56xxp1;
 	struct cvmx_mio_uartx_fcr_s cn58xx;
 	struct cvmx_mio_uartx_fcr_s cn58xxp1;
+	struct cvmx_mio_uartx_fcr_s cn61xx;
 	struct cvmx_mio_uartx_fcr_s cn63xx;
 	struct cvmx_mio_uartx_fcr_s cn63xxp1;
+	struct cvmx_mio_uartx_fcr_s cn66xx;
+	struct cvmx_mio_uartx_fcr_s cn68xx;
+	struct cvmx_mio_uartx_fcr_s cn68xxp1;
 };
 
 union cvmx_mio_uartx_htx {
@@ -1609,8 +2488,12 @@ union cvmx_mio_uartx_htx {
 	struct cvmx_mio_uartx_htx_s cn56xxp1;
 	struct cvmx_mio_uartx_htx_s cn58xx;
 	struct cvmx_mio_uartx_htx_s cn58xxp1;
+	struct cvmx_mio_uartx_htx_s cn61xx;
 	struct cvmx_mio_uartx_htx_s cn63xx;
 	struct cvmx_mio_uartx_htx_s cn63xxp1;
+	struct cvmx_mio_uartx_htx_s cn66xx;
+	struct cvmx_mio_uartx_htx_s cn68xx;
+	struct cvmx_mio_uartx_htx_s cn68xxp1;
 };
 
 union cvmx_mio_uartx_ier {
@@ -1635,8 +2518,12 @@ union cvmx_mio_uartx_ier {
 	struct cvmx_mio_uartx_ier_s cn56xxp1;
 	struct cvmx_mio_uartx_ier_s cn58xx;
 	struct cvmx_mio_uartx_ier_s cn58xxp1;
+	struct cvmx_mio_uartx_ier_s cn61xx;
 	struct cvmx_mio_uartx_ier_s cn63xx;
 	struct cvmx_mio_uartx_ier_s cn63xxp1;
+	struct cvmx_mio_uartx_ier_s cn66xx;
+	struct cvmx_mio_uartx_ier_s cn68xx;
+	struct cvmx_mio_uartx_ier_s cn68xxp1;
 };
 
 union cvmx_mio_uartx_iir {
@@ -1658,8 +2545,12 @@ union cvmx_mio_uartx_iir {
 	struct cvmx_mio_uartx_iir_s cn56xxp1;
 	struct cvmx_mio_uartx_iir_s cn58xx;
 	struct cvmx_mio_uartx_iir_s cn58xxp1;
+	struct cvmx_mio_uartx_iir_s cn61xx;
 	struct cvmx_mio_uartx_iir_s cn63xx;
 	struct cvmx_mio_uartx_iir_s cn63xxp1;
+	struct cvmx_mio_uartx_iir_s cn66xx;
+	struct cvmx_mio_uartx_iir_s cn68xx;
+	struct cvmx_mio_uartx_iir_s cn68xxp1;
 };
 
 union cvmx_mio_uartx_lcr {
@@ -1685,8 +2576,12 @@ union cvmx_mio_uartx_lcr {
 	struct cvmx_mio_uartx_lcr_s cn56xxp1;
 	struct cvmx_mio_uartx_lcr_s cn58xx;
 	struct cvmx_mio_uartx_lcr_s cn58xxp1;
+	struct cvmx_mio_uartx_lcr_s cn61xx;
 	struct cvmx_mio_uartx_lcr_s cn63xx;
 	struct cvmx_mio_uartx_lcr_s cn63xxp1;
+	struct cvmx_mio_uartx_lcr_s cn66xx;
+	struct cvmx_mio_uartx_lcr_s cn68xx;
+	struct cvmx_mio_uartx_lcr_s cn68xxp1;
 };
 
 union cvmx_mio_uartx_lsr {
@@ -1713,8 +2608,12 @@ union cvmx_mio_uartx_lsr {
 	struct cvmx_mio_uartx_lsr_s cn56xxp1;
 	struct cvmx_mio_uartx_lsr_s cn58xx;
 	struct cvmx_mio_uartx_lsr_s cn58xxp1;
+	struct cvmx_mio_uartx_lsr_s cn61xx;
 	struct cvmx_mio_uartx_lsr_s cn63xx;
 	struct cvmx_mio_uartx_lsr_s cn63xxp1;
+	struct cvmx_mio_uartx_lsr_s cn66xx;
+	struct cvmx_mio_uartx_lsr_s cn68xx;
+	struct cvmx_mio_uartx_lsr_s cn68xxp1;
 };
 
 union cvmx_mio_uartx_mcr {
@@ -1739,8 +2638,12 @@ union cvmx_mio_uartx_mcr {
 	struct cvmx_mio_uartx_mcr_s cn56xxp1;
 	struct cvmx_mio_uartx_mcr_s cn58xx;
 	struct cvmx_mio_uartx_mcr_s cn58xxp1;
+	struct cvmx_mio_uartx_mcr_s cn61xx;
 	struct cvmx_mio_uartx_mcr_s cn63xx;
 	struct cvmx_mio_uartx_mcr_s cn63xxp1;
+	struct cvmx_mio_uartx_mcr_s cn66xx;
+	struct cvmx_mio_uartx_mcr_s cn68xx;
+	struct cvmx_mio_uartx_mcr_s cn68xxp1;
 };
 
 union cvmx_mio_uartx_msr {
@@ -1767,8 +2670,12 @@ union cvmx_mio_uartx_msr {
 	struct cvmx_mio_uartx_msr_s cn56xxp1;
 	struct cvmx_mio_uartx_msr_s cn58xx;
 	struct cvmx_mio_uartx_msr_s cn58xxp1;
+	struct cvmx_mio_uartx_msr_s cn61xx;
 	struct cvmx_mio_uartx_msr_s cn63xx;
 	struct cvmx_mio_uartx_msr_s cn63xxp1;
+	struct cvmx_mio_uartx_msr_s cn66xx;
+	struct cvmx_mio_uartx_msr_s cn68xx;
+	struct cvmx_mio_uartx_msr_s cn68xxp1;
 };
 
 union cvmx_mio_uartx_rbr {
@@ -1788,8 +2695,12 @@ union cvmx_mio_uartx_rbr {
 	struct cvmx_mio_uartx_rbr_s cn56xxp1;
 	struct cvmx_mio_uartx_rbr_s cn58xx;
 	struct cvmx_mio_uartx_rbr_s cn58xxp1;
+	struct cvmx_mio_uartx_rbr_s cn61xx;
 	struct cvmx_mio_uartx_rbr_s cn63xx;
 	struct cvmx_mio_uartx_rbr_s cn63xxp1;
+	struct cvmx_mio_uartx_rbr_s cn66xx;
+	struct cvmx_mio_uartx_rbr_s cn68xx;
+	struct cvmx_mio_uartx_rbr_s cn68xxp1;
 };
 
 union cvmx_mio_uartx_rfl {
@@ -1809,8 +2720,12 @@ union cvmx_mio_uartx_rfl {
 	struct cvmx_mio_uartx_rfl_s cn56xxp1;
 	struct cvmx_mio_uartx_rfl_s cn58xx;
 	struct cvmx_mio_uartx_rfl_s cn58xxp1;
+	struct cvmx_mio_uartx_rfl_s cn61xx;
 	struct cvmx_mio_uartx_rfl_s cn63xx;
 	struct cvmx_mio_uartx_rfl_s cn63xxp1;
+	struct cvmx_mio_uartx_rfl_s cn66xx;
+	struct cvmx_mio_uartx_rfl_s cn68xx;
+	struct cvmx_mio_uartx_rfl_s cn68xxp1;
 };
 
 union cvmx_mio_uartx_rfw {
@@ -1832,8 +2747,12 @@ union cvmx_mio_uartx_rfw {
 	struct cvmx_mio_uartx_rfw_s cn56xxp1;
 	struct cvmx_mio_uartx_rfw_s cn58xx;
 	struct cvmx_mio_uartx_rfw_s cn58xxp1;
+	struct cvmx_mio_uartx_rfw_s cn61xx;
 	struct cvmx_mio_uartx_rfw_s cn63xx;
 	struct cvmx_mio_uartx_rfw_s cn63xxp1;
+	struct cvmx_mio_uartx_rfw_s cn66xx;
+	struct cvmx_mio_uartx_rfw_s cn68xx;
+	struct cvmx_mio_uartx_rfw_s cn68xxp1;
 };
 
 union cvmx_mio_uartx_sbcr {
@@ -1853,8 +2772,12 @@ union cvmx_mio_uartx_sbcr {
 	struct cvmx_mio_uartx_sbcr_s cn56xxp1;
 	struct cvmx_mio_uartx_sbcr_s cn58xx;
 	struct cvmx_mio_uartx_sbcr_s cn58xxp1;
+	struct cvmx_mio_uartx_sbcr_s cn61xx;
 	struct cvmx_mio_uartx_sbcr_s cn63xx;
 	struct cvmx_mio_uartx_sbcr_s cn63xxp1;
+	struct cvmx_mio_uartx_sbcr_s cn66xx;
+	struct cvmx_mio_uartx_sbcr_s cn68xx;
+	struct cvmx_mio_uartx_sbcr_s cn68xxp1;
 };
 
 union cvmx_mio_uartx_scr {
@@ -1874,8 +2797,12 @@ union cvmx_mio_uartx_scr {
 	struct cvmx_mio_uartx_scr_s cn56xxp1;
 	struct cvmx_mio_uartx_scr_s cn58xx;
 	struct cvmx_mio_uartx_scr_s cn58xxp1;
+	struct cvmx_mio_uartx_scr_s cn61xx;
 	struct cvmx_mio_uartx_scr_s cn63xx;
 	struct cvmx_mio_uartx_scr_s cn63xxp1;
+	struct cvmx_mio_uartx_scr_s cn66xx;
+	struct cvmx_mio_uartx_scr_s cn68xx;
+	struct cvmx_mio_uartx_scr_s cn68xxp1;
 };
 
 union cvmx_mio_uartx_sfe {
@@ -1895,8 +2822,12 @@ union cvmx_mio_uartx_sfe {
 	struct cvmx_mio_uartx_sfe_s cn56xxp1;
 	struct cvmx_mio_uartx_sfe_s cn58xx;
 	struct cvmx_mio_uartx_sfe_s cn58xxp1;
+	struct cvmx_mio_uartx_sfe_s cn61xx;
 	struct cvmx_mio_uartx_sfe_s cn63xx;
 	struct cvmx_mio_uartx_sfe_s cn63xxp1;
+	struct cvmx_mio_uartx_sfe_s cn66xx;
+	struct cvmx_mio_uartx_sfe_s cn68xx;
+	struct cvmx_mio_uartx_sfe_s cn68xxp1;
 };
 
 union cvmx_mio_uartx_srr {
@@ -1918,8 +2849,12 @@ union cvmx_mio_uartx_srr {
 	struct cvmx_mio_uartx_srr_s cn56xxp1;
 	struct cvmx_mio_uartx_srr_s cn58xx;
 	struct cvmx_mio_uartx_srr_s cn58xxp1;
+	struct cvmx_mio_uartx_srr_s cn61xx;
 	struct cvmx_mio_uartx_srr_s cn63xx;
 	struct cvmx_mio_uartx_srr_s cn63xxp1;
+	struct cvmx_mio_uartx_srr_s cn66xx;
+	struct cvmx_mio_uartx_srr_s cn68xx;
+	struct cvmx_mio_uartx_srr_s cn68xxp1;
 };
 
 union cvmx_mio_uartx_srt {
@@ -1939,8 +2874,12 @@ union cvmx_mio_uartx_srt {
 	struct cvmx_mio_uartx_srt_s cn56xxp1;
 	struct cvmx_mio_uartx_srt_s cn58xx;
 	struct cvmx_mio_uartx_srt_s cn58xxp1;
+	struct cvmx_mio_uartx_srt_s cn61xx;
 	struct cvmx_mio_uartx_srt_s cn63xx;
 	struct cvmx_mio_uartx_srt_s cn63xxp1;
+	struct cvmx_mio_uartx_srt_s cn66xx;
+	struct cvmx_mio_uartx_srt_s cn68xx;
+	struct cvmx_mio_uartx_srt_s cn68xxp1;
 };
 
 union cvmx_mio_uartx_srts {
@@ -1960,8 +2899,12 @@ union cvmx_mio_uartx_srts {
 	struct cvmx_mio_uartx_srts_s cn56xxp1;
 	struct cvmx_mio_uartx_srts_s cn58xx;
 	struct cvmx_mio_uartx_srts_s cn58xxp1;
+	struct cvmx_mio_uartx_srts_s cn61xx;
 	struct cvmx_mio_uartx_srts_s cn63xx;
 	struct cvmx_mio_uartx_srts_s cn63xxp1;
+	struct cvmx_mio_uartx_srts_s cn66xx;
+	struct cvmx_mio_uartx_srts_s cn68xx;
+	struct cvmx_mio_uartx_srts_s cn68xxp1;
 };
 
 union cvmx_mio_uartx_stt {
@@ -1981,8 +2924,12 @@ union cvmx_mio_uartx_stt {
 	struct cvmx_mio_uartx_stt_s cn56xxp1;
 	struct cvmx_mio_uartx_stt_s cn58xx;
 	struct cvmx_mio_uartx_stt_s cn58xxp1;
+	struct cvmx_mio_uartx_stt_s cn61xx;
 	struct cvmx_mio_uartx_stt_s cn63xx;
 	struct cvmx_mio_uartx_stt_s cn63xxp1;
+	struct cvmx_mio_uartx_stt_s cn66xx;
+	struct cvmx_mio_uartx_stt_s cn68xx;
+	struct cvmx_mio_uartx_stt_s cn68xxp1;
 };
 
 union cvmx_mio_uartx_tfl {
@@ -2002,8 +2949,12 @@ union cvmx_mio_uartx_tfl {
 	struct cvmx_mio_uartx_tfl_s cn56xxp1;
 	struct cvmx_mio_uartx_tfl_s cn58xx;
 	struct cvmx_mio_uartx_tfl_s cn58xxp1;
+	struct cvmx_mio_uartx_tfl_s cn61xx;
 	struct cvmx_mio_uartx_tfl_s cn63xx;
 	struct cvmx_mio_uartx_tfl_s cn63xxp1;
+	struct cvmx_mio_uartx_tfl_s cn66xx;
+	struct cvmx_mio_uartx_tfl_s cn68xx;
+	struct cvmx_mio_uartx_tfl_s cn68xxp1;
 };
 
 union cvmx_mio_uartx_tfr {
@@ -2023,8 +2974,12 @@ union cvmx_mio_uartx_tfr {
 	struct cvmx_mio_uartx_tfr_s cn56xxp1;
 	struct cvmx_mio_uartx_tfr_s cn58xx;
 	struct cvmx_mio_uartx_tfr_s cn58xxp1;
+	struct cvmx_mio_uartx_tfr_s cn61xx;
 	struct cvmx_mio_uartx_tfr_s cn63xx;
 	struct cvmx_mio_uartx_tfr_s cn63xxp1;
+	struct cvmx_mio_uartx_tfr_s cn66xx;
+	struct cvmx_mio_uartx_tfr_s cn68xx;
+	struct cvmx_mio_uartx_tfr_s cn68xxp1;
 };
 
 union cvmx_mio_uartx_thr {
@@ -2044,8 +2999,12 @@ union cvmx_mio_uartx_thr {
 	struct cvmx_mio_uartx_thr_s cn56xxp1;
 	struct cvmx_mio_uartx_thr_s cn58xx;
 	struct cvmx_mio_uartx_thr_s cn58xxp1;
+	struct cvmx_mio_uartx_thr_s cn61xx;
 	struct cvmx_mio_uartx_thr_s cn63xx;
 	struct cvmx_mio_uartx_thr_s cn63xxp1;
+	struct cvmx_mio_uartx_thr_s cn66xx;
+	struct cvmx_mio_uartx_thr_s cn68xx;
+	struct cvmx_mio_uartx_thr_s cn68xxp1;
 };
 
 union cvmx_mio_uartx_usr {
@@ -2069,8 +3028,12 @@ union cvmx_mio_uartx_usr {
 	struct cvmx_mio_uartx_usr_s cn56xxp1;
 	struct cvmx_mio_uartx_usr_s cn58xx;
 	struct cvmx_mio_uartx_usr_s cn58xxp1;
+	struct cvmx_mio_uartx_usr_s cn61xx;
 	struct cvmx_mio_uartx_usr_s cn63xx;
 	struct cvmx_mio_uartx_usr_s cn63xxp1;
+	struct cvmx_mio_uartx_usr_s cn66xx;
+	struct cvmx_mio_uartx_usr_s cn68xx;
+	struct cvmx_mio_uartx_usr_s cn68xxp1;
 };
 
 union cvmx_mio_uart2_dlh {
diff --git a/arch/mips/include/asm/octeon/octeon-model.h b/arch/mips/include/asm/octeon/octeon-model.h
index 700f88e..4e338a4 100644
--- a/arch/mips/include/asm/octeon/octeon-model.h
+++ b/arch/mips/include/asm/octeon/octeon-model.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2010 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -24,14 +24,6 @@
  * This file may also be available under a different license from Cavium.
  * Contact Cavium Networks for more information
  ***********************license end**************************************/
-
-/*
- *
- * File defining different Octeon model IDs and macros to
- * compare them.
- *
- */
-
 #ifndef __OCTEON_MODEL_H__
 #define __OCTEON_MODEL_H__
 
@@ -52,6 +44,8 @@
  * for internal use only, and may change without notice.
  */
 
+#define OCTEON_FAMILY_MASK      0x00ffff00
+
 /* Flag bits in top byte */
 /* Ignores revision in model checks */
 #define OM_IGNORE_REVISION        0x01000000
@@ -63,21 +57,48 @@
 #define OM_IGNORE_MINOR_REVISION  0x08000000
 #define OM_FLAG_MASK              0xff000000
 
-#define OM_MATCH_5XXX_FAMILY_MODELS     0x20000000 /* Match all cn5XXX Octeon models. */
-#define OM_MATCH_6XXX_FAMILY_MODELS     0x40000000 /* Match all cn6XXX Octeon models. */
+/* Match all cn5XXX Octeon models. */
+#define OM_MATCH_5XXX_FAMILY_MODELS     0x20000000
+/* Match all cn6XXX Octeon models. */
+#define OM_MATCH_6XXX_FAMILY_MODELS     0x40000000
 
 /*
  * CN6XXX models with new revision encoding
  */
+#define OCTEON_CN68XX_PASS1_0   0x000d9100
+#define OCTEON_CN68XX_PASS1_1   0x000d9101
+#define OCTEON_CN68XX_PASS1_2   0x000d9102
+#define OCTEON_CN68XX_PASS2_0   0x000d9108
+
+#define OCTEON_CN68XX           (OCTEON_CN68XX_PASS2_0 | OM_IGNORE_REVISION)
+#define OCTEON_CN68XX_PASS1_X   (OCTEON_CN68XX_PASS1_0 | OM_IGNORE_MINOR_REVISION)
+#define OCTEON_CN68XX_PASS2_X   (OCTEON_CN68XX_PASS2_0 | OM_IGNORE_MINOR_REVISION)
+
+#define OCTEON_CN68XX_PASS1	OCTEON_CN68XX_PASS1_X
+#define OCTEON_CN68XX_PASS2	OCTEON_CN68XX_PASS2_X
+
+#define OCTEON_CN66XX_PASS1_0   0x000d9200
+#define OCTEON_CN66XX_PASS1_2   0x000d9202
+
+#define OCTEON_CN66XX           (OCTEON_CN66XX_PASS1_0 | OM_IGNORE_REVISION)
+#define OCTEON_CN66XX_PASS1_X   (OCTEON_CN66XX_PASS1_0 | OM_IGNORE_MINOR_REVISION)
+
 #define OCTEON_CN63XX_PASS1_0   0x000d9000
 #define OCTEON_CN63XX_PASS1_1   0x000d9001
 #define OCTEON_CN63XX_PASS1_2   0x000d9002
 #define OCTEON_CN63XX_PASS2_0   0x000d9008
+#define OCTEON_CN63XX_PASS2_1   0x000d9009
+#define OCTEON_CN63XX_PASS2_2   0x000d900a
 
 #define OCTEON_CN63XX           (OCTEON_CN63XX_PASS2_0 | OM_IGNORE_REVISION)
 #define OCTEON_CN63XX_PASS1_X   (OCTEON_CN63XX_PASS1_0 | OM_IGNORE_MINOR_REVISION)
 #define OCTEON_CN63XX_PASS2_X   (OCTEON_CN63XX_PASS2_0 | OM_IGNORE_MINOR_REVISION)
 
+#define OCTEON_CN61XX_PASS1_0   0x000d9300
+
+#define OCTEON_CN61XX           (OCTEON_CN61XX_PASS1_0 | OM_IGNORE_REVISION)
+#define OCTEON_CN61XX_PASS1_X   (OCTEON_CN61XX_PASS1_0 | OM_IGNORE_MINOR_REVISION)
+
 /*
  * CN5XXX models with new revision encoding
  */
@@ -90,10 +111,8 @@
 #define OCTEON_CN58XX_PASS2_3   0x000d030b
 
 #define OCTEON_CN58XX           (OCTEON_CN58XX_PASS1_0 | OM_IGNORE_REVISION)
-#define OCTEON_CN58XX_PASS1_X   (OCTEON_CN58XX_PASS1_0 \
-				 | OM_IGNORE_MINOR_REVISION)
-#define OCTEON_CN58XX_PASS2_X   (OCTEON_CN58XX_PASS2_0 \
-				 | OM_IGNORE_MINOR_REVISION)
+#define OCTEON_CN58XX_PASS1_X   (OCTEON_CN58XX_PASS1_0 | OM_IGNORE_MINOR_REVISION)
+#define OCTEON_CN58XX_PASS2_X   (OCTEON_CN58XX_PASS2_0 | OM_IGNORE_MINOR_REVISION)
 #define OCTEON_CN58XX_PASS1     OCTEON_CN58XX_PASS1_X
 #define OCTEON_CN58XX_PASS2     OCTEON_CN58XX_PASS2_X
 
@@ -103,10 +122,8 @@
 #define OCTEON_CN56XX_PASS2_1   0x000d0409
 
 #define OCTEON_CN56XX           (OCTEON_CN56XX_PASS2_0 | OM_IGNORE_REVISION)
-#define OCTEON_CN56XX_PASS1_X   (OCTEON_CN56XX_PASS1_0 \
-				 | OM_IGNORE_MINOR_REVISION)
-#define OCTEON_CN56XX_PASS2_X   (OCTEON_CN56XX_PASS2_0 \
-				 | OM_IGNORE_MINOR_REVISION)
+#define OCTEON_CN56XX_PASS1_X   (OCTEON_CN56XX_PASS1_0 | OM_IGNORE_MINOR_REVISION)
+#define OCTEON_CN56XX_PASS2_X   (OCTEON_CN56XX_PASS2_0 | OM_IGNORE_MINOR_REVISION)
 #define OCTEON_CN56XX_PASS1     OCTEON_CN56XX_PASS1_X
 #define OCTEON_CN56XX_PASS2     OCTEON_CN56XX_PASS2_X
 
@@ -125,8 +142,7 @@
 #define OCTEON_CN50XX_PASS1_0   0x000d0600
 
 #define OCTEON_CN50XX           (OCTEON_CN50XX_PASS1_0 | OM_IGNORE_REVISION)
-#define OCTEON_CN50XX_PASS1_X   (OCTEON_CN50XX_PASS1_0 \
-				 | OM_IGNORE_MINOR_REVISION)
+#define OCTEON_CN50XX_PASS1_X   (OCTEON_CN50XX_PASS1_0 | OM_IGNORE_MINOR_REVISION)
 #define OCTEON_CN50XX_PASS1     OCTEON_CN50XX_PASS1_X
 
 /*
@@ -138,10 +154,8 @@
 #define OCTEON_CN52XX_PASS2_0   0x000d0708
 
 #define OCTEON_CN52XX           (OCTEON_CN52XX_PASS2_0 | OM_IGNORE_REVISION)
-#define OCTEON_CN52XX_PASS1_X   (OCTEON_CN52XX_PASS1_0 \
-				 | OM_IGNORE_MINOR_REVISION)
-#define OCTEON_CN52XX_PASS2_X   (OCTEON_CN52XX_PASS2_0 \
-				 | OM_IGNORE_MINOR_REVISION)
+#define OCTEON_CN52XX_PASS1_X   (OCTEON_CN52XX_PASS1_0 | OM_IGNORE_MINOR_REVISION)
+#define OCTEON_CN52XX_PASS2_X   (OCTEON_CN52XX_PASS2_0 | OM_IGNORE_MINOR_REVISION)
 #define OCTEON_CN52XX_PASS1     OCTEON_CN52XX_PASS1_X
 #define OCTEON_CN52XX_PASS2     OCTEON_CN52XX_PASS2_X
 
@@ -174,28 +188,23 @@
 #define OCTEON_CN3005_PASS1     (0x000d0210 | OM_CHECK_SUBMODEL)
 #define OCTEON_CN3005_PASS1_0   (0x000d0210 | OM_CHECK_SUBMODEL)
 #define OCTEON_CN3005_PASS1_1   (0x000d0212 | OM_CHECK_SUBMODEL)
-#define OCTEON_CN3005           (OCTEON_CN3005_PASS1 | OM_IGNORE_REVISION \
-				 | OM_CHECK_SUBMODEL)
+#define OCTEON_CN3005           (OCTEON_CN3005_PASS1 | OM_IGNORE_REVISION | OM_CHECK_SUBMODEL)
 
 #define OCTEON_CN3010_PASS1     (0x000d0200 | OM_CHECK_SUBMODEL)
 #define OCTEON_CN3010_PASS1_0   (0x000d0200 | OM_CHECK_SUBMODEL)
 #define OCTEON_CN3010_PASS1_1   (0x000d0202 | OM_CHECK_SUBMODEL)
-#define OCTEON_CN3010           (OCTEON_CN3010_PASS1 | OM_IGNORE_REVISION \
-				 | OM_CHECK_SUBMODEL)
+#define OCTEON_CN3010           (OCTEON_CN3010_PASS1 | OM_IGNORE_REVISION | OM_CHECK_SUBMODEL)
 
 #define OCTEON_CN3020_PASS1     (0x000d0110 | OM_CHECK_SUBMODEL)
 #define OCTEON_CN3020_PASS1_0   (0x000d0110 | OM_CHECK_SUBMODEL)
 #define OCTEON_CN3020_PASS1_1   (0x000d0112 | OM_CHECK_SUBMODEL)
-#define OCTEON_CN3020           (OCTEON_CN3020_PASS1 | OM_IGNORE_REVISION \
-				 | OM_CHECK_SUBMODEL)
-
-
-
-/* This matches the complete family of CN3xxx CPUs, and not subsequent models */
-#define OCTEON_CN3XXX           (OCTEON_CN58XX_PASS1_0 \
-				 | OM_MATCH_PREVIOUS_MODELS \
-				 | OM_IGNORE_REVISION)
+#define OCTEON_CN3020           (OCTEON_CN3020_PASS1 | OM_IGNORE_REVISION | OM_CHECK_SUBMODEL)
 
+/*
+ * This matches the complete family of CN3xxx CPUs, and not subsequent
+ * models
+ */
+#define OCTEON_CN3XXX           (OCTEON_CN58XX_PASS1_0 | OM_MATCH_PREVIOUS_MODELS | OM_IGNORE_REVISION)
 #define OCTEON_CN5XXX           (OCTEON_CN58XX_PASS1_0 | OM_MATCH_5XXX_FAMILY_MODELS)
 #define OCTEON_CN6XXX           (OCTEON_CN63XX_PASS1_0 | OM_MATCH_6XXX_FAMILY_MODELS)
 
@@ -221,90 +230,55 @@
 #define OCTEON_38XX_FAMILY_MASK      0x00ffff00
 #define OCTEON_38XX_FAMILY_REV_MASK  0x00ffff0f
 #define OCTEON_38XX_MODEL_MASK       0x00ffff10
-#define OCTEON_38XX_MODEL_REV_MASK   (OCTEON_38XX_FAMILY_REV_MASK \
-				      | OCTEON_38XX_MODEL_MASK)
+#define OCTEON_38XX_MODEL_REV_MASK   (OCTEON_38XX_FAMILY_REV_MASK | OCTEON_38XX_MODEL_MASK)
 
 /* CN5XXX and later use different layout of bits in the revision ID field */
 #define OCTEON_58XX_FAMILY_MASK      OCTEON_38XX_FAMILY_MASK
 #define OCTEON_58XX_FAMILY_REV_MASK  0x00ffff3f
 #define OCTEON_58XX_MODEL_MASK       0x00ffffc0
-#define OCTEON_58XX_MODEL_REV_MASK   (OCTEON_58XX_FAMILY_REV_MASK \
-				      | OCTEON_58XX_MODEL_MASK)
-#define OCTEON_58XX_MODEL_MINOR_REV_MASK (OCTEON_58XX_MODEL_REV_MASK \
-					  & 0x00fffff8)
+#define OCTEON_58XX_MODEL_REV_MASK   (OCTEON_58XX_FAMILY_REV_MASK | OCTEON_58XX_MODEL_MASK)
+#define OCTEON_58XX_MODEL_MINOR_REV_MASK (OCTEON_58XX_MODEL_REV_MASK & 0x00fffff8)
 #define OCTEON_5XXX_MODEL_MASK       0x00ff0fc0
 
-#define __OCTEON_MATCH_MASK__(x, y, z) (((x) & (z)) == ((y) & (z)))
-
-/* NOTE: This is for internal (to this file) use only. */
-static inline int __OCTEON_IS_MODEL_COMPILE__(uint32_t arg_model,
-					      uint32_t chip_model)
-{
-	uint32_t rev_and_sub = OM_IGNORE_REVISION | OM_CHECK_SUBMODEL;
-
-	if ((arg_model & OCTEON_38XX_FAMILY_MASK) < OCTEON_CN58XX_PASS1_0) {
-		if (((arg_model & OM_FLAG_MASK) == rev_and_sub) &&
-		    __OCTEON_MATCH_MASK__(chip_model, arg_model,
-					  OCTEON_38XX_MODEL_MASK))
-			return 1;
-		if (((arg_model & OM_FLAG_MASK) == 0) &&
-		    __OCTEON_MATCH_MASK__(chip_model, arg_model,
-					  OCTEON_38XX_FAMILY_REV_MASK))
-			return 1;
-		if (((arg_model & OM_FLAG_MASK) == OM_IGNORE_REVISION) &&
-		    __OCTEON_MATCH_MASK__(chip_model, arg_model,
-					  OCTEON_38XX_FAMILY_MASK))
-			return 1;
-		if (((arg_model & OM_FLAG_MASK) == OM_CHECK_SUBMODEL) &&
-		    __OCTEON_MATCH_MASK__((chip_model), (arg_model),
-					  OCTEON_38XX_MODEL_REV_MASK))
-			return 1;
-		if ((arg_model & OM_MATCH_PREVIOUS_MODELS) &&
-		    ((chip_model & OCTEON_38XX_MODEL_MASK) <
-			    (arg_model & OCTEON_38XX_MODEL_MASK)))
-			return 1;
-	} else {
-		if (((arg_model & OM_FLAG_MASK) == rev_and_sub) &&
-		    __OCTEON_MATCH_MASK__((chip_model), (arg_model),
-					  OCTEON_58XX_MODEL_MASK))
-			return 1;
-		if (((arg_model & OM_FLAG_MASK) == 0) &&
-		    __OCTEON_MATCH_MASK__((chip_model), (arg_model),
-					  OCTEON_58XX_FAMILY_REV_MASK))
-			return 1;
-		if (((arg_model & OM_FLAG_MASK) == OM_IGNORE_MINOR_REVISION) &&
-		    __OCTEON_MATCH_MASK__((chip_model), (arg_model),
-					  OCTEON_58XX_MODEL_MINOR_REV_MASK))
-			return 1;
-		if (((arg_model & OM_FLAG_MASK) == OM_IGNORE_REVISION) &&
-		    __OCTEON_MATCH_MASK__((chip_model), (arg_model),
-					  OCTEON_58XX_FAMILY_MASK))
-			return 1;
-		if (((arg_model & OM_FLAG_MASK) == OM_CHECK_SUBMODEL) &&
-		    __OCTEON_MATCH_MASK__((chip_model), (arg_model),
-					  OCTEON_58XX_MODEL_REV_MASK))
-			return 1;
-
-		if (((arg_model & OM_MATCH_5XXX_FAMILY_MODELS) == OM_MATCH_5XXX_FAMILY_MODELS) &&
-		    ((chip_model) >= OCTEON_CN58XX_PASS1_0) && ((chip_model) < OCTEON_CN63XX_PASS1_0))
-			return 1;
-
-		if (((arg_model & OM_MATCH_6XXX_FAMILY_MODELS) == OM_MATCH_6XXX_FAMILY_MODELS) &&
-		    ((chip_model) >= OCTEON_CN63XX_PASS1_0))
-			return 1;
-
-		if ((arg_model & OM_MATCH_PREVIOUS_MODELS) &&
-		    ((chip_model & OCTEON_58XX_MODEL_MASK) <
-			    (arg_model & OCTEON_58XX_MODEL_MASK)))
-			return 1;
-	}
-	return 0;
-}
-
 /* forward declarations */
 static inline uint32_t cvmx_get_proc_id(void) __attribute__ ((pure));
 static inline uint64_t cvmx_read_csr(uint64_t csr_addr);
 
+#define __OCTEON_MATCH_MASK__(x, y, z) (((x) & (z)) == ((y) & (z)))
+
+/* NOTE: This for internal use only! */
+#define __OCTEON_IS_MODEL_COMPILE__(arg_model, chip_model)		\
+((((arg_model & OCTEON_38XX_FAMILY_MASK) < OCTEON_CN58XX_PASS1_0)  && (	\
+		((((arg_model) & (OM_FLAG_MASK)) == (OM_IGNORE_REVISION | OM_CHECK_SUBMODEL)) \
+			&& __OCTEON_MATCH_MASK__((chip_model), (arg_model), OCTEON_38XX_MODEL_MASK)) || \
+		((((arg_model) & (OM_FLAG_MASK)) == 0)			\
+			&& __OCTEON_MATCH_MASK__((chip_model), (arg_model), OCTEON_38XX_FAMILY_REV_MASK)) || \
+		((((arg_model) & (OM_FLAG_MASK)) == OM_IGNORE_REVISION) \
+			&& __OCTEON_MATCH_MASK__((chip_model), (arg_model), OCTEON_38XX_FAMILY_MASK)) || \
+		((((arg_model) & (OM_FLAG_MASK)) == OM_CHECK_SUBMODEL)	\
+			&& __OCTEON_MATCH_MASK__((chip_model), (arg_model), OCTEON_38XX_MODEL_REV_MASK)) || \
+		((((arg_model) & (OM_MATCH_PREVIOUS_MODELS)) == OM_MATCH_PREVIOUS_MODELS) \
+			&& (((chip_model) & OCTEON_38XX_MODEL_MASK) < ((arg_model) & OCTEON_38XX_MODEL_MASK))) \
+		)) ||							\
+	(((arg_model & OCTEON_38XX_FAMILY_MASK) >= OCTEON_CN58XX_PASS1_0)  && (	\
+		((((arg_model) & (OM_FLAG_MASK)) == (OM_IGNORE_REVISION | OM_CHECK_SUBMODEL)) \
+			&& __OCTEON_MATCH_MASK__((chip_model), (arg_model), OCTEON_58XX_MODEL_MASK)) || \
+		((((arg_model) & (OM_FLAG_MASK)) == 0)			\
+			&& __OCTEON_MATCH_MASK__((chip_model), (arg_model), OCTEON_58XX_FAMILY_REV_MASK)) || \
+		((((arg_model) & (OM_FLAG_MASK)) == OM_IGNORE_MINOR_REVISION) \
+			&& __OCTEON_MATCH_MASK__((chip_model), (arg_model), OCTEON_58XX_MODEL_MINOR_REV_MASK)) || \
+		((((arg_model) & (OM_FLAG_MASK)) == OM_IGNORE_REVISION) \
+			&& __OCTEON_MATCH_MASK__((chip_model), (arg_model), OCTEON_58XX_FAMILY_MASK)) || \
+		((((arg_model) & (OM_FLAG_MASK)) == OM_CHECK_SUBMODEL)	\
+			&& __OCTEON_MATCH_MASK__((chip_model), (arg_model), OCTEON_58XX_MODEL_REV_MASK)) || \
+		((((arg_model) & (OM_MATCH_5XXX_FAMILY_MODELS)) == OM_MATCH_5XXX_FAMILY_MODELS) \
+			&& ((chip_model) >= OCTEON_CN58XX_PASS1_0) && ((chip_model) < OCTEON_CN63XX_PASS1_0)) || \
+		((((arg_model) & (OM_MATCH_6XXX_FAMILY_MODELS)) == OM_MATCH_6XXX_FAMILY_MODELS) \
+			&& ((chip_model) >= OCTEON_CN63XX_PASS1_0)) ||	\
+		((((arg_model) & (OM_MATCH_PREVIOUS_MODELS)) == OM_MATCH_PREVIOUS_MODELS) \
+			&& (((chip_model) & OCTEON_58XX_MODEL_MASK) < ((arg_model) & OCTEON_58XX_MODEL_MASK))) \
+		)))
+
 /* NOTE: This for internal use only!!!!! */
 static inline int __octeon_is_model_runtime__(uint32_t model)
 {
@@ -312,22 +286,25 @@ static inline int __octeon_is_model_runtime__(uint32_t model)
 
 	/*
 	 * Check for special case of mismarked 3005 samples. We only
-	 * need to check if the sub model isn't being ignored.
+	 * need to check if the sub model isn't being ignored
 	 */
 	if ((model & OM_CHECK_SUBMODEL) == OM_CHECK_SUBMODEL) {
-		if (cpuid == OCTEON_CN3010_PASS1 \
-		    && (cvmx_read_csr(0x80011800800007B8ull) & (1ull << 34)))
+		if (cpuid == OCTEON_CN3010_PASS1 && (cvmx_read_csr(0x80011800800007B8ull) & (1ull << 34)))
 			cpuid |= 0x10;
 	}
 	return __OCTEON_IS_MODEL_COMPILE__(model, cpuid);
 }
 
 /*
- * The OCTEON_IS_MODEL macro should be used for all Octeon model
- * checking done in a program.  This should be kept runtime if at all
- * possible.  Any compile time (#if OCTEON_IS_MODEL) usage must be
- * condtionalized with OCTEON_IS_COMMON_BINARY() if runtime checking
- * support is required.
+ * The OCTEON_IS_MODEL macro should be used for all Octeon model checking done
+ * in a program.
+ * This should be kept runtime if at all possible  and must be conditionalized
+ * with OCTEON_IS_COMMON_BINARY() if runtime checking support is required.
+ *
+ * Use of the macro in preprocessor directives ( #if OCTEON_IS_MODEL(...) )
+ * is NOT SUPPORTED, and should be replaced with CVMX_COMPILED_FOR()
+ * I.e.:
+ *  #if OCTEON_IS_MODEL(OCTEON_CN56XX)  ->  #if CVMX_COMPILED_FOR(OCTEON_CN56XX)
  */
 #define OCTEON_IS_MODEL(x) __octeon_is_model_runtime__(x)
 #define OCTEON_IS_COMMON_BINARY() 1
-- 
1.7.2.3
