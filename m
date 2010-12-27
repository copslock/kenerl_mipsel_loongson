Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Dec 2010 18:10:50 +0100 (CET)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:35410 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491005Ab0L0RKr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Dec 2010 18:10:47 +0100
Received: by vws5 with SMTP id 5so3477151vws.36
        for <linux-mips@linux-mips.org>; Mon, 27 Dec 2010 09:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=yRXcmhw0DBuO0N95gTcmVLKNHIs5TyS6lbn03ooxlIM=;
        b=PCCSiyt/O/ydUUUyJyzixppzNOZK+XxZnwaS0SMjkC3q/dAGb2O49pWez/XRud4Pm5
         syeHlgbml+4HJCyWP1AtGVuZeyAmIgHn8wzonhT3PZhYUp7tZjy/LoArbAX42jCHbS7B
         HIBGA/XB1giUNOR6kc0aJmY1DZA8uxqu8EszU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=EVGzFSfpY1LkQSDQKjEekeRFvknpfy6xI7mSz5p5pAWhn88lacAS+v62xMFuC3krLA
         w7tFcTl7wMEU4dFZrJ3o45ZhNegSDt72rz5nbUsX0M4oFuy0jQ0AYEEK7spDpmQ2oKIn
         7crZdvYfAxXJd682T3NER6XKN3zVAH6g/62hg=
Received: by 10.220.202.134 with SMTP id fe6mr3377917vcb.245.1293469839044;
        Mon, 27 Dec 2010 09:10:39 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id e10sm271126vch.19.2010.12.27.09.10.34
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 27 Dec 2010 09:10:37 -0800 (PST)
Subject: RE: SMTC support status in latest git head.
From:   Anoop P A <anoop.pa@gmail.com>
To:     STUART VENTERS <stuart.venters@adtran.com>
Cc:     "Kevin D. Kissell" <kevink@paralogos.com>,
        "Anoop P.A." <Anoop_P.A@pmc-sierra.com>, linux-mips@linux-mips.org
In-Reply-To: <8F242B230AD6474C8E7815DE0B4982D7179FB88F@EXV1.corp.adtran.com>
References: <8F242B230AD6474C8E7815DE0B4982D7179FB88F@EXV1.corp.adtran.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Mon, 27 Dec 2010 22:49:52 +0530
Message-ID: <1293470392.27661.202.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Kevin,

It is very unlikely that the patch you pointed has any impact on the the
hang I am seeing. The patch you have mentioned got into kernel around
2.6.32 timeframe. I am able to boot both 2.6.32 and  2.6.33 kernel ( +
stackframe patch) . 

Hi Stuart,

I haven't got much time to spend on this today.

I had got 2.6.36-stable(+ stack frame patch) booting last day and I have
observed hang issue with 2.6.37-rc1 ( Same as rc6 and current git head)

So probably some patches in 2.6.37 branch introduced this hang.

Hopefully I will get some free slot tomorrow so that I can look into
code diff .

Thanks
Anoop

On Mon, 2010-12-27 at 09:49 -0600, STUART VENTERS wrote:
> Kevin,
> 
> Outstanding, sometimes it's better to be lucky than good.
> 
> 
> Anoop,
> 
> Maybe we can get lucky again.
> 
> If you can isolate the .33 works/.37 works_not bug to a specific pair of versions, 
>    I'll be happy to do another diff.
> 
> 
> Hope you'll have had a good Christmas as well.
>   We've had snow in Alabama since Christmas eve!
> 
> 
> Regards,
> 
> Stuart
> 
> 
> -----Original Message-----
> From: Kevin D. Kissell [mailto:kevink@paralogos.com]
> Sent: Friday, December 24, 2010 5:34 PM
> To: Anoop P A
> Cc: STUART VENTERS; Anoop P.A.; linux-mips@linux-mips.org
> Subject: Re: SMTC support status in latest git head.
> 
> 
> Ah, well, at least we have a stackframe.h fix that preserves David's 
> performance tweak for the deeper pipelined processors.  In looking for 
> this, I did notice that someone did some modification to the SMTC clock 
> tick logic that I was skeptical had ever been tested.  If you've still 
> got that kernel binary handy, you might check to see if it boots with 
> maxtcs=1 maxvpes=1, maxtcs=2 maxvpes=1, and/or maxtcs=2 maxvpes=2.
> 
> Oh, yes, and Merry Christmas one and all!
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
