Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4AHlDV07903
	for linux-mips-outgoing; Thu, 10 May 2001 10:47:13 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4AHlCF07900
	for <linux-mips@oss.sgi.com>; Thu, 10 May 2001 10:47:12 -0700
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f4AHka014392;
	Thu, 10 May 2001 10:46:36 -0700
Message-ID: <3AFAD368.9B70E1D5@mvista.com>
Date: Thu, 10 May 2001 10:44:08 -0700
From: Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en, bg
MIME-Version: 1.0
To: Wayne Gowcher <wgowcher@yahoo.com>
CC: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
   linux-mips@oss.sgi.com
Subject: Re: Configuration of PCI Video card on a BIOS-less board
References: <Pine.GSO.4.10.10105101919230.14224-100000@rose.sonytel.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Geert Uytterhoeven wrote:
> 
> On Thu, 10 May 2001, Pete Popov wrote:
> > Are you really trying to assign 0xC000 0000 to the card or was that just
> > an example address?  Unless your pci to memory window is such that
> > there's a translation that occurs, that address is incorrect.  If the
> > window is 1:1, the physical address 0xC000 0000 does not exist.  You
> > need to assign the card a real physical address; if your system has 32MB
> > of memory, than that address would have to be between 0 and 0x2000000.
> > (well, you can't give it address "0" because of interrupt vectors, but
> > you get the point). I can point you to some examples if you have
> > problems.
> 
> If you have 32 MB of RAM and you put a PCI card at an address between 0 and
> 0x2000000 you'll have a problem! PCI cards must not overlap with real memory.

Sorry Wayne, I'm working on an ethernet driver and was thinking of
descriptors and data buffers for PCI ethernet cards, which have to be in
real physical memory. Geert is right, but 0xC000 0000 still seems
suspicious.  That's a very high physical address and pci devices are
usually mapped at lower addresses. Something like 0x2000 0000 is more
reasonable and makes accessing the card through kseg1 possible. 

Pete
