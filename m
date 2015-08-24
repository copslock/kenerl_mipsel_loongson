Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Aug 2015 16:56:06 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:48064 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007257AbbHXO4FUeVm9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Aug 2015 16:56:05 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZTtAG-000616-6z; Mon, 24 Aug 2015 16:56:00 +0200
Date:   Mon, 24 Aug 2015 16:55:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@imgtec.com>
cc:     alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export gic_send_ipi
In-Reply-To: <55DB15EB.3090109@imgtec.com>
Message-ID: <alpine.DEB.2.11.1508241653200.3873@nanos>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com> <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com> <alpine.DEB.2.11.1508241447100.3873@nanos> <55DB15EB.3090109@imgtec.com>
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
X-archive-position: 49004
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
> On 08/24/2015 01:49 PM, Thomas Gleixner wrote:
> > On Mon, 24 Aug 2015, Qais Yousef wrote:
> > 
> > > Some drivers might require to send ipi to other cores. So export it.
> > Which IPIs do you need to send from a driver which are not exposed by
> > the SMP functions already?
> 
> It's not an SMP IPI. We use GIC to exchange interrupts between AXD and the
> host system since AXD is another MIPS core in the cluster.

So that should have been in the changelog to begin with.
 
> > > This will be used later by AXD driver.
> > That smells fishy and it wants a proper explanation WHY and not just a
> > sloppy statement that it will be used later. I can figure that out
> > myself as exporting a function without using it does not make any sense.
> 
> Sorry for the terse explanation. As pointed above AXD uses GIC to send and
> receive interrupts to the host core. Without this change I can't compile the
> driver as a driver module because the symbol is not exported.

Really? Exporting it solves that problem then. That's interesting news
for me.

Thanks,

	tglx
