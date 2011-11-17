Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 05:56:17 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:52111 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903662Ab1KQE4M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Nov 2011 05:56:12 +0100
Received: by yenr8 with SMTP id r8so113466yen.36
        for <linux-mips@linux-mips.org>; Wed, 16 Nov 2011 20:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=+ZfkW5EVc7G9XPbqaMbcdQcaNtIPdjxsHAIhyVRRG38=;
        b=bm9SeR2adbgwPXShR6AuB+ffgkAEDPMBbvI7QyYidEREWL170cD/pzDhXliQDfgDQc
         RblMt1oaxR/a+Sa2Y9Fw==
Received: by 10.236.173.233 with SMTP id v69mr6448100yhl.46.1321505766560;
        Wed, 16 Nov 2011 20:56:06 -0800 (PST)
Received: by 10.236.173.233 with SMTP id v69mr6448067yhl.46.1321505766431;
        Wed, 16 Nov 2011 20:56:06 -0800 (PST)
Received: from [2620:0:1008:1201:be30:5bff:fed8:5e64] ([2620:0:1008:1201:be30:5bff:fed8:5e64])
        by mx.google.com with ESMTPS id i31sm70687453anm.19.2011.11.16.20.56.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 20:56:05 -0800 (PST)
Date:   Wed, 16 Nov 2011 20:56:03 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     David Daney <ddaney.cavm@gmail.com>
cc:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] hugetlb: Provide a default HPAGE_SHIFT if
 !CONFIG_HUGETLB_PAGE
In-Reply-To: <4EC45CAE.1000704@gmail.com>
Message-ID: <alpine.DEB.2.00.1111162047170.13603@chino.kir.corp.google.com>
References: <1321472611-13283-1-git-send-email-ddaney.cavm@gmail.com> <alpine.DEB.2.00.1111161327180.16596@chino.kir.corp.google.com> <4EC43488.3070400@gmail.com> <alpine.DEB.2.00.1111161512371.16596@chino.kir.corp.google.com> <4EC44AD0.5070800@gmail.com>
 <alpine.DEB.2.00.1111161552450.25089@chino.kir.corp.google.com> <4EC45CAE.1000704@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 31713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rientjes@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14151

On Wed, 16 Nov 2011, David Daney wrote:

> > > It is a well established kernel idiom to supply dummy values for symbols
> > > that
> > > are required to be defined in order to form a syntactically correct C
> > > program,
> > > but that are known by the programmer to be used only on dead code paths.
> > > 
> > > This is exactly what we are doing here.
> > > 
> > > To do otherwise requires that code be cluttered with #ifdefery.
> > > 
> > 
> > You're wrong,
> 
> Ok, then please tell me why:
> 
> 1) the dummy version of is_vm_hugetlb_page() exists in hugetlb_inline.h?
> 2) the dummy version of PageHuge() exists in hugetlb.h
> 3) the dummy version of reset_vma_resv_huge_pages()
> 4) the dummy version of hugetlb_total_pages() exists in hugetlb.h
> 5) the dummy version of follow_hugetlb_page() exists in hugetlb.h
> 6) the dummy version of follow_huge_addr() exists in hugetlb.h
> 7) the dummy version of copy_hugetlb_page_range() exists in hugetlb.h
> 8) the dummy version of hugetlb_prefault() exists in hugetlb.h
> 9) the dummy version of unmap_hugepage_range() exists in hugetlb.h
> 10) the dummy version of hugetlb_report_meminfo() exists in hugetlb.h
> 11) the dummy version of hugetlb_report_node_meminfo() exists in hugetlb.h
> 12) the dummy version of follow_huge_pmd() exists in hugetlb.h
> 13) the dummy version of follow_huge_pud() exists in hugetlb.h
> 14) the dummy version of prepare_hugepage_range() exists in hugetlb.h
> 15) the dummy version of pmd_huge() exists in hugetlb.h
> 16) the dummy version of pud_huge() exists in hugetlb.h
> 17) the dummy version of is_hugepage_only_range() exists in hugetlb.h
> 17) the dummy version of hugetlb_free_pgd_range() exists in hugetlb.h
> 18) the dummy version of hugetlb_fault() exists in hugetlb.h
> 19) the dummy version of huge_pte_offset() exists in hugetlb.h
> 20) the dummy version of dequeue_hwpoisoned_huge_page() exists in hugetlb.h
> 21) the dummy version of copy_huge_page() exists in hugetlb.h
> 22) the dummy version of hugetlb_change_protection() exists in hugetlb.h
> .
> .
> .
> [Other non HUGETLB_PAGE examples omitted for conciseness]
> 

To avoid the #ifdef's, but you'll notice that they return either NULL, 0, 
or are a no-op.  We don't substitute real values in dummy functions where 
they could be used in generic code as though they were valid.  That's the 
problem with defining HPAGE_SHIFT to be PAGE_SHIFT and, yes, defining 
HPAGE_MASK and HPAGE_SIZE as well shouldn't be done and should be removed.  

We expect HPAGE_* to represent hugepages, not the native page size of the 
bare metal.  This is why we do things like

	#define HPAGE_PMD_SHIFT ({ BUG(); 0; })
	#define HPAGE_PMD_MASK ({ BUG(); 0; })
	#define HPAGE_PMD_SIZE ({ BUG(); 0; })

for CONFIG_TRANSPARENT_HUGEPAGE=n.  We don't want to pretend that they're 
valid outside the context of hugepages.

We also never use HPAGE_SHIFT, HPAGE_MASK, or HPAGE_SIZE in generic code 
that isn't dependent on CONFIG_HUGETLB_PAGE.  If you'd like to submit a 
patch to fix this in the mips tree, then that would be good, and if you'd 
like to submit a patch to remove these dummy definitions all together by 
auditing other arch code, then that would be great.
