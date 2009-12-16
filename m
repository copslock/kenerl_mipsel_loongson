Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Dec 2009 23:42:13 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15391 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1494500AbZLPWmG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Dec 2009 23:42:06 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b295f8c0000>; Wed, 16 Dec 2009 14:30:41 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 16 Dec 2009 14:30:36 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 16 Dec 2009 14:30:36 -0800
Message-ID: <4B295F8C.4050905@caviumnetworks.com>
Date:   Wed, 16 Dec 2009 14:30:36 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Chetan Loke <chetanloke@gmail.com>
CC:     Chris Friesen <cfriesen@nortel.com>, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: Irq architecture for multi-core network driver.
References: <4AE0D14B.1070307@caviumnetworks.com> <4AE0D72A.4090607@nortel.com>  <4AE0DB98.1000101@caviumnetworks.com> <b2f3590f0912161408u73947f6fx6902ebef927caf94@mail.gmail.com>
In-Reply-To: <b2f3590f0912161408u73947f6fx6902ebef927caf94@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Dec 2009 22:30:36.0463 (UTC) FILETIME=[6350F3F0:01CA7E9F]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Chetan Loke wrote:
>>> Does your hardware do flow-based queues?  In this model you have
>>> multiple rx queues and the hardware hashes incoming packets to a single
>>> queue based on the addresses, ports, etc. This ensures that all the
>>> packets of a single connection always get processed in the order they
>>> arrived at the net device.
>>>
>> Indeed, this is exactly what we have.
>>
>>
>>> Typically in this model you have as many interrupts as queues
>>> (presumably 16 in your case).  Each queue is assigned an interrupt and
>>> that interrupt is affined to a single core.
> 
>> Certainly this is one mode of operation that should be supported, but I
>> would also like to be able to go for raw throughput and have as many cores
>> as possible reading from a single queue (like I currently have).
>>
> Well, you could let the NIC firmware(f/w) handle this. The f/w would
> know which interrupt was just injected recently.In other words it
> would have a history of which CPU's would be available. So if some
> previously interrupted CPU isn't making good progress then the
> firmware should route the incoming response packets to a different
> queue. This way some other CPU will pick it up.
> 


It isn's a NIC.  There is no firmware.  The system interrupt hardware is 
what it is and cannot be changed.

My current implementation still has a single input queue configured and 
I get a maskable interrupt on a single CPU when packets are available. 
If the queue depth increases above a given threshold, I optionally send 
an IPI to another CPU to enable NAPI polling on that CPU.

Currently I have a module parameter that controls the maximum number of 
CPUs that will have NAPI polling enabled.

This allows me to get multiple CPUs doing receive processing without 
having to hack into the lower levels of the system's interrupt 
processing code to try to do interrupt steering.  Since all the 
interrupt service routine was doing was call netif_rx_schedule(), I can 
simply do this via smp_call_function_single().

David Daney
