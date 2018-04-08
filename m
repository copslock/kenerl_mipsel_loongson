Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Apr 2018 23:31:03 +0200 (CEST)
Received: from mail-oi0-x243.google.com ([IPv6:2607:f8b0:4003:c06::243]:41555
        "EHLO mail-oi0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990477AbeDHVayTP4sY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 Apr 2018 23:30:54 +0200
Received: by mail-oi0-x243.google.com with SMTP id 188-v6so5811673oih.8
        for <linux-mips@linux-mips.org>; Sun, 08 Apr 2018 14:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LhmPbpCSJYRJGIiIJfvC3MVexdc1m4deLuErqrO/Po0=;
        b=LEPyaE32fMt61wbH+w6aRlNbYVD3c3o0hHcAaovZXmKel+68QZVKNHqEwJeTmf5NMU
         x/+8JT7jmD8An/33SfS320Z+GkqBG+aT/ERt8YoMQwUVrT3Kr0ku4732mQSyTGSiBrjk
         8fAFo7VzQGuIop3qy32X0Hoxbn9LaJeY9Fc+feabypoyfPGuZUmV5vqxKTjBqjqrTHHd
         9OXFDvXJI44+IhkRBdANuNR2fmkJIgEHHt2yBl4RB157j+XDAc9Z0amIPmRNa2d50Iku
         1S5kuRmypUqGwqp42nZ88oVHGz/EnOgebBPV6IVQJnB0nvquJB9ilbqxPsusJXd1pWSN
         5qGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LhmPbpCSJYRJGIiIJfvC3MVexdc1m4deLuErqrO/Po0=;
        b=bbBTyMCvsCMzpYO7WiaeFq2qKnkjb+IYxmts5q6ndJ33L2ZZRSjgMsUQIgnBj9Zw/R
         w2iqmi31mYOV+f/oXVXtfCNX/780eABXBQyle/3XAm7cfBX2iU4PzU43/S2FnW6tSEgm
         vkF2ds3a8IAICR7dRpcLsDGH6AXy5SDnOD4JrOQz171Aw1viyuAbD5QRYsL+Fle3+1gA
         Dd9BB1muXC6vGGTgRY1A43kHKeu1UX4+JZ0Mi99xIOUkpPOyneRTsNFFuROfA2WDPuK6
         3oj8pZIdRN9olWCRhnrQRwJAmWzt7wqJOk6ypTwCqIu10qQd/vUqFmlrkn0HrBk+lOZR
         5hHQ==
X-Gm-Message-State: ALQs6tCuOe5AhhUXM+x3W7YHyannHC0WDU8HgnAS7aTyALN+4f/ptagO
        aJSPwdrQ9wJEj5xe/LsymcPHwQrNAP4iFfKVA4g=
X-Google-Smtp-Source: AIpwx4+bJNWPWuab/3CjCbqrhVEMA6+76TLi7iCmV4OOFgv+othkoJcP3pu4aTQUYViKdZmK+/zyzgRbpiPIgb7J3ls=
X-Received: by 2002:aca:e54b:: with SMTP id c72-v6mr19065856oih.65.1523223047880;
 Sun, 08 Apr 2018 14:30:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.138.5.70 with HTTP; Sun, 8 Apr 2018 14:30:27 -0700 (PDT)
In-Reply-To: <1523176203-18926-1-git-send-email-dev@kresin.me>
References: <1523176203-18926-1-git-send-email-dev@kresin.me>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 8 Apr 2018 23:30:27 +0200
Message-ID: <CAFBinCCQO4B3a+ft7H1mMgfaS4=qSnmern3ZqD3QGt0815Oh0w@mail.gmail.com>
Subject: Re: [PATCH] MIPS: lantiq: gphy: Drop reboot/remove reset asserts
To:     Mathias Kresin <dev@kresin.me>, Hauke Mehrtens <hauke@hauke-m.de>
Cc:     john@phrozen.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <martin.blumenstingl@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: martin.blumenstingl@googlemail.com
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

On Sun, Apr 8, 2018 at 10:30 AM, Mathias Kresin <dev@kresin.me> wrote:
> While doing a global software reset, these bits are not cleared and let
> some bootloader fail to initialise the GPHYs. The bootloader don't
> expect the GPHYs in reset, as they aren't during power on.
>
> The asserts were a workaround for a wrong syscon-reboot mask. With a
> mask set which includes the GPHY resets, these resets aren't required
> any more.
>
> Fixes: 126534141b45 ("MIPS: lantiq: Add a GPHY driver which uses the RCU syscon-mfd")
> Cc: stable@vger.kernel.org # 4.14+
> Signed-off-by: Mathias Kresin <dev@kresin.me>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

thank you Mathias!
@Hauke: maybe you can also review this and give feedback?

> ---
>  drivers/soc/lantiq/gphy.c | 34 ----------------------------------
>  1 file changed, 34 deletions(-)
>
> diff --git a/drivers/soc/lantiq/gphy.c b/drivers/soc/lantiq/gphy.c
> index 8d86594..8c31ae7 100644
> --- a/drivers/soc/lantiq/gphy.c
> +++ b/drivers/soc/lantiq/gphy.c
> @@ -30,7 +30,6 @@ struct xway_gphy_priv {
>         struct clk *gphy_clk_gate;
>         struct reset_control *gphy_reset;
>         struct reset_control *gphy_reset2;
> -       struct notifier_block gphy_reboot_nb;
>         void __iomem *membase;
>         char *fw_name;
>  };
> @@ -64,24 +63,6 @@ static const struct of_device_id xway_gphy_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, xway_gphy_match);
>
> -static struct xway_gphy_priv *to_xway_gphy_priv(struct notifier_block *nb)
> -{
> -       return container_of(nb, struct xway_gphy_priv, gphy_reboot_nb);
> -}
> -
> -static int xway_gphy_reboot_notify(struct notifier_block *reboot_nb,
> -                                  unsigned long code, void *unused)
> -{
> -       struct xway_gphy_priv *priv = to_xway_gphy_priv(reboot_nb);
> -
> -       if (priv) {
> -               reset_control_assert(priv->gphy_reset);
> -               reset_control_assert(priv->gphy_reset2);
> -       }
> -
> -       return NOTIFY_DONE;
> -}
> -
>  static int xway_gphy_load(struct device *dev, struct xway_gphy_priv *priv,
>                           dma_addr_t *dev_addr)
>  {
> @@ -205,14 +186,6 @@ static int xway_gphy_probe(struct platform_device *pdev)
>         reset_control_deassert(priv->gphy_reset);
>         reset_control_deassert(priv->gphy_reset2);
>
> -       /* assert the gphy reset because it can hang after a reboot: */
> -       priv->gphy_reboot_nb.notifier_call = xway_gphy_reboot_notify;
> -       priv->gphy_reboot_nb.priority = -1;
> -
> -       ret = register_reboot_notifier(&priv->gphy_reboot_nb);
> -       if (ret)
> -               dev_warn(dev, "Failed to register reboot notifier\n");
> -
>         platform_set_drvdata(pdev, priv);
>
>         return ret;
> @@ -224,17 +197,10 @@ static int xway_gphy_remove(struct platform_device *pdev)
>         struct xway_gphy_priv *priv = platform_get_drvdata(pdev);
>         int ret;
>
> -       reset_control_assert(priv->gphy_reset);
> -       reset_control_assert(priv->gphy_reset2);
> -
>         iowrite32be(0, priv->membase);
>
>         clk_disable_unprepare(priv->gphy_clk_gate);
>
> -       ret = unregister_reboot_notifier(&priv->gphy_reboot_nb);
> -       if (ret)
> -               dev_warn(dev, "Failed to unregister reboot notifier\n");
> -
>         return 0;
>  }
>
> --
> 2.7.4
>
