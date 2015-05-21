Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 00:05:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34964 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013589AbbEUWFsh2Uhx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 00:05:48 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C881466170EEE;
        Thu, 21 May 2015 23:05:41 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 21 May
 2015 23:05:45 +0100
Received: from [10.100.200.44] (10.100.200.44) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Thu, 21 May
 2015 23:05:44 +0100
Message-ID: <555E55F4.2060500@imgtec.com>
Date:   Thu, 21 May 2015 19:02:28 -0300
From:   Ezequiel Garcia <ezequiel.garcia@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        <devicetree@vger.kernel.org>,
        "Andrew Bresticker" <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        <Damien.Horsley@imgtec.com>, <Govindraj.Raja@imgtec.com>
Subject: Re: [PATCH 6/7] clocksource: Add Pistachio clocksource-only driver
References: <1432244260-14908-1-git-send-email-ezequiel.garcia@imgtec.com> <1432244506-15388-1-git-send-email-ezequiel.garcia@imgtec.com> <alpine.DEB.2.11.1505212352330.5457@nanos>
In-Reply-To: <alpine.DEB.2.11.1505212352330.5457@nanos>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.100.200.44]
Return-Path: <Ezequiel.Garcia@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel.garcia@imgtec.com
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



On 05/21/2015 07:00 PM, Thomas Gleixner wrote:
> On Thu, 21 May 2015, Ezequiel Garcia wrote:
>> +static cycle_t clocksource_read_cycles(struct clocksource *cs)
>> +{
>> +	u32 counter, overflw;
>> +	unsigned long flags;
>> +
>> +	raw_spin_lock_irqsave(&lock, flags);
> 
> Hmm. Is that lock really necessary to read that counter? The
> clocksource is global. And if its actually used for timekeeping, the
> lock can get heavy contended.
> 

Yup, it is really (and sadly) necessary. The kernel hangs up completely
without it when the counter is accesed by more than one CPU.

Apparently, those two timer registers overflow and counter must be read
atomically.

>> +	overflw = gpt_readl(TIMER_CURRENT_OVERFLOW_VALUE, 0);
>> +	counter = gpt_readl(TIMER_CURRENT_VALUE, 0);
>> +	raw_spin_unlock_irqrestore(&lock, flags);
>> +
>> +	return ~(cycle_t)counter;
>> +}
> 
> Thanks,
> 
> 	tglx
> 

-- 
Ezequiel
