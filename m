Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Jan 2018 16:59:59 +0100 (CET)
Received: from mail-io0-x242.google.com ([IPv6:2607:f8b0:4001:c06::242]:33812
        "EHLO mail-io0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990397AbeATP7vNyUb0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Jan 2018 16:59:51 +0100
Received: by mail-io0-x242.google.com with SMTP id c17so5231665iod.1;
        Sat, 20 Jan 2018 07:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yhAGoMNTJ78K6NWBaeMCqRMDXJ5FhzjeGArJqWSv4sQ=;
        b=VxlgJLR7SuZboxCBVMNAv8rC3FkqknfqO+G7+6oAsDsuJsuBwxTmqUY8e8LfTgfCIr
         ixsE/n70iZ/cAdRAQtQ1nmxluQPqZphn7n/LdrlQbLC2RBT1N7gPxvdY4xak6n4UVzNb
         FIbbLGQq7zSMn7Xiyia+XH0M907H1+P/O5A+6pofZdEFMZ4SYhK+Qo6AfyLBBfTBOtCj
         YGIbNRmRpUnCdYfgjyz4LVQuMPOqa/jhBeS7cZfxdmNLEibxBzRTtUQ+D5ZlxtL42OIA
         9+9AIWnmFC+xD77mlgHwayk35gMXZ930JMlOJW4sFxweN/IL8/72g92tI9UQcAx7SRm1
         caUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yhAGoMNTJ78K6NWBaeMCqRMDXJ5FhzjeGArJqWSv4sQ=;
        b=BvkCqiviZNDC+DSxEIvirIx4myjQhOXr4j9MohQF9R+4bktiQoT8g1nJ/IaCAeeJQI
         wpL9mDYoHU9GN2l7mz8X81ovLGPRJ6mliia4pRZqwX93HDiJoHoboBGisbYWS9QZjcoh
         4Fw7knRo94TMEUW/i3NQBSwcZp7G2K8PvDg71IbqtWDkS8b5MyiEGxlF7n0U9q95Esa0
         ECjnNFcs+EiHrY7p5y5xYI+sZMG3TJVGAxHeLqe/j4dRwB5sBgaIyw18s4CEXLkuwHR4
         swXNvs87ZC5wPmK+gwjFwIAMs6gEFyR0bmCTFw9oPtGYOK7AHUZuVUQGEa5clAUedylA
         4mVw==
X-Gm-Message-State: AKwxyte4LG8vHPYixuVubIsSR8JaejvVRbBt5QClLoqLeXPIQksZDNEB
        qAKvcKNlOnnKwyNm25BylzLrgPmfbk0X1NOOiUYflo/I
X-Google-Smtp-Source: AH8x227eweEbRYJwE6LxlvH5oAervbfhKQ0S+CU/F3Q+eBUPFA/+V+wRoplhPD3FSG075vjn/4Y0fOGPePXMIfURAsk=
X-Received: by 10.107.79.19 with SMTP id d19mr2061064iob.263.1516463984590;
 Sat, 20 Jan 2018 07:59:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.165.9 with HTTP; Sat, 20 Jan 2018 07:59:43 -0800 (PST)
In-Reply-To: <71845801-7edf-9e49-8591-2a4caf11c45b@roeck-us.net>
References: <20171228162939.3928-2-paul@crapouillou.net> <20171230135108.6834-1-paul@crapouillou.net>
 <20171230135108.6834-4-paul@crapouillou.net> <CANc+2y4z-_++zUG8DUR6+zZYjc26AyJjU-yX+Lx37TSRXb4u0g@mail.gmail.com>
 <71845801-7edf-9e49-8591-2a4caf11c45b@roeck-us.net>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Sat, 20 Jan 2018 21:29:43 +0530
Message-ID: <CANc+2y6OhA8tFZq-toek5ed1Kt-Dv8Jy0+E4HFqQGg8WYGygSg@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] watchdog: JZ4740: Drop module remove function
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
X-archive-position: 62262
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

On 20 January 2018 at 21:20, Guenter Roeck <linux@roeck-us.net> wrote:
> On 01/19/2018 11:41 PM, PrasannaKumar Muralidharan wrote:
>>
>> Hi Paul,
>>
>> On 30 December 2017 at 19:21, Paul Cercueil <paul@crapouillou.net> wrote:
>>>
>>> When the watchdog was configured for nowayout, and after the
>>> userspace watchdog daemon closed the dev node without sending the
>>> magic character, unloading this module stopped the watchdog
>>> hardware, which was clearly a problem.
>>>
>>> Besides, unloading the module is not possible when the userspace
>>> watchdog daemon is running, so it's safe to assume that we don't
>>> need to stop the watchdog hardware in the jz4740_wdt_remove()
>>> function.
>>>
>>> For this reason, the jz4740_wdt_remove() function can then be
>>> dropped alltogether.
>>>
>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>> ---
>>>   drivers/watchdog/jz4740_wdt.c | 8 --------
>>>   1 file changed, 8 deletions(-)
>>>
>>>   v2: New patch in this series
>>>
>>> diff --git a/drivers/watchdog/jz4740_wdt.c
>>> b/drivers/watchdog/jz4740_wdt.c
>>> index fa7f49a3212c..02b9b8e946a2 100644
>>> --- a/drivers/watchdog/jz4740_wdt.c
>>> +++ b/drivers/watchdog/jz4740_wdt.c
>>> @@ -205,16 +205,8 @@ static int jz4740_wdt_probe(struct platform_device
>>> *pdev)
>>>          return 0;
>>>   }
>>>
>>> -static int jz4740_wdt_remove(struct platform_device *pdev)
>>> -{
>>> -       struct jz4740_wdt_drvdata *drvdata = platform_get_drvdata(pdev);
>>> -
>>> -       return jz4740_wdt_stop(&drvdata->wdt);
>>> -}
>>> -
>>>   static struct platform_driver jz4740_wdt_driver = {
>>>          .probe = jz4740_wdt_probe,
>>> -       .remove = jz4740_wdt_remove,
>>>          .driver = {
>>>                  .name = "jz4740-wdt",
>>>                  .of_match_table = of_match_ptr(jz4740_wdt_of_matches),
>>> --
>>> 2.11.0
>>>
>>>
>>
>> As ".remove" is removed and wdt is required for restarting the system
>> I am thinking that stop callback is also not required. If so does it
>> makes sense to remove the stop callback? I can submit a patch for the
>> same once this patch series goes in.
>>
> The remove function was removed because it would otherwise be an empty
> function. Since it is optional, it can and should be removed if it does not
> do anything. If the stop function is removed, it is no longer possible
> to stop the watchdog. Why would this make sense, and why would it make sense
> to drop the stop function if there is no remove function ?
>
> Guenter
>

I missed the fact that stopping is watchdog is possible. Sorry for the noise.

Thanks,
PrasannaKumar
