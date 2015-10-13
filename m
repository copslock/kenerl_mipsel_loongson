Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2015 15:41:42 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:51046 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010039AbbJMNlkdyfLj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2015 15:41:40 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1Zlzpg-00083B-4v; Tue, 13 Oct 2015 15:41:36 +0200
Date:   Tue, 13 Oct 2015 15:40:59 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@imgtec.com>
cc:     linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, jiang.liu@linux.intel.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [RFC v2 PATCH 08/14] irq: implement irq_send_ipi
In-Reply-To: <1444731382-19313-9-git-send-email-qais.yousef@imgtec.com>
Message-ID: <alpine.DEB.2.11.1510131539010.25029@nanos>
References: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com> <1444731382-19313-9-git-send-email-qais.yousef@imgtec.com>
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
X-archive-position: 49521
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

Lacks kerneldoc

> +int __irq_desc_send_ipi(struct irq_desc *desc, const struct ipi_mask *dest)
> +{
> +	struct irq_data *data = irq_desc_get_irq_data(desc);
> +	struct irq_chip *chip = irq_data_get_irq_chip(data);
> +
> +	if (!chip || !chip->irq_send_ipi)
> +		return -EINVAL;
> +
> +	/*
> +	 * Do not validate the mask for IPIs marked global. These are
> +	 * regular IPIs so we can avoid the operation as their target
> +	 * mask is the cpu_possible_mask.
> +	 */
> +	if (!dest->global) {
> +		if (!bitmap_subset(dest->cpumask, data->ipi_mask.cpumask,
> +				   dest->nbits))
> +			return -EINVAL;
> +	}

This looks half thought out. You rely on the caller getting the global
bit right. There should be a sanity check for this versus
data->ipi_mask and also you need to validate nbits.

> +EXPORT_SYMBOL(irq_send_ipi);

EXPORT_SYMBOL_GPL please

Thanks,

	tglx
