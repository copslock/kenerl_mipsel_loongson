Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Nov 2011 14:25:43 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:38569 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1905688Ab1K2NZi convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Nov 2011 14:25:38 +0100
Received: by yenq4 with SMTP id q4so4027073yen.36
        for <multiple recipients>; Tue, 29 Nov 2011 05:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=0JKpgG132312VaniMWX01f+gCqTL8c9EA8HBVbqhr7I=;
        b=k1B+qOdHhgRzJGHckaPPfKVw/Y/BDYYGuvFX6BBDpzqsIqeiffBRSXDiL+p5cs7JZJ
         EStz2ZBq8MmWtVl07de4MiLYIzKk4/QZeI9+Wy8xmNsiu/xn1iJb3FTUtVANw+uXfGQz
         6wOH+WU1PEvbPMXYMv+makL/Vo1ga0yNOiXk4=
MIME-Version: 1.0
Received: by 10.236.183.52 with SMTP id p40mr69424235yhm.19.1322573132218;
 Tue, 29 Nov 2011 05:25:32 -0800 (PST)
Received: by 10.236.181.1 with HTTP; Tue, 29 Nov 2011 05:25:32 -0800 (PST)
In-Reply-To: <20111126173151.GF8397@redhat.com>
References: <CAJd=RBB2gSCaJSsFfJXBg2zmgzNjXPAn8OakAZACNG0mv2D7nQ@mail.gmail.com>
        <20111126173151.GF8397@redhat.com>
Date:   Tue, 29 Nov 2011 21:25:32 +0800
Message-ID: <CAJd=RBD_JmPDx8tPjNXF=1gQTvzxtER6uQ4M9m5jhSFBLCOkGA@mail.gmail.com>
Subject: Re: [PATCH 3/3] MIPS: changes in VM core for adding THP
From:   Hillf Danton <dhillf@gmail.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 32011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 24106

On Sun, Nov 27, 2011 at 1:31 AM, Andrea Arcangeli <aarcange@redhat.com> wrote:
> On Sat, Nov 26, 2011 at 10:43:15PM +0800, Hillf Danton wrote:
>> In VM core, window is opened for MIPS to use THP.
>>
>> And two simple helper functions are added to easy MIPS a bit.
>>
>> Signed-off-by: Hillf Danton <dhillf@gmail.com>
>> ---
>>
>> --- a/mm/Kconfig      Thu Nov 24 21:12:00 2011
>> +++ b/mm/Kconfig      Sat Nov 26 22:12:56 2011
>> @@ -307,7 +307,7 @@ config NOMMU_INITIAL_TRIM_EXCESS
>>
>>  config TRANSPARENT_HUGEPAGE
>>       bool "Transparent Hugepage Support"
>> -     depends on X86 && MMU
>> +     depends on MMU
>>       select COMPACTION
>>       help
>>         Transparent Hugepages allows the kernel to use huge pages and
>
> Then the build will break for all archs if they enable it, better to
> limit the option to those archs that supports it.
>
>> --- a/mm/huge_memory.c        Thu Nov 24 21:12:48 2011
>> +++ b/mm/huge_memory.c        Sat Nov 26 22:30:24 2011
>> @@ -17,6 +17,7 @@
>>  #include <linux/khugepaged.h>
>>  #include <linux/freezer.h>
>>  #include <linux/mman.h>
>> +#include <linux/pagemap.h>
>>  #include <asm/tlb.h>
>>  #include <asm/pgalloc.h>
>>  #include "internal.h"
>> @@ -135,6 +136,30 @@ static int set_recommended_min_free_kbyt
>>  }
>>  late_initcall(set_recommended_min_free_kbytes);
>>
>> +/* helper function for MIPS to call pmd_page() indirectly */
>> +static inline struct page *__pmd_page(pmd_t pmd)
>> +{
>> +     struct page *page;
>> +
>> +#ifdef __HAVE_ARCH_THP_PMD_PAGE
>> +     page = thp_pmd_page(pmd);
>> +#else
>> +     page = pmd_page(pmd);
>> +#endif
>> +     return page;
>> +}
>
> Why do you need this and also a branch in thp_pmd_page checking for
> pmd_trans_huge? If you fallback in pmd_page that would mean you're
> called by hugetlbfs. Doesn't make much sense to fallback in pmd_page
> if the hugepmd format for thp and hugetlbfs is different.
>
> Couldn't you set a different _PAGE_HUGE flag in the pmd in the thp
> case to avoid the above? Then you could have a pmd_page that works on
> both. Ok it'll be slower and require 1 more branch (but you already
> have a branch for something that doesn't seem needed).
>
> pmd_page is only called by hugetlbfs/thp, rest uses pte_offset* so I
> don't think a branch would be a big deal and you could hide the fact
> he format of the pmd between hugetlbfs and thp is different with a
> bitflag on the pmd (if any reserved is available to use to software).
>
>> +
>> +/* helper function for MIPS to call update_mmu_cache() indirectly */
>> +static inline void __update_mmu_cache(struct vm_area_struct *vma,
>> +                                     unsigned long addr, pmd_t *pmdp)
>> +{
>> +#ifdef __HAVE_ARCH_UPDATE_MMU_THP
>> +     update_mmu_thp(vma, addr, pmdp);
>> +#else
>> +     update_mmu_cache(vma, addr, pmdp);
>> +#endif
>> +}
>
> Maybe here same, check pmd_trans_huge (and make it succeed only in the
> thp case and not the hugetlbfs case) and avoid it the __ and the ifdefs.
>

Got and thanks.

Hillf
