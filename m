Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 10:04:40 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.17.24]:52311 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011905AbaJ3JEeehE6S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 10:04:34 +0100
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue101) with ESMTP (Nemesis)
        id 0LfRd3-1YP5km0gfZ-00p7l1; Thu, 30 Oct 2014 10:04:25 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Brian Norris <computersforpeace@gmail.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>, f.fainelli@gmail.com,
        tglx@linutronix.de, jason@lakedaemon.net, ralf@linux-mips.org,
        lethal@linux-sh.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH V2 06/15] genirq: Generic chip: Optimize for fixed-endian systems
Date:   Thu, 30 Oct 2014 10:04:24 +0100
Message-ID: <2089348.fa41ONzNz9@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <20141030041658.GB29070@brian-ubuntu>
References: <1414635488-14137-1-git-send-email-cernekee@gmail.com> <1414635488-14137-7-git-send-email-cernekee@gmail.com> <20141030041658.GB29070@brian-ubuntu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:V9cRYoCTU+oVFZW3xLwNHYpCAX2OqEvA0Zh4+nxWtAZ
 ervurGLunJufnbQkmHnNE6bq/mr2D2sbK7nirW84Y6RS6vV6GF
 H48tv+MY/Ga6ljevDUvdTaEfzWGXVqHSwaOtTQSlNh/BRtW13D
 l7LA9V1hXUNOLjRiPi96Zs8bPLV2t2bJLILjZxMU4e0F2BKSQp
 3lrLuuzChcaoEl/Aupo/rhdMBLGw6D1ejXn9iE8KuoirHoPIs4
 ow0NdeYAqt3/SIZqKtQknZvlREveCpMvLXR8G4zNwuWea68eUu
 s5ZPKsGmEGTHXZVlF5oAY/LFlS7m6leZus64aotFZwdQAPsjub
 h0ZxC2GKv8CsxlyvgznE=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43759
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

On Wednesday 29 October 2014 21:16:58 Brian Norris wrote:
> >  static int is_big_endian(struct irq_chip_generic *gc)
> >  {
> > -     return !!(gc->domain->gc->gc_flags & IRQ_GC_BE_IO);
> > +     if (IS_ENABLED(CONFIG_GENERIC_IRQ_CHIP) &&
> > +         !IS_ENABLED(CONFIG_GENERIC_IRQ_CHIP_BE))
> > +             return 0;
> > +     else if (IS_ENABLED(CONFIG_GENERIC_IRQ_CHIP_BE) &&
> > +              !IS_ENABLED(CONFIG_GENERIC_IRQ_CHIP))
> > +             return 1;
> 
> Would XOR make this any easier to read? e.g.:
> 
>         if (IS_ENABLED(CONFIG_GENERIC_IRQ_CHIP) ^
>             IS_ENABLED(CONFIG_GENERIC_IRQ_CHIP_BE))
>                 return IS_ENABLED(CONFIG_GENERIC_IRQ_CHIP_BE);
>         else
>                 ...
> 

I think that would only be easier to read for the compiler, not for
for a human. ;-)

	Arnd
