Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2018 21:50:09 +0200 (CEST)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:36848
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992835AbeFSTuCEZgKI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2018 21:50:02 +0200
Received: by mail-wm0-x243.google.com with SMTP id v131-v6so2610326wma.1;
        Tue, 19 Jun 2018 12:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xW3LWItn3s+rq7xaiWNphrx0opOV3pMS1BhiZ2PRoqw=;
        b=jx4k2Wk7RiBFquNv5QNsVrDxbDsgozSEV525CqNKT7vZl7/ga43sfOxx401xtyqYAD
         NndJUeeienNtYT4vBpNWDF17TfChft52jO5Rt4X/26R+I0XszaaRXL8kLBev7G1dSliE
         LbCclXabDC3NECTBWBno909eEauir6oj6d8VK4P6UvDOd3yq5uempITO3oYMzpNMXWll
         weVgSwgG/KT9YKEpKqBGF8UwYD4QS2D/XqDQfHG2iwoOjofAc5zASQY2C2NJI/QVTzc3
         FNofLCrWENuxRwX0V0ZGC3TzRVz+8+9eXviMWBqb9hSvecB7fXKsnyMEAye3wSmzMXdL
         zyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xW3LWItn3s+rq7xaiWNphrx0opOV3pMS1BhiZ2PRoqw=;
        b=YCuOPhqIdE8pE8X/mDRsE+xtC+dZk8e0B6dqNRxy9A2M5KVWum/QHJVeM8f1YNniZ1
         TNagTF+udOLyyPC0/jjUhS/y13aub0JruBNccAn8+x1pC1MiUbwkHSuKrvANtLQjnw6T
         P8vhNH/Ln+FQgbAqfdJJYR2qKO0FxVPtcM7cm+pbyXJuJ3V2MBAst5kM552+5e7TUYea
         3JwOLXHwcZFxsachyj1mUz2az2Mnic+bFoLGwMg+OZ5eR0uLegYDIN5SVwyjsjQcthDX
         lg9g1K0rZDYh8EVZzBM2EmEkNR8VIzc8UizTlT08tw9p/q0QSXAD7nRhfAoZFf3QBKKZ
         kemg==
X-Gm-Message-State: APt69E0Dao8GAm40Hg5l7NViTPhfbj2w+nNTcob9HglhHeOV09kCS3Ck
        GRQuMbvJm+vwWrJn6mXvUhE=
X-Google-Smtp-Source: ADUXVKLUrx2fiFBxIY3gxMSZJtWGbEHeewy9eODhRaR/o2APeZhU4SczeO+3HJJEazMgOF2wUtAXIg==
X-Received: by 2002:a50:b671:: with SMTP id c46-v6mr16223611ede.190.1529437796649;
        Tue, 19 Jun 2018 12:49:56 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id h39-v6sm365554edb.65.2018.06.19.12.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 12:49:55 -0700 (PDT)
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
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <f5ffdbd1-d357-fa8d-9fdb-461cf2b9ad89@gmail.com>
Date:   Tue, 19 Jun 2018 12:49:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180617143127.11421-1-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 06/17/2018 07:31 AM, Jonathan Neuschäfer wrote:
> Multiple binding documents have various forms of unbalanced quotation
> marks. Fix them.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---

[snip]

>  Documentation/devicetree/bindings/mips/brcm/soc.txt             | 2 +-

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
