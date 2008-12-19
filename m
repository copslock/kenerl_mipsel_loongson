Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2008 23:43:45 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:12516 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24207742AbYLSXnX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Dec 2008 23:43:23 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B494c31930001>; Fri, 19 Dec 2008 18:43:15 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 19 Dec 2008 15:43:15 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 19 Dec 2008 15:43:15 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mBJNhDmZ011899;
	Fri, 19 Dec 2008 15:43:13 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mBJNhDK9011898;
	Fri, 19 Dec 2008 15:43:13 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, netdev@vger.kernel.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/3] MIPS: Add some register definitions to OCTEON for MGMT ethernet driver.
Date:	Fri, 19 Dec 2008 15:43:11 -0800
Message-Id: <1229730192-11870-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <494C312E.9000901@caviumnetworks.com>
References: <494C312E.9000901@caviumnetworks.com>
X-OriginalArrivalTime: 19 Dec 2008 23:43:15.0512 (UTC) FILETIME=[8FF98B80:01C96233]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The MGMT ethernet driver uses the AGL, MIXX and SMIX blocks, so we add
definitions for them.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/octeon/cvmx-agl-defs.h  | 1194 +++++++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx-mixx-defs.h |  248 +++++
 arch/mips/include/asm/octeon/cvmx-smix-defs.h |  178 ++++
 3 files changed, 1620 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/octeon/cvmx-agl-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-mixx-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-smix-defs.h

diff --git a/arch/mips/include/asm/octeon/cvmx-agl-defs.h b/arch/mips/include/asm/octeon/cvmx-agl-defs.h
new file mode 100644
index 0000000..ec94b9a
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-agl-defs.h
@@ -0,0 +1,1194 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_AGL_DEFS_H__
+#define __CVMX_AGL_DEFS_H__
+
+#define CVMX_AGL_GMX_BAD_REG \
+	 CVMX_ADD_IO_SEG(0x00011800E0000518ull)
+#define CVMX_AGL_GMX_BIST \
+	 CVMX_ADD_IO_SEG(0x00011800E0000400ull)
+#define CVMX_AGL_GMX_DRV_CTL \
+	 CVMX_ADD_IO_SEG(0x00011800E00007F0ull)
+#define CVMX_AGL_GMX_INF_MODE \
+	 CVMX_ADD_IO_SEG(0x00011800E00007F8ull)
+#define CVMX_AGL_GMX_PRTX_CFG(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000010ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_ADR_CAM0(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000180ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_ADR_CAM1(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000188ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_ADR_CAM2(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000190ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_ADR_CAM3(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000198ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_ADR_CAM4(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E00001A0ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_ADR_CAM5(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E00001A8ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_ADR_CAM_EN(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000108ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_ADR_CTL(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000100ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_DECISION(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000040ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_FRM_CHK(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000020ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_FRM_CTL(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000018ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_FRM_MAX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000030ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_FRM_MIN(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000028ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_IFG(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000058ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_INT_EN(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000008ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_INT_REG(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000000ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_JABBER(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000038ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_PAUSE_DROP_TIME(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000068ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_STATS_CTL(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000050ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_STATS_OCTS(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000088ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_STATS_OCTS_CTL(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000098ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_STATS_OCTS_DMAC(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E00000A8ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_STATS_OCTS_DRP(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E00000B8ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_STATS_PKTS(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000080ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_STATS_PKTS_BAD(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E00000C0ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_STATS_PKTS_CTL(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000090ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_STATS_PKTS_DMAC(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E00000A0ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_STATS_PKTS_DRP(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E00000B0ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RXX_UDD_SKP(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000048ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_RX_BP_DROPX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000420ull + (((offset) & 1) * 8))
+#define CVMX_AGL_GMX_RX_BP_OFFX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000460ull + (((offset) & 1) * 8))
+#define CVMX_AGL_GMX_RX_BP_ONX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000440ull + (((offset) & 1) * 8))
+#define CVMX_AGL_GMX_RX_PRT_INFO \
+	 CVMX_ADD_IO_SEG(0x00011800E00004E8ull)
+#define CVMX_AGL_GMX_RX_TX_STATUS \
+	 CVMX_ADD_IO_SEG(0x00011800E00007E8ull)
+#define CVMX_AGL_GMX_SMACX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000230ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_STAT_BP \
+	 CVMX_ADD_IO_SEG(0x00011800E0000520ull)
+#define CVMX_AGL_GMX_TXX_APPEND(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000218ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_TXX_CTL(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000270ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_TXX_MIN_PKT(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000240ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_TXX_PAUSE_PKT_INTERVAL(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000248ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_TXX_PAUSE_PKT_TIME(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000238ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_TXX_PAUSE_TOGO(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000258ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_TXX_PAUSE_ZERO(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000260ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_TXX_SOFT_PAUSE(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000250ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_TXX_STAT0(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000280ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_TXX_STAT1(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000288ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_TXX_STAT2(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000290ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_TXX_STAT3(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000298ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_TXX_STAT4(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E00002A0ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_TXX_STAT5(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E00002A8ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_TXX_STAT6(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E00002B0ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_TXX_STAT7(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E00002B8ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_TXX_STAT8(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E00002C0ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_TXX_STAT9(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E00002C8ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_TXX_STATS_CTL(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000268ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_TXX_THRESH(offset) \
+	 CVMX_ADD_IO_SEG(0x00011800E0000210ull + (((offset) & 1) * 2048))
+#define CVMX_AGL_GMX_TX_BP \
+	 CVMX_ADD_IO_SEG(0x00011800E00004D0ull)
+#define CVMX_AGL_GMX_TX_COL_ATTEMPT \
+	 CVMX_ADD_IO_SEG(0x00011800E0000498ull)
+#define CVMX_AGL_GMX_TX_IFG \
+	 CVMX_ADD_IO_SEG(0x00011800E0000488ull)
+#define CVMX_AGL_GMX_TX_INT_EN \
+	 CVMX_ADD_IO_SEG(0x00011800E0000508ull)
+#define CVMX_AGL_GMX_TX_INT_REG \
+	 CVMX_ADD_IO_SEG(0x00011800E0000500ull)
+#define CVMX_AGL_GMX_TX_JAM \
+	 CVMX_ADD_IO_SEG(0x00011800E0000490ull)
+#define CVMX_AGL_GMX_TX_LFSR \
+	 CVMX_ADD_IO_SEG(0x00011800E00004F8ull)
+#define CVMX_AGL_GMX_TX_OVR_BP \
+	 CVMX_ADD_IO_SEG(0x00011800E00004C8ull)
+#define CVMX_AGL_GMX_TX_PAUSE_PKT_DMAC \
+	 CVMX_ADD_IO_SEG(0x00011800E00004A0ull)
+#define CVMX_AGL_GMX_TX_PAUSE_PKT_TYPE \
+	 CVMX_ADD_IO_SEG(0x00011800E00004A8ull)
+
+union cvmx_agl_gmx_bad_reg {
+	uint64_t u64;
+	struct cvmx_agl_gmx_bad_reg_s {
+		uint64_t reserved_38_63:26;
+		uint64_t txpsh1:1;
+		uint64_t txpop1:1;
+		uint64_t ovrflw1:1;
+		uint64_t txpsh:1;
+		uint64_t txpop:1;
+		uint64_t ovrflw:1;
+		uint64_t reserved_27_31:5;
+		uint64_t statovr:1;
+		uint64_t reserved_23_25:3;
+		uint64_t loststat:1;
+		uint64_t reserved_4_21:18;
+		uint64_t out_ovr:2;
+		uint64_t reserved_0_1:2;
+	} s;
+	struct cvmx_agl_gmx_bad_reg_s cn52xx;
+	struct cvmx_agl_gmx_bad_reg_s cn52xxp1;
+	struct cvmx_agl_gmx_bad_reg_cn56xx {
+		uint64_t reserved_35_63:29;
+		uint64_t txpsh:1;
+		uint64_t txpop:1;
+		uint64_t ovrflw:1;
+		uint64_t reserved_27_31:5;
+		uint64_t statovr:1;
+		uint64_t reserved_23_25:3;
+		uint64_t loststat:1;
+		uint64_t reserved_3_21:19;
+		uint64_t out_ovr:1;
+		uint64_t reserved_0_1:2;
+	} cn56xx;
+	struct cvmx_agl_gmx_bad_reg_cn56xx cn56xxp1;
+};
+
+union cvmx_agl_gmx_bist {
+	uint64_t u64;
+	struct cvmx_agl_gmx_bist_s {
+		uint64_t reserved_10_63:54;
+		uint64_t status:10;
+	} s;
+	struct cvmx_agl_gmx_bist_s cn52xx;
+	struct cvmx_agl_gmx_bist_s cn52xxp1;
+	struct cvmx_agl_gmx_bist_s cn56xx;
+	struct cvmx_agl_gmx_bist_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_drv_ctl {
+	uint64_t u64;
+	struct cvmx_agl_gmx_drv_ctl_s {
+		uint64_t reserved_49_63:15;
+		uint64_t byp_en1:1;
+		uint64_t reserved_45_47:3;
+		uint64_t pctl1:5;
+		uint64_t reserved_37_39:3;
+		uint64_t nctl1:5;
+		uint64_t reserved_17_31:15;
+		uint64_t byp_en:1;
+		uint64_t reserved_13_15:3;
+		uint64_t pctl:5;
+		uint64_t reserved_5_7:3;
+		uint64_t nctl:5;
+	} s;
+	struct cvmx_agl_gmx_drv_ctl_s cn52xx;
+	struct cvmx_agl_gmx_drv_ctl_s cn52xxp1;
+	struct cvmx_agl_gmx_drv_ctl_cn56xx {
+		uint64_t reserved_17_63:47;
+		uint64_t byp_en:1;
+		uint64_t reserved_13_15:3;
+		uint64_t pctl:5;
+		uint64_t reserved_5_7:3;
+		uint64_t nctl:5;
+	} cn56xx;
+	struct cvmx_agl_gmx_drv_ctl_cn56xx cn56xxp1;
+};
+
+union cvmx_agl_gmx_inf_mode {
+	uint64_t u64;
+	struct cvmx_agl_gmx_inf_mode_s {
+		uint64_t reserved_2_63:62;
+		uint64_t en:1;
+		uint64_t reserved_0_0:1;
+	} s;
+	struct cvmx_agl_gmx_inf_mode_s cn52xx;
+	struct cvmx_agl_gmx_inf_mode_s cn52xxp1;
+	struct cvmx_agl_gmx_inf_mode_s cn56xx;
+	struct cvmx_agl_gmx_inf_mode_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_prtx_cfg {
+	uint64_t u64;
+	struct cvmx_agl_gmx_prtx_cfg_s {
+		uint64_t reserved_6_63:58;
+		uint64_t tx_en:1;
+		uint64_t rx_en:1;
+		uint64_t slottime:1;
+		uint64_t duplex:1;
+		uint64_t speed:1;
+		uint64_t en:1;
+	} s;
+	struct cvmx_agl_gmx_prtx_cfg_s cn52xx;
+	struct cvmx_agl_gmx_prtx_cfg_s cn52xxp1;
+	struct cvmx_agl_gmx_prtx_cfg_s cn56xx;
+	struct cvmx_agl_gmx_prtx_cfg_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_adr_cam0 {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_adr_cam0_s {
+		uint64_t adr:64;
+	} s;
+	struct cvmx_agl_gmx_rxx_adr_cam0_s cn52xx;
+	struct cvmx_agl_gmx_rxx_adr_cam0_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_adr_cam0_s cn56xx;
+	struct cvmx_agl_gmx_rxx_adr_cam0_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_adr_cam1 {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_adr_cam1_s {
+		uint64_t adr:64;
+	} s;
+	struct cvmx_agl_gmx_rxx_adr_cam1_s cn52xx;
+	struct cvmx_agl_gmx_rxx_adr_cam1_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_adr_cam1_s cn56xx;
+	struct cvmx_agl_gmx_rxx_adr_cam1_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_adr_cam2 {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_adr_cam2_s {
+		uint64_t adr:64;
+	} s;
+	struct cvmx_agl_gmx_rxx_adr_cam2_s cn52xx;
+	struct cvmx_agl_gmx_rxx_adr_cam2_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_adr_cam2_s cn56xx;
+	struct cvmx_agl_gmx_rxx_adr_cam2_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_adr_cam3 {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_adr_cam3_s {
+		uint64_t adr:64;
+	} s;
+	struct cvmx_agl_gmx_rxx_adr_cam3_s cn52xx;
+	struct cvmx_agl_gmx_rxx_adr_cam3_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_adr_cam3_s cn56xx;
+	struct cvmx_agl_gmx_rxx_adr_cam3_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_adr_cam4 {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_adr_cam4_s {
+		uint64_t adr:64;
+	} s;
+	struct cvmx_agl_gmx_rxx_adr_cam4_s cn52xx;
+	struct cvmx_agl_gmx_rxx_adr_cam4_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_adr_cam4_s cn56xx;
+	struct cvmx_agl_gmx_rxx_adr_cam4_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_adr_cam5 {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_adr_cam5_s {
+		uint64_t adr:64;
+	} s;
+	struct cvmx_agl_gmx_rxx_adr_cam5_s cn52xx;
+	struct cvmx_agl_gmx_rxx_adr_cam5_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_adr_cam5_s cn56xx;
+	struct cvmx_agl_gmx_rxx_adr_cam5_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_adr_cam_en {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_adr_cam_en_s {
+		uint64_t reserved_8_63:56;
+		uint64_t en:8;
+	} s;
+	struct cvmx_agl_gmx_rxx_adr_cam_en_s cn52xx;
+	struct cvmx_agl_gmx_rxx_adr_cam_en_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_adr_cam_en_s cn56xx;
+	struct cvmx_agl_gmx_rxx_adr_cam_en_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_adr_ctl {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_adr_ctl_s {
+		uint64_t reserved_4_63:60;
+		uint64_t cam_mode:1;
+		uint64_t mcst:2;
+		uint64_t bcst:1;
+	} s;
+	struct cvmx_agl_gmx_rxx_adr_ctl_s cn52xx;
+	struct cvmx_agl_gmx_rxx_adr_ctl_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_adr_ctl_s cn56xx;
+	struct cvmx_agl_gmx_rxx_adr_ctl_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_decision {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_decision_s {
+		uint64_t reserved_5_63:59;
+		uint64_t cnt:5;
+	} s;
+	struct cvmx_agl_gmx_rxx_decision_s cn52xx;
+	struct cvmx_agl_gmx_rxx_decision_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_decision_s cn56xx;
+	struct cvmx_agl_gmx_rxx_decision_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_frm_chk {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_frm_chk_s {
+		uint64_t reserved_9_63:55;
+		uint64_t skperr:1;
+		uint64_t rcverr:1;
+		uint64_t lenerr:1;
+		uint64_t alnerr:1;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t maxerr:1;
+		uint64_t reserved_1_1:1;
+		uint64_t minerr:1;
+	} s;
+	struct cvmx_agl_gmx_rxx_frm_chk_s cn52xx;
+	struct cvmx_agl_gmx_rxx_frm_chk_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_frm_chk_s cn56xx;
+	struct cvmx_agl_gmx_rxx_frm_chk_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_frm_ctl {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_frm_ctl_s {
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
+	} s;
+	struct cvmx_agl_gmx_rxx_frm_ctl_s cn52xx;
+	struct cvmx_agl_gmx_rxx_frm_ctl_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_frm_ctl_s cn56xx;
+	struct cvmx_agl_gmx_rxx_frm_ctl_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_frm_max {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_frm_max_s {
+		uint64_t reserved_16_63:48;
+		uint64_t len:16;
+	} s;
+	struct cvmx_agl_gmx_rxx_frm_max_s cn52xx;
+	struct cvmx_agl_gmx_rxx_frm_max_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_frm_max_s cn56xx;
+	struct cvmx_agl_gmx_rxx_frm_max_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_frm_min {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_frm_min_s {
+		uint64_t reserved_16_63:48;
+		uint64_t len:16;
+	} s;
+	struct cvmx_agl_gmx_rxx_frm_min_s cn52xx;
+	struct cvmx_agl_gmx_rxx_frm_min_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_frm_min_s cn56xx;
+	struct cvmx_agl_gmx_rxx_frm_min_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_ifg {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_ifg_s {
+		uint64_t reserved_4_63:60;
+		uint64_t ifg:4;
+	} s;
+	struct cvmx_agl_gmx_rxx_ifg_s cn52xx;
+	struct cvmx_agl_gmx_rxx_ifg_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_ifg_s cn56xx;
+	struct cvmx_agl_gmx_rxx_ifg_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_int_en {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_int_en_s {
+		uint64_t reserved_20_63:44;
+		uint64_t pause_drp:1;
+		uint64_t reserved_16_18:3;
+		uint64_t ifgerr:1;
+		uint64_t coldet:1;
+		uint64_t falerr:1;
+		uint64_t rsverr:1;
+		uint64_t pcterr:1;
+		uint64_t ovrerr:1;
+		uint64_t reserved_9_9:1;
+		uint64_t skperr:1;
+		uint64_t rcverr:1;
+		uint64_t lenerr:1;
+		uint64_t alnerr:1;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t maxerr:1;
+		uint64_t reserved_1_1:1;
+		uint64_t minerr:1;
+	} s;
+	struct cvmx_agl_gmx_rxx_int_en_s cn52xx;
+	struct cvmx_agl_gmx_rxx_int_en_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_int_en_s cn56xx;
+	struct cvmx_agl_gmx_rxx_int_en_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_int_reg {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_int_reg_s {
+		uint64_t reserved_20_63:44;
+		uint64_t pause_drp:1;
+		uint64_t reserved_16_18:3;
+		uint64_t ifgerr:1;
+		uint64_t coldet:1;
+		uint64_t falerr:1;
+		uint64_t rsverr:1;
+		uint64_t pcterr:1;
+		uint64_t ovrerr:1;
+		uint64_t reserved_9_9:1;
+		uint64_t skperr:1;
+		uint64_t rcverr:1;
+		uint64_t lenerr:1;
+		uint64_t alnerr:1;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t maxerr:1;
+		uint64_t reserved_1_1:1;
+		uint64_t minerr:1;
+	} s;
+	struct cvmx_agl_gmx_rxx_int_reg_s cn52xx;
+	struct cvmx_agl_gmx_rxx_int_reg_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_int_reg_s cn56xx;
+	struct cvmx_agl_gmx_rxx_int_reg_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_jabber {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_jabber_s {
+		uint64_t reserved_16_63:48;
+		uint64_t cnt:16;
+	} s;
+	struct cvmx_agl_gmx_rxx_jabber_s cn52xx;
+	struct cvmx_agl_gmx_rxx_jabber_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_jabber_s cn56xx;
+	struct cvmx_agl_gmx_rxx_jabber_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_pause_drop_time {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_pause_drop_time_s {
+		uint64_t reserved_16_63:48;
+		uint64_t status:16;
+	} s;
+	struct cvmx_agl_gmx_rxx_pause_drop_time_s cn52xx;
+	struct cvmx_agl_gmx_rxx_pause_drop_time_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_pause_drop_time_s cn56xx;
+	struct cvmx_agl_gmx_rxx_pause_drop_time_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_stats_ctl {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_stats_ctl_s {
+		uint64_t reserved_1_63:63;
+		uint64_t rd_clr:1;
+	} s;
+	struct cvmx_agl_gmx_rxx_stats_ctl_s cn52xx;
+	struct cvmx_agl_gmx_rxx_stats_ctl_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_stats_ctl_s cn56xx;
+	struct cvmx_agl_gmx_rxx_stats_ctl_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_stats_octs {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_stats_octs_s {
+		uint64_t reserved_48_63:16;
+		uint64_t cnt:48;
+	} s;
+	struct cvmx_agl_gmx_rxx_stats_octs_s cn52xx;
+	struct cvmx_agl_gmx_rxx_stats_octs_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_stats_octs_s cn56xx;
+	struct cvmx_agl_gmx_rxx_stats_octs_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_stats_octs_ctl {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_stats_octs_ctl_s {
+		uint64_t reserved_48_63:16;
+		uint64_t cnt:48;
+	} s;
+	struct cvmx_agl_gmx_rxx_stats_octs_ctl_s cn52xx;
+	struct cvmx_agl_gmx_rxx_stats_octs_ctl_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_stats_octs_ctl_s cn56xx;
+	struct cvmx_agl_gmx_rxx_stats_octs_ctl_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_stats_octs_dmac {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_stats_octs_dmac_s {
+		uint64_t reserved_48_63:16;
+		uint64_t cnt:48;
+	} s;
+	struct cvmx_agl_gmx_rxx_stats_octs_dmac_s cn52xx;
+	struct cvmx_agl_gmx_rxx_stats_octs_dmac_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_stats_octs_dmac_s cn56xx;
+	struct cvmx_agl_gmx_rxx_stats_octs_dmac_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_stats_octs_drp {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_stats_octs_drp_s {
+		uint64_t reserved_48_63:16;
+		uint64_t cnt:48;
+	} s;
+	struct cvmx_agl_gmx_rxx_stats_octs_drp_s cn52xx;
+	struct cvmx_agl_gmx_rxx_stats_octs_drp_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_stats_octs_drp_s cn56xx;
+	struct cvmx_agl_gmx_rxx_stats_octs_drp_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_stats_pkts {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_stats_pkts_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_agl_gmx_rxx_stats_pkts_s cn52xx;
+	struct cvmx_agl_gmx_rxx_stats_pkts_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_stats_pkts_s cn56xx;
+	struct cvmx_agl_gmx_rxx_stats_pkts_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_stats_pkts_bad {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_stats_pkts_bad_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_agl_gmx_rxx_stats_pkts_bad_s cn52xx;
+	struct cvmx_agl_gmx_rxx_stats_pkts_bad_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_stats_pkts_bad_s cn56xx;
+	struct cvmx_agl_gmx_rxx_stats_pkts_bad_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_stats_pkts_ctl {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_stats_pkts_ctl_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_agl_gmx_rxx_stats_pkts_ctl_s cn52xx;
+	struct cvmx_agl_gmx_rxx_stats_pkts_ctl_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_stats_pkts_ctl_s cn56xx;
+	struct cvmx_agl_gmx_rxx_stats_pkts_ctl_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_stats_pkts_dmac {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_stats_pkts_dmac_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_agl_gmx_rxx_stats_pkts_dmac_s cn52xx;
+	struct cvmx_agl_gmx_rxx_stats_pkts_dmac_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_stats_pkts_dmac_s cn56xx;
+	struct cvmx_agl_gmx_rxx_stats_pkts_dmac_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_stats_pkts_drp {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_stats_pkts_drp_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_agl_gmx_rxx_stats_pkts_drp_s cn52xx;
+	struct cvmx_agl_gmx_rxx_stats_pkts_drp_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_stats_pkts_drp_s cn56xx;
+	struct cvmx_agl_gmx_rxx_stats_pkts_drp_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rxx_udd_skp {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_udd_skp_s {
+		uint64_t reserved_9_63:55;
+		uint64_t fcssel:1;
+		uint64_t reserved_7_7:1;
+		uint64_t len:7;
+	} s;
+	struct cvmx_agl_gmx_rxx_udd_skp_s cn52xx;
+	struct cvmx_agl_gmx_rxx_udd_skp_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_udd_skp_s cn56xx;
+	struct cvmx_agl_gmx_rxx_udd_skp_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rx_bp_dropx {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rx_bp_dropx_s {
+		uint64_t reserved_6_63:58;
+		uint64_t mark:6;
+	} s;
+	struct cvmx_agl_gmx_rx_bp_dropx_s cn52xx;
+	struct cvmx_agl_gmx_rx_bp_dropx_s cn52xxp1;
+	struct cvmx_agl_gmx_rx_bp_dropx_s cn56xx;
+	struct cvmx_agl_gmx_rx_bp_dropx_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rx_bp_offx {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rx_bp_offx_s {
+		uint64_t reserved_6_63:58;
+		uint64_t mark:6;
+	} s;
+	struct cvmx_agl_gmx_rx_bp_offx_s cn52xx;
+	struct cvmx_agl_gmx_rx_bp_offx_s cn52xxp1;
+	struct cvmx_agl_gmx_rx_bp_offx_s cn56xx;
+	struct cvmx_agl_gmx_rx_bp_offx_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rx_bp_onx {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rx_bp_onx_s {
+		uint64_t reserved_9_63:55;
+		uint64_t mark:9;
+	} s;
+	struct cvmx_agl_gmx_rx_bp_onx_s cn52xx;
+	struct cvmx_agl_gmx_rx_bp_onx_s cn52xxp1;
+	struct cvmx_agl_gmx_rx_bp_onx_s cn56xx;
+	struct cvmx_agl_gmx_rx_bp_onx_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_rx_prt_info {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rx_prt_info_s {
+		uint64_t reserved_18_63:46;
+		uint64_t drop:2;
+		uint64_t reserved_2_15:14;
+		uint64_t commit:2;
+	} s;
+	struct cvmx_agl_gmx_rx_prt_info_s cn52xx;
+	struct cvmx_agl_gmx_rx_prt_info_s cn52xxp1;
+	struct cvmx_agl_gmx_rx_prt_info_cn56xx {
+		uint64_t reserved_17_63:47;
+		uint64_t drop:1;
+		uint64_t reserved_1_15:15;
+		uint64_t commit:1;
+	} cn56xx;
+	struct cvmx_agl_gmx_rx_prt_info_cn56xx cn56xxp1;
+};
+
+union cvmx_agl_gmx_rx_tx_status {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rx_tx_status_s {
+		uint64_t reserved_6_63:58;
+		uint64_t tx:2;
+		uint64_t reserved_2_3:2;
+		uint64_t rx:2;
+	} s;
+	struct cvmx_agl_gmx_rx_tx_status_s cn52xx;
+	struct cvmx_agl_gmx_rx_tx_status_s cn52xxp1;
+	struct cvmx_agl_gmx_rx_tx_status_cn56xx {
+		uint64_t reserved_5_63:59;
+		uint64_t tx:1;
+		uint64_t reserved_1_3:3;
+		uint64_t rx:1;
+	} cn56xx;
+	struct cvmx_agl_gmx_rx_tx_status_cn56xx cn56xxp1;
+};
+
+union cvmx_agl_gmx_smacx {
+	uint64_t u64;
+	struct cvmx_agl_gmx_smacx_s {
+		uint64_t reserved_48_63:16;
+		uint64_t smac:48;
+	} s;
+	struct cvmx_agl_gmx_smacx_s cn52xx;
+	struct cvmx_agl_gmx_smacx_s cn52xxp1;
+	struct cvmx_agl_gmx_smacx_s cn56xx;
+	struct cvmx_agl_gmx_smacx_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_stat_bp {
+	uint64_t u64;
+	struct cvmx_agl_gmx_stat_bp_s {
+		uint64_t reserved_17_63:47;
+		uint64_t bp:1;
+		uint64_t cnt:16;
+	} s;
+	struct cvmx_agl_gmx_stat_bp_s cn52xx;
+	struct cvmx_agl_gmx_stat_bp_s cn52xxp1;
+	struct cvmx_agl_gmx_stat_bp_s cn56xx;
+	struct cvmx_agl_gmx_stat_bp_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_txx_append {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_append_s {
+		uint64_t reserved_4_63:60;
+		uint64_t force_fcs:1;
+		uint64_t fcs:1;
+		uint64_t pad:1;
+		uint64_t preamble:1;
+	} s;
+	struct cvmx_agl_gmx_txx_append_s cn52xx;
+	struct cvmx_agl_gmx_txx_append_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_append_s cn56xx;
+	struct cvmx_agl_gmx_txx_append_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_txx_ctl {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_ctl_s {
+		uint64_t reserved_2_63:62;
+		uint64_t xsdef_en:1;
+		uint64_t xscol_en:1;
+	} s;
+	struct cvmx_agl_gmx_txx_ctl_s cn52xx;
+	struct cvmx_agl_gmx_txx_ctl_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_ctl_s cn56xx;
+	struct cvmx_agl_gmx_txx_ctl_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_txx_min_pkt {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_min_pkt_s {
+		uint64_t reserved_8_63:56;
+		uint64_t min_size:8;
+	} s;
+	struct cvmx_agl_gmx_txx_min_pkt_s cn52xx;
+	struct cvmx_agl_gmx_txx_min_pkt_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_min_pkt_s cn56xx;
+	struct cvmx_agl_gmx_txx_min_pkt_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_txx_pause_pkt_interval {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_pause_pkt_interval_s {
+		uint64_t reserved_16_63:48;
+		uint64_t interval:16;
+	} s;
+	struct cvmx_agl_gmx_txx_pause_pkt_interval_s cn52xx;
+	struct cvmx_agl_gmx_txx_pause_pkt_interval_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_pause_pkt_interval_s cn56xx;
+	struct cvmx_agl_gmx_txx_pause_pkt_interval_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_txx_pause_pkt_time {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_pause_pkt_time_s {
+		uint64_t reserved_16_63:48;
+		uint64_t time:16;
+	} s;
+	struct cvmx_agl_gmx_txx_pause_pkt_time_s cn52xx;
+	struct cvmx_agl_gmx_txx_pause_pkt_time_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_pause_pkt_time_s cn56xx;
+	struct cvmx_agl_gmx_txx_pause_pkt_time_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_txx_pause_togo {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_pause_togo_s {
+		uint64_t reserved_16_63:48;
+		uint64_t time:16;
+	} s;
+	struct cvmx_agl_gmx_txx_pause_togo_s cn52xx;
+	struct cvmx_agl_gmx_txx_pause_togo_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_pause_togo_s cn56xx;
+	struct cvmx_agl_gmx_txx_pause_togo_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_txx_pause_zero {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_pause_zero_s {
+		uint64_t reserved_1_63:63;
+		uint64_t send:1;
+	} s;
+	struct cvmx_agl_gmx_txx_pause_zero_s cn52xx;
+	struct cvmx_agl_gmx_txx_pause_zero_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_pause_zero_s cn56xx;
+	struct cvmx_agl_gmx_txx_pause_zero_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_txx_soft_pause {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_soft_pause_s {
+		uint64_t reserved_16_63:48;
+		uint64_t time:16;
+	} s;
+	struct cvmx_agl_gmx_txx_soft_pause_s cn52xx;
+	struct cvmx_agl_gmx_txx_soft_pause_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_soft_pause_s cn56xx;
+	struct cvmx_agl_gmx_txx_soft_pause_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_txx_stat0 {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_stat0_s {
+		uint64_t xsdef:32;
+		uint64_t xscol:32;
+	} s;
+	struct cvmx_agl_gmx_txx_stat0_s cn52xx;
+	struct cvmx_agl_gmx_txx_stat0_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_stat0_s cn56xx;
+	struct cvmx_agl_gmx_txx_stat0_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_txx_stat1 {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_stat1_s {
+		uint64_t scol:32;
+		uint64_t mcol:32;
+	} s;
+	struct cvmx_agl_gmx_txx_stat1_s cn52xx;
+	struct cvmx_agl_gmx_txx_stat1_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_stat1_s cn56xx;
+	struct cvmx_agl_gmx_txx_stat1_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_txx_stat2 {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_stat2_s {
+		uint64_t reserved_48_63:16;
+		uint64_t octs:48;
+	} s;
+	struct cvmx_agl_gmx_txx_stat2_s cn52xx;
+	struct cvmx_agl_gmx_txx_stat2_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_stat2_s cn56xx;
+	struct cvmx_agl_gmx_txx_stat2_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_txx_stat3 {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_stat3_s {
+		uint64_t reserved_32_63:32;
+		uint64_t pkts:32;
+	} s;
+	struct cvmx_agl_gmx_txx_stat3_s cn52xx;
+	struct cvmx_agl_gmx_txx_stat3_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_stat3_s cn56xx;
+	struct cvmx_agl_gmx_txx_stat3_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_txx_stat4 {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_stat4_s {
+		uint64_t hist1:32;
+		uint64_t hist0:32;
+	} s;
+	struct cvmx_agl_gmx_txx_stat4_s cn52xx;
+	struct cvmx_agl_gmx_txx_stat4_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_stat4_s cn56xx;
+	struct cvmx_agl_gmx_txx_stat4_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_txx_stat5 {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_stat5_s {
+		uint64_t hist3:32;
+		uint64_t hist2:32;
+	} s;
+	struct cvmx_agl_gmx_txx_stat5_s cn52xx;
+	struct cvmx_agl_gmx_txx_stat5_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_stat5_s cn56xx;
+	struct cvmx_agl_gmx_txx_stat5_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_txx_stat6 {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_stat6_s {
+		uint64_t hist5:32;
+		uint64_t hist4:32;
+	} s;
+	struct cvmx_agl_gmx_txx_stat6_s cn52xx;
+	struct cvmx_agl_gmx_txx_stat6_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_stat6_s cn56xx;
+	struct cvmx_agl_gmx_txx_stat6_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_txx_stat7 {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_stat7_s {
+		uint64_t hist7:32;
+		uint64_t hist6:32;
+	} s;
+	struct cvmx_agl_gmx_txx_stat7_s cn52xx;
+	struct cvmx_agl_gmx_txx_stat7_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_stat7_s cn56xx;
+	struct cvmx_agl_gmx_txx_stat7_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_txx_stat8 {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_stat8_s {
+		uint64_t mcst:32;
+		uint64_t bcst:32;
+	} s;
+	struct cvmx_agl_gmx_txx_stat8_s cn52xx;
+	struct cvmx_agl_gmx_txx_stat8_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_stat8_s cn56xx;
+	struct cvmx_agl_gmx_txx_stat8_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_txx_stat9 {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_stat9_s {
+		uint64_t undflw:32;
+		uint64_t ctl:32;
+	} s;
+	struct cvmx_agl_gmx_txx_stat9_s cn52xx;
+	struct cvmx_agl_gmx_txx_stat9_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_stat9_s cn56xx;
+	struct cvmx_agl_gmx_txx_stat9_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_txx_stats_ctl {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_stats_ctl_s {
+		uint64_t reserved_1_63:63;
+		uint64_t rd_clr:1;
+	} s;
+	struct cvmx_agl_gmx_txx_stats_ctl_s cn52xx;
+	struct cvmx_agl_gmx_txx_stats_ctl_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_stats_ctl_s cn56xx;
+	struct cvmx_agl_gmx_txx_stats_ctl_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_txx_thresh {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_thresh_s {
+		uint64_t reserved_6_63:58;
+		uint64_t cnt:6;
+	} s;
+	struct cvmx_agl_gmx_txx_thresh_s cn52xx;
+	struct cvmx_agl_gmx_txx_thresh_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_thresh_s cn56xx;
+	struct cvmx_agl_gmx_txx_thresh_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_tx_bp {
+	uint64_t u64;
+	struct cvmx_agl_gmx_tx_bp_s {
+		uint64_t reserved_2_63:62;
+		uint64_t bp:2;
+	} s;
+	struct cvmx_agl_gmx_tx_bp_s cn52xx;
+	struct cvmx_agl_gmx_tx_bp_s cn52xxp1;
+	struct cvmx_agl_gmx_tx_bp_cn56xx {
+		uint64_t reserved_1_63:63;
+		uint64_t bp:1;
+	} cn56xx;
+	struct cvmx_agl_gmx_tx_bp_cn56xx cn56xxp1;
+};
+
+union cvmx_agl_gmx_tx_col_attempt {
+	uint64_t u64;
+	struct cvmx_agl_gmx_tx_col_attempt_s {
+		uint64_t reserved_5_63:59;
+		uint64_t limit:5;
+	} s;
+	struct cvmx_agl_gmx_tx_col_attempt_s cn52xx;
+	struct cvmx_agl_gmx_tx_col_attempt_s cn52xxp1;
+	struct cvmx_agl_gmx_tx_col_attempt_s cn56xx;
+	struct cvmx_agl_gmx_tx_col_attempt_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_tx_ifg {
+	uint64_t u64;
+	struct cvmx_agl_gmx_tx_ifg_s {
+		uint64_t reserved_8_63:56;
+		uint64_t ifg2:4;
+		uint64_t ifg1:4;
+	} s;
+	struct cvmx_agl_gmx_tx_ifg_s cn52xx;
+	struct cvmx_agl_gmx_tx_ifg_s cn52xxp1;
+	struct cvmx_agl_gmx_tx_ifg_s cn56xx;
+	struct cvmx_agl_gmx_tx_ifg_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_tx_int_en {
+	uint64_t u64;
+	struct cvmx_agl_gmx_tx_int_en_s {
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
+	} s;
+	struct cvmx_agl_gmx_tx_int_en_s cn52xx;
+	struct cvmx_agl_gmx_tx_int_en_s cn52xxp1;
+	struct cvmx_agl_gmx_tx_int_en_cn56xx {
+		uint64_t reserved_17_63:47;
+		uint64_t late_col:1;
+		uint64_t reserved_13_15:3;
+		uint64_t xsdef:1;
+		uint64_t reserved_9_11:3;
+		uint64_t xscol:1;
+		uint64_t reserved_3_7:5;
+		uint64_t undflw:1;
+		uint64_t reserved_1_1:1;
+		uint64_t pko_nxa:1;
+	} cn56xx;
+	struct cvmx_agl_gmx_tx_int_en_cn56xx cn56xxp1;
+};
+
+union cvmx_agl_gmx_tx_int_reg {
+	uint64_t u64;
+	struct cvmx_agl_gmx_tx_int_reg_s {
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
+	} s;
+	struct cvmx_agl_gmx_tx_int_reg_s cn52xx;
+	struct cvmx_agl_gmx_tx_int_reg_s cn52xxp1;
+	struct cvmx_agl_gmx_tx_int_reg_cn56xx {
+		uint64_t reserved_17_63:47;
+		uint64_t late_col:1;
+		uint64_t reserved_13_15:3;
+		uint64_t xsdef:1;
+		uint64_t reserved_9_11:3;
+		uint64_t xscol:1;
+		uint64_t reserved_3_7:5;
+		uint64_t undflw:1;
+		uint64_t reserved_1_1:1;
+		uint64_t pko_nxa:1;
+	} cn56xx;
+	struct cvmx_agl_gmx_tx_int_reg_cn56xx cn56xxp1;
+};
+
+union cvmx_agl_gmx_tx_jam {
+	uint64_t u64;
+	struct cvmx_agl_gmx_tx_jam_s {
+		uint64_t reserved_8_63:56;
+		uint64_t jam:8;
+	} s;
+	struct cvmx_agl_gmx_tx_jam_s cn52xx;
+	struct cvmx_agl_gmx_tx_jam_s cn52xxp1;
+	struct cvmx_agl_gmx_tx_jam_s cn56xx;
+	struct cvmx_agl_gmx_tx_jam_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_tx_lfsr {
+	uint64_t u64;
+	struct cvmx_agl_gmx_tx_lfsr_s {
+		uint64_t reserved_16_63:48;
+		uint64_t lfsr:16;
+	} s;
+	struct cvmx_agl_gmx_tx_lfsr_s cn52xx;
+	struct cvmx_agl_gmx_tx_lfsr_s cn52xxp1;
+	struct cvmx_agl_gmx_tx_lfsr_s cn56xx;
+	struct cvmx_agl_gmx_tx_lfsr_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_tx_ovr_bp {
+	uint64_t u64;
+	struct cvmx_agl_gmx_tx_ovr_bp_s {
+		uint64_t reserved_10_63:54;
+		uint64_t en:2;
+		uint64_t reserved_6_7:2;
+		uint64_t bp:2;
+		uint64_t reserved_2_3:2;
+		uint64_t ign_full:2;
+	} s;
+	struct cvmx_agl_gmx_tx_ovr_bp_s cn52xx;
+	struct cvmx_agl_gmx_tx_ovr_bp_s cn52xxp1;
+	struct cvmx_agl_gmx_tx_ovr_bp_cn56xx {
+		uint64_t reserved_9_63:55;
+		uint64_t en:1;
+		uint64_t reserved_5_7:3;
+		uint64_t bp:1;
+		uint64_t reserved_1_3:3;
+		uint64_t ign_full:1;
+	} cn56xx;
+	struct cvmx_agl_gmx_tx_ovr_bp_cn56xx cn56xxp1;
+};
+
+union cvmx_agl_gmx_tx_pause_pkt_dmac {
+	uint64_t u64;
+	struct cvmx_agl_gmx_tx_pause_pkt_dmac_s {
+		uint64_t reserved_48_63:16;
+		uint64_t dmac:48;
+	} s;
+	struct cvmx_agl_gmx_tx_pause_pkt_dmac_s cn52xx;
+	struct cvmx_agl_gmx_tx_pause_pkt_dmac_s cn52xxp1;
+	struct cvmx_agl_gmx_tx_pause_pkt_dmac_s cn56xx;
+	struct cvmx_agl_gmx_tx_pause_pkt_dmac_s cn56xxp1;
+};
+
+union cvmx_agl_gmx_tx_pause_pkt_type {
+	uint64_t u64;
+	struct cvmx_agl_gmx_tx_pause_pkt_type_s {
+		uint64_t reserved_16_63:48;
+		uint64_t type:16;
+	} s;
+	struct cvmx_agl_gmx_tx_pause_pkt_type_s cn52xx;
+	struct cvmx_agl_gmx_tx_pause_pkt_type_s cn52xxp1;
+	struct cvmx_agl_gmx_tx_pause_pkt_type_s cn56xx;
+	struct cvmx_agl_gmx_tx_pause_pkt_type_s cn56xxp1;
+};
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-mixx-defs.h b/arch/mips/include/asm/octeon/cvmx-mixx-defs.h
new file mode 100644
index 0000000..dab6dca
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-mixx-defs.h
@@ -0,0 +1,248 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_MIXX_DEFS_H__
+#define __CVMX_MIXX_DEFS_H__
+
+#define CVMX_MIXX_BIST(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000100078ull + (((offset) & 1) * 2048))
+#define CVMX_MIXX_CTL(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000100020ull + (((offset) & 1) * 2048))
+#define CVMX_MIXX_INTENA(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000100050ull + (((offset) & 1) * 2048))
+#define CVMX_MIXX_IRCNT(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000100030ull + (((offset) & 1) * 2048))
+#define CVMX_MIXX_IRHWM(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000100028ull + (((offset) & 1) * 2048))
+#define CVMX_MIXX_IRING1(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000100010ull + (((offset) & 1) * 2048))
+#define CVMX_MIXX_IRING2(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000100018ull + (((offset) & 1) * 2048))
+#define CVMX_MIXX_ISR(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000100048ull + (((offset) & 1) * 2048))
+#define CVMX_MIXX_ORCNT(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000100040ull + (((offset) & 1) * 2048))
+#define CVMX_MIXX_ORHWM(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000100038ull + (((offset) & 1) * 2048))
+#define CVMX_MIXX_ORING1(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000100000ull + (((offset) & 1) * 2048))
+#define CVMX_MIXX_ORING2(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000100008ull + (((offset) & 1) * 2048))
+#define CVMX_MIXX_REMCNT(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000100058ull + (((offset) & 1) * 2048))
+
+union cvmx_mixx_bist {
+	uint64_t u64;
+	struct cvmx_mixx_bist_s {
+		uint64_t reserved_4_63:60;
+		uint64_t mrqdat:1;
+		uint64_t ipfdat:1;
+		uint64_t irfdat:1;
+		uint64_t orfdat:1;
+	} s;
+	struct cvmx_mixx_bist_s cn52xx;
+	struct cvmx_mixx_bist_s cn52xxp1;
+	struct cvmx_mixx_bist_s cn56xx;
+	struct cvmx_mixx_bist_s cn56xxp1;
+};
+
+union cvmx_mixx_ctl {
+	uint64_t u64;
+	struct cvmx_mixx_ctl_s {
+		uint64_t reserved_8_63:56;
+		uint64_t crc_strip:1;
+		uint64_t busy:1;
+		uint64_t en:1;
+		uint64_t reset:1;
+		uint64_t lendian:1;
+		uint64_t nbtarb:1;
+		uint64_t mrq_hwm:2;
+	} s;
+	struct cvmx_mixx_ctl_s cn52xx;
+	struct cvmx_mixx_ctl_s cn52xxp1;
+	struct cvmx_mixx_ctl_s cn56xx;
+	struct cvmx_mixx_ctl_s cn56xxp1;
+};
+
+union cvmx_mixx_intena {
+	uint64_t u64;
+	struct cvmx_mixx_intena_s {
+		uint64_t reserved_7_63:57;
+		uint64_t orunena:1;
+		uint64_t irunena:1;
+		uint64_t data_drpena:1;
+		uint64_t ithena:1;
+		uint64_t othena:1;
+		uint64_t ivfena:1;
+		uint64_t ovfena:1;
+	} s;
+	struct cvmx_mixx_intena_s cn52xx;
+	struct cvmx_mixx_intena_s cn52xxp1;
+	struct cvmx_mixx_intena_s cn56xx;
+	struct cvmx_mixx_intena_s cn56xxp1;
+};
+
+union cvmx_mixx_ircnt {
+	uint64_t u64;
+	struct cvmx_mixx_ircnt_s {
+		uint64_t reserved_20_63:44;
+		uint64_t ircnt:20;
+	} s;
+	struct cvmx_mixx_ircnt_s cn52xx;
+	struct cvmx_mixx_ircnt_s cn52xxp1;
+	struct cvmx_mixx_ircnt_s cn56xx;
+	struct cvmx_mixx_ircnt_s cn56xxp1;
+};
+
+union cvmx_mixx_irhwm {
+	uint64_t u64;
+	struct cvmx_mixx_irhwm_s {
+		uint64_t reserved_40_63:24;
+		uint64_t ibplwm:20;
+		uint64_t irhwm:20;
+	} s;
+	struct cvmx_mixx_irhwm_s cn52xx;
+	struct cvmx_mixx_irhwm_s cn52xxp1;
+	struct cvmx_mixx_irhwm_s cn56xx;
+	struct cvmx_mixx_irhwm_s cn56xxp1;
+};
+
+union cvmx_mixx_iring1 {
+	uint64_t u64;
+	struct cvmx_mixx_iring1_s {
+		uint64_t reserved_60_63:4;
+		uint64_t isize:20;
+		uint64_t reserved_36_39:4;
+		uint64_t ibase:33;
+		uint64_t reserved_0_2:3;
+	} s;
+	struct cvmx_mixx_iring1_s cn52xx;
+	struct cvmx_mixx_iring1_s cn52xxp1;
+	struct cvmx_mixx_iring1_s cn56xx;
+	struct cvmx_mixx_iring1_s cn56xxp1;
+};
+
+union cvmx_mixx_iring2 {
+	uint64_t u64;
+	struct cvmx_mixx_iring2_s {
+		uint64_t reserved_52_63:12;
+		uint64_t itlptr:20;
+		uint64_t reserved_20_31:12;
+		uint64_t idbell:20;
+	} s;
+	struct cvmx_mixx_iring2_s cn52xx;
+	struct cvmx_mixx_iring2_s cn52xxp1;
+	struct cvmx_mixx_iring2_s cn56xx;
+	struct cvmx_mixx_iring2_s cn56xxp1;
+};
+
+union cvmx_mixx_isr {
+	uint64_t u64;
+	struct cvmx_mixx_isr_s {
+		uint64_t reserved_7_63:57;
+		uint64_t orun:1;
+		uint64_t irun:1;
+		uint64_t data_drp:1;
+		uint64_t irthresh:1;
+		uint64_t orthresh:1;
+		uint64_t idblovf:1;
+		uint64_t odblovf:1;
+	} s;
+	struct cvmx_mixx_isr_s cn52xx;
+	struct cvmx_mixx_isr_s cn52xxp1;
+	struct cvmx_mixx_isr_s cn56xx;
+	struct cvmx_mixx_isr_s cn56xxp1;
+};
+
+union cvmx_mixx_orcnt {
+	uint64_t u64;
+	struct cvmx_mixx_orcnt_s {
+		uint64_t reserved_20_63:44;
+		uint64_t orcnt:20;
+	} s;
+	struct cvmx_mixx_orcnt_s cn52xx;
+	struct cvmx_mixx_orcnt_s cn52xxp1;
+	struct cvmx_mixx_orcnt_s cn56xx;
+	struct cvmx_mixx_orcnt_s cn56xxp1;
+};
+
+union cvmx_mixx_orhwm {
+	uint64_t u64;
+	struct cvmx_mixx_orhwm_s {
+		uint64_t reserved_20_63:44;
+		uint64_t orhwm:20;
+	} s;
+	struct cvmx_mixx_orhwm_s cn52xx;
+	struct cvmx_mixx_orhwm_s cn52xxp1;
+	struct cvmx_mixx_orhwm_s cn56xx;
+	struct cvmx_mixx_orhwm_s cn56xxp1;
+};
+
+union cvmx_mixx_oring1 {
+	uint64_t u64;
+	struct cvmx_mixx_oring1_s {
+		uint64_t reserved_60_63:4;
+		uint64_t osize:20;
+		uint64_t reserved_36_39:4;
+		uint64_t obase:33;
+		uint64_t reserved_0_2:3;
+	} s;
+	struct cvmx_mixx_oring1_s cn52xx;
+	struct cvmx_mixx_oring1_s cn52xxp1;
+	struct cvmx_mixx_oring1_s cn56xx;
+	struct cvmx_mixx_oring1_s cn56xxp1;
+};
+
+union cvmx_mixx_oring2 {
+	uint64_t u64;
+	struct cvmx_mixx_oring2_s {
+		uint64_t reserved_52_63:12;
+		uint64_t otlptr:20;
+		uint64_t reserved_20_31:12;
+		uint64_t odbell:20;
+	} s;
+	struct cvmx_mixx_oring2_s cn52xx;
+	struct cvmx_mixx_oring2_s cn52xxp1;
+	struct cvmx_mixx_oring2_s cn56xx;
+	struct cvmx_mixx_oring2_s cn56xxp1;
+};
+
+union cvmx_mixx_remcnt {
+	uint64_t u64;
+	struct cvmx_mixx_remcnt_s {
+		uint64_t reserved_52_63:12;
+		uint64_t iremcnt:20;
+		uint64_t reserved_20_31:12;
+		uint64_t oremcnt:20;
+	} s;
+	struct cvmx_mixx_remcnt_s cn52xx;
+	struct cvmx_mixx_remcnt_s cn52xxp1;
+	struct cvmx_mixx_remcnt_s cn56xx;
+	struct cvmx_mixx_remcnt_s cn56xxp1;
+};
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-smix-defs.h b/arch/mips/include/asm/octeon/cvmx-smix-defs.h
new file mode 100644
index 0000000..9ae45fc
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-smix-defs.h
@@ -0,0 +1,178 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_SMIX_DEFS_H__
+#define __CVMX_SMIX_DEFS_H__
+
+#define CVMX_SMIX_CLK(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000001818ull + (((offset) & 1) * 256))
+#define CVMX_SMIX_CMD(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000001800ull + (((offset) & 1) * 256))
+#define CVMX_SMIX_EN(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000001820ull + (((offset) & 1) * 256))
+#define CVMX_SMIX_RD_DAT(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000001810ull + (((offset) & 1) * 256))
+#define CVMX_SMIX_WR_DAT(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000001808ull + (((offset) & 1) * 256))
+
+union cvmx_smix_clk {
+	uint64_t u64;
+	struct cvmx_smix_clk_s {
+		uint64_t reserved_25_63:39;
+		uint64_t mode:1;
+		uint64_t reserved_21_23:3;
+		uint64_t sample_hi:5;
+		uint64_t sample_mode:1;
+		uint64_t reserved_14_14:1;
+		uint64_t clk_idle:1;
+		uint64_t preamble:1;
+		uint64_t sample:4;
+		uint64_t phase:8;
+	} s;
+	struct cvmx_smix_clk_cn30xx {
+		uint64_t reserved_21_63:43;
+		uint64_t sample_hi:5;
+		uint64_t reserved_14_15:2;
+		uint64_t clk_idle:1;
+		uint64_t preamble:1;
+		uint64_t sample:4;
+		uint64_t phase:8;
+	} cn30xx;
+	struct cvmx_smix_clk_cn30xx cn31xx;
+	struct cvmx_smix_clk_cn30xx cn38xx;
+	struct cvmx_smix_clk_cn30xx cn38xxp2;
+	struct cvmx_smix_clk_cn50xx {
+		uint64_t reserved_25_63:39;
+		uint64_t mode:1;
+		uint64_t reserved_21_23:3;
+		uint64_t sample_hi:5;
+		uint64_t reserved_14_15:2;
+		uint64_t clk_idle:1;
+		uint64_t preamble:1;
+		uint64_t sample:4;
+		uint64_t phase:8;
+	} cn50xx;
+	struct cvmx_smix_clk_s cn52xx;
+	struct cvmx_smix_clk_cn50xx cn52xxp1;
+	struct cvmx_smix_clk_s cn56xx;
+	struct cvmx_smix_clk_cn50xx cn56xxp1;
+	struct cvmx_smix_clk_cn30xx cn58xx;
+	struct cvmx_smix_clk_cn30xx cn58xxp1;
+};
+
+union cvmx_smix_cmd {
+	uint64_t u64;
+	struct cvmx_smix_cmd_s {
+		uint64_t reserved_18_63:46;
+		uint64_t phy_op:2;
+		uint64_t reserved_13_15:3;
+		uint64_t phy_adr:5;
+		uint64_t reserved_5_7:3;
+		uint64_t reg_adr:5;
+	} s;
+	struct cvmx_smix_cmd_cn30xx {
+		uint64_t reserved_17_63:47;
+		uint64_t phy_op:1;
+		uint64_t reserved_13_15:3;
+		uint64_t phy_adr:5;
+		uint64_t reserved_5_7:3;
+		uint64_t reg_adr:5;
+	} cn30xx;
+	struct cvmx_smix_cmd_cn30xx cn31xx;
+	struct cvmx_smix_cmd_cn30xx cn38xx;
+	struct cvmx_smix_cmd_cn30xx cn38xxp2;
+	struct cvmx_smix_cmd_s cn50xx;
+	struct cvmx_smix_cmd_s cn52xx;
+	struct cvmx_smix_cmd_s cn52xxp1;
+	struct cvmx_smix_cmd_s cn56xx;
+	struct cvmx_smix_cmd_s cn56xxp1;
+	struct cvmx_smix_cmd_cn30xx cn58xx;
+	struct cvmx_smix_cmd_cn30xx cn58xxp1;
+};
+
+union cvmx_smix_en {
+	uint64_t u64;
+	struct cvmx_smix_en_s {
+		uint64_t reserved_1_63:63;
+		uint64_t en:1;
+	} s;
+	struct cvmx_smix_en_s cn30xx;
+	struct cvmx_smix_en_s cn31xx;
+	struct cvmx_smix_en_s cn38xx;
+	struct cvmx_smix_en_s cn38xxp2;
+	struct cvmx_smix_en_s cn50xx;
+	struct cvmx_smix_en_s cn52xx;
+	struct cvmx_smix_en_s cn52xxp1;
+	struct cvmx_smix_en_s cn56xx;
+	struct cvmx_smix_en_s cn56xxp1;
+	struct cvmx_smix_en_s cn58xx;
+	struct cvmx_smix_en_s cn58xxp1;
+};
+
+union cvmx_smix_rd_dat {
+	uint64_t u64;
+	struct cvmx_smix_rd_dat_s {
+		uint64_t reserved_18_63:46;
+		uint64_t pending:1;
+		uint64_t val:1;
+		uint64_t dat:16;
+	} s;
+	struct cvmx_smix_rd_dat_s cn30xx;
+	struct cvmx_smix_rd_dat_s cn31xx;
+	struct cvmx_smix_rd_dat_s cn38xx;
+	struct cvmx_smix_rd_dat_s cn38xxp2;
+	struct cvmx_smix_rd_dat_s cn50xx;
+	struct cvmx_smix_rd_dat_s cn52xx;
+	struct cvmx_smix_rd_dat_s cn52xxp1;
+	struct cvmx_smix_rd_dat_s cn56xx;
+	struct cvmx_smix_rd_dat_s cn56xxp1;
+	struct cvmx_smix_rd_dat_s cn58xx;
+	struct cvmx_smix_rd_dat_s cn58xxp1;
+};
+
+union cvmx_smix_wr_dat {
+	uint64_t u64;
+	struct cvmx_smix_wr_dat_s {
+		uint64_t reserved_18_63:46;
+		uint64_t pending:1;
+		uint64_t val:1;
+		uint64_t dat:16;
+	} s;
+	struct cvmx_smix_wr_dat_s cn30xx;
+	struct cvmx_smix_wr_dat_s cn31xx;
+	struct cvmx_smix_wr_dat_s cn38xx;
+	struct cvmx_smix_wr_dat_s cn38xxp2;
+	struct cvmx_smix_wr_dat_s cn50xx;
+	struct cvmx_smix_wr_dat_s cn52xx;
+	struct cvmx_smix_wr_dat_s cn52xxp1;
+	struct cvmx_smix_wr_dat_s cn56xx;
+	struct cvmx_smix_wr_dat_s cn56xxp1;
+	struct cvmx_smix_wr_dat_s cn58xx;
+	struct cvmx_smix_wr_dat_s cn58xxp1;
+};
+
+#endif
-- 
1.5.6.5
