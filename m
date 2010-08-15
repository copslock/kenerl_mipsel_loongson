Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Aug 2010 18:00:14 +0200 (CEST)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:37931 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491038Ab0HOQAK convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 15 Aug 2010 18:00:10 +0200
Received: by qwe4 with SMTP id 4so4748290qwe.36
        for <linux-mips@linux-mips.org>; Sun, 15 Aug 2010 09:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cGAElgvGcakb6UMOg/tPjHsAcYotguqHFMmlfrErspA=;
        b=uxThSP4B2u0XmsGwgvevv/8bG/tIDy7kVFLrzmv1NHfrex1xVQ/33Iw7x+jovjWLAL
         4/Vj10piExhuUsgIq28XrT1K1rkgovK0MCmrqc4zItBaPKJZ2nBSFSZUhOiQUvBbgy6v
         3WudbsnTJKoOVVGaK0OYphdN/W241MTYrmra8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RmnPOAYp+S5Nke0aDTyXc448fiRbwmv7/XUz9WNOaNL5PyWW/3z4NaNwEZ/xpFxk3W
         ECZZtiT2h6NJcXtTjl/TWcdZfwLfiy7Xz9nsN+2/LkSUGDOcVEsgJsrJbA5DI5cebPeL
         iAuccYPkAN2AuTNWEYCXaHgM0gr+YObxvqhDs=
MIME-Version: 1.0
Received: by 10.229.215.76 with SMTP id hd12mr2930705qcb.44.1281888003603;
 Sun, 15 Aug 2010 09:00:03 -0700 (PDT)
Received: by 10.229.55.69 with HTTP; Sun, 15 Aug 2010 09:00:03 -0700 (PDT)
In-Reply-To: <AANLkTimm2NMwu8_OjqdWvcJ11KFzBiz8VTGgYwAcemhf@mail.gmail.com>
References: <AANLkTik5o+LsApwvkDTb7z+k=Ls60h9PJugrvM7ozO=p@mail.gmail.com>
        <AANLkTimm2NMwu8_OjqdWvcJ11KFzBiz8VTGgYwAcemhf@mail.gmail.com>
Date:   Mon, 16 Aug 2010 00:00:03 +0800
Message-ID: <AANLkTimVkN_SaHpkc4cFiSvfTZqGXiigkYsQaNFcx08q@mail.gmail.com>
Subject: Re: Clock Source in hrtimer
From:   "wilbur.chan" <wilbur512@gmail.com>
To:     wu zhangjin <wuzhangjin@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27618
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

Hi wu,

2010/8/15 wu zhangjin <wuzhangjin@gmail.com>:

>
> don't worry about it, the timekeeper solves it:
>
> kernel/time/timekeeping.c
>
> The r4k timer in most of the MIPS variants also only has a 32bits
> counter register, no problem with it:
>
> arch/mips/kernel/csrc-r4k.c
> arch/mips/kernel/cevt-r4k.c
>
> does  xlr 732 also use such a timer (with MIPS count & compare
> registers of coprocessor0)?
>

yes, xlr732  use these two registers to generate timer interrupt,
with a frequency of 1GHZ



> If you need to get the time with high resolution, please use:
> getnstimeofday(), this function will return a linear time with the
> help of timekeeper(timekeeping_get_ns).
>


1)  So hrtimer is based on  xtime,

If CONFIG_NO_HZ is set , would xtime be updated on time and correctly ?


2) some question about __get_nsec_offset :

               /* read clocksource: */
	cycle_now = clocksource_read(clock);

	/* calculate the delta since the last update_wall_time: */
	cycle_delta = (cycle_now - clock->cycle_last) & clock->mask;



if   cycle_now  is smaller than clock->cycle_last , say , cycle_now =
3 ,    cycle->cycle_last = 2^32-1 ,  then

cycle_delta  = 3 - (2^32-1)  =  ?


> Regards,
> Wu Zhangjin
>
