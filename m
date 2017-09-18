Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Sep 2017 15:21:39 +0200 (CEST)
Received: from mail-pg0-x242.google.com ([IPv6:2607:f8b0:400e:c05::242]:36921
        "EHLO mail-pg0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992517AbdIRNVcJDC7V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Sep 2017 15:21:32 +0200
Received: by mail-pg0-x242.google.com with SMTP id v5so229216pgn.4;
        Mon, 18 Sep 2017 06:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=miyEGFQ0QUFeAy2Mx5dXOagfTjMEFHdUTVXda1gsWbw=;
        b=AHEIl9yHnhTFZtu7luulTHPh4wKB62WmcmF+T7qVLMzJ395v+1GwzuqRnISkuniSQi
         SlVYEdQbhwwJN0DNaPonZi0WAcU4ujtIuSoeg1BqM5MzybqhtekR4srRQ+3Gl7Pezh/T
         0V/QQT6nAab4t4ofzQeJu9ABEBe4YrUpggEGU/AtKCS9mhdJpVokSJGCd0HS5LQDgjSf
         3sIyNrGFs1yI84PrxwkUVK0o87NOe+264ttkIMoktQYbIMiKgza7QsWcBrdaB0Ewjnng
         wMWMtsZO93wK8GXYatoe3P9hGy//nVELZIEWuRrXNsgCCZIlgGMfTSKZp0UwQvKTqPWa
         VMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=miyEGFQ0QUFeAy2Mx5dXOagfTjMEFHdUTVXda1gsWbw=;
        b=CZix2qkGYTvhKfKAtW+RvtKHYYNXA6JBLJ2iV9xCcbwtulYq3wvUxXHb1VKl1o91Be
         mdRCUAwp6W1JQ0j9fgWkNmdrikQlhZEnWLkc20uBtdJlHDLbx8I58EMl1QhAIrOOuNA7
         86XvO3WQyvDTOFodHAv1cM0nC3l/0uyuPWOlwtsJLzchWwuFIzhMvrIYSkfr3KpDsgRg
         /7Iv3g5oZZyZnpc5kx15Ei+JXo3VoDibmGxpaFcCTGKgufsQtzv9KwP9drEgeq1+rh8H
         z98pm4wsxHuUMw6j0xCeH/NiHGXtJIIA9dNxtE8yznhv/Z6Y1vuSMx+fnCMJscRuhnDY
         eZwQ==
X-Gm-Message-State: AHPjjUiAyTrmV49HleejAEaNDQoTJ9jTVTNoUwNDj+AO6a5a50HBesbr
        js6wMDwK580HZ3JQ
X-Google-Smtp-Source: ADKCNb7yg941BzsPojh6JN3DOrSk7Wp1aPeoZH/rfHsT0PMkdhyhAHDZmR13Fmt2cQCcUvLlxzCyRA==
X-Received: by 10.98.211.193 with SMTP id z62mr32566945pfk.118.1505740885079;
        Mon, 18 Sep 2017 06:21:25 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id o128sm5817082pga.5.2017.09.18.06.21.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2017 06:21:22 -0700 (PDT)
Subject: Re: [PATCH 1/5] i2c: gpio: Convert to use descriptors
To:     hs@denx.de, Linus Walleij <linus.walleij@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Ben Dooks <ben@fluff.org.uk>,
        Ville Syrjala <syrjala@sci.fi>,
        Magnus Damm <magnus.damm@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        "arm@kernel.org" <arm@kernel.org>, Steven Miao <realmz6@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
 <20170910214424.14945-2-linus.walleij@linaro.org>
 <20170914093509.uwk47vt3wnm3rtqb@dell>
 <CACRpkdZYDALXSoEE9jdo7A5P4XZczVbh_uiLkE54=sRtA3rNDQ@mail.gmail.com>
 <59BF5483.9020403@denx.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <0c3eaa74-6e94-825c-5830-2cfc71efaf4f@roeck-us.net>
Date:   Mon, 18 Sep 2017 06:21:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <59BF5483.9020403@denx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 09/17/2017 10:07 PM, Heiko Schocher wrote:
> Hello Linux,
> 
> Am 17.09.2017 um 00:25 schrieb Linus Walleij:
>> On Thu, Sep 14, 2017 at 11:35 AM, Lee Jones <lee.jones@linaro.org> wrote:
>>
>>>>   drivers/mfd/sm501.c                          |  49 +++++-----
>>>
>>> I'd prefer for this to be applied with a Tested-by.  I appreciate that
>>> this is an old driver, but can you attempt to contact one of the
>>> authors or someone else who might have hardware please?
>>
>> For SM501 specifically I guess.
>>
>> OK makes sense as it is the most invasive one, paging around...
>>
>> Ben, Ville, Magnus, Heiko, Guenther: is one of you still using this
>> hardware so you can test the patch set?
> 
> I am Sorry, I do not have the hardware anymore so no chance to test
> it :-(
> 

I had a look into the kernel and qemu code. The only machine actually using
it is an arm system names Anubis, which qemu does not support. No help here
either, sorry.

Guenter
