Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Nov 2013 08:22:31 +0100 (CET)
Received: from mail-pd0-f171.google.com ([209.85.192.171]:62608 "EHLO
        mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817179Ab3KHHW1nJGlA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Nov 2013 08:22:27 +0100
Received: by mail-pd0-f171.google.com with SMTP id w10so1759020pde.2
        for <multiple recipients>; Thu, 07 Nov 2013 23:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=4oLoxF2xrE3PnaN0CKkeU40Ahywspm0/FUVfur8Fmnw=;
        b=VwU3OJFHTuqMgdO52G3R8VDWRx0Q3Rq9CUFOTZ4HBtlktM6Ag7y4PH2GHmrWvPHbyc
         1/HWrCcVxc0LJ8DIolQzgY25HAHoiNAAOV9to4uMkLjPRHCqdvDlxqR3KTcckQ5nhX7A
         lGgd/Qr2B0T4IVbgJdpf8jLzyDZ7w5tHuVEMUvOoN3XgfCCVWQWJFPGV3krlp2+ADqkH
         eqCIC3Sok8NAeUyYLSjZJybqobgBunC+MgPsaPqivjG3AxcbUdqpbLszu400Ey4IfpJf
         PUJ3ZfzRNPFCSqv+9WP5FkxzTyt52qlp2B3pwegNAMn6PYDH5UCotcBfa9dLpm7vXuH8
         dLjA==
X-Received: by 10.66.186.204 with SMTP id fm12mr1304162pac.189.1383895340312;
        Thu, 07 Nov 2013 23:22:20 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id i6sm9967952pbc.1.2013.11.07.23.22.12
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 07 Nov 2013 23:22:19 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [RFC PATCH] MIPS: Fix case mismatch in local_r4k_flush_icache_range()
Date:   Fri,  8 Nov 2013 15:21:53 +0800
Message-Id: <1383895313-6375-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Currently, Loongson-2 call protected_blast_icache_range() and others
call protected_loongson23_blast_icache_range(), but I think the correct
behavior should be the opposite. BTW, Loongson-3's cache-ops is
compatible with MIPS64, but not compatible with Loongson-2. So, rename
xxx_loongson23_yyy things to xxx_loongson2_yyy.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/cacheops.h |    2 +-
 arch/mips/include/asm/r4kcache.h |    8 ++++----
 arch/mips/mm/c-r4k.c             |    4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/cacheops.h b/arch/mips/include/asm/cacheops.h
index c75025f..06b9bc7 100644
--- a/arch/mips/include/asm/cacheops.h
+++ b/arch/mips/include/asm/cacheops.h
@@ -83,6 +83,6 @@
 /*
  * Loongson2-specific cacheops
  */
-#define Hit_Invalidate_I_Loongson23	0x00
+#define Hit_Invalidate_I_Loongson2	0x00
 
 #endif	/* __ASM_CACHEOPS_H */
diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
index 34d1a19..91d20b0 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -165,7 +165,7 @@ static inline void flush_icache_line(unsigned long addr)
 	__iflush_prologue
 	switch (boot_cpu_type()) {
 	case CPU_LOONGSON2:
-		cache_op(Hit_Invalidate_I_Loongson23, addr);
+		cache_op(Hit_Invalidate_I_Loongson2, addr);
 		break;
 
 	default:
@@ -219,7 +219,7 @@ static inline void protected_flush_icache_line(unsigned long addr)
 {
 	switch (boot_cpu_type()) {
 	case CPU_LOONGSON2:
-		protected_cache_op(Hit_Invalidate_I_Loongson23, addr);
+		protected_cache_op(Hit_Invalidate_I_Loongson2, addr);
 		break;
 
 	default:
@@ -452,8 +452,8 @@ static inline void prot##extra##blast_##pfx##cache##_range(unsigned long start,
 __BUILD_BLAST_CACHE_RANGE(d, dcache, Hit_Writeback_Inv_D, protected_, )
 __BUILD_BLAST_CACHE_RANGE(s, scache, Hit_Writeback_Inv_SD, protected_, )
 __BUILD_BLAST_CACHE_RANGE(i, icache, Hit_Invalidate_I, protected_, )
-__BUILD_BLAST_CACHE_RANGE(i, icache, Hit_Invalidate_I_Loongson23, \
-	protected_, loongson23_)
+__BUILD_BLAST_CACHE_RANGE(i, icache, Hit_Invalidate_I_Loongson2, \
+	protected_, loongson2_)
 __BUILD_BLAST_CACHE_RANGE(d, dcache, Hit_Writeback_Inv_D, , )
 __BUILD_BLAST_CACHE_RANGE(s, scache, Hit_Writeback_Inv_SD, , )
 /* blast_inv_dcache_range */
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 62ffd20..73f02da 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -580,11 +580,11 @@ static inline void local_r4k_flush_icache_range(unsigned long start, unsigned lo
 	else {
 		switch (boot_cpu_type()) {
 		case CPU_LOONGSON2:
-			protected_blast_icache_range(start, end);
+			protected_loongson2_blast_icache_range(start, end);
 			break;
 
 		default:
-			protected_loongson23_blast_icache_range(start, end);
+			protected_blast_icache_range(start, end);
 			break;
 		}
 	}
-- 
1.7.7.3
