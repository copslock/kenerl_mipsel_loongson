Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Jul 2014 00:50:56 +0200 (CEST)
Received: from mail-la0-f49.google.com ([209.85.215.49]:57320 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860024AbaGEWuwgJoL6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Jul 2014 00:50:52 +0200
Received: by mail-la0-f49.google.com with SMTP id gf5so1880327lab.8
        for <multiple recipients>; Sat, 05 Jul 2014 15:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=AK3s3ZUhohxLIJqDZwluRsTTfE2eFIoSk7Ci4zBKW64=;
        b=jauhscZnYDMh83jBRCgDeQHJRLvneqdvaX0XmzciGBLM8Z/wXjj3eIdgRch9hMoM6C
         lDB7Xklt3mcy9diJ8j1yyAPnCC0E3emKkhvtG32yhqmz0qs9UJW4l5ntsmk0mlJGYSN5
         EgMuGfvn/CSzPR6YyLM6WPvY0PKD9ISx55g3QBaw7nJgBGKaww7VrK8xVlOBG/A1v9kI
         uVZZz5Afcqg46sv5Bo/2vi2ltcp0fpaHVAODL5aPd80Kl1e4IdUTWwPsEtsiynXtJVfA
         4WEsXu8/pStKAFu94oc31z37S4ibDCj0rLt/011AA01Xws4tkHpq4yBP8RxGyi/A8VpE
         f8aQ==
X-Received: by 10.152.5.230 with SMTP id v6mr15056663lav.33.1404600646936;
        Sat, 05 Jul 2014 15:50:46 -0700 (PDT)
Received: from lianli (c193-14-6-78.cust.tele2.se. [193.14.6.78])
        by mx.google.com with ESMTPSA id jv2sm15511403lbc.45.2014.07.05.15.50.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 05 Jul 2014 15:50:46 -0700 (PDT)
Date:   Sun, 6 Jul 2014 00:50:34 +0200
From:   Emil Goode <emilgoode@gmail.com>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        John Crispin <blogic@openwrt.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: Fix incorrect NULL check in
 local_flush_tlb_page()
Message-ID: <20140705225034.GA12090@lianli>
References: <1404584812-12377-1-git-send-email-emilgoode@gmail.com>
 <CAOiHx=nU7GvGnwrH0TqTkO9-mhX2RJU5gPzRRwb1OfHPcHmrqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiHx=nU7GvGnwrH0TqTkO9-mhX2RJU5gPzRRwb1OfHPcHmrqA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <emilgoode@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41053
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

Hello,

On Sat, Jul 05, 2014 at 09:10:44PM +0200, Jonas Gorski wrote:
> On Sat, Jul 5, 2014 at 8:26 PM, Emil Goode <emilgoode@gmail.com> wrote:
> > We check that the struct vm_area_struct pointer vma is NULL and then
> > dereference it a few lines below. The intent must have been to make sure
> > that vma is not NULL and then to check the value from cpu_context() for
> > the condition to be true.
> >
> > Signed-off-by: Emil Goode <emilgoode@gmail.com>
> > ---
> >
> > v2: Updated the commit message with a better explanation.
> >
> >  arch/mips/mm/tlb-r3k.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/mips/mm/tlb-r3k.c b/arch/mips/mm/tlb-r3k.c
> > index d657493..6546758 100644
> > --- a/arch/mips/mm/tlb-r3k.c
> > +++ b/arch/mips/mm/tlb-r3k.c
> > @@ -158,7 +158,7 @@ void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
> >  {
> >         int cpu = smp_processor_id();
> >
> > -       if (!vma || cpu_context(cpu, vma->vm_mm) != 0) {
> > +       if (vma && cpu_context(cpu, vma->vm_mm) != 0) {
> 
> Sorry for replying "too late", but grepping through the kernel code I
> fail to find any caller that does not dereference vma before calling
> (local)flush_tlb_page(). Also both tlb-4k and tlb-8k assume vma cannot
> be NULL, so I would say it is safe to assume vma is never NULL, and
> the NULL check can be removed completely.
> 
> Also it looks like this "bug" was there since at least 2.6.12, and
> never seem to have bitten anyone.

Yes, the bug pre-dates GIT history and I agree that it is most unlikely
that it ever caused a problem. I will send a new patch that removes the
NULL check of vma.

Best regards,

Emil Goode
