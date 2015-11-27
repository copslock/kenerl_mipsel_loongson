Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Nov 2015 12:46:46 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55489 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010740AbbK0Lqo4KFW- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Nov 2015 12:46:44 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id AC38A98EB0FD3;
        Fri, 27 Nov 2015 11:46:36 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Fri, 27 Nov 2015 11:46:38 +0000
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 27 Nov
 2015 11:46:38 +0000
Subject: Re: [PATCH v2 09/19] genirq: Add a new function to get IPI reverse
 mapping
To:     <linux-kernel@vger.kernel.org>
References: <1448453217-3874-1-git-send-email-qais.yousef@imgtec.com>
 <1448453217-3874-10-git-send-email-qais.yousef@imgtec.com>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
From:   Qais Yousef <qais.yousef@imgtec.com>
Message-ID: <5658429D.3000105@imgtec.com>
Date:   Fri, 27 Nov 2015 11:46:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1448453217-3874-10-git-send-email-qais.yousef@imgtec.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50153
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

On 11/25/2015 12:06 PM, Qais Yousef wrote:
> +
> +/**
> + * ipi_get_hwirq - get the hwirq associated with an IPI to a cpu
> + * @irq: linux irq number
> + * @cpu: the cpu to find the revmap for
> + *
> + * When dealing with coprocessors IPI, we need to inform it of the hwirq it
> + * needs to use to receive and send IPIs. This function provides the revmap
> + * to get this info to pass on to coprocessor firmware.
> + *
> + * Returns hwirq value on success and INVALID_HWIRQ on failure.
> + */
> +irq_hw_number_t ipi_get_hwirq(unsigned int irq, unsigned int cpu)
> +{
> +	struct irq_data *data = irq_get_irq_data(irq);
> +	struct ipi_mask *ipimask = data ? irq_data_get_ipi_mask(data) : NULL;
> +	irq_hw_number_t hwirq;
> +
> +	if (!data || !ipimask)
> +		return INVALID_HWIRQ;
> +
> +	if (cpu > ipimask->nbits)
> +		return INVALID_HWIRQ;
> +
> +	if (!test_bit(cpu, ipimask->cpu_bitmap))
> +		return INVALID_HWIRQ;
> +
> +	if (irq_domain_is_ipi_per_cpu(data->domain)) {
> +		data = irq_get_irq_data(irq + cpu - ipimask->offset);
> +		hwirq = data ? irqd_to_hwirq(data) : INVALID_HWIRQ;
> +	} else {
> +		hwirq = irqd_to_hwirq(data) + cpu - ipimask->offset;
> +	}
> +
> +	return hwirq;
> +}
> +EXPORT_SYMBOL_GPL(ipi_get_hwirq);


While trying to get my remoteproc driver work with this I uncovered a 
problem with this approach.

mips-gic doesn't store the actual hwirq in the irq_data. It uses 
GIC_SHARED_TO_HWIRQ() and GIC_HWIRQ_TO_SHARED() to add and remove an offset.

I'll add a new chip function irq_get_raw_hwirq(struct irq_data *d) that 
will return the real hardware value of hwirq. If not defined, I'll 
revert back to using the irqd_to_hwirq().

Objections?

Thanks,
Qais
