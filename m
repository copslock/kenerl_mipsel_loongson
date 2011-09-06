Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Sep 2011 21:17:14 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:12114 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491846Ab1IFTRJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Sep 2011 21:17:09 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e6671fc0000>; Tue, 06 Sep 2011 12:18:20 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 6 Sep 2011 12:17:08 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 6 Sep 2011 12:17:08 -0700
Message-ID: <4E6671B0.4040603@cavium.com>
Date:   Tue, 06 Sep 2011 12:17:04 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     SAURABH MALPANI <saurabh140585@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: MIPS: Octeon: mailbox_interrupt is not registered as per cpu
References: <CAFsuBjW4XZy6x4gDL+0cw92jUbuEodF4vzCcCijQDize97wkNQ@mail.gmail.com>        <4E6668A4.8010300@cavium.com> <CAFsuBjU_VnUPL+hpQV=m1HNJ6Fis38hyToOHBgROmiYYTEQHyQ@mail.gmail.com>
In-Reply-To: <CAFsuBjU_VnUPL+hpQV=m1HNJ6Fis38hyToOHBgROmiYYTEQHyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Sep 2011 19:17:08.0099 (UTC) FILETIME=[9205ED30:01CC6CC9]
X-archive-position: 31049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3419

On 09/06/2011 12:02 PM, SAURABH MALPANI wrote:
> Hi David,
>
> Thanks a bunch for clarifying this. Just to complete, I have some code
> which calls CHECK_IRQ_PER_CPU(desc->status) after every time a
> descriptor is created for an irq. And based on it we create either per
> cpu data structures or single data structure for that particular irq.
>
> After your clarification, I can safely create exception for
> OCTEON_IRQ_MBOX0 and OCTEON_IRQ_MBOX1 as you mention that missing the
> flag is just cosmetic.
>

Well the performance counter and timer interrupts may suffer in a 
similar manner.

David Daney


> Thanks again
> Saurabh
>
>
> On Wed, Sep 7, 2011 at 12:08 AM, David Daney<david.daney@cavium.com>  wrote:
>> On 09/05/2011 03:23 AM, SAURABH MALPANI wrote:
>>>
>>> Hi,
>>>
>>> <Re sending this because last time I am afraid I didn't hit the
>>> correct mail filters.>
>>>
>>> Query:
>>>
>>> mailbox_interrupt is not registered with IRQF_PERCPU but it is
>>> supposed to be percpu interrupt. Is that on purpose or a miss?
>>
>> On Octeon the per-cpuness of a particular irq is a property of the irq
>> itself rather than being controlled by IRQF_PERCPU.  So other than being
>> perhaps stylistically in poor taste, no harm is done by omitting IRQF_PERCPU
>> here.
>>
>>> I am
>>> porting some code from x86 to octeon which requires special handling
>>> for per cpu interrupts.
>>>
>>>   void octeon_prepare_cpus(unsigned int max_cpus)
>>> {
>>>           cvmx_write_csr(CVMX_CIU_MBOX_CLRX(cvmx_get_core_num()),
>>> 0xffffffff);
>>>           if (request_irq(OCTEON_IRQ_MBOX0, mailbox_interrupt,
>>> IRQF_DISABLED,
>>>                           "mailbox0", mailbox_interrupt)) {
>>>                   panic("Cannot request_irq(OCTEON_IRQ_MBOX0)\n");
>>>           }
>>>           if (request_irq(OCTEON_IRQ_MBOX1, mailbox_interrupt,
>>> IRQF_DISABLED,
>>>                           "mailbox1", mailbox_interrupt)) {
>>>                   panic("Cannot request_irq(OCTEON_IRQ_MBOX1)\n");
>>>           }
>>> }
>>>
>>> --
>>> Saurabh
>>>
>>>
>>
>>
>
>
>
