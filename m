Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Aug 2009 20:38:50 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11032 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493520AbZHJSiW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 10 Aug 2009 20:38:22 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a8068ea0001>; Mon, 10 Aug 2009 14:37:30 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 10 Aug 2009 11:30:29 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 10 Aug 2009 11:30:29 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n7AIUQql029649;
	Mon, 10 Aug 2009 11:30:26 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n7AIUPTR029648;
	Mon, 10 Aug 2009 11:30:25 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	ralf@linux-mips.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/2] MIPS: Octeon:  Add hardware RNG platform device.
Date:	Mon, 10 Aug 2009 11:30:24 -0700
Message-Id: <1249929025-29625-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4A806529.3060609@caviumnetworks.com>
References: <4A806529.3060609@caviumnetworks.com>
X-OriginalArrivalTime: 10 Aug 2009 18:30:29.0225 (UTC) FILETIME=[A30EE590:01CA19E8]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Add a platform device for the Octeon Random Number Generator (RNG).

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/setup.c              |   44 +++++++++++++
 arch/mips/include/asm/octeon/cvmx-rnm-defs.h |   86 ++++++++++++++++++++++++++
 2 files changed, 130 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/octeon/cvmx-rnm-defs.h

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index bc0c869..c67487a 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -33,6 +33,7 @@
 #include <asm/time.h>
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-rnm-defs.h>
 
 #ifdef CONFIG_CAVIUM_DECODE_RSL
 extern void cvmx_interrupt_rsl_decode(void);
@@ -931,3 +932,46 @@ out:
 	return ret;
 }
 device_initcall(octeon_cf_device_init);
+
+/* Octeon Random Number Generator.  */
+static int __init octeon_rng_device_init(void)
+{
+	struct platform_device *pd;
+	struct resource rng_resources[2];
+	unsigned int res_count;
+	int ret = 0;
+
+	memset(rng_resources, 0, sizeof(rng_resources));
+	res_count = 0;
+	rng_resources[res_count].flags = IORESOURCE_MEM;
+	rng_resources[res_count].start = XKPHYS_TO_PHYS(CVMX_RNM_CTL_STATUS);
+	rng_resources[res_count].end = rng_resources[res_count].start + 0xf;
+	res_count++;
+
+	rng_resources[res_count].flags = IORESOURCE_MEM;
+	rng_resources[res_count].start = cvmx_build_io_address(8, 0);
+	rng_resources[res_count].end = rng_resources[res_count].start + 0x7;
+	res_count++;
+
+	pd = platform_device_alloc("octeon_rng", -1);
+	if (!pd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = platform_device_add_resources(pd, rng_resources, res_count);
+	if (ret)
+		goto fail;
+
+	ret = platform_device_add(pd);
+	if (ret)
+		goto fail;
+
+	return ret;
+fail:
+	platform_device_put(pd);
+
+out:
+	return ret;
+}
+device_initcall(octeon_rng_device_init);
diff --git a/arch/mips/include/asm/octeon/cvmx-rnm-defs.h b/arch/mips/include/asm/octeon/cvmx-rnm-defs.h
new file mode 100644
index 0000000..a25e2bc
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-rnm-defs.h
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
+#ifndef __CVMX_RNM_DEFS_H__
+#define __CVMX_RNM_DEFS_H__
+
+#define CVMX_RNM_BIST_STATUS \
+	 CVMX_ADD_IO_SEG(0x0001180040000008ull)
+#define CVMX_RNM_CTL_STATUS \
+	 CVMX_ADD_IO_SEG(0x0001180040000000ull)
+
+union cvmx_rnm_bist_status {
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
+};
+
+union cvmx_rnm_ctl_status {
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
+};
+
+#endif
-- 
1.6.0.6
