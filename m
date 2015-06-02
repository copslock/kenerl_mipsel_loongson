Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2015 00:03:47 +0200 (CEST)
Received: from resqmta-ch2-09v.sys.comcast.net ([69.252.207.41]:35551 "EHLO
        resqmta-ch2-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006896AbbFBWDqEYU2k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2015 00:03:46 +0200
Received: from resomta-ch2-03v.sys.comcast.net ([69.252.207.99])
        by resqmta-ch2-09v.sys.comcast.net with comcast
        id ba3C1q00729Cfhx01a3fa6; Tue, 02 Jun 2015 22:03:39 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-03v.sys.comcast.net with comcast
        id ba3d1q00S42s2jH01a3esp; Tue, 02 Jun 2015 22:03:39 +0000
Message-ID: <556E2833.8060407@gentoo.org>
Date:   Tue, 02 Jun 2015 18:03:31 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: IP27: Update/restructure CPU overrides
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1433282619;
        bh=PeetWFHmZZ6f++lGLd0Qi4y/Uc2Cn1H5pC0Q2z15LPc=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=Dj7Lw648mzYndVs3jATBWVWKk12kyxeVBo2CrhkRmGIeV7qWPO/VLipJQASzM9ziN
         Mj7eFHVWdxIocFsd/M1OakRSSCggPSgf7R59/U+09BBoyQMfuYx6wOaRe1z85lk4ct
         4uASVydH89v+lBeATCfG1zoGwmdWiOIVCSJWanD/CE23LHek1caVtYIwlQGkmTRa+d
         53l/kXjLXi9uE1fqBT+QSU46qk8ig180Fs7LrfKpHnvXyTmM79HQTrS4ff5zOCeau+
         Wp6QeKcNIdK/JnnK/l4BZZgfkEcL028RT+Am1ZQogaXfqZPMa4n+r0qXKIjR+BbK1c
         DvSRcZBDtj8dw==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

From: Joshua Kinard <kumba@gentoo.org>

Inspired by Maciej's recent patch to update DEC cpu-feature-overrides.h,
I updated IP27's as well to disable features known to not apply to the
IP27 platform or the R10K-series of CPUs.

Before:
   text    data     bss     dec     hex filename
8616648  463200  472240 9552088  91c0d8 vmlinux

After:
   text    data     bss     dec     hex filename
8592256  471392  472240 9535888  918190 vmlinux

I believe the increase in the size of the data section is for the same
reasons as in the DEC patch.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h |   92 ++++++----
 1 file changed, 57 insertions(+), 35 deletions(-)

The number of changes is due to restructuring the file to be similar to
IP30's, so that eventually, all of the SGI platforms will have a similar
look to their cpu-feature-overrides.h file, making it easier to update
in the future.  I'll also send one for IP32 shortly, as that needs some
more careful updating due to the various CPUs it supports.

linux-mips-ip27-update-cpu-feature-overrides.patch
diff --git a/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h
index d6111aa..7449794 100644
--- a/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h
@@ -11,47 +11,69 @@
 #include <asm/cpu.h>
 
 /*
- * IP27 only comes with R10000 family processors all using the same config
+ * IP27 only comes with R1x000 family processors, all using the same config
  */
-#define cpu_has_watch		1
-#define cpu_has_mips16		0
-#define cpu_has_divec		0
-#define cpu_has_vce		0
-#define cpu_has_cache_cdex_p	0
-#define cpu_has_cache_cdex_s	0
-#define cpu_has_prefetch	1
-#define cpu_has_mcheck		0
-#define cpu_has_ejtag		0
+#define cpu_has_tlb			1
+#define cpu_has_tlbinv			0
+#define cpu_has_segments		0
+#define cpu_has_eva			0
+#define cpu_has_htw			0
+#define cpu_has_rixiex			0
+#define cpu_has_maar			0
+#define cpu_has_rw_llb			0
+#define cpu_has_3kex			0
+#define cpu_has_4kex			1
+#define cpu_has_3k_cache		0
+#define cpu_has_4k_cache		1
+#define cpu_has_6k_cache		0
+#define cpu_has_8k_cache		0
+#define cpu_has_tx39_cache		0
+#define cpu_has_fpu			1
+#define cpu_has_nofpuex			0
+#define cpu_has_32fpr			1
+#define cpu_has_counter			1
+#define cpu_has_watch			1
+#define cpu_has_64bits			1
+#define cpu_has_divec			0
+#define cpu_has_vce			0
+#define cpu_has_cache_cdex_p		0
+#define cpu_has_cache_cdex_s		0
+#define cpu_has_prefetch		1
+#define cpu_has_mcheck			0
+#define cpu_has_ejtag			0
+#define cpu_has_llsc			1
+#define cpu_has_mips16			0
+#define cpu_has_mdmx			0
+#define cpu_has_mips3d			0
+#define cpu_has_smartmips		0
+#define cpu_has_rixi			0
+#define cpu_has_xpa			0
+#define cpu_has_vtag_icache		0
+#define cpu_has_dc_aliases		0
+#define cpu_has_ic_fills_f_dc		0
 
-#define cpu_has_llsc		1
-#define cpu_has_vtag_icache	0
-#define cpu_has_dc_aliases	0
-#define cpu_has_ic_fills_f_dc	0
-#define cpu_has_dsp		0
-#define cpu_has_dsp2		0
 #define cpu_icache_snoops_remote_store	1
-#define cpu_has_mipsmt		0
-#define cpu_has_userlocal	0
 
-#define cpu_has_nofpuex		0
-#define cpu_has_64bits		1
-
-#define cpu_has_4kex		1
-#define cpu_has_3k_cache	0
-#define cpu_has_6k_cache	0
-#define cpu_has_4k_cache	1
-#define cpu_has_8k_cache	0
-#define cpu_has_tx39_cache	0
+#define cpu_has_mips32r1		0
+#define cpu_has_mips32r2		0
+#define cpu_has_mips64r1		0
+#define cpu_has_mips64r2		0
+#define cpu_has_mips32r6		0
+#define cpu_has_mips64r6		0
 
+#define cpu_has_dsp			0
+#define cpu_has_dsp2			0
+#define cpu_has_mipsmt			0
+#define cpu_has_userlocal		0
 #define cpu_has_inclusive_pcaches	1
+#define cpu_hwrena_impl_bits		0
+#define cpu_has_perf_cntr_intr_bit	0
+#define cpu_has_vz			0
+#define cpu_has_fre			0
+#define cpu_has_cdmm			0
 
-#define cpu_dcache_line_size()	32
-#define cpu_icache_line_size()	64
-#define cpu_scache_line_size()	128
-
-#define cpu_has_mips32r1	0
-#define cpu_has_mips32r2	0
-#define cpu_has_mips64r1	0
-#define cpu_has_mips64r2	0
+#define cpu_dcache_line_size()		32
+#define cpu_icache_line_size()		64
+#define cpu_scache_line_size()		128
 
 #endif /* __ASM_MACH_IP27_CPU_FEATURE_OVERRIDES_H */
