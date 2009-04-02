Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Apr 2009 08:42:19 +0100 (BST)
Received: from tenor.i-cable.com ([203.83.115.107]:38899 "HELO
	tenor.i-cable.com") by ftp.linux-mips.org with SMTP
	id S20021857AbZDBHmM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Apr 2009 08:42:12 +0100
Received: (qmail 15065 invoked by uid 508); 2 Apr 2009 07:42:02 -0000
Received: from 203.83.114.121 by tenor (envelope-from <r0bertz@gentoo.org>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/7824.  
 Clear:RC:1(203.83.114.121):. 
 Processed in 0.132846 secs); 02 Apr 2009 07:42:02 -0000
Received: from ip114121.hkicable.com (HELO silicon.i-cable.com) (203.83.114.121)
  by 0 with SMTP; 2 Apr 2009 07:42:01 -0000
Received: from localhost.localdomain (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by silicon.i-cable.com (8.13.5/8.13.5) with ESMTP id n327fxvt026842;
	Thu, 2 Apr 2009 15:42:01 +0800 (HKT)
From:	Zhang Le <r0bertz@gentoo.org>
To:	linux-mips@linux-mips.org
Cc:	Zhang Le <r0bertz@gentoo.org>
Subject: [PATCH] added Loongson cpu-feature-overrides.h
Date:	Thu,  2 Apr 2009 15:41:45 +0800
Message-Id: <1238658105-23260-1-git-send-email-r0bertz@gentoo.org>
X-Mailer: git-send-email 1.6.2
Return-Path: <r0bertz@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

added Loongson cpu-feature-overrides.h

I have taken Wu Zhangjin's and Philippe Vachon's version as references, did a
little modification and tested on 16K page size kernel. It works well.

Unfornately although it already has defined cpu_has_dc_aliases as 1, 4k page
size still not working. More work needed here.

Signed-off-by: Zhang Le <r0bertz@gentoo.org>
---
 .../asm/mach-lemote/cpu-feature-overrides.h        |   59 ++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-lemote/cpu-feature-overrides.h

diff --git a/arch/mips/include/asm/mach-lemote/cpu-feature-overrides.h b/arch/mips/include/asm/mach-lemote/cpu-feature-overrides.h
new file mode 100644
index 0000000..550a10d
--- /dev/null
+++ b/arch/mips/include/asm/mach-lemote/cpu-feature-overrides.h
@@ -0,0 +1,59 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2009 Wu Zhangjin <wuzj@lemote.com>
+ * Copyright (C) 2009 Philippe Vachon <philippe@cowpig.ca>
+ * Copyright (C) 2009 Zhang Le <r0bertz@gentoo.org>
+ *
+ * reference: /proc/cpuinfo,
+ * 	arch/mips/kernel/cpu-probe.c(cpu_probe_legacy),
+ * 	arch/mips/kernel/proc.c(show_cpuinfo),
+ *      loongson2f user manual.
+ */
+
+#ifndef __ASM_MACH_LEMOTE_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_LEMOTE_CPU_FEATURE_OVERRIDES_H
+
+#define cpu_dcache_line_size()	32
+#define cpu_icache_line_size()	32
+#define cpu_scache_line_size()	32
+
+
+#define cpu_has_32fpr		1
+#define cpu_has_3k_cache	0
+#define cpu_has_4k_cache	1
+#define cpu_has_4kex		1
+#define cpu_has_64bits		1
+#define cpu_has_cache_cdex_p	0
+#define cpu_has_cache_cdex_s	0
+#define cpu_has_counter		1
+#define cpu_has_dc_aliases	1
+#define cpu_has_divec		0
+#define cpu_has_dsp		0
+#define cpu_has_ejtag		0
+#define cpu_has_fpu		1
+#define cpu_has_ic_fills_f_dc	0
+#define cpu_has_inclusive_pcaches	1
+#define cpu_has_llsc 		1
+#define cpu_has_mcheck		0
+#define cpu_has_mdmx		0
+#define cpu_has_mips16		0
+#define cpu_has_mips32r1	0
+#define cpu_has_mips32r2	0
+#define cpu_has_mips3d		0
+#define cpu_has_mips64r1	0
+#define cpu_has_mips64r2	0
+#define cpu_has_mipsmt		0
+#define cpu_has_prefetch	0
+#define cpu_has_smartmips	0
+#define cpu_has_tlb		1
+#define cpu_has_tx39_cache	0
+#define cpu_has_userlocal	0
+#define cpu_has_vce		0
+#define cpu_has_vtag_icache	0
+#define cpu_has_watch		1
+#define cpu_icache_snoops_remote_store	1
+
+#endif /* __ASM_MACH_LEMOTE_CPU_FEATURE_OVERRIDES_H */
-- 
1.6.2
