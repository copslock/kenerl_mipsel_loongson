Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Jan 2018 17:04:49 +0100 (CET)
Received: from mail-it0-x241.google.com ([IPv6:2607:f8b0:4001:c0b::241]:36663
        "EHLO mail-it0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990397AbeATQEmSQi50 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Jan 2018 17:04:42 +0100
Received: by mail-it0-x241.google.com with SMTP id p124so5377348ite.1;
        Sat, 20 Jan 2018 08:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zJomkRSHQ/MoTEtJIp4qzYBQvn8e9JSDKqzCp+EdC3k=;
        b=CDPjCU2IGu2vfjYVH75V0mFWgIlKaoQBhaNEJp3gzqcsigaMr53/PY4Eiq/De49WHv
         gM2EADJM3+WTdfXr8qzMHPGSZ+h13m7TV2rdwHNGmpN6Y82D+RWri1ZcKs/D2ovRyudm
         zoT6SFJT8bbxELb/Q6yRfsnonHsZJ0M5ym3pgjVWOmZD62asSMpWghYnh5cN3l1qbLVu
         Tks3kWtT1GilQt4pr8p6GQzGDinOjNk7tXWVAg/Bw8MIsmpKQkr/ZbRc4tXFNpDgJJkS
         lit3MZWS1e+wMM4vzQzZFQo9y5KMdpPShUw2JgZ//IeYVcSbXdjs5b0RpOpNRasRaf5M
         75DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zJomkRSHQ/MoTEtJIp4qzYBQvn8e9JSDKqzCp+EdC3k=;
        b=bqXDt3TpZZ6Svyok+7H5r2761tawzDxiitz+00T0P8fSVE+KlnccA3tWst8BcbsoR7
         eYAc1G2EEiXUf/EfrdiC9Jgy7PMdyJ6Vsxb00oGA+ErIzcANanJwuZo7HQ/k4erJJk2r
         zSpFTQVJGyRfWCc1RVCzJw6LE4vySNMXMowEf10iuLoj5kV2zNuUlN1JBDacYCzq69dv
         GW7OnmFhHXuIf2kCmyD2zl3KL1HRCdKSjo6C4iPuMXilT5rf9Evck5uV9piyW0nWrYno
         htVnUEuwAXM/bnlnMBSRyvbN/KJfF2Kuz806fsOYoyJ/95LT/zAAJ3d7NeSNx+PdltZh
         +LQg==
X-Gm-Message-State: AKwxytduRXgVUImz0gfmWGRtrTF7wj4bZWOGaoj4s38Jjas8+x3FpWtA
        c8p+BJiL2IO9zMemNVVAni9xrguxPndTbt69SZ01m8EiWgY=
X-Google-Smtp-Source: AH8x227M0OQ4HEp5UrJ6R87x+PRMkzenYHa5GbFO7+7Go5r74stzpENYD6XeTBOBNJYXQF3mVi2Vn2rBMQrRZzWD1tQ=
X-Received: by 10.36.31.5 with SMTP id d5mr2152081itd.136.1516464275650; Sat,
 20 Jan 2018 08:04:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.165.9 with HTTP; Sat, 20 Jan 2018 08:04:35 -0800 (PST)
In-Reply-To: <20061de8-fa1f-93eb-eb9b-089c699018aa@roeck-us.net>
References: <20171228162939.3928-2-paul@crapouillou.net> <20171230135108.6834-1-paul@crapouillou.net>
 <20171230135108.6834-3-paul@crapouillou.net> <CANc+2y7CT150cO61RfRgc6hCLEasx+NmqCacZtaFPKLgTPyt4w@mail.gmail.com>
 <20061de8-fa1f-93eb-eb9b-089c699018aa@roeck-us.net>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Sat, 20 Jan 2018 21:34:35 +0530
Message-ID: <CANc+2y52ObW773=20=-gbztvoH0DSRSO1N5Srf3WYcKLZbPNBg@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] watchdog: JZ4740: Register a restart handler
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

Hi Guenter,

On 20 January 2018 at 21:15, Guenter Roeck <linux@roeck-us.net> wrote:
> On 01/19/2018 11:31 PM, PrasannaKumar Muralidharan wrote:
>>
>> Hi Paul,
>>
>> On 30 December 2017 at 19:21, Paul Cercueil <paul@crapouillou.net> wrote:
>>>
>>> The watchdog driver can restart the system by simply configuring the
>>> hardware for a timeout of 0 seconds.
>>>
>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>>   drivers/watchdog/jz4740_wdt.c | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>>   v2: No change
>>>
>>> diff --git a/drivers/watchdog/jz4740_wdt.c
>>> b/drivers/watchdog/jz4740_wdt.c
>>> index 92d6ca8ceb49..fa7f49a3212c 100644
>>> --- a/drivers/watchdog/jz4740_wdt.c
>>> +++ b/drivers/watchdog/jz4740_wdt.c
>>> @@ -130,6 +130,14 @@ static int jz4740_wdt_stop(struct watchdog_device
>>> *wdt_dev)
>>>          return 0;
>>>   }
>>>
>>> +static int jz4740_wdt_restart(struct watchdog_device *wdt_dev,
>>> +                             unsigned long action, void *data)
>>> +{
>>> +       wdt_dev->timeout = 0;
>>> +       jz4740_wdt_start(wdt_dev);
>>> +       return 0;
>>> +}
>>> +
>>>   static const struct watchdog_info jz4740_wdt_info = {
>>>          .options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
>>> WDIOF_MAGICCLOSE,
>>>          .identity = "jz4740 Watchdog",
>>> @@ -141,6 +149,7 @@ static const struct watchdog_ops jz4740_wdt_ops = {
>>>          .stop = jz4740_wdt_stop,
>>>          .ping = jz4740_wdt_ping,
>>>          .set_timeout = jz4740_wdt_set_timeout,
>>> +       .restart = jz4740_wdt_restart,
>>>   };
>>>
>>>   #ifdef CONFIG_OF
>>> --
>>> 2.11.0
>>>
>>>
>>
>> Noticed that min_timeout of the watchdog device is set to 1 but this
>> function calls start with timeout set to 0. Even though this works I
>> feel it is better to set min_timeout to 0.
>>
>
> No. That would be wrong. If you want to be pedantic, write a new function
> __jz4740_wdt_set_timeout(u16 clock_div, u16 timeout_value) and call it
> instead, but don't mess with min_timeout.
>
> Guenter

What is the effect of changing min_timeout? I could see only
validation checks with it.

Thanks,
PrasannaKumar
