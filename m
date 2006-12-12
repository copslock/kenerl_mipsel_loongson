Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Dec 2006 09:15:00 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.171]:48802 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20037867AbWLLJOz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 12 Dec 2006 09:14:55 +0000
Received: by ug-out-1314.google.com with SMTP id 40so1958510uga
        for <linux-mips@linux-mips.org>; Tue, 12 Dec 2006 01:14:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nkL4IlS9AzDVvGE+2LHY2gI6vUh+kqc+TqPMB0QH6cckyOUaJOFNLp3UQcZOWM5a6ffvfYEKgKz/V1m/GoDZmdlE2EQ/ZX6nXK2lLTD9bVdNQ2duUZfpPHb3L+43vqQVyI2ryG/iayt96vQDV7RBa26FUrOg/qSyMF0fR6qeKdk=
Received: by 10.78.193.19 with SMTP id q19mr869629huf.1165914893886;
        Tue, 12 Dec 2006 01:14:53 -0800 (PST)
Received: by 10.78.123.2 with HTTP; Tue, 12 Dec 2006 01:14:53 -0800 (PST)
Message-ID: <cda58cb80612120114y47ecd7bfw296af0327399d56c@mail.gmail.com>
Date:	Tue, 12 Dec 2006 10:14:53 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH 2/3] Setup min_low_pfn/max_low_pfn correctly
Cc:	linux-mips@linux-mips.org, "Franck Bui-Huu" <fbuihuu@gmail.com>
In-Reply-To: <20061211181640.GA25769@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1165420110699-git-send-email-fbuihuu@gmail.com>
	 <11654201103291-git-send-email-fbuihuu@gmail.com>
	 <20061211181640.GA25769@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 12/11/06, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Wed, Dec 06, 2006 at 04:48:29PM +0100, Franck Bui-Huu wrote:
>
> > The old code was assuming that min_low_pfn was always 0. This
> > means that we can't handle platforms with a big hole at start
> > of memory since mem_map[] size would blew up.
>
> It was - and IP22 was paying a high price for that.  It's currently 1MB
> on 32-bit and 1.75MB on 64-bit kernels - but used to be much higher in
> the past.
>
> Btw, I think you're confusing the terms here; your patch description reads
> wrong while the patch looks fine.  PFN is page frame number, not physical
> frame number.  To avoid wasting dead mem_map[] entries idealy the pfn for
> the first allocatable page should be zero.
> So ignoring NUMA and discontig memory for a moment (those make everything
> more complicated ...) PFN 0 is the first entry in mem_map[] - which usually
> but not necessarily is physical address 0x0.
>

well if you look at the generic definition of pfn_to_page(), you find:

        #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))

With the current implementation, PFN 0 is something that does not
exist. PFN ARCH_PFN_OFFSET is the first entry in mem_map[]...

I think I'm missing your point....

> > This patch does not relax this constraint but it's a first
> > step to achieve that.
>
> > diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> > index 89440a0..8e58d7f 100644
> > --- a/arch/mips/kernel/setup.c
> > +++ b/arch/mips/kernel/setup.c
> > @@ -271,7 +271,6 @@ static void __init bootmem_init(void)
> >  static void __init bootmem_init(void)
> >  {
> >       unsigned long reserved_end;
> > -     unsigned long highest = 0;
> >       unsigned long mapstart = -1UL;
>
> Assigning a negative number to an unsigned long variable ...
>

Well, it's a convenient way to set mapstart to 0xffffffff on both
32bits and 64bits kernels as you guessed. I think it's quite readable
thanks to the 'UL' suffix. But I'll change the whole line with:

        unsigned long mapstart = ~(0UL);

> >       unsigned long bootmap_size;
> >       int i;
> > @@ -284,6 +283,13 @@ static void __init bootmem_init(void)
> >       reserved_end = max(init_initrd(), PFN_UP(__pa_symbol(&_end)));
> >
> >       /*
> > +      * max_low_pfn is not a number of pages. The number of pages
> > +      * of the system is given by 'max_low_pfn - min_low_pfn'.
> > +      */
> > +     min_low_pfn = -1UL;
>
> Assigning a negative number to an unsigned long variable ...

ditto

thanks
-- 
               Franck
