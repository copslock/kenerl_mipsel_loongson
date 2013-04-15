Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Apr 2013 14:48:29 +0200 (CEST)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:36489 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6832298Ab3DOMrndCPkn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Apr 2013 14:47:43 +0200
Received: by mail-pd0-f180.google.com with SMTP id q11so2487789pdj.11
        for <multiple recipients>; Mon, 15 Apr 2013 05:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=CtFNkZEO8d0pHNlvSL2VnhgxzHVr2RL29nFf7d+v6Hk=;
        b=dC8gpsNuHg8Ra7Jf1xx548fheMRxmVAw+YX39qHZCMEuq+6K2HfPM/qBMlgW8XYdo7
         KCA4PlOoMVkYtGYdGBs+yC9SIkqhNksjDBEWxuz6L8zSYZJRgEzeOckeS29PY7iDWMVE
         JcYWsUtKB1V0FIAqSIuAUwbGrR6Q6BYZVUmjcFKn6mAu5pw9rAyZcTQ3HYp/FfwRBuio
         GPZu62j9eBZ+zGCaSORiT0oCvCuvgKMPqGZGKgV8AL4RG4VhgIsash2qFb3z+o4P18u4
         0zTu+WKbm9BTwC/cxNx1oMjG56wvwIxcV5jy8xRxIkbZXFL6lSivcYUCEcKtOdkQebFl
         PhBw==
X-Received: by 10.66.246.168 with SMTP id xx8mr29312543pac.107.1366030055254;
        Mon, 15 Apr 2013 05:47:35 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id xz4sm20242580pbb.18.2013.04.15.05.47.31
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 05:47:34 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V10 03/13] MIPS: Loongson: Introduce and use cpu_has_coherent_cache feature
Date:   Mon, 15 Apr 2013 20:46:58 +0800
Message-Id: <1366030028-5084-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1366030028-5084-1-git-send-email-chenhc@lemote.com>
References: <1366030028-5084-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36184
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
index e5ec8fc..18b4db0 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -113,6 +113,9 @@
 #ifndef cpu_has_pindexed_dcache
 #define cpu_has_pindexed_dcache (cpu_data[0].dcache.flags & MIPS_CACHE_PINDEX)
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
index cab2aa2..edecf1c 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -341,7 +341,10 @@ static void __cpuinit r4k_blast_scache_setup(void)
 
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
@@ -395,6 +398,9 @@ static inline void local_r4k_flush_cache_range(void * args)
 	struct vm_area_struct *vma = args;
 	int exec = vma->vm_flags & VM_EXEC;
 
+	if (cpu_has_coherent_cache && !cpu_has_dc_aliases)
+		return;
+
 	if (!(has_valid_asid(vma->vm_mm)))
 		return;
 
@@ -465,6 +471,9 @@ static inline void local_r4k_flush_cache_page(void *args)
 	pte_t *ptep;
 	void *vaddr;
 
+	if (cpu_has_coherent_cache && !cpu_has_dc_aliases)
+		return;
+
 	/*
 	 * If ownes no valid ASID yet, cannot possibly have gotten
 	 * this page into the cache.
@@ -538,6 +547,9 @@ static void r4k_flush_cache_page(struct vm_area_struct *vma,
 
 static inline void local_r4k_flush_data_cache_page(void * addr)
 {
+	if (cpu_has_coherent_cache && !cpu_has_dc_aliases)
+		return;
+
 	r4k_blast_dcache_page((unsigned long) addr);
 }
 
@@ -670,6 +682,9 @@ static void local_r4k_flush_cache_sigtramp(void * arg)
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
