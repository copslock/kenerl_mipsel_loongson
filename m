Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2018 09:07:15 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:46778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994551AbeFRHHDIIEwN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jun 2018 09:07:03 +0200
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CBE7208E7;
        Mon, 18 Jun 2018 07:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529305615;
        bh=4ZYFG1TnLxxT8on8ktrEz7UhOVRcpYgKuwmuDa4az9o=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=iEiG4jvytPZtwpU15iRI0ZiQuU0Y5K8gd+P4dlBceh4QiCxU58waprp+/YAcat4Yv
         9cSBKct8XHpp/9GR4o4zfqg35mxqIWPMOlmOkTn7TsPtzJo3BhDzoUhrzdbQgoP06g
         tZUDq3wV1bXDAdv5si0AfHh9S0/ydPBgo4lRFVQc=
Received: by mail-wm0-f46.google.com with SMTP id o13-v6so12142762wmf.4;
        Mon, 18 Jun 2018 00:06:55 -0700 (PDT)
X-Gm-Message-State: APt69E3xiJm1yksPxHTzsyQ+21V6uhmOB54hSKy8xecx5BJSn/+JanWT
        5GrDZbJG2NRQR7TRs2ffw70nGiknt/x876gns28=
X-Google-Smtp-Source: ADUXVKJU9gWVlcj+yRVl3049YozY9P9RtZj4/L2gJu6Ei7m38f4Jyz5oPgD0+ND9eHX0xp+s6GC08IaYRSBZbpN9Oq4=
X-Received: by 2002:a1c:c05:: with SMTP id 5-v6mr8153967wmm.117.1529305613911;
 Mon, 18 Jun 2018 00:06:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9166:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 00:06:53
 -0700 (PDT)
In-Reply-To: <20180617143127.11421-1-j.neuschaefer@gmx.net>
References: <20180617143127.11421-1-j.neuschaefer@gmx.net>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 18 Jun 2018 09:06:53 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcAVovxU2mHSbkAG0axutFbd=_92bNdd2P_CnQGmhAfCg@mail.gmail.com>
Message-ID: <CAJKOXPcAVovxU2mHSbkAG0axutFbd=_92bNdd2P_CnQGmhAfCg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Fix unbalanced quotation marks
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     devicetree@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anthony Kim <anthony.kim@hideep.com>,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, linux-pm@vger.kernel.org,
        alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <krzk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: krzk@kernel.org
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

On Sun, Jun 17, 2018 at 4:31 PM, Jonathan Neuschäfer
<j.neuschaefer@gmx.net> wrote:
> Multiple binding documents have various forms of unbalanced quotation
> marks. Fix them.
>
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>
> Should I split this patch so that different parts can go through different trees?
> ---
>  .../devicetree/bindings/arm/samsung/samsung-boards.txt          | 2 +-
>  .../devicetree/bindings/gpio/nintendo,hollywood-gpio.txt        | 2 +-
>  Documentation/devicetree/bindings/input/touchscreen/hideep.txt  | 2 +-
>  .../bindings/interrupt-controller/nvidia,tegra20-ictlr.txt      | 2 +-
>  .../devicetree/bindings/interrupt-controller/st,stm32-exti.txt  | 2 +-
>  Documentation/devicetree/bindings/mips/brcm/soc.txt             | 2 +-
>  Documentation/devicetree/bindings/net/fsl-fman.txt              | 2 +-
>  Documentation/devicetree/bindings/power/power_domain.txt        | 2 +-
>  Documentation/devicetree/bindings/regulator/tps65090.txt        | 2 +-
>  Documentation/devicetree/bindings/reset/st,sti-softreset.txt    | 2 +-
>  Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt    | 2 +-
>  Documentation/devicetree/bindings/sound/qcom,apq8096.txt        | 2 +-
>  12 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> index bdadc3da9556..6970f30a3770 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> @@ -66,7 +66,7 @@ Required root node properties:
>         - "insignal,arndale-octa" - for Exynos5420-based Insignal Arndale
>                                     Octa board.
>         - "insignal,origen"       - for Exynos4210-based Insignal Origen board.
> -       - "insignal,origen4412    - for Exynos4412-based Insignal Origen board.
> +       - "insignal,origen4412"   - for Exynos4412-based Insignal Origen board.
>

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
