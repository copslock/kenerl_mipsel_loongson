Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2017 11:27:45 +0200 (CEST)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:46546
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992348AbdJSJ1gmPZBN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Oct 2017 11:27:36 +0200
Received: by mail-wm0-x241.google.com with SMTP id m72so14722780wmc.1
        for <linux-mips@linux-mips.org>; Thu, 19 Oct 2017 02:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qt6AGulliyObWXsGH7xJjV2uGDp32ReAwJm0atjwPng=;
        b=HHtL/FAm1jyYp29jraY5VBgU4DyzBOyUea+pihH8F4K16MimP6x4xBHMU+BTNGZjaC
         KjooL7A2wVUMwTlWMVZVixAl3fDPAqChQEYjFI1k3GWtWY4CEdl8Q9tPgashK09mlhMv
         YjwbVlNQsWIOtXpb4zLTBC6u5bYErt6tPnWrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qt6AGulliyObWXsGH7xJjV2uGDp32ReAwJm0atjwPng=;
        b=OqLBG5E9Q9L2FajSm7Otdix0qsTVUWgS21eEd3AGGH8wuBRy1z6w8ECtbRucmW+cic
         fnzmsC4TFg4RVGuwdfmIYZwHfhpje6A0K39jXN5VIjFqHbkZkvHfizDdSx2DyED5+6A7
         LQ6z73xnilKuTC4VesP798y8vfcvQPcZDT9wu10Bmmc+q5f9k3WSEBOaDx27xTIsmZ0b
         uZqHjALrQG+O6zKrnO4LSRgZWOR0luFu9K0j+DkGxz/eATmHEC31TcOcI9mP9ZkzcNUv
         Flx1h2DGtMFoUgZFPN5EQdgVtA9Q1AX6dqKmdWVhRPueubONONA+iF0XNz/AV+NnNcnz
         6MhA==
X-Gm-Message-State: AMCzsaWlMRa5Uc07CDpDCcxeE/8JvIb/K4mx2FWMMW+wJRiiGHnsxN9y
        H3jmwvRAFMRl4lQotmD8F4nO4w==
X-Google-Smtp-Source: ABhQp+T/8p9wAMfku0gDFRPbkuQ6wRuZ8jKNNEMdpV45KKxMQkdS8SA64/A1b9fhDqGWAqiNWhAGtg==
X-Received: by 10.80.147.83 with SMTP id n19mr1705945eda.36.1508405251211;
        Thu, 19 Oct 2017 02:27:31 -0700 (PDT)
Received: from ?IPv6:2a01:e35:879a:6cd0:3e97:eff:fe5b:1402? ([2a01:e35:879a:6cd0:3e97:eff:fe5b:1402])
        by smtp.googlemail.com with ESMTPSA id d12sm8478307eda.27.2017.10.19.02.27.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Oct 2017 02:27:30 -0700 (PDT)
Subject: Re: [PATCH 1/3] clocksource/mips-gic-timer: Fix rcu_sched timeouts
 from multithreading
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Matt Redfearn <matt.redfearn@mips.com>, linux-mips@linux-mips.org,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        "# v3 . 19 +" <stable@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <1507730474-8577-1-git-send-email-matt.redfearn@mips.com>
 <alpine.DEB.2.20.1710182226080.2477@nanos>
 <32cc3d3e-88df-405f-5278-7fe00d066a93@linaro.org>
 <alpine.DEB.2.20.1710191117010.1971@nanos>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <faeb9fd6-fe7a-8c93-3769-2cc6d2300dbe@linaro.org>
Date:   Thu, 19 Oct 2017 11:27:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1710191117010.1971@nanos>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60460
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

On 19/10/2017 11:18, Thomas Gleixner wrote:
> On Thu, 19 Oct 2017, Daniel Lezcano wrote:
>> On 18/10/2017 22:34, Thomas Gleixner wrote:
>>> On Wed, 11 Oct 2017, Matt Redfearn wrote:
>>>
>>>> When the MIPS GIC clockevent code was written, it appears to have
>>>> inherited the 0x300 cycle min delta from the MIPS CPU timer driver. This
>>>> is suboptimal for two reasons.
>>>>
>>>> Firstly, the CPU timer counts once every other cycle (i.e. half the
>>>> clock rate). The GIC counts once per clock. Assuming that the GIC and
>>>> CPU share the same clock this means the GIC is counting twice as fast,
>>>> and so the min delta should be (at least) doubled. Fix this by doubling
>>>> the min delta to 0x600.
>>>>
>>>> Secondly, the fixed min delta ignores the fact that with MIPS
>>>> multithreading active, execution resource within a core is shared
>>>> between the hardware threads within that core. An inconvenienly timed
>>>> switch of executing thread within gic_next_event, between the read and
>>>> write of updated count, can result in the CPU writing an event in the
>>>> past, and subsequently not receiving a tick interrupt until the counter
>>>> wraps. This stalls the CPU from the RCU scheduler. Other CPUs detect
>>>> this and print rcu_sched timeout messages in  the kernel log. It can
>>>> lead to other issues as well if the CPU is holding locks or other
>>>> resources at the point at which it stalls. Fix this by scaling the min
>>>> delta for the timer based on the number of threads in the core
>>>> (smp_num_siblings). This accounts for the greater average runtime of
>>>> CPUs within a multithreading core.
>>>
>>> I don't understand why this is not catched by the check at the end of the
>>> next_event() function:
>>>
>>>         res = ((int)(gic_read_count() - cnt) >= 0) ? -ETIME : 0;
>>>
>>> Btw, the local_irq_save() in this function is pointless as this function is
>>> always called with interrupts disabled from the core code.
>>
>> Would it be worth to add some comment in include/linux/clockchips.h in
>> the structure definition for the different callbacks to tell which ones
>> are called with the irq disabled ?
> 
> Yes. IIRC all callbacks are invoked with interrupts disabled. Care to check
> that and whip up a patch?

Sure, no problem.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
