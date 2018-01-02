Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 18:58:14 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:32800
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990754AbeABR6HnrQa9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 18:58:07 +0100
Received: by mail-wm0-x241.google.com with SMTP id g130so17221944wme.0
        for <linux-mips@linux-mips.org>; Tue, 02 Jan 2018 09:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+gggkiyiFTBKYrF+5GBqbrt3XdecogKXK4dg5Xs9UrE=;
        b=C82VI3ds81cHlVlaOwEX9zNpgGwMyhUNcjGiJ9Z+Q55vwYwnI+4J2gsMkVhi3CQBDb
         E4grIEsHvb3aDDtOIfRpJw+9qKxDItwFo3JLpRr7QIMcCgrlNf/jRCTjP14LAfxterj0
         z1hqMhCFKpfOsGnxKAAyubJyjdlB1AZ46K6XU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+gggkiyiFTBKYrF+5GBqbrt3XdecogKXK4dg5Xs9UrE=;
        b=gM3BRsyGYMOYpFzm9X+iAJAISszPI/J6Ol36j+d8aicKVwHqVFAdBBs8yVhPLKtM6o
         qpBfDQeHNb9cBksAJ05T4OOh18Yl9Qw8qXBavkw1mVWLz98qBfWNuIumq+c9tq+KH++Q
         NIikpTqgNDrpFrk2khs32PgkakD5vkIF2t/lN6ZFRImlW6h/YJxiNSmHLaBuMx67euxd
         7mVX8Prq4YyOeu7pLUwu2rO9WNlidhv/xwPHGfNzUVf8EUIWaS0V6nH+gECyNPF7fcp3
         0t+UANyMAYiM/YA+YM9TKEHyEc6SYWJUy8cpCZsHOr9AA8Yhltot+CSk4kvCDJxv1Smc
         J7sQ==
X-Gm-Message-State: AKGB3mL+iZR/KTD9JIoPV2Zs9qvaSe2qLPnDVPH9OPPc4f7Tjp33HlZY
        HwQtvcrlbUyCc6BpGSANlxkeCa8BTO8=
X-Google-Smtp-Source: ACJfBos0mBZWRoi7UaSF0sECTa1dYYi8TVU3w3pT8xEgWZXJSB0EKD2UvBx4RZU+jv+F5z2UYVt/Ew==
X-Received: by 10.28.61.87 with SMTP id k84mr35342176wma.48.1514915882177;
        Tue, 02 Jan 2018 09:58:02 -0800 (PST)
Received: from [192.168.0.20] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id 139sm22537120wmp.7.2018.01.02.09.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jan 2018 09:58:01 -0800 (PST)
Subject: Re: [PATCH v2 0/2] Add efuse driver for Ingenic JZ4780 SoC
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zubair.Kakakhel@mips.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        open list <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
References: <20171228212954.2922-1-malat@debian.org>
 <828981e5-c23c-8dc4-55e4-23b65b33908b@linaro.org>
 <CANc+2y5cEoqEkqEr9b-APApd42HXQczFWJfGv+MWPNRdWpQr7Q@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <11f64a94-2500-6c5f-d6f9-2db68fcf9c58@linaro.org>
Date:   Tue, 2 Jan 2018 17:58:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CANc+2y5cEoqEkqEr9b-APApd42HXQczFWJfGv+MWPNRdWpQr7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <srinivas.kandagatla@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61861
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



On 02/01/18 16:17, PrasannaKumar Muralidharan wrote:
> Hi Srinivas,
> 
> On 2 January 2018 at 17:31, Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>>
>> On 28/12/17 21:29, Mathieu Malaterre wrote:
>>>
>>> This patchset bring support for read-only access to the JZ4780 efuse as
>>> found
>>> on MIPS Creator CI20.
>>>
>>> To keep the driver as simple as possible, it was not possible to re-use
>>> most of
>>> the nvmem core functionalities. This driver is not compatible with the
>>> original
>>
>> Can you explain a bit more on not able to re-use nvmem core?
>>
>> If you are referring to adding nvmem cell entires in sysfs, This should
>> probably go in to nvmem core, rather that in individual providers.
>> This is one of the feature my todo list, will try to come up with some thing
>> soon.
> 
> We could not find a way to expose different sized segments using nvmem
> framework. Do you have any pointers for this?

This does not exist at the moment, but it should be very much doable to 
add this functionality to nvmem core.

I will keep you loop if I manage to post this patch soon.

--srini
> We were not aware of the fact that nvmem does not expose individual
> cell entries in sysfs.
> 
> Regards,
> PrasannaKumar
> 
