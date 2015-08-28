Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Aug 2015 16:22:43 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:36269 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006585AbbH1OWmUYo8C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Aug 2015 16:22:42 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZVKY9-00054t-D0; Fri, 28 Aug 2015 16:22:37 +0200
Date:   Fri, 28 Aug 2015 16:22:08 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@imgtec.com>
cc:     Marc Zyngier <marc.zyngier@arm.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Lisa Parratt <Lisa.Parratt@imgtec.com>
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export gic_send_ipi
In-Reply-To: <55E03A2B.3070805@imgtec.com>
Message-ID: <alpine.DEB.2.11.1508281619311.15006@nanos>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com> <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com> <alpine.DEB.2.11.1508241447100.3873@nanos> <55DB15EB.3090109@imgtec.com> <55DB1CD2.5030300@arm.com> <55DB29B5.3010202@imgtec.com>
 <alpine.DEB.2.11.1508241656280.3873@nanos> <55DB48C9.7010508@imgtec.com> <55DB519D.2090203@arm.com> <55DDA1C4.4070301@imgtec.com> <alpine.DEB.2.11.1508261427280.15006@nanos> <55DDD3E3.7070009@imgtec.com> <alpine.DEB.2.11.1508261701430.15006@nanos>
 <55DDDE3C.8030609@imgtec.com> <alpine.DEB.2.11.1508262101450.15006@nanos> <55E03A2B.3070805@imgtec.com>
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
X-archive-position: 49064
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

On Fri, 28 Aug 2015, Qais Yousef wrote:
> Thanks a lot for the detailed explanation. I wasn't looking for a quick and
> dirty solution but my view of the problem is much simpler than yours so my
> idea of a solution would look quick and dirty. I have a better appreciation of
> the problem now and a way to approach it :-)
> 
> From DT point of view are we OK with this form then
> 
>     coprocessor {
>             interrupt-source = <&intc INT_SPEC COP_HWAFFINITY>;
>             interrupt-sink = <&intc INT_SPEC CPU_HWAFFINITY>;
>     }
> 
> and if the root controller sends normal IPI as it sends normal device
> interrupts then interrupt-sink can be a standard interrupts property (like in
> my case)
> 
>     coprocessor {
>             interrupt-source = <&intc INT_SPEC COP_HWAFFINITY>;
>             interrupts = <INT_SPEC>;
>     }
> 
> Does this look right to you? Is there something else that needs to be covered
> still?

I'm not an DT wizard. I leave that to the DT experts.
 
> One more thing I can think of now is that the coprocessor will need the raw
> irq numbers that are picked by linux so that it can use them to trigger the
> IPI. Are we ok to add a function that returns this raw irq number (as opposed
> to linux irq number) directly from DT? The way this is communicated to the
> coprocessor will be platform specific.

Why do you want that to be hacked into DT? 

> >     To configure your coprocessor proper, we need a translation
> >     mechanism from the linux interrupt number to the magic value which
> >     needs to be written into the trigger register when the coprocessor
> >     wants to send an interrupt or an IPI.
> > 
> >     int irq_get_irq_hwcfg(unsigned int irq, struct irq_hwcfg *cfg);
> > 
> >     struct irq_hwcfg needs to be defined, but it might look like this:
> > 
> >       {
> > 	/* Generic fields */
> > 	x;
> > 	...
> > 	union {
> > 	      mips_gic;
> > 	      ...
> > 	};
> >       };

That function provides you the information which you have to hand over
to your coprocessor firmware.

Thanks,

	tglx
