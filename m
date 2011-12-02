Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Dec 2011 19:02:23 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:44844 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903832Ab1LBSCT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Dec 2011 19:02:19 +0100
Received: by ghrr19 with SMTP id r19so3683758ghr.36
        for <multiple recipients>; Fri, 02 Dec 2011 10:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=qCLRXIDErTwNw8e0bYWQCQFmdnBCblhb8KevHAQXRU4=;
        b=jXFsk5xRK1oHEW4gwjJLgSNcZl+PmIE9yFwXxLpdF4YzBfWd9HtRrU0ksZ2Aermeec
         l1CeKqqkCELSqKsfThdE0HzOQnZXWrvsFnvN2F95abG3fUOZ+S1fPqHiu8suCVLndUw9
         6H+6rfe7kFtfOsg3zNCjBe3XrqykDoZIbNGOw=
Received: by 10.101.158.28 with SMTP id k28mr3225160ano.7.1322848932766;
        Fri, 02 Dec 2011 10:02:12 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id n64sm16772721yhk.4.2011.12.02.10.02.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Dec 2011 10:02:12 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pB2I29hC016154;
        Fri, 2 Dec 2011 10:02:09 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pB2I29vc016153;
        Fri, 2 Dec 2011 10:02:09 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH resend] MIPS: Get rid of some #ifdefery in arch/mips/mm/tlb-r4k.c
Date:   Fri,  2 Dec 2011 10:02:07 -0800
Message-Id: <1322848927-16122-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 32018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1749

From: David Daney <david.daney@cavium.com>

In the case of !CONFIG_HUGETLB_PAGE, in linux/hugetlb.h we have this
definition:

 #define pmd_huge(x)	0

The other huge page constants in the if(pmd_huge()) block are likewise
defined, so we can get rid of the #ifdef CONFIG_HUGETLB_PAGE an let
the compiler optimize this block away instead.  Doing this the code
has a much cleaner appearance.

Signed-off-by: David Daney <david.daney@cavium.com>
---

The first attempt as sending the patch resulted in a corrupt change
log, no change other than correcting the log.

 arch/mips/mm/tlb-r4k.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 88dc49c..f93af98 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -305,7 +305,7 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 	pudp = pud_offset(pgdp, address);
 	pmdp = pmd_offset(pudp, address);
 	idx = read_c0_index();
-#ifdef CONFIG_HUGETLB_PAGE
+
 	/* this could be a huge page  */
 	if (pmd_huge(*pmdp)) {
 		unsigned long lo;
@@ -321,9 +321,7 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 		else
 			tlb_write_indexed();
 		write_c0_pagemask(PM_DEFAULT_MASK);
-	} else
-#endif
-	{
+	} else {
 		ptep = pte_offset_map(pmdp, address);
 
 #if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
-- 
1.7.2.3
