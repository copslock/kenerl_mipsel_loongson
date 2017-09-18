Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Sep 2017 13:16:09 +0200 (CEST)
Received: from mail-pg0-x244.google.com ([IPv6:2607:f8b0:400e:c05::244]:33748
        "EHLO mail-pg0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992126AbdIRLQCrt6tR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Sep 2017 13:16:02 +0200
Received: by mail-pg0-x244.google.com with SMTP id i130so82214pgc.0
        for <linux-mips@linux-mips.org>; Mon, 18 Sep 2017 04:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=4ve3tJQ3ZQkrSAlPYgR/EAUoghZeu+Wb6CReR/d+Rrk=;
        b=DmgLIkaD4TMwV3/efg/M4pw1CbvEJbvyl6P3hRWd2r2psBaXTTfl0KsA54JhnMY1LF
         Fka3JBlPsB3mzpcAPvw9YFixaJ9f72yJXPHKawVdyO2ALWsC262MnuHa2s3dvnt4SNhI
         69ifpDyPW3iBhWhiWDDdagir26nKDQiW/L8amhC3fNNuuOlIVgR5bneaWbXjCGrUIDll
         J8qdj063SD/Mgwb9DcKZnQYp94ifxdI6br898W1kXJUP3wI9JABXXwP1qQTxR1p42jBY
         MlCuihDB4LKdI4ZtfOl6TIu17mlPRtnGIixhREAKdmP1h6WA0iZZK0UCcDVDTF3+8mhd
         jQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=4ve3tJQ3ZQkrSAlPYgR/EAUoghZeu+Wb6CReR/d+Rrk=;
        b=MoVNKw8LO4ap94qulayS/OEmVDOj7uBJXme25c+OgHw+BaoPEp7qPZJ6Cmie2Kk4ID
         7hoFNQP1Y/Wc0lKENXRl+TuX75cNsXUWyi9ijV0sCmZPFbVzE9qsC5F7gunBb4hlj6j4
         3EEFpCefFQmsH0YAyo7WirtHf54sbGji6RETre+NUtwpsFa4i7mjCW2xR03kQtfW3PSZ
         h5LDirg0xE79WM1DFbO76lpIUUCxjvDE490IoM5YarMZOhnBzLfsdd6UhTnb8OmObsk4
         NKWVFz7+UBtd4rtFq15RPCwnqN+J1bv35sSv60djVvsOuDiGab7UZwW3oFnjEE5XoiI3
         fwpA==
X-Gm-Message-State: AHPjjUgZllNfIsP+JKR7xSSamWIvI6m5o8yhXVkxqjreBhIuocmB3A7O
        bfvZc4Dv1R8LAZDh23lvu2K/mKKHeOZSaXv51mM=
X-Google-Smtp-Source: ADKCNb6+nMLeLv25YFbinFmW+WYOhpnln4w9YakSBQ2sTRmYK8heP4+lM1D3+mjouyA89KBpV7UI9D6GcV5bPXSTRRk=
X-Received: by 10.98.217.75 with SMTP id s72mr31474346pfg.158.1505733356089;
 Mon, 18 Sep 2017 04:15:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.160.13 with HTTP; Mon, 18 Sep 2017 04:15:55 -0700 (PDT)
In-Reply-To: <20170917093906.16325-1-linus.walleij@linaro.org>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Sep 2017 13:15:55 +0200
X-Google-Sender-Auth: Dj9C1qSWPrBO8jZisOIGx-ICcls
Message-ID: <CAMuHMdWOt3e7eT4_wF8QJVM=aZNNcou+tGmjZOyvOziutedv_w@mail.gmail.com>
Subject: Re: [PATCH 0/7] I2C GPIO to use gpiolibs open drain
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60053
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

Hi Linus,

On Sun, Sep 17, 2017 at 11:38 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> This augments the I2C GPIO driver to use open drain emulation
> or hardware support for open drain from the GPIO driver.
>
> This version layers Geert Uytterhoeven's idea to use explicit
> sda-gpios and scl-gpios for the GPIO lines, and strongly
> encourage the (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN) flags to be
> used in all device trees.
>
> We have collected ACKs from the ARM SoC maintainers and the
> MFD maintainer and are looking for testers to try this out.
>
> Geert Uytterhoeven (1):
>   dt-bindings: i2c: i2c-gpio: Add support for named gpios
>
> Linus Walleij (6):
>   i2c: gpio: Convert to use descriptors
>   gpio: Make it possible for consumers to enforce open drain
>   i2c: gpio: Enforce open drain through gpiolib
>   i2c: gpio: Augment all boardfiles to use open drain
>   i2c: gpio: Local vars in probe
>   i2c: gpio: Add support for named gpios in DT

Thanks for doing this, and picking up my patch.

I gave this a try on r8a7740/armadillo800eva.
Without DT changes, the GPIO i2c bus still works fine, but a warning is
printed, as expected:

    gpio-208 (sda): enforced open drain please flag it properly in
DT/ACPI DSDT/board file
    gpio-91 (scl): enforced open drain please flag it properly in
DT/ACPI DSDT/board file

After

    -  sda-gpios = <&pfc 208 GPIO_ACTIVE_HIGH>;
    -  scl-gpios = <&pfc 91 GPIO_ACTIVE_HIGH>;
    + sda-gpios = <&pfc 208 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
    + scl-gpios = <&pfc 91 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;

the warning is gone, and the GPIO i2c bus still works.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
