Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Dec 2008 23:41:00 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:47146 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24176772AbYLKXkF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Dec 2008 23:40:05 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4941a3760000>; Thu, 11 Dec 2008 18:34:17 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 11 Dec 2008 15:33:45 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 11 Dec 2008 15:33:45 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mBBNXdGw031859;
	Thu, 11 Dec 2008 15:33:39 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mBBNXc2P031857;
	Thu, 11 Dec 2008 15:33:38 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 01/20] MIPS: Add Cavium OCTEON processor CSR definitions
Date:	Thu, 11 Dec 2008 15:33:19 -0800
Message-Id: <1229038418-31833-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <4941A2F5.1010202@caviumnetworks.com>
References: <4941A2F5.1010202@caviumnetworks.com>
X-OriginalArrivalTime: 11 Dec 2008 23:33:45.0161 (UTC) FILETIME=[E8B6E390:01C95BE8]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Here we define the addresses and bit-fields of the Configuration and
Status Registers (CSRs) for some of the hardware functional units on
the OCTEON SOC.

Definitions are needed for:

CIU  -- Central Interrupt Unit.
GPIO -- General Purpose Input Output.
IOB  -- Input / Output {Busing,Bridge}.
IPD  -- Input Packet Data unit.
L2C  -- Level-2 Cache controller.
L2D  -- Level-2 Data cache.
L2T  -- Level-2 cache Tag.
LED  -- Light Emitting Diode controller.
MIO  -- Miscellaneous Input / Output.
POW  -- Packet Order / Work unit.


Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h  | 1616 ++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx-gpio-defs.h |  219 +++
 arch/mips/include/asm/octeon/cvmx-iob-defs.h  |  530 +++++++
 arch/mips/include/asm/octeon/cvmx-ipd-defs.h  |  877 +++++++++++
 arch/mips/include/asm/octeon/cvmx-l2c-defs.h  |  963 ++++++++++++
 arch/mips/include/asm/octeon/cvmx-l2d-defs.h  |  369 +++++
 arch/mips/include/asm/octeon/cvmx-l2t-defs.h  |  141 ++
 arch/mips/include/asm/octeon/cvmx-led-defs.h  |  240 +++
 arch/mips/include/asm/octeon/cvmx-mio-defs.h  | 2004 +++++++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx-pow-defs.h  |  698 +++++++++
 10 files changed, 7657 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/octeon/cvmx-ciu-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-gpio-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-iob-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-ipd-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-l2c-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-l2d-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-l2t-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-led-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-mio-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-pow-defs.h

diff --git a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
new file mode 100644
index 0000000..f8f05b7
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
@@ -0,0 +1,1616 @@
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
+#ifndef __CVMX_CIU_DEFS_H__
+#define __CVMX_CIU_DEFS_H__
+
+#define CVMX_CIU_BIST \
+	 CVMX_ADD_IO_SEG(0x0001070000000730ull)
+#define CVMX_CIU_DINT \
+	 CVMX_ADD_IO_SEG(0x0001070000000720ull)
+#define CVMX_CIU_FUSE \
+	 CVMX_ADD_IO_SEG(0x0001070000000728ull)
+#define CVMX_CIU_GSTOP \
+	 CVMX_ADD_IO_SEG(0x0001070000000710ull)
+#define CVMX_CIU_INTX_EN0(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000000200ull + (((offset) & 63) * 16))
+#define CVMX_CIU_INTX_EN0_W1C(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000002200ull + (((offset) & 63) * 16))
+#define CVMX_CIU_INTX_EN0_W1S(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000006200ull + (((offset) & 63) * 16))
+#define CVMX_CIU_INTX_EN1(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000000208ull + (((offset) & 63) * 16))
+#define CVMX_CIU_INTX_EN1_W1C(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000002208ull + (((offset) & 63) * 16))
+#define CVMX_CIU_INTX_EN1_W1S(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000006208ull + (((offset) & 63) * 16))
+#define CVMX_CIU_INTX_EN4_0(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000000C80ull + (((offset) & 15) * 16))
+#define CVMX_CIU_INTX_EN4_0_W1C(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000002C80ull + (((offset) & 15) * 16))
+#define CVMX_CIU_INTX_EN4_0_W1S(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000006C80ull + (((offset) & 15) * 16))
+#define CVMX_CIU_INTX_EN4_1(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000000C88ull + (((offset) & 15) * 16))
+#define CVMX_CIU_INTX_EN4_1_W1C(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000002C88ull + (((offset) & 15) * 16))
+#define CVMX_CIU_INTX_EN4_1_W1S(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000006C88ull + (((offset) & 15) * 16))
+#define CVMX_CIU_INTX_SUM0(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000000000ull + (((offset) & 63) * 8))
+#define CVMX_CIU_INTX_SUM4(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000000C00ull + (((offset) & 15) * 8))
+#define CVMX_CIU_INT_SUM1 \
+	 CVMX_ADD_IO_SEG(0x0001070000000108ull)
+#define CVMX_CIU_MBOX_CLRX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000000680ull + (((offset) & 15) * 8))
+#define CVMX_CIU_MBOX_SETX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000000600ull + (((offset) & 15) * 8))
+#define CVMX_CIU_NMI \
+	 CVMX_ADD_IO_SEG(0x0001070000000718ull)
+#define CVMX_CIU_PCI_INTA \
+	 CVMX_ADD_IO_SEG(0x0001070000000750ull)
+#define CVMX_CIU_PP_DBG \
+	 CVMX_ADD_IO_SEG(0x0001070000000708ull)
+#define CVMX_CIU_PP_POKEX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000000580ull + (((offset) & 15) * 8))
+#define CVMX_CIU_PP_RST \
+	 CVMX_ADD_IO_SEG(0x0001070000000700ull)
+#define CVMX_CIU_QLM_DCOK \
+	 CVMX_ADD_IO_SEG(0x0001070000000760ull)
+#define CVMX_CIU_QLM_JTGC \
+	 CVMX_ADD_IO_SEG(0x0001070000000768ull)
+#define CVMX_CIU_QLM_JTGD \
+	 CVMX_ADD_IO_SEG(0x0001070000000770ull)
+#define CVMX_CIU_SOFT_BIST \
+	 CVMX_ADD_IO_SEG(0x0001070000000738ull)
+#define CVMX_CIU_SOFT_PRST \
+	 CVMX_ADD_IO_SEG(0x0001070000000748ull)
+#define CVMX_CIU_SOFT_PRST1 \
+	 CVMX_ADD_IO_SEG(0x0001070000000758ull)
+#define CVMX_CIU_SOFT_RST \
+	 CVMX_ADD_IO_SEG(0x0001070000000740ull)
+#define CVMX_CIU_TIMX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000000480ull + (((offset) & 3) * 8))
+#define CVMX_CIU_WDOGX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000000500ull + (((offset) & 15) * 8))
+
+union cvmx_ciu_bist {
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
+};
+
+union cvmx_ciu_dint {
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
+};
+
+union cvmx_ciu_fuse {
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
+};
+
+union cvmx_ciu_gstop {
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
+};
+
+union cvmx_ciu_intx_en0 {
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
+};
+
+union cvmx_ciu_intx_en0_w1c {
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
+};
+
+union cvmx_ciu_intx_en0_w1s {
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
+};
+
+union cvmx_ciu_intx_en1 {
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
+};
+
+union cvmx_ciu_intx_en1_w1c {
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
+};
+
+union cvmx_ciu_intx_en1_w1s {
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
+};
+
+union cvmx_ciu_intx_en4_0 {
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
+};
+
+union cvmx_ciu_intx_en4_0_w1c {
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
+};
+
+union cvmx_ciu_intx_en4_0_w1s {
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
+};
+
+union cvmx_ciu_intx_en4_1 {
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
+};
+
+union cvmx_ciu_intx_en4_1_w1c {
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
+};
+
+union cvmx_ciu_intx_en4_1_w1s {
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
+};
+
+union cvmx_ciu_intx_sum0 {
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
+};
+
+union cvmx_ciu_intx_sum4 {
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
+};
+
+union cvmx_ciu_int_sum1 {
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
+};
+
+union cvmx_ciu_mbox_clrx {
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
+};
+
+union cvmx_ciu_mbox_setx {
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
+};
+
+union cvmx_ciu_nmi {
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
+};
+
+union cvmx_ciu_pci_inta {
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
+};
+
+union cvmx_ciu_pp_dbg {
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
+};
+
+union cvmx_ciu_pp_pokex {
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
+};
+
+union cvmx_ciu_pp_rst {
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
+};
+
+union cvmx_ciu_qlm_dcok {
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
+};
+
+union cvmx_ciu_qlm_jtgc {
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
+};
+
+union cvmx_ciu_qlm_jtgd {
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
+};
+
+union cvmx_ciu_soft_bist {
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
+};
+
+union cvmx_ciu_soft_prst {
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
+};
+
+union cvmx_ciu_soft_prst1 {
+	uint64_t u64;
+	struct cvmx_ciu_soft_prst1_s {
+		uint64_t reserved_1_63:63;
+		uint64_t soft_prst:1;
+	} s;
+	struct cvmx_ciu_soft_prst1_s cn52xx;
+	struct cvmx_ciu_soft_prst1_s cn52xxp1;
+	struct cvmx_ciu_soft_prst1_s cn56xx;
+	struct cvmx_ciu_soft_prst1_s cn56xxp1;
+};
+
+union cvmx_ciu_soft_rst {
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
+};
+
+union cvmx_ciu_timx {
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
+};
+
+union cvmx_ciu_wdogx {
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
+};
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-gpio-defs.h b/arch/mips/include/asm/octeon/cvmx-gpio-defs.h
new file mode 100644
index 0000000..5fdd6ba
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-gpio-defs.h
@@ -0,0 +1,219 @@
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
+#ifndef __CVMX_GPIO_DEFS_H__
+#define __CVMX_GPIO_DEFS_H__
+
+#define CVMX_GPIO_BIT_CFGX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000000800ull + (((offset) & 15) * 8))
+#define CVMX_GPIO_BOOT_ENA \
+	 CVMX_ADD_IO_SEG(0x00010700000008A8ull)
+#define CVMX_GPIO_CLK_GENX(offset) \
+	 CVMX_ADD_IO_SEG(0x00010700000008C0ull + (((offset) & 3) * 8))
+#define CVMX_GPIO_DBG_ENA \
+	 CVMX_ADD_IO_SEG(0x00010700000008A0ull)
+#define CVMX_GPIO_INT_CLR \
+	 CVMX_ADD_IO_SEG(0x0001070000000898ull)
+#define CVMX_GPIO_RX_DAT \
+	 CVMX_ADD_IO_SEG(0x0001070000000880ull)
+#define CVMX_GPIO_TX_CLR \
+	 CVMX_ADD_IO_SEG(0x0001070000000890ull)
+#define CVMX_GPIO_TX_SET \
+	 CVMX_ADD_IO_SEG(0x0001070000000888ull)
+#define CVMX_GPIO_XBIT_CFGX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001070000000900ull + (((offset) & 31) * 8) - 8 * 16)
+
+union cvmx_gpio_bit_cfgx {
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
+};
+
+union cvmx_gpio_boot_ena {
+	uint64_t u64;
+	struct cvmx_gpio_boot_ena_s {
+		uint64_t reserved_12_63:52;
+		uint64_t boot_ena:4;
+		uint64_t reserved_0_7:8;
+	} s;
+	struct cvmx_gpio_boot_ena_s cn30xx;
+	struct cvmx_gpio_boot_ena_s cn31xx;
+	struct cvmx_gpio_boot_ena_s cn50xx;
+};
+
+union cvmx_gpio_clk_genx {
+	uint64_t u64;
+	struct cvmx_gpio_clk_genx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t n:32;
+	} s;
+	struct cvmx_gpio_clk_genx_s cn52xx;
+	struct cvmx_gpio_clk_genx_s cn52xxp1;
+	struct cvmx_gpio_clk_genx_s cn56xx;
+	struct cvmx_gpio_clk_genx_s cn56xxp1;
+};
+
+union cvmx_gpio_dbg_ena {
+	uint64_t u64;
+	struct cvmx_gpio_dbg_ena_s {
+		uint64_t reserved_21_63:43;
+		uint64_t dbg_ena:21;
+	} s;
+	struct cvmx_gpio_dbg_ena_s cn30xx;
+	struct cvmx_gpio_dbg_ena_s cn31xx;
+	struct cvmx_gpio_dbg_ena_s cn50xx;
+};
+
+union cvmx_gpio_int_clr {
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
+};
+
+union cvmx_gpio_rx_dat {
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
+};
+
+union cvmx_gpio_tx_clr {
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
+};
+
+union cvmx_gpio_tx_set {
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
+};
+
+union cvmx_gpio_xbit_cfgx {
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
+};
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-iob-defs.h b/arch/mips/include/asm/octeon/cvmx-iob-defs.h
new file mode 100644
index 0000000..0ee36ba
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-iob-defs.h
@@ -0,0 +1,530 @@
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
+#ifndef __CVMX_IOB_DEFS_H__
+#define __CVMX_IOB_DEFS_H__
+
+#define CVMX_IOB_BIST_STATUS \
+	 CVMX_ADD_IO_SEG(0x00011800F00007F8ull)
+#define CVMX_IOB_CTL_STATUS \
+	 CVMX_ADD_IO_SEG(0x00011800F0000050ull)
+#define CVMX_IOB_DWB_PRI_CNT \
+	 CVMX_ADD_IO_SEG(0x00011800F0000028ull)
+#define CVMX_IOB_FAU_TIMEOUT \
+	 CVMX_ADD_IO_SEG(0x00011800F0000000ull)
+#define CVMX_IOB_I2C_PRI_CNT \
+	 CVMX_ADD_IO_SEG(0x00011800F0000010ull)
+#define CVMX_IOB_INB_CONTROL_MATCH \
+	 CVMX_ADD_IO_SEG(0x00011800F0000078ull)
+#define CVMX_IOB_INB_CONTROL_MATCH_ENB \
+	 CVMX_ADD_IO_SEG(0x00011800F0000088ull)
+#define CVMX_IOB_INB_DATA_MATCH \
+	 CVMX_ADD_IO_SEG(0x00011800F0000070ull)
+#define CVMX_IOB_INB_DATA_MATCH_ENB \
+	 CVMX_ADD_IO_SEG(0x00011800F0000080ull)
+#define CVMX_IOB_INT_ENB \
+	 CVMX_ADD_IO_SEG(0x00011800F0000060ull)
+#define CVMX_IOB_INT_SUM \
+	 CVMX_ADD_IO_SEG(0x00011800F0000058ull)
+#define CVMX_IOB_N2C_L2C_PRI_CNT \
+	 CVMX_ADD_IO_SEG(0x00011800F0000020ull)
+#define CVMX_IOB_N2C_RSP_PRI_CNT \
+	 CVMX_ADD_IO_SEG(0x00011800F0000008ull)
+#define CVMX_IOB_OUTB_COM_PRI_CNT \
+	 CVMX_ADD_IO_SEG(0x00011800F0000040ull)
+#define CVMX_IOB_OUTB_CONTROL_MATCH \
+	 CVMX_ADD_IO_SEG(0x00011800F0000098ull)
+#define CVMX_IOB_OUTB_CONTROL_MATCH_ENB \
+	 CVMX_ADD_IO_SEG(0x00011800F00000A8ull)
+#define CVMX_IOB_OUTB_DATA_MATCH \
+	 CVMX_ADD_IO_SEG(0x00011800F0000090ull)
+#define CVMX_IOB_OUTB_DATA_MATCH_ENB \
+	 CVMX_ADD_IO_SEG(0x00011800F00000A0ull)
+#define CVMX_IOB_OUTB_FPA_PRI_CNT \
+	 CVMX_ADD_IO_SEG(0x00011800F0000048ull)
+#define CVMX_IOB_OUTB_REQ_PRI_CNT \
+	 CVMX_ADD_IO_SEG(0x00011800F0000038ull)
+#define CVMX_IOB_P2C_REQ_PRI_CNT \
+	 CVMX_ADD_IO_SEG(0x00011800F0000018ull)
+#define CVMX_IOB_PKT_ERR \
+	 CVMX_ADD_IO_SEG(0x00011800F0000068ull)
+
+union cvmx_iob_bist_status {
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
+};
+
+union cvmx_iob_ctl_status {
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
+};
+
+union cvmx_iob_dwb_pri_cnt {
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
+};
+
+union cvmx_iob_fau_timeout {
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
+};
+
+union cvmx_iob_i2c_pri_cnt {
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
+};
+
+union cvmx_iob_inb_control_match {
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
+};
+
+union cvmx_iob_inb_control_match_enb {
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
+};
+
+union cvmx_iob_inb_data_match {
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
+};
+
+union cvmx_iob_inb_data_match_enb {
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
+};
+
+union cvmx_iob_int_enb {
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
+};
+
+union cvmx_iob_int_sum {
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
+};
+
+union cvmx_iob_n2c_l2c_pri_cnt {
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
+};
+
+union cvmx_iob_n2c_rsp_pri_cnt {
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
+};
+
+union cvmx_iob_outb_com_pri_cnt {
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
+};
+
+union cvmx_iob_outb_control_match {
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
+};
+
+union cvmx_iob_outb_control_match_enb {
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
+};
+
+union cvmx_iob_outb_data_match {
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
+};
+
+union cvmx_iob_outb_data_match_enb {
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
+};
+
+union cvmx_iob_outb_fpa_pri_cnt {
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
+};
+
+union cvmx_iob_outb_req_pri_cnt {
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
+};
+
+union cvmx_iob_p2c_req_pri_cnt {
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
+};
+
+union cvmx_iob_pkt_err {
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
+};
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-ipd-defs.h b/arch/mips/include/asm/octeon/cvmx-ipd-defs.h
new file mode 100644
index 0000000..f8b8fc6
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-ipd-defs.h
@@ -0,0 +1,877 @@
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
+#ifndef __CVMX_IPD_DEFS_H__
+#define __CVMX_IPD_DEFS_H__
+
+#define CVMX_IPD_1ST_MBUFF_SKIP \
+	 CVMX_ADD_IO_SEG(0x00014F0000000000ull)
+#define CVMX_IPD_1st_NEXT_PTR_BACK \
+	 CVMX_ADD_IO_SEG(0x00014F0000000150ull)
+#define CVMX_IPD_2nd_NEXT_PTR_BACK \
+	 CVMX_ADD_IO_SEG(0x00014F0000000158ull)
+#define CVMX_IPD_BIST_STATUS \
+	 CVMX_ADD_IO_SEG(0x00014F00000007F8ull)
+#define CVMX_IPD_BP_PRT_RED_END \
+	 CVMX_ADD_IO_SEG(0x00014F0000000328ull)
+#define CVMX_IPD_CLK_COUNT \
+	 CVMX_ADD_IO_SEG(0x00014F0000000338ull)
+#define CVMX_IPD_CTL_STATUS \
+	 CVMX_ADD_IO_SEG(0x00014F0000000018ull)
+#define CVMX_IPD_INT_ENB \
+	 CVMX_ADD_IO_SEG(0x00014F0000000160ull)
+#define CVMX_IPD_INT_SUM \
+	 CVMX_ADD_IO_SEG(0x00014F0000000168ull)
+#define CVMX_IPD_NOT_1ST_MBUFF_SKIP \
+	 CVMX_ADD_IO_SEG(0x00014F0000000008ull)
+#define CVMX_IPD_PACKET_MBUFF_SIZE \
+	 CVMX_ADD_IO_SEG(0x00014F0000000010ull)
+#define CVMX_IPD_PKT_PTR_VALID \
+	 CVMX_ADD_IO_SEG(0x00014F0000000358ull)
+#define CVMX_IPD_PORTX_BP_PAGE_CNT(offset) \
+	 CVMX_ADD_IO_SEG(0x00014F0000000028ull + (((offset) & 63) * 8))
+#define CVMX_IPD_PORTX_BP_PAGE_CNT2(offset) \
+	 CVMX_ADD_IO_SEG(0x00014F0000000368ull + (((offset) & 63) * 8) - 8 * 36)
+#define CVMX_IPD_PORT_BP_COUNTERS2_PAIRX(offset) \
+	 CVMX_ADD_IO_SEG(0x00014F0000000388ull + (((offset) & 63) * 8) - 8 * 36)
+#define CVMX_IPD_PORT_BP_COUNTERS_PAIRX(offset) \
+	 CVMX_ADD_IO_SEG(0x00014F00000001B8ull + (((offset) & 63) * 8))
+#define CVMX_IPD_PORT_QOS_INTX(offset) \
+	 CVMX_ADD_IO_SEG(0x00014F0000000808ull + (((offset) & 7) * 8))
+#define CVMX_IPD_PORT_QOS_INT_ENBX(offset) \
+	 CVMX_ADD_IO_SEG(0x00014F0000000848ull + (((offset) & 7) * 8))
+#define CVMX_IPD_PORT_QOS_X_CNT(offset) \
+	 CVMX_ADD_IO_SEG(0x00014F0000000888ull + (((offset) & 511) * 8))
+#define CVMX_IPD_PRC_HOLD_PTR_FIFO_CTL \
+	 CVMX_ADD_IO_SEG(0x00014F0000000348ull)
+#define CVMX_IPD_PRC_PORT_PTR_FIFO_CTL \
+	 CVMX_ADD_IO_SEG(0x00014F0000000350ull)
+#define CVMX_IPD_PTR_COUNT \
+	 CVMX_ADD_IO_SEG(0x00014F0000000320ull)
+#define CVMX_IPD_PWP_PTR_FIFO_CTL \
+	 CVMX_ADD_IO_SEG(0x00014F0000000340ull)
+#define CVMX_IPD_QOS0_RED_MARKS \
+	 CVMX_ADD_IO_SEG(0x00014F0000000178ull)
+#define CVMX_IPD_QOS1_RED_MARKS \
+	 CVMX_ADD_IO_SEG(0x00014F0000000180ull)
+#define CVMX_IPD_QOS2_RED_MARKS \
+	 CVMX_ADD_IO_SEG(0x00014F0000000188ull)
+#define CVMX_IPD_QOS3_RED_MARKS \
+	 CVMX_ADD_IO_SEG(0x00014F0000000190ull)
+#define CVMX_IPD_QOS4_RED_MARKS \
+	 CVMX_ADD_IO_SEG(0x00014F0000000198ull)
+#define CVMX_IPD_QOS5_RED_MARKS \
+	 CVMX_ADD_IO_SEG(0x00014F00000001A0ull)
+#define CVMX_IPD_QOS6_RED_MARKS \
+	 CVMX_ADD_IO_SEG(0x00014F00000001A8ull)
+#define CVMX_IPD_QOS7_RED_MARKS \
+	 CVMX_ADD_IO_SEG(0x00014F00000001B0ull)
+#define CVMX_IPD_QOSX_RED_MARKS(offset) \
+	 CVMX_ADD_IO_SEG(0x00014F0000000178ull + (((offset) & 7) * 8))
+#define CVMX_IPD_QUE0_FREE_PAGE_CNT \
+	 CVMX_ADD_IO_SEG(0x00014F0000000330ull)
+#define CVMX_IPD_RED_PORT_ENABLE \
+	 CVMX_ADD_IO_SEG(0x00014F00000002D8ull)
+#define CVMX_IPD_RED_PORT_ENABLE2 \
+	 CVMX_ADD_IO_SEG(0x00014F00000003A8ull)
+#define CVMX_IPD_RED_QUE0_PARAM \
+	 CVMX_ADD_IO_SEG(0x00014F00000002E0ull)
+#define CVMX_IPD_RED_QUE1_PARAM \
+	 CVMX_ADD_IO_SEG(0x00014F00000002E8ull)
+#define CVMX_IPD_RED_QUE2_PARAM \
+	 CVMX_ADD_IO_SEG(0x00014F00000002F0ull)
+#define CVMX_IPD_RED_QUE3_PARAM \
+	 CVMX_ADD_IO_SEG(0x00014F00000002F8ull)
+#define CVMX_IPD_RED_QUE4_PARAM \
+	 CVMX_ADD_IO_SEG(0x00014F0000000300ull)
+#define CVMX_IPD_RED_QUE5_PARAM \
+	 CVMX_ADD_IO_SEG(0x00014F0000000308ull)
+#define CVMX_IPD_RED_QUE6_PARAM \
+	 CVMX_ADD_IO_SEG(0x00014F0000000310ull)
+#define CVMX_IPD_RED_QUE7_PARAM \
+	 CVMX_ADD_IO_SEG(0x00014F0000000318ull)
+#define CVMX_IPD_RED_QUEX_PARAM(offset) \
+	 CVMX_ADD_IO_SEG(0x00014F00000002E0ull + (((offset) & 7) * 8))
+#define CVMX_IPD_SUB_PORT_BP_PAGE_CNT \
+	 CVMX_ADD_IO_SEG(0x00014F0000000148ull)
+#define CVMX_IPD_SUB_PORT_FCS \
+	 CVMX_ADD_IO_SEG(0x00014F0000000170ull)
+#define CVMX_IPD_SUB_PORT_QOS_CNT \
+	 CVMX_ADD_IO_SEG(0x00014F0000000800ull)
+#define CVMX_IPD_WQE_FPA_QUEUE \
+	 CVMX_ADD_IO_SEG(0x00014F0000000020ull)
+#define CVMX_IPD_WQE_PTR_VALID \
+	 CVMX_ADD_IO_SEG(0x00014F0000000360ull)
+
+union cvmx_ipd_1st_mbuff_skip {
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
+};
+
+union cvmx_ipd_1st_next_ptr_back {
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
+};
+
+union cvmx_ipd_2nd_next_ptr_back {
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
+};
+
+union cvmx_ipd_bist_status {
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
+};
+
+union cvmx_ipd_bp_prt_red_end {
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
+};
+
+union cvmx_ipd_clk_count {
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
+};
+
+union cvmx_ipd_ctl_status {
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
+		uint64_t opc_mode:2;
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
+		uint64_t opc_mode:2;
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
+		uint64_t opc_mode:2;
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
+		uint64_t opc_mode:2;
+		uint64_t ipd_en:1;
+	} cn58xx;
+	struct cvmx_ipd_ctl_status_cn58xx cn58xxp1;
+};
+
+union cvmx_ipd_int_enb {
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
+};
+
+union cvmx_ipd_int_sum {
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
+};
+
+union cvmx_ipd_not_1st_mbuff_skip {
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
+};
+
+union cvmx_ipd_packet_mbuff_size {
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
+};
+
+union cvmx_ipd_pkt_ptr_valid {
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
+};
+
+union cvmx_ipd_portx_bp_page_cnt {
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
+};
+
+union cvmx_ipd_portx_bp_page_cnt2 {
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
+};
+
+union cvmx_ipd_port_bp_counters2_pairx {
+	uint64_t u64;
+	struct cvmx_ipd_port_bp_counters2_pairx_s {
+		uint64_t reserved_25_63:39;
+		uint64_t cnt_val:25;
+	} s;
+	struct cvmx_ipd_port_bp_counters2_pairx_s cn52xx;
+	struct cvmx_ipd_port_bp_counters2_pairx_s cn52xxp1;
+	struct cvmx_ipd_port_bp_counters2_pairx_s cn56xx;
+	struct cvmx_ipd_port_bp_counters2_pairx_s cn56xxp1;
+};
+
+union cvmx_ipd_port_bp_counters_pairx {
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
+};
+
+union cvmx_ipd_port_qos_x_cnt {
+	uint64_t u64;
+	struct cvmx_ipd_port_qos_x_cnt_s {
+		uint64_t wmark:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_ipd_port_qos_x_cnt_s cn52xx;
+	struct cvmx_ipd_port_qos_x_cnt_s cn52xxp1;
+	struct cvmx_ipd_port_qos_x_cnt_s cn56xx;
+	struct cvmx_ipd_port_qos_x_cnt_s cn56xxp1;
+};
+
+union cvmx_ipd_port_qos_intx {
+	uint64_t u64;
+	struct cvmx_ipd_port_qos_intx_s {
+		uint64_t intr:64;
+	} s;
+	struct cvmx_ipd_port_qos_intx_s cn52xx;
+	struct cvmx_ipd_port_qos_intx_s cn52xxp1;
+	struct cvmx_ipd_port_qos_intx_s cn56xx;
+	struct cvmx_ipd_port_qos_intx_s cn56xxp1;
+};
+
+union cvmx_ipd_port_qos_int_enbx {
+	uint64_t u64;
+	struct cvmx_ipd_port_qos_int_enbx_s {
+		uint64_t enb:64;
+	} s;
+	struct cvmx_ipd_port_qos_int_enbx_s cn52xx;
+	struct cvmx_ipd_port_qos_int_enbx_s cn52xxp1;
+	struct cvmx_ipd_port_qos_int_enbx_s cn56xx;
+	struct cvmx_ipd_port_qos_int_enbx_s cn56xxp1;
+};
+
+union cvmx_ipd_prc_hold_ptr_fifo_ctl {
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
+};
+
+union cvmx_ipd_prc_port_ptr_fifo_ctl {
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
+};
+
+union cvmx_ipd_ptr_count {
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
+};
+
+union cvmx_ipd_pwp_ptr_fifo_ctl {
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
+};
+
+union cvmx_ipd_qosx_red_marks {
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
+};
+
+union cvmx_ipd_que0_free_page_cnt {
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
+};
+
+union cvmx_ipd_red_port_enable {
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
+};
+
+union cvmx_ipd_red_port_enable2 {
+	uint64_t u64;
+	struct cvmx_ipd_red_port_enable2_s {
+		uint64_t reserved_4_63:60;
+		uint64_t prt_enb:4;
+	} s;
+	struct cvmx_ipd_red_port_enable2_s cn52xx;
+	struct cvmx_ipd_red_port_enable2_s cn52xxp1;
+	struct cvmx_ipd_red_port_enable2_s cn56xx;
+	struct cvmx_ipd_red_port_enable2_s cn56xxp1;
+};
+
+union cvmx_ipd_red_quex_param {
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
+};
+
+union cvmx_ipd_sub_port_bp_page_cnt {
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
+};
+
+union cvmx_ipd_sub_port_fcs {
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
+};
+
+union cvmx_ipd_sub_port_qos_cnt {
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
+};
+
+union cvmx_ipd_wqe_fpa_queue {
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
+};
+
+union cvmx_ipd_wqe_ptr_valid {
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
+};
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-l2c-defs.h b/arch/mips/include/asm/octeon/cvmx-l2c-defs.h
new file mode 100644
index 0000000..3375838
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-l2c-defs.h
@@ -0,0 +1,963 @@
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
+#ifndef __CVMX_L2C_DEFS_H__
+#define __CVMX_L2C_DEFS_H__
+
+#define CVMX_L2C_BST0 \
+	 CVMX_ADD_IO_SEG(0x00011800800007F8ull)
+#define CVMX_L2C_BST1 \
+	 CVMX_ADD_IO_SEG(0x00011800800007F0ull)
+#define CVMX_L2C_BST2 \
+	 CVMX_ADD_IO_SEG(0x00011800800007E8ull)
+#define CVMX_L2C_CFG \
+	 CVMX_ADD_IO_SEG(0x0001180080000000ull)
+#define CVMX_L2C_DBG \
+	 CVMX_ADD_IO_SEG(0x0001180080000030ull)
+#define CVMX_L2C_DUT \
+	 CVMX_ADD_IO_SEG(0x0001180080000050ull)
+#define CVMX_L2C_GRPWRR0 \
+	 CVMX_ADD_IO_SEG(0x00011800800000C8ull)
+#define CVMX_L2C_GRPWRR1 \
+	 CVMX_ADD_IO_SEG(0x00011800800000D0ull)
+#define CVMX_L2C_INT_EN \
+	 CVMX_ADD_IO_SEG(0x0001180080000100ull)
+#define CVMX_L2C_INT_STAT \
+	 CVMX_ADD_IO_SEG(0x00011800800000F8ull)
+#define CVMX_L2C_LCKBASE \
+	 CVMX_ADD_IO_SEG(0x0001180080000058ull)
+#define CVMX_L2C_LCKOFF \
+	 CVMX_ADD_IO_SEG(0x0001180080000060ull)
+#define CVMX_L2C_LFB0 \
+	 CVMX_ADD_IO_SEG(0x0001180080000038ull)
+#define CVMX_L2C_LFB1 \
+	 CVMX_ADD_IO_SEG(0x0001180080000040ull)
+#define CVMX_L2C_LFB2 \
+	 CVMX_ADD_IO_SEG(0x0001180080000048ull)
+#define CVMX_L2C_LFB3 \
+	 CVMX_ADD_IO_SEG(0x00011800800000B8ull)
+#define CVMX_L2C_OOB \
+	 CVMX_ADD_IO_SEG(0x00011800800000D8ull)
+#define CVMX_L2C_OOB1 \
+	 CVMX_ADD_IO_SEG(0x00011800800000E0ull)
+#define CVMX_L2C_OOB2 \
+	 CVMX_ADD_IO_SEG(0x00011800800000E8ull)
+#define CVMX_L2C_OOB3 \
+	 CVMX_ADD_IO_SEG(0x00011800800000F0ull)
+#define CVMX_L2C_PFC0 \
+	 CVMX_ADD_IO_SEG(0x0001180080000098ull)
+#define CVMX_L2C_PFC1 \
+	 CVMX_ADD_IO_SEG(0x00011800800000A0ull)
+#define CVMX_L2C_PFC2 \
+	 CVMX_ADD_IO_SEG(0x00011800800000A8ull)
+#define CVMX_L2C_PFC3 \
+	 CVMX_ADD_IO_SEG(0x00011800800000B0ull)
+#define CVMX_L2C_PFCTL \
+	 CVMX_ADD_IO_SEG(0x0001180080000090ull)
+#define CVMX_L2C_PFCX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180080000098ull + (((offset) & 3) * 8))
+#define CVMX_L2C_PPGRP \
+	 CVMX_ADD_IO_SEG(0x00011800800000C0ull)
+#define CVMX_L2C_SPAR0 \
+	 CVMX_ADD_IO_SEG(0x0001180080000068ull)
+#define CVMX_L2C_SPAR1 \
+	 CVMX_ADD_IO_SEG(0x0001180080000070ull)
+#define CVMX_L2C_SPAR2 \
+	 CVMX_ADD_IO_SEG(0x0001180080000078ull)
+#define CVMX_L2C_SPAR3 \
+	 CVMX_ADD_IO_SEG(0x0001180080000080ull)
+#define CVMX_L2C_SPAR4 \
+	 CVMX_ADD_IO_SEG(0x0001180080000088ull)
+
+union cvmx_l2c_bst0 {
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
+};
+
+union cvmx_l2c_bst1 {
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
+};
+
+union cvmx_l2c_bst2 {
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
+};
+
+union cvmx_l2c_cfg {
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
+};
+
+union cvmx_l2c_dbg {
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
+};
+
+union cvmx_l2c_dut {
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
+};
+
+union cvmx_l2c_grpwrr0 {
+	uint64_t u64;
+	struct cvmx_l2c_grpwrr0_s {
+		uint64_t plc1rmsk:32;
+		uint64_t plc0rmsk:32;
+	} s;
+	struct cvmx_l2c_grpwrr0_s cn52xx;
+	struct cvmx_l2c_grpwrr0_s cn52xxp1;
+	struct cvmx_l2c_grpwrr0_s cn56xx;
+	struct cvmx_l2c_grpwrr0_s cn56xxp1;
+};
+
+union cvmx_l2c_grpwrr1 {
+	uint64_t u64;
+	struct cvmx_l2c_grpwrr1_s {
+		uint64_t ilcrmsk:32;
+		uint64_t plc2rmsk:32;
+	} s;
+	struct cvmx_l2c_grpwrr1_s cn52xx;
+	struct cvmx_l2c_grpwrr1_s cn52xxp1;
+	struct cvmx_l2c_grpwrr1_s cn56xx;
+	struct cvmx_l2c_grpwrr1_s cn56xxp1;
+};
+
+union cvmx_l2c_int_en {
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
+};
+
+union cvmx_l2c_int_stat {
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
+};
+
+union cvmx_l2c_lckbase {
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
+};
+
+union cvmx_l2c_lckoff {
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
+};
+
+union cvmx_l2c_lfb0 {
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
+};
+
+union cvmx_l2c_lfb1 {
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
+};
+
+union cvmx_l2c_lfb2 {
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
+};
+
+union cvmx_l2c_lfb3 {
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
+};
+
+union cvmx_l2c_oob {
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
+};
+
+union cvmx_l2c_oob1 {
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
+};
+
+union cvmx_l2c_oob2 {
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
+};
+
+union cvmx_l2c_oob3 {
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
+};
+
+union cvmx_l2c_pfcx {
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
+};
+
+union cvmx_l2c_pfctl {
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
+};
+
+union cvmx_l2c_ppgrp {
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
+};
+
+union cvmx_l2c_spar0 {
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
+};
+
+union cvmx_l2c_spar1 {
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
+};
+
+union cvmx_l2c_spar2 {
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
+};
+
+union cvmx_l2c_spar3 {
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
+};
+
+union cvmx_l2c_spar4 {
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
+};
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-l2d-defs.h b/arch/mips/include/asm/octeon/cvmx-l2d-defs.h
new file mode 100644
index 0000000..d7102d4
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-l2d-defs.h
@@ -0,0 +1,369 @@
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
+#ifndef __CVMX_L2D_DEFS_H__
+#define __CVMX_L2D_DEFS_H__
+
+#define CVMX_L2D_BST0 \
+	 CVMX_ADD_IO_SEG(0x0001180080000780ull)
+#define CVMX_L2D_BST1 \
+	 CVMX_ADD_IO_SEG(0x0001180080000788ull)
+#define CVMX_L2D_BST2 \
+	 CVMX_ADD_IO_SEG(0x0001180080000790ull)
+#define CVMX_L2D_BST3 \
+	 CVMX_ADD_IO_SEG(0x0001180080000798ull)
+#define CVMX_L2D_ERR \
+	 CVMX_ADD_IO_SEG(0x0001180080000010ull)
+#define CVMX_L2D_FADR \
+	 CVMX_ADD_IO_SEG(0x0001180080000018ull)
+#define CVMX_L2D_FSYN0 \
+	 CVMX_ADD_IO_SEG(0x0001180080000020ull)
+#define CVMX_L2D_FSYN1 \
+	 CVMX_ADD_IO_SEG(0x0001180080000028ull)
+#define CVMX_L2D_FUS0 \
+	 CVMX_ADD_IO_SEG(0x00011800800007A0ull)
+#define CVMX_L2D_FUS1 \
+	 CVMX_ADD_IO_SEG(0x00011800800007A8ull)
+#define CVMX_L2D_FUS2 \
+	 CVMX_ADD_IO_SEG(0x00011800800007B0ull)
+#define CVMX_L2D_FUS3 \
+	 CVMX_ADD_IO_SEG(0x00011800800007B8ull)
+
+union cvmx_l2d_bst0 {
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
+};
+
+union cvmx_l2d_bst1 {
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
+};
+
+union cvmx_l2d_bst2 {
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
+};
+
+union cvmx_l2d_bst3 {
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
+};
+
+union cvmx_l2d_err {
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
+};
+
+union cvmx_l2d_fadr {
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
+};
+
+union cvmx_l2d_fsyn0 {
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
+};
+
+union cvmx_l2d_fsyn1 {
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
+};
+
+union cvmx_l2d_fus0 {
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
+};
+
+union cvmx_l2d_fus1 {
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
+};
+
+union cvmx_l2d_fus2 {
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
+};
+
+union cvmx_l2d_fus3 {
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
+};
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-l2t-defs.h b/arch/mips/include/asm/octeon/cvmx-l2t-defs.h
new file mode 100644
index 0000000..2639a3f
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-l2t-defs.h
@@ -0,0 +1,141 @@
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
+#ifndef __CVMX_L2T_DEFS_H__
+#define __CVMX_L2T_DEFS_H__
+
+#define CVMX_L2T_ERR \
+	 CVMX_ADD_IO_SEG(0x0001180080000008ull)
+
+union cvmx_l2t_err {
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
+};
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-led-defs.h b/arch/mips/include/asm/octeon/cvmx-led-defs.h
new file mode 100644
index 0000000..16f174a
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-led-defs.h
@@ -0,0 +1,240 @@
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
+#ifndef __CVMX_LED_DEFS_H__
+#define __CVMX_LED_DEFS_H__
+
+#define CVMX_LED_BLINK \
+	 CVMX_ADD_IO_SEG(0x0001180000001A48ull)
+#define CVMX_LED_CLK_PHASE \
+	 CVMX_ADD_IO_SEG(0x0001180000001A08ull)
+#define CVMX_LED_CYLON \
+	 CVMX_ADD_IO_SEG(0x0001180000001AF8ull)
+#define CVMX_LED_DBG \
+	 CVMX_ADD_IO_SEG(0x0001180000001A18ull)
+#define CVMX_LED_EN \
+	 CVMX_ADD_IO_SEG(0x0001180000001A00ull)
+#define CVMX_LED_POLARITY \
+	 CVMX_ADD_IO_SEG(0x0001180000001A50ull)
+#define CVMX_LED_PRT \
+	 CVMX_ADD_IO_SEG(0x0001180000001A10ull)
+#define CVMX_LED_PRT_FMT \
+	 CVMX_ADD_IO_SEG(0x0001180000001A30ull)
+#define CVMX_LED_PRT_STATUSX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000001A80ull + (((offset) & 7) * 8))
+#define CVMX_LED_UDD_CNTX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000001A20ull + (((offset) & 1) * 8))
+#define CVMX_LED_UDD_DATX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000001A38ull + (((offset) & 1) * 8))
+#define CVMX_LED_UDD_DAT_CLRX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000001AC8ull + (((offset) & 1) * 16))
+#define CVMX_LED_UDD_DAT_SETX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000001AC0ull + (((offset) & 1) * 16))
+
+union cvmx_led_blink {
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
+};
+
+union cvmx_led_clk_phase {
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
+};
+
+union cvmx_led_cylon {
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
+};
+
+union cvmx_led_dbg {
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
+};
+
+union cvmx_led_en {
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
+};
+
+union cvmx_led_polarity {
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
+};
+
+union cvmx_led_prt {
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
+};
+
+union cvmx_led_prt_fmt {
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
+};
+
+union cvmx_led_prt_statusx {
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
+};
+
+union cvmx_led_udd_cntx {
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
+};
+
+union cvmx_led_udd_datx {
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
+};
+
+union cvmx_led_udd_dat_clrx {
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
+};
+
+union cvmx_led_udd_dat_setx {
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
+};
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-mio-defs.h b/arch/mips/include/asm/octeon/cvmx-mio-defs.h
new file mode 100644
index 0000000..6555f05
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-mio-defs.h
@@ -0,0 +1,2004 @@
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
+#ifndef __CVMX_MIO_DEFS_H__
+#define __CVMX_MIO_DEFS_H__
+
+#define CVMX_MIO_BOOT_BIST_STAT \
+	 CVMX_ADD_IO_SEG(0x00011800000000F8ull)
+#define CVMX_MIO_BOOT_COMP \
+	 CVMX_ADD_IO_SEG(0x00011800000000B8ull)
+#define CVMX_MIO_BOOT_DMA_CFGX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000100ull + (((offset) & 3) * 8))
+#define CVMX_MIO_BOOT_DMA_INTX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000138ull + (((offset) & 3) * 8))
+#define CVMX_MIO_BOOT_DMA_INT_ENX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000150ull + (((offset) & 3) * 8))
+#define CVMX_MIO_BOOT_DMA_TIMX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000120ull + (((offset) & 3) * 8))
+#define CVMX_MIO_BOOT_ERR \
+	 CVMX_ADD_IO_SEG(0x00011800000000A0ull)
+#define CVMX_MIO_BOOT_INT \
+	 CVMX_ADD_IO_SEG(0x00011800000000A8ull)
+#define CVMX_MIO_BOOT_LOC_ADR \
+	 CVMX_ADD_IO_SEG(0x0001180000000090ull)
+#define CVMX_MIO_BOOT_LOC_CFGX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000080ull + (((offset) & 1) * 8))
+#define CVMX_MIO_BOOT_LOC_DAT \
+	 CVMX_ADD_IO_SEG(0x0001180000000098ull)
+#define CVMX_MIO_BOOT_PIN_DEFS \
+	 CVMX_ADD_IO_SEG(0x00011800000000C0ull)
+#define CVMX_MIO_BOOT_REG_CFGX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000000ull + (((offset) & 7) * 8))
+#define CVMX_MIO_BOOT_REG_TIMX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000040ull + (((offset) & 7) * 8))
+#define CVMX_MIO_BOOT_THR \
+	 CVMX_ADD_IO_SEG(0x00011800000000B0ull)
+#define CVMX_MIO_FUS_BNK_DATX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000001520ull + (((offset) & 3) * 8))
+#define CVMX_MIO_FUS_DAT0 \
+	 CVMX_ADD_IO_SEG(0x0001180000001400ull)
+#define CVMX_MIO_FUS_DAT1 \
+	 CVMX_ADD_IO_SEG(0x0001180000001408ull)
+#define CVMX_MIO_FUS_DAT2 \
+	 CVMX_ADD_IO_SEG(0x0001180000001410ull)
+#define CVMX_MIO_FUS_DAT3 \
+	 CVMX_ADD_IO_SEG(0x0001180000001418ull)
+#define CVMX_MIO_FUS_EMA \
+	 CVMX_ADD_IO_SEG(0x0001180000001550ull)
+#define CVMX_MIO_FUS_PDF \
+	 CVMX_ADD_IO_SEG(0x0001180000001420ull)
+#define CVMX_MIO_FUS_PLL \
+	 CVMX_ADD_IO_SEG(0x0001180000001580ull)
+#define CVMX_MIO_FUS_PROG \
+	 CVMX_ADD_IO_SEG(0x0001180000001510ull)
+#define CVMX_MIO_FUS_PROG_TIMES \
+	 CVMX_ADD_IO_SEG(0x0001180000001518ull)
+#define CVMX_MIO_FUS_RCMD \
+	 CVMX_ADD_IO_SEG(0x0001180000001500ull)
+#define CVMX_MIO_FUS_SPR_REPAIR_RES \
+	 CVMX_ADD_IO_SEG(0x0001180000001548ull)
+#define CVMX_MIO_FUS_SPR_REPAIR_SUM \
+	 CVMX_ADD_IO_SEG(0x0001180000001540ull)
+#define CVMX_MIO_FUS_UNLOCK \
+	 CVMX_ADD_IO_SEG(0x0001180000001578ull)
+#define CVMX_MIO_FUS_WADR \
+	 CVMX_ADD_IO_SEG(0x0001180000001508ull)
+#define CVMX_MIO_NDF_DMA_CFG \
+	 CVMX_ADD_IO_SEG(0x0001180000000168ull)
+#define CVMX_MIO_NDF_DMA_INT \
+	 CVMX_ADD_IO_SEG(0x0001180000000170ull)
+#define CVMX_MIO_NDF_DMA_INT_EN \
+	 CVMX_ADD_IO_SEG(0x0001180000000178ull)
+#define CVMX_MIO_PLL_CTL \
+	 CVMX_ADD_IO_SEG(0x0001180000001448ull)
+#define CVMX_MIO_PLL_SETTING \
+	 CVMX_ADD_IO_SEG(0x0001180000001440ull)
+#define CVMX_MIO_TWSX_INT(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000001010ull + (((offset) & 1) * 512))
+#define CVMX_MIO_TWSX_SW_TWSI(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000001000ull + (((offset) & 1) * 512))
+#define CVMX_MIO_TWSX_SW_TWSI_EXT(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000001018ull + (((offset) & 1) * 512))
+#define CVMX_MIO_TWSX_TWSI_SW(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000001008ull + (((offset) & 1) * 512))
+#define CVMX_MIO_UART2_DLH \
+	 CVMX_ADD_IO_SEG(0x0001180000000488ull)
+#define CVMX_MIO_UART2_DLL \
+	 CVMX_ADD_IO_SEG(0x0001180000000480ull)
+#define CVMX_MIO_UART2_FAR \
+	 CVMX_ADD_IO_SEG(0x0001180000000520ull)
+#define CVMX_MIO_UART2_FCR \
+	 CVMX_ADD_IO_SEG(0x0001180000000450ull)
+#define CVMX_MIO_UART2_HTX \
+	 CVMX_ADD_IO_SEG(0x0001180000000708ull)
+#define CVMX_MIO_UART2_IER \
+	 CVMX_ADD_IO_SEG(0x0001180000000408ull)
+#define CVMX_MIO_UART2_IIR \
+	 CVMX_ADD_IO_SEG(0x0001180000000410ull)
+#define CVMX_MIO_UART2_LCR \
+	 CVMX_ADD_IO_SEG(0x0001180000000418ull)
+#define CVMX_MIO_UART2_LSR \
+	 CVMX_ADD_IO_SEG(0x0001180000000428ull)
+#define CVMX_MIO_UART2_MCR \
+	 CVMX_ADD_IO_SEG(0x0001180000000420ull)
+#define CVMX_MIO_UART2_MSR \
+	 CVMX_ADD_IO_SEG(0x0001180000000430ull)
+#define CVMX_MIO_UART2_RBR \
+	 CVMX_ADD_IO_SEG(0x0001180000000400ull)
+#define CVMX_MIO_UART2_RFL \
+	 CVMX_ADD_IO_SEG(0x0001180000000608ull)
+#define CVMX_MIO_UART2_RFW \
+	 CVMX_ADD_IO_SEG(0x0001180000000530ull)
+#define CVMX_MIO_UART2_SBCR \
+	 CVMX_ADD_IO_SEG(0x0001180000000620ull)
+#define CVMX_MIO_UART2_SCR \
+	 CVMX_ADD_IO_SEG(0x0001180000000438ull)
+#define CVMX_MIO_UART2_SFE \
+	 CVMX_ADD_IO_SEG(0x0001180000000630ull)
+#define CVMX_MIO_UART2_SRR \
+	 CVMX_ADD_IO_SEG(0x0001180000000610ull)
+#define CVMX_MIO_UART2_SRT \
+	 CVMX_ADD_IO_SEG(0x0001180000000638ull)
+#define CVMX_MIO_UART2_SRTS \
+	 CVMX_ADD_IO_SEG(0x0001180000000618ull)
+#define CVMX_MIO_UART2_STT \
+	 CVMX_ADD_IO_SEG(0x0001180000000700ull)
+#define CVMX_MIO_UART2_TFL \
+	 CVMX_ADD_IO_SEG(0x0001180000000600ull)
+#define CVMX_MIO_UART2_TFR \
+	 CVMX_ADD_IO_SEG(0x0001180000000528ull)
+#define CVMX_MIO_UART2_THR \
+	 CVMX_ADD_IO_SEG(0x0001180000000440ull)
+#define CVMX_MIO_UART2_USR \
+	 CVMX_ADD_IO_SEG(0x0001180000000538ull)
+#define CVMX_MIO_UARTX_DLH(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000888ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_DLL(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000880ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_FAR(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000920ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_FCR(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000850ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_HTX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000B08ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_IER(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000808ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_IIR(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000810ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_LCR(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000818ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_LSR(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000828ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_MCR(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000820ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_MSR(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000830ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_RBR(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000800ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_RFL(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000A08ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_RFW(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000930ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_SBCR(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000A20ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_SCR(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000838ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_SFE(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000A30ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_SRR(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000A10ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_SRT(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000A38ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_SRTS(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000A18ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_STT(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000B00ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_TFL(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000A00ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_TFR(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000928ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_THR(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000840ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_USR(offset) \
+	 CVMX_ADD_IO_SEG(0x0001180000000938ull + (((offset) & 1) * 1024))
+
+union cvmx_mio_boot_bist_stat {
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
+};
+
+union cvmx_mio_boot_comp {
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
+};
+
+union cvmx_mio_boot_dma_cfgx {
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
+};
+
+union cvmx_mio_boot_dma_intx {
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
+};
+
+union cvmx_mio_boot_dma_int_enx {
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
+};
+
+union cvmx_mio_boot_dma_timx {
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
+};
+
+union cvmx_mio_boot_err {
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
+};
+
+union cvmx_mio_boot_int {
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
+};
+
+union cvmx_mio_boot_loc_adr {
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
+};
+
+union cvmx_mio_boot_loc_cfgx {
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
+};
+
+union cvmx_mio_boot_loc_dat {
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
+};
+
+union cvmx_mio_boot_pin_defs {
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
+};
+
+union cvmx_mio_boot_reg_cfgx {
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
+};
+
+union cvmx_mio_boot_reg_timx {
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
+};
+
+union cvmx_mio_boot_thr {
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
+};
+
+union cvmx_mio_fus_bnk_datx {
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
+};
+
+union cvmx_mio_fus_dat0 {
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
+};
+
+union cvmx_mio_fus_dat1 {
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
+};
+
+union cvmx_mio_fus_dat2 {
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
+};
+
+union cvmx_mio_fus_dat3 {
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
+};
+
+union cvmx_mio_fus_ema {
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
+};
+
+union cvmx_mio_fus_pdf {
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
+};
+
+union cvmx_mio_fus_pll {
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
+};
+
+union cvmx_mio_fus_prog {
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
+};
+
+union cvmx_mio_fus_prog_times {
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
+};
+
+union cvmx_mio_fus_rcmd {
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
+};
+
+union cvmx_mio_fus_spr_repair_res {
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
+};
+
+union cvmx_mio_fus_spr_repair_sum {
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
+};
+
+union cvmx_mio_fus_unlock {
+	uint64_t u64;
+	struct cvmx_mio_fus_unlock_s {
+		uint64_t reserved_24_63:40;
+		uint64_t key:24;
+	} s;
+	struct cvmx_mio_fus_unlock_s cn30xx;
+	struct cvmx_mio_fus_unlock_s cn31xx;
+};
+
+union cvmx_mio_fus_wadr {
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
+};
+
+union cvmx_mio_ndf_dma_cfg {
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
+};
+
+union cvmx_mio_ndf_dma_int {
+	uint64_t u64;
+	struct cvmx_mio_ndf_dma_int_s {
+		uint64_t reserved_1_63:63;
+		uint64_t done:1;
+	} s;
+	struct cvmx_mio_ndf_dma_int_s cn52xx;
+};
+
+union cvmx_mio_ndf_dma_int_en {
+	uint64_t u64;
+	struct cvmx_mio_ndf_dma_int_en_s {
+		uint64_t reserved_1_63:63;
+		uint64_t done:1;
+	} s;
+	struct cvmx_mio_ndf_dma_int_en_s cn52xx;
+};
+
+union cvmx_mio_pll_ctl {
+	uint64_t u64;
+	struct cvmx_mio_pll_ctl_s {
+		uint64_t reserved_5_63:59;
+		uint64_t bw_ctl:5;
+	} s;
+	struct cvmx_mio_pll_ctl_s cn30xx;
+	struct cvmx_mio_pll_ctl_s cn31xx;
+};
+
+union cvmx_mio_pll_setting {
+	uint64_t u64;
+	struct cvmx_mio_pll_setting_s {
+		uint64_t reserved_17_63:47;
+		uint64_t setting:17;
+	} s;
+	struct cvmx_mio_pll_setting_s cn30xx;
+	struct cvmx_mio_pll_setting_s cn31xx;
+};
+
+union cvmx_mio_twsx_int {
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
+};
+
+union cvmx_mio_twsx_sw_twsi {
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
+};
+
+union cvmx_mio_twsx_sw_twsi_ext {
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
+};
+
+union cvmx_mio_twsx_twsi_sw {
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
+};
+
+union cvmx_mio_uartx_dlh {
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
+};
+
+union cvmx_mio_uartx_dll {
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
+};
+
+union cvmx_mio_uartx_far {
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
+};
+
+union cvmx_mio_uartx_fcr {
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
+};
+
+union cvmx_mio_uartx_htx {
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
+};
+
+union cvmx_mio_uartx_ier {
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
+};
+
+union cvmx_mio_uartx_iir {
+	uint64_t u64;
+	struct cvmx_mio_uartx_iir_s {
+		uint64_t reserved_8_63:56;
+		uint64_t fen:2;
+		uint64_t reserved_4_5:2;
+		uint64_t iid:4;
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
+};
+
+union cvmx_mio_uartx_lcr {
+	uint64_t u64;
+	struct cvmx_mio_uartx_lcr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t dlab:1;
+		uint64_t brk:1;
+		uint64_t reserved_5_5:1;
+		uint64_t eps:1;
+		uint64_t pen:1;
+		uint64_t stop:1;
+		uint64_t cls:2;
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
+};
+
+union cvmx_mio_uartx_lsr {
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
+};
+
+union cvmx_mio_uartx_mcr {
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
+};
+
+union cvmx_mio_uartx_msr {
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
+};
+
+union cvmx_mio_uartx_rbr {
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
+};
+
+union cvmx_mio_uartx_rfl {
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
+};
+
+union cvmx_mio_uartx_rfw {
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
+};
+
+union cvmx_mio_uartx_sbcr {
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
+};
+
+union cvmx_mio_uartx_scr {
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
+};
+
+union cvmx_mio_uartx_sfe {
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
+};
+
+union cvmx_mio_uartx_srr {
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
+};
+
+union cvmx_mio_uartx_srt {
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
+};
+
+union cvmx_mio_uartx_srts {
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
+};
+
+union cvmx_mio_uartx_stt {
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
+};
+
+union cvmx_mio_uartx_tfl {
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
+};
+
+union cvmx_mio_uartx_tfr {
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
+};
+
+union cvmx_mio_uartx_thr {
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
+};
+
+union cvmx_mio_uartx_usr {
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
+};
+
+union cvmx_mio_uart2_dlh {
+	uint64_t u64;
+	struct cvmx_mio_uart2_dlh_s {
+		uint64_t reserved_8_63:56;
+		uint64_t dlh:8;
+	} s;
+	struct cvmx_mio_uart2_dlh_s cn52xx;
+	struct cvmx_mio_uart2_dlh_s cn52xxp1;
+};
+
+union cvmx_mio_uart2_dll {
+	uint64_t u64;
+	struct cvmx_mio_uart2_dll_s {
+		uint64_t reserved_8_63:56;
+		uint64_t dll:8;
+	} s;
+	struct cvmx_mio_uart2_dll_s cn52xx;
+	struct cvmx_mio_uart2_dll_s cn52xxp1;
+};
+
+union cvmx_mio_uart2_far {
+	uint64_t u64;
+	struct cvmx_mio_uart2_far_s {
+		uint64_t reserved_1_63:63;
+		uint64_t far:1;
+	} s;
+	struct cvmx_mio_uart2_far_s cn52xx;
+	struct cvmx_mio_uart2_far_s cn52xxp1;
+};
+
+union cvmx_mio_uart2_fcr {
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
+};
+
+union cvmx_mio_uart2_htx {
+	uint64_t u64;
+	struct cvmx_mio_uart2_htx_s {
+		uint64_t reserved_1_63:63;
+		uint64_t htx:1;
+	} s;
+	struct cvmx_mio_uart2_htx_s cn52xx;
+	struct cvmx_mio_uart2_htx_s cn52xxp1;
+};
+
+union cvmx_mio_uart2_ier {
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
+};
+
+union cvmx_mio_uart2_iir {
+	uint64_t u64;
+	struct cvmx_mio_uart2_iir_s {
+		uint64_t reserved_8_63:56;
+		uint64_t fen:2;
+		uint64_t reserved_4_5:2;
+		uint64_t iid:4;
+	} s;
+	struct cvmx_mio_uart2_iir_s cn52xx;
+	struct cvmx_mio_uart2_iir_s cn52xxp1;
+};
+
+union cvmx_mio_uart2_lcr {
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
+};
+
+union cvmx_mio_uart2_lsr {
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
+};
+
+union cvmx_mio_uart2_mcr {
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
+};
+
+union cvmx_mio_uart2_msr {
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
+};
+
+union cvmx_mio_uart2_rbr {
+	uint64_t u64;
+	struct cvmx_mio_uart2_rbr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t rbr:8;
+	} s;
+	struct cvmx_mio_uart2_rbr_s cn52xx;
+	struct cvmx_mio_uart2_rbr_s cn52xxp1;
+};
+
+union cvmx_mio_uart2_rfl {
+	uint64_t u64;
+	struct cvmx_mio_uart2_rfl_s {
+		uint64_t reserved_7_63:57;
+		uint64_t rfl:7;
+	} s;
+	struct cvmx_mio_uart2_rfl_s cn52xx;
+	struct cvmx_mio_uart2_rfl_s cn52xxp1;
+};
+
+union cvmx_mio_uart2_rfw {
+	uint64_t u64;
+	struct cvmx_mio_uart2_rfw_s {
+		uint64_t reserved_10_63:54;
+		uint64_t rffe:1;
+		uint64_t rfpe:1;
+		uint64_t rfwd:8;
+	} s;
+	struct cvmx_mio_uart2_rfw_s cn52xx;
+	struct cvmx_mio_uart2_rfw_s cn52xxp1;
+};
+
+union cvmx_mio_uart2_sbcr {
+	uint64_t u64;
+	struct cvmx_mio_uart2_sbcr_s {
+		uint64_t reserved_1_63:63;
+		uint64_t sbcr:1;
+	} s;
+	struct cvmx_mio_uart2_sbcr_s cn52xx;
+	struct cvmx_mio_uart2_sbcr_s cn52xxp1;
+};
+
+union cvmx_mio_uart2_scr {
+	uint64_t u64;
+	struct cvmx_mio_uart2_scr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t scr:8;
+	} s;
+	struct cvmx_mio_uart2_scr_s cn52xx;
+	struct cvmx_mio_uart2_scr_s cn52xxp1;
+};
+
+union cvmx_mio_uart2_sfe {
+	uint64_t u64;
+	struct cvmx_mio_uart2_sfe_s {
+		uint64_t reserved_1_63:63;
+		uint64_t sfe:1;
+	} s;
+	struct cvmx_mio_uart2_sfe_s cn52xx;
+	struct cvmx_mio_uart2_sfe_s cn52xxp1;
+};
+
+union cvmx_mio_uart2_srr {
+	uint64_t u64;
+	struct cvmx_mio_uart2_srr_s {
+		uint64_t reserved_3_63:61;
+		uint64_t stfr:1;
+		uint64_t srfr:1;
+		uint64_t usr:1;
+	} s;
+	struct cvmx_mio_uart2_srr_s cn52xx;
+	struct cvmx_mio_uart2_srr_s cn52xxp1;
+};
+
+union cvmx_mio_uart2_srt {
+	uint64_t u64;
+	struct cvmx_mio_uart2_srt_s {
+		uint64_t reserved_2_63:62;
+		uint64_t srt:2;
+	} s;
+	struct cvmx_mio_uart2_srt_s cn52xx;
+	struct cvmx_mio_uart2_srt_s cn52xxp1;
+};
+
+union cvmx_mio_uart2_srts {
+	uint64_t u64;
+	struct cvmx_mio_uart2_srts_s {
+		uint64_t reserved_1_63:63;
+		uint64_t srts:1;
+	} s;
+	struct cvmx_mio_uart2_srts_s cn52xx;
+	struct cvmx_mio_uart2_srts_s cn52xxp1;
+};
+
+union cvmx_mio_uart2_stt {
+	uint64_t u64;
+	struct cvmx_mio_uart2_stt_s {
+		uint64_t reserved_2_63:62;
+		uint64_t stt:2;
+	} s;
+	struct cvmx_mio_uart2_stt_s cn52xx;
+	struct cvmx_mio_uart2_stt_s cn52xxp1;
+};
+
+union cvmx_mio_uart2_tfl {
+	uint64_t u64;
+	struct cvmx_mio_uart2_tfl_s {
+		uint64_t reserved_7_63:57;
+		uint64_t tfl:7;
+	} s;
+	struct cvmx_mio_uart2_tfl_s cn52xx;
+	struct cvmx_mio_uart2_tfl_s cn52xxp1;
+};
+
+union cvmx_mio_uart2_tfr {
+	uint64_t u64;
+	struct cvmx_mio_uart2_tfr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t tfr:8;
+	} s;
+	struct cvmx_mio_uart2_tfr_s cn52xx;
+	struct cvmx_mio_uart2_tfr_s cn52xxp1;
+};
+
+union cvmx_mio_uart2_thr {
+	uint64_t u64;
+	struct cvmx_mio_uart2_thr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t thr:8;
+	} s;
+	struct cvmx_mio_uart2_thr_s cn52xx;
+	struct cvmx_mio_uart2_thr_s cn52xxp1;
+};
+
+union cvmx_mio_uart2_usr {
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
+};
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-pow-defs.h b/arch/mips/include/asm/octeon/cvmx-pow-defs.h
new file mode 100644
index 0000000..2d82e24
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-pow-defs.h
@@ -0,0 +1,698 @@
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
+#ifndef __CVMX_POW_DEFS_H__
+#define __CVMX_POW_DEFS_H__
+
+#define CVMX_POW_BIST_STAT \
+	 CVMX_ADD_IO_SEG(0x00016700000003F8ull)
+#define CVMX_POW_DS_PC \
+	 CVMX_ADD_IO_SEG(0x0001670000000398ull)
+#define CVMX_POW_ECC_ERR \
+	 CVMX_ADD_IO_SEG(0x0001670000000218ull)
+#define CVMX_POW_INT_CTL \
+	 CVMX_ADD_IO_SEG(0x0001670000000220ull)
+#define CVMX_POW_IQ_CNTX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001670000000340ull + (((offset) & 7) * 8))
+#define CVMX_POW_IQ_COM_CNT \
+	 CVMX_ADD_IO_SEG(0x0001670000000388ull)
+#define CVMX_POW_IQ_INT \
+	 CVMX_ADD_IO_SEG(0x0001670000000238ull)
+#define CVMX_POW_IQ_INT_EN \
+	 CVMX_ADD_IO_SEG(0x0001670000000240ull)
+#define CVMX_POW_IQ_THRX(offset) \
+	 CVMX_ADD_IO_SEG(0x00016700000003A0ull + (((offset) & 7) * 8))
+#define CVMX_POW_NOS_CNT \
+	 CVMX_ADD_IO_SEG(0x0001670000000228ull)
+#define CVMX_POW_NW_TIM \
+	 CVMX_ADD_IO_SEG(0x0001670000000210ull)
+#define CVMX_POW_PF_RST_MSK \
+	 CVMX_ADD_IO_SEG(0x0001670000000230ull)
+#define CVMX_POW_PP_GRP_MSKX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001670000000000ull + (((offset) & 15) * 8))
+#define CVMX_POW_QOS_RNDX(offset) \
+	 CVMX_ADD_IO_SEG(0x00016700000001C0ull + (((offset) & 7) * 8))
+#define CVMX_POW_QOS_THRX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001670000000180ull + (((offset) & 7) * 8))
+#define CVMX_POW_TS_PC \
+	 CVMX_ADD_IO_SEG(0x0001670000000390ull)
+#define CVMX_POW_WA_COM_PC \
+	 CVMX_ADD_IO_SEG(0x0001670000000380ull)
+#define CVMX_POW_WA_PCX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001670000000300ull + (((offset) & 7) * 8))
+#define CVMX_POW_WQ_INT \
+	 CVMX_ADD_IO_SEG(0x0001670000000200ull)
+#define CVMX_POW_WQ_INT_CNTX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001670000000100ull + (((offset) & 15) * 8))
+#define CVMX_POW_WQ_INT_PC \
+	 CVMX_ADD_IO_SEG(0x0001670000000208ull)
+#define CVMX_POW_WQ_INT_THRX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001670000000080ull + (((offset) & 15) * 8))
+#define CVMX_POW_WS_PCX(offset) \
+	 CVMX_ADD_IO_SEG(0x0001670000000280ull + (((offset) & 15) * 8))
+
+union cvmx_pow_bist_stat {
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
+};
+
+union cvmx_pow_ds_pc {
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
+};
+
+union cvmx_pow_ecc_err {
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
+};
+
+union cvmx_pow_int_ctl {
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
+};
+
+union cvmx_pow_iq_cntx {
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
+};
+
+union cvmx_pow_iq_com_cnt {
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
+};
+
+union cvmx_pow_iq_int {
+	uint64_t u64;
+	struct cvmx_pow_iq_int_s {
+		uint64_t reserved_8_63:56;
+		uint64_t iq_int:8;
+	} s;
+	struct cvmx_pow_iq_int_s cn52xx;
+	struct cvmx_pow_iq_int_s cn52xxp1;
+	struct cvmx_pow_iq_int_s cn56xx;
+	struct cvmx_pow_iq_int_s cn56xxp1;
+};
+
+union cvmx_pow_iq_int_en {
+	uint64_t u64;
+	struct cvmx_pow_iq_int_en_s {
+		uint64_t reserved_8_63:56;
+		uint64_t int_en:8;
+	} s;
+	struct cvmx_pow_iq_int_en_s cn52xx;
+	struct cvmx_pow_iq_int_en_s cn52xxp1;
+	struct cvmx_pow_iq_int_en_s cn56xx;
+	struct cvmx_pow_iq_int_en_s cn56xxp1;
+};
+
+union cvmx_pow_iq_thrx {
+	uint64_t u64;
+	struct cvmx_pow_iq_thrx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t iq_thr:32;
+	} s;
+	struct cvmx_pow_iq_thrx_s cn52xx;
+	struct cvmx_pow_iq_thrx_s cn52xxp1;
+	struct cvmx_pow_iq_thrx_s cn56xx;
+	struct cvmx_pow_iq_thrx_s cn56xxp1;
+};
+
+union cvmx_pow_nos_cnt {
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
+};
+
+union cvmx_pow_nw_tim {
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
+};
+
+union cvmx_pow_pf_rst_msk {
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
+};
+
+union cvmx_pow_pp_grp_mskx {
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
+};
+
+union cvmx_pow_qos_rndx {
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
+};
+
+union cvmx_pow_qos_thrx {
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
+};
+
+union cvmx_pow_ts_pc {
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
+};
+
+union cvmx_pow_wa_com_pc {
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
+};
+
+union cvmx_pow_wa_pcx {
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
+};
+
+union cvmx_pow_wq_int {
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
+};
+
+union cvmx_pow_wq_int_cntx {
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
+};
+
+union cvmx_pow_wq_int_pc {
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
+};
+
+union cvmx_pow_wq_int_thrx {
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
+};
+
+union cvmx_pow_ws_pcx {
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
+};
+
+#endif
-- 
1.5.6.5
