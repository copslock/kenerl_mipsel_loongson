Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jun 2014 20:44:30 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46200 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6854772AbaFCSo20-H0e (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Jun 2014 20:44:28 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s53IiFfi016787;
        Tue, 3 Jun 2014 20:44:15 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s53IiE4N016786;
        Tue, 3 Jun 2014 20:44:14 +0200
Date:   Tue, 3 Jun 2014 20:44:14 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     chenj <chenj@lemote.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: lib: csum_partial: use wsbh/movn on ls3
Message-ID: <20140603184414.GT17197@linux-mips.org>
References: <1400137743-8806-1-git-send-email-chenj@lemote.com>
 <1400137743-8806-2-git-send-email-chenj@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1400137743-8806-2-git-send-email-chenj@lemote.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, May 15, 2014 at 03:09:03PM +0800, chenj wrote:

> wsbh & movn are available on loongson3 CPU.

I think there are a few more case that need to be fixed than just
this file to make best use of WSBH and similar on Loongson 3A.  How
about below patch?

As I don't have Loongson 3 hardware I am not able to runtime test this.

Thanks,

  Ralf

 arch/mips/include/asm/cpu-features.h                           | 10 ++++++++++
 .../include/asm/mach-cavium-octeon/cpu-feature-overrides.h     |  1 +
 arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h    |  2 ++
 arch/mips/include/uapi/asm/swab.h                              |  5 +++--
 arch/mips/lib/csum_partial.S                                   | 10 ++++++++--
 arch/mips/net/bpf_jit.c                                        |  2 +-
 6 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index c7d8c99..d927bda 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -222,6 +222,16 @@
 #define cpu_has_clo_clz	cpu_has_mips_r
 #endif
 
+/*
+ * MIPS32 R2, MIPS64 R2, Loongson 3A and Octeon have WSBH.
+ * MIPS64 R2, Loongson 3A and Octeon have WSBH, DSBH and DSHD.
+ * This indicates the availability of WSBH and in case of 64 bit CPUs also
+ * DSBH and DSHD.
+ */
+#ifndef cpu_has_wsbh
+#define cpu_has_wsbh		cpu_has_mips_r2
+#endif
+
 #ifndef cpu_has_dsp
 #define cpu_has_dsp		(cpu_data[0].ases & MIPS_ASE_DSP)
 #endif
diff --git a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
index cf80228..fa1f3cf 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
@@ -57,6 +57,7 @@
 #define cpu_has_vint		0
 #define cpu_has_veic		0
 #define cpu_hwrena_impl_bits	0xc0000000
+#define cpu_has_wsbh            1
 
 #define cpu_has_rixi		(cpu_data[0].cputype != CPU_CAVIUM_OCTEON)
 
diff --git a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
index c0f3ef4..7d28f95 100644
--- a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
@@ -59,4 +59,6 @@
 #define cpu_has_watch		1
 #define cpu_has_local_ebase	0
 
+#define cpu_has_wsbh		IS_ENABLED(CONFIG_CPU_LOONGSON3)
+
 #endif /* __ASM_MACH_LOONGSON_CPU_FEATURE_OVERRIDES_H */
diff --git a/arch/mips/include/uapi/asm/swab.h b/arch/mips/include/uapi/asm/swab.h
index ac9a8f9..b2ab2cf 100644
--- a/arch/mips/include/uapi/asm/swab.h
+++ b/arch/mips/include/uapi/asm/swab.h
@@ -13,7 +13,8 @@
 
 #define __SWAB_64_THRU_32__
 
-#if defined(__mips_isa_rev) && (__mips_isa_rev >= 2)
+#if (defined(__mips_isa_rev) && (__mips_isa_rev >= 2)) ||		\
+    defined(_MIPS_ARCH_LOONGSON3A)
 
 static inline __attribute_const__ __u16 __arch_swab16(__u16 x)
 {
@@ -55,5 +56,5 @@ static inline __attribute_const__ __u64 __arch_swab64(__u64 x)
 }
 #define __arch_swab64 __arch_swab64
 #endif /* __mips64 */
-#endif /* MIPS R2 or newer  */
+#endif /* MIPS R2 or newer or Loongson 3A  */
 #endif /* _ASM_SWAB_H */
diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index 9901237..4c721e2 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -277,9 +277,12 @@ LEAF(csum_partial)
 #endif
 
 	/* odd buffer alignment? */
-#ifdef CONFIG_CPU_MIPSR2
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_LOONGSON3)
+	.set	push
+	.set	arch=mips32r2
 	wsbh	v1, sum
 	movn	sum, v1, t7
+	.set	pop
 #else
 	beqz	t7, 1f			/* odd buffer alignment? */
 	 lui	v1, 0x00ff
@@ -726,9 +729,12 @@ LEAF(csum_partial)
 	addu	sum, v1
 #endif
 
-#ifdef CONFIG_CPU_MIPSR2
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_LOONGSON3)
+	.set	push
+	.set	arch=mips32r2
 	wsbh	v1, sum
 	movn	sum, v1, odd
+	.set	pop
 #else
 	beqz	odd, 1f			/* odd buffer alignment? */
 	 lui	v1, 0x00ff
diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index a67b975..b2a560b 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -1240,7 +1240,7 @@ jmp_cmp:
 			emit_half_load(r_A, r_skb, off, ctx);
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
 			/* This needs little endian fixup */
-			if (cpu_has_mips_r2) {
+			if (cpu_has_wsbh) {
 				/* R2 and later have the wsbh instruction */
 				emit_wsbh(r_A, r_A, ctx);
 			} else {
