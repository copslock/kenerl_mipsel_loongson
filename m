Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2011 23:42:08 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4639 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491079Ab1FIVmE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2011 23:42:04 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4df13e6c0000>; Thu, 09 Jun 2011 14:43:08 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 9 Jun 2011 14:42:02 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 9 Jun 2011 14:42:02 -0700
Message-ID: <4DF13E25.2060502@caviumnetworks.com>
Date:   Thu, 09 Jun 2011 14:41:57 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     guenter.roeck@ericsson.com
CC:     linux-mips@linux-mips.org
Subject: Re: Linux 2.6.39 on Cavium CN38xx
References: <1307653714.8271.130.camel@groeck-laptop>
In-Reply-To: <1307653714.8271.130.camel@groeck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jun 2011 21:42:02.0666 (UTC) FILETIME=[119FD0A0:01CC26EE]
X-archive-position: 30311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8539

On 06/09/2011 02:08 PM, Guenter Roeck wrote:
> Hi folks,
>
> I am trying to get Linux 2.6.39

Where did you get your 2.6.39?  Or in othe rwords, what's the SHA1 Kenneth?

And, what is your .config?

> to run on a board with Cavium CN38xx
> (pass 3, cpu ID 0x000d0003).
>
> Problem I have is that CPUs 1..15 come online, but get stuck in and
> endless interrupt handling loop as soon as interrupts are enabled. I
> attached a log generated with instrumentation code in the interrupt
> handler.
>
> Any idea what I might be doing wrong ? Note that I don't start the
> system from u-boot; the board uses OFW, so some register initialization
> may be wrong.
>

Octeon only supports the Octeon u-boot 'bootoctlinux' protocol.

You have to make sure that the octeon_bootinfo structure is filled in 
properly, and all the CPUs in the core_mask enter the kernel.


> I did see commit dbb103b243e09475c84df2b8ef17615975593761, but I have no
> idea if my problem may be related.
>

Probably not because the Ethernet driver would not be active at this point.

David Daney

> Thanks,
> Guenter
>
> ------------------------------
>
> SMP: Booting CPU09 (CoreId  9)...
> Core 9 ALIVE
>   --- waiting for CPU 9
> CPU revision is: 000d0003 (Cavium Octeon)
>   --- ### CPU 9 SR=0x100000e0
>   ---- set CPU 9 (9) callin map bit
>   ---- CPU 9 (9) call cpu_idle
> CPU 9: IRQ cause 0x0 status 0:0:0:0:0:0
> Cpu 9
> $ 0   : 0000000000000000 000000001000efe1 ffffffff81582db8
> 00000000000001ff
> $ 4   : 0000000000000009 0000000000000009 0000000000000048
> 0000000000000000
> $ 8   : 0000000000000000 0000000000000008 0000000000000000
> 0000000000000000
> $12   : 0000000000000000 ffffffff812b69bc ffffffff8140aed0
> ffffffffbfc02334
> $16   : ffffffff81582db8 0000000000000009 ffffffff815f07b0
> ffffffff81582db8
> $20   : ffffffff815e38d0 ffffffff815830f0 ffffffff815de600
> ffffffff81420000
> $24   : 0000000000000001
> ffffffff8110e870
> $28   : a80000041fe20000 a80000041fe23bf0 0000000000000003
> ffffffff8110a60c
> Hi    : 000000000b71b000
> Lo    : 000000000a037a00
> epc   : ffffffff8140d8e4 schedule+0xdc/0xde8
>      Not tainted
> ra    : ffffffff8110a60c cpu_idle+0x2fc/0x350
> Status: 1000efe3    KX SX UX KERNEL EXL IE
> Cause : 40800000
> PrId  : 000d0003 (Cavium Octeon)
> Call Trace:
> [<ffffffff8140d18c>] dump_stack+0x8/0x34
> [<ffffffff81100fbc>] plat_irq_dispatch+0x2bc/0x2c8
> [<ffffffff81107ea8>] ret_from_irq+0x0/0x4
> [<ffffffff8140d8e4>] schedule+0xdc/0xde8
> [<ffffffff8110a60c>] cpu_idle+0x2fc/0x350
>
> ---
>
> 2nd and subsequent interrupts:
>
> CPU 9: IRQ cause 0x0 status 0:0:0:0:0:0
> Call Trace:
> [<ffffffff8140d18c>] dump_stack+0x8/0x34
> [<ffffffff81100ec4>] plat_irq_dispatch+0x1c4/0x2c8
> [<ffffffff81107ea8>] ret_from_irq+0x0/0x4
> [<ffffffff8140d8e4>] schedule+0xdc/0xde8
> [<ffffffff8110a60c>] cpu_idle+0x2fc/0x350
>
>
>
>
