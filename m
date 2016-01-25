Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2016 09:24:14 +0100 (CET)
Received: from mail-io0-f170.google.com ([209.85.223.170]:36825 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008653AbcAYIYMHssdA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jan 2016 09:24:12 +0100
Received: by mail-io0-f170.google.com with SMTP id g73so147658896ioe.3
        for <linux-mips@linux-mips.org>; Mon, 25 Jan 2016 00:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=cdd3x6i2iDwDw2ipq+nhwi2q+gsKT6ayajZHDoO2IEY=;
        b=hzfXvvV5IVk8o2MP4iGhxsi7wJ4IivxTdvwUurxLpvZFCiwjyLzLiO3/APrce0yDIB
         iNnEEvJiAKQl1ua593pXRhWlW5vIY45BpAXnFcEzf0ZZ4hpncvkTVh0jS3CcbC++IX7l
         Q4tJuIJv40LzCp+jGpBjA2XocmR264kWQNz0b6i9ORECCB0YzrGZe/hta6yVhC19zBfm
         WKhg6GonbXAyodScmDsFSPHQ3R+qICDPvq7bmKri1ofSn8Q4ZkYaATJyLzm417eSmRS9
         +l6U7VPLqPcWnLR8Od5sky2RwHEU812RXKpK15/zZN5hu8bC+ABSvquxfrWEgBk/sxpq
         uTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=cdd3x6i2iDwDw2ipq+nhwi2q+gsKT6ayajZHDoO2IEY=;
        b=d66wFz8kOwSEggGv4SBLsC9NUt6SLiyvP6bzUgH4hdjnvtUTtmYOh7HPSroFbO11Bb
         M1MCN+y+jfIQ3MfznWVrrtQbZ7DFRLagXmEtCpfYxwP5GeB6V5ouwePDTYSKspCzQwfy
         EYQJ4Wbb8CW5LiUl4Uw0vBzy+mN66px6QnlOeHcLQOP7Jkfem1av2snb1aI5/BV51lGM
         US2e1WiHe80n8lMHt1XaXE+WFRpmy8vS5nKIRdOHWzxYPg2yFs8Og+5psizYYAm+QlXA
         wmLnLtVO8TyoTw3JS9ZxXS0br9yYt7ACSFizz3xg7+Iq8SuhJxhBR0AUkHlbH5ehwpIL
         vQbA==
X-Gm-Message-State: AG10YOQR6ZehhxCGARY557a+NtxWueGgUbMCeYYHeZl7uZ12sFcCsXsVt+PAi/r9MefFr6jkJ/8vKNfnFLJcHg==
MIME-Version: 1.0
X-Received: by 10.107.164.231 with SMTP id d100mr15507228ioj.151.1453710246220;
 Mon, 25 Jan 2016 00:24:06 -0800 (PST)
Received: by 10.107.9.97 with HTTP; Mon, 25 Jan 2016 00:24:06 -0800 (PST)
In-Reply-To: <1453709909-15240-1-git-send-email-geert@linux-m68k.org>
References: <1453709909-15240-1-git-send-email-geert@linux-m68k.org>
Date:   Mon, 25 Jan 2016 09:24:06 +0100
X-Google-Sender-Auth: HcGAowejLJBv1Wet75X0ZNiVy6c
Message-ID: <CAMuHMdXPFRRJvw4wC8kHvSo7zbcv9159EeRjzh2xiQ_+8zxb6w@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.5-rc1
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51348
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

On Mon, Jan 25, 2016 at 9:18 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.5-rc1[1] compared to v4.4[2].
>
> Summarized:
>   - build errors: +15/-23

> [1] http://kisskb.ellerman.id.au/kisskb/head/9841/ (all 261 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/head/9774/ (259 out of 261 configs)
>
>
> *** ERRORS ***
>
> 15 error regressions:
>   + /home/kisskb/slave/src/arch/sh/drivers/dma/dma-sh.c: error: 'DMTE6_IRQ' undeclared (first use in this function):  => 58:21

sh-randconfig

>   + /home/kisskb/slave/src/drivers/gpu/drm/vc4/vc4_v3d.c: error: called object '0u' is not a function:  => 157:29, 159:27

cris-allmodconfig
cris-allyesconfig
m32r/m32700ut.smp_defconfig
m68k-allmodconfig
parisc-allmodconfig
sh-randconfig
xtensa-allmodconfig

>   + /home/kisskb/slave/src/sound/core/compress_offload.c: error: case label does not reduce to an integer constant:  => 804:2

ppc64le/allmodconfig+ppc64le

>   + /tmp/ccDC0dZh.s: Error: can't resolve `_start' {*UND* section} - `L0 ' {.text section}:  => 378, 49
>   + /tmp/ccGniXga.s: Error: can't resolve `_start' {*UND* section} - `L0 ' {.text section}:  => 43
>   + /tmp/ccci5ABy.s: Error: can't resolve `_start' {*UND* section} - `L0 ' {.text section}:  => 366, 49
>   + /tmp/cccq2wZf.s: Error: can't resolve `_start' {*UND* section} - `L0 ' {.text section}:  => 43
>   + /tmp/cchnfEGb.s: Error: can't resolve `_start' {*UND* section} - `L0 ' {.text section}:  => 43

(reported before)

mips-allnoconfig
mips-defconfig
ip27_defconfig

>   + error: No rule to make target include/config/auto.conf:  => N/A

arm-randconfig (reported before)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
