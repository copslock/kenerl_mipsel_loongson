Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2015 00:56:00 +0100 (CET)
Received: from mail-qa0-f43.google.com ([209.85.216.43]:41085 "EHLO
        mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010831AbbBAXz7CZNIJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Feb 2015 00:55:59 +0100
Received: by mail-qa0-f43.google.com with SMTP id v10so27074943qac.2
        for <linux-mips@linux-mips.org>; Sun, 01 Feb 2015 15:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FD1At9ajW2t8uf4OzHE5sAlgQjPG8vd1l3mDgUHgAuo=;
        b=VrwvLMuRFCo519i3eBpDLrbCpbtOJKEaKDHZYrb3lagsl5/lIT+SthYW9AzGFMtyRm
         hlru8dXVpbReaQQS1HPudje2HlaB9gz4NxFi/YKxayYb7M/ggKeGuRx+5S7KqQ+0x0WK
         rTw8wk+Jaw0BHcDic/+mVJnkuNry6JoNquJ58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=FD1At9ajW2t8uf4OzHE5sAlgQjPG8vd1l3mDgUHgAuo=;
        b=VNx86hlYdYYNtalFkYgzuUWEikf3fzB6c3pOqqtixa8Y4G8FjsZj5WVLamBUR9xqCv
         nhng+Q34a7VSEAYZ19SYHcw8p8ROhBYxUh7GLhCv2TZVCjIaRhHmBur6rPY4bjOr4dGQ
         UiI4lCF6gmyaZAkOdP/mzG/Zh+VCyzwRnw7sl3pqRBoZZR6SatlXO24kN2lMTA/GUQbT
         +7oFxQxLDNz9yS6PBbGhXfDdwM/TCWVSynXnA4Xzxu31cZosQDscc809piLb3tStEUs3
         7/+LE07v8TvFup1DCU9RGczLMEXUpYFbNgtGtCclDchKgM62dV0iIMrTR1M38s2pbcY3
         rEQQ==
X-Gm-Message-State: ALoCoQm0aDXXj6EF9V/tVRbQJ0YqHNt42fhuRLWz4VTPqChyXOw6hhAM0pauwDJ/Bjqm+bE4Coh0
X-Received: by 10.224.98.196 with SMTP id r4mr35798287qan.27.1422834953129;
        Sun, 01 Feb 2015 15:55:53 -0800 (PST)
Received: from mail-qa0-f46.google.com (mail-qa0-f46.google.com. [209.85.216.46])
        by mx.google.com with ESMTPSA id 107sm16703910qgf.21.2015.02.01.15.55.52
        for <linux-mips@linux-mips.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 01 Feb 2015 15:55:52 -0800 (PST)
Received: by mail-qa0-f46.google.com with SMTP id j7so27108651qaq.5
        for <linux-mips@linux-mips.org>; Sun, 01 Feb 2015 15:55:52 -0800 (PST)
X-Received: by 10.140.83.163 with SMTP id j32mr30435360qgd.52.1422834952000;
 Sun, 01 Feb 2015 15:55:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.36.210 with HTTP; Sun, 1 Feb 2015 15:55:31 -0800 (PST)
In-Reply-To: <54CEACC1.1040701@gmail.com>
References: <54CEACC1.1040701@gmail.com>
From:   Kevin Cernekee <cernekee@chromium.org>
Date:   Sun, 1 Feb 2015 15:55:31 -0800
Message-ID: <CAJiQ=7AQuP1JsiApEs4yAR449w6-pcR_qqhSqKdpqNHL5L1mRQ@mail.gmail.com>
Subject: Re: Few questions about porting Linux to SMP86xx boards
To:     Oleg Kolosov <bazurbat@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45599
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@chromium.org
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

On Sun, Feb 1, 2015 at 2:46 PM, Oleg Kolosov <bazurbat@gmail.com> wrote:
> Hello MIPS gurus!
>
> I'm adding support for Sigma Designs SMP8652/SMP8654 (Tango3 family,
> MIPS 24kf CPU) to newer kernel. I've selectively adapted patches from
> 2.6.32.15 (the latest officially available for us) to the latest mips
> 3.18 stable branch and things seem to work (it boots, runs simple test
> programs), but there are few questions which I was not able to resolve
> yet with my limited experience:
>
> 1. They (Sigma Designs) have overridden __fast_iob which is identical to
> the default one except for one line:
>
>     : "m" (*(int *)CKSEG1)
>
> is replaced with:
>
>     : "m" (*(int *)(CKSEG1+CPU_REMAP_SPACE))
>
> where CPU_REMAP_SPACE=0x4000000 is a compile time constant for Tango3
> and also called KERNEL_START_ADDRESS in Makefiles. The same value is
> also written to ebase:
>
> ebase = KSEG0ADDR(CPU_REMAP_SPACE);
> write_c0_ebase(ebase);
>
> in traps.c:per_cpu_trap_init()
>
> while writing ebase is really necessary for the kernel to boot, I've not
> found any negative effects of not applying __fast_iob patch. What is it
> supposed to do?

I do not have any direct experience with these SoCs, but you might
want to look at the memory map to try to figure this one out.  i.e. if
__fast_iob() normally performs an uncached dummy read from the first
word of physical memory, does the address need to be adjusted by 64MB
on the Sigma chips because system memory (or the memory allocated to
the Linux application processor) starts at PA 0x0400_0000 instead of
0x0000_0000?

That theory would also explain why the exception vectors were adjusted
by the same offset.

BTW, you can override ebase from the platform code, as was done in
arch/mips/kernel/smp-bmips.c.  It probably isn't necessary to change
the common per_cpu_trap_init() code (but it may have been necessary
way back in 2.6.32).

> 2. In io.h they have added explicit __sync() to the end of
> pfx##write##bwlq and pfx##out##bwlq##p. Is this really necessary? I've
> not yet found any adverse effects of not doing so. Maybe this was a
> workaround for some old kernel issue which was fixed since then?

Adding a barrier in writel(), as was done on ARM, might have something
to do with the SoC's busing or peripherals.  Sometimes there are chip
bugs that cause MMIO transaction ordering to break in unexpected ways.
Or it could be there to compensate for missing barriers or bad
assumptions in a driver somewhere.

For #2 and #3, it is likely that somebody at Sigma could find a bug
report or changelog explaining why it was added.  In my experience
these sorts of changes are usually made to work around subtle problems
discovered in testing or production.  Figuring out the exact problem
that inspired the patch can be difficult without insider knowledge,
unless you happened to run across the same failure.

> 3. In c-r4k.c:r4k_cache_init() they assign:
>
> flush_icache_page = r4k_flush_icache_page;
>
> where:
>
> static void r4k_flush_icache_page(struct vm_area_struct *vma,
>                                   struct page *page)
> {
>     r4k_flush_icache_range((unsigned long)page_address(page),
>         (unsigned long)page_address(page) + PAGE_SIZE);
> }

Hmm, this might not play nice with HIGHMEM.  If it does, it would be
helpful to include a comment explaining why.
