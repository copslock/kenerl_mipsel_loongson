Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2015 15:31:53 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:50988 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010039AbbJMNbuqMMSj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2015 15:31:50 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1Zlzg9-0007nT-9e; Tue, 13 Oct 2015 15:31:45 +0200
Date:   Tue, 13 Oct 2015 15:31:09 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@imgtec.com>
cc:     linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, jiang.liu@linux.intel.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [RFC v2 PATCH 06/14] irq: add struct ipi_mapping and its helper
 functions
In-Reply-To: <1444731382-19313-7-git-send-email-qais.yousef@imgtec.com>
Message-ID: <alpine.DEB.2.11.1510131527360.25029@nanos>
References: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com> <1444731382-19313-7-git-send-email-qais.yousef@imgtec.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001,URIBL_BLOCKED=0.001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

On Tue, 13 Oct 2015, Qais Yousef wrote:

> struct ipi_mapping will provide a mechanism for irqdomain/architure
> code to fill out the mapping for the generic code later to implement
> generic IPI reserve and send functions.
> 
> Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
> ---
>  include/linux/irq.h | 21 +++++++++++++++++++
>  kernel/irq/manage.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+)
> 
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index b000b217ea24..c3d0f26c3eff 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -964,4 +964,25 @@ static inline u32 irq_reg_readl(struct irq_chip_generic *gc,
>  		return readl(gc->reg_base + reg_offset);
>  }
>  
> +#define INVALID_HWIRQ	-1
> +
> +/**
> + * struct ipi_mapping - IPI mapping information object
> + * @nr_hwirqs: number of hwirqs mapped
> + * @nr_cpus: number of cpus the controller can talk to
> + * @cpumap: per cpu hwirq mapping table
> + */
> +struct ipi_mapping {
> +	unsigned int nr_hwirqs;
> +	unsigned int nr_cpus;
> +	unsigned int *cpumap;
> +};

Again, you can avoid seperate allocations and pointer indirections by
s/*cpumap/cpumap[]/
      
> +struct ipi_mapping *irq_alloc_ipi_mapping(unsigned int nr_cpus)
> +{
> +	struct ipi_mapping *map;
> +	int i;
> +
> +	map = kzalloc(sizeof(struct ipi_mapping), GFP_KERNEL);
> +	if (!map)
> +		return NULL;
> +
> +	map->nr_cpus = nr_cpus;
> +
> +	map->cpumap = kmalloc(sizeof(irq_hw_number_t) * nr_cpus, GFP_KERNEL);
> +	if (!map->cpumap) {
> +		kfree(map);
> +		return NULL;
> +	}
> +	for (i = 0; i < nr_cpus; i++)
> +		map->cpumap[i] = INVALID_HWIRQ;

memset please

> +
> +	return map;
> +}
> +
> +void irq_free_ipi_mapping(struct ipi_mapping *map)
> +{
> +	kfree(map->cpumap);
> +	kfree(map);
> +}
> +
> +int irq_map_ipi(struct ipi_mapping *map,
> +		unsigned int cpu, irq_hw_number_t hwirq)
> +{
> +	if (cpu >= map->nr_cpus)
> +		return -EINVAL;
> +
> +	map->cpumap[cpu] = hwirq;
> +	map->nr_hwirqs++;
> +
> +	return 0;
> +}
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

Why do we store hwirq in unmap?

All these new functions lack kerneldoc comments.

Thanks,

	tglx
