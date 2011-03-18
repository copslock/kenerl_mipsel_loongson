Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Mar 2011 21:01:18 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:63102 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490969Ab1CRUBP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Mar 2011 21:01:15 +0100
Received: by wwb17 with SMTP id 17so4697067wwb.24
        for <multiple recipients>; Fri, 18 Mar 2011 13:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=w9lHNrWmCC1laaknSwdVXS70Ya9ovV1yLagAqXYvzNc=;
        b=Rz9kz8zPAJq2wp1sqH0dPwj5VxLy/KhmYaFYAuLbGzEV6qiR0Rx6Vo6xTGvGDrHDaT
         5m71MNtvTwNMH9uti5F3/PkDiFwfdvw2YzsRkx5Jzc1BfdmUE4PcgaQu0m9Hr/ClrPeT
         JGEJhjooGHadfpK7I3ps/v4dO2boFMmpce0E0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZNLKMOStu2D/3hmO6uiTKokKiv3HJRA+Wh0zfmScYLIASjujYAy+muxhqhgUeUVkUS
         vpaAuxgZxZeb2SLp5Q8qz+StsJbZWhFLRbhPXJ/e+3YFYgm8hEVEnTL/SDANLAkst1og
         xHsKqhgURrhwcMJpK9d8s/Gea0DODAbDGhlTs=
Received: by 10.217.3.69 with SMTP id q47mr1744408wes.15.1300478470095;
        Fri, 18 Mar 2011 13:01:10 -0700 (PDT)
Received: from prasad-kvm (pineapple.rdg.ac.uk [134.225.206.123])
        by mx.google.com with ESMTPS id l5sm1712013wej.8.2011.03.18.13.01.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2011 13:01:09 -0700 (PDT)
Date:   Fri, 18 Mar 2011 20:01:50 +0000
From:   Prasad Joshi <prasadjoshi124@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, prasadjoshi124@gmail.com,
        mitra@kqinfotech.com
Subject: Re: [RFC][PATCH v3 13/22] mm, mips: add gfp flags variant of pmd
 and pte allocations
Message-ID: <20110318200150.GN4746@prasad-kvm>
References: <20110318194740.GD4746@prasad-kvm>
 <20110318194929.GE4746@prasad-kvm>
 <20110318195035.GF4746@prasad-kvm>
 <20110318195141.GG4746@prasad-kvm>
 <20110318195307.GH4746@prasad-kvm>
 <20110318195507.GI4746@prasad-kvm>
 <20110318195643.GJ4746@prasad-kvm>
 <20110318195754.GK4746@prasad-kvm>
 <20110318195926.GL4746@prasad-kvm>
 <20110318200045.GM4746@prasad-kvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110318200045.GM4746@prasad-kvm>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <prasadjoshi124@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasadjoshi124@gmail.com
Precedence: bulk
X-list: linux-mips


- Added __pmd_alloc_one to allocate pages using the given allocation flag.

- Changed pmd_alloc_one to call __pmd_alloc_one and pass
  GFP_KERNEL | __GFP_REPEAT allocation flag.

- Added __pte_alloc_one_kernel to allocate zeroed pages using the given
  allocation flag. The function pte_alloc_one_kernel() has been changed to
  call __pte_alloc_one_kernel() passing GFP_KERNEL | __GFP_REPEAT
  allocation flags.

- Helps in fixing the Bug 30702

Signed-off-by: Prasad Joshi <prasadjoshi124@gmail.com>
Signed-off-by: Anand Mitra <mitra@kqinfotech.com>
---
 arch/mips/include/asm/pgalloc.h |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index 881d18b..f2c5439 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -64,14 +64,16 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 	free_pages((unsigned long)pgd, PGD_ORDER);
 }
 
+static inline pte_t *__pte_alloc_one_kernel(struct mm_struct *mm,
+	unsigned long address, gfp_t gfp_mask)
+{
+	return (pte_t *) __get_free_pages(gfp_mask | __GFP_ZERO, PTE_ORDER);
+}
+
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 	unsigned long address)
 {
-	pte_t *pte;
-
-	pte = (pte_t *) __get_free_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, PTE_ORDER);
-
-	return pte;
+	return __pte_alloc_one_kernel(mm, address, GFP_KERNEL | __GFP_REPEAT);
 }
 
 static inline struct page *pte_alloc_one(struct mm_struct *mm,
@@ -106,16 +108,22 @@ do {							\
 
 #ifndef __PAGETABLE_PMD_FOLDED
 
-static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
+static inline pmd_t *
+__pmd_alloc_one(struct mm_struct *mm, unsigned long address, gfp_t gfp_mask)
 {
 	pmd_t *pmd;
 
-	pmd = (pmd_t *) __get_free_pages(GFP_KERNEL|__GFP_REPEAT, PMD_ORDER);
+	pmd = (pmd_t *) __get_free_pages(gfp_mask, PMD_ORDER);
 	if (pmd)
 		pmd_init((unsigned long)pmd, (unsigned long)invalid_pte_table);
 	return pmd;
 }
 
+static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
+{
+	return __pmd_alloc_one(mm, address, GFP_KERNEL | __GFP_REPEAT);
+}
+
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 {
 	free_pages((unsigned long)pmd, PMD_ORDER);
-- 
1.7.0.4
