Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Aug 2010 08:14:26 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:34733 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491062Ab0HOGOW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 Aug 2010 08:14:22 +0200
Received: by wwb34 with SMTP id 34so4149975wwb.24
        for <linux-mips@linux-mips.org>; Sat, 14 Aug 2010 23:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=nftAXQebPIsTErUrYNnz3pLj4zAAyJcRLyk9dzXvtzw=;
        b=pw5tRifUvRMcW0qWx82rLUG/05X7A0LsWPTSA8RxLZ2nyvkrT0ZwgphXGAbnopERab
         Ge0nennFHQNXBPkszbKdNzMVD8Bb7FVO7hkiV3Tf9gIzq21is/jfOiQ9pjOPSjOgTEPF
         ujQqvTb5Y6T2QrG0Ppoo6BbeJFeBN1Pjkaf/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=t6N3CWiMS9QySea3O1O14fFDVs6Kc+WRsq1z2mYVO6ug0t00ds28cmB6+uOpNo8BYh
         uaH9EXd91IyTJ2cy5nmXIAkkcs4IQYSQgK+eiTX3TUekv+jwSUYsre86jYU3ZWBjby7B
         zsji1z389qgVvj7i0BCytIeOwKHWJAQC/PaKk=
MIME-Version: 1.0
Received: by 10.216.89.149 with SMTP id c21mr3014466wef.73.1281852857530; Sat,
 14 Aug 2010 23:14:17 -0700 (PDT)
Received: by 10.216.159.199 with HTTP; Sat, 14 Aug 2010 23:14:17 -0700 (PDT)
In-Reply-To: <AANLkTik5o+LsApwvkDTb7z+k=Ls60h9PJugrvM7ozO=p@mail.gmail.com>
References: <AANLkTik5o+LsApwvkDTb7z+k=Ls60h9PJugrvM7ozO=p@mail.gmail.com>
Date:   Sun, 15 Aug 2010 14:14:17 +0800
Message-ID: <AANLkTimm2NMwu8_OjqdWvcJ11KFzBiz8VTGgYwAcemhf@mail.gmail.com>
Subject: Re: Clock Source in hrtimer
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     "wilbur.chan" <wilbur512@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On 8/15/10, wilbur.chan <wilbur512@gmail.com> wrote:
> I am planning to use  linux 2.6.24  with hrtimer enabled and with
> CONFIG_NO_HZ  on mips xlr 732.
>
>
> As we know, a   monotomic increasing Clock Source is required to
> support hrtimer,  whose cycles could be retrieved  from
> clocksource->read function.
>
> However  on  xlr 732 ,there is only a 32 bits counter register, which
> would overflow in 4s ( 2^32 / 1GHZ = 4).
>
> How to solve this ?
>

don't worry about it, the timekeeper solves it:

kernel/time/timekeeping.c

The r4k timer in most of the MIPS variants also only has a 32bits
counter register, no problem with it:

arch/mips/kernel/csrc-r4k.c
arch/mips/kernel/cevt-r4k.c

does  xlr 732 also use such a timer (with MIPS count & compare
registers of coprocessor0)?

If you need to get the time with high resolution, please use:
getnstimeofday(), this function will return a linear time with the
help of timekeeper(timekeeping_get_ns).

Regards,
Wu Zhangjin
