Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2011 00:02:49 +0200 (CEST)
Received: from mail1.pearl-online.net ([62.159.194.147]:44736 "EHLO
        mail1.pearl-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491110Ab1IMWCO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Sep 2011 00:02:14 +0200
Received: from Mobile0.Peter (109.125.101.165.dynamic.cablesurf.de [109.125.101.165])
        by mail1.pearl-online.net (Postfix) with ESMTPA id C2E4D20351;
        Wed, 14 Sep 2011 00:02:09 +0200 (CEST)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
        by Mobile0.Peter (8.12.6/8.12.6/Sendmail/Linux 2.2.13) with ESMTP id p8DNeT33001119;
        Tue, 13 Sep 2011 23:40:30 GMT
Received: from Indigo2.Peter (localhost [127.0.0.1])
        by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.36-ip28) with ESMTP id p8DKR0nM000486;
        Tue, 13 Sep 2011 22:27:00 +0200
Received: from localhost (pf@localhost)
        by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id p8DKR0iH000483;
        Tue, 13 Sep 2011 22:27:00 +0200
X-Authentication-Warning: Indigo2.Peter: pf owned process doing -bs
Date:   Tue, 13 Sep 2011 22:27:00 +0200 (CEST)
From:   peter fuerst <post@pfrst.de>
X-X-Sender: pf@Indigo2.Peter
Reply-To: post@pfrst.de
To:     Joshua Kinard <kumba@gentoo.org>
cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        attilio.fiandrotti@gmail.com
Subject: Re (early con): Re: [PATCH] Impact video driver for SGI Indigo2
In-Reply-To: <4E6F4FFB.7050704@gentoo.org>
Message-ID: <Pine.LNX.4.64.1109132105110.435@Indigo2.Peter>
References: <Pine.LNX.4.64.1109111200400.4146@Indigo2.Peter>
 <4E6F4FFB.7050704@gentoo.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-archive-position: 31067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6734



Hello,

On Tue, 13 Sep 2011, Joshua Kinard wrote:

> Date: Tue, 13 Sep 2011 08:43:39 -0400
> From: Joshua Kinard <kumba@gentoo.org>
> To: post@pfrst.de
> Cc: linux-mips@linux-mips.org, ralf@linux-mips.org,
>     attilio.fiandrotti@gmail.com
> Subject: Re: [PATCH] Impact video driver for SGI Indigo2
> 
> On 09/11/2011 07:14, peter fuerst wrote:
>
>> +#ifndef CONFIG_EARLY_PRINTK
>> +        if (ctype && strstr(ctype, "impact=early"))
>> +#endif
+			setup_impact_earlycons();

>
> I think we can gut all the Impact early printk stuff.  Per Skylark, to use
> it, you have to drop a function call into arch/mips/kernel/setup.c and
> kernel/printk.c,

It's the setup_impact_earlycons() call in ip22-setup.c above. In so far the
patch is complete, one can leave setup.c and printk.c alone.

Depending on the situation, ip22-setup.c may not be early enough. The
setup_impact_earlycons-call could be moved near to the beginning of
start_kernel() (init/main.c), it doesn't depend on non-static kernel setup.
But this had to be done by hand, it won't be in the regular source.
So, given the intended purpose of the early console - providing helpfull
information simply by a boot option to a potential bug report by an user,
who has no inclination to kernel hacking, just wants to use the kernel out
of the box - early console may or may not be usefull.

>                  so I don't think this is an easily-used feature.  In my
> patchset for Gentoo's mips-sources, I actually broke both Impact and
> Odyssey's early console bits out as separate drivers applied as patches if
> one forces a debug mode on.

Do you intend to submit these drivers?  Anyway i will separate the early
console stuff from the "basic" Impact-patch, when i resubmit the patches,
so it's optional and can be discussed independently.

>                              Because they're not really even real
> consoles....just a way to get output out of offbeat systems like Octane,
> which hides all the good stuff behind the broken (horifically broken) IOC3
> metadevice.
>
> Unless you've come up with a better way to do early printk that can work
> shortly after the CPUs are brought up?

No regular/every-day usable method, only debug-hackery:
Moving the setup_impact_earlycons-call to start_kernel() or using a specially
tailored ARCS-console, which in addition allows to capture kernel output via
serial line (and helped me debugging for long).
(BTW: in recent kernels any ARCS-console must be switched off very early,
while in e.g. 2.6.14 it could be used until Impact or IP22Zilog take over)

>
>
> ...
>
>
> -- 
> Joshua Kinard
> Gentoo/MIPS
> kumba@gentoo.org
> 4096R/D25D95E3 2011-03-28
>
> "The past tempts us, the present confuses us, the future frightens us.  And
> our lives slip away, moment by moment, lost in that vast, terrible in-between."
>
> --Emperor Turhan, Centauri Republic
>
>

kind regards

peter
