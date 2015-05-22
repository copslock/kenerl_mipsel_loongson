Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 18:53:54 +0200 (CEST)
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33709 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006627AbbEVQxwimGew (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 18:53:52 +0200
Received: by qkgv12 with SMTP id v12so16168522qkg.0
        for <linux-mips@linux-mips.org>; Fri, 22 May 2015 09:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=xsV151YrB1BYLauOyRbuO2v0PSDbsoWH3csV3G9s2XM=;
        b=bGpDkHwj1/Wzbio1bHIDGQEgfkAsZ/NeC7rQCNxRp7T3bazDis/IU3xJoNDinfTBru
         Ily5fD7XFkKWQpG72bwNeYYetBzC2eu2ONWuwZ6TWZZbaJimTwYDxxF7M8E4aDd2wKpj
         6JKhzhk29jy/t8Qnz/SBP8RDiVJ3Jj6oN0epSgO2Us06y1Nqds4qRc2M8Fm6FFOe7YYz
         z6o/PJgVEmNqT/IsAsSFYqglkY+A/iNKXYYhGNitH/iIzeOGjAnPq6n0HOszqkaPzsnm
         9LZnbC0VR/Fim6GUOQ3sjQ9M9j+kj6Ln+67EeqTYz0DBdYhFdPPscjN7v7DOHL8OO5oL
         oUGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=xsV151YrB1BYLauOyRbuO2v0PSDbsoWH3csV3G9s2XM=;
        b=cAzKXNio5Jp/c9sUUhzWHWdgZNq/jvFp4oAhbwMz8kZxZD6CulblrBR2xUiLbIs6rP
         Hoyp7SB8fVhO3zJEvu5DPl8O0KrQSMBleulNMD632jHee17cHxPjkKY6p9g+2PsRo+sd
         sMEUiUZuKlC3fTlkhmOCzlWgrZeAPKCzlpKQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=xsV151YrB1BYLauOyRbuO2v0PSDbsoWH3csV3G9s2XM=;
        b=M0r5B/M2TXUMfRs0w/gB7QE2lM0lOpUeoDYh2aDO2i5NqTZLks9XKXTxP42AcoWWG7
         qg1j9ehWzJcqqTDtfuErtNQWtA6i8bIrqOt4Ip8Cvfk4MZqKa70lYgBBIgT9NsLg9LjS
         uusfc1q4tvv5qANlfeWtEMS5AG++ON8ZQucLgfZZiVGtmNLMRi/ozzcOF9iBXqn4/jWb
         Ed8NGtBtaZZ8qTqo8+1xqN4qLcjsmzRqXixuC8eDvKILCKSk6w4C5u8tpDeCjK1zMGbE
         3DxvzJHr1VUWKRUu/yxjzcYBUtnEdwrodsay1VUJHcCoRFL24J4D795IrAjOK8PmtCZM
         MVpw==
X-Gm-Message-State: ALoCoQm4wi8v8d74we288x646uELc6TPXFYDRCS77tlA8ajgZelcwKEkSUWNCxFKR2RS45e1/vF5
MIME-Version: 1.0
X-Received: by 10.55.41.17 with SMTP id p17mr19856251qkh.86.1432313629688;
 Fri, 22 May 2015 09:53:49 -0700 (PDT)
Received: by 10.140.23.72 with HTTP; Fri, 22 May 2015 09:53:49 -0700 (PDT)
In-Reply-To: <555E5B5C.9050807@imgtec.com>
References: <1432244260-14908-1-git-send-email-ezequiel.garcia@imgtec.com>
        <1432244260-14908-4-git-send-email-ezequiel.garcia@imgtec.com>
        <CAL1qeaFkzpH+nGqRPOuY-L62jP8NgZWP0WxKTYKXZDpe1sSojg@mail.gmail.com>
        <555E5B5C.9050807@imgtec.com>
Date:   Fri, 22 May 2015 09:53:49 -0700
X-Google-Sender-Auth: UHaB_RFTv0uFpSZdfYSM8yZvLgA
Message-ID: <CAL1qeaG4mh1_gnJA8RqF5xKuco=RUsXfLBcKC2g4OxiXfqUgKA@mail.gmail.com>
Subject: Re: [PATCH 3/7] clocksource: mips-gic: Split clocksource and
 clockevent initialization
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Govindraj Raja <Govindraj.Raja@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

On Thu, May 21, 2015 at 3:25 PM, Ezequiel Garcia
<ezequiel.garcia@imgtec.com> wrote:
>
>
> On 05/21/2015 07:24 PM, Andrew Bresticker wrote:
>> On Thu, May 21, 2015 at 2:37 PM, Ezequiel Garcia
>> <ezequiel.garcia@imgtec.com> wrote:
>>> This is preparation work for the introduction of clockevent frequency
>>> update with a clock notifier. This is only possible when the device
>>> is passed a clk struct, so let's split the legacy and devicetree
>>> initialization.
>>>
>>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>>> ---
>>>  drivers/clocksource/mips-gic-timer.c | 13 ++++++++-----
>>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
>>> index c4352f0..22a4daf 100644
>>> --- a/drivers/clocksource/mips-gic-timer.c
>>> +++ b/drivers/clocksource/mips-gic-timer.c
>>> @@ -142,11 +142,6 @@ static void __init __gic_clocksource_init(void)
>>>         ret = clocksource_register_hz(&gic_clocksource, gic_frequency);
>>>         if (ret < 0)
>>>                 pr_warn("GIC: Unable to register clocksource\n");
>>> -
>>> -       gic_clockevent_init();
>>> -
>>> -       /* And finally start the counter */
>>> -       gic_start_count();
>>>  }
>>
>> Instead of duplicating this bit in both the OF and non-OF paths, maybe
>> it would be better to do the notifier registration in
>> gic_clockevent_init(), either by passing around the struct clk or
>> making it a global?
>>
>
> Yeah, I had something like that first, but somehow it looked ugly to have:
>
>   gic_clockevent_init(IS_ERR(clk) ? NULL : clk);
>
> Don't have a strong opinion though.

Ah that is a bit ugly.  I'm fine either way though, so:

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
