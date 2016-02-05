Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Feb 2016 01:43:52 +0100 (CET)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33683 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014891AbcBEAnSIzD7l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Feb 2016 01:43:18 +0100
Received: by mail-pf0-f195.google.com with SMTP id c10so4082913pfc.0;
        Thu, 04 Feb 2016 16:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E6afx6t5TwB5gDMMJBXmr1CTPMAs+tjwsQRrxBeMoEo=;
        b=1HnF8KUjdBuiR9EFiMedSJ3BoQkjrhpq3QyRoE80Rtxfa6u9hB3OmbqdxTd5HhDxM9
         oF242L3tGye3Ze0spIwkCBRoG4gsZ1Q3ahFOGoqADR3lx9OZ9dsDkIUEQiVKRqz785dU
         ucto9AqJz5QDaEgHulr3hSrrpCaTsFgBFN6Ufc9W2s6EKwF1rlnEF11sukWKuRJAvaH6
         IocRY6sSaNYvlPLuC2vTNxvjY+cuRMDkYVlE734fMNV5BHLH1/tMM8TB1T+WgGeNLt9c
         4du5rZL3gEFKdq+7k9LBRvsqaVCEXKE/+NZEMTq+wT6zZjH7hZ4EKk0hVBpeCjRnqEBQ
         VNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E6afx6t5TwB5gDMMJBXmr1CTPMAs+tjwsQRrxBeMoEo=;
        b=GhjpfkN9Cgx0crTYKtKvNVRoSMnBlvuIv08pSDnRVrbU813Na1n8wNyUo3IxLzQS73
         rOhIdhgv+sztUA//VwxZbADDW87RBR0NRnkfglWEbUqnmlBpDeoFOJRRck/vHbbr7kmE
         BvsHUt0/qHEForpp74bnYB9X/vRdXa3glx6/8v86KdWQcnlt92abquanSmyiYh1Sbyzo
         mxt4w7A/9+6rFaP+hajIJgKTJitb1RGABh468SRG2QDmdVqDE2A+t98p93uldDsrbHUp
         dWlTAinzPMR9BAQRAp9NuOYRvQ2duxmUGLvAGIPF7MSjM+0PSQNc16VotkaUBWG6XFjE
         Mztg==
X-Gm-Message-State: AG10YOSgsEXo3AZ0yksO7hwXHMXylvil+YupUOd5+knaVfMtZou8IzJ54N/ym99mi3shmA==
X-Received: by 10.98.64.4 with SMTP id n4mr2780284pfa.58.1454632992325;
        Thu, 04 Feb 2016 16:43:12 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.gmail.com with ESMTPSA id u21sm19853251pfi.15.2016.02.04.16.43.04
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 04 Feb 2016 16:43:08 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id u150h46H007739;
        Thu, 4 Feb 2016 16:43:04 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id u150h4f9007738;
        Thu, 4 Feb 2016 16:43:04 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 3/7] MIPS: OCTEON: Add register definitions for cn73xx, cnf75xx and cn78xx.
Date:   Thu,  4 Feb 2016 16:42:50 -0800
Message-Id: <1454632974-7686-4-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1454632974-7686-1-git-send-email-ddaney.cavm@gmail.com>
References: <1454632974-7686-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

These new members of the OCTEON III family have some new registers,
update some of the definitions for use in follow on patches.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/octeon/cvmx-ciu3-defs.h | 353 ++++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx-fpa-defs.h  |   1 +
 arch/mips/include/asm/octeon/cvmx-mio-defs.h  | 410 +++++++++++++++++++++++++-
 3 files changed, 748 insertions(+), 16 deletions(-)
 create mode 100644 arch/mips/include/asm/octeon/cvmx-ciu3-defs.h

diff --git a/arch/mips/include/asm/octeon/cvmx-ciu3-defs.h b/arch/mips/include/asm/octeon/cvmx-ciu3-defs.h
new file mode 100644
index 0000000..547f778
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-ciu3-defs.h
@@ -0,0 +1,353 @@
+/*
+ * Copyright (c) 2003-2016 Cavium Inc.
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
+ */
+
+#ifndef __CVMX_CIU3_DEFS_H__
+#define __CVMX_CIU3_DEFS_H__
+
+#define CVMX_CIU3_FUSE CVMX_ADD_IO_SEG(0x00010100000001A0ull)
+#define CVMX_CIU3_BIST CVMX_ADD_IO_SEG(0x00010100000001C0ull)
+#define CVMX_CIU3_CONST CVMX_ADD_IO_SEG(0x0001010000000220ull)
+#define CVMX_CIU3_CTL CVMX_ADD_IO_SEG(0x00010100000000E0ull)
+#define CVMX_CIU3_DESTX_IO_INT(offset) (CVMX_ADD_IO_SEG(0x0001010000210000ull) + ((offset) & 7) * 8)
+#define CVMX_CIU3_DESTX_PP_INT(offset) (CVMX_ADD_IO_SEG(0x0001010000200000ull) + ((offset) & 255) * 8)
+#define CVMX_CIU3_GSTOP CVMX_ADD_IO_SEG(0x0001010000000140ull)
+#define CVMX_CIU3_IDTX_CTL(offset) (CVMX_ADD_IO_SEG(0x0001010000110000ull) + ((offset) & 255) * 8)
+#define CVMX_CIU3_IDTX_IO(offset) (CVMX_ADD_IO_SEG(0x0001010000130000ull) + ((offset) & 255) * 8)
+#define CVMX_CIU3_IDTX_PPX(offset, block_id) (CVMX_ADD_IO_SEG(0x0001010000120000ull) + ((block_id) & 255) * 0x20ull)
+#define CVMX_CIU3_INTR_RAM_ECC_CTL CVMX_ADD_IO_SEG(0x0001010000000260ull)
+#define CVMX_CIU3_INTR_RAM_ECC_ST CVMX_ADD_IO_SEG(0x0001010000000280ull)
+#define CVMX_CIU3_INTR_READY CVMX_ADD_IO_SEG(0x00010100000002A0ull)
+#define CVMX_CIU3_INTR_SLOWDOWN CVMX_ADD_IO_SEG(0x0001010000000240ull)
+#define CVMX_CIU3_ISCX_CTL(offset) (CVMX_ADD_IO_SEG(0x0001010080000000ull) + ((offset) & 1048575) * 8)
+#define CVMX_CIU3_ISCX_W1C(offset) (CVMX_ADD_IO_SEG(0x0001010090000000ull) + ((offset) & 1048575) * 8)
+#define CVMX_CIU3_ISCX_W1S(offset) (CVMX_ADD_IO_SEG(0x00010100A0000000ull) + ((offset) & 1048575) * 8)
+#define CVMX_CIU3_NMI CVMX_ADD_IO_SEG(0x0001010000000160ull)
+#define CVMX_CIU3_SISCX(offset) (CVMX_ADD_IO_SEG(0x0001010000220000ull) + ((offset) & 255) * 8)
+#define CVMX_CIU3_TIMX(offset) (CVMX_ADD_IO_SEG(0x0001010000010000ull) + ((offset) & 15) * 8)
+
+union cvmx_ciu3_bist {
+	uint64_t u64;
+	struct cvmx_ciu3_bist_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_9_63                : 55;
+	uint64_t bist                         : 9;
+#else
+	uint64_t bist                         : 9;
+	uint64_t reserved_9_63                : 55;
+#endif
+	} s;
+};
+
+union cvmx_ciu3_const {
+	uint64_t u64;
+	struct cvmx_ciu3_const_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t dests_io                     : 16;
+	uint64_t pintsn                       : 16;
+	uint64_t dests_pp                     : 16;
+	uint64_t idt                          : 16;
+#else
+	uint64_t idt                          : 16;
+	uint64_t dests_pp                     : 16;
+	uint64_t pintsn                       : 16;
+	uint64_t dests_io                     : 16;
+#endif
+	} s;
+};
+
+union cvmx_ciu3_ctl {
+	uint64_t u64;
+	struct cvmx_ciu3_ctl_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_5_63                : 59;
+	uint64_t mcd_sel                      : 2;
+	uint64_t iscmem_le                    : 1;
+	uint64_t seq_dis                      : 1;
+	uint64_t cclk_dis                     : 1;
+#else
+	uint64_t cclk_dis                     : 1;
+	uint64_t seq_dis                      : 1;
+	uint64_t iscmem_le                    : 1;
+	uint64_t mcd_sel                      : 2;
+	uint64_t reserved_5_63                : 59;
+#endif
+	} s;
+};
+
+union cvmx_ciu3_destx_io_int {
+	uint64_t u64;
+	struct cvmx_ciu3_destx_io_int_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_52_63               : 12;
+	uint64_t intsn                        : 20;
+	uint64_t reserved_10_31               : 22;
+	uint64_t intidt                       : 8;
+	uint64_t newint                       : 1;
+	uint64_t intr                         : 1;
+#else
+	uint64_t intr                         : 1;
+	uint64_t newint                       : 1;
+	uint64_t intidt                       : 8;
+	uint64_t reserved_10_31               : 22;
+	uint64_t intsn                        : 20;
+	uint64_t reserved_52_63               : 12;
+#endif
+	} s;
+};
+
+union cvmx_ciu3_destx_pp_int {
+	uint64_t u64;
+	struct cvmx_ciu3_destx_pp_int_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_52_63               : 12;
+	uint64_t intsn                        : 20;
+	uint64_t reserved_10_31               : 22;
+	uint64_t intidt                       : 8;
+	uint64_t newint                       : 1;
+	uint64_t intr                         : 1;
+#else
+	uint64_t intr                         : 1;
+	uint64_t newint                       : 1;
+	uint64_t intidt                       : 8;
+	uint64_t reserved_10_31               : 22;
+	uint64_t intsn                        : 20;
+	uint64_t reserved_52_63               : 12;
+#endif
+	} s;
+};
+
+union cvmx_ciu3_gstop {
+	uint64_t u64;
+	struct cvmx_ciu3_gstop_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_1_63                : 63;
+	uint64_t gstop                        : 1;
+#else
+	uint64_t gstop                        : 1;
+	uint64_t reserved_1_63                : 63;
+#endif
+	} s;
+};
+
+union cvmx_ciu3_idtx_ctl {
+	uint64_t u64;
+	struct cvmx_ciu3_idtx_ctl_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_52_63               : 12;
+	uint64_t intsn                        : 20;
+	uint64_t reserved_4_31                : 28;
+	uint64_t intr                         : 1;
+	uint64_t newint                       : 1;
+	uint64_t ip_num                       : 2;
+#else
+	uint64_t ip_num                       : 2;
+	uint64_t newint                       : 1;
+	uint64_t intr                         : 1;
+	uint64_t reserved_4_31                : 28;
+	uint64_t intsn                        : 20;
+	uint64_t reserved_52_63               : 12;
+#endif
+	} s;
+};
+
+union cvmx_ciu3_idtx_io {
+	uint64_t u64;
+	struct cvmx_ciu3_idtx_io_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_5_63                : 59;
+	uint64_t io                           : 5;
+#else
+	uint64_t io                           : 5;
+	uint64_t reserved_5_63                : 59;
+#endif
+	} s;
+};
+
+union cvmx_ciu3_idtx_ppx {
+	uint64_t u64;
+	struct cvmx_ciu3_idtx_ppx_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_48_63               : 16;
+	uint64_t pp                           : 48;
+#else
+	uint64_t pp                           : 48;
+	uint64_t reserved_48_63               : 16;
+#endif
+	} s;
+};
+
+union cvmx_ciu3_intr_ram_ecc_ctl {
+	uint64_t u64;
+	struct cvmx_ciu3_intr_ram_ecc_ctl_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_3_63                : 61;
+	uint64_t flip_synd                    : 2;
+	uint64_t ecc_ena                      : 1;
+#else
+	uint64_t ecc_ena                      : 1;
+	uint64_t flip_synd                    : 2;
+	uint64_t reserved_3_63                : 61;
+#endif
+	} s;
+};
+
+union cvmx_ciu3_intr_ram_ecc_st {
+	uint64_t u64;
+	struct cvmx_ciu3_intr_ram_ecc_st_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_52_63               : 12;
+	uint64_t addr                         : 20;
+	uint64_t reserved_6_31                : 26;
+	uint64_t sisc_dbe                     : 1;
+	uint64_t sisc_sbe                     : 1;
+	uint64_t idt_dbe                      : 1;
+	uint64_t idt_sbe                      : 1;
+	uint64_t isc_dbe                      : 1;
+	uint64_t isc_sbe                      : 1;
+#else
+	uint64_t isc_sbe                      : 1;
+	uint64_t isc_dbe                      : 1;
+	uint64_t idt_sbe                      : 1;
+	uint64_t idt_dbe                      : 1;
+	uint64_t sisc_sbe                     : 1;
+	uint64_t sisc_dbe                     : 1;
+	uint64_t reserved_6_31                : 26;
+	uint64_t addr                         : 20;
+	uint64_t reserved_52_63               : 12;
+#endif
+	} s;
+};
+
+union cvmx_ciu3_intr_ready {
+	uint64_t u64;
+	struct cvmx_ciu3_intr_ready_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_46_63               : 18;
+	uint64_t index                        : 14;
+	uint64_t reserved_1_31                : 31;
+	uint64_t ready                        : 1;
+#else
+	uint64_t ready                        : 1;
+	uint64_t reserved_1_31                : 31;
+	uint64_t index                        : 14;
+	uint64_t reserved_46_63               : 18;
+#endif
+	} s;
+};
+
+union cvmx_ciu3_intr_slowdown {
+	uint64_t u64;
+	struct cvmx_ciu3_intr_slowdown_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_3_63                : 61;
+	uint64_t ctl                          : 3;
+#else
+	uint64_t ctl                          : 3;
+	uint64_t reserved_3_63                : 61;
+#endif
+	} s;
+};
+
+union cvmx_ciu3_iscx_ctl {
+	uint64_t u64;
+	struct cvmx_ciu3_iscx_ctl_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_24_63               : 40;
+	uint64_t idt                          : 8;
+	uint64_t imp                          : 1;
+	uint64_t reserved_2_14                : 13;
+	uint64_t en                           : 1;
+	uint64_t raw                          : 1;
+#else
+	uint64_t raw                          : 1;
+	uint64_t en                           : 1;
+	uint64_t reserved_2_14                : 13;
+	uint64_t imp                          : 1;
+	uint64_t idt                          : 8;
+	uint64_t reserved_24_63               : 40;
+#endif
+	} s;
+};
+
+union cvmx_ciu3_iscx_w1c {
+	uint64_t u64;
+	struct cvmx_ciu3_iscx_w1c_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_2_63                : 62;
+	uint64_t en                           : 1;
+	uint64_t raw                          : 1;
+#else
+	uint64_t raw                          : 1;
+	uint64_t en                           : 1;
+	uint64_t reserved_2_63                : 62;
+#endif
+	} s;
+};
+
+union cvmx_ciu3_iscx_w1s {
+	uint64_t u64;
+	struct cvmx_ciu3_iscx_w1s_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_2_63                : 62;
+	uint64_t en                           : 1;
+	uint64_t raw                          : 1;
+#else
+	uint64_t raw                          : 1;
+	uint64_t en                           : 1;
+	uint64_t reserved_2_63                : 62;
+#endif
+	} s;
+};
+
+union cvmx_ciu3_nmi {
+	uint64_t u64;
+	struct cvmx_ciu3_nmi_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_48_63               : 16;
+	uint64_t nmi                          : 48;
+#else
+	uint64_t nmi                          : 48;
+	uint64_t reserved_48_63               : 16;
+#endif
+	} s;
+};
+
+union cvmx_ciu3_siscx {
+	uint64_t u64;
+	struct cvmx_ciu3_siscx_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t en                           : 64;
+#else
+	uint64_t en                           : 64;
+#endif
+	} s;
+};
+
+union cvmx_ciu3_timx {
+	uint64_t u64;
+	struct cvmx_ciu3_timx_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+	uint64_t reserved_37_63               : 27;
+	uint64_t one_shot                     : 1;
+	uint64_t len                          : 36;
+#else
+	uint64_t len                          : 36;
+	uint64_t one_shot                     : 1;
+	uint64_t reserved_37_63               : 27;
+#endif
+	} s;
+};
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-fpa-defs.h b/arch/mips/include/asm/octeon/cvmx-fpa-defs.h
index 1d79e3c..887ff8e 100644
--- a/arch/mips/include/asm/octeon/cvmx-fpa-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-fpa-defs.h
@@ -66,6 +66,7 @@
 #define CVMX_FPA_WART_CTL (CVMX_ADD_IO_SEG(0x00011800280000D8ull))
 #define CVMX_FPA_WART_STATUS (CVMX_ADD_IO_SEG(0x00011800280000E0ull))
 #define CVMX_FPA_WQE_THRESHOLD (CVMX_ADD_IO_SEG(0x0001180028000468ull))
+#define CVMX_FPA_CLK_COUNT (CVMX_ADD_IO_SEG(0x00012800000000F0ull))
 
 union cvmx_fpa_addr_range_error {
 	uint64_t u64;
diff --git a/arch/mips/include/asm/octeon/cvmx-mio-defs.h b/arch/mips/include/asm/octeon/cvmx-mio-defs.h
index bb0ae33..5196c04 100644
--- a/arch/mips/include/asm/octeon/cvmx-mio-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-mio-defs.h
@@ -1481,7 +1481,9 @@ union cvmx_mio_fus_dat2 {
 	uint64_t u64;
 	struct cvmx_mio_fus_dat2_s {
 #ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_48_63:16;
+		uint64_t reserved_59_63:5;
+		uint64_t run_platform:3;
+		uint64_t gbl_pwr_throttle:8;
 		uint64_t fus118:1;
 		uint64_t rom_info:10;
 		uint64_t power_limit:2;
@@ -1513,7 +1515,9 @@ union cvmx_mio_fus_dat2 {
 		uint64_t power_limit:2;
 		uint64_t rom_info:10;
 		uint64_t fus118:1;
-		uint64_t reserved_48_63:16;
+		uint64_t gbl_pwr_throttle:8;
+		uint64_t run_platform:3;
+		uint64_t reserved_59_63:5;
 #endif
 	} s;
 	struct cvmx_mio_fus_dat2_cn30xx {
@@ -1837,50 +1841,192 @@ union cvmx_mio_fus_dat2 {
 #endif
 	} cn68xx;
 	struct cvmx_mio_fus_dat2_cn68xx cn68xxp1;
+	struct cvmx_mio_fus_dat2_cn70xx {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t reserved_48_63:16;
+		uint64_t fus118:1;
+		uint64_t rom_info:10;
+		uint64_t power_limit:2;
+		uint64_t dorm_crypto:1;
+		uint64_t fus318:1;
+		uint64_t raid_en:1;
+		uint64_t reserved_31_29:3;
+		uint64_t nodfa_cp2:1;
+		uint64_t nomul:1;
+		uint64_t nocrypto:1;
+		uint64_t reserved_25_24:2;
+		uint64_t chip_id:8;
+		uint64_t reserved_15_0:16;
+#else
+		uint64_t reserved_15_0:16;
+		uint64_t chip_id:8;
+		uint64_t reserved_25_24:2;
+		uint64_t nocrypto:1;
+		uint64_t nomul:1;
+		uint64_t nodfa_cp2:1;
+		uint64_t reserved_31_29:3;
+		uint64_t raid_en:1;
+		uint64_t fus318:1;
+		uint64_t dorm_crypto:1;
+		uint64_t power_limit:2;
+		uint64_t rom_info:10;
+		uint64_t fus118:1;
+		uint64_t reserved_48_63:16;
+#endif
+	} cn70xx;
+	struct cvmx_mio_fus_dat2_cn70xx cn70xxp1;
+	struct cvmx_mio_fus_dat2_cn73xx {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t reserved_59_63:5;
+		uint64_t run_platform:3;
+		uint64_t gbl_pwr_throttle:8;
+		uint64_t fus118:1;
+		uint64_t rom_info:10;
+		uint64_t power_limit:2;
+		uint64_t dorm_crypto:1;
+		uint64_t fus318:1;
+		uint64_t raid_en:1;
+		uint64_t reserved_31_29:3;
+		uint64_t nodfa_cp2:1;
+		uint64_t nomul:1;
+		uint64_t nocrypto:1;
+		uint64_t reserved_25_24:2;
+		uint64_t chip_id:8;
+		uint64_t reserved_15_0:16;
+#else
+		uint64_t reserved_15_0:16;
+		uint64_t chip_id:8;
+		uint64_t reserved_25_24:2;
+		uint64_t nocrypto:1;
+		uint64_t nomul:1;
+		uint64_t nodfa_cp2:1;
+		uint64_t reserved_31_29:3;
+		uint64_t raid_en:1;
+		uint64_t fus318:1;
+		uint64_t dorm_crypto:1;
+		uint64_t power_limit:2;
+		uint64_t rom_info:10;
+		uint64_t fus118:1;
+		uint64_t gbl_pwr_throttle:8;
+		uint64_t run_platform:3;
+		uint64_t reserved_59_63:5;
+#endif
+	} cn73xx;
+	struct cvmx_mio_fus_dat2_cn78xx {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t reserved_59_63:5;
+		uint64_t run_platform:3;
+		uint64_t reserved_48_55:8;
+		uint64_t fus118:1;
+		uint64_t rom_info:10;
+		uint64_t power_limit:2;
+		uint64_t dorm_crypto:1;
+		uint64_t fus318:1;
+		uint64_t raid_en:1;
+		uint64_t reserved_31_29:3;
+		uint64_t nodfa_cp2:1;
+		uint64_t nomul:1;
+		uint64_t nocrypto:1;
+		uint64_t reserved_25_24:2;
+		uint64_t chip_id:8;
+		uint64_t reserved_0_15:16;
+#else
+		uint64_t reserved_0_15:16;
+		uint64_t chip_id:8;
+		uint64_t reserved_25_24:2;
+		uint64_t nocrypto:1;
+		uint64_t nomul:1;
+		uint64_t nodfa_cp2:1;
+		uint64_t reserved_31_29:3;
+		uint64_t raid_en:1;
+		uint64_t fus318:1;
+		uint64_t dorm_crypto:1;
+		uint64_t power_limit:2;
+		uint64_t rom_info:10;
+		uint64_t fus118:1;
+		uint64_t reserved_48_55:8;
+		uint64_t run_platform:3;
+		uint64_t reserved_59_63:5;
+#endif
+	} cn78xx;
+	struct cvmx_mio_fus_dat2_cn78xxp2 {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t reserved_59_63:5;
+		uint64_t run_platform:3;
+		uint64_t gbl_pwr_throttle:8;
+		uint64_t fus118:1;
+		uint64_t rom_info:10;
+		uint64_t power_limit:2;
+		uint64_t dorm_crypto:1;
+		uint64_t fus318:1;
+		uint64_t raid_en:1;
+		uint64_t reserved_31_29:3;
+		uint64_t nodfa_cp2:1;
+		uint64_t nomul:1;
+		uint64_t nocrypto:1;
+		uint64_t reserved_25_24:2;
+		uint64_t chip_id:8;
+		uint64_t reserved_0_15:16;
+#else
+		uint64_t reserved_0_15:16;
+		uint64_t chip_id:8;
+		uint64_t reserved_25_24:2;
+		uint64_t nocrypto:1;
+		uint64_t nomul:1;
+		uint64_t nodfa_cp2:1;
+		uint64_t reserved_31_29:3;
+		uint64_t raid_en:1;
+		uint64_t fus318:1;
+		uint64_t dorm_crypto:1;
+		uint64_t power_limit:2;
+		uint64_t rom_info:10;
+		uint64_t fus118:1;
+		uint64_t gbl_pwr_throttle:8;
+		uint64_t run_platform:3;
+		uint64_t reserved_59_63:5;
+#endif
+	} cn78xxp2;
 	struct cvmx_mio_fus_dat2_cn61xx cnf71xx;
+	struct cvmx_mio_fus_dat2_cn73xx cnf75xx;
 };
 
 union cvmx_mio_fus_dat3 {
 	uint64_t u64;
 	struct cvmx_mio_fus_dat3_s {
 #ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_58_63:6;
+		uint64_t ema0:6;
 		uint64_t pll_ctl:10;
 		uint64_t dfa_info_dte:3;
 		uint64_t dfa_info_clm:4;
-		uint64_t reserved_40_40:1;
-		uint64_t ema:2;
+		uint64_t pll_alt_matrix:1;
+		uint64_t reserved_38_39:2;
 		uint64_t efus_lck_rsv:1;
 		uint64_t efus_lck_man:1;
 		uint64_t pll_half_dis:1;
 		uint64_t l2c_crip:3;
-		uint64_t pll_div4:1;
-		uint64_t reserved_29_30:2;
-		uint64_t bar2_en:1;
+		uint64_t reserved_28_31:4;
 		uint64_t efus_lck:1;
 		uint64_t efus_ign:1;
 		uint64_t nozip:1;
 		uint64_t nodfa_dte:1;
-		uint64_t icache:24;
+		uint64_t reserved_0_23:24;
 #else
-		uint64_t icache:24;
+		uint64_t reserved_0_23:24;
 		uint64_t nodfa_dte:1;
 		uint64_t nozip:1;
 		uint64_t efus_ign:1;
 		uint64_t efus_lck:1;
-		uint64_t bar2_en:1;
-		uint64_t reserved_29_30:2;
-		uint64_t pll_div4:1;
+		uint64_t reserved_28_31:4;
 		uint64_t l2c_crip:3;
 		uint64_t pll_half_dis:1;
 		uint64_t efus_lck_man:1;
 		uint64_t efus_lck_rsv:1;
-		uint64_t ema:2;
-		uint64_t reserved_40_40:1;
+		uint64_t reserved_38_39:2;
+		uint64_t pll_alt_matrix:1;
 		uint64_t dfa_info_clm:4;
 		uint64_t dfa_info_dte:3;
 		uint64_t pll_ctl:10;
-		uint64_t reserved_58_63:6;
+		uint64_t ema0:6;
 #endif
 	} s;
 	struct cvmx_mio_fus_dat3_cn30xx {
@@ -2022,7 +2168,239 @@ union cvmx_mio_fus_dat3 {
 	struct cvmx_mio_fus_dat3_cn61xx cn66xx;
 	struct cvmx_mio_fus_dat3_cn61xx cn68xx;
 	struct cvmx_mio_fus_dat3_cn61xx cn68xxp1;
+	struct cvmx_mio_fus_dat3_cn70xx {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t ema0:6;
+		uint64_t pll_ctl:10;
+		uint64_t dfa_info_dte:3;
+		uint64_t dfa_info_clm:4;
+		uint64_t pll_alt_matrix:1;
+		uint64_t pll_bwadj_denom:2;
+		uint64_t efus_lck_rsv:1;
+		uint64_t efus_lck_man:1;
+		uint64_t pll_half_dis:1;
+		uint64_t l2c_crip:3;
+		uint64_t use_int_refclk:1;
+		uint64_t zip_info:2;
+		uint64_t bar2_sz_conf:1;
+		uint64_t efus_lck:1;
+		uint64_t efus_ign:1;
+		uint64_t nozip:1;
+		uint64_t nodfa_dte:1;
+		uint64_t ema1:6;
+		uint64_t reserved_0_17:18;
+#else
+		uint64_t reserved_0_17:18;
+		uint64_t ema1:6;
+		uint64_t nodfa_dte:1;
+		uint64_t nozip:1;
+		uint64_t efus_ign:1;
+		uint64_t efus_lck:1;
+		uint64_t bar2_sz_conf:1;
+		uint64_t zip_info:2;
+		uint64_t use_int_refclk:1;
+		uint64_t l2c_crip:3;
+		uint64_t pll_half_dis:1;
+		uint64_t efus_lck_man:1;
+		uint64_t efus_lck_rsv:1;
+		uint64_t pll_bwadj_denom:2;
+		uint64_t pll_alt_matrix:1;
+		uint64_t dfa_info_clm:4;
+		uint64_t dfa_info_dte:3;
+		uint64_t pll_ctl:10;
+		uint64_t ema0:6;
+#endif
+	} cn70xx;
+	struct cvmx_mio_fus_dat3_cn70xxp1 {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t ema0:6;
+		uint64_t pll_ctl:10;
+		uint64_t dfa_info_dte:3;
+		uint64_t dfa_info_clm:4;
+		uint64_t reserved_38_40:3;
+		uint64_t efus_lck_rsv:1;
+		uint64_t efus_lck_man:1;
+		uint64_t pll_half_dis:1;
+		uint64_t l2c_crip:3;
+		uint64_t reserved_31_31:1;
+		uint64_t zip_info:2;
+		uint64_t bar2_sz_conf:1;
+		uint64_t efus_lck:1;
+		uint64_t efus_ign:1;
+		uint64_t nozip:1;
+		uint64_t nodfa_dte:1;
+		uint64_t ema1:6;
+		uint64_t reserved_0_17:18;
+#else
+		uint64_t reserved_0_17:18;
+		uint64_t ema1:6;
+		uint64_t nodfa_dte:1;
+		uint64_t nozip:1;
+		uint64_t efus_ign:1;
+		uint64_t efus_lck:1;
+		uint64_t bar2_sz_conf:1;
+		uint64_t zip_info:2;
+		uint64_t reserved_31_31:1;
+		uint64_t l2c_crip:3;
+		uint64_t pll_half_dis:1;
+		uint64_t efus_lck_man:1;
+		uint64_t efus_lck_rsv:1;
+		uint64_t reserved_38_40:3;
+		uint64_t dfa_info_clm:4;
+		uint64_t dfa_info_dte:3;
+		uint64_t pll_ctl:10;
+		uint64_t ema0:6;
+#endif
+	} cn70xxp1;
+	struct cvmx_mio_fus_dat3_cn73xx {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t ema0:6;
+		uint64_t pll_ctl:10;
+		uint64_t dfa_info_dte:3;
+		uint64_t dfa_info_clm:4;
+		uint64_t pll_alt_matrix:1;
+		uint64_t pll_bwadj_denom:2;
+		uint64_t efus_lck_rsv:1;
+		uint64_t efus_lck_man:1;
+		uint64_t pll_half_dis:1;
+		uint64_t l2c_crip:3;
+		uint64_t use_int_refclk:1;
+		uint64_t zip_info:2;
+		uint64_t bar2_sz_conf:1;
+		uint64_t efus_lck:1;
+		uint64_t efus_ign:1;
+		uint64_t nozip:1;
+		uint64_t nodfa_dte:1;
+		uint64_t ema1:6;
+		uint64_t nohna_dte:1;
+		uint64_t hna_info_dte:3;
+		uint64_t hna_info_clm:4;
+		uint64_t reserved_9_9:1;
+		uint64_t core_pll_mul:5;
+		uint64_t pnr_pll_mul:4;
+#else
+		uint64_t pnr_pll_mul:4;
+		uint64_t core_pll_mul:5;
+		uint64_t reserved_9_9:1;
+		uint64_t hna_info_clm:4;
+		uint64_t hna_info_dte:3;
+		uint64_t nohna_dte:1;
+		uint64_t ema1:6;
+		uint64_t nodfa_dte:1;
+		uint64_t nozip:1;
+		uint64_t efus_ign:1;
+		uint64_t efus_lck:1;
+		uint64_t bar2_sz_conf:1;
+		uint64_t zip_info:2;
+		uint64_t use_int_refclk:1;
+		uint64_t l2c_crip:3;
+		uint64_t pll_half_dis:1;
+		uint64_t efus_lck_man:1;
+		uint64_t efus_lck_rsv:1;
+		uint64_t pll_bwadj_denom:2;
+		uint64_t pll_alt_matrix:1;
+		uint64_t dfa_info_clm:4;
+		uint64_t dfa_info_dte:3;
+		uint64_t pll_ctl:10;
+		uint64_t ema0:6;
+#endif
+	} cn73xx;
+	struct cvmx_mio_fus_dat3_cn78xx {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t ema0:6;
+		uint64_t pll_ctl:10;
+		uint64_t dfa_info_dte:3;
+		uint64_t dfa_info_clm:4;
+		uint64_t reserved_38_40:3;
+		uint64_t efus_lck_rsv:1;
+		uint64_t efus_lck_man:1;
+		uint64_t pll_half_dis:1;
+		uint64_t l2c_crip:3;
+		uint64_t reserved_31_31:1;
+		uint64_t zip_info:2;
+		uint64_t bar2_sz_conf:1;
+		uint64_t efus_lck:1;
+		uint64_t efus_ign:1;
+		uint64_t nozip:1;
+		uint64_t nodfa_dte:1;
+		uint64_t ema1:6;
+		uint64_t nohna_dte:1;
+		uint64_t hna_info_dte:3;
+		uint64_t hna_info_clm:4;
+		uint64_t reserved_0_9:10;
+#else
+		uint64_t reserved_0_9:10;
+		uint64_t hna_info_clm:4;
+		uint64_t hna_info_dte:3;
+		uint64_t nohna_dte:1;
+		uint64_t ema1:6;
+		uint64_t nodfa_dte:1;
+		uint64_t nozip:1;
+		uint64_t efus_ign:1;
+		uint64_t efus_lck:1;
+		uint64_t bar2_sz_conf:1;
+		uint64_t zip_info:2;
+		uint64_t reserved_31_31:1;
+		uint64_t l2c_crip:3;
+		uint64_t pll_half_dis:1;
+		uint64_t efus_lck_man:1;
+		uint64_t efus_lck_rsv:1;
+		uint64_t reserved_38_40:3;
+		uint64_t dfa_info_clm:4;
+		uint64_t dfa_info_dte:3;
+		uint64_t pll_ctl:10;
+		uint64_t ema0:6;
+#endif
+	} cn78xx;
+	struct cvmx_mio_fus_dat3_cn73xx cn78xxp2;
 	struct cvmx_mio_fus_dat3_cn61xx cnf71xx;
+	struct cvmx_mio_fus_dat3_cnf75xx {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t ema0:6;
+		uint64_t pll_ctl:10;
+		uint64_t dfa_info_dte:3;
+		uint64_t dfa_info_clm:4;
+		uint64_t pll_alt_matrix:1;
+		uint64_t pll_bwadj_denom:2;
+		uint64_t efus_lck_rsv:1;
+		uint64_t efus_lck_man:1;
+		uint64_t pll_half_dis:1;
+		uint64_t l2c_crip:3;
+		uint64_t use_int_refclk:1;
+		uint64_t zip_info:2;
+		uint64_t bar2_sz_conf:1;
+		uint64_t efus_lck:1;
+		uint64_t efus_ign:1;
+		uint64_t nozip:1;
+		uint64_t nodfa_dte:1;
+		uint64_t ema1:6;
+		uint64_t reserved_9_17:9;
+		uint64_t core_pll_mul:5;
+		uint64_t pnr_pll_mul:4;
+#else
+		uint64_t pnr_pll_mul:4;
+		uint64_t core_pll_mul:5;
+		uint64_t reserved_9_17:9;
+		uint64_t ema1:6;
+		uint64_t nodfa_dte:1;
+		uint64_t nozip:1;
+		uint64_t efus_ign:1;
+		uint64_t efus_lck:1;
+		uint64_t bar2_sz_conf:1;
+		uint64_t zip_info:2;
+		uint64_t use_int_refclk:1;
+		uint64_t l2c_crip:3;
+		uint64_t pll_half_dis:1;
+		uint64_t efus_lck_man:1;
+		uint64_t efus_lck_rsv:1;
+		uint64_t pll_bwadj_denom:2;
+		uint64_t pll_alt_matrix:1;
+		uint64_t dfa_info_clm:4;
+		uint64_t dfa_info_dte:3;
+		uint64_t pll_ctl:10;
+		uint64_t ema0:6;
+#endif
+	} cnf75xx;
 };
 
 union cvmx_mio_fus_ema {
-- 
1.7.11.7
