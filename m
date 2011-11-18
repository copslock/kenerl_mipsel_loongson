Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 22:30:28 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:48219 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904136Ab1KRVaV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2011 22:30:21 +0100
Received: by iapp10 with SMTP id p10so5653068iap.36
        for <multiple recipients>; Fri, 18 Nov 2011 13:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=98kw5Xc0De8HrbqOnUFmJImoIHzm5Qhg45JqcpipWBs=;
        b=gFL/+bEfjHP3KVl3Fc2uHARkczHEbBjcA2WYbg+Pr2+fVISBumX8Von2qs3fMISmSN
         Fdqt04kMN7pGfN1AVhaxV9I+oVJQyZ4HEYerR9YqWMdD43PEyUwL5s6Z3Rkc1INqPKao
         kRTEWBmgf2lOiNgR2Baq5bfX2+zAZAt3lvUoE=
Received: by 10.42.161.132 with SMTP id t4mr4378866icx.16.1321651814783;
        Fri, 18 Nov 2011 13:30:14 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id z10sm7430270ibv.9.2011.11.18.13.30.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Nov 2011 13:30:13 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAILUBQo023427;
        Fri, 18 Nov 2011 13:30:11 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAILUAvI023426;
        Fri, 18 Nov 2011 13:30:10 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Get rid of some #ifdefery in arch/mips/mm/tlb-r4k.c
Date:   Fri, 18 Nov 2011 13:30:09 -0800
Message-Id: <1321651809-23395-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 31814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15944

From: David Daney <david.daney@cavium.com>

In the case of !CONFIG_HUGETLB_PAGE, in linux/hugetlb.h we have this
definition:

The other huge page constants in the if(pmd_huge()) block are likewise
defined, so we can get rid of the #ifdef CONFIG_HUGETLB_PAGE an let
the compiler optimize this block away instead.  Doing this the code
has a much cleaner appearance.

Signed-off-by: David Daney <david.daney@cavium.com>
---
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
