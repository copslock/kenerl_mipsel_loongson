Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Dec 2004 16:47:21 +0000 (GMT)
Received: from pimout1-ext.prodigy.net ([IPv6:::ffff:207.115.63.77]:11256 "EHLO
	pimout1-ext.prodigy.net") by linux-mips.org with ESMTP
	id <S8224922AbULUQrP>; Tue, 21 Dec 2004 16:47:15 +0000
Received: from 127.0.0.1 (adsl-68-124-224-225.dsl.snfc21.pacbell.net [68.124.224.225])
	by pimout1-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id iBLGkke3134608
	for <linux-mips@linux-mips.org>; Tue, 21 Dec 2004 11:46:59 -0500
Received: from  [63.194.214.47] by 127.0.0.1
  (ArGoSoft Mail Server Pro for WinNT/2000/XP, Version 1.8 (1.8.6.7)); Tue, 21 Dec 2004 08:46:44 -0800
Message-ID: <41C8536E.5060507@embeddedalley.com>
Date: Tue, 21 Dec 2004 08:46:38 -0800
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Josh Green <jgreen@users.sourceforge.net>
CC: linux-mips@linux-mips.org
Subject: Re: Problems with PCMCIA on AMD dbau1100
References: <1103628665.22113.16.camel@SillyPuddy.localdomain>
In-Reply-To: <1103628665.22113.16.camel@SillyPuddy.localdomain>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ArGoMail-Authenticated: ppopov@embeddedalley.com
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Josh Green wrote:
> I'm having trouble getting PCMCIA to work properly on my dbau1100 MIPS
> board with latest CVS (2.6.10rc3).  Any help would be very appreciated.
> Here is lsmod output:
> 
> # lsmod
> Module                  Size  Used by    Not tainted
> au1x00_ss 12160 0 - Live 0xc0005000
> pcmcia_core 60848 1 au1x00_ss, Live 0xc0015000
> 
> 
> I get this output when modprobing au1x00_ss:
> 
> Linux Kernel Card Services
>   options:  none
> 
> 
> At this point 'pcmcia' is not listed in /proc/devices though, so I'm
> assuming another module needs to be inserted?  On my x86 laptop I see
> there is a ds module.  This appears to have been compiled into an object
> for my MIPS build, but there is no stand alone ds module.  If I insert
> the 'pcmcia' module I get pcmcia support (I'm assuming this is the 16
> bit PCMCIA module, it doesn't appear dependent on au1x00_ss), but no
> cards are detected:
> 
> # cardctl ident
> Socket 0:
>   no product info available
> Socket 1:
>   no product info available
> 
> # cardctl status
> Socket 0:
>   no card
> Socket 1:
>   no card

If all the config files are setup properly, you should start pcmcia 
with /etc/rc.d/init.d/pcmcia start. That will also run the cardmgr. 
Without the cardmgr, nothing will happen. If you're loading the 
modules manuall, modprobe au1x00_ss, then ds.o, the execute cardmgr 
and at that point the card should be detected.

> One thing to note is that I get a few warnings during the PCMCIA build:
> 
>   CC [M]  drivers/pcmcia/au1000_generic.o
> drivers/pcmcia/au1000_generic.c: In function
> `au1x00_pcmcia_socket_probe':
> drivers/pcmcia/au1000_generic.c:425: warning: integer constant is too
> large for "long" type
> drivers/pcmcia/au1000_generic.c:433: warning: integer constant is too
> large for "long" type
> 
> The first warning is related to the following code (second is similar
> but for socket 1):
> 
> 	skt->virt_io = (void *)
> 		((u32)ioremap((ioaddr_t)AU1X_SOCK0_IO, 0x1000) -
> 		(u32)mips_io_port_base);
> 
> 
> AU1X_SOCK0_IO is defined as 0xF00000000 which is a 36 bit number, not
> sure if that will cause a problem or not (since ioremap is using phys_t
> which is 32 bit). 

phys_t is 64 bit if 64BIT is enabled. Make sure you have the 36bit 
I/O support enabled. CONFIG_64BIT_PHYS_ADDR has to be defined.

> Perhaps this truncation is intentional though.
> 
> Thanks in advance for any helpful pointers. Best regards,
> 	Josh Green

I tested pcmcia a couple of months ago when I updated the driver. 
I'll retest it in the next few days and send you additional 
instructions.

Pete
