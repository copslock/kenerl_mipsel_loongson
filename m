Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Jan 2018 16:46:04 +0100 (CET)
Received: from mail-pf0-x244.google.com ([IPv6:2607:f8b0:400e:c00::244]:38193
        "EHLO mail-pf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990397AbeATPp43lNs0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Jan 2018 16:45:56 +0100
Received: by mail-pf0-x244.google.com with SMTP id k19so3690075pfj.5;
        Sat, 20 Jan 2018 07:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YC+uA4ZvdZbYDESjHE9cjPDvWzqU72tKrLK+BYrQ9es=;
        b=LWezTObnCPNvh6B0KTBsPazicrBiHNAsDU3lBcqwzjp/LQ+JkhvT2W61rFcOMiKPe3
         lWv8o2I9MkVxppOhWaYh/jQWp6LR0TxR5IIfOIkjBmLyL/ScAojzIFBWreK1ogMgevTY
         Ajqe6MLnYT9arBrEsvMe6Wrh1GrPytA21Ncczw8tNJrsZ7puHfSzp53f8Ws46+05ZlJq
         S5wVRjDL1GrzDGPh9RxxULdPo6aa40woAcvfPW/m2KbVYS9bSS4mmOq0O0JIsBtkwnYK
         +inVdpwsbYgzn43mEWUpAWDG2r7r56bzT9HEMLM/ScbeRuC9vDSTB2tg0bCwlJNH1g4j
         f6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YC+uA4ZvdZbYDESjHE9cjPDvWzqU72tKrLK+BYrQ9es=;
        b=qJL7OWmaVlRXgnEnEDfmuPyOebsX7tvwn9L69XEJUlYqWwZ9Hs3PU9+IJRUhMz7VSV
         qyG2bpb/CyeK1L6UcuIkU3N8mrDVj8noTcB93cZuYF559gnBNr3MGJWIZzS+gQVs6kFe
         D+eTasqJheY7TQbC9ZvzhoXtCZeC9Ok2R7ZHHa38prrwKhhuX2JkIBSjbKniAG7R+ltI
         yNmYzbDHN9OvSjRnAIs23z9fAE+gdL8KfLxebn7612Oz50+RbJdBjilhg6zHQ/kw+VzT
         bvqltgBrUEtNylp6MxjxHT5Q7YiuDAeRK4llV3a7XDu71oFH8tVOwSgMowPoA258GpNX
         ZKrQ==
X-Gm-Message-State: AKwxyteBgrznjd8ifrC++iIDbWUeqLWIIA2HBhltY11FO7zujBVPdWVK
        1oyH0oFP2vrcQ/kGeN7nFp4=
X-Google-Smtp-Source: AH8x2255K+9bCpPYIHQ/rMYcVtW1WjqPQ3kW4mlxf6PmGiVs1bIfUrqUmtQYL3BSd1u/mzfenF6tdQ==
X-Received: by 10.99.116.82 with SMTP id e18mr2344872pgn.3.1516463149797;
        Sat, 20 Jan 2018 07:45:49 -0800 (PST)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id b6sm18417544pgc.2.2018.01.20.07.45.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jan 2018 07:45:48 -0800 (PST)
Subject: Re: [PATCH v2 3/8] watchdog: JZ4740: Register a restart handler
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org
References: <20171228162939.3928-2-paul@crapouillou.net>
 <20171230135108.6834-1-paul@crapouillou.net>
 <20171230135108.6834-3-paul@crapouillou.net>
 <CANc+2y7CT150cO61RfRgc6hCLEasx+NmqCacZtaFPKLgTPyt4w@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <20061de8-fa1f-93eb-eb9b-089c699018aa@roeck-us.net>
Date:   Sat, 20 Jan 2018 07:45:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CANc+2y7CT150cO61RfRgc6hCLEasx+NmqCacZtaFPKLgTPyt4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62260
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

On 01/19/2018 11:31 PM, PrasannaKumar Muralidharan wrote:
> Hi Paul,
> 
> On 30 December 2017 at 19:21, Paul Cercueil <paul@crapouillou.net> wrote:
>> The watchdog driver can restart the system by simply configuring the
>> hardware for a timeout of 0 seconds.
>>
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/watchdog/jz4740_wdt.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>>   v2: No change
>>
>> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
>> index 92d6ca8ceb49..fa7f49a3212c 100644
>> --- a/drivers/watchdog/jz4740_wdt.c
>> +++ b/drivers/watchdog/jz4740_wdt.c
>> @@ -130,6 +130,14 @@ static int jz4740_wdt_stop(struct watchdog_device *wdt_dev)
>>          return 0;
>>   }
>>
>> +static int jz4740_wdt_restart(struct watchdog_device *wdt_dev,
>> +                             unsigned long action, void *data)
>> +{
>> +       wdt_dev->timeout = 0;
>> +       jz4740_wdt_start(wdt_dev);
>> +       return 0;
>> +}
>> +
>>   static const struct watchdog_info jz4740_wdt_info = {
>>          .options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
>>          .identity = "jz4740 Watchdog",
>> @@ -141,6 +149,7 @@ static const struct watchdog_ops jz4740_wdt_ops = {
>>          .stop = jz4740_wdt_stop,
>>          .ping = jz4740_wdt_ping,
>>          .set_timeout = jz4740_wdt_set_timeout,
>> +       .restart = jz4740_wdt_restart,
>>   };
>>
>>   #ifdef CONFIG_OF
>> --
>> 2.11.0
>>
>>
> 
> Noticed that min_timeout of the watchdog device is set to 1 but this
> function calls start with timeout set to 0. Even though this works I
> feel it is better to set min_timeout to 0.
> 

No. That would be wrong. If you want to be pedantic, write a new function
__jz4740_wdt_set_timeout(u16 clock_div, u16 timeout_value) and call it
instead, but don't mess with min_timeout.

Guenter
