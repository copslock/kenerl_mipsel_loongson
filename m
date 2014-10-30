Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 11:48:53 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.131]:60231 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011905AbaJ3Ksupsgfq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 11:48:50 +0100
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue002) with ESMTP (Nemesis)
        id 0LpTKI-1YFFwL1AYw-00fVpt; Thu, 30 Oct 2014 11:48:19 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kevin Cernekee <cernekee@gmail.com>, f.fainelli@gmail.com,
        jason@lakedaemon.net, ralf@linux-mips.org, lethal@linux-sh.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 02/15] sh: Eliminate unused irq_reg_{readl,writel} accessors
Date:   Thu, 30 Oct 2014 11:48:18 +0100
Message-ID: <1879572.mbc2eHiUuo@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <alpine.DEB.2.11.1410301142010.5308@nanos>
References: <1414635488-14137-1-git-send-email-cernekee@gmail.com> <2294092.AHz8W66sEP@wuerfel> <alpine.DEB.2.11.1410301142010.5308@nanos>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:spn7xC786tUw4V0VRLuP4GakLOUvMvva3RlpnTjZlaA
 p3aogCK0hSgM15+vhy6WquiQYNvhVErJGa5W2Rfc6wwr6m/1ex
 QQrsOyAl0T7h+K8XK12/XIhGYyQeu3mJB8u9zRRX5R3wK6o35X
 AYIRBkDfspkzioD+BNsiYTZodNS5Ck2d2vMN/4AgiN9w+jUO+/
 ZW8MRUmrkMsh9S0fnUqlLYwVc02bO80m9ShxP6IcZOZx0wZwwR
 njHk2io1wZKZUzm6R7HlpNDg/7R0kQarinzEGld7ZmKK8bJXyj
 +KIMzqFK1Ob1NJ0Y/IC0LJ17NhXji8WjN6Qp2QDWQEEqUirOPl
 EBJw5LzvDJdeSm7HfrDA=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Thursday 30 October 2014 11:43:00 Thomas Gleixner wrote:
> On Thu, 30 Oct 2014, Arnd Bergmann wrote:
> 
> > On Wednesday 29 October 2014 19:17:55 Kevin Cernekee wrote:
> > > Defining these macros way down in arch/sh/.../irq.c doesn't cause
> > > kernel/irq/generic-chip.c to use them.  As far as I can tell this code
> > > has no effect.
> > > 
> > > Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> > 
> > Actually it overrides the 32-bit accessors with 16-bit accessors,
> > which does seem intentional and certainly has an effect.
> 
> Not really. Neither arch/sh/boards/mach-se/7343/irq.c nor
> arch/sh/boards/mach-se/7722/irq.c actually use
> irq_reg_readl/writel. They simply define it.

Ah, that makes things easier. I looked at the commits that introduced
them, and even then they were unused. Probably an artifact from an
earlier version of the patch which did not get merged.

	Arnd
