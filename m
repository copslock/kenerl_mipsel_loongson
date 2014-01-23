Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jan 2014 09:04:23 +0100 (CET)
Received: from server.prisktech.co.nz ([115.188.14.127]:60252 "EHLO
        server.prisktech.co.nz" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825733AbaAWIEUl0tV6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jan 2014 09:04:20 +0100
Received: from [192.168.0.102] (unknown [192.168.0.102])
        by server.prisktech.co.nz (Postfix) with ESMTP id 61BD0FC11D4;
        Thu, 23 Jan 2014 21:04:23 +1300 (NZDT)
Message-ID: <52E0CD18.5080104@prisktech.co.nz>
Date:   Thu, 23 Jan 2014 21:04:40 +1300
From:   Tony Prisk <linux@prisktech.co.nz>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Yijing Wang <wangyijing@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kevin Hilman <khilman@deeprootsystems.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux <linux@lists.openrisc.net>, Sekhar Nori <nsekhar@ti.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Walker <dwalker@fifo99.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Jonas Bonn <jonas@southpole.se>,
        Kukjin Kim <kgene.kim@samsung.com>,
        Russell King <linux@arm.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        the arch/x86 maintainers <x86@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ingo Molnar <mingo@redhat.com>, linux-arm-msm@vger.kernel.org,
        David Brown <davidb@codeaurora.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Mike Frysinger <vapier@gentoo.org>,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Jeff Dike <jdike@addtoit.com>, Barry Song <baohua@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        uml-user <user-mode-linux-user@lists.sourceforge.net>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        davinci-linux-open-source@linux.davincidsp.com,
        Michal Simek <monstr@monstr.eu>,
        Jim Cromie <jim.cromie@gmail.com>,
        microblaze-uclinux@itee.uq.edu.au,
        Hanjun Guo <guohanjun@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Bryan Huntsman <bryanh@codeaurora.org>,
        "uclinux-dist-devel@blackfin.uclinux.org" 
        <uclinux-dist-devel@blackfin.uclinux.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 2/2] clocksource: Make clocksource register functions
 void
References: <1390461166-36440-1-git-send-email-wangyijing@huawei.com>   <52E0C889.6000106@prisktech.co.nz> <CAMuHMdUcKb8m71Z7dUo86MQ_KZgPujxsduUUt3Mz8Oke+DLSVw@mail.gmail.com>
In-Reply-To: <CAMuHMdUcKb8m71Z7dUo86MQ_KZgPujxsduUUt3Mz8Oke+DLSVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <linux@prisktech.co.nz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@prisktech.co.nz
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

On 23/01/14 20:58, Geert Uytterhoeven wrote:
> On Thu, Jan 23, 2014 at 8:45 AM, Tony Prisk <linux@prisktech.co.nz> wrote:
>>>    -static inline int clocksource_register_hz(struct clocksource *cs, u32
>>> hz)
>>> +static inline void clocksource_register_hz(struct clocksource *cs, u32
>>> hz)
>>>    {
>>>          return __clocksource_register_scale(cs, 1, hz);
>>>    }
>>
>> This doesn't make sense - you are still returning a value on a function
>> declared void, and the return is now from a function that doesn't return
>> anything either ?!?!
>> Doesn't this throw a compile-time warning??
> No, passing on void in functions returning void doesn't cause compiler
> warnings.
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
Doesn't seem right to me (even if there is no warning) but that's 
probably because I used to program in Pascal where functions with no 
return were 'procedures' :)
Whether it needs to be changed or not:

For the vt8500 part -
Acked-by: Tony Prisk <linux@prisktech.co.nz>

Regards
Tony Prisk
