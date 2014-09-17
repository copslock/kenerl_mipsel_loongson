Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Sep 2014 16:07:29 +0200 (CEST)
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:49387 "EHLO
        mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009048AbaIQOHZ6ixvP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Sep 2014 16:07:25 +0200
Received: from pool-96-249-243-124.nrflva.fios.verizon.net ([96.249.243.124] helo=titan)
        by mho-01-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <jason@lakedaemon.net>)
        id 1XUFt4-000PqN-6C; Wed, 17 Sep 2014 14:07:14 +0000
Received: from titan.lakedaemon.net (localhost [127.0.0.1])
        by titan (Postfix) with ESMTP id 266DA5E4F46;
        Wed, 17 Sep 2014 10:07:11 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Originating-IP: 96.249.243.124
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+9TmN6w1siK1iY3Csom1l97krH4WyA23I=
X-DKIM: OpenDKIM Filter v2.0.1 titan 266DA5E4F46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1410962831;
        bh=h+tH+ik2WmYmsEtrM4tUR/9jkvE607OP42hNDIzNp+c=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=RszFltlWnbRrr9/Q7QZHpLxT9DQZID3mWzA9QdbJva2/RJIp6OiJWQc233LFYY12U
         bbq6tbMEO2X0PNDY9cxG0rhEWp1oyyAMqy6ZgqlOvIGlc5Dvfx/6ou4Kkh7CA1uYVL
         HPJrgDZu/icNNayhvVRGvhrmj5Ohg5iJ4UO03OHYOXt8ilFQ1L2Bj7ckvIiHJTvbq/
         xIA9ltbC6eiOa3lW+0Ql2POywGyOkKmAhXn3/pdW0frLMV14efRQPtyjSbaggfubxD
         ZMZX+qSL2kiPvJuLE8Ny+PT6pKeCCsMEs0Miha+0vvEYj4ArsX6YkJ50rwIXlXTufT
         K8xRt4o2vRa+g==
Date:   Wed, 17 Sep 2014 10:07:11 -0400
From:   Jason Cooper <jason@lakedaemon.net>
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/24] MIPS GIC cleanup, part 1
Message-ID: <20140917140711.GB16945@titan.lakedaemon.net>
References: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42663
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason@lakedaemon.net
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

Andrew,

First, great work!

On Mon, Sep 15, 2014 at 04:51:03PM -0700, Andrew Bresticker wrote:
> The current MIPS GIC driver and the platform code using it are rather
> ugly and could use a good cleanup before adding device-tree support [0].
> This major issues addressed in this series are converting the GIC (and
> platforms using it) to use IRQ domains and properly mapping interrupts
> through the GIC instead of using it transparently.  For part 2 I plan
> on: updating the driver to use proper iomem accessors, cleaning up and
> moving the GIC clocksource driver to drivers/clocksource/, adding DT
> support, and possibly converting the GIC driver to use generic irqchip.
> 
> Patches 1-16 are cleanups for the existing GIC driver and prepare platforms
> using it for the switch to IRQ domains and using the GIC in a non-transparent
> way.
> 
> Patches 17-24 convert the GIC driver to use IRQ domains and updates the
> platforms using it to properly map GIC interrupts instead of using the static
> routing tables to make the GIC appear transparent.
> 
> I've tested this series on Malta and, with additional patches, on the
> DT-enabled Danube platform.  Unfortunately I do not have SEAD-3 hardware,
> so that has only been compile tested.  Compile tested on all other affected
> architectures (ath79, ralink, lantiq).
> 
> [0] https://lkml.org/lkml/2014/9/5/542
> 
> Andrew Bresticker (24):
...
>   MIPS: Move GIC to drivers/irqchip/
>   irqchip: mips-gic: Implement generic irq_ack/irq_eoi callbacks
>   irqchip: mips-gic: Implement irq_set_type callback
>   irqchip: mips-gic: Fix gic_set_affinity() return value
>   irqchip: mips-gic: Use IRQ domains
>   irqchip: mips-gic: Stop using per-platform mapping tables
>   irqchip: mips-gic: Probe for number of external interrupts
>   irqchip: mips-gic: Use separate edge/level irq_chips
>   irqchip: mips-gic: Support local interrupts
>   irqchip: mips-gic: Remove unnecessary globals
...
>  drivers/irqchip/Kconfig                            |   4 +
>  drivers/irqchip/Makefile                           |   1 +
>  drivers/irqchip/irq-mips-gic.c                     | 597 +++++++++++++++++++++

It would be too much of a pia to have this go through irqchip, so

Acked-by: Jason Cooper <jason@lakedaemon.net>

Please make sure to add the Tested-by's, etc before merging through
mips.

thx,

Jason.
