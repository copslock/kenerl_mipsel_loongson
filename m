Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2018 20:23:24 +0200 (CEST)
Received: from mail-pl0-x244.google.com ([IPv6:2607:f8b0:400e:c01::244]:40358
        "EHLO mail-pl0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992835AbeFSSXROch0h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2018 20:23:17 +0200
Received: by mail-pl0-x244.google.com with SMTP id t12-v6so284444plo.7;
        Tue, 19 Jun 2018 11:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9yqKscspWioSQg/mdUQVbCb1IzDlTrgVuF38fd/HGmQ=;
        b=lrbd/+ywpi09p0kEaYhZf+gQj86n/cj7Tfoe4kQTnqqHeDW6Szv1u7Boe7dxskxv/p
         doMgGOetTFFrkiuBscnp3352XJQtGqlQDG/L+aKty+fbHvPZr8Loh3D1Ns7RNCZB7Prf
         6BZzv4adJgY5dHBPJRV17A7r0jMxltr11Sz7gAXraOpc3SkEHyo6GY1gI1zypcWff4+k
         qIfq/iyPHE5Wa62qVYiYUUuXxQXe6vgEbLdjL8fAzRlWyJ5Pe/tA9cHnOR+9LEeXzwmC
         ZRfQ67mkfUzr5MWrl72yXTMwkVucks26+3i2LJutzc0WYKqlXJe5P36jDZ3wh1x67V7h
         7Ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9yqKscspWioSQg/mdUQVbCb1IzDlTrgVuF38fd/HGmQ=;
        b=eVcZNqhSyz936inkqnrjzqgbc1y8F4d0m7+VRzf1RV/7g58XIqQ0rXGerZSEDo+XI0
         aNvAZtY0dP3mIXtM4catt4ekHn6opiq1LyM7nEZ73TWXZOW4akpURvZCPNOwcLMur2fL
         ftTkfDUM+Q8LEGiBZLs9wg0RcplzbXbSGE83aQC+f4vOCUEXF9x+NFIwGJu7KeA++dx3
         tEpwuio/zauZDEDGyCw3tW9tJnKC6oDSaEZiN1sCKP0L3sQTs33Jh2eAYodnfS+vKsjy
         t4mCWjsDT5ZydCxla4x2QqQRsEQrZDt+x8mclf8Od/Ru5Kboj2ptX442iRJh1jbwMgrq
         Ibmg==
X-Gm-Message-State: APt69E1ZAHDhczI2+LJ6TZxB1Xj7wGhRL/PXiVncpIQlPkb4d8l41wvs
        gVtEJjez2lw9pTtEdeZFClM=
X-Google-Smtp-Source: ADUXVKKWR7hGXcl7XrJBhq6yYQqfB2fAAlYr81pFpyd+9nIPixyf6o5FqzIVSM0se1l2Wn4EgfAIQQ==
X-Received: by 2002:a17:902:5402:: with SMTP id d2-v6mr15781793pli.38.1529432590593;
        Tue, 19 Jun 2018 11:23:10 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id r20-v6sm321175pgu.25.2018.06.19.11.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 11:23:09 -0700 (PDT)
Date:   Tue, 19 Jun 2018 11:23:07 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     devicetree@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
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
Message-ID: <20180619182307.GG71788@dtor-ws>
References: <20180617143127.11421-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180617143127.11421-1-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Return-Path: <dmitry.torokhov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.torokhov@gmail.com
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
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/hideep.txt b/Documentation/devicetree/bindings/input/touchscreen/hideep.txt
> index 121d9b7c79a2..1063c30d53f7 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/hideep.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/hideep.txt
> @@ -32,7 +32,7 @@ i2c@00000000 {
>  		reg = <0x6c>;
>  		interrupt-parent = <&gpx1>;
>  		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
> -		vdd-supply = <&ldo15_reg>";
> +		vdd-supply = <&ldo15_reg>;
>  		vid-supply = <&ldo18_reg>;
>  		reset-gpios = <&gpx1 5 0>;
>  		touchscreen-size-x = <1080>;

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

-- 
Dmitry
