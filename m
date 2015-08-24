Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Aug 2015 19:17:28 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:48517 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007261AbbHXRR1GPa66 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Aug 2015 19:17:27 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 300F875;
        Mon, 24 Aug 2015 10:17:07 -0700 (PDT)
Received: from [10.1.209.148] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B48CF3F23A;
        Mon, 24 Aug 2015 10:17:18 -0700 (PDT)
Message-ID: <55DB519D.2090203@arm.com>
Date:   Mon, 24 Aug 2015 18:17:17 +0100
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
MIME-Version: 1.0
To:     Qais Yousef <qais.yousef@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Mark Rutland <Mark.Rutland@arm.com>
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export gic_send_ipi
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com> <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com> <alpine.DEB.2.11.1508241447100.3873@nanos> <55DB15EB.3090109@imgtec.com> <55DB1CD2.5030300@arm.com> <55DB29B5.3010202@imgtec.com> <alpine.DEB.2.11.1508241656280.3873@nanos> <55DB48C9.7010508@imgtec.com>
In-Reply-To: <55DB48C9.7010508@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marc.zyngier@arm.com
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

[adding Mark Rutland, as this is heading straight into uncharted DT
territory]

On 24/08/15 17:39, Qais Yousef wrote:
> On 08/24/2015 04:07 PM, Thomas Gleixner wrote:
>> On Mon, 24 Aug 2015, Qais Yousef wrote:
>>> On 08/24/2015 02:32 PM, Marc Zyngier wrote:
>>>> I'd rather see something more "architected" than this blind export, or
>>>> at least some level of filtering (the idea random drivers can access
>>>> such a low-level function doesn't make me feel very good).
>>> I don't know how to architect this better or how to perform  the filtering,
>>> but I'm happy to hear suggestions and try them out.
>>> Keep in mind that detecting GIC and writing your own gic_send_ipi() is very
>>> simple. I have done this when the driver was out of tree. So restricting it by
>>> not exporting it will not prevent someone from really accessing the
>>> functionality, it's just they have to do it their own way.
>> Keep in mind that we are not talking about out of tree hackery. We
>> talk about a kernel code submission and I doubt, that you will get
>> away with a GIC detection/fiddling burried in your driver code.
>>
>> Keep in mind that just slapping an export to some random function is
>> not much better than doing a GIC hack in the driver.
>>
>> Marcs concerns about blindly exposing IPI functionality to drivers is
>> well justified and that kind of coprocessor stuff is not unique to
>> your particular SoC. We're going to see such things more frequently in
>> the not so distant future, so we better think now about proper
>> solutions to that problem.
> 
> Sure I'm not trying to argue against that.
> 
>>
>> There are a couple of issues to solve:
>>
>> 1) How is the IPI which is received by the coprocessor reserved in the
>>     system?
>>
>> 2) How is it associated to a particular driver?
> 
> Shouldn't 'interrupts' property in DT take care of these 2 questions? 
> Maybe we can give it an alias name to make it more readable that this 
> interrupt is requested for external IPI.

The "interrupts" property has a rather different meaning, and isn't
designed to hardcode IPIs. Also, this property describes an interrupt
from a device to the CPU, not the other way around (I imagine you also
have an interrupt coming from the AXD to the CPU, possibly using an IPI
too).

We can deal with these issues, but that's not something we can improvise.

What I had in mind was something fairly generic:
- interrupt-source: something generating an interrupt
- interrupt-sink: something being targeted by an interrupt

You could then express things like:

intc: interrupt-controller@1000 {
	interrupt-controller;
};

mydevice@f0000000 {
	interrupt-source = <&intc INT_SPEC 2 &inttarg1 &inttarg1>;
};

inttarg1: mydevice@f1000000 {
	interrupt-sink = <&intc HWAFFINITY1>;
};

inttarg2: cpu@1 {
	interrupt-sink = <&intc HWAFFINITY2>;
};

You could also imagine having CPUs being both source and sink.

>>
>> 3) How do we ensure that a driver cannot issue random IPIs and can
>>     only send the associated ones?
> 
> If we get the irq number from DT then I'm not sure how feasible it is to 
> implement a generic_send_ipi() function that takes this number to 
> generate an IPI.
> 
> Do you think this approach would work?

If you follow the above approach, it should be pretty easy to derive a
source identifier and a sink identifier from the DT, and have the core
code to route one to the other and do the right thing.

The source identifier could also be used to describe an IPI in a fairly
safe way (the target being fixed by DT, but the actual number used
dynamically allocated by the kernel).

This is just a 10 minutes braindump, so feel free to throw rocks at it
and to come up with a better solution! :-)

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
