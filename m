Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Sep 2015 10:27:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59562 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007433AbbIXI1ESpRvt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Sep 2015 10:27:04 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8AF817359A1DA;
        Thu, 24 Sep 2015 09:26:56 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 24 Sep 2015 09:26:58 +0100
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 24 Sep
 2015 09:26:57 +0100
Subject: Re: [PATCH 4/6] irq: add a new generic IPI handling code to irq core
To:     Jiang Liu <jiang.liu@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>
References: <1443019758-20620-1-git-send-email-qais.yousef@imgtec.com>
 <1443019758-20620-5-git-send-email-qais.yousef@imgtec.com>
 <5602D863.4040503@linux.intel.com>
CC:     <marc.zyngier@arm.com>, <jason@lakedaemon.net>,
        <linux-mips@linux-mips.org>
From:   Qais Yousef <qais.yousef@imgtec.com>
Message-ID: <5603B3D1.3000405@imgtec.com>
Date:   Thu, 24 Sep 2015 09:26:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <5602D863.4040503@linux.intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49355
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

On 09/23/2015 05:50 PM, Jiang Liu wrote:
> On 2015/9/23 22:49, Qais Yousef wrote:
>>   
>> +/**
>> + * irq_reserve_ipi() - setup an IPI to destination cpumask
>> + * @domain: IPI domain
>> + * @dest: cpumask of cpus to receive the IPI
>> + * @devid: devid that requested the reservation
>> + *
>> + * Allocate a virq that can be used to send IPI to any CPU in dest mask.
>> + *
>> + * On success it'll return linux irq number and 0 on failure
>> + */
>> +unsigned int irq_reserve_ipi(struct irq_domain *domain,
>> +			     const struct cpumask *dest, void *devid)
> Hi Qais,
> 	I have caught the idea why we need "dest" here. Per my
> understanding, IPI could be sent to any active CPUs and the target
> CPUs are specified when calling send_ipi(). What's the benefit or
> usage to use "dest" to define a possible target scope here? And
> how cpu hotplug?
> Thanks!
> Gerry
>


The CPUs we want to send the IPI to are not Linux CPUs only. My use case 
is about sending IPI to audio coprocessor.
So "dest" doesn't have to be part of Linux online CPUs, hence we need to 
specify it so that the underlying controller will know how to map to 
that CPU. I should have put more info in the cover letter, not just the 
link to the discussion, apologies for that.

I'm not sure about cpu hotplug. We could call irq_destroy_ipi() when a 
cpu is hot unplugged, but the current behaviour is to statically reserve 
the IPI and keep them reserved. I think it makes sense to keep it this 
way for SMP IPIs or things will get complicated.

For a coprocessor, if we the 'module is unloaded', I'd expect the 
irq_destroy_ipi() to be called returning the reserved IPI to the pool.

Makes sense?

Thanks,
Qais
