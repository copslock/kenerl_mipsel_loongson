Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Sep 2015 10:39:51 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52091 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007433AbbIXIjq0gwXt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Sep 2015 10:39:46 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id EE84C891574CB;
        Thu, 24 Sep 2015 09:39:36 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 24 Sep 2015 09:39:38 +0100
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 24 Sep
 2015 09:39:38 +0100
Subject: Re: [PATCH 0/6] Implement generic IPI support mechanism
To:     Jiang Liu <jiang.liu@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>
References: <1443019758-20620-1-git-send-email-qais.yousef@imgtec.com>
 <5602D958.6000003@linux.intel.com>
CC:     <marc.zyngier@arm.com>, <jason@lakedaemon.net>,
        <linux-mips@linux-mips.org>
From:   Qais Yousef <qais.yousef@imgtec.com>
Message-ID: <5603B6CA.7050601@imgtec.com>
Date:   Thu, 24 Sep 2015 09:39:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <5602D958.6000003@linux.intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qais.yousef@imgtec.com
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

On 09/23/2015 05:54 PM, Jiang Liu wrote:
> On 2015/9/23 22:49, Qais Yousef wrote:
>> This RFC series attempts to implement a generic IPI layer for reserving and sending IPI.
>>
>> It is based on the discussion in this link
>>
>> 	https://lkml.org/lkml/2015/8/26/713
>>
>> This series deals with points #1 and #2 only. Since I'm not the irq expert, I'm hoping this
>> series will give me early feedback and drive the discussion further about any potential
>> tricky points.
>>
>> I tried to keep changes clean and small, but since this is just an RFC I might have missed
>> few things.
>>
>> Thomas I hope I didn't stray far from what you had in mind :-)
>>
>> My only testing so far is having SMP linux booting.
> Hi Qais,
> 	Thanks for doing this, but the change is a little bigger than
> my expectation. Could we achieve this by:
> 1) extend irq_chip to support send_ipi operation
> 2) reuse existing irqdomain allocation interfaces to allocate IPI IRQ
> 3) arch code to create an IPI domain for IPI allocations
> 4) IRQ core provides some helpers to help arch code to implement IPI
>     irqdomain
> 	I think that may make the change smaller and more clear.
> Thanks!
> Gerry
>
>


Can you be more specific about 2 please? I tried to reuse the hierarchy 
irqdomain alloc function. One major difference when allocating IPI than 
a normal irq is that it's dynamic. The caller doesn't know what hwirq 
number it needs. It actually shouldn't.

The idea is for the user to just say 'I want an IPI to a CPUAFFINITY' 
from DT and get a virq in return to send an IPI to the target CPU(s). 
Also I think we need to accommodate the possibility of having more than 
1 IPI controller.

Can you provide more pointers please?

Thanks,
Qais
