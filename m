Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Mar 2016 07:51:15 +0100 (CET)
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38118 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007351AbcCBGvNg5nbY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Mar 2016 07:51:13 +0100
Received: by mail-wm0-f53.google.com with SMTP id l68so63887108wml.1;
        Tue, 01 Mar 2016 22:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ylDBPuuFqMkuzhaVhQYzgK2fNdFm9eehFA7PF+ZMIbY=;
        b=0AEyTDyERyzWchvDF/TDUYIIeqkX2DzuDpRQsM7sItV2TqgxKhC03yPDgaFF+eEKgN
         Mhg4OLr88YupFF+fwl7hku88ZePXQ/tEagpIIz3I0P3shrUqtej4Gs3+4JyxBJ7W737X
         bU1m1fXJSzDrevCfLrY34UPYQTd00XG1d1+kJD2AIkzZDnVZcRfREaDTrTKHEkbNO/9w
         NlK5F+y8EfdV7X57/YCxTnc8ZvPeMSCwMVAzxwiTL21PqW21q/UVGIMnxFWVmXrxV20q
         DUr0KIynY5llnkisDHSP5J1aNCS8Wmfgec4sP5Ce3bTlyGbaTdTk958pgDnlNKC47lIM
         vwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ylDBPuuFqMkuzhaVhQYzgK2fNdFm9eehFA7PF+ZMIbY=;
        b=eHSRNDE/251tJYI/FJomxBm3PQ3QGRbO4Hhlwre6ugkukqCRhKAH3zXRJpxDW1FKkX
         mABvEjJYEE8IfLDFtceS3C8fvVJpGBddH3g8LBK1C7C92Ae/CHjCvSPj0G1GzcvxV4Uv
         qRAw/kM55F3Po9IKZMMR61/xaJ/Lgdo6rIWQ/szciaZPXyLeyZLR1NLhttW85mP2KlEu
         LoXCtdpG5Nz3m/iiZR/4wE2RuYsIzUcBblklQGun7ei05ARPrt4Ln8szHxhtI5mPuBNd
         p5BrJGfAlri+xr2lf1DeWBR9Ro2+ZznpjxQlQeUQ3kY1uQhwyeEN0eP2tX0ttXl+rU8T
         1kxg==
X-Gm-Message-State: AD7BkJIrD6lJT7BPR9xohyzN+1CpZKmJcQR+xjB1pysrvelhmfWzJ/d0rA708ct7XCQ2eDz2ipwTZraFkeVzIw==
X-Received: by 10.28.179.84 with SMTP id c81mr2695452wmf.13.1456901468338;
 Tue, 01 Mar 2016 22:51:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.136.206 with HTTP; Tue, 1 Mar 2016 22:50:28 -0800 (PST)
In-Reply-To: <1547427.xN2rd1Mon4@wuerfel>
References: <1547427.xN2rd1Mon4@wuerfel>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Wed, 2 Mar 2016 07:50:28 +0100
Message-ID: <CAOLZvyHH4-uq_fnpjrRptkMfjR1+1kzxXM+AUtj_Zb5V3AL-yQ@mail.gmail.com>
Subject: Re: [PATCH] pcmcia: db1xxx: use correct irq_to_gpio helper
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-pcmcia <linux-pcmcia@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52412
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

 Hi Arnd,


On Tue, Mar 1, 2016 at 11:12 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> After the removal of asm/gpio.h and asm/mach-au1x00/gpio.h, the db1xxx_ss
> pcmcia driver picked up the wrong irq_to_gpio function from the generic
> headers.
>
> This restores the old __au_irq_to_gpio() implementation, but keeps
> it local to the only file that uses it.
>
> It would be nicer to just pass the gpio number from platform code,
> but restoring the previous implementation seems safer.

Give me a few hours and I'll fix this driver for good.


> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: stable@vger.kernel.org # v4.3
> Fixes: 832f5dacfa0b ("MIPS: Remove all the uses of custom gpio.h")
> ---
> I think this is now the last holdout of the irq_to_gpio function,
> and it's been broken for a while. Maybe Ralf can queue it up through
> the MIPS tree along with the other fix for irq_to_gpio?

It's not broken though..  this driver on current linus-git works fine!

Thank you,
      Manuel
