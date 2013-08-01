Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Aug 2013 08:22:37 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:51035 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816354Ab3HAGWdpEaO0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Aug 2013 08:22:33 +0200
Message-ID: <51F9FD16.4030706@phrozen.org>
Date:   Thu, 01 Aug 2013 08:15:50 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH] MIPS: add proper set_mode() to cevt-r4k
References: <1375091743-20608-1-git-send-email-blogic@openwrt.org> <CAGVrzcYcP8kUueLkDtL+fT9g+HFUKGgdw_hTRXkhA8P+4LbL8A@mail.gmail.com> <51F963E7.50407@gmail.com> <1687511.8JA8mPPmNW@lenovo>
In-Reply-To: <1687511.8JA8mPPmNW@lenovo>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

On 31/07/13 21:26, Florian Fainelli wrote:
> Le mercredi 31 juillet 2013 12:22:15 David Daney a écrit :
>> On 07/29/2013 04:14 AM, Florian Fainelli wrote:
>>> 2013/7/29 John Crispin<john@phrozen.org>:
>> [...]
>>
>>>>> It looks to me like you are moving the irq setup later just to ensure
>>>>> that your ralink clockevent device has been registered before and has
>>>>> set cp0_timer_irq_installed when the set_mode() r4k clockevent device
>>>>> runs, such that it won't register the same IRQ that your platforms
>>>>> uses. If that it the case, cannot you just ensure that you run your
>>>>> cevt device registration before mips_clockevent_init() is called?
>>>>
>>>> i dont like relying on the order in which the modules get loaded.
>>>
>>> plat_time_init() runs before mips_clockevent_init() and the ordering
>>> is explicit, would not that work for what you are trying to do?
>>>
>>>> the actual problem is not the irq sharing but that the cevt-r4k registers
>>>> the irq when the cevt is registered and not when it is activated. i
>>>> believe
>>>> that the patch fixes this problem
>>>
>>> Your patch certainly does what you say it does, but that is kind of an
>>> abuse of the set_mode() callback.
>>
>> I might as add my $0.02...
>>
>> There are many other clockevent drivers that do this type of thing
>> aren't there?  The clockevent framework uses this to
>> install/remove/switch drivers, so why should cevt-r4k not be made to
>> work like this?
>
> Whatever works for you. I still would like to understand why plat_time_init()
> is not suitable for John's specific use case.

Hi Florian,

the reason is that fixing it in plat_time_init() works around the real 
problem. the double request of the irq is a symptom of the actual 
problem, which is, that the cevt-r4k sets up the timer during init and 
not during setup. additionally, plat_time_init is used to probe the cevt 
drivers from OF already. currently the mips code just assumes that on a 
r4k we always have and want to run the cevt-r4k. this assumption is 
wrong and can quickly be fixed by making the cevt-r4k use the correct api.

also fixing it this way allows the user to control the clocksource and 
change it at runtime via sysfs, a feature als not working currently on 
r4k as the cevt driver did not implement the set_mode() handler 
correctly. to be quite honest, i cannot think of a single way in which 
this can be fixed cleanly in the ralink plat_time_init() without using 
some weird heuristic. also if i fix this inside ralink plat_time_init() 
it is fixed only on ralink SoC and not on any other platform.

	John
