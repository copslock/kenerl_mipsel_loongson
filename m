Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Dec 2015 13:29:25 +0100 (CET)
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35583 "EHLO
        mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008622AbbL1M3YKI8EG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Dec 2015 13:29:24 +0100
Received: by mail-ig0-f177.google.com with SMTP id to4so143731945igc.0;
        Mon, 28 Dec 2015 04:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=1TCT45Bv22glPCGkdu5DhIrCqY7n0+YcXSCyugaBFA8=;
        b=MGouIATxVYJWdIVsY4CUQnGoSXR86ukS/b5EEnJKyloxNeH4lDZyhd6vPNN3qg0gxr
         Unm/PJC6sBZfysk0KEoR+HZZniHPg4uPJVs6Rjs4iZ9BWYPc31VBMMF+Szo4tsKk3KaI
         1OW3yOoBhj2aE8skHuhjfybZQwwdLdIRHxuT4vcganjfvOghnKa+/zFyqzs1zKAMoyu3
         sq3rkImzyZBGAjpDXRW2YAIH/D9XHcqi8VtTeM/ZnJsWTIbt72f0JF8QpsCHGQwCDMYz
         pEkKQqcgEG7Twv5Crf4bwjVY2hkKXEILwQqrTO8oJHJty1v5K7N0/WI6R+iJf81ZZae4
         bNUA==
MIME-Version: 1.0
X-Received: by 10.50.50.201 with SMTP id e9mr54339719igo.10.1451305758143;
 Mon, 28 Dec 2015 04:29:18 -0800 (PST)
Received: by 10.107.9.97 with HTTP; Mon, 28 Dec 2015 04:29:18 -0800 (PST)
In-Reply-To: <1451305281-3911-1-git-send-email-geert@linux-m68k.org>
References: <1451305281-3911-1-git-send-email-geert@linux-m68k.org>
Date:   Mon, 28 Dec 2015 13:29:18 +0100
X-Google-Sender-Auth: dGdO9F3UTo5ZEo828H1nY1-lKbw
Message-ID: <CAMuHMdWnSERAHcxDV47FRY1Sz6XJku72xRPb1cGig7sSF8nf4A@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.4-rc7
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        Tejun Heo <tj@kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50762
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

On Mon, Dec 28, 2015 at 1:21 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.4-rc7[1] to v4.4-rc6[3], the summaries are:
>   - build errors: +14/-3

  + /home/kisskb/slave/src/include/linux/kqueue.h: error:
dereferencing type-punned pointer will break strict-aliasing rules
[-Werror=strict-aliasing]:  => 186:2

mips-allmodconfig

Reported in September by kbuild test robot <lkp@intel.com>

  + /tmp/cc5veAi5.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 378, 49

mips-allnoconfig

  + /tmp/cc6DopGj.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 43
  + /tmp/cc7GEfIa.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 43
  + /tmp/ccmqbWag.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 43

bigsur_defconfig

  + /tmp/ccGsoCyO.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 49, 366

ip22_defconfig

  + /tmp/ccH1dW0f.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 43
  + /tmp/ccP7l3ug.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 43
  + /tmp/ccSlbKej.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 43

ip27_defconfig

  + /tmp/ccemCHRe.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 50, 326
  + /tmp/cckgYy8k.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 329, 50
  + /tmp/cclNaAGh.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 366, 49

ip32_defconfig

  + /tmp/cczzZNSV.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 403, 41

malta_defconfig

I guess the last-minute build fix for MIPS broke the build for other versions of
binutils?

> [1] http://kisskb.ellerman.id.au/kisskb/head/9745/ (258 out of 259 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/9734/ (all 259 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
