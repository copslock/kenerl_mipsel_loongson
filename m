Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 13:29:11 +0100 (CET)
Received: from mail-wg0-f42.google.com ([74.125.82.42]:41604 "EHLO
        mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012759AbaKGM3JyOPnF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Nov 2014 13:29:09 +0100
Received: by mail-wg0-f42.google.com with SMTP id k14so3554537wgh.15
        for <multiple recipients>; Fri, 07 Nov 2014 04:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NpfE9UvcLYDiwb7fRXzppqOmSUufnX+MCbQjxZwIU8s=;
        b=Fgf2M5Rin4PftHDvPK0d9qTgoGhPIUnYRv+IWDNeGpXB8YsvkNNO2G5Fw+6HUT1IqC
         F3P+jryjG7GCV62s8UIoQxC2WGDH3nUeEdqBfJuz9Bc9I/s3AgG4pxVKNoeab6y6YTjP
         JQjo6sjOhBvAcqK2E+axYUpJEgQDozIckzQCucwhGJUxPd6HE8YPDJeJxvjLoJ90Lc+D
         /Yitwd7aTGUdTquYM60zsCF14o4lvmJCaYUK/LnnWaVGE3SDx3A17O+6USbFzyNfc5Ye
         +YrQX/uytnIdpOO2mCTy0J96zG0oxTnc4k4zzZo9Nq1JfmICAQ4u/tLlXs0CPx2J0S21
         3/rg==
X-Received: by 10.180.109.17 with SMTP id ho17mr4634413wib.4.1415363344423;
 Fri, 07 Nov 2014 04:29:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.217.55.200 with HTTP; Fri, 7 Nov 2014 04:28:24 -0800 (PST)
In-Reply-To: <6D39441BF12EF246A7ABCE6654B0235320F6C533@LEMAIL01.le.imgtec.org>
References: <1414771394-24314-1-git-send-email-manuel.lauss@gmail.com>
 <20141107020204.GA24423@linux-mips.org> <6D39441BF12EF246A7ABCE6654B0235320F6C533@LEMAIL01.le.imgtec.org>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Fri, 7 Nov 2014 13:28:24 +0100
Message-ID: <CAOLZvyEuKHq+DUZ_RNaEU+y3PSeiJBvBjyU0uJRz+D9A=fo7JA@mail.gmail.com>
Subject: Re: [RFC PATCH v6] MIPS: fix build with binutils 2.24.51+
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Fri, Nov 7, 2014 at 12:05 PM, Matthew Fortune
<Matthew.Fortune@imgtec.com> wrote:
>> +(mips1) `cfc1 $2,$31'
>> make[1]: *** [arch/mips/math-emu/cp1emu.o] Error 1
>> make: *** [arch/mips/math-emu] Error 2
>> make: *** Waiting for unfinished jobs....
>
> This is the offending code in cp1emu.c:
>
>                         if (is_fpu_owner())
>                                 asm volatile(
>                                         ".set push\n"
>                                         "\t.set mips1\n"
>                                         "\tcfc1\t%0,$31\n"
>                                         "\t.set pop" : "=r" (fcr31));
>                         else
>                                 fcr31 = current->thread.fpu.fcr31;
>                         preempt_enable();
>
>
> I'm not sure how this can have built with binutils 2.23 (as indicated by
> Manuel and not built with 2.24). The reason this works with the latest
> version of binutils 2.24.x is that cfc1 has been reclassified as not an
> FPU instruction.
>
> This just needs the hardfloat annotation adding via the macro as in the
> other cases.


Oh I know how to fix it.  However I'm unsure why I didn't run into this
while testing.  I've repeatedly built a cavium-octeon, malta and my
alchemy defconfigs
and never hit this.

I'll send out a revised patch shortly.

Thank you!
        Manuel
