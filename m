Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2018 19:04:09 +0200 (CEST)
Received: from mail-wm1-x343.google.com ([IPv6:2a00:1450:4864:20::343]:37179
        "EHLO mail-wm1-x343.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992759AbeITREASGLue (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Sep 2018 19:04:00 +0200
Received: by mail-wm1-x343.google.com with SMTP id n11-v6so289869wmc.2;
        Thu, 20 Sep 2018 10:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4PO+2xN50YOGmdsMHqRRiz/sBgsLtYes0gmsz/5CQWk=;
        b=XGGz/SFZvEUKd2wjeWjMANhT6LtbvS+Z3pxGVsdoSW01Xf9rL8cUEVWXxnbenVzqrk
         7w5D8F/7ykxca5fbkxj4DH2KI1VBl7LCxK24m+pjYQx5qVZ+8xur3JLkXUuPFAvSXP2I
         R9lqPGSwIwqOe/eXRh4WuJieq55cwKogOCiBuLZU/ZkL14azOdHyz0NZxpTC7fRW+63h
         oL75gL1IecvC5VJRCo5cf3RCDpoP5Q+niEfWKhxr2h3JKJZBVbnSu6jHsJVAlfuAN04h
         eHV/hs+ZratmwZD+rmZZZNqYEkN+yVJs+VFs3uqNvNQAy25fjbGlZ2JAdDL8lI1IiR9M
         6GtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4PO+2xN50YOGmdsMHqRRiz/sBgsLtYes0gmsz/5CQWk=;
        b=MjWeErcX6gmZX2O8+NHW7EZ7NB1dCAgBK9tZT9ySICIsb7aA0HPsYl1C4hPkR7JEfS
         SBbgsblqBAHy4Qdv4QidkbbxO7zsEHSvB/OvPAPQx2ltAN3RO2m2LyYwXsmj3WppK2da
         hjAkjxmbe9B8Fx0KM8rbjQl4BGfFK4Dq0c12QTc9Moiru8h3nu7mopTkL61d1dkYHvUi
         Za3X6GNPMST4VHgMZJfWIVFTbPWdAZ/g/HxxWusY5YiyFvJxE0FTnRq2/mKBLT4/bC/B
         W04ouCGGd9dl4bXFuIdmlanbNReQRCEuSU0xE/BNYc/CajCABqBh735v0WpYeyETz2db
         L3zw==
X-Gm-Message-State: ABuFfohWuo06At77d/tRU3uDz44A1Li5jXtMP/ZLu2pLJpeKPwH9TqHZ
        l3rjscp3l/Y82oH551srXYg7OIwV8i4=
X-Google-Smtp-Source: ACcGV62r7aSjs0JmubjVJpjyAGwCTg4bQFugU4U04V6fjAIH+E6vPnHptGwxnvbWUduksoyzGIo9GA==
X-Received: by 2002:a1c:2905:: with SMTP id p5-v6mr3611154wmp.1.1537463034524;
        Thu, 20 Sep 2018 10:03:54 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id t131-v6sm1540221wmg.10.2018.09.20.10.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:03:54 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org,
        Yasha Cherikovsky <yasha.che3@gmail.com>
Subject: [PATCH 1/1] MIPS: Add new Kconfig variable to avoid unaligned access instructions
Date:   Thu, 20 Sep 2018 20:03:06 +0300
Message-Id: <20180920170306.9157-2-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180920170306.9157-1-yasha.che3@gmail.com>
References: <20180920170306.9157-1-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <yasha.che3@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yasha.che3@gmail.com
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

MIPSR6 doesn't support unaligned access instructions (lwl, lwr, swl, swr).
The MIPS tree has some special cases to avoid these instructions,
and currently the code is testing for CONFIG_CPU_MIPSR6.

Declare a new Kconfig variable: CONFIG_CPU_HAS_NO_UNALIGNED_LOAD_STORE,
and make CONFIG_CPU_MIPSR6 select it.
And switch all the special cases to test for the new variable.

Also, the new variable selects CONFIG_GENERIC_CSUM, to use
generic C checksum code (to avoid special assembly code that uses
the unsupported instructions).

This commit should not affect MIPSR6 behavior, and is required
for future Lexra CPU support, that misses these instructions too.

Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
---
 arch/mips/Kconfig            |  7 +++++--
 arch/mips/kernel/unaligned.c | 24 ++++++++++++------------
 arch/mips/lib/memcpy.S       | 10 +++++-----
 arch/mips/lib/memset.S       | 12 ++++++------
 4 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 08c10c518f83..5dd2f05ecd39 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1477,7 +1477,6 @@ config CPU_MIPS32_R6
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_MSA
-	select GENERIC_CSUM
 	select HAVE_KVM
 	select MIPS_O32_FP64_SUPPORT
 	help
@@ -1530,7 +1529,6 @@ config CPU_MIPS64_R6
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_MSA
-	select GENERIC_CSUM
 	select MIPS_O32_FP64_SUPPORT if 32BIT || MIPS32_O32
 	select HAVE_KVM
 	help
@@ -2032,6 +2030,7 @@ config CPU_MIPSR6
 	select MIPS_ASID_BITS_VARIABLE
 	select MIPS_CRC_SUPPORT
 	select MIPS_SPRAM
+	select CPU_HAS_NO_UNALIGNED_LOAD_STORE
 
 config EVA
 	bool
@@ -2456,6 +2455,10 @@ config XKS01
 config CPU_HAS_RIXI
 	bool
 
+config CPU_HAS_NO_UNALIGNED_LOAD_STORE
+	bool
+	select GENERIC_CSUM
+
 #
 # Vectored interrupt mode is an R2 feature
 #
diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index 2d0b912f9e3e..b19056aa8ea5 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -130,7 +130,7 @@ do {                                                        \
 			: "r" (addr), "i" (-EFAULT));       \
 } while(0)
 
-#ifndef CONFIG_CPU_MIPSR6
+#ifndef CONFIG_CPU_HAS_NO_UNALIGNED_LOAD_STORE
 #define     _LoadW(addr, value, res, type)   \
 do {                                                        \
 		__asm__ __volatile__ (                      \
@@ -186,7 +186,7 @@ do {                                                        \
 			: "r" (addr), "i" (-EFAULT));       \
 } while(0)
 
-#endif /* CONFIG_CPU_MIPSR6 */
+#endif /* CONFIG_CPU_HAS_NO_UNALIGNED_LOAD_STORE */
 
 #define     _LoadHWU(addr, value, res, type) \
 do {                                                        \
@@ -212,7 +212,7 @@ do {                                                        \
 			: "r" (addr), "i" (-EFAULT));       \
 } while(0)
 
-#ifndef CONFIG_CPU_MIPSR6
+#ifndef CONFIG_CPU_HAS_NO_UNALIGNED_LOAD_STORE
 #define     _LoadWU(addr, value, res, type)  \
 do {                                                        \
 		__asm__ __volatile__ (                      \
@@ -339,7 +339,7 @@ do {                                                        \
 			: "r" (addr), "i" (-EFAULT));       \
 } while(0)
 
-#endif /* CONFIG_CPU_MIPSR6 */
+#endif /* CONFIG_CPU_HAS_NO_UNALIGNED_LOAD_STORE */
 
 
 #define     _StoreHW(addr, value, res, type) \
@@ -365,7 +365,7 @@ do {                                                        \
 			: "r" (value), "r" (addr), "i" (-EFAULT));\
 } while(0)
 
-#ifndef CONFIG_CPU_MIPSR6
+#ifndef CONFIG_CPU_HAS_NO_UNALIGNED_LOAD_STORE
 #define     _StoreW(addr, value, res, type)  \
 do {                                                        \
 		__asm__ __volatile__ (                      \
@@ -483,7 +483,7 @@ do {                                                        \
 		: "memory");                                \
 } while(0)
 
-#endif /* CONFIG_CPU_MIPSR6 */
+#endif /* CONFIG_CPU_HAS_NO_UNALIGNED_LOAD_STORE */
 
 #else /* __BIG_ENDIAN */
 
@@ -509,7 +509,7 @@ do {                                                        \
 			: "r" (addr), "i" (-EFAULT));       \
 } while(0)
 
-#ifndef CONFIG_CPU_MIPSR6
+#ifndef CONFIG_CPU_HAS_NO_UNALIGNED_LOAD_STORE
 #define     _LoadW(addr, value, res, type)   \
 do {                                                        \
 		__asm__ __volatile__ (                      \
@@ -565,7 +565,7 @@ do {                                                        \
 			: "r" (addr), "i" (-EFAULT));       \
 } while(0)
 
-#endif /* CONFIG_CPU_MIPSR6 */
+#endif /* CONFIG_CPU_HAS_NO_UNALIGNED_LOAD_STORE */
 
 
 #define     _LoadHWU(addr, value, res, type) \
@@ -592,7 +592,7 @@ do {                                                        \
 			: "r" (addr), "i" (-EFAULT));       \
 } while(0)
 
-#ifndef CONFIG_CPU_MIPSR6
+#ifndef CONFIG_CPU_HAS_NO_UNALIGNED_LOAD_STORE
 #define     _LoadWU(addr, value, res, type)  \
 do {                                                        \
 		__asm__ __volatile__ (                      \
@@ -718,7 +718,7 @@ do {                                                        \
 			: "=&r" (value), "=r" (res)	    \
 			: "r" (addr), "i" (-EFAULT));       \
 } while(0)
-#endif /* CONFIG_CPU_MIPSR6 */
+#endif /* CONFIG_CPU_HAS_NO_UNALIGNED_LOAD_STORE */
 
 #define     _StoreHW(addr, value, res, type) \
 do {                                                        \
@@ -743,7 +743,7 @@ do {                                                        \
 			: "r" (value), "r" (addr), "i" (-EFAULT));\
 } while(0)
 
-#ifndef CONFIG_CPU_MIPSR6
+#ifndef CONFIG_CPU_HAS_NO_UNALIGNED_LOAD_STORE
 #define     _StoreW(addr, value, res, type)  \
 do {                                                        \
 		__asm__ __volatile__ (                      \
@@ -861,7 +861,7 @@ do {                                                        \
 		: "memory");                                \
 } while(0)
 
-#endif /* CONFIG_CPU_MIPSR6 */
+#endif /* CONFIG_CPU_HAS_NO_UNALIGNED_LOAD_STORE */
 #endif
 
 #define LoadHWU(addr, value, res)	_LoadHWU(addr, value, res, kernel)
diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
index 03e3304d6ae5..1bc8ee6398bb 100644
--- a/arch/mips/lib/memcpy.S
+++ b/arch/mips/lib/memcpy.S
@@ -297,7 +297,7 @@
 	 and	t0, src, ADDRMASK
 	PREFS(	0, 2*32(src) )
 	PREFD(	1, 2*32(dst) )
-#ifndef CONFIG_CPU_MIPSR6
+#ifndef CONFIG_CPU_HAS_NO_UNALIGNED_LOAD_STORE
 	bnez	t1, .Ldst_unaligned\@
 	 nop
 	bnez	t0, .Lsrc_unaligned_dst_aligned\@
@@ -385,7 +385,7 @@
 	bne	rem, len, 1b
 	.set	noreorder
 
-#ifndef CONFIG_CPU_MIPSR6
+#ifndef CONFIG_CPU_HAS_NO_UNALIGNED_LOAD_STORE
 	/*
 	 * src and dst are aligned, need to copy rem bytes (rem < NBYTES)
 	 * A loop would do only a byte at a time with possible branch
@@ -487,7 +487,7 @@
 	bne	len, rem, 1b
 	.set	noreorder
 
-#endif /* !CONFIG_CPU_MIPSR6 */
+#endif /* !CONFIG_CPU_HAS_NO_UNALIGNED_LOAD_STORE */
 .Lcopy_bytes_checklen\@:
 	beqz	len, .Ldone\@
 	 nop
@@ -516,7 +516,7 @@
 	jr	ra
 	 nop
 
-#ifdef CONFIG_CPU_MIPSR6
+#ifdef CONFIG_CPU_HAS_NO_UNALIGNED_LOAD_STORE
 .Lcopy_unaligned_bytes\@:
 1:
 	COPY_BYTE(0)
@@ -530,7 +530,7 @@
 	ADD	src, src, 8
 	b	1b
 	 ADD	dst, dst, 8
-#endif /* CONFIG_CPU_MIPSR6 */
+#endif /* CONFIG_CPU_HAS_NO_UNALIGNED_LOAD_STORE */
 	.if __memcpy == 1
 	END(memcpy)
 	.set __memcpy, 0
diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index 1cc306520a55..87f199df6902 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -112,7 +112,7 @@
 	.set		at
 #endif
 
-#ifndef CONFIG_CPU_MIPSR6
+#ifndef CONFIG_CPU_HAS_NO_UNALIGNED_LOAD_STORE
 	R10KCBARRIER(0(ra))
 #ifdef __MIPSEB__
 	EX(LONG_S_L, a1, (a0), .Lfirst_fixup\@)	/* make word/dword aligned */
@@ -122,7 +122,7 @@
 	PTR_SUBU	a0, t0			/* long align ptr */
 	PTR_ADDU	a2, t0			/* correct size */
 
-#else /* CONFIG_CPU_MIPSR6 */
+#else /* CONFIG_CPU_HAS_NO_UNALIGNED_LOAD_STORE */
 #define STORE_BYTE(N)				\
 	EX(sb, a1, N(a0), .Lbyte_fixup\@);	\
 	beqz		t0, 0f;			\
@@ -145,7 +145,7 @@
 	ori		a0, STORMASK
 	xori		a0, STORMASK
 	PTR_ADDIU	a0, STORSIZE
-#endif /* CONFIG_CPU_MIPSR6 */
+#endif /* CONFIG_CPU_HAS_NO_UNALIGNED_LOAD_STORE */
 1:	ori		t1, a2, 0x3f		/* # of full blocks */
 	xori		t1, 0x3f
 	beqz		t1, .Lmemset_partial\@	/* no block to fill */
@@ -185,7 +185,7 @@
 	andi		a2, STORMASK		/* At most one long to go */
 
 	beqz		a2, 1f
-#ifndef CONFIG_CPU_MIPSR6
+#ifndef CONFIG_CPU_HAS_NO_UNALIGNED_LOAD_STORE
 	 PTR_ADDU	a0, a2			/* What's left */
 	R10KCBARRIER(0(ra))
 #ifdef __MIPSEB__
@@ -229,12 +229,12 @@
 	.hidden __memset
 	.endif
 
-#ifdef CONFIG_CPU_MIPSR6
+#ifdef CONFIG_CPU_HAS_NO_UNALIGNED_LOAD_STORE
 .Lbyte_fixup\@:
 	PTR_SUBU	a2, $0, t0
 	jr		ra
 	 PTR_ADDIU	a2, 1
-#endif /* CONFIG_CPU_MIPSR6 */
+#endif /* CONFIG_CPU_HAS_NO_UNALIGNED_LOAD_STORE */
 
 .Lfirst_fixup\@:
 	jr	ra
-- 
2.19.0
