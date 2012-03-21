Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2012 07:57:24 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:65200 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903609Ab2CUG5K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2012 07:57:10 +0100
Received: by bkcjk13 with SMTP id jk13so830554bkc.36
        for <multiple recipients>; Tue, 20 Mar 2012 23:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=z3EAZZR5A4YKqn52+p/sy8ERgiu2SfjKsuXn7KyuHEE=;
        b=KfCFI/BOJBJuQMwaYKHP0u4npyuuMLqv2erozPusHtBW9+jcVjM5hOAvpzFCRzydW7
         q/pXVLfvZTB1VvEyIx0XDaGeRcx0H/i8f6jgKoqEwPK7v8vNJ2P1KqyQ3lzqqIFIlP4g
         jtizXZ6HMoc8eWsMn1lKVF+KVIVUSaCzY2VwrwLnpcF2RzI2IQVdlIq7dK5elPp7dsns
         beqpzy/HUZBXWpaiXf0jn6pKyZLxd5IPAV8UNES7gsgTJexn32RwpitkPCDGrVWg41zr
         jfmT6Al+zqoUGsXu91skjzKmpk7gL2kpeyI6eSTGYdQzvP+mdmhXzvt0BubZSmpkn+RJ
         TLHQ==
Received: by 10.204.150.78 with SMTP id x14mr1012375bkv.114.1332313024885;
        Tue, 20 Mar 2012 23:57:04 -0700 (PDT)
Received: from localhost (95-25-247-196.broadband.corbina.ru. [95.25.247.196])
        by mx.google.com with ESMTPS id o7sm1377701bkw.16.2012.03.20.23.57.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Mar 2012 23:57:04 -0700 (PDT)
Subject: [PATCH 12/16] mm/mips: use vm_flags_t for vma flags
To:     Andrew Morton <akpm@linux-foundation.org>
From:   Konstantin Khlebnikov <khlebnikov@openvz.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Date:   Wed, 21 Mar 2012 10:57:02 +0400
Message-ID: <20120321065702.13852.81639.stgit@zurg>
In-Reply-To: <20120321065140.13852.52315.stgit@zurg>
References: <20120321065140.13852.52315.stgit@zurg>
User-Agent: StGit/0.15
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-archive-position: 32733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khlebnikov@openvz.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Konstantin Khlebnikov <khlebnikov@openvz.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/mm/c-r3k.c  |    2 +-
 arch/mips/mm/c-r4k.c  |    6 +++---
 arch/mips/mm/c-tx39.c |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/mm/c-r3k.c b/arch/mips/mm/c-r3k.c
index 0765583..0ae0684 100644
--- a/arch/mips/mm/c-r3k.c
+++ b/arch/mips/mm/c-r3k.c
@@ -239,7 +239,7 @@ static void r3k_flush_cache_page(struct vm_area_struct *vma,
 				 unsigned long addr, unsigned long pfn)
 {
 	unsigned long kaddr = KSEG0ADDR(pfn << PAGE_SHIFT);
-	int exec = vma->vm_flags & VM_EXEC;
+	int exec = (vma->vm_flags & VM_EXEC) != VM_NONE;
 	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgdp;
 	pud_t *pudp;
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index c97087d..94b2b89 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -394,7 +394,7 @@ static void r4k__flush_cache_vunmap(void)
 static inline void local_r4k_flush_cache_range(void * args)
 {
 	struct vm_area_struct *vma = args;
-	int exec = vma->vm_flags & VM_EXEC;
+	int exec = (vma->vm_flags & VM_EXEC) != VM_NONE;
 
 	if (!(has_valid_asid(vma->vm_mm)))
 		return;
@@ -407,7 +407,7 @@ static inline void local_r4k_flush_cache_range(void * args)
 static void r4k_flush_cache_range(struct vm_area_struct *vma,
 	unsigned long start, unsigned long end)
 {
-	int exec = vma->vm_flags & VM_EXEC;
+	int exec = (vma->vm_flags & VM_EXEC) != VM_NONE;
 
 	if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc))
 		r4k_on_each_cpu(local_r4k_flush_cache_range, vma);
@@ -457,7 +457,7 @@ static inline void local_r4k_flush_cache_page(void *args)
 	struct vm_area_struct *vma = fcp_args->vma;
 	unsigned long addr = fcp_args->addr;
 	struct page *page = pfn_to_page(fcp_args->pfn);
-	int exec = vma->vm_flags & VM_EXEC;
+	int exec = (vma->vm_flags & VM_EXEC) != VM_NONE;
 	struct mm_struct *mm = vma->vm_mm;
 	int map_coherent = 0;
 	pgd_t *pgdp;
diff --git a/arch/mips/mm/c-tx39.c b/arch/mips/mm/c-tx39.c
index a43c197c..1227670 100644
--- a/arch/mips/mm/c-tx39.c
+++ b/arch/mips/mm/c-tx39.c
@@ -169,7 +169,7 @@ static void tx39_flush_cache_range(struct vm_area_struct *vma,
 
 static void tx39_flush_cache_page(struct vm_area_struct *vma, unsigned long page, unsigned long pfn)
 {
-	int exec = vma->vm_flags & VM_EXEC;
+	int exec = (vma->vm_flags & VM_EXEC) != VM_NONE;
 	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgdp;
 	pud_t *pudp;
