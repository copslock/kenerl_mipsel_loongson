Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2003 19:15:12 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:50927 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225207AbTGaSPK>;
	Thu, 31 Jul 2003 19:15:10 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h6VIF6Z07582;
	Thu, 31 Jul 2003 11:15:06 -0700
Date: Thu, 31 Jul 2003 11:15:06 -0700
From: Jun Sun <jsun@mvista.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: Malta + USB on 2.4, anyone?
Message-ID: <20030731111506.F14914@mvista.com>
References: <20030730191219.A14914@mvista.com> <Pine.GSO.3.96.1030731121705.17497D-100000@delta.ds2.pg.gda.pl> <20030731103629.D14914@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030731103629.D14914@mvista.com>; from jsun@mvista.com on Thu, Jul 31, 2003 at 10:36:29AM -0700
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, Jul 31, 2003 at 10:36:29AM -0700, Jun Sun wrote:
> On Thu, Jul 31, 2003 at 12:26:44PM +0200, Maciej W. Rozycki wrote:
> > On Wed, 30 Jul 2003, Jun Sun wrote:
> > 
> > > Has anybody tried USB on malta with 2.4 kernel?  I just found that
> > > I got 0xff IRQ number and kernel panics.
> > 
> >  Possibly IRQ routing is broken -- the PIIX4 uses INTD for its USB
> > controller's interrupt.  For the Malta it should be routed to the IRQ11
> > input of the PIIX4's internal dual-8259A PIC.  What does `/sbin/lspci -vv
> > -s 00:0a.2' print?
> >
> 
> The output seems to say the same thing:
> 
> root@10.0.18.6:~# lspci -vv -s 00:0a.2                                          
> 00:0a.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00
>  [UHCI])                                                                        
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
> ping- SERR- FastB2B-                                                            
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort
> - <MAbort- >SERR- <PERR-                                                        
>         Latency: 32                                                             
>         Interrupt: pin D routed to IRQ 11                                       
>         Region 4: I/O ports at 1220 [size=32]                                   
> 

Using the alternative JE driver sovles the problem.  

I suspect the main UHCI driver does not get cache flushing
or bus/virt address right.


Jun
