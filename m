Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2003 18:06:49 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:53938 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225425AbTIRRGq>;
	Thu, 18 Sep 2003 18:06:46 +0100
Received: from drow by nevyn.them.org with local (Exim 4.22 #1 (Debian))
	id 1A02Es-0005vc-OA; Thu, 18 Sep 2003 13:06:42 -0400
Date: Thu, 18 Sep 2003 13:06:42 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: ddb5477 fixes for 2.6
Message-ID: <20030918170642.GA22753@nevyn.them.org>
References: <20030918163344.GA22013@nevyn.them.org> <Pine.GSO.3.96.1030918185742.20533A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030918185742.20533A-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 18, 2003 at 07:04:43PM +0200, Maciej W. Rozycki wrote:
> On Thu, 18 Sep 2003, Daniel Jacobowitz wrote:
> 
> > --- arch/mips/pci/pci.c	22 Jun 2003 23:09:48 -0000	1.3
> > +++ arch/mips/pci/pci.c	18 Sep 2003 16:25:08 -0000
> > @@ -66,6 +66,8 @@
> >  extern void pcibios_fixup(void);
> >  extern void pcibios_fixup_irqs(void);
> >  
> > +#if 0
> > +
> >  void __init pcibios_fixup_irqs(void)
> >  {
> >  	struct pci_dev *dev = NULL;
> > @@ -126,6 +128,8 @@ void __init pcibios_fixup_resources(stru
> >  	}
> >  
> >  }
> > +
> > +#endif
> >  
> >  struct pci_fixup pcibios_fixups[] = {
> >  	{PCI_FIXUP_HEADER, PCI_ANY_ID, PCI_ANY_ID,
> 
>  Is it OK for other PCI systems?

Yes, I think so.  Those two functions seem to have migrated in from
pci-hplj.c; they can't possibly compile, since they use constants only
defined in that file.

> > --- include/asm-mips/addrspace.h	9 Aug 2003 21:16:38 -0000	1.11
> > +++ include/asm-mips/addrspace.h	18 Sep 2003 16:25:13 -0000
> > @@ -75,14 +75,14 @@
> >   * The compatibility segments use the full 64-bit sign extended value.  Note
> >   * the R8000 doesn't have them so don't reference these in generic MIPS code.
> >   */
> > -#define XKUSEG			0x0000000000000000
> > -#define XKSSEG			0x4000000000000000
> > -#define XKPHYS			0x8000000000000000
> > -#define XKSEG			0xc000000000000000
> > -#define CKSEG0			0xffffffff80000000
> > -#define CKSEG1			0xffffffffa0000000
> > -#define CKSSEG			0xffffffffc0000000
> > -#define CKSEG3			0xffffffffe0000000
> > +#define XKUSEG			0x0000000000000000ULL
> > +#define XKSSEG			0x4000000000000000ULL
> > +#define XKPHYS			0x8000000000000000ULL
> > +#define XKSEG			0xc000000000000000ULL
> > +#define CKSEG0			0xffffffff80000000ULL
> > +#define CKSEG1			0xffffffffa0000000ULL
> > +#define CKSSEG			0xffffffffc0000000ULL
> > +#define CKSEG3			0xffffffffe0000000ULL
> >  
> >  /*
> >   * Cache modes for XKPHYS address conversion macros
> 
>  Why do you want these suffixes?  They don't work for assembly sources.

Because otherwise uses of XKPHYS in a 32-bit kernel generate noisy
warnings.  I don't remember where it was offhand.  Wrap it in
__ASSEMBLY__ if you like.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
