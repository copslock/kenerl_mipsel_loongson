Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Sep 2016 14:35:56 +0200 (CEST)
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35126 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992111AbcILMftkuMw2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Sep 2016 14:35:49 +0200
Received: by mail-pf0-f180.google.com with SMTP id i75so11983602pfa.2
        for <linux-mips@linux-mips.org>; Mon, 12 Sep 2016 05:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=i7P4XGle7oEHWZWzc6cpxm8ibdvnt3kWQ0IWDpPInwk=;
        b=LyyH+ZYbNexBK0UEYuvFgc4tdgCww/pW+I3ytJzvLymewUNGYUVi5wsOGjcmIXZCwb
         jz+LC5zQ4ho3PdhCAkkXsTN6qt4G/uOHhXpwxKhQgF/k3C/6lkfIHlHUq0Lv18QjxEVN
         0orL/ubG763cveScbbV0PrxlexqVSXBsI3Tk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i7P4XGle7oEHWZWzc6cpxm8ibdvnt3kWQ0IWDpPInwk=;
        b=cSqMBWQtDZpNeMorcap9zFObIhf2hYIScKQDiA+Y8LUsEXESWX8Pxex1OxvvwIxG9g
         47UqIR0Jh5ZpAKrVsXLmi8W2EdjSoCJFElvMlnvAd78MONYczApCz1O6WiFxk2qpOF5+
         YbaEcTgqUEDKQLGoRZac3wIudU3tvGCJVbhoEG5vOTZOtGIN4tC9JpDP+0W2tLmqZwfy
         KrgVm/rPbXeLAgcnmbIqvdvHO9+VR8M9Q5RhUqtvGsbN3r7W2aKtdAxxP8IE0Tj4RBxJ
         riaGcrkReYGG5Me45boNF1cnRi41aDhpMT/1AaxlU0Dz5HcweRQyYdezr4buYKlRq9eh
         xCxg==
X-Gm-Message-State: AE9vXwPjsBKxyfqmVs49m9FbxoKTpKUUcQ3gfNkQ/MPDcAYvqC7THt6RCLnujfVxb9mptqKJ
X-Received: by 10.98.22.212 with SMTP id 203mr33174598pfw.74.1473683742285;
        Mon, 12 Sep 2016 05:35:42 -0700 (PDT)
Received: from localhost.localdomain ([45.56.152.29])
        by smtp.gmail.com with ESMTPSA id u1sm22496013pfb.62.2016.09.12.05.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Sep 2016 05:35:41 -0700 (PDT)
From:   Baoyou Xie <baoyou.xie@linaro.org>
To:     ralf@linux-mips.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, paul.burton@imgtec.com,
        chenhc@lemote.com, david.daney@cavium.com, kumba@gentoo.org,
        yamada.masahiro@socionext.com, kirill.shutemov@linux.intel.com,
        dave.hansen@linux.intel.com, toshi.kani@hpe.com, JBeulich@suse.com,
        dan.j.williams@intel.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, baoyou.xie@linaro.org,
        xie.baoyou@zte.com.cn
Subject: [PATCH] mm: move phys_mem_access_prot_allowed() declaration to pgtable.h
Date:   Mon, 12 Sep 2016 20:35:03 +0800
Message-Id: <1473683703-15727-1-git-send-email-baoyou.xie@linaro.org>
X-Mailer: git-send-email 2.7.4
Return-Path: <baoyou.xie@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55103
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
index d4458b6..ad625dd 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -814,4 +814,7 @@ static inline int pmd_clear_huge(pmd_t *pmd)
 #endif
 #endif
 
+struct file;
+int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
+			unsigned long size, pgprot_t *vma_prot);
 #endif /* _ASM_GENERIC_PGTABLE_H */
-- 
2.7.4
