Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Aug 2011 04:30:19 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:3191 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491913Ab1H0CaQ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 27 Aug 2011 04:30:16 +0200
X-TM-IMSS-Message-ID: <6f1bbd5f0001834b@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 6f1bbd5f0001834b ; Fri, 26 Aug 2011 19:28:18 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: How to chip->startup() with IRQs disabled
Date:   Fri, 26 Aug 2011 19:30:42 -0700
Message-ID: <74B0AE1BA53C37449DE49BB274F9A2DBC4D053@orion8.netlogicmicro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to chip->startup() with IRQs disabled
Thread-Index: AcxkXxFexKfiew3eTL+AONbDJYpN1gAAWKVW
References: <74B0AE1BA53C37449DE49BB274F9A2DBC4D052@orion8.netlogicmicro.com> <CA+7sy7CSauuSAgF1Ai8dRbcVzVkdj7zWxVjOuyUJw2WSUwk5bg@mail.gmail.com>
From:   "Om Narasimhan" <onarasimhan@netlogicmicro.com>
To:     "Jayachandran C." <jayachandranc@netlogicmicro.com>
Cc:     <linux-mips@linux-mips.org>
X-archive-position: 31004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: onarasimhan@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20451

>On Sat, Aug 27, 2011 at 7:09 AM, Om Narasimhan
><onarasimhan@netlogicmicro.com> wrote:
>> Hi,
>> I am working on a chip with multiple cores. I have defined
>> static struct irq_chip new_plat_chip = {
>> ...
>>        .startup = n_irq_startup,
>>        .mask = n_irq_shutdown,
>> ...
>> };
>>
>> In n_irq_startup(), I have to make sure that all cores have set RVEC bit and
>> corresponding EIMR bit. So, I try using on_each_cpu() (because EIMR can be set
>> only by running code on that particular cpu) to run a function to set EIMR.
>>
>> n_irq_startup() is called as chip->startup() from __setup_irq() (from
>> request_threaded_irq, in turn from request_irq() ) with a spin lock held
>> (desc->lock, in kernel/irq/manage.c).  This causes a stack dump from
>> on_each_cpu(). Since it is wrong to call on_each_cpu with interrupts disabled,
>> I want to change this piece of code.
>
>>In XLR code
>>(http://git.linux-mips.org/?p=linux.git;a=blob;f=arch/mips/netlogic/xlr/smp.c)
>>we do the initialization of EIMR in nlm_init_secondary() which is
>>registered as .init_secondary method in smp_ops.  on_each_cpu() may not be the
>>right way to do this.

There is a problem with that approach. At initialization time one has no idea
about the interrupts that should be set. E.g, in our system, PCIe interrupts
need be enabled only if there is a device attached to one of the pcie bus.
Moreover, whether the device requests Intx, MSI or MSI-X is determinable only at
the event of request_irq(). That means, it is imperative that we defer setting
EIMR till request_irq()

Om.
