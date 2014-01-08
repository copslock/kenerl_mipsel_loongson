Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jan 2014 23:12:24 +0100 (CET)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:59291 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6870568AbaAHWMDeBAqp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Jan 2014 23:12:03 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id 5133C19C123;
        Thu,  9 Jan 2014 00:12:01 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id SQYHxWHGcbp2; Thu,  9 Jan 2014 00:11:56 +0200 (EET)
Received: from blackmetal.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with ESMTP id 2D3005BC003;
        Thu,  9 Jan 2014 00:11:56 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Huacai Chen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 1/2] MIPS: Fix case mismatch in local_r4k_flush_icache_range()
Date:   Thu,  9 Jan 2014 00:11:18 +0200
Message-Id: <1389219079-6133-2-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1389219079-6133-1-git-send-email-aaro.koskinen@iki.fi>
References: <1389219079-6133-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

From: Huacai Chen <chenhc@lemote.com>

Currently, Loongson-2 call protected_blast_icache_range() and others
call protected_loongson23_blast_icache_range(), but I think the
correct behavior should be the opposite. BTW, Loongson-3's cache-ops is
compatible with MIPS64, but not compatible with Loongson-2. So, rename
xxx_loongson23_yyy things to xxx_loongson2_yyy.

The patch fixes early boot hang with 3.13-rc1, introduced in the commit
14bd8c082016cd1f67fdfd702e4cf6367869a712 (MIPS: Loongson: Get rid of
Loongson 2 #ifdefery all over arch/mips.).

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Acked-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/cacheops.h | 2 +-
 arch/mips/include/asm/r4kcache.h | 8 ++++----
 arch/mips/mm/c-r4k.c             | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/cacheops.h b/arch/mips/include/asm/cacheops.h
index c75025f27c20..06b9bc7ea14b 100644
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
index 34d1a1917125..91d20b08246f 100644
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
index 62ffd20ea869..73f02da61baf 100644
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
1.8.5.2
