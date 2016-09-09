Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Sep 2016 19:09:12 +0200 (CEST)
Received: from mail-ua0-f181.google.com ([209.85.217.181]:36143 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992990AbcIIRJB3SoOZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Sep 2016 19:09:01 +0200
Received: by mail-ua0-f181.google.com with SMTP id b7so73089793uab.3
        for <linux-mips@linux-mips.org>; Fri, 09 Sep 2016 10:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DLv3xqnPaCSByi9IigJx0FZ961jSndG0cOIU72kK5ik=;
        b=swDz1kaTyDOL8Z70CC1L7xOIfmdwBdObPEqWcpv1Njbr9ur68V4fibKZ7W7yBtnZI2
         ZLcMMd5MSkaLzY+Csul8nqOwXustGDOGN9nZjPgFlmKDS00OTreYKtBb+C7o6u0dBSFW
         g4I/8XXyJOTZwBzu+5+XB6D0KL8ptjdg5pLzGt4evj0MW+eE8YPmRsaCAtXVnv3iFczz
         GLJYS3YTPjD/sDDrqODncrdaWyaAzycnR3rUYckq0OYzSyjiuBf7KWl/w4uf2WeaWriQ
         c9j39HZ6vDv0MvFWg/h0DRPc/4tTLjNBewmpFWAKMxmTuYoOakUU/8GI8WZ7rz0oGxu+
         k0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DLv3xqnPaCSByi9IigJx0FZ961jSndG0cOIU72kK5ik=;
        b=IzCBAvBEEg4aztVkWfDKhBHbqMhB5kl6E5hbVRPPH7qRJgeBeuLN+XEAs0ljCXUggF
         X1b0/Ag20RYgcJwQE86AULfUG3tcgNPObZ8ABu1MwNbfRJbIdOfcHDapgkX1tauvNzuS
         xS/2vvPq2q+b+LJqkAs2Rtt/mYZEITGOjFR1vhKSVwQhJ4Xh/insHi+vMnF3dgDEHHoq
         q3ogbrMmdOsYK7o1TcgtggHoUoZhWFd8RPAS9h+3n+H/OciEfOv5LYdllSAcvqPTl4E2
         NL/6DC6HarYbQdINBVAu8BFYuoOKDV0SAP2/yEBbzWHToH+DLLYKOrmPH246pCFyU6fC
         FLqg==
X-Gm-Message-State: AE9vXwPKlQrZup4jIQECIs97jtTqCGrHytqdOL6sP7AmwgDo9RQGz1Cn4zm7lGmFySbqrhhapVTmVipkZAYwvg==
X-Received: by 10.176.67.195 with SMTP id l61mr3250189ual.62.1473440935593;
 Fri, 09 Sep 2016 10:08:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.242.73 with HTTP; Fri, 9 Sep 2016 10:08:35 -0700 (PDT)
In-Reply-To: <20160909145058.GD26885@jhogan-linux.le.imgtec.org>
References: <CAFwMWxtUHa_Av34RrzFp3Dar0y-ghQRJNeXeUqYeUo3149zOsw@mail.gmail.com>
 <20160909123652.GA1846@jhogan-linux.le.imgtec.org> <CAFwMWxsQ6tpj7D1NnatEeVis32pRwKRsKkPXFgGrkvyCES0yHA@mail.gmail.com>
 <20160909145058.GD26885@jhogan-linux.le.imgtec.org>
From:   Sagar Borikar <sagar.borikar@gmail.com>
Date:   Fri, 9 Sep 2016 10:08:35 -0700
Message-ID: <CAFwMWxvE_popTW01j7EGZOkqkG2jQhxQW8GV-XNS7o359ghHsA@mail.gmail.com>
Subject: Re: highmem issues with 3.14.10 (LST)
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <sagar.borikar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sagar.borikar@gmail.com
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

Thanks James. That was useful.

Sagar

On Fri, Sep 9, 2016 at 7:50 AM, James Hogan <james.hogan@imgtec.com> wrote:
> On Fri, Sep 09, 2016 at 06:17:13AM -0700, Sagar Borikar wrote:
>> Thanks James.
>>
>> On Fri, Sep 9, 2016 at 5:36 AM, James Hogan <james.hogan@imgtec.com> wrote:
>> > Hi Sagar,
>> >
>> > On Thu, Sep 08, 2016 at 08:33:57PM -0700, Sagar Borikar wrote:
>> >> Hello,
>> >>
>> >> I am upgrading kernel for a MIPS Interaptive CPU from 3.10.60 to
>> >> 3.14.10 (stable) from:
>> >> https://www.linux-mips.org/wiki/Malta_Linux_Repository
>> >
>> > Unfortunately that wiki page needs updating.
>> >
>> > If you're upgrading anyway, I think we'd recommend switching all the way
>> > to a recent mainline kernel release / stable branch, e.g. 4.4 (LTS) or
>> > 4.7 (and maybe update to 4.9 (LTS) when it is released or when 4.7 goes
>> > EOL). I think all the stuff you'll need for interAptiv should be in
>> > mainline now anyway.
>>
>> I see. We generally upgrade to malta repo as its maintained by mips
>> (imgtec). I presume you are referring to kernel.org. I think linux-mti
>> is having  4.1.7 as stable, right?
>
> Yeh I was referring to kernel.org. 3.14 was the last linux-mti branch.
> A lot of stuff in mti-3.10 got upstreamed (with a lot of changes and
> clean ups made along the way), and I think as a result mti-3.14 was
> mostly backported patches from mainline. That may explain this
> regression.
>
> We're now trying to focus a lot more on mainline (although we have
> engineering branches in that same linux-mti repository, which are more
> for supporting new architecture features & new cores before they've
> found their way into mainline).
>
>> >>  The platform has non-contiguous low memory and high memory. After the
>> >> upgrade, highmem is not getting enabled due to max_low_pfn and
>> >> highend_pfn not being the same.
>> >>
>> >> The commit cce335ae47e231398269fb05fa48e0e9cbf289e0 introduced the
>> >> change apparently for sibyte platform. That change doesn't hold good
>> >> for all platforms where the high memory and low memory is sparsed.
>> >>
>> >> If I comment out only following change in arch/mips/mm/init.c, highmem
>> >> gets initialized properly.
>> >>
>> >> 296     if (cpu_has_dc_aliases && max_low_pfn != highend_pfn) {
>> >> 297         printk(KERN_WARNING "This processor doesn't support highmem."
>> >> 298                " %ldk highmem ignored\n",
>> >> 299                (highend_pfn - max_low_pfn) << (PAGE_SHIFT - 10));
>> >> 300         max_zone_pfns[ZONE_HIGHMEM] = max_low_pfn;
>> >> 301         lastpfn = max_low_pfn;
>> >> 302     }
>> >
>> > I don't think we ever supported DCache aliasing + highmem in
>> > combination.
>>
>> Interesting. We are currently running 3.10.60 and apparently it seems
>> to work. Are you saying it may cause any issues? So far we haven't
>> seen any problems. What kind of issues it might end up into?
>
> Sorry, I was thinking of mainline.
>
> Mti-3.10 seems to have had changes which didn't make it upstream which
> would have made this possible, from which commit 15de36a4c3cf
> ("mm/highmem: make kmap cache coloring aware") was derived (which was
> merged for v3.17, in August 2014). There were attempts to add the MIPS
> support after this, but none of them made it upstream:
>
> https://patchwork.linux-mips.org/project/linux-mips/list/?state=*&q=fixes+for+cache+aliasing
>
>>
>> >
>> > If you want to use that memory your options are probably:
>> > - increase the page size to avoid dcache aliasing.
>>
>> Ok thanks. I would need to experiment with this but I am bit baffled
>> how its working in 3.10.60.
>> Generally, is there any reference platforms based on interaptiv which
>> uses highmem and dcache aliasing? I might have missed but couldn't
>> find any platform which comes close in both trees.
>
> Its probably possible to configure malta in such a way (4k pages, big
> cache, alias removal disabled in hardware, highmem).
>
>>
>> > - OR use EVA to increase the size of lowmem, which at the moment is a
>> >   bit more involved. How much RAM do you have, and what does your
>> >   physical memory map look like?
>>
>> Total memory is 2GB. memory map looks like this:
>>
>> low mem(~66MB) :
>>
>>  * 0x04300000 +-----------------+
>>  *                    |     Linux       |
>>  * 0x00043000 +-----------------+
>>
>> high mem (128MB):
>>
>>  * 0x28000000 +-----------------+
>>  *                   |     linuxhi     |
>>  * 0x20000000 +-----------------+
>>
>> Rest of the blocks are reserved.
>
> It should be possible to use EVA to expand lowmem to cover these two
> regions. Fitting in the whole 2GB would probably be a little trickier
> depending on other stuff (how much IO memory is needed, IOCU in use,
> etc).
>
> Cheers
> James
