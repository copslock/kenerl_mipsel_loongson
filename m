Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2007 11:29:56 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:31717 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S20024666AbXIDK3r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Sep 2007 11:29:47 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id l84ATfGf001857;
	Tue, 4 Sep 2007 03:29:41 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 4 Sep 2007 03:29:41 -0700
Received: from [128.224.162.180] ([128.224.162.180]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 4 Sep 2007 03:29:38 -0700
Subject: Re: [PATCH] malta4kec hang in calibrate_delay fix
From:	yshi <yang.shi@windriver.com>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <006901c7eeda$d8049a50$10eca8c0@grendel>
References: <46DD1CD1.5040306@windriver.com>
	 <006901c7eeda$d8049a50$10eca8c0@grendel>
Content-Type: text/plain; charset=utf-8
Date:	Tue, 04 Sep 2007 18:32:31 +0800
Message-Id: <1188901951.4106.16.camel@yshi.CORP>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 04 Sep 2007 10:29:38.0916 (UTC) FILETIME=[7F4B9A40:01C7EEDE]
Return-Path: <Yang.Shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
Precedence: bulk
X-list: linux-mips

在 2007-09-04二的 12:03 +0200，Kevin D. Kissell写道：
> The 4KEc is a MIPS32 Release 2 processor, for which the implementation
> of the Cause.TI bit (bit 30) is required.  You may have a defective board
> or a bad FPGA bitfile.  Please work with your support contacts at MIPS
> to verify that this is not the case.  It may also be that there's something more
> subtle going on in the interrupt processing, such that the Cause.TI bit is being
> cleared before it can be sampled by the code you've changed.  But while the
> patch below presumably solves the symptoms of your problem, I really
> don't think that a kernel hack based on detecting CoreFPA3 is an appropriate
> solution.  I work every day with Malta/CoreFPGA3 bitfiles and have not
> seen Cause.TI fail to function in any of the Release 2 core bitfiles I've used.
My board's core is Release 1 core. So Cause.TI bit always is zero. Maybe
I need update this patch to reflect this, i.e add #ifdef to distinguish
Release 1 and Release 2. Thanks.

Best Regards,
Yang Shi
> 
>             Regards,
> 
>             Kevin K.
> 
> ----- Original Message ----- 
> From: "yshi" <yang.shi@windriver.com>
> To: <linux-mips@linux-mips.org>
> Sent: Tuesday, September 04, 2007 10:52 AM
> Subject: [PATCH] malta4kec hang in calibrate_delay fix
> 
> 
> > perfmon2 patch changed timer interrupt handler of malta board.
> > When kernel handles timer interrupt, interrupt handler will read 30 bit
> > of cause register. If this bit is zero, timer interrupt handler will
> > exit, won't really handle interrupt. Because Malta 4kec board's core
> > revision is CoreFPGA-3, this core's cause register doesn't implement 30
> > bit, so kernel always read zero from this bit. This will cause kernel
> > hang in calibrate_delay.
> > 
> > Signed-off-by: Yang Shi <yang.shi@windriver.com>
> > ---
> > b/arch/mips/mips-boards/generic/time.c |   17 ++++++++++++-----
> > 1 file changed, 12 insertions(+), 5 deletions(-)
> > ---
> > 
> > --- a/arch/mips/mips-boards/generic/time.c
> > +++ b/arch/mips/mips-boards/generic/time.c
> > @@ -136,11 +136,13 @@ irqreturn_t mips_timer_interrupt(int irq
> > #else /* CONFIG_MIPS_MT_SMTC */
> >       int r2 = cpu_has_mips_r2;
> > 
> > -       if (handle_perf_irq(r2))
> > -               goto out;
> > +       if (mips_revision_corid != MIPS_REVISION_CORID_CORE_FPGA3) {
> > +               if (handle_perf_irq(r2))
> > +                       goto out;
> > 
> > -       if (r2 && ((read_c0_cause() & (1 << 30)) == 0))
> > -               goto out;
> > +               if (r2 && ((read_c0_cause() & (1 << 30)) == 0))
> > +                       goto out;
> > +       }
> > 
> >       if (cpu == 0) {
> >               /*
> > @@ -294,7 +296,12 @@ void __init plat_timer_setup(struct irqa
> >       {
> >               if (cpu_has_vint)
> >                       set_vi_handler(cp0_compare_irq, mips_timer_dispatch);
> > -               mips_cpu_timer_irq = MIPS_CPU_IRQ_BASE + cp0_compare_irq;
> > +
> > +               if (mips_revision_corid != MIPS_REVISION_CORID_CORE_FPGA3)
> > +                       mips_cpu_timer_irq = MIPS_CPU_IRQ_BASE + 
> > cp0_compare_irq;
> > +               else
> > +                       mips_cpu_timer_irq = MIPS_CPU_IRQ_BASE +
> > +                                            CP0_LEGACY_COMPARE_IRQ;
> >       }
> > 
> >       /* we are using the cpu counter for timer interrupts */
> > 
> > 
