Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2018 13:15:26 +0200 (CEST)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:33041
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990393AbeFSLPRJON8u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2018 13:15:17 +0200
Received: by mail-wm0-x243.google.com with SMTP id z6-v6so18487253wma.0
        for <linux-mips@linux-mips.org>; Tue, 19 Jun 2018 04:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3qG2GD9vEydpZNA+93iHdGaoMR6QtDzUT2eZmaGdZXQ=;
        b=EE/NXf01ichKu/Q4IegwGIfQvryjFVhd0A4AdLG5a4IogkdRY5i8D6882ORg46qQaR
         Sn8oHipaKHpHKzvddbw+uXS+Ay5qWx7lwW3cVPrUJ+WEzQAV8ePQZIzmyrc4/bUjE9Hg
         td+C3YgLNLMf2ZYkwhrOXBVRbZKYxs/sHzmDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3qG2GD9vEydpZNA+93iHdGaoMR6QtDzUT2eZmaGdZXQ=;
        b=O+lqTMSOn2FFz8gkJyDgi3yulYuO7lyM4JUdXufaA0SjUaa85OdJe+8RQWZfRjLY+z
         Ypn9WM3+SKEs3G6hiRGwvL2C9lOBOqsUfonyjzAPLCUysjrM+1T18F5T1vDQR/K5oL1d
         gNy7WLt1gDefAmHPUdyYHXJdhdAqt3rryxBz6ZTMW0H5Sdfpvyao6+0hmJHidtW39snF
         HWFmAGe4voP5EcG5N1v36IS8XrfZisG6gntYi8Jm4ARUnK66wHrsdf02Mp8CzakWqj3M
         492F6YL5wJSEZx3iZZA2wHWIn0rN7wVv05d0aK3pTzkyPmi/7BbNjb/1OHnU7H72j5Oe
         YP8g==
X-Gm-Message-State: APt69E1vpzXnAUlBpmznQy1KQRq6ijEu0F4eYVx5Wfy9N7FVb1D76ikQ
        Iw6fkHWXEvSxe5GsR/o6UfYMfg==
X-Google-Smtp-Source: ADUXVKLwXSqEjjeC4a+6kT2LyeacjjTFB4xWuqz1zoOPAqHs1z5t2MoyIhKl7TklkLPWHf9gPNt9SQ==
X-Received: by 2002:a50:9553:: with SMTP id v19-v6mr14701044eda.268.1529406911245;
        Tue, 19 Jun 2018 04:15:11 -0700 (PDT)
Received: from [192.168.1.180] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id s2-v6sm9616725edm.13.2018.06.19.04.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 04:15:10 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: Fix unbalanced quotation marks
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        devicetree@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        James Hogan <jhogan@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-samsung-soc@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kukjin Kim <kgene@kernel.org>, linux-input@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Hauke Mehrtens <hauke@hauke-m.de>, linux-gpio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Anthony Kim <anthony.kim@hideep.com>, netdev@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20180617143127.11421-1-j.neuschaefer@gmx.net>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <1d775530-e250-6397-8e60-4dac8d580f7d@linaro.org>
Date:   Tue, 19 Jun 2018 12:15:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180617143127.11421-1-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <srinivas.kandagatla@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: srinivas.kandagatla@linaro.org
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



On 17/06/18 15:31, Jonathan Neuschäfer wrote:
>   example:
> diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt b/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
> index 6a4aadc4ce06..84b28dbe9f15 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
> +++ b/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
> @@ -30,7 +30,7 @@ Required properties:
>   
>   			  Board connectors:
>   			  * Headset Mic
> -			  * Secondary Mic",
> +			  * Secondary Mic
>   			  * DMIC
>   			  * Ext Spk
>   
> diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
> index aa54e49fc8a2..c7600a93ab39 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
> +++ b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
> @@ -35,7 +35,7 @@ This binding describes the APQ8096 sound card, which uses qdsp for audio.
>   			"Digital Mic3"
>   
>   		Audio pins and MicBias on WCD9335 Codec:
> -			"MIC_BIAS1
> +			"MIC_BIAS1"
>   			"MIC_BIAS2"
>   			"MIC_BIAS3"
>   			"MIC_BIAS4"

for apq8016 and apq8096 parts:

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
