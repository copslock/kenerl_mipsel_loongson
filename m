Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Dec 2010 08:23:54 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:42001 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491122Ab0LYHXu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Dec 2010 08:23:50 +0100
Received: by ywf7 with SMTP id 7so3593043ywf.36
        for <linux-mips@linux-mips.org>; Fri, 24 Dec 2010 23:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=6P7v4hOeqJepBh74tFI9txKeiR5UkC3DhhTV/AXmm6w=;
        b=Jv+KL1C8YxA28ONuqGlezavaPdc8xBcfRKw2XQ10H+sZqu+gSJcstia//naidPf8Tq
         qcOcJ81ESlfHR17LRZCZZ641aOkNboYBgr9dC0biy2Pn7V02wym3zXDhcfBjaJU/oHkO
         UZyk6fyOXaskMCSzYLKIrvPjzgiw8cimttIHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=gSC73ihWGYqAPsd4XZvuRjfMiJA1al0n5RJ1gFWC5dF1fO03F9nXb1vnwR7XTzklkC
         U/ZVGxp25tORd1HmHDQ2qVoqTkmmfPCeDi/8VUjXmXNlsmquBVreNOhav+GSDXqJ/eDl
         pZxHwIQairiC3OqiAFkL36IiwDS83tzxoWywE=
Received: by 10.150.52.20 with SMTP id z20mr14857239ybz.193.1293261822957;
        Fri, 24 Dec 2010 23:23:42 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id q33sm7686006yba.7.2010.12.24.23.23.39
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Dec 2010 23:23:41 -0800 (PST)
Subject: Re: SMTC support status in latest git head.
From:   Anoop P A <anoop.pa@gmail.com>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     STUART VENTERS <stuart.venters@adtran.com>,
        "Anoop P.A." <Anoop_P.A@pmc-sierra.com>, linux-mips@linux-mips.org
In-Reply-To: <4D152DFA.5090504@paralogos.com>
References: <8F242B230AD6474C8E7815DE0B4982D7179FB88D@EXV1.corp.adtran.com>
         <4D1492E0.5090407@paralogos.com>
         <1293201545.27661.55.camel@paanoop1-desktop>
         <4D14B3FA.5080304@paralogos.com>
         <1293206536.27661.63.camel@paanoop1-desktop>
         <4D152DFA.5090504@paralogos.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Sat, 25 Dec 2010 13:02:21 +0530
Message-ID: <1293262341.27661.188.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2010-12-24 at 15:34 -0800, Kevin D. Kissell wrote:
> Ah, well, at least we have a stackframe.h fix that preserves David's 
> performance tweak for the deeper pipelined processors.  In looking for 
> this, I did notice that someone did some modification to the SMTC clock 
> tick logic that I was skeptical had ever been tested.  If you've still 
> got that kernel binary handy, you might check to see if it boots with 
> maxtcs=1 maxvpes=1, maxtcs=2 maxvpes=1, and/or maxtcs=2 maxvpes=2.

Yes I have tried with various combinations of tcs and vpes. with
maxvpes=1 I can boot with a max of 4 TCS ( VPE0 has 4 TCs) .
However setting maxpes=2 and maxtcs=2 hangs pretty early.

Clock rate set to 600000000
console [ttyS0] enabled
Calibrating delay loop... 398.33 BogoMIPS (lpj=796672)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
Limit of 2 VPEs set
Limit of 2 TCs set
TLB of 64 entry pairs shared by 2 VPEs
VPE 0: TC 0, VPE 1: TC 1
IPI buffer pool of 32 buffers
CPU revision is: 00019548 ((null))
TC 1 going on-line as CPU 1
Brought up 2 CPUs

One strange observation is with maxtcs=3 and maxvpes=2 kernel boots all
the way. 

Again with maxtcs=5 and maxvpes=2 it hangs after switching to MIPS
clocksource.

I strongly suspect some issue with locking. I will dig the code early
next week.


> 
> Oh, yes, and Merry Christmas one and all!

Thank you ! ..

Everybody Happy Christmas.

> 
>              Regards,
> 
>              Kevin K.
> 
> On 12/24/10 8:02 AM, Anoop P A wrote:
> > On Fri, 2010-12-24 at 06:53 -0800, Kevin D. Kissell wrote:
> >> Excellent!  Now, does the attached patch (relative to 2.6.37.11) also
> >> fix things, while preserving the other fixes and performance enhancements?
> >>
> > I have tested that patch with 2.6.37 branch it well passes calibration
> > loop but hangs after switching to mips closource
> >
> > TC 6 going on-line as CPU 6
> > Brought up 7 CPUs
> > bio: create slab<bio-0>  at 0
> > SCSI subsystem initialized
> > Switching to clocksource MIPS
> >
> > I Presume this is a different issue as restoring older file didn't help
> > much to get rid of this hang.
> >
> > diff --git a/arch/mips/include/asm/stackframe.h
> > b/arch/mips/include/asm/stackframe.h
> > index 58730c5..7fc9f10 100644
> > --- a/arch/mips/include/asm/stackframe.h
> > +++ b/arch/mips/include/asm/stackframe.h
> > @@ -195,9 +195,9 @@
> >   		 * to cover the pipeline delay.
> >   		 */
> >   		.set	mips32
> > -		mfc0	v1, CP0_TCSTATUS
> > +		mfc0	v0, CP0_TCSTATUS
> >   		.set	mips0
> > -		LONG_S	v1, PT_TCSTATUS(sp)
> > +		LONG_S	v0, PT_TCSTATUS(sp)
> >   #endif /* CONFIG_MIPS_MT_SMTC */
> >   		LONG_S	$4, PT_R4(sp)
> >   		LONG_S	$5, PT_R5(sp)
> >
> >
> >> /K.
> >>
> >> On 12/24/10 6:39 AM, Anoop P A wrote:
> >>> Hi Kevin, Stuart ,
> >>>
> >>> Woohooo You guys spotted !.
> >>>
> >>>    http://git.linux-mips.org/?p=linux.git;a=commit;h=d5ec6e3c seems to be
> >>> the culprit
> >>>
> >>> Once I restored previous version of stackframe.h 2.6.33-stable started
> >>> booting !.
> >>>
> >>> Thanks,
> >>> Anoop
> >>>
> >>> On Fri, 2010-12-24 at 04:32 -0800, Kevin D. Kissell wrote:
> >>>> Thank you, Stuart!  I've spotted some definite breakage to SMTC between
> >>>> those versions.  In arch/mips/include/asm/stackframe.h, someone moved
> >>>> the store of the Status register value in SAVE_SOME (line 169 or 204,
> >>>> depending on the version) from two instructions after the mfc0 to a
> >>>> point after the #ifdef for SMTC, presumably to get better pipelining of
> >>>> the register access.  Unfortunately, the v1 register is also used in the
> >>>> SMTC-specific fragment to save TCStatus, so the Status value gets
> >>>> clobbered before it gets stored.  This will eventually result in the
> >>>> Status register getting a TCStatus value, which has some bits on common,
> >>>> but isn't identical and sooner or later Bad Things will happen.
> >>>>
> >>>> I'm a little surprised this wasn't caught by visual inspection of the patch.
> >>>>
> >>>> Possible solutions would include reverting the store of the CP0_STATUS
> >>>> value to the block above the #ifdef, or, to retain whatever performance
> >>>> advantage was obtained by moving the store downward, to use v0/$2
> >>>> instead of v1/$3, as the staging register for the TCStatus value.  I'd
> >>>> lean toward the second option, but I'm not in a position to test and
> >>>> submit a patch just now.
> >>>>
> >>>>                Regards,
> >>>>
> >>>>                Kevin K.
> >>>>
> >>>> On 12/23/10 1:09 PM, STUART VENTERS wrote:
> >>>>> Kevin,
> >>>>>
> >>>>> I'm not sure if it's useful,
> >>>>>       but finally I got the time to look at the two kernel versions Anoop pointed out.
> >>>>>        works   2.6.32-stable with patch 804
> >>>>>        works_not 2.6.33-stable
> >>>>>
> >>>>> greping for files with CONFIG_MIPS_MT_SMTC
> >>>>>       and looking for timer interrupt related stuff found the following differences:
> >>>>>
> >>>>>
> >>>>> arch/mips/include/asm/irq.h
> >>>>> arch/mips/kernel/irq.c
> >>>>>      do_IRQ
> >>>>>
> >>>>> arch/mips/include/asm/stackframe.h
> >>>>>      SAVE_SOME SAVE_TEMP get/set_saved_sp
> >>>>>
> >>>>> arch/mips/include/asm/time.h
> >>>>>      clocksource_set_clock
> >>>>>
> >>>>> arch/mips/kernel/process.c
> >>>>>      cpu_idle
> >>>>>
> >>>>> arch/mips/kernel/smtc.c
> >>>>>      __irq_entry
> >>>>>      ipi_decode
> >>>>>          SMTC_CLOCK_TICK
> >>>>>
> >>>>>
> >>>>> Enclosed are the two subsets of files for a more expert look.
> >>>>>
> >>>>> I'll try to look in more detail after Christmas.
> >>>>>
> >>>>>
> >>>>> Cheers,
> >>>>>
> >>>>> Stuart
> >>>>>
> >>>>>
> >>>>>
> >>>>>
> >
> 
