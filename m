Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2015 18:17:56 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:42997 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012765AbbKPRRyldYs3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Nov 2015 18:17:54 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZyNPZ-0005QQ-F7; Mon, 16 Nov 2015 18:17:49 +0100
Date:   Mon, 16 Nov 2015 18:17:09 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@imgtec.com>
cc:     linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, jiang.liu@linux.intel.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 10/14] irqchip/mips-gic: Add a IPI hierarchy domain
In-Reply-To: <56407F3C.4060404@imgtec.com>
Message-ID: <alpine.DEB.2.11.1511161610070.3761@nanos>
References: <1446549181-31788-1-git-send-email-qais.yousef@imgtec.com> <1446549181-31788-11-git-send-email-qais.yousef@imgtec.com> <alpine.DEB.2.11.1511071323471.4032@nanos> <56407F3C.4060404@imgtec.com>
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
X-archive-position: 49943
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

On Mon, 9 Nov 2015, Qais Yousef wrote:
> On 11/07/2015 02:51 PM, Thomas Gleixner wrote:
> Generally it's hard to know whether a real device is connected to a hwirq or
> not. I am saving a patch where we get a set of free hwirqs from DT as only the
> SoC designer knows what hwirq are actually free and safe to use for IPI. I'll
> send this patch with the DT IPI changes or the rproc driver that I will be
> send once these changes are merged.
> 
> The current code assumes that the last 2 * NR_CPUs hwirqs are always free to
> use for Linux SMP.

So what you're saying is that you cannot rely on the last X hwirqs
being available for IPIs. That's insane and to my knowledge there is
no hardware out there which does not reserve a consecutive IPI space.

But nevertheless, lets look at the various (possible) requirements we
have:

1) IPI as per_cpu interrupts

   Single hwirq represented by a single irq descriptor

2) IPI with consecutive mapping space

   No extra mapping from virq base to target cpu required as its just
   linear. Everything can be handled via the base virq.

3) IPI with random mapping space

   Seperate mapping virq base to target cpu is required. The obvious
   place to store it are the irq descriptors. That needs a bit
   different machinery for ipi_send_mask(), but it's not rocket
   science.

> > That makes a lot of things simpler. You don't have to keep a mapping
> > of the hwirq to the target cpu. You just can use the base hwirq and
> > calculate the destination hwirq from there when sending an IPI
> > (general Linux ones). The coprocessor one will just be a natural
> > fallout.
> 
> Are you suggesting here to remove the whole new mapping API from the
> generic code or just that it's not necessary to use it in my case?

Err. I'm saying that you did not make use of hierarchical domains. You
just glued the IPI stuff sideways on the GIC.

We certainly want the generic code for managing the allocation etc.
 
> I'm confused here as well. Is this a complementary API or are you suggesting
> replacing the one this patch introduces?

Those are replacements. We just need to handle the random mapping case
if we really need it.
 
Thanks,

	tglx
