Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jan 2018 05:46:40 +0100 (CET)
Received: from mail-pf0-x244.google.com ([IPv6:2607:f8b0:400e:c00::244]:32784
        "EHLO mail-pf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990410AbeACEqbyUK8R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Jan 2018 05:46:31 +0100
Received: by mail-pf0-x244.google.com with SMTP id y89so328501pfk.0;
        Tue, 02 Jan 2018 20:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fjrAfLEgMsfo5tOvcwxpKA4fR7REJqft5qgci0kzp/Q=;
        b=Ki1eU+mdnaXXroelNVFVBnTAPQ2JIaMVp5ewbG48uRi56Kz6MJ0yMLXLwzWqS6kh5m
         fFz25lCAcQsNQeO2IdaYx7yYY7OUKChCQJW0juScRIam9Fd6LTnnANWbf6knJUuby4JA
         SDVx2lW9Wx87mf65BcDxTZ7VBtI/tZkfTktHGt4yZDKeyq5Pmby5hCJZM6SdE+cOHxLW
         AaqtjH43PvhuWNU7zjFTowdRpsz507KrctPygP94nKAoElurZTn3M0G9sXxnleoyMaJP
         +jiMi09VIqNriZQHPEKs5dLmfiWVwF0mdpEHk9cfI7kDH4e5/uBh4WgjWqRGRy0WJzzc
         3MaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fjrAfLEgMsfo5tOvcwxpKA4fR7REJqft5qgci0kzp/Q=;
        b=rqZ+xILAe/25b6aDzkKEs1RuHVQMaiLR+fzR6TO+iYwcq6ftkmvM6kEDs4K4xfcpz8
         xR5CPt2AS+4QupAd9sM+mdXOYl/oDtbDIe4Og3HKVBe0+8ktsRp2AtwHcL/J2sfuMRTg
         5pZGeA1KEfoE83pa7a9yy+yxmFwkxhWlTsKYfljzhtwJZMJyuCsqp0O+hEx3fV7BUZM0
         +BKetZzWlLBkAwTE5Qm12ri5P6hmKbP9g2SVN5hfEWp8IAihvAcnUnDVMJANtSKlQ6+i
         NzYMLYQkrXcXDepxmRHAA/j9B8aOTotMkWrOfKZNdV5OmyEYPp+Qb8O8pizqXlI8411B
         6Lsg==
X-Gm-Message-State: AKGB3mKHUH0TIDoryLCkzEuC3LDStY4PKC505ggWj8h8LMewWR4kaRbQ
        w0rfBL4Sk+1fTzAh7veF2iU=
X-Google-Smtp-Source: ACJfBouR6pr3LLG6nEqaGfFvIsuDZjp8jv6uFFXoHw/zL0QHUK24BniCGTiSOJ/7KbOz/ZTSynfceg==
X-Received: by 10.99.146.83 with SMTP id s19mr241745pgn.217.1514954784945;
        Tue, 02 Jan 2018 20:46:24 -0800 (PST)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id s81sm492561pfg.60.2018.01.02.20.46.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jan 2018 20:46:23 -0800 (PST)
Subject: Re: [PATCH v2 5/8] MIPS: jz4740: dts: Add bindings for the jz4740-wdt
 driver
To:     Paul Cercueil <paul@crapouillou.net>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org
References: <20171228162939.3928-2-paul@crapouillou.net>
 <20171230135108.6834-1-paul@crapouillou.net>
 <20171230135108.6834-5-paul@crapouillou.net>
 <CANc+2y5ZUM_ZzXaGgbx9b7O1GF4GrbaYsv97G+akvhP2d2VVUA@mail.gmail.com>
 <1514911698.3623.1@smtp.crapouillou.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <698e7ae5-9f19-1282-7b82-0e2fd2080906@roeck-us.net>
Date:   Tue, 2 Jan 2018 20:46:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1514911698.3623.1@smtp.crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61882
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

On 01/02/2018 08:48 AM, Paul Cercueil wrote:
> Hi PrasannaKumar,
> 
> Le mar. 2 janv. 2018 à 17:37, PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com> a écrit :
>> Hi Paul,
>>
>> On 30 December 2017 at 19:21, Paul Cercueil <paul@crapouillou.net> wrote:
>>>  Also remove the watchdog platform_device from platform.c, since it
>>>  wasn't used anywhere anyway.
>>>
>>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>  ---
>>>   arch/mips/boot/dts/ingenic/jz4740.dtsi |  8 ++++++++
>>>   arch/mips/jz4740/platform.c            | 16 ----------------
>>>   2 files changed, 8 insertions(+), 16 deletions(-)
>>>
>>>   v2: No change
>>>
>>>  diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
>>>  index cd5185bb90ae..26c6b561d6f7 100644
>>>  --- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
>>>  +++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
>>>  @@ -45,6 +45,14 @@
>>>                  #clock-cells = <1>;
>>>          };
>>>
>>>  +       watchdog: watchdog@10002000 {
>>>  +               compatible = "ingenic,jz4740-watchdog";
>>>  +               reg = <0x10002000 0x10>;
>>>  +
>>>  +               clocks = <&cgu JZ4740_CLK_RTC>;
>>>  +               clock-names = "rtc";
>>>  +       };
>>>  +
>>
>> The watchdog driver calls jz4740_timer_enable_watchdog and
>> jz4740_timer_disable_watchdog which defined in
>> arch/mips/jz4740/timer.c. It accesses registers iomapped by timer
>> code. Declaring register size as 0x10 does not show the real picture.
>> Better use register size as 0x100 and let timer, wdt, pwm drivers to
>> share them.
> 
> As you said, it accesses registers iomapped by timer code. So the watchdog
> driver doesn't need to iomap them.
> 
>> Code from one of your branches
>> (https://github.com/OpenDingux/linux/blob/for-upstream-clocksource/arch/mips/boot/dts/ingenic/jz4740.dtsi)
>> does it. Can you prepare a patch series and send it?
>> I have a patch set that moves timer code out of arch/mips/jz4740/ and
>> does a similar thing for watchdog and pwm. As your new timer driver is
>> better than the existing one I have not sent my patches yet. I would
>> like to see it getting mainlined as it paves way for removing most of
>> code in arch/mips/jz4740.
> 
> The whole 'for-upstream-clocksource' branch is supposed to go upstream,
> but I can't do it in one big patchset without having lots of breakages with
> my other patchsets (jz4770 SoC support, and jz4740 watchdog updates)
> currently under review. That also makes it simpler to upstream than having
> one single patchset that touches 6 different frameworks (MIPS, irq, clocks,
> clocksource, watchdog, PWM).
> 
> So I will submit it in two steps, first the irq/clocks/clocksource drivers
> (this patchset) hopefully for 4.16, and then the platform/watchdog/PWM fixes
> for 4.17.
> 

I kind of lost it in this exchange, sorry. At this point I don't know if something
is wrong with the watchdog patches, and I have no clue what the upstream path
is supposed to be. My working assumption is that 1) something may be wrong with
the current version of the patches, and, 2), even if not, none of the patches
is expected to find its way upstream through the watchdog subsystem. Plus, 3),
even if some of the patches are supposed to go upstream through the watchdog
subsystem, that won't happen in 4.16, and the patches will be resubmitted later
when they are ready [and will hopefully marked clearly for submission through
the watchdog subsystem].

With that in mind, I'll mark the series for my reference as "not applicable".
If this is wrong please let me know.

Guenter
