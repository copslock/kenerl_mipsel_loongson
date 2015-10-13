Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2015 15:38:14 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:51019 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010039AbbJMNiMeRQKj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2015 15:38:12 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZlzmJ-0007wj-1j; Tue, 13 Oct 2015 15:38:07 +0200
Date:   Tue, 13 Oct 2015 15:37:30 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@imgtec.com>
cc:     linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, jiang.liu@linux.intel.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [RFC v2 PATCH 07/14] irq: add a new generic IPI reservation code
 to irq core
In-Reply-To: <1444731382-19313-8-git-send-email-qais.yousef@imgtec.com>
Message-ID: <alpine.DEB.2.11.1510131531290.25029@nanos>
References: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com> <1444731382-19313-8-git-send-email-qais.yousef@imgtec.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49520
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
> +/**
> + * irq_reserve_ipi() - setup an IPI to destination cpumask
> + * @domain: IPI domain
> + * @dest: cpumask of cpus to receive the IPI
> + *
> + * Allocate a virq that can be used to send IPI to any CPU in dest mask.
> + *
> + * On success it'll return linux irq number and 0 on failure
> + */
> +unsigned int irq_reserve_ipi(struct irq_domain *domain,
> +			     const struct ipi_mask *dest)
> +{
> +	struct irq_data *data;
> +	int virq;
> +	unsigned int nr_irqs;

Please order them so:

+	struct irq_data *data;
+	unsigned int nr_irqs;
+	int virq;

Much simpler to read.

> +	if (domain == NULL)
> +		domain = irq_default_domain; /* need a separate ipi_default_domain? */

No tail comments please.

We should neither use irq_default_domain nor have an
ipi_default_domain.

> +
> +	if (domain == NULL) {
> +		pr_warn("Must provide a valid IPI domain!\n");
> +		return 0;
> +	}
> +
> +	if (!irq_domain_is_ipi(domain)) {
> +		pr_warn("Not an IPI domain!\n");
> +		return 0;
> +	}
> +
> +	/* always allocate a virq per cpu */
> +	nr_irqs = bitmap_weight(dest->cpumask, dest->nbits);;

Double semicolon

> +
> +	virq = irq_domain_alloc_descs(-1, nr_irqs, 0, NUMA_NO_NODE);
> +	if (virq <= 0) {
> +		pr_warn("Can't reserve IPI, failed to alloc descs\n");
> +		return 0;
> +	}
> +
> +	/* we are reusing hierarchy alloc function, should we create another one? */
> +	virq = __irq_domain_alloc_irqs(domain, virq, nr_irqs, NUMA_NO_NODE,
> +					(void *) dest, true);
> +	if (virq <= 0) {
> +		pr_warn("Can't reserve IPI, failed to alloc irqs\n");
> +		goto free_descs;
> +	}
> +
> +	data = irq_get_irq_data(virq);
> +	bitmap_copy(data->ipi_mask.cpumask, dest->cpumask, dest->nbits);
> +	data->ipi_mask.nbits = dest->nbits;

This does only initialize the first virq data. What about the others?

> +	return virq;
> +
> +free_descs:
> +	irq_free_descs(virq, nr_irqs);
> +	return 0;
> +}
> +
> +/**
> + * irq_destroy_ipi() - unreserve an IPI that was previously allocated
> + * @irq: linux irq number to be destroyed
> + *
> + * Return an IPI allocated with irq_reserve_ipi() to the system.

That wants to explain that it actually destroys a number of virqs not
just the primary one.

Thanks,

	tglx
