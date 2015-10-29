Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2015 11:39:56 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14085 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007280AbbJ2KjzO71id (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Oct 2015 11:39:55 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id CF03ABAA2E70A;
        Thu, 29 Oct 2015 10:39:43 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Thu, 29 Oct 2015 10:39:45 +0000
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 29 Oct
 2015 10:39:44 +0000
Subject: Re: [RFC v2 PATCH 07/14] irq: add a new generic IPI reservation code
 to irq core
To:     Thomas Gleixner <tglx@linutronix.de>
References: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com>
 <1444731382-19313-8-git-send-email-qais.yousef@imgtec.com>
 <alpine.DEB.2.11.1510131531290.25029@nanos> <561D1779.7060307@imgtec.com>
 <5630EDC2.10505@imgtec.com>
CC:     <linux-kernel@vger.kernel.org>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
From:   Qais Yousef <qais.yousef@imgtec.com>
Message-ID: <5631F770.3040702@imgtec.com>
Date:   Thu, 29 Oct 2015 10:39:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <5630EDC2.10505@imgtec.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49762
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

On 10/28/2015 03:46 PM, Qais Yousef wrote:
> Hi Thomas,
>
> On 10/13/2015 03:38 PM, Qais Yousef wrote:
>> On 10/13/2015 02:37 PM, Thomas Gleixner wrote:
>>> On Tue, 13 Oct 2015, Qais Yousef wrote:
>>>
>>>> +    if (domain == NULL)
>>>> +        domain = irq_default_domain; /* need a separate 
>>>> ipi_default_domain? */
>>> No tail comments please.
>>>
>>> We should neither use irq_default_domain nor have an
>>> ipi_default_domain.
>>
>> OK though I understood that you were OK with using the 
>> irq_default_domain.
>>
>> This means that arch code must parse the DT for an IPI domain. I 
>> think I've seen arch code using the root FDT to search for a specific 
>> node. I'll try to do something similar to search for an IPI domain.
>
> I'm having an issue here. I made the arch code look for an IPI domain 
> but we have some platforms on MIPS that don't support device tree. I 
> can't find how I can go away with that without using irq_default_domain.
>
> Also irq_default_domain is understandably only visible within 
> irqdomain code, so I can't make the arch code fallback to passing 
> irq_default_domain if the platform doesn't support DT.
>
> Are you OK with keeping this in irq_reserve_ipi()? Alternatively I 
> could modify irq_find_host(), which I'm using to find the IPI domain, 
> return irq_default_domain() if the passed node is NULL.
>
> Or maybe there's a better option I couldn't think of?

I think I can fix this in the GIC driver by using my own 
irq_domain->ops->match() function to ignore when of_node is NULL to cope 
with platforms without DT.

Sorry for the noise.

Thanks,
Qais
