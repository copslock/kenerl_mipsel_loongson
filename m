Return-Path: <SRS0=Zc/W=RE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA32AC43381
	for <linux-mips@archiver.kernel.org>; Fri,  1 Mar 2019 11:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9307120851
	for <linux-mips@archiver.kernel.org>; Fri,  1 Mar 2019 11:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfCALC7 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Mar 2019 06:02:59 -0500
Received: from foss.arm.com ([217.140.101.70]:33106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727932AbfCALC6 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 1 Mar 2019 06:02:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CC78EBD;
        Fri,  1 Mar 2019 03:02:58 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 507303F575;
        Fri,  1 Mar 2019 03:02:54 -0800 (PST)
Subject: Re: [PATCH v3 11/34] mips: mm: Add p?d_large() definitions
To:     Paul Burton <paul.burton@mips.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        James Hogan <jhogan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Morse <james.morse@arm.com>
References: <20190227170608.27963-1-steven.price@arm.com>
 <20190227170608.27963-12-steven.price@arm.com>
 <20190228021526.bb6m3my46ohb4o6h@pburton-laptop>
 <74944d83-f3c0-ff02-590e-b7e5abcea485@arm.com>
 <20190228185526.hdryn2zsfign7vht@pburton-laptop>
From:   Steven Price <steven.price@arm.com>
Message-ID: <7e314e29-dab5-e941-60c8-05ea74747f4e@arm.com>
Date:   Fri, 1 Mar 2019 11:02:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190228185526.hdryn2zsfign7vht@pburton-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On 28/02/2019 18:55, Paul Burton wrote:
> Hi Steven,
> 
> On Thu, Feb 28, 2019 at 12:11:24PM +0000, Steven Price wrote:
>> On 28/02/2019 02:15, Paul Burton wrote:
>>> On Wed, Feb 27, 2019 at 05:05:45PM +0000, Steven Price wrote:
>>>> For mips, we don't support large pages on 32 bit so add stubs returning 0.
>>>
>>> So far so good :)
>>>
>>>> For 64 bit look for _PAGE_HUGE flag being set. This means exposing the
>>>> flag when !CONFIG_MIPS_HUGE_TLB_SUPPORT.
>>>
>>> Here I have to ask why? We could just return 0 like the mips32 case when
>>> CONFIG_MIPS_HUGE_TLB_SUPPORT=n, let the compiler optimize the whole
>>> thing out and avoid redundant work at runtime.
>>>
>>> This could be unified too in asm/pgtable.h - checking for
>>> CONFIG_MIPS_HUGE_TLB_SUPPORT should be sufficient to cover the mips32
>>> case along with the subset of mips64 configurations without huge pages.
>>
>> The intention here is to define a new set of macros/functions which will
>> always tell us whether we're at the leaf of a page table walk, whether
>> or not huge pages are compiled into the kernel. Basically this allows
>> the page walking code to be used on page tables other than user space,
>> for instance the kernel page tables (which e.g. might use a large
>> mapping for linear memory even if huge pages are not compiled in) or
>> page tables from firmware (e.g. EFI on arm64).
>>
>> I'm not familiar enough with mips to know how it handles things like the
>> linear map so I don't know how relevant that is, but I'm trying to
>> introduce a new set of functions which differ from the existing
>> p?d_huge() macros by not depending on whether these mappings could exist
>> for a user space VMA (i.e. not depending on HUGETLB support and existing
>> for all levels that architecturally they can occur at).
> 
> Thanks for the explanation - the background helps.
> 
> Right now for MIPS, with one exception, there'll be no difference
> between a page being huge or large. So for the vast majority of kernels
> with CONFIG_MIPS_HUGE_TLB_SUPPORT=n we should just return 0.
> 
> The one exception I mentioned is old SGI IP27 support, which allows the
> kernel to be mapped through the TLB & does that using 2x 16MB pages when
> CONFIG_MAPPED_KERNEL=y. However even there your patch as-is won't pick
> up on that for 2 reasons:
> 
>   1) The pages in question don't appear to actually be recorded in the
>      page tables - they're just written straight into the TLB as wired
>      entries (ie. entries that will never be evicted).
> 
>   2) Even if they were in the page tables the _PAGE_HUGE bit isn't set.
> 
> Since those pages aren't recorded in the page tables anyway we'd either
> need to:
> 
>   a) Add them to the page tables, and set the _PAGE_HUGE bit.
> 
>   b) Ignore them if the code you're working on won't be operating on the
>      memory mapping the kernel.
> 
> For other platforms the kernel is run from unmapped memory, and for all
> cases including IP27 the kernel will use unmapped memory to access
> lowmem or peripherals when possible. That is, MIPS has virtual address
> regions ((c)kseg[01] or xkphys) which are architecturally defined as
> linear maps to physical memory & so VA->PA translation doesn't use the
> TLB at all.
> 
> So my thought would be that for almost everything we could just do:
> 
>   #define pmd_large(pmd)	pmd_huge(pmd)
>   #define pud_large(pmd)	pud_huge(pmd)
> 
> And whether we need to do anything about IP27 depends on whether a) or
> b) is chosen above.
> 
> Or alternatively you could do something like:
> 
>   #ifdef _PAGE_HUGE
> 
>   static inline int pmd_large(pmd_t pmd)
>   {
>   	return (pmd_val(pmd) & _PAGE_HUGE) != 0;
>   }
> 
>   static inline int pud_large(pud_t pud)
>   {
>   	return (pud_val(pud) & _PAGE_HUGE) != 0;
>   }
> 
>   #else
>   # define pmd_large(pmd)	0
>   # define pud_large(pud)	0
>   #endif
> 
> That would cover everything except for the IP27, but would make it pick
> up the IP27 kernel pages automatically if someone later defines
> _PAGE_HUGE for IP27 CONFIG_MAPPED_KERNEL=y & makes use of it for those
> pages.

Thanks for the detailed explanation. I think my preference is your
change above (#ifdef _PAGE_HUGE) because I'm trying to stop people
thinking p?d_large==p?d_huge. MIPS is a little different from other
architectures in that the hardware doesn't walk the page tables, so
there isn't a definitive answer as to whether there is a 'huge' bit in
the tables or not - it actually does depend on the kernel configuration.

For the IP27 case I think the current situation is probably fine - the
intention is to walk the page tables, so even though the TLBs (and
therefore the actual translations) might not match, at least p?d_large
will accurately tell when the leaf of the page table tree has been
reached. And as you say, using _PAGE_HUGE as the #ifdef means that
should support be added the code should automatically make use of it.

Thanks for your help,

Steve
