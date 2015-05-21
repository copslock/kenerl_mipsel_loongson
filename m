Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 00:31:56 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33377 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013595AbbEUWbyVGUje (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 00:31:54 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 60991128FBF65;
        Thu, 21 May 2015 23:31:47 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 21 May
 2015 23:28:49 +0100
Received: from [10.100.200.44] (10.100.200.44) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Thu, 21 May
 2015 23:28:48 +0100
Message-ID: <555E5B5C.9050807@imgtec.com>
Date:   Thu, 21 May 2015 19:25:32 -0300
From:   Ezequiel Garcia <ezequiel.garcia@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Andrew Bresticker <abrestic@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Govindraj Raja <Govindraj.Raja@imgtec.com>
Subject: Re: [PATCH 3/7] clocksource: mips-gic: Split clocksource and clockevent
 initialization
References: <1432244260-14908-1-git-send-email-ezequiel.garcia@imgtec.com>      <1432244260-14908-4-git-send-email-ezequiel.garcia@imgtec.com> <CAL1qeaFkzpH+nGqRPOuY-L62jP8NgZWP0WxKTYKXZDpe1sSojg@mail.gmail.com>
In-Reply-To: <CAL1qeaFkzpH+nGqRPOuY-L62jP8NgZWP0WxKTYKXZDpe1sSojg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.100.200.44]
Return-Path: <Ezequiel.Garcia@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47533
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



On 05/21/2015 07:24 PM, Andrew Bresticker wrote:
> On Thu, May 21, 2015 at 2:37 PM, Ezequiel Garcia
> <ezequiel.garcia@imgtec.com> wrote:
>> This is preparation work for the introduction of clockevent frequency
>> update with a clock notifier. This is only possible when the device
>> is passed a clk struct, so let's split the legacy and devicetree
>> initialization.
>>
>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>> ---
>>  drivers/clocksource/mips-gic-timer.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
>> index c4352f0..22a4daf 100644
>> --- a/drivers/clocksource/mips-gic-timer.c
>> +++ b/drivers/clocksource/mips-gic-timer.c
>> @@ -142,11 +142,6 @@ static void __init __gic_clocksource_init(void)
>>         ret = clocksource_register_hz(&gic_clocksource, gic_frequency);
>>         if (ret < 0)
>>                 pr_warn("GIC: Unable to register clocksource\n");
>> -
>> -       gic_clockevent_init();
>> -
>> -       /* And finally start the counter */
>> -       gic_start_count();
>>  }
> 
> Instead of duplicating this bit in both the OF and non-OF paths, maybe
> it would be better to do the notifier registration in
> gic_clockevent_init(), either by passing around the struct clk or
> making it a global?
> 

Yeah, I had something like that first, but somehow it looked ugly to have:

  gic_clockevent_init(IS_ERR(clk) ? NULL : clk);

Don't have a strong opinion though.
-- 
Ezequiel
