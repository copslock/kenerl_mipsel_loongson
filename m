Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jun 2016 13:47:25 +0200 (CEST)
Received: from caladan.dune.hu ([78.24.191.180]:58756 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27041932AbcFCLrWU3lRv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Jun 2016 13:47:22 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 38DDBB80EA0;
        Fri,  3 Jun 2016 13:47:21 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-vk0-f42.google.com (mail-vk0-f42.google.com [209.85.213.42])
        by arrakis.dune.hu (Postfix) with ESMTPSA id D87AAB80E04;
        Fri,  3 Jun 2016 13:46:37 +0200 (CEST)
Received: by mail-vk0-f42.google.com with SMTP id r140so110840466vkf.0;
        Fri, 03 Jun 2016 04:46:37 -0700 (PDT)
X-Gm-Message-State: ALyK8tKJ97Fn4Yq8GFKNW+3is3Z7IUyYoP4bwwF3CqsklEFHg3UPnkEGuzBvgzxy/b9mg0vh+M5GKAki5I7OfA==
X-Received: by 10.176.3.20 with SMTP id 20mr1519240uat.102.1464954396842; Fri,
 03 Jun 2016 04:46:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.67.227 with HTTP; Fri, 3 Jun 2016 04:46:17 -0700 (PDT)
In-Reply-To: <1464941524-3992-2-git-send-email-noltari@gmail.com>
References: <1464941524-3992-1-git-send-email-noltari@gmail.com> <1464941524-3992-2-git-send-email-noltari@gmail.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Fri, 3 Jun 2016 13:46:17 +0200
X-Gmail-Original-Message-ID: <CAOiHx=nu-5_CeHn8dki+v9nrP8uN2QH13gcNsejYKpt7dsmX2w@mail.gmail.com>
Message-ID: <CAOiHx=nu-5_CeHn8dki+v9nrP8uN2QH13gcNsejYKpt7dsmX2w@mail.gmail.com>
Subject: Re: [PATCH 2/3] MIPS: BMIPS: Add BCM6345 support
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh@kernel.org>, Simon Arlott <simon@fire.lp0.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Hi,

On 3 June 2016 at 10:12, Álvaro Fernández Rojas <noltari@gmail.com> wrote:
> BCM6345 has only one CPU, so SMP support must be disabled.
>
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  Documentation/devicetree/bindings/mips/brcm/soc.txt | 2 +-
>  arch/mips/bmips/setup.c                             | 9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mips/brcm/soc.txt b/Documentation/devicetree/bindings/mips/brcm/soc.txt
> index 4a7e030..1936e8a 100644
> --- a/Documentation/devicetree/bindings/mips/brcm/soc.txt
> +++ b/Documentation/devicetree/bindings/mips/brcm/soc.txt
> @@ -4,7 +4,7 @@ Required properties:
>
>  - compatible: "brcm,bcm3384", "brcm,bcm33843"
>                "brcm,bcm3384-viper", "brcm,bcm33843-viper"
> -              "brcm,bcm6328", "brcm,bcm6358", "brcm,bcm6368",
> +              "brcm,bcm6328", "brcm,bcm6345", "brcm,bcm6358", "brcm,bcm6368",
>                "brcm,bcm63168", "brcm,bcm63268",
>                "brcm,bcm7125", "brcm,bcm7346", "brcm,bcm7358", "brcm,bcm7360",
>                "brcm,bcm7362", "brcm,bcm7420", "brcm,bcm7425"

This is reasonable.

> diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
> index f146d12..b0d339d 100644
> --- a/arch/mips/bmips/setup.c
> +++ b/arch/mips/bmips/setup.c
> @@ -95,6 +95,14 @@ static void bcm6328_quirks(void)
>                 bcm63xx_fixup_cpu1();
>  }
>
> +static void bcm6345_quirks(void)
> +{
> +       /*
> +        * BCM6345 has only one CPU and no SMP support
> +        */
> +       bmips_smp_enabled = 0;
> +}
> +
>  static void bcm6358_quirks(void)
>  {
>         /*
> @@ -113,6 +121,7 @@ static const struct bmips_quirk bmips_quirk_list[] = {
>         { "brcm,bcm3384-viper",         &bcm3384_viper_quirks           },
>         { "brcm,bcm33843-viper",        &bcm3384_viper_quirks           },
>         { "brcm,bcm6328",               &bcm6328_quirks                 },
> +       { "brcm,bcm6345",               &bcm6345_quirks                 },
>         { "brcm,bcm6358",               &bcm6358_quirks                 },
>         { "brcm,bcm6368",               &bcm6368_quirks                 },
>         { "brcm,bcm63168",              &bcm6368_quirks                 },

This part is unnecessary, as cpu-bmips will only try to enable smp for
bmips4350 and higher. but not for bmips32/bmips3300.


Jonas
