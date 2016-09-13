Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Sep 2016 09:27:12 +0200 (CEST)
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36760 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992247AbcIMH1Flobgt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Sep 2016 09:27:05 +0200
Received: by mail-pf0-f181.google.com with SMTP id 128so60865678pfb.3
        for <linux-mips@linux-mips.org>; Tue, 13 Sep 2016 00:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Aah0aNhPrpVwCnVObnhcNE1aF9zD/iYpAvEAL8r3S5A=;
        b=IgAQL/LqAOwjZrqr2hfayXN3+bkZI5wHnkGJgcMrDvG5XMZ21krcGT/8Zgsrr7UCiJ
         c+JY6Pk0H9J9pnt7Aw4qQ+CnIQahPtK/1VDDIkCiJfYl+l/pHc1FyZz8J18wmG9d4pYH
         g7ELcKnfUg2ZQ0SxnJWGOw5MO0ixJS4w/JV4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Aah0aNhPrpVwCnVObnhcNE1aF9zD/iYpAvEAL8r3S5A=;
        b=kisvfDbeJxDWG60IJ7y4QZN6aHvNT434MtDvOYfgSB2mifwvFDG5t2pStMus2NkewM
         MGkvXpiR8dJE+mMb3WQwnT087pTwMxZGqYx9DL/yYqB19YAhDXbhN4qOeQC2RpGM61Gg
         7lTsfU6z527ZQIVPAe/XS0AZbpC4tvUwyjwHjv+ZMEGdojqpooJkfbcH4lWDwRBIc9Q8
         FKmxtz3mXZwuIdPZpPgOecv+E9fdblESNKzEIPJJDGNhdw8A301UEQMXXXY+yE9J3VNN
         TaM1in1GLM3gAHIfoEej3dygIAlXIoRJIOXtimvbDPFzf60bu3Lo4EXVPLGpPQcBpwhB
         UnBg==
X-Gm-Message-State: AE9vXwM92FMnhqysRmHdXC2Nx7ePHD95QxzavFAG5YFYjYL6+gMb3w4m8zclv0v44gt6cDC+
X-Received: by 10.98.58.195 with SMTP id v64mr38370373pfj.97.1473751619827;
        Tue, 13 Sep 2016 00:26:59 -0700 (PDT)
Received: from localhost.localdomain ([45.56.152.36])
        by smtp.gmail.com with ESMTPSA id y2sm28995330pan.31.2016.09.13.00.26.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Sep 2016 00:26:59 -0700 (PDT)
From:   Baoyou Xie <baoyou.xie@linaro.org>
To:     ralf@linux-mips.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, paul.burton@imgtec.com,
        chenhc@lemote.com, david.daney@cavium.com, kumba@gentoo.org,
        yamada.masahiro@socionext.com, kirill.shutemov@linux.intel.com,
        dave.hansen@linux.intel.com, toshi.kani@hpe.com,
        dan.j.williams@intel.com, luto@kernel.org, JBeulich@suse.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, baoyou.xie@linaro.org,
        xie.baoyou@zte.com.cn
Subject: [PATCH v2] mm: move phys_mem_access_prot_allowed() declaration to pgtable.h
Date:   Tue, 13 Sep 2016 15:26:37 +0800
Message-Id: <1473751597-12139-1-git-send-email-baoyou.xie@linaro.org>
X-Mailer: git-send-email 2.7.4
Return-Path: <baoyou.xie@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baoyou.xie@linaro.org
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

We get 1 warning when building kernel with W=1:
drivers/char/mem.c:220:12: warning: no previous prototype for 'phys_mem_access_prot_allowed' [-Wmissing-prototypes]
 int __weak phys_mem_access_prot_allowed(struct file *file,

In fact, its declaration is spreading to several header files
in different architecture, but need to be declare in common
header file.

So this patch moves phys_mem_access_prot_allowed() to pgtable.h.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 arch/mips/include/asm/pgtable.h      | 2 --
 arch/x86/include/asm/pgtable_types.h | 2 --
 include/asm-generic/pgtable.h        | 3 +++
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 70128d3..9e9e944 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -673,8 +673,6 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 struct file;
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 		unsigned long size, pgprot_t vma_prot);
-int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
-		unsigned long size, pgprot_t *vma_prot);
 #endif
 
 /*
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index f1218f5..8b4de22 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -439,8 +439,6 @@ extern pgprot_t pgprot_writethrough(pgprot_t prot);
 struct file;
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
                               unsigned long size, pgprot_t vma_prot);
-int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
-                              unsigned long size, pgprot_t *vma_prot);
 
 /* Install a pte for a particular vaddr in kernel space. */
 void set_pte_vaddr(unsigned long vaddr, pte_t pte);
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index d4458b6..c4f8fd2 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -800,6 +800,9 @@ static inline int pmd_clear_huge(pmd_t *pmd)
 #endif
 #endif
 
+struct file;
+int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
+			unsigned long size, pgprot_t *vma_prot);
 #endif /* !__ASSEMBLY__ */
 
 #ifndef io_remap_pfn_range
-- 
2.7.4
