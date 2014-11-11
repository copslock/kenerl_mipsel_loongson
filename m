Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 11:03:19 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:49469 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013355AbaKKKDRKj-yb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Nov 2014 11:03:17 +0100
Received: by mail.free-electrons.com (Postfix, from userid 106)
        id 74DB2746; Tue, 11 Nov 2014 11:03:19 +0100 (CET)
Received: from bbrezillon (col31-4-88-188-80-5.fbx.proxad.net [88.188.80.5])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 74226744;
        Tue, 11 Nov 2014 11:03:18 +0100 (CET)
Date:   Tue, 11 Nov 2014 11:03:08 +0100
From:   Boris Brezillon <boris.brezillon@free-electrons.com>
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, linux-sh@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        nicolas.ferre@atmel.com, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V4 04/14] genirq: Generic chip: Add big endian I/O
 accessors
Message-ID: <20141111110308.5bf7bbef@bbrezillon>
In-Reply-To: <20141110230301.GV4068@piout.net>
References: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
        <1415342669-30640-5-git-send-email-cernekee@gmail.com>
        <7hy4riogwt.fsf@deeprootsystems.com>
        <CAJiQ=7CYjy-sWc-M3m2Mg8si8JacpDH=RPPm8S-Q4m88wk3Sqg@mail.gmail.com>
        <20141110230301.GV4068@piout.net>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43980
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

Hi,

On Tue, 11 Nov 2014 00:03:01 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> Adding Boris in Cc: as he wrote that part.

Thanks for putting me in the loop.

> 
> On 10/11/2014 at 14:11:44 -0800, Kevin Cernekee wrote :
> > On Mon, Nov 10, 2014 at 2:00 PM, Kevin Hilman <khilman@kernel.org> wrote:
> > > Kevin Cernekee <cernekee@gmail.com> writes:
> > >
> > >> Use io{read,write}32be if the caller specified IRQ_GC_BE_IO when creating
> > >> the irqchip.
> > >>
> > >> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> > >
> > > I bisected a couple ARM boot failures in next-20141110 on atmel sama5 platforms down to
> > > this patch, though I'm not quite yet sure how it's causing the failure.
> > > I'm not getting any console output, so haven't been able to dig deeper
> > > yet.  Maybe the atmel maintainers (Cc'd) can help dig.
> > >
> > > I've confirmed that reverting $SUBJECT patch (commit
> > > b79055952badbd73710685643bab44104f2509ea2) on top of next-20141110 gets
> > > things booting again.
> > >
> > > Also, it only happens with sama5_defconfig, not with multi_v7_defconfig.
> > 
> > In drivers/irqchip/irq-atmel-aic-common.c I see:
> > 
> >         ret = irq_alloc_domain_generic_chips(domain, 32, 1, name,
> >                                              handle_level_irq, 0, 0,
> >                                              IRQCHIP_SKIP_SET_WAKE);
> > 
> > and IRQCHIP_SKIP_SET_WAKE is (1 << 4), same as IRQ_GC_BE_IO.
> > 
> > Is it possible that the caller is passing values intended for
> > irq_chip->flags into a function expecting
> > irq_domain_chip_generic->gc_flags ?

Indeed, I don't know what I tried to do in the first place but this is
completely wrong.
First because the last argument is not a valid flag as you pointed out,
then because I clearly have set irq_set_wake and thus setting
IRQCHIP_SKIP_SET_WAKE makes no sense.

I also realized I should directly pass handle_fasteoi_irq and not
handle_level_irq for the handler, that clr flags (IRQ_NOREQUEST |
IRQ_NOPROBE | IRQ_NOAUTOEN) are missing and that IRQ_GC_INIT_MASK_CACHE
is missing too.

I'll propose a patch fixing all those bugs.

Sorry for the inconvenience :-(.

Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
