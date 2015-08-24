Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Aug 2015 15:32:13 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:47618 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010140AbbHXNcLrORSp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Aug 2015 15:32:11 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C47E3DA;
        Mon, 24 Aug 2015 06:31:52 -0700 (PDT)
Received: from [10.1.209.148] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FF453F59B;
        Mon, 24 Aug 2015 06:32:04 -0700 (PDT)
Message-ID: <55DB1CD2.5030300@arm.com>
Date:   Mon, 24 Aug 2015 14:32:02 +0100
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
MIME-Version: 1.0
To:     Qais Yousef <qais.yousef@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export gic_send_ipi
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com> <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com> <alpine.DEB.2.11.1508241447100.3873@nanos> <55DB15EB.3090109@imgtec.com>
In-Reply-To: <55DB15EB.3090109@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49002
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

On 24/08/15 14:02, Qais Yousef wrote:
> On 08/24/2015 01:49 PM, Thomas Gleixner wrote:
>> On Mon, 24 Aug 2015, Qais Yousef wrote:
>>
>>> Some drivers might require to send ipi to other cores. So export it.
>> Which IPIs do you need to send from a driver which are not exposed by
>> the SMP functions already?
> 
> It's not an SMP IPI. We use GIC to exchange interrupts between AXD and 
> the host system since AXD is another MIPS core in the cluster.

So is this the case of another CPU in the system that is not under
control of Linux, but that you need to signal anyway? How do you agree
on the IPI number between the two systems?

>>> This will be used later by AXD driver.
>> That smells fishy and it wants a proper explanation WHY and not just a
>> sloppy statement that it will be used later. I can figure that out
>> myself as exporting a function without using it does not make any sense.
> 
> Sorry for the terse explanation. As pointed above AXD uses GIC to send 
> and receive interrupts to the host core. Without this change I can't 
> compile the driver as a driver module because the symbol is not exported.
> 
> Does this make things clearer?

To me, it feels like this is yet another case of routing interrupts to
another agent in the system, which is not a CPU under the kernel's
control. There is at least two other platforms doing similar craziness
(a Freescale platform, and at least one Nvidia).

I'd rather see something more "architected" than this blind export, or
at least some level of filtering (the idea random drivers can access
such a low-level function doesn't make me feel very good).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
