Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Mar 2003 21:34:11 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:12286 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225202AbTCNVeK>;
	Fri, 14 Mar 2003 21:34:10 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id NAA02473;
	Fri, 14 Mar 2003 13:34:05 -0800
Subject: Re: Success! Full CardBus/EXCA on PCI->Cardbus Bridge + DbAU1500
From: Pete Popov <ppopov@mvista.com>
To: baitisj@evolution.com
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <20030314122352.F20129@luca.pas.lab>
References: <20030314122352.F20129@luca.pas.lab>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1047677667.18887.162.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 14 Mar 2003 13:34:28 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, 2003-03-14 at 12:23, Jeff Baitis wrote:
> Everyone:
> 
> Thank you very much for helping this green hand get up to speed on the MIPS
> platform.  I have successfully configured card services to work with the
> current linux_2_4 CVS, in conjunction with a TI PCI1510 PCI->CardBus bridge.
> 
> There are a few card services options that you will need, in order to replicate
> my work:
> 
> 1. The pcmcia_core cis_speed needs to be set to a fairly low value.
>    I have successfully used `modprobe pcmcia_core cis_speed=10` and 
>    `modprobe pcmcia_core cis_speed=1.`
> 
> 2. The PCMCIA memory window must map into the memory window assigned
>    by the PCI device autoconfiguration. Since my `lspci -v` shows:
> 
>    00:0d.0 CardBus bridge: Texas Instruments: Unknown device ac56
>        Subsystem: Unknown device 5678:1234
>        Flags: bus master, medium devsel, latency 168, IRQ 1
>        Memory at 40000000 (32-bit, non-prefetchable) [size=4K]
>        Bus: primary=00, secondary=05, subordinate=00, sec-latency=176
>        Memory window 0: 40001000-40002000 (prefetchable)
>        Memory window 1: 40400000-407ff000
>        I/O window 0: 00004000-000040ff
>        I/O window 1: 00004400-000044ff
>        16-bit legacy interface ports at 0001
>  
>    I configured /etc/pcmcia/config.opts as follows:
> 
>        #
>        # Local PCMCIA Configuration File
>        #
>        #----------------------------------------------------------------------
>        
>        # System resources available for PCMCIA devices
>        # remember to modprobe pcmcia_core cis_speed=10
>        
>        include port 0x100-0x4ff, port 0xc00-0xcff
>        include memory 0x40000000-0x40ffffff
> 
>        #-------------------------- eof 

Yep, I had to do that way back then when I got the same sort of setup
working.  Good job figuring that out :)

Just to confirm, this setup works with the current linux-mips.org plus
the above info?  No other patches are required, correct?

I think I'll start an Alchemy/AMD FAQ or something in my directory and
put this information there. Thanks!

Pete
