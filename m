Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Sep 2018 09:19:48 +0200 (CEST)
Received: from mail-io1-f67.google.com ([209.85.166.67]:34356 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992328AbeI0HTo3WIov (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Sep 2018 09:19:44 +0200
Received: by mail-io1-f67.google.com with SMTP id h16-v6so1245161ioj.1;
        Thu, 27 Sep 2018 00:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XY9YF6lzHS0a9WcoIvgpLFK1ycNQ/wuP1R2A7Qn/Jng=;
        b=TJg1nMVndjQtF5Tk2lMRBFzLizOdxAqTEV9S2bad71VGFt43RPlLR8Kcx3zhhQBND4
         G3FHzykL2oYUu/0g574oIhn8d5jZsFfDMGMSWXw2m3AlNX7K9K/ZIRfkaKGIk33ZQWl9
         9uZxAE8PkpECcvJRLts3opIDYC3VZLYkmf35TqDRS4RF+ddGKLpTZ5G07prr04bvySss
         dOapvlnYyhTYM4LxHGHK7JPm4p7tpksyqhnTaD7LdRZSVTgbGK27LyBCtSKZn84t9YAU
         LIudjaugBgS5OD7qSwirR0RcFIYb1uJmmYHRXV3ad43V8r5AOpBfWHG/KH1EtGnNMitW
         O0FA==
X-Gm-Message-State: ABuFfoh4C8AiPwciTsAIWY013Gc20ZvaM5Sem9AOifmWRoD7UtNTeD3i
        iLQROIFh3qzJJXUR2ilqWmVQ5YnnrK4KiSJug8s=
X-Google-Smtp-Source: ACcGV60AptmKmtR6z1kOH9tdtwML1/TBHyEQkETVgLVs6fQ/GlJbzEZgx21L/tJ1OUGIJQYlS9euAvZuX3TDRXTPaAY=
X-Received: by 2002:a5e:d612:: with SMTP id w18-v6mr8018948iom.54.1538032778411;
 Thu, 27 Sep 2018 00:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <1536139990-11665-1-git-send-email-chenhc@lemote.com>
 <1536139990-11665-3-git-send-email-chenhc@lemote.com> <20180926214750.4h7iuqaglno7i2mv@pburton-laptop>
In-Reply-To: <20180926214750.4h7iuqaglno7i2mv@pburton-laptop>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Thu, 27 Sep 2018 15:25:10 +0800
Message-ID: <CAAhV-H5DVwrzobuj1W8mnRKf-QEa9CFPzpJ6RHJEwBtdPX+=1Q@mail.gmail.com>
Subject: Re: [PATCH 02/10] MIPS: c-r4k: Add r4k_blast_scache_node for Loongson-3
To:     Paul Burton <paul.burton@mips.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        zhangfx <zhangfx@lemote.com>, wu zhangjin <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

On Thu, Sep 27, 2018 at 5:47 AM Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Huacai,
>
> Copying DMA mapping maintainers for any input they may have.
>
> On Wed, Sep 05, 2018 at 05:33:02PM +0800, Huacai Chen wrote:
> >  static inline void local_r4k___flush_cache_all(void * args)
> >  {
> >       switch (current_cpu_type()) {
> >       case CPU_LOONGSON2:
> > -     case CPU_LOONGSON3:
> >       case CPU_R4000SC:
> >       case CPU_R4000MC:
> >       case CPU_R4400SC:
> > @@ -480,6 +497,11 @@ static inline void local_r4k___flush_cache_all(void * args)
> >               r4k_blast_scache();
> >               break;
> >
> > +     case CPU_LOONGSON3:
> > +             /* Use get_ebase_cpunum() for both NUMA=y/n */
> > +             r4k_blast_scache_node(get_ebase_cpunum() >> 2);
> > +             break;
> > +
>
> I wonder if we could instead just include the node ID bits in
> INDEX_BASE? Then we could continue using r4k_blast_scache() here as
> usual.
Yes, but it has no advantages.

>
> >       case CPU_BMIPS5000:
> >               r4k_blast_scache();
> >               __sync();
> > @@ -840,10 +862,14 @@ static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
> >
> >       preempt_disable();
> >       if (cpu_has_inclusive_pcaches) {
> > -             if (size >= scache_size)
> > -                     r4k_blast_scache();
> > -             else
> > +             if (size >= scache_size) {
> > +                     if (current_cpu_type() != CPU_LOONGSON3)
> > +                             r4k_blast_scache();
> > +                     else
> > +                             r4k_blast_scache_node(pa_to_nid(addr));
> > +             } else {
> >                       blast_scache_range(addr, addr + size);
> > +             }
> >               preempt_enable();
> >               __sync();
> >               return;
>
> Hmm, so if I understand correctly this will writeback+invalidate the L2
> for one node only? ie. you just changed which node that is.
>
> I'm presuming L2 ops performed in one node aren't broadcast to other
> nodes, otherwise this patch is pointless?
>
> Thus presumably L2 caches in other nodes may contain stale data, right?
> Or even worse, dirty data which may get written back at any moment?
>
> I'm not sure this is safe - do you need to operate on all L2 caches in
> the system here?
>
> I also wonder whether it would be cleaner for Loongson3 to provide a
> custom struct dma_map_ops to implement this, rather than adding the
> condition to the generic implementation.
In Loongson-3, L2 cache is shared by all nodes, that means a memory
address has only one copy in L2 (node-0's memory only cached in
node-0's L2, node-1's memory only cached in node-1's memory. If node-0
want to access node-1's memory, it may hit in node-1's L2).

Huacai

>
> Thanks,
>     Paul
