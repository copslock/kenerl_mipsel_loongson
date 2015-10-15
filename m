Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Oct 2015 11:37:34 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54947 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009715AbbJOJhdGVmLg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Oct 2015 11:37:33 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 622284F4B37BA;
        Thu, 15 Oct 2015 10:37:25 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 15 Oct 2015 10:37:27 +0100
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 15 Oct
 2015 10:37:26 +0100
Subject: Re: [PATCH v2 2/3] irqchip: irq-mips-gic: Provide function to map GIC
 user section
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
References: <1443435117-17144-1-git-send-email-markos.chandras@imgtec.com>
 <1444642843-16375-1-git-send-email-markos.chandras@imgtec.com>
 <561B82BA.30809@arm.com> <alpine.DEB.2.11.1510121155490.6097@nanos>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <linux-mips@linux-mips.org>, Alex Smith <alex.smith@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>
From:   Qais Yousef <qais.yousef@imgtec.com>
Message-ID: <561F73D6.8040300@imgtec.com>
Date:   Thu, 15 Oct 2015 10:37:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1510121155490.6097@nanos>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49561
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

On 10/12/2015 11:16 AM, Thomas Gleixner wrote:
> On Mon, 12 Oct 2015, Marc Zyngier wrote:
>> On 12/10/15 10:40, Markos Chandras wrote:
>>> From: Alex Smith <alex.smith@imgtec.com>
>>>
>>> The GIC provides a "user-mode visible" section containing a mirror of
>>> the counter registers which can be mapped into user memory. This will
>>> be used by the VDSO time function implementations, so provide a
>>> function to map it in.
> <SNIP>
>   
>> This looks much better than the previous version (though I cannot find
>> the two other patches on LKML just yet).
> Yes, it looks better. But I really have to ask the question why we are
> trying to pack the world and somemore into an irq chip driver. We
> already have the completely misplaced gic_read_count() there.

This code has a bad history. It was scattered all over the place in arch 
code. Andrew Bresticker did a good job cleaning it up and moved it to 
this irqchip driver.

     https://lkml.org/lkml/2014/9/18/487
     https://lkml.org/lkml/2014/10/20/481

>
> While I understand that all of this is in the GIC block at least
> according to the documentation, technically it's different hardware
> blocks. And logically its different as well.

Yes but they're exposed through the same register interface.

>
> So why not describe the various blocks (interrupt controller, timer,
> shadow timer) as separate entities in the device tree and let each
> subsystem look them up on their own. This cross subsystem hackery is
> just horrible and does not buy anything except merge dependencies and
> other avoidable hassle.

There's a mips-gic-timer driver in drivers/clocksource. But in device 
tree it's a subnode of the irqchip driver.

http://lxr.free-electrons.com/source/drivers/clocksource/mips-gic-timer.c
http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt

>
> Thoughts?
>

It could be refactored but the DT binding already specifies the GIC 
timer as a subnode of GIC. Exposing this usermode register is the only 
thing left in the register set that GIC driver wasn't dealing with.

Little gain in changing all of this now I think?

Thanks,
Qais
