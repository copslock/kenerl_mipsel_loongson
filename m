Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 18:19:05 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:39174 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493217AbZJMQTC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Oct 2009 18:19:02 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9DGKJrp028117;
	Tue, 13 Oct 2009 18:20:19 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9DGKIvi028114;
	Tue, 13 Oct 2009 18:20:18 +0200
Date:	Tue, 13 Oct 2009 18:20:18 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: Octeon: Use lockless interrupt controller
	operations when possible.
Message-ID: <20091013162018.GB27508@linux-mips.org>
References: <4AD4A1E9.1080309@caviumnetworks.com> <1255449149-22054-2-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1255449149-22054-2-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 13, 2009 at 08:52:29AM -0700, David Daney wrote:

> Some newer Octeon chips have registers that allow lockless operation
> of the interrupt controller.  Take advantage of them.

Good stuff.

> +/*
> + * Disable the irq on the all cores for chips that have the EN*_W1{S,C}
> + * registers.
> + */
> +static void octeon_irq_ciu0_disable_all_v2(unsigned int irq)
> +{
> +	u64 mask = 1ull << (irq - OCTEON_IRQ_WORKQ0);
> +	int index;
> +#ifdef CONFIG_SMP
> +	int cpu;
> +	for_each_online_cpu(cpu) {
> +		index = cpu_logical_map(cpu) * 2;
> +		cvmx_write_csr(CVMX_CIU_INTX_EN0_W1C(index), mask);
> +	}
> +#else
> +	index = cvmx_get_core_num() * 2;
> +	cvmx_write_csr(CVMX_CIU_INTX_EN0_W1C(index), mask);
> +#endif

This #ifdef should be unnecessary.  For NR_CPUS == 1 it is defined as

#define for_each_online_cpu(cpu)   for_each_cpu((cpu), cpu_online_mask)
And for NR_CPUS == 1:
#define for_each_cpu(cpu, mask)                 \
        for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)

Iow, the loop will go away for uniprocessor kernels.

Rest looks ok at a glance.

  Ralf
