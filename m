Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 May 2017 13:55:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9714 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992366AbdEVLzCyETQY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 May 2017 13:55:02 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 151369C3B9B01;
        Mon, 22 May 2017 12:54:53 +0100 (IST)
Received: from [10.150.130.83] (10.150.130.83) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 22 May
 2017 12:54:56 +0100
Subject: Re: kernel 4.12-rc1 does not boot with CONFIG_MIPS_MT_SMP enabled on
 lantiq xway xrx200
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
References: <26d0c2c6-e7a6-f39a-974f-5809b94d9845@hauke-m.de>
 <39a5c44b-ea5f-5ae7-5626-a7be364be0ab@imgtec.com>
 <1c8c287d-537e-669c-c615-fa4810c1a873@hauke-m.de>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <51af78c1-500c-7f68-feb3-57af09529a2c@imgtec.com>
Date:   Mon, 22 May 2017 12:54:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1c8c287d-537e-669c-c615-fa4810c1a873@hauke-m.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Hi Hauke,


On 19/05/17 23:00, Hauke Mehrtens wrote:
> On 05/18/2017 10:19 AM, Matt Redfearn wrote:
>> Hi Hauke,
>>
>> I would guess something to do with the conversion of the CPU interrupt
>> controller to IPI domains by patchset
>> https://patchwork.linux-mips.org/project/linux-mips/list/?series=255&state=*,
>> new in 4.12, has broken your IPIs and a CPU is getting stuck waiting for
>> the other to respond.
>>
>> Note that Paul says the Lantiq part of patch
>> https://patchwork.linux-mips.org/patch/15837/
>> (1eed40043579608e16509c43eeeb3a53a8a42378) has only been compile tested.
>>
>> Thanks,
>>
>> Matt
>>
>>
>> On 17/05/17 23:12, Hauke Mehrtens wrote:
>>> Hi,
>>>
>>> I just tried to boot Linux 4.12-rc1 on a Lantiq Xway xrx200 board and
>>> boot failed when I had CONFIG_MIPS_MT_SMP enabled.
>>>
>>> It works with SMP on 4.9 and I think I also tried 4.11-rcX, but I am not
>>> 100% sure. I will investigate this problem further on Friday.
>>>
>>> If someone has an idea what I should test, I will do it on Friday.
>>>
>>> Both boot logs are attached to this mail.
> Hi Matt and Paul,
>
> you are correct, this commit breaks booting of Lantiq boards when SMP is
> enabled on 4.12-rc1: https://patchwork.linux-mips.org/patch/15837/
> When I revert this commit or when I add the boot option nosmp the system
> boots again.
>
> The problem is that the Lantiq IRQ controller gets registered first and
> it directly handles the MIPS native SW1/2 and HW0 - HW5 IRQs. It looks
> like this controller already registers IRQ 0 - 7 and the generic driver
> only gets the following IRQs starting later.
>
> root@LEDE:/# cat /proc/interrupts
>             CPU0
>    7:      26253      MIPS   7  timer
>    8:          0      MIPS   0  IPI call
>    9:          0      MIPS   1  IPI resched
>   22:        130       icu  22  spi_rx
>   23:         10       icu  23  spi_tx
>   24:          0       icu  24  spi_err
> 112:        142       icu 112  asc_tx
> 113:         27       icu 113  asc_rx
> 114:          0       icu 114  asc_err
> ERR:          0
> root@LEDE:/#
>
> I see two options to fix this problem.
> 1. Revert the removing of the SMP IRQ code from arch/mips/lantiq/irq.c
> and make the generic code "register" IRQ 8 and 9 for SMP.

Ideally we'd entirely get rid of the notion of hardcoded expected VIRQ 
numbers, but for some platforms like Malta with it's i8259 it's 
impossible to do so.

> 2. Make the Lantiq IRQ code use the generic MIPS IRQ code and only
> handle the Lantiq IRQ controller ICU and not the MIPS IRQs.

Option 2 sounds like the right way to go.... hopefully it will reduce 
the amount of Lantiq specific code if you make use of the generic MIPS 
cpu interrupt controller stuff - that was certainly the case for the 
Malta platform code.

Thanks,
Matt

>
> Which option should I choose, or is there something else?
>
>
> Hauke
