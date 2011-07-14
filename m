Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jul 2011 13:51:45 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:37264 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491083Ab1GNLvi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jul 2011 13:51:38 +0200
Received: by gwb1 with SMTP id 1so59996gwb.36
        for <linux-mips@linux-mips.org>; Thu, 14 Jul 2011 04:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ls9Cwy4exXxg+He/kKmswpQo6lfkP7VyxNryUzb+4Tg=;
        b=KTd2mpGrsvfAcXAOdzhhTy4ffcxLgJLL5tCqFTfU8I7WuJXVW9oEGKXApHmRRULATw
         FPudkmW0efWeTwuFwJyj6n6c+NG0svR/L88H9d0GcafY9C9Q/PKBWHCrrtWPhUIB+m4z
         IOfBA+ZLfTx0tK8FasOUdfWa1c1/S9PQXYLPY=
Received: by 10.150.47.42 with SMTP id u42mr2239270ybu.127.1310644292351; Thu,
 14 Jul 2011 04:51:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.151.158.21 with HTTP; Thu, 14 Jul 2011 04:51:11 -0700 (PDT)
In-Reply-To: <4E1ECE3B.10308@broadcom.com>
References: <4E1ECE3B.10308@broadcom.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Thu, 14 Jul 2011 13:51:11 +0200
Message-ID: <CAOiHx=kznEFL1BELeg2psg9yw+=-A5reunG0VYTu89DGKwrSzA@mail.gmail.com>
Subject: Re: Status of MIPS on 3.0.0-rc6 kernel
To:     Roland Vossen <rvossen@broadcom.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, "Rafael J. Wysocki" <rjw@sisk.pl>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 30621
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10134

On 14 July 2011 13:08, Roland Vossen <rvossen@broadcom.com> wrote:
> Hi Jonas,
>
> The (defconfig) mips kernel fails to build, with the error message:
>
> arch/mips/kernel/i8259.c:240: error: unknown field 'resume' specified in
> initializer
>
> I read on https://lkml.org/lkml/2011/6/1/37 that Geert Uytterhoeven
> encountered the same issue on June 1st.
>
> Do you know if there are still known problems building a 3.0.0-rc6 MIPS
> kernel ?

You probably could have found that out yourself quite easily [1] ;-)

This is actually still a problem in rc7. Commit
2e711c04dbbf7a7732a3f7073b1fc285d12b369d ("PM: Remove sysdev suspend,
resume and shutdown operations") broke it.
It's probably easily fixable by just removing the offending
.resume/.shutdown lines (and their referenced functions), but I don't
know the code (or PM) enough to know if some replacement is missing
there.


Regards,
Jonas

[1] <https://lkml.org/lkml/2011/7/7/267>
