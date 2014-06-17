Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2014 23:33:03 +0200 (CEST)
Received: from mail-la0-f53.google.com ([209.85.215.53]:35081 "EHLO
        mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816409AbaFQVdAxBjHC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jun 2014 23:33:00 +0200
Received: by mail-la0-f53.google.com with SMTP id b8so2896838lan.26
        for <linux-mips@linux-mips.org>; Tue, 17 Jun 2014 14:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=nCVZpjuc6TH9btSZAhClVAMt/FMAPs6/ilFoPhEw0Ts=;
        b=O0IRhUSke/12BvHI9DpHujGGpNOnz+ls3WtPgR4Z3KGiSRNWo+GFlWQKukhnnXiMcU
         N2LVBmwFCa5syOvM8STc2IWeEKTyd0nrJI//Z3DNmn0fdHiSEbRv0tLpByJr4Y508Opt
         OlCl4PtvoRgkfIJX3hoROYX19hwQDDbdozh6WGcxk6RgLw+78Mx7FYLvV9o6Jr1POng7
         IMHXbTL17NX+eOWJqRFbPoHCtN7ebyNj0S9u2cQHu/6t3FPb7vbR/wRTWR7/rLZTKbxO
         6CRxAiiW/JZpXDgUIZcJ+EyLoPTM91YvWzMiaEJUiNAriTMrpBHQqfgEYFdg2fbSiEqI
         58Ug==
MIME-Version: 1.0
X-Received: by 10.112.51.37 with SMTP id h5mr18818901lbo.24.1403040775402;
 Tue, 17 Jun 2014 14:32:55 -0700 (PDT)
Received: by 10.152.43.4 with HTTP; Tue, 17 Jun 2014 14:32:55 -0700 (PDT)
In-Reply-To: <20140617212917.GA22353@ravnborg.org>
References: <1403018163-25307-1-git-send-email-geert@linux-m68k.org>
        <CAMuHMdU2DTt0va67uSKqhhqbVORuY+xEs3uGZ21sKjahE_MSXg@mail.gmail.com>
        <20140617212917.GA22353@ravnborg.org>
Date:   Tue, 17 Jun 2014 23:32:55 +0200
X-Google-Sender-Auth: FkWLK3L5QauETMIpboHyNAS2LcQ
Message-ID: <CAMuHMdXLak21vFMVLW8svF=hjNatgc9dax5cPdtNuOgySWGWBQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.16-rc1
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

Hi Sam,

On Tue, Jun 17, 2014 at 11:29 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
>> >   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_add' [-Werror=implicit-function-declaration]:  => 176:2
>> >   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_add_negative' [-Werror=implicit-function-declaration]:  => 211:2
>> >   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_add_return' [-Werror=implicit-function-declaration]:  => 218:2
>> >   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_dec' [-Werror=implicit-function-declaration]:  => 169:2
>> >   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_dec_and_test' [-Werror=implicit-function-declaration]:  => 197:2
>> >   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_dec_return' [-Werror=implicit-function-declaration]:  => 239:2
>> >   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_inc' [-Werror=implicit-function-declaration]:  => 162:2
>> >   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_inc_and_test' [-Werror=implicit-function-declaration]:  => 204:2
>> >   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_inc_return' [-Werror=implicit-function-declaration]:  => 232:2
>> >   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_set' [-Werror=implicit-function-declaration]:  => 155:2
>> >   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_sub' [-Werror=implicit-function-declaration]:  => 183:2
>> >   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_sub_and_test' [-Werror=implicit-function-declaration]:  => 190:2
>> >   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_sub_return' [-Werror=implicit-function-declaration]:  => 225:2
>> >   + /scratch/kisskb/src/include/linux/atomic.h: error: implicit declaration of function '__atomic_add_unless' [-Werror=implicit-function-declaration]:  => 53:2
>> >   + /scratch/kisskb/src/include/linux/atomic.h: error: implicit declaration of function 'atomic_cmpxchg' [-Werror=implicit-function-declaration]:  => 89:3
>> >   + /scratch/kisskb/src/include/linux/atomic.h: error: implicit declaration of function 'atomic_read' [-Werror=implicit-function-declaration]:  => 136:2
>>
>> sparc-allmodconfig
> Not reproduceable here with linus latest. (-rc1 + two patches).
> Can you help me with a pointer to the original build log?

http://kisskb.ellerman.id.au/kisskb/buildresult/11340509/

They've been there since quite a while (in -next since Apr 22),
but lately I didn't have much time to dive into -next build failures.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
