Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jan 2018 15:28:20 +0100 (CET)
Received: from mail-it0-x242.google.com ([IPv6:2607:f8b0:4001:c0b::242]:47086
        "EHLO mail-it0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990419AbeACO2MhEQVb convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Jan 2018 15:28:12 +0100
Received: by mail-it0-x242.google.com with SMTP id c16so1871001itc.5;
        Wed, 03 Jan 2018 06:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Cv9pK0oowxee4CaexEDVvzxuhjfg6pu8JJgdMbaQR/E=;
        b=dLAP1RNXA+Zh1UsgXybq6ZTGQXsTD10KwEvHJlbx6++Zj2LFMhHiihVmBAdbHtZimB
         49aR9Ew7N5rxFVp4ckzcaYQ6uFRYF9v6CbiYDwRtmv81OZrNnWxQwe//8AskPzMZQhsG
         CbsTCVSIL1I9SS9eF5y3E2AhsjYDP4dmcUK4BfUmQyhPXanmQHzFvkvo57OhoMru8Og2
         EV56K0IwqNBfOvTJe66n9LEw+vhi3Hn249Z77Do+xLDUMmQL2kwAJkwCENQ9BPKA1GYG
         VMfGQyqSMfhSIdUZ46e7HRbiGqEcu+uZym/x49Nk+p/FcK9svbVrfUQOZegswy3ZSF0A
         RpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Cv9pK0oowxee4CaexEDVvzxuhjfg6pu8JJgdMbaQR/E=;
        b=o5dQI2dWHqz1CfyLheVNBdQ/6a3vjivjWn/1lIq/YZUXvh3EyGEha75PnO1dqzwf+f
         R4Owd44bD8XXVvUq1Yu4Qs3/hcakwQj994nGTY7n2041oUQgGyK8Uie4XOTVd3XQDvw6
         R2XJCJykc+ByyE9+1EqUEgw0DcHfvROI3tLR59nPPAfKhmUhlcD5PIR7JoXAqCQbVv7g
         b/6AipV++Gb34R5/ArN7WQjX+A6518vJnvXfDzK7ErM9K6KeBCfW1gxHK1i2OVS/g4Kh
         V452GSjgEc5ncaEdUq31Stu5V0eNodM2HIplZTsrZqVF9KNdyUp3Q/cnWQNaHMfu9jgQ
         pc0w==
X-Gm-Message-State: AKGB3mKDvH4Frov/652JzlWvbJWoml7szwciwcIpqJgZMCbg9E4VTVBu
        crAfdb7A6GMNWWm3TjFuCLSY/8Sh+dldcSzlLsM=
X-Google-Smtp-Source: ACJfBosA+hHrEsIRYEXuUJ/rcOankPmvV99UH7CkoqX8lm/GVE4M8Ffofgu4v7AdPT30dNZ+vEGYITL+LOUywFednGU=
X-Received: by 10.36.53.12 with SMTP id k12mr2084920ita.136.1514989685222;
 Wed, 03 Jan 2018 06:28:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.144.208 with HTTP; Wed, 3 Jan 2018 06:28:04 -0800 (PST)
In-Reply-To: <698e7ae5-9f19-1282-7b82-0e2fd2080906@roeck-us.net>
References: <20171228162939.3928-2-paul@crapouillou.net> <20171230135108.6834-1-paul@crapouillou.net>
 <20171230135108.6834-5-paul@crapouillou.net> <CANc+2y5ZUM_ZzXaGgbx9b7O1GF4GrbaYsv97G+akvhP2d2VVUA@mail.gmail.com>
 <1514911698.3623.1@smtp.crapouillou.net> <698e7ae5-9f19-1282-7b82-0e2fd2080906@roeck-us.net>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Wed, 3 Jan 2018 19:58:04 +0530
Message-ID: <CANc+2y4_saELdhX7SFOAOxSqvZUoDO53zOBQasx3_+UDykJHrQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] MIPS: jz4740: dts: Add bindings for the jz4740-wdt driver
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61889
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

On 3 January 2018 at 10:16, Guenter Roeck <linux@roeck-us.net> wrote:
> On 01/02/2018 08:48 AM, Paul Cercueil wrote:
>>
>> Hi PrasannaKumar,
>>
>> Le mar. 2 janv. 2018 à 17:37, PrasannaKumar Muralidharan
>> <prasannatsmkumar@gmail.com> a écrit :
>>>
>>> Hi Paul,
>>>
>>> On 30 December 2017 at 19:21, Paul Cercueil <paul@crapouillou.net> wrote:
>>>>
>>>>  Also remove the watchdog platform_device from platform.c, since it
>>>>  wasn't used anywhere anyway.
>>>>
>>>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>>  ---
>>>>   arch/mips/boot/dts/ingenic/jz4740.dtsi |  8 ++++++++
>>>>   arch/mips/jz4740/platform.c            | 16 ----------------
>>>>   2 files changed, 8 insertions(+), 16 deletions(-)
>>>>
>>>>   v2: No change
>>>>
>>>>  diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi
>>>> b/arch/mips/boot/dts/ingenic/jz4740.dtsi
>>>>  index cd5185bb90ae..26c6b561d6f7 100644
>>>>  --- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
>>>>  +++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
>>>>  @@ -45,6 +45,14 @@
>>>>                  #clock-cells = <1>;
>>>>          };
>>>>
>>>>  +       watchdog: watchdog@10002000 {
>>>>  +               compatible = "ingenic,jz4740-watchdog";
>>>>  +               reg = <0x10002000 0x10>;
>>>>  +
>>>>  +               clocks = <&cgu JZ4740_CLK_RTC>;
>>>>  +               clock-names = "rtc";
>>>>  +       };
>>>>  +
>>>
>>>
>>> The watchdog driver calls jz4740_timer_enable_watchdog and
>>> jz4740_timer_disable_watchdog which defined in
>>> arch/mips/jz4740/timer.c. It accesses registers iomapped by timer
>>> code. Declaring register size as 0x10 does not show the real picture.
>>> Better use register size as 0x100 and let timer, wdt, pwm drivers to
>>> share them.
>>
>>
>> As you said, it accesses registers iomapped by timer code. So the watchdog
>> driver doesn't need to iomap them.
>>
>>> Code from one of your branches
>>>
>>> (https://github.com/OpenDingux/linux/blob/for-upstream-clocksource/arch/mips/boot/dts/ingenic/jz4740.dtsi)
>>> does it. Can you prepare a patch series and send it?
>>> I have a patch set that moves timer code out of arch/mips/jz4740/ and
>>> does a similar thing for watchdog and pwm. As your new timer driver is
>>> better than the existing one I have not sent my patches yet. I would
>>> like to see it getting mainlined as it paves way for removing most of
>>> code in arch/mips/jz4740.
>>
>>
>> The whole 'for-upstream-clocksource' branch is supposed to go upstream,
>> but I can't do it in one big patchset without having lots of breakages
>> with
>> my other patchsets (jz4770 SoC support, and jz4740 watchdog updates)
>> currently under review. That also makes it simpler to upstream than having
>> one single patchset that touches 6 different frameworks (MIPS, irq,
>> clocks,
>> clocksource, watchdog, PWM).
>>
>> So I will submit it in two steps, first the irq/clocks/clocksource drivers
>> (this patchset) hopefully for 4.16, and then the platform/watchdog/PWM
>> fixes
>> for 4.17.
>>
>
> I kind of lost it in this exchange, sorry. At this point I don't know if
> something
> is wrong with the watchdog patches, and I have no clue what the upstream
> path

There is nothing wrong in this watchdog patches.

> is supposed to be. My working assumption is that 1) something may be wrong
> with
> the current version of the patches, and, 2), even if not, none of the
> patches
> is expected to find its way upstream through the watchdog subsystem. Plus,
> 3),
> even if some of the patches are supposed to go upstream through the watchdog
> subsystem, that won't happen in 4.16, and the patches will be resubmitted
> later
> when they are ready [and will hopefully marked clearly for submission
> through
> the watchdog subsystem].
>
> With that in mind, I'll mark the series for my reference as "not
> applicable".
> If this is wrong please let me know.

Paul has patches related to timer code. While sending that he would
send changes to watchdog dts entry also. I was suggesting him to send
timer patches together with watchdog patches as a single patch series
but he prefers to send them as separate patch series.

I would like to reiterate that there is nothing wrong with this
watchdog patches. I should have set the correct context in my previous
email itself. I sincerely apologize for creating this confusion.

Regards,
PrasannaKumar
