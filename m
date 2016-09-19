Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Sep 2016 10:25:49 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:59846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990519AbcISIZle3-sJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Sep 2016 10:25:41 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64890F0;
        Mon, 19 Sep 2016 01:25:34 -0700 (PDT)
Received: from [10.1.207.16] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 419913F211;
        Mon, 19 Sep 2016 01:25:33 -0700 (PDT)
Subject: Re: genirq: Setting trigger mode 0 for irq 11 failed
 (txx9_irq_set_type+0x0/0xb8)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
References: <CAMuHMdVW1eTn20=EtYcJ8hkVwohaSuH_yQXrY2MGBEvZ8fpFOg@mail.gmail.com>
 <1473980577.17787.21.camel@gmail.com> <57DBA464.9010506@arm.com>
 <CAMuHMdW+MdtdcdD=7J3BFobaUBnFhfUdyUD8g8u6hx5TuqyHPA@mail.gmail.com>
Cc:     Alban Browaeys <alban.browaeys@gmail.com>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jon Hunter <jonathanh@nvidia.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <57DFA0FB.8070807@arm.com>
Date:   Mon, 19 Sep 2016 09:25:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdW+MdtdcdD=7J3BFobaUBnFhfUdyUD8g8u6hx5TuqyHPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marc.zyngier@arm.com
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

On 18/09/16 11:26, Geert Uytterhoeven wrote:
> Hi Marc,
> 
> On Fri, Sep 16, 2016 at 9:51 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 16/09/16 00:02, Alban Browaeys wrote:
>>> Le mercredi 14 septembre 2016 à 21:25 +0200, Geert Uytterhoeven a
>>> écrit :
>>>> JFYI, with v4.8-rc6 I'm seeing
>>>>
>>>>     genirq: Setting trigger mode 0 for irq 11 failed
>>>> (txx9_irq_set_type+0x0/0xb8)
>>>>
>>>> on rbtx4927. This did not happen with v4.8-rc3.
>>>
>>> txx9_irq_set_type receives a type IRQ_TYPE_NONE from the call to
>>> __irq_set_trigger added in:
>>> 1e12c4a939 ("genirq: Correctly configure the trigger on chained interrupts")
> 
> Yep, that's the commit that introduced the issue.
> 
>>> This patch is a regression fix for :
>>>
>>> Desc: irqdomain: Don't set type when mapping an IRQ breaks nexus7 gpio buttons
>>> Repo: 2016-07-30 https://marc.info/?l=linux-kernel&m=146985356305280&w=2
>>>
>>> I am seeing this on arm odroid u2 devicetree :
>>> genirq: Setting trigger mode 0 for irq 16 failed (gic_set_type+0x0/0x64)
>>
>> Passing IRQ_TYPE_NONE to a cascading interrupt is risky at best...
>> Can you point me to the various DTs and their failing interrupts?
> 
> Rbtx4927 does not use DT. The issue is triggered during:
> 
>     irq_set_chained_handler(RBTX4927_IRQ_IOCINT, handle_simple_irq);
> 
> in arch/mips/txx9/rbtx4927/irq.c:toshiba_rbtx4927_irq_ioc_init(),
> which is inlined into rbtx4927_irq_setup().

Right. Vintage stuff ;-). It is odd that there is not handling of
interrupt trigger at all, but maybe the HW doesn't support it
(everything looks level).

> 
>> Also, can you please give the following patch a go and let me know
>> if that fixes the issue (I'm interested in the potential warning here).
>>
>> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>> index 6373890..8422779 100644
>> --- a/kernel/irq/chip.c
>> +++ b/kernel/irq/chip.c
>> @@ -820,6 +820,8 @@ __irq_do_set_handler(struct irq_desc *desc, irq_flow_handler_t handle,
>>         desc->name = name;
>>
>>         if (handle != handle_bad_irq && is_chained) {
>> +               unsigned int type = irqd_get_trigger_type(&desc->irq_data);
>> +
>>                 /*
>>                  * We're about to start this interrupt immediately,
>>                  * hence the need to set the trigger configuration.
>> @@ -828,8 +830,10 @@ __irq_do_set_handler(struct irq_desc *desc, irq_flow_handler_t handle,
>>                  * chained interrupt. Reset it immediately because we
>>                  * do know better.
>>                  */
>> -               __irq_set_trigger(desc, irqd_get_trigger_type(&desc->irq_data));
>> -               desc->handle_irq = handle;
>> +               if (!(WARN_ON(type == IRQ_TYPE_NONE))) {
>> +                       __irq_set_trigger(desc, type);
>> +                       desc->handle_irq = handle;
>> +               }
>>
>>                 irq_settings_set_noprobe(desc);
>>                 irq_settings_set_norequest(desc);
> 
> This indeed makes the issue go away:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at kernel/irq/chip.c:833 __irq_do_set_handler+0x144/0x1b4
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted
> 4.8.0-rc6-rbtx4927-01162-g1596ef0280a363ac-dirty #50
> Stack : 00000000 10000000 0000000b 00000004 80453f47 804542d8 80429ff8 00000000
>          804a36c8 00000341 80789384 000001e0 803c70b0 8014a19c 80460ac8 80460acc
>          804314ec 00000000 8042f408 80451d94 80789384 80173624 803c70b0 8014a19c
>          00000007 000009e0 00000000 00000000 00000000 00000000 00000000 0000000
> 
>          00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>          ...
> Call Trace:
> [<8010abf0>] show_stack+0x50/0x84
> [<8012100c>] __warn+0xe4/0x118
> [<80121098>] warn_slowpath_null+0x1c/0x28
> [<8014f7a0>] __irq_do_set_handler+0x144/0x1b4
> [<8014f860>] __irq_set_handler+0x50/0x7c
> [<804740ac>] tx4927_irq_init+0x34/0xa8
> [<80475e9c>] rbtx4927_irq_setup+0x30/0xd0
> [<8046e9c0>] start_kernel+0x288/0x450
> 
> ---[ end trace 0000000000000000 ]---
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at kernel/irq/chip.c:833 __irq_do_set_handler+0x144/0x1b4
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Tainted: G        W
> 4.8.0-rc6-rbtx4927-01162-g1596ef0280a363ac-dirty #50
> Stack : 00000000 10000400 00000009 00000004 80453f47 804542d8 80429ff8 00000000
>          804a36c8 00000341 80789384 000001e0 803c70b0 8014a19c 80460ac8 80460acc
>          804314ec 00000000 8042f408 80451dac 80789384 80173624 803c70b0 8014a19c
>          00000000 00000f00 00000000 00000000 00000000 00000000 00000000 00000000
>          00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>          ...
> Call Trace:
> [<8010abf0>] show_stack+0x50/0x84
> [<8012100c>] __warn+0xe4/0x118
> [<80121098>] warn_slowpath_null+0x1c/0x28
> [<8014f7a0>] __irq_do_set_handler+0x144/0x1b4
> [<8014f860>] __irq_set_handler+0x50/0x7c
> [<80475f18>] rbtx4927_irq_setup+0xac/0xd0
> [<8046e9c0>] start_kernel+0x288/0x450
> 
> ---[ end trace f68728a0d3053b52 ]---
> 
> /proc/interrupts says:
> 
>                CPU0
>       7:      11977      MIPS   7  timer
>      13:      30586      TXX9  RBHMA4X00-RTL8019
>      16:        293      TXX9  serial_txx9
>      30:          0      TXX9  PCI error
>     ERR:          3

OK. I'll turn this a proper patch (without the WARN_ON) and post it for
Thomas to pick ASAP.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
