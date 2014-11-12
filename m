Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 10:44:10 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:57419 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013490AbaKLJnvakrsH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 10:43:51 +0100
Received: by mail.free-electrons.com (Postfix, from userid 106)
        id 156EB74C; Wed, 12 Nov 2014 10:43:47 +0100 (CET)
Received: from bbrezillon (col31-4-88-188-83-94.fbx.proxad.net [88.188.83.94])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 151DE746;
        Wed, 12 Nov 2014 10:43:46 +0100 (CET)
Date:   Wed, 12 Nov 2014 10:43:42 +0100
From:   Boris Brezillon <boris.brezillon@free-electrons.com>
To:     Jason Cooper <jason@lakedaemon.net>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-sh@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>, linux-mips@linux-mips.org,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] irqchip: atmel-aic: fix irqdomain initialization
Message-ID: <20141112104342.3d28ad46@bbrezillon>
In-Reply-To: <20141111225800.GE3698@titan.lakedaemon.net>
References: <20141110230301.GV4068@piout.net>
        <1415712816-9202-1-git-send-email-boris.brezillon@free-electrons.com>
        <20141111225800.GE3698@titan.lakedaemon.net>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boris.brezillon@free-electrons.com
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

Hi Jason,

On Tue, 11 Nov 2014 17:58:00 -0500
Jason Cooper <jason@lakedaemon.net> wrote:

> On Tue, Nov 11, 2014 at 02:33:36PM +0100, Boris Brezillon wrote:
> > First of all IRQCHIP_SKIP_SET_WAKE is not a valid irq_gc_flags and thus
> > should not be passed as the last argument of
> > irq_alloc_domain_generic_chips.
> > 
> > Then pass the correct handler (handle_fasteoi_irq) to
> > irq_alloc_domain_generic_chips instead of manually re-setting it in the
> > initialization loop.
> > 
> > And eventually initialize default irq flags to the pseudo standard:
> > IRQ_REQUEST | IRQ_PROBE | IRQ_AUTOEN.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> > Hello Kevin,
> > 
> > This patch has not been tested yet but it should solve the issue you've
> > experienced with the IRQ_GC_BE_IO flag and the atmel-aic driver.
> > 
> > I'll test it tomorrow and let you know if it actually works.

Tested it, and it seems to work.

> > 
> > Regards,
> > 
> > Boris
> > 
> >  drivers/irqchip/irq-atmel-aic-common.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Applied to irqchip/urgent with Kevin's Tested-by.  Also, flagged for
> stable, v3.17 and up.

Thanks!

> 
> Boris, once this is in mainline, you may want to generate a patch
> against older versions (in the arch dir) for the stable team.

Actually, the old irq driver does not use the generic irqchip
infrastructure and thus is not impacted by this bug.

Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
