Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Sep 2017 13:28:14 +0200 (CEST)
Received: from mail-pg0-x243.google.com ([IPv6:2607:f8b0:400e:c05::243]:32959
        "EHLO mail-pg0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990825AbdIKL2HDf3A2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Sep 2017 13:28:07 +0200
Received: by mail-pg0-x243.google.com with SMTP id i130so2490587pgc.0;
        Mon, 11 Sep 2017 04:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=N8sMq9wxozdYgKExWbiwzp8ImpdmqsreDXH/2Ckod/k=;
        b=uo7j6b3q32zYoFqxk1CNmC1mgKU+3ITEolW+9r8Z69VejnPzAmwzo7SPVuPB0eMsCC
         aq4nQW98M/6hNk2IDICYYcnQL45DrdU33T743zNf6bL6mnOjgYUJkj4lRuhuucMLIb8w
         hso25CfiFaUrBohEiJ0BEJXIGFl4VVnb8VZkMu2ix1JR8wf+KZbc3bHoaH+VSlHTL1ef
         EEjprUPJBFGGKDs02lYJOJkOr4yfRHhEpEmVqRxOadft/CkdG5d/zmC6Ajn/TPGNHNfn
         ILg8iP4VS/29568y4c8eYbL37T2lqqrXnFXrcs4+KVVbohRgub6+g50mlCZ4xhJOhxq1
         d6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=N8sMq9wxozdYgKExWbiwzp8ImpdmqsreDXH/2Ckod/k=;
        b=tzHOaUlHKao689n43Weartv+1okphT7i8AxN9a1mrC9T24v+BwuBTsL99+7znadvBw
         90LMdCLxER9u14SMJ9LPynOEzuCZPVaWh4MgClEjrDxAzYQ30Z8dCqJOiWNW7+V04i2t
         gjQUwbd4wEFVR11NYKlo1X19MefSPyJVQgJMyd5Utm0yC9T3mzULu24AN+MsC7UYZ88a
         4GJz9pSMoitFMIL45Dinofys9j1Vgdi/CsCwD8Rb4T+JwVDpCax3vLvghiQm0MTOtDsZ
         g/lBCw14mr8GDG0c27Cyob1rJsni8NUY3h5wyTSOVKup9fMevUiFaHVk+uY3pqLiQtcd
         K7sw==
X-Gm-Message-State: AHPjjUh7rb3xlw2CpVoJCA5Tm+YqXizuvZn965Ku2LyYiKGq9K4X+5h7
        ey7UNe+bJnBU9CnEgvFH81g+xNy7Ug==
X-Google-Smtp-Source: ADKCNb6nUNZPBWoh20Y3Qf4YVl8BDxStZUUZd2Yat1uULHB7b0rm8E0Pn+z+6PjUGes8ygsUKxoTQdVS9xxmXC2kU0A=
X-Received: by 10.98.27.8 with SMTP id b8mr11356649pfb.21.1505129280464; Mon,
 11 Sep 2017 04:28:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.176.234 with HTTP; Mon, 11 Sep 2017 04:27:59 -0700 (PDT)
In-Reply-To: <20170910214424.14945-2-linus.walleij@linaro.org>
References: <20170910214424.14945-1-linus.walleij@linaro.org> <20170910214424.14945-2-linus.walleij@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Sep 2017 13:27:59 +0200
X-Google-Sender-Auth: yqjwwKofOFST9MxauQ_fKb_f0og
Message-ID: <CAMuHMdXabvax2Wru8j+MC4X5F+z5hoUo1tEbX+zn2AUW6QENVA@mail.gmail.com>
Subject: Re: [PATCH 1/5] i2c: gpio: Convert to use descriptors
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Steven Miao <realmz6@gmail.com>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        "arm@kernel.org" <arm@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59985
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

On Sun, Sep 10, 2017 at 11:44 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> This converts the GPIO-based I2C-driver to using GPIO
> descriptors instead of the old global numberspace-based
> GPIO interface. We:
>
> - Convert the driver to unconditionally grab two GPIOs
>   from the device by index 0 (SDA) and 1 (SCL) which
>   will work fine with device tree and descriptor tables.
>   The existing device trees will continue to work just
>   like before, but without any roundtrip through the
>   global numberspace.

FYI, I recently posted a series to deprecate (at least for DT) this error
prone indexing, in favor of using named GPIOs:

    [PATCH/RFC 0/3] i2c: gpio: Add support for named gpios in DT
    http://www.spinics.net/lists/devicetree/msg191936.html

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
