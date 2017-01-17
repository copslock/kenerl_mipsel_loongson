Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2017 09:38:17 +0100 (CET)
Received: from Galois.linutronix.de ([IPv6:2a01:7a0:2:106d:700::1]:37568 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992227AbdAQIiKCV19l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2017 09:38:10 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1cTPH3-0001VZ-IN; Tue, 17 Jan 2017 09:37:49 +0100
Date:   Tue, 17 Jan 2017 09:38:03 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arvind Yadav <arvind.yadav.cs@gmail.com>
cc:     Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH v2] irqchip: irq-mips-gic:- Avoiding Kernel panics due
 to Error.
In-Reply-To: <1484546822-10199-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <alpine.DEB.2.20.1701170936410.3495@nanos>
References: <1484546822-10199-1-git-send-email-arvind.yadav.cs@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56338
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

On Mon, 16 Jan 2017, Arvind Yadav wrote:

Cc'ing the MIPS folks.

> Eliminating kernel panic due to NULL pointer dereferencing and
> other failure in __gic_init.
> Here, __gic_init can fail. This error check will avoid NULL pointer
> dereference and kernel panic.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/irqchip/irq-mips-gic.c | 40 +++++++++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
> index c01c09e..bf0816f 100644
> --- a/drivers/irqchip/irq-mips-gic.c
> +++ b/drivers/irqchip/irq-mips-gic.c
> @@ -968,7 +968,7 @@ int gic_ipi_domain_match(struct irq_domain *d, struct device_node *node,
>  	.match = gic_ipi_domain_match,
>  };
>  
> -static void __init __gic_init(unsigned long gic_base_addr,
> +static int  __init __gic_init(unsigned long gic_base_addr,
>  			      unsigned long gic_addrspace_size,
>  			      unsigned int cpu_vec, unsigned int irqbase,
>  			      struct device_node *node)
> @@ -979,6 +979,10 @@ static void __init __gic_init(unsigned long gic_base_addr,
>  	__gic_base_addr = gic_base_addr;
>  
>  	gic_base = ioremap_nocache(gic_base_addr, gic_addrspace_size);
> +	if (!gic_base) {
> +		pr_err("Failed to map GIC memory");
> +		return -ENOMEM;
> +	}
>  
>  	gicconfig = gic_read(GIC_REG(SHARED, GIC_SH_CONFIG));
>  	gic_shared_intrs = (gicconfig & GIC_SH_CONFIG_NUMINTRS_MSK) >>
> @@ -1035,23 +1039,29 @@ static void __init __gic_init(unsigned long gic_base_addr,
>  	gic_irq_domain = irq_domain_add_simple(node, GIC_NUM_LOCAL_INTRS +
>  					       gic_shared_intrs, irqbase,
>  					       &gic_irq_domain_ops, NULL);
> -	if (!gic_irq_domain)
> -		panic("Failed to add GIC IRQ domain");
> +	if (!gic_irq_domain) {
> +		pr_err("Failed to add GIC IRQ domain");
> +		goto iounmap;
> +	}
>  	gic_irq_domain->name = "mips-gic-irq";
>  
>  	gic_dev_domain = irq_domain_add_hierarchy(gic_irq_domain, 0,
>  						  GIC_NUM_LOCAL_INTRS + gic_shared_intrs,
>  						  node, &gic_dev_domain_ops, NULL);
> -	if (!gic_dev_domain)
> -		panic("Failed to add GIC DEV domain");
> +	if (!gic_dev_domain) {
> +		pr_err("Failed to add GIC DEV domain");
> +		goto iounmap;
> +	}
>  	gic_dev_domain->name = "mips-gic-dev";
>  
>  	gic_ipi_domain = irq_domain_add_hierarchy(gic_irq_domain,
>  						  IRQ_DOMAIN_FLAG_IPI_PER_CPU,
>  						  GIC_NUM_LOCAL_INTRS + gic_shared_intrs,
>  						  node, &gic_ipi_domain_ops, NULL);
> -	if (!gic_ipi_domain)
> -		panic("Failed to add GIC IPI domain");
> +	if (!gic_ipi_domain) {
> +		pr_err("Failed to add GIC IPI domain");
> +		goto iounmap;
> +	}
>  
>  	gic_ipi_domain->name = "mips-gic-ipi";
>  	gic_ipi_domain->bus_token = DOMAIN_BUS_IPI;
> @@ -1067,13 +1077,22 @@ static void __init __gic_init(unsigned long gic_base_addr,
>  	}
>  
>  	gic_basic_init();
> +	return 0;
> +iounmap:
> +	iounmap(gic_base);
> +	return -ENOMEM;
>  }
>  
>  void __init gic_init(unsigned long gic_base_addr,
>  		     unsigned long gic_addrspace_size,
>  		     unsigned int cpu_vec, unsigned int irqbase)
>  {
> -	__gic_init(gic_base_addr, gic_addrspace_size, cpu_vec, irqbase, NULL);
> +	int ret;
> +
> +	ret = __gic_init(gic_base_addr, gic_addrspace_size, cpu_vec, irqbase,
> +			 NULL);
> +	if (ret)
> +		pr_err("Failed to initialize GIC");
>  }
>  
>  static int __init gic_of_init(struct device_node *node,
> @@ -1083,6 +1102,7 @@ static int __init gic_of_init(struct device_node *node,
>  	unsigned int cpu_vec, i = 0, reserved = 0;
>  	phys_addr_t gic_base;
>  	size_t gic_len;
> +	int ret;
>  
>  	/* Find the first available CPU vector. */
>  	while (!of_property_read_u32_index(node, "mti,reserved-cpu-vectors",
> @@ -1119,7 +1139,9 @@ static int __init gic_of_init(struct device_node *node,
>  		write_gcr_gic_base(gic_base | CM_GCR_GIC_BASE_GICEN_MSK);
>  	gic_present = true;
>  
> -	__gic_init(gic_base, gic_len, cpu_vec, 0, node);
> +	ret = __gic_init(gic_base, gic_len, cpu_vec, 0, node);
> +	if (ret)
> +		return ret;
>  
>  	return 0;
>  }
> -- 
> 1.9.1
> 
> 
