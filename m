Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2018 22:48:04 +0100 (CET)
Received: from mail-ua1-x944.google.com ([IPv6:2607:f8b0:4864:20::944]:33823
        "EHLO mail-ua1-x944.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991034AbeJaVryeXR34 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Oct 2018 22:47:54 +0100
Received: by mail-ua1-x944.google.com with SMTP id e16so6527656uam.1
        for <linux-mips@linux-mips.org>; Wed, 31 Oct 2018 14:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9OZBU7xBbZRq91LmWRsKb1e+HamrGUSqJjfkZGsW5iY=;
        b=hRfi3Kd5G9/BLYolaPFaixRBSy8QElOUfTm0fyNwi5G2el/3A087MYoMPAXTtCvmr6
         aqtzB3yUpqwbaMtfyXn9KPe/xCBryhqzS5lXRDQiilI7KlDKS9tpNMeE3EhIpseZtToC
         y5ZSqIZ1fBG/MJmna3J4vq+E8lJ01mfbgfTEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9OZBU7xBbZRq91LmWRsKb1e+HamrGUSqJjfkZGsW5iY=;
        b=XWV8JI6rj3/P5HSDPgmMtPBvtz/MkvnuRRFvuWkhLVUdNMhhkFVZvt4LNitKwditB+
         8gulHKEegpMA3+JOsf+wqlTMS6RPDnOaOp2EbC4OCPVuLp6AVtSYkq9cfLxnpoVAkB7x
         d8nrFfMgoLgPs42Q1RdsPTzVpsgbiosuml2rLvlTYwbklBPfufwP8MmMJNlrTXmgbaZl
         7ahsxJOUTS0jmyGrc7+eFvEuOMZV3mR9jBmbUNQ2ZWd9pBzWk6O+SekREdITLf4BFxJ5
         dSPVlmbeXOhY6oDL5Gf/gt2+0/YudnbvtABeIXT4x0JrZSfKS7kHHCq5BWMjTyEZoXrz
         l0ZA==
X-Gm-Message-State: AGRZ1gLOUc5bGZpius4A6g7yOSV6vcuA1hVyPSRjt9sqDV89qx+dRm6N
        9g983rNSUf+zeJ2avzvs2BFBqr+cXcA=
X-Google-Smtp-Source: AJdET5dk/E2EnGJ2U+BW+EByt3pPtJgKJ1xgsrwwIYjVDt7wg14ADAYmu0NGTF09wXq4hd/Cxr3L0A==
X-Received: by 2002:ab0:812:: with SMTP id a18mr2329754uaf.135.1541022473477;
        Wed, 31 Oct 2018 14:47:53 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id z10sm5773100uao.10.2018.10.31.14.47.53
        for <linux-mips@linux-mips.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 14:47:53 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id e126so11015409vsc.9
        for <linux-mips@linux-mips.org>; Wed, 31 Oct 2018 14:47:53 -0700 (PDT)
X-Received: by 2002:a67:6642:: with SMTP id a63mr2174631vsc.42.1541022087194;
 Wed, 31 Oct 2018 14:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181030221843.121254-1-dianders@chromium.org>
 <20181030221843.121254-3-dianders@chromium.org> <20181031184050.sd5opni3mznaapkv@holly.lan>
In-Reply-To: <20181031184050.sd5opni3mznaapkv@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 31 Oct 2018 14:41:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V1eHo7Wz31DTMMNi394qwEaESTxJCYVE60Q7hpDEqRmQ@mail.gmail.com>
Message-ID: <CAD=FV=V1eHo7Wz31DTMMNi394qwEaESTxJCYVE60Q7hpDEqRmQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>, jhogan@kernel.org,
        linux-hexagon@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>, dalias@libc.org,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-snps-arc@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will.deacon@arm.com>, paulus@samba.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        christophe.leroy@c-s.fr, mpe@ellerman.id.au, paul.burton@mips.com,
        LKML <linux-kernel@vger.kernel.org>, rkuo@codeaurora.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <dianders@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dianders@chromium.org
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

Hi,

On Wed, Oct 31, 2018 at 11:40 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Oct 30, 2018 at 03:18:43PM -0700, Douglas Anderson wrote:
> > diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> > index f3cadda45f07..9a3f952de6ed 100644
> > --- a/kernel/debug/debug_core.c
> > +++ b/kernel/debug/debug_core.c
> > @@ -55,6 +55,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/vmacache.h>
> >  #include <linux/rcupdate.h>
> > +#include <linux/irq.h>
> >
> >  #include <asm/cacheflush.h>
> >  #include <asm/byteorder.h>
> > @@ -220,6 +221,39 @@ int __weak kgdb_skipexception(int exception, struct pt_regs *regs)
> >       return 0;
> >  }
> >
> > +/*
> > + * Default (weak) implementation for kgdb_roundup_cpus
> > + */
> > +
> > +static DEFINE_PER_CPU(call_single_data_t, kgdb_roundup_csd);
> > +
> > +void __weak kgdb_call_nmi_hook(void *ignored)
> > +{
> > +     kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
> > +}
> > +
> > +void __weak kgdb_roundup_cpus(void)
> > +{
> > +     call_single_data_t *csd;
> > +     int cpu;
> > +
> > +     for_each_cpu(cpu, cpu_online_mask) {
> > +             csd = &per_cpu(kgdb_roundup_csd, cpu);
> > +             smp_call_function_single_async(cpu, csd);
> > +     }
>
> smp_call_function() automatically skips the calling CPU but this code does
> not. It isn't a hard bug since kgdb_nmicallback() does a re-entrancy
> check but I'd still prefer to skip the calling CPU.

I'll incorporate this into the next version.


> As mentioned in another part of the thread we can also add robustness
> by skipping a cpu where csd->flags != 0 (and adding an appropriately
> large comment regarding why). Doing the check directly is abusing
> internal knowledge that smp.c normally keeps to itself so an accessor
> of some kind would be needed.

Sure.  I could add smp_async_func_finished() that just looked like:

int smp_async_func_finished(call_single_data_t *csd)
{
  return !(csd->flags & CSD_FLAG_LOCK);
}

My understanding of all the mutual exclusion / memory barrier concepts
employed by smp.c is pretty weak, though.  I'm hoping that it's safe
to just access the structure and check the bit directly.

...but do you think adding a generic accessor like this is better than
just keeping track of this in kgdb directly?  I could avoid the
accessor by adding a "rounding_up" member to "struct
debuggerinfo_struct" and doing something like this in roundup:

  /* If it didn't round up last time, don't try again */
  if (kgdb_info[cpu].rounding_up)
    continue

  kgdb_info[cpu].rounding_up = true
  smp_call_function_single_async(cpu, csd);

...and then in kgdb_nmicallback() I could just add:

  kgdb_info[cpu].rounding_up = false

In that case we're not adding a generic accessor to smp.c that most
people should never use.


I'll wait to hear back from you if you think the accessor is OK.  It
seems like it might be nice not to have to add something to smp.c just
for this one use case.


> > +}
> > +
> > +static void kgdb_generic_roundup_init(void)
> > +{
> > +     call_single_data_t *csd;
> > +     int cpu;
> > +
> > +     for_each_possible_cpu(cpu) {
> > +             csd = &per_cpu(kgdb_roundup_csd, cpu);
> > +             csd->func = kgdb_call_nmi_hook;
> > +     }
> > +}
>
> I can't help noticing this code is very similar to kgdb_roundup_cpus. Do
> we really gain much from ahead-of-time initializing csd->func?

Oh!  Right...  At first I thought about just trying to put the "csd"
on the stack in kgdb_roundup_cpus() but then I realized that it needed
to persist past the end of kgdb_roundup_cpus().  ...and once I gave up
on the idea of putting it on the stack I decided I needed the init.

...but you're right that I don't really.  The only thing I'm initting
is the function pointer and it totally wouldn't hurt to just init that
over and over again every time kgdb_roundup_cpus() is called.

-Doug
