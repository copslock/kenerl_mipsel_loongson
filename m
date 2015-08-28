Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Aug 2015 12:38:45 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63736 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013265AbbH1Kim6CUue (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Aug 2015 12:38:42 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id CAD128DCEBF18;
        Fri, 28 Aug 2015 11:38:33 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 28 Aug 2015 11:38:35 +0100
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 28 Aug
 2015 11:38:35 +0100
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export gic_send_ipi
To:     Thomas Gleixner <tglx@linutronix.de>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
 <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com>
 <alpine.DEB.2.11.1508241447100.3873@nanos> <55DB15EB.3090109@imgtec.com>
 <55DB1CD2.5030300@arm.com> <55DB29B5.3010202@imgtec.com>
 <alpine.DEB.2.11.1508241656280.3873@nanos> <55DB48C9.7010508@imgtec.com>
 <55DB519D.2090203@arm.com> <55DDA1C4.4070301@imgtec.com>
 <alpine.DEB.2.11.1508261427280.15006@nanos> <55DDD3E3.7070009@imgtec.com>
 <alpine.DEB.2.11.1508261701430.15006@nanos> <55DDDE3C.8030609@imgtec.com>
 <alpine.DEB.2.11.1508262101450.15006@nanos>
CC:     Marc Zyngier <marc.zyngier@arm.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Lisa Parratt <Lisa.Parratt@imgtec.com>
From:   Qais Yousef <qais.yousef@imgtec.com>
Message-ID: <55E03A2B.3070805@imgtec.com>
Date:   Fri, 28 Aug 2015 11:38:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1508262101450.15006@nanos>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49062
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

On 08/26/2015 10:40 PM, Thomas Gleixner wrote:
> On Wed, 26 Aug 2015, Qais Yousef wrote:
>> On 08/26/2015 04:08 PM, Thomas Gleixner wrote:
>>> IPI = Inter Processor Interrupt
>>>
>>> As the name says that's an interrupt which goes from one cpu to
>>> another. So an IPI has a very clear target.
>> OK understood. My interpretation of the processor here was the difference. I
>> was viewing the whole linux cpus as one unit with regard to its coprocessors.
> You can only view it this way if you talk about peripheral interrupts
> which are not used as per cpu interrupts and can be routed to a single
> cpu or a set of cpus via set_affinity.
>
>>> Whether the platform implements IPIs via general interrupts which are
>>> made affine to a particular cpu or some other specialized mechanism is
>>> completely irrelevant. An IPI is not subject to affinity settings,
>>> period.
>>>
>>> So if you want to use an IPI then you need a target cpu for that IPI.
>>>
>>> If you want something which can be affined to any cpu, then you need a
>>> general interrupt and not an IPI.
>> We are using IPIs to exchange interrupts. Affinity is not important to me.
> That's a bold statement. If you chose CPU x as the target for the
> interrupts received from the coprocessor, then you have pinned the
> processing for this stuff on to CPU x. So you limit the freedom of
> moving stuff around on the linux cpus.

I said that because I thought you were telling me if I'm expecting my 
IPIs to be movable then I must be using general interrupts. So what I 
was saying is that we use IPIs and if it's against the rule for them to 
have affinity we can live with that.

>
> And if your root irq controller supports sending normal device
> interrupts in the same or a similar way as it sends IPIs you can spare
> quite some extra handling on the linux side for receiving the
> coprocessor interrupt, i.e. you can use just the bog standard
> request_irq() mechanism and have the ability to set the affinity of
> that interrupt from user space so you can move it to the core on which
> your processing happens. Definitely simpler and more flexible, so I
> would go there if the hardware allows.

That's what I was trying to say but words failed me to explain it 
clearly maybe :(

>
> But back to the IPIs. We need infrastructure and DT support to:
>
> 1) reserve an IPI
>
> 2) send an IPI
>
> 3) request/free an IPI
>
> #1 We have no infrastructure for that, but we definitely need one.
>
>     We can look at the IPI as a single linux irq number which is
>     replicated on all cpu cores. The replication can happen in hardware
>     or by software, but that depends on the underlying root irq
>     controller. How that is implemented does not matter for the
>     reservation.
>
>     The most flexible and platform independent solution would be to
>     describe the IPI space as a seperate irq domain. In most cases this
>     would be a hierarchical domain stacked on the root irq domain:
>
>     [IPI-domain] --> [GIC-MIPS-domain]
>
>     on x86 this would be:
>
>     [IPI-domain] --> [vector-domain]
>
>     That needs some change how the IPIs which are used by the kernel
>     (rescheduling, function call ..) are set up, but we get a proper
>     management and collision avoidance that way. Depending on the
>     platform we could actually remove the whole IPI compile time
>     reservation and hand out IPIs at boot time on demand and
>     dynamically.
>
>     So the reservation function would be something like:
>
>     unsigned int irq_reserve_ipi(const struct cpumask *dest, void *devid);
>
>     @dest contains the possible targets for the IPI. So for generic
>     linux IPIs this would be cpu_possible_mask. For your coprocessor
>     the target would be a cpumask with just the bit of the coprocessor
>     core set. If you need to use an IPI for sending an interrupt from
>     the coprocessor to a specific linux core then @dest will contain
>     just that target cpu.
>
>     @devid is stored in the IPI domain for sanity checks during
>     operation.
>
>     The function returns a linux irq number or 0 if allocation fails.
>
>     We need a complementary interface as well, so you can hand back the
>     IPI to the core when the coprocessor is disabled:
>
>     void irq_destroy_ipi(unsigned int irq, void *devid);
>
>
>     To configure your coprocessor proper, we need a translation
>     mechanism from the linux interrupt number to the magic value which
>     needs to be written into the trigger register when the coprocessor
>     wants to send an interrupt or an IPI.
>
>     int irq_get_irq_hwcfg(unsigned int irq, struct irq_hwcfg *cfg);
>
>     struct irq_hwcfg needs to be defined, but it might look like this:
>
>       {
> 	/* Generic fields */
> 	x;
> 	...
> 	union {
> 	      mips_gic;
> 	      ...
> 	};
>       };
>
>     The actual hw specific value(s) need to be filled in from the irq
>     domain specific code.
>
>
> #2 We have no generic mechanism for that either.
>
>     Something like this is needed:
>
>     void irq_send_ipi(unsigned int irq, const struct cpumask *dest,
>     		     void *devid);	
>
>     @dest is for generic linux IPIs and can be NULL so the IPI is sent to
>      	 the core(s) which have been handed in at reservation time
>
>     @devid is used to sanity check the driver call.
>
>     So that finally will call down via a irq chip callback into the
>     code which sends the IPI.
>
>
> #3 Now you get lucky, because we actually have an interface for this
>
>     request_percpu_irq()
>     free_percpu_irq()
>     disable_percpu_irq()
>     enable_percpu_irq()
>
>     Though there is a caveat. enable/disable_percpu_irq() must be
>     called from the target cpu, but that should be a solvable problem.
>
>     And at the IPI-domain side we need sanity checks whether the cpu
>     from which enable/disable is called is actually configured in the
>     reservation mask.
>     
>     There are a few other nasty details, but that's not important for
>     the big picture.
>
>     As I said above, I really would recommend to avoid that if possible
>     because a bog standard device interrupt is way simpler to deal
>     with.

Agreed. Something for us to think about and consider. But if not for AXD 
this kind of mechanism is important for us for other reasons so we 
probably want to see it through.

>
> That's certainly not the quick and dirty solution you are looking for,
> but exposing IPIs to drivers by anything else than a well thought out
> infrastructure is not going to happen.

Thanks a lot for the detailed explanation. I wasn't looking for a quick 
and dirty solution but my view of the problem is much simpler than yours 
so my idea of a solution would look quick and dirty. I have a better 
appreciation of the problem now and a way to approach it :-)

 From DT point of view are we OK with this form then

     coprocessor {
             interrupt-source = <&intc INT_SPEC COP_HWAFFINITY>;
             interrupt-sink = <&intc INT_SPEC CPU_HWAFFINITY>;
     }

and if the root controller sends normal IPI as it sends normal device 
interrupts then interrupt-sink can be a standard interrupts property 
(like in my case)

     coprocessor {
             interrupt-source = <&intc INT_SPEC COP_HWAFFINITY>;
             interrupts = <INT_SPEC>;
     }

Does this look right to you? Is there something else that needs to be 
covered still?

One more thing I can think of now is that the coprocessor will need the 
raw irq numbers that are picked by linux so that it can use them to 
trigger the IPI. Are we ok to add a function that returns this raw irq 
number (as opposed to linux irq number) directly from DT? The way this 
is communicated to the coprocessor will be platform specific.

Thanks,
Qais

>
> Thanks,
>
> 	tglx
