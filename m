Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Apr 2017 11:57:40 +0200 (CEST)
Received: from mail-lf0-x22f.google.com ([IPv6:2a00:1450:4010:c07::22f]:35896
        "EHLO mail-lf0-x22f.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992078AbdDCJ5cZEXvr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Apr 2017 11:57:32 +0200
Received: by mail-lf0-x22f.google.com with SMTP id x137so69665127lff.3
        for <linux-mips@linux-mips.org>; Mon, 03 Apr 2017 02:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=eDUBV6FQ0gl9GhIj7MuXF72CMwBo/5s1CkZce5qs6bg=;
        b=tGV8sss7/IGdm2B+RxTGsqK7PVXDxKx/etrECLL4BUzesmCzr3fNgpI8MrnEv/B3Ib
         QBGRc0xLUHwTJLLY+XFBVMAe0M+uBM2kUJYDgOowfd85CBrAg7EReSPP0g5PWRjlc/Ms
         TDI/9ItIjWCrwiKyo7t72i354+F/dlyDDpW9LXTZNhSwalCL+t5C3uNf2GyTGuilwXwC
         X531xBSUmHFI5dTIFaC7beW3t9ZuoAmfgLE3Qh+USkisgRNaNL4iF4Vx7z87Jy+GGLjX
         FWjNB3wZgj0w8MmMn9uUx13pR4dmuWblLhsrGagR0dq0wmlKYibZjUaPbybd6+4zM4gT
         SGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=eDUBV6FQ0gl9GhIj7MuXF72CMwBo/5s1CkZce5qs6bg=;
        b=EYTZfJX8EPMM2k5DaB2oYBPZoGpJX2U5FpqCCtzyLe3LLEnNbEzaDipt3mXLsc4siQ
         sXL8c1Oar57hyqaOiwh7xf55cypOJvvIlxeAIyDDu911mS4gwzl9zAAn3U8q9wCH9tRC
         glpdFaryKXPLM1LoODNFiED5xSsgV6rV7xtVooICZBnqSWPGf6G2on7XtTI1IERXbzH5
         7QZaHyQSL6Z1PhNRsGlUhFLvbDjOFXkFukgGCXpiqB/SfZZk5TY3A+fBNoiVgOEac5bV
         9CNujvd9lmAqgjMKqwnoLgjYv3oW8mAxH189J7rFIZ7Kc4AUttS/gRVCoxGObmbTb33R
         Pbtw==
X-Gm-Message-State: AFeK/H0+UCx8Y/XUK8SsNK7wiGgJFxrelS2fJDXjXH8vUrZQFBKJd3xJEOWwSAjn2+qc6g==
X-Received: by 10.46.21.76 with SMTP id 12mr4871751ljv.98.1491213446999;
        Mon, 03 Apr 2017 02:57:26 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.87.23])
        by smtp.gmail.com with ESMTPSA id l11sm2375335ljb.45.2017.04.03.02.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Apr 2017 02:57:26 -0700 (PDT)
Subject: Re: [PATCH v4 06/14] MIPS: jz4740: DTS: Add nodes for ingenic pinctrl
 and gpio drivers
To:     Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <20170125185207.23902-2-paul@crapouillou.net>
 <20170402204244.14216-1-paul@crapouillou.net>
 <20170402204244.14216-7-paul@crapouillou.net>
Cc:     Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>, james.hogan@imgtec.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <48f7f4ee-b8e3-0096-ddea-2fbe0b399b40@cogentembedded.com>
Date:   Mon, 3 Apr 2017 12:57:25 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170402204244.14216-7-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57547
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

Hello!

On 4/2/2017 11:42 PM, Paul Cercueil wrote:

> For a description of the pinctrl devicetree node, please read
> Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
>
> For a description of the gpio devicetree nodes, please read
> Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
[...]

> diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
> index 3e1587f1f77a..9c23c877fc34 100644
> --- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
> +++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
> @@ -55,6 +55,67 @@
>  		clock-names = "rtc";
>  	};
>
> +	pinctrl: ingenic-pinctrl@10010000 {

    The node name should be generic, so please rename it to something like 
"pin-controller@..."

> +		compatible = "ingenic,jz4740-pinctrl";
> +		reg = <0x10010000 0x400>;
> +
> +		gpa: gpio-controller@0 {

    The name should be just "gpio@0", according to ePAPR and its successor 
spec. Although, using the <unit-address> without the "reg" prop isn't allowed 
either...

[...]

MBR, Sergei
