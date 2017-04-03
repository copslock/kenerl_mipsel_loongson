Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Apr 2017 12:33:06 +0200 (CEST)
Received: from mail-lf0-x230.google.com ([IPv6:2a00:1450:4010:c07::230]:32989
        "EHLO mail-lf0-x230.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991359AbdDCKc6tAUCA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Apr 2017 12:32:58 +0200
Received: by mail-lf0-x230.google.com with SMTP id h125so70035369lfe.0
        for <linux-mips@linux-mips.org>; Mon, 03 Apr 2017 03:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=3+0eOxW7QBKhXq652ITo/V7H2ArVwgDA9rDiqZPYYpA=;
        b=uUNMUbowPjkv4p1OwXt38FypYxi70hFp3nljUVZLIiYCZS6F2lz7AAwix7sqiFQhTD
         eCFzznlokUnTAkjQNQRAzPs62ntQnKvLwkEUwNLwN0F68x/KIrn2hV4N2a7PBflsrald
         xq31f/sgMSKJ1F3d232Ivuj7XA1ZqyT/il9V7bB6koijbSVN1IQk0FVQosLgO0F0Kiio
         TsS/C9krV6zLcgOGl577KmuHYWOweVEjbpJWixiLBw/e9CEV4nRSXukn1ZSaAQGseOO2
         DX4qovHvlOsmsGFPefo9rtmxqnH4kyt+nWt9nE/EV9z436P8MDEfanvs31UmVfkQ9clF
         Cnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=3+0eOxW7QBKhXq652ITo/V7H2ArVwgDA9rDiqZPYYpA=;
        b=VCetBYs3+Wv/ymd017Ya2Q6J87gCSm0X795TSDTcEDq7Q6AEqkU8iBgz4YJj8rYDF3
         0Cchzj9hI57rfUi5s6gfk5IBXi1jGN49LJgnJTspWay7N1tLQ3id9rCnlIQmtPnR8ZI7
         9hXJHHT8fMzoEbnI4a96bbmEKgkyJW6vTtw2E4PNzyYXY4Jr2l7AUBWrpdL5hUQakYCX
         Jl55mYd1g4lOo1O5+Hm5sS4MQuAF2neUOhpZFywBr7PjHGQd74q5wpxI18G8MPePyBHI
         LuZ3UN9Y8QL/blutvPp6i2QqVgCf0oqsRLXIYCiiKs2SFa/bkyjG1MIYrLbIMVRAzNwG
         1IFg==
X-Gm-Message-State: AFeK/H1rQqr9U6ziqxIuOQQBL8UMn6/iuMyRtREYaE596O9Mz+UOH4kE7sLEYBuo/ymlyA==
X-Received: by 10.25.196.68 with SMTP id u65mr5092724lff.50.1491215568355;
        Mon, 03 Apr 2017 03:32:48 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.87.23])
        by smtp.gmail.com with ESMTPSA id x84sm2413357lfa.13.2017.04.03.03.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Apr 2017 03:32:47 -0700 (PDT)
Subject: Re: [PATCH v4 06/14] MIPS: jz4740: DTS: Add nodes for ingenic pinctrl
 and gpio drivers
To:     Paul Cercueil <paul@crapouillou.net>
References: <20170125185207.23902-2-paul@crapouillou.net>
 <20170402204244.14216-1-paul@crapouillou.net>
 <20170402204244.14216-7-paul@crapouillou.net>
 <48f7f4ee-b8e3-0096-ddea-2fbe0b399b40@cogentembedded.com>
 <cf809000718514ba612b4f7b477586a9@crapouillou.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
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
Message-ID: <b5d195a9-ec3d-1b92-b17c-e87bd6d990cf@cogentembedded.com>
Date:   Mon, 3 Apr 2017 13:32:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <cf809000718514ba612b4f7b477586a9@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57550
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

On 4/3/2017 1:20 PM, Paul Cercueil wrote:

>>> For a description of the pinctrl devicetree node, please read
>>> Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
>>>
>>> For a description of the gpio devicetree nodes, please read
>>> Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
>>>
>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> [...]
>>
>>> diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi
>>> b/arch/mips/boot/dts/ingenic/jz4740.dtsi
>>> index 3e1587f1f77a..9c23c877fc34 100644
>>> --- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
>>> +++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
>>> @@ -55,6 +55,67 @@
>>>          clock-names = "rtc";
>>>      };
>>>
>>> +    pinctrl: ingenic-pinctrl@10010000 {
>>
>>    The node name should be generic, so please rename it to something
>> like "pin-controller@..."
>
> OK.
>
>>> +        compatible = "ingenic,jz4740-pinctrl";
>>> +        reg = <0x10010000 0x400>;
>>> +
>>> +        gpa: gpio-controller@0 {
>>
>>    The name should be just "gpio@0", according to ePAPR and its
>> successor spec. Although, using the <unit-address> without the "reg"
>> prop isn't allowed either...
>
> ePAPR says: "If the node has no reg property, the unit-address may be

    My copy of ePAPR 1.1 says "must be omitted". :-)

> omitted if the node name alone differentiates the node from other nodes at
> the same level in the tree."

> I could use 'gpio@bank-a', it is allowed by the spec. Or do you prefer 'gpio@0'?

    Hm... maybe you should just use the "reg" prop.

> I'll wait from some feedback on the other patches then send a v5.
>
> Thanks,
> -Paul

MBR, Sergei
