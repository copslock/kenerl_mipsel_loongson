Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2015 16:38:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45303 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009454AbbJMOi4Rn7c6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2015 16:38:56 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0CE14D080501A;
        Tue, 13 Oct 2015 15:38:48 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 13 Oct 2015 15:38:50 +0100
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 13 Oct
 2015 15:38:49 +0100
Subject: Re: [RFC v2 PATCH 07/14] irq: add a new generic IPI reservation code
 to irq core
To:     Thomas Gleixner <tglx@linutronix.de>
References: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com>
 <1444731382-19313-8-git-send-email-qais.yousef@imgtec.com>
 <alpine.DEB.2.11.1510131531290.25029@nanos>
CC:     <linux-kernel@vger.kernel.org>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
From:   Qais Yousef <qais.yousef@imgtec.com>
Message-ID: <561D1779.7060307@imgtec.com>
Date:   Tue, 13 Oct 2015 15:38:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1510131531290.25029@nanos>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49527
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

On 10/13/2015 02:37 PM, Thomas Gleixner wrote:
> On Tue, 13 Oct 2015, Qais Yousef wrote:
>
>> +	if (domain == NULL)
>> +		domain = irq_default_domain; /* need a separate ipi_default_domain? */
> No tail comments please.
>
> We should neither use irq_default_domain nor have an
> ipi_default_domain.

OK though I understood that you were OK with using the irq_default_domain.

This means that arch code must parse the DT for an IPI domain. I think 
I've seen arch code using the root FDT to search for a specific node. 
I'll try to do something similar to search for an IPI domain.

>> +
>> +	virq = irq_domain_alloc_descs(-1, nr_irqs, 0, NUMA_NO_NODE);
>> +	if (virq <= 0) {
>> +		pr_warn("Can't reserve IPI, failed to alloc descs\n");
>> +		return 0;
>> +	}
>> +
>> +	/* we are reusing hierarchy alloc function, should we create another one? */
>> +	virq = __irq_domain_alloc_irqs(domain, virq, nr_irqs, NUMA_NO_NODE,
>> +					(void *) dest, true);
>> +	if (virq <= 0) {
>> +		pr_warn("Can't reserve IPI, failed to alloc irqs\n");
>> +		goto free_descs;
>> +	}
>> +
>> +	data = irq_get_irq_data(virq);
>> +	bitmap_copy(data->ipi_mask.cpumask, dest->cpumask, dest->nbits);
>> +	data->ipi_mask.nbits = dest->nbits;
> This does only initialize the first virq data. What about the others?

Right I missed that. I'll fix it.


>
>> +	return virq;
>> +
>> +free_descs:
>> +	irq_free_descs(virq, nr_irqs);
>> +	return 0;
>> +}
>> +
>> +/**
>> + * irq_destroy_ipi() - unreserve an IPI that was previously allocated
>> + * @irq: linux irq number to be destroyed
>> + *
>> + * Return an IPI allocated with irq_reserve_ipi() to the system.
> That wants to explain that it actually destroys a number of virqs not
> just the primary one.
>
>

OK I'll expand on that.

Thanks,
Qais
