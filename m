Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Feb 2017 10:27:29 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14125 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993890AbdBPJ1WGe1-w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Feb 2017 10:27:22 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 4EE1D9347565;
        Thu, 16 Feb 2017 09:27:13 +0000 (GMT)
Received: from [10.80.2.5] (10.80.2.5) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 16 Feb
 2017 09:27:15 +0000
Subject: Re: [PATCH 1/2] pwm: loongson1: Add PWM driver for Loongson1 SoC
To:     Yang Ling <gnaygnil@gmail.com>
References: <20170213152801.GA32019@ubuntu>
 <f27d34d4-b0ac-2fd6-bc75-89a6c913ba3c@imgtec.com>
 <20170215130902.GA32795@ubuntu>
CC:     <thierry.reding@gmail.com>, <keguang.zhang@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Message-ID: <0d0c43f5-1016-4cb5-01f8-9ca82860b8ad@imgtec.com>
Date:   Thu, 16 Feb 2017 10:27:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170215130902.GA32795@ubuntu>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

Hi Yang,

On 15.02.2017 14:09, Yang Ling wrote:

>>> +	tmp = (unsigned long long)clk_get_rate(pc->clk) * period_ns;
>>> +	do_div(tmp, 1000000000);

NSEC_PER_SEC ?

>>> +	period = tmp;
>>> +
>>> +	tmp = (unsigned long long)period * duty_ns;
>>> +	do_div(tmp, period_ns);
>>> +	duty = period - tmp;
>>> +
>>> +	if (duty >= period)
>>> +		duty = period - 1;
>>> +
>>> +	if (duty >> 24 || period >> 24)
>>> +		return -EINVAL;
>>> +
>>> +	chan->period_ns = period_ns;
>>> +	chan->duty_ns = duty_ns;
>>> +
>>> +	writel(duty, pc->base + PWM_HRC(pwm->hwpwm));
>>> +	writel(period, pc->base + PWM_LRC(pwm->hwpwm));
>>> +	writel(0x00, pc->base + PWM_CNT(pwm->hwpwm));
>>> +
>>
>> PWM_HRC and PWM_LRC names suggest that you're using high/low state
>> counters here rather than duty/period - but with no documentation
>> I'm just guessing here.
>
> Indeed, the high/low state counters is used here.
> Change the name to duty_cnt/period_cnt.
>
>

What I was referring to here is that if you have a high/low value 
counters that you enter then these are not the same as duty/period, in 
simple terms:
high_cnt = duty_cnt
low_cnt = period_cnt - duty_cnt

so please double check that this is what you want to be doing? As the 
names used suggest that this code may be wrong. Or maybe what you're 
doing is correct but the register access macros have misleading names?

Marcin
