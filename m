Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Aug 2015 13:23:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7572 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012215AbbHZLX4b-xD6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Aug 2015 13:23:56 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B5392A3C80A64;
        Wed, 26 Aug 2015 12:23:46 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 26 Aug 2015 12:23:49 +0100
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 26 Aug
 2015 12:23:48 +0100
Message-ID: <55DDA1C4.4070301@imgtec.com>
Date:   Wed, 26 Aug 2015 12:23:48 +0100
From:   Qais Yousef <qais.yousef@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.8.0
MIME-Version: 1.0
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Mark Rutland <Mark.Rutland@arm.com>
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export gic_send_ipi
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com> <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com> <alpine.DEB.2.11.1508241447100.3873@nanos> <55DB15EB.3090109@imgtec.com> <55DB1CD2.5030300@arm.com> <55DB29B5.3010202@imgtec.com> <alpine.DEB.2.11.1508241656280.3873@nanos> <55DB48C9.7010508@imgtec.com> <55DB519D.2090203@arm.com>
In-Reply-To: <55DB519D.2090203@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49017
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

On 08/24/2015 06:17 PM, Marc Zyngier wrote:
> [adding Mark Rutland, as this is heading straight into uncharted DT
> territory]
>
> On 24/08/15 17:39, Qais Yousef wrote:
>> On 08/24/2015 04:07 PM, Thomas Gleixner wrote:
>>> On Mon, 24 Aug 2015, Qais Yousef wrote:
>>>> On 08/24/2015 02:32 PM, Marc Zyngier wrote:
>>>>> I'd rather see something more "architected" than this blind export, or
>>>>> at least some level of filtering (the idea random drivers can access
>>>>> such a low-level function doesn't make me feel very good).
>>>> I don't know how to architect this better or how to perform  the filtering,
>>>> but I'm happy to hear suggestions and try them out.
>>>> Keep in mind that detecting GIC and writing your own gic_send_ipi() is very
>>>> simple. I have done this when the driver was out of tree. So restricting it by
>>>> not exporting it will not prevent someone from really accessing the
>>>> functionality, it's just they have to do it their own way.
>>> Keep in mind that we are not talking about out of tree hackery. We
>>> talk about a kernel code submission and I doubt, that you will get
>>> away with a GIC detection/fiddling burried in your driver code.
>>>
>>> Keep in mind that just slapping an export to some random function is
>>> not much better than doing a GIC hack in the driver.
>>>
>>> Marcs concerns about blindly exposing IPI functionality to drivers is
>>> well justified and that kind of coprocessor stuff is not unique to
>>> your particular SoC. We're going to see such things more frequently in
>>> the not so distant future, so we better think now about proper
>>> solutions to that problem.
>> Sure I'm not trying to argue against that.
>>
>>> There are a couple of issues to solve:
>>>
>>> 1) How is the IPI which is received by the coprocessor reserved in the
>>>      system?
>>>
>>> 2) How is it associated to a particular driver?
>> Shouldn't 'interrupts' property in DT take care of these 2 questions?
>> Maybe we can give it an alias name to make it more readable that this
>> interrupt is requested for external IPI.
> The "interrupts" property has a rather different meaning, and isn't
> designed to hardcode IPIs. Also, this property describes an interrupt
> from a device to the CPU, not the other way around (I imagine you also
> have an interrupt coming from the AXD to the CPU, possibly using an IPI
> too).

Yes we have an interrupt from AXD to the CPU. But the way I take
care of the routing at the moment is that the CPU routes the interrupt it
receives from AXD. And AXD routes the interrupt it receives from the
CPU. This is useful because in MIPS GIC the routing is done per hw thread
on the core so this gives the flexibility for each one to choose what it
suits it best.

>
> We can deal with these issues, but that's not something we can improvise.
>
> What I had in mind was something fairly generic:
> - interrupt-source: something generating an interrupt
> - interrupt-sink: something being targeted by an interrupt
>
> You could then express things like:
>
> intc: interrupt-controller@1000 {
> 	interrupt-controller;
> };
>
> mydevice@f0000000 {
> 	interrupt-source = <&intc INT_SPEC 2 &inttarg1 &inttarg1>;
> };

To make sure we're on the same page. INT_SPEC here refers to the arguments
we pass to a standard interrupts property, right?

>
> inttarg1: mydevice@f1000000 {
> 	interrupt-sink = <&intc HWAFFINITY1>;
> };
>
> inttarg2: cpu@1 {
> 	interrupt-sink = <&intc HWAFFINITY2>;
> };

And HWAFFINITY here is the core (or hardware thread) this interrupt will 
be routed to?

So for my case where CPU is on core 0 and AXD is on core 1 my 
description will look like

cpu: cpu@0 {
         interrupt-source = <&gic GIC_SHARED 36 IRQ_TYPE_EDGE_RISING 1 
&axd>;
         interrupt-sink = <&gic 0>;
}

axd: axd {
         interrupt-source = <&gic GIC_SHARED 37 IRQ_TYPE_EDGE_RISING 1 
&cpu>;
         interrupt-sink = <&gic 1>;
}

If I didn't misunderstand you, the issue I see with this is that the 
information about which IRQ to use to send an IPI to AXD is not present 
in the AXD node. We will need to search the cpu node for something that 
is meant to be routed to axd or have some logic to implicitly infer it 
from interrupt-sink in axd node. Not convenient IMO.

Can we replace 'something' in interrupt-source and interrupt-sink 
definitions to 'host' or 'CPU' or do we really care about creating IPI 
between any 2 'things'?

Changing the definition will also make interrupt-sink a synonym/alias to 
interrupts property. So the description will become

axd: axd {
         interrupt-source = <&gic GIC_SHARED 36 IRQ_TYPE_EDGE_RISING>; 
/* interrupt from CPU to AXD */
         interrupt-sink = <&gic GIC_SHARED 37 IRQ_TYPE_EDGE_RISING>; /* 
interrupt from AXD to CPU */
}

But this assume Linux won't take care of the routing. If we want Linux 
to take care of the routing, maybe something like this then?

axd: axd {
         interrupt-source = <&gic GIC_SHARED 36 IRQ_TYPE_EDGE_RISING 
HWAFFINITY1>; /* interrupt from CPU to
AXD@HWAFFINITY1*/
         interrupt-sink = <&gic GIC_SHARED 37 IRQ_TYPE_EDGE_RISING 
HWAFFINITY2>; /* interrupt from AXD to CPU@HWAFFINITY2 */
}

I don't think it's necessary to specify the HWAFFINITY2 for 
interrupt-sink as linux can use SMP affinity to move it around but we 
can make it optional in case there's a need to hardcode it to a specific 
Linux core. Or maybe the driver can use affinity hint..

>
> You could also imagine having CPUs being both source and sink.
>
>>> 3) How do we ensure that a driver cannot issue random IPIs and can
>>>      only send the associated ones?
>> If we get the irq number from DT then I'm not sure how feasible it is to
>> implement a generic_send_ipi() function that takes this number to
>> generate an IPI.
>>
>> Do you think this approach would work?
> If you follow the above approach, it should be pretty easy to derive a
> source identifier and a sink identifier from the DT, and have the core
> code to route one to the other and do the right thing.

Do you think it's better for linux to take care of all the routing 
instead of each core doing its own routing?
If Linux to do the routing for the other core (even if optionally), 
what's the mechanism to do that? We can't use irq_set_affinity() because 
we want to map something that is not part of Linux. A new mapping 
function in struct irq_domain_ops maybe?

>
> The source identifier could also be used to describe an IPI in a fairly
> safe way (the target being fixed by DT, but the actual number used
> dynamically allocated by the kernel).

To be dynamic, then the interrupt controller must specify which 
interrupts are actually free to use. What if the DT doesn't describe all 
the hardawre that is connected to GIC and Linux thinks its free to use 
but actually it's connected to a real hardware but no one told us about? 
I think since this information will always have to be looked up maybe 
it's better to give the responsibility to the user to specify something 
they know will work explicitly.

>
> This is just a 10 minutes braindump, so feel free to throw rocks at it
> and to come up with a better solution! :-)

Thanks for that. My brain is tied down to my use case to come up with 
something generic easily :-)

Any pointers on the best way to tie gic_send_ipi() with the driver/core 
code? The way it's currently tied to the core code is through SMP IPI 
functions which I don't think we can use. I'm thinking adding a pointer 
function in struct irq_chip would be the easiest approach maybe?

Thanks,
Qais

>
> Thanks,
>
> 	M.
