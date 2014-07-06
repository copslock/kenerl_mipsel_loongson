Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jul 2014 00:13:39 +0200 (CEST)
Received: from mail-la0-f53.google.com ([209.85.215.53]:54196 "EHLO
        mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859971AbaGFWNSzvaEC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Jul 2014 00:13:18 +0200
Received: by mail-la0-f53.google.com with SMTP id b8so2339968lan.12
        for <multiple recipients>; Sun, 06 Jul 2014 15:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9AQL3sVW+jg1DganSFeOTTwzj2fcaOCTViCTr+a9C2A=;
        b=YZfGbLJbeYM+QvqS/e/XeOkjhPZR2I3W7lmkJHsiFQKDYwu/Z+blR9hner5Lm/2g+F
         sQFriW6UBtsu0xwnpuaSXuQ54DhcVp12vxL9s6BQY1lZm9NSnuyuJHiGefNl6GjJYFvU
         slWvbz5Izq5kMQgRQ99/EyFCwH/YGGcMFZxdgv5ajB/ohErEUICBPhxclF7ASDFyVNjd
         MjvnW6Hadj/d0JKSYyBYKLbnWwS7rgADuvzXFoL9k8hOgOP71MTXyHVPmBBAbxA6Q48e
         nYVTpCSNcC6w8gR2OXiGBozIvzUNxThuXmw5ybaEUSPQjqW05jqNcq/rT1VsBx+q74tB
         Sh+g==
X-Received: by 10.152.42.211 with SMTP id q19mr3566964lal.59.1404684793038;
        Sun, 06 Jul 2014 15:13:13 -0700 (PDT)
Received: from lianli (c193-14-6-78.cust.tele2.se. [193.14.6.78])
        by mx.google.com with ESMTPSA id lb5sm11170094lab.20.2014.07.06.15.13.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 06 Jul 2014 15:13:12 -0700 (PDT)
Date:   Mon, 7 Jul 2014 00:13:12 +0200
From:   Emil Goode <emilgoode@gmail.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Jonas Gorski <jogo@openwrt.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        John Crispin <blogic@openwrt.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: Fix incorrect NULL check in
 local_flush_tlb_page()
Message-ID: <20140706221312.GB12090@lianli>
References: <1404584812-12377-1-git-send-email-emilgoode@gmail.com>
 <CAOiHx=nU7GvGnwrH0TqTkO9-mhX2RJU5gPzRRwb1OfHPcHmrqA@mail.gmail.com>
 <20140705225034.GA12090@lianli>
 <alpine.LFD.2.11.1407060033420.15455@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1407060033420.15455@eddie.linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <emilgoode@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: emilgoode@gmail.com
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

Hello Maciej,

I didn't know it was possible to go beyond commit 1da177e,
thank you for the info.

Best regards,

Emil

On Sun, Jul 06, 2014 at 12:16:38PM +0100, Maciej W. Rozycki wrote:
> On Sun, 6 Jul 2014, Emil Goode wrote:
> 
> > > > diff --git a/arch/mips/mm/tlb-r3k.c b/arch/mips/mm/tlb-r3k.c
> > > > index d657493..6546758 100644
> > > > --- a/arch/mips/mm/tlb-r3k.c
> > > > +++ b/arch/mips/mm/tlb-r3k.c
> > > > @@ -158,7 +158,7 @@ void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
> > > >  {
> > > >         int cpu = smp_processor_id();
> > > >
> > > > -       if (!vma || cpu_context(cpu, vma->vm_mm) != 0) {
> > > > +       if (vma && cpu_context(cpu, vma->vm_mm) != 0) {
> > > 
> > > Sorry for replying "too late", but grepping through the kernel code I
> > > fail to find any caller that does not dereference vma before calling
> > > (local)flush_tlb_page(). Also both tlb-4k and tlb-8k assume vma cannot
> > > be NULL, so I would say it is safe to assume vma is never NULL, and
> > > the NULL check can be removed completely.
> > > 
> > > Also it looks like this "bug" was there since at least 2.6.12, and
> > > never seem to have bitten anyone.
> > 
> > Yes, the bug pre-dates GIT history and I agree that it is most unlikely
> > that it ever caused a problem. I will send a new patch that removes the
> > NULL check of vma.
> 
>  Well, as at 2.4.26 (picked randomly) code in arch/mips/mm/tlb-r4k.c had 
> the same check:
> 
> void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
> {
> 	int cpu = smp_processor_id();
> 
> 	if (!vma || cpu_context(cpu, vma->vm_mm) != 0) {
> 		unsigned long flags;
> 		[...]
> 
> but code in arch/mips64/mm/tlb-r4k.c did not:
> 
> void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
> {
> 	int cpu = smp_processor_id();
> 
> 	if (cpu_context(cpu, vma->vm_mm) != 0) {
> 		unsigned long flags;
> 		[...]
> 
> and the current situation is an artefact from the 32-bit and 64-bit port 
> unification:
> 
> commit efc2f9a8a100511399309a50a33b46ff099f3454
> Author: Ralf Baechle <ralf@linux-mips.org>
> Date:   Mon Jul 21 03:03:15 2003 +0000
> 
>     Unify tlb-r4k.c.
> 
> -- at which point tlb-r3k.c wasn't updated accordingly.  The condition was 
> eventually removed from arch/mips/mm/tlb-r4k.c in 2.4 too with:
> 
> commit fd8917812546ef2278e006237a7cc38497bfbf52
> Author: Ralf Baechle <ralf@linux-mips.org>
> Date:   Thu Nov 25 22:18:38 2004 +0000
> 
>     Try to glue the hazard avoidance stuff the same way it was done for
>     2.6 before the TLB synthesizer.  Previously the code for some CPUs
>     such as the RM9000 was completly bogus nonsense ...  I guess we may
>     eventually want to backport the tlb synthesizer to 2.4 once the dust
>     has settled.
> 
> And arch/mips64/mm/tlb-r4k.c was introduced with:
> 
> commit 49be6d9f37bbac0a0c413a2a63dcf7cc497d144a
> Author: Ralf Baechle <ralf@linux-mips.org>
> Date:   Wed Jul 24 16:12:03 2002 +0000
> 
>     Random 64-bit updates and fixes.
> 
> and never had the condition in the first place.
> 
>  We do have full 2.6 GIT history, beyond 2.6.12.  It seems cut off at 
> 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 for some operations, but not 
> plain `git log' for example, and I was able to peek beyond that by 
> checking out the immediately preceding commit, that is 
> 66f0a432564b5f0ebf632263ceac84a10a99de09:
> 
> commit 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2
> Author: Linus Torvalds <torvalds@ppc970.osdl.org>
> Date:   Sat Apr 16 15:20:36 2005 -0700
> 
>     Linux-2.6.12-rc2
> 
>     Initial git repository build. I'm not bothering with the full history,
>     even though we have it. We can create a separate "historical" git
>     archive of that later if we want to, and in the meantime it's about
>     3.2GB when imported into git - space that would just make the early
>     git days unnecessarily complicated, when we don't have a lot of good
>     infrastructure for it.
> 
>     Let it rip!
> 
> commit 66f0a432564b5f0ebf632263ceac84a10a99de09
> Author: Ralf Baechle <ralf@linux-mips.org>
> Date:   Fri Apr 15 14:40:46 2005 +0000
> 
>     Add resource managment.
> 
> There may be a better way, I don't claim GIT expertise.
> 
>   Maciej
