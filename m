Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 00:03:11 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:47375 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013146AbaKJXDI406Bt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Nov 2014 00:03:08 +0100
Received: by mail.free-electrons.com (Postfix, from userid 106)
        id 3AF9E745; Tue, 11 Nov 2014 00:03:10 +0100 (CET)
Received: from localhost (128-79-216-6.hfc.dyn.abo.bbox.fr [128.79.216.6])
        by mail.free-electrons.com (Postfix) with ESMTPSA id E891E743;
        Tue, 11 Nov 2014 00:03:09 +0100 (CET)
Date:   Tue, 11 Nov 2014 00:03:01 +0100
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
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
        Arnd Bergmann <arnd@arndb.de>,
        Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH V4 04/14] genirq: Generic chip: Add big endian I/O
 accessors
Message-ID: <20141110230301.GV4068@piout.net>
References: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
 <1415342669-30640-5-git-send-email-cernekee@gmail.com>
 <7hy4riogwt.fsf@deeprootsystems.com>
 <CAJiQ=7CYjy-sWc-M3m2Mg8si8JacpDH=RPPm8S-Q4m88wk3Sqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJiQ=7CYjy-sWc-M3m2Mg8si8JacpDH=RPPm8S-Q4m88wk3Sqg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@free-electrons.com
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

Adding Boris in Cc: as he wrote that part.

On 10/11/2014 at 14:11:44 -0800, Kevin Cernekee wrote :
> On Mon, Nov 10, 2014 at 2:00 PM, Kevin Hilman <khilman@kernel.org> wrote:
> > Kevin Cernekee <cernekee@gmail.com> writes:
> >
> >> Use io{read,write}32be if the caller specified IRQ_GC_BE_IO when creating
> >> the irqchip.
> >>
> >> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> >
> > I bisected a couple ARM boot failures in next-20141110 on atmel sama5 platforms down to
> > this patch, though I'm not quite yet sure how it's causing the failure.
> > I'm not getting any console output, so haven't been able to dig deeper
> > yet.  Maybe the atmel maintainers (Cc'd) can help dig.
> >
> > I've confirmed that reverting $SUBJECT patch (commit
> > b79055952badbd73710685643bab44104f2509ea2) on top of next-20141110 gets
> > things booting again.
> >
> > Also, it only happens with sama5_defconfig, not with multi_v7_defconfig.
> 
> In drivers/irqchip/irq-atmel-aic-common.c I see:
> 
>         ret = irq_alloc_domain_generic_chips(domain, 32, 1, name,
>                                              handle_level_irq, 0, 0,
>                                              IRQCHIP_SKIP_SET_WAKE);
> 
> and IRQCHIP_SKIP_SET_WAKE is (1 << 4), same as IRQ_GC_BE_IO.
> 
> Is it possible that the caller is passing values intended for
> irq_chip->flags into a function expecting
> irq_domain_chip_generic->gc_flags ?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
