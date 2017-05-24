Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2017 11:21:36 +0200 (CEST)
Received: from mail-it0-x241.google.com ([IPv6:2607:f8b0:4001:c0b::241]:34373
        "EHLO mail-it0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993918AbdEXJV31aR1v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 May 2017 11:21:29 +0200
Received: by mail-it0-x241.google.com with SMTP id d68so19353377ita.1;
        Wed, 24 May 2017 02:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8dHHqi9CoNH5LpcKo1hUvYouX8t8PsHI2DSpmiOOicU=;
        b=KGnRP0ebGYxF8kZo7xQxP2b7uCOXvGM91NFGdfrLfy6xqdYiFkzKJK015hbCauCXW7
         qmfgEz7d5nQaRrwoHEUUusYSuLfMmT05MptH7WqeImA4xpRLd+MTZQZsEqb3I5z9zFCw
         7buTYo7sAW22LRqv6LS5JkEWY095dqvzzkPi7JvNHuC3E6OhAVetG1IupDugo+iT1mon
         L25Rucv2kMF9DrYE+1hWkA/BEAchInxqrP5xXeXvNxIN9o5RgQAdVx9wcsNgsWYeeJQ5
         CHVctsds3gawrfL9qkVeQXBO34taMUh2iuoaEVP/AmQYbhAs0xivQqSunQU3uTrisKAf
         bmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=8dHHqi9CoNH5LpcKo1hUvYouX8t8PsHI2DSpmiOOicU=;
        b=bAokLgBmAlOoA5q0movdjUFpfKuGvT/U2Ka7Qm1h9x8KtA/glCwb/XHMMo0cEMqWAe
         Zgb4VmfuVPIa+KWHQL/iQg7w88qgDuSM2gz1xyg5Y5iX6OXa63UmxZD98Vi2Q2bzMtEs
         1as/qFlxOHTtDnIuOGZzP1cnlzyjqkLzIwzHF0QrcpUn8uUSGWoOX8R+WOQIfoVwHDuC
         WHaLXJR5sawyQCogB9LSSMAshAXf5V0IkHk4N1OUob/0T6Ay7rqNs7ULxGtPmWpvEIvU
         C7NTEJhiwO91E2NpJCP+4P27ssQP37P9NNhXAiBwe7zrdWyDkx6b8ZOZWkpNEGAQl3c4
         kqZQ==
X-Gm-Message-State: AODbwcAbhh20RZXw1yJxvNmBK/uMGIfXeGkptg7IsI/XhXBH6LENmF6D
        FeU2xk2OdMRRaePV7++8IIOQAKhObw==
X-Received: by 10.36.88.18 with SMTP id f18mr7202781itb.60.1495617683034; Wed,
 24 May 2017 02:21:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.35.142 with HTTP; Wed, 24 May 2017 02:21:22 -0700 (PDT)
In-Reply-To: <20170523220546.16758-1-palmer@dabbelt.com>
References: <20170523220546.16758-1-palmer@dabbelt.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 24 May 2017 11:21:22 +0200
X-Google-Sender-Auth: XDjmJR3ypyKKEPd50Cxz5eGieuE
Message-ID: <CAMuHMdUP2RbjV+09UGkzjJcRrsoyy9F6XT8fbCPEd0mQCDFvFw@mail.gmail.com>
Subject: Re: Unify the various copies of libgcc into lib
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Chen Liqin <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57979
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

Hi Palmer,

On Wed, May 24, 2017 at 12:05 AM, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> I'm in the process of submitting the RISC-V Linux port, and someone noticed
> that we were adding copies of some libgcc emulation routines that were the same
> as some of the other ports.  This prompted me to go through and check all the
> ports for libgcc.h and to merge the versions that were functionally identical.
>
> The only difference in libgcc.h was that there was a #define for little vs big
> endian.  The differences in the emulation routines were all just whitespace.
>
> This patch set comes in two parts:
>
>  * Patch 1 adds new copies of all the C files copied from libgcc, as well as
>    moving libgcc.h to include/lib (that's a new folder, which probably means
>    it's the wrong place to put it, but I couldn't find anything better).  There
>    are Kconfig entries for each of these library functions so architectures can
>    select them one at a time.

I would call the Kconfig symbols GENERIC_* instead of LIB_*, for consistency
with other generic implementations.

>  * The rest of the patches convert each architecture over to the new system.

Thanks! For all but "[PATCH 4/7] mips: ...":

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

> Unless I screwed something up, this patch set shouldn't actually change any
> functionality.  Unfortunately I don't actually have all these cross compilers
> setup so I can't actually test any of this, but I did convert the RISC-V port
> over to using this system and it appears to be OK there so at least this isn't
> completely broken.

https://www.kernel.org/pub/tools/crosstool/

BTW, blackfin, h8300, m68k, and parisc have their own implementations, too.
They look different, but I believe their functionality is identical.
They can be converted later, though.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
