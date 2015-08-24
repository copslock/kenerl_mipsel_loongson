Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Aug 2015 18:39:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63300 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011154AbbHXQjoTxO06 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Aug 2015 18:39:44 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 32DE337326DCB;
        Mon, 24 Aug 2015 17:39:35 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 24 Aug 2015 17:39:37 +0100
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 24 Aug
 2015 17:39:37 +0100
Message-ID: <55DB48C9.7010508@imgtec.com>
Date:   Mon, 24 Aug 2015 17:39:37 +0100
From:   Qais Yousef <qais.yousef@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.8.0
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Marc Zyngier <marc.zyngier@arm.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export gic_send_ipi
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com> <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com> <alpine.DEB.2.11.1508241447100.3873@nanos> <55DB15EB.3090109@imgtec.com> <55DB1CD2.5030300@arm.com> <55DB29B5.3010202@imgtec.com> <alpine.DEB.2.11.1508241656280.3873@nanos>
In-Reply-To: <alpine.DEB.2.11.1508241656280.3873@nanos>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49007
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

On 08/24/2015 04:07 PM, Thomas Gleixner wrote:
> On Mon, 24 Aug 2015, Qais Yousef wrote:
>> On 08/24/2015 02:32 PM, Marc Zyngier wrote:
>>> I'd rather see something more "architected" than this blind export, or
>>> at least some level of filtering (the idea random drivers can access
>>> such a low-level function doesn't make me feel very good).
>> I don't know how to architect this better or how to perform  the filtering,
>> but I'm happy to hear suggestions and try them out.
>> Keep in mind that detecting GIC and writing your own gic_send_ipi() is very
>> simple. I have done this when the driver was out of tree. So restricting it by
>> not exporting it will not prevent someone from really accessing the
>> functionality, it's just they have to do it their own way.
> Keep in mind that we are not talking about out of tree hackery. We
> talk about a kernel code submission and I doubt, that you will get
> away with a GIC detection/fiddling burried in your driver code.
>
> Keep in mind that just slapping an export to some random function is
> not much better than doing a GIC hack in the driver.
>
> Marcs concerns about blindly exposing IPI functionality to drivers is
> well justified and that kind of coprocessor stuff is not unique to
> your particular SoC. We're going to see such things more frequently in
> the not so distant future, so we better think now about proper
> solutions to that problem.

Sure I'm not trying to argue against that.

>
> There are a couple of issues to solve:
>
> 1) How is the IPI which is received by the coprocessor reserved in the
>     system?
>
> 2) How is it associated to a particular driver?

Shouldn't 'interrupts' property in DT take care of these 2 questions? 
Maybe we can give it an alias name to make it more readable that this 
interrupt is requested for external IPI.

>
> 3) How do we ensure that a driver cannot issue random IPIs and can
>     only send the associated ones?

If we get the irq number from DT then I'm not sure how feasible it is to 
implement a generic_send_ipi() function that takes this number to 
generate an IPI.

Do you think this approach would work?

>
> None of these issues are handled by your export.
>
> So we need a core infrastructure which allows us to do that. The
> requirements are pretty clear from the above and Marc might have some
> further restrictions in mind.

Another issue I'm having which is related is that I need to communicate 
these GIC irq numbers to AXD core when it starts up. So the logic is 
that these IPIs are not hardwired and it's up to the system designer to 
allocate 2 free GIC irqs to be used for that purpose. At the moment I 
have my own DT property to take these numbers. Hopefully this link would 
explain the issue. See the question about gic-irq property.

     https://lkml.org/lkml/2015/8/24/459

 From what I know there's no generic way for the driver to get the hw 
irq number from linux irq number unless I missed something. Is it 
possible to add something to support this? Or maybe there's something 
but I failed to find?

Thanks,
Qais

>
> Thanks,
>
> 	tglx
