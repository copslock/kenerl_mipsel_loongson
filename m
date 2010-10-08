Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2010 23:48:37 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:6294 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491206Ab0JHVsI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Oct 2010 23:48:08 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4caf91b80000>; Fri, 08 Oct 2010 14:48:41 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 8 Oct 2010 14:48:15 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 8 Oct 2010 14:48:15 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o98Lm0lw023138;
        Fri, 8 Oct 2010 14:48:00 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o98Lm0lA023137;
        Fri, 8 Oct 2010 14:48:00 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org, gregkh@suse.de,
        dbrownell@users.sourceforge.net
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/3] MIPS: Octeon: Add register definitions for ehci/ohci USB glue logic.
Date:   Fri,  8 Oct 2010 14:47:51 -0700
Message-Id: <1286574473-23098-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1286574473-23098-1-git-send-email-ddaney@caviumnetworks.com>
References: <1286574473-23098-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 08 Oct 2010 21:48:15.0807 (UTC) FILETIME=[833D9CF0:01CB6732]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The EHCI and OHCI blocks connection to the I/O bus is controlled by
these registers.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/octeon/cvmx-uctlx-defs.h |  261 ++++++++++++++++++++++++
 1 files changed, 261 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/octeon/cvmx-uctlx-defs.h

diff --git a/arch/mips/include/asm/octeon/cvmx-uctlx-defs.h b/arch/mips/include/asm/octeon/cvmx-uctlx-defs.h
new file mode 100644
index 0000000..594f1b6
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-uctlx-defs.h
@@ -0,0 +1,261 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2010 Cavium Networks
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
+#ifndef __CVMX_UCTLX_TYPEDEFS_H__
+#define __CVMX_UCTLX_TYPEDEFS_H__
+
+#define CVMX_UCTLX_BIST_STATUS(block_id) (CVMX_ADD_IO_SEG(0x000118006F0000A0ull))
+#define CVMX_UCTLX_CLK_RST_CTL(block_id) (CVMX_ADD_IO_SEG(0x000118006F000000ull))
+#define CVMX_UCTLX_EHCI_CTL(block_id) (CVMX_ADD_IO_SEG(0x000118006F000080ull))
+#define CVMX_UCTLX_EHCI_FLA(block_id) (CVMX_ADD_IO_SEG(0x000118006F0000A8ull))
+#define CVMX_UCTLX_ERTO_CTL(block_id) (CVMX_ADD_IO_SEG(0x000118006F000090ull))
+#define CVMX_UCTLX_IF_ENA(block_id) (CVMX_ADD_IO_SEG(0x000118006F000030ull))
+#define CVMX_UCTLX_INT_ENA(block_id) (CVMX_ADD_IO_SEG(0x000118006F000028ull))
+#define CVMX_UCTLX_INT_REG(block_id) (CVMX_ADD_IO_SEG(0x000118006F000020ull))
+#define CVMX_UCTLX_OHCI_CTL(block_id) (CVMX_ADD_IO_SEG(0x000118006F000088ull))
+#define CVMX_UCTLX_ORTO_CTL(block_id) (CVMX_ADD_IO_SEG(0x000118006F000098ull))
+#define CVMX_UCTLX_PPAF_WM(block_id) (CVMX_ADD_IO_SEG(0x000118006F000038ull))
+#define CVMX_UCTLX_UPHY_CTL_STATUS(block_id) (CVMX_ADD_IO_SEG(0x000118006F000008ull))
+#define CVMX_UCTLX_UPHY_PORTX_CTL_STATUS(offset, block_id) (CVMX_ADD_IO_SEG(0x000118006F000010ull) + (((offset) & 1) + ((block_id) & 0) * 0x0ull) * 8)
+
+union cvmx_uctlx_bist_status {
+	uint64_t u64;
+	struct cvmx_uctlx_bist_status_s {
+		uint64_t reserved_6_63:58;
+		uint64_t data_bis:1;
+		uint64_t desc_bis:1;
+		uint64_t erbm_bis:1;
+		uint64_t orbm_bis:1;
+		uint64_t wrbm_bis:1;
+		uint64_t ppaf_bis:1;
+	} s;
+	struct cvmx_uctlx_bist_status_s       cn63xx;
+	struct cvmx_uctlx_bist_status_s       cn63xxp1;
+};
+
+union cvmx_uctlx_clk_rst_ctl {
+	uint64_t u64;
+	struct cvmx_uctlx_clk_rst_ctl_s {
+		uint64_t reserved_25_63:39;
+		uint64_t clear_bist:1;
+		uint64_t start_bist:1;
+		uint64_t ehci_sm:1;
+		uint64_t ohci_clkcktrst:1;
+		uint64_t ohci_sm:1;
+		uint64_t ohci_susp_lgcy:1;
+		uint64_t app_start_clk:1;
+		uint64_t o_clkdiv_rst:1;
+		uint64_t h_clkdiv_byp:1;
+		uint64_t h_clkdiv_rst:1;
+		uint64_t h_clkdiv_en:1;
+		uint64_t o_clkdiv_en:1;
+		uint64_t h_div:4;
+		uint64_t p_refclk_sel:2;
+		uint64_t p_refclk_div:2;
+		uint64_t reserved_4_4:1;
+		uint64_t p_com_on:1;
+		uint64_t p_por:1;
+		uint64_t p_prst:1;
+		uint64_t hrst:1;
+	} s;
+	struct cvmx_uctlx_clk_rst_ctl_s       cn63xx;
+	struct cvmx_uctlx_clk_rst_ctl_s       cn63xxp1;
+};
+
+union cvmx_uctlx_ehci_ctl {
+	uint64_t u64;
+	struct cvmx_uctlx_ehci_ctl_s {
+		uint64_t reserved_20_63:44;
+		uint64_t desc_rbm:1;
+		uint64_t reg_nb:1;
+		uint64_t l2c_dc:1;
+		uint64_t l2c_bc:1;
+		uint64_t l2c_0pag:1;
+		uint64_t l2c_stt:1;
+		uint64_t l2c_buff_emod:2;
+		uint64_t l2c_desc_emod:2;
+		uint64_t inv_reg_a2:1;
+		uint64_t ehci_64b_addr_en:1;
+		uint64_t l2c_addr_msb:8;
+	} s;
+	struct cvmx_uctlx_ehci_ctl_s          cn63xx;
+	struct cvmx_uctlx_ehci_ctl_s          cn63xxp1;
+};
+
+union cvmx_uctlx_ehci_fla {
+	uint64_t u64;
+	struct cvmx_uctlx_ehci_fla_s {
+		uint64_t reserved_6_63:58;
+		uint64_t fla:6;
+	} s;
+	struct cvmx_uctlx_ehci_fla_s          cn63xx;
+	struct cvmx_uctlx_ehci_fla_s          cn63xxp1;
+};
+
+union cvmx_uctlx_erto_ctl {
+	uint64_t u64;
+	struct cvmx_uctlx_erto_ctl_s {
+		uint64_t reserved_32_63:32;
+		uint64_t to_val:27;
+		uint64_t reserved_0_4:5;
+	} s;
+	struct cvmx_uctlx_erto_ctl_s          cn63xx;
+	struct cvmx_uctlx_erto_ctl_s          cn63xxp1;
+};
+
+union cvmx_uctlx_if_ena {
+	uint64_t u64;
+	struct cvmx_uctlx_if_ena_s {
+		uint64_t reserved_1_63:63;
+		uint64_t en:1;
+	} s;
+	struct cvmx_uctlx_if_ena_s            cn63xx;
+	struct cvmx_uctlx_if_ena_s            cn63xxp1;
+};
+
+union cvmx_uctlx_int_ena {
+	uint64_t u64;
+	struct cvmx_uctlx_int_ena_s {
+		uint64_t reserved_8_63:56;
+		uint64_t ec_ovf_e:1;
+		uint64_t oc_ovf_e:1;
+		uint64_t wb_pop_e:1;
+		uint64_t wb_psh_f:1;
+		uint64_t cf_psh_f:1;
+		uint64_t or_psh_f:1;
+		uint64_t er_psh_f:1;
+		uint64_t pp_psh_f:1;
+	} s;
+	struct cvmx_uctlx_int_ena_s           cn63xx;
+	struct cvmx_uctlx_int_ena_s           cn63xxp1;
+};
+
+union cvmx_uctlx_int_reg {
+	uint64_t u64;
+	struct cvmx_uctlx_int_reg_s {
+		uint64_t reserved_8_63:56;
+		uint64_t ec_ovf_e:1;
+		uint64_t oc_ovf_e:1;
+		uint64_t wb_pop_e:1;
+		uint64_t wb_psh_f:1;
+		uint64_t cf_psh_f:1;
+		uint64_t or_psh_f:1;
+		uint64_t er_psh_f:1;
+		uint64_t pp_psh_f:1;
+	} s;
+	struct cvmx_uctlx_int_reg_s           cn63xx;
+	struct cvmx_uctlx_int_reg_s           cn63xxp1;
+};
+
+union cvmx_uctlx_ohci_ctl {
+	uint64_t u64;
+	struct cvmx_uctlx_ohci_ctl_s {
+		uint64_t reserved_19_63:45;
+		uint64_t reg_nb:1;
+		uint64_t l2c_dc:1;
+		uint64_t l2c_bc:1;
+		uint64_t l2c_0pag:1;
+		uint64_t l2c_stt:1;
+		uint64_t l2c_buff_emod:2;
+		uint64_t l2c_desc_emod:2;
+		uint64_t inv_reg_a2:1;
+		uint64_t reserved_8_8:1;
+		uint64_t l2c_addr_msb:8;
+	} s;
+	struct cvmx_uctlx_ohci_ctl_s          cn63xx;
+	struct cvmx_uctlx_ohci_ctl_s          cn63xxp1;
+};
+
+union cvmx_uctlx_orto_ctl {
+	uint64_t u64;
+	struct cvmx_uctlx_orto_ctl_s {
+		uint64_t reserved_32_63:32;
+		uint64_t to_val:24;
+		uint64_t reserved_0_7:8;
+	} s;
+	struct cvmx_uctlx_orto_ctl_s          cn63xx;
+	struct cvmx_uctlx_orto_ctl_s          cn63xxp1;
+};
+
+union cvmx_uctlx_ppaf_wm {
+	uint64_t u64;
+	struct cvmx_uctlx_ppaf_wm_s {
+		uint64_t reserved_5_63:59;
+		uint64_t wm:5;
+	} s;
+	struct cvmx_uctlx_ppaf_wm_s           cn63xx;
+	struct cvmx_uctlx_ppaf_wm_s           cn63xxp1;
+};
+
+union cvmx_uctlx_uphy_ctl_status {
+	uint64_t u64;
+	struct cvmx_uctlx_uphy_ctl_status_s {
+		uint64_t reserved_10_63:54;
+		uint64_t bist_done:1;
+		uint64_t bist_err:1;
+		uint64_t hsbist:1;
+		uint64_t fsbist:1;
+		uint64_t lsbist:1;
+		uint64_t siddq:1;
+		uint64_t vtest_en:1;
+		uint64_t uphy_bist:1;
+		uint64_t bist_en:1;
+		uint64_t ate_reset:1;
+	} s;
+	struct cvmx_uctlx_uphy_ctl_status_s   cn63xx;
+	struct cvmx_uctlx_uphy_ctl_status_s   cn63xxp1;
+};
+
+union cvmx_uctlx_uphy_portx_ctl_status {
+	uint64_t u64;
+	struct cvmx_uctlx_uphy_portx_ctl_status_s {
+		uint64_t reserved_43_63:21;
+		uint64_t tdata_out:4;
+		uint64_t txbiststuffenh:1;
+		uint64_t txbiststuffen:1;
+		uint64_t dmpulldown:1;
+		uint64_t dppulldown:1;
+		uint64_t vbusvldext:1;
+		uint64_t portreset:1;
+		uint64_t txhsvxtune:2;
+		uint64_t txvreftune:4;
+		uint64_t txrisetune:1;
+		uint64_t txpreemphasistune:1;
+		uint64_t txfslstune:4;
+		uint64_t sqrxtune:3;
+		uint64_t compdistune:3;
+		uint64_t loop_en:1;
+		uint64_t tclk:1;
+		uint64_t tdata_sel:1;
+		uint64_t taddr_in:4;
+		uint64_t tdata_in:8;
+	} s;
+	struct cvmx_uctlx_uphy_portx_ctl_status_s cn63xx;
+	struct cvmx_uctlx_uphy_portx_ctl_status_s cn63xxp1;
+};
+
+#endif
-- 
1.7.2.3
