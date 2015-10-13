Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2015 15:27:36 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:50957 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010039AbbJMN1exdZhj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2015 15:27:34 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1Zlzc0-0007jW-KS; Tue, 13 Oct 2015 15:27:28 +0200
Date:   Tue, 13 Oct 2015 15:26:52 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@imgtec.com>
cc:     linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, jiang.liu@linux.intel.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [RFC v2 PATCH 03/14] irq: add new struct ipi_mask
In-Reply-To: <1444731382-19313-4-git-send-email-qais.yousef@imgtec.com>
Message-ID: <alpine.DEB.2.11.1510131517080.25029@nanos>
References: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com> <1444731382-19313-4-git-send-email-qais.yousef@imgtec.com>
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
X-archive-position: 49518
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
> cpumask is limited to NR_CPUS. introduce ipi_mask which allows us to address
> cpu range that is higher than NR_CPUS which is required for drivers to send
> IPIs for coprocessor that are outside Linux CPU range.
> 
> Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
> ---
>  include/linux/irq.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index 11bf09288ddb..4b537e4d393b 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -125,6 +125,21 @@ enum {
>  struct msi_desc;
>  struct irq_domain;
>  
> + /**
> + * struct ipi_mask - IPI mask information
> + * @cpumask: bitmap of cpumasks
> + * @nbits: number of bits in cpumask
> + * @global: whether the mask is SMP IPI ie: subset of cpu_possible_mask or not
> + *
> + * ipi_mask is similar to cpumask, but it provides nbits that's configurable
> + * rather than fixed to NR_CPUS.
> + */
> +struct ipi_mask {
> +	unsigned long	*cpumask;
> +	unsigned int	nbits;
> +	bool		global;
> +};

Can you make that:

struct ipi_mask {
	unsigned int	nbits;
	bool		global;
	unsigned long	cpu_bitmap[];
};

That allows you to allocate the data structure in one go. So the
ipi_mask in irq_data_common becomes a pointer which is only filled in
when ipi_mask is actually used.

Note, I renamed cpumask to cpu_bitmap to avoid confusion with
cpumasks.

We also want a helper function

   struct cpumask *irq_data_get_ipi_mask(struct irq_data *data);

so we can use normal cpumask operations for the majority of cases.

Thanks,

	tglx
