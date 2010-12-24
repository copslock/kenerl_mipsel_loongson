Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Dec 2010 15:30:53 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:50272 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491081Ab0LXOau (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Dec 2010 15:30:50 +0100
Received: by gxk27 with SMTP id 27so3838311gxk.36
        for <linux-mips@linux-mips.org>; Fri, 24 Dec 2010 06:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=A4nk52Jz8pr4arWTtEIM09MPPNDissjfKWbAXJuRmQU=;
        b=Y5DlpO1vbH/pJz8rcGGRi2NVx8nSe5JNmdzjj6tf/LBiOGBo1hvQQffx/GdWIlpEAU
         mXaYFSF7nuDRR1sIX2M/C7LWUnPY9OSBOvClKEy9cyK0Kz3BKaGIJbwxs24aqN3U5n2V
         ur9C7gnLm9ciV3HNPwKoISXekT67qn4cZGvHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=eE4aFkMVHoHK9XxmfoDjjglXSgohHHzNev8NWvUIi5AJqUYm5VetZfrsiwAR4zMwOu
         3g6DMQpT9OrLQxIsTBtYCVZKdAl+PNP492saxvMZxLIRKSWACKUl3SkH2/tkpGiQP8ea
         2Ym41YpmWiNY3m7Yfp2kYMH8137fatddhR6kI=
Received: by 10.90.219.8 with SMTP id r8mr853953agg.49.1293201039251;
        Fri, 24 Dec 2010 06:30:39 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id c7sm13881416ana.17.2010.12.24.06.30.35
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Dec 2010 06:30:37 -0800 (PST)
Subject: Re: SMTC support status in latest git head.
From:   Anoop P A <anoop.pa@gmail.com>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     STUART VENTERS <stuart.venters@adtran.com>,
        "Anoop P.A." <Anoop_P.A@pmc-sierra.com>, linux-mips@linux-mips.org
In-Reply-To: <4D1492E0.5090407@paralogos.com>
References: <8F242B230AD6474C8E7815DE0B4982D7179FB88D@EXV1.corp.adtran.com>
         <4D1492E0.5090407@paralogos.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 24 Dec 2010 20:09:05 +0530
Message-ID: <1293201545.27661.55.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Kevin, Stuart ,

Woohooo You guys spotted !.

 http://git.linux-mips.org/?p=linux.git;a=commit;h=d5ec6e3c seems to be
the culprit

Once I restored previous version of stackframe.h 2.6.33-stable started
booting !.

Thanks,
Anoop

On Fri, 2010-12-24 at 04:32 -0800, Kevin D. Kissell wrote:
> Thank you, Stuart!  I've spotted some definite breakage to SMTC between 
> those versions.  In arch/mips/include/asm/stackframe.h, someone moved 
> the store of the Status register value in SAVE_SOME (line 169 or 204, 
> depending on the version) from two instructions after the mfc0 to a 
> point after the #ifdef for SMTC, presumably to get better pipelining of 
> the register access.  Unfortunately, the v1 register is also used in the 
> SMTC-specific fragment to save TCStatus, so the Status value gets 
> clobbered before it gets stored.  This will eventually result in the 
> Status register getting a TCStatus value, which has some bits on common, 
> but isn't identical and sooner or later Bad Things will happen.
> 
> I'm a little surprised this wasn't caught by visual inspection of the patch.
> 
> Possible solutions would include reverting the store of the CP0_STATUS 
> value to the block above the #ifdef, or, to retain whatever performance 
> advantage was obtained by moving the store downward, to use v0/$2 
> instead of v1/$3, as the staging register for the TCStatus value.  I'd 
> lean toward the second option, but I'm not in a position to test and 
> submit a patch just now.
> 
>              Regards,
> 
>              Kevin K.
> 
> On 12/23/10 1:09 PM, STUART VENTERS wrote:
> > Kevin,
> >
> > I'm not sure if it's useful,
> >     but finally I got the time to look at the two kernel versions Anoop pointed out.
> >      works   2.6.32-stable with patch 804
> >      works_not 2.6.33-stable
> >
> > greping for files with CONFIG_MIPS_MT_SMTC
> >     and looking for timer interrupt related stuff found the following differences:
> >
> >
> > arch/mips/include/asm/irq.h
> > arch/mips/kernel/irq.c
> >    do_IRQ
> >
> > arch/mips/include/asm/stackframe.h
> >    SAVE_SOME SAVE_TEMP get/set_saved_sp
> >
> > arch/mips/include/asm/time.h
> >    clocksource_set_clock
> >
> > arch/mips/kernel/process.c
> >    cpu_idle
> >
> > arch/mips/kernel/smtc.c
> >    __irq_entry
> >    ipi_decode
> >        SMTC_CLOCK_TICK
> >
> >
> > Enclosed are the two subsets of files for a more expert look.
> >
> > I'll try to look in more detail after Christmas.
> >
> >
> > Cheers,
> >
> > Stuart
> >
> >
> >
> >
> 
