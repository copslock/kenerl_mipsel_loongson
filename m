Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2003 21:05:03 +0100 (BST)
Received: from il-la.la.idealab.com ([IPv6:::ffff:63.251.211.5]:9123 "HELO
	idealab.com") by linux-mips.org with SMTP id <S8225208AbTDXUFC>;
	Thu, 24 Apr 2003 21:05:02 +0100
Received: (qmail 14161 invoked by uid 6180); 24 Apr 2003 20:04:59 -0000
Date: Thu, 24 Apr 2003 13:04:59 -0700
From: Jeff Baitis <baitisj@evolution.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Au1500 PCI autoconfig issues with multiple PCI devices?
Message-ID: <20030424130459.P10148@luca.pas.lab>
Reply-To: baitisj@evolution.com
References: <20030424114832.O10148@luca.pas.lab> <20030424121140.G28275@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030424121140.G28275@mvista.com>; from jsun@mvista.com on Thu, Apr 24, 2003 at 12:11:40PM -0700
Return-Path: <baitisj@idealab.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2177
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

Hi Jun:

To clarify, the DbAu1500 development board does *not* have a CardBus
controller.

Our fabbed board, however, does ;)

Also, before I applied that patch, you should know that I tried plugging in a
PCI->PCI bridge, placing the 3Com card behind the bridge, and the PCI auto
config didn't find the 3Com card. :(

    Autoconfig PCI channel 0x8028c428  
    Scanning bus 00, I/O 0x00000300:0x00100000, Mem 0x40000000:0x44000000
    00:0b.0 Class 0607: 104c:ac56                                        
      CARDBUS  Bridge: primary=00, secondary=01
    PCI Autoconfig: Found CardBus bridge, device 11 function 0
            Mem at 0x40000000 [size=0x1000]                   
    Scanning sub bus 01, I/O 0x00000300, Mem 0x40001000
    Back to bus 00, sub_bus is 1                       
    00:0d.0 Class 0604: 1011:0022 (rev 02)
            Bridge: primary=00, secondary=02
    Scanning sub bus 02, I/O 0x00001000, Mem 0x40100000

After applying the patch, it looks like the PCI autoconfig fortunately didn't
assign overlapping memory areas:

    00:0b.0 CardBus bridge: Texas Instruments: Unknown device ac56
            Flags: bus master, medium devsel, latency 0, IRQ 255
            Memory at 40000000 (32-bit, non-prefetchable) [size=4K]
            Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
            Memory window 0: 40001000-40400000 (prefetchable)
            I/O window 0: 00000300-000042ff
            I/O window 1: 00000000-00000003
            16-bit legacy interface ports at 0001

    00:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 78)
            Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
            Flags: bus master, medium devsel, latency 128, IRQ 1
            I/O ports at 4300 [size=128]
            Memory at 40401000 (32-bit, non-prefetchable) [size=128]
            Expansion ROM at <unassigned> [disabled] [size=128K]
            Capabilities: [dc] Power Management version 2

It seems like there used to be two memory windows associated with the CardBus bridge:
although I'm not completely familiar with what it *should* look like, I think there
should be two; one for the EXCA and one for the 32bit CardBus (?)

Anyway, cardservices is locking up on me right now. Perhaps I don't have the
memory range right. I'm including port 0x300-0x42ff, and include memory
0x40001000-0x403fffff. 

Thanks for your help, Jun. Hopefully I'll have this working today.

Here's another question:

What are the goals of the AU1500 PCI auto config? Is it supposed to be a full
implementation, or just enough to work with a PCI card? The reason I ask is
that the DBAu1500 has only one PCI slot, so a simple implementation would
normally suffice.

Restated: I don't know if the PCI auto config code was designed to work with
all sorts of wacky PCI devices. I don't know if the intention of the code is to
support the single PCI slot present on the DbAu1500 development board, or if it
is supposed to be more flexible (and complicated). 

Thanks.

-Jeff



On Thu, Apr 24, 2003 at 12:11:40PM -0700, Jun Sun wrote:
> 
> 
> On Thu, Apr 24, 2003 at 11:48:32AM -0700, Jeff Baitis wrote:
> > Hi ya'll:
> > 
> > This is the first time I've tried multiple PCI devices on the Au1500. I have a
> > PCI->CardBus bridge and a 3Com ethernet plugged into the Au1500's PCI bus. I'm
> > using the linux_2_4 branch.
> >
> <snip>
> 
> Try this patch and let me know the results.
> 
> BTW, I did not know Au1500 has a cardbus controller.  I was under impression
> it is a PCMCIA controller.  Interesting.
> 
> Jun

> diff -Nru link/arch/mips/kernel/pci_auto.c.orig link/arch/mips/kernel/pci_auto.c
> --- link/arch/mips/kernel/pci_auto.c.orig	Thu Apr 10 14:13:57 2003
> +++ link/arch/mips/kernel/pci_auto.c	Thu Apr 24 12:10:16 2003
> @@ -354,8 +354,8 @@
>  	 * configured by this routine to happily live behind a
>  	 * P2P bridge in a system.
>  	 */
> -	pciauto_upper_memspc += 0x00400000;
> -	pciauto_upper_iospc += 0x00004000;
> +	pciauto_lower_memspc += 0x00400000;
> +	pciauto_lower_iospc += 0x00004000;
>  
>  	/* Align memory and I/O to 4KB and 4 byte boundaries. */
>  	pciauto_lower_memspc = (pciauto_lower_memspc + (0x1000 - 1))


-- 
         Jeffrey Baitis - Associate Software Engineer

                    Evolution Robotics, Inc.
                     130 West Union Street
                       Pasadena CA 91103

 tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com 
