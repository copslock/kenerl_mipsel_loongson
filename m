Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Aug 2015 15:20:18 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:56604 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007390AbbHZNUR2CXDQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Aug 2015 15:20:17 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZUace-00021d-N4; Wed, 26 Aug 2015 15:20:12 +0200
Date:   Wed, 26 Aug 2015 15:19:44 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@imgtec.com>
cc:     Marc Zyngier <marc.zyngier@arm.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Mark Rutland <Mark.Rutland@arm.com>
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export gic_send_ipi
In-Reply-To: <55DDA1C4.4070301@imgtec.com>
Message-ID: <alpine.DEB.2.11.1508261427280.15006@nanos>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com> <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com> <alpine.DEB.2.11.1508241447100.3873@nanos> <55DB15EB.3090109@imgtec.com> <55DB1CD2.5030300@arm.com> <55DB29B5.3010202@imgtec.com>
 <alpine.DEB.2.11.1508241656280.3873@nanos> <55DB48C9.7010508@imgtec.com> <55DB519D.2090203@arm.com> <55DDA1C4.4070301@imgtec.com>
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
X-archive-position: 49018
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
> Can we replace 'something' in interrupt-source and interrupt-sink definitions
> to 'host' or 'CPU' or do we really care about creating IPI between any 2
> 'things'?
> 
> Changing the definition will also make interrupt-sink a synonym/alias to
> interrupts property. So the description will become
> 
> axd: axd {
>         interrupt-source = <&gic GIC_SHARED 36 IRQ_TYPE_EDGE_RISING>; /*
> interrupt from CPU to AXD */
>         interrupt-sink = <&gic GIC_SHARED 37 IRQ_TYPE_EDGE_RISING>; /*
> interrupt from AXD to CPU */
> }
> 
> But this assume Linux won't take care of the routing. If we want Linux to take
> care of the routing, maybe something like this then?
> 
> axd: axd {
>         interrupt-source = <&gic GIC_SHARED 36 IRQ_TYPE_EDGE_RISING
> HWAFFINITY1>; /* interrupt from CPU to
> AXD@HWAFFINITY1*/
>         interrupt-sink = <&gic GIC_SHARED 37 IRQ_TYPE_EDGE_RISING
> HWAFFINITY2>; /* interrupt from AXD to CPU@HWAFFINITY2 */
> }
> 
> I don't think it's necessary to specify the HWAFFINITY2 for interrupt-sink as
> linux can use SMP affinity to move it around but we can make it optional in
> case there's a need to hardcode it to a specific Linux core. Or maybe the
> driver can use affinity hint..

Wrong. You cannot move an IPI around with set_affinity. It's possible
to send an IPI to more than one target CPU, but that has nothing to do
with affinities.

Are you talking about IPIs or about general interrupts which have an
affinity setting?

> Any pointers on the best way to tie gic_send_ipi() with the driver/core code?
> The way it's currently tied to the core code is through SMP IPI functions
> which I don't think we can use. I'm thinking adding a pointer function in
> struct irq_chip would be the easiest approach maybe?

That's the least of our worries. We need to get the high level
interfaces and the devicetree mechanism straight before we talk about
this kind of details.

Thanks,

	tglx
