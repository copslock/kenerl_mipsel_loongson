Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Mar 2005 17:32:04 +0000 (GMT)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:65039 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8227061AbVCORbr>; Tue, 15 Mar 2005 17:31:47 +0000
Received: from [10.1.100.4] ([64.164.196.27])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id j2FHUhPt014943;
	Tue, 15 Mar 2005 12:30:44 -0500
Message-ID: <42371C05.7060401@embeddedalley.com>
Date:	Tue, 15 Mar 2005 09:31:49 -0800
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
MIME-Version: 1.0
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
CC:	linux-mips@linux-mips.org
Subject: Re: need help with CompactFlash/PCMCIA
References: <200503151245.15920.eckhardt@satorlaser.com>
In-Reply-To: <200503151245.15920.eckhardt@satorlaser.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7436
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Ulrich Eckhardt wrote:
> Hi!
> 
> I have a board here which roughly resembles a DB1100, AFAICT. My problem is 
> that I can't get the CompactFlash card to be recognized, and I don't even 
> know where exactly it fails.
> So, a few questions up front:
> 1. CompactFlash is accessed via PCMCIA, it does not use the MTD 
> infrastructure, right? 

Correct.

> I also read that the CF then appears as a normal(?) 
> ATA device. So, what should be the right drivers for it?

The au1x00_ss socket driver, the pcmcia stack modules or statically compiled, 
and ide-cs.o, which is the pcmcia ide client driver.

> 2. How can I find out if it's looking at the right addresses? I just need some 
> kind of register which I can probe to find out if the device is where I think 
> it should be.
> 
> Hmm, in fact I'd be happy about _any_ hint the would get me further. I'm 
> slightly desparate...

Start with the low level routines that detect the card and set the voltage 
levels. When you plug in the card, is it detected? Are you setting the correct 
voltages? What happens next -- is the card at least recognized by the cardmgr, 
which means that the attribute memory is read correctly?

> Appended is a patch that removes an unused variable, something I found while 
> trying to understand what's going on there.

Well, there is another patch for a custom board that uses those unused 
variables. Perhaps those variables should just be part of that external patch...

Pete

> thanks
> 
> Uli
> 
> ---
> 
> Index: au1000_generic.c
> ===================================================================
> RCS file: /home/cvs/linux/drivers/pcmcia/au1000_generic.c,v
> retrieving revision 1.18
> diff -u -r1.18 au1000_generic.c
> --- au1000_generic.c 25 Jan 2005 04:28:38 -0000 1.18
> +++ au1000_generic.c 15 Mar 2005 11:40:26 -0000
> @@ -66,10 +66,6 @@
>  #define PCMCIA_SOCKET(x) (au1000_pcmcia_socket + (x))
>  #define to_au1000_socket(x) container_of(x, struct au1000_pcmcia_socket, 
> socket)
>  
> -/* Some boards like to support CF cards as IDE root devices, so they
> - * grab pcmcia sockets directly.
> - */
> -u32 *pcmcia_base_vaddrs[2];
>  extern const unsigned long mips_io_port_base;
>  
>  DECLARE_MUTEX(pcmcia_sockets_lock);
> @@ -437,7 +433,6 @@
>     skt->phys_mem = AU1X_SOCK1_PSEUDO_PHYS_MEM;
>    }
>  #endif
> -  pcmcia_base_vaddrs[i] = (u32 *)skt->virt_io;
>    ret = ops->hw_init(skt);
>  
>    skt->socket.features = SS_CAP_STATIC_MAP|SS_CAP_PCCARD;
> 
> 
