Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 00:09:12 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14868 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22533309AbYJ1AEz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Oct 2008 00:04:55 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B490656f60005>; Mon, 27 Oct 2008 20:04:06 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Oct 2008 17:03:09 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Oct 2008 17:03:08 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9S0332Y003268;
	Mon, 27 Oct 2008 17:03:03 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9S033Vk003267;
	Mon, 27 Oct 2008 17:03:03 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 06/36] Add Cavium OCTEON processor CSR definitions
Date:	Mon, 27 Oct 2008 17:02:38 -0700
Message-Id: <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1225152181-3221-5-git-send-email-ddaney@caviumnetworks.com>
References: <490655B6.4030406@caviumnetworks.com>
 <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-3-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-5-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 28 Oct 2008 00:03:08.0757 (UTC) FILETIME=[8F4F8850:01C93890]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 .../cavium-octeon/executive/cvmx-csr-addresses.h   | 8391 ++++++
 arch/mips/cavium-octeon/executive/cvmx-csr-enums.h |   86 +
 .../cavium-octeon/executive/cvmx-csr-typedefs.h    |27517 ++++++++++++++++++++
 arch/mips/cavium-octeon/executive/cvmx-csr.h       |  199 +
 4 files changed, 36193 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/cavium-octeon/executive/cvmx-csr-addresses.h
 create mode 100644 arch/mips/cavium-octeon/executive/cvmx-csr-enums.h
 create mode 100644 arch/mips/cavium-octeon/executive/cvmx-csr-typedefs.h
 create mode 100644 arch/mips/cavium-octeon/executive/cvmx-csr.h

diff --git a/arch/mips/cavium-octeon/executive/cvmx-csr-addresses.h b/arch/mips/cavium-octeon/executive/cvmx-csr-addresses.h
new file mode 100644
index 0000000..04bfdaf
--- /dev/null
+++ b/arch/mips/cavium-octeon/executive/cvmx-csr-addresses.h
@@ -0,0 +1,8391 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
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
+/**
+ * @file
+ *
+ * Configuration and status register (CSR) address and for
+ * Octeon. Include cvmx-csr.h instead of this file directly.
+ *
+ * This file is auto generated. Do not edit.
+ *
+ *
+ */
+#ifndef __CVMX_CSR_ADDRESSES_H__
+#define __CVMX_CSR_ADDRESSES_H__
+
+
+#define CVMX_AGL_GMX_BAD_REG CVMX_AGL_GMX_BAD_REG_FUNC()
+static inline uint64_t CVMX_AGL_GMX_BAD_REG_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000518ull);
+}
+
+#define CVMX_AGL_GMX_BIST CVMX_AGL_GMX_BIST_FUNC()
+static inline uint64_t CVMX_AGL_GMX_BIST_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000400ull);
+}
+
+#define CVMX_AGL_GMX_DRV_CTL CVMX_AGL_GMX_DRV_CTL_FUNC()
+static inline uint64_t CVMX_AGL_GMX_DRV_CTL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E00007F0ull);
+}
+
+#define CVMX_AGL_GMX_INF_MODE CVMX_AGL_GMX_INF_MODE_FUNC()
+static inline uint64_t CVMX_AGL_GMX_INF_MODE_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E00007F8ull);
+}
+
+static inline uint64_t CVMX_AGL_GMX_PRTX_CFG(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000010ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_ADR_CAM0(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000180ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_ADR_CAM1(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000188ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_ADR_CAM2(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000190ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_ADR_CAM3(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000198ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_ADR_CAM4(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E00001A0ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_ADR_CAM5(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E00001A8ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_ADR_CAM_EN(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000108ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_ADR_CTL(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000100ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_DECISION(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000040ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_FRM_CHK(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000020ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_FRM_CTL(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000018ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_FRM_MAX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000030ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_FRM_MIN(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000028ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_IFG(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000058ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_INT_EN(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000008ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_INT_REG(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000000ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_JABBER(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000038ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_PAUSE_DROP_TIME(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000068ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_STATS_CTL(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000050ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_STATS_OCTS(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000088ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_STATS_OCTS_CTL(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000098ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_STATS_OCTS_DMAC(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E00000A8ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_STATS_OCTS_DRP(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E00000B8ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_STATS_PKTS(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000080ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_STATS_PKTS_BAD(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E00000C0ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_STATS_PKTS_CTL(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000090ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_STATS_PKTS_DMAC(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E00000A0ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_STATS_PKTS_DRP(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E00000B0ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RXX_UDD_SKP(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000048ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RX_BP_DROPX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000420ull) + (offset & 1) * 8;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RX_BP_OFFX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000460ull) + (offset & 1) * 8;
+}
+
+static inline uint64_t CVMX_AGL_GMX_RX_BP_ONX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000440ull) + (offset & 1) * 8;
+}
+
+#define CVMX_AGL_GMX_RX_PRT_INFO CVMX_AGL_GMX_RX_PRT_INFO_FUNC()
+static inline uint64_t CVMX_AGL_GMX_RX_PRT_INFO_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E00004E8ull);
+}
+
+#define CVMX_AGL_GMX_RX_TX_STATUS CVMX_AGL_GMX_RX_TX_STATUS_FUNC()
+static inline uint64_t CVMX_AGL_GMX_RX_TX_STATUS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E00007E8ull);
+}
+
+static inline uint64_t CVMX_AGL_GMX_SMACX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000230ull) + (offset & 1) * 2048;
+}
+
+#define CVMX_AGL_GMX_STAT_BP CVMX_AGL_GMX_STAT_BP_FUNC()
+static inline uint64_t CVMX_AGL_GMX_STAT_BP_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000520ull);
+}
+
+static inline uint64_t CVMX_AGL_GMX_TXX_APPEND(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000218ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_TXX_CTL(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000270ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_TXX_MIN_PKT(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000240ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_TXX_PAUSE_PKT_INTERVAL(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000248ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_TXX_PAUSE_PKT_TIME(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000238ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_TXX_PAUSE_TOGO(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000258ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_TXX_PAUSE_ZERO(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000260ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_TXX_SOFT_PAUSE(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000250ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_TXX_STAT0(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000280ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_TXX_STAT1(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000288ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_TXX_STAT2(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000290ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_TXX_STAT3(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000298ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_TXX_STAT4(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E00002A0ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_TXX_STAT5(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E00002A8ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_TXX_STAT6(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E00002B0ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_TXX_STAT7(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E00002B8ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_TXX_STAT8(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E00002C0ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_TXX_STAT9(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E00002C8ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_TXX_STATS_CTL(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000268ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_AGL_GMX_TXX_THRESH(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000210ull) + (offset & 1) * 2048;
+}
+
+#define CVMX_AGL_GMX_TX_BP CVMX_AGL_GMX_TX_BP_FUNC()
+static inline uint64_t CVMX_AGL_GMX_TX_BP_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E00004D0ull);
+}
+
+#define CVMX_AGL_GMX_TX_COL_ATTEMPT CVMX_AGL_GMX_TX_COL_ATTEMPT_FUNC()
+static inline uint64_t CVMX_AGL_GMX_TX_COL_ATTEMPT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000498ull);
+}
+
+#define CVMX_AGL_GMX_TX_IFG CVMX_AGL_GMX_TX_IFG_FUNC()
+static inline uint64_t CVMX_AGL_GMX_TX_IFG_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000488ull);
+}
+
+#define CVMX_AGL_GMX_TX_INT_EN CVMX_AGL_GMX_TX_INT_EN_FUNC()
+static inline uint64_t CVMX_AGL_GMX_TX_INT_EN_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000508ull);
+}
+
+#define CVMX_AGL_GMX_TX_INT_REG CVMX_AGL_GMX_TX_INT_REG_FUNC()
+static inline uint64_t CVMX_AGL_GMX_TX_INT_REG_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000500ull);
+}
+
+#define CVMX_AGL_GMX_TX_JAM CVMX_AGL_GMX_TX_JAM_FUNC()
+static inline uint64_t CVMX_AGL_GMX_TX_JAM_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E0000490ull);
+}
+
+#define CVMX_AGL_GMX_TX_LFSR CVMX_AGL_GMX_TX_LFSR_FUNC()
+static inline uint64_t CVMX_AGL_GMX_TX_LFSR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E00004F8ull);
+}
+
+#define CVMX_AGL_GMX_TX_OVR_BP CVMX_AGL_GMX_TX_OVR_BP_FUNC()
+static inline uint64_t CVMX_AGL_GMX_TX_OVR_BP_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E00004C8ull);
+}
+
+#define CVMX_AGL_GMX_TX_PAUSE_PKT_DMAC CVMX_AGL_GMX_TX_PAUSE_PKT_DMAC_FUNC()
+static inline uint64_t CVMX_AGL_GMX_TX_PAUSE_PKT_DMAC_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E00004A0ull);
+}
+
+#define CVMX_AGL_GMX_TX_PAUSE_PKT_TYPE CVMX_AGL_GMX_TX_PAUSE_PKT_TYPE_FUNC()
+static inline uint64_t CVMX_AGL_GMX_TX_PAUSE_PKT_TYPE_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800E00004A8ull);
+}
+
+#define CVMX_ASX0_DBG_DATA_DRV CVMX_ASX0_DBG_DATA_DRV_FUNC()
+static inline uint64_t CVMX_ASX0_DBG_DATA_DRV_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000208ull);
+}
+
+#define CVMX_ASX0_DBG_DATA_ENABLE CVMX_ASX0_DBG_DATA_ENABLE_FUNC()
+static inline uint64_t CVMX_ASX0_DBG_DATA_ENABLE_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000200ull);
+}
+
+static inline uint64_t CVMX_ASXX_GMII_RX_CLK_SET(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000180ull) +
+	    (block_id & 0) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_ASXX_GMII_RX_DAT_SET(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000188ull) +
+	    (block_id & 0) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_ASXX_INT_EN(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000018ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_ASXX_INT_REG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000010ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_ASXX_MII_RX_DAT_SET(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000190ull) +
+	    (block_id & 0) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_ASXX_PRT_LOOP(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000040ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_ASXX_RLD_BYPASS(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000248ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_ASXX_RLD_BYPASS_SETTING(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000250ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_ASXX_RLD_COMP(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000220ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_ASXX_RLD_DATA_DRV(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000218ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_ASXX_RLD_FCRAM_MODE(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000210ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_ASXX_RLD_NCTL_STRONG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000230ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_ASXX_RLD_NCTL_WEAK(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000240ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_ASXX_RLD_PCTL_STRONG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000228ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_ASXX_RLD_PCTL_WEAK(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000238ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_ASXX_RLD_SETTING(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000258ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_ASXX_RX_CLK_SETX(unsigned long offset,
+					     unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000020ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x1000000ull) * 8;
+}
+
+static inline uint64_t CVMX_ASXX_RX_PRT_EN(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000000ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_ASXX_RX_WOL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000100ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_ASXX_RX_WOL_MSK(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000108ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_ASXX_RX_WOL_POWOK(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000118ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_ASXX_RX_WOL_SIG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000110ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_ASXX_TX_CLK_SETX(unsigned long offset,
+					     unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000048ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x1000000ull) * 8;
+}
+
+static inline uint64_t CVMX_ASXX_TX_COMP_BYP(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000068ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_ASXX_TX_HI_WATERX(unsigned long offset,
+					      unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000080ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x1000000ull) * 8;
+}
+
+static inline uint64_t CVMX_ASXX_TX_PRT_EN(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000008ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+#define CVMX_CIU_BIST CVMX_CIU_BIST_FUNC()
+static inline uint64_t CVMX_CIU_BIST_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000730ull);
+}
+
+#define CVMX_CIU_DINT CVMX_CIU_DINT_FUNC()
+static inline uint64_t CVMX_CIU_DINT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000720ull);
+}
+
+#define CVMX_CIU_FUSE CVMX_CIU_FUSE_FUNC()
+static inline uint64_t CVMX_CIU_FUSE_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000728ull);
+}
+
+#define CVMX_CIU_GSTOP CVMX_CIU_GSTOP_FUNC()
+static inline uint64_t CVMX_CIU_GSTOP_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000710ull);
+}
+
+static inline uint64_t CVMX_CIU_INTX_EN0(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000200ull) + (offset & 63) * 16;
+}
+
+static inline uint64_t CVMX_CIU_INTX_EN0_W1C(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000002200ull) + (offset & 63) * 16;
+}
+
+static inline uint64_t CVMX_CIU_INTX_EN0_W1S(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000006200ull) + (offset & 63) * 16;
+}
+
+static inline uint64_t CVMX_CIU_INTX_EN1(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000208ull) + (offset & 63) * 16;
+}
+
+static inline uint64_t CVMX_CIU_INTX_EN1_W1C(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000002208ull) + (offset & 63) * 16;
+}
+
+static inline uint64_t CVMX_CIU_INTX_EN1_W1S(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000006208ull) + (offset & 63) * 16;
+}
+
+static inline uint64_t CVMX_CIU_INTX_EN4_0(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000C80ull) + (offset & 15) * 16;
+}
+
+static inline uint64_t CVMX_CIU_INTX_EN4_0_W1C(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000002C80ull) + (offset & 15) * 16;
+}
+
+static inline uint64_t CVMX_CIU_INTX_EN4_0_W1S(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000006C80ull) + (offset & 15) * 16;
+}
+
+static inline uint64_t CVMX_CIU_INTX_EN4_1(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000C88ull) + (offset & 15) * 16;
+}
+
+static inline uint64_t CVMX_CIU_INTX_EN4_1_W1C(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000002C88ull) + (offset & 15) * 16;
+}
+
+static inline uint64_t CVMX_CIU_INTX_EN4_1_W1S(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000006C88ull) + (offset & 15) * 16;
+}
+
+static inline uint64_t CVMX_CIU_INTX_SUM0(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000000ull) + (offset & 63) * 8;
+}
+
+static inline uint64_t CVMX_CIU_INTX_SUM4(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000C00ull) + (offset & 15) * 8;
+}
+
+#define CVMX_CIU_INT_SUM1 CVMX_CIU_INT_SUM1_FUNC()
+static inline uint64_t CVMX_CIU_INT_SUM1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000108ull);
+}
+
+static inline uint64_t CVMX_CIU_MBOX_CLRX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset & 15) * 8;
+}
+
+static inline uint64_t CVMX_CIU_MBOX_SETX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset & 15) * 8;
+}
+
+#define CVMX_CIU_NMI CVMX_CIU_NMI_FUNC()
+static inline uint64_t CVMX_CIU_NMI_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000718ull);
+}
+
+#define CVMX_CIU_PCI_INTA CVMX_CIU_PCI_INTA_FUNC()
+static inline uint64_t CVMX_CIU_PCI_INTA_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000750ull);
+}
+
+#define CVMX_CIU_PP_DBG CVMX_CIU_PP_DBG_FUNC()
+static inline uint64_t CVMX_CIU_PP_DBG_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000708ull);
+}
+
+static inline uint64_t CVMX_CIU_PP_POKEX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset & 15) * 8;
+}
+
+#define CVMX_CIU_PP_RST CVMX_CIU_PP_RST_FUNC()
+static inline uint64_t CVMX_CIU_PP_RST_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000700ull);
+}
+
+#define CVMX_CIU_QLM_DCOK CVMX_CIU_QLM_DCOK_FUNC()
+static inline uint64_t CVMX_CIU_QLM_DCOK_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000760ull);
+}
+
+#define CVMX_CIU_QLM_JTGC CVMX_CIU_QLM_JTGC_FUNC()
+static inline uint64_t CVMX_CIU_QLM_JTGC_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000768ull);
+}
+
+#define CVMX_CIU_QLM_JTGD CVMX_CIU_QLM_JTGD_FUNC()
+static inline uint64_t CVMX_CIU_QLM_JTGD_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000770ull);
+}
+
+#define CVMX_CIU_SOFT_BIST CVMX_CIU_SOFT_BIST_FUNC()
+static inline uint64_t CVMX_CIU_SOFT_BIST_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000738ull);
+}
+
+#define CVMX_CIU_SOFT_PRST CVMX_CIU_SOFT_PRST_FUNC()
+static inline uint64_t CVMX_CIU_SOFT_PRST_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000748ull);
+}
+
+#define CVMX_CIU_SOFT_PRST1 CVMX_CIU_SOFT_PRST1_FUNC()
+static inline uint64_t CVMX_CIU_SOFT_PRST1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000758ull);
+}
+
+#define CVMX_CIU_SOFT_RST CVMX_CIU_SOFT_RST_FUNC()
+static inline uint64_t CVMX_CIU_SOFT_RST_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000740ull);
+}
+
+static inline uint64_t CVMX_CIU_TIMX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000480ull) + (offset & 3) * 8;
+}
+
+static inline uint64_t CVMX_CIU_WDOGX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset & 15) * 8;
+}
+
+#define CVMX_DBG_DATA CVMX_DBG_DATA_FUNC()
+static inline uint64_t CVMX_DBG_DATA_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000001E8ull);
+}
+
+#define CVMX_DFA_BST0 CVMX_DFA_BST0_FUNC()
+static inline uint64_t CVMX_DFA_BST0_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800300007F0ull);
+}
+
+#define CVMX_DFA_BST1 CVMX_DFA_BST1_FUNC()
+static inline uint64_t CVMX_DFA_BST1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800300007F8ull);
+}
+
+#define CVMX_DFA_CFG CVMX_DFA_CFG_FUNC()
+static inline uint64_t CVMX_DFA_CFG_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180030000000ull);
+}
+
+#define CVMX_DFA_DBELL CVMX_DFA_DBELL_FUNC()
+static inline uint64_t CVMX_DFA_DBELL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001370000000000ull);
+}
+
+#define CVMX_DFA_DDR2_ADDR CVMX_DFA_DDR2_ADDR_FUNC()
+static inline uint64_t CVMX_DFA_DDR2_ADDR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180030000210ull);
+}
+
+#define CVMX_DFA_DDR2_BUS CVMX_DFA_DDR2_BUS_FUNC()
+static inline uint64_t CVMX_DFA_DDR2_BUS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180030000080ull);
+}
+
+#define CVMX_DFA_DDR2_CFG CVMX_DFA_DDR2_CFG_FUNC()
+static inline uint64_t CVMX_DFA_DDR2_CFG_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180030000208ull);
+}
+
+#define CVMX_DFA_DDR2_COMP CVMX_DFA_DDR2_COMP_FUNC()
+static inline uint64_t CVMX_DFA_DDR2_COMP_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180030000090ull);
+}
+
+#define CVMX_DFA_DDR2_EMRS CVMX_DFA_DDR2_EMRS_FUNC()
+static inline uint64_t CVMX_DFA_DDR2_EMRS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180030000268ull);
+}
+
+#define CVMX_DFA_DDR2_FCNT CVMX_DFA_DDR2_FCNT_FUNC()
+static inline uint64_t CVMX_DFA_DDR2_FCNT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180030000078ull);
+}
+
+#define CVMX_DFA_DDR2_MRS CVMX_DFA_DDR2_MRS_FUNC()
+static inline uint64_t CVMX_DFA_DDR2_MRS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180030000260ull);
+}
+
+#define CVMX_DFA_DDR2_OPT CVMX_DFA_DDR2_OPT_FUNC()
+static inline uint64_t CVMX_DFA_DDR2_OPT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180030000070ull);
+}
+
+#define CVMX_DFA_DDR2_PLL CVMX_DFA_DDR2_PLL_FUNC()
+static inline uint64_t CVMX_DFA_DDR2_PLL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180030000088ull);
+}
+
+#define CVMX_DFA_DDR2_TMG CVMX_DFA_DDR2_TMG_FUNC()
+static inline uint64_t CVMX_DFA_DDR2_TMG_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180030000218ull);
+}
+
+#define CVMX_DFA_DIFCTL CVMX_DFA_DIFCTL_FUNC()
+static inline uint64_t CVMX_DFA_DIFCTL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001370600000000ull);
+}
+
+#define CVMX_DFA_DIFRDPTR CVMX_DFA_DIFRDPTR_FUNC()
+static inline uint64_t CVMX_DFA_DIFRDPTR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001370200000000ull);
+}
+
+#define CVMX_DFA_ECLKCFG CVMX_DFA_ECLKCFG_FUNC()
+static inline uint64_t CVMX_DFA_ECLKCFG_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180030000200ull);
+}
+
+#define CVMX_DFA_ERR CVMX_DFA_ERR_FUNC()
+static inline uint64_t CVMX_DFA_ERR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180030000028ull);
+}
+
+#define CVMX_DFA_MEMCFG0 CVMX_DFA_MEMCFG0_FUNC()
+static inline uint64_t CVMX_DFA_MEMCFG0_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180030000008ull);
+}
+
+#define CVMX_DFA_MEMCFG1 CVMX_DFA_MEMCFG1_FUNC()
+static inline uint64_t CVMX_DFA_MEMCFG1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180030000010ull);
+}
+
+#define CVMX_DFA_MEMCFG2 CVMX_DFA_MEMCFG2_FUNC()
+static inline uint64_t CVMX_DFA_MEMCFG2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180030000060ull);
+}
+
+#define CVMX_DFA_MEMFADR CVMX_DFA_MEMFADR_FUNC()
+static inline uint64_t CVMX_DFA_MEMFADR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180030000030ull);
+}
+
+#define CVMX_DFA_MEMFCR CVMX_DFA_MEMFCR_FUNC()
+static inline uint64_t CVMX_DFA_MEMFCR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180030000038ull);
+}
+
+#define CVMX_DFA_MEMRLD CVMX_DFA_MEMRLD_FUNC()
+static inline uint64_t CVMX_DFA_MEMRLD_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180030000018ull);
+}
+
+#define CVMX_DFA_NCBCTL CVMX_DFA_NCBCTL_FUNC()
+static inline uint64_t CVMX_DFA_NCBCTL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180030000020ull);
+}
+
+#define CVMX_DFA_RODT_COMP_CTL CVMX_DFA_RODT_COMP_CTL_FUNC()
+static inline uint64_t CVMX_DFA_RODT_COMP_CTL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180030000068ull);
+}
+
+#define CVMX_DFA_SBD_DBG0 CVMX_DFA_SBD_DBG0_FUNC()
+static inline uint64_t CVMX_DFA_SBD_DBG0_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180030000040ull);
+}
+
+#define CVMX_DFA_SBD_DBG1 CVMX_DFA_SBD_DBG1_FUNC()
+static inline uint64_t CVMX_DFA_SBD_DBG1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180030000048ull);
+}
+
+#define CVMX_DFA_SBD_DBG2 CVMX_DFA_SBD_DBG2_FUNC()
+static inline uint64_t CVMX_DFA_SBD_DBG2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180030000050ull);
+}
+
+#define CVMX_DFA_SBD_DBG3 CVMX_DFA_SBD_DBG3_FUNC()
+static inline uint64_t CVMX_DFA_SBD_DBG3_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180030000058ull);
+}
+
+#define CVMX_FPA_BIST_STATUS CVMX_FPA_BIST_STATUS_FUNC()
+static inline uint64_t CVMX_FPA_BIST_STATUS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800280000E8ull);
+}
+
+#define CVMX_FPA_CTL_STATUS CVMX_FPA_CTL_STATUS_FUNC()
+static inline uint64_t CVMX_FPA_CTL_STATUS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180028000050ull);
+}
+
+#define CVMX_FPA_FPF0_MARKS CVMX_FPA_FPF0_MARKS_FUNC()
+static inline uint64_t CVMX_FPA_FPF0_MARKS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180028000000ull);
+}
+
+#define CVMX_FPA_FPF0_SIZE CVMX_FPA_FPF0_SIZE_FUNC()
+static inline uint64_t CVMX_FPA_FPF0_SIZE_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180028000058ull);
+}
+
+#define CVMX_FPA_FPF1_MARKS CVMX_FPA_FPFX_MARKS(1)
+#define CVMX_FPA_FPF2_MARKS CVMX_FPA_FPFX_MARKS(2)
+#define CVMX_FPA_FPF3_MARKS CVMX_FPA_FPFX_MARKS(3)
+#define CVMX_FPA_FPF4_MARKS CVMX_FPA_FPFX_MARKS(4)
+#define CVMX_FPA_FPF5_MARKS CVMX_FPA_FPFX_MARKS(5)
+#define CVMX_FPA_FPF6_MARKS CVMX_FPA_FPFX_MARKS(6)
+#define CVMX_FPA_FPF7_MARKS CVMX_FPA_FPFX_MARKS(7)
+static inline uint64_t CVMX_FPA_FPFX_MARKS(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180028000008ull) + (offset & 7) * 8 -
+	    8 * 1;
+}
+
+static inline uint64_t CVMX_FPA_FPFX_SIZE(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180028000060ull) + (offset & 7) * 8 -
+	    8 * 1;
+}
+
+#define CVMX_FPA_INT_ENB CVMX_FPA_INT_ENB_FUNC()
+static inline uint64_t CVMX_FPA_INT_ENB_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180028000048ull);
+}
+
+#define CVMX_FPA_INT_SUM CVMX_FPA_INT_SUM_FUNC()
+static inline uint64_t CVMX_FPA_INT_SUM_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180028000040ull);
+}
+
+#define CVMX_FPA_QUE0_PAGE_INDEX CVMX_FPA_QUEX_PAGE_INDEX(0)
+#define CVMX_FPA_QUE1_PAGE_INDEX CVMX_FPA_QUEX_PAGE_INDEX(1)
+#define CVMX_FPA_QUE2_PAGE_INDEX CVMX_FPA_QUEX_PAGE_INDEX(2)
+#define CVMX_FPA_QUE3_PAGE_INDEX CVMX_FPA_QUEX_PAGE_INDEX(3)
+#define CVMX_FPA_QUE4_PAGE_INDEX CVMX_FPA_QUEX_PAGE_INDEX(4)
+#define CVMX_FPA_QUE5_PAGE_INDEX CVMX_FPA_QUEX_PAGE_INDEX(5)
+#define CVMX_FPA_QUE6_PAGE_INDEX CVMX_FPA_QUEX_PAGE_INDEX(6)
+#define CVMX_FPA_QUE7_PAGE_INDEX CVMX_FPA_QUEX_PAGE_INDEX(7)
+static inline uint64_t CVMX_FPA_QUEX_AVAILABLE(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180028000098ull) + (offset & 7) * 8;
+}
+
+static inline uint64_t CVMX_FPA_QUEX_PAGE_INDEX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800280000F0ull) + (offset & 7) * 8;
+}
+
+#define CVMX_FPA_QUE_ACT CVMX_FPA_QUE_ACT_FUNC()
+static inline uint64_t CVMX_FPA_QUE_ACT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180028000138ull);
+}
+
+#define CVMX_FPA_QUE_EXP CVMX_FPA_QUE_EXP_FUNC()
+static inline uint64_t CVMX_FPA_QUE_EXP_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180028000130ull);
+}
+
+#define CVMX_FPA_WART_CTL CVMX_FPA_WART_CTL_FUNC()
+static inline uint64_t CVMX_FPA_WART_CTL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800280000D8ull);
+}
+
+#define CVMX_FPA_WART_STATUS CVMX_FPA_WART_STATUS_FUNC()
+static inline uint64_t CVMX_FPA_WART_STATUS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800280000E0ull);
+}
+
+static inline uint64_t CVMX_GMXX_BAD_REG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000518ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_BIST(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000400ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_CLK_EN(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080007F0ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_HG2_CONTROL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000550ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_INF_MODE(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080007F8ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_NXA_ADR(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000510ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_PRTX_CBFC_CTL(unsigned long offset,
+					       unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000580ull) + ((offset & 0) +
+							 (block_id & 1) *
+							 0x1000000ull) * 8;
+}
+
+static inline uint64_t CVMX_GMXX_PRTX_CFG(unsigned long offset,
+					  unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000010ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_ADR_CAM0(unsigned long offset,
+					      unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000180ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_ADR_CAM1(unsigned long offset,
+					      unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000188ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_ADR_CAM2(unsigned long offset,
+					      unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000190ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_ADR_CAM3(unsigned long offset,
+					      unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000198ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_ADR_CAM4(unsigned long offset,
+					      unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080001A0ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_ADR_CAM5(unsigned long offset,
+					      unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080001A8ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_ADR_CAM_EN(unsigned long offset,
+						unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000108ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_ADR_CTL(unsigned long offset,
+					     unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000100ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_DECISION(unsigned long offset,
+					      unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000040ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_FRM_CHK(unsigned long offset,
+					     unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000020ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_FRM_CTL(unsigned long offset,
+					     unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000018ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_FRM_MAX(unsigned long offset,
+					     unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000030ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_FRM_MIN(unsigned long offset,
+					     unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000028ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_IFG(unsigned long offset,
+					 unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000058ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_INT_EN(unsigned long offset,
+					    unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000008ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_INT_REG(unsigned long offset,
+					     unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000000ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_JABBER(unsigned long offset,
+					    unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000038ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_PAUSE_DROP_TIME(unsigned long offset,
+						     unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000068ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_RX_INBND(unsigned long offset,
+					      unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000060ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_STATS_CTL(unsigned long offset,
+					       unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000050ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_STATS_OCTS(unsigned long offset,
+						unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000088ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_STATS_OCTS_CTL(unsigned long offset,
+						    unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000098ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_STATS_OCTS_DMAC(unsigned long offset,
+						     unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080000A8ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_STATS_OCTS_DRP(unsigned long offset,
+						    unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080000B8ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_STATS_PKTS(unsigned long offset,
+						unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000080ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_STATS_PKTS_BAD(unsigned long offset,
+						    unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080000C0ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_STATS_PKTS_CTL(unsigned long offset,
+						    unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000090ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_STATS_PKTS_DMAC(unsigned long offset,
+						     unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080000A0ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_STATS_PKTS_DRP(unsigned long offset,
+						    unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080000B0ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RXX_UDD_SKP(unsigned long offset,
+					     unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000048ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_RX_BP_DROPX(unsigned long offset,
+					     unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000420ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x1000000ull) * 8;
+}
+
+static inline uint64_t CVMX_GMXX_RX_BP_OFFX(unsigned long offset,
+					    unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000460ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x1000000ull) * 8;
+}
+
+static inline uint64_t CVMX_GMXX_RX_BP_ONX(unsigned long offset,
+					   unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000440ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x1000000ull) * 8;
+}
+
+static inline uint64_t CVMX_GMXX_RX_HG2_STATUS(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000548ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_RX_PASS_EN(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080005F8ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_RX_PASS_MAPX(unsigned long offset,
+					      unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000600ull) + ((offset & 15) +
+							 (block_id & 1) *
+							 0x1000000ull) * 8;
+}
+
+static inline uint64_t CVMX_GMXX_RX_PRTS(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000410ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_RX_PRT_INFO(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080004E8ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_RX_TX_STATUS(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080007E8ull) +
+	    (block_id & 0) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_RX_XAUI_BAD_COL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000538ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_RX_XAUI_CTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000530ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_SMACX(unsigned long offset,
+				       unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000230ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_STAT_BP(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000520ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_TXX_APPEND(unsigned long offset,
+					    unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000218ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_TXX_BURST(unsigned long offset,
+					   unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000228ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_TXX_CBFC_XOFF(unsigned long offset,
+					       unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080005A0ull) + ((offset & 0) +
+							 (block_id & 1) *
+							 0x1000000ull) * 8;
+}
+
+static inline uint64_t CVMX_GMXX_TXX_CBFC_XON(unsigned long offset,
+					      unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080005C0ull) + ((offset & 0) +
+							 (block_id & 1) *
+							 0x1000000ull) * 8;
+}
+
+static inline uint64_t CVMX_GMXX_TXX_CLK(unsigned long offset,
+					 unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000208ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_TXX_CTL(unsigned long offset,
+					 unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000270ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_TXX_MIN_PKT(unsigned long offset,
+					     unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000240ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_TXX_PAUSE_PKT_INTERVAL(unsigned long offset,
+							unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000248ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_TXX_PAUSE_PKT_TIME(unsigned long offset,
+						    unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000238ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_TXX_PAUSE_TOGO(unsigned long offset,
+						unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000258ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_TXX_PAUSE_ZERO(unsigned long offset,
+						unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000260ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_TXX_SGMII_CTL(unsigned long offset,
+					       unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000300ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_TXX_SLOT(unsigned long offset,
+					  unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000220ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_TXX_SOFT_PAUSE(unsigned long offset,
+						unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000250ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_TXX_STAT0(unsigned long offset,
+					   unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000280ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_TXX_STAT1(unsigned long offset,
+					   unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000288ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_TXX_STAT2(unsigned long offset,
+					   unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000290ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_TXX_STAT3(unsigned long offset,
+					   unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000298ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_TXX_STAT4(unsigned long offset,
+					   unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080002A0ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_TXX_STAT5(unsigned long offset,
+					   unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080002A8ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_TXX_STAT6(unsigned long offset,
+					   unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080002B0ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_TXX_STAT7(unsigned long offset,
+					   unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080002B8ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_TXX_STAT8(unsigned long offset,
+					   unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080002C0ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_TXX_STAT9(unsigned long offset,
+					   unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080002C8ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_TXX_STATS_CTL(unsigned long offset,
+					       unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000268ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_TXX_THRESH(unsigned long offset,
+					    unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000210ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x10000ull) * 2048;
+}
+
+static inline uint64_t CVMX_GMXX_TX_BP(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080004D0ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_TX_CLK_MSKX(unsigned long offset,
+					     unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000780ull) + ((offset & 1) +
+							 (block_id & 0) *
+							 0x0ull) * 8;
+}
+
+static inline uint64_t CVMX_GMXX_TX_COL_ATTEMPT(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000498ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_TX_CORRUPT(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080004D8ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_TX_HG2_REG1(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000558ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_TX_HG2_REG2(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000560ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_TX_IFG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000488ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_TX_INT_EN(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000508ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_TX_INT_REG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000500ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_TX_JAM(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000490ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_TX_LFSR(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080004F8ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_TX_OVR_BP(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080004C8ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_TX_PAUSE_PKT_DMAC(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080004A0ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_TX_PAUSE_PKT_TYPE(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080004A8ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_TX_PRTS(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000480ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_TX_SPI_CTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080004C0ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_TX_SPI_DRAIN(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080004E0ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_TX_SPI_MAX(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080004B0ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_TX_SPI_ROUNDX(unsigned long offset,
+					       unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000680ull) + ((offset & 31) +
+							 (block_id & 1) *
+							 0x1000000ull) * 8;
+}
+
+static inline uint64_t CVMX_GMXX_TX_SPI_THRESH(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800080004B8ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_TX_XAUI_CTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000528ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GMXX_XAUI_EXT_LOOPBACK(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180008000540ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_GPIO_BIT_CFGX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000800ull) + (offset & 15) * 8;
+}
+
+#define CVMX_GPIO_BOOT_ENA CVMX_GPIO_BOOT_ENA_FUNC()
+static inline uint64_t CVMX_GPIO_BOOT_ENA_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00010700000008A8ull);
+}
+
+static inline uint64_t CVMX_GPIO_CLK_GENX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00010700000008C0ull) + (offset & 3) * 8;
+}
+
+#define CVMX_GPIO_DBG_ENA CVMX_GPIO_DBG_ENA_FUNC()
+static inline uint64_t CVMX_GPIO_DBG_ENA_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00010700000008A0ull);
+}
+
+#define CVMX_GPIO_INT_CLR CVMX_GPIO_INT_CLR_FUNC()
+static inline uint64_t CVMX_GPIO_INT_CLR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000898ull);
+}
+
+#define CVMX_GPIO_RX_DAT CVMX_GPIO_RX_DAT_FUNC()
+static inline uint64_t CVMX_GPIO_RX_DAT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000880ull);
+}
+
+#define CVMX_GPIO_TX_CLR CVMX_GPIO_TX_CLR_FUNC()
+static inline uint64_t CVMX_GPIO_TX_CLR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000890ull);
+}
+
+#define CVMX_GPIO_TX_SET CVMX_GPIO_TX_SET_FUNC()
+static inline uint64_t CVMX_GPIO_TX_SET_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000888ull);
+}
+
+static inline uint64_t CVMX_GPIO_XBIT_CFGX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000000900ull) + (offset & 31) * 8 -
+	    8 * 16;
+}
+
+#define CVMX_IOB_BIST_STATUS CVMX_IOB_BIST_STATUS_FUNC()
+static inline uint64_t CVMX_IOB_BIST_STATUS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800F00007F8ull);
+}
+
+#define CVMX_IOB_CTL_STATUS CVMX_IOB_CTL_STATUS_FUNC()
+static inline uint64_t CVMX_IOB_CTL_STATUS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800F0000050ull);
+}
+
+#define CVMX_IOB_DWB_PRI_CNT CVMX_IOB_DWB_PRI_CNT_FUNC()
+static inline uint64_t CVMX_IOB_DWB_PRI_CNT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800F0000028ull);
+}
+
+#define CVMX_IOB_FAU_TIMEOUT CVMX_IOB_FAU_TIMEOUT_FUNC()
+static inline uint64_t CVMX_IOB_FAU_TIMEOUT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800F0000000ull);
+}
+
+#define CVMX_IOB_I2C_PRI_CNT CVMX_IOB_I2C_PRI_CNT_FUNC()
+static inline uint64_t CVMX_IOB_I2C_PRI_CNT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800F0000010ull);
+}
+
+#define CVMX_IOB_INB_CONTROL_MATCH CVMX_IOB_INB_CONTROL_MATCH_FUNC()
+static inline uint64_t CVMX_IOB_INB_CONTROL_MATCH_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800F0000078ull);
+}
+
+#define CVMX_IOB_INB_CONTROL_MATCH_ENB CVMX_IOB_INB_CONTROL_MATCH_ENB_FUNC()
+static inline uint64_t CVMX_IOB_INB_CONTROL_MATCH_ENB_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800F0000088ull);
+}
+
+#define CVMX_IOB_INB_DATA_MATCH CVMX_IOB_INB_DATA_MATCH_FUNC()
+static inline uint64_t CVMX_IOB_INB_DATA_MATCH_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800F0000070ull);
+}
+
+#define CVMX_IOB_INB_DATA_MATCH_ENB CVMX_IOB_INB_DATA_MATCH_ENB_FUNC()
+static inline uint64_t CVMX_IOB_INB_DATA_MATCH_ENB_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800F0000080ull);
+}
+
+#define CVMX_IOB_INT_ENB CVMX_IOB_INT_ENB_FUNC()
+static inline uint64_t CVMX_IOB_INT_ENB_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800F0000060ull);
+}
+
+#define CVMX_IOB_INT_SUM CVMX_IOB_INT_SUM_FUNC()
+static inline uint64_t CVMX_IOB_INT_SUM_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800F0000058ull);
+}
+
+#define CVMX_IOB_N2C_L2C_PRI_CNT CVMX_IOB_N2C_L2C_PRI_CNT_FUNC()
+static inline uint64_t CVMX_IOB_N2C_L2C_PRI_CNT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800F0000020ull);
+}
+
+#define CVMX_IOB_N2C_RSP_PRI_CNT CVMX_IOB_N2C_RSP_PRI_CNT_FUNC()
+static inline uint64_t CVMX_IOB_N2C_RSP_PRI_CNT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800F0000008ull);
+}
+
+#define CVMX_IOB_OUTB_COM_PRI_CNT CVMX_IOB_OUTB_COM_PRI_CNT_FUNC()
+static inline uint64_t CVMX_IOB_OUTB_COM_PRI_CNT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800F0000040ull);
+}
+
+#define CVMX_IOB_OUTB_CONTROL_MATCH CVMX_IOB_OUTB_CONTROL_MATCH_FUNC()
+static inline uint64_t CVMX_IOB_OUTB_CONTROL_MATCH_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800F0000098ull);
+}
+
+#define CVMX_IOB_OUTB_CONTROL_MATCH_ENB CVMX_IOB_OUTB_CONTROL_MATCH_ENB_FUNC()
+static inline uint64_t CVMX_IOB_OUTB_CONTROL_MATCH_ENB_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800F00000A8ull);
+}
+
+#define CVMX_IOB_OUTB_DATA_MATCH CVMX_IOB_OUTB_DATA_MATCH_FUNC()
+static inline uint64_t CVMX_IOB_OUTB_DATA_MATCH_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800F0000090ull);
+}
+
+#define CVMX_IOB_OUTB_DATA_MATCH_ENB CVMX_IOB_OUTB_DATA_MATCH_ENB_FUNC()
+static inline uint64_t CVMX_IOB_OUTB_DATA_MATCH_ENB_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800F00000A0ull);
+}
+
+#define CVMX_IOB_OUTB_FPA_PRI_CNT CVMX_IOB_OUTB_FPA_PRI_CNT_FUNC()
+static inline uint64_t CVMX_IOB_OUTB_FPA_PRI_CNT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800F0000048ull);
+}
+
+#define CVMX_IOB_OUTB_REQ_PRI_CNT CVMX_IOB_OUTB_REQ_PRI_CNT_FUNC()
+static inline uint64_t CVMX_IOB_OUTB_REQ_PRI_CNT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800F0000038ull);
+}
+
+#define CVMX_IOB_P2C_REQ_PRI_CNT CVMX_IOB_P2C_REQ_PRI_CNT_FUNC()
+static inline uint64_t CVMX_IOB_P2C_REQ_PRI_CNT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800F0000018ull);
+}
+
+#define CVMX_IOB_PKT_ERR CVMX_IOB_PKT_ERR_FUNC()
+static inline uint64_t CVMX_IOB_PKT_ERR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800F0000068ull);
+}
+
+#define CVMX_IPD_1ST_MBUFF_SKIP CVMX_IPD_1ST_MBUFF_SKIP_FUNC()
+static inline uint64_t CVMX_IPD_1ST_MBUFF_SKIP_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00014F0000000000ull);
+}
+
+#define CVMX_IPD_1st_NEXT_PTR_BACK CVMX_IPD_1st_NEXT_PTR_BACK_FUNC()
+static inline uint64_t CVMX_IPD_1st_NEXT_PTR_BACK_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00014F0000000150ull);
+}
+
+#define CVMX_IPD_2nd_NEXT_PTR_BACK CVMX_IPD_2nd_NEXT_PTR_BACK_FUNC()
+static inline uint64_t CVMX_IPD_2nd_NEXT_PTR_BACK_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00014F0000000158ull);
+}
+
+#define CVMX_IPD_BIST_STATUS CVMX_IPD_BIST_STATUS_FUNC()
+static inline uint64_t CVMX_IPD_BIST_STATUS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00014F00000007F8ull);
+}
+
+#define CVMX_IPD_BP_PRT_RED_END CVMX_IPD_BP_PRT_RED_END_FUNC()
+static inline uint64_t CVMX_IPD_BP_PRT_RED_END_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00014F0000000328ull);
+}
+
+#define CVMX_IPD_CLK_COUNT CVMX_IPD_CLK_COUNT_FUNC()
+static inline uint64_t CVMX_IPD_CLK_COUNT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00014F0000000338ull);
+}
+
+#define CVMX_IPD_CTL_STATUS CVMX_IPD_CTL_STATUS_FUNC()
+static inline uint64_t CVMX_IPD_CTL_STATUS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00014F0000000018ull);
+}
+
+#define CVMX_IPD_INT_ENB CVMX_IPD_INT_ENB_FUNC()
+static inline uint64_t CVMX_IPD_INT_ENB_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00014F0000000160ull);
+}
+
+#define CVMX_IPD_INT_SUM CVMX_IPD_INT_SUM_FUNC()
+static inline uint64_t CVMX_IPD_INT_SUM_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00014F0000000168ull);
+}
+
+#define CVMX_IPD_NOT_1ST_MBUFF_SKIP CVMX_IPD_NOT_1ST_MBUFF_SKIP_FUNC()
+static inline uint64_t CVMX_IPD_NOT_1ST_MBUFF_SKIP_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00014F0000000008ull);
+}
+
+#define CVMX_IPD_PACKET_MBUFF_SIZE CVMX_IPD_PACKET_MBUFF_SIZE_FUNC()
+static inline uint64_t CVMX_IPD_PACKET_MBUFF_SIZE_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00014F0000000010ull);
+}
+
+#define CVMX_IPD_PKT_PTR_VALID CVMX_IPD_PKT_PTR_VALID_FUNC()
+static inline uint64_t CVMX_IPD_PKT_PTR_VALID_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00014F0000000358ull);
+}
+
+static inline uint64_t CVMX_IPD_PORTX_BP_PAGE_CNT(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00014F0000000028ull) + (offset & 63) * 8;
+}
+
+static inline uint64_t CVMX_IPD_PORTX_BP_PAGE_CNT2(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00014F0000000368ull) + (offset & 63) * 8 -
+	    8 * 36;
+}
+
+static inline uint64_t CVMX_IPD_PORT_BP_COUNTERS2_PAIRX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00014F0000000388ull) + (offset & 63) * 8 -
+	    8 * 36;
+}
+
+static inline uint64_t CVMX_IPD_PORT_BP_COUNTERS_PAIRX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00014F00000001B8ull) + (offset & 63) * 8;
+}
+
+static inline uint64_t CVMX_IPD_PORT_QOS_INTX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00014F0000000808ull) + (offset & 7) * 8;
+}
+
+static inline uint64_t CVMX_IPD_PORT_QOS_INT_ENBX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00014F0000000848ull) + (offset & 7) * 8;
+}
+
+static inline uint64_t CVMX_IPD_PORT_QOS_X_CNT(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00014F0000000888ull) + (offset & 511) * 8;
+}
+
+#define CVMX_IPD_PRC_HOLD_PTR_FIFO_CTL CVMX_IPD_PRC_HOLD_PTR_FIFO_CTL_FUNC()
+static inline uint64_t CVMX_IPD_PRC_HOLD_PTR_FIFO_CTL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00014F0000000348ull);
+}
+
+#define CVMX_IPD_PRC_PORT_PTR_FIFO_CTL CVMX_IPD_PRC_PORT_PTR_FIFO_CTL_FUNC()
+static inline uint64_t CVMX_IPD_PRC_PORT_PTR_FIFO_CTL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00014F0000000350ull);
+}
+
+#define CVMX_IPD_PTR_COUNT CVMX_IPD_PTR_COUNT_FUNC()
+static inline uint64_t CVMX_IPD_PTR_COUNT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00014F0000000320ull);
+}
+
+#define CVMX_IPD_PWP_PTR_FIFO_CTL CVMX_IPD_PWP_PTR_FIFO_CTL_FUNC()
+static inline uint64_t CVMX_IPD_PWP_PTR_FIFO_CTL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00014F0000000340ull);
+}
+
+#define CVMX_IPD_QOS0_RED_MARKS CVMX_IPD_QOSX_RED_MARKS(0)
+#define CVMX_IPD_QOS1_RED_MARKS CVMX_IPD_QOSX_RED_MARKS(1)
+#define CVMX_IPD_QOS2_RED_MARKS CVMX_IPD_QOSX_RED_MARKS(2)
+#define CVMX_IPD_QOS3_RED_MARKS CVMX_IPD_QOSX_RED_MARKS(3)
+#define CVMX_IPD_QOS4_RED_MARKS CVMX_IPD_QOSX_RED_MARKS(4)
+#define CVMX_IPD_QOS5_RED_MARKS CVMX_IPD_QOSX_RED_MARKS(5)
+#define CVMX_IPD_QOS6_RED_MARKS CVMX_IPD_QOSX_RED_MARKS(6)
+#define CVMX_IPD_QOS7_RED_MARKS CVMX_IPD_QOSX_RED_MARKS(7)
+static inline uint64_t CVMX_IPD_QOSX_RED_MARKS(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00014F0000000178ull) + (offset & 7) * 8;
+}
+
+#define CVMX_IPD_QUE0_FREE_PAGE_CNT CVMX_IPD_QUE0_FREE_PAGE_CNT_FUNC()
+static inline uint64_t CVMX_IPD_QUE0_FREE_PAGE_CNT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00014F0000000330ull);
+}
+
+#define CVMX_IPD_RED_PORT_ENABLE CVMX_IPD_RED_PORT_ENABLE_FUNC()
+static inline uint64_t CVMX_IPD_RED_PORT_ENABLE_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00014F00000002D8ull);
+}
+
+#define CVMX_IPD_RED_PORT_ENABLE2 CVMX_IPD_RED_PORT_ENABLE2_FUNC()
+static inline uint64_t CVMX_IPD_RED_PORT_ENABLE2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00014F00000003A8ull);
+}
+
+#define CVMX_IPD_RED_QUE0_PARAM CVMX_IPD_RED_QUEX_PARAM(0)
+#define CVMX_IPD_RED_QUE1_PARAM CVMX_IPD_RED_QUEX_PARAM(1)
+#define CVMX_IPD_RED_QUE2_PARAM CVMX_IPD_RED_QUEX_PARAM(2)
+#define CVMX_IPD_RED_QUE3_PARAM CVMX_IPD_RED_QUEX_PARAM(3)
+#define CVMX_IPD_RED_QUE4_PARAM CVMX_IPD_RED_QUEX_PARAM(4)
+#define CVMX_IPD_RED_QUE5_PARAM CVMX_IPD_RED_QUEX_PARAM(5)
+#define CVMX_IPD_RED_QUE6_PARAM CVMX_IPD_RED_QUEX_PARAM(6)
+#define CVMX_IPD_RED_QUE7_PARAM CVMX_IPD_RED_QUEX_PARAM(7)
+static inline uint64_t CVMX_IPD_RED_QUEX_PARAM(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00014F00000002E0ull) + (offset & 7) * 8;
+}
+
+#define CVMX_IPD_SUB_PORT_BP_PAGE_CNT CVMX_IPD_SUB_PORT_BP_PAGE_CNT_FUNC()
+static inline uint64_t CVMX_IPD_SUB_PORT_BP_PAGE_CNT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00014F0000000148ull);
+}
+
+#define CVMX_IPD_SUB_PORT_FCS CVMX_IPD_SUB_PORT_FCS_FUNC()
+static inline uint64_t CVMX_IPD_SUB_PORT_FCS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00014F0000000170ull);
+}
+
+#define CVMX_IPD_SUB_PORT_QOS_CNT CVMX_IPD_SUB_PORT_QOS_CNT_FUNC()
+static inline uint64_t CVMX_IPD_SUB_PORT_QOS_CNT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00014F0000000800ull);
+}
+
+#define CVMX_IPD_WQE_FPA_QUEUE CVMX_IPD_WQE_FPA_QUEUE_FUNC()
+static inline uint64_t CVMX_IPD_WQE_FPA_QUEUE_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00014F0000000020ull);
+}
+
+#define CVMX_IPD_WQE_PTR_VALID CVMX_IPD_WQE_PTR_VALID_FUNC()
+static inline uint64_t CVMX_IPD_WQE_PTR_VALID_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00014F0000000360ull);
+}
+
+#define CVMX_KEY_BIST_REG CVMX_KEY_BIST_REG_FUNC()
+static inline uint64_t CVMX_KEY_BIST_REG_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180020000018ull);
+}
+
+#define CVMX_KEY_CTL_STATUS CVMX_KEY_CTL_STATUS_FUNC()
+static inline uint64_t CVMX_KEY_CTL_STATUS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180020000010ull);
+}
+
+#define CVMX_KEY_INT_ENB CVMX_KEY_INT_ENB_FUNC()
+static inline uint64_t CVMX_KEY_INT_ENB_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180020000008ull);
+}
+
+#define CVMX_KEY_INT_SUM CVMX_KEY_INT_SUM_FUNC()
+static inline uint64_t CVMX_KEY_INT_SUM_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180020000000ull);
+}
+
+#define CVMX_L2C_BST0 CVMX_L2C_BST0_FUNC()
+static inline uint64_t CVMX_L2C_BST0_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800800007F8ull);
+}
+
+#define CVMX_L2C_BST1 CVMX_L2C_BST1_FUNC()
+static inline uint64_t CVMX_L2C_BST1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800800007F0ull);
+}
+
+#define CVMX_L2C_BST2 CVMX_L2C_BST2_FUNC()
+static inline uint64_t CVMX_L2C_BST2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800800007E8ull);
+}
+
+#define CVMX_L2C_CFG CVMX_L2C_CFG_FUNC()
+static inline uint64_t CVMX_L2C_CFG_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180080000000ull);
+}
+
+#define CVMX_L2C_DBG CVMX_L2C_DBG_FUNC()
+static inline uint64_t CVMX_L2C_DBG_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180080000030ull);
+}
+
+#define CVMX_L2C_DUT CVMX_L2C_DUT_FUNC()
+static inline uint64_t CVMX_L2C_DUT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180080000050ull);
+}
+
+#define CVMX_L2C_GRPWRR0 CVMX_L2C_GRPWRR0_FUNC()
+static inline uint64_t CVMX_L2C_GRPWRR0_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800800000C8ull);
+}
+
+#define CVMX_L2C_GRPWRR1 CVMX_L2C_GRPWRR1_FUNC()
+static inline uint64_t CVMX_L2C_GRPWRR1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800800000D0ull);
+}
+
+#define CVMX_L2C_INT_EN CVMX_L2C_INT_EN_FUNC()
+static inline uint64_t CVMX_L2C_INT_EN_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180080000100ull);
+}
+
+#define CVMX_L2C_INT_STAT CVMX_L2C_INT_STAT_FUNC()
+static inline uint64_t CVMX_L2C_INT_STAT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800800000F8ull);
+}
+
+#define CVMX_L2C_LCKBASE CVMX_L2C_LCKBASE_FUNC()
+static inline uint64_t CVMX_L2C_LCKBASE_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180080000058ull);
+}
+
+#define CVMX_L2C_LCKOFF CVMX_L2C_LCKOFF_FUNC()
+static inline uint64_t CVMX_L2C_LCKOFF_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180080000060ull);
+}
+
+#define CVMX_L2C_LFB0 CVMX_L2C_LFB0_FUNC()
+static inline uint64_t CVMX_L2C_LFB0_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180080000038ull);
+}
+
+#define CVMX_L2C_LFB1 CVMX_L2C_LFB1_FUNC()
+static inline uint64_t CVMX_L2C_LFB1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180080000040ull);
+}
+
+#define CVMX_L2C_LFB2 CVMX_L2C_LFB2_FUNC()
+static inline uint64_t CVMX_L2C_LFB2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180080000048ull);
+}
+
+#define CVMX_L2C_LFB3 CVMX_L2C_LFB3_FUNC()
+static inline uint64_t CVMX_L2C_LFB3_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800800000B8ull);
+}
+
+#define CVMX_L2C_OOB CVMX_L2C_OOB_FUNC()
+static inline uint64_t CVMX_L2C_OOB_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800800000D8ull);
+}
+
+#define CVMX_L2C_OOB1 CVMX_L2C_OOB1_FUNC()
+static inline uint64_t CVMX_L2C_OOB1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800800000E0ull);
+}
+
+#define CVMX_L2C_OOB2 CVMX_L2C_OOB2_FUNC()
+static inline uint64_t CVMX_L2C_OOB2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800800000E8ull);
+}
+
+#define CVMX_L2C_OOB3 CVMX_L2C_OOB3_FUNC()
+static inline uint64_t CVMX_L2C_OOB3_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800800000F0ull);
+}
+
+#define CVMX_L2C_PFC0 CVMX_L2C_PFCX(0)
+#define CVMX_L2C_PFC1 CVMX_L2C_PFCX(1)
+#define CVMX_L2C_PFC2 CVMX_L2C_PFCX(2)
+#define CVMX_L2C_PFC3 CVMX_L2C_PFCX(3)
+#define CVMX_L2C_PFCTL CVMX_L2C_PFCTL_FUNC()
+static inline uint64_t CVMX_L2C_PFCTL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180080000090ull);
+}
+
+static inline uint64_t CVMX_L2C_PFCX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180080000098ull) + (offset & 3) * 8;
+}
+
+#define CVMX_L2C_PPGRP CVMX_L2C_PPGRP_FUNC()
+static inline uint64_t CVMX_L2C_PPGRP_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800800000C0ull);
+}
+
+#define CVMX_L2C_SPAR0 CVMX_L2C_SPAR0_FUNC()
+static inline uint64_t CVMX_L2C_SPAR0_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180080000068ull);
+}
+
+#define CVMX_L2C_SPAR1 CVMX_L2C_SPAR1_FUNC()
+static inline uint64_t CVMX_L2C_SPAR1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180080000070ull);
+}
+
+#define CVMX_L2C_SPAR2 CVMX_L2C_SPAR2_FUNC()
+static inline uint64_t CVMX_L2C_SPAR2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180080000078ull);
+}
+
+#define CVMX_L2C_SPAR3 CVMX_L2C_SPAR3_FUNC()
+static inline uint64_t CVMX_L2C_SPAR3_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180080000080ull);
+}
+
+#define CVMX_L2C_SPAR4 CVMX_L2C_SPAR4_FUNC()
+static inline uint64_t CVMX_L2C_SPAR4_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180080000088ull);
+}
+
+#define CVMX_L2D_BST0 CVMX_L2D_BST0_FUNC()
+static inline uint64_t CVMX_L2D_BST0_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180080000780ull);
+}
+
+#define CVMX_L2D_BST1 CVMX_L2D_BST1_FUNC()
+static inline uint64_t CVMX_L2D_BST1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180080000788ull);
+}
+
+#define CVMX_L2D_BST2 CVMX_L2D_BST2_FUNC()
+static inline uint64_t CVMX_L2D_BST2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180080000790ull);
+}
+
+#define CVMX_L2D_BST3 CVMX_L2D_BST3_FUNC()
+static inline uint64_t CVMX_L2D_BST3_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180080000798ull);
+}
+
+#define CVMX_L2D_ERR CVMX_L2D_ERR_FUNC()
+static inline uint64_t CVMX_L2D_ERR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180080000010ull);
+}
+
+#define CVMX_L2D_FADR CVMX_L2D_FADR_FUNC()
+static inline uint64_t CVMX_L2D_FADR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180080000018ull);
+}
+
+#define CVMX_L2D_FSYN0 CVMX_L2D_FSYN0_FUNC()
+static inline uint64_t CVMX_L2D_FSYN0_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180080000020ull);
+}
+
+#define CVMX_L2D_FSYN1 CVMX_L2D_FSYN1_FUNC()
+static inline uint64_t CVMX_L2D_FSYN1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180080000028ull);
+}
+
+#define CVMX_L2D_FUS0 CVMX_L2D_FUS0_FUNC()
+static inline uint64_t CVMX_L2D_FUS0_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800800007A0ull);
+}
+
+#define CVMX_L2D_FUS1 CVMX_L2D_FUS1_FUNC()
+static inline uint64_t CVMX_L2D_FUS1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800800007A8ull);
+}
+
+#define CVMX_L2D_FUS2 CVMX_L2D_FUS2_FUNC()
+static inline uint64_t CVMX_L2D_FUS2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800800007B0ull);
+}
+
+#define CVMX_L2D_FUS3 CVMX_L2D_FUS3_FUNC()
+static inline uint64_t CVMX_L2D_FUS3_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800800007B8ull);
+}
+
+#define CVMX_L2T_ERR CVMX_L2T_ERR_FUNC()
+static inline uint64_t CVMX_L2T_ERR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180080000008ull);
+}
+
+#define CVMX_LED_BLINK CVMX_LED_BLINK_FUNC()
+static inline uint64_t CVMX_LED_BLINK_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001A48ull);
+}
+
+#define CVMX_LED_CLK_PHASE CVMX_LED_CLK_PHASE_FUNC()
+static inline uint64_t CVMX_LED_CLK_PHASE_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001A08ull);
+}
+
+#define CVMX_LED_CYLON CVMX_LED_CYLON_FUNC()
+static inline uint64_t CVMX_LED_CYLON_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001AF8ull);
+}
+
+#define CVMX_LED_DBG CVMX_LED_DBG_FUNC()
+static inline uint64_t CVMX_LED_DBG_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001A18ull);
+}
+
+#define CVMX_LED_EN CVMX_LED_EN_FUNC()
+static inline uint64_t CVMX_LED_EN_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001A00ull);
+}
+
+#define CVMX_LED_POLARITY CVMX_LED_POLARITY_FUNC()
+static inline uint64_t CVMX_LED_POLARITY_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001A50ull);
+}
+
+#define CVMX_LED_PRT CVMX_LED_PRT_FUNC()
+static inline uint64_t CVMX_LED_PRT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001A10ull);
+}
+
+#define CVMX_LED_PRT_FMT CVMX_LED_PRT_FMT_FUNC()
+static inline uint64_t CVMX_LED_PRT_FMT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001A30ull);
+}
+
+static inline uint64_t CVMX_LED_PRT_STATUSX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001A80ull) + (offset & 7) * 8;
+}
+
+static inline uint64_t CVMX_LED_UDD_CNTX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001A20ull) + (offset & 1) * 8;
+}
+
+static inline uint64_t CVMX_LED_UDD_DATX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001A38ull) + (offset & 1) * 8;
+}
+
+static inline uint64_t CVMX_LED_UDD_DAT_CLRX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001AC8ull) + (offset & 1) * 16;
+}
+
+static inline uint64_t CVMX_LED_UDD_DAT_SETX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001AC0ull) + (offset & 1) * 16;
+}
+
+static inline uint64_t CVMX_LMCX_BIST_CTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800880000F0ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_BIST_RESULT(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800880000F8ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_COMP_CTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180088000028ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_CTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180088000010ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_CTL1(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180088000090ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_DCLK_CNT_HI(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180088000070ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_DCLK_CNT_LO(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180088000068ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_DCLK_CTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800880000B8ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_DDR2_CTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180088000018ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_DELAY_CFG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180088000088ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_DLL_CTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800880000C0ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_DUAL_MEMCFG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180088000098ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_ECC_SYND(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180088000038ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_FADR(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180088000020ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_IFB_CNT_HI(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180088000050ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_IFB_CNT_LO(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180088000048ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_MEM_CFG0(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180088000000ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_MEM_CFG1(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180088000008ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_NXM(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800880000C8ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_OPS_CNT_HI(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180088000060ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_OPS_CNT_LO(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180088000058ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_PLL_BWCTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180088000040ull) +
+	    (block_id & 0) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_PLL_CTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800880000A8ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_PLL_STATUS(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800880000B0ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_READ_LEVEL_CTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180088000140ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_READ_LEVEL_DBG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180088000148ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_READ_LEVEL_RANKX(unsigned long offset,
+						  unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180088000100ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0xC000000ull) * 8;
+}
+
+static inline uint64_t CVMX_LMCX_RODT_COMP_CTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800880000A0ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_RODT_CTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180088000078ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_WODT_CTL0(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180088000030ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+static inline uint64_t CVMX_LMCX_WODT_CTL1(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180088000080ull) +
+	    (block_id & 1) * 0x60000000ull;
+}
+
+#define CVMX_MIO_BOOT_BIST_STAT CVMX_MIO_BOOT_BIST_STAT_FUNC()
+static inline uint64_t CVMX_MIO_BOOT_BIST_STAT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800000000F8ull);
+}
+
+#define CVMX_MIO_BOOT_COMP CVMX_MIO_BOOT_COMP_FUNC()
+static inline uint64_t CVMX_MIO_BOOT_COMP_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800000000B8ull);
+}
+
+static inline uint64_t CVMX_MIO_BOOT_DMA_CFGX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000100ull) + (offset & 3) * 8;
+}
+
+static inline uint64_t CVMX_MIO_BOOT_DMA_INTX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000138ull) + (offset & 3) * 8;
+}
+
+static inline uint64_t CVMX_MIO_BOOT_DMA_INT_ENX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000150ull) + (offset & 3) * 8;
+}
+
+static inline uint64_t CVMX_MIO_BOOT_DMA_TIMX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000120ull) + (offset & 3) * 8;
+}
+
+#define CVMX_MIO_BOOT_ERR CVMX_MIO_BOOT_ERR_FUNC()
+static inline uint64_t CVMX_MIO_BOOT_ERR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800000000A0ull);
+}
+
+#define CVMX_MIO_BOOT_INT CVMX_MIO_BOOT_INT_FUNC()
+static inline uint64_t CVMX_MIO_BOOT_INT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800000000A8ull);
+}
+
+#define CVMX_MIO_BOOT_LOC_ADR CVMX_MIO_BOOT_LOC_ADR_FUNC()
+static inline uint64_t CVMX_MIO_BOOT_LOC_ADR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000090ull);
+}
+
+static inline uint64_t CVMX_MIO_BOOT_LOC_CFGX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000080ull) + (offset & 1) * 8;
+}
+
+#define CVMX_MIO_BOOT_LOC_DAT CVMX_MIO_BOOT_LOC_DAT_FUNC()
+static inline uint64_t CVMX_MIO_BOOT_LOC_DAT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000098ull);
+}
+
+#define CVMX_MIO_BOOT_PIN_DEFS CVMX_MIO_BOOT_PIN_DEFS_FUNC()
+static inline uint64_t CVMX_MIO_BOOT_PIN_DEFS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800000000C0ull);
+}
+
+static inline uint64_t CVMX_MIO_BOOT_REG_CFGX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000000ull) + (offset & 7) * 8;
+}
+
+static inline uint64_t CVMX_MIO_BOOT_REG_TIMX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000040ull) + (offset & 7) * 8;
+}
+
+#define CVMX_MIO_BOOT_THR CVMX_MIO_BOOT_THR_FUNC()
+static inline uint64_t CVMX_MIO_BOOT_THR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800000000B0ull);
+}
+
+static inline uint64_t CVMX_MIO_FUS_BNK_DATX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001520ull) + (offset & 3) * 8;
+}
+
+#define CVMX_MIO_FUS_DAT0 CVMX_MIO_FUS_DAT0_FUNC()
+static inline uint64_t CVMX_MIO_FUS_DAT0_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001400ull);
+}
+
+#define CVMX_MIO_FUS_DAT1 CVMX_MIO_FUS_DAT1_FUNC()
+static inline uint64_t CVMX_MIO_FUS_DAT1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001408ull);
+}
+
+#define CVMX_MIO_FUS_DAT2 CVMX_MIO_FUS_DAT2_FUNC()
+static inline uint64_t CVMX_MIO_FUS_DAT2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001410ull);
+}
+
+#define CVMX_MIO_FUS_DAT3 CVMX_MIO_FUS_DAT3_FUNC()
+static inline uint64_t CVMX_MIO_FUS_DAT3_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001418ull);
+}
+
+#define CVMX_MIO_FUS_EMA CVMX_MIO_FUS_EMA_FUNC()
+static inline uint64_t CVMX_MIO_FUS_EMA_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001550ull);
+}
+
+#define CVMX_MIO_FUS_PDF CVMX_MIO_FUS_PDF_FUNC()
+static inline uint64_t CVMX_MIO_FUS_PDF_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001420ull);
+}
+
+#define CVMX_MIO_FUS_PLL CVMX_MIO_FUS_PLL_FUNC()
+static inline uint64_t CVMX_MIO_FUS_PLL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001580ull);
+}
+
+#define CVMX_MIO_FUS_PROG CVMX_MIO_FUS_PROG_FUNC()
+static inline uint64_t CVMX_MIO_FUS_PROG_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001510ull);
+}
+
+#define CVMX_MIO_FUS_PROG_TIMES CVMX_MIO_FUS_PROG_TIMES_FUNC()
+static inline uint64_t CVMX_MIO_FUS_PROG_TIMES_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001518ull);
+}
+
+#define CVMX_MIO_FUS_RCMD CVMX_MIO_FUS_RCMD_FUNC()
+static inline uint64_t CVMX_MIO_FUS_RCMD_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001500ull);
+}
+
+#define CVMX_MIO_FUS_SPR_REPAIR_RES CVMX_MIO_FUS_SPR_REPAIR_RES_FUNC()
+static inline uint64_t CVMX_MIO_FUS_SPR_REPAIR_RES_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001548ull);
+}
+
+#define CVMX_MIO_FUS_SPR_REPAIR_SUM CVMX_MIO_FUS_SPR_REPAIR_SUM_FUNC()
+static inline uint64_t CVMX_MIO_FUS_SPR_REPAIR_SUM_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001540ull);
+}
+
+#define CVMX_MIO_FUS_UNLOCK CVMX_MIO_FUS_UNLOCK_FUNC()
+static inline uint64_t CVMX_MIO_FUS_UNLOCK_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001578ull);
+}
+
+#define CVMX_MIO_FUS_WADR CVMX_MIO_FUS_WADR_FUNC()
+static inline uint64_t CVMX_MIO_FUS_WADR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001508ull);
+}
+
+#define CVMX_MIO_NDF_DMA_CFG CVMX_MIO_NDF_DMA_CFG_FUNC()
+static inline uint64_t CVMX_MIO_NDF_DMA_CFG_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000168ull);
+}
+
+#define CVMX_MIO_NDF_DMA_INT CVMX_MIO_NDF_DMA_INT_FUNC()
+static inline uint64_t CVMX_MIO_NDF_DMA_INT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000170ull);
+}
+
+#define CVMX_MIO_NDF_DMA_INT_EN CVMX_MIO_NDF_DMA_INT_EN_FUNC()
+static inline uint64_t CVMX_MIO_NDF_DMA_INT_EN_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000178ull);
+}
+
+#define CVMX_MIO_PLL_CTL CVMX_MIO_PLL_CTL_FUNC()
+static inline uint64_t CVMX_MIO_PLL_CTL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001448ull);
+}
+
+#define CVMX_MIO_PLL_SETTING CVMX_MIO_PLL_SETTING_FUNC()
+static inline uint64_t CVMX_MIO_PLL_SETTING_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001440ull);
+}
+
+static inline uint64_t CVMX_MIO_TWSX_INT(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001010ull) + (offset & 1) * 512;
+}
+
+static inline uint64_t CVMX_MIO_TWSX_SW_TWSI(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001000ull) + (offset & 1) * 512;
+}
+
+static inline uint64_t CVMX_MIO_TWSX_SW_TWSI_EXT(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001018ull) + (offset & 1) * 512;
+}
+
+static inline uint64_t CVMX_MIO_TWSX_TWSI_SW(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001008ull) + (offset & 1) * 512;
+}
+
+#define CVMX_MIO_UART2_DLH CVMX_MIO_UART2_DLH_FUNC()
+static inline uint64_t CVMX_MIO_UART2_DLH_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000488ull);
+}
+
+#define CVMX_MIO_UART2_DLL CVMX_MIO_UART2_DLL_FUNC()
+static inline uint64_t CVMX_MIO_UART2_DLL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000480ull);
+}
+
+#define CVMX_MIO_UART2_FAR CVMX_MIO_UART2_FAR_FUNC()
+static inline uint64_t CVMX_MIO_UART2_FAR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000520ull);
+}
+
+#define CVMX_MIO_UART2_FCR CVMX_MIO_UART2_FCR_FUNC()
+static inline uint64_t CVMX_MIO_UART2_FCR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000450ull);
+}
+
+#define CVMX_MIO_UART2_HTX CVMX_MIO_UART2_HTX_FUNC()
+static inline uint64_t CVMX_MIO_UART2_HTX_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000708ull);
+}
+
+#define CVMX_MIO_UART2_IER CVMX_MIO_UART2_IER_FUNC()
+static inline uint64_t CVMX_MIO_UART2_IER_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000408ull);
+}
+
+#define CVMX_MIO_UART2_IIR CVMX_MIO_UART2_IIR_FUNC()
+static inline uint64_t CVMX_MIO_UART2_IIR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000410ull);
+}
+
+#define CVMX_MIO_UART2_LCR CVMX_MIO_UART2_LCR_FUNC()
+static inline uint64_t CVMX_MIO_UART2_LCR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000418ull);
+}
+
+#define CVMX_MIO_UART2_LSR CVMX_MIO_UART2_LSR_FUNC()
+static inline uint64_t CVMX_MIO_UART2_LSR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000428ull);
+}
+
+#define CVMX_MIO_UART2_MCR CVMX_MIO_UART2_MCR_FUNC()
+static inline uint64_t CVMX_MIO_UART2_MCR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000420ull);
+}
+
+#define CVMX_MIO_UART2_MSR CVMX_MIO_UART2_MSR_FUNC()
+static inline uint64_t CVMX_MIO_UART2_MSR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000430ull);
+}
+
+#define CVMX_MIO_UART2_RBR CVMX_MIO_UART2_RBR_FUNC()
+static inline uint64_t CVMX_MIO_UART2_RBR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000400ull);
+}
+
+#define CVMX_MIO_UART2_RFL CVMX_MIO_UART2_RFL_FUNC()
+static inline uint64_t CVMX_MIO_UART2_RFL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000608ull);
+}
+
+#define CVMX_MIO_UART2_RFW CVMX_MIO_UART2_RFW_FUNC()
+static inline uint64_t CVMX_MIO_UART2_RFW_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000530ull);
+}
+
+#define CVMX_MIO_UART2_SBCR CVMX_MIO_UART2_SBCR_FUNC()
+static inline uint64_t CVMX_MIO_UART2_SBCR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000620ull);
+}
+
+#define CVMX_MIO_UART2_SCR CVMX_MIO_UART2_SCR_FUNC()
+static inline uint64_t CVMX_MIO_UART2_SCR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000438ull);
+}
+
+#define CVMX_MIO_UART2_SFE CVMX_MIO_UART2_SFE_FUNC()
+static inline uint64_t CVMX_MIO_UART2_SFE_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000630ull);
+}
+
+#define CVMX_MIO_UART2_SRR CVMX_MIO_UART2_SRR_FUNC()
+static inline uint64_t CVMX_MIO_UART2_SRR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000610ull);
+}
+
+#define CVMX_MIO_UART2_SRT CVMX_MIO_UART2_SRT_FUNC()
+static inline uint64_t CVMX_MIO_UART2_SRT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000638ull);
+}
+
+#define CVMX_MIO_UART2_SRTS CVMX_MIO_UART2_SRTS_FUNC()
+static inline uint64_t CVMX_MIO_UART2_SRTS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000618ull);
+}
+
+#define CVMX_MIO_UART2_STT CVMX_MIO_UART2_STT_FUNC()
+static inline uint64_t CVMX_MIO_UART2_STT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000700ull);
+}
+
+#define CVMX_MIO_UART2_TFL CVMX_MIO_UART2_TFL_FUNC()
+static inline uint64_t CVMX_MIO_UART2_TFL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000600ull);
+}
+
+#define CVMX_MIO_UART2_TFR CVMX_MIO_UART2_TFR_FUNC()
+static inline uint64_t CVMX_MIO_UART2_TFR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000528ull);
+}
+
+#define CVMX_MIO_UART2_THR CVMX_MIO_UART2_THR_FUNC()
+static inline uint64_t CVMX_MIO_UART2_THR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000440ull);
+}
+
+#define CVMX_MIO_UART2_USR CVMX_MIO_UART2_USR_FUNC()
+static inline uint64_t CVMX_MIO_UART2_USR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000538ull);
+}
+
+static inline uint64_t CVMX_MIO_UARTX_DLH(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000888ull) + (offset & 1) * 1024;
+}
+
+static inline uint64_t CVMX_MIO_UARTX_DLL(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000880ull) + (offset & 1) * 1024;
+}
+
+static inline uint64_t CVMX_MIO_UARTX_FAR(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000920ull) + (offset & 1) * 1024;
+}
+
+static inline uint64_t CVMX_MIO_UARTX_FCR(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000850ull) + (offset & 1) * 1024;
+}
+
+static inline uint64_t CVMX_MIO_UARTX_HTX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000B08ull) + (offset & 1) * 1024;
+}
+
+static inline uint64_t CVMX_MIO_UARTX_IER(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000808ull) + (offset & 1) * 1024;
+}
+
+static inline uint64_t CVMX_MIO_UARTX_IIR(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000810ull) + (offset & 1) * 1024;
+}
+
+static inline uint64_t CVMX_MIO_UARTX_LCR(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000818ull) + (offset & 1) * 1024;
+}
+
+static inline uint64_t CVMX_MIO_UARTX_LSR(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000828ull) + (offset & 1) * 1024;
+}
+
+static inline uint64_t CVMX_MIO_UARTX_MCR(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000820ull) + (offset & 1) * 1024;
+}
+
+static inline uint64_t CVMX_MIO_UARTX_MSR(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000830ull) + (offset & 1) * 1024;
+}
+
+static inline uint64_t CVMX_MIO_UARTX_RBR(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000800ull) + (offset & 1) * 1024;
+}
+
+static inline uint64_t CVMX_MIO_UARTX_RFL(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000A08ull) + (offset & 1) * 1024;
+}
+
+static inline uint64_t CVMX_MIO_UARTX_RFW(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000930ull) + (offset & 1) * 1024;
+}
+
+static inline uint64_t CVMX_MIO_UARTX_SBCR(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000A20ull) + (offset & 1) * 1024;
+}
+
+static inline uint64_t CVMX_MIO_UARTX_SCR(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000838ull) + (offset & 1) * 1024;
+}
+
+static inline uint64_t CVMX_MIO_UARTX_SFE(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000A30ull) + (offset & 1) * 1024;
+}
+
+static inline uint64_t CVMX_MIO_UARTX_SRR(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000A10ull) + (offset & 1) * 1024;
+}
+
+static inline uint64_t CVMX_MIO_UARTX_SRT(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000A38ull) + (offset & 1) * 1024;
+}
+
+static inline uint64_t CVMX_MIO_UARTX_SRTS(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000A18ull) + (offset & 1) * 1024;
+}
+
+static inline uint64_t CVMX_MIO_UARTX_STT(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000B00ull) + (offset & 1) * 1024;
+}
+
+static inline uint64_t CVMX_MIO_UARTX_TFL(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000A00ull) + (offset & 1) * 1024;
+}
+
+static inline uint64_t CVMX_MIO_UARTX_TFR(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000928ull) + (offset & 1) * 1024;
+}
+
+static inline uint64_t CVMX_MIO_UARTX_THR(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000840ull) + (offset & 1) * 1024;
+}
+
+static inline uint64_t CVMX_MIO_UARTX_USR(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000000938ull) + (offset & 1) * 1024;
+}
+
+static inline uint64_t CVMX_MIXX_BIST(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000100078ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_MIXX_CTL(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000100020ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_MIXX_INTENA(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000100050ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_MIXX_IRCNT(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000100030ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_MIXX_IRHWM(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000100028ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_MIXX_IRING1(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000100010ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_MIXX_IRING2(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000100018ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_MIXX_ISR(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000100048ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_MIXX_ORCNT(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000100040ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_MIXX_ORHWM(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000100038ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_MIXX_ORING1(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000100000ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_MIXX_ORING2(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000100008ull) + (offset & 1) * 2048;
+}
+
+static inline uint64_t CVMX_MIXX_REMCNT(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000100058ull) + (offset & 1) * 2048;
+}
+
+#define CVMX_MPI_CFG CVMX_MPI_CFG_FUNC()
+static inline uint64_t CVMX_MPI_CFG_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000001000ull);
+}
+
+static inline uint64_t CVMX_MPI_DATX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000001080ull) + (offset & 15) * 8;
+}
+
+#define CVMX_MPI_STS CVMX_MPI_STS_FUNC()
+static inline uint64_t CVMX_MPI_STS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000001008ull);
+}
+
+#define CVMX_MPI_TX CVMX_MPI_TX_FUNC()
+static inline uint64_t CVMX_MPI_TX_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000001010ull);
+}
+
+#define CVMX_NDF_BT_PG_INFO CVMX_NDF_BT_PG_INFO_FUNC()
+static inline uint64_t CVMX_NDF_BT_PG_INFO_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070001000018ull);
+}
+
+#define CVMX_NDF_CMD CVMX_NDF_CMD_FUNC()
+static inline uint64_t CVMX_NDF_CMD_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070001000000ull);
+}
+
+#define CVMX_NDF_DRBELL CVMX_NDF_DRBELL_FUNC()
+static inline uint64_t CVMX_NDF_DRBELL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070001000030ull);
+}
+
+#define CVMX_NDF_ECC_CNT CVMX_NDF_ECC_CNT_FUNC()
+static inline uint64_t CVMX_NDF_ECC_CNT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070001000010ull);
+}
+
+#define CVMX_NDF_INT CVMX_NDF_INT_FUNC()
+static inline uint64_t CVMX_NDF_INT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070001000020ull);
+}
+
+#define CVMX_NDF_INT_EN CVMX_NDF_INT_EN_FUNC()
+static inline uint64_t CVMX_NDF_INT_EN_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070001000028ull);
+}
+
+#define CVMX_NDF_MISC CVMX_NDF_MISC_FUNC()
+static inline uint64_t CVMX_NDF_MISC_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070001000008ull);
+}
+
+#define CVMX_NDF_ST_REG CVMX_NDF_ST_REG_FUNC()
+static inline uint64_t CVMX_NDF_ST_REG_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001070001000038ull);
+}
+
+static inline uint64_t CVMX_NPEI_BAR1_INDEXX(unsigned long offset)
+{
+	return 0x0000000000000000ull + (offset & 31) * 16;
+}
+
+#define CVMX_NPEI_BIST_STATUS CVMX_NPEI_BIST_STATUS_FUNC()
+static inline uint64_t CVMX_NPEI_BIST_STATUS_FUNC(void)
+{
+	return 0x0000000000000580ull;
+}
+
+#define CVMX_NPEI_BIST_STATUS2 CVMX_NPEI_BIST_STATUS2_FUNC()
+static inline uint64_t CVMX_NPEI_BIST_STATUS2_FUNC(void)
+{
+	return 0x0000000000000680ull;
+}
+
+#define CVMX_NPEI_CTL_PORT0 CVMX_NPEI_CTL_PORT0_FUNC()
+static inline uint64_t CVMX_NPEI_CTL_PORT0_FUNC(void)
+{
+	return 0x0000000000000250ull;
+}
+
+#define CVMX_NPEI_CTL_PORT1 CVMX_NPEI_CTL_PORT1_FUNC()
+static inline uint64_t CVMX_NPEI_CTL_PORT1_FUNC(void)
+{
+	return 0x0000000000000260ull;
+}
+
+#define CVMX_NPEI_CTL_STATUS CVMX_NPEI_CTL_STATUS_FUNC()
+static inline uint64_t CVMX_NPEI_CTL_STATUS_FUNC(void)
+{
+	return 0x0000000000000570ull;
+}
+
+#define CVMX_NPEI_CTL_STATUS2 CVMX_NPEI_CTL_STATUS2_FUNC()
+static inline uint64_t CVMX_NPEI_CTL_STATUS2_FUNC(void)
+{
+	return 0x0000000000003C00ull;
+}
+
+#define CVMX_NPEI_DATA_OUT_CNT CVMX_NPEI_DATA_OUT_CNT_FUNC()
+static inline uint64_t CVMX_NPEI_DATA_OUT_CNT_FUNC(void)
+{
+	return 0x00000000000005F0ull;
+}
+
+#define CVMX_NPEI_DBG_DATA CVMX_NPEI_DBG_DATA_FUNC()
+static inline uint64_t CVMX_NPEI_DBG_DATA_FUNC(void)
+{
+	return 0x0000000000000510ull;
+}
+
+#define CVMX_NPEI_DBG_SELECT CVMX_NPEI_DBG_SELECT_FUNC()
+static inline uint64_t CVMX_NPEI_DBG_SELECT_FUNC(void)
+{
+	return 0x0000000000000500ull;
+}
+
+#define CVMX_NPEI_DMA0_INT_LEVEL CVMX_NPEI_DMA0_INT_LEVEL_FUNC()
+static inline uint64_t CVMX_NPEI_DMA0_INT_LEVEL_FUNC(void)
+{
+	return 0x00000000000005C0ull;
+}
+
+#define CVMX_NPEI_DMA1_INT_LEVEL CVMX_NPEI_DMA1_INT_LEVEL_FUNC()
+static inline uint64_t CVMX_NPEI_DMA1_INT_LEVEL_FUNC(void)
+{
+	return 0x00000000000005D0ull;
+}
+
+static inline uint64_t CVMX_NPEI_DMAX_COUNTS(unsigned long offset)
+{
+	return 0x0000000000000450ull + (offset & 7) * 16;
+}
+
+static inline uint64_t CVMX_NPEI_DMAX_DBELL(unsigned long offset)
+{
+	return 0x00000000000003B0ull + (offset & 7) * 16;
+}
+
+static inline uint64_t CVMX_NPEI_DMAX_IBUFF_SADDR(unsigned long offset)
+{
+	return 0x0000000000000400ull + (offset & 7) * 16;
+}
+
+static inline uint64_t CVMX_NPEI_DMAX_NADDR(unsigned long offset)
+{
+	return 0x00000000000004A0ull + (offset & 7) * 16;
+}
+
+#define CVMX_NPEI_DMA_CNTS CVMX_NPEI_DMA_CNTS_FUNC()
+static inline uint64_t CVMX_NPEI_DMA_CNTS_FUNC(void)
+{
+	return 0x00000000000005E0ull;
+}
+
+#define CVMX_NPEI_DMA_CONTROL CVMX_NPEI_DMA_CONTROL_FUNC()
+static inline uint64_t CVMX_NPEI_DMA_CONTROL_FUNC(void)
+{
+	return 0x00000000000003A0ull;
+}
+
+#define CVMX_NPEI_INT_A_ENB CVMX_NPEI_INT_A_ENB_FUNC()
+static inline uint64_t CVMX_NPEI_INT_A_ENB_FUNC(void)
+{
+	return 0x0000000000000560ull;
+}
+
+#define CVMX_NPEI_INT_A_ENB2 CVMX_NPEI_INT_A_ENB2_FUNC()
+static inline uint64_t CVMX_NPEI_INT_A_ENB2_FUNC(void)
+{
+	return 0x0000000000003CE0ull;
+}
+
+#define CVMX_NPEI_INT_A_SUM CVMX_NPEI_INT_A_SUM_FUNC()
+static inline uint64_t CVMX_NPEI_INT_A_SUM_FUNC(void)
+{
+	return 0x0000000000000550ull;
+}
+
+#define CVMX_NPEI_INT_ENB CVMX_NPEI_INT_ENB_FUNC()
+static inline uint64_t CVMX_NPEI_INT_ENB_FUNC(void)
+{
+	return 0x0000000000000540ull;
+}
+
+#define CVMX_NPEI_INT_ENB2 CVMX_NPEI_INT_ENB2_FUNC()
+static inline uint64_t CVMX_NPEI_INT_ENB2_FUNC(void)
+{
+	return 0x0000000000003CD0ull;
+}
+
+#define CVMX_NPEI_INT_INFO CVMX_NPEI_INT_INFO_FUNC()
+static inline uint64_t CVMX_NPEI_INT_INFO_FUNC(void)
+{
+	return 0x0000000000000590ull;
+}
+
+#define CVMX_NPEI_INT_SUM CVMX_NPEI_INT_SUM_FUNC()
+static inline uint64_t CVMX_NPEI_INT_SUM_FUNC(void)
+{
+	return 0x0000000000000530ull;
+}
+
+#define CVMX_NPEI_INT_SUM2 CVMX_NPEI_INT_SUM2_FUNC()
+static inline uint64_t CVMX_NPEI_INT_SUM2_FUNC(void)
+{
+	return 0x0000000000003CC0ull;
+}
+
+#define CVMX_NPEI_LAST_WIN_RDATA0 CVMX_NPEI_LAST_WIN_RDATA0_FUNC()
+static inline uint64_t CVMX_NPEI_LAST_WIN_RDATA0_FUNC(void)
+{
+	return 0x0000000000000600ull;
+}
+
+#define CVMX_NPEI_LAST_WIN_RDATA1 CVMX_NPEI_LAST_WIN_RDATA1_FUNC()
+static inline uint64_t CVMX_NPEI_LAST_WIN_RDATA1_FUNC(void)
+{
+	return 0x0000000000000610ull;
+}
+
+#define CVMX_NPEI_MEM_ACCESS_CTL CVMX_NPEI_MEM_ACCESS_CTL_FUNC()
+static inline uint64_t CVMX_NPEI_MEM_ACCESS_CTL_FUNC(void)
+{
+	return 0x00000000000004F0ull;
+}
+
+static inline uint64_t CVMX_NPEI_MEM_ACCESS_SUBIDX(unsigned long offset)
+{
+	return 0x0000000000000340ull + (offset & 31) * 16 - 16 * 12;
+}
+
+#define CVMX_NPEI_MSI_ENB0 CVMX_NPEI_MSI_ENB0_FUNC()
+static inline uint64_t CVMX_NPEI_MSI_ENB0_FUNC(void)
+{
+	return 0x0000000000003C50ull;
+}
+
+#define CVMX_NPEI_MSI_ENB1 CVMX_NPEI_MSI_ENB1_FUNC()
+static inline uint64_t CVMX_NPEI_MSI_ENB1_FUNC(void)
+{
+	return 0x0000000000003C60ull;
+}
+
+#define CVMX_NPEI_MSI_ENB2 CVMX_NPEI_MSI_ENB2_FUNC()
+static inline uint64_t CVMX_NPEI_MSI_ENB2_FUNC(void)
+{
+	return 0x0000000000003C70ull;
+}
+
+#define CVMX_NPEI_MSI_ENB3 CVMX_NPEI_MSI_ENB3_FUNC()
+static inline uint64_t CVMX_NPEI_MSI_ENB3_FUNC(void)
+{
+	return 0x0000000000003C80ull;
+}
+
+#define CVMX_NPEI_MSI_RCV0 CVMX_NPEI_MSI_RCV0_FUNC()
+static inline uint64_t CVMX_NPEI_MSI_RCV0_FUNC(void)
+{
+	return 0x0000000000003C10ull;
+}
+
+#define CVMX_NPEI_MSI_RCV1 CVMX_NPEI_MSI_RCV1_FUNC()
+static inline uint64_t CVMX_NPEI_MSI_RCV1_FUNC(void)
+{
+	return 0x0000000000003C20ull;
+}
+
+#define CVMX_NPEI_MSI_RCV2 CVMX_NPEI_MSI_RCV2_FUNC()
+static inline uint64_t CVMX_NPEI_MSI_RCV2_FUNC(void)
+{
+	return 0x0000000000003C30ull;
+}
+
+#define CVMX_NPEI_MSI_RCV3 CVMX_NPEI_MSI_RCV3_FUNC()
+static inline uint64_t CVMX_NPEI_MSI_RCV3_FUNC(void)
+{
+	return 0x0000000000003C40ull;
+}
+
+#define CVMX_NPEI_MSI_RD_MAP CVMX_NPEI_MSI_RD_MAP_FUNC()
+static inline uint64_t CVMX_NPEI_MSI_RD_MAP_FUNC(void)
+{
+	return 0x0000000000003CA0ull;
+}
+
+#define CVMX_NPEI_MSI_W1C_ENB0 CVMX_NPEI_MSI_W1C_ENB0_FUNC()
+static inline uint64_t CVMX_NPEI_MSI_W1C_ENB0_FUNC(void)
+{
+	return 0x0000000000003CF0ull;
+}
+
+#define CVMX_NPEI_MSI_W1C_ENB1 CVMX_NPEI_MSI_W1C_ENB1_FUNC()
+static inline uint64_t CVMX_NPEI_MSI_W1C_ENB1_FUNC(void)
+{
+	return 0x0000000000003D00ull;
+}
+
+#define CVMX_NPEI_MSI_W1C_ENB2 CVMX_NPEI_MSI_W1C_ENB2_FUNC()
+static inline uint64_t CVMX_NPEI_MSI_W1C_ENB2_FUNC(void)
+{
+	return 0x0000000000003D10ull;
+}
+
+#define CVMX_NPEI_MSI_W1C_ENB3 CVMX_NPEI_MSI_W1C_ENB3_FUNC()
+static inline uint64_t CVMX_NPEI_MSI_W1C_ENB3_FUNC(void)
+{
+	return 0x0000000000003D20ull;
+}
+
+#define CVMX_NPEI_MSI_W1S_ENB0 CVMX_NPEI_MSI_W1S_ENB0_FUNC()
+static inline uint64_t CVMX_NPEI_MSI_W1S_ENB0_FUNC(void)
+{
+	return 0x0000000000003D30ull;
+}
+
+#define CVMX_NPEI_MSI_W1S_ENB1 CVMX_NPEI_MSI_W1S_ENB1_FUNC()
+static inline uint64_t CVMX_NPEI_MSI_W1S_ENB1_FUNC(void)
+{
+	return 0x0000000000003D40ull;
+}
+
+#define CVMX_NPEI_MSI_W1S_ENB2 CVMX_NPEI_MSI_W1S_ENB2_FUNC()
+static inline uint64_t CVMX_NPEI_MSI_W1S_ENB2_FUNC(void)
+{
+	return 0x0000000000003D50ull;
+}
+
+#define CVMX_NPEI_MSI_W1S_ENB3 CVMX_NPEI_MSI_W1S_ENB3_FUNC()
+static inline uint64_t CVMX_NPEI_MSI_W1S_ENB3_FUNC(void)
+{
+	return 0x0000000000003D60ull;
+}
+
+#define CVMX_NPEI_MSI_WR_MAP CVMX_NPEI_MSI_WR_MAP_FUNC()
+static inline uint64_t CVMX_NPEI_MSI_WR_MAP_FUNC(void)
+{
+	return 0x0000000000003C90ull;
+}
+
+#define CVMX_NPEI_PCIE_CREDIT_CNT CVMX_NPEI_PCIE_CREDIT_CNT_FUNC()
+static inline uint64_t CVMX_NPEI_PCIE_CREDIT_CNT_FUNC(void)
+{
+	return 0x0000000000003D70ull;
+}
+
+#define CVMX_NPEI_PCIE_MSI_RCV CVMX_NPEI_PCIE_MSI_RCV_FUNC()
+static inline uint64_t CVMX_NPEI_PCIE_MSI_RCV_FUNC(void)
+{
+	return 0x0000000000003CB0ull;
+}
+
+#define CVMX_NPEI_PCIE_MSI_RCV_B1 CVMX_NPEI_PCIE_MSI_RCV_B1_FUNC()
+static inline uint64_t CVMX_NPEI_PCIE_MSI_RCV_B1_FUNC(void)
+{
+	return 0x0000000000000650ull;
+}
+
+#define CVMX_NPEI_PCIE_MSI_RCV_B2 CVMX_NPEI_PCIE_MSI_RCV_B2_FUNC()
+static inline uint64_t CVMX_NPEI_PCIE_MSI_RCV_B2_FUNC(void)
+{
+	return 0x0000000000000660ull;
+}
+
+#define CVMX_NPEI_PCIE_MSI_RCV_B3 CVMX_NPEI_PCIE_MSI_RCV_B3_FUNC()
+static inline uint64_t CVMX_NPEI_PCIE_MSI_RCV_B3_FUNC(void)
+{
+	return 0x0000000000000670ull;
+}
+
+static inline uint64_t CVMX_NPEI_PKTX_CNTS(unsigned long offset)
+{
+	return 0x0000000000002400ull + (offset & 31) * 16;
+}
+
+static inline uint64_t CVMX_NPEI_PKTX_INSTR_BADDR(unsigned long offset)
+{
+	return 0x0000000000002800ull + (offset & 31) * 16;
+}
+
+static inline uint64_t CVMX_NPEI_PKTX_INSTR_BAOFF_DBELL(unsigned long offset)
+{
+	return 0x0000000000002C00ull + (offset & 31) * 16;
+}
+
+static inline uint64_t CVMX_NPEI_PKTX_INSTR_FIFO_RSIZE(unsigned long offset)
+{
+	return 0x0000000000003000ull + (offset & 31) * 16;
+}
+
+static inline uint64_t CVMX_NPEI_PKTX_INSTR_HEADER(unsigned long offset)
+{
+	return 0x0000000000003400ull + (offset & 31) * 16;
+}
+
+static inline uint64_t CVMX_NPEI_PKTX_IN_BP(unsigned long offset)
+{
+	return 0x0000000000003800ull + (offset & 31) * 16;
+}
+
+static inline uint64_t CVMX_NPEI_PKTX_SLIST_BADDR(unsigned long offset)
+{
+	return 0x0000000000001400ull + (offset & 31) * 16;
+}
+
+static inline uint64_t CVMX_NPEI_PKTX_SLIST_BAOFF_DBELL(unsigned long offset)
+{
+	return 0x0000000000001800ull + (offset & 31) * 16;
+}
+
+static inline uint64_t CVMX_NPEI_PKTX_SLIST_FIFO_RSIZE(unsigned long offset)
+{
+	return 0x0000000000001C00ull + (offset & 31) * 16;
+}
+
+#define CVMX_NPEI_PKT_CNT_INT CVMX_NPEI_PKT_CNT_INT_FUNC()
+static inline uint64_t CVMX_NPEI_PKT_CNT_INT_FUNC(void)
+{
+	return 0x0000000000001110ull;
+}
+
+#define CVMX_NPEI_PKT_CNT_INT_ENB CVMX_NPEI_PKT_CNT_INT_ENB_FUNC()
+static inline uint64_t CVMX_NPEI_PKT_CNT_INT_ENB_FUNC(void)
+{
+	return 0x0000000000001130ull;
+}
+
+#define CVMX_NPEI_PKT_DATA_OUT_ES CVMX_NPEI_PKT_DATA_OUT_ES_FUNC()
+static inline uint64_t CVMX_NPEI_PKT_DATA_OUT_ES_FUNC(void)
+{
+	return 0x00000000000010B0ull;
+}
+
+#define CVMX_NPEI_PKT_DATA_OUT_NS CVMX_NPEI_PKT_DATA_OUT_NS_FUNC()
+static inline uint64_t CVMX_NPEI_PKT_DATA_OUT_NS_FUNC(void)
+{
+	return 0x00000000000010A0ull;
+}
+
+#define CVMX_NPEI_PKT_DATA_OUT_ROR CVMX_NPEI_PKT_DATA_OUT_ROR_FUNC()
+static inline uint64_t CVMX_NPEI_PKT_DATA_OUT_ROR_FUNC(void)
+{
+	return 0x0000000000001090ull;
+}
+
+#define CVMX_NPEI_PKT_DPADDR CVMX_NPEI_PKT_DPADDR_FUNC()
+static inline uint64_t CVMX_NPEI_PKT_DPADDR_FUNC(void)
+{
+	return 0x0000000000001080ull;
+}
+
+#define CVMX_NPEI_PKT_INPUT_CONTROL CVMX_NPEI_PKT_INPUT_CONTROL_FUNC()
+static inline uint64_t CVMX_NPEI_PKT_INPUT_CONTROL_FUNC(void)
+{
+	return 0x0000000000001150ull;
+}
+
+#define CVMX_NPEI_PKT_INSTR_ENB CVMX_NPEI_PKT_INSTR_ENB_FUNC()
+static inline uint64_t CVMX_NPEI_PKT_INSTR_ENB_FUNC(void)
+{
+	return 0x0000000000001000ull;
+}
+
+#define CVMX_NPEI_PKT_INSTR_RD_SIZE CVMX_NPEI_PKT_INSTR_RD_SIZE_FUNC()
+static inline uint64_t CVMX_NPEI_PKT_INSTR_RD_SIZE_FUNC(void)
+{
+	return 0x0000000000001190ull;
+}
+
+#define CVMX_NPEI_PKT_INSTR_SIZE CVMX_NPEI_PKT_INSTR_SIZE_FUNC()
+static inline uint64_t CVMX_NPEI_PKT_INSTR_SIZE_FUNC(void)
+{
+	return 0x0000000000001020ull;
+}
+
+#define CVMX_NPEI_PKT_INT_LEVELS CVMX_NPEI_PKT_INT_LEVELS_FUNC()
+static inline uint64_t CVMX_NPEI_PKT_INT_LEVELS_FUNC(void)
+{
+	return 0x0000000000001100ull;
+}
+
+#define CVMX_NPEI_PKT_IN_BP CVMX_NPEI_PKT_IN_BP_FUNC()
+static inline uint64_t CVMX_NPEI_PKT_IN_BP_FUNC(void)
+{
+	return 0x00000000000006B0ull;
+}
+
+static inline uint64_t CVMX_NPEI_PKT_IN_DONEX_CNTS(unsigned long offset)
+{
+	return 0x0000000000002000ull + (offset & 31) * 16;
+}
+
+#define CVMX_NPEI_PKT_IN_INSTR_COUNTS CVMX_NPEI_PKT_IN_INSTR_COUNTS_FUNC()
+static inline uint64_t CVMX_NPEI_PKT_IN_INSTR_COUNTS_FUNC(void)
+{
+	return 0x00000000000006A0ull;
+}
+
+#define CVMX_NPEI_PKT_IN_PCIE_PORT CVMX_NPEI_PKT_IN_PCIE_PORT_FUNC()
+static inline uint64_t CVMX_NPEI_PKT_IN_PCIE_PORT_FUNC(void)
+{
+	return 0x00000000000011A0ull;
+}
+
+#define CVMX_NPEI_PKT_IPTR CVMX_NPEI_PKT_IPTR_FUNC()
+static inline uint64_t CVMX_NPEI_PKT_IPTR_FUNC(void)
+{
+	return 0x0000000000001070ull;
+}
+
+#define CVMX_NPEI_PKT_OUTPUT_WMARK CVMX_NPEI_PKT_OUTPUT_WMARK_FUNC()
+static inline uint64_t CVMX_NPEI_PKT_OUTPUT_WMARK_FUNC(void)
+{
+	return 0x0000000000001160ull;
+}
+
+#define CVMX_NPEI_PKT_OUT_BMODE CVMX_NPEI_PKT_OUT_BMODE_FUNC()
+static inline uint64_t CVMX_NPEI_PKT_OUT_BMODE_FUNC(void)
+{
+	return 0x00000000000010D0ull;
+}
+
+#define CVMX_NPEI_PKT_OUT_ENB CVMX_NPEI_PKT_OUT_ENB_FUNC()
+static inline uint64_t CVMX_NPEI_PKT_OUT_ENB_FUNC(void)
+{
+	return 0x0000000000001010ull;
+}
+
+#define CVMX_NPEI_PKT_PCIE_PORT CVMX_NPEI_PKT_PCIE_PORT_FUNC()
+static inline uint64_t CVMX_NPEI_PKT_PCIE_PORT_FUNC(void)
+{
+	return 0x00000000000010E0ull;
+}
+
+#define CVMX_NPEI_PKT_PORT_IN_RST CVMX_NPEI_PKT_PORT_IN_RST_FUNC()
+static inline uint64_t CVMX_NPEI_PKT_PORT_IN_RST_FUNC(void)
+{
+	return 0x0000000000000690ull;
+}
+
+#define CVMX_NPEI_PKT_SLIST_ES CVMX_NPEI_PKT_SLIST_ES_FUNC()
+static inline uint64_t CVMX_NPEI_PKT_SLIST_ES_FUNC(void)
+{
+	return 0x0000000000001050ull;
+}
+
+#define CVMX_NPEI_PKT_SLIST_ID_SIZE CVMX_NPEI_PKT_SLIST_ID_SIZE_FUNC()
+static inline uint64_t CVMX_NPEI_PKT_SLIST_ID_SIZE_FUNC(void)
+{
+	return 0x0000000000001180ull;
+}
+
+#define CVMX_NPEI_PKT_SLIST_NS CVMX_NPEI_PKT_SLIST_NS_FUNC()
+static inline uint64_t CVMX_NPEI_PKT_SLIST_NS_FUNC(void)
+{
+	return 0x0000000000001040ull;
+}
+
+#define CVMX_NPEI_PKT_SLIST_ROR CVMX_NPEI_PKT_SLIST_ROR_FUNC()
+static inline uint64_t CVMX_NPEI_PKT_SLIST_ROR_FUNC(void)
+{
+	return 0x0000000000001030ull;
+}
+
+#define CVMX_NPEI_PKT_TIME_INT CVMX_NPEI_PKT_TIME_INT_FUNC()
+static inline uint64_t CVMX_NPEI_PKT_TIME_INT_FUNC(void)
+{
+	return 0x0000000000001120ull;
+}
+
+#define CVMX_NPEI_PKT_TIME_INT_ENB CVMX_NPEI_PKT_TIME_INT_ENB_FUNC()
+static inline uint64_t CVMX_NPEI_PKT_TIME_INT_ENB_FUNC(void)
+{
+	return 0x0000000000001140ull;
+}
+
+#define CVMX_NPEI_RSL_INT_BLOCKS CVMX_NPEI_RSL_INT_BLOCKS_FUNC()
+static inline uint64_t CVMX_NPEI_RSL_INT_BLOCKS_FUNC(void)
+{
+	return 0x0000000000000520ull;
+}
+
+#define CVMX_NPEI_SCRATCH_1 CVMX_NPEI_SCRATCH_1_FUNC()
+static inline uint64_t CVMX_NPEI_SCRATCH_1_FUNC(void)
+{
+	return 0x0000000000000270ull;
+}
+
+#define CVMX_NPEI_STATE1 CVMX_NPEI_STATE1_FUNC()
+static inline uint64_t CVMX_NPEI_STATE1_FUNC(void)
+{
+	return 0x0000000000000620ull;
+}
+
+#define CVMX_NPEI_STATE2 CVMX_NPEI_STATE2_FUNC()
+static inline uint64_t CVMX_NPEI_STATE2_FUNC(void)
+{
+	return 0x0000000000000630ull;
+}
+
+#define CVMX_NPEI_STATE3 CVMX_NPEI_STATE3_FUNC()
+static inline uint64_t CVMX_NPEI_STATE3_FUNC(void)
+{
+	return 0x0000000000000640ull;
+}
+
+#define CVMX_NPEI_WINDOW_CTL CVMX_NPEI_WINDOW_CTL_FUNC()
+static inline uint64_t CVMX_NPEI_WINDOW_CTL_FUNC(void)
+{
+	return 0x0000000000000380ull;
+}
+
+#define CVMX_NPEI_WIN_RD_ADDR CVMX_NPEI_WIN_RD_ADDR_FUNC()
+static inline uint64_t CVMX_NPEI_WIN_RD_ADDR_FUNC(void)
+{
+	return 0x0000000000000210ull;
+}
+
+#define CVMX_NPEI_WIN_RD_DATA CVMX_NPEI_WIN_RD_DATA_FUNC()
+static inline uint64_t CVMX_NPEI_WIN_RD_DATA_FUNC(void)
+{
+	return 0x0000000000000240ull;
+}
+
+#define CVMX_NPEI_WIN_WR_ADDR CVMX_NPEI_WIN_WR_ADDR_FUNC()
+static inline uint64_t CVMX_NPEI_WIN_WR_ADDR_FUNC(void)
+{
+	return 0x0000000000000200ull;
+}
+
+#define CVMX_NPEI_WIN_WR_DATA CVMX_NPEI_WIN_WR_DATA_FUNC()
+static inline uint64_t CVMX_NPEI_WIN_WR_DATA_FUNC(void)
+{
+	return 0x0000000000000220ull;
+}
+
+#define CVMX_NPEI_WIN_WR_MASK CVMX_NPEI_WIN_WR_MASK_FUNC()
+static inline uint64_t CVMX_NPEI_WIN_WR_MASK_FUNC(void)
+{
+	return 0x0000000000000230ull;
+}
+
+#define CVMX_NPI_BASE_ADDR_INPUT0 CVMX_NPI_BASE_ADDR_INPUTX(0)
+#define CVMX_NPI_BASE_ADDR_INPUT1 CVMX_NPI_BASE_ADDR_INPUTX(1)
+#define CVMX_NPI_BASE_ADDR_INPUT2 CVMX_NPI_BASE_ADDR_INPUTX(2)
+#define CVMX_NPI_BASE_ADDR_INPUT3 CVMX_NPI_BASE_ADDR_INPUTX(3)
+static inline uint64_t CVMX_NPI_BASE_ADDR_INPUTX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000000070ull) + (offset & 3) * 16;
+}
+
+#define CVMX_NPI_BASE_ADDR_OUTPUT0 CVMX_NPI_BASE_ADDR_OUTPUTX(0)
+#define CVMX_NPI_BASE_ADDR_OUTPUT1 CVMX_NPI_BASE_ADDR_OUTPUTX(1)
+#define CVMX_NPI_BASE_ADDR_OUTPUT2 CVMX_NPI_BASE_ADDR_OUTPUTX(2)
+#define CVMX_NPI_BASE_ADDR_OUTPUT3 CVMX_NPI_BASE_ADDR_OUTPUTX(3)
+static inline uint64_t CVMX_NPI_BASE_ADDR_OUTPUTX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000000B8ull) + (offset & 3) * 8;
+}
+
+#define CVMX_NPI_BIST_STATUS CVMX_NPI_BIST_STATUS_FUNC()
+static inline uint64_t CVMX_NPI_BIST_STATUS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000003F8ull);
+}
+
+#define CVMX_NPI_BUFF_SIZE_OUTPUT0 CVMX_NPI_BUFF_SIZE_OUTPUTX(0)
+#define CVMX_NPI_BUFF_SIZE_OUTPUT1 CVMX_NPI_BUFF_SIZE_OUTPUTX(1)
+#define CVMX_NPI_BUFF_SIZE_OUTPUT2 CVMX_NPI_BUFF_SIZE_OUTPUTX(2)
+#define CVMX_NPI_BUFF_SIZE_OUTPUT3 CVMX_NPI_BUFF_SIZE_OUTPUTX(3)
+static inline uint64_t CVMX_NPI_BUFF_SIZE_OUTPUTX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000000E0ull) + (offset & 3) * 8;
+}
+
+#define CVMX_NPI_COMP_CTL CVMX_NPI_COMP_CTL_FUNC()
+static inline uint64_t CVMX_NPI_COMP_CTL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000000218ull);
+}
+
+#define CVMX_NPI_CTL_STATUS CVMX_NPI_CTL_STATUS_FUNC()
+static inline uint64_t CVMX_NPI_CTL_STATUS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000000010ull);
+}
+
+#define CVMX_NPI_DBG_SELECT CVMX_NPI_DBG_SELECT_FUNC()
+static inline uint64_t CVMX_NPI_DBG_SELECT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000000008ull);
+}
+
+#define CVMX_NPI_DMA_CONTROL CVMX_NPI_DMA_CONTROL_FUNC()
+static inline uint64_t CVMX_NPI_DMA_CONTROL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000000128ull);
+}
+
+#define CVMX_NPI_DMA_HIGHP_COUNTS CVMX_NPI_DMA_HIGHP_COUNTS_FUNC()
+static inline uint64_t CVMX_NPI_DMA_HIGHP_COUNTS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000000148ull);
+}
+
+#define CVMX_NPI_DMA_HIGHP_NADDR CVMX_NPI_DMA_HIGHP_NADDR_FUNC()
+static inline uint64_t CVMX_NPI_DMA_HIGHP_NADDR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000000158ull);
+}
+
+#define CVMX_NPI_DMA_LOWP_COUNTS CVMX_NPI_DMA_LOWP_COUNTS_FUNC()
+static inline uint64_t CVMX_NPI_DMA_LOWP_COUNTS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000000140ull);
+}
+
+#define CVMX_NPI_DMA_LOWP_NADDR CVMX_NPI_DMA_LOWP_NADDR_FUNC()
+static inline uint64_t CVMX_NPI_DMA_LOWP_NADDR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000000150ull);
+}
+
+#define CVMX_NPI_HIGHP_DBELL CVMX_NPI_HIGHP_DBELL_FUNC()
+static inline uint64_t CVMX_NPI_HIGHP_DBELL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000000120ull);
+}
+
+#define CVMX_NPI_HIGHP_IBUFF_SADDR CVMX_NPI_HIGHP_IBUFF_SADDR_FUNC()
+static inline uint64_t CVMX_NPI_HIGHP_IBUFF_SADDR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000000110ull);
+}
+
+#define CVMX_NPI_INPUT_CONTROL CVMX_NPI_INPUT_CONTROL_FUNC()
+static inline uint64_t CVMX_NPI_INPUT_CONTROL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000000138ull);
+}
+
+#define CVMX_NPI_INT_ENB CVMX_NPI_INT_ENB_FUNC()
+static inline uint64_t CVMX_NPI_INT_ENB_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000000020ull);
+}
+
+#define CVMX_NPI_INT_SUM CVMX_NPI_INT_SUM_FUNC()
+static inline uint64_t CVMX_NPI_INT_SUM_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000000018ull);
+}
+
+#define CVMX_NPI_LOWP_DBELL CVMX_NPI_LOWP_DBELL_FUNC()
+static inline uint64_t CVMX_NPI_LOWP_DBELL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000000118ull);
+}
+
+#define CVMX_NPI_LOWP_IBUFF_SADDR CVMX_NPI_LOWP_IBUFF_SADDR_FUNC()
+static inline uint64_t CVMX_NPI_LOWP_IBUFF_SADDR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000000108ull);
+}
+
+#define CVMX_NPI_MEM_ACCESS_SUBID3 CVMX_NPI_MEM_ACCESS_SUBIDX(3)
+#define CVMX_NPI_MEM_ACCESS_SUBID4 CVMX_NPI_MEM_ACCESS_SUBIDX(4)
+#define CVMX_NPI_MEM_ACCESS_SUBID5 CVMX_NPI_MEM_ACCESS_SUBIDX(5)
+#define CVMX_NPI_MEM_ACCESS_SUBID6 CVMX_NPI_MEM_ACCESS_SUBIDX(6)
+static inline uint64_t CVMX_NPI_MEM_ACCESS_SUBIDX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000000028ull) + (offset & 7) * 8 -
+	    8 * 3;
+}
+
+#define CVMX_NPI_MSI_RCV CVMX_NPI_MSI_RCV_FUNC()
+static inline uint64_t CVMX_NPI_MSI_RCV_FUNC(void)
+{
+	return 0x0000000000000190ull;
+}
+
+#define CVMX_NPI_NPI_MSI_RCV CVMX_NPI_NPI_MSI_RCV_FUNC()
+static inline uint64_t CVMX_NPI_NPI_MSI_RCV_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000001190ull);
+}
+
+#define CVMX_NPI_NUM_DESC_OUTPUT0 CVMX_NPI_NUM_DESC_OUTPUTX(0)
+#define CVMX_NPI_NUM_DESC_OUTPUT1 CVMX_NPI_NUM_DESC_OUTPUTX(1)
+#define CVMX_NPI_NUM_DESC_OUTPUT2 CVMX_NPI_NUM_DESC_OUTPUTX(2)
+#define CVMX_NPI_NUM_DESC_OUTPUT3 CVMX_NPI_NUM_DESC_OUTPUTX(3)
+static inline uint64_t CVMX_NPI_NUM_DESC_OUTPUTX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000000050ull) + (offset & 3) * 8;
+}
+
+#define CVMX_NPI_OUTPUT_CONTROL CVMX_NPI_OUTPUT_CONTROL_FUNC()
+static inline uint64_t CVMX_NPI_OUTPUT_CONTROL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000000100ull);
+}
+
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
+static inline uint64_t CVMX_NPI_PCI_BAR1_INDEXX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000001100ull) + (offset & 31) * 4;
+}
+
+#define CVMX_NPI_PCI_BIST_REG CVMX_NPI_PCI_BIST_REG_FUNC()
+static inline uint64_t CVMX_NPI_PCI_BIST_REG_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000011C0ull);
+}
+
+#define CVMX_NPI_PCI_BURST_SIZE CVMX_NPI_PCI_BURST_SIZE_FUNC()
+static inline uint64_t CVMX_NPI_PCI_BURST_SIZE_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000000D8ull);
+}
+
+#define CVMX_NPI_PCI_CFG00 CVMX_NPI_PCI_CFG00_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG00_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000001800ull);
+}
+
+#define CVMX_NPI_PCI_CFG01 CVMX_NPI_PCI_CFG01_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG01_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000001804ull);
+}
+
+#define CVMX_NPI_PCI_CFG02 CVMX_NPI_PCI_CFG02_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG02_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000001808ull);
+}
+
+#define CVMX_NPI_PCI_CFG03 CVMX_NPI_PCI_CFG03_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG03_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000180Cull);
+}
+
+#define CVMX_NPI_PCI_CFG04 CVMX_NPI_PCI_CFG04_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG04_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000001810ull);
+}
+
+#define CVMX_NPI_PCI_CFG05 CVMX_NPI_PCI_CFG05_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG05_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000001814ull);
+}
+
+#define CVMX_NPI_PCI_CFG06 CVMX_NPI_PCI_CFG06_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG06_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000001818ull);
+}
+
+#define CVMX_NPI_PCI_CFG07 CVMX_NPI_PCI_CFG07_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG07_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000181Cull);
+}
+
+#define CVMX_NPI_PCI_CFG08 CVMX_NPI_PCI_CFG08_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG08_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000001820ull);
+}
+
+#define CVMX_NPI_PCI_CFG09 CVMX_NPI_PCI_CFG09_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG09_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000001824ull);
+}
+
+#define CVMX_NPI_PCI_CFG10 CVMX_NPI_PCI_CFG10_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG10_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000001828ull);
+}
+
+#define CVMX_NPI_PCI_CFG11 CVMX_NPI_PCI_CFG11_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG11_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000182Cull);
+}
+
+#define CVMX_NPI_PCI_CFG12 CVMX_NPI_PCI_CFG12_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG12_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000001830ull);
+}
+
+#define CVMX_NPI_PCI_CFG13 CVMX_NPI_PCI_CFG13_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG13_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000001834ull);
+}
+
+#define CVMX_NPI_PCI_CFG15 CVMX_NPI_PCI_CFG15_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG15_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000183Cull);
+}
+
+#define CVMX_NPI_PCI_CFG16 CVMX_NPI_PCI_CFG16_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG16_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000001840ull);
+}
+
+#define CVMX_NPI_PCI_CFG17 CVMX_NPI_PCI_CFG17_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG17_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000001844ull);
+}
+
+#define CVMX_NPI_PCI_CFG18 CVMX_NPI_PCI_CFG18_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG18_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000001848ull);
+}
+
+#define CVMX_NPI_PCI_CFG19 CVMX_NPI_PCI_CFG19_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG19_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000184Cull);
+}
+
+#define CVMX_NPI_PCI_CFG20 CVMX_NPI_PCI_CFG20_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG20_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000001850ull);
+}
+
+#define CVMX_NPI_PCI_CFG21 CVMX_NPI_PCI_CFG21_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG21_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000001854ull);
+}
+
+#define CVMX_NPI_PCI_CFG22 CVMX_NPI_PCI_CFG22_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG22_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000001858ull);
+}
+
+#define CVMX_NPI_PCI_CFG56 CVMX_NPI_PCI_CFG56_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG56_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000018E0ull);
+}
+
+#define CVMX_NPI_PCI_CFG57 CVMX_NPI_PCI_CFG57_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG57_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000018E4ull);
+}
+
+#define CVMX_NPI_PCI_CFG58 CVMX_NPI_PCI_CFG58_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG58_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000018E8ull);
+}
+
+#define CVMX_NPI_PCI_CFG59 CVMX_NPI_PCI_CFG59_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG59_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000018ECull);
+}
+
+#define CVMX_NPI_PCI_CFG60 CVMX_NPI_PCI_CFG60_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG60_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000018F0ull);
+}
+
+#define CVMX_NPI_PCI_CFG61 CVMX_NPI_PCI_CFG61_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG61_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000018F4ull);
+}
+
+#define CVMX_NPI_PCI_CFG62 CVMX_NPI_PCI_CFG62_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG62_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000018F8ull);
+}
+
+#define CVMX_NPI_PCI_CFG63 CVMX_NPI_PCI_CFG63_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CFG63_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000018FCull);
+}
+
+#define CVMX_NPI_PCI_CNT_REG CVMX_NPI_PCI_CNT_REG_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CNT_REG_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000011B8ull);
+}
+
+#define CVMX_NPI_PCI_CTL_STATUS_2 CVMX_NPI_PCI_CTL_STATUS_2_FUNC()
+static inline uint64_t CVMX_NPI_PCI_CTL_STATUS_2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000118Cull);
+}
+
+#define CVMX_NPI_PCI_INT_ARB_CFG CVMX_NPI_PCI_INT_ARB_CFG_FUNC()
+static inline uint64_t CVMX_NPI_PCI_INT_ARB_CFG_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000000130ull);
+}
+
+#define CVMX_NPI_PCI_INT_ENB2 CVMX_NPI_PCI_INT_ENB2_FUNC()
+static inline uint64_t CVMX_NPI_PCI_INT_ENB2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000011A0ull);
+}
+
+#define CVMX_NPI_PCI_INT_SUM2 CVMX_NPI_PCI_INT_SUM2_FUNC()
+static inline uint64_t CVMX_NPI_PCI_INT_SUM2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000001198ull);
+}
+
+#define CVMX_NPI_PCI_READ_CMD CVMX_NPI_PCI_READ_CMD_FUNC()
+static inline uint64_t CVMX_NPI_PCI_READ_CMD_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000000048ull);
+}
+
+#define CVMX_NPI_PCI_READ_CMD_6 CVMX_NPI_PCI_READ_CMD_6_FUNC()
+static inline uint64_t CVMX_NPI_PCI_READ_CMD_6_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000001180ull);
+}
+
+#define CVMX_NPI_PCI_READ_CMD_C CVMX_NPI_PCI_READ_CMD_C_FUNC()
+static inline uint64_t CVMX_NPI_PCI_READ_CMD_C_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000001184ull);
+}
+
+#define CVMX_NPI_PCI_READ_CMD_E CVMX_NPI_PCI_READ_CMD_E_FUNC()
+static inline uint64_t CVMX_NPI_PCI_READ_CMD_E_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000001188ull);
+}
+
+#define CVMX_NPI_PCI_SCM_REG CVMX_NPI_PCI_SCM_REG_FUNC()
+static inline uint64_t CVMX_NPI_PCI_SCM_REG_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000011A8ull);
+}
+
+#define CVMX_NPI_PCI_TSR_REG CVMX_NPI_PCI_TSR_REG_FUNC()
+static inline uint64_t CVMX_NPI_PCI_TSR_REG_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000011B0ull);
+}
+
+#define CVMX_NPI_PORT32_INSTR_HDR CVMX_NPI_PORT32_INSTR_HDR_FUNC()
+static inline uint64_t CVMX_NPI_PORT32_INSTR_HDR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000001F8ull);
+}
+
+#define CVMX_NPI_PORT33_INSTR_HDR CVMX_NPI_PORT33_INSTR_HDR_FUNC()
+static inline uint64_t CVMX_NPI_PORT33_INSTR_HDR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000000200ull);
+}
+
+#define CVMX_NPI_PORT34_INSTR_HDR CVMX_NPI_PORT34_INSTR_HDR_FUNC()
+static inline uint64_t CVMX_NPI_PORT34_INSTR_HDR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000000208ull);
+}
+
+#define CVMX_NPI_PORT35_INSTR_HDR CVMX_NPI_PORT35_INSTR_HDR_FUNC()
+static inline uint64_t CVMX_NPI_PORT35_INSTR_HDR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000000210ull);
+}
+
+#define CVMX_NPI_PORT_BP_CONTROL CVMX_NPI_PORT_BP_CONTROL_FUNC()
+static inline uint64_t CVMX_NPI_PORT_BP_CONTROL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000001F0ull);
+}
+
+static inline uint64_t CVMX_NPI_PX_DBPAIR_ADDR(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000000180ull) + (offset & 3) * 8;
+}
+
+static inline uint64_t CVMX_NPI_PX_INSTR_ADDR(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000001C0ull) + (offset & 3) * 8;
+}
+
+static inline uint64_t CVMX_NPI_PX_INSTR_CNTS(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000001A0ull) + (offset & 3) * 8;
+}
+
+static inline uint64_t CVMX_NPI_PX_PAIR_CNTS(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000000160ull) + (offset & 3) * 8;
+}
+
+#define CVMX_NPI_RSL_INT_BLOCKS CVMX_NPI_RSL_INT_BLOCKS_FUNC()
+static inline uint64_t CVMX_NPI_RSL_INT_BLOCKS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000000000ull);
+}
+
+#define CVMX_NPI_SIZE_INPUT0 CVMX_NPI_SIZE_INPUTX(0)
+#define CVMX_NPI_SIZE_INPUT1 CVMX_NPI_SIZE_INPUTX(1)
+#define CVMX_NPI_SIZE_INPUT2 CVMX_NPI_SIZE_INPUTX(2)
+#define CVMX_NPI_SIZE_INPUT3 CVMX_NPI_SIZE_INPUTX(3)
+static inline uint64_t CVMX_NPI_SIZE_INPUTX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000000078ull) + (offset & 3) * 16;
+}
+
+#define CVMX_NPI_WIN_READ_TO CVMX_NPI_WIN_READ_TO_FUNC()
+static inline uint64_t CVMX_NPI_WIN_READ_TO_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000001E0ull);
+}
+
+#define CVMX_PCIEEP_CFG000 CVMX_PCIEEP_CFG000_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG000_FUNC(void)
+{
+	return 0x0000000000000000ull;
+}
+
+#define CVMX_PCIEEP_CFG001 CVMX_PCIEEP_CFG001_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG001_FUNC(void)
+{
+	return 0x0000000000000004ull;
+}
+
+#define CVMX_PCIEEP_CFG002 CVMX_PCIEEP_CFG002_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG002_FUNC(void)
+{
+	return 0x0000000000000008ull;
+}
+
+#define CVMX_PCIEEP_CFG003 CVMX_PCIEEP_CFG003_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG003_FUNC(void)
+{
+	return 0x000000000000000Cull;
+}
+
+#define CVMX_PCIEEP_CFG004 CVMX_PCIEEP_CFG004_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG004_FUNC(void)
+{
+	return 0x0000000000000010ull;
+}
+
+#define CVMX_PCIEEP_CFG004_MASK CVMX_PCIEEP_CFG004_MASK_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG004_MASK_FUNC(void)
+{
+	return 0x0000000080000010ull;
+}
+
+#define CVMX_PCIEEP_CFG005 CVMX_PCIEEP_CFG005_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG005_FUNC(void)
+{
+	return 0x0000000000000014ull;
+}
+
+#define CVMX_PCIEEP_CFG005_MASK CVMX_PCIEEP_CFG005_MASK_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG005_MASK_FUNC(void)
+{
+	return 0x0000000080000014ull;
+}
+
+#define CVMX_PCIEEP_CFG006 CVMX_PCIEEP_CFG006_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG006_FUNC(void)
+{
+	return 0x0000000000000018ull;
+}
+
+#define CVMX_PCIEEP_CFG006_MASK CVMX_PCIEEP_CFG006_MASK_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG006_MASK_FUNC(void)
+{
+	return 0x0000000080000018ull;
+}
+
+#define CVMX_PCIEEP_CFG007 CVMX_PCIEEP_CFG007_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG007_FUNC(void)
+{
+	return 0x000000000000001Cull;
+}
+
+#define CVMX_PCIEEP_CFG007_MASK CVMX_PCIEEP_CFG007_MASK_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG007_MASK_FUNC(void)
+{
+	return 0x000000008000001Cull;
+}
+
+#define CVMX_PCIEEP_CFG008 CVMX_PCIEEP_CFG008_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG008_FUNC(void)
+{
+	return 0x0000000000000020ull;
+}
+
+#define CVMX_PCIEEP_CFG008_MASK CVMX_PCIEEP_CFG008_MASK_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG008_MASK_FUNC(void)
+{
+	return 0x0000000080000020ull;
+}
+
+#define CVMX_PCIEEP_CFG009 CVMX_PCIEEP_CFG009_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG009_FUNC(void)
+{
+	return 0x0000000000000024ull;
+}
+
+#define CVMX_PCIEEP_CFG009_MASK CVMX_PCIEEP_CFG009_MASK_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG009_MASK_FUNC(void)
+{
+	return 0x0000000080000024ull;
+}
+
+#define CVMX_PCIEEP_CFG010 CVMX_PCIEEP_CFG010_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG010_FUNC(void)
+{
+	return 0x0000000000000028ull;
+}
+
+#define CVMX_PCIEEP_CFG011 CVMX_PCIEEP_CFG011_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG011_FUNC(void)
+{
+	return 0x000000000000002Cull;
+}
+
+#define CVMX_PCIEEP_CFG012 CVMX_PCIEEP_CFG012_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG012_FUNC(void)
+{
+	return 0x0000000000000030ull;
+}
+
+#define CVMX_PCIEEP_CFG012_MASK CVMX_PCIEEP_CFG012_MASK_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG012_MASK_FUNC(void)
+{
+	return 0x0000000080000030ull;
+}
+
+#define CVMX_PCIEEP_CFG013 CVMX_PCIEEP_CFG013_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG013_FUNC(void)
+{
+	return 0x0000000000000034ull;
+}
+
+#define CVMX_PCIEEP_CFG015 CVMX_PCIEEP_CFG015_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG015_FUNC(void)
+{
+	return 0x000000000000003Cull;
+}
+
+#define CVMX_PCIEEP_CFG016 CVMX_PCIEEP_CFG016_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG016_FUNC(void)
+{
+	return 0x0000000000000040ull;
+}
+
+#define CVMX_PCIEEP_CFG017 CVMX_PCIEEP_CFG017_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG017_FUNC(void)
+{
+	return 0x0000000000000044ull;
+}
+
+#define CVMX_PCIEEP_CFG020 CVMX_PCIEEP_CFG020_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG020_FUNC(void)
+{
+	return 0x0000000000000050ull;
+}
+
+#define CVMX_PCIEEP_CFG021 CVMX_PCIEEP_CFG021_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG021_FUNC(void)
+{
+	return 0x0000000000000054ull;
+}
+
+#define CVMX_PCIEEP_CFG022 CVMX_PCIEEP_CFG022_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG022_FUNC(void)
+{
+	return 0x0000000000000058ull;
+}
+
+#define CVMX_PCIEEP_CFG023 CVMX_PCIEEP_CFG023_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG023_FUNC(void)
+{
+	return 0x000000000000005Cull;
+}
+
+#define CVMX_PCIEEP_CFG028 CVMX_PCIEEP_CFG028_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG028_FUNC(void)
+{
+	return 0x0000000000000070ull;
+}
+
+#define CVMX_PCIEEP_CFG029 CVMX_PCIEEP_CFG029_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG029_FUNC(void)
+{
+	return 0x0000000000000074ull;
+}
+
+#define CVMX_PCIEEP_CFG030 CVMX_PCIEEP_CFG030_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG030_FUNC(void)
+{
+	return 0x0000000000000078ull;
+}
+
+#define CVMX_PCIEEP_CFG031 CVMX_PCIEEP_CFG031_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG031_FUNC(void)
+{
+	return 0x000000000000007Cull;
+}
+
+#define CVMX_PCIEEP_CFG032 CVMX_PCIEEP_CFG032_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG032_FUNC(void)
+{
+	return 0x0000000000000080ull;
+}
+
+#define CVMX_PCIEEP_CFG033 CVMX_PCIEEP_CFG033_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG033_FUNC(void)
+{
+	return 0x0000000000000084ull;
+}
+
+#define CVMX_PCIEEP_CFG034 CVMX_PCIEEP_CFG034_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG034_FUNC(void)
+{
+	return 0x0000000000000088ull;
+}
+
+#define CVMX_PCIEEP_CFG037 CVMX_PCIEEP_CFG037_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG037_FUNC(void)
+{
+	return 0x0000000000000094ull;
+}
+
+#define CVMX_PCIEEP_CFG038 CVMX_PCIEEP_CFG038_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG038_FUNC(void)
+{
+	return 0x0000000000000098ull;
+}
+
+#define CVMX_PCIEEP_CFG039 CVMX_PCIEEP_CFG039_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG039_FUNC(void)
+{
+	return 0x000000000000009Cull;
+}
+
+#define CVMX_PCIEEP_CFG040 CVMX_PCIEEP_CFG040_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG040_FUNC(void)
+{
+	return 0x00000000000000A0ull;
+}
+
+#define CVMX_PCIEEP_CFG041 CVMX_PCIEEP_CFG041_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG041_FUNC(void)
+{
+	return 0x00000000000000A4ull;
+}
+
+#define CVMX_PCIEEP_CFG042 CVMX_PCIEEP_CFG042_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG042_FUNC(void)
+{
+	return 0x00000000000000A8ull;
+}
+
+#define CVMX_PCIEEP_CFG064 CVMX_PCIEEP_CFG064_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG064_FUNC(void)
+{
+	return 0x0000000000000100ull;
+}
+
+#define CVMX_PCIEEP_CFG065 CVMX_PCIEEP_CFG065_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG065_FUNC(void)
+{
+	return 0x0000000000000104ull;
+}
+
+#define CVMX_PCIEEP_CFG066 CVMX_PCIEEP_CFG066_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG066_FUNC(void)
+{
+	return 0x0000000000000108ull;
+}
+
+#define CVMX_PCIEEP_CFG067 CVMX_PCIEEP_CFG067_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG067_FUNC(void)
+{
+	return 0x000000000000010Cull;
+}
+
+#define CVMX_PCIEEP_CFG068 CVMX_PCIEEP_CFG068_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG068_FUNC(void)
+{
+	return 0x0000000000000110ull;
+}
+
+#define CVMX_PCIEEP_CFG069 CVMX_PCIEEP_CFG069_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG069_FUNC(void)
+{
+	return 0x0000000000000114ull;
+}
+
+#define CVMX_PCIEEP_CFG070 CVMX_PCIEEP_CFG070_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG070_FUNC(void)
+{
+	return 0x0000000000000118ull;
+}
+
+#define CVMX_PCIEEP_CFG071 CVMX_PCIEEP_CFG071_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG071_FUNC(void)
+{
+	return 0x000000000000011Cull;
+}
+
+#define CVMX_PCIEEP_CFG072 CVMX_PCIEEP_CFG072_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG072_FUNC(void)
+{
+	return 0x0000000000000120ull;
+}
+
+#define CVMX_PCIEEP_CFG073 CVMX_PCIEEP_CFG073_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG073_FUNC(void)
+{
+	return 0x0000000000000124ull;
+}
+
+#define CVMX_PCIEEP_CFG074 CVMX_PCIEEP_CFG074_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG074_FUNC(void)
+{
+	return 0x0000000000000128ull;
+}
+
+#define CVMX_PCIEEP_CFG448 CVMX_PCIEEP_CFG448_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG448_FUNC(void)
+{
+	return 0x0000000000000700ull;
+}
+
+#define CVMX_PCIEEP_CFG449 CVMX_PCIEEP_CFG449_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG449_FUNC(void)
+{
+	return 0x0000000000000704ull;
+}
+
+#define CVMX_PCIEEP_CFG450 CVMX_PCIEEP_CFG450_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG450_FUNC(void)
+{
+	return 0x0000000000000708ull;
+}
+
+#define CVMX_PCIEEP_CFG451 CVMX_PCIEEP_CFG451_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG451_FUNC(void)
+{
+	return 0x000000000000070Cull;
+}
+
+#define CVMX_PCIEEP_CFG452 CVMX_PCIEEP_CFG452_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG452_FUNC(void)
+{
+	return 0x0000000000000710ull;
+}
+
+#define CVMX_PCIEEP_CFG453 CVMX_PCIEEP_CFG453_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG453_FUNC(void)
+{
+	return 0x0000000000000714ull;
+}
+
+#define CVMX_PCIEEP_CFG454 CVMX_PCIEEP_CFG454_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG454_FUNC(void)
+{
+	return 0x0000000000000718ull;
+}
+
+#define CVMX_PCIEEP_CFG455 CVMX_PCIEEP_CFG455_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG455_FUNC(void)
+{
+	return 0x000000000000071Cull;
+}
+
+#define CVMX_PCIEEP_CFG456 CVMX_PCIEEP_CFG456_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG456_FUNC(void)
+{
+	return 0x0000000000000720ull;
+}
+
+#define CVMX_PCIEEP_CFG458 CVMX_PCIEEP_CFG458_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG458_FUNC(void)
+{
+	return 0x0000000000000728ull;
+}
+
+#define CVMX_PCIEEP_CFG459 CVMX_PCIEEP_CFG459_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG459_FUNC(void)
+{
+	return 0x000000000000072Cull;
+}
+
+#define CVMX_PCIEEP_CFG460 CVMX_PCIEEP_CFG460_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG460_FUNC(void)
+{
+	return 0x0000000000000730ull;
+}
+
+#define CVMX_PCIEEP_CFG461 CVMX_PCIEEP_CFG461_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG461_FUNC(void)
+{
+	return 0x0000000000000734ull;
+}
+
+#define CVMX_PCIEEP_CFG462 CVMX_PCIEEP_CFG462_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG462_FUNC(void)
+{
+	return 0x0000000000000738ull;
+}
+
+#define CVMX_PCIEEP_CFG463 CVMX_PCIEEP_CFG463_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG463_FUNC(void)
+{
+	return 0x000000000000073Cull;
+}
+
+#define CVMX_PCIEEP_CFG464 CVMX_PCIEEP_CFG464_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG464_FUNC(void)
+{
+	return 0x0000000000000740ull;
+}
+
+#define CVMX_PCIEEP_CFG465 CVMX_PCIEEP_CFG465_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG465_FUNC(void)
+{
+	return 0x0000000000000744ull;
+}
+
+#define CVMX_PCIEEP_CFG466 CVMX_PCIEEP_CFG466_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG466_FUNC(void)
+{
+	return 0x0000000000000748ull;
+}
+
+#define CVMX_PCIEEP_CFG467 CVMX_PCIEEP_CFG467_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG467_FUNC(void)
+{
+	return 0x000000000000074Cull;
+}
+
+#define CVMX_PCIEEP_CFG468 CVMX_PCIEEP_CFG468_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG468_FUNC(void)
+{
+	return 0x0000000000000750ull;
+}
+
+#define CVMX_PCIEEP_CFG490 CVMX_PCIEEP_CFG490_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG490_FUNC(void)
+{
+	return 0x00000000000007A8ull;
+}
+
+#define CVMX_PCIEEP_CFG491 CVMX_PCIEEP_CFG491_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG491_FUNC(void)
+{
+	return 0x00000000000007ACull;
+}
+
+#define CVMX_PCIEEP_CFG492 CVMX_PCIEEP_CFG492_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG492_FUNC(void)
+{
+	return 0x00000000000007B0ull;
+}
+
+#define CVMX_PCIEEP_CFG516 CVMX_PCIEEP_CFG516_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG516_FUNC(void)
+{
+	return 0x0000000000000810ull;
+}
+
+#define CVMX_PCIEEP_CFG517 CVMX_PCIEEP_CFG517_FUNC()
+static inline uint64_t CVMX_PCIEEP_CFG517_FUNC(void)
+{
+	return 0x0000000000000814ull;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG000(unsigned long offset)
+{
+	return 0x0000000000000000ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG001(unsigned long offset)
+{
+	return 0x0000000000000004ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG002(unsigned long offset)
+{
+	return 0x0000000000000008ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG003(unsigned long offset)
+{
+	return 0x000000000000000Cull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG004(unsigned long offset)
+{
+	return 0x0000000000000010ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG005(unsigned long offset)
+{
+	return 0x0000000000000014ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG006(unsigned long offset)
+{
+	return 0x0000000000000018ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG007(unsigned long offset)
+{
+	return 0x000000000000001Cull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG008(unsigned long offset)
+{
+	return 0x0000000000000020ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG009(unsigned long offset)
+{
+	return 0x0000000000000024ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG010(unsigned long offset)
+{
+	return 0x0000000000000028ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG011(unsigned long offset)
+{
+	return 0x000000000000002Cull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG012(unsigned long offset)
+{
+	return 0x0000000000000030ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG013(unsigned long offset)
+{
+	return 0x0000000000000034ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG014(unsigned long offset)
+{
+	return 0x0000000000000038ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG015(unsigned long offset)
+{
+	return 0x000000000000003Cull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG016(unsigned long offset)
+{
+	return 0x0000000000000040ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG017(unsigned long offset)
+{
+	return 0x0000000000000044ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG020(unsigned long offset)
+{
+	return 0x0000000000000050ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG021(unsigned long offset)
+{
+	return 0x0000000000000054ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG022(unsigned long offset)
+{
+	return 0x0000000000000058ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG023(unsigned long offset)
+{
+	return 0x000000000000005Cull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG028(unsigned long offset)
+{
+	return 0x0000000000000070ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG029(unsigned long offset)
+{
+	return 0x0000000000000074ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG030(unsigned long offset)
+{
+	return 0x0000000000000078ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG031(unsigned long offset)
+{
+	return 0x000000000000007Cull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG032(unsigned long offset)
+{
+	return 0x0000000000000080ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG033(unsigned long offset)
+{
+	return 0x0000000000000084ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG034(unsigned long offset)
+{
+	return 0x0000000000000088ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG035(unsigned long offset)
+{
+	return 0x000000000000008Cull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG036(unsigned long offset)
+{
+	return 0x0000000000000090ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG037(unsigned long offset)
+{
+	return 0x0000000000000094ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG038(unsigned long offset)
+{
+	return 0x0000000000000098ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG039(unsigned long offset)
+{
+	return 0x000000000000009Cull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG040(unsigned long offset)
+{
+	return 0x00000000000000A0ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG041(unsigned long offset)
+{
+	return 0x00000000000000A4ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG042(unsigned long offset)
+{
+	return 0x00000000000000A8ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG064(unsigned long offset)
+{
+	return 0x0000000000000100ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG065(unsigned long offset)
+{
+	return 0x0000000000000104ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG066(unsigned long offset)
+{
+	return 0x0000000000000108ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG067(unsigned long offset)
+{
+	return 0x000000000000010Cull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG068(unsigned long offset)
+{
+	return 0x0000000000000110ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG069(unsigned long offset)
+{
+	return 0x0000000000000114ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG070(unsigned long offset)
+{
+	return 0x0000000000000118ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG071(unsigned long offset)
+{
+	return 0x000000000000011Cull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG072(unsigned long offset)
+{
+	return 0x0000000000000120ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG073(unsigned long offset)
+{
+	return 0x0000000000000124ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG074(unsigned long offset)
+{
+	return 0x0000000000000128ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG075(unsigned long offset)
+{
+	return 0x000000000000012Cull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG076(unsigned long offset)
+{
+	return 0x0000000000000130ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG077(unsigned long offset)
+{
+	return 0x0000000000000134ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG448(unsigned long offset)
+{
+	return 0x0000000000000700ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG449(unsigned long offset)
+{
+	return 0x0000000000000704ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG450(unsigned long offset)
+{
+	return 0x0000000000000708ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG451(unsigned long offset)
+{
+	return 0x000000000000070Cull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG452(unsigned long offset)
+{
+	return 0x0000000000000710ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG453(unsigned long offset)
+{
+	return 0x0000000000000714ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG454(unsigned long offset)
+{
+	return 0x0000000000000718ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG455(unsigned long offset)
+{
+	return 0x000000000000071Cull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG456(unsigned long offset)
+{
+	return 0x0000000000000720ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG458(unsigned long offset)
+{
+	return 0x0000000000000728ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG459(unsigned long offset)
+{
+	return 0x000000000000072Cull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG460(unsigned long offset)
+{
+	return 0x0000000000000730ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG461(unsigned long offset)
+{
+	return 0x0000000000000734ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG462(unsigned long offset)
+{
+	return 0x0000000000000738ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG463(unsigned long offset)
+{
+	return 0x000000000000073Cull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG464(unsigned long offset)
+{
+	return 0x0000000000000740ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG465(unsigned long offset)
+{
+	return 0x0000000000000744ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG466(unsigned long offset)
+{
+	return 0x0000000000000748ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG467(unsigned long offset)
+{
+	return 0x000000000000074Cull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG468(unsigned long offset)
+{
+	return 0x0000000000000750ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG490(unsigned long offset)
+{
+	return 0x00000000000007A8ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG491(unsigned long offset)
+{
+	return 0x00000000000007ACull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG492(unsigned long offset)
+{
+	return 0x00000000000007B0ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG516(unsigned long offset)
+{
+	return 0x0000000000000810ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCIERCX_CFG517(unsigned long offset)
+{
+	return 0x0000000000000814ull + (offset & 1) * 0;
+}
+
+static inline uint64_t CVMX_PCI_BAR1_INDEXX(unsigned long offset)
+{
+	return 0x0000000000000100ull + (offset & 31) * 4;
+}
+
+#define CVMX_PCI_BIST_REG CVMX_PCI_BIST_REG_FUNC()
+static inline uint64_t CVMX_PCI_BIST_REG_FUNC(void)
+{
+	return 0x00000000000001C0ull;
+}
+
+#define CVMX_PCI_CFG00 CVMX_PCI_CFG00_FUNC()
+static inline uint64_t CVMX_PCI_CFG00_FUNC(void)
+{
+	return 0x0000000000000000ull;
+}
+
+#define CVMX_PCI_CFG01 CVMX_PCI_CFG01_FUNC()
+static inline uint64_t CVMX_PCI_CFG01_FUNC(void)
+{
+	return 0x0000000000000004ull;
+}
+
+#define CVMX_PCI_CFG02 CVMX_PCI_CFG02_FUNC()
+static inline uint64_t CVMX_PCI_CFG02_FUNC(void)
+{
+	return 0x0000000000000008ull;
+}
+
+#define CVMX_PCI_CFG03 CVMX_PCI_CFG03_FUNC()
+static inline uint64_t CVMX_PCI_CFG03_FUNC(void)
+{
+	return 0x000000000000000Cull;
+}
+
+#define CVMX_PCI_CFG04 CVMX_PCI_CFG04_FUNC()
+static inline uint64_t CVMX_PCI_CFG04_FUNC(void)
+{
+	return 0x0000000000000010ull;
+}
+
+#define CVMX_PCI_CFG05 CVMX_PCI_CFG05_FUNC()
+static inline uint64_t CVMX_PCI_CFG05_FUNC(void)
+{
+	return 0x0000000000000014ull;
+}
+
+#define CVMX_PCI_CFG06 CVMX_PCI_CFG06_FUNC()
+static inline uint64_t CVMX_PCI_CFG06_FUNC(void)
+{
+	return 0x0000000000000018ull;
+}
+
+#define CVMX_PCI_CFG07 CVMX_PCI_CFG07_FUNC()
+static inline uint64_t CVMX_PCI_CFG07_FUNC(void)
+{
+	return 0x000000000000001Cull;
+}
+
+#define CVMX_PCI_CFG08 CVMX_PCI_CFG08_FUNC()
+static inline uint64_t CVMX_PCI_CFG08_FUNC(void)
+{
+	return 0x0000000000000020ull;
+}
+
+#define CVMX_PCI_CFG09 CVMX_PCI_CFG09_FUNC()
+static inline uint64_t CVMX_PCI_CFG09_FUNC(void)
+{
+	return 0x0000000000000024ull;
+}
+
+#define CVMX_PCI_CFG10 CVMX_PCI_CFG10_FUNC()
+static inline uint64_t CVMX_PCI_CFG10_FUNC(void)
+{
+	return 0x0000000000000028ull;
+}
+
+#define CVMX_PCI_CFG11 CVMX_PCI_CFG11_FUNC()
+static inline uint64_t CVMX_PCI_CFG11_FUNC(void)
+{
+	return 0x000000000000002Cull;
+}
+
+#define CVMX_PCI_CFG12 CVMX_PCI_CFG12_FUNC()
+static inline uint64_t CVMX_PCI_CFG12_FUNC(void)
+{
+	return 0x0000000000000030ull;
+}
+
+#define CVMX_PCI_CFG13 CVMX_PCI_CFG13_FUNC()
+static inline uint64_t CVMX_PCI_CFG13_FUNC(void)
+{
+	return 0x0000000000000034ull;
+}
+
+#define CVMX_PCI_CFG15 CVMX_PCI_CFG15_FUNC()
+static inline uint64_t CVMX_PCI_CFG15_FUNC(void)
+{
+	return 0x000000000000003Cull;
+}
+
+#define CVMX_PCI_CFG16 CVMX_PCI_CFG16_FUNC()
+static inline uint64_t CVMX_PCI_CFG16_FUNC(void)
+{
+	return 0x0000000000000040ull;
+}
+
+#define CVMX_PCI_CFG17 CVMX_PCI_CFG17_FUNC()
+static inline uint64_t CVMX_PCI_CFG17_FUNC(void)
+{
+	return 0x0000000000000044ull;
+}
+
+#define CVMX_PCI_CFG18 CVMX_PCI_CFG18_FUNC()
+static inline uint64_t CVMX_PCI_CFG18_FUNC(void)
+{
+	return 0x0000000000000048ull;
+}
+
+#define CVMX_PCI_CFG19 CVMX_PCI_CFG19_FUNC()
+static inline uint64_t CVMX_PCI_CFG19_FUNC(void)
+{
+	return 0x000000000000004Cull;
+}
+
+#define CVMX_PCI_CFG20 CVMX_PCI_CFG20_FUNC()
+static inline uint64_t CVMX_PCI_CFG20_FUNC(void)
+{
+	return 0x0000000000000050ull;
+}
+
+#define CVMX_PCI_CFG21 CVMX_PCI_CFG21_FUNC()
+static inline uint64_t CVMX_PCI_CFG21_FUNC(void)
+{
+	return 0x0000000000000054ull;
+}
+
+#define CVMX_PCI_CFG22 CVMX_PCI_CFG22_FUNC()
+static inline uint64_t CVMX_PCI_CFG22_FUNC(void)
+{
+	return 0x0000000000000058ull;
+}
+
+#define CVMX_PCI_CFG56 CVMX_PCI_CFG56_FUNC()
+static inline uint64_t CVMX_PCI_CFG56_FUNC(void)
+{
+	return 0x00000000000000E0ull;
+}
+
+#define CVMX_PCI_CFG57 CVMX_PCI_CFG57_FUNC()
+static inline uint64_t CVMX_PCI_CFG57_FUNC(void)
+{
+	return 0x00000000000000E4ull;
+}
+
+#define CVMX_PCI_CFG58 CVMX_PCI_CFG58_FUNC()
+static inline uint64_t CVMX_PCI_CFG58_FUNC(void)
+{
+	return 0x00000000000000E8ull;
+}
+
+#define CVMX_PCI_CFG59 CVMX_PCI_CFG59_FUNC()
+static inline uint64_t CVMX_PCI_CFG59_FUNC(void)
+{
+	return 0x00000000000000ECull;
+}
+
+#define CVMX_PCI_CFG60 CVMX_PCI_CFG60_FUNC()
+static inline uint64_t CVMX_PCI_CFG60_FUNC(void)
+{
+	return 0x00000000000000F0ull;
+}
+
+#define CVMX_PCI_CFG61 CVMX_PCI_CFG61_FUNC()
+static inline uint64_t CVMX_PCI_CFG61_FUNC(void)
+{
+	return 0x00000000000000F4ull;
+}
+
+#define CVMX_PCI_CFG62 CVMX_PCI_CFG62_FUNC()
+static inline uint64_t CVMX_PCI_CFG62_FUNC(void)
+{
+	return 0x00000000000000F8ull;
+}
+
+#define CVMX_PCI_CFG63 CVMX_PCI_CFG63_FUNC()
+static inline uint64_t CVMX_PCI_CFG63_FUNC(void)
+{
+	return 0x00000000000000FCull;
+}
+
+#define CVMX_PCI_CNT_REG CVMX_PCI_CNT_REG_FUNC()
+static inline uint64_t CVMX_PCI_CNT_REG_FUNC(void)
+{
+	return 0x00000000000001B8ull;
+}
+
+#define CVMX_PCI_CTL_STATUS_2 CVMX_PCI_CTL_STATUS_2_FUNC()
+static inline uint64_t CVMX_PCI_CTL_STATUS_2_FUNC(void)
+{
+	return 0x000000000000018Cull;
+}
+
+static inline uint64_t CVMX_PCI_DBELL_X(unsigned long offset)
+{
+	return 0x0000000000000080ull + (offset & 3) * 8;
+}
+
+#define CVMX_PCI_DMA_CNT0 CVMX_PCI_DMA_CNTX(0)
+#define CVMX_PCI_DMA_CNT1 CVMX_PCI_DMA_CNTX(1)
+static inline uint64_t CVMX_PCI_DMA_CNTX(unsigned long offset)
+{
+	return 0x00000000000000A0ull + (offset & 1) * 8;
+}
+
+#define CVMX_PCI_DMA_INT_LEV0 CVMX_PCI_DMA_INT_LEVX(0)
+#define CVMX_PCI_DMA_INT_LEV1 CVMX_PCI_DMA_INT_LEVX(1)
+static inline uint64_t CVMX_PCI_DMA_INT_LEVX(unsigned long offset)
+{
+	return 0x00000000000000A4ull + (offset & 1) * 8;
+}
+
+#define CVMX_PCI_DMA_TIME0 CVMX_PCI_DMA_TIMEX(0)
+#define CVMX_PCI_DMA_TIME1 CVMX_PCI_DMA_TIMEX(1)
+static inline uint64_t CVMX_PCI_DMA_TIMEX(unsigned long offset)
+{
+	return 0x00000000000000B0ull + (offset & 1) * 4;
+}
+
+#define CVMX_PCI_INSTR_COUNT0 CVMX_PCI_INSTR_COUNTX(0)
+#define CVMX_PCI_INSTR_COUNT1 CVMX_PCI_INSTR_COUNTX(1)
+#define CVMX_PCI_INSTR_COUNT2 CVMX_PCI_INSTR_COUNTX(2)
+#define CVMX_PCI_INSTR_COUNT3 CVMX_PCI_INSTR_COUNTX(3)
+static inline uint64_t CVMX_PCI_INSTR_COUNTX(unsigned long offset)
+{
+	return 0x0000000000000084ull + (offset & 3) * 8;
+}
+
+#define CVMX_PCI_INT_ENB CVMX_PCI_INT_ENB_FUNC()
+static inline uint64_t CVMX_PCI_INT_ENB_FUNC(void)
+{
+	return 0x0000000000000038ull;
+}
+
+#define CVMX_PCI_INT_ENB2 CVMX_PCI_INT_ENB2_FUNC()
+static inline uint64_t CVMX_PCI_INT_ENB2_FUNC(void)
+{
+	return 0x00000000000001A0ull;
+}
+
+#define CVMX_PCI_INT_SUM CVMX_PCI_INT_SUM_FUNC()
+static inline uint64_t CVMX_PCI_INT_SUM_FUNC(void)
+{
+	return 0x0000000000000030ull;
+}
+
+#define CVMX_PCI_INT_SUM2 CVMX_PCI_INT_SUM2_FUNC()
+static inline uint64_t CVMX_PCI_INT_SUM2_FUNC(void)
+{
+	return 0x0000000000000198ull;
+}
+
+#define CVMX_PCI_MSI_RCV CVMX_PCI_MSI_RCV_FUNC()
+static inline uint64_t CVMX_PCI_MSI_RCV_FUNC(void)
+{
+	return 0x00000000000000F0ull;
+}
+
+#define CVMX_PCI_PKTS_SENT0 CVMX_PCI_PKTS_SENTX(0)
+#define CVMX_PCI_PKTS_SENT1 CVMX_PCI_PKTS_SENTX(1)
+#define CVMX_PCI_PKTS_SENT2 CVMX_PCI_PKTS_SENTX(2)
+#define CVMX_PCI_PKTS_SENT3 CVMX_PCI_PKTS_SENTX(3)
+static inline uint64_t CVMX_PCI_PKTS_SENTX(unsigned long offset)
+{
+	return 0x0000000000000040ull + (offset & 3) * 16;
+}
+
+#define CVMX_PCI_PKTS_SENT_INT_LEV0 CVMX_PCI_PKTS_SENT_INT_LEVX(0)
+#define CVMX_PCI_PKTS_SENT_INT_LEV1 CVMX_PCI_PKTS_SENT_INT_LEVX(1)
+#define CVMX_PCI_PKTS_SENT_INT_LEV2 CVMX_PCI_PKTS_SENT_INT_LEVX(2)
+#define CVMX_PCI_PKTS_SENT_INT_LEV3 CVMX_PCI_PKTS_SENT_INT_LEVX(3)
+static inline uint64_t CVMX_PCI_PKTS_SENT_INT_LEVX(unsigned long offset)
+{
+	return 0x0000000000000048ull + (offset & 3) * 16;
+}
+
+#define CVMX_PCI_PKTS_SENT_TIME0 CVMX_PCI_PKTS_SENT_TIMEX(0)
+#define CVMX_PCI_PKTS_SENT_TIME1 CVMX_PCI_PKTS_SENT_TIMEX(1)
+#define CVMX_PCI_PKTS_SENT_TIME2 CVMX_PCI_PKTS_SENT_TIMEX(2)
+#define CVMX_PCI_PKTS_SENT_TIME3 CVMX_PCI_PKTS_SENT_TIMEX(3)
+static inline uint64_t CVMX_PCI_PKTS_SENT_TIMEX(unsigned long offset)
+{
+	return 0x000000000000004Cull + (offset & 3) * 16;
+}
+
+#define CVMX_PCI_PKT_CREDITS0 CVMX_PCI_PKT_CREDITSX(0)
+#define CVMX_PCI_PKT_CREDITS1 CVMX_PCI_PKT_CREDITSX(1)
+#define CVMX_PCI_PKT_CREDITS2 CVMX_PCI_PKT_CREDITSX(2)
+#define CVMX_PCI_PKT_CREDITS3 CVMX_PCI_PKT_CREDITSX(3)
+static inline uint64_t CVMX_PCI_PKT_CREDITSX(unsigned long offset)
+{
+	return 0x0000000000000044ull + (offset & 3) * 16;
+}
+
+#define CVMX_PCI_READ_CMD_6 CVMX_PCI_READ_CMD_6_FUNC()
+static inline uint64_t CVMX_PCI_READ_CMD_6_FUNC(void)
+{
+	return 0x0000000000000180ull;
+}
+
+#define CVMX_PCI_READ_CMD_C CVMX_PCI_READ_CMD_C_FUNC()
+static inline uint64_t CVMX_PCI_READ_CMD_C_FUNC(void)
+{
+	return 0x0000000000000184ull;
+}
+
+#define CVMX_PCI_READ_CMD_E CVMX_PCI_READ_CMD_E_FUNC()
+static inline uint64_t CVMX_PCI_READ_CMD_E_FUNC(void)
+{
+	return 0x0000000000000188ull;
+}
+
+#define CVMX_PCI_READ_TIMEOUT CVMX_PCI_READ_TIMEOUT_FUNC()
+static inline uint64_t CVMX_PCI_READ_TIMEOUT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000000B0ull);
+}
+
+#define CVMX_PCI_SCM_REG CVMX_PCI_SCM_REG_FUNC()
+static inline uint64_t CVMX_PCI_SCM_REG_FUNC(void)
+{
+	return 0x00000000000001A8ull;
+}
+
+#define CVMX_PCI_TSR_REG CVMX_PCI_TSR_REG_FUNC()
+static inline uint64_t CVMX_PCI_TSR_REG_FUNC(void)
+{
+	return 0x00000000000001B0ull;
+}
+
+#define CVMX_PCI_WIN_RD_ADDR CVMX_PCI_WIN_RD_ADDR_FUNC()
+static inline uint64_t CVMX_PCI_WIN_RD_ADDR_FUNC(void)
+{
+	return 0x0000000000000008ull;
+}
+
+#define CVMX_PCI_WIN_RD_DATA CVMX_PCI_WIN_RD_DATA_FUNC()
+static inline uint64_t CVMX_PCI_WIN_RD_DATA_FUNC(void)
+{
+	return 0x0000000000000020ull;
+}
+
+#define CVMX_PCI_WIN_WR_ADDR CVMX_PCI_WIN_WR_ADDR_FUNC()
+static inline uint64_t CVMX_PCI_WIN_WR_ADDR_FUNC(void)
+{
+	return 0x0000000000000000ull;
+}
+
+#define CVMX_PCI_WIN_WR_DATA CVMX_PCI_WIN_WR_DATA_FUNC()
+static inline uint64_t CVMX_PCI_WIN_WR_DATA_FUNC(void)
+{
+	return 0x0000000000000010ull;
+}
+
+#define CVMX_PCI_WIN_WR_MASK CVMX_PCI_WIN_WR_MASK_FUNC()
+static inline uint64_t CVMX_PCI_WIN_WR_MASK_FUNC(void)
+{
+	return 0x0000000000000018ull;
+}
+
+static inline uint64_t CVMX_PCMX_DMA_CFG(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000010018ull) + (offset & 3) * 16384;
+}
+
+static inline uint64_t CVMX_PCMX_INT_ENA(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000010020ull) + (offset & 3) * 16384;
+}
+
+static inline uint64_t CVMX_PCMX_INT_SUM(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000010028ull) + (offset & 3) * 16384;
+}
+
+static inline uint64_t CVMX_PCMX_RXADDR(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000010068ull) + (offset & 3) * 16384;
+}
+
+static inline uint64_t CVMX_PCMX_RXCNT(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000010060ull) + (offset & 3) * 16384;
+}
+
+static inline uint64_t CVMX_PCMX_RXMSK0(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00010700000100C0ull) + (offset & 3) * 16384;
+}
+
+static inline uint64_t CVMX_PCMX_RXMSK1(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00010700000100C8ull) + (offset & 3) * 16384;
+}
+
+static inline uint64_t CVMX_PCMX_RXMSK2(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00010700000100D0ull) + (offset & 3) * 16384;
+}
+
+static inline uint64_t CVMX_PCMX_RXMSK3(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00010700000100D8ull) + (offset & 3) * 16384;
+}
+
+static inline uint64_t CVMX_PCMX_RXMSK4(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00010700000100E0ull) + (offset & 3) * 16384;
+}
+
+static inline uint64_t CVMX_PCMX_RXMSK5(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00010700000100E8ull) + (offset & 3) * 16384;
+}
+
+static inline uint64_t CVMX_PCMX_RXMSK6(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00010700000100F0ull) + (offset & 3) * 16384;
+}
+
+static inline uint64_t CVMX_PCMX_RXMSK7(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00010700000100F8ull) + (offset & 3) * 16384;
+}
+
+static inline uint64_t CVMX_PCMX_RXSTART(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000010058ull) + (offset & 3) * 16384;
+}
+
+static inline uint64_t CVMX_PCMX_TDM_CFG(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000010010ull) + (offset & 3) * 16384;
+}
+
+static inline uint64_t CVMX_PCMX_TDM_DBG(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000010030ull) + (offset & 3) * 16384;
+}
+
+static inline uint64_t CVMX_PCMX_TXADDR(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000010050ull) + (offset & 3) * 16384;
+}
+
+static inline uint64_t CVMX_PCMX_TXCNT(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000010048ull) + (offset & 3) * 16384;
+}
+
+static inline uint64_t CVMX_PCMX_TXMSK0(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000010080ull) + (offset & 3) * 16384;
+}
+
+static inline uint64_t CVMX_PCMX_TXMSK1(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000010088ull) + (offset & 3) * 16384;
+}
+
+static inline uint64_t CVMX_PCMX_TXMSK2(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000010090ull) + (offset & 3) * 16384;
+}
+
+static inline uint64_t CVMX_PCMX_TXMSK3(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000010098ull) + (offset & 3) * 16384;
+}
+
+static inline uint64_t CVMX_PCMX_TXMSK4(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00010700000100A0ull) + (offset & 3) * 16384;
+}
+
+static inline uint64_t CVMX_PCMX_TXMSK5(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00010700000100A8ull) + (offset & 3) * 16384;
+}
+
+static inline uint64_t CVMX_PCMX_TXMSK6(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00010700000100B0ull) + (offset & 3) * 16384;
+}
+
+static inline uint64_t CVMX_PCMX_TXMSK7(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00010700000100B8ull) + (offset & 3) * 16384;
+}
+
+static inline uint64_t CVMX_PCMX_TXSTART(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000010040ull) + (offset & 3) * 16384;
+}
+
+static inline uint64_t CVMX_PCM_CLKX_CFG(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000010000ull) + (offset & 1) * 16384;
+}
+
+static inline uint64_t CVMX_PCM_CLKX_DBG(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000010038ull) + (offset & 1) * 16384;
+}
+
+static inline uint64_t CVMX_PCM_CLKX_GEN(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001070000010008ull) + (offset & 1) * 16384;
+}
+
+static inline uint64_t CVMX_PCSXX_10GBX_STATUS_REG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000828ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PCSXX_BIST_STATUS_REG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000870ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PCSXX_BIT_LOCK_STATUS_REG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000850ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PCSXX_CONTROL1_REG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000800ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PCSXX_CONTROL2_REG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000818ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PCSXX_INT_EN_REG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000860ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PCSXX_INT_REG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000858ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PCSXX_LOG_ANL_REG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000868ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PCSXX_MISC_CTL_REG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000848ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PCSXX_RX_SYNC_STATES_REG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000838ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PCSXX_SPD_ABIL_REG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000810ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PCSXX_STATUS1_REG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000808ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PCSXX_STATUS2_REG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000820ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PCSXX_TX_RX_POLARITY_REG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000840ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PCSXX_TX_RX_STATES_REG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0000830ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PCSX_ANX_ADV_REG(unsigned long offset,
+					     unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0001010ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x20000ull) * 1024;
+}
+
+static inline uint64_t CVMX_PCSX_ANX_EXT_ST_REG(unsigned long offset,
+						unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0001028ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x20000ull) * 1024;
+}
+
+static inline uint64_t CVMX_PCSX_ANX_LP_ABIL_REG(unsigned long offset,
+						 unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0001018ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x20000ull) * 1024;
+}
+
+static inline uint64_t CVMX_PCSX_ANX_RESULTS_REG(unsigned long offset,
+						 unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0001020ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x20000ull) * 1024;
+}
+
+static inline uint64_t CVMX_PCSX_INTX_EN_REG(unsigned long offset,
+					     unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0001088ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x20000ull) * 1024;
+}
+
+static inline uint64_t CVMX_PCSX_INTX_REG(unsigned long offset,
+					  unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0001080ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x20000ull) * 1024;
+}
+
+static inline uint64_t CVMX_PCSX_LINKX_TIMER_COUNT_REG(unsigned long offset,
+						       unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0001040ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x20000ull) * 1024;
+}
+
+static inline uint64_t CVMX_PCSX_LOG_ANLX_REG(unsigned long offset,
+					      unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0001090ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x20000ull) * 1024;
+}
+
+static inline uint64_t CVMX_PCSX_MISCX_CTL_REG(unsigned long offset,
+					       unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0001078ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x20000ull) * 1024;
+}
+
+static inline uint64_t CVMX_PCSX_MRX_CONTROL_REG(unsigned long offset,
+						 unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0001000ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x20000ull) * 1024;
+}
+
+static inline uint64_t CVMX_PCSX_MRX_STATUS_REG(unsigned long offset,
+						unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0001008ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x20000ull) * 1024;
+}
+
+static inline uint64_t CVMX_PCSX_RXX_STATES_REG(unsigned long offset,
+						unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0001058ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x20000ull) * 1024;
+}
+
+static inline uint64_t CVMX_PCSX_RXX_SYNC_REG(unsigned long offset,
+					      unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0001050ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x20000ull) * 1024;
+}
+
+static inline uint64_t CVMX_PCSX_SGMX_AN_ADV_REG(unsigned long offset,
+						 unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0001068ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x20000ull) * 1024;
+}
+
+static inline uint64_t CVMX_PCSX_SGMX_LP_ADV_REG(unsigned long offset,
+						 unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0001070ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x20000ull) * 1024;
+}
+
+static inline uint64_t CVMX_PCSX_TXX_STATES_REG(unsigned long offset,
+						unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0001060ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x20000ull) * 1024;
+}
+
+static inline uint64_t CVMX_PCSX_TX_RXX_POLARITY_REG(unsigned long offset,
+						     unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800B0001048ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x20000ull) * 1024;
+}
+
+static inline uint64_t CVMX_PESCX_BIST_STATUS(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800C8000018ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PESCX_BIST_STATUS2(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800C8000418ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PESCX_CFG_RD(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800C8000030ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PESCX_CFG_WR(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800C8000028ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PESCX_CPL_LUT_VALID(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800C8000098ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PESCX_CTL_STATUS(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800C8000000ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PESCX_CTL_STATUS2(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800C8000400ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PESCX_DBG_INFO(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800C8000008ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PESCX_DBG_INFO_EN(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800C80000A0ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PESCX_DIAG_STATUS(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800C8000020ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PESCX_P2N_BAR0_START(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800C8000080ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PESCX_P2N_BAR1_START(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800C8000088ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PESCX_P2N_BAR2_START(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800C8000090ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PESCX_P2P_BARX_END(unsigned long offset,
+					       unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800C8000048ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x800000ull) * 16;
+}
+
+static inline uint64_t CVMX_PESCX_P2P_BARX_START(unsigned long offset,
+						 unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800C8000040ull) + ((offset & 3) +
+							 (block_id & 1) *
+							 0x800000ull) * 16;
+}
+
+static inline uint64_t CVMX_PESCX_TLP_CREDITS(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800C8000038ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_PEXP_NPEI_BAR1_INDEXX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000008000ull) + (offset & 31) * 16;
+}
+
+#define CVMX_PEXP_NPEI_BIST_STATUS CVMX_PEXP_NPEI_BIST_STATUS_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_BIST_STATUS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000008580ull);
+}
+
+#define CVMX_PEXP_NPEI_BIST_STATUS2 CVMX_PEXP_NPEI_BIST_STATUS2_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_BIST_STATUS2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000008680ull);
+}
+
+#define CVMX_PEXP_NPEI_CTL_PORT0 CVMX_PEXP_NPEI_CTL_PORT0_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_CTL_PORT0_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000008250ull);
+}
+
+#define CVMX_PEXP_NPEI_CTL_PORT1 CVMX_PEXP_NPEI_CTL_PORT1_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_CTL_PORT1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000008260ull);
+}
+
+#define CVMX_PEXP_NPEI_CTL_STATUS CVMX_PEXP_NPEI_CTL_STATUS_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_CTL_STATUS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000008570ull);
+}
+
+#define CVMX_PEXP_NPEI_CTL_STATUS2 CVMX_PEXP_NPEI_CTL_STATUS2_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_CTL_STATUS2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000BC00ull);
+}
+
+#define CVMX_PEXP_NPEI_DATA_OUT_CNT CVMX_PEXP_NPEI_DATA_OUT_CNT_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_DATA_OUT_CNT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000085F0ull);
+}
+
+#define CVMX_PEXP_NPEI_DBG_DATA CVMX_PEXP_NPEI_DBG_DATA_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_DBG_DATA_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000008510ull);
+}
+
+#define CVMX_PEXP_NPEI_DBG_SELECT CVMX_PEXP_NPEI_DBG_SELECT_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_DBG_SELECT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000008500ull);
+}
+
+#define CVMX_PEXP_NPEI_DMA0_INT_LEVEL CVMX_PEXP_NPEI_DMA0_INT_LEVEL_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_DMA0_INT_LEVEL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000085C0ull);
+}
+
+#define CVMX_PEXP_NPEI_DMA1_INT_LEVEL CVMX_PEXP_NPEI_DMA1_INT_LEVEL_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_DMA1_INT_LEVEL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000085D0ull);
+}
+
+static inline uint64_t CVMX_PEXP_NPEI_DMAX_COUNTS(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000008450ull) + (offset & 7) * 16;
+}
+
+static inline uint64_t CVMX_PEXP_NPEI_DMAX_DBELL(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000083B0ull) + (offset & 7) * 16;
+}
+
+static inline uint64_t CVMX_PEXP_NPEI_DMAX_IBUFF_SADDR(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000008400ull) + (offset & 7) * 16;
+}
+
+static inline uint64_t CVMX_PEXP_NPEI_DMAX_NADDR(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000084A0ull) + (offset & 7) * 16;
+}
+
+#define CVMX_PEXP_NPEI_DMA_CNTS CVMX_PEXP_NPEI_DMA_CNTS_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_DMA_CNTS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000085E0ull);
+}
+
+#define CVMX_PEXP_NPEI_DMA_CONTROL CVMX_PEXP_NPEI_DMA_CONTROL_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_DMA_CONTROL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000083A0ull);
+}
+
+#define CVMX_PEXP_NPEI_INT_A_ENB CVMX_PEXP_NPEI_INT_A_ENB_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_INT_A_ENB_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000008560ull);
+}
+
+#define CVMX_PEXP_NPEI_INT_A_ENB2 CVMX_PEXP_NPEI_INT_A_ENB2_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_INT_A_ENB2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000BCE0ull);
+}
+
+#define CVMX_PEXP_NPEI_INT_A_SUM CVMX_PEXP_NPEI_INT_A_SUM_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_INT_A_SUM_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000008550ull);
+}
+
+#define CVMX_PEXP_NPEI_INT_ENB CVMX_PEXP_NPEI_INT_ENB_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_INT_ENB_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000008540ull);
+}
+
+#define CVMX_PEXP_NPEI_INT_ENB2 CVMX_PEXP_NPEI_INT_ENB2_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_INT_ENB2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000BCD0ull);
+}
+
+#define CVMX_PEXP_NPEI_INT_INFO CVMX_PEXP_NPEI_INT_INFO_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_INT_INFO_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000008590ull);
+}
+
+#define CVMX_PEXP_NPEI_INT_SUM CVMX_PEXP_NPEI_INT_SUM_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_INT_SUM_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000008530ull);
+}
+
+#define CVMX_PEXP_NPEI_INT_SUM2 CVMX_PEXP_NPEI_INT_SUM2_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_INT_SUM2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000BCC0ull);
+}
+
+#define CVMX_PEXP_NPEI_LAST_WIN_RDATA0 CVMX_PEXP_NPEI_LAST_WIN_RDATA0_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_LAST_WIN_RDATA0_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000008600ull);
+}
+
+#define CVMX_PEXP_NPEI_LAST_WIN_RDATA1 CVMX_PEXP_NPEI_LAST_WIN_RDATA1_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_LAST_WIN_RDATA1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000008610ull);
+}
+
+#define CVMX_PEXP_NPEI_MEM_ACCESS_CTL CVMX_PEXP_NPEI_MEM_ACCESS_CTL_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_MEM_ACCESS_CTL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000084F0ull);
+}
+
+static inline uint64_t CVMX_PEXP_NPEI_MEM_ACCESS_SUBIDX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000008280ull) + (offset & 31) * 16 -
+	    16 * 12;
+}
+
+#define CVMX_PEXP_NPEI_MSI_ENB0 CVMX_PEXP_NPEI_MSI_ENB0_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_MSI_ENB0_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000BC50ull);
+}
+
+#define CVMX_PEXP_NPEI_MSI_ENB1 CVMX_PEXP_NPEI_MSI_ENB1_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_MSI_ENB1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000BC60ull);
+}
+
+#define CVMX_PEXP_NPEI_MSI_ENB2 CVMX_PEXP_NPEI_MSI_ENB2_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_MSI_ENB2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000BC70ull);
+}
+
+#define CVMX_PEXP_NPEI_MSI_ENB3 CVMX_PEXP_NPEI_MSI_ENB3_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_MSI_ENB3_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000BC80ull);
+}
+
+#define CVMX_PEXP_NPEI_MSI_RCV0 CVMX_PEXP_NPEI_MSI_RCV0_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_MSI_RCV0_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000BC10ull);
+}
+
+#define CVMX_PEXP_NPEI_MSI_RCV1 CVMX_PEXP_NPEI_MSI_RCV1_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_MSI_RCV1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000BC20ull);
+}
+
+#define CVMX_PEXP_NPEI_MSI_RCV2 CVMX_PEXP_NPEI_MSI_RCV2_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_MSI_RCV2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000BC30ull);
+}
+
+#define CVMX_PEXP_NPEI_MSI_RCV3 CVMX_PEXP_NPEI_MSI_RCV3_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_MSI_RCV3_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000BC40ull);
+}
+
+#define CVMX_PEXP_NPEI_MSI_RD_MAP CVMX_PEXP_NPEI_MSI_RD_MAP_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_MSI_RD_MAP_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000BCA0ull);
+}
+
+#define CVMX_PEXP_NPEI_MSI_W1C_ENB0 CVMX_PEXP_NPEI_MSI_W1C_ENB0_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_MSI_W1C_ENB0_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000BCF0ull);
+}
+
+#define CVMX_PEXP_NPEI_MSI_W1C_ENB1 CVMX_PEXP_NPEI_MSI_W1C_ENB1_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_MSI_W1C_ENB1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000BD00ull);
+}
+
+#define CVMX_PEXP_NPEI_MSI_W1C_ENB2 CVMX_PEXP_NPEI_MSI_W1C_ENB2_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_MSI_W1C_ENB2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000BD10ull);
+}
+
+#define CVMX_PEXP_NPEI_MSI_W1C_ENB3 CVMX_PEXP_NPEI_MSI_W1C_ENB3_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_MSI_W1C_ENB3_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000BD20ull);
+}
+
+#define CVMX_PEXP_NPEI_MSI_W1S_ENB0 CVMX_PEXP_NPEI_MSI_W1S_ENB0_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_MSI_W1S_ENB0_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000BD30ull);
+}
+
+#define CVMX_PEXP_NPEI_MSI_W1S_ENB1 CVMX_PEXP_NPEI_MSI_W1S_ENB1_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_MSI_W1S_ENB1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000BD40ull);
+}
+
+#define CVMX_PEXP_NPEI_MSI_W1S_ENB2 CVMX_PEXP_NPEI_MSI_W1S_ENB2_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_MSI_W1S_ENB2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000BD50ull);
+}
+
+#define CVMX_PEXP_NPEI_MSI_W1S_ENB3 CVMX_PEXP_NPEI_MSI_W1S_ENB3_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_MSI_W1S_ENB3_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000BD60ull);
+}
+
+#define CVMX_PEXP_NPEI_MSI_WR_MAP CVMX_PEXP_NPEI_MSI_WR_MAP_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_MSI_WR_MAP_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000BC90ull);
+}
+
+#define CVMX_PEXP_NPEI_PCIE_CREDIT_CNT CVMX_PEXP_NPEI_PCIE_CREDIT_CNT_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PCIE_CREDIT_CNT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000BD70ull);
+}
+
+#define CVMX_PEXP_NPEI_PCIE_MSI_RCV CVMX_PEXP_NPEI_PCIE_MSI_RCV_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PCIE_MSI_RCV_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000BCB0ull);
+}
+
+#define CVMX_PEXP_NPEI_PCIE_MSI_RCV_B1 CVMX_PEXP_NPEI_PCIE_MSI_RCV_B1_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PCIE_MSI_RCV_B1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000008650ull);
+}
+
+#define CVMX_PEXP_NPEI_PCIE_MSI_RCV_B2 CVMX_PEXP_NPEI_PCIE_MSI_RCV_B2_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PCIE_MSI_RCV_B2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000008660ull);
+}
+
+#define CVMX_PEXP_NPEI_PCIE_MSI_RCV_B3 CVMX_PEXP_NPEI_PCIE_MSI_RCV_B3_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PCIE_MSI_RCV_B3_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000008670ull);
+}
+
+static inline uint64_t CVMX_PEXP_NPEI_PKTX_CNTS(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000A400ull) + (offset & 31) * 16;
+}
+
+static inline uint64_t CVMX_PEXP_NPEI_PKTX_INSTR_BADDR(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000A800ull) + (offset & 31) * 16;
+}
+
+static inline uint64_t CVMX_PEXP_NPEI_PKTX_INSTR_BAOFF_DBELL(unsigned long
+							     offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000AC00ull) + (offset & 31) * 16;
+}
+
+static inline uint64_t CVMX_PEXP_NPEI_PKTX_INSTR_FIFO_RSIZE(unsigned long
+							    offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000B000ull) + (offset & 31) * 16;
+}
+
+static inline uint64_t CVMX_PEXP_NPEI_PKTX_INSTR_HEADER(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000B400ull) + (offset & 31) * 16;
+}
+
+static inline uint64_t CVMX_PEXP_NPEI_PKTX_IN_BP(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000B800ull) + (offset & 31) * 16;
+}
+
+static inline uint64_t CVMX_PEXP_NPEI_PKTX_SLIST_BADDR(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000009400ull) + (offset & 31) * 16;
+}
+
+static inline uint64_t CVMX_PEXP_NPEI_PKTX_SLIST_BAOFF_DBELL(unsigned long
+							     offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000009800ull) + (offset & 31) * 16;
+}
+
+static inline uint64_t CVMX_PEXP_NPEI_PKTX_SLIST_FIFO_RSIZE(unsigned long
+							    offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000009C00ull) + (offset & 31) * 16;
+}
+
+#define CVMX_PEXP_NPEI_PKT_CNT_INT CVMX_PEXP_NPEI_PKT_CNT_INT_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PKT_CNT_INT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000009110ull);
+}
+
+#define CVMX_PEXP_NPEI_PKT_CNT_INT_ENB CVMX_PEXP_NPEI_PKT_CNT_INT_ENB_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PKT_CNT_INT_ENB_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000009130ull);
+}
+
+#define CVMX_PEXP_NPEI_PKT_DATA_OUT_ES CVMX_PEXP_NPEI_PKT_DATA_OUT_ES_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PKT_DATA_OUT_ES_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000090B0ull);
+}
+
+#define CVMX_PEXP_NPEI_PKT_DATA_OUT_NS CVMX_PEXP_NPEI_PKT_DATA_OUT_NS_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PKT_DATA_OUT_NS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000090A0ull);
+}
+
+#define CVMX_PEXP_NPEI_PKT_DATA_OUT_ROR CVMX_PEXP_NPEI_PKT_DATA_OUT_ROR_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PKT_DATA_OUT_ROR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000009090ull);
+}
+
+#define CVMX_PEXP_NPEI_PKT_DPADDR CVMX_PEXP_NPEI_PKT_DPADDR_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PKT_DPADDR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000009080ull);
+}
+
+#define CVMX_PEXP_NPEI_PKT_INPUT_CONTROL CVMX_PEXP_NPEI_PKT_INPUT_CONTROL_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PKT_INPUT_CONTROL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000009150ull);
+}
+
+#define CVMX_PEXP_NPEI_PKT_INSTR_ENB CVMX_PEXP_NPEI_PKT_INSTR_ENB_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PKT_INSTR_ENB_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000009000ull);
+}
+
+#define CVMX_PEXP_NPEI_PKT_INSTR_RD_SIZE CVMX_PEXP_NPEI_PKT_INSTR_RD_SIZE_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PKT_INSTR_RD_SIZE_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000009190ull);
+}
+
+#define CVMX_PEXP_NPEI_PKT_INSTR_SIZE CVMX_PEXP_NPEI_PKT_INSTR_SIZE_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PKT_INSTR_SIZE_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000009020ull);
+}
+
+#define CVMX_PEXP_NPEI_PKT_INT_LEVELS CVMX_PEXP_NPEI_PKT_INT_LEVELS_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PKT_INT_LEVELS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000009100ull);
+}
+
+#define CVMX_PEXP_NPEI_PKT_IN_BP CVMX_PEXP_NPEI_PKT_IN_BP_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PKT_IN_BP_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000086B0ull);
+}
+
+static inline uint64_t CVMX_PEXP_NPEI_PKT_IN_DONEX_CNTS(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011F000000A000ull) + (offset & 31) * 16;
+}
+
+#define CVMX_PEXP_NPEI_PKT_IN_INSTR_COUNTS CVMX_PEXP_NPEI_PKT_IN_INSTR_COUNTS_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PKT_IN_INSTR_COUNTS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000086A0ull);
+}
+
+#define CVMX_PEXP_NPEI_PKT_IN_PCIE_PORT CVMX_PEXP_NPEI_PKT_IN_PCIE_PORT_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PKT_IN_PCIE_PORT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000091A0ull);
+}
+
+#define CVMX_PEXP_NPEI_PKT_IPTR CVMX_PEXP_NPEI_PKT_IPTR_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PKT_IPTR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000009070ull);
+}
+
+#define CVMX_PEXP_NPEI_PKT_OUTPUT_WMARK CVMX_PEXP_NPEI_PKT_OUTPUT_WMARK_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PKT_OUTPUT_WMARK_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000009160ull);
+}
+
+#define CVMX_PEXP_NPEI_PKT_OUT_BMODE CVMX_PEXP_NPEI_PKT_OUT_BMODE_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PKT_OUT_BMODE_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000090D0ull);
+}
+
+#define CVMX_PEXP_NPEI_PKT_OUT_ENB CVMX_PEXP_NPEI_PKT_OUT_ENB_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PKT_OUT_ENB_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000009010ull);
+}
+
+#define CVMX_PEXP_NPEI_PKT_PCIE_PORT CVMX_PEXP_NPEI_PKT_PCIE_PORT_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PKT_PCIE_PORT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F00000090E0ull);
+}
+
+#define CVMX_PEXP_NPEI_PKT_PORT_IN_RST CVMX_PEXP_NPEI_PKT_PORT_IN_RST_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PKT_PORT_IN_RST_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000008690ull);
+}
+
+#define CVMX_PEXP_NPEI_PKT_SLIST_ES CVMX_PEXP_NPEI_PKT_SLIST_ES_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PKT_SLIST_ES_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000009050ull);
+}
+
+#define CVMX_PEXP_NPEI_PKT_SLIST_ID_SIZE CVMX_PEXP_NPEI_PKT_SLIST_ID_SIZE_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PKT_SLIST_ID_SIZE_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000009180ull);
+}
+
+#define CVMX_PEXP_NPEI_PKT_SLIST_NS CVMX_PEXP_NPEI_PKT_SLIST_NS_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PKT_SLIST_NS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000009040ull);
+}
+
+#define CVMX_PEXP_NPEI_PKT_SLIST_ROR CVMX_PEXP_NPEI_PKT_SLIST_ROR_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PKT_SLIST_ROR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000009030ull);
+}
+
+#define CVMX_PEXP_NPEI_PKT_TIME_INT CVMX_PEXP_NPEI_PKT_TIME_INT_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PKT_TIME_INT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000009120ull);
+}
+
+#define CVMX_PEXP_NPEI_PKT_TIME_INT_ENB CVMX_PEXP_NPEI_PKT_TIME_INT_ENB_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_PKT_TIME_INT_ENB_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000009140ull);
+}
+
+#define CVMX_PEXP_NPEI_RSL_INT_BLOCKS CVMX_PEXP_NPEI_RSL_INT_BLOCKS_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_RSL_INT_BLOCKS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000008520ull);
+}
+
+#define CVMX_PEXP_NPEI_SCRATCH_1 CVMX_PEXP_NPEI_SCRATCH_1_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_SCRATCH_1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000008270ull);
+}
+
+#define CVMX_PEXP_NPEI_STATE1 CVMX_PEXP_NPEI_STATE1_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_STATE1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000008620ull);
+}
+
+#define CVMX_PEXP_NPEI_STATE2 CVMX_PEXP_NPEI_STATE2_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_STATE2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000008630ull);
+}
+
+#define CVMX_PEXP_NPEI_STATE3 CVMX_PEXP_NPEI_STATE3_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_STATE3_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000008640ull);
+}
+
+#define CVMX_PEXP_NPEI_WINDOW_CTL CVMX_PEXP_NPEI_WINDOW_CTL_FUNC()
+static inline uint64_t CVMX_PEXP_NPEI_WINDOW_CTL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011F0000008380ull);
+}
+
+#define CVMX_PIP_BCK_PRS CVMX_PIP_BCK_PRS_FUNC()
+static inline uint64_t CVMX_PIP_BCK_PRS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000038ull);
+}
+
+#define CVMX_PIP_BIST_STATUS CVMX_PIP_BIST_STATUS_FUNC()
+static inline uint64_t CVMX_PIP_BIST_STATUS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000000ull);
+}
+
+static inline uint64_t CVMX_PIP_CRC_CTLX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000040ull) + (offset & 1) * 8;
+}
+
+static inline uint64_t CVMX_PIP_CRC_IVX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000050ull) + (offset & 1) * 8;
+}
+
+static inline uint64_t CVMX_PIP_DEC_IPSECX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000080ull) + (offset & 3) * 8;
+}
+
+#define CVMX_PIP_DSA_SRC_GRP CVMX_PIP_DSA_SRC_GRP_FUNC()
+static inline uint64_t CVMX_PIP_DSA_SRC_GRP_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000190ull);
+}
+
+#define CVMX_PIP_DSA_VID_GRP CVMX_PIP_DSA_VID_GRP_FUNC()
+static inline uint64_t CVMX_PIP_DSA_VID_GRP_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000198ull);
+}
+
+static inline uint64_t CVMX_PIP_FRM_LEN_CHKX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000180ull) + (offset & 1) * 8;
+}
+
+#define CVMX_PIP_GBL_CFG CVMX_PIP_GBL_CFG_FUNC()
+static inline uint64_t CVMX_PIP_GBL_CFG_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000028ull);
+}
+
+#define CVMX_PIP_GBL_CTL CVMX_PIP_GBL_CTL_FUNC()
+static inline uint64_t CVMX_PIP_GBL_CTL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000020ull);
+}
+
+#define CVMX_PIP_HG_PRI_QOS CVMX_PIP_HG_PRI_QOS_FUNC()
+static inline uint64_t CVMX_PIP_HG_PRI_QOS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A00001A0ull);
+}
+
+#define CVMX_PIP_INT_EN CVMX_PIP_INT_EN_FUNC()
+static inline uint64_t CVMX_PIP_INT_EN_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000010ull);
+}
+
+#define CVMX_PIP_INT_REG CVMX_PIP_INT_REG_FUNC()
+static inline uint64_t CVMX_PIP_INT_REG_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000008ull);
+}
+
+#define CVMX_PIP_IP_OFFSET CVMX_PIP_IP_OFFSET_FUNC()
+static inline uint64_t CVMX_PIP_IP_OFFSET_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000060ull);
+}
+
+static inline uint64_t CVMX_PIP_PRT_CFGX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000200ull) + (offset & 63) * 8;
+}
+
+static inline uint64_t CVMX_PIP_PRT_TAGX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000400ull) + (offset & 63) * 8;
+}
+
+static inline uint64_t CVMX_PIP_QOS_DIFFX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000600ull) + (offset & 63) * 8;
+}
+
+static inline uint64_t CVMX_PIP_QOS_VLANX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A00000C0ull) + (offset & 7) * 8;
+}
+
+static inline uint64_t CVMX_PIP_QOS_WATCHX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000100ull) + (offset & 7) * 8;
+}
+
+#define CVMX_PIP_RAW_WORD CVMX_PIP_RAW_WORD_FUNC()
+static inline uint64_t CVMX_PIP_RAW_WORD_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A00000B0ull);
+}
+
+#define CVMX_PIP_SFT_RST CVMX_PIP_SFT_RST_FUNC()
+static inline uint64_t CVMX_PIP_SFT_RST_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000030ull);
+}
+
+static inline uint64_t CVMX_PIP_STAT0_PRTX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000800ull) + (offset & 63) * 80;
+}
+
+static inline uint64_t CVMX_PIP_STAT1_PRTX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000808ull) + (offset & 63) * 80;
+}
+
+static inline uint64_t CVMX_PIP_STAT2_PRTX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000810ull) + (offset & 63) * 80;
+}
+
+static inline uint64_t CVMX_PIP_STAT3_PRTX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000818ull) + (offset & 63) * 80;
+}
+
+static inline uint64_t CVMX_PIP_STAT4_PRTX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000820ull) + (offset & 63) * 80;
+}
+
+static inline uint64_t CVMX_PIP_STAT5_PRTX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000828ull) + (offset & 63) * 80;
+}
+
+static inline uint64_t CVMX_PIP_STAT6_PRTX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000830ull) + (offset & 63) * 80;
+}
+
+static inline uint64_t CVMX_PIP_STAT7_PRTX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000838ull) + (offset & 63) * 80;
+}
+
+static inline uint64_t CVMX_PIP_STAT8_PRTX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000840ull) + (offset & 63) * 80;
+}
+
+static inline uint64_t CVMX_PIP_STAT9_PRTX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000848ull) + (offset & 63) * 80;
+}
+
+#define CVMX_PIP_STAT_CTL CVMX_PIP_STAT_CTL_FUNC()
+static inline uint64_t CVMX_PIP_STAT_CTL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000018ull);
+}
+
+static inline uint64_t CVMX_PIP_STAT_INB_ERRSX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0001A10ull) + (offset & 63) * 32;
+}
+
+static inline uint64_t CVMX_PIP_STAT_INB_OCTSX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0001A08ull) + (offset & 63) * 32;
+}
+
+static inline uint64_t CVMX_PIP_STAT_INB_PKTSX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0001A00ull) + (offset & 63) * 32;
+}
+
+static inline uint64_t CVMX_PIP_TAG_INCX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0001800ull) + (offset & 63) * 8;
+}
+
+#define CVMX_PIP_TAG_MASK CVMX_PIP_TAG_MASK_FUNC()
+static inline uint64_t CVMX_PIP_TAG_MASK_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000070ull);
+}
+
+#define CVMX_PIP_TAG_SECRET CVMX_PIP_TAG_SECRET_FUNC()
+static inline uint64_t CVMX_PIP_TAG_SECRET_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000068ull);
+}
+
+#define CVMX_PIP_TODO_ENTRY CVMX_PIP_TODO_ENTRY_FUNC()
+static inline uint64_t CVMX_PIP_TODO_ENTRY_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A0000078ull);
+}
+
+#define CVMX_PKO_MEM_COUNT0 CVMX_PKO_MEM_COUNT0_FUNC()
+static inline uint64_t CVMX_PKO_MEM_COUNT0_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050001080ull);
+}
+
+#define CVMX_PKO_MEM_COUNT1 CVMX_PKO_MEM_COUNT1_FUNC()
+static inline uint64_t CVMX_PKO_MEM_COUNT1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050001088ull);
+}
+
+#define CVMX_PKO_MEM_DEBUG0 CVMX_PKO_MEM_DEBUG0_FUNC()
+static inline uint64_t CVMX_PKO_MEM_DEBUG0_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050001100ull);
+}
+
+#define CVMX_PKO_MEM_DEBUG1 CVMX_PKO_MEM_DEBUG1_FUNC()
+static inline uint64_t CVMX_PKO_MEM_DEBUG1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050001108ull);
+}
+
+#define CVMX_PKO_MEM_DEBUG10 CVMX_PKO_MEM_DEBUG10_FUNC()
+static inline uint64_t CVMX_PKO_MEM_DEBUG10_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050001150ull);
+}
+
+#define CVMX_PKO_MEM_DEBUG11 CVMX_PKO_MEM_DEBUG11_FUNC()
+static inline uint64_t CVMX_PKO_MEM_DEBUG11_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050001158ull);
+}
+
+#define CVMX_PKO_MEM_DEBUG12 CVMX_PKO_MEM_DEBUG12_FUNC()
+static inline uint64_t CVMX_PKO_MEM_DEBUG12_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050001160ull);
+}
+
+#define CVMX_PKO_MEM_DEBUG13 CVMX_PKO_MEM_DEBUG13_FUNC()
+static inline uint64_t CVMX_PKO_MEM_DEBUG13_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050001168ull);
+}
+
+#define CVMX_PKO_MEM_DEBUG14 CVMX_PKO_MEM_DEBUG14_FUNC()
+static inline uint64_t CVMX_PKO_MEM_DEBUG14_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050001170ull);
+}
+
+#define CVMX_PKO_MEM_DEBUG2 CVMX_PKO_MEM_DEBUG2_FUNC()
+static inline uint64_t CVMX_PKO_MEM_DEBUG2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050001110ull);
+}
+
+#define CVMX_PKO_MEM_DEBUG3 CVMX_PKO_MEM_DEBUG3_FUNC()
+static inline uint64_t CVMX_PKO_MEM_DEBUG3_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050001118ull);
+}
+
+#define CVMX_PKO_MEM_DEBUG4 CVMX_PKO_MEM_DEBUG4_FUNC()
+static inline uint64_t CVMX_PKO_MEM_DEBUG4_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050001120ull);
+}
+
+#define CVMX_PKO_MEM_DEBUG5 CVMX_PKO_MEM_DEBUG5_FUNC()
+static inline uint64_t CVMX_PKO_MEM_DEBUG5_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050001128ull);
+}
+
+#define CVMX_PKO_MEM_DEBUG6 CVMX_PKO_MEM_DEBUG6_FUNC()
+static inline uint64_t CVMX_PKO_MEM_DEBUG6_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050001130ull);
+}
+
+#define CVMX_PKO_MEM_DEBUG7 CVMX_PKO_MEM_DEBUG7_FUNC()
+static inline uint64_t CVMX_PKO_MEM_DEBUG7_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050001138ull);
+}
+
+#define CVMX_PKO_MEM_DEBUG8 CVMX_PKO_MEM_DEBUG8_FUNC()
+static inline uint64_t CVMX_PKO_MEM_DEBUG8_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050001140ull);
+}
+
+#define CVMX_PKO_MEM_DEBUG9 CVMX_PKO_MEM_DEBUG9_FUNC()
+static inline uint64_t CVMX_PKO_MEM_DEBUG9_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050001148ull);
+}
+
+#define CVMX_PKO_MEM_PORT_PTRS CVMX_PKO_MEM_PORT_PTRS_FUNC()
+static inline uint64_t CVMX_PKO_MEM_PORT_PTRS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050001010ull);
+}
+
+#define CVMX_PKO_MEM_PORT_QOS CVMX_PKO_MEM_PORT_QOS_FUNC()
+static inline uint64_t CVMX_PKO_MEM_PORT_QOS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050001018ull);
+}
+
+#define CVMX_PKO_MEM_PORT_RATE0 CVMX_PKO_MEM_PORT_RATE0_FUNC()
+static inline uint64_t CVMX_PKO_MEM_PORT_RATE0_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050001020ull);
+}
+
+#define CVMX_PKO_MEM_PORT_RATE1 CVMX_PKO_MEM_PORT_RATE1_FUNC()
+static inline uint64_t CVMX_PKO_MEM_PORT_RATE1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050001028ull);
+}
+
+#define CVMX_PKO_MEM_QUEUE_PTRS CVMX_PKO_MEM_QUEUE_PTRS_FUNC()
+static inline uint64_t CVMX_PKO_MEM_QUEUE_PTRS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050001000ull);
+}
+
+#define CVMX_PKO_MEM_QUEUE_QOS CVMX_PKO_MEM_QUEUE_QOS_FUNC()
+static inline uint64_t CVMX_PKO_MEM_QUEUE_QOS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050001008ull);
+}
+
+#define CVMX_PKO_REG_BIST_RESULT CVMX_PKO_REG_BIST_RESULT_FUNC()
+static inline uint64_t CVMX_PKO_REG_BIST_RESULT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050000080ull);
+}
+
+#define CVMX_PKO_REG_CMD_BUF CVMX_PKO_REG_CMD_BUF_FUNC()
+static inline uint64_t CVMX_PKO_REG_CMD_BUF_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050000010ull);
+}
+
+static inline uint64_t CVMX_PKO_REG_CRC_CTLX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050000028ull) + (offset & 1) * 8;
+}
+
+#define CVMX_PKO_REG_CRC_ENABLE CVMX_PKO_REG_CRC_ENABLE_FUNC()
+static inline uint64_t CVMX_PKO_REG_CRC_ENABLE_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050000020ull);
+}
+
+static inline uint64_t CVMX_PKO_REG_CRC_IVX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050000038ull) + (offset & 1) * 8;
+}
+
+#define CVMX_PKO_REG_DEBUG0 CVMX_PKO_REG_DEBUG0_FUNC()
+static inline uint64_t CVMX_PKO_REG_DEBUG0_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050000098ull);
+}
+
+#define CVMX_PKO_REG_DEBUG1 CVMX_PKO_REG_DEBUG1_FUNC()
+static inline uint64_t CVMX_PKO_REG_DEBUG1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800500000A0ull);
+}
+
+#define CVMX_PKO_REG_DEBUG2 CVMX_PKO_REG_DEBUG2_FUNC()
+static inline uint64_t CVMX_PKO_REG_DEBUG2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800500000A8ull);
+}
+
+#define CVMX_PKO_REG_DEBUG3 CVMX_PKO_REG_DEBUG3_FUNC()
+static inline uint64_t CVMX_PKO_REG_DEBUG3_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800500000B0ull);
+}
+
+#define CVMX_PKO_REG_ENGINE_INFLIGHT CVMX_PKO_REG_ENGINE_INFLIGHT_FUNC()
+static inline uint64_t CVMX_PKO_REG_ENGINE_INFLIGHT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050000050ull);
+}
+
+#define CVMX_PKO_REG_ENGINE_THRESH CVMX_PKO_REG_ENGINE_THRESH_FUNC()
+static inline uint64_t CVMX_PKO_REG_ENGINE_THRESH_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050000058ull);
+}
+
+#define CVMX_PKO_REG_ERROR CVMX_PKO_REG_ERROR_FUNC()
+static inline uint64_t CVMX_PKO_REG_ERROR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050000088ull);
+}
+
+#define CVMX_PKO_REG_FLAGS CVMX_PKO_REG_FLAGS_FUNC()
+static inline uint64_t CVMX_PKO_REG_FLAGS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050000000ull);
+}
+
+#define CVMX_PKO_REG_GMX_PORT_MODE CVMX_PKO_REG_GMX_PORT_MODE_FUNC()
+static inline uint64_t CVMX_PKO_REG_GMX_PORT_MODE_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050000018ull);
+}
+
+#define CVMX_PKO_REG_INT_MASK CVMX_PKO_REG_INT_MASK_FUNC()
+static inline uint64_t CVMX_PKO_REG_INT_MASK_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050000090ull);
+}
+
+#define CVMX_PKO_REG_QUEUE_MODE CVMX_PKO_REG_QUEUE_MODE_FUNC()
+static inline uint64_t CVMX_PKO_REG_QUEUE_MODE_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050000048ull);
+}
+
+#define CVMX_PKO_REG_QUEUE_PTRS1 CVMX_PKO_REG_QUEUE_PTRS1_FUNC()
+static inline uint64_t CVMX_PKO_REG_QUEUE_PTRS1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050000100ull);
+}
+
+#define CVMX_PKO_REG_READ_IDX CVMX_PKO_REG_READ_IDX_FUNC()
+static inline uint64_t CVMX_PKO_REG_READ_IDX_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180050000008ull);
+}
+
+#define CVMX_POW_BIST_STAT CVMX_POW_BIST_STAT_FUNC()
+static inline uint64_t CVMX_POW_BIST_STAT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00016700000003F8ull);
+}
+
+#define CVMX_POW_DS_PC CVMX_POW_DS_PC_FUNC()
+static inline uint64_t CVMX_POW_DS_PC_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001670000000398ull);
+}
+
+#define CVMX_POW_ECC_ERR CVMX_POW_ECC_ERR_FUNC()
+static inline uint64_t CVMX_POW_ECC_ERR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001670000000218ull);
+}
+
+#define CVMX_POW_INT_CTL CVMX_POW_INT_CTL_FUNC()
+static inline uint64_t CVMX_POW_INT_CTL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001670000000220ull);
+}
+
+static inline uint64_t CVMX_POW_IQ_CNTX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001670000000340ull) + (offset & 7) * 8;
+}
+
+#define CVMX_POW_IQ_COM_CNT CVMX_POW_IQ_COM_CNT_FUNC()
+static inline uint64_t CVMX_POW_IQ_COM_CNT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001670000000388ull);
+}
+
+#define CVMX_POW_IQ_INT CVMX_POW_IQ_INT_FUNC()
+static inline uint64_t CVMX_POW_IQ_INT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001670000000238ull);
+}
+
+#define CVMX_POW_IQ_INT_EN CVMX_POW_IQ_INT_EN_FUNC()
+static inline uint64_t CVMX_POW_IQ_INT_EN_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001670000000240ull);
+}
+
+static inline uint64_t CVMX_POW_IQ_THRX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00016700000003A0ull) + (offset & 7) * 8;
+}
+
+#define CVMX_POW_NOS_CNT CVMX_POW_NOS_CNT_FUNC()
+static inline uint64_t CVMX_POW_NOS_CNT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001670000000228ull);
+}
+
+#define CVMX_POW_NW_TIM CVMX_POW_NW_TIM_FUNC()
+static inline uint64_t CVMX_POW_NW_TIM_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001670000000210ull);
+}
+
+#define CVMX_POW_PF_RST_MSK CVMX_POW_PF_RST_MSK_FUNC()
+static inline uint64_t CVMX_POW_PF_RST_MSK_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001670000000230ull);
+}
+
+static inline uint64_t CVMX_POW_PP_GRP_MSKX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001670000000000ull) + (offset & 15) * 8;
+}
+
+static inline uint64_t CVMX_POW_QOS_RNDX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x00016700000001C0ull) + (offset & 7) * 8;
+}
+
+static inline uint64_t CVMX_POW_QOS_THRX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001670000000180ull) + (offset & 7) * 8;
+}
+
+#define CVMX_POW_TS_PC CVMX_POW_TS_PC_FUNC()
+static inline uint64_t CVMX_POW_TS_PC_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001670000000390ull);
+}
+
+#define CVMX_POW_WA_COM_PC CVMX_POW_WA_COM_PC_FUNC()
+static inline uint64_t CVMX_POW_WA_COM_PC_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001670000000380ull);
+}
+
+static inline uint64_t CVMX_POW_WA_PCX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001670000000300ull) + (offset & 7) * 8;
+}
+
+#define CVMX_POW_WQ_INT CVMX_POW_WQ_INT_FUNC()
+static inline uint64_t CVMX_POW_WQ_INT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001670000000200ull);
+}
+
+static inline uint64_t CVMX_POW_WQ_INT_CNTX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001670000000100ull) + (offset & 15) * 8;
+}
+
+#define CVMX_POW_WQ_INT_PC CVMX_POW_WQ_INT_PC_FUNC()
+static inline uint64_t CVMX_POW_WQ_INT_PC_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001670000000208ull);
+}
+
+static inline uint64_t CVMX_POW_WQ_INT_THRX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001670000000080ull) + (offset & 15) * 8;
+}
+
+static inline uint64_t CVMX_POW_WS_PCX(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001670000000280ull) + (offset & 15) * 8;
+}
+
+#define CVMX_RAD_MEM_DEBUG0 CVMX_RAD_MEM_DEBUG0_FUNC()
+static inline uint64_t CVMX_RAD_MEM_DEBUG0_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180070001000ull);
+}
+
+#define CVMX_RAD_MEM_DEBUG1 CVMX_RAD_MEM_DEBUG1_FUNC()
+static inline uint64_t CVMX_RAD_MEM_DEBUG1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180070001008ull);
+}
+
+#define CVMX_RAD_MEM_DEBUG2 CVMX_RAD_MEM_DEBUG2_FUNC()
+static inline uint64_t CVMX_RAD_MEM_DEBUG2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180070001010ull);
+}
+
+#define CVMX_RAD_REG_BIST_RESULT CVMX_RAD_REG_BIST_RESULT_FUNC()
+static inline uint64_t CVMX_RAD_REG_BIST_RESULT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180070000080ull);
+}
+
+#define CVMX_RAD_REG_CMD_BUF CVMX_RAD_REG_CMD_BUF_FUNC()
+static inline uint64_t CVMX_RAD_REG_CMD_BUF_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180070000008ull);
+}
+
+#define CVMX_RAD_REG_CTL CVMX_RAD_REG_CTL_FUNC()
+static inline uint64_t CVMX_RAD_REG_CTL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180070000000ull);
+}
+
+#define CVMX_RAD_REG_DEBUG0 CVMX_RAD_REG_DEBUG0_FUNC()
+static inline uint64_t CVMX_RAD_REG_DEBUG0_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180070000100ull);
+}
+
+#define CVMX_RAD_REG_DEBUG1 CVMX_RAD_REG_DEBUG1_FUNC()
+static inline uint64_t CVMX_RAD_REG_DEBUG1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180070000108ull);
+}
+
+#define CVMX_RAD_REG_DEBUG10 CVMX_RAD_REG_DEBUG10_FUNC()
+static inline uint64_t CVMX_RAD_REG_DEBUG10_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180070000150ull);
+}
+
+#define CVMX_RAD_REG_DEBUG11 CVMX_RAD_REG_DEBUG11_FUNC()
+static inline uint64_t CVMX_RAD_REG_DEBUG11_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180070000158ull);
+}
+
+#define CVMX_RAD_REG_DEBUG12 CVMX_RAD_REG_DEBUG12_FUNC()
+static inline uint64_t CVMX_RAD_REG_DEBUG12_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180070000160ull);
+}
+
+#define CVMX_RAD_REG_DEBUG2 CVMX_RAD_REG_DEBUG2_FUNC()
+static inline uint64_t CVMX_RAD_REG_DEBUG2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180070000110ull);
+}
+
+#define CVMX_RAD_REG_DEBUG3 CVMX_RAD_REG_DEBUG3_FUNC()
+static inline uint64_t CVMX_RAD_REG_DEBUG3_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180070000118ull);
+}
+
+#define CVMX_RAD_REG_DEBUG4 CVMX_RAD_REG_DEBUG4_FUNC()
+static inline uint64_t CVMX_RAD_REG_DEBUG4_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180070000120ull);
+}
+
+#define CVMX_RAD_REG_DEBUG5 CVMX_RAD_REG_DEBUG5_FUNC()
+static inline uint64_t CVMX_RAD_REG_DEBUG5_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180070000128ull);
+}
+
+#define CVMX_RAD_REG_DEBUG6 CVMX_RAD_REG_DEBUG6_FUNC()
+static inline uint64_t CVMX_RAD_REG_DEBUG6_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180070000130ull);
+}
+
+#define CVMX_RAD_REG_DEBUG7 CVMX_RAD_REG_DEBUG7_FUNC()
+static inline uint64_t CVMX_RAD_REG_DEBUG7_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180070000138ull);
+}
+
+#define CVMX_RAD_REG_DEBUG8 CVMX_RAD_REG_DEBUG8_FUNC()
+static inline uint64_t CVMX_RAD_REG_DEBUG8_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180070000140ull);
+}
+
+#define CVMX_RAD_REG_DEBUG9 CVMX_RAD_REG_DEBUG9_FUNC()
+static inline uint64_t CVMX_RAD_REG_DEBUG9_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180070000148ull);
+}
+
+#define CVMX_RAD_REG_ERROR CVMX_RAD_REG_ERROR_FUNC()
+static inline uint64_t CVMX_RAD_REG_ERROR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180070000088ull);
+}
+
+#define CVMX_RAD_REG_INT_MASK CVMX_RAD_REG_INT_MASK_FUNC()
+static inline uint64_t CVMX_RAD_REG_INT_MASK_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180070000090ull);
+}
+
+#define CVMX_RAD_REG_POLYNOMIAL CVMX_RAD_REG_POLYNOMIAL_FUNC()
+static inline uint64_t CVMX_RAD_REG_POLYNOMIAL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180070000010ull);
+}
+
+#define CVMX_RAD_REG_READ_IDX CVMX_RAD_REG_READ_IDX_FUNC()
+static inline uint64_t CVMX_RAD_REG_READ_IDX_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180070000018ull);
+}
+
+#define CVMX_RNM_BIST_STATUS CVMX_RNM_BIST_STATUS_FUNC()
+static inline uint64_t CVMX_RNM_BIST_STATUS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180040000008ull);
+}
+
+#define CVMX_RNM_CTL_STATUS CVMX_RNM_CTL_STATUS_FUNC()
+static inline uint64_t CVMX_RNM_CTL_STATUS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180040000000ull);
+}
+
+static inline uint64_t CVMX_SMIX_CLK(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001818ull) + (offset & 1) * 256;
+}
+
+static inline uint64_t CVMX_SMIX_CMD(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001800ull) + (offset & 1) * 256;
+}
+
+static inline uint64_t CVMX_SMIX_EN(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001820ull) + (offset & 1) * 256;
+}
+
+static inline uint64_t CVMX_SMIX_RD_DAT(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001810ull) + (offset & 1) * 256;
+}
+
+static inline uint64_t CVMX_SMIX_WR_DAT(unsigned long offset)
+{
+	return CVMX_ADD_IO_SEG(0x0001180000001808ull) + (offset & 1) * 256;
+}
+
+#define CVMX_SPX0_PLL_BW_CTL CVMX_SPX0_PLL_BW_CTL_FUNC()
+static inline uint64_t CVMX_SPX0_PLL_BW_CTL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000388ull);
+}
+
+#define CVMX_SPX0_PLL_SETTING CVMX_SPX0_PLL_SETTING_FUNC()
+static inline uint64_t CVMX_SPX0_PLL_SETTING_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000380ull);
+}
+
+static inline uint64_t CVMX_SPXX_BCKPRS_CNT(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000340ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_SPXX_BIST_STAT(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800900007F8ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_SPXX_CLK_CTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000348ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_SPXX_CLK_STAT(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000350ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_SPXX_DBG_DESKEW_CTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000368ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_SPXX_DBG_DESKEW_STATE(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000370ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_SPXX_DRV_CTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000358ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_SPXX_ERR_CTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000320ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_SPXX_INT_DAT(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000318ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_SPXX_INT_MSK(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000308ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_SPXX_INT_REG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000300ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_SPXX_INT_SYNC(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000310ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_SPXX_TPA_ACC(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000338ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_SPXX_TPA_MAX(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000330ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_SPXX_TPA_SEL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000328ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_SPXX_TRN4_CTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000360ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_SRXX_COM_CTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000200ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_SRXX_IGN_RX_FULL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000218ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_SRXX_SPI4_CALX(unsigned long offset,
+					   unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000000ull) + ((offset & 31) +
+							 (block_id & 1) *
+							 0x1000000ull) * 8;
+}
+
+static inline uint64_t CVMX_SRXX_SPI4_STAT(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000208ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_SRXX_SW_TICK_CTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000220ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_SRXX_SW_TICK_DAT(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000228ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_STXX_ARB_CTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000608ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_STXX_BCKPRS_CNT(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000688ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_STXX_COM_CTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000600ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_STXX_DIP_CNT(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000690ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_STXX_IGN_CAL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000610ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_STXX_INT_MSK(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800900006A0ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_STXX_INT_REG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000698ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_STXX_INT_SYNC(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800900006A8ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_STXX_MIN_BST(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000618ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_STXX_SPI4_CALX(unsigned long offset,
+					   unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000400ull) + ((offset & 31) +
+							 (block_id & 1) *
+							 0x1000000ull) * 8;
+}
+
+static inline uint64_t CVMX_STXX_SPI4_DAT(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000628ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_STXX_SPI4_STAT(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000630ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_STXX_STAT_BYTES_HI(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000648ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_STXX_STAT_BYTES_LO(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000680ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_STXX_STAT_CTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000638ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+static inline uint64_t CVMX_STXX_STAT_PKT_XMT(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180090000640ull) +
+	    (block_id & 1) * 0x8000000ull;
+}
+
+#define CVMX_TIM_MEM_DEBUG0 CVMX_TIM_MEM_DEBUG0_FUNC()
+static inline uint64_t CVMX_TIM_MEM_DEBUG0_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180058001100ull);
+}
+
+#define CVMX_TIM_MEM_DEBUG1 CVMX_TIM_MEM_DEBUG1_FUNC()
+static inline uint64_t CVMX_TIM_MEM_DEBUG1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180058001108ull);
+}
+
+#define CVMX_TIM_MEM_DEBUG2 CVMX_TIM_MEM_DEBUG2_FUNC()
+static inline uint64_t CVMX_TIM_MEM_DEBUG2_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180058001110ull);
+}
+
+#define CVMX_TIM_MEM_RING0 CVMX_TIM_MEM_RING0_FUNC()
+static inline uint64_t CVMX_TIM_MEM_RING0_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180058001000ull);
+}
+
+#define CVMX_TIM_MEM_RING1 CVMX_TIM_MEM_RING1_FUNC()
+static inline uint64_t CVMX_TIM_MEM_RING1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180058001008ull);
+}
+
+#define CVMX_TIM_REG_BIST_RESULT CVMX_TIM_REG_BIST_RESULT_FUNC()
+static inline uint64_t CVMX_TIM_REG_BIST_RESULT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180058000080ull);
+}
+
+#define CVMX_TIM_REG_ERROR CVMX_TIM_REG_ERROR_FUNC()
+static inline uint64_t CVMX_TIM_REG_ERROR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180058000088ull);
+}
+
+#define CVMX_TIM_REG_FLAGS CVMX_TIM_REG_FLAGS_FUNC()
+static inline uint64_t CVMX_TIM_REG_FLAGS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180058000000ull);
+}
+
+#define CVMX_TIM_REG_INT_MASK CVMX_TIM_REG_INT_MASK_FUNC()
+static inline uint64_t CVMX_TIM_REG_INT_MASK_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180058000090ull);
+}
+
+#define CVMX_TIM_REG_READ_IDX CVMX_TIM_REG_READ_IDX_FUNC()
+static inline uint64_t CVMX_TIM_REG_READ_IDX_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180058000008ull);
+}
+
+#define CVMX_TRA_BIST_STATUS CVMX_TRA_BIST_STATUS_FUNC()
+static inline uint64_t CVMX_TRA_BIST_STATUS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A8000010ull);
+}
+
+#define CVMX_TRA_CTL CVMX_TRA_CTL_FUNC()
+static inline uint64_t CVMX_TRA_CTL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A8000000ull);
+}
+
+#define CVMX_TRA_CYCLES_SINCE CVMX_TRA_CYCLES_SINCE_FUNC()
+static inline uint64_t CVMX_TRA_CYCLES_SINCE_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A8000018ull);
+}
+
+#define CVMX_TRA_CYCLES_SINCE1 CVMX_TRA_CYCLES_SINCE1_FUNC()
+static inline uint64_t CVMX_TRA_CYCLES_SINCE1_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A8000028ull);
+}
+
+#define CVMX_TRA_FILT_ADR_ADR CVMX_TRA_FILT_ADR_ADR_FUNC()
+static inline uint64_t CVMX_TRA_FILT_ADR_ADR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A8000058ull);
+}
+
+#define CVMX_TRA_FILT_ADR_MSK CVMX_TRA_FILT_ADR_MSK_FUNC()
+static inline uint64_t CVMX_TRA_FILT_ADR_MSK_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A8000060ull);
+}
+
+#define CVMX_TRA_FILT_CMD CVMX_TRA_FILT_CMD_FUNC()
+static inline uint64_t CVMX_TRA_FILT_CMD_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A8000040ull);
+}
+
+#define CVMX_TRA_FILT_DID CVMX_TRA_FILT_DID_FUNC()
+static inline uint64_t CVMX_TRA_FILT_DID_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A8000050ull);
+}
+
+#define CVMX_TRA_FILT_SID CVMX_TRA_FILT_SID_FUNC()
+static inline uint64_t CVMX_TRA_FILT_SID_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A8000048ull);
+}
+
+#define CVMX_TRA_INT_STATUS CVMX_TRA_INT_STATUS_FUNC()
+static inline uint64_t CVMX_TRA_INT_STATUS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A8000008ull);
+}
+
+#define CVMX_TRA_READ_DAT CVMX_TRA_READ_DAT_FUNC()
+static inline uint64_t CVMX_TRA_READ_DAT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A8000020ull);
+}
+
+#define CVMX_TRA_TRIG0_ADR_ADR CVMX_TRA_TRIG0_ADR_ADR_FUNC()
+static inline uint64_t CVMX_TRA_TRIG0_ADR_ADR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A8000098ull);
+}
+
+#define CVMX_TRA_TRIG0_ADR_MSK CVMX_TRA_TRIG0_ADR_MSK_FUNC()
+static inline uint64_t CVMX_TRA_TRIG0_ADR_MSK_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A80000A0ull);
+}
+
+#define CVMX_TRA_TRIG0_CMD CVMX_TRA_TRIG0_CMD_FUNC()
+static inline uint64_t CVMX_TRA_TRIG0_CMD_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A8000080ull);
+}
+
+#define CVMX_TRA_TRIG0_DID CVMX_TRA_TRIG0_DID_FUNC()
+static inline uint64_t CVMX_TRA_TRIG0_DID_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A8000090ull);
+}
+
+#define CVMX_TRA_TRIG0_SID CVMX_TRA_TRIG0_SID_FUNC()
+static inline uint64_t CVMX_TRA_TRIG0_SID_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A8000088ull);
+}
+
+#define CVMX_TRA_TRIG1_ADR_ADR CVMX_TRA_TRIG1_ADR_ADR_FUNC()
+static inline uint64_t CVMX_TRA_TRIG1_ADR_ADR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A80000D8ull);
+}
+
+#define CVMX_TRA_TRIG1_ADR_MSK CVMX_TRA_TRIG1_ADR_MSK_FUNC()
+static inline uint64_t CVMX_TRA_TRIG1_ADR_MSK_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A80000E0ull);
+}
+
+#define CVMX_TRA_TRIG1_CMD CVMX_TRA_TRIG1_CMD_FUNC()
+static inline uint64_t CVMX_TRA_TRIG1_CMD_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A80000C0ull);
+}
+
+#define CVMX_TRA_TRIG1_DID CVMX_TRA_TRIG1_DID_FUNC()
+static inline uint64_t CVMX_TRA_TRIG1_DID_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A80000D0ull);
+}
+
+#define CVMX_TRA_TRIG1_SID CVMX_TRA_TRIG1_SID_FUNC()
+static inline uint64_t CVMX_TRA_TRIG1_SID_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800A80000C8ull);
+}
+
+static inline uint64_t CVMX_USBCX_DAINT(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000818ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_DAINTMSK(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F001000081Cull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_DCFG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000800ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_DCTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000804ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_DIEPCTLX(unsigned long offset,
+					   unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000900ull) + ((offset & 7) +
+							 (block_id & 1) *
+							 0x8000000000ull) * 32;
+}
+
+static inline uint64_t CVMX_USBCX_DIEPINTX(unsigned long offset,
+					   unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000908ull) + ((offset & 7) +
+							 (block_id & 1) *
+							 0x8000000000ull) * 32;
+}
+
+static inline uint64_t CVMX_USBCX_DIEPMSK(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000810ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_DIEPTSIZX(unsigned long offset,
+					    unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000910ull) + ((offset & 7) +
+							 (block_id & 1) *
+							 0x8000000000ull) * 32;
+}
+
+static inline uint64_t CVMX_USBCX_DOEPCTLX(unsigned long offset,
+					   unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000B00ull) + ((offset & 7) +
+							 (block_id & 1) *
+							 0x8000000000ull) * 32;
+}
+
+static inline uint64_t CVMX_USBCX_DOEPINTX(unsigned long offset,
+					   unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000B08ull) + ((offset & 7) +
+							 (block_id & 1) *
+							 0x8000000000ull) * 32;
+}
+
+static inline uint64_t CVMX_USBCX_DOEPMSK(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000814ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_DOEPTSIZX(unsigned long offset,
+					    unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000B10ull) + ((offset & 7) +
+							 (block_id & 1) *
+							 0x8000000000ull) * 32;
+}
+
+static inline uint64_t CVMX_USBCX_DPTXFSIZX(unsigned long offset,
+					    unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000100ull) + ((offset & 7) +
+							 (block_id & 1) *
+							 0x40000000000ull) * 4;
+}
+
+static inline uint64_t CVMX_USBCX_DSTS(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000808ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_DTKNQR1(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000820ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_DTKNQR2(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000824ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_DTKNQR3(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000830ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_DTKNQR4(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000834ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_GAHBCFG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000008ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_GHWCFG1(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000044ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_GHWCFG2(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000048ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_GHWCFG3(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F001000004Cull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_GHWCFG4(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000050ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_GINTMSK(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000018ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_GINTSTS(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000014ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_GNPTXFSIZ(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000028ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_GNPTXSTS(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F001000002Cull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_GOTGCTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000000ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_GOTGINT(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000004ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_GRSTCTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000010ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_GRXFSIZ(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000024ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_GRXSTSPD(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010040020ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_GRXSTSPH(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000020ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_GRXSTSRD(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F001004001Cull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_GRXSTSRH(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F001000001Cull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_GSNPSID(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000040ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_GUSBCFG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F001000000Cull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_HAINT(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000414ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_HAINTMSK(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000418ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_HCCHARX(unsigned long offset,
+					  unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000500ull) + ((offset & 7) +
+							 (block_id & 1) *
+							 0x8000000000ull) * 32;
+}
+
+static inline uint64_t CVMX_USBCX_HCFG(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000400ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_HCINTMSKX(unsigned long offset,
+					    unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F001000050Cull) + ((offset & 7) +
+							 (block_id & 1) *
+							 0x8000000000ull) * 32;
+}
+
+static inline uint64_t CVMX_USBCX_HCINTX(unsigned long offset,
+					 unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000508ull) + ((offset & 7) +
+							 (block_id & 1) *
+							 0x8000000000ull) * 32;
+}
+
+static inline uint64_t CVMX_USBCX_HCSPLTX(unsigned long offset,
+					  unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000504ull) + ((offset & 7) +
+							 (block_id & 1) *
+							 0x8000000000ull) * 32;
+}
+
+static inline uint64_t CVMX_USBCX_HCTSIZX(unsigned long offset,
+					  unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000510ull) + ((offset & 7) +
+							 (block_id & 1) *
+							 0x8000000000ull) * 32;
+}
+
+static inline uint64_t CVMX_USBCX_HFIR(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000404ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_HFNUM(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000408ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_HPRT(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000440ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_HPTXFSIZ(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000100ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_HPTXSTS(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000410ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBCX_NPTXDFIFOX(unsigned long offset,
+					     unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010001000ull) + ((offset & 7) +
+							 (block_id & 1) *
+							 0x100000000ull) * 4096;
+}
+
+static inline uint64_t CVMX_USBCX_PCGCCTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0010000E00ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBNX_BIST_STATUS(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00011800680007F8ull) +
+	    (block_id & 1) * 0x10000000ull;
+}
+
+static inline uint64_t CVMX_USBNX_CLK_CTL(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180068000010ull) +
+	    (block_id & 1) * 0x10000000ull;
+}
+
+static inline uint64_t CVMX_USBNX_CTL_STATUS(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0000000800ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBNX_DMA0_INB_CHN0(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0000000818ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBNX_DMA0_INB_CHN1(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0000000820ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBNX_DMA0_INB_CHN2(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0000000828ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBNX_DMA0_INB_CHN3(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0000000830ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBNX_DMA0_INB_CHN4(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0000000838ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBNX_DMA0_INB_CHN5(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0000000840ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBNX_DMA0_INB_CHN6(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0000000848ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBNX_DMA0_INB_CHN7(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0000000850ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBNX_DMA0_OUTB_CHN0(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0000000858ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBNX_DMA0_OUTB_CHN1(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0000000860ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBNX_DMA0_OUTB_CHN2(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0000000868ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBNX_DMA0_OUTB_CHN3(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0000000870ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBNX_DMA0_OUTB_CHN4(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0000000878ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBNX_DMA0_OUTB_CHN5(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0000000880ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBNX_DMA0_OUTB_CHN6(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0000000888ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBNX_DMA0_OUTB_CHN7(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0000000890ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBNX_DMA_TEST(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x00016F0000000808ull) +
+	    (block_id & 1) * 0x100000000000ull;
+}
+
+static inline uint64_t CVMX_USBNX_INT_ENB(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180068000008ull) +
+	    (block_id & 1) * 0x10000000ull;
+}
+
+static inline uint64_t CVMX_USBNX_INT_SUM(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180068000000ull) +
+	    (block_id & 1) * 0x10000000ull;
+}
+
+static inline uint64_t CVMX_USBNX_USBP_CTL_STATUS(unsigned long block_id)
+{
+	return CVMX_ADD_IO_SEG(0x0001180068000018ull) +
+	    (block_id & 1) * 0x10000000ull;
+}
+
+#define CVMX_ZIP_CMD_BIST_RESULT CVMX_ZIP_CMD_BIST_RESULT_FUNC()
+static inline uint64_t CVMX_ZIP_CMD_BIST_RESULT_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180038000080ull);
+}
+
+#define CVMX_ZIP_CMD_BUF CVMX_ZIP_CMD_BUF_FUNC()
+static inline uint64_t CVMX_ZIP_CMD_BUF_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180038000008ull);
+}
+
+#define CVMX_ZIP_CMD_CTL CVMX_ZIP_CMD_CTL_FUNC()
+static inline uint64_t CVMX_ZIP_CMD_CTL_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180038000000ull);
+}
+
+#define CVMX_ZIP_CONSTANTS CVMX_ZIP_CONSTANTS_FUNC()
+static inline uint64_t CVMX_ZIP_CONSTANTS_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x00011800380000A0ull);
+}
+
+#define CVMX_ZIP_DEBUG0 CVMX_ZIP_DEBUG0_FUNC()
+static inline uint64_t CVMX_ZIP_DEBUG0_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180038000098ull);
+}
+
+#define CVMX_ZIP_ERROR CVMX_ZIP_ERROR_FUNC()
+static inline uint64_t CVMX_ZIP_ERROR_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180038000088ull);
+}
+
+#define CVMX_ZIP_INT_MASK CVMX_ZIP_INT_MASK_FUNC()
+static inline uint64_t CVMX_ZIP_INT_MASK_FUNC(void)
+{
+	return CVMX_ADD_IO_SEG(0x0001180038000090ull);
+}
+
+#endif /* __CVMX_CSR_ADDRESSES_H__ */
diff --git a/arch/mips/cavium-octeon/executive/cvmx-csr-enums.h b/arch/mips/cavium-octeon/executive/cvmx-csr-enums.h
new file mode 100644
index 0000000..387cf80
--- /dev/null
+++ b/arch/mips/cavium-octeon/executive/cvmx-csr-enums.h
@@ -0,0 +1,86 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
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
+#ifndef __CVMX_CSR_ENUMS_H__
+#define __CVMX_CSR_ENUMS_H__
+
+typedef enum {
+	CVMX_IPD_OPC_MODE_STT = 0LL,
+	CVMX_IPD_OPC_MODE_STF = 1LL,
+	CVMX_IPD_OPC_MODE_STF1_STT = 2LL,
+	CVMX_IPD_OPC_MODE_STF2_STT = 3LL
+} cvmx_ipd_mode_t;
+
+typedef enum {
+	CVMX_PIP_PORT_CFG_MODE_NONE = 0ull,
+
+	CVMX_PIP_PORT_CFG_MODE_SKIPL2 = 1ull,
+
+	CVMX_PIP_PORT_CFG_MODE_SKIPIP = 2ull
+
+} cvmx_pip_port_parse_mode_t;
+
+typedef enum {
+	CVMX_PIP_QOS_WATCH_DISABLE = 0ull,
+
+	CVMX_PIP_QOS_WATCH_PROTNH = 1ull,
+	CVMX_PIP_QOS_WATCH_TCP = 2ull,
+	CVMX_PIP_QOS_WATCH_UDP = 3ull
+} cvmx_pip_qos_watch_types;
+
+typedef enum {
+	CVMX_PIP_TAG_MODE_TUPLE = 0ull,
+	CVMX_PIP_TAG_MODE_MASK = 1ull,
+	CVMX_PIP_TAG_MODE_IP_OR_MASK = 2ull,
+	CVMX_PIP_TAG_MODE_TUPLE_XOR_MASK = 3ull
+
+} cvmx_pip_tag_mode_t;
+
+typedef enum {
+	CVMX_POW_TAG_TYPE_ORDERED = 0L,
+	CVMX_POW_TAG_TYPE_ATOMIC = 1L,
+	CVMX_POW_TAG_TYPE_NULL = 2L,
+	CVMX_POW_TAG_TYPE_NULL_NULL = 3L
+} cvmx_pow_tag_type_t;
+
+typedef enum {
+	CVMX_UART_BITS5 = 0,
+	CVMX_UART_BITS6 = 1,
+	CVMX_UART_BITS7 = 2,
+	CVMX_UART_BITS8 = 3
+} cvmx_uart_bits_t;
+
+typedef enum {
+	CVMX_UART_IID_NONE = 1,
+	CVMX_UART_IID_RX_ERROR = 6,
+	CVMX_UART_IID_RX_DATA = 4,
+	CVMX_UART_IID_RX_TIMEOUT = 12,
+	CVMX_UART_IID_TX_EMPTY = 2,
+	CVMX_UART_IID_MODEM = 0,
+	CVMX_UART_IID_BUSY = 7
+} cvmx_uart_iid_t;
+
+#endif
diff --git a/arch/mips/cavium-octeon/executive/cvmx-csr-typedefs.h b/arch/mips/cavium-octeon/executive/cvmx-csr-typedefs.h
new file mode 100644
index 0000000..6c77ef5
--- /dev/null
+++ b/arch/mips/cavium-octeon/executive/cvmx-csr-typedefs.h
@@ -0,0 +1,27517 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
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
+#ifndef __CVMX_CSR_TYPEDEFS_H__
+#define __CVMX_CSR_TYPEDEFS_H__
+
+typedef union {
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
+} cvmx_agl_gmx_bad_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_bist_s {
+		uint64_t reserved_10_63:54;
+		uint64_t status:10;
+	} s;
+	struct cvmx_agl_gmx_bist_s cn52xx;
+	struct cvmx_agl_gmx_bist_s cn52xxp1;
+	struct cvmx_agl_gmx_bist_s cn56xx;
+	struct cvmx_agl_gmx_bist_s cn56xxp1;
+} cvmx_agl_gmx_bist_t;
+
+typedef union {
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
+} cvmx_agl_gmx_drv_ctl_t;
+
+typedef union {
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
+} cvmx_agl_gmx_inf_mode_t;
+
+typedef union {
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
+} cvmx_agl_gmx_prtx_cfg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_adr_cam0_s {
+		uint64_t adr:64;
+	} s;
+	struct cvmx_agl_gmx_rxx_adr_cam0_s cn52xx;
+	struct cvmx_agl_gmx_rxx_adr_cam0_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_adr_cam0_s cn56xx;
+	struct cvmx_agl_gmx_rxx_adr_cam0_s cn56xxp1;
+} cvmx_agl_gmx_rxx_adr_cam0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_adr_cam1_s {
+		uint64_t adr:64;
+	} s;
+	struct cvmx_agl_gmx_rxx_adr_cam1_s cn52xx;
+	struct cvmx_agl_gmx_rxx_adr_cam1_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_adr_cam1_s cn56xx;
+	struct cvmx_agl_gmx_rxx_adr_cam1_s cn56xxp1;
+} cvmx_agl_gmx_rxx_adr_cam1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_adr_cam2_s {
+		uint64_t adr:64;
+	} s;
+	struct cvmx_agl_gmx_rxx_adr_cam2_s cn52xx;
+	struct cvmx_agl_gmx_rxx_adr_cam2_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_adr_cam2_s cn56xx;
+	struct cvmx_agl_gmx_rxx_adr_cam2_s cn56xxp1;
+} cvmx_agl_gmx_rxx_adr_cam2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_adr_cam3_s {
+		uint64_t adr:64;
+	} s;
+	struct cvmx_agl_gmx_rxx_adr_cam3_s cn52xx;
+	struct cvmx_agl_gmx_rxx_adr_cam3_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_adr_cam3_s cn56xx;
+	struct cvmx_agl_gmx_rxx_adr_cam3_s cn56xxp1;
+} cvmx_agl_gmx_rxx_adr_cam3_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_adr_cam4_s {
+		uint64_t adr:64;
+	} s;
+	struct cvmx_agl_gmx_rxx_adr_cam4_s cn52xx;
+	struct cvmx_agl_gmx_rxx_adr_cam4_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_adr_cam4_s cn56xx;
+	struct cvmx_agl_gmx_rxx_adr_cam4_s cn56xxp1;
+} cvmx_agl_gmx_rxx_adr_cam4_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_adr_cam5_s {
+		uint64_t adr:64;
+	} s;
+	struct cvmx_agl_gmx_rxx_adr_cam5_s cn52xx;
+	struct cvmx_agl_gmx_rxx_adr_cam5_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_adr_cam5_s cn56xx;
+	struct cvmx_agl_gmx_rxx_adr_cam5_s cn56xxp1;
+} cvmx_agl_gmx_rxx_adr_cam5_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_adr_cam_en_s {
+		uint64_t reserved_8_63:56;
+		uint64_t en:8;
+	} s;
+	struct cvmx_agl_gmx_rxx_adr_cam_en_s cn52xx;
+	struct cvmx_agl_gmx_rxx_adr_cam_en_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_adr_cam_en_s cn56xx;
+	struct cvmx_agl_gmx_rxx_adr_cam_en_s cn56xxp1;
+} cvmx_agl_gmx_rxx_adr_cam_en_t;
+
+typedef union {
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
+} cvmx_agl_gmx_rxx_adr_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_decision_s {
+		uint64_t reserved_5_63:59;
+		uint64_t cnt:5;
+	} s;
+	struct cvmx_agl_gmx_rxx_decision_s cn52xx;
+	struct cvmx_agl_gmx_rxx_decision_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_decision_s cn56xx;
+	struct cvmx_agl_gmx_rxx_decision_s cn56xxp1;
+} cvmx_agl_gmx_rxx_decision_t;
+
+typedef union {
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
+} cvmx_agl_gmx_rxx_frm_chk_t;
+
+typedef union {
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
+} cvmx_agl_gmx_rxx_frm_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_frm_max_s {
+		uint64_t reserved_16_63:48;
+		uint64_t len:16;
+	} s;
+	struct cvmx_agl_gmx_rxx_frm_max_s cn52xx;
+	struct cvmx_agl_gmx_rxx_frm_max_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_frm_max_s cn56xx;
+	struct cvmx_agl_gmx_rxx_frm_max_s cn56xxp1;
+} cvmx_agl_gmx_rxx_frm_max_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_frm_min_s {
+		uint64_t reserved_16_63:48;
+		uint64_t len:16;
+	} s;
+	struct cvmx_agl_gmx_rxx_frm_min_s cn52xx;
+	struct cvmx_agl_gmx_rxx_frm_min_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_frm_min_s cn56xx;
+	struct cvmx_agl_gmx_rxx_frm_min_s cn56xxp1;
+} cvmx_agl_gmx_rxx_frm_min_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_ifg_s {
+		uint64_t reserved_4_63:60;
+		uint64_t ifg:4;
+	} s;
+	struct cvmx_agl_gmx_rxx_ifg_s cn52xx;
+	struct cvmx_agl_gmx_rxx_ifg_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_ifg_s cn56xx;
+	struct cvmx_agl_gmx_rxx_ifg_s cn56xxp1;
+} cvmx_agl_gmx_rxx_ifg_t;
+
+typedef union {
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
+} cvmx_agl_gmx_rxx_int_en_t;
+
+typedef union {
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
+} cvmx_agl_gmx_rxx_int_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_jabber_s {
+		uint64_t reserved_16_63:48;
+		uint64_t cnt:16;
+	} s;
+	struct cvmx_agl_gmx_rxx_jabber_s cn52xx;
+	struct cvmx_agl_gmx_rxx_jabber_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_jabber_s cn56xx;
+	struct cvmx_agl_gmx_rxx_jabber_s cn56xxp1;
+} cvmx_agl_gmx_rxx_jabber_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_pause_drop_time_s {
+		uint64_t reserved_16_63:48;
+		uint64_t status:16;
+	} s;
+	struct cvmx_agl_gmx_rxx_pause_drop_time_s cn52xx;
+	struct cvmx_agl_gmx_rxx_pause_drop_time_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_pause_drop_time_s cn56xx;
+	struct cvmx_agl_gmx_rxx_pause_drop_time_s cn56xxp1;
+} cvmx_agl_gmx_rxx_pause_drop_time_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_stats_ctl_s {
+		uint64_t reserved_1_63:63;
+		uint64_t rd_clr:1;
+	} s;
+	struct cvmx_agl_gmx_rxx_stats_ctl_s cn52xx;
+	struct cvmx_agl_gmx_rxx_stats_ctl_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_stats_ctl_s cn56xx;
+	struct cvmx_agl_gmx_rxx_stats_ctl_s cn56xxp1;
+} cvmx_agl_gmx_rxx_stats_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_stats_octs_s {
+		uint64_t reserved_48_63:16;
+		uint64_t cnt:48;
+	} s;
+	struct cvmx_agl_gmx_rxx_stats_octs_s cn52xx;
+	struct cvmx_agl_gmx_rxx_stats_octs_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_stats_octs_s cn56xx;
+	struct cvmx_agl_gmx_rxx_stats_octs_s cn56xxp1;
+} cvmx_agl_gmx_rxx_stats_octs_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_stats_octs_ctl_s {
+		uint64_t reserved_48_63:16;
+		uint64_t cnt:48;
+	} s;
+	struct cvmx_agl_gmx_rxx_stats_octs_ctl_s cn52xx;
+	struct cvmx_agl_gmx_rxx_stats_octs_ctl_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_stats_octs_ctl_s cn56xx;
+	struct cvmx_agl_gmx_rxx_stats_octs_ctl_s cn56xxp1;
+} cvmx_agl_gmx_rxx_stats_octs_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_stats_octs_dmac_s {
+		uint64_t reserved_48_63:16;
+		uint64_t cnt:48;
+	} s;
+	struct cvmx_agl_gmx_rxx_stats_octs_dmac_s cn52xx;
+	struct cvmx_agl_gmx_rxx_stats_octs_dmac_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_stats_octs_dmac_s cn56xx;
+	struct cvmx_agl_gmx_rxx_stats_octs_dmac_s cn56xxp1;
+} cvmx_agl_gmx_rxx_stats_octs_dmac_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_stats_octs_drp_s {
+		uint64_t reserved_48_63:16;
+		uint64_t cnt:48;
+	} s;
+	struct cvmx_agl_gmx_rxx_stats_octs_drp_s cn52xx;
+	struct cvmx_agl_gmx_rxx_stats_octs_drp_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_stats_octs_drp_s cn56xx;
+	struct cvmx_agl_gmx_rxx_stats_octs_drp_s cn56xxp1;
+} cvmx_agl_gmx_rxx_stats_octs_drp_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_stats_pkts_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_agl_gmx_rxx_stats_pkts_s cn52xx;
+	struct cvmx_agl_gmx_rxx_stats_pkts_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_stats_pkts_s cn56xx;
+	struct cvmx_agl_gmx_rxx_stats_pkts_s cn56xxp1;
+} cvmx_agl_gmx_rxx_stats_pkts_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_stats_pkts_bad_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_agl_gmx_rxx_stats_pkts_bad_s cn52xx;
+	struct cvmx_agl_gmx_rxx_stats_pkts_bad_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_stats_pkts_bad_s cn56xx;
+	struct cvmx_agl_gmx_rxx_stats_pkts_bad_s cn56xxp1;
+} cvmx_agl_gmx_rxx_stats_pkts_bad_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_stats_pkts_ctl_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_agl_gmx_rxx_stats_pkts_ctl_s cn52xx;
+	struct cvmx_agl_gmx_rxx_stats_pkts_ctl_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_stats_pkts_ctl_s cn56xx;
+	struct cvmx_agl_gmx_rxx_stats_pkts_ctl_s cn56xxp1;
+} cvmx_agl_gmx_rxx_stats_pkts_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_stats_pkts_dmac_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_agl_gmx_rxx_stats_pkts_dmac_s cn52xx;
+	struct cvmx_agl_gmx_rxx_stats_pkts_dmac_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_stats_pkts_dmac_s cn56xx;
+	struct cvmx_agl_gmx_rxx_stats_pkts_dmac_s cn56xxp1;
+} cvmx_agl_gmx_rxx_stats_pkts_dmac_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rxx_stats_pkts_drp_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_agl_gmx_rxx_stats_pkts_drp_s cn52xx;
+	struct cvmx_agl_gmx_rxx_stats_pkts_drp_s cn52xxp1;
+	struct cvmx_agl_gmx_rxx_stats_pkts_drp_s cn56xx;
+	struct cvmx_agl_gmx_rxx_stats_pkts_drp_s cn56xxp1;
+} cvmx_agl_gmx_rxx_stats_pkts_drp_t;
+
+typedef union {
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
+} cvmx_agl_gmx_rxx_udd_skp_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rx_bp_dropx_s {
+		uint64_t reserved_6_63:58;
+		uint64_t mark:6;
+	} s;
+	struct cvmx_agl_gmx_rx_bp_dropx_s cn52xx;
+	struct cvmx_agl_gmx_rx_bp_dropx_s cn52xxp1;
+	struct cvmx_agl_gmx_rx_bp_dropx_s cn56xx;
+	struct cvmx_agl_gmx_rx_bp_dropx_s cn56xxp1;
+} cvmx_agl_gmx_rx_bp_dropx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rx_bp_offx_s {
+		uint64_t reserved_6_63:58;
+		uint64_t mark:6;
+	} s;
+	struct cvmx_agl_gmx_rx_bp_offx_s cn52xx;
+	struct cvmx_agl_gmx_rx_bp_offx_s cn52xxp1;
+	struct cvmx_agl_gmx_rx_bp_offx_s cn56xx;
+	struct cvmx_agl_gmx_rx_bp_offx_s cn56xxp1;
+} cvmx_agl_gmx_rx_bp_offx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_rx_bp_onx_s {
+		uint64_t reserved_9_63:55;
+		uint64_t mark:9;
+	} s;
+	struct cvmx_agl_gmx_rx_bp_onx_s cn52xx;
+	struct cvmx_agl_gmx_rx_bp_onx_s cn52xxp1;
+	struct cvmx_agl_gmx_rx_bp_onx_s cn56xx;
+	struct cvmx_agl_gmx_rx_bp_onx_s cn56xxp1;
+} cvmx_agl_gmx_rx_bp_onx_t;
+
+typedef union {
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
+} cvmx_agl_gmx_rx_prt_info_t;
+
+typedef union {
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
+} cvmx_agl_gmx_rx_tx_status_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_smacx_s {
+		uint64_t reserved_48_63:16;
+		uint64_t smac:48;
+	} s;
+	struct cvmx_agl_gmx_smacx_s cn52xx;
+	struct cvmx_agl_gmx_smacx_s cn52xxp1;
+	struct cvmx_agl_gmx_smacx_s cn56xx;
+	struct cvmx_agl_gmx_smacx_s cn56xxp1;
+} cvmx_agl_gmx_smacx_t;
+
+typedef union {
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
+} cvmx_agl_gmx_stat_bp_t;
+
+typedef union {
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
+} cvmx_agl_gmx_txx_append_t;
+
+typedef union {
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
+} cvmx_agl_gmx_txx_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_min_pkt_s {
+		uint64_t reserved_8_63:56;
+		uint64_t min_size:8;
+	} s;
+	struct cvmx_agl_gmx_txx_min_pkt_s cn52xx;
+	struct cvmx_agl_gmx_txx_min_pkt_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_min_pkt_s cn56xx;
+	struct cvmx_agl_gmx_txx_min_pkt_s cn56xxp1;
+} cvmx_agl_gmx_txx_min_pkt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_pause_pkt_interval_s {
+		uint64_t reserved_16_63:48;
+		uint64_t interval:16;
+	} s;
+	struct cvmx_agl_gmx_txx_pause_pkt_interval_s cn52xx;
+	struct cvmx_agl_gmx_txx_pause_pkt_interval_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_pause_pkt_interval_s cn56xx;
+	struct cvmx_agl_gmx_txx_pause_pkt_interval_s cn56xxp1;
+} cvmx_agl_gmx_txx_pause_pkt_interval_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_pause_pkt_time_s {
+		uint64_t reserved_16_63:48;
+		uint64_t time:16;
+	} s;
+	struct cvmx_agl_gmx_txx_pause_pkt_time_s cn52xx;
+	struct cvmx_agl_gmx_txx_pause_pkt_time_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_pause_pkt_time_s cn56xx;
+	struct cvmx_agl_gmx_txx_pause_pkt_time_s cn56xxp1;
+} cvmx_agl_gmx_txx_pause_pkt_time_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_pause_togo_s {
+		uint64_t reserved_16_63:48;
+		uint64_t time:16;
+	} s;
+	struct cvmx_agl_gmx_txx_pause_togo_s cn52xx;
+	struct cvmx_agl_gmx_txx_pause_togo_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_pause_togo_s cn56xx;
+	struct cvmx_agl_gmx_txx_pause_togo_s cn56xxp1;
+} cvmx_agl_gmx_txx_pause_togo_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_pause_zero_s {
+		uint64_t reserved_1_63:63;
+		uint64_t send:1;
+	} s;
+	struct cvmx_agl_gmx_txx_pause_zero_s cn52xx;
+	struct cvmx_agl_gmx_txx_pause_zero_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_pause_zero_s cn56xx;
+	struct cvmx_agl_gmx_txx_pause_zero_s cn56xxp1;
+} cvmx_agl_gmx_txx_pause_zero_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_soft_pause_s {
+		uint64_t reserved_16_63:48;
+		uint64_t time:16;
+	} s;
+	struct cvmx_agl_gmx_txx_soft_pause_s cn52xx;
+	struct cvmx_agl_gmx_txx_soft_pause_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_soft_pause_s cn56xx;
+	struct cvmx_agl_gmx_txx_soft_pause_s cn56xxp1;
+} cvmx_agl_gmx_txx_soft_pause_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_stat0_s {
+		uint64_t xsdef:32;
+		uint64_t xscol:32;
+	} s;
+	struct cvmx_agl_gmx_txx_stat0_s cn52xx;
+	struct cvmx_agl_gmx_txx_stat0_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_stat0_s cn56xx;
+	struct cvmx_agl_gmx_txx_stat0_s cn56xxp1;
+} cvmx_agl_gmx_txx_stat0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_stat1_s {
+		uint64_t scol:32;
+		uint64_t mcol:32;
+	} s;
+	struct cvmx_agl_gmx_txx_stat1_s cn52xx;
+	struct cvmx_agl_gmx_txx_stat1_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_stat1_s cn56xx;
+	struct cvmx_agl_gmx_txx_stat1_s cn56xxp1;
+} cvmx_agl_gmx_txx_stat1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_stat2_s {
+		uint64_t reserved_48_63:16;
+		uint64_t octs:48;
+	} s;
+	struct cvmx_agl_gmx_txx_stat2_s cn52xx;
+	struct cvmx_agl_gmx_txx_stat2_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_stat2_s cn56xx;
+	struct cvmx_agl_gmx_txx_stat2_s cn56xxp1;
+} cvmx_agl_gmx_txx_stat2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_stat3_s {
+		uint64_t reserved_32_63:32;
+		uint64_t pkts:32;
+	} s;
+	struct cvmx_agl_gmx_txx_stat3_s cn52xx;
+	struct cvmx_agl_gmx_txx_stat3_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_stat3_s cn56xx;
+	struct cvmx_agl_gmx_txx_stat3_s cn56xxp1;
+} cvmx_agl_gmx_txx_stat3_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_stat4_s {
+		uint64_t hist1:32;
+		uint64_t hist0:32;
+	} s;
+	struct cvmx_agl_gmx_txx_stat4_s cn52xx;
+	struct cvmx_agl_gmx_txx_stat4_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_stat4_s cn56xx;
+	struct cvmx_agl_gmx_txx_stat4_s cn56xxp1;
+} cvmx_agl_gmx_txx_stat4_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_stat5_s {
+		uint64_t hist3:32;
+		uint64_t hist2:32;
+	} s;
+	struct cvmx_agl_gmx_txx_stat5_s cn52xx;
+	struct cvmx_agl_gmx_txx_stat5_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_stat5_s cn56xx;
+	struct cvmx_agl_gmx_txx_stat5_s cn56xxp1;
+} cvmx_agl_gmx_txx_stat5_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_stat6_s {
+		uint64_t hist5:32;
+		uint64_t hist4:32;
+	} s;
+	struct cvmx_agl_gmx_txx_stat6_s cn52xx;
+	struct cvmx_agl_gmx_txx_stat6_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_stat6_s cn56xx;
+	struct cvmx_agl_gmx_txx_stat6_s cn56xxp1;
+} cvmx_agl_gmx_txx_stat6_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_stat7_s {
+		uint64_t hist7:32;
+		uint64_t hist6:32;
+	} s;
+	struct cvmx_agl_gmx_txx_stat7_s cn52xx;
+	struct cvmx_agl_gmx_txx_stat7_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_stat7_s cn56xx;
+	struct cvmx_agl_gmx_txx_stat7_s cn56xxp1;
+} cvmx_agl_gmx_txx_stat7_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_stat8_s {
+		uint64_t mcst:32;
+		uint64_t bcst:32;
+	} s;
+	struct cvmx_agl_gmx_txx_stat8_s cn52xx;
+	struct cvmx_agl_gmx_txx_stat8_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_stat8_s cn56xx;
+	struct cvmx_agl_gmx_txx_stat8_s cn56xxp1;
+} cvmx_agl_gmx_txx_stat8_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_stat9_s {
+		uint64_t undflw:32;
+		uint64_t ctl:32;
+	} s;
+	struct cvmx_agl_gmx_txx_stat9_s cn52xx;
+	struct cvmx_agl_gmx_txx_stat9_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_stat9_s cn56xx;
+	struct cvmx_agl_gmx_txx_stat9_s cn56xxp1;
+} cvmx_agl_gmx_txx_stat9_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_stats_ctl_s {
+		uint64_t reserved_1_63:63;
+		uint64_t rd_clr:1;
+	} s;
+	struct cvmx_agl_gmx_txx_stats_ctl_s cn52xx;
+	struct cvmx_agl_gmx_txx_stats_ctl_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_stats_ctl_s cn56xx;
+	struct cvmx_agl_gmx_txx_stats_ctl_s cn56xxp1;
+} cvmx_agl_gmx_txx_stats_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_txx_thresh_s {
+		uint64_t reserved_6_63:58;
+		uint64_t cnt:6;
+	} s;
+	struct cvmx_agl_gmx_txx_thresh_s cn52xx;
+	struct cvmx_agl_gmx_txx_thresh_s cn52xxp1;
+	struct cvmx_agl_gmx_txx_thresh_s cn56xx;
+	struct cvmx_agl_gmx_txx_thresh_s cn56xxp1;
+} cvmx_agl_gmx_txx_thresh_t;
+
+typedef union {
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
+} cvmx_agl_gmx_tx_bp_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_tx_col_attempt_s {
+		uint64_t reserved_5_63:59;
+		uint64_t limit:5;
+	} s;
+	struct cvmx_agl_gmx_tx_col_attempt_s cn52xx;
+	struct cvmx_agl_gmx_tx_col_attempt_s cn52xxp1;
+	struct cvmx_agl_gmx_tx_col_attempt_s cn56xx;
+	struct cvmx_agl_gmx_tx_col_attempt_s cn56xxp1;
+} cvmx_agl_gmx_tx_col_attempt_t;
+
+typedef union {
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
+} cvmx_agl_gmx_tx_ifg_t;
+
+typedef union {
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
+} cvmx_agl_gmx_tx_int_en_t;
+
+typedef union {
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
+} cvmx_agl_gmx_tx_int_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_tx_jam_s {
+		uint64_t reserved_8_63:56;
+		uint64_t jam:8;
+	} s;
+	struct cvmx_agl_gmx_tx_jam_s cn52xx;
+	struct cvmx_agl_gmx_tx_jam_s cn52xxp1;
+	struct cvmx_agl_gmx_tx_jam_s cn56xx;
+	struct cvmx_agl_gmx_tx_jam_s cn56xxp1;
+} cvmx_agl_gmx_tx_jam_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_tx_lfsr_s {
+		uint64_t reserved_16_63:48;
+		uint64_t lfsr:16;
+	} s;
+	struct cvmx_agl_gmx_tx_lfsr_s cn52xx;
+	struct cvmx_agl_gmx_tx_lfsr_s cn52xxp1;
+	struct cvmx_agl_gmx_tx_lfsr_s cn56xx;
+	struct cvmx_agl_gmx_tx_lfsr_s cn56xxp1;
+} cvmx_agl_gmx_tx_lfsr_t;
+
+typedef union {
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
+} cvmx_agl_gmx_tx_ovr_bp_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_tx_pause_pkt_dmac_s {
+		uint64_t reserved_48_63:16;
+		uint64_t dmac:48;
+	} s;
+	struct cvmx_agl_gmx_tx_pause_pkt_dmac_s cn52xx;
+	struct cvmx_agl_gmx_tx_pause_pkt_dmac_s cn52xxp1;
+	struct cvmx_agl_gmx_tx_pause_pkt_dmac_s cn56xx;
+	struct cvmx_agl_gmx_tx_pause_pkt_dmac_s cn56xxp1;
+} cvmx_agl_gmx_tx_pause_pkt_dmac_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_agl_gmx_tx_pause_pkt_type_s {
+		uint64_t reserved_16_63:48;
+		uint64_t type:16;
+	} s;
+	struct cvmx_agl_gmx_tx_pause_pkt_type_s cn52xx;
+	struct cvmx_agl_gmx_tx_pause_pkt_type_s cn52xxp1;
+	struct cvmx_agl_gmx_tx_pause_pkt_type_s cn56xx;
+	struct cvmx_agl_gmx_tx_pause_pkt_type_s cn56xxp1;
+} cvmx_agl_gmx_tx_pause_pkt_type_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_asxx_gmii_rx_clk_set_s {
+		uint64_t reserved_5_63:59;
+		uint64_t setting:5;
+	} s;
+	struct cvmx_asxx_gmii_rx_clk_set_s cn30xx;
+	struct cvmx_asxx_gmii_rx_clk_set_s cn31xx;
+	struct cvmx_asxx_gmii_rx_clk_set_s cn50xx;
+} cvmx_asxx_gmii_rx_clk_set_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_asxx_gmii_rx_dat_set_s {
+		uint64_t reserved_5_63:59;
+		uint64_t setting:5;
+	} s;
+	struct cvmx_asxx_gmii_rx_dat_set_s cn30xx;
+	struct cvmx_asxx_gmii_rx_dat_set_s cn31xx;
+	struct cvmx_asxx_gmii_rx_dat_set_s cn50xx;
+} cvmx_asxx_gmii_rx_dat_set_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_asxx_int_en_s {
+		uint64_t reserved_12_63:52;
+		uint64_t txpsh:4;
+		uint64_t txpop:4;
+		uint64_t ovrflw:4;
+	} s;
+	struct cvmx_asxx_int_en_cn30xx {
+		uint64_t reserved_11_63:53;
+		uint64_t txpsh:3;
+		uint64_t reserved_7_7:1;
+		uint64_t txpop:3;
+		uint64_t reserved_3_3:1;
+		uint64_t ovrflw:3;
+	} cn30xx;
+	struct cvmx_asxx_int_en_cn30xx cn31xx;
+	struct cvmx_asxx_int_en_s cn38xx;
+	struct cvmx_asxx_int_en_s cn38xxp2;
+	struct cvmx_asxx_int_en_cn30xx cn50xx;
+	struct cvmx_asxx_int_en_s cn58xx;
+	struct cvmx_asxx_int_en_s cn58xxp1;
+} cvmx_asxx_int_en_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_asxx_int_reg_s {
+		uint64_t reserved_12_63:52;
+		uint64_t txpsh:4;
+		uint64_t txpop:4;
+		uint64_t ovrflw:4;
+	} s;
+	struct cvmx_asxx_int_reg_cn30xx {
+		uint64_t reserved_11_63:53;
+		uint64_t txpsh:3;
+		uint64_t reserved_7_7:1;
+		uint64_t txpop:3;
+		uint64_t reserved_3_3:1;
+		uint64_t ovrflw:3;
+	} cn30xx;
+	struct cvmx_asxx_int_reg_cn30xx cn31xx;
+	struct cvmx_asxx_int_reg_s cn38xx;
+	struct cvmx_asxx_int_reg_s cn38xxp2;
+	struct cvmx_asxx_int_reg_cn30xx cn50xx;
+	struct cvmx_asxx_int_reg_s cn58xx;
+	struct cvmx_asxx_int_reg_s cn58xxp1;
+} cvmx_asxx_int_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_asxx_mii_rx_dat_set_s {
+		uint64_t reserved_5_63:59;
+		uint64_t setting:5;
+	} s;
+	struct cvmx_asxx_mii_rx_dat_set_s cn30xx;
+	struct cvmx_asxx_mii_rx_dat_set_s cn50xx;
+} cvmx_asxx_mii_rx_dat_set_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_asxx_prt_loop_s {
+		uint64_t reserved_8_63:56;
+		uint64_t ext_loop:4;
+		uint64_t int_loop:4;
+	} s;
+	struct cvmx_asxx_prt_loop_cn30xx {
+		uint64_t reserved_7_63:57;
+		uint64_t ext_loop:3;
+		uint64_t reserved_3_3:1;
+		uint64_t int_loop:3;
+	} cn30xx;
+	struct cvmx_asxx_prt_loop_cn30xx cn31xx;
+	struct cvmx_asxx_prt_loop_s cn38xx;
+	struct cvmx_asxx_prt_loop_s cn38xxp2;
+	struct cvmx_asxx_prt_loop_cn30xx cn50xx;
+	struct cvmx_asxx_prt_loop_s cn58xx;
+	struct cvmx_asxx_prt_loop_s cn58xxp1;
+} cvmx_asxx_prt_loop_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_asxx_rld_bypass_s {
+		uint64_t reserved_1_63:63;
+		uint64_t bypass:1;
+	} s;
+	struct cvmx_asxx_rld_bypass_s cn38xx;
+	struct cvmx_asxx_rld_bypass_s cn38xxp2;
+	struct cvmx_asxx_rld_bypass_s cn58xx;
+	struct cvmx_asxx_rld_bypass_s cn58xxp1;
+} cvmx_asxx_rld_bypass_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_asxx_rld_bypass_setting_s {
+		uint64_t reserved_5_63:59;
+		uint64_t setting:5;
+	} s;
+	struct cvmx_asxx_rld_bypass_setting_s cn38xx;
+	struct cvmx_asxx_rld_bypass_setting_s cn38xxp2;
+	struct cvmx_asxx_rld_bypass_setting_s cn58xx;
+	struct cvmx_asxx_rld_bypass_setting_s cn58xxp1;
+} cvmx_asxx_rld_bypass_setting_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_asxx_rld_comp_s {
+		uint64_t reserved_9_63:55;
+		uint64_t pctl:5;
+		uint64_t nctl:4;
+	} s;
+	struct cvmx_asxx_rld_comp_cn38xx {
+		uint64_t reserved_8_63:56;
+		uint64_t pctl:4;
+		uint64_t nctl:4;
+	} cn38xx;
+	struct cvmx_asxx_rld_comp_cn38xx cn38xxp2;
+	struct cvmx_asxx_rld_comp_s cn58xx;
+	struct cvmx_asxx_rld_comp_s cn58xxp1;
+} cvmx_asxx_rld_comp_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_asxx_rld_data_drv_s {
+		uint64_t reserved_8_63:56;
+		uint64_t pctl:4;
+		uint64_t nctl:4;
+	} s;
+	struct cvmx_asxx_rld_data_drv_s cn38xx;
+	struct cvmx_asxx_rld_data_drv_s cn38xxp2;
+	struct cvmx_asxx_rld_data_drv_s cn58xx;
+	struct cvmx_asxx_rld_data_drv_s cn58xxp1;
+} cvmx_asxx_rld_data_drv_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_asxx_rld_fcram_mode_s {
+		uint64_t reserved_1_63:63;
+		uint64_t mode:1;
+	} s;
+	struct cvmx_asxx_rld_fcram_mode_s cn38xx;
+	struct cvmx_asxx_rld_fcram_mode_s cn38xxp2;
+} cvmx_asxx_rld_fcram_mode_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_asxx_rld_nctl_strong_s {
+		uint64_t reserved_5_63:59;
+		uint64_t nctl:5;
+	} s;
+	struct cvmx_asxx_rld_nctl_strong_s cn38xx;
+	struct cvmx_asxx_rld_nctl_strong_s cn38xxp2;
+	struct cvmx_asxx_rld_nctl_strong_s cn58xx;
+	struct cvmx_asxx_rld_nctl_strong_s cn58xxp1;
+} cvmx_asxx_rld_nctl_strong_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_asxx_rld_nctl_weak_s {
+		uint64_t reserved_5_63:59;
+		uint64_t nctl:5;
+	} s;
+	struct cvmx_asxx_rld_nctl_weak_s cn38xx;
+	struct cvmx_asxx_rld_nctl_weak_s cn38xxp2;
+	struct cvmx_asxx_rld_nctl_weak_s cn58xx;
+	struct cvmx_asxx_rld_nctl_weak_s cn58xxp1;
+} cvmx_asxx_rld_nctl_weak_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_asxx_rld_pctl_strong_s {
+		uint64_t reserved_5_63:59;
+		uint64_t pctl:5;
+	} s;
+	struct cvmx_asxx_rld_pctl_strong_s cn38xx;
+	struct cvmx_asxx_rld_pctl_strong_s cn38xxp2;
+	struct cvmx_asxx_rld_pctl_strong_s cn58xx;
+	struct cvmx_asxx_rld_pctl_strong_s cn58xxp1;
+} cvmx_asxx_rld_pctl_strong_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_asxx_rld_pctl_weak_s {
+		uint64_t reserved_5_63:59;
+		uint64_t pctl:5;
+	} s;
+	struct cvmx_asxx_rld_pctl_weak_s cn38xx;
+	struct cvmx_asxx_rld_pctl_weak_s cn38xxp2;
+	struct cvmx_asxx_rld_pctl_weak_s cn58xx;
+	struct cvmx_asxx_rld_pctl_weak_s cn58xxp1;
+} cvmx_asxx_rld_pctl_weak_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_asxx_rld_setting_s {
+		uint64_t reserved_13_63:51;
+		uint64_t dfaset:5;
+		uint64_t dfalag:1;
+		uint64_t dfalead:1;
+		uint64_t dfalock:1;
+		uint64_t setting:5;
+	} s;
+	struct cvmx_asxx_rld_setting_cn38xx {
+		uint64_t reserved_5_63:59;
+		uint64_t setting:5;
+	} cn38xx;
+	struct cvmx_asxx_rld_setting_cn38xx cn38xxp2;
+	struct cvmx_asxx_rld_setting_s cn58xx;
+	struct cvmx_asxx_rld_setting_s cn58xxp1;
+} cvmx_asxx_rld_setting_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_asxx_rx_clk_setx_s {
+		uint64_t reserved_5_63:59;
+		uint64_t setting:5;
+	} s;
+	struct cvmx_asxx_rx_clk_setx_s cn30xx;
+	struct cvmx_asxx_rx_clk_setx_s cn31xx;
+	struct cvmx_asxx_rx_clk_setx_s cn38xx;
+	struct cvmx_asxx_rx_clk_setx_s cn38xxp2;
+	struct cvmx_asxx_rx_clk_setx_s cn50xx;
+	struct cvmx_asxx_rx_clk_setx_s cn58xx;
+	struct cvmx_asxx_rx_clk_setx_s cn58xxp1;
+} cvmx_asxx_rx_clk_setx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_asxx_rx_prt_en_s {
+		uint64_t reserved_4_63:60;
+		uint64_t prt_en:4;
+	} s;
+	struct cvmx_asxx_rx_prt_en_cn30xx {
+		uint64_t reserved_3_63:61;
+		uint64_t prt_en:3;
+	} cn30xx;
+	struct cvmx_asxx_rx_prt_en_cn30xx cn31xx;
+	struct cvmx_asxx_rx_prt_en_s cn38xx;
+	struct cvmx_asxx_rx_prt_en_s cn38xxp2;
+	struct cvmx_asxx_rx_prt_en_cn30xx cn50xx;
+	struct cvmx_asxx_rx_prt_en_s cn58xx;
+	struct cvmx_asxx_rx_prt_en_s cn58xxp1;
+} cvmx_asxx_rx_prt_en_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_asxx_rx_wol_s {
+		uint64_t reserved_2_63:62;
+		uint64_t status:1;
+		uint64_t enable:1;
+	} s;
+	struct cvmx_asxx_rx_wol_s cn38xx;
+	struct cvmx_asxx_rx_wol_s cn38xxp2;
+} cvmx_asxx_rx_wol_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_asxx_rx_wol_msk_s {
+		uint64_t msk:64;
+	} s;
+	struct cvmx_asxx_rx_wol_msk_s cn38xx;
+	struct cvmx_asxx_rx_wol_msk_s cn38xxp2;
+} cvmx_asxx_rx_wol_msk_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_asxx_rx_wol_powok_s {
+		uint64_t reserved_1_63:63;
+		uint64_t powerok:1;
+	} s;
+	struct cvmx_asxx_rx_wol_powok_s cn38xx;
+	struct cvmx_asxx_rx_wol_powok_s cn38xxp2;
+} cvmx_asxx_rx_wol_powok_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_asxx_rx_wol_sig_s {
+		uint64_t reserved_32_63:32;
+		uint64_t sig:32;
+	} s;
+	struct cvmx_asxx_rx_wol_sig_s cn38xx;
+	struct cvmx_asxx_rx_wol_sig_s cn38xxp2;
+} cvmx_asxx_rx_wol_sig_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_asxx_tx_clk_setx_s {
+		uint64_t reserved_5_63:59;
+		uint64_t setting:5;
+	} s;
+	struct cvmx_asxx_tx_clk_setx_s cn30xx;
+	struct cvmx_asxx_tx_clk_setx_s cn31xx;
+	struct cvmx_asxx_tx_clk_setx_s cn38xx;
+	struct cvmx_asxx_tx_clk_setx_s cn38xxp2;
+	struct cvmx_asxx_tx_clk_setx_s cn50xx;
+	struct cvmx_asxx_tx_clk_setx_s cn58xx;
+	struct cvmx_asxx_tx_clk_setx_s cn58xxp1;
+} cvmx_asxx_tx_clk_setx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_asxx_tx_comp_byp_s {
+		uint64_t reserved_0_63:64;
+	} s;
+	struct cvmx_asxx_tx_comp_byp_cn30xx {
+		uint64_t reserved_9_63:55;
+		uint64_t bypass:1;
+		uint64_t pctl:4;
+		uint64_t nctl:4;
+	} cn30xx;
+	struct cvmx_asxx_tx_comp_byp_cn30xx cn31xx;
+	struct cvmx_asxx_tx_comp_byp_cn38xx {
+		uint64_t reserved_8_63:56;
+		uint64_t pctl:4;
+		uint64_t nctl:4;
+	} cn38xx;
+	struct cvmx_asxx_tx_comp_byp_cn38xx cn38xxp2;
+	struct cvmx_asxx_tx_comp_byp_cn50xx {
+		uint64_t reserved_17_63:47;
+		uint64_t bypass:1;
+		uint64_t reserved_13_15:3;
+		uint64_t pctl:5;
+		uint64_t reserved_5_7:3;
+		uint64_t nctl:5;
+	} cn50xx;
+	struct cvmx_asxx_tx_comp_byp_cn58xx {
+		uint64_t reserved_13_63:51;
+		uint64_t pctl:5;
+		uint64_t reserved_5_7:3;
+		uint64_t nctl:5;
+	} cn58xx;
+	struct cvmx_asxx_tx_comp_byp_cn58xx cn58xxp1;
+} cvmx_asxx_tx_comp_byp_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_asxx_tx_hi_waterx_s {
+		uint64_t reserved_4_63:60;
+		uint64_t mark:4;
+	} s;
+	struct cvmx_asxx_tx_hi_waterx_cn30xx {
+		uint64_t reserved_3_63:61;
+		uint64_t mark:3;
+	} cn30xx;
+	struct cvmx_asxx_tx_hi_waterx_cn30xx cn31xx;
+	struct cvmx_asxx_tx_hi_waterx_s cn38xx;
+	struct cvmx_asxx_tx_hi_waterx_s cn38xxp2;
+	struct cvmx_asxx_tx_hi_waterx_cn30xx cn50xx;
+	struct cvmx_asxx_tx_hi_waterx_s cn58xx;
+	struct cvmx_asxx_tx_hi_waterx_s cn58xxp1;
+} cvmx_asxx_tx_hi_waterx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_asxx_tx_prt_en_s {
+		uint64_t reserved_4_63:60;
+		uint64_t prt_en:4;
+	} s;
+	struct cvmx_asxx_tx_prt_en_cn30xx {
+		uint64_t reserved_3_63:61;
+		uint64_t prt_en:3;
+	} cn30xx;
+	struct cvmx_asxx_tx_prt_en_cn30xx cn31xx;
+	struct cvmx_asxx_tx_prt_en_s cn38xx;
+	struct cvmx_asxx_tx_prt_en_s cn38xxp2;
+	struct cvmx_asxx_tx_prt_en_cn30xx cn50xx;
+	struct cvmx_asxx_tx_prt_en_s cn58xx;
+	struct cvmx_asxx_tx_prt_en_s cn58xxp1;
+} cvmx_asxx_tx_prt_en_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_asx0_dbg_data_drv_s {
+		uint64_t reserved_9_63:55;
+		uint64_t pctl:5;
+		uint64_t nctl:4;
+	} s;
+	struct cvmx_asx0_dbg_data_drv_cn38xx {
+		uint64_t reserved_8_63:56;
+		uint64_t pctl:4;
+		uint64_t nctl:4;
+	} cn38xx;
+	struct cvmx_asx0_dbg_data_drv_cn38xx cn38xxp2;
+	struct cvmx_asx0_dbg_data_drv_s cn58xx;
+	struct cvmx_asx0_dbg_data_drv_s cn58xxp1;
+} cvmx_asx0_dbg_data_drv_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_asx0_dbg_data_enable_s {
+		uint64_t reserved_1_63:63;
+		uint64_t en:1;
+	} s;
+	struct cvmx_asx0_dbg_data_enable_s cn38xx;
+	struct cvmx_asx0_dbg_data_enable_s cn38xxp2;
+	struct cvmx_asx0_dbg_data_enable_s cn58xx;
+	struct cvmx_asx0_dbg_data_enable_s cn58xxp1;
+} cvmx_asx0_dbg_data_enable_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_bist_s {
+		uint64_t reserved_4_63:60;
+		uint64_t bist:4;
+	} s;
+	struct cvmx_ciu_bist_s cn30xx;
+	struct cvmx_ciu_bist_s cn31xx;
+	struct cvmx_ciu_bist_s cn38xx;
+	struct cvmx_ciu_bist_s cn38xxp2;
+	struct cvmx_ciu_bist_cn50xx {
+		uint64_t reserved_2_63:62;
+		uint64_t bist:2;
+	} cn50xx;
+	struct cvmx_ciu_bist_cn52xx {
+		uint64_t reserved_3_63:61;
+		uint64_t bist:3;
+	} cn52xx;
+	struct cvmx_ciu_bist_cn52xx cn52xxp1;
+	struct cvmx_ciu_bist_s cn56xx;
+	struct cvmx_ciu_bist_s cn56xxp1;
+	struct cvmx_ciu_bist_s cn58xx;
+	struct cvmx_ciu_bist_s cn58xxp1;
+} cvmx_ciu_bist_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_dint_s {
+		uint64_t reserved_16_63:48;
+		uint64_t dint:16;
+	} s;
+	struct cvmx_ciu_dint_cn30xx {
+		uint64_t reserved_1_63:63;
+		uint64_t dint:1;
+	} cn30xx;
+	struct cvmx_ciu_dint_cn31xx {
+		uint64_t reserved_2_63:62;
+		uint64_t dint:2;
+	} cn31xx;
+	struct cvmx_ciu_dint_s cn38xx;
+	struct cvmx_ciu_dint_s cn38xxp2;
+	struct cvmx_ciu_dint_cn31xx cn50xx;
+	struct cvmx_ciu_dint_cn52xx {
+		uint64_t reserved_4_63:60;
+		uint64_t dint:4;
+	} cn52xx;
+	struct cvmx_ciu_dint_cn52xx cn52xxp1;
+	struct cvmx_ciu_dint_cn56xx {
+		uint64_t reserved_12_63:52;
+		uint64_t dint:12;
+	} cn56xx;
+	struct cvmx_ciu_dint_cn56xx cn56xxp1;
+	struct cvmx_ciu_dint_s cn58xx;
+	struct cvmx_ciu_dint_s cn58xxp1;
+} cvmx_ciu_dint_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_fuse_s {
+		uint64_t reserved_16_63:48;
+		uint64_t fuse:16;
+	} s;
+	struct cvmx_ciu_fuse_cn30xx {
+		uint64_t reserved_1_63:63;
+		uint64_t fuse:1;
+	} cn30xx;
+	struct cvmx_ciu_fuse_cn31xx {
+		uint64_t reserved_2_63:62;
+		uint64_t fuse:2;
+	} cn31xx;
+	struct cvmx_ciu_fuse_s cn38xx;
+	struct cvmx_ciu_fuse_s cn38xxp2;
+	struct cvmx_ciu_fuse_cn31xx cn50xx;
+	struct cvmx_ciu_fuse_cn52xx {
+		uint64_t reserved_4_63:60;
+		uint64_t fuse:4;
+	} cn52xx;
+	struct cvmx_ciu_fuse_cn52xx cn52xxp1;
+	struct cvmx_ciu_fuse_cn56xx {
+		uint64_t reserved_12_63:52;
+		uint64_t fuse:12;
+	} cn56xx;
+	struct cvmx_ciu_fuse_cn56xx cn56xxp1;
+	struct cvmx_ciu_fuse_s cn58xx;
+	struct cvmx_ciu_fuse_s cn58xxp1;
+} cvmx_ciu_fuse_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_gstop_s {
+		uint64_t reserved_1_63:63;
+		uint64_t gstop:1;
+	} s;
+	struct cvmx_ciu_gstop_s cn30xx;
+	struct cvmx_ciu_gstop_s cn31xx;
+	struct cvmx_ciu_gstop_s cn38xx;
+	struct cvmx_ciu_gstop_s cn38xxp2;
+	struct cvmx_ciu_gstop_s cn50xx;
+	struct cvmx_ciu_gstop_s cn52xx;
+	struct cvmx_ciu_gstop_s cn52xxp1;
+	struct cvmx_ciu_gstop_s cn56xx;
+	struct cvmx_ciu_gstop_s cn56xxp1;
+	struct cvmx_ciu_gstop_s cn58xx;
+	struct cvmx_ciu_gstop_s cn58xxp1;
+} cvmx_ciu_gstop_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_intx_en0_s {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t mpi:1;
+		uint64_t pcm:1;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} s;
+	struct cvmx_ciu_intx_en0_cn30xx {
+		uint64_t reserved_59_63:5;
+		uint64_t mpi:1;
+		uint64_t pcm:1;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t reserved_51_51:1;
+		uint64_t ipd_drp:1;
+		uint64_t reserved_49_49:1;
+		uint64_t gmx_drp:1;
+		uint64_t reserved_47_47:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn30xx;
+	struct cvmx_ciu_intx_en0_cn31xx {
+		uint64_t reserved_59_63:5;
+		uint64_t mpi:1;
+		uint64_t pcm:1;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t reserved_51_51:1;
+		uint64_t ipd_drp:1;
+		uint64_t reserved_49_49:1;
+		uint64_t gmx_drp:1;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn31xx;
+	struct cvmx_ciu_intx_en0_cn38xx {
+		uint64_t reserved_56_63:8;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn38xx;
+	struct cvmx_ciu_intx_en0_cn38xx cn38xxp2;
+	struct cvmx_ciu_intx_en0_cn30xx cn50xx;
+	struct cvmx_ciu_intx_en0_cn52xx {
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
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn52xx;
+	struct cvmx_ciu_intx_en0_cn52xx cn52xxp1;
+	struct cvmx_ciu_intx_en0_cn56xx {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t reserved_57_58:2;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn56xx;
+	struct cvmx_ciu_intx_en0_cn56xx cn56xxp1;
+	struct cvmx_ciu_intx_en0_cn38xx cn58xx;
+	struct cvmx_ciu_intx_en0_cn38xx cn58xxp1;
+} cvmx_ciu_intx_en0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_intx_en0_w1c_s {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t reserved_57_58:2;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} s;
+	struct cvmx_ciu_intx_en0_w1c_cn52xx {
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
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn52xx;
+	struct cvmx_ciu_intx_en0_w1c_s cn56xx;
+	struct cvmx_ciu_intx_en0_w1c_cn58xx {
+		uint64_t reserved_56_63:8;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn58xx;
+} cvmx_ciu_intx_en0_w1c_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_intx_en0_w1s_s {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t reserved_57_58:2;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} s;
+	struct cvmx_ciu_intx_en0_w1s_cn52xx {
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
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn52xx;
+	struct cvmx_ciu_intx_en0_w1s_s cn56xx;
+	struct cvmx_ciu_intx_en0_w1s_cn58xx {
+		uint64_t reserved_56_63:8;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn58xx;
+} cvmx_ciu_intx_en0_w1s_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_intx_en1_s {
+		uint64_t reserved_20_63:44;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t wdog:16;
+	} s;
+	struct cvmx_ciu_intx_en1_cn30xx {
+		uint64_t reserved_1_63:63;
+		uint64_t wdog:1;
+	} cn30xx;
+	struct cvmx_ciu_intx_en1_cn31xx {
+		uint64_t reserved_2_63:62;
+		uint64_t wdog:2;
+	} cn31xx;
+	struct cvmx_ciu_intx_en1_cn38xx {
+		uint64_t reserved_16_63:48;
+		uint64_t wdog:16;
+	} cn38xx;
+	struct cvmx_ciu_intx_en1_cn38xx cn38xxp2;
+	struct cvmx_ciu_intx_en1_cn31xx cn50xx;
+	struct cvmx_ciu_intx_en1_cn52xx {
+		uint64_t reserved_20_63:44;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t reserved_4_15:12;
+		uint64_t wdog:4;
+	} cn52xx;
+	struct cvmx_ciu_intx_en1_cn52xxp1 {
+		uint64_t reserved_19_63:45;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t reserved_4_15:12;
+		uint64_t wdog:4;
+	} cn52xxp1;
+	struct cvmx_ciu_intx_en1_cn56xx {
+		uint64_t reserved_12_63:52;
+		uint64_t wdog:12;
+	} cn56xx;
+	struct cvmx_ciu_intx_en1_cn56xx cn56xxp1;
+	struct cvmx_ciu_intx_en1_cn38xx cn58xx;
+	struct cvmx_ciu_intx_en1_cn38xx cn58xxp1;
+} cvmx_ciu_intx_en1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_intx_en1_w1c_s {
+		uint64_t reserved_20_63:44;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t wdog:16;
+	} s;
+	struct cvmx_ciu_intx_en1_w1c_cn52xx {
+		uint64_t reserved_20_63:44;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t reserved_4_15:12;
+		uint64_t wdog:4;
+	} cn52xx;
+	struct cvmx_ciu_intx_en1_w1c_cn56xx {
+		uint64_t reserved_12_63:52;
+		uint64_t wdog:12;
+	} cn56xx;
+	struct cvmx_ciu_intx_en1_w1c_cn58xx {
+		uint64_t reserved_16_63:48;
+		uint64_t wdog:16;
+	} cn58xx;
+} cvmx_ciu_intx_en1_w1c_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_intx_en1_w1s_s {
+		uint64_t reserved_20_63:44;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t wdog:16;
+	} s;
+	struct cvmx_ciu_intx_en1_w1s_cn52xx {
+		uint64_t reserved_20_63:44;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t reserved_4_15:12;
+		uint64_t wdog:4;
+	} cn52xx;
+	struct cvmx_ciu_intx_en1_w1s_cn56xx {
+		uint64_t reserved_12_63:52;
+		uint64_t wdog:12;
+	} cn56xx;
+	struct cvmx_ciu_intx_en1_w1s_cn58xx {
+		uint64_t reserved_16_63:48;
+		uint64_t wdog:16;
+	} cn58xx;
+} cvmx_ciu_intx_en1_w1s_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_intx_en4_0_s {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t mpi:1;
+		uint64_t pcm:1;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} s;
+	struct cvmx_ciu_intx_en4_0_cn50xx {
+		uint64_t reserved_59_63:5;
+		uint64_t mpi:1;
+		uint64_t pcm:1;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t reserved_51_51:1;
+		uint64_t ipd_drp:1;
+		uint64_t reserved_49_49:1;
+		uint64_t gmx_drp:1;
+		uint64_t reserved_47_47:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn50xx;
+	struct cvmx_ciu_intx_en4_0_cn52xx {
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
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn52xx;
+	struct cvmx_ciu_intx_en4_0_cn52xx cn52xxp1;
+	struct cvmx_ciu_intx_en4_0_cn56xx {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t reserved_57_58:2;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn56xx;
+	struct cvmx_ciu_intx_en4_0_cn56xx cn56xxp1;
+	struct cvmx_ciu_intx_en4_0_cn58xx {
+		uint64_t reserved_56_63:8;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn58xx;
+	struct cvmx_ciu_intx_en4_0_cn58xx cn58xxp1;
+} cvmx_ciu_intx_en4_0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_intx_en4_0_w1c_s {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t reserved_57_58:2;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} s;
+	struct cvmx_ciu_intx_en4_0_w1c_cn52xx {
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
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn52xx;
+	struct cvmx_ciu_intx_en4_0_w1c_s cn56xx;
+	struct cvmx_ciu_intx_en4_0_w1c_cn58xx {
+		uint64_t reserved_56_63:8;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn58xx;
+} cvmx_ciu_intx_en4_0_w1c_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_intx_en4_0_w1s_s {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t reserved_57_58:2;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} s;
+	struct cvmx_ciu_intx_en4_0_w1s_cn52xx {
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
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn52xx;
+	struct cvmx_ciu_intx_en4_0_w1s_s cn56xx;
+	struct cvmx_ciu_intx_en4_0_w1s_cn58xx {
+		uint64_t reserved_56_63:8;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn58xx;
+} cvmx_ciu_intx_en4_0_w1s_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_intx_en4_1_s {
+		uint64_t reserved_20_63:44;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t wdog:16;
+	} s;
+	struct cvmx_ciu_intx_en4_1_cn50xx {
+		uint64_t reserved_2_63:62;
+		uint64_t wdog:2;
+	} cn50xx;
+	struct cvmx_ciu_intx_en4_1_cn52xx {
+		uint64_t reserved_20_63:44;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t reserved_4_15:12;
+		uint64_t wdog:4;
+	} cn52xx;
+	struct cvmx_ciu_intx_en4_1_cn52xxp1 {
+		uint64_t reserved_19_63:45;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t reserved_4_15:12;
+		uint64_t wdog:4;
+	} cn52xxp1;
+	struct cvmx_ciu_intx_en4_1_cn56xx {
+		uint64_t reserved_12_63:52;
+		uint64_t wdog:12;
+	} cn56xx;
+	struct cvmx_ciu_intx_en4_1_cn56xx cn56xxp1;
+	struct cvmx_ciu_intx_en4_1_cn58xx {
+		uint64_t reserved_16_63:48;
+		uint64_t wdog:16;
+	} cn58xx;
+	struct cvmx_ciu_intx_en4_1_cn58xx cn58xxp1;
+} cvmx_ciu_intx_en4_1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_intx_en4_1_w1c_s {
+		uint64_t reserved_20_63:44;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t wdog:16;
+	} s;
+	struct cvmx_ciu_intx_en4_1_w1c_cn52xx {
+		uint64_t reserved_20_63:44;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t reserved_4_15:12;
+		uint64_t wdog:4;
+	} cn52xx;
+	struct cvmx_ciu_intx_en4_1_w1c_cn56xx {
+		uint64_t reserved_12_63:52;
+		uint64_t wdog:12;
+	} cn56xx;
+	struct cvmx_ciu_intx_en4_1_w1c_cn58xx {
+		uint64_t reserved_16_63:48;
+		uint64_t wdog:16;
+	} cn58xx;
+} cvmx_ciu_intx_en4_1_w1c_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_intx_en4_1_w1s_s {
+		uint64_t reserved_20_63:44;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t wdog:16;
+	} s;
+	struct cvmx_ciu_intx_en4_1_w1s_cn52xx {
+		uint64_t reserved_20_63:44;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t reserved_4_15:12;
+		uint64_t wdog:4;
+	} cn52xx;
+	struct cvmx_ciu_intx_en4_1_w1s_cn56xx {
+		uint64_t reserved_12_63:52;
+		uint64_t wdog:12;
+	} cn56xx;
+	struct cvmx_ciu_intx_en4_1_w1s_cn58xx {
+		uint64_t reserved_16_63:48;
+		uint64_t wdog:16;
+	} cn58xx;
+} cvmx_ciu_intx_en4_1_w1s_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_intx_sum0_s {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t mpi:1;
+		uint64_t pcm:1;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
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
+	struct cvmx_ciu_intx_sum0_cn30xx {
+		uint64_t reserved_59_63:5;
+		uint64_t mpi:1;
+		uint64_t pcm:1;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t reserved_51_51:1;
+		uint64_t ipd_drp:1;
+		uint64_t reserved_49_49:1;
+		uint64_t gmx_drp:1;
+		uint64_t reserved_47_47:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t wdog_sum:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn30xx;
+	struct cvmx_ciu_intx_sum0_cn31xx {
+		uint64_t reserved_59_63:5;
+		uint64_t mpi:1;
+		uint64_t pcm:1;
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
+	} cn31xx;
+	struct cvmx_ciu_intx_sum0_cn38xx {
+		uint64_t reserved_56_63:8;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
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
+	} cn38xx;
+	struct cvmx_ciu_intx_sum0_cn38xx cn38xxp2;
+	struct cvmx_ciu_intx_sum0_cn30xx cn50xx;
+	struct cvmx_ciu_intx_sum0_cn52xx {
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
+	} cn52xx;
+	struct cvmx_ciu_intx_sum0_cn52xx cn52xxp1;
+	struct cvmx_ciu_intx_sum0_cn56xx {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t reserved_57_58:2;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
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
+	} cn56xx;
+	struct cvmx_ciu_intx_sum0_cn56xx cn56xxp1;
+	struct cvmx_ciu_intx_sum0_cn38xx cn58xx;
+	struct cvmx_ciu_intx_sum0_cn38xx cn58xxp1;
+} cvmx_ciu_intx_sum0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_intx_sum4_s {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t mpi:1;
+		uint64_t pcm:1;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
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
+	struct cvmx_ciu_intx_sum4_cn50xx {
+		uint64_t reserved_59_63:5;
+		uint64_t mpi:1;
+		uint64_t pcm:1;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t reserved_51_51:1;
+		uint64_t ipd_drp:1;
+		uint64_t reserved_49_49:1;
+		uint64_t gmx_drp:1;
+		uint64_t reserved_47_47:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t wdog_sum:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn50xx;
+	struct cvmx_ciu_intx_sum4_cn52xx {
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
+	} cn52xx;
+	struct cvmx_ciu_intx_sum4_cn52xx cn52xxp1;
+	struct cvmx_ciu_intx_sum4_cn56xx {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t reserved_57_58:2;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
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
+	} cn56xx;
+	struct cvmx_ciu_intx_sum4_cn56xx cn56xxp1;
+	struct cvmx_ciu_intx_sum4_cn58xx {
+		uint64_t reserved_56_63:8;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
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
+	} cn58xx;
+	struct cvmx_ciu_intx_sum4_cn58xx cn58xxp1;
+} cvmx_ciu_intx_sum4_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_int_sum1_s {
+		uint64_t reserved_20_63:44;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t wdog:16;
+	} s;
+	struct cvmx_ciu_int_sum1_cn30xx {
+		uint64_t reserved_1_63:63;
+		uint64_t wdog:1;
+	} cn30xx;
+	struct cvmx_ciu_int_sum1_cn31xx {
+		uint64_t reserved_2_63:62;
+		uint64_t wdog:2;
+	} cn31xx;
+	struct cvmx_ciu_int_sum1_cn38xx {
+		uint64_t reserved_16_63:48;
+		uint64_t wdog:16;
+	} cn38xx;
+	struct cvmx_ciu_int_sum1_cn38xx cn38xxp2;
+	struct cvmx_ciu_int_sum1_cn31xx cn50xx;
+	struct cvmx_ciu_int_sum1_cn52xx {
+		uint64_t reserved_20_63:44;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t reserved_4_15:12;
+		uint64_t wdog:4;
+	} cn52xx;
+	struct cvmx_ciu_int_sum1_cn52xxp1 {
+		uint64_t reserved_19_63:45;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t reserved_4_15:12;
+		uint64_t wdog:4;
+	} cn52xxp1;
+	struct cvmx_ciu_int_sum1_cn56xx {
+		uint64_t reserved_12_63:52;
+		uint64_t wdog:12;
+	} cn56xx;
+	struct cvmx_ciu_int_sum1_cn56xx cn56xxp1;
+	struct cvmx_ciu_int_sum1_cn38xx cn58xx;
+	struct cvmx_ciu_int_sum1_cn38xx cn58xxp1;
+} cvmx_ciu_int_sum1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_mbox_clrx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t bits:32;
+	} s;
+	struct cvmx_ciu_mbox_clrx_s cn30xx;
+	struct cvmx_ciu_mbox_clrx_s cn31xx;
+	struct cvmx_ciu_mbox_clrx_s cn38xx;
+	struct cvmx_ciu_mbox_clrx_s cn38xxp2;
+	struct cvmx_ciu_mbox_clrx_s cn50xx;
+	struct cvmx_ciu_mbox_clrx_s cn52xx;
+	struct cvmx_ciu_mbox_clrx_s cn52xxp1;
+	struct cvmx_ciu_mbox_clrx_s cn56xx;
+	struct cvmx_ciu_mbox_clrx_s cn56xxp1;
+	struct cvmx_ciu_mbox_clrx_s cn58xx;
+	struct cvmx_ciu_mbox_clrx_s cn58xxp1;
+} cvmx_ciu_mbox_clrx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_mbox_setx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t bits:32;
+	} s;
+	struct cvmx_ciu_mbox_setx_s cn30xx;
+	struct cvmx_ciu_mbox_setx_s cn31xx;
+	struct cvmx_ciu_mbox_setx_s cn38xx;
+	struct cvmx_ciu_mbox_setx_s cn38xxp2;
+	struct cvmx_ciu_mbox_setx_s cn50xx;
+	struct cvmx_ciu_mbox_setx_s cn52xx;
+	struct cvmx_ciu_mbox_setx_s cn52xxp1;
+	struct cvmx_ciu_mbox_setx_s cn56xx;
+	struct cvmx_ciu_mbox_setx_s cn56xxp1;
+	struct cvmx_ciu_mbox_setx_s cn58xx;
+	struct cvmx_ciu_mbox_setx_s cn58xxp1;
+} cvmx_ciu_mbox_setx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_nmi_s {
+		uint64_t reserved_16_63:48;
+		uint64_t nmi:16;
+	} s;
+	struct cvmx_ciu_nmi_cn30xx {
+		uint64_t reserved_1_63:63;
+		uint64_t nmi:1;
+	} cn30xx;
+	struct cvmx_ciu_nmi_cn31xx {
+		uint64_t reserved_2_63:62;
+		uint64_t nmi:2;
+	} cn31xx;
+	struct cvmx_ciu_nmi_s cn38xx;
+	struct cvmx_ciu_nmi_s cn38xxp2;
+	struct cvmx_ciu_nmi_cn31xx cn50xx;
+	struct cvmx_ciu_nmi_cn52xx {
+		uint64_t reserved_4_63:60;
+		uint64_t nmi:4;
+	} cn52xx;
+	struct cvmx_ciu_nmi_cn52xx cn52xxp1;
+	struct cvmx_ciu_nmi_cn56xx {
+		uint64_t reserved_12_63:52;
+		uint64_t nmi:12;
+	} cn56xx;
+	struct cvmx_ciu_nmi_cn56xx cn56xxp1;
+	struct cvmx_ciu_nmi_s cn58xx;
+	struct cvmx_ciu_nmi_s cn58xxp1;
+} cvmx_ciu_nmi_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_pci_inta_s {
+		uint64_t reserved_2_63:62;
+		uint64_t intr:2;
+	} s;
+	struct cvmx_ciu_pci_inta_s cn30xx;
+	struct cvmx_ciu_pci_inta_s cn31xx;
+	struct cvmx_ciu_pci_inta_s cn38xx;
+	struct cvmx_ciu_pci_inta_s cn38xxp2;
+	struct cvmx_ciu_pci_inta_s cn50xx;
+	struct cvmx_ciu_pci_inta_s cn52xx;
+	struct cvmx_ciu_pci_inta_s cn52xxp1;
+	struct cvmx_ciu_pci_inta_s cn56xx;
+	struct cvmx_ciu_pci_inta_s cn56xxp1;
+	struct cvmx_ciu_pci_inta_s cn58xx;
+	struct cvmx_ciu_pci_inta_s cn58xxp1;
+} cvmx_ciu_pci_inta_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_pp_dbg_s {
+		uint64_t reserved_16_63:48;
+		uint64_t ppdbg:16;
+	} s;
+	struct cvmx_ciu_pp_dbg_cn30xx {
+		uint64_t reserved_1_63:63;
+		uint64_t ppdbg:1;
+	} cn30xx;
+	struct cvmx_ciu_pp_dbg_cn31xx {
+		uint64_t reserved_2_63:62;
+		uint64_t ppdbg:2;
+	} cn31xx;
+	struct cvmx_ciu_pp_dbg_s cn38xx;
+	struct cvmx_ciu_pp_dbg_s cn38xxp2;
+	struct cvmx_ciu_pp_dbg_cn31xx cn50xx;
+	struct cvmx_ciu_pp_dbg_cn52xx {
+		uint64_t reserved_4_63:60;
+		uint64_t ppdbg:4;
+	} cn52xx;
+	struct cvmx_ciu_pp_dbg_cn52xx cn52xxp1;
+	struct cvmx_ciu_pp_dbg_cn56xx {
+		uint64_t reserved_12_63:52;
+		uint64_t ppdbg:12;
+	} cn56xx;
+	struct cvmx_ciu_pp_dbg_cn56xx cn56xxp1;
+	struct cvmx_ciu_pp_dbg_s cn58xx;
+	struct cvmx_ciu_pp_dbg_s cn58xxp1;
+} cvmx_ciu_pp_dbg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_pp_pokex_s {
+		uint64_t reserved_0_63:64;
+	} s;
+	struct cvmx_ciu_pp_pokex_s cn30xx;
+	struct cvmx_ciu_pp_pokex_s cn31xx;
+	struct cvmx_ciu_pp_pokex_s cn38xx;
+	struct cvmx_ciu_pp_pokex_s cn38xxp2;
+	struct cvmx_ciu_pp_pokex_s cn50xx;
+	struct cvmx_ciu_pp_pokex_s cn52xx;
+	struct cvmx_ciu_pp_pokex_s cn52xxp1;
+	struct cvmx_ciu_pp_pokex_s cn56xx;
+	struct cvmx_ciu_pp_pokex_s cn56xxp1;
+	struct cvmx_ciu_pp_pokex_s cn58xx;
+	struct cvmx_ciu_pp_pokex_s cn58xxp1;
+} cvmx_ciu_pp_pokex_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_pp_rst_s {
+		uint64_t reserved_16_63:48;
+		uint64_t rst:15;
+		uint64_t rst0:1;
+	} s;
+	struct cvmx_ciu_pp_rst_cn30xx {
+		uint64_t reserved_1_63:63;
+		uint64_t rst0:1;
+	} cn30xx;
+	struct cvmx_ciu_pp_rst_cn31xx {
+		uint64_t reserved_2_63:62;
+		uint64_t rst:1;
+		uint64_t rst0:1;
+	} cn31xx;
+	struct cvmx_ciu_pp_rst_s cn38xx;
+	struct cvmx_ciu_pp_rst_s cn38xxp2;
+	struct cvmx_ciu_pp_rst_cn31xx cn50xx;
+	struct cvmx_ciu_pp_rst_cn52xx {
+		uint64_t reserved_4_63:60;
+		uint64_t rst:3;
+		uint64_t rst0:1;
+	} cn52xx;
+	struct cvmx_ciu_pp_rst_cn52xx cn52xxp1;
+	struct cvmx_ciu_pp_rst_cn56xx {
+		uint64_t reserved_12_63:52;
+		uint64_t rst:11;
+		uint64_t rst0:1;
+	} cn56xx;
+	struct cvmx_ciu_pp_rst_cn56xx cn56xxp1;
+	struct cvmx_ciu_pp_rst_s cn58xx;
+	struct cvmx_ciu_pp_rst_s cn58xxp1;
+} cvmx_ciu_pp_rst_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_qlm_dcok_s {
+		uint64_t reserved_4_63:60;
+		uint64_t qlm_dcok:4;
+	} s;
+	struct cvmx_ciu_qlm_dcok_cn52xx {
+		uint64_t reserved_2_63:62;
+		uint64_t qlm_dcok:2;
+	} cn52xx;
+	struct cvmx_ciu_qlm_dcok_cn52xx cn52xxp1;
+	struct cvmx_ciu_qlm_dcok_s cn56xx;
+	struct cvmx_ciu_qlm_dcok_s cn56xxp1;
+} cvmx_ciu_qlm_dcok_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_qlm_jtgc_s {
+		uint64_t reserved_11_63:53;
+		uint64_t clk_div:3;
+		uint64_t reserved_6_7:2;
+		uint64_t mux_sel:2;
+		uint64_t bypass:4;
+	} s;
+	struct cvmx_ciu_qlm_jtgc_cn52xx {
+		uint64_t reserved_11_63:53;
+		uint64_t clk_div:3;
+		uint64_t reserved_5_7:3;
+		uint64_t mux_sel:1;
+		uint64_t reserved_2_3:2;
+		uint64_t bypass:2;
+	} cn52xx;
+	struct cvmx_ciu_qlm_jtgc_cn52xx cn52xxp1;
+	struct cvmx_ciu_qlm_jtgc_s cn56xx;
+	struct cvmx_ciu_qlm_jtgc_s cn56xxp1;
+} cvmx_ciu_qlm_jtgc_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_qlm_jtgd_s {
+		uint64_t capture:1;
+		uint64_t shift:1;
+		uint64_t update:1;
+		uint64_t reserved_44_60:17;
+		uint64_t select:4;
+		uint64_t reserved_37_39:3;
+		uint64_t shft_cnt:5;
+		uint64_t shft_reg:32;
+	} s;
+	struct cvmx_ciu_qlm_jtgd_cn52xx {
+		uint64_t capture:1;
+		uint64_t shift:1;
+		uint64_t update:1;
+		uint64_t reserved_42_60:19;
+		uint64_t select:2;
+		uint64_t reserved_37_39:3;
+		uint64_t shft_cnt:5;
+		uint64_t shft_reg:32;
+	} cn52xx;
+	struct cvmx_ciu_qlm_jtgd_cn52xx cn52xxp1;
+	struct cvmx_ciu_qlm_jtgd_s cn56xx;
+	struct cvmx_ciu_qlm_jtgd_cn56xxp1 {
+		uint64_t capture:1;
+		uint64_t shift:1;
+		uint64_t update:1;
+		uint64_t reserved_37_60:24;
+		uint64_t shft_cnt:5;
+		uint64_t shft_reg:32;
+	} cn56xxp1;
+} cvmx_ciu_qlm_jtgd_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_soft_bist_s {
+		uint64_t reserved_1_63:63;
+		uint64_t soft_bist:1;
+	} s;
+	struct cvmx_ciu_soft_bist_s cn30xx;
+	struct cvmx_ciu_soft_bist_s cn31xx;
+	struct cvmx_ciu_soft_bist_s cn38xx;
+	struct cvmx_ciu_soft_bist_s cn38xxp2;
+	struct cvmx_ciu_soft_bist_s cn50xx;
+	struct cvmx_ciu_soft_bist_s cn52xx;
+	struct cvmx_ciu_soft_bist_s cn52xxp1;
+	struct cvmx_ciu_soft_bist_s cn56xx;
+	struct cvmx_ciu_soft_bist_s cn56xxp1;
+	struct cvmx_ciu_soft_bist_s cn58xx;
+	struct cvmx_ciu_soft_bist_s cn58xxp1;
+} cvmx_ciu_soft_bist_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_soft_prst_s {
+		uint64_t reserved_3_63:61;
+		uint64_t host64:1;
+		uint64_t npi:1;
+		uint64_t soft_prst:1;
+	} s;
+	struct cvmx_ciu_soft_prst_s cn30xx;
+	struct cvmx_ciu_soft_prst_s cn31xx;
+	struct cvmx_ciu_soft_prst_s cn38xx;
+	struct cvmx_ciu_soft_prst_s cn38xxp2;
+	struct cvmx_ciu_soft_prst_s cn50xx;
+	struct cvmx_ciu_soft_prst_cn52xx {
+		uint64_t reserved_1_63:63;
+		uint64_t soft_prst:1;
+	} cn52xx;
+	struct cvmx_ciu_soft_prst_cn52xx cn52xxp1;
+	struct cvmx_ciu_soft_prst_cn52xx cn56xx;
+	struct cvmx_ciu_soft_prst_cn52xx cn56xxp1;
+	struct cvmx_ciu_soft_prst_s cn58xx;
+	struct cvmx_ciu_soft_prst_s cn58xxp1;
+} cvmx_ciu_soft_prst_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_soft_prst1_s {
+		uint64_t reserved_1_63:63;
+		uint64_t soft_prst:1;
+	} s;
+	struct cvmx_ciu_soft_prst1_s cn52xx;
+	struct cvmx_ciu_soft_prst1_s cn52xxp1;
+	struct cvmx_ciu_soft_prst1_s cn56xx;
+	struct cvmx_ciu_soft_prst1_s cn56xxp1;
+} cvmx_ciu_soft_prst1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_soft_rst_s {
+		uint64_t reserved_1_63:63;
+		uint64_t soft_rst:1;
+	} s;
+	struct cvmx_ciu_soft_rst_s cn30xx;
+	struct cvmx_ciu_soft_rst_s cn31xx;
+	struct cvmx_ciu_soft_rst_s cn38xx;
+	struct cvmx_ciu_soft_rst_s cn38xxp2;
+	struct cvmx_ciu_soft_rst_s cn50xx;
+	struct cvmx_ciu_soft_rst_s cn52xx;
+	struct cvmx_ciu_soft_rst_s cn52xxp1;
+	struct cvmx_ciu_soft_rst_s cn56xx;
+	struct cvmx_ciu_soft_rst_s cn56xxp1;
+	struct cvmx_ciu_soft_rst_s cn58xx;
+	struct cvmx_ciu_soft_rst_s cn58xxp1;
+} cvmx_ciu_soft_rst_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_timx_s {
+		uint64_t reserved_37_63:27;
+		uint64_t one_shot:1;
+		uint64_t len:36;
+	} s;
+	struct cvmx_ciu_timx_s cn30xx;
+	struct cvmx_ciu_timx_s cn31xx;
+	struct cvmx_ciu_timx_s cn38xx;
+	struct cvmx_ciu_timx_s cn38xxp2;
+	struct cvmx_ciu_timx_s cn50xx;
+	struct cvmx_ciu_timx_s cn52xx;
+	struct cvmx_ciu_timx_s cn52xxp1;
+	struct cvmx_ciu_timx_s cn56xx;
+	struct cvmx_ciu_timx_s cn56xxp1;
+	struct cvmx_ciu_timx_s cn58xx;
+	struct cvmx_ciu_timx_s cn58xxp1;
+} cvmx_ciu_timx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ciu_wdogx_s {
+		uint64_t reserved_46_63:18;
+		uint64_t gstopen:1;
+		uint64_t dstop:1;
+		uint64_t cnt:24;
+		uint64_t len:16;
+		uint64_t state:2;
+		uint64_t mode:2;
+	} s;
+	struct cvmx_ciu_wdogx_s cn30xx;
+	struct cvmx_ciu_wdogx_s cn31xx;
+	struct cvmx_ciu_wdogx_s cn38xx;
+	struct cvmx_ciu_wdogx_s cn38xxp2;
+	struct cvmx_ciu_wdogx_s cn50xx;
+	struct cvmx_ciu_wdogx_s cn52xx;
+	struct cvmx_ciu_wdogx_s cn52xxp1;
+	struct cvmx_ciu_wdogx_s cn56xx;
+	struct cvmx_ciu_wdogx_s cn56xxp1;
+	struct cvmx_ciu_wdogx_s cn58xx;
+	struct cvmx_ciu_wdogx_s cn58xxp1;
+} cvmx_ciu_wdogx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dbg_data_s {
+		uint64_t reserved_23_63:41;
+		uint64_t c_mul:5;
+		uint64_t dsel_ext:1;
+		uint64_t data:17;
+	} s;
+	struct cvmx_dbg_data_cn30xx {
+		uint64_t reserved_31_63:33;
+		uint64_t pll_mul:3;
+		uint64_t reserved_23_27:5;
+		uint64_t c_mul:5;
+		uint64_t dsel_ext:1;
+		uint64_t data:17;
+	} cn30xx;
+	struct cvmx_dbg_data_cn30xx cn31xx;
+	struct cvmx_dbg_data_cn38xx {
+		uint64_t reserved_29_63:35;
+		uint64_t d_mul:4;
+		uint64_t dclk_mul2:1;
+		uint64_t cclk_div2:1;
+		uint64_t c_mul:5;
+		uint64_t dsel_ext:1;
+		uint64_t data:17;
+	} cn38xx;
+	struct cvmx_dbg_data_cn38xx cn38xxp2;
+	struct cvmx_dbg_data_cn30xx cn50xx;
+	struct cvmx_dbg_data_cn58xx {
+		uint64_t reserved_29_63:35;
+		uint64_t rem:6;
+		uint64_t c_mul:5;
+		uint64_t dsel_ext:1;
+		uint64_t data:17;
+	} cn58xx;
+	struct cvmx_dbg_data_cn58xx cn58xxp1;
+} cvmx_dbg_data_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_bst0_s {
+		uint64_t reserved_32_63:32;
+		uint64_t rdf:16;
+		uint64_t pdf:16;
+	} s;
+	struct cvmx_dfa_bst0_s cn31xx;
+	struct cvmx_dfa_bst0_s cn38xx;
+	struct cvmx_dfa_bst0_s cn38xxp2;
+	struct cvmx_dfa_bst0_cn58xx {
+		uint64_t reserved_20_63:44;
+		uint64_t rdf:4;
+		uint64_t reserved_4_15:12;
+		uint64_t pdf:4;
+	} cn58xx;
+	struct cvmx_dfa_bst0_cn58xx cn58xxp1;
+} cvmx_dfa_bst0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_bst1_s {
+		uint64_t reserved_23_63:41;
+		uint64_t crq:1;
+		uint64_t ifu:1;
+		uint64_t gfu:1;
+		uint64_t drf:1;
+		uint64_t crf:1;
+		uint64_t p0_bwb:1;
+		uint64_t p1_bwb:1;
+		uint64_t p0_brf:8;
+		uint64_t p1_brf:8;
+	} s;
+	struct cvmx_dfa_bst1_cn31xx {
+		uint64_t reserved_23_63:41;
+		uint64_t crq:1;
+		uint64_t ifu:1;
+		uint64_t gfu:1;
+		uint64_t drf:1;
+		uint64_t crf:1;
+		uint64_t reserved_0_17:18;
+	} cn31xx;
+	struct cvmx_dfa_bst1_s cn38xx;
+	struct cvmx_dfa_bst1_s cn38xxp2;
+	struct cvmx_dfa_bst1_cn58xx {
+		uint64_t reserved_23_63:41;
+		uint64_t crq:1;
+		uint64_t ifu:1;
+		uint64_t gfu:1;
+		uint64_t reserved_19_19:1;
+		uint64_t crf:1;
+		uint64_t p0_bwb:1;
+		uint64_t p1_bwb:1;
+		uint64_t p0_brf:8;
+		uint64_t p1_brf:8;
+	} cn58xx;
+	struct cvmx_dfa_bst1_cn58xx cn58xxp1;
+} cvmx_dfa_bst1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_cfg_s {
+		uint64_t reserved_4_63:60;
+		uint64_t nrpl_ena:1;
+		uint64_t nxor_ena:1;
+		uint64_t gxor_ena:1;
+		uint64_t sarb:1;
+	} s;
+	struct cvmx_dfa_cfg_s cn38xx;
+	struct cvmx_dfa_cfg_cn38xxp2 {
+		uint64_t reserved_1_63:63;
+		uint64_t sarb:1;
+	} cn38xxp2;
+	struct cvmx_dfa_cfg_s cn58xx;
+	struct cvmx_dfa_cfg_s cn58xxp1;
+} cvmx_dfa_cfg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_dbell_s {
+		uint64_t reserved_20_63:44;
+		uint64_t dbell:20;
+	} s;
+	struct cvmx_dfa_dbell_s cn31xx;
+	struct cvmx_dfa_dbell_s cn38xx;
+	struct cvmx_dfa_dbell_s cn38xxp2;
+	struct cvmx_dfa_dbell_s cn58xx;
+	struct cvmx_dfa_dbell_s cn58xxp1;
+} cvmx_dfa_dbell_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_ddr2_addr_s {
+		uint64_t reserved_9_63:55;
+		uint64_t rdimm_ena:1;
+		uint64_t num_rnks:2;
+		uint64_t rnk_lo:1;
+		uint64_t num_colrows:3;
+		uint64_t num_cols:2;
+	} s;
+	struct cvmx_dfa_ddr2_addr_s cn31xx;
+} cvmx_dfa_ddr2_addr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_ddr2_bus_s {
+		uint64_t reserved_47_63:17;
+		uint64_t bus_cnt:47;
+	} s;
+	struct cvmx_dfa_ddr2_bus_s cn31xx;
+} cvmx_dfa_ddr2_bus_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_ddr2_cfg_s {
+		uint64_t reserved_41_63:23;
+		uint64_t trfc:5;
+		uint64_t mrs_pgm:1;
+		uint64_t fpip:3;
+		uint64_t reserved_29_31:3;
+		uint64_t ref_int:13;
+		uint64_t reserved_14_15:2;
+		uint64_t tskw:2;
+		uint64_t rnk_msk:4;
+		uint64_t silo_qc:1;
+		uint64_t silo_hc:1;
+		uint64_t sil_lat:2;
+		uint64_t bprch:1;
+		uint64_t fprch:1;
+		uint64_t init:1;
+		uint64_t prtena:1;
+	} s;
+	struct cvmx_dfa_ddr2_cfg_s cn31xx;
+} cvmx_dfa_ddr2_cfg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_ddr2_comp_s {
+		uint64_t dfa__pctl:4;
+		uint64_t dfa__nctl:4;
+		uint64_t reserved_9_55:47;
+		uint64_t pctl_csr:4;
+		uint64_t nctl_csr:4;
+		uint64_t comp_bypass:1;
+	} s;
+	struct cvmx_dfa_ddr2_comp_s cn31xx;
+} cvmx_dfa_ddr2_comp_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_ddr2_emrs_s {
+		uint64_t reserved_31_63:33;
+		uint64_t emrs1_ocd:15;
+		uint64_t reserved_15_15:1;
+		uint64_t emrs1:15;
+	} s;
+	struct cvmx_dfa_ddr2_emrs_s cn31xx;
+} cvmx_dfa_ddr2_emrs_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_ddr2_fcnt_s {
+		uint64_t reserved_47_63:17;
+		uint64_t fcyc_cnt:47;
+	} s;
+	struct cvmx_dfa_ddr2_fcnt_s cn31xx;
+} cvmx_dfa_ddr2_fcnt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_ddr2_mrs_s {
+		uint64_t reserved_31_63:33;
+		uint64_t mrs:15;
+		uint64_t reserved_15_15:1;
+		uint64_t mrs_dll:15;
+	} s;
+	struct cvmx_dfa_ddr2_mrs_s cn31xx;
+} cvmx_dfa_ddr2_mrs_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_ddr2_opt_s {
+		uint64_t reserved_10_63:54;
+		uint64_t max_read_batch:5;
+		uint64_t max_write_batch:5;
+	} s;
+	struct cvmx_dfa_ddr2_opt_s cn31xx;
+} cvmx_dfa_ddr2_opt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_ddr2_pll_s {
+		uint64_t pll_setting:17;
+		uint64_t reserved_32_46:15;
+		uint64_t setting90:5;
+		uint64_t reserved_21_26:6;
+		uint64_t dll_setting:5;
+		uint64_t dll_byp:1;
+		uint64_t qdll_ena:1;
+		uint64_t bw_ctl:4;
+		uint64_t bw_upd:1;
+		uint64_t pll_div2:1;
+		uint64_t reserved_7_7:1;
+		uint64_t pll_ratio:5;
+		uint64_t pll_bypass:1;
+		uint64_t pll_init:1;
+	} s;
+	struct cvmx_dfa_ddr2_pll_s cn31xx;
+} cvmx_dfa_ddr2_pll_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_ddr2_tmg_s {
+		uint64_t reserved_47_63:17;
+		uint64_t fcnt_mode:1;
+		uint64_t cnt_clr:1;
+		uint64_t cavmipo:1;
+		uint64_t ctr_rst:1;
+		uint64_t odt_rtt:2;
+		uint64_t dqsn_ena:1;
+		uint64_t dic:1;
+		uint64_t r2r_slot:1;
+		uint64_t tfaw:5;
+		uint64_t twtr:4;
+		uint64_t twr:3;
+		uint64_t trp:4;
+		uint64_t tras:5;
+		uint64_t trrd:3;
+		uint64_t trcd:4;
+		uint64_t addlat:3;
+		uint64_t pocas:1;
+		uint64_t caslat:3;
+		uint64_t tmrd:2;
+		uint64_t ddr2t:1;
+	} s;
+	struct cvmx_dfa_ddr2_tmg_s cn31xx;
+} cvmx_dfa_ddr2_tmg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_difctl_s {
+		uint64_t reserved_20_63:44;
+		uint64_t dwbcnt:8;
+		uint64_t pool:3;
+		uint64_t size:9;
+	} s;
+	struct cvmx_dfa_difctl_s cn31xx;
+	struct cvmx_dfa_difctl_s cn38xx;
+	struct cvmx_dfa_difctl_s cn38xxp2;
+	struct cvmx_dfa_difctl_s cn58xx;
+	struct cvmx_dfa_difctl_s cn58xxp1;
+} cvmx_dfa_difctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_difrdptr_s {
+		uint64_t reserved_36_63:28;
+		uint64_t rdptr:31;
+		uint64_t reserved_0_4:5;
+	} s;
+	struct cvmx_dfa_difrdptr_s cn31xx;
+	struct cvmx_dfa_difrdptr_s cn38xx;
+	struct cvmx_dfa_difrdptr_s cn38xxp2;
+	struct cvmx_dfa_difrdptr_s cn58xx;
+	struct cvmx_dfa_difrdptr_s cn58xxp1;
+} cvmx_dfa_difrdptr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_eclkcfg_s {
+		uint64_t reserved_19_63:45;
+		uint64_t sbdnum:3;
+		uint64_t reserved_15_15:1;
+		uint64_t sbdlck:1;
+		uint64_t dcmode:1;
+		uint64_t dtmode:1;
+		uint64_t pmode:1;
+		uint64_t qmode:1;
+		uint64_t imode:1;
+		uint64_t sarb:1;
+		uint64_t reserved_3_7:5;
+		uint64_t dteclkdis:1;
+		uint64_t maxbnk:1;
+		uint64_t dfa_frstn:1;
+	} s;
+	struct cvmx_dfa_eclkcfg_s cn31xx;
+} cvmx_dfa_eclkcfg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_err_s {
+		uint64_t reserved_33_63:31;
+		uint64_t dblina:1;
+		uint64_t dblovf:1;
+		uint64_t cp2pina:1;
+		uint64_t cp2perr:1;
+		uint64_t cp2parena:1;
+		uint64_t dtepina:1;
+		uint64_t dteperr:1;
+		uint64_t dteparena:1;
+		uint64_t dtesyn:7;
+		uint64_t dtedbina:1;
+		uint64_t dtesbina:1;
+		uint64_t dtedbe:1;
+		uint64_t dtesbe:1;
+		uint64_t dteeccena:1;
+		uint64_t cp2syn:8;
+		uint64_t cp2dbina:1;
+		uint64_t cp2sbina:1;
+		uint64_t cp2dbe:1;
+		uint64_t cp2sbe:1;
+		uint64_t cp2eccena:1;
+	} s;
+	struct cvmx_dfa_err_s cn31xx;
+	struct cvmx_dfa_err_s cn38xx;
+	struct cvmx_dfa_err_s cn38xxp2;
+	struct cvmx_dfa_err_s cn58xx;
+	struct cvmx_dfa_err_s cn58xxp1;
+} cvmx_dfa_err_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_memcfg0_s {
+		uint64_t reserved_32_63:32;
+		uint64_t rldqck90_rst:1;
+		uint64_t rldck_rst:1;
+		uint64_t clkdiv:2;
+		uint64_t lpp_ena:1;
+		uint64_t bunk_init:2;
+		uint64_t init_p0:1;
+		uint64_t init_p1:1;
+		uint64_t r2r_pbunk:1;
+		uint64_t pbunk:3;
+		uint64_t blen:1;
+		uint64_t bprch:2;
+		uint64_t fprch:2;
+		uint64_t wr_dly:4;
+		uint64_t rw_dly:4;
+		uint64_t sil_lat:2;
+		uint64_t mtype:1;
+		uint64_t reserved_2_2:1;
+		uint64_t ena_p0:1;
+		uint64_t ena_p1:1;
+	} s;
+	struct cvmx_dfa_memcfg0_cn38xx {
+		uint64_t reserved_28_63:36;
+		uint64_t lpp_ena:1;
+		uint64_t bunk_init:2;
+		uint64_t init_p0:1;
+		uint64_t init_p1:1;
+		uint64_t r2r_pbunk:1;
+		uint64_t pbunk:3;
+		uint64_t blen:1;
+		uint64_t bprch:2;
+		uint64_t fprch:2;
+		uint64_t wr_dly:4;
+		uint64_t rw_dly:4;
+		uint64_t sil_lat:2;
+		uint64_t mtype:1;
+		uint64_t reserved_2_2:1;
+		uint64_t ena_p0:1;
+		uint64_t ena_p1:1;
+	} cn38xx;
+	struct cvmx_dfa_memcfg0_cn38xxp2 {
+		uint64_t reserved_27_63:37;
+		uint64_t bunk_init:2;
+		uint64_t init_p0:1;
+		uint64_t init_p1:1;
+		uint64_t r2r_pbunk:1;
+		uint64_t pbunk:3;
+		uint64_t blen:1;
+		uint64_t bprch:2;
+		uint64_t fprch:2;
+		uint64_t wr_dly:4;
+		uint64_t rw_dly:4;
+		uint64_t sil_lat:2;
+		uint64_t mtype:1;
+		uint64_t reserved_2_2:1;
+		uint64_t ena_p0:1;
+		uint64_t ena_p1:1;
+	} cn38xxp2;
+	struct cvmx_dfa_memcfg0_s cn58xx;
+	struct cvmx_dfa_memcfg0_s cn58xxp1;
+} cvmx_dfa_memcfg0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_memcfg1_s {
+		uint64_t reserved_34_63:30;
+		uint64_t ref_intlo:9;
+		uint64_t aref_ena:1;
+		uint64_t mrs_ena:1;
+		uint64_t tmrsc:3;
+		uint64_t trc:4;
+		uint64_t twl:4;
+		uint64_t trl:4;
+		uint64_t reserved_6_7:2;
+		uint64_t tskw:2;
+		uint64_t ref_int:4;
+	} s;
+	struct cvmx_dfa_memcfg1_s cn38xx;
+	struct cvmx_dfa_memcfg1_s cn38xxp2;
+	struct cvmx_dfa_memcfg1_s cn58xx;
+	struct cvmx_dfa_memcfg1_s cn58xxp1;
+} cvmx_dfa_memcfg1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_memcfg2_s {
+		uint64_t reserved_12_63:52;
+		uint64_t dteclkdis:1;
+		uint64_t silrst:1;
+		uint64_t trfc:5;
+		uint64_t refshort:1;
+		uint64_t ua_start:2;
+		uint64_t maxbnk:1;
+		uint64_t fcram2p:1;
+	} s;
+	struct cvmx_dfa_memcfg2_s cn38xx;
+	struct cvmx_dfa_memcfg2_s cn38xxp2;
+	struct cvmx_dfa_memcfg2_s cn58xx;
+	struct cvmx_dfa_memcfg2_s cn58xxp1;
+} cvmx_dfa_memcfg2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_memfadr_s {
+		uint64_t reserved_24_63:40;
+		uint64_t maddr:24;
+	} s;
+	struct cvmx_dfa_memfadr_cn31xx {
+		uint64_t reserved_40_63:24;
+		uint64_t fdst:9;
+		uint64_t fsrc:2;
+		uint64_t pnum:1;
+		uint64_t bnum:3;
+		uint64_t maddr:25;
+	} cn31xx;
+	struct cvmx_dfa_memfadr_cn38xx {
+		uint64_t reserved_39_63:25;
+		uint64_t fdst:9;
+		uint64_t fsrc:2;
+		uint64_t pnum:1;
+		uint64_t bnum:3;
+		uint64_t maddr:24;
+	} cn38xx;
+	struct cvmx_dfa_memfadr_cn38xx cn38xxp2;
+	struct cvmx_dfa_memfadr_cn38xx cn58xx;
+	struct cvmx_dfa_memfadr_cn38xx cn58xxp1;
+} cvmx_dfa_memfadr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_memfcr_s {
+		uint64_t reserved_47_63:17;
+		uint64_t emrs2:15;
+		uint64_t reserved_31_31:1;
+		uint64_t emrs:15;
+		uint64_t reserved_15_15:1;
+		uint64_t mrs:15;
+	} s;
+	struct cvmx_dfa_memfcr_s cn38xx;
+	struct cvmx_dfa_memfcr_s cn38xxp2;
+	struct cvmx_dfa_memfcr_s cn58xx;
+	struct cvmx_dfa_memfcr_s cn58xxp1;
+} cvmx_dfa_memfcr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_memrld_s {
+		uint64_t reserved_23_63:41;
+		uint64_t mrsdat:23;
+	} s;
+	struct cvmx_dfa_memrld_s cn38xx;
+	struct cvmx_dfa_memrld_s cn38xxp2;
+	struct cvmx_dfa_memrld_s cn58xx;
+	struct cvmx_dfa_memrld_s cn58xxp1;
+} cvmx_dfa_memrld_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_ncbctl_s {
+		uint64_t reserved_11_63:53;
+		uint64_t sbdnum:5;
+		uint64_t sbdlck:1;
+		uint64_t dcmode:1;
+		uint64_t dtmode:1;
+		uint64_t pmode:1;
+		uint64_t qmode:1;
+		uint64_t imode:1;
+	} s;
+	struct cvmx_dfa_ncbctl_cn38xx {
+		uint64_t reserved_10_63:54;
+		uint64_t sbdnum:4;
+		uint64_t sbdlck:1;
+		uint64_t dcmode:1;
+		uint64_t dtmode:1;
+		uint64_t pmode:1;
+		uint64_t qmode:1;
+		uint64_t imode:1;
+	} cn38xx;
+	struct cvmx_dfa_ncbctl_cn38xx cn38xxp2;
+	struct cvmx_dfa_ncbctl_s cn58xx;
+	struct cvmx_dfa_ncbctl_s cn58xxp1;
+} cvmx_dfa_ncbctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_rodt_comp_ctl_s {
+		uint64_t reserved_17_63:47;
+		uint64_t enable:1;
+		uint64_t reserved_12_15:4;
+		uint64_t nctl:4;
+		uint64_t reserved_5_7:3;
+		uint64_t pctl:5;
+	} s;
+	struct cvmx_dfa_rodt_comp_ctl_s cn58xx;
+	struct cvmx_dfa_rodt_comp_ctl_s cn58xxp1;
+} cvmx_dfa_rodt_comp_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_sbd_dbg0_s {
+		uint64_t sbd0:64;
+	} s;
+	struct cvmx_dfa_sbd_dbg0_s cn31xx;
+	struct cvmx_dfa_sbd_dbg0_s cn38xx;
+	struct cvmx_dfa_sbd_dbg0_s cn38xxp2;
+	struct cvmx_dfa_sbd_dbg0_s cn58xx;
+	struct cvmx_dfa_sbd_dbg0_s cn58xxp1;
+} cvmx_dfa_sbd_dbg0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_sbd_dbg1_s {
+		uint64_t sbd1:64;
+	} s;
+	struct cvmx_dfa_sbd_dbg1_s cn31xx;
+	struct cvmx_dfa_sbd_dbg1_s cn38xx;
+	struct cvmx_dfa_sbd_dbg1_s cn38xxp2;
+	struct cvmx_dfa_sbd_dbg1_s cn58xx;
+	struct cvmx_dfa_sbd_dbg1_s cn58xxp1;
+} cvmx_dfa_sbd_dbg1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_sbd_dbg2_s {
+		uint64_t sbd2:64;
+	} s;
+	struct cvmx_dfa_sbd_dbg2_s cn31xx;
+	struct cvmx_dfa_sbd_dbg2_s cn38xx;
+	struct cvmx_dfa_sbd_dbg2_s cn38xxp2;
+	struct cvmx_dfa_sbd_dbg2_s cn58xx;
+	struct cvmx_dfa_sbd_dbg2_s cn58xxp1;
+} cvmx_dfa_sbd_dbg2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_dfa_sbd_dbg3_s {
+		uint64_t sbd3:64;
+	} s;
+	struct cvmx_dfa_sbd_dbg3_s cn31xx;
+	struct cvmx_dfa_sbd_dbg3_s cn38xx;
+	struct cvmx_dfa_sbd_dbg3_s cn38xxp2;
+	struct cvmx_dfa_sbd_dbg3_s cn58xx;
+	struct cvmx_dfa_sbd_dbg3_s cn58xxp1;
+} cvmx_dfa_sbd_dbg3_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_fpa_bist_status_s {
+		uint64_t reserved_5_63:59;
+		uint64_t frd:1;
+		uint64_t fpf0:1;
+		uint64_t fpf1:1;
+		uint64_t ffr:1;
+		uint64_t fdr:1;
+	} s;
+	struct cvmx_fpa_bist_status_s cn30xx;
+	struct cvmx_fpa_bist_status_s cn31xx;
+	struct cvmx_fpa_bist_status_s cn38xx;
+	struct cvmx_fpa_bist_status_s cn38xxp2;
+	struct cvmx_fpa_bist_status_s cn50xx;
+	struct cvmx_fpa_bist_status_s cn52xx;
+	struct cvmx_fpa_bist_status_s cn52xxp1;
+	struct cvmx_fpa_bist_status_s cn56xx;
+	struct cvmx_fpa_bist_status_s cn56xxp1;
+	struct cvmx_fpa_bist_status_s cn58xx;
+	struct cvmx_fpa_bist_status_s cn58xxp1;
+} cvmx_fpa_bist_status_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_fpa_ctl_status_s {
+		uint64_t reserved_18_63:46;
+		uint64_t reset:1;
+		uint64_t use_ldt:1;
+		uint64_t use_stt:1;
+		uint64_t enb:1;
+		uint64_t mem1_err:7;
+		uint64_t mem0_err:7;
+	} s;
+	struct cvmx_fpa_ctl_status_s cn30xx;
+	struct cvmx_fpa_ctl_status_s cn31xx;
+	struct cvmx_fpa_ctl_status_s cn38xx;
+	struct cvmx_fpa_ctl_status_s cn38xxp2;
+	struct cvmx_fpa_ctl_status_s cn50xx;
+	struct cvmx_fpa_ctl_status_s cn52xx;
+	struct cvmx_fpa_ctl_status_s cn52xxp1;
+	struct cvmx_fpa_ctl_status_s cn56xx;
+	struct cvmx_fpa_ctl_status_s cn56xxp1;
+	struct cvmx_fpa_ctl_status_s cn58xx;
+	struct cvmx_fpa_ctl_status_s cn58xxp1;
+} cvmx_fpa_ctl_status_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_fpa_fpfx_marks_s {
+		uint64_t reserved_22_63:42;
+		uint64_t fpf_wr:11;
+		uint64_t fpf_rd:11;
+	} s;
+	struct cvmx_fpa_fpfx_marks_s cn38xx;
+	struct cvmx_fpa_fpfx_marks_s cn38xxp2;
+	struct cvmx_fpa_fpfx_marks_s cn56xx;
+	struct cvmx_fpa_fpfx_marks_s cn56xxp1;
+	struct cvmx_fpa_fpfx_marks_s cn58xx;
+	struct cvmx_fpa_fpfx_marks_s cn58xxp1;
+} cvmx_fpa_fpfx_marks_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_fpa_fpfx_size_s {
+		uint64_t reserved_11_63:53;
+		uint64_t fpf_siz:11;
+	} s;
+	struct cvmx_fpa_fpfx_size_s cn38xx;
+	struct cvmx_fpa_fpfx_size_s cn38xxp2;
+	struct cvmx_fpa_fpfx_size_s cn56xx;
+	struct cvmx_fpa_fpfx_size_s cn56xxp1;
+	struct cvmx_fpa_fpfx_size_s cn58xx;
+	struct cvmx_fpa_fpfx_size_s cn58xxp1;
+} cvmx_fpa_fpfx_size_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_fpa_fpf0_marks_s {
+		uint64_t reserved_24_63:40;
+		uint64_t fpf_wr:12;
+		uint64_t fpf_rd:12;
+	} s;
+	struct cvmx_fpa_fpf0_marks_s cn38xx;
+	struct cvmx_fpa_fpf0_marks_s cn38xxp2;
+	struct cvmx_fpa_fpf0_marks_s cn56xx;
+	struct cvmx_fpa_fpf0_marks_s cn56xxp1;
+	struct cvmx_fpa_fpf0_marks_s cn58xx;
+	struct cvmx_fpa_fpf0_marks_s cn58xxp1;
+} cvmx_fpa_fpf0_marks_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_fpa_fpf0_size_s {
+		uint64_t reserved_12_63:52;
+		uint64_t fpf_siz:12;
+	} s;
+	struct cvmx_fpa_fpf0_size_s cn38xx;
+	struct cvmx_fpa_fpf0_size_s cn38xxp2;
+	struct cvmx_fpa_fpf0_size_s cn56xx;
+	struct cvmx_fpa_fpf0_size_s cn56xxp1;
+	struct cvmx_fpa_fpf0_size_s cn58xx;
+	struct cvmx_fpa_fpf0_size_s cn58xxp1;
+} cvmx_fpa_fpf0_size_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_fpa_int_enb_s {
+		uint64_t reserved_28_63:36;
+		uint64_t q7_perr:1;
+		uint64_t q7_coff:1;
+		uint64_t q7_und:1;
+		uint64_t q6_perr:1;
+		uint64_t q6_coff:1;
+		uint64_t q6_und:1;
+		uint64_t q5_perr:1;
+		uint64_t q5_coff:1;
+		uint64_t q5_und:1;
+		uint64_t q4_perr:1;
+		uint64_t q4_coff:1;
+		uint64_t q4_und:1;
+		uint64_t q3_perr:1;
+		uint64_t q3_coff:1;
+		uint64_t q3_und:1;
+		uint64_t q2_perr:1;
+		uint64_t q2_coff:1;
+		uint64_t q2_und:1;
+		uint64_t q1_perr:1;
+		uint64_t q1_coff:1;
+		uint64_t q1_und:1;
+		uint64_t q0_perr:1;
+		uint64_t q0_coff:1;
+		uint64_t q0_und:1;
+		uint64_t fed1_dbe:1;
+		uint64_t fed1_sbe:1;
+		uint64_t fed0_dbe:1;
+		uint64_t fed0_sbe:1;
+	} s;
+	struct cvmx_fpa_int_enb_s cn30xx;
+	struct cvmx_fpa_int_enb_s cn31xx;
+	struct cvmx_fpa_int_enb_s cn38xx;
+	struct cvmx_fpa_int_enb_s cn38xxp2;
+	struct cvmx_fpa_int_enb_s cn50xx;
+	struct cvmx_fpa_int_enb_s cn52xx;
+	struct cvmx_fpa_int_enb_s cn52xxp1;
+	struct cvmx_fpa_int_enb_s cn56xx;
+	struct cvmx_fpa_int_enb_s cn56xxp1;
+	struct cvmx_fpa_int_enb_s cn58xx;
+	struct cvmx_fpa_int_enb_s cn58xxp1;
+} cvmx_fpa_int_enb_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_fpa_int_sum_s {
+		uint64_t reserved_28_63:36;
+		uint64_t q7_perr:1;
+		uint64_t q7_coff:1;
+		uint64_t q7_und:1;
+		uint64_t q6_perr:1;
+		uint64_t q6_coff:1;
+		uint64_t q6_und:1;
+		uint64_t q5_perr:1;
+		uint64_t q5_coff:1;
+		uint64_t q5_und:1;
+		uint64_t q4_perr:1;
+		uint64_t q4_coff:1;
+		uint64_t q4_und:1;
+		uint64_t q3_perr:1;
+		uint64_t q3_coff:1;
+		uint64_t q3_und:1;
+		uint64_t q2_perr:1;
+		uint64_t q2_coff:1;
+		uint64_t q2_und:1;
+		uint64_t q1_perr:1;
+		uint64_t q1_coff:1;
+		uint64_t q1_und:1;
+		uint64_t q0_perr:1;
+		uint64_t q0_coff:1;
+		uint64_t q0_und:1;
+		uint64_t fed1_dbe:1;
+		uint64_t fed1_sbe:1;
+		uint64_t fed0_dbe:1;
+		uint64_t fed0_sbe:1;
+	} s;
+	struct cvmx_fpa_int_sum_s cn30xx;
+	struct cvmx_fpa_int_sum_s cn31xx;
+	struct cvmx_fpa_int_sum_s cn38xx;
+	struct cvmx_fpa_int_sum_s cn38xxp2;
+	struct cvmx_fpa_int_sum_s cn50xx;
+	struct cvmx_fpa_int_sum_s cn52xx;
+	struct cvmx_fpa_int_sum_s cn52xxp1;
+	struct cvmx_fpa_int_sum_s cn56xx;
+	struct cvmx_fpa_int_sum_s cn56xxp1;
+	struct cvmx_fpa_int_sum_s cn58xx;
+	struct cvmx_fpa_int_sum_s cn58xxp1;
+} cvmx_fpa_int_sum_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_fpa_quex_available_s {
+		uint64_t reserved_29_63:35;
+		uint64_t que_siz:29;
+	} s;
+	struct cvmx_fpa_quex_available_s cn30xx;
+	struct cvmx_fpa_quex_available_s cn31xx;
+	struct cvmx_fpa_quex_available_s cn38xx;
+	struct cvmx_fpa_quex_available_s cn38xxp2;
+	struct cvmx_fpa_quex_available_s cn50xx;
+	struct cvmx_fpa_quex_available_s cn52xx;
+	struct cvmx_fpa_quex_available_s cn52xxp1;
+	struct cvmx_fpa_quex_available_s cn56xx;
+	struct cvmx_fpa_quex_available_s cn56xxp1;
+	struct cvmx_fpa_quex_available_s cn58xx;
+	struct cvmx_fpa_quex_available_s cn58xxp1;
+} cvmx_fpa_quex_available_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_fpa_quex_page_index_s {
+		uint64_t reserved_25_63:39;
+		uint64_t pg_num:25;
+	} s;
+	struct cvmx_fpa_quex_page_index_s cn30xx;
+	struct cvmx_fpa_quex_page_index_s cn31xx;
+	struct cvmx_fpa_quex_page_index_s cn38xx;
+	struct cvmx_fpa_quex_page_index_s cn38xxp2;
+	struct cvmx_fpa_quex_page_index_s cn50xx;
+	struct cvmx_fpa_quex_page_index_s cn52xx;
+	struct cvmx_fpa_quex_page_index_s cn52xxp1;
+	struct cvmx_fpa_quex_page_index_s cn56xx;
+	struct cvmx_fpa_quex_page_index_s cn56xxp1;
+	struct cvmx_fpa_quex_page_index_s cn58xx;
+	struct cvmx_fpa_quex_page_index_s cn58xxp1;
+} cvmx_fpa_quex_page_index_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_fpa_que_act_s {
+		uint64_t reserved_29_63:35;
+		uint64_t act_que:3;
+		uint64_t act_indx:26;
+	} s;
+	struct cvmx_fpa_que_act_s cn30xx;
+	struct cvmx_fpa_que_act_s cn31xx;
+	struct cvmx_fpa_que_act_s cn38xx;
+	struct cvmx_fpa_que_act_s cn38xxp2;
+	struct cvmx_fpa_que_act_s cn50xx;
+	struct cvmx_fpa_que_act_s cn52xx;
+	struct cvmx_fpa_que_act_s cn52xxp1;
+	struct cvmx_fpa_que_act_s cn56xx;
+	struct cvmx_fpa_que_act_s cn56xxp1;
+	struct cvmx_fpa_que_act_s cn58xx;
+	struct cvmx_fpa_que_act_s cn58xxp1;
+} cvmx_fpa_que_act_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_fpa_que_exp_s {
+		uint64_t reserved_29_63:35;
+		uint64_t exp_que:3;
+		uint64_t exp_indx:26;
+	} s;
+	struct cvmx_fpa_que_exp_s cn30xx;
+	struct cvmx_fpa_que_exp_s cn31xx;
+	struct cvmx_fpa_que_exp_s cn38xx;
+	struct cvmx_fpa_que_exp_s cn38xxp2;
+	struct cvmx_fpa_que_exp_s cn50xx;
+	struct cvmx_fpa_que_exp_s cn52xx;
+	struct cvmx_fpa_que_exp_s cn52xxp1;
+	struct cvmx_fpa_que_exp_s cn56xx;
+	struct cvmx_fpa_que_exp_s cn56xxp1;
+	struct cvmx_fpa_que_exp_s cn58xx;
+	struct cvmx_fpa_que_exp_s cn58xxp1;
+} cvmx_fpa_que_exp_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_fpa_wart_ctl_s {
+		uint64_t reserved_16_63:48;
+		uint64_t ctl:16;
+	} s;
+	struct cvmx_fpa_wart_ctl_s cn30xx;
+	struct cvmx_fpa_wart_ctl_s cn31xx;
+	struct cvmx_fpa_wart_ctl_s cn38xx;
+	struct cvmx_fpa_wart_ctl_s cn38xxp2;
+	struct cvmx_fpa_wart_ctl_s cn50xx;
+	struct cvmx_fpa_wart_ctl_s cn52xx;
+	struct cvmx_fpa_wart_ctl_s cn52xxp1;
+	struct cvmx_fpa_wart_ctl_s cn56xx;
+	struct cvmx_fpa_wart_ctl_s cn56xxp1;
+	struct cvmx_fpa_wart_ctl_s cn58xx;
+	struct cvmx_fpa_wart_ctl_s cn58xxp1;
+} cvmx_fpa_wart_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_fpa_wart_status_s {
+		uint64_t reserved_32_63:32;
+		uint64_t status:32;
+	} s;
+	struct cvmx_fpa_wart_status_s cn30xx;
+	struct cvmx_fpa_wart_status_s cn31xx;
+	struct cvmx_fpa_wart_status_s cn38xx;
+	struct cvmx_fpa_wart_status_s cn38xxp2;
+	struct cvmx_fpa_wart_status_s cn50xx;
+	struct cvmx_fpa_wart_status_s cn52xx;
+	struct cvmx_fpa_wart_status_s cn52xxp1;
+	struct cvmx_fpa_wart_status_s cn56xx;
+	struct cvmx_fpa_wart_status_s cn56xxp1;
+	struct cvmx_fpa_wart_status_s cn58xx;
+	struct cvmx_fpa_wart_status_s cn58xxp1;
+} cvmx_fpa_wart_status_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_bad_reg_s {
+		uint64_t reserved_31_63:33;
+		uint64_t inb_nxa:4;
+		uint64_t statovr:1;
+		uint64_t loststat:4;
+		uint64_t reserved_18_21:4;
+		uint64_t out_ovr:16;
+		uint64_t ncb_ovr:1;
+		uint64_t out_col:1;
+	} s;
+	struct cvmx_gmxx_bad_reg_cn30xx {
+		uint64_t reserved_31_63:33;
+		uint64_t inb_nxa:4;
+		uint64_t statovr:1;
+		uint64_t reserved_25_25:1;
+		uint64_t loststat:3;
+		uint64_t reserved_5_21:17;
+		uint64_t out_ovr:3;
+		uint64_t reserved_0_1:2;
+	} cn30xx;
+	struct cvmx_gmxx_bad_reg_cn30xx cn31xx;
+	struct cvmx_gmxx_bad_reg_s cn38xx;
+	struct cvmx_gmxx_bad_reg_s cn38xxp2;
+	struct cvmx_gmxx_bad_reg_cn30xx cn50xx;
+	struct cvmx_gmxx_bad_reg_cn52xx {
+		uint64_t reserved_31_63:33;
+		uint64_t inb_nxa:4;
+		uint64_t statovr:1;
+		uint64_t loststat:4;
+		uint64_t reserved_6_21:16;
+		uint64_t out_ovr:4;
+		uint64_t reserved_0_1:2;
+	} cn52xx;
+	struct cvmx_gmxx_bad_reg_cn52xx cn52xxp1;
+	struct cvmx_gmxx_bad_reg_cn52xx cn56xx;
+	struct cvmx_gmxx_bad_reg_cn52xx cn56xxp1;
+	struct cvmx_gmxx_bad_reg_s cn58xx;
+	struct cvmx_gmxx_bad_reg_s cn58xxp1;
+} cvmx_gmxx_bad_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_bist_s {
+		uint64_t reserved_17_63:47;
+		uint64_t status:17;
+	} s;
+	struct cvmx_gmxx_bist_cn30xx {
+		uint64_t reserved_10_63:54;
+		uint64_t status:10;
+	} cn30xx;
+	struct cvmx_gmxx_bist_cn30xx cn31xx;
+	struct cvmx_gmxx_bist_cn30xx cn38xx;
+	struct cvmx_gmxx_bist_cn30xx cn38xxp2;
+	struct cvmx_gmxx_bist_cn50xx {
+		uint64_t reserved_12_63:52;
+		uint64_t status:12;
+	} cn50xx;
+	struct cvmx_gmxx_bist_cn52xx {
+		uint64_t reserved_16_63:48;
+		uint64_t status:16;
+	} cn52xx;
+	struct cvmx_gmxx_bist_cn52xx cn52xxp1;
+	struct cvmx_gmxx_bist_cn52xx cn56xx;
+	struct cvmx_gmxx_bist_cn52xx cn56xxp1;
+	struct cvmx_gmxx_bist_s cn58xx;
+	struct cvmx_gmxx_bist_s cn58xxp1;
+} cvmx_gmxx_bist_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_clk_en_s {
+		uint64_t reserved_1_63:63;
+		uint64_t clk_en:1;
+	} s;
+	struct cvmx_gmxx_clk_en_s cn52xx;
+	struct cvmx_gmxx_clk_en_s cn52xxp1;
+	struct cvmx_gmxx_clk_en_s cn56xx;
+	struct cvmx_gmxx_clk_en_s cn56xxp1;
+} cvmx_gmxx_clk_en_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_hg2_control_s {
+		uint64_t reserved_19_63:45;
+		uint64_t hg2tx_en:1;
+		uint64_t hg2rx_en:1;
+		uint64_t phys_en:1;
+		uint64_t logl_en:16;
+	} s;
+	struct cvmx_gmxx_hg2_control_s cn52xx;
+	struct cvmx_gmxx_hg2_control_s cn52xxp1;
+	struct cvmx_gmxx_hg2_control_s cn56xx;
+} cvmx_gmxx_hg2_control_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_inf_mode_s {
+		uint64_t reserved_10_63:54;
+		uint64_t speed:2;
+		uint64_t reserved_6_7:2;
+		uint64_t mode:2;
+		uint64_t reserved_3_3:1;
+		uint64_t p0mii:1;
+		uint64_t en:1;
+		uint64_t type:1;
+	} s;
+	struct cvmx_gmxx_inf_mode_cn30xx {
+		uint64_t reserved_3_63:61;
+		uint64_t p0mii:1;
+		uint64_t en:1;
+		uint64_t type:1;
+	} cn30xx;
+	struct cvmx_gmxx_inf_mode_cn31xx {
+		uint64_t reserved_2_63:62;
+		uint64_t en:1;
+		uint64_t type:1;
+	} cn31xx;
+	struct cvmx_gmxx_inf_mode_cn31xx cn38xx;
+	struct cvmx_gmxx_inf_mode_cn31xx cn38xxp2;
+	struct cvmx_gmxx_inf_mode_cn30xx cn50xx;
+	struct cvmx_gmxx_inf_mode_cn52xx {
+		uint64_t reserved_10_63:54;
+		uint64_t speed:2;
+		uint64_t reserved_6_7:2;
+		uint64_t mode:2;
+		uint64_t reserved_2_3:2;
+		uint64_t en:1;
+		uint64_t type:1;
+	} cn52xx;
+	struct cvmx_gmxx_inf_mode_cn52xx cn52xxp1;
+	struct cvmx_gmxx_inf_mode_cn52xx cn56xx;
+	struct cvmx_gmxx_inf_mode_cn52xx cn56xxp1;
+	struct cvmx_gmxx_inf_mode_cn31xx cn58xx;
+	struct cvmx_gmxx_inf_mode_cn31xx cn58xxp1;
+} cvmx_gmxx_inf_mode_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_nxa_adr_s {
+		uint64_t reserved_6_63:58;
+		uint64_t prt:6;
+	} s;
+	struct cvmx_gmxx_nxa_adr_s cn30xx;
+	struct cvmx_gmxx_nxa_adr_s cn31xx;
+	struct cvmx_gmxx_nxa_adr_s cn38xx;
+	struct cvmx_gmxx_nxa_adr_s cn38xxp2;
+	struct cvmx_gmxx_nxa_adr_s cn50xx;
+	struct cvmx_gmxx_nxa_adr_s cn52xx;
+	struct cvmx_gmxx_nxa_adr_s cn52xxp1;
+	struct cvmx_gmxx_nxa_adr_s cn56xx;
+	struct cvmx_gmxx_nxa_adr_s cn56xxp1;
+	struct cvmx_gmxx_nxa_adr_s cn58xx;
+	struct cvmx_gmxx_nxa_adr_s cn58xxp1;
+} cvmx_gmxx_nxa_adr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_prtx_cbfc_ctl_s {
+		uint64_t phys_en:16;
+		uint64_t logl_en:16;
+		uint64_t phys_bp:16;
+		uint64_t reserved_4_15:12;
+		uint64_t bck_en:1;
+		uint64_t drp_en:1;
+		uint64_t tx_en:1;
+		uint64_t rx_en:1;
+	} s;
+	struct cvmx_gmxx_prtx_cbfc_ctl_s cn52xx;
+	struct cvmx_gmxx_prtx_cbfc_ctl_s cn56xx;
+} cvmx_gmxx_prtx_cbfc_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_prtx_cfg_s {
+		uint64_t reserved_14_63:50;
+		uint64_t tx_idle:1;
+		uint64_t rx_idle:1;
+		uint64_t reserved_9_11:3;
+		uint64_t speed_msb:1;
+		uint64_t reserved_4_7:4;
+		uint64_t slottime:1;
+		uint64_t duplex:1;
+		uint64_t speed:1;
+		uint64_t en:1;
+	} s;
+	struct cvmx_gmxx_prtx_cfg_cn30xx {
+		uint64_t reserved_4_63:60;
+		uint64_t slottime:1;
+		uint64_t duplex:1;
+		uint64_t speed:1;
+		uint64_t en:1;
+	} cn30xx;
+	struct cvmx_gmxx_prtx_cfg_cn30xx cn31xx;
+	struct cvmx_gmxx_prtx_cfg_cn30xx cn38xx;
+	struct cvmx_gmxx_prtx_cfg_cn30xx cn38xxp2;
+	struct cvmx_gmxx_prtx_cfg_cn30xx cn50xx;
+	struct cvmx_gmxx_prtx_cfg_s cn52xx;
+	struct cvmx_gmxx_prtx_cfg_s cn52xxp1;
+	struct cvmx_gmxx_prtx_cfg_s cn56xx;
+	struct cvmx_gmxx_prtx_cfg_s cn56xxp1;
+	struct cvmx_gmxx_prtx_cfg_cn30xx cn58xx;
+	struct cvmx_gmxx_prtx_cfg_cn30xx cn58xxp1;
+} cvmx_gmxx_prtx_cfg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_adr_cam0_s {
+		uint64_t adr:64;
+	} s;
+	struct cvmx_gmxx_rxx_adr_cam0_s cn30xx;
+	struct cvmx_gmxx_rxx_adr_cam0_s cn31xx;
+	struct cvmx_gmxx_rxx_adr_cam0_s cn38xx;
+	struct cvmx_gmxx_rxx_adr_cam0_s cn38xxp2;
+	struct cvmx_gmxx_rxx_adr_cam0_s cn50xx;
+	struct cvmx_gmxx_rxx_adr_cam0_s cn52xx;
+	struct cvmx_gmxx_rxx_adr_cam0_s cn52xxp1;
+	struct cvmx_gmxx_rxx_adr_cam0_s cn56xx;
+	struct cvmx_gmxx_rxx_adr_cam0_s cn56xxp1;
+	struct cvmx_gmxx_rxx_adr_cam0_s cn58xx;
+	struct cvmx_gmxx_rxx_adr_cam0_s cn58xxp1;
+} cvmx_gmxx_rxx_adr_cam0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_adr_cam1_s {
+		uint64_t adr:64;
+	} s;
+	struct cvmx_gmxx_rxx_adr_cam1_s cn30xx;
+	struct cvmx_gmxx_rxx_adr_cam1_s cn31xx;
+	struct cvmx_gmxx_rxx_adr_cam1_s cn38xx;
+	struct cvmx_gmxx_rxx_adr_cam1_s cn38xxp2;
+	struct cvmx_gmxx_rxx_adr_cam1_s cn50xx;
+	struct cvmx_gmxx_rxx_adr_cam1_s cn52xx;
+	struct cvmx_gmxx_rxx_adr_cam1_s cn52xxp1;
+	struct cvmx_gmxx_rxx_adr_cam1_s cn56xx;
+	struct cvmx_gmxx_rxx_adr_cam1_s cn56xxp1;
+	struct cvmx_gmxx_rxx_adr_cam1_s cn58xx;
+	struct cvmx_gmxx_rxx_adr_cam1_s cn58xxp1;
+} cvmx_gmxx_rxx_adr_cam1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_adr_cam2_s {
+		uint64_t adr:64;
+	} s;
+	struct cvmx_gmxx_rxx_adr_cam2_s cn30xx;
+	struct cvmx_gmxx_rxx_adr_cam2_s cn31xx;
+	struct cvmx_gmxx_rxx_adr_cam2_s cn38xx;
+	struct cvmx_gmxx_rxx_adr_cam2_s cn38xxp2;
+	struct cvmx_gmxx_rxx_adr_cam2_s cn50xx;
+	struct cvmx_gmxx_rxx_adr_cam2_s cn52xx;
+	struct cvmx_gmxx_rxx_adr_cam2_s cn52xxp1;
+	struct cvmx_gmxx_rxx_adr_cam2_s cn56xx;
+	struct cvmx_gmxx_rxx_adr_cam2_s cn56xxp1;
+	struct cvmx_gmxx_rxx_adr_cam2_s cn58xx;
+	struct cvmx_gmxx_rxx_adr_cam2_s cn58xxp1;
+} cvmx_gmxx_rxx_adr_cam2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_adr_cam3_s {
+		uint64_t adr:64;
+	} s;
+	struct cvmx_gmxx_rxx_adr_cam3_s cn30xx;
+	struct cvmx_gmxx_rxx_adr_cam3_s cn31xx;
+	struct cvmx_gmxx_rxx_adr_cam3_s cn38xx;
+	struct cvmx_gmxx_rxx_adr_cam3_s cn38xxp2;
+	struct cvmx_gmxx_rxx_adr_cam3_s cn50xx;
+	struct cvmx_gmxx_rxx_adr_cam3_s cn52xx;
+	struct cvmx_gmxx_rxx_adr_cam3_s cn52xxp1;
+	struct cvmx_gmxx_rxx_adr_cam3_s cn56xx;
+	struct cvmx_gmxx_rxx_adr_cam3_s cn56xxp1;
+	struct cvmx_gmxx_rxx_adr_cam3_s cn58xx;
+	struct cvmx_gmxx_rxx_adr_cam3_s cn58xxp1;
+} cvmx_gmxx_rxx_adr_cam3_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_adr_cam4_s {
+		uint64_t adr:64;
+	} s;
+	struct cvmx_gmxx_rxx_adr_cam4_s cn30xx;
+	struct cvmx_gmxx_rxx_adr_cam4_s cn31xx;
+	struct cvmx_gmxx_rxx_adr_cam4_s cn38xx;
+	struct cvmx_gmxx_rxx_adr_cam4_s cn38xxp2;
+	struct cvmx_gmxx_rxx_adr_cam4_s cn50xx;
+	struct cvmx_gmxx_rxx_adr_cam4_s cn52xx;
+	struct cvmx_gmxx_rxx_adr_cam4_s cn52xxp1;
+	struct cvmx_gmxx_rxx_adr_cam4_s cn56xx;
+	struct cvmx_gmxx_rxx_adr_cam4_s cn56xxp1;
+	struct cvmx_gmxx_rxx_adr_cam4_s cn58xx;
+	struct cvmx_gmxx_rxx_adr_cam4_s cn58xxp1;
+} cvmx_gmxx_rxx_adr_cam4_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_adr_cam5_s {
+		uint64_t adr:64;
+	} s;
+	struct cvmx_gmxx_rxx_adr_cam5_s cn30xx;
+	struct cvmx_gmxx_rxx_adr_cam5_s cn31xx;
+	struct cvmx_gmxx_rxx_adr_cam5_s cn38xx;
+	struct cvmx_gmxx_rxx_adr_cam5_s cn38xxp2;
+	struct cvmx_gmxx_rxx_adr_cam5_s cn50xx;
+	struct cvmx_gmxx_rxx_adr_cam5_s cn52xx;
+	struct cvmx_gmxx_rxx_adr_cam5_s cn52xxp1;
+	struct cvmx_gmxx_rxx_adr_cam5_s cn56xx;
+	struct cvmx_gmxx_rxx_adr_cam5_s cn56xxp1;
+	struct cvmx_gmxx_rxx_adr_cam5_s cn58xx;
+	struct cvmx_gmxx_rxx_adr_cam5_s cn58xxp1;
+} cvmx_gmxx_rxx_adr_cam5_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_adr_cam_en_s {
+		uint64_t reserved_8_63:56;
+		uint64_t en:8;
+	} s;
+	struct cvmx_gmxx_rxx_adr_cam_en_s cn30xx;
+	struct cvmx_gmxx_rxx_adr_cam_en_s cn31xx;
+	struct cvmx_gmxx_rxx_adr_cam_en_s cn38xx;
+	struct cvmx_gmxx_rxx_adr_cam_en_s cn38xxp2;
+	struct cvmx_gmxx_rxx_adr_cam_en_s cn50xx;
+	struct cvmx_gmxx_rxx_adr_cam_en_s cn52xx;
+	struct cvmx_gmxx_rxx_adr_cam_en_s cn52xxp1;
+	struct cvmx_gmxx_rxx_adr_cam_en_s cn56xx;
+	struct cvmx_gmxx_rxx_adr_cam_en_s cn56xxp1;
+	struct cvmx_gmxx_rxx_adr_cam_en_s cn58xx;
+	struct cvmx_gmxx_rxx_adr_cam_en_s cn58xxp1;
+} cvmx_gmxx_rxx_adr_cam_en_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_adr_ctl_s {
+		uint64_t reserved_4_63:60;
+		uint64_t cam_mode:1;
+		uint64_t mcst:2;
+		uint64_t bcst:1;
+	} s;
+	struct cvmx_gmxx_rxx_adr_ctl_s cn30xx;
+	struct cvmx_gmxx_rxx_adr_ctl_s cn31xx;
+	struct cvmx_gmxx_rxx_adr_ctl_s cn38xx;
+	struct cvmx_gmxx_rxx_adr_ctl_s cn38xxp2;
+	struct cvmx_gmxx_rxx_adr_ctl_s cn50xx;
+	struct cvmx_gmxx_rxx_adr_ctl_s cn52xx;
+	struct cvmx_gmxx_rxx_adr_ctl_s cn52xxp1;
+	struct cvmx_gmxx_rxx_adr_ctl_s cn56xx;
+	struct cvmx_gmxx_rxx_adr_ctl_s cn56xxp1;
+	struct cvmx_gmxx_rxx_adr_ctl_s cn58xx;
+	struct cvmx_gmxx_rxx_adr_ctl_s cn58xxp1;
+} cvmx_gmxx_rxx_adr_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_decision_s {
+		uint64_t reserved_5_63:59;
+		uint64_t cnt:5;
+	} s;
+	struct cvmx_gmxx_rxx_decision_s cn30xx;
+	struct cvmx_gmxx_rxx_decision_s cn31xx;
+	struct cvmx_gmxx_rxx_decision_s cn38xx;
+	struct cvmx_gmxx_rxx_decision_s cn38xxp2;
+	struct cvmx_gmxx_rxx_decision_s cn50xx;
+	struct cvmx_gmxx_rxx_decision_s cn52xx;
+	struct cvmx_gmxx_rxx_decision_s cn52xxp1;
+	struct cvmx_gmxx_rxx_decision_s cn56xx;
+	struct cvmx_gmxx_rxx_decision_s cn56xxp1;
+	struct cvmx_gmxx_rxx_decision_s cn58xx;
+	struct cvmx_gmxx_rxx_decision_s cn58xxp1;
+} cvmx_gmxx_rxx_decision_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_frm_chk_s {
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
+	struct cvmx_gmxx_rxx_frm_chk_s cn30xx;
+	struct cvmx_gmxx_rxx_frm_chk_s cn31xx;
+	struct cvmx_gmxx_rxx_frm_chk_s cn38xx;
+	struct cvmx_gmxx_rxx_frm_chk_s cn38xxp2;
+	struct cvmx_gmxx_rxx_frm_chk_cn50xx {
+		uint64_t reserved_10_63:54;
+		uint64_t niberr:1;
+		uint64_t skperr:1;
+		uint64_t rcverr:1;
+		uint64_t reserved_6_6:1;
+		uint64_t alnerr:1;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t reserved_2_2:1;
+		uint64_t carext:1;
+		uint64_t reserved_0_0:1;
+	} cn50xx;
+	struct cvmx_gmxx_rxx_frm_chk_cn52xx {
+		uint64_t reserved_9_63:55;
+		uint64_t skperr:1;
+		uint64_t rcverr:1;
+		uint64_t reserved_5_6:2;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t reserved_2_2:1;
+		uint64_t carext:1;
+		uint64_t reserved_0_0:1;
+	} cn52xx;
+	struct cvmx_gmxx_rxx_frm_chk_cn52xx cn52xxp1;
+	struct cvmx_gmxx_rxx_frm_chk_cn52xx cn56xx;
+	struct cvmx_gmxx_rxx_frm_chk_cn52xx cn56xxp1;
+	struct cvmx_gmxx_rxx_frm_chk_s cn58xx;
+	struct cvmx_gmxx_rxx_frm_chk_s cn58xxp1;
+} cvmx_gmxx_rxx_frm_chk_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_frm_ctl_s {
+		uint64_t reserved_11_63:53;
+		uint64_t null_dis:1;
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
+	struct cvmx_gmxx_rxx_frm_ctl_cn30xx {
+		uint64_t reserved_9_63:55;
+		uint64_t pad_len:1;
+		uint64_t vlan_len:1;
+		uint64_t pre_free:1;
+		uint64_t ctl_smac:1;
+		uint64_t ctl_mcst:1;
+		uint64_t ctl_bck:1;
+		uint64_t ctl_drp:1;
+		uint64_t pre_strp:1;
+		uint64_t pre_chk:1;
+	} cn30xx;
+	struct cvmx_gmxx_rxx_frm_ctl_cn31xx {
+		uint64_t reserved_8_63:56;
+		uint64_t vlan_len:1;
+		uint64_t pre_free:1;
+		uint64_t ctl_smac:1;
+		uint64_t ctl_mcst:1;
+		uint64_t ctl_bck:1;
+		uint64_t ctl_drp:1;
+		uint64_t pre_strp:1;
+		uint64_t pre_chk:1;
+	} cn31xx;
+	struct cvmx_gmxx_rxx_frm_ctl_cn30xx cn38xx;
+	struct cvmx_gmxx_rxx_frm_ctl_cn31xx cn38xxp2;
+	struct cvmx_gmxx_rxx_frm_ctl_cn50xx {
+		uint64_t reserved_11_63:53;
+		uint64_t null_dis:1;
+		uint64_t pre_align:1;
+		uint64_t reserved_7_8:2;
+		uint64_t pre_free:1;
+		uint64_t ctl_smac:1;
+		uint64_t ctl_mcst:1;
+		uint64_t ctl_bck:1;
+		uint64_t ctl_drp:1;
+		uint64_t pre_strp:1;
+		uint64_t pre_chk:1;
+	} cn50xx;
+	struct cvmx_gmxx_rxx_frm_ctl_cn50xx cn52xx;
+	struct cvmx_gmxx_rxx_frm_ctl_cn50xx cn52xxp1;
+	struct cvmx_gmxx_rxx_frm_ctl_cn50xx cn56xx;
+	struct cvmx_gmxx_rxx_frm_ctl_cn56xxp1 {
+		uint64_t reserved_10_63:54;
+		uint64_t pre_align:1;
+		uint64_t reserved_7_8:2;
+		uint64_t pre_free:1;
+		uint64_t ctl_smac:1;
+		uint64_t ctl_mcst:1;
+		uint64_t ctl_bck:1;
+		uint64_t ctl_drp:1;
+		uint64_t pre_strp:1;
+		uint64_t pre_chk:1;
+	} cn56xxp1;
+	struct cvmx_gmxx_rxx_frm_ctl_s cn58xx;
+	struct cvmx_gmxx_rxx_frm_ctl_cn30xx cn58xxp1;
+} cvmx_gmxx_rxx_frm_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_frm_max_s {
+		uint64_t reserved_16_63:48;
+		uint64_t len:16;
+	} s;
+	struct cvmx_gmxx_rxx_frm_max_s cn30xx;
+	struct cvmx_gmxx_rxx_frm_max_s cn31xx;
+	struct cvmx_gmxx_rxx_frm_max_s cn38xx;
+	struct cvmx_gmxx_rxx_frm_max_s cn38xxp2;
+	struct cvmx_gmxx_rxx_frm_max_s cn58xx;
+	struct cvmx_gmxx_rxx_frm_max_s cn58xxp1;
+} cvmx_gmxx_rxx_frm_max_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_frm_min_s {
+		uint64_t reserved_16_63:48;
+		uint64_t len:16;
+	} s;
+	struct cvmx_gmxx_rxx_frm_min_s cn30xx;
+	struct cvmx_gmxx_rxx_frm_min_s cn31xx;
+	struct cvmx_gmxx_rxx_frm_min_s cn38xx;
+	struct cvmx_gmxx_rxx_frm_min_s cn38xxp2;
+	struct cvmx_gmxx_rxx_frm_min_s cn58xx;
+	struct cvmx_gmxx_rxx_frm_min_s cn58xxp1;
+} cvmx_gmxx_rxx_frm_min_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_ifg_s {
+		uint64_t reserved_4_63:60;
+		uint64_t ifg:4;
+	} s;
+	struct cvmx_gmxx_rxx_ifg_s cn30xx;
+	struct cvmx_gmxx_rxx_ifg_s cn31xx;
+	struct cvmx_gmxx_rxx_ifg_s cn38xx;
+	struct cvmx_gmxx_rxx_ifg_s cn38xxp2;
+	struct cvmx_gmxx_rxx_ifg_s cn50xx;
+	struct cvmx_gmxx_rxx_ifg_s cn52xx;
+	struct cvmx_gmxx_rxx_ifg_s cn52xxp1;
+	struct cvmx_gmxx_rxx_ifg_s cn56xx;
+	struct cvmx_gmxx_rxx_ifg_s cn56xxp1;
+	struct cvmx_gmxx_rxx_ifg_s cn58xx;
+	struct cvmx_gmxx_rxx_ifg_s cn58xxp1;
+} cvmx_gmxx_rxx_ifg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_int_en_s {
+		uint64_t reserved_29_63:35;
+		uint64_t hg2cc:1;
+		uint64_t hg2fld:1;
+		uint64_t undat:1;
+		uint64_t uneop:1;
+		uint64_t unsop:1;
+		uint64_t bad_term:1;
+		uint64_t bad_seq:1;
+		uint64_t rem_fault:1;
+		uint64_t loc_fault:1;
+		uint64_t pause_drp:1;
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
+	struct cvmx_gmxx_rxx_int_en_cn30xx {
+		uint64_t reserved_19_63:45;
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
+	} cn30xx;
+	struct cvmx_gmxx_rxx_int_en_cn30xx cn31xx;
+	struct cvmx_gmxx_rxx_int_en_cn30xx cn38xx;
+	struct cvmx_gmxx_rxx_int_en_cn30xx cn38xxp2;
+	struct cvmx_gmxx_rxx_int_en_cn50xx {
+		uint64_t reserved_20_63:44;
+		uint64_t pause_drp:1;
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
+		uint64_t reserved_6_6:1;
+		uint64_t alnerr:1;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t reserved_2_2:1;
+		uint64_t carext:1;
+		uint64_t reserved_0_0:1;
+	} cn50xx;
+	struct cvmx_gmxx_rxx_int_en_cn52xx {
+		uint64_t reserved_29_63:35;
+		uint64_t hg2cc:1;
+		uint64_t hg2fld:1;
+		uint64_t undat:1;
+		uint64_t uneop:1;
+		uint64_t unsop:1;
+		uint64_t bad_term:1;
+		uint64_t bad_seq:1;
+		uint64_t rem_fault:1;
+		uint64_t loc_fault:1;
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
+		uint64_t reserved_5_6:2;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t reserved_2_2:1;
+		uint64_t carext:1;
+		uint64_t reserved_0_0:1;
+	} cn52xx;
+	struct cvmx_gmxx_rxx_int_en_cn52xx cn52xxp1;
+	struct cvmx_gmxx_rxx_int_en_cn52xx cn56xx;
+	struct cvmx_gmxx_rxx_int_en_cn56xxp1 {
+		uint64_t reserved_27_63:37;
+		uint64_t undat:1;
+		uint64_t uneop:1;
+		uint64_t unsop:1;
+		uint64_t bad_term:1;
+		uint64_t bad_seq:1;
+		uint64_t rem_fault:1;
+		uint64_t loc_fault:1;
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
+		uint64_t reserved_5_6:2;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t reserved_2_2:1;
+		uint64_t carext:1;
+		uint64_t reserved_0_0:1;
+	} cn56xxp1;
+	struct cvmx_gmxx_rxx_int_en_cn58xx {
+		uint64_t reserved_20_63:44;
+		uint64_t pause_drp:1;
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
+	} cn58xx;
+	struct cvmx_gmxx_rxx_int_en_cn58xx cn58xxp1;
+} cvmx_gmxx_rxx_int_en_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_int_reg_s {
+		uint64_t reserved_29_63:35;
+		uint64_t hg2cc:1;
+		uint64_t hg2fld:1;
+		uint64_t undat:1;
+		uint64_t uneop:1;
+		uint64_t unsop:1;
+		uint64_t bad_term:1;
+		uint64_t bad_seq:1;
+		uint64_t rem_fault:1;
+		uint64_t loc_fault:1;
+		uint64_t pause_drp:1;
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
+	struct cvmx_gmxx_rxx_int_reg_cn30xx {
+		uint64_t reserved_19_63:45;
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
+	} cn30xx;
+	struct cvmx_gmxx_rxx_int_reg_cn30xx cn31xx;
+	struct cvmx_gmxx_rxx_int_reg_cn30xx cn38xx;
+	struct cvmx_gmxx_rxx_int_reg_cn30xx cn38xxp2;
+	struct cvmx_gmxx_rxx_int_reg_cn50xx {
+		uint64_t reserved_20_63:44;
+		uint64_t pause_drp:1;
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
+		uint64_t reserved_6_6:1;
+		uint64_t alnerr:1;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t reserved_2_2:1;
+		uint64_t carext:1;
+		uint64_t reserved_0_0:1;
+	} cn50xx;
+	struct cvmx_gmxx_rxx_int_reg_cn52xx {
+		uint64_t reserved_29_63:35;
+		uint64_t hg2cc:1;
+		uint64_t hg2fld:1;
+		uint64_t undat:1;
+		uint64_t uneop:1;
+		uint64_t unsop:1;
+		uint64_t bad_term:1;
+		uint64_t bad_seq:1;
+		uint64_t rem_fault:1;
+		uint64_t loc_fault:1;
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
+		uint64_t reserved_5_6:2;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t reserved_2_2:1;
+		uint64_t carext:1;
+		uint64_t reserved_0_0:1;
+	} cn52xx;
+	struct cvmx_gmxx_rxx_int_reg_cn52xx cn52xxp1;
+	struct cvmx_gmxx_rxx_int_reg_cn52xx cn56xx;
+	struct cvmx_gmxx_rxx_int_reg_cn56xxp1 {
+		uint64_t reserved_27_63:37;
+		uint64_t undat:1;
+		uint64_t uneop:1;
+		uint64_t unsop:1;
+		uint64_t bad_term:1;
+		uint64_t bad_seq:1;
+		uint64_t rem_fault:1;
+		uint64_t loc_fault:1;
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
+		uint64_t reserved_5_6:2;
+		uint64_t fcserr:1;
+		uint64_t jabber:1;
+		uint64_t reserved_2_2:1;
+		uint64_t carext:1;
+		uint64_t reserved_0_0:1;
+	} cn56xxp1;
+	struct cvmx_gmxx_rxx_int_reg_cn58xx {
+		uint64_t reserved_20_63:44;
+		uint64_t pause_drp:1;
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
+	} cn58xx;
+	struct cvmx_gmxx_rxx_int_reg_cn58xx cn58xxp1;
+} cvmx_gmxx_rxx_int_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_jabber_s {
+		uint64_t reserved_16_63:48;
+		uint64_t cnt:16;
+	} s;
+	struct cvmx_gmxx_rxx_jabber_s cn30xx;
+	struct cvmx_gmxx_rxx_jabber_s cn31xx;
+	struct cvmx_gmxx_rxx_jabber_s cn38xx;
+	struct cvmx_gmxx_rxx_jabber_s cn38xxp2;
+	struct cvmx_gmxx_rxx_jabber_s cn50xx;
+	struct cvmx_gmxx_rxx_jabber_s cn52xx;
+	struct cvmx_gmxx_rxx_jabber_s cn52xxp1;
+	struct cvmx_gmxx_rxx_jabber_s cn56xx;
+	struct cvmx_gmxx_rxx_jabber_s cn56xxp1;
+	struct cvmx_gmxx_rxx_jabber_s cn58xx;
+	struct cvmx_gmxx_rxx_jabber_s cn58xxp1;
+} cvmx_gmxx_rxx_jabber_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_pause_drop_time_s {
+		uint64_t reserved_16_63:48;
+		uint64_t status:16;
+	} s;
+	struct cvmx_gmxx_rxx_pause_drop_time_s cn50xx;
+	struct cvmx_gmxx_rxx_pause_drop_time_s cn52xx;
+	struct cvmx_gmxx_rxx_pause_drop_time_s cn52xxp1;
+	struct cvmx_gmxx_rxx_pause_drop_time_s cn56xx;
+	struct cvmx_gmxx_rxx_pause_drop_time_s cn56xxp1;
+	struct cvmx_gmxx_rxx_pause_drop_time_s cn58xx;
+	struct cvmx_gmxx_rxx_pause_drop_time_s cn58xxp1;
+} cvmx_gmxx_rxx_pause_drop_time_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_rx_inbnd_s {
+		uint64_t reserved_4_63:60;
+		uint64_t duplex:1;
+		uint64_t speed:2;
+		uint64_t status:1;
+	} s;
+	struct cvmx_gmxx_rxx_rx_inbnd_s cn30xx;
+	struct cvmx_gmxx_rxx_rx_inbnd_s cn31xx;
+	struct cvmx_gmxx_rxx_rx_inbnd_s cn38xx;
+	struct cvmx_gmxx_rxx_rx_inbnd_s cn38xxp2;
+	struct cvmx_gmxx_rxx_rx_inbnd_s cn50xx;
+	struct cvmx_gmxx_rxx_rx_inbnd_s cn58xx;
+	struct cvmx_gmxx_rxx_rx_inbnd_s cn58xxp1;
+} cvmx_gmxx_rxx_rx_inbnd_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_stats_ctl_s {
+		uint64_t reserved_1_63:63;
+		uint64_t rd_clr:1;
+	} s;
+	struct cvmx_gmxx_rxx_stats_ctl_s cn30xx;
+	struct cvmx_gmxx_rxx_stats_ctl_s cn31xx;
+	struct cvmx_gmxx_rxx_stats_ctl_s cn38xx;
+	struct cvmx_gmxx_rxx_stats_ctl_s cn38xxp2;
+	struct cvmx_gmxx_rxx_stats_ctl_s cn50xx;
+	struct cvmx_gmxx_rxx_stats_ctl_s cn52xx;
+	struct cvmx_gmxx_rxx_stats_ctl_s cn52xxp1;
+	struct cvmx_gmxx_rxx_stats_ctl_s cn56xx;
+	struct cvmx_gmxx_rxx_stats_ctl_s cn56xxp1;
+	struct cvmx_gmxx_rxx_stats_ctl_s cn58xx;
+	struct cvmx_gmxx_rxx_stats_ctl_s cn58xxp1;
+} cvmx_gmxx_rxx_stats_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_stats_octs_s {
+		uint64_t reserved_48_63:16;
+		uint64_t cnt:48;
+	} s;
+	struct cvmx_gmxx_rxx_stats_octs_s cn30xx;
+	struct cvmx_gmxx_rxx_stats_octs_s cn31xx;
+	struct cvmx_gmxx_rxx_stats_octs_s cn38xx;
+	struct cvmx_gmxx_rxx_stats_octs_s cn38xxp2;
+	struct cvmx_gmxx_rxx_stats_octs_s cn50xx;
+	struct cvmx_gmxx_rxx_stats_octs_s cn52xx;
+	struct cvmx_gmxx_rxx_stats_octs_s cn52xxp1;
+	struct cvmx_gmxx_rxx_stats_octs_s cn56xx;
+	struct cvmx_gmxx_rxx_stats_octs_s cn56xxp1;
+	struct cvmx_gmxx_rxx_stats_octs_s cn58xx;
+	struct cvmx_gmxx_rxx_stats_octs_s cn58xxp1;
+} cvmx_gmxx_rxx_stats_octs_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_stats_octs_ctl_s {
+		uint64_t reserved_48_63:16;
+		uint64_t cnt:48;
+	} s;
+	struct cvmx_gmxx_rxx_stats_octs_ctl_s cn30xx;
+	struct cvmx_gmxx_rxx_stats_octs_ctl_s cn31xx;
+	struct cvmx_gmxx_rxx_stats_octs_ctl_s cn38xx;
+	struct cvmx_gmxx_rxx_stats_octs_ctl_s cn38xxp2;
+	struct cvmx_gmxx_rxx_stats_octs_ctl_s cn50xx;
+	struct cvmx_gmxx_rxx_stats_octs_ctl_s cn52xx;
+	struct cvmx_gmxx_rxx_stats_octs_ctl_s cn52xxp1;
+	struct cvmx_gmxx_rxx_stats_octs_ctl_s cn56xx;
+	struct cvmx_gmxx_rxx_stats_octs_ctl_s cn56xxp1;
+	struct cvmx_gmxx_rxx_stats_octs_ctl_s cn58xx;
+	struct cvmx_gmxx_rxx_stats_octs_ctl_s cn58xxp1;
+} cvmx_gmxx_rxx_stats_octs_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_stats_octs_dmac_s {
+		uint64_t reserved_48_63:16;
+		uint64_t cnt:48;
+	} s;
+	struct cvmx_gmxx_rxx_stats_octs_dmac_s cn30xx;
+	struct cvmx_gmxx_rxx_stats_octs_dmac_s cn31xx;
+	struct cvmx_gmxx_rxx_stats_octs_dmac_s cn38xx;
+	struct cvmx_gmxx_rxx_stats_octs_dmac_s cn38xxp2;
+	struct cvmx_gmxx_rxx_stats_octs_dmac_s cn50xx;
+	struct cvmx_gmxx_rxx_stats_octs_dmac_s cn52xx;
+	struct cvmx_gmxx_rxx_stats_octs_dmac_s cn52xxp1;
+	struct cvmx_gmxx_rxx_stats_octs_dmac_s cn56xx;
+	struct cvmx_gmxx_rxx_stats_octs_dmac_s cn56xxp1;
+	struct cvmx_gmxx_rxx_stats_octs_dmac_s cn58xx;
+	struct cvmx_gmxx_rxx_stats_octs_dmac_s cn58xxp1;
+} cvmx_gmxx_rxx_stats_octs_dmac_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_stats_octs_drp_s {
+		uint64_t reserved_48_63:16;
+		uint64_t cnt:48;
+	} s;
+	struct cvmx_gmxx_rxx_stats_octs_drp_s cn30xx;
+	struct cvmx_gmxx_rxx_stats_octs_drp_s cn31xx;
+	struct cvmx_gmxx_rxx_stats_octs_drp_s cn38xx;
+	struct cvmx_gmxx_rxx_stats_octs_drp_s cn38xxp2;
+	struct cvmx_gmxx_rxx_stats_octs_drp_s cn50xx;
+	struct cvmx_gmxx_rxx_stats_octs_drp_s cn52xx;
+	struct cvmx_gmxx_rxx_stats_octs_drp_s cn52xxp1;
+	struct cvmx_gmxx_rxx_stats_octs_drp_s cn56xx;
+	struct cvmx_gmxx_rxx_stats_octs_drp_s cn56xxp1;
+	struct cvmx_gmxx_rxx_stats_octs_drp_s cn58xx;
+	struct cvmx_gmxx_rxx_stats_octs_drp_s cn58xxp1;
+} cvmx_gmxx_rxx_stats_octs_drp_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_stats_pkts_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_gmxx_rxx_stats_pkts_s cn30xx;
+	struct cvmx_gmxx_rxx_stats_pkts_s cn31xx;
+	struct cvmx_gmxx_rxx_stats_pkts_s cn38xx;
+	struct cvmx_gmxx_rxx_stats_pkts_s cn38xxp2;
+	struct cvmx_gmxx_rxx_stats_pkts_s cn50xx;
+	struct cvmx_gmxx_rxx_stats_pkts_s cn52xx;
+	struct cvmx_gmxx_rxx_stats_pkts_s cn52xxp1;
+	struct cvmx_gmxx_rxx_stats_pkts_s cn56xx;
+	struct cvmx_gmxx_rxx_stats_pkts_s cn56xxp1;
+	struct cvmx_gmxx_rxx_stats_pkts_s cn58xx;
+	struct cvmx_gmxx_rxx_stats_pkts_s cn58xxp1;
+} cvmx_gmxx_rxx_stats_pkts_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_stats_pkts_bad_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_gmxx_rxx_stats_pkts_bad_s cn30xx;
+	struct cvmx_gmxx_rxx_stats_pkts_bad_s cn31xx;
+	struct cvmx_gmxx_rxx_stats_pkts_bad_s cn38xx;
+	struct cvmx_gmxx_rxx_stats_pkts_bad_s cn38xxp2;
+	struct cvmx_gmxx_rxx_stats_pkts_bad_s cn50xx;
+	struct cvmx_gmxx_rxx_stats_pkts_bad_s cn52xx;
+	struct cvmx_gmxx_rxx_stats_pkts_bad_s cn52xxp1;
+	struct cvmx_gmxx_rxx_stats_pkts_bad_s cn56xx;
+	struct cvmx_gmxx_rxx_stats_pkts_bad_s cn56xxp1;
+	struct cvmx_gmxx_rxx_stats_pkts_bad_s cn58xx;
+	struct cvmx_gmxx_rxx_stats_pkts_bad_s cn58xxp1;
+} cvmx_gmxx_rxx_stats_pkts_bad_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_stats_pkts_ctl_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_gmxx_rxx_stats_pkts_ctl_s cn30xx;
+	struct cvmx_gmxx_rxx_stats_pkts_ctl_s cn31xx;
+	struct cvmx_gmxx_rxx_stats_pkts_ctl_s cn38xx;
+	struct cvmx_gmxx_rxx_stats_pkts_ctl_s cn38xxp2;
+	struct cvmx_gmxx_rxx_stats_pkts_ctl_s cn50xx;
+	struct cvmx_gmxx_rxx_stats_pkts_ctl_s cn52xx;
+	struct cvmx_gmxx_rxx_stats_pkts_ctl_s cn52xxp1;
+	struct cvmx_gmxx_rxx_stats_pkts_ctl_s cn56xx;
+	struct cvmx_gmxx_rxx_stats_pkts_ctl_s cn56xxp1;
+	struct cvmx_gmxx_rxx_stats_pkts_ctl_s cn58xx;
+	struct cvmx_gmxx_rxx_stats_pkts_ctl_s cn58xxp1;
+} cvmx_gmxx_rxx_stats_pkts_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_stats_pkts_dmac_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_gmxx_rxx_stats_pkts_dmac_s cn30xx;
+	struct cvmx_gmxx_rxx_stats_pkts_dmac_s cn31xx;
+	struct cvmx_gmxx_rxx_stats_pkts_dmac_s cn38xx;
+	struct cvmx_gmxx_rxx_stats_pkts_dmac_s cn38xxp2;
+	struct cvmx_gmxx_rxx_stats_pkts_dmac_s cn50xx;
+	struct cvmx_gmxx_rxx_stats_pkts_dmac_s cn52xx;
+	struct cvmx_gmxx_rxx_stats_pkts_dmac_s cn52xxp1;
+	struct cvmx_gmxx_rxx_stats_pkts_dmac_s cn56xx;
+	struct cvmx_gmxx_rxx_stats_pkts_dmac_s cn56xxp1;
+	struct cvmx_gmxx_rxx_stats_pkts_dmac_s cn58xx;
+	struct cvmx_gmxx_rxx_stats_pkts_dmac_s cn58xxp1;
+} cvmx_gmxx_rxx_stats_pkts_dmac_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_stats_pkts_drp_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_gmxx_rxx_stats_pkts_drp_s cn30xx;
+	struct cvmx_gmxx_rxx_stats_pkts_drp_s cn31xx;
+	struct cvmx_gmxx_rxx_stats_pkts_drp_s cn38xx;
+	struct cvmx_gmxx_rxx_stats_pkts_drp_s cn38xxp2;
+	struct cvmx_gmxx_rxx_stats_pkts_drp_s cn50xx;
+	struct cvmx_gmxx_rxx_stats_pkts_drp_s cn52xx;
+	struct cvmx_gmxx_rxx_stats_pkts_drp_s cn52xxp1;
+	struct cvmx_gmxx_rxx_stats_pkts_drp_s cn56xx;
+	struct cvmx_gmxx_rxx_stats_pkts_drp_s cn56xxp1;
+	struct cvmx_gmxx_rxx_stats_pkts_drp_s cn58xx;
+	struct cvmx_gmxx_rxx_stats_pkts_drp_s cn58xxp1;
+} cvmx_gmxx_rxx_stats_pkts_drp_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rxx_udd_skp_s {
+		uint64_t reserved_9_63:55;
+		uint64_t fcssel:1;
+		uint64_t reserved_7_7:1;
+		uint64_t len:7;
+	} s;
+	struct cvmx_gmxx_rxx_udd_skp_s cn30xx;
+	struct cvmx_gmxx_rxx_udd_skp_s cn31xx;
+	struct cvmx_gmxx_rxx_udd_skp_s cn38xx;
+	struct cvmx_gmxx_rxx_udd_skp_s cn38xxp2;
+	struct cvmx_gmxx_rxx_udd_skp_s cn50xx;
+	struct cvmx_gmxx_rxx_udd_skp_s cn52xx;
+	struct cvmx_gmxx_rxx_udd_skp_s cn52xxp1;
+	struct cvmx_gmxx_rxx_udd_skp_s cn56xx;
+	struct cvmx_gmxx_rxx_udd_skp_s cn56xxp1;
+	struct cvmx_gmxx_rxx_udd_skp_s cn58xx;
+	struct cvmx_gmxx_rxx_udd_skp_s cn58xxp1;
+} cvmx_gmxx_rxx_udd_skp_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rx_bp_dropx_s {
+		uint64_t reserved_6_63:58;
+		uint64_t mark:6;
+	} s;
+	struct cvmx_gmxx_rx_bp_dropx_s cn30xx;
+	struct cvmx_gmxx_rx_bp_dropx_s cn31xx;
+	struct cvmx_gmxx_rx_bp_dropx_s cn38xx;
+	struct cvmx_gmxx_rx_bp_dropx_s cn38xxp2;
+	struct cvmx_gmxx_rx_bp_dropx_s cn50xx;
+	struct cvmx_gmxx_rx_bp_dropx_s cn52xx;
+	struct cvmx_gmxx_rx_bp_dropx_s cn52xxp1;
+	struct cvmx_gmxx_rx_bp_dropx_s cn56xx;
+	struct cvmx_gmxx_rx_bp_dropx_s cn56xxp1;
+	struct cvmx_gmxx_rx_bp_dropx_s cn58xx;
+	struct cvmx_gmxx_rx_bp_dropx_s cn58xxp1;
+} cvmx_gmxx_rx_bp_dropx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rx_bp_offx_s {
+		uint64_t reserved_6_63:58;
+		uint64_t mark:6;
+	} s;
+	struct cvmx_gmxx_rx_bp_offx_s cn30xx;
+	struct cvmx_gmxx_rx_bp_offx_s cn31xx;
+	struct cvmx_gmxx_rx_bp_offx_s cn38xx;
+	struct cvmx_gmxx_rx_bp_offx_s cn38xxp2;
+	struct cvmx_gmxx_rx_bp_offx_s cn50xx;
+	struct cvmx_gmxx_rx_bp_offx_s cn52xx;
+	struct cvmx_gmxx_rx_bp_offx_s cn52xxp1;
+	struct cvmx_gmxx_rx_bp_offx_s cn56xx;
+	struct cvmx_gmxx_rx_bp_offx_s cn56xxp1;
+	struct cvmx_gmxx_rx_bp_offx_s cn58xx;
+	struct cvmx_gmxx_rx_bp_offx_s cn58xxp1;
+} cvmx_gmxx_rx_bp_offx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rx_bp_onx_s {
+		uint64_t reserved_9_63:55;
+		uint64_t mark:9;
+	} s;
+	struct cvmx_gmxx_rx_bp_onx_s cn30xx;
+	struct cvmx_gmxx_rx_bp_onx_s cn31xx;
+	struct cvmx_gmxx_rx_bp_onx_s cn38xx;
+	struct cvmx_gmxx_rx_bp_onx_s cn38xxp2;
+	struct cvmx_gmxx_rx_bp_onx_s cn50xx;
+	struct cvmx_gmxx_rx_bp_onx_s cn52xx;
+	struct cvmx_gmxx_rx_bp_onx_s cn52xxp1;
+	struct cvmx_gmxx_rx_bp_onx_s cn56xx;
+	struct cvmx_gmxx_rx_bp_onx_s cn56xxp1;
+	struct cvmx_gmxx_rx_bp_onx_s cn58xx;
+	struct cvmx_gmxx_rx_bp_onx_s cn58xxp1;
+} cvmx_gmxx_rx_bp_onx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rx_hg2_status_s {
+		uint64_t reserved_48_63:16;
+		uint64_t phtim2go:16;
+		uint64_t xof:16;
+		uint64_t lgtim2go:16;
+	} s;
+	struct cvmx_gmxx_rx_hg2_status_s cn52xx;
+	struct cvmx_gmxx_rx_hg2_status_s cn52xxp1;
+	struct cvmx_gmxx_rx_hg2_status_s cn56xx;
+} cvmx_gmxx_rx_hg2_status_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rx_pass_en_s {
+		uint64_t reserved_16_63:48;
+		uint64_t en:16;
+	} s;
+	struct cvmx_gmxx_rx_pass_en_s cn38xx;
+	struct cvmx_gmxx_rx_pass_en_s cn38xxp2;
+	struct cvmx_gmxx_rx_pass_en_s cn58xx;
+	struct cvmx_gmxx_rx_pass_en_s cn58xxp1;
+} cvmx_gmxx_rx_pass_en_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rx_pass_mapx_s {
+		uint64_t reserved_4_63:60;
+		uint64_t dprt:4;
+	} s;
+	struct cvmx_gmxx_rx_pass_mapx_s cn38xx;
+	struct cvmx_gmxx_rx_pass_mapx_s cn38xxp2;
+	struct cvmx_gmxx_rx_pass_mapx_s cn58xx;
+	struct cvmx_gmxx_rx_pass_mapx_s cn58xxp1;
+} cvmx_gmxx_rx_pass_mapx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rx_prt_info_s {
+		uint64_t reserved_32_63:32;
+		uint64_t drop:16;
+		uint64_t commit:16;
+	} s;
+	struct cvmx_gmxx_rx_prt_info_cn30xx {
+		uint64_t reserved_19_63:45;
+		uint64_t drop:3;
+		uint64_t reserved_3_15:13;
+		uint64_t commit:3;
+	} cn30xx;
+	struct cvmx_gmxx_rx_prt_info_cn30xx cn31xx;
+	struct cvmx_gmxx_rx_prt_info_s cn38xx;
+	struct cvmx_gmxx_rx_prt_info_cn30xx cn50xx;
+	struct cvmx_gmxx_rx_prt_info_cn52xx {
+		uint64_t reserved_20_63:44;
+		uint64_t drop:4;
+		uint64_t reserved_4_15:12;
+		uint64_t commit:4;
+	} cn52xx;
+	struct cvmx_gmxx_rx_prt_info_cn52xx cn52xxp1;
+	struct cvmx_gmxx_rx_prt_info_cn52xx cn56xx;
+	struct cvmx_gmxx_rx_prt_info_cn52xx cn56xxp1;
+	struct cvmx_gmxx_rx_prt_info_s cn58xx;
+	struct cvmx_gmxx_rx_prt_info_s cn58xxp1;
+} cvmx_gmxx_rx_prt_info_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rx_prts_s {
+		uint64_t reserved_3_63:61;
+		uint64_t prts:3;
+	} s;
+	struct cvmx_gmxx_rx_prts_s cn30xx;
+	struct cvmx_gmxx_rx_prts_s cn31xx;
+	struct cvmx_gmxx_rx_prts_s cn38xx;
+	struct cvmx_gmxx_rx_prts_s cn38xxp2;
+	struct cvmx_gmxx_rx_prts_s cn50xx;
+	struct cvmx_gmxx_rx_prts_s cn52xx;
+	struct cvmx_gmxx_rx_prts_s cn52xxp1;
+	struct cvmx_gmxx_rx_prts_s cn56xx;
+	struct cvmx_gmxx_rx_prts_s cn56xxp1;
+	struct cvmx_gmxx_rx_prts_s cn58xx;
+	struct cvmx_gmxx_rx_prts_s cn58xxp1;
+} cvmx_gmxx_rx_prts_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rx_tx_status_s {
+		uint64_t reserved_7_63:57;
+		uint64_t tx:3;
+		uint64_t reserved_3_3:1;
+		uint64_t rx:3;
+	} s;
+	struct cvmx_gmxx_rx_tx_status_s cn30xx;
+	struct cvmx_gmxx_rx_tx_status_s cn31xx;
+	struct cvmx_gmxx_rx_tx_status_s cn50xx;
+} cvmx_gmxx_rx_tx_status_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rx_xaui_bad_col_s {
+		uint64_t reserved_40_63:24;
+		uint64_t val:1;
+		uint64_t state:3;
+		uint64_t lane_rxc:4;
+		uint64_t lane_rxd:32;
+	} s;
+	struct cvmx_gmxx_rx_xaui_bad_col_s cn52xx;
+	struct cvmx_gmxx_rx_xaui_bad_col_s cn52xxp1;
+	struct cvmx_gmxx_rx_xaui_bad_col_s cn56xx;
+	struct cvmx_gmxx_rx_xaui_bad_col_s cn56xxp1;
+} cvmx_gmxx_rx_xaui_bad_col_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_rx_xaui_ctl_s {
+		uint64_t reserved_2_63:62;
+		uint64_t status:2;
+	} s;
+	struct cvmx_gmxx_rx_xaui_ctl_s cn52xx;
+	struct cvmx_gmxx_rx_xaui_ctl_s cn52xxp1;
+	struct cvmx_gmxx_rx_xaui_ctl_s cn56xx;
+	struct cvmx_gmxx_rx_xaui_ctl_s cn56xxp1;
+} cvmx_gmxx_rx_xaui_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_smacx_s {
+		uint64_t reserved_48_63:16;
+		uint64_t smac:48;
+	} s;
+	struct cvmx_gmxx_smacx_s cn30xx;
+	struct cvmx_gmxx_smacx_s cn31xx;
+	struct cvmx_gmxx_smacx_s cn38xx;
+	struct cvmx_gmxx_smacx_s cn38xxp2;
+	struct cvmx_gmxx_smacx_s cn50xx;
+	struct cvmx_gmxx_smacx_s cn52xx;
+	struct cvmx_gmxx_smacx_s cn52xxp1;
+	struct cvmx_gmxx_smacx_s cn56xx;
+	struct cvmx_gmxx_smacx_s cn56xxp1;
+	struct cvmx_gmxx_smacx_s cn58xx;
+	struct cvmx_gmxx_smacx_s cn58xxp1;
+} cvmx_gmxx_smacx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_stat_bp_s {
+		uint64_t reserved_17_63:47;
+		uint64_t bp:1;
+		uint64_t cnt:16;
+	} s;
+	struct cvmx_gmxx_stat_bp_s cn30xx;
+	struct cvmx_gmxx_stat_bp_s cn31xx;
+	struct cvmx_gmxx_stat_bp_s cn38xx;
+	struct cvmx_gmxx_stat_bp_s cn38xxp2;
+	struct cvmx_gmxx_stat_bp_s cn50xx;
+	struct cvmx_gmxx_stat_bp_s cn52xx;
+	struct cvmx_gmxx_stat_bp_s cn52xxp1;
+	struct cvmx_gmxx_stat_bp_s cn56xx;
+	struct cvmx_gmxx_stat_bp_s cn56xxp1;
+	struct cvmx_gmxx_stat_bp_s cn58xx;
+	struct cvmx_gmxx_stat_bp_s cn58xxp1;
+} cvmx_gmxx_stat_bp_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_append_s {
+		uint64_t reserved_4_63:60;
+		uint64_t force_fcs:1;
+		uint64_t fcs:1;
+		uint64_t pad:1;
+		uint64_t preamble:1;
+	} s;
+	struct cvmx_gmxx_txx_append_s cn30xx;
+	struct cvmx_gmxx_txx_append_s cn31xx;
+	struct cvmx_gmxx_txx_append_s cn38xx;
+	struct cvmx_gmxx_txx_append_s cn38xxp2;
+	struct cvmx_gmxx_txx_append_s cn50xx;
+	struct cvmx_gmxx_txx_append_s cn52xx;
+	struct cvmx_gmxx_txx_append_s cn52xxp1;
+	struct cvmx_gmxx_txx_append_s cn56xx;
+	struct cvmx_gmxx_txx_append_s cn56xxp1;
+	struct cvmx_gmxx_txx_append_s cn58xx;
+	struct cvmx_gmxx_txx_append_s cn58xxp1;
+} cvmx_gmxx_txx_append_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_burst_s {
+		uint64_t reserved_16_63:48;
+		uint64_t burst:16;
+	} s;
+	struct cvmx_gmxx_txx_burst_s cn30xx;
+	struct cvmx_gmxx_txx_burst_s cn31xx;
+	struct cvmx_gmxx_txx_burst_s cn38xx;
+	struct cvmx_gmxx_txx_burst_s cn38xxp2;
+	struct cvmx_gmxx_txx_burst_s cn50xx;
+	struct cvmx_gmxx_txx_burst_s cn52xx;
+	struct cvmx_gmxx_txx_burst_s cn52xxp1;
+	struct cvmx_gmxx_txx_burst_s cn56xx;
+	struct cvmx_gmxx_txx_burst_s cn56xxp1;
+	struct cvmx_gmxx_txx_burst_s cn58xx;
+	struct cvmx_gmxx_txx_burst_s cn58xxp1;
+} cvmx_gmxx_txx_burst_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_cbfc_xoff_s {
+		uint64_t reserved_16_63:48;
+		uint64_t xoff:16;
+	} s;
+	struct cvmx_gmxx_txx_cbfc_xoff_s cn52xx;
+	struct cvmx_gmxx_txx_cbfc_xoff_s cn56xx;
+} cvmx_gmxx_txx_cbfc_xoff_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_cbfc_xon_s {
+		uint64_t reserved_16_63:48;
+		uint64_t xon:16;
+	} s;
+	struct cvmx_gmxx_txx_cbfc_xon_s cn52xx;
+	struct cvmx_gmxx_txx_cbfc_xon_s cn56xx;
+} cvmx_gmxx_txx_cbfc_xon_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_clk_s {
+		uint64_t reserved_6_63:58;
+		uint64_t clk_cnt:6;
+	} s;
+	struct cvmx_gmxx_txx_clk_s cn30xx;
+	struct cvmx_gmxx_txx_clk_s cn31xx;
+	struct cvmx_gmxx_txx_clk_s cn38xx;
+	struct cvmx_gmxx_txx_clk_s cn38xxp2;
+	struct cvmx_gmxx_txx_clk_s cn50xx;
+	struct cvmx_gmxx_txx_clk_s cn58xx;
+	struct cvmx_gmxx_txx_clk_s cn58xxp1;
+} cvmx_gmxx_txx_clk_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_ctl_s {
+		uint64_t reserved_2_63:62;
+		uint64_t xsdef_en:1;
+		uint64_t xscol_en:1;
+	} s;
+	struct cvmx_gmxx_txx_ctl_s cn30xx;
+	struct cvmx_gmxx_txx_ctl_s cn31xx;
+	struct cvmx_gmxx_txx_ctl_s cn38xx;
+	struct cvmx_gmxx_txx_ctl_s cn38xxp2;
+	struct cvmx_gmxx_txx_ctl_s cn50xx;
+	struct cvmx_gmxx_txx_ctl_s cn52xx;
+	struct cvmx_gmxx_txx_ctl_s cn52xxp1;
+	struct cvmx_gmxx_txx_ctl_s cn56xx;
+	struct cvmx_gmxx_txx_ctl_s cn56xxp1;
+	struct cvmx_gmxx_txx_ctl_s cn58xx;
+	struct cvmx_gmxx_txx_ctl_s cn58xxp1;
+} cvmx_gmxx_txx_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_min_pkt_s {
+		uint64_t reserved_8_63:56;
+		uint64_t min_size:8;
+	} s;
+	struct cvmx_gmxx_txx_min_pkt_s cn30xx;
+	struct cvmx_gmxx_txx_min_pkt_s cn31xx;
+	struct cvmx_gmxx_txx_min_pkt_s cn38xx;
+	struct cvmx_gmxx_txx_min_pkt_s cn38xxp2;
+	struct cvmx_gmxx_txx_min_pkt_s cn50xx;
+	struct cvmx_gmxx_txx_min_pkt_s cn52xx;
+	struct cvmx_gmxx_txx_min_pkt_s cn52xxp1;
+	struct cvmx_gmxx_txx_min_pkt_s cn56xx;
+	struct cvmx_gmxx_txx_min_pkt_s cn56xxp1;
+	struct cvmx_gmxx_txx_min_pkt_s cn58xx;
+	struct cvmx_gmxx_txx_min_pkt_s cn58xxp1;
+} cvmx_gmxx_txx_min_pkt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_pause_pkt_interval_s {
+		uint64_t reserved_16_63:48;
+		uint64_t interval:16;
+	} s;
+	struct cvmx_gmxx_txx_pause_pkt_interval_s cn30xx;
+	struct cvmx_gmxx_txx_pause_pkt_interval_s cn31xx;
+	struct cvmx_gmxx_txx_pause_pkt_interval_s cn38xx;
+	struct cvmx_gmxx_txx_pause_pkt_interval_s cn38xxp2;
+	struct cvmx_gmxx_txx_pause_pkt_interval_s cn50xx;
+	struct cvmx_gmxx_txx_pause_pkt_interval_s cn52xx;
+	struct cvmx_gmxx_txx_pause_pkt_interval_s cn52xxp1;
+	struct cvmx_gmxx_txx_pause_pkt_interval_s cn56xx;
+	struct cvmx_gmxx_txx_pause_pkt_interval_s cn56xxp1;
+	struct cvmx_gmxx_txx_pause_pkt_interval_s cn58xx;
+	struct cvmx_gmxx_txx_pause_pkt_interval_s cn58xxp1;
+} cvmx_gmxx_txx_pause_pkt_interval_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_pause_pkt_time_s {
+		uint64_t reserved_16_63:48;
+		uint64_t time:16;
+	} s;
+	struct cvmx_gmxx_txx_pause_pkt_time_s cn30xx;
+	struct cvmx_gmxx_txx_pause_pkt_time_s cn31xx;
+	struct cvmx_gmxx_txx_pause_pkt_time_s cn38xx;
+	struct cvmx_gmxx_txx_pause_pkt_time_s cn38xxp2;
+	struct cvmx_gmxx_txx_pause_pkt_time_s cn50xx;
+	struct cvmx_gmxx_txx_pause_pkt_time_s cn52xx;
+	struct cvmx_gmxx_txx_pause_pkt_time_s cn52xxp1;
+	struct cvmx_gmxx_txx_pause_pkt_time_s cn56xx;
+	struct cvmx_gmxx_txx_pause_pkt_time_s cn56xxp1;
+	struct cvmx_gmxx_txx_pause_pkt_time_s cn58xx;
+	struct cvmx_gmxx_txx_pause_pkt_time_s cn58xxp1;
+} cvmx_gmxx_txx_pause_pkt_time_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_pause_togo_s {
+		uint64_t reserved_32_63:32;
+		uint64_t msg_time:16;
+		uint64_t time:16;
+	} s;
+	struct cvmx_gmxx_txx_pause_togo_cn30xx {
+		uint64_t reserved_16_63:48;
+		uint64_t time:16;
+	} cn30xx;
+	struct cvmx_gmxx_txx_pause_togo_cn30xx cn31xx;
+	struct cvmx_gmxx_txx_pause_togo_cn30xx cn38xx;
+	struct cvmx_gmxx_txx_pause_togo_cn30xx cn38xxp2;
+	struct cvmx_gmxx_txx_pause_togo_cn30xx cn50xx;
+	struct cvmx_gmxx_txx_pause_togo_s cn52xx;
+	struct cvmx_gmxx_txx_pause_togo_s cn52xxp1;
+	struct cvmx_gmxx_txx_pause_togo_s cn56xx;
+	struct cvmx_gmxx_txx_pause_togo_cn30xx cn56xxp1;
+	struct cvmx_gmxx_txx_pause_togo_cn30xx cn58xx;
+	struct cvmx_gmxx_txx_pause_togo_cn30xx cn58xxp1;
+} cvmx_gmxx_txx_pause_togo_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_pause_zero_s {
+		uint64_t reserved_1_63:63;
+		uint64_t send:1;
+	} s;
+	struct cvmx_gmxx_txx_pause_zero_s cn30xx;
+	struct cvmx_gmxx_txx_pause_zero_s cn31xx;
+	struct cvmx_gmxx_txx_pause_zero_s cn38xx;
+	struct cvmx_gmxx_txx_pause_zero_s cn38xxp2;
+	struct cvmx_gmxx_txx_pause_zero_s cn50xx;
+	struct cvmx_gmxx_txx_pause_zero_s cn52xx;
+	struct cvmx_gmxx_txx_pause_zero_s cn52xxp1;
+	struct cvmx_gmxx_txx_pause_zero_s cn56xx;
+	struct cvmx_gmxx_txx_pause_zero_s cn56xxp1;
+	struct cvmx_gmxx_txx_pause_zero_s cn58xx;
+	struct cvmx_gmxx_txx_pause_zero_s cn58xxp1;
+} cvmx_gmxx_txx_pause_zero_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_sgmii_ctl_s {
+		uint64_t reserved_1_63:63;
+		uint64_t align:1;
+	} s;
+	struct cvmx_gmxx_txx_sgmii_ctl_s cn52xx;
+	struct cvmx_gmxx_txx_sgmii_ctl_s cn52xxp1;
+	struct cvmx_gmxx_txx_sgmii_ctl_s cn56xx;
+	struct cvmx_gmxx_txx_sgmii_ctl_s cn56xxp1;
+} cvmx_gmxx_txx_sgmii_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_slot_s {
+		uint64_t reserved_10_63:54;
+		uint64_t slot:10;
+	} s;
+	struct cvmx_gmxx_txx_slot_s cn30xx;
+	struct cvmx_gmxx_txx_slot_s cn31xx;
+	struct cvmx_gmxx_txx_slot_s cn38xx;
+	struct cvmx_gmxx_txx_slot_s cn38xxp2;
+	struct cvmx_gmxx_txx_slot_s cn50xx;
+	struct cvmx_gmxx_txx_slot_s cn52xx;
+	struct cvmx_gmxx_txx_slot_s cn52xxp1;
+	struct cvmx_gmxx_txx_slot_s cn56xx;
+	struct cvmx_gmxx_txx_slot_s cn56xxp1;
+	struct cvmx_gmxx_txx_slot_s cn58xx;
+	struct cvmx_gmxx_txx_slot_s cn58xxp1;
+} cvmx_gmxx_txx_slot_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_soft_pause_s {
+		uint64_t reserved_16_63:48;
+		uint64_t time:16;
+	} s;
+	struct cvmx_gmxx_txx_soft_pause_s cn30xx;
+	struct cvmx_gmxx_txx_soft_pause_s cn31xx;
+	struct cvmx_gmxx_txx_soft_pause_s cn38xx;
+	struct cvmx_gmxx_txx_soft_pause_s cn38xxp2;
+	struct cvmx_gmxx_txx_soft_pause_s cn50xx;
+	struct cvmx_gmxx_txx_soft_pause_s cn52xx;
+	struct cvmx_gmxx_txx_soft_pause_s cn52xxp1;
+	struct cvmx_gmxx_txx_soft_pause_s cn56xx;
+	struct cvmx_gmxx_txx_soft_pause_s cn56xxp1;
+	struct cvmx_gmxx_txx_soft_pause_s cn58xx;
+	struct cvmx_gmxx_txx_soft_pause_s cn58xxp1;
+} cvmx_gmxx_txx_soft_pause_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_stat0_s {
+		uint64_t xsdef:32;
+		uint64_t xscol:32;
+	} s;
+	struct cvmx_gmxx_txx_stat0_s cn30xx;
+	struct cvmx_gmxx_txx_stat0_s cn31xx;
+	struct cvmx_gmxx_txx_stat0_s cn38xx;
+	struct cvmx_gmxx_txx_stat0_s cn38xxp2;
+	struct cvmx_gmxx_txx_stat0_s cn50xx;
+	struct cvmx_gmxx_txx_stat0_s cn52xx;
+	struct cvmx_gmxx_txx_stat0_s cn52xxp1;
+	struct cvmx_gmxx_txx_stat0_s cn56xx;
+	struct cvmx_gmxx_txx_stat0_s cn56xxp1;
+	struct cvmx_gmxx_txx_stat0_s cn58xx;
+	struct cvmx_gmxx_txx_stat0_s cn58xxp1;
+} cvmx_gmxx_txx_stat0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_stat1_s {
+		uint64_t scol:32;
+		uint64_t mcol:32;
+	} s;
+	struct cvmx_gmxx_txx_stat1_s cn30xx;
+	struct cvmx_gmxx_txx_stat1_s cn31xx;
+	struct cvmx_gmxx_txx_stat1_s cn38xx;
+	struct cvmx_gmxx_txx_stat1_s cn38xxp2;
+	struct cvmx_gmxx_txx_stat1_s cn50xx;
+	struct cvmx_gmxx_txx_stat1_s cn52xx;
+	struct cvmx_gmxx_txx_stat1_s cn52xxp1;
+	struct cvmx_gmxx_txx_stat1_s cn56xx;
+	struct cvmx_gmxx_txx_stat1_s cn56xxp1;
+	struct cvmx_gmxx_txx_stat1_s cn58xx;
+	struct cvmx_gmxx_txx_stat1_s cn58xxp1;
+} cvmx_gmxx_txx_stat1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_stat2_s {
+		uint64_t reserved_48_63:16;
+		uint64_t octs:48;
+	} s;
+	struct cvmx_gmxx_txx_stat2_s cn30xx;
+	struct cvmx_gmxx_txx_stat2_s cn31xx;
+	struct cvmx_gmxx_txx_stat2_s cn38xx;
+	struct cvmx_gmxx_txx_stat2_s cn38xxp2;
+	struct cvmx_gmxx_txx_stat2_s cn50xx;
+	struct cvmx_gmxx_txx_stat2_s cn52xx;
+	struct cvmx_gmxx_txx_stat2_s cn52xxp1;
+	struct cvmx_gmxx_txx_stat2_s cn56xx;
+	struct cvmx_gmxx_txx_stat2_s cn56xxp1;
+	struct cvmx_gmxx_txx_stat2_s cn58xx;
+	struct cvmx_gmxx_txx_stat2_s cn58xxp1;
+} cvmx_gmxx_txx_stat2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_stat3_s {
+		uint64_t reserved_32_63:32;
+		uint64_t pkts:32;
+	} s;
+	struct cvmx_gmxx_txx_stat3_s cn30xx;
+	struct cvmx_gmxx_txx_stat3_s cn31xx;
+	struct cvmx_gmxx_txx_stat3_s cn38xx;
+	struct cvmx_gmxx_txx_stat3_s cn38xxp2;
+	struct cvmx_gmxx_txx_stat3_s cn50xx;
+	struct cvmx_gmxx_txx_stat3_s cn52xx;
+	struct cvmx_gmxx_txx_stat3_s cn52xxp1;
+	struct cvmx_gmxx_txx_stat3_s cn56xx;
+	struct cvmx_gmxx_txx_stat3_s cn56xxp1;
+	struct cvmx_gmxx_txx_stat3_s cn58xx;
+	struct cvmx_gmxx_txx_stat3_s cn58xxp1;
+} cvmx_gmxx_txx_stat3_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_stat4_s {
+		uint64_t hist1:32;
+		uint64_t hist0:32;
+	} s;
+	struct cvmx_gmxx_txx_stat4_s cn30xx;
+	struct cvmx_gmxx_txx_stat4_s cn31xx;
+	struct cvmx_gmxx_txx_stat4_s cn38xx;
+	struct cvmx_gmxx_txx_stat4_s cn38xxp2;
+	struct cvmx_gmxx_txx_stat4_s cn50xx;
+	struct cvmx_gmxx_txx_stat4_s cn52xx;
+	struct cvmx_gmxx_txx_stat4_s cn52xxp1;
+	struct cvmx_gmxx_txx_stat4_s cn56xx;
+	struct cvmx_gmxx_txx_stat4_s cn56xxp1;
+	struct cvmx_gmxx_txx_stat4_s cn58xx;
+	struct cvmx_gmxx_txx_stat4_s cn58xxp1;
+} cvmx_gmxx_txx_stat4_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_stat5_s {
+		uint64_t hist3:32;
+		uint64_t hist2:32;
+	} s;
+	struct cvmx_gmxx_txx_stat5_s cn30xx;
+	struct cvmx_gmxx_txx_stat5_s cn31xx;
+	struct cvmx_gmxx_txx_stat5_s cn38xx;
+	struct cvmx_gmxx_txx_stat5_s cn38xxp2;
+	struct cvmx_gmxx_txx_stat5_s cn50xx;
+	struct cvmx_gmxx_txx_stat5_s cn52xx;
+	struct cvmx_gmxx_txx_stat5_s cn52xxp1;
+	struct cvmx_gmxx_txx_stat5_s cn56xx;
+	struct cvmx_gmxx_txx_stat5_s cn56xxp1;
+	struct cvmx_gmxx_txx_stat5_s cn58xx;
+	struct cvmx_gmxx_txx_stat5_s cn58xxp1;
+} cvmx_gmxx_txx_stat5_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_stat6_s {
+		uint64_t hist5:32;
+		uint64_t hist4:32;
+	} s;
+	struct cvmx_gmxx_txx_stat6_s cn30xx;
+	struct cvmx_gmxx_txx_stat6_s cn31xx;
+	struct cvmx_gmxx_txx_stat6_s cn38xx;
+	struct cvmx_gmxx_txx_stat6_s cn38xxp2;
+	struct cvmx_gmxx_txx_stat6_s cn50xx;
+	struct cvmx_gmxx_txx_stat6_s cn52xx;
+	struct cvmx_gmxx_txx_stat6_s cn52xxp1;
+	struct cvmx_gmxx_txx_stat6_s cn56xx;
+	struct cvmx_gmxx_txx_stat6_s cn56xxp1;
+	struct cvmx_gmxx_txx_stat6_s cn58xx;
+	struct cvmx_gmxx_txx_stat6_s cn58xxp1;
+} cvmx_gmxx_txx_stat6_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_stat7_s {
+		uint64_t hist7:32;
+		uint64_t hist6:32;
+	} s;
+	struct cvmx_gmxx_txx_stat7_s cn30xx;
+	struct cvmx_gmxx_txx_stat7_s cn31xx;
+	struct cvmx_gmxx_txx_stat7_s cn38xx;
+	struct cvmx_gmxx_txx_stat7_s cn38xxp2;
+	struct cvmx_gmxx_txx_stat7_s cn50xx;
+	struct cvmx_gmxx_txx_stat7_s cn52xx;
+	struct cvmx_gmxx_txx_stat7_s cn52xxp1;
+	struct cvmx_gmxx_txx_stat7_s cn56xx;
+	struct cvmx_gmxx_txx_stat7_s cn56xxp1;
+	struct cvmx_gmxx_txx_stat7_s cn58xx;
+	struct cvmx_gmxx_txx_stat7_s cn58xxp1;
+} cvmx_gmxx_txx_stat7_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_stat8_s {
+		uint64_t mcst:32;
+		uint64_t bcst:32;
+	} s;
+	struct cvmx_gmxx_txx_stat8_s cn30xx;
+	struct cvmx_gmxx_txx_stat8_s cn31xx;
+	struct cvmx_gmxx_txx_stat8_s cn38xx;
+	struct cvmx_gmxx_txx_stat8_s cn38xxp2;
+	struct cvmx_gmxx_txx_stat8_s cn50xx;
+	struct cvmx_gmxx_txx_stat8_s cn52xx;
+	struct cvmx_gmxx_txx_stat8_s cn52xxp1;
+	struct cvmx_gmxx_txx_stat8_s cn56xx;
+	struct cvmx_gmxx_txx_stat8_s cn56xxp1;
+	struct cvmx_gmxx_txx_stat8_s cn58xx;
+	struct cvmx_gmxx_txx_stat8_s cn58xxp1;
+} cvmx_gmxx_txx_stat8_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_stat9_s {
+		uint64_t undflw:32;
+		uint64_t ctl:32;
+	} s;
+	struct cvmx_gmxx_txx_stat9_s cn30xx;
+	struct cvmx_gmxx_txx_stat9_s cn31xx;
+	struct cvmx_gmxx_txx_stat9_s cn38xx;
+	struct cvmx_gmxx_txx_stat9_s cn38xxp2;
+	struct cvmx_gmxx_txx_stat9_s cn50xx;
+	struct cvmx_gmxx_txx_stat9_s cn52xx;
+	struct cvmx_gmxx_txx_stat9_s cn52xxp1;
+	struct cvmx_gmxx_txx_stat9_s cn56xx;
+	struct cvmx_gmxx_txx_stat9_s cn56xxp1;
+	struct cvmx_gmxx_txx_stat9_s cn58xx;
+	struct cvmx_gmxx_txx_stat9_s cn58xxp1;
+} cvmx_gmxx_txx_stat9_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_stats_ctl_s {
+		uint64_t reserved_1_63:63;
+		uint64_t rd_clr:1;
+	} s;
+	struct cvmx_gmxx_txx_stats_ctl_s cn30xx;
+	struct cvmx_gmxx_txx_stats_ctl_s cn31xx;
+	struct cvmx_gmxx_txx_stats_ctl_s cn38xx;
+	struct cvmx_gmxx_txx_stats_ctl_s cn38xxp2;
+	struct cvmx_gmxx_txx_stats_ctl_s cn50xx;
+	struct cvmx_gmxx_txx_stats_ctl_s cn52xx;
+	struct cvmx_gmxx_txx_stats_ctl_s cn52xxp1;
+	struct cvmx_gmxx_txx_stats_ctl_s cn56xx;
+	struct cvmx_gmxx_txx_stats_ctl_s cn56xxp1;
+	struct cvmx_gmxx_txx_stats_ctl_s cn58xx;
+	struct cvmx_gmxx_txx_stats_ctl_s cn58xxp1;
+} cvmx_gmxx_txx_stats_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_txx_thresh_s {
+		uint64_t reserved_9_63:55;
+		uint64_t cnt:9;
+	} s;
+	struct cvmx_gmxx_txx_thresh_cn30xx {
+		uint64_t reserved_7_63:57;
+		uint64_t cnt:7;
+	} cn30xx;
+	struct cvmx_gmxx_txx_thresh_cn30xx cn31xx;
+	struct cvmx_gmxx_txx_thresh_s cn38xx;
+	struct cvmx_gmxx_txx_thresh_s cn38xxp2;
+	struct cvmx_gmxx_txx_thresh_cn30xx cn50xx;
+	struct cvmx_gmxx_txx_thresh_s cn52xx;
+	struct cvmx_gmxx_txx_thresh_s cn52xxp1;
+	struct cvmx_gmxx_txx_thresh_s cn56xx;
+	struct cvmx_gmxx_txx_thresh_s cn56xxp1;
+	struct cvmx_gmxx_txx_thresh_s cn58xx;
+	struct cvmx_gmxx_txx_thresh_s cn58xxp1;
+} cvmx_gmxx_txx_thresh_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_bp_s {
+		uint64_t reserved_4_63:60;
+		uint64_t bp:4;
+	} s;
+	struct cvmx_gmxx_tx_bp_cn30xx {
+		uint64_t reserved_3_63:61;
+		uint64_t bp:3;
+	} cn30xx;
+	struct cvmx_gmxx_tx_bp_cn30xx cn31xx;
+	struct cvmx_gmxx_tx_bp_s cn38xx;
+	struct cvmx_gmxx_tx_bp_s cn38xxp2;
+	struct cvmx_gmxx_tx_bp_cn30xx cn50xx;
+	struct cvmx_gmxx_tx_bp_s cn52xx;
+	struct cvmx_gmxx_tx_bp_s cn52xxp1;
+	struct cvmx_gmxx_tx_bp_s cn56xx;
+	struct cvmx_gmxx_tx_bp_s cn56xxp1;
+	struct cvmx_gmxx_tx_bp_s cn58xx;
+	struct cvmx_gmxx_tx_bp_s cn58xxp1;
+} cvmx_gmxx_tx_bp_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_clk_mskx_s {
+		uint64_t reserved_1_63:63;
+		uint64_t msk:1;
+	} s;
+	struct cvmx_gmxx_tx_clk_mskx_s cn30xx;
+	struct cvmx_gmxx_tx_clk_mskx_s cn50xx;
+} cvmx_gmxx_tx_clk_mskx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_col_attempt_s {
+		uint64_t reserved_5_63:59;
+		uint64_t limit:5;
+	} s;
+	struct cvmx_gmxx_tx_col_attempt_s cn30xx;
+	struct cvmx_gmxx_tx_col_attempt_s cn31xx;
+	struct cvmx_gmxx_tx_col_attempt_s cn38xx;
+	struct cvmx_gmxx_tx_col_attempt_s cn38xxp2;
+	struct cvmx_gmxx_tx_col_attempt_s cn50xx;
+	struct cvmx_gmxx_tx_col_attempt_s cn52xx;
+	struct cvmx_gmxx_tx_col_attempt_s cn52xxp1;
+	struct cvmx_gmxx_tx_col_attempt_s cn56xx;
+	struct cvmx_gmxx_tx_col_attempt_s cn56xxp1;
+	struct cvmx_gmxx_tx_col_attempt_s cn58xx;
+	struct cvmx_gmxx_tx_col_attempt_s cn58xxp1;
+} cvmx_gmxx_tx_col_attempt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_corrupt_s {
+		uint64_t reserved_4_63:60;
+		uint64_t corrupt:4;
+	} s;
+	struct cvmx_gmxx_tx_corrupt_cn30xx {
+		uint64_t reserved_3_63:61;
+		uint64_t corrupt:3;
+	} cn30xx;
+	struct cvmx_gmxx_tx_corrupt_cn30xx cn31xx;
+	struct cvmx_gmxx_tx_corrupt_s cn38xx;
+	struct cvmx_gmxx_tx_corrupt_s cn38xxp2;
+	struct cvmx_gmxx_tx_corrupt_cn30xx cn50xx;
+	struct cvmx_gmxx_tx_corrupt_s cn52xx;
+	struct cvmx_gmxx_tx_corrupt_s cn52xxp1;
+	struct cvmx_gmxx_tx_corrupt_s cn56xx;
+	struct cvmx_gmxx_tx_corrupt_s cn56xxp1;
+	struct cvmx_gmxx_tx_corrupt_s cn58xx;
+	struct cvmx_gmxx_tx_corrupt_s cn58xxp1;
+} cvmx_gmxx_tx_corrupt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_hg2_reg1_s {
+		uint64_t reserved_16_63:48;
+		uint64_t tx_xof:16;
+	} s;
+	struct cvmx_gmxx_tx_hg2_reg1_s cn52xx;
+	struct cvmx_gmxx_tx_hg2_reg1_s cn52xxp1;
+	struct cvmx_gmxx_tx_hg2_reg1_s cn56xx;
+} cvmx_gmxx_tx_hg2_reg1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_hg2_reg2_s {
+		uint64_t reserved_16_63:48;
+		uint64_t tx_xon:16;
+	} s;
+	struct cvmx_gmxx_tx_hg2_reg2_s cn52xx;
+	struct cvmx_gmxx_tx_hg2_reg2_s cn52xxp1;
+	struct cvmx_gmxx_tx_hg2_reg2_s cn56xx;
+} cvmx_gmxx_tx_hg2_reg2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_ifg_s {
+		uint64_t reserved_8_63:56;
+		uint64_t ifg2:4;
+		uint64_t ifg1:4;
+	} s;
+	struct cvmx_gmxx_tx_ifg_s cn30xx;
+	struct cvmx_gmxx_tx_ifg_s cn31xx;
+	struct cvmx_gmxx_tx_ifg_s cn38xx;
+	struct cvmx_gmxx_tx_ifg_s cn38xxp2;
+	struct cvmx_gmxx_tx_ifg_s cn50xx;
+	struct cvmx_gmxx_tx_ifg_s cn52xx;
+	struct cvmx_gmxx_tx_ifg_s cn52xxp1;
+	struct cvmx_gmxx_tx_ifg_s cn56xx;
+	struct cvmx_gmxx_tx_ifg_s cn56xxp1;
+	struct cvmx_gmxx_tx_ifg_s cn58xx;
+	struct cvmx_gmxx_tx_ifg_s cn58xxp1;
+} cvmx_gmxx_tx_ifg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_int_en_s {
+		uint64_t reserved_20_63:44;
+		uint64_t late_col:4;
+		uint64_t xsdef:4;
+		uint64_t xscol:4;
+		uint64_t reserved_6_7:2;
+		uint64_t undflw:4;
+		uint64_t ncb_nxa:1;
+		uint64_t pko_nxa:1;
+	} s;
+	struct cvmx_gmxx_tx_int_en_cn30xx {
+		uint64_t reserved_19_63:45;
+		uint64_t late_col:3;
+		uint64_t reserved_15_15:1;
+		uint64_t xsdef:3;
+		uint64_t reserved_11_11:1;
+		uint64_t xscol:3;
+		uint64_t reserved_5_7:3;
+		uint64_t undflw:3;
+		uint64_t reserved_1_1:1;
+		uint64_t pko_nxa:1;
+	} cn30xx;
+	struct cvmx_gmxx_tx_int_en_cn31xx {
+		uint64_t reserved_15_63:49;
+		uint64_t xsdef:3;
+		uint64_t reserved_11_11:1;
+		uint64_t xscol:3;
+		uint64_t reserved_5_7:3;
+		uint64_t undflw:3;
+		uint64_t reserved_1_1:1;
+		uint64_t pko_nxa:1;
+	} cn31xx;
+	struct cvmx_gmxx_tx_int_en_s cn38xx;
+	struct cvmx_gmxx_tx_int_en_cn38xxp2 {
+		uint64_t reserved_16_63:48;
+		uint64_t xsdef:4;
+		uint64_t xscol:4;
+		uint64_t reserved_6_7:2;
+		uint64_t undflw:4;
+		uint64_t ncb_nxa:1;
+		uint64_t pko_nxa:1;
+	} cn38xxp2;
+	struct cvmx_gmxx_tx_int_en_cn30xx cn50xx;
+	struct cvmx_gmxx_tx_int_en_cn52xx {
+		uint64_t reserved_20_63:44;
+		uint64_t late_col:4;
+		uint64_t xsdef:4;
+		uint64_t xscol:4;
+		uint64_t reserved_6_7:2;
+		uint64_t undflw:4;
+		uint64_t reserved_1_1:1;
+		uint64_t pko_nxa:1;
+	} cn52xx;
+	struct cvmx_gmxx_tx_int_en_cn52xx cn52xxp1;
+	struct cvmx_gmxx_tx_int_en_cn52xx cn56xx;
+	struct cvmx_gmxx_tx_int_en_cn52xx cn56xxp1;
+	struct cvmx_gmxx_tx_int_en_s cn58xx;
+	struct cvmx_gmxx_tx_int_en_s cn58xxp1;
+} cvmx_gmxx_tx_int_en_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_int_reg_s {
+		uint64_t reserved_20_63:44;
+		uint64_t late_col:4;
+		uint64_t xsdef:4;
+		uint64_t xscol:4;
+		uint64_t reserved_6_7:2;
+		uint64_t undflw:4;
+		uint64_t ncb_nxa:1;
+		uint64_t pko_nxa:1;
+	} s;
+	struct cvmx_gmxx_tx_int_reg_cn30xx {
+		uint64_t reserved_19_63:45;
+		uint64_t late_col:3;
+		uint64_t reserved_15_15:1;
+		uint64_t xsdef:3;
+		uint64_t reserved_11_11:1;
+		uint64_t xscol:3;
+		uint64_t reserved_5_7:3;
+		uint64_t undflw:3;
+		uint64_t reserved_1_1:1;
+		uint64_t pko_nxa:1;
+	} cn30xx;
+	struct cvmx_gmxx_tx_int_reg_cn31xx {
+		uint64_t reserved_15_63:49;
+		uint64_t xsdef:3;
+		uint64_t reserved_11_11:1;
+		uint64_t xscol:3;
+		uint64_t reserved_5_7:3;
+		uint64_t undflw:3;
+		uint64_t reserved_1_1:1;
+		uint64_t pko_nxa:1;
+	} cn31xx;
+	struct cvmx_gmxx_tx_int_reg_s cn38xx;
+	struct cvmx_gmxx_tx_int_reg_cn38xxp2 {
+		uint64_t reserved_16_63:48;
+		uint64_t xsdef:4;
+		uint64_t xscol:4;
+		uint64_t reserved_6_7:2;
+		uint64_t undflw:4;
+		uint64_t ncb_nxa:1;
+		uint64_t pko_nxa:1;
+	} cn38xxp2;
+	struct cvmx_gmxx_tx_int_reg_cn30xx cn50xx;
+	struct cvmx_gmxx_tx_int_reg_cn52xx {
+		uint64_t reserved_20_63:44;
+		uint64_t late_col:4;
+		uint64_t xsdef:4;
+		uint64_t xscol:4;
+		uint64_t reserved_6_7:2;
+		uint64_t undflw:4;
+		uint64_t reserved_1_1:1;
+		uint64_t pko_nxa:1;
+	} cn52xx;
+	struct cvmx_gmxx_tx_int_reg_cn52xx cn52xxp1;
+	struct cvmx_gmxx_tx_int_reg_cn52xx cn56xx;
+	struct cvmx_gmxx_tx_int_reg_cn52xx cn56xxp1;
+	struct cvmx_gmxx_tx_int_reg_s cn58xx;
+	struct cvmx_gmxx_tx_int_reg_s cn58xxp1;
+} cvmx_gmxx_tx_int_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_jam_s {
+		uint64_t reserved_8_63:56;
+		uint64_t jam:8;
+	} s;
+	struct cvmx_gmxx_tx_jam_s cn30xx;
+	struct cvmx_gmxx_tx_jam_s cn31xx;
+	struct cvmx_gmxx_tx_jam_s cn38xx;
+	struct cvmx_gmxx_tx_jam_s cn38xxp2;
+	struct cvmx_gmxx_tx_jam_s cn50xx;
+	struct cvmx_gmxx_tx_jam_s cn52xx;
+	struct cvmx_gmxx_tx_jam_s cn52xxp1;
+	struct cvmx_gmxx_tx_jam_s cn56xx;
+	struct cvmx_gmxx_tx_jam_s cn56xxp1;
+	struct cvmx_gmxx_tx_jam_s cn58xx;
+	struct cvmx_gmxx_tx_jam_s cn58xxp1;
+} cvmx_gmxx_tx_jam_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_lfsr_s {
+		uint64_t reserved_16_63:48;
+		uint64_t lfsr:16;
+	} s;
+	struct cvmx_gmxx_tx_lfsr_s cn30xx;
+	struct cvmx_gmxx_tx_lfsr_s cn31xx;
+	struct cvmx_gmxx_tx_lfsr_s cn38xx;
+	struct cvmx_gmxx_tx_lfsr_s cn38xxp2;
+	struct cvmx_gmxx_tx_lfsr_s cn50xx;
+	struct cvmx_gmxx_tx_lfsr_s cn52xx;
+	struct cvmx_gmxx_tx_lfsr_s cn52xxp1;
+	struct cvmx_gmxx_tx_lfsr_s cn56xx;
+	struct cvmx_gmxx_tx_lfsr_s cn56xxp1;
+	struct cvmx_gmxx_tx_lfsr_s cn58xx;
+	struct cvmx_gmxx_tx_lfsr_s cn58xxp1;
+} cvmx_gmxx_tx_lfsr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_ovr_bp_s {
+		uint64_t reserved_48_63:16;
+		uint64_t tx_prt_bp:16;
+		uint64_t reserved_12_31:20;
+		uint64_t en:4;
+		uint64_t bp:4;
+		uint64_t ign_full:4;
+	} s;
+	struct cvmx_gmxx_tx_ovr_bp_cn30xx {
+		uint64_t reserved_11_63:53;
+		uint64_t en:3;
+		uint64_t reserved_7_7:1;
+		uint64_t bp:3;
+		uint64_t reserved_3_3:1;
+		uint64_t ign_full:3;
+	} cn30xx;
+	struct cvmx_gmxx_tx_ovr_bp_cn30xx cn31xx;
+	struct cvmx_gmxx_tx_ovr_bp_cn38xx {
+		uint64_t reserved_12_63:52;
+		uint64_t en:4;
+		uint64_t bp:4;
+		uint64_t ign_full:4;
+	} cn38xx;
+	struct cvmx_gmxx_tx_ovr_bp_cn38xx cn38xxp2;
+	struct cvmx_gmxx_tx_ovr_bp_cn30xx cn50xx;
+	struct cvmx_gmxx_tx_ovr_bp_s cn52xx;
+	struct cvmx_gmxx_tx_ovr_bp_s cn52xxp1;
+	struct cvmx_gmxx_tx_ovr_bp_s cn56xx;
+	struct cvmx_gmxx_tx_ovr_bp_s cn56xxp1;
+	struct cvmx_gmxx_tx_ovr_bp_cn38xx cn58xx;
+	struct cvmx_gmxx_tx_ovr_bp_cn38xx cn58xxp1;
+} cvmx_gmxx_tx_ovr_bp_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_pause_pkt_dmac_s {
+		uint64_t reserved_48_63:16;
+		uint64_t dmac:48;
+	} s;
+	struct cvmx_gmxx_tx_pause_pkt_dmac_s cn30xx;
+	struct cvmx_gmxx_tx_pause_pkt_dmac_s cn31xx;
+	struct cvmx_gmxx_tx_pause_pkt_dmac_s cn38xx;
+	struct cvmx_gmxx_tx_pause_pkt_dmac_s cn38xxp2;
+	struct cvmx_gmxx_tx_pause_pkt_dmac_s cn50xx;
+	struct cvmx_gmxx_tx_pause_pkt_dmac_s cn52xx;
+	struct cvmx_gmxx_tx_pause_pkt_dmac_s cn52xxp1;
+	struct cvmx_gmxx_tx_pause_pkt_dmac_s cn56xx;
+	struct cvmx_gmxx_tx_pause_pkt_dmac_s cn56xxp1;
+	struct cvmx_gmxx_tx_pause_pkt_dmac_s cn58xx;
+	struct cvmx_gmxx_tx_pause_pkt_dmac_s cn58xxp1;
+} cvmx_gmxx_tx_pause_pkt_dmac_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_pause_pkt_type_s {
+		uint64_t reserved_16_63:48;
+		uint64_t type:16;
+	} s;
+	struct cvmx_gmxx_tx_pause_pkt_type_s cn30xx;
+	struct cvmx_gmxx_tx_pause_pkt_type_s cn31xx;
+	struct cvmx_gmxx_tx_pause_pkt_type_s cn38xx;
+	struct cvmx_gmxx_tx_pause_pkt_type_s cn38xxp2;
+	struct cvmx_gmxx_tx_pause_pkt_type_s cn50xx;
+	struct cvmx_gmxx_tx_pause_pkt_type_s cn52xx;
+	struct cvmx_gmxx_tx_pause_pkt_type_s cn52xxp1;
+	struct cvmx_gmxx_tx_pause_pkt_type_s cn56xx;
+	struct cvmx_gmxx_tx_pause_pkt_type_s cn56xxp1;
+	struct cvmx_gmxx_tx_pause_pkt_type_s cn58xx;
+	struct cvmx_gmxx_tx_pause_pkt_type_s cn58xxp1;
+} cvmx_gmxx_tx_pause_pkt_type_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_prts_s {
+		uint64_t reserved_5_63:59;
+		uint64_t prts:5;
+	} s;
+	struct cvmx_gmxx_tx_prts_s cn30xx;
+	struct cvmx_gmxx_tx_prts_s cn31xx;
+	struct cvmx_gmxx_tx_prts_s cn38xx;
+	struct cvmx_gmxx_tx_prts_s cn38xxp2;
+	struct cvmx_gmxx_tx_prts_s cn50xx;
+	struct cvmx_gmxx_tx_prts_s cn52xx;
+	struct cvmx_gmxx_tx_prts_s cn52xxp1;
+	struct cvmx_gmxx_tx_prts_s cn56xx;
+	struct cvmx_gmxx_tx_prts_s cn56xxp1;
+	struct cvmx_gmxx_tx_prts_s cn58xx;
+	struct cvmx_gmxx_tx_prts_s cn58xxp1;
+} cvmx_gmxx_tx_prts_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_spi_ctl_s {
+		uint64_t reserved_2_63:62;
+		uint64_t tpa_clr:1;
+		uint64_t cont_pkt:1;
+	} s;
+	struct cvmx_gmxx_tx_spi_ctl_s cn38xx;
+	struct cvmx_gmxx_tx_spi_ctl_s cn38xxp2;
+	struct cvmx_gmxx_tx_spi_ctl_s cn58xx;
+	struct cvmx_gmxx_tx_spi_ctl_s cn58xxp1;
+} cvmx_gmxx_tx_spi_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_spi_drain_s {
+		uint64_t reserved_16_63:48;
+		uint64_t drain:16;
+	} s;
+	struct cvmx_gmxx_tx_spi_drain_s cn38xx;
+	struct cvmx_gmxx_tx_spi_drain_s cn58xx;
+	struct cvmx_gmxx_tx_spi_drain_s cn58xxp1;
+} cvmx_gmxx_tx_spi_drain_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_spi_max_s {
+		uint64_t reserved_23_63:41;
+		uint64_t slice:7;
+		uint64_t max2:8;
+		uint64_t max1:8;
+	} s;
+	struct cvmx_gmxx_tx_spi_max_cn38xx {
+		uint64_t reserved_16_63:48;
+		uint64_t max2:8;
+		uint64_t max1:8;
+	} cn38xx;
+	struct cvmx_gmxx_tx_spi_max_cn38xx cn38xxp2;
+	struct cvmx_gmxx_tx_spi_max_s cn58xx;
+	struct cvmx_gmxx_tx_spi_max_s cn58xxp1;
+} cvmx_gmxx_tx_spi_max_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_spi_roundx_s {
+		uint64_t reserved_16_63:48;
+		uint64_t round:16;
+	} s;
+	struct cvmx_gmxx_tx_spi_roundx_s cn58xx;
+	struct cvmx_gmxx_tx_spi_roundx_s cn58xxp1;
+} cvmx_gmxx_tx_spi_roundx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_spi_thresh_s {
+		uint64_t reserved_6_63:58;
+		uint64_t thresh:6;
+	} s;
+	struct cvmx_gmxx_tx_spi_thresh_s cn38xx;
+	struct cvmx_gmxx_tx_spi_thresh_s cn38xxp2;
+	struct cvmx_gmxx_tx_spi_thresh_s cn58xx;
+	struct cvmx_gmxx_tx_spi_thresh_s cn58xxp1;
+} cvmx_gmxx_tx_spi_thresh_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_tx_xaui_ctl_s {
+		uint64_t reserved_11_63:53;
+		uint64_t hg_pause_hgi:2;
+		uint64_t hg_en:1;
+		uint64_t reserved_7_7:1;
+		uint64_t ls_byp:1;
+		uint64_t ls:2;
+		uint64_t reserved_2_3:2;
+		uint64_t uni_en:1;
+		uint64_t dic_en:1;
+	} s;
+	struct cvmx_gmxx_tx_xaui_ctl_s cn52xx;
+	struct cvmx_gmxx_tx_xaui_ctl_s cn52xxp1;
+	struct cvmx_gmxx_tx_xaui_ctl_s cn56xx;
+	struct cvmx_gmxx_tx_xaui_ctl_s cn56xxp1;
+} cvmx_gmxx_tx_xaui_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gmxx_xaui_ext_loopback_s {
+		uint64_t reserved_5_63:59;
+		uint64_t en:1;
+		uint64_t thresh:4;
+	} s;
+	struct cvmx_gmxx_xaui_ext_loopback_s cn52xx;
+	struct cvmx_gmxx_xaui_ext_loopback_s cn52xxp1;
+	struct cvmx_gmxx_xaui_ext_loopback_s cn56xx;
+	struct cvmx_gmxx_xaui_ext_loopback_s cn56xxp1;
+} cvmx_gmxx_xaui_ext_loopback_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gpio_bit_cfgx_s {
+		uint64_t reserved_15_63:49;
+		uint64_t clk_gen:1;
+		uint64_t clk_sel:2;
+		uint64_t fil_sel:4;
+		uint64_t fil_cnt:4;
+		uint64_t int_type:1;
+		uint64_t int_en:1;
+		uint64_t rx_xor:1;
+		uint64_t tx_oe:1;
+	} s;
+	struct cvmx_gpio_bit_cfgx_cn30xx {
+		uint64_t reserved_12_63:52;
+		uint64_t fil_sel:4;
+		uint64_t fil_cnt:4;
+		uint64_t int_type:1;
+		uint64_t int_en:1;
+		uint64_t rx_xor:1;
+		uint64_t tx_oe:1;
+	} cn30xx;
+	struct cvmx_gpio_bit_cfgx_cn30xx cn31xx;
+	struct cvmx_gpio_bit_cfgx_cn30xx cn38xx;
+	struct cvmx_gpio_bit_cfgx_cn30xx cn38xxp2;
+	struct cvmx_gpio_bit_cfgx_cn30xx cn50xx;
+	struct cvmx_gpio_bit_cfgx_s cn52xx;
+	struct cvmx_gpio_bit_cfgx_s cn52xxp1;
+	struct cvmx_gpio_bit_cfgx_s cn56xx;
+	struct cvmx_gpio_bit_cfgx_s cn56xxp1;
+	struct cvmx_gpio_bit_cfgx_cn30xx cn58xx;
+	struct cvmx_gpio_bit_cfgx_cn30xx cn58xxp1;
+} cvmx_gpio_bit_cfgx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gpio_boot_ena_s {
+		uint64_t reserved_12_63:52;
+		uint64_t boot_ena:4;
+		uint64_t reserved_0_7:8;
+	} s;
+	struct cvmx_gpio_boot_ena_s cn30xx;
+	struct cvmx_gpio_boot_ena_s cn31xx;
+	struct cvmx_gpio_boot_ena_s cn50xx;
+} cvmx_gpio_boot_ena_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gpio_clk_genx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t n:32;
+	} s;
+	struct cvmx_gpio_clk_genx_s cn52xx;
+	struct cvmx_gpio_clk_genx_s cn52xxp1;
+	struct cvmx_gpio_clk_genx_s cn56xx;
+	struct cvmx_gpio_clk_genx_s cn56xxp1;
+} cvmx_gpio_clk_genx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gpio_dbg_ena_s {
+		uint64_t reserved_21_63:43;
+		uint64_t dbg_ena:21;
+	} s;
+	struct cvmx_gpio_dbg_ena_s cn30xx;
+	struct cvmx_gpio_dbg_ena_s cn31xx;
+	struct cvmx_gpio_dbg_ena_s cn50xx;
+} cvmx_gpio_dbg_ena_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gpio_int_clr_s {
+		uint64_t reserved_16_63:48;
+		uint64_t type:16;
+	} s;
+	struct cvmx_gpio_int_clr_s cn30xx;
+	struct cvmx_gpio_int_clr_s cn31xx;
+	struct cvmx_gpio_int_clr_s cn38xx;
+	struct cvmx_gpio_int_clr_s cn38xxp2;
+	struct cvmx_gpio_int_clr_s cn50xx;
+	struct cvmx_gpio_int_clr_s cn52xx;
+	struct cvmx_gpio_int_clr_s cn52xxp1;
+	struct cvmx_gpio_int_clr_s cn56xx;
+	struct cvmx_gpio_int_clr_s cn56xxp1;
+	struct cvmx_gpio_int_clr_s cn58xx;
+	struct cvmx_gpio_int_clr_s cn58xxp1;
+} cvmx_gpio_int_clr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gpio_rx_dat_s {
+		uint64_t reserved_24_63:40;
+		uint64_t dat:24;
+	} s;
+	struct cvmx_gpio_rx_dat_s cn30xx;
+	struct cvmx_gpio_rx_dat_s cn31xx;
+	struct cvmx_gpio_rx_dat_cn38xx {
+		uint64_t reserved_16_63:48;
+		uint64_t dat:16;
+	} cn38xx;
+	struct cvmx_gpio_rx_dat_cn38xx cn38xxp2;
+	struct cvmx_gpio_rx_dat_s cn50xx;
+	struct cvmx_gpio_rx_dat_cn38xx cn52xx;
+	struct cvmx_gpio_rx_dat_cn38xx cn52xxp1;
+	struct cvmx_gpio_rx_dat_cn38xx cn56xx;
+	struct cvmx_gpio_rx_dat_cn38xx cn56xxp1;
+	struct cvmx_gpio_rx_dat_cn38xx cn58xx;
+	struct cvmx_gpio_rx_dat_cn38xx cn58xxp1;
+} cvmx_gpio_rx_dat_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gpio_tx_clr_s {
+		uint64_t reserved_24_63:40;
+		uint64_t clr:24;
+	} s;
+	struct cvmx_gpio_tx_clr_s cn30xx;
+	struct cvmx_gpio_tx_clr_s cn31xx;
+	struct cvmx_gpio_tx_clr_cn38xx {
+		uint64_t reserved_16_63:48;
+		uint64_t clr:16;
+	} cn38xx;
+	struct cvmx_gpio_tx_clr_cn38xx cn38xxp2;
+	struct cvmx_gpio_tx_clr_s cn50xx;
+	struct cvmx_gpio_tx_clr_cn38xx cn52xx;
+	struct cvmx_gpio_tx_clr_cn38xx cn52xxp1;
+	struct cvmx_gpio_tx_clr_cn38xx cn56xx;
+	struct cvmx_gpio_tx_clr_cn38xx cn56xxp1;
+	struct cvmx_gpio_tx_clr_cn38xx cn58xx;
+	struct cvmx_gpio_tx_clr_cn38xx cn58xxp1;
+} cvmx_gpio_tx_clr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gpio_tx_set_s {
+		uint64_t reserved_24_63:40;
+		uint64_t set:24;
+	} s;
+	struct cvmx_gpio_tx_set_s cn30xx;
+	struct cvmx_gpio_tx_set_s cn31xx;
+	struct cvmx_gpio_tx_set_cn38xx {
+		uint64_t reserved_16_63:48;
+		uint64_t set:16;
+	} cn38xx;
+	struct cvmx_gpio_tx_set_cn38xx cn38xxp2;
+	struct cvmx_gpio_tx_set_s cn50xx;
+	struct cvmx_gpio_tx_set_cn38xx cn52xx;
+	struct cvmx_gpio_tx_set_cn38xx cn52xxp1;
+	struct cvmx_gpio_tx_set_cn38xx cn56xx;
+	struct cvmx_gpio_tx_set_cn38xx cn56xxp1;
+	struct cvmx_gpio_tx_set_cn38xx cn58xx;
+	struct cvmx_gpio_tx_set_cn38xx cn58xxp1;
+} cvmx_gpio_tx_set_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_gpio_xbit_cfgx_s {
+		uint64_t reserved_12_63:52;
+		uint64_t fil_sel:4;
+		uint64_t fil_cnt:4;
+		uint64_t reserved_2_3:2;
+		uint64_t rx_xor:1;
+		uint64_t tx_oe:1;
+	} s;
+	struct cvmx_gpio_xbit_cfgx_s cn30xx;
+	struct cvmx_gpio_xbit_cfgx_s cn31xx;
+	struct cvmx_gpio_xbit_cfgx_s cn50xx;
+} cvmx_gpio_xbit_cfgx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_iob_bist_status_s {
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
+	} s;
+	struct cvmx_iob_bist_status_s cn30xx;
+	struct cvmx_iob_bist_status_s cn31xx;
+	struct cvmx_iob_bist_status_s cn38xx;
+	struct cvmx_iob_bist_status_s cn38xxp2;
+	struct cvmx_iob_bist_status_s cn50xx;
+	struct cvmx_iob_bist_status_s cn52xx;
+	struct cvmx_iob_bist_status_s cn52xxp1;
+	struct cvmx_iob_bist_status_s cn56xx;
+	struct cvmx_iob_bist_status_s cn56xxp1;
+	struct cvmx_iob_bist_status_s cn58xx;
+	struct cvmx_iob_bist_status_s cn58xxp1;
+} cvmx_iob_bist_status_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_iob_ctl_status_s {
+		uint64_t reserved_5_63:59;
+		uint64_t outb_mat:1;
+		uint64_t inb_mat:1;
+		uint64_t pko_enb:1;
+		uint64_t dwb_enb:1;
+		uint64_t fau_end:1;
+	} s;
+	struct cvmx_iob_ctl_status_s cn30xx;
+	struct cvmx_iob_ctl_status_s cn31xx;
+	struct cvmx_iob_ctl_status_s cn38xx;
+	struct cvmx_iob_ctl_status_s cn38xxp2;
+	struct cvmx_iob_ctl_status_s cn50xx;
+	struct cvmx_iob_ctl_status_s cn52xx;
+	struct cvmx_iob_ctl_status_s cn52xxp1;
+	struct cvmx_iob_ctl_status_s cn56xx;
+	struct cvmx_iob_ctl_status_s cn56xxp1;
+	struct cvmx_iob_ctl_status_s cn58xx;
+	struct cvmx_iob_ctl_status_s cn58xxp1;
+} cvmx_iob_ctl_status_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_iob_dwb_pri_cnt_s {
+		uint64_t reserved_16_63:48;
+		uint64_t cnt_enb:1;
+		uint64_t cnt_val:15;
+	} s;
+	struct cvmx_iob_dwb_pri_cnt_s cn38xx;
+	struct cvmx_iob_dwb_pri_cnt_s cn38xxp2;
+	struct cvmx_iob_dwb_pri_cnt_s cn52xx;
+	struct cvmx_iob_dwb_pri_cnt_s cn52xxp1;
+	struct cvmx_iob_dwb_pri_cnt_s cn56xx;
+	struct cvmx_iob_dwb_pri_cnt_s cn56xxp1;
+	struct cvmx_iob_dwb_pri_cnt_s cn58xx;
+	struct cvmx_iob_dwb_pri_cnt_s cn58xxp1;
+} cvmx_iob_dwb_pri_cnt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_iob_fau_timeout_s {
+		uint64_t reserved_13_63:51;
+		uint64_t tout_enb:1;
+		uint64_t tout_val:12;
+	} s;
+	struct cvmx_iob_fau_timeout_s cn30xx;
+	struct cvmx_iob_fau_timeout_s cn31xx;
+	struct cvmx_iob_fau_timeout_s cn38xx;
+	struct cvmx_iob_fau_timeout_s cn38xxp2;
+	struct cvmx_iob_fau_timeout_s cn50xx;
+	struct cvmx_iob_fau_timeout_s cn52xx;
+	struct cvmx_iob_fau_timeout_s cn52xxp1;
+	struct cvmx_iob_fau_timeout_s cn56xx;
+	struct cvmx_iob_fau_timeout_s cn56xxp1;
+	struct cvmx_iob_fau_timeout_s cn58xx;
+	struct cvmx_iob_fau_timeout_s cn58xxp1;
+} cvmx_iob_fau_timeout_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_iob_i2c_pri_cnt_s {
+		uint64_t reserved_16_63:48;
+		uint64_t cnt_enb:1;
+		uint64_t cnt_val:15;
+	} s;
+	struct cvmx_iob_i2c_pri_cnt_s cn38xx;
+	struct cvmx_iob_i2c_pri_cnt_s cn38xxp2;
+	struct cvmx_iob_i2c_pri_cnt_s cn52xx;
+	struct cvmx_iob_i2c_pri_cnt_s cn52xxp1;
+	struct cvmx_iob_i2c_pri_cnt_s cn56xx;
+	struct cvmx_iob_i2c_pri_cnt_s cn56xxp1;
+	struct cvmx_iob_i2c_pri_cnt_s cn58xx;
+	struct cvmx_iob_i2c_pri_cnt_s cn58xxp1;
+} cvmx_iob_i2c_pri_cnt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_iob_inb_control_match_s {
+		uint64_t reserved_29_63:35;
+		uint64_t mask:8;
+		uint64_t opc:4;
+		uint64_t dst:9;
+		uint64_t src:8;
+	} s;
+	struct cvmx_iob_inb_control_match_s cn30xx;
+	struct cvmx_iob_inb_control_match_s cn31xx;
+	struct cvmx_iob_inb_control_match_s cn38xx;
+	struct cvmx_iob_inb_control_match_s cn38xxp2;
+	struct cvmx_iob_inb_control_match_s cn50xx;
+	struct cvmx_iob_inb_control_match_s cn52xx;
+	struct cvmx_iob_inb_control_match_s cn52xxp1;
+	struct cvmx_iob_inb_control_match_s cn56xx;
+	struct cvmx_iob_inb_control_match_s cn56xxp1;
+	struct cvmx_iob_inb_control_match_s cn58xx;
+	struct cvmx_iob_inb_control_match_s cn58xxp1;
+} cvmx_iob_inb_control_match_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_iob_inb_control_match_enb_s {
+		uint64_t reserved_29_63:35;
+		uint64_t mask:8;
+		uint64_t opc:4;
+		uint64_t dst:9;
+		uint64_t src:8;
+	} s;
+	struct cvmx_iob_inb_control_match_enb_s cn30xx;
+	struct cvmx_iob_inb_control_match_enb_s cn31xx;
+	struct cvmx_iob_inb_control_match_enb_s cn38xx;
+	struct cvmx_iob_inb_control_match_enb_s cn38xxp2;
+	struct cvmx_iob_inb_control_match_enb_s cn50xx;
+	struct cvmx_iob_inb_control_match_enb_s cn52xx;
+	struct cvmx_iob_inb_control_match_enb_s cn52xxp1;
+	struct cvmx_iob_inb_control_match_enb_s cn56xx;
+	struct cvmx_iob_inb_control_match_enb_s cn56xxp1;
+	struct cvmx_iob_inb_control_match_enb_s cn58xx;
+	struct cvmx_iob_inb_control_match_enb_s cn58xxp1;
+} cvmx_iob_inb_control_match_enb_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_iob_inb_data_match_s {
+		uint64_t data:64;
+	} s;
+	struct cvmx_iob_inb_data_match_s cn30xx;
+	struct cvmx_iob_inb_data_match_s cn31xx;
+	struct cvmx_iob_inb_data_match_s cn38xx;
+	struct cvmx_iob_inb_data_match_s cn38xxp2;
+	struct cvmx_iob_inb_data_match_s cn50xx;
+	struct cvmx_iob_inb_data_match_s cn52xx;
+	struct cvmx_iob_inb_data_match_s cn52xxp1;
+	struct cvmx_iob_inb_data_match_s cn56xx;
+	struct cvmx_iob_inb_data_match_s cn56xxp1;
+	struct cvmx_iob_inb_data_match_s cn58xx;
+	struct cvmx_iob_inb_data_match_s cn58xxp1;
+} cvmx_iob_inb_data_match_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_iob_inb_data_match_enb_s {
+		uint64_t data:64;
+	} s;
+	struct cvmx_iob_inb_data_match_enb_s cn30xx;
+	struct cvmx_iob_inb_data_match_enb_s cn31xx;
+	struct cvmx_iob_inb_data_match_enb_s cn38xx;
+	struct cvmx_iob_inb_data_match_enb_s cn38xxp2;
+	struct cvmx_iob_inb_data_match_enb_s cn50xx;
+	struct cvmx_iob_inb_data_match_enb_s cn52xx;
+	struct cvmx_iob_inb_data_match_enb_s cn52xxp1;
+	struct cvmx_iob_inb_data_match_enb_s cn56xx;
+	struct cvmx_iob_inb_data_match_enb_s cn56xxp1;
+	struct cvmx_iob_inb_data_match_enb_s cn58xx;
+	struct cvmx_iob_inb_data_match_enb_s cn58xxp1;
+} cvmx_iob_inb_data_match_enb_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_iob_int_enb_s {
+		uint64_t reserved_6_63:58;
+		uint64_t p_dat:1;
+		uint64_t np_dat:1;
+		uint64_t p_eop:1;
+		uint64_t p_sop:1;
+		uint64_t np_eop:1;
+		uint64_t np_sop:1;
+	} s;
+	struct cvmx_iob_int_enb_cn30xx {
+		uint64_t reserved_4_63:60;
+		uint64_t p_eop:1;
+		uint64_t p_sop:1;
+		uint64_t np_eop:1;
+		uint64_t np_sop:1;
+	} cn30xx;
+	struct cvmx_iob_int_enb_cn30xx cn31xx;
+	struct cvmx_iob_int_enb_cn30xx cn38xx;
+	struct cvmx_iob_int_enb_cn30xx cn38xxp2;
+	struct cvmx_iob_int_enb_s cn50xx;
+	struct cvmx_iob_int_enb_s cn52xx;
+	struct cvmx_iob_int_enb_s cn52xxp1;
+	struct cvmx_iob_int_enb_s cn56xx;
+	struct cvmx_iob_int_enb_s cn56xxp1;
+	struct cvmx_iob_int_enb_s cn58xx;
+	struct cvmx_iob_int_enb_s cn58xxp1;
+} cvmx_iob_int_enb_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_iob_int_sum_s {
+		uint64_t reserved_6_63:58;
+		uint64_t p_dat:1;
+		uint64_t np_dat:1;
+		uint64_t p_eop:1;
+		uint64_t p_sop:1;
+		uint64_t np_eop:1;
+		uint64_t np_sop:1;
+	} s;
+	struct cvmx_iob_int_sum_cn30xx {
+		uint64_t reserved_4_63:60;
+		uint64_t p_eop:1;
+		uint64_t p_sop:1;
+		uint64_t np_eop:1;
+		uint64_t np_sop:1;
+	} cn30xx;
+	struct cvmx_iob_int_sum_cn30xx cn31xx;
+	struct cvmx_iob_int_sum_cn30xx cn38xx;
+	struct cvmx_iob_int_sum_cn30xx cn38xxp2;
+	struct cvmx_iob_int_sum_s cn50xx;
+	struct cvmx_iob_int_sum_s cn52xx;
+	struct cvmx_iob_int_sum_s cn52xxp1;
+	struct cvmx_iob_int_sum_s cn56xx;
+	struct cvmx_iob_int_sum_s cn56xxp1;
+	struct cvmx_iob_int_sum_s cn58xx;
+	struct cvmx_iob_int_sum_s cn58xxp1;
+} cvmx_iob_int_sum_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_iob_n2c_l2c_pri_cnt_s {
+		uint64_t reserved_16_63:48;
+		uint64_t cnt_enb:1;
+		uint64_t cnt_val:15;
+	} s;
+	struct cvmx_iob_n2c_l2c_pri_cnt_s cn38xx;
+	struct cvmx_iob_n2c_l2c_pri_cnt_s cn38xxp2;
+	struct cvmx_iob_n2c_l2c_pri_cnt_s cn52xx;
+	struct cvmx_iob_n2c_l2c_pri_cnt_s cn52xxp1;
+	struct cvmx_iob_n2c_l2c_pri_cnt_s cn56xx;
+	struct cvmx_iob_n2c_l2c_pri_cnt_s cn56xxp1;
+	struct cvmx_iob_n2c_l2c_pri_cnt_s cn58xx;
+	struct cvmx_iob_n2c_l2c_pri_cnt_s cn58xxp1;
+} cvmx_iob_n2c_l2c_pri_cnt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_iob_n2c_rsp_pri_cnt_s {
+		uint64_t reserved_16_63:48;
+		uint64_t cnt_enb:1;
+		uint64_t cnt_val:15;
+	} s;
+	struct cvmx_iob_n2c_rsp_pri_cnt_s cn38xx;
+	struct cvmx_iob_n2c_rsp_pri_cnt_s cn38xxp2;
+	struct cvmx_iob_n2c_rsp_pri_cnt_s cn52xx;
+	struct cvmx_iob_n2c_rsp_pri_cnt_s cn52xxp1;
+	struct cvmx_iob_n2c_rsp_pri_cnt_s cn56xx;
+	struct cvmx_iob_n2c_rsp_pri_cnt_s cn56xxp1;
+	struct cvmx_iob_n2c_rsp_pri_cnt_s cn58xx;
+	struct cvmx_iob_n2c_rsp_pri_cnt_s cn58xxp1;
+} cvmx_iob_n2c_rsp_pri_cnt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_iob_outb_com_pri_cnt_s {
+		uint64_t reserved_16_63:48;
+		uint64_t cnt_enb:1;
+		uint64_t cnt_val:15;
+	} s;
+	struct cvmx_iob_outb_com_pri_cnt_s cn38xx;
+	struct cvmx_iob_outb_com_pri_cnt_s cn38xxp2;
+	struct cvmx_iob_outb_com_pri_cnt_s cn52xx;
+	struct cvmx_iob_outb_com_pri_cnt_s cn52xxp1;
+	struct cvmx_iob_outb_com_pri_cnt_s cn56xx;
+	struct cvmx_iob_outb_com_pri_cnt_s cn56xxp1;
+	struct cvmx_iob_outb_com_pri_cnt_s cn58xx;
+	struct cvmx_iob_outb_com_pri_cnt_s cn58xxp1;
+} cvmx_iob_outb_com_pri_cnt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_iob_outb_control_match_s {
+		uint64_t reserved_26_63:38;
+		uint64_t mask:8;
+		uint64_t eot:1;
+		uint64_t dst:8;
+		uint64_t src:9;
+	} s;
+	struct cvmx_iob_outb_control_match_s cn30xx;
+	struct cvmx_iob_outb_control_match_s cn31xx;
+	struct cvmx_iob_outb_control_match_s cn38xx;
+	struct cvmx_iob_outb_control_match_s cn38xxp2;
+	struct cvmx_iob_outb_control_match_s cn50xx;
+	struct cvmx_iob_outb_control_match_s cn52xx;
+	struct cvmx_iob_outb_control_match_s cn52xxp1;
+	struct cvmx_iob_outb_control_match_s cn56xx;
+	struct cvmx_iob_outb_control_match_s cn56xxp1;
+	struct cvmx_iob_outb_control_match_s cn58xx;
+	struct cvmx_iob_outb_control_match_s cn58xxp1;
+} cvmx_iob_outb_control_match_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_iob_outb_control_match_enb_s {
+		uint64_t reserved_26_63:38;
+		uint64_t mask:8;
+		uint64_t eot:1;
+		uint64_t dst:8;
+		uint64_t src:9;
+	} s;
+	struct cvmx_iob_outb_control_match_enb_s cn30xx;
+	struct cvmx_iob_outb_control_match_enb_s cn31xx;
+	struct cvmx_iob_outb_control_match_enb_s cn38xx;
+	struct cvmx_iob_outb_control_match_enb_s cn38xxp2;
+	struct cvmx_iob_outb_control_match_enb_s cn50xx;
+	struct cvmx_iob_outb_control_match_enb_s cn52xx;
+	struct cvmx_iob_outb_control_match_enb_s cn52xxp1;
+	struct cvmx_iob_outb_control_match_enb_s cn56xx;
+	struct cvmx_iob_outb_control_match_enb_s cn56xxp1;
+	struct cvmx_iob_outb_control_match_enb_s cn58xx;
+	struct cvmx_iob_outb_control_match_enb_s cn58xxp1;
+} cvmx_iob_outb_control_match_enb_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_iob_outb_data_match_s {
+		uint64_t data:64;
+	} s;
+	struct cvmx_iob_outb_data_match_s cn30xx;
+	struct cvmx_iob_outb_data_match_s cn31xx;
+	struct cvmx_iob_outb_data_match_s cn38xx;
+	struct cvmx_iob_outb_data_match_s cn38xxp2;
+	struct cvmx_iob_outb_data_match_s cn50xx;
+	struct cvmx_iob_outb_data_match_s cn52xx;
+	struct cvmx_iob_outb_data_match_s cn52xxp1;
+	struct cvmx_iob_outb_data_match_s cn56xx;
+	struct cvmx_iob_outb_data_match_s cn56xxp1;
+	struct cvmx_iob_outb_data_match_s cn58xx;
+	struct cvmx_iob_outb_data_match_s cn58xxp1;
+} cvmx_iob_outb_data_match_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_iob_outb_data_match_enb_s {
+		uint64_t data:64;
+	} s;
+	struct cvmx_iob_outb_data_match_enb_s cn30xx;
+	struct cvmx_iob_outb_data_match_enb_s cn31xx;
+	struct cvmx_iob_outb_data_match_enb_s cn38xx;
+	struct cvmx_iob_outb_data_match_enb_s cn38xxp2;
+	struct cvmx_iob_outb_data_match_enb_s cn50xx;
+	struct cvmx_iob_outb_data_match_enb_s cn52xx;
+	struct cvmx_iob_outb_data_match_enb_s cn52xxp1;
+	struct cvmx_iob_outb_data_match_enb_s cn56xx;
+	struct cvmx_iob_outb_data_match_enb_s cn56xxp1;
+	struct cvmx_iob_outb_data_match_enb_s cn58xx;
+	struct cvmx_iob_outb_data_match_enb_s cn58xxp1;
+} cvmx_iob_outb_data_match_enb_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_iob_outb_fpa_pri_cnt_s {
+		uint64_t reserved_16_63:48;
+		uint64_t cnt_enb:1;
+		uint64_t cnt_val:15;
+	} s;
+	struct cvmx_iob_outb_fpa_pri_cnt_s cn38xx;
+	struct cvmx_iob_outb_fpa_pri_cnt_s cn38xxp2;
+	struct cvmx_iob_outb_fpa_pri_cnt_s cn52xx;
+	struct cvmx_iob_outb_fpa_pri_cnt_s cn52xxp1;
+	struct cvmx_iob_outb_fpa_pri_cnt_s cn56xx;
+	struct cvmx_iob_outb_fpa_pri_cnt_s cn56xxp1;
+	struct cvmx_iob_outb_fpa_pri_cnt_s cn58xx;
+	struct cvmx_iob_outb_fpa_pri_cnt_s cn58xxp1;
+} cvmx_iob_outb_fpa_pri_cnt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_iob_outb_req_pri_cnt_s {
+		uint64_t reserved_16_63:48;
+		uint64_t cnt_enb:1;
+		uint64_t cnt_val:15;
+	} s;
+	struct cvmx_iob_outb_req_pri_cnt_s cn38xx;
+	struct cvmx_iob_outb_req_pri_cnt_s cn38xxp2;
+	struct cvmx_iob_outb_req_pri_cnt_s cn52xx;
+	struct cvmx_iob_outb_req_pri_cnt_s cn52xxp1;
+	struct cvmx_iob_outb_req_pri_cnt_s cn56xx;
+	struct cvmx_iob_outb_req_pri_cnt_s cn56xxp1;
+	struct cvmx_iob_outb_req_pri_cnt_s cn58xx;
+	struct cvmx_iob_outb_req_pri_cnt_s cn58xxp1;
+} cvmx_iob_outb_req_pri_cnt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_iob_p2c_req_pri_cnt_s {
+		uint64_t reserved_16_63:48;
+		uint64_t cnt_enb:1;
+		uint64_t cnt_val:15;
+	} s;
+	struct cvmx_iob_p2c_req_pri_cnt_s cn38xx;
+	struct cvmx_iob_p2c_req_pri_cnt_s cn38xxp2;
+	struct cvmx_iob_p2c_req_pri_cnt_s cn52xx;
+	struct cvmx_iob_p2c_req_pri_cnt_s cn52xxp1;
+	struct cvmx_iob_p2c_req_pri_cnt_s cn56xx;
+	struct cvmx_iob_p2c_req_pri_cnt_s cn56xxp1;
+	struct cvmx_iob_p2c_req_pri_cnt_s cn58xx;
+	struct cvmx_iob_p2c_req_pri_cnt_s cn58xxp1;
+} cvmx_iob_p2c_req_pri_cnt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_iob_pkt_err_s {
+		uint64_t reserved_6_63:58;
+		uint64_t port:6;
+	} s;
+	struct cvmx_iob_pkt_err_s cn30xx;
+	struct cvmx_iob_pkt_err_s cn31xx;
+	struct cvmx_iob_pkt_err_s cn38xx;
+	struct cvmx_iob_pkt_err_s cn38xxp2;
+	struct cvmx_iob_pkt_err_s cn50xx;
+	struct cvmx_iob_pkt_err_s cn52xx;
+	struct cvmx_iob_pkt_err_s cn52xxp1;
+	struct cvmx_iob_pkt_err_s cn56xx;
+	struct cvmx_iob_pkt_err_s cn56xxp1;
+	struct cvmx_iob_pkt_err_s cn58xx;
+	struct cvmx_iob_pkt_err_s cn58xxp1;
+} cvmx_iob_pkt_err_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_1st_mbuff_skip_s {
+		uint64_t reserved_6_63:58;
+		uint64_t skip_sz:6;
+	} s;
+	struct cvmx_ipd_1st_mbuff_skip_s cn30xx;
+	struct cvmx_ipd_1st_mbuff_skip_s cn31xx;
+	struct cvmx_ipd_1st_mbuff_skip_s cn38xx;
+	struct cvmx_ipd_1st_mbuff_skip_s cn38xxp2;
+	struct cvmx_ipd_1st_mbuff_skip_s cn50xx;
+	struct cvmx_ipd_1st_mbuff_skip_s cn52xx;
+	struct cvmx_ipd_1st_mbuff_skip_s cn52xxp1;
+	struct cvmx_ipd_1st_mbuff_skip_s cn56xx;
+	struct cvmx_ipd_1st_mbuff_skip_s cn56xxp1;
+	struct cvmx_ipd_1st_mbuff_skip_s cn58xx;
+	struct cvmx_ipd_1st_mbuff_skip_s cn58xxp1;
+} cvmx_ipd_1st_mbuff_skip_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_1st_next_ptr_back_s {
+		uint64_t reserved_4_63:60;
+		uint64_t back:4;
+	} s;
+	struct cvmx_ipd_1st_next_ptr_back_s cn30xx;
+	struct cvmx_ipd_1st_next_ptr_back_s cn31xx;
+	struct cvmx_ipd_1st_next_ptr_back_s cn38xx;
+	struct cvmx_ipd_1st_next_ptr_back_s cn38xxp2;
+	struct cvmx_ipd_1st_next_ptr_back_s cn50xx;
+	struct cvmx_ipd_1st_next_ptr_back_s cn52xx;
+	struct cvmx_ipd_1st_next_ptr_back_s cn52xxp1;
+	struct cvmx_ipd_1st_next_ptr_back_s cn56xx;
+	struct cvmx_ipd_1st_next_ptr_back_s cn56xxp1;
+	struct cvmx_ipd_1st_next_ptr_back_s cn58xx;
+	struct cvmx_ipd_1st_next_ptr_back_s cn58xxp1;
+} cvmx_ipd_1st_next_ptr_back_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_2nd_next_ptr_back_s {
+		uint64_t reserved_4_63:60;
+		uint64_t back:4;
+	} s;
+	struct cvmx_ipd_2nd_next_ptr_back_s cn30xx;
+	struct cvmx_ipd_2nd_next_ptr_back_s cn31xx;
+	struct cvmx_ipd_2nd_next_ptr_back_s cn38xx;
+	struct cvmx_ipd_2nd_next_ptr_back_s cn38xxp2;
+	struct cvmx_ipd_2nd_next_ptr_back_s cn50xx;
+	struct cvmx_ipd_2nd_next_ptr_back_s cn52xx;
+	struct cvmx_ipd_2nd_next_ptr_back_s cn52xxp1;
+	struct cvmx_ipd_2nd_next_ptr_back_s cn56xx;
+	struct cvmx_ipd_2nd_next_ptr_back_s cn56xxp1;
+	struct cvmx_ipd_2nd_next_ptr_back_s cn58xx;
+	struct cvmx_ipd_2nd_next_ptr_back_s cn58xxp1;
+} cvmx_ipd_2nd_next_ptr_back_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_bist_status_s {
+		uint64_t reserved_18_63:46;
+		uint64_t csr_mem:1;
+		uint64_t csr_ncmd:1;
+		uint64_t pwq_wqed:1;
+		uint64_t pwq_wp1:1;
+		uint64_t pwq_pow:1;
+		uint64_t ipq_pbe1:1;
+		uint64_t ipq_pbe0:1;
+		uint64_t pbm3:1;
+		uint64_t pbm2:1;
+		uint64_t pbm1:1;
+		uint64_t pbm0:1;
+		uint64_t pbm_word:1;
+		uint64_t pwq1:1;
+		uint64_t pwq0:1;
+		uint64_t prc_off:1;
+		uint64_t ipd_old:1;
+		uint64_t ipd_new:1;
+		uint64_t pwp:1;
+	} s;
+	struct cvmx_ipd_bist_status_cn30xx {
+		uint64_t reserved_16_63:48;
+		uint64_t pwq_wqed:1;
+		uint64_t pwq_wp1:1;
+		uint64_t pwq_pow:1;
+		uint64_t ipq_pbe1:1;
+		uint64_t ipq_pbe0:1;
+		uint64_t pbm3:1;
+		uint64_t pbm2:1;
+		uint64_t pbm1:1;
+		uint64_t pbm0:1;
+		uint64_t pbm_word:1;
+		uint64_t pwq1:1;
+		uint64_t pwq0:1;
+		uint64_t prc_off:1;
+		uint64_t ipd_old:1;
+		uint64_t ipd_new:1;
+		uint64_t pwp:1;
+	} cn30xx;
+	struct cvmx_ipd_bist_status_cn30xx cn31xx;
+	struct cvmx_ipd_bist_status_cn30xx cn38xx;
+	struct cvmx_ipd_bist_status_cn30xx cn38xxp2;
+	struct cvmx_ipd_bist_status_cn30xx cn50xx;
+	struct cvmx_ipd_bist_status_s cn52xx;
+	struct cvmx_ipd_bist_status_s cn52xxp1;
+	struct cvmx_ipd_bist_status_s cn56xx;
+	struct cvmx_ipd_bist_status_s cn56xxp1;
+	struct cvmx_ipd_bist_status_cn30xx cn58xx;
+	struct cvmx_ipd_bist_status_cn30xx cn58xxp1;
+} cvmx_ipd_bist_status_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_bp_prt_red_end_s {
+		uint64_t reserved_40_63:24;
+		uint64_t prt_enb:40;
+	} s;
+	struct cvmx_ipd_bp_prt_red_end_cn30xx {
+		uint64_t reserved_36_63:28;
+		uint64_t prt_enb:36;
+	} cn30xx;
+	struct cvmx_ipd_bp_prt_red_end_cn30xx cn31xx;
+	struct cvmx_ipd_bp_prt_red_end_cn30xx cn38xx;
+	struct cvmx_ipd_bp_prt_red_end_cn30xx cn38xxp2;
+	struct cvmx_ipd_bp_prt_red_end_cn30xx cn50xx;
+	struct cvmx_ipd_bp_prt_red_end_s cn52xx;
+	struct cvmx_ipd_bp_prt_red_end_s cn52xxp1;
+	struct cvmx_ipd_bp_prt_red_end_s cn56xx;
+	struct cvmx_ipd_bp_prt_red_end_s cn56xxp1;
+	struct cvmx_ipd_bp_prt_red_end_cn30xx cn58xx;
+	struct cvmx_ipd_bp_prt_red_end_cn30xx cn58xxp1;
+} cvmx_ipd_bp_prt_red_end_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_clk_count_s {
+		uint64_t clk_cnt:64;
+	} s;
+	struct cvmx_ipd_clk_count_s cn30xx;
+	struct cvmx_ipd_clk_count_s cn31xx;
+	struct cvmx_ipd_clk_count_s cn38xx;
+	struct cvmx_ipd_clk_count_s cn38xxp2;
+	struct cvmx_ipd_clk_count_s cn50xx;
+	struct cvmx_ipd_clk_count_s cn52xx;
+	struct cvmx_ipd_clk_count_s cn52xxp1;
+	struct cvmx_ipd_clk_count_s cn56xx;
+	struct cvmx_ipd_clk_count_s cn56xxp1;
+	struct cvmx_ipd_clk_count_s cn58xx;
+	struct cvmx_ipd_clk_count_s cn58xxp1;
+} cvmx_ipd_clk_count_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_ctl_status_s {
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
+		cvmx_ipd_mode_t opc_mode:2;
+		uint64_t ipd_en:1;
+	} s;
+	struct cvmx_ipd_ctl_status_cn30xx {
+		uint64_t reserved_10_63:54;
+		uint64_t len_m8:1;
+		uint64_t reset:1;
+		uint64_t addpkt:1;
+		uint64_t naddbuf:1;
+		uint64_t pkt_lend:1;
+		uint64_t wqe_lend:1;
+		uint64_t pbp_en:1;
+		cvmx_ipd_mode_t opc_mode:2;
+		uint64_t ipd_en:1;
+	} cn30xx;
+	struct cvmx_ipd_ctl_status_cn30xx cn31xx;
+	struct cvmx_ipd_ctl_status_cn30xx cn38xx;
+	struct cvmx_ipd_ctl_status_cn38xxp2 {
+		uint64_t reserved_9_63:55;
+		uint64_t reset:1;
+		uint64_t addpkt:1;
+		uint64_t naddbuf:1;
+		uint64_t pkt_lend:1;
+		uint64_t wqe_lend:1;
+		uint64_t pbp_en:1;
+		cvmx_ipd_mode_t opc_mode:2;
+		uint64_t ipd_en:1;
+	} cn38xxp2;
+	struct cvmx_ipd_ctl_status_s cn50xx;
+	struct cvmx_ipd_ctl_status_s cn52xx;
+	struct cvmx_ipd_ctl_status_s cn52xxp1;
+	struct cvmx_ipd_ctl_status_s cn56xx;
+	struct cvmx_ipd_ctl_status_s cn56xxp1;
+	struct cvmx_ipd_ctl_status_cn58xx {
+		uint64_t reserved_12_63:52;
+		uint64_t ipd_full:1;
+		uint64_t pkt_off:1;
+		uint64_t len_m8:1;
+		uint64_t reset:1;
+		uint64_t addpkt:1;
+		uint64_t naddbuf:1;
+		uint64_t pkt_lend:1;
+		uint64_t wqe_lend:1;
+		uint64_t pbp_en:1;
+		cvmx_ipd_mode_t opc_mode:2;
+		uint64_t ipd_en:1;
+	} cn58xx;
+	struct cvmx_ipd_ctl_status_cn58xx cn58xxp1;
+} cvmx_ipd_ctl_status_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_int_enb_s {
+		uint64_t reserved_12_63:52;
+		uint64_t pq_sub:1;
+		uint64_t pq_add:1;
+		uint64_t bc_ovr:1;
+		uint64_t d_coll:1;
+		uint64_t c_coll:1;
+		uint64_t cc_ovr:1;
+		uint64_t dc_ovr:1;
+		uint64_t bp_sub:1;
+		uint64_t prc_par3:1;
+		uint64_t prc_par2:1;
+		uint64_t prc_par1:1;
+		uint64_t prc_par0:1;
+	} s;
+	struct cvmx_ipd_int_enb_cn30xx {
+		uint64_t reserved_5_63:59;
+		uint64_t bp_sub:1;
+		uint64_t prc_par3:1;
+		uint64_t prc_par2:1;
+		uint64_t prc_par1:1;
+		uint64_t prc_par0:1;
+	} cn30xx;
+	struct cvmx_ipd_int_enb_cn30xx cn31xx;
+	struct cvmx_ipd_int_enb_cn38xx {
+		uint64_t reserved_10_63:54;
+		uint64_t bc_ovr:1;
+		uint64_t d_coll:1;
+		uint64_t c_coll:1;
+		uint64_t cc_ovr:1;
+		uint64_t dc_ovr:1;
+		uint64_t bp_sub:1;
+		uint64_t prc_par3:1;
+		uint64_t prc_par2:1;
+		uint64_t prc_par1:1;
+		uint64_t prc_par0:1;
+	} cn38xx;
+	struct cvmx_ipd_int_enb_cn30xx cn38xxp2;
+	struct cvmx_ipd_int_enb_cn38xx cn50xx;
+	struct cvmx_ipd_int_enb_s cn52xx;
+	struct cvmx_ipd_int_enb_s cn52xxp1;
+	struct cvmx_ipd_int_enb_s cn56xx;
+	struct cvmx_ipd_int_enb_s cn56xxp1;
+	struct cvmx_ipd_int_enb_cn38xx cn58xx;
+	struct cvmx_ipd_int_enb_cn38xx cn58xxp1;
+} cvmx_ipd_int_enb_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_int_sum_s {
+		uint64_t reserved_12_63:52;
+		uint64_t pq_sub:1;
+		uint64_t pq_add:1;
+		uint64_t bc_ovr:1;
+		uint64_t d_coll:1;
+		uint64_t c_coll:1;
+		uint64_t cc_ovr:1;
+		uint64_t dc_ovr:1;
+		uint64_t bp_sub:1;
+		uint64_t prc_par3:1;
+		uint64_t prc_par2:1;
+		uint64_t prc_par1:1;
+		uint64_t prc_par0:1;
+	} s;
+	struct cvmx_ipd_int_sum_cn30xx {
+		uint64_t reserved_5_63:59;
+		uint64_t bp_sub:1;
+		uint64_t prc_par3:1;
+		uint64_t prc_par2:1;
+		uint64_t prc_par1:1;
+		uint64_t prc_par0:1;
+	} cn30xx;
+	struct cvmx_ipd_int_sum_cn30xx cn31xx;
+	struct cvmx_ipd_int_sum_cn38xx {
+		uint64_t reserved_10_63:54;
+		uint64_t bc_ovr:1;
+		uint64_t d_coll:1;
+		uint64_t c_coll:1;
+		uint64_t cc_ovr:1;
+		uint64_t dc_ovr:1;
+		uint64_t bp_sub:1;
+		uint64_t prc_par3:1;
+		uint64_t prc_par2:1;
+		uint64_t prc_par1:1;
+		uint64_t prc_par0:1;
+	} cn38xx;
+	struct cvmx_ipd_int_sum_cn30xx cn38xxp2;
+	struct cvmx_ipd_int_sum_cn38xx cn50xx;
+	struct cvmx_ipd_int_sum_s cn52xx;
+	struct cvmx_ipd_int_sum_s cn52xxp1;
+	struct cvmx_ipd_int_sum_s cn56xx;
+	struct cvmx_ipd_int_sum_s cn56xxp1;
+	struct cvmx_ipd_int_sum_cn38xx cn58xx;
+	struct cvmx_ipd_int_sum_cn38xx cn58xxp1;
+} cvmx_ipd_int_sum_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_not_1st_mbuff_skip_s {
+		uint64_t reserved_6_63:58;
+		uint64_t skip_sz:6;
+	} s;
+	struct cvmx_ipd_not_1st_mbuff_skip_s cn30xx;
+	struct cvmx_ipd_not_1st_mbuff_skip_s cn31xx;
+	struct cvmx_ipd_not_1st_mbuff_skip_s cn38xx;
+	struct cvmx_ipd_not_1st_mbuff_skip_s cn38xxp2;
+	struct cvmx_ipd_not_1st_mbuff_skip_s cn50xx;
+	struct cvmx_ipd_not_1st_mbuff_skip_s cn52xx;
+	struct cvmx_ipd_not_1st_mbuff_skip_s cn52xxp1;
+	struct cvmx_ipd_not_1st_mbuff_skip_s cn56xx;
+	struct cvmx_ipd_not_1st_mbuff_skip_s cn56xxp1;
+	struct cvmx_ipd_not_1st_mbuff_skip_s cn58xx;
+	struct cvmx_ipd_not_1st_mbuff_skip_s cn58xxp1;
+} cvmx_ipd_not_1st_mbuff_skip_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_packet_mbuff_size_s {
+		uint64_t reserved_12_63:52;
+		uint64_t mb_size:12;
+	} s;
+	struct cvmx_ipd_packet_mbuff_size_s cn30xx;
+	struct cvmx_ipd_packet_mbuff_size_s cn31xx;
+	struct cvmx_ipd_packet_mbuff_size_s cn38xx;
+	struct cvmx_ipd_packet_mbuff_size_s cn38xxp2;
+	struct cvmx_ipd_packet_mbuff_size_s cn50xx;
+	struct cvmx_ipd_packet_mbuff_size_s cn52xx;
+	struct cvmx_ipd_packet_mbuff_size_s cn52xxp1;
+	struct cvmx_ipd_packet_mbuff_size_s cn56xx;
+	struct cvmx_ipd_packet_mbuff_size_s cn56xxp1;
+	struct cvmx_ipd_packet_mbuff_size_s cn58xx;
+	struct cvmx_ipd_packet_mbuff_size_s cn58xxp1;
+} cvmx_ipd_packet_mbuff_size_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_pkt_ptr_valid_s {
+		uint64_t reserved_29_63:35;
+		uint64_t ptr:29;
+	} s;
+	struct cvmx_ipd_pkt_ptr_valid_s cn30xx;
+	struct cvmx_ipd_pkt_ptr_valid_s cn31xx;
+	struct cvmx_ipd_pkt_ptr_valid_s cn38xx;
+	struct cvmx_ipd_pkt_ptr_valid_s cn50xx;
+	struct cvmx_ipd_pkt_ptr_valid_s cn52xx;
+	struct cvmx_ipd_pkt_ptr_valid_s cn52xxp1;
+	struct cvmx_ipd_pkt_ptr_valid_s cn56xx;
+	struct cvmx_ipd_pkt_ptr_valid_s cn56xxp1;
+	struct cvmx_ipd_pkt_ptr_valid_s cn58xx;
+	struct cvmx_ipd_pkt_ptr_valid_s cn58xxp1;
+} cvmx_ipd_pkt_ptr_valid_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_portx_bp_page_cnt_s {
+		uint64_t reserved_18_63:46;
+		uint64_t bp_enb:1;
+		uint64_t page_cnt:17;
+	} s;
+	struct cvmx_ipd_portx_bp_page_cnt_s cn30xx;
+	struct cvmx_ipd_portx_bp_page_cnt_s cn31xx;
+	struct cvmx_ipd_portx_bp_page_cnt_s cn38xx;
+	struct cvmx_ipd_portx_bp_page_cnt_s cn38xxp2;
+	struct cvmx_ipd_portx_bp_page_cnt_s cn50xx;
+	struct cvmx_ipd_portx_bp_page_cnt_s cn52xx;
+	struct cvmx_ipd_portx_bp_page_cnt_s cn52xxp1;
+	struct cvmx_ipd_portx_bp_page_cnt_s cn56xx;
+	struct cvmx_ipd_portx_bp_page_cnt_s cn56xxp1;
+	struct cvmx_ipd_portx_bp_page_cnt_s cn58xx;
+	struct cvmx_ipd_portx_bp_page_cnt_s cn58xxp1;
+} cvmx_ipd_portx_bp_page_cnt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_portx_bp_page_cnt2_s {
+		uint64_t reserved_18_63:46;
+		uint64_t bp_enb:1;
+		uint64_t page_cnt:17;
+	} s;
+	struct cvmx_ipd_portx_bp_page_cnt2_s cn52xx;
+	struct cvmx_ipd_portx_bp_page_cnt2_s cn52xxp1;
+	struct cvmx_ipd_portx_bp_page_cnt2_s cn56xx;
+	struct cvmx_ipd_portx_bp_page_cnt2_s cn56xxp1;
+} cvmx_ipd_portx_bp_page_cnt2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_port_bp_counters2_pairx_s {
+		uint64_t reserved_25_63:39;
+		uint64_t cnt_val:25;
+	} s;
+	struct cvmx_ipd_port_bp_counters2_pairx_s cn52xx;
+	struct cvmx_ipd_port_bp_counters2_pairx_s cn52xxp1;
+	struct cvmx_ipd_port_bp_counters2_pairx_s cn56xx;
+	struct cvmx_ipd_port_bp_counters2_pairx_s cn56xxp1;
+} cvmx_ipd_port_bp_counters2_pairx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_port_bp_counters_pairx_s {
+		uint64_t reserved_25_63:39;
+		uint64_t cnt_val:25;
+	} s;
+	struct cvmx_ipd_port_bp_counters_pairx_s cn30xx;
+	struct cvmx_ipd_port_bp_counters_pairx_s cn31xx;
+	struct cvmx_ipd_port_bp_counters_pairx_s cn38xx;
+	struct cvmx_ipd_port_bp_counters_pairx_s cn38xxp2;
+	struct cvmx_ipd_port_bp_counters_pairx_s cn50xx;
+	struct cvmx_ipd_port_bp_counters_pairx_s cn52xx;
+	struct cvmx_ipd_port_bp_counters_pairx_s cn52xxp1;
+	struct cvmx_ipd_port_bp_counters_pairx_s cn56xx;
+	struct cvmx_ipd_port_bp_counters_pairx_s cn56xxp1;
+	struct cvmx_ipd_port_bp_counters_pairx_s cn58xx;
+	struct cvmx_ipd_port_bp_counters_pairx_s cn58xxp1;
+} cvmx_ipd_port_bp_counters_pairx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_port_qos_x_cnt_s {
+		uint64_t wmark:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_ipd_port_qos_x_cnt_s cn52xx;
+	struct cvmx_ipd_port_qos_x_cnt_s cn52xxp1;
+	struct cvmx_ipd_port_qos_x_cnt_s cn56xx;
+	struct cvmx_ipd_port_qos_x_cnt_s cn56xxp1;
+} cvmx_ipd_port_qos_x_cnt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_port_qos_intx_s {
+		uint64_t intr:64;
+	} s;
+	struct cvmx_ipd_port_qos_intx_s cn52xx;
+	struct cvmx_ipd_port_qos_intx_s cn52xxp1;
+	struct cvmx_ipd_port_qos_intx_s cn56xx;
+	struct cvmx_ipd_port_qos_intx_s cn56xxp1;
+} cvmx_ipd_port_qos_intx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_port_qos_int_enbx_s {
+		uint64_t enb:64;
+	} s;
+	struct cvmx_ipd_port_qos_int_enbx_s cn52xx;
+	struct cvmx_ipd_port_qos_int_enbx_s cn52xxp1;
+	struct cvmx_ipd_port_qos_int_enbx_s cn56xx;
+	struct cvmx_ipd_port_qos_int_enbx_s cn56xxp1;
+} cvmx_ipd_port_qos_int_enbx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_prc_hold_ptr_fifo_ctl_s {
+		uint64_t reserved_39_63:25;
+		uint64_t max_pkt:3;
+		uint64_t praddr:3;
+		uint64_t ptr:29;
+		uint64_t cena:1;
+		uint64_t raddr:3;
+	} s;
+	struct cvmx_ipd_prc_hold_ptr_fifo_ctl_s cn30xx;
+	struct cvmx_ipd_prc_hold_ptr_fifo_ctl_s cn31xx;
+	struct cvmx_ipd_prc_hold_ptr_fifo_ctl_s cn38xx;
+	struct cvmx_ipd_prc_hold_ptr_fifo_ctl_s cn50xx;
+	struct cvmx_ipd_prc_hold_ptr_fifo_ctl_s cn52xx;
+	struct cvmx_ipd_prc_hold_ptr_fifo_ctl_s cn52xxp1;
+	struct cvmx_ipd_prc_hold_ptr_fifo_ctl_s cn56xx;
+	struct cvmx_ipd_prc_hold_ptr_fifo_ctl_s cn56xxp1;
+	struct cvmx_ipd_prc_hold_ptr_fifo_ctl_s cn58xx;
+	struct cvmx_ipd_prc_hold_ptr_fifo_ctl_s cn58xxp1;
+} cvmx_ipd_prc_hold_ptr_fifo_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_prc_port_ptr_fifo_ctl_s {
+		uint64_t reserved_44_63:20;
+		uint64_t max_pkt:7;
+		uint64_t ptr:29;
+		uint64_t cena:1;
+		uint64_t raddr:7;
+	} s;
+	struct cvmx_ipd_prc_port_ptr_fifo_ctl_s cn30xx;
+	struct cvmx_ipd_prc_port_ptr_fifo_ctl_s cn31xx;
+	struct cvmx_ipd_prc_port_ptr_fifo_ctl_s cn38xx;
+	struct cvmx_ipd_prc_port_ptr_fifo_ctl_s cn50xx;
+	struct cvmx_ipd_prc_port_ptr_fifo_ctl_s cn52xx;
+	struct cvmx_ipd_prc_port_ptr_fifo_ctl_s cn52xxp1;
+	struct cvmx_ipd_prc_port_ptr_fifo_ctl_s cn56xx;
+	struct cvmx_ipd_prc_port_ptr_fifo_ctl_s cn56xxp1;
+	struct cvmx_ipd_prc_port_ptr_fifo_ctl_s cn58xx;
+	struct cvmx_ipd_prc_port_ptr_fifo_ctl_s cn58xxp1;
+} cvmx_ipd_prc_port_ptr_fifo_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_ptr_count_s {
+		uint64_t reserved_19_63:45;
+		uint64_t pktv_cnt:1;
+		uint64_t wqev_cnt:1;
+		uint64_t pfif_cnt:3;
+		uint64_t pkt_pcnt:7;
+		uint64_t wqe_pcnt:7;
+	} s;
+	struct cvmx_ipd_ptr_count_s cn30xx;
+	struct cvmx_ipd_ptr_count_s cn31xx;
+	struct cvmx_ipd_ptr_count_s cn38xx;
+	struct cvmx_ipd_ptr_count_s cn38xxp2;
+	struct cvmx_ipd_ptr_count_s cn50xx;
+	struct cvmx_ipd_ptr_count_s cn52xx;
+	struct cvmx_ipd_ptr_count_s cn52xxp1;
+	struct cvmx_ipd_ptr_count_s cn56xx;
+	struct cvmx_ipd_ptr_count_s cn56xxp1;
+	struct cvmx_ipd_ptr_count_s cn58xx;
+	struct cvmx_ipd_ptr_count_s cn58xxp1;
+} cvmx_ipd_ptr_count_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_pwp_ptr_fifo_ctl_s {
+		uint64_t reserved_61_63:3;
+		uint64_t max_cnts:7;
+		uint64_t wraddr:8;
+		uint64_t praddr:8;
+		uint64_t ptr:29;
+		uint64_t cena:1;
+		uint64_t raddr:8;
+	} s;
+	struct cvmx_ipd_pwp_ptr_fifo_ctl_s cn30xx;
+	struct cvmx_ipd_pwp_ptr_fifo_ctl_s cn31xx;
+	struct cvmx_ipd_pwp_ptr_fifo_ctl_s cn38xx;
+	struct cvmx_ipd_pwp_ptr_fifo_ctl_s cn50xx;
+	struct cvmx_ipd_pwp_ptr_fifo_ctl_s cn52xx;
+	struct cvmx_ipd_pwp_ptr_fifo_ctl_s cn52xxp1;
+	struct cvmx_ipd_pwp_ptr_fifo_ctl_s cn56xx;
+	struct cvmx_ipd_pwp_ptr_fifo_ctl_s cn56xxp1;
+	struct cvmx_ipd_pwp_ptr_fifo_ctl_s cn58xx;
+	struct cvmx_ipd_pwp_ptr_fifo_ctl_s cn58xxp1;
+} cvmx_ipd_pwp_ptr_fifo_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_qosx_red_marks_s {
+		uint64_t drop:32;
+		uint64_t pass:32;
+	} s;
+	struct cvmx_ipd_qosx_red_marks_s cn30xx;
+	struct cvmx_ipd_qosx_red_marks_s cn31xx;
+	struct cvmx_ipd_qosx_red_marks_s cn38xx;
+	struct cvmx_ipd_qosx_red_marks_s cn38xxp2;
+	struct cvmx_ipd_qosx_red_marks_s cn50xx;
+	struct cvmx_ipd_qosx_red_marks_s cn52xx;
+	struct cvmx_ipd_qosx_red_marks_s cn52xxp1;
+	struct cvmx_ipd_qosx_red_marks_s cn56xx;
+	struct cvmx_ipd_qosx_red_marks_s cn56xxp1;
+	struct cvmx_ipd_qosx_red_marks_s cn58xx;
+	struct cvmx_ipd_qosx_red_marks_s cn58xxp1;
+} cvmx_ipd_qosx_red_marks_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_que0_free_page_cnt_s {
+		uint64_t reserved_32_63:32;
+		uint64_t q0_pcnt:32;
+	} s;
+	struct cvmx_ipd_que0_free_page_cnt_s cn30xx;
+	struct cvmx_ipd_que0_free_page_cnt_s cn31xx;
+	struct cvmx_ipd_que0_free_page_cnt_s cn38xx;
+	struct cvmx_ipd_que0_free_page_cnt_s cn38xxp2;
+	struct cvmx_ipd_que0_free_page_cnt_s cn50xx;
+	struct cvmx_ipd_que0_free_page_cnt_s cn52xx;
+	struct cvmx_ipd_que0_free_page_cnt_s cn52xxp1;
+	struct cvmx_ipd_que0_free_page_cnt_s cn56xx;
+	struct cvmx_ipd_que0_free_page_cnt_s cn56xxp1;
+	struct cvmx_ipd_que0_free_page_cnt_s cn58xx;
+	struct cvmx_ipd_que0_free_page_cnt_s cn58xxp1;
+} cvmx_ipd_que0_free_page_cnt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_red_port_enable_s {
+		uint64_t prb_dly:14;
+		uint64_t avg_dly:14;
+		uint64_t prt_enb:36;
+	} s;
+	struct cvmx_ipd_red_port_enable_s cn30xx;
+	struct cvmx_ipd_red_port_enable_s cn31xx;
+	struct cvmx_ipd_red_port_enable_s cn38xx;
+	struct cvmx_ipd_red_port_enable_s cn38xxp2;
+	struct cvmx_ipd_red_port_enable_s cn50xx;
+	struct cvmx_ipd_red_port_enable_s cn52xx;
+	struct cvmx_ipd_red_port_enable_s cn52xxp1;
+	struct cvmx_ipd_red_port_enable_s cn56xx;
+	struct cvmx_ipd_red_port_enable_s cn56xxp1;
+	struct cvmx_ipd_red_port_enable_s cn58xx;
+	struct cvmx_ipd_red_port_enable_s cn58xxp1;
+} cvmx_ipd_red_port_enable_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_red_port_enable2_s {
+		uint64_t reserved_4_63:60;
+		uint64_t prt_enb:4;
+	} s;
+	struct cvmx_ipd_red_port_enable2_s cn52xx;
+	struct cvmx_ipd_red_port_enable2_s cn52xxp1;
+	struct cvmx_ipd_red_port_enable2_s cn56xx;
+	struct cvmx_ipd_red_port_enable2_s cn56xxp1;
+} cvmx_ipd_red_port_enable2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_red_quex_param_s {
+		uint64_t reserved_49_63:15;
+		uint64_t use_pcnt:1;
+		uint64_t new_con:8;
+		uint64_t avg_con:8;
+		uint64_t prb_con:32;
+	} s;
+	struct cvmx_ipd_red_quex_param_s cn30xx;
+	struct cvmx_ipd_red_quex_param_s cn31xx;
+	struct cvmx_ipd_red_quex_param_s cn38xx;
+	struct cvmx_ipd_red_quex_param_s cn38xxp2;
+	struct cvmx_ipd_red_quex_param_s cn50xx;
+	struct cvmx_ipd_red_quex_param_s cn52xx;
+	struct cvmx_ipd_red_quex_param_s cn52xxp1;
+	struct cvmx_ipd_red_quex_param_s cn56xx;
+	struct cvmx_ipd_red_quex_param_s cn56xxp1;
+	struct cvmx_ipd_red_quex_param_s cn58xx;
+	struct cvmx_ipd_red_quex_param_s cn58xxp1;
+} cvmx_ipd_red_quex_param_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_sub_port_bp_page_cnt_s {
+		uint64_t reserved_31_63:33;
+		uint64_t port:6;
+		uint64_t page_cnt:25;
+	} s;
+	struct cvmx_ipd_sub_port_bp_page_cnt_s cn30xx;
+	struct cvmx_ipd_sub_port_bp_page_cnt_s cn31xx;
+	struct cvmx_ipd_sub_port_bp_page_cnt_s cn38xx;
+	struct cvmx_ipd_sub_port_bp_page_cnt_s cn38xxp2;
+	struct cvmx_ipd_sub_port_bp_page_cnt_s cn50xx;
+	struct cvmx_ipd_sub_port_bp_page_cnt_s cn52xx;
+	struct cvmx_ipd_sub_port_bp_page_cnt_s cn52xxp1;
+	struct cvmx_ipd_sub_port_bp_page_cnt_s cn56xx;
+	struct cvmx_ipd_sub_port_bp_page_cnt_s cn56xxp1;
+	struct cvmx_ipd_sub_port_bp_page_cnt_s cn58xx;
+	struct cvmx_ipd_sub_port_bp_page_cnt_s cn58xxp1;
+} cvmx_ipd_sub_port_bp_page_cnt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_sub_port_fcs_s {
+		uint64_t reserved_40_63:24;
+		uint64_t port_bit2:4;
+		uint64_t reserved_32_35:4;
+		uint64_t port_bit:32;
+	} s;
+	struct cvmx_ipd_sub_port_fcs_cn30xx {
+		uint64_t reserved_3_63:61;
+		uint64_t port_bit:3;
+	} cn30xx;
+	struct cvmx_ipd_sub_port_fcs_cn30xx cn31xx;
+	struct cvmx_ipd_sub_port_fcs_cn38xx {
+		uint64_t reserved_32_63:32;
+		uint64_t port_bit:32;
+	} cn38xx;
+	struct cvmx_ipd_sub_port_fcs_cn38xx cn38xxp2;
+	struct cvmx_ipd_sub_port_fcs_cn30xx cn50xx;
+	struct cvmx_ipd_sub_port_fcs_s cn52xx;
+	struct cvmx_ipd_sub_port_fcs_s cn52xxp1;
+	struct cvmx_ipd_sub_port_fcs_s cn56xx;
+	struct cvmx_ipd_sub_port_fcs_s cn56xxp1;
+	struct cvmx_ipd_sub_port_fcs_cn38xx cn58xx;
+	struct cvmx_ipd_sub_port_fcs_cn38xx cn58xxp1;
+} cvmx_ipd_sub_port_fcs_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_sub_port_qos_cnt_s {
+		uint64_t reserved_41_63:23;
+		uint64_t port_qos:9;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_ipd_sub_port_qos_cnt_s cn52xx;
+	struct cvmx_ipd_sub_port_qos_cnt_s cn52xxp1;
+	struct cvmx_ipd_sub_port_qos_cnt_s cn56xx;
+	struct cvmx_ipd_sub_port_qos_cnt_s cn56xxp1;
+} cvmx_ipd_sub_port_qos_cnt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_wqe_fpa_queue_s {
+		uint64_t reserved_3_63:61;
+		uint64_t wqe_pool:3;
+	} s;
+	struct cvmx_ipd_wqe_fpa_queue_s cn30xx;
+	struct cvmx_ipd_wqe_fpa_queue_s cn31xx;
+	struct cvmx_ipd_wqe_fpa_queue_s cn38xx;
+	struct cvmx_ipd_wqe_fpa_queue_s cn38xxp2;
+	struct cvmx_ipd_wqe_fpa_queue_s cn50xx;
+	struct cvmx_ipd_wqe_fpa_queue_s cn52xx;
+	struct cvmx_ipd_wqe_fpa_queue_s cn52xxp1;
+	struct cvmx_ipd_wqe_fpa_queue_s cn56xx;
+	struct cvmx_ipd_wqe_fpa_queue_s cn56xxp1;
+	struct cvmx_ipd_wqe_fpa_queue_s cn58xx;
+	struct cvmx_ipd_wqe_fpa_queue_s cn58xxp1;
+} cvmx_ipd_wqe_fpa_queue_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ipd_wqe_ptr_valid_s {
+		uint64_t reserved_29_63:35;
+		uint64_t ptr:29;
+	} s;
+	struct cvmx_ipd_wqe_ptr_valid_s cn30xx;
+	struct cvmx_ipd_wqe_ptr_valid_s cn31xx;
+	struct cvmx_ipd_wqe_ptr_valid_s cn38xx;
+	struct cvmx_ipd_wqe_ptr_valid_s cn50xx;
+	struct cvmx_ipd_wqe_ptr_valid_s cn52xx;
+	struct cvmx_ipd_wqe_ptr_valid_s cn52xxp1;
+	struct cvmx_ipd_wqe_ptr_valid_s cn56xx;
+	struct cvmx_ipd_wqe_ptr_valid_s cn56xxp1;
+	struct cvmx_ipd_wqe_ptr_valid_s cn58xx;
+	struct cvmx_ipd_wqe_ptr_valid_s cn58xxp1;
+} cvmx_ipd_wqe_ptr_valid_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_key_bist_reg_s {
+		uint64_t reserved_3_63:61;
+		uint64_t rrc:1;
+		uint64_t mem1:1;
+		uint64_t mem0:1;
+	} s;
+	struct cvmx_key_bist_reg_s cn38xx;
+	struct cvmx_key_bist_reg_s cn38xxp2;
+	struct cvmx_key_bist_reg_s cn56xx;
+	struct cvmx_key_bist_reg_s cn56xxp1;
+	struct cvmx_key_bist_reg_s cn58xx;
+	struct cvmx_key_bist_reg_s cn58xxp1;
+} cvmx_key_bist_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_key_ctl_status_s {
+		uint64_t reserved_14_63:50;
+		uint64_t mem1_err:7;
+		uint64_t mem0_err:7;
+	} s;
+	struct cvmx_key_ctl_status_s cn38xx;
+	struct cvmx_key_ctl_status_s cn38xxp2;
+	struct cvmx_key_ctl_status_s cn56xx;
+	struct cvmx_key_ctl_status_s cn56xxp1;
+	struct cvmx_key_ctl_status_s cn58xx;
+	struct cvmx_key_ctl_status_s cn58xxp1;
+} cvmx_key_ctl_status_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_key_int_enb_s {
+		uint64_t reserved_4_63:60;
+		uint64_t ked1_dbe:1;
+		uint64_t ked1_sbe:1;
+		uint64_t ked0_dbe:1;
+		uint64_t ked0_sbe:1;
+	} s;
+	struct cvmx_key_int_enb_s cn38xx;
+	struct cvmx_key_int_enb_s cn38xxp2;
+	struct cvmx_key_int_enb_s cn56xx;
+	struct cvmx_key_int_enb_s cn56xxp1;
+	struct cvmx_key_int_enb_s cn58xx;
+	struct cvmx_key_int_enb_s cn58xxp1;
+} cvmx_key_int_enb_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_key_int_sum_s {
+		uint64_t reserved_4_63:60;
+		uint64_t ked1_dbe:1;
+		uint64_t ked1_sbe:1;
+		uint64_t ked0_dbe:1;
+		uint64_t ked0_sbe:1;
+	} s;
+	struct cvmx_key_int_sum_s cn38xx;
+	struct cvmx_key_int_sum_s cn38xxp2;
+	struct cvmx_key_int_sum_s cn56xx;
+	struct cvmx_key_int_sum_s cn56xxp1;
+	struct cvmx_key_int_sum_s cn58xx;
+	struct cvmx_key_int_sum_s cn58xxp1;
+} cvmx_key_int_sum_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_bst0_s {
+		uint64_t reserved_24_63:40;
+		uint64_t dtbnk:1;
+		uint64_t wlb_msk:4;
+		uint64_t dtcnt:13;
+		uint64_t dt:1;
+		uint64_t stin_msk:1;
+		uint64_t wlb_dat:4;
+	} s;
+	struct cvmx_l2c_bst0_cn30xx {
+		uint64_t reserved_23_63:41;
+		uint64_t wlb_msk:4;
+		uint64_t reserved_15_18:4;
+		uint64_t dtcnt:9;
+		uint64_t dt:1;
+		uint64_t reserved_4_4:1;
+		uint64_t wlb_dat:4;
+	} cn30xx;
+	struct cvmx_l2c_bst0_cn31xx {
+		uint64_t reserved_23_63:41;
+		uint64_t wlb_msk:4;
+		uint64_t reserved_16_18:3;
+		uint64_t dtcnt:10;
+		uint64_t dt:1;
+		uint64_t stin_msk:1;
+		uint64_t wlb_dat:4;
+	} cn31xx;
+	struct cvmx_l2c_bst0_cn38xx {
+		uint64_t reserved_19_63:45;
+		uint64_t dtcnt:13;
+		uint64_t dt:1;
+		uint64_t stin_msk:1;
+		uint64_t wlb_dat:4;
+	} cn38xx;
+	struct cvmx_l2c_bst0_cn38xx cn38xxp2;
+	struct cvmx_l2c_bst0_cn50xx {
+		uint64_t reserved_24_63:40;
+		uint64_t dtbnk:1;
+		uint64_t wlb_msk:4;
+		uint64_t reserved_16_18:3;
+		uint64_t dtcnt:10;
+		uint64_t dt:1;
+		uint64_t stin_msk:1;
+		uint64_t wlb_dat:4;
+	} cn50xx;
+	struct cvmx_l2c_bst0_cn50xx cn52xx;
+	struct cvmx_l2c_bst0_cn50xx cn52xxp1;
+	struct cvmx_l2c_bst0_s cn56xx;
+	struct cvmx_l2c_bst0_s cn56xxp1;
+	struct cvmx_l2c_bst0_s cn58xx;
+	struct cvmx_l2c_bst0_s cn58xxp1;
+} cvmx_l2c_bst0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_bst1_s {
+		uint64_t reserved_9_63:55;
+		uint64_t l2t:9;
+	} s;
+	struct cvmx_l2c_bst1_cn30xx {
+		uint64_t reserved_16_63:48;
+		uint64_t vwdf:4;
+		uint64_t lrf:2;
+		uint64_t vab_vwcf:1;
+		uint64_t reserved_5_8:4;
+		uint64_t l2t:5;
+	} cn30xx;
+	struct cvmx_l2c_bst1_cn30xx cn31xx;
+	struct cvmx_l2c_bst1_cn38xx {
+		uint64_t reserved_16_63:48;
+		uint64_t vwdf:4;
+		uint64_t lrf:2;
+		uint64_t vab_vwcf:1;
+		uint64_t l2t:9;
+	} cn38xx;
+	struct cvmx_l2c_bst1_cn38xx cn38xxp2;
+	struct cvmx_l2c_bst1_cn38xx cn50xx;
+	struct cvmx_l2c_bst1_cn52xx {
+		uint64_t reserved_19_63:45;
+		uint64_t plc2:1;
+		uint64_t plc1:1;
+		uint64_t plc0:1;
+		uint64_t vwdf:4;
+		uint64_t reserved_11_11:1;
+		uint64_t ilc:1;
+		uint64_t vab_vwcf:1;
+		uint64_t l2t:9;
+	} cn52xx;
+	struct cvmx_l2c_bst1_cn52xx cn52xxp1;
+	struct cvmx_l2c_bst1_cn56xx {
+		uint64_t reserved_24_63:40;
+		uint64_t plc2:1;
+		uint64_t plc1:1;
+		uint64_t plc0:1;
+		uint64_t ilc:1;
+		uint64_t vwdf1:4;
+		uint64_t vwdf0:4;
+		uint64_t vab_vwcf1:1;
+		uint64_t reserved_10_10:1;
+		uint64_t vab_vwcf0:1;
+		uint64_t l2t:9;
+	} cn56xx;
+	struct cvmx_l2c_bst1_cn56xx cn56xxp1;
+	struct cvmx_l2c_bst1_cn38xx cn58xx;
+	struct cvmx_l2c_bst1_cn38xx cn58xxp1;
+} cvmx_l2c_bst1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_bst2_s {
+		uint64_t reserved_16_63:48;
+		uint64_t mrb:4;
+		uint64_t reserved_4_11:8;
+		uint64_t ipcbst:1;
+		uint64_t picbst:1;
+		uint64_t xrdmsk:1;
+		uint64_t xrddat:1;
+	} s;
+	struct cvmx_l2c_bst2_cn30xx {
+		uint64_t reserved_16_63:48;
+		uint64_t mrb:4;
+		uint64_t rmdf:4;
+		uint64_t reserved_4_7:4;
+		uint64_t ipcbst:1;
+		uint64_t reserved_2_2:1;
+		uint64_t xrdmsk:1;
+		uint64_t xrddat:1;
+	} cn30xx;
+	struct cvmx_l2c_bst2_cn30xx cn31xx;
+	struct cvmx_l2c_bst2_cn38xx {
+		uint64_t reserved_16_63:48;
+		uint64_t mrb:4;
+		uint64_t rmdf:4;
+		uint64_t rhdf:4;
+		uint64_t ipcbst:1;
+		uint64_t picbst:1;
+		uint64_t xrdmsk:1;
+		uint64_t xrddat:1;
+	} cn38xx;
+	struct cvmx_l2c_bst2_cn38xx cn38xxp2;
+	struct cvmx_l2c_bst2_cn30xx cn50xx;
+	struct cvmx_l2c_bst2_cn30xx cn52xx;
+	struct cvmx_l2c_bst2_cn30xx cn52xxp1;
+	struct cvmx_l2c_bst2_cn56xx {
+		uint64_t reserved_16_63:48;
+		uint64_t mrb:4;
+		uint64_t rmdb:4;
+		uint64_t rhdb:4;
+		uint64_t ipcbst:1;
+		uint64_t picbst:1;
+		uint64_t xrdmsk:1;
+		uint64_t xrddat:1;
+	} cn56xx;
+	struct cvmx_l2c_bst2_cn56xx cn56xxp1;
+	struct cvmx_l2c_bst2_cn56xx cn58xx;
+	struct cvmx_l2c_bst2_cn56xx cn58xxp1;
+} cvmx_l2c_bst2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_cfg_s {
+		uint64_t reserved_20_63:44;
+		uint64_t bstrun:1;
+		uint64_t lbist:1;
+		uint64_t xor_bank:1;
+		uint64_t dpres1:1;
+		uint64_t dpres0:1;
+		uint64_t dfill_dis:1;
+		uint64_t fpexp:4;
+		uint64_t fpempty:1;
+		uint64_t fpen:1;
+		uint64_t idxalias:1;
+		uint64_t mwf_crd:4;
+		uint64_t rsp_arb_mode:1;
+		uint64_t rfb_arb_mode:1;
+		uint64_t lrf_arb_mode:1;
+	} s;
+	struct cvmx_l2c_cfg_cn30xx {
+		uint64_t reserved_14_63:50;
+		uint64_t fpexp:4;
+		uint64_t fpempty:1;
+		uint64_t fpen:1;
+		uint64_t idxalias:1;
+		uint64_t mwf_crd:4;
+		uint64_t rsp_arb_mode:1;
+		uint64_t rfb_arb_mode:1;
+		uint64_t lrf_arb_mode:1;
+	} cn30xx;
+	struct cvmx_l2c_cfg_cn30xx cn31xx;
+	struct cvmx_l2c_cfg_cn30xx cn38xx;
+	struct cvmx_l2c_cfg_cn30xx cn38xxp2;
+	struct cvmx_l2c_cfg_cn50xx {
+		uint64_t reserved_20_63:44;
+		uint64_t bstrun:1;
+		uint64_t lbist:1;
+		uint64_t reserved_14_17:4;
+		uint64_t fpexp:4;
+		uint64_t fpempty:1;
+		uint64_t fpen:1;
+		uint64_t idxalias:1;
+		uint64_t mwf_crd:4;
+		uint64_t rsp_arb_mode:1;
+		uint64_t rfb_arb_mode:1;
+		uint64_t lrf_arb_mode:1;
+	} cn50xx;
+	struct cvmx_l2c_cfg_cn50xx cn52xx;
+	struct cvmx_l2c_cfg_cn50xx cn52xxp1;
+	struct cvmx_l2c_cfg_s cn56xx;
+	struct cvmx_l2c_cfg_s cn56xxp1;
+	struct cvmx_l2c_cfg_cn58xx {
+		uint64_t reserved_20_63:44;
+		uint64_t bstrun:1;
+		uint64_t lbist:1;
+		uint64_t reserved_15_17:3;
+		uint64_t dfill_dis:1;
+		uint64_t fpexp:4;
+		uint64_t fpempty:1;
+		uint64_t fpen:1;
+		uint64_t idxalias:1;
+		uint64_t mwf_crd:4;
+		uint64_t rsp_arb_mode:1;
+		uint64_t rfb_arb_mode:1;
+		uint64_t lrf_arb_mode:1;
+	} cn58xx;
+	struct cvmx_l2c_cfg_cn58xxp1 {
+		uint64_t reserved_15_63:49;
+		uint64_t dfill_dis:1;
+		uint64_t fpexp:4;
+		uint64_t fpempty:1;
+		uint64_t fpen:1;
+		uint64_t idxalias:1;
+		uint64_t mwf_crd:4;
+		uint64_t rsp_arb_mode:1;
+		uint64_t rfb_arb_mode:1;
+		uint64_t lrf_arb_mode:1;
+	} cn58xxp1;
+} cvmx_l2c_cfg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_dbg_s {
+		uint64_t reserved_15_63:49;
+		uint64_t lfb_enum:4;
+		uint64_t lfb_dmp:1;
+		uint64_t ppnum:4;
+		uint64_t set:3;
+		uint64_t finv:1;
+		uint64_t l2d:1;
+		uint64_t l2t:1;
+	} s;
+	struct cvmx_l2c_dbg_cn30xx {
+		uint64_t reserved_13_63:51;
+		uint64_t lfb_enum:2;
+		uint64_t lfb_dmp:1;
+		uint64_t reserved_5_9:5;
+		uint64_t set:2;
+		uint64_t finv:1;
+		uint64_t l2d:1;
+		uint64_t l2t:1;
+	} cn30xx;
+	struct cvmx_l2c_dbg_cn31xx {
+		uint64_t reserved_14_63:50;
+		uint64_t lfb_enum:3;
+		uint64_t lfb_dmp:1;
+		uint64_t reserved_7_9:3;
+		uint64_t ppnum:1;
+		uint64_t reserved_5_5:1;
+		uint64_t set:2;
+		uint64_t finv:1;
+		uint64_t l2d:1;
+		uint64_t l2t:1;
+	} cn31xx;
+	struct cvmx_l2c_dbg_s cn38xx;
+	struct cvmx_l2c_dbg_s cn38xxp2;
+	struct cvmx_l2c_dbg_cn50xx {
+		uint64_t reserved_14_63:50;
+		uint64_t lfb_enum:3;
+		uint64_t lfb_dmp:1;
+		uint64_t reserved_7_9:3;
+		uint64_t ppnum:1;
+		uint64_t set:3;
+		uint64_t finv:1;
+		uint64_t l2d:1;
+		uint64_t l2t:1;
+	} cn50xx;
+	struct cvmx_l2c_dbg_cn52xx {
+		uint64_t reserved_14_63:50;
+		uint64_t lfb_enum:3;
+		uint64_t lfb_dmp:1;
+		uint64_t reserved_8_9:2;
+		uint64_t ppnum:2;
+		uint64_t set:3;
+		uint64_t finv:1;
+		uint64_t l2d:1;
+		uint64_t l2t:1;
+	} cn52xx;
+	struct cvmx_l2c_dbg_cn52xx cn52xxp1;
+	struct cvmx_l2c_dbg_s cn56xx;
+	struct cvmx_l2c_dbg_s cn56xxp1;
+	struct cvmx_l2c_dbg_s cn58xx;
+	struct cvmx_l2c_dbg_s cn58xxp1;
+} cvmx_l2c_dbg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_dut_s {
+		uint64_t reserved_32_63:32;
+		uint64_t dtena:1;
+		uint64_t reserved_30_30:1;
+		uint64_t dt_vld:1;
+		uint64_t dt_tag:29;
+	} s;
+	struct cvmx_l2c_dut_s cn30xx;
+	struct cvmx_l2c_dut_s cn31xx;
+	struct cvmx_l2c_dut_s cn38xx;
+	struct cvmx_l2c_dut_s cn38xxp2;
+	struct cvmx_l2c_dut_s cn50xx;
+	struct cvmx_l2c_dut_s cn52xx;
+	struct cvmx_l2c_dut_s cn52xxp1;
+	struct cvmx_l2c_dut_s cn56xx;
+	struct cvmx_l2c_dut_s cn56xxp1;
+	struct cvmx_l2c_dut_s cn58xx;
+	struct cvmx_l2c_dut_s cn58xxp1;
+} cvmx_l2c_dut_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_grpwrr0_s {
+		uint64_t plc1rmsk:32;
+		uint64_t plc0rmsk:32;
+	} s;
+	struct cvmx_l2c_grpwrr0_s cn52xx;
+	struct cvmx_l2c_grpwrr0_s cn52xxp1;
+	struct cvmx_l2c_grpwrr0_s cn56xx;
+	struct cvmx_l2c_grpwrr0_s cn56xxp1;
+} cvmx_l2c_grpwrr0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_grpwrr1_s {
+		uint64_t ilcrmsk:32;
+		uint64_t plc2rmsk:32;
+	} s;
+	struct cvmx_l2c_grpwrr1_s cn52xx;
+	struct cvmx_l2c_grpwrr1_s cn52xxp1;
+	struct cvmx_l2c_grpwrr1_s cn56xx;
+	struct cvmx_l2c_grpwrr1_s cn56xxp1;
+} cvmx_l2c_grpwrr1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_int_en_s {
+		uint64_t reserved_9_63:55;
+		uint64_t lck2ena:1;
+		uint64_t lckena:1;
+		uint64_t l2ddeden:1;
+		uint64_t l2dsecen:1;
+		uint64_t l2tdeden:1;
+		uint64_t l2tsecen:1;
+		uint64_t oob3en:1;
+		uint64_t oob2en:1;
+		uint64_t oob1en:1;
+	} s;
+	struct cvmx_l2c_int_en_s cn52xx;
+	struct cvmx_l2c_int_en_s cn52xxp1;
+	struct cvmx_l2c_int_en_s cn56xx;
+	struct cvmx_l2c_int_en_s cn56xxp1;
+} cvmx_l2c_int_en_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_int_stat_s {
+		uint64_t reserved_9_63:55;
+		uint64_t lck2:1;
+		uint64_t lck:1;
+		uint64_t l2dded:1;
+		uint64_t l2dsec:1;
+		uint64_t l2tded:1;
+		uint64_t l2tsec:1;
+		uint64_t oob3:1;
+		uint64_t oob2:1;
+		uint64_t oob1:1;
+	} s;
+	struct cvmx_l2c_int_stat_s cn52xx;
+	struct cvmx_l2c_int_stat_s cn52xxp1;
+	struct cvmx_l2c_int_stat_s cn56xx;
+	struct cvmx_l2c_int_stat_s cn56xxp1;
+} cvmx_l2c_int_stat_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_lckbase_s {
+		uint64_t reserved_31_63:33;
+		uint64_t lck_base:27;
+		uint64_t reserved_1_3:3;
+		uint64_t lck_ena:1;
+	} s;
+	struct cvmx_l2c_lckbase_s cn30xx;
+	struct cvmx_l2c_lckbase_s cn31xx;
+	struct cvmx_l2c_lckbase_s cn38xx;
+	struct cvmx_l2c_lckbase_s cn38xxp2;
+	struct cvmx_l2c_lckbase_s cn50xx;
+	struct cvmx_l2c_lckbase_s cn52xx;
+	struct cvmx_l2c_lckbase_s cn52xxp1;
+	struct cvmx_l2c_lckbase_s cn56xx;
+	struct cvmx_l2c_lckbase_s cn56xxp1;
+	struct cvmx_l2c_lckbase_s cn58xx;
+	struct cvmx_l2c_lckbase_s cn58xxp1;
+} cvmx_l2c_lckbase_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_lckoff_s {
+		uint64_t reserved_10_63:54;
+		uint64_t lck_offset:10;
+	} s;
+	struct cvmx_l2c_lckoff_s cn30xx;
+	struct cvmx_l2c_lckoff_s cn31xx;
+	struct cvmx_l2c_lckoff_s cn38xx;
+	struct cvmx_l2c_lckoff_s cn38xxp2;
+	struct cvmx_l2c_lckoff_s cn50xx;
+	struct cvmx_l2c_lckoff_s cn52xx;
+	struct cvmx_l2c_lckoff_s cn52xxp1;
+	struct cvmx_l2c_lckoff_s cn56xx;
+	struct cvmx_l2c_lckoff_s cn56xxp1;
+	struct cvmx_l2c_lckoff_s cn58xx;
+	struct cvmx_l2c_lckoff_s cn58xxp1;
+} cvmx_l2c_lckoff_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_lfb0_s {
+		uint64_t reserved_32_63:32;
+		uint64_t stcpnd:1;
+		uint64_t stpnd:1;
+		uint64_t stinv:1;
+		uint64_t stcfl:1;
+		uint64_t vam:1;
+		uint64_t inxt:4;
+		uint64_t itl:1;
+		uint64_t ihd:1;
+		uint64_t set:3;
+		uint64_t vabnum:4;
+		uint64_t sid:9;
+		uint64_t cmd:4;
+		uint64_t vld:1;
+	} s;
+	struct cvmx_l2c_lfb0_cn30xx {
+		uint64_t reserved_32_63:32;
+		uint64_t stcpnd:1;
+		uint64_t stpnd:1;
+		uint64_t stinv:1;
+		uint64_t stcfl:1;
+		uint64_t vam:1;
+		uint64_t reserved_25_26:2;
+		uint64_t inxt:2;
+		uint64_t itl:1;
+		uint64_t ihd:1;
+		uint64_t reserved_20_20:1;
+		uint64_t set:2;
+		uint64_t reserved_16_17:2;
+		uint64_t vabnum:2;
+		uint64_t sid:9;
+		uint64_t cmd:4;
+		uint64_t vld:1;
+	} cn30xx;
+	struct cvmx_l2c_lfb0_cn31xx {
+		uint64_t reserved_32_63:32;
+		uint64_t stcpnd:1;
+		uint64_t stpnd:1;
+		uint64_t stinv:1;
+		uint64_t stcfl:1;
+		uint64_t vam:1;
+		uint64_t reserved_26_26:1;
+		uint64_t inxt:3;
+		uint64_t itl:1;
+		uint64_t ihd:1;
+		uint64_t reserved_20_20:1;
+		uint64_t set:2;
+		uint64_t reserved_17_17:1;
+		uint64_t vabnum:3;
+		uint64_t sid:9;
+		uint64_t cmd:4;
+		uint64_t vld:1;
+	} cn31xx;
+	struct cvmx_l2c_lfb0_s cn38xx;
+	struct cvmx_l2c_lfb0_s cn38xxp2;
+	struct cvmx_l2c_lfb0_cn50xx {
+		uint64_t reserved_32_63:32;
+		uint64_t stcpnd:1;
+		uint64_t stpnd:1;
+		uint64_t stinv:1;
+		uint64_t stcfl:1;
+		uint64_t vam:1;
+		uint64_t reserved_26_26:1;
+		uint64_t inxt:3;
+		uint64_t itl:1;
+		uint64_t ihd:1;
+		uint64_t set:3;
+		uint64_t reserved_17_17:1;
+		uint64_t vabnum:3;
+		uint64_t sid:9;
+		uint64_t cmd:4;
+		uint64_t vld:1;
+	} cn50xx;
+	struct cvmx_l2c_lfb0_cn50xx cn52xx;
+	struct cvmx_l2c_lfb0_cn50xx cn52xxp1;
+	struct cvmx_l2c_lfb0_s cn56xx;
+	struct cvmx_l2c_lfb0_s cn56xxp1;
+	struct cvmx_l2c_lfb0_s cn58xx;
+	struct cvmx_l2c_lfb0_s cn58xxp1;
+} cvmx_l2c_lfb0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_lfb1_s {
+		uint64_t reserved_19_63:45;
+		uint64_t dsgoing:1;
+		uint64_t bid:2;
+		uint64_t wtrsp:1;
+		uint64_t wtdw:1;
+		uint64_t wtdq:1;
+		uint64_t wtwhp:1;
+		uint64_t wtwhf:1;
+		uint64_t wtwrm:1;
+		uint64_t wtstm:1;
+		uint64_t wtrda:1;
+		uint64_t wtstdt:1;
+		uint64_t wtstrsp:1;
+		uint64_t wtstrsc:1;
+		uint64_t wtvtm:1;
+		uint64_t wtmfl:1;
+		uint64_t prbrty:1;
+		uint64_t wtprb:1;
+		uint64_t vld:1;
+	} s;
+	struct cvmx_l2c_lfb1_s cn30xx;
+	struct cvmx_l2c_lfb1_s cn31xx;
+	struct cvmx_l2c_lfb1_s cn38xx;
+	struct cvmx_l2c_lfb1_s cn38xxp2;
+	struct cvmx_l2c_lfb1_s cn50xx;
+	struct cvmx_l2c_lfb1_s cn52xx;
+	struct cvmx_l2c_lfb1_s cn52xxp1;
+	struct cvmx_l2c_lfb1_s cn56xx;
+	struct cvmx_l2c_lfb1_s cn56xxp1;
+	struct cvmx_l2c_lfb1_s cn58xx;
+	struct cvmx_l2c_lfb1_s cn58xxp1;
+} cvmx_l2c_lfb1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_lfb2_s {
+		uint64_t reserved_0_63:64;
+	} s;
+	struct cvmx_l2c_lfb2_cn30xx {
+		uint64_t reserved_27_63:37;
+		uint64_t lfb_tag:19;
+		uint64_t lfb_idx:8;
+	} cn30xx;
+	struct cvmx_l2c_lfb2_cn31xx {
+		uint64_t reserved_27_63:37;
+		uint64_t lfb_tag:17;
+		uint64_t lfb_idx:10;
+	} cn31xx;
+	struct cvmx_l2c_lfb2_cn31xx cn38xx;
+	struct cvmx_l2c_lfb2_cn31xx cn38xxp2;
+	struct cvmx_l2c_lfb2_cn50xx {
+		uint64_t reserved_27_63:37;
+		uint64_t lfb_tag:20;
+		uint64_t lfb_idx:7;
+	} cn50xx;
+	struct cvmx_l2c_lfb2_cn52xx {
+		uint64_t reserved_27_63:37;
+		uint64_t lfb_tag:18;
+		uint64_t lfb_idx:9;
+	} cn52xx;
+	struct cvmx_l2c_lfb2_cn52xx cn52xxp1;
+	struct cvmx_l2c_lfb2_cn56xx {
+		uint64_t reserved_27_63:37;
+		uint64_t lfb_tag:16;
+		uint64_t lfb_idx:11;
+	} cn56xx;
+	struct cvmx_l2c_lfb2_cn56xx cn56xxp1;
+	struct cvmx_l2c_lfb2_cn56xx cn58xx;
+	struct cvmx_l2c_lfb2_cn56xx cn58xxp1;
+} cvmx_l2c_lfb2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_lfb3_s {
+		uint64_t reserved_5_63:59;
+		uint64_t stpartdis:1;
+		uint64_t lfb_hwm:4;
+	} s;
+	struct cvmx_l2c_lfb3_cn30xx {
+		uint64_t reserved_5_63:59;
+		uint64_t stpartdis:1;
+		uint64_t reserved_2_3:2;
+		uint64_t lfb_hwm:2;
+	} cn30xx;
+	struct cvmx_l2c_lfb3_cn31xx {
+		uint64_t reserved_5_63:59;
+		uint64_t stpartdis:1;
+		uint64_t reserved_3_3:1;
+		uint64_t lfb_hwm:3;
+	} cn31xx;
+	struct cvmx_l2c_lfb3_s cn38xx;
+	struct cvmx_l2c_lfb3_s cn38xxp2;
+	struct cvmx_l2c_lfb3_cn31xx cn50xx;
+	struct cvmx_l2c_lfb3_cn31xx cn52xx;
+	struct cvmx_l2c_lfb3_cn31xx cn52xxp1;
+	struct cvmx_l2c_lfb3_s cn56xx;
+	struct cvmx_l2c_lfb3_s cn56xxp1;
+	struct cvmx_l2c_lfb3_s cn58xx;
+	struct cvmx_l2c_lfb3_s cn58xxp1;
+} cvmx_l2c_lfb3_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_oob_s {
+		uint64_t reserved_2_63:62;
+		uint64_t dwbena:1;
+		uint64_t stena:1;
+	} s;
+	struct cvmx_l2c_oob_s cn52xx;
+	struct cvmx_l2c_oob_s cn52xxp1;
+	struct cvmx_l2c_oob_s cn56xx;
+	struct cvmx_l2c_oob_s cn56xxp1;
+} cvmx_l2c_oob_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_oob1_s {
+		uint64_t fadr:27;
+		uint64_t fsrc:1;
+		uint64_t reserved_34_35:2;
+		uint64_t sadr:14;
+		uint64_t reserved_14_19:6;
+		uint64_t size:14;
+	} s;
+	struct cvmx_l2c_oob1_s cn52xx;
+	struct cvmx_l2c_oob1_s cn52xxp1;
+	struct cvmx_l2c_oob1_s cn56xx;
+	struct cvmx_l2c_oob1_s cn56xxp1;
+} cvmx_l2c_oob1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_oob2_s {
+		uint64_t fadr:27;
+		uint64_t fsrc:1;
+		uint64_t reserved_34_35:2;
+		uint64_t sadr:14;
+		uint64_t reserved_14_19:6;
+		uint64_t size:14;
+	} s;
+	struct cvmx_l2c_oob2_s cn52xx;
+	struct cvmx_l2c_oob2_s cn52xxp1;
+	struct cvmx_l2c_oob2_s cn56xx;
+	struct cvmx_l2c_oob2_s cn56xxp1;
+} cvmx_l2c_oob2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_oob3_s {
+		uint64_t fadr:27;
+		uint64_t fsrc:1;
+		uint64_t reserved_34_35:2;
+		uint64_t sadr:14;
+		uint64_t reserved_14_19:6;
+		uint64_t size:14;
+	} s;
+	struct cvmx_l2c_oob3_s cn52xx;
+	struct cvmx_l2c_oob3_s cn52xxp1;
+	struct cvmx_l2c_oob3_s cn56xx;
+	struct cvmx_l2c_oob3_s cn56xxp1;
+} cvmx_l2c_oob3_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_pfcx_s {
+		uint64_t reserved_36_63:28;
+		uint64_t pfcnt0:36;
+	} s;
+	struct cvmx_l2c_pfcx_s cn30xx;
+	struct cvmx_l2c_pfcx_s cn31xx;
+	struct cvmx_l2c_pfcx_s cn38xx;
+	struct cvmx_l2c_pfcx_s cn38xxp2;
+	struct cvmx_l2c_pfcx_s cn50xx;
+	struct cvmx_l2c_pfcx_s cn52xx;
+	struct cvmx_l2c_pfcx_s cn52xxp1;
+	struct cvmx_l2c_pfcx_s cn56xx;
+	struct cvmx_l2c_pfcx_s cn56xxp1;
+	struct cvmx_l2c_pfcx_s cn58xx;
+	struct cvmx_l2c_pfcx_s cn58xxp1;
+} cvmx_l2c_pfcx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_pfctl_s {
+		uint64_t reserved_36_63:28;
+		uint64_t cnt3rdclr:1;
+		uint64_t cnt2rdclr:1;
+		uint64_t cnt1rdclr:1;
+		uint64_t cnt0rdclr:1;
+		uint64_t cnt3ena:1;
+		uint64_t cnt3clr:1;
+		uint64_t cnt3sel:6;
+		uint64_t cnt2ena:1;
+		uint64_t cnt2clr:1;
+		uint64_t cnt2sel:6;
+		uint64_t cnt1ena:1;
+		uint64_t cnt1clr:1;
+		uint64_t cnt1sel:6;
+		uint64_t cnt0ena:1;
+		uint64_t cnt0clr:1;
+		uint64_t cnt0sel:6;
+	} s;
+	struct cvmx_l2c_pfctl_s cn30xx;
+	struct cvmx_l2c_pfctl_s cn31xx;
+	struct cvmx_l2c_pfctl_s cn38xx;
+	struct cvmx_l2c_pfctl_s cn38xxp2;
+	struct cvmx_l2c_pfctl_s cn50xx;
+	struct cvmx_l2c_pfctl_s cn52xx;
+	struct cvmx_l2c_pfctl_s cn52xxp1;
+	struct cvmx_l2c_pfctl_s cn56xx;
+	struct cvmx_l2c_pfctl_s cn56xxp1;
+	struct cvmx_l2c_pfctl_s cn58xx;
+	struct cvmx_l2c_pfctl_s cn58xxp1;
+} cvmx_l2c_pfctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_ppgrp_s {
+		uint64_t reserved_24_63:40;
+		uint64_t pp11grp:2;
+		uint64_t pp10grp:2;
+		uint64_t pp9grp:2;
+		uint64_t pp8grp:2;
+		uint64_t pp7grp:2;
+		uint64_t pp6grp:2;
+		uint64_t pp5grp:2;
+		uint64_t pp4grp:2;
+		uint64_t pp3grp:2;
+		uint64_t pp2grp:2;
+		uint64_t pp1grp:2;
+		uint64_t pp0grp:2;
+	} s;
+	struct cvmx_l2c_ppgrp_cn52xx {
+		uint64_t reserved_8_63:56;
+		uint64_t pp3grp:2;
+		uint64_t pp2grp:2;
+		uint64_t pp1grp:2;
+		uint64_t pp0grp:2;
+	} cn52xx;
+	struct cvmx_l2c_ppgrp_cn52xx cn52xxp1;
+	struct cvmx_l2c_ppgrp_s cn56xx;
+	struct cvmx_l2c_ppgrp_s cn56xxp1;
+} cvmx_l2c_ppgrp_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_spar0_s {
+		uint64_t reserved_32_63:32;
+		uint64_t umsk3:8;
+		uint64_t umsk2:8;
+		uint64_t umsk1:8;
+		uint64_t umsk0:8;
+	} s;
+	struct cvmx_l2c_spar0_cn30xx {
+		uint64_t reserved_4_63:60;
+		uint64_t umsk0:4;
+	} cn30xx;
+	struct cvmx_l2c_spar0_cn31xx {
+		uint64_t reserved_12_63:52;
+		uint64_t umsk1:4;
+		uint64_t reserved_4_7:4;
+		uint64_t umsk0:4;
+	} cn31xx;
+	struct cvmx_l2c_spar0_s cn38xx;
+	struct cvmx_l2c_spar0_s cn38xxp2;
+	struct cvmx_l2c_spar0_cn50xx {
+		uint64_t reserved_16_63:48;
+		uint64_t umsk1:8;
+		uint64_t umsk0:8;
+	} cn50xx;
+	struct cvmx_l2c_spar0_s cn52xx;
+	struct cvmx_l2c_spar0_s cn52xxp1;
+	struct cvmx_l2c_spar0_s cn56xx;
+	struct cvmx_l2c_spar0_s cn56xxp1;
+	struct cvmx_l2c_spar0_s cn58xx;
+	struct cvmx_l2c_spar0_s cn58xxp1;
+} cvmx_l2c_spar0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_spar1_s {
+		uint64_t reserved_32_63:32;
+		uint64_t umsk7:8;
+		uint64_t umsk6:8;
+		uint64_t umsk5:8;
+		uint64_t umsk4:8;
+	} s;
+	struct cvmx_l2c_spar1_s cn38xx;
+	struct cvmx_l2c_spar1_s cn38xxp2;
+	struct cvmx_l2c_spar1_s cn56xx;
+	struct cvmx_l2c_spar1_s cn56xxp1;
+	struct cvmx_l2c_spar1_s cn58xx;
+	struct cvmx_l2c_spar1_s cn58xxp1;
+} cvmx_l2c_spar1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_spar2_s {
+		uint64_t reserved_32_63:32;
+		uint64_t umsk11:8;
+		uint64_t umsk10:8;
+		uint64_t umsk9:8;
+		uint64_t umsk8:8;
+	} s;
+	struct cvmx_l2c_spar2_s cn38xx;
+	struct cvmx_l2c_spar2_s cn38xxp2;
+	struct cvmx_l2c_spar2_s cn56xx;
+	struct cvmx_l2c_spar2_s cn56xxp1;
+	struct cvmx_l2c_spar2_s cn58xx;
+	struct cvmx_l2c_spar2_s cn58xxp1;
+} cvmx_l2c_spar2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_spar3_s {
+		uint64_t reserved_32_63:32;
+		uint64_t umsk15:8;
+		uint64_t umsk14:8;
+		uint64_t umsk13:8;
+		uint64_t umsk12:8;
+	} s;
+	struct cvmx_l2c_spar3_s cn38xx;
+	struct cvmx_l2c_spar3_s cn38xxp2;
+	struct cvmx_l2c_spar3_s cn58xx;
+	struct cvmx_l2c_spar3_s cn58xxp1;
+} cvmx_l2c_spar3_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_spar4_s {
+		uint64_t reserved_8_63:56;
+		uint64_t umskiob:8;
+	} s;
+	struct cvmx_l2c_spar4_cn30xx {
+		uint64_t reserved_4_63:60;
+		uint64_t umskiob:4;
+	} cn30xx;
+	struct cvmx_l2c_spar4_cn30xx cn31xx;
+	struct cvmx_l2c_spar4_s cn38xx;
+	struct cvmx_l2c_spar4_s cn38xxp2;
+	struct cvmx_l2c_spar4_s cn50xx;
+	struct cvmx_l2c_spar4_s cn52xx;
+	struct cvmx_l2c_spar4_s cn52xxp1;
+	struct cvmx_l2c_spar4_s cn56xx;
+	struct cvmx_l2c_spar4_s cn56xxp1;
+	struct cvmx_l2c_spar4_s cn58xx;
+	struct cvmx_l2c_spar4_s cn58xxp1;
+} cvmx_l2c_spar4_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2d_bst0_s {
+		uint64_t reserved_35_63:29;
+		uint64_t ftl:1;
+		uint64_t q0stat:34;
+	} s;
+	struct cvmx_l2d_bst0_s cn30xx;
+	struct cvmx_l2d_bst0_s cn31xx;
+	struct cvmx_l2d_bst0_s cn38xx;
+	struct cvmx_l2d_bst0_s cn38xxp2;
+	struct cvmx_l2d_bst0_s cn50xx;
+	struct cvmx_l2d_bst0_s cn52xx;
+	struct cvmx_l2d_bst0_s cn52xxp1;
+	struct cvmx_l2d_bst0_s cn56xx;
+	struct cvmx_l2d_bst0_s cn56xxp1;
+	struct cvmx_l2d_bst0_s cn58xx;
+	struct cvmx_l2d_bst0_s cn58xxp1;
+} cvmx_l2d_bst0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2d_bst1_s {
+		uint64_t reserved_34_63:30;
+		uint64_t q1stat:34;
+	} s;
+	struct cvmx_l2d_bst1_s cn30xx;
+	struct cvmx_l2d_bst1_s cn31xx;
+	struct cvmx_l2d_bst1_s cn38xx;
+	struct cvmx_l2d_bst1_s cn38xxp2;
+	struct cvmx_l2d_bst1_s cn50xx;
+	struct cvmx_l2d_bst1_s cn52xx;
+	struct cvmx_l2d_bst1_s cn52xxp1;
+	struct cvmx_l2d_bst1_s cn56xx;
+	struct cvmx_l2d_bst1_s cn56xxp1;
+	struct cvmx_l2d_bst1_s cn58xx;
+	struct cvmx_l2d_bst1_s cn58xxp1;
+} cvmx_l2d_bst1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2d_bst2_s {
+		uint64_t reserved_34_63:30;
+		uint64_t q2stat:34;
+	} s;
+	struct cvmx_l2d_bst2_s cn30xx;
+	struct cvmx_l2d_bst2_s cn31xx;
+	struct cvmx_l2d_bst2_s cn38xx;
+	struct cvmx_l2d_bst2_s cn38xxp2;
+	struct cvmx_l2d_bst2_s cn50xx;
+	struct cvmx_l2d_bst2_s cn52xx;
+	struct cvmx_l2d_bst2_s cn52xxp1;
+	struct cvmx_l2d_bst2_s cn56xx;
+	struct cvmx_l2d_bst2_s cn56xxp1;
+	struct cvmx_l2d_bst2_s cn58xx;
+	struct cvmx_l2d_bst2_s cn58xxp1;
+} cvmx_l2d_bst2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2d_bst3_s {
+		uint64_t reserved_34_63:30;
+		uint64_t q3stat:34;
+	} s;
+	struct cvmx_l2d_bst3_s cn30xx;
+	struct cvmx_l2d_bst3_s cn31xx;
+	struct cvmx_l2d_bst3_s cn38xx;
+	struct cvmx_l2d_bst3_s cn38xxp2;
+	struct cvmx_l2d_bst3_s cn50xx;
+	struct cvmx_l2d_bst3_s cn52xx;
+	struct cvmx_l2d_bst3_s cn52xxp1;
+	struct cvmx_l2d_bst3_s cn56xx;
+	struct cvmx_l2d_bst3_s cn56xxp1;
+	struct cvmx_l2d_bst3_s cn58xx;
+	struct cvmx_l2d_bst3_s cn58xxp1;
+} cvmx_l2d_bst3_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2d_err_s {
+		uint64_t reserved_6_63:58;
+		uint64_t bmhclsel:1;
+		uint64_t ded_err:1;
+		uint64_t sec_err:1;
+		uint64_t ded_intena:1;
+		uint64_t sec_intena:1;
+		uint64_t ecc_ena:1;
+	} s;
+	struct cvmx_l2d_err_s cn30xx;
+	struct cvmx_l2d_err_s cn31xx;
+	struct cvmx_l2d_err_s cn38xx;
+	struct cvmx_l2d_err_s cn38xxp2;
+	struct cvmx_l2d_err_s cn50xx;
+	struct cvmx_l2d_err_s cn52xx;
+	struct cvmx_l2d_err_s cn52xxp1;
+	struct cvmx_l2d_err_s cn56xx;
+	struct cvmx_l2d_err_s cn56xxp1;
+	struct cvmx_l2d_err_s cn58xx;
+	struct cvmx_l2d_err_s cn58xxp1;
+} cvmx_l2d_err_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2d_fadr_s {
+		uint64_t reserved_19_63:45;
+		uint64_t fadru:1;
+		uint64_t fowmsk:4;
+		uint64_t fset:3;
+		uint64_t fadr:11;
+	} s;
+	struct cvmx_l2d_fadr_cn30xx {
+		uint64_t reserved_18_63:46;
+		uint64_t fowmsk:4;
+		uint64_t reserved_13_13:1;
+		uint64_t fset:2;
+		uint64_t reserved_9_10:2;
+		uint64_t fadr:9;
+	} cn30xx;
+	struct cvmx_l2d_fadr_cn31xx {
+		uint64_t reserved_18_63:46;
+		uint64_t fowmsk:4;
+		uint64_t reserved_13_13:1;
+		uint64_t fset:2;
+		uint64_t reserved_10_10:1;
+		uint64_t fadr:10;
+	} cn31xx;
+	struct cvmx_l2d_fadr_cn38xx {
+		uint64_t reserved_18_63:46;
+		uint64_t fowmsk:4;
+		uint64_t fset:3;
+		uint64_t fadr:11;
+	} cn38xx;
+	struct cvmx_l2d_fadr_cn38xx cn38xxp2;
+	struct cvmx_l2d_fadr_cn50xx {
+		uint64_t reserved_18_63:46;
+		uint64_t fowmsk:4;
+		uint64_t fset:3;
+		uint64_t reserved_8_10:3;
+		uint64_t fadr:8;
+	} cn50xx;
+	struct cvmx_l2d_fadr_cn52xx {
+		uint64_t reserved_18_63:46;
+		uint64_t fowmsk:4;
+		uint64_t fset:3;
+		uint64_t reserved_10_10:1;
+		uint64_t fadr:10;
+	} cn52xx;
+	struct cvmx_l2d_fadr_cn52xx cn52xxp1;
+	struct cvmx_l2d_fadr_s cn56xx;
+	struct cvmx_l2d_fadr_s cn56xxp1;
+	struct cvmx_l2d_fadr_s cn58xx;
+	struct cvmx_l2d_fadr_s cn58xxp1;
+} cvmx_l2d_fadr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2d_fsyn0_s {
+		uint64_t reserved_20_63:44;
+		uint64_t fsyn_ow1:10;
+		uint64_t fsyn_ow0:10;
+	} s;
+	struct cvmx_l2d_fsyn0_s cn30xx;
+	struct cvmx_l2d_fsyn0_s cn31xx;
+	struct cvmx_l2d_fsyn0_s cn38xx;
+	struct cvmx_l2d_fsyn0_s cn38xxp2;
+	struct cvmx_l2d_fsyn0_s cn50xx;
+	struct cvmx_l2d_fsyn0_s cn52xx;
+	struct cvmx_l2d_fsyn0_s cn52xxp1;
+	struct cvmx_l2d_fsyn0_s cn56xx;
+	struct cvmx_l2d_fsyn0_s cn56xxp1;
+	struct cvmx_l2d_fsyn0_s cn58xx;
+	struct cvmx_l2d_fsyn0_s cn58xxp1;
+} cvmx_l2d_fsyn0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2d_fsyn1_s {
+		uint64_t reserved_20_63:44;
+		uint64_t fsyn_ow3:10;
+		uint64_t fsyn_ow2:10;
+	} s;
+	struct cvmx_l2d_fsyn1_s cn30xx;
+	struct cvmx_l2d_fsyn1_s cn31xx;
+	struct cvmx_l2d_fsyn1_s cn38xx;
+	struct cvmx_l2d_fsyn1_s cn38xxp2;
+	struct cvmx_l2d_fsyn1_s cn50xx;
+	struct cvmx_l2d_fsyn1_s cn52xx;
+	struct cvmx_l2d_fsyn1_s cn52xxp1;
+	struct cvmx_l2d_fsyn1_s cn56xx;
+	struct cvmx_l2d_fsyn1_s cn56xxp1;
+	struct cvmx_l2d_fsyn1_s cn58xx;
+	struct cvmx_l2d_fsyn1_s cn58xxp1;
+} cvmx_l2d_fsyn1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2d_fus0_s {
+		uint64_t reserved_34_63:30;
+		uint64_t q0fus:34;
+	} s;
+	struct cvmx_l2d_fus0_s cn30xx;
+	struct cvmx_l2d_fus0_s cn31xx;
+	struct cvmx_l2d_fus0_s cn38xx;
+	struct cvmx_l2d_fus0_s cn38xxp2;
+	struct cvmx_l2d_fus0_s cn50xx;
+	struct cvmx_l2d_fus0_s cn52xx;
+	struct cvmx_l2d_fus0_s cn52xxp1;
+	struct cvmx_l2d_fus0_s cn56xx;
+	struct cvmx_l2d_fus0_s cn56xxp1;
+	struct cvmx_l2d_fus0_s cn58xx;
+	struct cvmx_l2d_fus0_s cn58xxp1;
+} cvmx_l2d_fus0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2d_fus1_s {
+		uint64_t reserved_34_63:30;
+		uint64_t q1fus:34;
+	} s;
+	struct cvmx_l2d_fus1_s cn30xx;
+	struct cvmx_l2d_fus1_s cn31xx;
+	struct cvmx_l2d_fus1_s cn38xx;
+	struct cvmx_l2d_fus1_s cn38xxp2;
+	struct cvmx_l2d_fus1_s cn50xx;
+	struct cvmx_l2d_fus1_s cn52xx;
+	struct cvmx_l2d_fus1_s cn52xxp1;
+	struct cvmx_l2d_fus1_s cn56xx;
+	struct cvmx_l2d_fus1_s cn56xxp1;
+	struct cvmx_l2d_fus1_s cn58xx;
+	struct cvmx_l2d_fus1_s cn58xxp1;
+} cvmx_l2d_fus1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2d_fus2_s {
+		uint64_t reserved_34_63:30;
+		uint64_t q2fus:34;
+	} s;
+	struct cvmx_l2d_fus2_s cn30xx;
+	struct cvmx_l2d_fus2_s cn31xx;
+	struct cvmx_l2d_fus2_s cn38xx;
+	struct cvmx_l2d_fus2_s cn38xxp2;
+	struct cvmx_l2d_fus2_s cn50xx;
+	struct cvmx_l2d_fus2_s cn52xx;
+	struct cvmx_l2d_fus2_s cn52xxp1;
+	struct cvmx_l2d_fus2_s cn56xx;
+	struct cvmx_l2d_fus2_s cn56xxp1;
+	struct cvmx_l2d_fus2_s cn58xx;
+	struct cvmx_l2d_fus2_s cn58xxp1;
+} cvmx_l2d_fus2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2d_fus3_s {
+		uint64_t reserved_40_63:24;
+		uint64_t ema_ctl:3;
+		uint64_t reserved_34_36:3;
+		uint64_t q3fus:34;
+	} s;
+	struct cvmx_l2d_fus3_cn30xx {
+		uint64_t reserved_35_63:29;
+		uint64_t crip_64k:1;
+		uint64_t q3fus:34;
+	} cn30xx;
+	struct cvmx_l2d_fus3_cn31xx {
+		uint64_t reserved_35_63:29;
+		uint64_t crip_128k:1;
+		uint64_t q3fus:34;
+	} cn31xx;
+	struct cvmx_l2d_fus3_cn38xx {
+		uint64_t reserved_36_63:28;
+		uint64_t crip_256k:1;
+		uint64_t crip_512k:1;
+		uint64_t q3fus:34;
+	} cn38xx;
+	struct cvmx_l2d_fus3_cn38xx cn38xxp2;
+	struct cvmx_l2d_fus3_cn50xx {
+		uint64_t reserved_40_63:24;
+		uint64_t ema_ctl:3;
+		uint64_t reserved_36_36:1;
+		uint64_t crip_32k:1;
+		uint64_t crip_64k:1;
+		uint64_t q3fus:34;
+	} cn50xx;
+	struct cvmx_l2d_fus3_cn52xx {
+		uint64_t reserved_40_63:24;
+		uint64_t ema_ctl:3;
+		uint64_t reserved_36_36:1;
+		uint64_t crip_128k:1;
+		uint64_t crip_256k:1;
+		uint64_t q3fus:34;
+	} cn52xx;
+	struct cvmx_l2d_fus3_cn52xx cn52xxp1;
+	struct cvmx_l2d_fus3_cn56xx {
+		uint64_t reserved_40_63:24;
+		uint64_t ema_ctl:3;
+		uint64_t reserved_36_36:1;
+		uint64_t crip_512k:1;
+		uint64_t crip_1024k:1;
+		uint64_t q3fus:34;
+	} cn56xx;
+	struct cvmx_l2d_fus3_cn56xx cn56xxp1;
+	struct cvmx_l2d_fus3_cn58xx {
+		uint64_t reserved_39_63:25;
+		uint64_t ema_ctl:2;
+		uint64_t reserved_36_36:1;
+		uint64_t crip_512k:1;
+		uint64_t crip_1024k:1;
+		uint64_t q3fus:34;
+	} cn58xx;
+	struct cvmx_l2d_fus3_cn58xx cn58xxp1;
+} cvmx_l2d_fus3_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2t_err_s {
+		uint64_t reserved_29_63:35;
+		uint64_t fadru:1;
+		uint64_t lck_intena2:1;
+		uint64_t lckerr2:1;
+		uint64_t lck_intena:1;
+		uint64_t lckerr:1;
+		uint64_t fset:3;
+		uint64_t fadr:10;
+		uint64_t fsyn:6;
+		uint64_t ded_err:1;
+		uint64_t sec_err:1;
+		uint64_t ded_intena:1;
+		uint64_t sec_intena:1;
+		uint64_t ecc_ena:1;
+	} s;
+	struct cvmx_l2t_err_cn30xx {
+		uint64_t reserved_28_63:36;
+		uint64_t lck_intena2:1;
+		uint64_t lckerr2:1;
+		uint64_t lck_intena:1;
+		uint64_t lckerr:1;
+		uint64_t reserved_23_23:1;
+		uint64_t fset:2;
+		uint64_t reserved_19_20:2;
+		uint64_t fadr:8;
+		uint64_t fsyn:6;
+		uint64_t ded_err:1;
+		uint64_t sec_err:1;
+		uint64_t ded_intena:1;
+		uint64_t sec_intena:1;
+		uint64_t ecc_ena:1;
+	} cn30xx;
+	struct cvmx_l2t_err_cn31xx {
+		uint64_t reserved_28_63:36;
+		uint64_t lck_intena2:1;
+		uint64_t lckerr2:1;
+		uint64_t lck_intena:1;
+		uint64_t lckerr:1;
+		uint64_t reserved_23_23:1;
+		uint64_t fset:2;
+		uint64_t reserved_20_20:1;
+		uint64_t fadr:9;
+		uint64_t fsyn:6;
+		uint64_t ded_err:1;
+		uint64_t sec_err:1;
+		uint64_t ded_intena:1;
+		uint64_t sec_intena:1;
+		uint64_t ecc_ena:1;
+	} cn31xx;
+	struct cvmx_l2t_err_cn38xx {
+		uint64_t reserved_28_63:36;
+		uint64_t lck_intena2:1;
+		uint64_t lckerr2:1;
+		uint64_t lck_intena:1;
+		uint64_t lckerr:1;
+		uint64_t fset:3;
+		uint64_t fadr:10;
+		uint64_t fsyn:6;
+		uint64_t ded_err:1;
+		uint64_t sec_err:1;
+		uint64_t ded_intena:1;
+		uint64_t sec_intena:1;
+		uint64_t ecc_ena:1;
+	} cn38xx;
+	struct cvmx_l2t_err_cn38xx cn38xxp2;
+	struct cvmx_l2t_err_cn50xx {
+		uint64_t reserved_28_63:36;
+		uint64_t lck_intena2:1;
+		uint64_t lckerr2:1;
+		uint64_t lck_intena:1;
+		uint64_t lckerr:1;
+		uint64_t fset:3;
+		uint64_t reserved_18_20:3;
+		uint64_t fadr:7;
+		uint64_t fsyn:6;
+		uint64_t ded_err:1;
+		uint64_t sec_err:1;
+		uint64_t ded_intena:1;
+		uint64_t sec_intena:1;
+		uint64_t ecc_ena:1;
+	} cn50xx;
+	struct cvmx_l2t_err_cn52xx {
+		uint64_t reserved_28_63:36;
+		uint64_t lck_intena2:1;
+		uint64_t lckerr2:1;
+		uint64_t lck_intena:1;
+		uint64_t lckerr:1;
+		uint64_t fset:3;
+		uint64_t reserved_20_20:1;
+		uint64_t fadr:9;
+		uint64_t fsyn:6;
+		uint64_t ded_err:1;
+		uint64_t sec_err:1;
+		uint64_t ded_intena:1;
+		uint64_t sec_intena:1;
+		uint64_t ecc_ena:1;
+	} cn52xx;
+	struct cvmx_l2t_err_cn52xx cn52xxp1;
+	struct cvmx_l2t_err_s cn56xx;
+	struct cvmx_l2t_err_s cn56xxp1;
+	struct cvmx_l2t_err_s cn58xx;
+	struct cvmx_l2t_err_s cn58xxp1;
+} cvmx_l2t_err_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_led_blink_s {
+		uint64_t reserved_8_63:56;
+		uint64_t rate:8;
+	} s;
+	struct cvmx_led_blink_s cn38xx;
+	struct cvmx_led_blink_s cn38xxp2;
+	struct cvmx_led_blink_s cn56xx;
+	struct cvmx_led_blink_s cn56xxp1;
+	struct cvmx_led_blink_s cn58xx;
+	struct cvmx_led_blink_s cn58xxp1;
+} cvmx_led_blink_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_led_clk_phase_s {
+		uint64_t reserved_7_63:57;
+		uint64_t phase:7;
+	} s;
+	struct cvmx_led_clk_phase_s cn38xx;
+	struct cvmx_led_clk_phase_s cn38xxp2;
+	struct cvmx_led_clk_phase_s cn56xx;
+	struct cvmx_led_clk_phase_s cn56xxp1;
+	struct cvmx_led_clk_phase_s cn58xx;
+	struct cvmx_led_clk_phase_s cn58xxp1;
+} cvmx_led_clk_phase_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_led_cylon_s {
+		uint64_t reserved_16_63:48;
+		uint64_t rate:16;
+	} s;
+	struct cvmx_led_cylon_s cn38xx;
+	struct cvmx_led_cylon_s cn38xxp2;
+	struct cvmx_led_cylon_s cn56xx;
+	struct cvmx_led_cylon_s cn56xxp1;
+	struct cvmx_led_cylon_s cn58xx;
+	struct cvmx_led_cylon_s cn58xxp1;
+} cvmx_led_cylon_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_led_dbg_s {
+		uint64_t reserved_1_63:63;
+		uint64_t dbg_en:1;
+	} s;
+	struct cvmx_led_dbg_s cn38xx;
+	struct cvmx_led_dbg_s cn38xxp2;
+	struct cvmx_led_dbg_s cn56xx;
+	struct cvmx_led_dbg_s cn56xxp1;
+	struct cvmx_led_dbg_s cn58xx;
+	struct cvmx_led_dbg_s cn58xxp1;
+} cvmx_led_dbg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_led_en_s {
+		uint64_t reserved_1_63:63;
+		uint64_t en:1;
+	} s;
+	struct cvmx_led_en_s cn38xx;
+	struct cvmx_led_en_s cn38xxp2;
+	struct cvmx_led_en_s cn56xx;
+	struct cvmx_led_en_s cn56xxp1;
+	struct cvmx_led_en_s cn58xx;
+	struct cvmx_led_en_s cn58xxp1;
+} cvmx_led_en_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_led_polarity_s {
+		uint64_t reserved_1_63:63;
+		uint64_t polarity:1;
+	} s;
+	struct cvmx_led_polarity_s cn38xx;
+	struct cvmx_led_polarity_s cn38xxp2;
+	struct cvmx_led_polarity_s cn56xx;
+	struct cvmx_led_polarity_s cn56xxp1;
+	struct cvmx_led_polarity_s cn58xx;
+	struct cvmx_led_polarity_s cn58xxp1;
+} cvmx_led_polarity_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_led_prt_s {
+		uint64_t reserved_8_63:56;
+		uint64_t prt_en:8;
+	} s;
+	struct cvmx_led_prt_s cn38xx;
+	struct cvmx_led_prt_s cn38xxp2;
+	struct cvmx_led_prt_s cn56xx;
+	struct cvmx_led_prt_s cn56xxp1;
+	struct cvmx_led_prt_s cn58xx;
+	struct cvmx_led_prt_s cn58xxp1;
+} cvmx_led_prt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_led_prt_fmt_s {
+		uint64_t reserved_4_63:60;
+		uint64_t format:4;
+	} s;
+	struct cvmx_led_prt_fmt_s cn38xx;
+	struct cvmx_led_prt_fmt_s cn38xxp2;
+	struct cvmx_led_prt_fmt_s cn56xx;
+	struct cvmx_led_prt_fmt_s cn56xxp1;
+	struct cvmx_led_prt_fmt_s cn58xx;
+	struct cvmx_led_prt_fmt_s cn58xxp1;
+} cvmx_led_prt_fmt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_led_prt_statusx_s {
+		uint64_t reserved_6_63:58;
+		uint64_t status:6;
+	} s;
+	struct cvmx_led_prt_statusx_s cn38xx;
+	struct cvmx_led_prt_statusx_s cn38xxp2;
+	struct cvmx_led_prt_statusx_s cn56xx;
+	struct cvmx_led_prt_statusx_s cn56xxp1;
+	struct cvmx_led_prt_statusx_s cn58xx;
+	struct cvmx_led_prt_statusx_s cn58xxp1;
+} cvmx_led_prt_statusx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_led_udd_cntx_s {
+		uint64_t reserved_6_63:58;
+		uint64_t cnt:6;
+	} s;
+	struct cvmx_led_udd_cntx_s cn38xx;
+	struct cvmx_led_udd_cntx_s cn38xxp2;
+	struct cvmx_led_udd_cntx_s cn56xx;
+	struct cvmx_led_udd_cntx_s cn56xxp1;
+	struct cvmx_led_udd_cntx_s cn58xx;
+	struct cvmx_led_udd_cntx_s cn58xxp1;
+} cvmx_led_udd_cntx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_led_udd_datx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t dat:32;
+	} s;
+	struct cvmx_led_udd_datx_s cn38xx;
+	struct cvmx_led_udd_datx_s cn38xxp2;
+	struct cvmx_led_udd_datx_s cn56xx;
+	struct cvmx_led_udd_datx_s cn56xxp1;
+	struct cvmx_led_udd_datx_s cn58xx;
+	struct cvmx_led_udd_datx_s cn58xxp1;
+} cvmx_led_udd_datx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_led_udd_dat_clrx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t clr:32;
+	} s;
+	struct cvmx_led_udd_dat_clrx_s cn38xx;
+	struct cvmx_led_udd_dat_clrx_s cn38xxp2;
+	struct cvmx_led_udd_dat_clrx_s cn56xx;
+	struct cvmx_led_udd_dat_clrx_s cn56xxp1;
+	struct cvmx_led_udd_dat_clrx_s cn58xx;
+	struct cvmx_led_udd_dat_clrx_s cn58xxp1;
+} cvmx_led_udd_dat_clrx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_led_udd_dat_setx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t set:32;
+	} s;
+	struct cvmx_led_udd_dat_setx_s cn38xx;
+	struct cvmx_led_udd_dat_setx_s cn38xxp2;
+	struct cvmx_led_udd_dat_setx_s cn56xx;
+	struct cvmx_led_udd_dat_setx_s cn56xxp1;
+	struct cvmx_led_udd_dat_setx_s cn58xx;
+	struct cvmx_led_udd_dat_setx_s cn58xxp1;
+} cvmx_led_udd_dat_setx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_bist_ctl_s {
+		uint64_t reserved_1_63:63;
+		uint64_t start:1;
+	} s;
+	struct cvmx_lmcx_bist_ctl_s cn50xx;
+	struct cvmx_lmcx_bist_ctl_s cn52xx;
+	struct cvmx_lmcx_bist_ctl_s cn52xxp1;
+	struct cvmx_lmcx_bist_ctl_s cn56xx;
+	struct cvmx_lmcx_bist_ctl_s cn56xxp1;
+} cvmx_lmcx_bist_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_bist_result_s {
+		uint64_t reserved_11_63:53;
+		uint64_t csrd2e:1;
+		uint64_t csre2d:1;
+		uint64_t mwf:1;
+		uint64_t mwd:3;
+		uint64_t mwc:1;
+		uint64_t mrf:1;
+		uint64_t mrd:3;
+	} s;
+	struct cvmx_lmcx_bist_result_cn50xx {
+		uint64_t reserved_9_63:55;
+		uint64_t mwf:1;
+		uint64_t mwd:3;
+		uint64_t mwc:1;
+		uint64_t mrf:1;
+		uint64_t mrd:3;
+	} cn50xx;
+	struct cvmx_lmcx_bist_result_s cn52xx;
+	struct cvmx_lmcx_bist_result_s cn52xxp1;
+	struct cvmx_lmcx_bist_result_s cn56xx;
+	struct cvmx_lmcx_bist_result_s cn56xxp1;
+} cvmx_lmcx_bist_result_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_comp_ctl_s {
+		uint64_t reserved_32_63:32;
+		uint64_t nctl_csr:4;
+		uint64_t nctl_clk:4;
+		uint64_t nctl_cmd:4;
+		uint64_t nctl_dat:4;
+		uint64_t pctl_csr:4;
+		uint64_t pctl_clk:4;
+		uint64_t reserved_0_7:8;
+	} s;
+	struct cvmx_lmcx_comp_ctl_cn30xx {
+		uint64_t reserved_32_63:32;
+		uint64_t nctl_csr:4;
+		uint64_t nctl_clk:4;
+		uint64_t nctl_cmd:4;
+		uint64_t nctl_dat:4;
+		uint64_t pctl_csr:4;
+		uint64_t pctl_clk:4;
+		uint64_t pctl_cmd:4;
+		uint64_t pctl_dat:4;
+	} cn30xx;
+	struct cvmx_lmcx_comp_ctl_cn30xx cn31xx;
+	struct cvmx_lmcx_comp_ctl_cn30xx cn38xx;
+	struct cvmx_lmcx_comp_ctl_cn30xx cn38xxp2;
+	struct cvmx_lmcx_comp_ctl_cn50xx {
+		uint64_t reserved_32_63:32;
+		uint64_t nctl_csr:4;
+		uint64_t reserved_20_27:8;
+		uint64_t nctl_dat:4;
+		uint64_t pctl_csr:4;
+		uint64_t reserved_5_11:7;
+		uint64_t pctl_dat:5;
+	} cn50xx;
+	struct cvmx_lmcx_comp_ctl_cn50xx cn52xx;
+	struct cvmx_lmcx_comp_ctl_cn50xx cn52xxp1;
+	struct cvmx_lmcx_comp_ctl_cn50xx cn56xx;
+	struct cvmx_lmcx_comp_ctl_cn50xx cn56xxp1;
+	struct cvmx_lmcx_comp_ctl_cn50xx cn58xx;
+	struct cvmx_lmcx_comp_ctl_cn58xxp1 {
+		uint64_t reserved_32_63:32;
+		uint64_t nctl_csr:4;
+		uint64_t reserved_20_27:8;
+		uint64_t nctl_dat:4;
+		uint64_t pctl_csr:4;
+		uint64_t reserved_4_11:8;
+		uint64_t pctl_dat:4;
+	} cn58xxp1;
+} cvmx_lmcx_comp_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_ctl_s {
+		uint64_t reserved_32_63:32;
+		uint64_t ddr__nctl:4;
+		uint64_t ddr__pctl:4;
+		uint64_t slow_scf:1;
+		uint64_t xor_bank:1;
+		uint64_t max_write_batch:4;
+		uint64_t pll_div2:1;
+		uint64_t pll_bypass:1;
+		uint64_t rdimm_ena:1;
+		uint64_t r2r_slot:1;
+		uint64_t inorder_mwf:1;
+		uint64_t inorder_mrf:1;
+		uint64_t reserved_10_11:2;
+		uint64_t fprch2:1;
+		uint64_t bprch:1;
+		uint64_t sil_lat:2;
+		uint64_t tskw:2;
+		uint64_t qs_dic:2;
+		uint64_t dic:2;
+	} s;
+	struct cvmx_lmcx_ctl_cn30xx {
+		uint64_t reserved_32_63:32;
+		uint64_t ddr__nctl:4;
+		uint64_t ddr__pctl:4;
+		uint64_t slow_scf:1;
+		uint64_t xor_bank:1;
+		uint64_t max_write_batch:4;
+		uint64_t pll_div2:1;
+		uint64_t pll_bypass:1;
+		uint64_t rdimm_ena:1;
+		uint64_t r2r_slot:1;
+		uint64_t reserved_13_13:1;
+		uint64_t inorder_mrf:1;
+		uint64_t dreset:1;
+		uint64_t mode32b:1;
+		uint64_t fprch2:1;
+		uint64_t bprch:1;
+		uint64_t sil_lat:2;
+		uint64_t tskw:2;
+		uint64_t qs_dic:2;
+		uint64_t dic:2;
+	} cn30xx;
+	struct cvmx_lmcx_ctl_cn30xx cn31xx;
+	struct cvmx_lmcx_ctl_cn38xx {
+		uint64_t reserved_32_63:32;
+		uint64_t ddr__nctl:4;
+		uint64_t ddr__pctl:4;
+		uint64_t slow_scf:1;
+		uint64_t xor_bank:1;
+		uint64_t max_write_batch:4;
+		uint64_t reserved_16_17:2;
+		uint64_t rdimm_ena:1;
+		uint64_t r2r_slot:1;
+		uint64_t inorder_mwf:1;
+		uint64_t inorder_mrf:1;
+		uint64_t set_zero:1;
+		uint64_t mode128b:1;
+		uint64_t fprch2:1;
+		uint64_t bprch:1;
+		uint64_t sil_lat:2;
+		uint64_t tskw:2;
+		uint64_t qs_dic:2;
+		uint64_t dic:2;
+	} cn38xx;
+	struct cvmx_lmcx_ctl_cn38xx cn38xxp2;
+	struct cvmx_lmcx_ctl_cn50xx {
+		uint64_t reserved_32_63:32;
+		uint64_t ddr__nctl:4;
+		uint64_t ddr__pctl:4;
+		uint64_t slow_scf:1;
+		uint64_t xor_bank:1;
+		uint64_t max_write_batch:4;
+		uint64_t reserved_17_17:1;
+		uint64_t pll_bypass:1;
+		uint64_t rdimm_ena:1;
+		uint64_t r2r_slot:1;
+		uint64_t reserved_13_13:1;
+		uint64_t inorder_mrf:1;
+		uint64_t dreset:1;
+		uint64_t mode32b:1;
+		uint64_t fprch2:1;
+		uint64_t bprch:1;
+		uint64_t sil_lat:2;
+		uint64_t tskw:2;
+		uint64_t qs_dic:2;
+		uint64_t dic:2;
+	} cn50xx;
+	struct cvmx_lmcx_ctl_cn52xx {
+		uint64_t reserved_32_63:32;
+		uint64_t ddr__nctl:4;
+		uint64_t ddr__pctl:4;
+		uint64_t slow_scf:1;
+		uint64_t xor_bank:1;
+		uint64_t max_write_batch:4;
+		uint64_t reserved_16_17:2;
+		uint64_t rdimm_ena:1;
+		uint64_t r2r_slot:1;
+		uint64_t reserved_13_13:1;
+		uint64_t inorder_mrf:1;
+		uint64_t dreset:1;
+		uint64_t mode32b:1;
+		uint64_t fprch2:1;
+		uint64_t bprch:1;
+		uint64_t sil_lat:2;
+		uint64_t tskw:2;
+		uint64_t qs_dic:2;
+		uint64_t dic:2;
+	} cn52xx;
+	struct cvmx_lmcx_ctl_cn52xx cn52xxp1;
+	struct cvmx_lmcx_ctl_cn52xx cn56xx;
+	struct cvmx_lmcx_ctl_cn52xx cn56xxp1;
+	struct cvmx_lmcx_ctl_cn58xx {
+		uint64_t reserved_32_63:32;
+		uint64_t ddr__nctl:4;
+		uint64_t ddr__pctl:4;
+		uint64_t slow_scf:1;
+		uint64_t xor_bank:1;
+		uint64_t max_write_batch:4;
+		uint64_t reserved_16_17:2;
+		uint64_t rdimm_ena:1;
+		uint64_t r2r_slot:1;
+		uint64_t reserved_13_13:1;
+		uint64_t inorder_mrf:1;
+		uint64_t dreset:1;
+		uint64_t mode128b:1;
+		uint64_t fprch2:1;
+		uint64_t bprch:1;
+		uint64_t sil_lat:2;
+		uint64_t tskw:2;
+		uint64_t qs_dic:2;
+		uint64_t dic:2;
+	} cn58xx;
+	struct cvmx_lmcx_ctl_cn58xx cn58xxp1;
+} cvmx_lmcx_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_ctl1_s {
+		uint64_t reserved_21_63:43;
+		uint64_t ecc_adr:1;
+		uint64_t forcewrite:4;
+		uint64_t idlepower:3;
+		uint64_t sequence:3;
+		uint64_t sil_mode:1;
+		uint64_t dcc_enable:1;
+		uint64_t reserved_2_7:6;
+		uint64_t data_layout:2;
+	} s;
+	struct cvmx_lmcx_ctl1_cn30xx {
+		uint64_t reserved_2_63:62;
+		uint64_t data_layout:2;
+	} cn30xx;
+	struct cvmx_lmcx_ctl1_cn50xx {
+		uint64_t reserved_10_63:54;
+		uint64_t sil_mode:1;
+		uint64_t dcc_enable:1;
+		uint64_t reserved_2_7:6;
+		uint64_t data_layout:2;
+	} cn50xx;
+	struct cvmx_lmcx_ctl1_cn52xx {
+		uint64_t reserved_21_63:43;
+		uint64_t ecc_adr:1;
+		uint64_t forcewrite:4;
+		uint64_t idlepower:3;
+		uint64_t sequence:3;
+		uint64_t sil_mode:1;
+		uint64_t dcc_enable:1;
+		uint64_t reserved_0_7:8;
+	} cn52xx;
+	struct cvmx_lmcx_ctl1_cn52xx cn52xxp1;
+	struct cvmx_lmcx_ctl1_cn52xx cn56xx;
+	struct cvmx_lmcx_ctl1_cn52xx cn56xxp1;
+	struct cvmx_lmcx_ctl1_cn58xx {
+		uint64_t reserved_10_63:54;
+		uint64_t sil_mode:1;
+		uint64_t dcc_enable:1;
+		uint64_t reserved_0_7:8;
+	} cn58xx;
+	struct cvmx_lmcx_ctl1_cn58xx cn58xxp1;
+} cvmx_lmcx_ctl1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_dclk_cnt_hi_s {
+		uint64_t reserved_32_63:32;
+		uint64_t dclkcnt_hi:32;
+	} s;
+	struct cvmx_lmcx_dclk_cnt_hi_s cn30xx;
+	struct cvmx_lmcx_dclk_cnt_hi_s cn31xx;
+	struct cvmx_lmcx_dclk_cnt_hi_s cn38xx;
+	struct cvmx_lmcx_dclk_cnt_hi_s cn38xxp2;
+	struct cvmx_lmcx_dclk_cnt_hi_s cn50xx;
+	struct cvmx_lmcx_dclk_cnt_hi_s cn52xx;
+	struct cvmx_lmcx_dclk_cnt_hi_s cn52xxp1;
+	struct cvmx_lmcx_dclk_cnt_hi_s cn56xx;
+	struct cvmx_lmcx_dclk_cnt_hi_s cn56xxp1;
+	struct cvmx_lmcx_dclk_cnt_hi_s cn58xx;
+	struct cvmx_lmcx_dclk_cnt_hi_s cn58xxp1;
+} cvmx_lmcx_dclk_cnt_hi_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_dclk_cnt_lo_s {
+		uint64_t reserved_32_63:32;
+		uint64_t dclkcnt_lo:32;
+	} s;
+	struct cvmx_lmcx_dclk_cnt_lo_s cn30xx;
+	struct cvmx_lmcx_dclk_cnt_lo_s cn31xx;
+	struct cvmx_lmcx_dclk_cnt_lo_s cn38xx;
+	struct cvmx_lmcx_dclk_cnt_lo_s cn38xxp2;
+	struct cvmx_lmcx_dclk_cnt_lo_s cn50xx;
+	struct cvmx_lmcx_dclk_cnt_lo_s cn52xx;
+	struct cvmx_lmcx_dclk_cnt_lo_s cn52xxp1;
+	struct cvmx_lmcx_dclk_cnt_lo_s cn56xx;
+	struct cvmx_lmcx_dclk_cnt_lo_s cn56xxp1;
+	struct cvmx_lmcx_dclk_cnt_lo_s cn58xx;
+	struct cvmx_lmcx_dclk_cnt_lo_s cn58xxp1;
+} cvmx_lmcx_dclk_cnt_lo_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_dclk_ctl_s {
+		uint64_t reserved_8_63:56;
+		uint64_t off90_ena:1;
+		uint64_t dclk90_byp:1;
+		uint64_t dclk90_ld:1;
+		uint64_t dclk90_vlu:5;
+	} s;
+	struct cvmx_lmcx_dclk_ctl_s cn56xx;
+	struct cvmx_lmcx_dclk_ctl_s cn56xxp1;
+} cvmx_lmcx_dclk_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_ddr2_ctl_s {
+		uint64_t reserved_32_63:32;
+		uint64_t bank8:1;
+		uint64_t burst8:1;
+		uint64_t addlat:3;
+		uint64_t pocas:1;
+		uint64_t bwcnt:1;
+		uint64_t twr:3;
+		uint64_t silo_hc:1;
+		uint64_t ddr_eof:4;
+		uint64_t tfaw:5;
+		uint64_t crip_mode:1;
+		uint64_t ddr2t:1;
+		uint64_t odt_ena:1;
+		uint64_t qdll_ena:1;
+		uint64_t dll90_vlu:5;
+		uint64_t dll90_byp:1;
+		uint64_t rdqs:1;
+		uint64_t ddr2:1;
+	} s;
+	struct cvmx_lmcx_ddr2_ctl_cn30xx {
+		uint64_t reserved_32_63:32;
+		uint64_t bank8:1;
+		uint64_t burst8:1;
+		uint64_t addlat:3;
+		uint64_t pocas:1;
+		uint64_t bwcnt:1;
+		uint64_t twr:3;
+		uint64_t silo_hc:1;
+		uint64_t ddr_eof:4;
+		uint64_t tfaw:5;
+		uint64_t crip_mode:1;
+		uint64_t ddr2t:1;
+		uint64_t odt_ena:1;
+		uint64_t qdll_ena:1;
+		uint64_t dll90_vlu:5;
+		uint64_t dll90_byp:1;
+		uint64_t reserved_1_1:1;
+		uint64_t ddr2:1;
+	} cn30xx;
+	struct cvmx_lmcx_ddr2_ctl_cn30xx cn31xx;
+	struct cvmx_lmcx_ddr2_ctl_s cn38xx;
+	struct cvmx_lmcx_ddr2_ctl_s cn38xxp2;
+	struct cvmx_lmcx_ddr2_ctl_s cn50xx;
+	struct cvmx_lmcx_ddr2_ctl_s cn52xx;
+	struct cvmx_lmcx_ddr2_ctl_s cn52xxp1;
+	struct cvmx_lmcx_ddr2_ctl_s cn56xx;
+	struct cvmx_lmcx_ddr2_ctl_s cn56xxp1;
+	struct cvmx_lmcx_ddr2_ctl_s cn58xx;
+	struct cvmx_lmcx_ddr2_ctl_s cn58xxp1;
+} cvmx_lmcx_ddr2_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_delay_cfg_s {
+		uint64_t reserved_15_63:49;
+		uint64_t dq:5;
+		uint64_t cmd:5;
+		uint64_t clk:5;
+	} s;
+	struct cvmx_lmcx_delay_cfg_s cn30xx;
+	struct cvmx_lmcx_delay_cfg_cn38xx {
+		uint64_t reserved_14_63:50;
+		uint64_t dq:4;
+		uint64_t reserved_9_9:1;
+		uint64_t cmd:4;
+		uint64_t reserved_4_4:1;
+		uint64_t clk:4;
+	} cn38xx;
+	struct cvmx_lmcx_delay_cfg_cn38xx cn50xx;
+	struct cvmx_lmcx_delay_cfg_cn38xx cn52xx;
+	struct cvmx_lmcx_delay_cfg_cn38xx cn52xxp1;
+	struct cvmx_lmcx_delay_cfg_cn38xx cn56xx;
+	struct cvmx_lmcx_delay_cfg_cn38xx cn56xxp1;
+	struct cvmx_lmcx_delay_cfg_cn38xx cn58xx;
+	struct cvmx_lmcx_delay_cfg_cn38xx cn58xxp1;
+} cvmx_lmcx_delay_cfg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_dll_ctl_s {
+		uint64_t reserved_8_63:56;
+		uint64_t dreset:1;
+		uint64_t dll90_byp:1;
+		uint64_t dll90_ena:1;
+		uint64_t dll90_vlu:5;
+	} s;
+	struct cvmx_lmcx_dll_ctl_s cn52xx;
+	struct cvmx_lmcx_dll_ctl_s cn52xxp1;
+	struct cvmx_lmcx_dll_ctl_s cn56xx;
+	struct cvmx_lmcx_dll_ctl_s cn56xxp1;
+} cvmx_lmcx_dll_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_dual_memcfg_s {
+		uint64_t reserved_20_63:44;
+		uint64_t bank8:1;
+		uint64_t row_lsb:3;
+		uint64_t reserved_8_15:8;
+		uint64_t cs_mask:8;
+	} s;
+	struct cvmx_lmcx_dual_memcfg_s cn50xx;
+	struct cvmx_lmcx_dual_memcfg_s cn52xx;
+	struct cvmx_lmcx_dual_memcfg_s cn52xxp1;
+	struct cvmx_lmcx_dual_memcfg_s cn56xx;
+	struct cvmx_lmcx_dual_memcfg_s cn56xxp1;
+	struct cvmx_lmcx_dual_memcfg_s cn58xx;
+	struct cvmx_lmcx_dual_memcfg_s cn58xxp1;
+} cvmx_lmcx_dual_memcfg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_ecc_synd_s {
+		uint64_t reserved_32_63:32;
+		uint64_t mrdsyn3:8;
+		uint64_t mrdsyn2:8;
+		uint64_t mrdsyn1:8;
+		uint64_t mrdsyn0:8;
+	} s;
+	struct cvmx_lmcx_ecc_synd_s cn30xx;
+	struct cvmx_lmcx_ecc_synd_s cn31xx;
+	struct cvmx_lmcx_ecc_synd_s cn38xx;
+	struct cvmx_lmcx_ecc_synd_s cn38xxp2;
+	struct cvmx_lmcx_ecc_synd_s cn50xx;
+	struct cvmx_lmcx_ecc_synd_s cn52xx;
+	struct cvmx_lmcx_ecc_synd_s cn52xxp1;
+	struct cvmx_lmcx_ecc_synd_s cn56xx;
+	struct cvmx_lmcx_ecc_synd_s cn56xxp1;
+	struct cvmx_lmcx_ecc_synd_s cn58xx;
+	struct cvmx_lmcx_ecc_synd_s cn58xxp1;
+} cvmx_lmcx_ecc_synd_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_fadr_s {
+		uint64_t reserved_32_63:32;
+		uint64_t fdimm:2;
+		uint64_t fbunk:1;
+		uint64_t fbank:3;
+		uint64_t frow:14;
+		uint64_t fcol:12;
+	} s;
+	struct cvmx_lmcx_fadr_s cn30xx;
+	struct cvmx_lmcx_fadr_s cn31xx;
+	struct cvmx_lmcx_fadr_s cn38xx;
+	struct cvmx_lmcx_fadr_s cn38xxp2;
+	struct cvmx_lmcx_fadr_s cn50xx;
+	struct cvmx_lmcx_fadr_s cn52xx;
+	struct cvmx_lmcx_fadr_s cn52xxp1;
+	struct cvmx_lmcx_fadr_s cn56xx;
+	struct cvmx_lmcx_fadr_s cn56xxp1;
+	struct cvmx_lmcx_fadr_s cn58xx;
+	struct cvmx_lmcx_fadr_s cn58xxp1;
+} cvmx_lmcx_fadr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_ifb_cnt_hi_s {
+		uint64_t reserved_32_63:32;
+		uint64_t ifbcnt_hi:32;
+	} s;
+	struct cvmx_lmcx_ifb_cnt_hi_s cn30xx;
+	struct cvmx_lmcx_ifb_cnt_hi_s cn31xx;
+	struct cvmx_lmcx_ifb_cnt_hi_s cn38xx;
+	struct cvmx_lmcx_ifb_cnt_hi_s cn38xxp2;
+	struct cvmx_lmcx_ifb_cnt_hi_s cn50xx;
+	struct cvmx_lmcx_ifb_cnt_hi_s cn52xx;
+	struct cvmx_lmcx_ifb_cnt_hi_s cn52xxp1;
+	struct cvmx_lmcx_ifb_cnt_hi_s cn56xx;
+	struct cvmx_lmcx_ifb_cnt_hi_s cn56xxp1;
+	struct cvmx_lmcx_ifb_cnt_hi_s cn58xx;
+	struct cvmx_lmcx_ifb_cnt_hi_s cn58xxp1;
+} cvmx_lmcx_ifb_cnt_hi_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_ifb_cnt_lo_s {
+		uint64_t reserved_32_63:32;
+		uint64_t ifbcnt_lo:32;
+	} s;
+	struct cvmx_lmcx_ifb_cnt_lo_s cn30xx;
+	struct cvmx_lmcx_ifb_cnt_lo_s cn31xx;
+	struct cvmx_lmcx_ifb_cnt_lo_s cn38xx;
+	struct cvmx_lmcx_ifb_cnt_lo_s cn38xxp2;
+	struct cvmx_lmcx_ifb_cnt_lo_s cn50xx;
+	struct cvmx_lmcx_ifb_cnt_lo_s cn52xx;
+	struct cvmx_lmcx_ifb_cnt_lo_s cn52xxp1;
+	struct cvmx_lmcx_ifb_cnt_lo_s cn56xx;
+	struct cvmx_lmcx_ifb_cnt_lo_s cn56xxp1;
+	struct cvmx_lmcx_ifb_cnt_lo_s cn58xx;
+	struct cvmx_lmcx_ifb_cnt_lo_s cn58xxp1;
+} cvmx_lmcx_ifb_cnt_lo_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_mem_cfg0_s {
+		uint64_t reserved_32_63:32;
+		uint64_t reset:1;
+		uint64_t silo_qc:1;
+		uint64_t bunk_ena:1;
+		uint64_t ded_err:4;
+		uint64_t sec_err:4;
+		uint64_t intr_ded_ena:1;
+		uint64_t intr_sec_ena:1;
+		uint64_t tcl:4;
+		uint64_t ref_int:6;
+		uint64_t pbank_lsb:4;
+		uint64_t row_lsb:3;
+		uint64_t ecc_ena:1;
+		uint64_t init_start:1;
+	} s;
+	struct cvmx_lmcx_mem_cfg0_s cn30xx;
+	struct cvmx_lmcx_mem_cfg0_s cn31xx;
+	struct cvmx_lmcx_mem_cfg0_s cn38xx;
+	struct cvmx_lmcx_mem_cfg0_s cn38xxp2;
+	struct cvmx_lmcx_mem_cfg0_s cn50xx;
+	struct cvmx_lmcx_mem_cfg0_s cn52xx;
+	struct cvmx_lmcx_mem_cfg0_s cn52xxp1;
+	struct cvmx_lmcx_mem_cfg0_s cn56xx;
+	struct cvmx_lmcx_mem_cfg0_s cn56xxp1;
+	struct cvmx_lmcx_mem_cfg0_s cn58xx;
+	struct cvmx_lmcx_mem_cfg0_s cn58xxp1;
+} cvmx_lmcx_mem_cfg0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_mem_cfg1_s {
+		uint64_t reserved_32_63:32;
+		uint64_t comp_bypass:1;
+		uint64_t trrd:3;
+		uint64_t caslat:3;
+		uint64_t tmrd:3;
+		uint64_t trfc:5;
+		uint64_t trp:4;
+		uint64_t twtr:4;
+		uint64_t trcd:4;
+		uint64_t tras:5;
+	} s;
+	struct cvmx_lmcx_mem_cfg1_s cn30xx;
+	struct cvmx_lmcx_mem_cfg1_s cn31xx;
+	struct cvmx_lmcx_mem_cfg1_cn38xx {
+		uint64_t reserved_31_63:33;
+		uint64_t trrd:3;
+		uint64_t caslat:3;
+		uint64_t tmrd:3;
+		uint64_t trfc:5;
+		uint64_t trp:4;
+		uint64_t twtr:4;
+		uint64_t trcd:4;
+		uint64_t tras:5;
+	} cn38xx;
+	struct cvmx_lmcx_mem_cfg1_cn38xx cn38xxp2;
+	struct cvmx_lmcx_mem_cfg1_s cn50xx;
+	struct cvmx_lmcx_mem_cfg1_cn38xx cn52xx;
+	struct cvmx_lmcx_mem_cfg1_cn38xx cn52xxp1;
+	struct cvmx_lmcx_mem_cfg1_cn38xx cn56xx;
+	struct cvmx_lmcx_mem_cfg1_cn38xx cn56xxp1;
+	struct cvmx_lmcx_mem_cfg1_cn38xx cn58xx;
+	struct cvmx_lmcx_mem_cfg1_cn38xx cn58xxp1;
+} cvmx_lmcx_mem_cfg1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_nxm_s {
+		uint64_t reserved_8_63:56;
+		uint64_t cs_mask:8;
+	} s;
+	struct cvmx_lmcx_nxm_s cn52xx;
+	struct cvmx_lmcx_nxm_s cn56xx;
+	struct cvmx_lmcx_nxm_s cn58xx;
+} cvmx_lmcx_nxm_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_ops_cnt_hi_s {
+		uint64_t reserved_32_63:32;
+		uint64_t opscnt_hi:32;
+	} s;
+	struct cvmx_lmcx_ops_cnt_hi_s cn30xx;
+	struct cvmx_lmcx_ops_cnt_hi_s cn31xx;
+	struct cvmx_lmcx_ops_cnt_hi_s cn38xx;
+	struct cvmx_lmcx_ops_cnt_hi_s cn38xxp2;
+	struct cvmx_lmcx_ops_cnt_hi_s cn50xx;
+	struct cvmx_lmcx_ops_cnt_hi_s cn52xx;
+	struct cvmx_lmcx_ops_cnt_hi_s cn52xxp1;
+	struct cvmx_lmcx_ops_cnt_hi_s cn56xx;
+	struct cvmx_lmcx_ops_cnt_hi_s cn56xxp1;
+	struct cvmx_lmcx_ops_cnt_hi_s cn58xx;
+	struct cvmx_lmcx_ops_cnt_hi_s cn58xxp1;
+} cvmx_lmcx_ops_cnt_hi_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_ops_cnt_lo_s {
+		uint64_t reserved_32_63:32;
+		uint64_t opscnt_lo:32;
+	} s;
+	struct cvmx_lmcx_ops_cnt_lo_s cn30xx;
+	struct cvmx_lmcx_ops_cnt_lo_s cn31xx;
+	struct cvmx_lmcx_ops_cnt_lo_s cn38xx;
+	struct cvmx_lmcx_ops_cnt_lo_s cn38xxp2;
+	struct cvmx_lmcx_ops_cnt_lo_s cn50xx;
+	struct cvmx_lmcx_ops_cnt_lo_s cn52xx;
+	struct cvmx_lmcx_ops_cnt_lo_s cn52xxp1;
+	struct cvmx_lmcx_ops_cnt_lo_s cn56xx;
+	struct cvmx_lmcx_ops_cnt_lo_s cn56xxp1;
+	struct cvmx_lmcx_ops_cnt_lo_s cn58xx;
+	struct cvmx_lmcx_ops_cnt_lo_s cn58xxp1;
+} cvmx_lmcx_ops_cnt_lo_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_pll_bwctl_s {
+		uint64_t reserved_5_63:59;
+		uint64_t bwupd:1;
+		uint64_t bwctl:4;
+	} s;
+	struct cvmx_lmcx_pll_bwctl_s cn30xx;
+	struct cvmx_lmcx_pll_bwctl_s cn31xx;
+	struct cvmx_lmcx_pll_bwctl_s cn38xx;
+	struct cvmx_lmcx_pll_bwctl_s cn38xxp2;
+} cvmx_lmcx_pll_bwctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_pll_ctl_s {
+		uint64_t reserved_30_63:34;
+		uint64_t bypass:1;
+		uint64_t fasten_n:1;
+		uint64_t div_reset:1;
+		uint64_t reset_n:1;
+		uint64_t clkf:12;
+		uint64_t clkr:6;
+		uint64_t reserved_6_7:2;
+		uint64_t en16:1;
+		uint64_t en12:1;
+		uint64_t en8:1;
+		uint64_t en6:1;
+		uint64_t en4:1;
+		uint64_t en2:1;
+	} s;
+	struct cvmx_lmcx_pll_ctl_cn50xx {
+		uint64_t reserved_29_63:35;
+		uint64_t fasten_n:1;
+		uint64_t div_reset:1;
+		uint64_t reset_n:1;
+		uint64_t clkf:12;
+		uint64_t clkr:6;
+		uint64_t reserved_6_7:2;
+		uint64_t en16:1;
+		uint64_t en12:1;
+		uint64_t en8:1;
+		uint64_t en6:1;
+		uint64_t en4:1;
+		uint64_t en2:1;
+	} cn50xx;
+	struct cvmx_lmcx_pll_ctl_s cn52xx;
+	struct cvmx_lmcx_pll_ctl_s cn52xxp1;
+	struct cvmx_lmcx_pll_ctl_cn50xx cn56xx;
+	struct cvmx_lmcx_pll_ctl_cn56xxp1 {
+		uint64_t reserved_28_63:36;
+		uint64_t div_reset:1;
+		uint64_t reset_n:1;
+		uint64_t clkf:12;
+		uint64_t clkr:6;
+		uint64_t reserved_6_7:2;
+		uint64_t en16:1;
+		uint64_t en12:1;
+		uint64_t en8:1;
+		uint64_t en6:1;
+		uint64_t en4:1;
+		uint64_t en2:1;
+	} cn56xxp1;
+	struct cvmx_lmcx_pll_ctl_cn56xxp1 cn58xx;
+	struct cvmx_lmcx_pll_ctl_cn56xxp1 cn58xxp1;
+} cvmx_lmcx_pll_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_pll_status_s {
+		uint64_t reserved_32_63:32;
+		uint64_t ddr__nctl:5;
+		uint64_t ddr__pctl:5;
+		uint64_t reserved_2_21:20;
+		uint64_t rfslip:1;
+		uint64_t fbslip:1;
+	} s;
+	struct cvmx_lmcx_pll_status_s cn50xx;
+	struct cvmx_lmcx_pll_status_s cn52xx;
+	struct cvmx_lmcx_pll_status_s cn52xxp1;
+	struct cvmx_lmcx_pll_status_s cn56xx;
+	struct cvmx_lmcx_pll_status_s cn56xxp1;
+	struct cvmx_lmcx_pll_status_s cn58xx;
+	struct cvmx_lmcx_pll_status_cn58xxp1 {
+		uint64_t reserved_2_63:62;
+		uint64_t rfslip:1;
+		uint64_t fbslip:1;
+	} cn58xxp1;
+} cvmx_lmcx_pll_status_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_read_level_ctl_s {
+		uint64_t reserved_44_63:20;
+		uint64_t rankmask:4;
+		uint64_t pattern:8;
+		uint64_t row:16;
+		uint64_t col:12;
+		uint64_t reserved_3_3:1;
+		uint64_t bnk:3;
+	} s;
+	struct cvmx_lmcx_read_level_ctl_s cn52xx;
+	struct cvmx_lmcx_read_level_ctl_s cn52xxp1;
+	struct cvmx_lmcx_read_level_ctl_s cn56xx;
+	struct cvmx_lmcx_read_level_ctl_s cn56xxp1;
+} cvmx_lmcx_read_level_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_read_level_dbg_s {
+		uint64_t reserved_32_63:32;
+		uint64_t bitmask:16;
+		uint64_t reserved_4_15:12;
+		uint64_t byte:4;
+	} s;
+	struct cvmx_lmcx_read_level_dbg_s cn52xx;
+	struct cvmx_lmcx_read_level_dbg_s cn52xxp1;
+	struct cvmx_lmcx_read_level_dbg_s cn56xx;
+	struct cvmx_lmcx_read_level_dbg_s cn56xxp1;
+} cvmx_lmcx_read_level_dbg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_read_level_rankx_s {
+		uint64_t reserved_38_63:26;
+		uint64_t status:2;
+		uint64_t byte8:4;
+		uint64_t byte7:4;
+		uint64_t byte6:4;
+		uint64_t byte5:4;
+		uint64_t byte4:4;
+		uint64_t byte3:4;
+		uint64_t byte2:4;
+		uint64_t byte1:4;
+		uint64_t byte0:4;
+	} s;
+	struct cvmx_lmcx_read_level_rankx_s cn52xx;
+	struct cvmx_lmcx_read_level_rankx_s cn52xxp1;
+	struct cvmx_lmcx_read_level_rankx_s cn56xx;
+	struct cvmx_lmcx_read_level_rankx_s cn56xxp1;
+} cvmx_lmcx_read_level_rankx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_rodt_comp_ctl_s {
+		uint64_t reserved_17_63:47;
+		uint64_t enable:1;
+		uint64_t reserved_12_15:4;
+		uint64_t nctl:4;
+		uint64_t reserved_5_7:3;
+		uint64_t pctl:5;
+	} s;
+	struct cvmx_lmcx_rodt_comp_ctl_s cn50xx;
+	struct cvmx_lmcx_rodt_comp_ctl_s cn52xx;
+	struct cvmx_lmcx_rodt_comp_ctl_s cn52xxp1;
+	struct cvmx_lmcx_rodt_comp_ctl_s cn56xx;
+	struct cvmx_lmcx_rodt_comp_ctl_s cn56xxp1;
+	struct cvmx_lmcx_rodt_comp_ctl_s cn58xx;
+	struct cvmx_lmcx_rodt_comp_ctl_s cn58xxp1;
+} cvmx_lmcx_rodt_comp_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_rodt_ctl_s {
+		uint64_t reserved_32_63:32;
+		uint64_t rodt_hi3:4;
+		uint64_t rodt_hi2:4;
+		uint64_t rodt_hi1:4;
+		uint64_t rodt_hi0:4;
+		uint64_t rodt_lo3:4;
+		uint64_t rodt_lo2:4;
+		uint64_t rodt_lo1:4;
+		uint64_t rodt_lo0:4;
+	} s;
+	struct cvmx_lmcx_rodt_ctl_s cn30xx;
+	struct cvmx_lmcx_rodt_ctl_s cn31xx;
+	struct cvmx_lmcx_rodt_ctl_s cn38xx;
+	struct cvmx_lmcx_rodt_ctl_s cn38xxp2;
+	struct cvmx_lmcx_rodt_ctl_s cn50xx;
+	struct cvmx_lmcx_rodt_ctl_s cn52xx;
+	struct cvmx_lmcx_rodt_ctl_s cn52xxp1;
+	struct cvmx_lmcx_rodt_ctl_s cn56xx;
+	struct cvmx_lmcx_rodt_ctl_s cn56xxp1;
+	struct cvmx_lmcx_rodt_ctl_s cn58xx;
+	struct cvmx_lmcx_rodt_ctl_s cn58xxp1;
+} cvmx_lmcx_rodt_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_wodt_ctl0_s {
+		uint64_t reserved_0_63:64;
+	} s;
+	struct cvmx_lmcx_wodt_ctl0_cn30xx {
+		uint64_t reserved_32_63:32;
+		uint64_t wodt_d1_r1:8;
+		uint64_t wodt_d1_r0:8;
+		uint64_t wodt_d0_r1:8;
+		uint64_t wodt_d0_r0:8;
+	} cn30xx;
+	struct cvmx_lmcx_wodt_ctl0_cn30xx cn31xx;
+	struct cvmx_lmcx_wodt_ctl0_cn38xx {
+		uint64_t reserved_32_63:32;
+		uint64_t wodt_hi3:4;
+		uint64_t wodt_hi2:4;
+		uint64_t wodt_hi1:4;
+		uint64_t wodt_hi0:4;
+		uint64_t wodt_lo3:4;
+		uint64_t wodt_lo2:4;
+		uint64_t wodt_lo1:4;
+		uint64_t wodt_lo0:4;
+	} cn38xx;
+	struct cvmx_lmcx_wodt_ctl0_cn38xx cn38xxp2;
+	struct cvmx_lmcx_wodt_ctl0_cn38xx cn50xx;
+	struct cvmx_lmcx_wodt_ctl0_cn30xx cn52xx;
+	struct cvmx_lmcx_wodt_ctl0_cn30xx cn52xxp1;
+	struct cvmx_lmcx_wodt_ctl0_cn30xx cn56xx;
+	struct cvmx_lmcx_wodt_ctl0_cn30xx cn56xxp1;
+	struct cvmx_lmcx_wodt_ctl0_cn38xx cn58xx;
+	struct cvmx_lmcx_wodt_ctl0_cn38xx cn58xxp1;
+} cvmx_lmcx_wodt_ctl0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_lmcx_wodt_ctl1_s {
+		uint64_t reserved_32_63:32;
+		uint64_t wodt_d3_r1:8;
+		uint64_t wodt_d3_r0:8;
+		uint64_t wodt_d2_r1:8;
+		uint64_t wodt_d2_r0:8;
+	} s;
+	struct cvmx_lmcx_wodt_ctl1_s cn30xx;
+	struct cvmx_lmcx_wodt_ctl1_s cn31xx;
+	struct cvmx_lmcx_wodt_ctl1_s cn52xx;
+	struct cvmx_lmcx_wodt_ctl1_s cn52xxp1;
+	struct cvmx_lmcx_wodt_ctl1_s cn56xx;
+	struct cvmx_lmcx_wodt_ctl1_s cn56xxp1;
+} cvmx_lmcx_wodt_ctl1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_boot_bist_stat_s {
+		uint64_t reserved_2_63:62;
+		uint64_t loc:1;
+		uint64_t ncbi:1;
+	} s;
+	struct cvmx_mio_boot_bist_stat_cn30xx {
+		uint64_t reserved_4_63:60;
+		uint64_t ncbo_1:1;
+		uint64_t ncbo_0:1;
+		uint64_t loc:1;
+		uint64_t ncbi:1;
+	} cn30xx;
+	struct cvmx_mio_boot_bist_stat_cn30xx cn31xx;
+	struct cvmx_mio_boot_bist_stat_cn38xx {
+		uint64_t reserved_3_63:61;
+		uint64_t ncbo_0:1;
+		uint64_t loc:1;
+		uint64_t ncbi:1;
+	} cn38xx;
+	struct cvmx_mio_boot_bist_stat_cn38xx cn38xxp2;
+	struct cvmx_mio_boot_bist_stat_cn50xx {
+		uint64_t reserved_6_63:58;
+		uint64_t pcm_1:1;
+		uint64_t pcm_0:1;
+		uint64_t ncbo_1:1;
+		uint64_t ncbo_0:1;
+		uint64_t loc:1;
+		uint64_t ncbi:1;
+	} cn50xx;
+	struct cvmx_mio_boot_bist_stat_cn52xx {
+		uint64_t reserved_6_63:58;
+		uint64_t ndf:2;
+		uint64_t ncbo_0:1;
+		uint64_t dma:1;
+		uint64_t loc:1;
+		uint64_t ncbi:1;
+	} cn52xx;
+	struct cvmx_mio_boot_bist_stat_cn52xxp1 {
+		uint64_t reserved_4_63:60;
+		uint64_t ncbo_0:1;
+		uint64_t dma:1;
+		uint64_t loc:1;
+		uint64_t ncbi:1;
+	} cn52xxp1;
+	struct cvmx_mio_boot_bist_stat_cn52xxp1 cn56xx;
+	struct cvmx_mio_boot_bist_stat_cn52xxp1 cn56xxp1;
+	struct cvmx_mio_boot_bist_stat_cn38xx cn58xx;
+	struct cvmx_mio_boot_bist_stat_cn38xx cn58xxp1;
+} cvmx_mio_boot_bist_stat_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_boot_comp_s {
+		uint64_t reserved_10_63:54;
+		uint64_t pctl:5;
+		uint64_t nctl:5;
+	} s;
+	struct cvmx_mio_boot_comp_s cn50xx;
+	struct cvmx_mio_boot_comp_s cn52xx;
+	struct cvmx_mio_boot_comp_s cn52xxp1;
+	struct cvmx_mio_boot_comp_s cn56xx;
+	struct cvmx_mio_boot_comp_s cn56xxp1;
+} cvmx_mio_boot_comp_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_boot_dma_cfgx_s {
+		uint64_t en:1;
+		uint64_t rw:1;
+		uint64_t clr:1;
+		uint64_t reserved_60_60:1;
+		uint64_t swap32:1;
+		uint64_t swap16:1;
+		uint64_t swap8:1;
+		uint64_t endian:1;
+		uint64_t size:20;
+		uint64_t adr:36;
+	} s;
+	struct cvmx_mio_boot_dma_cfgx_s cn52xx;
+	struct cvmx_mio_boot_dma_cfgx_s cn52xxp1;
+	struct cvmx_mio_boot_dma_cfgx_s cn56xx;
+	struct cvmx_mio_boot_dma_cfgx_s cn56xxp1;
+} cvmx_mio_boot_dma_cfgx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_boot_dma_intx_s {
+		uint64_t reserved_2_63:62;
+		uint64_t dmarq:1;
+		uint64_t done:1;
+	} s;
+	struct cvmx_mio_boot_dma_intx_s cn52xx;
+	struct cvmx_mio_boot_dma_intx_s cn52xxp1;
+	struct cvmx_mio_boot_dma_intx_s cn56xx;
+	struct cvmx_mio_boot_dma_intx_s cn56xxp1;
+} cvmx_mio_boot_dma_intx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_boot_dma_int_enx_s {
+		uint64_t reserved_2_63:62;
+		uint64_t dmarq:1;
+		uint64_t done:1;
+	} s;
+	struct cvmx_mio_boot_dma_int_enx_s cn52xx;
+	struct cvmx_mio_boot_dma_int_enx_s cn52xxp1;
+	struct cvmx_mio_boot_dma_int_enx_s cn56xx;
+	struct cvmx_mio_boot_dma_int_enx_s cn56xxp1;
+} cvmx_mio_boot_dma_int_enx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_boot_dma_timx_s {
+		uint64_t dmack_pi:1;
+		uint64_t dmarq_pi:1;
+		uint64_t tim_mult:2;
+		uint64_t rd_dly:3;
+		uint64_t ddr:1;
+		uint64_t width:1;
+		uint64_t reserved_48_54:7;
+		uint64_t pause:6;
+		uint64_t dmack_h:6;
+		uint64_t we_n:6;
+		uint64_t we_a:6;
+		uint64_t oe_n:6;
+		uint64_t oe_a:6;
+		uint64_t dmack_s:6;
+		uint64_t dmarq:6;
+	} s;
+	struct cvmx_mio_boot_dma_timx_s cn52xx;
+	struct cvmx_mio_boot_dma_timx_s cn52xxp1;
+	struct cvmx_mio_boot_dma_timx_s cn56xx;
+	struct cvmx_mio_boot_dma_timx_s cn56xxp1;
+} cvmx_mio_boot_dma_timx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_boot_err_s {
+		uint64_t reserved_2_63:62;
+		uint64_t wait_err:1;
+		uint64_t adr_err:1;
+	} s;
+	struct cvmx_mio_boot_err_s cn30xx;
+	struct cvmx_mio_boot_err_s cn31xx;
+	struct cvmx_mio_boot_err_s cn38xx;
+	struct cvmx_mio_boot_err_s cn38xxp2;
+	struct cvmx_mio_boot_err_s cn50xx;
+	struct cvmx_mio_boot_err_s cn52xx;
+	struct cvmx_mio_boot_err_s cn52xxp1;
+	struct cvmx_mio_boot_err_s cn56xx;
+	struct cvmx_mio_boot_err_s cn56xxp1;
+	struct cvmx_mio_boot_err_s cn58xx;
+	struct cvmx_mio_boot_err_s cn58xxp1;
+} cvmx_mio_boot_err_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_boot_int_s {
+		uint64_t reserved_2_63:62;
+		uint64_t wait_int:1;
+		uint64_t adr_int:1;
+	} s;
+	struct cvmx_mio_boot_int_s cn30xx;
+	struct cvmx_mio_boot_int_s cn31xx;
+	struct cvmx_mio_boot_int_s cn38xx;
+	struct cvmx_mio_boot_int_s cn38xxp2;
+	struct cvmx_mio_boot_int_s cn50xx;
+	struct cvmx_mio_boot_int_s cn52xx;
+	struct cvmx_mio_boot_int_s cn52xxp1;
+	struct cvmx_mio_boot_int_s cn56xx;
+	struct cvmx_mio_boot_int_s cn56xxp1;
+	struct cvmx_mio_boot_int_s cn58xx;
+	struct cvmx_mio_boot_int_s cn58xxp1;
+} cvmx_mio_boot_int_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_boot_loc_adr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t adr:5;
+		uint64_t reserved_0_2:3;
+	} s;
+	struct cvmx_mio_boot_loc_adr_s cn30xx;
+	struct cvmx_mio_boot_loc_adr_s cn31xx;
+	struct cvmx_mio_boot_loc_adr_s cn38xx;
+	struct cvmx_mio_boot_loc_adr_s cn38xxp2;
+	struct cvmx_mio_boot_loc_adr_s cn50xx;
+	struct cvmx_mio_boot_loc_adr_s cn52xx;
+	struct cvmx_mio_boot_loc_adr_s cn52xxp1;
+	struct cvmx_mio_boot_loc_adr_s cn56xx;
+	struct cvmx_mio_boot_loc_adr_s cn56xxp1;
+	struct cvmx_mio_boot_loc_adr_s cn58xx;
+	struct cvmx_mio_boot_loc_adr_s cn58xxp1;
+} cvmx_mio_boot_loc_adr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_boot_loc_cfgx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t en:1;
+		uint64_t reserved_28_30:3;
+		uint64_t base:25;
+		uint64_t reserved_0_2:3;
+	} s;
+	struct cvmx_mio_boot_loc_cfgx_s cn30xx;
+	struct cvmx_mio_boot_loc_cfgx_s cn31xx;
+	struct cvmx_mio_boot_loc_cfgx_s cn38xx;
+	struct cvmx_mio_boot_loc_cfgx_s cn38xxp2;
+	struct cvmx_mio_boot_loc_cfgx_s cn50xx;
+	struct cvmx_mio_boot_loc_cfgx_s cn52xx;
+	struct cvmx_mio_boot_loc_cfgx_s cn52xxp1;
+	struct cvmx_mio_boot_loc_cfgx_s cn56xx;
+	struct cvmx_mio_boot_loc_cfgx_s cn56xxp1;
+	struct cvmx_mio_boot_loc_cfgx_s cn58xx;
+	struct cvmx_mio_boot_loc_cfgx_s cn58xxp1;
+} cvmx_mio_boot_loc_cfgx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_boot_loc_dat_s {
+		uint64_t data:64;
+	} s;
+	struct cvmx_mio_boot_loc_dat_s cn30xx;
+	struct cvmx_mio_boot_loc_dat_s cn31xx;
+	struct cvmx_mio_boot_loc_dat_s cn38xx;
+	struct cvmx_mio_boot_loc_dat_s cn38xxp2;
+	struct cvmx_mio_boot_loc_dat_s cn50xx;
+	struct cvmx_mio_boot_loc_dat_s cn52xx;
+	struct cvmx_mio_boot_loc_dat_s cn52xxp1;
+	struct cvmx_mio_boot_loc_dat_s cn56xx;
+	struct cvmx_mio_boot_loc_dat_s cn56xxp1;
+	struct cvmx_mio_boot_loc_dat_s cn58xx;
+	struct cvmx_mio_boot_loc_dat_s cn58xxp1;
+} cvmx_mio_boot_loc_dat_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_boot_pin_defs_s {
+		uint64_t reserved_16_63:48;
+		uint64_t ale:1;
+		uint64_t width:1;
+		uint64_t dmack_p2:1;
+		uint64_t dmack_p1:1;
+		uint64_t dmack_p0:1;
+		uint64_t term:2;
+		uint64_t nand:1;
+		uint64_t reserved_0_7:8;
+	} s;
+	struct cvmx_mio_boot_pin_defs_cn52xx {
+		uint64_t reserved_16_63:48;
+		uint64_t ale:1;
+		uint64_t width:1;
+		uint64_t reserved_13_13:1;
+		uint64_t dmack_p1:1;
+		uint64_t dmack_p0:1;
+		uint64_t term:2;
+		uint64_t nand:1;
+		uint64_t reserved_0_7:8;
+	} cn52xx;
+	struct cvmx_mio_boot_pin_defs_cn56xx {
+		uint64_t reserved_16_63:48;
+		uint64_t ale:1;
+		uint64_t width:1;
+		uint64_t dmack_p2:1;
+		uint64_t dmack_p1:1;
+		uint64_t dmack_p0:1;
+		uint64_t term:2;
+		uint64_t reserved_0_8:9;
+	} cn56xx;
+} cvmx_mio_boot_pin_defs_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_boot_reg_cfgx_s {
+		uint64_t reserved_44_63:20;
+		uint64_t dmack:2;
+		uint64_t tim_mult:2;
+		uint64_t rd_dly:3;
+		uint64_t sam:1;
+		uint64_t we_ext:2;
+		uint64_t oe_ext:2;
+		uint64_t en:1;
+		uint64_t orbit:1;
+		uint64_t ale:1;
+		uint64_t width:1;
+		uint64_t size:12;
+		uint64_t base:16;
+	} s;
+	struct cvmx_mio_boot_reg_cfgx_cn30xx {
+		uint64_t reserved_37_63:27;
+		uint64_t sam:1;
+		uint64_t we_ext:2;
+		uint64_t oe_ext:2;
+		uint64_t en:1;
+		uint64_t orbit:1;
+		uint64_t ale:1;
+		uint64_t width:1;
+		uint64_t size:12;
+		uint64_t base:16;
+	} cn30xx;
+	struct cvmx_mio_boot_reg_cfgx_cn30xx cn31xx;
+	struct cvmx_mio_boot_reg_cfgx_cn38xx {
+		uint64_t reserved_32_63:32;
+		uint64_t en:1;
+		uint64_t orbit:1;
+		uint64_t reserved_28_29:2;
+		uint64_t size:12;
+		uint64_t base:16;
+	} cn38xx;
+	struct cvmx_mio_boot_reg_cfgx_cn38xx cn38xxp2;
+	struct cvmx_mio_boot_reg_cfgx_cn50xx {
+		uint64_t reserved_42_63:22;
+		uint64_t tim_mult:2;
+		uint64_t rd_dly:3;
+		uint64_t sam:1;
+		uint64_t we_ext:2;
+		uint64_t oe_ext:2;
+		uint64_t en:1;
+		uint64_t orbit:1;
+		uint64_t ale:1;
+		uint64_t width:1;
+		uint64_t size:12;
+		uint64_t base:16;
+	} cn50xx;
+	struct cvmx_mio_boot_reg_cfgx_s cn52xx;
+	struct cvmx_mio_boot_reg_cfgx_s cn52xxp1;
+	struct cvmx_mio_boot_reg_cfgx_s cn56xx;
+	struct cvmx_mio_boot_reg_cfgx_s cn56xxp1;
+	struct cvmx_mio_boot_reg_cfgx_cn30xx cn58xx;
+	struct cvmx_mio_boot_reg_cfgx_cn30xx cn58xxp1;
+} cvmx_mio_boot_reg_cfgx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_boot_reg_timx_s {
+		uint64_t pagem:1;
+		uint64_t waitm:1;
+		uint64_t pages:2;
+		uint64_t ale:6;
+		uint64_t page:6;
+		uint64_t wait:6;
+		uint64_t pause:6;
+		uint64_t wr_hld:6;
+		uint64_t rd_hld:6;
+		uint64_t we:6;
+		uint64_t oe:6;
+		uint64_t ce:6;
+		uint64_t adr:6;
+	} s;
+	struct cvmx_mio_boot_reg_timx_s cn30xx;
+	struct cvmx_mio_boot_reg_timx_s cn31xx;
+	struct cvmx_mio_boot_reg_timx_cn38xx {
+		uint64_t pagem:1;
+		uint64_t waitm:1;
+		uint64_t pages:2;
+		uint64_t reserved_54_59:6;
+		uint64_t page:6;
+		uint64_t wait:6;
+		uint64_t pause:6;
+		uint64_t wr_hld:6;
+		uint64_t rd_hld:6;
+		uint64_t we:6;
+		uint64_t oe:6;
+		uint64_t ce:6;
+		uint64_t adr:6;
+	} cn38xx;
+	struct cvmx_mio_boot_reg_timx_cn38xx cn38xxp2;
+	struct cvmx_mio_boot_reg_timx_s cn50xx;
+	struct cvmx_mio_boot_reg_timx_s cn52xx;
+	struct cvmx_mio_boot_reg_timx_s cn52xxp1;
+	struct cvmx_mio_boot_reg_timx_s cn56xx;
+	struct cvmx_mio_boot_reg_timx_s cn56xxp1;
+	struct cvmx_mio_boot_reg_timx_s cn58xx;
+	struct cvmx_mio_boot_reg_timx_s cn58xxp1;
+} cvmx_mio_boot_reg_timx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_boot_thr_s {
+		uint64_t reserved_22_63:42;
+		uint64_t dma_thr:6;
+		uint64_t reserved_14_15:2;
+		uint64_t fif_cnt:6;
+		uint64_t reserved_6_7:2;
+		uint64_t fif_thr:6;
+	} s;
+	struct cvmx_mio_boot_thr_cn30xx {
+		uint64_t reserved_14_63:50;
+		uint64_t fif_cnt:6;
+		uint64_t reserved_6_7:2;
+		uint64_t fif_thr:6;
+	} cn30xx;
+	struct cvmx_mio_boot_thr_cn30xx cn31xx;
+	struct cvmx_mio_boot_thr_cn30xx cn38xx;
+	struct cvmx_mio_boot_thr_cn30xx cn38xxp2;
+	struct cvmx_mio_boot_thr_cn30xx cn50xx;
+	struct cvmx_mio_boot_thr_s cn52xx;
+	struct cvmx_mio_boot_thr_s cn52xxp1;
+	struct cvmx_mio_boot_thr_s cn56xx;
+	struct cvmx_mio_boot_thr_s cn56xxp1;
+	struct cvmx_mio_boot_thr_cn30xx cn58xx;
+	struct cvmx_mio_boot_thr_cn30xx cn58xxp1;
+} cvmx_mio_boot_thr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_fus_bnk_datx_s {
+		uint64_t dat:64;
+	} s;
+	struct cvmx_mio_fus_bnk_datx_s cn50xx;
+	struct cvmx_mio_fus_bnk_datx_s cn52xx;
+	struct cvmx_mio_fus_bnk_datx_s cn52xxp1;
+	struct cvmx_mio_fus_bnk_datx_s cn56xx;
+	struct cvmx_mio_fus_bnk_datx_s cn56xxp1;
+	struct cvmx_mio_fus_bnk_datx_s cn58xx;
+	struct cvmx_mio_fus_bnk_datx_s cn58xxp1;
+} cvmx_mio_fus_bnk_datx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_fus_dat0_s {
+		uint64_t reserved_32_63:32;
+		uint64_t man_info:32;
+	} s;
+	struct cvmx_mio_fus_dat0_s cn30xx;
+	struct cvmx_mio_fus_dat0_s cn31xx;
+	struct cvmx_mio_fus_dat0_s cn38xx;
+	struct cvmx_mio_fus_dat0_s cn38xxp2;
+	struct cvmx_mio_fus_dat0_s cn50xx;
+	struct cvmx_mio_fus_dat0_s cn52xx;
+	struct cvmx_mio_fus_dat0_s cn52xxp1;
+	struct cvmx_mio_fus_dat0_s cn56xx;
+	struct cvmx_mio_fus_dat0_s cn56xxp1;
+	struct cvmx_mio_fus_dat0_s cn58xx;
+	struct cvmx_mio_fus_dat0_s cn58xxp1;
+} cvmx_mio_fus_dat0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_fus_dat1_s {
+		uint64_t reserved_32_63:32;
+		uint64_t man_info:32;
+	} s;
+	struct cvmx_mio_fus_dat1_s cn30xx;
+	struct cvmx_mio_fus_dat1_s cn31xx;
+	struct cvmx_mio_fus_dat1_s cn38xx;
+	struct cvmx_mio_fus_dat1_s cn38xxp2;
+	struct cvmx_mio_fus_dat1_s cn50xx;
+	struct cvmx_mio_fus_dat1_s cn52xx;
+	struct cvmx_mio_fus_dat1_s cn52xxp1;
+	struct cvmx_mio_fus_dat1_s cn56xx;
+	struct cvmx_mio_fus_dat1_s cn56xxp1;
+	struct cvmx_mio_fus_dat1_s cn58xx;
+	struct cvmx_mio_fus_dat1_s cn58xxp1;
+} cvmx_mio_fus_dat1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_fus_dat2_s {
+		uint64_t reserved_34_63:30;
+		uint64_t fus318:1;
+		uint64_t raid_en:1;
+		uint64_t reserved_30_31:2;
+		uint64_t nokasu:1;
+		uint64_t nodfa_cp2:1;
+		uint64_t nomul:1;
+		uint64_t nocrypto:1;
+		uint64_t rst_sht:1;
+		uint64_t bist_dis:1;
+		uint64_t chip_id:8;
+		uint64_t reserved_0_15:16;
+	} s;
+	struct cvmx_mio_fus_dat2_cn30xx {
+		uint64_t reserved_29_63:35;
+		uint64_t nodfa_cp2:1;
+		uint64_t nomul:1;
+		uint64_t nocrypto:1;
+		uint64_t rst_sht:1;
+		uint64_t bist_dis:1;
+		uint64_t chip_id:8;
+		uint64_t pll_off:4;
+		uint64_t reserved_1_11:11;
+		uint64_t pp_dis:1;
+	} cn30xx;
+	struct cvmx_mio_fus_dat2_cn31xx {
+		uint64_t reserved_29_63:35;
+		uint64_t nodfa_cp2:1;
+		uint64_t nomul:1;
+		uint64_t nocrypto:1;
+		uint64_t rst_sht:1;
+		uint64_t bist_dis:1;
+		uint64_t chip_id:8;
+		uint64_t pll_off:4;
+		uint64_t reserved_2_11:10;
+		uint64_t pp_dis:2;
+	} cn31xx;
+	struct cvmx_mio_fus_dat2_cn38xx {
+		uint64_t reserved_29_63:35;
+		uint64_t nodfa_cp2:1;
+		uint64_t nomul:1;
+		uint64_t nocrypto:1;
+		uint64_t rst_sht:1;
+		uint64_t bist_dis:1;
+		uint64_t chip_id:8;
+		uint64_t pp_dis:16;
+	} cn38xx;
+	struct cvmx_mio_fus_dat2_cn38xx cn38xxp2;
+	struct cvmx_mio_fus_dat2_cn50xx {
+		uint64_t reserved_34_63:30;
+		uint64_t fus318:1;
+		uint64_t raid_en:1;
+		uint64_t reserved_30_31:2;
+		uint64_t nokasu:1;
+		uint64_t nodfa_cp2:1;
+		uint64_t nomul:1;
+		uint64_t nocrypto:1;
+		uint64_t rst_sht:1;
+		uint64_t bist_dis:1;
+		uint64_t chip_id:8;
+		uint64_t reserved_2_15:14;
+		uint64_t pp_dis:2;
+	} cn50xx;
+	struct cvmx_mio_fus_dat2_cn52xx {
+		uint64_t reserved_34_63:30;
+		uint64_t fus318:1;
+		uint64_t raid_en:1;
+		uint64_t reserved_30_31:2;
+		uint64_t nokasu:1;
+		uint64_t nodfa_cp2:1;
+		uint64_t nomul:1;
+		uint64_t nocrypto:1;
+		uint64_t rst_sht:1;
+		uint64_t bist_dis:1;
+		uint64_t chip_id:8;
+		uint64_t reserved_4_15:12;
+		uint64_t pp_dis:4;
+	} cn52xx;
+	struct cvmx_mio_fus_dat2_cn52xx cn52xxp1;
+	struct cvmx_mio_fus_dat2_cn56xx {
+		uint64_t reserved_34_63:30;
+		uint64_t fus318:1;
+		uint64_t raid_en:1;
+		uint64_t reserved_30_31:2;
+		uint64_t nokasu:1;
+		uint64_t nodfa_cp2:1;
+		uint64_t nomul:1;
+		uint64_t nocrypto:1;
+		uint64_t rst_sht:1;
+		uint64_t bist_dis:1;
+		uint64_t chip_id:8;
+		uint64_t reserved_12_15:4;
+		uint64_t pp_dis:12;
+	} cn56xx;
+	struct cvmx_mio_fus_dat2_cn56xx cn56xxp1;
+	struct cvmx_mio_fus_dat2_cn58xx {
+		uint64_t reserved_30_63:34;
+		uint64_t nokasu:1;
+		uint64_t nodfa_cp2:1;
+		uint64_t nomul:1;
+		uint64_t nocrypto:1;
+		uint64_t rst_sht:1;
+		uint64_t bist_dis:1;
+		uint64_t chip_id:8;
+		uint64_t pp_dis:16;
+	} cn58xx;
+	struct cvmx_mio_fus_dat2_cn58xx cn58xxp1;
+} cvmx_mio_fus_dat2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_fus_dat3_s {
+		uint64_t reserved_32_63:32;
+		uint64_t pll_div4:1;
+		uint64_t zip_crip:2;
+		uint64_t bar2_en:1;
+		uint64_t efus_lck:1;
+		uint64_t efus_ign:1;
+		uint64_t nozip:1;
+		uint64_t nodfa_dte:1;
+		uint64_t icache:24;
+	} s;
+	struct cvmx_mio_fus_dat3_cn30xx {
+		uint64_t reserved_32_63:32;
+		uint64_t pll_div4:1;
+		uint64_t reserved_29_30:2;
+		uint64_t bar2_en:1;
+		uint64_t efus_lck:1;
+		uint64_t efus_ign:1;
+		uint64_t nozip:1;
+		uint64_t nodfa_dte:1;
+		uint64_t icache:24;
+	} cn30xx;
+	struct cvmx_mio_fus_dat3_s cn31xx;
+	struct cvmx_mio_fus_dat3_cn38xx {
+		uint64_t reserved_31_63:33;
+		uint64_t zip_crip:2;
+		uint64_t bar2_en:1;
+		uint64_t efus_lck:1;
+		uint64_t efus_ign:1;
+		uint64_t nozip:1;
+		uint64_t nodfa_dte:1;
+		uint64_t icache:24;
+	} cn38xx;
+	struct cvmx_mio_fus_dat3_cn38xxp2 {
+		uint64_t reserved_29_63:35;
+		uint64_t bar2_en:1;
+		uint64_t efus_lck:1;
+		uint64_t efus_ign:1;
+		uint64_t nozip:1;
+		uint64_t nodfa_dte:1;
+		uint64_t icache:24;
+	} cn38xxp2;
+	struct cvmx_mio_fus_dat3_cn38xx cn50xx;
+	struct cvmx_mio_fus_dat3_cn38xx cn52xx;
+	struct cvmx_mio_fus_dat3_cn38xx cn52xxp1;
+	struct cvmx_mio_fus_dat3_cn38xx cn56xx;
+	struct cvmx_mio_fus_dat3_cn38xx cn56xxp1;
+	struct cvmx_mio_fus_dat3_cn38xx cn58xx;
+	struct cvmx_mio_fus_dat3_cn38xx cn58xxp1;
+} cvmx_mio_fus_dat3_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_fus_ema_s {
+		uint64_t reserved_7_63:57;
+		uint64_t eff_ema:3;
+		uint64_t reserved_3_3:1;
+		uint64_t ema:3;
+	} s;
+	struct cvmx_mio_fus_ema_s cn50xx;
+	struct cvmx_mio_fus_ema_s cn52xx;
+	struct cvmx_mio_fus_ema_s cn52xxp1;
+	struct cvmx_mio_fus_ema_s cn56xx;
+	struct cvmx_mio_fus_ema_s cn56xxp1;
+	struct cvmx_mio_fus_ema_cn58xx {
+		uint64_t reserved_2_63:62;
+		uint64_t ema:2;
+	} cn58xx;
+	struct cvmx_mio_fus_ema_cn58xx cn58xxp1;
+} cvmx_mio_fus_ema_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_fus_pdf_s {
+		uint64_t pdf:64;
+	} s;
+	struct cvmx_mio_fus_pdf_s cn50xx;
+	struct cvmx_mio_fus_pdf_s cn52xx;
+	struct cvmx_mio_fus_pdf_s cn52xxp1;
+	struct cvmx_mio_fus_pdf_s cn56xx;
+	struct cvmx_mio_fus_pdf_s cn56xxp1;
+	struct cvmx_mio_fus_pdf_s cn58xx;
+} cvmx_mio_fus_pdf_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_fus_pll_s {
+		uint64_t reserved_2_63:62;
+		uint64_t rfslip:1;
+		uint64_t fbslip:1;
+	} s;
+	struct cvmx_mio_fus_pll_s cn50xx;
+	struct cvmx_mio_fus_pll_s cn52xx;
+	struct cvmx_mio_fus_pll_s cn52xxp1;
+	struct cvmx_mio_fus_pll_s cn56xx;
+	struct cvmx_mio_fus_pll_s cn56xxp1;
+	struct cvmx_mio_fus_pll_s cn58xx;
+	struct cvmx_mio_fus_pll_s cn58xxp1;
+} cvmx_mio_fus_pll_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_fus_prog_s {
+		uint64_t reserved_1_63:63;
+		uint64_t prog:1;
+	} s;
+	struct cvmx_mio_fus_prog_s cn30xx;
+	struct cvmx_mio_fus_prog_s cn31xx;
+	struct cvmx_mio_fus_prog_s cn38xx;
+	struct cvmx_mio_fus_prog_s cn38xxp2;
+	struct cvmx_mio_fus_prog_s cn50xx;
+	struct cvmx_mio_fus_prog_s cn52xx;
+	struct cvmx_mio_fus_prog_s cn52xxp1;
+	struct cvmx_mio_fus_prog_s cn56xx;
+	struct cvmx_mio_fus_prog_s cn56xxp1;
+	struct cvmx_mio_fus_prog_s cn58xx;
+	struct cvmx_mio_fus_prog_s cn58xxp1;
+} cvmx_mio_fus_prog_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_fus_prog_times_s {
+		uint64_t reserved_33_63:31;
+		uint64_t prog_pin:1;
+		uint64_t out:8;
+		uint64_t sclk_lo:4;
+		uint64_t sclk_hi:12;
+		uint64_t setup:8;
+	} s;
+	struct cvmx_mio_fus_prog_times_s cn50xx;
+	struct cvmx_mio_fus_prog_times_s cn52xx;
+	struct cvmx_mio_fus_prog_times_s cn52xxp1;
+	struct cvmx_mio_fus_prog_times_s cn56xx;
+	struct cvmx_mio_fus_prog_times_s cn56xxp1;
+	struct cvmx_mio_fus_prog_times_s cn58xx;
+	struct cvmx_mio_fus_prog_times_s cn58xxp1;
+} cvmx_mio_fus_prog_times_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_fus_rcmd_s {
+		uint64_t reserved_24_63:40;
+		uint64_t dat:8;
+		uint64_t reserved_13_15:3;
+		uint64_t pend:1;
+		uint64_t reserved_9_11:3;
+		uint64_t efuse:1;
+		uint64_t addr:8;
+	} s;
+	struct cvmx_mio_fus_rcmd_cn30xx {
+		uint64_t reserved_24_63:40;
+		uint64_t dat:8;
+		uint64_t reserved_13_15:3;
+		uint64_t pend:1;
+		uint64_t reserved_9_11:3;
+		uint64_t efuse:1;
+		uint64_t reserved_7_7:1;
+		uint64_t addr:7;
+	} cn30xx;
+	struct cvmx_mio_fus_rcmd_cn30xx cn31xx;
+	struct cvmx_mio_fus_rcmd_cn30xx cn38xx;
+	struct cvmx_mio_fus_rcmd_cn30xx cn38xxp2;
+	struct cvmx_mio_fus_rcmd_cn30xx cn50xx;
+	struct cvmx_mio_fus_rcmd_s cn52xx;
+	struct cvmx_mio_fus_rcmd_s cn52xxp1;
+	struct cvmx_mio_fus_rcmd_s cn56xx;
+	struct cvmx_mio_fus_rcmd_s cn56xxp1;
+	struct cvmx_mio_fus_rcmd_cn30xx cn58xx;
+	struct cvmx_mio_fus_rcmd_cn30xx cn58xxp1;
+} cvmx_mio_fus_rcmd_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_fus_spr_repair_res_s {
+		uint64_t reserved_42_63:22;
+		uint64_t repair2:14;
+		uint64_t repair1:14;
+		uint64_t repair0:14;
+	} s;
+	struct cvmx_mio_fus_spr_repair_res_s cn30xx;
+	struct cvmx_mio_fus_spr_repair_res_s cn31xx;
+	struct cvmx_mio_fus_spr_repair_res_s cn38xx;
+	struct cvmx_mio_fus_spr_repair_res_s cn50xx;
+	struct cvmx_mio_fus_spr_repair_res_s cn52xx;
+	struct cvmx_mio_fus_spr_repair_res_s cn52xxp1;
+	struct cvmx_mio_fus_spr_repair_res_s cn56xx;
+	struct cvmx_mio_fus_spr_repair_res_s cn56xxp1;
+	struct cvmx_mio_fus_spr_repair_res_s cn58xx;
+	struct cvmx_mio_fus_spr_repair_res_s cn58xxp1;
+} cvmx_mio_fus_spr_repair_res_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_fus_spr_repair_sum_s {
+		uint64_t reserved_1_63:63;
+		uint64_t too_many:1;
+	} s;
+	struct cvmx_mio_fus_spr_repair_sum_s cn30xx;
+	struct cvmx_mio_fus_spr_repair_sum_s cn31xx;
+	struct cvmx_mio_fus_spr_repair_sum_s cn38xx;
+	struct cvmx_mio_fus_spr_repair_sum_s cn50xx;
+	struct cvmx_mio_fus_spr_repair_sum_s cn52xx;
+	struct cvmx_mio_fus_spr_repair_sum_s cn52xxp1;
+	struct cvmx_mio_fus_spr_repair_sum_s cn56xx;
+	struct cvmx_mio_fus_spr_repair_sum_s cn56xxp1;
+	struct cvmx_mio_fus_spr_repair_sum_s cn58xx;
+	struct cvmx_mio_fus_spr_repair_sum_s cn58xxp1;
+} cvmx_mio_fus_spr_repair_sum_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_fus_unlock_s {
+		uint64_t reserved_24_63:40;
+		uint64_t key:24;
+	} s;
+	struct cvmx_mio_fus_unlock_s cn30xx;
+	struct cvmx_mio_fus_unlock_s cn31xx;
+} cvmx_mio_fus_unlock_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_fus_wadr_s {
+		uint64_t reserved_10_63:54;
+		uint64_t addr:10;
+	} s;
+	struct cvmx_mio_fus_wadr_s cn30xx;
+	struct cvmx_mio_fus_wadr_s cn31xx;
+	struct cvmx_mio_fus_wadr_s cn38xx;
+	struct cvmx_mio_fus_wadr_s cn38xxp2;
+	struct cvmx_mio_fus_wadr_cn50xx {
+		uint64_t reserved_2_63:62;
+		uint64_t addr:2;
+	} cn50xx;
+	struct cvmx_mio_fus_wadr_cn52xx {
+		uint64_t reserved_3_63:61;
+		uint64_t addr:3;
+	} cn52xx;
+	struct cvmx_mio_fus_wadr_cn52xx cn52xxp1;
+	struct cvmx_mio_fus_wadr_cn52xx cn56xx;
+	struct cvmx_mio_fus_wadr_cn52xx cn56xxp1;
+	struct cvmx_mio_fus_wadr_cn50xx cn58xx;
+	struct cvmx_mio_fus_wadr_cn50xx cn58xxp1;
+} cvmx_mio_fus_wadr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_ndf_dma_cfg_s {
+		uint64_t en:1;
+		uint64_t rw:1;
+		uint64_t clr:1;
+		uint64_t reserved_60_60:1;
+		uint64_t swap32:1;
+		uint64_t swap16:1;
+		uint64_t swap8:1;
+		uint64_t endian:1;
+		uint64_t size:20;
+		uint64_t adr:36;
+	} s;
+	struct cvmx_mio_ndf_dma_cfg_s cn52xx;
+} cvmx_mio_ndf_dma_cfg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_ndf_dma_int_s {
+		uint64_t reserved_1_63:63;
+		uint64_t done:1;
+	} s;
+	struct cvmx_mio_ndf_dma_int_s cn52xx;
+} cvmx_mio_ndf_dma_int_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_ndf_dma_int_en_s {
+		uint64_t reserved_1_63:63;
+		uint64_t done:1;
+	} s;
+	struct cvmx_mio_ndf_dma_int_en_s cn52xx;
+} cvmx_mio_ndf_dma_int_en_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_pll_ctl_s {
+		uint64_t reserved_5_63:59;
+		uint64_t bw_ctl:5;
+	} s;
+	struct cvmx_mio_pll_ctl_s cn30xx;
+	struct cvmx_mio_pll_ctl_s cn31xx;
+} cvmx_mio_pll_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_pll_setting_s {
+		uint64_t reserved_17_63:47;
+		uint64_t setting:17;
+	} s;
+	struct cvmx_mio_pll_setting_s cn30xx;
+	struct cvmx_mio_pll_setting_s cn31xx;
+} cvmx_mio_pll_setting_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_twsx_int_s {
+		uint64_t reserved_12_63:52;
+		uint64_t scl:1;
+		uint64_t sda:1;
+		uint64_t scl_ovr:1;
+		uint64_t sda_ovr:1;
+		uint64_t reserved_7_7:1;
+		uint64_t core_en:1;
+		uint64_t ts_en:1;
+		uint64_t st_en:1;
+		uint64_t reserved_3_3:1;
+		uint64_t core_int:1;
+		uint64_t ts_int:1;
+		uint64_t st_int:1;
+	} s;
+	struct cvmx_mio_twsx_int_s cn30xx;
+	struct cvmx_mio_twsx_int_s cn31xx;
+	struct cvmx_mio_twsx_int_s cn38xx;
+	struct cvmx_mio_twsx_int_cn38xxp2 {
+		uint64_t reserved_7_63:57;
+		uint64_t core_en:1;
+		uint64_t ts_en:1;
+		uint64_t st_en:1;
+		uint64_t reserved_3_3:1;
+		uint64_t core_int:1;
+		uint64_t ts_int:1;
+		uint64_t st_int:1;
+	} cn38xxp2;
+	struct cvmx_mio_twsx_int_s cn50xx;
+	struct cvmx_mio_twsx_int_s cn52xx;
+	struct cvmx_mio_twsx_int_s cn52xxp1;
+	struct cvmx_mio_twsx_int_s cn56xx;
+	struct cvmx_mio_twsx_int_s cn56xxp1;
+	struct cvmx_mio_twsx_int_s cn58xx;
+	struct cvmx_mio_twsx_int_s cn58xxp1;
+} cvmx_mio_twsx_int_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_twsx_sw_twsi_s {
+		uint64_t v:1;
+		uint64_t slonly:1;
+		uint64_t eia:1;
+		uint64_t op:4;
+		uint64_t r:1;
+		uint64_t sovr:1;
+		uint64_t size:3;
+		uint64_t scr:2;
+		uint64_t a:10;
+		uint64_t ia:5;
+		uint64_t eop_ia:3;
+		uint64_t d:32;
+	} s;
+	struct cvmx_mio_twsx_sw_twsi_s cn30xx;
+	struct cvmx_mio_twsx_sw_twsi_s cn31xx;
+	struct cvmx_mio_twsx_sw_twsi_s cn38xx;
+	struct cvmx_mio_twsx_sw_twsi_s cn38xxp2;
+	struct cvmx_mio_twsx_sw_twsi_s cn50xx;
+	struct cvmx_mio_twsx_sw_twsi_s cn52xx;
+	struct cvmx_mio_twsx_sw_twsi_s cn52xxp1;
+	struct cvmx_mio_twsx_sw_twsi_s cn56xx;
+	struct cvmx_mio_twsx_sw_twsi_s cn56xxp1;
+	struct cvmx_mio_twsx_sw_twsi_s cn58xx;
+	struct cvmx_mio_twsx_sw_twsi_s cn58xxp1;
+} cvmx_mio_twsx_sw_twsi_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_twsx_sw_twsi_ext_s {
+		uint64_t reserved_40_63:24;
+		uint64_t ia:8;
+		uint64_t d:32;
+	} s;
+	struct cvmx_mio_twsx_sw_twsi_ext_s cn30xx;
+	struct cvmx_mio_twsx_sw_twsi_ext_s cn31xx;
+	struct cvmx_mio_twsx_sw_twsi_ext_s cn38xx;
+	struct cvmx_mio_twsx_sw_twsi_ext_s cn38xxp2;
+	struct cvmx_mio_twsx_sw_twsi_ext_s cn50xx;
+	struct cvmx_mio_twsx_sw_twsi_ext_s cn52xx;
+	struct cvmx_mio_twsx_sw_twsi_ext_s cn52xxp1;
+	struct cvmx_mio_twsx_sw_twsi_ext_s cn56xx;
+	struct cvmx_mio_twsx_sw_twsi_ext_s cn56xxp1;
+	struct cvmx_mio_twsx_sw_twsi_ext_s cn58xx;
+	struct cvmx_mio_twsx_sw_twsi_ext_s cn58xxp1;
+} cvmx_mio_twsx_sw_twsi_ext_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_twsx_twsi_sw_s {
+		uint64_t v:2;
+		uint64_t reserved_32_61:30;
+		uint64_t d:32;
+	} s;
+	struct cvmx_mio_twsx_twsi_sw_s cn30xx;
+	struct cvmx_mio_twsx_twsi_sw_s cn31xx;
+	struct cvmx_mio_twsx_twsi_sw_s cn38xx;
+	struct cvmx_mio_twsx_twsi_sw_s cn38xxp2;
+	struct cvmx_mio_twsx_twsi_sw_s cn50xx;
+	struct cvmx_mio_twsx_twsi_sw_s cn52xx;
+	struct cvmx_mio_twsx_twsi_sw_s cn52xxp1;
+	struct cvmx_mio_twsx_twsi_sw_s cn56xx;
+	struct cvmx_mio_twsx_twsi_sw_s cn56xxp1;
+	struct cvmx_mio_twsx_twsi_sw_s cn58xx;
+	struct cvmx_mio_twsx_twsi_sw_s cn58xxp1;
+} cvmx_mio_twsx_twsi_sw_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uartx_dlh_s {
+		uint64_t reserved_8_63:56;
+		uint64_t dlh:8;
+	} s;
+	struct cvmx_mio_uartx_dlh_s cn30xx;
+	struct cvmx_mio_uartx_dlh_s cn31xx;
+	struct cvmx_mio_uartx_dlh_s cn38xx;
+	struct cvmx_mio_uartx_dlh_s cn38xxp2;
+	struct cvmx_mio_uartx_dlh_s cn50xx;
+	struct cvmx_mio_uartx_dlh_s cn52xx;
+	struct cvmx_mio_uartx_dlh_s cn52xxp1;
+	struct cvmx_mio_uartx_dlh_s cn56xx;
+	struct cvmx_mio_uartx_dlh_s cn56xxp1;
+	struct cvmx_mio_uartx_dlh_s cn58xx;
+	struct cvmx_mio_uartx_dlh_s cn58xxp1;
+} cvmx_mio_uartx_dlh_t;
+typedef cvmx_mio_uartx_dlh_t cvmx_uart_dlh_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uartx_dll_s {
+		uint64_t reserved_8_63:56;
+		uint64_t dll:8;
+	} s;
+	struct cvmx_mio_uartx_dll_s cn30xx;
+	struct cvmx_mio_uartx_dll_s cn31xx;
+	struct cvmx_mio_uartx_dll_s cn38xx;
+	struct cvmx_mio_uartx_dll_s cn38xxp2;
+	struct cvmx_mio_uartx_dll_s cn50xx;
+	struct cvmx_mio_uartx_dll_s cn52xx;
+	struct cvmx_mio_uartx_dll_s cn52xxp1;
+	struct cvmx_mio_uartx_dll_s cn56xx;
+	struct cvmx_mio_uartx_dll_s cn56xxp1;
+	struct cvmx_mio_uartx_dll_s cn58xx;
+	struct cvmx_mio_uartx_dll_s cn58xxp1;
+} cvmx_mio_uartx_dll_t;
+typedef cvmx_mio_uartx_dll_t cvmx_uart_dll_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uartx_far_s {
+		uint64_t reserved_1_63:63;
+		uint64_t far:1;
+	} s;
+	struct cvmx_mio_uartx_far_s cn30xx;
+	struct cvmx_mio_uartx_far_s cn31xx;
+	struct cvmx_mio_uartx_far_s cn38xx;
+	struct cvmx_mio_uartx_far_s cn38xxp2;
+	struct cvmx_mio_uartx_far_s cn50xx;
+	struct cvmx_mio_uartx_far_s cn52xx;
+	struct cvmx_mio_uartx_far_s cn52xxp1;
+	struct cvmx_mio_uartx_far_s cn56xx;
+	struct cvmx_mio_uartx_far_s cn56xxp1;
+	struct cvmx_mio_uartx_far_s cn58xx;
+	struct cvmx_mio_uartx_far_s cn58xxp1;
+} cvmx_mio_uartx_far_t;
+typedef cvmx_mio_uartx_far_t cvmx_uart_far_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uartx_fcr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t rxtrig:2;
+		uint64_t txtrig:2;
+		uint64_t reserved_3_3:1;
+		uint64_t txfr:1;
+		uint64_t rxfr:1;
+		uint64_t en:1;
+	} s;
+	struct cvmx_mio_uartx_fcr_s cn30xx;
+	struct cvmx_mio_uartx_fcr_s cn31xx;
+	struct cvmx_mio_uartx_fcr_s cn38xx;
+	struct cvmx_mio_uartx_fcr_s cn38xxp2;
+	struct cvmx_mio_uartx_fcr_s cn50xx;
+	struct cvmx_mio_uartx_fcr_s cn52xx;
+	struct cvmx_mio_uartx_fcr_s cn52xxp1;
+	struct cvmx_mio_uartx_fcr_s cn56xx;
+	struct cvmx_mio_uartx_fcr_s cn56xxp1;
+	struct cvmx_mio_uartx_fcr_s cn58xx;
+	struct cvmx_mio_uartx_fcr_s cn58xxp1;
+} cvmx_mio_uartx_fcr_t;
+typedef cvmx_mio_uartx_fcr_t cvmx_uart_fcr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uartx_htx_s {
+		uint64_t reserved_1_63:63;
+		uint64_t htx:1;
+	} s;
+	struct cvmx_mio_uartx_htx_s cn30xx;
+	struct cvmx_mio_uartx_htx_s cn31xx;
+	struct cvmx_mio_uartx_htx_s cn38xx;
+	struct cvmx_mio_uartx_htx_s cn38xxp2;
+	struct cvmx_mio_uartx_htx_s cn50xx;
+	struct cvmx_mio_uartx_htx_s cn52xx;
+	struct cvmx_mio_uartx_htx_s cn52xxp1;
+	struct cvmx_mio_uartx_htx_s cn56xx;
+	struct cvmx_mio_uartx_htx_s cn56xxp1;
+	struct cvmx_mio_uartx_htx_s cn58xx;
+	struct cvmx_mio_uartx_htx_s cn58xxp1;
+} cvmx_mio_uartx_htx_t;
+typedef cvmx_mio_uartx_htx_t cvmx_uart_htx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uartx_ier_s {
+		uint64_t reserved_8_63:56;
+		uint64_t ptime:1;
+		uint64_t reserved_4_6:3;
+		uint64_t edssi:1;
+		uint64_t elsi:1;
+		uint64_t etbei:1;
+		uint64_t erbfi:1;
+	} s;
+	struct cvmx_mio_uartx_ier_s cn30xx;
+	struct cvmx_mio_uartx_ier_s cn31xx;
+	struct cvmx_mio_uartx_ier_s cn38xx;
+	struct cvmx_mio_uartx_ier_s cn38xxp2;
+	struct cvmx_mio_uartx_ier_s cn50xx;
+	struct cvmx_mio_uartx_ier_s cn52xx;
+	struct cvmx_mio_uartx_ier_s cn52xxp1;
+	struct cvmx_mio_uartx_ier_s cn56xx;
+	struct cvmx_mio_uartx_ier_s cn56xxp1;
+	struct cvmx_mio_uartx_ier_s cn58xx;
+	struct cvmx_mio_uartx_ier_s cn58xxp1;
+} cvmx_mio_uartx_ier_t;
+typedef cvmx_mio_uartx_ier_t cvmx_uart_ier_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uartx_iir_s {
+		uint64_t reserved_8_63:56;
+		uint64_t fen:2;
+		uint64_t reserved_4_5:2;
+		cvmx_uart_iid_t iid:4;
+	} s;
+	struct cvmx_mio_uartx_iir_s cn30xx;
+	struct cvmx_mio_uartx_iir_s cn31xx;
+	struct cvmx_mio_uartx_iir_s cn38xx;
+	struct cvmx_mio_uartx_iir_s cn38xxp2;
+	struct cvmx_mio_uartx_iir_s cn50xx;
+	struct cvmx_mio_uartx_iir_s cn52xx;
+	struct cvmx_mio_uartx_iir_s cn52xxp1;
+	struct cvmx_mio_uartx_iir_s cn56xx;
+	struct cvmx_mio_uartx_iir_s cn56xxp1;
+	struct cvmx_mio_uartx_iir_s cn58xx;
+	struct cvmx_mio_uartx_iir_s cn58xxp1;
+} cvmx_mio_uartx_iir_t;
+typedef cvmx_mio_uartx_iir_t cvmx_uart_iir_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uartx_lcr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t dlab:1;
+		uint64_t brk:1;
+		uint64_t reserved_5_5:1;
+		uint64_t eps:1;
+		uint64_t pen:1;
+		uint64_t stop:1;
+		cvmx_uart_bits_t cls:2;
+	} s;
+	struct cvmx_mio_uartx_lcr_s cn30xx;
+	struct cvmx_mio_uartx_lcr_s cn31xx;
+	struct cvmx_mio_uartx_lcr_s cn38xx;
+	struct cvmx_mio_uartx_lcr_s cn38xxp2;
+	struct cvmx_mio_uartx_lcr_s cn50xx;
+	struct cvmx_mio_uartx_lcr_s cn52xx;
+	struct cvmx_mio_uartx_lcr_s cn52xxp1;
+	struct cvmx_mio_uartx_lcr_s cn56xx;
+	struct cvmx_mio_uartx_lcr_s cn56xxp1;
+	struct cvmx_mio_uartx_lcr_s cn58xx;
+	struct cvmx_mio_uartx_lcr_s cn58xxp1;
+} cvmx_mio_uartx_lcr_t;
+typedef cvmx_mio_uartx_lcr_t cvmx_uart_lcr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uartx_lsr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t ferr:1;
+		uint64_t temt:1;
+		uint64_t thre:1;
+		uint64_t bi:1;
+		uint64_t fe:1;
+		uint64_t pe:1;
+		uint64_t oe:1;
+		uint64_t dr:1;
+	} s;
+	struct cvmx_mio_uartx_lsr_s cn30xx;
+	struct cvmx_mio_uartx_lsr_s cn31xx;
+	struct cvmx_mio_uartx_lsr_s cn38xx;
+	struct cvmx_mio_uartx_lsr_s cn38xxp2;
+	struct cvmx_mio_uartx_lsr_s cn50xx;
+	struct cvmx_mio_uartx_lsr_s cn52xx;
+	struct cvmx_mio_uartx_lsr_s cn52xxp1;
+	struct cvmx_mio_uartx_lsr_s cn56xx;
+	struct cvmx_mio_uartx_lsr_s cn56xxp1;
+	struct cvmx_mio_uartx_lsr_s cn58xx;
+	struct cvmx_mio_uartx_lsr_s cn58xxp1;
+} cvmx_mio_uartx_lsr_t;
+typedef cvmx_mio_uartx_lsr_t cvmx_uart_lsr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uartx_mcr_s {
+		uint64_t reserved_6_63:58;
+		uint64_t afce:1;
+		uint64_t loop:1;
+		uint64_t out2:1;
+		uint64_t out1:1;
+		uint64_t rts:1;
+		uint64_t dtr:1;
+	} s;
+	struct cvmx_mio_uartx_mcr_s cn30xx;
+	struct cvmx_mio_uartx_mcr_s cn31xx;
+	struct cvmx_mio_uartx_mcr_s cn38xx;
+	struct cvmx_mio_uartx_mcr_s cn38xxp2;
+	struct cvmx_mio_uartx_mcr_s cn50xx;
+	struct cvmx_mio_uartx_mcr_s cn52xx;
+	struct cvmx_mio_uartx_mcr_s cn52xxp1;
+	struct cvmx_mio_uartx_mcr_s cn56xx;
+	struct cvmx_mio_uartx_mcr_s cn56xxp1;
+	struct cvmx_mio_uartx_mcr_s cn58xx;
+	struct cvmx_mio_uartx_mcr_s cn58xxp1;
+} cvmx_mio_uartx_mcr_t;
+typedef cvmx_mio_uartx_mcr_t cvmx_uart_mcr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uartx_msr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t dcd:1;
+		uint64_t ri:1;
+		uint64_t dsr:1;
+		uint64_t cts:1;
+		uint64_t ddcd:1;
+		uint64_t teri:1;
+		uint64_t ddsr:1;
+		uint64_t dcts:1;
+	} s;
+	struct cvmx_mio_uartx_msr_s cn30xx;
+	struct cvmx_mio_uartx_msr_s cn31xx;
+	struct cvmx_mio_uartx_msr_s cn38xx;
+	struct cvmx_mio_uartx_msr_s cn38xxp2;
+	struct cvmx_mio_uartx_msr_s cn50xx;
+	struct cvmx_mio_uartx_msr_s cn52xx;
+	struct cvmx_mio_uartx_msr_s cn52xxp1;
+	struct cvmx_mio_uartx_msr_s cn56xx;
+	struct cvmx_mio_uartx_msr_s cn56xxp1;
+	struct cvmx_mio_uartx_msr_s cn58xx;
+	struct cvmx_mio_uartx_msr_s cn58xxp1;
+} cvmx_mio_uartx_msr_t;
+typedef cvmx_mio_uartx_msr_t cvmx_uart_msr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uartx_rbr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t rbr:8;
+	} s;
+	struct cvmx_mio_uartx_rbr_s cn30xx;
+	struct cvmx_mio_uartx_rbr_s cn31xx;
+	struct cvmx_mio_uartx_rbr_s cn38xx;
+	struct cvmx_mio_uartx_rbr_s cn38xxp2;
+	struct cvmx_mio_uartx_rbr_s cn50xx;
+	struct cvmx_mio_uartx_rbr_s cn52xx;
+	struct cvmx_mio_uartx_rbr_s cn52xxp1;
+	struct cvmx_mio_uartx_rbr_s cn56xx;
+	struct cvmx_mio_uartx_rbr_s cn56xxp1;
+	struct cvmx_mio_uartx_rbr_s cn58xx;
+	struct cvmx_mio_uartx_rbr_s cn58xxp1;
+} cvmx_mio_uartx_rbr_t;
+typedef cvmx_mio_uartx_rbr_t cvmx_uart_rbr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uartx_rfl_s {
+		uint64_t reserved_7_63:57;
+		uint64_t rfl:7;
+	} s;
+	struct cvmx_mio_uartx_rfl_s cn30xx;
+	struct cvmx_mio_uartx_rfl_s cn31xx;
+	struct cvmx_mio_uartx_rfl_s cn38xx;
+	struct cvmx_mio_uartx_rfl_s cn38xxp2;
+	struct cvmx_mio_uartx_rfl_s cn50xx;
+	struct cvmx_mio_uartx_rfl_s cn52xx;
+	struct cvmx_mio_uartx_rfl_s cn52xxp1;
+	struct cvmx_mio_uartx_rfl_s cn56xx;
+	struct cvmx_mio_uartx_rfl_s cn56xxp1;
+	struct cvmx_mio_uartx_rfl_s cn58xx;
+	struct cvmx_mio_uartx_rfl_s cn58xxp1;
+} cvmx_mio_uartx_rfl_t;
+typedef cvmx_mio_uartx_rfl_t cvmx_uart_rfl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uartx_rfw_s {
+		uint64_t reserved_10_63:54;
+		uint64_t rffe:1;
+		uint64_t rfpe:1;
+		uint64_t rfwd:8;
+	} s;
+	struct cvmx_mio_uartx_rfw_s cn30xx;
+	struct cvmx_mio_uartx_rfw_s cn31xx;
+	struct cvmx_mio_uartx_rfw_s cn38xx;
+	struct cvmx_mio_uartx_rfw_s cn38xxp2;
+	struct cvmx_mio_uartx_rfw_s cn50xx;
+	struct cvmx_mio_uartx_rfw_s cn52xx;
+	struct cvmx_mio_uartx_rfw_s cn52xxp1;
+	struct cvmx_mio_uartx_rfw_s cn56xx;
+	struct cvmx_mio_uartx_rfw_s cn56xxp1;
+	struct cvmx_mio_uartx_rfw_s cn58xx;
+	struct cvmx_mio_uartx_rfw_s cn58xxp1;
+} cvmx_mio_uartx_rfw_t;
+typedef cvmx_mio_uartx_rfw_t cvmx_uart_rfw_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uartx_sbcr_s {
+		uint64_t reserved_1_63:63;
+		uint64_t sbcr:1;
+	} s;
+	struct cvmx_mio_uartx_sbcr_s cn30xx;
+	struct cvmx_mio_uartx_sbcr_s cn31xx;
+	struct cvmx_mio_uartx_sbcr_s cn38xx;
+	struct cvmx_mio_uartx_sbcr_s cn38xxp2;
+	struct cvmx_mio_uartx_sbcr_s cn50xx;
+	struct cvmx_mio_uartx_sbcr_s cn52xx;
+	struct cvmx_mio_uartx_sbcr_s cn52xxp1;
+	struct cvmx_mio_uartx_sbcr_s cn56xx;
+	struct cvmx_mio_uartx_sbcr_s cn56xxp1;
+	struct cvmx_mio_uartx_sbcr_s cn58xx;
+	struct cvmx_mio_uartx_sbcr_s cn58xxp1;
+} cvmx_mio_uartx_sbcr_t;
+typedef cvmx_mio_uartx_sbcr_t cvmx_uart_sbcr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uartx_scr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t scr:8;
+	} s;
+	struct cvmx_mio_uartx_scr_s cn30xx;
+	struct cvmx_mio_uartx_scr_s cn31xx;
+	struct cvmx_mio_uartx_scr_s cn38xx;
+	struct cvmx_mio_uartx_scr_s cn38xxp2;
+	struct cvmx_mio_uartx_scr_s cn50xx;
+	struct cvmx_mio_uartx_scr_s cn52xx;
+	struct cvmx_mio_uartx_scr_s cn52xxp1;
+	struct cvmx_mio_uartx_scr_s cn56xx;
+	struct cvmx_mio_uartx_scr_s cn56xxp1;
+	struct cvmx_mio_uartx_scr_s cn58xx;
+	struct cvmx_mio_uartx_scr_s cn58xxp1;
+} cvmx_mio_uartx_scr_t;
+typedef cvmx_mio_uartx_scr_t cvmx_uart_scr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uartx_sfe_s {
+		uint64_t reserved_1_63:63;
+		uint64_t sfe:1;
+	} s;
+	struct cvmx_mio_uartx_sfe_s cn30xx;
+	struct cvmx_mio_uartx_sfe_s cn31xx;
+	struct cvmx_mio_uartx_sfe_s cn38xx;
+	struct cvmx_mio_uartx_sfe_s cn38xxp2;
+	struct cvmx_mio_uartx_sfe_s cn50xx;
+	struct cvmx_mio_uartx_sfe_s cn52xx;
+	struct cvmx_mio_uartx_sfe_s cn52xxp1;
+	struct cvmx_mio_uartx_sfe_s cn56xx;
+	struct cvmx_mio_uartx_sfe_s cn56xxp1;
+	struct cvmx_mio_uartx_sfe_s cn58xx;
+	struct cvmx_mio_uartx_sfe_s cn58xxp1;
+} cvmx_mio_uartx_sfe_t;
+typedef cvmx_mio_uartx_sfe_t cvmx_uart_sfe_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uartx_srr_s {
+		uint64_t reserved_3_63:61;
+		uint64_t stfr:1;
+		uint64_t srfr:1;
+		uint64_t usr:1;
+	} s;
+	struct cvmx_mio_uartx_srr_s cn30xx;
+	struct cvmx_mio_uartx_srr_s cn31xx;
+	struct cvmx_mio_uartx_srr_s cn38xx;
+	struct cvmx_mio_uartx_srr_s cn38xxp2;
+	struct cvmx_mio_uartx_srr_s cn50xx;
+	struct cvmx_mio_uartx_srr_s cn52xx;
+	struct cvmx_mio_uartx_srr_s cn52xxp1;
+	struct cvmx_mio_uartx_srr_s cn56xx;
+	struct cvmx_mio_uartx_srr_s cn56xxp1;
+	struct cvmx_mio_uartx_srr_s cn58xx;
+	struct cvmx_mio_uartx_srr_s cn58xxp1;
+} cvmx_mio_uartx_srr_t;
+typedef cvmx_mio_uartx_srr_t cvmx_uart_srr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uartx_srt_s {
+		uint64_t reserved_2_63:62;
+		uint64_t srt:2;
+	} s;
+	struct cvmx_mio_uartx_srt_s cn30xx;
+	struct cvmx_mio_uartx_srt_s cn31xx;
+	struct cvmx_mio_uartx_srt_s cn38xx;
+	struct cvmx_mio_uartx_srt_s cn38xxp2;
+	struct cvmx_mio_uartx_srt_s cn50xx;
+	struct cvmx_mio_uartx_srt_s cn52xx;
+	struct cvmx_mio_uartx_srt_s cn52xxp1;
+	struct cvmx_mio_uartx_srt_s cn56xx;
+	struct cvmx_mio_uartx_srt_s cn56xxp1;
+	struct cvmx_mio_uartx_srt_s cn58xx;
+	struct cvmx_mio_uartx_srt_s cn58xxp1;
+} cvmx_mio_uartx_srt_t;
+typedef cvmx_mio_uartx_srt_t cvmx_uart_srt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uartx_srts_s {
+		uint64_t reserved_1_63:63;
+		uint64_t srts:1;
+	} s;
+	struct cvmx_mio_uartx_srts_s cn30xx;
+	struct cvmx_mio_uartx_srts_s cn31xx;
+	struct cvmx_mio_uartx_srts_s cn38xx;
+	struct cvmx_mio_uartx_srts_s cn38xxp2;
+	struct cvmx_mio_uartx_srts_s cn50xx;
+	struct cvmx_mio_uartx_srts_s cn52xx;
+	struct cvmx_mio_uartx_srts_s cn52xxp1;
+	struct cvmx_mio_uartx_srts_s cn56xx;
+	struct cvmx_mio_uartx_srts_s cn56xxp1;
+	struct cvmx_mio_uartx_srts_s cn58xx;
+	struct cvmx_mio_uartx_srts_s cn58xxp1;
+} cvmx_mio_uartx_srts_t;
+typedef cvmx_mio_uartx_srts_t cvmx_uart_srts_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uartx_stt_s {
+		uint64_t reserved_2_63:62;
+		uint64_t stt:2;
+	} s;
+	struct cvmx_mio_uartx_stt_s cn30xx;
+	struct cvmx_mio_uartx_stt_s cn31xx;
+	struct cvmx_mio_uartx_stt_s cn38xx;
+	struct cvmx_mio_uartx_stt_s cn38xxp2;
+	struct cvmx_mio_uartx_stt_s cn50xx;
+	struct cvmx_mio_uartx_stt_s cn52xx;
+	struct cvmx_mio_uartx_stt_s cn52xxp1;
+	struct cvmx_mio_uartx_stt_s cn56xx;
+	struct cvmx_mio_uartx_stt_s cn56xxp1;
+	struct cvmx_mio_uartx_stt_s cn58xx;
+	struct cvmx_mio_uartx_stt_s cn58xxp1;
+} cvmx_mio_uartx_stt_t;
+typedef cvmx_mio_uartx_stt_t cvmx_uart_stt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uartx_tfl_s {
+		uint64_t reserved_7_63:57;
+		uint64_t tfl:7;
+	} s;
+	struct cvmx_mio_uartx_tfl_s cn30xx;
+	struct cvmx_mio_uartx_tfl_s cn31xx;
+	struct cvmx_mio_uartx_tfl_s cn38xx;
+	struct cvmx_mio_uartx_tfl_s cn38xxp2;
+	struct cvmx_mio_uartx_tfl_s cn50xx;
+	struct cvmx_mio_uartx_tfl_s cn52xx;
+	struct cvmx_mio_uartx_tfl_s cn52xxp1;
+	struct cvmx_mio_uartx_tfl_s cn56xx;
+	struct cvmx_mio_uartx_tfl_s cn56xxp1;
+	struct cvmx_mio_uartx_tfl_s cn58xx;
+	struct cvmx_mio_uartx_tfl_s cn58xxp1;
+} cvmx_mio_uartx_tfl_t;
+typedef cvmx_mio_uartx_tfl_t cvmx_uart_tfl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uartx_tfr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t tfr:8;
+	} s;
+	struct cvmx_mio_uartx_tfr_s cn30xx;
+	struct cvmx_mio_uartx_tfr_s cn31xx;
+	struct cvmx_mio_uartx_tfr_s cn38xx;
+	struct cvmx_mio_uartx_tfr_s cn38xxp2;
+	struct cvmx_mio_uartx_tfr_s cn50xx;
+	struct cvmx_mio_uartx_tfr_s cn52xx;
+	struct cvmx_mio_uartx_tfr_s cn52xxp1;
+	struct cvmx_mio_uartx_tfr_s cn56xx;
+	struct cvmx_mio_uartx_tfr_s cn56xxp1;
+	struct cvmx_mio_uartx_tfr_s cn58xx;
+	struct cvmx_mio_uartx_tfr_s cn58xxp1;
+} cvmx_mio_uartx_tfr_t;
+typedef cvmx_mio_uartx_tfr_t cvmx_uart_tfr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uartx_thr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t thr:8;
+	} s;
+	struct cvmx_mio_uartx_thr_s cn30xx;
+	struct cvmx_mio_uartx_thr_s cn31xx;
+	struct cvmx_mio_uartx_thr_s cn38xx;
+	struct cvmx_mio_uartx_thr_s cn38xxp2;
+	struct cvmx_mio_uartx_thr_s cn50xx;
+	struct cvmx_mio_uartx_thr_s cn52xx;
+	struct cvmx_mio_uartx_thr_s cn52xxp1;
+	struct cvmx_mio_uartx_thr_s cn56xx;
+	struct cvmx_mio_uartx_thr_s cn56xxp1;
+	struct cvmx_mio_uartx_thr_s cn58xx;
+	struct cvmx_mio_uartx_thr_s cn58xxp1;
+} cvmx_mio_uartx_thr_t;
+typedef cvmx_mio_uartx_thr_t cvmx_uart_thr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uartx_usr_s {
+		uint64_t reserved_5_63:59;
+		uint64_t rff:1;
+		uint64_t rfne:1;
+		uint64_t tfe:1;
+		uint64_t tfnf:1;
+		uint64_t busy:1;
+	} s;
+	struct cvmx_mio_uartx_usr_s cn30xx;
+	struct cvmx_mio_uartx_usr_s cn31xx;
+	struct cvmx_mio_uartx_usr_s cn38xx;
+	struct cvmx_mio_uartx_usr_s cn38xxp2;
+	struct cvmx_mio_uartx_usr_s cn50xx;
+	struct cvmx_mio_uartx_usr_s cn52xx;
+	struct cvmx_mio_uartx_usr_s cn52xxp1;
+	struct cvmx_mio_uartx_usr_s cn56xx;
+	struct cvmx_mio_uartx_usr_s cn56xxp1;
+	struct cvmx_mio_uartx_usr_s cn58xx;
+	struct cvmx_mio_uartx_usr_s cn58xxp1;
+} cvmx_mio_uartx_usr_t;
+typedef cvmx_mio_uartx_usr_t cvmx_uart_usr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uart2_dlh_s {
+		uint64_t reserved_8_63:56;
+		uint64_t dlh:8;
+	} s;
+	struct cvmx_mio_uart2_dlh_s cn52xx;
+	struct cvmx_mio_uart2_dlh_s cn52xxp1;
+} cvmx_mio_uart2_dlh_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uart2_dll_s {
+		uint64_t reserved_8_63:56;
+		uint64_t dll:8;
+	} s;
+	struct cvmx_mio_uart2_dll_s cn52xx;
+	struct cvmx_mio_uart2_dll_s cn52xxp1;
+} cvmx_mio_uart2_dll_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uart2_far_s {
+		uint64_t reserved_1_63:63;
+		uint64_t far:1;
+	} s;
+	struct cvmx_mio_uart2_far_s cn52xx;
+	struct cvmx_mio_uart2_far_s cn52xxp1;
+} cvmx_mio_uart2_far_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uart2_fcr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t rxtrig:2;
+		uint64_t txtrig:2;
+		uint64_t reserved_3_3:1;
+		uint64_t txfr:1;
+		uint64_t rxfr:1;
+		uint64_t en:1;
+	} s;
+	struct cvmx_mio_uart2_fcr_s cn52xx;
+	struct cvmx_mio_uart2_fcr_s cn52xxp1;
+} cvmx_mio_uart2_fcr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uart2_htx_s {
+		uint64_t reserved_1_63:63;
+		uint64_t htx:1;
+	} s;
+	struct cvmx_mio_uart2_htx_s cn52xx;
+	struct cvmx_mio_uart2_htx_s cn52xxp1;
+} cvmx_mio_uart2_htx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uart2_ier_s {
+		uint64_t reserved_8_63:56;
+		uint64_t ptime:1;
+		uint64_t reserved_4_6:3;
+		uint64_t edssi:1;
+		uint64_t elsi:1;
+		uint64_t etbei:1;
+		uint64_t erbfi:1;
+	} s;
+	struct cvmx_mio_uart2_ier_s cn52xx;
+	struct cvmx_mio_uart2_ier_s cn52xxp1;
+} cvmx_mio_uart2_ier_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uart2_iir_s {
+		uint64_t reserved_8_63:56;
+		uint64_t fen:2;
+		uint64_t reserved_4_5:2;
+		uint64_t iid:4;
+	} s;
+	struct cvmx_mio_uart2_iir_s cn52xx;
+	struct cvmx_mio_uart2_iir_s cn52xxp1;
+} cvmx_mio_uart2_iir_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uart2_lcr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t dlab:1;
+		uint64_t brk:1;
+		uint64_t reserved_5_5:1;
+		uint64_t eps:1;
+		uint64_t pen:1;
+		uint64_t stop:1;
+		uint64_t cls:2;
+	} s;
+	struct cvmx_mio_uart2_lcr_s cn52xx;
+	struct cvmx_mio_uart2_lcr_s cn52xxp1;
+} cvmx_mio_uart2_lcr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uart2_lsr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t ferr:1;
+		uint64_t temt:1;
+		uint64_t thre:1;
+		uint64_t bi:1;
+		uint64_t fe:1;
+		uint64_t pe:1;
+		uint64_t oe:1;
+		uint64_t dr:1;
+	} s;
+	struct cvmx_mio_uart2_lsr_s cn52xx;
+	struct cvmx_mio_uart2_lsr_s cn52xxp1;
+} cvmx_mio_uart2_lsr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uart2_mcr_s {
+		uint64_t reserved_6_63:58;
+		uint64_t afce:1;
+		uint64_t loop:1;
+		uint64_t out2:1;
+		uint64_t out1:1;
+		uint64_t rts:1;
+		uint64_t dtr:1;
+	} s;
+	struct cvmx_mio_uart2_mcr_s cn52xx;
+	struct cvmx_mio_uart2_mcr_s cn52xxp1;
+} cvmx_mio_uart2_mcr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uart2_msr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t dcd:1;
+		uint64_t ri:1;
+		uint64_t dsr:1;
+		uint64_t cts:1;
+		uint64_t ddcd:1;
+		uint64_t teri:1;
+		uint64_t ddsr:1;
+		uint64_t dcts:1;
+	} s;
+	struct cvmx_mio_uart2_msr_s cn52xx;
+	struct cvmx_mio_uart2_msr_s cn52xxp1;
+} cvmx_mio_uart2_msr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uart2_rbr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t rbr:8;
+	} s;
+	struct cvmx_mio_uart2_rbr_s cn52xx;
+	struct cvmx_mio_uart2_rbr_s cn52xxp1;
+} cvmx_mio_uart2_rbr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uart2_rfl_s {
+		uint64_t reserved_7_63:57;
+		uint64_t rfl:7;
+	} s;
+	struct cvmx_mio_uart2_rfl_s cn52xx;
+	struct cvmx_mio_uart2_rfl_s cn52xxp1;
+} cvmx_mio_uart2_rfl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uart2_rfw_s {
+		uint64_t reserved_10_63:54;
+		uint64_t rffe:1;
+		uint64_t rfpe:1;
+		uint64_t rfwd:8;
+	} s;
+	struct cvmx_mio_uart2_rfw_s cn52xx;
+	struct cvmx_mio_uart2_rfw_s cn52xxp1;
+} cvmx_mio_uart2_rfw_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uart2_sbcr_s {
+		uint64_t reserved_1_63:63;
+		uint64_t sbcr:1;
+	} s;
+	struct cvmx_mio_uart2_sbcr_s cn52xx;
+	struct cvmx_mio_uart2_sbcr_s cn52xxp1;
+} cvmx_mio_uart2_sbcr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uart2_scr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t scr:8;
+	} s;
+	struct cvmx_mio_uart2_scr_s cn52xx;
+	struct cvmx_mio_uart2_scr_s cn52xxp1;
+} cvmx_mio_uart2_scr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uart2_sfe_s {
+		uint64_t reserved_1_63:63;
+		uint64_t sfe:1;
+	} s;
+	struct cvmx_mio_uart2_sfe_s cn52xx;
+	struct cvmx_mio_uart2_sfe_s cn52xxp1;
+} cvmx_mio_uart2_sfe_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uart2_srr_s {
+		uint64_t reserved_3_63:61;
+		uint64_t stfr:1;
+		uint64_t srfr:1;
+		uint64_t usr:1;
+	} s;
+	struct cvmx_mio_uart2_srr_s cn52xx;
+	struct cvmx_mio_uart2_srr_s cn52xxp1;
+} cvmx_mio_uart2_srr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uart2_srt_s {
+		uint64_t reserved_2_63:62;
+		uint64_t srt:2;
+	} s;
+	struct cvmx_mio_uart2_srt_s cn52xx;
+	struct cvmx_mio_uart2_srt_s cn52xxp1;
+} cvmx_mio_uart2_srt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uart2_srts_s {
+		uint64_t reserved_1_63:63;
+		uint64_t srts:1;
+	} s;
+	struct cvmx_mio_uart2_srts_s cn52xx;
+	struct cvmx_mio_uart2_srts_s cn52xxp1;
+} cvmx_mio_uart2_srts_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uart2_stt_s {
+		uint64_t reserved_2_63:62;
+		uint64_t stt:2;
+	} s;
+	struct cvmx_mio_uart2_stt_s cn52xx;
+	struct cvmx_mio_uart2_stt_s cn52xxp1;
+} cvmx_mio_uart2_stt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uart2_tfl_s {
+		uint64_t reserved_7_63:57;
+		uint64_t tfl:7;
+	} s;
+	struct cvmx_mio_uart2_tfl_s cn52xx;
+	struct cvmx_mio_uart2_tfl_s cn52xxp1;
+} cvmx_mio_uart2_tfl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uart2_tfr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t tfr:8;
+	} s;
+	struct cvmx_mio_uart2_tfr_s cn52xx;
+	struct cvmx_mio_uart2_tfr_s cn52xxp1;
+} cvmx_mio_uart2_tfr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uart2_thr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t thr:8;
+	} s;
+	struct cvmx_mio_uart2_thr_s cn52xx;
+	struct cvmx_mio_uart2_thr_s cn52xxp1;
+} cvmx_mio_uart2_thr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mio_uart2_usr_s {
+		uint64_t reserved_5_63:59;
+		uint64_t rff:1;
+		uint64_t rfne:1;
+		uint64_t tfe:1;
+		uint64_t tfnf:1;
+		uint64_t busy:1;
+	} s;
+	struct cvmx_mio_uart2_usr_s cn52xx;
+	struct cvmx_mio_uart2_usr_s cn52xxp1;
+} cvmx_mio_uart2_usr_t;
+
+typedef union {
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
+} cvmx_mixx_bist_t;
+
+typedef union {
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
+} cvmx_mixx_ctl_t;
+
+typedef union {
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
+} cvmx_mixx_intena_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mixx_ircnt_s {
+		uint64_t reserved_20_63:44;
+		uint64_t ircnt:20;
+	} s;
+	struct cvmx_mixx_ircnt_s cn52xx;
+	struct cvmx_mixx_ircnt_s cn52xxp1;
+	struct cvmx_mixx_ircnt_s cn56xx;
+	struct cvmx_mixx_ircnt_s cn56xxp1;
+} cvmx_mixx_ircnt_t;
+
+typedef union {
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
+} cvmx_mixx_irhwm_t;
+
+typedef union {
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
+} cvmx_mixx_iring1_t;
+
+typedef union {
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
+} cvmx_mixx_iring2_t;
+
+typedef union {
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
+} cvmx_mixx_isr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mixx_orcnt_s {
+		uint64_t reserved_20_63:44;
+		uint64_t orcnt:20;
+	} s;
+	struct cvmx_mixx_orcnt_s cn52xx;
+	struct cvmx_mixx_orcnt_s cn52xxp1;
+	struct cvmx_mixx_orcnt_s cn56xx;
+	struct cvmx_mixx_orcnt_s cn56xxp1;
+} cvmx_mixx_orcnt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mixx_orhwm_s {
+		uint64_t reserved_20_63:44;
+		uint64_t orhwm:20;
+	} s;
+	struct cvmx_mixx_orhwm_s cn52xx;
+	struct cvmx_mixx_orhwm_s cn52xxp1;
+	struct cvmx_mixx_orhwm_s cn56xx;
+	struct cvmx_mixx_orhwm_s cn56xxp1;
+} cvmx_mixx_orhwm_t;
+
+typedef union {
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
+} cvmx_mixx_oring1_t;
+
+typedef union {
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
+} cvmx_mixx_oring2_t;
+
+typedef union {
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
+} cvmx_mixx_remcnt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mpi_cfg_s {
+		uint64_t reserved_29_63:35;
+		uint64_t clkdiv:13;
+		uint64_t reserved_12_15:4;
+		uint64_t cslate:1;
+		uint64_t tritx:1;
+		uint64_t idleclks:2;
+		uint64_t cshi:1;
+		uint64_t csena:1;
+		uint64_t int_ena:1;
+		uint64_t lsbfirst:1;
+		uint64_t wireor:1;
+		uint64_t clk_cont:1;
+		uint64_t idlelo:1;
+		uint64_t enable:1;
+	} s;
+	struct cvmx_mpi_cfg_s cn30xx;
+	struct cvmx_mpi_cfg_cn31xx {
+		uint64_t reserved_29_63:35;
+		uint64_t clkdiv:13;
+		uint64_t reserved_11_15:5;
+		uint64_t tritx:1;
+		uint64_t idleclks:2;
+		uint64_t cshi:1;
+		uint64_t csena:1;
+		uint64_t int_ena:1;
+		uint64_t lsbfirst:1;
+		uint64_t wireor:1;
+		uint64_t clk_cont:1;
+		uint64_t idlelo:1;
+		uint64_t enable:1;
+	} cn31xx;
+	struct cvmx_mpi_cfg_s cn50xx;
+} cvmx_mpi_cfg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mpi_datx_s {
+		uint64_t reserved_8_63:56;
+		uint64_t data:8;
+	} s;
+	struct cvmx_mpi_datx_s cn30xx;
+	struct cvmx_mpi_datx_s cn31xx;
+	struct cvmx_mpi_datx_s cn50xx;
+} cvmx_mpi_datx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mpi_sts_s {
+		uint64_t reserved_13_63:51;
+		uint64_t rxnum:5;
+		uint64_t reserved_1_7:7;
+		uint64_t busy:1;
+	} s;
+	struct cvmx_mpi_sts_s cn30xx;
+	struct cvmx_mpi_sts_s cn31xx;
+	struct cvmx_mpi_sts_s cn50xx;
+} cvmx_mpi_sts_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_mpi_tx_s {
+		uint64_t reserved_17_63:47;
+		uint64_t leavecs:1;
+		uint64_t reserved_13_15:3;
+		uint64_t txnum:5;
+		uint64_t reserved_5_7:3;
+		uint64_t totnum:5;
+	} s;
+	struct cvmx_mpi_tx_s cn30xx;
+	struct cvmx_mpi_tx_s cn31xx;
+	struct cvmx_mpi_tx_s cn50xx;
+} cvmx_mpi_tx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ndf_bt_pg_info_s {
+		uint64_t reserved_11_63:53;
+		uint64_t t_mult:4;
+		uint64_t adr_cyc:4;
+		uint64_t size:3;
+	} s;
+	struct cvmx_ndf_bt_pg_info_s cn52xx;
+} cvmx_ndf_bt_pg_info_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ndf_cmd_s {
+		uint64_t nf_cmd:64;
+	} s;
+	struct cvmx_ndf_cmd_s cn52xx;
+} cvmx_ndf_cmd_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ndf_drbell_s {
+		uint64_t reserved_8_63:56;
+		uint64_t cnt:8;
+	} s;
+	struct cvmx_ndf_drbell_s cn52xx;
+} cvmx_ndf_drbell_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ndf_ecc_cnt_s {
+		uint64_t reserved_32_63:32;
+		uint64_t xor_ecc:24;
+		uint64_t ecc_err:8;
+	} s;
+	struct cvmx_ndf_ecc_cnt_s cn52xx;
+} cvmx_ndf_ecc_cnt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ndf_int_s {
+		uint64_t reserved_7_63:57;
+		uint64_t ovrf:1;
+		uint64_t ecc_mult:1;
+		uint64_t ecc_1bit:1;
+		uint64_t sm_bad:1;
+		uint64_t wdog:1;
+		uint64_t full:1;
+		uint64_t empty:1;
+	} s;
+	struct cvmx_ndf_int_s cn52xx;
+} cvmx_ndf_int_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ndf_int_en_s {
+		uint64_t reserved_7_63:57;
+		uint64_t ovrf:1;
+		uint64_t ecc_mult:1;
+		uint64_t ecc_1bit:1;
+		uint64_t sm_bad:1;
+		uint64_t wdog:1;
+		uint64_t full:1;
+		uint64_t empty:1;
+	} s;
+	struct cvmx_ndf_int_en_s cn52xx;
+} cvmx_ndf_int_en_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ndf_misc_s {
+		uint64_t reserved_27_63:37;
+		uint64_t nbr_hwm:3;
+		uint64_t wait_cnt:6;
+		uint64_t fr_byt:11;
+		uint64_t rd_done:1;
+		uint64_t rd_val:1;
+		uint64_t rd_cmd:1;
+		uint64_t bt_dma:1;
+		uint64_t bt_dis:1;
+		uint64_t ex_dis:1;
+		uint64_t rst_ff:1;
+	} s;
+	struct cvmx_ndf_misc_s cn52xx;
+} cvmx_ndf_misc_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_ndf_st_reg_s {
+		uint64_t reserved_16_63:48;
+		uint64_t exe_idle:1;
+		uint64_t exe_sm:4;
+		uint64_t bt_sm:4;
+		uint64_t rd_ff_bad:1;
+		uint64_t rd_ff:2;
+		uint64_t main_bad:1;
+		uint64_t main_sm:3;
+	} s;
+	struct cvmx_ndf_st_reg_s cn52xx;
+} cvmx_ndf_st_reg_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_npei_bar1_indexx_s {
+		uint32_t reserved_18_31:14;
+		uint32_t addr_idx:14;
+		uint32_t ca:1;
+		uint32_t end_swp:2;
+		uint32_t addr_v:1;
+	} s;
+	struct cvmx_npei_bar1_indexx_s cn52xx;
+	struct cvmx_npei_bar1_indexx_s cn52xxp1;
+	struct cvmx_npei_bar1_indexx_s cn56xx;
+	struct cvmx_npei_bar1_indexx_s cn56xxp1;
+} cvmx_npei_bar1_indexx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_bist_status_s {
+		uint64_t pkt_rdf:1;
+		uint64_t pkt_pmem:1;
+		uint64_t pkt_p1:1;
+		uint64_t reserved_60_60:1;
+		uint64_t pcr_gim:1;
+		uint64_t pkt_pif:1;
+		uint64_t pcsr_int:1;
+		uint64_t pcsr_im:1;
+		uint64_t pcsr_cnt:1;
+		uint64_t pcsr_id:1;
+		uint64_t pcsr_sl:1;
+		uint64_t reserved_50_52:3;
+		uint64_t pkt_ind:1;
+		uint64_t pkt_slm:1;
+		uint64_t reserved_36_47:12;
+		uint64_t d0_pst:1;
+		uint64_t d1_pst:1;
+		uint64_t d2_pst:1;
+		uint64_t d3_pst:1;
+		uint64_t reserved_31_31:1;
+		uint64_t n2p0_c:1;
+		uint64_t n2p0_o:1;
+		uint64_t n2p1_c:1;
+		uint64_t n2p1_o:1;
+		uint64_t cpl_p0:1;
+		uint64_t cpl_p1:1;
+		uint64_t p2n1_po:1;
+		uint64_t p2n1_no:1;
+		uint64_t p2n1_co:1;
+		uint64_t p2n0_po:1;
+		uint64_t p2n0_no:1;
+		uint64_t p2n0_co:1;
+		uint64_t p2n0_c0:1;
+		uint64_t p2n0_c1:1;
+		uint64_t p2n0_n:1;
+		uint64_t p2n0_p0:1;
+		uint64_t p2n0_p1:1;
+		uint64_t p2n1_c0:1;
+		uint64_t p2n1_c1:1;
+		uint64_t p2n1_n:1;
+		uint64_t p2n1_p0:1;
+		uint64_t p2n1_p1:1;
+		uint64_t csm0:1;
+		uint64_t csm1:1;
+		uint64_t dif0:1;
+		uint64_t dif1:1;
+		uint64_t dif2:1;
+		uint64_t dif3:1;
+		uint64_t reserved_2_2:1;
+		uint64_t msi:1;
+		uint64_t ncb_cmd:1;
+	} s;
+	struct cvmx_npei_bist_status_cn52xx {
+		uint64_t pkt_rdf:1;
+		uint64_t pkt_pmem:1;
+		uint64_t pkt_p1:1;
+		uint64_t reserved_60_60:1;
+		uint64_t pcr_gim:1;
+		uint64_t pkt_pif:1;
+		uint64_t pcsr_int:1;
+		uint64_t pcsr_im:1;
+		uint64_t pcsr_cnt:1;
+		uint64_t pcsr_id:1;
+		uint64_t pcsr_sl:1;
+		uint64_t pkt_imem:1;
+		uint64_t pkt_pfm:1;
+		uint64_t pkt_pof:1;
+		uint64_t reserved_48_49:2;
+		uint64_t pkt_pop0:1;
+		uint64_t pkt_pop1:1;
+		uint64_t d0_mem:1;
+		uint64_t d1_mem:1;
+		uint64_t d2_mem:1;
+		uint64_t d3_mem:1;
+		uint64_t d4_mem:1;
+		uint64_t ds_mem:1;
+		uint64_t reserved_36_39:4;
+		uint64_t d0_pst:1;
+		uint64_t d1_pst:1;
+		uint64_t d2_pst:1;
+		uint64_t d3_pst:1;
+		uint64_t d4_pst:1;
+		uint64_t n2p0_c:1;
+		uint64_t n2p0_o:1;
+		uint64_t n2p1_c:1;
+		uint64_t n2p1_o:1;
+		uint64_t cpl_p0:1;
+		uint64_t cpl_p1:1;
+		uint64_t p2n1_po:1;
+		uint64_t p2n1_no:1;
+		uint64_t p2n1_co:1;
+		uint64_t p2n0_po:1;
+		uint64_t p2n0_no:1;
+		uint64_t p2n0_co:1;
+		uint64_t p2n0_c0:1;
+		uint64_t p2n0_c1:1;
+		uint64_t p2n0_n:1;
+		uint64_t p2n0_p0:1;
+		uint64_t p2n0_p1:1;
+		uint64_t p2n1_c0:1;
+		uint64_t p2n1_c1:1;
+		uint64_t p2n1_n:1;
+		uint64_t p2n1_p0:1;
+		uint64_t p2n1_p1:1;
+		uint64_t csm0:1;
+		uint64_t csm1:1;
+		uint64_t dif0:1;
+		uint64_t dif1:1;
+		uint64_t dif2:1;
+		uint64_t dif3:1;
+		uint64_t dif4:1;
+		uint64_t msi:1;
+		uint64_t ncb_cmd:1;
+	} cn52xx;
+	struct cvmx_npei_bist_status_cn52xxp1 {
+		uint64_t reserved_46_63:18;
+		uint64_t d0_mem0:1;
+		uint64_t d1_mem1:1;
+		uint64_t d2_mem2:1;
+		uint64_t d3_mem3:1;
+		uint64_t dr0_mem:1;
+		uint64_t d0_mem:1;
+		uint64_t d1_mem:1;
+		uint64_t d2_mem:1;
+		uint64_t d3_mem:1;
+		uint64_t dr1_mem:1;
+		uint64_t d0_pst:1;
+		uint64_t d1_pst:1;
+		uint64_t d2_pst:1;
+		uint64_t d3_pst:1;
+		uint64_t dr2_mem:1;
+		uint64_t n2p0_c:1;
+		uint64_t n2p0_o:1;
+		uint64_t n2p1_c:1;
+		uint64_t n2p1_o:1;
+		uint64_t cpl_p0:1;
+		uint64_t cpl_p1:1;
+		uint64_t p2n1_po:1;
+		uint64_t p2n1_no:1;
+		uint64_t p2n1_co:1;
+		uint64_t p2n0_po:1;
+		uint64_t p2n0_no:1;
+		uint64_t p2n0_co:1;
+		uint64_t p2n0_c0:1;
+		uint64_t p2n0_c1:1;
+		uint64_t p2n0_n:1;
+		uint64_t p2n0_p0:1;
+		uint64_t p2n0_p1:1;
+		uint64_t p2n1_c0:1;
+		uint64_t p2n1_c1:1;
+		uint64_t p2n1_n:1;
+		uint64_t p2n1_p0:1;
+		uint64_t p2n1_p1:1;
+		uint64_t csm0:1;
+		uint64_t csm1:1;
+		uint64_t dif0:1;
+		uint64_t dif1:1;
+		uint64_t dif2:1;
+		uint64_t dif3:1;
+		uint64_t dr3_mem:1;
+		uint64_t msi:1;
+		uint64_t ncb_cmd:1;
+	} cn52xxp1;
+	struct cvmx_npei_bist_status_cn56xx {
+		uint64_t pkt_rdf:1;
+		uint64_t reserved_60_62:3;
+		uint64_t pcr_gim:1;
+		uint64_t pkt_pif:1;
+		uint64_t pcsr_int:1;
+		uint64_t pcsr_im:1;
+		uint64_t pcsr_cnt:1;
+		uint64_t pcsr_id:1;
+		uint64_t pcsr_sl:1;
+		uint64_t pkt_imem:1;
+		uint64_t pkt_pfm:1;
+		uint64_t pkt_pof:1;
+		uint64_t reserved_48_49:2;
+		uint64_t pkt_pop0:1;
+		uint64_t pkt_pop1:1;
+		uint64_t d0_mem:1;
+		uint64_t d1_mem:1;
+		uint64_t d2_mem:1;
+		uint64_t d3_mem:1;
+		uint64_t d4_mem:1;
+		uint64_t ds_mem:1;
+		uint64_t reserved_36_39:4;
+		uint64_t d0_pst:1;
+		uint64_t d1_pst:1;
+		uint64_t d2_pst:1;
+		uint64_t d3_pst:1;
+		uint64_t d4_pst:1;
+		uint64_t n2p0_c:1;
+		uint64_t n2p0_o:1;
+		uint64_t n2p1_c:1;
+		uint64_t n2p1_o:1;
+		uint64_t cpl_p0:1;
+		uint64_t cpl_p1:1;
+		uint64_t p2n1_po:1;
+		uint64_t p2n1_no:1;
+		uint64_t p2n1_co:1;
+		uint64_t p2n0_po:1;
+		uint64_t p2n0_no:1;
+		uint64_t p2n0_co:1;
+		uint64_t p2n0_c0:1;
+		uint64_t p2n0_c1:1;
+		uint64_t p2n0_n:1;
+		uint64_t p2n0_p0:1;
+		uint64_t p2n0_p1:1;
+		uint64_t p2n1_c0:1;
+		uint64_t p2n1_c1:1;
+		uint64_t p2n1_n:1;
+		uint64_t p2n1_p0:1;
+		uint64_t p2n1_p1:1;
+		uint64_t csm0:1;
+		uint64_t csm1:1;
+		uint64_t dif0:1;
+		uint64_t dif1:1;
+		uint64_t dif2:1;
+		uint64_t dif3:1;
+		uint64_t dif4:1;
+		uint64_t msi:1;
+		uint64_t ncb_cmd:1;
+	} cn56xx;
+	struct cvmx_npei_bist_status_cn56xxp1 {
+		uint64_t reserved_58_63:6;
+		uint64_t pcsr_int:1;
+		uint64_t pcsr_im:1;
+		uint64_t pcsr_cnt:1;
+		uint64_t pcsr_id:1;
+		uint64_t pcsr_sl:1;
+		uint64_t pkt_pout:1;
+		uint64_t pkt_imem:1;
+		uint64_t pkt_cntm:1;
+		uint64_t pkt_ind:1;
+		uint64_t pkt_slm:1;
+		uint64_t pkt_odf:1;
+		uint64_t pkt_oif:1;
+		uint64_t pkt_out:1;
+		uint64_t pkt_i0:1;
+		uint64_t pkt_i1:1;
+		uint64_t pkt_s0:1;
+		uint64_t pkt_s1:1;
+		uint64_t d0_mem:1;
+		uint64_t d1_mem:1;
+		uint64_t d2_mem:1;
+		uint64_t d3_mem:1;
+		uint64_t d4_mem:1;
+		uint64_t d0_pst:1;
+		uint64_t d1_pst:1;
+		uint64_t d2_pst:1;
+		uint64_t d3_pst:1;
+		uint64_t d4_pst:1;
+		uint64_t n2p0_c:1;
+		uint64_t n2p0_o:1;
+		uint64_t n2p1_c:1;
+		uint64_t n2p1_o:1;
+		uint64_t cpl_p0:1;
+		uint64_t cpl_p1:1;
+		uint64_t p2n1_po:1;
+		uint64_t p2n1_no:1;
+		uint64_t p2n1_co:1;
+		uint64_t p2n0_po:1;
+		uint64_t p2n0_no:1;
+		uint64_t p2n0_co:1;
+		uint64_t p2n0_c0:1;
+		uint64_t p2n0_c1:1;
+		uint64_t p2n0_n:1;
+		uint64_t p2n0_p0:1;
+		uint64_t p2n0_p1:1;
+		uint64_t p2n1_c0:1;
+		uint64_t p2n1_c1:1;
+		uint64_t p2n1_n:1;
+		uint64_t p2n1_p0:1;
+		uint64_t p2n1_p1:1;
+		uint64_t csm0:1;
+		uint64_t csm1:1;
+		uint64_t dif0:1;
+		uint64_t dif1:1;
+		uint64_t dif2:1;
+		uint64_t dif3:1;
+		uint64_t dif4:1;
+		uint64_t msi:1;
+		uint64_t ncb_cmd:1;
+	} cn56xxp1;
+} cvmx_npei_bist_status_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_bist_status2_s {
+		uint64_t reserved_5_63:59;
+		uint64_t psc_p0:1;
+		uint64_t psc_p1:1;
+		uint64_t pkt_gd:1;
+		uint64_t pkt_gl:1;
+		uint64_t pkt_blk:1;
+	} s;
+	struct cvmx_npei_bist_status2_s cn52xx;
+	struct cvmx_npei_bist_status2_s cn56xx;
+} cvmx_npei_bist_status2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_ctl_port0_s {
+		uint64_t reserved_21_63:43;
+		uint64_t waitl_com:1;
+		uint64_t intd:1;
+		uint64_t intc:1;
+		uint64_t intb:1;
+		uint64_t inta:1;
+		uint64_t intd_map:2;
+		uint64_t intc_map:2;
+		uint64_t intb_map:2;
+		uint64_t inta_map:2;
+		uint64_t ctlp_ro:1;
+		uint64_t reserved_6_6:1;
+		uint64_t ptlp_ro:1;
+		uint64_t bar2_enb:1;
+		uint64_t bar2_esx:2;
+		uint64_t bar2_cax:1;
+		uint64_t wait_com:1;
+	} s;
+	struct cvmx_npei_ctl_port0_s cn52xx;
+	struct cvmx_npei_ctl_port0_s cn52xxp1;
+	struct cvmx_npei_ctl_port0_s cn56xx;
+	struct cvmx_npei_ctl_port0_s cn56xxp1;
+} cvmx_npei_ctl_port0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_ctl_port1_s {
+		uint64_t reserved_21_63:43;
+		uint64_t waitl_com:1;
+		uint64_t intd:1;
+		uint64_t intc:1;
+		uint64_t intb:1;
+		uint64_t inta:1;
+		uint64_t intd_map:2;
+		uint64_t intc_map:2;
+		uint64_t intb_map:2;
+		uint64_t inta_map:2;
+		uint64_t ctlp_ro:1;
+		uint64_t reserved_6_6:1;
+		uint64_t ptlp_ro:1;
+		uint64_t bar2_enb:1;
+		uint64_t bar2_esx:2;
+		uint64_t bar2_cax:1;
+		uint64_t wait_com:1;
+	} s;
+	struct cvmx_npei_ctl_port1_s cn52xx;
+	struct cvmx_npei_ctl_port1_s cn52xxp1;
+	struct cvmx_npei_ctl_port1_s cn56xx;
+	struct cvmx_npei_ctl_port1_s cn56xxp1;
+} cvmx_npei_ctl_port1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_ctl_status_s {
+		uint64_t reserved_44_63:20;
+		uint64_t p1_ntags:6;
+		uint64_t p0_ntags:6;
+		uint64_t cfg_rtry:16;
+		uint64_t ring_en:1;
+		uint64_t lnk_rst:1;
+		uint64_t arb:1;
+		uint64_t pkt_bp:4;
+		uint64_t host_mode:1;
+		uint64_t chip_rev:8;
+	} s;
+	struct cvmx_npei_ctl_status_s cn52xx;
+	struct cvmx_npei_ctl_status_cn52xxp1 {
+		uint64_t reserved_44_63:20;
+		uint64_t p1_ntags:6;
+		uint64_t p0_ntags:6;
+		uint64_t cfg_rtry:16;
+		uint64_t reserved_15_15:1;
+		uint64_t lnk_rst:1;
+		uint64_t arb:1;
+		uint64_t reserved_9_12:4;
+		uint64_t host_mode:1;
+		uint64_t chip_rev:8;
+	} cn52xxp1;
+	struct cvmx_npei_ctl_status_s cn56xx;
+	struct cvmx_npei_ctl_status_cn56xxp1 {
+		uint64_t reserved_16_63:48;
+		uint64_t ring_en:1;
+		uint64_t lnk_rst:1;
+		uint64_t arb:1;
+		uint64_t pkt_bp:4;
+		uint64_t host_mode:1;
+		uint64_t chip_rev:8;
+	} cn56xxp1;
+} cvmx_npei_ctl_status_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_ctl_status2_s {
+		uint64_t reserved_16_63:48;
+		uint64_t mps:1;
+		uint64_t mrrs:3;
+		uint64_t c1_w_flt:1;
+		uint64_t c0_w_flt:1;
+		uint64_t c1_b1_s:3;
+		uint64_t c0_b1_s:3;
+		uint64_t c1_wi_d:1;
+		uint64_t c1_b0_d:1;
+		uint64_t c0_wi_d:1;
+		uint64_t c0_b0_d:1;
+	} s;
+	struct cvmx_npei_ctl_status2_s cn52xx;
+	struct cvmx_npei_ctl_status2_s cn52xxp1;
+	struct cvmx_npei_ctl_status2_s cn56xx;
+	struct cvmx_npei_ctl_status2_s cn56xxp1;
+} cvmx_npei_ctl_status2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_data_out_cnt_s {
+		uint64_t reserved_44_63:20;
+		uint64_t p1_ucnt:16;
+		uint64_t p1_fcnt:6;
+		uint64_t p0_ucnt:16;
+		uint64_t p0_fcnt:6;
+	} s;
+	struct cvmx_npei_data_out_cnt_s cn52xx;
+	struct cvmx_npei_data_out_cnt_s cn52xxp1;
+	struct cvmx_npei_data_out_cnt_s cn56xx;
+	struct cvmx_npei_data_out_cnt_s cn56xxp1;
+} cvmx_npei_data_out_cnt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_dbg_data_s {
+		uint64_t reserved_28_63:36;
+		uint64_t qlm0_rev_lanes:1;
+		uint64_t reserved_25_26:2;
+		uint64_t qlm1_spd:2;
+		uint64_t c_mul:5;
+		uint64_t dsel_ext:1;
+		uint64_t data:17;
+	} s;
+	struct cvmx_npei_dbg_data_cn52xx {
+		uint64_t reserved_29_63:35;
+		uint64_t qlm0_link_width:1;
+		uint64_t qlm0_rev_lanes:1;
+		uint64_t qlm1_mode:2;
+		uint64_t qlm1_spd:2;
+		uint64_t c_mul:5;
+		uint64_t dsel_ext:1;
+		uint64_t data:17;
+	} cn52xx;
+	struct cvmx_npei_dbg_data_cn52xx cn52xxp1;
+	struct cvmx_npei_dbg_data_cn56xx {
+		uint64_t reserved_29_63:35;
+		uint64_t qlm2_rev_lanes:1;
+		uint64_t qlm0_rev_lanes:1;
+		uint64_t qlm3_spd:2;
+		uint64_t qlm1_spd:2;
+		uint64_t c_mul:5;
+		uint64_t dsel_ext:1;
+		uint64_t data:17;
+	} cn56xx;
+	struct cvmx_npei_dbg_data_cn56xx cn56xxp1;
+} cvmx_npei_dbg_data_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_dbg_select_s {
+		uint64_t reserved_16_63:48;
+		uint64_t dbg_sel:16;
+	} s;
+	struct cvmx_npei_dbg_select_s cn52xx;
+	struct cvmx_npei_dbg_select_s cn52xxp1;
+	struct cvmx_npei_dbg_select_s cn56xx;
+	struct cvmx_npei_dbg_select_s cn56xxp1;
+} cvmx_npei_dbg_select_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_dmax_counts_s {
+		uint64_t reserved_39_63:25;
+		uint64_t fcnt:7;
+		uint64_t dbell:32;
+	} s;
+	struct cvmx_npei_dmax_counts_s cn52xx;
+	struct cvmx_npei_dmax_counts_s cn52xxp1;
+	struct cvmx_npei_dmax_counts_s cn56xx;
+	struct cvmx_npei_dmax_counts_s cn56xxp1;
+} cvmx_npei_dmax_counts_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_npei_dmax_dbell_s {
+		uint32_t reserved_16_31:16;
+		uint32_t dbell:16;
+	} s;
+	struct cvmx_npei_dmax_dbell_s cn52xx;
+	struct cvmx_npei_dmax_dbell_s cn52xxp1;
+	struct cvmx_npei_dmax_dbell_s cn56xx;
+	struct cvmx_npei_dmax_dbell_s cn56xxp1;
+} cvmx_npei_dmax_dbell_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_dmax_ibuff_saddr_s {
+		uint64_t reserved_37_63:27;
+		uint64_t idle:1;
+		uint64_t saddr:29;
+		uint64_t reserved_0_6:7;
+	} s;
+	struct cvmx_npei_dmax_ibuff_saddr_cn52xx {
+		uint64_t reserved_36_63:28;
+		uint64_t saddr:29;
+		uint64_t reserved_0_6:7;
+	} cn52xx;
+	struct cvmx_npei_dmax_ibuff_saddr_cn52xx cn52xxp1;
+	struct cvmx_npei_dmax_ibuff_saddr_s cn56xx;
+	struct cvmx_npei_dmax_ibuff_saddr_cn52xx cn56xxp1;
+} cvmx_npei_dmax_ibuff_saddr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_dmax_naddr_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_npei_dmax_naddr_s cn52xx;
+	struct cvmx_npei_dmax_naddr_s cn52xxp1;
+	struct cvmx_npei_dmax_naddr_s cn56xx;
+	struct cvmx_npei_dmax_naddr_s cn56xxp1;
+} cvmx_npei_dmax_naddr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_dma0_int_level_s {
+		uint64_t time:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_npei_dma0_int_level_s cn52xx;
+	struct cvmx_npei_dma0_int_level_s cn52xxp1;
+	struct cvmx_npei_dma0_int_level_s cn56xx;
+	struct cvmx_npei_dma0_int_level_s cn56xxp1;
+} cvmx_npei_dma0_int_level_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_dma1_int_level_s {
+		uint64_t time:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_npei_dma1_int_level_s cn52xx;
+	struct cvmx_npei_dma1_int_level_s cn52xxp1;
+	struct cvmx_npei_dma1_int_level_s cn56xx;
+	struct cvmx_npei_dma1_int_level_s cn56xxp1;
+} cvmx_npei_dma1_int_level_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_dma_cnts_s {
+		uint64_t dma1:32;
+		uint64_t dma0:32;
+	} s;
+	struct cvmx_npei_dma_cnts_s cn52xx;
+	struct cvmx_npei_dma_cnts_s cn52xxp1;
+	struct cvmx_npei_dma_cnts_s cn56xx;
+	struct cvmx_npei_dma_cnts_s cn56xxp1;
+} cvmx_npei_dma_cnts_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_dma_control_s {
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
+	} s;
+	struct cvmx_npei_dma_control_s cn52xx;
+	struct cvmx_npei_dma_control_cn52xxp1 {
+		uint64_t reserved_38_63:26;
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
+	} cn52xxp1;
+	struct cvmx_npei_dma_control_s cn56xx;
+	struct cvmx_npei_dma_control_s cn56xxp1;
+} cvmx_npei_dma_control_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_int_a_enb_s {
+		uint64_t reserved_10_63:54;
+		uint64_t pout_err:1;
+		uint64_t pin_bp:1;
+		uint64_t p1_rdlk:1;
+		uint64_t p0_rdlk:1;
+		uint64_t pgl_err:1;
+		uint64_t pdi_err:1;
+		uint64_t pop_err:1;
+		uint64_t pins_err:1;
+		uint64_t dma1_cpl:1;
+		uint64_t dma0_cpl:1;
+	} s;
+	struct cvmx_npei_int_a_enb_cn52xx {
+		uint64_t reserved_8_63:56;
+		uint64_t p1_rdlk:1;
+		uint64_t p0_rdlk:1;
+		uint64_t pgl_err:1;
+		uint64_t pdi_err:1;
+		uint64_t pop_err:1;
+		uint64_t pins_err:1;
+		uint64_t dma1_cpl:1;
+		uint64_t dma0_cpl:1;
+	} cn52xx;
+	struct cvmx_npei_int_a_enb_cn52xxp1 {
+		uint64_t reserved_2_63:62;
+		uint64_t dma1_cpl:1;
+		uint64_t dma0_cpl:1;
+	} cn52xxp1;
+	struct cvmx_npei_int_a_enb_s cn56xx;
+} cvmx_npei_int_a_enb_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_int_a_enb2_s {
+		uint64_t reserved_10_63:54;
+		uint64_t pout_err:1;
+		uint64_t pin_bp:1;
+		uint64_t p1_rdlk:1;
+		uint64_t p0_rdlk:1;
+		uint64_t pgl_err:1;
+		uint64_t pdi_err:1;
+		uint64_t pop_err:1;
+		uint64_t pins_err:1;
+		uint64_t dma1_cpl:1;
+		uint64_t dma0_cpl:1;
+	} s;
+	struct cvmx_npei_int_a_enb2_cn52xx {
+		uint64_t reserved_8_63:56;
+		uint64_t p1_rdlk:1;
+		uint64_t p0_rdlk:1;
+		uint64_t pgl_err:1;
+		uint64_t pdi_err:1;
+		uint64_t pop_err:1;
+		uint64_t pins_err:1;
+		uint64_t reserved_0_1:2;
+	} cn52xx;
+	struct cvmx_npei_int_a_enb2_cn52xxp1 {
+		uint64_t reserved_2_63:62;
+		uint64_t dma1_cpl:1;
+		uint64_t dma0_cpl:1;
+	} cn52xxp1;
+	struct cvmx_npei_int_a_enb2_s cn56xx;
+} cvmx_npei_int_a_enb2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_int_a_sum_s {
+		uint64_t reserved_10_63:54;
+		uint64_t pout_err:1;
+		uint64_t pin_bp:1;
+		uint64_t p1_rdlk:1;
+		uint64_t p0_rdlk:1;
+		uint64_t pgl_err:1;
+		uint64_t pdi_err:1;
+		uint64_t pop_err:1;
+		uint64_t pins_err:1;
+		uint64_t dma1_cpl:1;
+		uint64_t dma0_cpl:1;
+	} s;
+	struct cvmx_npei_int_a_sum_cn52xx {
+		uint64_t reserved_8_63:56;
+		uint64_t p1_rdlk:1;
+		uint64_t p0_rdlk:1;
+		uint64_t pgl_err:1;
+		uint64_t pdi_err:1;
+		uint64_t pop_err:1;
+		uint64_t pins_err:1;
+		uint64_t dma1_cpl:1;
+		uint64_t dma0_cpl:1;
+	} cn52xx;
+	struct cvmx_npei_int_a_sum_cn52xxp1 {
+		uint64_t reserved_2_63:62;
+		uint64_t dma1_cpl:1;
+		uint64_t dma0_cpl:1;
+	} cn52xxp1;
+	struct cvmx_npei_int_a_sum_s cn56xx;
+} cvmx_npei_int_a_sum_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_int_enb_s {
+		uint64_t mio_inta:1;
+		uint64_t reserved_62_62:1;
+		uint64_t int_a:1;
+		uint64_t c1_ldwn:1;
+		uint64_t c0_ldwn:1;
+		uint64_t c1_exc:1;
+		uint64_t c0_exc:1;
+		uint64_t c1_up_wf:1;
+		uint64_t c0_up_wf:1;
+		uint64_t c1_un_wf:1;
+		uint64_t c0_un_wf:1;
+		uint64_t c1_un_bx:1;
+		uint64_t c1_un_wi:1;
+		uint64_t c1_un_b2:1;
+		uint64_t c1_un_b1:1;
+		uint64_t c1_un_b0:1;
+		uint64_t c1_up_bx:1;
+		uint64_t c1_up_wi:1;
+		uint64_t c1_up_b2:1;
+		uint64_t c1_up_b1:1;
+		uint64_t c1_up_b0:1;
+		uint64_t c0_un_bx:1;
+		uint64_t c0_un_wi:1;
+		uint64_t c0_un_b2:1;
+		uint64_t c0_un_b1:1;
+		uint64_t c0_un_b0:1;
+		uint64_t c0_up_bx:1;
+		uint64_t c0_up_wi:1;
+		uint64_t c0_up_b2:1;
+		uint64_t c0_up_b1:1;
+		uint64_t c0_up_b0:1;
+		uint64_t c1_hpint:1;
+		uint64_t c1_pmei:1;
+		uint64_t c1_wake:1;
+		uint64_t crs1_dr:1;
+		uint64_t c1_se:1;
+		uint64_t crs1_er:1;
+		uint64_t c1_aeri:1;
+		uint64_t c0_hpint:1;
+		uint64_t c0_pmei:1;
+		uint64_t c0_wake:1;
+		uint64_t crs0_dr:1;
+		uint64_t c0_se:1;
+		uint64_t crs0_er:1;
+		uint64_t c0_aeri:1;
+		uint64_t ptime:1;
+		uint64_t pcnt:1;
+		uint64_t pidbof:1;
+		uint64_t psldbof:1;
+		uint64_t dtime1:1;
+		uint64_t dtime0:1;
+		uint64_t dcnt1:1;
+		uint64_t dcnt0:1;
+		uint64_t dma1fi:1;
+		uint64_t dma0fi:1;
+		uint64_t dma4dbo:1;
+		uint64_t dma3dbo:1;
+		uint64_t dma2dbo:1;
+		uint64_t dma1dbo:1;
+		uint64_t dma0dbo:1;
+		uint64_t iob2big:1;
+		uint64_t bar0_to:1;
+		uint64_t rml_wto:1;
+		uint64_t rml_rto:1;
+	} s;
+	struct cvmx_npei_int_enb_s cn52xx;
+	struct cvmx_npei_int_enb_cn52xxp1 {
+		uint64_t mio_inta:1;
+		uint64_t reserved_62_62:1;
+		uint64_t int_a:1;
+		uint64_t c1_ldwn:1;
+		uint64_t c0_ldwn:1;
+		uint64_t c1_exc:1;
+		uint64_t c0_exc:1;
+		uint64_t c1_up_wf:1;
+		uint64_t c0_up_wf:1;
+		uint64_t c1_un_wf:1;
+		uint64_t c0_un_wf:1;
+		uint64_t c1_un_bx:1;
+		uint64_t c1_un_wi:1;
+		uint64_t c1_un_b2:1;
+		uint64_t c1_un_b1:1;
+		uint64_t c1_un_b0:1;
+		uint64_t c1_up_bx:1;
+		uint64_t c1_up_wi:1;
+		uint64_t c1_up_b2:1;
+		uint64_t c1_up_b1:1;
+		uint64_t c1_up_b0:1;
+		uint64_t c0_un_bx:1;
+		uint64_t c0_un_wi:1;
+		uint64_t c0_un_b2:1;
+		uint64_t c0_un_b1:1;
+		uint64_t c0_un_b0:1;
+		uint64_t c0_up_bx:1;
+		uint64_t c0_up_wi:1;
+		uint64_t c0_up_b2:1;
+		uint64_t c0_up_b1:1;
+		uint64_t c0_up_b0:1;
+		uint64_t c1_hpint:1;
+		uint64_t c1_pmei:1;
+		uint64_t c1_wake:1;
+		uint64_t crs1_dr:1;
+		uint64_t c1_se:1;
+		uint64_t crs1_er:1;
+		uint64_t c1_aeri:1;
+		uint64_t c0_hpint:1;
+		uint64_t c0_pmei:1;
+		uint64_t c0_wake:1;
+		uint64_t crs0_dr:1;
+		uint64_t c0_se:1;
+		uint64_t crs0_er:1;
+		uint64_t c0_aeri:1;
+		uint64_t ptime:1;
+		uint64_t pcnt:1;
+		uint64_t pidbof:1;
+		uint64_t psldbof:1;
+		uint64_t dtime1:1;
+		uint64_t dtime0:1;
+		uint64_t dcnt1:1;
+		uint64_t dcnt0:1;
+		uint64_t dma1fi:1;
+		uint64_t dma0fi:1;
+		uint64_t reserved_8_8:1;
+		uint64_t dma3dbo:1;
+		uint64_t dma2dbo:1;
+		uint64_t dma1dbo:1;
+		uint64_t dma0dbo:1;
+		uint64_t iob2big:1;
+		uint64_t bar0_to:1;
+		uint64_t rml_wto:1;
+		uint64_t rml_rto:1;
+	} cn52xxp1;
+	struct cvmx_npei_int_enb_s cn56xx;
+	struct cvmx_npei_int_enb_cn56xxp1 {
+		uint64_t mio_inta:1;
+		uint64_t reserved_61_62:2;
+		uint64_t c1_ldwn:1;
+		uint64_t c0_ldwn:1;
+		uint64_t c1_exc:1;
+		uint64_t c0_exc:1;
+		uint64_t c1_up_wf:1;
+		uint64_t c0_up_wf:1;
+		uint64_t c1_un_wf:1;
+		uint64_t c0_un_wf:1;
+		uint64_t c1_un_bx:1;
+		uint64_t c1_un_wi:1;
+		uint64_t c1_un_b2:1;
+		uint64_t c1_un_b1:1;
+		uint64_t c1_un_b0:1;
+		uint64_t c1_up_bx:1;
+		uint64_t c1_up_wi:1;
+		uint64_t c1_up_b2:1;
+		uint64_t c1_up_b1:1;
+		uint64_t c1_up_b0:1;
+		uint64_t c0_un_bx:1;
+		uint64_t c0_un_wi:1;
+		uint64_t c0_un_b2:1;
+		uint64_t c0_un_b1:1;
+		uint64_t c0_un_b0:1;
+		uint64_t c0_up_bx:1;
+		uint64_t c0_up_wi:1;
+		uint64_t c0_up_b2:1;
+		uint64_t c0_up_b1:1;
+		uint64_t c0_up_b0:1;
+		uint64_t c1_hpint:1;
+		uint64_t c1_pmei:1;
+		uint64_t c1_wake:1;
+		uint64_t reserved_29_29:1;
+		uint64_t c1_se:1;
+		uint64_t reserved_27_27:1;
+		uint64_t c1_aeri:1;
+		uint64_t c0_hpint:1;
+		uint64_t c0_pmei:1;
+		uint64_t c0_wake:1;
+		uint64_t reserved_22_22:1;
+		uint64_t c0_se:1;
+		uint64_t reserved_20_20:1;
+		uint64_t c0_aeri:1;
+		uint64_t ptime:1;
+		uint64_t pcnt:1;
+		uint64_t pidbof:1;
+		uint64_t psldbof:1;
+		uint64_t dtime1:1;
+		uint64_t dtime0:1;
+		uint64_t dcnt1:1;
+		uint64_t dcnt0:1;
+		uint64_t dma1fi:1;
+		uint64_t dma0fi:1;
+		uint64_t dma4dbo:1;
+		uint64_t dma3dbo:1;
+		uint64_t dma2dbo:1;
+		uint64_t dma1dbo:1;
+		uint64_t dma0dbo:1;
+		uint64_t iob2big:1;
+		uint64_t bar0_to:1;
+		uint64_t rml_wto:1;
+		uint64_t rml_rto:1;
+	} cn56xxp1;
+} cvmx_npei_int_enb_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_int_enb2_s {
+		uint64_t reserved_62_63:2;
+		uint64_t int_a:1;
+		uint64_t c1_ldwn:1;
+		uint64_t c0_ldwn:1;
+		uint64_t c1_exc:1;
+		uint64_t c0_exc:1;
+		uint64_t c1_up_wf:1;
+		uint64_t c0_up_wf:1;
+		uint64_t c1_un_wf:1;
+		uint64_t c0_un_wf:1;
+		uint64_t c1_un_bx:1;
+		uint64_t c1_un_wi:1;
+		uint64_t c1_un_b2:1;
+		uint64_t c1_un_b1:1;
+		uint64_t c1_un_b0:1;
+		uint64_t c1_up_bx:1;
+		uint64_t c1_up_wi:1;
+		uint64_t c1_up_b2:1;
+		uint64_t c1_up_b1:1;
+		uint64_t c1_up_b0:1;
+		uint64_t c0_un_bx:1;
+		uint64_t c0_un_wi:1;
+		uint64_t c0_un_b2:1;
+		uint64_t c0_un_b1:1;
+		uint64_t c0_un_b0:1;
+		uint64_t c0_up_bx:1;
+		uint64_t c0_up_wi:1;
+		uint64_t c0_up_b2:1;
+		uint64_t c0_up_b1:1;
+		uint64_t c0_up_b0:1;
+		uint64_t c1_hpint:1;
+		uint64_t c1_pmei:1;
+		uint64_t c1_wake:1;
+		uint64_t crs1_dr:1;
+		uint64_t c1_se:1;
+		uint64_t crs1_er:1;
+		uint64_t c1_aeri:1;
+		uint64_t c0_hpint:1;
+		uint64_t c0_pmei:1;
+		uint64_t c0_wake:1;
+		uint64_t crs0_dr:1;
+		uint64_t c0_se:1;
+		uint64_t crs0_er:1;
+		uint64_t c0_aeri:1;
+		uint64_t ptime:1;
+		uint64_t pcnt:1;
+		uint64_t pidbof:1;
+		uint64_t psldbof:1;
+		uint64_t dtime1:1;
+		uint64_t dtime0:1;
+		uint64_t dcnt1:1;
+		uint64_t dcnt0:1;
+		uint64_t dma1fi:1;
+		uint64_t dma0fi:1;
+		uint64_t dma4dbo:1;
+		uint64_t dma3dbo:1;
+		uint64_t dma2dbo:1;
+		uint64_t dma1dbo:1;
+		uint64_t dma0dbo:1;
+		uint64_t iob2big:1;
+		uint64_t bar0_to:1;
+		uint64_t rml_wto:1;
+		uint64_t rml_rto:1;
+	} s;
+	struct cvmx_npei_int_enb2_s cn52xx;
+	struct cvmx_npei_int_enb2_cn52xxp1 {
+		uint64_t reserved_62_63:2;
+		uint64_t int_a:1;
+		uint64_t c1_ldwn:1;
+		uint64_t c0_ldwn:1;
+		uint64_t c1_exc:1;
+		uint64_t c0_exc:1;
+		uint64_t c1_up_wf:1;
+		uint64_t c0_up_wf:1;
+		uint64_t c1_un_wf:1;
+		uint64_t c0_un_wf:1;
+		uint64_t c1_un_bx:1;
+		uint64_t c1_un_wi:1;
+		uint64_t c1_un_b2:1;
+		uint64_t c1_un_b1:1;
+		uint64_t c1_un_b0:1;
+		uint64_t c1_up_bx:1;
+		uint64_t c1_up_wi:1;
+		uint64_t c1_up_b2:1;
+		uint64_t c1_up_b1:1;
+		uint64_t c1_up_b0:1;
+		uint64_t c0_un_bx:1;
+		uint64_t c0_un_wi:1;
+		uint64_t c0_un_b2:1;
+		uint64_t c0_un_b1:1;
+		uint64_t c0_un_b0:1;
+		uint64_t c0_up_bx:1;
+		uint64_t c0_up_wi:1;
+		uint64_t c0_up_b2:1;
+		uint64_t c0_up_b1:1;
+		uint64_t c0_up_b0:1;
+		uint64_t c1_hpint:1;
+		uint64_t c1_pmei:1;
+		uint64_t c1_wake:1;
+		uint64_t crs1_dr:1;
+		uint64_t c1_se:1;
+		uint64_t crs1_er:1;
+		uint64_t c1_aeri:1;
+		uint64_t c0_hpint:1;
+		uint64_t c0_pmei:1;
+		uint64_t c0_wake:1;
+		uint64_t crs0_dr:1;
+		uint64_t c0_se:1;
+		uint64_t crs0_er:1;
+		uint64_t c0_aeri:1;
+		uint64_t ptime:1;
+		uint64_t pcnt:1;
+		uint64_t pidbof:1;
+		uint64_t psldbof:1;
+		uint64_t dtime1:1;
+		uint64_t dtime0:1;
+		uint64_t dcnt1:1;
+		uint64_t dcnt0:1;
+		uint64_t dma1fi:1;
+		uint64_t dma0fi:1;
+		uint64_t reserved_8_8:1;
+		uint64_t dma3dbo:1;
+		uint64_t dma2dbo:1;
+		uint64_t dma1dbo:1;
+		uint64_t dma0dbo:1;
+		uint64_t iob2big:1;
+		uint64_t bar0_to:1;
+		uint64_t rml_wto:1;
+		uint64_t rml_rto:1;
+	} cn52xxp1;
+	struct cvmx_npei_int_enb2_s cn56xx;
+	struct cvmx_npei_int_enb2_cn56xxp1 {
+		uint64_t reserved_61_63:3;
+		uint64_t c1_ldwn:1;
+		uint64_t c0_ldwn:1;
+		uint64_t c1_exc:1;
+		uint64_t c0_exc:1;
+		uint64_t c1_up_wf:1;
+		uint64_t c0_up_wf:1;
+		uint64_t c1_un_wf:1;
+		uint64_t c0_un_wf:1;
+		uint64_t c1_un_bx:1;
+		uint64_t c1_un_wi:1;
+		uint64_t c1_un_b2:1;
+		uint64_t c1_un_b1:1;
+		uint64_t c1_un_b0:1;
+		uint64_t c1_up_bx:1;
+		uint64_t c1_up_wi:1;
+		uint64_t c1_up_b2:1;
+		uint64_t c1_up_b1:1;
+		uint64_t c1_up_b0:1;
+		uint64_t c0_un_bx:1;
+		uint64_t c0_un_wi:1;
+		uint64_t c0_un_b2:1;
+		uint64_t c0_un_b1:1;
+		uint64_t c0_un_b0:1;
+		uint64_t c0_up_bx:1;
+		uint64_t c0_up_wi:1;
+		uint64_t c0_up_b2:1;
+		uint64_t c0_up_b1:1;
+		uint64_t c0_up_b0:1;
+		uint64_t c1_hpint:1;
+		uint64_t c1_pmei:1;
+		uint64_t c1_wake:1;
+		uint64_t reserved_29_29:1;
+		uint64_t c1_se:1;
+		uint64_t reserved_27_27:1;
+		uint64_t c1_aeri:1;
+		uint64_t c0_hpint:1;
+		uint64_t c0_pmei:1;
+		uint64_t c0_wake:1;
+		uint64_t reserved_22_22:1;
+		uint64_t c0_se:1;
+		uint64_t reserved_20_20:1;
+		uint64_t c0_aeri:1;
+		uint64_t ptime:1;
+		uint64_t pcnt:1;
+		uint64_t pidbof:1;
+		uint64_t psldbof:1;
+		uint64_t dtime1:1;
+		uint64_t dtime0:1;
+		uint64_t dcnt1:1;
+		uint64_t dcnt0:1;
+		uint64_t dma1fi:1;
+		uint64_t dma0fi:1;
+		uint64_t dma4dbo:1;
+		uint64_t dma3dbo:1;
+		uint64_t dma2dbo:1;
+		uint64_t dma1dbo:1;
+		uint64_t dma0dbo:1;
+		uint64_t iob2big:1;
+		uint64_t bar0_to:1;
+		uint64_t rml_wto:1;
+		uint64_t rml_rto:1;
+	} cn56xxp1;
+} cvmx_npei_int_enb2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_int_info_s {
+		uint64_t reserved_12_63:52;
+		uint64_t pidbof:6;
+		uint64_t psldbof:6;
+	} s;
+	struct cvmx_npei_int_info_s cn52xx;
+	struct cvmx_npei_int_info_s cn56xx;
+	struct cvmx_npei_int_info_s cn56xxp1;
+} cvmx_npei_int_info_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_int_sum_s {
+		uint64_t mio_inta:1;
+		uint64_t reserved_62_62:1;
+		uint64_t int_a:1;
+		uint64_t c1_ldwn:1;
+		uint64_t c0_ldwn:1;
+		uint64_t c1_exc:1;
+		uint64_t c0_exc:1;
+		uint64_t c1_up_wf:1;
+		uint64_t c0_up_wf:1;
+		uint64_t c1_un_wf:1;
+		uint64_t c0_un_wf:1;
+		uint64_t c1_un_bx:1;
+		uint64_t c1_un_wi:1;
+		uint64_t c1_un_b2:1;
+		uint64_t c1_un_b1:1;
+		uint64_t c1_un_b0:1;
+		uint64_t c1_up_bx:1;
+		uint64_t c1_up_wi:1;
+		uint64_t c1_up_b2:1;
+		uint64_t c1_up_b1:1;
+		uint64_t c1_up_b0:1;
+		uint64_t c0_un_bx:1;
+		uint64_t c0_un_wi:1;
+		uint64_t c0_un_b2:1;
+		uint64_t c0_un_b1:1;
+		uint64_t c0_un_b0:1;
+		uint64_t c0_up_bx:1;
+		uint64_t c0_up_wi:1;
+		uint64_t c0_up_b2:1;
+		uint64_t c0_up_b1:1;
+		uint64_t c0_up_b0:1;
+		uint64_t c1_hpint:1;
+		uint64_t c1_pmei:1;
+		uint64_t c1_wake:1;
+		uint64_t crs1_dr:1;
+		uint64_t c1_se:1;
+		uint64_t crs1_er:1;
+		uint64_t c1_aeri:1;
+		uint64_t c0_hpint:1;
+		uint64_t c0_pmei:1;
+		uint64_t c0_wake:1;
+		uint64_t crs0_dr:1;
+		uint64_t c0_se:1;
+		uint64_t crs0_er:1;
+		uint64_t c0_aeri:1;
+		uint64_t ptime:1;
+		uint64_t pcnt:1;
+		uint64_t pidbof:1;
+		uint64_t psldbof:1;
+		uint64_t dtime1:1;
+		uint64_t dtime0:1;
+		uint64_t dcnt1:1;
+		uint64_t dcnt0:1;
+		uint64_t dma1fi:1;
+		uint64_t dma0fi:1;
+		uint64_t dma4dbo:1;
+		uint64_t dma3dbo:1;
+		uint64_t dma2dbo:1;
+		uint64_t dma1dbo:1;
+		uint64_t dma0dbo:1;
+		uint64_t iob2big:1;
+		uint64_t bar0_to:1;
+		uint64_t rml_wto:1;
+		uint64_t rml_rto:1;
+	} s;
+	struct cvmx_npei_int_sum_s cn52xx;
+	struct cvmx_npei_int_sum_cn52xxp1 {
+		uint64_t mio_inta:1;
+		uint64_t reserved_62_62:1;
+		uint64_t int_a:1;
+		uint64_t c1_ldwn:1;
+		uint64_t c0_ldwn:1;
+		uint64_t c1_exc:1;
+		uint64_t c0_exc:1;
+		uint64_t c1_up_wf:1;
+		uint64_t c0_up_wf:1;
+		uint64_t c1_un_wf:1;
+		uint64_t c0_un_wf:1;
+		uint64_t c1_un_bx:1;
+		uint64_t c1_un_wi:1;
+		uint64_t c1_un_b2:1;
+		uint64_t c1_un_b1:1;
+		uint64_t c1_un_b0:1;
+		uint64_t c1_up_bx:1;
+		uint64_t c1_up_wi:1;
+		uint64_t c1_up_b2:1;
+		uint64_t c1_up_b1:1;
+		uint64_t c1_up_b0:1;
+		uint64_t c0_un_bx:1;
+		uint64_t c0_un_wi:1;
+		uint64_t c0_un_b2:1;
+		uint64_t c0_un_b1:1;
+		uint64_t c0_un_b0:1;
+		uint64_t c0_up_bx:1;
+		uint64_t c0_up_wi:1;
+		uint64_t c0_up_b2:1;
+		uint64_t c0_up_b1:1;
+		uint64_t c0_up_b0:1;
+		uint64_t c1_hpint:1;
+		uint64_t c1_pmei:1;
+		uint64_t c1_wake:1;
+		uint64_t crs1_dr:1;
+		uint64_t c1_se:1;
+		uint64_t crs1_er:1;
+		uint64_t c1_aeri:1;
+		uint64_t c0_hpint:1;
+		uint64_t c0_pmei:1;
+		uint64_t c0_wake:1;
+		uint64_t crs0_dr:1;
+		uint64_t c0_se:1;
+		uint64_t crs0_er:1;
+		uint64_t c0_aeri:1;
+		uint64_t reserved_15_18:4;
+		uint64_t dtime1:1;
+		uint64_t dtime0:1;
+		uint64_t dcnt1:1;
+		uint64_t dcnt0:1;
+		uint64_t dma1fi:1;
+		uint64_t dma0fi:1;
+		uint64_t reserved_8_8:1;
+		uint64_t dma3dbo:1;
+		uint64_t dma2dbo:1;
+		uint64_t dma1dbo:1;
+		uint64_t dma0dbo:1;
+		uint64_t iob2big:1;
+		uint64_t bar0_to:1;
+		uint64_t rml_wto:1;
+		uint64_t rml_rto:1;
+	} cn52xxp1;
+	struct cvmx_npei_int_sum_s cn56xx;
+	struct cvmx_npei_int_sum_cn56xxp1 {
+		uint64_t mio_inta:1;
+		uint64_t reserved_61_62:2;
+		uint64_t c1_ldwn:1;
+		uint64_t c0_ldwn:1;
+		uint64_t c1_exc:1;
+		uint64_t c0_exc:1;
+		uint64_t c1_up_wf:1;
+		uint64_t c0_up_wf:1;
+		uint64_t c1_un_wf:1;
+		uint64_t c0_un_wf:1;
+		uint64_t c1_un_bx:1;
+		uint64_t c1_un_wi:1;
+		uint64_t c1_un_b2:1;
+		uint64_t c1_un_b1:1;
+		uint64_t c1_un_b0:1;
+		uint64_t c1_up_bx:1;
+		uint64_t c1_up_wi:1;
+		uint64_t c1_up_b2:1;
+		uint64_t c1_up_b1:1;
+		uint64_t c1_up_b0:1;
+		uint64_t c0_un_bx:1;
+		uint64_t c0_un_wi:1;
+		uint64_t c0_un_b2:1;
+		uint64_t c0_un_b1:1;
+		uint64_t c0_un_b0:1;
+		uint64_t c0_up_bx:1;
+		uint64_t c0_up_wi:1;
+		uint64_t c0_up_b2:1;
+		uint64_t c0_up_b1:1;
+		uint64_t c0_up_b0:1;
+		uint64_t c1_hpint:1;
+		uint64_t c1_pmei:1;
+		uint64_t c1_wake:1;
+		uint64_t reserved_29_29:1;
+		uint64_t c1_se:1;
+		uint64_t reserved_27_27:1;
+		uint64_t c1_aeri:1;
+		uint64_t c0_hpint:1;
+		uint64_t c0_pmei:1;
+		uint64_t c0_wake:1;
+		uint64_t reserved_22_22:1;
+		uint64_t c0_se:1;
+		uint64_t reserved_20_20:1;
+		uint64_t c0_aeri:1;
+		uint64_t ptime:1;
+		uint64_t pcnt:1;
+		uint64_t pidbof:1;
+		uint64_t psldbof:1;
+		uint64_t dtime1:1;
+		uint64_t dtime0:1;
+		uint64_t dcnt1:1;
+		uint64_t dcnt0:1;
+		uint64_t dma1fi:1;
+		uint64_t dma0fi:1;
+		uint64_t dma4dbo:1;
+		uint64_t dma3dbo:1;
+		uint64_t dma2dbo:1;
+		uint64_t dma1dbo:1;
+		uint64_t dma0dbo:1;
+		uint64_t iob2big:1;
+		uint64_t bar0_to:1;
+		uint64_t rml_wto:1;
+		uint64_t rml_rto:1;
+	} cn56xxp1;
+} cvmx_npei_int_sum_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_int_sum2_s {
+		uint64_t mio_inta:1;
+		uint64_t reserved_62_62:1;
+		uint64_t int_a:1;
+		uint64_t c1_ldwn:1;
+		uint64_t c0_ldwn:1;
+		uint64_t c1_exc:1;
+		uint64_t c0_exc:1;
+		uint64_t c1_up_wf:1;
+		uint64_t c0_up_wf:1;
+		uint64_t c1_un_wf:1;
+		uint64_t c0_un_wf:1;
+		uint64_t c1_un_bx:1;
+		uint64_t c1_un_wi:1;
+		uint64_t c1_un_b2:1;
+		uint64_t c1_un_b1:1;
+		uint64_t c1_un_b0:1;
+		uint64_t c1_up_bx:1;
+		uint64_t c1_up_wi:1;
+		uint64_t c1_up_b2:1;
+		uint64_t c1_up_b1:1;
+		uint64_t c1_up_b0:1;
+		uint64_t c0_un_bx:1;
+		uint64_t c0_un_wi:1;
+		uint64_t c0_un_b2:1;
+		uint64_t c0_un_b1:1;
+		uint64_t c0_un_b0:1;
+		uint64_t c0_up_bx:1;
+		uint64_t c0_up_wi:1;
+		uint64_t c0_up_b2:1;
+		uint64_t c0_up_b1:1;
+		uint64_t c0_up_b0:1;
+		uint64_t c1_hpint:1;
+		uint64_t c1_pmei:1;
+		uint64_t c1_wake:1;
+		uint64_t crs1_dr:1;
+		uint64_t c1_se:1;
+		uint64_t crs1_er:1;
+		uint64_t c1_aeri:1;
+		uint64_t c0_hpint:1;
+		uint64_t c0_pmei:1;
+		uint64_t c0_wake:1;
+		uint64_t crs0_dr:1;
+		uint64_t c0_se:1;
+		uint64_t crs0_er:1;
+		uint64_t c0_aeri:1;
+		uint64_t reserved_15_18:4;
+		uint64_t dtime1:1;
+		uint64_t dtime0:1;
+		uint64_t dcnt1:1;
+		uint64_t dcnt0:1;
+		uint64_t dma1fi:1;
+		uint64_t dma0fi:1;
+		uint64_t reserved_8_8:1;
+		uint64_t dma3dbo:1;
+		uint64_t dma2dbo:1;
+		uint64_t dma1dbo:1;
+		uint64_t dma0dbo:1;
+		uint64_t iob2big:1;
+		uint64_t bar0_to:1;
+		uint64_t rml_wto:1;
+		uint64_t rml_rto:1;
+	} s;
+	struct cvmx_npei_int_sum2_s cn52xx;
+	struct cvmx_npei_int_sum2_s cn52xxp1;
+	struct cvmx_npei_int_sum2_s cn56xx;
+} cvmx_npei_int_sum2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_last_win_rdata0_s {
+		uint64_t data:64;
+	} s;
+	struct cvmx_npei_last_win_rdata0_s cn52xx;
+	struct cvmx_npei_last_win_rdata0_s cn52xxp1;
+	struct cvmx_npei_last_win_rdata0_s cn56xx;
+	struct cvmx_npei_last_win_rdata0_s cn56xxp1;
+} cvmx_npei_last_win_rdata0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_last_win_rdata1_s {
+		uint64_t data:64;
+	} s;
+	struct cvmx_npei_last_win_rdata1_s cn52xx;
+	struct cvmx_npei_last_win_rdata1_s cn52xxp1;
+	struct cvmx_npei_last_win_rdata1_s cn56xx;
+	struct cvmx_npei_last_win_rdata1_s cn56xxp1;
+} cvmx_npei_last_win_rdata1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_mem_access_ctl_s {
+		uint64_t reserved_14_63:50;
+		uint64_t max_word:4;
+		uint64_t timer:10;
+	} s;
+	struct cvmx_npei_mem_access_ctl_s cn52xx;
+	struct cvmx_npei_mem_access_ctl_s cn52xxp1;
+	struct cvmx_npei_mem_access_ctl_s cn56xx;
+	struct cvmx_npei_mem_access_ctl_s cn56xxp1;
+} cvmx_npei_mem_access_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_mem_access_subidx_s {
+		uint64_t reserved_42_63:22;
+		uint64_t zero:1;
+		uint64_t port:2;
+		uint64_t nmerge:1;
+		uint64_t esr:2;
+		uint64_t esw:2;
+		uint64_t nsr:1;
+		uint64_t nsw:1;
+		uint64_t ror:1;
+		uint64_t row:1;
+		uint64_t ba:30;
+	} s;
+	struct cvmx_npei_mem_access_subidx_s cn52xx;
+	struct cvmx_npei_mem_access_subidx_s cn52xxp1;
+	struct cvmx_npei_mem_access_subidx_s cn56xx;
+	struct cvmx_npei_mem_access_subidx_s cn56xxp1;
+} cvmx_npei_mem_access_subidx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_msi_enb0_s {
+		uint64_t enb:64;
+	} s;
+	struct cvmx_npei_msi_enb0_s cn52xx;
+	struct cvmx_npei_msi_enb0_s cn52xxp1;
+	struct cvmx_npei_msi_enb0_s cn56xx;
+	struct cvmx_npei_msi_enb0_s cn56xxp1;
+} cvmx_npei_msi_enb0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_msi_enb1_s {
+		uint64_t enb:64;
+	} s;
+	struct cvmx_npei_msi_enb1_s cn52xx;
+	struct cvmx_npei_msi_enb1_s cn52xxp1;
+	struct cvmx_npei_msi_enb1_s cn56xx;
+	struct cvmx_npei_msi_enb1_s cn56xxp1;
+} cvmx_npei_msi_enb1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_msi_enb2_s {
+		uint64_t enb:64;
+	} s;
+	struct cvmx_npei_msi_enb2_s cn52xx;
+	struct cvmx_npei_msi_enb2_s cn52xxp1;
+	struct cvmx_npei_msi_enb2_s cn56xx;
+	struct cvmx_npei_msi_enb2_s cn56xxp1;
+} cvmx_npei_msi_enb2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_msi_enb3_s {
+		uint64_t enb:64;
+	} s;
+	struct cvmx_npei_msi_enb3_s cn52xx;
+	struct cvmx_npei_msi_enb3_s cn52xxp1;
+	struct cvmx_npei_msi_enb3_s cn56xx;
+	struct cvmx_npei_msi_enb3_s cn56xxp1;
+} cvmx_npei_msi_enb3_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_msi_rcv0_s {
+		uint64_t intr:64;
+	} s;
+	struct cvmx_npei_msi_rcv0_s cn52xx;
+	struct cvmx_npei_msi_rcv0_s cn52xxp1;
+	struct cvmx_npei_msi_rcv0_s cn56xx;
+	struct cvmx_npei_msi_rcv0_s cn56xxp1;
+} cvmx_npei_msi_rcv0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_msi_rcv1_s {
+		uint64_t intr:64;
+	} s;
+	struct cvmx_npei_msi_rcv1_s cn52xx;
+	struct cvmx_npei_msi_rcv1_s cn52xxp1;
+	struct cvmx_npei_msi_rcv1_s cn56xx;
+	struct cvmx_npei_msi_rcv1_s cn56xxp1;
+} cvmx_npei_msi_rcv1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_msi_rcv2_s {
+		uint64_t intr:64;
+	} s;
+	struct cvmx_npei_msi_rcv2_s cn52xx;
+	struct cvmx_npei_msi_rcv2_s cn52xxp1;
+	struct cvmx_npei_msi_rcv2_s cn56xx;
+	struct cvmx_npei_msi_rcv2_s cn56xxp1;
+} cvmx_npei_msi_rcv2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_msi_rcv3_s {
+		uint64_t intr:64;
+	} s;
+	struct cvmx_npei_msi_rcv3_s cn52xx;
+	struct cvmx_npei_msi_rcv3_s cn52xxp1;
+	struct cvmx_npei_msi_rcv3_s cn56xx;
+	struct cvmx_npei_msi_rcv3_s cn56xxp1;
+} cvmx_npei_msi_rcv3_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_msi_rd_map_s {
+		uint64_t reserved_16_63:48;
+		uint64_t rd_int:8;
+		uint64_t msi_int:8;
+	} s;
+	struct cvmx_npei_msi_rd_map_s cn52xx;
+	struct cvmx_npei_msi_rd_map_s cn52xxp1;
+	struct cvmx_npei_msi_rd_map_s cn56xx;
+	struct cvmx_npei_msi_rd_map_s cn56xxp1;
+} cvmx_npei_msi_rd_map_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_msi_w1c_enb0_s {
+		uint64_t clr:64;
+	} s;
+	struct cvmx_npei_msi_w1c_enb0_s cn52xx;
+	struct cvmx_npei_msi_w1c_enb0_s cn56xx;
+} cvmx_npei_msi_w1c_enb0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_msi_w1c_enb1_s {
+		uint64_t clr:64;
+	} s;
+	struct cvmx_npei_msi_w1c_enb1_s cn52xx;
+	struct cvmx_npei_msi_w1c_enb1_s cn56xx;
+} cvmx_npei_msi_w1c_enb1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_msi_w1c_enb2_s {
+		uint64_t clr:64;
+	} s;
+	struct cvmx_npei_msi_w1c_enb2_s cn52xx;
+	struct cvmx_npei_msi_w1c_enb2_s cn56xx;
+} cvmx_npei_msi_w1c_enb2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_msi_w1c_enb3_s {
+		uint64_t clr:64;
+	} s;
+	struct cvmx_npei_msi_w1c_enb3_s cn52xx;
+	struct cvmx_npei_msi_w1c_enb3_s cn56xx;
+} cvmx_npei_msi_w1c_enb3_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_msi_w1s_enb0_s {
+		uint64_t set:64;
+	} s;
+	struct cvmx_npei_msi_w1s_enb0_s cn52xx;
+	struct cvmx_npei_msi_w1s_enb0_s cn56xx;
+} cvmx_npei_msi_w1s_enb0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_msi_w1s_enb1_s {
+		uint64_t set:64;
+	} s;
+	struct cvmx_npei_msi_w1s_enb1_s cn52xx;
+	struct cvmx_npei_msi_w1s_enb1_s cn56xx;
+} cvmx_npei_msi_w1s_enb1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_msi_w1s_enb2_s {
+		uint64_t set:64;
+	} s;
+	struct cvmx_npei_msi_w1s_enb2_s cn52xx;
+	struct cvmx_npei_msi_w1s_enb2_s cn56xx;
+} cvmx_npei_msi_w1s_enb2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_msi_w1s_enb3_s {
+		uint64_t set:64;
+	} s;
+	struct cvmx_npei_msi_w1s_enb3_s cn52xx;
+	struct cvmx_npei_msi_w1s_enb3_s cn56xx;
+} cvmx_npei_msi_w1s_enb3_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_msi_wr_map_s {
+		uint64_t reserved_16_63:48;
+		uint64_t ciu_int:8;
+		uint64_t msi_int:8;
+	} s;
+	struct cvmx_npei_msi_wr_map_s cn52xx;
+	struct cvmx_npei_msi_wr_map_s cn52xxp1;
+	struct cvmx_npei_msi_wr_map_s cn56xx;
+	struct cvmx_npei_msi_wr_map_s cn56xxp1;
+} cvmx_npei_msi_wr_map_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pcie_credit_cnt_s {
+		uint64_t reserved_48_63:16;
+		uint64_t p1_ccnt:8;
+		uint64_t p1_ncnt:8;
+		uint64_t p1_pcnt:8;
+		uint64_t p0_ccnt:8;
+		uint64_t p0_ncnt:8;
+		uint64_t p0_pcnt:8;
+	} s;
+	struct cvmx_npei_pcie_credit_cnt_s cn52xx;
+	struct cvmx_npei_pcie_credit_cnt_s cn56xx;
+} cvmx_npei_pcie_credit_cnt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pcie_msi_rcv_s {
+		uint64_t reserved_8_63:56;
+		uint64_t intr:8;
+	} s;
+	struct cvmx_npei_pcie_msi_rcv_s cn52xx;
+	struct cvmx_npei_pcie_msi_rcv_s cn52xxp1;
+	struct cvmx_npei_pcie_msi_rcv_s cn56xx;
+	struct cvmx_npei_pcie_msi_rcv_s cn56xxp1;
+} cvmx_npei_pcie_msi_rcv_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pcie_msi_rcv_b1_s {
+		uint64_t reserved_16_63:48;
+		uint64_t intr:8;
+		uint64_t reserved_0_7:8;
+	} s;
+	struct cvmx_npei_pcie_msi_rcv_b1_s cn52xx;
+	struct cvmx_npei_pcie_msi_rcv_b1_s cn52xxp1;
+	struct cvmx_npei_pcie_msi_rcv_b1_s cn56xx;
+	struct cvmx_npei_pcie_msi_rcv_b1_s cn56xxp1;
+} cvmx_npei_pcie_msi_rcv_b1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pcie_msi_rcv_b2_s {
+		uint64_t reserved_24_63:40;
+		uint64_t intr:8;
+		uint64_t reserved_0_15:16;
+	} s;
+	struct cvmx_npei_pcie_msi_rcv_b2_s cn52xx;
+	struct cvmx_npei_pcie_msi_rcv_b2_s cn52xxp1;
+	struct cvmx_npei_pcie_msi_rcv_b2_s cn56xx;
+	struct cvmx_npei_pcie_msi_rcv_b2_s cn56xxp1;
+} cvmx_npei_pcie_msi_rcv_b2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pcie_msi_rcv_b3_s {
+		uint64_t reserved_32_63:32;
+		uint64_t intr:8;
+		uint64_t reserved_0_23:24;
+	} s;
+	struct cvmx_npei_pcie_msi_rcv_b3_s cn52xx;
+	struct cvmx_npei_pcie_msi_rcv_b3_s cn52xxp1;
+	struct cvmx_npei_pcie_msi_rcv_b3_s cn56xx;
+	struct cvmx_npei_pcie_msi_rcv_b3_s cn56xxp1;
+} cvmx_npei_pcie_msi_rcv_b3_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pktx_cnts_s {
+		uint64_t reserved_54_63:10;
+		uint64_t timer:22;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_npei_pktx_cnts_s cn52xx;
+	struct cvmx_npei_pktx_cnts_s cn56xx;
+	struct cvmx_npei_pktx_cnts_s cn56xxp1;
+} cvmx_npei_pktx_cnts_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pktx_in_bp_s {
+		uint64_t wmark:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_npei_pktx_in_bp_s cn52xx;
+	struct cvmx_npei_pktx_in_bp_s cn56xx;
+	struct cvmx_npei_pktx_in_bp_s cn56xxp1;
+} cvmx_npei_pktx_in_bp_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pktx_instr_baddr_s {
+		uint64_t addr:61;
+		uint64_t reserved_0_2:3;
+	} s;
+	struct cvmx_npei_pktx_instr_baddr_s cn52xx;
+	struct cvmx_npei_pktx_instr_baddr_s cn56xx;
+	struct cvmx_npei_pktx_instr_baddr_s cn56xxp1;
+} cvmx_npei_pktx_instr_baddr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pktx_instr_baoff_dbell_s {
+		uint64_t aoff:32;
+		uint64_t dbell:32;
+	} s;
+	struct cvmx_npei_pktx_instr_baoff_dbell_s cn52xx;
+	struct cvmx_npei_pktx_instr_baoff_dbell_s cn56xx;
+	struct cvmx_npei_pktx_instr_baoff_dbell_s cn56xxp1;
+} cvmx_npei_pktx_instr_baoff_dbell_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pktx_instr_fifo_rsize_s {
+		uint64_t max:9;
+		uint64_t rrp:9;
+		uint64_t wrp:9;
+		uint64_t fcnt:5;
+		uint64_t rsize:32;
+	} s;
+	struct cvmx_npei_pktx_instr_fifo_rsize_s cn52xx;
+	struct cvmx_npei_pktx_instr_fifo_rsize_s cn56xx;
+	struct cvmx_npei_pktx_instr_fifo_rsize_s cn56xxp1;
+} cvmx_npei_pktx_instr_fifo_rsize_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pktx_instr_header_s {
+		uint64_t reserved_44_63:20;
+		uint64_t pbp:1;
+		uint64_t rsv_f:5;
+		uint64_t rparmode:2;
+		uint64_t rsv_e:1;
+		uint64_t rskp_len:7;
+		uint64_t rsv_d:6;
+		uint64_t use_ihdr:1;
+		uint64_t rsv_c:5;
+		uint64_t par_mode:2;
+		uint64_t rsv_b:1;
+		uint64_t skp_len:7;
+		uint64_t rsv_a:6;
+	} s;
+	struct cvmx_npei_pktx_instr_header_s cn52xx;
+	struct cvmx_npei_pktx_instr_header_s cn56xx;
+	struct cvmx_npei_pktx_instr_header_s cn56xxp1;
+} cvmx_npei_pktx_instr_header_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pktx_slist_baddr_s {
+		uint64_t addr:60;
+		uint64_t reserved_0_3:4;
+	} s;
+	struct cvmx_npei_pktx_slist_baddr_s cn52xx;
+	struct cvmx_npei_pktx_slist_baddr_s cn56xx;
+	struct cvmx_npei_pktx_slist_baddr_s cn56xxp1;
+} cvmx_npei_pktx_slist_baddr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pktx_slist_baoff_dbell_s {
+		uint64_t aoff:32;
+		uint64_t dbell:32;
+	} s;
+	struct cvmx_npei_pktx_slist_baoff_dbell_s cn52xx;
+	struct cvmx_npei_pktx_slist_baoff_dbell_s cn56xx;
+	struct cvmx_npei_pktx_slist_baoff_dbell_s cn56xxp1;
+} cvmx_npei_pktx_slist_baoff_dbell_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pktx_slist_fifo_rsize_s {
+		uint64_t reserved_32_63:32;
+		uint64_t rsize:32;
+	} s;
+	struct cvmx_npei_pktx_slist_fifo_rsize_s cn52xx;
+	struct cvmx_npei_pktx_slist_fifo_rsize_s cn56xx;
+	struct cvmx_npei_pktx_slist_fifo_rsize_s cn56xxp1;
+} cvmx_npei_pktx_slist_fifo_rsize_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pkt_cnt_int_s {
+		uint64_t reserved_32_63:32;
+		uint64_t port:32;
+	} s;
+	struct cvmx_npei_pkt_cnt_int_s cn52xx;
+	struct cvmx_npei_pkt_cnt_int_s cn56xx;
+	struct cvmx_npei_pkt_cnt_int_s cn56xxp1;
+} cvmx_npei_pkt_cnt_int_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pkt_cnt_int_enb_s {
+		uint64_t reserved_32_63:32;
+		uint64_t port:32;
+	} s;
+	struct cvmx_npei_pkt_cnt_int_enb_s cn52xx;
+	struct cvmx_npei_pkt_cnt_int_enb_s cn56xx;
+	struct cvmx_npei_pkt_cnt_int_enb_s cn56xxp1;
+} cvmx_npei_pkt_cnt_int_enb_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pkt_data_out_es_s {
+		uint64_t es:64;
+	} s;
+	struct cvmx_npei_pkt_data_out_es_s cn52xx;
+	struct cvmx_npei_pkt_data_out_es_s cn56xx;
+	struct cvmx_npei_pkt_data_out_es_s cn56xxp1;
+} cvmx_npei_pkt_data_out_es_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pkt_data_out_ns_s {
+		uint64_t reserved_32_63:32;
+		uint64_t nsr:32;
+	} s;
+	struct cvmx_npei_pkt_data_out_ns_s cn52xx;
+	struct cvmx_npei_pkt_data_out_ns_s cn56xx;
+	struct cvmx_npei_pkt_data_out_ns_s cn56xxp1;
+} cvmx_npei_pkt_data_out_ns_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pkt_data_out_ror_s {
+		uint64_t reserved_32_63:32;
+		uint64_t ror:32;
+	} s;
+	struct cvmx_npei_pkt_data_out_ror_s cn52xx;
+	struct cvmx_npei_pkt_data_out_ror_s cn56xx;
+	struct cvmx_npei_pkt_data_out_ror_s cn56xxp1;
+} cvmx_npei_pkt_data_out_ror_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pkt_dpaddr_s {
+		uint64_t reserved_32_63:32;
+		uint64_t dptr:32;
+	} s;
+	struct cvmx_npei_pkt_dpaddr_s cn52xx;
+	struct cvmx_npei_pkt_dpaddr_s cn56xx;
+	struct cvmx_npei_pkt_dpaddr_s cn56xxp1;
+} cvmx_npei_pkt_dpaddr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pkt_in_bp_s {
+		uint64_t reserved_32_63:32;
+		uint64_t bp:32;
+	} s;
+	struct cvmx_npei_pkt_in_bp_s cn56xx;
+} cvmx_npei_pkt_in_bp_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pkt_in_donex_cnts_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_npei_pkt_in_donex_cnts_s cn52xx;
+	struct cvmx_npei_pkt_in_donex_cnts_s cn56xx;
+	struct cvmx_npei_pkt_in_donex_cnts_s cn56xxp1;
+} cvmx_npei_pkt_in_donex_cnts_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pkt_in_instr_counts_s {
+		uint64_t wr_cnt:32;
+		uint64_t rd_cnt:32;
+	} s;
+	struct cvmx_npei_pkt_in_instr_counts_s cn52xx;
+	struct cvmx_npei_pkt_in_instr_counts_s cn56xx;
+} cvmx_npei_pkt_in_instr_counts_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pkt_in_pcie_port_s {
+		uint64_t pp:64;
+	} s;
+	struct cvmx_npei_pkt_in_pcie_port_s cn52xx;
+	struct cvmx_npei_pkt_in_pcie_port_s cn56xx;
+} cvmx_npei_pkt_in_pcie_port_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pkt_input_control_s {
+		uint64_t reserved_23_63:41;
+		uint64_t pkt_rr:1;
+		uint64_t pbp_dhi:13;
+		uint64_t d_nsr:1;
+		uint64_t d_esr:2;
+		uint64_t d_ror:1;
+		uint64_t use_csr:1;
+		uint64_t nsr:1;
+		uint64_t esr:2;
+		uint64_t ror:1;
+	} s;
+	struct cvmx_npei_pkt_input_control_s cn52xx;
+	struct cvmx_npei_pkt_input_control_s cn56xx;
+	struct cvmx_npei_pkt_input_control_s cn56xxp1;
+} cvmx_npei_pkt_input_control_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pkt_instr_enb_s {
+		uint64_t reserved_32_63:32;
+		uint64_t enb:32;
+	} s;
+	struct cvmx_npei_pkt_instr_enb_s cn52xx;
+	struct cvmx_npei_pkt_instr_enb_s cn56xx;
+	struct cvmx_npei_pkt_instr_enb_s cn56xxp1;
+} cvmx_npei_pkt_instr_enb_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pkt_instr_rd_size_s {
+		uint64_t rdsize:64;
+	} s;
+	struct cvmx_npei_pkt_instr_rd_size_s cn52xx;
+	struct cvmx_npei_pkt_instr_rd_size_s cn56xx;
+} cvmx_npei_pkt_instr_rd_size_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pkt_instr_size_s {
+		uint64_t reserved_32_63:32;
+		uint64_t is_64b:32;
+	} s;
+	struct cvmx_npei_pkt_instr_size_s cn52xx;
+	struct cvmx_npei_pkt_instr_size_s cn56xx;
+	struct cvmx_npei_pkt_instr_size_s cn56xxp1;
+} cvmx_npei_pkt_instr_size_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pkt_int_levels_s {
+		uint64_t reserved_54_63:10;
+		uint64_t time:22;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_npei_pkt_int_levels_s cn52xx;
+	struct cvmx_npei_pkt_int_levels_s cn56xx;
+	struct cvmx_npei_pkt_int_levels_s cn56xxp1;
+} cvmx_npei_pkt_int_levels_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pkt_iptr_s {
+		uint64_t reserved_32_63:32;
+		uint64_t iptr:32;
+	} s;
+	struct cvmx_npei_pkt_iptr_s cn52xx;
+	struct cvmx_npei_pkt_iptr_s cn56xx;
+	struct cvmx_npei_pkt_iptr_s cn56xxp1;
+} cvmx_npei_pkt_iptr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pkt_out_bmode_s {
+		uint64_t reserved_32_63:32;
+		uint64_t bmode:32;
+	} s;
+	struct cvmx_npei_pkt_out_bmode_s cn52xx;
+	struct cvmx_npei_pkt_out_bmode_s cn56xx;
+	struct cvmx_npei_pkt_out_bmode_s cn56xxp1;
+} cvmx_npei_pkt_out_bmode_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pkt_out_enb_s {
+		uint64_t reserved_32_63:32;
+		uint64_t enb:32;
+	} s;
+	struct cvmx_npei_pkt_out_enb_s cn52xx;
+	struct cvmx_npei_pkt_out_enb_s cn56xx;
+	struct cvmx_npei_pkt_out_enb_s cn56xxp1;
+} cvmx_npei_pkt_out_enb_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pkt_output_wmark_s {
+		uint64_t reserved_32_63:32;
+		uint64_t wmark:32;
+	} s;
+	struct cvmx_npei_pkt_output_wmark_s cn52xx;
+	struct cvmx_npei_pkt_output_wmark_s cn56xx;
+} cvmx_npei_pkt_output_wmark_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pkt_pcie_port_s {
+		uint64_t pp:64;
+	} s;
+	struct cvmx_npei_pkt_pcie_port_s cn52xx;
+	struct cvmx_npei_pkt_pcie_port_s cn56xx;
+	struct cvmx_npei_pkt_pcie_port_s cn56xxp1;
+} cvmx_npei_pkt_pcie_port_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pkt_port_in_rst_s {
+		uint64_t in_rst:32;
+		uint64_t out_rst:32;
+	} s;
+	struct cvmx_npei_pkt_port_in_rst_s cn52xx;
+	struct cvmx_npei_pkt_port_in_rst_s cn56xx;
+} cvmx_npei_pkt_port_in_rst_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pkt_slist_es_s {
+		uint64_t es:64;
+	} s;
+	struct cvmx_npei_pkt_slist_es_s cn52xx;
+	struct cvmx_npei_pkt_slist_es_s cn56xx;
+	struct cvmx_npei_pkt_slist_es_s cn56xxp1;
+} cvmx_npei_pkt_slist_es_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pkt_slist_id_size_s {
+		uint64_t reserved_23_63:41;
+		uint64_t isize:7;
+		uint64_t bsize:16;
+	} s;
+	struct cvmx_npei_pkt_slist_id_size_s cn52xx;
+	struct cvmx_npei_pkt_slist_id_size_s cn56xx;
+	struct cvmx_npei_pkt_slist_id_size_s cn56xxp1;
+} cvmx_npei_pkt_slist_id_size_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pkt_slist_ns_s {
+		uint64_t reserved_32_63:32;
+		uint64_t nsr:32;
+	} s;
+	struct cvmx_npei_pkt_slist_ns_s cn52xx;
+	struct cvmx_npei_pkt_slist_ns_s cn56xx;
+	struct cvmx_npei_pkt_slist_ns_s cn56xxp1;
+} cvmx_npei_pkt_slist_ns_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pkt_slist_ror_s {
+		uint64_t reserved_32_63:32;
+		uint64_t ror:32;
+	} s;
+	struct cvmx_npei_pkt_slist_ror_s cn52xx;
+	struct cvmx_npei_pkt_slist_ror_s cn56xx;
+	struct cvmx_npei_pkt_slist_ror_s cn56xxp1;
+} cvmx_npei_pkt_slist_ror_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pkt_time_int_s {
+		uint64_t reserved_32_63:32;
+		uint64_t port:32;
+	} s;
+	struct cvmx_npei_pkt_time_int_s cn52xx;
+	struct cvmx_npei_pkt_time_int_s cn56xx;
+	struct cvmx_npei_pkt_time_int_s cn56xxp1;
+} cvmx_npei_pkt_time_int_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_pkt_time_int_enb_s {
+		uint64_t reserved_32_63:32;
+		uint64_t port:32;
+	} s;
+	struct cvmx_npei_pkt_time_int_enb_s cn52xx;
+	struct cvmx_npei_pkt_time_int_enb_s cn56xx;
+	struct cvmx_npei_pkt_time_int_enb_s cn56xxp1;
+} cvmx_npei_pkt_time_int_enb_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_rsl_int_blocks_s {
+		uint64_t reserved_31_63:33;
+		uint64_t iob:1;
+		uint64_t lmc1:1;
+		uint64_t agl:1;
+		uint64_t reserved_24_27:4;
+		uint64_t asxpcs1:1;
+		uint64_t asxpcs0:1;
+		uint64_t reserved_21_21:1;
+		uint64_t pip:1;
+		uint64_t reserved_18_19:2;
+		uint64_t lmc0:1;
+		uint64_t l2c:1;
+		uint64_t usb1:1;
+		uint64_t rad:1;
+		uint64_t usb:1;
+		uint64_t pow:1;
+		uint64_t tim:1;
+		uint64_t pko:1;
+		uint64_t ipd:1;
+		uint64_t reserved_8_8:1;
+		uint64_t zip:1;
+		uint64_t reserved_6_6:1;
+		uint64_t fpa:1;
+		uint64_t key:1;
+		uint64_t npei:1;
+		uint64_t gmx1:1;
+		uint64_t gmx0:1;
+		uint64_t mio:1;
+	} s;
+	struct cvmx_npei_rsl_int_blocks_s cn52xx;
+	struct cvmx_npei_rsl_int_blocks_s cn52xxp1;
+	struct cvmx_npei_rsl_int_blocks_cn56xx {
+		uint64_t reserved_31_63:33;
+		uint64_t iob:1;
+		uint64_t lmc1:1;
+		uint64_t agl:1;
+		uint64_t reserved_24_27:4;
+		uint64_t asxpcs1:1;
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
+		uint64_t reserved_6_6:1;
+		uint64_t fpa:1;
+		uint64_t key:1;
+		uint64_t npei:1;
+		uint64_t gmx1:1;
+		uint64_t gmx0:1;
+		uint64_t mio:1;
+	} cn56xx;
+	struct cvmx_npei_rsl_int_blocks_cn56xx cn56xxp1;
+} cvmx_npei_rsl_int_blocks_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_scratch_1_s {
+		uint64_t data:64;
+	} s;
+	struct cvmx_npei_scratch_1_s cn52xx;
+	struct cvmx_npei_scratch_1_s cn52xxp1;
+	struct cvmx_npei_scratch_1_s cn56xx;
+	struct cvmx_npei_scratch_1_s cn56xxp1;
+} cvmx_npei_scratch_1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_state1_s {
+		uint64_t cpl1:12;
+		uint64_t cpl0:12;
+		uint64_t arb:1;
+		uint64_t csr:39;
+	} s;
+	struct cvmx_npei_state1_s cn52xx;
+	struct cvmx_npei_state1_s cn52xxp1;
+	struct cvmx_npei_state1_s cn56xx;
+	struct cvmx_npei_state1_s cn56xxp1;
+} cvmx_npei_state1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_state2_s {
+		uint64_t reserved_48_63:16;
+		uint64_t npei:1;
+		uint64_t rac:1;
+		uint64_t csm1:15;
+		uint64_t csm0:15;
+		uint64_t nnp0:8;
+		uint64_t nnd:8;
+	} s;
+	struct cvmx_npei_state2_s cn52xx;
+	struct cvmx_npei_state2_s cn52xxp1;
+	struct cvmx_npei_state2_s cn56xx;
+	struct cvmx_npei_state2_s cn56xxp1;
+} cvmx_npei_state2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_state3_s {
+		uint64_t reserved_56_63:8;
+		uint64_t psm1:15;
+		uint64_t psm0:15;
+		uint64_t nsm1:13;
+		uint64_t nsm0:13;
+	} s;
+	struct cvmx_npei_state3_s cn52xx;
+	struct cvmx_npei_state3_s cn52xxp1;
+	struct cvmx_npei_state3_s cn56xx;
+	struct cvmx_npei_state3_s cn56xxp1;
+} cvmx_npei_state3_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_win_rd_addr_s {
+		uint64_t reserved_51_63:13;
+		uint64_t ld_cmd:2;
+		uint64_t iobit:1;
+		uint64_t rd_addr:48;
+	} s;
+	struct cvmx_npei_win_rd_addr_s cn52xx;
+	struct cvmx_npei_win_rd_addr_s cn52xxp1;
+	struct cvmx_npei_win_rd_addr_s cn56xx;
+	struct cvmx_npei_win_rd_addr_s cn56xxp1;
+} cvmx_npei_win_rd_addr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_win_rd_data_s {
+		uint64_t rd_data:64;
+	} s;
+	struct cvmx_npei_win_rd_data_s cn52xx;
+	struct cvmx_npei_win_rd_data_s cn52xxp1;
+	struct cvmx_npei_win_rd_data_s cn56xx;
+	struct cvmx_npei_win_rd_data_s cn56xxp1;
+} cvmx_npei_win_rd_data_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_win_wr_addr_s {
+		uint64_t reserved_49_63:15;
+		uint64_t iobit:1;
+		uint64_t wr_addr:46;
+		uint64_t reserved_0_1:2;
+	} s;
+	struct cvmx_npei_win_wr_addr_s cn52xx;
+	struct cvmx_npei_win_wr_addr_s cn52xxp1;
+	struct cvmx_npei_win_wr_addr_s cn56xx;
+	struct cvmx_npei_win_wr_addr_s cn56xxp1;
+} cvmx_npei_win_wr_addr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_win_wr_data_s {
+		uint64_t wr_data:64;
+	} s;
+	struct cvmx_npei_win_wr_data_s cn52xx;
+	struct cvmx_npei_win_wr_data_s cn52xxp1;
+	struct cvmx_npei_win_wr_data_s cn56xx;
+	struct cvmx_npei_win_wr_data_s cn56xxp1;
+} cvmx_npei_win_wr_data_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_win_wr_mask_s {
+		uint64_t reserved_8_63:56;
+		uint64_t wr_mask:8;
+	} s;
+	struct cvmx_npei_win_wr_mask_s cn52xx;
+	struct cvmx_npei_win_wr_mask_s cn52xxp1;
+	struct cvmx_npei_win_wr_mask_s cn56xx;
+	struct cvmx_npei_win_wr_mask_s cn56xxp1;
+} cvmx_npei_win_wr_mask_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npei_window_ctl_s {
+		uint64_t reserved_32_63:32;
+		uint64_t time:32;
+	} s;
+	struct cvmx_npei_window_ctl_s cn52xx;
+	struct cvmx_npei_window_ctl_s cn52xxp1;
+	struct cvmx_npei_window_ctl_s cn56xx;
+	struct cvmx_npei_window_ctl_s cn56xxp1;
+} cvmx_npei_window_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_base_addr_inputx_s {
+		uint64_t baddr:61;
+		uint64_t reserved_0_2:3;
+	} s;
+	struct cvmx_npi_base_addr_inputx_s cn30xx;
+	struct cvmx_npi_base_addr_inputx_s cn31xx;
+	struct cvmx_npi_base_addr_inputx_s cn38xx;
+	struct cvmx_npi_base_addr_inputx_s cn38xxp2;
+	struct cvmx_npi_base_addr_inputx_s cn50xx;
+	struct cvmx_npi_base_addr_inputx_s cn58xx;
+	struct cvmx_npi_base_addr_inputx_s cn58xxp1;
+} cvmx_npi_base_addr_inputx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_base_addr_outputx_s {
+		uint64_t baddr:61;
+		uint64_t reserved_0_2:3;
+	} s;
+	struct cvmx_npi_base_addr_outputx_s cn30xx;
+	struct cvmx_npi_base_addr_outputx_s cn31xx;
+	struct cvmx_npi_base_addr_outputx_s cn38xx;
+	struct cvmx_npi_base_addr_outputx_s cn38xxp2;
+	struct cvmx_npi_base_addr_outputx_s cn50xx;
+	struct cvmx_npi_base_addr_outputx_s cn58xx;
+	struct cvmx_npi_base_addr_outputx_s cn58xxp1;
+} cvmx_npi_base_addr_outputx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_bist_status_s {
+		uint64_t reserved_20_63:44;
+		uint64_t csr_bs:1;
+		uint64_t dif_bs:1;
+		uint64_t rdp_bs:1;
+		uint64_t pcnc_bs:1;
+		uint64_t pcn_bs:1;
+		uint64_t rdn_bs:1;
+		uint64_t pcac_bs:1;
+		uint64_t pcad_bs:1;
+		uint64_t rdnl_bs:1;
+		uint64_t pgf_bs:1;
+		uint64_t pig_bs:1;
+		uint64_t pof0_bs:1;
+		uint64_t pof1_bs:1;
+		uint64_t pof2_bs:1;
+		uint64_t pof3_bs:1;
+		uint64_t pos_bs:1;
+		uint64_t nus_bs:1;
+		uint64_t dob_bs:1;
+		uint64_t pdf_bs:1;
+		uint64_t dpi_bs:1;
+	} s;
+	struct cvmx_npi_bist_status_cn30xx {
+		uint64_t reserved_20_63:44;
+		uint64_t csr_bs:1;
+		uint64_t dif_bs:1;
+		uint64_t rdp_bs:1;
+		uint64_t pcnc_bs:1;
+		uint64_t pcn_bs:1;
+		uint64_t rdn_bs:1;
+		uint64_t pcac_bs:1;
+		uint64_t pcad_bs:1;
+		uint64_t rdnl_bs:1;
+		uint64_t pgf_bs:1;
+		uint64_t pig_bs:1;
+		uint64_t pof0_bs:1;
+		uint64_t reserved_5_7:3;
+		uint64_t pos_bs:1;
+		uint64_t nus_bs:1;
+		uint64_t dob_bs:1;
+		uint64_t pdf_bs:1;
+		uint64_t dpi_bs:1;
+	} cn30xx;
+	struct cvmx_npi_bist_status_s cn31xx;
+	struct cvmx_npi_bist_status_s cn38xx;
+	struct cvmx_npi_bist_status_s cn38xxp2;
+	struct cvmx_npi_bist_status_cn50xx {
+		uint64_t reserved_20_63:44;
+		uint64_t csr_bs:1;
+		uint64_t dif_bs:1;
+		uint64_t rdp_bs:1;
+		uint64_t pcnc_bs:1;
+		uint64_t pcn_bs:1;
+		uint64_t rdn_bs:1;
+		uint64_t pcac_bs:1;
+		uint64_t pcad_bs:1;
+		uint64_t rdnl_bs:1;
+		uint64_t pgf_bs:1;
+		uint64_t pig_bs:1;
+		uint64_t pof0_bs:1;
+		uint64_t pof1_bs:1;
+		uint64_t reserved_5_6:2;
+		uint64_t pos_bs:1;
+		uint64_t nus_bs:1;
+		uint64_t dob_bs:1;
+		uint64_t pdf_bs:1;
+		uint64_t dpi_bs:1;
+	} cn50xx;
+	struct cvmx_npi_bist_status_s cn58xx;
+	struct cvmx_npi_bist_status_s cn58xxp1;
+} cvmx_npi_bist_status_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_buff_size_outputx_s {
+		uint64_t reserved_23_63:41;
+		uint64_t isize:7;
+		uint64_t bsize:16;
+	} s;
+	struct cvmx_npi_buff_size_outputx_s cn30xx;
+	struct cvmx_npi_buff_size_outputx_s cn31xx;
+	struct cvmx_npi_buff_size_outputx_s cn38xx;
+	struct cvmx_npi_buff_size_outputx_s cn38xxp2;
+	struct cvmx_npi_buff_size_outputx_s cn50xx;
+	struct cvmx_npi_buff_size_outputx_s cn58xx;
+	struct cvmx_npi_buff_size_outputx_s cn58xxp1;
+} cvmx_npi_buff_size_outputx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_comp_ctl_s {
+		uint64_t reserved_10_63:54;
+		uint64_t pctl:5;
+		uint64_t nctl:5;
+	} s;
+	struct cvmx_npi_comp_ctl_s cn50xx;
+	struct cvmx_npi_comp_ctl_s cn58xx;
+	struct cvmx_npi_comp_ctl_s cn58xxp1;
+} cvmx_npi_comp_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_ctl_status_s {
+		uint64_t reserved_63_63:1;
+		uint64_t chip_rev:8;
+		uint64_t dis_pniw:1;
+		uint64_t out3_enb:1;
+		uint64_t out2_enb:1;
+		uint64_t out1_enb:1;
+		uint64_t out0_enb:1;
+		uint64_t ins3_enb:1;
+		uint64_t ins2_enb:1;
+		uint64_t ins1_enb:1;
+		uint64_t ins0_enb:1;
+		uint64_t ins3_64b:1;
+		uint64_t ins2_64b:1;
+		uint64_t ins1_64b:1;
+		uint64_t ins0_64b:1;
+		uint64_t pci_wdis:1;
+		uint64_t wait_com:1;
+		uint64_t reserved_37_39:3;
+		uint64_t max_word:5;
+		uint64_t reserved_10_31:22;
+		uint64_t timer:10;
+	} s;
+	struct cvmx_npi_ctl_status_cn30xx {
+		uint64_t reserved_63_63:1;
+		uint64_t chip_rev:8;
+		uint64_t dis_pniw:1;
+		uint64_t reserved_51_53:3;
+		uint64_t out0_enb:1;
+		uint64_t reserved_47_49:3;
+		uint64_t ins0_enb:1;
+		uint64_t reserved_43_45:3;
+		uint64_t ins0_64b:1;
+		uint64_t pci_wdis:1;
+		uint64_t wait_com:1;
+		uint64_t reserved_37_39:3;
+		uint64_t max_word:5;
+		uint64_t reserved_10_31:22;
+		uint64_t timer:10;
+	} cn30xx;
+	struct cvmx_npi_ctl_status_cn31xx {
+		uint64_t reserved_63_63:1;
+		uint64_t chip_rev:8;
+		uint64_t dis_pniw:1;
+		uint64_t reserved_52_53:2;
+		uint64_t out1_enb:1;
+		uint64_t out0_enb:1;
+		uint64_t reserved_48_49:2;
+		uint64_t ins1_enb:1;
+		uint64_t ins0_enb:1;
+		uint64_t reserved_44_45:2;
+		uint64_t ins1_64b:1;
+		uint64_t ins0_64b:1;
+		uint64_t pci_wdis:1;
+		uint64_t wait_com:1;
+		uint64_t reserved_37_39:3;
+		uint64_t max_word:5;
+		uint64_t reserved_10_31:22;
+		uint64_t timer:10;
+	} cn31xx;
+	struct cvmx_npi_ctl_status_s cn38xx;
+	struct cvmx_npi_ctl_status_s cn38xxp2;
+	struct cvmx_npi_ctl_status_cn31xx cn50xx;
+	struct cvmx_npi_ctl_status_s cn58xx;
+	struct cvmx_npi_ctl_status_s cn58xxp1;
+} cvmx_npi_ctl_status_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_dbg_select_s {
+		uint64_t reserved_16_63:48;
+		uint64_t dbg_sel:16;
+	} s;
+	struct cvmx_npi_dbg_select_s cn30xx;
+	struct cvmx_npi_dbg_select_s cn31xx;
+	struct cvmx_npi_dbg_select_s cn38xx;
+	struct cvmx_npi_dbg_select_s cn38xxp2;
+	struct cvmx_npi_dbg_select_s cn50xx;
+	struct cvmx_npi_dbg_select_s cn58xx;
+	struct cvmx_npi_dbg_select_s cn58xxp1;
+} cvmx_npi_dbg_select_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_dma_control_s {
+		uint64_t reserved_36_63:28;
+		uint64_t b0_lend:1;
+		uint64_t dwb_denb:1;
+		uint64_t dwb_ichk:9;
+		uint64_t fpa_que:3;
+		uint64_t o_add1:1;
+		uint64_t o_ro:1;
+		uint64_t o_ns:1;
+		uint64_t o_es:2;
+		uint64_t o_mode:1;
+		uint64_t hp_enb:1;
+		uint64_t lp_enb:1;
+		uint64_t csize:14;
+	} s;
+	struct cvmx_npi_dma_control_s cn30xx;
+	struct cvmx_npi_dma_control_s cn31xx;
+	struct cvmx_npi_dma_control_s cn38xx;
+	struct cvmx_npi_dma_control_s cn38xxp2;
+	struct cvmx_npi_dma_control_s cn50xx;
+	struct cvmx_npi_dma_control_s cn58xx;
+	struct cvmx_npi_dma_control_s cn58xxp1;
+} cvmx_npi_dma_control_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_dma_highp_counts_s {
+		uint64_t reserved_39_63:25;
+		uint64_t fcnt:7;
+		uint64_t dbell:32;
+	} s;
+	struct cvmx_npi_dma_highp_counts_s cn30xx;
+	struct cvmx_npi_dma_highp_counts_s cn31xx;
+	struct cvmx_npi_dma_highp_counts_s cn38xx;
+	struct cvmx_npi_dma_highp_counts_s cn38xxp2;
+	struct cvmx_npi_dma_highp_counts_s cn50xx;
+	struct cvmx_npi_dma_highp_counts_s cn58xx;
+	struct cvmx_npi_dma_highp_counts_s cn58xxp1;
+} cvmx_npi_dma_highp_counts_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_dma_highp_naddr_s {
+		uint64_t reserved_40_63:24;
+		uint64_t state:4;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_npi_dma_highp_naddr_s cn30xx;
+	struct cvmx_npi_dma_highp_naddr_s cn31xx;
+	struct cvmx_npi_dma_highp_naddr_s cn38xx;
+	struct cvmx_npi_dma_highp_naddr_s cn38xxp2;
+	struct cvmx_npi_dma_highp_naddr_s cn50xx;
+	struct cvmx_npi_dma_highp_naddr_s cn58xx;
+	struct cvmx_npi_dma_highp_naddr_s cn58xxp1;
+} cvmx_npi_dma_highp_naddr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_dma_lowp_counts_s {
+		uint64_t reserved_39_63:25;
+		uint64_t fcnt:7;
+		uint64_t dbell:32;
+	} s;
+	struct cvmx_npi_dma_lowp_counts_s cn30xx;
+	struct cvmx_npi_dma_lowp_counts_s cn31xx;
+	struct cvmx_npi_dma_lowp_counts_s cn38xx;
+	struct cvmx_npi_dma_lowp_counts_s cn38xxp2;
+	struct cvmx_npi_dma_lowp_counts_s cn50xx;
+	struct cvmx_npi_dma_lowp_counts_s cn58xx;
+	struct cvmx_npi_dma_lowp_counts_s cn58xxp1;
+} cvmx_npi_dma_lowp_counts_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_dma_lowp_naddr_s {
+		uint64_t reserved_40_63:24;
+		uint64_t state:4;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_npi_dma_lowp_naddr_s cn30xx;
+	struct cvmx_npi_dma_lowp_naddr_s cn31xx;
+	struct cvmx_npi_dma_lowp_naddr_s cn38xx;
+	struct cvmx_npi_dma_lowp_naddr_s cn38xxp2;
+	struct cvmx_npi_dma_lowp_naddr_s cn50xx;
+	struct cvmx_npi_dma_lowp_naddr_s cn58xx;
+	struct cvmx_npi_dma_lowp_naddr_s cn58xxp1;
+} cvmx_npi_dma_lowp_naddr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_highp_dbell_s {
+		uint64_t reserved_16_63:48;
+		uint64_t dbell:16;
+	} s;
+	struct cvmx_npi_highp_dbell_s cn30xx;
+	struct cvmx_npi_highp_dbell_s cn31xx;
+	struct cvmx_npi_highp_dbell_s cn38xx;
+	struct cvmx_npi_highp_dbell_s cn38xxp2;
+	struct cvmx_npi_highp_dbell_s cn50xx;
+	struct cvmx_npi_highp_dbell_s cn58xx;
+	struct cvmx_npi_highp_dbell_s cn58xxp1;
+} cvmx_npi_highp_dbell_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_highp_ibuff_saddr_s {
+		uint64_t reserved_36_63:28;
+		uint64_t saddr:36;
+	} s;
+	struct cvmx_npi_highp_ibuff_saddr_s cn30xx;
+	struct cvmx_npi_highp_ibuff_saddr_s cn31xx;
+	struct cvmx_npi_highp_ibuff_saddr_s cn38xx;
+	struct cvmx_npi_highp_ibuff_saddr_s cn38xxp2;
+	struct cvmx_npi_highp_ibuff_saddr_s cn50xx;
+	struct cvmx_npi_highp_ibuff_saddr_s cn58xx;
+	struct cvmx_npi_highp_ibuff_saddr_s cn58xxp1;
+} cvmx_npi_highp_ibuff_saddr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_input_control_s {
+		uint64_t reserved_23_63:41;
+		uint64_t pkt_rr:1;
+		uint64_t pbp_dhi:13;
+		uint64_t d_nsr:1;
+		uint64_t d_esr:2;
+		uint64_t d_ror:1;
+		uint64_t use_csr:1;
+		uint64_t nsr:1;
+		uint64_t esr:2;
+		uint64_t ror:1;
+	} s;
+	struct cvmx_npi_input_control_cn30xx {
+		uint64_t reserved_22_63:42;
+		uint64_t pbp_dhi:13;
+		uint64_t d_nsr:1;
+		uint64_t d_esr:2;
+		uint64_t d_ror:1;
+		uint64_t use_csr:1;
+		uint64_t nsr:1;
+		uint64_t esr:2;
+		uint64_t ror:1;
+	} cn30xx;
+	struct cvmx_npi_input_control_cn30xx cn31xx;
+	struct cvmx_npi_input_control_s cn38xx;
+	struct cvmx_npi_input_control_cn30xx cn38xxp2;
+	struct cvmx_npi_input_control_s cn50xx;
+	struct cvmx_npi_input_control_s cn58xx;
+	struct cvmx_npi_input_control_s cn58xxp1;
+} cvmx_npi_input_control_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_int_enb_s {
+		uint64_t reserved_62_63:2;
+		uint64_t q1_a_f:1;
+		uint64_t q1_s_e:1;
+		uint64_t pdf_p_f:1;
+		uint64_t pdf_p_e:1;
+		uint64_t pcf_p_f:1;
+		uint64_t pcf_p_e:1;
+		uint64_t rdx_s_e:1;
+		uint64_t rwx_s_e:1;
+		uint64_t pnc_a_f:1;
+		uint64_t pnc_s_e:1;
+		uint64_t com_a_f:1;
+		uint64_t com_s_e:1;
+		uint64_t q3_a_f:1;
+		uint64_t q3_s_e:1;
+		uint64_t q2_a_f:1;
+		uint64_t q2_s_e:1;
+		uint64_t pcr_a_f:1;
+		uint64_t pcr_s_e:1;
+		uint64_t fcr_a_f:1;
+		uint64_t fcr_s_e:1;
+		uint64_t iobdma:1;
+		uint64_t p_dperr:1;
+		uint64_t win_rto:1;
+		uint64_t i3_pperr:1;
+		uint64_t i2_pperr:1;
+		uint64_t i1_pperr:1;
+		uint64_t i0_pperr:1;
+		uint64_t p3_ptout:1;
+		uint64_t p2_ptout:1;
+		uint64_t p1_ptout:1;
+		uint64_t p0_ptout:1;
+		uint64_t p3_pperr:1;
+		uint64_t p2_pperr:1;
+		uint64_t p1_pperr:1;
+		uint64_t p0_pperr:1;
+		uint64_t g3_rtout:1;
+		uint64_t g2_rtout:1;
+		uint64_t g1_rtout:1;
+		uint64_t g0_rtout:1;
+		uint64_t p3_perr:1;
+		uint64_t p2_perr:1;
+		uint64_t p1_perr:1;
+		uint64_t p0_perr:1;
+		uint64_t p3_rtout:1;
+		uint64_t p2_rtout:1;
+		uint64_t p1_rtout:1;
+		uint64_t p0_rtout:1;
+		uint64_t i3_overf:1;
+		uint64_t i2_overf:1;
+		uint64_t i1_overf:1;
+		uint64_t i0_overf:1;
+		uint64_t i3_rtout:1;
+		uint64_t i2_rtout:1;
+		uint64_t i1_rtout:1;
+		uint64_t i0_rtout:1;
+		uint64_t po3_2sml:1;
+		uint64_t po2_2sml:1;
+		uint64_t po1_2sml:1;
+		uint64_t po0_2sml:1;
+		uint64_t pci_rsl:1;
+		uint64_t rml_wto:1;
+		uint64_t rml_rto:1;
+	} s;
+	struct cvmx_npi_int_enb_cn30xx {
+		uint64_t reserved_62_63:2;
+		uint64_t q1_a_f:1;
+		uint64_t q1_s_e:1;
+		uint64_t pdf_p_f:1;
+		uint64_t pdf_p_e:1;
+		uint64_t pcf_p_f:1;
+		uint64_t pcf_p_e:1;
+		uint64_t rdx_s_e:1;
+		uint64_t rwx_s_e:1;
+		uint64_t pnc_a_f:1;
+		uint64_t pnc_s_e:1;
+		uint64_t com_a_f:1;
+		uint64_t com_s_e:1;
+		uint64_t q3_a_f:1;
+		uint64_t q3_s_e:1;
+		uint64_t q2_a_f:1;
+		uint64_t q2_s_e:1;
+		uint64_t pcr_a_f:1;
+		uint64_t pcr_s_e:1;
+		uint64_t fcr_a_f:1;
+		uint64_t fcr_s_e:1;
+		uint64_t iobdma:1;
+		uint64_t p_dperr:1;
+		uint64_t win_rto:1;
+		uint64_t reserved_36_38:3;
+		uint64_t i0_pperr:1;
+		uint64_t reserved_32_34:3;
+		uint64_t p0_ptout:1;
+		uint64_t reserved_28_30:3;
+		uint64_t p0_pperr:1;
+		uint64_t reserved_24_26:3;
+		uint64_t g0_rtout:1;
+		uint64_t reserved_20_22:3;
+		uint64_t p0_perr:1;
+		uint64_t reserved_16_18:3;
+		uint64_t p0_rtout:1;
+		uint64_t reserved_12_14:3;
+		uint64_t i0_overf:1;
+		uint64_t reserved_8_10:3;
+		uint64_t i0_rtout:1;
+		uint64_t reserved_4_6:3;
+		uint64_t po0_2sml:1;
+		uint64_t pci_rsl:1;
+		uint64_t rml_wto:1;
+		uint64_t rml_rto:1;
+	} cn30xx;
+	struct cvmx_npi_int_enb_cn31xx {
+		uint64_t reserved_62_63:2;
+		uint64_t q1_a_f:1;
+		uint64_t q1_s_e:1;
+		uint64_t pdf_p_f:1;
+		uint64_t pdf_p_e:1;
+		uint64_t pcf_p_f:1;
+		uint64_t pcf_p_e:1;
+		uint64_t rdx_s_e:1;
+		uint64_t rwx_s_e:1;
+		uint64_t pnc_a_f:1;
+		uint64_t pnc_s_e:1;
+		uint64_t com_a_f:1;
+		uint64_t com_s_e:1;
+		uint64_t q3_a_f:1;
+		uint64_t q3_s_e:1;
+		uint64_t q2_a_f:1;
+		uint64_t q2_s_e:1;
+		uint64_t pcr_a_f:1;
+		uint64_t pcr_s_e:1;
+		uint64_t fcr_a_f:1;
+		uint64_t fcr_s_e:1;
+		uint64_t iobdma:1;
+		uint64_t p_dperr:1;
+		uint64_t win_rto:1;
+		uint64_t reserved_37_38:2;
+		uint64_t i1_pperr:1;
+		uint64_t i0_pperr:1;
+		uint64_t reserved_33_34:2;
+		uint64_t p1_ptout:1;
+		uint64_t p0_ptout:1;
+		uint64_t reserved_29_30:2;
+		uint64_t p1_pperr:1;
+		uint64_t p0_pperr:1;
+		uint64_t reserved_25_26:2;
+		uint64_t g1_rtout:1;
+		uint64_t g0_rtout:1;
+		uint64_t reserved_21_22:2;
+		uint64_t p1_perr:1;
+		uint64_t p0_perr:1;
+		uint64_t reserved_17_18:2;
+		uint64_t p1_rtout:1;
+		uint64_t p0_rtout:1;
+		uint64_t reserved_13_14:2;
+		uint64_t i1_overf:1;
+		uint64_t i0_overf:1;
+		uint64_t reserved_9_10:2;
+		uint64_t i1_rtout:1;
+		uint64_t i0_rtout:1;
+		uint64_t reserved_5_6:2;
+		uint64_t po1_2sml:1;
+		uint64_t po0_2sml:1;
+		uint64_t pci_rsl:1;
+		uint64_t rml_wto:1;
+		uint64_t rml_rto:1;
+	} cn31xx;
+	struct cvmx_npi_int_enb_s cn38xx;
+	struct cvmx_npi_int_enb_cn38xxp2 {
+		uint64_t reserved_42_63:22;
+		uint64_t iobdma:1;
+		uint64_t p_dperr:1;
+		uint64_t win_rto:1;
+		uint64_t i3_pperr:1;
+		uint64_t i2_pperr:1;
+		uint64_t i1_pperr:1;
+		uint64_t i0_pperr:1;
+		uint64_t p3_ptout:1;
+		uint64_t p2_ptout:1;
+		uint64_t p1_ptout:1;
+		uint64_t p0_ptout:1;
+		uint64_t p3_pperr:1;
+		uint64_t p2_pperr:1;
+		uint64_t p1_pperr:1;
+		uint64_t p0_pperr:1;
+		uint64_t g3_rtout:1;
+		uint64_t g2_rtout:1;
+		uint64_t g1_rtout:1;
+		uint64_t g0_rtout:1;
+		uint64_t p3_perr:1;
+		uint64_t p2_perr:1;
+		uint64_t p1_perr:1;
+		uint64_t p0_perr:1;
+		uint64_t p3_rtout:1;
+		uint64_t p2_rtout:1;
+		uint64_t p1_rtout:1;
+		uint64_t p0_rtout:1;
+		uint64_t i3_overf:1;
+		uint64_t i2_overf:1;
+		uint64_t i1_overf:1;
+		uint64_t i0_overf:1;
+		uint64_t i3_rtout:1;
+		uint64_t i2_rtout:1;
+		uint64_t i1_rtout:1;
+		uint64_t i0_rtout:1;
+		uint64_t po3_2sml:1;
+		uint64_t po2_2sml:1;
+		uint64_t po1_2sml:1;
+		uint64_t po0_2sml:1;
+		uint64_t pci_rsl:1;
+		uint64_t rml_wto:1;
+		uint64_t rml_rto:1;
+	} cn38xxp2;
+	struct cvmx_npi_int_enb_cn31xx cn50xx;
+	struct cvmx_npi_int_enb_s cn58xx;
+	struct cvmx_npi_int_enb_s cn58xxp1;
+} cvmx_npi_int_enb_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_int_sum_s {
+		uint64_t reserved_62_63:2;
+		uint64_t q1_a_f:1;
+		uint64_t q1_s_e:1;
+		uint64_t pdf_p_f:1;
+		uint64_t pdf_p_e:1;
+		uint64_t pcf_p_f:1;
+		uint64_t pcf_p_e:1;
+		uint64_t rdx_s_e:1;
+		uint64_t rwx_s_e:1;
+		uint64_t pnc_a_f:1;
+		uint64_t pnc_s_e:1;
+		uint64_t com_a_f:1;
+		uint64_t com_s_e:1;
+		uint64_t q3_a_f:1;
+		uint64_t q3_s_e:1;
+		uint64_t q2_a_f:1;
+		uint64_t q2_s_e:1;
+		uint64_t pcr_a_f:1;
+		uint64_t pcr_s_e:1;
+		uint64_t fcr_a_f:1;
+		uint64_t fcr_s_e:1;
+		uint64_t iobdma:1;
+		uint64_t p_dperr:1;
+		uint64_t win_rto:1;
+		uint64_t i3_pperr:1;
+		uint64_t i2_pperr:1;
+		uint64_t i1_pperr:1;
+		uint64_t i0_pperr:1;
+		uint64_t p3_ptout:1;
+		uint64_t p2_ptout:1;
+		uint64_t p1_ptout:1;
+		uint64_t p0_ptout:1;
+		uint64_t p3_pperr:1;
+		uint64_t p2_pperr:1;
+		uint64_t p1_pperr:1;
+		uint64_t p0_pperr:1;
+		uint64_t g3_rtout:1;
+		uint64_t g2_rtout:1;
+		uint64_t g1_rtout:1;
+		uint64_t g0_rtout:1;
+		uint64_t p3_perr:1;
+		uint64_t p2_perr:1;
+		uint64_t p1_perr:1;
+		uint64_t p0_perr:1;
+		uint64_t p3_rtout:1;
+		uint64_t p2_rtout:1;
+		uint64_t p1_rtout:1;
+		uint64_t p0_rtout:1;
+		uint64_t i3_overf:1;
+		uint64_t i2_overf:1;
+		uint64_t i1_overf:1;
+		uint64_t i0_overf:1;
+		uint64_t i3_rtout:1;
+		uint64_t i2_rtout:1;
+		uint64_t i1_rtout:1;
+		uint64_t i0_rtout:1;
+		uint64_t po3_2sml:1;
+		uint64_t po2_2sml:1;
+		uint64_t po1_2sml:1;
+		uint64_t po0_2sml:1;
+		uint64_t pci_rsl:1;
+		uint64_t rml_wto:1;
+		uint64_t rml_rto:1;
+	} s;
+	struct cvmx_npi_int_sum_cn30xx {
+		uint64_t reserved_62_63:2;
+		uint64_t q1_a_f:1;
+		uint64_t q1_s_e:1;
+		uint64_t pdf_p_f:1;
+		uint64_t pdf_p_e:1;
+		uint64_t pcf_p_f:1;
+		uint64_t pcf_p_e:1;
+		uint64_t rdx_s_e:1;
+		uint64_t rwx_s_e:1;
+		uint64_t pnc_a_f:1;
+		uint64_t pnc_s_e:1;
+		uint64_t com_a_f:1;
+		uint64_t com_s_e:1;
+		uint64_t q3_a_f:1;
+		uint64_t q3_s_e:1;
+		uint64_t q2_a_f:1;
+		uint64_t q2_s_e:1;
+		uint64_t pcr_a_f:1;
+		uint64_t pcr_s_e:1;
+		uint64_t fcr_a_f:1;
+		uint64_t fcr_s_e:1;
+		uint64_t iobdma:1;
+		uint64_t p_dperr:1;
+		uint64_t win_rto:1;
+		uint64_t reserved_36_38:3;
+		uint64_t i0_pperr:1;
+		uint64_t reserved_32_34:3;
+		uint64_t p0_ptout:1;
+		uint64_t reserved_28_30:3;
+		uint64_t p0_pperr:1;
+		uint64_t reserved_24_26:3;
+		uint64_t g0_rtout:1;
+		uint64_t reserved_20_22:3;
+		uint64_t p0_perr:1;
+		uint64_t reserved_16_18:3;
+		uint64_t p0_rtout:1;
+		uint64_t reserved_12_14:3;
+		uint64_t i0_overf:1;
+		uint64_t reserved_8_10:3;
+		uint64_t i0_rtout:1;
+		uint64_t reserved_4_6:3;
+		uint64_t po0_2sml:1;
+		uint64_t pci_rsl:1;
+		uint64_t rml_wto:1;
+		uint64_t rml_rto:1;
+	} cn30xx;
+	struct cvmx_npi_int_sum_cn31xx {
+		uint64_t reserved_62_63:2;
+		uint64_t q1_a_f:1;
+		uint64_t q1_s_e:1;
+		uint64_t pdf_p_f:1;
+		uint64_t pdf_p_e:1;
+		uint64_t pcf_p_f:1;
+		uint64_t pcf_p_e:1;
+		uint64_t rdx_s_e:1;
+		uint64_t rwx_s_e:1;
+		uint64_t pnc_a_f:1;
+		uint64_t pnc_s_e:1;
+		uint64_t com_a_f:1;
+		uint64_t com_s_e:1;
+		uint64_t q3_a_f:1;
+		uint64_t q3_s_e:1;
+		uint64_t q2_a_f:1;
+		uint64_t q2_s_e:1;
+		uint64_t pcr_a_f:1;
+		uint64_t pcr_s_e:1;
+		uint64_t fcr_a_f:1;
+		uint64_t fcr_s_e:1;
+		uint64_t iobdma:1;
+		uint64_t p_dperr:1;
+		uint64_t win_rto:1;
+		uint64_t reserved_37_38:2;
+		uint64_t i1_pperr:1;
+		uint64_t i0_pperr:1;
+		uint64_t reserved_33_34:2;
+		uint64_t p1_ptout:1;
+		uint64_t p0_ptout:1;
+		uint64_t reserved_29_30:2;
+		uint64_t p1_pperr:1;
+		uint64_t p0_pperr:1;
+		uint64_t reserved_25_26:2;
+		uint64_t g1_rtout:1;
+		uint64_t g0_rtout:1;
+		uint64_t reserved_21_22:2;
+		uint64_t p1_perr:1;
+		uint64_t p0_perr:1;
+		uint64_t reserved_17_18:2;
+		uint64_t p1_rtout:1;
+		uint64_t p0_rtout:1;
+		uint64_t reserved_13_14:2;
+		uint64_t i1_overf:1;
+		uint64_t i0_overf:1;
+		uint64_t reserved_9_10:2;
+		uint64_t i1_rtout:1;
+		uint64_t i0_rtout:1;
+		uint64_t reserved_5_6:2;
+		uint64_t po1_2sml:1;
+		uint64_t po0_2sml:1;
+		uint64_t pci_rsl:1;
+		uint64_t rml_wto:1;
+		uint64_t rml_rto:1;
+	} cn31xx;
+	struct cvmx_npi_int_sum_s cn38xx;
+	struct cvmx_npi_int_sum_cn38xxp2 {
+		uint64_t reserved_42_63:22;
+		uint64_t iobdma:1;
+		uint64_t p_dperr:1;
+		uint64_t win_rto:1;
+		uint64_t i3_pperr:1;
+		uint64_t i2_pperr:1;
+		uint64_t i1_pperr:1;
+		uint64_t i0_pperr:1;
+		uint64_t p3_ptout:1;
+		uint64_t p2_ptout:1;
+		uint64_t p1_ptout:1;
+		uint64_t p0_ptout:1;
+		uint64_t p3_pperr:1;
+		uint64_t p2_pperr:1;
+		uint64_t p1_pperr:1;
+		uint64_t p0_pperr:1;
+		uint64_t g3_rtout:1;
+		uint64_t g2_rtout:1;
+		uint64_t g1_rtout:1;
+		uint64_t g0_rtout:1;
+		uint64_t p3_perr:1;
+		uint64_t p2_perr:1;
+		uint64_t p1_perr:1;
+		uint64_t p0_perr:1;
+		uint64_t p3_rtout:1;
+		uint64_t p2_rtout:1;
+		uint64_t p1_rtout:1;
+		uint64_t p0_rtout:1;
+		uint64_t i3_overf:1;
+		uint64_t i2_overf:1;
+		uint64_t i1_overf:1;
+		uint64_t i0_overf:1;
+		uint64_t i3_rtout:1;
+		uint64_t i2_rtout:1;
+		uint64_t i1_rtout:1;
+		uint64_t i0_rtout:1;
+		uint64_t po3_2sml:1;
+		uint64_t po2_2sml:1;
+		uint64_t po1_2sml:1;
+		uint64_t po0_2sml:1;
+		uint64_t pci_rsl:1;
+		uint64_t rml_wto:1;
+		uint64_t rml_rto:1;
+	} cn38xxp2;
+	struct cvmx_npi_int_sum_cn31xx cn50xx;
+	struct cvmx_npi_int_sum_s cn58xx;
+	struct cvmx_npi_int_sum_s cn58xxp1;
+} cvmx_npi_int_sum_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_lowp_dbell_s {
+		uint64_t reserved_16_63:48;
+		uint64_t dbell:16;
+	} s;
+	struct cvmx_npi_lowp_dbell_s cn30xx;
+	struct cvmx_npi_lowp_dbell_s cn31xx;
+	struct cvmx_npi_lowp_dbell_s cn38xx;
+	struct cvmx_npi_lowp_dbell_s cn38xxp2;
+	struct cvmx_npi_lowp_dbell_s cn50xx;
+	struct cvmx_npi_lowp_dbell_s cn58xx;
+	struct cvmx_npi_lowp_dbell_s cn58xxp1;
+} cvmx_npi_lowp_dbell_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_lowp_ibuff_saddr_s {
+		uint64_t reserved_36_63:28;
+		uint64_t saddr:36;
+	} s;
+	struct cvmx_npi_lowp_ibuff_saddr_s cn30xx;
+	struct cvmx_npi_lowp_ibuff_saddr_s cn31xx;
+	struct cvmx_npi_lowp_ibuff_saddr_s cn38xx;
+	struct cvmx_npi_lowp_ibuff_saddr_s cn38xxp2;
+	struct cvmx_npi_lowp_ibuff_saddr_s cn50xx;
+	struct cvmx_npi_lowp_ibuff_saddr_s cn58xx;
+	struct cvmx_npi_lowp_ibuff_saddr_s cn58xxp1;
+} cvmx_npi_lowp_ibuff_saddr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_mem_access_subidx_s {
+		uint64_t reserved_38_63:26;
+		uint64_t shortl:1;
+		uint64_t nmerge:1;
+		uint64_t esr:2;
+		uint64_t esw:2;
+		uint64_t nsr:1;
+		uint64_t nsw:1;
+		uint64_t ror:1;
+		uint64_t row:1;
+		uint64_t ba:28;
+	} s;
+	struct cvmx_npi_mem_access_subidx_s cn30xx;
+	struct cvmx_npi_mem_access_subidx_cn31xx {
+		uint64_t reserved_36_63:28;
+		uint64_t esr:2;
+		uint64_t esw:2;
+		uint64_t nsr:1;
+		uint64_t nsw:1;
+		uint64_t ror:1;
+		uint64_t row:1;
+		uint64_t ba:28;
+	} cn31xx;
+	struct cvmx_npi_mem_access_subidx_s cn38xx;
+	struct cvmx_npi_mem_access_subidx_cn31xx cn38xxp2;
+	struct cvmx_npi_mem_access_subidx_s cn50xx;
+	struct cvmx_npi_mem_access_subidx_s cn58xx;
+	struct cvmx_npi_mem_access_subidx_s cn58xxp1;
+} cvmx_npi_mem_access_subidx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_msi_rcv_s {
+		uint64_t int_vec:64;
+	} s;
+	struct cvmx_npi_msi_rcv_s cn30xx;
+	struct cvmx_npi_msi_rcv_s cn31xx;
+	struct cvmx_npi_msi_rcv_s cn38xx;
+	struct cvmx_npi_msi_rcv_s cn38xxp2;
+	struct cvmx_npi_msi_rcv_s cn50xx;
+	struct cvmx_npi_msi_rcv_s cn58xx;
+	struct cvmx_npi_msi_rcv_s cn58xxp1;
+} cvmx_npi_msi_rcv_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_num_desc_outputx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t size:32;
+	} s;
+	struct cvmx_npi_num_desc_outputx_s cn30xx;
+	struct cvmx_npi_num_desc_outputx_s cn31xx;
+	struct cvmx_npi_num_desc_outputx_s cn38xx;
+	struct cvmx_npi_num_desc_outputx_s cn38xxp2;
+	struct cvmx_npi_num_desc_outputx_s cn50xx;
+	struct cvmx_npi_num_desc_outputx_s cn58xx;
+	struct cvmx_npi_num_desc_outputx_s cn58xxp1;
+} cvmx_npi_num_desc_outputx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_output_control_s {
+		uint64_t reserved_49_63:15;
+		uint64_t pkt_rr:1;
+		uint64_t p3_bmode:1;
+		uint64_t p2_bmode:1;
+		uint64_t p1_bmode:1;
+		uint64_t p0_bmode:1;
+		uint64_t o3_es:2;
+		uint64_t o3_ns:1;
+		uint64_t o3_ro:1;
+		uint64_t o2_es:2;
+		uint64_t o2_ns:1;
+		uint64_t o2_ro:1;
+		uint64_t o1_es:2;
+		uint64_t o1_ns:1;
+		uint64_t o1_ro:1;
+		uint64_t o0_es:2;
+		uint64_t o0_ns:1;
+		uint64_t o0_ro:1;
+		uint64_t o3_csrm:1;
+		uint64_t o2_csrm:1;
+		uint64_t o1_csrm:1;
+		uint64_t o0_csrm:1;
+		uint64_t reserved_20_23:4;
+		uint64_t iptr_o3:1;
+		uint64_t iptr_o2:1;
+		uint64_t iptr_o1:1;
+		uint64_t iptr_o0:1;
+		uint64_t esr_sl3:2;
+		uint64_t nsr_sl3:1;
+		uint64_t ror_sl3:1;
+		uint64_t esr_sl2:2;
+		uint64_t nsr_sl2:1;
+		uint64_t ror_sl2:1;
+		uint64_t esr_sl1:2;
+		uint64_t nsr_sl1:1;
+		uint64_t ror_sl1:1;
+		uint64_t esr_sl0:2;
+		uint64_t nsr_sl0:1;
+		uint64_t ror_sl0:1;
+	} s;
+	struct cvmx_npi_output_control_cn30xx {
+		uint64_t reserved_45_63:19;
+		uint64_t p0_bmode:1;
+		uint64_t reserved_32_43:12;
+		uint64_t o0_es:2;
+		uint64_t o0_ns:1;
+		uint64_t o0_ro:1;
+		uint64_t reserved_25_27:3;
+		uint64_t o0_csrm:1;
+		uint64_t reserved_17_23:7;
+		uint64_t iptr_o0:1;
+		uint64_t reserved_4_15:12;
+		uint64_t esr_sl0:2;
+		uint64_t nsr_sl0:1;
+		uint64_t ror_sl0:1;
+	} cn30xx;
+	struct cvmx_npi_output_control_cn31xx {
+		uint64_t reserved_46_63:18;
+		uint64_t p1_bmode:1;
+		uint64_t p0_bmode:1;
+		uint64_t reserved_36_43:8;
+		uint64_t o1_es:2;
+		uint64_t o1_ns:1;
+		uint64_t o1_ro:1;
+		uint64_t o0_es:2;
+		uint64_t o0_ns:1;
+		uint64_t o0_ro:1;
+		uint64_t reserved_26_27:2;
+		uint64_t o1_csrm:1;
+		uint64_t o0_csrm:1;
+		uint64_t reserved_18_23:6;
+		uint64_t iptr_o1:1;
+		uint64_t iptr_o0:1;
+		uint64_t reserved_8_15:8;
+		uint64_t esr_sl1:2;
+		uint64_t nsr_sl1:1;
+		uint64_t ror_sl1:1;
+		uint64_t esr_sl0:2;
+		uint64_t nsr_sl0:1;
+		uint64_t ror_sl0:1;
+	} cn31xx;
+	struct cvmx_npi_output_control_s cn38xx;
+	struct cvmx_npi_output_control_cn38xxp2 {
+		uint64_t reserved_48_63:16;
+		uint64_t p3_bmode:1;
+		uint64_t p2_bmode:1;
+		uint64_t p1_bmode:1;
+		uint64_t p0_bmode:1;
+		uint64_t o3_es:2;
+		uint64_t o3_ns:1;
+		uint64_t o3_ro:1;
+		uint64_t o2_es:2;
+		uint64_t o2_ns:1;
+		uint64_t o2_ro:1;
+		uint64_t o1_es:2;
+		uint64_t o1_ns:1;
+		uint64_t o1_ro:1;
+		uint64_t o0_es:2;
+		uint64_t o0_ns:1;
+		uint64_t o0_ro:1;
+		uint64_t o3_csrm:1;
+		uint64_t o2_csrm:1;
+		uint64_t o1_csrm:1;
+		uint64_t o0_csrm:1;
+		uint64_t reserved_20_23:4;
+		uint64_t iptr_o3:1;
+		uint64_t iptr_o2:1;
+		uint64_t iptr_o1:1;
+		uint64_t iptr_o0:1;
+		uint64_t esr_sl3:2;
+		uint64_t nsr_sl3:1;
+		uint64_t ror_sl3:1;
+		uint64_t esr_sl2:2;
+		uint64_t nsr_sl2:1;
+		uint64_t ror_sl2:1;
+		uint64_t esr_sl1:2;
+		uint64_t nsr_sl1:1;
+		uint64_t ror_sl1:1;
+		uint64_t esr_sl0:2;
+		uint64_t nsr_sl0:1;
+		uint64_t ror_sl0:1;
+	} cn38xxp2;
+	struct cvmx_npi_output_control_cn50xx {
+		uint64_t reserved_49_63:15;
+		uint64_t pkt_rr:1;
+		uint64_t reserved_46_47:2;
+		uint64_t p1_bmode:1;
+		uint64_t p0_bmode:1;
+		uint64_t reserved_36_43:8;
+		uint64_t o1_es:2;
+		uint64_t o1_ns:1;
+		uint64_t o1_ro:1;
+		uint64_t o0_es:2;
+		uint64_t o0_ns:1;
+		uint64_t o0_ro:1;
+		uint64_t reserved_26_27:2;
+		uint64_t o1_csrm:1;
+		uint64_t o0_csrm:1;
+		uint64_t reserved_18_23:6;
+		uint64_t iptr_o1:1;
+		uint64_t iptr_o0:1;
+		uint64_t reserved_8_15:8;
+		uint64_t esr_sl1:2;
+		uint64_t nsr_sl1:1;
+		uint64_t ror_sl1:1;
+		uint64_t esr_sl0:2;
+		uint64_t nsr_sl0:1;
+		uint64_t ror_sl0:1;
+	} cn50xx;
+	struct cvmx_npi_output_control_s cn58xx;
+	struct cvmx_npi_output_control_s cn58xxp1;
+} cvmx_npi_output_control_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_px_dbpair_addr_s {
+		uint64_t reserved_63_63:1;
+		uint64_t state:2;
+		uint64_t naddr:61;
+	} s;
+	struct cvmx_npi_px_dbpair_addr_s cn30xx;
+	struct cvmx_npi_px_dbpair_addr_s cn31xx;
+	struct cvmx_npi_px_dbpair_addr_s cn38xx;
+	struct cvmx_npi_px_dbpair_addr_s cn38xxp2;
+	struct cvmx_npi_px_dbpair_addr_s cn50xx;
+	struct cvmx_npi_px_dbpair_addr_s cn58xx;
+	struct cvmx_npi_px_dbpair_addr_s cn58xxp1;
+} cvmx_npi_px_dbpair_addr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_px_instr_addr_s {
+		uint64_t state:3;
+		uint64_t naddr:61;
+	} s;
+	struct cvmx_npi_px_instr_addr_s cn30xx;
+	struct cvmx_npi_px_instr_addr_s cn31xx;
+	struct cvmx_npi_px_instr_addr_s cn38xx;
+	struct cvmx_npi_px_instr_addr_s cn38xxp2;
+	struct cvmx_npi_px_instr_addr_s cn50xx;
+	struct cvmx_npi_px_instr_addr_s cn58xx;
+	struct cvmx_npi_px_instr_addr_s cn58xxp1;
+} cvmx_npi_px_instr_addr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_px_instr_cnts_s {
+		uint64_t reserved_38_63:26;
+		uint64_t fcnt:6;
+		uint64_t avail:32;
+	} s;
+	struct cvmx_npi_px_instr_cnts_s cn30xx;
+	struct cvmx_npi_px_instr_cnts_s cn31xx;
+	struct cvmx_npi_px_instr_cnts_s cn38xx;
+	struct cvmx_npi_px_instr_cnts_s cn38xxp2;
+	struct cvmx_npi_px_instr_cnts_s cn50xx;
+	struct cvmx_npi_px_instr_cnts_s cn58xx;
+	struct cvmx_npi_px_instr_cnts_s cn58xxp1;
+} cvmx_npi_px_instr_cnts_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_px_pair_cnts_s {
+		uint64_t reserved_37_63:27;
+		uint64_t fcnt:5;
+		uint64_t avail:32;
+	} s;
+	struct cvmx_npi_px_pair_cnts_s cn30xx;
+	struct cvmx_npi_px_pair_cnts_s cn31xx;
+	struct cvmx_npi_px_pair_cnts_s cn38xx;
+	struct cvmx_npi_px_pair_cnts_s cn38xxp2;
+	struct cvmx_npi_px_pair_cnts_s cn50xx;
+	struct cvmx_npi_px_pair_cnts_s cn58xx;
+	struct cvmx_npi_px_pair_cnts_s cn58xxp1;
+} cvmx_npi_px_pair_cnts_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_pci_burst_size_s {
+		uint64_t reserved_14_63:50;
+		uint64_t wr_brst:7;
+		uint64_t rd_brst:7;
+	} s;
+	struct cvmx_npi_pci_burst_size_s cn30xx;
+	struct cvmx_npi_pci_burst_size_s cn31xx;
+	struct cvmx_npi_pci_burst_size_s cn38xx;
+	struct cvmx_npi_pci_burst_size_s cn38xxp2;
+	struct cvmx_npi_pci_burst_size_s cn50xx;
+	struct cvmx_npi_pci_burst_size_s cn58xx;
+	struct cvmx_npi_pci_burst_size_s cn58xxp1;
+} cvmx_npi_pci_burst_size_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_pci_int_arb_cfg_s {
+		uint64_t reserved_13_63:51;
+		uint64_t hostmode:1;
+		uint64_t pci_ovr:4;
+		uint64_t reserved_5_7:3;
+		uint64_t en:1;
+		uint64_t park_mod:1;
+		uint64_t park_dev:3;
+	} s;
+	struct cvmx_npi_pci_int_arb_cfg_cn30xx {
+		uint64_t reserved_5_63:59;
+		uint64_t en:1;
+		uint64_t park_mod:1;
+		uint64_t park_dev:3;
+	} cn30xx;
+	struct cvmx_npi_pci_int_arb_cfg_cn30xx cn31xx;
+	struct cvmx_npi_pci_int_arb_cfg_cn30xx cn38xx;
+	struct cvmx_npi_pci_int_arb_cfg_cn30xx cn38xxp2;
+	struct cvmx_npi_pci_int_arb_cfg_s cn50xx;
+	struct cvmx_npi_pci_int_arb_cfg_s cn58xx;
+	struct cvmx_npi_pci_int_arb_cfg_s cn58xxp1;
+} cvmx_npi_pci_int_arb_cfg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_pci_read_cmd_s {
+		uint64_t reserved_11_63:53;
+		uint64_t cmd_size:11;
+	} s;
+	struct cvmx_npi_pci_read_cmd_s cn30xx;
+	struct cvmx_npi_pci_read_cmd_s cn31xx;
+	struct cvmx_npi_pci_read_cmd_s cn38xx;
+	struct cvmx_npi_pci_read_cmd_s cn38xxp2;
+	struct cvmx_npi_pci_read_cmd_s cn50xx;
+	struct cvmx_npi_pci_read_cmd_s cn58xx;
+	struct cvmx_npi_pci_read_cmd_s cn58xxp1;
+} cvmx_npi_pci_read_cmd_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_port32_instr_hdr_s {
+		uint64_t reserved_44_63:20;
+		uint64_t pbp:1;
+		uint64_t rsv_f:5;
+		uint64_t rparmode:2;
+		uint64_t rsv_e:1;
+		uint64_t rskp_len:7;
+		uint64_t rsv_d:6;
+		uint64_t use_ihdr:1;
+		uint64_t rsv_c:5;
+		uint64_t par_mode:2;
+		uint64_t rsv_b:1;
+		uint64_t skp_len:7;
+		uint64_t rsv_a:6;
+	} s;
+	struct cvmx_npi_port32_instr_hdr_s cn30xx;
+	struct cvmx_npi_port32_instr_hdr_s cn31xx;
+	struct cvmx_npi_port32_instr_hdr_s cn38xx;
+	struct cvmx_npi_port32_instr_hdr_s cn38xxp2;
+	struct cvmx_npi_port32_instr_hdr_s cn50xx;
+	struct cvmx_npi_port32_instr_hdr_s cn58xx;
+	struct cvmx_npi_port32_instr_hdr_s cn58xxp1;
+} cvmx_npi_port32_instr_hdr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_port33_instr_hdr_s {
+		uint64_t reserved_44_63:20;
+		uint64_t pbp:1;
+		uint64_t rsv_f:5;
+		uint64_t rparmode:2;
+		uint64_t rsv_e:1;
+		uint64_t rskp_len:7;
+		uint64_t rsv_d:6;
+		uint64_t use_ihdr:1;
+		uint64_t rsv_c:5;
+		uint64_t par_mode:2;
+		uint64_t rsv_b:1;
+		uint64_t skp_len:7;
+		uint64_t rsv_a:6;
+	} s;
+	struct cvmx_npi_port33_instr_hdr_s cn31xx;
+	struct cvmx_npi_port33_instr_hdr_s cn38xx;
+	struct cvmx_npi_port33_instr_hdr_s cn38xxp2;
+	struct cvmx_npi_port33_instr_hdr_s cn50xx;
+	struct cvmx_npi_port33_instr_hdr_s cn58xx;
+	struct cvmx_npi_port33_instr_hdr_s cn58xxp1;
+} cvmx_npi_port33_instr_hdr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_port34_instr_hdr_s {
+		uint64_t reserved_44_63:20;
+		uint64_t pbp:1;
+		uint64_t rsv_f:5;
+		uint64_t rparmode:2;
+		uint64_t rsv_e:1;
+		uint64_t rskp_len:7;
+		uint64_t rsv_d:6;
+		uint64_t use_ihdr:1;
+		uint64_t rsv_c:5;
+		uint64_t par_mode:2;
+		uint64_t rsv_b:1;
+		uint64_t skp_len:7;
+		uint64_t rsv_a:6;
+	} s;
+	struct cvmx_npi_port34_instr_hdr_s cn38xx;
+	struct cvmx_npi_port34_instr_hdr_s cn38xxp2;
+	struct cvmx_npi_port34_instr_hdr_s cn58xx;
+	struct cvmx_npi_port34_instr_hdr_s cn58xxp1;
+} cvmx_npi_port34_instr_hdr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_port35_instr_hdr_s {
+		uint64_t reserved_44_63:20;
+		uint64_t pbp:1;
+		uint64_t rsv_f:5;
+		uint64_t rparmode:2;
+		uint64_t rsv_e:1;
+		uint64_t rskp_len:7;
+		uint64_t rsv_d:6;
+		uint64_t use_ihdr:1;
+		uint64_t rsv_c:5;
+		uint64_t par_mode:2;
+		uint64_t rsv_b:1;
+		uint64_t skp_len:7;
+		uint64_t rsv_a:6;
+	} s;
+	struct cvmx_npi_port35_instr_hdr_s cn38xx;
+	struct cvmx_npi_port35_instr_hdr_s cn38xxp2;
+	struct cvmx_npi_port35_instr_hdr_s cn58xx;
+	struct cvmx_npi_port35_instr_hdr_s cn58xxp1;
+} cvmx_npi_port35_instr_hdr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_port_bp_control_s {
+		uint64_t reserved_8_63:56;
+		uint64_t bp_on:4;
+		uint64_t enb:4;
+	} s;
+	struct cvmx_npi_port_bp_control_s cn30xx;
+	struct cvmx_npi_port_bp_control_s cn31xx;
+	struct cvmx_npi_port_bp_control_s cn38xx;
+	struct cvmx_npi_port_bp_control_s cn38xxp2;
+	struct cvmx_npi_port_bp_control_s cn50xx;
+	struct cvmx_npi_port_bp_control_s cn58xx;
+	struct cvmx_npi_port_bp_control_s cn58xxp1;
+} cvmx_npi_port_bp_control_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_rsl_int_blocks_s {
+		uint64_t reserved_32_63:32;
+		uint64_t rint_31:1;
+		uint64_t iob:1;
+		uint64_t reserved_28_29:2;
+		uint64_t rint_27:1;
+		uint64_t rint_26:1;
+		uint64_t rint_25:1;
+		uint64_t rint_24:1;
+		uint64_t asx1:1;
+		uint64_t asx0:1;
+		uint64_t rint_21:1;
+		uint64_t pip:1;
+		uint64_t spx1:1;
+		uint64_t spx0:1;
+		uint64_t lmc:1;
+		uint64_t l2c:1;
+		uint64_t rint_15:1;
+		uint64_t reserved_13_14:2;
+		uint64_t pow:1;
+		uint64_t tim:1;
+		uint64_t pko:1;
+		uint64_t ipd:1;
+		uint64_t rint_8:1;
+		uint64_t zip:1;
+		uint64_t dfa:1;
+		uint64_t fpa:1;
+		uint64_t key:1;
+		uint64_t npi:1;
+		uint64_t gmx1:1;
+		uint64_t gmx0:1;
+		uint64_t mio:1;
+	} s;
+	struct cvmx_npi_rsl_int_blocks_cn30xx {
+		uint64_t reserved_32_63:32;
+		uint64_t rint_31:1;
+		uint64_t iob:1;
+		uint64_t rint_29:1;
+		uint64_t rint_28:1;
+		uint64_t rint_27:1;
+		uint64_t rint_26:1;
+		uint64_t rint_25:1;
+		uint64_t rint_24:1;
+		uint64_t asx1:1;
+		uint64_t asx0:1;
+		uint64_t rint_21:1;
+		uint64_t pip:1;
+		uint64_t spx1:1;
+		uint64_t spx0:1;
+		uint64_t lmc:1;
+		uint64_t l2c:1;
+		uint64_t rint_15:1;
+		uint64_t rint_14:1;
+		uint64_t usb:1;
+		uint64_t pow:1;
+		uint64_t tim:1;
+		uint64_t pko:1;
+		uint64_t ipd:1;
+		uint64_t rint_8:1;
+		uint64_t zip:1;
+		uint64_t dfa:1;
+		uint64_t fpa:1;
+		uint64_t key:1;
+		uint64_t npi:1;
+		uint64_t gmx1:1;
+		uint64_t gmx0:1;
+		uint64_t mio:1;
+	} cn30xx;
+	struct cvmx_npi_rsl_int_blocks_cn30xx cn31xx;
+	struct cvmx_npi_rsl_int_blocks_cn38xx {
+		uint64_t reserved_32_63:32;
+		uint64_t rint_31:1;
+		uint64_t iob:1;
+		uint64_t rint_29:1;
+		uint64_t rint_28:1;
+		uint64_t rint_27:1;
+		uint64_t rint_26:1;
+		uint64_t rint_25:1;
+		uint64_t rint_24:1;
+		uint64_t asx1:1;
+		uint64_t asx0:1;
+		uint64_t rint_21:1;
+		uint64_t pip:1;
+		uint64_t spx1:1;
+		uint64_t spx0:1;
+		uint64_t lmc:1;
+		uint64_t l2c:1;
+		uint64_t rint_15:1;
+		uint64_t rint_14:1;
+		uint64_t rint_13:1;
+		uint64_t pow:1;
+		uint64_t tim:1;
+		uint64_t pko:1;
+		uint64_t ipd:1;
+		uint64_t rint_8:1;
+		uint64_t zip:1;
+		uint64_t dfa:1;
+		uint64_t fpa:1;
+		uint64_t key:1;
+		uint64_t npi:1;
+		uint64_t gmx1:1;
+		uint64_t gmx0:1;
+		uint64_t mio:1;
+	} cn38xx;
+	struct cvmx_npi_rsl_int_blocks_cn38xx cn38xxp2;
+	struct cvmx_npi_rsl_int_blocks_cn50xx {
+		uint64_t reserved_31_63:33;
+		uint64_t iob:1;
+		uint64_t lmc1:1;
+		uint64_t agl:1;
+		uint64_t reserved_24_27:4;
+		uint64_t asx1:1;
+		uint64_t asx0:1;
+		uint64_t reserved_21_21:1;
+		uint64_t pip:1;
+		uint64_t spx1:1;
+		uint64_t spx0:1;
+		uint64_t lmc:1;
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
+		uint64_t npi:1;
+		uint64_t gmx1:1;
+		uint64_t gmx0:1;
+		uint64_t mio:1;
+	} cn50xx;
+	struct cvmx_npi_rsl_int_blocks_cn38xx cn58xx;
+	struct cvmx_npi_rsl_int_blocks_cn38xx cn58xxp1;
+} cvmx_npi_rsl_int_blocks_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_size_inputx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t size:32;
+	} s;
+	struct cvmx_npi_size_inputx_s cn30xx;
+	struct cvmx_npi_size_inputx_s cn31xx;
+	struct cvmx_npi_size_inputx_s cn38xx;
+	struct cvmx_npi_size_inputx_s cn38xxp2;
+	struct cvmx_npi_size_inputx_s cn50xx;
+	struct cvmx_npi_size_inputx_s cn58xx;
+	struct cvmx_npi_size_inputx_s cn58xxp1;
+} cvmx_npi_size_inputx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_npi_win_read_to_s {
+		uint64_t reserved_32_63:32;
+		uint64_t time:32;
+	} s;
+	struct cvmx_npi_win_read_to_s cn30xx;
+	struct cvmx_npi_win_read_to_s cn31xx;
+	struct cvmx_npi_win_read_to_s cn38xx;
+	struct cvmx_npi_win_read_to_s cn38xxp2;
+	struct cvmx_npi_win_read_to_s cn50xx;
+	struct cvmx_npi_win_read_to_s cn58xx;
+	struct cvmx_npi_win_read_to_s cn58xxp1;
+} cvmx_npi_win_read_to_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_bar1_indexx_s {
+		uint32_t reserved_18_31:14;
+		uint32_t addr_idx:14;
+		uint32_t ca:1;
+		uint32_t end_swp:2;
+		uint32_t addr_v:1;
+	} s;
+	struct cvmx_pci_bar1_indexx_s cn30xx;
+	struct cvmx_pci_bar1_indexx_s cn31xx;
+	struct cvmx_pci_bar1_indexx_s cn38xx;
+	struct cvmx_pci_bar1_indexx_s cn38xxp2;
+	struct cvmx_pci_bar1_indexx_s cn50xx;
+	struct cvmx_pci_bar1_indexx_s cn58xx;
+	struct cvmx_pci_bar1_indexx_s cn58xxp1;
+} cvmx_pci_bar1_indexx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pci_bist_reg_s {
+		uint64_t reserved_10_63:54;
+		uint64_t rsp_bs:1;
+		uint64_t dma0_bs:1;
+		uint64_t cmd0_bs:1;
+		uint64_t cmd_bs:1;
+		uint64_t csr2p_bs:1;
+		uint64_t csrr_bs:1;
+		uint64_t rsp2p_bs:1;
+		uint64_t csr2n_bs:1;
+		uint64_t dat2n_bs:1;
+		uint64_t dbg2n_bs:1;
+	} s;
+	struct cvmx_pci_bist_reg_s cn50xx;
+} cvmx_pci_bist_reg_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg00_s {
+		uint32_t devid:16;
+		uint32_t vendid:16;
+	} s;
+	struct cvmx_pci_cfg00_s cn30xx;
+	struct cvmx_pci_cfg00_s cn31xx;
+	struct cvmx_pci_cfg00_s cn38xx;
+	struct cvmx_pci_cfg00_s cn38xxp2;
+	struct cvmx_pci_cfg00_s cn50xx;
+	struct cvmx_pci_cfg00_s cn58xx;
+	struct cvmx_pci_cfg00_s cn58xxp1;
+} cvmx_pci_cfg00_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg01_s {
+		uint32_t dpe:1;
+		uint32_t sse:1;
+		uint32_t rma:1;
+		uint32_t rta:1;
+		uint32_t sta:1;
+		uint32_t devt:2;
+		uint32_t mdpe:1;
+		uint32_t fbb:1;
+		uint32_t reserved_22_22:1;
+		uint32_t m66:1;
+		uint32_t cle:1;
+		uint32_t i_stat:1;
+		uint32_t reserved_11_18:8;
+		uint32_t i_dis:1;
+		uint32_t fbbe:1;
+		uint32_t see:1;
+		uint32_t ads:1;
+		uint32_t pee:1;
+		uint32_t vps:1;
+		uint32_t mwice:1;
+		uint32_t scse:1;
+		uint32_t me:1;
+		uint32_t msae:1;
+		uint32_t isae:1;
+	} s;
+	struct cvmx_pci_cfg01_s cn30xx;
+	struct cvmx_pci_cfg01_s cn31xx;
+	struct cvmx_pci_cfg01_s cn38xx;
+	struct cvmx_pci_cfg01_s cn38xxp2;
+	struct cvmx_pci_cfg01_s cn50xx;
+	struct cvmx_pci_cfg01_s cn58xx;
+	struct cvmx_pci_cfg01_s cn58xxp1;
+} cvmx_pci_cfg01_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg02_s {
+		uint32_t cc:24;
+		uint32_t rid:8;
+	} s;
+	struct cvmx_pci_cfg02_s cn30xx;
+	struct cvmx_pci_cfg02_s cn31xx;
+	struct cvmx_pci_cfg02_s cn38xx;
+	struct cvmx_pci_cfg02_s cn38xxp2;
+	struct cvmx_pci_cfg02_s cn50xx;
+	struct cvmx_pci_cfg02_s cn58xx;
+	struct cvmx_pci_cfg02_s cn58xxp1;
+} cvmx_pci_cfg02_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg03_s {
+		uint32_t bcap:1;
+		uint32_t brb:1;
+		uint32_t reserved_28_29:2;
+		uint32_t bcod:4;
+		uint32_t ht:8;
+		uint32_t lt:8;
+		uint32_t cls:8;
+	} s;
+	struct cvmx_pci_cfg03_s cn30xx;
+	struct cvmx_pci_cfg03_s cn31xx;
+	struct cvmx_pci_cfg03_s cn38xx;
+	struct cvmx_pci_cfg03_s cn38xxp2;
+	struct cvmx_pci_cfg03_s cn50xx;
+	struct cvmx_pci_cfg03_s cn58xx;
+	struct cvmx_pci_cfg03_s cn58xxp1;
+} cvmx_pci_cfg03_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg04_s {
+		uint32_t lbase:20;
+		uint32_t lbasez:8;
+		uint32_t pf:1;
+		uint32_t typ:2;
+		uint32_t mspc:1;
+	} s;
+	struct cvmx_pci_cfg04_s cn30xx;
+	struct cvmx_pci_cfg04_s cn31xx;
+	struct cvmx_pci_cfg04_s cn38xx;
+	struct cvmx_pci_cfg04_s cn38xxp2;
+	struct cvmx_pci_cfg04_s cn50xx;
+	struct cvmx_pci_cfg04_s cn58xx;
+	struct cvmx_pci_cfg04_s cn58xxp1;
+} cvmx_pci_cfg04_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg05_s {
+		uint32_t hbase:32;
+	} s;
+	struct cvmx_pci_cfg05_s cn30xx;
+	struct cvmx_pci_cfg05_s cn31xx;
+	struct cvmx_pci_cfg05_s cn38xx;
+	struct cvmx_pci_cfg05_s cn38xxp2;
+	struct cvmx_pci_cfg05_s cn50xx;
+	struct cvmx_pci_cfg05_s cn58xx;
+	struct cvmx_pci_cfg05_s cn58xxp1;
+} cvmx_pci_cfg05_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg06_s {
+		uint32_t lbase:5;
+		uint32_t lbasez:23;
+		uint32_t pf:1;
+		uint32_t typ:2;
+		uint32_t mspc:1;
+	} s;
+	struct cvmx_pci_cfg06_s cn30xx;
+	struct cvmx_pci_cfg06_s cn31xx;
+	struct cvmx_pci_cfg06_s cn38xx;
+	struct cvmx_pci_cfg06_s cn38xxp2;
+	struct cvmx_pci_cfg06_s cn50xx;
+	struct cvmx_pci_cfg06_s cn58xx;
+	struct cvmx_pci_cfg06_s cn58xxp1;
+} cvmx_pci_cfg06_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg07_s {
+		uint32_t hbase:32;
+	} s;
+	struct cvmx_pci_cfg07_s cn30xx;
+	struct cvmx_pci_cfg07_s cn31xx;
+	struct cvmx_pci_cfg07_s cn38xx;
+	struct cvmx_pci_cfg07_s cn38xxp2;
+	struct cvmx_pci_cfg07_s cn50xx;
+	struct cvmx_pci_cfg07_s cn58xx;
+	struct cvmx_pci_cfg07_s cn58xxp1;
+} cvmx_pci_cfg07_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg08_s {
+		uint32_t lbasez:28;
+		uint32_t pf:1;
+		uint32_t typ:2;
+		uint32_t mspc:1;
+	} s;
+	struct cvmx_pci_cfg08_s cn30xx;
+	struct cvmx_pci_cfg08_s cn31xx;
+	struct cvmx_pci_cfg08_s cn38xx;
+	struct cvmx_pci_cfg08_s cn38xxp2;
+	struct cvmx_pci_cfg08_s cn50xx;
+	struct cvmx_pci_cfg08_s cn58xx;
+	struct cvmx_pci_cfg08_s cn58xxp1;
+} cvmx_pci_cfg08_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg09_s {
+		uint32_t hbase:25;
+		uint32_t hbasez:7;
+	} s;
+	struct cvmx_pci_cfg09_s cn30xx;
+	struct cvmx_pci_cfg09_s cn31xx;
+	struct cvmx_pci_cfg09_s cn38xx;
+	struct cvmx_pci_cfg09_s cn38xxp2;
+	struct cvmx_pci_cfg09_s cn50xx;
+	struct cvmx_pci_cfg09_s cn58xx;
+	struct cvmx_pci_cfg09_s cn58xxp1;
+} cvmx_pci_cfg09_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg10_s {
+		uint32_t cisp:32;
+	} s;
+	struct cvmx_pci_cfg10_s cn30xx;
+	struct cvmx_pci_cfg10_s cn31xx;
+	struct cvmx_pci_cfg10_s cn38xx;
+	struct cvmx_pci_cfg10_s cn38xxp2;
+	struct cvmx_pci_cfg10_s cn50xx;
+	struct cvmx_pci_cfg10_s cn58xx;
+	struct cvmx_pci_cfg10_s cn58xxp1;
+} cvmx_pci_cfg10_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg11_s {
+		uint32_t ssid:16;
+		uint32_t ssvid:16;
+	} s;
+	struct cvmx_pci_cfg11_s cn30xx;
+	struct cvmx_pci_cfg11_s cn31xx;
+	struct cvmx_pci_cfg11_s cn38xx;
+	struct cvmx_pci_cfg11_s cn38xxp2;
+	struct cvmx_pci_cfg11_s cn50xx;
+	struct cvmx_pci_cfg11_s cn58xx;
+	struct cvmx_pci_cfg11_s cn58xxp1;
+} cvmx_pci_cfg11_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg12_s {
+		uint32_t erbar:16;
+		uint32_t erbarz:5;
+		uint32_t reserved_1_10:10;
+		uint32_t erbar_en:1;
+	} s;
+	struct cvmx_pci_cfg12_s cn30xx;
+	struct cvmx_pci_cfg12_s cn31xx;
+	struct cvmx_pci_cfg12_s cn38xx;
+	struct cvmx_pci_cfg12_s cn38xxp2;
+	struct cvmx_pci_cfg12_s cn50xx;
+	struct cvmx_pci_cfg12_s cn58xx;
+	struct cvmx_pci_cfg12_s cn58xxp1;
+} cvmx_pci_cfg12_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg13_s {
+		uint32_t reserved_8_31:24;
+		uint32_t cp:8;
+	} s;
+	struct cvmx_pci_cfg13_s cn30xx;
+	struct cvmx_pci_cfg13_s cn31xx;
+	struct cvmx_pci_cfg13_s cn38xx;
+	struct cvmx_pci_cfg13_s cn38xxp2;
+	struct cvmx_pci_cfg13_s cn50xx;
+	struct cvmx_pci_cfg13_s cn58xx;
+	struct cvmx_pci_cfg13_s cn58xxp1;
+} cvmx_pci_cfg13_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg15_s {
+		uint32_t ml:8;
+		uint32_t mg:8;
+		uint32_t inta:8;
+		uint32_t il:8;
+	} s;
+	struct cvmx_pci_cfg15_s cn30xx;
+	struct cvmx_pci_cfg15_s cn31xx;
+	struct cvmx_pci_cfg15_s cn38xx;
+	struct cvmx_pci_cfg15_s cn38xxp2;
+	struct cvmx_pci_cfg15_s cn50xx;
+	struct cvmx_pci_cfg15_s cn58xx;
+	struct cvmx_pci_cfg15_s cn58xxp1;
+} cvmx_pci_cfg15_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg16_s {
+		uint32_t trdnpr:1;
+		uint32_t trdard:1;
+		uint32_t rdsati:1;
+		uint32_t trdrs:1;
+		uint32_t trtae:1;
+		uint32_t twsei:1;
+		uint32_t twsen:1;
+		uint32_t twtae:1;
+		uint32_t tmae:1;
+		uint32_t tslte:3;
+		uint32_t tilt:4;
+		uint32_t pbe:12;
+		uint32_t dppmr:1;
+		uint32_t reserved_2_2:1;
+		uint32_t tswc:1;
+		uint32_t mltd:1;
+	} s;
+	struct cvmx_pci_cfg16_s cn30xx;
+	struct cvmx_pci_cfg16_s cn31xx;
+	struct cvmx_pci_cfg16_s cn38xx;
+	struct cvmx_pci_cfg16_s cn38xxp2;
+	struct cvmx_pci_cfg16_s cn50xx;
+	struct cvmx_pci_cfg16_s cn58xx;
+	struct cvmx_pci_cfg16_s cn58xxp1;
+} cvmx_pci_cfg16_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg17_s {
+		uint32_t tscme:32;
+	} s;
+	struct cvmx_pci_cfg17_s cn30xx;
+	struct cvmx_pci_cfg17_s cn31xx;
+	struct cvmx_pci_cfg17_s cn38xx;
+	struct cvmx_pci_cfg17_s cn38xxp2;
+	struct cvmx_pci_cfg17_s cn50xx;
+	struct cvmx_pci_cfg17_s cn58xx;
+	struct cvmx_pci_cfg17_s cn58xxp1;
+} cvmx_pci_cfg17_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg18_s {
+		uint32_t tdsrps:32;
+	} s;
+	struct cvmx_pci_cfg18_s cn30xx;
+	struct cvmx_pci_cfg18_s cn31xx;
+	struct cvmx_pci_cfg18_s cn38xx;
+	struct cvmx_pci_cfg18_s cn38xxp2;
+	struct cvmx_pci_cfg18_s cn50xx;
+	struct cvmx_pci_cfg18_s cn58xx;
+	struct cvmx_pci_cfg18_s cn58xxp1;
+} cvmx_pci_cfg18_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg19_s {
+		uint32_t mrbcm:1;
+		uint32_t mrbci:1;
+		uint32_t mdwe:1;
+		uint32_t mdre:1;
+		uint32_t mdrimc:1;
+		uint32_t mdrrmc:3;
+		uint32_t tmes:8;
+		uint32_t teci:1;
+		uint32_t tmei:1;
+		uint32_t tmse:1;
+		uint32_t tmdpes:1;
+		uint32_t tmapes:1;
+		uint32_t reserved_9_10:2;
+		uint32_t tibcd:1;
+		uint32_t tibde:1;
+		uint32_t reserved_6_6:1;
+		uint32_t tidomc:1;
+		uint32_t tdomc:5;
+	} s;
+	struct cvmx_pci_cfg19_s cn30xx;
+	struct cvmx_pci_cfg19_s cn31xx;
+	struct cvmx_pci_cfg19_s cn38xx;
+	struct cvmx_pci_cfg19_s cn38xxp2;
+	struct cvmx_pci_cfg19_s cn50xx;
+	struct cvmx_pci_cfg19_s cn58xx;
+	struct cvmx_pci_cfg19_s cn58xxp1;
+} cvmx_pci_cfg19_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg20_s {
+		uint32_t mdsp:32;
+	} s;
+	struct cvmx_pci_cfg20_s cn30xx;
+	struct cvmx_pci_cfg20_s cn31xx;
+	struct cvmx_pci_cfg20_s cn38xx;
+	struct cvmx_pci_cfg20_s cn38xxp2;
+	struct cvmx_pci_cfg20_s cn50xx;
+	struct cvmx_pci_cfg20_s cn58xx;
+	struct cvmx_pci_cfg20_s cn58xxp1;
+} cvmx_pci_cfg20_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg21_s {
+		uint32_t scmre:32;
+	} s;
+	struct cvmx_pci_cfg21_s cn30xx;
+	struct cvmx_pci_cfg21_s cn31xx;
+	struct cvmx_pci_cfg21_s cn38xx;
+	struct cvmx_pci_cfg21_s cn38xxp2;
+	struct cvmx_pci_cfg21_s cn50xx;
+	struct cvmx_pci_cfg21_s cn58xx;
+	struct cvmx_pci_cfg21_s cn58xxp1;
+} cvmx_pci_cfg21_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg22_s {
+		uint32_t mac:7;
+		uint32_t reserved_19_24:6;
+		uint32_t flush:1;
+		uint32_t mra:1;
+		uint32_t mtta:1;
+		uint32_t mrv:8;
+		uint32_t mttv:8;
+	} s;
+	struct cvmx_pci_cfg22_s cn30xx;
+	struct cvmx_pci_cfg22_s cn31xx;
+	struct cvmx_pci_cfg22_s cn38xx;
+	struct cvmx_pci_cfg22_s cn38xxp2;
+	struct cvmx_pci_cfg22_s cn50xx;
+	struct cvmx_pci_cfg22_s cn58xx;
+	struct cvmx_pci_cfg22_s cn58xxp1;
+} cvmx_pci_cfg22_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg56_s {
+		uint32_t reserved_23_31:9;
+		uint32_t most:3;
+		uint32_t mmbc:2;
+		uint32_t roe:1;
+		uint32_t dpere:1;
+		uint32_t ncp:8;
+		uint32_t pxcid:8;
+	} s;
+	struct cvmx_pci_cfg56_s cn30xx;
+	struct cvmx_pci_cfg56_s cn31xx;
+	struct cvmx_pci_cfg56_s cn38xx;
+	struct cvmx_pci_cfg56_s cn38xxp2;
+	struct cvmx_pci_cfg56_s cn50xx;
+	struct cvmx_pci_cfg56_s cn58xx;
+	struct cvmx_pci_cfg56_s cn58xxp1;
+} cvmx_pci_cfg56_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg57_s {
+		uint32_t reserved_30_31:2;
+		uint32_t scemr:1;
+		uint32_t mcrsd:3;
+		uint32_t mostd:3;
+		uint32_t mmrbcd:2;
+		uint32_t dc:1;
+		uint32_t usc:1;
+		uint32_t scd:1;
+		uint32_t m133:1;
+		uint32_t w64:1;
+		uint32_t bn:8;
+		uint32_t dn:5;
+		uint32_t fn:3;
+	} s;
+	struct cvmx_pci_cfg57_s cn30xx;
+	struct cvmx_pci_cfg57_s cn31xx;
+	struct cvmx_pci_cfg57_s cn38xx;
+	struct cvmx_pci_cfg57_s cn38xxp2;
+	struct cvmx_pci_cfg57_s cn50xx;
+	struct cvmx_pci_cfg57_s cn58xx;
+	struct cvmx_pci_cfg57_s cn58xxp1;
+} cvmx_pci_cfg57_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg58_s {
+		uint32_t pmes:5;
+		uint32_t d2s:1;
+		uint32_t d1s:1;
+		uint32_t auxc:3;
+		uint32_t dsi:1;
+		uint32_t reserved_20_20:1;
+		uint32_t pmec:1;
+		uint32_t pcimiv:3;
+		uint32_t ncp:8;
+		uint32_t pmcid:8;
+	} s;
+	struct cvmx_pci_cfg58_s cn30xx;
+	struct cvmx_pci_cfg58_s cn31xx;
+	struct cvmx_pci_cfg58_s cn38xx;
+	struct cvmx_pci_cfg58_s cn38xxp2;
+	struct cvmx_pci_cfg58_s cn50xx;
+	struct cvmx_pci_cfg58_s cn58xx;
+	struct cvmx_pci_cfg58_s cn58xxp1;
+} cvmx_pci_cfg58_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg59_s {
+		uint32_t pmdia:8;
+		uint32_t bpccen:1;
+		uint32_t bd3h:1;
+		uint32_t reserved_16_21:6;
+		uint32_t pmess:1;
+		uint32_t pmedsia:2;
+		uint32_t pmds:4;
+		uint32_t pmeens:1;
+		uint32_t reserved_2_7:6;
+		uint32_t ps:2;
+	} s;
+	struct cvmx_pci_cfg59_s cn30xx;
+	struct cvmx_pci_cfg59_s cn31xx;
+	struct cvmx_pci_cfg59_s cn38xx;
+	struct cvmx_pci_cfg59_s cn38xxp2;
+	struct cvmx_pci_cfg59_s cn50xx;
+	struct cvmx_pci_cfg59_s cn58xx;
+	struct cvmx_pci_cfg59_s cn58xxp1;
+} cvmx_pci_cfg59_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg60_s {
+		uint32_t reserved_24_31:8;
+		uint32_t m64:1;
+		uint32_t mme:3;
+		uint32_t mmc:3;
+		uint32_t msien:1;
+		uint32_t ncp:8;
+		uint32_t msicid:8;
+	} s;
+	struct cvmx_pci_cfg60_s cn30xx;
+	struct cvmx_pci_cfg60_s cn31xx;
+	struct cvmx_pci_cfg60_s cn38xx;
+	struct cvmx_pci_cfg60_s cn38xxp2;
+	struct cvmx_pci_cfg60_s cn50xx;
+	struct cvmx_pci_cfg60_s cn58xx;
+	struct cvmx_pci_cfg60_s cn58xxp1;
+} cvmx_pci_cfg60_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg61_s {
+		uint32_t msi31t2:30;
+		uint32_t reserved_0_1:2;
+	} s;
+	struct cvmx_pci_cfg61_s cn30xx;
+	struct cvmx_pci_cfg61_s cn31xx;
+	struct cvmx_pci_cfg61_s cn38xx;
+	struct cvmx_pci_cfg61_s cn38xxp2;
+	struct cvmx_pci_cfg61_s cn50xx;
+	struct cvmx_pci_cfg61_s cn58xx;
+	struct cvmx_pci_cfg61_s cn58xxp1;
+} cvmx_pci_cfg61_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg62_s {
+		uint32_t msi:32;
+	} s;
+	struct cvmx_pci_cfg62_s cn30xx;
+	struct cvmx_pci_cfg62_s cn31xx;
+	struct cvmx_pci_cfg62_s cn38xx;
+	struct cvmx_pci_cfg62_s cn38xxp2;
+	struct cvmx_pci_cfg62_s cn50xx;
+	struct cvmx_pci_cfg62_s cn58xx;
+	struct cvmx_pci_cfg62_s cn58xxp1;
+} cvmx_pci_cfg62_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_cfg63_s {
+		uint32_t reserved_16_31:16;
+		uint32_t msimd:16;
+	} s;
+	struct cvmx_pci_cfg63_s cn30xx;
+	struct cvmx_pci_cfg63_s cn31xx;
+	struct cvmx_pci_cfg63_s cn38xx;
+	struct cvmx_pci_cfg63_s cn38xxp2;
+	struct cvmx_pci_cfg63_s cn50xx;
+	struct cvmx_pci_cfg63_s cn58xx;
+	struct cvmx_pci_cfg63_s cn58xxp1;
+} cvmx_pci_cfg63_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pci_cnt_reg_s {
+		uint64_t reserved_38_63:26;
+		uint64_t hm_pcix:1;
+		uint64_t hm_speed:2;
+		uint64_t ap_pcix:1;
+		uint64_t ap_speed:2;
+		uint64_t pcicnt:32;
+	} s;
+	struct cvmx_pci_cnt_reg_s cn50xx;
+	struct cvmx_pci_cnt_reg_s cn58xx;
+	struct cvmx_pci_cnt_reg_s cn58xxp1;
+} cvmx_pci_cnt_reg_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_ctl_status_2_s {
+		uint32_t reserved_29_31:3;
+		uint32_t bb1_hole:3;
+		uint32_t bb1_siz:1;
+		uint32_t bb_ca:1;
+		uint32_t bb_es:2;
+		uint32_t bb1:1;
+		uint32_t bb0:1;
+		uint32_t erst_n:1;
+		uint32_t bar2pres:1;
+		uint32_t scmtyp:1;
+		uint32_t scm:1;
+		uint32_t en_wfilt:1;
+		uint32_t reserved_14_14:1;
+		uint32_t ap_pcix:1;
+		uint32_t ap_64ad:1;
+		uint32_t b12_bist:1;
+		uint32_t pmo_amod:1;
+		uint32_t pmo_fpc:3;
+		uint32_t tsr_hwm:3;
+		uint32_t bar2_enb:1;
+		uint32_t bar2_esx:2;
+		uint32_t bar2_cax:1;
+	} s;
+	struct cvmx_pci_ctl_status_2_s cn30xx;
+	struct cvmx_pci_ctl_status_2_cn31xx {
+		uint32_t reserved_20_31:12;
+		uint32_t erst_n:1;
+		uint32_t bar2pres:1;
+		uint32_t scmtyp:1;
+		uint32_t scm:1;
+		uint32_t en_wfilt:1;
+		uint32_t reserved_14_14:1;
+		uint32_t ap_pcix:1;
+		uint32_t ap_64ad:1;
+		uint32_t b12_bist:1;
+		uint32_t pmo_amod:1;
+		uint32_t pmo_fpc:3;
+		uint32_t tsr_hwm:3;
+		uint32_t bar2_enb:1;
+		uint32_t bar2_esx:2;
+		uint32_t bar2_cax:1;
+	} cn31xx;
+	struct cvmx_pci_ctl_status_2_s cn38xx;
+	struct cvmx_pci_ctl_status_2_cn31xx cn38xxp2;
+	struct cvmx_pci_ctl_status_2_s cn50xx;
+	struct cvmx_pci_ctl_status_2_s cn58xx;
+	struct cvmx_pci_ctl_status_2_s cn58xxp1;
+} cvmx_pci_ctl_status_2_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_dbellx_s {
+		uint32_t reserved_16_31:16;
+		uint32_t inc_val:16;
+	} s;
+	struct cvmx_pci_dbellx_s cn30xx;
+	struct cvmx_pci_dbellx_s cn31xx;
+	struct cvmx_pci_dbellx_s cn38xx;
+	struct cvmx_pci_dbellx_s cn38xxp2;
+	struct cvmx_pci_dbellx_s cn50xx;
+	struct cvmx_pci_dbellx_s cn58xx;
+	struct cvmx_pci_dbellx_s cn58xxp1;
+} cvmx_pci_dbellx_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_dma_cntx_s {
+		uint32_t dma_cnt:32;
+	} s;
+	struct cvmx_pci_dma_cntx_s cn30xx;
+	struct cvmx_pci_dma_cntx_s cn31xx;
+	struct cvmx_pci_dma_cntx_s cn38xx;
+	struct cvmx_pci_dma_cntx_s cn38xxp2;
+	struct cvmx_pci_dma_cntx_s cn50xx;
+	struct cvmx_pci_dma_cntx_s cn58xx;
+	struct cvmx_pci_dma_cntx_s cn58xxp1;
+} cvmx_pci_dma_cntx_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_dma_int_levx_s {
+		uint32_t pkt_cnt:32;
+	} s;
+	struct cvmx_pci_dma_int_levx_s cn30xx;
+	struct cvmx_pci_dma_int_levx_s cn31xx;
+	struct cvmx_pci_dma_int_levx_s cn38xx;
+	struct cvmx_pci_dma_int_levx_s cn38xxp2;
+	struct cvmx_pci_dma_int_levx_s cn50xx;
+	struct cvmx_pci_dma_int_levx_s cn58xx;
+	struct cvmx_pci_dma_int_levx_s cn58xxp1;
+} cvmx_pci_dma_int_levx_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_dma_timex_s {
+		uint32_t dma_time:32;
+	} s;
+	struct cvmx_pci_dma_timex_s cn30xx;
+	struct cvmx_pci_dma_timex_s cn31xx;
+	struct cvmx_pci_dma_timex_s cn38xx;
+	struct cvmx_pci_dma_timex_s cn38xxp2;
+	struct cvmx_pci_dma_timex_s cn50xx;
+	struct cvmx_pci_dma_timex_s cn58xx;
+	struct cvmx_pci_dma_timex_s cn58xxp1;
+} cvmx_pci_dma_timex_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_instr_countx_s {
+		uint32_t icnt:32;
+	} s;
+	struct cvmx_pci_instr_countx_s cn30xx;
+	struct cvmx_pci_instr_countx_s cn31xx;
+	struct cvmx_pci_instr_countx_s cn38xx;
+	struct cvmx_pci_instr_countx_s cn38xxp2;
+	struct cvmx_pci_instr_countx_s cn50xx;
+	struct cvmx_pci_instr_countx_s cn58xx;
+	struct cvmx_pci_instr_countx_s cn58xxp1;
+} cvmx_pci_instr_countx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pci_int_enb_s {
+		uint64_t reserved_34_63:30;
+		uint64_t ill_rd:1;
+		uint64_t ill_wr:1;
+		uint64_t win_wr:1;
+		uint64_t dma1_fi:1;
+		uint64_t dma0_fi:1;
+		uint64_t idtime1:1;
+		uint64_t idtime0:1;
+		uint64_t idcnt1:1;
+		uint64_t idcnt0:1;
+		uint64_t iptime3:1;
+		uint64_t iptime2:1;
+		uint64_t iptime1:1;
+		uint64_t iptime0:1;
+		uint64_t ipcnt3:1;
+		uint64_t ipcnt2:1;
+		uint64_t ipcnt1:1;
+		uint64_t ipcnt0:1;
+		uint64_t irsl_int:1;
+		uint64_t ill_rrd:1;
+		uint64_t ill_rwr:1;
+		uint64_t idperr:1;
+		uint64_t iaperr:1;
+		uint64_t iserr:1;
+		uint64_t itsr_abt:1;
+		uint64_t imsc_msg:1;
+		uint64_t imsi_mabt:1;
+		uint64_t imsi_tabt:1;
+		uint64_t imsi_per:1;
+		uint64_t imr_tto:1;
+		uint64_t imr_abt:1;
+		uint64_t itr_abt:1;
+		uint64_t imr_wtto:1;
+		uint64_t imr_wabt:1;
+		uint64_t itr_wabt:1;
+	} s;
+	struct cvmx_pci_int_enb_cn30xx {
+		uint64_t reserved_34_63:30;
+		uint64_t ill_rd:1;
+		uint64_t ill_wr:1;
+		uint64_t win_wr:1;
+		uint64_t dma1_fi:1;
+		uint64_t dma0_fi:1;
+		uint64_t idtime1:1;
+		uint64_t idtime0:1;
+		uint64_t idcnt1:1;
+		uint64_t idcnt0:1;
+		uint64_t reserved_22_24:3;
+		uint64_t iptime0:1;
+		uint64_t reserved_18_20:3;
+		uint64_t ipcnt0:1;
+		uint64_t irsl_int:1;
+		uint64_t ill_rrd:1;
+		uint64_t ill_rwr:1;
+		uint64_t idperr:1;
+		uint64_t iaperr:1;
+		uint64_t iserr:1;
+		uint64_t itsr_abt:1;
+		uint64_t imsc_msg:1;
+		uint64_t imsi_mabt:1;
+		uint64_t imsi_tabt:1;
+		uint64_t imsi_per:1;
+		uint64_t imr_tto:1;
+		uint64_t imr_abt:1;
+		uint64_t itr_abt:1;
+		uint64_t imr_wtto:1;
+		uint64_t imr_wabt:1;
+		uint64_t itr_wabt:1;
+	} cn30xx;
+	struct cvmx_pci_int_enb_cn31xx {
+		uint64_t reserved_34_63:30;
+		uint64_t ill_rd:1;
+		uint64_t ill_wr:1;
+		uint64_t win_wr:1;
+		uint64_t dma1_fi:1;
+		uint64_t dma0_fi:1;
+		uint64_t idtime1:1;
+		uint64_t idtime0:1;
+		uint64_t idcnt1:1;
+		uint64_t idcnt0:1;
+		uint64_t reserved_23_24:2;
+		uint64_t iptime1:1;
+		uint64_t iptime0:1;
+		uint64_t reserved_19_20:2;
+		uint64_t ipcnt1:1;
+		uint64_t ipcnt0:1;
+		uint64_t irsl_int:1;
+		uint64_t ill_rrd:1;
+		uint64_t ill_rwr:1;
+		uint64_t idperr:1;
+		uint64_t iaperr:1;
+		uint64_t iserr:1;
+		uint64_t itsr_abt:1;
+		uint64_t imsc_msg:1;
+		uint64_t imsi_mabt:1;
+		uint64_t imsi_tabt:1;
+		uint64_t imsi_per:1;
+		uint64_t imr_tto:1;
+		uint64_t imr_abt:1;
+		uint64_t itr_abt:1;
+		uint64_t imr_wtto:1;
+		uint64_t imr_wabt:1;
+		uint64_t itr_wabt:1;
+	} cn31xx;
+	struct cvmx_pci_int_enb_s cn38xx;
+	struct cvmx_pci_int_enb_s cn38xxp2;
+	struct cvmx_pci_int_enb_cn31xx cn50xx;
+	struct cvmx_pci_int_enb_s cn58xx;
+	struct cvmx_pci_int_enb_s cn58xxp1;
+} cvmx_pci_int_enb_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pci_int_enb2_s {
+		uint64_t reserved_34_63:30;
+		uint64_t ill_rd:1;
+		uint64_t ill_wr:1;
+		uint64_t win_wr:1;
+		uint64_t dma1_fi:1;
+		uint64_t dma0_fi:1;
+		uint64_t rdtime1:1;
+		uint64_t rdtime0:1;
+		uint64_t rdcnt1:1;
+		uint64_t rdcnt0:1;
+		uint64_t rptime3:1;
+		uint64_t rptime2:1;
+		uint64_t rptime1:1;
+		uint64_t rptime0:1;
+		uint64_t rpcnt3:1;
+		uint64_t rpcnt2:1;
+		uint64_t rpcnt1:1;
+		uint64_t rpcnt0:1;
+		uint64_t rrsl_int:1;
+		uint64_t ill_rrd:1;
+		uint64_t ill_rwr:1;
+		uint64_t rdperr:1;
+		uint64_t raperr:1;
+		uint64_t rserr:1;
+		uint64_t rtsr_abt:1;
+		uint64_t rmsc_msg:1;
+		uint64_t rmsi_mabt:1;
+		uint64_t rmsi_tabt:1;
+		uint64_t rmsi_per:1;
+		uint64_t rmr_tto:1;
+		uint64_t rmr_abt:1;
+		uint64_t rtr_abt:1;
+		uint64_t rmr_wtto:1;
+		uint64_t rmr_wabt:1;
+		uint64_t rtr_wabt:1;
+	} s;
+	struct cvmx_pci_int_enb2_cn30xx {
+		uint64_t reserved_34_63:30;
+		uint64_t ill_rd:1;
+		uint64_t ill_wr:1;
+		uint64_t win_wr:1;
+		uint64_t dma1_fi:1;
+		uint64_t dma0_fi:1;
+		uint64_t rdtime1:1;
+		uint64_t rdtime0:1;
+		uint64_t rdcnt1:1;
+		uint64_t rdcnt0:1;
+		uint64_t reserved_22_24:3;
+		uint64_t rptime0:1;
+		uint64_t reserved_18_20:3;
+		uint64_t rpcnt0:1;
+		uint64_t rrsl_int:1;
+		uint64_t ill_rrd:1;
+		uint64_t ill_rwr:1;
+		uint64_t rdperr:1;
+		uint64_t raperr:1;
+		uint64_t rserr:1;
+		uint64_t rtsr_abt:1;
+		uint64_t rmsc_msg:1;
+		uint64_t rmsi_mabt:1;
+		uint64_t rmsi_tabt:1;
+		uint64_t rmsi_per:1;
+		uint64_t rmr_tto:1;
+		uint64_t rmr_abt:1;
+		uint64_t rtr_abt:1;
+		uint64_t rmr_wtto:1;
+		uint64_t rmr_wabt:1;
+		uint64_t rtr_wabt:1;
+	} cn30xx;
+	struct cvmx_pci_int_enb2_cn31xx {
+		uint64_t reserved_34_63:30;
+		uint64_t ill_rd:1;
+		uint64_t ill_wr:1;
+		uint64_t win_wr:1;
+		uint64_t dma1_fi:1;
+		uint64_t dma0_fi:1;
+		uint64_t rdtime1:1;
+		uint64_t rdtime0:1;
+		uint64_t rdcnt1:1;
+		uint64_t rdcnt0:1;
+		uint64_t reserved_23_24:2;
+		uint64_t rptime1:1;
+		uint64_t rptime0:1;
+		uint64_t reserved_19_20:2;
+		uint64_t rpcnt1:1;
+		uint64_t rpcnt0:1;
+		uint64_t rrsl_int:1;
+		uint64_t ill_rrd:1;
+		uint64_t ill_rwr:1;
+		uint64_t rdperr:1;
+		uint64_t raperr:1;
+		uint64_t rserr:1;
+		uint64_t rtsr_abt:1;
+		uint64_t rmsc_msg:1;
+		uint64_t rmsi_mabt:1;
+		uint64_t rmsi_tabt:1;
+		uint64_t rmsi_per:1;
+		uint64_t rmr_tto:1;
+		uint64_t rmr_abt:1;
+		uint64_t rtr_abt:1;
+		uint64_t rmr_wtto:1;
+		uint64_t rmr_wabt:1;
+		uint64_t rtr_wabt:1;
+	} cn31xx;
+	struct cvmx_pci_int_enb2_s cn38xx;
+	struct cvmx_pci_int_enb2_s cn38xxp2;
+	struct cvmx_pci_int_enb2_cn31xx cn50xx;
+	struct cvmx_pci_int_enb2_s cn58xx;
+	struct cvmx_pci_int_enb2_s cn58xxp1;
+} cvmx_pci_int_enb2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pci_int_sum_s {
+		uint64_t reserved_34_63:30;
+		uint64_t ill_rd:1;
+		uint64_t ill_wr:1;
+		uint64_t win_wr:1;
+		uint64_t dma1_fi:1;
+		uint64_t dma0_fi:1;
+		uint64_t dtime1:1;
+		uint64_t dtime0:1;
+		uint64_t dcnt1:1;
+		uint64_t dcnt0:1;
+		uint64_t ptime3:1;
+		uint64_t ptime2:1;
+		uint64_t ptime1:1;
+		uint64_t ptime0:1;
+		uint64_t pcnt3:1;
+		uint64_t pcnt2:1;
+		uint64_t pcnt1:1;
+		uint64_t pcnt0:1;
+		uint64_t rsl_int:1;
+		uint64_t ill_rrd:1;
+		uint64_t ill_rwr:1;
+		uint64_t dperr:1;
+		uint64_t aperr:1;
+		uint64_t serr:1;
+		uint64_t tsr_abt:1;
+		uint64_t msc_msg:1;
+		uint64_t msi_mabt:1;
+		uint64_t msi_tabt:1;
+		uint64_t msi_per:1;
+		uint64_t mr_tto:1;
+		uint64_t mr_abt:1;
+		uint64_t tr_abt:1;
+		uint64_t mr_wtto:1;
+		uint64_t mr_wabt:1;
+		uint64_t tr_wabt:1;
+	} s;
+	struct cvmx_pci_int_sum_cn30xx {
+		uint64_t reserved_34_63:30;
+		uint64_t ill_rd:1;
+		uint64_t ill_wr:1;
+		uint64_t win_wr:1;
+		uint64_t dma1_fi:1;
+		uint64_t dma0_fi:1;
+		uint64_t dtime1:1;
+		uint64_t dtime0:1;
+		uint64_t dcnt1:1;
+		uint64_t dcnt0:1;
+		uint64_t reserved_22_24:3;
+		uint64_t ptime0:1;
+		uint64_t reserved_18_20:3;
+		uint64_t pcnt0:1;
+		uint64_t rsl_int:1;
+		uint64_t ill_rrd:1;
+		uint64_t ill_rwr:1;
+		uint64_t dperr:1;
+		uint64_t aperr:1;
+		uint64_t serr:1;
+		uint64_t tsr_abt:1;
+		uint64_t msc_msg:1;
+		uint64_t msi_mabt:1;
+		uint64_t msi_tabt:1;
+		uint64_t msi_per:1;
+		uint64_t mr_tto:1;
+		uint64_t mr_abt:1;
+		uint64_t tr_abt:1;
+		uint64_t mr_wtto:1;
+		uint64_t mr_wabt:1;
+		uint64_t tr_wabt:1;
+	} cn30xx;
+	struct cvmx_pci_int_sum_cn31xx {
+		uint64_t reserved_34_63:30;
+		uint64_t ill_rd:1;
+		uint64_t ill_wr:1;
+		uint64_t win_wr:1;
+		uint64_t dma1_fi:1;
+		uint64_t dma0_fi:1;
+		uint64_t dtime1:1;
+		uint64_t dtime0:1;
+		uint64_t dcnt1:1;
+		uint64_t dcnt0:1;
+		uint64_t reserved_23_24:2;
+		uint64_t ptime1:1;
+		uint64_t ptime0:1;
+		uint64_t reserved_19_20:2;
+		uint64_t pcnt1:1;
+		uint64_t pcnt0:1;
+		uint64_t rsl_int:1;
+		uint64_t ill_rrd:1;
+		uint64_t ill_rwr:1;
+		uint64_t dperr:1;
+		uint64_t aperr:1;
+		uint64_t serr:1;
+		uint64_t tsr_abt:1;
+		uint64_t msc_msg:1;
+		uint64_t msi_mabt:1;
+		uint64_t msi_tabt:1;
+		uint64_t msi_per:1;
+		uint64_t mr_tto:1;
+		uint64_t mr_abt:1;
+		uint64_t tr_abt:1;
+		uint64_t mr_wtto:1;
+		uint64_t mr_wabt:1;
+		uint64_t tr_wabt:1;
+	} cn31xx;
+	struct cvmx_pci_int_sum_s cn38xx;
+	struct cvmx_pci_int_sum_s cn38xxp2;
+	struct cvmx_pci_int_sum_cn31xx cn50xx;
+	struct cvmx_pci_int_sum_s cn58xx;
+	struct cvmx_pci_int_sum_s cn58xxp1;
+} cvmx_pci_int_sum_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pci_int_sum2_s {
+		uint64_t reserved_34_63:30;
+		uint64_t ill_rd:1;
+		uint64_t ill_wr:1;
+		uint64_t win_wr:1;
+		uint64_t dma1_fi:1;
+		uint64_t dma0_fi:1;
+		uint64_t dtime1:1;
+		uint64_t dtime0:1;
+		uint64_t dcnt1:1;
+		uint64_t dcnt0:1;
+		uint64_t ptime3:1;
+		uint64_t ptime2:1;
+		uint64_t ptime1:1;
+		uint64_t ptime0:1;
+		uint64_t pcnt3:1;
+		uint64_t pcnt2:1;
+		uint64_t pcnt1:1;
+		uint64_t pcnt0:1;
+		uint64_t rsl_int:1;
+		uint64_t ill_rrd:1;
+		uint64_t ill_rwr:1;
+		uint64_t dperr:1;
+		uint64_t aperr:1;
+		uint64_t serr:1;
+		uint64_t tsr_abt:1;
+		uint64_t msc_msg:1;
+		uint64_t msi_mabt:1;
+		uint64_t msi_tabt:1;
+		uint64_t msi_per:1;
+		uint64_t mr_tto:1;
+		uint64_t mr_abt:1;
+		uint64_t tr_abt:1;
+		uint64_t mr_wtto:1;
+		uint64_t mr_wabt:1;
+		uint64_t tr_wabt:1;
+	} s;
+	struct cvmx_pci_int_sum2_cn30xx {
+		uint64_t reserved_34_63:30;
+		uint64_t ill_rd:1;
+		uint64_t ill_wr:1;
+		uint64_t win_wr:1;
+		uint64_t dma1_fi:1;
+		uint64_t dma0_fi:1;
+		uint64_t dtime1:1;
+		uint64_t dtime0:1;
+		uint64_t dcnt1:1;
+		uint64_t dcnt0:1;
+		uint64_t reserved_22_24:3;
+		uint64_t ptime0:1;
+		uint64_t reserved_18_20:3;
+		uint64_t pcnt0:1;
+		uint64_t rsl_int:1;
+		uint64_t ill_rrd:1;
+		uint64_t ill_rwr:1;
+		uint64_t dperr:1;
+		uint64_t aperr:1;
+		uint64_t serr:1;
+		uint64_t tsr_abt:1;
+		uint64_t msc_msg:1;
+		uint64_t msi_mabt:1;
+		uint64_t msi_tabt:1;
+		uint64_t msi_per:1;
+		uint64_t mr_tto:1;
+		uint64_t mr_abt:1;
+		uint64_t tr_abt:1;
+		uint64_t mr_wtto:1;
+		uint64_t mr_wabt:1;
+		uint64_t tr_wabt:1;
+	} cn30xx;
+	struct cvmx_pci_int_sum2_cn31xx {
+		uint64_t reserved_34_63:30;
+		uint64_t ill_rd:1;
+		uint64_t ill_wr:1;
+		uint64_t win_wr:1;
+		uint64_t dma1_fi:1;
+		uint64_t dma0_fi:1;
+		uint64_t dtime1:1;
+		uint64_t dtime0:1;
+		uint64_t dcnt1:1;
+		uint64_t dcnt0:1;
+		uint64_t reserved_23_24:2;
+		uint64_t ptime1:1;
+		uint64_t ptime0:1;
+		uint64_t reserved_19_20:2;
+		uint64_t pcnt1:1;
+		uint64_t pcnt0:1;
+		uint64_t rsl_int:1;
+		uint64_t ill_rrd:1;
+		uint64_t ill_rwr:1;
+		uint64_t dperr:1;
+		uint64_t aperr:1;
+		uint64_t serr:1;
+		uint64_t tsr_abt:1;
+		uint64_t msc_msg:1;
+		uint64_t msi_mabt:1;
+		uint64_t msi_tabt:1;
+		uint64_t msi_per:1;
+		uint64_t mr_tto:1;
+		uint64_t mr_abt:1;
+		uint64_t tr_abt:1;
+		uint64_t mr_wtto:1;
+		uint64_t mr_wabt:1;
+		uint64_t tr_wabt:1;
+	} cn31xx;
+	struct cvmx_pci_int_sum2_s cn38xx;
+	struct cvmx_pci_int_sum2_s cn38xxp2;
+	struct cvmx_pci_int_sum2_cn31xx cn50xx;
+	struct cvmx_pci_int_sum2_s cn58xx;
+	struct cvmx_pci_int_sum2_s cn58xxp1;
+} cvmx_pci_int_sum2_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_msi_rcv_s {
+		uint32_t reserved_6_31:26;
+		uint32_t intr:6;
+	} s;
+	struct cvmx_pci_msi_rcv_s cn30xx;
+	struct cvmx_pci_msi_rcv_s cn31xx;
+	struct cvmx_pci_msi_rcv_s cn38xx;
+	struct cvmx_pci_msi_rcv_s cn38xxp2;
+	struct cvmx_pci_msi_rcv_s cn50xx;
+	struct cvmx_pci_msi_rcv_s cn58xx;
+	struct cvmx_pci_msi_rcv_s cn58xxp1;
+} cvmx_pci_msi_rcv_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_pkt_creditsx_s {
+		uint32_t pkt_cnt:16;
+		uint32_t ptr_cnt:16;
+	} s;
+	struct cvmx_pci_pkt_creditsx_s cn30xx;
+	struct cvmx_pci_pkt_creditsx_s cn31xx;
+	struct cvmx_pci_pkt_creditsx_s cn38xx;
+	struct cvmx_pci_pkt_creditsx_s cn38xxp2;
+	struct cvmx_pci_pkt_creditsx_s cn50xx;
+	struct cvmx_pci_pkt_creditsx_s cn58xx;
+	struct cvmx_pci_pkt_creditsx_s cn58xxp1;
+} cvmx_pci_pkt_creditsx_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_pkts_sentx_s {
+		uint32_t pkt_cnt:32;
+	} s;
+	struct cvmx_pci_pkts_sentx_s cn30xx;
+	struct cvmx_pci_pkts_sentx_s cn31xx;
+	struct cvmx_pci_pkts_sentx_s cn38xx;
+	struct cvmx_pci_pkts_sentx_s cn38xxp2;
+	struct cvmx_pci_pkts_sentx_s cn50xx;
+	struct cvmx_pci_pkts_sentx_s cn58xx;
+	struct cvmx_pci_pkts_sentx_s cn58xxp1;
+} cvmx_pci_pkts_sentx_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_pkts_sent_int_levx_s {
+		uint32_t pkt_cnt:32;
+	} s;
+	struct cvmx_pci_pkts_sent_int_levx_s cn30xx;
+	struct cvmx_pci_pkts_sent_int_levx_s cn31xx;
+	struct cvmx_pci_pkts_sent_int_levx_s cn38xx;
+	struct cvmx_pci_pkts_sent_int_levx_s cn38xxp2;
+	struct cvmx_pci_pkts_sent_int_levx_s cn50xx;
+	struct cvmx_pci_pkts_sent_int_levx_s cn58xx;
+	struct cvmx_pci_pkts_sent_int_levx_s cn58xxp1;
+} cvmx_pci_pkts_sent_int_levx_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_pkts_sent_timex_s {
+		uint32_t pkt_time:32;
+	} s;
+	struct cvmx_pci_pkts_sent_timex_s cn30xx;
+	struct cvmx_pci_pkts_sent_timex_s cn31xx;
+	struct cvmx_pci_pkts_sent_timex_s cn38xx;
+	struct cvmx_pci_pkts_sent_timex_s cn38xxp2;
+	struct cvmx_pci_pkts_sent_timex_s cn50xx;
+	struct cvmx_pci_pkts_sent_timex_s cn58xx;
+	struct cvmx_pci_pkts_sent_timex_s cn58xxp1;
+} cvmx_pci_pkts_sent_timex_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_read_cmd_6_s {
+		uint32_t reserved_9_31:23;
+		uint32_t min_data:6;
+		uint32_t prefetch:3;
+	} s;
+	struct cvmx_pci_read_cmd_6_s cn30xx;
+	struct cvmx_pci_read_cmd_6_s cn31xx;
+	struct cvmx_pci_read_cmd_6_s cn38xx;
+	struct cvmx_pci_read_cmd_6_s cn38xxp2;
+	struct cvmx_pci_read_cmd_6_s cn50xx;
+	struct cvmx_pci_read_cmd_6_s cn58xx;
+	struct cvmx_pci_read_cmd_6_s cn58xxp1;
+} cvmx_pci_read_cmd_6_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_read_cmd_c_s {
+		uint32_t reserved_9_31:23;
+		uint32_t min_data:6;
+		uint32_t prefetch:3;
+	} s;
+	struct cvmx_pci_read_cmd_c_s cn30xx;
+	struct cvmx_pci_read_cmd_c_s cn31xx;
+	struct cvmx_pci_read_cmd_c_s cn38xx;
+	struct cvmx_pci_read_cmd_c_s cn38xxp2;
+	struct cvmx_pci_read_cmd_c_s cn50xx;
+	struct cvmx_pci_read_cmd_c_s cn58xx;
+	struct cvmx_pci_read_cmd_c_s cn58xxp1;
+} cvmx_pci_read_cmd_c_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pci_read_cmd_e_s {
+		uint32_t reserved_9_31:23;
+		uint32_t min_data:6;
+		uint32_t prefetch:3;
+	} s;
+	struct cvmx_pci_read_cmd_e_s cn30xx;
+	struct cvmx_pci_read_cmd_e_s cn31xx;
+	struct cvmx_pci_read_cmd_e_s cn38xx;
+	struct cvmx_pci_read_cmd_e_s cn38xxp2;
+	struct cvmx_pci_read_cmd_e_s cn50xx;
+	struct cvmx_pci_read_cmd_e_s cn58xx;
+	struct cvmx_pci_read_cmd_e_s cn58xxp1;
+} cvmx_pci_read_cmd_e_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pci_read_timeout_s {
+		uint64_t reserved_32_63:32;
+		uint64_t enb:1;
+		uint64_t cnt:31;
+	} s;
+	struct cvmx_pci_read_timeout_s cn30xx;
+	struct cvmx_pci_read_timeout_s cn31xx;
+	struct cvmx_pci_read_timeout_s cn38xx;
+	struct cvmx_pci_read_timeout_s cn38xxp2;
+	struct cvmx_pci_read_timeout_s cn50xx;
+	struct cvmx_pci_read_timeout_s cn58xx;
+	struct cvmx_pci_read_timeout_s cn58xxp1;
+} cvmx_pci_read_timeout_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pci_scm_reg_s {
+		uint64_t reserved_32_63:32;
+		uint64_t scm:32;
+	} s;
+	struct cvmx_pci_scm_reg_s cn30xx;
+	struct cvmx_pci_scm_reg_s cn31xx;
+	struct cvmx_pci_scm_reg_s cn38xx;
+	struct cvmx_pci_scm_reg_s cn38xxp2;
+	struct cvmx_pci_scm_reg_s cn50xx;
+	struct cvmx_pci_scm_reg_s cn58xx;
+	struct cvmx_pci_scm_reg_s cn58xxp1;
+} cvmx_pci_scm_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pci_tsr_reg_s {
+		uint64_t reserved_36_63:28;
+		uint64_t tsr:36;
+	} s;
+	struct cvmx_pci_tsr_reg_s cn30xx;
+	struct cvmx_pci_tsr_reg_s cn31xx;
+	struct cvmx_pci_tsr_reg_s cn38xx;
+	struct cvmx_pci_tsr_reg_s cn38xxp2;
+	struct cvmx_pci_tsr_reg_s cn50xx;
+	struct cvmx_pci_tsr_reg_s cn58xx;
+	struct cvmx_pci_tsr_reg_s cn58xxp1;
+} cvmx_pci_tsr_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pci_win_rd_addr_s {
+		uint64_t reserved_49_63:15;
+		uint64_t iobit:1;
+		uint64_t reserved_0_47:48;
+	} s;
+	struct cvmx_pci_win_rd_addr_cn30xx {
+		uint64_t reserved_49_63:15;
+		uint64_t iobit:1;
+		uint64_t rd_addr:46;
+		uint64_t reserved_0_1:2;
+	} cn30xx;
+	struct cvmx_pci_win_rd_addr_cn30xx cn31xx;
+	struct cvmx_pci_win_rd_addr_cn38xx {
+		uint64_t reserved_49_63:15;
+		uint64_t iobit:1;
+		uint64_t rd_addr:45;
+		uint64_t reserved_0_2:3;
+	} cn38xx;
+	struct cvmx_pci_win_rd_addr_cn38xx cn38xxp2;
+	struct cvmx_pci_win_rd_addr_cn30xx cn50xx;
+	struct cvmx_pci_win_rd_addr_cn38xx cn58xx;
+	struct cvmx_pci_win_rd_addr_cn38xx cn58xxp1;
+} cvmx_pci_win_rd_addr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pci_win_rd_data_s {
+		uint64_t rd_data:64;
+	} s;
+	struct cvmx_pci_win_rd_data_s cn30xx;
+	struct cvmx_pci_win_rd_data_s cn31xx;
+	struct cvmx_pci_win_rd_data_s cn38xx;
+	struct cvmx_pci_win_rd_data_s cn38xxp2;
+	struct cvmx_pci_win_rd_data_s cn50xx;
+	struct cvmx_pci_win_rd_data_s cn58xx;
+	struct cvmx_pci_win_rd_data_s cn58xxp1;
+} cvmx_pci_win_rd_data_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pci_win_wr_addr_s {
+		uint64_t reserved_49_63:15;
+		uint64_t iobit:1;
+		uint64_t wr_addr:45;
+		uint64_t reserved_0_2:3;
+	} s;
+	struct cvmx_pci_win_wr_addr_s cn30xx;
+	struct cvmx_pci_win_wr_addr_s cn31xx;
+	struct cvmx_pci_win_wr_addr_s cn38xx;
+	struct cvmx_pci_win_wr_addr_s cn38xxp2;
+	struct cvmx_pci_win_wr_addr_s cn50xx;
+	struct cvmx_pci_win_wr_addr_s cn58xx;
+	struct cvmx_pci_win_wr_addr_s cn58xxp1;
+} cvmx_pci_win_wr_addr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pci_win_wr_data_s {
+		uint64_t wr_data:64;
+	} s;
+	struct cvmx_pci_win_wr_data_s cn30xx;
+	struct cvmx_pci_win_wr_data_s cn31xx;
+	struct cvmx_pci_win_wr_data_s cn38xx;
+	struct cvmx_pci_win_wr_data_s cn38xxp2;
+	struct cvmx_pci_win_wr_data_s cn50xx;
+	struct cvmx_pci_win_wr_data_s cn58xx;
+	struct cvmx_pci_win_wr_data_s cn58xxp1;
+} cvmx_pci_win_wr_data_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pci_win_wr_mask_s {
+		uint64_t reserved_8_63:56;
+		uint64_t wr_mask:8;
+	} s;
+	struct cvmx_pci_win_wr_mask_s cn30xx;
+	struct cvmx_pci_win_wr_mask_s cn31xx;
+	struct cvmx_pci_win_wr_mask_s cn38xx;
+	struct cvmx_pci_win_wr_mask_s cn38xxp2;
+	struct cvmx_pci_win_wr_mask_s cn50xx;
+	struct cvmx_pci_win_wr_mask_s cn58xx;
+	struct cvmx_pci_win_wr_mask_s cn58xxp1;
+} cvmx_pci_win_wr_mask_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg000_s {
+		uint32_t devid:16;
+		uint32_t vendid:16;
+	} s;
+	struct cvmx_pcieep_cfg000_s cn52xx;
+	struct cvmx_pcieep_cfg000_s cn52xxp1;
+	struct cvmx_pcieep_cfg000_s cn56xx;
+	struct cvmx_pcieep_cfg000_s cn56xxp1;
+} cvmx_pcieep_cfg000_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg001_s {
+		uint32_t dpe:1;
+		uint32_t sse:1;
+		uint32_t rma:1;
+		uint32_t rta:1;
+		uint32_t sta:1;
+		uint32_t devt:2;
+		uint32_t mdpe:1;
+		uint32_t fbb:1;
+		uint32_t reserved_22_22:1;
+		uint32_t m66:1;
+		uint32_t cl:1;
+		uint32_t i_stat:1;
+		uint32_t reserved_11_18:8;
+		uint32_t i_dis:1;
+		uint32_t fbbe:1;
+		uint32_t see:1;
+		uint32_t ids_wcc:1;
+		uint32_t per:1;
+		uint32_t vps:1;
+		uint32_t mwice:1;
+		uint32_t scse:1;
+		uint32_t me:1;
+		uint32_t msae:1;
+		uint32_t isae:1;
+	} s;
+	struct cvmx_pcieep_cfg001_s cn52xx;
+	struct cvmx_pcieep_cfg001_s cn52xxp1;
+	struct cvmx_pcieep_cfg001_s cn56xx;
+	struct cvmx_pcieep_cfg001_s cn56xxp1;
+} cvmx_pcieep_cfg001_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg002_s {
+		uint32_t bcc:8;
+		uint32_t sc:8;
+		uint32_t pi:8;
+		uint32_t rid:8;
+	} s;
+	struct cvmx_pcieep_cfg002_s cn52xx;
+	struct cvmx_pcieep_cfg002_s cn52xxp1;
+	struct cvmx_pcieep_cfg002_s cn56xx;
+	struct cvmx_pcieep_cfg002_s cn56xxp1;
+} cvmx_pcieep_cfg002_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg003_s {
+		uint32_t bist:8;
+		uint32_t mfd:1;
+		uint32_t chf:7;
+		uint32_t lt:8;
+		uint32_t cls:8;
+	} s;
+	struct cvmx_pcieep_cfg003_s cn52xx;
+	struct cvmx_pcieep_cfg003_s cn52xxp1;
+	struct cvmx_pcieep_cfg003_s cn56xx;
+	struct cvmx_pcieep_cfg003_s cn56xxp1;
+} cvmx_pcieep_cfg003_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg004_s {
+		uint32_t lbab:18;
+		uint32_t reserved_4_13:10;
+		uint32_t pf:1;
+		uint32_t typ:2;
+		uint32_t mspc:1;
+	} s;
+	struct cvmx_pcieep_cfg004_s cn52xx;
+	struct cvmx_pcieep_cfg004_s cn52xxp1;
+	struct cvmx_pcieep_cfg004_s cn56xx;
+	struct cvmx_pcieep_cfg004_s cn56xxp1;
+} cvmx_pcieep_cfg004_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg004_mask_s {
+		uint32_t lmask:31;
+		uint32_t enb:1;
+	} s;
+	struct cvmx_pcieep_cfg004_mask_s cn52xx;
+	struct cvmx_pcieep_cfg004_mask_s cn52xxp1;
+	struct cvmx_pcieep_cfg004_mask_s cn56xx;
+	struct cvmx_pcieep_cfg004_mask_s cn56xxp1;
+} cvmx_pcieep_cfg004_mask_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg005_s {
+		uint32_t ubab:32;
+	} s;
+	struct cvmx_pcieep_cfg005_s cn52xx;
+	struct cvmx_pcieep_cfg005_s cn52xxp1;
+	struct cvmx_pcieep_cfg005_s cn56xx;
+	struct cvmx_pcieep_cfg005_s cn56xxp1;
+} cvmx_pcieep_cfg005_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg005_mask_s {
+		uint32_t umask:32;
+	} s;
+	struct cvmx_pcieep_cfg005_mask_s cn52xx;
+	struct cvmx_pcieep_cfg005_mask_s cn52xxp1;
+	struct cvmx_pcieep_cfg005_mask_s cn56xx;
+	struct cvmx_pcieep_cfg005_mask_s cn56xxp1;
+} cvmx_pcieep_cfg005_mask_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg006_s {
+		uint32_t lbab:6;
+		uint32_t reserved_4_25:22;
+		uint32_t pf:1;
+		uint32_t typ:2;
+		uint32_t mspc:1;
+	} s;
+	struct cvmx_pcieep_cfg006_s cn52xx;
+	struct cvmx_pcieep_cfg006_s cn52xxp1;
+	struct cvmx_pcieep_cfg006_s cn56xx;
+	struct cvmx_pcieep_cfg006_s cn56xxp1;
+} cvmx_pcieep_cfg006_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg006_mask_s {
+		uint32_t lmask:31;
+		uint32_t enb:1;
+	} s;
+	struct cvmx_pcieep_cfg006_mask_s cn52xx;
+	struct cvmx_pcieep_cfg006_mask_s cn52xxp1;
+	struct cvmx_pcieep_cfg006_mask_s cn56xx;
+	struct cvmx_pcieep_cfg006_mask_s cn56xxp1;
+} cvmx_pcieep_cfg006_mask_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg007_s {
+		uint32_t ubab:32;
+	} s;
+	struct cvmx_pcieep_cfg007_s cn52xx;
+	struct cvmx_pcieep_cfg007_s cn52xxp1;
+	struct cvmx_pcieep_cfg007_s cn56xx;
+	struct cvmx_pcieep_cfg007_s cn56xxp1;
+} cvmx_pcieep_cfg007_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg007_mask_s {
+		uint32_t umask:32;
+	} s;
+	struct cvmx_pcieep_cfg007_mask_s cn52xx;
+	struct cvmx_pcieep_cfg007_mask_s cn52xxp1;
+	struct cvmx_pcieep_cfg007_mask_s cn56xx;
+	struct cvmx_pcieep_cfg007_mask_s cn56xxp1;
+} cvmx_pcieep_cfg007_mask_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg008_s {
+		uint32_t reserved_4_31:28;
+		uint32_t pf:1;
+		uint32_t typ:2;
+		uint32_t mspc:1;
+	} s;
+	struct cvmx_pcieep_cfg008_s cn52xx;
+	struct cvmx_pcieep_cfg008_s cn52xxp1;
+	struct cvmx_pcieep_cfg008_s cn56xx;
+	struct cvmx_pcieep_cfg008_s cn56xxp1;
+} cvmx_pcieep_cfg008_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg008_mask_s {
+		uint32_t lmask:31;
+		uint32_t enb:1;
+	} s;
+	struct cvmx_pcieep_cfg008_mask_s cn52xx;
+	struct cvmx_pcieep_cfg008_mask_s cn52xxp1;
+	struct cvmx_pcieep_cfg008_mask_s cn56xx;
+	struct cvmx_pcieep_cfg008_mask_s cn56xxp1;
+} cvmx_pcieep_cfg008_mask_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg009_s {
+		uint32_t ubab:25;
+		uint32_t reserved_0_6:7;
+	} s;
+	struct cvmx_pcieep_cfg009_s cn52xx;
+	struct cvmx_pcieep_cfg009_s cn52xxp1;
+	struct cvmx_pcieep_cfg009_s cn56xx;
+	struct cvmx_pcieep_cfg009_s cn56xxp1;
+} cvmx_pcieep_cfg009_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg009_mask_s {
+		uint32_t umask:32;
+	} s;
+	struct cvmx_pcieep_cfg009_mask_s cn52xx;
+	struct cvmx_pcieep_cfg009_mask_s cn52xxp1;
+	struct cvmx_pcieep_cfg009_mask_s cn56xx;
+	struct cvmx_pcieep_cfg009_mask_s cn56xxp1;
+} cvmx_pcieep_cfg009_mask_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg010_s {
+		uint32_t cisp:32;
+	} s;
+	struct cvmx_pcieep_cfg010_s cn52xx;
+	struct cvmx_pcieep_cfg010_s cn52xxp1;
+	struct cvmx_pcieep_cfg010_s cn56xx;
+	struct cvmx_pcieep_cfg010_s cn56xxp1;
+} cvmx_pcieep_cfg010_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg011_s {
+		uint32_t ssid:16;
+		uint32_t ssvid:16;
+	} s;
+	struct cvmx_pcieep_cfg011_s cn52xx;
+	struct cvmx_pcieep_cfg011_s cn52xxp1;
+	struct cvmx_pcieep_cfg011_s cn56xx;
+	struct cvmx_pcieep_cfg011_s cn56xxp1;
+} cvmx_pcieep_cfg011_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg012_s {
+		uint32_t eraddr:16;
+		uint32_t reserved_1_15:15;
+		uint32_t er_en:1;
+	} s;
+	struct cvmx_pcieep_cfg012_s cn52xx;
+	struct cvmx_pcieep_cfg012_s cn52xxp1;
+	struct cvmx_pcieep_cfg012_s cn56xx;
+	struct cvmx_pcieep_cfg012_s cn56xxp1;
+} cvmx_pcieep_cfg012_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg012_mask_s {
+		uint32_t mask:31;
+		uint32_t enb:1;
+	} s;
+	struct cvmx_pcieep_cfg012_mask_s cn52xx;
+	struct cvmx_pcieep_cfg012_mask_s cn52xxp1;
+	struct cvmx_pcieep_cfg012_mask_s cn56xx;
+	struct cvmx_pcieep_cfg012_mask_s cn56xxp1;
+} cvmx_pcieep_cfg012_mask_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg013_s {
+		uint32_t reserved_8_31:24;
+		uint32_t cp:8;
+	} s;
+	struct cvmx_pcieep_cfg013_s cn52xx;
+	struct cvmx_pcieep_cfg013_s cn52xxp1;
+	struct cvmx_pcieep_cfg013_s cn56xx;
+	struct cvmx_pcieep_cfg013_s cn56xxp1;
+} cvmx_pcieep_cfg013_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg015_s {
+		uint32_t ml:8;
+		uint32_t mg:8;
+		uint32_t inta:8;
+		uint32_t il:8;
+	} s;
+	struct cvmx_pcieep_cfg015_s cn52xx;
+	struct cvmx_pcieep_cfg015_s cn52xxp1;
+	struct cvmx_pcieep_cfg015_s cn56xx;
+	struct cvmx_pcieep_cfg015_s cn56xxp1;
+} cvmx_pcieep_cfg015_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg016_s {
+		uint32_t pmes:5;
+		uint32_t d2s:1;
+		uint32_t d1s:1;
+		uint32_t auxc:3;
+		uint32_t dsi:1;
+		uint32_t reserved_20_20:1;
+		uint32_t pme_clock:1;
+		uint32_t pmsv:3;
+		uint32_t ncp:8;
+		uint32_t pmcid:8;
+	} s;
+	struct cvmx_pcieep_cfg016_s cn52xx;
+	struct cvmx_pcieep_cfg016_s cn52xxp1;
+	struct cvmx_pcieep_cfg016_s cn56xx;
+	struct cvmx_pcieep_cfg016_s cn56xxp1;
+} cvmx_pcieep_cfg016_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg017_s {
+		uint32_t pmdia:8;
+		uint32_t bpccee:1;
+		uint32_t bd3h:1;
+		uint32_t reserved_16_21:6;
+		uint32_t pmess:1;
+		uint32_t pmedsia:2;
+		uint32_t pmds:4;
+		uint32_t pmeens:1;
+		uint32_t reserved_4_7:4;
+		uint32_t nsr:1;
+		uint32_t reserved_2_2:1;
+		uint32_t ps:2;
+	} s;
+	struct cvmx_pcieep_cfg017_s cn52xx;
+	struct cvmx_pcieep_cfg017_s cn52xxp1;
+	struct cvmx_pcieep_cfg017_s cn56xx;
+	struct cvmx_pcieep_cfg017_s cn56xxp1;
+} cvmx_pcieep_cfg017_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg020_s {
+		uint32_t reserved_24_31:8;
+		uint32_t m64:1;
+		uint32_t mme:3;
+		uint32_t mmc:3;
+		uint32_t msien:1;
+		uint32_t ncp:8;
+		uint32_t msicid:8;
+	} s;
+	struct cvmx_pcieep_cfg020_s cn52xx;
+	struct cvmx_pcieep_cfg020_s cn52xxp1;
+	struct cvmx_pcieep_cfg020_s cn56xx;
+	struct cvmx_pcieep_cfg020_s cn56xxp1;
+} cvmx_pcieep_cfg020_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg021_s {
+		uint32_t lmsi:30;
+		uint32_t reserved_0_1:2;
+	} s;
+	struct cvmx_pcieep_cfg021_s cn52xx;
+	struct cvmx_pcieep_cfg021_s cn52xxp1;
+	struct cvmx_pcieep_cfg021_s cn56xx;
+	struct cvmx_pcieep_cfg021_s cn56xxp1;
+} cvmx_pcieep_cfg021_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg022_s {
+		uint32_t umsi:32;
+	} s;
+	struct cvmx_pcieep_cfg022_s cn52xx;
+	struct cvmx_pcieep_cfg022_s cn52xxp1;
+	struct cvmx_pcieep_cfg022_s cn56xx;
+	struct cvmx_pcieep_cfg022_s cn56xxp1;
+} cvmx_pcieep_cfg022_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg023_s {
+		uint32_t reserved_16_31:16;
+		uint32_t msimd:16;
+	} s;
+	struct cvmx_pcieep_cfg023_s cn52xx;
+	struct cvmx_pcieep_cfg023_s cn52xxp1;
+	struct cvmx_pcieep_cfg023_s cn56xx;
+	struct cvmx_pcieep_cfg023_s cn56xxp1;
+} cvmx_pcieep_cfg023_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg028_s {
+		uint32_t reserved_30_31:2;
+		uint32_t imn:5;
+		uint32_t si:1;
+		uint32_t dpt:4;
+		uint32_t pciecv:4;
+		uint32_t ncp:8;
+		uint32_t pcieid:8;
+	} s;
+	struct cvmx_pcieep_cfg028_s cn52xx;
+	struct cvmx_pcieep_cfg028_s cn52xxp1;
+	struct cvmx_pcieep_cfg028_s cn56xx;
+	struct cvmx_pcieep_cfg028_s cn56xxp1;
+} cvmx_pcieep_cfg028_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg029_s {
+		uint32_t reserved_28_31:4;
+		uint32_t cspls:2;
+		uint32_t csplv:8;
+		uint32_t reserved_16_17:2;
+		uint32_t rber:1;
+		uint32_t reserved_12_14:3;
+		uint32_t el1al:3;
+		uint32_t el0al:3;
+		uint32_t etfs:1;
+		uint32_t pfs:2;
+		uint32_t mpss:3;
+	} s;
+	struct cvmx_pcieep_cfg029_s cn52xx;
+	struct cvmx_pcieep_cfg029_s cn52xxp1;
+	struct cvmx_pcieep_cfg029_s cn56xx;
+	struct cvmx_pcieep_cfg029_s cn56xxp1;
+} cvmx_pcieep_cfg029_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg030_s {
+		uint32_t reserved_22_31:10;
+		uint32_t tp:1;
+		uint32_t ap_d:1;
+		uint32_t ur_d:1;
+		uint32_t fe_d:1;
+		uint32_t nfe_d:1;
+		uint32_t ce_d:1;
+		uint32_t reserved_15_15:1;
+		uint32_t mrrs:3;
+		uint32_t ns_en:1;
+		uint32_t ap_en:1;
+		uint32_t pf_en:1;
+		uint32_t etf_en:1;
+		uint32_t mps:3;
+		uint32_t ro_en:1;
+		uint32_t ur_en:1;
+		uint32_t fe_en:1;
+		uint32_t nfe_en:1;
+		uint32_t ce_en:1;
+	} s;
+	struct cvmx_pcieep_cfg030_s cn52xx;
+	struct cvmx_pcieep_cfg030_s cn52xxp1;
+	struct cvmx_pcieep_cfg030_s cn56xx;
+	struct cvmx_pcieep_cfg030_s cn56xxp1;
+} cvmx_pcieep_cfg030_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg031_s {
+		uint32_t pnum:8;
+		uint32_t reserved_22_23:2;
+		uint32_t lbnc:1;
+		uint32_t dllarc:1;
+		uint32_t sderc:1;
+		uint32_t cpm:1;
+		uint32_t l1el:3;
+		uint32_t l0el:3;
+		uint32_t aslpms:2;
+		uint32_t mlw:6;
+		uint32_t mls:4;
+	} s;
+	struct cvmx_pcieep_cfg031_s cn52xx;
+	struct cvmx_pcieep_cfg031_s cn52xxp1;
+	struct cvmx_pcieep_cfg031_s cn56xx;
+	struct cvmx_pcieep_cfg031_s cn56xxp1;
+} cvmx_pcieep_cfg031_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg032_s {
+		uint32_t reserved_30_31:2;
+		uint32_t dlla:1;
+		uint32_t scc:1;
+		uint32_t lt:1;
+		uint32_t reserved_26_26:1;
+		uint32_t nlw:6;
+		uint32_t ls:4;
+		uint32_t reserved_10_15:6;
+		uint32_t hawd:1;
+		uint32_t ecpm:1;
+		uint32_t es:1;
+		uint32_t ccc:1;
+		uint32_t rl:1;
+		uint32_t ld:1;
+		uint32_t rcb:1;
+		uint32_t reserved_2_2:1;
+		uint32_t aslpc:2;
+	} s;
+	struct cvmx_pcieep_cfg032_s cn52xx;
+	struct cvmx_pcieep_cfg032_s cn52xxp1;
+	struct cvmx_pcieep_cfg032_s cn56xx;
+	struct cvmx_pcieep_cfg032_s cn56xxp1;
+} cvmx_pcieep_cfg032_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg033_s {
+		uint32_t ps_num:13;
+		uint32_t nccs:1;
+		uint32_t emip:1;
+		uint32_t sp_ls:2;
+		uint32_t sp_lv:8;
+		uint32_t hp_c:1;
+		uint32_t hp_s:1;
+		uint32_t pip:1;
+		uint32_t aip:1;
+		uint32_t mrlsp:1;
+		uint32_t pcp:1;
+		uint32_t abp:1;
+	} s;
+	struct cvmx_pcieep_cfg033_s cn52xx;
+	struct cvmx_pcieep_cfg033_s cn52xxp1;
+	struct cvmx_pcieep_cfg033_s cn56xx;
+	struct cvmx_pcieep_cfg033_s cn56xxp1;
+} cvmx_pcieep_cfg033_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg034_s {
+		uint32_t reserved_25_31:7;
+		uint32_t dlls_c:1;
+		uint32_t emis:1;
+		uint32_t pds:1;
+		uint32_t mrlss:1;
+		uint32_t ccint_d:1;
+		uint32_t pd_c:1;
+		uint32_t mrls_c:1;
+		uint32_t pf_d:1;
+		uint32_t abp_d:1;
+		uint32_t reserved_13_15:3;
+		uint32_t dlls_en:1;
+		uint32_t emic:1;
+		uint32_t pcc:1;
+		uint32_t pic:2;
+		uint32_t aic:2;
+		uint32_t hpint_en:1;
+		uint32_t ccint_en:1;
+		uint32_t pd_en:1;
+		uint32_t mrls_en:1;
+		uint32_t pf_en:1;
+		uint32_t abp_en:1;
+	} s;
+	struct cvmx_pcieep_cfg034_s cn52xx;
+	struct cvmx_pcieep_cfg034_s cn52xxp1;
+	struct cvmx_pcieep_cfg034_s cn56xx;
+	struct cvmx_pcieep_cfg034_s cn56xxp1;
+} cvmx_pcieep_cfg034_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg037_s {
+		uint32_t reserved_5_31:27;
+		uint32_t ctds:1;
+		uint32_t ctrs:4;
+	} s;
+	struct cvmx_pcieep_cfg037_s cn52xx;
+	struct cvmx_pcieep_cfg037_s cn52xxp1;
+	struct cvmx_pcieep_cfg037_s cn56xx;
+	struct cvmx_pcieep_cfg037_s cn56xxp1;
+} cvmx_pcieep_cfg037_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg038_s {
+		uint32_t reserved_5_31:27;
+		uint32_t ctd:1;
+		uint32_t ctv:4;
+	} s;
+	struct cvmx_pcieep_cfg038_s cn52xx;
+	struct cvmx_pcieep_cfg038_s cn52xxp1;
+	struct cvmx_pcieep_cfg038_s cn56xx;
+	struct cvmx_pcieep_cfg038_s cn56xxp1;
+} cvmx_pcieep_cfg038_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg039_s {
+		uint32_t reserved_0_31:32;
+	} s;
+	struct cvmx_pcieep_cfg039_s cn52xx;
+	struct cvmx_pcieep_cfg039_s cn52xxp1;
+	struct cvmx_pcieep_cfg039_s cn56xx;
+	struct cvmx_pcieep_cfg039_s cn56xxp1;
+} cvmx_pcieep_cfg039_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg040_s {
+		uint32_t reserved_0_31:32;
+	} s;
+	struct cvmx_pcieep_cfg040_s cn52xx;
+	struct cvmx_pcieep_cfg040_s cn52xxp1;
+	struct cvmx_pcieep_cfg040_s cn56xx;
+	struct cvmx_pcieep_cfg040_s cn56xxp1;
+} cvmx_pcieep_cfg040_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg041_s {
+		uint32_t reserved_0_31:32;
+	} s;
+	struct cvmx_pcieep_cfg041_s cn52xx;
+	struct cvmx_pcieep_cfg041_s cn52xxp1;
+	struct cvmx_pcieep_cfg041_s cn56xx;
+	struct cvmx_pcieep_cfg041_s cn56xxp1;
+} cvmx_pcieep_cfg041_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg042_s {
+		uint32_t reserved_0_31:32;
+	} s;
+	struct cvmx_pcieep_cfg042_s cn52xx;
+	struct cvmx_pcieep_cfg042_s cn52xxp1;
+	struct cvmx_pcieep_cfg042_s cn56xx;
+	struct cvmx_pcieep_cfg042_s cn56xxp1;
+} cvmx_pcieep_cfg042_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg064_s {
+		uint32_t nco:12;
+		uint32_t cv:4;
+		uint32_t pcieec:16;
+	} s;
+	struct cvmx_pcieep_cfg064_s cn52xx;
+	struct cvmx_pcieep_cfg064_s cn52xxp1;
+	struct cvmx_pcieep_cfg064_s cn56xx;
+	struct cvmx_pcieep_cfg064_s cn56xxp1;
+} cvmx_pcieep_cfg064_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg065_s {
+		uint32_t reserved_21_31:11;
+		uint32_t ures:1;
+		uint32_t ecrces:1;
+		uint32_t mtlps:1;
+		uint32_t ros:1;
+		uint32_t ucs:1;
+		uint32_t cas:1;
+		uint32_t cts:1;
+		uint32_t fcpes:1;
+		uint32_t ptlps:1;
+		uint32_t reserved_6_11:6;
+		uint32_t sdes:1;
+		uint32_t dlpes:1;
+		uint32_t reserved_0_3:4;
+	} s;
+	struct cvmx_pcieep_cfg065_s cn52xx;
+	struct cvmx_pcieep_cfg065_s cn52xxp1;
+	struct cvmx_pcieep_cfg065_s cn56xx;
+	struct cvmx_pcieep_cfg065_s cn56xxp1;
+} cvmx_pcieep_cfg065_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg066_s {
+		uint32_t reserved_21_31:11;
+		uint32_t urem:1;
+		uint32_t ecrcem:1;
+		uint32_t mtlpm:1;
+		uint32_t rom:1;
+		uint32_t ucm:1;
+		uint32_t cam:1;
+		uint32_t ctm:1;
+		uint32_t fcpem:1;
+		uint32_t ptlpm:1;
+		uint32_t reserved_6_11:6;
+		uint32_t sdem:1;
+		uint32_t dlpem:1;
+		uint32_t reserved_0_3:4;
+	} s;
+	struct cvmx_pcieep_cfg066_s cn52xx;
+	struct cvmx_pcieep_cfg066_s cn52xxp1;
+	struct cvmx_pcieep_cfg066_s cn56xx;
+	struct cvmx_pcieep_cfg066_s cn56xxp1;
+} cvmx_pcieep_cfg066_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg067_s {
+		uint32_t reserved_21_31:11;
+		uint32_t ures:1;
+		uint32_t ecrces:1;
+		uint32_t mtlps:1;
+		uint32_t ros:1;
+		uint32_t ucs:1;
+		uint32_t cas:1;
+		uint32_t cts:1;
+		uint32_t fcpes:1;
+		uint32_t ptlps:1;
+		uint32_t reserved_6_11:6;
+		uint32_t sdes:1;
+		uint32_t dlpes:1;
+		uint32_t reserved_0_3:4;
+	} s;
+	struct cvmx_pcieep_cfg067_s cn52xx;
+	struct cvmx_pcieep_cfg067_s cn52xxp1;
+	struct cvmx_pcieep_cfg067_s cn56xx;
+	struct cvmx_pcieep_cfg067_s cn56xxp1;
+} cvmx_pcieep_cfg067_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg068_s {
+		uint32_t reserved_14_31:18;
+		uint32_t anfes:1;
+		uint32_t rtts:1;
+		uint32_t reserved_9_11:3;
+		uint32_t rnrs:1;
+		uint32_t bdllps:1;
+		uint32_t btlps:1;
+		uint32_t reserved_1_5:5;
+		uint32_t res:1;
+	} s;
+	struct cvmx_pcieep_cfg068_s cn52xx;
+	struct cvmx_pcieep_cfg068_s cn52xxp1;
+	struct cvmx_pcieep_cfg068_s cn56xx;
+	struct cvmx_pcieep_cfg068_s cn56xxp1;
+} cvmx_pcieep_cfg068_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg069_s {
+		uint32_t reserved_14_31:18;
+		uint32_t anfem:1;
+		uint32_t rttm:1;
+		uint32_t reserved_9_11:3;
+		uint32_t rnrm:1;
+		uint32_t bdllpm:1;
+		uint32_t btlpm:1;
+		uint32_t reserved_1_5:5;
+		uint32_t rem:1;
+	} s;
+	struct cvmx_pcieep_cfg069_s cn52xx;
+	struct cvmx_pcieep_cfg069_s cn52xxp1;
+	struct cvmx_pcieep_cfg069_s cn56xx;
+	struct cvmx_pcieep_cfg069_s cn56xxp1;
+} cvmx_pcieep_cfg069_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg070_s {
+		uint32_t reserved_9_31:23;
+		uint32_t ce:1;
+		uint32_t cc:1;
+		uint32_t ge:1;
+		uint32_t gc:1;
+		uint32_t fep:5;
+	} s;
+	struct cvmx_pcieep_cfg070_s cn52xx;
+	struct cvmx_pcieep_cfg070_s cn52xxp1;
+	struct cvmx_pcieep_cfg070_s cn56xx;
+	struct cvmx_pcieep_cfg070_s cn56xxp1;
+} cvmx_pcieep_cfg070_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg071_s {
+		uint32_t dword1:32;
+	} s;
+	struct cvmx_pcieep_cfg071_s cn52xx;
+	struct cvmx_pcieep_cfg071_s cn52xxp1;
+	struct cvmx_pcieep_cfg071_s cn56xx;
+	struct cvmx_pcieep_cfg071_s cn56xxp1;
+} cvmx_pcieep_cfg071_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg072_s {
+		uint32_t dword2:32;
+	} s;
+	struct cvmx_pcieep_cfg072_s cn52xx;
+	struct cvmx_pcieep_cfg072_s cn52xxp1;
+	struct cvmx_pcieep_cfg072_s cn56xx;
+	struct cvmx_pcieep_cfg072_s cn56xxp1;
+} cvmx_pcieep_cfg072_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg073_s {
+		uint32_t dword3:32;
+	} s;
+	struct cvmx_pcieep_cfg073_s cn52xx;
+	struct cvmx_pcieep_cfg073_s cn52xxp1;
+	struct cvmx_pcieep_cfg073_s cn56xx;
+	struct cvmx_pcieep_cfg073_s cn56xxp1;
+} cvmx_pcieep_cfg073_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg074_s {
+		uint32_t dword4:32;
+	} s;
+	struct cvmx_pcieep_cfg074_s cn52xx;
+	struct cvmx_pcieep_cfg074_s cn52xxp1;
+	struct cvmx_pcieep_cfg074_s cn56xx;
+	struct cvmx_pcieep_cfg074_s cn56xxp1;
+} cvmx_pcieep_cfg074_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg448_s {
+		uint32_t rtl:16;
+		uint32_t rtltl:16;
+	} s;
+	struct cvmx_pcieep_cfg448_s cn52xx;
+	struct cvmx_pcieep_cfg448_s cn52xxp1;
+	struct cvmx_pcieep_cfg448_s cn56xx;
+	struct cvmx_pcieep_cfg448_s cn56xxp1;
+} cvmx_pcieep_cfg448_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg449_s {
+		uint32_t omr:32;
+	} s;
+	struct cvmx_pcieep_cfg449_s cn52xx;
+	struct cvmx_pcieep_cfg449_s cn52xxp1;
+	struct cvmx_pcieep_cfg449_s cn56xx;
+	struct cvmx_pcieep_cfg449_s cn56xxp1;
+} cvmx_pcieep_cfg449_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg450_s {
+		uint32_t lpec:8;
+		uint32_t reserved_22_23:2;
+		uint32_t link_state:6;
+		uint32_t force_link:1;
+		uint32_t reserved_8_14:7;
+		uint32_t link_num:8;
+	} s;
+	struct cvmx_pcieep_cfg450_s cn52xx;
+	struct cvmx_pcieep_cfg450_s cn52xxp1;
+	struct cvmx_pcieep_cfg450_s cn56xx;
+	struct cvmx_pcieep_cfg450_s cn56xxp1;
+} cvmx_pcieep_cfg450_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg451_s {
+		uint32_t reserved_30_31:2;
+		uint32_t l1el:3;
+		uint32_t l0el:3;
+		uint32_t n_fts_cc:8;
+		uint32_t n_fts:8;
+		uint32_t ack_freq:8;
+	} s;
+	struct cvmx_pcieep_cfg451_s cn52xx;
+	struct cvmx_pcieep_cfg451_s cn52xxp1;
+	struct cvmx_pcieep_cfg451_s cn56xx;
+	struct cvmx_pcieep_cfg451_s cn56xxp1;
+} cvmx_pcieep_cfg451_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg452_s {
+		uint32_t reserved_26_31:6;
+		uint32_t eccrc:1;
+		uint32_t reserved_22_24:3;
+		uint32_t lme:6;
+		uint32_t reserved_8_15:8;
+		uint32_t flm:1;
+		uint32_t reserved_6_6:1;
+		uint32_t dllle:1;
+		uint32_t reserved_4_4:1;
+		uint32_t ra:1;
+		uint32_t le:1;
+		uint32_t sd:1;
+		uint32_t omr:1;
+	} s;
+	struct cvmx_pcieep_cfg452_s cn52xx;
+	struct cvmx_pcieep_cfg452_s cn52xxp1;
+	struct cvmx_pcieep_cfg452_s cn56xx;
+	struct cvmx_pcieep_cfg452_s cn56xxp1;
+} cvmx_pcieep_cfg452_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg453_s {
+		uint32_t dlld:1;
+		uint32_t reserved_26_30:5;
+		uint32_t ack_nak:1;
+		uint32_t fcd:1;
+		uint32_t ilst:24;
+	} s;
+	struct cvmx_pcieep_cfg453_s cn52xx;
+	struct cvmx_pcieep_cfg453_s cn52xxp1;
+	struct cvmx_pcieep_cfg453_s cn56xx;
+	struct cvmx_pcieep_cfg453_s cn56xxp1;
+} cvmx_pcieep_cfg453_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg454_s {
+		uint32_t reserved_29_31:3;
+		uint32_t tmfcwt:5;
+		uint32_t tmanlt:5;
+		uint32_t tmrt:5;
+		uint32_t reserved_11_13:3;
+		uint32_t nskps:3;
+		uint32_t reserved_4_7:4;
+		uint32_t ntss:4;
+	} s;
+	struct cvmx_pcieep_cfg454_s cn52xx;
+	struct cvmx_pcieep_cfg454_s cn52xxp1;
+	struct cvmx_pcieep_cfg454_s cn56xx;
+	struct cvmx_pcieep_cfg454_s cn56xxp1;
+} cvmx_pcieep_cfg454_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg455_s {
+		uint32_t m_cfg0_filt:1;
+		uint32_t m_io_filt:1;
+		uint32_t msg_ctrl:1;
+		uint32_t m_cpl_ecrc_filt:1;
+		uint32_t m_ecrc_filt:1;
+		uint32_t m_cpl_len_err:1;
+		uint32_t m_cpl_attr_err:1;
+		uint32_t m_cpl_tc_err:1;
+		uint32_t m_cpl_fun_err:1;
+		uint32_t m_cpl_rid_err:1;
+		uint32_t m_cpl_tag_err:1;
+		uint32_t m_lk_filt:1;
+		uint32_t m_cfg1_filt:1;
+		uint32_t m_bar_match:1;
+		uint32_t m_pois_filt:1;
+		uint32_t m_fun:1;
+		uint32_t dfcwt:1;
+		uint32_t reserved_11_14:4;
+		uint32_t skpiv:11;
+	} s;
+	struct cvmx_pcieep_cfg455_s cn52xx;
+	struct cvmx_pcieep_cfg455_s cn52xxp1;
+	struct cvmx_pcieep_cfg455_s cn56xx;
+	struct cvmx_pcieep_cfg455_s cn56xxp1;
+} cvmx_pcieep_cfg455_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg456_s {
+		uint32_t reserved_2_31:30;
+		uint32_t m_vend1_drp:1;
+		uint32_t m_vend0_drp:1;
+	} s;
+	struct cvmx_pcieep_cfg456_s cn52xx;
+	struct cvmx_pcieep_cfg456_s cn52xxp1;
+	struct cvmx_pcieep_cfg456_s cn56xx;
+	struct cvmx_pcieep_cfg456_s cn56xxp1;
+} cvmx_pcieep_cfg456_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg458_s {
+		uint32_t dbg_info_l32:32;
+	} s;
+	struct cvmx_pcieep_cfg458_s cn52xx;
+	struct cvmx_pcieep_cfg458_s cn52xxp1;
+	struct cvmx_pcieep_cfg458_s cn56xx;
+	struct cvmx_pcieep_cfg458_s cn56xxp1;
+} cvmx_pcieep_cfg458_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg459_s {
+		uint32_t dbg_info_u32:32;
+	} s;
+	struct cvmx_pcieep_cfg459_s cn52xx;
+	struct cvmx_pcieep_cfg459_s cn52xxp1;
+	struct cvmx_pcieep_cfg459_s cn56xx;
+	struct cvmx_pcieep_cfg459_s cn56xxp1;
+} cvmx_pcieep_cfg459_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg460_s {
+		uint32_t reserved_20_31:12;
+		uint32_t tphfcc:8;
+		uint32_t tpdfcc:12;
+	} s;
+	struct cvmx_pcieep_cfg460_s cn52xx;
+	struct cvmx_pcieep_cfg460_s cn52xxp1;
+	struct cvmx_pcieep_cfg460_s cn56xx;
+	struct cvmx_pcieep_cfg460_s cn56xxp1;
+} cvmx_pcieep_cfg460_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg461_s {
+		uint32_t reserved_20_31:12;
+		uint32_t tchfcc:8;
+		uint32_t tcdfcc:12;
+	} s;
+	struct cvmx_pcieep_cfg461_s cn52xx;
+	struct cvmx_pcieep_cfg461_s cn52xxp1;
+	struct cvmx_pcieep_cfg461_s cn56xx;
+	struct cvmx_pcieep_cfg461_s cn56xxp1;
+} cvmx_pcieep_cfg461_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg462_s {
+		uint32_t reserved_20_31:12;
+		uint32_t tchfcc:8;
+		uint32_t tcdfcc:12;
+	} s;
+	struct cvmx_pcieep_cfg462_s cn52xx;
+	struct cvmx_pcieep_cfg462_s cn52xxp1;
+	struct cvmx_pcieep_cfg462_s cn56xx;
+	struct cvmx_pcieep_cfg462_s cn56xxp1;
+} cvmx_pcieep_cfg462_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg463_s {
+		uint32_t reserved_3_31:29;
+		uint32_t rqne:1;
+		uint32_t trbne:1;
+		uint32_t rtlpfccnr:1;
+	} s;
+	struct cvmx_pcieep_cfg463_s cn52xx;
+	struct cvmx_pcieep_cfg463_s cn52xxp1;
+	struct cvmx_pcieep_cfg463_s cn56xx;
+	struct cvmx_pcieep_cfg463_s cn56xxp1;
+} cvmx_pcieep_cfg463_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg464_s {
+		uint32_t wrr_vc3:8;
+		uint32_t wrr_vc2:8;
+		uint32_t wrr_vc1:8;
+		uint32_t wrr_vc0:8;
+	} s;
+	struct cvmx_pcieep_cfg464_s cn52xx;
+	struct cvmx_pcieep_cfg464_s cn52xxp1;
+	struct cvmx_pcieep_cfg464_s cn56xx;
+	struct cvmx_pcieep_cfg464_s cn56xxp1;
+} cvmx_pcieep_cfg464_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg465_s {
+		uint32_t wrr_vc7:8;
+		uint32_t wrr_vc6:8;
+		uint32_t wrr_vc5:8;
+		uint32_t wrr_vc4:8;
+	} s;
+	struct cvmx_pcieep_cfg465_s cn52xx;
+	struct cvmx_pcieep_cfg465_s cn52xxp1;
+	struct cvmx_pcieep_cfg465_s cn56xx;
+	struct cvmx_pcieep_cfg465_s cn56xxp1;
+} cvmx_pcieep_cfg465_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg466_s {
+		uint32_t rx_queue_order:1;
+		uint32_t type_ordering:1;
+		uint32_t reserved_24_29:6;
+		uint32_t queue_mode:3;
+		uint32_t reserved_20_20:1;
+		uint32_t header_credits:8;
+		uint32_t data_credits:12;
+	} s;
+	struct cvmx_pcieep_cfg466_s cn52xx;
+	struct cvmx_pcieep_cfg466_s cn52xxp1;
+	struct cvmx_pcieep_cfg466_s cn56xx;
+	struct cvmx_pcieep_cfg466_s cn56xxp1;
+} cvmx_pcieep_cfg466_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg467_s {
+		uint32_t reserved_24_31:8;
+		uint32_t queue_mode:3;
+		uint32_t reserved_20_20:1;
+		uint32_t header_credits:8;
+		uint32_t data_credits:12;
+	} s;
+	struct cvmx_pcieep_cfg467_s cn52xx;
+	struct cvmx_pcieep_cfg467_s cn52xxp1;
+	struct cvmx_pcieep_cfg467_s cn56xx;
+	struct cvmx_pcieep_cfg467_s cn56xxp1;
+} cvmx_pcieep_cfg467_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg468_s {
+		uint32_t reserved_24_31:8;
+		uint32_t queue_mode:3;
+		uint32_t reserved_20_20:1;
+		uint32_t header_credits:8;
+		uint32_t data_credits:12;
+	} s;
+	struct cvmx_pcieep_cfg468_s cn52xx;
+	struct cvmx_pcieep_cfg468_s cn52xxp1;
+	struct cvmx_pcieep_cfg468_s cn56xx;
+	struct cvmx_pcieep_cfg468_s cn56xxp1;
+} cvmx_pcieep_cfg468_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg490_s {
+		uint32_t reserved_26_31:6;
+		uint32_t header_depth:10;
+		uint32_t reserved_14_15:2;
+		uint32_t data_depth:14;
+	} s;
+	struct cvmx_pcieep_cfg490_s cn52xx;
+	struct cvmx_pcieep_cfg490_s cn52xxp1;
+	struct cvmx_pcieep_cfg490_s cn56xx;
+	struct cvmx_pcieep_cfg490_s cn56xxp1;
+} cvmx_pcieep_cfg490_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg491_s {
+		uint32_t reserved_26_31:6;
+		uint32_t header_depth:10;
+		uint32_t reserved_14_15:2;
+		uint32_t data_depth:14;
+	} s;
+	struct cvmx_pcieep_cfg491_s cn52xx;
+	struct cvmx_pcieep_cfg491_s cn52xxp1;
+	struct cvmx_pcieep_cfg491_s cn56xx;
+	struct cvmx_pcieep_cfg491_s cn56xxp1;
+} cvmx_pcieep_cfg491_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg492_s {
+		uint32_t reserved_26_31:6;
+		uint32_t header_depth:10;
+		uint32_t reserved_14_15:2;
+		uint32_t data_depth:14;
+	} s;
+	struct cvmx_pcieep_cfg492_s cn52xx;
+	struct cvmx_pcieep_cfg492_s cn52xxp1;
+	struct cvmx_pcieep_cfg492_s cn56xx;
+	struct cvmx_pcieep_cfg492_s cn56xxp1;
+} cvmx_pcieep_cfg492_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg516_s {
+		uint32_t phy_stat:32;
+	} s;
+	struct cvmx_pcieep_cfg516_s cn52xx;
+	struct cvmx_pcieep_cfg516_s cn52xxp1;
+	struct cvmx_pcieep_cfg516_s cn56xx;
+	struct cvmx_pcieep_cfg516_s cn56xxp1;
+} cvmx_pcieep_cfg516_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg517_s {
+		uint32_t phy_ctrl:32;
+	} s;
+	struct cvmx_pcieep_cfg517_s cn52xx;
+	struct cvmx_pcieep_cfg517_s cn52xxp1;
+	struct cvmx_pcieep_cfg517_s cn56xx;
+	struct cvmx_pcieep_cfg517_s cn56xxp1;
+} cvmx_pcieep_cfg517_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg000_s {
+		uint32_t devid:16;
+		uint32_t vendid:16;
+	} s;
+	struct cvmx_pciercx_cfg000_s cn52xx;
+	struct cvmx_pciercx_cfg000_s cn52xxp1;
+	struct cvmx_pciercx_cfg000_s cn56xx;
+	struct cvmx_pciercx_cfg000_s cn56xxp1;
+} cvmx_pciercx_cfg000_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg001_s {
+		uint32_t dpe:1;
+		uint32_t sse:1;
+		uint32_t rma:1;
+		uint32_t rta:1;
+		uint32_t sta:1;
+		uint32_t devt:2;
+		uint32_t mdpe:1;
+		uint32_t fbb:1;
+		uint32_t reserved_22_22:1;
+		uint32_t m66:1;
+		uint32_t cl:1;
+		uint32_t i_stat:1;
+		uint32_t reserved_11_18:8;
+		uint32_t i_dis:1;
+		uint32_t fbbe:1;
+		uint32_t see:1;
+		uint32_t ids_wcc:1;
+		uint32_t per:1;
+		uint32_t vps:1;
+		uint32_t mwice:1;
+		uint32_t scse:1;
+		uint32_t me:1;
+		uint32_t msae:1;
+		uint32_t isae:1;
+	} s;
+	struct cvmx_pciercx_cfg001_s cn52xx;
+	struct cvmx_pciercx_cfg001_s cn52xxp1;
+	struct cvmx_pciercx_cfg001_s cn56xx;
+	struct cvmx_pciercx_cfg001_s cn56xxp1;
+} cvmx_pciercx_cfg001_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg002_s {
+		uint32_t bcc:8;
+		uint32_t sc:8;
+		uint32_t pi:8;
+		uint32_t rid:8;
+	} s;
+	struct cvmx_pciercx_cfg002_s cn52xx;
+	struct cvmx_pciercx_cfg002_s cn52xxp1;
+	struct cvmx_pciercx_cfg002_s cn56xx;
+	struct cvmx_pciercx_cfg002_s cn56xxp1;
+} cvmx_pciercx_cfg002_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg003_s {
+		uint32_t bist:8;
+		uint32_t mfd:1;
+		uint32_t chf:7;
+		uint32_t lt:8;
+		uint32_t cls:8;
+	} s;
+	struct cvmx_pciercx_cfg003_s cn52xx;
+	struct cvmx_pciercx_cfg003_s cn52xxp1;
+	struct cvmx_pciercx_cfg003_s cn56xx;
+	struct cvmx_pciercx_cfg003_s cn56xxp1;
+} cvmx_pciercx_cfg003_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg004_s {
+		uint32_t reserved_0_31:32;
+	} s;
+	struct cvmx_pciercx_cfg004_s cn52xx;
+	struct cvmx_pciercx_cfg004_s cn52xxp1;
+	struct cvmx_pciercx_cfg004_s cn56xx;
+	struct cvmx_pciercx_cfg004_s cn56xxp1;
+} cvmx_pciercx_cfg004_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg005_s {
+		uint32_t reserved_0_31:32;
+	} s;
+	struct cvmx_pciercx_cfg005_s cn52xx;
+	struct cvmx_pciercx_cfg005_s cn52xxp1;
+	struct cvmx_pciercx_cfg005_s cn56xx;
+	struct cvmx_pciercx_cfg005_s cn56xxp1;
+} cvmx_pciercx_cfg005_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg006_s {
+		uint32_t slt:8;
+		uint32_t subbnum:8;
+		uint32_t sbnum:8;
+		uint32_t pbnum:8;
+	} s;
+	struct cvmx_pciercx_cfg006_s cn52xx;
+	struct cvmx_pciercx_cfg006_s cn52xxp1;
+	struct cvmx_pciercx_cfg006_s cn56xx;
+	struct cvmx_pciercx_cfg006_s cn56xxp1;
+} cvmx_pciercx_cfg006_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg007_s {
+		uint32_t dpe:1;
+		uint32_t sse:1;
+		uint32_t rma:1;
+		uint32_t rta:1;
+		uint32_t sta:1;
+		uint32_t devt:2;
+		uint32_t mdpe:1;
+		uint32_t fbb:1;
+		uint32_t reserved_22_22:1;
+		uint32_t m66:1;
+		uint32_t reserved_16_20:5;
+		uint32_t lio_limi:4;
+		uint32_t reserved_9_11:3;
+		uint32_t io32b:1;
+		uint32_t lio_base:4;
+		uint32_t reserved_1_3:3;
+		uint32_t io32a:1;
+	} s;
+	struct cvmx_pciercx_cfg007_s cn52xx;
+	struct cvmx_pciercx_cfg007_s cn52xxp1;
+	struct cvmx_pciercx_cfg007_s cn56xx;
+	struct cvmx_pciercx_cfg007_s cn56xxp1;
+} cvmx_pciercx_cfg007_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg008_s {
+		uint32_t ml_addr:12;
+		uint32_t reserved_16_19:4;
+		uint32_t mb_addr:12;
+		uint32_t reserved_0_3:4;
+	} s;
+	struct cvmx_pciercx_cfg008_s cn52xx;
+	struct cvmx_pciercx_cfg008_s cn52xxp1;
+	struct cvmx_pciercx_cfg008_s cn56xx;
+	struct cvmx_pciercx_cfg008_s cn56xxp1;
+} cvmx_pciercx_cfg008_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg009_s {
+		uint32_t lmem_limit:12;
+		uint32_t reserved_17_19:3;
+		uint32_t mem64b:1;
+		uint32_t lmem_base:12;
+		uint32_t reserved_1_3:3;
+		uint32_t mem64a:1;
+	} s;
+	struct cvmx_pciercx_cfg009_s cn52xx;
+	struct cvmx_pciercx_cfg009_s cn52xxp1;
+	struct cvmx_pciercx_cfg009_s cn56xx;
+	struct cvmx_pciercx_cfg009_s cn56xxp1;
+} cvmx_pciercx_cfg009_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg010_s {
+		uint32_t umem_base:32;
+	} s;
+	struct cvmx_pciercx_cfg010_s cn52xx;
+	struct cvmx_pciercx_cfg010_s cn52xxp1;
+	struct cvmx_pciercx_cfg010_s cn56xx;
+	struct cvmx_pciercx_cfg010_s cn56xxp1;
+} cvmx_pciercx_cfg010_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg011_s {
+		uint32_t umem_limit:32;
+	} s;
+	struct cvmx_pciercx_cfg011_s cn52xx;
+	struct cvmx_pciercx_cfg011_s cn52xxp1;
+	struct cvmx_pciercx_cfg011_s cn56xx;
+	struct cvmx_pciercx_cfg011_s cn56xxp1;
+} cvmx_pciercx_cfg011_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg012_s {
+		uint32_t uio_limit:16;
+		uint32_t uio_base:16;
+	} s;
+	struct cvmx_pciercx_cfg012_s cn52xx;
+	struct cvmx_pciercx_cfg012_s cn52xxp1;
+	struct cvmx_pciercx_cfg012_s cn56xx;
+	struct cvmx_pciercx_cfg012_s cn56xxp1;
+} cvmx_pciercx_cfg012_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg013_s {
+		uint32_t reserved_8_31:24;
+		uint32_t cp:8;
+	} s;
+	struct cvmx_pciercx_cfg013_s cn52xx;
+	struct cvmx_pciercx_cfg013_s cn52xxp1;
+	struct cvmx_pciercx_cfg013_s cn56xx;
+	struct cvmx_pciercx_cfg013_s cn56xxp1;
+} cvmx_pciercx_cfg013_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg014_s {
+		uint32_t reserved_0_31:32;
+	} s;
+	struct cvmx_pciercx_cfg014_s cn52xx;
+	struct cvmx_pciercx_cfg014_s cn52xxp1;
+	struct cvmx_pciercx_cfg014_s cn56xx;
+	struct cvmx_pciercx_cfg014_s cn56xxp1;
+} cvmx_pciercx_cfg014_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg015_s {
+		uint32_t reserved_28_31:4;
+		uint32_t dtsees:1;
+		uint32_t dts:1;
+		uint32_t sdt:1;
+		uint32_t pdt:1;
+		uint32_t fbbe:1;
+		uint32_t sbrst:1;
+		uint32_t mam:1;
+		uint32_t vga16d:1;
+		uint32_t vgae:1;
+		uint32_t isae:1;
+		uint32_t see:1;
+		uint32_t pere:1;
+		uint32_t inta:8;
+		uint32_t il:8;
+	} s;
+	struct cvmx_pciercx_cfg015_s cn52xx;
+	struct cvmx_pciercx_cfg015_s cn52xxp1;
+	struct cvmx_pciercx_cfg015_s cn56xx;
+	struct cvmx_pciercx_cfg015_s cn56xxp1;
+} cvmx_pciercx_cfg015_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg016_s {
+		uint32_t pmes:5;
+		uint32_t d2s:1;
+		uint32_t d1s:1;
+		uint32_t auxc:3;
+		uint32_t dsi:1;
+		uint32_t reserved_20_20:1;
+		uint32_t pme_clock:1;
+		uint32_t pmsv:3;
+		uint32_t ncp:8;
+		uint32_t pmcid:8;
+	} s;
+	struct cvmx_pciercx_cfg016_s cn52xx;
+	struct cvmx_pciercx_cfg016_s cn52xxp1;
+	struct cvmx_pciercx_cfg016_s cn56xx;
+	struct cvmx_pciercx_cfg016_s cn56xxp1;
+} cvmx_pciercx_cfg016_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg017_s {
+		uint32_t pmdia:8;
+		uint32_t bpccee:1;
+		uint32_t bd3h:1;
+		uint32_t reserved_16_21:6;
+		uint32_t pmess:1;
+		uint32_t pmedsia:2;
+		uint32_t pmds:4;
+		uint32_t pmeens:1;
+		uint32_t reserved_4_7:4;
+		uint32_t nsr:1;
+		uint32_t reserved_2_2:1;
+		uint32_t ps:2;
+	} s;
+	struct cvmx_pciercx_cfg017_s cn52xx;
+	struct cvmx_pciercx_cfg017_s cn52xxp1;
+	struct cvmx_pciercx_cfg017_s cn56xx;
+	struct cvmx_pciercx_cfg017_s cn56xxp1;
+} cvmx_pciercx_cfg017_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg020_s {
+		uint32_t reserved_24_31:8;
+		uint32_t m64:1;
+		uint32_t mme:3;
+		uint32_t mmc:3;
+		uint32_t msien:1;
+		uint32_t ncp:8;
+		uint32_t msicid:8;
+	} s;
+	struct cvmx_pciercx_cfg020_s cn52xx;
+	struct cvmx_pciercx_cfg020_s cn52xxp1;
+	struct cvmx_pciercx_cfg020_s cn56xx;
+	struct cvmx_pciercx_cfg020_s cn56xxp1;
+} cvmx_pciercx_cfg020_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg021_s {
+		uint32_t lmsi:30;
+		uint32_t reserved_0_1:2;
+	} s;
+	struct cvmx_pciercx_cfg021_s cn52xx;
+	struct cvmx_pciercx_cfg021_s cn52xxp1;
+	struct cvmx_pciercx_cfg021_s cn56xx;
+	struct cvmx_pciercx_cfg021_s cn56xxp1;
+} cvmx_pciercx_cfg021_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg022_s {
+		uint32_t umsi:32;
+	} s;
+	struct cvmx_pciercx_cfg022_s cn52xx;
+	struct cvmx_pciercx_cfg022_s cn52xxp1;
+	struct cvmx_pciercx_cfg022_s cn56xx;
+	struct cvmx_pciercx_cfg022_s cn56xxp1;
+} cvmx_pciercx_cfg022_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg023_s {
+		uint32_t reserved_16_31:16;
+		uint32_t msimd:16;
+	} s;
+	struct cvmx_pciercx_cfg023_s cn52xx;
+	struct cvmx_pciercx_cfg023_s cn52xxp1;
+	struct cvmx_pciercx_cfg023_s cn56xx;
+	struct cvmx_pciercx_cfg023_s cn56xxp1;
+} cvmx_pciercx_cfg023_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg028_s {
+		uint32_t reserved_30_31:2;
+		uint32_t imn:5;
+		uint32_t si:1;
+		uint32_t dpt:4;
+		uint32_t pciecv:4;
+		uint32_t ncp:8;
+		uint32_t pcieid:8;
+	} s;
+	struct cvmx_pciercx_cfg028_s cn52xx;
+	struct cvmx_pciercx_cfg028_s cn52xxp1;
+	struct cvmx_pciercx_cfg028_s cn56xx;
+	struct cvmx_pciercx_cfg028_s cn56xxp1;
+} cvmx_pciercx_cfg028_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg029_s {
+		uint32_t reserved_28_31:4;
+		uint32_t cspls:2;
+		uint32_t csplv:8;
+		uint32_t reserved_16_17:2;
+		uint32_t rber:1;
+		uint32_t reserved_12_14:3;
+		uint32_t el1al:3;
+		uint32_t el0al:3;
+		uint32_t etfs:1;
+		uint32_t pfs:2;
+		uint32_t mpss:3;
+	} s;
+	struct cvmx_pciercx_cfg029_s cn52xx;
+	struct cvmx_pciercx_cfg029_s cn52xxp1;
+	struct cvmx_pciercx_cfg029_s cn56xx;
+	struct cvmx_pciercx_cfg029_s cn56xxp1;
+} cvmx_pciercx_cfg029_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg030_s {
+		uint32_t reserved_22_31:10;
+		uint32_t tp:1;
+		uint32_t ap_d:1;
+		uint32_t ur_d:1;
+		uint32_t fe_d:1;
+		uint32_t nfe_d:1;
+		uint32_t ce_d:1;
+		uint32_t reserved_15_15:1;
+		uint32_t mrrs:3;
+		uint32_t ns_en:1;
+		uint32_t ap_en:1;
+		uint32_t pf_en:1;
+		uint32_t etf_en:1;
+		uint32_t mps:3;
+		uint32_t ro_en:1;
+		uint32_t ur_en:1;
+		uint32_t fe_en:1;
+		uint32_t nfe_en:1;
+		uint32_t ce_en:1;
+	} s;
+	struct cvmx_pciercx_cfg030_s cn52xx;
+	struct cvmx_pciercx_cfg030_s cn52xxp1;
+	struct cvmx_pciercx_cfg030_s cn56xx;
+	struct cvmx_pciercx_cfg030_s cn56xxp1;
+} cvmx_pciercx_cfg030_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg031_s {
+		uint32_t pnum:8;
+		uint32_t reserved_22_23:2;
+		uint32_t lbnc:1;
+		uint32_t dllarc:1;
+		uint32_t sderc:1;
+		uint32_t cpm:1;
+		uint32_t l1el:3;
+		uint32_t l0el:3;
+		uint32_t aslpms:2;
+		uint32_t mlw:6;
+		uint32_t mls:4;
+	} s;
+	struct cvmx_pciercx_cfg031_s cn52xx;
+	struct cvmx_pciercx_cfg031_s cn52xxp1;
+	struct cvmx_pciercx_cfg031_s cn56xx;
+	struct cvmx_pciercx_cfg031_s cn56xxp1;
+} cvmx_pciercx_cfg031_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg032_s {
+		uint32_t lab:1;
+		uint32_t lbm:1;
+		uint32_t dlla:1;
+		uint32_t scc:1;
+		uint32_t lt:1;
+		uint32_t reserved_26_26:1;
+		uint32_t nlw:6;
+		uint32_t ls:4;
+		uint32_t reserved_12_15:4;
+		uint32_t lab_int_enb:1;
+		uint32_t lbm_int_enb:1;
+		uint32_t hawd:1;
+		uint32_t ecpm:1;
+		uint32_t es:1;
+		uint32_t ccc:1;
+		uint32_t rl:1;
+		uint32_t ld:1;
+		uint32_t rcb:1;
+		uint32_t reserved_2_2:1;
+		uint32_t aslpc:2;
+	} s;
+	struct cvmx_pciercx_cfg032_s cn52xx;
+	struct cvmx_pciercx_cfg032_s cn52xxp1;
+	struct cvmx_pciercx_cfg032_s cn56xx;
+	struct cvmx_pciercx_cfg032_s cn56xxp1;
+} cvmx_pciercx_cfg032_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg033_s {
+		uint32_t ps_num:13;
+		uint32_t nccs:1;
+		uint32_t emip:1;
+		uint32_t sp_ls:2;
+		uint32_t sp_lv:8;
+		uint32_t hp_c:1;
+		uint32_t hp_s:1;
+		uint32_t pip:1;
+		uint32_t aip:1;
+		uint32_t mrlsp:1;
+		uint32_t pcp:1;
+		uint32_t abp:1;
+	} s;
+	struct cvmx_pciercx_cfg033_s cn52xx;
+	struct cvmx_pciercx_cfg033_s cn52xxp1;
+	struct cvmx_pciercx_cfg033_s cn56xx;
+	struct cvmx_pciercx_cfg033_s cn56xxp1;
+} cvmx_pciercx_cfg033_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg034_s {
+		uint32_t reserved_25_31:7;
+		uint32_t dlls_c:1;
+		uint32_t emis:1;
+		uint32_t pds:1;
+		uint32_t mrlss:1;
+		uint32_t ccint_d:1;
+		uint32_t pd_c:1;
+		uint32_t mrls_c:1;
+		uint32_t pf_d:1;
+		uint32_t abp_d:1;
+		uint32_t reserved_13_15:3;
+		uint32_t dlls_en:1;
+		uint32_t emic:1;
+		uint32_t pcc:1;
+		uint32_t pic:2;
+		uint32_t aic:2;
+		uint32_t hpint_en:1;
+		uint32_t ccint_en:1;
+		uint32_t pd_en:1;
+		uint32_t mrls_en:1;
+		uint32_t pf_en:1;
+		uint32_t abp_en:1;
+	} s;
+	struct cvmx_pciercx_cfg034_s cn52xx;
+	struct cvmx_pciercx_cfg034_s cn52xxp1;
+	struct cvmx_pciercx_cfg034_s cn56xx;
+	struct cvmx_pciercx_cfg034_s cn56xxp1;
+} cvmx_pciercx_cfg034_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg035_s {
+		uint32_t reserved_17_31:15;
+		uint32_t crssv:1;
+		uint32_t reserved_5_15:11;
+		uint32_t crssve:1;
+		uint32_t pmeie:1;
+		uint32_t sefee:1;
+		uint32_t senfee:1;
+		uint32_t secee:1;
+	} s;
+	struct cvmx_pciercx_cfg035_s cn52xx;
+	struct cvmx_pciercx_cfg035_s cn52xxp1;
+	struct cvmx_pciercx_cfg035_s cn56xx;
+	struct cvmx_pciercx_cfg035_s cn56xxp1;
+} cvmx_pciercx_cfg035_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg036_s {
+		uint32_t reserved_18_31:14;
+		uint32_t pme_pend:1;
+		uint32_t pme_stat:1;
+		uint32_t pme_rid:16;
+	} s;
+	struct cvmx_pciercx_cfg036_s cn52xx;
+	struct cvmx_pciercx_cfg036_s cn52xxp1;
+	struct cvmx_pciercx_cfg036_s cn56xx;
+	struct cvmx_pciercx_cfg036_s cn56xxp1;
+} cvmx_pciercx_cfg036_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg037_s {
+		uint32_t reserved_5_31:27;
+		uint32_t ctds:1;
+		uint32_t ctrs:4;
+	} s;
+	struct cvmx_pciercx_cfg037_s cn52xx;
+	struct cvmx_pciercx_cfg037_s cn52xxp1;
+	struct cvmx_pciercx_cfg037_s cn56xx;
+	struct cvmx_pciercx_cfg037_s cn56xxp1;
+} cvmx_pciercx_cfg037_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg038_s {
+		uint32_t reserved_5_31:27;
+		uint32_t ctd:1;
+		uint32_t ctv:4;
+	} s;
+	struct cvmx_pciercx_cfg038_s cn52xx;
+	struct cvmx_pciercx_cfg038_s cn52xxp1;
+	struct cvmx_pciercx_cfg038_s cn56xx;
+	struct cvmx_pciercx_cfg038_s cn56xxp1;
+} cvmx_pciercx_cfg038_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg039_s {
+		uint32_t reserved_0_31:32;
+	} s;
+	struct cvmx_pciercx_cfg039_s cn52xx;
+	struct cvmx_pciercx_cfg039_s cn52xxp1;
+	struct cvmx_pciercx_cfg039_s cn56xx;
+	struct cvmx_pciercx_cfg039_s cn56xxp1;
+} cvmx_pciercx_cfg039_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg040_s {
+		uint32_t reserved_0_31:32;
+	} s;
+	struct cvmx_pciercx_cfg040_s cn52xx;
+	struct cvmx_pciercx_cfg040_s cn52xxp1;
+	struct cvmx_pciercx_cfg040_s cn56xx;
+	struct cvmx_pciercx_cfg040_s cn56xxp1;
+} cvmx_pciercx_cfg040_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg041_s {
+		uint32_t reserved_0_31:32;
+	} s;
+	struct cvmx_pciercx_cfg041_s cn52xx;
+	struct cvmx_pciercx_cfg041_s cn52xxp1;
+	struct cvmx_pciercx_cfg041_s cn56xx;
+	struct cvmx_pciercx_cfg041_s cn56xxp1;
+} cvmx_pciercx_cfg041_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg042_s {
+		uint32_t reserved_0_31:32;
+	} s;
+	struct cvmx_pciercx_cfg042_s cn52xx;
+	struct cvmx_pciercx_cfg042_s cn52xxp1;
+	struct cvmx_pciercx_cfg042_s cn56xx;
+	struct cvmx_pciercx_cfg042_s cn56xxp1;
+} cvmx_pciercx_cfg042_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg064_s {
+		uint32_t nco:12;
+		uint32_t cv:4;
+		uint32_t pcieec:16;
+	} s;
+	struct cvmx_pciercx_cfg064_s cn52xx;
+	struct cvmx_pciercx_cfg064_s cn52xxp1;
+	struct cvmx_pciercx_cfg064_s cn56xx;
+	struct cvmx_pciercx_cfg064_s cn56xxp1;
+} cvmx_pciercx_cfg064_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg065_s {
+		uint32_t reserved_21_31:11;
+		uint32_t ures:1;
+		uint32_t ecrces:1;
+		uint32_t mtlps:1;
+		uint32_t ros:1;
+		uint32_t ucs:1;
+		uint32_t cas:1;
+		uint32_t cts:1;
+		uint32_t fcpes:1;
+		uint32_t ptlps:1;
+		uint32_t reserved_6_11:6;
+		uint32_t sdes:1;
+		uint32_t dlpes:1;
+		uint32_t reserved_0_3:4;
+	} s;
+	struct cvmx_pciercx_cfg065_s cn52xx;
+	struct cvmx_pciercx_cfg065_s cn52xxp1;
+	struct cvmx_pciercx_cfg065_s cn56xx;
+	struct cvmx_pciercx_cfg065_s cn56xxp1;
+} cvmx_pciercx_cfg065_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg066_s {
+		uint32_t reserved_21_31:11;
+		uint32_t urem:1;
+		uint32_t ecrcem:1;
+		uint32_t mtlpm:1;
+		uint32_t rom:1;
+		uint32_t ucm:1;
+		uint32_t cam:1;
+		uint32_t ctm:1;
+		uint32_t fcpem:1;
+		uint32_t ptlpm:1;
+		uint32_t reserved_6_11:6;
+		uint32_t sdem:1;
+		uint32_t dlpem:1;
+		uint32_t reserved_0_3:4;
+	} s;
+	struct cvmx_pciercx_cfg066_s cn52xx;
+	struct cvmx_pciercx_cfg066_s cn52xxp1;
+	struct cvmx_pciercx_cfg066_s cn56xx;
+	struct cvmx_pciercx_cfg066_s cn56xxp1;
+} cvmx_pciercx_cfg066_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg067_s {
+		uint32_t reserved_21_31:11;
+		uint32_t ures:1;
+		uint32_t ecrces:1;
+		uint32_t mtlps:1;
+		uint32_t ros:1;
+		uint32_t ucs:1;
+		uint32_t cas:1;
+		uint32_t cts:1;
+		uint32_t fcpes:1;
+		uint32_t ptlps:1;
+		uint32_t reserved_6_11:6;
+		uint32_t sdes:1;
+		uint32_t dlpes:1;
+		uint32_t reserved_0_3:4;
+	} s;
+	struct cvmx_pciercx_cfg067_s cn52xx;
+	struct cvmx_pciercx_cfg067_s cn52xxp1;
+	struct cvmx_pciercx_cfg067_s cn56xx;
+	struct cvmx_pciercx_cfg067_s cn56xxp1;
+} cvmx_pciercx_cfg067_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg068_s {
+		uint32_t reserved_14_31:18;
+		uint32_t anfes:1;
+		uint32_t rtts:1;
+		uint32_t reserved_9_11:3;
+		uint32_t rnrs:1;
+		uint32_t bdllps:1;
+		uint32_t btlps:1;
+		uint32_t reserved_1_5:5;
+		uint32_t res:1;
+	} s;
+	struct cvmx_pciercx_cfg068_s cn52xx;
+	struct cvmx_pciercx_cfg068_s cn52xxp1;
+	struct cvmx_pciercx_cfg068_s cn56xx;
+	struct cvmx_pciercx_cfg068_s cn56xxp1;
+} cvmx_pciercx_cfg068_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg069_s {
+		uint32_t reserved_14_31:18;
+		uint32_t anfem:1;
+		uint32_t rttm:1;
+		uint32_t reserved_9_11:3;
+		uint32_t rnrm:1;
+		uint32_t bdllpm:1;
+		uint32_t btlpm:1;
+		uint32_t reserved_1_5:5;
+		uint32_t rem:1;
+	} s;
+	struct cvmx_pciercx_cfg069_s cn52xx;
+	struct cvmx_pciercx_cfg069_s cn52xxp1;
+	struct cvmx_pciercx_cfg069_s cn56xx;
+	struct cvmx_pciercx_cfg069_s cn56xxp1;
+} cvmx_pciercx_cfg069_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg070_s {
+		uint32_t reserved_9_31:23;
+		uint32_t ce:1;
+		uint32_t cc:1;
+		uint32_t ge:1;
+		uint32_t gc:1;
+		uint32_t fep:5;
+	} s;
+	struct cvmx_pciercx_cfg070_s cn52xx;
+	struct cvmx_pciercx_cfg070_s cn52xxp1;
+	struct cvmx_pciercx_cfg070_s cn56xx;
+	struct cvmx_pciercx_cfg070_s cn56xxp1;
+} cvmx_pciercx_cfg070_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg071_s {
+		uint32_t dword1:32;
+	} s;
+	struct cvmx_pciercx_cfg071_s cn52xx;
+	struct cvmx_pciercx_cfg071_s cn52xxp1;
+	struct cvmx_pciercx_cfg071_s cn56xx;
+	struct cvmx_pciercx_cfg071_s cn56xxp1;
+} cvmx_pciercx_cfg071_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg072_s {
+		uint32_t dword2:32;
+	} s;
+	struct cvmx_pciercx_cfg072_s cn52xx;
+	struct cvmx_pciercx_cfg072_s cn52xxp1;
+	struct cvmx_pciercx_cfg072_s cn56xx;
+	struct cvmx_pciercx_cfg072_s cn56xxp1;
+} cvmx_pciercx_cfg072_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg073_s {
+		uint32_t dword3:32;
+	} s;
+	struct cvmx_pciercx_cfg073_s cn52xx;
+	struct cvmx_pciercx_cfg073_s cn52xxp1;
+	struct cvmx_pciercx_cfg073_s cn56xx;
+	struct cvmx_pciercx_cfg073_s cn56xxp1;
+} cvmx_pciercx_cfg073_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg074_s {
+		uint32_t dword4:32;
+	} s;
+	struct cvmx_pciercx_cfg074_s cn52xx;
+	struct cvmx_pciercx_cfg074_s cn52xxp1;
+	struct cvmx_pciercx_cfg074_s cn56xx;
+	struct cvmx_pciercx_cfg074_s cn56xxp1;
+} cvmx_pciercx_cfg074_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg075_s {
+		uint32_t reserved_3_31:29;
+		uint32_t fere:1;
+		uint32_t nfere:1;
+		uint32_t cere:1;
+	} s;
+	struct cvmx_pciercx_cfg075_s cn52xx;
+	struct cvmx_pciercx_cfg075_s cn52xxp1;
+	struct cvmx_pciercx_cfg075_s cn56xx;
+	struct cvmx_pciercx_cfg075_s cn56xxp1;
+} cvmx_pciercx_cfg075_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg076_s {
+		uint32_t aeimn:5;
+		uint32_t reserved_7_26:20;
+		uint32_t femr:1;
+		uint32_t nfemr:1;
+		uint32_t fuf:1;
+		uint32_t multi_efnfr:1;
+		uint32_t efnfr:1;
+		uint32_t multi_ecr:1;
+		uint32_t ecr:1;
+	} s;
+	struct cvmx_pciercx_cfg076_s cn52xx;
+	struct cvmx_pciercx_cfg076_s cn52xxp1;
+	struct cvmx_pciercx_cfg076_s cn56xx;
+	struct cvmx_pciercx_cfg076_s cn56xxp1;
+} cvmx_pciercx_cfg076_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg077_s {
+		uint32_t efnfsi:16;
+		uint32_t ecsi:16;
+	} s;
+	struct cvmx_pciercx_cfg077_s cn52xx;
+	struct cvmx_pciercx_cfg077_s cn52xxp1;
+	struct cvmx_pciercx_cfg077_s cn56xx;
+	struct cvmx_pciercx_cfg077_s cn56xxp1;
+} cvmx_pciercx_cfg077_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg448_s {
+		uint32_t rtl:16;
+		uint32_t rtltl:16;
+	} s;
+	struct cvmx_pciercx_cfg448_s cn52xx;
+	struct cvmx_pciercx_cfg448_s cn52xxp1;
+	struct cvmx_pciercx_cfg448_s cn56xx;
+	struct cvmx_pciercx_cfg448_s cn56xxp1;
+} cvmx_pciercx_cfg448_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg449_s {
+		uint32_t omr:32;
+	} s;
+	struct cvmx_pciercx_cfg449_s cn52xx;
+	struct cvmx_pciercx_cfg449_s cn52xxp1;
+	struct cvmx_pciercx_cfg449_s cn56xx;
+	struct cvmx_pciercx_cfg449_s cn56xxp1;
+} cvmx_pciercx_cfg449_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg450_s {
+		uint32_t lpec:8;
+		uint32_t reserved_22_23:2;
+		uint32_t link_state:6;
+		uint32_t force_link:1;
+		uint32_t reserved_8_14:7;
+		uint32_t link_num:8;
+	} s;
+	struct cvmx_pciercx_cfg450_s cn52xx;
+	struct cvmx_pciercx_cfg450_s cn52xxp1;
+	struct cvmx_pciercx_cfg450_s cn56xx;
+	struct cvmx_pciercx_cfg450_s cn56xxp1;
+} cvmx_pciercx_cfg450_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg451_s {
+		uint32_t reserved_30_31:2;
+		uint32_t l1el:3;
+		uint32_t l0el:3;
+		uint32_t n_fts_cc:8;
+		uint32_t n_fts:8;
+		uint32_t ack_freq:8;
+	} s;
+	struct cvmx_pciercx_cfg451_s cn52xx;
+	struct cvmx_pciercx_cfg451_s cn52xxp1;
+	struct cvmx_pciercx_cfg451_s cn56xx;
+	struct cvmx_pciercx_cfg451_s cn56xxp1;
+} cvmx_pciercx_cfg451_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg452_s {
+		uint32_t reserved_26_31:6;
+		uint32_t eccrc:1;
+		uint32_t reserved_22_24:3;
+		uint32_t lme:6;
+		uint32_t reserved_8_15:8;
+		uint32_t flm:1;
+		uint32_t reserved_6_6:1;
+		uint32_t dllle:1;
+		uint32_t reserved_4_4:1;
+		uint32_t ra:1;
+		uint32_t le:1;
+		uint32_t sd:1;
+		uint32_t omr:1;
+	} s;
+	struct cvmx_pciercx_cfg452_s cn52xx;
+	struct cvmx_pciercx_cfg452_s cn52xxp1;
+	struct cvmx_pciercx_cfg452_s cn56xx;
+	struct cvmx_pciercx_cfg452_s cn56xxp1;
+} cvmx_pciercx_cfg452_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg453_s {
+		uint32_t dlld:1;
+		uint32_t reserved_26_30:5;
+		uint32_t ack_nak:1;
+		uint32_t fcd:1;
+		uint32_t ilst:24;
+	} s;
+	struct cvmx_pciercx_cfg453_s cn52xx;
+	struct cvmx_pciercx_cfg453_s cn52xxp1;
+	struct cvmx_pciercx_cfg453_s cn56xx;
+	struct cvmx_pciercx_cfg453_s cn56xxp1;
+} cvmx_pciercx_cfg453_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg454_s {
+		uint32_t reserved_29_31:3;
+		uint32_t tmfcwt:5;
+		uint32_t tmanlt:5;
+		uint32_t tmrt:5;
+		uint32_t reserved_11_13:3;
+		uint32_t nskps:3;
+		uint32_t reserved_4_7:4;
+		uint32_t ntss:4;
+	} s;
+	struct cvmx_pciercx_cfg454_s cn52xx;
+	struct cvmx_pciercx_cfg454_s cn52xxp1;
+	struct cvmx_pciercx_cfg454_s cn56xx;
+	struct cvmx_pciercx_cfg454_s cn56xxp1;
+} cvmx_pciercx_cfg454_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg455_s {
+		uint32_t m_cfg0_filt:1;
+		uint32_t m_io_filt:1;
+		uint32_t msg_ctrl:1;
+		uint32_t m_cpl_ecrc_filt:1;
+		uint32_t m_ecrc_filt:1;
+		uint32_t m_cpl_len_err:1;
+		uint32_t m_cpl_attr_err:1;
+		uint32_t m_cpl_tc_err:1;
+		uint32_t m_cpl_fun_err:1;
+		uint32_t m_cpl_rid_err:1;
+		uint32_t m_cpl_tag_err:1;
+		uint32_t m_lk_filt:1;
+		uint32_t m_cfg1_filt:1;
+		uint32_t m_bar_match:1;
+		uint32_t m_pois_filt:1;
+		uint32_t m_fun:1;
+		uint32_t dfcwt:1;
+		uint32_t reserved_11_14:4;
+		uint32_t skpiv:11;
+	} s;
+	struct cvmx_pciercx_cfg455_s cn52xx;
+	struct cvmx_pciercx_cfg455_s cn52xxp1;
+	struct cvmx_pciercx_cfg455_s cn56xx;
+	struct cvmx_pciercx_cfg455_s cn56xxp1;
+} cvmx_pciercx_cfg455_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg456_s {
+		uint32_t reserved_2_31:30;
+		uint32_t m_vend1_drp:1;
+		uint32_t m_vend0_drp:1;
+	} s;
+	struct cvmx_pciercx_cfg456_s cn52xx;
+	struct cvmx_pciercx_cfg456_s cn52xxp1;
+	struct cvmx_pciercx_cfg456_s cn56xx;
+	struct cvmx_pciercx_cfg456_s cn56xxp1;
+} cvmx_pciercx_cfg456_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg458_s {
+		uint32_t dbg_info_l32:32;
+	} s;
+	struct cvmx_pciercx_cfg458_s cn52xx;
+	struct cvmx_pciercx_cfg458_s cn52xxp1;
+	struct cvmx_pciercx_cfg458_s cn56xx;
+	struct cvmx_pciercx_cfg458_s cn56xxp1;
+} cvmx_pciercx_cfg458_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg459_s {
+		uint32_t dbg_info_u32:32;
+	} s;
+	struct cvmx_pciercx_cfg459_s cn52xx;
+	struct cvmx_pciercx_cfg459_s cn52xxp1;
+	struct cvmx_pciercx_cfg459_s cn56xx;
+	struct cvmx_pciercx_cfg459_s cn56xxp1;
+} cvmx_pciercx_cfg459_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg460_s {
+		uint32_t reserved_20_31:12;
+		uint32_t tphfcc:8;
+		uint32_t tpdfcc:12;
+	} s;
+	struct cvmx_pciercx_cfg460_s cn52xx;
+	struct cvmx_pciercx_cfg460_s cn52xxp1;
+	struct cvmx_pciercx_cfg460_s cn56xx;
+	struct cvmx_pciercx_cfg460_s cn56xxp1;
+} cvmx_pciercx_cfg460_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg461_s {
+		uint32_t reserved_20_31:12;
+		uint32_t tchfcc:8;
+		uint32_t tcdfcc:12;
+	} s;
+	struct cvmx_pciercx_cfg461_s cn52xx;
+	struct cvmx_pciercx_cfg461_s cn52xxp1;
+	struct cvmx_pciercx_cfg461_s cn56xx;
+	struct cvmx_pciercx_cfg461_s cn56xxp1;
+} cvmx_pciercx_cfg461_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg462_s {
+		uint32_t reserved_20_31:12;
+		uint32_t tchfcc:8;
+		uint32_t tcdfcc:12;
+	} s;
+	struct cvmx_pciercx_cfg462_s cn52xx;
+	struct cvmx_pciercx_cfg462_s cn52xxp1;
+	struct cvmx_pciercx_cfg462_s cn56xx;
+	struct cvmx_pciercx_cfg462_s cn56xxp1;
+} cvmx_pciercx_cfg462_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg463_s {
+		uint32_t reserved_3_31:29;
+		uint32_t rqne:1;
+		uint32_t trbne:1;
+		uint32_t rtlpfccnr:1;
+	} s;
+	struct cvmx_pciercx_cfg463_s cn52xx;
+	struct cvmx_pciercx_cfg463_s cn52xxp1;
+	struct cvmx_pciercx_cfg463_s cn56xx;
+	struct cvmx_pciercx_cfg463_s cn56xxp1;
+} cvmx_pciercx_cfg463_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg464_s {
+		uint32_t wrr_vc3:8;
+		uint32_t wrr_vc2:8;
+		uint32_t wrr_vc1:8;
+		uint32_t wrr_vc0:8;
+	} s;
+	struct cvmx_pciercx_cfg464_s cn52xx;
+	struct cvmx_pciercx_cfg464_s cn52xxp1;
+	struct cvmx_pciercx_cfg464_s cn56xx;
+	struct cvmx_pciercx_cfg464_s cn56xxp1;
+} cvmx_pciercx_cfg464_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg465_s {
+		uint32_t wrr_vc7:8;
+		uint32_t wrr_vc6:8;
+		uint32_t wrr_vc5:8;
+		uint32_t wrr_vc4:8;
+	} s;
+	struct cvmx_pciercx_cfg465_s cn52xx;
+	struct cvmx_pciercx_cfg465_s cn52xxp1;
+	struct cvmx_pciercx_cfg465_s cn56xx;
+	struct cvmx_pciercx_cfg465_s cn56xxp1;
+} cvmx_pciercx_cfg465_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg466_s {
+		uint32_t rx_queue_order:1;
+		uint32_t type_ordering:1;
+		uint32_t reserved_24_29:6;
+		uint32_t queue_mode:3;
+		uint32_t reserved_20_20:1;
+		uint32_t header_credits:8;
+		uint32_t data_credits:12;
+	} s;
+	struct cvmx_pciercx_cfg466_s cn52xx;
+	struct cvmx_pciercx_cfg466_s cn52xxp1;
+	struct cvmx_pciercx_cfg466_s cn56xx;
+	struct cvmx_pciercx_cfg466_s cn56xxp1;
+} cvmx_pciercx_cfg466_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg467_s {
+		uint32_t reserved_24_31:8;
+		uint32_t queue_mode:3;
+		uint32_t reserved_20_20:1;
+		uint32_t header_credits:8;
+		uint32_t data_credits:12;
+	} s;
+	struct cvmx_pciercx_cfg467_s cn52xx;
+	struct cvmx_pciercx_cfg467_s cn52xxp1;
+	struct cvmx_pciercx_cfg467_s cn56xx;
+	struct cvmx_pciercx_cfg467_s cn56xxp1;
+} cvmx_pciercx_cfg467_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg468_s {
+		uint32_t reserved_24_31:8;
+		uint32_t queue_mode:3;
+		uint32_t reserved_20_20:1;
+		uint32_t header_credits:8;
+		uint32_t data_credits:12;
+	} s;
+	struct cvmx_pciercx_cfg468_s cn52xx;
+	struct cvmx_pciercx_cfg468_s cn52xxp1;
+	struct cvmx_pciercx_cfg468_s cn56xx;
+	struct cvmx_pciercx_cfg468_s cn56xxp1;
+} cvmx_pciercx_cfg468_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg490_s {
+		uint32_t reserved_26_31:6;
+		uint32_t header_depth:10;
+		uint32_t reserved_14_15:2;
+		uint32_t data_depth:14;
+	} s;
+	struct cvmx_pciercx_cfg490_s cn52xx;
+	struct cvmx_pciercx_cfg490_s cn52xxp1;
+	struct cvmx_pciercx_cfg490_s cn56xx;
+	struct cvmx_pciercx_cfg490_s cn56xxp1;
+} cvmx_pciercx_cfg490_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg491_s {
+		uint32_t reserved_26_31:6;
+		uint32_t header_depth:10;
+		uint32_t reserved_14_15:2;
+		uint32_t data_depth:14;
+	} s;
+	struct cvmx_pciercx_cfg491_s cn52xx;
+	struct cvmx_pciercx_cfg491_s cn52xxp1;
+	struct cvmx_pciercx_cfg491_s cn56xx;
+	struct cvmx_pciercx_cfg491_s cn56xxp1;
+} cvmx_pciercx_cfg491_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg492_s {
+		uint32_t reserved_26_31:6;
+		uint32_t header_depth:10;
+		uint32_t reserved_14_15:2;
+		uint32_t data_depth:14;
+	} s;
+	struct cvmx_pciercx_cfg492_s cn52xx;
+	struct cvmx_pciercx_cfg492_s cn52xxp1;
+	struct cvmx_pciercx_cfg492_s cn56xx;
+	struct cvmx_pciercx_cfg492_s cn56xxp1;
+} cvmx_pciercx_cfg492_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg516_s {
+		uint32_t phy_stat:32;
+	} s;
+	struct cvmx_pciercx_cfg516_s cn52xx;
+	struct cvmx_pciercx_cfg516_s cn52xxp1;
+	struct cvmx_pciercx_cfg516_s cn56xx;
+	struct cvmx_pciercx_cfg516_s cn56xxp1;
+} cvmx_pciercx_cfg516_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg517_s {
+		uint32_t phy_ctrl:32;
+	} s;
+	struct cvmx_pciercx_cfg517_s cn52xx;
+	struct cvmx_pciercx_cfg517_s cn52xxp1;
+	struct cvmx_pciercx_cfg517_s cn56xx;
+	struct cvmx_pciercx_cfg517_s cn56xxp1;
+} cvmx_pciercx_cfg517_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcmx_dma_cfg_s {
+		uint64_t rdpend:1;
+		uint64_t reserved_54_62:9;
+		uint64_t rxslots:10;
+		uint64_t reserved_42_43:2;
+		uint64_t txslots:10;
+		uint64_t reserved_30_31:2;
+		uint64_t rxst:10;
+		uint64_t reserved_19_19:1;
+		uint64_t useldt:1;
+		uint64_t txrd:10;
+		uint64_t fetchsiz:4;
+		uint64_t thresh:4;
+	} s;
+	struct cvmx_pcmx_dma_cfg_s cn30xx;
+	struct cvmx_pcmx_dma_cfg_s cn31xx;
+	struct cvmx_pcmx_dma_cfg_s cn50xx;
+} cvmx_pcmx_dma_cfg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcmx_int_ena_s {
+		uint64_t reserved_8_63:56;
+		uint64_t rxovf:1;
+		uint64_t txempty:1;
+		uint64_t txrd:1;
+		uint64_t txwrap:1;
+		uint64_t rxst:1;
+		uint64_t rxwrap:1;
+		uint64_t fsyncextra:1;
+		uint64_t fsyncmissed:1;
+	} s;
+	struct cvmx_pcmx_int_ena_s cn30xx;
+	struct cvmx_pcmx_int_ena_s cn31xx;
+	struct cvmx_pcmx_int_ena_s cn50xx;
+} cvmx_pcmx_int_ena_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcmx_int_sum_s {
+		uint64_t reserved_8_63:56;
+		uint64_t rxovf:1;
+		uint64_t txempty:1;
+		uint64_t txrd:1;
+		uint64_t txwrap:1;
+		uint64_t rxst:1;
+		uint64_t rxwrap:1;
+		uint64_t fsyncextra:1;
+		uint64_t fsyncmissed:1;
+	} s;
+	struct cvmx_pcmx_int_sum_s cn30xx;
+	struct cvmx_pcmx_int_sum_s cn31xx;
+	struct cvmx_pcmx_int_sum_s cn50xx;
+} cvmx_pcmx_int_sum_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcmx_rxaddr_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_pcmx_rxaddr_s cn30xx;
+	struct cvmx_pcmx_rxaddr_s cn31xx;
+	struct cvmx_pcmx_rxaddr_s cn50xx;
+} cvmx_pcmx_rxaddr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcmx_rxcnt_s {
+		uint64_t reserved_16_63:48;
+		uint64_t cnt:16;
+	} s;
+	struct cvmx_pcmx_rxcnt_s cn30xx;
+	struct cvmx_pcmx_rxcnt_s cn31xx;
+	struct cvmx_pcmx_rxcnt_s cn50xx;
+} cvmx_pcmx_rxcnt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcmx_rxmsk0_s {
+		uint64_t mask:64;
+	} s;
+	struct cvmx_pcmx_rxmsk0_s cn30xx;
+	struct cvmx_pcmx_rxmsk0_s cn31xx;
+	struct cvmx_pcmx_rxmsk0_s cn50xx;
+} cvmx_pcmx_rxmsk0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcmx_rxmsk1_s {
+		uint64_t mask:64;
+	} s;
+	struct cvmx_pcmx_rxmsk1_s cn30xx;
+	struct cvmx_pcmx_rxmsk1_s cn31xx;
+	struct cvmx_pcmx_rxmsk1_s cn50xx;
+} cvmx_pcmx_rxmsk1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcmx_rxmsk2_s {
+		uint64_t mask:64;
+	} s;
+	struct cvmx_pcmx_rxmsk2_s cn30xx;
+	struct cvmx_pcmx_rxmsk2_s cn31xx;
+	struct cvmx_pcmx_rxmsk2_s cn50xx;
+} cvmx_pcmx_rxmsk2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcmx_rxmsk3_s {
+		uint64_t mask:64;
+	} s;
+	struct cvmx_pcmx_rxmsk3_s cn30xx;
+	struct cvmx_pcmx_rxmsk3_s cn31xx;
+	struct cvmx_pcmx_rxmsk3_s cn50xx;
+} cvmx_pcmx_rxmsk3_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcmx_rxmsk4_s {
+		uint64_t mask:64;
+	} s;
+	struct cvmx_pcmx_rxmsk4_s cn30xx;
+	struct cvmx_pcmx_rxmsk4_s cn31xx;
+	struct cvmx_pcmx_rxmsk4_s cn50xx;
+} cvmx_pcmx_rxmsk4_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcmx_rxmsk5_s {
+		uint64_t mask:64;
+	} s;
+	struct cvmx_pcmx_rxmsk5_s cn30xx;
+	struct cvmx_pcmx_rxmsk5_s cn31xx;
+	struct cvmx_pcmx_rxmsk5_s cn50xx;
+} cvmx_pcmx_rxmsk5_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcmx_rxmsk6_s {
+		uint64_t mask:64;
+	} s;
+	struct cvmx_pcmx_rxmsk6_s cn30xx;
+	struct cvmx_pcmx_rxmsk6_s cn31xx;
+	struct cvmx_pcmx_rxmsk6_s cn50xx;
+} cvmx_pcmx_rxmsk6_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcmx_rxmsk7_s {
+		uint64_t mask:64;
+	} s;
+	struct cvmx_pcmx_rxmsk7_s cn30xx;
+	struct cvmx_pcmx_rxmsk7_s cn31xx;
+	struct cvmx_pcmx_rxmsk7_s cn50xx;
+} cvmx_pcmx_rxmsk7_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcmx_rxstart_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:33;
+		uint64_t reserved_0_2:3;
+	} s;
+	struct cvmx_pcmx_rxstart_s cn30xx;
+	struct cvmx_pcmx_rxstart_s cn31xx;
+	struct cvmx_pcmx_rxstart_s cn50xx;
+} cvmx_pcmx_rxstart_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcmx_tdm_cfg_s {
+		uint64_t drvtim:16;
+		uint64_t samppt:16;
+		uint64_t reserved_3_31:29;
+		uint64_t lsbfirst:1;
+		uint64_t useclk1:1;
+		uint64_t enable:1;
+	} s;
+	struct cvmx_pcmx_tdm_cfg_s cn30xx;
+	struct cvmx_pcmx_tdm_cfg_s cn31xx;
+	struct cvmx_pcmx_tdm_cfg_s cn50xx;
+} cvmx_pcmx_tdm_cfg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcmx_tdm_dbg_s {
+		uint64_t debuginfo:64;
+	} s;
+	struct cvmx_pcmx_tdm_dbg_s cn30xx;
+	struct cvmx_pcmx_tdm_dbg_s cn31xx;
+	struct cvmx_pcmx_tdm_dbg_s cn50xx;
+} cvmx_pcmx_tdm_dbg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcmx_txaddr_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:33;
+		uint64_t fram:3;
+	} s;
+	struct cvmx_pcmx_txaddr_s cn30xx;
+	struct cvmx_pcmx_txaddr_s cn31xx;
+	struct cvmx_pcmx_txaddr_s cn50xx;
+} cvmx_pcmx_txaddr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcmx_txcnt_s {
+		uint64_t reserved_16_63:48;
+		uint64_t cnt:16;
+	} s;
+	struct cvmx_pcmx_txcnt_s cn30xx;
+	struct cvmx_pcmx_txcnt_s cn31xx;
+	struct cvmx_pcmx_txcnt_s cn50xx;
+} cvmx_pcmx_txcnt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcmx_txmsk0_s {
+		uint64_t mask:64;
+	} s;
+	struct cvmx_pcmx_txmsk0_s cn30xx;
+	struct cvmx_pcmx_txmsk0_s cn31xx;
+	struct cvmx_pcmx_txmsk0_s cn50xx;
+} cvmx_pcmx_txmsk0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcmx_txmsk1_s {
+		uint64_t mask:64;
+	} s;
+	struct cvmx_pcmx_txmsk1_s cn30xx;
+	struct cvmx_pcmx_txmsk1_s cn31xx;
+	struct cvmx_pcmx_txmsk1_s cn50xx;
+} cvmx_pcmx_txmsk1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcmx_txmsk2_s {
+		uint64_t mask:64;
+	} s;
+	struct cvmx_pcmx_txmsk2_s cn30xx;
+	struct cvmx_pcmx_txmsk2_s cn31xx;
+	struct cvmx_pcmx_txmsk2_s cn50xx;
+} cvmx_pcmx_txmsk2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcmx_txmsk3_s {
+		uint64_t mask:64;
+	} s;
+	struct cvmx_pcmx_txmsk3_s cn30xx;
+	struct cvmx_pcmx_txmsk3_s cn31xx;
+	struct cvmx_pcmx_txmsk3_s cn50xx;
+} cvmx_pcmx_txmsk3_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcmx_txmsk4_s {
+		uint64_t mask:64;
+	} s;
+	struct cvmx_pcmx_txmsk4_s cn30xx;
+	struct cvmx_pcmx_txmsk4_s cn31xx;
+	struct cvmx_pcmx_txmsk4_s cn50xx;
+} cvmx_pcmx_txmsk4_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcmx_txmsk5_s {
+		uint64_t mask:64;
+	} s;
+	struct cvmx_pcmx_txmsk5_s cn30xx;
+	struct cvmx_pcmx_txmsk5_s cn31xx;
+	struct cvmx_pcmx_txmsk5_s cn50xx;
+} cvmx_pcmx_txmsk5_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcmx_txmsk6_s {
+		uint64_t mask:64;
+	} s;
+	struct cvmx_pcmx_txmsk6_s cn30xx;
+	struct cvmx_pcmx_txmsk6_s cn31xx;
+	struct cvmx_pcmx_txmsk6_s cn50xx;
+} cvmx_pcmx_txmsk6_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcmx_txmsk7_s {
+		uint64_t mask:64;
+	} s;
+	struct cvmx_pcmx_txmsk7_s cn30xx;
+	struct cvmx_pcmx_txmsk7_s cn31xx;
+	struct cvmx_pcmx_txmsk7_s cn50xx;
+} cvmx_pcmx_txmsk7_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcmx_txstart_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:33;
+		uint64_t reserved_0_2:3;
+	} s;
+	struct cvmx_pcmx_txstart_s cn30xx;
+	struct cvmx_pcmx_txstart_s cn31xx;
+	struct cvmx_pcmx_txstart_s cn50xx;
+} cvmx_pcmx_txstart_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcm_clkx_cfg_s {
+		uint64_t fsyncgood:1;
+		uint64_t reserved_48_62:15;
+		uint64_t fsyncsamp:16;
+		uint64_t reserved_26_31:6;
+		uint64_t fsynclen:5;
+		uint64_t fsyncloc:5;
+		uint64_t numslots:10;
+		uint64_t extrabit:1;
+		uint64_t bitlen:2;
+		uint64_t bclkpol:1;
+		uint64_t fsyncpol:1;
+		uint64_t ena:1;
+	} s;
+	struct cvmx_pcm_clkx_cfg_s cn30xx;
+	struct cvmx_pcm_clkx_cfg_s cn31xx;
+	struct cvmx_pcm_clkx_cfg_s cn50xx;
+} cvmx_pcm_clkx_cfg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcm_clkx_dbg_s {
+		uint64_t debuginfo:64;
+	} s;
+	struct cvmx_pcm_clkx_dbg_s cn30xx;
+	struct cvmx_pcm_clkx_dbg_s cn31xx;
+	struct cvmx_pcm_clkx_dbg_s cn50xx;
+} cvmx_pcm_clkx_dbg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcm_clkx_gen_s {
+		uint64_t deltasamp:16;
+		uint64_t numsamp:16;
+		uint64_t n:32;
+	} s;
+	struct cvmx_pcm_clkx_gen_s cn30xx;
+	struct cvmx_pcm_clkx_gen_s cn31xx;
+	struct cvmx_pcm_clkx_gen_s cn50xx;
+} cvmx_pcm_clkx_gen_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsx_anx_adv_reg_s {
+		uint64_t reserved_16_63:48;
+		uint64_t np:1;
+		uint64_t reserved_14_14:1;
+		uint64_t rem_flt:2;
+		uint64_t reserved_9_11:3;
+		uint64_t pause:2;
+		uint64_t hfd:1;
+		uint64_t fd:1;
+		uint64_t reserved_0_4:5;
+	} s;
+	struct cvmx_pcsx_anx_adv_reg_s cn52xx;
+	struct cvmx_pcsx_anx_adv_reg_s cn52xxp1;
+	struct cvmx_pcsx_anx_adv_reg_s cn56xx;
+	struct cvmx_pcsx_anx_adv_reg_s cn56xxp1;
+} cvmx_pcsx_anx_adv_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsx_anx_ext_st_reg_s {
+		uint64_t reserved_16_63:48;
+		uint64_t thou_xfd:1;
+		uint64_t thou_xhd:1;
+		uint64_t thou_tfd:1;
+		uint64_t thou_thd:1;
+		uint64_t reserved_0_11:12;
+	} s;
+	struct cvmx_pcsx_anx_ext_st_reg_s cn52xx;
+	struct cvmx_pcsx_anx_ext_st_reg_s cn52xxp1;
+	struct cvmx_pcsx_anx_ext_st_reg_s cn56xx;
+	struct cvmx_pcsx_anx_ext_st_reg_s cn56xxp1;
+} cvmx_pcsx_anx_ext_st_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsx_anx_lp_abil_reg_s {
+		uint64_t reserved_16_63:48;
+		uint64_t np:1;
+		uint64_t ack:1;
+		uint64_t rem_flt:2;
+		uint64_t reserved_9_11:3;
+		uint64_t pause:2;
+		uint64_t hfd:1;
+		uint64_t fd:1;
+		uint64_t reserved_0_4:5;
+	} s;
+	struct cvmx_pcsx_anx_lp_abil_reg_s cn52xx;
+	struct cvmx_pcsx_anx_lp_abil_reg_s cn52xxp1;
+	struct cvmx_pcsx_anx_lp_abil_reg_s cn56xx;
+	struct cvmx_pcsx_anx_lp_abil_reg_s cn56xxp1;
+} cvmx_pcsx_anx_lp_abil_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsx_anx_results_reg_s {
+		uint64_t reserved_7_63:57;
+		uint64_t pause:2;
+		uint64_t spd:2;
+		uint64_t an_cpt:1;
+		uint64_t dup:1;
+		uint64_t link_ok:1;
+	} s;
+	struct cvmx_pcsx_anx_results_reg_s cn52xx;
+	struct cvmx_pcsx_anx_results_reg_s cn52xxp1;
+	struct cvmx_pcsx_anx_results_reg_s cn56xx;
+	struct cvmx_pcsx_anx_results_reg_s cn56xxp1;
+} cvmx_pcsx_anx_results_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsx_intx_en_reg_s {
+		uint64_t reserved_12_63:52;
+		uint64_t dup:1;
+		uint64_t sync_bad_en:1;
+		uint64_t an_bad_en:1;
+		uint64_t rxlock_en:1;
+		uint64_t rxbad_en:1;
+		uint64_t rxerr_en:1;
+		uint64_t txbad_en:1;
+		uint64_t txfifo_en:1;
+		uint64_t txfifu_en:1;
+		uint64_t an_err_en:1;
+		uint64_t xmit_en:1;
+		uint64_t lnkspd_en:1;
+	} s;
+	struct cvmx_pcsx_intx_en_reg_s cn52xx;
+	struct cvmx_pcsx_intx_en_reg_s cn52xxp1;
+	struct cvmx_pcsx_intx_en_reg_s cn56xx;
+	struct cvmx_pcsx_intx_en_reg_s cn56xxp1;
+} cvmx_pcsx_intx_en_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsx_intx_reg_s {
+		uint64_t reserved_12_63:52;
+		uint64_t dup:1;
+		uint64_t sync_bad:1;
+		uint64_t an_bad:1;
+		uint64_t rxlock:1;
+		uint64_t rxbad:1;
+		uint64_t rxerr:1;
+		uint64_t txbad:1;
+		uint64_t txfifo:1;
+		uint64_t txfifu:1;
+		uint64_t an_err:1;
+		uint64_t xmit:1;
+		uint64_t lnkspd:1;
+	} s;
+	struct cvmx_pcsx_intx_reg_s cn52xx;
+	struct cvmx_pcsx_intx_reg_s cn52xxp1;
+	struct cvmx_pcsx_intx_reg_s cn56xx;
+	struct cvmx_pcsx_intx_reg_s cn56xxp1;
+} cvmx_pcsx_intx_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsx_linkx_timer_count_reg_s {
+		uint64_t reserved_16_63:48;
+		uint64_t count:16;
+	} s;
+	struct cvmx_pcsx_linkx_timer_count_reg_s cn52xx;
+	struct cvmx_pcsx_linkx_timer_count_reg_s cn52xxp1;
+	struct cvmx_pcsx_linkx_timer_count_reg_s cn56xx;
+	struct cvmx_pcsx_linkx_timer_count_reg_s cn56xxp1;
+} cvmx_pcsx_linkx_timer_count_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsx_log_anlx_reg_s {
+		uint64_t reserved_4_63:60;
+		uint64_t lafifovfl:1;
+		uint64_t la_en:1;
+		uint64_t pkt_sz:2;
+	} s;
+	struct cvmx_pcsx_log_anlx_reg_s cn52xx;
+	struct cvmx_pcsx_log_anlx_reg_s cn52xxp1;
+	struct cvmx_pcsx_log_anlx_reg_s cn56xx;
+	struct cvmx_pcsx_log_anlx_reg_s cn56xxp1;
+} cvmx_pcsx_log_anlx_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsx_miscx_ctl_reg_s {
+		uint64_t reserved_13_63:51;
+		uint64_t sgmii:1;
+		uint64_t gmxeno:1;
+		uint64_t loopbck2:1;
+		uint64_t mac_phy:1;
+		uint64_t mode:1;
+		uint64_t an_ovrd:1;
+		uint64_t samp_pt:7;
+	} s;
+	struct cvmx_pcsx_miscx_ctl_reg_s cn52xx;
+	struct cvmx_pcsx_miscx_ctl_reg_s cn52xxp1;
+	struct cvmx_pcsx_miscx_ctl_reg_s cn56xx;
+	struct cvmx_pcsx_miscx_ctl_reg_s cn56xxp1;
+} cvmx_pcsx_miscx_ctl_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsx_mrx_control_reg_s {
+		uint64_t reserved_16_63:48;
+		uint64_t reset:1;
+		uint64_t loopbck1:1;
+		uint64_t spdlsb:1;
+		uint64_t an_en:1;
+		uint64_t pwr_dn:1;
+		uint64_t reserved_10_10:1;
+		uint64_t rst_an:1;
+		uint64_t dup:1;
+		uint64_t coltst:1;
+		uint64_t spdmsb:1;
+		uint64_t uni:1;
+		uint64_t reserved_0_4:5;
+	} s;
+	struct cvmx_pcsx_mrx_control_reg_s cn52xx;
+	struct cvmx_pcsx_mrx_control_reg_s cn52xxp1;
+	struct cvmx_pcsx_mrx_control_reg_s cn56xx;
+	struct cvmx_pcsx_mrx_control_reg_s cn56xxp1;
+} cvmx_pcsx_mrx_control_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsx_mrx_status_reg_s {
+		uint64_t reserved_16_63:48;
+		uint64_t hun_t4:1;
+		uint64_t hun_xfd:1;
+		uint64_t hun_xhd:1;
+		uint64_t ten_fd:1;
+		uint64_t ten_hd:1;
+		uint64_t hun_t2fd:1;
+		uint64_t hun_t2hd:1;
+		uint64_t ext_st:1;
+		uint64_t reserved_7_7:1;
+		uint64_t prb_sup:1;
+		uint64_t an_cpt:1;
+		uint64_t rm_flt:1;
+		uint64_t an_abil:1;
+		uint64_t lnk_st:1;
+		uint64_t reserved_1_1:1;
+		uint64_t extnd:1;
+	} s;
+	struct cvmx_pcsx_mrx_status_reg_s cn52xx;
+	struct cvmx_pcsx_mrx_status_reg_s cn52xxp1;
+	struct cvmx_pcsx_mrx_status_reg_s cn56xx;
+	struct cvmx_pcsx_mrx_status_reg_s cn56xxp1;
+} cvmx_pcsx_mrx_status_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsx_rxx_states_reg_s {
+		uint64_t reserved_16_63:48;
+		uint64_t rx_bad:1;
+		uint64_t rx_st:5;
+		uint64_t sync_bad:1;
+		uint64_t sync:4;
+		uint64_t an_bad:1;
+		uint64_t an_st:4;
+	} s;
+	struct cvmx_pcsx_rxx_states_reg_s cn52xx;
+	struct cvmx_pcsx_rxx_states_reg_s cn52xxp1;
+	struct cvmx_pcsx_rxx_states_reg_s cn56xx;
+	struct cvmx_pcsx_rxx_states_reg_s cn56xxp1;
+} cvmx_pcsx_rxx_states_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsx_rxx_sync_reg_s {
+		uint64_t reserved_2_63:62;
+		uint64_t sync:1;
+		uint64_t bit_lock:1;
+	} s;
+	struct cvmx_pcsx_rxx_sync_reg_s cn52xx;
+	struct cvmx_pcsx_rxx_sync_reg_s cn52xxp1;
+	struct cvmx_pcsx_rxx_sync_reg_s cn56xx;
+	struct cvmx_pcsx_rxx_sync_reg_s cn56xxp1;
+} cvmx_pcsx_rxx_sync_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsx_sgmx_an_adv_reg_s {
+		uint64_t reserved_16_63:48;
+		uint64_t link:1;
+		uint64_t ack:1;
+		uint64_t reserved_13_13:1;
+		uint64_t dup:1;
+		uint64_t speed:2;
+		uint64_t reserved_1_9:9;
+		uint64_t one:1;
+	} s;
+	struct cvmx_pcsx_sgmx_an_adv_reg_s cn52xx;
+	struct cvmx_pcsx_sgmx_an_adv_reg_s cn52xxp1;
+	struct cvmx_pcsx_sgmx_an_adv_reg_s cn56xx;
+	struct cvmx_pcsx_sgmx_an_adv_reg_s cn56xxp1;
+} cvmx_pcsx_sgmx_an_adv_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsx_sgmx_lp_adv_reg_s {
+		uint64_t reserved_16_63:48;
+		uint64_t link:1;
+		uint64_t reserved_13_14:2;
+		uint64_t dup:1;
+		uint64_t speed:2;
+		uint64_t reserved_1_9:9;
+		uint64_t one:1;
+	} s;
+	struct cvmx_pcsx_sgmx_lp_adv_reg_s cn52xx;
+	struct cvmx_pcsx_sgmx_lp_adv_reg_s cn52xxp1;
+	struct cvmx_pcsx_sgmx_lp_adv_reg_s cn56xx;
+	struct cvmx_pcsx_sgmx_lp_adv_reg_s cn56xxp1;
+} cvmx_pcsx_sgmx_lp_adv_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsx_txx_states_reg_s {
+		uint64_t reserved_7_63:57;
+		uint64_t xmit:2;
+		uint64_t tx_bad:1;
+		uint64_t ord_st:4;
+	} s;
+	struct cvmx_pcsx_txx_states_reg_s cn52xx;
+	struct cvmx_pcsx_txx_states_reg_s cn52xxp1;
+	struct cvmx_pcsx_txx_states_reg_s cn56xx;
+	struct cvmx_pcsx_txx_states_reg_s cn56xxp1;
+} cvmx_pcsx_txx_states_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsx_tx_rxx_polarity_reg_s {
+		uint64_t reserved_4_63:60;
+		uint64_t rxovrd:1;
+		uint64_t autorxpl:1;
+		uint64_t rxplrt:1;
+		uint64_t txplrt:1;
+	} s;
+	struct cvmx_pcsx_tx_rxx_polarity_reg_s cn52xx;
+	struct cvmx_pcsx_tx_rxx_polarity_reg_s cn52xxp1;
+	struct cvmx_pcsx_tx_rxx_polarity_reg_s cn56xx;
+	struct cvmx_pcsx_tx_rxx_polarity_reg_s cn56xxp1;
+} cvmx_pcsx_tx_rxx_polarity_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsxx_10gbx_status_reg_s {
+		uint64_t reserved_13_63:51;
+		uint64_t alignd:1;
+		uint64_t pattst:1;
+		uint64_t reserved_4_10:7;
+		uint64_t l3sync:1;
+		uint64_t l2sync:1;
+		uint64_t l1sync:1;
+		uint64_t l0sync:1;
+	} s;
+	struct cvmx_pcsxx_10gbx_status_reg_s cn52xx;
+	struct cvmx_pcsxx_10gbx_status_reg_s cn52xxp1;
+	struct cvmx_pcsxx_10gbx_status_reg_s cn56xx;
+	struct cvmx_pcsxx_10gbx_status_reg_s cn56xxp1;
+} cvmx_pcsxx_10gbx_status_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsxx_bist_status_reg_s {
+		uint64_t reserved_1_63:63;
+		uint64_t bist_status:1;
+	} s;
+	struct cvmx_pcsxx_bist_status_reg_s cn52xx;
+	struct cvmx_pcsxx_bist_status_reg_s cn52xxp1;
+	struct cvmx_pcsxx_bist_status_reg_s cn56xx;
+	struct cvmx_pcsxx_bist_status_reg_s cn56xxp1;
+} cvmx_pcsxx_bist_status_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsxx_bit_lock_status_reg_s {
+		uint64_t reserved_4_63:60;
+		uint64_t bitlck3:1;
+		uint64_t bitlck2:1;
+		uint64_t bitlck1:1;
+		uint64_t bitlck0:1;
+	} s;
+	struct cvmx_pcsxx_bit_lock_status_reg_s cn52xx;
+	struct cvmx_pcsxx_bit_lock_status_reg_s cn52xxp1;
+	struct cvmx_pcsxx_bit_lock_status_reg_s cn56xx;
+	struct cvmx_pcsxx_bit_lock_status_reg_s cn56xxp1;
+} cvmx_pcsxx_bit_lock_status_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsxx_control1_reg_s {
+		uint64_t reserved_16_63:48;
+		uint64_t reset:1;
+		uint64_t loopbck1:1;
+		uint64_t spdsel1:1;
+		uint64_t reserved_12_12:1;
+		uint64_t lo_pwr:1;
+		uint64_t reserved_7_10:4;
+		uint64_t spdsel0:1;
+		uint64_t spd:4;
+		uint64_t reserved_0_1:2;
+	} s;
+	struct cvmx_pcsxx_control1_reg_s cn52xx;
+	struct cvmx_pcsxx_control1_reg_s cn52xxp1;
+	struct cvmx_pcsxx_control1_reg_s cn56xx;
+	struct cvmx_pcsxx_control1_reg_s cn56xxp1;
+} cvmx_pcsxx_control1_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsxx_control2_reg_s {
+		uint64_t reserved_2_63:62;
+		uint64_t type:2;
+	} s;
+	struct cvmx_pcsxx_control2_reg_s cn52xx;
+	struct cvmx_pcsxx_control2_reg_s cn52xxp1;
+	struct cvmx_pcsxx_control2_reg_s cn56xx;
+	struct cvmx_pcsxx_control2_reg_s cn56xxp1;
+} cvmx_pcsxx_control2_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsxx_int_en_reg_s {
+		uint64_t reserved_6_63:58;
+		uint64_t algnlos_en:1;
+		uint64_t synlos_en:1;
+		uint64_t bitlckls_en:1;
+		uint64_t rxsynbad_en:1;
+		uint64_t rxbad_en:1;
+		uint64_t txflt_en:1;
+	} s;
+	struct cvmx_pcsxx_int_en_reg_s cn52xx;
+	struct cvmx_pcsxx_int_en_reg_s cn52xxp1;
+	struct cvmx_pcsxx_int_en_reg_s cn56xx;
+	struct cvmx_pcsxx_int_en_reg_s cn56xxp1;
+} cvmx_pcsxx_int_en_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsxx_int_reg_s {
+		uint64_t reserved_6_63:58;
+		uint64_t algnlos:1;
+		uint64_t synlos:1;
+		uint64_t bitlckls:1;
+		uint64_t rxsynbad:1;
+		uint64_t rxbad:1;
+		uint64_t txflt:1;
+	} s;
+	struct cvmx_pcsxx_int_reg_s cn52xx;
+	struct cvmx_pcsxx_int_reg_s cn52xxp1;
+	struct cvmx_pcsxx_int_reg_s cn56xx;
+	struct cvmx_pcsxx_int_reg_s cn56xxp1;
+} cvmx_pcsxx_int_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsxx_log_anl_reg_s {
+		uint64_t reserved_7_63:57;
+		uint64_t enc_mode:1;
+		uint64_t drop_ln:2;
+		uint64_t lafifovfl:1;
+		uint64_t la_en:1;
+		uint64_t pkt_sz:2;
+	} s;
+	struct cvmx_pcsxx_log_anl_reg_s cn52xx;
+	struct cvmx_pcsxx_log_anl_reg_s cn52xxp1;
+	struct cvmx_pcsxx_log_anl_reg_s cn56xx;
+	struct cvmx_pcsxx_log_anl_reg_s cn56xxp1;
+} cvmx_pcsxx_log_anl_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsxx_misc_ctl_reg_s {
+		uint64_t reserved_4_63:60;
+		uint64_t tx_swap:1;
+		uint64_t rx_swap:1;
+		uint64_t xaui:1;
+		uint64_t gmxeno:1;
+	} s;
+	struct cvmx_pcsxx_misc_ctl_reg_s cn52xx;
+	struct cvmx_pcsxx_misc_ctl_reg_s cn52xxp1;
+	struct cvmx_pcsxx_misc_ctl_reg_s cn56xx;
+	struct cvmx_pcsxx_misc_ctl_reg_s cn56xxp1;
+} cvmx_pcsxx_misc_ctl_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsxx_rx_sync_states_reg_s {
+		uint64_t reserved_16_63:48;
+		uint64_t sync3st:4;
+		uint64_t sync2st:4;
+		uint64_t sync1st:4;
+		uint64_t sync0st:4;
+	} s;
+	struct cvmx_pcsxx_rx_sync_states_reg_s cn52xx;
+	struct cvmx_pcsxx_rx_sync_states_reg_s cn52xxp1;
+	struct cvmx_pcsxx_rx_sync_states_reg_s cn56xx;
+	struct cvmx_pcsxx_rx_sync_states_reg_s cn56xxp1;
+} cvmx_pcsxx_rx_sync_states_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsxx_spd_abil_reg_s {
+		uint64_t reserved_2_63:62;
+		uint64_t tenpasst:1;
+		uint64_t tengb:1;
+	} s;
+	struct cvmx_pcsxx_spd_abil_reg_s cn52xx;
+	struct cvmx_pcsxx_spd_abil_reg_s cn52xxp1;
+	struct cvmx_pcsxx_spd_abil_reg_s cn56xx;
+	struct cvmx_pcsxx_spd_abil_reg_s cn56xxp1;
+} cvmx_pcsxx_spd_abil_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsxx_status1_reg_s {
+		uint64_t reserved_8_63:56;
+		uint64_t flt:1;
+		uint64_t reserved_3_6:4;
+		uint64_t rcv_lnk:1;
+		uint64_t lpable:1;
+		uint64_t reserved_0_0:1;
+	} s;
+	struct cvmx_pcsxx_status1_reg_s cn52xx;
+	struct cvmx_pcsxx_status1_reg_s cn52xxp1;
+	struct cvmx_pcsxx_status1_reg_s cn56xx;
+	struct cvmx_pcsxx_status1_reg_s cn56xxp1;
+} cvmx_pcsxx_status1_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsxx_status2_reg_s {
+		uint64_t reserved_16_63:48;
+		uint64_t dev:2;
+		uint64_t reserved_12_13:2;
+		uint64_t xmtflt:1;
+		uint64_t rcvflt:1;
+		uint64_t reserved_3_9:7;
+		uint64_t tengb_w:1;
+		uint64_t tengb_x:1;
+		uint64_t tengb_r:1;
+	} s;
+	struct cvmx_pcsxx_status2_reg_s cn52xx;
+	struct cvmx_pcsxx_status2_reg_s cn52xxp1;
+	struct cvmx_pcsxx_status2_reg_s cn56xx;
+	struct cvmx_pcsxx_status2_reg_s cn56xxp1;
+} cvmx_pcsxx_status2_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsxx_tx_rx_polarity_reg_s {
+		uint64_t reserved_10_63:54;
+		uint64_t xor_rxplrt:4;
+		uint64_t xor_txplrt:4;
+		uint64_t rxplrt:1;
+		uint64_t txplrt:1;
+	} s;
+	struct cvmx_pcsxx_tx_rx_polarity_reg_s cn52xx;
+	struct cvmx_pcsxx_tx_rx_polarity_reg_cn52xxp1 {
+		uint64_t reserved_2_63:62;
+		uint64_t rxplrt:1;
+		uint64_t txplrt:1;
+	} cn52xxp1;
+	struct cvmx_pcsxx_tx_rx_polarity_reg_s cn56xx;
+	struct cvmx_pcsxx_tx_rx_polarity_reg_cn52xxp1 cn56xxp1;
+} cvmx_pcsxx_tx_rx_polarity_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pcsxx_tx_rx_states_reg_s {
+		uint64_t reserved_14_63:50;
+		uint64_t term_err:1;
+		uint64_t syn3bad:1;
+		uint64_t syn2bad:1;
+		uint64_t syn1bad:1;
+		uint64_t syn0bad:1;
+		uint64_t rxbad:1;
+		uint64_t algn_st:3;
+		uint64_t rx_st:2;
+		uint64_t tx_st:3;
+	} s;
+	struct cvmx_pcsxx_tx_rx_states_reg_s cn52xx;
+	struct cvmx_pcsxx_tx_rx_states_reg_cn52xxp1 {
+		uint64_t reserved_13_63:51;
+		uint64_t syn3bad:1;
+		uint64_t syn2bad:1;
+		uint64_t syn1bad:1;
+		uint64_t syn0bad:1;
+		uint64_t rxbad:1;
+		uint64_t algn_st:3;
+		uint64_t rx_st:2;
+		uint64_t tx_st:3;
+	} cn52xxp1;
+	struct cvmx_pcsxx_tx_rx_states_reg_s cn56xx;
+	struct cvmx_pcsxx_tx_rx_states_reg_cn52xxp1 cn56xxp1;
+} cvmx_pcsxx_tx_rx_states_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pescx_bist_status_s {
+		uint64_t reserved_13_63:51;
+		uint64_t rqdata5:1;
+		uint64_t ctlp_or:1;
+		uint64_t ntlp_or:1;
+		uint64_t ptlp_or:1;
+		uint64_t retry:1;
+		uint64_t rqdata0:1;
+		uint64_t rqdata1:1;
+		uint64_t rqdata2:1;
+		uint64_t rqdata3:1;
+		uint64_t rqdata4:1;
+		uint64_t rqhdr1:1;
+		uint64_t rqhdr0:1;
+		uint64_t sot:1;
+	} s;
+	struct cvmx_pescx_bist_status_s cn52xx;
+	struct cvmx_pescx_bist_status_cn52xxp1 {
+		uint64_t reserved_12_63:52;
+		uint64_t ctlp_or:1;
+		uint64_t ntlp_or:1;
+		uint64_t ptlp_or:1;
+		uint64_t retry:1;
+		uint64_t rqdata0:1;
+		uint64_t rqdata1:1;
+		uint64_t rqdata2:1;
+		uint64_t rqdata3:1;
+		uint64_t rqdata4:1;
+		uint64_t rqhdr1:1;
+		uint64_t rqhdr0:1;
+		uint64_t sot:1;
+	} cn52xxp1;
+	struct cvmx_pescx_bist_status_s cn56xx;
+	struct cvmx_pescx_bist_status_cn52xxp1 cn56xxp1;
+} cvmx_pescx_bist_status_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pescx_bist_status2_s {
+		uint64_t reserved_14_63:50;
+		uint64_t cto_p2e:1;
+		uint64_t e2p_cpl:1;
+		uint64_t e2p_n:1;
+		uint64_t e2p_p:1;
+		uint64_t e2p_rsl:1;
+		uint64_t dbg_p2e:1;
+		uint64_t peai_p2e:1;
+		uint64_t rsl_p2e:1;
+		uint64_t pef_tpf1:1;
+		uint64_t pef_tpf0:1;
+		uint64_t pef_tnf:1;
+		uint64_t pef_tcf1:1;
+		uint64_t pef_tc0:1;
+		uint64_t ppf:1;
+	} s;
+	struct cvmx_pescx_bist_status2_s cn52xx;
+	struct cvmx_pescx_bist_status2_s cn52xxp1;
+	struct cvmx_pescx_bist_status2_s cn56xx;
+	struct cvmx_pescx_bist_status2_s cn56xxp1;
+} cvmx_pescx_bist_status2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pescx_cfg_rd_s {
+		uint64_t data:32;
+		uint64_t addr:32;
+	} s;
+	struct cvmx_pescx_cfg_rd_s cn52xx;
+	struct cvmx_pescx_cfg_rd_s cn52xxp1;
+	struct cvmx_pescx_cfg_rd_s cn56xx;
+	struct cvmx_pescx_cfg_rd_s cn56xxp1;
+} cvmx_pescx_cfg_rd_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pescx_cfg_wr_s {
+		uint64_t data:32;
+		uint64_t addr:32;
+	} s;
+	struct cvmx_pescx_cfg_wr_s cn52xx;
+	struct cvmx_pescx_cfg_wr_s cn52xxp1;
+	struct cvmx_pescx_cfg_wr_s cn56xx;
+	struct cvmx_pescx_cfg_wr_s cn56xxp1;
+} cvmx_pescx_cfg_wr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pescx_cpl_lut_valid_s {
+		uint64_t reserved_32_63:32;
+		uint64_t tag:32;
+	} s;
+	struct cvmx_pescx_cpl_lut_valid_s cn52xx;
+	struct cvmx_pescx_cpl_lut_valid_s cn52xxp1;
+	struct cvmx_pescx_cpl_lut_valid_s cn56xx;
+	struct cvmx_pescx_cpl_lut_valid_s cn56xxp1;
+} cvmx_pescx_cpl_lut_valid_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pescx_ctl_status_s {
+		uint64_t reserved_28_63:36;
+		uint64_t dnum:5;
+		uint64_t pbus:8;
+		uint64_t qlm_cfg:2;
+		uint64_t lane_swp:1;
+		uint64_t pm_xtoff:1;
+		uint64_t pm_xpme:1;
+		uint64_t ob_p_cmd:1;
+		uint64_t reserved_7_8:2;
+		uint64_t nf_ecrc:1;
+		uint64_t dly_one:1;
+		uint64_t lnk_enb:1;
+		uint64_t ro_ctlp:1;
+		uint64_t reserved_2_2:1;
+		uint64_t inv_ecrc:1;
+		uint64_t inv_lcrc:1;
+	} s;
+	struct cvmx_pescx_ctl_status_s cn52xx;
+	struct cvmx_pescx_ctl_status_s cn52xxp1;
+	struct cvmx_pescx_ctl_status_cn56xx {
+		uint64_t reserved_28_63:36;
+		uint64_t dnum:5;
+		uint64_t pbus:8;
+		uint64_t qlm_cfg:2;
+		uint64_t reserved_12_12:1;
+		uint64_t pm_xtoff:1;
+		uint64_t pm_xpme:1;
+		uint64_t ob_p_cmd:1;
+		uint64_t reserved_7_8:2;
+		uint64_t nf_ecrc:1;
+		uint64_t dly_one:1;
+		uint64_t lnk_enb:1;
+		uint64_t ro_ctlp:1;
+		uint64_t reserved_2_2:1;
+		uint64_t inv_ecrc:1;
+		uint64_t inv_lcrc:1;
+	} cn56xx;
+	struct cvmx_pescx_ctl_status_cn56xx cn56xxp1;
+} cvmx_pescx_ctl_status_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pescx_ctl_status2_s {
+		uint64_t reserved_2_63:62;
+		uint64_t pclk_run:1;
+		uint64_t pcierst:1;
+	} s;
+	struct cvmx_pescx_ctl_status2_s cn52xx;
+	struct cvmx_pescx_ctl_status2_cn52xxp1 {
+		uint64_t reserved_1_63:63;
+		uint64_t pcierst:1;
+	} cn52xxp1;
+	struct cvmx_pescx_ctl_status2_s cn56xx;
+	struct cvmx_pescx_ctl_status2_cn52xxp1 cn56xxp1;
+} cvmx_pescx_ctl_status2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pescx_dbg_info_s {
+		uint64_t reserved_31_63:33;
+		uint64_t ecrc_e:1;
+		uint64_t rawwpp:1;
+		uint64_t racpp:1;
+		uint64_t ramtlp:1;
+		uint64_t rarwdns:1;
+		uint64_t caar:1;
+		uint64_t racca:1;
+		uint64_t racur:1;
+		uint64_t rauc:1;
+		uint64_t rqo:1;
+		uint64_t fcuv:1;
+		uint64_t rpe:1;
+		uint64_t fcpvwt:1;
+		uint64_t dpeoosd:1;
+		uint64_t rtwdle:1;
+		uint64_t rdwdle:1;
+		uint64_t mre:1;
+		uint64_t rte:1;
+		uint64_t acto:1;
+		uint64_t rvdm:1;
+		uint64_t rumep:1;
+		uint64_t rptamrc:1;
+		uint64_t rpmerc:1;
+		uint64_t rfemrc:1;
+		uint64_t rnfemrc:1;
+		uint64_t rcemrc:1;
+		uint64_t rpoison:1;
+		uint64_t recrce:1;
+		uint64_t rtlplle:1;
+		uint64_t rtlpmal:1;
+		uint64_t spoison:1;
+	} s;
+	struct cvmx_pescx_dbg_info_s cn52xx;
+	struct cvmx_pescx_dbg_info_s cn52xxp1;
+	struct cvmx_pescx_dbg_info_s cn56xx;
+	struct cvmx_pescx_dbg_info_s cn56xxp1;
+} cvmx_pescx_dbg_info_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pescx_dbg_info_en_s {
+		uint64_t reserved_31_63:33;
+		uint64_t ecrc_e:1;
+		uint64_t rawwpp:1;
+		uint64_t racpp:1;
+		uint64_t ramtlp:1;
+		uint64_t rarwdns:1;
+		uint64_t caar:1;
+		uint64_t racca:1;
+		uint64_t racur:1;
+		uint64_t rauc:1;
+		uint64_t rqo:1;
+		uint64_t fcuv:1;
+		uint64_t rpe:1;
+		uint64_t fcpvwt:1;
+		uint64_t dpeoosd:1;
+		uint64_t rtwdle:1;
+		uint64_t rdwdle:1;
+		uint64_t mre:1;
+		uint64_t rte:1;
+		uint64_t acto:1;
+		uint64_t rvdm:1;
+		uint64_t rumep:1;
+		uint64_t rptamrc:1;
+		uint64_t rpmerc:1;
+		uint64_t rfemrc:1;
+		uint64_t rnfemrc:1;
+		uint64_t rcemrc:1;
+		uint64_t rpoison:1;
+		uint64_t recrce:1;
+		uint64_t rtlplle:1;
+		uint64_t rtlpmal:1;
+		uint64_t spoison:1;
+	} s;
+	struct cvmx_pescx_dbg_info_en_s cn52xx;
+	struct cvmx_pescx_dbg_info_en_s cn52xxp1;
+	struct cvmx_pescx_dbg_info_en_s cn56xx;
+	struct cvmx_pescx_dbg_info_en_s cn56xxp1;
+} cvmx_pescx_dbg_info_en_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pescx_diag_status_s {
+		uint64_t reserved_4_63:60;
+		uint64_t pm_dst:1;
+		uint64_t pm_stat:1;
+		uint64_t pm_en:1;
+		uint64_t aux_en:1;
+	} s;
+	struct cvmx_pescx_diag_status_s cn52xx;
+	struct cvmx_pescx_diag_status_s cn52xxp1;
+	struct cvmx_pescx_diag_status_s cn56xx;
+	struct cvmx_pescx_diag_status_s cn56xxp1;
+} cvmx_pescx_diag_status_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pescx_p2n_bar0_start_s {
+		uint64_t addr:50;
+		uint64_t reserved_0_13:14;
+	} s;
+	struct cvmx_pescx_p2n_bar0_start_s cn52xx;
+	struct cvmx_pescx_p2n_bar0_start_s cn52xxp1;
+	struct cvmx_pescx_p2n_bar0_start_s cn56xx;
+	struct cvmx_pescx_p2n_bar0_start_s cn56xxp1;
+} cvmx_pescx_p2n_bar0_start_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pescx_p2n_bar1_start_s {
+		uint64_t addr:38;
+		uint64_t reserved_0_25:26;
+	} s;
+	struct cvmx_pescx_p2n_bar1_start_s cn52xx;
+	struct cvmx_pescx_p2n_bar1_start_s cn52xxp1;
+	struct cvmx_pescx_p2n_bar1_start_s cn56xx;
+	struct cvmx_pescx_p2n_bar1_start_s cn56xxp1;
+} cvmx_pescx_p2n_bar1_start_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pescx_p2n_bar2_start_s {
+		uint64_t addr:25;
+		uint64_t reserved_0_38:39;
+	} s;
+	struct cvmx_pescx_p2n_bar2_start_s cn52xx;
+	struct cvmx_pescx_p2n_bar2_start_s cn52xxp1;
+	struct cvmx_pescx_p2n_bar2_start_s cn56xx;
+	struct cvmx_pescx_p2n_bar2_start_s cn56xxp1;
+} cvmx_pescx_p2n_bar2_start_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pescx_p2p_barx_end_s {
+		uint64_t addr:52;
+		uint64_t reserved_0_11:12;
+	} s;
+	struct cvmx_pescx_p2p_barx_end_s cn52xx;
+	struct cvmx_pescx_p2p_barx_end_s cn52xxp1;
+	struct cvmx_pescx_p2p_barx_end_s cn56xx;
+	struct cvmx_pescx_p2p_barx_end_s cn56xxp1;
+} cvmx_pescx_p2p_barx_end_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pescx_p2p_barx_start_s {
+		uint64_t addr:52;
+		uint64_t reserved_0_11:12;
+	} s;
+	struct cvmx_pescx_p2p_barx_start_s cn52xx;
+	struct cvmx_pescx_p2p_barx_start_s cn52xxp1;
+	struct cvmx_pescx_p2p_barx_start_s cn56xx;
+	struct cvmx_pescx_p2p_barx_start_s cn56xxp1;
+} cvmx_pescx_p2p_barx_start_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pescx_tlp_credits_s {
+		uint64_t reserved_0_63:64;
+	} s;
+	struct cvmx_pescx_tlp_credits_cn52xx {
+		uint64_t reserved_56_63:8;
+		uint64_t peai_ppf:8;
+		uint64_t pesc_cpl:8;
+		uint64_t pesc_np:8;
+		uint64_t pesc_p:8;
+		uint64_t npei_cpl:8;
+		uint64_t npei_np:8;
+		uint64_t npei_p:8;
+	} cn52xx;
+	struct cvmx_pescx_tlp_credits_cn52xxp1 {
+		uint64_t reserved_38_63:26;
+		uint64_t peai_ppf:8;
+		uint64_t pesc_cpl:5;
+		uint64_t pesc_np:5;
+		uint64_t pesc_p:5;
+		uint64_t npei_cpl:5;
+		uint64_t npei_np:5;
+		uint64_t npei_p:5;
+	} cn52xxp1;
+	struct cvmx_pescx_tlp_credits_cn52xx cn56xx;
+	struct cvmx_pescx_tlp_credits_cn52xxp1 cn56xxp1;
+} cvmx_pescx_tlp_credits_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_bck_prs_s {
+		uint64_t bckprs:1;
+		uint64_t reserved_13_62:50;
+		uint64_t hiwater:5;
+		uint64_t reserved_5_7:3;
+		uint64_t lowater:5;
+	} s;
+	struct cvmx_pip_bck_prs_s cn38xx;
+	struct cvmx_pip_bck_prs_s cn38xxp2;
+	struct cvmx_pip_bck_prs_s cn56xx;
+	struct cvmx_pip_bck_prs_s cn56xxp1;
+	struct cvmx_pip_bck_prs_s cn58xx;
+	struct cvmx_pip_bck_prs_s cn58xxp1;
+} cvmx_pip_bck_prs_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_bist_status_s {
+		uint64_t reserved_18_63:46;
+		uint64_t bist:18;
+	} s;
+	struct cvmx_pip_bist_status_s cn30xx;
+	struct cvmx_pip_bist_status_s cn31xx;
+	struct cvmx_pip_bist_status_s cn38xx;
+	struct cvmx_pip_bist_status_s cn38xxp2;
+	struct cvmx_pip_bist_status_cn50xx {
+		uint64_t reserved_17_63:47;
+		uint64_t bist:17;
+	} cn50xx;
+	struct cvmx_pip_bist_status_s cn52xx;
+	struct cvmx_pip_bist_status_s cn52xxp1;
+	struct cvmx_pip_bist_status_s cn56xx;
+	struct cvmx_pip_bist_status_s cn56xxp1;
+	struct cvmx_pip_bist_status_s cn58xx;
+	struct cvmx_pip_bist_status_s cn58xxp1;
+} cvmx_pip_bist_status_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_crc_ctlx_s {
+		uint64_t reserved_2_63:62;
+		uint64_t invres:1;
+		uint64_t reflect:1;
+	} s;
+	struct cvmx_pip_crc_ctlx_s cn38xx;
+	struct cvmx_pip_crc_ctlx_s cn38xxp2;
+	struct cvmx_pip_crc_ctlx_s cn58xx;
+	struct cvmx_pip_crc_ctlx_s cn58xxp1;
+} cvmx_pip_crc_ctlx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_crc_ivx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t iv:32;
+	} s;
+	struct cvmx_pip_crc_ivx_s cn38xx;
+	struct cvmx_pip_crc_ivx_s cn38xxp2;
+	struct cvmx_pip_crc_ivx_s cn58xx;
+	struct cvmx_pip_crc_ivx_s cn58xxp1;
+} cvmx_pip_crc_ivx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_dec_ipsecx_s {
+		uint64_t reserved_18_63:46;
+		uint64_t tcp:1;
+		uint64_t udp:1;
+		uint64_t dprt:16;
+	} s;
+	struct cvmx_pip_dec_ipsecx_s cn30xx;
+	struct cvmx_pip_dec_ipsecx_s cn31xx;
+	struct cvmx_pip_dec_ipsecx_s cn38xx;
+	struct cvmx_pip_dec_ipsecx_s cn38xxp2;
+	struct cvmx_pip_dec_ipsecx_s cn50xx;
+	struct cvmx_pip_dec_ipsecx_s cn52xx;
+	struct cvmx_pip_dec_ipsecx_s cn52xxp1;
+	struct cvmx_pip_dec_ipsecx_s cn56xx;
+	struct cvmx_pip_dec_ipsecx_s cn56xxp1;
+	struct cvmx_pip_dec_ipsecx_s cn58xx;
+	struct cvmx_pip_dec_ipsecx_s cn58xxp1;
+} cvmx_pip_dec_ipsecx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_dsa_src_grp_s {
+		uint64_t map15:4;
+		uint64_t map14:4;
+		uint64_t map13:4;
+		uint64_t map12:4;
+		uint64_t map11:4;
+		uint64_t map10:4;
+		uint64_t map9:4;
+		uint64_t map8:4;
+		uint64_t map7:4;
+		uint64_t map6:4;
+		uint64_t map5:4;
+		uint64_t map4:4;
+		uint64_t map3:4;
+		uint64_t map2:4;
+		uint64_t map1:4;
+		uint64_t map0:4;
+	} s;
+	struct cvmx_pip_dsa_src_grp_s cn52xx;
+	struct cvmx_pip_dsa_src_grp_s cn52xxp1;
+	struct cvmx_pip_dsa_src_grp_s cn56xx;
+} cvmx_pip_dsa_src_grp_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_dsa_vid_grp_s {
+		uint64_t map15:4;
+		uint64_t map14:4;
+		uint64_t map13:4;
+		uint64_t map12:4;
+		uint64_t map11:4;
+		uint64_t map10:4;
+		uint64_t map9:4;
+		uint64_t map8:4;
+		uint64_t map7:4;
+		uint64_t map6:4;
+		uint64_t map5:4;
+		uint64_t map4:4;
+		uint64_t map3:4;
+		uint64_t map2:4;
+		uint64_t map1:4;
+		uint64_t map0:4;
+	} s;
+	struct cvmx_pip_dsa_vid_grp_s cn52xx;
+	struct cvmx_pip_dsa_vid_grp_s cn52xxp1;
+	struct cvmx_pip_dsa_vid_grp_s cn56xx;
+} cvmx_pip_dsa_vid_grp_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_frm_len_chkx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t maxlen:16;
+		uint64_t minlen:16;
+	} s;
+	struct cvmx_pip_frm_len_chkx_s cn50xx;
+	struct cvmx_pip_frm_len_chkx_s cn52xx;
+	struct cvmx_pip_frm_len_chkx_s cn52xxp1;
+	struct cvmx_pip_frm_len_chkx_s cn56xx;
+	struct cvmx_pip_frm_len_chkx_s cn56xxp1;
+} cvmx_pip_frm_len_chkx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_gbl_cfg_s {
+		uint64_t reserved_19_63:45;
+		uint64_t tag_syn:1;
+		uint64_t ip6_udp:1;
+		uint64_t max_l2:1;
+		uint64_t reserved_11_15:5;
+		uint64_t raw_shf:3;
+		uint64_t reserved_3_7:5;
+		uint64_t nip_shf:3;
+	} s;
+	struct cvmx_pip_gbl_cfg_s cn30xx;
+	struct cvmx_pip_gbl_cfg_s cn31xx;
+	struct cvmx_pip_gbl_cfg_s cn38xx;
+	struct cvmx_pip_gbl_cfg_s cn38xxp2;
+	struct cvmx_pip_gbl_cfg_s cn50xx;
+	struct cvmx_pip_gbl_cfg_s cn52xx;
+	struct cvmx_pip_gbl_cfg_s cn52xxp1;
+	struct cvmx_pip_gbl_cfg_s cn56xx;
+	struct cvmx_pip_gbl_cfg_s cn56xxp1;
+	struct cvmx_pip_gbl_cfg_s cn58xx;
+	struct cvmx_pip_gbl_cfg_s cn58xxp1;
+} cvmx_pip_gbl_cfg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_gbl_ctl_s {
+		uint64_t reserved_27_63:37;
+		uint64_t dsa_grp_tvid:1;
+		uint64_t dsa_grp_scmd:1;
+		uint64_t dsa_grp_sid:1;
+		uint64_t reserved_21_23:3;
+		uint64_t ring_en:1;
+		uint64_t reserved_17_19:3;
+		uint64_t ignrs:1;
+		uint64_t vs_wqe:1;
+		uint64_t vs_qos:1;
+		uint64_t l2_mal:1;
+		uint64_t tcp_flag:1;
+		uint64_t l4_len:1;
+		uint64_t l4_chk:1;
+		uint64_t l4_prt:1;
+		uint64_t l4_mal:1;
+		uint64_t reserved_6_7:2;
+		uint64_t ip6_eext:2;
+		uint64_t ip4_opts:1;
+		uint64_t ip_hop:1;
+		uint64_t ip_mal:1;
+		uint64_t ip_chk:1;
+	} s;
+	struct cvmx_pip_gbl_ctl_cn30xx {
+		uint64_t reserved_17_63:47;
+		uint64_t ignrs:1;
+		uint64_t vs_wqe:1;
+		uint64_t vs_qos:1;
+		uint64_t l2_mal:1;
+		uint64_t tcp_flag:1;
+		uint64_t l4_len:1;
+		uint64_t l4_chk:1;
+		uint64_t l4_prt:1;
+		uint64_t l4_mal:1;
+		uint64_t reserved_6_7:2;
+		uint64_t ip6_eext:2;
+		uint64_t ip4_opts:1;
+		uint64_t ip_hop:1;
+		uint64_t ip_mal:1;
+		uint64_t ip_chk:1;
+	} cn30xx;
+	struct cvmx_pip_gbl_ctl_cn30xx cn31xx;
+	struct cvmx_pip_gbl_ctl_cn30xx cn38xx;
+	struct cvmx_pip_gbl_ctl_cn30xx cn38xxp2;
+	struct cvmx_pip_gbl_ctl_cn30xx cn50xx;
+	struct cvmx_pip_gbl_ctl_s cn52xx;
+	struct cvmx_pip_gbl_ctl_s cn52xxp1;
+	struct cvmx_pip_gbl_ctl_s cn56xx;
+	struct cvmx_pip_gbl_ctl_cn56xxp1 {
+		uint64_t reserved_21_63:43;
+		uint64_t ring_en:1;
+		uint64_t reserved_17_19:3;
+		uint64_t ignrs:1;
+		uint64_t vs_wqe:1;
+		uint64_t vs_qos:1;
+		uint64_t l2_mal:1;
+		uint64_t tcp_flag:1;
+		uint64_t l4_len:1;
+		uint64_t l4_chk:1;
+		uint64_t l4_prt:1;
+		uint64_t l4_mal:1;
+		uint64_t reserved_6_7:2;
+		uint64_t ip6_eext:2;
+		uint64_t ip4_opts:1;
+		uint64_t ip_hop:1;
+		uint64_t ip_mal:1;
+		uint64_t ip_chk:1;
+	} cn56xxp1;
+	struct cvmx_pip_gbl_ctl_cn30xx cn58xx;
+	struct cvmx_pip_gbl_ctl_cn30xx cn58xxp1;
+} cvmx_pip_gbl_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_hg_pri_qos_s {
+		uint64_t reserved_11_63:53;
+		uint64_t qos:3;
+		uint64_t reserved_6_7:2;
+		uint64_t pri:6;
+	} s;
+	struct cvmx_pip_hg_pri_qos_s cn52xx;
+	struct cvmx_pip_hg_pri_qos_s cn52xxp1;
+	struct cvmx_pip_hg_pri_qos_s cn56xx;
+} cvmx_pip_hg_pri_qos_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_int_en_s {
+		uint64_t reserved_13_63:51;
+		uint64_t punyerr:1;
+		uint64_t lenerr:1;
+		uint64_t maxerr:1;
+		uint64_t minerr:1;
+		uint64_t beperr:1;
+		uint64_t feperr:1;
+		uint64_t todoovr:1;
+		uint64_t skprunt:1;
+		uint64_t badtag:1;
+		uint64_t prtnxa:1;
+		uint64_t bckprs:1;
+		uint64_t crcerr:1;
+		uint64_t pktdrp:1;
+	} s;
+	struct cvmx_pip_int_en_cn30xx {
+		uint64_t reserved_9_63:55;
+		uint64_t beperr:1;
+		uint64_t feperr:1;
+		uint64_t todoovr:1;
+		uint64_t skprunt:1;
+		uint64_t badtag:1;
+		uint64_t prtnxa:1;
+		uint64_t bckprs:1;
+		uint64_t crcerr:1;
+		uint64_t pktdrp:1;
+	} cn30xx;
+	struct cvmx_pip_int_en_cn30xx cn31xx;
+	struct cvmx_pip_int_en_cn30xx cn38xx;
+	struct cvmx_pip_int_en_cn30xx cn38xxp2;
+	struct cvmx_pip_int_en_cn50xx {
+		uint64_t reserved_12_63:52;
+		uint64_t lenerr:1;
+		uint64_t maxerr:1;
+		uint64_t minerr:1;
+		uint64_t beperr:1;
+		uint64_t feperr:1;
+		uint64_t todoovr:1;
+		uint64_t skprunt:1;
+		uint64_t badtag:1;
+		uint64_t prtnxa:1;
+		uint64_t bckprs:1;
+		uint64_t reserved_1_1:1;
+		uint64_t pktdrp:1;
+	} cn50xx;
+	struct cvmx_pip_int_en_cn52xx {
+		uint64_t reserved_13_63:51;
+		uint64_t punyerr:1;
+		uint64_t lenerr:1;
+		uint64_t maxerr:1;
+		uint64_t minerr:1;
+		uint64_t beperr:1;
+		uint64_t feperr:1;
+		uint64_t todoovr:1;
+		uint64_t skprunt:1;
+		uint64_t badtag:1;
+		uint64_t prtnxa:1;
+		uint64_t bckprs:1;
+		uint64_t reserved_1_1:1;
+		uint64_t pktdrp:1;
+	} cn52xx;
+	struct cvmx_pip_int_en_cn52xx cn52xxp1;
+	struct cvmx_pip_int_en_s cn56xx;
+	struct cvmx_pip_int_en_cn56xxp1 {
+		uint64_t reserved_12_63:52;
+		uint64_t lenerr:1;
+		uint64_t maxerr:1;
+		uint64_t minerr:1;
+		uint64_t beperr:1;
+		uint64_t feperr:1;
+		uint64_t todoovr:1;
+		uint64_t skprunt:1;
+		uint64_t badtag:1;
+		uint64_t prtnxa:1;
+		uint64_t bckprs:1;
+		uint64_t crcerr:1;
+		uint64_t pktdrp:1;
+	} cn56xxp1;
+	struct cvmx_pip_int_en_cn58xx {
+		uint64_t reserved_13_63:51;
+		uint64_t punyerr:1;
+		uint64_t reserved_9_11:3;
+		uint64_t beperr:1;
+		uint64_t feperr:1;
+		uint64_t todoovr:1;
+		uint64_t skprunt:1;
+		uint64_t badtag:1;
+		uint64_t prtnxa:1;
+		uint64_t bckprs:1;
+		uint64_t crcerr:1;
+		uint64_t pktdrp:1;
+	} cn58xx;
+	struct cvmx_pip_int_en_cn30xx cn58xxp1;
+} cvmx_pip_int_en_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_int_reg_s {
+		uint64_t reserved_13_63:51;
+		uint64_t punyerr:1;
+		uint64_t lenerr:1;
+		uint64_t maxerr:1;
+		uint64_t minerr:1;
+		uint64_t beperr:1;
+		uint64_t feperr:1;
+		uint64_t todoovr:1;
+		uint64_t skprunt:1;
+		uint64_t badtag:1;
+		uint64_t prtnxa:1;
+		uint64_t bckprs:1;
+		uint64_t crcerr:1;
+		uint64_t pktdrp:1;
+	} s;
+	struct cvmx_pip_int_reg_cn30xx {
+		uint64_t reserved_9_63:55;
+		uint64_t beperr:1;
+		uint64_t feperr:1;
+		uint64_t todoovr:1;
+		uint64_t skprunt:1;
+		uint64_t badtag:1;
+		uint64_t prtnxa:1;
+		uint64_t bckprs:1;
+		uint64_t crcerr:1;
+		uint64_t pktdrp:1;
+	} cn30xx;
+	struct cvmx_pip_int_reg_cn30xx cn31xx;
+	struct cvmx_pip_int_reg_cn30xx cn38xx;
+	struct cvmx_pip_int_reg_cn30xx cn38xxp2;
+	struct cvmx_pip_int_reg_cn50xx {
+		uint64_t reserved_12_63:52;
+		uint64_t lenerr:1;
+		uint64_t maxerr:1;
+		uint64_t minerr:1;
+		uint64_t beperr:1;
+		uint64_t feperr:1;
+		uint64_t todoovr:1;
+		uint64_t skprunt:1;
+		uint64_t badtag:1;
+		uint64_t prtnxa:1;
+		uint64_t bckprs:1;
+		uint64_t reserved_1_1:1;
+		uint64_t pktdrp:1;
+	} cn50xx;
+	struct cvmx_pip_int_reg_cn52xx {
+		uint64_t reserved_13_63:51;
+		uint64_t punyerr:1;
+		uint64_t lenerr:1;
+		uint64_t maxerr:1;
+		uint64_t minerr:1;
+		uint64_t beperr:1;
+		uint64_t feperr:1;
+		uint64_t todoovr:1;
+		uint64_t skprunt:1;
+		uint64_t badtag:1;
+		uint64_t prtnxa:1;
+		uint64_t bckprs:1;
+		uint64_t reserved_1_1:1;
+		uint64_t pktdrp:1;
+	} cn52xx;
+	struct cvmx_pip_int_reg_cn52xx cn52xxp1;
+	struct cvmx_pip_int_reg_s cn56xx;
+	struct cvmx_pip_int_reg_cn56xxp1 {
+		uint64_t reserved_12_63:52;
+		uint64_t lenerr:1;
+		uint64_t maxerr:1;
+		uint64_t minerr:1;
+		uint64_t beperr:1;
+		uint64_t feperr:1;
+		uint64_t todoovr:1;
+		uint64_t skprunt:1;
+		uint64_t badtag:1;
+		uint64_t prtnxa:1;
+		uint64_t bckprs:1;
+		uint64_t crcerr:1;
+		uint64_t pktdrp:1;
+	} cn56xxp1;
+	struct cvmx_pip_int_reg_cn58xx {
+		uint64_t reserved_13_63:51;
+		uint64_t punyerr:1;
+		uint64_t reserved_9_11:3;
+		uint64_t beperr:1;
+		uint64_t feperr:1;
+		uint64_t todoovr:1;
+		uint64_t skprunt:1;
+		uint64_t badtag:1;
+		uint64_t prtnxa:1;
+		uint64_t bckprs:1;
+		uint64_t crcerr:1;
+		uint64_t pktdrp:1;
+	} cn58xx;
+	struct cvmx_pip_int_reg_cn30xx cn58xxp1;
+} cvmx_pip_int_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_ip_offset_s {
+		uint64_t reserved_3_63:61;
+		uint64_t offset:3;
+	} s;
+	struct cvmx_pip_ip_offset_s cn30xx;
+	struct cvmx_pip_ip_offset_s cn31xx;
+	struct cvmx_pip_ip_offset_s cn38xx;
+	struct cvmx_pip_ip_offset_s cn38xxp2;
+	struct cvmx_pip_ip_offset_s cn50xx;
+	struct cvmx_pip_ip_offset_s cn52xx;
+	struct cvmx_pip_ip_offset_s cn52xxp1;
+	struct cvmx_pip_ip_offset_s cn56xx;
+	struct cvmx_pip_ip_offset_s cn56xxp1;
+	struct cvmx_pip_ip_offset_s cn58xx;
+	struct cvmx_pip_ip_offset_s cn58xxp1;
+} cvmx_pip_ip_offset_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_prt_cfgx_s {
+		uint64_t reserved_53_63:11;
+		uint64_t pad_len:1;
+		uint64_t vlan_len:1;
+		uint64_t lenerr_en:1;
+		uint64_t maxerr_en:1;
+		uint64_t minerr_en:1;
+		uint64_t grp_wat_47:4;
+		uint64_t qos_wat_47:4;
+		uint64_t reserved_37_39:3;
+		uint64_t rawdrp:1;
+		uint64_t tag_inc:2;
+		uint64_t dyn_rs:1;
+		uint64_t inst_hdr:1;
+		uint64_t grp_wat:4;
+		uint64_t hg_qos:1;
+		uint64_t qos:3;
+		uint64_t qos_wat:4;
+		uint64_t qos_vsel:1;
+		uint64_t qos_vod:1;
+		uint64_t qos_diff:1;
+		uint64_t qos_vlan:1;
+		uint64_t reserved_13_15:3;
+		uint64_t crc_en:1;
+		uint64_t higig_en:1;
+		uint64_t dsa_en:1;
+		cvmx_pip_port_parse_mode_t mode:2;
+		uint64_t reserved_7_7:1;
+		uint64_t skip:7;
+	} s;
+	struct cvmx_pip_prt_cfgx_cn30xx {
+		uint64_t reserved_37_63:27;
+		uint64_t rawdrp:1;
+		uint64_t tag_inc:2;
+		uint64_t dyn_rs:1;
+		uint64_t inst_hdr:1;
+		uint64_t grp_wat:4;
+		uint64_t reserved_27_27:1;
+		uint64_t qos:3;
+		uint64_t qos_wat:4;
+		uint64_t reserved_18_19:2;
+		uint64_t qos_diff:1;
+		uint64_t qos_vlan:1;
+		uint64_t reserved_10_15:6;
+		cvmx_pip_port_parse_mode_t mode:2;
+		uint64_t reserved_7_7:1;
+		uint64_t skip:7;
+	} cn30xx;
+	struct cvmx_pip_prt_cfgx_cn30xx cn31xx;
+	struct cvmx_pip_prt_cfgx_cn38xx {
+		uint64_t reserved_37_63:27;
+		uint64_t rawdrp:1;
+		uint64_t tag_inc:2;
+		uint64_t dyn_rs:1;
+		uint64_t inst_hdr:1;
+		uint64_t grp_wat:4;
+		uint64_t reserved_27_27:1;
+		uint64_t qos:3;
+		uint64_t qos_wat:4;
+		uint64_t reserved_18_19:2;
+		uint64_t qos_diff:1;
+		uint64_t qos_vlan:1;
+		uint64_t reserved_13_15:3;
+		uint64_t crc_en:1;
+		uint64_t reserved_10_11:2;
+		cvmx_pip_port_parse_mode_t mode:2;
+		uint64_t reserved_7_7:1;
+		uint64_t skip:7;
+	} cn38xx;
+	struct cvmx_pip_prt_cfgx_cn38xx cn38xxp2;
+	struct cvmx_pip_prt_cfgx_cn50xx {
+		uint64_t reserved_53_63:11;
+		uint64_t pad_len:1;
+		uint64_t vlan_len:1;
+		uint64_t lenerr_en:1;
+		uint64_t maxerr_en:1;
+		uint64_t minerr_en:1;
+		uint64_t grp_wat_47:4;
+		uint64_t qos_wat_47:4;
+		uint64_t reserved_37_39:3;
+		uint64_t rawdrp:1;
+		uint64_t tag_inc:2;
+		uint64_t dyn_rs:1;
+		uint64_t inst_hdr:1;
+		uint64_t grp_wat:4;
+		uint64_t reserved_27_27:1;
+		uint64_t qos:3;
+		uint64_t qos_wat:4;
+		uint64_t reserved_19_19:1;
+		uint64_t qos_vod:1;
+		uint64_t qos_diff:1;
+		uint64_t qos_vlan:1;
+		uint64_t reserved_13_15:3;
+		uint64_t crc_en:1;
+		uint64_t reserved_10_11:2;
+		cvmx_pip_port_parse_mode_t mode:2;
+		uint64_t reserved_7_7:1;
+		uint64_t skip:7;
+	} cn50xx;
+	struct cvmx_pip_prt_cfgx_s cn52xx;
+	struct cvmx_pip_prt_cfgx_s cn52xxp1;
+	struct cvmx_pip_prt_cfgx_s cn56xx;
+	struct cvmx_pip_prt_cfgx_cn50xx cn56xxp1;
+	struct cvmx_pip_prt_cfgx_cn58xx {
+		uint64_t reserved_37_63:27;
+		uint64_t rawdrp:1;
+		uint64_t tag_inc:2;
+		uint64_t dyn_rs:1;
+		uint64_t inst_hdr:1;
+		uint64_t grp_wat:4;
+		uint64_t reserved_27_27:1;
+		uint64_t qos:3;
+		uint64_t qos_wat:4;
+		uint64_t reserved_19_19:1;
+		uint64_t qos_vod:1;
+		uint64_t qos_diff:1;
+		uint64_t qos_vlan:1;
+		uint64_t reserved_13_15:3;
+		uint64_t crc_en:1;
+		uint64_t reserved_10_11:2;
+		cvmx_pip_port_parse_mode_t mode:2;
+		uint64_t reserved_7_7:1;
+		uint64_t skip:7;
+	} cn58xx;
+	struct cvmx_pip_prt_cfgx_cn58xx cn58xxp1;
+} cvmx_pip_prt_cfgx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_prt_tagx_s {
+		uint64_t reserved_40_63:24;
+		uint64_t grptagbase:4;
+		uint64_t grptagmask:4;
+		uint64_t grptag:1;
+		uint64_t grptag_mskip:1;
+		uint64_t tag_mode:2;
+		uint64_t inc_vs:2;
+		uint64_t inc_vlan:1;
+		uint64_t inc_prt_flag:1;
+		uint64_t ip6_dprt_flag:1;
+		uint64_t ip4_dprt_flag:1;
+		uint64_t ip6_sprt_flag:1;
+		uint64_t ip4_sprt_flag:1;
+		uint64_t ip6_nxth_flag:1;
+		uint64_t ip4_pctl_flag:1;
+		uint64_t ip6_dst_flag:1;
+		uint64_t ip4_dst_flag:1;
+		uint64_t ip6_src_flag:1;
+		uint64_t ip4_src_flag:1;
+		cvmx_pow_tag_type_t tcp6_tag_type:2;
+		cvmx_pow_tag_type_t tcp4_tag_type:2;
+		cvmx_pow_tag_type_t ip6_tag_type:2;
+		cvmx_pow_tag_type_t ip4_tag_type:2;
+		cvmx_pow_tag_type_t non_tag_type:2;
+		uint64_t grp:4;
+	} s;
+	struct cvmx_pip_prt_tagx_cn30xx {
+		uint64_t reserved_40_63:24;
+		uint64_t grptagbase:4;
+		uint64_t grptagmask:4;
+		uint64_t grptag:1;
+		uint64_t reserved_30_30:1;
+		uint64_t tag_mode:2;
+		uint64_t inc_vs:2;
+		uint64_t inc_vlan:1;
+		uint64_t inc_prt_flag:1;
+		uint64_t ip6_dprt_flag:1;
+		uint64_t ip4_dprt_flag:1;
+		uint64_t ip6_sprt_flag:1;
+		uint64_t ip4_sprt_flag:1;
+		uint64_t ip6_nxth_flag:1;
+		uint64_t ip4_pctl_flag:1;
+		uint64_t ip6_dst_flag:1;
+		uint64_t ip4_dst_flag:1;
+		uint64_t ip6_src_flag:1;
+		uint64_t ip4_src_flag:1;
+		cvmx_pow_tag_type_t tcp6_tag_type:2;
+		cvmx_pow_tag_type_t tcp4_tag_type:2;
+		cvmx_pow_tag_type_t ip6_tag_type:2;
+		cvmx_pow_tag_type_t ip4_tag_type:2;
+		cvmx_pow_tag_type_t non_tag_type:2;
+		uint64_t grp:4;
+	} cn30xx;
+	struct cvmx_pip_prt_tagx_cn30xx cn31xx;
+	struct cvmx_pip_prt_tagx_cn30xx cn38xx;
+	struct cvmx_pip_prt_tagx_cn30xx cn38xxp2;
+	struct cvmx_pip_prt_tagx_s cn50xx;
+	struct cvmx_pip_prt_tagx_s cn52xx;
+	struct cvmx_pip_prt_tagx_s cn52xxp1;
+	struct cvmx_pip_prt_tagx_s cn56xx;
+	struct cvmx_pip_prt_tagx_s cn56xxp1;
+	struct cvmx_pip_prt_tagx_cn30xx cn58xx;
+	struct cvmx_pip_prt_tagx_cn30xx cn58xxp1;
+} cvmx_pip_prt_tagx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_qos_diffx_s {
+		uint64_t reserved_3_63:61;
+		uint64_t qos:3;
+	} s;
+	struct cvmx_pip_qos_diffx_s cn30xx;
+	struct cvmx_pip_qos_diffx_s cn31xx;
+	struct cvmx_pip_qos_diffx_s cn38xx;
+	struct cvmx_pip_qos_diffx_s cn38xxp2;
+	struct cvmx_pip_qos_diffx_s cn50xx;
+	struct cvmx_pip_qos_diffx_s cn52xx;
+	struct cvmx_pip_qos_diffx_s cn52xxp1;
+	struct cvmx_pip_qos_diffx_s cn56xx;
+	struct cvmx_pip_qos_diffx_s cn56xxp1;
+	struct cvmx_pip_qos_diffx_s cn58xx;
+	struct cvmx_pip_qos_diffx_s cn58xxp1;
+} cvmx_pip_qos_diffx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_qos_vlanx_s {
+		uint64_t reserved_7_63:57;
+		uint64_t qos1:3;
+		uint64_t reserved_3_3:1;
+		uint64_t qos:3;
+	} s;
+	struct cvmx_pip_qos_vlanx_cn30xx {
+		uint64_t reserved_3_63:61;
+		uint64_t qos:3;
+	} cn30xx;
+	struct cvmx_pip_qos_vlanx_cn30xx cn31xx;
+	struct cvmx_pip_qos_vlanx_cn30xx cn38xx;
+	struct cvmx_pip_qos_vlanx_cn30xx cn38xxp2;
+	struct cvmx_pip_qos_vlanx_cn30xx cn50xx;
+	struct cvmx_pip_qos_vlanx_s cn52xx;
+	struct cvmx_pip_qos_vlanx_s cn52xxp1;
+	struct cvmx_pip_qos_vlanx_s cn56xx;
+	struct cvmx_pip_qos_vlanx_cn30xx cn56xxp1;
+	struct cvmx_pip_qos_vlanx_cn30xx cn58xx;
+	struct cvmx_pip_qos_vlanx_cn30xx cn58xxp1;
+} cvmx_pip_qos_vlanx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_qos_watchx_s {
+		uint64_t reserved_48_63:16;
+		uint64_t mask:16;
+		uint64_t reserved_28_31:4;
+		uint64_t grp:4;
+		uint64_t reserved_23_23:1;
+		uint64_t qos:3;
+		uint64_t reserved_19_19:1;
+		cvmx_pip_qos_watch_types match_type:3;
+
+		uint64_t match_value:16;
+	} s;
+	struct cvmx_pip_qos_watchx_cn30xx {
+		uint64_t reserved_48_63:16;
+		uint64_t mask:16;
+		uint64_t reserved_28_31:4;
+		uint64_t grp:4;
+		uint64_t reserved_23_23:1;
+		uint64_t qos:3;
+		uint64_t reserved_18_19:2;
+		cvmx_pip_qos_watch_types match_type:2;
+
+		uint64_t match_value:16;
+	} cn30xx;
+	struct cvmx_pip_qos_watchx_cn30xx cn31xx;
+	struct cvmx_pip_qos_watchx_cn30xx cn38xx;
+	struct cvmx_pip_qos_watchx_cn30xx cn38xxp2;
+	struct cvmx_pip_qos_watchx_s cn50xx;
+	struct cvmx_pip_qos_watchx_s cn52xx;
+	struct cvmx_pip_qos_watchx_s cn52xxp1;
+	struct cvmx_pip_qos_watchx_s cn56xx;
+	struct cvmx_pip_qos_watchx_s cn56xxp1;
+	struct cvmx_pip_qos_watchx_cn30xx cn58xx;
+	struct cvmx_pip_qos_watchx_cn30xx cn58xxp1;
+} cvmx_pip_qos_watchx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_raw_word_s {
+		uint64_t reserved_56_63:8;
+		uint64_t word:56;
+	} s;
+	struct cvmx_pip_raw_word_s cn30xx;
+	struct cvmx_pip_raw_word_s cn31xx;
+	struct cvmx_pip_raw_word_s cn38xx;
+	struct cvmx_pip_raw_word_s cn38xxp2;
+	struct cvmx_pip_raw_word_s cn50xx;
+	struct cvmx_pip_raw_word_s cn52xx;
+	struct cvmx_pip_raw_word_s cn52xxp1;
+	struct cvmx_pip_raw_word_s cn56xx;
+	struct cvmx_pip_raw_word_s cn56xxp1;
+	struct cvmx_pip_raw_word_s cn58xx;
+	struct cvmx_pip_raw_word_s cn58xxp1;
+} cvmx_pip_raw_word_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_sft_rst_s {
+		uint64_t reserved_1_63:63;
+		uint64_t rst:1;
+	} s;
+	struct cvmx_pip_sft_rst_s cn30xx;
+	struct cvmx_pip_sft_rst_s cn31xx;
+	struct cvmx_pip_sft_rst_s cn38xx;
+	struct cvmx_pip_sft_rst_s cn50xx;
+	struct cvmx_pip_sft_rst_s cn52xx;
+	struct cvmx_pip_sft_rst_s cn52xxp1;
+	struct cvmx_pip_sft_rst_s cn56xx;
+	struct cvmx_pip_sft_rst_s cn56xxp1;
+	struct cvmx_pip_sft_rst_s cn58xx;
+	struct cvmx_pip_sft_rst_s cn58xxp1;
+} cvmx_pip_sft_rst_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_stat0_prtx_s {
+		uint64_t drp_pkts:32;
+		uint64_t drp_octs:32;
+	} s;
+	struct cvmx_pip_stat0_prtx_s cn30xx;
+	struct cvmx_pip_stat0_prtx_s cn31xx;
+	struct cvmx_pip_stat0_prtx_s cn38xx;
+	struct cvmx_pip_stat0_prtx_s cn38xxp2;
+	struct cvmx_pip_stat0_prtx_s cn50xx;
+	struct cvmx_pip_stat0_prtx_s cn52xx;
+	struct cvmx_pip_stat0_prtx_s cn52xxp1;
+	struct cvmx_pip_stat0_prtx_s cn56xx;
+	struct cvmx_pip_stat0_prtx_s cn56xxp1;
+	struct cvmx_pip_stat0_prtx_s cn58xx;
+	struct cvmx_pip_stat0_prtx_s cn58xxp1;
+} cvmx_pip_stat0_prtx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_stat1_prtx_s {
+		uint64_t reserved_48_63:16;
+		uint64_t octs:48;
+	} s;
+	struct cvmx_pip_stat1_prtx_s cn30xx;
+	struct cvmx_pip_stat1_prtx_s cn31xx;
+	struct cvmx_pip_stat1_prtx_s cn38xx;
+	struct cvmx_pip_stat1_prtx_s cn38xxp2;
+	struct cvmx_pip_stat1_prtx_s cn50xx;
+	struct cvmx_pip_stat1_prtx_s cn52xx;
+	struct cvmx_pip_stat1_prtx_s cn52xxp1;
+	struct cvmx_pip_stat1_prtx_s cn56xx;
+	struct cvmx_pip_stat1_prtx_s cn56xxp1;
+	struct cvmx_pip_stat1_prtx_s cn58xx;
+	struct cvmx_pip_stat1_prtx_s cn58xxp1;
+} cvmx_pip_stat1_prtx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_stat2_prtx_s {
+		uint64_t pkts:32;
+		uint64_t raw:32;
+	} s;
+	struct cvmx_pip_stat2_prtx_s cn30xx;
+	struct cvmx_pip_stat2_prtx_s cn31xx;
+	struct cvmx_pip_stat2_prtx_s cn38xx;
+	struct cvmx_pip_stat2_prtx_s cn38xxp2;
+	struct cvmx_pip_stat2_prtx_s cn50xx;
+	struct cvmx_pip_stat2_prtx_s cn52xx;
+	struct cvmx_pip_stat2_prtx_s cn52xxp1;
+	struct cvmx_pip_stat2_prtx_s cn56xx;
+	struct cvmx_pip_stat2_prtx_s cn56xxp1;
+	struct cvmx_pip_stat2_prtx_s cn58xx;
+	struct cvmx_pip_stat2_prtx_s cn58xxp1;
+} cvmx_pip_stat2_prtx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_stat3_prtx_s {
+		uint64_t bcst:32;
+		uint64_t mcst:32;
+	} s;
+	struct cvmx_pip_stat3_prtx_s cn30xx;
+	struct cvmx_pip_stat3_prtx_s cn31xx;
+	struct cvmx_pip_stat3_prtx_s cn38xx;
+	struct cvmx_pip_stat3_prtx_s cn38xxp2;
+	struct cvmx_pip_stat3_prtx_s cn50xx;
+	struct cvmx_pip_stat3_prtx_s cn52xx;
+	struct cvmx_pip_stat3_prtx_s cn52xxp1;
+	struct cvmx_pip_stat3_prtx_s cn56xx;
+	struct cvmx_pip_stat3_prtx_s cn56xxp1;
+	struct cvmx_pip_stat3_prtx_s cn58xx;
+	struct cvmx_pip_stat3_prtx_s cn58xxp1;
+} cvmx_pip_stat3_prtx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_stat4_prtx_s {
+		uint64_t h65to127:32;
+		uint64_t h64:32;
+	} s;
+	struct cvmx_pip_stat4_prtx_s cn30xx;
+	struct cvmx_pip_stat4_prtx_s cn31xx;
+	struct cvmx_pip_stat4_prtx_s cn38xx;
+	struct cvmx_pip_stat4_prtx_s cn38xxp2;
+	struct cvmx_pip_stat4_prtx_s cn50xx;
+	struct cvmx_pip_stat4_prtx_s cn52xx;
+	struct cvmx_pip_stat4_prtx_s cn52xxp1;
+	struct cvmx_pip_stat4_prtx_s cn56xx;
+	struct cvmx_pip_stat4_prtx_s cn56xxp1;
+	struct cvmx_pip_stat4_prtx_s cn58xx;
+	struct cvmx_pip_stat4_prtx_s cn58xxp1;
+} cvmx_pip_stat4_prtx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_stat5_prtx_s {
+		uint64_t h256to511:32;
+		uint64_t h128to255:32;
+	} s;
+	struct cvmx_pip_stat5_prtx_s cn30xx;
+	struct cvmx_pip_stat5_prtx_s cn31xx;
+	struct cvmx_pip_stat5_prtx_s cn38xx;
+	struct cvmx_pip_stat5_prtx_s cn38xxp2;
+	struct cvmx_pip_stat5_prtx_s cn50xx;
+	struct cvmx_pip_stat5_prtx_s cn52xx;
+	struct cvmx_pip_stat5_prtx_s cn52xxp1;
+	struct cvmx_pip_stat5_prtx_s cn56xx;
+	struct cvmx_pip_stat5_prtx_s cn56xxp1;
+	struct cvmx_pip_stat5_prtx_s cn58xx;
+	struct cvmx_pip_stat5_prtx_s cn58xxp1;
+} cvmx_pip_stat5_prtx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_stat6_prtx_s {
+		uint64_t h1024to1518:32;
+		uint64_t h512to1023:32;
+	} s;
+	struct cvmx_pip_stat6_prtx_s cn30xx;
+	struct cvmx_pip_stat6_prtx_s cn31xx;
+	struct cvmx_pip_stat6_prtx_s cn38xx;
+	struct cvmx_pip_stat6_prtx_s cn38xxp2;
+	struct cvmx_pip_stat6_prtx_s cn50xx;
+	struct cvmx_pip_stat6_prtx_s cn52xx;
+	struct cvmx_pip_stat6_prtx_s cn52xxp1;
+	struct cvmx_pip_stat6_prtx_s cn56xx;
+	struct cvmx_pip_stat6_prtx_s cn56xxp1;
+	struct cvmx_pip_stat6_prtx_s cn58xx;
+	struct cvmx_pip_stat6_prtx_s cn58xxp1;
+} cvmx_pip_stat6_prtx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_stat7_prtx_s {
+		uint64_t fcs:32;
+		uint64_t h1519:32;
+	} s;
+	struct cvmx_pip_stat7_prtx_s cn30xx;
+	struct cvmx_pip_stat7_prtx_s cn31xx;
+	struct cvmx_pip_stat7_prtx_s cn38xx;
+	struct cvmx_pip_stat7_prtx_s cn38xxp2;
+	struct cvmx_pip_stat7_prtx_s cn50xx;
+	struct cvmx_pip_stat7_prtx_s cn52xx;
+	struct cvmx_pip_stat7_prtx_s cn52xxp1;
+	struct cvmx_pip_stat7_prtx_s cn56xx;
+	struct cvmx_pip_stat7_prtx_s cn56xxp1;
+	struct cvmx_pip_stat7_prtx_s cn58xx;
+	struct cvmx_pip_stat7_prtx_s cn58xxp1;
+} cvmx_pip_stat7_prtx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_stat8_prtx_s {
+		uint64_t frag:32;
+		uint64_t undersz:32;
+	} s;
+	struct cvmx_pip_stat8_prtx_s cn30xx;
+	struct cvmx_pip_stat8_prtx_s cn31xx;
+	struct cvmx_pip_stat8_prtx_s cn38xx;
+	struct cvmx_pip_stat8_prtx_s cn38xxp2;
+	struct cvmx_pip_stat8_prtx_s cn50xx;
+	struct cvmx_pip_stat8_prtx_s cn52xx;
+	struct cvmx_pip_stat8_prtx_s cn52xxp1;
+	struct cvmx_pip_stat8_prtx_s cn56xx;
+	struct cvmx_pip_stat8_prtx_s cn56xxp1;
+	struct cvmx_pip_stat8_prtx_s cn58xx;
+	struct cvmx_pip_stat8_prtx_s cn58xxp1;
+} cvmx_pip_stat8_prtx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_stat9_prtx_s {
+		uint64_t jabber:32;
+		uint64_t oversz:32;
+	} s;
+	struct cvmx_pip_stat9_prtx_s cn30xx;
+	struct cvmx_pip_stat9_prtx_s cn31xx;
+	struct cvmx_pip_stat9_prtx_s cn38xx;
+	struct cvmx_pip_stat9_prtx_s cn38xxp2;
+	struct cvmx_pip_stat9_prtx_s cn50xx;
+	struct cvmx_pip_stat9_prtx_s cn52xx;
+	struct cvmx_pip_stat9_prtx_s cn52xxp1;
+	struct cvmx_pip_stat9_prtx_s cn56xx;
+	struct cvmx_pip_stat9_prtx_s cn56xxp1;
+	struct cvmx_pip_stat9_prtx_s cn58xx;
+	struct cvmx_pip_stat9_prtx_s cn58xxp1;
+} cvmx_pip_stat9_prtx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_stat_ctl_s {
+		uint64_t reserved_1_63:63;
+		uint64_t rdclr:1;
+	} s;
+	struct cvmx_pip_stat_ctl_s cn30xx;
+	struct cvmx_pip_stat_ctl_s cn31xx;
+	struct cvmx_pip_stat_ctl_s cn38xx;
+	struct cvmx_pip_stat_ctl_s cn38xxp2;
+	struct cvmx_pip_stat_ctl_s cn50xx;
+	struct cvmx_pip_stat_ctl_s cn52xx;
+	struct cvmx_pip_stat_ctl_s cn52xxp1;
+	struct cvmx_pip_stat_ctl_s cn56xx;
+	struct cvmx_pip_stat_ctl_s cn56xxp1;
+	struct cvmx_pip_stat_ctl_s cn58xx;
+	struct cvmx_pip_stat_ctl_s cn58xxp1;
+} cvmx_pip_stat_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_stat_inb_errsx_s {
+		uint64_t reserved_16_63:48;
+		uint64_t errs:16;
+	} s;
+	struct cvmx_pip_stat_inb_errsx_s cn30xx;
+	struct cvmx_pip_stat_inb_errsx_s cn31xx;
+	struct cvmx_pip_stat_inb_errsx_s cn38xx;
+	struct cvmx_pip_stat_inb_errsx_s cn38xxp2;
+	struct cvmx_pip_stat_inb_errsx_s cn50xx;
+	struct cvmx_pip_stat_inb_errsx_s cn52xx;
+	struct cvmx_pip_stat_inb_errsx_s cn52xxp1;
+	struct cvmx_pip_stat_inb_errsx_s cn56xx;
+	struct cvmx_pip_stat_inb_errsx_s cn56xxp1;
+	struct cvmx_pip_stat_inb_errsx_s cn58xx;
+	struct cvmx_pip_stat_inb_errsx_s cn58xxp1;
+} cvmx_pip_stat_inb_errsx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_stat_inb_octsx_s {
+		uint64_t reserved_48_63:16;
+		uint64_t octs:48;
+	} s;
+	struct cvmx_pip_stat_inb_octsx_s cn30xx;
+	struct cvmx_pip_stat_inb_octsx_s cn31xx;
+	struct cvmx_pip_stat_inb_octsx_s cn38xx;
+	struct cvmx_pip_stat_inb_octsx_s cn38xxp2;
+	struct cvmx_pip_stat_inb_octsx_s cn50xx;
+	struct cvmx_pip_stat_inb_octsx_s cn52xx;
+	struct cvmx_pip_stat_inb_octsx_s cn52xxp1;
+	struct cvmx_pip_stat_inb_octsx_s cn56xx;
+	struct cvmx_pip_stat_inb_octsx_s cn56xxp1;
+	struct cvmx_pip_stat_inb_octsx_s cn58xx;
+	struct cvmx_pip_stat_inb_octsx_s cn58xxp1;
+} cvmx_pip_stat_inb_octsx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_stat_inb_pktsx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t pkts:32;
+	} s;
+	struct cvmx_pip_stat_inb_pktsx_s cn30xx;
+	struct cvmx_pip_stat_inb_pktsx_s cn31xx;
+	struct cvmx_pip_stat_inb_pktsx_s cn38xx;
+	struct cvmx_pip_stat_inb_pktsx_s cn38xxp2;
+	struct cvmx_pip_stat_inb_pktsx_s cn50xx;
+	struct cvmx_pip_stat_inb_pktsx_s cn52xx;
+	struct cvmx_pip_stat_inb_pktsx_s cn52xxp1;
+	struct cvmx_pip_stat_inb_pktsx_s cn56xx;
+	struct cvmx_pip_stat_inb_pktsx_s cn56xxp1;
+	struct cvmx_pip_stat_inb_pktsx_s cn58xx;
+	struct cvmx_pip_stat_inb_pktsx_s cn58xxp1;
+} cvmx_pip_stat_inb_pktsx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_tag_incx_s {
+		uint64_t reserved_8_63:56;
+		uint64_t en:8;
+	} s;
+	struct cvmx_pip_tag_incx_s cn30xx;
+	struct cvmx_pip_tag_incx_s cn31xx;
+	struct cvmx_pip_tag_incx_s cn38xx;
+	struct cvmx_pip_tag_incx_s cn38xxp2;
+	struct cvmx_pip_tag_incx_s cn50xx;
+	struct cvmx_pip_tag_incx_s cn52xx;
+	struct cvmx_pip_tag_incx_s cn52xxp1;
+	struct cvmx_pip_tag_incx_s cn56xx;
+	struct cvmx_pip_tag_incx_s cn56xxp1;
+	struct cvmx_pip_tag_incx_s cn58xx;
+	struct cvmx_pip_tag_incx_s cn58xxp1;
+} cvmx_pip_tag_incx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_tag_mask_s {
+		uint64_t reserved_16_63:48;
+		uint64_t mask:16;
+	} s;
+	struct cvmx_pip_tag_mask_s cn30xx;
+	struct cvmx_pip_tag_mask_s cn31xx;
+	struct cvmx_pip_tag_mask_s cn38xx;
+	struct cvmx_pip_tag_mask_s cn38xxp2;
+	struct cvmx_pip_tag_mask_s cn50xx;
+	struct cvmx_pip_tag_mask_s cn52xx;
+	struct cvmx_pip_tag_mask_s cn52xxp1;
+	struct cvmx_pip_tag_mask_s cn56xx;
+	struct cvmx_pip_tag_mask_s cn56xxp1;
+	struct cvmx_pip_tag_mask_s cn58xx;
+	struct cvmx_pip_tag_mask_s cn58xxp1;
+} cvmx_pip_tag_mask_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_tag_secret_s {
+		uint64_t reserved_32_63:32;
+		uint64_t dst:16;
+		uint64_t src:16;
+	} s;
+	struct cvmx_pip_tag_secret_s cn30xx;
+	struct cvmx_pip_tag_secret_s cn31xx;
+	struct cvmx_pip_tag_secret_s cn38xx;
+	struct cvmx_pip_tag_secret_s cn38xxp2;
+	struct cvmx_pip_tag_secret_s cn50xx;
+	struct cvmx_pip_tag_secret_s cn52xx;
+	struct cvmx_pip_tag_secret_s cn52xxp1;
+	struct cvmx_pip_tag_secret_s cn56xx;
+	struct cvmx_pip_tag_secret_s cn56xxp1;
+	struct cvmx_pip_tag_secret_s cn58xx;
+	struct cvmx_pip_tag_secret_s cn58xxp1;
+} cvmx_pip_tag_secret_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pip_todo_entry_s {
+		uint64_t val:1;
+		uint64_t reserved_62_62:1;
+		uint64_t entry:62;
+	} s;
+	struct cvmx_pip_todo_entry_s cn30xx;
+	struct cvmx_pip_todo_entry_s cn31xx;
+	struct cvmx_pip_todo_entry_s cn38xx;
+	struct cvmx_pip_todo_entry_s cn38xxp2;
+	struct cvmx_pip_todo_entry_s cn50xx;
+	struct cvmx_pip_todo_entry_s cn52xx;
+	struct cvmx_pip_todo_entry_s cn52xxp1;
+	struct cvmx_pip_todo_entry_s cn56xx;
+	struct cvmx_pip_todo_entry_s cn56xxp1;
+	struct cvmx_pip_todo_entry_s cn58xx;
+	struct cvmx_pip_todo_entry_s cn58xxp1;
+} cvmx_pip_todo_entry_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_mem_count0_s {
+		uint64_t reserved_32_63:32;
+		uint64_t count:32;
+	} s;
+	struct cvmx_pko_mem_count0_s cn30xx;
+	struct cvmx_pko_mem_count0_s cn31xx;
+	struct cvmx_pko_mem_count0_s cn38xx;
+	struct cvmx_pko_mem_count0_s cn38xxp2;
+	struct cvmx_pko_mem_count0_s cn50xx;
+	struct cvmx_pko_mem_count0_s cn52xx;
+	struct cvmx_pko_mem_count0_s cn52xxp1;
+	struct cvmx_pko_mem_count0_s cn56xx;
+	struct cvmx_pko_mem_count0_s cn56xxp1;
+	struct cvmx_pko_mem_count0_s cn58xx;
+	struct cvmx_pko_mem_count0_s cn58xxp1;
+} cvmx_pko_mem_count0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_mem_count1_s {
+		uint64_t reserved_48_63:16;
+		uint64_t count:48;
+	} s;
+	struct cvmx_pko_mem_count1_s cn30xx;
+	struct cvmx_pko_mem_count1_s cn31xx;
+	struct cvmx_pko_mem_count1_s cn38xx;
+	struct cvmx_pko_mem_count1_s cn38xxp2;
+	struct cvmx_pko_mem_count1_s cn50xx;
+	struct cvmx_pko_mem_count1_s cn52xx;
+	struct cvmx_pko_mem_count1_s cn52xxp1;
+	struct cvmx_pko_mem_count1_s cn56xx;
+	struct cvmx_pko_mem_count1_s cn56xxp1;
+	struct cvmx_pko_mem_count1_s cn58xx;
+	struct cvmx_pko_mem_count1_s cn58xxp1;
+} cvmx_pko_mem_count1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug0_s {
+		uint64_t fau:28;
+		uint64_t cmd:14;
+		uint64_t segs:6;
+		uint64_t size:16;
+	} s;
+	struct cvmx_pko_mem_debug0_s cn30xx;
+	struct cvmx_pko_mem_debug0_s cn31xx;
+	struct cvmx_pko_mem_debug0_s cn38xx;
+	struct cvmx_pko_mem_debug0_s cn38xxp2;
+	struct cvmx_pko_mem_debug0_s cn50xx;
+	struct cvmx_pko_mem_debug0_s cn52xx;
+	struct cvmx_pko_mem_debug0_s cn52xxp1;
+	struct cvmx_pko_mem_debug0_s cn56xx;
+	struct cvmx_pko_mem_debug0_s cn56xxp1;
+	struct cvmx_pko_mem_debug0_s cn58xx;
+	struct cvmx_pko_mem_debug0_s cn58xxp1;
+} cvmx_pko_mem_debug0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug1_s {
+		uint64_t i:1;
+		uint64_t back:4;
+		uint64_t pool:3;
+		uint64_t size:16;
+		uint64_t ptr:40;
+	} s;
+	struct cvmx_pko_mem_debug1_s cn30xx;
+	struct cvmx_pko_mem_debug1_s cn31xx;
+	struct cvmx_pko_mem_debug1_s cn38xx;
+	struct cvmx_pko_mem_debug1_s cn38xxp2;
+	struct cvmx_pko_mem_debug1_s cn50xx;
+	struct cvmx_pko_mem_debug1_s cn52xx;
+	struct cvmx_pko_mem_debug1_s cn52xxp1;
+	struct cvmx_pko_mem_debug1_s cn56xx;
+	struct cvmx_pko_mem_debug1_s cn56xxp1;
+	struct cvmx_pko_mem_debug1_s cn58xx;
+	struct cvmx_pko_mem_debug1_s cn58xxp1;
+} cvmx_pko_mem_debug1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug10_s {
+		uint64_t reserved_0_63:64;
+	} s;
+	struct cvmx_pko_mem_debug10_cn30xx {
+		uint64_t fau:28;
+		uint64_t cmd:14;
+		uint64_t segs:6;
+		uint64_t size:16;
+	} cn30xx;
+	struct cvmx_pko_mem_debug10_cn30xx cn31xx;
+	struct cvmx_pko_mem_debug10_cn30xx cn38xx;
+	struct cvmx_pko_mem_debug10_cn30xx cn38xxp2;
+	struct cvmx_pko_mem_debug10_cn50xx {
+		uint64_t reserved_49_63:15;
+		uint64_t ptrs1:17;
+		uint64_t reserved_17_31:15;
+		uint64_t ptrs2:17;
+	} cn50xx;
+	struct cvmx_pko_mem_debug10_cn50xx cn52xx;
+	struct cvmx_pko_mem_debug10_cn50xx cn52xxp1;
+	struct cvmx_pko_mem_debug10_cn50xx cn56xx;
+	struct cvmx_pko_mem_debug10_cn50xx cn56xxp1;
+	struct cvmx_pko_mem_debug10_cn50xx cn58xx;
+	struct cvmx_pko_mem_debug10_cn50xx cn58xxp1;
+} cvmx_pko_mem_debug10_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug11_s {
+		uint64_t i:1;
+		uint64_t back:4;
+		uint64_t pool:3;
+		uint64_t size:16;
+		uint64_t reserved_0_39:40;
+	} s;
+	struct cvmx_pko_mem_debug11_cn30xx {
+		uint64_t i:1;
+		uint64_t back:4;
+		uint64_t pool:3;
+		uint64_t size:16;
+		uint64_t ptr:40;
+	} cn30xx;
+	struct cvmx_pko_mem_debug11_cn30xx cn31xx;
+	struct cvmx_pko_mem_debug11_cn30xx cn38xx;
+	struct cvmx_pko_mem_debug11_cn30xx cn38xxp2;
+	struct cvmx_pko_mem_debug11_cn50xx {
+		uint64_t reserved_23_63:41;
+		uint64_t maj:1;
+		uint64_t uid:3;
+		uint64_t sop:1;
+		uint64_t len:1;
+		uint64_t chk:1;
+		uint64_t cnt:13;
+		uint64_t mod:3;
+	} cn50xx;
+	struct cvmx_pko_mem_debug11_cn50xx cn52xx;
+	struct cvmx_pko_mem_debug11_cn50xx cn52xxp1;
+	struct cvmx_pko_mem_debug11_cn50xx cn56xx;
+	struct cvmx_pko_mem_debug11_cn50xx cn56xxp1;
+	struct cvmx_pko_mem_debug11_cn50xx cn58xx;
+	struct cvmx_pko_mem_debug11_cn50xx cn58xxp1;
+} cvmx_pko_mem_debug11_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug12_s {
+		uint64_t reserved_0_63:64;
+	} s;
+	struct cvmx_pko_mem_debug12_cn30xx {
+		uint64_t data:64;
+	} cn30xx;
+	struct cvmx_pko_mem_debug12_cn30xx cn31xx;
+	struct cvmx_pko_mem_debug12_cn30xx cn38xx;
+	struct cvmx_pko_mem_debug12_cn30xx cn38xxp2;
+	struct cvmx_pko_mem_debug12_cn50xx {
+		uint64_t fau:28;
+		uint64_t cmd:14;
+		uint64_t segs:6;
+		uint64_t size:16;
+	} cn50xx;
+	struct cvmx_pko_mem_debug12_cn50xx cn52xx;
+	struct cvmx_pko_mem_debug12_cn50xx cn52xxp1;
+	struct cvmx_pko_mem_debug12_cn50xx cn56xx;
+	struct cvmx_pko_mem_debug12_cn50xx cn56xxp1;
+	struct cvmx_pko_mem_debug12_cn50xx cn58xx;
+	struct cvmx_pko_mem_debug12_cn50xx cn58xxp1;
+} cvmx_pko_mem_debug12_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug13_s {
+		uint64_t i:1;
+		uint64_t back:4;
+		uint64_t pool:3;
+		uint64_t reserved_0_55:56;
+	} s;
+	struct cvmx_pko_mem_debug13_cn30xx {
+		uint64_t reserved_51_63:13;
+		uint64_t widx:17;
+		uint64_t ridx2:17;
+		uint64_t widx2:17;
+	} cn30xx;
+	struct cvmx_pko_mem_debug13_cn30xx cn31xx;
+	struct cvmx_pko_mem_debug13_cn30xx cn38xx;
+	struct cvmx_pko_mem_debug13_cn30xx cn38xxp2;
+	struct cvmx_pko_mem_debug13_cn50xx {
+		uint64_t i:1;
+		uint64_t back:4;
+		uint64_t pool:3;
+		uint64_t size:16;
+		uint64_t ptr:40;
+	} cn50xx;
+	struct cvmx_pko_mem_debug13_cn50xx cn52xx;
+	struct cvmx_pko_mem_debug13_cn50xx cn52xxp1;
+	struct cvmx_pko_mem_debug13_cn50xx cn56xx;
+	struct cvmx_pko_mem_debug13_cn50xx cn56xxp1;
+	struct cvmx_pko_mem_debug13_cn50xx cn58xx;
+	struct cvmx_pko_mem_debug13_cn50xx cn58xxp1;
+} cvmx_pko_mem_debug13_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug14_s {
+		uint64_t reserved_0_63:64;
+	} s;
+	struct cvmx_pko_mem_debug14_cn30xx {
+		uint64_t reserved_17_63:47;
+		uint64_t ridx:17;
+	} cn30xx;
+	struct cvmx_pko_mem_debug14_cn30xx cn31xx;
+	struct cvmx_pko_mem_debug14_cn30xx cn38xx;
+	struct cvmx_pko_mem_debug14_cn30xx cn38xxp2;
+	struct cvmx_pko_mem_debug14_cn52xx {
+		uint64_t data:64;
+	} cn52xx;
+	struct cvmx_pko_mem_debug14_cn52xx cn52xxp1;
+	struct cvmx_pko_mem_debug14_cn52xx cn56xx;
+	struct cvmx_pko_mem_debug14_cn52xx cn56xxp1;
+} cvmx_pko_mem_debug14_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug2_s {
+		uint64_t i:1;
+		uint64_t back:4;
+		uint64_t pool:3;
+		uint64_t size:16;
+		uint64_t ptr:40;
+	} s;
+	struct cvmx_pko_mem_debug2_s cn30xx;
+	struct cvmx_pko_mem_debug2_s cn31xx;
+	struct cvmx_pko_mem_debug2_s cn38xx;
+	struct cvmx_pko_mem_debug2_s cn38xxp2;
+	struct cvmx_pko_mem_debug2_s cn50xx;
+	struct cvmx_pko_mem_debug2_s cn52xx;
+	struct cvmx_pko_mem_debug2_s cn52xxp1;
+	struct cvmx_pko_mem_debug2_s cn56xx;
+	struct cvmx_pko_mem_debug2_s cn56xxp1;
+	struct cvmx_pko_mem_debug2_s cn58xx;
+	struct cvmx_pko_mem_debug2_s cn58xxp1;
+} cvmx_pko_mem_debug2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug3_s {
+		uint64_t reserved_0_63:64;
+	} s;
+	struct cvmx_pko_mem_debug3_cn30xx {
+		uint64_t i:1;
+		uint64_t back:4;
+		uint64_t pool:3;
+		uint64_t size:16;
+		uint64_t ptr:40;
+	} cn30xx;
+	struct cvmx_pko_mem_debug3_cn30xx cn31xx;
+	struct cvmx_pko_mem_debug3_cn30xx cn38xx;
+	struct cvmx_pko_mem_debug3_cn30xx cn38xxp2;
+	struct cvmx_pko_mem_debug3_cn50xx {
+		uint64_t data:64;
+	} cn50xx;
+	struct cvmx_pko_mem_debug3_cn50xx cn52xx;
+	struct cvmx_pko_mem_debug3_cn50xx cn52xxp1;
+	struct cvmx_pko_mem_debug3_cn50xx cn56xx;
+	struct cvmx_pko_mem_debug3_cn50xx cn56xxp1;
+	struct cvmx_pko_mem_debug3_cn50xx cn58xx;
+	struct cvmx_pko_mem_debug3_cn50xx cn58xxp1;
+} cvmx_pko_mem_debug3_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug4_s {
+		uint64_t reserved_0_63:64;
+	} s;
+	struct cvmx_pko_mem_debug4_cn30xx {
+		uint64_t data:64;
+	} cn30xx;
+	struct cvmx_pko_mem_debug4_cn30xx cn31xx;
+	struct cvmx_pko_mem_debug4_cn30xx cn38xx;
+	struct cvmx_pko_mem_debug4_cn30xx cn38xxp2;
+	struct cvmx_pko_mem_debug4_cn50xx {
+		uint64_t cmnd_segs:3;
+		uint64_t cmnd_siz:16;
+		uint64_t cmnd_off:6;
+		uint64_t uid:3;
+		uint64_t dread_sop:1;
+		uint64_t init_dwrite:1;
+		uint64_t chk_once:1;
+		uint64_t chk_mode:1;
+		uint64_t active:1;
+		uint64_t static_p:1;
+		uint64_t qos:3;
+		uint64_t qcb_ridx:5;
+		uint64_t qid_off_max:4;
+		uint64_t qid_off:4;
+		uint64_t qid_base:8;
+		uint64_t wait:1;
+		uint64_t minor:2;
+		uint64_t major:3;
+	} cn50xx;
+	struct cvmx_pko_mem_debug4_cn52xx {
+		uint64_t curr_siz:8;
+		uint64_t curr_off:16;
+		uint64_t cmnd_segs:6;
+		uint64_t cmnd_siz:16;
+		uint64_t cmnd_off:6;
+		uint64_t uid:2;
+		uint64_t dread_sop:1;
+		uint64_t init_dwrite:1;
+		uint64_t chk_once:1;
+		uint64_t chk_mode:1;
+		uint64_t wait:1;
+		uint64_t minor:2;
+		uint64_t major:3;
+	} cn52xx;
+	struct cvmx_pko_mem_debug4_cn52xx cn52xxp1;
+	struct cvmx_pko_mem_debug4_cn52xx cn56xx;
+	struct cvmx_pko_mem_debug4_cn52xx cn56xxp1;
+	struct cvmx_pko_mem_debug4_cn50xx cn58xx;
+	struct cvmx_pko_mem_debug4_cn50xx cn58xxp1;
+} cvmx_pko_mem_debug4_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug5_s {
+		uint64_t reserved_0_63:64;
+	} s;
+	struct cvmx_pko_mem_debug5_cn30xx {
+		uint64_t dwri_mod:1;
+		uint64_t dwri_sop:1;
+		uint64_t dwri_len:1;
+		uint64_t dwri_cnt:13;
+		uint64_t cmnd_siz:16;
+		uint64_t uid:1;
+		uint64_t xfer_wor:1;
+		uint64_t xfer_dwr:1;
+		uint64_t cbuf_fre:1;
+		uint64_t reserved_27_27:1;
+		uint64_t chk_mode:1;
+		uint64_t active:1;
+		uint64_t qos:3;
+		uint64_t qcb_ridx:5;
+		uint64_t qid_off:3;
+		uint64_t qid_base:7;
+		uint64_t wait:1;
+		uint64_t minor:2;
+		uint64_t major:4;
+	} cn30xx;
+	struct cvmx_pko_mem_debug5_cn30xx cn31xx;
+	struct cvmx_pko_mem_debug5_cn30xx cn38xx;
+	struct cvmx_pko_mem_debug5_cn30xx cn38xxp2;
+	struct cvmx_pko_mem_debug5_cn50xx {
+		uint64_t curr_ptr:29;
+		uint64_t curr_siz:16;
+		uint64_t curr_off:16;
+		uint64_t cmnd_segs:3;
+	} cn50xx;
+	struct cvmx_pko_mem_debug5_cn52xx {
+		uint64_t reserved_54_63:10;
+		uint64_t nxt_inflt:6;
+		uint64_t curr_ptr:40;
+		uint64_t curr_siz:8;
+	} cn52xx;
+	struct cvmx_pko_mem_debug5_cn52xx cn52xxp1;
+	struct cvmx_pko_mem_debug5_cn52xx cn56xx;
+	struct cvmx_pko_mem_debug5_cn52xx cn56xxp1;
+	struct cvmx_pko_mem_debug5_cn50xx cn58xx;
+	struct cvmx_pko_mem_debug5_cn50xx cn58xxp1;
+} cvmx_pko_mem_debug5_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug6_s {
+		uint64_t reserved_37_63:27;
+		uint64_t qid_offres:4;
+		uint64_t qid_offths:4;
+		uint64_t preempter:1;
+		uint64_t preemptee:1;
+		uint64_t preempted:1;
+		uint64_t active:1;
+		uint64_t statc:1;
+		uint64_t qos:3;
+		uint64_t qcb_ridx:5;
+		uint64_t qid_offmax:4;
+		uint64_t reserved_0_11:12;
+	} s;
+	struct cvmx_pko_mem_debug6_cn30xx {
+		uint64_t reserved_11_63:53;
+		uint64_t qid_offm:3;
+		uint64_t static_p:1;
+		uint64_t work_min:3;
+		uint64_t dwri_chk:1;
+		uint64_t dwri_uid:1;
+		uint64_t dwri_mod:2;
+	} cn30xx;
+	struct cvmx_pko_mem_debug6_cn30xx cn31xx;
+	struct cvmx_pko_mem_debug6_cn30xx cn38xx;
+	struct cvmx_pko_mem_debug6_cn30xx cn38xxp2;
+	struct cvmx_pko_mem_debug6_cn50xx {
+		uint64_t reserved_11_63:53;
+		uint64_t curr_ptr:11;
+	} cn50xx;
+	struct cvmx_pko_mem_debug6_cn52xx {
+		uint64_t reserved_37_63:27;
+		uint64_t qid_offres:4;
+		uint64_t qid_offths:4;
+		uint64_t preempter:1;
+		uint64_t preemptee:1;
+		uint64_t preempted:1;
+		uint64_t active:1;
+		uint64_t statc:1;
+		uint64_t qos:3;
+		uint64_t qcb_ridx:5;
+		uint64_t qid_offmax:4;
+		uint64_t qid_off:4;
+		uint64_t qid_base:8;
+	} cn52xx;
+	struct cvmx_pko_mem_debug6_cn52xx cn52xxp1;
+	struct cvmx_pko_mem_debug6_cn52xx cn56xx;
+	struct cvmx_pko_mem_debug6_cn52xx cn56xxp1;
+	struct cvmx_pko_mem_debug6_cn50xx cn58xx;
+	struct cvmx_pko_mem_debug6_cn50xx cn58xxp1;
+} cvmx_pko_mem_debug6_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug7_s {
+		uint64_t qos:5;
+		uint64_t tail:1;
+		uint64_t reserved_0_57:58;
+	} s;
+	struct cvmx_pko_mem_debug7_cn30xx {
+		uint64_t reserved_58_63:6;
+		uint64_t dwb:9;
+		uint64_t start:33;
+		uint64_t size:16;
+	} cn30xx;
+	struct cvmx_pko_mem_debug7_cn30xx cn31xx;
+	struct cvmx_pko_mem_debug7_cn30xx cn38xx;
+	struct cvmx_pko_mem_debug7_cn30xx cn38xxp2;
+	struct cvmx_pko_mem_debug7_cn50xx {
+		uint64_t qos:5;
+		uint64_t tail:1;
+		uint64_t buf_siz:13;
+		uint64_t buf_ptr:33;
+		uint64_t qcb_widx:6;
+		uint64_t qcb_ridx:6;
+	} cn50xx;
+	struct cvmx_pko_mem_debug7_cn50xx cn52xx;
+	struct cvmx_pko_mem_debug7_cn50xx cn52xxp1;
+	struct cvmx_pko_mem_debug7_cn50xx cn56xx;
+	struct cvmx_pko_mem_debug7_cn50xx cn56xxp1;
+	struct cvmx_pko_mem_debug7_cn50xx cn58xx;
+	struct cvmx_pko_mem_debug7_cn50xx cn58xxp1;
+} cvmx_pko_mem_debug7_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug8_s {
+		uint64_t reserved_59_63:5;
+		uint64_t tail:1;
+		uint64_t buf_siz:13;
+		uint64_t reserved_0_44:45;
+	} s;
+	struct cvmx_pko_mem_debug8_cn30xx {
+		uint64_t qos:5;
+		uint64_t tail:1;
+		uint64_t buf_siz:13;
+		uint64_t buf_ptr:33;
+		uint64_t qcb_widx:6;
+		uint64_t qcb_ridx:6;
+	} cn30xx;
+	struct cvmx_pko_mem_debug8_cn30xx cn31xx;
+	struct cvmx_pko_mem_debug8_cn30xx cn38xx;
+	struct cvmx_pko_mem_debug8_cn30xx cn38xxp2;
+	struct cvmx_pko_mem_debug8_cn50xx {
+		uint64_t reserved_28_63:36;
+		uint64_t doorbell:20;
+		uint64_t reserved_6_7:2;
+		uint64_t static_p:1;
+		uint64_t s_tail:1;
+		uint64_t static_q:1;
+		uint64_t qos:3;
+	} cn50xx;
+	struct cvmx_pko_mem_debug8_cn52xx {
+		uint64_t reserved_29_63:35;
+		uint64_t preempter:1;
+		uint64_t doorbell:20;
+		uint64_t reserved_7_7:1;
+		uint64_t preemptee:1;
+		uint64_t static_p:1;
+		uint64_t s_tail:1;
+		uint64_t static_q:1;
+		uint64_t qos:3;
+	} cn52xx;
+	struct cvmx_pko_mem_debug8_cn52xx cn52xxp1;
+	struct cvmx_pko_mem_debug8_cn52xx cn56xx;
+	struct cvmx_pko_mem_debug8_cn52xx cn56xxp1;
+	struct cvmx_pko_mem_debug8_cn50xx cn58xx;
+	struct cvmx_pko_mem_debug8_cn50xx cn58xxp1;
+} cvmx_pko_mem_debug8_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_mem_debug9_s {
+		uint64_t reserved_49_63:15;
+		uint64_t ptrs0:17;
+		uint64_t reserved_0_31:32;
+	} s;
+	struct cvmx_pko_mem_debug9_cn30xx {
+		uint64_t reserved_28_63:36;
+		uint64_t doorbell:20;
+		uint64_t reserved_5_7:3;
+		uint64_t s_tail:1;
+		uint64_t static_q:1;
+		uint64_t qos:3;
+	} cn30xx;
+	struct cvmx_pko_mem_debug9_cn30xx cn31xx;
+	struct cvmx_pko_mem_debug9_cn38xx {
+		uint64_t reserved_28_63:36;
+		uint64_t doorbell:20;
+		uint64_t reserved_6_7:2;
+		uint64_t static_p:1;
+		uint64_t s_tail:1;
+		uint64_t static_q:1;
+		uint64_t qos:3;
+	} cn38xx;
+	struct cvmx_pko_mem_debug9_cn38xx cn38xxp2;
+	struct cvmx_pko_mem_debug9_cn50xx {
+		uint64_t reserved_49_63:15;
+		uint64_t ptrs0:17;
+		uint64_t reserved_17_31:15;
+		uint64_t ptrs3:17;
+	} cn50xx;
+	struct cvmx_pko_mem_debug9_cn50xx cn52xx;
+	struct cvmx_pko_mem_debug9_cn50xx cn52xxp1;
+	struct cvmx_pko_mem_debug9_cn50xx cn56xx;
+	struct cvmx_pko_mem_debug9_cn50xx cn56xxp1;
+	struct cvmx_pko_mem_debug9_cn50xx cn58xx;
+	struct cvmx_pko_mem_debug9_cn50xx cn58xxp1;
+} cvmx_pko_mem_debug9_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_mem_port_ptrs_s {
+		uint64_t reserved_62_63:2;
+		uint64_t static_p:1;
+		uint64_t qos_mask:8;
+		uint64_t reserved_16_52:37;
+		uint64_t bp_port:6;
+		uint64_t eid:4;
+		uint64_t pid:6;
+	} s;
+	struct cvmx_pko_mem_port_ptrs_s cn52xx;
+	struct cvmx_pko_mem_port_ptrs_s cn52xxp1;
+	struct cvmx_pko_mem_port_ptrs_s cn56xx;
+	struct cvmx_pko_mem_port_ptrs_s cn56xxp1;
+} cvmx_pko_mem_port_ptrs_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_mem_port_qos_s {
+		uint64_t reserved_61_63:3;
+		uint64_t qos_mask:8;
+		uint64_t reserved_10_52:43;
+		uint64_t eid:4;
+		uint64_t pid:6;
+	} s;
+	struct cvmx_pko_mem_port_qos_s cn52xx;
+	struct cvmx_pko_mem_port_qos_s cn52xxp1;
+	struct cvmx_pko_mem_port_qos_s cn56xx;
+	struct cvmx_pko_mem_port_qos_s cn56xxp1;
+} cvmx_pko_mem_port_qos_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_mem_port_rate0_s {
+		uint64_t reserved_51_63:13;
+		uint64_t rate_word:19;
+		uint64_t rate_pkt:24;
+		uint64_t reserved_6_7:2;
+		uint64_t pid:6;
+	} s;
+	struct cvmx_pko_mem_port_rate0_s cn52xx;
+	struct cvmx_pko_mem_port_rate0_s cn52xxp1;
+	struct cvmx_pko_mem_port_rate0_s cn56xx;
+	struct cvmx_pko_mem_port_rate0_s cn56xxp1;
+} cvmx_pko_mem_port_rate0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_mem_port_rate1_s {
+		uint64_t reserved_32_63:32;
+		uint64_t rate_lim:24;
+		uint64_t reserved_6_7:2;
+		uint64_t pid:6;
+	} s;
+	struct cvmx_pko_mem_port_rate1_s cn52xx;
+	struct cvmx_pko_mem_port_rate1_s cn52xxp1;
+	struct cvmx_pko_mem_port_rate1_s cn56xx;
+	struct cvmx_pko_mem_port_rate1_s cn56xxp1;
+} cvmx_pko_mem_port_rate1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_mem_queue_ptrs_s {
+		uint64_t s_tail:1;
+		uint64_t static_p:1;
+		uint64_t static_q:1;
+		uint64_t qos_mask:8;
+		uint64_t buf_ptr:36;
+		uint64_t tail:1;
+		uint64_t index:3;
+		uint64_t port:6;
+		uint64_t queue:7;
+	} s;
+	struct cvmx_pko_mem_queue_ptrs_s cn30xx;
+	struct cvmx_pko_mem_queue_ptrs_s cn31xx;
+	struct cvmx_pko_mem_queue_ptrs_s cn38xx;
+	struct cvmx_pko_mem_queue_ptrs_s cn38xxp2;
+	struct cvmx_pko_mem_queue_ptrs_s cn50xx;
+	struct cvmx_pko_mem_queue_ptrs_s cn52xx;
+	struct cvmx_pko_mem_queue_ptrs_s cn52xxp1;
+	struct cvmx_pko_mem_queue_ptrs_s cn56xx;
+	struct cvmx_pko_mem_queue_ptrs_s cn56xxp1;
+	struct cvmx_pko_mem_queue_ptrs_s cn58xx;
+	struct cvmx_pko_mem_queue_ptrs_s cn58xxp1;
+} cvmx_pko_mem_queue_ptrs_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_mem_queue_qos_s {
+		uint64_t reserved_61_63:3;
+		uint64_t qos_mask:8;
+		uint64_t reserved_13_52:40;
+		uint64_t pid:6;
+		uint64_t qid:7;
+	} s;
+	struct cvmx_pko_mem_queue_qos_s cn30xx;
+	struct cvmx_pko_mem_queue_qos_s cn31xx;
+	struct cvmx_pko_mem_queue_qos_s cn38xx;
+	struct cvmx_pko_mem_queue_qos_s cn38xxp2;
+	struct cvmx_pko_mem_queue_qos_s cn50xx;
+	struct cvmx_pko_mem_queue_qos_s cn52xx;
+	struct cvmx_pko_mem_queue_qos_s cn52xxp1;
+	struct cvmx_pko_mem_queue_qos_s cn56xx;
+	struct cvmx_pko_mem_queue_qos_s cn56xxp1;
+	struct cvmx_pko_mem_queue_qos_s cn58xx;
+	struct cvmx_pko_mem_queue_qos_s cn58xxp1;
+} cvmx_pko_mem_queue_qos_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_reg_bist_result_s {
+		uint64_t reserved_0_63:64;
+	} s;
+	struct cvmx_pko_reg_bist_result_cn30xx {
+		uint64_t reserved_27_63:37;
+		uint64_t psb2:5;
+		uint64_t count:1;
+		uint64_t rif:1;
+		uint64_t wif:1;
+		uint64_t ncb:1;
+		uint64_t out:1;
+		uint64_t crc:1;
+		uint64_t chk:1;
+		uint64_t qsb:2;
+		uint64_t qcb:2;
+		uint64_t pdb:4;
+		uint64_t psb:7;
+	} cn30xx;
+	struct cvmx_pko_reg_bist_result_cn30xx cn31xx;
+	struct cvmx_pko_reg_bist_result_cn30xx cn38xx;
+	struct cvmx_pko_reg_bist_result_cn30xx cn38xxp2;
+	struct cvmx_pko_reg_bist_result_cn50xx {
+		uint64_t reserved_33_63:31;
+		uint64_t csr:1;
+		uint64_t iob:1;
+		uint64_t out_crc:1;
+		uint64_t out_ctl:3;
+		uint64_t out_sta:1;
+		uint64_t out_wif:1;
+		uint64_t prt_chk:3;
+		uint64_t prt_nxt:1;
+		uint64_t prt_psb:6;
+		uint64_t ncb_inb:2;
+		uint64_t prt_qcb:2;
+		uint64_t prt_qsb:3;
+		uint64_t dat_dat:4;
+		uint64_t dat_ptr:4;
+	} cn50xx;
+	struct cvmx_pko_reg_bist_result_cn52xx {
+		uint64_t reserved_35_63:29;
+		uint64_t csr:1;
+		uint64_t iob:1;
+		uint64_t out_dat:1;
+		uint64_t out_ctl:3;
+		uint64_t out_sta:1;
+		uint64_t out_wif:1;
+		uint64_t prt_chk:3;
+		uint64_t prt_nxt:1;
+		uint64_t prt_psb:8;
+		uint64_t ncb_inb:2;
+		uint64_t prt_qcb:2;
+		uint64_t prt_qsb:3;
+		uint64_t prt_ctl:2;
+		uint64_t dat_dat:2;
+		uint64_t dat_ptr:4;
+	} cn52xx;
+	struct cvmx_pko_reg_bist_result_cn52xx cn52xxp1;
+	struct cvmx_pko_reg_bist_result_cn52xx cn56xx;
+	struct cvmx_pko_reg_bist_result_cn52xx cn56xxp1;
+	struct cvmx_pko_reg_bist_result_cn50xx cn58xx;
+	struct cvmx_pko_reg_bist_result_cn50xx cn58xxp1;
+} cvmx_pko_reg_bist_result_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_reg_cmd_buf_s {
+		uint64_t reserved_23_63:41;
+		uint64_t pool:3;
+		uint64_t reserved_13_19:7;
+		uint64_t size:13;
+	} s;
+	struct cvmx_pko_reg_cmd_buf_s cn30xx;
+	struct cvmx_pko_reg_cmd_buf_s cn31xx;
+	struct cvmx_pko_reg_cmd_buf_s cn38xx;
+	struct cvmx_pko_reg_cmd_buf_s cn38xxp2;
+	struct cvmx_pko_reg_cmd_buf_s cn50xx;
+	struct cvmx_pko_reg_cmd_buf_s cn52xx;
+	struct cvmx_pko_reg_cmd_buf_s cn52xxp1;
+	struct cvmx_pko_reg_cmd_buf_s cn56xx;
+	struct cvmx_pko_reg_cmd_buf_s cn56xxp1;
+	struct cvmx_pko_reg_cmd_buf_s cn58xx;
+	struct cvmx_pko_reg_cmd_buf_s cn58xxp1;
+} cvmx_pko_reg_cmd_buf_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_reg_crc_ctlx_s {
+		uint64_t reserved_2_63:62;
+		uint64_t invres:1;
+		uint64_t refin:1;
+	} s;
+	struct cvmx_pko_reg_crc_ctlx_s cn38xx;
+	struct cvmx_pko_reg_crc_ctlx_s cn38xxp2;
+	struct cvmx_pko_reg_crc_ctlx_s cn58xx;
+	struct cvmx_pko_reg_crc_ctlx_s cn58xxp1;
+} cvmx_pko_reg_crc_ctlx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_reg_crc_enable_s {
+		uint64_t reserved_32_63:32;
+		uint64_t enable:32;
+	} s;
+	struct cvmx_pko_reg_crc_enable_s cn38xx;
+	struct cvmx_pko_reg_crc_enable_s cn38xxp2;
+	struct cvmx_pko_reg_crc_enable_s cn58xx;
+	struct cvmx_pko_reg_crc_enable_s cn58xxp1;
+} cvmx_pko_reg_crc_enable_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_reg_crc_ivx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t iv:32;
+	} s;
+	struct cvmx_pko_reg_crc_ivx_s cn38xx;
+	struct cvmx_pko_reg_crc_ivx_s cn38xxp2;
+	struct cvmx_pko_reg_crc_ivx_s cn58xx;
+	struct cvmx_pko_reg_crc_ivx_s cn58xxp1;
+} cvmx_pko_reg_crc_ivx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_reg_debug0_s {
+		uint64_t asserts:64;
+	} s;
+	struct cvmx_pko_reg_debug0_cn30xx {
+		uint64_t reserved_17_63:47;
+		uint64_t asserts:17;
+	} cn30xx;
+	struct cvmx_pko_reg_debug0_cn30xx cn31xx;
+	struct cvmx_pko_reg_debug0_cn30xx cn38xx;
+	struct cvmx_pko_reg_debug0_cn30xx cn38xxp2;
+	struct cvmx_pko_reg_debug0_s cn50xx;
+	struct cvmx_pko_reg_debug0_s cn52xx;
+	struct cvmx_pko_reg_debug0_s cn52xxp1;
+	struct cvmx_pko_reg_debug0_s cn56xx;
+	struct cvmx_pko_reg_debug0_s cn56xxp1;
+	struct cvmx_pko_reg_debug0_s cn58xx;
+	struct cvmx_pko_reg_debug0_s cn58xxp1;
+} cvmx_pko_reg_debug0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_reg_debug1_s {
+		uint64_t asserts:64;
+	} s;
+	struct cvmx_pko_reg_debug1_s cn50xx;
+	struct cvmx_pko_reg_debug1_s cn52xx;
+	struct cvmx_pko_reg_debug1_s cn52xxp1;
+	struct cvmx_pko_reg_debug1_s cn56xx;
+	struct cvmx_pko_reg_debug1_s cn56xxp1;
+	struct cvmx_pko_reg_debug1_s cn58xx;
+	struct cvmx_pko_reg_debug1_s cn58xxp1;
+} cvmx_pko_reg_debug1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_reg_debug2_s {
+		uint64_t asserts:64;
+	} s;
+	struct cvmx_pko_reg_debug2_s cn50xx;
+	struct cvmx_pko_reg_debug2_s cn52xx;
+	struct cvmx_pko_reg_debug2_s cn52xxp1;
+	struct cvmx_pko_reg_debug2_s cn56xx;
+	struct cvmx_pko_reg_debug2_s cn56xxp1;
+	struct cvmx_pko_reg_debug2_s cn58xx;
+	struct cvmx_pko_reg_debug2_s cn58xxp1;
+} cvmx_pko_reg_debug2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_reg_debug3_s {
+		uint64_t asserts:64;
+	} s;
+	struct cvmx_pko_reg_debug3_s cn50xx;
+	struct cvmx_pko_reg_debug3_s cn52xx;
+	struct cvmx_pko_reg_debug3_s cn52xxp1;
+	struct cvmx_pko_reg_debug3_s cn56xx;
+	struct cvmx_pko_reg_debug3_s cn56xxp1;
+	struct cvmx_pko_reg_debug3_s cn58xx;
+	struct cvmx_pko_reg_debug3_s cn58xxp1;
+} cvmx_pko_reg_debug3_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_reg_engine_inflight_s {
+		uint64_t reserved_40_63:24;
+		uint64_t engine9:4;
+		uint64_t engine8:4;
+		uint64_t engine7:4;
+		uint64_t engine6:4;
+		uint64_t engine5:4;
+		uint64_t engine4:4;
+		uint64_t engine3:4;
+		uint64_t engine2:4;
+		uint64_t engine1:4;
+		uint64_t engine0:4;
+	} s;
+	struct cvmx_pko_reg_engine_inflight_s cn52xx;
+	struct cvmx_pko_reg_engine_inflight_s cn52xxp1;
+	struct cvmx_pko_reg_engine_inflight_s cn56xx;
+	struct cvmx_pko_reg_engine_inflight_s cn56xxp1;
+} cvmx_pko_reg_engine_inflight_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_reg_engine_thresh_s {
+		uint64_t reserved_10_63:54;
+		uint64_t mask:10;
+	} s;
+	struct cvmx_pko_reg_engine_thresh_s cn52xx;
+	struct cvmx_pko_reg_engine_thresh_s cn52xxp1;
+	struct cvmx_pko_reg_engine_thresh_s cn56xx;
+	struct cvmx_pko_reg_engine_thresh_s cn56xxp1;
+} cvmx_pko_reg_engine_thresh_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_reg_error_s {
+		uint64_t reserved_3_63:61;
+		uint64_t currzero:1;
+		uint64_t doorbell:1;
+		uint64_t parity:1;
+	} s;
+	struct cvmx_pko_reg_error_cn30xx {
+		uint64_t reserved_2_63:62;
+		uint64_t doorbell:1;
+		uint64_t parity:1;
+	} cn30xx;
+	struct cvmx_pko_reg_error_cn30xx cn31xx;
+	struct cvmx_pko_reg_error_cn30xx cn38xx;
+	struct cvmx_pko_reg_error_cn30xx cn38xxp2;
+	struct cvmx_pko_reg_error_s cn50xx;
+	struct cvmx_pko_reg_error_s cn52xx;
+	struct cvmx_pko_reg_error_s cn52xxp1;
+	struct cvmx_pko_reg_error_s cn56xx;
+	struct cvmx_pko_reg_error_s cn56xxp1;
+	struct cvmx_pko_reg_error_s cn58xx;
+	struct cvmx_pko_reg_error_s cn58xxp1;
+} cvmx_pko_reg_error_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_reg_flags_s {
+		uint64_t reserved_4_63:60;
+		uint64_t reset:1;
+		uint64_t store_be:1;
+		uint64_t ena_dwb:1;
+		uint64_t ena_pko:1;
+	} s;
+	struct cvmx_pko_reg_flags_s cn30xx;
+	struct cvmx_pko_reg_flags_s cn31xx;
+	struct cvmx_pko_reg_flags_s cn38xx;
+	struct cvmx_pko_reg_flags_s cn38xxp2;
+	struct cvmx_pko_reg_flags_s cn50xx;
+	struct cvmx_pko_reg_flags_s cn52xx;
+	struct cvmx_pko_reg_flags_s cn52xxp1;
+	struct cvmx_pko_reg_flags_s cn56xx;
+	struct cvmx_pko_reg_flags_s cn56xxp1;
+	struct cvmx_pko_reg_flags_s cn58xx;
+	struct cvmx_pko_reg_flags_s cn58xxp1;
+} cvmx_pko_reg_flags_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_reg_gmx_port_mode_s {
+		uint64_t reserved_6_63:58;
+		uint64_t mode1:3;
+		uint64_t mode0:3;
+	} s;
+	struct cvmx_pko_reg_gmx_port_mode_s cn30xx;
+	struct cvmx_pko_reg_gmx_port_mode_s cn31xx;
+	struct cvmx_pko_reg_gmx_port_mode_s cn38xx;
+	struct cvmx_pko_reg_gmx_port_mode_s cn38xxp2;
+	struct cvmx_pko_reg_gmx_port_mode_s cn50xx;
+	struct cvmx_pko_reg_gmx_port_mode_s cn52xx;
+	struct cvmx_pko_reg_gmx_port_mode_s cn52xxp1;
+	struct cvmx_pko_reg_gmx_port_mode_s cn56xx;
+	struct cvmx_pko_reg_gmx_port_mode_s cn56xxp1;
+	struct cvmx_pko_reg_gmx_port_mode_s cn58xx;
+	struct cvmx_pko_reg_gmx_port_mode_s cn58xxp1;
+} cvmx_pko_reg_gmx_port_mode_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_reg_int_mask_s {
+		uint64_t reserved_3_63:61;
+		uint64_t currzero:1;
+		uint64_t doorbell:1;
+		uint64_t parity:1;
+	} s;
+	struct cvmx_pko_reg_int_mask_cn30xx {
+		uint64_t reserved_2_63:62;
+		uint64_t doorbell:1;
+		uint64_t parity:1;
+	} cn30xx;
+	struct cvmx_pko_reg_int_mask_cn30xx cn31xx;
+	struct cvmx_pko_reg_int_mask_cn30xx cn38xx;
+	struct cvmx_pko_reg_int_mask_cn30xx cn38xxp2;
+	struct cvmx_pko_reg_int_mask_s cn50xx;
+	struct cvmx_pko_reg_int_mask_s cn52xx;
+	struct cvmx_pko_reg_int_mask_s cn52xxp1;
+	struct cvmx_pko_reg_int_mask_s cn56xx;
+	struct cvmx_pko_reg_int_mask_s cn56xxp1;
+	struct cvmx_pko_reg_int_mask_s cn58xx;
+	struct cvmx_pko_reg_int_mask_s cn58xxp1;
+} cvmx_pko_reg_int_mask_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_reg_queue_mode_s {
+		uint64_t reserved_2_63:62;
+		uint64_t mode:2;
+	} s;
+	struct cvmx_pko_reg_queue_mode_s cn30xx;
+	struct cvmx_pko_reg_queue_mode_s cn31xx;
+	struct cvmx_pko_reg_queue_mode_s cn38xx;
+	struct cvmx_pko_reg_queue_mode_s cn38xxp2;
+	struct cvmx_pko_reg_queue_mode_s cn50xx;
+	struct cvmx_pko_reg_queue_mode_s cn52xx;
+	struct cvmx_pko_reg_queue_mode_s cn52xxp1;
+	struct cvmx_pko_reg_queue_mode_s cn56xx;
+	struct cvmx_pko_reg_queue_mode_s cn56xxp1;
+	struct cvmx_pko_reg_queue_mode_s cn58xx;
+	struct cvmx_pko_reg_queue_mode_s cn58xxp1;
+} cvmx_pko_reg_queue_mode_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_reg_queue_ptrs1_s {
+		uint64_t reserved_2_63:62;
+		uint64_t idx3:1;
+		uint64_t qid7:1;
+	} s;
+	struct cvmx_pko_reg_queue_ptrs1_s cn50xx;
+	struct cvmx_pko_reg_queue_ptrs1_s cn52xx;
+	struct cvmx_pko_reg_queue_ptrs1_s cn52xxp1;
+	struct cvmx_pko_reg_queue_ptrs1_s cn56xx;
+	struct cvmx_pko_reg_queue_ptrs1_s cn56xxp1;
+	struct cvmx_pko_reg_queue_ptrs1_s cn58xx;
+	struct cvmx_pko_reg_queue_ptrs1_s cn58xxp1;
+} cvmx_pko_reg_queue_ptrs1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pko_reg_read_idx_s {
+		uint64_t reserved_16_63:48;
+		uint64_t inc:8;
+		uint64_t index:8;
+	} s;
+	struct cvmx_pko_reg_read_idx_s cn30xx;
+	struct cvmx_pko_reg_read_idx_s cn31xx;
+	struct cvmx_pko_reg_read_idx_s cn38xx;
+	struct cvmx_pko_reg_read_idx_s cn38xxp2;
+	struct cvmx_pko_reg_read_idx_s cn50xx;
+	struct cvmx_pko_reg_read_idx_s cn52xx;
+	struct cvmx_pko_reg_read_idx_s cn52xxp1;
+	struct cvmx_pko_reg_read_idx_s cn56xx;
+	struct cvmx_pko_reg_read_idx_s cn56xxp1;
+	struct cvmx_pko_reg_read_idx_s cn58xx;
+	struct cvmx_pko_reg_read_idx_s cn58xxp1;
+} cvmx_pko_reg_read_idx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pow_bist_stat_s {
+		uint64_t reserved_32_63:32;
+		uint64_t pp:16;
+		uint64_t reserved_0_15:16;
+	} s;
+	struct cvmx_pow_bist_stat_cn30xx {
+		uint64_t reserved_17_63:47;
+		uint64_t pp:1;
+		uint64_t reserved_9_15:7;
+		uint64_t cam:1;
+		uint64_t nbt1:1;
+		uint64_t nbt0:1;
+		uint64_t index:1;
+		uint64_t fidx:1;
+		uint64_t nbr1:1;
+		uint64_t nbr0:1;
+		uint64_t pend:1;
+		uint64_t adr:1;
+	} cn30xx;
+	struct cvmx_pow_bist_stat_cn31xx {
+		uint64_t reserved_18_63:46;
+		uint64_t pp:2;
+		uint64_t reserved_9_15:7;
+		uint64_t cam:1;
+		uint64_t nbt1:1;
+		uint64_t nbt0:1;
+		uint64_t index:1;
+		uint64_t fidx:1;
+		uint64_t nbr1:1;
+		uint64_t nbr0:1;
+		uint64_t pend:1;
+		uint64_t adr:1;
+	} cn31xx;
+	struct cvmx_pow_bist_stat_cn38xx {
+		uint64_t reserved_32_63:32;
+		uint64_t pp:16;
+		uint64_t reserved_10_15:6;
+		uint64_t cam:1;
+		uint64_t nbt:1;
+		uint64_t index:1;
+		uint64_t fidx:1;
+		uint64_t nbr1:1;
+		uint64_t nbr0:1;
+		uint64_t pend1:1;
+		uint64_t pend0:1;
+		uint64_t adr1:1;
+		uint64_t adr0:1;
+	} cn38xx;
+	struct cvmx_pow_bist_stat_cn38xx cn38xxp2;
+	struct cvmx_pow_bist_stat_cn31xx cn50xx;
+	struct cvmx_pow_bist_stat_cn52xx {
+		uint64_t reserved_20_63:44;
+		uint64_t pp:4;
+		uint64_t reserved_9_15:7;
+		uint64_t cam:1;
+		uint64_t nbt1:1;
+		uint64_t nbt0:1;
+		uint64_t index:1;
+		uint64_t fidx:1;
+		uint64_t nbr1:1;
+		uint64_t nbr0:1;
+		uint64_t pend:1;
+		uint64_t adr:1;
+	} cn52xx;
+	struct cvmx_pow_bist_stat_cn52xx cn52xxp1;
+	struct cvmx_pow_bist_stat_cn56xx {
+		uint64_t reserved_28_63:36;
+		uint64_t pp:12;
+		uint64_t reserved_10_15:6;
+		uint64_t cam:1;
+		uint64_t nbt:1;
+		uint64_t index:1;
+		uint64_t fidx:1;
+		uint64_t nbr1:1;
+		uint64_t nbr0:1;
+		uint64_t pend1:1;
+		uint64_t pend0:1;
+		uint64_t adr1:1;
+		uint64_t adr0:1;
+	} cn56xx;
+	struct cvmx_pow_bist_stat_cn56xx cn56xxp1;
+	struct cvmx_pow_bist_stat_cn38xx cn58xx;
+	struct cvmx_pow_bist_stat_cn38xx cn58xxp1;
+} cvmx_pow_bist_stat_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pow_ds_pc_s {
+		uint64_t reserved_32_63:32;
+		uint64_t ds_pc:32;
+	} s;
+	struct cvmx_pow_ds_pc_s cn30xx;
+	struct cvmx_pow_ds_pc_s cn31xx;
+	struct cvmx_pow_ds_pc_s cn38xx;
+	struct cvmx_pow_ds_pc_s cn38xxp2;
+	struct cvmx_pow_ds_pc_s cn50xx;
+	struct cvmx_pow_ds_pc_s cn52xx;
+	struct cvmx_pow_ds_pc_s cn52xxp1;
+	struct cvmx_pow_ds_pc_s cn56xx;
+	struct cvmx_pow_ds_pc_s cn56xxp1;
+	struct cvmx_pow_ds_pc_s cn58xx;
+	struct cvmx_pow_ds_pc_s cn58xxp1;
+} cvmx_pow_ds_pc_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pow_ecc_err_s {
+		uint64_t reserved_45_63:19;
+		uint64_t iop_ie:13;
+		uint64_t reserved_29_31:3;
+		uint64_t iop:13;
+		uint64_t reserved_14_15:2;
+		uint64_t rpe_ie:1;
+		uint64_t rpe:1;
+		uint64_t reserved_9_11:3;
+		uint64_t syn:5;
+		uint64_t dbe_ie:1;
+		uint64_t sbe_ie:1;
+		uint64_t dbe:1;
+		uint64_t sbe:1;
+	} s;
+	struct cvmx_pow_ecc_err_s cn30xx;
+	struct cvmx_pow_ecc_err_cn31xx {
+		uint64_t reserved_14_63:50;
+		uint64_t rpe_ie:1;
+		uint64_t rpe:1;
+		uint64_t reserved_9_11:3;
+		uint64_t syn:5;
+		uint64_t dbe_ie:1;
+		uint64_t sbe_ie:1;
+		uint64_t dbe:1;
+		uint64_t sbe:1;
+	} cn31xx;
+	struct cvmx_pow_ecc_err_s cn38xx;
+	struct cvmx_pow_ecc_err_cn31xx cn38xxp2;
+	struct cvmx_pow_ecc_err_s cn50xx;
+	struct cvmx_pow_ecc_err_s cn52xx;
+	struct cvmx_pow_ecc_err_s cn52xxp1;
+	struct cvmx_pow_ecc_err_s cn56xx;
+	struct cvmx_pow_ecc_err_s cn56xxp1;
+	struct cvmx_pow_ecc_err_s cn58xx;
+	struct cvmx_pow_ecc_err_s cn58xxp1;
+} cvmx_pow_ecc_err_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pow_int_ctl_s {
+		uint64_t reserved_6_63:58;
+		uint64_t pfr_dis:1;
+		uint64_t nbr_thr:5;
+	} s;
+	struct cvmx_pow_int_ctl_s cn30xx;
+	struct cvmx_pow_int_ctl_s cn31xx;
+	struct cvmx_pow_int_ctl_s cn38xx;
+	struct cvmx_pow_int_ctl_s cn38xxp2;
+	struct cvmx_pow_int_ctl_s cn50xx;
+	struct cvmx_pow_int_ctl_s cn52xx;
+	struct cvmx_pow_int_ctl_s cn52xxp1;
+	struct cvmx_pow_int_ctl_s cn56xx;
+	struct cvmx_pow_int_ctl_s cn56xxp1;
+	struct cvmx_pow_int_ctl_s cn58xx;
+	struct cvmx_pow_int_ctl_s cn58xxp1;
+} cvmx_pow_int_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pow_iq_cntx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t iq_cnt:32;
+	} s;
+	struct cvmx_pow_iq_cntx_s cn30xx;
+	struct cvmx_pow_iq_cntx_s cn31xx;
+	struct cvmx_pow_iq_cntx_s cn38xx;
+	struct cvmx_pow_iq_cntx_s cn38xxp2;
+	struct cvmx_pow_iq_cntx_s cn50xx;
+	struct cvmx_pow_iq_cntx_s cn52xx;
+	struct cvmx_pow_iq_cntx_s cn52xxp1;
+	struct cvmx_pow_iq_cntx_s cn56xx;
+	struct cvmx_pow_iq_cntx_s cn56xxp1;
+	struct cvmx_pow_iq_cntx_s cn58xx;
+	struct cvmx_pow_iq_cntx_s cn58xxp1;
+} cvmx_pow_iq_cntx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pow_iq_com_cnt_s {
+		uint64_t reserved_32_63:32;
+		uint64_t iq_cnt:32;
+	} s;
+	struct cvmx_pow_iq_com_cnt_s cn30xx;
+	struct cvmx_pow_iq_com_cnt_s cn31xx;
+	struct cvmx_pow_iq_com_cnt_s cn38xx;
+	struct cvmx_pow_iq_com_cnt_s cn38xxp2;
+	struct cvmx_pow_iq_com_cnt_s cn50xx;
+	struct cvmx_pow_iq_com_cnt_s cn52xx;
+	struct cvmx_pow_iq_com_cnt_s cn52xxp1;
+	struct cvmx_pow_iq_com_cnt_s cn56xx;
+	struct cvmx_pow_iq_com_cnt_s cn56xxp1;
+	struct cvmx_pow_iq_com_cnt_s cn58xx;
+	struct cvmx_pow_iq_com_cnt_s cn58xxp1;
+} cvmx_pow_iq_com_cnt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pow_iq_int_s {
+		uint64_t reserved_8_63:56;
+		uint64_t iq_int:8;
+	} s;
+	struct cvmx_pow_iq_int_s cn52xx;
+	struct cvmx_pow_iq_int_s cn52xxp1;
+	struct cvmx_pow_iq_int_s cn56xx;
+	struct cvmx_pow_iq_int_s cn56xxp1;
+} cvmx_pow_iq_int_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pow_iq_int_en_s {
+		uint64_t reserved_8_63:56;
+		uint64_t int_en:8;
+	} s;
+	struct cvmx_pow_iq_int_en_s cn52xx;
+	struct cvmx_pow_iq_int_en_s cn52xxp1;
+	struct cvmx_pow_iq_int_en_s cn56xx;
+	struct cvmx_pow_iq_int_en_s cn56xxp1;
+} cvmx_pow_iq_int_en_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pow_iq_thrx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t iq_thr:32;
+	} s;
+	struct cvmx_pow_iq_thrx_s cn52xx;
+	struct cvmx_pow_iq_thrx_s cn52xxp1;
+	struct cvmx_pow_iq_thrx_s cn56xx;
+	struct cvmx_pow_iq_thrx_s cn56xxp1;
+} cvmx_pow_iq_thrx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pow_nos_cnt_s {
+		uint64_t reserved_12_63:52;
+		uint64_t nos_cnt:12;
+	} s;
+	struct cvmx_pow_nos_cnt_cn30xx {
+		uint64_t reserved_7_63:57;
+		uint64_t nos_cnt:7;
+	} cn30xx;
+	struct cvmx_pow_nos_cnt_cn31xx {
+		uint64_t reserved_9_63:55;
+		uint64_t nos_cnt:9;
+	} cn31xx;
+	struct cvmx_pow_nos_cnt_s cn38xx;
+	struct cvmx_pow_nos_cnt_s cn38xxp2;
+	struct cvmx_pow_nos_cnt_cn31xx cn50xx;
+	struct cvmx_pow_nos_cnt_cn52xx {
+		uint64_t reserved_10_63:54;
+		uint64_t nos_cnt:10;
+	} cn52xx;
+	struct cvmx_pow_nos_cnt_cn52xx cn52xxp1;
+	struct cvmx_pow_nos_cnt_s cn56xx;
+	struct cvmx_pow_nos_cnt_s cn56xxp1;
+	struct cvmx_pow_nos_cnt_s cn58xx;
+	struct cvmx_pow_nos_cnt_s cn58xxp1;
+} cvmx_pow_nos_cnt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pow_nw_tim_s {
+		uint64_t reserved_10_63:54;
+		uint64_t nw_tim:10;
+	} s;
+	struct cvmx_pow_nw_tim_s cn30xx;
+	struct cvmx_pow_nw_tim_s cn31xx;
+	struct cvmx_pow_nw_tim_s cn38xx;
+	struct cvmx_pow_nw_tim_s cn38xxp2;
+	struct cvmx_pow_nw_tim_s cn50xx;
+	struct cvmx_pow_nw_tim_s cn52xx;
+	struct cvmx_pow_nw_tim_s cn52xxp1;
+	struct cvmx_pow_nw_tim_s cn56xx;
+	struct cvmx_pow_nw_tim_s cn56xxp1;
+	struct cvmx_pow_nw_tim_s cn58xx;
+	struct cvmx_pow_nw_tim_s cn58xxp1;
+} cvmx_pow_nw_tim_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pow_pf_rst_msk_s {
+		uint64_t reserved_8_63:56;
+		uint64_t rst_msk:8;
+	} s;
+	struct cvmx_pow_pf_rst_msk_s cn50xx;
+	struct cvmx_pow_pf_rst_msk_s cn52xx;
+	struct cvmx_pow_pf_rst_msk_s cn52xxp1;
+	struct cvmx_pow_pf_rst_msk_s cn56xx;
+	struct cvmx_pow_pf_rst_msk_s cn56xxp1;
+	struct cvmx_pow_pf_rst_msk_s cn58xx;
+	struct cvmx_pow_pf_rst_msk_s cn58xxp1;
+} cvmx_pow_pf_rst_msk_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pow_pp_grp_mskx_s {
+		uint64_t reserved_48_63:16;
+		uint64_t qos7_pri:4;
+		uint64_t qos6_pri:4;
+		uint64_t qos5_pri:4;
+		uint64_t qos4_pri:4;
+		uint64_t qos3_pri:4;
+		uint64_t qos2_pri:4;
+		uint64_t qos1_pri:4;
+		uint64_t qos0_pri:4;
+		uint64_t grp_msk:16;
+	} s;
+	struct cvmx_pow_pp_grp_mskx_cn30xx {
+		uint64_t reserved_16_63:48;
+		uint64_t grp_msk:16;
+	} cn30xx;
+	struct cvmx_pow_pp_grp_mskx_cn30xx cn31xx;
+	struct cvmx_pow_pp_grp_mskx_cn30xx cn38xx;
+	struct cvmx_pow_pp_grp_mskx_cn30xx cn38xxp2;
+	struct cvmx_pow_pp_grp_mskx_s cn50xx;
+	struct cvmx_pow_pp_grp_mskx_s cn52xx;
+	struct cvmx_pow_pp_grp_mskx_s cn52xxp1;
+	struct cvmx_pow_pp_grp_mskx_s cn56xx;
+	struct cvmx_pow_pp_grp_mskx_s cn56xxp1;
+	struct cvmx_pow_pp_grp_mskx_s cn58xx;
+	struct cvmx_pow_pp_grp_mskx_s cn58xxp1;
+} cvmx_pow_pp_grp_mskx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pow_qos_rndx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t rnd_p3:8;
+		uint64_t rnd_p2:8;
+		uint64_t rnd_p1:8;
+		uint64_t rnd:8;
+	} s;
+	struct cvmx_pow_qos_rndx_s cn30xx;
+	struct cvmx_pow_qos_rndx_s cn31xx;
+	struct cvmx_pow_qos_rndx_s cn38xx;
+	struct cvmx_pow_qos_rndx_s cn38xxp2;
+	struct cvmx_pow_qos_rndx_s cn50xx;
+	struct cvmx_pow_qos_rndx_s cn52xx;
+	struct cvmx_pow_qos_rndx_s cn52xxp1;
+	struct cvmx_pow_qos_rndx_s cn56xx;
+	struct cvmx_pow_qos_rndx_s cn56xxp1;
+	struct cvmx_pow_qos_rndx_s cn58xx;
+	struct cvmx_pow_qos_rndx_s cn58xxp1;
+} cvmx_pow_qos_rndx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pow_qos_thrx_s {
+		uint64_t reserved_60_63:4;
+		uint64_t des_cnt:12;
+		uint64_t buf_cnt:12;
+		uint64_t free_cnt:12;
+		uint64_t reserved_23_23:1;
+		uint64_t max_thr:11;
+		uint64_t reserved_11_11:1;
+		uint64_t min_thr:11;
+	} s;
+	struct cvmx_pow_qos_thrx_cn30xx {
+		uint64_t reserved_55_63:9;
+		uint64_t des_cnt:7;
+		uint64_t reserved_43_47:5;
+		uint64_t buf_cnt:7;
+		uint64_t reserved_31_35:5;
+		uint64_t free_cnt:7;
+		uint64_t reserved_18_23:6;
+		uint64_t max_thr:6;
+		uint64_t reserved_6_11:6;
+		uint64_t min_thr:6;
+	} cn30xx;
+	struct cvmx_pow_qos_thrx_cn31xx {
+		uint64_t reserved_57_63:7;
+		uint64_t des_cnt:9;
+		uint64_t reserved_45_47:3;
+		uint64_t buf_cnt:9;
+		uint64_t reserved_33_35:3;
+		uint64_t free_cnt:9;
+		uint64_t reserved_20_23:4;
+		uint64_t max_thr:8;
+		uint64_t reserved_8_11:4;
+		uint64_t min_thr:8;
+	} cn31xx;
+	struct cvmx_pow_qos_thrx_s cn38xx;
+	struct cvmx_pow_qos_thrx_s cn38xxp2;
+	struct cvmx_pow_qos_thrx_cn31xx cn50xx;
+	struct cvmx_pow_qos_thrx_cn52xx {
+		uint64_t reserved_58_63:6;
+		uint64_t des_cnt:10;
+		uint64_t reserved_46_47:2;
+		uint64_t buf_cnt:10;
+		uint64_t reserved_34_35:2;
+		uint64_t free_cnt:10;
+		uint64_t reserved_21_23:3;
+		uint64_t max_thr:9;
+		uint64_t reserved_9_11:3;
+		uint64_t min_thr:9;
+	} cn52xx;
+	struct cvmx_pow_qos_thrx_cn52xx cn52xxp1;
+	struct cvmx_pow_qos_thrx_s cn56xx;
+	struct cvmx_pow_qos_thrx_s cn56xxp1;
+	struct cvmx_pow_qos_thrx_s cn58xx;
+	struct cvmx_pow_qos_thrx_s cn58xxp1;
+} cvmx_pow_qos_thrx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pow_ts_pc_s {
+		uint64_t reserved_32_63:32;
+		uint64_t ts_pc:32;
+	} s;
+	struct cvmx_pow_ts_pc_s cn30xx;
+	struct cvmx_pow_ts_pc_s cn31xx;
+	struct cvmx_pow_ts_pc_s cn38xx;
+	struct cvmx_pow_ts_pc_s cn38xxp2;
+	struct cvmx_pow_ts_pc_s cn50xx;
+	struct cvmx_pow_ts_pc_s cn52xx;
+	struct cvmx_pow_ts_pc_s cn52xxp1;
+	struct cvmx_pow_ts_pc_s cn56xx;
+	struct cvmx_pow_ts_pc_s cn56xxp1;
+	struct cvmx_pow_ts_pc_s cn58xx;
+	struct cvmx_pow_ts_pc_s cn58xxp1;
+} cvmx_pow_ts_pc_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pow_wa_com_pc_s {
+		uint64_t reserved_32_63:32;
+		uint64_t wa_pc:32;
+	} s;
+	struct cvmx_pow_wa_com_pc_s cn30xx;
+	struct cvmx_pow_wa_com_pc_s cn31xx;
+	struct cvmx_pow_wa_com_pc_s cn38xx;
+	struct cvmx_pow_wa_com_pc_s cn38xxp2;
+	struct cvmx_pow_wa_com_pc_s cn50xx;
+	struct cvmx_pow_wa_com_pc_s cn52xx;
+	struct cvmx_pow_wa_com_pc_s cn52xxp1;
+	struct cvmx_pow_wa_com_pc_s cn56xx;
+	struct cvmx_pow_wa_com_pc_s cn56xxp1;
+	struct cvmx_pow_wa_com_pc_s cn58xx;
+	struct cvmx_pow_wa_com_pc_s cn58xxp1;
+} cvmx_pow_wa_com_pc_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pow_wa_pcx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t wa_pc:32;
+	} s;
+	struct cvmx_pow_wa_pcx_s cn30xx;
+	struct cvmx_pow_wa_pcx_s cn31xx;
+	struct cvmx_pow_wa_pcx_s cn38xx;
+	struct cvmx_pow_wa_pcx_s cn38xxp2;
+	struct cvmx_pow_wa_pcx_s cn50xx;
+	struct cvmx_pow_wa_pcx_s cn52xx;
+	struct cvmx_pow_wa_pcx_s cn52xxp1;
+	struct cvmx_pow_wa_pcx_s cn56xx;
+	struct cvmx_pow_wa_pcx_s cn56xxp1;
+	struct cvmx_pow_wa_pcx_s cn58xx;
+	struct cvmx_pow_wa_pcx_s cn58xxp1;
+} cvmx_pow_wa_pcx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pow_wq_int_s {
+		uint64_t reserved_32_63:32;
+		uint64_t iq_dis:16;
+		uint64_t wq_int:16;
+	} s;
+	struct cvmx_pow_wq_int_s cn30xx;
+	struct cvmx_pow_wq_int_s cn31xx;
+	struct cvmx_pow_wq_int_s cn38xx;
+	struct cvmx_pow_wq_int_s cn38xxp2;
+	struct cvmx_pow_wq_int_s cn50xx;
+	struct cvmx_pow_wq_int_s cn52xx;
+	struct cvmx_pow_wq_int_s cn52xxp1;
+	struct cvmx_pow_wq_int_s cn56xx;
+	struct cvmx_pow_wq_int_s cn56xxp1;
+	struct cvmx_pow_wq_int_s cn58xx;
+	struct cvmx_pow_wq_int_s cn58xxp1;
+} cvmx_pow_wq_int_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pow_wq_int_cntx_s {
+		uint64_t reserved_28_63:36;
+		uint64_t tc_cnt:4;
+		uint64_t ds_cnt:12;
+		uint64_t iq_cnt:12;
+	} s;
+	struct cvmx_pow_wq_int_cntx_cn30xx {
+		uint64_t reserved_28_63:36;
+		uint64_t tc_cnt:4;
+		uint64_t reserved_19_23:5;
+		uint64_t ds_cnt:7;
+		uint64_t reserved_7_11:5;
+		uint64_t iq_cnt:7;
+	} cn30xx;
+	struct cvmx_pow_wq_int_cntx_cn31xx {
+		uint64_t reserved_28_63:36;
+		uint64_t tc_cnt:4;
+		uint64_t reserved_21_23:3;
+		uint64_t ds_cnt:9;
+		uint64_t reserved_9_11:3;
+		uint64_t iq_cnt:9;
+	} cn31xx;
+	struct cvmx_pow_wq_int_cntx_s cn38xx;
+	struct cvmx_pow_wq_int_cntx_s cn38xxp2;
+	struct cvmx_pow_wq_int_cntx_cn31xx cn50xx;
+	struct cvmx_pow_wq_int_cntx_cn52xx {
+		uint64_t reserved_28_63:36;
+		uint64_t tc_cnt:4;
+		uint64_t reserved_22_23:2;
+		uint64_t ds_cnt:10;
+		uint64_t reserved_10_11:2;
+		uint64_t iq_cnt:10;
+	} cn52xx;
+	struct cvmx_pow_wq_int_cntx_cn52xx cn52xxp1;
+	struct cvmx_pow_wq_int_cntx_s cn56xx;
+	struct cvmx_pow_wq_int_cntx_s cn56xxp1;
+	struct cvmx_pow_wq_int_cntx_s cn58xx;
+	struct cvmx_pow_wq_int_cntx_s cn58xxp1;
+} cvmx_pow_wq_int_cntx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pow_wq_int_pc_s {
+		uint64_t reserved_60_63:4;
+		uint64_t pc:28;
+		uint64_t reserved_28_31:4;
+		uint64_t pc_thr:20;
+		uint64_t reserved_0_7:8;
+	} s;
+	struct cvmx_pow_wq_int_pc_s cn30xx;
+	struct cvmx_pow_wq_int_pc_s cn31xx;
+	struct cvmx_pow_wq_int_pc_s cn38xx;
+	struct cvmx_pow_wq_int_pc_s cn38xxp2;
+	struct cvmx_pow_wq_int_pc_s cn50xx;
+	struct cvmx_pow_wq_int_pc_s cn52xx;
+	struct cvmx_pow_wq_int_pc_s cn52xxp1;
+	struct cvmx_pow_wq_int_pc_s cn56xx;
+	struct cvmx_pow_wq_int_pc_s cn56xxp1;
+	struct cvmx_pow_wq_int_pc_s cn58xx;
+	struct cvmx_pow_wq_int_pc_s cn58xxp1;
+} cvmx_pow_wq_int_pc_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pow_wq_int_thrx_s {
+		uint64_t reserved_29_63:35;
+		uint64_t tc_en:1;
+		uint64_t tc_thr:4;
+		uint64_t reserved_23_23:1;
+		uint64_t ds_thr:11;
+		uint64_t reserved_11_11:1;
+		uint64_t iq_thr:11;
+	} s;
+	struct cvmx_pow_wq_int_thrx_cn30xx {
+		uint64_t reserved_29_63:35;
+		uint64_t tc_en:1;
+		uint64_t tc_thr:4;
+		uint64_t reserved_18_23:6;
+		uint64_t ds_thr:6;
+		uint64_t reserved_6_11:6;
+		uint64_t iq_thr:6;
+	} cn30xx;
+	struct cvmx_pow_wq_int_thrx_cn31xx {
+		uint64_t reserved_29_63:35;
+		uint64_t tc_en:1;
+		uint64_t tc_thr:4;
+		uint64_t reserved_20_23:4;
+		uint64_t ds_thr:8;
+		uint64_t reserved_8_11:4;
+		uint64_t iq_thr:8;
+	} cn31xx;
+	struct cvmx_pow_wq_int_thrx_s cn38xx;
+	struct cvmx_pow_wq_int_thrx_s cn38xxp2;
+	struct cvmx_pow_wq_int_thrx_cn31xx cn50xx;
+	struct cvmx_pow_wq_int_thrx_cn52xx {
+		uint64_t reserved_29_63:35;
+		uint64_t tc_en:1;
+		uint64_t tc_thr:4;
+		uint64_t reserved_21_23:3;
+		uint64_t ds_thr:9;
+		uint64_t reserved_9_11:3;
+		uint64_t iq_thr:9;
+	} cn52xx;
+	struct cvmx_pow_wq_int_thrx_cn52xx cn52xxp1;
+	struct cvmx_pow_wq_int_thrx_s cn56xx;
+	struct cvmx_pow_wq_int_thrx_s cn56xxp1;
+	struct cvmx_pow_wq_int_thrx_s cn58xx;
+	struct cvmx_pow_wq_int_thrx_s cn58xxp1;
+} cvmx_pow_wq_int_thrx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_pow_ws_pcx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t ws_pc:32;
+	} s;
+	struct cvmx_pow_ws_pcx_s cn30xx;
+	struct cvmx_pow_ws_pcx_s cn31xx;
+	struct cvmx_pow_ws_pcx_s cn38xx;
+	struct cvmx_pow_ws_pcx_s cn38xxp2;
+	struct cvmx_pow_ws_pcx_s cn50xx;
+	struct cvmx_pow_ws_pcx_s cn52xx;
+	struct cvmx_pow_ws_pcx_s cn52xxp1;
+	struct cvmx_pow_ws_pcx_s cn56xx;
+	struct cvmx_pow_ws_pcx_s cn56xxp1;
+	struct cvmx_pow_ws_pcx_s cn58xx;
+	struct cvmx_pow_ws_pcx_s cn58xxp1;
+} cvmx_pow_ws_pcx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_rad_mem_debug0_s {
+		uint64_t iword:64;
+	} s;
+	struct cvmx_rad_mem_debug0_s cn52xx;
+	struct cvmx_rad_mem_debug0_s cn52xxp1;
+	struct cvmx_rad_mem_debug0_s cn56xx;
+	struct cvmx_rad_mem_debug0_s cn56xxp1;
+} cvmx_rad_mem_debug0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_rad_mem_debug1_s {
+		uint64_t p_dat:64;
+	} s;
+	struct cvmx_rad_mem_debug1_s cn52xx;
+	struct cvmx_rad_mem_debug1_s cn52xxp1;
+	struct cvmx_rad_mem_debug1_s cn56xx;
+	struct cvmx_rad_mem_debug1_s cn56xxp1;
+} cvmx_rad_mem_debug1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_rad_mem_debug2_s {
+		uint64_t q_dat:64;
+	} s;
+	struct cvmx_rad_mem_debug2_s cn52xx;
+	struct cvmx_rad_mem_debug2_s cn52xxp1;
+	struct cvmx_rad_mem_debug2_s cn56xx;
+	struct cvmx_rad_mem_debug2_s cn56xxp1;
+} cvmx_rad_mem_debug2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_rad_reg_bist_result_s {
+		uint64_t reserved_6_63:58;
+		uint64_t sta:1;
+		uint64_t ncb_oub:1;
+		uint64_t ncb_inb:2;
+		uint64_t dat:2;
+	} s;
+	struct cvmx_rad_reg_bist_result_s cn52xx;
+	struct cvmx_rad_reg_bist_result_s cn52xxp1;
+	struct cvmx_rad_reg_bist_result_s cn56xx;
+	struct cvmx_rad_reg_bist_result_s cn56xxp1;
+} cvmx_rad_reg_bist_result_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_rad_reg_cmd_buf_s {
+		uint64_t reserved_58_63:6;
+		uint64_t dwb:9;
+		uint64_t pool:3;
+		uint64_t size:13;
+		uint64_t ptr:33;
+	} s;
+	struct cvmx_rad_reg_cmd_buf_s cn52xx;
+	struct cvmx_rad_reg_cmd_buf_s cn52xxp1;
+	struct cvmx_rad_reg_cmd_buf_s cn56xx;
+	struct cvmx_rad_reg_cmd_buf_s cn56xxp1;
+} cvmx_rad_reg_cmd_buf_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_rad_reg_ctl_s {
+		uint64_t reserved_6_63:58;
+		uint64_t max_read:4;
+		uint64_t store_le:1;
+		uint64_t reset:1;
+	} s;
+	struct cvmx_rad_reg_ctl_s cn52xx;
+	struct cvmx_rad_reg_ctl_s cn52xxp1;
+	struct cvmx_rad_reg_ctl_s cn56xx;
+	struct cvmx_rad_reg_ctl_s cn56xxp1;
+} cvmx_rad_reg_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_rad_reg_debug0_s {
+		uint64_t reserved_57_63:7;
+		uint64_t loop:25;
+		uint64_t reserved_22_31:10;
+		uint64_t iridx:6;
+		uint64_t reserved_14_15:2;
+		uint64_t iwidx:6;
+		uint64_t owordqv:1;
+		uint64_t owordpv:1;
+		uint64_t commit:1;
+		uint64_t state:5;
+	} s;
+	struct cvmx_rad_reg_debug0_s cn52xx;
+	struct cvmx_rad_reg_debug0_s cn52xxp1;
+	struct cvmx_rad_reg_debug0_s cn56xx;
+	struct cvmx_rad_reg_debug0_s cn56xxp1;
+} cvmx_rad_reg_debug0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_rad_reg_debug1_s {
+		uint64_t cword:64;
+	} s;
+	struct cvmx_rad_reg_debug1_s cn52xx;
+	struct cvmx_rad_reg_debug1_s cn52xxp1;
+	struct cvmx_rad_reg_debug1_s cn56xx;
+	struct cvmx_rad_reg_debug1_s cn56xxp1;
+} cvmx_rad_reg_debug1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_rad_reg_debug10_s {
+		uint64_t flags:8;
+		uint64_t size:16;
+		uint64_t ptr:40;
+	} s;
+	struct cvmx_rad_reg_debug10_s cn52xx;
+	struct cvmx_rad_reg_debug10_s cn52xxp1;
+	struct cvmx_rad_reg_debug10_s cn56xx;
+	struct cvmx_rad_reg_debug10_s cn56xxp1;
+} cvmx_rad_reg_debug10_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_rad_reg_debug11_s {
+		uint64_t reserved_13_63:51;
+		uint64_t q:1;
+		uint64_t p:1;
+		uint64_t wc:1;
+		uint64_t eod:1;
+		uint64_t sod:1;
+		uint64_t index:8;
+	} s;
+	struct cvmx_rad_reg_debug11_s cn52xx;
+	struct cvmx_rad_reg_debug11_s cn52xxp1;
+	struct cvmx_rad_reg_debug11_s cn56xx;
+	struct cvmx_rad_reg_debug11_s cn56xxp1;
+} cvmx_rad_reg_debug11_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_rad_reg_debug12_s {
+		uint64_t reserved_15_63:49;
+		uint64_t asserts:15;
+	} s;
+	struct cvmx_rad_reg_debug12_s cn52xx;
+	struct cvmx_rad_reg_debug12_s cn52xxp1;
+	struct cvmx_rad_reg_debug12_s cn56xx;
+	struct cvmx_rad_reg_debug12_s cn56xxp1;
+} cvmx_rad_reg_debug12_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_rad_reg_debug2_s {
+		uint64_t owordp:64;
+	} s;
+	struct cvmx_rad_reg_debug2_s cn52xx;
+	struct cvmx_rad_reg_debug2_s cn52xxp1;
+	struct cvmx_rad_reg_debug2_s cn56xx;
+	struct cvmx_rad_reg_debug2_s cn56xxp1;
+} cvmx_rad_reg_debug2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_rad_reg_debug3_s {
+		uint64_t owordq:64;
+	} s;
+	struct cvmx_rad_reg_debug3_s cn52xx;
+	struct cvmx_rad_reg_debug3_s cn52xxp1;
+	struct cvmx_rad_reg_debug3_s cn56xx;
+	struct cvmx_rad_reg_debug3_s cn56xxp1;
+} cvmx_rad_reg_debug3_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_rad_reg_debug4_s {
+		uint64_t rword:64;
+	} s;
+	struct cvmx_rad_reg_debug4_s cn52xx;
+	struct cvmx_rad_reg_debug4_s cn52xxp1;
+	struct cvmx_rad_reg_debug4_s cn56xx;
+	struct cvmx_rad_reg_debug4_s cn56xxp1;
+} cvmx_rad_reg_debug4_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_rad_reg_debug5_s {
+		uint64_t reserved_53_63:11;
+		uint64_t niropc7:3;
+		uint64_t nirque7:2;
+		uint64_t nirval7:5;
+		uint64_t niropc6:3;
+		uint64_t nirque6:2;
+		uint64_t nirarb6:1;
+		uint64_t nirval6:5;
+		uint64_t niridx1:4;
+		uint64_t niwidx1:4;
+		uint64_t niridx0:4;
+		uint64_t niwidx0:4;
+		uint64_t wccreds:2;
+		uint64_t fpacreds:2;
+		uint64_t reserved_10_11:2;
+		uint64_t powcreds:2;
+		uint64_t n1creds:4;
+		uint64_t n0creds:4;
+	} s;
+	struct cvmx_rad_reg_debug5_s cn52xx;
+	struct cvmx_rad_reg_debug5_s cn52xxp1;
+	struct cvmx_rad_reg_debug5_s cn56xx;
+	struct cvmx_rad_reg_debug5_s cn56xxp1;
+} cvmx_rad_reg_debug5_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_rad_reg_debug6_s {
+		uint64_t cnt:8;
+		uint64_t size:16;
+		uint64_t ptr:40;
+	} s;
+	struct cvmx_rad_reg_debug6_s cn52xx;
+	struct cvmx_rad_reg_debug6_s cn52xxp1;
+	struct cvmx_rad_reg_debug6_s cn56xx;
+	struct cvmx_rad_reg_debug6_s cn56xxp1;
+} cvmx_rad_reg_debug6_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_rad_reg_debug7_s {
+		uint64_t reserved_15_63:49;
+		uint64_t cnt:15;
+	} s;
+	struct cvmx_rad_reg_debug7_s cn52xx;
+	struct cvmx_rad_reg_debug7_s cn52xxp1;
+	struct cvmx_rad_reg_debug7_s cn56xx;
+	struct cvmx_rad_reg_debug7_s cn56xxp1;
+} cvmx_rad_reg_debug7_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_rad_reg_debug8_s {
+		uint64_t flags:8;
+		uint64_t size:16;
+		uint64_t ptr:40;
+	} s;
+	struct cvmx_rad_reg_debug8_s cn52xx;
+	struct cvmx_rad_reg_debug8_s cn52xxp1;
+	struct cvmx_rad_reg_debug8_s cn56xx;
+	struct cvmx_rad_reg_debug8_s cn56xxp1;
+} cvmx_rad_reg_debug8_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_rad_reg_debug9_s {
+		uint64_t reserved_20_63:44;
+		uint64_t eod:1;
+		uint64_t ini:1;
+		uint64_t q:1;
+		uint64_t p:1;
+		uint64_t mul:8;
+		uint64_t index:8;
+	} s;
+	struct cvmx_rad_reg_debug9_s cn52xx;
+	struct cvmx_rad_reg_debug9_s cn52xxp1;
+	struct cvmx_rad_reg_debug9_s cn56xx;
+	struct cvmx_rad_reg_debug9_s cn56xxp1;
+} cvmx_rad_reg_debug9_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_rad_reg_error_s {
+		uint64_t reserved_1_63:63;
+		uint64_t doorbell:1;
+	} s;
+	struct cvmx_rad_reg_error_s cn52xx;
+	struct cvmx_rad_reg_error_s cn52xxp1;
+	struct cvmx_rad_reg_error_s cn56xx;
+	struct cvmx_rad_reg_error_s cn56xxp1;
+} cvmx_rad_reg_error_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_rad_reg_int_mask_s {
+		uint64_t reserved_1_63:63;
+		uint64_t doorbell:1;
+	} s;
+	struct cvmx_rad_reg_int_mask_s cn52xx;
+	struct cvmx_rad_reg_int_mask_s cn52xxp1;
+	struct cvmx_rad_reg_int_mask_s cn56xx;
+	struct cvmx_rad_reg_int_mask_s cn56xxp1;
+} cvmx_rad_reg_int_mask_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_rad_reg_polynomial_s {
+		uint64_t reserved_8_63:56;
+		uint64_t coeffs:8;
+	} s;
+	struct cvmx_rad_reg_polynomial_s cn52xx;
+	struct cvmx_rad_reg_polynomial_s cn52xxp1;
+	struct cvmx_rad_reg_polynomial_s cn56xx;
+	struct cvmx_rad_reg_polynomial_s cn56xxp1;
+} cvmx_rad_reg_polynomial_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_rad_reg_read_idx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t inc:16;
+		uint64_t index:16;
+	} s;
+	struct cvmx_rad_reg_read_idx_s cn52xx;
+	struct cvmx_rad_reg_read_idx_s cn52xxp1;
+	struct cvmx_rad_reg_read_idx_s cn56xx;
+	struct cvmx_rad_reg_read_idx_s cn56xxp1;
+} cvmx_rad_reg_read_idx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_rnm_bist_status_s {
+		uint64_t reserved_2_63:62;
+		uint64_t rrc:1;
+		uint64_t mem:1;
+	} s;
+	struct cvmx_rnm_bist_status_s cn30xx;
+	struct cvmx_rnm_bist_status_s cn31xx;
+	struct cvmx_rnm_bist_status_s cn38xx;
+	struct cvmx_rnm_bist_status_s cn38xxp2;
+	struct cvmx_rnm_bist_status_s cn50xx;
+	struct cvmx_rnm_bist_status_s cn52xx;
+	struct cvmx_rnm_bist_status_s cn52xxp1;
+	struct cvmx_rnm_bist_status_s cn56xx;
+	struct cvmx_rnm_bist_status_s cn56xxp1;
+	struct cvmx_rnm_bist_status_s cn58xx;
+	struct cvmx_rnm_bist_status_s cn58xxp1;
+} cvmx_rnm_bist_status_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_rnm_ctl_status_s {
+		uint64_t reserved_9_63:55;
+		uint64_t ent_sel:4;
+		uint64_t exp_ent:1;
+		uint64_t rng_rst:1;
+		uint64_t rnm_rst:1;
+		uint64_t rng_en:1;
+		uint64_t ent_en:1;
+	} s;
+	struct cvmx_rnm_ctl_status_cn30xx {
+		uint64_t reserved_4_63:60;
+		uint64_t rng_rst:1;
+		uint64_t rnm_rst:1;
+		uint64_t rng_en:1;
+		uint64_t ent_en:1;
+	} cn30xx;
+	struct cvmx_rnm_ctl_status_cn30xx cn31xx;
+	struct cvmx_rnm_ctl_status_cn30xx cn38xx;
+	struct cvmx_rnm_ctl_status_cn30xx cn38xxp2;
+	struct cvmx_rnm_ctl_status_s cn50xx;
+	struct cvmx_rnm_ctl_status_s cn52xx;
+	struct cvmx_rnm_ctl_status_s cn52xxp1;
+	struct cvmx_rnm_ctl_status_s cn56xx;
+	struct cvmx_rnm_ctl_status_s cn56xxp1;
+	struct cvmx_rnm_ctl_status_s cn58xx;
+	struct cvmx_rnm_ctl_status_s cn58xxp1;
+} cvmx_rnm_ctl_status_t;
+
+typedef union {
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
+} cvmx_smix_clk_t;
+
+typedef union {
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
+} cvmx_smix_cmd_t;
+
+typedef union {
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
+} cvmx_smix_en_t;
+
+typedef union {
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
+} cvmx_smix_rd_dat_t;
+
+typedef union {
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
+} cvmx_smix_wr_dat_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_spxx_bckprs_cnt_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_spxx_bckprs_cnt_s cn38xx;
+	struct cvmx_spxx_bckprs_cnt_s cn38xxp2;
+	struct cvmx_spxx_bckprs_cnt_s cn58xx;
+	struct cvmx_spxx_bckprs_cnt_s cn58xxp1;
+} cvmx_spxx_bckprs_cnt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_spxx_bist_stat_s {
+		uint64_t reserved_3_63:61;
+		uint64_t stat2:1;
+		uint64_t stat1:1;
+		uint64_t stat0:1;
+	} s;
+	struct cvmx_spxx_bist_stat_s cn38xx;
+	struct cvmx_spxx_bist_stat_s cn38xxp2;
+	struct cvmx_spxx_bist_stat_s cn58xx;
+	struct cvmx_spxx_bist_stat_s cn58xxp1;
+} cvmx_spxx_bist_stat_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_spxx_clk_ctl_s {
+		uint64_t reserved_17_63:47;
+		uint64_t seetrn:1;
+		uint64_t reserved_12_15:4;
+		uint64_t clkdly:5;
+		uint64_t runbist:1;
+		uint64_t statdrv:1;
+		uint64_t statrcv:1;
+		uint64_t sndtrn:1;
+		uint64_t drptrn:1;
+		uint64_t rcvtrn:1;
+		uint64_t srxdlck:1;
+	} s;
+	struct cvmx_spxx_clk_ctl_s cn38xx;
+	struct cvmx_spxx_clk_ctl_s cn38xxp2;
+	struct cvmx_spxx_clk_ctl_s cn58xx;
+	struct cvmx_spxx_clk_ctl_s cn58xxp1;
+} cvmx_spxx_clk_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_spxx_clk_stat_s {
+		uint64_t reserved_11_63:53;
+		uint64_t stxcal:1;
+		uint64_t reserved_9_9:1;
+		uint64_t srxtrn:1;
+		uint64_t s4clk1:1;
+		uint64_t s4clk0:1;
+		uint64_t d4clk1:1;
+		uint64_t d4clk0:1;
+		uint64_t reserved_0_3:4;
+	} s;
+	struct cvmx_spxx_clk_stat_s cn38xx;
+	struct cvmx_spxx_clk_stat_s cn38xxp2;
+	struct cvmx_spxx_clk_stat_s cn58xx;
+	struct cvmx_spxx_clk_stat_s cn58xxp1;
+} cvmx_spxx_clk_stat_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_spxx_dbg_deskew_ctl_s {
+		uint64_t reserved_30_63:34;
+		uint64_t fallnop:1;
+		uint64_t fall8:1;
+		uint64_t reserved_26_27:2;
+		uint64_t sstep_go:1;
+		uint64_t sstep:1;
+		uint64_t reserved_22_23:2;
+		uint64_t clrdly:1;
+		uint64_t dec:1;
+		uint64_t inc:1;
+		uint64_t mux:1;
+		uint64_t offset:5;
+		uint64_t bitsel:5;
+		uint64_t offdly:6;
+		uint64_t dllfrc:1;
+		uint64_t dlldis:1;
+	} s;
+	struct cvmx_spxx_dbg_deskew_ctl_s cn38xx;
+	struct cvmx_spxx_dbg_deskew_ctl_s cn38xxp2;
+	struct cvmx_spxx_dbg_deskew_ctl_s cn58xx;
+	struct cvmx_spxx_dbg_deskew_ctl_s cn58xxp1;
+} cvmx_spxx_dbg_deskew_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_spxx_dbg_deskew_state_s {
+		uint64_t reserved_9_63:55;
+		uint64_t testres:1;
+		uint64_t unxterm:1;
+		uint64_t muxsel:2;
+		uint64_t offset:5;
+	} s;
+	struct cvmx_spxx_dbg_deskew_state_s cn38xx;
+	struct cvmx_spxx_dbg_deskew_state_s cn38xxp2;
+	struct cvmx_spxx_dbg_deskew_state_s cn58xx;
+	struct cvmx_spxx_dbg_deskew_state_s cn58xxp1;
+} cvmx_spxx_dbg_deskew_state_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_spxx_drv_ctl_s {
+		uint64_t reserved_0_63:64;
+	} s;
+	struct cvmx_spxx_drv_ctl_cn38xx {
+		uint64_t reserved_16_63:48;
+		uint64_t stx4ncmp:4;
+		uint64_t stx4pcmp:4;
+		uint64_t srx4cmp:8;
+	} cn38xx;
+	struct cvmx_spxx_drv_ctl_cn38xx cn38xxp2;
+	struct cvmx_spxx_drv_ctl_cn58xx {
+		uint64_t reserved_24_63:40;
+		uint64_t stx4ncmp:4;
+		uint64_t stx4pcmp:4;
+		uint64_t reserved_10_15:6;
+		uint64_t srx4cmp:10;
+	} cn58xx;
+	struct cvmx_spxx_drv_ctl_cn58xx cn58xxp1;
+} cvmx_spxx_drv_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_spxx_err_ctl_s {
+		uint64_t reserved_9_63:55;
+		uint64_t prtnxa:1;
+		uint64_t dipcls:1;
+		uint64_t dippay:1;
+		uint64_t reserved_4_5:2;
+		uint64_t errcnt:4;
+	} s;
+	struct cvmx_spxx_err_ctl_s cn38xx;
+	struct cvmx_spxx_err_ctl_s cn38xxp2;
+	struct cvmx_spxx_err_ctl_s cn58xx;
+	struct cvmx_spxx_err_ctl_s cn58xxp1;
+} cvmx_spxx_err_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_spxx_int_dat_s {
+		uint64_t reserved_32_63:32;
+		uint64_t mul:1;
+		uint64_t reserved_14_30:17;
+		uint64_t calbnk:2;
+		uint64_t rsvop:4;
+		uint64_t prt:8;
+	} s;
+	struct cvmx_spxx_int_dat_s cn38xx;
+	struct cvmx_spxx_int_dat_s cn38xxp2;
+	struct cvmx_spxx_int_dat_s cn58xx;
+	struct cvmx_spxx_int_dat_s cn58xxp1;
+} cvmx_spxx_int_dat_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_spxx_int_msk_s {
+		uint64_t reserved_12_63:52;
+		uint64_t calerr:1;
+		uint64_t syncerr:1;
+		uint64_t diperr:1;
+		uint64_t tpaovr:1;
+		uint64_t rsverr:1;
+		uint64_t drwnng:1;
+		uint64_t clserr:1;
+		uint64_t spiovr:1;
+		uint64_t reserved_2_3:2;
+		uint64_t abnorm:1;
+		uint64_t prtnxa:1;
+	} s;
+	struct cvmx_spxx_int_msk_s cn38xx;
+	struct cvmx_spxx_int_msk_s cn38xxp2;
+	struct cvmx_spxx_int_msk_s cn58xx;
+	struct cvmx_spxx_int_msk_s cn58xxp1;
+} cvmx_spxx_int_msk_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_spxx_int_reg_s {
+		uint64_t reserved_32_63:32;
+		uint64_t spf:1;
+		uint64_t reserved_12_30:19;
+		uint64_t calerr:1;
+		uint64_t syncerr:1;
+		uint64_t diperr:1;
+		uint64_t tpaovr:1;
+		uint64_t rsverr:1;
+		uint64_t drwnng:1;
+		uint64_t clserr:1;
+		uint64_t spiovr:1;
+		uint64_t reserved_2_3:2;
+		uint64_t abnorm:1;
+		uint64_t prtnxa:1;
+	} s;
+	struct cvmx_spxx_int_reg_s cn38xx;
+	struct cvmx_spxx_int_reg_s cn38xxp2;
+	struct cvmx_spxx_int_reg_s cn58xx;
+	struct cvmx_spxx_int_reg_s cn58xxp1;
+} cvmx_spxx_int_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_spxx_int_sync_s {
+		uint64_t reserved_12_63:52;
+		uint64_t calerr:1;
+		uint64_t syncerr:1;
+		uint64_t diperr:1;
+		uint64_t tpaovr:1;
+		uint64_t rsverr:1;
+		uint64_t drwnng:1;
+		uint64_t clserr:1;
+		uint64_t spiovr:1;
+		uint64_t reserved_2_3:2;
+		uint64_t abnorm:1;
+		uint64_t prtnxa:1;
+	} s;
+	struct cvmx_spxx_int_sync_s cn38xx;
+	struct cvmx_spxx_int_sync_s cn38xxp2;
+	struct cvmx_spxx_int_sync_s cn58xx;
+	struct cvmx_spxx_int_sync_s cn58xxp1;
+} cvmx_spxx_int_sync_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_spxx_tpa_acc_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_spxx_tpa_acc_s cn38xx;
+	struct cvmx_spxx_tpa_acc_s cn38xxp2;
+	struct cvmx_spxx_tpa_acc_s cn58xx;
+	struct cvmx_spxx_tpa_acc_s cn58xxp1;
+} cvmx_spxx_tpa_acc_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_spxx_tpa_max_s {
+		uint64_t reserved_32_63:32;
+		uint64_t max:32;
+	} s;
+	struct cvmx_spxx_tpa_max_s cn38xx;
+	struct cvmx_spxx_tpa_max_s cn38xxp2;
+	struct cvmx_spxx_tpa_max_s cn58xx;
+	struct cvmx_spxx_tpa_max_s cn58xxp1;
+} cvmx_spxx_tpa_max_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_spxx_tpa_sel_s {
+		uint64_t reserved_4_63:60;
+		uint64_t prtsel:4;
+	} s;
+	struct cvmx_spxx_tpa_sel_s cn38xx;
+	struct cvmx_spxx_tpa_sel_s cn38xxp2;
+	struct cvmx_spxx_tpa_sel_s cn58xx;
+	struct cvmx_spxx_tpa_sel_s cn58xxp1;
+} cvmx_spxx_tpa_sel_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_spxx_trn4_ctl_s {
+		uint64_t reserved_13_63:51;
+		uint64_t trntest:1;
+		uint64_t jitter:3;
+		uint64_t clr_boot:1;
+		uint64_t set_boot:1;
+		uint64_t maxdist:5;
+		uint64_t macro_en:1;
+		uint64_t mux_en:1;
+	} s;
+	struct cvmx_spxx_trn4_ctl_s cn38xx;
+	struct cvmx_spxx_trn4_ctl_s cn38xxp2;
+	struct cvmx_spxx_trn4_ctl_s cn58xx;
+	struct cvmx_spxx_trn4_ctl_s cn58xxp1;
+} cvmx_spxx_trn4_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_spx0_pll_bw_ctl_s {
+		uint64_t reserved_5_63:59;
+		uint64_t bw_ctl:5;
+	} s;
+	struct cvmx_spx0_pll_bw_ctl_s cn38xx;
+	struct cvmx_spx0_pll_bw_ctl_s cn38xxp2;
+} cvmx_spx0_pll_bw_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_spx0_pll_setting_s {
+		uint64_t reserved_17_63:47;
+		uint64_t setting:17;
+	} s;
+	struct cvmx_spx0_pll_setting_s cn38xx;
+	struct cvmx_spx0_pll_setting_s cn38xxp2;
+} cvmx_spx0_pll_setting_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_srxx_com_ctl_s {
+		uint64_t reserved_8_63:56;
+		uint64_t prts:4;
+		uint64_t st_en:1;
+		uint64_t reserved_1_2:2;
+		uint64_t inf_en:1;
+	} s;
+	struct cvmx_srxx_com_ctl_s cn38xx;
+	struct cvmx_srxx_com_ctl_s cn38xxp2;
+	struct cvmx_srxx_com_ctl_s cn58xx;
+	struct cvmx_srxx_com_ctl_s cn58xxp1;
+} cvmx_srxx_com_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_srxx_ign_rx_full_s {
+		uint64_t reserved_16_63:48;
+		uint64_t ignore:16;
+	} s;
+	struct cvmx_srxx_ign_rx_full_s cn38xx;
+	struct cvmx_srxx_ign_rx_full_s cn38xxp2;
+	struct cvmx_srxx_ign_rx_full_s cn58xx;
+	struct cvmx_srxx_ign_rx_full_s cn58xxp1;
+} cvmx_srxx_ign_rx_full_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_srxx_spi4_calx_s {
+		uint64_t reserved_17_63:47;
+		uint64_t oddpar:1;
+		uint64_t prt3:4;
+		uint64_t prt2:4;
+		uint64_t prt1:4;
+		uint64_t prt0:4;
+	} s;
+	struct cvmx_srxx_spi4_calx_s cn38xx;
+	struct cvmx_srxx_spi4_calx_s cn38xxp2;
+	struct cvmx_srxx_spi4_calx_s cn58xx;
+	struct cvmx_srxx_spi4_calx_s cn58xxp1;
+} cvmx_srxx_spi4_calx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_srxx_spi4_stat_s {
+		uint64_t reserved_16_63:48;
+		uint64_t m:8;
+		uint64_t reserved_7_7:1;
+		uint64_t len:7;
+	} s;
+	struct cvmx_srxx_spi4_stat_s cn38xx;
+	struct cvmx_srxx_spi4_stat_s cn38xxp2;
+	struct cvmx_srxx_spi4_stat_s cn58xx;
+	struct cvmx_srxx_spi4_stat_s cn58xxp1;
+} cvmx_srxx_spi4_stat_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_srxx_sw_tick_ctl_s {
+		uint64_t reserved_14_63:50;
+		uint64_t eop:1;
+		uint64_t sop:1;
+		uint64_t mod:4;
+		uint64_t opc:4;
+		uint64_t adr:4;
+	} s;
+	struct cvmx_srxx_sw_tick_ctl_s cn38xx;
+	struct cvmx_srxx_sw_tick_ctl_s cn58xx;
+	struct cvmx_srxx_sw_tick_ctl_s cn58xxp1;
+} cvmx_srxx_sw_tick_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_srxx_sw_tick_dat_s {
+		uint64_t dat:64;
+	} s;
+	struct cvmx_srxx_sw_tick_dat_s cn38xx;
+	struct cvmx_srxx_sw_tick_dat_s cn58xx;
+	struct cvmx_srxx_sw_tick_dat_s cn58xxp1;
+} cvmx_srxx_sw_tick_dat_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_stxx_arb_ctl_s {
+		uint64_t reserved_6_63:58;
+		uint64_t mintrn:1;
+		uint64_t reserved_4_4:1;
+		uint64_t igntpa:1;
+		uint64_t reserved_0_2:3;
+	} s;
+	struct cvmx_stxx_arb_ctl_s cn38xx;
+	struct cvmx_stxx_arb_ctl_s cn38xxp2;
+	struct cvmx_stxx_arb_ctl_s cn58xx;
+	struct cvmx_stxx_arb_ctl_s cn58xxp1;
+} cvmx_stxx_arb_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_stxx_bckprs_cnt_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_stxx_bckprs_cnt_s cn38xx;
+	struct cvmx_stxx_bckprs_cnt_s cn38xxp2;
+	struct cvmx_stxx_bckprs_cnt_s cn58xx;
+	struct cvmx_stxx_bckprs_cnt_s cn58xxp1;
+} cvmx_stxx_bckprs_cnt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_stxx_com_ctl_s {
+		uint64_t reserved_4_63:60;
+		uint64_t st_en:1;
+		uint64_t reserved_1_2:2;
+		uint64_t inf_en:1;
+	} s;
+	struct cvmx_stxx_com_ctl_s cn38xx;
+	struct cvmx_stxx_com_ctl_s cn38xxp2;
+	struct cvmx_stxx_com_ctl_s cn58xx;
+	struct cvmx_stxx_com_ctl_s cn58xxp1;
+} cvmx_stxx_com_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_stxx_dip_cnt_s {
+		uint64_t reserved_8_63:56;
+		uint64_t frmmax:4;
+		uint64_t dipmax:4;
+	} s;
+	struct cvmx_stxx_dip_cnt_s cn38xx;
+	struct cvmx_stxx_dip_cnt_s cn38xxp2;
+	struct cvmx_stxx_dip_cnt_s cn58xx;
+	struct cvmx_stxx_dip_cnt_s cn58xxp1;
+} cvmx_stxx_dip_cnt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_stxx_ign_cal_s {
+		uint64_t reserved_16_63:48;
+		uint64_t igntpa:16;
+	} s;
+	struct cvmx_stxx_ign_cal_s cn38xx;
+	struct cvmx_stxx_ign_cal_s cn38xxp2;
+	struct cvmx_stxx_ign_cal_s cn58xx;
+	struct cvmx_stxx_ign_cal_s cn58xxp1;
+} cvmx_stxx_ign_cal_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_stxx_int_msk_s {
+		uint64_t reserved_8_63:56;
+		uint64_t frmerr:1;
+		uint64_t unxfrm:1;
+		uint64_t nosync:1;
+		uint64_t diperr:1;
+		uint64_t datovr:1;
+		uint64_t ovrbst:1;
+		uint64_t calpar1:1;
+		uint64_t calpar0:1;
+	} s;
+	struct cvmx_stxx_int_msk_s cn38xx;
+	struct cvmx_stxx_int_msk_s cn38xxp2;
+	struct cvmx_stxx_int_msk_s cn58xx;
+	struct cvmx_stxx_int_msk_s cn58xxp1;
+} cvmx_stxx_int_msk_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_stxx_int_reg_s {
+		uint64_t reserved_9_63:55;
+		uint64_t syncerr:1;
+		uint64_t frmerr:1;
+		uint64_t unxfrm:1;
+		uint64_t nosync:1;
+		uint64_t diperr:1;
+		uint64_t datovr:1;
+		uint64_t ovrbst:1;
+		uint64_t calpar1:1;
+		uint64_t calpar0:1;
+	} s;
+	struct cvmx_stxx_int_reg_s cn38xx;
+	struct cvmx_stxx_int_reg_s cn38xxp2;
+	struct cvmx_stxx_int_reg_s cn58xx;
+	struct cvmx_stxx_int_reg_s cn58xxp1;
+} cvmx_stxx_int_reg_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_stxx_int_sync_s {
+		uint64_t reserved_8_63:56;
+		uint64_t frmerr:1;
+		uint64_t unxfrm:1;
+		uint64_t nosync:1;
+		uint64_t diperr:1;
+		uint64_t datovr:1;
+		uint64_t ovrbst:1;
+		uint64_t calpar1:1;
+		uint64_t calpar0:1;
+	} s;
+	struct cvmx_stxx_int_sync_s cn38xx;
+	struct cvmx_stxx_int_sync_s cn38xxp2;
+	struct cvmx_stxx_int_sync_s cn58xx;
+	struct cvmx_stxx_int_sync_s cn58xxp1;
+} cvmx_stxx_int_sync_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_stxx_min_bst_s {
+		uint64_t reserved_9_63:55;
+		uint64_t minb:9;
+	} s;
+	struct cvmx_stxx_min_bst_s cn38xx;
+	struct cvmx_stxx_min_bst_s cn38xxp2;
+	struct cvmx_stxx_min_bst_s cn58xx;
+	struct cvmx_stxx_min_bst_s cn58xxp1;
+} cvmx_stxx_min_bst_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_stxx_spi4_calx_s {
+		uint64_t reserved_17_63:47;
+		uint64_t oddpar:1;
+		uint64_t prt3:4;
+		uint64_t prt2:4;
+		uint64_t prt1:4;
+		uint64_t prt0:4;
+	} s;
+	struct cvmx_stxx_spi4_calx_s cn38xx;
+	struct cvmx_stxx_spi4_calx_s cn38xxp2;
+	struct cvmx_stxx_spi4_calx_s cn58xx;
+	struct cvmx_stxx_spi4_calx_s cn58xxp1;
+} cvmx_stxx_spi4_calx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_stxx_spi4_dat_s {
+		uint64_t reserved_32_63:32;
+		uint64_t alpha:16;
+		uint64_t max_t:16;
+	} s;
+	struct cvmx_stxx_spi4_dat_s cn38xx;
+	struct cvmx_stxx_spi4_dat_s cn38xxp2;
+	struct cvmx_stxx_spi4_dat_s cn58xx;
+	struct cvmx_stxx_spi4_dat_s cn58xxp1;
+} cvmx_stxx_spi4_dat_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_stxx_spi4_stat_s {
+		uint64_t reserved_16_63:48;
+		uint64_t m:8;
+		uint64_t reserved_7_7:1;
+		uint64_t len:7;
+	} s;
+	struct cvmx_stxx_spi4_stat_s cn38xx;
+	struct cvmx_stxx_spi4_stat_s cn38xxp2;
+	struct cvmx_stxx_spi4_stat_s cn58xx;
+	struct cvmx_stxx_spi4_stat_s cn58xxp1;
+} cvmx_stxx_spi4_stat_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_stxx_stat_bytes_hi_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_stxx_stat_bytes_hi_s cn38xx;
+	struct cvmx_stxx_stat_bytes_hi_s cn38xxp2;
+	struct cvmx_stxx_stat_bytes_hi_s cn58xx;
+	struct cvmx_stxx_stat_bytes_hi_s cn58xxp1;
+} cvmx_stxx_stat_bytes_hi_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_stxx_stat_bytes_lo_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_stxx_stat_bytes_lo_s cn38xx;
+	struct cvmx_stxx_stat_bytes_lo_s cn38xxp2;
+	struct cvmx_stxx_stat_bytes_lo_s cn58xx;
+	struct cvmx_stxx_stat_bytes_lo_s cn58xxp1;
+} cvmx_stxx_stat_bytes_lo_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_stxx_stat_ctl_s {
+		uint64_t reserved_5_63:59;
+		uint64_t clr:1;
+		uint64_t bckprs:4;
+	} s;
+	struct cvmx_stxx_stat_ctl_s cn38xx;
+	struct cvmx_stxx_stat_ctl_s cn38xxp2;
+	struct cvmx_stxx_stat_ctl_s cn58xx;
+	struct cvmx_stxx_stat_ctl_s cn58xxp1;
+} cvmx_stxx_stat_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_stxx_stat_pkt_xmt_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_stxx_stat_pkt_xmt_s cn38xx;
+	struct cvmx_stxx_stat_pkt_xmt_s cn38xxp2;
+	struct cvmx_stxx_stat_pkt_xmt_s cn58xx;
+	struct cvmx_stxx_stat_pkt_xmt_s cn58xxp1;
+} cvmx_stxx_stat_pkt_xmt_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tim_mem_debug0_s {
+		uint64_t reserved_48_63:16;
+		uint64_t ena:1;
+		uint64_t reserved_46_46:1;
+		uint64_t count:22;
+		uint64_t reserved_22_23:2;
+		uint64_t interval:22;
+	} s;
+	struct cvmx_tim_mem_debug0_s cn30xx;
+	struct cvmx_tim_mem_debug0_s cn31xx;
+	struct cvmx_tim_mem_debug0_s cn38xx;
+	struct cvmx_tim_mem_debug0_s cn38xxp2;
+	struct cvmx_tim_mem_debug0_s cn50xx;
+	struct cvmx_tim_mem_debug0_s cn52xx;
+	struct cvmx_tim_mem_debug0_s cn52xxp1;
+	struct cvmx_tim_mem_debug0_s cn56xx;
+	struct cvmx_tim_mem_debug0_s cn56xxp1;
+	struct cvmx_tim_mem_debug0_s cn58xx;
+	struct cvmx_tim_mem_debug0_s cn58xxp1;
+} cvmx_tim_mem_debug0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tim_mem_debug1_s {
+		uint64_t bucket:13;
+		uint64_t base:31;
+		uint64_t bsize:20;
+	} s;
+	struct cvmx_tim_mem_debug1_s cn30xx;
+	struct cvmx_tim_mem_debug1_s cn31xx;
+	struct cvmx_tim_mem_debug1_s cn38xx;
+	struct cvmx_tim_mem_debug1_s cn38xxp2;
+	struct cvmx_tim_mem_debug1_s cn50xx;
+	struct cvmx_tim_mem_debug1_s cn52xx;
+	struct cvmx_tim_mem_debug1_s cn52xxp1;
+	struct cvmx_tim_mem_debug1_s cn56xx;
+	struct cvmx_tim_mem_debug1_s cn56xxp1;
+	struct cvmx_tim_mem_debug1_s cn58xx;
+	struct cvmx_tim_mem_debug1_s cn58xxp1;
+} cvmx_tim_mem_debug1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tim_mem_debug2_s {
+		uint64_t reserved_24_63:40;
+		uint64_t cpool:3;
+		uint64_t csize:13;
+		uint64_t reserved_7_7:1;
+		uint64_t bucket:7;
+	} s;
+	struct cvmx_tim_mem_debug2_s cn30xx;
+	struct cvmx_tim_mem_debug2_s cn31xx;
+	struct cvmx_tim_mem_debug2_s cn38xx;
+	struct cvmx_tim_mem_debug2_s cn38xxp2;
+	struct cvmx_tim_mem_debug2_s cn50xx;
+	struct cvmx_tim_mem_debug2_s cn52xx;
+	struct cvmx_tim_mem_debug2_s cn52xxp1;
+	struct cvmx_tim_mem_debug2_s cn56xx;
+	struct cvmx_tim_mem_debug2_s cn56xxp1;
+	struct cvmx_tim_mem_debug2_s cn58xx;
+	struct cvmx_tim_mem_debug2_s cn58xxp1;
+} cvmx_tim_mem_debug2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tim_mem_ring0_s {
+		uint64_t reserved_55_63:9;
+		uint64_t first_bucket:31;
+		uint64_t num_buckets:20;
+		uint64_t ring:4;
+	} s;
+	struct cvmx_tim_mem_ring0_s cn30xx;
+	struct cvmx_tim_mem_ring0_s cn31xx;
+	struct cvmx_tim_mem_ring0_s cn38xx;
+	struct cvmx_tim_mem_ring0_s cn38xxp2;
+	struct cvmx_tim_mem_ring0_s cn50xx;
+	struct cvmx_tim_mem_ring0_s cn52xx;
+	struct cvmx_tim_mem_ring0_s cn52xxp1;
+	struct cvmx_tim_mem_ring0_s cn56xx;
+	struct cvmx_tim_mem_ring0_s cn56xxp1;
+	struct cvmx_tim_mem_ring0_s cn58xx;
+	struct cvmx_tim_mem_ring0_s cn58xxp1;
+} cvmx_tim_mem_ring0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tim_mem_ring1_s {
+		uint64_t reserved_43_63:21;
+		uint64_t enable:1;
+		uint64_t pool:3;
+		uint64_t words_per_chunk:13;
+		uint64_t interval:22;
+		uint64_t ring:4;
+	} s;
+	struct cvmx_tim_mem_ring1_s cn30xx;
+	struct cvmx_tim_mem_ring1_s cn31xx;
+	struct cvmx_tim_mem_ring1_s cn38xx;
+	struct cvmx_tim_mem_ring1_s cn38xxp2;
+	struct cvmx_tim_mem_ring1_s cn50xx;
+	struct cvmx_tim_mem_ring1_s cn52xx;
+	struct cvmx_tim_mem_ring1_s cn52xxp1;
+	struct cvmx_tim_mem_ring1_s cn56xx;
+	struct cvmx_tim_mem_ring1_s cn56xxp1;
+	struct cvmx_tim_mem_ring1_s cn58xx;
+	struct cvmx_tim_mem_ring1_s cn58xxp1;
+} cvmx_tim_mem_ring1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tim_reg_bist_result_s {
+		uint64_t reserved_4_63:60;
+		uint64_t sta:2;
+		uint64_t ncb:1;
+		uint64_t ctl:1;
+	} s;
+	struct cvmx_tim_reg_bist_result_s cn30xx;
+	struct cvmx_tim_reg_bist_result_s cn31xx;
+	struct cvmx_tim_reg_bist_result_s cn38xx;
+	struct cvmx_tim_reg_bist_result_s cn38xxp2;
+	struct cvmx_tim_reg_bist_result_s cn50xx;
+	struct cvmx_tim_reg_bist_result_s cn52xx;
+	struct cvmx_tim_reg_bist_result_s cn52xxp1;
+	struct cvmx_tim_reg_bist_result_s cn56xx;
+	struct cvmx_tim_reg_bist_result_s cn56xxp1;
+	struct cvmx_tim_reg_bist_result_s cn58xx;
+	struct cvmx_tim_reg_bist_result_s cn58xxp1;
+} cvmx_tim_reg_bist_result_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tim_reg_error_s {
+		uint64_t reserved_16_63:48;
+		uint64_t mask:16;
+	} s;
+	struct cvmx_tim_reg_error_s cn30xx;
+	struct cvmx_tim_reg_error_s cn31xx;
+	struct cvmx_tim_reg_error_s cn38xx;
+	struct cvmx_tim_reg_error_s cn38xxp2;
+	struct cvmx_tim_reg_error_s cn50xx;
+	struct cvmx_tim_reg_error_s cn52xx;
+	struct cvmx_tim_reg_error_s cn52xxp1;
+	struct cvmx_tim_reg_error_s cn56xx;
+	struct cvmx_tim_reg_error_s cn56xxp1;
+	struct cvmx_tim_reg_error_s cn58xx;
+	struct cvmx_tim_reg_error_s cn58xxp1;
+} cvmx_tim_reg_error_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tim_reg_flags_s {
+		uint64_t reserved_3_63:61;
+		uint64_t reset:1;
+		uint64_t enable_dwb:1;
+		uint64_t enable_timers:1;
+	} s;
+	struct cvmx_tim_reg_flags_s cn30xx;
+	struct cvmx_tim_reg_flags_s cn31xx;
+	struct cvmx_tim_reg_flags_s cn38xx;
+	struct cvmx_tim_reg_flags_s cn38xxp2;
+	struct cvmx_tim_reg_flags_s cn50xx;
+	struct cvmx_tim_reg_flags_s cn52xx;
+	struct cvmx_tim_reg_flags_s cn52xxp1;
+	struct cvmx_tim_reg_flags_s cn56xx;
+	struct cvmx_tim_reg_flags_s cn56xxp1;
+	struct cvmx_tim_reg_flags_s cn58xx;
+	struct cvmx_tim_reg_flags_s cn58xxp1;
+} cvmx_tim_reg_flags_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tim_reg_int_mask_s {
+		uint64_t reserved_16_63:48;
+		uint64_t mask:16;
+	} s;
+	struct cvmx_tim_reg_int_mask_s cn30xx;
+	struct cvmx_tim_reg_int_mask_s cn31xx;
+	struct cvmx_tim_reg_int_mask_s cn38xx;
+	struct cvmx_tim_reg_int_mask_s cn38xxp2;
+	struct cvmx_tim_reg_int_mask_s cn50xx;
+	struct cvmx_tim_reg_int_mask_s cn52xx;
+	struct cvmx_tim_reg_int_mask_s cn52xxp1;
+	struct cvmx_tim_reg_int_mask_s cn56xx;
+	struct cvmx_tim_reg_int_mask_s cn56xxp1;
+	struct cvmx_tim_reg_int_mask_s cn58xx;
+	struct cvmx_tim_reg_int_mask_s cn58xxp1;
+} cvmx_tim_reg_int_mask_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tim_reg_read_idx_s {
+		uint64_t reserved_16_63:48;
+		uint64_t inc:8;
+		uint64_t index:8;
+	} s;
+	struct cvmx_tim_reg_read_idx_s cn30xx;
+	struct cvmx_tim_reg_read_idx_s cn31xx;
+	struct cvmx_tim_reg_read_idx_s cn38xx;
+	struct cvmx_tim_reg_read_idx_s cn38xxp2;
+	struct cvmx_tim_reg_read_idx_s cn50xx;
+	struct cvmx_tim_reg_read_idx_s cn52xx;
+	struct cvmx_tim_reg_read_idx_s cn52xxp1;
+	struct cvmx_tim_reg_read_idx_s cn56xx;
+	struct cvmx_tim_reg_read_idx_s cn56xxp1;
+	struct cvmx_tim_reg_read_idx_s cn58xx;
+	struct cvmx_tim_reg_read_idx_s cn58xxp1;
+} cvmx_tim_reg_read_idx_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tra_bist_status_s {
+		uint64_t reserved_3_63:61;
+		uint64_t tcf:1;
+		uint64_t tdf1:1;
+		uint64_t tdf0:1;
+	} s;
+	struct cvmx_tra_bist_status_s cn31xx;
+	struct cvmx_tra_bist_status_s cn38xx;
+	struct cvmx_tra_bist_status_s cn38xxp2;
+	struct cvmx_tra_bist_status_s cn52xx;
+	struct cvmx_tra_bist_status_s cn52xxp1;
+	struct cvmx_tra_bist_status_s cn56xx;
+	struct cvmx_tra_bist_status_s cn56xxp1;
+	struct cvmx_tra_bist_status_s cn58xx;
+	struct cvmx_tra_bist_status_s cn58xxp1;
+} cvmx_tra_bist_status_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tra_ctl_s {
+		uint64_t reserved_15_63:49;
+		uint64_t ignore_o:1;
+		uint64_t mcd0_ena:1;
+		uint64_t mcd0_thr:1;
+		uint64_t mcd0_trg:1;
+		uint64_t ciu_thr:1;
+		uint64_t ciu_trg:1;
+		uint64_t full_thr:2;
+		uint64_t time_grn:3;
+		uint64_t trig_ctl:2;
+		uint64_t wrap:1;
+		uint64_t ena:1;
+	} s;
+	struct cvmx_tra_ctl_s cn31xx;
+	struct cvmx_tra_ctl_s cn38xx;
+	struct cvmx_tra_ctl_s cn38xxp2;
+	struct cvmx_tra_ctl_s cn52xx;
+	struct cvmx_tra_ctl_s cn52xxp1;
+	struct cvmx_tra_ctl_s cn56xx;
+	struct cvmx_tra_ctl_s cn56xxp1;
+	struct cvmx_tra_ctl_s cn58xx;
+	struct cvmx_tra_ctl_s cn58xxp1;
+} cvmx_tra_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tra_cycles_since_s {
+		uint64_t cycles:48;
+		uint64_t rptr:8;
+		uint64_t wptr:8;
+	} s;
+	struct cvmx_tra_cycles_since_s cn31xx;
+	struct cvmx_tra_cycles_since_s cn38xx;
+	struct cvmx_tra_cycles_since_s cn38xxp2;
+	struct cvmx_tra_cycles_since_s cn52xx;
+	struct cvmx_tra_cycles_since_s cn52xxp1;
+	struct cvmx_tra_cycles_since_s cn56xx;
+	struct cvmx_tra_cycles_since_s cn56xxp1;
+	struct cvmx_tra_cycles_since_s cn58xx;
+	struct cvmx_tra_cycles_since_s cn58xxp1;
+} cvmx_tra_cycles_since_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tra_cycles_since1_s {
+		uint64_t cycles:40;
+		uint64_t reserved_22_23:2;
+		uint64_t rptr:10;
+		uint64_t reserved_10_11:2;
+		uint64_t wptr:10;
+	} s;
+	struct cvmx_tra_cycles_since1_s cn52xx;
+	struct cvmx_tra_cycles_since1_s cn52xxp1;
+	struct cvmx_tra_cycles_since1_s cn56xx;
+	struct cvmx_tra_cycles_since1_s cn56xxp1;
+	struct cvmx_tra_cycles_since1_s cn58xx;
+	struct cvmx_tra_cycles_since1_s cn58xxp1;
+} cvmx_tra_cycles_since1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tra_filt_adr_adr_s {
+		uint64_t reserved_36_63:28;
+		uint64_t adr:36;
+	} s;
+	struct cvmx_tra_filt_adr_adr_s cn31xx;
+	struct cvmx_tra_filt_adr_adr_s cn38xx;
+	struct cvmx_tra_filt_adr_adr_s cn38xxp2;
+	struct cvmx_tra_filt_adr_adr_s cn52xx;
+	struct cvmx_tra_filt_adr_adr_s cn52xxp1;
+	struct cvmx_tra_filt_adr_adr_s cn56xx;
+	struct cvmx_tra_filt_adr_adr_s cn56xxp1;
+	struct cvmx_tra_filt_adr_adr_s cn58xx;
+	struct cvmx_tra_filt_adr_adr_s cn58xxp1;
+} cvmx_tra_filt_adr_adr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tra_filt_adr_msk_s {
+		uint64_t reserved_36_63:28;
+		uint64_t adr:36;
+	} s;
+	struct cvmx_tra_filt_adr_msk_s cn31xx;
+	struct cvmx_tra_filt_adr_msk_s cn38xx;
+	struct cvmx_tra_filt_adr_msk_s cn38xxp2;
+	struct cvmx_tra_filt_adr_msk_s cn52xx;
+	struct cvmx_tra_filt_adr_msk_s cn52xxp1;
+	struct cvmx_tra_filt_adr_msk_s cn56xx;
+	struct cvmx_tra_filt_adr_msk_s cn56xxp1;
+	struct cvmx_tra_filt_adr_msk_s cn58xx;
+	struct cvmx_tra_filt_adr_msk_s cn58xxp1;
+} cvmx_tra_filt_adr_msk_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tra_filt_cmd_s {
+		uint64_t reserved_17_63:47;
+		uint64_t saa:1;
+		uint64_t iobdma:1;
+		uint64_t iobst:1;
+		uint64_t iobld64:1;
+		uint64_t iobld32:1;
+		uint64_t iobld16:1;
+		uint64_t iobld8:1;
+		uint64_t stt:1;
+		uint64_t stp:1;
+		uint64_t stc:1;
+		uint64_t stf:1;
+		uint64_t ldt:1;
+		uint64_t ldi:1;
+		uint64_t ldd:1;
+		uint64_t psl1:1;
+		uint64_t pl2:1;
+		uint64_t dwb:1;
+	} s;
+	struct cvmx_tra_filt_cmd_cn31xx {
+		uint64_t reserved_16_63:48;
+		uint64_t iobdma:1;
+		uint64_t iobst:1;
+		uint64_t iobld64:1;
+		uint64_t iobld32:1;
+		uint64_t iobld16:1;
+		uint64_t iobld8:1;
+		uint64_t stt:1;
+		uint64_t stp:1;
+		uint64_t stc:1;
+		uint64_t stf:1;
+		uint64_t ldt:1;
+		uint64_t ldi:1;
+		uint64_t ldd:1;
+		uint64_t psl1:1;
+		uint64_t pl2:1;
+		uint64_t dwb:1;
+	} cn31xx;
+	struct cvmx_tra_filt_cmd_cn31xx cn38xx;
+	struct cvmx_tra_filt_cmd_cn31xx cn38xxp2;
+	struct cvmx_tra_filt_cmd_s cn52xx;
+	struct cvmx_tra_filt_cmd_s cn52xxp1;
+	struct cvmx_tra_filt_cmd_s cn56xx;
+	struct cvmx_tra_filt_cmd_s cn56xxp1;
+	struct cvmx_tra_filt_cmd_s cn58xx;
+	struct cvmx_tra_filt_cmd_s cn58xxp1;
+} cvmx_tra_filt_cmd_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tra_filt_did_s {
+		uint64_t reserved_32_63:32;
+		uint64_t illegal:19;
+		uint64_t pow:1;
+		uint64_t illegal2:3;
+		uint64_t rng:1;
+		uint64_t zip:1;
+		uint64_t dfa:1;
+		uint64_t fpa:1;
+		uint64_t key:1;
+		uint64_t pci:1;
+		uint64_t illegal3:2;
+		uint64_t mio:1;
+	} s;
+	struct cvmx_tra_filt_did_s cn31xx;
+	struct cvmx_tra_filt_did_s cn38xx;
+	struct cvmx_tra_filt_did_s cn38xxp2;
+	struct cvmx_tra_filt_did_s cn52xx;
+	struct cvmx_tra_filt_did_s cn52xxp1;
+	struct cvmx_tra_filt_did_s cn56xx;
+	struct cvmx_tra_filt_did_s cn56xxp1;
+	struct cvmx_tra_filt_did_s cn58xx;
+	struct cvmx_tra_filt_did_s cn58xxp1;
+} cvmx_tra_filt_did_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tra_filt_sid_s {
+		uint64_t reserved_20_63:44;
+		uint64_t dwb:1;
+		uint64_t iobreq:1;
+		uint64_t pko:1;
+		uint64_t pki:1;
+		uint64_t pp:16;
+	} s;
+	struct cvmx_tra_filt_sid_s cn31xx;
+	struct cvmx_tra_filt_sid_s cn38xx;
+	struct cvmx_tra_filt_sid_s cn38xxp2;
+	struct cvmx_tra_filt_sid_s cn52xx;
+	struct cvmx_tra_filt_sid_s cn52xxp1;
+	struct cvmx_tra_filt_sid_s cn56xx;
+	struct cvmx_tra_filt_sid_s cn56xxp1;
+	struct cvmx_tra_filt_sid_s cn58xx;
+	struct cvmx_tra_filt_sid_s cn58xxp1;
+} cvmx_tra_filt_sid_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tra_int_status_s {
+		uint64_t reserved_4_63:60;
+		uint64_t mcd0_thr:1;
+		uint64_t mcd0_trg:1;
+		uint64_t ciu_thr:1;
+		uint64_t ciu_trg:1;
+	} s;
+	struct cvmx_tra_int_status_s cn31xx;
+	struct cvmx_tra_int_status_s cn38xx;
+	struct cvmx_tra_int_status_s cn38xxp2;
+	struct cvmx_tra_int_status_s cn52xx;
+	struct cvmx_tra_int_status_s cn52xxp1;
+	struct cvmx_tra_int_status_s cn56xx;
+	struct cvmx_tra_int_status_s cn56xxp1;
+	struct cvmx_tra_int_status_s cn58xx;
+	struct cvmx_tra_int_status_s cn58xxp1;
+} cvmx_tra_int_status_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tra_read_dat_s {
+		uint64_t data:64;
+	} s;
+	struct cvmx_tra_read_dat_s cn31xx;
+	struct cvmx_tra_read_dat_s cn38xx;
+	struct cvmx_tra_read_dat_s cn38xxp2;
+	struct cvmx_tra_read_dat_s cn52xx;
+	struct cvmx_tra_read_dat_s cn52xxp1;
+	struct cvmx_tra_read_dat_s cn56xx;
+	struct cvmx_tra_read_dat_s cn56xxp1;
+	struct cvmx_tra_read_dat_s cn58xx;
+	struct cvmx_tra_read_dat_s cn58xxp1;
+} cvmx_tra_read_dat_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tra_trig0_adr_adr_s {
+		uint64_t reserved_36_63:28;
+		uint64_t adr:36;
+	} s;
+	struct cvmx_tra_trig0_adr_adr_s cn31xx;
+	struct cvmx_tra_trig0_adr_adr_s cn38xx;
+	struct cvmx_tra_trig0_adr_adr_s cn38xxp2;
+	struct cvmx_tra_trig0_adr_adr_s cn52xx;
+	struct cvmx_tra_trig0_adr_adr_s cn52xxp1;
+	struct cvmx_tra_trig0_adr_adr_s cn56xx;
+	struct cvmx_tra_trig0_adr_adr_s cn56xxp1;
+	struct cvmx_tra_trig0_adr_adr_s cn58xx;
+	struct cvmx_tra_trig0_adr_adr_s cn58xxp1;
+} cvmx_tra_trig0_adr_adr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tra_trig0_adr_msk_s {
+		uint64_t reserved_36_63:28;
+		uint64_t adr:36;
+	} s;
+	struct cvmx_tra_trig0_adr_msk_s cn31xx;
+	struct cvmx_tra_trig0_adr_msk_s cn38xx;
+	struct cvmx_tra_trig0_adr_msk_s cn38xxp2;
+	struct cvmx_tra_trig0_adr_msk_s cn52xx;
+	struct cvmx_tra_trig0_adr_msk_s cn52xxp1;
+	struct cvmx_tra_trig0_adr_msk_s cn56xx;
+	struct cvmx_tra_trig0_adr_msk_s cn56xxp1;
+	struct cvmx_tra_trig0_adr_msk_s cn58xx;
+	struct cvmx_tra_trig0_adr_msk_s cn58xxp1;
+} cvmx_tra_trig0_adr_msk_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tra_trig0_cmd_s {
+		uint64_t reserved_17_63:47;
+		uint64_t saa:1;
+		uint64_t iobdma:1;
+		uint64_t iobst:1;
+		uint64_t iobld64:1;
+		uint64_t iobld32:1;
+		uint64_t iobld16:1;
+		uint64_t iobld8:1;
+		uint64_t stt:1;
+		uint64_t stp:1;
+		uint64_t stc:1;
+		uint64_t stf:1;
+		uint64_t ldt:1;
+		uint64_t ldi:1;
+		uint64_t ldd:1;
+		uint64_t psl1:1;
+		uint64_t pl2:1;
+		uint64_t dwb:1;
+	} s;
+	struct cvmx_tra_trig0_cmd_cn31xx {
+		uint64_t reserved_16_63:48;
+		uint64_t iobdma:1;
+		uint64_t iobst:1;
+		uint64_t iobld64:1;
+		uint64_t iobld32:1;
+		uint64_t iobld16:1;
+		uint64_t iobld8:1;
+		uint64_t stt:1;
+		uint64_t stp:1;
+		uint64_t stc:1;
+		uint64_t stf:1;
+		uint64_t ldt:1;
+		uint64_t ldi:1;
+		uint64_t ldd:1;
+		uint64_t psl1:1;
+		uint64_t pl2:1;
+		uint64_t dwb:1;
+	} cn31xx;
+	struct cvmx_tra_trig0_cmd_cn31xx cn38xx;
+	struct cvmx_tra_trig0_cmd_cn31xx cn38xxp2;
+	struct cvmx_tra_trig0_cmd_s cn52xx;
+	struct cvmx_tra_trig0_cmd_s cn52xxp1;
+	struct cvmx_tra_trig0_cmd_s cn56xx;
+	struct cvmx_tra_trig0_cmd_s cn56xxp1;
+	struct cvmx_tra_trig0_cmd_s cn58xx;
+	struct cvmx_tra_trig0_cmd_s cn58xxp1;
+} cvmx_tra_trig0_cmd_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tra_trig0_did_s {
+		uint64_t reserved_32_63:32;
+		uint64_t illegal:19;
+		uint64_t pow:1;
+		uint64_t illegal2:3;
+		uint64_t rng:1;
+		uint64_t zip:1;
+		uint64_t dfa:1;
+		uint64_t fpa:1;
+		uint64_t key:1;
+		uint64_t pci:1;
+		uint64_t illegal3:2;
+		uint64_t mio:1;
+	} s;
+	struct cvmx_tra_trig0_did_s cn31xx;
+	struct cvmx_tra_trig0_did_s cn38xx;
+	struct cvmx_tra_trig0_did_s cn38xxp2;
+	struct cvmx_tra_trig0_did_s cn52xx;
+	struct cvmx_tra_trig0_did_s cn52xxp1;
+	struct cvmx_tra_trig0_did_s cn56xx;
+	struct cvmx_tra_trig0_did_s cn56xxp1;
+	struct cvmx_tra_trig0_did_s cn58xx;
+	struct cvmx_tra_trig0_did_s cn58xxp1;
+} cvmx_tra_trig0_did_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tra_trig0_sid_s {
+		uint64_t reserved_20_63:44;
+		uint64_t dwb:1;
+		uint64_t iobreq:1;
+		uint64_t pko:1;
+		uint64_t pki:1;
+		uint64_t pp:16;
+	} s;
+	struct cvmx_tra_trig0_sid_s cn31xx;
+	struct cvmx_tra_trig0_sid_s cn38xx;
+	struct cvmx_tra_trig0_sid_s cn38xxp2;
+	struct cvmx_tra_trig0_sid_s cn52xx;
+	struct cvmx_tra_trig0_sid_s cn52xxp1;
+	struct cvmx_tra_trig0_sid_s cn56xx;
+	struct cvmx_tra_trig0_sid_s cn56xxp1;
+	struct cvmx_tra_trig0_sid_s cn58xx;
+	struct cvmx_tra_trig0_sid_s cn58xxp1;
+} cvmx_tra_trig0_sid_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tra_trig1_adr_adr_s {
+		uint64_t reserved_36_63:28;
+		uint64_t adr:36;
+	} s;
+	struct cvmx_tra_trig1_adr_adr_s cn31xx;
+	struct cvmx_tra_trig1_adr_adr_s cn38xx;
+	struct cvmx_tra_trig1_adr_adr_s cn38xxp2;
+	struct cvmx_tra_trig1_adr_adr_s cn52xx;
+	struct cvmx_tra_trig1_adr_adr_s cn52xxp1;
+	struct cvmx_tra_trig1_adr_adr_s cn56xx;
+	struct cvmx_tra_trig1_adr_adr_s cn56xxp1;
+	struct cvmx_tra_trig1_adr_adr_s cn58xx;
+	struct cvmx_tra_trig1_adr_adr_s cn58xxp1;
+} cvmx_tra_trig1_adr_adr_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tra_trig1_adr_msk_s {
+		uint64_t reserved_36_63:28;
+		uint64_t adr:36;
+	} s;
+	struct cvmx_tra_trig1_adr_msk_s cn31xx;
+	struct cvmx_tra_trig1_adr_msk_s cn38xx;
+	struct cvmx_tra_trig1_adr_msk_s cn38xxp2;
+	struct cvmx_tra_trig1_adr_msk_s cn52xx;
+	struct cvmx_tra_trig1_adr_msk_s cn52xxp1;
+	struct cvmx_tra_trig1_adr_msk_s cn56xx;
+	struct cvmx_tra_trig1_adr_msk_s cn56xxp1;
+	struct cvmx_tra_trig1_adr_msk_s cn58xx;
+	struct cvmx_tra_trig1_adr_msk_s cn58xxp1;
+} cvmx_tra_trig1_adr_msk_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tra_trig1_cmd_s {
+		uint64_t reserved_17_63:47;
+		uint64_t saa:1;
+		uint64_t iobdma:1;
+		uint64_t iobst:1;
+		uint64_t iobld64:1;
+		uint64_t iobld32:1;
+		uint64_t iobld16:1;
+		uint64_t iobld8:1;
+		uint64_t stt:1;
+		uint64_t stp:1;
+		uint64_t stc:1;
+		uint64_t stf:1;
+		uint64_t ldt:1;
+		uint64_t ldi:1;
+		uint64_t ldd:1;
+		uint64_t psl1:1;
+		uint64_t pl2:1;
+		uint64_t dwb:1;
+	} s;
+	struct cvmx_tra_trig1_cmd_cn31xx {
+		uint64_t reserved_16_63:48;
+		uint64_t iobdma:1;
+		uint64_t iobst:1;
+		uint64_t iobld64:1;
+		uint64_t iobld32:1;
+		uint64_t iobld16:1;
+		uint64_t iobld8:1;
+		uint64_t stt:1;
+		uint64_t stp:1;
+		uint64_t stc:1;
+		uint64_t stf:1;
+		uint64_t ldt:1;
+		uint64_t ldi:1;
+		uint64_t ldd:1;
+		uint64_t psl1:1;
+		uint64_t pl2:1;
+		uint64_t dwb:1;
+	} cn31xx;
+	struct cvmx_tra_trig1_cmd_cn31xx cn38xx;
+	struct cvmx_tra_trig1_cmd_cn31xx cn38xxp2;
+	struct cvmx_tra_trig1_cmd_s cn52xx;
+	struct cvmx_tra_trig1_cmd_s cn52xxp1;
+	struct cvmx_tra_trig1_cmd_s cn56xx;
+	struct cvmx_tra_trig1_cmd_s cn56xxp1;
+	struct cvmx_tra_trig1_cmd_s cn58xx;
+	struct cvmx_tra_trig1_cmd_s cn58xxp1;
+} cvmx_tra_trig1_cmd_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tra_trig1_did_s {
+		uint64_t reserved_32_63:32;
+		uint64_t illegal:19;
+		uint64_t pow:1;
+		uint64_t illegal2:3;
+		uint64_t rng:1;
+		uint64_t zip:1;
+		uint64_t dfa:1;
+		uint64_t fpa:1;
+		uint64_t key:1;
+		uint64_t pci:1;
+		uint64_t illegal3:2;
+		uint64_t mio:1;
+	} s;
+	struct cvmx_tra_trig1_did_s cn31xx;
+	struct cvmx_tra_trig1_did_s cn38xx;
+	struct cvmx_tra_trig1_did_s cn38xxp2;
+	struct cvmx_tra_trig1_did_s cn52xx;
+	struct cvmx_tra_trig1_did_s cn52xxp1;
+	struct cvmx_tra_trig1_did_s cn56xx;
+	struct cvmx_tra_trig1_did_s cn56xxp1;
+	struct cvmx_tra_trig1_did_s cn58xx;
+	struct cvmx_tra_trig1_did_s cn58xxp1;
+} cvmx_tra_trig1_did_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_tra_trig1_sid_s {
+		uint64_t reserved_20_63:44;
+		uint64_t dwb:1;
+		uint64_t iobreq:1;
+		uint64_t pko:1;
+		uint64_t pki:1;
+		uint64_t pp:16;
+	} s;
+	struct cvmx_tra_trig1_sid_s cn31xx;
+	struct cvmx_tra_trig1_sid_s cn38xx;
+	struct cvmx_tra_trig1_sid_s cn38xxp2;
+	struct cvmx_tra_trig1_sid_s cn52xx;
+	struct cvmx_tra_trig1_sid_s cn52xxp1;
+	struct cvmx_tra_trig1_sid_s cn56xx;
+	struct cvmx_tra_trig1_sid_s cn56xxp1;
+	struct cvmx_tra_trig1_sid_s cn58xx;
+	struct cvmx_tra_trig1_sid_s cn58xxp1;
+} cvmx_tra_trig1_sid_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_daint_s {
+		uint32_t outepint:16;
+		uint32_t inepint:16;
+	} s;
+	struct cvmx_usbcx_daint_s cn30xx;
+	struct cvmx_usbcx_daint_s cn31xx;
+	struct cvmx_usbcx_daint_s cn50xx;
+	struct cvmx_usbcx_daint_s cn52xx;
+	struct cvmx_usbcx_daint_s cn52xxp1;
+	struct cvmx_usbcx_daint_s cn56xx;
+	struct cvmx_usbcx_daint_s cn56xxp1;
+} cvmx_usbcx_daint_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_daintmsk_s {
+		uint32_t outepmsk:16;
+		uint32_t inepmsk:16;
+	} s;
+	struct cvmx_usbcx_daintmsk_s cn30xx;
+	struct cvmx_usbcx_daintmsk_s cn31xx;
+	struct cvmx_usbcx_daintmsk_s cn50xx;
+	struct cvmx_usbcx_daintmsk_s cn52xx;
+	struct cvmx_usbcx_daintmsk_s cn52xxp1;
+	struct cvmx_usbcx_daintmsk_s cn56xx;
+	struct cvmx_usbcx_daintmsk_s cn56xxp1;
+} cvmx_usbcx_daintmsk_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_dcfg_s {
+		uint32_t reserved_23_31:9;
+		uint32_t epmiscnt:5;
+		uint32_t reserved_13_17:5;
+		uint32_t perfrint:2;
+		uint32_t devaddr:7;
+		uint32_t reserved_3_3:1;
+		uint32_t nzstsouthshk:1;
+		uint32_t devspd:2;
+	} s;
+	struct cvmx_usbcx_dcfg_s cn30xx;
+	struct cvmx_usbcx_dcfg_s cn31xx;
+	struct cvmx_usbcx_dcfg_s cn50xx;
+	struct cvmx_usbcx_dcfg_s cn52xx;
+	struct cvmx_usbcx_dcfg_s cn52xxp1;
+	struct cvmx_usbcx_dcfg_s cn56xx;
+	struct cvmx_usbcx_dcfg_s cn56xxp1;
+} cvmx_usbcx_dcfg_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_dctl_s {
+		uint32_t reserved_12_31:20;
+		uint32_t pwronprgdone:1;
+		uint32_t cgoutnak:1;
+		uint32_t sgoutnak:1;
+		uint32_t cgnpinnak:1;
+		uint32_t sgnpinnak:1;
+		uint32_t tstctl:3;
+		uint32_t goutnaksts:1;
+		uint32_t gnpinnaksts:1;
+		uint32_t sftdiscon:1;
+		uint32_t rmtwkupsig:1;
+	} s;
+	struct cvmx_usbcx_dctl_s cn30xx;
+	struct cvmx_usbcx_dctl_s cn31xx;
+	struct cvmx_usbcx_dctl_s cn50xx;
+	struct cvmx_usbcx_dctl_s cn52xx;
+	struct cvmx_usbcx_dctl_s cn52xxp1;
+	struct cvmx_usbcx_dctl_s cn56xx;
+	struct cvmx_usbcx_dctl_s cn56xxp1;
+} cvmx_usbcx_dctl_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_diepctlx_s {
+		uint32_t epena:1;
+		uint32_t epdis:1;
+		uint32_t setd1pid:1;
+		uint32_t setd0pid:1;
+		uint32_t snak:1;
+		uint32_t cnak:1;
+		uint32_t txfnum:4;
+		uint32_t stall:1;
+		uint32_t reserved_20_20:1;
+		uint32_t eptype:2;
+		uint32_t naksts:1;
+		uint32_t dpid:1;
+		uint32_t usbactep:1;
+		uint32_t nextep:4;
+		uint32_t mps:11;
+	} s;
+	struct cvmx_usbcx_diepctlx_s cn30xx;
+	struct cvmx_usbcx_diepctlx_s cn31xx;
+	struct cvmx_usbcx_diepctlx_s cn50xx;
+	struct cvmx_usbcx_diepctlx_s cn52xx;
+	struct cvmx_usbcx_diepctlx_s cn52xxp1;
+	struct cvmx_usbcx_diepctlx_s cn56xx;
+	struct cvmx_usbcx_diepctlx_s cn56xxp1;
+} cvmx_usbcx_diepctlx_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_diepintx_s {
+		uint32_t reserved_7_31:25;
+		uint32_t inepnakeff:1;
+		uint32_t intknepmis:1;
+		uint32_t intkntxfemp:1;
+		uint32_t timeout:1;
+		uint32_t ahberr:1;
+		uint32_t epdisbld:1;
+		uint32_t xfercompl:1;
+	} s;
+	struct cvmx_usbcx_diepintx_s cn30xx;
+	struct cvmx_usbcx_diepintx_s cn31xx;
+	struct cvmx_usbcx_diepintx_s cn50xx;
+	struct cvmx_usbcx_diepintx_s cn52xx;
+	struct cvmx_usbcx_diepintx_s cn52xxp1;
+	struct cvmx_usbcx_diepintx_s cn56xx;
+	struct cvmx_usbcx_diepintx_s cn56xxp1;
+} cvmx_usbcx_diepintx_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_diepmsk_s {
+		uint32_t reserved_7_31:25;
+		uint32_t inepnakeffmsk:1;
+		uint32_t intknepmismsk:1;
+		uint32_t intkntxfempmsk:1;
+		uint32_t timeoutmsk:1;
+		uint32_t ahberrmsk:1;
+		uint32_t epdisbldmsk:1;
+		uint32_t xfercomplmsk:1;
+	} s;
+	struct cvmx_usbcx_diepmsk_s cn30xx;
+	struct cvmx_usbcx_diepmsk_s cn31xx;
+	struct cvmx_usbcx_diepmsk_s cn50xx;
+	struct cvmx_usbcx_diepmsk_s cn52xx;
+	struct cvmx_usbcx_diepmsk_s cn52xxp1;
+	struct cvmx_usbcx_diepmsk_s cn56xx;
+	struct cvmx_usbcx_diepmsk_s cn56xxp1;
+} cvmx_usbcx_diepmsk_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_dieptsizx_s {
+		uint32_t reserved_31_31:1;
+		uint32_t mc:2;
+		uint32_t pktcnt:10;
+		uint32_t xfersize:19;
+	} s;
+	struct cvmx_usbcx_dieptsizx_s cn30xx;
+	struct cvmx_usbcx_dieptsizx_s cn31xx;
+	struct cvmx_usbcx_dieptsizx_s cn50xx;
+	struct cvmx_usbcx_dieptsizx_s cn52xx;
+	struct cvmx_usbcx_dieptsizx_s cn52xxp1;
+	struct cvmx_usbcx_dieptsizx_s cn56xx;
+	struct cvmx_usbcx_dieptsizx_s cn56xxp1;
+} cvmx_usbcx_dieptsizx_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_doepctlx_s {
+		uint32_t epena:1;
+		uint32_t epdis:1;
+		uint32_t setd1pid:1;
+		uint32_t setd0pid:1;
+		uint32_t snak:1;
+		uint32_t cnak:1;
+		uint32_t reserved_22_25:4;
+		uint32_t stall:1;
+		uint32_t snp:1;
+		uint32_t eptype:2;
+		uint32_t naksts:1;
+		uint32_t dpid:1;
+		uint32_t usbactep:1;
+		uint32_t reserved_11_14:4;
+		uint32_t mps:11;
+	} s;
+	struct cvmx_usbcx_doepctlx_s cn30xx;
+	struct cvmx_usbcx_doepctlx_s cn31xx;
+	struct cvmx_usbcx_doepctlx_s cn50xx;
+	struct cvmx_usbcx_doepctlx_s cn52xx;
+	struct cvmx_usbcx_doepctlx_s cn52xxp1;
+	struct cvmx_usbcx_doepctlx_s cn56xx;
+	struct cvmx_usbcx_doepctlx_s cn56xxp1;
+} cvmx_usbcx_doepctlx_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_doepintx_s {
+		uint32_t reserved_5_31:27;
+		uint32_t outtknepdis:1;
+		uint32_t setup:1;
+		uint32_t ahberr:1;
+		uint32_t epdisbld:1;
+		uint32_t xfercompl:1;
+	} s;
+	struct cvmx_usbcx_doepintx_s cn30xx;
+	struct cvmx_usbcx_doepintx_s cn31xx;
+	struct cvmx_usbcx_doepintx_s cn50xx;
+	struct cvmx_usbcx_doepintx_s cn52xx;
+	struct cvmx_usbcx_doepintx_s cn52xxp1;
+	struct cvmx_usbcx_doepintx_s cn56xx;
+	struct cvmx_usbcx_doepintx_s cn56xxp1;
+} cvmx_usbcx_doepintx_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_doepmsk_s {
+		uint32_t reserved_5_31:27;
+		uint32_t outtknepdismsk:1;
+		uint32_t setupmsk:1;
+		uint32_t ahberrmsk:1;
+		uint32_t epdisbldmsk:1;
+		uint32_t xfercomplmsk:1;
+	} s;
+	struct cvmx_usbcx_doepmsk_s cn30xx;
+	struct cvmx_usbcx_doepmsk_s cn31xx;
+	struct cvmx_usbcx_doepmsk_s cn50xx;
+	struct cvmx_usbcx_doepmsk_s cn52xx;
+	struct cvmx_usbcx_doepmsk_s cn52xxp1;
+	struct cvmx_usbcx_doepmsk_s cn56xx;
+	struct cvmx_usbcx_doepmsk_s cn56xxp1;
+} cvmx_usbcx_doepmsk_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_doeptsizx_s {
+		uint32_t reserved_31_31:1;
+		uint32_t mc:2;
+		uint32_t pktcnt:10;
+		uint32_t xfersize:19;
+	} s;
+	struct cvmx_usbcx_doeptsizx_s cn30xx;
+	struct cvmx_usbcx_doeptsizx_s cn31xx;
+	struct cvmx_usbcx_doeptsizx_s cn50xx;
+	struct cvmx_usbcx_doeptsizx_s cn52xx;
+	struct cvmx_usbcx_doeptsizx_s cn52xxp1;
+	struct cvmx_usbcx_doeptsizx_s cn56xx;
+	struct cvmx_usbcx_doeptsizx_s cn56xxp1;
+} cvmx_usbcx_doeptsizx_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_dptxfsizx_s {
+		uint32_t dptxfsize:16;
+		uint32_t dptxfstaddr:16;
+	} s;
+	struct cvmx_usbcx_dptxfsizx_s cn30xx;
+	struct cvmx_usbcx_dptxfsizx_s cn31xx;
+	struct cvmx_usbcx_dptxfsizx_s cn50xx;
+	struct cvmx_usbcx_dptxfsizx_s cn52xx;
+	struct cvmx_usbcx_dptxfsizx_s cn52xxp1;
+	struct cvmx_usbcx_dptxfsizx_s cn56xx;
+	struct cvmx_usbcx_dptxfsizx_s cn56xxp1;
+} cvmx_usbcx_dptxfsizx_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_dsts_s {
+		uint32_t reserved_22_31:10;
+		uint32_t soffn:14;
+		uint32_t reserved_4_7:4;
+		uint32_t errticerr:1;
+		uint32_t enumspd:2;
+		uint32_t suspsts:1;
+	} s;
+	struct cvmx_usbcx_dsts_s cn30xx;
+	struct cvmx_usbcx_dsts_s cn31xx;
+	struct cvmx_usbcx_dsts_s cn50xx;
+	struct cvmx_usbcx_dsts_s cn52xx;
+	struct cvmx_usbcx_dsts_s cn52xxp1;
+	struct cvmx_usbcx_dsts_s cn56xx;
+	struct cvmx_usbcx_dsts_s cn56xxp1;
+} cvmx_usbcx_dsts_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_dtknqr1_s {
+		uint32_t eptkn:24;
+		uint32_t wrapbit:1;
+		uint32_t reserved_5_6:2;
+		uint32_t intknwptr:5;
+	} s;
+	struct cvmx_usbcx_dtknqr1_s cn30xx;
+	struct cvmx_usbcx_dtknqr1_s cn31xx;
+	struct cvmx_usbcx_dtknqr1_s cn50xx;
+	struct cvmx_usbcx_dtknqr1_s cn52xx;
+	struct cvmx_usbcx_dtknqr1_s cn52xxp1;
+	struct cvmx_usbcx_dtknqr1_s cn56xx;
+	struct cvmx_usbcx_dtknqr1_s cn56xxp1;
+} cvmx_usbcx_dtknqr1_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_dtknqr2_s {
+		uint32_t eptkn:32;
+	} s;
+	struct cvmx_usbcx_dtknqr2_s cn30xx;
+	struct cvmx_usbcx_dtknqr2_s cn31xx;
+	struct cvmx_usbcx_dtknqr2_s cn50xx;
+	struct cvmx_usbcx_dtknqr2_s cn52xx;
+	struct cvmx_usbcx_dtknqr2_s cn52xxp1;
+	struct cvmx_usbcx_dtknqr2_s cn56xx;
+	struct cvmx_usbcx_dtknqr2_s cn56xxp1;
+} cvmx_usbcx_dtknqr2_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_dtknqr3_s {
+		uint32_t eptkn:32;
+	} s;
+	struct cvmx_usbcx_dtknqr3_s cn30xx;
+	struct cvmx_usbcx_dtknqr3_s cn31xx;
+	struct cvmx_usbcx_dtknqr3_s cn50xx;
+	struct cvmx_usbcx_dtknqr3_s cn52xx;
+	struct cvmx_usbcx_dtknqr3_s cn52xxp1;
+	struct cvmx_usbcx_dtknqr3_s cn56xx;
+	struct cvmx_usbcx_dtknqr3_s cn56xxp1;
+} cvmx_usbcx_dtknqr3_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_dtknqr4_s {
+		uint32_t eptkn:32;
+	} s;
+	struct cvmx_usbcx_dtknqr4_s cn30xx;
+	struct cvmx_usbcx_dtknqr4_s cn31xx;
+	struct cvmx_usbcx_dtknqr4_s cn50xx;
+	struct cvmx_usbcx_dtknqr4_s cn52xx;
+	struct cvmx_usbcx_dtknqr4_s cn52xxp1;
+	struct cvmx_usbcx_dtknqr4_s cn56xx;
+	struct cvmx_usbcx_dtknqr4_s cn56xxp1;
+} cvmx_usbcx_dtknqr4_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_gahbcfg_s {
+		uint32_t reserved_9_31:23;
+		uint32_t ptxfemplvl:1;
+		uint32_t nptxfemplvl:1;
+		uint32_t reserved_6_6:1;
+		uint32_t dmaen:1;
+		uint32_t hbstlen:4;
+		uint32_t glblintrmsk:1;
+	} s;
+	struct cvmx_usbcx_gahbcfg_s cn30xx;
+	struct cvmx_usbcx_gahbcfg_s cn31xx;
+	struct cvmx_usbcx_gahbcfg_s cn50xx;
+	struct cvmx_usbcx_gahbcfg_s cn52xx;
+	struct cvmx_usbcx_gahbcfg_s cn52xxp1;
+	struct cvmx_usbcx_gahbcfg_s cn56xx;
+	struct cvmx_usbcx_gahbcfg_s cn56xxp1;
+} cvmx_usbcx_gahbcfg_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_ghwcfg1_s {
+		uint32_t epdir:32;
+	} s;
+	struct cvmx_usbcx_ghwcfg1_s cn30xx;
+	struct cvmx_usbcx_ghwcfg1_s cn31xx;
+	struct cvmx_usbcx_ghwcfg1_s cn50xx;
+	struct cvmx_usbcx_ghwcfg1_s cn52xx;
+	struct cvmx_usbcx_ghwcfg1_s cn52xxp1;
+	struct cvmx_usbcx_ghwcfg1_s cn56xx;
+	struct cvmx_usbcx_ghwcfg1_s cn56xxp1;
+} cvmx_usbcx_ghwcfg1_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_ghwcfg2_s {
+		uint32_t reserved_31_31:1;
+		uint32_t tknqdepth:5;
+		uint32_t ptxqdepth:2;
+		uint32_t nptxqdepth:2;
+		uint32_t reserved_20_21:2;
+		uint32_t dynfifosizing:1;
+		uint32_t periosupport:1;
+		uint32_t numhstchnl:4;
+		uint32_t numdeveps:4;
+		uint32_t fsphytype:2;
+		uint32_t hsphytype:2;
+		uint32_t singpnt:1;
+		uint32_t otgarch:2;
+		uint32_t otgmode:3;
+	} s;
+	struct cvmx_usbcx_ghwcfg2_s cn30xx;
+	struct cvmx_usbcx_ghwcfg2_s cn31xx;
+	struct cvmx_usbcx_ghwcfg2_s cn50xx;
+	struct cvmx_usbcx_ghwcfg2_s cn52xx;
+	struct cvmx_usbcx_ghwcfg2_s cn52xxp1;
+	struct cvmx_usbcx_ghwcfg2_s cn56xx;
+	struct cvmx_usbcx_ghwcfg2_s cn56xxp1;
+} cvmx_usbcx_ghwcfg2_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_ghwcfg3_s {
+		uint32_t dfifodepth:16;
+		uint32_t reserved_13_15:3;
+		uint32_t ahbphysync:1;
+		uint32_t rsttype:1;
+		uint32_t optfeature:1;
+		uint32_t vendor_control_interface_support:1;
+
+		uint32_t i2c_selection:1;
+		uint32_t otgen:1;
+		uint32_t pktsizewidth:3;
+		uint32_t xfersizewidth:4;
+	} s;
+	struct cvmx_usbcx_ghwcfg3_s cn30xx;
+	struct cvmx_usbcx_ghwcfg3_s cn31xx;
+	struct cvmx_usbcx_ghwcfg3_s cn50xx;
+	struct cvmx_usbcx_ghwcfg3_s cn52xx;
+	struct cvmx_usbcx_ghwcfg3_s cn52xxp1;
+	struct cvmx_usbcx_ghwcfg3_s cn56xx;
+	struct cvmx_usbcx_ghwcfg3_s cn56xxp1;
+} cvmx_usbcx_ghwcfg3_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_ghwcfg4_s {
+		uint32_t reserved_30_31:2;
+		uint32_t numdevmodinend:4;
+		uint32_t endedtrfifo:1;
+		uint32_t sessendfltr:1;
+		uint32_t bvalidfltr:1;
+		uint32_t avalidfltr:1;
+		uint32_t vbusvalidfltr:1;
+		uint32_t iddgfltr:1;
+		uint32_t numctleps:4;
+		uint32_t phydatawidth:2;
+		uint32_t reserved_6_13:8;
+		uint32_t ahbfreq:1;
+		uint32_t enablepwropt:1;
+		uint32_t numdevperioeps:4;
+	} s;
+	struct cvmx_usbcx_ghwcfg4_cn30xx {
+		uint32_t reserved_25_31:7;
+		uint32_t sessendfltr:1;
+		uint32_t bvalidfltr:1;
+		uint32_t avalidfltr:1;
+		uint32_t vbusvalidfltr:1;
+		uint32_t iddgfltr:1;
+		uint32_t numctleps:4;
+		uint32_t phydatawidth:2;
+		uint32_t reserved_6_13:8;
+		uint32_t ahbfreq:1;
+		uint32_t enablepwropt:1;
+		uint32_t numdevperioeps:4;
+	} cn30xx;
+	struct cvmx_usbcx_ghwcfg4_cn30xx cn31xx;
+	struct cvmx_usbcx_ghwcfg4_s cn50xx;
+	struct cvmx_usbcx_ghwcfg4_s cn52xx;
+	struct cvmx_usbcx_ghwcfg4_s cn52xxp1;
+	struct cvmx_usbcx_ghwcfg4_s cn56xx;
+	struct cvmx_usbcx_ghwcfg4_s cn56xxp1;
+} cvmx_usbcx_ghwcfg4_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_gintmsk_s {
+		uint32_t wkupintmsk:1;
+		uint32_t sessreqintmsk:1;
+		uint32_t disconnintmsk:1;
+		uint32_t conidstschngmsk:1;
+		uint32_t reserved_27_27:1;
+		uint32_t ptxfempmsk:1;
+		uint32_t hchintmsk:1;
+		uint32_t prtintmsk:1;
+		uint32_t reserved_23_23:1;
+		uint32_t fetsuspmsk:1;
+		uint32_t incomplpmsk:1;
+		uint32_t incompisoinmsk:1;
+		uint32_t oepintmsk:1;
+		uint32_t inepintmsk:1;
+		uint32_t epmismsk:1;
+		uint32_t reserved_16_16:1;
+		uint32_t eopfmsk:1;
+		uint32_t isooutdropmsk:1;
+		uint32_t enumdonemsk:1;
+		uint32_t usbrstmsk:1;
+		uint32_t usbsuspmsk:1;
+		uint32_t erlysuspmsk:1;
+		uint32_t i2cint:1;
+		uint32_t ulpickintmsk:1;
+		uint32_t goutnakeffmsk:1;
+		uint32_t ginnakeffmsk:1;
+		uint32_t nptxfempmsk:1;
+		uint32_t rxflvlmsk:1;
+		uint32_t sofmsk:1;
+		uint32_t otgintmsk:1;
+		uint32_t modemismsk:1;
+		uint32_t reserved_0_0:1;
+	} s;
+	struct cvmx_usbcx_gintmsk_s cn30xx;
+	struct cvmx_usbcx_gintmsk_s cn31xx;
+	struct cvmx_usbcx_gintmsk_s cn50xx;
+	struct cvmx_usbcx_gintmsk_s cn52xx;
+	struct cvmx_usbcx_gintmsk_s cn52xxp1;
+	struct cvmx_usbcx_gintmsk_s cn56xx;
+	struct cvmx_usbcx_gintmsk_s cn56xxp1;
+} cvmx_usbcx_gintmsk_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_gintsts_s {
+		uint32_t wkupint:1;
+		uint32_t sessreqint:1;
+		uint32_t disconnint:1;
+		uint32_t conidstschng:1;
+		uint32_t reserved_27_27:1;
+		uint32_t ptxfemp:1;
+		uint32_t hchint:1;
+		uint32_t prtint:1;
+		uint32_t reserved_23_23:1;
+		uint32_t fetsusp:1;
+		uint32_t incomplp:1;
+		uint32_t incompisoin:1;
+		uint32_t oepint:1;
+		uint32_t iepint:1;
+		uint32_t epmis:1;
+		uint32_t reserved_16_16:1;
+		uint32_t eopf:1;
+		uint32_t isooutdrop:1;
+		uint32_t enumdone:1;
+		uint32_t usbrst:1;
+		uint32_t usbsusp:1;
+		uint32_t erlysusp:1;
+		uint32_t i2cint:1;
+		uint32_t ulpickint:1;
+		uint32_t goutnakeff:1;
+		uint32_t ginnakeff:1;
+		uint32_t nptxfemp:1;
+		uint32_t rxflvl:1;
+		uint32_t sof:1;
+		uint32_t otgint:1;
+		uint32_t modemis:1;
+		uint32_t curmod:1;
+	} s;
+	struct cvmx_usbcx_gintsts_s cn30xx;
+	struct cvmx_usbcx_gintsts_s cn31xx;
+	struct cvmx_usbcx_gintsts_s cn50xx;
+	struct cvmx_usbcx_gintsts_s cn52xx;
+	struct cvmx_usbcx_gintsts_s cn52xxp1;
+	struct cvmx_usbcx_gintsts_s cn56xx;
+	struct cvmx_usbcx_gintsts_s cn56xxp1;
+} cvmx_usbcx_gintsts_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_gnptxfsiz_s {
+		uint32_t nptxfdep:16;
+		uint32_t nptxfstaddr:16;
+	} s;
+	struct cvmx_usbcx_gnptxfsiz_s cn30xx;
+	struct cvmx_usbcx_gnptxfsiz_s cn31xx;
+	struct cvmx_usbcx_gnptxfsiz_s cn50xx;
+	struct cvmx_usbcx_gnptxfsiz_s cn52xx;
+	struct cvmx_usbcx_gnptxfsiz_s cn52xxp1;
+	struct cvmx_usbcx_gnptxfsiz_s cn56xx;
+	struct cvmx_usbcx_gnptxfsiz_s cn56xxp1;
+} cvmx_usbcx_gnptxfsiz_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_gnptxsts_s {
+		uint32_t reserved_31_31:1;
+		uint32_t nptxqtop:7;
+		uint32_t nptxqspcavail:8;
+		uint32_t nptxfspcavail:16;
+	} s;
+	struct cvmx_usbcx_gnptxsts_s cn30xx;
+	struct cvmx_usbcx_gnptxsts_s cn31xx;
+	struct cvmx_usbcx_gnptxsts_s cn50xx;
+	struct cvmx_usbcx_gnptxsts_s cn52xx;
+	struct cvmx_usbcx_gnptxsts_s cn52xxp1;
+	struct cvmx_usbcx_gnptxsts_s cn56xx;
+	struct cvmx_usbcx_gnptxsts_s cn56xxp1;
+} cvmx_usbcx_gnptxsts_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_gotgctl_s {
+		uint32_t reserved_20_31:12;
+		uint32_t bsesvld:1;
+		uint32_t asesvld:1;
+		uint32_t dbnctime:1;
+		uint32_t conidsts:1;
+		uint32_t reserved_12_15:4;
+		uint32_t devhnpen:1;
+		uint32_t hstsethnpen:1;
+		uint32_t hnpreq:1;
+		uint32_t hstnegscs:1;
+		uint32_t reserved_2_7:6;
+		uint32_t sesreq:1;
+		uint32_t sesreqscs:1;
+	} s;
+	struct cvmx_usbcx_gotgctl_s cn30xx;
+	struct cvmx_usbcx_gotgctl_s cn31xx;
+	struct cvmx_usbcx_gotgctl_s cn50xx;
+	struct cvmx_usbcx_gotgctl_s cn52xx;
+	struct cvmx_usbcx_gotgctl_s cn52xxp1;
+	struct cvmx_usbcx_gotgctl_s cn56xx;
+	struct cvmx_usbcx_gotgctl_s cn56xxp1;
+} cvmx_usbcx_gotgctl_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_gotgint_s {
+		uint32_t reserved_20_31:12;
+		uint32_t dbncedone:1;
+		uint32_t adevtoutchg:1;
+		uint32_t hstnegdet:1;
+		uint32_t reserved_10_16:7;
+		uint32_t hstnegsucstschng:1;
+		uint32_t sesreqsucstschng:1;
+		uint32_t reserved_3_7:5;
+		uint32_t sesenddet:1;
+		uint32_t reserved_0_1:2;
+	} s;
+	struct cvmx_usbcx_gotgint_s cn30xx;
+	struct cvmx_usbcx_gotgint_s cn31xx;
+	struct cvmx_usbcx_gotgint_s cn50xx;
+	struct cvmx_usbcx_gotgint_s cn52xx;
+	struct cvmx_usbcx_gotgint_s cn52xxp1;
+	struct cvmx_usbcx_gotgint_s cn56xx;
+	struct cvmx_usbcx_gotgint_s cn56xxp1;
+} cvmx_usbcx_gotgint_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_grstctl_s {
+		uint32_t ahbidle:1;
+		uint32_t dmareq:1;
+		uint32_t reserved_11_29:19;
+		uint32_t txfnum:5;
+		uint32_t txfflsh:1;
+		uint32_t rxfflsh:1;
+		uint32_t intknqflsh:1;
+		uint32_t frmcntrrst:1;
+		uint32_t hsftrst:1;
+		uint32_t csftrst:1;
+	} s;
+	struct cvmx_usbcx_grstctl_s cn30xx;
+	struct cvmx_usbcx_grstctl_s cn31xx;
+	struct cvmx_usbcx_grstctl_s cn50xx;
+	struct cvmx_usbcx_grstctl_s cn52xx;
+	struct cvmx_usbcx_grstctl_s cn52xxp1;
+	struct cvmx_usbcx_grstctl_s cn56xx;
+	struct cvmx_usbcx_grstctl_s cn56xxp1;
+} cvmx_usbcx_grstctl_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_grxfsiz_s {
+		uint32_t reserved_16_31:16;
+		uint32_t rxfdep:16;
+	} s;
+	struct cvmx_usbcx_grxfsiz_s cn30xx;
+	struct cvmx_usbcx_grxfsiz_s cn31xx;
+	struct cvmx_usbcx_grxfsiz_s cn50xx;
+	struct cvmx_usbcx_grxfsiz_s cn52xx;
+	struct cvmx_usbcx_grxfsiz_s cn52xxp1;
+	struct cvmx_usbcx_grxfsiz_s cn56xx;
+	struct cvmx_usbcx_grxfsiz_s cn56xxp1;
+} cvmx_usbcx_grxfsiz_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_grxstspd_s {
+		uint32_t reserved_25_31:7;
+		uint32_t fn:4;
+		uint32_t pktsts:4;
+		uint32_t dpid:2;
+		uint32_t bcnt:11;
+		uint32_t epnum:4;
+	} s;
+	struct cvmx_usbcx_grxstspd_s cn30xx;
+	struct cvmx_usbcx_grxstspd_s cn31xx;
+	struct cvmx_usbcx_grxstspd_s cn50xx;
+	struct cvmx_usbcx_grxstspd_s cn52xx;
+	struct cvmx_usbcx_grxstspd_s cn52xxp1;
+	struct cvmx_usbcx_grxstspd_s cn56xx;
+	struct cvmx_usbcx_grxstspd_s cn56xxp1;
+} cvmx_usbcx_grxstspd_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_grxstsph_s {
+		uint32_t reserved_21_31:11;
+		uint32_t pktsts:4;
+		uint32_t dpid:2;
+		uint32_t bcnt:11;
+		uint32_t chnum:4;
+	} s;
+	struct cvmx_usbcx_grxstsph_s cn30xx;
+	struct cvmx_usbcx_grxstsph_s cn31xx;
+	struct cvmx_usbcx_grxstsph_s cn50xx;
+	struct cvmx_usbcx_grxstsph_s cn52xx;
+	struct cvmx_usbcx_grxstsph_s cn52xxp1;
+	struct cvmx_usbcx_grxstsph_s cn56xx;
+	struct cvmx_usbcx_grxstsph_s cn56xxp1;
+} cvmx_usbcx_grxstsph_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_grxstsrd_s {
+		uint32_t reserved_25_31:7;
+		uint32_t fn:4;
+		uint32_t pktsts:4;
+		uint32_t dpid:2;
+		uint32_t bcnt:11;
+		uint32_t epnum:4;
+	} s;
+	struct cvmx_usbcx_grxstsrd_s cn30xx;
+	struct cvmx_usbcx_grxstsrd_s cn31xx;
+	struct cvmx_usbcx_grxstsrd_s cn50xx;
+	struct cvmx_usbcx_grxstsrd_s cn52xx;
+	struct cvmx_usbcx_grxstsrd_s cn52xxp1;
+	struct cvmx_usbcx_grxstsrd_s cn56xx;
+	struct cvmx_usbcx_grxstsrd_s cn56xxp1;
+} cvmx_usbcx_grxstsrd_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_grxstsrh_s {
+		uint32_t reserved_21_31:11;
+		uint32_t pktsts:4;
+		uint32_t dpid:2;
+		uint32_t bcnt:11;
+		uint32_t chnum:4;
+	} s;
+	struct cvmx_usbcx_grxstsrh_s cn30xx;
+	struct cvmx_usbcx_grxstsrh_s cn31xx;
+	struct cvmx_usbcx_grxstsrh_s cn50xx;
+	struct cvmx_usbcx_grxstsrh_s cn52xx;
+	struct cvmx_usbcx_grxstsrh_s cn52xxp1;
+	struct cvmx_usbcx_grxstsrh_s cn56xx;
+	struct cvmx_usbcx_grxstsrh_s cn56xxp1;
+} cvmx_usbcx_grxstsrh_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_gsnpsid_s {
+		uint32_t synopsysid:32;
+	} s;
+	struct cvmx_usbcx_gsnpsid_s cn30xx;
+	struct cvmx_usbcx_gsnpsid_s cn31xx;
+	struct cvmx_usbcx_gsnpsid_s cn50xx;
+	struct cvmx_usbcx_gsnpsid_s cn52xx;
+	struct cvmx_usbcx_gsnpsid_s cn52xxp1;
+	struct cvmx_usbcx_gsnpsid_s cn56xx;
+	struct cvmx_usbcx_gsnpsid_s cn56xxp1;
+} cvmx_usbcx_gsnpsid_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_gusbcfg_s {
+		uint32_t reserved_17_31:15;
+		uint32_t otgi2csel:1;
+		uint32_t phylpwrclksel:1;
+		uint32_t reserved_14_14:1;
+		uint32_t usbtrdtim:4;
+		uint32_t hnpcap:1;
+		uint32_t srpcap:1;
+		uint32_t ddrsel:1;
+		uint32_t physel:1;
+		uint32_t fsintf:1;
+		uint32_t ulpi_utmi_sel:1;
+		uint32_t phyif:1;
+		uint32_t toutcal:3;
+	} s;
+	struct cvmx_usbcx_gusbcfg_s cn30xx;
+	struct cvmx_usbcx_gusbcfg_s cn31xx;
+	struct cvmx_usbcx_gusbcfg_s cn50xx;
+	struct cvmx_usbcx_gusbcfg_s cn52xx;
+	struct cvmx_usbcx_gusbcfg_s cn52xxp1;
+	struct cvmx_usbcx_gusbcfg_s cn56xx;
+	struct cvmx_usbcx_gusbcfg_s cn56xxp1;
+} cvmx_usbcx_gusbcfg_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_haint_s {
+		uint32_t reserved_16_31:16;
+		uint32_t haint:16;
+	} s;
+	struct cvmx_usbcx_haint_s cn30xx;
+	struct cvmx_usbcx_haint_s cn31xx;
+	struct cvmx_usbcx_haint_s cn50xx;
+	struct cvmx_usbcx_haint_s cn52xx;
+	struct cvmx_usbcx_haint_s cn52xxp1;
+	struct cvmx_usbcx_haint_s cn56xx;
+	struct cvmx_usbcx_haint_s cn56xxp1;
+} cvmx_usbcx_haint_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_haintmsk_s {
+		uint32_t reserved_16_31:16;
+		uint32_t haintmsk:16;
+	} s;
+	struct cvmx_usbcx_haintmsk_s cn30xx;
+	struct cvmx_usbcx_haintmsk_s cn31xx;
+	struct cvmx_usbcx_haintmsk_s cn50xx;
+	struct cvmx_usbcx_haintmsk_s cn52xx;
+	struct cvmx_usbcx_haintmsk_s cn52xxp1;
+	struct cvmx_usbcx_haintmsk_s cn56xx;
+	struct cvmx_usbcx_haintmsk_s cn56xxp1;
+} cvmx_usbcx_haintmsk_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_hccharx_s {
+		uint32_t chena:1;
+		uint32_t chdis:1;
+		uint32_t oddfrm:1;
+		uint32_t devaddr:7;
+		uint32_t ec:2;
+		uint32_t eptype:2;
+		uint32_t lspddev:1;
+		uint32_t reserved_16_16:1;
+		uint32_t epdir:1;
+		uint32_t epnum:4;
+		uint32_t mps:11;
+	} s;
+	struct cvmx_usbcx_hccharx_s cn30xx;
+	struct cvmx_usbcx_hccharx_s cn31xx;
+	struct cvmx_usbcx_hccharx_s cn50xx;
+	struct cvmx_usbcx_hccharx_s cn52xx;
+	struct cvmx_usbcx_hccharx_s cn52xxp1;
+	struct cvmx_usbcx_hccharx_s cn56xx;
+	struct cvmx_usbcx_hccharx_s cn56xxp1;
+} cvmx_usbcx_hccharx_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_hcfg_s {
+		uint32_t reserved_3_31:29;
+		uint32_t fslssupp:1;
+		uint32_t fslspclksel:2;
+	} s;
+	struct cvmx_usbcx_hcfg_s cn30xx;
+	struct cvmx_usbcx_hcfg_s cn31xx;
+	struct cvmx_usbcx_hcfg_s cn50xx;
+	struct cvmx_usbcx_hcfg_s cn52xx;
+	struct cvmx_usbcx_hcfg_s cn52xxp1;
+	struct cvmx_usbcx_hcfg_s cn56xx;
+	struct cvmx_usbcx_hcfg_s cn56xxp1;
+} cvmx_usbcx_hcfg_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_hcintx_s {
+		uint32_t reserved_11_31:21;
+		uint32_t datatglerr:1;
+		uint32_t frmovrun:1;
+		uint32_t bblerr:1;
+		uint32_t xacterr:1;
+		uint32_t nyet:1;
+		uint32_t ack:1;
+		uint32_t nak:1;
+		uint32_t stall:1;
+		uint32_t ahberr:1;
+		uint32_t chhltd:1;
+		uint32_t xfercompl:1;
+	} s;
+	struct cvmx_usbcx_hcintx_s cn30xx;
+	struct cvmx_usbcx_hcintx_s cn31xx;
+	struct cvmx_usbcx_hcintx_s cn50xx;
+	struct cvmx_usbcx_hcintx_s cn52xx;
+	struct cvmx_usbcx_hcintx_s cn52xxp1;
+	struct cvmx_usbcx_hcintx_s cn56xx;
+	struct cvmx_usbcx_hcintx_s cn56xxp1;
+} cvmx_usbcx_hcintx_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_hcintmskx_s {
+		uint32_t reserved_11_31:21;
+		uint32_t datatglerrmsk:1;
+		uint32_t frmovrunmsk:1;
+		uint32_t bblerrmsk:1;
+		uint32_t xacterrmsk:1;
+		uint32_t nyetmsk:1;
+		uint32_t ackmsk:1;
+		uint32_t nakmsk:1;
+		uint32_t stallmsk:1;
+		uint32_t ahberrmsk:1;
+		uint32_t chhltdmsk:1;
+		uint32_t xfercomplmsk:1;
+	} s;
+	struct cvmx_usbcx_hcintmskx_s cn30xx;
+	struct cvmx_usbcx_hcintmskx_s cn31xx;
+	struct cvmx_usbcx_hcintmskx_s cn50xx;
+	struct cvmx_usbcx_hcintmskx_s cn52xx;
+	struct cvmx_usbcx_hcintmskx_s cn52xxp1;
+	struct cvmx_usbcx_hcintmskx_s cn56xx;
+	struct cvmx_usbcx_hcintmskx_s cn56xxp1;
+} cvmx_usbcx_hcintmskx_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_hcspltx_s {
+		uint32_t spltena:1;
+		uint32_t reserved_17_30:14;
+		uint32_t compsplt:1;
+		uint32_t xactpos:2;
+		uint32_t hubaddr:7;
+		uint32_t prtaddr:7;
+	} s;
+	struct cvmx_usbcx_hcspltx_s cn30xx;
+	struct cvmx_usbcx_hcspltx_s cn31xx;
+	struct cvmx_usbcx_hcspltx_s cn50xx;
+	struct cvmx_usbcx_hcspltx_s cn52xx;
+	struct cvmx_usbcx_hcspltx_s cn52xxp1;
+	struct cvmx_usbcx_hcspltx_s cn56xx;
+	struct cvmx_usbcx_hcspltx_s cn56xxp1;
+} cvmx_usbcx_hcspltx_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_hctsizx_s {
+		uint32_t dopng:1;
+		uint32_t pid:2;
+		uint32_t pktcnt:10;
+		uint32_t xfersize:19;
+	} s;
+	struct cvmx_usbcx_hctsizx_s cn30xx;
+	struct cvmx_usbcx_hctsizx_s cn31xx;
+	struct cvmx_usbcx_hctsizx_s cn50xx;
+	struct cvmx_usbcx_hctsizx_s cn52xx;
+	struct cvmx_usbcx_hctsizx_s cn52xxp1;
+	struct cvmx_usbcx_hctsizx_s cn56xx;
+	struct cvmx_usbcx_hctsizx_s cn56xxp1;
+} cvmx_usbcx_hctsizx_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_hfir_s {
+		uint32_t reserved_16_31:16;
+		uint32_t frint:16;
+	} s;
+	struct cvmx_usbcx_hfir_s cn30xx;
+	struct cvmx_usbcx_hfir_s cn31xx;
+	struct cvmx_usbcx_hfir_s cn50xx;
+	struct cvmx_usbcx_hfir_s cn52xx;
+	struct cvmx_usbcx_hfir_s cn52xxp1;
+	struct cvmx_usbcx_hfir_s cn56xx;
+	struct cvmx_usbcx_hfir_s cn56xxp1;
+} cvmx_usbcx_hfir_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_hfnum_s {
+		uint32_t frrem:16;
+		uint32_t frnum:16;
+	} s;
+	struct cvmx_usbcx_hfnum_s cn30xx;
+	struct cvmx_usbcx_hfnum_s cn31xx;
+	struct cvmx_usbcx_hfnum_s cn50xx;
+	struct cvmx_usbcx_hfnum_s cn52xx;
+	struct cvmx_usbcx_hfnum_s cn52xxp1;
+	struct cvmx_usbcx_hfnum_s cn56xx;
+	struct cvmx_usbcx_hfnum_s cn56xxp1;
+} cvmx_usbcx_hfnum_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_hprt_s {
+		uint32_t reserved_19_31:13;
+		uint32_t prtspd:2;
+		uint32_t prttstctl:4;
+		uint32_t prtpwr:1;
+		uint32_t prtlnsts:2;
+		uint32_t reserved_9_9:1;
+		uint32_t prtrst:1;
+		uint32_t prtsusp:1;
+		uint32_t prtres:1;
+		uint32_t prtovrcurrchng:1;
+		uint32_t prtovrcurract:1;
+		uint32_t prtenchng:1;
+		uint32_t prtena:1;
+		uint32_t prtconndet:1;
+		uint32_t prtconnsts:1;
+	} s;
+	struct cvmx_usbcx_hprt_s cn30xx;
+	struct cvmx_usbcx_hprt_s cn31xx;
+	struct cvmx_usbcx_hprt_s cn50xx;
+	struct cvmx_usbcx_hprt_s cn52xx;
+	struct cvmx_usbcx_hprt_s cn52xxp1;
+	struct cvmx_usbcx_hprt_s cn56xx;
+	struct cvmx_usbcx_hprt_s cn56xxp1;
+} cvmx_usbcx_hprt_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_hptxfsiz_s {
+		uint32_t ptxfsize:16;
+		uint32_t ptxfstaddr:16;
+	} s;
+	struct cvmx_usbcx_hptxfsiz_s cn30xx;
+	struct cvmx_usbcx_hptxfsiz_s cn31xx;
+	struct cvmx_usbcx_hptxfsiz_s cn50xx;
+	struct cvmx_usbcx_hptxfsiz_s cn52xx;
+	struct cvmx_usbcx_hptxfsiz_s cn52xxp1;
+	struct cvmx_usbcx_hptxfsiz_s cn56xx;
+	struct cvmx_usbcx_hptxfsiz_s cn56xxp1;
+} cvmx_usbcx_hptxfsiz_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_hptxsts_s {
+		uint32_t ptxqtop:8;
+		uint32_t ptxqspcavail:8;
+		uint32_t ptxfspcavail:16;
+	} s;
+	struct cvmx_usbcx_hptxsts_s cn30xx;
+	struct cvmx_usbcx_hptxsts_s cn31xx;
+	struct cvmx_usbcx_hptxsts_s cn50xx;
+	struct cvmx_usbcx_hptxsts_s cn52xx;
+	struct cvmx_usbcx_hptxsts_s cn52xxp1;
+	struct cvmx_usbcx_hptxsts_s cn56xx;
+	struct cvmx_usbcx_hptxsts_s cn56xxp1;
+} cvmx_usbcx_hptxsts_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_nptxdfifox_s {
+		uint32_t data:32;
+	} s;
+	struct cvmx_usbcx_nptxdfifox_s cn30xx;
+	struct cvmx_usbcx_nptxdfifox_s cn31xx;
+	struct cvmx_usbcx_nptxdfifox_s cn50xx;
+	struct cvmx_usbcx_nptxdfifox_s cn52xx;
+	struct cvmx_usbcx_nptxdfifox_s cn52xxp1;
+	struct cvmx_usbcx_nptxdfifox_s cn56xx;
+	struct cvmx_usbcx_nptxdfifox_s cn56xxp1;
+} cvmx_usbcx_nptxdfifox_t;
+
+typedef union {
+	uint32_t u32;
+	struct cvmx_usbcx_pcgcctl_s {
+		uint32_t reserved_5_31:27;
+		uint32_t physuspended:1;
+		uint32_t rstpdwnmodule:1;
+		uint32_t pwrclmp:1;
+		uint32_t gatehclk:1;
+		uint32_t stoppclk:1;
+	} s;
+	struct cvmx_usbcx_pcgcctl_s cn30xx;
+	struct cvmx_usbcx_pcgcctl_s cn31xx;
+	struct cvmx_usbcx_pcgcctl_s cn50xx;
+	struct cvmx_usbcx_pcgcctl_s cn52xx;
+	struct cvmx_usbcx_pcgcctl_s cn52xxp1;
+	struct cvmx_usbcx_pcgcctl_s cn56xx;
+	struct cvmx_usbcx_pcgcctl_s cn56xxp1;
+} cvmx_usbcx_pcgcctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_usbnx_bist_status_s {
+		uint64_t reserved_7_63:57;
+		uint64_t u2nc_bis:1;
+		uint64_t u2nf_bis:1;
+		uint64_t e2hc_bis:1;
+		uint64_t n2uf_bis:1;
+		uint64_t usbc_bis:1;
+		uint64_t nif_bis:1;
+		uint64_t nof_bis:1;
+	} s;
+	struct cvmx_usbnx_bist_status_cn30xx {
+		uint64_t reserved_3_63:61;
+		uint64_t usbc_bis:1;
+		uint64_t nif_bis:1;
+		uint64_t nof_bis:1;
+	} cn30xx;
+	struct cvmx_usbnx_bist_status_cn30xx cn31xx;
+	struct cvmx_usbnx_bist_status_s cn50xx;
+	struct cvmx_usbnx_bist_status_s cn52xx;
+	struct cvmx_usbnx_bist_status_s cn52xxp1;
+	struct cvmx_usbnx_bist_status_s cn56xx;
+	struct cvmx_usbnx_bist_status_s cn56xxp1;
+} cvmx_usbnx_bist_status_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_usbnx_clk_ctl_s {
+		uint64_t reserved_20_63:44;
+		uint64_t divide2:2;
+		uint64_t hclk_rst:1;
+		uint64_t p_x_on:1;
+		uint64_t reserved_14_15:2;
+		uint64_t p_com_on:1;
+		uint64_t p_c_sel:2;
+		uint64_t cdiv_byp:1;
+		uint64_t sd_mode:2;
+		uint64_t s_bist:1;
+		uint64_t por:1;
+		uint64_t enable:1;
+		uint64_t prst:1;
+		uint64_t hrst:1;
+		uint64_t divide:3;
+	} s;
+	struct cvmx_usbnx_clk_ctl_cn30xx {
+		uint64_t reserved_18_63:46;
+		uint64_t hclk_rst:1;
+		uint64_t p_x_on:1;
+		uint64_t p_rclk:1;
+		uint64_t p_xenbn:1;
+		uint64_t p_com_on:1;
+		uint64_t p_c_sel:2;
+		uint64_t cdiv_byp:1;
+		uint64_t sd_mode:2;
+		uint64_t s_bist:1;
+		uint64_t por:1;
+		uint64_t enable:1;
+		uint64_t prst:1;
+		uint64_t hrst:1;
+		uint64_t divide:3;
+	} cn30xx;
+	struct cvmx_usbnx_clk_ctl_cn30xx cn31xx;
+	struct cvmx_usbnx_clk_ctl_cn50xx {
+		uint64_t reserved_20_63:44;
+		uint64_t divide2:2;
+		uint64_t hclk_rst:1;
+		uint64_t reserved_16_16:1;
+		uint64_t p_rtype:2;
+		uint64_t p_com_on:1;
+		uint64_t p_c_sel:2;
+		uint64_t cdiv_byp:1;
+		uint64_t sd_mode:2;
+		uint64_t s_bist:1;
+		uint64_t por:1;
+		uint64_t enable:1;
+		uint64_t prst:1;
+		uint64_t hrst:1;
+		uint64_t divide:3;
+	} cn50xx;
+	struct cvmx_usbnx_clk_ctl_cn50xx cn52xx;
+	struct cvmx_usbnx_clk_ctl_cn50xx cn52xxp1;
+	struct cvmx_usbnx_clk_ctl_cn50xx cn56xx;
+	struct cvmx_usbnx_clk_ctl_cn50xx cn56xxp1;
+} cvmx_usbnx_clk_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_usbnx_ctl_status_s {
+		uint64_t reserved_6_63:58;
+		uint64_t dma_0pag:1;
+		uint64_t dma_stt:1;
+		uint64_t dma_test:1;
+		uint64_t inv_a2:1;
+		uint64_t l2c_emod:2;
+	} s;
+	struct cvmx_usbnx_ctl_status_s cn30xx;
+	struct cvmx_usbnx_ctl_status_s cn31xx;
+	struct cvmx_usbnx_ctl_status_s cn50xx;
+	struct cvmx_usbnx_ctl_status_s cn52xx;
+	struct cvmx_usbnx_ctl_status_s cn52xxp1;
+	struct cvmx_usbnx_ctl_status_s cn56xx;
+	struct cvmx_usbnx_ctl_status_s cn56xxp1;
+} cvmx_usbnx_ctl_status_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_inb_chn0_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_inb_chn0_s cn30xx;
+	struct cvmx_usbnx_dma0_inb_chn0_s cn31xx;
+	struct cvmx_usbnx_dma0_inb_chn0_s cn50xx;
+	struct cvmx_usbnx_dma0_inb_chn0_s cn52xx;
+	struct cvmx_usbnx_dma0_inb_chn0_s cn52xxp1;
+	struct cvmx_usbnx_dma0_inb_chn0_s cn56xx;
+	struct cvmx_usbnx_dma0_inb_chn0_s cn56xxp1;
+} cvmx_usbnx_dma0_inb_chn0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_inb_chn1_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_inb_chn1_s cn30xx;
+	struct cvmx_usbnx_dma0_inb_chn1_s cn31xx;
+	struct cvmx_usbnx_dma0_inb_chn1_s cn50xx;
+	struct cvmx_usbnx_dma0_inb_chn1_s cn52xx;
+	struct cvmx_usbnx_dma0_inb_chn1_s cn52xxp1;
+	struct cvmx_usbnx_dma0_inb_chn1_s cn56xx;
+	struct cvmx_usbnx_dma0_inb_chn1_s cn56xxp1;
+} cvmx_usbnx_dma0_inb_chn1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_inb_chn2_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_inb_chn2_s cn30xx;
+	struct cvmx_usbnx_dma0_inb_chn2_s cn31xx;
+	struct cvmx_usbnx_dma0_inb_chn2_s cn50xx;
+	struct cvmx_usbnx_dma0_inb_chn2_s cn52xx;
+	struct cvmx_usbnx_dma0_inb_chn2_s cn52xxp1;
+	struct cvmx_usbnx_dma0_inb_chn2_s cn56xx;
+	struct cvmx_usbnx_dma0_inb_chn2_s cn56xxp1;
+} cvmx_usbnx_dma0_inb_chn2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_inb_chn3_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_inb_chn3_s cn30xx;
+	struct cvmx_usbnx_dma0_inb_chn3_s cn31xx;
+	struct cvmx_usbnx_dma0_inb_chn3_s cn50xx;
+	struct cvmx_usbnx_dma0_inb_chn3_s cn52xx;
+	struct cvmx_usbnx_dma0_inb_chn3_s cn52xxp1;
+	struct cvmx_usbnx_dma0_inb_chn3_s cn56xx;
+	struct cvmx_usbnx_dma0_inb_chn3_s cn56xxp1;
+} cvmx_usbnx_dma0_inb_chn3_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_inb_chn4_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_inb_chn4_s cn30xx;
+	struct cvmx_usbnx_dma0_inb_chn4_s cn31xx;
+	struct cvmx_usbnx_dma0_inb_chn4_s cn50xx;
+	struct cvmx_usbnx_dma0_inb_chn4_s cn52xx;
+	struct cvmx_usbnx_dma0_inb_chn4_s cn52xxp1;
+	struct cvmx_usbnx_dma0_inb_chn4_s cn56xx;
+	struct cvmx_usbnx_dma0_inb_chn4_s cn56xxp1;
+} cvmx_usbnx_dma0_inb_chn4_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_inb_chn5_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_inb_chn5_s cn30xx;
+	struct cvmx_usbnx_dma0_inb_chn5_s cn31xx;
+	struct cvmx_usbnx_dma0_inb_chn5_s cn50xx;
+	struct cvmx_usbnx_dma0_inb_chn5_s cn52xx;
+	struct cvmx_usbnx_dma0_inb_chn5_s cn52xxp1;
+	struct cvmx_usbnx_dma0_inb_chn5_s cn56xx;
+	struct cvmx_usbnx_dma0_inb_chn5_s cn56xxp1;
+} cvmx_usbnx_dma0_inb_chn5_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_inb_chn6_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_inb_chn6_s cn30xx;
+	struct cvmx_usbnx_dma0_inb_chn6_s cn31xx;
+	struct cvmx_usbnx_dma0_inb_chn6_s cn50xx;
+	struct cvmx_usbnx_dma0_inb_chn6_s cn52xx;
+	struct cvmx_usbnx_dma0_inb_chn6_s cn52xxp1;
+	struct cvmx_usbnx_dma0_inb_chn6_s cn56xx;
+	struct cvmx_usbnx_dma0_inb_chn6_s cn56xxp1;
+} cvmx_usbnx_dma0_inb_chn6_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_inb_chn7_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_inb_chn7_s cn30xx;
+	struct cvmx_usbnx_dma0_inb_chn7_s cn31xx;
+	struct cvmx_usbnx_dma0_inb_chn7_s cn50xx;
+	struct cvmx_usbnx_dma0_inb_chn7_s cn52xx;
+	struct cvmx_usbnx_dma0_inb_chn7_s cn52xxp1;
+	struct cvmx_usbnx_dma0_inb_chn7_s cn56xx;
+	struct cvmx_usbnx_dma0_inb_chn7_s cn56xxp1;
+} cvmx_usbnx_dma0_inb_chn7_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_outb_chn0_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_outb_chn0_s cn30xx;
+	struct cvmx_usbnx_dma0_outb_chn0_s cn31xx;
+	struct cvmx_usbnx_dma0_outb_chn0_s cn50xx;
+	struct cvmx_usbnx_dma0_outb_chn0_s cn52xx;
+	struct cvmx_usbnx_dma0_outb_chn0_s cn52xxp1;
+	struct cvmx_usbnx_dma0_outb_chn0_s cn56xx;
+	struct cvmx_usbnx_dma0_outb_chn0_s cn56xxp1;
+} cvmx_usbnx_dma0_outb_chn0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_outb_chn1_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_outb_chn1_s cn30xx;
+	struct cvmx_usbnx_dma0_outb_chn1_s cn31xx;
+	struct cvmx_usbnx_dma0_outb_chn1_s cn50xx;
+	struct cvmx_usbnx_dma0_outb_chn1_s cn52xx;
+	struct cvmx_usbnx_dma0_outb_chn1_s cn52xxp1;
+	struct cvmx_usbnx_dma0_outb_chn1_s cn56xx;
+	struct cvmx_usbnx_dma0_outb_chn1_s cn56xxp1;
+} cvmx_usbnx_dma0_outb_chn1_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_outb_chn2_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_outb_chn2_s cn30xx;
+	struct cvmx_usbnx_dma0_outb_chn2_s cn31xx;
+	struct cvmx_usbnx_dma0_outb_chn2_s cn50xx;
+	struct cvmx_usbnx_dma0_outb_chn2_s cn52xx;
+	struct cvmx_usbnx_dma0_outb_chn2_s cn52xxp1;
+	struct cvmx_usbnx_dma0_outb_chn2_s cn56xx;
+	struct cvmx_usbnx_dma0_outb_chn2_s cn56xxp1;
+} cvmx_usbnx_dma0_outb_chn2_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_outb_chn3_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_outb_chn3_s cn30xx;
+	struct cvmx_usbnx_dma0_outb_chn3_s cn31xx;
+	struct cvmx_usbnx_dma0_outb_chn3_s cn50xx;
+	struct cvmx_usbnx_dma0_outb_chn3_s cn52xx;
+	struct cvmx_usbnx_dma0_outb_chn3_s cn52xxp1;
+	struct cvmx_usbnx_dma0_outb_chn3_s cn56xx;
+	struct cvmx_usbnx_dma0_outb_chn3_s cn56xxp1;
+} cvmx_usbnx_dma0_outb_chn3_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_outb_chn4_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_outb_chn4_s cn30xx;
+	struct cvmx_usbnx_dma0_outb_chn4_s cn31xx;
+	struct cvmx_usbnx_dma0_outb_chn4_s cn50xx;
+	struct cvmx_usbnx_dma0_outb_chn4_s cn52xx;
+	struct cvmx_usbnx_dma0_outb_chn4_s cn52xxp1;
+	struct cvmx_usbnx_dma0_outb_chn4_s cn56xx;
+	struct cvmx_usbnx_dma0_outb_chn4_s cn56xxp1;
+} cvmx_usbnx_dma0_outb_chn4_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_outb_chn5_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_outb_chn5_s cn30xx;
+	struct cvmx_usbnx_dma0_outb_chn5_s cn31xx;
+	struct cvmx_usbnx_dma0_outb_chn5_s cn50xx;
+	struct cvmx_usbnx_dma0_outb_chn5_s cn52xx;
+	struct cvmx_usbnx_dma0_outb_chn5_s cn52xxp1;
+	struct cvmx_usbnx_dma0_outb_chn5_s cn56xx;
+	struct cvmx_usbnx_dma0_outb_chn5_s cn56xxp1;
+} cvmx_usbnx_dma0_outb_chn5_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_outb_chn6_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_outb_chn6_s cn30xx;
+	struct cvmx_usbnx_dma0_outb_chn6_s cn31xx;
+	struct cvmx_usbnx_dma0_outb_chn6_s cn50xx;
+	struct cvmx_usbnx_dma0_outb_chn6_s cn52xx;
+	struct cvmx_usbnx_dma0_outb_chn6_s cn52xxp1;
+	struct cvmx_usbnx_dma0_outb_chn6_s cn56xx;
+	struct cvmx_usbnx_dma0_outb_chn6_s cn56xxp1;
+} cvmx_usbnx_dma0_outb_chn6_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_outb_chn7_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_outb_chn7_s cn30xx;
+	struct cvmx_usbnx_dma0_outb_chn7_s cn31xx;
+	struct cvmx_usbnx_dma0_outb_chn7_s cn50xx;
+	struct cvmx_usbnx_dma0_outb_chn7_s cn52xx;
+	struct cvmx_usbnx_dma0_outb_chn7_s cn52xxp1;
+	struct cvmx_usbnx_dma0_outb_chn7_s cn56xx;
+	struct cvmx_usbnx_dma0_outb_chn7_s cn56xxp1;
+} cvmx_usbnx_dma0_outb_chn7_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_usbnx_dma_test_s {
+		uint64_t reserved_40_63:24;
+		uint64_t done:1;
+		uint64_t req:1;
+		uint64_t f_addr:18;
+		uint64_t count:11;
+		uint64_t channel:5;
+		uint64_t burst:4;
+	} s;
+	struct cvmx_usbnx_dma_test_s cn30xx;
+	struct cvmx_usbnx_dma_test_s cn31xx;
+	struct cvmx_usbnx_dma_test_s cn50xx;
+	struct cvmx_usbnx_dma_test_s cn52xx;
+	struct cvmx_usbnx_dma_test_s cn52xxp1;
+	struct cvmx_usbnx_dma_test_s cn56xx;
+	struct cvmx_usbnx_dma_test_s cn56xxp1;
+} cvmx_usbnx_dma_test_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_usbnx_int_enb_s {
+		uint64_t reserved_38_63:26;
+		uint64_t nd4o_dpf:1;
+		uint64_t nd4o_dpe:1;
+		uint64_t nd4o_rpf:1;
+		uint64_t nd4o_rpe:1;
+		uint64_t ltl_f_pf:1;
+		uint64_t ltl_f_pe:1;
+		uint64_t u2n_c_pe:1;
+		uint64_t u2n_c_pf:1;
+		uint64_t u2n_d_pf:1;
+		uint64_t u2n_d_pe:1;
+		uint64_t n2u_pe:1;
+		uint64_t n2u_pf:1;
+		uint64_t uod_pf:1;
+		uint64_t uod_pe:1;
+		uint64_t rq_q3_e:1;
+		uint64_t rq_q3_f:1;
+		uint64_t rq_q2_e:1;
+		uint64_t rq_q2_f:1;
+		uint64_t rg_fi_f:1;
+		uint64_t rg_fi_e:1;
+		uint64_t l2_fi_f:1;
+		uint64_t l2_fi_e:1;
+		uint64_t l2c_a_f:1;
+		uint64_t l2c_s_e:1;
+		uint64_t dcred_f:1;
+		uint64_t dcred_e:1;
+		uint64_t lt_pu_f:1;
+		uint64_t lt_po_e:1;
+		uint64_t nt_pu_f:1;
+		uint64_t nt_po_e:1;
+		uint64_t pt_pu_f:1;
+		uint64_t pt_po_e:1;
+		uint64_t lr_pu_f:1;
+		uint64_t lr_po_e:1;
+		uint64_t nr_pu_f:1;
+		uint64_t nr_po_e:1;
+		uint64_t pr_pu_f:1;
+		uint64_t pr_po_e:1;
+	} s;
+	struct cvmx_usbnx_int_enb_s cn30xx;
+	struct cvmx_usbnx_int_enb_s cn31xx;
+	struct cvmx_usbnx_int_enb_cn50xx {
+		uint64_t reserved_38_63:26;
+		uint64_t nd4o_dpf:1;
+		uint64_t nd4o_dpe:1;
+		uint64_t nd4o_rpf:1;
+		uint64_t nd4o_rpe:1;
+		uint64_t ltl_f_pf:1;
+		uint64_t ltl_f_pe:1;
+		uint64_t reserved_26_31:6;
+		uint64_t uod_pf:1;
+		uint64_t uod_pe:1;
+		uint64_t rq_q3_e:1;
+		uint64_t rq_q3_f:1;
+		uint64_t rq_q2_e:1;
+		uint64_t rq_q2_f:1;
+		uint64_t rg_fi_f:1;
+		uint64_t rg_fi_e:1;
+		uint64_t l2_fi_f:1;
+		uint64_t l2_fi_e:1;
+		uint64_t l2c_a_f:1;
+		uint64_t l2c_s_e:1;
+		uint64_t dcred_f:1;
+		uint64_t dcred_e:1;
+		uint64_t lt_pu_f:1;
+		uint64_t lt_po_e:1;
+		uint64_t nt_pu_f:1;
+		uint64_t nt_po_e:1;
+		uint64_t pt_pu_f:1;
+		uint64_t pt_po_e:1;
+		uint64_t lr_pu_f:1;
+		uint64_t lr_po_e:1;
+		uint64_t nr_pu_f:1;
+		uint64_t nr_po_e:1;
+		uint64_t pr_pu_f:1;
+		uint64_t pr_po_e:1;
+	} cn50xx;
+	struct cvmx_usbnx_int_enb_cn50xx cn52xx;
+	struct cvmx_usbnx_int_enb_cn50xx cn52xxp1;
+	struct cvmx_usbnx_int_enb_cn50xx cn56xx;
+	struct cvmx_usbnx_int_enb_cn50xx cn56xxp1;
+} cvmx_usbnx_int_enb_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_usbnx_int_sum_s {
+		uint64_t reserved_38_63:26;
+		uint64_t nd4o_dpf:1;
+		uint64_t nd4o_dpe:1;
+		uint64_t nd4o_rpf:1;
+		uint64_t nd4o_rpe:1;
+		uint64_t ltl_f_pf:1;
+		uint64_t ltl_f_pe:1;
+		uint64_t u2n_c_pe:1;
+		uint64_t u2n_c_pf:1;
+		uint64_t u2n_d_pf:1;
+		uint64_t u2n_d_pe:1;
+		uint64_t n2u_pe:1;
+		uint64_t n2u_pf:1;
+		uint64_t uod_pf:1;
+		uint64_t uod_pe:1;
+		uint64_t rq_q3_e:1;
+		uint64_t rq_q3_f:1;
+		uint64_t rq_q2_e:1;
+		uint64_t rq_q2_f:1;
+		uint64_t rg_fi_f:1;
+		uint64_t rg_fi_e:1;
+		uint64_t lt_fi_f:1;
+		uint64_t lt_fi_e:1;
+		uint64_t l2c_a_f:1;
+		uint64_t l2c_s_e:1;
+		uint64_t dcred_f:1;
+		uint64_t dcred_e:1;
+		uint64_t lt_pu_f:1;
+		uint64_t lt_po_e:1;
+		uint64_t nt_pu_f:1;
+		uint64_t nt_po_e:1;
+		uint64_t pt_pu_f:1;
+		uint64_t pt_po_e:1;
+		uint64_t lr_pu_f:1;
+		uint64_t lr_po_e:1;
+		uint64_t nr_pu_f:1;
+		uint64_t nr_po_e:1;
+		uint64_t pr_pu_f:1;
+		uint64_t pr_po_e:1;
+	} s;
+	struct cvmx_usbnx_int_sum_s cn30xx;
+	struct cvmx_usbnx_int_sum_s cn31xx;
+	struct cvmx_usbnx_int_sum_cn50xx {
+		uint64_t reserved_38_63:26;
+		uint64_t nd4o_dpf:1;
+		uint64_t nd4o_dpe:1;
+		uint64_t nd4o_rpf:1;
+		uint64_t nd4o_rpe:1;
+		uint64_t ltl_f_pf:1;
+		uint64_t ltl_f_pe:1;
+		uint64_t reserved_26_31:6;
+		uint64_t uod_pf:1;
+		uint64_t uod_pe:1;
+		uint64_t rq_q3_e:1;
+		uint64_t rq_q3_f:1;
+		uint64_t rq_q2_e:1;
+		uint64_t rq_q2_f:1;
+		uint64_t rg_fi_f:1;
+		uint64_t rg_fi_e:1;
+		uint64_t lt_fi_f:1;
+		uint64_t lt_fi_e:1;
+		uint64_t l2c_a_f:1;
+		uint64_t l2c_s_e:1;
+		uint64_t dcred_f:1;
+		uint64_t dcred_e:1;
+		uint64_t lt_pu_f:1;
+		uint64_t lt_po_e:1;
+		uint64_t nt_pu_f:1;
+		uint64_t nt_po_e:1;
+		uint64_t pt_pu_f:1;
+		uint64_t pt_po_e:1;
+		uint64_t lr_pu_f:1;
+		uint64_t lr_po_e:1;
+		uint64_t nr_pu_f:1;
+		uint64_t nr_po_e:1;
+		uint64_t pr_pu_f:1;
+		uint64_t pr_po_e:1;
+	} cn50xx;
+	struct cvmx_usbnx_int_sum_cn50xx cn52xx;
+	struct cvmx_usbnx_int_sum_cn50xx cn52xxp1;
+	struct cvmx_usbnx_int_sum_cn50xx cn56xx;
+	struct cvmx_usbnx_int_sum_cn50xx cn56xxp1;
+} cvmx_usbnx_int_sum_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_usbnx_usbp_ctl_status_s {
+		uint64_t txrisetune:1;
+		uint64_t txvreftune:4;
+		uint64_t txfslstune:4;
+		uint64_t txhsxvtune:2;
+		uint64_t sqrxtune:3;
+		uint64_t compdistune:3;
+		uint64_t otgtune:3;
+		uint64_t otgdisable:1;
+		uint64_t portreset:1;
+		uint64_t drvvbus:1;
+		uint64_t lsbist:1;
+		uint64_t fsbist:1;
+		uint64_t hsbist:1;
+		uint64_t bist_done:1;
+		uint64_t bist_err:1;
+		uint64_t tdata_out:4;
+		uint64_t siddq:1;
+		uint64_t txpreemphasistune:1;
+		uint64_t dma_bmode:1;
+		uint64_t usbc_end:1;
+		uint64_t usbp_bist:1;
+		uint64_t tclk:1;
+		uint64_t dp_pulld:1;
+		uint64_t dm_pulld:1;
+		uint64_t hst_mode:1;
+		uint64_t tuning:4;
+		uint64_t tx_bs_enh:1;
+		uint64_t tx_bs_en:1;
+		uint64_t loop_enb:1;
+		uint64_t vtest_enb:1;
+		uint64_t bist_enb:1;
+		uint64_t tdata_sel:1;
+		uint64_t taddr_in:4;
+		uint64_t tdata_in:8;
+		uint64_t ate_reset:1;
+	} s;
+	struct cvmx_usbnx_usbp_ctl_status_cn30xx {
+		uint64_t reserved_38_63:26;
+		uint64_t bist_done:1;
+		uint64_t bist_err:1;
+		uint64_t tdata_out:4;
+		uint64_t reserved_30_31:2;
+		uint64_t dma_bmode:1;
+		uint64_t usbc_end:1;
+		uint64_t usbp_bist:1;
+		uint64_t tclk:1;
+		uint64_t dp_pulld:1;
+		uint64_t dm_pulld:1;
+		uint64_t hst_mode:1;
+		uint64_t tuning:4;
+		uint64_t tx_bs_enh:1;
+		uint64_t tx_bs_en:1;
+		uint64_t loop_enb:1;
+		uint64_t vtest_enb:1;
+		uint64_t bist_enb:1;
+		uint64_t tdata_sel:1;
+		uint64_t taddr_in:4;
+		uint64_t tdata_in:8;
+		uint64_t ate_reset:1;
+	} cn30xx;
+	struct cvmx_usbnx_usbp_ctl_status_cn30xx cn31xx;
+	struct cvmx_usbnx_usbp_ctl_status_cn50xx {
+		uint64_t txrisetune:1;
+		uint64_t txvreftune:4;
+		uint64_t txfslstune:4;
+		uint64_t txhsxvtune:2;
+		uint64_t sqrxtune:3;
+		uint64_t compdistune:3;
+		uint64_t otgtune:3;
+		uint64_t otgdisable:1;
+		uint64_t portreset:1;
+		uint64_t drvvbus:1;
+		uint64_t lsbist:1;
+		uint64_t fsbist:1;
+		uint64_t hsbist:1;
+		uint64_t bist_done:1;
+		uint64_t bist_err:1;
+		uint64_t tdata_out:4;
+		uint64_t reserved_31_31:1;
+		uint64_t txpreemphasistune:1;
+		uint64_t dma_bmode:1;
+		uint64_t usbc_end:1;
+		uint64_t usbp_bist:1;
+		uint64_t tclk:1;
+		uint64_t dp_pulld:1;
+		uint64_t dm_pulld:1;
+		uint64_t hst_mode:1;
+		uint64_t reserved_19_22:4;
+		uint64_t tx_bs_enh:1;
+		uint64_t tx_bs_en:1;
+		uint64_t loop_enb:1;
+		uint64_t vtest_enb:1;
+		uint64_t bist_enb:1;
+		uint64_t tdata_sel:1;
+		uint64_t taddr_in:4;
+		uint64_t tdata_in:8;
+		uint64_t ate_reset:1;
+	} cn50xx;
+	struct cvmx_usbnx_usbp_ctl_status_cn50xx cn52xx;
+	struct cvmx_usbnx_usbp_ctl_status_cn50xx cn52xxp1;
+	struct cvmx_usbnx_usbp_ctl_status_cn56xx {
+		uint64_t txrisetune:1;
+		uint64_t txvreftune:4;
+		uint64_t txfslstune:4;
+		uint64_t txhsxvtune:2;
+		uint64_t sqrxtune:3;
+		uint64_t compdistune:3;
+		uint64_t otgtune:3;
+		uint64_t otgdisable:1;
+		uint64_t portreset:1;
+		uint64_t drvvbus:1;
+		uint64_t lsbist:1;
+		uint64_t fsbist:1;
+		uint64_t hsbist:1;
+		uint64_t bist_done:1;
+		uint64_t bist_err:1;
+		uint64_t tdata_out:4;
+		uint64_t siddq:1;
+		uint64_t txpreemphasistune:1;
+		uint64_t dma_bmode:1;
+		uint64_t usbc_end:1;
+		uint64_t usbp_bist:1;
+		uint64_t tclk:1;
+		uint64_t dp_pulld:1;
+		uint64_t dm_pulld:1;
+		uint64_t hst_mode:1;
+		uint64_t reserved_19_22:4;
+		uint64_t tx_bs_enh:1;
+		uint64_t tx_bs_en:1;
+		uint64_t loop_enb:1;
+		uint64_t vtest_enb:1;
+		uint64_t bist_enb:1;
+		uint64_t tdata_sel:1;
+		uint64_t taddr_in:4;
+		uint64_t tdata_in:8;
+		uint64_t ate_reset:1;
+	} cn56xx;
+	struct cvmx_usbnx_usbp_ctl_status_cn50xx cn56xxp1;
+} cvmx_usbnx_usbp_ctl_status_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_zip_cmd_bist_result_s {
+		uint64_t reserved_31_63:33;
+		uint64_t zip_core:27;
+		uint64_t zip_ctl:4;
+	} s;
+	struct cvmx_zip_cmd_bist_result_s cn31xx;
+	struct cvmx_zip_cmd_bist_result_s cn38xx;
+	struct cvmx_zip_cmd_bist_result_s cn38xxp2;
+	struct cvmx_zip_cmd_bist_result_s cn56xx;
+	struct cvmx_zip_cmd_bist_result_s cn56xxp1;
+	struct cvmx_zip_cmd_bist_result_s cn58xx;
+	struct cvmx_zip_cmd_bist_result_s cn58xxp1;
+} cvmx_zip_cmd_bist_result_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_zip_cmd_buf_s {
+		uint64_t reserved_58_63:6;
+		uint64_t dwb:9;
+		uint64_t pool:3;
+		uint64_t size:13;
+		uint64_t ptr:33;
+	} s;
+	struct cvmx_zip_cmd_buf_s cn31xx;
+	struct cvmx_zip_cmd_buf_s cn38xx;
+	struct cvmx_zip_cmd_buf_s cn38xxp2;
+	struct cvmx_zip_cmd_buf_s cn56xx;
+	struct cvmx_zip_cmd_buf_s cn56xxp1;
+	struct cvmx_zip_cmd_buf_s cn58xx;
+	struct cvmx_zip_cmd_buf_s cn58xxp1;
+} cvmx_zip_cmd_buf_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_zip_cmd_ctl_s {
+		uint64_t reserved_2_63:62;
+		uint64_t forceclk:1;
+		uint64_t reset:1;
+	} s;
+	struct cvmx_zip_cmd_ctl_s cn31xx;
+	struct cvmx_zip_cmd_ctl_s cn38xx;
+	struct cvmx_zip_cmd_ctl_s cn38xxp2;
+	struct cvmx_zip_cmd_ctl_s cn56xx;
+	struct cvmx_zip_cmd_ctl_s cn56xxp1;
+	struct cvmx_zip_cmd_ctl_s cn58xx;
+	struct cvmx_zip_cmd_ctl_s cn58xxp1;
+} cvmx_zip_cmd_ctl_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_zip_constants_s {
+		uint64_t reserved_48_63:16;
+		uint64_t depth:16;
+		uint64_t onfsize:12;
+		uint64_t ctxsize:12;
+		uint64_t reserved_1_7:7;
+		uint64_t disabled:1;
+	} s;
+	struct cvmx_zip_constants_s cn31xx;
+	struct cvmx_zip_constants_s cn38xx;
+	struct cvmx_zip_constants_s cn38xxp2;
+	struct cvmx_zip_constants_s cn56xx;
+	struct cvmx_zip_constants_s cn56xxp1;
+	struct cvmx_zip_constants_s cn58xx;
+	struct cvmx_zip_constants_s cn58xxp1;
+} cvmx_zip_constants_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_zip_debug0_s {
+		uint64_t reserved_14_63:50;
+		uint64_t asserts:14;
+	} s;
+	struct cvmx_zip_debug0_s cn31xx;
+	struct cvmx_zip_debug0_s cn38xx;
+	struct cvmx_zip_debug0_s cn38xxp2;
+	struct cvmx_zip_debug0_s cn56xx;
+	struct cvmx_zip_debug0_s cn56xxp1;
+	struct cvmx_zip_debug0_s cn58xx;
+	struct cvmx_zip_debug0_s cn58xxp1;
+} cvmx_zip_debug0_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_zip_error_s {
+		uint64_t reserved_1_63:63;
+		uint64_t doorbell:1;
+	} s;
+	struct cvmx_zip_error_s cn31xx;
+	struct cvmx_zip_error_s cn38xx;
+	struct cvmx_zip_error_s cn38xxp2;
+	struct cvmx_zip_error_s cn56xx;
+	struct cvmx_zip_error_s cn56xxp1;
+	struct cvmx_zip_error_s cn58xx;
+	struct cvmx_zip_error_s cn58xxp1;
+} cvmx_zip_error_t;
+
+typedef union {
+	uint64_t u64;
+	struct cvmx_zip_int_mask_s {
+		uint64_t reserved_1_63:63;
+		uint64_t doorbell:1;
+	} s;
+	struct cvmx_zip_int_mask_s cn31xx;
+	struct cvmx_zip_int_mask_s cn38xx;
+	struct cvmx_zip_int_mask_s cn38xxp2;
+	struct cvmx_zip_int_mask_s cn56xx;
+	struct cvmx_zip_int_mask_s cn56xxp1;
+	struct cvmx_zip_int_mask_s cn58xx;
+	struct cvmx_zip_int_mask_s cn58xxp1;
+} cvmx_zip_int_mask_t;
+#endif
diff --git a/arch/mips/cavium-octeon/executive/cvmx-csr.h b/arch/mips/cavium-octeon/executive/cvmx-csr.h
new file mode 100644
index 0000000..d363145
--- /dev/null
+++ b/arch/mips/cavium-octeon/executive/cvmx-csr.h
@@ -0,0 +1,199 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
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
+/**
+ * @file
+ *
+ * Configuration and status register (CSR) address and type definitions for
+ * Octoen.
+ *
+ */
+#ifndef __CVMX_CSR_H__
+#define __CVMX_CSR_H__
+
+
+#include "cvmx-platform.h"
+#include "cvmx-csr-enums.h"
+#include "cvmx-csr-addresses.h"
+#include "cvmx-csr-typedefs.h"
+
+/* Map the HW names to the SDK historical names */
+typedef cvmx_ciu_intx_en1_t cvmx_ciu_int1_t;
+typedef cvmx_ciu_intx_sum0_t cvmx_ciu_intx0_t;
+typedef cvmx_ciu_mbox_setx_t cvmx_ciu_mbox_t;
+typedef cvmx_fpa_fpfx_marks_t cvmx_fpa_fpf_marks_t;
+typedef cvmx_fpa_quex_page_index_t cvmx_fpa_que0_page_index_t;
+typedef cvmx_fpa_quex_page_index_t cvmx_fpa_que1_page_index_t;
+typedef cvmx_fpa_quex_page_index_t cvmx_fpa_que2_page_index_t;
+typedef cvmx_fpa_quex_page_index_t cvmx_fpa_que3_page_index_t;
+typedef cvmx_fpa_quex_page_index_t cvmx_fpa_que4_page_index_t;
+typedef cvmx_fpa_quex_page_index_t cvmx_fpa_que5_page_index_t;
+typedef cvmx_fpa_quex_page_index_t cvmx_fpa_que6_page_index_t;
+typedef cvmx_fpa_quex_page_index_t cvmx_fpa_que7_page_index_t;
+typedef cvmx_ipd_1st_mbuff_skip_t cvmx_ipd_mbuff_first_skip_t;
+typedef cvmx_ipd_1st_next_ptr_back_t cvmx_ipd_first_next_ptr_back_t;
+typedef cvmx_ipd_packet_mbuff_size_t cvmx_ipd_mbuff_size_t;
+typedef cvmx_ipd_qosx_red_marks_t cvmx_ipd_qos_red_marks_t;
+typedef cvmx_ipd_wqe_fpa_queue_t cvmx_ipd_wqe_fpa_pool_t;
+typedef cvmx_l2c_pfcx_t cvmx_l2c_pfc0_t;
+typedef cvmx_l2c_pfcx_t cvmx_l2c_pfc1_t;
+typedef cvmx_l2c_pfcx_t cvmx_l2c_pfc2_t;
+typedef cvmx_l2c_pfcx_t cvmx_l2c_pfc3_t;
+typedef cvmx_lmcx_bist_ctl_t cvmx_lmc_bist_ctl_t;
+typedef cvmx_lmcx_bist_result_t cvmx_lmc_bist_result_t;
+typedef cvmx_lmcx_comp_ctl_t cvmx_lmc_comp_ctl_t;
+typedef cvmx_lmcx_ctl_t cvmx_lmc_ctl_t;
+typedef cvmx_lmcx_ctl1_t cvmx_lmc_ctl1_t;
+typedef cvmx_lmcx_dclk_cnt_hi_t cvmx_lmc_dclk_cnt_hi_t;
+typedef cvmx_lmcx_dclk_cnt_lo_t cvmx_lmc_dclk_cnt_lo_t;
+typedef cvmx_lmcx_dclk_ctl_t cvmx_lmc_dclk_ctl_t;
+typedef cvmx_lmcx_ddr2_ctl_t cvmx_lmc_ddr2_ctl_t;
+typedef cvmx_lmcx_delay_cfg_t cvmx_lmc_delay_cfg_t;
+typedef cvmx_lmcx_dll_ctl_t cvmx_lmc_dll_ctl_t;
+typedef cvmx_lmcx_dual_memcfg_t cvmx_lmc_dual_memcfg_t;
+typedef cvmx_lmcx_ecc_synd_t cvmx_lmc_ecc_synd_t;
+typedef cvmx_lmcx_fadr_t cvmx_lmc_fadr_t;
+typedef cvmx_lmcx_ifb_cnt_hi_t cvmx_lmc_ifb_cnt_hi_t;
+typedef cvmx_lmcx_ifb_cnt_lo_t cvmx_lmc_ifb_cnt_lo_t;
+typedef cvmx_lmcx_mem_cfg0_t cvmx_lmc_mem_cfg0_t;
+typedef cvmx_lmcx_mem_cfg1_t cvmx_lmc_mem_cfg1_t;
+typedef cvmx_lmcx_wodt_ctl0_t cvmx_lmc_odt_ctl_t;
+typedef cvmx_lmcx_ops_cnt_hi_t cvmx_lmc_ops_cnt_hi_t;
+typedef cvmx_lmcx_ops_cnt_lo_t cvmx_lmc_ops_cnt_lo_t;
+typedef cvmx_lmcx_pll_bwctl_t cvmx_lmc_pll_bwctl_t;
+typedef cvmx_lmcx_pll_ctl_t cvmx_lmc_pll_ctl_t;
+typedef cvmx_lmcx_pll_status_t cvmx_lmc_pll_status_t;
+typedef cvmx_lmcx_read_level_ctl_t cvmx_lmc_read_level_ctl_t;
+typedef cvmx_lmcx_read_level_dbg_t cvmx_lmc_read_level_dbg_t;
+typedef cvmx_lmcx_read_level_rankx_t cvmx_lmc_read_level_rankx_t;
+typedef cvmx_lmcx_rodt_comp_ctl_t cvmx_lmc_rodt_comp_ctl_t;
+typedef cvmx_lmcx_rodt_ctl_t cvmx_lmc_rodt_ctl_t;
+typedef cvmx_lmcx_wodt_ctl0_t cvmx_lmc_wodt_ctl_t;
+typedef cvmx_lmcx_wodt_ctl0_t cvmx_lmc_wodt_ctl0_t;
+typedef cvmx_lmcx_wodt_ctl1_t cvmx_lmc_wodt_ctl1_t;
+typedef cvmx_mio_boot_reg_cfgx_t cvmx_mio_boot_reg_cfg0_t;
+typedef cvmx_mio_boot_reg_timx_t cvmx_mio_boot_reg_tim0_t;
+typedef cvmx_mio_twsx_int_t cvmx_mio_tws_int_t;
+typedef cvmx_mio_twsx_sw_twsi_t cvmx_mio_tws_sw_twsi_t;
+typedef cvmx_mio_twsx_sw_twsi_ext_t cvmx_mio_tws_sw_twsi_ext_t;
+typedef cvmx_mio_twsx_twsi_sw_t cvmx_mio_tws_twsi_sw_t;
+typedef cvmx_npi_base_addr_inputx_t cvmx_npi_base_addr_input_t;
+typedef cvmx_npi_base_addr_outputx_t cvmx_npi_base_addr_output_t;
+typedef cvmx_npi_buff_size_outputx_t cvmx_npi_buff_size_output_t;
+typedef cvmx_npi_dma_highp_counts_t cvmx_npi_dma_counts_t;
+typedef cvmx_npi_dma_highp_naddr_t cvmx_npi_dma_naddr_t;
+typedef cvmx_npi_highp_dbell_t cvmx_npi_dbell_t;
+typedef cvmx_npi_highp_ibuff_saddr_t cvmx_npi_dma_ibuff_saddr_t;
+typedef cvmx_npi_mem_access_subidx_t cvmx_npi_mem_access_subid_t;
+typedef cvmx_npi_num_desc_outputx_t cvmx_npi_num_desc_output_t;
+typedef cvmx_npi_px_dbpair_addr_t cvmx_npi_dbpair_addr_t;
+typedef cvmx_npi_px_instr_addr_t cvmx_npi_instr_addr_t;
+typedef cvmx_npi_px_instr_cnts_t cvmx_npi_instr_cnts_t;
+typedef cvmx_npi_px_pair_cnts_t cvmx_npi_pair_cnts_t;
+typedef cvmx_npi_size_inputx_t cvmx_npi_size_input_t;
+typedef cvmx_pci_dbellx_t cvmx_pci_dbell_t;
+typedef cvmx_pci_dma_cntx_t cvmx_pci_dma_cnt_t;
+typedef cvmx_pci_dma_int_levx_t cvmx_pci_dma_int_lev_t;
+typedef cvmx_pci_dma_timex_t cvmx_pci_dma_time_t;
+typedef cvmx_pci_instr_countx_t cvmx_pci_instr_count_t;
+typedef cvmx_pci_pkt_creditsx_t cvmx_pci_pkt_credits_t;
+typedef cvmx_pci_pkts_sent_int_levx_t cvmx_pci_pkts_sent_int_lev_t;
+typedef cvmx_pci_pkts_sent_timex_t cvmx_pci_pkts_sent_time_t;
+typedef cvmx_pci_pkts_sentx_t cvmx_pci_pkts_sent_t;
+typedef cvmx_pip_prt_cfgx_t cvmx_pip_port_cfg_t;
+typedef cvmx_pip_prt_tagx_t cvmx_pip_port_tag_cfg_t;
+typedef cvmx_pip_qos_watchx_t cvmx_pip_port_watcher_cfg_t;
+typedef cvmx_pko_mem_queue_ptrs_t cvmx_pko_queue_cfg_t;
+typedef cvmx_pko_reg_cmd_buf_t cvmx_pko_pool_cfg_t;
+typedef cvmx_smix_clk_t cvmx_smi_clk_t;
+typedef cvmx_smix_cmd_t cvmx_smi_cmd_t;
+typedef cvmx_smix_en_t cvmx_smi_en_t;
+typedef cvmx_smix_rd_dat_t cvmx_smi_rd_dat_t;
+typedef cvmx_smix_wr_dat_t cvmx_smi_wr_dat_t;
+typedef cvmx_tim_reg_flags_t cvmx_tim_control_t;
+
+/* The CSRs for bootbus region zero used to be independent of the
+    other 1-7. As of SDK 1.7.0 these were combined. These macros
+    are for backwards compactability */
+#define CVMX_MIO_BOOT_REG_CFG0		CVMX_MIO_BOOT_REG_CFGX(0)
+#define CVMX_MIO_BOOT_REG_TIM0		CVMX_MIO_BOOT_REG_TIMX(0)
+
+/* The CN3XXX and CN58XX chips use to not have a LMC number
+    passed to the address macros. These are here to supply backwards
+    compatability with old code. Code should really use the new addresses
+    with bus arguments for support on other chips */
+#define CVMX_LMC_BIST_CTL               CVMX_LMCX_BIST_CTL(0)
+#define CVMX_LMC_BIST_RESULT            CVMX_LMCX_BIST_RESULT(0)
+#define CVMX_LMC_COMP_CTL               CVMX_LMCX_COMP_CTL(0)
+#define CVMX_LMC_CTL                    CVMX_LMCX_CTL(0)
+#define CVMX_LMC_CTL1                   CVMX_LMCX_CTL1(0)
+#define CVMX_LMC_DCLK_CNT_HI            CVMX_LMCX_DCLK_CNT_HI(0)
+#define CVMX_LMC_DCLK_CNT_LO            CVMX_LMCX_DCLK_CNT_LO(0)
+#define CVMX_LMC_DCLK_CTL               CVMX_LMCX_DCLK_CTL(0)
+#define CVMX_LMC_DDR2_CTL               CVMX_LMCX_DDR2_CTL(0)
+#define CVMX_LMC_DELAY_CFG              CVMX_LMCX_DELAY_CFG(0)
+#define CVMX_LMC_DLL_CTL                CVMX_LMCX_DLL_CTL(0)
+#define CVMX_LMC_DUAL_MEMCFG            CVMX_LMCX_DUAL_MEMCFG(0)
+#define CVMX_LMC_ECC_SYND               CVMX_LMCX_ECC_SYND(0)
+#define CVMX_LMC_FADR                   CVMX_LMCX_FADR(0)
+#define CVMX_LMC_IFB_CNT_HI             CVMX_LMCX_IFB_CNT_HI(0)
+#define CVMX_LMC_IFB_CNT_LO             CVMX_LMCX_IFB_CNT_LO(0)
+#define CVMX_LMC_MEM_CFG0               CVMX_LMCX_MEM_CFG0(0)
+#define CVMX_LMC_MEM_CFG1               CVMX_LMCX_MEM_CFG1(0)
+#define CVMX_LMC_OPS_CNT_HI             CVMX_LMCX_OPS_CNT_HI(0)
+#define CVMX_LMC_OPS_CNT_LO             CVMX_LMCX_OPS_CNT_LO(0)
+#define CVMX_LMC_PLL_BWCTL              CVMX_LMCX_PLL_BWCTL(0)
+#define CVMX_LMC_PLL_CTL                CVMX_LMCX_PLL_CTL(0)
+#define CVMX_LMC_PLL_STATUS             CVMX_LMCX_PLL_STATUS(0)
+#define CVMX_LMC_READ_LEVEL_CTL         CVMX_LMCX_READ_LEVEL_CTL(0)
+#define CVMX_LMC_READ_LEVEL_DBG         CVMX_LMCX_READ_LEVEL_DBG(0)
+#define CVMX_LMC_READ_LEVEL_RANKX       CVMX_LMCX_READ_LEVEL_RANKX(0)
+#define CVMX_LMC_RODT_COMP_CTL          CVMX_LMCX_RODT_COMP_CTL(0)
+#define CVMX_LMC_RODT_CTL               CVMX_LMCX_RODT_CTL(0)
+#define CVMX_LMC_WODT_CTL               CVMX_LMCX_WODT_CTL0(0)
+#define CVMX_LMC_WODT_CTL0              CVMX_LMCX_WODT_CTL0(0)
+#define CVMX_LMC_WODT_CTL1              CVMX_LMCX_WODT_CTL1(0)
+
+/* The CN3XXX and CN58XX chips use to not have a TWSI bus number
+    passed to the address macros. These are here to supply backwards
+    compatability with old code. Code should really use the new addresses
+    with bus arguments for support on other chips */
+#define CVMX_MIO_TWS_INT            CVMX_MIO_TWSX_INT(0)
+#define CVMX_MIO_TWS_SW_TWSI        CVMX_MIO_TWSX_SW_TWSI(0)
+#define CVMX_MIO_TWS_SW_TWSI_EXT    CVMX_MIO_TWSX_SW_TWSI_EXT(0)
+#define CVMX_MIO_TWS_TWSI_SW        CVMX_MIO_TWSX_TWSI_SW(0)
+
+/* The CN3XXX and CN58XX chips use to not have a SMI/MDIO bus number
+    passed to the address macros. These are here to supply backwards
+    compatability with old code. Code should really use the new addresses
+    with bus arguments for support on other chips */
+#define CVMX_SMI_CLK    CVMX_SMIX_CLK(0)
+#define CVMX_SMI_CMD    CVMX_SMIX_CMD(0)
+#define CVMX_SMI_EN     CVMX_SMIX_EN(0)
+#define CVMX_SMI_RD_DAT CVMX_SMIX_RD_DAT(0)
+#define CVMX_SMI_WR_DAT CVMX_SMIX_WR_DAT(0)
+
+#endif /* __CVMX_CSR_H__ */
-- 
1.5.6.5
