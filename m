Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Sep 2017 11:11:45 +0200 (CEST)
Received: from mail-pg0-x244.google.com ([IPv6:2607:f8b0:400e:c05::244]:34879
        "EHLO mail-pg0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993122AbdIRJLiqLl8Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Sep 2017 11:11:38 +0200
Received: by mail-pg0-x244.google.com with SMTP id j16so4942476pga.2
        for <linux-mips@linux-mips.org>; Mon, 18 Sep 2017 02:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=zUwKuXVahJyp/hQO8G1awzpws5SvESmOxM/EZj/byGc=;
        b=Pkl5GYJs3aTk3XX645yijSHuvX7OcskB7QoI6sfUcxVHqRZkNCGGjaxKHru4Hh2h9M
         L8weTkbiQPh9t6oRNBbyyn7seVGJuXJEjO6FGsl/pBqwjoW0QIOTMi1JiSTqpgKB07RO
         l2VaotvO7MlsRRrm9C7X6b+kdYu+YCkDUDCeRTpWy8Bl5zRVGPtI1wxTLdQL3Kjia7Jb
         1YkeRSbHDaoaCSgNk/tnvHRu7zK6g7aPuqA3kAv0+xu9JJNE/7o2IRSROA2eQaVrtZmr
         eY5ZU+PjPQsp8HJeLNm5YYkhPKYlo1Cv2+u/CLU4yG4ngOgSaX4mRC1rhsoPAQ4i4FYB
         2X/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=zUwKuXVahJyp/hQO8G1awzpws5SvESmOxM/EZj/byGc=;
        b=b1CbBvRunJAg7Gz43RozUmF3KpTFORHKkpBZNM7VUVfHF10BTZ7cfPs7X4la6CDNEV
         Rqj7g16JE7imsbXxaxQ/ueqygwrRS9kjMiIrvZLmYWLtj51dFs78DiNHJc/y7DPITxBk
         mBBTFUtcMNFjB6PbX15/221gFZolY1xkNLRWWw4IdoD1lEuq58yqiqI3m1H7Bl5g5Ulo
         j/xwZcs/kkQt0naU2t5WprA7BUR7iFcIpZN0AkjoOZ/ygVk037kaXcmkA9/NzyvF2O5l
         YAWsJvlmVQQRyqdg31BHdswKZ3feltaRNvH1pKfq5OpfI5NDPexn8+QogpyrmQ0pLdQ0
         DJqg==
X-Gm-Message-State: AHPjjUhc8DzDIVn14RpeOn0zO6lPxy+OwM0DQ4Gn9CAthlL0nhTlpGPm
        e4v/WO9TYiWX96NftrwHC60X7mkjwgh/ErAnQL0=
X-Google-Smtp-Source: ADKCNb4JWrS97VSqMS2QEWUe23ejiMYaepSKd2jivNbNL47M0M18yRyDyket4tcbbVAZymCmZqMHuLeNyx3k/bR2fdI=
X-Received: by 10.98.27.8 with SMTP id b8mr31309236pfb.21.1505725892135; Mon,
 18 Sep 2017 02:11:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.160.13 with HTTP; Mon, 18 Sep 2017 02:11:31 -0700 (PDT)
In-Reply-To: <20170917093906.16325-6-linus.walleij@linaro.org>
References: <20170917093906.16325-1-linus.walleij@linaro.org> <20170917093906.16325-6-linus.walleij@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Sep 2017 11:11:31 +0200
X-Google-Sender-Auth: RVIuqdNp75g_BAqEI6UpH2OTLmE
Message-ID: <CAMuHMdX=AyJ2JVSBO8YwcfCMxEFAwEHe7Wxd_d4OreZaWFoF=A@mail.gmail.com>
Subject: Re: [PATCH 5/7] i2c: gpio: Local vars in probe
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
X-archive-position: 60050
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

On Sun, Sep 17, 2017 at 11:39 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> By creating local variables for *dev and *np, the code become
> much easier to read, in my opinion.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I put this at the end of the series because compared to the
> rest of the patches it is completely unimportant.
> ---
>  drivers/i2c/busses/i2c-gpio.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
> index 97b9c29e9429..beb5ce523684 100644
> --- a/drivers/i2c/busses/i2c-gpio.c
> +++ b/drivers/i2c/busses/i2c-gpio.c

> @@ -99,15 +101,15 @@ static int i2c_gpio_probe(struct platform_device *pdev)
>         bit_data = &priv->bit_data;
>         pdata = &priv->pdata;
>
> -       if (pdev->dev.of_node) {
> -               of_i2c_gpio_get_props(pdev->dev.of_node, pdata);
> +       if (np) {
> +               of_i2c_gpio_get_props(np, pdata);
>         } else {
>                 /*
>                  * If all platform data settings are zero it is OK
>                  * to not provide any platform data from the board.
>                  */
> -               if (dev_get_platdata(&pdev->dev))
> -                       memcpy(pdata, dev_get_platdata(&pdev->dev),
> +               if (dev_get_platdata(dev))
> +                       memcpy(pdata, dev_get_platdata(dev),
>                                sizeof(*pdata));

This fits on one line again (you have to do something to offset the LoC
increase 14 insertions(+), 12 deletions(-) ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
