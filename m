Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Mar 2016 10:01:26 +0100 (CET)
Received: from mail-io0-f181.google.com ([209.85.223.181]:33288 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006151AbcCGJBPb8E6P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Mar 2016 10:01:15 +0100
Received: by mail-io0-f181.google.com with SMTP id n190so124596996iof.0
        for <linux-mips@linux-mips.org>; Mon, 07 Mar 2016 01:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=tzPo6EYEb3Dw+/ZLDxSPrTGWQ5eGN/VPIEOYt4toB1s=;
        b=el1aGypzpykoUp8tUUD8Shq/WsJFrZ+xqxQH8EZPIDZYgrhw1GoLQBc59ioy9aeJ95
         kE3EqW9sq1bvg881xLXSRFrLbBENuuxTsPfoNG53vzMIBLo0F9YH+68iV8xJvYVrIqCX
         An4EiLs73NG514Sv95rF/obdd8j8HH5+XwHNjCn/OcYm4CT63NNFatHO3b+G5gwqmiR7
         W9yIiD6Rg5fqcKlXjzmeC4uTi7YWZwyliR8FnF0LD4UW1UnvV/YS3MdAJeUJx7N2TlVH
         ARYmKFgtzL4wj5lh0DpZc7QRiXJUN0W0iTo6krz1cpwJTcVU1W1uerXvJPPXc1uWTQwA
         Z3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=tzPo6EYEb3Dw+/ZLDxSPrTGWQ5eGN/VPIEOYt4toB1s=;
        b=mOHn1fNGBasjiOVO8at21p7CgyMgOCOynMjBoe1Xq1tFVuFnjUp/QSohDs2ccX4gaP
         WAUXYvNa9py/amgrTymXk+7sYROXzJyx/HQYDQ23tr+3pYMq11tLx1w+BIKWgrgQDqXY
         zNVDMRXdj61UH1fEovImwyH+LJLSBfTJQK9q2bOYdRDSUM7PE4hongd5Ot4bsjqaHL1c
         Ru40Mtz78de32X2rkqpc0b0s0Xup6+7g2nkTt+zAWWnBEMY4Z3gPtQG8Xb05bTdxZa5p
         iDCdwXB4M8zChRzpIbxpjSC19t1XeWU3qxN2EkOH6ZCOJ1tLiD96POW8yKtYCo1RQ0X/
         KX3g==
X-Gm-Message-State: AD7BkJKogti/6Gsm5uR6YYlbPWXvoqo33E3r4Ip8cyIFMLFJyC6KSgQj2K0M+pfD7EQkOBRSJG4szJfVk/RGNw==
MIME-Version: 1.0
X-Received: by 10.107.26.203 with SMTP id a194mr23698661ioa.115.1457341269589;
 Mon, 07 Mar 2016 01:01:09 -0800 (PST)
Received: by 10.107.31.77 with HTTP; Mon, 7 Mar 2016 01:01:09 -0800 (PST)
In-Reply-To: <1457340934-23042-1-git-send-email-geert@linux-m68k.org>
References: <1457340934-23042-1-git-send-email-geert@linux-m68k.org>
Date:   Mon, 7 Mar 2016 10:01:09 +0100
X-Google-Sender-Auth: SDuZ0NiX4MtLQ6GYwGaw7L0POtI
Message-ID: <CAMuHMdWe9bTjp-qmTJc9=n9-iP-qH8-O0jafiRD3-y_EtT=WvA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.5-rc7
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52486
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

On Mon, Mar 7, 2016 at 9:55 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.5-rc7[1] to v4.5-rc6[3], the summaries are:
>   - build errors: +8/-7
  + error: debugfs.c: undefined reference to `clk_round_rate':  =>
.text+0x11b9e0)

arm-randconfig

While looking for more context, I noticed another regression that fell through
the cracks of my script:

    arch/arm/kernel/head.o: In function `stext':
    (.head.text+0x40): undefined reference to `CONFIG_PHYS_OFFSET'
    drivers/built-in.o: In function `v4l2_clk_set_rate':
    debugfs.c:(.text+0x11b9e0): undefined reference to `clk_round_rate'

  + error: misc.c: undefined reference to `ftrace_likely_update':  =>
.text+0x714), .text+0x94c), .text+0x3b8), .text+0xc10)

sh-randconfig

    arch/sh/boot/compressed/misc.o: In function `lzo1x_decompress_safe':
    misc.c:(.text+0x3b8): undefined reference to `ftrace_likely_update'
    misc.c:(.text+0x714): undefined reference to `ftrace_likely_update'
    misc.c:(.text+0x94c): undefined reference to `ftrace_likely_update'
    arch/sh/boot/compressed/misc.o: In function `unlzo.constprop.2':
    misc.c:(.text+0xc10): undefined reference to `ftrace_likely_update'

  + /tmp/cc52LvuK.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 41, 403
  + /tmp/ccHfoDA4.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 43
  + /tmp/cch1r0UQ.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 49, 378
  + /tmp/ccoHdFI8.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 43

mips-allnoconfig
bigsur_defconfig
malta_defconfig
cavium_octeon_defconfig

Not really new, but it would be great if the MIPS people could get this
fixed for the final release.

Thanks!

> [1] http://kisskb.ellerman.id.au/kisskb/head/10011/ (all 262 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/9974/ (all 262 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
