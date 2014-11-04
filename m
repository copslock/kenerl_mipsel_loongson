Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2014 07:15:03 +0100 (CET)
Received: from mail-pd0-f172.google.com ([209.85.192.172]:33999 "EHLO
        mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010958AbaKDGOKB8X0e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Nov 2014 07:14:10 +0100
Received: by mail-pd0-f172.google.com with SMTP id r10so13019431pdi.17
        for <multiple recipients>; Mon, 03 Nov 2014 22:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xeAYipNZmBAjAdek5n8ECE04fgA8308l+AVSwFUq7R4=;
        b=BnXL8XSeiOhGNfOOHWZuIoyDYI8OfoXp9qy8K0lF2HA6IG0+s1U6hZLU/jpjX/9jg/
         7ftJU7tj3s/Ch2mbLXbcFjWQXVpJkxOO4vjBcJYksTBkEsJO6HVziErWS2n6Ho60K7nh
         8D+7lAIrellkIZwxce7bnQpMgL/v4V19gzsoYm7PWVANpzGABJvqgLLS+5oeroVvPDkk
         I/O+vy0mVIObRimR2QEPsbhTbt+/iGgAnF/CX0eQjdKEvV3K+e5Lfss0v/PkgqmYhrEC
         Exqh2nk1QM/N63IfGoQoSM3eDtnP0mCGbtjREN2kTqsHHENNMZet3oBrnIYZEm+F/Jd9
         zdqg==
X-Received: by 10.70.133.231 with SMTP id pf7mr13817548pdb.111.1415081643576;
        Mon, 03 Nov 2014 22:14:03 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id cs9sm7712498pac.8.2014.11.03.22.13.59
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 03 Nov 2014 22:14:02 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>
Subject: [PATCH V2 04/12] MIPS: Loongson: Introduce and use cpu_has_coherent_cache feature
Date:   Tue,  4 Nov 2014 14:13:25 +0800
Message-Id: <1415081610-25639-5-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1415081610-25639-1-git-send-email-chenhc@lemote.com>
References: <1415081610-25639-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43853
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
---
 arch/mips/Kconfig                                  |    3 +++
 arch/mips/include/asm/cpu-features.h               |    3 +++
 .../asm/mach-loongson/cpu-feature-overrides.h      |    1 +
 arch/mips/mm/c-r4k.c                               |   18 ++++++++++++++++++
 4 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e0b7c20..b3dc152 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1596,6 +1596,7 @@ config CPU_BMIPS5000
 config SYS_HAS_CPU_LOONGSON3
 	bool
 	select CPU_SUPPORTS_CPUFREQ
+	select CPU_SUPPORTS_COHERENT_CACHE
 
 config SYS_HAS_CPU_LOONGSON2E
 	bool
@@ -1759,6 +1760,8 @@ config CPU_SUPPORTS_HUGEPAGES
 	bool
 config CPU_SUPPORTS_UNCACHED_ACCELERATED
 	bool
+config CPU_SUPPORTS_COHERENT_CACHE
+	bool
 config MIPS_PGD_C0_CONTEXT
 	bool
 	default y if 64BIT && CPU_MIPSR2 && !CPU_XLP
diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 3325f3e..0e85d60 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -148,6 +148,9 @@
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
index 6d69332..7efb191 100644
--- a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
@@ -58,5 +58,6 @@
 #define cpu_has_local_ebase	0
 
 #define cpu_has_wsbh		IS_ENABLED(CONFIG_CPU_LOONGSON3)
+#define cpu_has_coherent_cache	IS_ENABLED(CONFIG_CPU_SUPPORTS_COHERENT_CACHE)
 
 #endif /* __ASM_MACH_LOONGSON_CPU_FEATURE_OVERRIDES_H */
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index fbcd867..68b3c3d 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -420,6 +420,9 @@ static void r4k_blast_scache_setup(void)
 
 static inline void local_r4k___flush_cache_all(void * args)
 {
+	if (cpu_has_coherent_cache)
+		return;
+
 	switch (current_cpu_type()) {
 	case CPU_LOONGSON2:
 	case CPU_LOONGSON3:
@@ -480,6 +483,9 @@ static inline void local_r4k_flush_cache_range(void * args)
 	struct vm_area_struct *vma = args;
 	int exec = vma->vm_flags & VM_EXEC;
 
+	if (cpu_has_coherent_cache)
+		return;
+
 	if (!(has_valid_asid(vma->vm_mm)))
 		return;
 
@@ -550,6 +556,9 @@ static inline void local_r4k_flush_cache_page(void *args)
 	pte_t *ptep;
 	void *vaddr;
 
+	if (cpu_has_coherent_cache)
+		return;
+
 	/*
 	 * If ownes no valid ASID yet, cannot possibly have gotten
 	 * this page into the cache.
@@ -625,11 +634,17 @@ static void r4k_flush_cache_page(struct vm_area_struct *vma,
 
 static inline void local_r4k_flush_data_cache_page(void * addr)
 {
+	if (cpu_has_coherent_cache)
+		return;
+
 	r4k_blast_dcache_page((unsigned long) addr);
 }
 
 static void r4k_flush_data_cache_page(unsigned long addr)
 {
+	if (cpu_has_coherent_cache)
+		return;
+
 	if (in_atomic())
 		local_r4k_flush_data_cache_page((void *)addr);
 	else
@@ -783,6 +798,9 @@ static void local_r4k_flush_cache_sigtramp(void * arg)
 	unsigned long sc_lsize = cpu_scache_line_size();
 	unsigned long addr = (unsigned long) arg;
 
+	if (cpu_has_coherent_cache)
+		return;
+
 	R4600_HIT_CACHEOP_WAR_IMPL;
 	if (dc_lsize)
 		protected_writeback_dcache_line(addr & ~(dc_lsize - 1));
-- 
1.7.7.3
