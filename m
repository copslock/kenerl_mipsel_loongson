Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 23:35:52 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:36270 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903697Ab2EKVe6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2012 23:34:58 +0200
Received: by pbbrq13 with SMTP id rq13so4299238pbb.36
        for <linux-mips@linux-mips.org>; Fri, 11 May 2012 14:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Mg6A+q/QOY0BvyYWXgxuQ42hpYPBbBVX7GFolSD+dTI=;
        b=O/Cf1M7qiO6s8Ta7IH1pxKLHJo/qSoMj7XwZoCd0N0M0Qi6eu50VyDIbQAVg9+E+km
         YDRifjBFya5AkOf5fpF788dYmXVePShyyXd3m9AJX4nfpsOoIgGIHczM+1tpRH3N0Jts
         t+s2u++OyG6pZFTUENfJ6hTKaEayLDa4qDgvVsRlWpSBKQHLOyw4pdKs/7g56hUYTr0h
         H3+nXgAo8OCYIYmORoyuNJEdfdHA4wPINF5V0GicBIWy670jIEe9IoYITYB/y25vGE3s
         etVLPhjSQmxWyDl6rouX1iAZ0b0wfgMQmHwxQC25e+zIXgeBW2W4rkVOmrBu8CuYS2Fj
         z0Xg==
Received: by 10.68.191.201 with SMTP id ha9mr23981171pbc.75.1336772092362;
        Fri, 11 May 2012 14:34:52 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id b10sm13879125pbr.46.2012.05.11.14.34.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 May 2012 14:34:51 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q4BLYnEv017286;
        Fri, 11 May 2012 14:34:49 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q4BLYnIh017285;
        Fri, 11 May 2012 14:34:49 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        spi-devel-general@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 1/2] MIPS: OCTEON: Add register definitions for SPI host hardware.
Date:   Fri, 11 May 2012 14:34:45 -0700
Message-Id: <1336772086-17248-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1336772086-17248-1-git-send-email-ddaney.cavm@gmail.com>
References: <1336772086-17248-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

Needed by SPI driver.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/octeon/cvmx-mpi-defs.h |  328 ++++++++++++++++++++++++++
 1 files changed, 328 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/octeon/cvmx-mpi-defs.h

diff --git a/arch/mips/include/asm/octeon/cvmx-mpi-defs.h b/arch/mips/include/asm/octeon/cvmx-mpi-defs.h
new file mode 100644
index 0000000..4615b10
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-mpi-defs.h
@@ -0,0 +1,328 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2012 Cavium Networks
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
+#ifndef __CVMX_MPI_DEFS_H__
+#define __CVMX_MPI_DEFS_H__
+
+#define CVMX_MPI_CFG (CVMX_ADD_IO_SEG(0x0001070000001000ull))
+#define CVMX_MPI_DATX(offset) (CVMX_ADD_IO_SEG(0x0001070000001080ull) + ((offset) & 15) * 8)
+#define CVMX_MPI_STS (CVMX_ADD_IO_SEG(0x0001070000001008ull))
+#define CVMX_MPI_TX (CVMX_ADD_IO_SEG(0x0001070000001010ull))
+
+union cvmx_mpi_cfg {
+	uint64_t u64;
+	struct cvmx_mpi_cfg_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t reserved_29_63:35;
+		uint64_t clkdiv:13;
+		uint64_t csena3:1;
+		uint64_t csena2:1;
+		uint64_t csena1:1;
+		uint64_t csena0:1;
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
+#else
+		uint64_t enable:1;
+		uint64_t idlelo:1;
+		uint64_t clk_cont:1;
+		uint64_t wireor:1;
+		uint64_t lsbfirst:1;
+		uint64_t int_ena:1;
+		uint64_t csena:1;
+		uint64_t cshi:1;
+		uint64_t idleclks:2;
+		uint64_t tritx:1;
+		uint64_t cslate:1;
+		uint64_t csena0:1;
+		uint64_t csena1:1;
+		uint64_t csena2:1;
+		uint64_t csena3:1;
+		uint64_t clkdiv:13;
+		uint64_t reserved_29_63:35;
+#endif
+	} s;
+	struct cvmx_mpi_cfg_cn30xx {
+#ifdef __BIG_ENDIAN_BITFIELD
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
+#else
+		uint64_t enable:1;
+		uint64_t idlelo:1;
+		uint64_t clk_cont:1;
+		uint64_t wireor:1;
+		uint64_t lsbfirst:1;
+		uint64_t int_ena:1;
+		uint64_t csena:1;
+		uint64_t cshi:1;
+		uint64_t idleclks:2;
+		uint64_t tritx:1;
+		uint64_t cslate:1;
+		uint64_t reserved_12_15:4;
+		uint64_t clkdiv:13;
+		uint64_t reserved_29_63:35;
+#endif
+	} cn30xx;
+	struct cvmx_mpi_cfg_cn31xx {
+#ifdef __BIG_ENDIAN_BITFIELD
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
+#else
+		uint64_t enable:1;
+		uint64_t idlelo:1;
+		uint64_t clk_cont:1;
+		uint64_t wireor:1;
+		uint64_t lsbfirst:1;
+		uint64_t int_ena:1;
+		uint64_t csena:1;
+		uint64_t cshi:1;
+		uint64_t idleclks:2;
+		uint64_t tritx:1;
+		uint64_t reserved_11_15:5;
+		uint64_t clkdiv:13;
+		uint64_t reserved_29_63:35;
+#endif
+	} cn31xx;
+	struct cvmx_mpi_cfg_cn30xx cn50xx;
+	struct cvmx_mpi_cfg_cn61xx {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t reserved_29_63:35;
+		uint64_t clkdiv:13;
+		uint64_t reserved_14_15:2;
+		uint64_t csena1:1;
+		uint64_t csena0:1;
+		uint64_t cslate:1;
+		uint64_t tritx:1;
+		uint64_t idleclks:2;
+		uint64_t cshi:1;
+		uint64_t reserved_6_6:1;
+		uint64_t int_ena:1;
+		uint64_t lsbfirst:1;
+		uint64_t wireor:1;
+		uint64_t clk_cont:1;
+		uint64_t idlelo:1;
+		uint64_t enable:1;
+#else
+		uint64_t enable:1;
+		uint64_t idlelo:1;
+		uint64_t clk_cont:1;
+		uint64_t wireor:1;
+		uint64_t lsbfirst:1;
+		uint64_t int_ena:1;
+		uint64_t reserved_6_6:1;
+		uint64_t cshi:1;
+		uint64_t idleclks:2;
+		uint64_t tritx:1;
+		uint64_t cslate:1;
+		uint64_t csena0:1;
+		uint64_t csena1:1;
+		uint64_t reserved_14_15:2;
+		uint64_t clkdiv:13;
+		uint64_t reserved_29_63:35;
+#endif
+	} cn61xx;
+	struct cvmx_mpi_cfg_cn66xx {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t reserved_29_63:35;
+		uint64_t clkdiv:13;
+		uint64_t csena3:1;
+		uint64_t csena2:1;
+		uint64_t reserved_12_13:2;
+		uint64_t cslate:1;
+		uint64_t tritx:1;
+		uint64_t idleclks:2;
+		uint64_t cshi:1;
+		uint64_t reserved_6_6:1;
+		uint64_t int_ena:1;
+		uint64_t lsbfirst:1;
+		uint64_t wireor:1;
+		uint64_t clk_cont:1;
+		uint64_t idlelo:1;
+		uint64_t enable:1;
+#else
+		uint64_t enable:1;
+		uint64_t idlelo:1;
+		uint64_t clk_cont:1;
+		uint64_t wireor:1;
+		uint64_t lsbfirst:1;
+		uint64_t int_ena:1;
+		uint64_t reserved_6_6:1;
+		uint64_t cshi:1;
+		uint64_t idleclks:2;
+		uint64_t tritx:1;
+		uint64_t cslate:1;
+		uint64_t reserved_12_13:2;
+		uint64_t csena2:1;
+		uint64_t csena3:1;
+		uint64_t clkdiv:13;
+		uint64_t reserved_29_63:35;
+#endif
+	} cn66xx;
+	struct cvmx_mpi_cfg_cn61xx cnf71xx;
+};
+
+union cvmx_mpi_datx {
+	uint64_t u64;
+	struct cvmx_mpi_datx_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t reserved_8_63:56;
+		uint64_t data:8;
+#else
+		uint64_t data:8;
+		uint64_t reserved_8_63:56;
+#endif
+	} s;
+	struct cvmx_mpi_datx_s cn30xx;
+	struct cvmx_mpi_datx_s cn31xx;
+	struct cvmx_mpi_datx_s cn50xx;
+	struct cvmx_mpi_datx_s cn61xx;
+	struct cvmx_mpi_datx_s cn66xx;
+	struct cvmx_mpi_datx_s cnf71xx;
+};
+
+union cvmx_mpi_sts {
+	uint64_t u64;
+	struct cvmx_mpi_sts_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t reserved_13_63:51;
+		uint64_t rxnum:5;
+		uint64_t reserved_1_7:7;
+		uint64_t busy:1;
+#else
+		uint64_t busy:1;
+		uint64_t reserved_1_7:7;
+		uint64_t rxnum:5;
+		uint64_t reserved_13_63:51;
+#endif
+	} s;
+	struct cvmx_mpi_sts_s cn30xx;
+	struct cvmx_mpi_sts_s cn31xx;
+	struct cvmx_mpi_sts_s cn50xx;
+	struct cvmx_mpi_sts_s cn61xx;
+	struct cvmx_mpi_sts_s cn66xx;
+	struct cvmx_mpi_sts_s cnf71xx;
+};
+
+union cvmx_mpi_tx {
+	uint64_t u64;
+	struct cvmx_mpi_tx_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t reserved_22_63:42;
+		uint64_t csid:2;
+		uint64_t reserved_17_19:3;
+		uint64_t leavecs:1;
+		uint64_t reserved_13_15:3;
+		uint64_t txnum:5;
+		uint64_t reserved_5_7:3;
+		uint64_t totnum:5;
+#else
+		uint64_t totnum:5;
+		uint64_t reserved_5_7:3;
+		uint64_t txnum:5;
+		uint64_t reserved_13_15:3;
+		uint64_t leavecs:1;
+		uint64_t reserved_17_19:3;
+		uint64_t csid:2;
+		uint64_t reserved_22_63:42;
+#endif
+	} s;
+	struct cvmx_mpi_tx_cn30xx {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t reserved_17_63:47;
+		uint64_t leavecs:1;
+		uint64_t reserved_13_15:3;
+		uint64_t txnum:5;
+		uint64_t reserved_5_7:3;
+		uint64_t totnum:5;
+#else
+		uint64_t totnum:5;
+		uint64_t reserved_5_7:3;
+		uint64_t txnum:5;
+		uint64_t reserved_13_15:3;
+		uint64_t leavecs:1;
+		uint64_t reserved_17_63:47;
+#endif
+	} cn30xx;
+	struct cvmx_mpi_tx_cn30xx cn31xx;
+	struct cvmx_mpi_tx_cn30xx cn50xx;
+	struct cvmx_mpi_tx_cn61xx {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t reserved_21_63:43;
+		uint64_t csid:1;
+		uint64_t reserved_17_19:3;
+		uint64_t leavecs:1;
+		uint64_t reserved_13_15:3;
+		uint64_t txnum:5;
+		uint64_t reserved_5_7:3;
+		uint64_t totnum:5;
+#else
+		uint64_t totnum:5;
+		uint64_t reserved_5_7:3;
+		uint64_t txnum:5;
+		uint64_t reserved_13_15:3;
+		uint64_t leavecs:1;
+		uint64_t reserved_17_19:3;
+		uint64_t csid:1;
+		uint64_t reserved_21_63:43;
+#endif
+	} cn61xx;
+	struct cvmx_mpi_tx_s cn66xx;
+	struct cvmx_mpi_tx_cn61xx cnf71xx;
+};
+
+#endif
-- 
1.7.2.3
