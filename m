Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 16:04:52 +0100 (CET)
Received: from mail-ig0-f173.google.com ([209.85.213.173]:36621 "EHLO
        mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008336AbcADPEtIqvqJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jan 2016 16:04:49 +0100
Received: by mail-ig0-f173.google.com with SMTP id ph11so246317287igc.1;
        Mon, 04 Jan 2016 07:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=YePYMzg8bVAuhm4BBepE+Fnww7vwOc0y9XgoZLWGyWk=;
        b=cSCr9v31v19ibdhOC5ALpEu1+iZ3rvab3tMpIDpaFp1qhy3PeAdraMlG11728dgJiU
         hjhImrDAIJERDJNz4S6ED5g9/JfdhUC72YRzax3DRtvom3ofMN447u5yOS19BHDEM8sU
         weIlVTmK17ot6ZPA3/NHEmYyUTuMwOvJgDsrLpPZJjPZ6jd1/Q6nMWqkJtv1/N30q25R
         YSZT7+9uTjcZrYuu6yl6OfJrqlBeX7QQ4Qa6Mp1jUyGAVA16yTcN9pgUVDIyXMNVfjDK
         GH5VAPl8Z1NPiAYnZxx80lef1FJSM2YQ47BaBFpuccYMqqWNZNgNO0m7MPtn2+kgHRrc
         lObg==
MIME-Version: 1.0
X-Received: by 10.50.109.167 with SMTP id ht7mr51673265igb.38.1451919882522;
 Mon, 04 Jan 2016 07:04:42 -0800 (PST)
Received: by 10.107.9.97 with HTTP; Mon, 4 Jan 2016 07:04:42 -0800 (PST)
In-Reply-To: <1451919704-31509-1-git-send-email-geert@linux-m68k.org>
References: <1451919704-31509-1-git-send-email-geert@linux-m68k.org>
Date:   Mon, 4 Jan 2016 16:04:42 +0100
X-Google-Sender-Auth: l_0dSxaZPNZhcE1cdWPl_5IrfIM
Message-ID: <CAMuHMdXSiozb=4pC-vecF5RhwHxbuVA0au-P9VKymWV+1YhsCQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.4-rc8
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50853
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

On Mon, Jan 4, 2016 at 4:01 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.4-rc8[1] to v4.4-rc7[3], the summaries are:
>   - build errors: +19/-18

  + /home/kisskb/slave/src/arch/arm/kernel/ftrace.c: error: implicit
declaration of function 'flush_tlb_all'
[-Werror=implicit-function-declaration]:  => 93:2
  + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error:
'L_PTE_DIRTY' undeclared (first use in this function):  => 39:2
  + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error:
'L_PTE_MT_WRITEBACK' undeclared (first use in this function):  => 39:2
  + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error:
'L_PTE_PRESENT' undeclared (first use in this function):  => 39:2
  + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_XN'
undeclared (first use in this function):  => 39:2
  + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error:
'L_PTE_YOUNG' undeclared (first use in this function):  => 39:2

arm-randconfig
Seen and report before

  + /tmp/cc5DX198.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 43
  + /tmp/ccHnSrdb.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 49, 366
  + /tmp/ccSLqWGf.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 43
  + /tmp/cch44bTJ.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 378, 49
  + /tmp/ccjj7cLa.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 43
  + /tmp/ccsgtMo8.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 41, 403
  + /tmp/ccxItlIa.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 43

Various mips.
Seems like the fix for this fix still doesn't fix everything?

> [1] http://kisskb.ellerman.id.au/kisskb/head/9755/ (all 259 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/9745/ (258 out of 259 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
