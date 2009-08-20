Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Aug 2009 23:12:35 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:41122 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492897AbZHTVMI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Aug 2009 23:12:08 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a8dbbf20000>; Thu, 20 Aug 2009 17:11:14 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 20 Aug 2009 14:10:28 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 20 Aug 2009 14:10:28 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n7KLAOhr006553;
	Thu, 20 Aug 2009 14:10:24 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n7KLANUr006552;
	Thu, 20 Aug 2009 14:10:23 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	ralf@linux-mips.org, mpm@selenic.com, herbert@gondor.apana.org.au
Cc:	linux-mips@linux-mips.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/2] MIPS: Octeon:  Add hardware RNG platform device.
Date:	Thu, 20 Aug 2009 14:10:22 -0700
Message-Id: <1250802623-6526-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4A8DBB17.5020301@caviumnetworks.com>
References: <4A8DBB17.5020301@caviumnetworks.com>
X-OriginalArrivalTime: 20 Aug 2009 21:10:28.0850 (UTC) FILETIME=[A502ED20:01CA21DA]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Add a platform device for the Octeon Random Number Generator (RNG).

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/setup.c              |   43 +++++++++++++
 arch/mips/include/asm/octeon/cvmx-rnm-defs.h |   88 ++++++++++++++++++++++++++
 2 files changed, 131 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/octeon/cvmx-rnm-defs.h

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index bc0c869..d8cf674 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -33,6 +33,7 @@
 #include <asm/time.h>
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-rnm-defs.h>
 
 #ifdef CONFIG_CAVIUM_DECODE_RSL
 extern void cvmx_interrupt_rsl_decode(void);
@@ -931,3 +932,45 @@ out:
 	return ret;
 }
 device_initcall(octeon_cf_device_init);
+
+/* Octeon Random Number Generator.  */
+static int __init octeon_rng_device_init(void)
+{
+	struct platform_device *pd;
+	int ret = 0;
+
+	struct resource rng_resources[] = {
+		{
+			.flags	= IORESOURCE_MEM,
+			.start	= XKPHYS_TO_PHYS(CVMX_RNM_CTL_STATUS),
+			.end	= XKPHYS_TO_PHYS(CVMX_RNM_CTL_STATUS) + 0xf
+		}, {
+			.flags	= IORESOURCE_MEM,
+			.start	= cvmx_build_io_address(8, 0),
+			.end	= cvmx_build_io_address(8, 0) + 0x7
+		}
+	};
+
+	pd = platform_device_alloc("octeon_rng", -1);
+	if (!pd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = platform_device_add_resources(pd, rng_resources,
+					    ARRAY_SIZE(rng_resources));
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
index 0000000..4586958
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-rnm-defs.h
@@ -0,0 +1,88 @@
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
+#include <linux/types.h>
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
