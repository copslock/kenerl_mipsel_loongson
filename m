Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Aug 2017 03:22:05 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:60394 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994815AbdHOBUnoeUjm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Aug 2017 03:20:43 +0200
Received: from localhost (unknown [70.96.146.25])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A5F4AA49;
        Tue, 15 Aug 2017 01:20:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Steven J. Hill" <steven.hill@cavium.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.12 64/65] MIPS: Octeon: Fix broken EDAC driver.
Date:   Mon, 14 Aug 2017 18:19:55 -0700
Message-Id: <20170815011944.930972753@linuxfoundation.org>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170815011942.395714306@linuxfoundation.org>
References: <20170815011942.395714306@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven J. Hill <Steven.Hill@cavium.com>

commit 81a67e52763d1db6b3200c648d1efa16daddc536 upstream.

Commit "MIPS: Octeon: Remove unused L2C types and macros." broke the
the EDAC driver. Bring back 'cvmx-l2d-defs.h' file and the missing
types for L2C. Fixes: 15f6847923a8 ("MIPS: Octeon: Remove unused L2C
types and macros.")

Fixes: 15f6847923a8 ("MIPS: Octeon: Remove unused L2C types and macros.")
Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16906/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/octeon/cvmx-l2c-defs.h |   37 ++++++++++++++++
 arch/mips/include/asm/octeon/cvmx-l2d-defs.h |   60 +++++++++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx.h          |    1 
 3 files changed, 97 insertions(+), 1 deletion(-)

--- a/arch/mips/include/asm/octeon/cvmx-l2c-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-l2c-defs.h
@@ -33,6 +33,10 @@
 #define CVMX_L2C_DBG (CVMX_ADD_IO_SEG(0x0001180080000030ull))
 #define CVMX_L2C_CFG (CVMX_ADD_IO_SEG(0x0001180080000000ull))
 #define CVMX_L2C_CTL (CVMX_ADD_IO_SEG(0x0001180080800000ull))
+#define CVMX_L2C_ERR_TDTX(block_id)					       \
+	(CVMX_ADD_IO_SEG(0x0001180080A007E0ull) + ((block_id) & 3) * 0x40000ull)
+#define CVMX_L2C_ERR_TTGX(block_id)					       \
+	(CVMX_ADD_IO_SEG(0x0001180080A007E8ull) + ((block_id) & 3) * 0x40000ull)
 #define CVMX_L2C_LCKBASE (CVMX_ADD_IO_SEG(0x0001180080000058ull))
 #define CVMX_L2C_LCKOFF (CVMX_ADD_IO_SEG(0x0001180080000060ull))
 #define CVMX_L2C_PFCTL (CVMX_ADD_IO_SEG(0x0001180080000090ull))
@@ -66,9 +70,40 @@
 		((offset) & 1) * 8)
 #define CVMX_L2C_WPAR_PPX(offset) (CVMX_ADD_IO_SEG(0x0001180080840000ull)    + \
 		((offset) & 31) * 8)
-#define CVMX_L2D_FUS3 (CVMX_ADD_IO_SEG(0x00011800800007B8ull))
 
 
+union cvmx_l2c_err_tdtx {
+	uint64_t u64;
+	struct cvmx_l2c_err_tdtx_s {
+		__BITFIELD_FIELD(uint64_t dbe:1,
+		__BITFIELD_FIELD(uint64_t sbe:1,
+		__BITFIELD_FIELD(uint64_t vdbe:1,
+		__BITFIELD_FIELD(uint64_t vsbe:1,
+		__BITFIELD_FIELD(uint64_t syn:10,
+		__BITFIELD_FIELD(uint64_t reserved_22_49:28,
+		__BITFIELD_FIELD(uint64_t wayidx:18,
+		__BITFIELD_FIELD(uint64_t reserved_2_3:2,
+		__BITFIELD_FIELD(uint64_t type:2,
+		;)))))))))
+	} s;
+};
+
+union cvmx_l2c_err_ttgx {
+	uint64_t u64;
+	struct cvmx_l2c_err_ttgx_s {
+		__BITFIELD_FIELD(uint64_t dbe:1,
+		__BITFIELD_FIELD(uint64_t sbe:1,
+		__BITFIELD_FIELD(uint64_t noway:1,
+		__BITFIELD_FIELD(uint64_t reserved_56_60:5,
+		__BITFIELD_FIELD(uint64_t syn:6,
+		__BITFIELD_FIELD(uint64_t reserved_22_49:28,
+		__BITFIELD_FIELD(uint64_t wayidx:15,
+		__BITFIELD_FIELD(uint64_t reserved_2_6:5,
+		__BITFIELD_FIELD(uint64_t type:2,
+		;)))))))))
+	} s;
+};
+
 union cvmx_l2c_cfg {
 	uint64_t u64;
 	struct cvmx_l2c_cfg_s {
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-l2d-defs.h
@@ -0,0 +1,60 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2017 Cavium, Inc.
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
+#define CVMX_L2D_ERR	(CVMX_ADD_IO_SEG(0x0001180080000010ull))
+#define CVMX_L2D_FUS3	(CVMX_ADD_IO_SEG(0x00011800800007B8ull))
+
+
+union cvmx_l2d_err {
+	uint64_t u64;
+	struct cvmx_l2d_err_s {
+		__BITFIELD_FIELD(uint64_t reserved_6_63:58,
+		__BITFIELD_FIELD(uint64_t bmhclsel:1,
+		__BITFIELD_FIELD(uint64_t ded_err:1,
+		__BITFIELD_FIELD(uint64_t sec_err:1,
+		__BITFIELD_FIELD(uint64_t ded_intena:1,
+		__BITFIELD_FIELD(uint64_t sec_intena:1,
+		__BITFIELD_FIELD(uint64_t ecc_ena:1,
+		;)))))))
+	} s;
+};
+
+union cvmx_l2d_fus3 {
+	uint64_t u64;
+	struct cvmx_l2d_fus3_s {
+		__BITFIELD_FIELD(uint64_t reserved_40_63:24,
+		__BITFIELD_FIELD(uint64_t ema_ctl:3,
+		__BITFIELD_FIELD(uint64_t reserved_34_36:3,
+		__BITFIELD_FIELD(uint64_t q3fus:34,
+		;))))
+	} s;
+};
+
+#endif
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -62,6 +62,7 @@ enum cvmx_mips_space {
 #include <asm/octeon/cvmx-iob-defs.h>
 #include <asm/octeon/cvmx-ipd-defs.h>
 #include <asm/octeon/cvmx-l2c-defs.h>
+#include <asm/octeon/cvmx-l2d-defs.h>
 #include <asm/octeon/cvmx-l2t-defs.h>
 #include <asm/octeon/cvmx-led-defs.h>
 #include <asm/octeon/cvmx-mio-defs.h>
