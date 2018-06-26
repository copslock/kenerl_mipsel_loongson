Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2018 22:20:00 +0200 (CEST)
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34046 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993024AbeFZUTwFbeiQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2018 22:19:52 +0200
Received: by mail-yw0-f194.google.com with SMTP id n187-v6so3084360ywd.1;
        Tue, 26 Jun 2018 13:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sEs8xYQqaOmmEu9IKPYDXtH4HFrJC1G3e+oD+2L+L/4=;
        b=XNR+lVXsuMyi8hxr5wlXLWDcw0SDazgdxLfIg606teNgOcwH2yJqeaRNxCgh7LWPgY
         v/pg7LkPzXyewsiUNpzcNKdWgU60GlFFehqEdv7xeskny7KH7Mb5JHctH8ekP72ggVz4
         HXjL5N0JRuiwd3cGZYN/czAOvcxkJHkp8N5FsDKQ9hAroGlM027hCq3eGDSAtH6hZQNO
         5XFdVIpNzNmxhg9yIfgugNF7eDqIynyZyrGYKkv7KuElYAOqorhlYIzaC4Bf0lUfCZYT
         EY7vFK6y6ziaF/tIPJQTv+9AHoWglGKZeBSy94M06ZhJmYF6FN6UmlqPd9Ecv+N9pa0o
         lVwA==
X-Gm-Message-State: APt69E1OBTDfdlikHTDhcjRIEnIvlFMl3o+7lxd8vXT3iRNpsSBxHmnS
        fzBfe5ycKD6Rnq2KyVOYZQ==
X-Google-Smtp-Source: AAOMgpfovofvozXKjQrtR+6W/wFDBC37fbSObvademvSjcDZPlQhcokgfS45A9ZUOWsNONw2hQJ4Mg==
X-Received: by 2002:a0d:fb81:: with SMTP id l123-v6mr1590462ywf.47.1530044386010;
        Tue, 26 Jun 2018 13:19:46 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id d203-v6sm936351ywe.5.2018.06.26.13.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 13:19:45 -0700 (PDT)
Date:   Tue, 26 Jun 2018 14:19:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     devicetree@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
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
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
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
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, linux-pm@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] dt-bindings: Fix unbalanced quotation marks
Message-ID: <20180626201944.GA24678@rob-hp-laptop>
References: <20180617143127.11421-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180617143127.11421-1-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Sun, Jun 17, 2018 at 04:31:18PM +0200, Jonathan Neuschäfer wrote:
> Multiple binding documents have various forms of unbalanced quotation
> marks. Fix them.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> 
> Should I split this patch so that different parts can go through different trees?

No, I applied it. Thanks.

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
