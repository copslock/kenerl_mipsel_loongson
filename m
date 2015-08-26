Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Aug 2015 17:09:38 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:57210 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007603AbbHZPJblxgx2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Aug 2015 17:09:31 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZUcKN-00039x-0z; Wed, 26 Aug 2015 17:09:27 +0200
Date:   Wed, 26 Aug 2015 17:08:59 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@imgtec.com>
cc:     Marc Zyngier <marc.zyngier@arm.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Mark Rutland <Mark.Rutland@arm.com>
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export gic_send_ipi
In-Reply-To: <55DDD3E3.7070009@imgtec.com>
Message-ID: <alpine.DEB.2.11.1508261701430.15006@nanos>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com> <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com> <alpine.DEB.2.11.1508241447100.3873@nanos> <55DB15EB.3090109@imgtec.com> <55DB1CD2.5030300@arm.com> <55DB29B5.3010202@imgtec.com>
 <alpine.DEB.2.11.1508241656280.3873@nanos> <55DB48C9.7010508@imgtec.com> <55DB519D.2090203@arm.com> <55DDA1C4.4070301@imgtec.com> <alpine.DEB.2.11.1508261427280.15006@nanos> <55DDD3E3.7070009@imgtec.com>
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
X-archive-position: 49020
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
> On 08/26/2015 02:19 PM, Thomas Gleixner wrote:
> > Wrong. You cannot move an IPI around with set_affinity. It's possible
> > to send an IPI to more than one target CPU, but that has nothing to do
> > with affinities.
> > 
> > Are you talking about IPIs or about general interrupts which have an
> > affinity setting?
> 
> Maybe my view of the world is limited. I wrote this because the mechanism to
> route an IPI and set affinities is the same.

That might be the case on your particular platform, but that's not
generally true.

> So specifying which core or hardware thread should Linux CPU route this IPI to
> is the same as setting the affinity, no? Linux will not move the IPI that is
> routed to the coprocessor core. Just the IPI it will receive.
> 
> Also the way I see it is that this is an external interrupt whether it was
> asserted by real signal or through IPI mechanism and it should be treated as
> such in terms of moving inside Linux SMP, no? Again maybe my view of the world
> is limited but I can't see why migrating the interrupt would affect
> correctness unless there's a hardware limitation like only core 0 can read
> info from AXD (which is where my suggestion to using affinity hint above to
> accommodate such limitations).
> 
> When you say 'It is possible to send an IPI to more than one target CPU', is
> it a case we need to cater for? The way I was seeing this problem is
> communication between single Linux SMP and a single coprocessor unit. I didn't
> think of it as single to many. Even if the coprocessor is a cluster I'd expect
> it to act as a single unit like Linux SMP. And if it wanted to send 2
> different interrupts it will need to use 2 different IPIs.

You are confusing the terms.

IPI = Inter Processor Interrupt

As the name says that's an interrupt which goes from one cpu to
another. So an IPI has a very clear target.

Whether the platform implements IPIs via general interrupts which are
made affine to a particular cpu or some other specialized mechanism is
completely irrelevant. An IPI is not subject to affinity settings,
period.

So if you want to use an IPI then you need a target cpu for that IPI.

If you want something which can be affined to any cpu, then you need a
general interrupt and not an IPI.

That's what I asked before and you still did not answer that question.

> > Are you talking about IPIs or about general interrupts which have an
> > affinity setting?

Thanks,

	tglx
