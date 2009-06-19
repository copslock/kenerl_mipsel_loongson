Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Jun 2009 12:04:31 +0200 (CEST)
Received: from xylophone.i-cable.com ([203.83.115.99]:46451 "HELO
	xylophone.i-cable.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with SMTP id S1491777AbZFSKEZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 19 Jun 2009 12:04:25 +0200
Received: (qmail 21953 invoked by uid 508); 19 Jun 2009 10:02:12 -0000
Received: from 203.83.114.121 by xylophone (envelope-from <r0bertz@gentoo.org>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/7737.  
 Clear:RC:1(203.83.114.121):. 
 Processed in 0.167376 secs); 19 Jun 2009 10:02:12 -0000
Received: from ip114121.hkicable.com (HELO silicon.i-cable.com) (203.83.114.121)
  by 0 with SMTP; 19 Jun 2009 10:02:11 -0000
Received: from localhost.localdomain (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by silicon.i-cable.com (8.13.5/8.13.5) with ESMTP id n5JA25F9009175;
	Fri, 19 Jun 2009 18:02:09 +0800 (HKT)
From:	Zhang Le <r0bertz@gentoo.org>
To:	linux-mips@linux-mips.org
Cc:	Zhang Le <r0bertz@gentoo.org>
Subject: [PATCH] Two fixes of Loongson cpu-feature-overrides.h
Date:	Fri, 19 Jun 2009 18:01:39 +0800
Message-Id: <1245405699-8197-1-git-send-email-r0bertz@gentoo.org>
X-Mailer: git-send-email 1.6.3.1
Return-Path: <r0bertz@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

Loongson 2 currently does not have dcache alias actually, because it is using 16k
page, and the dcache is 4 way set associative 64k VIPT cache. It will have
dcache alias if the page size is smaller than 16k.

And because Loongson 2 is not an SMP cpu, cpu_icache_snoops_remote_store does
not matter here.

Signed-off-by: Zhang Le <r0bertz@gentoo.org>
---
 .../asm/mach-lemote/cpu-feature-overrides.h        |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-lemote/cpu-feature-overrides.h b/arch/mips/include/asm/mach-lemote/cpu-feature-overrides.h
index 550a10d..7484561 100644
--- a/arch/mips/include/asm/mach-lemote/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-lemote/cpu-feature-overrides.h
@@ -29,7 +29,7 @@
 #define cpu_has_cache_cdex_p	0
 #define cpu_has_cache_cdex_s	0
 #define cpu_has_counter		1
-#define cpu_has_dc_aliases	1
+#define cpu_has_dc_aliases	(PAGE_SIZE < 0x4000)
 #define cpu_has_divec		0
 #define cpu_has_dsp		0
 #define cpu_has_ejtag		0
@@ -54,6 +54,5 @@
 #define cpu_has_vce		0
 #define cpu_has_vtag_icache	0
 #define cpu_has_watch		1
-#define cpu_icache_snoops_remote_store	1
 
 #endif /* __ASM_MACH_LEMOTE_CPU_FEATURE_OVERRIDES_H */
-- 
1.6.3.1
