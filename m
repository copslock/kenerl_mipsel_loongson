Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Aug 2014 10:49:11 +0200 (CEST)
Received: from mail-pd0-f173.google.com ([209.85.192.173]:38483 "EHLO
        mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816855AbaHOIsAz0M1J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Aug 2014 10:48:00 +0200
Received: by mail-pd0-f173.google.com with SMTP id w10so3043007pde.4
        for <multiple recipients>; Fri, 15 Aug 2014 01:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l/aMOBI8sHPj+cmmKAuYjHLEeJs3CGY1/DWeHzQg534=;
        b=IZORTGRZm91rr2un4eQS8su+zmabXpVVBdC0cXZ46iEeGzW0GAn7gXdtJ30g4zpjA2
         QB+92AC4HF4aMMcgw7L2OW81gYRhegpsSJrrOGi+BYmjQyt2pwJGUzvcBBspleeoPWhc
         9SzNcUhHeF2k/+wt+pnJqjpB39g84Ae5CLSPpTB0/2wTRFioBwKG2vElpptFiyBuYf8j
         Zr5lQBsE0swZCwxQflYVImb6pyBNN4y2efILXBHG8Ee/WKSrFLXHBBGu6TgRmxRKjdj0
         BlfSpTwhtK6Myolz/HMU3SWbbTMjia6hP0zoON++KA/28kKfKIn2zAhrJOaQZ90iySSN
         /vcg==
X-Received: by 10.70.123.134 with SMTP id ma6mr13645026pdb.124.1408092474201;
        Fri, 15 Aug 2014 01:47:54 -0700 (PDT)
Received: from software.domain.org ([222.92.8.142])
        by mx.google.com with ESMTPSA id ou5sm7445462pbb.62.2014.08.15.01.47.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Aug 2014 01:47:53 -0700 (PDT)
From:   chenj <chenj@lemote.com>
To:     linux-mips@linux-mips.org
Cc:     chenhc@lemote.com, ralf@linux-mips.org, chenj <chenj@lemote.com>
Subject: [v2] mips: use wsbh/dsbh/dshd on Loongson 3A
Date:   Fri, 15 Aug 2014 16:56:58 +0800
Message-Id: <1408093018-25436-1-git-send-email-chenj@lemote.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <CAGXxSxXGpRBJm+8sYfYXN4-20OYdmJ4FgBDnPknv9uMBN9zBsQ@mail.gmail.com>
References: <CAGXxSxXGpRBJm+8sYfYXN4-20OYdmJ4FgBDnPknv9uMBN9zBsQ@mail.gmail.com>
Return-Path: <fykcee1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenj@lemote.com
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

Signed-off-by: chenj <chenj@lemote.com>
---
This patch is modified from http://patchwork.linux-mips.org/patch/7054/
The original author is ralf.

v2: using "#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_LOONGSON3)"
instead of "#if cpu_has_wsbh" in csum_partial.S

 arch/mips/include/asm/cpu-features.h                       | 10 ++++++++++
 .../include/asm/mach-cavium-octeon/cpu-feature-overrides.h |  1 +
 .../mips/include/asm/mach-loongson/cpu-feature-overrides.h |  2 ++
 arch/mips/include/uapi/asm/swab.h                          | 14 ++++++++++++--
 arch/mips/lib/csum_partial.S                               | 10 ++++++++--
 arch/mips/net/bpf_jit.c                                    |  2 +-
 6 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index e079598..3325f3e 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -231,6 +231,16 @@
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
index ac9a8f9..20b884a 100644
--- a/arch/mips/include/uapi/asm/swab.h
+++ b/arch/mips/include/uapi/asm/swab.h
@@ -13,12 +13,16 @@
 
 #define __SWAB_64_THRU_32__
 
-#if defined(__mips_isa_rev) && (__mips_isa_rev >= 2)
+#if (defined(__mips_isa_rev) && (__mips_isa_rev >= 2)) ||		\
+    defined(_MIPS_ARCH_LOONGSON3A)
 
 static inline __attribute_const__ __u16 __arch_swab16(__u16 x)
 {
 	__asm__(
+	"	.set	push			\n"
+	"	.set	arch=mips32r2		\n"
 	"	wsbh	%0, %1			\n"
+	"	.set	pop			\n"
 	: "=r" (x)
 	: "r" (x));
 
@@ -29,8 +33,11 @@ static inline __attribute_const__ __u16 __arch_swab16(__u16 x)
 static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
 {
 	__asm__(
+	"	.set	push			\n"
+	"	.set	arch=mips32r2		\n"
 	"	wsbh	%0, %1			\n"
 	"	rotr	%0, %0, 16		\n"
+	"	.set	pop			\n"
 	: "=r" (x)
 	: "r" (x));
 
@@ -46,8 +53,11 @@ static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
 static inline __attribute_const__ __u64 __arch_swab64(__u64 x)
 {
 	__asm__(
+	"	.set	push			\n"
+	"	.set	arch=mips64r2		\n"
 	"	dsbh	%0, %1\n"
 	"	dshd	%0, %0"
+	"	.set	pop			\n"
 	: "=r" (x)
 	: "r" (x));
 
@@ -55,5 +65,5 @@ static inline __attribute_const__ __u64 __arch_swab64(__u64 x)
 }
 #define __arch_swab64 __arch_swab64
 #endif /* __mips64 */
-#endif /* MIPS R2 or newer  */
+#endif /* MIPS R2 or newer or Loongson 3A */
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
index 05a5661..762f448 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -1262,7 +1262,7 @@ jmp_cmp:
 			emit_half_load(r_A, r_skb, off, ctx);
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
 			/* This needs little endian fixup */
-			if (cpu_has_mips_r2) {
+			if (cpu_has_wsbh) {
 				/* R2 and later have the wsbh instruction */
 				emit_wsbh(r_A, r_A, ctx);
 			} else {
-- 
1.9.0
