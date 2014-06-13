Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2014 13:13:24 +0200 (CEST)
Received: from mail-wi0-f179.google.com ([209.85.212.179]:48966 "EHLO
        mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825715AbaFMLNVloQY9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jun 2014 13:13:21 +0200
Received: by mail-wi0-f179.google.com with SMTP id cc10so672590wib.0
        for <multiple recipients>; Fri, 13 Jun 2014 04:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OccDCe/4yOlepqMgRW1HWDn01KlwxB08Q2Pqt/rEKIw=;
        b=GePuPRYgpXx8qSolvTrpRYqJTjQO7nvsqz8JiFar0jb9SeSRMe0Dhca6C2nT0HJT+V
         hsZAoUEE6s3CGjGZK47U7s960bgPCr4Ogmt4mPuQYx3X6hElXDbH61AKMYcqyMBFpp/+
         +Bx8YX/qTbxHOnC/LGaTmQI5jBVJBrkVBnrvOHLIPIKdiMTqN11r3M+7NQjrdQC/Jl49
         46YKZUWEi/mfl2uEi4rj5Zzf+T3K7VSGV+f5A9SwaskEo5lX8BHZ0UGvDpGvl22xX13J
         a6H6tq9wmYnt/UPQbAYrFyMk1Mz0dBytXQ2LzDJEC6qByDxMPo1NVS1YTYws5TUH0jJr
         89vA==
X-Received: by 10.180.83.105 with SMTP id p9mr3852821wiy.8.1402657996250;
        Fri, 13 Jun 2014 04:13:16 -0700 (PDT)
Received: from alberich ([2.174.235.98])
        by mx.google.com with ESMTPSA id s9sm1881692wix.13.2014.06.13.04.13.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 13 Jun 2014 04:13:15 -0700 (PDT)
Date:   Fri, 13 Jun 2014 13:13:12 +0200
From:   Andreas Herrmann <herrmann.der.user@googlemail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        James Hogan <james.hogan@imgtec.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        kvm@vger.kernel.org
Subject: Re: mips: Accidental removal of paravirt_cpus_done?
Message-ID: <20140613111312.GA25642@alberich>
References: <CAMuHMdWSXBw554dy4mTGu9dGbhtKCfVE1=13QP1ykV=BkkBrnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdWSXBw554dy4mTGu9dGbhtKCfVE1=13QP1ykV=BkkBrnw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <herrmann.der.user@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: herrmann.der.user@googlemail.com
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

On Fri, Jun 13, 2014 at 12:02:30PM +0200, Geert Uytterhoeven wrote:
> Hi Ralf,
> 
> It seems you accidentally assimilated an (unwanted?) kvm change in my
> patch:

Hi Geert,

Actually this change was wanted. After Ralf informed me about a
compile error in linux-next I've sent him an update for one of my
mips-paravirt patches.

Unfortunately that ended up in your (unrelated patch).


Andreas

> On Tue, Jun 10, 2014 at 3:31 AM, Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org> wrote:
> > Gitweb:     http://git.kernel.org/linus/;a=commit;h=5e888e8fb55cf3da870b85d04fef6bfe0d57c974
> > Commit:     5e888e8fb55cf3da870b85d04fef6bfe0d57c974
> > Parent:     a1eace4ba53546bc7a6670b1c380cd5c1287ae8b
> > Refname:    refs/heads/master
> > Author:     Geert Uytterhoeven <geert@linux-m68k.org>
> > AuthorDate: Tue Apr 22 12:51:13 2014 +0200
> > Committer:  Ralf Baechle <ralf@linux-mips.org>
> > CommitDate: Mon Jun 2 16:34:41 2014 +0200
> >
> >     mips: Update the email address of Geert Uytterhoeven
> >
> >     All my Sony addresses are defunct.
> >
> >     Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >     Cc: linux-mips@linux-mips.org
> >     Patchwork: https://patchwork.linux-mips.org/patch/6817/
> >     Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> > ---
> >  arch/mips/include/asm/nile4.h     |    2 +-
> >  arch/mips/paravirt/paravirt-smp.c |    5 -----
> >  arch/mips/pci/ops-pmcmsp.c        |    2 +-
> >  arch/mips/pci/ops-tx3927.c        |    2 +-
> >  4 files changed, 3 insertions(+), 8 deletions(-)
> 
> > diff --git a/arch/mips/paravirt/paravirt-smp.c b/arch/mips/paravirt/paravirt-smp.c
> > index 73a123e..0164b0c 100644
> > --- a/arch/mips/paravirt/paravirt-smp.c
> > +++ b/arch/mips/paravirt/paravirt-smp.c
> > @@ -99,10 +99,6 @@ static void paravirt_smp_finish(void)
> >         local_irq_enable();
> >  }
> >
> > -static void paravirt_cpus_done(void)
> > -{
> > -}
> > -
> >  static void paravirt_boot_secondary(int cpu, struct task_struct *idle)
> >  {
> >         paravirt_smp_gp[cpu] = (unsigned long)task_thread_info(idle);
> > @@ -141,7 +137,6 @@ struct plat_smp_ops paravirt_smp_ops = {
> >         .send_ipi_mask          = paravirt_send_ipi_mask,
> >         .init_secondary         = paravirt_init_secondary,
> >         .smp_finish             = paravirt_smp_finish,
> > -       .cpus_done              = paravirt_cpus_done,
> >         .boot_secondary         = paravirt_boot_secondary,
> >         .smp_setup              = paravirt_smp_setup,
> >         .prepare_cpus           = paravirt_prepare_cpus,
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
