Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBJN39Q07994
	for linux-mips-outgoing; Wed, 19 Dec 2001 15:03:09 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBJN36X07991
	for <linux-mips@oss.sgi.com>; Wed, 19 Dec 2001 15:03:06 -0800
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fBJM2MB15854;
	Wed, 19 Dec 2001 14:02:22 -0800
Subject: Re: kmalloc/pci_alloc and skbuff's
From: Pete Popov <ppopov@mvista.com>
To: Geoffrey Espin <espin@idiom.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <20011219135615.A3709@idiom.com>
References: <3C205853.EE642541@niisi.msk.ru>
	<Pine.LNX.4.10.10112190903520.3562-100000@www.transvirtual.com>
	<20011219105633.B54722@idiom.com> <1008789145.31066.140.camel@zeus>
	<20011219115318.A12344@idiom.com> <1008796988.31046.150.camel@zeus> 
	<20011219135615.A3709@idiom.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 19 Dec 2001 14:06:23 -0800
Message-Id: <1008799583.1378.1.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 2001-12-19 at 13:56, Geoffrey Espin wrote:
> > > Can one include one's own arch/mips/korva/skbuff.c?
> > > But with network.o being a monolithic blob .o instead of a .a,
> 
> I figured someone might have some magic for hacking
> arch/mips/Makefile ifdef CONFIG_NEC_KORVA (or any BSP/LSP).
> I guess I'll have to make the effort.  :-)
> 
> > > Or will linux-mips.sf.net accept a patch for net/core/skbuff.c?
> > Up the the maintainer, but it's really not the right fix so I think it's
> > best for you or your customer to keep that patch locally.
> 
> I talked Jun into checking in the Markham patches... but will
> have to add a comment to the pci_xxx files that one has to get
> a separate patch for net/core/skbuff.c if using PCI with a generic
> driver.
> 
> > Another approach would be for you to preallocate your network buffers in
> > your driver, attach them permanently to the rx/tx descriptors, and then
> 
> The idea was not to mess with any PCI drivers. 2.5 is not an option for me.

Sorry, that was a bad suggestion.  I was thinking of an ethernet driver
that's part of your SOC and requires a new ethernet driver anyway. 
Otherwise, messing with all the pci ethernet drivers is definitely not
an option.

Pete
