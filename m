Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 00:48:45 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:61286 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903747Ab1KOXqb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Nov 2011 00:46:31 +0100
Received: by ggnb1 with SMTP id b1so563251ggn.36
        for <multiple recipients>; Tue, 15 Nov 2011 15:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=aX5Dm7dkNpRU6fdm/0JomHReRr2qXHA4mUx1Aa/NWe4=;
        b=rXraCWCTPXqh39BzktNFstQ7hV69Vx8T52ka0bm1/5MT0MoBYer1rTu/6/8luXlgjO
         cLdJWEtrZXRjlVG/rwycuAiqpU4GCuJu3bsLrh2vxx045yPtGt9REhrWcyiqzqqhVRte
         Qr3Gg6s6LFTZT9c9dmZcKvmb8kS2vSwW5d7+k=
Received: by 10.101.152.10 with SMTP id e10mr8804936ano.97.1321400782963;
        Tue, 15 Nov 2011 15:46:22 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id y1sm32530466anj.18.2011.11.15.15.46.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Nov 2011 15:46:20 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAFNkI8B032394;
        Tue, 15 Nov 2011 15:46:18 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAFNkI9G032393;
        Tue, 15 Nov 2011 15:46:18 -0800
From:   ddaney.cavm@gmail.com
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 1/5] MIPS: Octeon: Update SOC PCI related register definitions for new chips.
Date:   Tue, 15 Nov 2011 15:46:11 -0800
Message-Id: <1321400775-32353-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1321400775-32353-1-git-send-email-ddaney.cavm@gmail.com>
References: <1321400775-32353-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 31620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12948

From: David Daney <david.daney@cavium.com>

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/octeon/cvmx-dpi-defs.h     |  643 +++++++
 arch/mips/include/asm/octeon/cvmx-npei-defs.h    |    4 +-
 arch/mips/include/asm/octeon/cvmx-pciercx-defs.h |  609 ++++++-
 arch/mips/include/asm/octeon/cvmx-pemx-defs.h    |  509 +++++
 arch/mips/include/asm/octeon/cvmx-pexp-defs.h    |   19 +-
 arch/mips/include/asm/octeon/cvmx-sli-defs.h     | 2172 ++++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx-sriox-defs.h   | 1036 +++++++++++
 7 files changed, 4909 insertions(+), 83 deletions(-)
 create mode 100644 arch/mips/include/asm/octeon/cvmx-dpi-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-pemx-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-sli-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-sriox-defs.h

diff --git a/arch/mips/include/asm/octeon/cvmx-dpi-defs.h b/arch/mips/include/asm/octeon/cvmx-dpi-defs.h
new file mode 100644
index 0000000..c34ad04
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-dpi-defs.h
@@ -0,0 +1,643 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2011 Cavium Networks
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
+#ifndef __CVMX_DPI_DEFS_H__
+#define __CVMX_DPI_DEFS_H__
+
+#define CVMX_DPI_BIST_STATUS (CVMX_ADD_IO_SEG(0x0001DF0000000000ull))
+#define CVMX_DPI_CTL (CVMX_ADD_IO_SEG(0x0001DF0000000040ull))
+#define CVMX_DPI_DMAX_COUNTS(offset) (CVMX_ADD_IO_SEG(0x0001DF0000000300ull) + ((offset) & 7) * 8)
+#define CVMX_DPI_DMAX_DBELL(offset) (CVMX_ADD_IO_SEG(0x0001DF0000000200ull) + ((offset) & 7) * 8)
+#define CVMX_DPI_DMAX_ERR_RSP_STATUS(offset) (CVMX_ADD_IO_SEG(0x0001DF0000000A80ull) + ((offset) & 7) * 8)
+#define CVMX_DPI_DMAX_IBUFF_SADDR(offset) (CVMX_ADD_IO_SEG(0x0001DF0000000280ull) + ((offset) & 7) * 8)
+#define CVMX_DPI_DMAX_IFLIGHT(offset) (CVMX_ADD_IO_SEG(0x0001DF0000000A00ull) + ((offset) & 7) * 8)
+#define CVMX_DPI_DMAX_NADDR(offset) (CVMX_ADD_IO_SEG(0x0001DF0000000380ull) + ((offset) & 7) * 8)
+#define CVMX_DPI_DMAX_REQBNK0(offset) (CVMX_ADD_IO_SEG(0x0001DF0000000400ull) + ((offset) & 7) * 8)
+#define CVMX_DPI_DMAX_REQBNK1(offset) (CVMX_ADD_IO_SEG(0x0001DF0000000480ull) + ((offset) & 7) * 8)
+#define CVMX_DPI_DMA_CONTROL (CVMX_ADD_IO_SEG(0x0001DF0000000048ull))
+#define CVMX_DPI_DMA_ENGX_EN(offset) (CVMX_ADD_IO_SEG(0x0001DF0000000080ull) + ((offset) & 7) * 8)
+#define CVMX_DPI_DMA_PPX_CNT(offset) (CVMX_ADD_IO_SEG(0x0001DF0000000B00ull) + ((offset) & 31) * 8)
+#define CVMX_DPI_ENGX_BUF(offset) (CVMX_ADD_IO_SEG(0x0001DF0000000880ull) + ((offset) & 7) * 8)
+#define CVMX_DPI_INFO_REG (CVMX_ADD_IO_SEG(0x0001DF0000000980ull))
+#define CVMX_DPI_INT_EN (CVMX_ADD_IO_SEG(0x0001DF0000000010ull))
+#define CVMX_DPI_INT_REG (CVMX_ADD_IO_SEG(0x0001DF0000000008ull))
+#define CVMX_DPI_NCBX_CFG(block_id) (CVMX_ADD_IO_SEG(0x0001DF0000000800ull))
+#define CVMX_DPI_PINT_INFO (CVMX_ADD_IO_SEG(0x0001DF0000000830ull))
+#define CVMX_DPI_PKT_ERR_RSP (CVMX_ADD_IO_SEG(0x0001DF0000000078ull))
+#define CVMX_DPI_REQ_ERR_RSP (CVMX_ADD_IO_SEG(0x0001DF0000000058ull))
+#define CVMX_DPI_REQ_ERR_RSP_EN (CVMX_ADD_IO_SEG(0x0001DF0000000068ull))
+#define CVMX_DPI_REQ_ERR_RST (CVMX_ADD_IO_SEG(0x0001DF0000000060ull))
+#define CVMX_DPI_REQ_ERR_RST_EN (CVMX_ADD_IO_SEG(0x0001DF0000000070ull))
+#define CVMX_DPI_REQ_ERR_SKIP_COMP (CVMX_ADD_IO_SEG(0x0001DF0000000838ull))
+#define CVMX_DPI_REQ_GBL_EN (CVMX_ADD_IO_SEG(0x0001DF0000000050ull))
+#define CVMX_DPI_SLI_PRTX_CFG(offset) (CVMX_ADD_IO_SEG(0x0001DF0000000900ull) + ((offset) & 3) * 8)
+#define CVMX_DPI_SLI_PRTX_ERR_INFO(offset) (CVMX_ADD_IO_SEG(0x0001DF0000000940ull) + ((offset) & 3) * 8)
+
+union cvmx_dpi_bist_status {
+	uint64_t u64;
+	struct cvmx_dpi_bist_status_s {
+		uint64_t reserved_47_63:17;
+		uint64_t bist:47;
+	} s;
+	struct cvmx_dpi_bist_status_s cn61xx;
+	struct cvmx_dpi_bist_status_cn63xx {
+		uint64_t reserved_45_63:19;
+		uint64_t bist:45;
+	} cn63xx;
+	struct cvmx_dpi_bist_status_cn63xxp1 {
+		uint64_t reserved_37_63:27;
+		uint64_t bist:37;
+	} cn63xxp1;
+	struct cvmx_dpi_bist_status_s cn66xx;
+	struct cvmx_dpi_bist_status_cn63xx cn68xx;
+	struct cvmx_dpi_bist_status_cn63xx cn68xxp1;
+};
+
+union cvmx_dpi_ctl {
+	uint64_t u64;
+	struct cvmx_dpi_ctl_s {
+		uint64_t reserved_2_63:62;
+		uint64_t clk:1;
+		uint64_t en:1;
+	} s;
+	struct cvmx_dpi_ctl_cn61xx {
+		uint64_t reserved_1_63:63;
+		uint64_t en:1;
+	} cn61xx;
+	struct cvmx_dpi_ctl_s cn63xx;
+	struct cvmx_dpi_ctl_s cn63xxp1;
+	struct cvmx_dpi_ctl_s cn66xx;
+	struct cvmx_dpi_ctl_s cn68xx;
+	struct cvmx_dpi_ctl_s cn68xxp1;
+};
+
+union cvmx_dpi_dmax_counts {
+	uint64_t u64;
+	struct cvmx_dpi_dmax_counts_s {
+		uint64_t reserved_39_63:25;
+		uint64_t fcnt:7;
+		uint64_t dbell:32;
+	} s;
+	struct cvmx_dpi_dmax_counts_s cn61xx;
+	struct cvmx_dpi_dmax_counts_s cn63xx;
+	struct cvmx_dpi_dmax_counts_s cn63xxp1;
+	struct cvmx_dpi_dmax_counts_s cn66xx;
+	struct cvmx_dpi_dmax_counts_s cn68xx;
+	struct cvmx_dpi_dmax_counts_s cn68xxp1;
+};
+
+union cvmx_dpi_dmax_dbell {
+	uint64_t u64;
+	struct cvmx_dpi_dmax_dbell_s {
+		uint64_t reserved_16_63:48;
+		uint64_t dbell:16;
+	} s;
+	struct cvmx_dpi_dmax_dbell_s cn61xx;
+	struct cvmx_dpi_dmax_dbell_s cn63xx;
+	struct cvmx_dpi_dmax_dbell_s cn63xxp1;
+	struct cvmx_dpi_dmax_dbell_s cn66xx;
+	struct cvmx_dpi_dmax_dbell_s cn68xx;
+	struct cvmx_dpi_dmax_dbell_s cn68xxp1;
+};
+
+union cvmx_dpi_dmax_err_rsp_status {
+	uint64_t u64;
+	struct cvmx_dpi_dmax_err_rsp_status_s {
+		uint64_t reserved_6_63:58;
+		uint64_t status:6;
+	} s;
+	struct cvmx_dpi_dmax_err_rsp_status_s cn61xx;
+	struct cvmx_dpi_dmax_err_rsp_status_s cn66xx;
+	struct cvmx_dpi_dmax_err_rsp_status_s cn68xx;
+	struct cvmx_dpi_dmax_err_rsp_status_s cn68xxp1;
+};
+
+union cvmx_dpi_dmax_ibuff_saddr {
+	uint64_t u64;
+	struct cvmx_dpi_dmax_ibuff_saddr_s {
+		uint64_t reserved_62_63:2;
+		uint64_t csize:14;
+		uint64_t reserved_41_47:7;
+		uint64_t idle:1;
+		uint64_t saddr:33;
+		uint64_t reserved_0_6:7;
+	} s;
+	struct cvmx_dpi_dmax_ibuff_saddr_cn61xx {
+		uint64_t reserved_62_63:2;
+		uint64_t csize:14;
+		uint64_t reserved_41_47:7;
+		uint64_t idle:1;
+		uint64_t reserved_36_39:4;
+		uint64_t saddr:29;
+		uint64_t reserved_0_6:7;
+	} cn61xx;
+	struct cvmx_dpi_dmax_ibuff_saddr_cn61xx cn63xx;
+	struct cvmx_dpi_dmax_ibuff_saddr_cn61xx cn63xxp1;
+	struct cvmx_dpi_dmax_ibuff_saddr_cn61xx cn66xx;
+	struct cvmx_dpi_dmax_ibuff_saddr_s cn68xx;
+	struct cvmx_dpi_dmax_ibuff_saddr_s cn68xxp1;
+};
+
+union cvmx_dpi_dmax_iflight {
+	uint64_t u64;
+	struct cvmx_dpi_dmax_iflight_s {
+		uint64_t reserved_3_63:61;
+		uint64_t cnt:3;
+	} s;
+	struct cvmx_dpi_dmax_iflight_s cn61xx;
+	struct cvmx_dpi_dmax_iflight_s cn66xx;
+	struct cvmx_dpi_dmax_iflight_s cn68xx;
+	struct cvmx_dpi_dmax_iflight_s cn68xxp1;
+};
+
+union cvmx_dpi_dmax_naddr {
+	uint64_t u64;
+	struct cvmx_dpi_dmax_naddr_s {
+		uint64_t reserved_40_63:24;
+		uint64_t addr:40;
+	} s;
+	struct cvmx_dpi_dmax_naddr_cn61xx {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} cn61xx;
+	struct cvmx_dpi_dmax_naddr_cn61xx cn63xx;
+	struct cvmx_dpi_dmax_naddr_cn61xx cn63xxp1;
+	struct cvmx_dpi_dmax_naddr_cn61xx cn66xx;
+	struct cvmx_dpi_dmax_naddr_s cn68xx;
+	struct cvmx_dpi_dmax_naddr_s cn68xxp1;
+};
+
+union cvmx_dpi_dmax_reqbnk0 {
+	uint64_t u64;
+	struct cvmx_dpi_dmax_reqbnk0_s {
+		uint64_t state:64;
+	} s;
+	struct cvmx_dpi_dmax_reqbnk0_s cn61xx;
+	struct cvmx_dpi_dmax_reqbnk0_s cn63xx;
+	struct cvmx_dpi_dmax_reqbnk0_s cn63xxp1;
+	struct cvmx_dpi_dmax_reqbnk0_s cn66xx;
+	struct cvmx_dpi_dmax_reqbnk0_s cn68xx;
+	struct cvmx_dpi_dmax_reqbnk0_s cn68xxp1;
+};
+
+union cvmx_dpi_dmax_reqbnk1 {
+	uint64_t u64;
+	struct cvmx_dpi_dmax_reqbnk1_s {
+		uint64_t state:64;
+	} s;
+	struct cvmx_dpi_dmax_reqbnk1_s cn61xx;
+	struct cvmx_dpi_dmax_reqbnk1_s cn63xx;
+	struct cvmx_dpi_dmax_reqbnk1_s cn63xxp1;
+	struct cvmx_dpi_dmax_reqbnk1_s cn66xx;
+	struct cvmx_dpi_dmax_reqbnk1_s cn68xx;
+	struct cvmx_dpi_dmax_reqbnk1_s cn68xxp1;
+};
+
+union cvmx_dpi_dma_control {
+	uint64_t u64;
+	struct cvmx_dpi_dma_control_s {
+		uint64_t reserved_62_63:2;
+		uint64_t dici_mode:1;
+		uint64_t pkt_en1:1;
+		uint64_t ffp_dis:1;
+		uint64_t commit_mode:1;
+		uint64_t pkt_hp:1;
+		uint64_t pkt_en:1;
+		uint64_t reserved_54_55:2;
+		uint64_t dma_enb:6;
+		uint64_t reserved_34_47:14;
+		uint64_t b0_lend:1;
+		uint64_t dwb_denb:1;
+		uint64_t dwb_ichk:9;
+		uint64_t fpa_que:3;
+		uint64_t o_add1:1;
+		uint64_t o_ro:1;
+		uint64_t o_ns:1;
+		uint64_t o_es:2;
+		uint64_t o_mode:1;
+		uint64_t reserved_0_13:14;
+	} s;
+	struct cvmx_dpi_dma_control_s cn61xx;
+	struct cvmx_dpi_dma_control_cn63xx {
+		uint64_t reserved_61_63:3;
+		uint64_t pkt_en1:1;
+		uint64_t ffp_dis:1;
+		uint64_t commit_mode:1;
+		uint64_t pkt_hp:1;
+		uint64_t pkt_en:1;
+		uint64_t reserved_54_55:2;
+		uint64_t dma_enb:6;
+		uint64_t reserved_34_47:14;
+		uint64_t b0_lend:1;
+		uint64_t dwb_denb:1;
+		uint64_t dwb_ichk:9;
+		uint64_t fpa_que:3;
+		uint64_t o_add1:1;
+		uint64_t o_ro:1;
+		uint64_t o_ns:1;
+		uint64_t o_es:2;
+		uint64_t o_mode:1;
+		uint64_t reserved_0_13:14;
+	} cn63xx;
+	struct cvmx_dpi_dma_control_cn63xxp1 {
+		uint64_t reserved_59_63:5;
+		uint64_t commit_mode:1;
+		uint64_t pkt_hp:1;
+		uint64_t pkt_en:1;
+		uint64_t reserved_54_55:2;
+		uint64_t dma_enb:6;
+		uint64_t reserved_34_47:14;
+		uint64_t b0_lend:1;
+		uint64_t dwb_denb:1;
+		uint64_t dwb_ichk:9;
+		uint64_t fpa_que:3;
+		uint64_t o_add1:1;
+		uint64_t o_ro:1;
+		uint64_t o_ns:1;
+		uint64_t o_es:2;
+		uint64_t o_mode:1;
+		uint64_t reserved_0_13:14;
+	} cn63xxp1;
+	struct cvmx_dpi_dma_control_cn63xx cn66xx;
+	struct cvmx_dpi_dma_control_s cn68xx;
+	struct cvmx_dpi_dma_control_cn63xx cn68xxp1;
+};
+
+union cvmx_dpi_dma_engx_en {
+	uint64_t u64;
+	struct cvmx_dpi_dma_engx_en_s {
+		uint64_t reserved_8_63:56;
+		uint64_t qen:8;
+	} s;
+	struct cvmx_dpi_dma_engx_en_s cn61xx;
+	struct cvmx_dpi_dma_engx_en_s cn63xx;
+	struct cvmx_dpi_dma_engx_en_s cn63xxp1;
+	struct cvmx_dpi_dma_engx_en_s cn66xx;
+	struct cvmx_dpi_dma_engx_en_s cn68xx;
+	struct cvmx_dpi_dma_engx_en_s cn68xxp1;
+};
+
+union cvmx_dpi_dma_ppx_cnt {
+	uint64_t u64;
+	struct cvmx_dpi_dma_ppx_cnt_s {
+		uint64_t reserved_16_63:48;
+		uint64_t cnt:16;
+	} s;
+	struct cvmx_dpi_dma_ppx_cnt_s cn61xx;
+	struct cvmx_dpi_dma_ppx_cnt_s cn68xx;
+};
+
+union cvmx_dpi_engx_buf {
+	uint64_t u64;
+	struct cvmx_dpi_engx_buf_s {
+		uint64_t reserved_37_63:27;
+		uint64_t compblks:5;
+		uint64_t reserved_9_31:23;
+		uint64_t base:5;
+		uint64_t blks:4;
+	} s;
+	struct cvmx_dpi_engx_buf_s cn61xx;
+	struct cvmx_dpi_engx_buf_cn63xx {
+		uint64_t reserved_8_63:56;
+		uint64_t base:4;
+		uint64_t blks:4;
+	} cn63xx;
+	struct cvmx_dpi_engx_buf_cn63xx cn63xxp1;
+	struct cvmx_dpi_engx_buf_s cn66xx;
+	struct cvmx_dpi_engx_buf_s cn68xx;
+	struct cvmx_dpi_engx_buf_s cn68xxp1;
+};
+
+union cvmx_dpi_info_reg {
+	uint64_t u64;
+	struct cvmx_dpi_info_reg_s {
+		uint64_t reserved_8_63:56;
+		uint64_t ffp:4;
+		uint64_t reserved_2_3:2;
+		uint64_t ncb:1;
+		uint64_t rsl:1;
+	} s;
+	struct cvmx_dpi_info_reg_s cn61xx;
+	struct cvmx_dpi_info_reg_s cn63xx;
+	struct cvmx_dpi_info_reg_cn63xxp1 {
+		uint64_t reserved_2_63:62;
+		uint64_t ncb:1;
+		uint64_t rsl:1;
+	} cn63xxp1;
+	struct cvmx_dpi_info_reg_s cn66xx;
+	struct cvmx_dpi_info_reg_s cn68xx;
+	struct cvmx_dpi_info_reg_s cn68xxp1;
+};
+
+union cvmx_dpi_int_en {
+	uint64_t u64;
+	struct cvmx_dpi_int_en_s {
+		uint64_t reserved_28_63:36;
+		uint64_t sprt3_rst:1;
+		uint64_t sprt2_rst:1;
+		uint64_t sprt1_rst:1;
+		uint64_t sprt0_rst:1;
+		uint64_t reserved_23_23:1;
+		uint64_t req_badfil:1;
+		uint64_t req_inull:1;
+		uint64_t req_anull:1;
+		uint64_t req_undflw:1;
+		uint64_t req_ovrflw:1;
+		uint64_t req_badlen:1;
+		uint64_t req_badadr:1;
+		uint64_t dmadbo:8;
+		uint64_t reserved_2_7:6;
+		uint64_t nfovr:1;
+		uint64_t nderr:1;
+	} s;
+	struct cvmx_dpi_int_en_s cn61xx;
+	struct cvmx_dpi_int_en_cn63xx {
+		uint64_t reserved_26_63:38;
+		uint64_t sprt1_rst:1;
+		uint64_t sprt0_rst:1;
+		uint64_t reserved_23_23:1;
+		uint64_t req_badfil:1;
+		uint64_t req_inull:1;
+		uint64_t req_anull:1;
+		uint64_t req_undflw:1;
+		uint64_t req_ovrflw:1;
+		uint64_t req_badlen:1;
+		uint64_t req_badadr:1;
+		uint64_t dmadbo:8;
+		uint64_t reserved_2_7:6;
+		uint64_t nfovr:1;
+		uint64_t nderr:1;
+	} cn63xx;
+	struct cvmx_dpi_int_en_cn63xx cn63xxp1;
+	struct cvmx_dpi_int_en_s cn66xx;
+	struct cvmx_dpi_int_en_cn63xx cn68xx;
+	struct cvmx_dpi_int_en_cn63xx cn68xxp1;
+};
+
+union cvmx_dpi_int_reg {
+	uint64_t u64;
+	struct cvmx_dpi_int_reg_s {
+		uint64_t reserved_28_63:36;
+		uint64_t sprt3_rst:1;
+		uint64_t sprt2_rst:1;
+		uint64_t sprt1_rst:1;
+		uint64_t sprt0_rst:1;
+		uint64_t reserved_23_23:1;
+		uint64_t req_badfil:1;
+		uint64_t req_inull:1;
+		uint64_t req_anull:1;
+		uint64_t req_undflw:1;
+		uint64_t req_ovrflw:1;
+		uint64_t req_badlen:1;
+		uint64_t req_badadr:1;
+		uint64_t dmadbo:8;
+		uint64_t reserved_2_7:6;
+		uint64_t nfovr:1;
+		uint64_t nderr:1;
+	} s;
+	struct cvmx_dpi_int_reg_s cn61xx;
+	struct cvmx_dpi_int_reg_cn63xx {
+		uint64_t reserved_26_63:38;
+		uint64_t sprt1_rst:1;
+		uint64_t sprt0_rst:1;
+		uint64_t reserved_23_23:1;
+		uint64_t req_badfil:1;
+		uint64_t req_inull:1;
+		uint64_t req_anull:1;
+		uint64_t req_undflw:1;
+		uint64_t req_ovrflw:1;
+		uint64_t req_badlen:1;
+		uint64_t req_badadr:1;
+		uint64_t dmadbo:8;
+		uint64_t reserved_2_7:6;
+		uint64_t nfovr:1;
+		uint64_t nderr:1;
+	} cn63xx;
+	struct cvmx_dpi_int_reg_cn63xx cn63xxp1;
+	struct cvmx_dpi_int_reg_s cn66xx;
+	struct cvmx_dpi_int_reg_cn63xx cn68xx;
+	struct cvmx_dpi_int_reg_cn63xx cn68xxp1;
+};
+
+union cvmx_dpi_ncbx_cfg {
+	uint64_t u64;
+	struct cvmx_dpi_ncbx_cfg_s {
+		uint64_t reserved_6_63:58;
+		uint64_t molr:6;
+	} s;
+	struct cvmx_dpi_ncbx_cfg_s cn61xx;
+	struct cvmx_dpi_ncbx_cfg_s cn66xx;
+	struct cvmx_dpi_ncbx_cfg_s cn68xx;
+};
+
+union cvmx_dpi_pint_info {
+	uint64_t u64;
+	struct cvmx_dpi_pint_info_s {
+		uint64_t reserved_14_63:50;
+		uint64_t iinfo:6;
+		uint64_t reserved_6_7:2;
+		uint64_t sinfo:6;
+	} s;
+	struct cvmx_dpi_pint_info_s cn61xx;
+	struct cvmx_dpi_pint_info_s cn63xx;
+	struct cvmx_dpi_pint_info_s cn63xxp1;
+	struct cvmx_dpi_pint_info_s cn66xx;
+	struct cvmx_dpi_pint_info_s cn68xx;
+	struct cvmx_dpi_pint_info_s cn68xxp1;
+};
+
+union cvmx_dpi_pkt_err_rsp {
+	uint64_t u64;
+	struct cvmx_dpi_pkt_err_rsp_s {
+		uint64_t reserved_1_63:63;
+		uint64_t pkterr:1;
+	} s;
+	struct cvmx_dpi_pkt_err_rsp_s cn61xx;
+	struct cvmx_dpi_pkt_err_rsp_s cn63xx;
+	struct cvmx_dpi_pkt_err_rsp_s cn63xxp1;
+	struct cvmx_dpi_pkt_err_rsp_s cn66xx;
+	struct cvmx_dpi_pkt_err_rsp_s cn68xx;
+	struct cvmx_dpi_pkt_err_rsp_s cn68xxp1;
+};
+
+union cvmx_dpi_req_err_rsp {
+	uint64_t u64;
+	struct cvmx_dpi_req_err_rsp_s {
+		uint64_t reserved_8_63:56;
+		uint64_t qerr:8;
+	} s;
+	struct cvmx_dpi_req_err_rsp_s cn61xx;
+	struct cvmx_dpi_req_err_rsp_s cn63xx;
+	struct cvmx_dpi_req_err_rsp_s cn63xxp1;
+	struct cvmx_dpi_req_err_rsp_s cn66xx;
+	struct cvmx_dpi_req_err_rsp_s cn68xx;
+	struct cvmx_dpi_req_err_rsp_s cn68xxp1;
+};
+
+union cvmx_dpi_req_err_rsp_en {
+	uint64_t u64;
+	struct cvmx_dpi_req_err_rsp_en_s {
+		uint64_t reserved_8_63:56;
+		uint64_t en:8;
+	} s;
+	struct cvmx_dpi_req_err_rsp_en_s cn61xx;
+	struct cvmx_dpi_req_err_rsp_en_s cn63xx;
+	struct cvmx_dpi_req_err_rsp_en_s cn63xxp1;
+	struct cvmx_dpi_req_err_rsp_en_s cn66xx;
+	struct cvmx_dpi_req_err_rsp_en_s cn68xx;
+	struct cvmx_dpi_req_err_rsp_en_s cn68xxp1;
+};
+
+union cvmx_dpi_req_err_rst {
+	uint64_t u64;
+	struct cvmx_dpi_req_err_rst_s {
+		uint64_t reserved_8_63:56;
+		uint64_t qerr:8;
+	} s;
+	struct cvmx_dpi_req_err_rst_s cn61xx;
+	struct cvmx_dpi_req_err_rst_s cn63xx;
+	struct cvmx_dpi_req_err_rst_s cn63xxp1;
+	struct cvmx_dpi_req_err_rst_s cn66xx;
+	struct cvmx_dpi_req_err_rst_s cn68xx;
+	struct cvmx_dpi_req_err_rst_s cn68xxp1;
+};
+
+union cvmx_dpi_req_err_rst_en {
+	uint64_t u64;
+	struct cvmx_dpi_req_err_rst_en_s {
+		uint64_t reserved_8_63:56;
+		uint64_t en:8;
+	} s;
+	struct cvmx_dpi_req_err_rst_en_s cn61xx;
+	struct cvmx_dpi_req_err_rst_en_s cn63xx;
+	struct cvmx_dpi_req_err_rst_en_s cn63xxp1;
+	struct cvmx_dpi_req_err_rst_en_s cn66xx;
+	struct cvmx_dpi_req_err_rst_en_s cn68xx;
+	struct cvmx_dpi_req_err_rst_en_s cn68xxp1;
+};
+
+union cvmx_dpi_req_err_skip_comp {
+	uint64_t u64;
+	struct cvmx_dpi_req_err_skip_comp_s {
+		uint64_t reserved_24_63:40;
+		uint64_t en_rst:8;
+		uint64_t reserved_8_15:8;
+		uint64_t en_rsp:8;
+	} s;
+	struct cvmx_dpi_req_err_skip_comp_s cn61xx;
+	struct cvmx_dpi_req_err_skip_comp_s cn66xx;
+	struct cvmx_dpi_req_err_skip_comp_s cn68xx;
+	struct cvmx_dpi_req_err_skip_comp_s cn68xxp1;
+};
+
+union cvmx_dpi_req_gbl_en {
+	uint64_t u64;
+	struct cvmx_dpi_req_gbl_en_s {
+		uint64_t reserved_8_63:56;
+		uint64_t qen:8;
+	} s;
+	struct cvmx_dpi_req_gbl_en_s cn61xx;
+	struct cvmx_dpi_req_gbl_en_s cn63xx;
+	struct cvmx_dpi_req_gbl_en_s cn63xxp1;
+	struct cvmx_dpi_req_gbl_en_s cn66xx;
+	struct cvmx_dpi_req_gbl_en_s cn68xx;
+	struct cvmx_dpi_req_gbl_en_s cn68xxp1;
+};
+
+union cvmx_dpi_sli_prtx_cfg {
+	uint64_t u64;
+	struct cvmx_dpi_sli_prtx_cfg_s {
+		uint64_t reserved_25_63:39;
+		uint64_t halt:1;
+		uint64_t qlm_cfg:4;
+		uint64_t reserved_17_19:3;
+		uint64_t rd_mode:1;
+		uint64_t reserved_14_15:2;
+		uint64_t molr:6;
+		uint64_t mps_lim:1;
+		uint64_t reserved_5_6:2;
+		uint64_t mps:1;
+		uint64_t mrrs_lim:1;
+		uint64_t reserved_2_2:1;
+		uint64_t mrrs:2;
+	} s;
+	struct cvmx_dpi_sli_prtx_cfg_s cn61xx;
+	struct cvmx_dpi_sli_prtx_cfg_cn63xx {
+		uint64_t reserved_25_63:39;
+		uint64_t halt:1;
+		uint64_t reserved_21_23:3;
+		uint64_t qlm_cfg:1;
+		uint64_t reserved_17_19:3;
+		uint64_t rd_mode:1;
+		uint64_t reserved_14_15:2;
+		uint64_t molr:6;
+		uint64_t mps_lim:1;
+		uint64_t reserved_5_6:2;
+		uint64_t mps:1;
+		uint64_t mrrs_lim:1;
+		uint64_t reserved_2_2:1;
+		uint64_t mrrs:2;
+	} cn63xx;
+	struct cvmx_dpi_sli_prtx_cfg_cn63xx cn63xxp1;
+	struct cvmx_dpi_sli_prtx_cfg_s cn66xx;
+	struct cvmx_dpi_sli_prtx_cfg_cn63xx cn68xx;
+	struct cvmx_dpi_sli_prtx_cfg_cn63xx cn68xxp1;
+};
+
+union cvmx_dpi_sli_prtx_err {
+	uint64_t u64;
+	struct cvmx_dpi_sli_prtx_err_s {
+		uint64_t addr:61;
+		uint64_t reserved_0_2:3;
+	} s;
+	struct cvmx_dpi_sli_prtx_err_s cn61xx;
+	struct cvmx_dpi_sli_prtx_err_s cn63xx;
+	struct cvmx_dpi_sli_prtx_err_s cn63xxp1;
+	struct cvmx_dpi_sli_prtx_err_s cn66xx;
+	struct cvmx_dpi_sli_prtx_err_s cn68xx;
+	struct cvmx_dpi_sli_prtx_err_s cn68xxp1;
+};
+
+union cvmx_dpi_sli_prtx_err_info {
+	uint64_t u64;
+	struct cvmx_dpi_sli_prtx_err_info_s {
+		uint64_t reserved_9_63:55;
+		uint64_t lock:1;
+		uint64_t reserved_5_7:3;
+		uint64_t type:1;
+		uint64_t reserved_3_3:1;
+		uint64_t reqq:3;
+	} s;
+	struct cvmx_dpi_sli_prtx_err_info_s cn61xx;
+	struct cvmx_dpi_sli_prtx_err_info_s cn63xx;
+	struct cvmx_dpi_sli_prtx_err_info_s cn63xxp1;
+	struct cvmx_dpi_sli_prtx_err_info_s cn66xx;
+	struct cvmx_dpi_sli_prtx_err_info_s cn68xx;
+	struct cvmx_dpi_sli_prtx_err_info_s cn68xxp1;
+};
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-npei-defs.h b/arch/mips/include/asm/octeon/cvmx-npei-defs.h
index 9899a9d..a3075f7 100644
--- a/arch/mips/include/asm/octeon/cvmx-npei-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-npei-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2010 Cavium Networks
+ * Copyright (c) 2003-2011 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -65,7 +65,7 @@
 #define CVMX_NPEI_LAST_WIN_RDATA0 (0x0000000000000600ull)
 #define CVMX_NPEI_LAST_WIN_RDATA1 (0x0000000000000610ull)
 #define CVMX_NPEI_MEM_ACCESS_CTL (0x00000000000004F0ull)
-#define CVMX_NPEI_MEM_ACCESS_SUBIDX(offset) (0x0000000000000340ull + ((offset) & 31) * 16 - 16*12)
+#define CVMX_NPEI_MEM_ACCESS_SUBIDX(offset) (0x0000000000000280ull + ((offset) & 31) * 16 - 16*12)
 #define CVMX_NPEI_MSI_ENB0 (0x0000000000003C50ull)
 #define CVMX_NPEI_MSI_ENB1 (0x0000000000003C60ull)
 #define CVMX_NPEI_MSI_ENB2 (0x0000000000003C70ull)
diff --git a/arch/mips/include/asm/octeon/cvmx-pciercx-defs.h b/arch/mips/include/asm/octeon/cvmx-pciercx-defs.h
index f8cb889..7b1dc8b 100644
--- a/arch/mips/include/asm/octeon/cvmx-pciercx-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-pciercx-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2010 Cavium Networks
+ * Copyright (c) 2003-2011 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -116,8 +116,12 @@ union cvmx_pciercx_cfg000 {
 	struct cvmx_pciercx_cfg000_s cn52xxp1;
 	struct cvmx_pciercx_cfg000_s cn56xx;
 	struct cvmx_pciercx_cfg000_s cn56xxp1;
+	struct cvmx_pciercx_cfg000_s cn61xx;
 	struct cvmx_pciercx_cfg000_s cn63xx;
 	struct cvmx_pciercx_cfg000_s cn63xxp1;
+	struct cvmx_pciercx_cfg000_s cn66xx;
+	struct cvmx_pciercx_cfg000_s cn68xx;
+	struct cvmx_pciercx_cfg000_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg001 {
@@ -152,8 +156,12 @@ union cvmx_pciercx_cfg001 {
 	struct cvmx_pciercx_cfg001_s cn52xxp1;
 	struct cvmx_pciercx_cfg001_s cn56xx;
 	struct cvmx_pciercx_cfg001_s cn56xxp1;
+	struct cvmx_pciercx_cfg001_s cn61xx;
 	struct cvmx_pciercx_cfg001_s cn63xx;
 	struct cvmx_pciercx_cfg001_s cn63xxp1;
+	struct cvmx_pciercx_cfg001_s cn66xx;
+	struct cvmx_pciercx_cfg001_s cn68xx;
+	struct cvmx_pciercx_cfg001_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg002 {
@@ -168,8 +176,12 @@ union cvmx_pciercx_cfg002 {
 	struct cvmx_pciercx_cfg002_s cn52xxp1;
 	struct cvmx_pciercx_cfg002_s cn56xx;
 	struct cvmx_pciercx_cfg002_s cn56xxp1;
+	struct cvmx_pciercx_cfg002_s cn61xx;
 	struct cvmx_pciercx_cfg002_s cn63xx;
 	struct cvmx_pciercx_cfg002_s cn63xxp1;
+	struct cvmx_pciercx_cfg002_s cn66xx;
+	struct cvmx_pciercx_cfg002_s cn68xx;
+	struct cvmx_pciercx_cfg002_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg003 {
@@ -185,8 +197,12 @@ union cvmx_pciercx_cfg003 {
 	struct cvmx_pciercx_cfg003_s cn52xxp1;
 	struct cvmx_pciercx_cfg003_s cn56xx;
 	struct cvmx_pciercx_cfg003_s cn56xxp1;
+	struct cvmx_pciercx_cfg003_s cn61xx;
 	struct cvmx_pciercx_cfg003_s cn63xx;
 	struct cvmx_pciercx_cfg003_s cn63xxp1;
+	struct cvmx_pciercx_cfg003_s cn66xx;
+	struct cvmx_pciercx_cfg003_s cn68xx;
+	struct cvmx_pciercx_cfg003_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg004 {
@@ -198,8 +214,12 @@ union cvmx_pciercx_cfg004 {
 	struct cvmx_pciercx_cfg004_s cn52xxp1;
 	struct cvmx_pciercx_cfg004_s cn56xx;
 	struct cvmx_pciercx_cfg004_s cn56xxp1;
+	struct cvmx_pciercx_cfg004_s cn61xx;
 	struct cvmx_pciercx_cfg004_s cn63xx;
 	struct cvmx_pciercx_cfg004_s cn63xxp1;
+	struct cvmx_pciercx_cfg004_s cn66xx;
+	struct cvmx_pciercx_cfg004_s cn68xx;
+	struct cvmx_pciercx_cfg004_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg005 {
@@ -211,8 +231,12 @@ union cvmx_pciercx_cfg005 {
 	struct cvmx_pciercx_cfg005_s cn52xxp1;
 	struct cvmx_pciercx_cfg005_s cn56xx;
 	struct cvmx_pciercx_cfg005_s cn56xxp1;
+	struct cvmx_pciercx_cfg005_s cn61xx;
 	struct cvmx_pciercx_cfg005_s cn63xx;
 	struct cvmx_pciercx_cfg005_s cn63xxp1;
+	struct cvmx_pciercx_cfg005_s cn66xx;
+	struct cvmx_pciercx_cfg005_s cn68xx;
+	struct cvmx_pciercx_cfg005_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg006 {
@@ -227,8 +251,12 @@ union cvmx_pciercx_cfg006 {
 	struct cvmx_pciercx_cfg006_s cn52xxp1;
 	struct cvmx_pciercx_cfg006_s cn56xx;
 	struct cvmx_pciercx_cfg006_s cn56xxp1;
+	struct cvmx_pciercx_cfg006_s cn61xx;
 	struct cvmx_pciercx_cfg006_s cn63xx;
 	struct cvmx_pciercx_cfg006_s cn63xxp1;
+	struct cvmx_pciercx_cfg006_s cn66xx;
+	struct cvmx_pciercx_cfg006_s cn68xx;
+	struct cvmx_pciercx_cfg006_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg007 {
@@ -256,8 +284,12 @@ union cvmx_pciercx_cfg007 {
 	struct cvmx_pciercx_cfg007_s cn52xxp1;
 	struct cvmx_pciercx_cfg007_s cn56xx;
 	struct cvmx_pciercx_cfg007_s cn56xxp1;
+	struct cvmx_pciercx_cfg007_s cn61xx;
 	struct cvmx_pciercx_cfg007_s cn63xx;
 	struct cvmx_pciercx_cfg007_s cn63xxp1;
+	struct cvmx_pciercx_cfg007_s cn66xx;
+	struct cvmx_pciercx_cfg007_s cn68xx;
+	struct cvmx_pciercx_cfg007_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg008 {
@@ -272,8 +304,12 @@ union cvmx_pciercx_cfg008 {
 	struct cvmx_pciercx_cfg008_s cn52xxp1;
 	struct cvmx_pciercx_cfg008_s cn56xx;
 	struct cvmx_pciercx_cfg008_s cn56xxp1;
+	struct cvmx_pciercx_cfg008_s cn61xx;
 	struct cvmx_pciercx_cfg008_s cn63xx;
 	struct cvmx_pciercx_cfg008_s cn63xxp1;
+	struct cvmx_pciercx_cfg008_s cn66xx;
+	struct cvmx_pciercx_cfg008_s cn68xx;
+	struct cvmx_pciercx_cfg008_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg009 {
@@ -290,8 +326,12 @@ union cvmx_pciercx_cfg009 {
 	struct cvmx_pciercx_cfg009_s cn52xxp1;
 	struct cvmx_pciercx_cfg009_s cn56xx;
 	struct cvmx_pciercx_cfg009_s cn56xxp1;
+	struct cvmx_pciercx_cfg009_s cn61xx;
 	struct cvmx_pciercx_cfg009_s cn63xx;
 	struct cvmx_pciercx_cfg009_s cn63xxp1;
+	struct cvmx_pciercx_cfg009_s cn66xx;
+	struct cvmx_pciercx_cfg009_s cn68xx;
+	struct cvmx_pciercx_cfg009_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg010 {
@@ -303,8 +343,12 @@ union cvmx_pciercx_cfg010 {
 	struct cvmx_pciercx_cfg010_s cn52xxp1;
 	struct cvmx_pciercx_cfg010_s cn56xx;
 	struct cvmx_pciercx_cfg010_s cn56xxp1;
+	struct cvmx_pciercx_cfg010_s cn61xx;
 	struct cvmx_pciercx_cfg010_s cn63xx;
 	struct cvmx_pciercx_cfg010_s cn63xxp1;
+	struct cvmx_pciercx_cfg010_s cn66xx;
+	struct cvmx_pciercx_cfg010_s cn68xx;
+	struct cvmx_pciercx_cfg010_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg011 {
@@ -316,8 +360,12 @@ union cvmx_pciercx_cfg011 {
 	struct cvmx_pciercx_cfg011_s cn52xxp1;
 	struct cvmx_pciercx_cfg011_s cn56xx;
 	struct cvmx_pciercx_cfg011_s cn56xxp1;
+	struct cvmx_pciercx_cfg011_s cn61xx;
 	struct cvmx_pciercx_cfg011_s cn63xx;
 	struct cvmx_pciercx_cfg011_s cn63xxp1;
+	struct cvmx_pciercx_cfg011_s cn66xx;
+	struct cvmx_pciercx_cfg011_s cn68xx;
+	struct cvmx_pciercx_cfg011_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg012 {
@@ -330,8 +378,12 @@ union cvmx_pciercx_cfg012 {
 	struct cvmx_pciercx_cfg012_s cn52xxp1;
 	struct cvmx_pciercx_cfg012_s cn56xx;
 	struct cvmx_pciercx_cfg012_s cn56xxp1;
+	struct cvmx_pciercx_cfg012_s cn61xx;
 	struct cvmx_pciercx_cfg012_s cn63xx;
 	struct cvmx_pciercx_cfg012_s cn63xxp1;
+	struct cvmx_pciercx_cfg012_s cn66xx;
+	struct cvmx_pciercx_cfg012_s cn68xx;
+	struct cvmx_pciercx_cfg012_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg013 {
@@ -344,8 +396,12 @@ union cvmx_pciercx_cfg013 {
 	struct cvmx_pciercx_cfg013_s cn52xxp1;
 	struct cvmx_pciercx_cfg013_s cn56xx;
 	struct cvmx_pciercx_cfg013_s cn56xxp1;
+	struct cvmx_pciercx_cfg013_s cn61xx;
 	struct cvmx_pciercx_cfg013_s cn63xx;
 	struct cvmx_pciercx_cfg013_s cn63xxp1;
+	struct cvmx_pciercx_cfg013_s cn66xx;
+	struct cvmx_pciercx_cfg013_s cn68xx;
+	struct cvmx_pciercx_cfg013_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg014 {
@@ -357,8 +413,12 @@ union cvmx_pciercx_cfg014 {
 	struct cvmx_pciercx_cfg014_s cn52xxp1;
 	struct cvmx_pciercx_cfg014_s cn56xx;
 	struct cvmx_pciercx_cfg014_s cn56xxp1;
+	struct cvmx_pciercx_cfg014_s cn61xx;
 	struct cvmx_pciercx_cfg014_s cn63xx;
 	struct cvmx_pciercx_cfg014_s cn63xxp1;
+	struct cvmx_pciercx_cfg014_s cn66xx;
+	struct cvmx_pciercx_cfg014_s cn68xx;
+	struct cvmx_pciercx_cfg014_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg015 {
@@ -384,8 +444,12 @@ union cvmx_pciercx_cfg015 {
 	struct cvmx_pciercx_cfg015_s cn52xxp1;
 	struct cvmx_pciercx_cfg015_s cn56xx;
 	struct cvmx_pciercx_cfg015_s cn56xxp1;
+	struct cvmx_pciercx_cfg015_s cn61xx;
 	struct cvmx_pciercx_cfg015_s cn63xx;
 	struct cvmx_pciercx_cfg015_s cn63xxp1;
+	struct cvmx_pciercx_cfg015_s cn66xx;
+	struct cvmx_pciercx_cfg015_s cn68xx;
+	struct cvmx_pciercx_cfg015_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg016 {
@@ -406,8 +470,12 @@ union cvmx_pciercx_cfg016 {
 	struct cvmx_pciercx_cfg016_s cn52xxp1;
 	struct cvmx_pciercx_cfg016_s cn56xx;
 	struct cvmx_pciercx_cfg016_s cn56xxp1;
+	struct cvmx_pciercx_cfg016_s cn61xx;
 	struct cvmx_pciercx_cfg016_s cn63xx;
 	struct cvmx_pciercx_cfg016_s cn63xxp1;
+	struct cvmx_pciercx_cfg016_s cn66xx;
+	struct cvmx_pciercx_cfg016_s cn68xx;
+	struct cvmx_pciercx_cfg016_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg017 {
@@ -430,14 +498,19 @@ union cvmx_pciercx_cfg017 {
 	struct cvmx_pciercx_cfg017_s cn52xxp1;
 	struct cvmx_pciercx_cfg017_s cn56xx;
 	struct cvmx_pciercx_cfg017_s cn56xxp1;
+	struct cvmx_pciercx_cfg017_s cn61xx;
 	struct cvmx_pciercx_cfg017_s cn63xx;
 	struct cvmx_pciercx_cfg017_s cn63xxp1;
+	struct cvmx_pciercx_cfg017_s cn66xx;
+	struct cvmx_pciercx_cfg017_s cn68xx;
+	struct cvmx_pciercx_cfg017_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg020 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg020_s {
-		uint32_t reserved_24_31:8;
+		uint32_t reserved_25_31:7;
+		uint32_t pvm:1;
 		uint32_t m64:1;
 		uint32_t mme:3;
 		uint32_t mmc:3;
@@ -445,12 +518,24 @@ union cvmx_pciercx_cfg020 {
 		uint32_t ncp:8;
 		uint32_t msicid:8;
 	} s;
-	struct cvmx_pciercx_cfg020_s cn52xx;
-	struct cvmx_pciercx_cfg020_s cn52xxp1;
-	struct cvmx_pciercx_cfg020_s cn56xx;
-	struct cvmx_pciercx_cfg020_s cn56xxp1;
-	struct cvmx_pciercx_cfg020_s cn63xx;
-	struct cvmx_pciercx_cfg020_s cn63xxp1;
+	struct cvmx_pciercx_cfg020_cn52xx {
+		uint32_t reserved_24_31:8;
+		uint32_t m64:1;
+		uint32_t mme:3;
+		uint32_t mmc:3;
+		uint32_t msien:1;
+		uint32_t ncp:8;
+		uint32_t msicid:8;
+	} cn52xx;
+	struct cvmx_pciercx_cfg020_cn52xx cn52xxp1;
+	struct cvmx_pciercx_cfg020_cn52xx cn56xx;
+	struct cvmx_pciercx_cfg020_cn52xx cn56xxp1;
+	struct cvmx_pciercx_cfg020_s cn61xx;
+	struct cvmx_pciercx_cfg020_cn52xx cn63xx;
+	struct cvmx_pciercx_cfg020_cn52xx cn63xxp1;
+	struct cvmx_pciercx_cfg020_cn52xx cn66xx;
+	struct cvmx_pciercx_cfg020_cn52xx cn68xx;
+	struct cvmx_pciercx_cfg020_cn52xx cn68xxp1;
 };
 
 union cvmx_pciercx_cfg021 {
@@ -463,8 +548,12 @@ union cvmx_pciercx_cfg021 {
 	struct cvmx_pciercx_cfg021_s cn52xxp1;
 	struct cvmx_pciercx_cfg021_s cn56xx;
 	struct cvmx_pciercx_cfg021_s cn56xxp1;
+	struct cvmx_pciercx_cfg021_s cn61xx;
 	struct cvmx_pciercx_cfg021_s cn63xx;
 	struct cvmx_pciercx_cfg021_s cn63xxp1;
+	struct cvmx_pciercx_cfg021_s cn66xx;
+	struct cvmx_pciercx_cfg021_s cn68xx;
+	struct cvmx_pciercx_cfg021_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg022 {
@@ -476,8 +565,12 @@ union cvmx_pciercx_cfg022 {
 	struct cvmx_pciercx_cfg022_s cn52xxp1;
 	struct cvmx_pciercx_cfg022_s cn56xx;
 	struct cvmx_pciercx_cfg022_s cn56xxp1;
+	struct cvmx_pciercx_cfg022_s cn61xx;
 	struct cvmx_pciercx_cfg022_s cn63xx;
 	struct cvmx_pciercx_cfg022_s cn63xxp1;
+	struct cvmx_pciercx_cfg022_s cn66xx;
+	struct cvmx_pciercx_cfg022_s cn68xx;
+	struct cvmx_pciercx_cfg022_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg023 {
@@ -490,8 +583,12 @@ union cvmx_pciercx_cfg023 {
 	struct cvmx_pciercx_cfg023_s cn52xxp1;
 	struct cvmx_pciercx_cfg023_s cn56xx;
 	struct cvmx_pciercx_cfg023_s cn56xxp1;
+	struct cvmx_pciercx_cfg023_s cn61xx;
 	struct cvmx_pciercx_cfg023_s cn63xx;
 	struct cvmx_pciercx_cfg023_s cn63xxp1;
+	struct cvmx_pciercx_cfg023_s cn66xx;
+	struct cvmx_pciercx_cfg023_s cn68xx;
+	struct cvmx_pciercx_cfg023_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg028 {
@@ -509,8 +606,12 @@ union cvmx_pciercx_cfg028 {
 	struct cvmx_pciercx_cfg028_s cn52xxp1;
 	struct cvmx_pciercx_cfg028_s cn56xx;
 	struct cvmx_pciercx_cfg028_s cn56xxp1;
+	struct cvmx_pciercx_cfg028_s cn61xx;
 	struct cvmx_pciercx_cfg028_s cn63xx;
 	struct cvmx_pciercx_cfg028_s cn63xxp1;
+	struct cvmx_pciercx_cfg028_s cn66xx;
+	struct cvmx_pciercx_cfg028_s cn68xx;
+	struct cvmx_pciercx_cfg028_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg029 {
@@ -532,8 +633,12 @@ union cvmx_pciercx_cfg029 {
 	struct cvmx_pciercx_cfg029_s cn52xxp1;
 	struct cvmx_pciercx_cfg029_s cn56xx;
 	struct cvmx_pciercx_cfg029_s cn56xxp1;
+	struct cvmx_pciercx_cfg029_s cn61xx;
 	struct cvmx_pciercx_cfg029_s cn63xx;
 	struct cvmx_pciercx_cfg029_s cn63xxp1;
+	struct cvmx_pciercx_cfg029_s cn66xx;
+	struct cvmx_pciercx_cfg029_s cn68xx;
+	struct cvmx_pciercx_cfg029_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg030 {
@@ -563,15 +668,20 @@ union cvmx_pciercx_cfg030 {
 	struct cvmx_pciercx_cfg030_s cn52xxp1;
 	struct cvmx_pciercx_cfg030_s cn56xx;
 	struct cvmx_pciercx_cfg030_s cn56xxp1;
+	struct cvmx_pciercx_cfg030_s cn61xx;
 	struct cvmx_pciercx_cfg030_s cn63xx;
 	struct cvmx_pciercx_cfg030_s cn63xxp1;
+	struct cvmx_pciercx_cfg030_s cn66xx;
+	struct cvmx_pciercx_cfg030_s cn68xx;
+	struct cvmx_pciercx_cfg030_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg031 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg031_s {
 		uint32_t pnum:8;
-		uint32_t reserved_22_23:2;
+		uint32_t reserved_23_23:1;
+		uint32_t aspm:1;
 		uint32_t lbnc:1;
 		uint32_t dllarc:1;
 		uint32_t sderc:1;
@@ -582,12 +692,28 @@ union cvmx_pciercx_cfg031 {
 		uint32_t mlw:6;
 		uint32_t mls:4;
 	} s;
-	struct cvmx_pciercx_cfg031_s cn52xx;
-	struct cvmx_pciercx_cfg031_s cn52xxp1;
-	struct cvmx_pciercx_cfg031_s cn56xx;
-	struct cvmx_pciercx_cfg031_s cn56xxp1;
-	struct cvmx_pciercx_cfg031_s cn63xx;
-	struct cvmx_pciercx_cfg031_s cn63xxp1;
+	struct cvmx_pciercx_cfg031_cn52xx {
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
+	} cn52xx;
+	struct cvmx_pciercx_cfg031_cn52xx cn52xxp1;
+	struct cvmx_pciercx_cfg031_cn52xx cn56xx;
+	struct cvmx_pciercx_cfg031_cn52xx cn56xxp1;
+	struct cvmx_pciercx_cfg031_s cn61xx;
+	struct cvmx_pciercx_cfg031_cn52xx cn63xx;
+	struct cvmx_pciercx_cfg031_cn52xx cn63xxp1;
+	struct cvmx_pciercx_cfg031_s cn66xx;
+	struct cvmx_pciercx_cfg031_s cn68xx;
+	struct cvmx_pciercx_cfg031_cn52xx cn68xxp1;
 };
 
 union cvmx_pciercx_cfg032 {
@@ -618,8 +744,12 @@ union cvmx_pciercx_cfg032 {
 	struct cvmx_pciercx_cfg032_s cn52xxp1;
 	struct cvmx_pciercx_cfg032_s cn56xx;
 	struct cvmx_pciercx_cfg032_s cn56xxp1;
+	struct cvmx_pciercx_cfg032_s cn61xx;
 	struct cvmx_pciercx_cfg032_s cn63xx;
 	struct cvmx_pciercx_cfg032_s cn63xxp1;
+	struct cvmx_pciercx_cfg032_s cn66xx;
+	struct cvmx_pciercx_cfg032_s cn68xx;
+	struct cvmx_pciercx_cfg032_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg033 {
@@ -642,8 +772,12 @@ union cvmx_pciercx_cfg033 {
 	struct cvmx_pciercx_cfg033_s cn52xxp1;
 	struct cvmx_pciercx_cfg033_s cn56xx;
 	struct cvmx_pciercx_cfg033_s cn56xxp1;
+	struct cvmx_pciercx_cfg033_s cn61xx;
 	struct cvmx_pciercx_cfg033_s cn63xx;
 	struct cvmx_pciercx_cfg033_s cn63xxp1;
+	struct cvmx_pciercx_cfg033_s cn66xx;
+	struct cvmx_pciercx_cfg033_s cn68xx;
+	struct cvmx_pciercx_cfg033_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg034 {
@@ -676,8 +810,12 @@ union cvmx_pciercx_cfg034 {
 	struct cvmx_pciercx_cfg034_s cn52xxp1;
 	struct cvmx_pciercx_cfg034_s cn56xx;
 	struct cvmx_pciercx_cfg034_s cn56xxp1;
+	struct cvmx_pciercx_cfg034_s cn61xx;
 	struct cvmx_pciercx_cfg034_s cn63xx;
 	struct cvmx_pciercx_cfg034_s cn63xxp1;
+	struct cvmx_pciercx_cfg034_s cn66xx;
+	struct cvmx_pciercx_cfg034_s cn68xx;
+	struct cvmx_pciercx_cfg034_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg035 {
@@ -696,8 +834,12 @@ union cvmx_pciercx_cfg035 {
 	struct cvmx_pciercx_cfg035_s cn52xxp1;
 	struct cvmx_pciercx_cfg035_s cn56xx;
 	struct cvmx_pciercx_cfg035_s cn56xxp1;
+	struct cvmx_pciercx_cfg035_s cn61xx;
 	struct cvmx_pciercx_cfg035_s cn63xx;
 	struct cvmx_pciercx_cfg035_s cn63xxp1;
+	struct cvmx_pciercx_cfg035_s cn66xx;
+	struct cvmx_pciercx_cfg035_s cn68xx;
+	struct cvmx_pciercx_cfg035_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg036 {
@@ -712,38 +854,95 @@ union cvmx_pciercx_cfg036 {
 	struct cvmx_pciercx_cfg036_s cn52xxp1;
 	struct cvmx_pciercx_cfg036_s cn56xx;
 	struct cvmx_pciercx_cfg036_s cn56xxp1;
+	struct cvmx_pciercx_cfg036_s cn61xx;
 	struct cvmx_pciercx_cfg036_s cn63xx;
 	struct cvmx_pciercx_cfg036_s cn63xxp1;
+	struct cvmx_pciercx_cfg036_s cn66xx;
+	struct cvmx_pciercx_cfg036_s cn68xx;
+	struct cvmx_pciercx_cfg036_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg037 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg037_s {
-		uint32_t reserved_5_31:27;
+		uint32_t reserved_14_31:18;
+		uint32_t tph:2;
+		uint32_t reserved_11_11:1;
+		uint32_t noroprpr:1;
+		uint32_t atom128s:1;
+		uint32_t atom64s:1;
+		uint32_t atom32s:1;
+		uint32_t atom_ops:1;
+		uint32_t reserved_5_5:1;
 		uint32_t ctds:1;
 		uint32_t ctrs:4;
 	} s;
-	struct cvmx_pciercx_cfg037_s cn52xx;
-	struct cvmx_pciercx_cfg037_s cn52xxp1;
-	struct cvmx_pciercx_cfg037_s cn56xx;
-	struct cvmx_pciercx_cfg037_s cn56xxp1;
-	struct cvmx_pciercx_cfg037_s cn63xx;
-	struct cvmx_pciercx_cfg037_s cn63xxp1;
+	struct cvmx_pciercx_cfg037_cn52xx {
+		uint32_t reserved_5_31:27;
+		uint32_t ctds:1;
+		uint32_t ctrs:4;
+	} cn52xx;
+	struct cvmx_pciercx_cfg037_cn52xx cn52xxp1;
+	struct cvmx_pciercx_cfg037_cn52xx cn56xx;
+	struct cvmx_pciercx_cfg037_cn52xx cn56xxp1;
+	struct cvmx_pciercx_cfg037_cn61xx {
+		uint32_t reserved_14_31:18;
+		uint32_t tph:2;
+		uint32_t reserved_11_11:1;
+		uint32_t noroprpr:1;
+		uint32_t atom128s:1;
+		uint32_t atom64s:1;
+		uint32_t atom32s:1;
+		uint32_t atom_ops:1;
+		uint32_t ari_fw:1;
+		uint32_t ctds:1;
+		uint32_t ctrs:4;
+	} cn61xx;
+	struct cvmx_pciercx_cfg037_cn52xx cn63xx;
+	struct cvmx_pciercx_cfg037_cn52xx cn63xxp1;
+	struct cvmx_pciercx_cfg037_cn66xx {
+		uint32_t reserved_14_31:18;
+		uint32_t tph:2;
+		uint32_t reserved_11_11:1;
+		uint32_t noroprpr:1;
+		uint32_t atom128s:1;
+		uint32_t atom64s:1;
+		uint32_t atom32s:1;
+		uint32_t atom_ops:1;
+		uint32_t ari:1;
+		uint32_t ctds:1;
+		uint32_t ctrs:4;
+	} cn66xx;
+	struct cvmx_pciercx_cfg037_cn66xx cn68xx;
+	struct cvmx_pciercx_cfg037_cn66xx cn68xxp1;
 };
 
 union cvmx_pciercx_cfg038 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg038_s {
-		uint32_t reserved_5_31:27;
+		uint32_t reserved_10_31:22;
+		uint32_t id0_cp:1;
+		uint32_t id0_rq:1;
+		uint32_t atom_op_eb:1;
+		uint32_t atom_op:1;
+		uint32_t ari:1;
 		uint32_t ctd:1;
 		uint32_t ctv:4;
 	} s;
-	struct cvmx_pciercx_cfg038_s cn52xx;
-	struct cvmx_pciercx_cfg038_s cn52xxp1;
-	struct cvmx_pciercx_cfg038_s cn56xx;
-	struct cvmx_pciercx_cfg038_s cn56xxp1;
-	struct cvmx_pciercx_cfg038_s cn63xx;
-	struct cvmx_pciercx_cfg038_s cn63xxp1;
+	struct cvmx_pciercx_cfg038_cn52xx {
+		uint32_t reserved_5_31:27;
+		uint32_t ctd:1;
+		uint32_t ctv:4;
+	} cn52xx;
+	struct cvmx_pciercx_cfg038_cn52xx cn52xxp1;
+	struct cvmx_pciercx_cfg038_cn52xx cn56xx;
+	struct cvmx_pciercx_cfg038_cn52xx cn56xxp1;
+	struct cvmx_pciercx_cfg038_s cn61xx;
+	struct cvmx_pciercx_cfg038_cn52xx cn63xx;
+	struct cvmx_pciercx_cfg038_cn52xx cn63xxp1;
+	struct cvmx_pciercx_cfg038_s cn66xx;
+	struct cvmx_pciercx_cfg038_s cn68xx;
+	struct cvmx_pciercx_cfg038_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg039 {
@@ -760,8 +959,12 @@ union cvmx_pciercx_cfg039 {
 	struct cvmx_pciercx_cfg039_cn52xx cn52xxp1;
 	struct cvmx_pciercx_cfg039_cn52xx cn56xx;
 	struct cvmx_pciercx_cfg039_cn52xx cn56xxp1;
+	struct cvmx_pciercx_cfg039_s cn61xx;
 	struct cvmx_pciercx_cfg039_s cn63xx;
 	struct cvmx_pciercx_cfg039_cn52xx cn63xxp1;
+	struct cvmx_pciercx_cfg039_s cn66xx;
+	struct cvmx_pciercx_cfg039_s cn68xx;
+	struct cvmx_pciercx_cfg039_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg040 {
@@ -785,8 +988,12 @@ union cvmx_pciercx_cfg040 {
 	struct cvmx_pciercx_cfg040_cn52xx cn52xxp1;
 	struct cvmx_pciercx_cfg040_cn52xx cn56xx;
 	struct cvmx_pciercx_cfg040_cn52xx cn56xxp1;
+	struct cvmx_pciercx_cfg040_s cn61xx;
 	struct cvmx_pciercx_cfg040_s cn63xx;
 	struct cvmx_pciercx_cfg040_s cn63xxp1;
+	struct cvmx_pciercx_cfg040_s cn66xx;
+	struct cvmx_pciercx_cfg040_s cn68xx;
+	struct cvmx_pciercx_cfg040_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg041 {
@@ -798,8 +1005,12 @@ union cvmx_pciercx_cfg041 {
 	struct cvmx_pciercx_cfg041_s cn52xxp1;
 	struct cvmx_pciercx_cfg041_s cn56xx;
 	struct cvmx_pciercx_cfg041_s cn56xxp1;
+	struct cvmx_pciercx_cfg041_s cn61xx;
 	struct cvmx_pciercx_cfg041_s cn63xx;
 	struct cvmx_pciercx_cfg041_s cn63xxp1;
+	struct cvmx_pciercx_cfg041_s cn66xx;
+	struct cvmx_pciercx_cfg041_s cn68xx;
+	struct cvmx_pciercx_cfg041_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg042 {
@@ -811,8 +1022,12 @@ union cvmx_pciercx_cfg042 {
 	struct cvmx_pciercx_cfg042_s cn52xxp1;
 	struct cvmx_pciercx_cfg042_s cn56xx;
 	struct cvmx_pciercx_cfg042_s cn56xxp1;
+	struct cvmx_pciercx_cfg042_s cn61xx;
 	struct cvmx_pciercx_cfg042_s cn63xx;
 	struct cvmx_pciercx_cfg042_s cn63xxp1;
+	struct cvmx_pciercx_cfg042_s cn66xx;
+	struct cvmx_pciercx_cfg042_s cn68xx;
+	struct cvmx_pciercx_cfg042_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg064 {
@@ -826,14 +1041,20 @@ union cvmx_pciercx_cfg064 {
 	struct cvmx_pciercx_cfg064_s cn52xxp1;
 	struct cvmx_pciercx_cfg064_s cn56xx;
 	struct cvmx_pciercx_cfg064_s cn56xxp1;
+	struct cvmx_pciercx_cfg064_s cn61xx;
 	struct cvmx_pciercx_cfg064_s cn63xx;
 	struct cvmx_pciercx_cfg064_s cn63xxp1;
+	struct cvmx_pciercx_cfg064_s cn66xx;
+	struct cvmx_pciercx_cfg064_s cn68xx;
+	struct cvmx_pciercx_cfg064_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg065 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg065_s {
-		uint32_t reserved_21_31:11;
+		uint32_t reserved_25_31:7;
+		uint32_t uatombs:1;
+		uint32_t reserved_21_23:3;
 		uint32_t ures:1;
 		uint32_t ecrces:1;
 		uint32_t mtlps:1;
@@ -848,18 +1069,39 @@ union cvmx_pciercx_cfg065 {
 		uint32_t dlpes:1;
 		uint32_t reserved_0_3:4;
 	} s;
-	struct cvmx_pciercx_cfg065_s cn52xx;
-	struct cvmx_pciercx_cfg065_s cn52xxp1;
-	struct cvmx_pciercx_cfg065_s cn56xx;
-	struct cvmx_pciercx_cfg065_s cn56xxp1;
-	struct cvmx_pciercx_cfg065_s cn63xx;
-	struct cvmx_pciercx_cfg065_s cn63xxp1;
+	struct cvmx_pciercx_cfg065_cn52xx {
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
+	} cn52xx;
+	struct cvmx_pciercx_cfg065_cn52xx cn52xxp1;
+	struct cvmx_pciercx_cfg065_cn52xx cn56xx;
+	struct cvmx_pciercx_cfg065_cn52xx cn56xxp1;
+	struct cvmx_pciercx_cfg065_s cn61xx;
+	struct cvmx_pciercx_cfg065_cn52xx cn63xx;
+	struct cvmx_pciercx_cfg065_cn52xx cn63xxp1;
+	struct cvmx_pciercx_cfg065_s cn66xx;
+	struct cvmx_pciercx_cfg065_s cn68xx;
+	struct cvmx_pciercx_cfg065_cn52xx cn68xxp1;
 };
 
 union cvmx_pciercx_cfg066 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg066_s {
-		uint32_t reserved_21_31:11;
+		uint32_t reserved_25_31:7;
+		uint32_t uatombm:1;
+		uint32_t reserved_21_23:3;
 		uint32_t urem:1;
 		uint32_t ecrcem:1;
 		uint32_t mtlpm:1;
@@ -874,18 +1116,39 @@ union cvmx_pciercx_cfg066 {
 		uint32_t dlpem:1;
 		uint32_t reserved_0_3:4;
 	} s;
-	struct cvmx_pciercx_cfg066_s cn52xx;
-	struct cvmx_pciercx_cfg066_s cn52xxp1;
-	struct cvmx_pciercx_cfg066_s cn56xx;
-	struct cvmx_pciercx_cfg066_s cn56xxp1;
-	struct cvmx_pciercx_cfg066_s cn63xx;
-	struct cvmx_pciercx_cfg066_s cn63xxp1;
+	struct cvmx_pciercx_cfg066_cn52xx {
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
+	} cn52xx;
+	struct cvmx_pciercx_cfg066_cn52xx cn52xxp1;
+	struct cvmx_pciercx_cfg066_cn52xx cn56xx;
+	struct cvmx_pciercx_cfg066_cn52xx cn56xxp1;
+	struct cvmx_pciercx_cfg066_s cn61xx;
+	struct cvmx_pciercx_cfg066_cn52xx cn63xx;
+	struct cvmx_pciercx_cfg066_cn52xx cn63xxp1;
+	struct cvmx_pciercx_cfg066_s cn66xx;
+	struct cvmx_pciercx_cfg066_s cn68xx;
+	struct cvmx_pciercx_cfg066_cn52xx cn68xxp1;
 };
 
 union cvmx_pciercx_cfg067 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg067_s {
-		uint32_t reserved_21_31:11;
+		uint32_t reserved_25_31:7;
+		uint32_t uatombs:1;
+		uint32_t reserved_21_23:3;
 		uint32_t ures:1;
 		uint32_t ecrces:1;
 		uint32_t mtlps:1;
@@ -900,12 +1163,31 @@ union cvmx_pciercx_cfg067 {
 		uint32_t dlpes:1;
 		uint32_t reserved_0_3:4;
 	} s;
-	struct cvmx_pciercx_cfg067_s cn52xx;
-	struct cvmx_pciercx_cfg067_s cn52xxp1;
-	struct cvmx_pciercx_cfg067_s cn56xx;
-	struct cvmx_pciercx_cfg067_s cn56xxp1;
-	struct cvmx_pciercx_cfg067_s cn63xx;
-	struct cvmx_pciercx_cfg067_s cn63xxp1;
+	struct cvmx_pciercx_cfg067_cn52xx {
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
+	} cn52xx;
+	struct cvmx_pciercx_cfg067_cn52xx cn52xxp1;
+	struct cvmx_pciercx_cfg067_cn52xx cn56xx;
+	struct cvmx_pciercx_cfg067_cn52xx cn56xxp1;
+	struct cvmx_pciercx_cfg067_s cn61xx;
+	struct cvmx_pciercx_cfg067_cn52xx cn63xx;
+	struct cvmx_pciercx_cfg067_cn52xx cn63xxp1;
+	struct cvmx_pciercx_cfg067_s cn66xx;
+	struct cvmx_pciercx_cfg067_s cn68xx;
+	struct cvmx_pciercx_cfg067_cn52xx cn68xxp1;
 };
 
 union cvmx_pciercx_cfg068 {
@@ -925,8 +1207,12 @@ union cvmx_pciercx_cfg068 {
 	struct cvmx_pciercx_cfg068_s cn52xxp1;
 	struct cvmx_pciercx_cfg068_s cn56xx;
 	struct cvmx_pciercx_cfg068_s cn56xxp1;
+	struct cvmx_pciercx_cfg068_s cn61xx;
 	struct cvmx_pciercx_cfg068_s cn63xx;
 	struct cvmx_pciercx_cfg068_s cn63xxp1;
+	struct cvmx_pciercx_cfg068_s cn66xx;
+	struct cvmx_pciercx_cfg068_s cn68xx;
+	struct cvmx_pciercx_cfg068_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg069 {
@@ -946,8 +1232,12 @@ union cvmx_pciercx_cfg069 {
 	struct cvmx_pciercx_cfg069_s cn52xxp1;
 	struct cvmx_pciercx_cfg069_s cn56xx;
 	struct cvmx_pciercx_cfg069_s cn56xxp1;
+	struct cvmx_pciercx_cfg069_s cn61xx;
 	struct cvmx_pciercx_cfg069_s cn63xx;
 	struct cvmx_pciercx_cfg069_s cn63xxp1;
+	struct cvmx_pciercx_cfg069_s cn66xx;
+	struct cvmx_pciercx_cfg069_s cn68xx;
+	struct cvmx_pciercx_cfg069_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg070 {
@@ -964,8 +1254,12 @@ union cvmx_pciercx_cfg070 {
 	struct cvmx_pciercx_cfg070_s cn52xxp1;
 	struct cvmx_pciercx_cfg070_s cn56xx;
 	struct cvmx_pciercx_cfg070_s cn56xxp1;
+	struct cvmx_pciercx_cfg070_s cn61xx;
 	struct cvmx_pciercx_cfg070_s cn63xx;
 	struct cvmx_pciercx_cfg070_s cn63xxp1;
+	struct cvmx_pciercx_cfg070_s cn66xx;
+	struct cvmx_pciercx_cfg070_s cn68xx;
+	struct cvmx_pciercx_cfg070_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg071 {
@@ -977,8 +1271,12 @@ union cvmx_pciercx_cfg071 {
 	struct cvmx_pciercx_cfg071_s cn52xxp1;
 	struct cvmx_pciercx_cfg071_s cn56xx;
 	struct cvmx_pciercx_cfg071_s cn56xxp1;
+	struct cvmx_pciercx_cfg071_s cn61xx;
 	struct cvmx_pciercx_cfg071_s cn63xx;
 	struct cvmx_pciercx_cfg071_s cn63xxp1;
+	struct cvmx_pciercx_cfg071_s cn66xx;
+	struct cvmx_pciercx_cfg071_s cn68xx;
+	struct cvmx_pciercx_cfg071_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg072 {
@@ -990,8 +1288,12 @@ union cvmx_pciercx_cfg072 {
 	struct cvmx_pciercx_cfg072_s cn52xxp1;
 	struct cvmx_pciercx_cfg072_s cn56xx;
 	struct cvmx_pciercx_cfg072_s cn56xxp1;
+	struct cvmx_pciercx_cfg072_s cn61xx;
 	struct cvmx_pciercx_cfg072_s cn63xx;
 	struct cvmx_pciercx_cfg072_s cn63xxp1;
+	struct cvmx_pciercx_cfg072_s cn66xx;
+	struct cvmx_pciercx_cfg072_s cn68xx;
+	struct cvmx_pciercx_cfg072_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg073 {
@@ -1003,8 +1305,12 @@ union cvmx_pciercx_cfg073 {
 	struct cvmx_pciercx_cfg073_s cn52xxp1;
 	struct cvmx_pciercx_cfg073_s cn56xx;
 	struct cvmx_pciercx_cfg073_s cn56xxp1;
+	struct cvmx_pciercx_cfg073_s cn61xx;
 	struct cvmx_pciercx_cfg073_s cn63xx;
 	struct cvmx_pciercx_cfg073_s cn63xxp1;
+	struct cvmx_pciercx_cfg073_s cn66xx;
+	struct cvmx_pciercx_cfg073_s cn68xx;
+	struct cvmx_pciercx_cfg073_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg074 {
@@ -1016,8 +1322,12 @@ union cvmx_pciercx_cfg074 {
 	struct cvmx_pciercx_cfg074_s cn52xxp1;
 	struct cvmx_pciercx_cfg074_s cn56xx;
 	struct cvmx_pciercx_cfg074_s cn56xxp1;
+	struct cvmx_pciercx_cfg074_s cn61xx;
 	struct cvmx_pciercx_cfg074_s cn63xx;
 	struct cvmx_pciercx_cfg074_s cn63xxp1;
+	struct cvmx_pciercx_cfg074_s cn66xx;
+	struct cvmx_pciercx_cfg074_s cn68xx;
+	struct cvmx_pciercx_cfg074_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg075 {
@@ -1032,8 +1342,12 @@ union cvmx_pciercx_cfg075 {
 	struct cvmx_pciercx_cfg075_s cn52xxp1;
 	struct cvmx_pciercx_cfg075_s cn56xx;
 	struct cvmx_pciercx_cfg075_s cn56xxp1;
+	struct cvmx_pciercx_cfg075_s cn61xx;
 	struct cvmx_pciercx_cfg075_s cn63xx;
 	struct cvmx_pciercx_cfg075_s cn63xxp1;
+	struct cvmx_pciercx_cfg075_s cn66xx;
+	struct cvmx_pciercx_cfg075_s cn68xx;
+	struct cvmx_pciercx_cfg075_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg076 {
@@ -1053,8 +1367,12 @@ union cvmx_pciercx_cfg076 {
 	struct cvmx_pciercx_cfg076_s cn52xxp1;
 	struct cvmx_pciercx_cfg076_s cn56xx;
 	struct cvmx_pciercx_cfg076_s cn56xxp1;
+	struct cvmx_pciercx_cfg076_s cn61xx;
 	struct cvmx_pciercx_cfg076_s cn63xx;
 	struct cvmx_pciercx_cfg076_s cn63xxp1;
+	struct cvmx_pciercx_cfg076_s cn66xx;
+	struct cvmx_pciercx_cfg076_s cn68xx;
+	struct cvmx_pciercx_cfg076_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg077 {
@@ -1067,8 +1385,12 @@ union cvmx_pciercx_cfg077 {
 	struct cvmx_pciercx_cfg077_s cn52xxp1;
 	struct cvmx_pciercx_cfg077_s cn56xx;
 	struct cvmx_pciercx_cfg077_s cn56xxp1;
+	struct cvmx_pciercx_cfg077_s cn61xx;
 	struct cvmx_pciercx_cfg077_s cn63xx;
 	struct cvmx_pciercx_cfg077_s cn63xxp1;
+	struct cvmx_pciercx_cfg077_s cn66xx;
+	struct cvmx_pciercx_cfg077_s cn68xx;
+	struct cvmx_pciercx_cfg077_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg448 {
@@ -1081,8 +1403,12 @@ union cvmx_pciercx_cfg448 {
 	struct cvmx_pciercx_cfg448_s cn52xxp1;
 	struct cvmx_pciercx_cfg448_s cn56xx;
 	struct cvmx_pciercx_cfg448_s cn56xxp1;
+	struct cvmx_pciercx_cfg448_s cn61xx;
 	struct cvmx_pciercx_cfg448_s cn63xx;
 	struct cvmx_pciercx_cfg448_s cn63xxp1;
+	struct cvmx_pciercx_cfg448_s cn66xx;
+	struct cvmx_pciercx_cfg448_s cn68xx;
+	struct cvmx_pciercx_cfg448_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg449 {
@@ -1094,8 +1420,12 @@ union cvmx_pciercx_cfg449 {
 	struct cvmx_pciercx_cfg449_s cn52xxp1;
 	struct cvmx_pciercx_cfg449_s cn56xx;
 	struct cvmx_pciercx_cfg449_s cn56xxp1;
+	struct cvmx_pciercx_cfg449_s cn61xx;
 	struct cvmx_pciercx_cfg449_s cn63xx;
 	struct cvmx_pciercx_cfg449_s cn63xxp1;
+	struct cvmx_pciercx_cfg449_s cn66xx;
+	struct cvmx_pciercx_cfg449_s cn68xx;
+	struct cvmx_pciercx_cfg449_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg450 {
@@ -1112,26 +1442,42 @@ union cvmx_pciercx_cfg450 {
 	struct cvmx_pciercx_cfg450_s cn52xxp1;
 	struct cvmx_pciercx_cfg450_s cn56xx;
 	struct cvmx_pciercx_cfg450_s cn56xxp1;
+	struct cvmx_pciercx_cfg450_s cn61xx;
 	struct cvmx_pciercx_cfg450_s cn63xx;
 	struct cvmx_pciercx_cfg450_s cn63xxp1;
+	struct cvmx_pciercx_cfg450_s cn66xx;
+	struct cvmx_pciercx_cfg450_s cn68xx;
+	struct cvmx_pciercx_cfg450_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg451 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg451_s {
-		uint32_t reserved_30_31:2;
+		uint32_t reserved_31_31:1;
+		uint32_t easpml1:1;
 		uint32_t l1el:3;
 		uint32_t l0el:3;
 		uint32_t n_fts_cc:8;
 		uint32_t n_fts:8;
 		uint32_t ack_freq:8;
 	} s;
-	struct cvmx_pciercx_cfg451_s cn52xx;
-	struct cvmx_pciercx_cfg451_s cn52xxp1;
-	struct cvmx_pciercx_cfg451_s cn56xx;
-	struct cvmx_pciercx_cfg451_s cn56xxp1;
-	struct cvmx_pciercx_cfg451_s cn63xx;
-	struct cvmx_pciercx_cfg451_s cn63xxp1;
+	struct cvmx_pciercx_cfg451_cn52xx {
+		uint32_t reserved_30_31:2;
+		uint32_t l1el:3;
+		uint32_t l0el:3;
+		uint32_t n_fts_cc:8;
+		uint32_t n_fts:8;
+		uint32_t ack_freq:8;
+	} cn52xx;
+	struct cvmx_pciercx_cfg451_cn52xx cn52xxp1;
+	struct cvmx_pciercx_cfg451_cn52xx cn56xx;
+	struct cvmx_pciercx_cfg451_cn52xx cn56xxp1;
+	struct cvmx_pciercx_cfg451_s cn61xx;
+	struct cvmx_pciercx_cfg451_cn52xx cn63xx;
+	struct cvmx_pciercx_cfg451_cn52xx cn63xxp1;
+	struct cvmx_pciercx_cfg451_s cn66xx;
+	struct cvmx_pciercx_cfg451_s cn68xx;
+	struct cvmx_pciercx_cfg451_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg452 {
@@ -1155,8 +1501,24 @@ union cvmx_pciercx_cfg452 {
 	struct cvmx_pciercx_cfg452_s cn52xxp1;
 	struct cvmx_pciercx_cfg452_s cn56xx;
 	struct cvmx_pciercx_cfg452_s cn56xxp1;
+	struct cvmx_pciercx_cfg452_cn61xx {
+		uint32_t reserved_22_31:10;
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
+	} cn61xx;
 	struct cvmx_pciercx_cfg452_s cn63xx;
 	struct cvmx_pciercx_cfg452_s cn63xxp1;
+	struct cvmx_pciercx_cfg452_cn61xx cn66xx;
+	struct cvmx_pciercx_cfg452_cn61xx cn68xx;
+	struct cvmx_pciercx_cfg452_cn61xx cn68xxp1;
 };
 
 union cvmx_pciercx_cfg453 {
@@ -1172,13 +1534,26 @@ union cvmx_pciercx_cfg453 {
 	struct cvmx_pciercx_cfg453_s cn52xxp1;
 	struct cvmx_pciercx_cfg453_s cn56xx;
 	struct cvmx_pciercx_cfg453_s cn56xxp1;
+	struct cvmx_pciercx_cfg453_s cn61xx;
 	struct cvmx_pciercx_cfg453_s cn63xx;
 	struct cvmx_pciercx_cfg453_s cn63xxp1;
+	struct cvmx_pciercx_cfg453_s cn66xx;
+	struct cvmx_pciercx_cfg453_s cn68xx;
+	struct cvmx_pciercx_cfg453_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg454 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg454_s {
+		uint32_t cx_nfunc:3;
+		uint32_t tmfcwt:5;
+		uint32_t tmanlt:5;
+		uint32_t tmrt:5;
+		uint32_t reserved_11_13:3;
+		uint32_t nskps:3;
+		uint32_t reserved_0_7:8;
+	} s;
+	struct cvmx_pciercx_cfg454_cn52xx {
 		uint32_t reserved_29_31:3;
 		uint32_t tmfcwt:5;
 		uint32_t tmanlt:5;
@@ -1187,13 +1562,23 @@ union cvmx_pciercx_cfg454 {
 		uint32_t nskps:3;
 		uint32_t reserved_4_7:4;
 		uint32_t ntss:4;
-	} s;
-	struct cvmx_pciercx_cfg454_s cn52xx;
-	struct cvmx_pciercx_cfg454_s cn52xxp1;
-	struct cvmx_pciercx_cfg454_s cn56xx;
-	struct cvmx_pciercx_cfg454_s cn56xxp1;
-	struct cvmx_pciercx_cfg454_s cn63xx;
-	struct cvmx_pciercx_cfg454_s cn63xxp1;
+	} cn52xx;
+	struct cvmx_pciercx_cfg454_cn52xx cn52xxp1;
+	struct cvmx_pciercx_cfg454_cn52xx cn56xx;
+	struct cvmx_pciercx_cfg454_cn52xx cn56xxp1;
+	struct cvmx_pciercx_cfg454_cn61xx {
+		uint32_t cx_nfunc:3;
+		uint32_t tmfcwt:5;
+		uint32_t tmanlt:5;
+		uint32_t tmrt:5;
+		uint32_t reserved_8_13:6;
+		uint32_t mfuncn:8;
+	} cn61xx;
+	struct cvmx_pciercx_cfg454_cn52xx cn63xx;
+	struct cvmx_pciercx_cfg454_cn52xx cn63xxp1;
+	struct cvmx_pciercx_cfg454_cn61xx cn66xx;
+	struct cvmx_pciercx_cfg454_cn61xx cn68xx;
+	struct cvmx_pciercx_cfg454_cn52xx cn68xxp1;
 };
 
 union cvmx_pciercx_cfg455 {
@@ -1223,23 +1608,37 @@ union cvmx_pciercx_cfg455 {
 	struct cvmx_pciercx_cfg455_s cn52xxp1;
 	struct cvmx_pciercx_cfg455_s cn56xx;
 	struct cvmx_pciercx_cfg455_s cn56xxp1;
+	struct cvmx_pciercx_cfg455_s cn61xx;
 	struct cvmx_pciercx_cfg455_s cn63xx;
 	struct cvmx_pciercx_cfg455_s cn63xxp1;
+	struct cvmx_pciercx_cfg455_s cn66xx;
+	struct cvmx_pciercx_cfg455_s cn68xx;
+	struct cvmx_pciercx_cfg455_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg456 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg456_s {
-		uint32_t reserved_2_31:30;
+		uint32_t reserved_4_31:28;
+		uint32_t m_handle_flush:1;
+		uint32_t m_dabort_4ucpl:1;
 		uint32_t m_vend1_drp:1;
 		uint32_t m_vend0_drp:1;
 	} s;
-	struct cvmx_pciercx_cfg456_s cn52xx;
-	struct cvmx_pciercx_cfg456_s cn52xxp1;
-	struct cvmx_pciercx_cfg456_s cn56xx;
-	struct cvmx_pciercx_cfg456_s cn56xxp1;
-	struct cvmx_pciercx_cfg456_s cn63xx;
-	struct cvmx_pciercx_cfg456_s cn63xxp1;
+	struct cvmx_pciercx_cfg456_cn52xx {
+		uint32_t reserved_2_31:30;
+		uint32_t m_vend1_drp:1;
+		uint32_t m_vend0_drp:1;
+	} cn52xx;
+	struct cvmx_pciercx_cfg456_cn52xx cn52xxp1;
+	struct cvmx_pciercx_cfg456_cn52xx cn56xx;
+	struct cvmx_pciercx_cfg456_cn52xx cn56xxp1;
+	struct cvmx_pciercx_cfg456_s cn61xx;
+	struct cvmx_pciercx_cfg456_cn52xx cn63xx;
+	struct cvmx_pciercx_cfg456_cn52xx cn63xxp1;
+	struct cvmx_pciercx_cfg456_s cn66xx;
+	struct cvmx_pciercx_cfg456_s cn68xx;
+	struct cvmx_pciercx_cfg456_cn52xx cn68xxp1;
 };
 
 union cvmx_pciercx_cfg458 {
@@ -1251,8 +1650,12 @@ union cvmx_pciercx_cfg458 {
 	struct cvmx_pciercx_cfg458_s cn52xxp1;
 	struct cvmx_pciercx_cfg458_s cn56xx;
 	struct cvmx_pciercx_cfg458_s cn56xxp1;
+	struct cvmx_pciercx_cfg458_s cn61xx;
 	struct cvmx_pciercx_cfg458_s cn63xx;
 	struct cvmx_pciercx_cfg458_s cn63xxp1;
+	struct cvmx_pciercx_cfg458_s cn66xx;
+	struct cvmx_pciercx_cfg458_s cn68xx;
+	struct cvmx_pciercx_cfg458_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg459 {
@@ -1264,8 +1667,12 @@ union cvmx_pciercx_cfg459 {
 	struct cvmx_pciercx_cfg459_s cn52xxp1;
 	struct cvmx_pciercx_cfg459_s cn56xx;
 	struct cvmx_pciercx_cfg459_s cn56xxp1;
+	struct cvmx_pciercx_cfg459_s cn61xx;
 	struct cvmx_pciercx_cfg459_s cn63xx;
 	struct cvmx_pciercx_cfg459_s cn63xxp1;
+	struct cvmx_pciercx_cfg459_s cn66xx;
+	struct cvmx_pciercx_cfg459_s cn68xx;
+	struct cvmx_pciercx_cfg459_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg460 {
@@ -1279,8 +1686,12 @@ union cvmx_pciercx_cfg460 {
 	struct cvmx_pciercx_cfg460_s cn52xxp1;
 	struct cvmx_pciercx_cfg460_s cn56xx;
 	struct cvmx_pciercx_cfg460_s cn56xxp1;
+	struct cvmx_pciercx_cfg460_s cn61xx;
 	struct cvmx_pciercx_cfg460_s cn63xx;
 	struct cvmx_pciercx_cfg460_s cn63xxp1;
+	struct cvmx_pciercx_cfg460_s cn66xx;
+	struct cvmx_pciercx_cfg460_s cn68xx;
+	struct cvmx_pciercx_cfg460_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg461 {
@@ -1294,8 +1705,12 @@ union cvmx_pciercx_cfg461 {
 	struct cvmx_pciercx_cfg461_s cn52xxp1;
 	struct cvmx_pciercx_cfg461_s cn56xx;
 	struct cvmx_pciercx_cfg461_s cn56xxp1;
+	struct cvmx_pciercx_cfg461_s cn61xx;
 	struct cvmx_pciercx_cfg461_s cn63xx;
 	struct cvmx_pciercx_cfg461_s cn63xxp1;
+	struct cvmx_pciercx_cfg461_s cn66xx;
+	struct cvmx_pciercx_cfg461_s cn68xx;
+	struct cvmx_pciercx_cfg461_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg462 {
@@ -1309,8 +1724,12 @@ union cvmx_pciercx_cfg462 {
 	struct cvmx_pciercx_cfg462_s cn52xxp1;
 	struct cvmx_pciercx_cfg462_s cn56xx;
 	struct cvmx_pciercx_cfg462_s cn56xxp1;
+	struct cvmx_pciercx_cfg462_s cn61xx;
 	struct cvmx_pciercx_cfg462_s cn63xx;
 	struct cvmx_pciercx_cfg462_s cn63xxp1;
+	struct cvmx_pciercx_cfg462_s cn66xx;
+	struct cvmx_pciercx_cfg462_s cn68xx;
+	struct cvmx_pciercx_cfg462_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg463 {
@@ -1325,8 +1744,12 @@ union cvmx_pciercx_cfg463 {
 	struct cvmx_pciercx_cfg463_s cn52xxp1;
 	struct cvmx_pciercx_cfg463_s cn56xx;
 	struct cvmx_pciercx_cfg463_s cn56xxp1;
+	struct cvmx_pciercx_cfg463_s cn61xx;
 	struct cvmx_pciercx_cfg463_s cn63xx;
 	struct cvmx_pciercx_cfg463_s cn63xxp1;
+	struct cvmx_pciercx_cfg463_s cn66xx;
+	struct cvmx_pciercx_cfg463_s cn68xx;
+	struct cvmx_pciercx_cfg463_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg464 {
@@ -1341,8 +1764,12 @@ union cvmx_pciercx_cfg464 {
 	struct cvmx_pciercx_cfg464_s cn52xxp1;
 	struct cvmx_pciercx_cfg464_s cn56xx;
 	struct cvmx_pciercx_cfg464_s cn56xxp1;
+	struct cvmx_pciercx_cfg464_s cn61xx;
 	struct cvmx_pciercx_cfg464_s cn63xx;
 	struct cvmx_pciercx_cfg464_s cn63xxp1;
+	struct cvmx_pciercx_cfg464_s cn66xx;
+	struct cvmx_pciercx_cfg464_s cn68xx;
+	struct cvmx_pciercx_cfg464_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg465 {
@@ -1357,8 +1784,12 @@ union cvmx_pciercx_cfg465 {
 	struct cvmx_pciercx_cfg465_s cn52xxp1;
 	struct cvmx_pciercx_cfg465_s cn56xx;
 	struct cvmx_pciercx_cfg465_s cn56xxp1;
+	struct cvmx_pciercx_cfg465_s cn61xx;
 	struct cvmx_pciercx_cfg465_s cn63xx;
 	struct cvmx_pciercx_cfg465_s cn63xxp1;
+	struct cvmx_pciercx_cfg465_s cn66xx;
+	struct cvmx_pciercx_cfg465_s cn68xx;
+	struct cvmx_pciercx_cfg465_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg466 {
@@ -1376,8 +1807,12 @@ union cvmx_pciercx_cfg466 {
 	struct cvmx_pciercx_cfg466_s cn52xxp1;
 	struct cvmx_pciercx_cfg466_s cn56xx;
 	struct cvmx_pciercx_cfg466_s cn56xxp1;
+	struct cvmx_pciercx_cfg466_s cn61xx;
 	struct cvmx_pciercx_cfg466_s cn63xx;
 	struct cvmx_pciercx_cfg466_s cn63xxp1;
+	struct cvmx_pciercx_cfg466_s cn66xx;
+	struct cvmx_pciercx_cfg466_s cn68xx;
+	struct cvmx_pciercx_cfg466_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg467 {
@@ -1393,8 +1828,12 @@ union cvmx_pciercx_cfg467 {
 	struct cvmx_pciercx_cfg467_s cn52xxp1;
 	struct cvmx_pciercx_cfg467_s cn56xx;
 	struct cvmx_pciercx_cfg467_s cn56xxp1;
+	struct cvmx_pciercx_cfg467_s cn61xx;
 	struct cvmx_pciercx_cfg467_s cn63xx;
 	struct cvmx_pciercx_cfg467_s cn63xxp1;
+	struct cvmx_pciercx_cfg467_s cn66xx;
+	struct cvmx_pciercx_cfg467_s cn68xx;
+	struct cvmx_pciercx_cfg467_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg468 {
@@ -1410,8 +1849,12 @@ union cvmx_pciercx_cfg468 {
 	struct cvmx_pciercx_cfg468_s cn52xxp1;
 	struct cvmx_pciercx_cfg468_s cn56xx;
 	struct cvmx_pciercx_cfg468_s cn56xxp1;
+	struct cvmx_pciercx_cfg468_s cn61xx;
 	struct cvmx_pciercx_cfg468_s cn63xx;
 	struct cvmx_pciercx_cfg468_s cn63xxp1;
+	struct cvmx_pciercx_cfg468_s cn66xx;
+	struct cvmx_pciercx_cfg468_s cn68xx;
+	struct cvmx_pciercx_cfg468_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg490 {
@@ -1426,8 +1869,12 @@ union cvmx_pciercx_cfg490 {
 	struct cvmx_pciercx_cfg490_s cn52xxp1;
 	struct cvmx_pciercx_cfg490_s cn56xx;
 	struct cvmx_pciercx_cfg490_s cn56xxp1;
+	struct cvmx_pciercx_cfg490_s cn61xx;
 	struct cvmx_pciercx_cfg490_s cn63xx;
 	struct cvmx_pciercx_cfg490_s cn63xxp1;
+	struct cvmx_pciercx_cfg490_s cn66xx;
+	struct cvmx_pciercx_cfg490_s cn68xx;
+	struct cvmx_pciercx_cfg490_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg491 {
@@ -1442,8 +1889,12 @@ union cvmx_pciercx_cfg491 {
 	struct cvmx_pciercx_cfg491_s cn52xxp1;
 	struct cvmx_pciercx_cfg491_s cn56xx;
 	struct cvmx_pciercx_cfg491_s cn56xxp1;
+	struct cvmx_pciercx_cfg491_s cn61xx;
 	struct cvmx_pciercx_cfg491_s cn63xx;
 	struct cvmx_pciercx_cfg491_s cn63xxp1;
+	struct cvmx_pciercx_cfg491_s cn66xx;
+	struct cvmx_pciercx_cfg491_s cn68xx;
+	struct cvmx_pciercx_cfg491_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg492 {
@@ -1458,8 +1909,12 @@ union cvmx_pciercx_cfg492 {
 	struct cvmx_pciercx_cfg492_s cn52xxp1;
 	struct cvmx_pciercx_cfg492_s cn56xx;
 	struct cvmx_pciercx_cfg492_s cn56xxp1;
+	struct cvmx_pciercx_cfg492_s cn61xx;
 	struct cvmx_pciercx_cfg492_s cn63xx;
 	struct cvmx_pciercx_cfg492_s cn63xxp1;
+	struct cvmx_pciercx_cfg492_s cn66xx;
+	struct cvmx_pciercx_cfg492_s cn68xx;
+	struct cvmx_pciercx_cfg492_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg515 {
@@ -1473,8 +1928,12 @@ union cvmx_pciercx_cfg515 {
 		uint32_t le:9;
 		uint32_t n_fts:8;
 	} s;
+	struct cvmx_pciercx_cfg515_s cn61xx;
 	struct cvmx_pciercx_cfg515_s cn63xx;
 	struct cvmx_pciercx_cfg515_s cn63xxp1;
+	struct cvmx_pciercx_cfg515_s cn66xx;
+	struct cvmx_pciercx_cfg515_s cn68xx;
+	struct cvmx_pciercx_cfg515_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg516 {
@@ -1486,8 +1945,12 @@ union cvmx_pciercx_cfg516 {
 	struct cvmx_pciercx_cfg516_s cn52xxp1;
 	struct cvmx_pciercx_cfg516_s cn56xx;
 	struct cvmx_pciercx_cfg516_s cn56xxp1;
+	struct cvmx_pciercx_cfg516_s cn61xx;
 	struct cvmx_pciercx_cfg516_s cn63xx;
 	struct cvmx_pciercx_cfg516_s cn63xxp1;
+	struct cvmx_pciercx_cfg516_s cn66xx;
+	struct cvmx_pciercx_cfg516_s cn68xx;
+	struct cvmx_pciercx_cfg516_s cn68xxp1;
 };
 
 union cvmx_pciercx_cfg517 {
@@ -1499,8 +1962,12 @@ union cvmx_pciercx_cfg517 {
 	struct cvmx_pciercx_cfg517_s cn52xxp1;
 	struct cvmx_pciercx_cfg517_s cn56xx;
 	struct cvmx_pciercx_cfg517_s cn56xxp1;
+	struct cvmx_pciercx_cfg517_s cn61xx;
 	struct cvmx_pciercx_cfg517_s cn63xx;
 	struct cvmx_pciercx_cfg517_s cn63xxp1;
+	struct cvmx_pciercx_cfg517_s cn66xx;
+	struct cvmx_pciercx_cfg517_s cn68xx;
+	struct cvmx_pciercx_cfg517_s cn68xxp1;
 };
 
 #endif
diff --git a/arch/mips/include/asm/octeon/cvmx-pemx-defs.h b/arch/mips/include/asm/octeon/cvmx-pemx-defs.h
new file mode 100644
index 0000000..be189a2
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-pemx-defs.h
@@ -0,0 +1,509 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2011 Cavium Networks
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
+#ifndef __CVMX_PEMX_DEFS_H__
+#define __CVMX_PEMX_DEFS_H__
+
+#define CVMX_PEMX_BAR1_INDEXX(offset, block_id) (CVMX_ADD_IO_SEG(0x00011800C00000A8ull) + (((offset) & 15) + ((block_id) & 1) * 0x200000ull) * 8)
+#define CVMX_PEMX_BAR2_MASK(block_id) (CVMX_ADD_IO_SEG(0x00011800C0000130ull) + ((block_id) & 1) * 0x1000000ull)
+#define CVMX_PEMX_BAR_CTL(block_id) (CVMX_ADD_IO_SEG(0x00011800C0000128ull) + ((block_id) & 1) * 0x1000000ull)
+#define CVMX_PEMX_BIST_STATUS(block_id) (CVMX_ADD_IO_SEG(0x00011800C0000018ull) + ((block_id) & 1) * 0x1000000ull)
+#define CVMX_PEMX_BIST_STATUS2(block_id) (CVMX_ADD_IO_SEG(0x00011800C0000420ull) + ((block_id) & 1) * 0x1000000ull)
+#define CVMX_PEMX_CFG_RD(block_id) (CVMX_ADD_IO_SEG(0x00011800C0000030ull) + ((block_id) & 1) * 0x1000000ull)
+#define CVMX_PEMX_CFG_WR(block_id) (CVMX_ADD_IO_SEG(0x00011800C0000028ull) + ((block_id) & 1) * 0x1000000ull)
+#define CVMX_PEMX_CPL_LUT_VALID(block_id) (CVMX_ADD_IO_SEG(0x00011800C0000098ull) + ((block_id) & 1) * 0x1000000ull)
+#define CVMX_PEMX_CTL_STATUS(block_id) (CVMX_ADD_IO_SEG(0x00011800C0000000ull) + ((block_id) & 1) * 0x1000000ull)
+#define CVMX_PEMX_DBG_INFO(block_id) (CVMX_ADD_IO_SEG(0x00011800C0000008ull) + ((block_id) & 1) * 0x1000000ull)
+#define CVMX_PEMX_DBG_INFO_EN(block_id) (CVMX_ADD_IO_SEG(0x00011800C00000A0ull) + ((block_id) & 1) * 0x1000000ull)
+#define CVMX_PEMX_DIAG_STATUS(block_id) (CVMX_ADD_IO_SEG(0x00011800C0000020ull) + ((block_id) & 1) * 0x1000000ull)
+#define CVMX_PEMX_INB_READ_CREDITS(block_id) (CVMX_ADD_IO_SEG(0x00011800C0000138ull) + ((block_id) & 1) * 0x1000000ull)
+#define CVMX_PEMX_INT_ENB(block_id) (CVMX_ADD_IO_SEG(0x00011800C0000410ull) + ((block_id) & 1) * 0x1000000ull)
+#define CVMX_PEMX_INT_ENB_INT(block_id) (CVMX_ADD_IO_SEG(0x00011800C0000418ull) + ((block_id) & 1) * 0x1000000ull)
+#define CVMX_PEMX_INT_SUM(block_id) (CVMX_ADD_IO_SEG(0x00011800C0000408ull) + ((block_id) & 1) * 0x1000000ull)
+#define CVMX_PEMX_P2N_BAR0_START(block_id) (CVMX_ADD_IO_SEG(0x00011800C0000080ull) + ((block_id) & 1) * 0x1000000ull)
+#define CVMX_PEMX_P2N_BAR1_START(block_id) (CVMX_ADD_IO_SEG(0x00011800C0000088ull) + ((block_id) & 1) * 0x1000000ull)
+#define CVMX_PEMX_P2N_BAR2_START(block_id) (CVMX_ADD_IO_SEG(0x00011800C0000090ull) + ((block_id) & 1) * 0x1000000ull)
+#define CVMX_PEMX_P2P_BARX_END(offset, block_id) (CVMX_ADD_IO_SEG(0x00011800C0000048ull) + (((offset) & 3) + ((block_id) & 1) * 0x100000ull) * 16)
+#define CVMX_PEMX_P2P_BARX_START(offset, block_id) (CVMX_ADD_IO_SEG(0x00011800C0000040ull) + (((offset) & 3) + ((block_id) & 1) * 0x100000ull) * 16)
+#define CVMX_PEMX_TLP_CREDITS(block_id) (CVMX_ADD_IO_SEG(0x00011800C0000038ull) + ((block_id) & 1) * 0x1000000ull)
+
+union cvmx_pemx_bar1_indexx {
+	uint64_t u64;
+	struct cvmx_pemx_bar1_indexx_s {
+		uint64_t reserved_20_63:44;
+		uint64_t addr_idx:16;
+		uint64_t ca:1;
+		uint64_t end_swp:2;
+		uint64_t addr_v:1;
+	} s;
+	struct cvmx_pemx_bar1_indexx_s cn61xx;
+	struct cvmx_pemx_bar1_indexx_s cn63xx;
+	struct cvmx_pemx_bar1_indexx_s cn63xxp1;
+	struct cvmx_pemx_bar1_indexx_s cn66xx;
+	struct cvmx_pemx_bar1_indexx_s cn68xx;
+	struct cvmx_pemx_bar1_indexx_s cn68xxp1;
+};
+
+union cvmx_pemx_bar2_mask {
+	uint64_t u64;
+	struct cvmx_pemx_bar2_mask_s {
+		uint64_t reserved_38_63:26;
+		uint64_t mask:35;
+		uint64_t reserved_0_2:3;
+	} s;
+	struct cvmx_pemx_bar2_mask_s cn61xx;
+	struct cvmx_pemx_bar2_mask_s cn66xx;
+	struct cvmx_pemx_bar2_mask_s cn68xx;
+	struct cvmx_pemx_bar2_mask_s cn68xxp1;
+};
+
+union cvmx_pemx_bar_ctl {
+	uint64_t u64;
+	struct cvmx_pemx_bar_ctl_s {
+		uint64_t reserved_7_63:57;
+		uint64_t bar1_siz:3;
+		uint64_t bar2_enb:1;
+		uint64_t bar2_esx:2;
+		uint64_t bar2_cax:1;
+	} s;
+	struct cvmx_pemx_bar_ctl_s cn61xx;
+	struct cvmx_pemx_bar_ctl_s cn63xx;
+	struct cvmx_pemx_bar_ctl_s cn63xxp1;
+	struct cvmx_pemx_bar_ctl_s cn66xx;
+	struct cvmx_pemx_bar_ctl_s cn68xx;
+	struct cvmx_pemx_bar_ctl_s cn68xxp1;
+};
+
+union cvmx_pemx_bist_status {
+	uint64_t u64;
+	struct cvmx_pemx_bist_status_s {
+		uint64_t reserved_8_63:56;
+		uint64_t retry:1;
+		uint64_t rqdata0:1;
+		uint64_t rqdata1:1;
+		uint64_t rqdata2:1;
+		uint64_t rqdata3:1;
+		uint64_t rqhdr1:1;
+		uint64_t rqhdr0:1;
+		uint64_t sot:1;
+	} s;
+	struct cvmx_pemx_bist_status_s cn61xx;
+	struct cvmx_pemx_bist_status_s cn63xx;
+	struct cvmx_pemx_bist_status_s cn63xxp1;
+	struct cvmx_pemx_bist_status_s cn66xx;
+	struct cvmx_pemx_bist_status_s cn68xx;
+	struct cvmx_pemx_bist_status_s cn68xxp1;
+};
+
+union cvmx_pemx_bist_status2 {
+	uint64_t u64;
+	struct cvmx_pemx_bist_status2_s {
+		uint64_t reserved_10_63:54;
+		uint64_t e2p_cpl:1;
+		uint64_t e2p_n:1;
+		uint64_t e2p_p:1;
+		uint64_t peai_p2e:1;
+		uint64_t pef_tpf1:1;
+		uint64_t pef_tpf0:1;
+		uint64_t pef_tnf:1;
+		uint64_t pef_tcf1:1;
+		uint64_t pef_tc0:1;
+		uint64_t ppf:1;
+	} s;
+	struct cvmx_pemx_bist_status2_s cn61xx;
+	struct cvmx_pemx_bist_status2_s cn63xx;
+	struct cvmx_pemx_bist_status2_s cn63xxp1;
+	struct cvmx_pemx_bist_status2_s cn66xx;
+	struct cvmx_pemx_bist_status2_s cn68xx;
+	struct cvmx_pemx_bist_status2_s cn68xxp1;
+};
+
+union cvmx_pemx_cfg_rd {
+	uint64_t u64;
+	struct cvmx_pemx_cfg_rd_s {
+		uint64_t data:32;
+		uint64_t addr:32;
+	} s;
+	struct cvmx_pemx_cfg_rd_s cn61xx;
+	struct cvmx_pemx_cfg_rd_s cn63xx;
+	struct cvmx_pemx_cfg_rd_s cn63xxp1;
+	struct cvmx_pemx_cfg_rd_s cn66xx;
+	struct cvmx_pemx_cfg_rd_s cn68xx;
+	struct cvmx_pemx_cfg_rd_s cn68xxp1;
+};
+
+union cvmx_pemx_cfg_wr {
+	uint64_t u64;
+	struct cvmx_pemx_cfg_wr_s {
+		uint64_t data:32;
+		uint64_t addr:32;
+	} s;
+	struct cvmx_pemx_cfg_wr_s cn61xx;
+	struct cvmx_pemx_cfg_wr_s cn63xx;
+	struct cvmx_pemx_cfg_wr_s cn63xxp1;
+	struct cvmx_pemx_cfg_wr_s cn66xx;
+	struct cvmx_pemx_cfg_wr_s cn68xx;
+	struct cvmx_pemx_cfg_wr_s cn68xxp1;
+};
+
+union cvmx_pemx_cpl_lut_valid {
+	uint64_t u64;
+	struct cvmx_pemx_cpl_lut_valid_s {
+		uint64_t reserved_32_63:32;
+		uint64_t tag:32;
+	} s;
+	struct cvmx_pemx_cpl_lut_valid_s cn61xx;
+	struct cvmx_pemx_cpl_lut_valid_s cn63xx;
+	struct cvmx_pemx_cpl_lut_valid_s cn63xxp1;
+	struct cvmx_pemx_cpl_lut_valid_s cn66xx;
+	struct cvmx_pemx_cpl_lut_valid_s cn68xx;
+	struct cvmx_pemx_cpl_lut_valid_s cn68xxp1;
+};
+
+union cvmx_pemx_ctl_status {
+	uint64_t u64;
+	struct cvmx_pemx_ctl_status_s {
+		uint64_t reserved_48_63:16;
+		uint64_t auto_sd:1;
+		uint64_t dnum:5;
+		uint64_t pbus:8;
+		uint64_t reserved_32_33:2;
+		uint64_t cfg_rtry:16;
+		uint64_t reserved_12_15:4;
+		uint64_t pm_xtoff:1;
+		uint64_t pm_xpme:1;
+		uint64_t ob_p_cmd:1;
+		uint64_t reserved_7_8:2;
+		uint64_t nf_ecrc:1;
+		uint64_t dly_one:1;
+		uint64_t lnk_enb:1;
+		uint64_t ro_ctlp:1;
+		uint64_t fast_lm:1;
+		uint64_t inv_ecrc:1;
+		uint64_t inv_lcrc:1;
+	} s;
+	struct cvmx_pemx_ctl_status_s cn61xx;
+	struct cvmx_pemx_ctl_status_s cn63xx;
+	struct cvmx_pemx_ctl_status_s cn63xxp1;
+	struct cvmx_pemx_ctl_status_s cn66xx;
+	struct cvmx_pemx_ctl_status_s cn68xx;
+	struct cvmx_pemx_ctl_status_s cn68xxp1;
+};
+
+union cvmx_pemx_dbg_info {
+	uint64_t u64;
+	struct cvmx_pemx_dbg_info_s {
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
+	struct cvmx_pemx_dbg_info_s cn61xx;
+	struct cvmx_pemx_dbg_info_s cn63xx;
+	struct cvmx_pemx_dbg_info_s cn63xxp1;
+	struct cvmx_pemx_dbg_info_s cn66xx;
+	struct cvmx_pemx_dbg_info_s cn68xx;
+	struct cvmx_pemx_dbg_info_s cn68xxp1;
+};
+
+union cvmx_pemx_dbg_info_en {
+	uint64_t u64;
+	struct cvmx_pemx_dbg_info_en_s {
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
+	struct cvmx_pemx_dbg_info_en_s cn61xx;
+	struct cvmx_pemx_dbg_info_en_s cn63xx;
+	struct cvmx_pemx_dbg_info_en_s cn63xxp1;
+	struct cvmx_pemx_dbg_info_en_s cn66xx;
+	struct cvmx_pemx_dbg_info_en_s cn68xx;
+	struct cvmx_pemx_dbg_info_en_s cn68xxp1;
+};
+
+union cvmx_pemx_diag_status {
+	uint64_t u64;
+	struct cvmx_pemx_diag_status_s {
+		uint64_t reserved_4_63:60;
+		uint64_t pm_dst:1;
+		uint64_t pm_stat:1;
+		uint64_t pm_en:1;
+		uint64_t aux_en:1;
+	} s;
+	struct cvmx_pemx_diag_status_s cn61xx;
+	struct cvmx_pemx_diag_status_s cn63xx;
+	struct cvmx_pemx_diag_status_s cn63xxp1;
+	struct cvmx_pemx_diag_status_s cn66xx;
+	struct cvmx_pemx_diag_status_s cn68xx;
+	struct cvmx_pemx_diag_status_s cn68xxp1;
+};
+
+union cvmx_pemx_inb_read_credits {
+	uint64_t u64;
+	struct cvmx_pemx_inb_read_credits_s {
+		uint64_t reserved_6_63:58;
+		uint64_t num:6;
+	} s;
+	struct cvmx_pemx_inb_read_credits_s cn61xx;
+	struct cvmx_pemx_inb_read_credits_s cn66xx;
+	struct cvmx_pemx_inb_read_credits_s cn68xx;
+};
+
+union cvmx_pemx_int_enb {
+	uint64_t u64;
+	struct cvmx_pemx_int_enb_s {
+		uint64_t reserved_14_63:50;
+		uint64_t crs_dr:1;
+		uint64_t crs_er:1;
+		uint64_t rdlk:1;
+		uint64_t exc:1;
+		uint64_t un_bx:1;
+		uint64_t un_b2:1;
+		uint64_t un_b1:1;
+		uint64_t up_bx:1;
+		uint64_t up_b2:1;
+		uint64_t up_b1:1;
+		uint64_t pmem:1;
+		uint64_t pmei:1;
+		uint64_t se:1;
+		uint64_t aeri:1;
+	} s;
+	struct cvmx_pemx_int_enb_s cn61xx;
+	struct cvmx_pemx_int_enb_s cn63xx;
+	struct cvmx_pemx_int_enb_s cn63xxp1;
+	struct cvmx_pemx_int_enb_s cn66xx;
+	struct cvmx_pemx_int_enb_s cn68xx;
+	struct cvmx_pemx_int_enb_s cn68xxp1;
+};
+
+union cvmx_pemx_int_enb_int {
+	uint64_t u64;
+	struct cvmx_pemx_int_enb_int_s {
+		uint64_t reserved_14_63:50;
+		uint64_t crs_dr:1;
+		uint64_t crs_er:1;
+		uint64_t rdlk:1;
+		uint64_t exc:1;
+		uint64_t un_bx:1;
+		uint64_t un_b2:1;
+		uint64_t un_b1:1;
+		uint64_t up_bx:1;
+		uint64_t up_b2:1;
+		uint64_t up_b1:1;
+		uint64_t pmem:1;
+		uint64_t pmei:1;
+		uint64_t se:1;
+		uint64_t aeri:1;
+	} s;
+	struct cvmx_pemx_int_enb_int_s cn61xx;
+	struct cvmx_pemx_int_enb_int_s cn63xx;
+	struct cvmx_pemx_int_enb_int_s cn63xxp1;
+	struct cvmx_pemx_int_enb_int_s cn66xx;
+	struct cvmx_pemx_int_enb_int_s cn68xx;
+	struct cvmx_pemx_int_enb_int_s cn68xxp1;
+};
+
+union cvmx_pemx_int_sum {
+	uint64_t u64;
+	struct cvmx_pemx_int_sum_s {
+		uint64_t reserved_14_63:50;
+		uint64_t crs_dr:1;
+		uint64_t crs_er:1;
+		uint64_t rdlk:1;
+		uint64_t exc:1;
+		uint64_t un_bx:1;
+		uint64_t un_b2:1;
+		uint64_t un_b1:1;
+		uint64_t up_bx:1;
+		uint64_t up_b2:1;
+		uint64_t up_b1:1;
+		uint64_t pmem:1;
+		uint64_t pmei:1;
+		uint64_t se:1;
+		uint64_t aeri:1;
+	} s;
+	struct cvmx_pemx_int_sum_s cn61xx;
+	struct cvmx_pemx_int_sum_s cn63xx;
+	struct cvmx_pemx_int_sum_s cn63xxp1;
+	struct cvmx_pemx_int_sum_s cn66xx;
+	struct cvmx_pemx_int_sum_s cn68xx;
+	struct cvmx_pemx_int_sum_s cn68xxp1;
+};
+
+union cvmx_pemx_p2n_bar0_start {
+	uint64_t u64;
+	struct cvmx_pemx_p2n_bar0_start_s {
+		uint64_t addr:50;
+		uint64_t reserved_0_13:14;
+	} s;
+	struct cvmx_pemx_p2n_bar0_start_s cn61xx;
+	struct cvmx_pemx_p2n_bar0_start_s cn63xx;
+	struct cvmx_pemx_p2n_bar0_start_s cn63xxp1;
+	struct cvmx_pemx_p2n_bar0_start_s cn66xx;
+	struct cvmx_pemx_p2n_bar0_start_s cn68xx;
+	struct cvmx_pemx_p2n_bar0_start_s cn68xxp1;
+};
+
+union cvmx_pemx_p2n_bar1_start {
+	uint64_t u64;
+	struct cvmx_pemx_p2n_bar1_start_s {
+		uint64_t addr:38;
+		uint64_t reserved_0_25:26;
+	} s;
+	struct cvmx_pemx_p2n_bar1_start_s cn61xx;
+	struct cvmx_pemx_p2n_bar1_start_s cn63xx;
+	struct cvmx_pemx_p2n_bar1_start_s cn63xxp1;
+	struct cvmx_pemx_p2n_bar1_start_s cn66xx;
+	struct cvmx_pemx_p2n_bar1_start_s cn68xx;
+	struct cvmx_pemx_p2n_bar1_start_s cn68xxp1;
+};
+
+union cvmx_pemx_p2n_bar2_start {
+	uint64_t u64;
+	struct cvmx_pemx_p2n_bar2_start_s {
+		uint64_t addr:23;
+		uint64_t reserved_0_40:41;
+	} s;
+	struct cvmx_pemx_p2n_bar2_start_s cn61xx;
+	struct cvmx_pemx_p2n_bar2_start_s cn63xx;
+	struct cvmx_pemx_p2n_bar2_start_s cn63xxp1;
+	struct cvmx_pemx_p2n_bar2_start_s cn66xx;
+	struct cvmx_pemx_p2n_bar2_start_s cn68xx;
+	struct cvmx_pemx_p2n_bar2_start_s cn68xxp1;
+};
+
+union cvmx_pemx_p2p_barx_end {
+	uint64_t u64;
+	struct cvmx_pemx_p2p_barx_end_s {
+		uint64_t addr:52;
+		uint64_t reserved_0_11:12;
+	} s;
+	struct cvmx_pemx_p2p_barx_end_s cn63xx;
+	struct cvmx_pemx_p2p_barx_end_s cn63xxp1;
+	struct cvmx_pemx_p2p_barx_end_s cn66xx;
+	struct cvmx_pemx_p2p_barx_end_s cn68xx;
+	struct cvmx_pemx_p2p_barx_end_s cn68xxp1;
+};
+
+union cvmx_pemx_p2p_barx_start {
+	uint64_t u64;
+	struct cvmx_pemx_p2p_barx_start_s {
+		uint64_t addr:52;
+		uint64_t reserved_0_11:12;
+	} s;
+	struct cvmx_pemx_p2p_barx_start_s cn63xx;
+	struct cvmx_pemx_p2p_barx_start_s cn63xxp1;
+	struct cvmx_pemx_p2p_barx_start_s cn66xx;
+	struct cvmx_pemx_p2p_barx_start_s cn68xx;
+	struct cvmx_pemx_p2p_barx_start_s cn68xxp1;
+};
+
+union cvmx_pemx_tlp_credits {
+	uint64_t u64;
+	struct cvmx_pemx_tlp_credits_s {
+		uint64_t reserved_56_63:8;
+		uint64_t peai_ppf:8;
+		uint64_t pem_cpl:8;
+		uint64_t pem_np:8;
+		uint64_t pem_p:8;
+		uint64_t sli_cpl:8;
+		uint64_t sli_np:8;
+		uint64_t sli_p:8;
+	} s;
+	struct cvmx_pemx_tlp_credits_cn61xx {
+		uint64_t reserved_56_63:8;
+		uint64_t peai_ppf:8;
+		uint64_t reserved_24_47:24;
+		uint64_t sli_cpl:8;
+		uint64_t sli_np:8;
+		uint64_t sli_p:8;
+	} cn61xx;
+	struct cvmx_pemx_tlp_credits_s cn63xx;
+	struct cvmx_pemx_tlp_credits_s cn63xxp1;
+	struct cvmx_pemx_tlp_credits_s cn66xx;
+	struct cvmx_pemx_tlp_credits_s cn68xx;
+	struct cvmx_pemx_tlp_credits_s cn68xxp1;
+};
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-pexp-defs.h b/arch/mips/include/asm/octeon/cvmx-pexp-defs.h
index 5ab8679..4438d21 100644
--- a/arch/mips/include/asm/octeon/cvmx-pexp-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-pexp-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2010 Cavium Networks
+ * Copyright (c) 2003-2011 Cavium Networks
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -25,13 +25,6 @@
  * Contact Cavium Networks for more information
  ***********************license end**************************************/
 
-/**
- * cvmx-pexp-defs.h
- *
- * Configuration and status register (CSR) definitions for
- * OCTEON PEXP.
- *
- */
 #ifndef __CVMX_PEXP_DEFS_H__
 #define __CVMX_PEXP_DEFS_H__
 
@@ -139,7 +132,7 @@
 #define CVMX_PEXP_NPEI_STATE3 (CVMX_ADD_IO_SEG(0x00011F0000008640ull))
 #define CVMX_PEXP_NPEI_WINDOW_CTL (CVMX_ADD_IO_SEG(0x00011F0000008380ull))
 #define CVMX_PEXP_SLI_BIST_STATUS (CVMX_ADD_IO_SEG(0x00011F0000010580ull))
-#define CVMX_PEXP_SLI_CTL_PORTX(offset) (CVMX_ADD_IO_SEG(0x00011F0000010050ull) + ((offset) & 1) * 16)
+#define CVMX_PEXP_SLI_CTL_PORTX(offset) (CVMX_ADD_IO_SEG(0x00011F0000010050ull) + ((offset) & 3) * 16)
 #define CVMX_PEXP_SLI_CTL_STATUS (CVMX_ADD_IO_SEG(0x00011F0000010570ull))
 #define CVMX_PEXP_SLI_DATA_OUT_CNT (CVMX_ADD_IO_SEG(0x00011F00000105F0ull))
 #define CVMX_PEXP_SLI_DBG_DATA (CVMX_ADD_IO_SEG(0x00011F0000010310ull))
@@ -152,7 +145,10 @@
 #define CVMX_PEXP_SLI_INT_SUM (CVMX_ADD_IO_SEG(0x00011F0000010330ull))
 #define CVMX_PEXP_SLI_LAST_WIN_RDATA0 (CVMX_ADD_IO_SEG(0x00011F0000010600ull))
 #define CVMX_PEXP_SLI_LAST_WIN_RDATA1 (CVMX_ADD_IO_SEG(0x00011F0000010610ull))
+#define CVMX_PEXP_SLI_LAST_WIN_RDATA2 (CVMX_ADD_IO_SEG(0x00011F00000106C0ull))
+#define CVMX_PEXP_SLI_LAST_WIN_RDATA3 (CVMX_ADD_IO_SEG(0x00011F00000106D0ull))
 #define CVMX_PEXP_SLI_MAC_CREDIT_CNT (CVMX_ADD_IO_SEG(0x00011F0000013D70ull))
+#define CVMX_PEXP_SLI_MAC_CREDIT_CNT2 (CVMX_ADD_IO_SEG(0x00011F0000013E10ull))
 #define CVMX_PEXP_SLI_MEM_ACCESS_CTL (CVMX_ADD_IO_SEG(0x00011F00000102F0ull))
 #define CVMX_PEXP_SLI_MEM_ACCESS_SUBIDX(offset) (CVMX_ADD_IO_SEG(0x00011F00000100E0ull) + ((offset) & 31) * 16 - 16*12)
 #define CVMX_PEXP_SLI_MSI_ENB0 (CVMX_ADD_IO_SEG(0x00011F0000013C50ull))
@@ -206,6 +202,7 @@
 #define CVMX_PEXP_SLI_PKT_IPTR (CVMX_ADD_IO_SEG(0x00011F0000011070ull))
 #define CVMX_PEXP_SLI_PKT_OUTPUT_WMARK (CVMX_ADD_IO_SEG(0x00011F0000011180ull))
 #define CVMX_PEXP_SLI_PKT_OUT_BMODE (CVMX_ADD_IO_SEG(0x00011F00000110D0ull))
+#define CVMX_PEXP_SLI_PKT_OUT_BP_EN (CVMX_ADD_IO_SEG(0x00011F0000011240ull))
 #define CVMX_PEXP_SLI_PKT_OUT_ENB (CVMX_ADD_IO_SEG(0x00011F0000011010ull))
 #define CVMX_PEXP_SLI_PKT_PCIE_PORT (CVMX_ADD_IO_SEG(0x00011F00000110E0ull))
 #define CVMX_PEXP_SLI_PKT_PORT_IN_RST (CVMX_ADD_IO_SEG(0x00011F00000111F0ull))
@@ -214,12 +211,14 @@
 #define CVMX_PEXP_SLI_PKT_SLIST_ROR (CVMX_ADD_IO_SEG(0x00011F0000011030ull))
 #define CVMX_PEXP_SLI_PKT_TIME_INT (CVMX_ADD_IO_SEG(0x00011F0000011140ull))
 #define CVMX_PEXP_SLI_PKT_TIME_INT_ENB (CVMX_ADD_IO_SEG(0x00011F0000011160ull))
-#define CVMX_PEXP_SLI_S2M_PORTX_CTL(offset) (CVMX_ADD_IO_SEG(0x00011F0000013D80ull) + ((offset) & 1) * 16)
+#define CVMX_PEXP_SLI_PORTX_PKIND(offset) (CVMX_ADD_IO_SEG(0x00011F0000010800ull) + ((offset) & 31) * 16)
+#define CVMX_PEXP_SLI_S2M_PORTX_CTL(offset) (CVMX_ADD_IO_SEG(0x00011F0000013D80ull) + ((offset) & 3) * 16)
 #define CVMX_PEXP_SLI_SCRATCH_1 (CVMX_ADD_IO_SEG(0x00011F00000103C0ull))
 #define CVMX_PEXP_SLI_SCRATCH_2 (CVMX_ADD_IO_SEG(0x00011F00000103D0ull))
 #define CVMX_PEXP_SLI_STATE1 (CVMX_ADD_IO_SEG(0x00011F0000010620ull))
 #define CVMX_PEXP_SLI_STATE2 (CVMX_ADD_IO_SEG(0x00011F0000010630ull))
 #define CVMX_PEXP_SLI_STATE3 (CVMX_ADD_IO_SEG(0x00011F0000010640ull))
+#define CVMX_PEXP_SLI_TX_PIPE (CVMX_ADD_IO_SEG(0x00011F0000011230ull))
 #define CVMX_PEXP_SLI_WINDOW_CTL (CVMX_ADD_IO_SEG(0x00011F00000102E0ull))
 
 #endif
diff --git a/arch/mips/include/asm/octeon/cvmx-sli-defs.h b/arch/mips/include/asm/octeon/cvmx-sli-defs.h
new file mode 100644
index 0000000..7c6c901
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-sli-defs.h
@@ -0,0 +1,2172 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2011 Cavium Networks
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
+#ifndef __CVMX_SLI_DEFS_H__
+#define __CVMX_SLI_DEFS_H__
+
+#define CVMX_SLI_BIST_STATUS (0x0000000000000580ull)
+#define CVMX_SLI_CTL_PORTX(offset) (0x0000000000000050ull + ((offset) & 3) * 16)
+#define CVMX_SLI_CTL_STATUS (0x0000000000000570ull)
+#define CVMX_SLI_DATA_OUT_CNT (0x00000000000005F0ull)
+#define CVMX_SLI_DBG_DATA (0x0000000000000310ull)
+#define CVMX_SLI_DBG_SELECT (0x0000000000000300ull)
+#define CVMX_SLI_DMAX_CNT(offset) (0x0000000000000400ull + ((offset) & 1) * 16)
+#define CVMX_SLI_DMAX_INT_LEVEL(offset) (0x00000000000003E0ull + ((offset) & 1) * 16)
+#define CVMX_SLI_DMAX_TIM(offset) (0x0000000000000420ull + ((offset) & 1) * 16)
+#define CVMX_SLI_INT_ENB_CIU (0x0000000000003CD0ull)
+#define CVMX_SLI_INT_ENB_PORTX(offset) (0x0000000000000340ull + ((offset) & 1) * 16)
+#define CVMX_SLI_INT_SUM (0x0000000000000330ull)
+#define CVMX_SLI_LAST_WIN_RDATA0 (0x0000000000000600ull)
+#define CVMX_SLI_LAST_WIN_RDATA1 (0x0000000000000610ull)
+#define CVMX_SLI_LAST_WIN_RDATA2 (0x00000000000006C0ull)
+#define CVMX_SLI_LAST_WIN_RDATA3 (0x00000000000006D0ull)
+#define CVMX_SLI_MAC_CREDIT_CNT (0x0000000000003D70ull)
+#define CVMX_SLI_MAC_CREDIT_CNT2 (0x0000000000003E10ull)
+#define CVMX_SLI_MAC_NUMBER (0x0000000000003E00ull)
+#define CVMX_SLI_MEM_ACCESS_CTL (0x00000000000002F0ull)
+#define CVMX_SLI_MEM_ACCESS_SUBIDX(offset) (0x00000000000000E0ull + ((offset) & 31) * 16 - 16*12)
+#define CVMX_SLI_MSI_ENB0 (0x0000000000003C50ull)
+#define CVMX_SLI_MSI_ENB1 (0x0000000000003C60ull)
+#define CVMX_SLI_MSI_ENB2 (0x0000000000003C70ull)
+#define CVMX_SLI_MSI_ENB3 (0x0000000000003C80ull)
+#define CVMX_SLI_MSI_RCV0 (0x0000000000003C10ull)
+#define CVMX_SLI_MSI_RCV1 (0x0000000000003C20ull)
+#define CVMX_SLI_MSI_RCV2 (0x0000000000003C30ull)
+#define CVMX_SLI_MSI_RCV3 (0x0000000000003C40ull)
+#define CVMX_SLI_MSI_RD_MAP (0x0000000000003CA0ull)
+#define CVMX_SLI_MSI_W1C_ENB0 (0x0000000000003CF0ull)
+#define CVMX_SLI_MSI_W1C_ENB1 (0x0000000000003D00ull)
+#define CVMX_SLI_MSI_W1C_ENB2 (0x0000000000003D10ull)
+#define CVMX_SLI_MSI_W1C_ENB3 (0x0000000000003D20ull)
+#define CVMX_SLI_MSI_W1S_ENB0 (0x0000000000003D30ull)
+#define CVMX_SLI_MSI_W1S_ENB1 (0x0000000000003D40ull)
+#define CVMX_SLI_MSI_W1S_ENB2 (0x0000000000003D50ull)
+#define CVMX_SLI_MSI_W1S_ENB3 (0x0000000000003D60ull)
+#define CVMX_SLI_MSI_WR_MAP (0x0000000000003C90ull)
+#define CVMX_SLI_PCIE_MSI_RCV (0x0000000000003CB0ull)
+#define CVMX_SLI_PCIE_MSI_RCV_B1 (0x0000000000000650ull)
+#define CVMX_SLI_PCIE_MSI_RCV_B2 (0x0000000000000660ull)
+#define CVMX_SLI_PCIE_MSI_RCV_B3 (0x0000000000000670ull)
+#define CVMX_SLI_PKTX_CNTS(offset) (0x0000000000002400ull + ((offset) & 31) * 16)
+#define CVMX_SLI_PKTX_INSTR_BADDR(offset) (0x0000000000002800ull + ((offset) & 31) * 16)
+#define CVMX_SLI_PKTX_INSTR_BAOFF_DBELL(offset) (0x0000000000002C00ull + ((offset) & 31) * 16)
+#define CVMX_SLI_PKTX_INSTR_FIFO_RSIZE(offset) (0x0000000000003000ull + ((offset) & 31) * 16)
+#define CVMX_SLI_PKTX_INSTR_HEADER(offset) (0x0000000000003400ull + ((offset) & 31) * 16)
+#define CVMX_SLI_PKTX_IN_BP(offset) (0x0000000000003800ull + ((offset) & 31) * 16)
+#define CVMX_SLI_PKTX_OUT_SIZE(offset) (0x0000000000000C00ull + ((offset) & 31) * 16)
+#define CVMX_SLI_PKTX_SLIST_BADDR(offset) (0x0000000000001400ull + ((offset) & 31) * 16)
+#define CVMX_SLI_PKTX_SLIST_BAOFF_DBELL(offset) (0x0000000000001800ull + ((offset) & 31) * 16)
+#define CVMX_SLI_PKTX_SLIST_FIFO_RSIZE(offset) (0x0000000000001C00ull + ((offset) & 31) * 16)
+#define CVMX_SLI_PKT_CNT_INT (0x0000000000001130ull)
+#define CVMX_SLI_PKT_CNT_INT_ENB (0x0000000000001150ull)
+#define CVMX_SLI_PKT_CTL (0x0000000000001220ull)
+#define CVMX_SLI_PKT_DATA_OUT_ES (0x00000000000010B0ull)
+#define CVMX_SLI_PKT_DATA_OUT_NS (0x00000000000010A0ull)
+#define CVMX_SLI_PKT_DATA_OUT_ROR (0x0000000000001090ull)
+#define CVMX_SLI_PKT_DPADDR (0x0000000000001080ull)
+#define CVMX_SLI_PKT_INPUT_CONTROL (0x0000000000001170ull)
+#define CVMX_SLI_PKT_INSTR_ENB (0x0000000000001000ull)
+#define CVMX_SLI_PKT_INSTR_RD_SIZE (0x00000000000011A0ull)
+#define CVMX_SLI_PKT_INSTR_SIZE (0x0000000000001020ull)
+#define CVMX_SLI_PKT_INT_LEVELS (0x0000000000001120ull)
+#define CVMX_SLI_PKT_IN_BP (0x0000000000001210ull)
+#define CVMX_SLI_PKT_IN_DONEX_CNTS(offset) (0x0000000000002000ull + ((offset) & 31) * 16)
+#define CVMX_SLI_PKT_IN_INSTR_COUNTS (0x0000000000001200ull)
+#define CVMX_SLI_PKT_IN_PCIE_PORT (0x00000000000011B0ull)
+#define CVMX_SLI_PKT_IPTR (0x0000000000001070ull)
+#define CVMX_SLI_PKT_OUTPUT_WMARK (0x0000000000001180ull)
+#define CVMX_SLI_PKT_OUT_BMODE (0x00000000000010D0ull)
+#define CVMX_SLI_PKT_OUT_BP_EN (0x0000000000001240ull)
+#define CVMX_SLI_PKT_OUT_ENB (0x0000000000001010ull)
+#define CVMX_SLI_PKT_PCIE_PORT (0x00000000000010E0ull)
+#define CVMX_SLI_PKT_PORT_IN_RST (0x00000000000011F0ull)
+#define CVMX_SLI_PKT_SLIST_ES (0x0000000000001050ull)
+#define CVMX_SLI_PKT_SLIST_NS (0x0000000000001040ull)
+#define CVMX_SLI_PKT_SLIST_ROR (0x0000000000001030ull)
+#define CVMX_SLI_PKT_TIME_INT (0x0000000000001140ull)
+#define CVMX_SLI_PKT_TIME_INT_ENB (0x0000000000001160ull)
+#define CVMX_SLI_PORTX_PKIND(offset) (0x0000000000000800ull + ((offset) & 31) * 16)
+#define CVMX_SLI_S2M_PORTX_CTL(offset) (0x0000000000003D80ull + ((offset) & 3) * 16)
+#define CVMX_SLI_SCRATCH_1 (0x00000000000003C0ull)
+#define CVMX_SLI_SCRATCH_2 (0x00000000000003D0ull)
+#define CVMX_SLI_STATE1 (0x0000000000000620ull)
+#define CVMX_SLI_STATE2 (0x0000000000000630ull)
+#define CVMX_SLI_STATE3 (0x0000000000000640ull)
+#define CVMX_SLI_TX_PIPE (0x0000000000001230ull)
+#define CVMX_SLI_WINDOW_CTL (0x00000000000002E0ull)
+#define CVMX_SLI_WIN_RD_ADDR (0x0000000000000010ull)
+#define CVMX_SLI_WIN_RD_DATA (0x0000000000000040ull)
+#define CVMX_SLI_WIN_WR_ADDR (0x0000000000000000ull)
+#define CVMX_SLI_WIN_WR_DATA (0x0000000000000020ull)
+#define CVMX_SLI_WIN_WR_MASK (0x0000000000000030ull)
+
+union cvmx_sli_bist_status {
+	uint64_t u64;
+	struct cvmx_sli_bist_status_s {
+		uint64_t reserved_32_63:32;
+		uint64_t ncb_req:1;
+		uint64_t n2p0_c:1;
+		uint64_t n2p0_o:1;
+		uint64_t n2p1_c:1;
+		uint64_t n2p1_o:1;
+		uint64_t cpl_p0:1;
+		uint64_t cpl_p1:1;
+		uint64_t reserved_19_24:6;
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
+		uint64_t reserved_6_8:3;
+		uint64_t dsi1_1:1;
+		uint64_t dsi1_0:1;
+		uint64_t dsi0_1:1;
+		uint64_t dsi0_0:1;
+		uint64_t msi:1;
+		uint64_t ncb_cmd:1;
+	} s;
+	struct cvmx_sli_bist_status_cn61xx {
+		uint64_t reserved_31_63:33;
+		uint64_t n2p0_c:1;
+		uint64_t n2p0_o:1;
+		uint64_t reserved_27_28:2;
+		uint64_t cpl_p0:1;
+		uint64_t cpl_p1:1;
+		uint64_t reserved_19_24:6;
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
+		uint64_t reserved_6_8:3;
+		uint64_t dsi1_1:1;
+		uint64_t dsi1_0:1;
+		uint64_t dsi0_1:1;
+		uint64_t dsi0_0:1;
+		uint64_t msi:1;
+		uint64_t ncb_cmd:1;
+	} cn61xx;
+	struct cvmx_sli_bist_status_cn63xx {
+		uint64_t reserved_31_63:33;
+		uint64_t n2p0_c:1;
+		uint64_t n2p0_o:1;
+		uint64_t n2p1_c:1;
+		uint64_t n2p1_o:1;
+		uint64_t cpl_p0:1;
+		uint64_t cpl_p1:1;
+		uint64_t reserved_19_24:6;
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
+		uint64_t reserved_6_8:3;
+		uint64_t dsi1_1:1;
+		uint64_t dsi1_0:1;
+		uint64_t dsi0_1:1;
+		uint64_t dsi0_0:1;
+		uint64_t msi:1;
+		uint64_t ncb_cmd:1;
+	} cn63xx;
+	struct cvmx_sli_bist_status_cn63xx cn63xxp1;
+	struct cvmx_sli_bist_status_cn61xx cn66xx;
+	struct cvmx_sli_bist_status_s cn68xx;
+	struct cvmx_sli_bist_status_s cn68xxp1;
+};
+
+union cvmx_sli_ctl_portx {
+	uint64_t u64;
+	struct cvmx_sli_ctl_portx_s {
+		uint64_t reserved_22_63:42;
+		uint64_t intd:1;
+		uint64_t intc:1;
+		uint64_t intb:1;
+		uint64_t inta:1;
+		uint64_t dis_port:1;
+		uint64_t waitl_com:1;
+		uint64_t intd_map:2;
+		uint64_t intc_map:2;
+		uint64_t intb_map:2;
+		uint64_t inta_map:2;
+		uint64_t ctlp_ro:1;
+		uint64_t reserved_6_6:1;
+		uint64_t ptlp_ro:1;
+		uint64_t reserved_1_4:4;
+		uint64_t wait_com:1;
+	} s;
+	struct cvmx_sli_ctl_portx_s cn61xx;
+	struct cvmx_sli_ctl_portx_s cn63xx;
+	struct cvmx_sli_ctl_portx_s cn63xxp1;
+	struct cvmx_sli_ctl_portx_s cn66xx;
+	struct cvmx_sli_ctl_portx_s cn68xx;
+	struct cvmx_sli_ctl_portx_s cn68xxp1;
+};
+
+union cvmx_sli_ctl_status {
+	uint64_t u64;
+	struct cvmx_sli_ctl_status_s {
+		uint64_t reserved_20_63:44;
+		uint64_t p1_ntags:6;
+		uint64_t p0_ntags:6;
+		uint64_t chip_rev:8;
+	} s;
+	struct cvmx_sli_ctl_status_cn61xx {
+		uint64_t reserved_14_63:50;
+		uint64_t p0_ntags:6;
+		uint64_t chip_rev:8;
+	} cn61xx;
+	struct cvmx_sli_ctl_status_s cn63xx;
+	struct cvmx_sli_ctl_status_s cn63xxp1;
+	struct cvmx_sli_ctl_status_cn61xx cn66xx;
+	struct cvmx_sli_ctl_status_s cn68xx;
+	struct cvmx_sli_ctl_status_s cn68xxp1;
+};
+
+union cvmx_sli_data_out_cnt {
+	uint64_t u64;
+	struct cvmx_sli_data_out_cnt_s {
+		uint64_t reserved_44_63:20;
+		uint64_t p1_ucnt:16;
+		uint64_t p1_fcnt:6;
+		uint64_t p0_ucnt:16;
+		uint64_t p0_fcnt:6;
+	} s;
+	struct cvmx_sli_data_out_cnt_s cn61xx;
+	struct cvmx_sli_data_out_cnt_s cn63xx;
+	struct cvmx_sli_data_out_cnt_s cn63xxp1;
+	struct cvmx_sli_data_out_cnt_s cn66xx;
+	struct cvmx_sli_data_out_cnt_s cn68xx;
+	struct cvmx_sli_data_out_cnt_s cn68xxp1;
+};
+
+union cvmx_sli_dbg_data {
+	uint64_t u64;
+	struct cvmx_sli_dbg_data_s {
+		uint64_t reserved_18_63:46;
+		uint64_t dsel_ext:1;
+		uint64_t data:17;
+	} s;
+	struct cvmx_sli_dbg_data_s cn61xx;
+	struct cvmx_sli_dbg_data_s cn63xx;
+	struct cvmx_sli_dbg_data_s cn63xxp1;
+	struct cvmx_sli_dbg_data_s cn66xx;
+	struct cvmx_sli_dbg_data_s cn68xx;
+	struct cvmx_sli_dbg_data_s cn68xxp1;
+};
+
+union cvmx_sli_dbg_select {
+	uint64_t u64;
+	struct cvmx_sli_dbg_select_s {
+		uint64_t reserved_33_63:31;
+		uint64_t adbg_sel:1;
+		uint64_t dbg_sel:32;
+	} s;
+	struct cvmx_sli_dbg_select_s cn61xx;
+	struct cvmx_sli_dbg_select_s cn63xx;
+	struct cvmx_sli_dbg_select_s cn63xxp1;
+	struct cvmx_sli_dbg_select_s cn66xx;
+	struct cvmx_sli_dbg_select_s cn68xx;
+	struct cvmx_sli_dbg_select_s cn68xxp1;
+};
+
+union cvmx_sli_dmax_cnt {
+	uint64_t u64;
+	struct cvmx_sli_dmax_cnt_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_sli_dmax_cnt_s cn61xx;
+	struct cvmx_sli_dmax_cnt_s cn63xx;
+	struct cvmx_sli_dmax_cnt_s cn63xxp1;
+	struct cvmx_sli_dmax_cnt_s cn66xx;
+	struct cvmx_sli_dmax_cnt_s cn68xx;
+	struct cvmx_sli_dmax_cnt_s cn68xxp1;
+};
+
+union cvmx_sli_dmax_int_level {
+	uint64_t u64;
+	struct cvmx_sli_dmax_int_level_s {
+		uint64_t time:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_sli_dmax_int_level_s cn61xx;
+	struct cvmx_sli_dmax_int_level_s cn63xx;
+	struct cvmx_sli_dmax_int_level_s cn63xxp1;
+	struct cvmx_sli_dmax_int_level_s cn66xx;
+	struct cvmx_sli_dmax_int_level_s cn68xx;
+	struct cvmx_sli_dmax_int_level_s cn68xxp1;
+};
+
+union cvmx_sli_dmax_tim {
+	uint64_t u64;
+	struct cvmx_sli_dmax_tim_s {
+		uint64_t reserved_32_63:32;
+		uint64_t tim:32;
+	} s;
+	struct cvmx_sli_dmax_tim_s cn61xx;
+	struct cvmx_sli_dmax_tim_s cn63xx;
+	struct cvmx_sli_dmax_tim_s cn63xxp1;
+	struct cvmx_sli_dmax_tim_s cn66xx;
+	struct cvmx_sli_dmax_tim_s cn68xx;
+	struct cvmx_sli_dmax_tim_s cn68xxp1;
+};
+
+union cvmx_sli_int_enb_ciu {
+	uint64_t u64;
+	struct cvmx_sli_int_enb_ciu_s {
+		uint64_t reserved_62_63:2;
+		uint64_t pipe_err:1;
+		uint64_t ill_pad:1;
+		uint64_t sprt3_err:1;
+		uint64_t sprt2_err:1;
+		uint64_t sprt1_err:1;
+		uint64_t sprt0_err:1;
+		uint64_t pins_err:1;
+		uint64_t pop_err:1;
+		uint64_t pdi_err:1;
+		uint64_t pgl_err:1;
+		uint64_t pin_bp:1;
+		uint64_t pout_err:1;
+		uint64_t psldbof:1;
+		uint64_t pidbof:1;
+		uint64_t reserved_38_47:10;
+		uint64_t dtime:2;
+		uint64_t dcnt:2;
+		uint64_t dmafi:2;
+		uint64_t reserved_28_31:4;
+		uint64_t m3_un_wi:1;
+		uint64_t m3_un_b0:1;
+		uint64_t m3_up_wi:1;
+		uint64_t m3_up_b0:1;
+		uint64_t m2_un_wi:1;
+		uint64_t m2_un_b0:1;
+		uint64_t m2_up_wi:1;
+		uint64_t m2_up_b0:1;
+		uint64_t reserved_18_19:2;
+		uint64_t mio_int1:1;
+		uint64_t mio_int0:1;
+		uint64_t m1_un_wi:1;
+		uint64_t m1_un_b0:1;
+		uint64_t m1_up_wi:1;
+		uint64_t m1_up_b0:1;
+		uint64_t m0_un_wi:1;
+		uint64_t m0_un_b0:1;
+		uint64_t m0_up_wi:1;
+		uint64_t m0_up_b0:1;
+		uint64_t reserved_6_7:2;
+		uint64_t ptime:1;
+		uint64_t pcnt:1;
+		uint64_t iob2big:1;
+		uint64_t bar0_to:1;
+		uint64_t reserved_1_1:1;
+		uint64_t rml_to:1;
+	} s;
+	struct cvmx_sli_int_enb_ciu_cn61xx {
+		uint64_t reserved_61_63:3;
+		uint64_t ill_pad:1;
+		uint64_t sprt3_err:1;
+		uint64_t sprt2_err:1;
+		uint64_t sprt1_err:1;
+		uint64_t sprt0_err:1;
+		uint64_t pins_err:1;
+		uint64_t pop_err:1;
+		uint64_t pdi_err:1;
+		uint64_t pgl_err:1;
+		uint64_t pin_bp:1;
+		uint64_t pout_err:1;
+		uint64_t psldbof:1;
+		uint64_t pidbof:1;
+		uint64_t reserved_38_47:10;
+		uint64_t dtime:2;
+		uint64_t dcnt:2;
+		uint64_t dmafi:2;
+		uint64_t reserved_28_31:4;
+		uint64_t m3_un_wi:1;
+		uint64_t m3_un_b0:1;
+		uint64_t m3_up_wi:1;
+		uint64_t m3_up_b0:1;
+		uint64_t m2_un_wi:1;
+		uint64_t m2_un_b0:1;
+		uint64_t m2_up_wi:1;
+		uint64_t m2_up_b0:1;
+		uint64_t reserved_18_19:2;
+		uint64_t mio_int1:1;
+		uint64_t mio_int0:1;
+		uint64_t m1_un_wi:1;
+		uint64_t m1_un_b0:1;
+		uint64_t m1_up_wi:1;
+		uint64_t m1_up_b0:1;
+		uint64_t m0_un_wi:1;
+		uint64_t m0_un_b0:1;
+		uint64_t m0_up_wi:1;
+		uint64_t m0_up_b0:1;
+		uint64_t reserved_6_7:2;
+		uint64_t ptime:1;
+		uint64_t pcnt:1;
+		uint64_t iob2big:1;
+		uint64_t bar0_to:1;
+		uint64_t reserved_1_1:1;
+		uint64_t rml_to:1;
+	} cn61xx;
+	struct cvmx_sli_int_enb_ciu_cn63xx {
+		uint64_t reserved_61_63:3;
+		uint64_t ill_pad:1;
+		uint64_t reserved_58_59:2;
+		uint64_t sprt1_err:1;
+		uint64_t sprt0_err:1;
+		uint64_t pins_err:1;
+		uint64_t pop_err:1;
+		uint64_t pdi_err:1;
+		uint64_t pgl_err:1;
+		uint64_t pin_bp:1;
+		uint64_t pout_err:1;
+		uint64_t psldbof:1;
+		uint64_t pidbof:1;
+		uint64_t reserved_38_47:10;
+		uint64_t dtime:2;
+		uint64_t dcnt:2;
+		uint64_t dmafi:2;
+		uint64_t reserved_18_31:14;
+		uint64_t mio_int1:1;
+		uint64_t mio_int0:1;
+		uint64_t m1_un_wi:1;
+		uint64_t m1_un_b0:1;
+		uint64_t m1_up_wi:1;
+		uint64_t m1_up_b0:1;
+		uint64_t m0_un_wi:1;
+		uint64_t m0_un_b0:1;
+		uint64_t m0_up_wi:1;
+		uint64_t m0_up_b0:1;
+		uint64_t reserved_6_7:2;
+		uint64_t ptime:1;
+		uint64_t pcnt:1;
+		uint64_t iob2big:1;
+		uint64_t bar0_to:1;
+		uint64_t reserved_1_1:1;
+		uint64_t rml_to:1;
+	} cn63xx;
+	struct cvmx_sli_int_enb_ciu_cn63xx cn63xxp1;
+	struct cvmx_sli_int_enb_ciu_cn61xx cn66xx;
+	struct cvmx_sli_int_enb_ciu_cn68xx {
+		uint64_t reserved_62_63:2;
+		uint64_t pipe_err:1;
+		uint64_t ill_pad:1;
+		uint64_t reserved_58_59:2;
+		uint64_t sprt1_err:1;
+		uint64_t sprt0_err:1;
+		uint64_t pins_err:1;
+		uint64_t pop_err:1;
+		uint64_t pdi_err:1;
+		uint64_t pgl_err:1;
+		uint64_t reserved_51_51:1;
+		uint64_t pout_err:1;
+		uint64_t psldbof:1;
+		uint64_t pidbof:1;
+		uint64_t reserved_38_47:10;
+		uint64_t dtime:2;
+		uint64_t dcnt:2;
+		uint64_t dmafi:2;
+		uint64_t reserved_18_31:14;
+		uint64_t mio_int1:1;
+		uint64_t mio_int0:1;
+		uint64_t m1_un_wi:1;
+		uint64_t m1_un_b0:1;
+		uint64_t m1_up_wi:1;
+		uint64_t m1_up_b0:1;
+		uint64_t m0_un_wi:1;
+		uint64_t m0_un_b0:1;
+		uint64_t m0_up_wi:1;
+		uint64_t m0_up_b0:1;
+		uint64_t reserved_6_7:2;
+		uint64_t ptime:1;
+		uint64_t pcnt:1;
+		uint64_t iob2big:1;
+		uint64_t bar0_to:1;
+		uint64_t reserved_1_1:1;
+		uint64_t rml_to:1;
+	} cn68xx;
+	struct cvmx_sli_int_enb_ciu_cn68xx cn68xxp1;
+};
+
+union cvmx_sli_int_enb_portx {
+	uint64_t u64;
+	struct cvmx_sli_int_enb_portx_s {
+		uint64_t reserved_62_63:2;
+		uint64_t pipe_err:1;
+		uint64_t ill_pad:1;
+		uint64_t sprt3_err:1;
+		uint64_t sprt2_err:1;
+		uint64_t sprt1_err:1;
+		uint64_t sprt0_err:1;
+		uint64_t pins_err:1;
+		uint64_t pop_err:1;
+		uint64_t pdi_err:1;
+		uint64_t pgl_err:1;
+		uint64_t pin_bp:1;
+		uint64_t pout_err:1;
+		uint64_t psldbof:1;
+		uint64_t pidbof:1;
+		uint64_t reserved_38_47:10;
+		uint64_t dtime:2;
+		uint64_t dcnt:2;
+		uint64_t dmafi:2;
+		uint64_t reserved_28_31:4;
+		uint64_t m3_un_wi:1;
+		uint64_t m3_un_b0:1;
+		uint64_t m3_up_wi:1;
+		uint64_t m3_up_b0:1;
+		uint64_t m2_un_wi:1;
+		uint64_t m2_un_b0:1;
+		uint64_t m2_up_wi:1;
+		uint64_t m2_up_b0:1;
+		uint64_t mac1_int:1;
+		uint64_t mac0_int:1;
+		uint64_t mio_int1:1;
+		uint64_t mio_int0:1;
+		uint64_t m1_un_wi:1;
+		uint64_t m1_un_b0:1;
+		uint64_t m1_up_wi:1;
+		uint64_t m1_up_b0:1;
+		uint64_t m0_un_wi:1;
+		uint64_t m0_un_b0:1;
+		uint64_t m0_up_wi:1;
+		uint64_t m0_up_b0:1;
+		uint64_t reserved_6_7:2;
+		uint64_t ptime:1;
+		uint64_t pcnt:1;
+		uint64_t iob2big:1;
+		uint64_t bar0_to:1;
+		uint64_t reserved_1_1:1;
+		uint64_t rml_to:1;
+	} s;
+	struct cvmx_sli_int_enb_portx_cn61xx {
+		uint64_t reserved_61_63:3;
+		uint64_t ill_pad:1;
+		uint64_t sprt3_err:1;
+		uint64_t sprt2_err:1;
+		uint64_t sprt1_err:1;
+		uint64_t sprt0_err:1;
+		uint64_t pins_err:1;
+		uint64_t pop_err:1;
+		uint64_t pdi_err:1;
+		uint64_t pgl_err:1;
+		uint64_t pin_bp:1;
+		uint64_t pout_err:1;
+		uint64_t psldbof:1;
+		uint64_t pidbof:1;
+		uint64_t reserved_38_47:10;
+		uint64_t dtime:2;
+		uint64_t dcnt:2;
+		uint64_t dmafi:2;
+		uint64_t reserved_28_31:4;
+		uint64_t m3_un_wi:1;
+		uint64_t m3_un_b0:1;
+		uint64_t m3_up_wi:1;
+		uint64_t m3_up_b0:1;
+		uint64_t m2_un_wi:1;
+		uint64_t m2_un_b0:1;
+		uint64_t m2_up_wi:1;
+		uint64_t m2_up_b0:1;
+		uint64_t mac1_int:1;
+		uint64_t mac0_int:1;
+		uint64_t mio_int1:1;
+		uint64_t mio_int0:1;
+		uint64_t m1_un_wi:1;
+		uint64_t m1_un_b0:1;
+		uint64_t m1_up_wi:1;
+		uint64_t m1_up_b0:1;
+		uint64_t m0_un_wi:1;
+		uint64_t m0_un_b0:1;
+		uint64_t m0_up_wi:1;
+		uint64_t m0_up_b0:1;
+		uint64_t reserved_6_7:2;
+		uint64_t ptime:1;
+		uint64_t pcnt:1;
+		uint64_t iob2big:1;
+		uint64_t bar0_to:1;
+		uint64_t reserved_1_1:1;
+		uint64_t rml_to:1;
+	} cn61xx;
+	struct cvmx_sli_int_enb_portx_cn63xx {
+		uint64_t reserved_61_63:3;
+		uint64_t ill_pad:1;
+		uint64_t reserved_58_59:2;
+		uint64_t sprt1_err:1;
+		uint64_t sprt0_err:1;
+		uint64_t pins_err:1;
+		uint64_t pop_err:1;
+		uint64_t pdi_err:1;
+		uint64_t pgl_err:1;
+		uint64_t pin_bp:1;
+		uint64_t pout_err:1;
+		uint64_t psldbof:1;
+		uint64_t pidbof:1;
+		uint64_t reserved_38_47:10;
+		uint64_t dtime:2;
+		uint64_t dcnt:2;
+		uint64_t dmafi:2;
+		uint64_t reserved_20_31:12;
+		uint64_t mac1_int:1;
+		uint64_t mac0_int:1;
+		uint64_t mio_int1:1;
+		uint64_t mio_int0:1;
+		uint64_t m1_un_wi:1;
+		uint64_t m1_un_b0:1;
+		uint64_t m1_up_wi:1;
+		uint64_t m1_up_b0:1;
+		uint64_t m0_un_wi:1;
+		uint64_t m0_un_b0:1;
+		uint64_t m0_up_wi:1;
+		uint64_t m0_up_b0:1;
+		uint64_t reserved_6_7:2;
+		uint64_t ptime:1;
+		uint64_t pcnt:1;
+		uint64_t iob2big:1;
+		uint64_t bar0_to:1;
+		uint64_t reserved_1_1:1;
+		uint64_t rml_to:1;
+	} cn63xx;
+	struct cvmx_sli_int_enb_portx_cn63xx cn63xxp1;
+	struct cvmx_sli_int_enb_portx_cn61xx cn66xx;
+	struct cvmx_sli_int_enb_portx_cn68xx {
+		uint64_t reserved_62_63:2;
+		uint64_t pipe_err:1;
+		uint64_t ill_pad:1;
+		uint64_t reserved_58_59:2;
+		uint64_t sprt1_err:1;
+		uint64_t sprt0_err:1;
+		uint64_t pins_err:1;
+		uint64_t pop_err:1;
+		uint64_t pdi_err:1;
+		uint64_t pgl_err:1;
+		uint64_t reserved_51_51:1;
+		uint64_t pout_err:1;
+		uint64_t psldbof:1;
+		uint64_t pidbof:1;
+		uint64_t reserved_38_47:10;
+		uint64_t dtime:2;
+		uint64_t dcnt:2;
+		uint64_t dmafi:2;
+		uint64_t reserved_20_31:12;
+		uint64_t mac1_int:1;
+		uint64_t mac0_int:1;
+		uint64_t mio_int1:1;
+		uint64_t mio_int0:1;
+		uint64_t m1_un_wi:1;
+		uint64_t m1_un_b0:1;
+		uint64_t m1_up_wi:1;
+		uint64_t m1_up_b0:1;
+		uint64_t m0_un_wi:1;
+		uint64_t m0_un_b0:1;
+		uint64_t m0_up_wi:1;
+		uint64_t m0_up_b0:1;
+		uint64_t reserved_6_7:2;
+		uint64_t ptime:1;
+		uint64_t pcnt:1;
+		uint64_t iob2big:1;
+		uint64_t bar0_to:1;
+		uint64_t reserved_1_1:1;
+		uint64_t rml_to:1;
+	} cn68xx;
+	struct cvmx_sli_int_enb_portx_cn68xx cn68xxp1;
+};
+
+union cvmx_sli_int_sum {
+	uint64_t u64;
+	struct cvmx_sli_int_sum_s {
+		uint64_t reserved_62_63:2;
+		uint64_t pipe_err:1;
+		uint64_t ill_pad:1;
+		uint64_t sprt3_err:1;
+		uint64_t sprt2_err:1;
+		uint64_t sprt1_err:1;
+		uint64_t sprt0_err:1;
+		uint64_t pins_err:1;
+		uint64_t pop_err:1;
+		uint64_t pdi_err:1;
+		uint64_t pgl_err:1;
+		uint64_t pin_bp:1;
+		uint64_t pout_err:1;
+		uint64_t psldbof:1;
+		uint64_t pidbof:1;
+		uint64_t reserved_38_47:10;
+		uint64_t dtime:2;
+		uint64_t dcnt:2;
+		uint64_t dmafi:2;
+		uint64_t reserved_28_31:4;
+		uint64_t m3_un_wi:1;
+		uint64_t m3_un_b0:1;
+		uint64_t m3_up_wi:1;
+		uint64_t m3_up_b0:1;
+		uint64_t m2_un_wi:1;
+		uint64_t m2_un_b0:1;
+		uint64_t m2_up_wi:1;
+		uint64_t m2_up_b0:1;
+		uint64_t mac1_int:1;
+		uint64_t mac0_int:1;
+		uint64_t mio_int1:1;
+		uint64_t mio_int0:1;
+		uint64_t m1_un_wi:1;
+		uint64_t m1_un_b0:1;
+		uint64_t m1_up_wi:1;
+		uint64_t m1_up_b0:1;
+		uint64_t m0_un_wi:1;
+		uint64_t m0_un_b0:1;
+		uint64_t m0_up_wi:1;
+		uint64_t m0_up_b0:1;
+		uint64_t reserved_6_7:2;
+		uint64_t ptime:1;
+		uint64_t pcnt:1;
+		uint64_t iob2big:1;
+		uint64_t bar0_to:1;
+		uint64_t reserved_1_1:1;
+		uint64_t rml_to:1;
+	} s;
+	struct cvmx_sli_int_sum_cn61xx {
+		uint64_t reserved_61_63:3;
+		uint64_t ill_pad:1;
+		uint64_t sprt3_err:1;
+		uint64_t sprt2_err:1;
+		uint64_t sprt1_err:1;
+		uint64_t sprt0_err:1;
+		uint64_t pins_err:1;
+		uint64_t pop_err:1;
+		uint64_t pdi_err:1;
+		uint64_t pgl_err:1;
+		uint64_t pin_bp:1;
+		uint64_t pout_err:1;
+		uint64_t psldbof:1;
+		uint64_t pidbof:1;
+		uint64_t reserved_38_47:10;
+		uint64_t dtime:2;
+		uint64_t dcnt:2;
+		uint64_t dmafi:2;
+		uint64_t reserved_28_31:4;
+		uint64_t m3_un_wi:1;
+		uint64_t m3_un_b0:1;
+		uint64_t m3_up_wi:1;
+		uint64_t m3_up_b0:1;
+		uint64_t m2_un_wi:1;
+		uint64_t m2_un_b0:1;
+		uint64_t m2_up_wi:1;
+		uint64_t m2_up_b0:1;
+		uint64_t mac1_int:1;
+		uint64_t mac0_int:1;
+		uint64_t mio_int1:1;
+		uint64_t mio_int0:1;
+		uint64_t m1_un_wi:1;
+		uint64_t m1_un_b0:1;
+		uint64_t m1_up_wi:1;
+		uint64_t m1_up_b0:1;
+		uint64_t m0_un_wi:1;
+		uint64_t m0_un_b0:1;
+		uint64_t m0_up_wi:1;
+		uint64_t m0_up_b0:1;
+		uint64_t reserved_6_7:2;
+		uint64_t ptime:1;
+		uint64_t pcnt:1;
+		uint64_t iob2big:1;
+		uint64_t bar0_to:1;
+		uint64_t reserved_1_1:1;
+		uint64_t rml_to:1;
+	} cn61xx;
+	struct cvmx_sli_int_sum_cn63xx {
+		uint64_t reserved_61_63:3;
+		uint64_t ill_pad:1;
+		uint64_t reserved_58_59:2;
+		uint64_t sprt1_err:1;
+		uint64_t sprt0_err:1;
+		uint64_t pins_err:1;
+		uint64_t pop_err:1;
+		uint64_t pdi_err:1;
+		uint64_t pgl_err:1;
+		uint64_t pin_bp:1;
+		uint64_t pout_err:1;
+		uint64_t psldbof:1;
+		uint64_t pidbof:1;
+		uint64_t reserved_38_47:10;
+		uint64_t dtime:2;
+		uint64_t dcnt:2;
+		uint64_t dmafi:2;
+		uint64_t reserved_20_31:12;
+		uint64_t mac1_int:1;
+		uint64_t mac0_int:1;
+		uint64_t mio_int1:1;
+		uint64_t mio_int0:1;
+		uint64_t m1_un_wi:1;
+		uint64_t m1_un_b0:1;
+		uint64_t m1_up_wi:1;
+		uint64_t m1_up_b0:1;
+		uint64_t m0_un_wi:1;
+		uint64_t m0_un_b0:1;
+		uint64_t m0_up_wi:1;
+		uint64_t m0_up_b0:1;
+		uint64_t reserved_6_7:2;
+		uint64_t ptime:1;
+		uint64_t pcnt:1;
+		uint64_t iob2big:1;
+		uint64_t bar0_to:1;
+		uint64_t reserved_1_1:1;
+		uint64_t rml_to:1;
+	} cn63xx;
+	struct cvmx_sli_int_sum_cn63xx cn63xxp1;
+	struct cvmx_sli_int_sum_cn61xx cn66xx;
+	struct cvmx_sli_int_sum_cn68xx {
+		uint64_t reserved_62_63:2;
+		uint64_t pipe_err:1;
+		uint64_t ill_pad:1;
+		uint64_t reserved_58_59:2;
+		uint64_t sprt1_err:1;
+		uint64_t sprt0_err:1;
+		uint64_t pins_err:1;
+		uint64_t pop_err:1;
+		uint64_t pdi_err:1;
+		uint64_t pgl_err:1;
+		uint64_t reserved_51_51:1;
+		uint64_t pout_err:1;
+		uint64_t psldbof:1;
+		uint64_t pidbof:1;
+		uint64_t reserved_38_47:10;
+		uint64_t dtime:2;
+		uint64_t dcnt:2;
+		uint64_t dmafi:2;
+		uint64_t reserved_20_31:12;
+		uint64_t mac1_int:1;
+		uint64_t mac0_int:1;
+		uint64_t mio_int1:1;
+		uint64_t mio_int0:1;
+		uint64_t m1_un_wi:1;
+		uint64_t m1_un_b0:1;
+		uint64_t m1_up_wi:1;
+		uint64_t m1_up_b0:1;
+		uint64_t m0_un_wi:1;
+		uint64_t m0_un_b0:1;
+		uint64_t m0_up_wi:1;
+		uint64_t m0_up_b0:1;
+		uint64_t reserved_6_7:2;
+		uint64_t ptime:1;
+		uint64_t pcnt:1;
+		uint64_t iob2big:1;
+		uint64_t bar0_to:1;
+		uint64_t reserved_1_1:1;
+		uint64_t rml_to:1;
+	} cn68xx;
+	struct cvmx_sli_int_sum_cn68xx cn68xxp1;
+};
+
+union cvmx_sli_last_win_rdata0 {
+	uint64_t u64;
+	struct cvmx_sli_last_win_rdata0_s {
+		uint64_t data:64;
+	} s;
+	struct cvmx_sli_last_win_rdata0_s cn61xx;
+	struct cvmx_sli_last_win_rdata0_s cn63xx;
+	struct cvmx_sli_last_win_rdata0_s cn63xxp1;
+	struct cvmx_sli_last_win_rdata0_s cn66xx;
+	struct cvmx_sli_last_win_rdata0_s cn68xx;
+	struct cvmx_sli_last_win_rdata0_s cn68xxp1;
+};
+
+union cvmx_sli_last_win_rdata1 {
+	uint64_t u64;
+	struct cvmx_sli_last_win_rdata1_s {
+		uint64_t data:64;
+	} s;
+	struct cvmx_sli_last_win_rdata1_s cn61xx;
+	struct cvmx_sli_last_win_rdata1_s cn63xx;
+	struct cvmx_sli_last_win_rdata1_s cn63xxp1;
+	struct cvmx_sli_last_win_rdata1_s cn66xx;
+	struct cvmx_sli_last_win_rdata1_s cn68xx;
+	struct cvmx_sli_last_win_rdata1_s cn68xxp1;
+};
+
+union cvmx_sli_last_win_rdata2 {
+	uint64_t u64;
+	struct cvmx_sli_last_win_rdata2_s {
+		uint64_t data:64;
+	} s;
+	struct cvmx_sli_last_win_rdata2_s cn61xx;
+	struct cvmx_sli_last_win_rdata2_s cn66xx;
+};
+
+union cvmx_sli_last_win_rdata3 {
+	uint64_t u64;
+	struct cvmx_sli_last_win_rdata3_s {
+		uint64_t data:64;
+	} s;
+	struct cvmx_sli_last_win_rdata3_s cn61xx;
+	struct cvmx_sli_last_win_rdata3_s cn66xx;
+};
+
+union cvmx_sli_mac_credit_cnt {
+	uint64_t u64;
+	struct cvmx_sli_mac_credit_cnt_s {
+		uint64_t reserved_54_63:10;
+		uint64_t p1_c_d:1;
+		uint64_t p1_n_d:1;
+		uint64_t p1_p_d:1;
+		uint64_t p0_c_d:1;
+		uint64_t p0_n_d:1;
+		uint64_t p0_p_d:1;
+		uint64_t p1_ccnt:8;
+		uint64_t p1_ncnt:8;
+		uint64_t p1_pcnt:8;
+		uint64_t p0_ccnt:8;
+		uint64_t p0_ncnt:8;
+		uint64_t p0_pcnt:8;
+	} s;
+	struct cvmx_sli_mac_credit_cnt_s cn61xx;
+	struct cvmx_sli_mac_credit_cnt_s cn63xx;
+	struct cvmx_sli_mac_credit_cnt_cn63xxp1 {
+		uint64_t reserved_48_63:16;
+		uint64_t p1_ccnt:8;
+		uint64_t p1_ncnt:8;
+		uint64_t p1_pcnt:8;
+		uint64_t p0_ccnt:8;
+		uint64_t p0_ncnt:8;
+		uint64_t p0_pcnt:8;
+	} cn63xxp1;
+	struct cvmx_sli_mac_credit_cnt_s cn66xx;
+	struct cvmx_sli_mac_credit_cnt_s cn68xx;
+	struct cvmx_sli_mac_credit_cnt_s cn68xxp1;
+};
+
+union cvmx_sli_mac_credit_cnt2 {
+	uint64_t u64;
+	struct cvmx_sli_mac_credit_cnt2_s {
+		uint64_t reserved_54_63:10;
+		uint64_t p3_c_d:1;
+		uint64_t p3_n_d:1;
+		uint64_t p3_p_d:1;
+		uint64_t p2_c_d:1;
+		uint64_t p2_n_d:1;
+		uint64_t p2_p_d:1;
+		uint64_t p3_ccnt:8;
+		uint64_t p3_ncnt:8;
+		uint64_t p3_pcnt:8;
+		uint64_t p2_ccnt:8;
+		uint64_t p2_ncnt:8;
+		uint64_t p2_pcnt:8;
+	} s;
+	struct cvmx_sli_mac_credit_cnt2_s cn61xx;
+	struct cvmx_sli_mac_credit_cnt2_s cn66xx;
+};
+
+union cvmx_sli_mac_number {
+	uint64_t u64;
+	struct cvmx_sli_mac_number_s {
+		uint64_t reserved_9_63:55;
+		uint64_t a_mode:1;
+		uint64_t num:8;
+	} s;
+	struct cvmx_sli_mac_number_s cn61xx;
+	struct cvmx_sli_mac_number_cn63xx {
+		uint64_t reserved_8_63:56;
+		uint64_t num:8;
+	} cn63xx;
+	struct cvmx_sli_mac_number_s cn66xx;
+	struct cvmx_sli_mac_number_cn63xx cn68xx;
+	struct cvmx_sli_mac_number_cn63xx cn68xxp1;
+};
+
+union cvmx_sli_mem_access_ctl {
+	uint64_t u64;
+	struct cvmx_sli_mem_access_ctl_s {
+		uint64_t reserved_14_63:50;
+		uint64_t max_word:4;
+		uint64_t timer:10;
+	} s;
+	struct cvmx_sli_mem_access_ctl_s cn61xx;
+	struct cvmx_sli_mem_access_ctl_s cn63xx;
+	struct cvmx_sli_mem_access_ctl_s cn63xxp1;
+	struct cvmx_sli_mem_access_ctl_s cn66xx;
+	struct cvmx_sli_mem_access_ctl_s cn68xx;
+	struct cvmx_sli_mem_access_ctl_s cn68xxp1;
+};
+
+union cvmx_sli_mem_access_subidx {
+	uint64_t u64;
+	struct cvmx_sli_mem_access_subidx_s {
+		uint64_t reserved_43_63:21;
+		uint64_t zero:1;
+		uint64_t port:3;
+		uint64_t nmerge:1;
+		uint64_t esr:2;
+		uint64_t esw:2;
+		uint64_t wtype:2;
+		uint64_t rtype:2;
+		uint64_t reserved_0_29:30;
+	} s;
+	struct cvmx_sli_mem_access_subidx_cn61xx {
+		uint64_t reserved_43_63:21;
+		uint64_t zero:1;
+		uint64_t port:3;
+		uint64_t nmerge:1;
+		uint64_t esr:2;
+		uint64_t esw:2;
+		uint64_t wtype:2;
+		uint64_t rtype:2;
+		uint64_t ba:30;
+	} cn61xx;
+	struct cvmx_sli_mem_access_subidx_cn61xx cn63xx;
+	struct cvmx_sli_mem_access_subidx_cn61xx cn63xxp1;
+	struct cvmx_sli_mem_access_subidx_cn61xx cn66xx;
+	struct cvmx_sli_mem_access_subidx_cn68xx {
+		uint64_t reserved_43_63:21;
+		uint64_t zero:1;
+		uint64_t port:3;
+		uint64_t nmerge:1;
+		uint64_t esr:2;
+		uint64_t esw:2;
+		uint64_t wtype:2;
+		uint64_t rtype:2;
+		uint64_t ba:28;
+		uint64_t reserved_0_1:2;
+	} cn68xx;
+	struct cvmx_sli_mem_access_subidx_cn68xx cn68xxp1;
+};
+
+union cvmx_sli_msi_enb0 {
+	uint64_t u64;
+	struct cvmx_sli_msi_enb0_s {
+		uint64_t enb:64;
+	} s;
+	struct cvmx_sli_msi_enb0_s cn61xx;
+	struct cvmx_sli_msi_enb0_s cn63xx;
+	struct cvmx_sli_msi_enb0_s cn63xxp1;
+	struct cvmx_sli_msi_enb0_s cn66xx;
+	struct cvmx_sli_msi_enb0_s cn68xx;
+	struct cvmx_sli_msi_enb0_s cn68xxp1;
+};
+
+union cvmx_sli_msi_enb1 {
+	uint64_t u64;
+	struct cvmx_sli_msi_enb1_s {
+		uint64_t enb:64;
+	} s;
+	struct cvmx_sli_msi_enb1_s cn61xx;
+	struct cvmx_sli_msi_enb1_s cn63xx;
+	struct cvmx_sli_msi_enb1_s cn63xxp1;
+	struct cvmx_sli_msi_enb1_s cn66xx;
+	struct cvmx_sli_msi_enb1_s cn68xx;
+	struct cvmx_sli_msi_enb1_s cn68xxp1;
+};
+
+union cvmx_sli_msi_enb2 {
+	uint64_t u64;
+	struct cvmx_sli_msi_enb2_s {
+		uint64_t enb:64;
+	} s;
+	struct cvmx_sli_msi_enb2_s cn61xx;
+	struct cvmx_sli_msi_enb2_s cn63xx;
+	struct cvmx_sli_msi_enb2_s cn63xxp1;
+	struct cvmx_sli_msi_enb2_s cn66xx;
+	struct cvmx_sli_msi_enb2_s cn68xx;
+	struct cvmx_sli_msi_enb2_s cn68xxp1;
+};
+
+union cvmx_sli_msi_enb3 {
+	uint64_t u64;
+	struct cvmx_sli_msi_enb3_s {
+		uint64_t enb:64;
+	} s;
+	struct cvmx_sli_msi_enb3_s cn61xx;
+	struct cvmx_sli_msi_enb3_s cn63xx;
+	struct cvmx_sli_msi_enb3_s cn63xxp1;
+	struct cvmx_sli_msi_enb3_s cn66xx;
+	struct cvmx_sli_msi_enb3_s cn68xx;
+	struct cvmx_sli_msi_enb3_s cn68xxp1;
+};
+
+union cvmx_sli_msi_rcv0 {
+	uint64_t u64;
+	struct cvmx_sli_msi_rcv0_s {
+		uint64_t intr:64;
+	} s;
+	struct cvmx_sli_msi_rcv0_s cn61xx;
+	struct cvmx_sli_msi_rcv0_s cn63xx;
+	struct cvmx_sli_msi_rcv0_s cn63xxp1;
+	struct cvmx_sli_msi_rcv0_s cn66xx;
+	struct cvmx_sli_msi_rcv0_s cn68xx;
+	struct cvmx_sli_msi_rcv0_s cn68xxp1;
+};
+
+union cvmx_sli_msi_rcv1 {
+	uint64_t u64;
+	struct cvmx_sli_msi_rcv1_s {
+		uint64_t intr:64;
+	} s;
+	struct cvmx_sli_msi_rcv1_s cn61xx;
+	struct cvmx_sli_msi_rcv1_s cn63xx;
+	struct cvmx_sli_msi_rcv1_s cn63xxp1;
+	struct cvmx_sli_msi_rcv1_s cn66xx;
+	struct cvmx_sli_msi_rcv1_s cn68xx;
+	struct cvmx_sli_msi_rcv1_s cn68xxp1;
+};
+
+union cvmx_sli_msi_rcv2 {
+	uint64_t u64;
+	struct cvmx_sli_msi_rcv2_s {
+		uint64_t intr:64;
+	} s;
+	struct cvmx_sli_msi_rcv2_s cn61xx;
+	struct cvmx_sli_msi_rcv2_s cn63xx;
+	struct cvmx_sli_msi_rcv2_s cn63xxp1;
+	struct cvmx_sli_msi_rcv2_s cn66xx;
+	struct cvmx_sli_msi_rcv2_s cn68xx;
+	struct cvmx_sli_msi_rcv2_s cn68xxp1;
+};
+
+union cvmx_sli_msi_rcv3 {
+	uint64_t u64;
+	struct cvmx_sli_msi_rcv3_s {
+		uint64_t intr:64;
+	} s;
+	struct cvmx_sli_msi_rcv3_s cn61xx;
+	struct cvmx_sli_msi_rcv3_s cn63xx;
+	struct cvmx_sli_msi_rcv3_s cn63xxp1;
+	struct cvmx_sli_msi_rcv3_s cn66xx;
+	struct cvmx_sli_msi_rcv3_s cn68xx;
+	struct cvmx_sli_msi_rcv3_s cn68xxp1;
+};
+
+union cvmx_sli_msi_rd_map {
+	uint64_t u64;
+	struct cvmx_sli_msi_rd_map_s {
+		uint64_t reserved_16_63:48;
+		uint64_t rd_int:8;
+		uint64_t msi_int:8;
+	} s;
+	struct cvmx_sli_msi_rd_map_s cn61xx;
+	struct cvmx_sli_msi_rd_map_s cn63xx;
+	struct cvmx_sli_msi_rd_map_s cn63xxp1;
+	struct cvmx_sli_msi_rd_map_s cn66xx;
+	struct cvmx_sli_msi_rd_map_s cn68xx;
+	struct cvmx_sli_msi_rd_map_s cn68xxp1;
+};
+
+union cvmx_sli_msi_w1c_enb0 {
+	uint64_t u64;
+	struct cvmx_sli_msi_w1c_enb0_s {
+		uint64_t clr:64;
+	} s;
+	struct cvmx_sli_msi_w1c_enb0_s cn61xx;
+	struct cvmx_sli_msi_w1c_enb0_s cn63xx;
+	struct cvmx_sli_msi_w1c_enb0_s cn63xxp1;
+	struct cvmx_sli_msi_w1c_enb0_s cn66xx;
+	struct cvmx_sli_msi_w1c_enb0_s cn68xx;
+	struct cvmx_sli_msi_w1c_enb0_s cn68xxp1;
+};
+
+union cvmx_sli_msi_w1c_enb1 {
+	uint64_t u64;
+	struct cvmx_sli_msi_w1c_enb1_s {
+		uint64_t clr:64;
+	} s;
+	struct cvmx_sli_msi_w1c_enb1_s cn61xx;
+	struct cvmx_sli_msi_w1c_enb1_s cn63xx;
+	struct cvmx_sli_msi_w1c_enb1_s cn63xxp1;
+	struct cvmx_sli_msi_w1c_enb1_s cn66xx;
+	struct cvmx_sli_msi_w1c_enb1_s cn68xx;
+	struct cvmx_sli_msi_w1c_enb1_s cn68xxp1;
+};
+
+union cvmx_sli_msi_w1c_enb2 {
+	uint64_t u64;
+	struct cvmx_sli_msi_w1c_enb2_s {
+		uint64_t clr:64;
+	} s;
+	struct cvmx_sli_msi_w1c_enb2_s cn61xx;
+	struct cvmx_sli_msi_w1c_enb2_s cn63xx;
+	struct cvmx_sli_msi_w1c_enb2_s cn63xxp1;
+	struct cvmx_sli_msi_w1c_enb2_s cn66xx;
+	struct cvmx_sli_msi_w1c_enb2_s cn68xx;
+	struct cvmx_sli_msi_w1c_enb2_s cn68xxp1;
+};
+
+union cvmx_sli_msi_w1c_enb3 {
+	uint64_t u64;
+	struct cvmx_sli_msi_w1c_enb3_s {
+		uint64_t clr:64;
+	} s;
+	struct cvmx_sli_msi_w1c_enb3_s cn61xx;
+	struct cvmx_sli_msi_w1c_enb3_s cn63xx;
+	struct cvmx_sli_msi_w1c_enb3_s cn63xxp1;
+	struct cvmx_sli_msi_w1c_enb3_s cn66xx;
+	struct cvmx_sli_msi_w1c_enb3_s cn68xx;
+	struct cvmx_sli_msi_w1c_enb3_s cn68xxp1;
+};
+
+union cvmx_sli_msi_w1s_enb0 {
+	uint64_t u64;
+	struct cvmx_sli_msi_w1s_enb0_s {
+		uint64_t set:64;
+	} s;
+	struct cvmx_sli_msi_w1s_enb0_s cn61xx;
+	struct cvmx_sli_msi_w1s_enb0_s cn63xx;
+	struct cvmx_sli_msi_w1s_enb0_s cn63xxp1;
+	struct cvmx_sli_msi_w1s_enb0_s cn66xx;
+	struct cvmx_sli_msi_w1s_enb0_s cn68xx;
+	struct cvmx_sli_msi_w1s_enb0_s cn68xxp1;
+};
+
+union cvmx_sli_msi_w1s_enb1 {
+	uint64_t u64;
+	struct cvmx_sli_msi_w1s_enb1_s {
+		uint64_t set:64;
+	} s;
+	struct cvmx_sli_msi_w1s_enb1_s cn61xx;
+	struct cvmx_sli_msi_w1s_enb1_s cn63xx;
+	struct cvmx_sli_msi_w1s_enb1_s cn63xxp1;
+	struct cvmx_sli_msi_w1s_enb1_s cn66xx;
+	struct cvmx_sli_msi_w1s_enb1_s cn68xx;
+	struct cvmx_sli_msi_w1s_enb1_s cn68xxp1;
+};
+
+union cvmx_sli_msi_w1s_enb2 {
+	uint64_t u64;
+	struct cvmx_sli_msi_w1s_enb2_s {
+		uint64_t set:64;
+	} s;
+	struct cvmx_sli_msi_w1s_enb2_s cn61xx;
+	struct cvmx_sli_msi_w1s_enb2_s cn63xx;
+	struct cvmx_sli_msi_w1s_enb2_s cn63xxp1;
+	struct cvmx_sli_msi_w1s_enb2_s cn66xx;
+	struct cvmx_sli_msi_w1s_enb2_s cn68xx;
+	struct cvmx_sli_msi_w1s_enb2_s cn68xxp1;
+};
+
+union cvmx_sli_msi_w1s_enb3 {
+	uint64_t u64;
+	struct cvmx_sli_msi_w1s_enb3_s {
+		uint64_t set:64;
+	} s;
+	struct cvmx_sli_msi_w1s_enb3_s cn61xx;
+	struct cvmx_sli_msi_w1s_enb3_s cn63xx;
+	struct cvmx_sli_msi_w1s_enb3_s cn63xxp1;
+	struct cvmx_sli_msi_w1s_enb3_s cn66xx;
+	struct cvmx_sli_msi_w1s_enb3_s cn68xx;
+	struct cvmx_sli_msi_w1s_enb3_s cn68xxp1;
+};
+
+union cvmx_sli_msi_wr_map {
+	uint64_t u64;
+	struct cvmx_sli_msi_wr_map_s {
+		uint64_t reserved_16_63:48;
+		uint64_t ciu_int:8;
+		uint64_t msi_int:8;
+	} s;
+	struct cvmx_sli_msi_wr_map_s cn61xx;
+	struct cvmx_sli_msi_wr_map_s cn63xx;
+	struct cvmx_sli_msi_wr_map_s cn63xxp1;
+	struct cvmx_sli_msi_wr_map_s cn66xx;
+	struct cvmx_sli_msi_wr_map_s cn68xx;
+	struct cvmx_sli_msi_wr_map_s cn68xxp1;
+};
+
+union cvmx_sli_pcie_msi_rcv {
+	uint64_t u64;
+	struct cvmx_sli_pcie_msi_rcv_s {
+		uint64_t reserved_8_63:56;
+		uint64_t intr:8;
+	} s;
+	struct cvmx_sli_pcie_msi_rcv_s cn61xx;
+	struct cvmx_sli_pcie_msi_rcv_s cn63xx;
+	struct cvmx_sli_pcie_msi_rcv_s cn63xxp1;
+	struct cvmx_sli_pcie_msi_rcv_s cn66xx;
+	struct cvmx_sli_pcie_msi_rcv_s cn68xx;
+	struct cvmx_sli_pcie_msi_rcv_s cn68xxp1;
+};
+
+union cvmx_sli_pcie_msi_rcv_b1 {
+	uint64_t u64;
+	struct cvmx_sli_pcie_msi_rcv_b1_s {
+		uint64_t reserved_16_63:48;
+		uint64_t intr:8;
+		uint64_t reserved_0_7:8;
+	} s;
+	struct cvmx_sli_pcie_msi_rcv_b1_s cn61xx;
+	struct cvmx_sli_pcie_msi_rcv_b1_s cn63xx;
+	struct cvmx_sli_pcie_msi_rcv_b1_s cn63xxp1;
+	struct cvmx_sli_pcie_msi_rcv_b1_s cn66xx;
+	struct cvmx_sli_pcie_msi_rcv_b1_s cn68xx;
+	struct cvmx_sli_pcie_msi_rcv_b1_s cn68xxp1;
+};
+
+union cvmx_sli_pcie_msi_rcv_b2 {
+	uint64_t u64;
+	struct cvmx_sli_pcie_msi_rcv_b2_s {
+		uint64_t reserved_24_63:40;
+		uint64_t intr:8;
+		uint64_t reserved_0_15:16;
+	} s;
+	struct cvmx_sli_pcie_msi_rcv_b2_s cn61xx;
+	struct cvmx_sli_pcie_msi_rcv_b2_s cn63xx;
+	struct cvmx_sli_pcie_msi_rcv_b2_s cn63xxp1;
+	struct cvmx_sli_pcie_msi_rcv_b2_s cn66xx;
+	struct cvmx_sli_pcie_msi_rcv_b2_s cn68xx;
+	struct cvmx_sli_pcie_msi_rcv_b2_s cn68xxp1;
+};
+
+union cvmx_sli_pcie_msi_rcv_b3 {
+	uint64_t u64;
+	struct cvmx_sli_pcie_msi_rcv_b3_s {
+		uint64_t reserved_32_63:32;
+		uint64_t intr:8;
+		uint64_t reserved_0_23:24;
+	} s;
+	struct cvmx_sli_pcie_msi_rcv_b3_s cn61xx;
+	struct cvmx_sli_pcie_msi_rcv_b3_s cn63xx;
+	struct cvmx_sli_pcie_msi_rcv_b3_s cn63xxp1;
+	struct cvmx_sli_pcie_msi_rcv_b3_s cn66xx;
+	struct cvmx_sli_pcie_msi_rcv_b3_s cn68xx;
+	struct cvmx_sli_pcie_msi_rcv_b3_s cn68xxp1;
+};
+
+union cvmx_sli_pktx_cnts {
+	uint64_t u64;
+	struct cvmx_sli_pktx_cnts_s {
+		uint64_t reserved_54_63:10;
+		uint64_t timer:22;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_sli_pktx_cnts_s cn61xx;
+	struct cvmx_sli_pktx_cnts_s cn63xx;
+	struct cvmx_sli_pktx_cnts_s cn63xxp1;
+	struct cvmx_sli_pktx_cnts_s cn66xx;
+	struct cvmx_sli_pktx_cnts_s cn68xx;
+	struct cvmx_sli_pktx_cnts_s cn68xxp1;
+};
+
+union cvmx_sli_pktx_in_bp {
+	uint64_t u64;
+	struct cvmx_sli_pktx_in_bp_s {
+		uint64_t wmark:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_sli_pktx_in_bp_s cn61xx;
+	struct cvmx_sli_pktx_in_bp_s cn63xx;
+	struct cvmx_sli_pktx_in_bp_s cn63xxp1;
+	struct cvmx_sli_pktx_in_bp_s cn66xx;
+};
+
+union cvmx_sli_pktx_instr_baddr {
+	uint64_t u64;
+	struct cvmx_sli_pktx_instr_baddr_s {
+		uint64_t addr:61;
+		uint64_t reserved_0_2:3;
+	} s;
+	struct cvmx_sli_pktx_instr_baddr_s cn61xx;
+	struct cvmx_sli_pktx_instr_baddr_s cn63xx;
+	struct cvmx_sli_pktx_instr_baddr_s cn63xxp1;
+	struct cvmx_sli_pktx_instr_baddr_s cn66xx;
+	struct cvmx_sli_pktx_instr_baddr_s cn68xx;
+	struct cvmx_sli_pktx_instr_baddr_s cn68xxp1;
+};
+
+union cvmx_sli_pktx_instr_baoff_dbell {
+	uint64_t u64;
+	struct cvmx_sli_pktx_instr_baoff_dbell_s {
+		uint64_t aoff:32;
+		uint64_t dbell:32;
+	} s;
+	struct cvmx_sli_pktx_instr_baoff_dbell_s cn61xx;
+	struct cvmx_sli_pktx_instr_baoff_dbell_s cn63xx;
+	struct cvmx_sli_pktx_instr_baoff_dbell_s cn63xxp1;
+	struct cvmx_sli_pktx_instr_baoff_dbell_s cn66xx;
+	struct cvmx_sli_pktx_instr_baoff_dbell_s cn68xx;
+	struct cvmx_sli_pktx_instr_baoff_dbell_s cn68xxp1;
+};
+
+union cvmx_sli_pktx_instr_fifo_rsize {
+	uint64_t u64;
+	struct cvmx_sli_pktx_instr_fifo_rsize_s {
+		uint64_t max:9;
+		uint64_t rrp:9;
+		uint64_t wrp:9;
+		uint64_t fcnt:5;
+		uint64_t rsize:32;
+	} s;
+	struct cvmx_sli_pktx_instr_fifo_rsize_s cn61xx;
+	struct cvmx_sli_pktx_instr_fifo_rsize_s cn63xx;
+	struct cvmx_sli_pktx_instr_fifo_rsize_s cn63xxp1;
+	struct cvmx_sli_pktx_instr_fifo_rsize_s cn66xx;
+	struct cvmx_sli_pktx_instr_fifo_rsize_s cn68xx;
+	struct cvmx_sli_pktx_instr_fifo_rsize_s cn68xxp1;
+};
+
+union cvmx_sli_pktx_instr_header {
+	uint64_t u64;
+	struct cvmx_sli_pktx_instr_header_s {
+		uint64_t reserved_44_63:20;
+		uint64_t pbp:1;
+		uint64_t reserved_38_42:5;
+		uint64_t rparmode:2;
+		uint64_t reserved_35_35:1;
+		uint64_t rskp_len:7;
+		uint64_t rngrpext:2;
+		uint64_t rnqos:1;
+		uint64_t rngrp:1;
+		uint64_t rntt:1;
+		uint64_t rntag:1;
+		uint64_t use_ihdr:1;
+		uint64_t reserved_16_20:5;
+		uint64_t par_mode:2;
+		uint64_t reserved_13_13:1;
+		uint64_t skp_len:7;
+		uint64_t ngrpext:2;
+		uint64_t nqos:1;
+		uint64_t ngrp:1;
+		uint64_t ntt:1;
+		uint64_t ntag:1;
+	} s;
+	struct cvmx_sli_pktx_instr_header_cn61xx {
+		uint64_t reserved_44_63:20;
+		uint64_t pbp:1;
+		uint64_t reserved_38_42:5;
+		uint64_t rparmode:2;
+		uint64_t reserved_35_35:1;
+		uint64_t rskp_len:7;
+		uint64_t reserved_26_27:2;
+		uint64_t rnqos:1;
+		uint64_t rngrp:1;
+		uint64_t rntt:1;
+		uint64_t rntag:1;
+		uint64_t use_ihdr:1;
+		uint64_t reserved_16_20:5;
+		uint64_t par_mode:2;
+		uint64_t reserved_13_13:1;
+		uint64_t skp_len:7;
+		uint64_t reserved_4_5:2;
+		uint64_t nqos:1;
+		uint64_t ngrp:1;
+		uint64_t ntt:1;
+		uint64_t ntag:1;
+	} cn61xx;
+	struct cvmx_sli_pktx_instr_header_cn61xx cn63xx;
+	struct cvmx_sli_pktx_instr_header_cn61xx cn63xxp1;
+	struct cvmx_sli_pktx_instr_header_cn61xx cn66xx;
+	struct cvmx_sli_pktx_instr_header_s cn68xx;
+	struct cvmx_sli_pktx_instr_header_cn61xx cn68xxp1;
+};
+
+union cvmx_sli_pktx_out_size {
+	uint64_t u64;
+	struct cvmx_sli_pktx_out_size_s {
+		uint64_t reserved_23_63:41;
+		uint64_t isize:7;
+		uint64_t bsize:16;
+	} s;
+	struct cvmx_sli_pktx_out_size_s cn61xx;
+	struct cvmx_sli_pktx_out_size_s cn63xx;
+	struct cvmx_sli_pktx_out_size_s cn63xxp1;
+	struct cvmx_sli_pktx_out_size_s cn66xx;
+	struct cvmx_sli_pktx_out_size_s cn68xx;
+	struct cvmx_sli_pktx_out_size_s cn68xxp1;
+};
+
+union cvmx_sli_pktx_slist_baddr {
+	uint64_t u64;
+	struct cvmx_sli_pktx_slist_baddr_s {
+		uint64_t addr:60;
+		uint64_t reserved_0_3:4;
+	} s;
+	struct cvmx_sli_pktx_slist_baddr_s cn61xx;
+	struct cvmx_sli_pktx_slist_baddr_s cn63xx;
+	struct cvmx_sli_pktx_slist_baddr_s cn63xxp1;
+	struct cvmx_sli_pktx_slist_baddr_s cn66xx;
+	struct cvmx_sli_pktx_slist_baddr_s cn68xx;
+	struct cvmx_sli_pktx_slist_baddr_s cn68xxp1;
+};
+
+union cvmx_sli_pktx_slist_baoff_dbell {
+	uint64_t u64;
+	struct cvmx_sli_pktx_slist_baoff_dbell_s {
+		uint64_t aoff:32;
+		uint64_t dbell:32;
+	} s;
+	struct cvmx_sli_pktx_slist_baoff_dbell_s cn61xx;
+	struct cvmx_sli_pktx_slist_baoff_dbell_s cn63xx;
+	struct cvmx_sli_pktx_slist_baoff_dbell_s cn63xxp1;
+	struct cvmx_sli_pktx_slist_baoff_dbell_s cn66xx;
+	struct cvmx_sli_pktx_slist_baoff_dbell_s cn68xx;
+	struct cvmx_sli_pktx_slist_baoff_dbell_s cn68xxp1;
+};
+
+union cvmx_sli_pktx_slist_fifo_rsize {
+	uint64_t u64;
+	struct cvmx_sli_pktx_slist_fifo_rsize_s {
+		uint64_t reserved_32_63:32;
+		uint64_t rsize:32;
+	} s;
+	struct cvmx_sli_pktx_slist_fifo_rsize_s cn61xx;
+	struct cvmx_sli_pktx_slist_fifo_rsize_s cn63xx;
+	struct cvmx_sli_pktx_slist_fifo_rsize_s cn63xxp1;
+	struct cvmx_sli_pktx_slist_fifo_rsize_s cn66xx;
+	struct cvmx_sli_pktx_slist_fifo_rsize_s cn68xx;
+	struct cvmx_sli_pktx_slist_fifo_rsize_s cn68xxp1;
+};
+
+union cvmx_sli_pkt_cnt_int {
+	uint64_t u64;
+	struct cvmx_sli_pkt_cnt_int_s {
+		uint64_t reserved_32_63:32;
+		uint64_t port:32;
+	} s;
+	struct cvmx_sli_pkt_cnt_int_s cn61xx;
+	struct cvmx_sli_pkt_cnt_int_s cn63xx;
+	struct cvmx_sli_pkt_cnt_int_s cn63xxp1;
+	struct cvmx_sli_pkt_cnt_int_s cn66xx;
+	struct cvmx_sli_pkt_cnt_int_s cn68xx;
+	struct cvmx_sli_pkt_cnt_int_s cn68xxp1;
+};
+
+union cvmx_sli_pkt_cnt_int_enb {
+	uint64_t u64;
+	struct cvmx_sli_pkt_cnt_int_enb_s {
+		uint64_t reserved_32_63:32;
+		uint64_t port:32;
+	} s;
+	struct cvmx_sli_pkt_cnt_int_enb_s cn61xx;
+	struct cvmx_sli_pkt_cnt_int_enb_s cn63xx;
+	struct cvmx_sli_pkt_cnt_int_enb_s cn63xxp1;
+	struct cvmx_sli_pkt_cnt_int_enb_s cn66xx;
+	struct cvmx_sli_pkt_cnt_int_enb_s cn68xx;
+	struct cvmx_sli_pkt_cnt_int_enb_s cn68xxp1;
+};
+
+union cvmx_sli_pkt_ctl {
+	uint64_t u64;
+	struct cvmx_sli_pkt_ctl_s {
+		uint64_t reserved_5_63:59;
+		uint64_t ring_en:1;
+		uint64_t pkt_bp:4;
+	} s;
+	struct cvmx_sli_pkt_ctl_s cn61xx;
+	struct cvmx_sli_pkt_ctl_s cn63xx;
+	struct cvmx_sli_pkt_ctl_s cn63xxp1;
+	struct cvmx_sli_pkt_ctl_s cn66xx;
+	struct cvmx_sli_pkt_ctl_s cn68xx;
+	struct cvmx_sli_pkt_ctl_s cn68xxp1;
+};
+
+union cvmx_sli_pkt_data_out_es {
+	uint64_t u64;
+	struct cvmx_sli_pkt_data_out_es_s {
+		uint64_t es:64;
+	} s;
+	struct cvmx_sli_pkt_data_out_es_s cn61xx;
+	struct cvmx_sli_pkt_data_out_es_s cn63xx;
+	struct cvmx_sli_pkt_data_out_es_s cn63xxp1;
+	struct cvmx_sli_pkt_data_out_es_s cn66xx;
+	struct cvmx_sli_pkt_data_out_es_s cn68xx;
+	struct cvmx_sli_pkt_data_out_es_s cn68xxp1;
+};
+
+union cvmx_sli_pkt_data_out_ns {
+	uint64_t u64;
+	struct cvmx_sli_pkt_data_out_ns_s {
+		uint64_t reserved_32_63:32;
+		uint64_t nsr:32;
+	} s;
+	struct cvmx_sli_pkt_data_out_ns_s cn61xx;
+	struct cvmx_sli_pkt_data_out_ns_s cn63xx;
+	struct cvmx_sli_pkt_data_out_ns_s cn63xxp1;
+	struct cvmx_sli_pkt_data_out_ns_s cn66xx;
+	struct cvmx_sli_pkt_data_out_ns_s cn68xx;
+	struct cvmx_sli_pkt_data_out_ns_s cn68xxp1;
+};
+
+union cvmx_sli_pkt_data_out_ror {
+	uint64_t u64;
+	struct cvmx_sli_pkt_data_out_ror_s {
+		uint64_t reserved_32_63:32;
+		uint64_t ror:32;
+	} s;
+	struct cvmx_sli_pkt_data_out_ror_s cn61xx;
+	struct cvmx_sli_pkt_data_out_ror_s cn63xx;
+	struct cvmx_sli_pkt_data_out_ror_s cn63xxp1;
+	struct cvmx_sli_pkt_data_out_ror_s cn66xx;
+	struct cvmx_sli_pkt_data_out_ror_s cn68xx;
+	struct cvmx_sli_pkt_data_out_ror_s cn68xxp1;
+};
+
+union cvmx_sli_pkt_dpaddr {
+	uint64_t u64;
+	struct cvmx_sli_pkt_dpaddr_s {
+		uint64_t reserved_32_63:32;
+		uint64_t dptr:32;
+	} s;
+	struct cvmx_sli_pkt_dpaddr_s cn61xx;
+	struct cvmx_sli_pkt_dpaddr_s cn63xx;
+	struct cvmx_sli_pkt_dpaddr_s cn63xxp1;
+	struct cvmx_sli_pkt_dpaddr_s cn66xx;
+	struct cvmx_sli_pkt_dpaddr_s cn68xx;
+	struct cvmx_sli_pkt_dpaddr_s cn68xxp1;
+};
+
+union cvmx_sli_pkt_in_bp {
+	uint64_t u64;
+	struct cvmx_sli_pkt_in_bp_s {
+		uint64_t reserved_32_63:32;
+		uint64_t bp:32;
+	} s;
+	struct cvmx_sli_pkt_in_bp_s cn61xx;
+	struct cvmx_sli_pkt_in_bp_s cn63xx;
+	struct cvmx_sli_pkt_in_bp_s cn63xxp1;
+	struct cvmx_sli_pkt_in_bp_s cn66xx;
+};
+
+union cvmx_sli_pkt_in_donex_cnts {
+	uint64_t u64;
+	struct cvmx_sli_pkt_in_donex_cnts_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_sli_pkt_in_donex_cnts_s cn61xx;
+	struct cvmx_sli_pkt_in_donex_cnts_s cn63xx;
+	struct cvmx_sli_pkt_in_donex_cnts_s cn63xxp1;
+	struct cvmx_sli_pkt_in_donex_cnts_s cn66xx;
+	struct cvmx_sli_pkt_in_donex_cnts_s cn68xx;
+	struct cvmx_sli_pkt_in_donex_cnts_s cn68xxp1;
+};
+
+union cvmx_sli_pkt_in_instr_counts {
+	uint64_t u64;
+	struct cvmx_sli_pkt_in_instr_counts_s {
+		uint64_t wr_cnt:32;
+		uint64_t rd_cnt:32;
+	} s;
+	struct cvmx_sli_pkt_in_instr_counts_s cn61xx;
+	struct cvmx_sli_pkt_in_instr_counts_s cn63xx;
+	struct cvmx_sli_pkt_in_instr_counts_s cn63xxp1;
+	struct cvmx_sli_pkt_in_instr_counts_s cn66xx;
+	struct cvmx_sli_pkt_in_instr_counts_s cn68xx;
+	struct cvmx_sli_pkt_in_instr_counts_s cn68xxp1;
+};
+
+union cvmx_sli_pkt_in_pcie_port {
+	uint64_t u64;
+	struct cvmx_sli_pkt_in_pcie_port_s {
+		uint64_t pp:64;
+	} s;
+	struct cvmx_sli_pkt_in_pcie_port_s cn61xx;
+	struct cvmx_sli_pkt_in_pcie_port_s cn63xx;
+	struct cvmx_sli_pkt_in_pcie_port_s cn63xxp1;
+	struct cvmx_sli_pkt_in_pcie_port_s cn66xx;
+	struct cvmx_sli_pkt_in_pcie_port_s cn68xx;
+	struct cvmx_sli_pkt_in_pcie_port_s cn68xxp1;
+};
+
+union cvmx_sli_pkt_input_control {
+	uint64_t u64;
+	struct cvmx_sli_pkt_input_control_s {
+		uint64_t prd_erst:1;
+		uint64_t prd_rds:7;
+		uint64_t gii_erst:1;
+		uint64_t gii_rds:7;
+		uint64_t reserved_41_47:7;
+		uint64_t prc_idle:1;
+		uint64_t reserved_24_39:16;
+		uint64_t pin_rst:1;
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
+	struct cvmx_sli_pkt_input_control_s cn61xx;
+	struct cvmx_sli_pkt_input_control_cn63xx {
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
+	} cn63xx;
+	struct cvmx_sli_pkt_input_control_cn63xx cn63xxp1;
+	struct cvmx_sli_pkt_input_control_s cn66xx;
+	struct cvmx_sli_pkt_input_control_s cn68xx;
+	struct cvmx_sli_pkt_input_control_s cn68xxp1;
+};
+
+union cvmx_sli_pkt_instr_enb {
+	uint64_t u64;
+	struct cvmx_sli_pkt_instr_enb_s {
+		uint64_t reserved_32_63:32;
+		uint64_t enb:32;
+	} s;
+	struct cvmx_sli_pkt_instr_enb_s cn61xx;
+	struct cvmx_sli_pkt_instr_enb_s cn63xx;
+	struct cvmx_sli_pkt_instr_enb_s cn63xxp1;
+	struct cvmx_sli_pkt_instr_enb_s cn66xx;
+	struct cvmx_sli_pkt_instr_enb_s cn68xx;
+	struct cvmx_sli_pkt_instr_enb_s cn68xxp1;
+};
+
+union cvmx_sli_pkt_instr_rd_size {
+	uint64_t u64;
+	struct cvmx_sli_pkt_instr_rd_size_s {
+		uint64_t rdsize:64;
+	} s;
+	struct cvmx_sli_pkt_instr_rd_size_s cn61xx;
+	struct cvmx_sli_pkt_instr_rd_size_s cn63xx;
+	struct cvmx_sli_pkt_instr_rd_size_s cn63xxp1;
+	struct cvmx_sli_pkt_instr_rd_size_s cn66xx;
+	struct cvmx_sli_pkt_instr_rd_size_s cn68xx;
+	struct cvmx_sli_pkt_instr_rd_size_s cn68xxp1;
+};
+
+union cvmx_sli_pkt_instr_size {
+	uint64_t u64;
+	struct cvmx_sli_pkt_instr_size_s {
+		uint64_t reserved_32_63:32;
+		uint64_t is_64b:32;
+	} s;
+	struct cvmx_sli_pkt_instr_size_s cn61xx;
+	struct cvmx_sli_pkt_instr_size_s cn63xx;
+	struct cvmx_sli_pkt_instr_size_s cn63xxp1;
+	struct cvmx_sli_pkt_instr_size_s cn66xx;
+	struct cvmx_sli_pkt_instr_size_s cn68xx;
+	struct cvmx_sli_pkt_instr_size_s cn68xxp1;
+};
+
+union cvmx_sli_pkt_int_levels {
+	uint64_t u64;
+	struct cvmx_sli_pkt_int_levels_s {
+		uint64_t reserved_54_63:10;
+		uint64_t time:22;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_sli_pkt_int_levels_s cn61xx;
+	struct cvmx_sli_pkt_int_levels_s cn63xx;
+	struct cvmx_sli_pkt_int_levels_s cn63xxp1;
+	struct cvmx_sli_pkt_int_levels_s cn66xx;
+	struct cvmx_sli_pkt_int_levels_s cn68xx;
+	struct cvmx_sli_pkt_int_levels_s cn68xxp1;
+};
+
+union cvmx_sli_pkt_iptr {
+	uint64_t u64;
+	struct cvmx_sli_pkt_iptr_s {
+		uint64_t reserved_32_63:32;
+		uint64_t iptr:32;
+	} s;
+	struct cvmx_sli_pkt_iptr_s cn61xx;
+	struct cvmx_sli_pkt_iptr_s cn63xx;
+	struct cvmx_sli_pkt_iptr_s cn63xxp1;
+	struct cvmx_sli_pkt_iptr_s cn66xx;
+	struct cvmx_sli_pkt_iptr_s cn68xx;
+	struct cvmx_sli_pkt_iptr_s cn68xxp1;
+};
+
+union cvmx_sli_pkt_out_bmode {
+	uint64_t u64;
+	struct cvmx_sli_pkt_out_bmode_s {
+		uint64_t reserved_32_63:32;
+		uint64_t bmode:32;
+	} s;
+	struct cvmx_sli_pkt_out_bmode_s cn61xx;
+	struct cvmx_sli_pkt_out_bmode_s cn63xx;
+	struct cvmx_sli_pkt_out_bmode_s cn63xxp1;
+	struct cvmx_sli_pkt_out_bmode_s cn66xx;
+	struct cvmx_sli_pkt_out_bmode_s cn68xx;
+	struct cvmx_sli_pkt_out_bmode_s cn68xxp1;
+};
+
+union cvmx_sli_pkt_out_bp_en {
+	uint64_t u64;
+	struct cvmx_sli_pkt_out_bp_en_s {
+		uint64_t reserved_32_63:32;
+		uint64_t bp_en:32;
+	} s;
+	struct cvmx_sli_pkt_out_bp_en_s cn68xx;
+	struct cvmx_sli_pkt_out_bp_en_s cn68xxp1;
+};
+
+union cvmx_sli_pkt_out_enb {
+	uint64_t u64;
+	struct cvmx_sli_pkt_out_enb_s {
+		uint64_t reserved_32_63:32;
+		uint64_t enb:32;
+	} s;
+	struct cvmx_sli_pkt_out_enb_s cn61xx;
+	struct cvmx_sli_pkt_out_enb_s cn63xx;
+	struct cvmx_sli_pkt_out_enb_s cn63xxp1;
+	struct cvmx_sli_pkt_out_enb_s cn66xx;
+	struct cvmx_sli_pkt_out_enb_s cn68xx;
+	struct cvmx_sli_pkt_out_enb_s cn68xxp1;
+};
+
+union cvmx_sli_pkt_output_wmark {
+	uint64_t u64;
+	struct cvmx_sli_pkt_output_wmark_s {
+		uint64_t reserved_32_63:32;
+		uint64_t wmark:32;
+	} s;
+	struct cvmx_sli_pkt_output_wmark_s cn61xx;
+	struct cvmx_sli_pkt_output_wmark_s cn63xx;
+	struct cvmx_sli_pkt_output_wmark_s cn63xxp1;
+	struct cvmx_sli_pkt_output_wmark_s cn66xx;
+	struct cvmx_sli_pkt_output_wmark_s cn68xx;
+	struct cvmx_sli_pkt_output_wmark_s cn68xxp1;
+};
+
+union cvmx_sli_pkt_pcie_port {
+	uint64_t u64;
+	struct cvmx_sli_pkt_pcie_port_s {
+		uint64_t pp:64;
+	} s;
+	struct cvmx_sli_pkt_pcie_port_s cn61xx;
+	struct cvmx_sli_pkt_pcie_port_s cn63xx;
+	struct cvmx_sli_pkt_pcie_port_s cn63xxp1;
+	struct cvmx_sli_pkt_pcie_port_s cn66xx;
+	struct cvmx_sli_pkt_pcie_port_s cn68xx;
+	struct cvmx_sli_pkt_pcie_port_s cn68xxp1;
+};
+
+union cvmx_sli_pkt_port_in_rst {
+	uint64_t u64;
+	struct cvmx_sli_pkt_port_in_rst_s {
+		uint64_t in_rst:32;
+		uint64_t out_rst:32;
+	} s;
+	struct cvmx_sli_pkt_port_in_rst_s cn61xx;
+	struct cvmx_sli_pkt_port_in_rst_s cn63xx;
+	struct cvmx_sli_pkt_port_in_rst_s cn63xxp1;
+	struct cvmx_sli_pkt_port_in_rst_s cn66xx;
+	struct cvmx_sli_pkt_port_in_rst_s cn68xx;
+	struct cvmx_sli_pkt_port_in_rst_s cn68xxp1;
+};
+
+union cvmx_sli_pkt_slist_es {
+	uint64_t u64;
+	struct cvmx_sli_pkt_slist_es_s {
+		uint64_t es:64;
+	} s;
+	struct cvmx_sli_pkt_slist_es_s cn61xx;
+	struct cvmx_sli_pkt_slist_es_s cn63xx;
+	struct cvmx_sli_pkt_slist_es_s cn63xxp1;
+	struct cvmx_sli_pkt_slist_es_s cn66xx;
+	struct cvmx_sli_pkt_slist_es_s cn68xx;
+	struct cvmx_sli_pkt_slist_es_s cn68xxp1;
+};
+
+union cvmx_sli_pkt_slist_ns {
+	uint64_t u64;
+	struct cvmx_sli_pkt_slist_ns_s {
+		uint64_t reserved_32_63:32;
+		uint64_t nsr:32;
+	} s;
+	struct cvmx_sli_pkt_slist_ns_s cn61xx;
+	struct cvmx_sli_pkt_slist_ns_s cn63xx;
+	struct cvmx_sli_pkt_slist_ns_s cn63xxp1;
+	struct cvmx_sli_pkt_slist_ns_s cn66xx;
+	struct cvmx_sli_pkt_slist_ns_s cn68xx;
+	struct cvmx_sli_pkt_slist_ns_s cn68xxp1;
+};
+
+union cvmx_sli_pkt_slist_ror {
+	uint64_t u64;
+	struct cvmx_sli_pkt_slist_ror_s {
+		uint64_t reserved_32_63:32;
+		uint64_t ror:32;
+	} s;
+	struct cvmx_sli_pkt_slist_ror_s cn61xx;
+	struct cvmx_sli_pkt_slist_ror_s cn63xx;
+	struct cvmx_sli_pkt_slist_ror_s cn63xxp1;
+	struct cvmx_sli_pkt_slist_ror_s cn66xx;
+	struct cvmx_sli_pkt_slist_ror_s cn68xx;
+	struct cvmx_sli_pkt_slist_ror_s cn68xxp1;
+};
+
+union cvmx_sli_pkt_time_int {
+	uint64_t u64;
+	struct cvmx_sli_pkt_time_int_s {
+		uint64_t reserved_32_63:32;
+		uint64_t port:32;
+	} s;
+	struct cvmx_sli_pkt_time_int_s cn61xx;
+	struct cvmx_sli_pkt_time_int_s cn63xx;
+	struct cvmx_sli_pkt_time_int_s cn63xxp1;
+	struct cvmx_sli_pkt_time_int_s cn66xx;
+	struct cvmx_sli_pkt_time_int_s cn68xx;
+	struct cvmx_sli_pkt_time_int_s cn68xxp1;
+};
+
+union cvmx_sli_pkt_time_int_enb {
+	uint64_t u64;
+	struct cvmx_sli_pkt_time_int_enb_s {
+		uint64_t reserved_32_63:32;
+		uint64_t port:32;
+	} s;
+	struct cvmx_sli_pkt_time_int_enb_s cn61xx;
+	struct cvmx_sli_pkt_time_int_enb_s cn63xx;
+	struct cvmx_sli_pkt_time_int_enb_s cn63xxp1;
+	struct cvmx_sli_pkt_time_int_enb_s cn66xx;
+	struct cvmx_sli_pkt_time_int_enb_s cn68xx;
+	struct cvmx_sli_pkt_time_int_enb_s cn68xxp1;
+};
+
+union cvmx_sli_portx_pkind {
+	uint64_t u64;
+	struct cvmx_sli_portx_pkind_s {
+		uint64_t reserved_25_63:39;
+		uint64_t rpk_enb:1;
+		uint64_t reserved_22_23:2;
+		uint64_t pkindr:6;
+		uint64_t reserved_14_15:2;
+		uint64_t bpkind:6;
+		uint64_t reserved_6_7:2;
+		uint64_t pkind:6;
+	} s;
+	struct cvmx_sli_portx_pkind_s cn68xx;
+	struct cvmx_sli_portx_pkind_cn68xxp1 {
+		uint64_t reserved_14_63:50;
+		uint64_t bpkind:6;
+		uint64_t reserved_6_7:2;
+		uint64_t pkind:6;
+	} cn68xxp1;
+};
+
+union cvmx_sli_s2m_portx_ctl {
+	uint64_t u64;
+	struct cvmx_sli_s2m_portx_ctl_s {
+		uint64_t reserved_5_63:59;
+		uint64_t wind_d:1;
+		uint64_t bar0_d:1;
+		uint64_t mrrs:3;
+	} s;
+	struct cvmx_sli_s2m_portx_ctl_s cn61xx;
+	struct cvmx_sli_s2m_portx_ctl_s cn63xx;
+	struct cvmx_sli_s2m_portx_ctl_s cn63xxp1;
+	struct cvmx_sli_s2m_portx_ctl_s cn66xx;
+	struct cvmx_sli_s2m_portx_ctl_s cn68xx;
+	struct cvmx_sli_s2m_portx_ctl_s cn68xxp1;
+};
+
+union cvmx_sli_scratch_1 {
+	uint64_t u64;
+	struct cvmx_sli_scratch_1_s {
+		uint64_t data:64;
+	} s;
+	struct cvmx_sli_scratch_1_s cn61xx;
+	struct cvmx_sli_scratch_1_s cn63xx;
+	struct cvmx_sli_scratch_1_s cn63xxp1;
+	struct cvmx_sli_scratch_1_s cn66xx;
+	struct cvmx_sli_scratch_1_s cn68xx;
+	struct cvmx_sli_scratch_1_s cn68xxp1;
+};
+
+union cvmx_sli_scratch_2 {
+	uint64_t u64;
+	struct cvmx_sli_scratch_2_s {
+		uint64_t data:64;
+	} s;
+	struct cvmx_sli_scratch_2_s cn61xx;
+	struct cvmx_sli_scratch_2_s cn63xx;
+	struct cvmx_sli_scratch_2_s cn63xxp1;
+	struct cvmx_sli_scratch_2_s cn66xx;
+	struct cvmx_sli_scratch_2_s cn68xx;
+	struct cvmx_sli_scratch_2_s cn68xxp1;
+};
+
+union cvmx_sli_state1 {
+	uint64_t u64;
+	struct cvmx_sli_state1_s {
+		uint64_t cpl1:12;
+		uint64_t cpl0:12;
+		uint64_t arb:1;
+		uint64_t csr:39;
+	} s;
+	struct cvmx_sli_state1_s cn61xx;
+	struct cvmx_sli_state1_s cn63xx;
+	struct cvmx_sli_state1_s cn63xxp1;
+	struct cvmx_sli_state1_s cn66xx;
+	struct cvmx_sli_state1_s cn68xx;
+	struct cvmx_sli_state1_s cn68xxp1;
+};
+
+union cvmx_sli_state2 {
+	uint64_t u64;
+	struct cvmx_sli_state2_s {
+		uint64_t reserved_56_63:8;
+		uint64_t nnp1:8;
+		uint64_t reserved_47_47:1;
+		uint64_t rac:1;
+		uint64_t csm1:15;
+		uint64_t csm0:15;
+		uint64_t nnp0:8;
+		uint64_t nnd:8;
+	} s;
+	struct cvmx_sli_state2_s cn61xx;
+	struct cvmx_sli_state2_s cn63xx;
+	struct cvmx_sli_state2_s cn63xxp1;
+	struct cvmx_sli_state2_s cn66xx;
+	struct cvmx_sli_state2_s cn68xx;
+	struct cvmx_sli_state2_s cn68xxp1;
+};
+
+union cvmx_sli_state3 {
+	uint64_t u64;
+	struct cvmx_sli_state3_s {
+		uint64_t reserved_56_63:8;
+		uint64_t psm1:15;
+		uint64_t psm0:15;
+		uint64_t nsm1:13;
+		uint64_t nsm0:13;
+	} s;
+	struct cvmx_sli_state3_s cn61xx;
+	struct cvmx_sli_state3_s cn63xx;
+	struct cvmx_sli_state3_s cn63xxp1;
+	struct cvmx_sli_state3_s cn66xx;
+	struct cvmx_sli_state3_s cn68xx;
+	struct cvmx_sli_state3_s cn68xxp1;
+};
+
+union cvmx_sli_tx_pipe {
+	uint64_t u64;
+	struct cvmx_sli_tx_pipe_s {
+		uint64_t reserved_24_63:40;
+		uint64_t nump:8;
+		uint64_t reserved_7_15:9;
+		uint64_t base:7;
+	} s;
+	struct cvmx_sli_tx_pipe_s cn68xx;
+	struct cvmx_sli_tx_pipe_s cn68xxp1;
+};
+
+union cvmx_sli_win_rd_addr {
+	uint64_t u64;
+	struct cvmx_sli_win_rd_addr_s {
+		uint64_t reserved_51_63:13;
+		uint64_t ld_cmd:2;
+		uint64_t iobit:1;
+		uint64_t rd_addr:48;
+	} s;
+	struct cvmx_sli_win_rd_addr_s cn61xx;
+	struct cvmx_sli_win_rd_addr_s cn63xx;
+	struct cvmx_sli_win_rd_addr_s cn63xxp1;
+	struct cvmx_sli_win_rd_addr_s cn66xx;
+	struct cvmx_sli_win_rd_addr_s cn68xx;
+	struct cvmx_sli_win_rd_addr_s cn68xxp1;
+};
+
+union cvmx_sli_win_rd_data {
+	uint64_t u64;
+	struct cvmx_sli_win_rd_data_s {
+		uint64_t rd_data:64;
+	} s;
+	struct cvmx_sli_win_rd_data_s cn61xx;
+	struct cvmx_sli_win_rd_data_s cn63xx;
+	struct cvmx_sli_win_rd_data_s cn63xxp1;
+	struct cvmx_sli_win_rd_data_s cn66xx;
+	struct cvmx_sli_win_rd_data_s cn68xx;
+	struct cvmx_sli_win_rd_data_s cn68xxp1;
+};
+
+union cvmx_sli_win_wr_addr {
+	uint64_t u64;
+	struct cvmx_sli_win_wr_addr_s {
+		uint64_t reserved_49_63:15;
+		uint64_t iobit:1;
+		uint64_t wr_addr:45;
+		uint64_t reserved_0_2:3;
+	} s;
+	struct cvmx_sli_win_wr_addr_s cn61xx;
+	struct cvmx_sli_win_wr_addr_s cn63xx;
+	struct cvmx_sli_win_wr_addr_s cn63xxp1;
+	struct cvmx_sli_win_wr_addr_s cn66xx;
+	struct cvmx_sli_win_wr_addr_s cn68xx;
+	struct cvmx_sli_win_wr_addr_s cn68xxp1;
+};
+
+union cvmx_sli_win_wr_data {
+	uint64_t u64;
+	struct cvmx_sli_win_wr_data_s {
+		uint64_t wr_data:64;
+	} s;
+	struct cvmx_sli_win_wr_data_s cn61xx;
+	struct cvmx_sli_win_wr_data_s cn63xx;
+	struct cvmx_sli_win_wr_data_s cn63xxp1;
+	struct cvmx_sli_win_wr_data_s cn66xx;
+	struct cvmx_sli_win_wr_data_s cn68xx;
+	struct cvmx_sli_win_wr_data_s cn68xxp1;
+};
+
+union cvmx_sli_win_wr_mask {
+	uint64_t u64;
+	struct cvmx_sli_win_wr_mask_s {
+		uint64_t reserved_8_63:56;
+		uint64_t wr_mask:8;
+	} s;
+	struct cvmx_sli_win_wr_mask_s cn61xx;
+	struct cvmx_sli_win_wr_mask_s cn63xx;
+	struct cvmx_sli_win_wr_mask_s cn63xxp1;
+	struct cvmx_sli_win_wr_mask_s cn66xx;
+	struct cvmx_sli_win_wr_mask_s cn68xx;
+	struct cvmx_sli_win_wr_mask_s cn68xxp1;
+};
+
+union cvmx_sli_window_ctl {
+	uint64_t u64;
+	struct cvmx_sli_window_ctl_s {
+		uint64_t reserved_32_63:32;
+		uint64_t time:32;
+	} s;
+	struct cvmx_sli_window_ctl_s cn61xx;
+	struct cvmx_sli_window_ctl_s cn63xx;
+	struct cvmx_sli_window_ctl_s cn63xxp1;
+	struct cvmx_sli_window_ctl_s cn66xx;
+	struct cvmx_sli_window_ctl_s cn68xx;
+	struct cvmx_sli_window_ctl_s cn68xxp1;
+};
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-sriox-defs.h b/arch/mips/include/asm/octeon/cvmx-sriox-defs.h
new file mode 100644
index 0000000..7be7e9e
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-sriox-defs.h
@@ -0,0 +1,1036 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2011 Cavium Networks
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
+#ifndef __CVMX_SRIOX_DEFS_H__
+#define __CVMX_SRIOX_DEFS_H__
+
+#define CVMX_SRIOX_ACC_CTRL(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000148ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_ASMBLY_ID(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000200ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_ASMBLY_INFO(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000208ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_BELL_RESP_CTRL(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000310ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_BIST_STATUS(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000108ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_IMSG_CTRL(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000508ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_IMSG_INST_HDRX(offset, block_id) (CVMX_ADD_IO_SEG(0x00011800C8000510ull) + (((offset) & 1) + ((block_id) & 3) * 0x200000ull) * 8)
+#define CVMX_SRIOX_IMSG_QOS_GRPX(offset, block_id) (CVMX_ADD_IO_SEG(0x00011800C8000600ull) + (((offset) & 31) + ((block_id) & 3) * 0x200000ull) * 8)
+#define CVMX_SRIOX_IMSG_STATUSX(offset, block_id) (CVMX_ADD_IO_SEG(0x00011800C8000700ull) + (((offset) & 31) + ((block_id) & 3) * 0x200000ull) * 8)
+#define CVMX_SRIOX_IMSG_VPORT_THR(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000500ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_IMSG_VPORT_THR2(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000528ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_INT2_ENABLE(block_id) (CVMX_ADD_IO_SEG(0x00011800C80003E0ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_INT2_REG(block_id) (CVMX_ADD_IO_SEG(0x00011800C80003E8ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_INT_ENABLE(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000110ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_INT_INFO0(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000120ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_INT_INFO1(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000128ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_INT_INFO2(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000130ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_INT_INFO3(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000138ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_INT_REG(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000118ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_IP_FEATURE(block_id) (CVMX_ADD_IO_SEG(0x00011800C80003F8ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_MAC_BUFFERS(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000390ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_MAINT_OP(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000158ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_MAINT_RD_DATA(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000160ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_MCE_TX_CTL(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000240ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_MEM_OP_CTRL(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000168ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_OMSG_CTRLX(offset, block_id) (CVMX_ADD_IO_SEG(0x00011800C8000488ull) + (((offset) & 1) + ((block_id) & 3) * 0x40000ull) * 64)
+#define CVMX_SRIOX_OMSG_DONE_COUNTSX(offset, block_id) (CVMX_ADD_IO_SEG(0x00011800C80004B0ull) + (((offset) & 1) + ((block_id) & 3) * 0x40000ull) * 64)
+#define CVMX_SRIOX_OMSG_FMP_MRX(offset, block_id) (CVMX_ADD_IO_SEG(0x00011800C8000498ull) + (((offset) & 1) + ((block_id) & 3) * 0x40000ull) * 64)
+#define CVMX_SRIOX_OMSG_NMP_MRX(offset, block_id) (CVMX_ADD_IO_SEG(0x00011800C80004A0ull) + (((offset) & 1) + ((block_id) & 3) * 0x40000ull) * 64)
+#define CVMX_SRIOX_OMSG_PORTX(offset, block_id) (CVMX_ADD_IO_SEG(0x00011800C8000480ull) + (((offset) & 1) + ((block_id) & 3) * 0x40000ull) * 64)
+#define CVMX_SRIOX_OMSG_SILO_THR(block_id) (CVMX_ADD_IO_SEG(0x00011800C80004F8ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_OMSG_SP_MRX(offset, block_id) (CVMX_ADD_IO_SEG(0x00011800C8000490ull) + (((offset) & 1) + ((block_id) & 3) * 0x40000ull) * 64)
+#define CVMX_SRIOX_PRIOX_IN_USE(offset, block_id) (CVMX_ADD_IO_SEG(0x00011800C80003C0ull) + (((offset) & 3) + ((block_id) & 3) * 0x200000ull) * 8)
+#define CVMX_SRIOX_RX_BELL(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000308ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_RX_BELL_SEQ(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000300ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_RX_STATUS(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000380ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_S2M_TYPEX(offset, block_id) (CVMX_ADD_IO_SEG(0x00011800C8000180ull) + (((offset) & 15) + ((block_id) & 3) * 0x200000ull) * 8)
+#define CVMX_SRIOX_SEQ(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000278ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_STATUS_REG(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000100ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_TAG_CTRL(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000178ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_TLP_CREDITS(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000150ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_TX_BELL(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000280ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_TX_BELL_INFO(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000288ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_TX_CTRL(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000170ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_TX_EMPHASIS(block_id) (CVMX_ADD_IO_SEG(0x00011800C80003F0ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_TX_STATUS(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000388ull) + ((block_id) & 3) * 0x1000000ull)
+#define CVMX_SRIOX_WR_DONE_COUNTS(block_id) (CVMX_ADD_IO_SEG(0x00011800C8000340ull) + ((block_id) & 3) * 0x1000000ull)
+
+union cvmx_sriox_acc_ctrl {
+	uint64_t u64;
+	struct cvmx_sriox_acc_ctrl_s {
+		uint64_t reserved_7_63:57;
+		uint64_t deny_adr2:1;
+		uint64_t deny_adr1:1;
+		uint64_t deny_adr0:1;
+		uint64_t reserved_3_3:1;
+		uint64_t deny_bar2:1;
+		uint64_t deny_bar1:1;
+		uint64_t deny_bar0:1;
+	} s;
+	struct cvmx_sriox_acc_ctrl_cn63xx {
+		uint64_t reserved_3_63:61;
+		uint64_t deny_bar2:1;
+		uint64_t deny_bar1:1;
+		uint64_t deny_bar0:1;
+	} cn63xx;
+	struct cvmx_sriox_acc_ctrl_cn63xx cn63xxp1;
+	struct cvmx_sriox_acc_ctrl_s cn66xx;
+};
+
+union cvmx_sriox_asmbly_id {
+	uint64_t u64;
+	struct cvmx_sriox_asmbly_id_s {
+		uint64_t reserved_32_63:32;
+		uint64_t assy_id:16;
+		uint64_t assy_ven:16;
+	} s;
+	struct cvmx_sriox_asmbly_id_s cn63xx;
+	struct cvmx_sriox_asmbly_id_s cn63xxp1;
+	struct cvmx_sriox_asmbly_id_s cn66xx;
+};
+
+union cvmx_sriox_asmbly_info {
+	uint64_t u64;
+	struct cvmx_sriox_asmbly_info_s {
+		uint64_t reserved_32_63:32;
+		uint64_t assy_rev:16;
+		uint64_t reserved_0_15:16;
+	} s;
+	struct cvmx_sriox_asmbly_info_s cn63xx;
+	struct cvmx_sriox_asmbly_info_s cn63xxp1;
+	struct cvmx_sriox_asmbly_info_s cn66xx;
+};
+
+union cvmx_sriox_bell_resp_ctrl {
+	uint64_t u64;
+	struct cvmx_sriox_bell_resp_ctrl_s {
+		uint64_t reserved_6_63:58;
+		uint64_t rp1_sid:1;
+		uint64_t rp0_sid:2;
+		uint64_t rp1_pid:1;
+		uint64_t rp0_pid:2;
+	} s;
+	struct cvmx_sriox_bell_resp_ctrl_s cn63xx;
+	struct cvmx_sriox_bell_resp_ctrl_s cn63xxp1;
+	struct cvmx_sriox_bell_resp_ctrl_s cn66xx;
+};
+
+union cvmx_sriox_bist_status {
+	uint64_t u64;
+	struct cvmx_sriox_bist_status_s {
+		uint64_t reserved_45_63:19;
+		uint64_t lram:1;
+		uint64_t mram:2;
+		uint64_t cram:2;
+		uint64_t bell:2;
+		uint64_t otag:2;
+		uint64_t itag:1;
+		uint64_t ofree:1;
+		uint64_t rtn:2;
+		uint64_t obulk:4;
+		uint64_t optrs:4;
+		uint64_t oarb2:2;
+		uint64_t rxbuf2:2;
+		uint64_t oarb:2;
+		uint64_t ispf:1;
+		uint64_t ospf:1;
+		uint64_t txbuf:2;
+		uint64_t rxbuf:2;
+		uint64_t imsg:5;
+		uint64_t omsg:7;
+	} s;
+	struct cvmx_sriox_bist_status_cn63xx {
+		uint64_t reserved_44_63:20;
+		uint64_t mram:2;
+		uint64_t cram:2;
+		uint64_t bell:2;
+		uint64_t otag:2;
+		uint64_t itag:1;
+		uint64_t ofree:1;
+		uint64_t rtn:2;
+		uint64_t obulk:4;
+		uint64_t optrs:4;
+		uint64_t oarb2:2;
+		uint64_t rxbuf2:2;
+		uint64_t oarb:2;
+		uint64_t ispf:1;
+		uint64_t ospf:1;
+		uint64_t txbuf:2;
+		uint64_t rxbuf:2;
+		uint64_t imsg:5;
+		uint64_t omsg:7;
+	} cn63xx;
+	struct cvmx_sriox_bist_status_cn63xxp1 {
+		uint64_t reserved_44_63:20;
+		uint64_t mram:2;
+		uint64_t cram:2;
+		uint64_t bell:2;
+		uint64_t otag:2;
+		uint64_t itag:1;
+		uint64_t ofree:1;
+		uint64_t rtn:2;
+		uint64_t obulk:4;
+		uint64_t optrs:4;
+		uint64_t reserved_20_23:4;
+		uint64_t oarb:2;
+		uint64_t ispf:1;
+		uint64_t ospf:1;
+		uint64_t txbuf:2;
+		uint64_t rxbuf:2;
+		uint64_t imsg:5;
+		uint64_t omsg:7;
+	} cn63xxp1;
+	struct cvmx_sriox_bist_status_s cn66xx;
+};
+
+union cvmx_sriox_imsg_ctrl {
+	uint64_t u64;
+	struct cvmx_sriox_imsg_ctrl_s {
+		uint64_t reserved_32_63:32;
+		uint64_t to_mode:1;
+		uint64_t reserved_30_30:1;
+		uint64_t rsp_thr:6;
+		uint64_t reserved_22_23:2;
+		uint64_t rp1_sid:1;
+		uint64_t rp0_sid:2;
+		uint64_t rp1_pid:1;
+		uint64_t rp0_pid:2;
+		uint64_t reserved_15_15:1;
+		uint64_t prt_sel:3;
+		uint64_t lttr:4;
+		uint64_t prio:4;
+		uint64_t mbox:4;
+	} s;
+	struct cvmx_sriox_imsg_ctrl_s cn63xx;
+	struct cvmx_sriox_imsg_ctrl_s cn63xxp1;
+	struct cvmx_sriox_imsg_ctrl_s cn66xx;
+};
+
+union cvmx_sriox_imsg_inst_hdrx {
+	uint64_t u64;
+	struct cvmx_sriox_imsg_inst_hdrx_s {
+		uint64_t r:1;
+		uint64_t reserved_58_62:5;
+		uint64_t pm:2;
+		uint64_t reserved_55_55:1;
+		uint64_t sl:7;
+		uint64_t reserved_46_47:2;
+		uint64_t nqos:1;
+		uint64_t ngrp:1;
+		uint64_t ntt:1;
+		uint64_t ntag:1;
+		uint64_t reserved_35_41:7;
+		uint64_t rs:1;
+		uint64_t tt:2;
+		uint64_t tag:32;
+	} s;
+	struct cvmx_sriox_imsg_inst_hdrx_s cn63xx;
+	struct cvmx_sriox_imsg_inst_hdrx_s cn63xxp1;
+	struct cvmx_sriox_imsg_inst_hdrx_s cn66xx;
+};
+
+union cvmx_sriox_imsg_qos_grpx {
+	uint64_t u64;
+	struct cvmx_sriox_imsg_qos_grpx_s {
+		uint64_t reserved_63_63:1;
+		uint64_t qos7:3;
+		uint64_t grp7:4;
+		uint64_t reserved_55_55:1;
+		uint64_t qos6:3;
+		uint64_t grp6:4;
+		uint64_t reserved_47_47:1;
+		uint64_t qos5:3;
+		uint64_t grp5:4;
+		uint64_t reserved_39_39:1;
+		uint64_t qos4:3;
+		uint64_t grp4:4;
+		uint64_t reserved_31_31:1;
+		uint64_t qos3:3;
+		uint64_t grp3:4;
+		uint64_t reserved_23_23:1;
+		uint64_t qos2:3;
+		uint64_t grp2:4;
+		uint64_t reserved_15_15:1;
+		uint64_t qos1:3;
+		uint64_t grp1:4;
+		uint64_t reserved_7_7:1;
+		uint64_t qos0:3;
+		uint64_t grp0:4;
+	} s;
+	struct cvmx_sriox_imsg_qos_grpx_s cn63xx;
+	struct cvmx_sriox_imsg_qos_grpx_s cn63xxp1;
+	struct cvmx_sriox_imsg_qos_grpx_s cn66xx;
+};
+
+union cvmx_sriox_imsg_statusx {
+	uint64_t u64;
+	struct cvmx_sriox_imsg_statusx_s {
+		uint64_t val1:1;
+		uint64_t err1:1;
+		uint64_t toe1:1;
+		uint64_t toc1:1;
+		uint64_t prt1:1;
+		uint64_t reserved_58_58:1;
+		uint64_t tt1:1;
+		uint64_t dis1:1;
+		uint64_t seg1:4;
+		uint64_t mbox1:2;
+		uint64_t lttr1:2;
+		uint64_t sid1:16;
+		uint64_t val0:1;
+		uint64_t err0:1;
+		uint64_t toe0:1;
+		uint64_t toc0:1;
+		uint64_t prt0:1;
+		uint64_t reserved_26_26:1;
+		uint64_t tt0:1;
+		uint64_t dis0:1;
+		uint64_t seg0:4;
+		uint64_t mbox0:2;
+		uint64_t lttr0:2;
+		uint64_t sid0:16;
+	} s;
+	struct cvmx_sriox_imsg_statusx_s cn63xx;
+	struct cvmx_sriox_imsg_statusx_s cn63xxp1;
+	struct cvmx_sriox_imsg_statusx_s cn66xx;
+};
+
+union cvmx_sriox_imsg_vport_thr {
+	uint64_t u64;
+	struct cvmx_sriox_imsg_vport_thr_s {
+		uint64_t reserved_54_63:10;
+		uint64_t max_tot:6;
+		uint64_t reserved_46_47:2;
+		uint64_t max_s1:6;
+		uint64_t reserved_38_39:2;
+		uint64_t max_s0:6;
+		uint64_t sp_vport:1;
+		uint64_t reserved_20_30:11;
+		uint64_t buf_thr:4;
+		uint64_t reserved_14_15:2;
+		uint64_t max_p1:6;
+		uint64_t reserved_6_7:2;
+		uint64_t max_p0:6;
+	} s;
+	struct cvmx_sriox_imsg_vport_thr_s cn63xx;
+	struct cvmx_sriox_imsg_vport_thr_s cn63xxp1;
+	struct cvmx_sriox_imsg_vport_thr_s cn66xx;
+};
+
+union cvmx_sriox_imsg_vport_thr2 {
+	uint64_t u64;
+	struct cvmx_sriox_imsg_vport_thr2_s {
+		uint64_t reserved_46_63:18;
+		uint64_t max_s3:6;
+		uint64_t reserved_38_39:2;
+		uint64_t max_s2:6;
+		uint64_t reserved_0_31:32;
+	} s;
+	struct cvmx_sriox_imsg_vport_thr2_s cn66xx;
+};
+
+union cvmx_sriox_int2_enable {
+	uint64_t u64;
+	struct cvmx_sriox_int2_enable_s {
+		uint64_t reserved_1_63:63;
+		uint64_t pko_rst:1;
+	} s;
+	struct cvmx_sriox_int2_enable_s cn63xx;
+	struct cvmx_sriox_int2_enable_s cn66xx;
+};
+
+union cvmx_sriox_int2_reg {
+	uint64_t u64;
+	struct cvmx_sriox_int2_reg_s {
+		uint64_t reserved_32_63:32;
+		uint64_t int_sum:1;
+		uint64_t reserved_1_30:30;
+		uint64_t pko_rst:1;
+	} s;
+	struct cvmx_sriox_int2_reg_s cn63xx;
+	struct cvmx_sriox_int2_reg_s cn66xx;
+};
+
+union cvmx_sriox_int_enable {
+	uint64_t u64;
+	struct cvmx_sriox_int_enable_s {
+		uint64_t reserved_27_63:37;
+		uint64_t zero_pkt:1;
+		uint64_t ttl_tout:1;
+		uint64_t fail:1;
+		uint64_t degrade:1;
+		uint64_t mac_buf:1;
+		uint64_t f_error:1;
+		uint64_t rtry_err:1;
+		uint64_t pko_err:1;
+		uint64_t omsg_err:1;
+		uint64_t omsg1:1;
+		uint64_t omsg0:1;
+		uint64_t link_up:1;
+		uint64_t link_dwn:1;
+		uint64_t phy_erb:1;
+		uint64_t log_erb:1;
+		uint64_t soft_rx:1;
+		uint64_t soft_tx:1;
+		uint64_t mce_rx:1;
+		uint64_t mce_tx:1;
+		uint64_t wr_done:1;
+		uint64_t sli_err:1;
+		uint64_t deny_wr:1;
+		uint64_t bar_err:1;
+		uint64_t maint_op:1;
+		uint64_t rxbell:1;
+		uint64_t bell_err:1;
+		uint64_t txbell:1;
+	} s;
+	struct cvmx_sriox_int_enable_s cn63xx;
+	struct cvmx_sriox_int_enable_cn63xxp1 {
+		uint64_t reserved_22_63:42;
+		uint64_t f_error:1;
+		uint64_t rtry_err:1;
+		uint64_t pko_err:1;
+		uint64_t omsg_err:1;
+		uint64_t omsg1:1;
+		uint64_t omsg0:1;
+		uint64_t link_up:1;
+		uint64_t link_dwn:1;
+		uint64_t phy_erb:1;
+		uint64_t log_erb:1;
+		uint64_t soft_rx:1;
+		uint64_t soft_tx:1;
+		uint64_t mce_rx:1;
+		uint64_t mce_tx:1;
+		uint64_t wr_done:1;
+		uint64_t sli_err:1;
+		uint64_t deny_wr:1;
+		uint64_t bar_err:1;
+		uint64_t maint_op:1;
+		uint64_t rxbell:1;
+		uint64_t bell_err:1;
+		uint64_t txbell:1;
+	} cn63xxp1;
+	struct cvmx_sriox_int_enable_s cn66xx;
+};
+
+union cvmx_sriox_int_info0 {
+	uint64_t u64;
+	struct cvmx_sriox_int_info0_s {
+		uint64_t cmd:4;
+		uint64_t type:4;
+		uint64_t tag:8;
+		uint64_t reserved_42_47:6;
+		uint64_t length:10;
+		uint64_t status:3;
+		uint64_t reserved_16_28:13;
+		uint64_t be0:8;
+		uint64_t be1:8;
+	} s;
+	struct cvmx_sriox_int_info0_s cn63xx;
+	struct cvmx_sriox_int_info0_s cn63xxp1;
+	struct cvmx_sriox_int_info0_s cn66xx;
+};
+
+union cvmx_sriox_int_info1 {
+	uint64_t u64;
+	struct cvmx_sriox_int_info1_s {
+		uint64_t info1:64;
+	} s;
+	struct cvmx_sriox_int_info1_s cn63xx;
+	struct cvmx_sriox_int_info1_s cn63xxp1;
+	struct cvmx_sriox_int_info1_s cn66xx;
+};
+
+union cvmx_sriox_int_info2 {
+	uint64_t u64;
+	struct cvmx_sriox_int_info2_s {
+		uint64_t prio:2;
+		uint64_t tt:1;
+		uint64_t sis:1;
+		uint64_t ssize:4;
+		uint64_t did:16;
+		uint64_t xmbox:4;
+		uint64_t mbox:2;
+		uint64_t letter:2;
+		uint64_t rsrvd:30;
+		uint64_t lns:1;
+		uint64_t intr:1;
+	} s;
+	struct cvmx_sriox_int_info2_s cn63xx;
+	struct cvmx_sriox_int_info2_s cn63xxp1;
+	struct cvmx_sriox_int_info2_s cn66xx;
+};
+
+union cvmx_sriox_int_info3 {
+	uint64_t u64;
+	struct cvmx_sriox_int_info3_s {
+		uint64_t prio:2;
+		uint64_t tt:2;
+		uint64_t type:4;
+		uint64_t other:48;
+		uint64_t reserved_0_7:8;
+	} s;
+	struct cvmx_sriox_int_info3_s cn63xx;
+	struct cvmx_sriox_int_info3_s cn63xxp1;
+	struct cvmx_sriox_int_info3_s cn66xx;
+};
+
+union cvmx_sriox_int_reg {
+	uint64_t u64;
+	struct cvmx_sriox_int_reg_s {
+		uint64_t reserved_32_63:32;
+		uint64_t int2_sum:1;
+		uint64_t reserved_27_30:4;
+		uint64_t zero_pkt:1;
+		uint64_t ttl_tout:1;
+		uint64_t fail:1;
+		uint64_t degrad:1;
+		uint64_t mac_buf:1;
+		uint64_t f_error:1;
+		uint64_t rtry_err:1;
+		uint64_t pko_err:1;
+		uint64_t omsg_err:1;
+		uint64_t omsg1:1;
+		uint64_t omsg0:1;
+		uint64_t link_up:1;
+		uint64_t link_dwn:1;
+		uint64_t phy_erb:1;
+		uint64_t log_erb:1;
+		uint64_t soft_rx:1;
+		uint64_t soft_tx:1;
+		uint64_t mce_rx:1;
+		uint64_t mce_tx:1;
+		uint64_t wr_done:1;
+		uint64_t sli_err:1;
+		uint64_t deny_wr:1;
+		uint64_t bar_err:1;
+		uint64_t maint_op:1;
+		uint64_t rxbell:1;
+		uint64_t bell_err:1;
+		uint64_t txbell:1;
+	} s;
+	struct cvmx_sriox_int_reg_s cn63xx;
+	struct cvmx_sriox_int_reg_cn63xxp1 {
+		uint64_t reserved_22_63:42;
+		uint64_t f_error:1;
+		uint64_t rtry_err:1;
+		uint64_t pko_err:1;
+		uint64_t omsg_err:1;
+		uint64_t omsg1:1;
+		uint64_t omsg0:1;
+		uint64_t link_up:1;
+		uint64_t link_dwn:1;
+		uint64_t phy_erb:1;
+		uint64_t log_erb:1;
+		uint64_t soft_rx:1;
+		uint64_t soft_tx:1;
+		uint64_t mce_rx:1;
+		uint64_t mce_tx:1;
+		uint64_t wr_done:1;
+		uint64_t sli_err:1;
+		uint64_t deny_wr:1;
+		uint64_t bar_err:1;
+		uint64_t maint_op:1;
+		uint64_t rxbell:1;
+		uint64_t bell_err:1;
+		uint64_t txbell:1;
+	} cn63xxp1;
+	struct cvmx_sriox_int_reg_s cn66xx;
+};
+
+union cvmx_sriox_ip_feature {
+	uint64_t u64;
+	struct cvmx_sriox_ip_feature_s {
+		uint64_t ops:32;
+		uint64_t reserved_15_31:17;
+		uint64_t no_vmin:1;
+		uint64_t a66:1;
+		uint64_t a50:1;
+		uint64_t reserved_11_11:1;
+		uint64_t tx_flow:1;
+		uint64_t pt_width:2;
+		uint64_t tx_pol:4;
+		uint64_t rx_pol:4;
+	} s;
+	struct cvmx_sriox_ip_feature_cn63xx {
+		uint64_t ops:32;
+		uint64_t reserved_14_31:18;
+		uint64_t a66:1;
+		uint64_t a50:1;
+		uint64_t reserved_11_11:1;
+		uint64_t tx_flow:1;
+		uint64_t pt_width:2;
+		uint64_t tx_pol:4;
+		uint64_t rx_pol:4;
+	} cn63xx;
+	struct cvmx_sriox_ip_feature_cn63xx cn63xxp1;
+	struct cvmx_sriox_ip_feature_s cn66xx;
+};
+
+union cvmx_sriox_mac_buffers {
+	uint64_t u64;
+	struct cvmx_sriox_mac_buffers_s {
+		uint64_t reserved_56_63:8;
+		uint64_t tx_enb:8;
+		uint64_t reserved_44_47:4;
+		uint64_t tx_inuse:4;
+		uint64_t tx_stat:8;
+		uint64_t reserved_24_31:8;
+		uint64_t rx_enb:8;
+		uint64_t reserved_12_15:4;
+		uint64_t rx_inuse:4;
+		uint64_t rx_stat:8;
+	} s;
+	struct cvmx_sriox_mac_buffers_s cn63xx;
+	struct cvmx_sriox_mac_buffers_s cn66xx;
+};
+
+union cvmx_sriox_maint_op {
+	uint64_t u64;
+	struct cvmx_sriox_maint_op_s {
+		uint64_t wr_data:32;
+		uint64_t reserved_27_31:5;
+		uint64_t fail:1;
+		uint64_t pending:1;
+		uint64_t op:1;
+		uint64_t addr:24;
+	} s;
+	struct cvmx_sriox_maint_op_s cn63xx;
+	struct cvmx_sriox_maint_op_s cn63xxp1;
+	struct cvmx_sriox_maint_op_s cn66xx;
+};
+
+union cvmx_sriox_maint_rd_data {
+	uint64_t u64;
+	struct cvmx_sriox_maint_rd_data_s {
+		uint64_t reserved_33_63:31;
+		uint64_t valid:1;
+		uint64_t rd_data:32;
+	} s;
+	struct cvmx_sriox_maint_rd_data_s cn63xx;
+	struct cvmx_sriox_maint_rd_data_s cn63xxp1;
+	struct cvmx_sriox_maint_rd_data_s cn66xx;
+};
+
+union cvmx_sriox_mce_tx_ctl {
+	uint64_t u64;
+	struct cvmx_sriox_mce_tx_ctl_s {
+		uint64_t reserved_1_63:63;
+		uint64_t mce:1;
+	} s;
+	struct cvmx_sriox_mce_tx_ctl_s cn63xx;
+	struct cvmx_sriox_mce_tx_ctl_s cn63xxp1;
+	struct cvmx_sriox_mce_tx_ctl_s cn66xx;
+};
+
+union cvmx_sriox_mem_op_ctrl {
+	uint64_t u64;
+	struct cvmx_sriox_mem_op_ctrl_s {
+		uint64_t reserved_10_63:54;
+		uint64_t rr_ro:1;
+		uint64_t w_ro:1;
+		uint64_t reserved_6_7:2;
+		uint64_t rp1_sid:1;
+		uint64_t rp0_sid:2;
+		uint64_t rp1_pid:1;
+		uint64_t rp0_pid:2;
+	} s;
+	struct cvmx_sriox_mem_op_ctrl_s cn63xx;
+	struct cvmx_sriox_mem_op_ctrl_s cn63xxp1;
+	struct cvmx_sriox_mem_op_ctrl_s cn66xx;
+};
+
+union cvmx_sriox_omsg_ctrlx {
+	uint64_t u64;
+	struct cvmx_sriox_omsg_ctrlx_s {
+		uint64_t testmode:1;
+		uint64_t reserved_37_62:26;
+		uint64_t silo_max:5;
+		uint64_t rtry_thr:16;
+		uint64_t rtry_en:1;
+		uint64_t reserved_11_14:4;
+		uint64_t idm_tt:1;
+		uint64_t idm_sis:1;
+		uint64_t idm_did:1;
+		uint64_t lttr_sp:4;
+		uint64_t lttr_mp:4;
+	} s;
+	struct cvmx_sriox_omsg_ctrlx_s cn63xx;
+	struct cvmx_sriox_omsg_ctrlx_cn63xxp1 {
+		uint64_t testmode:1;
+		uint64_t reserved_32_62:31;
+		uint64_t rtry_thr:16;
+		uint64_t rtry_en:1;
+		uint64_t reserved_11_14:4;
+		uint64_t idm_tt:1;
+		uint64_t idm_sis:1;
+		uint64_t idm_did:1;
+		uint64_t lttr_sp:4;
+		uint64_t lttr_mp:4;
+	} cn63xxp1;
+	struct cvmx_sriox_omsg_ctrlx_s cn66xx;
+};
+
+union cvmx_sriox_omsg_done_countsx {
+	uint64_t u64;
+	struct cvmx_sriox_omsg_done_countsx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t bad:16;
+		uint64_t good:16;
+	} s;
+	struct cvmx_sriox_omsg_done_countsx_s cn63xx;
+	struct cvmx_sriox_omsg_done_countsx_s cn66xx;
+};
+
+union cvmx_sriox_omsg_fmp_mrx {
+	uint64_t u64;
+	struct cvmx_sriox_omsg_fmp_mrx_s {
+		uint64_t reserved_15_63:49;
+		uint64_t ctlr_sp:1;
+		uint64_t ctlr_fmp:1;
+		uint64_t ctlr_nmp:1;
+		uint64_t id_sp:1;
+		uint64_t id_fmp:1;
+		uint64_t id_nmp:1;
+		uint64_t id_psd:1;
+		uint64_t mbox_sp:1;
+		uint64_t mbox_fmp:1;
+		uint64_t mbox_nmp:1;
+		uint64_t mbox_psd:1;
+		uint64_t all_sp:1;
+		uint64_t all_fmp:1;
+		uint64_t all_nmp:1;
+		uint64_t all_psd:1;
+	} s;
+	struct cvmx_sriox_omsg_fmp_mrx_s cn63xx;
+	struct cvmx_sriox_omsg_fmp_mrx_s cn63xxp1;
+	struct cvmx_sriox_omsg_fmp_mrx_s cn66xx;
+};
+
+union cvmx_sriox_omsg_nmp_mrx {
+	uint64_t u64;
+	struct cvmx_sriox_omsg_nmp_mrx_s {
+		uint64_t reserved_15_63:49;
+		uint64_t ctlr_sp:1;
+		uint64_t ctlr_fmp:1;
+		uint64_t ctlr_nmp:1;
+		uint64_t id_sp:1;
+		uint64_t id_fmp:1;
+		uint64_t id_nmp:1;
+		uint64_t reserved_8_8:1;
+		uint64_t mbox_sp:1;
+		uint64_t mbox_fmp:1;
+		uint64_t mbox_nmp:1;
+		uint64_t reserved_4_4:1;
+		uint64_t all_sp:1;
+		uint64_t all_fmp:1;
+		uint64_t all_nmp:1;
+		uint64_t reserved_0_0:1;
+	} s;
+	struct cvmx_sriox_omsg_nmp_mrx_s cn63xx;
+	struct cvmx_sriox_omsg_nmp_mrx_s cn63xxp1;
+	struct cvmx_sriox_omsg_nmp_mrx_s cn66xx;
+};
+
+union cvmx_sriox_omsg_portx {
+	uint64_t u64;
+	struct cvmx_sriox_omsg_portx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t enable:1;
+		uint64_t reserved_3_30:28;
+		uint64_t port:3;
+	} s;
+	struct cvmx_sriox_omsg_portx_cn63xx {
+		uint64_t reserved_32_63:32;
+		uint64_t enable:1;
+		uint64_t reserved_2_30:29;
+		uint64_t port:2;
+	} cn63xx;
+	struct cvmx_sriox_omsg_portx_cn63xx cn63xxp1;
+	struct cvmx_sriox_omsg_portx_s cn66xx;
+};
+
+union cvmx_sriox_omsg_silo_thr {
+	uint64_t u64;
+	struct cvmx_sriox_omsg_silo_thr_s {
+		uint64_t reserved_5_63:59;
+		uint64_t tot_silo:5;
+	} s;
+	struct cvmx_sriox_omsg_silo_thr_s cn63xx;
+	struct cvmx_sriox_omsg_silo_thr_s cn66xx;
+};
+
+union cvmx_sriox_omsg_sp_mrx {
+	uint64_t u64;
+	struct cvmx_sriox_omsg_sp_mrx_s {
+		uint64_t reserved_16_63:48;
+		uint64_t xmbox_sp:1;
+		uint64_t ctlr_sp:1;
+		uint64_t ctlr_fmp:1;
+		uint64_t ctlr_nmp:1;
+		uint64_t id_sp:1;
+		uint64_t id_fmp:1;
+		uint64_t id_nmp:1;
+		uint64_t id_psd:1;
+		uint64_t mbox_sp:1;
+		uint64_t mbox_fmp:1;
+		uint64_t mbox_nmp:1;
+		uint64_t mbox_psd:1;
+		uint64_t all_sp:1;
+		uint64_t all_fmp:1;
+		uint64_t all_nmp:1;
+		uint64_t all_psd:1;
+	} s;
+	struct cvmx_sriox_omsg_sp_mrx_s cn63xx;
+	struct cvmx_sriox_omsg_sp_mrx_s cn63xxp1;
+	struct cvmx_sriox_omsg_sp_mrx_s cn66xx;
+};
+
+union cvmx_sriox_priox_in_use {
+	uint64_t u64;
+	struct cvmx_sriox_priox_in_use_s {
+		uint64_t reserved_32_63:32;
+		uint64_t end_cnt:16;
+		uint64_t start_cnt:16;
+	} s;
+	struct cvmx_sriox_priox_in_use_s cn63xx;
+	struct cvmx_sriox_priox_in_use_s cn66xx;
+};
+
+union cvmx_sriox_rx_bell {
+	uint64_t u64;
+	struct cvmx_sriox_rx_bell_s {
+		uint64_t reserved_48_63:16;
+		uint64_t data:16;
+		uint64_t src_id:16;
+		uint64_t count:8;
+		uint64_t reserved_5_7:3;
+		uint64_t dest_id:1;
+		uint64_t id16:1;
+		uint64_t reserved_2_2:1;
+		uint64_t priority:2;
+	} s;
+	struct cvmx_sriox_rx_bell_s cn63xx;
+	struct cvmx_sriox_rx_bell_s cn63xxp1;
+	struct cvmx_sriox_rx_bell_s cn66xx;
+};
+
+union cvmx_sriox_rx_bell_seq {
+	uint64_t u64;
+	struct cvmx_sriox_rx_bell_seq_s {
+		uint64_t reserved_40_63:24;
+		uint64_t count:8;
+		uint64_t seq:32;
+	} s;
+	struct cvmx_sriox_rx_bell_seq_s cn63xx;
+	struct cvmx_sriox_rx_bell_seq_s cn63xxp1;
+	struct cvmx_sriox_rx_bell_seq_s cn66xx;
+};
+
+union cvmx_sriox_rx_status {
+	uint64_t u64;
+	struct cvmx_sriox_rx_status_s {
+		uint64_t rtn_pr3:8;
+		uint64_t rtn_pr2:8;
+		uint64_t rtn_pr1:8;
+		uint64_t reserved_28_39:12;
+		uint64_t mbox:4;
+		uint64_t comp:8;
+		uint64_t reserved_13_15:3;
+		uint64_t n_post:5;
+		uint64_t post:8;
+	} s;
+	struct cvmx_sriox_rx_status_s cn63xx;
+	struct cvmx_sriox_rx_status_s cn63xxp1;
+	struct cvmx_sriox_rx_status_s cn66xx;
+};
+
+union cvmx_sriox_s2m_typex {
+	uint64_t u64;
+	struct cvmx_sriox_s2m_typex_s {
+		uint64_t reserved_19_63:45;
+		uint64_t wr_op:3;
+		uint64_t reserved_15_15:1;
+		uint64_t rd_op:3;
+		uint64_t wr_prior:2;
+		uint64_t rd_prior:2;
+		uint64_t reserved_6_7:2;
+		uint64_t src_id:1;
+		uint64_t id16:1;
+		uint64_t reserved_2_3:2;
+		uint64_t iaow_sel:2;
+	} s;
+	struct cvmx_sriox_s2m_typex_s cn63xx;
+	struct cvmx_sriox_s2m_typex_s cn63xxp1;
+	struct cvmx_sriox_s2m_typex_s cn66xx;
+};
+
+union cvmx_sriox_seq {
+	uint64_t u64;
+	struct cvmx_sriox_seq_s {
+		uint64_t reserved_32_63:32;
+		uint64_t seq:32;
+	} s;
+	struct cvmx_sriox_seq_s cn63xx;
+	struct cvmx_sriox_seq_s cn63xxp1;
+	struct cvmx_sriox_seq_s cn66xx;
+};
+
+union cvmx_sriox_status_reg {
+	uint64_t u64;
+	struct cvmx_sriox_status_reg_s {
+		uint64_t reserved_2_63:62;
+		uint64_t access:1;
+		uint64_t srio:1;
+	} s;
+	struct cvmx_sriox_status_reg_s cn63xx;
+	struct cvmx_sriox_status_reg_s cn63xxp1;
+	struct cvmx_sriox_status_reg_s cn66xx;
+};
+
+union cvmx_sriox_tag_ctrl {
+	uint64_t u64;
+	struct cvmx_sriox_tag_ctrl_s {
+		uint64_t reserved_17_63:47;
+		uint64_t o_clr:1;
+		uint64_t reserved_13_15:3;
+		uint64_t otag:5;
+		uint64_t reserved_5_7:3;
+		uint64_t itag:5;
+	} s;
+	struct cvmx_sriox_tag_ctrl_s cn63xx;
+	struct cvmx_sriox_tag_ctrl_s cn63xxp1;
+	struct cvmx_sriox_tag_ctrl_s cn66xx;
+};
+
+union cvmx_sriox_tlp_credits {
+	uint64_t u64;
+	struct cvmx_sriox_tlp_credits_s {
+		uint64_t reserved_28_63:36;
+		uint64_t mbox:4;
+		uint64_t comp:8;
+		uint64_t reserved_13_15:3;
+		uint64_t n_post:5;
+		uint64_t post:8;
+	} s;
+	struct cvmx_sriox_tlp_credits_s cn63xx;
+	struct cvmx_sriox_tlp_credits_s cn63xxp1;
+	struct cvmx_sriox_tlp_credits_s cn66xx;
+};
+
+union cvmx_sriox_tx_bell {
+	uint64_t u64;
+	struct cvmx_sriox_tx_bell_s {
+		uint64_t reserved_48_63:16;
+		uint64_t data:16;
+		uint64_t dest_id:16;
+		uint64_t reserved_9_15:7;
+		uint64_t pending:1;
+		uint64_t reserved_5_7:3;
+		uint64_t src_id:1;
+		uint64_t id16:1;
+		uint64_t reserved_2_2:1;
+		uint64_t priority:2;
+	} s;
+	struct cvmx_sriox_tx_bell_s cn63xx;
+	struct cvmx_sriox_tx_bell_s cn63xxp1;
+	struct cvmx_sriox_tx_bell_s cn66xx;
+};
+
+union cvmx_sriox_tx_bell_info {
+	uint64_t u64;
+	struct cvmx_sriox_tx_bell_info_s {
+		uint64_t reserved_48_63:16;
+		uint64_t data:16;
+		uint64_t dest_id:16;
+		uint64_t reserved_8_15:8;
+		uint64_t timeout:1;
+		uint64_t error:1;
+		uint64_t retry:1;
+		uint64_t src_id:1;
+		uint64_t id16:1;
+		uint64_t reserved_2_2:1;
+		uint64_t priority:2;
+	} s;
+	struct cvmx_sriox_tx_bell_info_s cn63xx;
+	struct cvmx_sriox_tx_bell_info_s cn63xxp1;
+	struct cvmx_sriox_tx_bell_info_s cn66xx;
+};
+
+union cvmx_sriox_tx_ctrl {
+	uint64_t u64;
+	struct cvmx_sriox_tx_ctrl_s {
+		uint64_t reserved_53_63:11;
+		uint64_t tag_th2:5;
+		uint64_t reserved_45_47:3;
+		uint64_t tag_th1:5;
+		uint64_t reserved_37_39:3;
+		uint64_t tag_th0:5;
+		uint64_t reserved_20_31:12;
+		uint64_t tx_th2:4;
+		uint64_t reserved_12_15:4;
+		uint64_t tx_th1:4;
+		uint64_t reserved_4_7:4;
+		uint64_t tx_th0:4;
+	} s;
+	struct cvmx_sriox_tx_ctrl_s cn63xx;
+	struct cvmx_sriox_tx_ctrl_s cn63xxp1;
+	struct cvmx_sriox_tx_ctrl_s cn66xx;
+};
+
+union cvmx_sriox_tx_emphasis {
+	uint64_t u64;
+	struct cvmx_sriox_tx_emphasis_s {
+		uint64_t reserved_4_63:60;
+		uint64_t emph:4;
+	} s;
+	struct cvmx_sriox_tx_emphasis_s cn63xx;
+	struct cvmx_sriox_tx_emphasis_s cn66xx;
+};
+
+union cvmx_sriox_tx_status {
+	uint64_t u64;
+	struct cvmx_sriox_tx_status_s {
+		uint64_t reserved_32_63:32;
+		uint64_t s2m_pr3:8;
+		uint64_t s2m_pr2:8;
+		uint64_t s2m_pr1:8;
+		uint64_t s2m_pr0:8;
+	} s;
+	struct cvmx_sriox_tx_status_s cn63xx;
+	struct cvmx_sriox_tx_status_s cn63xxp1;
+	struct cvmx_sriox_tx_status_s cn66xx;
+};
+
+union cvmx_sriox_wr_done_counts {
+	uint64_t u64;
+	struct cvmx_sriox_wr_done_counts_s {
+		uint64_t reserved_32_63:32;
+		uint64_t bad:16;
+		uint64_t good:16;
+	} s;
+	struct cvmx_sriox_wr_done_counts_s cn63xx;
+	struct cvmx_sriox_wr_done_counts_s cn66xx;
+};
+
+#endif
-- 
1.7.2.3
