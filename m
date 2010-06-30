Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jul 2010 00:01:37 +0200 (CEST)
Received: from sj-iport-4.cisco.com ([171.68.10.86]:25707 "EHLO
        sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492021Ab0F3WBb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Jul 2010 00:01:31 +0200
Authentication-Results: sj-iport-4.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAABcK0yrR7H+/2dsb2JhbACfVXGldppDhSUEg2w
X-IronPort-AV: E=Sophos;i="4.53,515,1272844800"; 
   d="scan'208";a="152205575"
Received: from sj-core-2.cisco.com ([171.71.177.254])
  by sj-iport-4.cisco.com with ESMTP; 30 Jun 2010 22:01:24 +0000
Received: from dvomlehn-lnx2.corp.sa.net (dhcp-171-71-47-241.cisco.com [171.71.47.241])
        by sj-core-2.cisco.com (8.13.8/8.14.3) with ESMTP id o5UM1Ogv010968;
        Wed, 30 Jun 2010 22:01:24 GMT
Date:   Wed, 30 Jun 2010 15:01:24 -0700
From:   David VomLehn <dvomlehn@cisco.com>
To:     Shinya Kuribayashi <skuribay@pobox.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: PowerTV: Use fls() carefully where static
        optimization is required
Message-ID: <20100630220124.GA576@dvomlehn-lnx2.corp.sa.net>
References: <4C2755A3.3080600@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C2755A3.3080600@pobox.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Sun, Jun 27, 2010 at 08:44:03AM -0500, Shinya Kuribayashi wrote:
> fls()/__fls() defined at <asm/bitops.h>, doesn't use CLZ unless it's
> explicitly requested via <cpu-features-overrides.h>.  In other words,
> as long as depending on cpu_data[0].isa_level, CLZ is nerver used for
> fls()/__fls().
...
> It's MIPS32 machine and luckily clz() is left there, then let's go back
> to the original shape.
> 
> Signed-off-by: Shinya Kuribayashi <skuribay@pobox.com>

Thanks!  You are correct in your analysis and make a good point that
clz should be used in interrupt handling. I think, though, that it's
better to go ahead and supply a full-blown cpu-features-override.h 
rather than focusing on this one case. This way fls() will be optimized
to use clz everywhere and any other optimizations that depend on constant
cpu_has_* values will also be used.

The following patch provides cpu-features-override.h and removes the
unused clz() function in asic_int.c.

Signed-off-by: David VomLehn <dvomlehn@cisco.com>
---
 .../asm/mach-powertv/cpu-feature-overrides.h       |   59 ++++++++++++++++++++
 arch/mips/powertv/asic/asic_int.c                  |   13 ----
 2 files changed, 59 insertions(+), 13 deletions(-)

diff --git a/arch/mips/include/asm/mach-powertv/cpu-feature-overrides.h b/arch/mips/include/asm/mach-powertv/cpu-feature-overrides.h
new file mode 100644
index 0000000..f751e3e
--- /dev/null
+++ b/arch/mips/include/asm/mach-powertv/cpu-feature-overrides.h
@@ -0,0 +1,59 @@
+/*
+ * Copyright (C) 2010  Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef _ASM_MACH_POWERTV_CPU_FEATURE_OVERRIDES_H_
+#define _ASM_MACH_POWERTV_CPU_FEATURE_OVERRIDES_H_
+#define cpu_has_tlb			1
+#define cpu_has_4kex			1
+#define cpu_has_3k_cache		0
+#define cpu_has_4k_cache		1
+#define cpu_has_tx39_cache		0
+#define cpu_has_fpu			0
+#define cpu_has_counter			1
+#define cpu_has_watch			1
+#define cpu_has_divec			1
+#define cpu_has_vce			0
+#define cpu_has_cache_cdex_p		0
+#define cpu_has_cache_cdex_s		0
+#define cpu_has_mcheck			1
+#define cpu_has_ejtag			1
+#define cpu_has_llsc			1
+#define cpu_has_mips16			0
+#define cpu_has_mdmx			0
+#define cpu_has_mips3d			0
+#define cpu_has_smartmips		0
+#define cpu_has_vtag_icache		0
+#define cpu_has_dc_aliases		0
+#define cpu_has_ic_fills_f_dc		0
+#define cpu_has_mips32r1		0
+#define cpu_has_mips32r2		1
+#define cpu_has_mips64r1		0
+#define cpu_has_mips64r2		0
+#define cpu_has_dsp			0
+#define cpu_has_mipsmt			0
+#define cpu_has_userlocal		0
+#define cpu_has_nofpuex			0
+#define cpu_has_64bits			0
+#define cpu_has_64bit_zero_reg		0
+#define cpu_has_vint			1
+#define cpu_has_veic			1
+#define cpu_has_inclusive_pcaches	0
+
+#define cpu_dcache_line_size()		32
+#define cpu_icache_line_size()		32
+#endif
diff --git a/arch/mips/powertv/asic/asic_int.c b/arch/mips/powertv/asic/asic_int.c
index 529c44a..7362f63 100644
--- a/arch/mips/powertv/asic/asic_int.c
+++ b/arch/mips/powertv/asic/asic_int.c
@@ -68,19 +68,6 @@ static void asic_irqdispatch(void)
 	do_IRQ(irq);
 }
 
-static inline int clz(unsigned long x)
-{
-	__asm__(
-	"	.set	push					\n"
-	"	.set	mips32					\n"
-	"	clz	%0, %1					\n"
-	"	.set	pop					\n"
-	: "=r" (x)
-	: "r" (x));
-
-	return x;
-}
-
 /*
  * Version of ffs that only looks at bits 12..15.
  */
