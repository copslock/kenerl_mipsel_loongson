Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Aug 2008 21:20:51 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13191 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S28585500AbYHTUUi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 Aug 2008 21:20:38 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B48ac7c900000>; Wed, 20 Aug 2008 16:20:32 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 20 Aug 2008 13:20:30 -0700
Received: from localhost.localdomain ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 20 Aug 2008 13:20:30 -0700
From:	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 2/2] OCTEON: Add workaround file
Date:	Wed, 20 Aug 2008 13:20:25 -0700
Message-Id: <1219263625-21540-1-git-send-email-tpaoletti@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <48A9E6DA.8030208@caviumnetworks.com>
References: <48A9E6DA.8030208@caviumnetworks.com>
X-OriginalArrivalTime: 20 Aug 2008 20:20:30.0679 (UTC) FILETIME=[312F9670:01C90302]
Return-Path: <Tomaso.Paoletti@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tpaoletti@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Add OCTEON specific version of the workarounds file.
None of these apply to OCTEON, but the file is required.

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
---
 include/asm-mips/mach-cavium-octeon/war.h |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-mips/mach-cavium-octeon/war.h

diff --git a/include/asm-mips/mach-cavium-octeon/war.h b/include/asm-mips/mach-cavium-octeon/war.h
new file mode 100644
index 0000000..c4712d7
--- /dev/null
+++ b/include/asm-mips/mach-cavium-octeon/war.h
@@ -0,0 +1,26 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
+ * Copyright (C) 2008 Cavium Networks <support@caviumnetworks.com>
+ */
+#ifndef __ASM_MIPS_MACH_CAVIUM_OCTEON_WAR_H
+#define __ASM_MIPS_MACH_CAVIUM_OCTEON_WAR_H
+
+#define R4600_V1_INDEX_ICACHEOP_WAR	0
+#define R4600_V1_HIT_CACHEOP_WAR	0
+#define R4600_V2_HIT_CACHEOP_WAR	0
+#define R5432_CP0_INTERRUPT_WAR		0
+#define BCM1250_M3_WAR			0
+#define SIBYTE_1956_WAR			0
+#define MIPS4K_ICACHE_REFILL_WAR	0
+#define MIPS_CACHE_SYNC_WAR		0
+#define TX49XX_ICACHE_INDEX_INV_WAR	0
+#define RM9000_CDEX_SMP_WAR		0
+#define ICACHE_REFILLS_WORKAROUND_WAR	0
+#define R10000_LLSC_WAR			0
+#define MIPS34K_MISSED_ITLB_WAR		0
+
+#endif /* __ASM_MIPS_MACH_CAVIUM_OCTEON_WAR_H */
-- 
1.5.3.2
