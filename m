Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2015 16:30:18 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10526 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009114AbbJMOaMpdZL6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2015 16:30:12 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3091A8FD89195;
        Tue, 13 Oct 2015 15:30:04 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 13 Oct 2015 15:30:06 +0100
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 13 Oct
 2015 15:30:05 +0100
Subject: Re: [RFC v2 PATCH 06/14] irq: add struct ipi_mapping and its helper
 functions
To:     Thomas Gleixner <tglx@linutronix.de>
References: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com>
 <1444731382-19313-7-git-send-email-qais.yousef@imgtec.com>
 <alpine.DEB.2.11.1510131527360.25029@nanos>
CC:     <linux-kernel@vger.kernel.org>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
From:   Qais Yousef <qais.yousef@imgtec.com>
Message-ID: <561D156D.1090403@imgtec.com>
Date:   Tue, 13 Oct 2015 15:30:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1510131527360.25029@nanos>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49526
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

On 10/13/2015 02:31 PM, Thomas Gleixner wrote:
> On Tue, 13 Oct 2015, Qais Yousef wrote:
>
> +
> +int irq_unmap_ipi(struct ipi_mapping *map,
> +		  unsigned int cpu, irq_hw_number_t *hwirq)
> +{
> +	if (cpu >= map->nr_cpus)
> +		return -EINVAL;
> +
> +	if (map->cpumap[cpu] == INVALID_HWIRQ)
> +		return -EINVAL;
> +
> +	if (hwirq)
> +		*hwirq = map->cpumap[cpu];
> Why do we store hwirq in unmap?

So that the irqchip driver can return the hwirq to its available IPI pool.

>
> All these new functions lack kerneldoc comments.

Apologies about the missing docs here and in other places.

Thanks,
Qais
