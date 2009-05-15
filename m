Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 23:07:02 +0100 (BST)
Received: from wf-out-1314.google.com ([209.85.200.170]:24776 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023334AbZEOWGy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2009 23:06:54 +0100
Received: by wf-out-1314.google.com with SMTP id 28so1224824wfa.21
        for <multiple recipients>; Fri, 15 May 2009 15:06:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=CkNCOA7ozSt/zOJXYVIO6iuN80C/5bDQjx7/QOL6NrA=;
        b=b2gyVuPE5xp82w7asz1gSK+3xUlu2IKUufQ78W9H91FDAIK16ofJcEJGI4e8dr9sI+
         4iGRwXMKIlCTT0z2CUIQXp3YSKOdOOF2BqFQTl01XavaZcvirT+TETrIQRMRuOAs8biu
         O0lJJd83ByTlXu/29G9uUEUB6H1M1yq6mKHtg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=fozMFBXEen6qapKGrSneSnEwBJ1xNRjyyiUdmo6p3b3uhFEw53F3VMU418Lz5d1LIQ
         i7aDXrd4oevDwwK1ckTEODbCvpkXFB2yZyQ0qeqUXkuSEiU4GdqpX3HO3nv0/jdBapNn
         zs7hNi7aePZQj/x9hBPAatjVwVvIm7iR7lDZE=
Received: by 10.142.147.15 with SMTP id u15mr1363495wfd.152.1242425212847;
        Fri, 15 May 2009 15:06:52 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 28sm3660155wfg.25.2009.05.15.15.06.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 15:06:52 -0700 (PDT)
Subject: [PATCH 10/30] loongson: add loongson-specific
 cpu-feature-overrides.h
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 16 May 2009 06:06:46 +0800
Message-Id: <1242425206.10164.151.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

>From b2176298282082f661f3dcea3659ddf780c0ec5f Mon Sep 17 00:00:00 2001
From: Wu Zhangjin <wuzhangjin@gmail.com>
Date: Sat, 16 May 2009 01:17:12 +0800
Subject: [PATCH 10/30] loongson: add loongson-specific
cpu-feature-overrides.h

---
 .../asm/mach-loongson/cpu-feature-overrides.h      |   58
++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)
 create mode 100644
arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h

diff --git a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
new file mode 100644
index 0000000..daa2ee9
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
@@ -0,0 +1,58 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General
Public
+ * License.  See the file "COPYING" in the main directory of this
archive
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
+#ifndef __ASM_LOONGSON_CPU_FEATURE_OVERRIDES_H
+#define __ASM_LOONGSON_CPU_FEATURE_OVERRIDES_H
+
+#define cpu_dcache_line_size()	32
+#define cpu_icache_line_size()	32
+#define cpu_scache_line_size()	32
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
+#endif				/* __ASM_LOONGSON_CPU_FEATURE_OVERRIDES_H */
-- 
1.6.2.1
