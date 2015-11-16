Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2015 18:24:49 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:43033 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012783AbbKPRYrkwHvv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Nov 2015 18:24:47 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZyNWF-0005Uu-26; Mon, 16 Nov 2015 18:24:43 +0100
Date:   Mon, 16 Nov 2015 18:24:03 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@imgtec.com>
cc:     linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, jiang.liu@linux.intel.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 10/14] irqchip/mips-gic: Add a IPI hierarchy domain
In-Reply-To: <5644AC66.2070508@imgtec.com>
Message-ID: <alpine.DEB.2.11.1511161817400.3761@nanos>
References: <1446549181-31788-1-git-send-email-qais.yousef@imgtec.com> <1446549181-31788-11-git-send-email-qais.yousef@imgtec.com> <alpine.DEB.2.11.1511071323471.4032@nanos> <5644AC66.2070508@imgtec.com>
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
X-archive-position: 49944
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

On Thu, 12 Nov 2015, Qais Yousef wrote:
> Issues I'm seeing:
> 
>     - Device domain would be identical to GIC domain and it would defer
> everything to the parent domain except for the extra level of indirection. No?
 
It's not identical. It's a subset of the GIC domain and it has
different semantics than the IPI domain.

>     - The race condition I mentioned in my earlier email where we must be told
> what hwirqs are available because we can't guarantee there's no real device
> connected to it which could interfere with the operation. We have always to
> work on a pre reserved set defined by the system. Currently GIC hard codes
> this set, but I'll be making it a DT property in the future.

We do that better now as we really don't want to start over when it
turns out that the DT property imposes other issues on it.
 
>     - If we remove the mapping, how can a coprocessor drivers find out the
> reverse mapping to pass the hwirq to the firmware so that it can send and
> listen on the correct hwirqs? I have to say my current patches missed dealing
> with this problem. Now I have something to test my rproc driver on I came to
> realise I haven't added the function to do the reverse mapping.

int ipi_get_hw_irq(int irq)
{
	struct irq_data *d = irq_get_irq_data(irq);
	return d ? irqd_to_hwirq(d);
}
 
Hmm?

Thanks,

	tglx
