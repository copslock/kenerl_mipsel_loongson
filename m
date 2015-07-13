Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 23:14:01 +0200 (CEST)
Received: from mail-wi0-f170.google.com ([209.85.212.170]:32909 "EHLO
        mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011113AbbGMVN7Dt0AV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 23:13:59 +0200
Received: by widic2 with SMTP id ic2so22755472wid.0
        for <linux-mips@linux-mips.org>; Mon, 13 Jul 2015 14:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nGwbsS+CK6iSXOw80NN4MTD/n9bpOKvQA+CU1PqYXWs=;
        b=kvJnuoRnKcJX08XUyU4uwot2ev1JPbq973lh+sKqeTZ5/i15j5gy7xt8NrVyD+tiyH
         6WkfVirDnhGZj8xeXFO0TFUI79AsvmQQaMzEkVjX2Xc6ZnPWtU7KxtwnxE3VLdzI8e0v
         pLKZD6yfIU2xzWw/Nzgt3jZENV+8InCAUY4VvNCM/SpfgafbxU2d8Q9lCI2xvOTCthF6
         CIlys5fPT4ecb6UmHjYHn7W3eEC3Mt7rZU01IAKdixwWwPmDw5mg4w4AJpxPqBchBmi6
         72deNAJdQyjnJbae5yUgt+VWCWbPyPqy0R0xLa0VCsu4z0GQo0WpkaRyJz0l22TVQQMx
         pSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=nGwbsS+CK6iSXOw80NN4MTD/n9bpOKvQA+CU1PqYXWs=;
        b=i1vPrVHYnwgeo5IDJitJcgIdQg+MyJ1I3yzTjaB4J8COuwIvUkBKfWc9iOZetXTWUF
         NV2E4Ze8GO2WrcPWUcUEOVHfk+p/RjYdvPdkAJXfQLOty9zMvUarx+6sP8lbQmhZIKoe
         9ERm+V6jhlozMmjyHgTOgBvPp/NVBvdTFXOqyF+GNjn7c1DRZ9XFLNA1Yfc45cgAVGme
         UYyFlo8SZr6Qgek8+r2RlJkJusQEuGj1YIJy7Iixn/39gkYTFqh8BrgmUlhfMBvqV9dH
         U/ZuH54sVMESR0qJarRwrdbd0UmGTgCGpvAr0y/fJ7Rz5tKTUMWNgyT8D8r6ocIIb5ry
         Si9A==
X-Gm-Message-State: ALoCoQnaYgKRtW00cLU6hyaPhpyakfDo88szGyxo68eFfuMLFwMHycrd1BBL1cUJxLvYWabDGFe0
X-Received: by 10.180.91.76 with SMTP id cc12mr27468209wib.67.1436822033755;
 Mon, 13 Jul 2015 14:13:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.210.74 with HTTP; Mon, 13 Jul 2015 14:13:34 -0700 (PDT)
In-Reply-To: <55A3885A.5010002@imgtec.com>
References: <20150712230402.11177.11848.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150712231129.11177.40742.stgit@bhelgaas-glaptop2.roam.corp.google.com> <55A3885A.5010002@imgtec.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 13 Jul 2015 16:13:34 -0500
Message-ID: <CAErSpo7NMNxe=B8BJMkr1SQ0xEshoiWsiUs1hJ+UgY=7eedYPQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] MIPS: Remove "weak" from get_c0_perfcount_int() declaration
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

On Mon, Jul 13, 2015 at 10:43:54AM +0100, James Hogan wrote:
> On 13/07/15 00:11, Bjorn Helgaas wrote:
> > Weak header file declarations are error-prone because they make every
> > definition weak, and the linker chooses one based on link order (see
> > 10629d711ed7 ("PCI: Remove __weak annotation from pcibios_get_phb_of_node
> > decl")).
> >
> > get_c0_perfcount_int() is defined in several files.  Every definition is
> > weak, so I assume Kconfig prevents two or more from being included.  The
> > callers contain identical default code used when get_c0_perfcount_int()
> > isn't defined at all.
> >
> > Add a weak get_c0_perfcount_int() definition with the default code and
> > remove the weak annotation from the declaration.
> >
> > Then the platform implementations will be strong and will override the weak
> > default.  If multiple platforms are ever configured in, we'll get a link
> > error instead of calling a random platform's implementation.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > CC: Andrew Bresticker <abrestic@chromium.org>
> > ---
> >  arch/mips/include/asm/time.h         |    2 +-
> >  arch/mips/kernel/perf_event_mipsxx.c |    7 +------
> >  arch/mips/kernel/time.c              |   10 +++++++++-
> >  arch/mips/oprofile/op_model_mipsxx.c |    8 +-------
> >  4 files changed, 12 insertions(+), 15 deletions(-)
> >
> > diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
> > index 8ab2874..ce6a7d5 100644
> > --- a/arch/mips/include/asm/time.h
> > +++ b/arch/mips/include/asm/time.h
> > @@ -46,7 +46,7 @@ extern unsigned int mips_hpt_frequency;
> >   * so it lives here.
> >   */
> >  extern int (*perf_irq)(void);
> > -extern int __weak get_c0_perfcount_int(void);
> > +extern int get_c0_perfcount_int(void);
> >
> >  /*
> >   * Initialize the calling CPU's compare interrupt as clockevent device
> > diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
> > index cc1b6fa..c126b1c 100644
> > --- a/arch/mips/kernel/perf_event_mipsxx.c
> > +++ b/arch/mips/kernel/perf_event_mipsxx.c
> > @@ -1682,12 +1682,7 @@ init_hw_perf_events(void)
> >   counters = counters_total_to_per_cpu(counters);
> >  #endif
> >
> > - if (get_c0_perfcount_int)
> > - irq = get_c0_perfcount_int();
> > - else if (cp0_perfcount_irq >= 0)
> > - irq = MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
> > - else
> > - irq = -1;
> > + irq = get_c0_perfcount_int();
> >
> >   mipspmu.map_raw_event = mipsxx_pmu_map_raw_event;
> >
> > diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
> > index 8d01709..ec7082d 100644
> > --- a/arch/mips/kernel/time.c
> > +++ b/arch/mips/kernel/time.c
> > @@ -55,9 +55,17 @@ static int null_perf_irq(void)
> >  }
> >
> >  int (*perf_irq)(void) = null_perf_irq;
> > -
> >  EXPORT_SYMBOL(perf_irq);
> >
> > +#ifdef MIPS_CPU_IRQ_BASE
>
> why the ifdef? This would be the only such ifdef in the kernel, and
> arch/mips/include/asm/mach-generic/irq.h seems to ensure it is always
> defined anyway.

I added the ifdef because I got a build error in
arch/mips/kernel/time.c.  But maybe I can fix that by including
<asm/irq.h> instead; that would be much nicer.

> > +int __weak get_c0_perfcount_int(void)
> > +{
> > + if (cp0_perfcount_irq >= 0)
> > + return MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
> > + return -1;
> > +}
> > +#endif
