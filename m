Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2011 00:02:23 +0200 (CEST)
Received: from mail1.pearl-online.net ([62.159.194.147]:44735 "EHLO
        mail1.pearl-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491113Ab1IMWCO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Sep 2011 00:02:14 +0200
Received: from Mobile0.Peter (109.125.101.165.dynamic.cablesurf.de [109.125.101.165])
        by mail1.pearl-online.net (Postfix) with ESMTPA id 847C4202EE;
        Wed, 14 Sep 2011 00:02:09 +0200 (CEST)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
        by Mobile0.Peter (8.12.6/8.12.6/Sendmail/Linux 2.2.13) with ESMTP id p8DNeT31001119;
        Tue, 13 Sep 2011 23:40:29 GMT
Received: from Indigo2.Peter (localhost [127.0.0.1])
        by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.36-ip28) with ESMTP id p8DLWHnM000539;
        Tue, 13 Sep 2011 23:32:17 +0200
Received: from localhost (pf@localhost)
        by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id p8DLWH5S000536;
        Tue, 13 Sep 2011 23:32:17 +0200
X-Authentication-Warning: Indigo2.Peter: pf owned process doing -bs
Date:   Tue, 13 Sep 2011 23:32:17 +0200 (CEST)
From:   peter fuerst <post@pfrst.de>
X-X-Sender: pf@Indigo2.Peter
Reply-To: post@pfrst.de
To:     Joshua Kinard <kumba@gentoo.org>
cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        attilio.fiandrotti@gmail.com
Subject: Re (R8000...): Re: [PATCH] Impact video driver for SGI Indigo2
In-Reply-To: <4E6F4FFB.7050704@gentoo.org>
Message-ID: <Pine.LNX.4.64.1109132227130.435@Indigo2.Peter>
References: <Pine.LNX.4.64.1109111200400.4146@Indigo2.Peter>
 <4E6F4FFB.7050704@gentoo.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-archive-position: 31066
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6794



On Tue, 13 Sep 2011, Joshua Kinard wrote:

> Date: Tue, 13 Sep 2011 08:43:39 -0400
> From: Joshua Kinard <kumba@gentoo.org>
> To: post@pfrst.de
> Cc: linux-mips@linux-mips.org, ralf@linux-mips.org,
>     attilio.fiandrotti@gmail.com
> Subject: Re: [PATCH] Impact video driver for SGI Indigo2
> 
> ...
>
>> +# elif defined(CONFIG_SGI_IP26)
>> +#  define IPNR 26
>
Just to uphold hope ;)

> I don't think IP26 will ever live.  I think the old R8000 TLB code was
> removed a few years ago, too, so to get such systems to work, someone needs
> to actually have one (I do), resurrect the old code, add in the TLB pieces
> (the Manual is available, so this isn't beyond impossible now), and test it.
> But at 75MHz, these machines aren't exactly speed demons, compared even to
> an R10K I2.

But the R8000 is more exotic ;-) And there are SPEC FP benchmarks, where it
outperforms a 333MHz Alpha 21164 :-)

But (to me) it seems uncertain, whether enough information can be retrieved
to make this machine work. Consider alone the cache handling (same constraints
for uncached memory accesses on IP26 and IP28): the manual states nothing about
whether this processor has inerited R4k's cacheflush-ops. Looking at the sample
code for cache initialization there, i fear, such easy methods are not
available.

>
>> +    /* CFIFO parameters */
>> +    IMPACT_CFIFO_HW(mmio) = VAL_CFIFO_HW;
>> +    IMPACT_CFIFO_LW(mmio) = VAL_CFIFO_LW;
>> +    IMPACT_CFIFO_DELAY(mmio) = VAL_CFIFO_DELAY;
>
>
> If I recall correctly, doesn't IMPACT_CFIFO_* break down to a pointer
> dereference?

Yes.  (Above each address occurs only once, so no pointer-variables are used)

>               I was thinking it might be more readable to finally create a
> static inline function called impact_write* and impact_read* to take care of
> register access than doing pointer dereferences.

I had prepared such functions, which would replace the assignments, to handle
32Bit and 64Bit accesses to the card transparently. But, although the Xserver
shows, that at least a subset of 32Bit-accesses work, i came to the conclusion,
that the benefits from allowing 32Bit-accesses aren't worth the exertion.
Staying with 64Bit mode we can use the simple assignments and IMHO demanding
a 64Bit kernel for IP22-Impact isn't asking to much.

>                                                   I got dinged on this when
> trying to submit a driver for the RTC 1687-5 in O2 and Octane a few months ago.
>
>
>> +    *cfifo = IMPACT_CMD_COLORMASKLSBSA(0xffffff);
>> +    *cfifo = IMPACT_CMD_COLORMASKLSBSB(0xffffff);
>> +    *cfifo = IMPACT_CMD_COLORMASKMSBS(0);
>> +    *cfifo = IMPACT_CMD_XFRMASKLO(0xffffff);
>> +    *cfifo = IMPACT_CMD_XFRMASKHI(0xffffff);
>
>
> Ditto per the above.
>
>
> Don't have a working IP22 board anymore.  Haven't setup my old IP28 in a
> while, but it is intact and does have a SolidImpact in it.  I also have a
> working IP26 (as noted above), but I would be surprised if anyone ever
> tackled R8000 support, given the exotic nature of that CPU.
>
> Yell if you ever pick up an Octane -- I could use some help getting that
> beast to work again...
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
