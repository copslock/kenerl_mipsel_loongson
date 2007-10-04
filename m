Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2007 14:03:22 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:11459 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024220AbXJDNDT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Oct 2007 14:03:19 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l94D3ISH006638;
	Thu, 4 Oct 2007 14:03:18 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l94D3I6w006637;
	Thu, 4 Oct 2007 14:03:18 +0100
Date:	Thu, 4 Oct 2007 14:03:18 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] enable PCI bridges in MIPS ip32
Message-ID: <20071004130318.GC28928@linux-mips.org>
References: <E1IdO0a-0000n7-Cg@eppesuigoccas.homedns.org> <Pine.LNX.4.64N.0710041316000.10573@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0710041316000.10573@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 04, 2007 at 01:27:47PM +0100, Maciej W. Rozycki wrote:

> On Thu, 4 Oct 2007, Giuseppe Sacco wrote:
> 
> > I managed to create a patch against current 2.6.23-rc9 git tree
> > for supporting PCI bridges on SGI ip32 machines.
> > This is my first kernel patch, so I am usure about the correct way
> > to send a patch. Please let me know if anything is wrong.
> 
>  I am glad you have succeeded.  A couple of minor notes below.
> 
> > @@ -31,20 +31,21 @@
> >  
> >  #define chkslot(_bus,_devfn)					\
> >  do {							        \
> > -	if ((_bus)->number > 0 || PCI_SLOT (_devfn) < 1	\
> > -	    || PCI_SLOT (_devfn) > 3)			        \
> > +	if ((_bus)->number > 1 ||                               \
> > +		((_bus)->number == 0 && (PCI_SLOT (_devfn) < 1  \
> > +	    	|| PCI_SLOT (_devfn) > 3)))		        \
> >  		return PCIBIOS_DEVICE_NOT_FOUND;		\
> 
>  I think you should allow any bus numbers, not only 0 and 1 -- while 
> possibly unlikely, you may have a tree of bridges on an option card.  The 
> generic code should handle it fine -- you need not care.

I think historically we had something like chkslot() first in the code
for the Galileo/Marvell bridges where it's needed due the brainddead
abuse of device 31 - any access to that will crash the system.  From that
point on chkslot checking spread across the PCI code like the measles in
a kindergarden.

Another stylistic comment is about the return statement in the macro.
That sort of construct should be avoided, it's quite unobvious to the
reader who isn't familiar with the macro definition.

Another thing the historically extremly widespread use of macros in the
Linux kernel.  Macros tend to be harder to read and maintain but
historically gcc was doing a rather bad job at optimizing inline functions
because inlining happend rather late in the compilation process when many
of the optimizations already had been performed.  That is no longer true
for modern gcc so these days functions are prefered.  So adding this all
up:

static inline int chkslot(struct pci_bus *bus, unsigned int devfn)
{
	return bus->number > 1 ||
	       (bus->number == 0 && (PCI_SLOT(devfn) < 1 ||
		PCI_SLOT(devfn) > 3));
}

static inline int mkaddr(struct pci_bus *bus, unsigned int devfn,
	unsigned int reg)
{
	return ((bus->number & 0xff) << 16) |
	       ((devfn & 0xff) << 8) |
	       (reg & 0xfc);
}

static int
mace_pci_read_config(struct pci_bus *bus, unsigned int devfn,
                     int reg, int size, u32 *val)
{
	if (chkslot(bus, devfn)
		return PCIBIOS_DEVICE_NOT_FOUND;

	mace->pci.config_addr = mkaddr(bus, devfn, reg);
[...]

(of course this all goes far beyond Giuseppe's patch - but the whole
ops-mace.c file like so much of the other code in arch/mips/pci isn't
exactly an example to be copied.

Ah, one final formality - when sending a patch please add a
Signed-off-by: line.  See Documentation/SubmittingPatches in the kernel
tree for what this means.

So Giuseppe, I'm happy to apply your patch because it makes sense and
doesn't add new badness.

Cheers,

  Ralf
