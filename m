Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2008 11:43:54 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:22695 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20024673AbYFKKnw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jun 2008 11:43:52 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5BAhXax008197;
	Wed, 11 Jun 2008 11:43:33 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5BAhRHO008156;
	Wed, 11 Jun 2008 11:43:27 +0100
Date:	Wed, 11 Jun 2008 11:43:27 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Laird <daniel.j.laird@nxp.com>
Cc:	Florian Fainelli <florian.fainelli@telecomint.eu>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] : Add support for NXP PNX833x (STB222/5) into linux
	kernel
Message-ID: <20080611104327.GA777@linux-mips.org>
References: <64660ef00806060132j1aab8d9fh968cbf3f2fc56bc2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64660ef00806060132j1aab8d9fh968cbf3f2fc56bc2@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 06, 2008 at 09:32:15AM +0100, Daniel Laird wrote:

> > > +#if defined(CONFIG_SATA_PNX833X) || defined(CONFIG_SATA_PNX833X_MODULE)
> > > +static struct resource pnx833x_sata_resources[] = {
> > > +       [0] = {
> > > +               .start = PNX8335_SATA_PORTS_START,
> > > +               .end   = PNX8335_SATA_PORTS_END,
> > > +               .flags = IORESOURCE_MEM,
> > > +       },
> > > +       [1] = {
> > > +               .start = PNX8335_PIC_SATA_INT,
> > > +               .end   = PNX8335_PIC_SATA_INT,
> > > +               .flags = IORESOURCE_IRQ,
> > > +       },
> > > +};
> > > +
> > > +static struct platform_device pnx833x_sata_device = {
> > > +       .name          = "pnx833x-sata",
> > > +       .id            = -1,
> > > +       .num_resources = ARRAY_SIZE(pnx833x_sata_resources),
> > > +       .resource      = pnx833x_sata_resources,
> > > +};
> > > +#endif
> >
> > What about defining those resources anyway ?
> > > +
> > > +#if defined(CONFIG_MTD_NAND_PLATFORM) ||
> > > defined(CONFIG_MTD_NAND_PLATFORM_MODULE)
> >
> > Same here and others below too.
> >
> Is there any harm in having them always defined even if not
> implemented? I was playing safe.

You normally should register all platform devices based on their presence
on the platform without consideration of the drivers actually being enabled.
The Linux driver philosophy is that a driver can be enabled, compiled as
a module and loaded separately from the kernel build and the driver should
still be working.  That will only work if the driver and its resources are
always in - even at the (low!) price of being unused on a particular
platform.  It also helps tools that use sysfs to query hardware
configuration.

> > > +{
> > > +       printk(KERN_ALERT "\n\nSystem halted.\n\n");
> > > +
> > > +       while (1)
> > > +               __asm__ __volatile__ ("wait");
> > > +}
> >
> > You might want to use cpu_relax(); instead of the assembly wait instruction.
> >
> Sounds good.

Almost.   cpu_relax() is defined to just barrier() on MIPS since there
isn't really very much we could or need to do in tight loop - unlike the
infamous Pentium 4 netburst architecture which burns serious amounts of
power in such a loop.

So best keep it as it is for now.  The issue deserves a better solution
though but that's beyond the scope of your patch.

> > > +void pnx833x_machine_power_off(void)
> > > +{
> > > +       printk(KERN_ALERT "\n\nPower off not implemented.");
> > > +       pnx833x_machine_halt();
> > > +}
> >
> > And put some less alarming message here, like "*** You can safely turn off the
> > board".

No message at all.  It's userspace which is supposed to communicate with the
user not the kernel.

  Ralf
