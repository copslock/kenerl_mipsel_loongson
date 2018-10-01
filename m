Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2018 10:48:23 +0200 (CEST)
Received: from mail-wm1-x344.google.com ([IPv6:2a00:1450:4864:20::344]:51463
        "EHLO mail-wm1-x344.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991808AbeJAIsRhaRRD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Oct 2018 10:48:17 +0200
Received: by mail-wm1-x344.google.com with SMTP id y25-v6so7826219wmi.1
        for <linux-mips@linux-mips.org>; Mon, 01 Oct 2018 01:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R9CJMIeFcZ8iHn0hpKm44TFWAl3+X4CN67TLXf13aHQ=;
        b=coR1VsBEtj0kJ1mZ1jz3pdAAyyaBlxiuk2frl4y5X8VJE1LePtX7bIHldJIM/vj0g2
         QjCVjyDAZSDkDaqG0JipfD4lB//hPsl15DZKsQqi4jd0V5boaYQfWNi7xUbxGhx4ko8L
         BQNGgwijfPNRf49zwHCw6HGupZcyuI+2W5pyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R9CJMIeFcZ8iHn0hpKm44TFWAl3+X4CN67TLXf13aHQ=;
        b=Wfoinkyj73U+dXb46PTsUlVgkOeT3gdK4UDEJqu329a0Dy+njpOPbfaEzTA2QPq0/h
         1/ZwSO7WQE9FK6sgZpgStD5TCqpbk9NZ0skIiRVL2L5Uvqo28RoIWLnrTzb3Od8ZmJIT
         ls5nn5gFCFSfP2lOEXvJevCHivNSgoiiPpNp80jaPqWU4uGCyiHjKx59QJldN8LY6gIx
         vJ9+PYdflCL9lcXPyJEvyaD2vnqBv4outlyRVnxrdqSkaZewS+MlMiIF7qe8ZkZF38QQ
         DFwdFRKOfllU9JkxheMHrPLyfGe7yGbFtUy7FNwX07sB/src+kYThivs5l3/M6xCJ+eH
         jIRw==
X-Gm-Message-State: ABuFfohdw1BK+O7s8BmHVw7xu27hOOdK+jXwJnAOKk6a4n4alW6b7Y/x
        hqq3pPS3Eou1l8/bF2j98/abmg==
X-Google-Smtp-Source: ACcGV62LzPXNoNM/2l/782JIfbTjRdlJCfbQwG6SIEKlNUaGeWtwPFoB1MROs3+5LPaj+nbPeC3VeA==
X-Received: by 2002:a1c:5dd4:: with SMTP id r203-v6mr7895873wmb.29.1538383691997;
        Mon, 01 Oct 2018 01:48:11 -0700 (PDT)
Received: from [192.168.0.41] (210.183.88.92.rev.sfr.net. [92.88.183.210])
        by smtp.googlemail.com with ESMTPSA id a18sm10442301wrx.55.2018.10.01.01.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 01:48:11 -0700 (PDT)
Subject: Re: [PATCH v5 04/21] dt-bindings: Add doc for the Ingenic TCU drivers
To:     Paul Cercueil <paul@crapouillou.net>, Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
References: <20180724231958.20659-1-paul@crapouillou.net>
 <20180724231958.20659-5-paul@crapouillou.net>
 <20180725152105.GA6347@rob-hp-laptop>
 <1532988062.4702.2@smtp.crapouillou.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <cfecfae5-abd0-c051-51a3-cb5d906006e9@linaro.org>
Date:   Mon, 1 Oct 2018 10:48:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532988062.4702.2@smtp.crapouillou.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.lezcano@linaro.org
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

On 31/07/2018 00:01, Paul Cercueil wrote:

[ ... ]

>>>  +- ingenic,timer-channel: Specifies the TCU channel that should be
>>> used as
>>>  +  system timer. If not provided, the TCU channel 0 is used for the
>>> system timer.
>>>  +
>>>  +- ingenic,clocksource-channel: Specifies the TCU channel that
>>> should be used
>>>  +  as clocksource and sched_clock. It must be a different channel
>>> than the one
>>>  +  used as system timer. If not provided, neither a clocksource nor a
>>>  +  sched_clock is instantiated.
>>
>> clocksource and sched_clock are Linux specific and don't belong in DT.
>> You should define properties of the hardware or use existing properties
>> like interrupts or clocks to figure out which channel to use. For
>> example, if some channels don't have an interrupt, then use them for
>> clocksource and not a clockevent. Or you could have timers that run in
>> low-power modes or not. If all the channels are identical, then it
>> shouldn't matter which ones the OS picks.

It can't work in this case because the pmw and the timer driver are not
communicating and the first one can stole a channel to the last one.


> We already talked about that. All the TCU channels can be used for PWM.
> The problem is I cannot know from the driver's scope which channels will
> be free and which channels will be requested for PWM. You suggested that I
> parse the devicetree for clients, and I did that in the V3/V4 patchset. But
> it only works for clients requesting through devicetree, not from platform
> code or even sysfs.
> 
> One thing I can try is to dynamically change the channels the system timer
> and clocksource are using when the current ones are requested for PWM. But
> that sounds hardcore...

Yes, it is :/

Sorry for letting you wasting time and effort to write an overkill code
not suitable for upstream.

A very gross thought, wouldn't be possible to "register" a channel from
the timer driver code in a shared data area (but well self-encapsulated)
and the pwm code will check such channel isn't in use ?

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
