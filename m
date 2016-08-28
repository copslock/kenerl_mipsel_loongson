Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Aug 2016 12:33:48 +0200 (CEST)
Received: from mail-lf0-f47.google.com ([209.85.215.47]:33607 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992093AbcH1Kdk0JyiV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Aug 2016 12:33:40 +0200
Received: by mail-lf0-f47.google.com with SMTP id b199so83269416lfe.0
        for <linux-mips@linux-mips.org>; Sun, 28 Aug 2016 03:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=/MZ81EvVq9D6NZpbHt+j5a76pYm4h/VjcNqWKE21T30=;
        b=YBKNBiQEP8vbE1nqDcv2mcf429YdRhsl7/AvFu6OZTrK3qmqX226EHovT4oT3CyjkE
         1efuUbwJj5/ewvaPySPsyijf6pLNCZZRF6LldzXd6JSIkXjH9ulH26VkzQk2U6djf7er
         jkIs/crv0664QUJxoRaxxofCgNx3VWPS6TU7ZZ0jdcyJ3IYV16ZWLMnCNdp3/WyNzLiu
         DjFAxrWpR3tQpPc6GU1BLoDyKonI57S5qseF61jb3bPXhONycyLswwGk/bXiH8MhR2a/
         PCwxwsdDWXbTDu6xPS5Pm/+Yc6X55q6Xc/hMDYWS1+6lAkqqagGi2mo+tDbWiqhPIRIC
         7RYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=/MZ81EvVq9D6NZpbHt+j5a76pYm4h/VjcNqWKE21T30=;
        b=KsAz6NYqxShS4NF6WTFqKFqnKPaF73kHnoKQCavpsMThswVG6vYilzmnwATI6evDkF
         b8ks55XIBSYhAi8uJ1iUVm6/hkT+QTj+i04cDOTOtHngF0p/r495rJU+N0nR16hRO2NR
         eQf8dM7iwOZC6au+iJPJhvluedQ4wMroLnJO3ic8wnPBGpfGhgjc31qh9UG2O87IVpxr
         5Yw4ZDHXnfH+/kjHPaU/GLrFB+HlHvHAOxyDJ80H+UlVrWJtFv3us+ekI6T0eaPhyizo
         taT14Njpjez44BWkCVW/SuIPOwlqRTdU2wVtTcccbWcE6Wo6D3WlyHQn9AIh5X5fYoeL
         REvw==
X-Gm-Message-State: AE9vXwMDe8gQIj6s5C0utAcwjzSNoEferPFt234hFh6WaOXG4Ek02BTGDJVJaIpVnF0p3g==
X-Received: by 10.25.19.169 with SMTP id 41mr3188446lft.24.1472380414698;
        Sun, 28 Aug 2016 03:33:34 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.81.39])
        by smtp.gmail.com with ESMTPSA id 98sm5467955lja.37.2016.08.28.03.33.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Aug 2016 03:33:33 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] hw_random: jz4780-rng: Add RNG node to jz4780.dtsi
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        mpm@selenic.com, herbert@gondor.apana.org.au, robh+dt@kernel.org,
        mark.rutland@arm.com, ralf@linux-mips.org,
        gregkh@linuxfoundation.org, boris.brezillon@free-electrons.com,
        harvey.hunt@imgtec.com, prarit@redhat.com, f.fainelli@gmail.com,
        joshua.henderson@microchip.com, narmstrong@baylibre.com,
        linus.walleij@linaro.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
References: <1472321697-3094-1-git-send-email-prasannatsmkumar@gmail.com>
 <1472321697-3094-4-git-send-email-prasannatsmkumar@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <7a3874e2-069e-7bdf-2289-3364ec2c8cc4@cogentembedded.com>
Date:   Sun, 28 Aug 2016 13:33:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1472321697-3094-4-git-send-email-prasannatsmkumar@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 8/27/2016 9:14 PM, PrasannaKumar Muralidharan wrote:

> This patch adds RNG node to jz4780.dtsi.
>
> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> ---
>  arch/mips/boot/dts/ingenic/jz4780.dtsi | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> index b868b42..f11d139 100644
> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> @@ -36,7 +36,7 @@
>
>  	cgu: jz4780-cgu@10000000 {
>  		compatible = "ingenic,jz4780-cgu";
> -		reg = <0x10000000 0x100>;
> +		reg = <0x10000000 0xD8>;

    I think lower case is preferred here.

>
>  		clocks = <&ext>, <&rtc>;
>  		clock-names = "ext", "rtc";
> @@ -44,6 +44,11 @@
>  		#clock-cells = <1>;
>  	};
>
> +	rng: jz4780-rng@100000D8 {

    All in lower case, please.

> +		compatible = "ingenic,jz4780-rng";
> +		reg = <0x100000D8 0x8>;

    Likewise.

[...]

MBR, Sergei
