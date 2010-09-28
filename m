Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Sep 2010 10:01:52 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:59415 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491049Ab0I1IBt convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Sep 2010 10:01:49 +0200
Received: by iwn41 with SMTP id 41so1877059iwn.36
        for <multiple recipients>; Tue, 28 Sep 2010 01:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=GQorPI/iT8zE2mUyigczCZNbwdlqq87w1aFasDRthME=;
        b=DpW9I1kXYF7ec8isgNfI8STaMQP9/tO0+IKwNOf03+GKJUSPc2o444Q+43AStxNwNz
         bXB/0vwPKRYAkKX2vn72cBAGC98J0yC5ra4oO9LuQhcOL7bSmR8YrYyRgDcy68JmYpiw
         ykvf/E7L5L24ZrYsm0nrK7cYzJg8iGWrGR7ro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=HGbwTC5LkQhDCMvu769U8FH9ZaheRAaD9ShietUjlbKC94MGm9TkCRxj1h2fRzN8Zw
         WbRPmbBghcnVU8IvjZG6ZTvJfHeDSIFjdvhyH9wbNOrQfHXP41FtK9CnMazdPrukIWul
         NET6B8iy0S7bn93uhrYnalBJf+6EYNr87k6Ao=
Received: by 10.231.146.141 with SMTP id h13mr10314409ibv.1.1285660903500;
 Tue, 28 Sep 2010 01:01:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.231.199.141 with HTTP; Tue, 28 Sep 2010 01:01:22 -0700 (PDT)
In-Reply-To: <1285659648-21409-4-git-send-email-arun.murthy@stericsson.com>
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com> <1285659648-21409-4-git-send-email-arun.murthy@stericsson.com>
From:   Eric Miao <eric.y.miao@gmail.com>
Date:   Tue, 28 Sep 2010 16:01:22 +0800
Message-ID: <AANLkTi=0xKWPNn+b1kfPyMTs_mxsYqx+Cd+R1aTZiycg@mail.gmail.com>
Subject: Re: [PATCH 3/7] leds: pwm: add a new element 'name' to platform data
To:     Arun Murthy <arun.murthy@stericsson.com>
Cc:     linux@arm.linux.org.uk, grinberg@compulab.co.il,
        mike@compulab.co.il, robert.jarzmik@free.fr, marek.vasut@gmail.com,
        drwyrm@gmail.com, stefan@openezx.org, laforge@openezx.org,
        ospite@studenti.unina.it, philipp.zabel@gmail.com,
        mad_soft@inbox.ru, maz@misterjones.org, daniel@caiaq.de,
        haojian.zhuang@marvell.com, timur@freescale.com,
        ben-linux@fluff.org, support@simtec.co.uk,
        arnaud.patard@rtp-net.org, dgreenday@gmail.com, anarsoul@gmail.com,
        akpm@linux-foundation.org, mcuelenaere@gmail.com,
        kernel@pengutronix.de, andre.goddard@gmail.com, jkosina@suse.cz,
        tj@kernel.org, hsweeten@visionengravers.com,
        u.kleine-koenig@pengutronix.de, kgene.kim@samsung.com,
        ralf@linux-mips.org, lars@metafoo.de, dilinger@collabora.co.uk,
        mroth@nessie.de, randy.dunlap@oracle.com, lethal@linux-sh.org,
        rusty@rustcorp.com.au, damm@opensource.se, mst@redhat.com,
        rpurdie@rpsys.net, sguinot@lacie.co, sameo@linux.intel.com,
        broonie@opensource.wolfsonmicro.com, balajitk@ti.com,
        rnayak@ti.com, santosh.shilimkar@ti.com, hemanthv@ti.com,
        michael.hennerich@analog.com, vapier@gentoo.org,
        khali@linux-fr.org, jic23@cam.ac.uk, re.emese@gmail.com,
        linux@simtec.co.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linus.walleij@stericsson.com, mattias.wallin@stericsson.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 27844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eric.y.miao@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 22127

On Tue, Sep 28, 2010 at 3:40 PM, Arun Murthy <arun.murthy@stericsson.com> wrote:
> A new element 'name' is added to pwm led platform data structure.
> This is required to identify the pwm device.

I cannot see what this name is used for?

>
> Signed-off-by: Arun Murthy <arun.murthy@stericsson.com>
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
>  drivers/leds/leds-pwm.c  |    4 +++-
>  include/linux/leds_pwm.h |    1 +
>  2 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
> index da3fa8d..8da2be6 100644
> --- a/drivers/leds/leds-pwm.c
> +++ b/drivers/leds/leds-pwm.c
> @@ -66,8 +66,10 @@ static int led_pwm_probe(struct platform_device *pdev)
>                cur_led = &pdata->leds[i];
>                led_dat = &leds_data[i];
>
> +               if (!pdata->name)
> +                       pdata->name = cur_led->name;
>                led_dat->pwm = pwm_request(cur_led->pwm_id,
> -                               cur_led->name);
> +                               pdata->name);
>                if (IS_ERR(led_dat->pwm)) {
>                        dev_err(&pdev->dev, "unable to request PWM %d\n",
>                                        cur_led->pwm_id);
> diff --git a/include/linux/leds_pwm.h b/include/linux/leds_pwm.h
> index 33a0711..7a847a0 100644
> --- a/include/linux/leds_pwm.h
> +++ b/include/linux/leds_pwm.h
> @@ -16,6 +16,7 @@ struct led_pwm {
>  struct led_pwm_platform_data {
>        int                     num_leds;
>        struct led_pwm  *leds;
> +       char *name;
>  };
>
>  #endif
> --
> 1.7.2.dirty
>
>
