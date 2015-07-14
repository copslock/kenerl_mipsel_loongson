Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 11:02:46 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45136 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009266AbbGNJCoE0t7x (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Jul 2015 11:02:44 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t6E92ghv026289;
        Tue, 14 Jul 2015 11:02:42 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t6E92eAp026288;
        Tue, 14 Jul 2015 11:02:40 +0200
Date:   Tue, 14 Jul 2015 11:02:40 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [patch 08/12] MIPS/alchemy: Remove pointless irqdisable/enable
Message-ID: <20150714090239.GO21180@linux-mips.org>
References: <20150713200602.799079101@linutronix.de>
 <20150713200715.113667554@linutronix.de>
 <CAOLZvyEEzWRU2RoMODPg13TMgi9jLGOUmp=AuBUA230KmgKODQ@mail.gmail.com>
 <alpine.DEB.2.11.1507141012360.20072@nanos>
 <CAOLZvyHxZdphtT6rw73=J-_HnFueNcmtxMCHZ-K=JsJt+UHKkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLZvyHxZdphtT6rw73=J-_HnFueNcmtxMCHZ-K=JsJt+UHKkg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Jul 14, 2015 at 10:55:08AM +0200, Manuel Lauss wrote:

> On Tue, Jul 14, 2015 at 10:16 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Tue, 14 Jul 2015, Manuel Lauss wrote:
> >
> >> On Mon, Jul 13, 2015 at 10:46 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >> > bcsr_csc_handler() is a cascading interrupt handler. It has a
> >> > disable_irq_nosync()/enable_irq() pair around the generic_handle_irq()
> >> > call. The value of this disable/enable is zero because its a complete
> >> > noop:
> >> >
> >> > disable_irq_nosync() merily increments the disable count without
> >> > actually masking the interrupt. enable_irq() soleley decrements the
> >> > disable count without touching the interrupt chip. The interrupt
> >> > cannot arrive again because the complete call chain runs with
> >> > interrupts disabled.
> >> >
> >> > Remove it.
> >>
> >> Is there another patch this one depends on?  The DB1300 board doesn't
> >
> > No.
> >
> >> boot (i.e. interrupts from the cpld aren't serviced) with this patch applied:
> >> (irq 136 is the first serviced by the bcsr cpld):
> >>
> >> irq 136: nobody cared (try booting with the "irqpoll" option)
> >
> > That's weird. Looking deeper, enable_irq() actually calls
> > chip->unmask() unconditionally. So it seems the chip is sensitive to
> > that.
> >
> > Does the following patch on top fix things again?
> >
> > Thanks,
> >
> >         tglx
> > ----
> > diff --git a/arch/mips/alchemy/devboards/bcsr.c b/arch/mips/alchemy/devboards/bcsr.c
> > index 3a24f2d6ecfd..ec47abe580c6 100644
> > --- a/arch/mips/alchemy/devboards/bcsr.c
> > +++ b/arch/mips/alchemy/devboards/bcsr.c
> > @@ -88,8 +88,11 @@ EXPORT_SYMBOL_GPL(bcsr_mod);
> >  static void bcsr_csc_handler(unsigned int irq, struct irq_desc *d)
> >  {
> >         unsigned short bisr = __raw_readw(bcsr_virt + BCSR_REG_INTSTAT);
> > +       struct irq_chip *chip = irq_desc_get_chip(d);
> >
> > +       chained_irq_enter(chip, d);
> >         generic_handle_irq(bcsr_csc_base + __ffs(bisr));
> > +       chained_irq_exit(chip, d);
> >  }
> >
> >  static void bcsr_irq_mask(struct irq_data *d)
> 
> 
> Yes.  Add #include <linux/irqchip/chained_irq.h> on top and it works again.
> This hardware is problematic, an older variant with identical verilog
> code in the cpld's
> irq unit works fine without this.

So shall I merge both patches and the header file change together or?

  Ralf
