Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Dec 2016 22:57:32 +0100 (CET)
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36153 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993061AbcLVV5YhNmdS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Dec 2016 22:57:24 +0100
Received: by mail-lf0-f65.google.com with SMTP id t196so1208012lff.3;
        Thu, 22 Dec 2016 13:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JinEBlgzv+cYpTdv+S1KmrkRcYO6roOZXac7O//stQw=;
        b=BAJthx3KDOc6eTbdCOf/0XPSG+ACqpSOzkaXi3Nc+Cj0EJEgl5rTdR4UcbOrt7adqH
         Kl+3go2f7Ct7M8r06q2a270wCS4QoXR5jHMOKE6gcsXh8JZv7OucN1N1kektBXqCFsWv
         gK5km9Ah6dOd4nDhYxTnDZQDvU5ql+mE3jiDElUlR0j8s3S+CoVFUrLrQGjNxO6Qq/nQ
         Qw9ewb23jOTJPl2XU5RzDNBVRDO2wZjfHkDp/bGWDBvwbbkvTHmaNKg2iCPEffU9O807
         C3ji5hEf5eCkwV3wgLxtNmtOt0cU2MBTZmvxTOCqGGp6AqD9YaMSIWM5C7ywapF39zX/
         hv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JinEBlgzv+cYpTdv+S1KmrkRcYO6roOZXac7O//stQw=;
        b=ZBWMW9/BqTwQvDtlXUhPe7uqPQkAdIctuA1JCLY0fJ3C2nUizsI1tO9WfAMKx7hSRy
         Vqoge9+UbcUzZNJbXppM6cc3CS7fa8iG1YVU8wprnTvEESq+DbzzkXeIuaXCkLaoSCkM
         dgN9JsuXTkq/mgt8cfn8V0pAC7dp7Fo0QwfYWFH5iNGlp66++BwDCwiO0LSBMnytnWvA
         r9zzs30KRWD5oPV0C+gzBRGdvGdn5Eeem8uUNOc1ZYE5EtbAguXjdXHOJ7DoxmcOdRax
         EejkF35cjV6qqFdVHvq/WAFN6K4Q5B1wyyTWaD5f/6+lJO5gQrJnCQNDY18yVGlO65gz
         28jA==
X-Gm-Message-State: AIkVDXLXQfBoaSz1UePf/iZgdCkvM1Vt1HAc5OnC9oxZ458jItB9R95kTtAnCdMUaobJZQ==
X-Received: by 10.46.5.136 with SMTP id 130mr5133576ljf.36.1482443839007;
        Thu, 22 Dec 2016 13:57:19 -0800 (PST)
Received: from mobilestation ([95.79.144.28])
        by smtp.gmail.com with ESMTPSA id s63sm7321876lja.19.2016.12.22.13.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Dec 2016 13:57:18 -0800 (PST)
Date:   Fri, 23 Dec 2016 00:57:21 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>, rabinv@axis.com,
        matt.redfearn@imgtec.com, James Hogan <james.hogan@imgtec.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Sergey.Semin@t-platforms.ru,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/21] MIPS memblock: Unpin dts memblock sanity check
 method
Message-ID: <20161222215721.GA7817@mobilestation>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
 <1482113266-13207-2-git-send-email-fancer.lancer@gmail.com>
 <CAL_JsqKNZRXzYKVFWRJraEZMvZ0Oj8CBoVFSAy+EWTi5Uavesw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKNZRXzYKVFWRJraEZMvZ0Oj8CBoVFSAy+EWTi5Uavesw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

On Thu, Dec 22, 2016 at 02:57:07PM -0600, Rob Herring <robh+dt@kernel.org> wrote:
> On Sun, Dec 18, 2016 at 8:07 PM, Serge Semin <fancer.lancer@gmail.com> wrote:
> > It's necessary to check whether retrieved from dts memory regions
> > fits to page alignment and limits restrictions. Sometimes it is
> > necessary to perform the same checks, but ito add the memory regions
> 
> s/ito/to/
> 
> > into a different subsystem. MIPS is going to be that case.
> >
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > ---
> >  drivers/of/fdt.c       | 47 +++++++++++++++++++++++---------
> >  include/linux/of_fdt.h |  1 +
> >  2 files changed, 35 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index 1f98156..1ee958f 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -983,44 +983,65 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
> >  #define MAX_MEMBLOCK_ADDR      ((phys_addr_t)~0)
> >  #endif
> >
> > -void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
> > +int __init sanity_check_dt_memory(phys_addr_t *out_base,
> > +                                 phys_addr_t *out_size)
> 
> As kbuild robot found, you don't want to use phys_addr_t here.
> phys_addr_t varies with kernel config such as LPAE on ARM and the DT
> does not.
> 

Ok, thanks. I'll fix it. I figured it out when got kbuild notification.

> >  {
> > +       phys_addr_t base = *out_base, size = *out_size;
> >         const u64 phys_offset = MIN_MEMBLOCK_ADDR;
> >
> >         if (!PAGE_ALIGNED(base)) {
> >                 if (size < PAGE_SIZE - (base & ~PAGE_MASK)) {
> > -                       pr_warn("Ignoring memory block 0x%llx - 0x%llx\n",
> > +                       pr_err("Memblock 0x%llx - 0x%llx isn't page aligned\n",
> 
> These are not errors. The page alignment is an OS restriction. h/w
> (which the DT describes) generally has little concept of page size
> outside the MMUs.
> 

Ok. Understood. I'll get back the pr_warn() method call.

> Too many unrelated changes in this patch. Add the error return only
> and make anything else a separate patch (though I would just drop
> everything else).
> 

There is no much changes actually. I just unpicked the check function
and switched pr_warn's to pr_error's. Since the last thing is going to
be discarded, then it's not necessary to make any separation.

> I've not looked at the rest of the series, but why can't MIPS migrate
> to using memblock directly and using the default DT functions using
> memblock?
> 
> Rob

Of course there is a reason. Otherwise I wouldn't do it.

A lot of platforms dependent code use MIPS-specific boot_mem_map
structure. So in order to prevent a lot of code modifications MIPS
architecture code needs to support that structure as reflection of
available memory regions. For this purpose I've modified
add_memory_region() method (see patch 0003), which adds a passed
memory region to memblock and boot_mem_map simultaneously.

So in order to simplify the MIPS architecture code, I unpicked the
parameters check function from the default
early_init_dt_add_memory_arch() method, and used it in my callback
method together with MIPS-specific add_memory_region().

Another approach would be to leave the early_init_dt_add_memory_arch()
alone with no modification, and add some new MIPS-specific function,
which would be called right after, for instance, plat_mem_setup().
But in this way we can come up with some errors, since we can't be
absolutely sure, that dts memory nodes scan is performed only there.
The method early_init_dt_scan() can be called from some other places
like device_tree_init() or some place else. It can be fixed by moving
early_init_dt_scan() invocations from chip-specific code to MIPS-
architecture code. But in this case We would have to make
modification at __dt_setup_arch(), which is widely used at the
soc-specific code.

Another option would be to leave early_init_dt_add_memory_arch() alone,
but to develop MIPS-specific parameters check function, or just leave
my callback method without it. But in the first case I would duplicate
the code and in the second case it would leave a window for errors,
since it's wrong to have unaligned memory regions. It may lead to
problems with further buddy allocator initialization.

So to speak I've chosen the easiest option of ones I came up to. If
you have any better suggestion, I would gladly get rid of this patch.
The lesser code modifications the better.

-Sergey
