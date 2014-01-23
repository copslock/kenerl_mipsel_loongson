Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jan 2014 09:23:56 +0100 (CET)
Received: from szxga02-in.huawei.com ([119.145.14.65]:1735 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825722AbaAWIXyFUNT- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jan 2014 09:23:54 +0100
Received: from 172.24.2.119 (EHLO szxeml210-edg.china.huawei.com) ([172.24.2.119])
        by szxrg02-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id BOZ66105;
        Thu, 23 Jan 2014 16:19:58 +0800 (CST)
Received: from SZXEML413-HUB.china.huawei.com (10.82.67.152) by
 szxeml210-edg.china.huawei.com (172.24.2.183) with Microsoft SMTP Server
 (TLS) id 14.3.158.1; Thu, 23 Jan 2014 16:17:45 +0800
Received: from [127.0.0.1] (10.177.27.212) by szxeml413-hub.china.huawei.com
 (10.82.67.152) with Microsoft SMTP Server id 14.3.158.1; Thu, 23 Jan 2014
 16:17:39 +0800
Message-ID: <52E0D01D.3080403@huawei.com>
Date:   Thu, 23 Jan 2014 16:17:33 +0800
From:   Yijing Wang <wangyijing@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
MIME-Version: 1.0
To:     Tony Prisk <linux@prisktech.co.nz>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kevin Hilman <khilman@deeprootsystems.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux <linux@openrisc.net>, Sekhar Nori <nsekhar@ti.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Walker <dwalker@fifo99.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Jonas Bonn <jonas@southpole.se>,
        Kukjin Kim <kgene.kim@samsung.com>,
        Russell King <linux@arm.linux.org.uk>,
        "Richard Weinberger" <richard@nod.at>,
        the arch/x86 maintainers <x86@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ingo Molnar <mingo@redhat.com>,
        <linux-arm-msm@vger.kernel.org>,
        David Brown <davidb@codeaurora.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Mike Frysinger <vapier@gentoo.org>,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Jeff Dike <jdike@addtoit.com>,
        "Barry Song" <baohua@kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        uml-user <user-mode-linux-user@lists.sourceforge.net>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        <davinci-linux-open-source@linux.davincidsp.com>,
        Michal Simek <monstr@monstr.eu>,
        Jim Cromie <jim.cromie@gmail.com>,
        <microblaze-uclinux@itee.uq.edu.au>,
        Hanjun Guo <guohanjun@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Bryan Huntsman <bryanh@codeaurora.org>,
        "uclinux-dist-devel@blackfin.uclinux.org" 
        <uclinux-dist-devel@blackfin.uclinux.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 2/2] clocksource: Make clocksource register functions
 void
References: <1390461166-36440-1-git-send-email-wangyijing@huawei.com>   <52E0C889.6000106@prisktech.co.nz> <CAMuHMdUcKb8m71Z7dUo86MQ_KZgPujxsduUUt3Mz8Oke+DLSVw@mail.gmail.com> <52E0CD18.5080104@prisktech.co.nz>
In-Reply-To: <52E0CD18.5080104@prisktech.co.nz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.27.212]
X-CFilter-Loop: Reflected
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wangyijing@huawei.com
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

On 2014/1/23 16:04, Tony Prisk wrote:
> On 23/01/14 20:58, Geert Uytterhoeven wrote:
>> On Thu, Jan 23, 2014 at 8:45 AM, Tony Prisk <linux@prisktech.co.nz> wrote:
>>>>    -static inline int clocksource_register_hz(struct clocksource *cs, u32
>>>> hz)
>>>> +static inline void clocksource_register_hz(struct clocksource *cs, u32
>>>> hz)
>>>>    {
>>>>          return __clocksource_register_scale(cs, 1, hz);
>>>>    }
>>>
>>> This doesn't make sense - you are still returning a value on a function
>>> declared void, and the return is now from a function that doesn't return
>>> anything either ?!?!
>>> Doesn't this throw a compile-time warning??
>> No, passing on void in functions returning void doesn't cause compiler
>> warnings.
>>
>> Gr{oetje,eeting}s,
>>
>>                          Geert
>>
>> -- 
>> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>>
>> In personal conversations with technical people, I call myself a hacker. But
>> when I'm talking to journalists I just say "programmer" or something like that.
>>                                  -- Linus Torvalds
> Doesn't seem right to me (even if there is no warning) but that's probably because I used to program in Pascal where functions with no return were 'procedures' :)
> Whether it needs to be changed or not:
> 
> For the vt8500 part -
> Acked-by: Tony Prisk <linux@prisktech.co.nz>

Thanks!

> 
> Regards
> Tony Prisk
> 
> 
> .
> 


-- 
Thanks!
Yijing
