Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBJMuNu06711
	for linux-mips-outgoing; Wed, 19 Dec 2001 14:56:23 -0800
Received: from idiom.com (espin@idiom.com [216.240.32.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBJMuKX06708
	for <linux-mips@oss.sgi.com>; Wed, 19 Dec 2001 14:56:20 -0800
Received: (from espin@localhost)
	by idiom.com (8.9.3/8.9.3) id NAA15148;
	Wed, 19 Dec 2001 13:56:15 -0800 (PST)
Date: Wed, 19 Dec 2001 13:56:15 -0800
From: Geoffrey Espin <espin@idiom.com>
To: Pete Popov <ppopov@mvista.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: kmalloc/pci_alloc and skbuff's
Message-ID: <20011219135615.A3709@idiom.com>
References: <3C205853.EE642541@niisi.msk.ru> <Pine.LNX.4.10.10112190903520.3562-100000@www.transvirtual.com> <20011219105633.B54722@idiom.com> <1008789145.31066.140.camel@zeus> <20011219115318.A12344@idiom.com> <1008796988.31046.150.camel@zeus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <1008796988.31046.150.camel@zeus>; from Pete Popov on Wed, Dec 19, 2001 at 01:23:08PM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> > Can one include one's own arch/mips/korva/skbuff.c?
> > But with network.o being a monolithic blob .o instead of a .a,

I figured someone might have some magic for hacking
arch/mips/Makefile ifdef CONFIG_NEC_KORVA (or any BSP/LSP).
I guess I'll have to make the effort.  :-)

> > Or will linux-mips.sf.net accept a patch for net/core/skbuff.c?
> Up the the maintainer, but it's really not the right fix so I think it's
> best for you or your customer to keep that patch locally.

I talked Jun into checking in the Markham patches... but will
have to add a comment to the pci_xxx files that one has to get
a separate patch for net/core/skbuff.c if using PCI with a generic
driver.

> Another approach would be for you to preallocate your network buffers in
> your driver, attach them permanently to the rx/tx descriptors, and then

The idea was not to mess with any PCI drivers. 2.5 is not an option for me.

Thanks, Pete.

Geoff
-- 
Geoffrey Espin espin@idiom.com
