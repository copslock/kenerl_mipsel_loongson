Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 May 2017 00:00:50 +0200 (CEST)
Received: from hauke-m.de ([IPv6:2001:41d0:8:b27b::1]:53412 "EHLO
        mail.hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994890AbdESWAnfODB1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 May 2017 00:00:43 +0200
Received: from [IPv6:2003:86:281c:1400:5108:40ff:ace0:afe] (p20030086281C1400510840FFACE00AFE.dip0.t-ipconnect.de [IPv6:2003:86:281c:1400:5108:40ff:ace0:afe])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 26526100036;
        Sat, 20 May 2017 00:00:36 +0200 (CEST)
Subject: Re: kernel 4.12-rc1 does not boot with CONFIG_MIPS_MT_SMP enabled on
 lantiq xway xrx200
To:     Matt Redfearn <matt.redfearn@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
References: <26d0c2c6-e7a6-f39a-974f-5809b94d9845@hauke-m.de>
 <39a5c44b-ea5f-5ae7-5626-a7be364be0ab@imgtec.com>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <1c8c287d-537e-669c-c615-fa4810c1a873@hauke-m.de>
Date:   Sat, 20 May 2017 00:00:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <39a5c44b-ea5f-5ae7-5626-a7be364be0ab@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 05/18/2017 10:19 AM, Matt Redfearn wrote:
> Hi Hauke,
> 
> I would guess something to do with the conversion of the CPU interrupt
> controller to IPI domains by patchset
> https://patchwork.linux-mips.org/project/linux-mips/list/?series=255&state=*,
> new in 4.12, has broken your IPIs and a CPU is getting stuck waiting for
> the other to respond.
> 
> Note that Paul says the Lantiq part of patch
> https://patchwork.linux-mips.org/patch/15837/
> (1eed40043579608e16509c43eeeb3a53a8a42378) has only been compile tested.
> 
> Thanks,
> 
> Matt
> 
> 
> On 17/05/17 23:12, Hauke Mehrtens wrote:
>> Hi,
>>
>> I just tried to boot Linux 4.12-rc1 on a Lantiq Xway xrx200 board and
>> boot failed when I had CONFIG_MIPS_MT_SMP enabled.
>>
>> It works with SMP on 4.9 and I think I also tried 4.11-rcX, but I am not
>> 100% sure. I will investigate this problem further on Friday.
>>
>> If someone has an idea what I should test, I will do it on Friday.
>>
>> Both boot logs are attached to this mail.

Hi Matt and Paul,

you are correct, this commit breaks booting of Lantiq boards when SMP is
enabled on 4.12-rc1: https://patchwork.linux-mips.org/patch/15837/
When I revert this commit or when I add the boot option nosmp the system
boots again.

The problem is that the Lantiq IRQ controller gets registered first and
it directly handles the MIPS native SW1/2 and HW0 - HW5 IRQs. It looks
like this controller already registers IRQ 0 - 7 and the generic driver
only gets the following IRQs starting later.

root@LEDE:/# cat /proc/interrupts
           CPU0
  7:      26253      MIPS   7  timer
  8:          0      MIPS   0  IPI call
  9:          0      MIPS   1  IPI resched
 22:        130       icu  22  spi_rx
 23:         10       icu  23  spi_tx
 24:          0       icu  24  spi_err
112:        142       icu 112  asc_tx
113:         27       icu 113  asc_rx
114:          0       icu 114  asc_err
ERR:          0
root@LEDE:/#

I see two options to fix this problem.
1. Revert the removing of the SMP IRQ code from arch/mips/lantiq/irq.c
and make the generic code "register" IRQ 8 and 9 for SMP.
2. Make the Lantiq IRQ code use the generic MIPS IRQ code and only
handle the Lantiq IRQ controller ICU and not the MIPS IRQs.

Which option should I choose, or is there something else?


Hauke
