Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2010 01:09:29 +0200 (CEST)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:18305 "EHLO
        smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491190Ab0JGXFI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Oct 2010 01:05:08 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by smtp2.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cae50da0000>; Thu, 07 Oct 2010 18:59:38 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 7 Oct 2010 16:04:15 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 7 Oct 2010 16:04:15 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o97N421D026936;
        Thu, 7 Oct 2010 16:04:02 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o97N41Xf026935;
        Thu, 7 Oct 2010 16:04:01 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 01/14] MIPS: Octeon: Update register definitions for CN63XX chips
Date:   Thu,  7 Oct 2010 16:03:40 -0700
Message-Id: <1286492633-26885-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
References: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 07 Oct 2010 23:04:15.0293 (UTC) FILETIME=[F67E36D0:01CB6673]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The CN63XX is a new 6-CPU SOC based on the new OCTEON II CPU cores.

Join some lines back together.  This makes some of them exceed 80
columns, but they are uninteresting and this unclutters things.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/octeon/cvmx-agl-defs.h     |  616 +++++++++++-----
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h     |  857 +++++++++++++++++++---
 arch/mips/include/asm/octeon/cvmx-gpio-defs.h    |   74 ++-
 arch/mips/include/asm/octeon/cvmx-iob-defs.h     |  242 ++++--
 arch/mips/include/asm/octeon/cvmx-ipd-defs.h     |  314 +++++---
 arch/mips/include/asm/octeon/cvmx-l2c-defs.h     |  738 +++++++++++++++++--
 arch/mips/include/asm/octeon/cvmx-l2d-defs.h     |   38 +-
 arch/mips/include/asm/octeon/cvmx-l2t-defs.h     |    5 +-
 arch/mips/include/asm/octeon/cvmx-led-defs.h     |   41 +-
 arch/mips/include/asm/octeon/cvmx-mio-defs.h     |  807 +++++++++++++++------
 arch/mips/include/asm/octeon/cvmx-mixx-defs.h    |  200 ++++--
 arch/mips/include/asm/octeon/cvmx-npei-defs.h    |  681 ++++++++----------
 arch/mips/include/asm/octeon/cvmx-npi-defs.h     |  362 +++------
 arch/mips/include/asm/octeon/cvmx-pci-defs.h     |  265 +++-----
 arch/mips/include/asm/octeon/cvmx-pciercx-defs.h |  435 +++++++----
 arch/mips/include/asm/octeon/cvmx-pescx-defs.h   |   50 +-
 arch/mips/include/asm/octeon/cvmx-pexp-defs.h    |  378 +++++-----
 arch/mips/include/asm/octeon/cvmx-pow-defs.h     |  157 +++--
 arch/mips/include/asm/octeon/cvmx-rnm-defs.h     |   67 ++-
 arch/mips/include/asm/octeon/cvmx-smix-defs.h    |   46 +-
 20 files changed, 4212 insertions(+), 2161 deletions(-)

diff --git a/arch/mips/include/asm/octeon/cvmx-agl-defs.h b/arch/mips/include/asm/octeon/cvmx-agl-defs.h
index ec94b9a..30d68f2 100644
--- a/arch/mips/include/asm/octeon/cvmx-agl-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-agl-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2010 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -28,148 +28,80 @@
 #ifndef __CVMX_AGL_DEFS_H__
 #define __CVMX_AGL_DEFS_H__
 
-#define CVMX_AGL_GMX_BAD_REG \
-	 CVMX_ADD_IO_SEG(0x00011800E0000518ull)
-#define CVMX_AGL_GMX_BIST \
-	 CVMX_ADD_IO_SEG(0x00011800E0000400ull)
-#define CVMX_AGL_GMX_DRV_CTL \
-	 CVMX_ADD_IO_SEG(0x00011800E00007F0ull)
-#define CVMX_AGL_GMX_INF_MODE \
-	 CVMX_ADD_IO_SEG(0x00011800E00007F8ull)
-#define CVMX_AGL_GMX_PRTX_CFG(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000010ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_ADR_CAM0(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000180ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_ADR_CAM1(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000188ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_ADR_CAM2(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000190ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_ADR_CAM3(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000198ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_ADR_CAM4(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E00001A0ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_ADR_CAM5(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E00001A8ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_ADR_CAM_EN(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000108ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_ADR_CTL(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000100ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_DECISION(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000040ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_FRM_CHK(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000020ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_FRM_CTL(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000018ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_FRM_MAX(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000030ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_FRM_MIN(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000028ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_IFG(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000058ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_INT_EN(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000008ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_INT_REG(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000000ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_JABBER(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000038ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_PAUSE_DROP_TIME(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000068ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_STATS_CTL(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000050ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_STATS_OCTS(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000088ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_STATS_OCTS_CTL(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000098ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_STATS_OCTS_DMAC(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E00000A8ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_STATS_OCTS_DRP(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E00000B8ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_STATS_PKTS(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000080ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_STATS_PKTS_BAD(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E00000C0ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_STATS_PKTS_CTL(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000090ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_STATS_PKTS_DMAC(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E00000A0ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_STATS_PKTS_DRP(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E00000B0ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RXX_UDD_SKP(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000048ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_RX_BP_DROPX(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000420ull + (((offset) & 1) * 8))
-#define CVMX_AGL_GMX_RX_BP_OFFX(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000460ull + (((offset) & 1) * 8))
-#define CVMX_AGL_GMX_RX_BP_ONX(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000440ull + (((offset) & 1) * 8))
-#define CVMX_AGL_GMX_RX_PRT_INFO \
-	 CVMX_ADD_IO_SEG(0x00011800E00004E8ull)
-#define CVMX_AGL_GMX_RX_TX_STATUS \
-	 CVMX_ADD_IO_SEG(0x00011800E00007E8ull)
-#define CVMX_AGL_GMX_SMACX(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000230ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_STAT_BP \
-	 CVMX_ADD_IO_SEG(0x00011800E0000520ull)
-#define CVMX_AGL_GMX_TXX_APPEND(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000218ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_TXX_CTL(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000270ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_TXX_MIN_PKT(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000240ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_TXX_PAUSE_PKT_INTERVAL(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000248ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_TXX_PAUSE_PKT_TIME(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000238ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_TXX_PAUSE_TOGO(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000258ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_TXX_PAUSE_ZERO(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000260ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_TXX_SOFT_PAUSE(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000250ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_TXX_STAT0(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000280ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_TXX_STAT1(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000288ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_TXX_STAT2(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000290ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_TXX_STAT3(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000298ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_TXX_STAT4(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E00002A0ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_TXX_STAT5(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E00002A8ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_TXX_STAT6(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E00002B0ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_TXX_STAT7(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E00002B8ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_TXX_STAT8(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E00002C0ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_TXX_STAT9(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E00002C8ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_TXX_STATS_CTL(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000268ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_TXX_THRESH(offset) \
-	 CVMX_ADD_IO_SEG(0x00011800E0000210ull + (((offset) & 1) * 2048))
-#define CVMX_AGL_GMX_TX_BP \
-	 CVMX_ADD_IO_SEG(0x00011800E00004D0ull)
-#define CVMX_AGL_GMX_TX_COL_ATTEMPT \
-	 CVMX_ADD_IO_SEG(0x00011800E0000498ull)
-#define CVMX_AGL_GMX_TX_IFG \
-	 CVMX_ADD_IO_SEG(0x00011800E0000488ull)
-#define CVMX_AGL_GMX_TX_INT_EN \
-	 CVMX_ADD_IO_SEG(0x00011800E0000508ull)
-#define CVMX_AGL_GMX_TX_INT_REG \
-	 CVMX_ADD_IO_SEG(0x00011800E0000500ull)
-#define CVMX_AGL_GMX_TX_JAM \
-	 CVMX_ADD_IO_SEG(0x00011800E0000490ull)
-#define CVMX_AGL_GMX_TX_LFSR \
-	 CVMX_ADD_IO_SEG(0x00011800E00004F8ull)
-#define CVMX_AGL_GMX_TX_OVR_BP \
-	 CVMX_ADD_IO_SEG(0x00011800E00004C8ull)
-#define CVMX_AGL_GMX_TX_PAUSE_PKT_DMAC \
-	 CVMX_ADD_IO_SEG(0x00011800E00004A0ull)
-#define CVMX_AGL_GMX_TX_PAUSE_PKT_TYPE \
-	 CVMX_ADD_IO_SEG(0x00011800E00004A8ull)
+#define CVMX_AGL_GMX_BAD_REG (CVMX_ADD_IO_SEG(0x00011800E0000518ull))
+#define CVMX_AGL_GMX_BIST (CVMX_ADD_IO_SEG(0x00011800E0000400ull))
+#define CVMX_AGL_GMX_DRV_CTL (CVMX_ADD_IO_SEG(0x00011800E00007F0ull))
+#define CVMX_AGL_GMX_INF_MODE (CVMX_ADD_IO_SEG(0x00011800E00007F8ull))
+#define CVMX_AGL_GMX_PRTX_CFG(offset) (CVMX_ADD_IO_SEG(0x00011800E0000010ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_ADR_CAM0(offset) (CVMX_ADD_IO_SEG(0x00011800E0000180ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_ADR_CAM1(offset) (CVMX_ADD_IO_SEG(0x00011800E0000188ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_ADR_CAM2(offset) (CVMX_ADD_IO_SEG(0x00011800E0000190ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_ADR_CAM3(offset) (CVMX_ADD_IO_SEG(0x00011800E0000198ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_ADR_CAM4(offset) (CVMX_ADD_IO_SEG(0x00011800E00001A0ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_ADR_CAM5(offset) (CVMX_ADD_IO_SEG(0x00011800E00001A8ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_ADR_CAM_EN(offset) (CVMX_ADD_IO_SEG(0x00011800E0000108ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_ADR_CTL(offset) (CVMX_ADD_IO_SEG(0x00011800E0000100ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_DECISION(offset) (CVMX_ADD_IO_SEG(0x00011800E0000040ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_FRM_CHK(offset) (CVMX_ADD_IO_SEG(0x00011800E0000020ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_FRM_CTL(offset) (CVMX_ADD_IO_SEG(0x00011800E0000018ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_FRM_MAX(offset) (CVMX_ADD_IO_SEG(0x00011800E0000030ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_FRM_MIN(offset) (CVMX_ADD_IO_SEG(0x00011800E0000028ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_IFG(offset) (CVMX_ADD_IO_SEG(0x00011800E0000058ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_INT_EN(offset) (CVMX_ADD_IO_SEG(0x00011800E0000008ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_INT_REG(offset) (CVMX_ADD_IO_SEG(0x00011800E0000000ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_JABBER(offset) (CVMX_ADD_IO_SEG(0x00011800E0000038ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_PAUSE_DROP_TIME(offset) (CVMX_ADD_IO_SEG(0x00011800E0000068ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_RX_INBND(offset) (CVMX_ADD_IO_SEG(0x00011800E0000060ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_STATS_CTL(offset) (CVMX_ADD_IO_SEG(0x00011800E0000050ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_STATS_OCTS(offset) (CVMX_ADD_IO_SEG(0x00011800E0000088ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_STATS_OCTS_CTL(offset) (CVMX_ADD_IO_SEG(0x00011800E0000098ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_STATS_OCTS_DMAC(offset) (CVMX_ADD_IO_SEG(0x00011800E00000A8ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_STATS_OCTS_DRP(offset) (CVMX_ADD_IO_SEG(0x00011800E00000B8ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_STATS_PKTS(offset) (CVMX_ADD_IO_SEG(0x00011800E0000080ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_STATS_PKTS_BAD(offset) (CVMX_ADD_IO_SEG(0x00011800E00000C0ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_STATS_PKTS_CTL(offset) (CVMX_ADD_IO_SEG(0x00011800E0000090ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_STATS_PKTS_DMAC(offset) (CVMX_ADD_IO_SEG(0x00011800E00000A0ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_STATS_PKTS_DRP(offset) (CVMX_ADD_IO_SEG(0x00011800E00000B0ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RXX_UDD_SKP(offset) (CVMX_ADD_IO_SEG(0x00011800E0000048ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_RX_BP_DROPX(offset) (CVMX_ADD_IO_SEG(0x00011800E0000420ull) + ((offset) & 1) * 8)
+#define CVMX_AGL_GMX_RX_BP_OFFX(offset) (CVMX_ADD_IO_SEG(0x00011800E0000460ull) + ((offset) & 1) * 8)
+#define CVMX_AGL_GMX_RX_BP_ONX(offset) (CVMX_ADD_IO_SEG(0x00011800E0000440ull) + ((offset) & 1) * 8)
+#define CVMX_AGL_GMX_RX_PRT_INFO (CVMX_ADD_IO_SEG(0x00011800E00004E8ull))
+#define CVMX_AGL_GMX_RX_TX_STATUS (CVMX_ADD_IO_SEG(0x00011800E00007E8ull))
+#define CVMX_AGL_GMX_SMACX(offset) (CVMX_ADD_IO_SEG(0x00011800E0000230ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_STAT_BP (CVMX_ADD_IO_SEG(0x00011800E0000520ull))
+#define CVMX_AGL_GMX_TXX_APPEND(offset) (CVMX_ADD_IO_SEG(0x00011800E0000218ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_TXX_CLK(offset) (CVMX_ADD_IO_SEG(0x00011800E0000208ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_TXX_CTL(offset) (CVMX_ADD_IO_SEG(0x00011800E0000270ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_TXX_MIN_PKT(offset) (CVMX_ADD_IO_SEG(0x00011800E0000240ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_TXX_PAUSE_PKT_INTERVAL(offset) (CVMX_ADD_IO_SEG(0x00011800E0000248ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_TXX_PAUSE_PKT_TIME(offset) (CVMX_ADD_IO_SEG(0x00011800E0000238ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_TXX_PAUSE_TOGO(offset) (CVMX_ADD_IO_SEG(0x00011800E0000258ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_TXX_PAUSE_ZERO(offset) (CVMX_ADD_IO_SEG(0x00011800E0000260ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_TXX_SOFT_PAUSE(offset) (CVMX_ADD_IO_SEG(0x00011800E0000250ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_TXX_STAT0(offset) (CVMX_ADD_IO_SEG(0x00011800E0000280ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_TXX_STAT1(offset) (CVMX_ADD_IO_SEG(0x00011800E0000288ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_TXX_STAT2(offset) (CVMX_ADD_IO_SEG(0x00011800E0000290ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_TXX_STAT3(offset) (CVMX_ADD_IO_SEG(0x00011800E0000298ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_TXX_STAT4(offset) (CVMX_ADD_IO_SEG(0x00011800E00002A0ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_TXX_STAT5(offset) (CVMX_ADD_IO_SEG(0x00011800E00002A8ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_TXX_STAT6(offset) (CVMX_ADD_IO_SEG(0x00011800E00002B0ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_TXX_STAT7(offset) (CVMX_ADD_IO_SEG(0x00011800E00002B8ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_TXX_STAT8(offset) (CVMX_ADD_IO_SEG(0x00011800E00002C0ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_TXX_STAT9(offset) (CVMX_ADD_IO_SEG(0x00011800E00002C8ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_TXX_STATS_CTL(offset) (CVMX_ADD_IO_SEG(0x00011800E0000268ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_TXX_THRESH(offset) (CVMX_ADD_IO_SEG(0x00011800E0000210ull) + ((offset) & 1) * 2048)
+#define CVMX_AGL_GMX_TX_BP (CVMX_ADD_IO_SEG(0x00011800E00004D0ull))
+#define CVMX_AGL_GMX_TX_COL_ATTEMPT (CVMX_ADD_IO_SEG(0x00011800E0000498ull))
+#define CVMX_AGL_GMX_TX_IFG (CVMX_ADD_IO_SEG(0x00011800E0000488ull))
+#define CVMX_AGL_GMX_TX_INT_EN (CVMX_ADD_IO_SEG(0x00011800E0000508ull))
+#define CVMX_AGL_GMX_TX_INT_REG (CVMX_ADD_IO_SEG(0x00011800E0000500ull))
+#define CVMX_AGL_GMX_TX_JAM (CVMX_ADD_IO_SEG(0x00011800E0000490ull))
+#define CVMX_AGL_GMX_TX_LFSR (CVMX_ADD_IO_SEG(0x00011800E00004F8ull))
+#define CVMX_AGL_GMX_TX_OVR_BP (CVMX_ADD_IO_SEG(0x00011800E00004C8ull))
+#define CVMX_AGL_GMX_TX_PAUSE_PKT_DMAC (CVMX_ADD_IO_SEG(0x00011800E00004A0ull))
+#define CVMX_AGL_GMX_TX_PAUSE_PKT_TYPE (CVMX_ADD_IO_SEG(0x00011800E00004A8ull))
+#define CVMX_AGL_PRTX_CTL(offset) (CVMX_ADD_IO_SEG(0x00011800E0002000ull) + ((offset) & 1) * 8)
 
 union cvmx_agl_gmx_bad_reg {
 	uint64_t u64;
@@ -183,14 +115,29 @@ union cvmx_agl_gmx_bad_reg {
 		uint64_t ovrflw:1;
 		uint64_t reserved_27_31:5;
 		uint64_t statovr:1;
+		uint64_t reserved_24_25:2;
+		uint64_t loststat:2;
+		uint64_t reserved_4_21:18;
+		uint64_t out_ovr:2;
+		uint64_t reserved_0_1:2;
+	} s;
+	struct cvmx_agl_gmx_bad_reg_cn52xx {
+		uint64_t reserved_38_63:26;
+		uint64_t txpsh1:1;
+		uint64_t txpop1:1;
+		uint64_t ovrflw1:1;
+		uint64_t txpsh:1;
+		uint64_t txpop:1;
+		uint64_t ovrflw:1;
+		uint64_t reserved_27_31:5;
+		uint64_t statovr:1;
 		uint64_t reserved_23_25:3;
 		uint64_t loststat:1;
 		uint64_t reserved_4_21:18;
 		uint64_t out_ovr:2;
 		uint64_t reserved_0_1:2;
-	} s;
-	struct cvmx_agl_gmx_bad_reg_s cn52xx;
-	struct cvmx_agl_gmx_bad_reg_s cn52xxp1;
+	} cn52xx;
+	struct cvmx_agl_gmx_bad_reg_cn52xx cn52xxp1;
 	struct cvmx_agl_gmx_bad_reg_cn56xx {
 		uint64_t reserved_35_63:29;
 		uint64_t txpsh:1;
@@ -205,18 +152,25 @@ union cvmx_agl_gmx_bad_reg {
 		uint64_t reserved_0_1:2;
 	} cn56xx;
 	struct cvmx_agl_gmx_bad_reg_cn56xx cn56xxp1;
+	struct cvmx_agl_gmx_bad_reg_s cn63xx;
+	struct cvmx_agl_gmx_bad_reg_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_bist {
 	uint64_t u64;
 	struct cvmx_agl_gmx_bist_s {
+		uint64_t reserved_25_63:39;
+		uint64_t status:25;
+	} s;
+	struct cvmx_agl_gmx_bist_cn52xx {
 		uint64_t reserved_10_63:54;
 		uint64_t status:10;
-	} s;
-	struct cvmx_agl_gmx_bist_s cn52xx;
-	struct cvmx_agl_gmx_bist_s cn52xxp1;
-	struct cvmx_agl_gmx_bist_s cn56xx;
-	struct cvmx_agl_gmx_bist_s cn56xxp1;
+	} cn52xx;
+	struct cvmx_agl_gmx_bist_cn52xx cn52xxp1;
+	struct cvmx_agl_gmx_bist_cn52xx cn56xx;
+	struct cvmx_agl_gmx_bist_cn52xx cn56xxp1;
+	struct cvmx_agl_gmx_bist_s cn63xx;
+	struct cvmx_agl_gmx_bist_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_drv_ctl {
@@ -264,7 +218,13 @@ union cvmx_agl_gmx_inf_mode {
 union cvmx_agl_gmx_prtx_cfg {
 	uint64_t u64;
 	struct cvmx_agl_gmx_prtx_cfg_s {
-		uint64_t reserved_6_63:58;
+		uint64_t reserved_14_63:50;
+		uint64_t tx_idle:1;
+		uint64_t rx_idle:1;
+		uint64_t reserved_9_11:3;
+		uint64_t speed_msb:1;
+		uint64_t reserved_7_7:1;
+		uint64_t burst:1;
 		uint64_t tx_en:1;
 		uint64_t rx_en:1;
 		uint64_t slottime:1;
@@ -272,10 +232,20 @@ union cvmx_agl_gmx_prtx_cfg {
 		uint64_t speed:1;
 		uint64_t en:1;
 	} s;
-	struct cvmx_agl_gmx_prtx_cfg_s cn52xx;
-	struct cvmx_agl_gmx_prtx_cfg_s cn52xxp1;
-	struct cvmx_agl_gmx_prtx_cfg_s cn56xx;
-	struct cvmx_agl_gmx_prtx_cfg_s cn56xxp1;
+	struct cvmx_agl_gmx_prtx_cfg_cn52xx {
+		uint64_t reserved_6_63:58;
+		uint64_t tx_en:1;
+		uint64_t rx_en:1;
+		uint64_t slottime:1;
+		uint64_t duplex:1;
+		uint64_t speed:1;
+		uint64_t en:1;
+	} cn52xx;
+	struct cvmx_agl_gmx_prtx_cfg_cn52xx cn52xxp1;
+	struct cvmx_agl_gmx_prtx_cfg_cn52xx cn56xx;
+	struct cvmx_agl_gmx_prtx_cfg_cn52xx cn56xxp1;
+	struct cvmx_agl_gmx_prtx_cfg_s cn63xx;
+	struct cvmx_agl_gmx_prtx_cfg_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_adr_cam0 {
@@ -287,6 +257,8 @@ union cvmx_agl_gmx_rxx_adr_cam0 {
 	struct cvmx_agl_gmx_rxx_adr_cam0_s cn52xxp1;
 	struct cvmx_agl_gmx_rxx_adr_cam0_s cn56xx;
 	struct cvmx_agl_gmx_rxx_adr_cam0_s cn56xxp1;
+	struct cvmx_agl_gmx_rxx_adr_cam0_s cn63xx;
+	struct cvmx_agl_gmx_rxx_adr_cam0_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_adr_cam1 {
@@ -298,6 +270,8 @@ union cvmx_agl_gmx_rxx_adr_cam1 {
 	struct cvmx_agl_gmx_rxx_adr_cam1_s cn52xxp1;
 	struct cvmx_agl_gmx_rxx_adr_cam1_s cn56xx;
 	struct cvmx_agl_gmx_rxx_adr_cam1_s cn56xxp1;
+	struct cvmx_agl_gmx_rxx_adr_cam1_s cn63xx;
+	struct cvmx_agl_gmx_rxx_adr_cam1_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_adr_cam2 {
@@ -309,6 +283,8 @@ union cvmx_agl_gmx_rxx_adr_cam2 {
 	struct cvmx_agl_gmx_rxx_adr_cam2_s cn52xxp1;
 	struct cvmx_agl_gmx_rxx_adr_cam2_s cn56xx;
 	struct cvmx_agl_gmx_rxx_adr_cam2_s cn56xxp1;
+	struct cvmx_agl_gmx_rxx_adr_cam2_s cn63xx;
+	struct cvmx_agl_gmx_rxx_adr_cam2_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_adr_cam3 {
@@ -320,6 +296,8 @@ union cvmx_agl_gmx_rxx_adr_cam3 {
 	struct cvmx_agl_gmx_rxx_adr_cam3_s cn52xxp1;
 	struct cvmx_agl_gmx_rxx_adr_cam3_s cn56xx;
 	struct cvmx_agl_gmx_rxx_adr_cam3_s cn56xxp1;
+	struct cvmx_agl_gmx_rxx_adr_cam3_s cn63xx;
+	struct cvmx_agl_gmx_rxx_adr_cam3_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_adr_cam4 {
@@ -331,6 +309,8 @@ union cvmx_agl_gmx_rxx_adr_cam4 {
 	struct cvmx_agl_gmx_rxx_adr_cam4_s cn52xxp1;
 	struct cvmx_agl_gmx_rxx_adr_cam4_s cn56xx;
 	struct cvmx_agl_gmx_rxx_adr_cam4_s cn56xxp1;
+	struct cvmx_agl_gmx_rxx_adr_cam4_s cn63xx;
+	struct cvmx_agl_gmx_rxx_adr_cam4_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_adr_cam5 {
@@ -342,6 +322,8 @@ union cvmx_agl_gmx_rxx_adr_cam5 {
 	struct cvmx_agl_gmx_rxx_adr_cam5_s cn52xxp1;
 	struct cvmx_agl_gmx_rxx_adr_cam5_s cn56xx;
 	struct cvmx_agl_gmx_rxx_adr_cam5_s cn56xxp1;
+	struct cvmx_agl_gmx_rxx_adr_cam5_s cn63xx;
+	struct cvmx_agl_gmx_rxx_adr_cam5_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_adr_cam_en {
@@ -354,6 +336,8 @@ union cvmx_agl_gmx_rxx_adr_cam_en {
 	struct cvmx_agl_gmx_rxx_adr_cam_en_s cn52xxp1;
 	struct cvmx_agl_gmx_rxx_adr_cam_en_s cn56xx;
 	struct cvmx_agl_gmx_rxx_adr_cam_en_s cn56xxp1;
+	struct cvmx_agl_gmx_rxx_adr_cam_en_s cn63xx;
+	struct cvmx_agl_gmx_rxx_adr_cam_en_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_adr_ctl {
@@ -368,6 +352,8 @@ union cvmx_agl_gmx_rxx_adr_ctl {
 	struct cvmx_agl_gmx_rxx_adr_ctl_s cn52xxp1;
 	struct cvmx_agl_gmx_rxx_adr_ctl_s cn56xx;
 	struct cvmx_agl_gmx_rxx_adr_ctl_s cn56xxp1;
+	struct cvmx_agl_gmx_rxx_adr_ctl_s cn63xx;
+	struct cvmx_agl_gmx_rxx_adr_ctl_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_decision {
@@ -380,11 +366,26 @@ union cvmx_agl_gmx_rxx_decision {
 	struct cvmx_agl_gmx_rxx_decision_s cn52xxp1;
 	struct cvmx_agl_gmx_rxx_decision_s cn56xx;
 	struct cvmx_agl_gmx_rxx_decision_s cn56xxp1;
+	struct cvmx_agl_gmx_rxx_decision_s cn63xx;
+	struct cvmx_agl_gmx_rxx_decision_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_frm_chk {
 	uint64_t u64;
 	struct cvmx_agl_gmx_rxx_frm_chk_s {
+		uint64_t reserved_10_63:54;
+		uint64_t niberr:1;
+		uint64_t skperr:1;
+		uint64_t rcverr:1;
+		uint64_t lenerr:1;
+		uint64_t alnerr:1;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t maxerr:1;
+		uint64_t carext:1;
+		uint64_t minerr:1;
+	} s;
+	struct cvmx_agl_gmx_rxx_frm_chk_cn52xx {
 		uint64_t reserved_9_63:55;
 		uint64_t skperr:1;
 		uint64_t rcverr:1;
@@ -395,17 +396,21 @@ union cvmx_agl_gmx_rxx_frm_chk {
 		uint64_t maxerr:1;
 		uint64_t reserved_1_1:1;
 		uint64_t minerr:1;
-	} s;
-	struct cvmx_agl_gmx_rxx_frm_chk_s cn52xx;
-	struct cvmx_agl_gmx_rxx_frm_chk_s cn52xxp1;
-	struct cvmx_agl_gmx_rxx_frm_chk_s cn56xx;
-	struct cvmx_agl_gmx_rxx_frm_chk_s cn56xxp1;
+	} cn52xx;
+	struct cvmx_agl_gmx_rxx_frm_chk_cn52xx cn52xxp1;
+	struct cvmx_agl_gmx_rxx_frm_chk_cn52xx cn56xx;
+	struct cvmx_agl_gmx_rxx_frm_chk_cn52xx cn56xxp1;
+	struct cvmx_agl_gmx_rxx_frm_chk_s cn63xx;
+	struct cvmx_agl_gmx_rxx_frm_chk_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_frm_ctl {
 	uint64_t u64;
 	struct cvmx_agl_gmx_rxx_frm_ctl_s {
-		uint64_t reserved_10_63:54;
+		uint64_t reserved_13_63:51;
+		uint64_t ptp_mode:1;
+		uint64_t reserved_11_11:1;
+		uint64_t null_dis:1;
 		uint64_t pre_align:1;
 		uint64_t pad_len:1;
 		uint64_t vlan_len:1;
@@ -417,10 +422,24 @@ union cvmx_agl_gmx_rxx_frm_ctl {
 		uint64_t pre_strp:1;
 		uint64_t pre_chk:1;
 	} s;
-	struct cvmx_agl_gmx_rxx_frm_ctl_s cn52xx;
-	struct cvmx_agl_gmx_rxx_frm_ctl_s cn52xxp1;
-	struct cvmx_agl_gmx_rxx_frm_ctl_s cn56xx;
-	struct cvmx_agl_gmx_rxx_frm_ctl_s cn56xxp1;
+	struct cvmx_agl_gmx_rxx_frm_ctl_cn52xx {
+		uint64_t reserved_10_63:54;
+		uint64_t pre_align:1;
+		uint64_t pad_len:1;
+		uint64_t vlan_len:1;
+		uint64_t pre_free:1;
+		uint64_t ctl_smac:1;
+		uint64_t ctl_mcst:1;
+		uint64_t ctl_bck:1;
+		uint64_t ctl_drp:1;
+		uint64_t pre_strp:1;
+		uint64_t pre_chk:1;
+	} cn52xx;
+	struct cvmx_agl_gmx_rxx_frm_ctl_cn52xx cn52xxp1;
+	struct cvmx_agl_gmx_rxx_frm_ctl_cn52xx cn56xx;
+	struct cvmx_agl_gmx_rxx_frm_ctl_cn52xx cn56xxp1;
+	struct cvmx_agl_gmx_rxx_frm_ctl_s cn63xx;
+	struct cvmx_agl_gmx_rxx_frm_ctl_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_frm_max {
@@ -433,6 +452,8 @@ union cvmx_agl_gmx_rxx_frm_max {
 	struct cvmx_agl_gmx_rxx_frm_max_s cn52xxp1;
 	struct cvmx_agl_gmx_rxx_frm_max_s cn56xx;
 	struct cvmx_agl_gmx_rxx_frm_max_s cn56xxp1;
+	struct cvmx_agl_gmx_rxx_frm_max_s cn63xx;
+	struct cvmx_agl_gmx_rxx_frm_max_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_frm_min {
@@ -445,6 +466,8 @@ union cvmx_agl_gmx_rxx_frm_min {
 	struct cvmx_agl_gmx_rxx_frm_min_s cn52xxp1;
 	struct cvmx_agl_gmx_rxx_frm_min_s cn56xx;
 	struct cvmx_agl_gmx_rxx_frm_min_s cn56xxp1;
+	struct cvmx_agl_gmx_rxx_frm_min_s cn63xx;
+	struct cvmx_agl_gmx_rxx_frm_min_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_ifg {
@@ -457,6 +480,8 @@ union cvmx_agl_gmx_rxx_ifg {
 	struct cvmx_agl_gmx_rxx_ifg_s cn52xxp1;
 	struct cvmx_agl_gmx_rxx_ifg_s cn56xx;
 	struct cvmx_agl_gmx_rxx_ifg_s cn56xxp1;
+	struct cvmx_agl_gmx_rxx_ifg_s cn63xx;
+	struct cvmx_agl_gmx_rxx_ifg_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_int_en {
@@ -464,6 +489,29 @@ union cvmx_agl_gmx_rxx_int_en {
 	struct cvmx_agl_gmx_rxx_int_en_s {
 		uint64_t reserved_20_63:44;
 		uint64_t pause_drp:1;
+		uint64_t phy_dupx:1;
+		uint64_t phy_spd:1;
+		uint64_t phy_link:1;
+		uint64_t ifgerr:1;
+		uint64_t coldet:1;
+		uint64_t falerr:1;
+		uint64_t rsverr:1;
+		uint64_t pcterr:1;
+		uint64_t ovrerr:1;
+		uint64_t niberr:1;
+		uint64_t skperr:1;
+		uint64_t rcverr:1;
+		uint64_t lenerr:1;
+		uint64_t alnerr:1;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t maxerr:1;
+		uint64_t carext:1;
+		uint64_t minerr:1;
+	} s;
+	struct cvmx_agl_gmx_rxx_int_en_cn52xx {
+		uint64_t reserved_20_63:44;
+		uint64_t pause_drp:1;
 		uint64_t reserved_16_18:3;
 		uint64_t ifgerr:1;
 		uint64_t coldet:1;
@@ -481,11 +529,12 @@ union cvmx_agl_gmx_rxx_int_en {
 		uint64_t maxerr:1;
 		uint64_t reserved_1_1:1;
 		uint64_t minerr:1;
-	} s;
-	struct cvmx_agl_gmx_rxx_int_en_s cn52xx;
-	struct cvmx_agl_gmx_rxx_int_en_s cn52xxp1;
-	struct cvmx_agl_gmx_rxx_int_en_s cn56xx;
-	struct cvmx_agl_gmx_rxx_int_en_s cn56xxp1;
+	} cn52xx;
+	struct cvmx_agl_gmx_rxx_int_en_cn52xx cn52xxp1;
+	struct cvmx_agl_gmx_rxx_int_en_cn52xx cn56xx;
+	struct cvmx_agl_gmx_rxx_int_en_cn52xx cn56xxp1;
+	struct cvmx_agl_gmx_rxx_int_en_s cn63xx;
+	struct cvmx_agl_gmx_rxx_int_en_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_int_reg {
@@ -493,6 +542,29 @@ union cvmx_agl_gmx_rxx_int_reg {
 	struct cvmx_agl_gmx_rxx_int_reg_s {
 		uint64_t reserved_20_63:44;
 		uint64_t pause_drp:1;
+		uint64_t phy_dupx:1;
+		uint64_t phy_spd:1;
+		uint64_t phy_link:1;
+		uint64_t ifgerr:1;
+		uint64_t coldet:1;
+		uint64_t falerr:1;
+		uint64_t rsverr:1;
+		uint64_t pcterr:1;
+		uint64_t ovrerr:1;
+		uint64_t niberr:1;
+		uint64_t skperr:1;
+		uint64_t rcverr:1;
+		uint64_t lenerr:1;
+		uint64_t alnerr:1;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t maxerr:1;
+		uint64_t carext:1;
+		uint64_t minerr:1;
+	} s;
+	struct cvmx_agl_gmx_rxx_int_reg_cn52xx {
+		uint64_t reserved_20_63:44;
+		uint64_t pause_drp:1;
 		uint64_t reserved_16_18:3;
 		uint64_t ifgerr:1;
 		uint64_t coldet:1;
@@ -510,11 +582,12 @@ union cvmx_agl_gmx_rxx_int_reg {
 		uint64_t maxerr:1;
 		uint64_t reserved_1_1:1;
 		uint64_t minerr:1;
-	} s;
-	struct cvmx_agl_gmx_rxx_int_reg_s cn52xx;
-	struct cvmx_agl_gmx_rxx_int_reg_s cn52xxp1;
-	struct cvmx_agl_gmx_rxx_int_reg_s cn56xx;
-	struct cvmx_agl_gmx_rxx_int_reg_s cn56xxp1;
+	} cn52xx;
+	struct cvmx_agl_gmx_rxx_int_reg_cn52xx cn52xxp1;
+	struct cvmx_agl_gmx_rxx_int_reg_cn52xx cn56xx;
+	struct cvmx_agl_gmx_rxx_int_reg_cn52xx cn56xxp1;
+	struct cvmx_agl_gmx_rxx_int_reg_s cn63xx;
+	struct cvmx_agl_gmx_rxx_int_reg_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_jabber {
@@ -527,6 +600,8 @@ union cvmx_agl_gmx_rxx_jabber {
 	struct cvmx_agl_gmx_rxx_jabber_s cn52xxp1;
 	struct cvmx_agl_gmx_rxx_jabber_s cn56xx;
 	struct cvmx_agl_gmx_rxx_jabber_s cn56xxp1;
+	struct cvmx_agl_gmx_rxx_jabber_s cn63xx;
+	struct cvmx_agl_gmx_rxx_jabber_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_pause_drop_time {
@@ -539,6 +614,20 @@ union cvmx_agl_gmx_rxx_pause_drop_time {
 	struct cvmx_agl_gmx_rxx_pause_drop_time_s cn52xxp1;
 	struct cvmx_agl_gmx_rxx_pause_drop_time_s cn56xx;
 	struct cvmx_agl_gmx_rxx_pause_drop_time_s cn56xxp1;
+	struct cvmx_agl_gmx_rxx_pause_drop_time_s cn63xx;
+	struct cvmx_agl_gmx_rxx_pause_drop_time_s cn63xxp1;
+};
+
+union cvmx_agl_gmx_rxx_rx_inbnd {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_rx_inbnd_s {
+		uint64_t reserved_4_63:60;
+		uint64_t duplex:1;
+		uint64_t speed:2;
+		uint64_t status:1;
+	} s;
+	struct cvmx_agl_gmx_rxx_rx_inbnd_s cn63xx;
+	struct cvmx_agl_gmx_rxx_rx_inbnd_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_stats_ctl {
@@ -551,6 +640,8 @@ union cvmx_agl_gmx_rxx_stats_ctl {
 	struct cvmx_agl_gmx_rxx_stats_ctl_s cn52xxp1;
 	struct cvmx_agl_gmx_rxx_stats_ctl_s cn56xx;
 	struct cvmx_agl_gmx_rxx_stats_ctl_s cn56xxp1;
+	struct cvmx_agl_gmx_rxx_stats_ctl_s cn63xx;
+	struct cvmx_agl_gmx_rxx_stats_ctl_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_stats_octs {
@@ -563,6 +654,8 @@ union cvmx_agl_gmx_rxx_stats_octs {
 	struct cvmx_agl_gmx_rxx_stats_octs_s cn52xxp1;
 	struct cvmx_agl_gmx_rxx_stats_octs_s cn56xx;
 	struct cvmx_agl_gmx_rxx_stats_octs_s cn56xxp1;
+	struct cvmx_agl_gmx_rxx_stats_octs_s cn63xx;
+	struct cvmx_agl_gmx_rxx_stats_octs_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_stats_octs_ctl {
@@ -575,6 +668,8 @@ union cvmx_agl_gmx_rxx_stats_octs_ctl {
 	struct cvmx_agl_gmx_rxx_stats_octs_ctl_s cn52xxp1;
 	struct cvmx_agl_gmx_rxx_stats_octs_ctl_s cn56xx;
 	struct cvmx_agl_gmx_rxx_stats_octs_ctl_s cn56xxp1;
+	struct cvmx_agl_gmx_rxx_stats_octs_ctl_s cn63xx;
+	struct cvmx_agl_gmx_rxx_stats_octs_ctl_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_stats_octs_dmac {
@@ -587,6 +682,8 @@ union cvmx_agl_gmx_rxx_stats_octs_dmac {
 	struct cvmx_agl_gmx_rxx_stats_octs_dmac_s cn52xxp1;
 	struct cvmx_agl_gmx_rxx_stats_octs_dmac_s cn56xx;
 	struct cvmx_agl_gmx_rxx_stats_octs_dmac_s cn56xxp1;
+	struct cvmx_agl_gmx_rxx_stats_octs_dmac_s cn63xx;
+	struct cvmx_agl_gmx_rxx_stats_octs_dmac_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_stats_octs_drp {
@@ -599,6 +696,8 @@ union cvmx_agl_gmx_rxx_stats_octs_drp {
 	struct cvmx_agl_gmx_rxx_stats_octs_drp_s cn52xxp1;
 	struct cvmx_agl_gmx_rxx_stats_octs_drp_s cn56xx;
 	struct cvmx_agl_gmx_rxx_stats_octs_drp_s cn56xxp1;
+	struct cvmx_agl_gmx_rxx_stats_octs_drp_s cn63xx;
+	struct cvmx_agl_gmx_rxx_stats_octs_drp_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_stats_pkts {
@@ -611,6 +710,8 @@ union cvmx_agl_gmx_rxx_stats_pkts {
 	struct cvmx_agl_gmx_rxx_stats_pkts_s cn52xxp1;
 	struct cvmx_agl_gmx_rxx_stats_pkts_s cn56xx;
 	struct cvmx_agl_gmx_rxx_stats_pkts_s cn56xxp1;
+	struct cvmx_agl_gmx_rxx_stats_pkts_s cn63xx;
+	struct cvmx_agl_gmx_rxx_stats_pkts_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_stats_pkts_bad {
@@ -623,6 +724,8 @@ union cvmx_agl_gmx_rxx_stats_pkts_bad {
 	struct cvmx_agl_gmx_rxx_stats_pkts_bad_s cn52xxp1;
 	struct cvmx_agl_gmx_rxx_stats_pkts_bad_s cn56xx;
 	struct cvmx_agl_gmx_rxx_stats_pkts_bad_s cn56xxp1;
+	struct cvmx_agl_gmx_rxx_stats_pkts_bad_s cn63xx;
+	struct cvmx_agl_gmx_rxx_stats_pkts_bad_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_stats_pkts_ctl {
@@ -635,6 +738,8 @@ union cvmx_agl_gmx_rxx_stats_pkts_ctl {
 	struct cvmx_agl_gmx_rxx_stats_pkts_ctl_s cn52xxp1;
 	struct cvmx_agl_gmx_rxx_stats_pkts_ctl_s cn56xx;
 	struct cvmx_agl_gmx_rxx_stats_pkts_ctl_s cn56xxp1;
+	struct cvmx_agl_gmx_rxx_stats_pkts_ctl_s cn63xx;
+	struct cvmx_agl_gmx_rxx_stats_pkts_ctl_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_stats_pkts_dmac {
@@ -647,6 +752,8 @@ union cvmx_agl_gmx_rxx_stats_pkts_dmac {
 	struct cvmx_agl_gmx_rxx_stats_pkts_dmac_s cn52xxp1;
 	struct cvmx_agl_gmx_rxx_stats_pkts_dmac_s cn56xx;
 	struct cvmx_agl_gmx_rxx_stats_pkts_dmac_s cn56xxp1;
+	struct cvmx_agl_gmx_rxx_stats_pkts_dmac_s cn63xx;
+	struct cvmx_agl_gmx_rxx_stats_pkts_dmac_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_stats_pkts_drp {
@@ -659,6 +766,8 @@ union cvmx_agl_gmx_rxx_stats_pkts_drp {
 	struct cvmx_agl_gmx_rxx_stats_pkts_drp_s cn52xxp1;
 	struct cvmx_agl_gmx_rxx_stats_pkts_drp_s cn56xx;
 	struct cvmx_agl_gmx_rxx_stats_pkts_drp_s cn56xxp1;
+	struct cvmx_agl_gmx_rxx_stats_pkts_drp_s cn63xx;
+	struct cvmx_agl_gmx_rxx_stats_pkts_drp_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rxx_udd_skp {
@@ -673,6 +782,8 @@ union cvmx_agl_gmx_rxx_udd_skp {
 	struct cvmx_agl_gmx_rxx_udd_skp_s cn52xxp1;
 	struct cvmx_agl_gmx_rxx_udd_skp_s cn56xx;
 	struct cvmx_agl_gmx_rxx_udd_skp_s cn56xxp1;
+	struct cvmx_agl_gmx_rxx_udd_skp_s cn63xx;
+	struct cvmx_agl_gmx_rxx_udd_skp_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rx_bp_dropx {
@@ -685,6 +796,8 @@ union cvmx_agl_gmx_rx_bp_dropx {
 	struct cvmx_agl_gmx_rx_bp_dropx_s cn52xxp1;
 	struct cvmx_agl_gmx_rx_bp_dropx_s cn56xx;
 	struct cvmx_agl_gmx_rx_bp_dropx_s cn56xxp1;
+	struct cvmx_agl_gmx_rx_bp_dropx_s cn63xx;
+	struct cvmx_agl_gmx_rx_bp_dropx_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rx_bp_offx {
@@ -697,6 +810,8 @@ union cvmx_agl_gmx_rx_bp_offx {
 	struct cvmx_agl_gmx_rx_bp_offx_s cn52xxp1;
 	struct cvmx_agl_gmx_rx_bp_offx_s cn56xx;
 	struct cvmx_agl_gmx_rx_bp_offx_s cn56xxp1;
+	struct cvmx_agl_gmx_rx_bp_offx_s cn63xx;
+	struct cvmx_agl_gmx_rx_bp_offx_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rx_bp_onx {
@@ -709,6 +824,8 @@ union cvmx_agl_gmx_rx_bp_onx {
 	struct cvmx_agl_gmx_rx_bp_onx_s cn52xxp1;
 	struct cvmx_agl_gmx_rx_bp_onx_s cn56xx;
 	struct cvmx_agl_gmx_rx_bp_onx_s cn56xxp1;
+	struct cvmx_agl_gmx_rx_bp_onx_s cn63xx;
+	struct cvmx_agl_gmx_rx_bp_onx_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rx_prt_info {
@@ -728,6 +845,8 @@ union cvmx_agl_gmx_rx_prt_info {
 		uint64_t commit:1;
 	} cn56xx;
 	struct cvmx_agl_gmx_rx_prt_info_cn56xx cn56xxp1;
+	struct cvmx_agl_gmx_rx_prt_info_s cn63xx;
+	struct cvmx_agl_gmx_rx_prt_info_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_rx_tx_status {
@@ -747,6 +866,8 @@ union cvmx_agl_gmx_rx_tx_status {
 		uint64_t rx:1;
 	} cn56xx;
 	struct cvmx_agl_gmx_rx_tx_status_cn56xx cn56xxp1;
+	struct cvmx_agl_gmx_rx_tx_status_s cn63xx;
+	struct cvmx_agl_gmx_rx_tx_status_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_smacx {
@@ -759,6 +880,8 @@ union cvmx_agl_gmx_smacx {
 	struct cvmx_agl_gmx_smacx_s cn52xxp1;
 	struct cvmx_agl_gmx_smacx_s cn56xx;
 	struct cvmx_agl_gmx_smacx_s cn56xxp1;
+	struct cvmx_agl_gmx_smacx_s cn63xx;
+	struct cvmx_agl_gmx_smacx_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_stat_bp {
@@ -772,6 +895,8 @@ union cvmx_agl_gmx_stat_bp {
 	struct cvmx_agl_gmx_stat_bp_s cn52xxp1;
 	struct cvmx_agl_gmx_stat_bp_s cn56xx;
 	struct cvmx_agl_gmx_stat_bp_s cn56xxp1;
+	struct cvmx_agl_gmx_stat_bp_s cn63xx;
+	struct cvmx_agl_gmx_stat_bp_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_txx_append {
@@ -787,6 +912,18 @@ union cvmx_agl_gmx_txx_append {
 	struct cvmx_agl_gmx_txx_append_s cn52xxp1;
 	struct cvmx_agl_gmx_txx_append_s cn56xx;
 	struct cvmx_agl_gmx_txx_append_s cn56xxp1;
+	struct cvmx_agl_gmx_txx_append_s cn63xx;
+	struct cvmx_agl_gmx_txx_append_s cn63xxp1;
+};
+
+union cvmx_agl_gmx_txx_clk {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_clk_s {
+		uint64_t reserved_6_63:58;
+		uint64_t clk_cnt:6;
+	} s;
+	struct cvmx_agl_gmx_txx_clk_s cn63xx;
+	struct cvmx_agl_gmx_txx_clk_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_txx_ctl {
@@ -800,6 +937,8 @@ union cvmx_agl_gmx_txx_ctl {
 	struct cvmx_agl_gmx_txx_ctl_s cn52xxp1;
 	struct cvmx_agl_gmx_txx_ctl_s cn56xx;
 	struct cvmx_agl_gmx_txx_ctl_s cn56xxp1;
+	struct cvmx_agl_gmx_txx_ctl_s cn63xx;
+	struct cvmx_agl_gmx_txx_ctl_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_txx_min_pkt {
@@ -812,6 +951,8 @@ union cvmx_agl_gmx_txx_min_pkt {
 	struct cvmx_agl_gmx_txx_min_pkt_s cn52xxp1;
 	struct cvmx_agl_gmx_txx_min_pkt_s cn56xx;
 	struct cvmx_agl_gmx_txx_min_pkt_s cn56xxp1;
+	struct cvmx_agl_gmx_txx_min_pkt_s cn63xx;
+	struct cvmx_agl_gmx_txx_min_pkt_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_txx_pause_pkt_interval {
@@ -824,6 +965,8 @@ union cvmx_agl_gmx_txx_pause_pkt_interval {
 	struct cvmx_agl_gmx_txx_pause_pkt_interval_s cn52xxp1;
 	struct cvmx_agl_gmx_txx_pause_pkt_interval_s cn56xx;
 	struct cvmx_agl_gmx_txx_pause_pkt_interval_s cn56xxp1;
+	struct cvmx_agl_gmx_txx_pause_pkt_interval_s cn63xx;
+	struct cvmx_agl_gmx_txx_pause_pkt_interval_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_txx_pause_pkt_time {
@@ -836,6 +979,8 @@ union cvmx_agl_gmx_txx_pause_pkt_time {
 	struct cvmx_agl_gmx_txx_pause_pkt_time_s cn52xxp1;
 	struct cvmx_agl_gmx_txx_pause_pkt_time_s cn56xx;
 	struct cvmx_agl_gmx_txx_pause_pkt_time_s cn56xxp1;
+	struct cvmx_agl_gmx_txx_pause_pkt_time_s cn63xx;
+	struct cvmx_agl_gmx_txx_pause_pkt_time_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_txx_pause_togo {
@@ -848,6 +993,8 @@ union cvmx_agl_gmx_txx_pause_togo {
 	struct cvmx_agl_gmx_txx_pause_togo_s cn52xxp1;
 	struct cvmx_agl_gmx_txx_pause_togo_s cn56xx;
 	struct cvmx_agl_gmx_txx_pause_togo_s cn56xxp1;
+	struct cvmx_agl_gmx_txx_pause_togo_s cn63xx;
+	struct cvmx_agl_gmx_txx_pause_togo_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_txx_pause_zero {
@@ -860,6 +1007,8 @@ union cvmx_agl_gmx_txx_pause_zero {
 	struct cvmx_agl_gmx_txx_pause_zero_s cn52xxp1;
 	struct cvmx_agl_gmx_txx_pause_zero_s cn56xx;
 	struct cvmx_agl_gmx_txx_pause_zero_s cn56xxp1;
+	struct cvmx_agl_gmx_txx_pause_zero_s cn63xx;
+	struct cvmx_agl_gmx_txx_pause_zero_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_txx_soft_pause {
@@ -872,6 +1021,8 @@ union cvmx_agl_gmx_txx_soft_pause {
 	struct cvmx_agl_gmx_txx_soft_pause_s cn52xxp1;
 	struct cvmx_agl_gmx_txx_soft_pause_s cn56xx;
 	struct cvmx_agl_gmx_txx_soft_pause_s cn56xxp1;
+	struct cvmx_agl_gmx_txx_soft_pause_s cn63xx;
+	struct cvmx_agl_gmx_txx_soft_pause_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_txx_stat0 {
@@ -884,6 +1035,8 @@ union cvmx_agl_gmx_txx_stat0 {
 	struct cvmx_agl_gmx_txx_stat0_s cn52xxp1;
 	struct cvmx_agl_gmx_txx_stat0_s cn56xx;
 	struct cvmx_agl_gmx_txx_stat0_s cn56xxp1;
+	struct cvmx_agl_gmx_txx_stat0_s cn63xx;
+	struct cvmx_agl_gmx_txx_stat0_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_txx_stat1 {
@@ -896,6 +1049,8 @@ union cvmx_agl_gmx_txx_stat1 {
 	struct cvmx_agl_gmx_txx_stat1_s cn52xxp1;
 	struct cvmx_agl_gmx_txx_stat1_s cn56xx;
 	struct cvmx_agl_gmx_txx_stat1_s cn56xxp1;
+	struct cvmx_agl_gmx_txx_stat1_s cn63xx;
+	struct cvmx_agl_gmx_txx_stat1_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_txx_stat2 {
@@ -908,6 +1063,8 @@ union cvmx_agl_gmx_txx_stat2 {
 	struct cvmx_agl_gmx_txx_stat2_s cn52xxp1;
 	struct cvmx_agl_gmx_txx_stat2_s cn56xx;
 	struct cvmx_agl_gmx_txx_stat2_s cn56xxp1;
+	struct cvmx_agl_gmx_txx_stat2_s cn63xx;
+	struct cvmx_agl_gmx_txx_stat2_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_txx_stat3 {
@@ -920,6 +1077,8 @@ union cvmx_agl_gmx_txx_stat3 {
 	struct cvmx_agl_gmx_txx_stat3_s cn52xxp1;
 	struct cvmx_agl_gmx_txx_stat3_s cn56xx;
 	struct cvmx_agl_gmx_txx_stat3_s cn56xxp1;
+	struct cvmx_agl_gmx_txx_stat3_s cn63xx;
+	struct cvmx_agl_gmx_txx_stat3_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_txx_stat4 {
@@ -932,6 +1091,8 @@ union cvmx_agl_gmx_txx_stat4 {
 	struct cvmx_agl_gmx_txx_stat4_s cn52xxp1;
 	struct cvmx_agl_gmx_txx_stat4_s cn56xx;
 	struct cvmx_agl_gmx_txx_stat4_s cn56xxp1;
+	struct cvmx_agl_gmx_txx_stat4_s cn63xx;
+	struct cvmx_agl_gmx_txx_stat4_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_txx_stat5 {
@@ -944,6 +1105,8 @@ union cvmx_agl_gmx_txx_stat5 {
 	struct cvmx_agl_gmx_txx_stat5_s cn52xxp1;
 	struct cvmx_agl_gmx_txx_stat5_s cn56xx;
 	struct cvmx_agl_gmx_txx_stat5_s cn56xxp1;
+	struct cvmx_agl_gmx_txx_stat5_s cn63xx;
+	struct cvmx_agl_gmx_txx_stat5_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_txx_stat6 {
@@ -956,6 +1119,8 @@ union cvmx_agl_gmx_txx_stat6 {
 	struct cvmx_agl_gmx_txx_stat6_s cn52xxp1;
 	struct cvmx_agl_gmx_txx_stat6_s cn56xx;
 	struct cvmx_agl_gmx_txx_stat6_s cn56xxp1;
+	struct cvmx_agl_gmx_txx_stat6_s cn63xx;
+	struct cvmx_agl_gmx_txx_stat6_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_txx_stat7 {
@@ -968,6 +1133,8 @@ union cvmx_agl_gmx_txx_stat7 {
 	struct cvmx_agl_gmx_txx_stat7_s cn52xxp1;
 	struct cvmx_agl_gmx_txx_stat7_s cn56xx;
 	struct cvmx_agl_gmx_txx_stat7_s cn56xxp1;
+	struct cvmx_agl_gmx_txx_stat7_s cn63xx;
+	struct cvmx_agl_gmx_txx_stat7_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_txx_stat8 {
@@ -980,6 +1147,8 @@ union cvmx_agl_gmx_txx_stat8 {
 	struct cvmx_agl_gmx_txx_stat8_s cn52xxp1;
 	struct cvmx_agl_gmx_txx_stat8_s cn56xx;
 	struct cvmx_agl_gmx_txx_stat8_s cn56xxp1;
+	struct cvmx_agl_gmx_txx_stat8_s cn63xx;
+	struct cvmx_agl_gmx_txx_stat8_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_txx_stat9 {
@@ -992,6 +1161,8 @@ union cvmx_agl_gmx_txx_stat9 {
 	struct cvmx_agl_gmx_txx_stat9_s cn52xxp1;
 	struct cvmx_agl_gmx_txx_stat9_s cn56xx;
 	struct cvmx_agl_gmx_txx_stat9_s cn56xxp1;
+	struct cvmx_agl_gmx_txx_stat9_s cn63xx;
+	struct cvmx_agl_gmx_txx_stat9_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_txx_stats_ctl {
@@ -1004,6 +1175,8 @@ union cvmx_agl_gmx_txx_stats_ctl {
 	struct cvmx_agl_gmx_txx_stats_ctl_s cn52xxp1;
 	struct cvmx_agl_gmx_txx_stats_ctl_s cn56xx;
 	struct cvmx_agl_gmx_txx_stats_ctl_s cn56xxp1;
+	struct cvmx_agl_gmx_txx_stats_ctl_s cn63xx;
+	struct cvmx_agl_gmx_txx_stats_ctl_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_txx_thresh {
@@ -1016,6 +1189,8 @@ union cvmx_agl_gmx_txx_thresh {
 	struct cvmx_agl_gmx_txx_thresh_s cn52xxp1;
 	struct cvmx_agl_gmx_txx_thresh_s cn56xx;
 	struct cvmx_agl_gmx_txx_thresh_s cn56xxp1;
+	struct cvmx_agl_gmx_txx_thresh_s cn63xx;
+	struct cvmx_agl_gmx_txx_thresh_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_tx_bp {
@@ -1031,6 +1206,8 @@ union cvmx_agl_gmx_tx_bp {
 		uint64_t bp:1;
 	} cn56xx;
 	struct cvmx_agl_gmx_tx_bp_cn56xx cn56xxp1;
+	struct cvmx_agl_gmx_tx_bp_s cn63xx;
+	struct cvmx_agl_gmx_tx_bp_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_tx_col_attempt {
@@ -1043,6 +1220,8 @@ union cvmx_agl_gmx_tx_col_attempt {
 	struct cvmx_agl_gmx_tx_col_attempt_s cn52xxp1;
 	struct cvmx_agl_gmx_tx_col_attempt_s cn56xx;
 	struct cvmx_agl_gmx_tx_col_attempt_s cn56xxp1;
+	struct cvmx_agl_gmx_tx_col_attempt_s cn63xx;
+	struct cvmx_agl_gmx_tx_col_attempt_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_tx_ifg {
@@ -1056,12 +1235,16 @@ union cvmx_agl_gmx_tx_ifg {
 	struct cvmx_agl_gmx_tx_ifg_s cn52xxp1;
 	struct cvmx_agl_gmx_tx_ifg_s cn56xx;
 	struct cvmx_agl_gmx_tx_ifg_s cn56xxp1;
+	struct cvmx_agl_gmx_tx_ifg_s cn63xx;
+	struct cvmx_agl_gmx_tx_ifg_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_tx_int_en {
 	uint64_t u64;
 	struct cvmx_agl_gmx_tx_int_en_s {
-		uint64_t reserved_18_63:46;
+		uint64_t reserved_22_63:42;
+		uint64_t ptp_lost:2;
+		uint64_t reserved_18_19:2;
 		uint64_t late_col:2;
 		uint64_t reserved_14_15:2;
 		uint64_t xsdef:2;
@@ -1072,8 +1255,19 @@ union cvmx_agl_gmx_tx_int_en {
 		uint64_t reserved_1_1:1;
 		uint64_t pko_nxa:1;
 	} s;
-	struct cvmx_agl_gmx_tx_int_en_s cn52xx;
-	struct cvmx_agl_gmx_tx_int_en_s cn52xxp1;
+	struct cvmx_agl_gmx_tx_int_en_cn52xx {
+		uint64_t reserved_18_63:46;
+		uint64_t late_col:2;
+		uint64_t reserved_14_15:2;
+		uint64_t xsdef:2;
+		uint64_t reserved_10_11:2;
+		uint64_t xscol:2;
+		uint64_t reserved_4_7:4;
+		uint64_t undflw:2;
+		uint64_t reserved_1_1:1;
+		uint64_t pko_nxa:1;
+	} cn52xx;
+	struct cvmx_agl_gmx_tx_int_en_cn52xx cn52xxp1;
 	struct cvmx_agl_gmx_tx_int_en_cn56xx {
 		uint64_t reserved_17_63:47;
 		uint64_t late_col:1;
@@ -1087,12 +1281,16 @@ union cvmx_agl_gmx_tx_int_en {
 		uint64_t pko_nxa:1;
 	} cn56xx;
 	struct cvmx_agl_gmx_tx_int_en_cn56xx cn56xxp1;
+	struct cvmx_agl_gmx_tx_int_en_s cn63xx;
+	struct cvmx_agl_gmx_tx_int_en_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_tx_int_reg {
 	uint64_t u64;
 	struct cvmx_agl_gmx_tx_int_reg_s {
-		uint64_t reserved_18_63:46;
+		uint64_t reserved_22_63:42;
+		uint64_t ptp_lost:2;
+		uint64_t reserved_18_19:2;
 		uint64_t late_col:2;
 		uint64_t reserved_14_15:2;
 		uint64_t xsdef:2;
@@ -1103,8 +1301,19 @@ union cvmx_agl_gmx_tx_int_reg {
 		uint64_t reserved_1_1:1;
 		uint64_t pko_nxa:1;
 	} s;
-	struct cvmx_agl_gmx_tx_int_reg_s cn52xx;
-	struct cvmx_agl_gmx_tx_int_reg_s cn52xxp1;
+	struct cvmx_agl_gmx_tx_int_reg_cn52xx {
+		uint64_t reserved_18_63:46;
+		uint64_t late_col:2;
+		uint64_t reserved_14_15:2;
+		uint64_t xsdef:2;
+		uint64_t reserved_10_11:2;
+		uint64_t xscol:2;
+		uint64_t reserved_4_7:4;
+		uint64_t undflw:2;
+		uint64_t reserved_1_1:1;
+		uint64_t pko_nxa:1;
+	} cn52xx;
+	struct cvmx_agl_gmx_tx_int_reg_cn52xx cn52xxp1;
 	struct cvmx_agl_gmx_tx_int_reg_cn56xx {
 		uint64_t reserved_17_63:47;
 		uint64_t late_col:1;
@@ -1118,6 +1327,8 @@ union cvmx_agl_gmx_tx_int_reg {
 		uint64_t pko_nxa:1;
 	} cn56xx;
 	struct cvmx_agl_gmx_tx_int_reg_cn56xx cn56xxp1;
+	struct cvmx_agl_gmx_tx_int_reg_s cn63xx;
+	struct cvmx_agl_gmx_tx_int_reg_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_tx_jam {
@@ -1130,6 +1341,8 @@ union cvmx_agl_gmx_tx_jam {
 	struct cvmx_agl_gmx_tx_jam_s cn52xxp1;
 	struct cvmx_agl_gmx_tx_jam_s cn56xx;
 	struct cvmx_agl_gmx_tx_jam_s cn56xxp1;
+	struct cvmx_agl_gmx_tx_jam_s cn63xx;
+	struct cvmx_agl_gmx_tx_jam_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_tx_lfsr {
@@ -1142,6 +1355,8 @@ union cvmx_agl_gmx_tx_lfsr {
 	struct cvmx_agl_gmx_tx_lfsr_s cn52xxp1;
 	struct cvmx_agl_gmx_tx_lfsr_s cn56xx;
 	struct cvmx_agl_gmx_tx_lfsr_s cn56xxp1;
+	struct cvmx_agl_gmx_tx_lfsr_s cn63xx;
+	struct cvmx_agl_gmx_tx_lfsr_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_tx_ovr_bp {
@@ -1165,6 +1380,8 @@ union cvmx_agl_gmx_tx_ovr_bp {
 		uint64_t ign_full:1;
 	} cn56xx;
 	struct cvmx_agl_gmx_tx_ovr_bp_cn56xx cn56xxp1;
+	struct cvmx_agl_gmx_tx_ovr_bp_s cn63xx;
+	struct cvmx_agl_gmx_tx_ovr_bp_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_tx_pause_pkt_dmac {
@@ -1177,6 +1394,8 @@ union cvmx_agl_gmx_tx_pause_pkt_dmac {
 	struct cvmx_agl_gmx_tx_pause_pkt_dmac_s cn52xxp1;
 	struct cvmx_agl_gmx_tx_pause_pkt_dmac_s cn56xx;
 	struct cvmx_agl_gmx_tx_pause_pkt_dmac_s cn56xxp1;
+	struct cvmx_agl_gmx_tx_pause_pkt_dmac_s cn63xx;
+	struct cvmx_agl_gmx_tx_pause_pkt_dmac_s cn63xxp1;
 };
 
 union cvmx_agl_gmx_tx_pause_pkt_type {
@@ -1189,6 +1408,39 @@ union cvmx_agl_gmx_tx_pause_pkt_type {
 	struct cvmx_agl_gmx_tx_pause_pkt_type_s cn52xxp1;
 	struct cvmx_agl_gmx_tx_pause_pkt_type_s cn56xx;
 	struct cvmx_agl_gmx_tx_pause_pkt_type_s cn56xxp1;
+	struct cvmx_agl_gmx_tx_pause_pkt_type_s cn63xx;
+	struct cvmx_agl_gmx_tx_pause_pkt_type_s cn63xxp1;
+};
+
+union cvmx_agl_prtx_ctl {
+	uint64_t u64;
+	struct cvmx_agl_prtx_ctl_s {
+		uint64_t drv_byp:1;
+		uint64_t reserved_62_62:1;
+		uint64_t cmp_pctl:6;
+		uint64_t reserved_54_55:2;
+		uint64_t cmp_nctl:6;
+		uint64_t reserved_46_47:2;
+		uint64_t drv_pctl:6;
+		uint64_t reserved_38_39:2;
+		uint64_t drv_nctl:6;
+		uint64_t reserved_29_31:3;
+		uint64_t clk_set:5;
+		uint64_t clkrx_byp:1;
+		uint64_t reserved_21_22:2;
+		uint64_t clkrx_set:5;
+		uint64_t clktx_byp:1;
+		uint64_t reserved_13_14:2;
+		uint64_t clktx_set:5;
+		uint64_t reserved_5_7:3;
+		uint64_t dllrst:1;
+		uint64_t comp:1;
+		uint64_t enable:1;
+		uint64_t clkrst:1;
+		uint64_t mode:1;
+	} s;
+	struct cvmx_agl_prtx_ctl_s cn63xx;
+	struct cvmx_agl_prtx_ctl_s cn63xxp1;
 };
 
 #endif
diff --git a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
index f8f05b7..27cead3 100644
--- a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2010 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -28,87 +28,61 @@
 #ifndef __CVMX_CIU_DEFS_H__
 #define __CVMX_CIU_DEFS_H__
 
-#define CVMX_CIU_BIST \
-	 CVMX_ADD_IO_SEG(0x0001070000000730ull)
-#define CVMX_CIU_DINT \
-	 CVMX_ADD_IO_SEG(0x0001070000000720ull)
-#define CVMX_CIU_FUSE \
-	 CVMX_ADD_IO_SEG(0x0001070000000728ull)
-#define CVMX_CIU_GSTOP \
-	 CVMX_ADD_IO_SEG(0x0001070000000710ull)
-#define CVMX_CIU_INTX_EN0(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000000200ull + (((offset) & 63) * 16))
-#define CVMX_CIU_INTX_EN0_W1C(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000002200ull + (((offset) & 63) * 16))
-#define CVMX_CIU_INTX_EN0_W1S(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000006200ull + (((offset) & 63) * 16))
-#define CVMX_CIU_INTX_EN1(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000000208ull + (((offset) & 63) * 16))
-#define CVMX_CIU_INTX_EN1_W1C(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000002208ull + (((offset) & 63) * 16))
-#define CVMX_CIU_INTX_EN1_W1S(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000006208ull + (((offset) & 63) * 16))
-#define CVMX_CIU_INTX_EN4_0(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000000C80ull + (((offset) & 15) * 16))
-#define CVMX_CIU_INTX_EN4_0_W1C(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000002C80ull + (((offset) & 15) * 16))
-#define CVMX_CIU_INTX_EN4_0_W1S(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000006C80ull + (((offset) & 15) * 16))
-#define CVMX_CIU_INTX_EN4_1(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000000C88ull + (((offset) & 15) * 16))
-#define CVMX_CIU_INTX_EN4_1_W1C(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000002C88ull + (((offset) & 15) * 16))
-#define CVMX_CIU_INTX_EN4_1_W1S(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000006C88ull + (((offset) & 15) * 16))
-#define CVMX_CIU_INTX_SUM0(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000000000ull + (((offset) & 63) * 8))
-#define CVMX_CIU_INTX_SUM4(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000000C00ull + (((offset) & 15) * 8))
-#define CVMX_CIU_INT_SUM1 \
-	 CVMX_ADD_IO_SEG(0x0001070000000108ull)
-#define CVMX_CIU_MBOX_CLRX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000000680ull + (((offset) & 15) * 8))
-#define CVMX_CIU_MBOX_SETX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000000600ull + (((offset) & 15) * 8))
-#define CVMX_CIU_NMI \
-	 CVMX_ADD_IO_SEG(0x0001070000000718ull)
-#define CVMX_CIU_PCI_INTA \
-	 CVMX_ADD_IO_SEG(0x0001070000000750ull)
-#define CVMX_CIU_PP_DBG \
-	 CVMX_ADD_IO_SEG(0x0001070000000708ull)
-#define CVMX_CIU_PP_POKEX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000000580ull + (((offset) & 15) * 8))
-#define CVMX_CIU_PP_RST \
-	 CVMX_ADD_IO_SEG(0x0001070000000700ull)
-#define CVMX_CIU_QLM_DCOK \
-	 CVMX_ADD_IO_SEG(0x0001070000000760ull)
-#define CVMX_CIU_QLM_JTGC \
-	 CVMX_ADD_IO_SEG(0x0001070000000768ull)
-#define CVMX_CIU_QLM_JTGD \
-	 CVMX_ADD_IO_SEG(0x0001070000000770ull)
-#define CVMX_CIU_SOFT_BIST \
-	 CVMX_ADD_IO_SEG(0x0001070000000738ull)
-#define CVMX_CIU_SOFT_PRST \
-	 CVMX_ADD_IO_SEG(0x0001070000000748ull)
-#define CVMX_CIU_SOFT_PRST1 \
-	 CVMX_ADD_IO_SEG(0x0001070000000758ull)
-#define CVMX_CIU_SOFT_RST \
-	 CVMX_ADD_IO_SEG(0x0001070000000740ull)
-#define CVMX_CIU_TIMX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000000480ull + (((offset) & 3) * 8))
-#define CVMX_CIU_WDOGX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000000500ull + (((offset) & 15) * 8))
+#define CVMX_CIU_BIST (CVMX_ADD_IO_SEG(0x0001070000000730ull))
+#define CVMX_CIU_BLOCK_INT (CVMX_ADD_IO_SEG(0x00010700000007C0ull))
+#define CVMX_CIU_DINT (CVMX_ADD_IO_SEG(0x0001070000000720ull))
+#define CVMX_CIU_FUSE (CVMX_ADD_IO_SEG(0x0001070000000728ull))
+#define CVMX_CIU_GSTOP (CVMX_ADD_IO_SEG(0x0001070000000710ull))
+#define CVMX_CIU_INT33_SUM0 (CVMX_ADD_IO_SEG(0x0001070000000110ull))
+#define CVMX_CIU_INTX_EN0(offset) (CVMX_ADD_IO_SEG(0x0001070000000200ull) + ((offset) & 63) * 16)
+#define CVMX_CIU_INTX_EN0_W1C(offset) (CVMX_ADD_IO_SEG(0x0001070000002200ull) + ((offset) & 63) * 16)
+#define CVMX_CIU_INTX_EN0_W1S(offset) (CVMX_ADD_IO_SEG(0x0001070000006200ull) + ((offset) & 63) * 16)
+#define CVMX_CIU_INTX_EN1(offset) (CVMX_ADD_IO_SEG(0x0001070000000208ull) + ((offset) & 63) * 16)
+#define CVMX_CIU_INTX_EN1_W1C(offset) (CVMX_ADD_IO_SEG(0x0001070000002208ull) + ((offset) & 63) * 16)
+#define CVMX_CIU_INTX_EN1_W1S(offset) (CVMX_ADD_IO_SEG(0x0001070000006208ull) + ((offset) & 63) * 16)
+#define CVMX_CIU_INTX_EN4_0(offset) (CVMX_ADD_IO_SEG(0x0001070000000C80ull) + ((offset) & 15) * 16)
+#define CVMX_CIU_INTX_EN4_0_W1C(offset) (CVMX_ADD_IO_SEG(0x0001070000002C80ull) + ((offset) & 15) * 16)
+#define CVMX_CIU_INTX_EN4_0_W1S(offset) (CVMX_ADD_IO_SEG(0x0001070000006C80ull) + ((offset) & 15) * 16)
+#define CVMX_CIU_INTX_EN4_1(offset) (CVMX_ADD_IO_SEG(0x0001070000000C88ull) + ((offset) & 15) * 16)
+#define CVMX_CIU_INTX_EN4_1_W1C(offset) (CVMX_ADD_IO_SEG(0x0001070000002C88ull) + ((offset) & 15) * 16)
+#define CVMX_CIU_INTX_EN4_1_W1S(offset) (CVMX_ADD_IO_SEG(0x0001070000006C88ull) + ((offset) & 15) * 16)
+#define CVMX_CIU_INTX_SUM0(offset) (CVMX_ADD_IO_SEG(0x0001070000000000ull) + ((offset) & 63) * 8)
+#define CVMX_CIU_INTX_SUM4(offset) (CVMX_ADD_IO_SEG(0x0001070000000C00ull) + ((offset) & 15) * 8)
+#define CVMX_CIU_INT_DBG_SEL (CVMX_ADD_IO_SEG(0x00010700000007D0ull))
+#define CVMX_CIU_INT_SUM1 (CVMX_ADD_IO_SEG(0x0001070000000108ull))
+#define CVMX_CIU_MBOX_CLRX(offset) (CVMX_ADD_IO_SEG(0x0001070000000680ull) + ((offset) & 15) * 8)
+#define CVMX_CIU_MBOX_SETX(offset) (CVMX_ADD_IO_SEG(0x0001070000000600ull) + ((offset) & 15) * 8)
+#define CVMX_CIU_NMI (CVMX_ADD_IO_SEG(0x0001070000000718ull))
+#define CVMX_CIU_PCI_INTA (CVMX_ADD_IO_SEG(0x0001070000000750ull))
+#define CVMX_CIU_PP_DBG (CVMX_ADD_IO_SEG(0x0001070000000708ull))
+#define CVMX_CIU_PP_POKEX(offset) (CVMX_ADD_IO_SEG(0x0001070000000580ull) + ((offset) & 15) * 8)
+#define CVMX_CIU_PP_RST (CVMX_ADD_IO_SEG(0x0001070000000700ull))
+#define CVMX_CIU_QLM0 (CVMX_ADD_IO_SEG(0x0001070000000780ull))
+#define CVMX_CIU_QLM1 (CVMX_ADD_IO_SEG(0x0001070000000788ull))
+#define CVMX_CIU_QLM2 (CVMX_ADD_IO_SEG(0x0001070000000790ull))
+#define CVMX_CIU_QLM_DCOK (CVMX_ADD_IO_SEG(0x0001070000000760ull))
+#define CVMX_CIU_QLM_JTGC (CVMX_ADD_IO_SEG(0x0001070000000768ull))
+#define CVMX_CIU_QLM_JTGD (CVMX_ADD_IO_SEG(0x0001070000000770ull))
+#define CVMX_CIU_SOFT_BIST (CVMX_ADD_IO_SEG(0x0001070000000738ull))
+#define CVMX_CIU_SOFT_PRST (CVMX_ADD_IO_SEG(0x0001070000000748ull))
+#define CVMX_CIU_SOFT_PRST1 (CVMX_ADD_IO_SEG(0x0001070000000758ull))
+#define CVMX_CIU_SOFT_RST (CVMX_ADD_IO_SEG(0x0001070000000740ull))
+#define CVMX_CIU_TIMX(offset) (CVMX_ADD_IO_SEG(0x0001070000000480ull) + ((offset) & 3) * 8)
+#define CVMX_CIU_WDOGX(offset) (CVMX_ADD_IO_SEG(0x0001070000000500ull) + ((offset) & 15) * 8)
 
 union cvmx_ciu_bist {
 	uint64_t u64;
 	struct cvmx_ciu_bist_s {
+		uint64_t reserved_5_63:59;
+		uint64_t bist:5;
+	} s;
+	struct cvmx_ciu_bist_cn30xx {
 		uint64_t reserved_4_63:60;
 		uint64_t bist:4;
-	} s;
-	struct cvmx_ciu_bist_s cn30xx;
-	struct cvmx_ciu_bist_s cn31xx;
-	struct cvmx_ciu_bist_s cn38xx;
-	struct cvmx_ciu_bist_s cn38xxp2;
+	} cn30xx;
+	struct cvmx_ciu_bist_cn30xx cn31xx;
+	struct cvmx_ciu_bist_cn30xx cn38xx;
+	struct cvmx_ciu_bist_cn30xx cn38xxp2;
 	struct cvmx_ciu_bist_cn50xx {
 		uint64_t reserved_2_63:62;
 		uint64_t bist:2;
@@ -118,10 +92,57 @@ union cvmx_ciu_bist {
 		uint64_t bist:3;
 	} cn52xx;
 	struct cvmx_ciu_bist_cn52xx cn52xxp1;
-	struct cvmx_ciu_bist_s cn56xx;
-	struct cvmx_ciu_bist_s cn56xxp1;
-	struct cvmx_ciu_bist_s cn58xx;
-	struct cvmx_ciu_bist_s cn58xxp1;
+	struct cvmx_ciu_bist_cn30xx cn56xx;
+	struct cvmx_ciu_bist_cn30xx cn56xxp1;
+	struct cvmx_ciu_bist_cn30xx cn58xx;
+	struct cvmx_ciu_bist_cn30xx cn58xxp1;
+	struct cvmx_ciu_bist_s cn63xx;
+	struct cvmx_ciu_bist_s cn63xxp1;
+};
+
+union cvmx_ciu_block_int {
+	uint64_t u64;
+	struct cvmx_ciu_block_int_s {
+		uint64_t reserved_43_63:21;
+		uint64_t ptp:1;
+		uint64_t dpi:1;
+		uint64_t dfm:1;
+		uint64_t reserved_34_39:6;
+		uint64_t srio1:1;
+		uint64_t srio0:1;
+		uint64_t reserved_31_31:1;
+		uint64_t iob:1;
+		uint64_t reserved_29_29:1;
+		uint64_t agl:1;
+		uint64_t reserved_27_27:1;
+		uint64_t pem1:1;
+		uint64_t pem0:1;
+		uint64_t reserved_23_24:2;
+		uint64_t asxpcs0:1;
+		uint64_t reserved_21_21:1;
+		uint64_t pip:1;
+		uint64_t reserved_18_19:2;
+		uint64_t lmc0:1;
+		uint64_t l2c:1;
+		uint64_t reserved_15_15:1;
+		uint64_t rad:1;
+		uint64_t usb:1;
+		uint64_t pow:1;
+		uint64_t tim:1;
+		uint64_t pko:1;
+		uint64_t ipd:1;
+		uint64_t reserved_8_8:1;
+		uint64_t zip:1;
+		uint64_t dfa:1;
+		uint64_t fpa:1;
+		uint64_t key:1;
+		uint64_t sli:1;
+		uint64_t reserved_2_2:1;
+		uint64_t gmx0:1;
+		uint64_t mio:1;
+	} s;
+	struct cvmx_ciu_block_int_s cn63xx;
+	struct cvmx_ciu_block_int_s cn63xxp1;
 };
 
 union cvmx_ciu_dint {
@@ -153,6 +174,11 @@ union cvmx_ciu_dint {
 	struct cvmx_ciu_dint_cn56xx cn56xxp1;
 	struct cvmx_ciu_dint_s cn58xx;
 	struct cvmx_ciu_dint_s cn58xxp1;
+	struct cvmx_ciu_dint_cn63xx {
+		uint64_t reserved_6_63:58;
+		uint64_t dint:6;
+	} cn63xx;
+	struct cvmx_ciu_dint_cn63xx cn63xxp1;
 };
 
 union cvmx_ciu_fuse {
@@ -184,6 +210,11 @@ union cvmx_ciu_fuse {
 	struct cvmx_ciu_fuse_cn56xx cn56xxp1;
 	struct cvmx_ciu_fuse_s cn58xx;
 	struct cvmx_ciu_fuse_s cn58xxp1;
+	struct cvmx_ciu_fuse_cn63xx {
+		uint64_t reserved_6_63:58;
+		uint64_t fuse:6;
+	} cn63xx;
+	struct cvmx_ciu_fuse_cn63xx cn63xxp1;
 };
 
 union cvmx_ciu_gstop {
@@ -203,6 +234,8 @@ union cvmx_ciu_gstop {
 	struct cvmx_ciu_gstop_s cn56xxp1;
 	struct cvmx_ciu_gstop_s cn58xx;
 	struct cvmx_ciu_gstop_s cn58xxp1;
+	struct cvmx_ciu_gstop_s cn63xx;
+	struct cvmx_ciu_gstop_s cn63xxp1;
 };
 
 union cvmx_ciu_intx_en0 {
@@ -343,6 +376,8 @@ union cvmx_ciu_intx_en0 {
 	struct cvmx_ciu_intx_en0_cn56xx cn56xxp1;
 	struct cvmx_ciu_intx_en0_cn38xx cn58xx;
 	struct cvmx_ciu_intx_en0_cn38xx cn58xxp1;
+	struct cvmx_ciu_intx_en0_cn52xx cn63xx;
+	struct cvmx_ciu_intx_en0_cn52xx cn63xxp1;
 };
 
 union cvmx_ciu_intx_en0_w1c {
@@ -412,6 +447,8 @@ union cvmx_ciu_intx_en0_w1c {
 		uint64_t gpio:16;
 		uint64_t workq:16;
 	} cn58xx;
+	struct cvmx_ciu_intx_en0_w1c_cn52xx cn63xx;
+	struct cvmx_ciu_intx_en0_w1c_cn52xx cn63xxp1;
 };
 
 union cvmx_ciu_intx_en0_w1s {
@@ -481,12 +518,42 @@ union cvmx_ciu_intx_en0_w1s {
 		uint64_t gpio:16;
 		uint64_t workq:16;
 	} cn58xx;
+	struct cvmx_ciu_intx_en0_w1s_cn52xx cn63xx;
+	struct cvmx_ciu_intx_en0_w1s_cn52xx cn63xxp1;
 };
 
 union cvmx_ciu_intx_en1 {
 	uint64_t u64;
 	struct cvmx_ciu_intx_en1_s {
-		uint64_t reserved_20_63:44;
+		uint64_t rst:1;
+		uint64_t reserved_57_62:6;
+		uint64_t dfm:1;
+		uint64_t reserved_53_55:3;
+		uint64_t lmc0:1;
+		uint64_t srio1:1;
+		uint64_t srio0:1;
+		uint64_t pem1:1;
+		uint64_t pem0:1;
+		uint64_t ptp:1;
+		uint64_t agl:1;
+		uint64_t reserved_37_45:9;
+		uint64_t agx0:1;
+		uint64_t dpi:1;
+		uint64_t sli:1;
+		uint64_t usb:1;
+		uint64_t dfa:1;
+		uint64_t key:1;
+		uint64_t rad:1;
+		uint64_t tim:1;
+		uint64_t zip:1;
+		uint64_t pko:1;
+		uint64_t pip:1;
+		uint64_t ipd:1;
+		uint64_t l2c:1;
+		uint64_t pow:1;
+		uint64_t fpa:1;
+		uint64_t iob:1;
+		uint64_t mio:1;
 		uint64_t nand:1;
 		uint64_t mii1:1;
 		uint64_t usb1:1;
@@ -531,12 +598,76 @@ union cvmx_ciu_intx_en1 {
 	struct cvmx_ciu_intx_en1_cn56xx cn56xxp1;
 	struct cvmx_ciu_intx_en1_cn38xx cn58xx;
 	struct cvmx_ciu_intx_en1_cn38xx cn58xxp1;
+	struct cvmx_ciu_intx_en1_cn63xx {
+		uint64_t rst:1;
+		uint64_t reserved_57_62:6;
+		uint64_t dfm:1;
+		uint64_t reserved_53_55:3;
+		uint64_t lmc0:1;
+		uint64_t srio1:1;
+		uint64_t srio0:1;
+		uint64_t pem1:1;
+		uint64_t pem0:1;
+		uint64_t ptp:1;
+		uint64_t agl:1;
+		uint64_t reserved_37_45:9;
+		uint64_t agx0:1;
+		uint64_t dpi:1;
+		uint64_t sli:1;
+		uint64_t usb:1;
+		uint64_t dfa:1;
+		uint64_t key:1;
+		uint64_t rad:1;
+		uint64_t tim:1;
+		uint64_t zip:1;
+		uint64_t pko:1;
+		uint64_t pip:1;
+		uint64_t ipd:1;
+		uint64_t l2c:1;
+		uint64_t pow:1;
+		uint64_t fpa:1;
+		uint64_t iob:1;
+		uint64_t mio:1;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t reserved_6_17:12;
+		uint64_t wdog:6;
+	} cn63xx;
+	struct cvmx_ciu_intx_en1_cn63xx cn63xxp1;
 };
 
 union cvmx_ciu_intx_en1_w1c {
 	uint64_t u64;
 	struct cvmx_ciu_intx_en1_w1c_s {
-		uint64_t reserved_20_63:44;
+		uint64_t rst:1;
+		uint64_t reserved_57_62:6;
+		uint64_t dfm:1;
+		uint64_t reserved_53_55:3;
+		uint64_t lmc0:1;
+		uint64_t srio1:1;
+		uint64_t srio0:1;
+		uint64_t pem1:1;
+		uint64_t pem0:1;
+		uint64_t ptp:1;
+		uint64_t agl:1;
+		uint64_t reserved_37_45:9;
+		uint64_t agx0:1;
+		uint64_t dpi:1;
+		uint64_t sli:1;
+		uint64_t usb:1;
+		uint64_t dfa:1;
+		uint64_t key:1;
+		uint64_t rad:1;
+		uint64_t tim:1;
+		uint64_t zip:1;
+		uint64_t pko:1;
+		uint64_t pip:1;
+		uint64_t ipd:1;
+		uint64_t l2c:1;
+		uint64_t pow:1;
+		uint64_t fpa:1;
+		uint64_t iob:1;
+		uint64_t mio:1;
 		uint64_t nand:1;
 		uint64_t mii1:1;
 		uint64_t usb1:1;
@@ -560,12 +691,76 @@ union cvmx_ciu_intx_en1_w1c {
 		uint64_t reserved_16_63:48;
 		uint64_t wdog:16;
 	} cn58xx;
+	struct cvmx_ciu_intx_en1_w1c_cn63xx {
+		uint64_t rst:1;
+		uint64_t reserved_57_62:6;
+		uint64_t dfm:1;
+		uint64_t reserved_53_55:3;
+		uint64_t lmc0:1;
+		uint64_t srio1:1;
+		uint64_t srio0:1;
+		uint64_t pem1:1;
+		uint64_t pem0:1;
+		uint64_t ptp:1;
+		uint64_t agl:1;
+		uint64_t reserved_37_45:9;
+		uint64_t agx0:1;
+		uint64_t dpi:1;
+		uint64_t sli:1;
+		uint64_t usb:1;
+		uint64_t dfa:1;
+		uint64_t key:1;
+		uint64_t rad:1;
+		uint64_t tim:1;
+		uint64_t zip:1;
+		uint64_t pko:1;
+		uint64_t pip:1;
+		uint64_t ipd:1;
+		uint64_t l2c:1;
+		uint64_t pow:1;
+		uint64_t fpa:1;
+		uint64_t iob:1;
+		uint64_t mio:1;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t reserved_6_17:12;
+		uint64_t wdog:6;
+	} cn63xx;
+	struct cvmx_ciu_intx_en1_w1c_cn63xx cn63xxp1;
 };
 
 union cvmx_ciu_intx_en1_w1s {
 	uint64_t u64;
 	struct cvmx_ciu_intx_en1_w1s_s {
-		uint64_t reserved_20_63:44;
+		uint64_t rst:1;
+		uint64_t reserved_57_62:6;
+		uint64_t dfm:1;
+		uint64_t reserved_53_55:3;
+		uint64_t lmc0:1;
+		uint64_t srio1:1;
+		uint64_t srio0:1;
+		uint64_t pem1:1;
+		uint64_t pem0:1;
+		uint64_t ptp:1;
+		uint64_t agl:1;
+		uint64_t reserved_37_45:9;
+		uint64_t agx0:1;
+		uint64_t dpi:1;
+		uint64_t sli:1;
+		uint64_t usb:1;
+		uint64_t dfa:1;
+		uint64_t key:1;
+		uint64_t rad:1;
+		uint64_t tim:1;
+		uint64_t zip:1;
+		uint64_t pko:1;
+		uint64_t pip:1;
+		uint64_t ipd:1;
+		uint64_t l2c:1;
+		uint64_t pow:1;
+		uint64_t fpa:1;
+		uint64_t iob:1;
+		uint64_t mio:1;
 		uint64_t nand:1;
 		uint64_t mii1:1;
 		uint64_t usb1:1;
@@ -589,6 +784,42 @@ union cvmx_ciu_intx_en1_w1s {
 		uint64_t reserved_16_63:48;
 		uint64_t wdog:16;
 	} cn58xx;
+	struct cvmx_ciu_intx_en1_w1s_cn63xx {
+		uint64_t rst:1;
+		uint64_t reserved_57_62:6;
+		uint64_t dfm:1;
+		uint64_t reserved_53_55:3;
+		uint64_t lmc0:1;
+		uint64_t srio1:1;
+		uint64_t srio0:1;
+		uint64_t pem1:1;
+		uint64_t pem0:1;
+		uint64_t ptp:1;
+		uint64_t agl:1;
+		uint64_t reserved_37_45:9;
+		uint64_t agx0:1;
+		uint64_t dpi:1;
+		uint64_t sli:1;
+		uint64_t usb:1;
+		uint64_t dfa:1;
+		uint64_t key:1;
+		uint64_t rad:1;
+		uint64_t tim:1;
+		uint64_t zip:1;
+		uint64_t pko:1;
+		uint64_t pip:1;
+		uint64_t ipd:1;
+		uint64_t l2c:1;
+		uint64_t pow:1;
+		uint64_t fpa:1;
+		uint64_t iob:1;
+		uint64_t mio:1;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t reserved_6_17:12;
+		uint64_t wdog:6;
+	} cn63xx;
+	struct cvmx_ciu_intx_en1_w1s_cn63xx cn63xxp1;
 };
 
 union cvmx_ciu_intx_en4_0 {
@@ -705,6 +936,8 @@ union cvmx_ciu_intx_en4_0 {
 		uint64_t workq:16;
 	} cn58xx;
 	struct cvmx_ciu_intx_en4_0_cn58xx cn58xxp1;
+	struct cvmx_ciu_intx_en4_0_cn52xx cn63xx;
+	struct cvmx_ciu_intx_en4_0_cn52xx cn63xxp1;
 };
 
 union cvmx_ciu_intx_en4_0_w1c {
@@ -774,6 +1007,8 @@ union cvmx_ciu_intx_en4_0_w1c {
 		uint64_t gpio:16;
 		uint64_t workq:16;
 	} cn58xx;
+	struct cvmx_ciu_intx_en4_0_w1c_cn52xx cn63xx;
+	struct cvmx_ciu_intx_en4_0_w1c_cn52xx cn63xxp1;
 };
 
 union cvmx_ciu_intx_en4_0_w1s {
@@ -843,12 +1078,42 @@ union cvmx_ciu_intx_en4_0_w1s {
 		uint64_t gpio:16;
 		uint64_t workq:16;
 	} cn58xx;
+	struct cvmx_ciu_intx_en4_0_w1s_cn52xx cn63xx;
+	struct cvmx_ciu_intx_en4_0_w1s_cn52xx cn63xxp1;
 };
 
 union cvmx_ciu_intx_en4_1 {
 	uint64_t u64;
 	struct cvmx_ciu_intx_en4_1_s {
-		uint64_t reserved_20_63:44;
+		uint64_t rst:1;
+		uint64_t reserved_57_62:6;
+		uint64_t dfm:1;
+		uint64_t reserved_53_55:3;
+		uint64_t lmc0:1;
+		uint64_t srio1:1;
+		uint64_t srio0:1;
+		uint64_t pem1:1;
+		uint64_t pem0:1;
+		uint64_t ptp:1;
+		uint64_t agl:1;
+		uint64_t reserved_37_45:9;
+		uint64_t agx0:1;
+		uint64_t dpi:1;
+		uint64_t sli:1;
+		uint64_t usb:1;
+		uint64_t dfa:1;
+		uint64_t key:1;
+		uint64_t rad:1;
+		uint64_t tim:1;
+		uint64_t zip:1;
+		uint64_t pko:1;
+		uint64_t pip:1;
+		uint64_t ipd:1;
+		uint64_t l2c:1;
+		uint64_t pow:1;
+		uint64_t fpa:1;
+		uint64_t iob:1;
+		uint64_t mio:1;
 		uint64_t nand:1;
 		uint64_t mii1:1;
 		uint64_t usb1:1;
@@ -886,12 +1151,76 @@ union cvmx_ciu_intx_en4_1 {
 		uint64_t wdog:16;
 	} cn58xx;
 	struct cvmx_ciu_intx_en4_1_cn58xx cn58xxp1;
+	struct cvmx_ciu_intx_en4_1_cn63xx {
+		uint64_t rst:1;
+		uint64_t reserved_57_62:6;
+		uint64_t dfm:1;
+		uint64_t reserved_53_55:3;
+		uint64_t lmc0:1;
+		uint64_t srio1:1;
+		uint64_t srio0:1;
+		uint64_t pem1:1;
+		uint64_t pem0:1;
+		uint64_t ptp:1;
+		uint64_t agl:1;
+		uint64_t reserved_37_45:9;
+		uint64_t agx0:1;
+		uint64_t dpi:1;
+		uint64_t sli:1;
+		uint64_t usb:1;
+		uint64_t dfa:1;
+		uint64_t key:1;
+		uint64_t rad:1;
+		uint64_t tim:1;
+		uint64_t zip:1;
+		uint64_t pko:1;
+		uint64_t pip:1;
+		uint64_t ipd:1;
+		uint64_t l2c:1;
+		uint64_t pow:1;
+		uint64_t fpa:1;
+		uint64_t iob:1;
+		uint64_t mio:1;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t reserved_6_17:12;
+		uint64_t wdog:6;
+	} cn63xx;
+	struct cvmx_ciu_intx_en4_1_cn63xx cn63xxp1;
 };
 
 union cvmx_ciu_intx_en4_1_w1c {
 	uint64_t u64;
 	struct cvmx_ciu_intx_en4_1_w1c_s {
-		uint64_t reserved_20_63:44;
+		uint64_t rst:1;
+		uint64_t reserved_57_62:6;
+		uint64_t dfm:1;
+		uint64_t reserved_53_55:3;
+		uint64_t lmc0:1;
+		uint64_t srio1:1;
+		uint64_t srio0:1;
+		uint64_t pem1:1;
+		uint64_t pem0:1;
+		uint64_t ptp:1;
+		uint64_t agl:1;
+		uint64_t reserved_37_45:9;
+		uint64_t agx0:1;
+		uint64_t dpi:1;
+		uint64_t sli:1;
+		uint64_t usb:1;
+		uint64_t dfa:1;
+		uint64_t key:1;
+		uint64_t rad:1;
+		uint64_t tim:1;
+		uint64_t zip:1;
+		uint64_t pko:1;
+		uint64_t pip:1;
+		uint64_t ipd:1;
+		uint64_t l2c:1;
+		uint64_t pow:1;
+		uint64_t fpa:1;
+		uint64_t iob:1;
+		uint64_t mio:1;
 		uint64_t nand:1;
 		uint64_t mii1:1;
 		uint64_t usb1:1;
@@ -915,12 +1244,76 @@ union cvmx_ciu_intx_en4_1_w1c {
 		uint64_t reserved_16_63:48;
 		uint64_t wdog:16;
 	} cn58xx;
+	struct cvmx_ciu_intx_en4_1_w1c_cn63xx {
+		uint64_t rst:1;
+		uint64_t reserved_57_62:6;
+		uint64_t dfm:1;
+		uint64_t reserved_53_55:3;
+		uint64_t lmc0:1;
+		uint64_t srio1:1;
+		uint64_t srio0:1;
+		uint64_t pem1:1;
+		uint64_t pem0:1;
+		uint64_t ptp:1;
+		uint64_t agl:1;
+		uint64_t reserved_37_45:9;
+		uint64_t agx0:1;
+		uint64_t dpi:1;
+		uint64_t sli:1;
+		uint64_t usb:1;
+		uint64_t dfa:1;
+		uint64_t key:1;
+		uint64_t rad:1;
+		uint64_t tim:1;
+		uint64_t zip:1;
+		uint64_t pko:1;
+		uint64_t pip:1;
+		uint64_t ipd:1;
+		uint64_t l2c:1;
+		uint64_t pow:1;
+		uint64_t fpa:1;
+		uint64_t iob:1;
+		uint64_t mio:1;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t reserved_6_17:12;
+		uint64_t wdog:6;
+	} cn63xx;
+	struct cvmx_ciu_intx_en4_1_w1c_cn63xx cn63xxp1;
 };
 
 union cvmx_ciu_intx_en4_1_w1s {
 	uint64_t u64;
 	struct cvmx_ciu_intx_en4_1_w1s_s {
-		uint64_t reserved_20_63:44;
+		uint64_t rst:1;
+		uint64_t reserved_57_62:6;
+		uint64_t dfm:1;
+		uint64_t reserved_53_55:3;
+		uint64_t lmc0:1;
+		uint64_t srio1:1;
+		uint64_t srio0:1;
+		uint64_t pem1:1;
+		uint64_t pem0:1;
+		uint64_t ptp:1;
+		uint64_t agl:1;
+		uint64_t reserved_37_45:9;
+		uint64_t agx0:1;
+		uint64_t dpi:1;
+		uint64_t sli:1;
+		uint64_t usb:1;
+		uint64_t dfa:1;
+		uint64_t key:1;
+		uint64_t rad:1;
+		uint64_t tim:1;
+		uint64_t zip:1;
+		uint64_t pko:1;
+		uint64_t pip:1;
+		uint64_t ipd:1;
+		uint64_t l2c:1;
+		uint64_t pow:1;
+		uint64_t fpa:1;
+		uint64_t iob:1;
+		uint64_t mio:1;
 		uint64_t nand:1;
 		uint64_t mii1:1;
 		uint64_t usb1:1;
@@ -944,6 +1337,42 @@ union cvmx_ciu_intx_en4_1_w1s {
 		uint64_t reserved_16_63:48;
 		uint64_t wdog:16;
 	} cn58xx;
+	struct cvmx_ciu_intx_en4_1_w1s_cn63xx {
+		uint64_t rst:1;
+		uint64_t reserved_57_62:6;
+		uint64_t dfm:1;
+		uint64_t reserved_53_55:3;
+		uint64_t lmc0:1;
+		uint64_t srio1:1;
+		uint64_t srio0:1;
+		uint64_t pem1:1;
+		uint64_t pem0:1;
+		uint64_t ptp:1;
+		uint64_t agl:1;
+		uint64_t reserved_37_45:9;
+		uint64_t agx0:1;
+		uint64_t dpi:1;
+		uint64_t sli:1;
+		uint64_t usb:1;
+		uint64_t dfa:1;
+		uint64_t key:1;
+		uint64_t rad:1;
+		uint64_t tim:1;
+		uint64_t zip:1;
+		uint64_t pko:1;
+		uint64_t pip:1;
+		uint64_t ipd:1;
+		uint64_t l2c:1;
+		uint64_t pow:1;
+		uint64_t fpa:1;
+		uint64_t iob:1;
+		uint64_t mio:1;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t reserved_6_17:12;
+		uint64_t wdog:6;
+	} cn63xx;
+	struct cvmx_ciu_intx_en4_1_w1s_cn63xx cn63xxp1;
 };
 
 union cvmx_ciu_intx_sum0 {
@@ -1084,6 +1513,8 @@ union cvmx_ciu_intx_sum0 {
 	struct cvmx_ciu_intx_sum0_cn56xx cn56xxp1;
 	struct cvmx_ciu_intx_sum0_cn38xx cn58xx;
 	struct cvmx_ciu_intx_sum0_cn38xx cn58xxp1;
+	struct cvmx_ciu_intx_sum0_cn52xx cn63xx;
+	struct cvmx_ciu_intx_sum0_cn52xx cn63xxp1;
 };
 
 union cvmx_ciu_intx_sum4 {
@@ -1200,12 +1631,85 @@ union cvmx_ciu_intx_sum4 {
 		uint64_t workq:16;
 	} cn58xx;
 	struct cvmx_ciu_intx_sum4_cn58xx cn58xxp1;
+	struct cvmx_ciu_intx_sum4_cn52xx cn63xx;
+	struct cvmx_ciu_intx_sum4_cn52xx cn63xxp1;
+};
+
+union cvmx_ciu_int33_sum0 {
+	uint64_t u64;
+	struct cvmx_ciu_int33_sum0_s {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t reserved_57_58:2;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t reserved_51_51:1;
+		uint64_t ipd_drp:1;
+		uint64_t reserved_49_49:1;
+		uint64_t gmx_drp:1;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t wdog_sum:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} s;
+	struct cvmx_ciu_int33_sum0_s cn63xx;
+	struct cvmx_ciu_int33_sum0_s cn63xxp1;
+};
+
+union cvmx_ciu_int_dbg_sel {
+	uint64_t u64;
+	struct cvmx_ciu_int_dbg_sel_s {
+		uint64_t reserved_19_63:45;
+		uint64_t sel:3;
+		uint64_t reserved_10_15:6;
+		uint64_t irq:2;
+		uint64_t reserved_3_7:5;
+		uint64_t pp:3;
+	} s;
+	struct cvmx_ciu_int_dbg_sel_s cn63xx;
 };
 
 union cvmx_ciu_int_sum1 {
 	uint64_t u64;
 	struct cvmx_ciu_int_sum1_s {
-		uint64_t reserved_20_63:44;
+		uint64_t rst:1;
+		uint64_t reserved_57_62:6;
+		uint64_t dfm:1;
+		uint64_t reserved_53_55:3;
+		uint64_t lmc0:1;
+		uint64_t srio1:1;
+		uint64_t srio0:1;
+		uint64_t pem1:1;
+		uint64_t pem0:1;
+		uint64_t ptp:1;
+		uint64_t agl:1;
+		uint64_t reserved_37_45:9;
+		uint64_t agx0:1;
+		uint64_t dpi:1;
+		uint64_t sli:1;
+		uint64_t usb:1;
+		uint64_t dfa:1;
+		uint64_t key:1;
+		uint64_t rad:1;
+		uint64_t tim:1;
+		uint64_t zip:1;
+		uint64_t pko:1;
+		uint64_t pip:1;
+		uint64_t ipd:1;
+		uint64_t l2c:1;
+		uint64_t pow:1;
+		uint64_t fpa:1;
+		uint64_t iob:1;
+		uint64_t mio:1;
 		uint64_t nand:1;
 		uint64_t mii1:1;
 		uint64_t usb1:1;
@@ -1250,6 +1754,42 @@ union cvmx_ciu_int_sum1 {
 	struct cvmx_ciu_int_sum1_cn56xx cn56xxp1;
 	struct cvmx_ciu_int_sum1_cn38xx cn58xx;
 	struct cvmx_ciu_int_sum1_cn38xx cn58xxp1;
+	struct cvmx_ciu_int_sum1_cn63xx {
+		uint64_t rst:1;
+		uint64_t reserved_57_62:6;
+		uint64_t dfm:1;
+		uint64_t reserved_53_55:3;
+		uint64_t lmc0:1;
+		uint64_t srio1:1;
+		uint64_t srio0:1;
+		uint64_t pem1:1;
+		uint64_t pem0:1;
+		uint64_t ptp:1;
+		uint64_t agl:1;
+		uint64_t reserved_37_45:9;
+		uint64_t agx0:1;
+		uint64_t dpi:1;
+		uint64_t sli:1;
+		uint64_t usb:1;
+		uint64_t dfa:1;
+		uint64_t key:1;
+		uint64_t rad:1;
+		uint64_t tim:1;
+		uint64_t zip:1;
+		uint64_t pko:1;
+		uint64_t pip:1;
+		uint64_t ipd:1;
+		uint64_t l2c:1;
+		uint64_t pow:1;
+		uint64_t fpa:1;
+		uint64_t iob:1;
+		uint64_t mio:1;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t reserved_6_17:12;
+		uint64_t wdog:6;
+	} cn63xx;
+	struct cvmx_ciu_int_sum1_cn63xx cn63xxp1;
 };
 
 union cvmx_ciu_mbox_clrx {
@@ -1269,6 +1809,8 @@ union cvmx_ciu_mbox_clrx {
 	struct cvmx_ciu_mbox_clrx_s cn56xxp1;
 	struct cvmx_ciu_mbox_clrx_s cn58xx;
 	struct cvmx_ciu_mbox_clrx_s cn58xxp1;
+	struct cvmx_ciu_mbox_clrx_s cn63xx;
+	struct cvmx_ciu_mbox_clrx_s cn63xxp1;
 };
 
 union cvmx_ciu_mbox_setx {
@@ -1288,6 +1830,8 @@ union cvmx_ciu_mbox_setx {
 	struct cvmx_ciu_mbox_setx_s cn56xxp1;
 	struct cvmx_ciu_mbox_setx_s cn58xx;
 	struct cvmx_ciu_mbox_setx_s cn58xxp1;
+	struct cvmx_ciu_mbox_setx_s cn63xx;
+	struct cvmx_ciu_mbox_setx_s cn63xxp1;
 };
 
 union cvmx_ciu_nmi {
@@ -1319,6 +1863,11 @@ union cvmx_ciu_nmi {
 	struct cvmx_ciu_nmi_cn56xx cn56xxp1;
 	struct cvmx_ciu_nmi_s cn58xx;
 	struct cvmx_ciu_nmi_s cn58xxp1;
+	struct cvmx_ciu_nmi_cn63xx {
+		uint64_t reserved_6_63:58;
+		uint64_t nmi:6;
+	} cn63xx;
+	struct cvmx_ciu_nmi_cn63xx cn63xxp1;
 };
 
 union cvmx_ciu_pci_inta {
@@ -1338,6 +1887,8 @@ union cvmx_ciu_pci_inta {
 	struct cvmx_ciu_pci_inta_s cn56xxp1;
 	struct cvmx_ciu_pci_inta_s cn58xx;
 	struct cvmx_ciu_pci_inta_s cn58xxp1;
+	struct cvmx_ciu_pci_inta_s cn63xx;
+	struct cvmx_ciu_pci_inta_s cn63xxp1;
 };
 
 union cvmx_ciu_pp_dbg {
@@ -1369,12 +1920,17 @@ union cvmx_ciu_pp_dbg {
 	struct cvmx_ciu_pp_dbg_cn56xx cn56xxp1;
 	struct cvmx_ciu_pp_dbg_s cn58xx;
 	struct cvmx_ciu_pp_dbg_s cn58xxp1;
+	struct cvmx_ciu_pp_dbg_cn63xx {
+		uint64_t reserved_6_63:58;
+		uint64_t ppdbg:6;
+	} cn63xx;
+	struct cvmx_ciu_pp_dbg_cn63xx cn63xxp1;
 };
 
 union cvmx_ciu_pp_pokex {
 	uint64_t u64;
 	struct cvmx_ciu_pp_pokex_s {
-		uint64_t reserved_0_63:64;
+		uint64_t poke:64;
 	} s;
 	struct cvmx_ciu_pp_pokex_s cn30xx;
 	struct cvmx_ciu_pp_pokex_s cn31xx;
@@ -1387,6 +1943,8 @@ union cvmx_ciu_pp_pokex {
 	struct cvmx_ciu_pp_pokex_s cn56xxp1;
 	struct cvmx_ciu_pp_pokex_s cn58xx;
 	struct cvmx_ciu_pp_pokex_s cn58xxp1;
+	struct cvmx_ciu_pp_pokex_s cn63xx;
+	struct cvmx_ciu_pp_pokex_s cn63xxp1;
 };
 
 union cvmx_ciu_pp_rst {
@@ -1422,6 +1980,97 @@ union cvmx_ciu_pp_rst {
 	struct cvmx_ciu_pp_rst_cn56xx cn56xxp1;
 	struct cvmx_ciu_pp_rst_s cn58xx;
 	struct cvmx_ciu_pp_rst_s cn58xxp1;
+	struct cvmx_ciu_pp_rst_cn63xx {
+		uint64_t reserved_6_63:58;
+		uint64_t rst:5;
+		uint64_t rst0:1;
+	} cn63xx;
+	struct cvmx_ciu_pp_rst_cn63xx cn63xxp1;
+};
+
+union cvmx_ciu_qlm0 {
+	uint64_t u64;
+	struct cvmx_ciu_qlm0_s {
+		uint64_t g2bypass:1;
+		uint64_t reserved_53_62:10;
+		uint64_t g2deemph:5;
+		uint64_t reserved_45_47:3;
+		uint64_t g2margin:5;
+		uint64_t reserved_32_39:8;
+		uint64_t txbypass:1;
+		uint64_t reserved_21_30:10;
+		uint64_t txdeemph:5;
+		uint64_t reserved_13_15:3;
+		uint64_t txmargin:5;
+		uint64_t reserved_4_7:4;
+		uint64_t lane_en:4;
+	} s;
+	struct cvmx_ciu_qlm0_s cn63xx;
+	struct cvmx_ciu_qlm0_cn63xxp1 {
+		uint64_t reserved_32_63:32;
+		uint64_t txbypass:1;
+		uint64_t reserved_20_30:11;
+		uint64_t txdeemph:4;
+		uint64_t reserved_13_15:3;
+		uint64_t txmargin:5;
+		uint64_t reserved_4_7:4;
+		uint64_t lane_en:4;
+	} cn63xxp1;
+};
+
+union cvmx_ciu_qlm1 {
+	uint64_t u64;
+	struct cvmx_ciu_qlm1_s {
+		uint64_t g2bypass:1;
+		uint64_t reserved_53_62:10;
+		uint64_t g2deemph:5;
+		uint64_t reserved_45_47:3;
+		uint64_t g2margin:5;
+		uint64_t reserved_32_39:8;
+		uint64_t txbypass:1;
+		uint64_t reserved_21_30:10;
+		uint64_t txdeemph:5;
+		uint64_t reserved_13_15:3;
+		uint64_t txmargin:5;
+		uint64_t reserved_4_7:4;
+		uint64_t lane_en:4;
+	} s;
+	struct cvmx_ciu_qlm1_s cn63xx;
+	struct cvmx_ciu_qlm1_cn63xxp1 {
+		uint64_t reserved_32_63:32;
+		uint64_t txbypass:1;
+		uint64_t reserved_20_30:11;
+		uint64_t txdeemph:4;
+		uint64_t reserved_13_15:3;
+		uint64_t txmargin:5;
+		uint64_t reserved_4_7:4;
+		uint64_t lane_en:4;
+	} cn63xxp1;
+};
+
+union cvmx_ciu_qlm2 {
+	uint64_t u64;
+	struct cvmx_ciu_qlm2_s {
+		uint64_t reserved_32_63:32;
+		uint64_t txbypass:1;
+		uint64_t reserved_21_30:10;
+		uint64_t txdeemph:5;
+		uint64_t reserved_13_15:3;
+		uint64_t txmargin:5;
+		uint64_t reserved_4_7:4;
+		uint64_t lane_en:4;
+	} s;
+	struct cvmx_ciu_qlm2_s cn63xx;
+	struct cvmx_ciu_qlm2_cn63xxp1 {
+		uint64_t reserved_32_63:32;
+		uint64_t txbypass:1;
+		uint64_t reserved_20_30:11;
+		uint64_t txdeemph:4;
+		uint64_t reserved_13_15:3;
+		uint64_t txmargin:5;
+		uint64_t reserved_4_7:4;
+		uint64_t lane_en:4;
+	} cn63xxp1;
 };
 
 union cvmx_ciu_qlm_dcok {
@@ -1459,6 +2108,15 @@ union cvmx_ciu_qlm_jtgc {
 	struct cvmx_ciu_qlm_jtgc_cn52xx cn52xxp1;
 	struct cvmx_ciu_qlm_jtgc_s cn56xx;
 	struct cvmx_ciu_qlm_jtgc_s cn56xxp1;
+	struct cvmx_ciu_qlm_jtgc_cn63xx {
+		uint64_t reserved_11_63:53;
+		uint64_t clk_div:3;
+		uint64_t reserved_6_7:2;
+		uint64_t mux_sel:2;
+		uint64_t reserved_3_3:1;
+		uint64_t bypass:3;
+	} cn63xx;
+	struct cvmx_ciu_qlm_jtgc_cn63xx cn63xxp1;
 };
 
 union cvmx_ciu_qlm_jtgd {
@@ -1493,6 +2151,17 @@ union cvmx_ciu_qlm_jtgd {
 		uint64_t shft_cnt:5;
 		uint64_t shft_reg:32;
 	} cn56xxp1;
+	struct cvmx_ciu_qlm_jtgd_cn63xx {
+		uint64_t capture:1;
+		uint64_t shift:1;
+		uint64_t update:1;
+		uint64_t reserved_43_60:18;
+		uint64_t select:3;
+		uint64_t reserved_37_39:3;
+		uint64_t shft_cnt:5;
+		uint64_t shft_reg:32;
+	} cn63xx;
+	struct cvmx_ciu_qlm_jtgd_cn63xx cn63xxp1;
 };
 
 union cvmx_ciu_soft_bist {
@@ -1512,6 +2181,8 @@ union cvmx_ciu_soft_bist {
 	struct cvmx_ciu_soft_bist_s cn56xxp1;
 	struct cvmx_ciu_soft_bist_s cn58xx;
 	struct cvmx_ciu_soft_bist_s cn58xxp1;
+	struct cvmx_ciu_soft_bist_s cn63xx;
+	struct cvmx_ciu_soft_bist_s cn63xxp1;
 };
 
 union cvmx_ciu_soft_prst {
@@ -1536,6 +2207,8 @@ union cvmx_ciu_soft_prst {
 	struct cvmx_ciu_soft_prst_cn52xx cn56xxp1;
 	struct cvmx_ciu_soft_prst_s cn58xx;
 	struct cvmx_ciu_soft_prst_s cn58xxp1;
+	struct cvmx_ciu_soft_prst_cn52xx cn63xx;
+	struct cvmx_ciu_soft_prst_cn52xx cn63xxp1;
 };
 
 union cvmx_ciu_soft_prst1 {
@@ -1548,6 +2221,8 @@ union cvmx_ciu_soft_prst1 {
 	struct cvmx_ciu_soft_prst1_s cn52xxp1;
 	struct cvmx_ciu_soft_prst1_s cn56xx;
 	struct cvmx_ciu_soft_prst1_s cn56xxp1;
+	struct cvmx_ciu_soft_prst1_s cn63xx;
+	struct cvmx_ciu_soft_prst1_s cn63xxp1;
 };
 
 union cvmx_ciu_soft_rst {
@@ -1567,6 +2242,8 @@ union cvmx_ciu_soft_rst {
 	struct cvmx_ciu_soft_rst_s cn56xxp1;
 	struct cvmx_ciu_soft_rst_s cn58xx;
 	struct cvmx_ciu_soft_rst_s cn58xxp1;
+	struct cvmx_ciu_soft_rst_s cn63xx;
+	struct cvmx_ciu_soft_rst_s cn63xxp1;
 };
 
 union cvmx_ciu_timx {
@@ -1587,6 +2264,8 @@ union cvmx_ciu_timx {
 	struct cvmx_ciu_timx_s cn56xxp1;
 	struct cvmx_ciu_timx_s cn58xx;
 	struct cvmx_ciu_timx_s cn58xxp1;
+	struct cvmx_ciu_timx_s cn63xx;
+	struct cvmx_ciu_timx_s cn63xxp1;
 };
 
 union cvmx_ciu_wdogx {
@@ -1611,6 +2290,8 @@ union cvmx_ciu_wdogx {
 	struct cvmx_ciu_wdogx_s cn56xxp1;
 	struct cvmx_ciu_wdogx_s cn58xx;
 	struct cvmx_ciu_wdogx_s cn58xxp1;
+	struct cvmx_ciu_wdogx_s cn63xx;
+	struct cvmx_ciu_wdogx_s cn63xxp1;
 };
 
 #endif
diff --git a/arch/mips/include/asm/octeon/cvmx-gpio-defs.h b/arch/mips/include/asm/octeon/cvmx-gpio-defs.h
index 5fdd6ba..395564e 100644
--- a/arch/mips/include/asm/octeon/cvmx-gpio-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-gpio-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2010 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -28,29 +28,22 @@
 #ifndef __CVMX_GPIO_DEFS_H__
 #define __CVMX_GPIO_DEFS_H__
 
-#define CVMX_GPIO_BIT_CFGX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000000800ull + (((offset) & 15) * 8))
-#define CVMX_GPIO_BOOT_ENA \
-	 CVMX_ADD_IO_SEG(0x00010700000008A8ull)
-#define CVMX_GPIO_CLK_GENX(offset) \
-	 CVMX_ADD_IO_SEG(0x00010700000008C0ull + (((offset) & 3) * 8))
-#define CVMX_GPIO_DBG_ENA \
-	 CVMX_ADD_IO_SEG(0x00010700000008A0ull)
-#define CVMX_GPIO_INT_CLR \
-	 CVMX_ADD_IO_SEG(0x0001070000000898ull)
-#define CVMX_GPIO_RX_DAT \
-	 CVMX_ADD_IO_SEG(0x0001070000000880ull)
-#define CVMX_GPIO_TX_CLR \
-	 CVMX_ADD_IO_SEG(0x0001070000000890ull)
-#define CVMX_GPIO_TX_SET \
-	 CVMX_ADD_IO_SEG(0x0001070000000888ull)
-#define CVMX_GPIO_XBIT_CFGX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000000900ull + (((offset) & 31) * 8) - 8 * 16)
+#define CVMX_GPIO_BIT_CFGX(offset) (CVMX_ADD_IO_SEG(0x0001070000000800ull) + ((offset) & 15) * 8)
+#define CVMX_GPIO_BOOT_ENA (CVMX_ADD_IO_SEG(0x00010700000008A8ull))
+#define CVMX_GPIO_CLK_GENX(offset) (CVMX_ADD_IO_SEG(0x00010700000008C0ull) + ((offset) & 3) * 8)
+#define CVMX_GPIO_CLK_QLMX(offset) (CVMX_ADD_IO_SEG(0x00010700000008E0ull) + ((offset) & 1) * 8)
+#define CVMX_GPIO_DBG_ENA (CVMX_ADD_IO_SEG(0x00010700000008A0ull))
+#define CVMX_GPIO_INT_CLR (CVMX_ADD_IO_SEG(0x0001070000000898ull))
+#define CVMX_GPIO_RX_DAT (CVMX_ADD_IO_SEG(0x0001070000000880ull))
+#define CVMX_GPIO_TX_CLR (CVMX_ADD_IO_SEG(0x0001070000000890ull))
+#define CVMX_GPIO_TX_SET (CVMX_ADD_IO_SEG(0x0001070000000888ull))
+#define CVMX_GPIO_XBIT_CFGX(offset) (CVMX_ADD_IO_SEG(0x0001070000000900ull) + ((offset) & 31) * 8 - 8*16)
 
 union cvmx_gpio_bit_cfgx {
 	uint64_t u64;
 	struct cvmx_gpio_bit_cfgx_s {
-		uint64_t reserved_15_63:49;
+		uint64_t reserved_17_63:47;
+		uint64_t synce_sel:2;
 		uint64_t clk_gen:1;
 		uint64_t clk_sel:2;
 		uint64_t fil_sel:4;
@@ -73,12 +66,24 @@ union cvmx_gpio_bit_cfgx {
 	struct cvmx_gpio_bit_cfgx_cn30xx cn38xx;
 	struct cvmx_gpio_bit_cfgx_cn30xx cn38xxp2;
 	struct cvmx_gpio_bit_cfgx_cn30xx cn50xx;
-	struct cvmx_gpio_bit_cfgx_s cn52xx;
-	struct cvmx_gpio_bit_cfgx_s cn52xxp1;
-	struct cvmx_gpio_bit_cfgx_s cn56xx;
-	struct cvmx_gpio_bit_cfgx_s cn56xxp1;
+	struct cvmx_gpio_bit_cfgx_cn52xx {
+		uint64_t reserved_15_63:49;
+		uint64_t clk_gen:1;
+		uint64_t clk_sel:2;
+		uint64_t fil_sel:4;
+		uint64_t fil_cnt:4;
+		uint64_t int_type:1;
+		uint64_t int_en:1;
+		uint64_t rx_xor:1;
+		uint64_t tx_oe:1;
+	} cn52xx;
+	struct cvmx_gpio_bit_cfgx_cn52xx cn52xxp1;
+	struct cvmx_gpio_bit_cfgx_cn52xx cn56xx;
+	struct cvmx_gpio_bit_cfgx_cn52xx cn56xxp1;
 	struct cvmx_gpio_bit_cfgx_cn30xx cn58xx;
 	struct cvmx_gpio_bit_cfgx_cn30xx cn58xxp1;
+	struct cvmx_gpio_bit_cfgx_s cn63xx;
+	struct cvmx_gpio_bit_cfgx_s cn63xxp1;
 };
 
 union cvmx_gpio_boot_ena {
@@ -103,6 +108,19 @@ union cvmx_gpio_clk_genx {
 	struct cvmx_gpio_clk_genx_s cn52xxp1;
 	struct cvmx_gpio_clk_genx_s cn56xx;
 	struct cvmx_gpio_clk_genx_s cn56xxp1;
+	struct cvmx_gpio_clk_genx_s cn63xx;
+	struct cvmx_gpio_clk_genx_s cn63xxp1;
+};
+
+union cvmx_gpio_clk_qlmx {
+	uint64_t u64;
+	struct cvmx_gpio_clk_qlmx_s {
+		uint64_t reserved_3_63:61;
+		uint64_t div:1;
+		uint64_t lane_sel:2;
+	} s;
+	struct cvmx_gpio_clk_qlmx_s cn63xx;
+	struct cvmx_gpio_clk_qlmx_s cn63xxp1;
 };
 
 union cvmx_gpio_dbg_ena {
@@ -133,6 +151,8 @@ union cvmx_gpio_int_clr {
 	struct cvmx_gpio_int_clr_s cn56xxp1;
 	struct cvmx_gpio_int_clr_s cn58xx;
 	struct cvmx_gpio_int_clr_s cn58xxp1;
+	struct cvmx_gpio_int_clr_s cn63xx;
+	struct cvmx_gpio_int_clr_s cn63xxp1;
 };
 
 union cvmx_gpio_rx_dat {
@@ -155,6 +175,8 @@ union cvmx_gpio_rx_dat {
 	struct cvmx_gpio_rx_dat_cn38xx cn56xxp1;
 	struct cvmx_gpio_rx_dat_cn38xx cn58xx;
 	struct cvmx_gpio_rx_dat_cn38xx cn58xxp1;
+	struct cvmx_gpio_rx_dat_cn38xx cn63xx;
+	struct cvmx_gpio_rx_dat_cn38xx cn63xxp1;
 };
 
 union cvmx_gpio_tx_clr {
@@ -177,6 +199,8 @@ union cvmx_gpio_tx_clr {
 	struct cvmx_gpio_tx_clr_cn38xx cn56xxp1;
 	struct cvmx_gpio_tx_clr_cn38xx cn58xx;
 	struct cvmx_gpio_tx_clr_cn38xx cn58xxp1;
+	struct cvmx_gpio_tx_clr_cn38xx cn63xx;
+	struct cvmx_gpio_tx_clr_cn38xx cn63xxp1;
 };
 
 union cvmx_gpio_tx_set {
@@ -199,6 +223,8 @@ union cvmx_gpio_tx_set {
 	struct cvmx_gpio_tx_set_cn38xx cn56xxp1;
 	struct cvmx_gpio_tx_set_cn38xx cn58xx;
 	struct cvmx_gpio_tx_set_cn38xx cn58xxp1;
+	struct cvmx_gpio_tx_set_cn38xx cn63xx;
+	struct cvmx_gpio_tx_set_cn38xx cn63xxp1;
 };
 
 union cvmx_gpio_xbit_cfgx {
diff --git a/arch/mips/include/asm/octeon/cvmx-iob-defs.h b/arch/mips/include/asm/octeon/cvmx-iob-defs.h
index 0ee36ba..d7d856c 100644
--- a/arch/mips/include/asm/octeon/cvmx-iob-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-iob-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2010 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -28,55 +28,39 @@
 #ifndef __CVMX_IOB_DEFS_H__
 #define __CVMX_IOB_DEFS_H__
 
-#define CVMX_IOB_BIST_STATUS \
-	 CVMX_ADD_IO_SEG(0x00011800F00007F8ull)
-#define CVMX_IOB_CTL_STATUS \
-	 CVMX_ADD_IO_SEG(0x00011800F0000050ull)
-#define CVMX_IOB_DWB_PRI_CNT \
-	 CVMX_ADD_IO_SEG(0x00011800F0000028ull)
-#define CVMX_IOB_FAU_TIMEOUT \
-	 CVMX_ADD_IO_SEG(0x00011800F0000000ull)
-#define CVMX_IOB_I2C_PRI_CNT \
-	 CVMX_ADD_IO_SEG(0x00011800F0000010ull)
-#define CVMX_IOB_INB_CONTROL_MATCH \
-	 CVMX_ADD_IO_SEG(0x00011800F0000078ull)
-#define CVMX_IOB_INB_CONTROL_MATCH_ENB \
-	 CVMX_ADD_IO_SEG(0x00011800F0000088ull)
-#define CVMX_IOB_INB_DATA_MATCH \
-	 CVMX_ADD_IO_SEG(0x00011800F0000070ull)
-#define CVMX_IOB_INB_DATA_MATCH_ENB \
-	 CVMX_ADD_IO_SEG(0x00011800F0000080ull)
-#define CVMX_IOB_INT_ENB \
-	 CVMX_ADD_IO_SEG(0x00011800F0000060ull)
-#define CVMX_IOB_INT_SUM \
-	 CVMX_ADD_IO_SEG(0x00011800F0000058ull)
-#define CVMX_IOB_N2C_L2C_PRI_CNT \
-	 CVMX_ADD_IO_SEG(0x00011800F0000020ull)
-#define CVMX_IOB_N2C_RSP_PRI_CNT \
-	 CVMX_ADD_IO_SEG(0x00011800F0000008ull)
-#define CVMX_IOB_OUTB_COM_PRI_CNT \
-	 CVMX_ADD_IO_SEG(0x00011800F0000040ull)
-#define CVMX_IOB_OUTB_CONTROL_MATCH \
-	 CVMX_ADD_IO_SEG(0x00011800F0000098ull)
-#define CVMX_IOB_OUTB_CONTROL_MATCH_ENB \
-	 CVMX_ADD_IO_SEG(0x00011800F00000A8ull)
-#define CVMX_IOB_OUTB_DATA_MATCH \
-	 CVMX_ADD_IO_SEG(0x00011800F0000090ull)
-#define CVMX_IOB_OUTB_DATA_MATCH_ENB \
-	 CVMX_ADD_IO_SEG(0x00011800F00000A0ull)
-#define CVMX_IOB_OUTB_FPA_PRI_CNT \
-	 CVMX_ADD_IO_SEG(0x00011800F0000048ull)
-#define CVMX_IOB_OUTB_REQ_PRI_CNT \
-	 CVMX_ADD_IO_SEG(0x00011800F0000038ull)
-#define CVMX_IOB_P2C_REQ_PRI_CNT \
-	 CVMX_ADD_IO_SEG(0x00011800F0000018ull)
-#define CVMX_IOB_PKT_ERR \
-	 CVMX_ADD_IO_SEG(0x00011800F0000068ull)
+#define CVMX_IOB_BIST_STATUS (CVMX_ADD_IO_SEG(0x00011800F00007F8ull))
+#define CVMX_IOB_CTL_STATUS (CVMX_ADD_IO_SEG(0x00011800F0000050ull))
+#define CVMX_IOB_DWB_PRI_CNT (CVMX_ADD_IO_SEG(0x00011800F0000028ull))
+#define CVMX_IOB_FAU_TIMEOUT (CVMX_ADD_IO_SEG(0x00011800F0000000ull))
+#define CVMX_IOB_I2C_PRI_CNT (CVMX_ADD_IO_SEG(0x00011800F0000010ull))
+#define CVMX_IOB_INB_CONTROL_MATCH (CVMX_ADD_IO_SEG(0x00011800F0000078ull))
+#define CVMX_IOB_INB_CONTROL_MATCH_ENB (CVMX_ADD_IO_SEG(0x00011800F0000088ull))
+#define CVMX_IOB_INB_DATA_MATCH (CVMX_ADD_IO_SEG(0x00011800F0000070ull))
+#define CVMX_IOB_INB_DATA_MATCH_ENB (CVMX_ADD_IO_SEG(0x00011800F0000080ull))
+#define CVMX_IOB_INT_ENB (CVMX_ADD_IO_SEG(0x00011800F0000060ull))
+#define CVMX_IOB_INT_SUM (CVMX_ADD_IO_SEG(0x00011800F0000058ull))
+#define CVMX_IOB_N2C_L2C_PRI_CNT (CVMX_ADD_IO_SEG(0x00011800F0000020ull))
+#define CVMX_IOB_N2C_RSP_PRI_CNT (CVMX_ADD_IO_SEG(0x00011800F0000008ull))
+#define CVMX_IOB_OUTB_COM_PRI_CNT (CVMX_ADD_IO_SEG(0x00011800F0000040ull))
+#define CVMX_IOB_OUTB_CONTROL_MATCH (CVMX_ADD_IO_SEG(0x00011800F0000098ull))
+#define CVMX_IOB_OUTB_CONTROL_MATCH_ENB (CVMX_ADD_IO_SEG(0x00011800F00000A8ull))
+#define CVMX_IOB_OUTB_DATA_MATCH (CVMX_ADD_IO_SEG(0x00011800F0000090ull))
+#define CVMX_IOB_OUTB_DATA_MATCH_ENB (CVMX_ADD_IO_SEG(0x00011800F00000A0ull))
+#define CVMX_IOB_OUTB_FPA_PRI_CNT (CVMX_ADD_IO_SEG(0x00011800F0000048ull))
+#define CVMX_IOB_OUTB_REQ_PRI_CNT (CVMX_ADD_IO_SEG(0x00011800F0000038ull))
+#define CVMX_IOB_P2C_REQ_PRI_CNT (CVMX_ADD_IO_SEG(0x00011800F0000018ull))
+#define CVMX_IOB_PKT_ERR (CVMX_ADD_IO_SEG(0x00011800F0000068ull))
+#define CVMX_IOB_TO_CMB_CREDITS (CVMX_ADD_IO_SEG(0x00011800F00000B0ull))
 
 union cvmx_iob_bist_status {
 	uint64_t u64;
 	struct cvmx_iob_bist_status_s {
-		uint64_t reserved_18_63:46;
+		uint64_t reserved_23_63:41;
+		uint64_t xmdfif:1;
+		uint64_t xmcfif:1;
+		uint64_t iorfif:1;
+		uint64_t rsdfif:1;
+		uint64_t iocfif:1;
 		uint64_t icnrcb:1;
 		uint64_t icr0:1;
 		uint64_t icr1:1;
@@ -96,40 +80,81 @@ union cvmx_iob_bist_status {
 		uint64_t ibd:1;
 		uint64_t icd:1;
 	} s;
-	struct cvmx_iob_bist_status_s cn30xx;
-	struct cvmx_iob_bist_status_s cn31xx;
-	struct cvmx_iob_bist_status_s cn38xx;
-	struct cvmx_iob_bist_status_s cn38xxp2;
-	struct cvmx_iob_bist_status_s cn50xx;
-	struct cvmx_iob_bist_status_s cn52xx;
-	struct cvmx_iob_bist_status_s cn52xxp1;
-	struct cvmx_iob_bist_status_s cn56xx;
-	struct cvmx_iob_bist_status_s cn56xxp1;
-	struct cvmx_iob_bist_status_s cn58xx;
-	struct cvmx_iob_bist_status_s cn58xxp1;
+	struct cvmx_iob_bist_status_cn30xx {
+		uint64_t reserved_18_63:46;
+		uint64_t icnrcb:1;
+		uint64_t icr0:1;
+		uint64_t icr1:1;
+		uint64_t icnr1:1;
+		uint64_t icnr0:1;
+		uint64_t ibdr0:1;
+		uint64_t ibdr1:1;
+		uint64_t ibr0:1;
+		uint64_t ibr1:1;
+		uint64_t icnrt:1;
+		uint64_t ibrq0:1;
+		uint64_t ibrq1:1;
+		uint64_t icrn0:1;
+		uint64_t icrn1:1;
+		uint64_t icrp0:1;
+		uint64_t icrp1:1;
+		uint64_t ibd:1;
+		uint64_t icd:1;
+	} cn30xx;
+	struct cvmx_iob_bist_status_cn30xx cn31xx;
+	struct cvmx_iob_bist_status_cn30xx cn38xx;
+	struct cvmx_iob_bist_status_cn30xx cn38xxp2;
+	struct cvmx_iob_bist_status_cn30xx cn50xx;
+	struct cvmx_iob_bist_status_cn30xx cn52xx;
+	struct cvmx_iob_bist_status_cn30xx cn52xxp1;
+	struct cvmx_iob_bist_status_cn30xx cn56xx;
+	struct cvmx_iob_bist_status_cn30xx cn56xxp1;
+	struct cvmx_iob_bist_status_cn30xx cn58xx;
+	struct cvmx_iob_bist_status_cn30xx cn58xxp1;
+	struct cvmx_iob_bist_status_s cn63xx;
+	struct cvmx_iob_bist_status_s cn63xxp1;
 };
 
 union cvmx_iob_ctl_status {
 	uint64_t u64;
 	struct cvmx_iob_ctl_status_s {
-		uint64_t reserved_5_63:59;
+		uint64_t reserved_10_63:54;
+		uint64_t xmc_per:4;
+		uint64_t rr_mode:1;
 		uint64_t outb_mat:1;
 		uint64_t inb_mat:1;
 		uint64_t pko_enb:1;
 		uint64_t dwb_enb:1;
 		uint64_t fau_end:1;
 	} s;
-	struct cvmx_iob_ctl_status_s cn30xx;
-	struct cvmx_iob_ctl_status_s cn31xx;
-	struct cvmx_iob_ctl_status_s cn38xx;
-	struct cvmx_iob_ctl_status_s cn38xxp2;
-	struct cvmx_iob_ctl_status_s cn50xx;
-	struct cvmx_iob_ctl_status_s cn52xx;
-	struct cvmx_iob_ctl_status_s cn52xxp1;
-	struct cvmx_iob_ctl_status_s cn56xx;
-	struct cvmx_iob_ctl_status_s cn56xxp1;
-	struct cvmx_iob_ctl_status_s cn58xx;
-	struct cvmx_iob_ctl_status_s cn58xxp1;
+	struct cvmx_iob_ctl_status_cn30xx {
+		uint64_t reserved_5_63:59;
+		uint64_t outb_mat:1;
+		uint64_t inb_mat:1;
+		uint64_t pko_enb:1;
+		uint64_t dwb_enb:1;
+		uint64_t fau_end:1;
+	} cn30xx;
+	struct cvmx_iob_ctl_status_cn30xx cn31xx;
+	struct cvmx_iob_ctl_status_cn30xx cn38xx;
+	struct cvmx_iob_ctl_status_cn30xx cn38xxp2;
+	struct cvmx_iob_ctl_status_cn30xx cn50xx;
+	struct cvmx_iob_ctl_status_cn52xx {
+		uint64_t reserved_6_63:58;
+		uint64_t rr_mode:1;
+		uint64_t outb_mat:1;
+		uint64_t inb_mat:1;
+		uint64_t pko_enb:1;
+		uint64_t dwb_enb:1;
+		uint64_t fau_end:1;
+	} cn52xx;
+	struct cvmx_iob_ctl_status_cn30xx cn52xxp1;
+	struct cvmx_iob_ctl_status_cn30xx cn56xx;
+	struct cvmx_iob_ctl_status_cn30xx cn56xxp1;
+	struct cvmx_iob_ctl_status_cn30xx cn58xx;
+	struct cvmx_iob_ctl_status_cn30xx cn58xxp1;
+	struct cvmx_iob_ctl_status_s cn63xx;
+	struct cvmx_iob_ctl_status_s cn63xxp1;
 };
 
 union cvmx_iob_dwb_pri_cnt {
@@ -147,6 +172,8 @@ union cvmx_iob_dwb_pri_cnt {
 	struct cvmx_iob_dwb_pri_cnt_s cn56xxp1;
 	struct cvmx_iob_dwb_pri_cnt_s cn58xx;
 	struct cvmx_iob_dwb_pri_cnt_s cn58xxp1;
+	struct cvmx_iob_dwb_pri_cnt_s cn63xx;
+	struct cvmx_iob_dwb_pri_cnt_s cn63xxp1;
 };
 
 union cvmx_iob_fau_timeout {
@@ -167,6 +194,8 @@ union cvmx_iob_fau_timeout {
 	struct cvmx_iob_fau_timeout_s cn56xxp1;
 	struct cvmx_iob_fau_timeout_s cn58xx;
 	struct cvmx_iob_fau_timeout_s cn58xxp1;
+	struct cvmx_iob_fau_timeout_s cn63xx;
+	struct cvmx_iob_fau_timeout_s cn63xxp1;
 };
 
 union cvmx_iob_i2c_pri_cnt {
@@ -184,6 +213,8 @@ union cvmx_iob_i2c_pri_cnt {
 	struct cvmx_iob_i2c_pri_cnt_s cn56xxp1;
 	struct cvmx_iob_i2c_pri_cnt_s cn58xx;
 	struct cvmx_iob_i2c_pri_cnt_s cn58xxp1;
+	struct cvmx_iob_i2c_pri_cnt_s cn63xx;
+	struct cvmx_iob_i2c_pri_cnt_s cn63xxp1;
 };
 
 union cvmx_iob_inb_control_match {
@@ -206,6 +237,8 @@ union cvmx_iob_inb_control_match {
 	struct cvmx_iob_inb_control_match_s cn56xxp1;
 	struct cvmx_iob_inb_control_match_s cn58xx;
 	struct cvmx_iob_inb_control_match_s cn58xxp1;
+	struct cvmx_iob_inb_control_match_s cn63xx;
+	struct cvmx_iob_inb_control_match_s cn63xxp1;
 };
 
 union cvmx_iob_inb_control_match_enb {
@@ -228,6 +261,8 @@ union cvmx_iob_inb_control_match_enb {
 	struct cvmx_iob_inb_control_match_enb_s cn56xxp1;
 	struct cvmx_iob_inb_control_match_enb_s cn58xx;
 	struct cvmx_iob_inb_control_match_enb_s cn58xxp1;
+	struct cvmx_iob_inb_control_match_enb_s cn63xx;
+	struct cvmx_iob_inb_control_match_enb_s cn63xxp1;
 };
 
 union cvmx_iob_inb_data_match {
@@ -246,6 +281,8 @@ union cvmx_iob_inb_data_match {
 	struct cvmx_iob_inb_data_match_s cn56xxp1;
 	struct cvmx_iob_inb_data_match_s cn58xx;
 	struct cvmx_iob_inb_data_match_s cn58xxp1;
+	struct cvmx_iob_inb_data_match_s cn63xx;
+	struct cvmx_iob_inb_data_match_s cn63xxp1;
 };
 
 union cvmx_iob_inb_data_match_enb {
@@ -264,6 +301,8 @@ union cvmx_iob_inb_data_match_enb {
 	struct cvmx_iob_inb_data_match_enb_s cn56xxp1;
 	struct cvmx_iob_inb_data_match_enb_s cn58xx;
 	struct cvmx_iob_inb_data_match_enb_s cn58xxp1;
+	struct cvmx_iob_inb_data_match_enb_s cn63xx;
+	struct cvmx_iob_inb_data_match_enb_s cn63xxp1;
 };
 
 union cvmx_iob_int_enb {
@@ -294,6 +333,8 @@ union cvmx_iob_int_enb {
 	struct cvmx_iob_int_enb_s cn56xxp1;
 	struct cvmx_iob_int_enb_s cn58xx;
 	struct cvmx_iob_int_enb_s cn58xxp1;
+	struct cvmx_iob_int_enb_s cn63xx;
+	struct cvmx_iob_int_enb_s cn63xxp1;
 };
 
 union cvmx_iob_int_sum {
@@ -324,6 +365,8 @@ union cvmx_iob_int_sum {
 	struct cvmx_iob_int_sum_s cn56xxp1;
 	struct cvmx_iob_int_sum_s cn58xx;
 	struct cvmx_iob_int_sum_s cn58xxp1;
+	struct cvmx_iob_int_sum_s cn63xx;
+	struct cvmx_iob_int_sum_s cn63xxp1;
 };
 
 union cvmx_iob_n2c_l2c_pri_cnt {
@@ -341,6 +384,8 @@ union cvmx_iob_n2c_l2c_pri_cnt {
 	struct cvmx_iob_n2c_l2c_pri_cnt_s cn56xxp1;
 	struct cvmx_iob_n2c_l2c_pri_cnt_s cn58xx;
 	struct cvmx_iob_n2c_l2c_pri_cnt_s cn58xxp1;
+	struct cvmx_iob_n2c_l2c_pri_cnt_s cn63xx;
+	struct cvmx_iob_n2c_l2c_pri_cnt_s cn63xxp1;
 };
 
 union cvmx_iob_n2c_rsp_pri_cnt {
@@ -358,6 +403,8 @@ union cvmx_iob_n2c_rsp_pri_cnt {
 	struct cvmx_iob_n2c_rsp_pri_cnt_s cn56xxp1;
 	struct cvmx_iob_n2c_rsp_pri_cnt_s cn58xx;
 	struct cvmx_iob_n2c_rsp_pri_cnt_s cn58xxp1;
+	struct cvmx_iob_n2c_rsp_pri_cnt_s cn63xx;
+	struct cvmx_iob_n2c_rsp_pri_cnt_s cn63xxp1;
 };
 
 union cvmx_iob_outb_com_pri_cnt {
@@ -375,6 +422,8 @@ union cvmx_iob_outb_com_pri_cnt {
 	struct cvmx_iob_outb_com_pri_cnt_s cn56xxp1;
 	struct cvmx_iob_outb_com_pri_cnt_s cn58xx;
 	struct cvmx_iob_outb_com_pri_cnt_s cn58xxp1;
+	struct cvmx_iob_outb_com_pri_cnt_s cn63xx;
+	struct cvmx_iob_outb_com_pri_cnt_s cn63xxp1;
 };
 
 union cvmx_iob_outb_control_match {
@@ -397,6 +446,8 @@ union cvmx_iob_outb_control_match {
 	struct cvmx_iob_outb_control_match_s cn56xxp1;
 	struct cvmx_iob_outb_control_match_s cn58xx;
 	struct cvmx_iob_outb_control_match_s cn58xxp1;
+	struct cvmx_iob_outb_control_match_s cn63xx;
+	struct cvmx_iob_outb_control_match_s cn63xxp1;
 };
 
 union cvmx_iob_outb_control_match_enb {
@@ -419,6 +470,8 @@ union cvmx_iob_outb_control_match_enb {
 	struct cvmx_iob_outb_control_match_enb_s cn56xxp1;
 	struct cvmx_iob_outb_control_match_enb_s cn58xx;
 	struct cvmx_iob_outb_control_match_enb_s cn58xxp1;
+	struct cvmx_iob_outb_control_match_enb_s cn63xx;
+	struct cvmx_iob_outb_control_match_enb_s cn63xxp1;
 };
 
 union cvmx_iob_outb_data_match {
@@ -437,6 +490,8 @@ union cvmx_iob_outb_data_match {
 	struct cvmx_iob_outb_data_match_s cn56xxp1;
 	struct cvmx_iob_outb_data_match_s cn58xx;
 	struct cvmx_iob_outb_data_match_s cn58xxp1;
+	struct cvmx_iob_outb_data_match_s cn63xx;
+	struct cvmx_iob_outb_data_match_s cn63xxp1;
 };
 
 union cvmx_iob_outb_data_match_enb {
@@ -455,6 +510,8 @@ union cvmx_iob_outb_data_match_enb {
 	struct cvmx_iob_outb_data_match_enb_s cn56xxp1;
 	struct cvmx_iob_outb_data_match_enb_s cn58xx;
 	struct cvmx_iob_outb_data_match_enb_s cn58xxp1;
+	struct cvmx_iob_outb_data_match_enb_s cn63xx;
+	struct cvmx_iob_outb_data_match_enb_s cn63xxp1;
 };
 
 union cvmx_iob_outb_fpa_pri_cnt {
@@ -472,6 +529,8 @@ union cvmx_iob_outb_fpa_pri_cnt {
 	struct cvmx_iob_outb_fpa_pri_cnt_s cn56xxp1;
 	struct cvmx_iob_outb_fpa_pri_cnt_s cn58xx;
 	struct cvmx_iob_outb_fpa_pri_cnt_s cn58xxp1;
+	struct cvmx_iob_outb_fpa_pri_cnt_s cn63xx;
+	struct cvmx_iob_outb_fpa_pri_cnt_s cn63xxp1;
 };
 
 union cvmx_iob_outb_req_pri_cnt {
@@ -489,6 +548,8 @@ union cvmx_iob_outb_req_pri_cnt {
 	struct cvmx_iob_outb_req_pri_cnt_s cn56xxp1;
 	struct cvmx_iob_outb_req_pri_cnt_s cn58xx;
 	struct cvmx_iob_outb_req_pri_cnt_s cn58xxp1;
+	struct cvmx_iob_outb_req_pri_cnt_s cn63xx;
+	struct cvmx_iob_outb_req_pri_cnt_s cn63xxp1;
 };
 
 union cvmx_iob_p2c_req_pri_cnt {
@@ -506,25 +567,46 @@ union cvmx_iob_p2c_req_pri_cnt {
 	struct cvmx_iob_p2c_req_pri_cnt_s cn56xxp1;
 	struct cvmx_iob_p2c_req_pri_cnt_s cn58xx;
 	struct cvmx_iob_p2c_req_pri_cnt_s cn58xxp1;
+	struct cvmx_iob_p2c_req_pri_cnt_s cn63xx;
+	struct cvmx_iob_p2c_req_pri_cnt_s cn63xxp1;
 };
 
 union cvmx_iob_pkt_err {
 	uint64_t u64;
 	struct cvmx_iob_pkt_err_s {
+		uint64_t reserved_12_63:52;
+		uint64_t vport:6;
+		uint64_t port:6;
+	} s;
+	struct cvmx_iob_pkt_err_cn30xx {
 		uint64_t reserved_6_63:58;
 		uint64_t port:6;
+	} cn30xx;
+	struct cvmx_iob_pkt_err_cn30xx cn31xx;
+	struct cvmx_iob_pkt_err_cn30xx cn38xx;
+	struct cvmx_iob_pkt_err_cn30xx cn38xxp2;
+	struct cvmx_iob_pkt_err_cn30xx cn50xx;
+	struct cvmx_iob_pkt_err_cn30xx cn52xx;
+	struct cvmx_iob_pkt_err_cn30xx cn52xxp1;
+	struct cvmx_iob_pkt_err_cn30xx cn56xx;
+	struct cvmx_iob_pkt_err_cn30xx cn56xxp1;
+	struct cvmx_iob_pkt_err_cn30xx cn58xx;
+	struct cvmx_iob_pkt_err_cn30xx cn58xxp1;
+	struct cvmx_iob_pkt_err_s cn63xx;
+	struct cvmx_iob_pkt_err_s cn63xxp1;
+};
+
+union cvmx_iob_to_cmb_credits {
+	uint64_t u64;
+	struct cvmx_iob_to_cmb_credits_s {
+		uint64_t reserved_9_63:55;
+		uint64_t pko_rd:3;
+		uint64_t ncb_rd:3;
+		uint64_t ncb_wr:3;
 	} s;
-	struct cvmx_iob_pkt_err_s cn30xx;
-	struct cvmx_iob_pkt_err_s cn31xx;
-	struct cvmx_iob_pkt_err_s cn38xx;
-	struct cvmx_iob_pkt_err_s cn38xxp2;
-	struct cvmx_iob_pkt_err_s cn50xx;
-	struct cvmx_iob_pkt_err_s cn52xx;
-	struct cvmx_iob_pkt_err_s cn52xxp1;
-	struct cvmx_iob_pkt_err_s cn56xx;
-	struct cvmx_iob_pkt_err_s cn56xxp1;
-	struct cvmx_iob_pkt_err_s cn58xx;
-	struct cvmx_iob_pkt_err_s cn58xxp1;
+	struct cvmx_iob_to_cmb_credits_s cn52xx;
+	struct cvmx_iob_to_cmb_credits_s cn63xx;
+	struct cvmx_iob_to_cmb_credits_s cn63xxp1;
 };
 
 #endif
diff --git a/arch/mips/include/asm/octeon/cvmx-ipd-defs.h b/arch/mips/include/asm/octeon/cvmx-ipd-defs.h
index f8b8fc6..e0a5bfe 100644
--- a/arch/mips/include/asm/octeon/cvmx-ipd-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-ipd-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2010 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -28,104 +28,57 @@
 #ifndef __CVMX_IPD_DEFS_H__
 #define __CVMX_IPD_DEFS_H__
 
-#define CVMX_IPD_1ST_MBUFF_SKIP \
-	 CVMX_ADD_IO_SEG(0x00014F0000000000ull)
-#define CVMX_IPD_1st_NEXT_PTR_BACK \
-	 CVMX_ADD_IO_SEG(0x00014F0000000150ull)
-#define CVMX_IPD_2nd_NEXT_PTR_BACK \
-	 CVMX_ADD_IO_SEG(0x00014F0000000158ull)
-#define CVMX_IPD_BIST_STATUS \
-	 CVMX_ADD_IO_SEG(0x00014F00000007F8ull)
-#define CVMX_IPD_BP_PRT_RED_END \
-	 CVMX_ADD_IO_SEG(0x00014F0000000328ull)
-#define CVMX_IPD_CLK_COUNT \
-	 CVMX_ADD_IO_SEG(0x00014F0000000338ull)
-#define CVMX_IPD_CTL_STATUS \
-	 CVMX_ADD_IO_SEG(0x00014F0000000018ull)
-#define CVMX_IPD_INT_ENB \
-	 CVMX_ADD_IO_SEG(0x00014F0000000160ull)
-#define CVMX_IPD_INT_SUM \
-	 CVMX_ADD_IO_SEG(0x00014F0000000168ull)
-#define CVMX_IPD_NOT_1ST_MBUFF_SKIP \
-	 CVMX_ADD_IO_SEG(0x00014F0000000008ull)
-#define CVMX_IPD_PACKET_MBUFF_SIZE \
-	 CVMX_ADD_IO_SEG(0x00014F0000000010ull)
-#define CVMX_IPD_PKT_PTR_VALID \
-	 CVMX_ADD_IO_SEG(0x00014F0000000358ull)
-#define CVMX_IPD_PORTX_BP_PAGE_CNT(offset) \
-	 CVMX_ADD_IO_SEG(0x00014F0000000028ull + (((offset) & 63) * 8))
-#define CVMX_IPD_PORTX_BP_PAGE_CNT2(offset) \
-	 CVMX_ADD_IO_SEG(0x00014F0000000368ull + (((offset) & 63) * 8) - 8 * 36)
-#define CVMX_IPD_PORT_BP_COUNTERS2_PAIRX(offset) \
-	 CVMX_ADD_IO_SEG(0x00014F0000000388ull + (((offset) & 63) * 8) - 8 * 36)
-#define CVMX_IPD_PORT_BP_COUNTERS_PAIRX(offset) \
-	 CVMX_ADD_IO_SEG(0x00014F00000001B8ull + (((offset) & 63) * 8))
-#define CVMX_IPD_PORT_QOS_INTX(offset) \
-	 CVMX_ADD_IO_SEG(0x00014F0000000808ull + (((offset) & 7) * 8))
-#define CVMX_IPD_PORT_QOS_INT_ENBX(offset) \
-	 CVMX_ADD_IO_SEG(0x00014F0000000848ull + (((offset) & 7) * 8))
-#define CVMX_IPD_PORT_QOS_X_CNT(offset) \
-	 CVMX_ADD_IO_SEG(0x00014F0000000888ull + (((offset) & 511) * 8))
-#define CVMX_IPD_PRC_HOLD_PTR_FIFO_CTL \
-	 CVMX_ADD_IO_SEG(0x00014F0000000348ull)
-#define CVMX_IPD_PRC_PORT_PTR_FIFO_CTL \
-	 CVMX_ADD_IO_SEG(0x00014F0000000350ull)
-#define CVMX_IPD_PTR_COUNT \
-	 CVMX_ADD_IO_SEG(0x00014F0000000320ull)
-#define CVMX_IPD_PWP_PTR_FIFO_CTL \
-	 CVMX_ADD_IO_SEG(0x00014F0000000340ull)
-#define CVMX_IPD_QOS0_RED_MARKS \
-	 CVMX_ADD_IO_SEG(0x00014F0000000178ull)
-#define CVMX_IPD_QOS1_RED_MARKS \
-	 CVMX_ADD_IO_SEG(0x00014F0000000180ull)
-#define CVMX_IPD_QOS2_RED_MARKS \
-	 CVMX_ADD_IO_SEG(0x00014F0000000188ull)
-#define CVMX_IPD_QOS3_RED_MARKS \
-	 CVMX_ADD_IO_SEG(0x00014F0000000190ull)
-#define CVMX_IPD_QOS4_RED_MARKS \
-	 CVMX_ADD_IO_SEG(0x00014F0000000198ull)
-#define CVMX_IPD_QOS5_RED_MARKS \
-	 CVMX_ADD_IO_SEG(0x00014F00000001A0ull)
-#define CVMX_IPD_QOS6_RED_MARKS \
-	 CVMX_ADD_IO_SEG(0x00014F00000001A8ull)
-#define CVMX_IPD_QOS7_RED_MARKS \
-	 CVMX_ADD_IO_SEG(0x00014F00000001B0ull)
-#define CVMX_IPD_QOSX_RED_MARKS(offset) \
-	 CVMX_ADD_IO_SEG(0x00014F0000000178ull + (((offset) & 7) * 8))
-#define CVMX_IPD_QUE0_FREE_PAGE_CNT \
-	 CVMX_ADD_IO_SEG(0x00014F0000000330ull)
-#define CVMX_IPD_RED_PORT_ENABLE \
-	 CVMX_ADD_IO_SEG(0x00014F00000002D8ull)
-#define CVMX_IPD_RED_PORT_ENABLE2 \
-	 CVMX_ADD_IO_SEG(0x00014F00000003A8ull)
-#define CVMX_IPD_RED_QUE0_PARAM \
-	 CVMX_ADD_IO_SEG(0x00014F00000002E0ull)
-#define CVMX_IPD_RED_QUE1_PARAM \
-	 CVMX_ADD_IO_SEG(0x00014F00000002E8ull)
-#define CVMX_IPD_RED_QUE2_PARAM \
-	 CVMX_ADD_IO_SEG(0x00014F00000002F0ull)
-#define CVMX_IPD_RED_QUE3_PARAM \
-	 CVMX_ADD_IO_SEG(0x00014F00000002F8ull)
-#define CVMX_IPD_RED_QUE4_PARAM \
-	 CVMX_ADD_IO_SEG(0x00014F0000000300ull)
-#define CVMX_IPD_RED_QUE5_PARAM \
-	 CVMX_ADD_IO_SEG(0x00014F0000000308ull)
-#define CVMX_IPD_RED_QUE6_PARAM \
-	 CVMX_ADD_IO_SEG(0x00014F0000000310ull)
-#define CVMX_IPD_RED_QUE7_PARAM \
-	 CVMX_ADD_IO_SEG(0x00014F0000000318ull)
-#define CVMX_IPD_RED_QUEX_PARAM(offset) \
-	 CVMX_ADD_IO_SEG(0x00014F00000002E0ull + (((offset) & 7) * 8))
-#define CVMX_IPD_SUB_PORT_BP_PAGE_CNT \
-	 CVMX_ADD_IO_SEG(0x00014F0000000148ull)
-#define CVMX_IPD_SUB_PORT_FCS \
-	 CVMX_ADD_IO_SEG(0x00014F0000000170ull)
-#define CVMX_IPD_SUB_PORT_QOS_CNT \
-	 CVMX_ADD_IO_SEG(0x00014F0000000800ull)
-#define CVMX_IPD_WQE_FPA_QUEUE \
-	 CVMX_ADD_IO_SEG(0x00014F0000000020ull)
-#define CVMX_IPD_WQE_PTR_VALID \
-	 CVMX_ADD_IO_SEG(0x00014F0000000360ull)
+#define CVMX_IPD_1ST_MBUFF_SKIP (CVMX_ADD_IO_SEG(0x00014F0000000000ull))
+#define CVMX_IPD_1st_NEXT_PTR_BACK (CVMX_ADD_IO_SEG(0x00014F0000000150ull))
+#define CVMX_IPD_2nd_NEXT_PTR_BACK (CVMX_ADD_IO_SEG(0x00014F0000000158ull))
+#define CVMX_IPD_BIST_STATUS (CVMX_ADD_IO_SEG(0x00014F00000007F8ull))
+#define CVMX_IPD_BP_PRT_RED_END (CVMX_ADD_IO_SEG(0x00014F0000000328ull))
+#define CVMX_IPD_CLK_COUNT (CVMX_ADD_IO_SEG(0x00014F0000000338ull))
+#define CVMX_IPD_CTL_STATUS (CVMX_ADD_IO_SEG(0x00014F0000000018ull))
+#define CVMX_IPD_INT_ENB (CVMX_ADD_IO_SEG(0x00014F0000000160ull))
+#define CVMX_IPD_INT_SUM (CVMX_ADD_IO_SEG(0x00014F0000000168ull))
+#define CVMX_IPD_NOT_1ST_MBUFF_SKIP (CVMX_ADD_IO_SEG(0x00014F0000000008ull))
+#define CVMX_IPD_PACKET_MBUFF_SIZE (CVMX_ADD_IO_SEG(0x00014F0000000010ull))
+#define CVMX_IPD_PKT_PTR_VALID (CVMX_ADD_IO_SEG(0x00014F0000000358ull))
+#define CVMX_IPD_PORTX_BP_PAGE_CNT(offset) (CVMX_ADD_IO_SEG(0x00014F0000000028ull) + ((offset) & 63) * 8)
+#define CVMX_IPD_PORTX_BP_PAGE_CNT2(offset) (CVMX_ADD_IO_SEG(0x00014F0000000368ull) + ((offset) & 63) * 8 - 8*36)
+#define CVMX_IPD_PORTX_BP_PAGE_CNT3(offset) (CVMX_ADD_IO_SEG(0x00014F00000003D0ull) + ((offset) & 63) * 8 - 8*40)
+#define CVMX_IPD_PORT_BP_COUNTERS2_PAIRX(offset) (CVMX_ADD_IO_SEG(0x00014F0000000388ull) + ((offset) & 63) * 8 - 8*36)
+#define CVMX_IPD_PORT_BP_COUNTERS3_PAIRX(offset) (CVMX_ADD_IO_SEG(0x00014F00000003B0ull) + ((offset) & 63) * 8 - 8*40)
+#define CVMX_IPD_PORT_BP_COUNTERS_PAIRX(offset) (CVMX_ADD_IO_SEG(0x00014F00000001B8ull) + ((offset) & 63) * 8)
+#define CVMX_IPD_PORT_QOS_INTX(offset) (CVMX_ADD_IO_SEG(0x00014F0000000808ull) + ((offset) & 7) * 8)
+#define CVMX_IPD_PORT_QOS_INT_ENBX(offset) (CVMX_ADD_IO_SEG(0x00014F0000000848ull) + ((offset) & 7) * 8)
+#define CVMX_IPD_PORT_QOS_X_CNT(offset) (CVMX_ADD_IO_SEG(0x00014F0000000888ull) + ((offset) & 511) * 8)
+#define CVMX_IPD_PRC_HOLD_PTR_FIFO_CTL (CVMX_ADD_IO_SEG(0x00014F0000000348ull))
+#define CVMX_IPD_PRC_PORT_PTR_FIFO_CTL (CVMX_ADD_IO_SEG(0x00014F0000000350ull))
+#define CVMX_IPD_PTR_COUNT (CVMX_ADD_IO_SEG(0x00014F0000000320ull))
+#define CVMX_IPD_PWP_PTR_FIFO_CTL (CVMX_ADD_IO_SEG(0x00014F0000000340ull))
+#define CVMX_IPD_QOS0_RED_MARKS CVMX_IPD_QOSX_RED_MARKS(0)
+#define CVMX_IPD_QOS1_RED_MARKS CVMX_IPD_QOSX_RED_MARKS(1)
+#define CVMX_IPD_QOS2_RED_MARKS CVMX_IPD_QOSX_RED_MARKS(2)
+#define CVMX_IPD_QOS3_RED_MARKS CVMX_IPD_QOSX_RED_MARKS(3)
+#define CVMX_IPD_QOS4_RED_MARKS CVMX_IPD_QOSX_RED_MARKS(4)
+#define CVMX_IPD_QOS5_RED_MARKS CVMX_IPD_QOSX_RED_MARKS(5)
+#define CVMX_IPD_QOS6_RED_MARKS CVMX_IPD_QOSX_RED_MARKS(6)
+#define CVMX_IPD_QOS7_RED_MARKS CVMX_IPD_QOSX_RED_MARKS(7)
+#define CVMX_IPD_QOSX_RED_MARKS(offset) (CVMX_ADD_IO_SEG(0x00014F0000000178ull) + ((offset) & 7) * 8)
+#define CVMX_IPD_QUE0_FREE_PAGE_CNT (CVMX_ADD_IO_SEG(0x00014F0000000330ull))
+#define CVMX_IPD_RED_PORT_ENABLE (CVMX_ADD_IO_SEG(0x00014F00000002D8ull))
+#define CVMX_IPD_RED_PORT_ENABLE2 (CVMX_ADD_IO_SEG(0x00014F00000003A8ull))
+#define CVMX_IPD_RED_QUE0_PARAM CVMX_IPD_RED_QUEX_PARAM(0)
+#define CVMX_IPD_RED_QUE1_PARAM CVMX_IPD_RED_QUEX_PARAM(1)
+#define CVMX_IPD_RED_QUE2_PARAM CVMX_IPD_RED_QUEX_PARAM(2)
+#define CVMX_IPD_RED_QUE3_PARAM CVMX_IPD_RED_QUEX_PARAM(3)
+#define CVMX_IPD_RED_QUE4_PARAM CVMX_IPD_RED_QUEX_PARAM(4)
+#define CVMX_IPD_RED_QUE5_PARAM CVMX_IPD_RED_QUEX_PARAM(5)
+#define CVMX_IPD_RED_QUE6_PARAM CVMX_IPD_RED_QUEX_PARAM(6)
+#define CVMX_IPD_RED_QUE7_PARAM CVMX_IPD_RED_QUEX_PARAM(7)
+#define CVMX_IPD_RED_QUEX_PARAM(offset) (CVMX_ADD_IO_SEG(0x00014F00000002E0ull) + ((offset) & 7) * 8)
+#define CVMX_IPD_SUB_PORT_BP_PAGE_CNT (CVMX_ADD_IO_SEG(0x00014F0000000148ull))
+#define CVMX_IPD_SUB_PORT_FCS (CVMX_ADD_IO_SEG(0x00014F0000000170ull))
+#define CVMX_IPD_SUB_PORT_QOS_CNT (CVMX_ADD_IO_SEG(0x00014F0000000800ull))
+#define CVMX_IPD_WQE_FPA_QUEUE (CVMX_ADD_IO_SEG(0x00014F0000000020ull))
+#define CVMX_IPD_WQE_PTR_VALID (CVMX_ADD_IO_SEG(0x00014F0000000360ull))
 
 union cvmx_ipd_1st_mbuff_skip {
 	uint64_t u64;
@@ -144,6 +97,8 @@ union cvmx_ipd_1st_mbuff_skip {
 	struct cvmx_ipd_1st_mbuff_skip_s cn56xxp1;
 	struct cvmx_ipd_1st_mbuff_skip_s cn58xx;
 	struct cvmx_ipd_1st_mbuff_skip_s cn58xxp1;
+	struct cvmx_ipd_1st_mbuff_skip_s cn63xx;
+	struct cvmx_ipd_1st_mbuff_skip_s cn63xxp1;
 };
 
 union cvmx_ipd_1st_next_ptr_back {
@@ -163,6 +118,8 @@ union cvmx_ipd_1st_next_ptr_back {
 	struct cvmx_ipd_1st_next_ptr_back_s cn56xxp1;
 	struct cvmx_ipd_1st_next_ptr_back_s cn58xx;
 	struct cvmx_ipd_1st_next_ptr_back_s cn58xxp1;
+	struct cvmx_ipd_1st_next_ptr_back_s cn63xx;
+	struct cvmx_ipd_1st_next_ptr_back_s cn63xxp1;
 };
 
 union cvmx_ipd_2nd_next_ptr_back {
@@ -182,6 +139,8 @@ union cvmx_ipd_2nd_next_ptr_back {
 	struct cvmx_ipd_2nd_next_ptr_back_s cn56xxp1;
 	struct cvmx_ipd_2nd_next_ptr_back_s cn58xx;
 	struct cvmx_ipd_2nd_next_ptr_back_s cn58xxp1;
+	struct cvmx_ipd_2nd_next_ptr_back_s cn63xx;
+	struct cvmx_ipd_2nd_next_ptr_back_s cn63xxp1;
 };
 
 union cvmx_ipd_bist_status {
@@ -236,13 +195,15 @@ union cvmx_ipd_bist_status {
 	struct cvmx_ipd_bist_status_s cn56xxp1;
 	struct cvmx_ipd_bist_status_cn30xx cn58xx;
 	struct cvmx_ipd_bist_status_cn30xx cn58xxp1;
+	struct cvmx_ipd_bist_status_s cn63xx;
+	struct cvmx_ipd_bist_status_s cn63xxp1;
 };
 
 union cvmx_ipd_bp_prt_red_end {
 	uint64_t u64;
 	struct cvmx_ipd_bp_prt_red_end_s {
-		uint64_t reserved_40_63:24;
-		uint64_t prt_enb:40;
+		uint64_t reserved_44_63:20;
+		uint64_t prt_enb:44;
 	} s;
 	struct cvmx_ipd_bp_prt_red_end_cn30xx {
 		uint64_t reserved_36_63:28;
@@ -252,12 +213,17 @@ union cvmx_ipd_bp_prt_red_end {
 	struct cvmx_ipd_bp_prt_red_end_cn30xx cn38xx;
 	struct cvmx_ipd_bp_prt_red_end_cn30xx cn38xxp2;
 	struct cvmx_ipd_bp_prt_red_end_cn30xx cn50xx;
-	struct cvmx_ipd_bp_prt_red_end_s cn52xx;
-	struct cvmx_ipd_bp_prt_red_end_s cn52xxp1;
-	struct cvmx_ipd_bp_prt_red_end_s cn56xx;
-	struct cvmx_ipd_bp_prt_red_end_s cn56xxp1;
+	struct cvmx_ipd_bp_prt_red_end_cn52xx {
+		uint64_t reserved_40_63:24;
+		uint64_t prt_enb:40;
+	} cn52xx;
+	struct cvmx_ipd_bp_prt_red_end_cn52xx cn52xxp1;
+	struct cvmx_ipd_bp_prt_red_end_cn52xx cn56xx;
+	struct cvmx_ipd_bp_prt_red_end_cn52xx cn56xxp1;
 	struct cvmx_ipd_bp_prt_red_end_cn30xx cn58xx;
 	struct cvmx_ipd_bp_prt_red_end_cn30xx cn58xxp1;
+	struct cvmx_ipd_bp_prt_red_end_s cn63xx;
+	struct cvmx_ipd_bp_prt_red_end_s cn63xxp1;
 };
 
 union cvmx_ipd_clk_count {
@@ -276,12 +242,17 @@ union cvmx_ipd_clk_count {
 	struct cvmx_ipd_clk_count_s cn56xxp1;
 	struct cvmx_ipd_clk_count_s cn58xx;
 	struct cvmx_ipd_clk_count_s cn58xxp1;
+	struct cvmx_ipd_clk_count_s cn63xx;
+	struct cvmx_ipd_clk_count_s cn63xxp1;
 };
 
 union cvmx_ipd_ctl_status {
 	uint64_t u64;
 	struct cvmx_ipd_ctl_status_s {
-		uint64_t reserved_15_63:49;
+		uint64_t reserved_18_63:46;
+		uint64_t use_sop:1;
+		uint64_t rst_done:1;
+		uint64_t clken:1;
 		uint64_t no_wptr:1;
 		uint64_t pq_apkt:1;
 		uint64_t pq_nabuf:1;
@@ -322,11 +293,27 @@ union cvmx_ipd_ctl_status {
 		uint64_t opc_mode:2;
 		uint64_t ipd_en:1;
 	} cn38xxp2;
-	struct cvmx_ipd_ctl_status_s cn50xx;
-	struct cvmx_ipd_ctl_status_s cn52xx;
-	struct cvmx_ipd_ctl_status_s cn52xxp1;
-	struct cvmx_ipd_ctl_status_s cn56xx;
-	struct cvmx_ipd_ctl_status_s cn56xxp1;
+	struct cvmx_ipd_ctl_status_cn50xx {
+		uint64_t reserved_15_63:49;
+		uint64_t no_wptr:1;
+		uint64_t pq_apkt:1;
+		uint64_t pq_nabuf:1;
+		uint64_t ipd_full:1;
+		uint64_t pkt_off:1;
+		uint64_t len_m8:1;
+		uint64_t reset:1;
+		uint64_t addpkt:1;
+		uint64_t naddbuf:1;
+		uint64_t pkt_lend:1;
+		uint64_t wqe_lend:1;
+		uint64_t pbp_en:1;
+		uint64_t opc_mode:2;
+		uint64_t ipd_en:1;
+	} cn50xx;
+	struct cvmx_ipd_ctl_status_cn50xx cn52xx;
+	struct cvmx_ipd_ctl_status_cn50xx cn52xxp1;
+	struct cvmx_ipd_ctl_status_cn50xx cn56xx;
+	struct cvmx_ipd_ctl_status_cn50xx cn56xxp1;
 	struct cvmx_ipd_ctl_status_cn58xx {
 		uint64_t reserved_12_63:52;
 		uint64_t ipd_full:1;
@@ -342,6 +329,25 @@ union cvmx_ipd_ctl_status {
 		uint64_t ipd_en:1;
 	} cn58xx;
 	struct cvmx_ipd_ctl_status_cn58xx cn58xxp1;
+	struct cvmx_ipd_ctl_status_s cn63xx;
+	struct cvmx_ipd_ctl_status_cn63xxp1 {
+		uint64_t reserved_16_63:48;
+		uint64_t clken:1;
+		uint64_t no_wptr:1;
+		uint64_t pq_apkt:1;
+		uint64_t pq_nabuf:1;
+		uint64_t ipd_full:1;
+		uint64_t pkt_off:1;
+		uint64_t len_m8:1;
+		uint64_t reset:1;
+		uint64_t addpkt:1;
+		uint64_t naddbuf:1;
+		uint64_t pkt_lend:1;
+		uint64_t wqe_lend:1;
+		uint64_t pbp_en:1;
+		uint64_t opc_mode:2;
+		uint64_t ipd_en:1;
+	} cn63xxp1;
 };
 
 union cvmx_ipd_int_enb {
@@ -391,6 +397,8 @@ union cvmx_ipd_int_enb {
 	struct cvmx_ipd_int_enb_s cn56xxp1;
 	struct cvmx_ipd_int_enb_cn38xx cn58xx;
 	struct cvmx_ipd_int_enb_cn38xx cn58xxp1;
+	struct cvmx_ipd_int_enb_s cn63xx;
+	struct cvmx_ipd_int_enb_s cn63xxp1;
 };
 
 union cvmx_ipd_int_sum {
@@ -440,6 +448,8 @@ union cvmx_ipd_int_sum {
 	struct cvmx_ipd_int_sum_s cn56xxp1;
 	struct cvmx_ipd_int_sum_cn38xx cn58xx;
 	struct cvmx_ipd_int_sum_cn38xx cn58xxp1;
+	struct cvmx_ipd_int_sum_s cn63xx;
+	struct cvmx_ipd_int_sum_s cn63xxp1;
 };
 
 union cvmx_ipd_not_1st_mbuff_skip {
@@ -459,6 +469,8 @@ union cvmx_ipd_not_1st_mbuff_skip {
 	struct cvmx_ipd_not_1st_mbuff_skip_s cn56xxp1;
 	struct cvmx_ipd_not_1st_mbuff_skip_s cn58xx;
 	struct cvmx_ipd_not_1st_mbuff_skip_s cn58xxp1;
+	struct cvmx_ipd_not_1st_mbuff_skip_s cn63xx;
+	struct cvmx_ipd_not_1st_mbuff_skip_s cn63xxp1;
 };
 
 union cvmx_ipd_packet_mbuff_size {
@@ -478,6 +490,8 @@ union cvmx_ipd_packet_mbuff_size {
 	struct cvmx_ipd_packet_mbuff_size_s cn56xxp1;
 	struct cvmx_ipd_packet_mbuff_size_s cn58xx;
 	struct cvmx_ipd_packet_mbuff_size_s cn58xxp1;
+	struct cvmx_ipd_packet_mbuff_size_s cn63xx;
+	struct cvmx_ipd_packet_mbuff_size_s cn63xxp1;
 };
 
 union cvmx_ipd_pkt_ptr_valid {
@@ -496,6 +510,8 @@ union cvmx_ipd_pkt_ptr_valid {
 	struct cvmx_ipd_pkt_ptr_valid_s cn56xxp1;
 	struct cvmx_ipd_pkt_ptr_valid_s cn58xx;
 	struct cvmx_ipd_pkt_ptr_valid_s cn58xxp1;
+	struct cvmx_ipd_pkt_ptr_valid_s cn63xx;
+	struct cvmx_ipd_pkt_ptr_valid_s cn63xxp1;
 };
 
 union cvmx_ipd_portx_bp_page_cnt {
@@ -516,6 +532,8 @@ union cvmx_ipd_portx_bp_page_cnt {
 	struct cvmx_ipd_portx_bp_page_cnt_s cn56xxp1;
 	struct cvmx_ipd_portx_bp_page_cnt_s cn58xx;
 	struct cvmx_ipd_portx_bp_page_cnt_s cn58xxp1;
+	struct cvmx_ipd_portx_bp_page_cnt_s cn63xx;
+	struct cvmx_ipd_portx_bp_page_cnt_s cn63xxp1;
 };
 
 union cvmx_ipd_portx_bp_page_cnt2 {
@@ -529,6 +547,19 @@ union cvmx_ipd_portx_bp_page_cnt2 {
 	struct cvmx_ipd_portx_bp_page_cnt2_s cn52xxp1;
 	struct cvmx_ipd_portx_bp_page_cnt2_s cn56xx;
 	struct cvmx_ipd_portx_bp_page_cnt2_s cn56xxp1;
+	struct cvmx_ipd_portx_bp_page_cnt2_s cn63xx;
+	struct cvmx_ipd_portx_bp_page_cnt2_s cn63xxp1;
+};
+
+union cvmx_ipd_portx_bp_page_cnt3 {
+	uint64_t u64;
+	struct cvmx_ipd_portx_bp_page_cnt3_s {
+		uint64_t reserved_18_63:46;
+		uint64_t bp_enb:1;
+		uint64_t page_cnt:17;
+	} s;
+	struct cvmx_ipd_portx_bp_page_cnt3_s cn63xx;
+	struct cvmx_ipd_portx_bp_page_cnt3_s cn63xxp1;
 };
 
 union cvmx_ipd_port_bp_counters2_pairx {
@@ -541,6 +572,18 @@ union cvmx_ipd_port_bp_counters2_pairx {
 	struct cvmx_ipd_port_bp_counters2_pairx_s cn52xxp1;
 	struct cvmx_ipd_port_bp_counters2_pairx_s cn56xx;
 	struct cvmx_ipd_port_bp_counters2_pairx_s cn56xxp1;
+	struct cvmx_ipd_port_bp_counters2_pairx_s cn63xx;
+	struct cvmx_ipd_port_bp_counters2_pairx_s cn63xxp1;
+};
+
+union cvmx_ipd_port_bp_counters3_pairx {
+	uint64_t u64;
+	struct cvmx_ipd_port_bp_counters3_pairx_s {
+		uint64_t reserved_25_63:39;
+		uint64_t cnt_val:25;
+	} s;
+	struct cvmx_ipd_port_bp_counters3_pairx_s cn63xx;
+	struct cvmx_ipd_port_bp_counters3_pairx_s cn63xxp1;
 };
 
 union cvmx_ipd_port_bp_counters_pairx {
@@ -560,6 +603,8 @@ union cvmx_ipd_port_bp_counters_pairx {
 	struct cvmx_ipd_port_bp_counters_pairx_s cn56xxp1;
 	struct cvmx_ipd_port_bp_counters_pairx_s cn58xx;
 	struct cvmx_ipd_port_bp_counters_pairx_s cn58xxp1;
+	struct cvmx_ipd_port_bp_counters_pairx_s cn63xx;
+	struct cvmx_ipd_port_bp_counters_pairx_s cn63xxp1;
 };
 
 union cvmx_ipd_port_qos_x_cnt {
@@ -572,6 +617,8 @@ union cvmx_ipd_port_qos_x_cnt {
 	struct cvmx_ipd_port_qos_x_cnt_s cn52xxp1;
 	struct cvmx_ipd_port_qos_x_cnt_s cn56xx;
 	struct cvmx_ipd_port_qos_x_cnt_s cn56xxp1;
+	struct cvmx_ipd_port_qos_x_cnt_s cn63xx;
+	struct cvmx_ipd_port_qos_x_cnt_s cn63xxp1;
 };
 
 union cvmx_ipd_port_qos_intx {
@@ -583,6 +630,8 @@ union cvmx_ipd_port_qos_intx {
 	struct cvmx_ipd_port_qos_intx_s cn52xxp1;
 	struct cvmx_ipd_port_qos_intx_s cn56xx;
 	struct cvmx_ipd_port_qos_intx_s cn56xxp1;
+	struct cvmx_ipd_port_qos_intx_s cn63xx;
+	struct cvmx_ipd_port_qos_intx_s cn63xxp1;
 };
 
 union cvmx_ipd_port_qos_int_enbx {
@@ -594,6 +643,8 @@ union cvmx_ipd_port_qos_int_enbx {
 	struct cvmx_ipd_port_qos_int_enbx_s cn52xxp1;
 	struct cvmx_ipd_port_qos_int_enbx_s cn56xx;
 	struct cvmx_ipd_port_qos_int_enbx_s cn56xxp1;
+	struct cvmx_ipd_port_qos_int_enbx_s cn63xx;
+	struct cvmx_ipd_port_qos_int_enbx_s cn63xxp1;
 };
 
 union cvmx_ipd_prc_hold_ptr_fifo_ctl {
@@ -616,6 +667,8 @@ union cvmx_ipd_prc_hold_ptr_fifo_ctl {
 	struct cvmx_ipd_prc_hold_ptr_fifo_ctl_s cn56xxp1;
 	struct cvmx_ipd_prc_hold_ptr_fifo_ctl_s cn58xx;
 	struct cvmx_ipd_prc_hold_ptr_fifo_ctl_s cn58xxp1;
+	struct cvmx_ipd_prc_hold_ptr_fifo_ctl_s cn63xx;
+	struct cvmx_ipd_prc_hold_ptr_fifo_ctl_s cn63xxp1;
 };
 
 union cvmx_ipd_prc_port_ptr_fifo_ctl {
@@ -637,6 +690,8 @@ union cvmx_ipd_prc_port_ptr_fifo_ctl {
 	struct cvmx_ipd_prc_port_ptr_fifo_ctl_s cn56xxp1;
 	struct cvmx_ipd_prc_port_ptr_fifo_ctl_s cn58xx;
 	struct cvmx_ipd_prc_port_ptr_fifo_ctl_s cn58xxp1;
+	struct cvmx_ipd_prc_port_ptr_fifo_ctl_s cn63xx;
+	struct cvmx_ipd_prc_port_ptr_fifo_ctl_s cn63xxp1;
 };
 
 union cvmx_ipd_ptr_count {
@@ -660,6 +715,8 @@ union cvmx_ipd_ptr_count {
 	struct cvmx_ipd_ptr_count_s cn56xxp1;
 	struct cvmx_ipd_ptr_count_s cn58xx;
 	struct cvmx_ipd_ptr_count_s cn58xxp1;
+	struct cvmx_ipd_ptr_count_s cn63xx;
+	struct cvmx_ipd_ptr_count_s cn63xxp1;
 };
 
 union cvmx_ipd_pwp_ptr_fifo_ctl {
@@ -683,6 +740,8 @@ union cvmx_ipd_pwp_ptr_fifo_ctl {
 	struct cvmx_ipd_pwp_ptr_fifo_ctl_s cn56xxp1;
 	struct cvmx_ipd_pwp_ptr_fifo_ctl_s cn58xx;
 	struct cvmx_ipd_pwp_ptr_fifo_ctl_s cn58xxp1;
+	struct cvmx_ipd_pwp_ptr_fifo_ctl_s cn63xx;
+	struct cvmx_ipd_pwp_ptr_fifo_ctl_s cn63xxp1;
 };
 
 union cvmx_ipd_qosx_red_marks {
@@ -702,6 +761,8 @@ union cvmx_ipd_qosx_red_marks {
 	struct cvmx_ipd_qosx_red_marks_s cn56xxp1;
 	struct cvmx_ipd_qosx_red_marks_s cn58xx;
 	struct cvmx_ipd_qosx_red_marks_s cn58xxp1;
+	struct cvmx_ipd_qosx_red_marks_s cn63xx;
+	struct cvmx_ipd_qosx_red_marks_s cn63xxp1;
 };
 
 union cvmx_ipd_que0_free_page_cnt {
@@ -721,6 +782,8 @@ union cvmx_ipd_que0_free_page_cnt {
 	struct cvmx_ipd_que0_free_page_cnt_s cn56xxp1;
 	struct cvmx_ipd_que0_free_page_cnt_s cn58xx;
 	struct cvmx_ipd_que0_free_page_cnt_s cn58xxp1;
+	struct cvmx_ipd_que0_free_page_cnt_s cn63xx;
+	struct cvmx_ipd_que0_free_page_cnt_s cn63xxp1;
 };
 
 union cvmx_ipd_red_port_enable {
@@ -741,18 +804,25 @@ union cvmx_ipd_red_port_enable {
 	struct cvmx_ipd_red_port_enable_s cn56xxp1;
 	struct cvmx_ipd_red_port_enable_s cn58xx;
 	struct cvmx_ipd_red_port_enable_s cn58xxp1;
+	struct cvmx_ipd_red_port_enable_s cn63xx;
+	struct cvmx_ipd_red_port_enable_s cn63xxp1;
 };
 
 union cvmx_ipd_red_port_enable2 {
 	uint64_t u64;
 	struct cvmx_ipd_red_port_enable2_s {
+		uint64_t reserved_8_63:56;
+		uint64_t prt_enb:8;
+	} s;
+	struct cvmx_ipd_red_port_enable2_cn52xx {
 		uint64_t reserved_4_63:60;
 		uint64_t prt_enb:4;
-	} s;
-	struct cvmx_ipd_red_port_enable2_s cn52xx;
-	struct cvmx_ipd_red_port_enable2_s cn52xxp1;
-	struct cvmx_ipd_red_port_enable2_s cn56xx;
-	struct cvmx_ipd_red_port_enable2_s cn56xxp1;
+	} cn52xx;
+	struct cvmx_ipd_red_port_enable2_cn52xx cn52xxp1;
+	struct cvmx_ipd_red_port_enable2_cn52xx cn56xx;
+	struct cvmx_ipd_red_port_enable2_cn52xx cn56xxp1;
+	struct cvmx_ipd_red_port_enable2_s cn63xx;
+	struct cvmx_ipd_red_port_enable2_s cn63xxp1;
 };
 
 union cvmx_ipd_red_quex_param {
@@ -775,6 +845,8 @@ union cvmx_ipd_red_quex_param {
 	struct cvmx_ipd_red_quex_param_s cn56xxp1;
 	struct cvmx_ipd_red_quex_param_s cn58xx;
 	struct cvmx_ipd_red_quex_param_s cn58xxp1;
+	struct cvmx_ipd_red_quex_param_s cn63xx;
+	struct cvmx_ipd_red_quex_param_s cn63xxp1;
 };
 
 union cvmx_ipd_sub_port_bp_page_cnt {
@@ -795,6 +867,8 @@ union cvmx_ipd_sub_port_bp_page_cnt {
 	struct cvmx_ipd_sub_port_bp_page_cnt_s cn56xxp1;
 	struct cvmx_ipd_sub_port_bp_page_cnt_s cn58xx;
 	struct cvmx_ipd_sub_port_bp_page_cnt_s cn58xxp1;
+	struct cvmx_ipd_sub_port_bp_page_cnt_s cn63xx;
+	struct cvmx_ipd_sub_port_bp_page_cnt_s cn63xxp1;
 };
 
 union cvmx_ipd_sub_port_fcs {
@@ -822,6 +896,8 @@ union cvmx_ipd_sub_port_fcs {
 	struct cvmx_ipd_sub_port_fcs_s cn56xxp1;
 	struct cvmx_ipd_sub_port_fcs_cn38xx cn58xx;
 	struct cvmx_ipd_sub_port_fcs_cn38xx cn58xxp1;
+	struct cvmx_ipd_sub_port_fcs_s cn63xx;
+	struct cvmx_ipd_sub_port_fcs_s cn63xxp1;
 };
 
 union cvmx_ipd_sub_port_qos_cnt {
@@ -835,6 +911,8 @@ union cvmx_ipd_sub_port_qos_cnt {
 	struct cvmx_ipd_sub_port_qos_cnt_s cn52xxp1;
 	struct cvmx_ipd_sub_port_qos_cnt_s cn56xx;
 	struct cvmx_ipd_sub_port_qos_cnt_s cn56xxp1;
+	struct cvmx_ipd_sub_port_qos_cnt_s cn63xx;
+	struct cvmx_ipd_sub_port_qos_cnt_s cn63xxp1;
 };
 
 union cvmx_ipd_wqe_fpa_queue {
@@ -854,6 +932,8 @@ union cvmx_ipd_wqe_fpa_queue {
 	struct cvmx_ipd_wqe_fpa_queue_s cn56xxp1;
 	struct cvmx_ipd_wqe_fpa_queue_s cn58xx;
 	struct cvmx_ipd_wqe_fpa_queue_s cn58xxp1;
+	struct cvmx_ipd_wqe_fpa_queue_s cn63xx;
+	struct cvmx_ipd_wqe_fpa_queue_s cn63xxp1;
 };
 
 union cvmx_ipd_wqe_ptr_valid {
@@ -872,6 +952,8 @@ union cvmx_ipd_wqe_ptr_valid {
 	struct cvmx_ipd_wqe_ptr_valid_s cn56xxp1;
 	struct cvmx_ipd_wqe_ptr_valid_s cn58xx;
 	struct cvmx_ipd_wqe_ptr_valid_s cn58xxp1;
+	struct cvmx_ipd_wqe_ptr_valid_s cn63xx;
+	struct cvmx_ipd_wqe_ptr_valid_s cn63xxp1;
 };
 
 #endif
diff --git a/arch/mips/include/asm/octeon/cvmx-l2c-defs.h b/arch/mips/include/asm/octeon/cvmx-l2c-defs.h
index 3375838..7a50a0b 100644
--- a/arch/mips/include/asm/octeon/cvmx-l2c-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-l2c-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2010 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -28,70 +28,113 @@
 #ifndef __CVMX_L2C_DEFS_H__
 #define __CVMX_L2C_DEFS_H__
 
-#define CVMX_L2C_BST0 \
-	 CVMX_ADD_IO_SEG(0x00011800800007F8ull)
-#define CVMX_L2C_BST1 \
-	 CVMX_ADD_IO_SEG(0x00011800800007F0ull)
-#define CVMX_L2C_BST2 \
-	 CVMX_ADD_IO_SEG(0x00011800800007E8ull)
-#define CVMX_L2C_CFG \
-	 CVMX_ADD_IO_SEG(0x0001180080000000ull)
-#define CVMX_L2C_DBG \
-	 CVMX_ADD_IO_SEG(0x0001180080000030ull)
-#define CVMX_L2C_DUT \
-	 CVMX_ADD_IO_SEG(0x0001180080000050ull)
-#define CVMX_L2C_GRPWRR0 \
-	 CVMX_ADD_IO_SEG(0x00011800800000C8ull)
-#define CVMX_L2C_GRPWRR1 \
-	 CVMX_ADD_IO_SEG(0x00011800800000D0ull)
-#define CVMX_L2C_INT_EN \
-	 CVMX_ADD_IO_SEG(0x0001180080000100ull)
-#define CVMX_L2C_INT_STAT \
-	 CVMX_ADD_IO_SEG(0x00011800800000F8ull)
-#define CVMX_L2C_LCKBASE \
-	 CVMX_ADD_IO_SEG(0x0001180080000058ull)
-#define CVMX_L2C_LCKOFF \
-	 CVMX_ADD_IO_SEG(0x0001180080000060ull)
-#define CVMX_L2C_LFB0 \
-	 CVMX_ADD_IO_SEG(0x0001180080000038ull)
-#define CVMX_L2C_LFB1 \
-	 CVMX_ADD_IO_SEG(0x0001180080000040ull)
-#define CVMX_L2C_LFB2 \
-	 CVMX_ADD_IO_SEG(0x0001180080000048ull)
-#define CVMX_L2C_LFB3 \
-	 CVMX_ADD_IO_SEG(0x00011800800000B8ull)
-#define CVMX_L2C_OOB \
-	 CVMX_ADD_IO_SEG(0x00011800800000D8ull)
-#define CVMX_L2C_OOB1 \
-	 CVMX_ADD_IO_SEG(0x00011800800000E0ull)
-#define CVMX_L2C_OOB2 \
-	 CVMX_ADD_IO_SEG(0x00011800800000E8ull)
-#define CVMX_L2C_OOB3 \
-	 CVMX_ADD_IO_SEG(0x00011800800000F0ull)
-#define CVMX_L2C_PFC0 \
-	 CVMX_ADD_IO_SEG(0x0001180080000098ull)
-#define CVMX_L2C_PFC1 \
-	 CVMX_ADD_IO_SEG(0x00011800800000A0ull)
-#define CVMX_L2C_PFC2 \
-	 CVMX_ADD_IO_SEG(0x00011800800000A8ull)
-#define CVMX_L2C_PFC3 \
-	 CVMX_ADD_IO_SEG(0x00011800800000B0ull)
-#define CVMX_L2C_PFCTL \
-	 CVMX_ADD_IO_SEG(0x0001180080000090ull)
-#define CVMX_L2C_PFCX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180080000098ull + (((offset) & 3) * 8))
-#define CVMX_L2C_PPGRP \
-	 CVMX_ADD_IO_SEG(0x00011800800000C0ull)
-#define CVMX_L2C_SPAR0 \
-	 CVMX_ADD_IO_SEG(0x0001180080000068ull)
-#define CVMX_L2C_SPAR1 \
-	 CVMX_ADD_IO_SEG(0x0001180080000070ull)
-#define CVMX_L2C_SPAR2 \
-	 CVMX_ADD_IO_SEG(0x0001180080000078ull)
-#define CVMX_L2C_SPAR3 \
-	 CVMX_ADD_IO_SEG(0x0001180080000080ull)
-#define CVMX_L2C_SPAR4 \
-	 CVMX_ADD_IO_SEG(0x0001180080000088ull)
+#define CVMX_L2C_BIG_CTL (CVMX_ADD_IO_SEG(0x0001180080800030ull))
+#define CVMX_L2C_BST (CVMX_ADD_IO_SEG(0x00011800808007F8ull))
+#define CVMX_L2C_BST0 (CVMX_ADD_IO_SEG(0x00011800800007F8ull))
+#define CVMX_L2C_BST1 (CVMX_ADD_IO_SEG(0x00011800800007F0ull))
+#define CVMX_L2C_BST2 (CVMX_ADD_IO_SEG(0x00011800800007E8ull))
+#define CVMX_L2C_BST_MEMX(block_id) (CVMX_ADD_IO_SEG(0x0001180080C007F8ull))
+#define CVMX_L2C_BST_TDTX(block_id) (CVMX_ADD_IO_SEG(0x0001180080A007F0ull))
+#define CVMX_L2C_BST_TTGX(block_id) (CVMX_ADD_IO_SEG(0x0001180080A007F8ull))
+#define CVMX_L2C_CFG (CVMX_ADD_IO_SEG(0x0001180080000000ull))
+#define CVMX_L2C_COP0_MAPX(offset) (CVMX_ADD_IO_SEG(0x0001180080940000ull) + ((offset) & 16383) * 8)
+#define CVMX_L2C_CTL (CVMX_ADD_IO_SEG(0x0001180080800000ull))
+#define CVMX_L2C_DBG (CVMX_ADD_IO_SEG(0x0001180080000030ull))
+#define CVMX_L2C_DUT (CVMX_ADD_IO_SEG(0x0001180080000050ull))
+#define CVMX_L2C_DUT_MAPX(offset) (CVMX_ADD_IO_SEG(0x0001180080E00000ull) + ((offset) & 2047) * 8)
+#define CVMX_L2C_ERR_TDTX(block_id) (CVMX_ADD_IO_SEG(0x0001180080A007E0ull))
+#define CVMX_L2C_ERR_TTGX(block_id) (CVMX_ADD_IO_SEG(0x0001180080A007E8ull))
+#define CVMX_L2C_ERR_VBFX(block_id) (CVMX_ADD_IO_SEG(0x0001180080C007F0ull))
+#define CVMX_L2C_ERR_XMC (CVMX_ADD_IO_SEG(0x00011800808007D8ull))
+#define CVMX_L2C_GRPWRR0 (CVMX_ADD_IO_SEG(0x00011800800000C8ull))
+#define CVMX_L2C_GRPWRR1 (CVMX_ADD_IO_SEG(0x00011800800000D0ull))
+#define CVMX_L2C_INT_EN (CVMX_ADD_IO_SEG(0x0001180080000100ull))
+#define CVMX_L2C_INT_ENA (CVMX_ADD_IO_SEG(0x0001180080800020ull))
+#define CVMX_L2C_INT_REG (CVMX_ADD_IO_SEG(0x0001180080800018ull))
+#define CVMX_L2C_INT_STAT (CVMX_ADD_IO_SEG(0x00011800800000F8ull))
+#define CVMX_L2C_IOCX_PFC(block_id) (CVMX_ADD_IO_SEG(0x0001180080800420ull))
+#define CVMX_L2C_IORX_PFC(block_id) (CVMX_ADD_IO_SEG(0x0001180080800428ull))
+#define CVMX_L2C_LCKBASE (CVMX_ADD_IO_SEG(0x0001180080000058ull))
+#define CVMX_L2C_LCKOFF (CVMX_ADD_IO_SEG(0x0001180080000060ull))
+#define CVMX_L2C_LFB0 (CVMX_ADD_IO_SEG(0x0001180080000038ull))
+#define CVMX_L2C_LFB1 (CVMX_ADD_IO_SEG(0x0001180080000040ull))
+#define CVMX_L2C_LFB2 (CVMX_ADD_IO_SEG(0x0001180080000048ull))
+#define CVMX_L2C_LFB3 (CVMX_ADD_IO_SEG(0x00011800800000B8ull))
+#define CVMX_L2C_OOB (CVMX_ADD_IO_SEG(0x00011800800000D8ull))
+#define CVMX_L2C_OOB1 (CVMX_ADD_IO_SEG(0x00011800800000E0ull))
+#define CVMX_L2C_OOB2 (CVMX_ADD_IO_SEG(0x00011800800000E8ull))
+#define CVMX_L2C_OOB3 (CVMX_ADD_IO_SEG(0x00011800800000F0ull))
+#define CVMX_L2C_PFC0 CVMX_L2C_PFCX(0)
+#define CVMX_L2C_PFC1 CVMX_L2C_PFCX(1)
+#define CVMX_L2C_PFC2 CVMX_L2C_PFCX(2)
+#define CVMX_L2C_PFC3 CVMX_L2C_PFCX(3)
+#define CVMX_L2C_PFCTL (CVMX_ADD_IO_SEG(0x0001180080000090ull))
+#define CVMX_L2C_PFCX(offset) (CVMX_ADD_IO_SEG(0x0001180080000098ull) + ((offset) & 3) * 8)
+#define CVMX_L2C_PPGRP (CVMX_ADD_IO_SEG(0x00011800800000C0ull))
+#define CVMX_L2C_QOS_IOBX(block_id) (CVMX_ADD_IO_SEG(0x0001180080880200ull))
+#define CVMX_L2C_QOS_PPX(offset) (CVMX_ADD_IO_SEG(0x0001180080880000ull) + ((offset) & 7) * 8)
+#define CVMX_L2C_QOS_WGT (CVMX_ADD_IO_SEG(0x0001180080800008ull))
+#define CVMX_L2C_RSCX_PFC(block_id) (CVMX_ADD_IO_SEG(0x0001180080800410ull))
+#define CVMX_L2C_RSDX_PFC(block_id) (CVMX_ADD_IO_SEG(0x0001180080800418ull))
+#define CVMX_L2C_SPAR0 (CVMX_ADD_IO_SEG(0x0001180080000068ull))
+#define CVMX_L2C_SPAR1 (CVMX_ADD_IO_SEG(0x0001180080000070ull))
+#define CVMX_L2C_SPAR2 (CVMX_ADD_IO_SEG(0x0001180080000078ull))
+#define CVMX_L2C_SPAR3 (CVMX_ADD_IO_SEG(0x0001180080000080ull))
+#define CVMX_L2C_SPAR4 (CVMX_ADD_IO_SEG(0x0001180080000088ull))
+#define CVMX_L2C_TADX_ECC0(block_id) (CVMX_ADD_IO_SEG(0x0001180080A00018ull))
+#define CVMX_L2C_TADX_ECC1(block_id) (CVMX_ADD_IO_SEG(0x0001180080A00020ull))
+#define CVMX_L2C_TADX_IEN(block_id) (CVMX_ADD_IO_SEG(0x0001180080A00000ull))
+#define CVMX_L2C_TADX_INT(block_id) (CVMX_ADD_IO_SEG(0x0001180080A00028ull))
+#define CVMX_L2C_TADX_PFC0(block_id) (CVMX_ADD_IO_SEG(0x0001180080A00400ull))
+#define CVMX_L2C_TADX_PFC1(block_id) (CVMX_ADD_IO_SEG(0x0001180080A00408ull))
+#define CVMX_L2C_TADX_PFC2(block_id) (CVMX_ADD_IO_SEG(0x0001180080A00410ull))
+#define CVMX_L2C_TADX_PFC3(block_id) (CVMX_ADD_IO_SEG(0x0001180080A00418ull))
+#define CVMX_L2C_TADX_PRF(block_id) (CVMX_ADD_IO_SEG(0x0001180080A00008ull))
+#define CVMX_L2C_TADX_TAG(block_id) (CVMX_ADD_IO_SEG(0x0001180080A00010ull))
+#define CVMX_L2C_VER_ID (CVMX_ADD_IO_SEG(0x00011800808007E0ull))
+#define CVMX_L2C_VER_IOB (CVMX_ADD_IO_SEG(0x00011800808007F0ull))
+#define CVMX_L2C_VER_MSC (CVMX_ADD_IO_SEG(0x00011800808007D0ull))
+#define CVMX_L2C_VER_PP (CVMX_ADD_IO_SEG(0x00011800808007E8ull))
+#define CVMX_L2C_VIRTID_IOBX(block_id) (CVMX_ADD_IO_SEG(0x00011800808C0200ull))
+#define CVMX_L2C_VIRTID_PPX(offset) (CVMX_ADD_IO_SEG(0x00011800808C0000ull) + ((offset) & 7) * 8)
+#define CVMX_L2C_VRT_CTL (CVMX_ADD_IO_SEG(0x0001180080800010ull))
+#define CVMX_L2C_VRT_MEMX(offset) (CVMX_ADD_IO_SEG(0x0001180080900000ull) + ((offset) & 1023) * 8)
+#define CVMX_L2C_WPAR_IOBX(block_id) (CVMX_ADD_IO_SEG(0x0001180080840200ull))
+#define CVMX_L2C_WPAR_PPX(offset) (CVMX_ADD_IO_SEG(0x0001180080840000ull) + ((offset) & 7) * 8)
+#define CVMX_L2C_XMCX_PFC(block_id) (CVMX_ADD_IO_SEG(0x0001180080800400ull))
+#define CVMX_L2C_XMC_CMD (CVMX_ADD_IO_SEG(0x0001180080800028ull))
+#define CVMX_L2C_XMDX_PFC(block_id) (CVMX_ADD_IO_SEG(0x0001180080800408ull))
+
+union cvmx_l2c_big_ctl {
+	uint64_t u64;
+	struct cvmx_l2c_big_ctl_s {
+		uint64_t reserved_8_63:56;
+		uint64_t maxdram:4;
+		uint64_t reserved_1_3:3;
+		uint64_t disable:1;
+	} s;
+	struct cvmx_l2c_big_ctl_s cn63xx;
+};
+
+union cvmx_l2c_bst {
+	uint64_t u64;
+	struct cvmx_l2c_bst_s {
+		uint64_t reserved_38_63:26;
+		uint64_t dutfl:6;
+		uint64_t reserved_17_31:15;
+		uint64_t ioccmdfl:1;
+		uint64_t reserved_13_15:3;
+		uint64_t iocdatfl:1;
+		uint64_t reserved_9_11:3;
+		uint64_t dutresfl:1;
+		uint64_t reserved_5_7:3;
+		uint64_t vrtfl:1;
+		uint64_t reserved_1_3:3;
+		uint64_t tdffl:1;
+	} s;
+	struct cvmx_l2c_bst_s cn63xx;
+	struct cvmx_l2c_bst_s cn63xxp1;
+};
 
 union cvmx_l2c_bst0 {
 	uint64_t u64;
@@ -253,6 +296,48 @@ union cvmx_l2c_bst2 {
 	struct cvmx_l2c_bst2_cn56xx cn58xxp1;
 };
 
+union cvmx_l2c_bst_memx {
+	uint64_t u64;
+	struct cvmx_l2c_bst_memx_s {
+		uint64_t start_bist:1;
+		uint64_t clear_bist:1;
+		uint64_t reserved_5_61:57;
+		uint64_t rdffl:1;
+		uint64_t vbffl:4;
+	} s;
+	struct cvmx_l2c_bst_memx_s cn63xx;
+	struct cvmx_l2c_bst_memx_s cn63xxp1;
+};
+
+union cvmx_l2c_bst_tdtx {
+	uint64_t u64;
+	struct cvmx_l2c_bst_tdtx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t fbfrspfl:8;
+		uint64_t sbffl:8;
+		uint64_t fbffl:8;
+		uint64_t l2dfl:8;
+	} s;
+	struct cvmx_l2c_bst_tdtx_s cn63xx;
+	struct cvmx_l2c_bst_tdtx_cn63xxp1 {
+		uint64_t reserved_24_63:40;
+		uint64_t sbffl:8;
+		uint64_t fbffl:8;
+		uint64_t l2dfl:8;
+	} cn63xxp1;
+};
+
+union cvmx_l2c_bst_ttgx {
+	uint64_t u64;
+	struct cvmx_l2c_bst_ttgx_s {
+		uint64_t reserved_17_63:47;
+		uint64_t lrufl:1;
+		uint64_t tagfl:16;
+	} s;
+	struct cvmx_l2c_bst_ttgx_s cn63xx;
+	struct cvmx_l2c_bst_ttgx_s cn63xxp1;
+};
+
 union cvmx_l2c_cfg {
 	uint64_t u64;
 	struct cvmx_l2c_cfg_s {
@@ -333,6 +418,49 @@ union cvmx_l2c_cfg {
 	} cn58xxp1;
 };
 
+union cvmx_l2c_cop0_mapx {
+	uint64_t u64;
+	struct cvmx_l2c_cop0_mapx_s {
+		uint64_t data:64;
+	} s;
+	struct cvmx_l2c_cop0_mapx_s cn63xx;
+	struct cvmx_l2c_cop0_mapx_s cn63xxp1;
+};
+
+union cvmx_l2c_ctl {
+	uint64_t u64;
+	struct cvmx_l2c_ctl_s {
+		uint64_t reserved_28_63:36;
+		uint64_t disstgl2i:1;
+		uint64_t l2dfsbe:1;
+		uint64_t l2dfdbe:1;
+		uint64_t discclk:1;
+		uint64_t maxvab:4;
+		uint64_t maxlfb:4;
+		uint64_t rsp_arb_mode:1;
+		uint64_t xmc_arb_mode:1;
+		uint64_t ef_ena:1;
+		uint64_t ef_cnt:7;
+		uint64_t vab_thresh:4;
+		uint64_t disecc:1;
+		uint64_t disidxalias:1;
+	} s;
+	struct cvmx_l2c_ctl_s cn63xx;
+	struct cvmx_l2c_ctl_cn63xxp1 {
+		uint64_t reserved_25_63:39;
+		uint64_t discclk:1;
+		uint64_t maxvab:4;
+		uint64_t maxlfb:4;
+		uint64_t rsp_arb_mode:1;
+		uint64_t xmc_arb_mode:1;
+		uint64_t ef_ena:1;
+		uint64_t ef_cnt:7;
+		uint64_t vab_thresh:4;
+		uint64_t disecc:1;
+		uint64_t disidxalias:1;
+	} cn63xxp1;
+};
+
 union cvmx_l2c_dbg {
 	uint64_t u64;
 	struct cvmx_l2c_dbg_s {
@@ -349,7 +477,9 @@ union cvmx_l2c_dbg {
 		uint64_t reserved_13_63:51;
 		uint64_t lfb_enum:2;
 		uint64_t lfb_dmp:1;
-		uint64_t reserved_5_9:5;
+		uint64_t reserved_7_9:3;
+		uint64_t ppnum:1;
+		uint64_t reserved_5_5:1;
 		uint64_t set:2;
 		uint64_t finv:1;
 		uint64_t l2d:1;
@@ -420,6 +550,79 @@ union cvmx_l2c_dut {
 	struct cvmx_l2c_dut_s cn58xxp1;
 };
 
+union cvmx_l2c_dut_mapx {
+	uint64_t u64;
+	struct cvmx_l2c_dut_mapx_s {
+		uint64_t reserved_38_63:26;
+		uint64_t tag:28;
+		uint64_t reserved_1_9:9;
+		uint64_t valid:1;
+	} s;
+	struct cvmx_l2c_dut_mapx_s cn63xx;
+	struct cvmx_l2c_dut_mapx_s cn63xxp1;
+};
+
+union cvmx_l2c_err_tdtx {
+	uint64_t u64;
+	struct cvmx_l2c_err_tdtx_s {
+		uint64_t dbe:1;
+		uint64_t sbe:1;
+		uint64_t vdbe:1;
+		uint64_t vsbe:1;
+		uint64_t syn:10;
+		uint64_t reserved_21_49:29;
+		uint64_t wayidx:17;
+		uint64_t reserved_2_3:2;
+		uint64_t type:2;
+	} s;
+	struct cvmx_l2c_err_tdtx_s cn63xx;
+	struct cvmx_l2c_err_tdtx_s cn63xxp1;
+};
+
+union cvmx_l2c_err_ttgx {
+	uint64_t u64;
+	struct cvmx_l2c_err_ttgx_s {
+		uint64_t dbe:1;
+		uint64_t sbe:1;
+		uint64_t noway:1;
+		uint64_t reserved_56_60:5;
+		uint64_t syn:6;
+		uint64_t reserved_21_49:29;
+		uint64_t wayidx:14;
+		uint64_t reserved_2_6:5;
+		uint64_t type:2;
+	} s;
+	struct cvmx_l2c_err_ttgx_s cn63xx;
+	struct cvmx_l2c_err_ttgx_s cn63xxp1;
+};
+
+union cvmx_l2c_err_vbfx {
+	uint64_t u64;
+	struct cvmx_l2c_err_vbfx_s {
+		uint64_t reserved_62_63:2;
+		uint64_t vdbe:1;
+		uint64_t vsbe:1;
+		uint64_t vsyn:10;
+		uint64_t reserved_2_49:48;
+		uint64_t type:2;
+	} s;
+	struct cvmx_l2c_err_vbfx_s cn63xx;
+	struct cvmx_l2c_err_vbfx_s cn63xxp1;
+};
+
+union cvmx_l2c_err_xmc {
+	uint64_t u64;
+	struct cvmx_l2c_err_xmc_s {
+		uint64_t cmd:6;
+		uint64_t reserved_52_57:6;
+		uint64_t sid:4;
+		uint64_t reserved_38_47:10;
+		uint64_t addr:38;
+	} s;
+	struct cvmx_l2c_err_xmc_s cn63xx;
+	struct cvmx_l2c_err_xmc_s cn63xxp1;
+};
+
 union cvmx_l2c_grpwrr0 {
 	uint64_t u64;
 	struct cvmx_l2c_grpwrr0_s {
@@ -464,6 +667,60 @@ union cvmx_l2c_int_en {
 	struct cvmx_l2c_int_en_s cn56xxp1;
 };
 
+union cvmx_l2c_int_ena {
+	uint64_t u64;
+	struct cvmx_l2c_int_ena_s {
+		uint64_t reserved_8_63:56;
+		uint64_t bigrd:1;
+		uint64_t bigwr:1;
+		uint64_t vrtpe:1;
+		uint64_t vrtadrng:1;
+		uint64_t vrtidrng:1;
+		uint64_t vrtwr:1;
+		uint64_t holewr:1;
+		uint64_t holerd:1;
+	} s;
+	struct cvmx_l2c_int_ena_s cn63xx;
+	struct cvmx_l2c_int_ena_cn63xxp1 {
+		uint64_t reserved_6_63:58;
+		uint64_t vrtpe:1;
+		uint64_t vrtadrng:1;
+		uint64_t vrtidrng:1;
+		uint64_t vrtwr:1;
+		uint64_t holewr:1;
+		uint64_t holerd:1;
+	} cn63xxp1;
+};
+
+union cvmx_l2c_int_reg {
+	uint64_t u64;
+	struct cvmx_l2c_int_reg_s {
+		uint64_t reserved_17_63:47;
+		uint64_t tad0:1;
+		uint64_t reserved_8_15:8;
+		uint64_t bigrd:1;
+		uint64_t bigwr:1;
+		uint64_t vrtpe:1;
+		uint64_t vrtadrng:1;
+		uint64_t vrtidrng:1;
+		uint64_t vrtwr:1;
+		uint64_t holewr:1;
+		uint64_t holerd:1;
+	} s;
+	struct cvmx_l2c_int_reg_s cn63xx;
+	struct cvmx_l2c_int_reg_cn63xxp1 {
+		uint64_t reserved_17_63:47;
+		uint64_t tad0:1;
+		uint64_t reserved_6_15:10;
+		uint64_t vrtpe:1;
+		uint64_t vrtadrng:1;
+		uint64_t vrtidrng:1;
+		uint64_t vrtwr:1;
+		uint64_t holewr:1;
+		uint64_t holerd:1;
+	} cn63xxp1;
+};
+
 union cvmx_l2c_int_stat {
 	uint64_t u64;
 	struct cvmx_l2c_int_stat_s {
@@ -484,6 +741,24 @@ union cvmx_l2c_int_stat {
 	struct cvmx_l2c_int_stat_s cn56xxp1;
 };
 
+union cvmx_l2c_iocx_pfc {
+	uint64_t u64;
+	struct cvmx_l2c_iocx_pfc_s {
+		uint64_t count:64;
+	} s;
+	struct cvmx_l2c_iocx_pfc_s cn63xx;
+	struct cvmx_l2c_iocx_pfc_s cn63xxp1;
+};
+
+union cvmx_l2c_iorx_pfc {
+	uint64_t u64;
+	struct cvmx_l2c_iorx_pfc_s {
+		uint64_t count:64;
+	} s;
+	struct cvmx_l2c_iorx_pfc_s cn63xx;
+	struct cvmx_l2c_iorx_pfc_s cn63xxp1;
+};
+
 union cvmx_l2c_lckbase {
 	uint64_t u64;
 	struct cvmx_l2c_lckbase_s {
@@ -855,6 +1130,59 @@ union cvmx_l2c_ppgrp {
 	struct cvmx_l2c_ppgrp_s cn56xxp1;
 };
 
+union cvmx_l2c_qos_iobx {
+	uint64_t u64;
+	struct cvmx_l2c_qos_iobx_s {
+		uint64_t reserved_6_63:58;
+		uint64_t dwblvl:2;
+		uint64_t reserved_2_3:2;
+		uint64_t lvl:2;
+	} s;
+	struct cvmx_l2c_qos_iobx_s cn63xx;
+	struct cvmx_l2c_qos_iobx_s cn63xxp1;
+};
+
+union cvmx_l2c_qos_ppx {
+	uint64_t u64;
+	struct cvmx_l2c_qos_ppx_s {
+		uint64_t reserved_2_63:62;
+		uint64_t lvl:2;
+	} s;
+	struct cvmx_l2c_qos_ppx_s cn63xx;
+	struct cvmx_l2c_qos_ppx_s cn63xxp1;
+};
+
+union cvmx_l2c_qos_wgt {
+	uint64_t u64;
+	struct cvmx_l2c_qos_wgt_s {
+		uint64_t reserved_32_63:32;
+		uint64_t wgt3:8;
+		uint64_t wgt2:8;
+		uint64_t wgt1:8;
+		uint64_t wgt0:8;
+	} s;
+	struct cvmx_l2c_qos_wgt_s cn63xx;
+	struct cvmx_l2c_qos_wgt_s cn63xxp1;
+};
+
+union cvmx_l2c_rscx_pfc {
+	uint64_t u64;
+	struct cvmx_l2c_rscx_pfc_s {
+		uint64_t count:64;
+	} s;
+	struct cvmx_l2c_rscx_pfc_s cn63xx;
+	struct cvmx_l2c_rscx_pfc_s cn63xxp1;
+};
+
+union cvmx_l2c_rsdx_pfc {
+	uint64_t u64;
+	struct cvmx_l2c_rsdx_pfc_s {
+		uint64_t count:64;
+	} s;
+	struct cvmx_l2c_rsdx_pfc_s cn63xx;
+	struct cvmx_l2c_rsdx_pfc_s cn63xxp1;
+};
+
 union cvmx_l2c_spar0 {
 	uint64_t u64;
 	struct cvmx_l2c_spar0_s {
@@ -960,4 +1288,282 @@ union cvmx_l2c_spar4 {
 	struct cvmx_l2c_spar4_s cn58xxp1;
 };
 
+union cvmx_l2c_tadx_ecc0 {
+	uint64_t u64;
+	struct cvmx_l2c_tadx_ecc0_s {
+		uint64_t reserved_58_63:6;
+		uint64_t ow3ecc:10;
+		uint64_t reserved_42_47:6;
+		uint64_t ow2ecc:10;
+		uint64_t reserved_26_31:6;
+		uint64_t ow1ecc:10;
+		uint64_t reserved_10_15:6;
+		uint64_t ow0ecc:10;
+	} s;
+	struct cvmx_l2c_tadx_ecc0_s cn63xx;
+	struct cvmx_l2c_tadx_ecc0_s cn63xxp1;
+};
+
+union cvmx_l2c_tadx_ecc1 {
+	uint64_t u64;
+	struct cvmx_l2c_tadx_ecc1_s {
+		uint64_t reserved_58_63:6;
+		uint64_t ow7ecc:10;
+		uint64_t reserved_42_47:6;
+		uint64_t ow6ecc:10;
+		uint64_t reserved_26_31:6;
+		uint64_t ow5ecc:10;
+		uint64_t reserved_10_15:6;
+		uint64_t ow4ecc:10;
+	} s;
+	struct cvmx_l2c_tadx_ecc1_s cn63xx;
+	struct cvmx_l2c_tadx_ecc1_s cn63xxp1;
+};
+
+union cvmx_l2c_tadx_ien {
+	uint64_t u64;
+	struct cvmx_l2c_tadx_ien_s {
+		uint64_t reserved_9_63:55;
+		uint64_t wrdislmc:1;
+		uint64_t rddislmc:1;
+		uint64_t noway:1;
+		uint64_t vbfdbe:1;
+		uint64_t vbfsbe:1;
+		uint64_t tagdbe:1;
+		uint64_t tagsbe:1;
+		uint64_t l2ddbe:1;
+		uint64_t l2dsbe:1;
+	} s;
+	struct cvmx_l2c_tadx_ien_s cn63xx;
+	struct cvmx_l2c_tadx_ien_cn63xxp1 {
+		uint64_t reserved_7_63:57;
+		uint64_t noway:1;
+		uint64_t vbfdbe:1;
+		uint64_t vbfsbe:1;
+		uint64_t tagdbe:1;
+		uint64_t tagsbe:1;
+		uint64_t l2ddbe:1;
+		uint64_t l2dsbe:1;
+	} cn63xxp1;
+};
+
+union cvmx_l2c_tadx_int {
+	uint64_t u64;
+	struct cvmx_l2c_tadx_int_s {
+		uint64_t reserved_9_63:55;
+		uint64_t wrdislmc:1;
+		uint64_t rddislmc:1;
+		uint64_t noway:1;
+		uint64_t vbfdbe:1;
+		uint64_t vbfsbe:1;
+		uint64_t tagdbe:1;
+		uint64_t tagsbe:1;
+		uint64_t l2ddbe:1;
+		uint64_t l2dsbe:1;
+	} s;
+	struct cvmx_l2c_tadx_int_s cn63xx;
+};
+
+union cvmx_l2c_tadx_pfc0 {
+	uint64_t u64;
+	struct cvmx_l2c_tadx_pfc0_s {
+		uint64_t count:64;
+	} s;
+	struct cvmx_l2c_tadx_pfc0_s cn63xx;
+	struct cvmx_l2c_tadx_pfc0_s cn63xxp1;
+};
+
+union cvmx_l2c_tadx_pfc1 {
+	uint64_t u64;
+	struct cvmx_l2c_tadx_pfc1_s {
+		uint64_t count:64;
+	} s;
+	struct cvmx_l2c_tadx_pfc1_s cn63xx;
+	struct cvmx_l2c_tadx_pfc1_s cn63xxp1;
+};
+
+union cvmx_l2c_tadx_pfc2 {
+	uint64_t u64;
+	struct cvmx_l2c_tadx_pfc2_s {
+		uint64_t count:64;
+	} s;
+	struct cvmx_l2c_tadx_pfc2_s cn63xx;
+	struct cvmx_l2c_tadx_pfc2_s cn63xxp1;
+};
+
+union cvmx_l2c_tadx_pfc3 {
+	uint64_t u64;
+	struct cvmx_l2c_tadx_pfc3_s {
+		uint64_t count:64;
+	} s;
+	struct cvmx_l2c_tadx_pfc3_s cn63xx;
+	struct cvmx_l2c_tadx_pfc3_s cn63xxp1;
+};
+
+union cvmx_l2c_tadx_prf {
+	uint64_t u64;
+	struct cvmx_l2c_tadx_prf_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt3sel:8;
+		uint64_t cnt2sel:8;
+		uint64_t cnt1sel:8;
+		uint64_t cnt0sel:8;
+	} s;
+	struct cvmx_l2c_tadx_prf_s cn63xx;
+	struct cvmx_l2c_tadx_prf_s cn63xxp1;
+};
+
+union cvmx_l2c_tadx_tag {
+	uint64_t u64;
+	struct cvmx_l2c_tadx_tag_s {
+		uint64_t reserved_46_63:18;
+		uint64_t ecc:6;
+		uint64_t reserved_36_39:4;
+		uint64_t tag:19;
+		uint64_t reserved_4_16:13;
+		uint64_t use:1;
+		uint64_t valid:1;
+		uint64_t dirty:1;
+		uint64_t lock:1;
+	} s;
+	struct cvmx_l2c_tadx_tag_s cn63xx;
+	struct cvmx_l2c_tadx_tag_s cn63xxp1;
+};
+
+union cvmx_l2c_ver_id {
+	uint64_t u64;
+	struct cvmx_l2c_ver_id_s {
+		uint64_t mask:64;
+	} s;
+	struct cvmx_l2c_ver_id_s cn63xx;
+	struct cvmx_l2c_ver_id_s cn63xxp1;
+};
+
+union cvmx_l2c_ver_iob {
+	uint64_t u64;
+	struct cvmx_l2c_ver_iob_s {
+		uint64_t reserved_1_63:63;
+		uint64_t mask:1;
+	} s;
+	struct cvmx_l2c_ver_iob_s cn63xx;
+	struct cvmx_l2c_ver_iob_s cn63xxp1;
+};
+
+union cvmx_l2c_ver_msc {
+	uint64_t u64;
+	struct cvmx_l2c_ver_msc_s {
+		uint64_t reserved_2_63:62;
+		uint64_t invl2:1;
+		uint64_t dwb:1;
+	} s;
+	struct cvmx_l2c_ver_msc_s cn63xx;
+};
+
+union cvmx_l2c_ver_pp {
+	uint64_t u64;
+	struct cvmx_l2c_ver_pp_s {
+		uint64_t reserved_6_63:58;
+		uint64_t mask:6;
+	} s;
+	struct cvmx_l2c_ver_pp_s cn63xx;
+	struct cvmx_l2c_ver_pp_s cn63xxp1;
+};
+
+union cvmx_l2c_virtid_iobx {
+	uint64_t u64;
+	struct cvmx_l2c_virtid_iobx_s {
+		uint64_t reserved_14_63:50;
+		uint64_t dwbid:6;
+		uint64_t reserved_6_7:2;
+		uint64_t id:6;
+	} s;
+	struct cvmx_l2c_virtid_iobx_s cn63xx;
+	struct cvmx_l2c_virtid_iobx_s cn63xxp1;
+};
+
+union cvmx_l2c_virtid_ppx {
+	uint64_t u64;
+	struct cvmx_l2c_virtid_ppx_s {
+		uint64_t reserved_6_63:58;
+		uint64_t id:6;
+	} s;
+	struct cvmx_l2c_virtid_ppx_s cn63xx;
+	struct cvmx_l2c_virtid_ppx_s cn63xxp1;
+};
+
+union cvmx_l2c_vrt_ctl {
+	uint64_t u64;
+	struct cvmx_l2c_vrt_ctl_s {
+		uint64_t reserved_9_63:55;
+		uint64_t ooberr:1;
+		uint64_t reserved_7_7:1;
+		uint64_t memsz:3;
+		uint64_t numid:3;
+		uint64_t enable:1;
+	} s;
+	struct cvmx_l2c_vrt_ctl_s cn63xx;
+	struct cvmx_l2c_vrt_ctl_s cn63xxp1;
+};
+
+union cvmx_l2c_vrt_memx {
+	uint64_t u64;
+	struct cvmx_l2c_vrt_memx_s {
+		uint64_t reserved_36_63:28;
+		uint64_t parity:4;
+		uint64_t data:32;
+	} s;
+	struct cvmx_l2c_vrt_memx_s cn63xx;
+	struct cvmx_l2c_vrt_memx_s cn63xxp1;
+};
+
+union cvmx_l2c_wpar_iobx {
+	uint64_t u64;
+	struct cvmx_l2c_wpar_iobx_s {
+		uint64_t reserved_16_63:48;
+		uint64_t mask:16;
+	} s;
+	struct cvmx_l2c_wpar_iobx_s cn63xx;
+	struct cvmx_l2c_wpar_iobx_s cn63xxp1;
+};
+
+union cvmx_l2c_wpar_ppx {
+	uint64_t u64;
+	struct cvmx_l2c_wpar_ppx_s {
+		uint64_t reserved_16_63:48;
+		uint64_t mask:16;
+	} s;
+	struct cvmx_l2c_wpar_ppx_s cn63xx;
+	struct cvmx_l2c_wpar_ppx_s cn63xxp1;
+};
+
+union cvmx_l2c_xmcx_pfc {
+	uint64_t u64;
+	struct cvmx_l2c_xmcx_pfc_s {
+		uint64_t count:64;
+	} s;
+	struct cvmx_l2c_xmcx_pfc_s cn63xx;
+	struct cvmx_l2c_xmcx_pfc_s cn63xxp1;
+};
+
+union cvmx_l2c_xmc_cmd {
+	uint64_t u64;
+	struct cvmx_l2c_xmc_cmd_s {
+		uint64_t inuse:1;
+		uint64_t cmd:6;
+		uint64_t reserved_38_56:19;
+		uint64_t addr:38;
+	} s;
+	struct cvmx_l2c_xmc_cmd_s cn63xx;
+	struct cvmx_l2c_xmc_cmd_s cn63xxp1;
+};
+
+union cvmx_l2c_xmdx_pfc {
+	uint64_t u64;
+	struct cvmx_l2c_xmdx_pfc_s {
+		uint64_t count:64;
+	} s;
+	struct cvmx_l2c_xmdx_pfc_s cn63xx;
+	struct cvmx_l2c_xmdx_pfc_s cn63xxp1;
+};
+
 #endif
diff --git a/arch/mips/include/asm/octeon/cvmx-l2d-defs.h b/arch/mips/include/asm/octeon/cvmx-l2d-defs.h
index d7102d4..60543e0 100644
--- a/arch/mips/include/asm/octeon/cvmx-l2d-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-l2d-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2010 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -28,30 +28,18 @@
 #ifndef __CVMX_L2D_DEFS_H__
 #define __CVMX_L2D_DEFS_H__
 
-#define CVMX_L2D_BST0 \
-	 CVMX_ADD_IO_SEG(0x0001180080000780ull)
-#define CVMX_L2D_BST1 \
-	 CVMX_ADD_IO_SEG(0x0001180080000788ull)
-#define CVMX_L2D_BST2 \
-	 CVMX_ADD_IO_SEG(0x0001180080000790ull)
-#define CVMX_L2D_BST3 \
-	 CVMX_ADD_IO_SEG(0x0001180080000798ull)
-#define CVMX_L2D_ERR \
-	 CVMX_ADD_IO_SEG(0x0001180080000010ull)
-#define CVMX_L2D_FADR \
-	 CVMX_ADD_IO_SEG(0x0001180080000018ull)
-#define CVMX_L2D_FSYN0 \
-	 CVMX_ADD_IO_SEG(0x0001180080000020ull)
-#define CVMX_L2D_FSYN1 \
-	 CVMX_ADD_IO_SEG(0x0001180080000028ull)
-#define CVMX_L2D_FUS0 \
-	 CVMX_ADD_IO_SEG(0x00011800800007A0ull)
-#define CVMX_L2D_FUS1 \
-	 CVMX_ADD_IO_SEG(0x00011800800007A8ull)
-#define CVMX_L2D_FUS2 \
-	 CVMX_ADD_IO_SEG(0x00011800800007B0ull)
-#define CVMX_L2D_FUS3 \
-	 CVMX_ADD_IO_SEG(0x00011800800007B8ull)
+#define CVMX_L2D_BST0 (CVMX_ADD_IO_SEG(0x0001180080000780ull))
+#define CVMX_L2D_BST1 (CVMX_ADD_IO_SEG(0x0001180080000788ull))
+#define CVMX_L2D_BST2 (CVMX_ADD_IO_SEG(0x0001180080000790ull))
+#define CVMX_L2D_BST3 (CVMX_ADD_IO_SEG(0x0001180080000798ull))
+#define CVMX_L2D_ERR (CVMX_ADD_IO_SEG(0x0001180080000010ull))
+#define CVMX_L2D_FADR (CVMX_ADD_IO_SEG(0x0001180080000018ull))
+#define CVMX_L2D_FSYN0 (CVMX_ADD_IO_SEG(0x0001180080000020ull))
+#define CVMX_L2D_FSYN1 (CVMX_ADD_IO_SEG(0x0001180080000028ull))
+#define CVMX_L2D_FUS0 (CVMX_ADD_IO_SEG(0x00011800800007A0ull))
+#define CVMX_L2D_FUS1 (CVMX_ADD_IO_SEG(0x00011800800007A8ull))
+#define CVMX_L2D_FUS2 (CVMX_ADD_IO_SEG(0x00011800800007B0ull))
+#define CVMX_L2D_FUS3 (CVMX_ADD_IO_SEG(0x00011800800007B8ull))
 
 union cvmx_l2d_bst0 {
 	uint64_t u64;
diff --git a/arch/mips/include/asm/octeon/cvmx-l2t-defs.h b/arch/mips/include/asm/octeon/cvmx-l2t-defs.h
index 2639a3f..873968f 100644
--- a/arch/mips/include/asm/octeon/cvmx-l2t-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-l2t-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2010 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -28,8 +28,7 @@
 #ifndef __CVMX_L2T_DEFS_H__
 #define __CVMX_L2T_DEFS_H__
 
-#define CVMX_L2T_ERR \
-	 CVMX_ADD_IO_SEG(0x0001180080000008ull)
+#define CVMX_L2T_ERR (CVMX_ADD_IO_SEG(0x0001180080000008ull))
 
 union cvmx_l2t_err {
 	uint64_t u64;
diff --git a/arch/mips/include/asm/octeon/cvmx-led-defs.h b/arch/mips/include/asm/octeon/cvmx-led-defs.h
index 16f174a..e25173b 100644
--- a/arch/mips/include/asm/octeon/cvmx-led-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-led-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2010 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -28,32 +28,19 @@
 #ifndef __CVMX_LED_DEFS_H__
 #define __CVMX_LED_DEFS_H__
 
-#define CVMX_LED_BLINK \
-	 CVMX_ADD_IO_SEG(0x0001180000001A48ull)
-#define CVMX_LED_CLK_PHASE \
-	 CVMX_ADD_IO_SEG(0x0001180000001A08ull)
-#define CVMX_LED_CYLON \
-	 CVMX_ADD_IO_SEG(0x0001180000001AF8ull)
-#define CVMX_LED_DBG \
-	 CVMX_ADD_IO_SEG(0x0001180000001A18ull)
-#define CVMX_LED_EN \
-	 CVMX_ADD_IO_SEG(0x0001180000001A00ull)
-#define CVMX_LED_POLARITY \
-	 CVMX_ADD_IO_SEG(0x0001180000001A50ull)
-#define CVMX_LED_PRT \
-	 CVMX_ADD_IO_SEG(0x0001180000001A10ull)
-#define CVMX_LED_PRT_FMT \
-	 CVMX_ADD_IO_SEG(0x0001180000001A30ull)
-#define CVMX_LED_PRT_STATUSX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000001A80ull + (((offset) & 7) * 8))
-#define CVMX_LED_UDD_CNTX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000001A20ull + (((offset) & 1) * 8))
-#define CVMX_LED_UDD_DATX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000001A38ull + (((offset) & 1) * 8))
-#define CVMX_LED_UDD_DAT_CLRX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000001AC8ull + (((offset) & 1) * 16))
-#define CVMX_LED_UDD_DAT_SETX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000001AC0ull + (((offset) & 1) * 16))
+#define CVMX_LED_BLINK (CVMX_ADD_IO_SEG(0x0001180000001A48ull))
+#define CVMX_LED_CLK_PHASE (CVMX_ADD_IO_SEG(0x0001180000001A08ull))
+#define CVMX_LED_CYLON (CVMX_ADD_IO_SEG(0x0001180000001AF8ull))
+#define CVMX_LED_DBG (CVMX_ADD_IO_SEG(0x0001180000001A18ull))
+#define CVMX_LED_EN (CVMX_ADD_IO_SEG(0x0001180000001A00ull))
+#define CVMX_LED_POLARITY (CVMX_ADD_IO_SEG(0x0001180000001A50ull))
+#define CVMX_LED_PRT (CVMX_ADD_IO_SEG(0x0001180000001A10ull))
+#define CVMX_LED_PRT_FMT (CVMX_ADD_IO_SEG(0x0001180000001A30ull))
+#define CVMX_LED_PRT_STATUSX(offset) (CVMX_ADD_IO_SEG(0x0001180000001A80ull) + ((offset) & 7) * 8)
+#define CVMX_LED_UDD_CNTX(offset) (CVMX_ADD_IO_SEG(0x0001180000001A20ull) + ((offset) & 1) * 8)
+#define CVMX_LED_UDD_DATX(offset) (CVMX_ADD_IO_SEG(0x0001180000001A38ull) + ((offset) & 1) * 8)
+#define CVMX_LED_UDD_DAT_CLRX(offset) (CVMX_ADD_IO_SEG(0x0001180000001AC8ull) + ((offset) & 1) * 16)
+#define CVMX_LED_UDD_DAT_SETX(offset) (CVMX_ADD_IO_SEG(0x0001180000001AC0ull) + ((offset) & 1) * 16)
 
 union cvmx_led_blink {
 	uint64_t u64;
diff --git a/arch/mips/include/asm/octeon/cvmx-mio-defs.h b/arch/mips/include/asm/octeon/cvmx-mio-defs.h
index 6555f05..52b14a3 100644
--- a/arch/mips/include/asm/octeon/cvmx-mio-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-mio-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2010 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -28,191 +28,117 @@
 #ifndef __CVMX_MIO_DEFS_H__
 #define __CVMX_MIO_DEFS_H__
 
-#define CVMX_MIO_BOOT_BIST_STAT \
-	 CVMX_ADD_IO_SEG(0x00011800000000F8ull)
-#define CVMX_MIO_BOOT_COMP \
-	 CVMX_ADD_IO_SEG(0x00011800000000B8ull)
-#define CVMX_MIO_BOOT_DMA_CFGX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000100ull + (((offset) & 3) * 8))
-#define CVMX_MIO_BOOT_DMA_INTX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000138ull + (((offset) & 3) * 8))
-#define CVMX_MIO_BOOT_DMA_INT_ENX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000150ull + (((offset) & 3) * 8))
-#define CVMX_MIO_BOOT_DMA_TIMX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000120ull + (((offset) & 3) * 8))
-#define CVMX_MIO_BOOT_ERR \
-	 CVMX_ADD_IO_SEG(0x00011800000000A0ull)
-#define CVMX_MIO_BOOT_INT \
-	 CVMX_ADD_IO_SEG(0x00011800000000A8ull)
-#define CVMX_MIO_BOOT_LOC_ADR \
-	 CVMX_ADD_IO_SEG(0x0001180000000090ull)
-#define CVMX_MIO_BOOT_LOC_CFGX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000080ull + (((offset) & 1) * 8))
-#define CVMX_MIO_BOOT_LOC_DAT \
-	 CVMX_ADD_IO_SEG(0x0001180000000098ull)
-#define CVMX_MIO_BOOT_PIN_DEFS \
-	 CVMX_ADD_IO_SEG(0x00011800000000C0ull)
-#define CVMX_MIO_BOOT_REG_CFGX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000000ull + (((offset) & 7) * 8))
-#define CVMX_MIO_BOOT_REG_TIMX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000040ull + (((offset) & 7) * 8))
-#define CVMX_MIO_BOOT_THR \
-	 CVMX_ADD_IO_SEG(0x00011800000000B0ull)
-#define CVMX_MIO_FUS_BNK_DATX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000001520ull + (((offset) & 3) * 8))
-#define CVMX_MIO_FUS_DAT0 \
-	 CVMX_ADD_IO_SEG(0x0001180000001400ull)
-#define CVMX_MIO_FUS_DAT1 \
-	 CVMX_ADD_IO_SEG(0x0001180000001408ull)
-#define CVMX_MIO_FUS_DAT2 \
-	 CVMX_ADD_IO_SEG(0x0001180000001410ull)
-#define CVMX_MIO_FUS_DAT3 \
-	 CVMX_ADD_IO_SEG(0x0001180000001418ull)
-#define CVMX_MIO_FUS_EMA \
-	 CVMX_ADD_IO_SEG(0x0001180000001550ull)
-#define CVMX_MIO_FUS_PDF \
-	 CVMX_ADD_IO_SEG(0x0001180000001420ull)
-#define CVMX_MIO_FUS_PLL \
-	 CVMX_ADD_IO_SEG(0x0001180000001580ull)
-#define CVMX_MIO_FUS_PROG \
-	 CVMX_ADD_IO_SEG(0x0001180000001510ull)
-#define CVMX_MIO_FUS_PROG_TIMES \
-	 CVMX_ADD_IO_SEG(0x0001180000001518ull)
-#define CVMX_MIO_FUS_RCMD \
-	 CVMX_ADD_IO_SEG(0x0001180000001500ull)
-#define CVMX_MIO_FUS_SPR_REPAIR_RES \
-	 CVMX_ADD_IO_SEG(0x0001180000001548ull)
-#define CVMX_MIO_FUS_SPR_REPAIR_SUM \
-	 CVMX_ADD_IO_SEG(0x0001180000001540ull)
-#define CVMX_MIO_FUS_UNLOCK \
-	 CVMX_ADD_IO_SEG(0x0001180000001578ull)
-#define CVMX_MIO_FUS_WADR \
-	 CVMX_ADD_IO_SEG(0x0001180000001508ull)
-#define CVMX_MIO_NDF_DMA_CFG \
-	 CVMX_ADD_IO_SEG(0x0001180000000168ull)
-#define CVMX_MIO_NDF_DMA_INT \
-	 CVMX_ADD_IO_SEG(0x0001180000000170ull)
-#define CVMX_MIO_NDF_DMA_INT_EN \
-	 CVMX_ADD_IO_SEG(0x0001180000000178ull)
-#define CVMX_MIO_PLL_CTL \
-	 CVMX_ADD_IO_SEG(0x0001180000001448ull)
-#define CVMX_MIO_PLL_SETTING \
-	 CVMX_ADD_IO_SEG(0x0001180000001440ull)
-#define CVMX_MIO_TWSX_INT(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000001010ull + (((offset) & 1) * 512))
-#define CVMX_MIO_TWSX_SW_TWSI(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000001000ull + (((offset) & 1) * 512))
-#define CVMX_MIO_TWSX_SW_TWSI_EXT(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000001018ull + (((offset) & 1) * 512))
-#define CVMX_MIO_TWSX_TWSI_SW(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000001008ull + (((offset) & 1) * 512))
-#define CVMX_MIO_UART2_DLH \
-	 CVMX_ADD_IO_SEG(0x0001180000000488ull)
-#define CVMX_MIO_UART2_DLL \
-	 CVMX_ADD_IO_SEG(0x0001180000000480ull)
-#define CVMX_MIO_UART2_FAR \
-	 CVMX_ADD_IO_SEG(0x0001180000000520ull)
-#define CVMX_MIO_UART2_FCR \
-	 CVMX_ADD_IO_SEG(0x0001180000000450ull)
-#define CVMX_MIO_UART2_HTX \
-	 CVMX_ADD_IO_SEG(0x0001180000000708ull)
-#define CVMX_MIO_UART2_IER \
-	 CVMX_ADD_IO_SEG(0x0001180000000408ull)
-#define CVMX_MIO_UART2_IIR \
-	 CVMX_ADD_IO_SEG(0x0001180000000410ull)
-#define CVMX_MIO_UART2_LCR \
-	 CVMX_ADD_IO_SEG(0x0001180000000418ull)
-#define CVMX_MIO_UART2_LSR \
-	 CVMX_ADD_IO_SEG(0x0001180000000428ull)
-#define CVMX_MIO_UART2_MCR \
-	 CVMX_ADD_IO_SEG(0x0001180000000420ull)
-#define CVMX_MIO_UART2_MSR \
-	 CVMX_ADD_IO_SEG(0x0001180000000430ull)
-#define CVMX_MIO_UART2_RBR \
-	 CVMX_ADD_IO_SEG(0x0001180000000400ull)
-#define CVMX_MIO_UART2_RFL \
-	 CVMX_ADD_IO_SEG(0x0001180000000608ull)
-#define CVMX_MIO_UART2_RFW \
-	 CVMX_ADD_IO_SEG(0x0001180000000530ull)
-#define CVMX_MIO_UART2_SBCR \
-	 CVMX_ADD_IO_SEG(0x0001180000000620ull)
-#define CVMX_MIO_UART2_SCR \
-	 CVMX_ADD_IO_SEG(0x0001180000000438ull)
-#define CVMX_MIO_UART2_SFE \
-	 CVMX_ADD_IO_SEG(0x0001180000000630ull)
-#define CVMX_MIO_UART2_SRR \
-	 CVMX_ADD_IO_SEG(0x0001180000000610ull)
-#define CVMX_MIO_UART2_SRT \
-	 CVMX_ADD_IO_SEG(0x0001180000000638ull)
-#define CVMX_MIO_UART2_SRTS \
-	 CVMX_ADD_IO_SEG(0x0001180000000618ull)
-#define CVMX_MIO_UART2_STT \
-	 CVMX_ADD_IO_SEG(0x0001180000000700ull)
-#define CVMX_MIO_UART2_TFL \
-	 CVMX_ADD_IO_SEG(0x0001180000000600ull)
-#define CVMX_MIO_UART2_TFR \
-	 CVMX_ADD_IO_SEG(0x0001180000000528ull)
-#define CVMX_MIO_UART2_THR \
-	 CVMX_ADD_IO_SEG(0x0001180000000440ull)
-#define CVMX_MIO_UART2_USR \
-	 CVMX_ADD_IO_SEG(0x0001180000000538ull)
-#define CVMX_MIO_UARTX_DLH(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000888ull + (((offset) & 1) * 1024))
-#define CVMX_MIO_UARTX_DLL(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000880ull + (((offset) & 1) * 1024))
-#define CVMX_MIO_UARTX_FAR(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000920ull + (((offset) & 1) * 1024))
-#define CVMX_MIO_UARTX_FCR(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000850ull + (((offset) & 1) * 1024))
-#define CVMX_MIO_UARTX_HTX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000B08ull + (((offset) & 1) * 1024))
-#define CVMX_MIO_UARTX_IER(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000808ull + (((offset) & 1) * 1024))
-#define CVMX_MIO_UARTX_IIR(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000810ull + (((offset) & 1) * 1024))
-#define CVMX_MIO_UARTX_LCR(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000818ull + (((offset) & 1) * 1024))
-#define CVMX_MIO_UARTX_LSR(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000828ull + (((offset) & 1) * 1024))
-#define CVMX_MIO_UARTX_MCR(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000820ull + (((offset) & 1) * 1024))
-#define CVMX_MIO_UARTX_MSR(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000830ull + (((offset) & 1) * 1024))
-#define CVMX_MIO_UARTX_RBR(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000800ull + (((offset) & 1) * 1024))
-#define CVMX_MIO_UARTX_RFL(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000A08ull + (((offset) & 1) * 1024))
-#define CVMX_MIO_UARTX_RFW(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000930ull + (((offset) & 1) * 1024))
-#define CVMX_MIO_UARTX_SBCR(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000A20ull + (((offset) & 1) * 1024))
-#define CVMX_MIO_UARTX_SCR(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000838ull + (((offset) & 1) * 1024))
-#define CVMX_MIO_UARTX_SFE(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000A30ull + (((offset) & 1) * 1024))
-#define CVMX_MIO_UARTX_SRR(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000A10ull + (((offset) & 1) * 1024))
-#define CVMX_MIO_UARTX_SRT(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000A38ull + (((offset) & 1) * 1024))
-#define CVMX_MIO_UARTX_SRTS(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000A18ull + (((offset) & 1) * 1024))
-#define CVMX_MIO_UARTX_STT(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000B00ull + (((offset) & 1) * 1024))
-#define CVMX_MIO_UARTX_TFL(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000A00ull + (((offset) & 1) * 1024))
-#define CVMX_MIO_UARTX_TFR(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000928ull + (((offset) & 1) * 1024))
-#define CVMX_MIO_UARTX_THR(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000840ull + (((offset) & 1) * 1024))
-#define CVMX_MIO_UARTX_USR(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000000938ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_BOOT_BIST_STAT (CVMX_ADD_IO_SEG(0x00011800000000F8ull))
+#define CVMX_MIO_BOOT_COMP (CVMX_ADD_IO_SEG(0x00011800000000B8ull))
+#define CVMX_MIO_BOOT_DMA_CFGX(offset) (CVMX_ADD_IO_SEG(0x0001180000000100ull) + ((offset) & 3) * 8)
+#define CVMX_MIO_BOOT_DMA_INTX(offset) (CVMX_ADD_IO_SEG(0x0001180000000138ull) + ((offset) & 3) * 8)
+#define CVMX_MIO_BOOT_DMA_INT_ENX(offset) (CVMX_ADD_IO_SEG(0x0001180000000150ull) + ((offset) & 3) * 8)
+#define CVMX_MIO_BOOT_DMA_TIMX(offset) (CVMX_ADD_IO_SEG(0x0001180000000120ull) + ((offset) & 3) * 8)
+#define CVMX_MIO_BOOT_ERR (CVMX_ADD_IO_SEG(0x00011800000000A0ull))
+#define CVMX_MIO_BOOT_INT (CVMX_ADD_IO_SEG(0x00011800000000A8ull))
+#define CVMX_MIO_BOOT_LOC_ADR (CVMX_ADD_IO_SEG(0x0001180000000090ull))
+#define CVMX_MIO_BOOT_LOC_CFGX(offset) (CVMX_ADD_IO_SEG(0x0001180000000080ull) + ((offset) & 1) * 8)
+#define CVMX_MIO_BOOT_LOC_DAT (CVMX_ADD_IO_SEG(0x0001180000000098ull))
+#define CVMX_MIO_BOOT_PIN_DEFS (CVMX_ADD_IO_SEG(0x00011800000000C0ull))
+#define CVMX_MIO_BOOT_REG_CFGX(offset) (CVMX_ADD_IO_SEG(0x0001180000000000ull) + ((offset) & 7) * 8)
+#define CVMX_MIO_BOOT_REG_TIMX(offset) (CVMX_ADD_IO_SEG(0x0001180000000040ull) + ((offset) & 7) * 8)
+#define CVMX_MIO_BOOT_THR (CVMX_ADD_IO_SEG(0x00011800000000B0ull))
+#define CVMX_MIO_FUS_BNK_DATX(offset) (CVMX_ADD_IO_SEG(0x0001180000001520ull) + ((offset) & 3) * 8)
+#define CVMX_MIO_FUS_DAT0 (CVMX_ADD_IO_SEG(0x0001180000001400ull))
+#define CVMX_MIO_FUS_DAT1 (CVMX_ADD_IO_SEG(0x0001180000001408ull))
+#define CVMX_MIO_FUS_DAT2 (CVMX_ADD_IO_SEG(0x0001180000001410ull))
+#define CVMX_MIO_FUS_DAT3 (CVMX_ADD_IO_SEG(0x0001180000001418ull))
+#define CVMX_MIO_FUS_EMA (CVMX_ADD_IO_SEG(0x0001180000001550ull))
+#define CVMX_MIO_FUS_PDF (CVMX_ADD_IO_SEG(0x0001180000001420ull))
+#define CVMX_MIO_FUS_PLL (CVMX_ADD_IO_SEG(0x0001180000001580ull))
+#define CVMX_MIO_FUS_PROG (CVMX_ADD_IO_SEG(0x0001180000001510ull))
+#define CVMX_MIO_FUS_PROG_TIMES (CVMX_ADD_IO_SEG(0x0001180000001518ull))
+#define CVMX_MIO_FUS_RCMD (CVMX_ADD_IO_SEG(0x0001180000001500ull))
+#define CVMX_MIO_FUS_READ_TIMES (CVMX_ADD_IO_SEG(0x0001180000001570ull))
+#define CVMX_MIO_FUS_REPAIR_RES0 (CVMX_ADD_IO_SEG(0x0001180000001558ull))
+#define CVMX_MIO_FUS_REPAIR_RES1 (CVMX_ADD_IO_SEG(0x0001180000001560ull))
+#define CVMX_MIO_FUS_REPAIR_RES2 (CVMX_ADD_IO_SEG(0x0001180000001568ull))
+#define CVMX_MIO_FUS_SPR_REPAIR_RES (CVMX_ADD_IO_SEG(0x0001180000001548ull))
+#define CVMX_MIO_FUS_SPR_REPAIR_SUM (CVMX_ADD_IO_SEG(0x0001180000001540ull))
+#define CVMX_MIO_FUS_UNLOCK (CVMX_ADD_IO_SEG(0x0001180000001578ull))
+#define CVMX_MIO_FUS_WADR (CVMX_ADD_IO_SEG(0x0001180000001508ull))
+#define CVMX_MIO_GPIO_COMP (CVMX_ADD_IO_SEG(0x00011800000000C8ull))
+#define CVMX_MIO_NDF_DMA_CFG (CVMX_ADD_IO_SEG(0x0001180000000168ull))
+#define CVMX_MIO_NDF_DMA_INT (CVMX_ADD_IO_SEG(0x0001180000000170ull))
+#define CVMX_MIO_NDF_DMA_INT_EN (CVMX_ADD_IO_SEG(0x0001180000000178ull))
+#define CVMX_MIO_PLL_CTL (CVMX_ADD_IO_SEG(0x0001180000001448ull))
+#define CVMX_MIO_PLL_SETTING (CVMX_ADD_IO_SEG(0x0001180000001440ull))
+#define CVMX_MIO_PTP_CLOCK_CFG (CVMX_ADD_IO_SEG(0x0001070000000F00ull))
+#define CVMX_MIO_PTP_CLOCK_COMP (CVMX_ADD_IO_SEG(0x0001070000000F18ull))
+#define CVMX_MIO_PTP_CLOCK_HI (CVMX_ADD_IO_SEG(0x0001070000000F10ull))
+#define CVMX_MIO_PTP_CLOCK_LO (CVMX_ADD_IO_SEG(0x0001070000000F08ull))
+#define CVMX_MIO_PTP_EVT_CNT (CVMX_ADD_IO_SEG(0x0001070000000F28ull))
+#define CVMX_MIO_PTP_TIMESTAMP (CVMX_ADD_IO_SEG(0x0001070000000F20ull))
+#define CVMX_MIO_RST_BOOT (CVMX_ADD_IO_SEG(0x0001180000001600ull))
+#define CVMX_MIO_RST_CFG (CVMX_ADD_IO_SEG(0x0001180000001610ull))
+#define CVMX_MIO_RST_CTLX(offset) (CVMX_ADD_IO_SEG(0x0001180000001618ull) + ((offset) & 1) * 8)
+#define CVMX_MIO_RST_DELAY (CVMX_ADD_IO_SEG(0x0001180000001608ull))
+#define CVMX_MIO_RST_INT (CVMX_ADD_IO_SEG(0x0001180000001628ull))
+#define CVMX_MIO_RST_INT_EN (CVMX_ADD_IO_SEG(0x0001180000001630ull))
+#define CVMX_MIO_TWSX_INT(offset) (CVMX_ADD_IO_SEG(0x0001180000001010ull) + ((offset) & 1) * 512)
+#define CVMX_MIO_TWSX_SW_TWSI(offset) (CVMX_ADD_IO_SEG(0x0001180000001000ull) + ((offset) & 1) * 512)
+#define CVMX_MIO_TWSX_SW_TWSI_EXT(offset) (CVMX_ADD_IO_SEG(0x0001180000001018ull) + ((offset) & 1) * 512)
+#define CVMX_MIO_TWSX_TWSI_SW(offset) (CVMX_ADD_IO_SEG(0x0001180000001008ull) + ((offset) & 1) * 512)
+#define CVMX_MIO_UART2_DLH (CVMX_ADD_IO_SEG(0x0001180000000488ull))
+#define CVMX_MIO_UART2_DLL (CVMX_ADD_IO_SEG(0x0001180000000480ull))
+#define CVMX_MIO_UART2_FAR (CVMX_ADD_IO_SEG(0x0001180000000520ull))
+#define CVMX_MIO_UART2_FCR (CVMX_ADD_IO_SEG(0x0001180000000450ull))
+#define CVMX_MIO_UART2_HTX (CVMX_ADD_IO_SEG(0x0001180000000708ull))
+#define CVMX_MIO_UART2_IER (CVMX_ADD_IO_SEG(0x0001180000000408ull))
+#define CVMX_MIO_UART2_IIR (CVMX_ADD_IO_SEG(0x0001180000000410ull))
+#define CVMX_MIO_UART2_LCR (CVMX_ADD_IO_SEG(0x0001180000000418ull))
+#define CVMX_MIO_UART2_LSR (CVMX_ADD_IO_SEG(0x0001180000000428ull))
+#define CVMX_MIO_UART2_MCR (CVMX_ADD_IO_SEG(0x0001180000000420ull))
+#define CVMX_MIO_UART2_MSR (CVMX_ADD_IO_SEG(0x0001180000000430ull))
+#define CVMX_MIO_UART2_RBR (CVMX_ADD_IO_SEG(0x0001180000000400ull))
+#define CVMX_MIO_UART2_RFL (CVMX_ADD_IO_SEG(0x0001180000000608ull))
+#define CVMX_MIO_UART2_RFW (CVMX_ADD_IO_SEG(0x0001180000000530ull))
+#define CVMX_MIO_UART2_SBCR (CVMX_ADD_IO_SEG(0x0001180000000620ull))
+#define CVMX_MIO_UART2_SCR (CVMX_ADD_IO_SEG(0x0001180000000438ull))
+#define CVMX_MIO_UART2_SFE (CVMX_ADD_IO_SEG(0x0001180000000630ull))
+#define CVMX_MIO_UART2_SRR (CVMX_ADD_IO_SEG(0x0001180000000610ull))
+#define CVMX_MIO_UART2_SRT (CVMX_ADD_IO_SEG(0x0001180000000638ull))
+#define CVMX_MIO_UART2_SRTS (CVMX_ADD_IO_SEG(0x0001180000000618ull))
+#define CVMX_MIO_UART2_STT (CVMX_ADD_IO_SEG(0x0001180000000700ull))
+#define CVMX_MIO_UART2_TFL (CVMX_ADD_IO_SEG(0x0001180000000600ull))
+#define CVMX_MIO_UART2_TFR (CVMX_ADD_IO_SEG(0x0001180000000528ull))
+#define CVMX_MIO_UART2_THR (CVMX_ADD_IO_SEG(0x0001180000000440ull))
+#define CVMX_MIO_UART2_USR (CVMX_ADD_IO_SEG(0x0001180000000538ull))
+#define CVMX_MIO_UARTX_DLH(offset) (CVMX_ADD_IO_SEG(0x0001180000000888ull) + ((offset) & 1) * 1024)
+#define CVMX_MIO_UARTX_DLL(offset) (CVMX_ADD_IO_SEG(0x0001180000000880ull) + ((offset) & 1) * 1024)
+#define CVMX_MIO_UARTX_FAR(offset) (CVMX_ADD_IO_SEG(0x0001180000000920ull) + ((offset) & 1) * 1024)
+#define CVMX_MIO_UARTX_FCR(offset) (CVMX_ADD_IO_SEG(0x0001180000000850ull) + ((offset) & 1) * 1024)
+#define CVMX_MIO_UARTX_HTX(offset) (CVMX_ADD_IO_SEG(0x0001180000000B08ull) + ((offset) & 1) * 1024)
+#define CVMX_MIO_UARTX_IER(offset) (CVMX_ADD_IO_SEG(0x0001180000000808ull) + ((offset) & 1) * 1024)
+#define CVMX_MIO_UARTX_IIR(offset) (CVMX_ADD_IO_SEG(0x0001180000000810ull) + ((offset) & 1) * 1024)
+#define CVMX_MIO_UARTX_LCR(offset) (CVMX_ADD_IO_SEG(0x0001180000000818ull) + ((offset) & 1) * 1024)
+#define CVMX_MIO_UARTX_LSR(offset) (CVMX_ADD_IO_SEG(0x0001180000000828ull) + ((offset) & 1) * 1024)
+#define CVMX_MIO_UARTX_MCR(offset) (CVMX_ADD_IO_SEG(0x0001180000000820ull) + ((offset) & 1) * 1024)
+#define CVMX_MIO_UARTX_MSR(offset) (CVMX_ADD_IO_SEG(0x0001180000000830ull) + ((offset) & 1) * 1024)
+#define CVMX_MIO_UARTX_RBR(offset) (CVMX_ADD_IO_SEG(0x0001180000000800ull) + ((offset) & 1) * 1024)
+#define CVMX_MIO_UARTX_RFL(offset) (CVMX_ADD_IO_SEG(0x0001180000000A08ull) + ((offset) & 1) * 1024)
+#define CVMX_MIO_UARTX_RFW(offset) (CVMX_ADD_IO_SEG(0x0001180000000930ull) + ((offset) & 1) * 1024)
+#define CVMX_MIO_UARTX_SBCR(offset) (CVMX_ADD_IO_SEG(0x0001180000000A20ull) + ((offset) & 1) * 1024)
+#define CVMX_MIO_UARTX_SCR(offset) (CVMX_ADD_IO_SEG(0x0001180000000838ull) + ((offset) & 1) * 1024)
+#define CVMX_MIO_UARTX_SFE(offset) (CVMX_ADD_IO_SEG(0x0001180000000A30ull) + ((offset) & 1) * 1024)
+#define CVMX_MIO_UARTX_SRR(offset) (CVMX_ADD_IO_SEG(0x0001180000000A10ull) + ((offset) & 1) * 1024)
+#define CVMX_MIO_UARTX_SRT(offset) (CVMX_ADD_IO_SEG(0x0001180000000A38ull) + ((offset) & 1) * 1024)
+#define CVMX_MIO_UARTX_SRTS(offset) (CVMX_ADD_IO_SEG(0x0001180000000A18ull) + ((offset) & 1) * 1024)
+#define CVMX_MIO_UARTX_STT(offset) (CVMX_ADD_IO_SEG(0x0001180000000B00ull) + ((offset) & 1) * 1024)
+#define CVMX_MIO_UARTX_TFL(offset) (CVMX_ADD_IO_SEG(0x0001180000000A00ull) + ((offset) & 1) * 1024)
+#define CVMX_MIO_UARTX_TFR(offset) (CVMX_ADD_IO_SEG(0x0001180000000928ull) + ((offset) & 1) * 1024)
+#define CVMX_MIO_UARTX_THR(offset) (CVMX_ADD_IO_SEG(0x0001180000000840ull) + ((offset) & 1) * 1024)
+#define CVMX_MIO_UARTX_USR(offset) (CVMX_ADD_IO_SEG(0x0001180000000938ull) + ((offset) & 1) * 1024)
 
 union cvmx_mio_boot_bist_stat {
 	uint64_t u64;
 	struct cvmx_mio_boot_bist_stat_s {
-		uint64_t reserved_2_63:62;
-		uint64_t loc:1;
-		uint64_t ncbi:1;
+		uint64_t reserved_0_63:64;
 	} s;
 	struct cvmx_mio_boot_bist_stat_cn30xx {
 		uint64_t reserved_4_63:60;
@@ -257,20 +183,33 @@ union cvmx_mio_boot_bist_stat {
 	struct cvmx_mio_boot_bist_stat_cn52xxp1 cn56xxp1;
 	struct cvmx_mio_boot_bist_stat_cn38xx cn58xx;
 	struct cvmx_mio_boot_bist_stat_cn38xx cn58xxp1;
+	struct cvmx_mio_boot_bist_stat_cn63xx {
+		uint64_t reserved_9_63:55;
+		uint64_t stat:9;
+	} cn63xx;
+	struct cvmx_mio_boot_bist_stat_cn63xx cn63xxp1;
 };
 
 union cvmx_mio_boot_comp {
 	uint64_t u64;
 	struct cvmx_mio_boot_comp_s {
+		uint64_t reserved_0_63:64;
+	} s;
+	struct cvmx_mio_boot_comp_cn50xx {
 		uint64_t reserved_10_63:54;
 		uint64_t pctl:5;
 		uint64_t nctl:5;
-	} s;
-	struct cvmx_mio_boot_comp_s cn50xx;
-	struct cvmx_mio_boot_comp_s cn52xx;
-	struct cvmx_mio_boot_comp_s cn52xxp1;
-	struct cvmx_mio_boot_comp_s cn56xx;
-	struct cvmx_mio_boot_comp_s cn56xxp1;
+	} cn50xx;
+	struct cvmx_mio_boot_comp_cn50xx cn52xx;
+	struct cvmx_mio_boot_comp_cn50xx cn52xxp1;
+	struct cvmx_mio_boot_comp_cn50xx cn56xx;
+	struct cvmx_mio_boot_comp_cn50xx cn56xxp1;
+	struct cvmx_mio_boot_comp_cn63xx {
+		uint64_t reserved_12_63:52;
+		uint64_t pctl:6;
+		uint64_t nctl:6;
+	} cn63xx;
+	struct cvmx_mio_boot_comp_cn63xx cn63xxp1;
 };
 
 union cvmx_mio_boot_dma_cfgx {
@@ -291,6 +230,8 @@ union cvmx_mio_boot_dma_cfgx {
 	struct cvmx_mio_boot_dma_cfgx_s cn52xxp1;
 	struct cvmx_mio_boot_dma_cfgx_s cn56xx;
 	struct cvmx_mio_boot_dma_cfgx_s cn56xxp1;
+	struct cvmx_mio_boot_dma_cfgx_s cn63xx;
+	struct cvmx_mio_boot_dma_cfgx_s cn63xxp1;
 };
 
 union cvmx_mio_boot_dma_intx {
@@ -304,6 +245,8 @@ union cvmx_mio_boot_dma_intx {
 	struct cvmx_mio_boot_dma_intx_s cn52xxp1;
 	struct cvmx_mio_boot_dma_intx_s cn56xx;
 	struct cvmx_mio_boot_dma_intx_s cn56xxp1;
+	struct cvmx_mio_boot_dma_intx_s cn63xx;
+	struct cvmx_mio_boot_dma_intx_s cn63xxp1;
 };
 
 union cvmx_mio_boot_dma_int_enx {
@@ -317,6 +260,8 @@ union cvmx_mio_boot_dma_int_enx {
 	struct cvmx_mio_boot_dma_int_enx_s cn52xxp1;
 	struct cvmx_mio_boot_dma_int_enx_s cn56xx;
 	struct cvmx_mio_boot_dma_int_enx_s cn56xxp1;
+	struct cvmx_mio_boot_dma_int_enx_s cn63xx;
+	struct cvmx_mio_boot_dma_int_enx_s cn63xxp1;
 };
 
 union cvmx_mio_boot_dma_timx {
@@ -342,6 +287,8 @@ union cvmx_mio_boot_dma_timx {
 	struct cvmx_mio_boot_dma_timx_s cn52xxp1;
 	struct cvmx_mio_boot_dma_timx_s cn56xx;
 	struct cvmx_mio_boot_dma_timx_s cn56xxp1;
+	struct cvmx_mio_boot_dma_timx_s cn63xx;
+	struct cvmx_mio_boot_dma_timx_s cn63xxp1;
 };
 
 union cvmx_mio_boot_err {
@@ -362,6 +309,8 @@ union cvmx_mio_boot_err {
 	struct cvmx_mio_boot_err_s cn56xxp1;
 	struct cvmx_mio_boot_err_s cn58xx;
 	struct cvmx_mio_boot_err_s cn58xxp1;
+	struct cvmx_mio_boot_err_s cn63xx;
+	struct cvmx_mio_boot_err_s cn63xxp1;
 };
 
 union cvmx_mio_boot_int {
@@ -382,6 +331,8 @@ union cvmx_mio_boot_int {
 	struct cvmx_mio_boot_int_s cn56xxp1;
 	struct cvmx_mio_boot_int_s cn58xx;
 	struct cvmx_mio_boot_int_s cn58xxp1;
+	struct cvmx_mio_boot_int_s cn63xx;
+	struct cvmx_mio_boot_int_s cn63xxp1;
 };
 
 union cvmx_mio_boot_loc_adr {
@@ -402,6 +353,8 @@ union cvmx_mio_boot_loc_adr {
 	struct cvmx_mio_boot_loc_adr_s cn56xxp1;
 	struct cvmx_mio_boot_loc_adr_s cn58xx;
 	struct cvmx_mio_boot_loc_adr_s cn58xxp1;
+	struct cvmx_mio_boot_loc_adr_s cn63xx;
+	struct cvmx_mio_boot_loc_adr_s cn63xxp1;
 };
 
 union cvmx_mio_boot_loc_cfgx {
@@ -424,6 +377,8 @@ union cvmx_mio_boot_loc_cfgx {
 	struct cvmx_mio_boot_loc_cfgx_s cn56xxp1;
 	struct cvmx_mio_boot_loc_cfgx_s cn58xx;
 	struct cvmx_mio_boot_loc_cfgx_s cn58xxp1;
+	struct cvmx_mio_boot_loc_cfgx_s cn63xx;
+	struct cvmx_mio_boot_loc_cfgx_s cn63xxp1;
 };
 
 union cvmx_mio_boot_loc_dat {
@@ -442,6 +397,8 @@ union cvmx_mio_boot_loc_dat {
 	struct cvmx_mio_boot_loc_dat_s cn56xxp1;
 	struct cvmx_mio_boot_loc_dat_s cn58xx;
 	struct cvmx_mio_boot_loc_dat_s cn58xxp1;
+	struct cvmx_mio_boot_loc_dat_s cn63xx;
+	struct cvmx_mio_boot_loc_dat_s cn63xxp1;
 };
 
 union cvmx_mio_boot_pin_defs {
@@ -478,6 +435,8 @@ union cvmx_mio_boot_pin_defs {
 		uint64_t term:2;
 		uint64_t reserved_0_8:9;
 	} cn56xx;
+	struct cvmx_mio_boot_pin_defs_cn52xx cn63xx;
+	struct cvmx_mio_boot_pin_defs_cn52xx cn63xxp1;
 };
 
 union cvmx_mio_boot_reg_cfgx {
@@ -539,6 +498,8 @@ union cvmx_mio_boot_reg_cfgx {
 	struct cvmx_mio_boot_reg_cfgx_s cn56xxp1;
 	struct cvmx_mio_boot_reg_cfgx_cn30xx cn58xx;
 	struct cvmx_mio_boot_reg_cfgx_cn30xx cn58xxp1;
+	struct cvmx_mio_boot_reg_cfgx_s cn63xx;
+	struct cvmx_mio_boot_reg_cfgx_s cn63xxp1;
 };
 
 union cvmx_mio_boot_reg_timx {
@@ -583,6 +544,8 @@ union cvmx_mio_boot_reg_timx {
 	struct cvmx_mio_boot_reg_timx_s cn56xxp1;
 	struct cvmx_mio_boot_reg_timx_s cn58xx;
 	struct cvmx_mio_boot_reg_timx_s cn58xxp1;
+	struct cvmx_mio_boot_reg_timx_s cn63xx;
+	struct cvmx_mio_boot_reg_timx_s cn63xxp1;
 };
 
 union cvmx_mio_boot_thr {
@@ -611,6 +574,8 @@ union cvmx_mio_boot_thr {
 	struct cvmx_mio_boot_thr_s cn56xxp1;
 	struct cvmx_mio_boot_thr_cn30xx cn58xx;
 	struct cvmx_mio_boot_thr_cn30xx cn58xxp1;
+	struct cvmx_mio_boot_thr_s cn63xx;
+	struct cvmx_mio_boot_thr_s cn63xxp1;
 };
 
 union cvmx_mio_fus_bnk_datx {
@@ -625,6 +590,8 @@ union cvmx_mio_fus_bnk_datx {
 	struct cvmx_mio_fus_bnk_datx_s cn56xxp1;
 	struct cvmx_mio_fus_bnk_datx_s cn58xx;
 	struct cvmx_mio_fus_bnk_datx_s cn58xxp1;
+	struct cvmx_mio_fus_bnk_datx_s cn63xx;
+	struct cvmx_mio_fus_bnk_datx_s cn63xxp1;
 };
 
 union cvmx_mio_fus_dat0 {
@@ -644,6 +611,8 @@ union cvmx_mio_fus_dat0 {
 	struct cvmx_mio_fus_dat0_s cn56xxp1;
 	struct cvmx_mio_fus_dat0_s cn58xx;
 	struct cvmx_mio_fus_dat0_s cn58xxp1;
+	struct cvmx_mio_fus_dat0_s cn63xx;
+	struct cvmx_mio_fus_dat0_s cn63xxp1;
 };
 
 union cvmx_mio_fus_dat1 {
@@ -663,12 +632,15 @@ union cvmx_mio_fus_dat1 {
 	struct cvmx_mio_fus_dat1_s cn56xxp1;
 	struct cvmx_mio_fus_dat1_s cn58xx;
 	struct cvmx_mio_fus_dat1_s cn58xxp1;
+	struct cvmx_mio_fus_dat1_s cn63xx;
+	struct cvmx_mio_fus_dat1_s cn63xxp1;
 };
 
 union cvmx_mio_fus_dat2 {
 	uint64_t u64;
 	struct cvmx_mio_fus_dat2_s {
-		uint64_t reserved_34_63:30;
+		uint64_t reserved_35_63:29;
+		uint64_t dorm_crypto:1;
 		uint64_t fus318:1;
 		uint64_t raid_en:1;
 		uint64_t reserved_30_31:2;
@@ -775,14 +747,38 @@ union cvmx_mio_fus_dat2 {
 		uint64_t pp_dis:16;
 	} cn58xx;
 	struct cvmx_mio_fus_dat2_cn58xx cn58xxp1;
+	struct cvmx_mio_fus_dat2_cn63xx {
+		uint64_t reserved_35_63:29;
+		uint64_t dorm_crypto:1;
+		uint64_t fus318:1;
+		uint64_t raid_en:1;
+		uint64_t reserved_29_31:3;
+		uint64_t nodfa_cp2:1;
+		uint64_t nomul:1;
+		uint64_t nocrypto:1;
+		uint64_t reserved_24_25:2;
+		uint64_t chip_id:8;
+		uint64_t reserved_6_15:10;
+		uint64_t pp_dis:6;
+	} cn63xx;
+	struct cvmx_mio_fus_dat2_cn63xx cn63xxp1;
 };
 
 union cvmx_mio_fus_dat3 {
 	uint64_t u64;
 	struct cvmx_mio_fus_dat3_s {
-		uint64_t reserved_32_63:32;
+		uint64_t reserved_58_63:6;
+		uint64_t pll_ctl:10;
+		uint64_t dfa_info_dte:3;
+		uint64_t dfa_info_clm:4;
+		uint64_t reserved_40_40:1;
+		uint64_t ema:2;
+		uint64_t efus_lck_rsv:1;
+		uint64_t efus_lck_man:1;
+		uint64_t pll_half_dis:1;
+		uint64_t l2c_crip:3;
 		uint64_t pll_div4:1;
-		uint64_t zip_crip:2;
+		uint64_t reserved_29_30:2;
 		uint64_t bar2_en:1;
 		uint64_t efus_lck:1;
 		uint64_t efus_ign:1;
@@ -801,7 +797,17 @@ union cvmx_mio_fus_dat3 {
 		uint64_t nodfa_dte:1;
 		uint64_t icache:24;
 	} cn30xx;
-	struct cvmx_mio_fus_dat3_s cn31xx;
+	struct cvmx_mio_fus_dat3_cn31xx {
+		uint64_t reserved_32_63:32;
+		uint64_t pll_div4:1;
+		uint64_t zip_crip:2;
+		uint64_t bar2_en:1;
+		uint64_t efus_lck:1;
+		uint64_t efus_ign:1;
+		uint64_t nozip:1;
+		uint64_t nodfa_dte:1;
+		uint64_t icache:24;
+	} cn31xx;
 	struct cvmx_mio_fus_dat3_cn38xx {
 		uint64_t reserved_31_63:33;
 		uint64_t zip_crip:2;
@@ -828,6 +834,27 @@ union cvmx_mio_fus_dat3 {
 	struct cvmx_mio_fus_dat3_cn38xx cn56xxp1;
 	struct cvmx_mio_fus_dat3_cn38xx cn58xx;
 	struct cvmx_mio_fus_dat3_cn38xx cn58xxp1;
+	struct cvmx_mio_fus_dat3_cn63xx {
+		uint64_t reserved_58_63:6;
+		uint64_t pll_ctl:10;
+		uint64_t dfa_info_dte:3;
+		uint64_t dfa_info_clm:4;
+		uint64_t reserved_40_40:1;
+		uint64_t ema:2;
+		uint64_t efus_lck_rsv:1;
+		uint64_t efus_lck_man:1;
+		uint64_t pll_half_dis:1;
+		uint64_t l2c_crip:3;
+		uint64_t reserved_31_31:1;
+		uint64_t zip_info:2;
+		uint64_t bar2_en:1;
+		uint64_t efus_lck:1;
+		uint64_t efus_ign:1;
+		uint64_t nozip:1;
+		uint64_t nodfa_dte:1;
+		uint64_t reserved_0_23:24;
+	} cn63xx;
+	struct cvmx_mio_fus_dat3_cn63xx cn63xxp1;
 };
 
 union cvmx_mio_fus_ema {
@@ -848,6 +875,8 @@ union cvmx_mio_fus_ema {
 		uint64_t ema:2;
 	} cn58xx;
 	struct cvmx_mio_fus_ema_cn58xx cn58xxp1;
+	struct cvmx_mio_fus_ema_s cn63xx;
+	struct cvmx_mio_fus_ema_s cn63xxp1;
 };
 
 union cvmx_mio_fus_pdf {
@@ -861,60 +890,96 @@ union cvmx_mio_fus_pdf {
 	struct cvmx_mio_fus_pdf_s cn56xx;
 	struct cvmx_mio_fus_pdf_s cn56xxp1;
 	struct cvmx_mio_fus_pdf_s cn58xx;
+	struct cvmx_mio_fus_pdf_s cn63xx;
+	struct cvmx_mio_fus_pdf_s cn63xxp1;
 };
 
 union cvmx_mio_fus_pll {
 	uint64_t u64;
 	struct cvmx_mio_fus_pll_s {
-		uint64_t reserved_2_63:62;
+		uint64_t reserved_8_63:56;
+		uint64_t c_cout_rst:1;
+		uint64_t c_cout_sel:2;
+		uint64_t pnr_cout_rst:1;
+		uint64_t pnr_cout_sel:2;
 		uint64_t rfslip:1;
 		uint64_t fbslip:1;
 	} s;
-	struct cvmx_mio_fus_pll_s cn50xx;
-	struct cvmx_mio_fus_pll_s cn52xx;
-	struct cvmx_mio_fus_pll_s cn52xxp1;
-	struct cvmx_mio_fus_pll_s cn56xx;
-	struct cvmx_mio_fus_pll_s cn56xxp1;
-	struct cvmx_mio_fus_pll_s cn58xx;
-	struct cvmx_mio_fus_pll_s cn58xxp1;
+	struct cvmx_mio_fus_pll_cn50xx {
+		uint64_t reserved_2_63:62;
+		uint64_t rfslip:1;
+		uint64_t fbslip:1;
+	} cn50xx;
+	struct cvmx_mio_fus_pll_cn50xx cn52xx;
+	struct cvmx_mio_fus_pll_cn50xx cn52xxp1;
+	struct cvmx_mio_fus_pll_cn50xx cn56xx;
+	struct cvmx_mio_fus_pll_cn50xx cn56xxp1;
+	struct cvmx_mio_fus_pll_cn50xx cn58xx;
+	struct cvmx_mio_fus_pll_cn50xx cn58xxp1;
+	struct cvmx_mio_fus_pll_s cn63xx;
+	struct cvmx_mio_fus_pll_s cn63xxp1;
 };
 
 union cvmx_mio_fus_prog {
 	uint64_t u64;
 	struct cvmx_mio_fus_prog_s {
-		uint64_t reserved_1_63:63;
+		uint64_t reserved_2_63:62;
+		uint64_t soft:1;
 		uint64_t prog:1;
 	} s;
-	struct cvmx_mio_fus_prog_s cn30xx;
-	struct cvmx_mio_fus_prog_s cn31xx;
-	struct cvmx_mio_fus_prog_s cn38xx;
-	struct cvmx_mio_fus_prog_s cn38xxp2;
-	struct cvmx_mio_fus_prog_s cn50xx;
-	struct cvmx_mio_fus_prog_s cn52xx;
-	struct cvmx_mio_fus_prog_s cn52xxp1;
-	struct cvmx_mio_fus_prog_s cn56xx;
-	struct cvmx_mio_fus_prog_s cn56xxp1;
-	struct cvmx_mio_fus_prog_s cn58xx;
-	struct cvmx_mio_fus_prog_s cn58xxp1;
+	struct cvmx_mio_fus_prog_cn30xx {
+		uint64_t reserved_1_63:63;
+		uint64_t prog:1;
+	} cn30xx;
+	struct cvmx_mio_fus_prog_cn30xx cn31xx;
+	struct cvmx_mio_fus_prog_cn30xx cn38xx;
+	struct cvmx_mio_fus_prog_cn30xx cn38xxp2;
+	struct cvmx_mio_fus_prog_cn30xx cn50xx;
+	struct cvmx_mio_fus_prog_cn30xx cn52xx;
+	struct cvmx_mio_fus_prog_cn30xx cn52xxp1;
+	struct cvmx_mio_fus_prog_cn30xx cn56xx;
+	struct cvmx_mio_fus_prog_cn30xx cn56xxp1;
+	struct cvmx_mio_fus_prog_cn30xx cn58xx;
+	struct cvmx_mio_fus_prog_cn30xx cn58xxp1;
+	struct cvmx_mio_fus_prog_s cn63xx;
+	struct cvmx_mio_fus_prog_s cn63xxp1;
 };
 
 union cvmx_mio_fus_prog_times {
 	uint64_t u64;
 	struct cvmx_mio_fus_prog_times_s {
+		uint64_t reserved_35_63:29;
+		uint64_t vgate_pin:1;
+		uint64_t fsrc_pin:1;
+		uint64_t prog_pin:1;
+		uint64_t reserved_6_31:26;
+		uint64_t setup:6;
+	} s;
+	struct cvmx_mio_fus_prog_times_cn50xx {
 		uint64_t reserved_33_63:31;
 		uint64_t prog_pin:1;
 		uint64_t out:8;
 		uint64_t sclk_lo:4;
 		uint64_t sclk_hi:12;
 		uint64_t setup:8;
-	} s;
-	struct cvmx_mio_fus_prog_times_s cn50xx;
-	struct cvmx_mio_fus_prog_times_s cn52xx;
-	struct cvmx_mio_fus_prog_times_s cn52xxp1;
-	struct cvmx_mio_fus_prog_times_s cn56xx;
-	struct cvmx_mio_fus_prog_times_s cn56xxp1;
-	struct cvmx_mio_fus_prog_times_s cn58xx;
-	struct cvmx_mio_fus_prog_times_s cn58xxp1;
+	} cn50xx;
+	struct cvmx_mio_fus_prog_times_cn50xx cn52xx;
+	struct cvmx_mio_fus_prog_times_cn50xx cn52xxp1;
+	struct cvmx_mio_fus_prog_times_cn50xx cn56xx;
+	struct cvmx_mio_fus_prog_times_cn50xx cn56xxp1;
+	struct cvmx_mio_fus_prog_times_cn50xx cn58xx;
+	struct cvmx_mio_fus_prog_times_cn50xx cn58xxp1;
+	struct cvmx_mio_fus_prog_times_cn63xx {
+		uint64_t reserved_35_63:29;
+		uint64_t vgate_pin:1;
+		uint64_t fsrc_pin:1;
+		uint64_t prog_pin:1;
+		uint64_t out:7;
+		uint64_t sclk_lo:4;
+		uint64_t sclk_hi:15;
+		uint64_t setup:6;
+	} cn63xx;
+	struct cvmx_mio_fus_prog_times_cn63xx cn63xxp1;
 };
 
 union cvmx_mio_fus_rcmd {
@@ -948,6 +1013,57 @@ union cvmx_mio_fus_rcmd {
 	struct cvmx_mio_fus_rcmd_s cn56xxp1;
 	struct cvmx_mio_fus_rcmd_cn30xx cn58xx;
 	struct cvmx_mio_fus_rcmd_cn30xx cn58xxp1;
+	struct cvmx_mio_fus_rcmd_s cn63xx;
+	struct cvmx_mio_fus_rcmd_s cn63xxp1;
+};
+
+union cvmx_mio_fus_read_times {
+	uint64_t u64;
+	struct cvmx_mio_fus_read_times_s {
+		uint64_t reserved_26_63:38;
+		uint64_t sch:4;
+		uint64_t fsh:4;
+		uint64_t prh:4;
+		uint64_t sdh:4;
+		uint64_t setup:10;
+	} s;
+	struct cvmx_mio_fus_read_times_s cn63xx;
+	struct cvmx_mio_fus_read_times_s cn63xxp1;
+};
+
+union cvmx_mio_fus_repair_res0 {
+	uint64_t u64;
+	struct cvmx_mio_fus_repair_res0_s {
+		uint64_t reserved_55_63:9;
+		uint64_t too_many:1;
+		uint64_t repair2:18;
+		uint64_t repair1:18;
+		uint64_t repair0:18;
+	} s;
+	struct cvmx_mio_fus_repair_res0_s cn63xx;
+	struct cvmx_mio_fus_repair_res0_s cn63xxp1;
+};
+
+union cvmx_mio_fus_repair_res1 {
+	uint64_t u64;
+	struct cvmx_mio_fus_repair_res1_s {
+		uint64_t reserved_54_63:10;
+		uint64_t repair5:18;
+		uint64_t repair4:18;
+		uint64_t repair3:18;
+	} s;
+	struct cvmx_mio_fus_repair_res1_s cn63xx;
+	struct cvmx_mio_fus_repair_res1_s cn63xxp1;
+};
+
+union cvmx_mio_fus_repair_res2 {
+	uint64_t u64;
+	struct cvmx_mio_fus_repair_res2_s {
+		uint64_t reserved_18_63:46;
+		uint64_t repair6:18;
+	} s;
+	struct cvmx_mio_fus_repair_res2_s cn63xx;
+	struct cvmx_mio_fus_repair_res2_s cn63xxp1;
 };
 
 union cvmx_mio_fus_spr_repair_res {
@@ -968,6 +1084,8 @@ union cvmx_mio_fus_spr_repair_res {
 	struct cvmx_mio_fus_spr_repair_res_s cn56xxp1;
 	struct cvmx_mio_fus_spr_repair_res_s cn58xx;
 	struct cvmx_mio_fus_spr_repair_res_s cn58xxp1;
+	struct cvmx_mio_fus_spr_repair_res_s cn63xx;
+	struct cvmx_mio_fus_spr_repair_res_s cn63xxp1;
 };
 
 union cvmx_mio_fus_spr_repair_sum {
@@ -986,6 +1104,8 @@ union cvmx_mio_fus_spr_repair_sum {
 	struct cvmx_mio_fus_spr_repair_sum_s cn56xxp1;
 	struct cvmx_mio_fus_spr_repair_sum_s cn58xx;
 	struct cvmx_mio_fus_spr_repair_sum_s cn58xxp1;
+	struct cvmx_mio_fus_spr_repair_sum_s cn63xx;
+	struct cvmx_mio_fus_spr_repair_sum_s cn63xxp1;
 };
 
 union cvmx_mio_fus_unlock {
@@ -1021,6 +1141,22 @@ union cvmx_mio_fus_wadr {
 	struct cvmx_mio_fus_wadr_cn52xx cn56xxp1;
 	struct cvmx_mio_fus_wadr_cn50xx cn58xx;
 	struct cvmx_mio_fus_wadr_cn50xx cn58xxp1;
+	struct cvmx_mio_fus_wadr_cn63xx {
+		uint64_t reserved_4_63:60;
+		uint64_t addr:4;
+	} cn63xx;
+	struct cvmx_mio_fus_wadr_cn63xx cn63xxp1;
+};
+
+union cvmx_mio_gpio_comp {
+	uint64_t u64;
+	struct cvmx_mio_gpio_comp_s {
+		uint64_t reserved_12_63:52;
+		uint64_t pctl:6;
+		uint64_t nctl:6;
+	} s;
+	struct cvmx_mio_gpio_comp_s cn63xx;
+	struct cvmx_mio_gpio_comp_s cn63xxp1;
 };
 
 union cvmx_mio_ndf_dma_cfg {
@@ -1038,6 +1174,8 @@ union cvmx_mio_ndf_dma_cfg {
 		uint64_t adr:36;
 	} s;
 	struct cvmx_mio_ndf_dma_cfg_s cn52xx;
+	struct cvmx_mio_ndf_dma_cfg_s cn63xx;
+	struct cvmx_mio_ndf_dma_cfg_s cn63xxp1;
 };
 
 union cvmx_mio_ndf_dma_int {
@@ -1047,6 +1185,8 @@ union cvmx_mio_ndf_dma_int {
 		uint64_t done:1;
 	} s;
 	struct cvmx_mio_ndf_dma_int_s cn52xx;
+	struct cvmx_mio_ndf_dma_int_s cn63xx;
+	struct cvmx_mio_ndf_dma_int_s cn63xxp1;
 };
 
 union cvmx_mio_ndf_dma_int_en {
@@ -1056,6 +1196,8 @@ union cvmx_mio_ndf_dma_int_en {
 		uint64_t done:1;
 	} s;
 	struct cvmx_mio_ndf_dma_int_en_s cn52xx;
+	struct cvmx_mio_ndf_dma_int_en_s cn63xx;
+	struct cvmx_mio_ndf_dma_int_en_s cn63xxp1;
 };
 
 union cvmx_mio_pll_ctl {
@@ -1078,6 +1220,173 @@ union cvmx_mio_pll_setting {
 	struct cvmx_mio_pll_setting_s cn31xx;
 };
 
+union cvmx_mio_ptp_clock_cfg {
+	uint64_t u64;
+	struct cvmx_mio_ptp_clock_cfg_s {
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
+	} s;
+	struct cvmx_mio_ptp_clock_cfg_s cn63xx;
+	struct cvmx_mio_ptp_clock_cfg_s cn63xxp1;
+};
+
+union cvmx_mio_ptp_clock_comp {
+	uint64_t u64;
+	struct cvmx_mio_ptp_clock_comp_s {
+		uint64_t nanosec:32;
+		uint64_t frnanosec:32;
+	} s;
+	struct cvmx_mio_ptp_clock_comp_s cn63xx;
+	struct cvmx_mio_ptp_clock_comp_s cn63xxp1;
+};
+
+union cvmx_mio_ptp_clock_hi {
+	uint64_t u64;
+	struct cvmx_mio_ptp_clock_hi_s {
+		uint64_t nanosec:64;
+	} s;
+	struct cvmx_mio_ptp_clock_hi_s cn63xx;
+	struct cvmx_mio_ptp_clock_hi_s cn63xxp1;
+};
+
+union cvmx_mio_ptp_clock_lo {
+	uint64_t u64;
+	struct cvmx_mio_ptp_clock_lo_s {
+		uint64_t reserved_32_63:32;
+		uint64_t frnanosec:32;
+	} s;
+	struct cvmx_mio_ptp_clock_lo_s cn63xx;
+	struct cvmx_mio_ptp_clock_lo_s cn63xxp1;
+};
+
+union cvmx_mio_ptp_evt_cnt {
+	uint64_t u64;
+	struct cvmx_mio_ptp_evt_cnt_s {
+		uint64_t cntr:64;
+	} s;
+	struct cvmx_mio_ptp_evt_cnt_s cn63xx;
+	struct cvmx_mio_ptp_evt_cnt_s cn63xxp1;
+};
+
+union cvmx_mio_ptp_timestamp {
+	uint64_t u64;
+	struct cvmx_mio_ptp_timestamp_s {
+		uint64_t nanosec:64;
+	} s;
+	struct cvmx_mio_ptp_timestamp_s cn63xx;
+	struct cvmx_mio_ptp_timestamp_s cn63xxp1;
+};
+
+union cvmx_mio_rst_boot {
+	uint64_t u64;
+	struct cvmx_mio_rst_boot_s {
+		uint64_t reserved_36_63:28;
+		uint64_t c_mul:6;
+		uint64_t pnr_mul:6;
+		uint64_t qlm2_spd:4;
+		uint64_t qlm1_spd:4;
+		uint64_t qlm0_spd:4;
+		uint64_t lboot:10;
+		uint64_t rboot:1;
+		uint64_t rboot_pin:1;
+	} s;
+	struct cvmx_mio_rst_boot_s cn63xx;
+	struct cvmx_mio_rst_boot_s cn63xxp1;
+};
+
+union cvmx_mio_rst_cfg {
+	uint64_t u64;
+	struct cvmx_mio_rst_cfg_s {
+		uint64_t bist_delay:58;
+		uint64_t reserved_3_5:3;
+		uint64_t cntl_clr_bist:1;
+		uint64_t warm_clr_bist:1;
+		uint64_t soft_clr_bist:1;
+	} s;
+	struct cvmx_mio_rst_cfg_s cn63xx;
+	struct cvmx_mio_rst_cfg_cn63xxp1 {
+		uint64_t bist_delay:58;
+		uint64_t reserved_2_5:4;
+		uint64_t warm_clr_bist:1;
+		uint64_t soft_clr_bist:1;
+	} cn63xxp1;
+};
+
+union cvmx_mio_rst_ctlx {
+	uint64_t u64;
+	struct cvmx_mio_rst_ctlx_s {
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
+	} s;
+	struct cvmx_mio_rst_ctlx_s cn63xx;
+	struct cvmx_mio_rst_ctlx_cn63xxp1 {
+		uint64_t reserved_9_63:55;
+		uint64_t rst_done:1;
+		uint64_t rst_link:1;
+		uint64_t host_mode:1;
+		uint64_t prtmode:2;
+		uint64_t rst_drv:1;
+		uint64_t rst_rcv:1;
+		uint64_t rst_chip:1;
+		uint64_t rst_val:1;
+	} cn63xxp1;
+};
+
+union cvmx_mio_rst_delay {
+	uint64_t u64;
+	struct cvmx_mio_rst_delay_s {
+		uint64_t reserved_32_63:32;
+		uint64_t soft_rst_dly:16;
+		uint64_t warm_rst_dly:16;
+	} s;
+	struct cvmx_mio_rst_delay_s cn63xx;
+	struct cvmx_mio_rst_delay_s cn63xxp1;
+};
+
+union cvmx_mio_rst_int {
+	uint64_t u64;
+	struct cvmx_mio_rst_int_s {
+		uint64_t reserved_10_63:54;
+		uint64_t perst1:1;
+		uint64_t perst0:1;
+		uint64_t reserved_2_7:6;
+		uint64_t rst_link1:1;
+		uint64_t rst_link0:1;
+	} s;
+	struct cvmx_mio_rst_int_s cn63xx;
+	struct cvmx_mio_rst_int_s cn63xxp1;
+};
+
+union cvmx_mio_rst_int_en {
+	uint64_t u64;
+	struct cvmx_mio_rst_int_en_s {
+		uint64_t reserved_10_63:54;
+		uint64_t perst1:1;
+		uint64_t perst0:1;
+		uint64_t reserved_2_7:6;
+		uint64_t rst_link1:1;
+		uint64_t rst_link0:1;
+	} s;
+	struct cvmx_mio_rst_int_en_s cn63xx;
+	struct cvmx_mio_rst_int_en_s cn63xxp1;
+};
+
 union cvmx_mio_twsx_int {
 	uint64_t u64;
 	struct cvmx_mio_twsx_int_s {
@@ -1115,6 +1424,8 @@ union cvmx_mio_twsx_int {
 	struct cvmx_mio_twsx_int_s cn56xxp1;
 	struct cvmx_mio_twsx_int_s cn58xx;
 	struct cvmx_mio_twsx_int_s cn58xxp1;
+	struct cvmx_mio_twsx_int_s cn63xx;
+	struct cvmx_mio_twsx_int_s cn63xxp1;
 };
 
 union cvmx_mio_twsx_sw_twsi {
@@ -1144,6 +1455,8 @@ union cvmx_mio_twsx_sw_twsi {
 	struct cvmx_mio_twsx_sw_twsi_s cn56xxp1;
 	struct cvmx_mio_twsx_sw_twsi_s cn58xx;
 	struct cvmx_mio_twsx_sw_twsi_s cn58xxp1;
+	struct cvmx_mio_twsx_sw_twsi_s cn63xx;
+	struct cvmx_mio_twsx_sw_twsi_s cn63xxp1;
 };
 
 union cvmx_mio_twsx_sw_twsi_ext {
@@ -1164,6 +1477,8 @@ union cvmx_mio_twsx_sw_twsi_ext {
 	struct cvmx_mio_twsx_sw_twsi_ext_s cn56xxp1;
 	struct cvmx_mio_twsx_sw_twsi_ext_s cn58xx;
 	struct cvmx_mio_twsx_sw_twsi_ext_s cn58xxp1;
+	struct cvmx_mio_twsx_sw_twsi_ext_s cn63xx;
+	struct cvmx_mio_twsx_sw_twsi_ext_s cn63xxp1;
 };
 
 union cvmx_mio_twsx_twsi_sw {
@@ -1184,6 +1499,8 @@ union cvmx_mio_twsx_twsi_sw {
 	struct cvmx_mio_twsx_twsi_sw_s cn56xxp1;
 	struct cvmx_mio_twsx_twsi_sw_s cn58xx;
 	struct cvmx_mio_twsx_twsi_sw_s cn58xxp1;
+	struct cvmx_mio_twsx_twsi_sw_s cn63xx;
+	struct cvmx_mio_twsx_twsi_sw_s cn63xxp1;
 };
 
 union cvmx_mio_uartx_dlh {
@@ -1203,6 +1520,8 @@ union cvmx_mio_uartx_dlh {
 	struct cvmx_mio_uartx_dlh_s cn56xxp1;
 	struct cvmx_mio_uartx_dlh_s cn58xx;
 	struct cvmx_mio_uartx_dlh_s cn58xxp1;
+	struct cvmx_mio_uartx_dlh_s cn63xx;
+	struct cvmx_mio_uartx_dlh_s cn63xxp1;
 };
 
 union cvmx_mio_uartx_dll {
@@ -1222,6 +1541,8 @@ union cvmx_mio_uartx_dll {
 	struct cvmx_mio_uartx_dll_s cn56xxp1;
 	struct cvmx_mio_uartx_dll_s cn58xx;
 	struct cvmx_mio_uartx_dll_s cn58xxp1;
+	struct cvmx_mio_uartx_dll_s cn63xx;
+	struct cvmx_mio_uartx_dll_s cn63xxp1;
 };
 
 union cvmx_mio_uartx_far {
@@ -1241,6 +1562,8 @@ union cvmx_mio_uartx_far {
 	struct cvmx_mio_uartx_far_s cn56xxp1;
 	struct cvmx_mio_uartx_far_s cn58xx;
 	struct cvmx_mio_uartx_far_s cn58xxp1;
+	struct cvmx_mio_uartx_far_s cn63xx;
+	struct cvmx_mio_uartx_far_s cn63xxp1;
 };
 
 union cvmx_mio_uartx_fcr {
@@ -1265,6 +1588,8 @@ union cvmx_mio_uartx_fcr {
 	struct cvmx_mio_uartx_fcr_s cn56xxp1;
 	struct cvmx_mio_uartx_fcr_s cn58xx;
 	struct cvmx_mio_uartx_fcr_s cn58xxp1;
+	struct cvmx_mio_uartx_fcr_s cn63xx;
+	struct cvmx_mio_uartx_fcr_s cn63xxp1;
 };
 
 union cvmx_mio_uartx_htx {
@@ -1284,6 +1609,8 @@ union cvmx_mio_uartx_htx {
 	struct cvmx_mio_uartx_htx_s cn56xxp1;
 	struct cvmx_mio_uartx_htx_s cn58xx;
 	struct cvmx_mio_uartx_htx_s cn58xxp1;
+	struct cvmx_mio_uartx_htx_s cn63xx;
+	struct cvmx_mio_uartx_htx_s cn63xxp1;
 };
 
 union cvmx_mio_uartx_ier {
@@ -1308,6 +1635,8 @@ union cvmx_mio_uartx_ier {
 	struct cvmx_mio_uartx_ier_s cn56xxp1;
 	struct cvmx_mio_uartx_ier_s cn58xx;
 	struct cvmx_mio_uartx_ier_s cn58xxp1;
+	struct cvmx_mio_uartx_ier_s cn63xx;
+	struct cvmx_mio_uartx_ier_s cn63xxp1;
 };
 
 union cvmx_mio_uartx_iir {
@@ -1329,6 +1658,8 @@ union cvmx_mio_uartx_iir {
 	struct cvmx_mio_uartx_iir_s cn56xxp1;
 	struct cvmx_mio_uartx_iir_s cn58xx;
 	struct cvmx_mio_uartx_iir_s cn58xxp1;
+	struct cvmx_mio_uartx_iir_s cn63xx;
+	struct cvmx_mio_uartx_iir_s cn63xxp1;
 };
 
 union cvmx_mio_uartx_lcr {
@@ -1354,6 +1685,8 @@ union cvmx_mio_uartx_lcr {
 	struct cvmx_mio_uartx_lcr_s cn56xxp1;
 	struct cvmx_mio_uartx_lcr_s cn58xx;
 	struct cvmx_mio_uartx_lcr_s cn58xxp1;
+	struct cvmx_mio_uartx_lcr_s cn63xx;
+	struct cvmx_mio_uartx_lcr_s cn63xxp1;
 };
 
 union cvmx_mio_uartx_lsr {
@@ -1380,6 +1713,8 @@ union cvmx_mio_uartx_lsr {
 	struct cvmx_mio_uartx_lsr_s cn56xxp1;
 	struct cvmx_mio_uartx_lsr_s cn58xx;
 	struct cvmx_mio_uartx_lsr_s cn58xxp1;
+	struct cvmx_mio_uartx_lsr_s cn63xx;
+	struct cvmx_mio_uartx_lsr_s cn63xxp1;
 };
 
 union cvmx_mio_uartx_mcr {
@@ -1404,6 +1739,8 @@ union cvmx_mio_uartx_mcr {
 	struct cvmx_mio_uartx_mcr_s cn56xxp1;
 	struct cvmx_mio_uartx_mcr_s cn58xx;
 	struct cvmx_mio_uartx_mcr_s cn58xxp1;
+	struct cvmx_mio_uartx_mcr_s cn63xx;
+	struct cvmx_mio_uartx_mcr_s cn63xxp1;
 };
 
 union cvmx_mio_uartx_msr {
@@ -1430,6 +1767,8 @@ union cvmx_mio_uartx_msr {
 	struct cvmx_mio_uartx_msr_s cn56xxp1;
 	struct cvmx_mio_uartx_msr_s cn58xx;
 	struct cvmx_mio_uartx_msr_s cn58xxp1;
+	struct cvmx_mio_uartx_msr_s cn63xx;
+	struct cvmx_mio_uartx_msr_s cn63xxp1;
 };
 
 union cvmx_mio_uartx_rbr {
@@ -1449,6 +1788,8 @@ union cvmx_mio_uartx_rbr {
 	struct cvmx_mio_uartx_rbr_s cn56xxp1;
 	struct cvmx_mio_uartx_rbr_s cn58xx;
 	struct cvmx_mio_uartx_rbr_s cn58xxp1;
+	struct cvmx_mio_uartx_rbr_s cn63xx;
+	struct cvmx_mio_uartx_rbr_s cn63xxp1;
 };
 
 union cvmx_mio_uartx_rfl {
@@ -1468,6 +1809,8 @@ union cvmx_mio_uartx_rfl {
 	struct cvmx_mio_uartx_rfl_s cn56xxp1;
 	struct cvmx_mio_uartx_rfl_s cn58xx;
 	struct cvmx_mio_uartx_rfl_s cn58xxp1;
+	struct cvmx_mio_uartx_rfl_s cn63xx;
+	struct cvmx_mio_uartx_rfl_s cn63xxp1;
 };
 
 union cvmx_mio_uartx_rfw {
@@ -1489,6 +1832,8 @@ union cvmx_mio_uartx_rfw {
 	struct cvmx_mio_uartx_rfw_s cn56xxp1;
 	struct cvmx_mio_uartx_rfw_s cn58xx;
 	struct cvmx_mio_uartx_rfw_s cn58xxp1;
+	struct cvmx_mio_uartx_rfw_s cn63xx;
+	struct cvmx_mio_uartx_rfw_s cn63xxp1;
 };
 
 union cvmx_mio_uartx_sbcr {
@@ -1508,6 +1853,8 @@ union cvmx_mio_uartx_sbcr {
 	struct cvmx_mio_uartx_sbcr_s cn56xxp1;
 	struct cvmx_mio_uartx_sbcr_s cn58xx;
 	struct cvmx_mio_uartx_sbcr_s cn58xxp1;
+	struct cvmx_mio_uartx_sbcr_s cn63xx;
+	struct cvmx_mio_uartx_sbcr_s cn63xxp1;
 };
 
 union cvmx_mio_uartx_scr {
@@ -1527,6 +1874,8 @@ union cvmx_mio_uartx_scr {
 	struct cvmx_mio_uartx_scr_s cn56xxp1;
 	struct cvmx_mio_uartx_scr_s cn58xx;
 	struct cvmx_mio_uartx_scr_s cn58xxp1;
+	struct cvmx_mio_uartx_scr_s cn63xx;
+	struct cvmx_mio_uartx_scr_s cn63xxp1;
 };
 
 union cvmx_mio_uartx_sfe {
@@ -1546,6 +1895,8 @@ union cvmx_mio_uartx_sfe {
 	struct cvmx_mio_uartx_sfe_s cn56xxp1;
 	struct cvmx_mio_uartx_sfe_s cn58xx;
 	struct cvmx_mio_uartx_sfe_s cn58xxp1;
+	struct cvmx_mio_uartx_sfe_s cn63xx;
+	struct cvmx_mio_uartx_sfe_s cn63xxp1;
 };
 
 union cvmx_mio_uartx_srr {
@@ -1567,6 +1918,8 @@ union cvmx_mio_uartx_srr {
 	struct cvmx_mio_uartx_srr_s cn56xxp1;
 	struct cvmx_mio_uartx_srr_s cn58xx;
 	struct cvmx_mio_uartx_srr_s cn58xxp1;
+	struct cvmx_mio_uartx_srr_s cn63xx;
+	struct cvmx_mio_uartx_srr_s cn63xxp1;
 };
 
 union cvmx_mio_uartx_srt {
@@ -1586,6 +1939,8 @@ union cvmx_mio_uartx_srt {
 	struct cvmx_mio_uartx_srt_s cn56xxp1;
 	struct cvmx_mio_uartx_srt_s cn58xx;
 	struct cvmx_mio_uartx_srt_s cn58xxp1;
+	struct cvmx_mio_uartx_srt_s cn63xx;
+	struct cvmx_mio_uartx_srt_s cn63xxp1;
 };
 
 union cvmx_mio_uartx_srts {
@@ -1605,6 +1960,8 @@ union cvmx_mio_uartx_srts {
 	struct cvmx_mio_uartx_srts_s cn56xxp1;
 	struct cvmx_mio_uartx_srts_s cn58xx;
 	struct cvmx_mio_uartx_srts_s cn58xxp1;
+	struct cvmx_mio_uartx_srts_s cn63xx;
+	struct cvmx_mio_uartx_srts_s cn63xxp1;
 };
 
 union cvmx_mio_uartx_stt {
@@ -1624,6 +1981,8 @@ union cvmx_mio_uartx_stt {
 	struct cvmx_mio_uartx_stt_s cn56xxp1;
 	struct cvmx_mio_uartx_stt_s cn58xx;
 	struct cvmx_mio_uartx_stt_s cn58xxp1;
+	struct cvmx_mio_uartx_stt_s cn63xx;
+	struct cvmx_mio_uartx_stt_s cn63xxp1;
 };
 
 union cvmx_mio_uartx_tfl {
@@ -1643,6 +2002,8 @@ union cvmx_mio_uartx_tfl {
 	struct cvmx_mio_uartx_tfl_s cn56xxp1;
 	struct cvmx_mio_uartx_tfl_s cn58xx;
 	struct cvmx_mio_uartx_tfl_s cn58xxp1;
+	struct cvmx_mio_uartx_tfl_s cn63xx;
+	struct cvmx_mio_uartx_tfl_s cn63xxp1;
 };
 
 union cvmx_mio_uartx_tfr {
@@ -1662,6 +2023,8 @@ union cvmx_mio_uartx_tfr {
 	struct cvmx_mio_uartx_tfr_s cn56xxp1;
 	struct cvmx_mio_uartx_tfr_s cn58xx;
 	struct cvmx_mio_uartx_tfr_s cn58xxp1;
+	struct cvmx_mio_uartx_tfr_s cn63xx;
+	struct cvmx_mio_uartx_tfr_s cn63xxp1;
 };
 
 union cvmx_mio_uartx_thr {
@@ -1681,6 +2044,8 @@ union cvmx_mio_uartx_thr {
 	struct cvmx_mio_uartx_thr_s cn56xxp1;
 	struct cvmx_mio_uartx_thr_s cn58xx;
 	struct cvmx_mio_uartx_thr_s cn58xxp1;
+	struct cvmx_mio_uartx_thr_s cn63xx;
+	struct cvmx_mio_uartx_thr_s cn63xxp1;
 };
 
 union cvmx_mio_uartx_usr {
@@ -1704,6 +2069,8 @@ union cvmx_mio_uartx_usr {
 	struct cvmx_mio_uartx_usr_s cn56xxp1;
 	struct cvmx_mio_uartx_usr_s cn58xx;
 	struct cvmx_mio_uartx_usr_s cn58xxp1;
+	struct cvmx_mio_uartx_usr_s cn63xx;
+	struct cvmx_mio_uartx_usr_s cn63xxp1;
 };
 
 union cvmx_mio_uart2_dlh {
diff --git a/arch/mips/include/asm/octeon/cvmx-mixx-defs.h b/arch/mips/include/asm/octeon/cvmx-mixx-defs.h
index dab6dca..7057c44 100644
--- a/arch/mips/include/asm/octeon/cvmx-mixx-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-mixx-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2010 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -28,52 +28,52 @@
 #ifndef __CVMX_MIXX_DEFS_H__
 #define __CVMX_MIXX_DEFS_H__
 
-#define CVMX_MIXX_BIST(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000100078ull + (((offset) & 1) * 2048))
-#define CVMX_MIXX_CTL(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000100020ull + (((offset) & 1) * 2048))
-#define CVMX_MIXX_INTENA(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000100050ull + (((offset) & 1) * 2048))
-#define CVMX_MIXX_IRCNT(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000100030ull + (((offset) & 1) * 2048))
-#define CVMX_MIXX_IRHWM(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000100028ull + (((offset) & 1) * 2048))
-#define CVMX_MIXX_IRING1(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000100010ull + (((offset) & 1) * 2048))
-#define CVMX_MIXX_IRING2(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000100018ull + (((offset) & 1) * 2048))
-#define CVMX_MIXX_ISR(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000100048ull + (((offset) & 1) * 2048))
-#define CVMX_MIXX_ORCNT(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000100040ull + (((offset) & 1) * 2048))
-#define CVMX_MIXX_ORHWM(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000100038ull + (((offset) & 1) * 2048))
-#define CVMX_MIXX_ORING1(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000100000ull + (((offset) & 1) * 2048))
-#define CVMX_MIXX_ORING2(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000100008ull + (((offset) & 1) * 2048))
-#define CVMX_MIXX_REMCNT(offset) \
-	 CVMX_ADD_IO_SEG(0x0001070000100058ull + (((offset) & 1) * 2048))
+#define CVMX_MIXX_BIST(offset) (CVMX_ADD_IO_SEG(0x0001070000100078ull) + ((offset) & 1) * 2048)
+#define CVMX_MIXX_CTL(offset) (CVMX_ADD_IO_SEG(0x0001070000100020ull) + ((offset) & 1) * 2048)
+#define CVMX_MIXX_INTENA(offset) (CVMX_ADD_IO_SEG(0x0001070000100050ull) + ((offset) & 1) * 2048)
+#define CVMX_MIXX_IRCNT(offset) (CVMX_ADD_IO_SEG(0x0001070000100030ull) + ((offset) & 1) * 2048)
+#define CVMX_MIXX_IRHWM(offset) (CVMX_ADD_IO_SEG(0x0001070000100028ull) + ((offset) & 1) * 2048)
+#define CVMX_MIXX_IRING1(offset) (CVMX_ADD_IO_SEG(0x0001070000100010ull) + ((offset) & 1) * 2048)
+#define CVMX_MIXX_IRING2(offset) (CVMX_ADD_IO_SEG(0x0001070000100018ull) + ((offset) & 1) * 2048)
+#define CVMX_MIXX_ISR(offset) (CVMX_ADD_IO_SEG(0x0001070000100048ull) + ((offset) & 1) * 2048)
+#define CVMX_MIXX_ORCNT(offset) (CVMX_ADD_IO_SEG(0x0001070000100040ull) + ((offset) & 1) * 2048)
+#define CVMX_MIXX_ORHWM(offset) (CVMX_ADD_IO_SEG(0x0001070000100038ull) + ((offset) & 1) * 2048)
+#define CVMX_MIXX_ORING1(offset) (CVMX_ADD_IO_SEG(0x0001070000100000ull) + ((offset) & 1) * 2048)
+#define CVMX_MIXX_ORING2(offset) (CVMX_ADD_IO_SEG(0x0001070000100008ull) + ((offset) & 1) * 2048)
+#define CVMX_MIXX_REMCNT(offset) (CVMX_ADD_IO_SEG(0x0001070000100058ull) + ((offset) & 1) * 2048)
+#define CVMX_MIXX_TSCTL(offset) (CVMX_ADD_IO_SEG(0x0001070000100068ull) + ((offset) & 1) * 2048)
+#define CVMX_MIXX_TSTAMP(offset) (CVMX_ADD_IO_SEG(0x0001070000100060ull) + ((offset) & 1) * 2048)
 
 union cvmx_mixx_bist {
 	uint64_t u64;
 	struct cvmx_mixx_bist_s {
-		uint64_t reserved_4_63:60;
+		uint64_t reserved_6_63:58;
+		uint64_t opfdat:1;
+		uint64_t mrgdat:1;
 		uint64_t mrqdat:1;
 		uint64_t ipfdat:1;
 		uint64_t irfdat:1;
 		uint64_t orfdat:1;
 	} s;
-	struct cvmx_mixx_bist_s cn52xx;
-	struct cvmx_mixx_bist_s cn52xxp1;
-	struct cvmx_mixx_bist_s cn56xx;
-	struct cvmx_mixx_bist_s cn56xxp1;
+	struct cvmx_mixx_bist_cn52xx {
+		uint64_t reserved_4_63:60;
+		uint64_t mrqdat:1;
+		uint64_t ipfdat:1;
+		uint64_t irfdat:1;
+		uint64_t orfdat:1;
+	} cn52xx;
+	struct cvmx_mixx_bist_cn52xx cn52xxp1;
+	struct cvmx_mixx_bist_cn52xx cn56xx;
+	struct cvmx_mixx_bist_cn52xx cn56xxp1;
+	struct cvmx_mixx_bist_s cn63xx;
+	struct cvmx_mixx_bist_s cn63xxp1;
 };
 
 union cvmx_mixx_ctl {
 	uint64_t u64;
 	struct cvmx_mixx_ctl_s {
-		uint64_t reserved_8_63:56;
+		uint64_t reserved_12_63:52;
+		uint64_t ts_thresh:4;
 		uint64_t crc_strip:1;
 		uint64_t busy:1;
 		uint64_t en:1;
@@ -82,16 +82,28 @@ union cvmx_mixx_ctl {
 		uint64_t nbtarb:1;
 		uint64_t mrq_hwm:2;
 	} s;
-	struct cvmx_mixx_ctl_s cn52xx;
-	struct cvmx_mixx_ctl_s cn52xxp1;
-	struct cvmx_mixx_ctl_s cn56xx;
-	struct cvmx_mixx_ctl_s cn56xxp1;
+	struct cvmx_mixx_ctl_cn52xx {
+		uint64_t reserved_8_63:56;
+		uint64_t crc_strip:1;
+		uint64_t busy:1;
+		uint64_t en:1;
+		uint64_t reset:1;
+		uint64_t lendian:1;
+		uint64_t nbtarb:1;
+		uint64_t mrq_hwm:2;
+	} cn52xx;
+	struct cvmx_mixx_ctl_cn52xx cn52xxp1;
+	struct cvmx_mixx_ctl_cn52xx cn56xx;
+	struct cvmx_mixx_ctl_cn52xx cn56xxp1;
+	struct cvmx_mixx_ctl_s cn63xx;
+	struct cvmx_mixx_ctl_s cn63xxp1;
 };
 
 union cvmx_mixx_intena {
 	uint64_t u64;
 	struct cvmx_mixx_intena_s {
-		uint64_t reserved_7_63:57;
+		uint64_t reserved_8_63:56;
+		uint64_t tsena:1;
 		uint64_t orunena:1;
 		uint64_t irunena:1;
 		uint64_t data_drpena:1;
@@ -100,10 +112,21 @@ union cvmx_mixx_intena {
 		uint64_t ivfena:1;
 		uint64_t ovfena:1;
 	} s;
-	struct cvmx_mixx_intena_s cn52xx;
-	struct cvmx_mixx_intena_s cn52xxp1;
-	struct cvmx_mixx_intena_s cn56xx;
-	struct cvmx_mixx_intena_s cn56xxp1;
+	struct cvmx_mixx_intena_cn52xx {
+		uint64_t reserved_7_63:57;
+		uint64_t orunena:1;
+		uint64_t irunena:1;
+		uint64_t data_drpena:1;
+		uint64_t ithena:1;
+		uint64_t othena:1;
+		uint64_t ivfena:1;
+		uint64_t ovfena:1;
+	} cn52xx;
+	struct cvmx_mixx_intena_cn52xx cn52xxp1;
+	struct cvmx_mixx_intena_cn52xx cn56xx;
+	struct cvmx_mixx_intena_cn52xx cn56xxp1;
+	struct cvmx_mixx_intena_s cn63xx;
+	struct cvmx_mixx_intena_s cn63xxp1;
 };
 
 union cvmx_mixx_ircnt {
@@ -116,6 +139,8 @@ union cvmx_mixx_ircnt {
 	struct cvmx_mixx_ircnt_s cn52xxp1;
 	struct cvmx_mixx_ircnt_s cn56xx;
 	struct cvmx_mixx_ircnt_s cn56xxp1;
+	struct cvmx_mixx_ircnt_s cn63xx;
+	struct cvmx_mixx_ircnt_s cn63xxp1;
 };
 
 union cvmx_mixx_irhwm {
@@ -129,6 +154,8 @@ union cvmx_mixx_irhwm {
 	struct cvmx_mixx_irhwm_s cn52xxp1;
 	struct cvmx_mixx_irhwm_s cn56xx;
 	struct cvmx_mixx_irhwm_s cn56xxp1;
+	struct cvmx_mixx_irhwm_s cn63xx;
+	struct cvmx_mixx_irhwm_s cn63xxp1;
 };
 
 union cvmx_mixx_iring1 {
@@ -136,14 +163,21 @@ union cvmx_mixx_iring1 {
 	struct cvmx_mixx_iring1_s {
 		uint64_t reserved_60_63:4;
 		uint64_t isize:20;
+		uint64_t ibase:37;
+		uint64_t reserved_0_2:3;
+	} s;
+	struct cvmx_mixx_iring1_cn52xx {
+		uint64_t reserved_60_63:4;
+		uint64_t isize:20;
 		uint64_t reserved_36_39:4;
 		uint64_t ibase:33;
 		uint64_t reserved_0_2:3;
-	} s;
-	struct cvmx_mixx_iring1_s cn52xx;
-	struct cvmx_mixx_iring1_s cn52xxp1;
-	struct cvmx_mixx_iring1_s cn56xx;
-	struct cvmx_mixx_iring1_s cn56xxp1;
+	} cn52xx;
+	struct cvmx_mixx_iring1_cn52xx cn52xxp1;
+	struct cvmx_mixx_iring1_cn52xx cn56xx;
+	struct cvmx_mixx_iring1_cn52xx cn56xxp1;
+	struct cvmx_mixx_iring1_s cn63xx;
+	struct cvmx_mixx_iring1_s cn63xxp1;
 };
 
 union cvmx_mixx_iring2 {
@@ -158,12 +192,15 @@ union cvmx_mixx_iring2 {
 	struct cvmx_mixx_iring2_s cn52xxp1;
 	struct cvmx_mixx_iring2_s cn56xx;
 	struct cvmx_mixx_iring2_s cn56xxp1;
+	struct cvmx_mixx_iring2_s cn63xx;
+	struct cvmx_mixx_iring2_s cn63xxp1;
 };
 
 union cvmx_mixx_isr {
 	uint64_t u64;
 	struct cvmx_mixx_isr_s {
-		uint64_t reserved_7_63:57;
+		uint64_t reserved_8_63:56;
+		uint64_t ts:1;
 		uint64_t orun:1;
 		uint64_t irun:1;
 		uint64_t data_drp:1;
@@ -172,10 +209,21 @@ union cvmx_mixx_isr {
 		uint64_t idblovf:1;
 		uint64_t odblovf:1;
 	} s;
-	struct cvmx_mixx_isr_s cn52xx;
-	struct cvmx_mixx_isr_s cn52xxp1;
-	struct cvmx_mixx_isr_s cn56xx;
-	struct cvmx_mixx_isr_s cn56xxp1;
+	struct cvmx_mixx_isr_cn52xx {
+		uint64_t reserved_7_63:57;
+		uint64_t orun:1;
+		uint64_t irun:1;
+		uint64_t data_drp:1;
+		uint64_t irthresh:1;
+		uint64_t orthresh:1;
+		uint64_t idblovf:1;
+		uint64_t odblovf:1;
+	} cn52xx;
+	struct cvmx_mixx_isr_cn52xx cn52xxp1;
+	struct cvmx_mixx_isr_cn52xx cn56xx;
+	struct cvmx_mixx_isr_cn52xx cn56xxp1;
+	struct cvmx_mixx_isr_s cn63xx;
+	struct cvmx_mixx_isr_s cn63xxp1;
 };
 
 union cvmx_mixx_orcnt {
@@ -188,6 +236,8 @@ union cvmx_mixx_orcnt {
 	struct cvmx_mixx_orcnt_s cn52xxp1;
 	struct cvmx_mixx_orcnt_s cn56xx;
 	struct cvmx_mixx_orcnt_s cn56xxp1;
+	struct cvmx_mixx_orcnt_s cn63xx;
+	struct cvmx_mixx_orcnt_s cn63xxp1;
 };
 
 union cvmx_mixx_orhwm {
@@ -200,6 +250,8 @@ union cvmx_mixx_orhwm {
 	struct cvmx_mixx_orhwm_s cn52xxp1;
 	struct cvmx_mixx_orhwm_s cn56xx;
 	struct cvmx_mixx_orhwm_s cn56xxp1;
+	struct cvmx_mixx_orhwm_s cn63xx;
+	struct cvmx_mixx_orhwm_s cn63xxp1;
 };
 
 union cvmx_mixx_oring1 {
@@ -207,14 +259,21 @@ union cvmx_mixx_oring1 {
 	struct cvmx_mixx_oring1_s {
 		uint64_t reserved_60_63:4;
 		uint64_t osize:20;
+		uint64_t obase:37;
+		uint64_t reserved_0_2:3;
+	} s;
+	struct cvmx_mixx_oring1_cn52xx {
+		uint64_t reserved_60_63:4;
+		uint64_t osize:20;
 		uint64_t reserved_36_39:4;
 		uint64_t obase:33;
 		uint64_t reserved_0_2:3;
-	} s;
-	struct cvmx_mixx_oring1_s cn52xx;
-	struct cvmx_mixx_oring1_s cn52xxp1;
-	struct cvmx_mixx_oring1_s cn56xx;
-	struct cvmx_mixx_oring1_s cn56xxp1;
+	} cn52xx;
+	struct cvmx_mixx_oring1_cn52xx cn52xxp1;
+	struct cvmx_mixx_oring1_cn52xx cn56xx;
+	struct cvmx_mixx_oring1_cn52xx cn56xxp1;
+	struct cvmx_mixx_oring1_s cn63xx;
+	struct cvmx_mixx_oring1_s cn63xxp1;
 };
 
 union cvmx_mixx_oring2 {
@@ -229,6 +288,8 @@ union cvmx_mixx_oring2 {
 	struct cvmx_mixx_oring2_s cn52xxp1;
 	struct cvmx_mixx_oring2_s cn56xx;
 	struct cvmx_mixx_oring2_s cn56xxp1;
+	struct cvmx_mixx_oring2_s cn63xx;
+	struct cvmx_mixx_oring2_s cn63xxp1;
 };
 
 union cvmx_mixx_remcnt {
@@ -243,6 +304,31 @@ union cvmx_mixx_remcnt {
 	struct cvmx_mixx_remcnt_s cn52xxp1;
 	struct cvmx_mixx_remcnt_s cn56xx;
 	struct cvmx_mixx_remcnt_s cn56xxp1;
+	struct cvmx_mixx_remcnt_s cn63xx;
+	struct cvmx_mixx_remcnt_s cn63xxp1;
+};
+
+union cvmx_mixx_tsctl {
+	uint64_t u64;
+	struct cvmx_mixx_tsctl_s {
+		uint64_t reserved_21_63:43;
+		uint64_t tsavl:5;
+		uint64_t reserved_13_15:3;
+		uint64_t tstot:5;
+		uint64_t reserved_5_7:3;
+		uint64_t tscnt:5;
+	} s;
+	struct cvmx_mixx_tsctl_s cn63xx;
+	struct cvmx_mixx_tsctl_s cn63xxp1;
+};
+
+union cvmx_mixx_tstamp {
+	uint64_t u64;
+	struct cvmx_mixx_tstamp_s {
+		uint64_t tstamp:64;
+	} s;
+	struct cvmx_mixx_tstamp_s cn63xx;
+	struct cvmx_mixx_tstamp_s cn63xxp1;
 };
 
 #endif
diff --git a/arch/mips/include/asm/octeon/cvmx-npei-defs.h b/arch/mips/include/asm/octeon/cvmx-npei-defs.h
index 4b347bb..9899a9d 100644
--- a/arch/mips/include/asm/octeon/cvmx-npei-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-npei-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2010 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -28,206 +28,114 @@
 #ifndef __CVMX_NPEI_DEFS_H__
 #define __CVMX_NPEI_DEFS_H__
 
-#define CVMX_NPEI_BAR1_INDEXX(offset) \
-	 (0x0000000000000000ull + (((offset) & 31) * 16))
-#define CVMX_NPEI_BIST_STATUS \
-	 (0x0000000000000580ull)
-#define CVMX_NPEI_BIST_STATUS2 \
-	 (0x0000000000000680ull)
-#define CVMX_NPEI_CTL_PORT0 \
-	 (0x0000000000000250ull)
-#define CVMX_NPEI_CTL_PORT1 \
-	 (0x0000000000000260ull)
-#define CVMX_NPEI_CTL_STATUS \
-	 (0x0000000000000570ull)
-#define CVMX_NPEI_CTL_STATUS2 \
-	 (0x0000000000003C00ull)
-#define CVMX_NPEI_DATA_OUT_CNT \
-	 (0x00000000000005F0ull)
-#define CVMX_NPEI_DBG_DATA \
-	 (0x0000000000000510ull)
-#define CVMX_NPEI_DBG_SELECT \
-	 (0x0000000000000500ull)
-#define CVMX_NPEI_DMA0_INT_LEVEL \
-	 (0x00000000000005C0ull)
-#define CVMX_NPEI_DMA1_INT_LEVEL \
-	 (0x00000000000005D0ull)
-#define CVMX_NPEI_DMAX_COUNTS(offset) \
-	 (0x0000000000000450ull + (((offset) & 7) * 16))
-#define CVMX_NPEI_DMAX_DBELL(offset) \
-	 (0x00000000000003B0ull + (((offset) & 7) * 16))
-#define CVMX_NPEI_DMAX_IBUFF_SADDR(offset) \
-	 (0x0000000000000400ull + (((offset) & 7) * 16))
-#define CVMX_NPEI_DMAX_NADDR(offset) \
-	 (0x00000000000004A0ull + (((offset) & 7) * 16))
-#define CVMX_NPEI_DMA_CNTS \
-	 (0x00000000000005E0ull)
-#define CVMX_NPEI_DMA_CONTROL \
-	 (0x00000000000003A0ull)
-#define CVMX_NPEI_INT_A_ENB \
-	 (0x0000000000000560ull)
-#define CVMX_NPEI_INT_A_ENB2 \
-	 (0x0000000000003CE0ull)
-#define CVMX_NPEI_INT_A_SUM \
-	 (0x0000000000000550ull)
-#define CVMX_NPEI_INT_ENB \
-	 (0x0000000000000540ull)
-#define CVMX_NPEI_INT_ENB2 \
-	 (0x0000000000003CD0ull)
-#define CVMX_NPEI_INT_INFO \
-	 (0x0000000000000590ull)
-#define CVMX_NPEI_INT_SUM \
-	 (0x0000000000000530ull)
-#define CVMX_NPEI_INT_SUM2 \
-	 (0x0000000000003CC0ull)
-#define CVMX_NPEI_LAST_WIN_RDATA0 \
-	 (0x0000000000000600ull)
-#define CVMX_NPEI_LAST_WIN_RDATA1 \
-	 (0x0000000000000610ull)
-#define CVMX_NPEI_MEM_ACCESS_CTL \
-	 (0x00000000000004F0ull)
-#define CVMX_NPEI_MEM_ACCESS_SUBIDX(offset) \
-	 (0x0000000000000340ull + (((offset) & 31) * 16) - 16 * 12)
-#define CVMX_NPEI_MSI_ENB0 \
-	 (0x0000000000003C50ull)
-#define CVMX_NPEI_MSI_ENB1 \
-	 (0x0000000000003C60ull)
-#define CVMX_NPEI_MSI_ENB2 \
-	 (0x0000000000003C70ull)
-#define CVMX_NPEI_MSI_ENB3 \
-	 (0x0000000000003C80ull)
-#define CVMX_NPEI_MSI_RCV0 \
-	 (0x0000000000003C10ull)
-#define CVMX_NPEI_MSI_RCV1 \
-	 (0x0000000000003C20ull)
-#define CVMX_NPEI_MSI_RCV2 \
-	 (0x0000000000003C30ull)
-#define CVMX_NPEI_MSI_RCV3 \
-	 (0x0000000000003C40ull)
-#define CVMX_NPEI_MSI_RD_MAP \
-	 (0x0000000000003CA0ull)
-#define CVMX_NPEI_MSI_W1C_ENB0 \
-	 (0x0000000000003CF0ull)
-#define CVMX_NPEI_MSI_W1C_ENB1 \
-	 (0x0000000000003D00ull)
-#define CVMX_NPEI_MSI_W1C_ENB2 \
-	 (0x0000000000003D10ull)
-#define CVMX_NPEI_MSI_W1C_ENB3 \
-	 (0x0000000000003D20ull)
-#define CVMX_NPEI_MSI_W1S_ENB0 \
-	 (0x0000000000003D30ull)
-#define CVMX_NPEI_MSI_W1S_ENB1 \
-	 (0x0000000000003D40ull)
-#define CVMX_NPEI_MSI_W1S_ENB2 \
-	 (0x0000000000003D50ull)
-#define CVMX_NPEI_MSI_W1S_ENB3 \
-	 (0x0000000000003D60ull)
-#define CVMX_NPEI_MSI_WR_MAP \
-	 (0x0000000000003C90ull)
-#define CVMX_NPEI_PCIE_CREDIT_CNT \
-	 (0x0000000000003D70ull)
-#define CVMX_NPEI_PCIE_MSI_RCV \
-	 (0x0000000000003CB0ull)
-#define CVMX_NPEI_PCIE_MSI_RCV_B1 \
-	 (0x0000000000000650ull)
-#define CVMX_NPEI_PCIE_MSI_RCV_B2 \
-	 (0x0000000000000660ull)
-#define CVMX_NPEI_PCIE_MSI_RCV_B3 \
-	 (0x0000000000000670ull)
-#define CVMX_NPEI_PKTX_CNTS(offset) \
-	 (0x0000000000002400ull + (((offset) & 31) * 16))
-#define CVMX_NPEI_PKTX_INSTR_BADDR(offset) \
-	 (0x0000000000002800ull + (((offset) & 31) * 16))
-#define CVMX_NPEI_PKTX_INSTR_BAOFF_DBELL(offset) \
-	 (0x0000000000002C00ull + (((offset) & 31) * 16))
-#define CVMX_NPEI_PKTX_INSTR_FIFO_RSIZE(offset) \
-	 (0x0000000000003000ull + (((offset) & 31) * 16))
-#define CVMX_NPEI_PKTX_INSTR_HEADER(offset) \
-	 (0x0000000000003400ull + (((offset) & 31) * 16))
-#define CVMX_NPEI_PKTX_IN_BP(offset) \
-	 (0x0000000000003800ull + (((offset) & 31) * 16))
-#define CVMX_NPEI_PKTX_SLIST_BADDR(offset) \
-	 (0x0000000000001400ull + (((offset) & 31) * 16))
-#define CVMX_NPEI_PKTX_SLIST_BAOFF_DBELL(offset) \
-	 (0x0000000000001800ull + (((offset) & 31) * 16))
-#define CVMX_NPEI_PKTX_SLIST_FIFO_RSIZE(offset) \
-	 (0x0000000000001C00ull + (((offset) & 31) * 16))
-#define CVMX_NPEI_PKT_CNT_INT \
-	 (0x0000000000001110ull)
-#define CVMX_NPEI_PKT_CNT_INT_ENB \
-	 (0x0000000000001130ull)
-#define CVMX_NPEI_PKT_DATA_OUT_ES \
-	 (0x00000000000010B0ull)
-#define CVMX_NPEI_PKT_DATA_OUT_NS \
-	 (0x00000000000010A0ull)
-#define CVMX_NPEI_PKT_DATA_OUT_ROR \
-	 (0x0000000000001090ull)
-#define CVMX_NPEI_PKT_DPADDR \
-	 (0x0000000000001080ull)
-#define CVMX_NPEI_PKT_INPUT_CONTROL \
-	 (0x0000000000001150ull)
-#define CVMX_NPEI_PKT_INSTR_ENB \
-	 (0x0000000000001000ull)
-#define CVMX_NPEI_PKT_INSTR_RD_SIZE \
-	 (0x0000000000001190ull)
-#define CVMX_NPEI_PKT_INSTR_SIZE \
-	 (0x0000000000001020ull)
-#define CVMX_NPEI_PKT_INT_LEVELS \
-	 (0x0000000000001100ull)
-#define CVMX_NPEI_PKT_IN_BP \
-	 (0x00000000000006B0ull)
-#define CVMX_NPEI_PKT_IN_DONEX_CNTS(offset) \
-	 (0x0000000000002000ull + (((offset) & 31) * 16))
-#define CVMX_NPEI_PKT_IN_INSTR_COUNTS \
-	 (0x00000000000006A0ull)
-#define CVMX_NPEI_PKT_IN_PCIE_PORT \
-	 (0x00000000000011A0ull)
-#define CVMX_NPEI_PKT_IPTR \
-	 (0x0000000000001070ull)
-#define CVMX_NPEI_PKT_OUTPUT_WMARK \
-	 (0x0000000000001160ull)
-#define CVMX_NPEI_PKT_OUT_BMODE \
-	 (0x00000000000010D0ull)
-#define CVMX_NPEI_PKT_OUT_ENB \
-	 (0x0000000000001010ull)
-#define CVMX_NPEI_PKT_PCIE_PORT \
-	 (0x00000000000010E0ull)
-#define CVMX_NPEI_PKT_PORT_IN_RST \
-	 (0x0000000000000690ull)
-#define CVMX_NPEI_PKT_SLIST_ES \
-	 (0x0000000000001050ull)
-#define CVMX_NPEI_PKT_SLIST_ID_SIZE \
-	 (0x0000000000001180ull)
-#define CVMX_NPEI_PKT_SLIST_NS \
-	 (0x0000000000001040ull)
-#define CVMX_NPEI_PKT_SLIST_ROR \
-	 (0x0000000000001030ull)
-#define CVMX_NPEI_PKT_TIME_INT \
-	 (0x0000000000001120ull)
-#define CVMX_NPEI_PKT_TIME_INT_ENB \
-	 (0x0000000000001140ull)
-#define CVMX_NPEI_RSL_INT_BLOCKS \
-	 (0x0000000000000520ull)
-#define CVMX_NPEI_SCRATCH_1 \
-	 (0x0000000000000270ull)
-#define CVMX_NPEI_STATE1 \
-	 (0x0000000000000620ull)
-#define CVMX_NPEI_STATE2 \
-	 (0x0000000000000630ull)
-#define CVMX_NPEI_STATE3 \
-	 (0x0000000000000640ull)
-#define CVMX_NPEI_WINDOW_CTL \
-	 (0x0000000000000380ull)
-#define CVMX_NPEI_WIN_RD_ADDR \
-	 (0x0000000000000210ull)
-#define CVMX_NPEI_WIN_RD_DATA \
-	 (0x0000000000000240ull)
-#define CVMX_NPEI_WIN_WR_ADDR \
-	 (0x0000000000000200ull)
-#define CVMX_NPEI_WIN_WR_DATA \
-	 (0x0000000000000220ull)
-#define CVMX_NPEI_WIN_WR_MASK \
-	 (0x0000000000000230ull)
+#define CVMX_NPEI_BAR1_INDEXX(offset) (0x0000000000000000ull + ((offset) & 31) * 16)
+#define CVMX_NPEI_BIST_STATUS (0x0000000000000580ull)
+#define CVMX_NPEI_BIST_STATUS2 (0x0000000000000680ull)
+#define CVMX_NPEI_CTL_PORT0 (0x0000000000000250ull)
+#define CVMX_NPEI_CTL_PORT1 (0x0000000000000260ull)
+#define CVMX_NPEI_CTL_STATUS (0x0000000000000570ull)
+#define CVMX_NPEI_CTL_STATUS2 (0x0000000000003C00ull)
+#define CVMX_NPEI_DATA_OUT_CNT (0x00000000000005F0ull)
+#define CVMX_NPEI_DBG_DATA (0x0000000000000510ull)
+#define CVMX_NPEI_DBG_SELECT (0x0000000000000500ull)
+#define CVMX_NPEI_DMA0_INT_LEVEL (0x00000000000005C0ull)
+#define CVMX_NPEI_DMA1_INT_LEVEL (0x00000000000005D0ull)
+#define CVMX_NPEI_DMAX_COUNTS(offset) (0x0000000000000450ull + ((offset) & 7) * 16)
+#define CVMX_NPEI_DMAX_DBELL(offset) (0x00000000000003B0ull + ((offset) & 7) * 16)
+#define CVMX_NPEI_DMAX_IBUFF_SADDR(offset) (0x0000000000000400ull + ((offset) & 7) * 16)
+#define CVMX_NPEI_DMAX_NADDR(offset) (0x00000000000004A0ull + ((offset) & 7) * 16)
+#define CVMX_NPEI_DMA_CNTS (0x00000000000005E0ull)
+#define CVMX_NPEI_DMA_CONTROL (0x00000000000003A0ull)
+#define CVMX_NPEI_DMA_PCIE_REQ_NUM (0x00000000000005B0ull)
+#define CVMX_NPEI_DMA_STATE1 (0x00000000000006C0ull)
+#define CVMX_NPEI_DMA_STATE1_P1 (0x0000000000000680ull)
+#define CVMX_NPEI_DMA_STATE2 (0x00000000000006D0ull)
+#define CVMX_NPEI_DMA_STATE2_P1 (0x0000000000000690ull)
+#define CVMX_NPEI_DMA_STATE3_P1 (0x00000000000006A0ull)
+#define CVMX_NPEI_DMA_STATE4_P1 (0x00000000000006B0ull)
+#define CVMX_NPEI_DMA_STATE5_P1 (0x00000000000006C0ull)
+#define CVMX_NPEI_INT_A_ENB (0x0000000000000560ull)
+#define CVMX_NPEI_INT_A_ENB2 (0x0000000000003CE0ull)
+#define CVMX_NPEI_INT_A_SUM (0x0000000000000550ull)
+#define CVMX_NPEI_INT_ENB (0x0000000000000540ull)
+#define CVMX_NPEI_INT_ENB2 (0x0000000000003CD0ull)
+#define CVMX_NPEI_INT_INFO (0x0000000000000590ull)
+#define CVMX_NPEI_INT_SUM (0x0000000000000530ull)
+#define CVMX_NPEI_INT_SUM2 (0x0000000000003CC0ull)
+#define CVMX_NPEI_LAST_WIN_RDATA0 (0x0000000000000600ull)
+#define CVMX_NPEI_LAST_WIN_RDATA1 (0x0000000000000610ull)
+#define CVMX_NPEI_MEM_ACCESS_CTL (0x00000000000004F0ull)
+#define CVMX_NPEI_MEM_ACCESS_SUBIDX(offset) (0x0000000000000340ull + ((offset) & 31) * 16 - 16*12)
+#define CVMX_NPEI_MSI_ENB0 (0x0000000000003C50ull)
+#define CVMX_NPEI_MSI_ENB1 (0x0000000000003C60ull)
+#define CVMX_NPEI_MSI_ENB2 (0x0000000000003C70ull)
+#define CVMX_NPEI_MSI_ENB3 (0x0000000000003C80ull)
+#define CVMX_NPEI_MSI_RCV0 (0x0000000000003C10ull)
+#define CVMX_NPEI_MSI_RCV1 (0x0000000000003C20ull)
+#define CVMX_NPEI_MSI_RCV2 (0x0000000000003C30ull)
+#define CVMX_NPEI_MSI_RCV3 (0x0000000000003C40ull)
+#define CVMX_NPEI_MSI_RD_MAP (0x0000000000003CA0ull)
+#define CVMX_NPEI_MSI_W1C_ENB0 (0x0000000000003CF0ull)
+#define CVMX_NPEI_MSI_W1C_ENB1 (0x0000000000003D00ull)
+#define CVMX_NPEI_MSI_W1C_ENB2 (0x0000000000003D10ull)
+#define CVMX_NPEI_MSI_W1C_ENB3 (0x0000000000003D20ull)
+#define CVMX_NPEI_MSI_W1S_ENB0 (0x0000000000003D30ull)
+#define CVMX_NPEI_MSI_W1S_ENB1 (0x0000000000003D40ull)
+#define CVMX_NPEI_MSI_W1S_ENB2 (0x0000000000003D50ull)
+#define CVMX_NPEI_MSI_W1S_ENB3 (0x0000000000003D60ull)
+#define CVMX_NPEI_MSI_WR_MAP (0x0000000000003C90ull)
+#define CVMX_NPEI_PCIE_CREDIT_CNT (0x0000000000003D70ull)
+#define CVMX_NPEI_PCIE_MSI_RCV (0x0000000000003CB0ull)
+#define CVMX_NPEI_PCIE_MSI_RCV_B1 (0x0000000000000650ull)
+#define CVMX_NPEI_PCIE_MSI_RCV_B2 (0x0000000000000660ull)
+#define CVMX_NPEI_PCIE_MSI_RCV_B3 (0x0000000000000670ull)
+#define CVMX_NPEI_PKTX_CNTS(offset) (0x0000000000002400ull + ((offset) & 31) * 16)
+#define CVMX_NPEI_PKTX_INSTR_BADDR(offset) (0x0000000000002800ull + ((offset) & 31) * 16)
+#define CVMX_NPEI_PKTX_INSTR_BAOFF_DBELL(offset) (0x0000000000002C00ull + ((offset) & 31) * 16)
+#define CVMX_NPEI_PKTX_INSTR_FIFO_RSIZE(offset) (0x0000000000003000ull + ((offset) & 31) * 16)
+#define CVMX_NPEI_PKTX_INSTR_HEADER(offset) (0x0000000000003400ull + ((offset) & 31) * 16)
+#define CVMX_NPEI_PKTX_IN_BP(offset) (0x0000000000003800ull + ((offset) & 31) * 16)
+#define CVMX_NPEI_PKTX_SLIST_BADDR(offset) (0x0000000000001400ull + ((offset) & 31) * 16)
+#define CVMX_NPEI_PKTX_SLIST_BAOFF_DBELL(offset) (0x0000000000001800ull + ((offset) & 31) * 16)
+#define CVMX_NPEI_PKTX_SLIST_FIFO_RSIZE(offset) (0x0000000000001C00ull + ((offset) & 31) * 16)
+#define CVMX_NPEI_PKT_CNT_INT (0x0000000000001110ull)
+#define CVMX_NPEI_PKT_CNT_INT_ENB (0x0000000000001130ull)
+#define CVMX_NPEI_PKT_DATA_OUT_ES (0x00000000000010B0ull)
+#define CVMX_NPEI_PKT_DATA_OUT_NS (0x00000000000010A0ull)
+#define CVMX_NPEI_PKT_DATA_OUT_ROR (0x0000000000001090ull)
+#define CVMX_NPEI_PKT_DPADDR (0x0000000000001080ull)
+#define CVMX_NPEI_PKT_INPUT_CONTROL (0x0000000000001150ull)
+#define CVMX_NPEI_PKT_INSTR_ENB (0x0000000000001000ull)
+#define CVMX_NPEI_PKT_INSTR_RD_SIZE (0x0000000000001190ull)
+#define CVMX_NPEI_PKT_INSTR_SIZE (0x0000000000001020ull)
+#define CVMX_NPEI_PKT_INT_LEVELS (0x0000000000001100ull)
+#define CVMX_NPEI_PKT_IN_BP (0x00000000000006B0ull)
+#define CVMX_NPEI_PKT_IN_DONEX_CNTS(offset) (0x0000000000002000ull + ((offset) & 31) * 16)
+#define CVMX_NPEI_PKT_IN_INSTR_COUNTS (0x00000000000006A0ull)
+#define CVMX_NPEI_PKT_IN_PCIE_PORT (0x00000000000011A0ull)
+#define CVMX_NPEI_PKT_IPTR (0x0000000000001070ull)
+#define CVMX_NPEI_PKT_OUTPUT_WMARK (0x0000000000001160ull)
+#define CVMX_NPEI_PKT_OUT_BMODE (0x00000000000010D0ull)
+#define CVMX_NPEI_PKT_OUT_ENB (0x0000000000001010ull)
+#define CVMX_NPEI_PKT_PCIE_PORT (0x00000000000010E0ull)
+#define CVMX_NPEI_PKT_PORT_IN_RST (0x0000000000000690ull)
+#define CVMX_NPEI_PKT_SLIST_ES (0x0000000000001050ull)
+#define CVMX_NPEI_PKT_SLIST_ID_SIZE (0x0000000000001180ull)
+#define CVMX_NPEI_PKT_SLIST_NS (0x0000000000001040ull)
+#define CVMX_NPEI_PKT_SLIST_ROR (0x0000000000001030ull)
+#define CVMX_NPEI_PKT_TIME_INT (0x0000000000001120ull)
+#define CVMX_NPEI_PKT_TIME_INT_ENB (0x0000000000001140ull)
+#define CVMX_NPEI_RSL_INT_BLOCKS (0x0000000000000520ull)
+#define CVMX_NPEI_SCRATCH_1 (0x0000000000000270ull)
+#define CVMX_NPEI_STATE1 (0x0000000000000620ull)
+#define CVMX_NPEI_STATE2 (0x0000000000000630ull)
+#define CVMX_NPEI_STATE3 (0x0000000000000640ull)
+#define CVMX_NPEI_WINDOW_CTL (0x0000000000000380ull)
+#define CVMX_NPEI_WIN_RD_ADDR (0x0000000000000210ull)
+#define CVMX_NPEI_WIN_RD_DATA (0x0000000000000240ull)
+#define CVMX_NPEI_WIN_WR_ADDR (0x0000000000000200ull)
+#define CVMX_NPEI_WIN_WR_DATA (0x0000000000000220ull)
+#define CVMX_NPEI_WIN_WR_MASK (0x0000000000000230ull)
 
 union cvmx_npei_bar1_indexx {
 	uint32_t u32;
@@ -248,9 +156,7 @@ union cvmx_npei_bist_status {
 	uint64_t u64;
 	struct cvmx_npei_bist_status_s {
 		uint64_t pkt_rdf:1;
-		uint64_t pkt_pmem:1;
-		uint64_t pkt_p1:1;
-		uint64_t reserved_60_60:1;
+		uint64_t reserved_60_62:3;
 		uint64_t pcr_gim:1;
 		uint64_t pkt_pif:1;
 		uint64_t pcsr_int:1;
@@ -301,9 +207,7 @@ union cvmx_npei_bist_status {
 	} s;
 	struct cvmx_npei_bist_status_cn52xx {
 		uint64_t pkt_rdf:1;
-		uint64_t pkt_pmem:1;
-		uint64_t pkt_p1:1;
-		uint64_t reserved_60_60:1;
+		uint64_t reserved_60_62:3;
 		uint64_t pcr_gim:1;
 		uint64_t pkt_pif:1;
 		uint64_t pcsr_int:1;
@@ -410,66 +314,7 @@ union cvmx_npei_bist_status {
 		uint64_t msi:1;
 		uint64_t ncb_cmd:1;
 	} cn52xxp1;
-	struct cvmx_npei_bist_status_cn56xx {
-		uint64_t pkt_rdf:1;
-		uint64_t reserved_60_62:3;
-		uint64_t pcr_gim:1;
-		uint64_t pkt_pif:1;
-		uint64_t pcsr_int:1;
-		uint64_t pcsr_im:1;
-		uint64_t pcsr_cnt:1;
-		uint64_t pcsr_id:1;
-		uint64_t pcsr_sl:1;
-		uint64_t pkt_imem:1;
-		uint64_t pkt_pfm:1;
-		uint64_t pkt_pof:1;
-		uint64_t reserved_48_49:2;
-		uint64_t pkt_pop0:1;
-		uint64_t pkt_pop1:1;
-		uint64_t d0_mem:1;
-		uint64_t d1_mem:1;
-		uint64_t d2_mem:1;
-		uint64_t d3_mem:1;
-		uint64_t d4_mem:1;
-		uint64_t ds_mem:1;
-		uint64_t reserved_36_39:4;
-		uint64_t d0_pst:1;
-		uint64_t d1_pst:1;
-		uint64_t d2_pst:1;
-		uint64_t d3_pst:1;
-		uint64_t d4_pst:1;
-		uint64_t n2p0_c:1;
-		uint64_t n2p0_o:1;
-		uint64_t n2p1_c:1;
-		uint64_t n2p1_o:1;
-		uint64_t cpl_p0:1;
-		uint64_t cpl_p1:1;
-		uint64_t p2n1_po:1;
-		uint64_t p2n1_no:1;
-		uint64_t p2n1_co:1;
-		uint64_t p2n0_po:1;
-		uint64_t p2n0_no:1;
-		uint64_t p2n0_co:1;
-		uint64_t p2n0_c0:1;
-		uint64_t p2n0_c1:1;
-		uint64_t p2n0_n:1;
-		uint64_t p2n0_p0:1;
-		uint64_t p2n0_p1:1;
-		uint64_t p2n1_c0:1;
-		uint64_t p2n1_c1:1;
-		uint64_t p2n1_n:1;
-		uint64_t p2n1_p0:1;
-		uint64_t p2n1_p1:1;
-		uint64_t csm0:1;
-		uint64_t csm1:1;
-		uint64_t dif0:1;
-		uint64_t dif1:1;
-		uint64_t dif2:1;
-		uint64_t dif3:1;
-		uint64_t dif4:1;
-		uint64_t msi:1;
-		uint64_t ncb_cmd:1;
-	} cn56xx;
+	struct cvmx_npei_bist_status_cn52xx cn56xx;
 	struct cvmx_npei_bist_status_cn56xxp1 {
 		uint64_t reserved_58_63:6;
 		uint64_t pcsr_int:1;
@@ -536,7 +381,16 @@ union cvmx_npei_bist_status {
 union cvmx_npei_bist_status2 {
 	uint64_t u64;
 	struct cvmx_npei_bist_status2_s {
-		uint64_t reserved_5_63:59;
+		uint64_t reserved_14_63:50;
+		uint64_t prd_tag:1;
+		uint64_t prd_st0:1;
+		uint64_t prd_st1:1;
+		uint64_t prd_err:1;
+		uint64_t nrd_st:1;
+		uint64_t nwe_st:1;
+		uint64_t nwe_wr0:1;
+		uint64_t nwe_wr1:1;
+		uint64_t pkt_rd:1;
 		uint64_t psc_p0:1;
 		uint64_t psc_p1:1;
 		uint64_t pkt_gd:1;
@@ -630,8 +484,7 @@ union cvmx_npei_ctl_status {
 	} cn52xxp1;
 	struct cvmx_npei_ctl_status_s cn56xx;
 	struct cvmx_npei_ctl_status_cn56xxp1 {
-		uint64_t reserved_16_63:48;
-		uint64_t ring_en:1;
+		uint64_t reserved_15_63:49;
 		uint64_t lnk_rst:1;
 		uint64_t arb:1;
 		uint64_t pkt_bp:4;
@@ -756,14 +609,14 @@ union cvmx_npei_dmax_ibuff_saddr {
 		uint64_t saddr:29;
 		uint64_t reserved_0_6:7;
 	} s;
-	struct cvmx_npei_dmax_ibuff_saddr_cn52xx {
+	struct cvmx_npei_dmax_ibuff_saddr_s cn52xx;
+	struct cvmx_npei_dmax_ibuff_saddr_cn52xxp1 {
 		uint64_t reserved_36_63:28;
 		uint64_t saddr:29;
 		uint64_t reserved_0_6:7;
-	} cn52xx;
-	struct cvmx_npei_dmax_ibuff_saddr_cn52xx cn52xxp1;
+	} cn52xxp1;
 	struct cvmx_npei_dmax_ibuff_saddr_s cn56xx;
-	struct cvmx_npei_dmax_ibuff_saddr_cn52xx cn56xxp1;
+	struct cvmx_npei_dmax_ibuff_saddr_cn52xxp1 cn56xxp1;
 };
 
 union cvmx_npei_dmax_naddr {
@@ -817,7 +670,8 @@ union cvmx_npei_dma_cnts {
 union cvmx_npei_dma_control {
 	uint64_t u64;
 	struct cvmx_npei_dma_control_s {
-		uint64_t reserved_39_63:25;
+		uint64_t reserved_40_63:24;
+		uint64_t p_32b_m:1;
 		uint64_t dma4_enb:1;
 		uint64_t dma3_enb:1;
 		uint64_t dma2_enb:1;
@@ -853,7 +707,161 @@ union cvmx_npei_dma_control {
 		uint64_t csize:14;
 	} cn52xxp1;
 	struct cvmx_npei_dma_control_s cn56xx;
-	struct cvmx_npei_dma_control_s cn56xxp1;
+	struct cvmx_npei_dma_control_cn56xxp1 {
+		uint64_t reserved_39_63:25;
+		uint64_t dma4_enb:1;
+		uint64_t dma3_enb:1;
+		uint64_t dma2_enb:1;
+		uint64_t dma1_enb:1;
+		uint64_t dma0_enb:1;
+		uint64_t b0_lend:1;
+		uint64_t dwb_denb:1;
+		uint64_t dwb_ichk:9;
+		uint64_t fpa_que:3;
+		uint64_t o_add1:1;
+		uint64_t o_ro:1;
+		uint64_t o_ns:1;
+		uint64_t o_es:2;
+		uint64_t o_mode:1;
+		uint64_t csize:14;
+	} cn56xxp1;
+};
+
+union cvmx_npei_dma_pcie_req_num {
+	uint64_t u64;
+	struct cvmx_npei_dma_pcie_req_num_s {
+		uint64_t dma_arb:1;
+		uint64_t reserved_53_62:10;
+		uint64_t pkt_cnt:5;
+		uint64_t reserved_45_47:3;
+		uint64_t dma4_cnt:5;
+		uint64_t reserved_37_39:3;
+		uint64_t dma3_cnt:5;
+		uint64_t reserved_29_31:3;
+		uint64_t dma2_cnt:5;
+		uint64_t reserved_21_23:3;
+		uint64_t dma1_cnt:5;
+		uint64_t reserved_13_15:3;
+		uint64_t dma0_cnt:5;
+		uint64_t reserved_5_7:3;
+		uint64_t dma_cnt:5;
+	} s;
+	struct cvmx_npei_dma_pcie_req_num_s cn52xx;
+	struct cvmx_npei_dma_pcie_req_num_s cn56xx;
+};
+
+union cvmx_npei_dma_state1 {
+	uint64_t u64;
+	struct cvmx_npei_dma_state1_s {
+		uint64_t reserved_40_63:24;
+		uint64_t d4_dwe:8;
+		uint64_t d3_dwe:8;
+		uint64_t d2_dwe:8;
+		uint64_t d1_dwe:8;
+		uint64_t d0_dwe:8;
+	} s;
+	struct cvmx_npei_dma_state1_s cn52xx;
+};
+
+union cvmx_npei_dma_state1_p1 {
+	uint64_t u64;
+	struct cvmx_npei_dma_state1_p1_s {
+		uint64_t reserved_60_63:4;
+		uint64_t d0_difst:7;
+		uint64_t d1_difst:7;
+		uint64_t d2_difst:7;
+		uint64_t d3_difst:7;
+		uint64_t d4_difst:7;
+		uint64_t d0_reqst:5;
+		uint64_t d1_reqst:5;
+		uint64_t d2_reqst:5;
+		uint64_t d3_reqst:5;
+		uint64_t d4_reqst:5;
+	} s;
+	struct cvmx_npei_dma_state1_p1_cn52xxp1 {
+		uint64_t reserved_60_63:4;
+		uint64_t d0_difst:7;
+		uint64_t d1_difst:7;
+		uint64_t d2_difst:7;
+		uint64_t d3_difst:7;
+		uint64_t reserved_25_31:7;
+		uint64_t d0_reqst:5;
+		uint64_t d1_reqst:5;
+		uint64_t d2_reqst:5;
+		uint64_t d3_reqst:5;
+		uint64_t reserved_0_4:5;
+	} cn52xxp1;
+	struct cvmx_npei_dma_state1_p1_s cn56xxp1;
+};
+
+union cvmx_npei_dma_state2 {
+	uint64_t u64;
+	struct cvmx_npei_dma_state2_s {
+		uint64_t reserved_28_63:36;
+		uint64_t ndwe:4;
+		uint64_t reserved_21_23:3;
+		uint64_t ndre:5;
+		uint64_t reserved_10_15:6;
+		uint64_t prd:10;
+	} s;
+	struct cvmx_npei_dma_state2_s cn52xx;
+};
+
+union cvmx_npei_dma_state2_p1 {
+	uint64_t u64;
+	struct cvmx_npei_dma_state2_p1_s {
+		uint64_t reserved_45_63:19;
+		uint64_t d0_dffst:9;
+		uint64_t d1_dffst:9;
+		uint64_t d2_dffst:9;
+		uint64_t d3_dffst:9;
+		uint64_t d4_dffst:9;
+	} s;
+	struct cvmx_npei_dma_state2_p1_cn52xxp1 {
+		uint64_t reserved_45_63:19;
+		uint64_t d0_dffst:9;
+		uint64_t d1_dffst:9;
+		uint64_t d2_dffst:9;
+		uint64_t d3_dffst:9;
+		uint64_t reserved_0_8:9;
+	} cn52xxp1;
+	struct cvmx_npei_dma_state2_p1_s cn56xxp1;
+};
+
+union cvmx_npei_dma_state3_p1 {
+	uint64_t u64;
+	struct cvmx_npei_dma_state3_p1_s {
+		uint64_t reserved_60_63:4;
+		uint64_t d0_drest:15;
+		uint64_t d1_drest:15;
+		uint64_t d2_drest:15;
+		uint64_t d3_drest:15;
+	} s;
+	struct cvmx_npei_dma_state3_p1_s cn52xxp1;
+	struct cvmx_npei_dma_state3_p1_s cn56xxp1;
+};
+
+union cvmx_npei_dma_state4_p1 {
+	uint64_t u64;
+	struct cvmx_npei_dma_state4_p1_s {
+		uint64_t reserved_52_63:12;
+		uint64_t d0_dwest:13;
+		uint64_t d1_dwest:13;
+		uint64_t d2_dwest:13;
+		uint64_t d3_dwest:13;
+	} s;
+	struct cvmx_npei_dma_state4_p1_s cn52xxp1;
+	struct cvmx_npei_dma_state4_p1_s cn56xxp1;
+};
+
+union cvmx_npei_dma_state5_p1 {
+	uint64_t u64;
+	struct cvmx_npei_dma_state5_p1_s {
+		uint64_t reserved_28_63:36;
+		uint64_t d4_drest:15;
+		uint64_t d4_dwest:13;
+	} s;
+	struct cvmx_npei_dma_state5_p1_s cn56xxp1;
 };
 
 union cvmx_npei_int_a_enb {
@@ -871,17 +879,7 @@ union cvmx_npei_int_a_enb {
 		uint64_t dma1_cpl:1;
 		uint64_t dma0_cpl:1;
 	} s;
-	struct cvmx_npei_int_a_enb_cn52xx {
-		uint64_t reserved_8_63:56;
-		uint64_t p1_rdlk:1;
-		uint64_t p0_rdlk:1;
-		uint64_t pgl_err:1;
-		uint64_t pdi_err:1;
-		uint64_t pop_err:1;
-		uint64_t pins_err:1;
-		uint64_t dma1_cpl:1;
-		uint64_t dma0_cpl:1;
-	} cn52xx;
+	struct cvmx_npei_int_a_enb_s cn52xx;
 	struct cvmx_npei_int_a_enb_cn52xxp1 {
 		uint64_t reserved_2_63:62;
 		uint64_t dma1_cpl:1;
@@ -905,16 +903,7 @@ union cvmx_npei_int_a_enb2 {
 		uint64_t dma1_cpl:1;
 		uint64_t dma0_cpl:1;
 	} s;
-	struct cvmx_npei_int_a_enb2_cn52xx {
-		uint64_t reserved_8_63:56;
-		uint64_t p1_rdlk:1;
-		uint64_t p0_rdlk:1;
-		uint64_t pgl_err:1;
-		uint64_t pdi_err:1;
-		uint64_t pop_err:1;
-		uint64_t pins_err:1;
-		uint64_t reserved_0_1:2;
-	} cn52xx;
+	struct cvmx_npei_int_a_enb2_s cn52xx;
 	struct cvmx_npei_int_a_enb2_cn52xxp1 {
 		uint64_t reserved_2_63:62;
 		uint64_t dma1_cpl:1;
@@ -938,17 +927,7 @@ union cvmx_npei_int_a_sum {
 		uint64_t dma1_cpl:1;
 		uint64_t dma0_cpl:1;
 	} s;
-	struct cvmx_npei_int_a_sum_cn52xx {
-		uint64_t reserved_8_63:56;
-		uint64_t p1_rdlk:1;
-		uint64_t p0_rdlk:1;
-		uint64_t pgl_err:1;
-		uint64_t pdi_err:1;
-		uint64_t pop_err:1;
-		uint64_t pins_err:1;
-		uint64_t dma1_cpl:1;
-		uint64_t dma0_cpl:1;
-	} cn52xx;
+	struct cvmx_npei_int_a_sum_s cn52xx;
 	struct cvmx_npei_int_a_sum_cn52xxp1 {
 		uint64_t reserved_2_63:62;
 		uint64_t dma1_cpl:1;
@@ -1550,10 +1529,7 @@ union cvmx_npei_int_sum {
 		uint64_t c0_se:1;
 		uint64_t reserved_20_20:1;
 		uint64_t c0_aeri:1;
-		uint64_t ptime:1;
-		uint64_t pcnt:1;
-		uint64_t pidbof:1;
-		uint64_t psldbof:1;
+		uint64_t reserved_15_18:4;
 		uint64_t dtime1:1;
 		uint64_t dtime0:1;
 		uint64_t dcnt1:1;
@@ -1959,7 +1935,6 @@ union cvmx_npei_pktx_cnts {
 	} s;
 	struct cvmx_npei_pktx_cnts_s cn52xx;
 	struct cvmx_npei_pktx_cnts_s cn56xx;
-	struct cvmx_npei_pktx_cnts_s cn56xxp1;
 };
 
 union cvmx_npei_pktx_in_bp {
@@ -1970,7 +1945,6 @@ union cvmx_npei_pktx_in_bp {
 	} s;
 	struct cvmx_npei_pktx_in_bp_s cn52xx;
 	struct cvmx_npei_pktx_in_bp_s cn56xx;
-	struct cvmx_npei_pktx_in_bp_s cn56xxp1;
 };
 
 union cvmx_npei_pktx_instr_baddr {
@@ -1981,7 +1955,6 @@ union cvmx_npei_pktx_instr_baddr {
 	} s;
 	struct cvmx_npei_pktx_instr_baddr_s cn52xx;
 	struct cvmx_npei_pktx_instr_baddr_s cn56xx;
-	struct cvmx_npei_pktx_instr_baddr_s cn56xxp1;
 };
 
 union cvmx_npei_pktx_instr_baoff_dbell {
@@ -1992,7 +1965,6 @@ union cvmx_npei_pktx_instr_baoff_dbell {
 	} s;
 	struct cvmx_npei_pktx_instr_baoff_dbell_s cn52xx;
 	struct cvmx_npei_pktx_instr_baoff_dbell_s cn56xx;
-	struct cvmx_npei_pktx_instr_baoff_dbell_s cn56xxp1;
 };
 
 union cvmx_npei_pktx_instr_fifo_rsize {
@@ -2006,7 +1978,6 @@ union cvmx_npei_pktx_instr_fifo_rsize {
 	} s;
 	struct cvmx_npei_pktx_instr_fifo_rsize_s cn52xx;
 	struct cvmx_npei_pktx_instr_fifo_rsize_s cn56xx;
-	struct cvmx_npei_pktx_instr_fifo_rsize_s cn56xxp1;
 };
 
 union cvmx_npei_pktx_instr_header {
@@ -2014,21 +1985,20 @@ union cvmx_npei_pktx_instr_header {
 	struct cvmx_npei_pktx_instr_header_s {
 		uint64_t reserved_44_63:20;
 		uint64_t pbp:1;
-		uint64_t rsv_f:5;
+		uint64_t reserved_38_42:5;
 		uint64_t rparmode:2;
-		uint64_t rsv_e:1;
+		uint64_t reserved_35_35:1;
 		uint64_t rskp_len:7;
-		uint64_t rsv_d:6;
+		uint64_t reserved_22_27:6;
 		uint64_t use_ihdr:1;
-		uint64_t rsv_c:5;
+		uint64_t reserved_16_20:5;
 		uint64_t par_mode:2;
-		uint64_t rsv_b:1;
+		uint64_t reserved_13_13:1;
 		uint64_t skp_len:7;
-		uint64_t rsv_a:6;
+		uint64_t reserved_0_5:6;
 	} s;
 	struct cvmx_npei_pktx_instr_header_s cn52xx;
 	struct cvmx_npei_pktx_instr_header_s cn56xx;
-	struct cvmx_npei_pktx_instr_header_s cn56xxp1;
 };
 
 union cvmx_npei_pktx_slist_baddr {
@@ -2039,7 +2009,6 @@ union cvmx_npei_pktx_slist_baddr {
 	} s;
 	struct cvmx_npei_pktx_slist_baddr_s cn52xx;
 	struct cvmx_npei_pktx_slist_baddr_s cn56xx;
-	struct cvmx_npei_pktx_slist_baddr_s cn56xxp1;
 };
 
 union cvmx_npei_pktx_slist_baoff_dbell {
@@ -2050,7 +2019,6 @@ union cvmx_npei_pktx_slist_baoff_dbell {
 	} s;
 	struct cvmx_npei_pktx_slist_baoff_dbell_s cn52xx;
 	struct cvmx_npei_pktx_slist_baoff_dbell_s cn56xx;
-	struct cvmx_npei_pktx_slist_baoff_dbell_s cn56xxp1;
 };
 
 union cvmx_npei_pktx_slist_fifo_rsize {
@@ -2061,7 +2029,6 @@ union cvmx_npei_pktx_slist_fifo_rsize {
 	} s;
 	struct cvmx_npei_pktx_slist_fifo_rsize_s cn52xx;
 	struct cvmx_npei_pktx_slist_fifo_rsize_s cn56xx;
-	struct cvmx_npei_pktx_slist_fifo_rsize_s cn56xxp1;
 };
 
 union cvmx_npei_pkt_cnt_int {
@@ -2072,7 +2039,6 @@ union cvmx_npei_pkt_cnt_int {
 	} s;
 	struct cvmx_npei_pkt_cnt_int_s cn52xx;
 	struct cvmx_npei_pkt_cnt_int_s cn56xx;
-	struct cvmx_npei_pkt_cnt_int_s cn56xxp1;
 };
 
 union cvmx_npei_pkt_cnt_int_enb {
@@ -2083,7 +2049,6 @@ union cvmx_npei_pkt_cnt_int_enb {
 	} s;
 	struct cvmx_npei_pkt_cnt_int_enb_s cn52xx;
 	struct cvmx_npei_pkt_cnt_int_enb_s cn56xx;
-	struct cvmx_npei_pkt_cnt_int_enb_s cn56xxp1;
 };
 
 union cvmx_npei_pkt_data_out_es {
@@ -2093,7 +2058,6 @@ union cvmx_npei_pkt_data_out_es {
 	} s;
 	struct cvmx_npei_pkt_data_out_es_s cn52xx;
 	struct cvmx_npei_pkt_data_out_es_s cn56xx;
-	struct cvmx_npei_pkt_data_out_es_s cn56xxp1;
 };
 
 union cvmx_npei_pkt_data_out_ns {
@@ -2104,7 +2068,6 @@ union cvmx_npei_pkt_data_out_ns {
 	} s;
 	struct cvmx_npei_pkt_data_out_ns_s cn52xx;
 	struct cvmx_npei_pkt_data_out_ns_s cn56xx;
-	struct cvmx_npei_pkt_data_out_ns_s cn56xxp1;
 };
 
 union cvmx_npei_pkt_data_out_ror {
@@ -2115,7 +2078,6 @@ union cvmx_npei_pkt_data_out_ror {
 	} s;
 	struct cvmx_npei_pkt_data_out_ror_s cn52xx;
 	struct cvmx_npei_pkt_data_out_ror_s cn56xx;
-	struct cvmx_npei_pkt_data_out_ror_s cn56xxp1;
 };
 
 union cvmx_npei_pkt_dpaddr {
@@ -2126,7 +2088,6 @@ union cvmx_npei_pkt_dpaddr {
 	} s;
 	struct cvmx_npei_pkt_dpaddr_s cn52xx;
 	struct cvmx_npei_pkt_dpaddr_s cn56xx;
-	struct cvmx_npei_pkt_dpaddr_s cn56xxp1;
 };
 
 union cvmx_npei_pkt_in_bp {
@@ -2135,6 +2096,7 @@ union cvmx_npei_pkt_in_bp {
 		uint64_t reserved_32_63:32;
 		uint64_t bp:32;
 	} s;
+	struct cvmx_npei_pkt_in_bp_s cn52xx;
 	struct cvmx_npei_pkt_in_bp_s cn56xx;
 };
 
@@ -2146,7 +2108,6 @@ union cvmx_npei_pkt_in_donex_cnts {
 	} s;
 	struct cvmx_npei_pkt_in_donex_cnts_s cn52xx;
 	struct cvmx_npei_pkt_in_donex_cnts_s cn56xx;
-	struct cvmx_npei_pkt_in_donex_cnts_s cn56xxp1;
 };
 
 union cvmx_npei_pkt_in_instr_counts {
@@ -2184,7 +2145,6 @@ union cvmx_npei_pkt_input_control {
 	} s;
 	struct cvmx_npei_pkt_input_control_s cn52xx;
 	struct cvmx_npei_pkt_input_control_s cn56xx;
-	struct cvmx_npei_pkt_input_control_s cn56xxp1;
 };
 
 union cvmx_npei_pkt_instr_enb {
@@ -2195,7 +2155,6 @@ union cvmx_npei_pkt_instr_enb {
 	} s;
 	struct cvmx_npei_pkt_instr_enb_s cn52xx;
 	struct cvmx_npei_pkt_instr_enb_s cn56xx;
-	struct cvmx_npei_pkt_instr_enb_s cn56xxp1;
 };
 
 union cvmx_npei_pkt_instr_rd_size {
@@ -2215,7 +2174,6 @@ union cvmx_npei_pkt_instr_size {
 	} s;
 	struct cvmx_npei_pkt_instr_size_s cn52xx;
 	struct cvmx_npei_pkt_instr_size_s cn56xx;
-	struct cvmx_npei_pkt_instr_size_s cn56xxp1;
 };
 
 union cvmx_npei_pkt_int_levels {
@@ -2227,7 +2185,6 @@ union cvmx_npei_pkt_int_levels {
 	} s;
 	struct cvmx_npei_pkt_int_levels_s cn52xx;
 	struct cvmx_npei_pkt_int_levels_s cn56xx;
-	struct cvmx_npei_pkt_int_levels_s cn56xxp1;
 };
 
 union cvmx_npei_pkt_iptr {
@@ -2238,7 +2195,6 @@ union cvmx_npei_pkt_iptr {
 	} s;
 	struct cvmx_npei_pkt_iptr_s cn52xx;
 	struct cvmx_npei_pkt_iptr_s cn56xx;
-	struct cvmx_npei_pkt_iptr_s cn56xxp1;
 };
 
 union cvmx_npei_pkt_out_bmode {
@@ -2249,7 +2205,6 @@ union cvmx_npei_pkt_out_bmode {
 	} s;
 	struct cvmx_npei_pkt_out_bmode_s cn52xx;
 	struct cvmx_npei_pkt_out_bmode_s cn56xx;
-	struct cvmx_npei_pkt_out_bmode_s cn56xxp1;
 };
 
 union cvmx_npei_pkt_out_enb {
@@ -2260,7 +2215,6 @@ union cvmx_npei_pkt_out_enb {
 	} s;
 	struct cvmx_npei_pkt_out_enb_s cn52xx;
 	struct cvmx_npei_pkt_out_enb_s cn56xx;
-	struct cvmx_npei_pkt_out_enb_s cn56xxp1;
 };
 
 union cvmx_npei_pkt_output_wmark {
@@ -2280,7 +2234,6 @@ union cvmx_npei_pkt_pcie_port {
 	} s;
 	struct cvmx_npei_pkt_pcie_port_s cn52xx;
 	struct cvmx_npei_pkt_pcie_port_s cn56xx;
-	struct cvmx_npei_pkt_pcie_port_s cn56xxp1;
 };
 
 union cvmx_npei_pkt_port_in_rst {
@@ -2300,7 +2253,6 @@ union cvmx_npei_pkt_slist_es {
 	} s;
 	struct cvmx_npei_pkt_slist_es_s cn52xx;
 	struct cvmx_npei_pkt_slist_es_s cn56xx;
-	struct cvmx_npei_pkt_slist_es_s cn56xxp1;
 };
 
 union cvmx_npei_pkt_slist_id_size {
@@ -2312,7 +2264,6 @@ union cvmx_npei_pkt_slist_id_size {
 	} s;
 	struct cvmx_npei_pkt_slist_id_size_s cn52xx;
 	struct cvmx_npei_pkt_slist_id_size_s cn56xx;
-	struct cvmx_npei_pkt_slist_id_size_s cn56xxp1;
 };
 
 union cvmx_npei_pkt_slist_ns {
@@ -2323,7 +2274,6 @@ union cvmx_npei_pkt_slist_ns {
 	} s;
 	struct cvmx_npei_pkt_slist_ns_s cn52xx;
 	struct cvmx_npei_pkt_slist_ns_s cn56xx;
-	struct cvmx_npei_pkt_slist_ns_s cn56xxp1;
 };
 
 union cvmx_npei_pkt_slist_ror {
@@ -2334,7 +2284,6 @@ union cvmx_npei_pkt_slist_ror {
 	} s;
 	struct cvmx_npei_pkt_slist_ror_s cn52xx;
 	struct cvmx_npei_pkt_slist_ror_s cn56xx;
-	struct cvmx_npei_pkt_slist_ror_s cn56xxp1;
 };
 
 union cvmx_npei_pkt_time_int {
@@ -2345,7 +2294,6 @@ union cvmx_npei_pkt_time_int {
 	} s;
 	struct cvmx_npei_pkt_time_int_s cn52xx;
 	struct cvmx_npei_pkt_time_int_s cn56xx;
-	struct cvmx_npei_pkt_time_int_s cn56xxp1;
 };
 
 union cvmx_npei_pkt_time_int_enb {
@@ -2356,7 +2304,6 @@ union cvmx_npei_pkt_time_int_enb {
 	} s;
 	struct cvmx_npei_pkt_time_int_enb_s cn52xx;
 	struct cvmx_npei_pkt_time_int_enb_s cn56xx;
-	struct cvmx_npei_pkt_time_int_enb_s cn56xxp1;
 };
 
 union cvmx_npei_rsl_int_blocks {
@@ -2371,7 +2318,8 @@ union cvmx_npei_rsl_int_blocks {
 		uint64_t asxpcs0:1;
 		uint64_t reserved_21_21:1;
 		uint64_t pip:1;
-		uint64_t reserved_18_19:2;
+		uint64_t spx1:1;
+		uint64_t spx0:1;
 		uint64_t lmc0:1;
 		uint64_t l2c:1;
 		uint64_t usb1:1;
@@ -2383,7 +2331,7 @@ union cvmx_npei_rsl_int_blocks {
 		uint64_t ipd:1;
 		uint64_t reserved_8_8:1;
 		uint64_t zip:1;
-		uint64_t reserved_6_6:1;
+		uint64_t dfa:1;
 		uint64_t fpa:1;
 		uint64_t key:1;
 		uint64_t npei:1;
@@ -2393,37 +2341,8 @@ union cvmx_npei_rsl_int_blocks {
 	} s;
 	struct cvmx_npei_rsl_int_blocks_s cn52xx;
 	struct cvmx_npei_rsl_int_blocks_s cn52xxp1;
-	struct cvmx_npei_rsl_int_blocks_cn56xx {
-		uint64_t reserved_31_63:33;
-		uint64_t iob:1;
-		uint64_t lmc1:1;
-		uint64_t agl:1;
-		uint64_t reserved_24_27:4;
-		uint64_t asxpcs1:1;
-		uint64_t asxpcs0:1;
-		uint64_t reserved_21_21:1;
-		uint64_t pip:1;
-		uint64_t reserved_18_19:2;
-		uint64_t lmc0:1;
-		uint64_t l2c:1;
-		uint64_t reserved_15_15:1;
-		uint64_t rad:1;
-		uint64_t usb:1;
-		uint64_t pow:1;
-		uint64_t tim:1;
-		uint64_t pko:1;
-		uint64_t ipd:1;
-		uint64_t reserved_8_8:1;
-		uint64_t zip:1;
-		uint64_t reserved_6_6:1;
-		uint64_t fpa:1;
-		uint64_t key:1;
-		uint64_t npei:1;
-		uint64_t gmx1:1;
-		uint64_t gmx0:1;
-		uint64_t mio:1;
-	} cn56xx;
-	struct cvmx_npei_rsl_int_blocks_cn56xx cn56xxp1;
+	struct cvmx_npei_rsl_int_blocks_s cn56xx;
+	struct cvmx_npei_rsl_int_blocks_s cn56xxp1;
 };
 
 union cvmx_npei_scratch_1 {
diff --git a/arch/mips/include/asm/octeon/cvmx-npi-defs.h b/arch/mips/include/asm/octeon/cvmx-npi-defs.h
index 4e03cd8..f089c78 100644
--- a/arch/mips/include/asm/octeon/cvmx-npi-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-npi-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2010 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -28,246 +28,126 @@
 #ifndef __CVMX_NPI_DEFS_H__
 #define __CVMX_NPI_DEFS_H__
 
-#define CVMX_NPI_BASE_ADDR_INPUT0 \
-	 CVMX_ADD_IO_SEG(0x00011F0000000070ull)
-#define CVMX_NPI_BASE_ADDR_INPUT1 \
-	 CVMX_ADD_IO_SEG(0x00011F0000000080ull)
-#define CVMX_NPI_BASE_ADDR_INPUT2 \
-	 CVMX_ADD_IO_SEG(0x00011F0000000090ull)
-#define CVMX_NPI_BASE_ADDR_INPUT3 \
-	 CVMX_ADD_IO_SEG(0x00011F00000000A0ull)
-#define CVMX_NPI_BASE_ADDR_INPUTX(offset) \
-	 CVMX_ADD_IO_SEG(0x00011F0000000070ull + (((offset) & 3) * 16))
-#define CVMX_NPI_BASE_ADDR_OUTPUT0 \
-	 CVMX_ADD_IO_SEG(0x00011F00000000B8ull)
-#define CVMX_NPI_BASE_ADDR_OUTPUT1 \
-	 CVMX_ADD_IO_SEG(0x00011F00000000C0ull)
-#define CVMX_NPI_BASE_ADDR_OUTPUT2 \
-	 CVMX_ADD_IO_SEG(0x00011F00000000C8ull)
-#define CVMX_NPI_BASE_ADDR_OUTPUT3 \
-	 CVMX_ADD_IO_SEG(0x00011F00000000D0ull)
-#define CVMX_NPI_BASE_ADDR_OUTPUTX(offset) \
-	 CVMX_ADD_IO_SEG(0x00011F00000000B8ull + (((offset) & 3) * 8))
-#define CVMX_NPI_BIST_STATUS \
-	 CVMX_ADD_IO_SEG(0x00011F00000003F8ull)
-#define CVMX_NPI_BUFF_SIZE_OUTPUT0 \
-	 CVMX_ADD_IO_SEG(0x00011F00000000E0ull)
-#define CVMX_NPI_BUFF_SIZE_OUTPUT1 \
-	 CVMX_ADD_IO_SEG(0x00011F00000000E8ull)
-#define CVMX_NPI_BUFF_SIZE_OUTPUT2 \
-	 CVMX_ADD_IO_SEG(0x00011F00000000F0ull)
-#define CVMX_NPI_BUFF_SIZE_OUTPUT3 \
-	 CVMX_ADD_IO_SEG(0x00011F00000000F8ull)
-#define CVMX_NPI_BUFF_SIZE_OUTPUTX(offset) \
-	 CVMX_ADD_IO_SEG(0x00011F00000000E0ull + (((offset) & 3) * 8))
-#define CVMX_NPI_COMP_CTL \
-	 CVMX_ADD_IO_SEG(0x00011F0000000218ull)
-#define CVMX_NPI_CTL_STATUS \
-	 CVMX_ADD_IO_SEG(0x00011F0000000010ull)
-#define CVMX_NPI_DBG_SELECT \
-	 CVMX_ADD_IO_SEG(0x00011F0000000008ull)
-#define CVMX_NPI_DMA_CONTROL \
-	 CVMX_ADD_IO_SEG(0x00011F0000000128ull)
-#define CVMX_NPI_DMA_HIGHP_COUNTS \
-	 CVMX_ADD_IO_SEG(0x00011F0000000148ull)
-#define CVMX_NPI_DMA_HIGHP_NADDR \
-	 CVMX_ADD_IO_SEG(0x00011F0000000158ull)
-#define CVMX_NPI_DMA_LOWP_COUNTS \
-	 CVMX_ADD_IO_SEG(0x00011F0000000140ull)
-#define CVMX_NPI_DMA_LOWP_NADDR \
-	 CVMX_ADD_IO_SEG(0x00011F0000000150ull)
-#define CVMX_NPI_HIGHP_DBELL \
-	 CVMX_ADD_IO_SEG(0x00011F0000000120ull)
-#define CVMX_NPI_HIGHP_IBUFF_SADDR \
-	 CVMX_ADD_IO_SEG(0x00011F0000000110ull)
-#define CVMX_NPI_INPUT_CONTROL \
-	 CVMX_ADD_IO_SEG(0x00011F0000000138ull)
-#define CVMX_NPI_INT_ENB \
-	 CVMX_ADD_IO_SEG(0x00011F0000000020ull)
-#define CVMX_NPI_INT_SUM \
-	 CVMX_ADD_IO_SEG(0x00011F0000000018ull)
-#define CVMX_NPI_LOWP_DBELL \
-	 CVMX_ADD_IO_SEG(0x00011F0000000118ull)
-#define CVMX_NPI_LOWP_IBUFF_SADDR \
-	 CVMX_ADD_IO_SEG(0x00011F0000000108ull)
-#define CVMX_NPI_MEM_ACCESS_SUBID3 \
-	 CVMX_ADD_IO_SEG(0x00011F0000000028ull)
-#define CVMX_NPI_MEM_ACCESS_SUBID4 \
-	 CVMX_ADD_IO_SEG(0x00011F0000000030ull)
-#define CVMX_NPI_MEM_ACCESS_SUBID5 \
-	 CVMX_ADD_IO_SEG(0x00011F0000000038ull)
-#define CVMX_NPI_MEM_ACCESS_SUBID6 \
-	 CVMX_ADD_IO_SEG(0x00011F0000000040ull)
-#define CVMX_NPI_MEM_ACCESS_SUBIDX(offset) \
-	 CVMX_ADD_IO_SEG(0x00011F0000000028ull + (((offset) & 7) * 8) - 8 * 3)
-#define CVMX_NPI_MSI_RCV \
-	 (0x0000000000000190ull)
-#define CVMX_NPI_NPI_MSI_RCV \
-	 CVMX_ADD_IO_SEG(0x00011F0000001190ull)
-#define CVMX_NPI_NUM_DESC_OUTPUT0 \
-	 CVMX_ADD_IO_SEG(0x00011F0000000050ull)
-#define CVMX_NPI_NUM_DESC_OUTPUT1 \
-	 CVMX_ADD_IO_SEG(0x00011F0000000058ull)
-#define CVMX_NPI_NUM_DESC_OUTPUT2 \
-	 CVMX_ADD_IO_SEG(0x00011F0000000060ull)
-#define CVMX_NPI_NUM_DESC_OUTPUT3 \
-	 CVMX_ADD_IO_SEG(0x00011F0000000068ull)
-#define CVMX_NPI_NUM_DESC_OUTPUTX(offset) \
-	 CVMX_ADD_IO_SEG(0x00011F0000000050ull + (((offset) & 3) * 8))
-#define CVMX_NPI_OUTPUT_CONTROL \
-	 CVMX_ADD_IO_SEG(0x00011F0000000100ull)
-#define CVMX_NPI_P0_DBPAIR_ADDR \
-	 CVMX_ADD_IO_SEG(0x00011F0000000180ull)
-#define CVMX_NPI_P0_INSTR_ADDR \
-	 CVMX_ADD_IO_SEG(0x00011F00000001C0ull)
-#define CVMX_NPI_P0_INSTR_CNTS \
-	 CVMX_ADD_IO_SEG(0x00011F00000001A0ull)
-#define CVMX_NPI_P0_PAIR_CNTS \
-	 CVMX_ADD_IO_SEG(0x00011F0000000160ull)
-#define CVMX_NPI_P1_DBPAIR_ADDR \
-	 CVMX_ADD_IO_SEG(0x00011F0000000188ull)
-#define CVMX_NPI_P1_INSTR_ADDR \
-	 CVMX_ADD_IO_SEG(0x00011F00000001C8ull)
-#define CVMX_NPI_P1_INSTR_CNTS \
-	 CVMX_ADD_IO_SEG(0x00011F00000001A8ull)
-#define CVMX_NPI_P1_PAIR_CNTS \
-	 CVMX_ADD_IO_SEG(0x00011F0000000168ull)
-#define CVMX_NPI_P2_DBPAIR_ADDR \
-	 CVMX_ADD_IO_SEG(0x00011F0000000190ull)
-#define CVMX_NPI_P2_INSTR_ADDR \
-	 CVMX_ADD_IO_SEG(0x00011F00000001D0ull)
-#define CVMX_NPI_P2_INSTR_CNTS \
-	 CVMX_ADD_IO_SEG(0x00011F00000001B0ull)
-#define CVMX_NPI_P2_PAIR_CNTS \
-	 CVMX_ADD_IO_SEG(0x00011F0000000170ull)
-#define CVMX_NPI_P3_DBPAIR_ADDR \
-	 CVMX_ADD_IO_SEG(0x00011F0000000198ull)
-#define CVMX_NPI_P3_INSTR_ADDR \
-	 CVMX_ADD_IO_SEG(0x00011F00000001D8ull)
-#define CVMX_NPI_P3_INSTR_CNTS \
-	 CVMX_ADD_IO_SEG(0x00011F00000001B8ull)
-#define CVMX_NPI_P3_PAIR_CNTS \
-	 CVMX_ADD_IO_SEG(0x00011F0000000178ull)
-#define CVMX_NPI_PCI_BAR1_INDEXX(offset) \
-	 CVMX_ADD_IO_SEG(0x00011F0000001100ull + (((offset) & 31) * 4))
-#define CVMX_NPI_PCI_BIST_REG \
-	 CVMX_ADD_IO_SEG(0x00011F00000011C0ull)
-#define CVMX_NPI_PCI_BURST_SIZE \
-	 CVMX_ADD_IO_SEG(0x00011F00000000D8ull)
-#define CVMX_NPI_PCI_CFG00 \
-	 CVMX_ADD_IO_SEG(0x00011F0000001800ull)
-#define CVMX_NPI_PCI_CFG01 \
-	 CVMX_ADD_IO_SEG(0x00011F0000001804ull)
-#define CVMX_NPI_PCI_CFG02 \
-	 CVMX_ADD_IO_SEG(0x00011F0000001808ull)
-#define CVMX_NPI_PCI_CFG03 \
-	 CVMX_ADD_IO_SEG(0x00011F000000180Cull)
-#define CVMX_NPI_PCI_CFG04 \
-	 CVMX_ADD_IO_SEG(0x00011F0000001810ull)
-#define CVMX_NPI_PCI_CFG05 \
-	 CVMX_ADD_IO_SEG(0x00011F0000001814ull)
-#define CVMX_NPI_PCI_CFG06 \
-	 CVMX_ADD_IO_SEG(0x00011F0000001818ull)
-#define CVMX_NPI_PCI_CFG07 \
-	 CVMX_ADD_IO_SEG(0x00011F000000181Cull)
-#define CVMX_NPI_PCI_CFG08 \
-	 CVMX_ADD_IO_SEG(0x00011F0000001820ull)
-#define CVMX_NPI_PCI_CFG09 \
-	 CVMX_ADD_IO_SEG(0x00011F0000001824ull)
-#define CVMX_NPI_PCI_CFG10 \
-	 CVMX_ADD_IO_SEG(0x00011F0000001828ull)
-#define CVMX_NPI_PCI_CFG11 \
-	 CVMX_ADD_IO_SEG(0x00011F000000182Cull)
-#define CVMX_NPI_PCI_CFG12 \
-	 CVMX_ADD_IO_SEG(0x00011F0000001830ull)
-#define CVMX_NPI_PCI_CFG13 \
-	 CVMX_ADD_IO_SEG(0x00011F0000001834ull)
-#define CVMX_NPI_PCI_CFG15 \
-	 CVMX_ADD_IO_SEG(0x00011F000000183Cull)
-#define CVMX_NPI_PCI_CFG16 \
-	 CVMX_ADD_IO_SEG(0x00011F0000001840ull)
-#define CVMX_NPI_PCI_CFG17 \
-	 CVMX_ADD_IO_SEG(0x00011F0000001844ull)
-#define CVMX_NPI_PCI_CFG18 \
-	 CVMX_ADD_IO_SEG(0x00011F0000001848ull)
-#define CVMX_NPI_PCI_CFG19 \
-	 CVMX_ADD_IO_SEG(0x00011F000000184Cull)
-#define CVMX_NPI_PCI_CFG20 \
-	 CVMX_ADD_IO_SEG(0x00011F0000001850ull)
-#define CVMX_NPI_PCI_CFG21 \
-	 CVMX_ADD_IO_SEG(0x00011F0000001854ull)
-#define CVMX_NPI_PCI_CFG22 \
-	 CVMX_ADD_IO_SEG(0x00011F0000001858ull)
-#define CVMX_NPI_PCI_CFG56 \
-	 CVMX_ADD_IO_SEG(0x00011F00000018E0ull)
-#define CVMX_NPI_PCI_CFG57 \
-	 CVMX_ADD_IO_SEG(0x00011F00000018E4ull)
-#define CVMX_NPI_PCI_CFG58 \
-	 CVMX_ADD_IO_SEG(0x00011F00000018E8ull)
-#define CVMX_NPI_PCI_CFG59 \
-	 CVMX_ADD_IO_SEG(0x00011F00000018ECull)
-#define CVMX_NPI_PCI_CFG60 \
-	 CVMX_ADD_IO_SEG(0x00011F00000018F0ull)
-#define CVMX_NPI_PCI_CFG61 \
-	 CVMX_ADD_IO_SEG(0x00011F00000018F4ull)
-#define CVMX_NPI_PCI_CFG62 \
-	 CVMX_ADD_IO_SEG(0x00011F00000018F8ull)
-#define CVMX_NPI_PCI_CFG63 \
-	 CVMX_ADD_IO_SEG(0x00011F00000018FCull)
-#define CVMX_NPI_PCI_CNT_REG \
-	 CVMX_ADD_IO_SEG(0x00011F00000011B8ull)
-#define CVMX_NPI_PCI_CTL_STATUS_2 \
-	 CVMX_ADD_IO_SEG(0x00011F000000118Cull)
-#define CVMX_NPI_PCI_INT_ARB_CFG \
-	 CVMX_ADD_IO_SEG(0x00011F0000000130ull)
-#define CVMX_NPI_PCI_INT_ENB2 \
-	 CVMX_ADD_IO_SEG(0x00011F00000011A0ull)
-#define CVMX_NPI_PCI_INT_SUM2 \
-	 CVMX_ADD_IO_SEG(0x00011F0000001198ull)
-#define CVMX_NPI_PCI_READ_CMD \
-	 CVMX_ADD_IO_SEG(0x00011F0000000048ull)
-#define CVMX_NPI_PCI_READ_CMD_6 \
-	 CVMX_ADD_IO_SEG(0x00011F0000001180ull)
-#define CVMX_NPI_PCI_READ_CMD_C \
-	 CVMX_ADD_IO_SEG(0x00011F0000001184ull)
-#define CVMX_NPI_PCI_READ_CMD_E \
-	 CVMX_ADD_IO_SEG(0x00011F0000001188ull)
-#define CVMX_NPI_PCI_SCM_REG \
-	 CVMX_ADD_IO_SEG(0x00011F00000011A8ull)
-#define CVMX_NPI_PCI_TSR_REG \
-	 CVMX_ADD_IO_SEG(0x00011F00000011B0ull)
-#define CVMX_NPI_PORT32_INSTR_HDR \
-	 CVMX_ADD_IO_SEG(0x00011F00000001F8ull)
-#define CVMX_NPI_PORT33_INSTR_HDR \
-	 CVMX_ADD_IO_SEG(0x00011F0000000200ull)
-#define CVMX_NPI_PORT34_INSTR_HDR \
-	 CVMX_ADD_IO_SEG(0x00011F0000000208ull)
-#define CVMX_NPI_PORT35_INSTR_HDR \
-	 CVMX_ADD_IO_SEG(0x00011F0000000210ull)
-#define CVMX_NPI_PORT_BP_CONTROL \
-	 CVMX_ADD_IO_SEG(0x00011F00000001F0ull)
-#define CVMX_NPI_PX_DBPAIR_ADDR(offset) \
-	 CVMX_ADD_IO_SEG(0x00011F0000000180ull + (((offset) & 3) * 8))
-#define CVMX_NPI_PX_INSTR_ADDR(offset) \
-	 CVMX_ADD_IO_SEG(0x00011F00000001C0ull + (((offset) & 3) * 8))
-#define CVMX_NPI_PX_INSTR_CNTS(offset) \
-	 CVMX_ADD_IO_SEG(0x00011F00000001A0ull + (((offset) & 3) * 8))
-#define CVMX_NPI_PX_PAIR_CNTS(offset) \
-	 CVMX_ADD_IO_SEG(0x00011F0000000160ull + (((offset) & 3) * 8))
-#define CVMX_NPI_RSL_INT_BLOCKS \
-	 CVMX_ADD_IO_SEG(0x00011F0000000000ull)
-#define CVMX_NPI_SIZE_INPUT0 \
-	 CVMX_ADD_IO_SEG(0x00011F0000000078ull)
-#define CVMX_NPI_SIZE_INPUT1 \
-	 CVMX_ADD_IO_SEG(0x00011F0000000088ull)
-#define CVMX_NPI_SIZE_INPUT2 \
-	 CVMX_ADD_IO_SEG(0x00011F0000000098ull)
-#define CVMX_NPI_SIZE_INPUT3 \
-	 CVMX_ADD_IO_SEG(0x00011F00000000A8ull)
-#define CVMX_NPI_SIZE_INPUTX(offset) \
-	 CVMX_ADD_IO_SEG(0x00011F0000000078ull + (((offset) & 3) * 16))
-#define CVMX_NPI_WIN_READ_TO \
-	 CVMX_ADD_IO_SEG(0x00011F00000001E0ull)
+#define CVMX_NPI_BASE_ADDR_INPUT0 CVMX_NPI_BASE_ADDR_INPUTX(0)
+#define CVMX_NPI_BASE_ADDR_INPUT1 CVMX_NPI_BASE_ADDR_INPUTX(1)
+#define CVMX_NPI_BASE_ADDR_INPUT2 CVMX_NPI_BASE_ADDR_INPUTX(2)
+#define CVMX_NPI_BASE_ADDR_INPUT3 CVMX_NPI_BASE_ADDR_INPUTX(3)
+#define CVMX_NPI_BASE_ADDR_INPUTX(offset) (CVMX_ADD_IO_SEG(0x00011F0000000070ull) + ((offset) & 3) * 16)
+#define CVMX_NPI_BASE_ADDR_OUTPUT0 CVMX_NPI_BASE_ADDR_OUTPUTX(0)
+#define CVMX_NPI_BASE_ADDR_OUTPUT1 CVMX_NPI_BASE_ADDR_OUTPUTX(1)
+#define CVMX_NPI_BASE_ADDR_OUTPUT2 CVMX_NPI_BASE_ADDR_OUTPUTX(2)
+#define CVMX_NPI_BASE_ADDR_OUTPUT3 CVMX_NPI_BASE_ADDR_OUTPUTX(3)
+#define CVMX_NPI_BASE_ADDR_OUTPUTX(offset) (CVMX_ADD_IO_SEG(0x00011F00000000B8ull) + ((offset) & 3) * 8)
+#define CVMX_NPI_BIST_STATUS (CVMX_ADD_IO_SEG(0x00011F00000003F8ull))
+#define CVMX_NPI_BUFF_SIZE_OUTPUT0 CVMX_NPI_BUFF_SIZE_OUTPUTX(0)
+#define CVMX_NPI_BUFF_SIZE_OUTPUT1 CVMX_NPI_BUFF_SIZE_OUTPUTX(1)
+#define CVMX_NPI_BUFF_SIZE_OUTPUT2 CVMX_NPI_BUFF_SIZE_OUTPUTX(2)
+#define CVMX_NPI_BUFF_SIZE_OUTPUT3 CVMX_NPI_BUFF_SIZE_OUTPUTX(3)
+#define CVMX_NPI_BUFF_SIZE_OUTPUTX(offset) (CVMX_ADD_IO_SEG(0x00011F00000000E0ull) + ((offset) & 3) * 8)
+#define CVMX_NPI_COMP_CTL (CVMX_ADD_IO_SEG(0x00011F0000000218ull))
+#define CVMX_NPI_CTL_STATUS (CVMX_ADD_IO_SEG(0x00011F0000000010ull))
+#define CVMX_NPI_DBG_SELECT (CVMX_ADD_IO_SEG(0x00011F0000000008ull))
+#define CVMX_NPI_DMA_CONTROL (CVMX_ADD_IO_SEG(0x00011F0000000128ull))
+#define CVMX_NPI_DMA_HIGHP_COUNTS (CVMX_ADD_IO_SEG(0x00011F0000000148ull))
+#define CVMX_NPI_DMA_HIGHP_NADDR (CVMX_ADD_IO_SEG(0x00011F0000000158ull))
+#define CVMX_NPI_DMA_LOWP_COUNTS (CVMX_ADD_IO_SEG(0x00011F0000000140ull))
+#define CVMX_NPI_DMA_LOWP_NADDR (CVMX_ADD_IO_SEG(0x00011F0000000150ull))
+#define CVMX_NPI_HIGHP_DBELL (CVMX_ADD_IO_SEG(0x00011F0000000120ull))
+#define CVMX_NPI_HIGHP_IBUFF_SADDR (CVMX_ADD_IO_SEG(0x00011F0000000110ull))
+#define CVMX_NPI_INPUT_CONTROL (CVMX_ADD_IO_SEG(0x00011F0000000138ull))
+#define CVMX_NPI_INT_ENB (CVMX_ADD_IO_SEG(0x00011F0000000020ull))
+#define CVMX_NPI_INT_SUM (CVMX_ADD_IO_SEG(0x00011F0000000018ull))
+#define CVMX_NPI_LOWP_DBELL (CVMX_ADD_IO_SEG(0x00011F0000000118ull))
+#define CVMX_NPI_LOWP_IBUFF_SADDR (CVMX_ADD_IO_SEG(0x00011F0000000108ull))
+#define CVMX_NPI_MEM_ACCESS_SUBID3 CVMX_NPI_MEM_ACCESS_SUBIDX(3)
+#define CVMX_NPI_MEM_ACCESS_SUBID4 CVMX_NPI_MEM_ACCESS_SUBIDX(4)
+#define CVMX_NPI_MEM_ACCESS_SUBID5 CVMX_NPI_MEM_ACCESS_SUBIDX(5)
+#define CVMX_NPI_MEM_ACCESS_SUBID6 CVMX_NPI_MEM_ACCESS_SUBIDX(6)
+#define CVMX_NPI_MEM_ACCESS_SUBIDX(offset) (CVMX_ADD_IO_SEG(0x00011F0000000028ull) + ((offset) & 7) * 8 - 8*3)
+#define CVMX_NPI_MSI_RCV (0x0000000000000190ull)
+#define CVMX_NPI_NPI_MSI_RCV (CVMX_ADD_IO_SEG(0x00011F0000001190ull))
+#define CVMX_NPI_NUM_DESC_OUTPUT0 CVMX_NPI_NUM_DESC_OUTPUTX(0)
+#define CVMX_NPI_NUM_DESC_OUTPUT1 CVMX_NPI_NUM_DESC_OUTPUTX(1)
+#define CVMX_NPI_NUM_DESC_OUTPUT2 CVMX_NPI_NUM_DESC_OUTPUTX(2)
+#define CVMX_NPI_NUM_DESC_OUTPUT3 CVMX_NPI_NUM_DESC_OUTPUTX(3)
+#define CVMX_NPI_NUM_DESC_OUTPUTX(offset) (CVMX_ADD_IO_SEG(0x00011F0000000050ull) + ((offset) & 3) * 8)
+#define CVMX_NPI_OUTPUT_CONTROL (CVMX_ADD_IO_SEG(0x00011F0000000100ull))
+#define CVMX_NPI_P0_DBPAIR_ADDR CVMX_NPI_PX_DBPAIR_ADDR(0)
+#define CVMX_NPI_P0_INSTR_ADDR CVMX_NPI_PX_INSTR_ADDR(0)
+#define CVMX_NPI_P0_INSTR_CNTS CVMX_NPI_PX_INSTR_CNTS(0)
+#define CVMX_NPI_P0_PAIR_CNTS CVMX_NPI_PX_PAIR_CNTS(0)
+#define CVMX_NPI_P1_DBPAIR_ADDR CVMX_NPI_PX_DBPAIR_ADDR(1)
+#define CVMX_NPI_P1_INSTR_ADDR CVMX_NPI_PX_INSTR_ADDR(1)
+#define CVMX_NPI_P1_INSTR_CNTS CVMX_NPI_PX_INSTR_CNTS(1)
+#define CVMX_NPI_P1_PAIR_CNTS CVMX_NPI_PX_PAIR_CNTS(1)
+#define CVMX_NPI_P2_DBPAIR_ADDR CVMX_NPI_PX_DBPAIR_ADDR(2)
+#define CVMX_NPI_P2_INSTR_ADDR CVMX_NPI_PX_INSTR_ADDR(2)
+#define CVMX_NPI_P2_INSTR_CNTS CVMX_NPI_PX_INSTR_CNTS(2)
+#define CVMX_NPI_P2_PAIR_CNTS CVMX_NPI_PX_PAIR_CNTS(2)
+#define CVMX_NPI_P3_DBPAIR_ADDR CVMX_NPI_PX_DBPAIR_ADDR(3)
+#define CVMX_NPI_P3_INSTR_ADDR CVMX_NPI_PX_INSTR_ADDR(3)
+#define CVMX_NPI_P3_INSTR_CNTS CVMX_NPI_PX_INSTR_CNTS(3)
+#define CVMX_NPI_P3_PAIR_CNTS CVMX_NPI_PX_PAIR_CNTS(3)
+#define CVMX_NPI_PCI_BAR1_INDEXX(offset) (CVMX_ADD_IO_SEG(0x00011F0000001100ull) + ((offset) & 31) * 4)
+#define CVMX_NPI_PCI_BIST_REG (CVMX_ADD_IO_SEG(0x00011F00000011C0ull))
+#define CVMX_NPI_PCI_BURST_SIZE (CVMX_ADD_IO_SEG(0x00011F00000000D8ull))
+#define CVMX_NPI_PCI_CFG00 (CVMX_ADD_IO_SEG(0x00011F0000001800ull))
+#define CVMX_NPI_PCI_CFG01 (CVMX_ADD_IO_SEG(0x00011F0000001804ull))
+#define CVMX_NPI_PCI_CFG02 (CVMX_ADD_IO_SEG(0x00011F0000001808ull))
+#define CVMX_NPI_PCI_CFG03 (CVMX_ADD_IO_SEG(0x00011F000000180Cull))
+#define CVMX_NPI_PCI_CFG04 (CVMX_ADD_IO_SEG(0x00011F0000001810ull))
+#define CVMX_NPI_PCI_CFG05 (CVMX_ADD_IO_SEG(0x00011F0000001814ull))
+#define CVMX_NPI_PCI_CFG06 (CVMX_ADD_IO_SEG(0x00011F0000001818ull))
+#define CVMX_NPI_PCI_CFG07 (CVMX_ADD_IO_SEG(0x00011F000000181Cull))
+#define CVMX_NPI_PCI_CFG08 (CVMX_ADD_IO_SEG(0x00011F0000001820ull))
+#define CVMX_NPI_PCI_CFG09 (CVMX_ADD_IO_SEG(0x00011F0000001824ull))
+#define CVMX_NPI_PCI_CFG10 (CVMX_ADD_IO_SEG(0x00011F0000001828ull))
+#define CVMX_NPI_PCI_CFG11 (CVMX_ADD_IO_SEG(0x00011F000000182Cull))
+#define CVMX_NPI_PCI_CFG12 (CVMX_ADD_IO_SEG(0x00011F0000001830ull))
+#define CVMX_NPI_PCI_CFG13 (CVMX_ADD_IO_SEG(0x00011F0000001834ull))
+#define CVMX_NPI_PCI_CFG15 (CVMX_ADD_IO_SEG(0x00011F000000183Cull))
+#define CVMX_NPI_PCI_CFG16 (CVMX_ADD_IO_SEG(0x00011F0000001840ull))
+#define CVMX_NPI_PCI_CFG17 (CVMX_ADD_IO_SEG(0x00011F0000001844ull))
+#define CVMX_NPI_PCI_CFG18 (CVMX_ADD_IO_SEG(0x00011F0000001848ull))
+#define CVMX_NPI_PCI_CFG19 (CVMX_ADD_IO_SEG(0x00011F000000184Cull))
+#define CVMX_NPI_PCI_CFG20 (CVMX_ADD_IO_SEG(0x00011F0000001850ull))
+#define CVMX_NPI_PCI_CFG21 (CVMX_ADD_IO_SEG(0x00011F0000001854ull))
+#define CVMX_NPI_PCI_CFG22 (CVMX_ADD_IO_SEG(0x00011F0000001858ull))
+#define CVMX_NPI_PCI_CFG56 (CVMX_ADD_IO_SEG(0x00011F00000018E0ull))
+#define CVMX_NPI_PCI_CFG57 (CVMX_ADD_IO_SEG(0x00011F00000018E4ull))
+#define CVMX_NPI_PCI_CFG58 (CVMX_ADD_IO_SEG(0x00011F00000018E8ull))
+#define CVMX_NPI_PCI_CFG59 (CVMX_ADD_IO_SEG(0x00011F00000018ECull))
+#define CVMX_NPI_PCI_CFG60 (CVMX_ADD_IO_SEG(0x00011F00000018F0ull))
+#define CVMX_NPI_PCI_CFG61 (CVMX_ADD_IO_SEG(0x00011F00000018F4ull))
+#define CVMX_NPI_PCI_CFG62 (CVMX_ADD_IO_SEG(0x00011F00000018F8ull))
+#define CVMX_NPI_PCI_CFG63 (CVMX_ADD_IO_SEG(0x00011F00000018FCull))
+#define CVMX_NPI_PCI_CNT_REG (CVMX_ADD_IO_SEG(0x00011F00000011B8ull))
+#define CVMX_NPI_PCI_CTL_STATUS_2 (CVMX_ADD_IO_SEG(0x00011F000000118Cull))
+#define CVMX_NPI_PCI_INT_ARB_CFG (CVMX_ADD_IO_SEG(0x00011F0000000130ull))
+#define CVMX_NPI_PCI_INT_ENB2 (CVMX_ADD_IO_SEG(0x00011F00000011A0ull))
+#define CVMX_NPI_PCI_INT_SUM2 (CVMX_ADD_IO_SEG(0x00011F0000001198ull))
+#define CVMX_NPI_PCI_READ_CMD (CVMX_ADD_IO_SEG(0x00011F0000000048ull))
+#define CVMX_NPI_PCI_READ_CMD_6 (CVMX_ADD_IO_SEG(0x00011F0000001180ull))
+#define CVMX_NPI_PCI_READ_CMD_C (CVMX_ADD_IO_SEG(0x00011F0000001184ull))
+#define CVMX_NPI_PCI_READ_CMD_E (CVMX_ADD_IO_SEG(0x00011F0000001188ull))
+#define CVMX_NPI_PCI_SCM_REG (CVMX_ADD_IO_SEG(0x00011F00000011A8ull))
+#define CVMX_NPI_PCI_TSR_REG (CVMX_ADD_IO_SEG(0x00011F00000011B0ull))
+#define CVMX_NPI_PORT32_INSTR_HDR (CVMX_ADD_IO_SEG(0x00011F00000001F8ull))
+#define CVMX_NPI_PORT33_INSTR_HDR (CVMX_ADD_IO_SEG(0x00011F0000000200ull))
+#define CVMX_NPI_PORT34_INSTR_HDR (CVMX_ADD_IO_SEG(0x00011F0000000208ull))
+#define CVMX_NPI_PORT35_INSTR_HDR (CVMX_ADD_IO_SEG(0x00011F0000000210ull))
+#define CVMX_NPI_PORT_BP_CONTROL (CVMX_ADD_IO_SEG(0x00011F00000001F0ull))
+#define CVMX_NPI_PX_DBPAIR_ADDR(offset) (CVMX_ADD_IO_SEG(0x00011F0000000180ull) + ((offset) & 3) * 8)
+#define CVMX_NPI_PX_INSTR_ADDR(offset) (CVMX_ADD_IO_SEG(0x00011F00000001C0ull) + ((offset) & 3) * 8)
+#define CVMX_NPI_PX_INSTR_CNTS(offset) (CVMX_ADD_IO_SEG(0x00011F00000001A0ull) + ((offset) & 3) * 8)
+#define CVMX_NPI_PX_PAIR_CNTS(offset) (CVMX_ADD_IO_SEG(0x00011F0000000160ull) + ((offset) & 3) * 8)
+#define CVMX_NPI_RSL_INT_BLOCKS (CVMX_ADD_IO_SEG(0x00011F0000000000ull))
+#define CVMX_NPI_SIZE_INPUT0 CVMX_NPI_SIZE_INPUTX(0)
+#define CVMX_NPI_SIZE_INPUT1 CVMX_NPI_SIZE_INPUTX(1)
+#define CVMX_NPI_SIZE_INPUT2 CVMX_NPI_SIZE_INPUTX(2)
+#define CVMX_NPI_SIZE_INPUT3 CVMX_NPI_SIZE_INPUTX(3)
+#define CVMX_NPI_SIZE_INPUTX(offset) (CVMX_ADD_IO_SEG(0x00011F0000000078ull) + ((offset) & 3) * 16)
+#define CVMX_NPI_WIN_READ_TO (CVMX_ADD_IO_SEG(0x00011F00000001E0ull))
 
 union cvmx_npi_base_addr_inputx {
 	uint64_t u64;
diff --git a/arch/mips/include/asm/octeon/cvmx-pci-defs.h b/arch/mips/include/asm/octeon/cvmx-pci-defs.h
index 90f8d65..6ff6d9d 100644
--- a/arch/mips/include/asm/octeon/cvmx-pci-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-pci-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2010 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -28,184 +28,91 @@
 #ifndef __CVMX_PCI_DEFS_H__
 #define __CVMX_PCI_DEFS_H__
 
-#define CVMX_PCI_BAR1_INDEXX(offset) \
-	 (0x0000000000000100ull + (((offset) & 31) * 4))
-#define CVMX_PCI_BIST_REG \
-	 (0x00000000000001C0ull)
-#define CVMX_PCI_CFG00 \
-	 (0x0000000000000000ull)
-#define CVMX_PCI_CFG01 \
-	 (0x0000000000000004ull)
-#define CVMX_PCI_CFG02 \
-	 (0x0000000000000008ull)
-#define CVMX_PCI_CFG03 \
-	 (0x000000000000000Cull)
-#define CVMX_PCI_CFG04 \
-	 (0x0000000000000010ull)
-#define CVMX_PCI_CFG05 \
-	 (0x0000000000000014ull)
-#define CVMX_PCI_CFG06 \
-	 (0x0000000000000018ull)
-#define CVMX_PCI_CFG07 \
-	 (0x000000000000001Cull)
-#define CVMX_PCI_CFG08 \
-	 (0x0000000000000020ull)
-#define CVMX_PCI_CFG09 \
-	 (0x0000000000000024ull)
-#define CVMX_PCI_CFG10 \
-	 (0x0000000000000028ull)
-#define CVMX_PCI_CFG11 \
-	 (0x000000000000002Cull)
-#define CVMX_PCI_CFG12 \
-	 (0x0000000000000030ull)
-#define CVMX_PCI_CFG13 \
-	 (0x0000000000000034ull)
-#define CVMX_PCI_CFG15 \
-	 (0x000000000000003Cull)
-#define CVMX_PCI_CFG16 \
-	 (0x0000000000000040ull)
-#define CVMX_PCI_CFG17 \
-	 (0x0000000000000044ull)
-#define CVMX_PCI_CFG18 \
-	 (0x0000000000000048ull)
-#define CVMX_PCI_CFG19 \
-	 (0x000000000000004Cull)
-#define CVMX_PCI_CFG20 \
-	 (0x0000000000000050ull)
-#define CVMX_PCI_CFG21 \
-	 (0x0000000000000054ull)
-#define CVMX_PCI_CFG22 \
-	 (0x0000000000000058ull)
-#define CVMX_PCI_CFG56 \
-	 (0x00000000000000E0ull)
-#define CVMX_PCI_CFG57 \
-	 (0x00000000000000E4ull)
-#define CVMX_PCI_CFG58 \
-	 (0x00000000000000E8ull)
-#define CVMX_PCI_CFG59 \
-	 (0x00000000000000ECull)
-#define CVMX_PCI_CFG60 \
-	 (0x00000000000000F0ull)
-#define CVMX_PCI_CFG61 \
-	 (0x00000000000000F4ull)
-#define CVMX_PCI_CFG62 \
-	 (0x00000000000000F8ull)
-#define CVMX_PCI_CFG63 \
-	 (0x00000000000000FCull)
-#define CVMX_PCI_CNT_REG \
-	 (0x00000000000001B8ull)
-#define CVMX_PCI_CTL_STATUS_2 \
-	 (0x000000000000018Cull)
-#define CVMX_PCI_DBELL_0 \
-	 (0x0000000000000080ull)
-#define CVMX_PCI_DBELL_1 \
-	 (0x0000000000000088ull)
-#define CVMX_PCI_DBELL_2 \
-	 (0x0000000000000090ull)
-#define CVMX_PCI_DBELL_3 \
-	 (0x0000000000000098ull)
-#define CVMX_PCI_DBELL_X(offset) \
-	 (0x0000000000000080ull + (((offset) & 3) * 8))
-#define CVMX_PCI_DMA_CNT0 \
-	 (0x00000000000000A0ull)
-#define CVMX_PCI_DMA_CNT1 \
-	 (0x00000000000000A8ull)
-#define CVMX_PCI_DMA_CNTX(offset) \
-	 (0x00000000000000A0ull + (((offset) & 1) * 8))
-#define CVMX_PCI_DMA_INT_LEV0 \
-	 (0x00000000000000A4ull)
-#define CVMX_PCI_DMA_INT_LEV1 \
-	 (0x00000000000000ACull)
-#define CVMX_PCI_DMA_INT_LEVX(offset) \
-	 (0x00000000000000A4ull + (((offset) & 1) * 8))
-#define CVMX_PCI_DMA_TIME0 \
-	 (0x00000000000000B0ull)
-#define CVMX_PCI_DMA_TIME1 \
-	 (0x00000000000000B4ull)
-#define CVMX_PCI_DMA_TIMEX(offset) \
-	 (0x00000000000000B0ull + (((offset) & 1) * 4))
-#define CVMX_PCI_INSTR_COUNT0 \
-	 (0x0000000000000084ull)
-#define CVMX_PCI_INSTR_COUNT1 \
-	 (0x000000000000008Cull)
-#define CVMX_PCI_INSTR_COUNT2 \
-	 (0x0000000000000094ull)
-#define CVMX_PCI_INSTR_COUNT3 \
-	 (0x000000000000009Cull)
-#define CVMX_PCI_INSTR_COUNTX(offset) \
-	 (0x0000000000000084ull + (((offset) & 3) * 8))
-#define CVMX_PCI_INT_ENB \
-	 (0x0000000000000038ull)
-#define CVMX_PCI_INT_ENB2 \
-	 (0x00000000000001A0ull)
-#define CVMX_PCI_INT_SUM \
-	 (0x0000000000000030ull)
-#define CVMX_PCI_INT_SUM2 \
-	 (0x0000000000000198ull)
-#define CVMX_PCI_MSI_RCV \
-	 (0x00000000000000F0ull)
-#define CVMX_PCI_PKTS_SENT0 \
-	 (0x0000000000000040ull)
-#define CVMX_PCI_PKTS_SENT1 \
-	 (0x0000000000000050ull)
-#define CVMX_PCI_PKTS_SENT2 \
-	 (0x0000000000000060ull)
-#define CVMX_PCI_PKTS_SENT3 \
-	 (0x0000000000000070ull)
-#define CVMX_PCI_PKTS_SENTX(offset) \
-	 (0x0000000000000040ull + (((offset) & 3) * 16))
-#define CVMX_PCI_PKTS_SENT_INT_LEV0 \
-	 (0x0000000000000048ull)
-#define CVMX_PCI_PKTS_SENT_INT_LEV1 \
-	 (0x0000000000000058ull)
-#define CVMX_PCI_PKTS_SENT_INT_LEV2 \
-	 (0x0000000000000068ull)
-#define CVMX_PCI_PKTS_SENT_INT_LEV3 \
-	 (0x0000000000000078ull)
-#define CVMX_PCI_PKTS_SENT_INT_LEVX(offset) \
-	 (0x0000000000000048ull + (((offset) & 3) * 16))
-#define CVMX_PCI_PKTS_SENT_TIME0 \
-	 (0x000000000000004Cull)
-#define CVMX_PCI_PKTS_SENT_TIME1 \
-	 (0x000000000000005Cull)
-#define CVMX_PCI_PKTS_SENT_TIME2 \
-	 (0x000000000000006Cull)
-#define CVMX_PCI_PKTS_SENT_TIME3 \
-	 (0x000000000000007Cull)
-#define CVMX_PCI_PKTS_SENT_TIMEX(offset) \
-	 (0x000000000000004Cull + (((offset) & 3) * 16))
-#define CVMX_PCI_PKT_CREDITS0 \
-	 (0x0000000000000044ull)
-#define CVMX_PCI_PKT_CREDITS1 \
-	 (0x0000000000000054ull)
-#define CVMX_PCI_PKT_CREDITS2 \
-	 (0x0000000000000064ull)
-#define CVMX_PCI_PKT_CREDITS3 \
-	 (0x0000000000000074ull)
-#define CVMX_PCI_PKT_CREDITSX(offset) \
-	 (0x0000000000000044ull + (((offset) & 3) * 16))
-#define CVMX_PCI_READ_CMD_6 \
-	 (0x0000000000000180ull)
-#define CVMX_PCI_READ_CMD_C \
-	 (0x0000000000000184ull)
-#define CVMX_PCI_READ_CMD_E \
-	 (0x0000000000000188ull)
-#define CVMX_PCI_READ_TIMEOUT \
-	 CVMX_ADD_IO_SEG(0x00011F00000000B0ull)
-#define CVMX_PCI_SCM_REG \
-	 (0x00000000000001A8ull)
-#define CVMX_PCI_TSR_REG \
-	 (0x00000000000001B0ull)
-#define CVMX_PCI_WIN_RD_ADDR \
-	 (0x0000000000000008ull)
-#define CVMX_PCI_WIN_RD_DATA \
-	 (0x0000000000000020ull)
-#define CVMX_PCI_WIN_WR_ADDR \
-	 (0x0000000000000000ull)
-#define CVMX_PCI_WIN_WR_DATA \
-	 (0x0000000000000010ull)
-#define CVMX_PCI_WIN_WR_MASK \
-	 (0x0000000000000018ull)
+#define CVMX_PCI_BAR1_INDEXX(offset) (0x0000000000000100ull + ((offset) & 31) * 4)
+#define CVMX_PCI_BIST_REG (0x00000000000001C0ull)
+#define CVMX_PCI_CFG00 (0x0000000000000000ull)
+#define CVMX_PCI_CFG01 (0x0000000000000004ull)
+#define CVMX_PCI_CFG02 (0x0000000000000008ull)
+#define CVMX_PCI_CFG03 (0x000000000000000Cull)
+#define CVMX_PCI_CFG04 (0x0000000000000010ull)
+#define CVMX_PCI_CFG05 (0x0000000000000014ull)
+#define CVMX_PCI_CFG06 (0x0000000000000018ull)
+#define CVMX_PCI_CFG07 (0x000000000000001Cull)
+#define CVMX_PCI_CFG08 (0x0000000000000020ull)
+#define CVMX_PCI_CFG09 (0x0000000000000024ull)
+#define CVMX_PCI_CFG10 (0x0000000000000028ull)
+#define CVMX_PCI_CFG11 (0x000000000000002Cull)
+#define CVMX_PCI_CFG12 (0x0000000000000030ull)
+#define CVMX_PCI_CFG13 (0x0000000000000034ull)
+#define CVMX_PCI_CFG15 (0x000000000000003Cull)
+#define CVMX_PCI_CFG16 (0x0000000000000040ull)
+#define CVMX_PCI_CFG17 (0x0000000000000044ull)
+#define CVMX_PCI_CFG18 (0x0000000000000048ull)
+#define CVMX_PCI_CFG19 (0x000000000000004Cull)
+#define CVMX_PCI_CFG20 (0x0000000000000050ull)
+#define CVMX_PCI_CFG21 (0x0000000000000054ull)
+#define CVMX_PCI_CFG22 (0x0000000000000058ull)
+#define CVMX_PCI_CFG56 (0x00000000000000E0ull)
+#define CVMX_PCI_CFG57 (0x00000000000000E4ull)
+#define CVMX_PCI_CFG58 (0x00000000000000E8ull)
+#define CVMX_PCI_CFG59 (0x00000000000000ECull)
+#define CVMX_PCI_CFG60 (0x00000000000000F0ull)
+#define CVMX_PCI_CFG61 (0x00000000000000F4ull)
+#define CVMX_PCI_CFG62 (0x00000000000000F8ull)
+#define CVMX_PCI_CFG63 (0x00000000000000FCull)
+#define CVMX_PCI_CNT_REG (0x00000000000001B8ull)
+#define CVMX_PCI_CTL_STATUS_2 (0x000000000000018Cull)
+#define CVMX_PCI_DBELL_X(offset) (0x0000000000000080ull + ((offset) & 3) * 8)
+#define CVMX_PCI_DMA_CNT0 CVMX_PCI_DMA_CNTX(0)
+#define CVMX_PCI_DMA_CNT1 CVMX_PCI_DMA_CNTX(1)
+#define CVMX_PCI_DMA_CNTX(offset) (0x00000000000000A0ull + ((offset) & 1) * 8)
+#define CVMX_PCI_DMA_INT_LEV0 CVMX_PCI_DMA_INT_LEVX(0)
+#define CVMX_PCI_DMA_INT_LEV1 CVMX_PCI_DMA_INT_LEVX(1)
+#define CVMX_PCI_DMA_INT_LEVX(offset) (0x00000000000000A4ull + ((offset) & 1) * 8)
+#define CVMX_PCI_DMA_TIME0 CVMX_PCI_DMA_TIMEX(0)
+#define CVMX_PCI_DMA_TIME1 CVMX_PCI_DMA_TIMEX(1)
+#define CVMX_PCI_DMA_TIMEX(offset) (0x00000000000000B0ull + ((offset) & 1) * 4)
+#define CVMX_PCI_INSTR_COUNT0 CVMX_PCI_INSTR_COUNTX(0)
+#define CVMX_PCI_INSTR_COUNT1 CVMX_PCI_INSTR_COUNTX(1)
+#define CVMX_PCI_INSTR_COUNT2 CVMX_PCI_INSTR_COUNTX(2)
+#define CVMX_PCI_INSTR_COUNT3 CVMX_PCI_INSTR_COUNTX(3)
+#define CVMX_PCI_INSTR_COUNTX(offset) (0x0000000000000084ull + ((offset) & 3) * 8)
+#define CVMX_PCI_INT_ENB (0x0000000000000038ull)
+#define CVMX_PCI_INT_ENB2 (0x00000000000001A0ull)
+#define CVMX_PCI_INT_SUM (0x0000000000000030ull)
+#define CVMX_PCI_INT_SUM2 (0x0000000000000198ull)
+#define CVMX_PCI_MSI_RCV (0x00000000000000F0ull)
+#define CVMX_PCI_PKTS_SENT0 CVMX_PCI_PKTS_SENTX(0)
+#define CVMX_PCI_PKTS_SENT1 CVMX_PCI_PKTS_SENTX(1)
+#define CVMX_PCI_PKTS_SENT2 CVMX_PCI_PKTS_SENTX(2)
+#define CVMX_PCI_PKTS_SENT3 CVMX_PCI_PKTS_SENTX(3)
+#define CVMX_PCI_PKTS_SENTX(offset) (0x0000000000000040ull + ((offset) & 3) * 16)
+#define CVMX_PCI_PKTS_SENT_INT_LEV0 CVMX_PCI_PKTS_SENT_INT_LEVX(0)
+#define CVMX_PCI_PKTS_SENT_INT_LEV1 CVMX_PCI_PKTS_SENT_INT_LEVX(1)
+#define CVMX_PCI_PKTS_SENT_INT_LEV2 CVMX_PCI_PKTS_SENT_INT_LEVX(2)
+#define CVMX_PCI_PKTS_SENT_INT_LEV3 CVMX_PCI_PKTS_SENT_INT_LEVX(3)
+#define CVMX_PCI_PKTS_SENT_INT_LEVX(offset) (0x0000000000000048ull + ((offset) & 3) * 16)
+#define CVMX_PCI_PKTS_SENT_TIME0 CVMX_PCI_PKTS_SENT_TIMEX(0)
+#define CVMX_PCI_PKTS_SENT_TIME1 CVMX_PCI_PKTS_SENT_TIMEX(1)
+#define CVMX_PCI_PKTS_SENT_TIME2 CVMX_PCI_PKTS_SENT_TIMEX(2)
+#define CVMX_PCI_PKTS_SENT_TIME3 CVMX_PCI_PKTS_SENT_TIMEX(3)
+#define CVMX_PCI_PKTS_SENT_TIMEX(offset) (0x000000000000004Cull + ((offset) & 3) * 16)
+#define CVMX_PCI_PKT_CREDITS0 CVMX_PCI_PKT_CREDITSX(0)
+#define CVMX_PCI_PKT_CREDITS1 CVMX_PCI_PKT_CREDITSX(1)
+#define CVMX_PCI_PKT_CREDITS2 CVMX_PCI_PKT_CREDITSX(2)
+#define CVMX_PCI_PKT_CREDITS3 CVMX_PCI_PKT_CREDITSX(3)
+#define CVMX_PCI_PKT_CREDITSX(offset) (0x0000000000000044ull + ((offset) & 3) * 16)
+#define CVMX_PCI_READ_CMD_6 (0x0000000000000180ull)
+#define CVMX_PCI_READ_CMD_C (0x0000000000000184ull)
+#define CVMX_PCI_READ_CMD_E (0x0000000000000188ull)
+#define CVMX_PCI_READ_TIMEOUT (CVMX_ADD_IO_SEG(0x00011F00000000B0ull))
+#define CVMX_PCI_SCM_REG (0x00000000000001A8ull)
+#define CVMX_PCI_TSR_REG (0x00000000000001B0ull)
+#define CVMX_PCI_WIN_RD_ADDR (0x0000000000000008ull)
+#define CVMX_PCI_WIN_RD_DATA (0x0000000000000020ull)
+#define CVMX_PCI_WIN_WR_ADDR (0x0000000000000000ull)
+#define CVMX_PCI_WIN_WR_DATA (0x0000000000000010ull)
+#define CVMX_PCI_WIN_WR_MASK (0x0000000000000018ull)
 
 union cvmx_pci_bar1_indexx {
 	uint32_t u32;
diff --git a/arch/mips/include/asm/octeon/cvmx-pciercx-defs.h b/arch/mips/include/asm/octeon/cvmx-pciercx-defs.h
index 75574c9..f8cb889 100644
--- a/arch/mips/include/asm/octeon/cvmx-pciercx-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-pciercx-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2010 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -28,158 +28,83 @@
 #ifndef __CVMX_PCIERCX_DEFS_H__
 #define __CVMX_PCIERCX_DEFS_H__
 
-#define CVMX_PCIERCX_CFG000(offset) \
-	 (0x0000000000000000ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG001(offset) \
-	 (0x0000000000000004ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG002(offset) \
-	 (0x0000000000000008ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG003(offset) \
-	 (0x000000000000000Cull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG004(offset) \
-	 (0x0000000000000010ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG005(offset) \
-	 (0x0000000000000014ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG006(offset) \
-	 (0x0000000000000018ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG007(offset) \
-	 (0x000000000000001Cull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG008(offset) \
-	 (0x0000000000000020ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG009(offset) \
-	 (0x0000000000000024ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG010(offset) \
-	 (0x0000000000000028ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG011(offset) \
-	 (0x000000000000002Cull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG012(offset) \
-	 (0x0000000000000030ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG013(offset) \
-	 (0x0000000000000034ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG014(offset) \
-	 (0x0000000000000038ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG015(offset) \
-	 (0x000000000000003Cull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG016(offset) \
-	 (0x0000000000000040ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG017(offset) \
-	 (0x0000000000000044ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG020(offset) \
-	 (0x0000000000000050ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG021(offset) \
-	 (0x0000000000000054ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG022(offset) \
-	 (0x0000000000000058ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG023(offset) \
-	 (0x000000000000005Cull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG028(offset) \
-	 (0x0000000000000070ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG029(offset) \
-	 (0x0000000000000074ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG030(offset) \
-	 (0x0000000000000078ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG031(offset) \
-	 (0x000000000000007Cull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG032(offset) \
-	 (0x0000000000000080ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG033(offset) \
-	 (0x0000000000000084ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG034(offset) \
-	 (0x0000000000000088ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG035(offset) \
-	 (0x000000000000008Cull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG036(offset) \
-	 (0x0000000000000090ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG037(offset) \
-	 (0x0000000000000094ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG038(offset) \
-	 (0x0000000000000098ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG039(offset) \
-	 (0x000000000000009Cull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG040(offset) \
-	 (0x00000000000000A0ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG041(offset) \
-	 (0x00000000000000A4ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG042(offset) \
-	 (0x00000000000000A8ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG064(offset) \
-	 (0x0000000000000100ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG065(offset) \
-	 (0x0000000000000104ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG066(offset) \
-	 (0x0000000000000108ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG067(offset) \
-	 (0x000000000000010Cull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG068(offset) \
-	 (0x0000000000000110ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG069(offset) \
-	 (0x0000000000000114ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG070(offset) \
-	 (0x0000000000000118ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG071(offset) \
-	 (0x000000000000011Cull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG072(offset) \
-	 (0x0000000000000120ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG073(offset) \
-	 (0x0000000000000124ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG074(offset) \
-	 (0x0000000000000128ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG075(offset) \
-	 (0x000000000000012Cull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG076(offset) \
-	 (0x0000000000000130ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG077(offset) \
-	 (0x0000000000000134ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG448(offset) \
-	 (0x0000000000000700ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG449(offset) \
-	 (0x0000000000000704ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG450(offset) \
-	 (0x0000000000000708ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG451(offset) \
-	 (0x000000000000070Cull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG452(offset) \
-	 (0x0000000000000710ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG453(offset) \
-	 (0x0000000000000714ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG454(offset) \
-	 (0x0000000000000718ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG455(offset) \
-	 (0x000000000000071Cull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG456(offset) \
-	 (0x0000000000000720ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG458(offset) \
-	 (0x0000000000000728ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG459(offset) \
-	 (0x000000000000072Cull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG460(offset) \
-	 (0x0000000000000730ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG461(offset) \
-	 (0x0000000000000734ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG462(offset) \
-	 (0x0000000000000738ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG463(offset) \
-	 (0x000000000000073Cull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG464(offset) \
-	 (0x0000000000000740ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG465(offset) \
-	 (0x0000000000000744ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG466(offset) \
-	 (0x0000000000000748ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG467(offset) \
-	 (0x000000000000074Cull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG468(offset) \
-	 (0x0000000000000750ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG490(offset) \
-	 (0x00000000000007A8ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG491(offset) \
-	 (0x00000000000007ACull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG492(offset) \
-	 (0x00000000000007B0ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG516(offset) \
-	 (0x0000000000000810ull + (((offset) & 1) * 0))
-#define CVMX_PCIERCX_CFG517(offset) \
-	 (0x0000000000000814ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG000(block_id) (0x0000000000000000ull)
+#define CVMX_PCIERCX_CFG001(block_id) (0x0000000000000004ull)
+#define CVMX_PCIERCX_CFG002(block_id) (0x0000000000000008ull)
+#define CVMX_PCIERCX_CFG003(block_id) (0x000000000000000Cull)
+#define CVMX_PCIERCX_CFG004(block_id) (0x0000000000000010ull)
+#define CVMX_PCIERCX_CFG005(block_id) (0x0000000000000014ull)
+#define CVMX_PCIERCX_CFG006(block_id) (0x0000000000000018ull)
+#define CVMX_PCIERCX_CFG007(block_id) (0x000000000000001Cull)
+#define CVMX_PCIERCX_CFG008(block_id) (0x0000000000000020ull)
+#define CVMX_PCIERCX_CFG009(block_id) (0x0000000000000024ull)
+#define CVMX_PCIERCX_CFG010(block_id) (0x0000000000000028ull)
+#define CVMX_PCIERCX_CFG011(block_id) (0x000000000000002Cull)
+#define CVMX_PCIERCX_CFG012(block_id) (0x0000000000000030ull)
+#define CVMX_PCIERCX_CFG013(block_id) (0x0000000000000034ull)
+#define CVMX_PCIERCX_CFG014(block_id) (0x0000000000000038ull)
+#define CVMX_PCIERCX_CFG015(block_id) (0x000000000000003Cull)
+#define CVMX_PCIERCX_CFG016(block_id) (0x0000000000000040ull)
+#define CVMX_PCIERCX_CFG017(block_id) (0x0000000000000044ull)
+#define CVMX_PCIERCX_CFG020(block_id) (0x0000000000000050ull)
+#define CVMX_PCIERCX_CFG021(block_id) (0x0000000000000054ull)
+#define CVMX_PCIERCX_CFG022(block_id) (0x0000000000000058ull)
+#define CVMX_PCIERCX_CFG023(block_id) (0x000000000000005Cull)
+#define CVMX_PCIERCX_CFG028(block_id) (0x0000000000000070ull)
+#define CVMX_PCIERCX_CFG029(block_id) (0x0000000000000074ull)
+#define CVMX_PCIERCX_CFG030(block_id) (0x0000000000000078ull)
+#define CVMX_PCIERCX_CFG031(block_id) (0x000000000000007Cull)
+#define CVMX_PCIERCX_CFG032(block_id) (0x0000000000000080ull)
+#define CVMX_PCIERCX_CFG033(block_id) (0x0000000000000084ull)
+#define CVMX_PCIERCX_CFG034(block_id) (0x0000000000000088ull)
+#define CVMX_PCIERCX_CFG035(block_id) (0x000000000000008Cull)
+#define CVMX_PCIERCX_CFG036(block_id) (0x0000000000000090ull)
+#define CVMX_PCIERCX_CFG037(block_id) (0x0000000000000094ull)
+#define CVMX_PCIERCX_CFG038(block_id) (0x0000000000000098ull)
+#define CVMX_PCIERCX_CFG039(block_id) (0x000000000000009Cull)
+#define CVMX_PCIERCX_CFG040(block_id) (0x00000000000000A0ull)
+#define CVMX_PCIERCX_CFG041(block_id) (0x00000000000000A4ull)
+#define CVMX_PCIERCX_CFG042(block_id) (0x00000000000000A8ull)
+#define CVMX_PCIERCX_CFG064(block_id) (0x0000000000000100ull)
+#define CVMX_PCIERCX_CFG065(block_id) (0x0000000000000104ull)
+#define CVMX_PCIERCX_CFG066(block_id) (0x0000000000000108ull)
+#define CVMX_PCIERCX_CFG067(block_id) (0x000000000000010Cull)
+#define CVMX_PCIERCX_CFG068(block_id) (0x0000000000000110ull)
+#define CVMX_PCIERCX_CFG069(block_id) (0x0000000000000114ull)
+#define CVMX_PCIERCX_CFG070(block_id) (0x0000000000000118ull)
+#define CVMX_PCIERCX_CFG071(block_id) (0x000000000000011Cull)
+#define CVMX_PCIERCX_CFG072(block_id) (0x0000000000000120ull)
+#define CVMX_PCIERCX_CFG073(block_id) (0x0000000000000124ull)
+#define CVMX_PCIERCX_CFG074(block_id) (0x0000000000000128ull)
+#define CVMX_PCIERCX_CFG075(block_id) (0x000000000000012Cull)
+#define CVMX_PCIERCX_CFG076(block_id) (0x0000000000000130ull)
+#define CVMX_PCIERCX_CFG077(block_id) (0x0000000000000134ull)
+#define CVMX_PCIERCX_CFG448(block_id) (0x0000000000000700ull)
+#define CVMX_PCIERCX_CFG449(block_id) (0x0000000000000704ull)
+#define CVMX_PCIERCX_CFG450(block_id) (0x0000000000000708ull)
+#define CVMX_PCIERCX_CFG451(block_id) (0x000000000000070Cull)
+#define CVMX_PCIERCX_CFG452(block_id) (0x0000000000000710ull)
+#define CVMX_PCIERCX_CFG453(block_id) (0x0000000000000714ull)
+#define CVMX_PCIERCX_CFG454(block_id) (0x0000000000000718ull)
+#define CVMX_PCIERCX_CFG455(block_id) (0x000000000000071Cull)
+#define CVMX_PCIERCX_CFG456(block_id) (0x0000000000000720ull)
+#define CVMX_PCIERCX_CFG458(block_id) (0x0000000000000728ull)
+#define CVMX_PCIERCX_CFG459(block_id) (0x000000000000072Cull)
+#define CVMX_PCIERCX_CFG460(block_id) (0x0000000000000730ull)
+#define CVMX_PCIERCX_CFG461(block_id) (0x0000000000000734ull)
+#define CVMX_PCIERCX_CFG462(block_id) (0x0000000000000738ull)
+#define CVMX_PCIERCX_CFG463(block_id) (0x000000000000073Cull)
+#define CVMX_PCIERCX_CFG464(block_id) (0x0000000000000740ull)
+#define CVMX_PCIERCX_CFG465(block_id) (0x0000000000000744ull)
+#define CVMX_PCIERCX_CFG466(block_id) (0x0000000000000748ull)
+#define CVMX_PCIERCX_CFG467(block_id) (0x000000000000074Cull)
+#define CVMX_PCIERCX_CFG468(block_id) (0x0000000000000750ull)
+#define CVMX_PCIERCX_CFG490(block_id) (0x00000000000007A8ull)
+#define CVMX_PCIERCX_CFG491(block_id) (0x00000000000007ACull)
+#define CVMX_PCIERCX_CFG492(block_id) (0x00000000000007B0ull)
+#define CVMX_PCIERCX_CFG515(block_id) (0x000000000000080Cull)
+#define CVMX_PCIERCX_CFG516(block_id) (0x0000000000000810ull)
+#define CVMX_PCIERCX_CFG517(block_id) (0x0000000000000814ull)
 
 union cvmx_pciercx_cfg000 {
 	uint32_t u32;
@@ -191,6 +116,8 @@ union cvmx_pciercx_cfg000 {
 	struct cvmx_pciercx_cfg000_s cn52xxp1;
 	struct cvmx_pciercx_cfg000_s cn56xx;
 	struct cvmx_pciercx_cfg000_s cn56xxp1;
+	struct cvmx_pciercx_cfg000_s cn63xx;
+	struct cvmx_pciercx_cfg000_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg001 {
@@ -225,6 +152,8 @@ union cvmx_pciercx_cfg001 {
 	struct cvmx_pciercx_cfg001_s cn52xxp1;
 	struct cvmx_pciercx_cfg001_s cn56xx;
 	struct cvmx_pciercx_cfg001_s cn56xxp1;
+	struct cvmx_pciercx_cfg001_s cn63xx;
+	struct cvmx_pciercx_cfg001_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg002 {
@@ -239,6 +168,8 @@ union cvmx_pciercx_cfg002 {
 	struct cvmx_pciercx_cfg002_s cn52xxp1;
 	struct cvmx_pciercx_cfg002_s cn56xx;
 	struct cvmx_pciercx_cfg002_s cn56xxp1;
+	struct cvmx_pciercx_cfg002_s cn63xx;
+	struct cvmx_pciercx_cfg002_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg003 {
@@ -254,6 +185,8 @@ union cvmx_pciercx_cfg003 {
 	struct cvmx_pciercx_cfg003_s cn52xxp1;
 	struct cvmx_pciercx_cfg003_s cn56xx;
 	struct cvmx_pciercx_cfg003_s cn56xxp1;
+	struct cvmx_pciercx_cfg003_s cn63xx;
+	struct cvmx_pciercx_cfg003_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg004 {
@@ -265,6 +198,8 @@ union cvmx_pciercx_cfg004 {
 	struct cvmx_pciercx_cfg004_s cn52xxp1;
 	struct cvmx_pciercx_cfg004_s cn56xx;
 	struct cvmx_pciercx_cfg004_s cn56xxp1;
+	struct cvmx_pciercx_cfg004_s cn63xx;
+	struct cvmx_pciercx_cfg004_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg005 {
@@ -276,6 +211,8 @@ union cvmx_pciercx_cfg005 {
 	struct cvmx_pciercx_cfg005_s cn52xxp1;
 	struct cvmx_pciercx_cfg005_s cn56xx;
 	struct cvmx_pciercx_cfg005_s cn56xxp1;
+	struct cvmx_pciercx_cfg005_s cn63xx;
+	struct cvmx_pciercx_cfg005_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg006 {
@@ -290,6 +227,8 @@ union cvmx_pciercx_cfg006 {
 	struct cvmx_pciercx_cfg006_s cn52xxp1;
 	struct cvmx_pciercx_cfg006_s cn56xx;
 	struct cvmx_pciercx_cfg006_s cn56xxp1;
+	struct cvmx_pciercx_cfg006_s cn63xx;
+	struct cvmx_pciercx_cfg006_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg007 {
@@ -317,6 +256,8 @@ union cvmx_pciercx_cfg007 {
 	struct cvmx_pciercx_cfg007_s cn52xxp1;
 	struct cvmx_pciercx_cfg007_s cn56xx;
 	struct cvmx_pciercx_cfg007_s cn56xxp1;
+	struct cvmx_pciercx_cfg007_s cn63xx;
+	struct cvmx_pciercx_cfg007_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg008 {
@@ -331,6 +272,8 @@ union cvmx_pciercx_cfg008 {
 	struct cvmx_pciercx_cfg008_s cn52xxp1;
 	struct cvmx_pciercx_cfg008_s cn56xx;
 	struct cvmx_pciercx_cfg008_s cn56xxp1;
+	struct cvmx_pciercx_cfg008_s cn63xx;
+	struct cvmx_pciercx_cfg008_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg009 {
@@ -347,6 +290,8 @@ union cvmx_pciercx_cfg009 {
 	struct cvmx_pciercx_cfg009_s cn52xxp1;
 	struct cvmx_pciercx_cfg009_s cn56xx;
 	struct cvmx_pciercx_cfg009_s cn56xxp1;
+	struct cvmx_pciercx_cfg009_s cn63xx;
+	struct cvmx_pciercx_cfg009_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg010 {
@@ -358,6 +303,8 @@ union cvmx_pciercx_cfg010 {
 	struct cvmx_pciercx_cfg010_s cn52xxp1;
 	struct cvmx_pciercx_cfg010_s cn56xx;
 	struct cvmx_pciercx_cfg010_s cn56xxp1;
+	struct cvmx_pciercx_cfg010_s cn63xx;
+	struct cvmx_pciercx_cfg010_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg011 {
@@ -369,6 +316,8 @@ union cvmx_pciercx_cfg011 {
 	struct cvmx_pciercx_cfg011_s cn52xxp1;
 	struct cvmx_pciercx_cfg011_s cn56xx;
 	struct cvmx_pciercx_cfg011_s cn56xxp1;
+	struct cvmx_pciercx_cfg011_s cn63xx;
+	struct cvmx_pciercx_cfg011_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg012 {
@@ -381,6 +330,8 @@ union cvmx_pciercx_cfg012 {
 	struct cvmx_pciercx_cfg012_s cn52xxp1;
 	struct cvmx_pciercx_cfg012_s cn56xx;
 	struct cvmx_pciercx_cfg012_s cn56xxp1;
+	struct cvmx_pciercx_cfg012_s cn63xx;
+	struct cvmx_pciercx_cfg012_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg013 {
@@ -393,6 +344,8 @@ union cvmx_pciercx_cfg013 {
 	struct cvmx_pciercx_cfg013_s cn52xxp1;
 	struct cvmx_pciercx_cfg013_s cn56xx;
 	struct cvmx_pciercx_cfg013_s cn56xxp1;
+	struct cvmx_pciercx_cfg013_s cn63xx;
+	struct cvmx_pciercx_cfg013_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg014 {
@@ -404,6 +357,8 @@ union cvmx_pciercx_cfg014 {
 	struct cvmx_pciercx_cfg014_s cn52xxp1;
 	struct cvmx_pciercx_cfg014_s cn56xx;
 	struct cvmx_pciercx_cfg014_s cn56xxp1;
+	struct cvmx_pciercx_cfg014_s cn63xx;
+	struct cvmx_pciercx_cfg014_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg015 {
@@ -429,6 +384,8 @@ union cvmx_pciercx_cfg015 {
 	struct cvmx_pciercx_cfg015_s cn52xxp1;
 	struct cvmx_pciercx_cfg015_s cn56xx;
 	struct cvmx_pciercx_cfg015_s cn56xxp1;
+	struct cvmx_pciercx_cfg015_s cn63xx;
+	struct cvmx_pciercx_cfg015_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg016 {
@@ -449,6 +406,8 @@ union cvmx_pciercx_cfg016 {
 	struct cvmx_pciercx_cfg016_s cn52xxp1;
 	struct cvmx_pciercx_cfg016_s cn56xx;
 	struct cvmx_pciercx_cfg016_s cn56xxp1;
+	struct cvmx_pciercx_cfg016_s cn63xx;
+	struct cvmx_pciercx_cfg016_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg017 {
@@ -471,6 +430,8 @@ union cvmx_pciercx_cfg017 {
 	struct cvmx_pciercx_cfg017_s cn52xxp1;
 	struct cvmx_pciercx_cfg017_s cn56xx;
 	struct cvmx_pciercx_cfg017_s cn56xxp1;
+	struct cvmx_pciercx_cfg017_s cn63xx;
+	struct cvmx_pciercx_cfg017_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg020 {
@@ -488,6 +449,8 @@ union cvmx_pciercx_cfg020 {
 	struct cvmx_pciercx_cfg020_s cn52xxp1;
 	struct cvmx_pciercx_cfg020_s cn56xx;
 	struct cvmx_pciercx_cfg020_s cn56xxp1;
+	struct cvmx_pciercx_cfg020_s cn63xx;
+	struct cvmx_pciercx_cfg020_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg021 {
@@ -500,6 +463,8 @@ union cvmx_pciercx_cfg021 {
 	struct cvmx_pciercx_cfg021_s cn52xxp1;
 	struct cvmx_pciercx_cfg021_s cn56xx;
 	struct cvmx_pciercx_cfg021_s cn56xxp1;
+	struct cvmx_pciercx_cfg021_s cn63xx;
+	struct cvmx_pciercx_cfg021_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg022 {
@@ -511,6 +476,8 @@ union cvmx_pciercx_cfg022 {
 	struct cvmx_pciercx_cfg022_s cn52xxp1;
 	struct cvmx_pciercx_cfg022_s cn56xx;
 	struct cvmx_pciercx_cfg022_s cn56xxp1;
+	struct cvmx_pciercx_cfg022_s cn63xx;
+	struct cvmx_pciercx_cfg022_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg023 {
@@ -523,6 +490,8 @@ union cvmx_pciercx_cfg023 {
 	struct cvmx_pciercx_cfg023_s cn52xxp1;
 	struct cvmx_pciercx_cfg023_s cn56xx;
 	struct cvmx_pciercx_cfg023_s cn56xxp1;
+	struct cvmx_pciercx_cfg023_s cn63xx;
+	struct cvmx_pciercx_cfg023_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg028 {
@@ -540,6 +509,8 @@ union cvmx_pciercx_cfg028 {
 	struct cvmx_pciercx_cfg028_s cn52xxp1;
 	struct cvmx_pciercx_cfg028_s cn56xx;
 	struct cvmx_pciercx_cfg028_s cn56xxp1;
+	struct cvmx_pciercx_cfg028_s cn63xx;
+	struct cvmx_pciercx_cfg028_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg029 {
@@ -561,6 +532,8 @@ union cvmx_pciercx_cfg029 {
 	struct cvmx_pciercx_cfg029_s cn52xxp1;
 	struct cvmx_pciercx_cfg029_s cn56xx;
 	struct cvmx_pciercx_cfg029_s cn56xxp1;
+	struct cvmx_pciercx_cfg029_s cn63xx;
+	struct cvmx_pciercx_cfg029_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg030 {
@@ -590,6 +563,8 @@ union cvmx_pciercx_cfg030 {
 	struct cvmx_pciercx_cfg030_s cn52xxp1;
 	struct cvmx_pciercx_cfg030_s cn56xx;
 	struct cvmx_pciercx_cfg030_s cn56xxp1;
+	struct cvmx_pciercx_cfg030_s cn63xx;
+	struct cvmx_pciercx_cfg030_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg031 {
@@ -611,6 +586,8 @@ union cvmx_pciercx_cfg031 {
 	struct cvmx_pciercx_cfg031_s cn52xxp1;
 	struct cvmx_pciercx_cfg031_s cn56xx;
 	struct cvmx_pciercx_cfg031_s cn56xxp1;
+	struct cvmx_pciercx_cfg031_s cn63xx;
+	struct cvmx_pciercx_cfg031_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg032 {
@@ -641,6 +618,8 @@ union cvmx_pciercx_cfg032 {
 	struct cvmx_pciercx_cfg032_s cn52xxp1;
 	struct cvmx_pciercx_cfg032_s cn56xx;
 	struct cvmx_pciercx_cfg032_s cn56xxp1;
+	struct cvmx_pciercx_cfg032_s cn63xx;
+	struct cvmx_pciercx_cfg032_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg033 {
@@ -663,6 +642,8 @@ union cvmx_pciercx_cfg033 {
 	struct cvmx_pciercx_cfg033_s cn52xxp1;
 	struct cvmx_pciercx_cfg033_s cn56xx;
 	struct cvmx_pciercx_cfg033_s cn56xxp1;
+	struct cvmx_pciercx_cfg033_s cn63xx;
+	struct cvmx_pciercx_cfg033_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg034 {
@@ -695,6 +676,8 @@ union cvmx_pciercx_cfg034 {
 	struct cvmx_pciercx_cfg034_s cn52xxp1;
 	struct cvmx_pciercx_cfg034_s cn56xx;
 	struct cvmx_pciercx_cfg034_s cn56xxp1;
+	struct cvmx_pciercx_cfg034_s cn63xx;
+	struct cvmx_pciercx_cfg034_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg035 {
@@ -713,6 +696,8 @@ union cvmx_pciercx_cfg035 {
 	struct cvmx_pciercx_cfg035_s cn52xxp1;
 	struct cvmx_pciercx_cfg035_s cn56xx;
 	struct cvmx_pciercx_cfg035_s cn56xxp1;
+	struct cvmx_pciercx_cfg035_s cn63xx;
+	struct cvmx_pciercx_cfg035_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg036 {
@@ -727,6 +712,8 @@ union cvmx_pciercx_cfg036 {
 	struct cvmx_pciercx_cfg036_s cn52xxp1;
 	struct cvmx_pciercx_cfg036_s cn56xx;
 	struct cvmx_pciercx_cfg036_s cn56xxp1;
+	struct cvmx_pciercx_cfg036_s cn63xx;
+	struct cvmx_pciercx_cfg036_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg037 {
@@ -740,6 +727,8 @@ union cvmx_pciercx_cfg037 {
 	struct cvmx_pciercx_cfg037_s cn52xxp1;
 	struct cvmx_pciercx_cfg037_s cn56xx;
 	struct cvmx_pciercx_cfg037_s cn56xxp1;
+	struct cvmx_pciercx_cfg037_s cn63xx;
+	struct cvmx_pciercx_cfg037_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg038 {
@@ -753,28 +742,51 @@ union cvmx_pciercx_cfg038 {
 	struct cvmx_pciercx_cfg038_s cn52xxp1;
 	struct cvmx_pciercx_cfg038_s cn56xx;
 	struct cvmx_pciercx_cfg038_s cn56xxp1;
+	struct cvmx_pciercx_cfg038_s cn63xx;
+	struct cvmx_pciercx_cfg038_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg039 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg039_s {
-		uint32_t reserved_0_31:32;
+		uint32_t reserved_9_31:23;
+		uint32_t cls:1;
+		uint32_t slsv:7;
+		uint32_t reserved_0_0:1;
 	} s;
-	struct cvmx_pciercx_cfg039_s cn52xx;
-	struct cvmx_pciercx_cfg039_s cn52xxp1;
-	struct cvmx_pciercx_cfg039_s cn56xx;
-	struct cvmx_pciercx_cfg039_s cn56xxp1;
+	struct cvmx_pciercx_cfg039_cn52xx {
+		uint32_t reserved_0_31:32;
+	} cn52xx;
+	struct cvmx_pciercx_cfg039_cn52xx cn52xxp1;
+	struct cvmx_pciercx_cfg039_cn52xx cn56xx;
+	struct cvmx_pciercx_cfg039_cn52xx cn56xxp1;
+	struct cvmx_pciercx_cfg039_s cn63xx;
+	struct cvmx_pciercx_cfg039_cn52xx cn63xxp1;
 };
 
 union cvmx_pciercx_cfg040 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg040_s {
+		uint32_t reserved_17_31:15;
+		uint32_t cdl:1;
+		uint32_t reserved_13_15:3;
+		uint32_t cde:1;
+		uint32_t csos:1;
+		uint32_t emc:1;
+		uint32_t tm:3;
+		uint32_t sde:1;
+		uint32_t hasd:1;
+		uint32_t ec:1;
+		uint32_t tls:4;
+	} s;
+	struct cvmx_pciercx_cfg040_cn52xx {
 		uint32_t reserved_0_31:32;
-	} s;
-	struct cvmx_pciercx_cfg040_s cn52xx;
-	struct cvmx_pciercx_cfg040_s cn52xxp1;
-	struct cvmx_pciercx_cfg040_s cn56xx;
-	struct cvmx_pciercx_cfg040_s cn56xxp1;
+	} cn52xx;
+	struct cvmx_pciercx_cfg040_cn52xx cn52xxp1;
+	struct cvmx_pciercx_cfg040_cn52xx cn56xx;
+	struct cvmx_pciercx_cfg040_cn52xx cn56xxp1;
+	struct cvmx_pciercx_cfg040_s cn63xx;
+	struct cvmx_pciercx_cfg040_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg041 {
@@ -786,6 +798,8 @@ union cvmx_pciercx_cfg041 {
 	struct cvmx_pciercx_cfg041_s cn52xxp1;
 	struct cvmx_pciercx_cfg041_s cn56xx;
 	struct cvmx_pciercx_cfg041_s cn56xxp1;
+	struct cvmx_pciercx_cfg041_s cn63xx;
+	struct cvmx_pciercx_cfg041_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg042 {
@@ -797,6 +811,8 @@ union cvmx_pciercx_cfg042 {
 	struct cvmx_pciercx_cfg042_s cn52xxp1;
 	struct cvmx_pciercx_cfg042_s cn56xx;
 	struct cvmx_pciercx_cfg042_s cn56xxp1;
+	struct cvmx_pciercx_cfg042_s cn63xx;
+	struct cvmx_pciercx_cfg042_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg064 {
@@ -810,6 +826,8 @@ union cvmx_pciercx_cfg064 {
 	struct cvmx_pciercx_cfg064_s cn52xxp1;
 	struct cvmx_pciercx_cfg064_s cn56xx;
 	struct cvmx_pciercx_cfg064_s cn56xxp1;
+	struct cvmx_pciercx_cfg064_s cn63xx;
+	struct cvmx_pciercx_cfg064_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg065 {
@@ -834,6 +852,8 @@ union cvmx_pciercx_cfg065 {
 	struct cvmx_pciercx_cfg065_s cn52xxp1;
 	struct cvmx_pciercx_cfg065_s cn56xx;
 	struct cvmx_pciercx_cfg065_s cn56xxp1;
+	struct cvmx_pciercx_cfg065_s cn63xx;
+	struct cvmx_pciercx_cfg065_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg066 {
@@ -858,6 +878,8 @@ union cvmx_pciercx_cfg066 {
 	struct cvmx_pciercx_cfg066_s cn52xxp1;
 	struct cvmx_pciercx_cfg066_s cn56xx;
 	struct cvmx_pciercx_cfg066_s cn56xxp1;
+	struct cvmx_pciercx_cfg066_s cn63xx;
+	struct cvmx_pciercx_cfg066_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg067 {
@@ -882,6 +904,8 @@ union cvmx_pciercx_cfg067 {
 	struct cvmx_pciercx_cfg067_s cn52xxp1;
 	struct cvmx_pciercx_cfg067_s cn56xx;
 	struct cvmx_pciercx_cfg067_s cn56xxp1;
+	struct cvmx_pciercx_cfg067_s cn63xx;
+	struct cvmx_pciercx_cfg067_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg068 {
@@ -901,6 +925,8 @@ union cvmx_pciercx_cfg068 {
 	struct cvmx_pciercx_cfg068_s cn52xxp1;
 	struct cvmx_pciercx_cfg068_s cn56xx;
 	struct cvmx_pciercx_cfg068_s cn56xxp1;
+	struct cvmx_pciercx_cfg068_s cn63xx;
+	struct cvmx_pciercx_cfg068_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg069 {
@@ -920,6 +946,8 @@ union cvmx_pciercx_cfg069 {
 	struct cvmx_pciercx_cfg069_s cn52xxp1;
 	struct cvmx_pciercx_cfg069_s cn56xx;
 	struct cvmx_pciercx_cfg069_s cn56xxp1;
+	struct cvmx_pciercx_cfg069_s cn63xx;
+	struct cvmx_pciercx_cfg069_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg070 {
@@ -936,6 +964,8 @@ union cvmx_pciercx_cfg070 {
 	struct cvmx_pciercx_cfg070_s cn52xxp1;
 	struct cvmx_pciercx_cfg070_s cn56xx;
 	struct cvmx_pciercx_cfg070_s cn56xxp1;
+	struct cvmx_pciercx_cfg070_s cn63xx;
+	struct cvmx_pciercx_cfg070_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg071 {
@@ -947,6 +977,8 @@ union cvmx_pciercx_cfg071 {
 	struct cvmx_pciercx_cfg071_s cn52xxp1;
 	struct cvmx_pciercx_cfg071_s cn56xx;
 	struct cvmx_pciercx_cfg071_s cn56xxp1;
+	struct cvmx_pciercx_cfg071_s cn63xx;
+	struct cvmx_pciercx_cfg071_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg072 {
@@ -958,6 +990,8 @@ union cvmx_pciercx_cfg072 {
 	struct cvmx_pciercx_cfg072_s cn52xxp1;
 	struct cvmx_pciercx_cfg072_s cn56xx;
 	struct cvmx_pciercx_cfg072_s cn56xxp1;
+	struct cvmx_pciercx_cfg072_s cn63xx;
+	struct cvmx_pciercx_cfg072_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg073 {
@@ -969,6 +1003,8 @@ union cvmx_pciercx_cfg073 {
 	struct cvmx_pciercx_cfg073_s cn52xxp1;
 	struct cvmx_pciercx_cfg073_s cn56xx;
 	struct cvmx_pciercx_cfg073_s cn56xxp1;
+	struct cvmx_pciercx_cfg073_s cn63xx;
+	struct cvmx_pciercx_cfg073_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg074 {
@@ -980,6 +1016,8 @@ union cvmx_pciercx_cfg074 {
 	struct cvmx_pciercx_cfg074_s cn52xxp1;
 	struct cvmx_pciercx_cfg074_s cn56xx;
 	struct cvmx_pciercx_cfg074_s cn56xxp1;
+	struct cvmx_pciercx_cfg074_s cn63xx;
+	struct cvmx_pciercx_cfg074_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg075 {
@@ -994,6 +1032,8 @@ union cvmx_pciercx_cfg075 {
 	struct cvmx_pciercx_cfg075_s cn52xxp1;
 	struct cvmx_pciercx_cfg075_s cn56xx;
 	struct cvmx_pciercx_cfg075_s cn56xxp1;
+	struct cvmx_pciercx_cfg075_s cn63xx;
+	struct cvmx_pciercx_cfg075_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg076 {
@@ -1013,6 +1053,8 @@ union cvmx_pciercx_cfg076 {
 	struct cvmx_pciercx_cfg076_s cn52xxp1;
 	struct cvmx_pciercx_cfg076_s cn56xx;
 	struct cvmx_pciercx_cfg076_s cn56xxp1;
+	struct cvmx_pciercx_cfg076_s cn63xx;
+	struct cvmx_pciercx_cfg076_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg077 {
@@ -1025,6 +1067,8 @@ union cvmx_pciercx_cfg077 {
 	struct cvmx_pciercx_cfg077_s cn52xxp1;
 	struct cvmx_pciercx_cfg077_s cn56xx;
 	struct cvmx_pciercx_cfg077_s cn56xxp1;
+	struct cvmx_pciercx_cfg077_s cn63xx;
+	struct cvmx_pciercx_cfg077_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg448 {
@@ -1037,6 +1081,8 @@ union cvmx_pciercx_cfg448 {
 	struct cvmx_pciercx_cfg448_s cn52xxp1;
 	struct cvmx_pciercx_cfg448_s cn56xx;
 	struct cvmx_pciercx_cfg448_s cn56xxp1;
+	struct cvmx_pciercx_cfg448_s cn63xx;
+	struct cvmx_pciercx_cfg448_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg449 {
@@ -1048,6 +1094,8 @@ union cvmx_pciercx_cfg449 {
 	struct cvmx_pciercx_cfg449_s cn52xxp1;
 	struct cvmx_pciercx_cfg449_s cn56xx;
 	struct cvmx_pciercx_cfg449_s cn56xxp1;
+	struct cvmx_pciercx_cfg449_s cn63xx;
+	struct cvmx_pciercx_cfg449_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg450 {
@@ -1064,6 +1112,8 @@ union cvmx_pciercx_cfg450 {
 	struct cvmx_pciercx_cfg450_s cn52xxp1;
 	struct cvmx_pciercx_cfg450_s cn56xx;
 	struct cvmx_pciercx_cfg450_s cn56xxp1;
+	struct cvmx_pciercx_cfg450_s cn63xx;
+	struct cvmx_pciercx_cfg450_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg451 {
@@ -1080,6 +1130,8 @@ union cvmx_pciercx_cfg451 {
 	struct cvmx_pciercx_cfg451_s cn52xxp1;
 	struct cvmx_pciercx_cfg451_s cn56xx;
 	struct cvmx_pciercx_cfg451_s cn56xxp1;
+	struct cvmx_pciercx_cfg451_s cn63xx;
+	struct cvmx_pciercx_cfg451_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg452 {
@@ -1103,6 +1155,8 @@ union cvmx_pciercx_cfg452 {
 	struct cvmx_pciercx_cfg452_s cn52xxp1;
 	struct cvmx_pciercx_cfg452_s cn56xx;
 	struct cvmx_pciercx_cfg452_s cn56xxp1;
+	struct cvmx_pciercx_cfg452_s cn63xx;
+	struct cvmx_pciercx_cfg452_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg453 {
@@ -1118,6 +1172,8 @@ union cvmx_pciercx_cfg453 {
 	struct cvmx_pciercx_cfg453_s cn52xxp1;
 	struct cvmx_pciercx_cfg453_s cn56xx;
 	struct cvmx_pciercx_cfg453_s cn56xxp1;
+	struct cvmx_pciercx_cfg453_s cn63xx;
+	struct cvmx_pciercx_cfg453_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg454 {
@@ -1136,6 +1192,8 @@ union cvmx_pciercx_cfg454 {
 	struct cvmx_pciercx_cfg454_s cn52xxp1;
 	struct cvmx_pciercx_cfg454_s cn56xx;
 	struct cvmx_pciercx_cfg454_s cn56xxp1;
+	struct cvmx_pciercx_cfg454_s cn63xx;
+	struct cvmx_pciercx_cfg454_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg455 {
@@ -1165,6 +1223,8 @@ union cvmx_pciercx_cfg455 {
 	struct cvmx_pciercx_cfg455_s cn52xxp1;
 	struct cvmx_pciercx_cfg455_s cn56xx;
 	struct cvmx_pciercx_cfg455_s cn56xxp1;
+	struct cvmx_pciercx_cfg455_s cn63xx;
+	struct cvmx_pciercx_cfg455_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg456 {
@@ -1178,6 +1238,8 @@ union cvmx_pciercx_cfg456 {
 	struct cvmx_pciercx_cfg456_s cn52xxp1;
 	struct cvmx_pciercx_cfg456_s cn56xx;
 	struct cvmx_pciercx_cfg456_s cn56xxp1;
+	struct cvmx_pciercx_cfg456_s cn63xx;
+	struct cvmx_pciercx_cfg456_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg458 {
@@ -1189,6 +1251,8 @@ union cvmx_pciercx_cfg458 {
 	struct cvmx_pciercx_cfg458_s cn52xxp1;
 	struct cvmx_pciercx_cfg458_s cn56xx;
 	struct cvmx_pciercx_cfg458_s cn56xxp1;
+	struct cvmx_pciercx_cfg458_s cn63xx;
+	struct cvmx_pciercx_cfg458_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg459 {
@@ -1200,6 +1264,8 @@ union cvmx_pciercx_cfg459 {
 	struct cvmx_pciercx_cfg459_s cn52xxp1;
 	struct cvmx_pciercx_cfg459_s cn56xx;
 	struct cvmx_pciercx_cfg459_s cn56xxp1;
+	struct cvmx_pciercx_cfg459_s cn63xx;
+	struct cvmx_pciercx_cfg459_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg460 {
@@ -1213,6 +1279,8 @@ union cvmx_pciercx_cfg460 {
 	struct cvmx_pciercx_cfg460_s cn52xxp1;
 	struct cvmx_pciercx_cfg460_s cn56xx;
 	struct cvmx_pciercx_cfg460_s cn56xxp1;
+	struct cvmx_pciercx_cfg460_s cn63xx;
+	struct cvmx_pciercx_cfg460_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg461 {
@@ -1226,6 +1294,8 @@ union cvmx_pciercx_cfg461 {
 	struct cvmx_pciercx_cfg461_s cn52xxp1;
 	struct cvmx_pciercx_cfg461_s cn56xx;
 	struct cvmx_pciercx_cfg461_s cn56xxp1;
+	struct cvmx_pciercx_cfg461_s cn63xx;
+	struct cvmx_pciercx_cfg461_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg462 {
@@ -1239,6 +1309,8 @@ union cvmx_pciercx_cfg462 {
 	struct cvmx_pciercx_cfg462_s cn52xxp1;
 	struct cvmx_pciercx_cfg462_s cn56xx;
 	struct cvmx_pciercx_cfg462_s cn56xxp1;
+	struct cvmx_pciercx_cfg462_s cn63xx;
+	struct cvmx_pciercx_cfg462_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg463 {
@@ -1253,6 +1325,8 @@ union cvmx_pciercx_cfg463 {
 	struct cvmx_pciercx_cfg463_s cn52xxp1;
 	struct cvmx_pciercx_cfg463_s cn56xx;
 	struct cvmx_pciercx_cfg463_s cn56xxp1;
+	struct cvmx_pciercx_cfg463_s cn63xx;
+	struct cvmx_pciercx_cfg463_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg464 {
@@ -1267,6 +1341,8 @@ union cvmx_pciercx_cfg464 {
 	struct cvmx_pciercx_cfg464_s cn52xxp1;
 	struct cvmx_pciercx_cfg464_s cn56xx;
 	struct cvmx_pciercx_cfg464_s cn56xxp1;
+	struct cvmx_pciercx_cfg464_s cn63xx;
+	struct cvmx_pciercx_cfg464_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg465 {
@@ -1281,6 +1357,8 @@ union cvmx_pciercx_cfg465 {
 	struct cvmx_pciercx_cfg465_s cn52xxp1;
 	struct cvmx_pciercx_cfg465_s cn56xx;
 	struct cvmx_pciercx_cfg465_s cn56xxp1;
+	struct cvmx_pciercx_cfg465_s cn63xx;
+	struct cvmx_pciercx_cfg465_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg466 {
@@ -1298,6 +1376,8 @@ union cvmx_pciercx_cfg466 {
 	struct cvmx_pciercx_cfg466_s cn52xxp1;
 	struct cvmx_pciercx_cfg466_s cn56xx;
 	struct cvmx_pciercx_cfg466_s cn56xxp1;
+	struct cvmx_pciercx_cfg466_s cn63xx;
+	struct cvmx_pciercx_cfg466_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg467 {
@@ -1313,6 +1393,8 @@ union cvmx_pciercx_cfg467 {
 	struct cvmx_pciercx_cfg467_s cn52xxp1;
 	struct cvmx_pciercx_cfg467_s cn56xx;
 	struct cvmx_pciercx_cfg467_s cn56xxp1;
+	struct cvmx_pciercx_cfg467_s cn63xx;
+	struct cvmx_pciercx_cfg467_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg468 {
@@ -1328,6 +1410,8 @@ union cvmx_pciercx_cfg468 {
 	struct cvmx_pciercx_cfg468_s cn52xxp1;
 	struct cvmx_pciercx_cfg468_s cn56xx;
 	struct cvmx_pciercx_cfg468_s cn56xxp1;
+	struct cvmx_pciercx_cfg468_s cn63xx;
+	struct cvmx_pciercx_cfg468_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg490 {
@@ -1342,6 +1426,8 @@ union cvmx_pciercx_cfg490 {
 	struct cvmx_pciercx_cfg490_s cn52xxp1;
 	struct cvmx_pciercx_cfg490_s cn56xx;
 	struct cvmx_pciercx_cfg490_s cn56xxp1;
+	struct cvmx_pciercx_cfg490_s cn63xx;
+	struct cvmx_pciercx_cfg490_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg491 {
@@ -1356,6 +1442,8 @@ union cvmx_pciercx_cfg491 {
 	struct cvmx_pciercx_cfg491_s cn52xxp1;
 	struct cvmx_pciercx_cfg491_s cn56xx;
 	struct cvmx_pciercx_cfg491_s cn56xxp1;
+	struct cvmx_pciercx_cfg491_s cn63xx;
+	struct cvmx_pciercx_cfg491_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg492 {
@@ -1370,6 +1458,23 @@ union cvmx_pciercx_cfg492 {
 	struct cvmx_pciercx_cfg492_s cn52xxp1;
 	struct cvmx_pciercx_cfg492_s cn56xx;
 	struct cvmx_pciercx_cfg492_s cn56xxp1;
+	struct cvmx_pciercx_cfg492_s cn63xx;
+	struct cvmx_pciercx_cfg492_s cn63xxp1;
+};
+
+union cvmx_pciercx_cfg515 {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg515_s {
+		uint32_t reserved_21_31:11;
+		uint32_t s_d_e:1;
+		uint32_t ctcrb:1;
+		uint32_t cpyts:1;
+		uint32_t dsc:1;
+		uint32_t le:9;
+		uint32_t n_fts:8;
+	} s;
+	struct cvmx_pciercx_cfg515_s cn63xx;
+	struct cvmx_pciercx_cfg515_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg516 {
@@ -1381,6 +1486,8 @@ union cvmx_pciercx_cfg516 {
 	struct cvmx_pciercx_cfg516_s cn52xxp1;
 	struct cvmx_pciercx_cfg516_s cn56xx;
 	struct cvmx_pciercx_cfg516_s cn56xxp1;
+	struct cvmx_pciercx_cfg516_s cn63xx;
+	struct cvmx_pciercx_cfg516_s cn63xxp1;
 };
 
 union cvmx_pciercx_cfg517 {
@@ -1392,6 +1499,8 @@ union cvmx_pciercx_cfg517 {
 	struct cvmx_pciercx_cfg517_s cn52xxp1;
 	struct cvmx_pciercx_cfg517_s cn56xx;
 	struct cvmx_pciercx_cfg517_s cn56xxp1;
+	struct cvmx_pciercx_cfg517_s cn63xx;
+	struct cvmx_pciercx_cfg517_s cn63xxp1;
 };
 
 #endif
diff --git a/arch/mips/include/asm/octeon/cvmx-pescx-defs.h b/arch/mips/include/asm/octeon/cvmx-pescx-defs.h
index f40cfaf..aef8485 100644
--- a/arch/mips/include/asm/octeon/cvmx-pescx-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-pescx-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2010 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -28,38 +28,22 @@
 #ifndef __CVMX_PESCX_DEFS_H__
 #define __CVMX_PESCX_DEFS_H__
 
-#define CVMX_PESCX_BIST_STATUS(block_id) \
-	 CVMX_ADD_IO_SEG(0x00011800C8000018ull + (((block_id) & 1) * 0x8000000ull))
-#define CVMX_PESCX_BIST_STATUS2(block_id) \
-	 CVMX_ADD_IO_SEG(0x00011800C8000418ull + (((block_id) & 1) * 0x8000000ull))
-#define CVMX_PESCX_CFG_RD(block_id) \
-	 CVMX_ADD_IO_SEG(0x00011800C8000030ull + (((block_id) & 1) * 0x8000000ull))
-#define CVMX_PESCX_CFG_WR(block_id) \
-	 CVMX_ADD_IO_SEG(0x00011800C8000028ull + (((block_id) & 1) * 0x8000000ull))
-#define CVMX_PESCX_CPL_LUT_VALID(block_id) \
-	 CVMX_ADD_IO_SEG(0x00011800C8000098ull + (((block_id) & 1) * 0x8000000ull))
-#define CVMX_PESCX_CTL_STATUS(block_id) \
-	 CVMX_ADD_IO_SEG(0x00011800C8000000ull + (((block_id) & 1) * 0x8000000ull))
-#define CVMX_PESCX_CTL_STATUS2(block_id) \
-	 CVMX_ADD_IO_SEG(0x00011800C8000400ull + (((block_id) & 1) * 0x8000000ull))
-#define CVMX_PESCX_DBG_INFO(block_id) \
-	 CVMX_ADD_IO_SEG(0x00011800C8000008ull + (((block_id) & 1) * 0x8000000ull))
-#define CVMX_PESCX_DBG_INFO_EN(block_id) \
-	 CVMX_ADD_IO_SEG(0x00011800C80000A0ull + (((block_id) & 1) * 0x8000000ull))
-#define CVMX_PESCX_DIAG_STATUS(block_id) \
-	 CVMX_ADD_IO_SEG(0x00011800C8000020ull + (((block_id) & 1) * 0x8000000ull))
-#define CVMX_PESCX_P2N_BAR0_START(block_id) \
-	 CVMX_ADD_IO_SEG(0x00011800C8000080ull + (((block_id) & 1) * 0x8000000ull))
-#define CVMX_PESCX_P2N_BAR1_START(block_id) \
-	 CVMX_ADD_IO_SEG(0x00011800C8000088ull + (((block_id) & 1) * 0x8000000ull))
-#define CVMX_PESCX_P2N_BAR2_START(block_id) \
-	 CVMX_ADD_IO_SEG(0x00011800C8000090ull + (((block_id) & 1) * 0x8000000ull))
-#define CVMX_PESCX_P2P_BARX_END(offset, block_id) \
-	 CVMX_ADD_IO_SEG(0x00011800C8000048ull + (((offset) & 3) * 16) + (((block_id) & 1) * 0x8000000ull))
-#define CVMX_PESCX_P2P_BARX_START(offset, block_id) \
-	 CVMX_ADD_IO_SEG(0x00011800C8000040ull + (((offset) & 3) * 16) + (((block_id) & 1) * 0x8000000ull))
-#define CVMX_PESCX_TLP_CREDITS(block_id) \
-	 CVMX_ADD_IO_SEG(0x00011800C8000038ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PESCX_BIST_STATUS(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000018ull) + ((block_id) & 1) * 0x8000000ull)
+#define CVMX_PESCX_BIST_STATUS2(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000418ull) + ((block_id) & 1) * 0x8000000ull)
+#define CVMX_PESCX_CFG_RD(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000030ull) + ((block_id) & 1) * 0x8000000ull)
+#define CVMX_PESCX_CFG_WR(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000028ull) + ((block_id) & 1) * 0x8000000ull)
+#define CVMX_PESCX_CPL_LUT_VALID(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000098ull) + ((block_id) & 1) * 0x8000000ull)
+#define CVMX_PESCX_CTL_STATUS(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000000ull) + ((block_id) & 1) * 0x8000000ull)
+#define CVMX_PESCX_CTL_STATUS2(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000400ull) + ((block_id) & 1) * 0x8000000ull)
+#define CVMX_PESCX_DBG_INFO(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000008ull) + ((block_id) & 1) * 0x8000000ull)
+#define CVMX_PESCX_DBG_INFO_EN(block_id) (CVMX_ADD_IO_SEG(0x00011800C80000A0ull) + ((block_id) & 1) * 0x8000000ull)
+#define CVMX_PESCX_DIAG_STATUS(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000020ull) + ((block_id) & 1) * 0x8000000ull)
+#define CVMX_PESCX_P2N_BAR0_START(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000080ull) + ((block_id) & 1) * 0x8000000ull)
+#define CVMX_PESCX_P2N_BAR1_START(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000088ull) + ((block_id) & 1) * 0x8000000ull)
+#define CVMX_PESCX_P2N_BAR2_START(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000090ull) + ((block_id) & 1) * 0x8000000ull)
+#define CVMX_PESCX_P2P_BARX_END(offset, block_id) (CVMX_ADD_IO_SEG(0x00011800C8000048ull) + (((offset) & 3) + ((block_id) & 1) * 0x800000ull) * 16)
+#define CVMX_PESCX_P2P_BARX_START(offset, block_id) (CVMX_ADD_IO_SEG(0x00011800C8000040ull) + (((offset) & 3) + ((block_id) & 1) * 0x800000ull) * 16)
+#define CVMX_PESCX_TLP_CREDITS(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000038ull) + ((block_id) & 1) * 0x8000000ull)
 
 union cvmx_pescx_bist_status {
 	uint64_t u64;
diff --git a/arch/mips/include/asm/octeon/cvmx-pexp-defs.h b/arch/mips/include/asm/octeon/cvmx-pexp-defs.h
index 5ea5dc5..5ab8679 100644
--- a/arch/mips/include/asm/octeon/cvmx-pexp-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-pexp-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2010 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -35,195 +35,191 @@
 #ifndef __CVMX_PEXP_DEFS_H__
 #define __CVMX_PEXP_DEFS_H__
 
-#define CVMX_PEXP_NPEI_BAR1_INDEXX(offset) \
-	 CVMX_ADD_IO_SEG(0x00011F0000008000ull + (((offset) & 31) * 16))
-#define CVMX_PEXP_NPEI_BIST_STATUS \
-	 CVMX_ADD_IO_SEG(0x00011F0000008580ull)
-#define CVMX_PEXP_NPEI_BIST_STATUS2 \
-	 CVMX_ADD_IO_SEG(0x00011F0000008680ull)
-#define CVMX_PEXP_NPEI_CTL_PORT0 \
-	 CVMX_ADD_IO_SEG(0x00011F0000008250ull)
-#define CVMX_PEXP_NPEI_CTL_PORT1 \
-	 CVMX_ADD_IO_SEG(0x00011F0000008260ull)
-#define CVMX_PEXP_NPEI_CTL_STATUS \
-	 CVMX_ADD_IO_SEG(0x00011F0000008570ull)
-#define CVMX_PEXP_NPEI_CTL_STATUS2 \
-	 CVMX_ADD_IO_SEG(0x00011F000000BC00ull)
-#define CVMX_PEXP_NPEI_DATA_OUT_CNT \
-	 CVMX_ADD_IO_SEG(0x00011F00000085F0ull)
-#define CVMX_PEXP_NPEI_DBG_DATA \
-	 CVMX_ADD_IO_SEG(0x00011F0000008510ull)
-#define CVMX_PEXP_NPEI_DBG_SELECT \
-	 CVMX_ADD_IO_SEG(0x00011F0000008500ull)
-#define CVMX_PEXP_NPEI_DMA0_INT_LEVEL \
-	 CVMX_ADD_IO_SEG(0x00011F00000085C0ull)
-#define CVMX_PEXP_NPEI_DMA1_INT_LEVEL \
-	 CVMX_ADD_IO_SEG(0x00011F00000085D0ull)
-#define CVMX_PEXP_NPEI_DMAX_COUNTS(offset) \
-	 CVMX_ADD_IO_SEG(0x00011F0000008450ull + (((offset) & 7) * 16))
-#define CVMX_PEXP_NPEI_DMAX_DBELL(offset) \
-	 CVMX_ADD_IO_SEG(0x00011F00000083B0ull + (((offset) & 7) * 16))
-#define CVMX_PEXP_NPEI_DMAX_IBUFF_SADDR(offset) \
-	 CVMX_ADD_IO_SEG(0x00011F0000008400ull + (((offset) & 7) * 16))
-#define CVMX_PEXP_NPEI_DMAX_NADDR(offset) \
-	 CVMX_ADD_IO_SEG(0x00011F00000084A0ull + (((offset) & 7) * 16))
-#define CVMX_PEXP_NPEI_DMA_CNTS \
-	 CVMX_ADD_IO_SEG(0x00011F00000085E0ull)
-#define CVMX_PEXP_NPEI_DMA_CONTROL \
-	 CVMX_ADD_IO_SEG(0x00011F00000083A0ull)
-#define CVMX_PEXP_NPEI_INT_A_ENB \
-	 CVMX_ADD_IO_SEG(0x00011F0000008560ull)
-#define CVMX_PEXP_NPEI_INT_A_ENB2 \
-	 CVMX_ADD_IO_SEG(0x00011F000000BCE0ull)
-#define CVMX_PEXP_NPEI_INT_A_SUM \
-	 CVMX_ADD_IO_SEG(0x00011F0000008550ull)
-#define CVMX_PEXP_NPEI_INT_ENB \
-	 CVMX_ADD_IO_SEG(0x00011F0000008540ull)
-#define CVMX_PEXP_NPEI_INT_ENB2 \
-	 CVMX_ADD_IO_SEG(0x00011F000000BCD0ull)
-#define CVMX_PEXP_NPEI_INT_INFO \
-	 CVMX_ADD_IO_SEG(0x00011F0000008590ull)
-#define CVMX_PEXP_NPEI_INT_SUM \
-	 CVMX_ADD_IO_SEG(0x00011F0000008530ull)
-#define CVMX_PEXP_NPEI_INT_SUM2 \
-	 CVMX_ADD_IO_SEG(0x00011F000000BCC0ull)
-#define CVMX_PEXP_NPEI_LAST_WIN_RDATA0 \
-	 CVMX_ADD_IO_SEG(0x00011F0000008600ull)
-#define CVMX_PEXP_NPEI_LAST_WIN_RDATA1 \
-	 CVMX_ADD_IO_SEG(0x00011F0000008610ull)
-#define CVMX_PEXP_NPEI_MEM_ACCESS_CTL \
-	 CVMX_ADD_IO_SEG(0x00011F00000084F0ull)
-#define CVMX_PEXP_NPEI_MEM_ACCESS_SUBIDX(offset) \
-	 CVMX_ADD_IO_SEG(0x00011F0000008280ull + (((offset) & 31) * 16) - 16 * 12)
-#define CVMX_PEXP_NPEI_MSI_ENB0 \
-	 CVMX_ADD_IO_SEG(0x00011F000000BC50ull)
-#define CVMX_PEXP_NPEI_MSI_ENB1 \
-	 CVMX_ADD_IO_SEG(0x00011F000000BC60ull)
-#define CVMX_PEXP_NPEI_MSI_ENB2 \
-	 CVMX_ADD_IO_SEG(0x00011F000000BC70ull)
-#define CVMX_PEXP_NPEI_MSI_ENB3 \
-	 CVMX_ADD_IO_SEG(0x00011F000000BC80ull)
-#define CVMX_PEXP_NPEI_MSI_RCV0 \
-	 CVMX_ADD_IO_SEG(0x00011F000000BC10ull)
-#define CVMX_PEXP_NPEI_MSI_RCV1 \
-	 CVMX_ADD_IO_SEG(0x00011F000000BC20ull)
-#define CVMX_PEXP_NPEI_MSI_RCV2 \
-	 CVMX_ADD_IO_SEG(0x00011F000000BC30ull)
-#define CVMX_PEXP_NPEI_MSI_RCV3 \
-	 CVMX_ADD_IO_SEG(0x00011F000000BC40ull)
-#define CVMX_PEXP_NPEI_MSI_RD_MAP \
-	 CVMX_ADD_IO_SEG(0x00011F000000BCA0ull)
-#define CVMX_PEXP_NPEI_MSI_W1C_ENB0 \
-	 CVMX_ADD_IO_SEG(0x00011F000000BCF0ull)
-#define CVMX_PEXP_NPEI_MSI_W1C_ENB1 \
-	 CVMX_ADD_IO_SEG(0x00011F000000BD00ull)
-#define CVMX_PEXP_NPEI_MSI_W1C_ENB2 \
-	 CVMX_ADD_IO_SEG(0x00011F000000BD10ull)
-#define CVMX_PEXP_NPEI_MSI_W1C_ENB3 \
-	 CVMX_ADD_IO_SEG(0x00011F000000BD20ull)
-#define CVMX_PEXP_NPEI_MSI_W1S_ENB0 \
-	 CVMX_ADD_IO_SEG(0x00011F000000BD30ull)
-#define CVMX_PEXP_NPEI_MSI_W1S_ENB1 \
-	 CVMX_ADD_IO_SEG(0x00011F000000BD40ull)
-#define CVMX_PEXP_NPEI_MSI_W1S_ENB2 \
-	 CVMX_ADD_IO_SEG(0x00011F000000BD50ull)
-#define CVMX_PEXP_NPEI_MSI_W1S_ENB3 \
-	 CVMX_ADD_IO_SEG(0x00011F000000BD60ull)
-#define CVMX_PEXP_NPEI_MSI_WR_MAP \
-	 CVMX_ADD_IO_SEG(0x00011F000000BC90ull)
-#define CVMX_PEXP_NPEI_PCIE_CREDIT_CNT \
-	 CVMX_ADD_IO_SEG(0x00011F000000BD70ull)
-#define CVMX_PEXP_NPEI_PCIE_MSI_RCV \
-	 CVMX_ADD_IO_SEG(0x00011F000000BCB0ull)
-#define CVMX_PEXP_NPEI_PCIE_MSI_RCV_B1 \
-	 CVMX_ADD_IO_SEG(0x00011F0000008650ull)
-#define CVMX_PEXP_NPEI_PCIE_MSI_RCV_B2 \
-	 CVMX_ADD_IO_SEG(0x00011F0000008660ull)
-#define CVMX_PEXP_NPEI_PCIE_MSI_RCV_B3 \
-	 CVMX_ADD_IO_SEG(0x00011F0000008670ull)
-#define CVMX_PEXP_NPEI_PKTX_CNTS(offset) \
-	 CVMX_ADD_IO_SEG(0x00011F000000A400ull + (((offset) & 31) * 16))
-#define CVMX_PEXP_NPEI_PKTX_INSTR_BADDR(offset) \
-	 CVMX_ADD_IO_SEG(0x00011F000000A800ull + (((offset) & 31) * 16))
-#define CVMX_PEXP_NPEI_PKTX_INSTR_BAOFF_DBELL(offset) \
-	 CVMX_ADD_IO_SEG(0x00011F000000AC00ull + (((offset) & 31) * 16))
-#define CVMX_PEXP_NPEI_PKTX_INSTR_FIFO_RSIZE(offset) \
-	 CVMX_ADD_IO_SEG(0x00011F000000B000ull + (((offset) & 31) * 16))
-#define CVMX_PEXP_NPEI_PKTX_INSTR_HEADER(offset) \
-	 CVMX_ADD_IO_SEG(0x00011F000000B400ull + (((offset) & 31) * 16))
-#define CVMX_PEXP_NPEI_PKTX_IN_BP(offset) \
-	 CVMX_ADD_IO_SEG(0x00011F000000B800ull + (((offset) & 31) * 16))
-#define CVMX_PEXP_NPEI_PKTX_SLIST_BADDR(offset) \
-	 CVMX_ADD_IO_SEG(0x00011F0000009400ull + (((offset) & 31) * 16))
-#define CVMX_PEXP_NPEI_PKTX_SLIST_BAOFF_DBELL(offset) \
-	 CVMX_ADD_IO_SEG(0x00011F0000009800ull + (((offset) & 31) * 16))
-#define CVMX_PEXP_NPEI_PKTX_SLIST_FIFO_RSIZE(offset) \
-	 CVMX_ADD_IO_SEG(0x00011F0000009C00ull + (((offset) & 31) * 16))
-#define CVMX_PEXP_NPEI_PKT_CNT_INT \
-	 CVMX_ADD_IO_SEG(0x00011F0000009110ull)
-#define CVMX_PEXP_NPEI_PKT_CNT_INT_ENB \
-	 CVMX_ADD_IO_SEG(0x00011F0000009130ull)
-#define CVMX_PEXP_NPEI_PKT_DATA_OUT_ES \
-	 CVMX_ADD_IO_SEG(0x00011F00000090B0ull)
-#define CVMX_PEXP_NPEI_PKT_DATA_OUT_NS \
-	 CVMX_ADD_IO_SEG(0x00011F00000090A0ull)
-#define CVMX_PEXP_NPEI_PKT_DATA_OUT_ROR \
-	 CVMX_ADD_IO_SEG(0x00011F0000009090ull)
-#define CVMX_PEXP_NPEI_PKT_DPADDR \
-	 CVMX_ADD_IO_SEG(0x00011F0000009080ull)
-#define CVMX_PEXP_NPEI_PKT_INPUT_CONTROL \
-	 CVMX_ADD_IO_SEG(0x00011F0000009150ull)
-#define CVMX_PEXP_NPEI_PKT_INSTR_ENB \
-	 CVMX_ADD_IO_SEG(0x00011F0000009000ull)
-#define CVMX_PEXP_NPEI_PKT_INSTR_RD_SIZE \
-	 CVMX_ADD_IO_SEG(0x00011F0000009190ull)
-#define CVMX_PEXP_NPEI_PKT_INSTR_SIZE \
-	 CVMX_ADD_IO_SEG(0x00011F0000009020ull)
-#define CVMX_PEXP_NPEI_PKT_INT_LEVELS \
-	 CVMX_ADD_IO_SEG(0x00011F0000009100ull)
-#define CVMX_PEXP_NPEI_PKT_IN_BP \
-	 CVMX_ADD_IO_SEG(0x00011F00000086B0ull)
-#define CVMX_PEXP_NPEI_PKT_IN_DONEX_CNTS(offset) \
-	 CVMX_ADD_IO_SEG(0x00011F000000A000ull + (((offset) & 31) * 16))
-#define CVMX_PEXP_NPEI_PKT_IN_INSTR_COUNTS \
-	 CVMX_ADD_IO_SEG(0x00011F00000086A0ull)
-#define CVMX_PEXP_NPEI_PKT_IN_PCIE_PORT \
-	 CVMX_ADD_IO_SEG(0x00011F00000091A0ull)
-#define CVMX_PEXP_NPEI_PKT_IPTR \
-	 CVMX_ADD_IO_SEG(0x00011F0000009070ull)
-#define CVMX_PEXP_NPEI_PKT_OUTPUT_WMARK \
-	 CVMX_ADD_IO_SEG(0x00011F0000009160ull)
-#define CVMX_PEXP_NPEI_PKT_OUT_BMODE \
-	 CVMX_ADD_IO_SEG(0x00011F00000090D0ull)
-#define CVMX_PEXP_NPEI_PKT_OUT_ENB \
-	 CVMX_ADD_IO_SEG(0x00011F0000009010ull)
-#define CVMX_PEXP_NPEI_PKT_PCIE_PORT \
-	 CVMX_ADD_IO_SEG(0x00011F00000090E0ull)
-#define CVMX_PEXP_NPEI_PKT_PORT_IN_RST \
-	 CVMX_ADD_IO_SEG(0x00011F0000008690ull)
-#define CVMX_PEXP_NPEI_PKT_SLIST_ES \
-	 CVMX_ADD_IO_SEG(0x00011F0000009050ull)
-#define CVMX_PEXP_NPEI_PKT_SLIST_ID_SIZE \
-	 CVMX_ADD_IO_SEG(0x00011F0000009180ull)
-#define CVMX_PEXP_NPEI_PKT_SLIST_NS \
-	 CVMX_ADD_IO_SEG(0x00011F0000009040ull)
-#define CVMX_PEXP_NPEI_PKT_SLIST_ROR \
-	 CVMX_ADD_IO_SEG(0x00011F0000009030ull)
-#define CVMX_PEXP_NPEI_PKT_TIME_INT \
-	 CVMX_ADD_IO_SEG(0x00011F0000009120ull)
-#define CVMX_PEXP_NPEI_PKT_TIME_INT_ENB \
-	 CVMX_ADD_IO_SEG(0x00011F0000009140ull)
-#define CVMX_PEXP_NPEI_RSL_INT_BLOCKS \
-	 CVMX_ADD_IO_SEG(0x00011F0000008520ull)
-#define CVMX_PEXP_NPEI_SCRATCH_1 \
-	 CVMX_ADD_IO_SEG(0x00011F0000008270ull)
-#define CVMX_PEXP_NPEI_STATE1 \
-	 CVMX_ADD_IO_SEG(0x00011F0000008620ull)
-#define CVMX_PEXP_NPEI_STATE2 \
-	 CVMX_ADD_IO_SEG(0x00011F0000008630ull)
-#define CVMX_PEXP_NPEI_STATE3 \
-	 CVMX_ADD_IO_SEG(0x00011F0000008640ull)
-#define CVMX_PEXP_NPEI_WINDOW_CTL \
-	 CVMX_ADD_IO_SEG(0x00011F0000008380ull)
+#define CVMX_PEXP_NPEI_BAR1_INDEXX(offset) (CVMX_ADD_IO_SEG(0x00011F0000008000ull) + ((offset) & 31) * 16)
+#define CVMX_PEXP_NPEI_BIST_STATUS (CVMX_ADD_IO_SEG(0x00011F0000008580ull))
+#define CVMX_PEXP_NPEI_BIST_STATUS2 (CVMX_ADD_IO_SEG(0x00011F0000008680ull))
+#define CVMX_PEXP_NPEI_CTL_PORT0 (CVMX_ADD_IO_SEG(0x00011F0000008250ull))
+#define CVMX_PEXP_NPEI_CTL_PORT1 (CVMX_ADD_IO_SEG(0x00011F0000008260ull))
+#define CVMX_PEXP_NPEI_CTL_STATUS (CVMX_ADD_IO_SEG(0x00011F0000008570ull))
+#define CVMX_PEXP_NPEI_CTL_STATUS2 (CVMX_ADD_IO_SEG(0x00011F000000BC00ull))
+#define CVMX_PEXP_NPEI_DATA_OUT_CNT (CVMX_ADD_IO_SEG(0x00011F00000085F0ull))
+#define CVMX_PEXP_NPEI_DBG_DATA (CVMX_ADD_IO_SEG(0x00011F0000008510ull))
+#define CVMX_PEXP_NPEI_DBG_SELECT (CVMX_ADD_IO_SEG(0x00011F0000008500ull))
+#define CVMX_PEXP_NPEI_DMA0_INT_LEVEL (CVMX_ADD_IO_SEG(0x00011F00000085C0ull))
+#define CVMX_PEXP_NPEI_DMA1_INT_LEVEL (CVMX_ADD_IO_SEG(0x00011F00000085D0ull))
+#define CVMX_PEXP_NPEI_DMAX_COUNTS(offset) (CVMX_ADD_IO_SEG(0x00011F0000008450ull) + ((offset) & 7) * 16)
+#define CVMX_PEXP_NPEI_DMAX_DBELL(offset) (CVMX_ADD_IO_SEG(0x00011F00000083B0ull) + ((offset) & 7) * 16)
+#define CVMX_PEXP_NPEI_DMAX_IBUFF_SADDR(offset) (CVMX_ADD_IO_SEG(0x00011F0000008400ull) + ((offset) & 7) * 16)
+#define CVMX_PEXP_NPEI_DMAX_NADDR(offset) (CVMX_ADD_IO_SEG(0x00011F00000084A0ull) + ((offset) & 7) * 16)
+#define CVMX_PEXP_NPEI_DMA_CNTS (CVMX_ADD_IO_SEG(0x00011F00000085E0ull))
+#define CVMX_PEXP_NPEI_DMA_CONTROL (CVMX_ADD_IO_SEG(0x00011F00000083A0ull))
+#define CVMX_PEXP_NPEI_DMA_PCIE_REQ_NUM (CVMX_ADD_IO_SEG(0x00011F00000085B0ull))
+#define CVMX_PEXP_NPEI_DMA_STATE1 (CVMX_ADD_IO_SEG(0x00011F00000086C0ull))
+#define CVMX_PEXP_NPEI_DMA_STATE1_P1 (CVMX_ADD_IO_SEG(0x00011F0000008680ull))
+#define CVMX_PEXP_NPEI_DMA_STATE2 (CVMX_ADD_IO_SEG(0x00011F00000086D0ull))
+#define CVMX_PEXP_NPEI_DMA_STATE2_P1 (CVMX_ADD_IO_SEG(0x00011F0000008690ull))
+#define CVMX_PEXP_NPEI_DMA_STATE3_P1 (CVMX_ADD_IO_SEG(0x00011F00000086A0ull))
+#define CVMX_PEXP_NPEI_DMA_STATE4_P1 (CVMX_ADD_IO_SEG(0x00011F00000086B0ull))
+#define CVMX_PEXP_NPEI_DMA_STATE5_P1 (CVMX_ADD_IO_SEG(0x00011F00000086C0ull))
+#define CVMX_PEXP_NPEI_INT_A_ENB (CVMX_ADD_IO_SEG(0x00011F0000008560ull))
+#define CVMX_PEXP_NPEI_INT_A_ENB2 (CVMX_ADD_IO_SEG(0x00011F000000BCE0ull))
+#define CVMX_PEXP_NPEI_INT_A_SUM (CVMX_ADD_IO_SEG(0x00011F0000008550ull))
+#define CVMX_PEXP_NPEI_INT_ENB (CVMX_ADD_IO_SEG(0x00011F0000008540ull))
+#define CVMX_PEXP_NPEI_INT_ENB2 (CVMX_ADD_IO_SEG(0x00011F000000BCD0ull))
+#define CVMX_PEXP_NPEI_INT_INFO (CVMX_ADD_IO_SEG(0x00011F0000008590ull))
+#define CVMX_PEXP_NPEI_INT_SUM (CVMX_ADD_IO_SEG(0x00011F0000008530ull))
+#define CVMX_PEXP_NPEI_INT_SUM2 (CVMX_ADD_IO_SEG(0x00011F000000BCC0ull))
+#define CVMX_PEXP_NPEI_LAST_WIN_RDATA0 (CVMX_ADD_IO_SEG(0x00011F0000008600ull))
+#define CVMX_PEXP_NPEI_LAST_WIN_RDATA1 (CVMX_ADD_IO_SEG(0x00011F0000008610ull))
+#define CVMX_PEXP_NPEI_MEM_ACCESS_CTL (CVMX_ADD_IO_SEG(0x00011F00000084F0ull))
+#define CVMX_PEXP_NPEI_MEM_ACCESS_SUBIDX(offset) (CVMX_ADD_IO_SEG(0x00011F0000008280ull) + ((offset) & 31) * 16 - 16*12)
+#define CVMX_PEXP_NPEI_MSI_ENB0 (CVMX_ADD_IO_SEG(0x00011F000000BC50ull))
+#define CVMX_PEXP_NPEI_MSI_ENB1 (CVMX_ADD_IO_SEG(0x00011F000000BC60ull))
+#define CVMX_PEXP_NPEI_MSI_ENB2 (CVMX_ADD_IO_SEG(0x00011F000000BC70ull))
+#define CVMX_PEXP_NPEI_MSI_ENB3 (CVMX_ADD_IO_SEG(0x00011F000000BC80ull))
+#define CVMX_PEXP_NPEI_MSI_RCV0 (CVMX_ADD_IO_SEG(0x00011F000000BC10ull))
+#define CVMX_PEXP_NPEI_MSI_RCV1 (CVMX_ADD_IO_SEG(0x00011F000000BC20ull))
+#define CVMX_PEXP_NPEI_MSI_RCV2 (CVMX_ADD_IO_SEG(0x00011F000000BC30ull))
+#define CVMX_PEXP_NPEI_MSI_RCV3 (CVMX_ADD_IO_SEG(0x00011F000000BC40ull))
+#define CVMX_PEXP_NPEI_MSI_RD_MAP (CVMX_ADD_IO_SEG(0x00011F000000BCA0ull))
+#define CVMX_PEXP_NPEI_MSI_W1C_ENB0 (CVMX_ADD_IO_SEG(0x00011F000000BCF0ull))
+#define CVMX_PEXP_NPEI_MSI_W1C_ENB1 (CVMX_ADD_IO_SEG(0x00011F000000BD00ull))
+#define CVMX_PEXP_NPEI_MSI_W1C_ENB2 (CVMX_ADD_IO_SEG(0x00011F000000BD10ull))
+#define CVMX_PEXP_NPEI_MSI_W1C_ENB3 (CVMX_ADD_IO_SEG(0x00011F000000BD20ull))
+#define CVMX_PEXP_NPEI_MSI_W1S_ENB0 (CVMX_ADD_IO_SEG(0x00011F000000BD30ull))
+#define CVMX_PEXP_NPEI_MSI_W1S_ENB1 (CVMX_ADD_IO_SEG(0x00011F000000BD40ull))
+#define CVMX_PEXP_NPEI_MSI_W1S_ENB2 (CVMX_ADD_IO_SEG(0x00011F000000BD50ull))
+#define CVMX_PEXP_NPEI_MSI_W1S_ENB3 (CVMX_ADD_IO_SEG(0x00011F000000BD60ull))
+#define CVMX_PEXP_NPEI_MSI_WR_MAP (CVMX_ADD_IO_SEG(0x00011F000000BC90ull))
+#define CVMX_PEXP_NPEI_PCIE_CREDIT_CNT (CVMX_ADD_IO_SEG(0x00011F000000BD70ull))
+#define CVMX_PEXP_NPEI_PCIE_MSI_RCV (CVMX_ADD_IO_SEG(0x00011F000000BCB0ull))
+#define CVMX_PEXP_NPEI_PCIE_MSI_RCV_B1 (CVMX_ADD_IO_SEG(0x00011F0000008650ull))
+#define CVMX_PEXP_NPEI_PCIE_MSI_RCV_B2 (CVMX_ADD_IO_SEG(0x00011F0000008660ull))
+#define CVMX_PEXP_NPEI_PCIE_MSI_RCV_B3 (CVMX_ADD_IO_SEG(0x00011F0000008670ull))
+#define CVMX_PEXP_NPEI_PKTX_CNTS(offset) (CVMX_ADD_IO_SEG(0x00011F000000A400ull) + ((offset) & 31) * 16)
+#define CVMX_PEXP_NPEI_PKTX_INSTR_BADDR(offset) (CVMX_ADD_IO_SEG(0x00011F000000A800ull) + ((offset) & 31) * 16)
+#define CVMX_PEXP_NPEI_PKTX_INSTR_BAOFF_DBELL(offset) (CVMX_ADD_IO_SEG(0x00011F000000AC00ull) + ((offset) & 31) * 16)
+#define CVMX_PEXP_NPEI_PKTX_INSTR_FIFO_RSIZE(offset) (CVMX_ADD_IO_SEG(0x00011F000000B000ull) + ((offset) & 31) * 16)
+#define CVMX_PEXP_NPEI_PKTX_INSTR_HEADER(offset) (CVMX_ADD_IO_SEG(0x00011F000000B400ull) + ((offset) & 31) * 16)
+#define CVMX_PEXP_NPEI_PKTX_IN_BP(offset) (CVMX_ADD_IO_SEG(0x00011F000000B800ull) + ((offset) & 31) * 16)
+#define CVMX_PEXP_NPEI_PKTX_SLIST_BADDR(offset) (CVMX_ADD_IO_SEG(0x00011F0000009400ull) + ((offset) & 31) * 16)
+#define CVMX_PEXP_NPEI_PKTX_SLIST_BAOFF_DBELL(offset) (CVMX_ADD_IO_SEG(0x00011F0000009800ull) + ((offset) & 31) * 16)
+#define CVMX_PEXP_NPEI_PKTX_SLIST_FIFO_RSIZE(offset) (CVMX_ADD_IO_SEG(0x00011F0000009C00ull) + ((offset) & 31) * 16)
+#define CVMX_PEXP_NPEI_PKT_CNT_INT (CVMX_ADD_IO_SEG(0x00011F0000009110ull))
+#define CVMX_PEXP_NPEI_PKT_CNT_INT_ENB (CVMX_ADD_IO_SEG(0x00011F0000009130ull))
+#define CVMX_PEXP_NPEI_PKT_DATA_OUT_ES (CVMX_ADD_IO_SEG(0x00011F00000090B0ull))
+#define CVMX_PEXP_NPEI_PKT_DATA_OUT_NS (CVMX_ADD_IO_SEG(0x00011F00000090A0ull))
+#define CVMX_PEXP_NPEI_PKT_DATA_OUT_ROR (CVMX_ADD_IO_SEG(0x00011F0000009090ull))
+#define CVMX_PEXP_NPEI_PKT_DPADDR (CVMX_ADD_IO_SEG(0x00011F0000009080ull))
+#define CVMX_PEXP_NPEI_PKT_INPUT_CONTROL (CVMX_ADD_IO_SEG(0x00011F0000009150ull))
+#define CVMX_PEXP_NPEI_PKT_INSTR_ENB (CVMX_ADD_IO_SEG(0x00011F0000009000ull))
+#define CVMX_PEXP_NPEI_PKT_INSTR_RD_SIZE (CVMX_ADD_IO_SEG(0x00011F0000009190ull))
+#define CVMX_PEXP_NPEI_PKT_INSTR_SIZE (CVMX_ADD_IO_SEG(0x00011F0000009020ull))
+#define CVMX_PEXP_NPEI_PKT_INT_LEVELS (CVMX_ADD_IO_SEG(0x00011F0000009100ull))
+#define CVMX_PEXP_NPEI_PKT_IN_BP (CVMX_ADD_IO_SEG(0x00011F00000086B0ull))
+#define CVMX_PEXP_NPEI_PKT_IN_DONEX_CNTS(offset) (CVMX_ADD_IO_SEG(0x00011F000000A000ull) + ((offset) & 31) * 16)
+#define CVMX_PEXP_NPEI_PKT_IN_INSTR_COUNTS (CVMX_ADD_IO_SEG(0x00011F00000086A0ull))
+#define CVMX_PEXP_NPEI_PKT_IN_PCIE_PORT (CVMX_ADD_IO_SEG(0x00011F00000091A0ull))
+#define CVMX_PEXP_NPEI_PKT_IPTR (CVMX_ADD_IO_SEG(0x00011F0000009070ull))
+#define CVMX_PEXP_NPEI_PKT_OUTPUT_WMARK (CVMX_ADD_IO_SEG(0x00011F0000009160ull))
+#define CVMX_PEXP_NPEI_PKT_OUT_BMODE (CVMX_ADD_IO_SEG(0x00011F00000090D0ull))
+#define CVMX_PEXP_NPEI_PKT_OUT_ENB (CVMX_ADD_IO_SEG(0x00011F0000009010ull))
+#define CVMX_PEXP_NPEI_PKT_PCIE_PORT (CVMX_ADD_IO_SEG(0x00011F00000090E0ull))
+#define CVMX_PEXP_NPEI_PKT_PORT_IN_RST (CVMX_ADD_IO_SEG(0x00011F0000008690ull))
+#define CVMX_PEXP_NPEI_PKT_SLIST_ES (CVMX_ADD_IO_SEG(0x00011F0000009050ull))
+#define CVMX_PEXP_NPEI_PKT_SLIST_ID_SIZE (CVMX_ADD_IO_SEG(0x00011F0000009180ull))
+#define CVMX_PEXP_NPEI_PKT_SLIST_NS (CVMX_ADD_IO_SEG(0x00011F0000009040ull))
+#define CVMX_PEXP_NPEI_PKT_SLIST_ROR (CVMX_ADD_IO_SEG(0x00011F0000009030ull))
+#define CVMX_PEXP_NPEI_PKT_TIME_INT (CVMX_ADD_IO_SEG(0x00011F0000009120ull))
+#define CVMX_PEXP_NPEI_PKT_TIME_INT_ENB (CVMX_ADD_IO_SEG(0x00011F0000009140ull))
+#define CVMX_PEXP_NPEI_RSL_INT_BLOCKS (CVMX_ADD_IO_SEG(0x00011F0000008520ull))
+#define CVMX_PEXP_NPEI_SCRATCH_1 (CVMX_ADD_IO_SEG(0x00011F0000008270ull))
+#define CVMX_PEXP_NPEI_STATE1 (CVMX_ADD_IO_SEG(0x00011F0000008620ull))
+#define CVMX_PEXP_NPEI_STATE2 (CVMX_ADD_IO_SEG(0x00011F0000008630ull))
+#define CVMX_PEXP_NPEI_STATE3 (CVMX_ADD_IO_SEG(0x00011F0000008640ull))
+#define CVMX_PEXP_NPEI_WINDOW_CTL (CVMX_ADD_IO_SEG(0x00011F0000008380ull))
+#define CVMX_PEXP_SLI_BIST_STATUS (CVMX_ADD_IO_SEG(0x00011F0000010580ull))
+#define CVMX_PEXP_SLI_CTL_PORTX(offset) (CVMX_ADD_IO_SEG(0x00011F0000010050ull) + ((offset) & 1) * 16)
+#define CVMX_PEXP_SLI_CTL_STATUS (CVMX_ADD_IO_SEG(0x00011F0000010570ull))
+#define CVMX_PEXP_SLI_DATA_OUT_CNT (CVMX_ADD_IO_SEG(0x00011F00000105F0ull))
+#define CVMX_PEXP_SLI_DBG_DATA (CVMX_ADD_IO_SEG(0x00011F0000010310ull))
+#define CVMX_PEXP_SLI_DBG_SELECT (CVMX_ADD_IO_SEG(0x00011F0000010300ull))
+#define CVMX_PEXP_SLI_DMAX_CNT(offset) (CVMX_ADD_IO_SEG(0x00011F0000010400ull) + ((offset) & 1) * 16)
+#define CVMX_PEXP_SLI_DMAX_INT_LEVEL(offset) (CVMX_ADD_IO_SEG(0x00011F00000103E0ull) + ((offset) & 1) * 16)
+#define CVMX_PEXP_SLI_DMAX_TIM(offset) (CVMX_ADD_IO_SEG(0x00011F0000010420ull) + ((offset) & 1) * 16)
+#define CVMX_PEXP_SLI_INT_ENB_CIU (CVMX_ADD_IO_SEG(0x00011F0000013CD0ull))
+#define CVMX_PEXP_SLI_INT_ENB_PORTX(offset) (CVMX_ADD_IO_SEG(0x00011F0000010340ull) + ((offset) & 1) * 16)
+#define CVMX_PEXP_SLI_INT_SUM (CVMX_ADD_IO_SEG(0x00011F0000010330ull))
+#define CVMX_PEXP_SLI_LAST_WIN_RDATA0 (CVMX_ADD_IO_SEG(0x00011F0000010600ull))
+#define CVMX_PEXP_SLI_LAST_WIN_RDATA1 (CVMX_ADD_IO_SEG(0x00011F0000010610ull))
+#define CVMX_PEXP_SLI_MAC_CREDIT_CNT (CVMX_ADD_IO_SEG(0x00011F0000013D70ull))
+#define CVMX_PEXP_SLI_MEM_ACCESS_CTL (CVMX_ADD_IO_SEG(0x00011F00000102F0ull))
+#define CVMX_PEXP_SLI_MEM_ACCESS_SUBIDX(offset) (CVMX_ADD_IO_SEG(0x00011F00000100E0ull) + ((offset) & 31) * 16 - 16*12)
+#define CVMX_PEXP_SLI_MSI_ENB0 (CVMX_ADD_IO_SEG(0x00011F0000013C50ull))
+#define CVMX_PEXP_SLI_MSI_ENB1 (CVMX_ADD_IO_SEG(0x00011F0000013C60ull))
+#define CVMX_PEXP_SLI_MSI_ENB2 (CVMX_ADD_IO_SEG(0x00011F0000013C70ull))
+#define CVMX_PEXP_SLI_MSI_ENB3 (CVMX_ADD_IO_SEG(0x00011F0000013C80ull))
+#define CVMX_PEXP_SLI_MSI_RCV0 (CVMX_ADD_IO_SEG(0x00011F0000013C10ull))
+#define CVMX_PEXP_SLI_MSI_RCV1 (CVMX_ADD_IO_SEG(0x00011F0000013C20ull))
+#define CVMX_PEXP_SLI_MSI_RCV2 (CVMX_ADD_IO_SEG(0x00011F0000013C30ull))
+#define CVMX_PEXP_SLI_MSI_RCV3 (CVMX_ADD_IO_SEG(0x00011F0000013C40ull))
+#define CVMX_PEXP_SLI_MSI_RD_MAP (CVMX_ADD_IO_SEG(0x00011F0000013CA0ull))
+#define CVMX_PEXP_SLI_MSI_W1C_ENB0 (CVMX_ADD_IO_SEG(0x00011F0000013CF0ull))
+#define CVMX_PEXP_SLI_MSI_W1C_ENB1 (CVMX_ADD_IO_SEG(0x00011F0000013D00ull))
+#define CVMX_PEXP_SLI_MSI_W1C_ENB2 (CVMX_ADD_IO_SEG(0x00011F0000013D10ull))
+#define CVMX_PEXP_SLI_MSI_W1C_ENB3 (CVMX_ADD_IO_SEG(0x00011F0000013D20ull))
+#define CVMX_PEXP_SLI_MSI_W1S_ENB0 (CVMX_ADD_IO_SEG(0x00011F0000013D30ull))
+#define CVMX_PEXP_SLI_MSI_W1S_ENB1 (CVMX_ADD_IO_SEG(0x00011F0000013D40ull))
+#define CVMX_PEXP_SLI_MSI_W1S_ENB2 (CVMX_ADD_IO_SEG(0x00011F0000013D50ull))
+#define CVMX_PEXP_SLI_MSI_W1S_ENB3 (CVMX_ADD_IO_SEG(0x00011F0000013D60ull))
+#define CVMX_PEXP_SLI_MSI_WR_MAP (CVMX_ADD_IO_SEG(0x00011F0000013C90ull))
+#define CVMX_PEXP_SLI_PCIE_MSI_RCV (CVMX_ADD_IO_SEG(0x00011F0000013CB0ull))
+#define CVMX_PEXP_SLI_PCIE_MSI_RCV_B1 (CVMX_ADD_IO_SEG(0x00011F0000010650ull))
+#define CVMX_PEXP_SLI_PCIE_MSI_RCV_B2 (CVMX_ADD_IO_SEG(0x00011F0000010660ull))
+#define CVMX_PEXP_SLI_PCIE_MSI_RCV_B3 (CVMX_ADD_IO_SEG(0x00011F0000010670ull))
+#define CVMX_PEXP_SLI_PKTX_CNTS(offset) (CVMX_ADD_IO_SEG(0x00011F0000012400ull) + ((offset) & 31) * 16)
+#define CVMX_PEXP_SLI_PKTX_INSTR_BADDR(offset) (CVMX_ADD_IO_SEG(0x00011F0000012800ull) + ((offset) & 31) * 16)
+#define CVMX_PEXP_SLI_PKTX_INSTR_BAOFF_DBELL(offset) (CVMX_ADD_IO_SEG(0x00011F0000012C00ull) + ((offset) & 31) * 16)
+#define CVMX_PEXP_SLI_PKTX_INSTR_FIFO_RSIZE(offset) (CVMX_ADD_IO_SEG(0x00011F0000013000ull) + ((offset) & 31) * 16)
+#define CVMX_PEXP_SLI_PKTX_INSTR_HEADER(offset) (CVMX_ADD_IO_SEG(0x00011F0000013400ull) + ((offset) & 31) * 16)
+#define CVMX_PEXP_SLI_PKTX_IN_BP(offset) (CVMX_ADD_IO_SEG(0x00011F0000013800ull) + ((offset) & 31) * 16)
+#define CVMX_PEXP_SLI_PKTX_OUT_SIZE(offset) (CVMX_ADD_IO_SEG(0x00011F0000010C00ull) + ((offset) & 31) * 16)
+#define CVMX_PEXP_SLI_PKTX_SLIST_BADDR(offset) (CVMX_ADD_IO_SEG(0x00011F0000011400ull) + ((offset) & 31) * 16)
+#define CVMX_PEXP_SLI_PKTX_SLIST_BAOFF_DBELL(offset) (CVMX_ADD_IO_SEG(0x00011F0000011800ull) + ((offset) & 31) * 16)
+#define CVMX_PEXP_SLI_PKTX_SLIST_FIFO_RSIZE(offset) (CVMX_ADD_IO_SEG(0x00011F0000011C00ull) + ((offset) & 31) * 16)
+#define CVMX_PEXP_SLI_PKT_CNT_INT (CVMX_ADD_IO_SEG(0x00011F0000011130ull))
+#define CVMX_PEXP_SLI_PKT_CNT_INT_ENB (CVMX_ADD_IO_SEG(0x00011F0000011150ull))
+#define CVMX_PEXP_SLI_PKT_CTL (CVMX_ADD_IO_SEG(0x00011F0000011220ull))
+#define CVMX_PEXP_SLI_PKT_DATA_OUT_ES (CVMX_ADD_IO_SEG(0x00011F00000110B0ull))
+#define CVMX_PEXP_SLI_PKT_DATA_OUT_NS (CVMX_ADD_IO_SEG(0x00011F00000110A0ull))
+#define CVMX_PEXP_SLI_PKT_DATA_OUT_ROR (CVMX_ADD_IO_SEG(0x00011F0000011090ull))
+#define CVMX_PEXP_SLI_PKT_DPADDR (CVMX_ADD_IO_SEG(0x00011F0000011080ull))
+#define CVMX_PEXP_SLI_PKT_INPUT_CONTROL (CVMX_ADD_IO_SEG(0x00011F0000011170ull))
+#define CVMX_PEXP_SLI_PKT_INSTR_ENB (CVMX_ADD_IO_SEG(0x00011F0000011000ull))
+#define CVMX_PEXP_SLI_PKT_INSTR_RD_SIZE (CVMX_ADD_IO_SEG(0x00011F00000111A0ull))
+#define CVMX_PEXP_SLI_PKT_INSTR_SIZE (CVMX_ADD_IO_SEG(0x00011F0000011020ull))
+#define CVMX_PEXP_SLI_PKT_INT_LEVELS (CVMX_ADD_IO_SEG(0x00011F0000011120ull))
+#define CVMX_PEXP_SLI_PKT_IN_BP (CVMX_ADD_IO_SEG(0x00011F0000011210ull))
+#define CVMX_PEXP_SLI_PKT_IN_DONEX_CNTS(offset) (CVMX_ADD_IO_SEG(0x00011F0000012000ull) + ((offset) & 31) * 16)
+#define CVMX_PEXP_SLI_PKT_IN_INSTR_COUNTS (CVMX_ADD_IO_SEG(0x00011F0000011200ull))
+#define CVMX_PEXP_SLI_PKT_IN_PCIE_PORT (CVMX_ADD_IO_SEG(0x00011F00000111B0ull))
+#define CVMX_PEXP_SLI_PKT_IPTR (CVMX_ADD_IO_SEG(0x00011F0000011070ull))
+#define CVMX_PEXP_SLI_PKT_OUTPUT_WMARK (CVMX_ADD_IO_SEG(0x00011F0000011180ull))
+#define CVMX_PEXP_SLI_PKT_OUT_BMODE (CVMX_ADD_IO_SEG(0x00011F00000110D0ull))
+#define CVMX_PEXP_SLI_PKT_OUT_ENB (CVMX_ADD_IO_SEG(0x00011F0000011010ull))
+#define CVMX_PEXP_SLI_PKT_PCIE_PORT (CVMX_ADD_IO_SEG(0x00011F00000110E0ull))
+#define CVMX_PEXP_SLI_PKT_PORT_IN_RST (CVMX_ADD_IO_SEG(0x00011F00000111F0ull))
+#define CVMX_PEXP_SLI_PKT_SLIST_ES (CVMX_ADD_IO_SEG(0x00011F0000011050ull))
+#define CVMX_PEXP_SLI_PKT_SLIST_NS (CVMX_ADD_IO_SEG(0x00011F0000011040ull))
+#define CVMX_PEXP_SLI_PKT_SLIST_ROR (CVMX_ADD_IO_SEG(0x00011F0000011030ull))
+#define CVMX_PEXP_SLI_PKT_TIME_INT (CVMX_ADD_IO_SEG(0x00011F0000011140ull))
+#define CVMX_PEXP_SLI_PKT_TIME_INT_ENB (CVMX_ADD_IO_SEG(0x00011F0000011160ull))
+#define CVMX_PEXP_SLI_S2M_PORTX_CTL(offset) (CVMX_ADD_IO_SEG(0x00011F0000013D80ull) + ((offset) & 1) * 16)
+#define CVMX_PEXP_SLI_SCRATCH_1 (CVMX_ADD_IO_SEG(0x00011F00000103C0ull))
+#define CVMX_PEXP_SLI_SCRATCH_2 (CVMX_ADD_IO_SEG(0x00011F00000103D0ull))
+#define CVMX_PEXP_SLI_STATE1 (CVMX_ADD_IO_SEG(0x00011F0000010620ull))
+#define CVMX_PEXP_SLI_STATE2 (CVMX_ADD_IO_SEG(0x00011F0000010630ull))
+#define CVMX_PEXP_SLI_STATE3 (CVMX_ADD_IO_SEG(0x00011F0000010640ull))
+#define CVMX_PEXP_SLI_WINDOW_CTL (CVMX_ADD_IO_SEG(0x00011F00000102E0ull))
 
 #endif
diff --git a/arch/mips/include/asm/octeon/cvmx-pow-defs.h b/arch/mips/include/asm/octeon/cvmx-pow-defs.h
index 2d82e24..39fd75b 100644
--- a/arch/mips/include/asm/octeon/cvmx-pow-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-pow-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2010 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -28,52 +28,29 @@
 #ifndef __CVMX_POW_DEFS_H__
 #define __CVMX_POW_DEFS_H__
 
-#define CVMX_POW_BIST_STAT \
-	 CVMX_ADD_IO_SEG(0x00016700000003F8ull)
-#define CVMX_POW_DS_PC \
-	 CVMX_ADD_IO_SEG(0x0001670000000398ull)
-#define CVMX_POW_ECC_ERR \
-	 CVMX_ADD_IO_SEG(0x0001670000000218ull)
-#define CVMX_POW_INT_CTL \
-	 CVMX_ADD_IO_SEG(0x0001670000000220ull)
-#define CVMX_POW_IQ_CNTX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001670000000340ull + (((offset) & 7) * 8))
-#define CVMX_POW_IQ_COM_CNT \
-	 CVMX_ADD_IO_SEG(0x0001670000000388ull)
-#define CVMX_POW_IQ_INT \
-	 CVMX_ADD_IO_SEG(0x0001670000000238ull)
-#define CVMX_POW_IQ_INT_EN \
-	 CVMX_ADD_IO_SEG(0x0001670000000240ull)
-#define CVMX_POW_IQ_THRX(offset) \
-	 CVMX_ADD_IO_SEG(0x00016700000003A0ull + (((offset) & 7) * 8))
-#define CVMX_POW_NOS_CNT \
-	 CVMX_ADD_IO_SEG(0x0001670000000228ull)
-#define CVMX_POW_NW_TIM \
-	 CVMX_ADD_IO_SEG(0x0001670000000210ull)
-#define CVMX_POW_PF_RST_MSK \
-	 CVMX_ADD_IO_SEG(0x0001670000000230ull)
-#define CVMX_POW_PP_GRP_MSKX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001670000000000ull + (((offset) & 15) * 8))
-#define CVMX_POW_QOS_RNDX(offset) \
-	 CVMX_ADD_IO_SEG(0x00016700000001C0ull + (((offset) & 7) * 8))
-#define CVMX_POW_QOS_THRX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001670000000180ull + (((offset) & 7) * 8))
-#define CVMX_POW_TS_PC \
-	 CVMX_ADD_IO_SEG(0x0001670000000390ull)
-#define CVMX_POW_WA_COM_PC \
-	 CVMX_ADD_IO_SEG(0x0001670000000380ull)
-#define CVMX_POW_WA_PCX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001670000000300ull + (((offset) & 7) * 8))
-#define CVMX_POW_WQ_INT \
-	 CVMX_ADD_IO_SEG(0x0001670000000200ull)
-#define CVMX_POW_WQ_INT_CNTX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001670000000100ull + (((offset) & 15) * 8))
-#define CVMX_POW_WQ_INT_PC \
-	 CVMX_ADD_IO_SEG(0x0001670000000208ull)
-#define CVMX_POW_WQ_INT_THRX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001670000000080ull + (((offset) & 15) * 8))
-#define CVMX_POW_WS_PCX(offset) \
-	 CVMX_ADD_IO_SEG(0x0001670000000280ull + (((offset) & 15) * 8))
+#define CVMX_POW_BIST_STAT (CVMX_ADD_IO_SEG(0x00016700000003F8ull))
+#define CVMX_POW_DS_PC (CVMX_ADD_IO_SEG(0x0001670000000398ull))
+#define CVMX_POW_ECC_ERR (CVMX_ADD_IO_SEG(0x0001670000000218ull))
+#define CVMX_POW_INT_CTL (CVMX_ADD_IO_SEG(0x0001670000000220ull))
+#define CVMX_POW_IQ_CNTX(offset) (CVMX_ADD_IO_SEG(0x0001670000000340ull) + ((offset) & 7) * 8)
+#define CVMX_POW_IQ_COM_CNT (CVMX_ADD_IO_SEG(0x0001670000000388ull))
+#define CVMX_POW_IQ_INT (CVMX_ADD_IO_SEG(0x0001670000000238ull))
+#define CVMX_POW_IQ_INT_EN (CVMX_ADD_IO_SEG(0x0001670000000240ull))
+#define CVMX_POW_IQ_THRX(offset) (CVMX_ADD_IO_SEG(0x00016700000003A0ull) + ((offset) & 7) * 8)
+#define CVMX_POW_NOS_CNT (CVMX_ADD_IO_SEG(0x0001670000000228ull))
+#define CVMX_POW_NW_TIM (CVMX_ADD_IO_SEG(0x0001670000000210ull))
+#define CVMX_POW_PF_RST_MSK (CVMX_ADD_IO_SEG(0x0001670000000230ull))
+#define CVMX_POW_PP_GRP_MSKX(offset) (CVMX_ADD_IO_SEG(0x0001670000000000ull) + ((offset) & 15) * 8)
+#define CVMX_POW_QOS_RNDX(offset) (CVMX_ADD_IO_SEG(0x00016700000001C0ull) + ((offset) & 7) * 8)
+#define CVMX_POW_QOS_THRX(offset) (CVMX_ADD_IO_SEG(0x0001670000000180ull) + ((offset) & 7) * 8)
+#define CVMX_POW_TS_PC (CVMX_ADD_IO_SEG(0x0001670000000390ull))
+#define CVMX_POW_WA_COM_PC (CVMX_ADD_IO_SEG(0x0001670000000380ull))
+#define CVMX_POW_WA_PCX(offset) (CVMX_ADD_IO_SEG(0x0001670000000300ull) + ((offset) & 7) * 8)
+#define CVMX_POW_WQ_INT (CVMX_ADD_IO_SEG(0x0001670000000200ull))
+#define CVMX_POW_WQ_INT_CNTX(offset) (CVMX_ADD_IO_SEG(0x0001670000000100ull) + ((offset) & 15) * 8)
+#define CVMX_POW_WQ_INT_PC (CVMX_ADD_IO_SEG(0x0001670000000208ull))
+#define CVMX_POW_WQ_INT_THRX(offset) (CVMX_ADD_IO_SEG(0x0001670000000080ull) + ((offset) & 15) * 8)
+#define CVMX_POW_WS_PCX(offset) (CVMX_ADD_IO_SEG(0x0001670000000280ull) + ((offset) & 15) * 8)
 
 union cvmx_pow_bist_stat {
 	uint64_t u64;
@@ -160,6 +137,19 @@ union cvmx_pow_bist_stat {
 	struct cvmx_pow_bist_stat_cn56xx cn56xxp1;
 	struct cvmx_pow_bist_stat_cn38xx cn58xx;
 	struct cvmx_pow_bist_stat_cn38xx cn58xxp1;
+	struct cvmx_pow_bist_stat_cn63xx {
+		uint64_t reserved_22_63:42;
+		uint64_t pp:6;
+		uint64_t reserved_12_15:4;
+		uint64_t cam:1;
+		uint64_t nbr:3;
+		uint64_t nbt:4;
+		uint64_t index:1;
+		uint64_t fidx:1;
+		uint64_t pend:1;
+		uint64_t adr:1;
+	} cn63xx;
+	struct cvmx_pow_bist_stat_cn63xx cn63xxp1;
 };
 
 union cvmx_pow_ds_pc {
@@ -179,6 +169,8 @@ union cvmx_pow_ds_pc {
 	struct cvmx_pow_ds_pc_s cn56xxp1;
 	struct cvmx_pow_ds_pc_s cn58xx;
 	struct cvmx_pow_ds_pc_s cn58xxp1;
+	struct cvmx_pow_ds_pc_s cn63xx;
+	struct cvmx_pow_ds_pc_s cn63xxp1;
 };
 
 union cvmx_pow_ecc_err {
@@ -219,6 +211,8 @@ union cvmx_pow_ecc_err {
 	struct cvmx_pow_ecc_err_s cn56xxp1;
 	struct cvmx_pow_ecc_err_s cn58xx;
 	struct cvmx_pow_ecc_err_s cn58xxp1;
+	struct cvmx_pow_ecc_err_s cn63xx;
+	struct cvmx_pow_ecc_err_s cn63xxp1;
 };
 
 union cvmx_pow_int_ctl {
@@ -239,6 +233,8 @@ union cvmx_pow_int_ctl {
 	struct cvmx_pow_int_ctl_s cn56xxp1;
 	struct cvmx_pow_int_ctl_s cn58xx;
 	struct cvmx_pow_int_ctl_s cn58xxp1;
+	struct cvmx_pow_int_ctl_s cn63xx;
+	struct cvmx_pow_int_ctl_s cn63xxp1;
 };
 
 union cvmx_pow_iq_cntx {
@@ -258,6 +254,8 @@ union cvmx_pow_iq_cntx {
 	struct cvmx_pow_iq_cntx_s cn56xxp1;
 	struct cvmx_pow_iq_cntx_s cn58xx;
 	struct cvmx_pow_iq_cntx_s cn58xxp1;
+	struct cvmx_pow_iq_cntx_s cn63xx;
+	struct cvmx_pow_iq_cntx_s cn63xxp1;
 };
 
 union cvmx_pow_iq_com_cnt {
@@ -277,6 +275,8 @@ union cvmx_pow_iq_com_cnt {
 	struct cvmx_pow_iq_com_cnt_s cn56xxp1;
 	struct cvmx_pow_iq_com_cnt_s cn58xx;
 	struct cvmx_pow_iq_com_cnt_s cn58xxp1;
+	struct cvmx_pow_iq_com_cnt_s cn63xx;
+	struct cvmx_pow_iq_com_cnt_s cn63xxp1;
 };
 
 union cvmx_pow_iq_int {
@@ -289,6 +289,8 @@ union cvmx_pow_iq_int {
 	struct cvmx_pow_iq_int_s cn52xxp1;
 	struct cvmx_pow_iq_int_s cn56xx;
 	struct cvmx_pow_iq_int_s cn56xxp1;
+	struct cvmx_pow_iq_int_s cn63xx;
+	struct cvmx_pow_iq_int_s cn63xxp1;
 };
 
 union cvmx_pow_iq_int_en {
@@ -301,6 +303,8 @@ union cvmx_pow_iq_int_en {
 	struct cvmx_pow_iq_int_en_s cn52xxp1;
 	struct cvmx_pow_iq_int_en_s cn56xx;
 	struct cvmx_pow_iq_int_en_s cn56xxp1;
+	struct cvmx_pow_iq_int_en_s cn63xx;
+	struct cvmx_pow_iq_int_en_s cn63xxp1;
 };
 
 union cvmx_pow_iq_thrx {
@@ -313,6 +317,8 @@ union cvmx_pow_iq_thrx {
 	struct cvmx_pow_iq_thrx_s cn52xxp1;
 	struct cvmx_pow_iq_thrx_s cn56xx;
 	struct cvmx_pow_iq_thrx_s cn56xxp1;
+	struct cvmx_pow_iq_thrx_s cn63xx;
+	struct cvmx_pow_iq_thrx_s cn63xxp1;
 };
 
 union cvmx_pow_nos_cnt {
@@ -341,6 +347,11 @@ union cvmx_pow_nos_cnt {
 	struct cvmx_pow_nos_cnt_s cn56xxp1;
 	struct cvmx_pow_nos_cnt_s cn58xx;
 	struct cvmx_pow_nos_cnt_s cn58xxp1;
+	struct cvmx_pow_nos_cnt_cn63xx {
+		uint64_t reserved_11_63:53;
+		uint64_t nos_cnt:11;
+	} cn63xx;
+	struct cvmx_pow_nos_cnt_cn63xx cn63xxp1;
 };
 
 union cvmx_pow_nw_tim {
@@ -360,6 +371,8 @@ union cvmx_pow_nw_tim {
 	struct cvmx_pow_nw_tim_s cn56xxp1;
 	struct cvmx_pow_nw_tim_s cn58xx;
 	struct cvmx_pow_nw_tim_s cn58xxp1;
+	struct cvmx_pow_nw_tim_s cn63xx;
+	struct cvmx_pow_nw_tim_s cn63xxp1;
 };
 
 union cvmx_pow_pf_rst_msk {
@@ -375,6 +388,8 @@ union cvmx_pow_pf_rst_msk {
 	struct cvmx_pow_pf_rst_msk_s cn56xxp1;
 	struct cvmx_pow_pf_rst_msk_s cn58xx;
 	struct cvmx_pow_pf_rst_msk_s cn58xxp1;
+	struct cvmx_pow_pf_rst_msk_s cn63xx;
+	struct cvmx_pow_pf_rst_msk_s cn63xxp1;
 };
 
 union cvmx_pow_pp_grp_mskx {
@@ -405,6 +420,8 @@ union cvmx_pow_pp_grp_mskx {
 	struct cvmx_pow_pp_grp_mskx_s cn56xxp1;
 	struct cvmx_pow_pp_grp_mskx_s cn58xx;
 	struct cvmx_pow_pp_grp_mskx_s cn58xxp1;
+	struct cvmx_pow_pp_grp_mskx_s cn63xx;
+	struct cvmx_pow_pp_grp_mskx_s cn63xxp1;
 };
 
 union cvmx_pow_qos_rndx {
@@ -427,6 +444,8 @@ union cvmx_pow_qos_rndx {
 	struct cvmx_pow_qos_rndx_s cn56xxp1;
 	struct cvmx_pow_qos_rndx_s cn58xx;
 	struct cvmx_pow_qos_rndx_s cn58xxp1;
+	struct cvmx_pow_qos_rndx_s cn63xx;
+	struct cvmx_pow_qos_rndx_s cn63xxp1;
 };
 
 union cvmx_pow_qos_thrx {
@@ -485,6 +504,19 @@ union cvmx_pow_qos_thrx {
 	struct cvmx_pow_qos_thrx_s cn56xxp1;
 	struct cvmx_pow_qos_thrx_s cn58xx;
 	struct cvmx_pow_qos_thrx_s cn58xxp1;
+	struct cvmx_pow_qos_thrx_cn63xx {
+		uint64_t reserved_59_63:5;
+		uint64_t des_cnt:11;
+		uint64_t reserved_47_47:1;
+		uint64_t buf_cnt:11;
+		uint64_t reserved_35_35:1;
+		uint64_t free_cnt:11;
+		uint64_t reserved_22_23:2;
+		uint64_t max_thr:10;
+		uint64_t reserved_10_11:2;
+		uint64_t min_thr:10;
+	} cn63xx;
+	struct cvmx_pow_qos_thrx_cn63xx cn63xxp1;
 };
 
 union cvmx_pow_ts_pc {
@@ -504,6 +536,8 @@ union cvmx_pow_ts_pc {
 	struct cvmx_pow_ts_pc_s cn56xxp1;
 	struct cvmx_pow_ts_pc_s cn58xx;
 	struct cvmx_pow_ts_pc_s cn58xxp1;
+	struct cvmx_pow_ts_pc_s cn63xx;
+	struct cvmx_pow_ts_pc_s cn63xxp1;
 };
 
 union cvmx_pow_wa_com_pc {
@@ -523,6 +557,8 @@ union cvmx_pow_wa_com_pc {
 	struct cvmx_pow_wa_com_pc_s cn56xxp1;
 	struct cvmx_pow_wa_com_pc_s cn58xx;
 	struct cvmx_pow_wa_com_pc_s cn58xxp1;
+	struct cvmx_pow_wa_com_pc_s cn63xx;
+	struct cvmx_pow_wa_com_pc_s cn63xxp1;
 };
 
 union cvmx_pow_wa_pcx {
@@ -542,6 +578,8 @@ union cvmx_pow_wa_pcx {
 	struct cvmx_pow_wa_pcx_s cn56xxp1;
 	struct cvmx_pow_wa_pcx_s cn58xx;
 	struct cvmx_pow_wa_pcx_s cn58xxp1;
+	struct cvmx_pow_wa_pcx_s cn63xx;
+	struct cvmx_pow_wa_pcx_s cn63xxp1;
 };
 
 union cvmx_pow_wq_int {
@@ -562,6 +600,8 @@ union cvmx_pow_wq_int {
 	struct cvmx_pow_wq_int_s cn56xxp1;
 	struct cvmx_pow_wq_int_s cn58xx;
 	struct cvmx_pow_wq_int_s cn58xxp1;
+	struct cvmx_pow_wq_int_s cn63xx;
+	struct cvmx_pow_wq_int_s cn63xxp1;
 };
 
 union cvmx_pow_wq_int_cntx {
@@ -604,6 +644,15 @@ union cvmx_pow_wq_int_cntx {
 	struct cvmx_pow_wq_int_cntx_s cn56xxp1;
 	struct cvmx_pow_wq_int_cntx_s cn58xx;
 	struct cvmx_pow_wq_int_cntx_s cn58xxp1;
+	struct cvmx_pow_wq_int_cntx_cn63xx {
+		uint64_t reserved_28_63:36;
+		uint64_t tc_cnt:4;
+		uint64_t reserved_23_23:1;
+		uint64_t ds_cnt:11;
+		uint64_t reserved_11_11:1;
+		uint64_t iq_cnt:11;
+	} cn63xx;
+	struct cvmx_pow_wq_int_cntx_cn63xx cn63xxp1;
 };
 
 union cvmx_pow_wq_int_pc {
@@ -626,6 +675,8 @@ union cvmx_pow_wq_int_pc {
 	struct cvmx_pow_wq_int_pc_s cn56xxp1;
 	struct cvmx_pow_wq_int_pc_s cn58xx;
 	struct cvmx_pow_wq_int_pc_s cn58xxp1;
+	struct cvmx_pow_wq_int_pc_s cn63xx;
+	struct cvmx_pow_wq_int_pc_s cn63xxp1;
 };
 
 union cvmx_pow_wq_int_thrx {
@@ -674,6 +725,16 @@ union cvmx_pow_wq_int_thrx {
 	struct cvmx_pow_wq_int_thrx_s cn56xxp1;
 	struct cvmx_pow_wq_int_thrx_s cn58xx;
 	struct cvmx_pow_wq_int_thrx_s cn58xxp1;
+	struct cvmx_pow_wq_int_thrx_cn63xx {
+		uint64_t reserved_29_63:35;
+		uint64_t tc_en:1;
+		uint64_t tc_thr:4;
+		uint64_t reserved_22_23:2;
+		uint64_t ds_thr:10;
+		uint64_t reserved_10_11:2;
+		uint64_t iq_thr:10;
+	} cn63xx;
+	struct cvmx_pow_wq_int_thrx_cn63xx cn63xxp1;
 };
 
 union cvmx_pow_ws_pcx {
@@ -693,6 +754,8 @@ union cvmx_pow_ws_pcx {
 	struct cvmx_pow_ws_pcx_s cn56xxp1;
 	struct cvmx_pow_ws_pcx_s cn58xx;
 	struct cvmx_pow_ws_pcx_s cn58xxp1;
+	struct cvmx_pow_ws_pcx_s cn63xx;
+	struct cvmx_pow_ws_pcx_s cn63xxp1;
 };
 
 #endif
diff --git a/arch/mips/include/asm/octeon/cvmx-rnm-defs.h b/arch/mips/include/asm/octeon/cvmx-rnm-defs.h
index 4586958..c45da1f 100644
--- a/arch/mips/include/asm/octeon/cvmx-rnm-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-rnm-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2010 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -30,10 +30,11 @@
 
 #include <linux/types.h>
 
-#define CVMX_RNM_BIST_STATUS \
-	 CVMX_ADD_IO_SEG(0x0001180040000008ull)
-#define CVMX_RNM_CTL_STATUS \
-	 CVMX_ADD_IO_SEG(0x0001180040000000ull)
+#define CVMX_RNM_BIST_STATUS (CVMX_ADD_IO_SEG(0x0001180040000008ull))
+#define CVMX_RNM_CTL_STATUS (CVMX_ADD_IO_SEG(0x0001180040000000ull))
+#define CVMX_RNM_EER_DBG (CVMX_ADD_IO_SEG(0x0001180040000018ull))
+#define CVMX_RNM_EER_KEY (CVMX_ADD_IO_SEG(0x0001180040000010ull))
+#define CVMX_RNM_SERIAL_NUM (CVMX_ADD_IO_SEG(0x0001180040000020ull))
 
 union cvmx_rnm_bist_status {
 	uint64_t u64;
@@ -53,12 +54,16 @@ union cvmx_rnm_bist_status {
 	struct cvmx_rnm_bist_status_s cn56xxp1;
 	struct cvmx_rnm_bist_status_s cn58xx;
 	struct cvmx_rnm_bist_status_s cn58xxp1;
+	struct cvmx_rnm_bist_status_s cn63xx;
+	struct cvmx_rnm_bist_status_s cn63xxp1;
 };
 
 union cvmx_rnm_ctl_status {
 	uint64_t u64;
 	struct cvmx_rnm_ctl_status_s {
-		uint64_t reserved_9_63:55;
+		uint64_t reserved_11_63:53;
+		uint64_t eer_lck:1;
+		uint64_t eer_val:1;
 		uint64_t ent_sel:4;
 		uint64_t exp_ent:1;
 		uint64_t rng_rst:1;
@@ -76,13 +81,49 @@ union cvmx_rnm_ctl_status {
 	struct cvmx_rnm_ctl_status_cn30xx cn31xx;
 	struct cvmx_rnm_ctl_status_cn30xx cn38xx;
 	struct cvmx_rnm_ctl_status_cn30xx cn38xxp2;
-	struct cvmx_rnm_ctl_status_s cn50xx;
-	struct cvmx_rnm_ctl_status_s cn52xx;
-	struct cvmx_rnm_ctl_status_s cn52xxp1;
-	struct cvmx_rnm_ctl_status_s cn56xx;
-	struct cvmx_rnm_ctl_status_s cn56xxp1;
-	struct cvmx_rnm_ctl_status_s cn58xx;
-	struct cvmx_rnm_ctl_status_s cn58xxp1;
+	struct cvmx_rnm_ctl_status_cn50xx {
+		uint64_t reserved_9_63:55;
+		uint64_t ent_sel:4;
+		uint64_t exp_ent:1;
+		uint64_t rng_rst:1;
+		uint64_t rnm_rst:1;
+		uint64_t rng_en:1;
+		uint64_t ent_en:1;
+	} cn50xx;
+	struct cvmx_rnm_ctl_status_cn50xx cn52xx;
+	struct cvmx_rnm_ctl_status_cn50xx cn52xxp1;
+	struct cvmx_rnm_ctl_status_cn50xx cn56xx;
+	struct cvmx_rnm_ctl_status_cn50xx cn56xxp1;
+	struct cvmx_rnm_ctl_status_cn50xx cn58xx;
+	struct cvmx_rnm_ctl_status_cn50xx cn58xxp1;
+	struct cvmx_rnm_ctl_status_s cn63xx;
+	struct cvmx_rnm_ctl_status_s cn63xxp1;
+};
+
+union cvmx_rnm_eer_dbg {
+	uint64_t u64;
+	struct cvmx_rnm_eer_dbg_s {
+		uint64_t dat:64;
+	} s;
+	struct cvmx_rnm_eer_dbg_s cn63xx;
+	struct cvmx_rnm_eer_dbg_s cn63xxp1;
+};
+
+union cvmx_rnm_eer_key {
+	uint64_t u64;
+	struct cvmx_rnm_eer_key_s {
+		uint64_t key:64;
+	} s;
+	struct cvmx_rnm_eer_key_s cn63xx;
+	struct cvmx_rnm_eer_key_s cn63xxp1;
+};
+
+union cvmx_rnm_serial_num {
+	uint64_t u64;
+	struct cvmx_rnm_serial_num_s {
+		uint64_t dat:64;
+	} s;
+	struct cvmx_rnm_serial_num_s cn63xx;
 };
 
 #endif
diff --git a/arch/mips/include/asm/octeon/cvmx-smix-defs.h b/arch/mips/include/asm/octeon/cvmx-smix-defs.h
index 9ae45fc..4f3c066 100644
--- a/arch/mips/include/asm/octeon/cvmx-smix-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-smix-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2010 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -28,16 +28,11 @@
 #ifndef __CVMX_SMIX_DEFS_H__
 #define __CVMX_SMIX_DEFS_H__
 
-#define CVMX_SMIX_CLK(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000001818ull + (((offset) & 1) * 256))
-#define CVMX_SMIX_CMD(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000001800ull + (((offset) & 1) * 256))
-#define CVMX_SMIX_EN(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000001820ull + (((offset) & 1) * 256))
-#define CVMX_SMIX_RD_DAT(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000001810ull + (((offset) & 1) * 256))
-#define CVMX_SMIX_WR_DAT(offset) \
-	 CVMX_ADD_IO_SEG(0x0001180000001808ull + (((offset) & 1) * 256))
+#define CVMX_SMIX_CLK(offset) (CVMX_ADD_IO_SEG(0x0001180000001818ull) + ((offset) & 1) * 256)
+#define CVMX_SMIX_CMD(offset) (CVMX_ADD_IO_SEG(0x0001180000001800ull) + ((offset) & 1) * 256)
+#define CVMX_SMIX_EN(offset) (CVMX_ADD_IO_SEG(0x0001180000001820ull) + ((offset) & 1) * 256)
+#define CVMX_SMIX_RD_DAT(offset) (CVMX_ADD_IO_SEG(0x0001180000001810ull) + ((offset) & 1) * 256)
+#define CVMX_SMIX_WR_DAT(offset) (CVMX_ADD_IO_SEG(0x0001180000001808ull) + ((offset) & 1) * 256)
 
 union cvmx_smix_clk {
 	uint64_t u64;
@@ -56,7 +51,8 @@ union cvmx_smix_clk {
 	struct cvmx_smix_clk_cn30xx {
 		uint64_t reserved_21_63:43;
 		uint64_t sample_hi:5;
-		uint64_t reserved_14_15:2;
+		uint64_t sample_mode:1;
+		uint64_t reserved_14_14:1;
 		uint64_t clk_idle:1;
 		uint64_t preamble:1;
 		uint64_t sample:4;
@@ -65,23 +61,15 @@ union cvmx_smix_clk {
 	struct cvmx_smix_clk_cn30xx cn31xx;
 	struct cvmx_smix_clk_cn30xx cn38xx;
 	struct cvmx_smix_clk_cn30xx cn38xxp2;
-	struct cvmx_smix_clk_cn50xx {
-		uint64_t reserved_25_63:39;
-		uint64_t mode:1;
-		uint64_t reserved_21_23:3;
-		uint64_t sample_hi:5;
-		uint64_t reserved_14_15:2;
-		uint64_t clk_idle:1;
-		uint64_t preamble:1;
-		uint64_t sample:4;
-		uint64_t phase:8;
-	} cn50xx;
+	struct cvmx_smix_clk_s cn50xx;
 	struct cvmx_smix_clk_s cn52xx;
-	struct cvmx_smix_clk_cn50xx cn52xxp1;
+	struct cvmx_smix_clk_s cn52xxp1;
 	struct cvmx_smix_clk_s cn56xx;
-	struct cvmx_smix_clk_cn50xx cn56xxp1;
+	struct cvmx_smix_clk_s cn56xxp1;
 	struct cvmx_smix_clk_cn30xx cn58xx;
 	struct cvmx_smix_clk_cn30xx cn58xxp1;
+	struct cvmx_smix_clk_s cn63xx;
+	struct cvmx_smix_clk_s cn63xxp1;
 };
 
 union cvmx_smix_cmd {
@@ -112,6 +100,8 @@ union cvmx_smix_cmd {
 	struct cvmx_smix_cmd_s cn56xxp1;
 	struct cvmx_smix_cmd_cn30xx cn58xx;
 	struct cvmx_smix_cmd_cn30xx cn58xxp1;
+	struct cvmx_smix_cmd_s cn63xx;
+	struct cvmx_smix_cmd_s cn63xxp1;
 };
 
 union cvmx_smix_en {
@@ -131,6 +121,8 @@ union cvmx_smix_en {
 	struct cvmx_smix_en_s cn56xxp1;
 	struct cvmx_smix_en_s cn58xx;
 	struct cvmx_smix_en_s cn58xxp1;
+	struct cvmx_smix_en_s cn63xx;
+	struct cvmx_smix_en_s cn63xxp1;
 };
 
 union cvmx_smix_rd_dat {
@@ -152,6 +144,8 @@ union cvmx_smix_rd_dat {
 	struct cvmx_smix_rd_dat_s cn56xxp1;
 	struct cvmx_smix_rd_dat_s cn58xx;
 	struct cvmx_smix_rd_dat_s cn58xxp1;
+	struct cvmx_smix_rd_dat_s cn63xx;
+	struct cvmx_smix_rd_dat_s cn63xxp1;
 };
 
 union cvmx_smix_wr_dat {
@@ -173,6 +167,8 @@ union cvmx_smix_wr_dat {
 	struct cvmx_smix_wr_dat_s cn56xxp1;
 	struct cvmx_smix_wr_dat_s cn58xx;
 	struct cvmx_smix_wr_dat_s cn58xxp1;
+	struct cvmx_smix_wr_dat_s cn63xx;
+	struct cvmx_smix_wr_dat_s cn63xxp1;
 };
 
 #endif
-- 
1.7.2.3
