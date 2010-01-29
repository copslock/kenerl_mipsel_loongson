Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2010 20:58:43 +0100 (CET)
Received: from imr1.ericy.com ([198.24.6.9]:56824 "EHLO imr1.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492854Ab0A2T6j (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 Jan 2010 20:58:39 +0100
Received: from eusaamw0711.eamcs.ericsson.se ([147.117.20.178])
        by imr1.ericy.com (8.13.1/8.13.1) with ESMTP id o0TJxSW0020307;
        Fri, 29 Jan 2010 13:59:29 -0600
Received: from localhost (147.117.20.212) by eusaamw0711.eamcs.ericsson.se
 (147.117.20.179) with Microsoft SMTP Server id 8.1.375.2; Fri, 29 Jan 2010
 14:58:31 -0500
Date:   Fri, 29 Jan 2010 12:00:13 -0800
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     David Daney <ddaney@caviumnetworks.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Kernel crash in 2.6.32.6 / bcm1480 with 16k page size
Message-ID: <20100129200013.GD11123@ericsson.com>
References: <20100128155514.GA31611@ericsson.com> <20100129132406.GD5685@linux-mips.org> <20100129151220.GA3882@ericsson.com> <4B6316D2.1060006@caviumnetworks.com> <20100129180619.GA20113@linux-mips.org> <20100129183926.GB9895@ericsson.com> <4B632F60.4000604@caviumnetworks.com> <20100129192532.GA11123@ericsson.com> <4B6336F1.8070208@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4B6336F1.8070208@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 25749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19083

On Fri, Jan 29, 2010 at 02:28:49PM -0500, David Daney wrote:
> Guenter Roeck wrote:
> > On Fri, Jan 29, 2010 at 01:56:32PM -0500, David Daney wrote:
> >> Guenter Roeck wrote:
> >>> On Fri, Jan 29, 2010 at 01:06:20PM -0500, Ralf Baechle wrote:
> >>>> On Fri, Jan 29, 2010 at 09:11:46AM -0800, David Daney wrote:
> >>>>
> >>>>>> So first question would be: Has anyone successfully loaded a 64
> >>>>>> bit mips kernel with 2.6.32 and a page size of 16k or 64k ? This
> >>>>>> would at least help me reducing the problem to sb1.
> >>>>> Yes, I routinely run with both 64K and 16K page sizes on 2.6.32 and
> >>>>> 2.6.33-rc*.  I have not seen any crashes that can not be easily
> >>>>> explained.
> >>>> I can reproduce it with today's 14b7baff3eb4b1b46a592630e6f85ded9264798a.
> >>>> 4K page size works ok, 16K without IPv6 works ok and 16K with IPv6 crashes.
> >>>> Note, I was testing with a non-16K capable userland so ok means userland is
> >>>> reached.
> >>>>
> >>>> Either way, that's good enought to look into things.
> >>>>
> >>> 16k page size works for me with the patch below. Not that I have any idea why;
> >>> this was just a blind test.
> >>>
> >>> It seems to me that the notes in arch/mips/include/asm/pgtable-64.h regarding
> >>> available virtual memory per page size may contradict with the definition
> >>> of VMALLOC_END. VMALLOC_END-VMALLOC_START increases as the page size increases,
> >>> but the comments indicate that a system with 16k pages should have _less_
> >>> virtual memory available than a system with 4k pages because it only uses
> >>> a 2 level page table.
> >>>
> >>> Guenter
> >>>
> >>> ---------------
> >>>
> >>> git diff arch/mips/include/asm/pgtable-64.h
> >>> diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
> >>> index 9cd5089..bd61030 100644
> >>> --- a/arch/mips/include/asm/pgtable-64.h
> >>> +++ b/arch/mips/include/asm/pgtable-64.h
> >>> @@ -110,7 +110,7 @@
> >>>  #define VMALLOC_START          MAP_BASE
> >>>  #define VMALLOC_END    \
> >>>         (VMALLOC_START + \
> >>> -        PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE - (1UL << 32))
> >>> +        (PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE / 16) - (1UL << 32))
> >>>  #if defined(CONFIG_MODULES) && defined(KBUILD_64BIT_SYM32) && \
> >>>         VMALLOC_START != CKSSEG
> >>>  /* Load modules into 32bit-compatible segment. */
> >> Although it may fix it, I think something along the lines of this:
> >>
> >> In asm/mach-generic/spaces.h:
> >> #define MAX_VIRTUAL_SIZE (1 << some number)
> >>
> >> In asm/mach-sibyte/paces.h:
> >> #define MAX_VIRTUAL_SIZE (1 << some other umber)
> >>
> >> In arch/mips/include/asm/pgtable-64.h
> >>
> >> #define VIRTUAL_SIZE (PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * 
> >> PAGE_SIZE)
> >>
> >> #define VMALLOC_END (VMALLOC_START + min(MAX_VIRTUAL_SIZE, VIRTUAL_SIZE) 
> >> - (1UL << 32))
> > 
> > Something like that. My patch wasn't supposed to be a proposal for a fix,
> > just a guide to help finding the underlying problem.
> > It may require some factor related to the page size.
> > Someone who knows mips and its memory management scheme should have
> > a look, otherwise it would just be a trial-end-error fix.
> > 
> 
> I suspect you are hitting a maximum valid address bits limit and getting 
> the Address Exception.  Limiting VMALLOC_END so that you don't hit the 
> limit seems to be the solution.  I don't have the manual for the sibyte, 
> so I don't know what the limit is.  The architecture specification 
> doesn't state a fixed limit, although it tells what should happen when 
> the limit is reached.
> 
To follow up on this - does Octeon have a fixed VM size limit ?
And when you run your tests with larger page sizes, do you have IPV6 enabled ?

Guenter
