Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jul 2013 09:36:36 +0200 (CEST)
Received: from mail-pb0-f51.google.com ([209.85.160.51]:60968 "EHLO
        mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822995Ab3GWHfY0YfCe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Jul 2013 09:35:24 +0200
Received: by mail-pb0-f51.google.com with SMTP id um15so8109162pbc.10
        for <multiple recipients>; Tue, 23 Jul 2013 00:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=KsP1B5UKB/i0UVuGIoXMenj82g8qUm2pL3JNdxnMZNU=;
        b=SDKp5vuDrHfD2MDpaB88oAz9QvBbiTCEHE0T7CQp0U2pUliIHUMyKobO1T44WP5XYT
         a61yJyhqDCU9GuTJZqX2pIeU3lwtcX5DlMffEgaNwkuJuLd5dxIS7i+uFWoXKYLrEpAd
         1jrceuU4gS5aFVMQabvJXpc5Y0bRuTIrV7E12zg/xLLuTo4lHPBrrsUmBHHiHMpZc/fL
         SNHox57irKfmrO7yQizE4cqeY95LYySmvxadMumMzicTIQqM8Mc+o75uaUHoHBf4z8db
         EKN6xztEzIiAN1wrV0272quUnG3MOsO2a5HSCs/cdayLkzTUea9D6Hd829gIDFQ/xPp3
         2DWA==
X-Received: by 10.68.171.194 with SMTP id aw2mr35049381pbc.197.1374564917898;
        Tue, 23 Jul 2013 00:35:17 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id bb1sm30359772pbc.10.2013.07.23.00.35.12
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jul 2013 00:35:16 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V11 03/13] MIPS: Loongson: Introduce and use cpu_has_coherent_cache feature
Date:   Tue, 23 Jul 2013 15:34:03 +0800
Message-Id: <1374564853-10762-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1374564853-10762-1-git-send-email-chenhc@lemote.com>
References: <1374564853-10762-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37351
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

Loongson-3 maintains cache coherency by hardware. So we introduce a cpu
feature named cpu_has_coherent_cache and use it to modify MIPS's cache
flushing functions.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
---
 arch/mips/include/asm/cpu-features.h               |    3 +++
 .../asm/mach-loongson/cpu-feature-overrides.h      |    6 ++++++
 arch/mips/mm/c-r4k.c                               |   17 ++++++++++++++++-
 3 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 1dc0860..75f3577 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -127,6 +127,9 @@
 #ifndef cpu_has_pindexed_dcache
 #define cpu_has_pindexed_dcache	(cpu_data[0].dcache.flags & MIPS_CACHE_PINDEX)
 #endif
+#ifndef cpu_has_coherent_cache
+#define cpu_has_coherent_cache	0
+#endif
 #ifndef cpu_has_local_ebase
 #define cpu_has_local_ebase	1
 #endif
diff --git a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
index c0f3ef4..1b03d31 100644
--- a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
@@ -58,5 +58,11 @@
 #define cpu_has_vtag_icache	0
 #define cpu_has_watch		1
 #define cpu_has_local_ebase	0
+#ifdef CONFIG_CPU_SUPPORTS_COHERENT_CACHE
+#define cpu_has_coherent_cache	1
+#else
+#define cpu_has_coherent_cache	0
+#endif
+
 
 #endif /* __ASM_MACH_LOONGSON_CPU_FEATURE_OVERRIDES_H */
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 10d1846..8a972e8 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -344,7 +344,10 @@ static void __cpuinit r4k_blast_scache_setup(void)
 
 static inline void local_r4k___flush_cache_all(void * args)
 {
-#if defined(CONFIG_CPU_LOONGSON2)
+	if (cpu_has_coherent_cache && !cpu_has_dc_aliases)
+		return;
+
+#if defined(CONFIG_CPU_LOONGSON2) || defined(CONFIG_CPU_LOONGSON3)
 	r4k_blast_scache();
 	return;
 #endif
@@ -398,6 +401,9 @@ static inline void local_r4k_flush_cache_range(void * args)
 	struct vm_area_struct *vma = args;
 	int exec = vma->vm_flags & VM_EXEC;
 
+	if (cpu_has_coherent_cache && !cpu_has_dc_aliases)
+		return;
+
 	if (!(has_valid_asid(vma->vm_mm)))
 		return;
 
@@ -468,6 +474,9 @@ static inline void local_r4k_flush_cache_page(void *args)
 	pte_t *ptep;
 	void *vaddr;
 
+	if (cpu_has_coherent_cache && !cpu_has_dc_aliases)
+		return;
+
 	/*
 	 * If ownes no valid ASID yet, cannot possibly have gotten
 	 * this page into the cache.
@@ -541,6 +550,9 @@ static void r4k_flush_cache_page(struct vm_area_struct *vma,
 
 static inline void local_r4k_flush_data_cache_page(void * addr)
 {
+	if (cpu_has_coherent_cache && !cpu_has_dc_aliases)
+		return;
+
 	r4k_blast_dcache_page((unsigned long) addr);
 }
 
@@ -673,6 +685,9 @@ static void local_r4k_flush_cache_sigtramp(void * arg)
 	unsigned long sc_lsize = cpu_scache_line_size();
 	unsigned long addr = (unsigned long) arg;
 
+	if (cpu_has_coherent_cache && !cpu_has_dc_aliases)
+		return;
+
 	R4600_HIT_CACHEOP_WAR_IMPL;
 	if (dc_lsize)
 		protected_writeback_dcache_line(addr & ~(dc_lsize - 1));
-- 
1.7.7.3
