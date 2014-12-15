Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2014 19:09:43 +0100 (CET)
Received: from mail-la0-f42.google.com ([209.85.215.42]:51675 "EHLO
        mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008842AbaLOSHCsTgQ- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Dec 2014 19:07:02 +0100
Received: by mail-la0-f42.google.com with SMTP id gd6so10049245lab.1
        for <multiple recipients>; Mon, 15 Dec 2014 10:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AFJxZb63zlnvh25nRz8CZIIxImYsCc6nD8L2Hh4iX1I=;
        b=DYc+6yCyMP3VjnwaxOogYhNOD/NH6LJ/KtQnPpM3RZEWQwtvxO9p5gWgMQgw7JQ1KX
         LLOuQK7oomouNQRh/S5qJsX3dusmxV1DyUjQkjOuws5vzp4xyf1rwAhm8INx/H43Rwla
         0C7MKkKm2JLxLa+9W0P2MfgMDHxZAKYB0/DAG4ODZMw73PIlaUrHvJFtRARIZ1KT+cR6
         XUDnlQFp3wYNpbXxdCaefXkzoJGLK84SfjbOctCrYYaS95bRG2gh5DuKpeoGOK7Q1eMD
         y2LBUgZSd+b29vwGD+dqt8RgvLUW8hHOx8heVal7LyuS+IcTczR4N65d1s5Tfeh0jTAI
         E3PA==
X-Received: by 10.153.11.170 with SMTP id ej10mr31659879lad.24.1418666817539;
        Mon, 15 Dec 2014 10:06:57 -0800 (PST)
Received: from turnip.localdomain (nivc-213.auriga.ru. [80.240.102.213])
        by mx.google.com with ESMTPSA id l9sm1238952lae.0.2014.12.15.10.06.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Dec 2014 10:06:56 -0800 (PST)
From:   Aleksey Makarov <feumilieu@gmail.com>
X-Google-Original-From: Aleksey Makarov <aleksey.makarov@auriga.com>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 13/14] MIPS: OCTEON: Add register definitions for OCTEON III reset unit.
Date:   Mon, 15 Dec 2014 21:03:19 +0300
Message-Id: <1418666603-15159-14-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com>
References: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com>
Return-Path: <feumilieu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: feumilieu@gmail.com
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

From: David Daney <david.daney@cavium.com>

Needed by follow-on patches.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
---
 arch/mips/include/asm/octeon/cvmx-rst-defs.h | 441 +++++++++++++++++++++++++++
 1 file changed, 441 insertions(+)
 create mode 100644 arch/mips/include/asm/octeon/cvmx-rst-defs.h

diff --git a/arch/mips/include/asm/octeon/cvmx-rst-defs.h b/arch/mips/include/asm/octeon/cvmx-rst-defs.h
new file mode 100644
index 0000000..724dedb
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-rst-defs.h
@@ -0,0 +1,441 @@
+/***********************license start***************
+ * Author: Cavium Inc.
+ *
+ * Contact: support@cavium.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2014 Cavium Inc.
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
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Inc. for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_RST_DEFS_H__
+#define __CVMX_RST_DEFS_H__
+
+#define CVMX_RST_BIST_TIMER (CVMX_ADD_IO_SEG(0x0001180006001760ull))
+#define CVMX_RST_BOOT (CVMX_ADD_IO_SEG(0x0001180006001600ull))
+#define CVMX_RST_CFG (CVMX_ADD_IO_SEG(0x0001180006001610ull))
+#define CVMX_RST_CKILL (CVMX_ADD_IO_SEG(0x0001180006001638ull))
+#define CVMX_RST_COLD_DATAX(offset) (CVMX_ADD_IO_SEG(0x00011800060017C0ull) + \
+				     ((offset) & 3) * 8)
+#define CVMX_RST_CTLX(offset) (CVMX_ADD_IO_SEG(0x0001180006001640ull) + \
+			       ((offset) & 3) * 8)
+#define CVMX_RST_DELAY (CVMX_ADD_IO_SEG(0x0001180006001608ull))
+#define CVMX_RST_ECO (CVMX_ADD_IO_SEG(0x00011800060017B8ull))
+#define CVMX_RST_INT (CVMX_ADD_IO_SEG(0x0001180006001628ull))
+#define CVMX_RST_INT_W1S (CVMX_ADD_IO_SEG(0x0001180006001630ull))
+#define CVMX_RST_OCX (CVMX_ADD_IO_SEG(0x0001180006001618ull))
+#define CVMX_RST_OUT_CTL (CVMX_ADD_IO_SEG(0x0001180006001688ull))
+#define CVMX_RST_POWER_DBG (CVMX_ADD_IO_SEG(0x0001180006001708ull))
+#define CVMX_RST_PP_POWER (CVMX_ADD_IO_SEG(0x0001180006001700ull))
+#define CVMX_RST_REF_CNTR (CVMX_ADD_IO_SEG(0x0001180006001758ull))
+#define CVMX_RST_SOFT_PRSTX(offset) (CVMX_ADD_IO_SEG(0x00011800060016C0ull) + \
+				     ((offset) & 3) * 8)
+#define CVMX_RST_SOFT_RST (CVMX_ADD_IO_SEG(0x0001180006001680ull))
+#define CVMX_RST_THERMAL_ALERT (CVMX_ADD_IO_SEG(0x0001180006001690ull))
+
+union cvmx_rst_bist_timer {
+	uint64_t u64;
+	struct cvmx_rst_bist_timer_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_29_63               : 35;
+	uint64_t count                        : 29;
+#else
+	uint64_t count                        : 29;
+	uint64_t reserved_29_63               : 35;
+#endif
+	} s;
+	struct cvmx_rst_bist_timer_s          cn73xx;
+};
+
+union cvmx_rst_boot {
+	uint64_t u64;
+	struct cvmx_rst_boot_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t chipkill                     : 1;
+	uint64_t jtcsrdis                     : 1;
+	uint64_t ejtagdis                     : 1;
+	uint64_t romen                        : 1;
+	uint64_t ckill_ppdis                  : 1;
+	uint64_t jt_tstmode                   : 1;
+	uint64_t vrm_err                      : 1;
+	uint64_t reserved_37_56               : 20;
+	uint64_t c_mul                        : 7;
+	uint64_t pnr_mul                      : 6;
+	uint64_t reserved_21_23               : 3;
+	uint64_t lboot_oci                    : 3;
+	uint64_t lboot_ext                    : 6;
+	uint64_t lboot                        : 10;
+	uint64_t rboot                        : 1;
+	uint64_t rboot_pin                    : 1;
+#else
+	uint64_t rboot_pin                    : 1;
+	uint64_t rboot                        : 1;
+	uint64_t lboot                        : 10;
+	uint64_t lboot_ext                    : 6;
+	uint64_t lboot_oci                    : 3;
+	uint64_t reserved_21_23               : 3;
+	uint64_t pnr_mul                      : 6;
+	uint64_t c_mul                        : 7;
+	uint64_t reserved_37_56               : 20;
+	uint64_t vrm_err                      : 1;
+	uint64_t jt_tstmode                   : 1;
+	uint64_t ckill_ppdis                  : 1;
+	uint64_t romen                        : 1;
+	uint64_t ejtagdis                     : 1;
+	uint64_t jtcsrdis                     : 1;
+	uint64_t chipkill                     : 1;
+#endif
+	} s;
+	struct cvmx_rst_boot_s                cn70xx;
+	struct cvmx_rst_boot_s                cn70xxp1;
+	struct cvmx_rst_boot_s                cn73xx;
+	struct cvmx_rst_boot_s                cn78xx;
+};
+
+union cvmx_rst_cfg {
+	uint64_t u64;
+	struct cvmx_rst_cfg_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t bist_delay                   : 58;
+	uint64_t reserved_3_5                 : 3;
+	uint64_t cntl_clr_bist                : 1;
+	uint64_t warm_clr_bist                : 1;
+	uint64_t reserved_0_0                 : 1;
+#else
+	uint64_t reserved_0_0                 : 1;
+	uint64_t warm_clr_bist                : 1;
+	uint64_t cntl_clr_bist                : 1;
+	uint64_t reserved_3_5                 : 3;
+	uint64_t bist_delay                   : 58;
+#endif
+	} s;
+	struct cvmx_rst_cfg_cn70xx {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t bist_delay                   : 58;
+	uint64_t reserved_3_5                 : 3;
+	uint64_t cntl_clr_bist                : 1;
+	uint64_t warm_clr_bist                : 1;
+	uint64_t soft_clr_bist                : 1;
+#else
+	uint64_t soft_clr_bist                : 1;
+	uint64_t warm_clr_bist                : 1;
+	uint64_t cntl_clr_bist                : 1;
+	uint64_t reserved_3_5                 : 3;
+	uint64_t bist_delay                   : 58;
+#endif
+	} cn70xx;
+	struct cvmx_rst_cfg_cn70xx            cn70xxp1;
+	struct cvmx_rst_cfg_cn73xx {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t bist_delay                   : 58;
+	uint64_t reserved_1_5                 : 5;
+	uint64_t clr_bist                     : 1;
+#else
+	uint64_t clr_bist                     : 1;
+	uint64_t reserved_1_5                 : 5;
+	uint64_t bist_delay                   : 58;
+#endif
+	} cn73xx;
+	struct cvmx_rst_cfg_cn70xx            cn78xx;
+};
+
+union cvmx_rst_ckill {
+	uint64_t u64;
+	struct cvmx_rst_ckill_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_47_63               : 17;
+	uint64_t timer                        : 47;
+#else
+	uint64_t timer                        : 47;
+	uint64_t reserved_47_63               : 17;
+#endif
+	} s;
+	struct cvmx_rst_ckill_s               cn70xx;
+	struct cvmx_rst_ckill_s               cn70xxp1;
+	struct cvmx_rst_ckill_s               cn73xx;
+	struct cvmx_rst_ckill_s               cn78xx;
+};
+
+union cvmx_rst_cold_datax {
+	uint64_t u64;
+	struct cvmx_rst_cold_datax_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t data                         : 64;
+#else
+	uint64_t data                         : 64;
+#endif
+	} s;
+	struct cvmx_rst_cold_datax_s          cn73xx;
+};
+
+union cvmx_rst_ctlx {
+	uint64_t u64;
+	struct cvmx_rst_ctlx_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_10_63               : 54;
+	uint64_t prst_link                    : 1;
+	uint64_t rst_done                     : 1;
+	uint64_t rst_link                     : 1;
+	uint64_t host_mode                    : 1;
+	uint64_t reserved_4_5                 : 2;
+	uint64_t rst_drv                      : 1;
+	uint64_t rst_rcv                      : 1;
+	uint64_t rst_chip                     : 1;
+	uint64_t rst_val                      : 1;
+#else
+	uint64_t rst_val                      : 1;
+	uint64_t rst_chip                     : 1;
+	uint64_t rst_rcv                      : 1;
+	uint64_t rst_drv                      : 1;
+	uint64_t reserved_4_5                 : 2;
+	uint64_t host_mode                    : 1;
+	uint64_t rst_link                     : 1;
+	uint64_t rst_done                     : 1;
+	uint64_t prst_link                    : 1;
+	uint64_t reserved_10_63               : 54;
+#endif
+	} s;
+	struct cvmx_rst_ctlx_s                cn70xx;
+	struct cvmx_rst_ctlx_s                cn70xxp1;
+	struct cvmx_rst_ctlx_s                cn73xx;
+	struct cvmx_rst_ctlx_s                cn78xx;
+};
+
+union cvmx_rst_delay {
+	uint64_t u64;
+	struct cvmx_rst_delay_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_32_63               : 32;
+	uint64_t warm_rst_dly                 : 16;
+	uint64_t soft_rst_dly                 : 16;
+#else
+	uint64_t soft_rst_dly                 : 16;
+	uint64_t warm_rst_dly                 : 16;
+	uint64_t reserved_32_63               : 32;
+#endif
+	} s;
+	struct cvmx_rst_delay_s               cn70xx;
+	struct cvmx_rst_delay_s               cn70xxp1;
+	struct cvmx_rst_delay_s               cn73xx;
+	struct cvmx_rst_delay_s               cn78xx;
+};
+
+union cvmx_rst_eco {
+	uint64_t u64;
+	struct cvmx_rst_eco_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_32_63               : 32;
+	uint64_t eco_rw                       : 32;
+#else
+	uint64_t eco_rw                       : 32;
+	uint64_t reserved_32_63               : 32;
+#endif
+	} s;
+	struct cvmx_rst_eco_s                 cn73xx;
+	struct cvmx_rst_eco_s                 cn78xx;
+};
+
+union cvmx_rst_int {
+	uint64_t u64;
+	struct cvmx_rst_int_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_12_63               : 52;
+	uint64_t perst                        : 4;
+	uint64_t reserved_4_7                 : 4;
+	uint64_t rst_link                     : 4;
+#else
+	uint64_t rst_link                     : 4;
+	uint64_t reserved_4_7                 : 4;
+	uint64_t perst                        : 4;
+	uint64_t reserved_12_63               : 52;
+#endif
+	} s;
+	struct cvmx_rst_int_cn70xx {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_11_63               : 53;
+	uint64_t perst                        : 3;
+	uint64_t reserved_3_7                 : 5;
+	uint64_t rst_link                     : 3;
+#else
+	uint64_t rst_link                     : 3;
+	uint64_t reserved_3_7                 : 5;
+	uint64_t perst                        : 3;
+	uint64_t reserved_11_63               : 53;
+#endif
+	} cn70xx;
+	struct cvmx_rst_int_cn70xx            cn70xxp1;
+	struct cvmx_rst_int_s                 cn73xx;
+	struct cvmx_rst_int_s                 cn78xx;
+};
+
+union cvmx_rst_int_w1s {
+	uint64_t u64;
+	struct cvmx_rst_int_w1s_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_12_63               : 52;
+	uint64_t perst                        : 4;
+	uint64_t reserved_4_7                 : 4;
+	uint64_t rst_link                     : 4;
+#else
+	uint64_t rst_link                     : 4;
+	uint64_t reserved_4_7                 : 4;
+	uint64_t perst                        : 4;
+	uint64_t reserved_12_63               : 52;
+#endif
+	} s;
+	struct cvmx_rst_int_w1s_s             cn73xx;
+};
+
+union cvmx_rst_ocx {
+	uint64_t u64;
+	struct cvmx_rst_ocx_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_3_63                : 61;
+	uint64_t rst_link                     : 3;
+#else
+	uint64_t rst_link                     : 3;
+	uint64_t reserved_3_63                : 61;
+#endif
+	} s;
+	struct cvmx_rst_ocx_s                 cn78xx;
+};
+
+union cvmx_rst_out_ctl {
+	uint64_t u64;
+	struct cvmx_rst_out_ctl_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_1_63                : 63;
+	uint64_t soft_rst                     : 1;
+#else
+	uint64_t soft_rst                     : 1;
+	uint64_t reserved_1_63                : 63;
+#endif
+	} s;
+	struct cvmx_rst_out_ctl_s             cn73xx;
+};
+
+union cvmx_rst_power_dbg {
+	uint64_t u64;
+	struct cvmx_rst_power_dbg_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_3_63                : 61;
+	uint64_t str                          : 3;
+#else
+	uint64_t str                          : 3;
+	uint64_t reserved_3_63                : 61;
+#endif
+	} s;
+	struct cvmx_rst_power_dbg_s           cn73xx;
+	struct cvmx_rst_power_dbg_s           cn78xx;
+};
+
+union cvmx_rst_pp_power {
+	uint64_t u64;
+	struct cvmx_rst_pp_power_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_48_63               : 16;
+	uint64_t gate                         : 48;
+#else
+	uint64_t gate                         : 48;
+	uint64_t reserved_48_63               : 16;
+#endif
+	} s;
+	struct cvmx_rst_pp_power_cn70xx {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_4_63                : 60;
+	uint64_t gate                         : 4;
+#else
+	uint64_t gate                         : 4;
+	uint64_t reserved_4_63                : 60;
+#endif
+	} cn70xx;
+	struct cvmx_rst_pp_power_cn70xx       cn70xxp1;
+	struct cvmx_rst_pp_power_cn73xx {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_16_63               : 48;
+	uint64_t gate                         : 16;
+#else
+	uint64_t gate                         : 16;
+	uint64_t reserved_16_63               : 48;
+#endif
+	} cn73xx;
+	struct cvmx_rst_pp_power_s            cn78xx;
+};
+
+union cvmx_rst_ref_cntr {
+	uint64_t u64;
+	struct cvmx_rst_ref_cntr_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t cnt                          : 64;
+#else
+	uint64_t cnt                          : 64;
+#endif
+	} s;
+	struct cvmx_rst_ref_cntr_s            cn73xx;
+};
+
+union cvmx_rst_soft_prstx {
+	uint64_t u64;
+	struct cvmx_rst_soft_prstx_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_1_63                : 63;
+	uint64_t soft_prst                    : 1;
+#else
+	uint64_t soft_prst                    : 1;
+	uint64_t reserved_1_63                : 63;
+#endif
+	} s;
+	struct cvmx_rst_soft_prstx_s          cn70xx;
+	struct cvmx_rst_soft_prstx_s          cn70xxp1;
+	struct cvmx_rst_soft_prstx_s          cn73xx;
+	struct cvmx_rst_soft_prstx_s          cn78xx;
+};
+
+union cvmx_rst_soft_rst {
+	uint64_t u64;
+	struct cvmx_rst_soft_rst_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_1_63                : 63;
+	uint64_t soft_rst                     : 1;
+#else
+	uint64_t soft_rst                     : 1;
+	uint64_t reserved_1_63                : 63;
+#endif
+	} s;
+	struct cvmx_rst_soft_rst_s            cn70xx;
+	struct cvmx_rst_soft_rst_s            cn70xxp1;
+	struct cvmx_rst_soft_rst_s            cn73xx;
+	struct cvmx_rst_soft_rst_s            cn78xx;
+};
+
+union cvmx_rst_thermal_alert {
+	uint64_t u64;
+	struct cvmx_rst_thermal_alert_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_9_63                : 55;
+	uint64_t trip                         : 1;
+	uint64_t reserved_1_7                 : 7;
+	uint64_t alert                        : 1;
+#else
+	uint64_t alert                        : 1;
+	uint64_t reserved_1_7                 : 7;
+	uint64_t trip                         : 1;
+	uint64_t reserved_9_63                : 55;
+#endif
+	} s;
+	struct cvmx_rst_thermal_alert_s       cn73xx;
+};
+
+#endif
-- 
2.1.3
