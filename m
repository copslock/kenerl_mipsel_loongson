Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 May 2004 20:38:28 +0100 (BST)
Received: from purplechoc.demon.co.uk ([IPv6:::ffff:80.176.224.106]:28800 "EHLO
	skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225974AbUEMTiQ>; Thu, 13 May 2004 20:38:16 +0100
Received: from pdh by skeleton-jack.localnet with local (Exim 3.36 #1 (Debian))
	id 1BOM1P-0000p7-00; Thu, 13 May 2004 20:37:35 +0100
Date: Thu, 13 May 2004 20:37:35 +0100
To: Joerg Rossdeutscher <joerg@factorlocal.de>
Cc: linux-mips@linux-mips.org
Subject: Re: RaQ2: Installation stops at "loading debian installer"
Message-ID: <20040513193735.GA2793@skeleton-jack>
References: <5055A94A-A503-11D8-B16C-000A956A056E@aurora.factorlocal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5055A94A-A503-11D8-B16C-000A956A056E@aurora.factorlocal.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

On Thu, May 13, 2004 at 07:31:05PM +0200, Joerg Rossdeutscher wrote:
> 
> The RaQ2 boots the debian-installer-b4 via tftp and nfs until the 
> display shows "Loading debian installer". Then it stops.
> I now have found an old Laptop that still has a serial port.
> 
> 
> The last lines say:
> 
> >execute initrd={initrd-size}@{initrd-start} 
> console=ttyS0,{console-speed}
> elf: 80080000 <-- 00001000 1916928t+176112t
> elf: entry 801fc040
> net: interface down
> 
> (I type this by hand, so excuse possibly errors)
> 
> That's it. Ethereal shows no more net traffic and no remarkable errors 
> before the installation stops. Nothings happens. And nothing at google 
> for this message. Hm.
> 
> Any ideas someone?
> 

The messages are just debugging output, nothing wrong there. The next
thing to be displayed should be kernel messages :-(

Can you post all the boot messages (off list).

P.
