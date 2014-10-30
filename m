Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 11:43:07 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:43846 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011905AbaJ3KnGJnpEO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 11:43:06 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1XjnC2-0001kX-4C; Thu, 30 Oct 2014 11:43:02 +0100
Date:   Thu, 30 Oct 2014 11:43:00 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Kevin Cernekee <cernekee@gmail.com>, f.fainelli@gmail.com,
        jason@lakedaemon.net, ralf@linux-mips.org, lethal@linux-sh.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 02/15] sh: Eliminate unused irq_reg_{readl,writel}
 accessors
In-Reply-To: <2294092.AHz8W66sEP@wuerfel>
Message-ID: <alpine.DEB.2.11.1410301142010.5308@nanos>
References: <1414635488-14137-1-git-send-email-cernekee@gmail.com> <1414635488-14137-3-git-send-email-cernekee@gmail.com> <2294092.AHz8W66sEP@wuerfel>
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
X-archive-position: 43770
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

On Thu, 30 Oct 2014, Arnd Bergmann wrote:

> On Wednesday 29 October 2014 19:17:55 Kevin Cernekee wrote:
> > Defining these macros way down in arch/sh/.../irq.c doesn't cause
> > kernel/irq/generic-chip.c to use them.  As far as I can tell this code
> > has no effect.
> > 
> > Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> 
> Actually it overrides the 32-bit accessors with 16-bit accessors,
> which does seem intentional and certainly has an effect.

Not really. Neither arch/sh/boards/mach-se/7343/irq.c nor
arch/sh/boards/mach-se/7722/irq.c actually use
irq_reg_readl/writel. They simply define it.
 
Thanks,

	tglx
