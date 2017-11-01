Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2017 17:59:39 +0100 (CET)
Received: from Galois.linutronix.de ([IPv6:2a01:7a0:2:106d:700::1]:42786 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992910AbdKAQ7c40Nfn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Nov 2017 17:59:32 +0100
Received: from p4fea49b2.dip0.t-ipconnect.de ([79.234.73.178] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1e9wLz-0004C1-Hj; Wed, 01 Nov 2017 17:58:59 +0100
Date:   Wed, 1 Nov 2017 17:59:23 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paul Burton <paul.burton@mips.com>
cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] irqchip: mips-gic: Cleanups, fixes, prep for
 multi-cluster
In-Reply-To: <20171101164047.4ascutd7tkoaxtjp@pburton-laptop>
Message-ID: <alpine.DEB.2.20.1711011758170.1942@nanos>
References: <867evc5cc9.fsf@arm.com> <20171031164151.6357-1-paul.burton@mips.com> <86efpi3lgj.fsf@arm.com> <20171101164047.4ascutd7tkoaxtjp@pburton-laptop>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60634
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

On Wed, 1 Nov 2017, Paul Burton wrote:

> Hi Marc,
> 
> On Wed, Nov 01, 2017 at 12:13:16AM +0000, Marc Zyngier wrote:
> > On Tue, Oct 31 2017 at  9:41:43 am GMT, Paul Burton <paul.burton@mips.com> wrote:
> > > This series continues cleaning & fixing up the MIPS GIC irqchip driver
> > > whilst laying groundwork to support multi-cluster systems.
> 
> <SNIP>
> 
> > Are those targeting 4.14 or 4.15? It is getting quite late for the
> > former, and it doesn't seem to cleanly apply on tip/irq/core (or my
> > irqchip-4.15 branch) if that's for the latter (patch 6 shouts at me).
> 
> Whichever you're happiest with. If you'd like me to rebase them & resubmit
> that's fine.
> 
> I see the conflict with patch 6 atop tip/irq/core - it's because tip/irq/core
> is based upon v4.14-rc2 which doesn't have commit a08588ea486a
> ("irqchip/mips-gic: Fix shifts to extract register fields") that went into
> v4.14-rc3. The correct resolution is to keep the patches version of things (ie.
> delete the block of code).

Marc, simply merge current linus into your branch with the reason:

      Pick up upstream fixes so dependent patches apply

Thanks,

	tglx
