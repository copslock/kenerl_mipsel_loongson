Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Aug 2015 23:41:13 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:58553 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007623AbbHZVlLkPpq- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Aug 2015 23:41:11 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZUiRL-0005yK-7y; Wed, 26 Aug 2015 23:41:03 +0200
Date:   Wed, 26 Aug 2015 23:40:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@imgtec.com>
cc:     Marc Zyngier <marc.zyngier@arm.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export gic_send_ipi
In-Reply-To: <55DDDE3C.8030609@imgtec.com>
Message-ID: <alpine.DEB.2.11.1508262101450.15006@nanos>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com> <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com> <alpine.DEB.2.11.1508241447100.3873@nanos> <55DB15EB.3090109@imgtec.com> <55DB1CD2.5030300@arm.com> <55DB29B5.3010202@imgtec.com>
 <alpine.DEB.2.11.1508241656280.3873@nanos> <55DB48C9.7010508@imgtec.com> <55DB519D.2090203@arm.com> <55DDA1C4.4070301@imgtec.com> <alpine.DEB.2.11.1508261427280.15006@nanos> <55DDD3E3.7070009@imgtec.com> <alpine.DEB.2.11.1508261701430.15006@nanos>
 <55DDDE3C.8030609@imgtec.com>
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
X-archive-position: 49036
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

On Wed, 26 Aug 2015, Qais Yousef wrote:
> On 08/26/2015 04:08 PM, Thomas Gleixner wrote:
> > IPI = Inter Processor Interrupt
> > 
> > As the name says that's an interrupt which goes from one cpu to
> > another. So an IPI has a very clear target.
> 
> OK understood. My interpretation of the processor here was the difference. I
> was viewing the whole linux cpus as one unit with regard to its coprocessors.

You can only view it this way if you talk about peripheral interrupts
which are not used as per cpu interrupts and can be routed to a single
cpu or a set of cpus via set_affinity.

> > Whether the platform implements IPIs via general interrupts which are
> > made affine to a particular cpu or some other specialized mechanism is
> > completely irrelevant. An IPI is not subject to affinity settings,
> > period.
> > 
> > So if you want to use an IPI then you need a target cpu for that IPI.
> > 
> > If you want something which can be affined to any cpu, then you need a
> > general interrupt and not an IPI.
> 
> We are using IPIs to exchange interrupts. Affinity is not important to me.

That's a bold statement. If you chose CPU x as the target for the
interrupts received from the coprocessor, then you have pinned the
processing for this stuff on to CPU x. So you limit the freedom of
moving stuff around on the linux cpus.

And if your root irq controller supports sending normal device
interrupts in the same or a similar way as it sends IPIs you can spare
quite some extra handling on the linux side for receiving the
coprocessor interrupt, i.e. you can use just the bog standard
request_irq() mechanism and have the ability to set the affinity of
that interrupt from user space so you can move it to the core on which
your processing happens. Definitely simpler and more flexible, so I
would go there if the hardware allows.

But back to the IPIs. We need infrastructure and DT support to:

1) reserve an IPI

2) send an IPI

3) request/free an IPI

#1 We have no infrastructure for that, but we definitely need one.

   We can look at the IPI as a single linux irq number which is
   replicated on all cpu cores. The replication can happen in hardware
   or by software, but that depends on the underlying root irq
   controller. How that is implemented does not matter for the
   reservation.

   The most flexible and platform independent solution would be to
   describe the IPI space as a seperate irq domain. In most cases this
   would be a hierarchical domain stacked on the root irq domain:

   [IPI-domain] --> [GIC-MIPS-domain]

   on x86 this would be:

   [IPI-domain] --> [vector-domain]

   That needs some change how the IPIs which are used by the kernel
   (rescheduling, function call ..) are set up, but we get a proper
   management and collision avoidance that way. Depending on the
   platform we could actually remove the whole IPI compile time
   reservation and hand out IPIs at boot time on demand and
   dynamically.

   So the reservation function would be something like:

   unsigned int irq_reserve_ipi(const struct cpumask *dest, void *devid);

   @dest contains the possible targets for the IPI. So for generic
   linux IPIs this would be cpu_possible_mask. For your coprocessor
   the target would be a cpumask with just the bit of the coprocessor
   core set. If you need to use an IPI for sending an interrupt from
   the coprocessor to a specific linux core then @dest will contain
   just that target cpu.

   @devid is stored in the IPI domain for sanity checks during
   operation.

   The function returns a linux irq number or 0 if allocation fails.

   We need a complementary interface as well, so you can hand back the
   IPI to the core when the coprocessor is disabled:

   void irq_destroy_ipi(unsigned int irq, void *devid);


   To configure your coprocessor proper, we need a translation
   mechanism from the linux interrupt number to the magic value which
   needs to be written into the trigger register when the coprocessor
   wants to send an interrupt or an IPI.

   int irq_get_irq_hwcfg(unsigned int irq, struct irq_hwcfg *cfg);

   struct irq_hwcfg needs to be defined, but it might look like this:

     {
	/* Generic fields */
	x;
	...
	union {
	      mips_gic;
	      ...
	};
     };

   The actual hw specific value(s) need to be filled in from the irq
   domain specific code.


#2 We have no generic mechanism for that either.

   Something like this is needed:

   void irq_send_ipi(unsigned int irq, const struct cpumask *dest,
   		     void *devid);	      

   @dest is for generic linux IPIs and can be NULL so the IPI is sent to
    	 the core(s) which have been handed in at reservation time

   @devid is used to sanity check the driver call.

   So that finally will call down via a irq chip callback into the
   code which sends the IPI.


#3 Now you get lucky, because we actually have an interface for this

   request_percpu_irq()
   free_percpu_irq()
   disable_percpu_irq()
   enable_percpu_irq()

   Though there is a caveat. enable/disable_percpu_irq() must be
   called from the target cpu, but that should be a solvable problem.

   And at the IPI-domain side we need sanity checks whether the cpu
   from which enable/disable is called is actually configured in the
   reservation mask.
   
   There are a few other nasty details, but that's not important for
   the big picture.

   As I said above, I really would recommend to avoid that if possible
   because a bog standard device interrupt is way simpler to deal
   with. 

That's certainly not the quick and dirty solution you are looking for,
but exposing IPIs to drivers by anything else than a well thought out
infrastructure is not going to happen.

Thanks,

	tglx
