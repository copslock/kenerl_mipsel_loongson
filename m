Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2009 01:46:28 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:62742 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20021638AbZDXApy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Apr 2009 01:45:54 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49f10bb30000>; Thu, 23 Apr 2009 20:45:39 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Apr 2009 17:44:42 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Apr 2009 17:44:42 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n3O0idpL025322;
	Thu, 23 Apr 2009 17:44:39 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n3O0icHU025320;
	Thu, 23 Apr 2009 17:44:38 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/2] MIPS: Add register definitions for PCI.
Date:	Thu, 23 Apr 2009 17:44:37 -0700
Message-Id: <1240533878-25296-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <49F10B38.7070808@caviumnetworks.com>
References: <49F10B38.7070808@caviumnetworks.com>
X-OriginalArrivalTime: 24 Apr 2009 00:44:42.0064 (UTC) FILETIME=[DAF77D00:01C9C475]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Here we add the register definitions for the processor blocks used by
the following PCI support patch.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/octeon/cvmx-npei-defs.h    | 2560 ++++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx-npi-defs.h     | 1735 +++++++++++++++
 arch/mips/include/asm/octeon/cvmx-pci-defs.h     | 1645 ++++++++++++++
 arch/mips/include/asm/octeon/cvmx-pcieep-defs.h  | 1365 ++++++++++++
 arch/mips/include/asm/octeon/cvmx-pciercx-defs.h | 1397 ++++++++++++
 arch/mips/include/asm/octeon/cvmx-pescx-defs.h   |  410 ++++
 arch/mips/include/asm/octeon/cvmx-pexp-defs.h    |  229 ++
 7 files changed, 9341 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/octeon/cvmx-npei-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-npi-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-pci-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-pcieep-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-pciercx-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-pescx-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-pexp-defs.h

diff --git a/arch/mips/include/asm/octeon/cvmx-npei-defs.h b/arch/mips/include/asm/octeon/cvmx-npei-defs.h
new file mode 100644
index 0000000..4b347bb
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-npei-defs.h
@@ -0,0 +1,2560 @@
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
+#ifndef __CVMX_NPEI_DEFS_H__
+#define __CVMX_NPEI_DEFS_H__
+
+#define CVMX_NPEI_BAR1_INDEXX(offset) \
+	 (0x0000000000000000ull + (((offset) & 31) * 16))
+#define CVMX_NPEI_BIST_STATUS \
+	 (0x0000000000000580ull)
+#define CVMX_NPEI_BIST_STATUS2 \
+	 (0x0000000000000680ull)
+#define CVMX_NPEI_CTL_PORT0 \
+	 (0x0000000000000250ull)
+#define CVMX_NPEI_CTL_PORT1 \
+	 (0x0000000000000260ull)
+#define CVMX_NPEI_CTL_STATUS \
+	 (0x0000000000000570ull)
+#define CVMX_NPEI_CTL_STATUS2 \
+	 (0x0000000000003C00ull)
+#define CVMX_NPEI_DATA_OUT_CNT \
+	 (0x00000000000005F0ull)
+#define CVMX_NPEI_DBG_DATA \
+	 (0x0000000000000510ull)
+#define CVMX_NPEI_DBG_SELECT \
+	 (0x0000000000000500ull)
+#define CVMX_NPEI_DMA0_INT_LEVEL \
+	 (0x00000000000005C0ull)
+#define CVMX_NPEI_DMA1_INT_LEVEL \
+	 (0x00000000000005D0ull)
+#define CVMX_NPEI_DMAX_COUNTS(offset) \
+	 (0x0000000000000450ull + (((offset) & 7) * 16))
+#define CVMX_NPEI_DMAX_DBELL(offset) \
+	 (0x00000000000003B0ull + (((offset) & 7) * 16))
+#define CVMX_NPEI_DMAX_IBUFF_SADDR(offset) \
+	 (0x0000000000000400ull + (((offset) & 7) * 16))
+#define CVMX_NPEI_DMAX_NADDR(offset) \
+	 (0x00000000000004A0ull + (((offset) & 7) * 16))
+#define CVMX_NPEI_DMA_CNTS \
+	 (0x00000000000005E0ull)
+#define CVMX_NPEI_DMA_CONTROL \
+	 (0x00000000000003A0ull)
+#define CVMX_NPEI_INT_A_ENB \
+	 (0x0000000000000560ull)
+#define CVMX_NPEI_INT_A_ENB2 \
+	 (0x0000000000003CE0ull)
+#define CVMX_NPEI_INT_A_SUM \
+	 (0x0000000000000550ull)
+#define CVMX_NPEI_INT_ENB \
+	 (0x0000000000000540ull)
+#define CVMX_NPEI_INT_ENB2 \
+	 (0x0000000000003CD0ull)
+#define CVMX_NPEI_INT_INFO \
+	 (0x0000000000000590ull)
+#define CVMX_NPEI_INT_SUM \
+	 (0x0000000000000530ull)
+#define CVMX_NPEI_INT_SUM2 \
+	 (0x0000000000003CC0ull)
+#define CVMX_NPEI_LAST_WIN_RDATA0 \
+	 (0x0000000000000600ull)
+#define CVMX_NPEI_LAST_WIN_RDATA1 \
+	 (0x0000000000000610ull)
+#define CVMX_NPEI_MEM_ACCESS_CTL \
+	 (0x00000000000004F0ull)
+#define CVMX_NPEI_MEM_ACCESS_SUBIDX(offset) \
+	 (0x0000000000000340ull + (((offset) & 31) * 16) - 16 * 12)
+#define CVMX_NPEI_MSI_ENB0 \
+	 (0x0000000000003C50ull)
+#define CVMX_NPEI_MSI_ENB1 \
+	 (0x0000000000003C60ull)
+#define CVMX_NPEI_MSI_ENB2 \
+	 (0x0000000000003C70ull)
+#define CVMX_NPEI_MSI_ENB3 \
+	 (0x0000000000003C80ull)
+#define CVMX_NPEI_MSI_RCV0 \
+	 (0x0000000000003C10ull)
+#define CVMX_NPEI_MSI_RCV1 \
+	 (0x0000000000003C20ull)
+#define CVMX_NPEI_MSI_RCV2 \
+	 (0x0000000000003C30ull)
+#define CVMX_NPEI_MSI_RCV3 \
+	 (0x0000000000003C40ull)
+#define CVMX_NPEI_MSI_RD_MAP \
+	 (0x0000000000003CA0ull)
+#define CVMX_NPEI_MSI_W1C_ENB0 \
+	 (0x0000000000003CF0ull)
+#define CVMX_NPEI_MSI_W1C_ENB1 \
+	 (0x0000000000003D00ull)
+#define CVMX_NPEI_MSI_W1C_ENB2 \
+	 (0x0000000000003D10ull)
+#define CVMX_NPEI_MSI_W1C_ENB3 \
+	 (0x0000000000003D20ull)
+#define CVMX_NPEI_MSI_W1S_ENB0 \
+	 (0x0000000000003D30ull)
+#define CVMX_NPEI_MSI_W1S_ENB1 \
+	 (0x0000000000003D40ull)
+#define CVMX_NPEI_MSI_W1S_ENB2 \
+	 (0x0000000000003D50ull)
+#define CVMX_NPEI_MSI_W1S_ENB3 \
+	 (0x0000000000003D60ull)
+#define CVMX_NPEI_MSI_WR_MAP \
+	 (0x0000000000003C90ull)
+#define CVMX_NPEI_PCIE_CREDIT_CNT \
+	 (0x0000000000003D70ull)
+#define CVMX_NPEI_PCIE_MSI_RCV \
+	 (0x0000000000003CB0ull)
+#define CVMX_NPEI_PCIE_MSI_RCV_B1 \
+	 (0x0000000000000650ull)
+#define CVMX_NPEI_PCIE_MSI_RCV_B2 \
+	 (0x0000000000000660ull)
+#define CVMX_NPEI_PCIE_MSI_RCV_B3 \
+	 (0x0000000000000670ull)
+#define CVMX_NPEI_PKTX_CNTS(offset) \
+	 (0x0000000000002400ull + (((offset) & 31) * 16))
+#define CVMX_NPEI_PKTX_INSTR_BADDR(offset) \
+	 (0x0000000000002800ull + (((offset) & 31) * 16))
+#define CVMX_NPEI_PKTX_INSTR_BAOFF_DBELL(offset) \
+	 (0x0000000000002C00ull + (((offset) & 31) * 16))
+#define CVMX_NPEI_PKTX_INSTR_FIFO_RSIZE(offset) \
+	 (0x0000000000003000ull + (((offset) & 31) * 16))
+#define CVMX_NPEI_PKTX_INSTR_HEADER(offset) \
+	 (0x0000000000003400ull + (((offset) & 31) * 16))
+#define CVMX_NPEI_PKTX_IN_BP(offset) \
+	 (0x0000000000003800ull + (((offset) & 31) * 16))
+#define CVMX_NPEI_PKTX_SLIST_BADDR(offset) \
+	 (0x0000000000001400ull + (((offset) & 31) * 16))
+#define CVMX_NPEI_PKTX_SLIST_BAOFF_DBELL(offset) \
+	 (0x0000000000001800ull + (((offset) & 31) * 16))
+#define CVMX_NPEI_PKTX_SLIST_FIFO_RSIZE(offset) \
+	 (0x0000000000001C00ull + (((offset) & 31) * 16))
+#define CVMX_NPEI_PKT_CNT_INT \
+	 (0x0000000000001110ull)
+#define CVMX_NPEI_PKT_CNT_INT_ENB \
+	 (0x0000000000001130ull)
+#define CVMX_NPEI_PKT_DATA_OUT_ES \
+	 (0x00000000000010B0ull)
+#define CVMX_NPEI_PKT_DATA_OUT_NS \
+	 (0x00000000000010A0ull)
+#define CVMX_NPEI_PKT_DATA_OUT_ROR \
+	 (0x0000000000001090ull)
+#define CVMX_NPEI_PKT_DPADDR \
+	 (0x0000000000001080ull)
+#define CVMX_NPEI_PKT_INPUT_CONTROL \
+	 (0x0000000000001150ull)
+#define CVMX_NPEI_PKT_INSTR_ENB \
+	 (0x0000000000001000ull)
+#define CVMX_NPEI_PKT_INSTR_RD_SIZE \
+	 (0x0000000000001190ull)
+#define CVMX_NPEI_PKT_INSTR_SIZE \
+	 (0x0000000000001020ull)
+#define CVMX_NPEI_PKT_INT_LEVELS \
+	 (0x0000000000001100ull)
+#define CVMX_NPEI_PKT_IN_BP \
+	 (0x00000000000006B0ull)
+#define CVMX_NPEI_PKT_IN_DONEX_CNTS(offset) \
+	 (0x0000000000002000ull + (((offset) & 31) * 16))
+#define CVMX_NPEI_PKT_IN_INSTR_COUNTS \
+	 (0x00000000000006A0ull)
+#define CVMX_NPEI_PKT_IN_PCIE_PORT \
+	 (0x00000000000011A0ull)
+#define CVMX_NPEI_PKT_IPTR \
+	 (0x0000000000001070ull)
+#define CVMX_NPEI_PKT_OUTPUT_WMARK \
+	 (0x0000000000001160ull)
+#define CVMX_NPEI_PKT_OUT_BMODE \
+	 (0x00000000000010D0ull)
+#define CVMX_NPEI_PKT_OUT_ENB \
+	 (0x0000000000001010ull)
+#define CVMX_NPEI_PKT_PCIE_PORT \
+	 (0x00000000000010E0ull)
+#define CVMX_NPEI_PKT_PORT_IN_RST \
+	 (0x0000000000000690ull)
+#define CVMX_NPEI_PKT_SLIST_ES \
+	 (0x0000000000001050ull)
+#define CVMX_NPEI_PKT_SLIST_ID_SIZE \
+	 (0x0000000000001180ull)
+#define CVMX_NPEI_PKT_SLIST_NS \
+	 (0x0000000000001040ull)
+#define CVMX_NPEI_PKT_SLIST_ROR \
+	 (0x0000000000001030ull)
+#define CVMX_NPEI_PKT_TIME_INT \
+	 (0x0000000000001120ull)
+#define CVMX_NPEI_PKT_TIME_INT_ENB \
+	 (0x0000000000001140ull)
+#define CVMX_NPEI_RSL_INT_BLOCKS \
+	 (0x0000000000000520ull)
+#define CVMX_NPEI_SCRATCH_1 \
+	 (0x0000000000000270ull)
+#define CVMX_NPEI_STATE1 \
+	 (0x0000000000000620ull)
+#define CVMX_NPEI_STATE2 \
+	 (0x0000000000000630ull)
+#define CVMX_NPEI_STATE3 \
+	 (0x0000000000000640ull)
+#define CVMX_NPEI_WINDOW_CTL \
+	 (0x0000000000000380ull)
+#define CVMX_NPEI_WIN_RD_ADDR \
+	 (0x0000000000000210ull)
+#define CVMX_NPEI_WIN_RD_DATA \
+	 (0x0000000000000240ull)
+#define CVMX_NPEI_WIN_WR_ADDR \
+	 (0x0000000000000200ull)
+#define CVMX_NPEI_WIN_WR_DATA \
+	 (0x0000000000000220ull)
+#define CVMX_NPEI_WIN_WR_MASK \
+	 (0x0000000000000230ull)
+
+union cvmx_npei_bar1_indexx {
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
+};
+
+union cvmx_npei_bist_status {
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
+};
+
+union cvmx_npei_bist_status2 {
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
+};
+
+union cvmx_npei_ctl_port0 {
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
+};
+
+union cvmx_npei_ctl_port1 {
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
+};
+
+union cvmx_npei_ctl_status {
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
+};
+
+union cvmx_npei_ctl_status2 {
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
+};
+
+union cvmx_npei_data_out_cnt {
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
+};
+
+union cvmx_npei_dbg_data {
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
+};
+
+union cvmx_npei_dbg_select {
+	uint64_t u64;
+	struct cvmx_npei_dbg_select_s {
+		uint64_t reserved_16_63:48;
+		uint64_t dbg_sel:16;
+	} s;
+	struct cvmx_npei_dbg_select_s cn52xx;
+	struct cvmx_npei_dbg_select_s cn52xxp1;
+	struct cvmx_npei_dbg_select_s cn56xx;
+	struct cvmx_npei_dbg_select_s cn56xxp1;
+};
+
+union cvmx_npei_dmax_counts {
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
+};
+
+union cvmx_npei_dmax_dbell {
+	uint32_t u32;
+	struct cvmx_npei_dmax_dbell_s {
+		uint32_t reserved_16_31:16;
+		uint32_t dbell:16;
+	} s;
+	struct cvmx_npei_dmax_dbell_s cn52xx;
+	struct cvmx_npei_dmax_dbell_s cn52xxp1;
+	struct cvmx_npei_dmax_dbell_s cn56xx;
+	struct cvmx_npei_dmax_dbell_s cn56xxp1;
+};
+
+union cvmx_npei_dmax_ibuff_saddr {
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
+};
+
+union cvmx_npei_dmax_naddr {
+	uint64_t u64;
+	struct cvmx_npei_dmax_naddr_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_npei_dmax_naddr_s cn52xx;
+	struct cvmx_npei_dmax_naddr_s cn52xxp1;
+	struct cvmx_npei_dmax_naddr_s cn56xx;
+	struct cvmx_npei_dmax_naddr_s cn56xxp1;
+};
+
+union cvmx_npei_dma0_int_level {
+	uint64_t u64;
+	struct cvmx_npei_dma0_int_level_s {
+		uint64_t time:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_npei_dma0_int_level_s cn52xx;
+	struct cvmx_npei_dma0_int_level_s cn52xxp1;
+	struct cvmx_npei_dma0_int_level_s cn56xx;
+	struct cvmx_npei_dma0_int_level_s cn56xxp1;
+};
+
+union cvmx_npei_dma1_int_level {
+	uint64_t u64;
+	struct cvmx_npei_dma1_int_level_s {
+		uint64_t time:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_npei_dma1_int_level_s cn52xx;
+	struct cvmx_npei_dma1_int_level_s cn52xxp1;
+	struct cvmx_npei_dma1_int_level_s cn56xx;
+	struct cvmx_npei_dma1_int_level_s cn56xxp1;
+};
+
+union cvmx_npei_dma_cnts {
+	uint64_t u64;
+	struct cvmx_npei_dma_cnts_s {
+		uint64_t dma1:32;
+		uint64_t dma0:32;
+	} s;
+	struct cvmx_npei_dma_cnts_s cn52xx;
+	struct cvmx_npei_dma_cnts_s cn52xxp1;
+	struct cvmx_npei_dma_cnts_s cn56xx;
+	struct cvmx_npei_dma_cnts_s cn56xxp1;
+};
+
+union cvmx_npei_dma_control {
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
+};
+
+union cvmx_npei_int_a_enb {
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
+};
+
+union cvmx_npei_int_a_enb2 {
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
+};
+
+union cvmx_npei_int_a_sum {
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
+};
+
+union cvmx_npei_int_enb {
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
+};
+
+union cvmx_npei_int_enb2 {
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
+};
+
+union cvmx_npei_int_info {
+	uint64_t u64;
+	struct cvmx_npei_int_info_s {
+		uint64_t reserved_12_63:52;
+		uint64_t pidbof:6;
+		uint64_t psldbof:6;
+	} s;
+	struct cvmx_npei_int_info_s cn52xx;
+	struct cvmx_npei_int_info_s cn56xx;
+	struct cvmx_npei_int_info_s cn56xxp1;
+};
+
+union cvmx_npei_int_sum {
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
+};
+
+union cvmx_npei_int_sum2 {
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
+};
+
+union cvmx_npei_last_win_rdata0 {
+	uint64_t u64;
+	struct cvmx_npei_last_win_rdata0_s {
+		uint64_t data:64;
+	} s;
+	struct cvmx_npei_last_win_rdata0_s cn52xx;
+	struct cvmx_npei_last_win_rdata0_s cn52xxp1;
+	struct cvmx_npei_last_win_rdata0_s cn56xx;
+	struct cvmx_npei_last_win_rdata0_s cn56xxp1;
+};
+
+union cvmx_npei_last_win_rdata1 {
+	uint64_t u64;
+	struct cvmx_npei_last_win_rdata1_s {
+		uint64_t data:64;
+	} s;
+	struct cvmx_npei_last_win_rdata1_s cn52xx;
+	struct cvmx_npei_last_win_rdata1_s cn52xxp1;
+	struct cvmx_npei_last_win_rdata1_s cn56xx;
+	struct cvmx_npei_last_win_rdata1_s cn56xxp1;
+};
+
+union cvmx_npei_mem_access_ctl {
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
+};
+
+union cvmx_npei_mem_access_subidx {
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
+};
+
+union cvmx_npei_msi_enb0 {
+	uint64_t u64;
+	struct cvmx_npei_msi_enb0_s {
+		uint64_t enb:64;
+	} s;
+	struct cvmx_npei_msi_enb0_s cn52xx;
+	struct cvmx_npei_msi_enb0_s cn52xxp1;
+	struct cvmx_npei_msi_enb0_s cn56xx;
+	struct cvmx_npei_msi_enb0_s cn56xxp1;
+};
+
+union cvmx_npei_msi_enb1 {
+	uint64_t u64;
+	struct cvmx_npei_msi_enb1_s {
+		uint64_t enb:64;
+	} s;
+	struct cvmx_npei_msi_enb1_s cn52xx;
+	struct cvmx_npei_msi_enb1_s cn52xxp1;
+	struct cvmx_npei_msi_enb1_s cn56xx;
+	struct cvmx_npei_msi_enb1_s cn56xxp1;
+};
+
+union cvmx_npei_msi_enb2 {
+	uint64_t u64;
+	struct cvmx_npei_msi_enb2_s {
+		uint64_t enb:64;
+	} s;
+	struct cvmx_npei_msi_enb2_s cn52xx;
+	struct cvmx_npei_msi_enb2_s cn52xxp1;
+	struct cvmx_npei_msi_enb2_s cn56xx;
+	struct cvmx_npei_msi_enb2_s cn56xxp1;
+};
+
+union cvmx_npei_msi_enb3 {
+	uint64_t u64;
+	struct cvmx_npei_msi_enb3_s {
+		uint64_t enb:64;
+	} s;
+	struct cvmx_npei_msi_enb3_s cn52xx;
+	struct cvmx_npei_msi_enb3_s cn52xxp1;
+	struct cvmx_npei_msi_enb3_s cn56xx;
+	struct cvmx_npei_msi_enb3_s cn56xxp1;
+};
+
+union cvmx_npei_msi_rcv0 {
+	uint64_t u64;
+	struct cvmx_npei_msi_rcv0_s {
+		uint64_t intr:64;
+	} s;
+	struct cvmx_npei_msi_rcv0_s cn52xx;
+	struct cvmx_npei_msi_rcv0_s cn52xxp1;
+	struct cvmx_npei_msi_rcv0_s cn56xx;
+	struct cvmx_npei_msi_rcv0_s cn56xxp1;
+};
+
+union cvmx_npei_msi_rcv1 {
+	uint64_t u64;
+	struct cvmx_npei_msi_rcv1_s {
+		uint64_t intr:64;
+	} s;
+	struct cvmx_npei_msi_rcv1_s cn52xx;
+	struct cvmx_npei_msi_rcv1_s cn52xxp1;
+	struct cvmx_npei_msi_rcv1_s cn56xx;
+	struct cvmx_npei_msi_rcv1_s cn56xxp1;
+};
+
+union cvmx_npei_msi_rcv2 {
+	uint64_t u64;
+	struct cvmx_npei_msi_rcv2_s {
+		uint64_t intr:64;
+	} s;
+	struct cvmx_npei_msi_rcv2_s cn52xx;
+	struct cvmx_npei_msi_rcv2_s cn52xxp1;
+	struct cvmx_npei_msi_rcv2_s cn56xx;
+	struct cvmx_npei_msi_rcv2_s cn56xxp1;
+};
+
+union cvmx_npei_msi_rcv3 {
+	uint64_t u64;
+	struct cvmx_npei_msi_rcv3_s {
+		uint64_t intr:64;
+	} s;
+	struct cvmx_npei_msi_rcv3_s cn52xx;
+	struct cvmx_npei_msi_rcv3_s cn52xxp1;
+	struct cvmx_npei_msi_rcv3_s cn56xx;
+	struct cvmx_npei_msi_rcv3_s cn56xxp1;
+};
+
+union cvmx_npei_msi_rd_map {
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
+};
+
+union cvmx_npei_msi_w1c_enb0 {
+	uint64_t u64;
+	struct cvmx_npei_msi_w1c_enb0_s {
+		uint64_t clr:64;
+	} s;
+	struct cvmx_npei_msi_w1c_enb0_s cn52xx;
+	struct cvmx_npei_msi_w1c_enb0_s cn56xx;
+};
+
+union cvmx_npei_msi_w1c_enb1 {
+	uint64_t u64;
+	struct cvmx_npei_msi_w1c_enb1_s {
+		uint64_t clr:64;
+	} s;
+	struct cvmx_npei_msi_w1c_enb1_s cn52xx;
+	struct cvmx_npei_msi_w1c_enb1_s cn56xx;
+};
+
+union cvmx_npei_msi_w1c_enb2 {
+	uint64_t u64;
+	struct cvmx_npei_msi_w1c_enb2_s {
+		uint64_t clr:64;
+	} s;
+	struct cvmx_npei_msi_w1c_enb2_s cn52xx;
+	struct cvmx_npei_msi_w1c_enb2_s cn56xx;
+};
+
+union cvmx_npei_msi_w1c_enb3 {
+	uint64_t u64;
+	struct cvmx_npei_msi_w1c_enb3_s {
+		uint64_t clr:64;
+	} s;
+	struct cvmx_npei_msi_w1c_enb3_s cn52xx;
+	struct cvmx_npei_msi_w1c_enb3_s cn56xx;
+};
+
+union cvmx_npei_msi_w1s_enb0 {
+	uint64_t u64;
+	struct cvmx_npei_msi_w1s_enb0_s {
+		uint64_t set:64;
+	} s;
+	struct cvmx_npei_msi_w1s_enb0_s cn52xx;
+	struct cvmx_npei_msi_w1s_enb0_s cn56xx;
+};
+
+union cvmx_npei_msi_w1s_enb1 {
+	uint64_t u64;
+	struct cvmx_npei_msi_w1s_enb1_s {
+		uint64_t set:64;
+	} s;
+	struct cvmx_npei_msi_w1s_enb1_s cn52xx;
+	struct cvmx_npei_msi_w1s_enb1_s cn56xx;
+};
+
+union cvmx_npei_msi_w1s_enb2 {
+	uint64_t u64;
+	struct cvmx_npei_msi_w1s_enb2_s {
+		uint64_t set:64;
+	} s;
+	struct cvmx_npei_msi_w1s_enb2_s cn52xx;
+	struct cvmx_npei_msi_w1s_enb2_s cn56xx;
+};
+
+union cvmx_npei_msi_w1s_enb3 {
+	uint64_t u64;
+	struct cvmx_npei_msi_w1s_enb3_s {
+		uint64_t set:64;
+	} s;
+	struct cvmx_npei_msi_w1s_enb3_s cn52xx;
+	struct cvmx_npei_msi_w1s_enb3_s cn56xx;
+};
+
+union cvmx_npei_msi_wr_map {
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
+};
+
+union cvmx_npei_pcie_credit_cnt {
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
+};
+
+union cvmx_npei_pcie_msi_rcv {
+	uint64_t u64;
+	struct cvmx_npei_pcie_msi_rcv_s {
+		uint64_t reserved_8_63:56;
+		uint64_t intr:8;
+	} s;
+	struct cvmx_npei_pcie_msi_rcv_s cn52xx;
+	struct cvmx_npei_pcie_msi_rcv_s cn52xxp1;
+	struct cvmx_npei_pcie_msi_rcv_s cn56xx;
+	struct cvmx_npei_pcie_msi_rcv_s cn56xxp1;
+};
+
+union cvmx_npei_pcie_msi_rcv_b1 {
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
+};
+
+union cvmx_npei_pcie_msi_rcv_b2 {
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
+};
+
+union cvmx_npei_pcie_msi_rcv_b3 {
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
+};
+
+union cvmx_npei_pktx_cnts {
+	uint64_t u64;
+	struct cvmx_npei_pktx_cnts_s {
+		uint64_t reserved_54_63:10;
+		uint64_t timer:22;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_npei_pktx_cnts_s cn52xx;
+	struct cvmx_npei_pktx_cnts_s cn56xx;
+	struct cvmx_npei_pktx_cnts_s cn56xxp1;
+};
+
+union cvmx_npei_pktx_in_bp {
+	uint64_t u64;
+	struct cvmx_npei_pktx_in_bp_s {
+		uint64_t wmark:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_npei_pktx_in_bp_s cn52xx;
+	struct cvmx_npei_pktx_in_bp_s cn56xx;
+	struct cvmx_npei_pktx_in_bp_s cn56xxp1;
+};
+
+union cvmx_npei_pktx_instr_baddr {
+	uint64_t u64;
+	struct cvmx_npei_pktx_instr_baddr_s {
+		uint64_t addr:61;
+		uint64_t reserved_0_2:3;
+	} s;
+	struct cvmx_npei_pktx_instr_baddr_s cn52xx;
+	struct cvmx_npei_pktx_instr_baddr_s cn56xx;
+	struct cvmx_npei_pktx_instr_baddr_s cn56xxp1;
+};
+
+union cvmx_npei_pktx_instr_baoff_dbell {
+	uint64_t u64;
+	struct cvmx_npei_pktx_instr_baoff_dbell_s {
+		uint64_t aoff:32;
+		uint64_t dbell:32;
+	} s;
+	struct cvmx_npei_pktx_instr_baoff_dbell_s cn52xx;
+	struct cvmx_npei_pktx_instr_baoff_dbell_s cn56xx;
+	struct cvmx_npei_pktx_instr_baoff_dbell_s cn56xxp1;
+};
+
+union cvmx_npei_pktx_instr_fifo_rsize {
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
+};
+
+union cvmx_npei_pktx_instr_header {
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
+};
+
+union cvmx_npei_pktx_slist_baddr {
+	uint64_t u64;
+	struct cvmx_npei_pktx_slist_baddr_s {
+		uint64_t addr:60;
+		uint64_t reserved_0_3:4;
+	} s;
+	struct cvmx_npei_pktx_slist_baddr_s cn52xx;
+	struct cvmx_npei_pktx_slist_baddr_s cn56xx;
+	struct cvmx_npei_pktx_slist_baddr_s cn56xxp1;
+};
+
+union cvmx_npei_pktx_slist_baoff_dbell {
+	uint64_t u64;
+	struct cvmx_npei_pktx_slist_baoff_dbell_s {
+		uint64_t aoff:32;
+		uint64_t dbell:32;
+	} s;
+	struct cvmx_npei_pktx_slist_baoff_dbell_s cn52xx;
+	struct cvmx_npei_pktx_slist_baoff_dbell_s cn56xx;
+	struct cvmx_npei_pktx_slist_baoff_dbell_s cn56xxp1;
+};
+
+union cvmx_npei_pktx_slist_fifo_rsize {
+	uint64_t u64;
+	struct cvmx_npei_pktx_slist_fifo_rsize_s {
+		uint64_t reserved_32_63:32;
+		uint64_t rsize:32;
+	} s;
+	struct cvmx_npei_pktx_slist_fifo_rsize_s cn52xx;
+	struct cvmx_npei_pktx_slist_fifo_rsize_s cn56xx;
+	struct cvmx_npei_pktx_slist_fifo_rsize_s cn56xxp1;
+};
+
+union cvmx_npei_pkt_cnt_int {
+	uint64_t u64;
+	struct cvmx_npei_pkt_cnt_int_s {
+		uint64_t reserved_32_63:32;
+		uint64_t port:32;
+	} s;
+	struct cvmx_npei_pkt_cnt_int_s cn52xx;
+	struct cvmx_npei_pkt_cnt_int_s cn56xx;
+	struct cvmx_npei_pkt_cnt_int_s cn56xxp1;
+};
+
+union cvmx_npei_pkt_cnt_int_enb {
+	uint64_t u64;
+	struct cvmx_npei_pkt_cnt_int_enb_s {
+		uint64_t reserved_32_63:32;
+		uint64_t port:32;
+	} s;
+	struct cvmx_npei_pkt_cnt_int_enb_s cn52xx;
+	struct cvmx_npei_pkt_cnt_int_enb_s cn56xx;
+	struct cvmx_npei_pkt_cnt_int_enb_s cn56xxp1;
+};
+
+union cvmx_npei_pkt_data_out_es {
+	uint64_t u64;
+	struct cvmx_npei_pkt_data_out_es_s {
+		uint64_t es:64;
+	} s;
+	struct cvmx_npei_pkt_data_out_es_s cn52xx;
+	struct cvmx_npei_pkt_data_out_es_s cn56xx;
+	struct cvmx_npei_pkt_data_out_es_s cn56xxp1;
+};
+
+union cvmx_npei_pkt_data_out_ns {
+	uint64_t u64;
+	struct cvmx_npei_pkt_data_out_ns_s {
+		uint64_t reserved_32_63:32;
+		uint64_t nsr:32;
+	} s;
+	struct cvmx_npei_pkt_data_out_ns_s cn52xx;
+	struct cvmx_npei_pkt_data_out_ns_s cn56xx;
+	struct cvmx_npei_pkt_data_out_ns_s cn56xxp1;
+};
+
+union cvmx_npei_pkt_data_out_ror {
+	uint64_t u64;
+	struct cvmx_npei_pkt_data_out_ror_s {
+		uint64_t reserved_32_63:32;
+		uint64_t ror:32;
+	} s;
+	struct cvmx_npei_pkt_data_out_ror_s cn52xx;
+	struct cvmx_npei_pkt_data_out_ror_s cn56xx;
+	struct cvmx_npei_pkt_data_out_ror_s cn56xxp1;
+};
+
+union cvmx_npei_pkt_dpaddr {
+	uint64_t u64;
+	struct cvmx_npei_pkt_dpaddr_s {
+		uint64_t reserved_32_63:32;
+		uint64_t dptr:32;
+	} s;
+	struct cvmx_npei_pkt_dpaddr_s cn52xx;
+	struct cvmx_npei_pkt_dpaddr_s cn56xx;
+	struct cvmx_npei_pkt_dpaddr_s cn56xxp1;
+};
+
+union cvmx_npei_pkt_in_bp {
+	uint64_t u64;
+	struct cvmx_npei_pkt_in_bp_s {
+		uint64_t reserved_32_63:32;
+		uint64_t bp:32;
+	} s;
+	struct cvmx_npei_pkt_in_bp_s cn56xx;
+};
+
+union cvmx_npei_pkt_in_donex_cnts {
+	uint64_t u64;
+	struct cvmx_npei_pkt_in_donex_cnts_s {
+		uint64_t reserved_32_63:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_npei_pkt_in_donex_cnts_s cn52xx;
+	struct cvmx_npei_pkt_in_donex_cnts_s cn56xx;
+	struct cvmx_npei_pkt_in_donex_cnts_s cn56xxp1;
+};
+
+union cvmx_npei_pkt_in_instr_counts {
+	uint64_t u64;
+	struct cvmx_npei_pkt_in_instr_counts_s {
+		uint64_t wr_cnt:32;
+		uint64_t rd_cnt:32;
+	} s;
+	struct cvmx_npei_pkt_in_instr_counts_s cn52xx;
+	struct cvmx_npei_pkt_in_instr_counts_s cn56xx;
+};
+
+union cvmx_npei_pkt_in_pcie_port {
+	uint64_t u64;
+	struct cvmx_npei_pkt_in_pcie_port_s {
+		uint64_t pp:64;
+	} s;
+	struct cvmx_npei_pkt_in_pcie_port_s cn52xx;
+	struct cvmx_npei_pkt_in_pcie_port_s cn56xx;
+};
+
+union cvmx_npei_pkt_input_control {
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
+};
+
+union cvmx_npei_pkt_instr_enb {
+	uint64_t u64;
+	struct cvmx_npei_pkt_instr_enb_s {
+		uint64_t reserved_32_63:32;
+		uint64_t enb:32;
+	} s;
+	struct cvmx_npei_pkt_instr_enb_s cn52xx;
+	struct cvmx_npei_pkt_instr_enb_s cn56xx;
+	struct cvmx_npei_pkt_instr_enb_s cn56xxp1;
+};
+
+union cvmx_npei_pkt_instr_rd_size {
+	uint64_t u64;
+	struct cvmx_npei_pkt_instr_rd_size_s {
+		uint64_t rdsize:64;
+	} s;
+	struct cvmx_npei_pkt_instr_rd_size_s cn52xx;
+	struct cvmx_npei_pkt_instr_rd_size_s cn56xx;
+};
+
+union cvmx_npei_pkt_instr_size {
+	uint64_t u64;
+	struct cvmx_npei_pkt_instr_size_s {
+		uint64_t reserved_32_63:32;
+		uint64_t is_64b:32;
+	} s;
+	struct cvmx_npei_pkt_instr_size_s cn52xx;
+	struct cvmx_npei_pkt_instr_size_s cn56xx;
+	struct cvmx_npei_pkt_instr_size_s cn56xxp1;
+};
+
+union cvmx_npei_pkt_int_levels {
+	uint64_t u64;
+	struct cvmx_npei_pkt_int_levels_s {
+		uint64_t reserved_54_63:10;
+		uint64_t time:22;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_npei_pkt_int_levels_s cn52xx;
+	struct cvmx_npei_pkt_int_levels_s cn56xx;
+	struct cvmx_npei_pkt_int_levels_s cn56xxp1;
+};
+
+union cvmx_npei_pkt_iptr {
+	uint64_t u64;
+	struct cvmx_npei_pkt_iptr_s {
+		uint64_t reserved_32_63:32;
+		uint64_t iptr:32;
+	} s;
+	struct cvmx_npei_pkt_iptr_s cn52xx;
+	struct cvmx_npei_pkt_iptr_s cn56xx;
+	struct cvmx_npei_pkt_iptr_s cn56xxp1;
+};
+
+union cvmx_npei_pkt_out_bmode {
+	uint64_t u64;
+	struct cvmx_npei_pkt_out_bmode_s {
+		uint64_t reserved_32_63:32;
+		uint64_t bmode:32;
+	} s;
+	struct cvmx_npei_pkt_out_bmode_s cn52xx;
+	struct cvmx_npei_pkt_out_bmode_s cn56xx;
+	struct cvmx_npei_pkt_out_bmode_s cn56xxp1;
+};
+
+union cvmx_npei_pkt_out_enb {
+	uint64_t u64;
+	struct cvmx_npei_pkt_out_enb_s {
+		uint64_t reserved_32_63:32;
+		uint64_t enb:32;
+	} s;
+	struct cvmx_npei_pkt_out_enb_s cn52xx;
+	struct cvmx_npei_pkt_out_enb_s cn56xx;
+	struct cvmx_npei_pkt_out_enb_s cn56xxp1;
+};
+
+union cvmx_npei_pkt_output_wmark {
+	uint64_t u64;
+	struct cvmx_npei_pkt_output_wmark_s {
+		uint64_t reserved_32_63:32;
+		uint64_t wmark:32;
+	} s;
+	struct cvmx_npei_pkt_output_wmark_s cn52xx;
+	struct cvmx_npei_pkt_output_wmark_s cn56xx;
+};
+
+union cvmx_npei_pkt_pcie_port {
+	uint64_t u64;
+	struct cvmx_npei_pkt_pcie_port_s {
+		uint64_t pp:64;
+	} s;
+	struct cvmx_npei_pkt_pcie_port_s cn52xx;
+	struct cvmx_npei_pkt_pcie_port_s cn56xx;
+	struct cvmx_npei_pkt_pcie_port_s cn56xxp1;
+};
+
+union cvmx_npei_pkt_port_in_rst {
+	uint64_t u64;
+	struct cvmx_npei_pkt_port_in_rst_s {
+		uint64_t in_rst:32;
+		uint64_t out_rst:32;
+	} s;
+	struct cvmx_npei_pkt_port_in_rst_s cn52xx;
+	struct cvmx_npei_pkt_port_in_rst_s cn56xx;
+};
+
+union cvmx_npei_pkt_slist_es {
+	uint64_t u64;
+	struct cvmx_npei_pkt_slist_es_s {
+		uint64_t es:64;
+	} s;
+	struct cvmx_npei_pkt_slist_es_s cn52xx;
+	struct cvmx_npei_pkt_slist_es_s cn56xx;
+	struct cvmx_npei_pkt_slist_es_s cn56xxp1;
+};
+
+union cvmx_npei_pkt_slist_id_size {
+	uint64_t u64;
+	struct cvmx_npei_pkt_slist_id_size_s {
+		uint64_t reserved_23_63:41;
+		uint64_t isize:7;
+		uint64_t bsize:16;
+	} s;
+	struct cvmx_npei_pkt_slist_id_size_s cn52xx;
+	struct cvmx_npei_pkt_slist_id_size_s cn56xx;
+	struct cvmx_npei_pkt_slist_id_size_s cn56xxp1;
+};
+
+union cvmx_npei_pkt_slist_ns {
+	uint64_t u64;
+	struct cvmx_npei_pkt_slist_ns_s {
+		uint64_t reserved_32_63:32;
+		uint64_t nsr:32;
+	} s;
+	struct cvmx_npei_pkt_slist_ns_s cn52xx;
+	struct cvmx_npei_pkt_slist_ns_s cn56xx;
+	struct cvmx_npei_pkt_slist_ns_s cn56xxp1;
+};
+
+union cvmx_npei_pkt_slist_ror {
+	uint64_t u64;
+	struct cvmx_npei_pkt_slist_ror_s {
+		uint64_t reserved_32_63:32;
+		uint64_t ror:32;
+	} s;
+	struct cvmx_npei_pkt_slist_ror_s cn52xx;
+	struct cvmx_npei_pkt_slist_ror_s cn56xx;
+	struct cvmx_npei_pkt_slist_ror_s cn56xxp1;
+};
+
+union cvmx_npei_pkt_time_int {
+	uint64_t u64;
+	struct cvmx_npei_pkt_time_int_s {
+		uint64_t reserved_32_63:32;
+		uint64_t port:32;
+	} s;
+	struct cvmx_npei_pkt_time_int_s cn52xx;
+	struct cvmx_npei_pkt_time_int_s cn56xx;
+	struct cvmx_npei_pkt_time_int_s cn56xxp1;
+};
+
+union cvmx_npei_pkt_time_int_enb {
+	uint64_t u64;
+	struct cvmx_npei_pkt_time_int_enb_s {
+		uint64_t reserved_32_63:32;
+		uint64_t port:32;
+	} s;
+	struct cvmx_npei_pkt_time_int_enb_s cn52xx;
+	struct cvmx_npei_pkt_time_int_enb_s cn56xx;
+	struct cvmx_npei_pkt_time_int_enb_s cn56xxp1;
+};
+
+union cvmx_npei_rsl_int_blocks {
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
+};
+
+union cvmx_npei_scratch_1 {
+	uint64_t u64;
+	struct cvmx_npei_scratch_1_s {
+		uint64_t data:64;
+	} s;
+	struct cvmx_npei_scratch_1_s cn52xx;
+	struct cvmx_npei_scratch_1_s cn52xxp1;
+	struct cvmx_npei_scratch_1_s cn56xx;
+	struct cvmx_npei_scratch_1_s cn56xxp1;
+};
+
+union cvmx_npei_state1 {
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
+};
+
+union cvmx_npei_state2 {
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
+};
+
+union cvmx_npei_state3 {
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
+};
+
+union cvmx_npei_win_rd_addr {
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
+};
+
+union cvmx_npei_win_rd_data {
+	uint64_t u64;
+	struct cvmx_npei_win_rd_data_s {
+		uint64_t rd_data:64;
+	} s;
+	struct cvmx_npei_win_rd_data_s cn52xx;
+	struct cvmx_npei_win_rd_data_s cn52xxp1;
+	struct cvmx_npei_win_rd_data_s cn56xx;
+	struct cvmx_npei_win_rd_data_s cn56xxp1;
+};
+
+union cvmx_npei_win_wr_addr {
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
+};
+
+union cvmx_npei_win_wr_data {
+	uint64_t u64;
+	struct cvmx_npei_win_wr_data_s {
+		uint64_t wr_data:64;
+	} s;
+	struct cvmx_npei_win_wr_data_s cn52xx;
+	struct cvmx_npei_win_wr_data_s cn52xxp1;
+	struct cvmx_npei_win_wr_data_s cn56xx;
+	struct cvmx_npei_win_wr_data_s cn56xxp1;
+};
+
+union cvmx_npei_win_wr_mask {
+	uint64_t u64;
+	struct cvmx_npei_win_wr_mask_s {
+		uint64_t reserved_8_63:56;
+		uint64_t wr_mask:8;
+	} s;
+	struct cvmx_npei_win_wr_mask_s cn52xx;
+	struct cvmx_npei_win_wr_mask_s cn52xxp1;
+	struct cvmx_npei_win_wr_mask_s cn56xx;
+	struct cvmx_npei_win_wr_mask_s cn56xxp1;
+};
+
+union cvmx_npei_window_ctl {
+	uint64_t u64;
+	struct cvmx_npei_window_ctl_s {
+		uint64_t reserved_32_63:32;
+		uint64_t time:32;
+	} s;
+	struct cvmx_npei_window_ctl_s cn52xx;
+	struct cvmx_npei_window_ctl_s cn52xxp1;
+	struct cvmx_npei_window_ctl_s cn56xx;
+	struct cvmx_npei_window_ctl_s cn56xxp1;
+};
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-npi-defs.h b/arch/mips/include/asm/octeon/cvmx-npi-defs.h
new file mode 100644
index 0000000..4e03cd8
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-npi-defs.h
@@ -0,0 +1,1735 @@
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
+#ifndef __CVMX_NPI_DEFS_H__
+#define __CVMX_NPI_DEFS_H__
+
+#define CVMX_NPI_BASE_ADDR_INPUT0 \
+	 CVMX_ADD_IO_SEG(0x00011F0000000070ull)
+#define CVMX_NPI_BASE_ADDR_INPUT1 \
+	 CVMX_ADD_IO_SEG(0x00011F0000000080ull)
+#define CVMX_NPI_BASE_ADDR_INPUT2 \
+	 CVMX_ADD_IO_SEG(0x00011F0000000090ull)
+#define CVMX_NPI_BASE_ADDR_INPUT3 \
+	 CVMX_ADD_IO_SEG(0x00011F00000000A0ull)
+#define CVMX_NPI_BASE_ADDR_INPUTX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011F0000000070ull + (((offset) & 3) * 16))
+#define CVMX_NPI_BASE_ADDR_OUTPUT0 \
+	 CVMX_ADD_IO_SEG(0x00011F00000000B8ull)
+#define CVMX_NPI_BASE_ADDR_OUTPUT1 \
+	 CVMX_ADD_IO_SEG(0x00011F00000000C0ull)
+#define CVMX_NPI_BASE_ADDR_OUTPUT2 \
+	 CVMX_ADD_IO_SEG(0x00011F00000000C8ull)
+#define CVMX_NPI_BASE_ADDR_OUTPUT3 \
+	 CVMX_ADD_IO_SEG(0x00011F00000000D0ull)
+#define CVMX_NPI_BASE_ADDR_OUTPUTX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011F00000000B8ull + (((offset) & 3) * 8))
+#define CVMX_NPI_BIST_STATUS \
+	 CVMX_ADD_IO_SEG(0x00011F00000003F8ull)
+#define CVMX_NPI_BUFF_SIZE_OUTPUT0 \
+	 CVMX_ADD_IO_SEG(0x00011F00000000E0ull)
+#define CVMX_NPI_BUFF_SIZE_OUTPUT1 \
+	 CVMX_ADD_IO_SEG(0x00011F00000000E8ull)
+#define CVMX_NPI_BUFF_SIZE_OUTPUT2 \
+	 CVMX_ADD_IO_SEG(0x00011F00000000F0ull)
+#define CVMX_NPI_BUFF_SIZE_OUTPUT3 \
+	 CVMX_ADD_IO_SEG(0x00011F00000000F8ull)
+#define CVMX_NPI_BUFF_SIZE_OUTPUTX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011F00000000E0ull + (((offset) & 3) * 8))
+#define CVMX_NPI_COMP_CTL \
+	 CVMX_ADD_IO_SEG(0x00011F0000000218ull)
+#define CVMX_NPI_CTL_STATUS \
+	 CVMX_ADD_IO_SEG(0x00011F0000000010ull)
+#define CVMX_NPI_DBG_SELECT \
+	 CVMX_ADD_IO_SEG(0x00011F0000000008ull)
+#define CVMX_NPI_DMA_CONTROL \
+	 CVMX_ADD_IO_SEG(0x00011F0000000128ull)
+#define CVMX_NPI_DMA_HIGHP_COUNTS \
+	 CVMX_ADD_IO_SEG(0x00011F0000000148ull)
+#define CVMX_NPI_DMA_HIGHP_NADDR \
+	 CVMX_ADD_IO_SEG(0x00011F0000000158ull)
+#define CVMX_NPI_DMA_LOWP_COUNTS \
+	 CVMX_ADD_IO_SEG(0x00011F0000000140ull)
+#define CVMX_NPI_DMA_LOWP_NADDR \
+	 CVMX_ADD_IO_SEG(0x00011F0000000150ull)
+#define CVMX_NPI_HIGHP_DBELL \
+	 CVMX_ADD_IO_SEG(0x00011F0000000120ull)
+#define CVMX_NPI_HIGHP_IBUFF_SADDR \
+	 CVMX_ADD_IO_SEG(0x00011F0000000110ull)
+#define CVMX_NPI_INPUT_CONTROL \
+	 CVMX_ADD_IO_SEG(0x00011F0000000138ull)
+#define CVMX_NPI_INT_ENB \
+	 CVMX_ADD_IO_SEG(0x00011F0000000020ull)
+#define CVMX_NPI_INT_SUM \
+	 CVMX_ADD_IO_SEG(0x00011F0000000018ull)
+#define CVMX_NPI_LOWP_DBELL \
+	 CVMX_ADD_IO_SEG(0x00011F0000000118ull)
+#define CVMX_NPI_LOWP_IBUFF_SADDR \
+	 CVMX_ADD_IO_SEG(0x00011F0000000108ull)
+#define CVMX_NPI_MEM_ACCESS_SUBID3 \
+	 CVMX_ADD_IO_SEG(0x00011F0000000028ull)
+#define CVMX_NPI_MEM_ACCESS_SUBID4 \
+	 CVMX_ADD_IO_SEG(0x00011F0000000030ull)
+#define CVMX_NPI_MEM_ACCESS_SUBID5 \
+	 CVMX_ADD_IO_SEG(0x00011F0000000038ull)
+#define CVMX_NPI_MEM_ACCESS_SUBID6 \
+	 CVMX_ADD_IO_SEG(0x00011F0000000040ull)
+#define CVMX_NPI_MEM_ACCESS_SUBIDX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011F0000000028ull + (((offset) & 7) * 8) - 8 * 3)
+#define CVMX_NPI_MSI_RCV \
+	 (0x0000000000000190ull)
+#define CVMX_NPI_NPI_MSI_RCV \
+	 CVMX_ADD_IO_SEG(0x00011F0000001190ull)
+#define CVMX_NPI_NUM_DESC_OUTPUT0 \
+	 CVMX_ADD_IO_SEG(0x00011F0000000050ull)
+#define CVMX_NPI_NUM_DESC_OUTPUT1 \
+	 CVMX_ADD_IO_SEG(0x00011F0000000058ull)
+#define CVMX_NPI_NUM_DESC_OUTPUT2 \
+	 CVMX_ADD_IO_SEG(0x00011F0000000060ull)
+#define CVMX_NPI_NUM_DESC_OUTPUT3 \
+	 CVMX_ADD_IO_SEG(0x00011F0000000068ull)
+#define CVMX_NPI_NUM_DESC_OUTPUTX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011F0000000050ull + (((offset) & 3) * 8))
+#define CVMX_NPI_OUTPUT_CONTROL \
+	 CVMX_ADD_IO_SEG(0x00011F0000000100ull)
+#define CVMX_NPI_P0_DBPAIR_ADDR \
+	 CVMX_ADD_IO_SEG(0x00011F0000000180ull)
+#define CVMX_NPI_P0_INSTR_ADDR \
+	 CVMX_ADD_IO_SEG(0x00011F00000001C0ull)
+#define CVMX_NPI_P0_INSTR_CNTS \
+	 CVMX_ADD_IO_SEG(0x00011F00000001A0ull)
+#define CVMX_NPI_P0_PAIR_CNTS \
+	 CVMX_ADD_IO_SEG(0x00011F0000000160ull)
+#define CVMX_NPI_P1_DBPAIR_ADDR \
+	 CVMX_ADD_IO_SEG(0x00011F0000000188ull)
+#define CVMX_NPI_P1_INSTR_ADDR \
+	 CVMX_ADD_IO_SEG(0x00011F00000001C8ull)
+#define CVMX_NPI_P1_INSTR_CNTS \
+	 CVMX_ADD_IO_SEG(0x00011F00000001A8ull)
+#define CVMX_NPI_P1_PAIR_CNTS \
+	 CVMX_ADD_IO_SEG(0x00011F0000000168ull)
+#define CVMX_NPI_P2_DBPAIR_ADDR \
+	 CVMX_ADD_IO_SEG(0x00011F0000000190ull)
+#define CVMX_NPI_P2_INSTR_ADDR \
+	 CVMX_ADD_IO_SEG(0x00011F00000001D0ull)
+#define CVMX_NPI_P2_INSTR_CNTS \
+	 CVMX_ADD_IO_SEG(0x00011F00000001B0ull)
+#define CVMX_NPI_P2_PAIR_CNTS \
+	 CVMX_ADD_IO_SEG(0x00011F0000000170ull)
+#define CVMX_NPI_P3_DBPAIR_ADDR \
+	 CVMX_ADD_IO_SEG(0x00011F0000000198ull)
+#define CVMX_NPI_P3_INSTR_ADDR \
+	 CVMX_ADD_IO_SEG(0x00011F00000001D8ull)
+#define CVMX_NPI_P3_INSTR_CNTS \
+	 CVMX_ADD_IO_SEG(0x00011F00000001B8ull)
+#define CVMX_NPI_P3_PAIR_CNTS \
+	 CVMX_ADD_IO_SEG(0x00011F0000000178ull)
+#define CVMX_NPI_PCI_BAR1_INDEXX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011F0000001100ull + (((offset) & 31) * 4))
+#define CVMX_NPI_PCI_BIST_REG \
+	 CVMX_ADD_IO_SEG(0x00011F00000011C0ull)
+#define CVMX_NPI_PCI_BURST_SIZE \
+	 CVMX_ADD_IO_SEG(0x00011F00000000D8ull)
+#define CVMX_NPI_PCI_CFG00 \
+	 CVMX_ADD_IO_SEG(0x00011F0000001800ull)
+#define CVMX_NPI_PCI_CFG01 \
+	 CVMX_ADD_IO_SEG(0x00011F0000001804ull)
+#define CVMX_NPI_PCI_CFG02 \
+	 CVMX_ADD_IO_SEG(0x00011F0000001808ull)
+#define CVMX_NPI_PCI_CFG03 \
+	 CVMX_ADD_IO_SEG(0x00011F000000180Cull)
+#define CVMX_NPI_PCI_CFG04 \
+	 CVMX_ADD_IO_SEG(0x00011F0000001810ull)
+#define CVMX_NPI_PCI_CFG05 \
+	 CVMX_ADD_IO_SEG(0x00011F0000001814ull)
+#define CVMX_NPI_PCI_CFG06 \
+	 CVMX_ADD_IO_SEG(0x00011F0000001818ull)
+#define CVMX_NPI_PCI_CFG07 \
+	 CVMX_ADD_IO_SEG(0x00011F000000181Cull)
+#define CVMX_NPI_PCI_CFG08 \
+	 CVMX_ADD_IO_SEG(0x00011F0000001820ull)
+#define CVMX_NPI_PCI_CFG09 \
+	 CVMX_ADD_IO_SEG(0x00011F0000001824ull)
+#define CVMX_NPI_PCI_CFG10 \
+	 CVMX_ADD_IO_SEG(0x00011F0000001828ull)
+#define CVMX_NPI_PCI_CFG11 \
+	 CVMX_ADD_IO_SEG(0x00011F000000182Cull)
+#define CVMX_NPI_PCI_CFG12 \
+	 CVMX_ADD_IO_SEG(0x00011F0000001830ull)
+#define CVMX_NPI_PCI_CFG13 \
+	 CVMX_ADD_IO_SEG(0x00011F0000001834ull)
+#define CVMX_NPI_PCI_CFG15 \
+	 CVMX_ADD_IO_SEG(0x00011F000000183Cull)
+#define CVMX_NPI_PCI_CFG16 \
+	 CVMX_ADD_IO_SEG(0x00011F0000001840ull)
+#define CVMX_NPI_PCI_CFG17 \
+	 CVMX_ADD_IO_SEG(0x00011F0000001844ull)
+#define CVMX_NPI_PCI_CFG18 \
+	 CVMX_ADD_IO_SEG(0x00011F0000001848ull)
+#define CVMX_NPI_PCI_CFG19 \
+	 CVMX_ADD_IO_SEG(0x00011F000000184Cull)
+#define CVMX_NPI_PCI_CFG20 \
+	 CVMX_ADD_IO_SEG(0x00011F0000001850ull)
+#define CVMX_NPI_PCI_CFG21 \
+	 CVMX_ADD_IO_SEG(0x00011F0000001854ull)
+#define CVMX_NPI_PCI_CFG22 \
+	 CVMX_ADD_IO_SEG(0x00011F0000001858ull)
+#define CVMX_NPI_PCI_CFG56 \
+	 CVMX_ADD_IO_SEG(0x00011F00000018E0ull)
+#define CVMX_NPI_PCI_CFG57 \
+	 CVMX_ADD_IO_SEG(0x00011F00000018E4ull)
+#define CVMX_NPI_PCI_CFG58 \
+	 CVMX_ADD_IO_SEG(0x00011F00000018E8ull)
+#define CVMX_NPI_PCI_CFG59 \
+	 CVMX_ADD_IO_SEG(0x00011F00000018ECull)
+#define CVMX_NPI_PCI_CFG60 \
+	 CVMX_ADD_IO_SEG(0x00011F00000018F0ull)
+#define CVMX_NPI_PCI_CFG61 \
+	 CVMX_ADD_IO_SEG(0x00011F00000018F4ull)
+#define CVMX_NPI_PCI_CFG62 \
+	 CVMX_ADD_IO_SEG(0x00011F00000018F8ull)
+#define CVMX_NPI_PCI_CFG63 \
+	 CVMX_ADD_IO_SEG(0x00011F00000018FCull)
+#define CVMX_NPI_PCI_CNT_REG \
+	 CVMX_ADD_IO_SEG(0x00011F00000011B8ull)
+#define CVMX_NPI_PCI_CTL_STATUS_2 \
+	 CVMX_ADD_IO_SEG(0x00011F000000118Cull)
+#define CVMX_NPI_PCI_INT_ARB_CFG \
+	 CVMX_ADD_IO_SEG(0x00011F0000000130ull)
+#define CVMX_NPI_PCI_INT_ENB2 \
+	 CVMX_ADD_IO_SEG(0x00011F00000011A0ull)
+#define CVMX_NPI_PCI_INT_SUM2 \
+	 CVMX_ADD_IO_SEG(0x00011F0000001198ull)
+#define CVMX_NPI_PCI_READ_CMD \
+	 CVMX_ADD_IO_SEG(0x00011F0000000048ull)
+#define CVMX_NPI_PCI_READ_CMD_6 \
+	 CVMX_ADD_IO_SEG(0x00011F0000001180ull)
+#define CVMX_NPI_PCI_READ_CMD_C \
+	 CVMX_ADD_IO_SEG(0x00011F0000001184ull)
+#define CVMX_NPI_PCI_READ_CMD_E \
+	 CVMX_ADD_IO_SEG(0x00011F0000001188ull)
+#define CVMX_NPI_PCI_SCM_REG \
+	 CVMX_ADD_IO_SEG(0x00011F00000011A8ull)
+#define CVMX_NPI_PCI_TSR_REG \
+	 CVMX_ADD_IO_SEG(0x00011F00000011B0ull)
+#define CVMX_NPI_PORT32_INSTR_HDR \
+	 CVMX_ADD_IO_SEG(0x00011F00000001F8ull)
+#define CVMX_NPI_PORT33_INSTR_HDR \
+	 CVMX_ADD_IO_SEG(0x00011F0000000200ull)
+#define CVMX_NPI_PORT34_INSTR_HDR \
+	 CVMX_ADD_IO_SEG(0x00011F0000000208ull)
+#define CVMX_NPI_PORT35_INSTR_HDR \
+	 CVMX_ADD_IO_SEG(0x00011F0000000210ull)
+#define CVMX_NPI_PORT_BP_CONTROL \
+	 CVMX_ADD_IO_SEG(0x00011F00000001F0ull)
+#define CVMX_NPI_PX_DBPAIR_ADDR(offset) \
+	 CVMX_ADD_IO_SEG(0x00011F0000000180ull + (((offset) & 3) * 8))
+#define CVMX_NPI_PX_INSTR_ADDR(offset) \
+	 CVMX_ADD_IO_SEG(0x00011F00000001C0ull + (((offset) & 3) * 8))
+#define CVMX_NPI_PX_INSTR_CNTS(offset) \
+	 CVMX_ADD_IO_SEG(0x00011F00000001A0ull + (((offset) & 3) * 8))
+#define CVMX_NPI_PX_PAIR_CNTS(offset) \
+	 CVMX_ADD_IO_SEG(0x00011F0000000160ull + (((offset) & 3) * 8))
+#define CVMX_NPI_RSL_INT_BLOCKS \
+	 CVMX_ADD_IO_SEG(0x00011F0000000000ull)
+#define CVMX_NPI_SIZE_INPUT0 \
+	 CVMX_ADD_IO_SEG(0x00011F0000000078ull)
+#define CVMX_NPI_SIZE_INPUT1 \
+	 CVMX_ADD_IO_SEG(0x00011F0000000088ull)
+#define CVMX_NPI_SIZE_INPUT2 \
+	 CVMX_ADD_IO_SEG(0x00011F0000000098ull)
+#define CVMX_NPI_SIZE_INPUT3 \
+	 CVMX_ADD_IO_SEG(0x00011F00000000A8ull)
+#define CVMX_NPI_SIZE_INPUTX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011F0000000078ull + (((offset) & 3) * 16))
+#define CVMX_NPI_WIN_READ_TO \
+	 CVMX_ADD_IO_SEG(0x00011F00000001E0ull)
+
+union cvmx_npi_base_addr_inputx {
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
+};
+
+union cvmx_npi_base_addr_outputx {
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
+};
+
+union cvmx_npi_bist_status {
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
+};
+
+union cvmx_npi_buff_size_outputx {
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
+};
+
+union cvmx_npi_comp_ctl {
+	uint64_t u64;
+	struct cvmx_npi_comp_ctl_s {
+		uint64_t reserved_10_63:54;
+		uint64_t pctl:5;
+		uint64_t nctl:5;
+	} s;
+	struct cvmx_npi_comp_ctl_s cn50xx;
+	struct cvmx_npi_comp_ctl_s cn58xx;
+	struct cvmx_npi_comp_ctl_s cn58xxp1;
+};
+
+union cvmx_npi_ctl_status {
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
+};
+
+union cvmx_npi_dbg_select {
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
+};
+
+union cvmx_npi_dma_control {
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
+};
+
+union cvmx_npi_dma_highp_counts {
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
+};
+
+union cvmx_npi_dma_highp_naddr {
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
+};
+
+union cvmx_npi_dma_lowp_counts {
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
+};
+
+union cvmx_npi_dma_lowp_naddr {
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
+};
+
+union cvmx_npi_highp_dbell {
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
+};
+
+union cvmx_npi_highp_ibuff_saddr {
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
+};
+
+union cvmx_npi_input_control {
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
+};
+
+union cvmx_npi_int_enb {
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
+};
+
+union cvmx_npi_int_sum {
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
+};
+
+union cvmx_npi_lowp_dbell {
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
+};
+
+union cvmx_npi_lowp_ibuff_saddr {
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
+};
+
+union cvmx_npi_mem_access_subidx {
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
+};
+
+union cvmx_npi_msi_rcv {
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
+};
+
+union cvmx_npi_num_desc_outputx {
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
+};
+
+union cvmx_npi_output_control {
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
+};
+
+union cvmx_npi_px_dbpair_addr {
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
+};
+
+union cvmx_npi_px_instr_addr {
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
+};
+
+union cvmx_npi_px_instr_cnts {
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
+};
+
+union cvmx_npi_px_pair_cnts {
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
+};
+
+union cvmx_npi_pci_burst_size {
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
+};
+
+union cvmx_npi_pci_int_arb_cfg {
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
+};
+
+union cvmx_npi_pci_read_cmd {
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
+};
+
+union cvmx_npi_port32_instr_hdr {
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
+};
+
+union cvmx_npi_port33_instr_hdr {
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
+};
+
+union cvmx_npi_port34_instr_hdr {
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
+};
+
+union cvmx_npi_port35_instr_hdr {
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
+};
+
+union cvmx_npi_port_bp_control {
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
+};
+
+union cvmx_npi_rsl_int_blocks {
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
+};
+
+union cvmx_npi_size_inputx {
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
+};
+
+union cvmx_npi_win_read_to {
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
+};
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-pci-defs.h b/arch/mips/include/asm/octeon/cvmx-pci-defs.h
new file mode 100644
index 0000000..90f8d65
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-pci-defs.h
@@ -0,0 +1,1645 @@
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
+#ifndef __CVMX_PCI_DEFS_H__
+#define __CVMX_PCI_DEFS_H__
+
+#define CVMX_PCI_BAR1_INDEXX(offset) \
+	 (0x0000000000000100ull + (((offset) & 31) * 4))
+#define CVMX_PCI_BIST_REG \
+	 (0x00000000000001C0ull)
+#define CVMX_PCI_CFG00 \
+	 (0x0000000000000000ull)
+#define CVMX_PCI_CFG01 \
+	 (0x0000000000000004ull)
+#define CVMX_PCI_CFG02 \
+	 (0x0000000000000008ull)
+#define CVMX_PCI_CFG03 \
+	 (0x000000000000000Cull)
+#define CVMX_PCI_CFG04 \
+	 (0x0000000000000010ull)
+#define CVMX_PCI_CFG05 \
+	 (0x0000000000000014ull)
+#define CVMX_PCI_CFG06 \
+	 (0x0000000000000018ull)
+#define CVMX_PCI_CFG07 \
+	 (0x000000000000001Cull)
+#define CVMX_PCI_CFG08 \
+	 (0x0000000000000020ull)
+#define CVMX_PCI_CFG09 \
+	 (0x0000000000000024ull)
+#define CVMX_PCI_CFG10 \
+	 (0x0000000000000028ull)
+#define CVMX_PCI_CFG11 \
+	 (0x000000000000002Cull)
+#define CVMX_PCI_CFG12 \
+	 (0x0000000000000030ull)
+#define CVMX_PCI_CFG13 \
+	 (0x0000000000000034ull)
+#define CVMX_PCI_CFG15 \
+	 (0x000000000000003Cull)
+#define CVMX_PCI_CFG16 \
+	 (0x0000000000000040ull)
+#define CVMX_PCI_CFG17 \
+	 (0x0000000000000044ull)
+#define CVMX_PCI_CFG18 \
+	 (0x0000000000000048ull)
+#define CVMX_PCI_CFG19 \
+	 (0x000000000000004Cull)
+#define CVMX_PCI_CFG20 \
+	 (0x0000000000000050ull)
+#define CVMX_PCI_CFG21 \
+	 (0x0000000000000054ull)
+#define CVMX_PCI_CFG22 \
+	 (0x0000000000000058ull)
+#define CVMX_PCI_CFG56 \
+	 (0x00000000000000E0ull)
+#define CVMX_PCI_CFG57 \
+	 (0x00000000000000E4ull)
+#define CVMX_PCI_CFG58 \
+	 (0x00000000000000E8ull)
+#define CVMX_PCI_CFG59 \
+	 (0x00000000000000ECull)
+#define CVMX_PCI_CFG60 \
+	 (0x00000000000000F0ull)
+#define CVMX_PCI_CFG61 \
+	 (0x00000000000000F4ull)
+#define CVMX_PCI_CFG62 \
+	 (0x00000000000000F8ull)
+#define CVMX_PCI_CFG63 \
+	 (0x00000000000000FCull)
+#define CVMX_PCI_CNT_REG \
+	 (0x00000000000001B8ull)
+#define CVMX_PCI_CTL_STATUS_2 \
+	 (0x000000000000018Cull)
+#define CVMX_PCI_DBELL_0 \
+	 (0x0000000000000080ull)
+#define CVMX_PCI_DBELL_1 \
+	 (0x0000000000000088ull)
+#define CVMX_PCI_DBELL_2 \
+	 (0x0000000000000090ull)
+#define CVMX_PCI_DBELL_3 \
+	 (0x0000000000000098ull)
+#define CVMX_PCI_DBELL_X(offset) \
+	 (0x0000000000000080ull + (((offset) & 3) * 8))
+#define CVMX_PCI_DMA_CNT0 \
+	 (0x00000000000000A0ull)
+#define CVMX_PCI_DMA_CNT1 \
+	 (0x00000000000000A8ull)
+#define CVMX_PCI_DMA_CNTX(offset) \
+	 (0x00000000000000A0ull + (((offset) & 1) * 8))
+#define CVMX_PCI_DMA_INT_LEV0 \
+	 (0x00000000000000A4ull)
+#define CVMX_PCI_DMA_INT_LEV1 \
+	 (0x00000000000000ACull)
+#define CVMX_PCI_DMA_INT_LEVX(offset) \
+	 (0x00000000000000A4ull + (((offset) & 1) * 8))
+#define CVMX_PCI_DMA_TIME0 \
+	 (0x00000000000000B0ull)
+#define CVMX_PCI_DMA_TIME1 \
+	 (0x00000000000000B4ull)
+#define CVMX_PCI_DMA_TIMEX(offset) \
+	 (0x00000000000000B0ull + (((offset) & 1) * 4))
+#define CVMX_PCI_INSTR_COUNT0 \
+	 (0x0000000000000084ull)
+#define CVMX_PCI_INSTR_COUNT1 \
+	 (0x000000000000008Cull)
+#define CVMX_PCI_INSTR_COUNT2 \
+	 (0x0000000000000094ull)
+#define CVMX_PCI_INSTR_COUNT3 \
+	 (0x000000000000009Cull)
+#define CVMX_PCI_INSTR_COUNTX(offset) \
+	 (0x0000000000000084ull + (((offset) & 3) * 8))
+#define CVMX_PCI_INT_ENB \
+	 (0x0000000000000038ull)
+#define CVMX_PCI_INT_ENB2 \
+	 (0x00000000000001A0ull)
+#define CVMX_PCI_INT_SUM \
+	 (0x0000000000000030ull)
+#define CVMX_PCI_INT_SUM2 \
+	 (0x0000000000000198ull)
+#define CVMX_PCI_MSI_RCV \
+	 (0x00000000000000F0ull)
+#define CVMX_PCI_PKTS_SENT0 \
+	 (0x0000000000000040ull)
+#define CVMX_PCI_PKTS_SENT1 \
+	 (0x0000000000000050ull)
+#define CVMX_PCI_PKTS_SENT2 \
+	 (0x0000000000000060ull)
+#define CVMX_PCI_PKTS_SENT3 \
+	 (0x0000000000000070ull)
+#define CVMX_PCI_PKTS_SENTX(offset) \
+	 (0x0000000000000040ull + (((offset) & 3) * 16))
+#define CVMX_PCI_PKTS_SENT_INT_LEV0 \
+	 (0x0000000000000048ull)
+#define CVMX_PCI_PKTS_SENT_INT_LEV1 \
+	 (0x0000000000000058ull)
+#define CVMX_PCI_PKTS_SENT_INT_LEV2 \
+	 (0x0000000000000068ull)
+#define CVMX_PCI_PKTS_SENT_INT_LEV3 \
+	 (0x0000000000000078ull)
+#define CVMX_PCI_PKTS_SENT_INT_LEVX(offset) \
+	 (0x0000000000000048ull + (((offset) & 3) * 16))
+#define CVMX_PCI_PKTS_SENT_TIME0 \
+	 (0x000000000000004Cull)
+#define CVMX_PCI_PKTS_SENT_TIME1 \
+	 (0x000000000000005Cull)
+#define CVMX_PCI_PKTS_SENT_TIME2 \
+	 (0x000000000000006Cull)
+#define CVMX_PCI_PKTS_SENT_TIME3 \
+	 (0x000000000000007Cull)
+#define CVMX_PCI_PKTS_SENT_TIMEX(offset) \
+	 (0x000000000000004Cull + (((offset) & 3) * 16))
+#define CVMX_PCI_PKT_CREDITS0 \
+	 (0x0000000000000044ull)
+#define CVMX_PCI_PKT_CREDITS1 \
+	 (0x0000000000000054ull)
+#define CVMX_PCI_PKT_CREDITS2 \
+	 (0x0000000000000064ull)
+#define CVMX_PCI_PKT_CREDITS3 \
+	 (0x0000000000000074ull)
+#define CVMX_PCI_PKT_CREDITSX(offset) \
+	 (0x0000000000000044ull + (((offset) & 3) * 16))
+#define CVMX_PCI_READ_CMD_6 \
+	 (0x0000000000000180ull)
+#define CVMX_PCI_READ_CMD_C \
+	 (0x0000000000000184ull)
+#define CVMX_PCI_READ_CMD_E \
+	 (0x0000000000000188ull)
+#define CVMX_PCI_READ_TIMEOUT \
+	 CVMX_ADD_IO_SEG(0x00011F00000000B0ull)
+#define CVMX_PCI_SCM_REG \
+	 (0x00000000000001A8ull)
+#define CVMX_PCI_TSR_REG \
+	 (0x00000000000001B0ull)
+#define CVMX_PCI_WIN_RD_ADDR \
+	 (0x0000000000000008ull)
+#define CVMX_PCI_WIN_RD_DATA \
+	 (0x0000000000000020ull)
+#define CVMX_PCI_WIN_WR_ADDR \
+	 (0x0000000000000000ull)
+#define CVMX_PCI_WIN_WR_DATA \
+	 (0x0000000000000010ull)
+#define CVMX_PCI_WIN_WR_MASK \
+	 (0x0000000000000018ull)
+
+union cvmx_pci_bar1_indexx {
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
+};
+
+union cvmx_pci_bist_reg {
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
+};
+
+union cvmx_pci_cfg00 {
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
+};
+
+union cvmx_pci_cfg01 {
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
+};
+
+union cvmx_pci_cfg02 {
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
+};
+
+union cvmx_pci_cfg03 {
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
+};
+
+union cvmx_pci_cfg04 {
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
+};
+
+union cvmx_pci_cfg05 {
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
+};
+
+union cvmx_pci_cfg06 {
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
+};
+
+union cvmx_pci_cfg07 {
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
+};
+
+union cvmx_pci_cfg08 {
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
+};
+
+union cvmx_pci_cfg09 {
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
+};
+
+union cvmx_pci_cfg10 {
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
+};
+
+union cvmx_pci_cfg11 {
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
+};
+
+union cvmx_pci_cfg12 {
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
+};
+
+union cvmx_pci_cfg13 {
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
+};
+
+union cvmx_pci_cfg15 {
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
+};
+
+union cvmx_pci_cfg16 {
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
+};
+
+union cvmx_pci_cfg17 {
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
+};
+
+union cvmx_pci_cfg18 {
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
+};
+
+union cvmx_pci_cfg19 {
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
+};
+
+union cvmx_pci_cfg20 {
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
+};
+
+union cvmx_pci_cfg21 {
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
+};
+
+union cvmx_pci_cfg22 {
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
+};
+
+union cvmx_pci_cfg56 {
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
+};
+
+union cvmx_pci_cfg57 {
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
+};
+
+union cvmx_pci_cfg58 {
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
+};
+
+union cvmx_pci_cfg59 {
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
+};
+
+union cvmx_pci_cfg60 {
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
+};
+
+union cvmx_pci_cfg61 {
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
+};
+
+union cvmx_pci_cfg62 {
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
+};
+
+union cvmx_pci_cfg63 {
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
+};
+
+union cvmx_pci_cnt_reg {
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
+};
+
+union cvmx_pci_ctl_status_2 {
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
+};
+
+union cvmx_pci_dbellx {
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
+};
+
+union cvmx_pci_dma_cntx {
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
+};
+
+union cvmx_pci_dma_int_levx {
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
+};
+
+union cvmx_pci_dma_timex {
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
+};
+
+union cvmx_pci_instr_countx {
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
+};
+
+union cvmx_pci_int_enb {
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
+};
+
+union cvmx_pci_int_enb2 {
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
+};
+
+union cvmx_pci_int_sum {
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
+};
+
+union cvmx_pci_int_sum2 {
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
+};
+
+union cvmx_pci_msi_rcv {
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
+};
+
+union cvmx_pci_pkt_creditsx {
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
+};
+
+union cvmx_pci_pkts_sentx {
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
+};
+
+union cvmx_pci_pkts_sent_int_levx {
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
+};
+
+union cvmx_pci_pkts_sent_timex {
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
+};
+
+union cvmx_pci_read_cmd_6 {
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
+};
+
+union cvmx_pci_read_cmd_c {
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
+};
+
+union cvmx_pci_read_cmd_e {
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
+};
+
+union cvmx_pci_read_timeout {
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
+};
+
+union cvmx_pci_scm_reg {
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
+};
+
+union cvmx_pci_tsr_reg {
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
+};
+
+union cvmx_pci_win_rd_addr {
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
+};
+
+union cvmx_pci_win_rd_data {
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
+};
+
+union cvmx_pci_win_wr_addr {
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
+};
+
+union cvmx_pci_win_wr_data {
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
+};
+
+union cvmx_pci_win_wr_mask {
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
+};
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-pcieep-defs.h b/arch/mips/include/asm/octeon/cvmx-pcieep-defs.h
new file mode 100644
index 0000000..d553f8e
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-pcieep-defs.h
@@ -0,0 +1,1365 @@
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
+#ifndef __CVMX_PCIEEP_DEFS_H__
+#define __CVMX_PCIEEP_DEFS_H__
+
+#define CVMX_PCIEEP_CFG000 \
+	 (0x0000000000000000ull)
+#define CVMX_PCIEEP_CFG001 \
+	 (0x0000000000000004ull)
+#define CVMX_PCIEEP_CFG002 \
+	 (0x0000000000000008ull)
+#define CVMX_PCIEEP_CFG003 \
+	 (0x000000000000000Cull)
+#define CVMX_PCIEEP_CFG004 \
+	 (0x0000000000000010ull)
+#define CVMX_PCIEEP_CFG004_MASK \
+	 (0x0000000080000010ull)
+#define CVMX_PCIEEP_CFG005 \
+	 (0x0000000000000014ull)
+#define CVMX_PCIEEP_CFG005_MASK \
+	 (0x0000000080000014ull)
+#define CVMX_PCIEEP_CFG006 \
+	 (0x0000000000000018ull)
+#define CVMX_PCIEEP_CFG006_MASK \
+	 (0x0000000080000018ull)
+#define CVMX_PCIEEP_CFG007 \
+	 (0x000000000000001Cull)
+#define CVMX_PCIEEP_CFG007_MASK \
+	 (0x000000008000001Cull)
+#define CVMX_PCIEEP_CFG008 \
+	 (0x0000000000000020ull)
+#define CVMX_PCIEEP_CFG008_MASK \
+	 (0x0000000080000020ull)
+#define CVMX_PCIEEP_CFG009 \
+	 (0x0000000000000024ull)
+#define CVMX_PCIEEP_CFG009_MASK \
+	 (0x0000000080000024ull)
+#define CVMX_PCIEEP_CFG010 \
+	 (0x0000000000000028ull)
+#define CVMX_PCIEEP_CFG011 \
+	 (0x000000000000002Cull)
+#define CVMX_PCIEEP_CFG012 \
+	 (0x0000000000000030ull)
+#define CVMX_PCIEEP_CFG012_MASK \
+	 (0x0000000080000030ull)
+#define CVMX_PCIEEP_CFG013 \
+	 (0x0000000000000034ull)
+#define CVMX_PCIEEP_CFG015 \
+	 (0x000000000000003Cull)
+#define CVMX_PCIEEP_CFG016 \
+	 (0x0000000000000040ull)
+#define CVMX_PCIEEP_CFG017 \
+	 (0x0000000000000044ull)
+#define CVMX_PCIEEP_CFG020 \
+	 (0x0000000000000050ull)
+#define CVMX_PCIEEP_CFG021 \
+	 (0x0000000000000054ull)
+#define CVMX_PCIEEP_CFG022 \
+	 (0x0000000000000058ull)
+#define CVMX_PCIEEP_CFG023 \
+	 (0x000000000000005Cull)
+#define CVMX_PCIEEP_CFG028 \
+	 (0x0000000000000070ull)
+#define CVMX_PCIEEP_CFG029 \
+	 (0x0000000000000074ull)
+#define CVMX_PCIEEP_CFG030 \
+	 (0x0000000000000078ull)
+#define CVMX_PCIEEP_CFG031 \
+	 (0x000000000000007Cull)
+#define CVMX_PCIEEP_CFG032 \
+	 (0x0000000000000080ull)
+#define CVMX_PCIEEP_CFG033 \
+	 (0x0000000000000084ull)
+#define CVMX_PCIEEP_CFG034 \
+	 (0x0000000000000088ull)
+#define CVMX_PCIEEP_CFG037 \
+	 (0x0000000000000094ull)
+#define CVMX_PCIEEP_CFG038 \
+	 (0x0000000000000098ull)
+#define CVMX_PCIEEP_CFG039 \
+	 (0x000000000000009Cull)
+#define CVMX_PCIEEP_CFG040 \
+	 (0x00000000000000A0ull)
+#define CVMX_PCIEEP_CFG041 \
+	 (0x00000000000000A4ull)
+#define CVMX_PCIEEP_CFG042 \
+	 (0x00000000000000A8ull)
+#define CVMX_PCIEEP_CFG064 \
+	 (0x0000000000000100ull)
+#define CVMX_PCIEEP_CFG065 \
+	 (0x0000000000000104ull)
+#define CVMX_PCIEEP_CFG066 \
+	 (0x0000000000000108ull)
+#define CVMX_PCIEEP_CFG067 \
+	 (0x000000000000010Cull)
+#define CVMX_PCIEEP_CFG068 \
+	 (0x0000000000000110ull)
+#define CVMX_PCIEEP_CFG069 \
+	 (0x0000000000000114ull)
+#define CVMX_PCIEEP_CFG070 \
+	 (0x0000000000000118ull)
+#define CVMX_PCIEEP_CFG071 \
+	 (0x000000000000011Cull)
+#define CVMX_PCIEEP_CFG072 \
+	 (0x0000000000000120ull)
+#define CVMX_PCIEEP_CFG073 \
+	 (0x0000000000000124ull)
+#define CVMX_PCIEEP_CFG074 \
+	 (0x0000000000000128ull)
+#define CVMX_PCIEEP_CFG448 \
+	 (0x0000000000000700ull)
+#define CVMX_PCIEEP_CFG449 \
+	 (0x0000000000000704ull)
+#define CVMX_PCIEEP_CFG450 \
+	 (0x0000000000000708ull)
+#define CVMX_PCIEEP_CFG451 \
+	 (0x000000000000070Cull)
+#define CVMX_PCIEEP_CFG452 \
+	 (0x0000000000000710ull)
+#define CVMX_PCIEEP_CFG453 \
+	 (0x0000000000000714ull)
+#define CVMX_PCIEEP_CFG454 \
+	 (0x0000000000000718ull)
+#define CVMX_PCIEEP_CFG455 \
+	 (0x000000000000071Cull)
+#define CVMX_PCIEEP_CFG456 \
+	 (0x0000000000000720ull)
+#define CVMX_PCIEEP_CFG458 \
+	 (0x0000000000000728ull)
+#define CVMX_PCIEEP_CFG459 \
+	 (0x000000000000072Cull)
+#define CVMX_PCIEEP_CFG460 \
+	 (0x0000000000000730ull)
+#define CVMX_PCIEEP_CFG461 \
+	 (0x0000000000000734ull)
+#define CVMX_PCIEEP_CFG462 \
+	 (0x0000000000000738ull)
+#define CVMX_PCIEEP_CFG463 \
+	 (0x000000000000073Cull)
+#define CVMX_PCIEEP_CFG464 \
+	 (0x0000000000000740ull)
+#define CVMX_PCIEEP_CFG465 \
+	 (0x0000000000000744ull)
+#define CVMX_PCIEEP_CFG466 \
+	 (0x0000000000000748ull)
+#define CVMX_PCIEEP_CFG467 \
+	 (0x000000000000074Cull)
+#define CVMX_PCIEEP_CFG468 \
+	 (0x0000000000000750ull)
+#define CVMX_PCIEEP_CFG490 \
+	 (0x00000000000007A8ull)
+#define CVMX_PCIEEP_CFG491 \
+	 (0x00000000000007ACull)
+#define CVMX_PCIEEP_CFG492 \
+	 (0x00000000000007B0ull)
+#define CVMX_PCIEEP_CFG516 \
+	 (0x0000000000000810ull)
+#define CVMX_PCIEEP_CFG517 \
+	 (0x0000000000000814ull)
+
+union cvmx_pcieep_cfg000 {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg000_s {
+		uint32_t devid:16;
+		uint32_t vendid:16;
+	} s;
+	struct cvmx_pcieep_cfg000_s cn52xx;
+	struct cvmx_pcieep_cfg000_s cn52xxp1;
+	struct cvmx_pcieep_cfg000_s cn56xx;
+	struct cvmx_pcieep_cfg000_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg001 {
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
+};
+
+union cvmx_pcieep_cfg002 {
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
+};
+
+union cvmx_pcieep_cfg003 {
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
+};
+
+union cvmx_pcieep_cfg004 {
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
+};
+
+union cvmx_pcieep_cfg004_mask {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg004_mask_s {
+		uint32_t lmask:31;
+		uint32_t enb:1;
+	} s;
+	struct cvmx_pcieep_cfg004_mask_s cn52xx;
+	struct cvmx_pcieep_cfg004_mask_s cn52xxp1;
+	struct cvmx_pcieep_cfg004_mask_s cn56xx;
+	struct cvmx_pcieep_cfg004_mask_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg005 {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg005_s {
+		uint32_t ubab:32;
+	} s;
+	struct cvmx_pcieep_cfg005_s cn52xx;
+	struct cvmx_pcieep_cfg005_s cn52xxp1;
+	struct cvmx_pcieep_cfg005_s cn56xx;
+	struct cvmx_pcieep_cfg005_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg005_mask {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg005_mask_s {
+		uint32_t umask:32;
+	} s;
+	struct cvmx_pcieep_cfg005_mask_s cn52xx;
+	struct cvmx_pcieep_cfg005_mask_s cn52xxp1;
+	struct cvmx_pcieep_cfg005_mask_s cn56xx;
+	struct cvmx_pcieep_cfg005_mask_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg006 {
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
+};
+
+union cvmx_pcieep_cfg006_mask {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg006_mask_s {
+		uint32_t lmask:31;
+		uint32_t enb:1;
+	} s;
+	struct cvmx_pcieep_cfg006_mask_s cn52xx;
+	struct cvmx_pcieep_cfg006_mask_s cn52xxp1;
+	struct cvmx_pcieep_cfg006_mask_s cn56xx;
+	struct cvmx_pcieep_cfg006_mask_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg007 {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg007_s {
+		uint32_t ubab:32;
+	} s;
+	struct cvmx_pcieep_cfg007_s cn52xx;
+	struct cvmx_pcieep_cfg007_s cn52xxp1;
+	struct cvmx_pcieep_cfg007_s cn56xx;
+	struct cvmx_pcieep_cfg007_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg007_mask {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg007_mask_s {
+		uint32_t umask:32;
+	} s;
+	struct cvmx_pcieep_cfg007_mask_s cn52xx;
+	struct cvmx_pcieep_cfg007_mask_s cn52xxp1;
+	struct cvmx_pcieep_cfg007_mask_s cn56xx;
+	struct cvmx_pcieep_cfg007_mask_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg008 {
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
+};
+
+union cvmx_pcieep_cfg008_mask {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg008_mask_s {
+		uint32_t lmask:31;
+		uint32_t enb:1;
+	} s;
+	struct cvmx_pcieep_cfg008_mask_s cn52xx;
+	struct cvmx_pcieep_cfg008_mask_s cn52xxp1;
+	struct cvmx_pcieep_cfg008_mask_s cn56xx;
+	struct cvmx_pcieep_cfg008_mask_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg009 {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg009_s {
+		uint32_t ubab:25;
+		uint32_t reserved_0_6:7;
+	} s;
+	struct cvmx_pcieep_cfg009_s cn52xx;
+	struct cvmx_pcieep_cfg009_s cn52xxp1;
+	struct cvmx_pcieep_cfg009_s cn56xx;
+	struct cvmx_pcieep_cfg009_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg009_mask {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg009_mask_s {
+		uint32_t umask:32;
+	} s;
+	struct cvmx_pcieep_cfg009_mask_s cn52xx;
+	struct cvmx_pcieep_cfg009_mask_s cn52xxp1;
+	struct cvmx_pcieep_cfg009_mask_s cn56xx;
+	struct cvmx_pcieep_cfg009_mask_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg010 {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg010_s {
+		uint32_t cisp:32;
+	} s;
+	struct cvmx_pcieep_cfg010_s cn52xx;
+	struct cvmx_pcieep_cfg010_s cn52xxp1;
+	struct cvmx_pcieep_cfg010_s cn56xx;
+	struct cvmx_pcieep_cfg010_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg011 {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg011_s {
+		uint32_t ssid:16;
+		uint32_t ssvid:16;
+	} s;
+	struct cvmx_pcieep_cfg011_s cn52xx;
+	struct cvmx_pcieep_cfg011_s cn52xxp1;
+	struct cvmx_pcieep_cfg011_s cn56xx;
+	struct cvmx_pcieep_cfg011_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg012 {
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
+};
+
+union cvmx_pcieep_cfg012_mask {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg012_mask_s {
+		uint32_t mask:31;
+		uint32_t enb:1;
+	} s;
+	struct cvmx_pcieep_cfg012_mask_s cn52xx;
+	struct cvmx_pcieep_cfg012_mask_s cn52xxp1;
+	struct cvmx_pcieep_cfg012_mask_s cn56xx;
+	struct cvmx_pcieep_cfg012_mask_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg013 {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg013_s {
+		uint32_t reserved_8_31:24;
+		uint32_t cp:8;
+	} s;
+	struct cvmx_pcieep_cfg013_s cn52xx;
+	struct cvmx_pcieep_cfg013_s cn52xxp1;
+	struct cvmx_pcieep_cfg013_s cn56xx;
+	struct cvmx_pcieep_cfg013_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg015 {
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
+};
+
+union cvmx_pcieep_cfg016 {
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
+};
+
+union cvmx_pcieep_cfg017 {
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
+};
+
+union cvmx_pcieep_cfg020 {
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
+};
+
+union cvmx_pcieep_cfg021 {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg021_s {
+		uint32_t lmsi:30;
+		uint32_t reserved_0_1:2;
+	} s;
+	struct cvmx_pcieep_cfg021_s cn52xx;
+	struct cvmx_pcieep_cfg021_s cn52xxp1;
+	struct cvmx_pcieep_cfg021_s cn56xx;
+	struct cvmx_pcieep_cfg021_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg022 {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg022_s {
+		uint32_t umsi:32;
+	} s;
+	struct cvmx_pcieep_cfg022_s cn52xx;
+	struct cvmx_pcieep_cfg022_s cn52xxp1;
+	struct cvmx_pcieep_cfg022_s cn56xx;
+	struct cvmx_pcieep_cfg022_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg023 {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg023_s {
+		uint32_t reserved_16_31:16;
+		uint32_t msimd:16;
+	} s;
+	struct cvmx_pcieep_cfg023_s cn52xx;
+	struct cvmx_pcieep_cfg023_s cn52xxp1;
+	struct cvmx_pcieep_cfg023_s cn56xx;
+	struct cvmx_pcieep_cfg023_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg028 {
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
+};
+
+union cvmx_pcieep_cfg029 {
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
+};
+
+union cvmx_pcieep_cfg030 {
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
+};
+
+union cvmx_pcieep_cfg031 {
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
+};
+
+union cvmx_pcieep_cfg032 {
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
+};
+
+union cvmx_pcieep_cfg033 {
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
+};
+
+union cvmx_pcieep_cfg034 {
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
+};
+
+union cvmx_pcieep_cfg037 {
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
+};
+
+union cvmx_pcieep_cfg038 {
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
+};
+
+union cvmx_pcieep_cfg039 {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg039_s {
+		uint32_t reserved_0_31:32;
+	} s;
+	struct cvmx_pcieep_cfg039_s cn52xx;
+	struct cvmx_pcieep_cfg039_s cn52xxp1;
+	struct cvmx_pcieep_cfg039_s cn56xx;
+	struct cvmx_pcieep_cfg039_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg040 {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg040_s {
+		uint32_t reserved_0_31:32;
+	} s;
+	struct cvmx_pcieep_cfg040_s cn52xx;
+	struct cvmx_pcieep_cfg040_s cn52xxp1;
+	struct cvmx_pcieep_cfg040_s cn56xx;
+	struct cvmx_pcieep_cfg040_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg041 {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg041_s {
+		uint32_t reserved_0_31:32;
+	} s;
+	struct cvmx_pcieep_cfg041_s cn52xx;
+	struct cvmx_pcieep_cfg041_s cn52xxp1;
+	struct cvmx_pcieep_cfg041_s cn56xx;
+	struct cvmx_pcieep_cfg041_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg042 {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg042_s {
+		uint32_t reserved_0_31:32;
+	} s;
+	struct cvmx_pcieep_cfg042_s cn52xx;
+	struct cvmx_pcieep_cfg042_s cn52xxp1;
+	struct cvmx_pcieep_cfg042_s cn56xx;
+	struct cvmx_pcieep_cfg042_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg064 {
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
+};
+
+union cvmx_pcieep_cfg065 {
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
+};
+
+union cvmx_pcieep_cfg066 {
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
+};
+
+union cvmx_pcieep_cfg067 {
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
+};
+
+union cvmx_pcieep_cfg068 {
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
+};
+
+union cvmx_pcieep_cfg069 {
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
+};
+
+union cvmx_pcieep_cfg070 {
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
+};
+
+union cvmx_pcieep_cfg071 {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg071_s {
+		uint32_t dword1:32;
+	} s;
+	struct cvmx_pcieep_cfg071_s cn52xx;
+	struct cvmx_pcieep_cfg071_s cn52xxp1;
+	struct cvmx_pcieep_cfg071_s cn56xx;
+	struct cvmx_pcieep_cfg071_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg072 {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg072_s {
+		uint32_t dword2:32;
+	} s;
+	struct cvmx_pcieep_cfg072_s cn52xx;
+	struct cvmx_pcieep_cfg072_s cn52xxp1;
+	struct cvmx_pcieep_cfg072_s cn56xx;
+	struct cvmx_pcieep_cfg072_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg073 {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg073_s {
+		uint32_t dword3:32;
+	} s;
+	struct cvmx_pcieep_cfg073_s cn52xx;
+	struct cvmx_pcieep_cfg073_s cn52xxp1;
+	struct cvmx_pcieep_cfg073_s cn56xx;
+	struct cvmx_pcieep_cfg073_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg074 {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg074_s {
+		uint32_t dword4:32;
+	} s;
+	struct cvmx_pcieep_cfg074_s cn52xx;
+	struct cvmx_pcieep_cfg074_s cn52xxp1;
+	struct cvmx_pcieep_cfg074_s cn56xx;
+	struct cvmx_pcieep_cfg074_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg448 {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg448_s {
+		uint32_t rtl:16;
+		uint32_t rtltl:16;
+	} s;
+	struct cvmx_pcieep_cfg448_s cn52xx;
+	struct cvmx_pcieep_cfg448_s cn52xxp1;
+	struct cvmx_pcieep_cfg448_s cn56xx;
+	struct cvmx_pcieep_cfg448_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg449 {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg449_s {
+		uint32_t omr:32;
+	} s;
+	struct cvmx_pcieep_cfg449_s cn52xx;
+	struct cvmx_pcieep_cfg449_s cn52xxp1;
+	struct cvmx_pcieep_cfg449_s cn56xx;
+	struct cvmx_pcieep_cfg449_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg450 {
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
+};
+
+union cvmx_pcieep_cfg451 {
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
+};
+
+union cvmx_pcieep_cfg452 {
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
+};
+
+union cvmx_pcieep_cfg453 {
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
+};
+
+union cvmx_pcieep_cfg454 {
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
+};
+
+union cvmx_pcieep_cfg455 {
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
+};
+
+union cvmx_pcieep_cfg456 {
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
+};
+
+union cvmx_pcieep_cfg458 {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg458_s {
+		uint32_t dbg_info_l32:32;
+	} s;
+	struct cvmx_pcieep_cfg458_s cn52xx;
+	struct cvmx_pcieep_cfg458_s cn52xxp1;
+	struct cvmx_pcieep_cfg458_s cn56xx;
+	struct cvmx_pcieep_cfg458_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg459 {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg459_s {
+		uint32_t dbg_info_u32:32;
+	} s;
+	struct cvmx_pcieep_cfg459_s cn52xx;
+	struct cvmx_pcieep_cfg459_s cn52xxp1;
+	struct cvmx_pcieep_cfg459_s cn56xx;
+	struct cvmx_pcieep_cfg459_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg460 {
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
+};
+
+union cvmx_pcieep_cfg461 {
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
+};
+
+union cvmx_pcieep_cfg462 {
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
+};
+
+union cvmx_pcieep_cfg463 {
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
+};
+
+union cvmx_pcieep_cfg464 {
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
+};
+
+union cvmx_pcieep_cfg465 {
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
+};
+
+union cvmx_pcieep_cfg466 {
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
+};
+
+union cvmx_pcieep_cfg467 {
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
+};
+
+union cvmx_pcieep_cfg468 {
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
+};
+
+union cvmx_pcieep_cfg490 {
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
+};
+
+union cvmx_pcieep_cfg491 {
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
+};
+
+union cvmx_pcieep_cfg492 {
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
+};
+
+union cvmx_pcieep_cfg516 {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg516_s {
+		uint32_t phy_stat:32;
+	} s;
+	struct cvmx_pcieep_cfg516_s cn52xx;
+	struct cvmx_pcieep_cfg516_s cn52xxp1;
+	struct cvmx_pcieep_cfg516_s cn56xx;
+	struct cvmx_pcieep_cfg516_s cn56xxp1;
+};
+
+union cvmx_pcieep_cfg517 {
+	uint32_t u32;
+	struct cvmx_pcieep_cfg517_s {
+		uint32_t phy_ctrl:32;
+	} s;
+	struct cvmx_pcieep_cfg517_s cn52xx;
+	struct cvmx_pcieep_cfg517_s cn52xxp1;
+	struct cvmx_pcieep_cfg517_s cn56xx;
+	struct cvmx_pcieep_cfg517_s cn56xxp1;
+};
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-pciercx-defs.h b/arch/mips/include/asm/octeon/cvmx-pciercx-defs.h
new file mode 100644
index 0000000..75574c9
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-pciercx-defs.h
@@ -0,0 +1,1397 @@
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
+#ifndef __CVMX_PCIERCX_DEFS_H__
+#define __CVMX_PCIERCX_DEFS_H__
+
+#define CVMX_PCIERCX_CFG000(offset) \
+	 (0x0000000000000000ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG001(offset) \
+	 (0x0000000000000004ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG002(offset) \
+	 (0x0000000000000008ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG003(offset) \
+	 (0x000000000000000Cull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG004(offset) \
+	 (0x0000000000000010ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG005(offset) \
+	 (0x0000000000000014ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG006(offset) \
+	 (0x0000000000000018ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG007(offset) \
+	 (0x000000000000001Cull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG008(offset) \
+	 (0x0000000000000020ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG009(offset) \
+	 (0x0000000000000024ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG010(offset) \
+	 (0x0000000000000028ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG011(offset) \
+	 (0x000000000000002Cull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG012(offset) \
+	 (0x0000000000000030ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG013(offset) \
+	 (0x0000000000000034ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG014(offset) \
+	 (0x0000000000000038ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG015(offset) \
+	 (0x000000000000003Cull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG016(offset) \
+	 (0x0000000000000040ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG017(offset) \
+	 (0x0000000000000044ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG020(offset) \
+	 (0x0000000000000050ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG021(offset) \
+	 (0x0000000000000054ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG022(offset) \
+	 (0x0000000000000058ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG023(offset) \
+	 (0x000000000000005Cull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG028(offset) \
+	 (0x0000000000000070ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG029(offset) \
+	 (0x0000000000000074ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG030(offset) \
+	 (0x0000000000000078ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG031(offset) \
+	 (0x000000000000007Cull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG032(offset) \
+	 (0x0000000000000080ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG033(offset) \
+	 (0x0000000000000084ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG034(offset) \
+	 (0x0000000000000088ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG035(offset) \
+	 (0x000000000000008Cull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG036(offset) \
+	 (0x0000000000000090ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG037(offset) \
+	 (0x0000000000000094ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG038(offset) \
+	 (0x0000000000000098ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG039(offset) \
+	 (0x000000000000009Cull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG040(offset) \
+	 (0x00000000000000A0ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG041(offset) \
+	 (0x00000000000000A4ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG042(offset) \
+	 (0x00000000000000A8ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG064(offset) \
+	 (0x0000000000000100ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG065(offset) \
+	 (0x0000000000000104ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG066(offset) \
+	 (0x0000000000000108ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG067(offset) \
+	 (0x000000000000010Cull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG068(offset) \
+	 (0x0000000000000110ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG069(offset) \
+	 (0x0000000000000114ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG070(offset) \
+	 (0x0000000000000118ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG071(offset) \
+	 (0x000000000000011Cull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG072(offset) \
+	 (0x0000000000000120ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG073(offset) \
+	 (0x0000000000000124ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG074(offset) \
+	 (0x0000000000000128ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG075(offset) \
+	 (0x000000000000012Cull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG076(offset) \
+	 (0x0000000000000130ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG077(offset) \
+	 (0x0000000000000134ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG448(offset) \
+	 (0x0000000000000700ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG449(offset) \
+	 (0x0000000000000704ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG450(offset) \
+	 (0x0000000000000708ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG451(offset) \
+	 (0x000000000000070Cull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG452(offset) \
+	 (0x0000000000000710ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG453(offset) \
+	 (0x0000000000000714ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG454(offset) \
+	 (0x0000000000000718ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG455(offset) \
+	 (0x000000000000071Cull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG456(offset) \
+	 (0x0000000000000720ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG458(offset) \
+	 (0x0000000000000728ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG459(offset) \
+	 (0x000000000000072Cull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG460(offset) \
+	 (0x0000000000000730ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG461(offset) \
+	 (0x0000000000000734ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG462(offset) \
+	 (0x0000000000000738ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG463(offset) \
+	 (0x000000000000073Cull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG464(offset) \
+	 (0x0000000000000740ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG465(offset) \
+	 (0x0000000000000744ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG466(offset) \
+	 (0x0000000000000748ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG467(offset) \
+	 (0x000000000000074Cull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG468(offset) \
+	 (0x0000000000000750ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG490(offset) \
+	 (0x00000000000007A8ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG491(offset) \
+	 (0x00000000000007ACull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG492(offset) \
+	 (0x00000000000007B0ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG516(offset) \
+	 (0x0000000000000810ull + (((offset) & 1) * 0))
+#define CVMX_PCIERCX_CFG517(offset) \
+	 (0x0000000000000814ull + (((offset) & 1) * 0))
+
+union cvmx_pciercx_cfg000 {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg000_s {
+		uint32_t devid:16;
+		uint32_t vendid:16;
+	} s;
+	struct cvmx_pciercx_cfg000_s cn52xx;
+	struct cvmx_pciercx_cfg000_s cn52xxp1;
+	struct cvmx_pciercx_cfg000_s cn56xx;
+	struct cvmx_pciercx_cfg000_s cn56xxp1;
+};
+
+union cvmx_pciercx_cfg001 {
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
+};
+
+union cvmx_pciercx_cfg002 {
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
+};
+
+union cvmx_pciercx_cfg003 {
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
+};
+
+union cvmx_pciercx_cfg004 {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg004_s {
+		uint32_t reserved_0_31:32;
+	} s;
+	struct cvmx_pciercx_cfg004_s cn52xx;
+	struct cvmx_pciercx_cfg004_s cn52xxp1;
+	struct cvmx_pciercx_cfg004_s cn56xx;
+	struct cvmx_pciercx_cfg004_s cn56xxp1;
+};
+
+union cvmx_pciercx_cfg005 {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg005_s {
+		uint32_t reserved_0_31:32;
+	} s;
+	struct cvmx_pciercx_cfg005_s cn52xx;
+	struct cvmx_pciercx_cfg005_s cn52xxp1;
+	struct cvmx_pciercx_cfg005_s cn56xx;
+	struct cvmx_pciercx_cfg005_s cn56xxp1;
+};
+
+union cvmx_pciercx_cfg006 {
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
+};
+
+union cvmx_pciercx_cfg007 {
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
+};
+
+union cvmx_pciercx_cfg008 {
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
+};
+
+union cvmx_pciercx_cfg009 {
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
+};
+
+union cvmx_pciercx_cfg010 {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg010_s {
+		uint32_t umem_base:32;
+	} s;
+	struct cvmx_pciercx_cfg010_s cn52xx;
+	struct cvmx_pciercx_cfg010_s cn52xxp1;
+	struct cvmx_pciercx_cfg010_s cn56xx;
+	struct cvmx_pciercx_cfg010_s cn56xxp1;
+};
+
+union cvmx_pciercx_cfg011 {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg011_s {
+		uint32_t umem_limit:32;
+	} s;
+	struct cvmx_pciercx_cfg011_s cn52xx;
+	struct cvmx_pciercx_cfg011_s cn52xxp1;
+	struct cvmx_pciercx_cfg011_s cn56xx;
+	struct cvmx_pciercx_cfg011_s cn56xxp1;
+};
+
+union cvmx_pciercx_cfg012 {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg012_s {
+		uint32_t uio_limit:16;
+		uint32_t uio_base:16;
+	} s;
+	struct cvmx_pciercx_cfg012_s cn52xx;
+	struct cvmx_pciercx_cfg012_s cn52xxp1;
+	struct cvmx_pciercx_cfg012_s cn56xx;
+	struct cvmx_pciercx_cfg012_s cn56xxp1;
+};
+
+union cvmx_pciercx_cfg013 {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg013_s {
+		uint32_t reserved_8_31:24;
+		uint32_t cp:8;
+	} s;
+	struct cvmx_pciercx_cfg013_s cn52xx;
+	struct cvmx_pciercx_cfg013_s cn52xxp1;
+	struct cvmx_pciercx_cfg013_s cn56xx;
+	struct cvmx_pciercx_cfg013_s cn56xxp1;
+};
+
+union cvmx_pciercx_cfg014 {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg014_s {
+		uint32_t reserved_0_31:32;
+	} s;
+	struct cvmx_pciercx_cfg014_s cn52xx;
+	struct cvmx_pciercx_cfg014_s cn52xxp1;
+	struct cvmx_pciercx_cfg014_s cn56xx;
+	struct cvmx_pciercx_cfg014_s cn56xxp1;
+};
+
+union cvmx_pciercx_cfg015 {
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
+};
+
+union cvmx_pciercx_cfg016 {
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
+};
+
+union cvmx_pciercx_cfg017 {
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
+};
+
+union cvmx_pciercx_cfg020 {
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
+};
+
+union cvmx_pciercx_cfg021 {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg021_s {
+		uint32_t lmsi:30;
+		uint32_t reserved_0_1:2;
+	} s;
+	struct cvmx_pciercx_cfg021_s cn52xx;
+	struct cvmx_pciercx_cfg021_s cn52xxp1;
+	struct cvmx_pciercx_cfg021_s cn56xx;
+	struct cvmx_pciercx_cfg021_s cn56xxp1;
+};
+
+union cvmx_pciercx_cfg022 {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg022_s {
+		uint32_t umsi:32;
+	} s;
+	struct cvmx_pciercx_cfg022_s cn52xx;
+	struct cvmx_pciercx_cfg022_s cn52xxp1;
+	struct cvmx_pciercx_cfg022_s cn56xx;
+	struct cvmx_pciercx_cfg022_s cn56xxp1;
+};
+
+union cvmx_pciercx_cfg023 {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg023_s {
+		uint32_t reserved_16_31:16;
+		uint32_t msimd:16;
+	} s;
+	struct cvmx_pciercx_cfg023_s cn52xx;
+	struct cvmx_pciercx_cfg023_s cn52xxp1;
+	struct cvmx_pciercx_cfg023_s cn56xx;
+	struct cvmx_pciercx_cfg023_s cn56xxp1;
+};
+
+union cvmx_pciercx_cfg028 {
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
+};
+
+union cvmx_pciercx_cfg029 {
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
+};
+
+union cvmx_pciercx_cfg030 {
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
+};
+
+union cvmx_pciercx_cfg031 {
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
+};
+
+union cvmx_pciercx_cfg032 {
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
+};
+
+union cvmx_pciercx_cfg033 {
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
+};
+
+union cvmx_pciercx_cfg034 {
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
+};
+
+union cvmx_pciercx_cfg035 {
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
+};
+
+union cvmx_pciercx_cfg036 {
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
+};
+
+union cvmx_pciercx_cfg037 {
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
+};
+
+union cvmx_pciercx_cfg038 {
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
+};
+
+union cvmx_pciercx_cfg039 {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg039_s {
+		uint32_t reserved_0_31:32;
+	} s;
+	struct cvmx_pciercx_cfg039_s cn52xx;
+	struct cvmx_pciercx_cfg039_s cn52xxp1;
+	struct cvmx_pciercx_cfg039_s cn56xx;
+	struct cvmx_pciercx_cfg039_s cn56xxp1;
+};
+
+union cvmx_pciercx_cfg040 {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg040_s {
+		uint32_t reserved_0_31:32;
+	} s;
+	struct cvmx_pciercx_cfg040_s cn52xx;
+	struct cvmx_pciercx_cfg040_s cn52xxp1;
+	struct cvmx_pciercx_cfg040_s cn56xx;
+	struct cvmx_pciercx_cfg040_s cn56xxp1;
+};
+
+union cvmx_pciercx_cfg041 {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg041_s {
+		uint32_t reserved_0_31:32;
+	} s;
+	struct cvmx_pciercx_cfg041_s cn52xx;
+	struct cvmx_pciercx_cfg041_s cn52xxp1;
+	struct cvmx_pciercx_cfg041_s cn56xx;
+	struct cvmx_pciercx_cfg041_s cn56xxp1;
+};
+
+union cvmx_pciercx_cfg042 {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg042_s {
+		uint32_t reserved_0_31:32;
+	} s;
+	struct cvmx_pciercx_cfg042_s cn52xx;
+	struct cvmx_pciercx_cfg042_s cn52xxp1;
+	struct cvmx_pciercx_cfg042_s cn56xx;
+	struct cvmx_pciercx_cfg042_s cn56xxp1;
+};
+
+union cvmx_pciercx_cfg064 {
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
+};
+
+union cvmx_pciercx_cfg065 {
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
+};
+
+union cvmx_pciercx_cfg066 {
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
+};
+
+union cvmx_pciercx_cfg067 {
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
+};
+
+union cvmx_pciercx_cfg068 {
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
+};
+
+union cvmx_pciercx_cfg069 {
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
+};
+
+union cvmx_pciercx_cfg070 {
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
+};
+
+union cvmx_pciercx_cfg071 {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg071_s {
+		uint32_t dword1:32;
+	} s;
+	struct cvmx_pciercx_cfg071_s cn52xx;
+	struct cvmx_pciercx_cfg071_s cn52xxp1;
+	struct cvmx_pciercx_cfg071_s cn56xx;
+	struct cvmx_pciercx_cfg071_s cn56xxp1;
+};
+
+union cvmx_pciercx_cfg072 {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg072_s {
+		uint32_t dword2:32;
+	} s;
+	struct cvmx_pciercx_cfg072_s cn52xx;
+	struct cvmx_pciercx_cfg072_s cn52xxp1;
+	struct cvmx_pciercx_cfg072_s cn56xx;
+	struct cvmx_pciercx_cfg072_s cn56xxp1;
+};
+
+union cvmx_pciercx_cfg073 {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg073_s {
+		uint32_t dword3:32;
+	} s;
+	struct cvmx_pciercx_cfg073_s cn52xx;
+	struct cvmx_pciercx_cfg073_s cn52xxp1;
+	struct cvmx_pciercx_cfg073_s cn56xx;
+	struct cvmx_pciercx_cfg073_s cn56xxp1;
+};
+
+union cvmx_pciercx_cfg074 {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg074_s {
+		uint32_t dword4:32;
+	} s;
+	struct cvmx_pciercx_cfg074_s cn52xx;
+	struct cvmx_pciercx_cfg074_s cn52xxp1;
+	struct cvmx_pciercx_cfg074_s cn56xx;
+	struct cvmx_pciercx_cfg074_s cn56xxp1;
+};
+
+union cvmx_pciercx_cfg075 {
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
+};
+
+union cvmx_pciercx_cfg076 {
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
+};
+
+union cvmx_pciercx_cfg077 {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg077_s {
+		uint32_t efnfsi:16;
+		uint32_t ecsi:16;
+	} s;
+	struct cvmx_pciercx_cfg077_s cn52xx;
+	struct cvmx_pciercx_cfg077_s cn52xxp1;
+	struct cvmx_pciercx_cfg077_s cn56xx;
+	struct cvmx_pciercx_cfg077_s cn56xxp1;
+};
+
+union cvmx_pciercx_cfg448 {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg448_s {
+		uint32_t rtl:16;
+		uint32_t rtltl:16;
+	} s;
+	struct cvmx_pciercx_cfg448_s cn52xx;
+	struct cvmx_pciercx_cfg448_s cn52xxp1;
+	struct cvmx_pciercx_cfg448_s cn56xx;
+	struct cvmx_pciercx_cfg448_s cn56xxp1;
+};
+
+union cvmx_pciercx_cfg449 {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg449_s {
+		uint32_t omr:32;
+	} s;
+	struct cvmx_pciercx_cfg449_s cn52xx;
+	struct cvmx_pciercx_cfg449_s cn52xxp1;
+	struct cvmx_pciercx_cfg449_s cn56xx;
+	struct cvmx_pciercx_cfg449_s cn56xxp1;
+};
+
+union cvmx_pciercx_cfg450 {
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
+};
+
+union cvmx_pciercx_cfg451 {
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
+};
+
+union cvmx_pciercx_cfg452 {
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
+};
+
+union cvmx_pciercx_cfg453 {
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
+};
+
+union cvmx_pciercx_cfg454 {
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
+};
+
+union cvmx_pciercx_cfg455 {
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
+};
+
+union cvmx_pciercx_cfg456 {
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
+};
+
+union cvmx_pciercx_cfg458 {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg458_s {
+		uint32_t dbg_info_l32:32;
+	} s;
+	struct cvmx_pciercx_cfg458_s cn52xx;
+	struct cvmx_pciercx_cfg458_s cn52xxp1;
+	struct cvmx_pciercx_cfg458_s cn56xx;
+	struct cvmx_pciercx_cfg458_s cn56xxp1;
+};
+
+union cvmx_pciercx_cfg459 {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg459_s {
+		uint32_t dbg_info_u32:32;
+	} s;
+	struct cvmx_pciercx_cfg459_s cn52xx;
+	struct cvmx_pciercx_cfg459_s cn52xxp1;
+	struct cvmx_pciercx_cfg459_s cn56xx;
+	struct cvmx_pciercx_cfg459_s cn56xxp1;
+};
+
+union cvmx_pciercx_cfg460 {
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
+};
+
+union cvmx_pciercx_cfg461 {
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
+};
+
+union cvmx_pciercx_cfg462 {
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
+};
+
+union cvmx_pciercx_cfg463 {
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
+};
+
+union cvmx_pciercx_cfg464 {
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
+};
+
+union cvmx_pciercx_cfg465 {
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
+};
+
+union cvmx_pciercx_cfg466 {
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
+};
+
+union cvmx_pciercx_cfg467 {
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
+};
+
+union cvmx_pciercx_cfg468 {
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
+};
+
+union cvmx_pciercx_cfg490 {
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
+};
+
+union cvmx_pciercx_cfg491 {
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
+};
+
+union cvmx_pciercx_cfg492 {
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
+};
+
+union cvmx_pciercx_cfg516 {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg516_s {
+		uint32_t phy_stat:32;
+	} s;
+	struct cvmx_pciercx_cfg516_s cn52xx;
+	struct cvmx_pciercx_cfg516_s cn52xxp1;
+	struct cvmx_pciercx_cfg516_s cn56xx;
+	struct cvmx_pciercx_cfg516_s cn56xxp1;
+};
+
+union cvmx_pciercx_cfg517 {
+	uint32_t u32;
+	struct cvmx_pciercx_cfg517_s {
+		uint32_t phy_ctrl:32;
+	} s;
+	struct cvmx_pciercx_cfg517_s cn52xx;
+	struct cvmx_pciercx_cfg517_s cn52xxp1;
+	struct cvmx_pciercx_cfg517_s cn56xx;
+	struct cvmx_pciercx_cfg517_s cn56xxp1;
+};
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-pescx-defs.h b/arch/mips/include/asm/octeon/cvmx-pescx-defs.h
new file mode 100644
index 0000000..f40cfaf
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-pescx-defs.h
@@ -0,0 +1,410 @@
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
+#ifndef __CVMX_PESCX_DEFS_H__
+#define __CVMX_PESCX_DEFS_H__
+
+#define CVMX_PESCX_BIST_STATUS(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800C8000018ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PESCX_BIST_STATUS2(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800C8000418ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PESCX_CFG_RD(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800C8000030ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PESCX_CFG_WR(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800C8000028ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PESCX_CPL_LUT_VALID(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800C8000098ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PESCX_CTL_STATUS(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800C8000000ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PESCX_CTL_STATUS2(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800C8000400ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PESCX_DBG_INFO(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800C8000008ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PESCX_DBG_INFO_EN(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800C80000A0ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PESCX_DIAG_STATUS(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800C8000020ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PESCX_P2N_BAR0_START(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800C8000080ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PESCX_P2N_BAR1_START(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800C8000088ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PESCX_P2N_BAR2_START(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800C8000090ull + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PESCX_P2P_BARX_END(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800C8000048ull + (((offset) & 3) * 16) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PESCX_P2P_BARX_START(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800C8000040ull + (((offset) & 3) * 16) + (((block_id) & 1) * 0x8000000ull))
+#define CVMX_PESCX_TLP_CREDITS(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800C8000038ull + (((block_id) & 1) * 0x8000000ull))
+
+union cvmx_pescx_bist_status {
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
+};
+
+union cvmx_pescx_bist_status2 {
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
+};
+
+union cvmx_pescx_cfg_rd {
+	uint64_t u64;
+	struct cvmx_pescx_cfg_rd_s {
+		uint64_t data:32;
+		uint64_t addr:32;
+	} s;
+	struct cvmx_pescx_cfg_rd_s cn52xx;
+	struct cvmx_pescx_cfg_rd_s cn52xxp1;
+	struct cvmx_pescx_cfg_rd_s cn56xx;
+	struct cvmx_pescx_cfg_rd_s cn56xxp1;
+};
+
+union cvmx_pescx_cfg_wr {
+	uint64_t u64;
+	struct cvmx_pescx_cfg_wr_s {
+		uint64_t data:32;
+		uint64_t addr:32;
+	} s;
+	struct cvmx_pescx_cfg_wr_s cn52xx;
+	struct cvmx_pescx_cfg_wr_s cn52xxp1;
+	struct cvmx_pescx_cfg_wr_s cn56xx;
+	struct cvmx_pescx_cfg_wr_s cn56xxp1;
+};
+
+union cvmx_pescx_cpl_lut_valid {
+	uint64_t u64;
+	struct cvmx_pescx_cpl_lut_valid_s {
+		uint64_t reserved_32_63:32;
+		uint64_t tag:32;
+	} s;
+	struct cvmx_pescx_cpl_lut_valid_s cn52xx;
+	struct cvmx_pescx_cpl_lut_valid_s cn52xxp1;
+	struct cvmx_pescx_cpl_lut_valid_s cn56xx;
+	struct cvmx_pescx_cpl_lut_valid_s cn56xxp1;
+};
+
+union cvmx_pescx_ctl_status {
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
+};
+
+union cvmx_pescx_ctl_status2 {
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
+};
+
+union cvmx_pescx_dbg_info {
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
+};
+
+union cvmx_pescx_dbg_info_en {
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
+};
+
+union cvmx_pescx_diag_status {
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
+};
+
+union cvmx_pescx_p2n_bar0_start {
+	uint64_t u64;
+	struct cvmx_pescx_p2n_bar0_start_s {
+		uint64_t addr:50;
+		uint64_t reserved_0_13:14;
+	} s;
+	struct cvmx_pescx_p2n_bar0_start_s cn52xx;
+	struct cvmx_pescx_p2n_bar0_start_s cn52xxp1;
+	struct cvmx_pescx_p2n_bar0_start_s cn56xx;
+	struct cvmx_pescx_p2n_bar0_start_s cn56xxp1;
+};
+
+union cvmx_pescx_p2n_bar1_start {
+	uint64_t u64;
+	struct cvmx_pescx_p2n_bar1_start_s {
+		uint64_t addr:38;
+		uint64_t reserved_0_25:26;
+	} s;
+	struct cvmx_pescx_p2n_bar1_start_s cn52xx;
+	struct cvmx_pescx_p2n_bar1_start_s cn52xxp1;
+	struct cvmx_pescx_p2n_bar1_start_s cn56xx;
+	struct cvmx_pescx_p2n_bar1_start_s cn56xxp1;
+};
+
+union cvmx_pescx_p2n_bar2_start {
+	uint64_t u64;
+	struct cvmx_pescx_p2n_bar2_start_s {
+		uint64_t addr:25;
+		uint64_t reserved_0_38:39;
+	} s;
+	struct cvmx_pescx_p2n_bar2_start_s cn52xx;
+	struct cvmx_pescx_p2n_bar2_start_s cn52xxp1;
+	struct cvmx_pescx_p2n_bar2_start_s cn56xx;
+	struct cvmx_pescx_p2n_bar2_start_s cn56xxp1;
+};
+
+union cvmx_pescx_p2p_barx_end {
+	uint64_t u64;
+	struct cvmx_pescx_p2p_barx_end_s {
+		uint64_t addr:52;
+		uint64_t reserved_0_11:12;
+	} s;
+	struct cvmx_pescx_p2p_barx_end_s cn52xx;
+	struct cvmx_pescx_p2p_barx_end_s cn52xxp1;
+	struct cvmx_pescx_p2p_barx_end_s cn56xx;
+	struct cvmx_pescx_p2p_barx_end_s cn56xxp1;
+};
+
+union cvmx_pescx_p2p_barx_start {
+	uint64_t u64;
+	struct cvmx_pescx_p2p_barx_start_s {
+		uint64_t addr:52;
+		uint64_t reserved_0_11:12;
+	} s;
+	struct cvmx_pescx_p2p_barx_start_s cn52xx;
+	struct cvmx_pescx_p2p_barx_start_s cn52xxp1;
+	struct cvmx_pescx_p2p_barx_start_s cn56xx;
+	struct cvmx_pescx_p2p_barx_start_s cn56xxp1;
+};
+
+union cvmx_pescx_tlp_credits {
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
+};
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-pexp-defs.h b/arch/mips/include/asm/octeon/cvmx-pexp-defs.h
new file mode 100644
index 0000000..5ea5dc5
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-pexp-defs.h
@@ -0,0 +1,229 @@
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
+/**
+ * cvmx-pexp-defs.h
+ *
+ * Configuration and status register (CSR) definitions for
+ * OCTEON PEXP.
+ *
+ */
+#ifndef __CVMX_PEXP_DEFS_H__
+#define __CVMX_PEXP_DEFS_H__
+
+#define CVMX_PEXP_NPEI_BAR1_INDEXX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011F0000008000ull + (((offset) & 31) * 16))
+#define CVMX_PEXP_NPEI_BIST_STATUS \
+	 CVMX_ADD_IO_SEG(0x00011F0000008580ull)
+#define CVMX_PEXP_NPEI_BIST_STATUS2 \
+	 CVMX_ADD_IO_SEG(0x00011F0000008680ull)
+#define CVMX_PEXP_NPEI_CTL_PORT0 \
+	 CVMX_ADD_IO_SEG(0x00011F0000008250ull)
+#define CVMX_PEXP_NPEI_CTL_PORT1 \
+	 CVMX_ADD_IO_SEG(0x00011F0000008260ull)
+#define CVMX_PEXP_NPEI_CTL_STATUS \
+	 CVMX_ADD_IO_SEG(0x00011F0000008570ull)
+#define CVMX_PEXP_NPEI_CTL_STATUS2 \
+	 CVMX_ADD_IO_SEG(0x00011F000000BC00ull)
+#define CVMX_PEXP_NPEI_DATA_OUT_CNT \
+	 CVMX_ADD_IO_SEG(0x00011F00000085F0ull)
+#define CVMX_PEXP_NPEI_DBG_DATA \
+	 CVMX_ADD_IO_SEG(0x00011F0000008510ull)
+#define CVMX_PEXP_NPEI_DBG_SELECT \
+	 CVMX_ADD_IO_SEG(0x00011F0000008500ull)
+#define CVMX_PEXP_NPEI_DMA0_INT_LEVEL \
+	 CVMX_ADD_IO_SEG(0x00011F00000085C0ull)
+#define CVMX_PEXP_NPEI_DMA1_INT_LEVEL \
+	 CVMX_ADD_IO_SEG(0x00011F00000085D0ull)
+#define CVMX_PEXP_NPEI_DMAX_COUNTS(offset) \
+	 CVMX_ADD_IO_SEG(0x00011F0000008450ull + (((offset) & 7) * 16))
+#define CVMX_PEXP_NPEI_DMAX_DBELL(offset) \
+	 CVMX_ADD_IO_SEG(0x00011F00000083B0ull + (((offset) & 7) * 16))
+#define CVMX_PEXP_NPEI_DMAX_IBUFF_SADDR(offset) \
+	 CVMX_ADD_IO_SEG(0x00011F0000008400ull + (((offset) & 7) * 16))
+#define CVMX_PEXP_NPEI_DMAX_NADDR(offset) \
+	 CVMX_ADD_IO_SEG(0x00011F00000084A0ull + (((offset) & 7) * 16))
+#define CVMX_PEXP_NPEI_DMA_CNTS \
+	 CVMX_ADD_IO_SEG(0x00011F00000085E0ull)
+#define CVMX_PEXP_NPEI_DMA_CONTROL \
+	 CVMX_ADD_IO_SEG(0x00011F00000083A0ull)
+#define CVMX_PEXP_NPEI_INT_A_ENB \
+	 CVMX_ADD_IO_SEG(0x00011F0000008560ull)
+#define CVMX_PEXP_NPEI_INT_A_ENB2 \
+	 CVMX_ADD_IO_SEG(0x00011F000000BCE0ull)
+#define CVMX_PEXP_NPEI_INT_A_SUM \
+	 CVMX_ADD_IO_SEG(0x00011F0000008550ull)
+#define CVMX_PEXP_NPEI_INT_ENB \
+	 CVMX_ADD_IO_SEG(0x00011F0000008540ull)
+#define CVMX_PEXP_NPEI_INT_ENB2 \
+	 CVMX_ADD_IO_SEG(0x00011F000000BCD0ull)
+#define CVMX_PEXP_NPEI_INT_INFO \
+	 CVMX_ADD_IO_SEG(0x00011F0000008590ull)
+#define CVMX_PEXP_NPEI_INT_SUM \
+	 CVMX_ADD_IO_SEG(0x00011F0000008530ull)
+#define CVMX_PEXP_NPEI_INT_SUM2 \
+	 CVMX_ADD_IO_SEG(0x00011F000000BCC0ull)
+#define CVMX_PEXP_NPEI_LAST_WIN_RDATA0 \
+	 CVMX_ADD_IO_SEG(0x00011F0000008600ull)
+#define CVMX_PEXP_NPEI_LAST_WIN_RDATA1 \
+	 CVMX_ADD_IO_SEG(0x00011F0000008610ull)
+#define CVMX_PEXP_NPEI_MEM_ACCESS_CTL \
+	 CVMX_ADD_IO_SEG(0x00011F00000084F0ull)
+#define CVMX_PEXP_NPEI_MEM_ACCESS_SUBIDX(offset) \
+	 CVMX_ADD_IO_SEG(0x00011F0000008280ull + (((offset) & 31) * 16) - 16 * 12)
+#define CVMX_PEXP_NPEI_MSI_ENB0 \
+	 CVMX_ADD_IO_SEG(0x00011F000000BC50ull)
+#define CVMX_PEXP_NPEI_MSI_ENB1 \
+	 CVMX_ADD_IO_SEG(0x00011F000000BC60ull)
+#define CVMX_PEXP_NPEI_MSI_ENB2 \
+	 CVMX_ADD_IO_SEG(0x00011F000000BC70ull)
+#define CVMX_PEXP_NPEI_MSI_ENB3 \
+	 CVMX_ADD_IO_SEG(0x00011F000000BC80ull)
+#define CVMX_PEXP_NPEI_MSI_RCV0 \
+	 CVMX_ADD_IO_SEG(0x00011F000000BC10ull)
+#define CVMX_PEXP_NPEI_MSI_RCV1 \
+	 CVMX_ADD_IO_SEG(0x00011F000000BC20ull)
+#define CVMX_PEXP_NPEI_MSI_RCV2 \
+	 CVMX_ADD_IO_SEG(0x00011F000000BC30ull)
+#define CVMX_PEXP_NPEI_MSI_RCV3 \
+	 CVMX_ADD_IO_SEG(0x00011F000000BC40ull)
+#define CVMX_PEXP_NPEI_MSI_RD_MAP \
+	 CVMX_ADD_IO_SEG(0x00011F000000BCA0ull)
+#define CVMX_PEXP_NPEI_MSI_W1C_ENB0 \
+	 CVMX_ADD_IO_SEG(0x00011F000000BCF0ull)
+#define CVMX_PEXP_NPEI_MSI_W1C_ENB1 \
+	 CVMX_ADD_IO_SEG(0x00011F000000BD00ull)
+#define CVMX_PEXP_NPEI_MSI_W1C_ENB2 \
+	 CVMX_ADD_IO_SEG(0x00011F000000BD10ull)
+#define CVMX_PEXP_NPEI_MSI_W1C_ENB3 \
+	 CVMX_ADD_IO_SEG(0x00011F000000BD20ull)
+#define CVMX_PEXP_NPEI_MSI_W1S_ENB0 \
+	 CVMX_ADD_IO_SEG(0x00011F000000BD30ull)
+#define CVMX_PEXP_NPEI_MSI_W1S_ENB1 \
+	 CVMX_ADD_IO_SEG(0x00011F000000BD40ull)
+#define CVMX_PEXP_NPEI_MSI_W1S_ENB2 \
+	 CVMX_ADD_IO_SEG(0x00011F000000BD50ull)
+#define CVMX_PEXP_NPEI_MSI_W1S_ENB3 \
+	 CVMX_ADD_IO_SEG(0x00011F000000BD60ull)
+#define CVMX_PEXP_NPEI_MSI_WR_MAP \
+	 CVMX_ADD_IO_SEG(0x00011F000000BC90ull)
+#define CVMX_PEXP_NPEI_PCIE_CREDIT_CNT \
+	 CVMX_ADD_IO_SEG(0x00011F000000BD70ull)
+#define CVMX_PEXP_NPEI_PCIE_MSI_RCV \
+	 CVMX_ADD_IO_SEG(0x00011F000000BCB0ull)
+#define CVMX_PEXP_NPEI_PCIE_MSI_RCV_B1 \
+	 CVMX_ADD_IO_SEG(0x00011F0000008650ull)
+#define CVMX_PEXP_NPEI_PCIE_MSI_RCV_B2 \
+	 CVMX_ADD_IO_SEG(0x00011F0000008660ull)
+#define CVMX_PEXP_NPEI_PCIE_MSI_RCV_B3 \
+	 CVMX_ADD_IO_SEG(0x00011F0000008670ull)
+#define CVMX_PEXP_NPEI_PKTX_CNTS(offset) \
+	 CVMX_ADD_IO_SEG(0x00011F000000A400ull + (((offset) & 31) * 16))
+#define CVMX_PEXP_NPEI_PKTX_INSTR_BADDR(offset) \
+	 CVMX_ADD_IO_SEG(0x00011F000000A800ull + (((offset) & 31) * 16))
+#define CVMX_PEXP_NPEI_PKTX_INSTR_BAOFF_DBELL(offset) \
+	 CVMX_ADD_IO_SEG(0x00011F000000AC00ull + (((offset) & 31) * 16))
+#define CVMX_PEXP_NPEI_PKTX_INSTR_FIFO_RSIZE(offset) \
+	 CVMX_ADD_IO_SEG(0x00011F000000B000ull + (((offset) & 31) * 16))
+#define CVMX_PEXP_NPEI_PKTX_INSTR_HEADER(offset) \
+	 CVMX_ADD_IO_SEG(0x00011F000000B400ull + (((offset) & 31) * 16))
+#define CVMX_PEXP_NPEI_PKTX_IN_BP(offset) \
+	 CVMX_ADD_IO_SEG(0x00011F000000B800ull + (((offset) & 31) * 16))
+#define CVMX_PEXP_NPEI_PKTX_SLIST_BADDR(offset) \
+	 CVMX_ADD_IO_SEG(0x00011F0000009400ull + (((offset) & 31) * 16))
+#define CVMX_PEXP_NPEI_PKTX_SLIST_BAOFF_DBELL(offset) \
+	 CVMX_ADD_IO_SEG(0x00011F0000009800ull + (((offset) & 31) * 16))
+#define CVMX_PEXP_NPEI_PKTX_SLIST_FIFO_RSIZE(offset) \
+	 CVMX_ADD_IO_SEG(0x00011F0000009C00ull + (((offset) & 31) * 16))
+#define CVMX_PEXP_NPEI_PKT_CNT_INT \
+	 CVMX_ADD_IO_SEG(0x00011F0000009110ull)
+#define CVMX_PEXP_NPEI_PKT_CNT_INT_ENB \
+	 CVMX_ADD_IO_SEG(0x00011F0000009130ull)
+#define CVMX_PEXP_NPEI_PKT_DATA_OUT_ES \
+	 CVMX_ADD_IO_SEG(0x00011F00000090B0ull)
+#define CVMX_PEXP_NPEI_PKT_DATA_OUT_NS \
+	 CVMX_ADD_IO_SEG(0x00011F00000090A0ull)
+#define CVMX_PEXP_NPEI_PKT_DATA_OUT_ROR \
+	 CVMX_ADD_IO_SEG(0x00011F0000009090ull)
+#define CVMX_PEXP_NPEI_PKT_DPADDR \
+	 CVMX_ADD_IO_SEG(0x00011F0000009080ull)
+#define CVMX_PEXP_NPEI_PKT_INPUT_CONTROL \
+	 CVMX_ADD_IO_SEG(0x00011F0000009150ull)
+#define CVMX_PEXP_NPEI_PKT_INSTR_ENB \
+	 CVMX_ADD_IO_SEG(0x00011F0000009000ull)
+#define CVMX_PEXP_NPEI_PKT_INSTR_RD_SIZE \
+	 CVMX_ADD_IO_SEG(0x00011F0000009190ull)
+#define CVMX_PEXP_NPEI_PKT_INSTR_SIZE \
+	 CVMX_ADD_IO_SEG(0x00011F0000009020ull)
+#define CVMX_PEXP_NPEI_PKT_INT_LEVELS \
+	 CVMX_ADD_IO_SEG(0x00011F0000009100ull)
+#define CVMX_PEXP_NPEI_PKT_IN_BP \
+	 CVMX_ADD_IO_SEG(0x00011F00000086B0ull)
+#define CVMX_PEXP_NPEI_PKT_IN_DONEX_CNTS(offset) \
+	 CVMX_ADD_IO_SEG(0x00011F000000A000ull + (((offset) & 31) * 16))
+#define CVMX_PEXP_NPEI_PKT_IN_INSTR_COUNTS \
+	 CVMX_ADD_IO_SEG(0x00011F00000086A0ull)
+#define CVMX_PEXP_NPEI_PKT_IN_PCIE_PORT \
+	 CVMX_ADD_IO_SEG(0x00011F00000091A0ull)
+#define CVMX_PEXP_NPEI_PKT_IPTR \
+	 CVMX_ADD_IO_SEG(0x00011F0000009070ull)
+#define CVMX_PEXP_NPEI_PKT_OUTPUT_WMARK \
+	 CVMX_ADD_IO_SEG(0x00011F0000009160ull)
+#define CVMX_PEXP_NPEI_PKT_OUT_BMODE \
+	 CVMX_ADD_IO_SEG(0x00011F00000090D0ull)
+#define CVMX_PEXP_NPEI_PKT_OUT_ENB \
+	 CVMX_ADD_IO_SEG(0x00011F0000009010ull)
+#define CVMX_PEXP_NPEI_PKT_PCIE_PORT \
+	 CVMX_ADD_IO_SEG(0x00011F00000090E0ull)
+#define CVMX_PEXP_NPEI_PKT_PORT_IN_RST \
+	 CVMX_ADD_IO_SEG(0x00011F0000008690ull)
+#define CVMX_PEXP_NPEI_PKT_SLIST_ES \
+	 CVMX_ADD_IO_SEG(0x00011F0000009050ull)
+#define CVMX_PEXP_NPEI_PKT_SLIST_ID_SIZE \
+	 CVMX_ADD_IO_SEG(0x00011F0000009180ull)
+#define CVMX_PEXP_NPEI_PKT_SLIST_NS \
+	 CVMX_ADD_IO_SEG(0x00011F0000009040ull)
+#define CVMX_PEXP_NPEI_PKT_SLIST_ROR \
+	 CVMX_ADD_IO_SEG(0x00011F0000009030ull)
+#define CVMX_PEXP_NPEI_PKT_TIME_INT \
+	 CVMX_ADD_IO_SEG(0x00011F0000009120ull)
+#define CVMX_PEXP_NPEI_PKT_TIME_INT_ENB \
+	 CVMX_ADD_IO_SEG(0x00011F0000009140ull)
+#define CVMX_PEXP_NPEI_RSL_INT_BLOCKS \
+	 CVMX_ADD_IO_SEG(0x00011F0000008520ull)
+#define CVMX_PEXP_NPEI_SCRATCH_1 \
+	 CVMX_ADD_IO_SEG(0x00011F0000008270ull)
+#define CVMX_PEXP_NPEI_STATE1 \
+	 CVMX_ADD_IO_SEG(0x00011F0000008620ull)
+#define CVMX_PEXP_NPEI_STATE2 \
+	 CVMX_ADD_IO_SEG(0x00011F0000008630ull)
+#define CVMX_PEXP_NPEI_STATE3 \
+	 CVMX_ADD_IO_SEG(0x00011F0000008640ull)
+#define CVMX_PEXP_NPEI_WINDOW_CTL \
+	 CVMX_ADD_IO_SEG(0x00011F0000008380ull)
+
+#endif
-- 
1.6.0.6
