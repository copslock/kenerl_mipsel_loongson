Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Aug 2015 17:07:47 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:48114 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007260AbbHXPHpCDuE9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Aug 2015 17:07:45 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZTtLY-00066R-Dv; Mon, 24 Aug 2015 17:07:40 +0200
Date:   Mon, 24 Aug 2015 17:07:13 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@imgtec.com>
cc:     Marc Zyngier <marc.zyngier@arm.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export gic_send_ipi
In-Reply-To: <55DB29B5.3010202@imgtec.com>
Message-ID: <alpine.DEB.2.11.1508241656280.3873@nanos>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com> <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com> <alpine.DEB.2.11.1508241447100.3873@nanos> <55DB15EB.3090109@imgtec.com> <55DB1CD2.5030300@arm.com>
 <55DB29B5.3010202@imgtec.com>
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
X-archive-position: 49005
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

On Mon, 24 Aug 2015, Qais Yousef wrote:
> On 08/24/2015 02:32 PM, Marc Zyngier wrote:
> > I'd rather see something more "architected" than this blind export, or
> > at least some level of filtering (the idea random drivers can access
> > such a low-level function doesn't make me feel very good).
> 
> I don't know how to architect this better or how to perform  the filtering,
> but I'm happy to hear suggestions and try them out.
> Keep in mind that detecting GIC and writing your own gic_send_ipi() is very
> simple. I have done this when the driver was out of tree. So restricting it by
> not exporting it will not prevent someone from really accessing the
> functionality, it's just they have to do it their own way.

Keep in mind that we are not talking about out of tree hackery. We
talk about a kernel code submission and I doubt, that you will get
away with a GIC detection/fiddling burried in your driver code.

Keep in mind that just slapping an export to some random function is
not much better than doing a GIC hack in the driver.

Marcs concerns about blindly exposing IPI functionality to drivers is
well justified and that kind of coprocessor stuff is not unique to
your particular SoC. We're going to see such things more frequently in
the not so distant future, so we better think now about proper
solutions to that problem.

There are a couple of issues to solve:

1) How is the IPI which is received by the coprocessor reserved in the
   system?

2) How is it associated to a particular driver?

3) How do we ensure that a driver cannot issue random IPIs and can
   only send the associated ones?

None of these issues are handled by your export.

So we need a core infrastructure which allows us to do that. The
requirements are pretty clear from the above and Marc might have some
further restrictions in mind.

Thanks,

	tglx
