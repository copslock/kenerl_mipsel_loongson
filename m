Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4AHE3h06453
	for linux-mips-outgoing; Thu, 10 May 2001 10:14:03 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4AHE2F06450
	for <linux-mips@oss.sgi.com>; Thu, 10 May 2001 10:14:02 -0700
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f4AHE2011951;
	Thu, 10 May 2001 10:14:02 -0700
Message-ID: <3AFACBC8.DE85A67E@mvista.com>
Date: Thu, 10 May 2001 10:11:36 -0700
From: Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en, bg
MIME-Version: 1.0
To: Wayne Gowcher <wgowcher@yahoo.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Configuration of PCI Video card on a BIOS-less board
References: <20010510055512.96321.qmail@web11902.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Wayne Gowcher wrote:
> 
> Dear All,
> 
> I was wondering if anyone has any experience in
> configuring the PCI registers in a PCI Video Card on a
> MIPS board that has no BIOS like in a PC.
> 
> At the moment when I have some "home grown" PCI
> probing routines based on my best interpretation of
> the PCI spec. But it's not working.
> 
> I can probe the Base Address Register successfully,
> determine the cards memory requirement and that it is
> memory rather than mapped IO. But when I try to write
> the address I have allocated to the PCI card ( eg
> 0xC000 0000 ) the address will not latch in the base
> address register.
> 
> The card is designed for x86 PCs and when the PC bios
> configures the card, the base address register has the
> value 0xF200 0000.
> 
> Any comments from anybody with any insight into what
> is happening here / or how I might fix my probelm,
> would be greatly appreciated.
> 
> Does anyone know of any code that carries out PCI
> probing similar to that found on x86 PC's ?

The boot code on our mips boards, whether some version of pmon or yamon
does that initialization.  The powerpc guys have implemented pci
scanning scheme that allows the kernel to complete initialize pretty
much arbitrarily complex pci bus systems with pci-to-pci bridges etc.  I
hope I'll have time to someday port that to mips. I don't think you can
wait till then :-)

Are you really trying to assign 0xC000 0000 to the card or was that just
an example address?  Unless your pci to memory window is such that
there's a translation that occurs, that address is incorrect.  If the
window is 1:1, the physical address 0xC000 0000 does not exist.  You
need to assign the card a real physical address; if your system has 32MB
of memory, than that address would have to be between 0 and 0x2000000. 
(well, you can't give it address "0" because of interrupt vectors, but
you get the point). I can point you to some examples if you have
problems. 

Pete
