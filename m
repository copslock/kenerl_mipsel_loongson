Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Aug 2015 16:57:47 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52630 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007603AbbHZO5qbh2l2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Aug 2015 16:57:46 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9220227CA3C44;
        Wed, 26 Aug 2015 15:57:36 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 26 Aug 2015 15:57:39 +0100
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 26 Aug
 2015 15:57:39 +0100
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export gic_send_ipi
To:     Thomas Gleixner <tglx@linutronix.de>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
 <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com>
 <alpine.DEB.2.11.1508241447100.3873@nanos> <55DB15EB.3090109@imgtec.com>
 <55DB1CD2.5030300@arm.com> <55DB29B5.3010202@imgtec.com>
 <alpine.DEB.2.11.1508241656280.3873@nanos> <55DB48C9.7010508@imgtec.com>
 <55DB519D.2090203@arm.com> <55DDA1C4.4070301@imgtec.com>
 <alpine.DEB.2.11.1508261427280.15006@nanos>
CC:     Marc Zyngier <marc.zyngier@arm.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Mark Rutland <Mark.Rutland@arm.com>
From:   Qais Yousef <qais.yousef@imgtec.com>
Message-ID: <55DDD3E3.7070009@imgtec.com>
Date:   Wed, 26 Aug 2015 15:57:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1508261427280.15006@nanos>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49019
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

On 08/26/2015 02:19 PM, Thomas Gleixner wrote:
> On Wed, 26 Aug 2015, Qais Yousef wrote:
>> Can we replace 'something' in interrupt-source and interrupt-sink definitions
>> to 'host' or 'CPU' or do we really care about creating IPI between any 2
>> 'things'?
>>
>> Changing the definition will also make interrupt-sink a synonym/alias to
>> interrupts property. So the description will become
>>
>> axd: axd {
>>          interrupt-source = <&gic GIC_SHARED 36 IRQ_TYPE_EDGE_RISING>; /*
>> interrupt from CPU to AXD */
>>          interrupt-sink = <&gic GIC_SHARED 37 IRQ_TYPE_EDGE_RISING>; /*
>> interrupt from AXD to CPU */
>> }
>>
>> But this assume Linux won't take care of the routing. If we want Linux to take
>> care of the routing, maybe something like this then?
>>
>> axd: axd {
>>          interrupt-source = <&gic GIC_SHARED 36 IRQ_TYPE_EDGE_RISING
>> HWAFFINITY1>; /* interrupt from CPU to
>> AXD@HWAFFINITY1*/
>>          interrupt-sink = <&gic GIC_SHARED 37 IRQ_TYPE_EDGE_RISING
>> HWAFFINITY2>; /* interrupt from AXD to CPU@HWAFFINITY2 */
>> }
>>
>> I don't think it's necessary to specify the HWAFFINITY2 for interrupt-sink as
>> linux can use SMP affinity to move it around but we can make it optional in
>> case there's a need to hardcode it to a specific Linux core. Or maybe the
>> driver can use affinity hint..
> Wrong. You cannot move an IPI around with set_affinity. It's possible
> to send an IPI to more than one target CPU, but that has nothing to do
> with affinities.
>
> Are you talking about IPIs or about general interrupts which have an
> affinity setting?

Maybe my view of the world is limited. I wrote this because the 
mechanism to route an IPI and set affinities is the same.
So specifying which core or hardware thread should Linux CPU route this 
IPI to is the same as setting the affinity, no? Linux will not move the 
IPI that is routed to the coprocessor core. Just the IPI it will receive.

Also the way I see it is that this is an external interrupt whether it 
was asserted by real signal or through IPI mechanism and it should be 
treated as such in terms of moving inside Linux SMP, no? Again maybe my 
view of the world is limited but I can't see why migrating the interrupt 
would affect correctness unless there's a hardware limitation like only 
core 0 can read info from AXD (which is where my suggestion to using 
affinity hint above to accommodate such limitations).

When you say 'It is possible to send an IPI to more than one target 
CPU', is it a case we need to cater for? The way I was seeing this 
problem is communication between single Linux SMP and a single 
coprocessor unit. I didn't think of it as single to many. Even if the 
coprocessor is a cluster I'd expect it to act as a single unit like 
Linux SMP. And if it wanted to send 2 different interrupts it will need 
to use 2 different IPIs.

If I'm stating anything obvious above please bear with me. I'm just 
trying to be clear about my view of the world in case I'm missing 
something :-)

>
>> Any pointers on the best way to tie gic_send_ipi() with the driver/core code?
>> The way it's currently tied to the core code is through SMP IPI functions
>> which I don't think we can use. I'm thinking adding a pointer function in
>> struct irq_chip would be the easiest approach maybe?
> That's the least of our worries. We need to get the high level
> interfaces and the devicetree mechanism straight before we talk about
> this kind of details.

Fair enough. The reason I asked is to help me start writing some test 
code but I'll wait.

Thanks,
Qais

>
> Thanks,
>
> 	tglx
