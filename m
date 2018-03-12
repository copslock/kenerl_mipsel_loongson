Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 21:39:49 +0100 (CET)
Received: from mail-oi0-x244.google.com ([IPv6:2607:f8b0:4003:c06::244]:46436
        "EHLO mail-oi0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990421AbeCLUjdpDKI9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Mar 2018 21:39:33 +0100
Received: by mail-oi0-x244.google.com with SMTP id x12so13475318oie.13;
        Mon, 12 Mar 2018 13:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9NcMJ+iPjqvPG0iVZpFkh4zuuGyNzYpstWUFvR24Src=;
        b=Gbb+MhjUxDC1EssmZ3mNkQqoJJ7OiSZPQaTLwrR2PgFmTJb+LB8S/rq4XGoJMIXDEj
         79lFS+ed6fzEmWlCcDrgFlmcFgkWaFhKP24Js8OEWvOxBZBv0SRG4/PK1onFCLcgx8lM
         N2eYbIJlxupvD/ma0W7m90cfO3MMASE7WfVG+msJeTdA67VyWq2tHGmcRyT5qBC/k9lz
         tQ5Dco2tPDTK5+VovlmE9E6o4ntiOkcGSH/qp1dNWpJjz9sr6Zhu8utBnpcc9oCNJjQ8
         /657xOS1g7W+uQaIdbo+pIIR68WeOmjSzMJoK86DRpTgXLOx3inEVRtOjOampqfr1k+f
         +2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9NcMJ+iPjqvPG0iVZpFkh4zuuGyNzYpstWUFvR24Src=;
        b=aWgX0sqpymInYBJTdR1zDmUlGVZrVfs62xAj9BLbPnFl6+G5s/19TWNVmi83m14nY8
         udgIb4C7L1HoiJtHgYe562kbz7G2Utuv2gfjnqvAy6udTyLW7URmZspRE1FDw+Ye0sRf
         A3e1zDSynudIK/up098W7spT9Y0jDFNOt8BoSZawgL3ZOASRk2UusIl8Q057h6ApMDtx
         2IjKbNcbNLNijxrCwxJCA9/c1eJvWqXUUucadPwMoi83xRzFcJUeYkv8z+CpOofmcQG0
         9zWKFpnu3/SXOYufDmq/wen69Do0TwNzOLgUKBIpKBcpeiwhfNsLmMxepe0jJzMp0fog
         kNFA==
X-Gm-Message-State: AElRT7FJJSPgODRgA9/qXmD65/rj1R3N7ftUniefrZrIZne9D5FBqcrk
        Zrt5/zhp9Cglv0vQzMaLW3SdSrcBKlQRh/6YBkU=
X-Google-Smtp-Source: AG47ELsqDZvk+FvifutR9qtcV5L+Pq39RwrVIH5grpNGaDtxyHQBtCvDwr8QPHiUsx8IzWQUMIZferLgaNwbogb1SqU=
X-Received: by 10.202.227.137 with SMTP id a131mr5468922oih.19.1520887167229;
 Mon, 12 Mar 2018 13:39:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.64.3 with HTTP; Mon, 12 Mar 2018 13:39:06 -0700 (PDT)
In-Reply-To: <20180311174123.2578-1-hauke@hauke-m.de>
References: <20180311174123.2578-1-hauke@hauke-m.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 12 Mar 2018 21:39:06 +0100
Message-ID: <CAFBinCB083WnWmOJ=JhwrmgbP3TRO_1bXToKUU__fvERhJDW+w@mail.gmail.com>
Subject: Re: [PATCH 1/3] MIPS: lantiq: fix danube usb clock
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, jhogan@kernel.org, john@phrozen.org,
        dev@kresin.me, linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <martin.blumenstingl@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62920
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

On Sun, Mar 11, 2018 at 6:41 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> From: Mathias Kresin <dev@kresin.me>
>
> On danube the USB0 registers are at 1e101000 similar to all other lantiq
> SoCs.
>
> Fixes: dea54fbad332 ("phy: Add an USB PHY driver for the Lantiq SoCs using the RCU module")
> Signed-off-by: Mathias Kresin <dev@kresin.me>
Acked-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>


> ---
>  arch/mips/lantiq/xway/sysctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
> index 52500d3b7004..f11f1dd10493 100644
> --- a/arch/mips/lantiq/xway/sysctrl.c
> +++ b/arch/mips/lantiq/xway/sysctrl.c
> @@ -560,7 +560,7 @@ void __init ltq_soc_init(void)
>         } else {
>                 clkdev_add_static(ltq_danube_cpu_hz(), ltq_danube_fpi_hz(),
>                                 ltq_danube_fpi_hz(), ltq_danube_pp32_hz());
> -               clkdev_add_pmu("1f203018.usb2-phy", "ctrl", 1, 0, PMU_USB0);
> +               clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0);
>                 clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 0, PMU_USB0_P);
>                 clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
>                 clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
> --
> 2.11.0
>
