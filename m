Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2009 08:57:42 +0100 (BST)
Received: from hall.aurel32.net ([88.191.82.174]:47254 "EHLO hall.aurel32.net"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20027027AbZEAH5g (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 1 May 2009 08:57:36 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.69)
	(envelope-from <aurelien@aurel32.net>)
	id 1Lzncg-0005bC-M2; Fri, 01 May 2009 09:57:30 +0200
Date:	Fri, 1 May 2009 09:57:30 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	luk@debian.org, linux-mips@linux-mips.org
Subject: Re: kernel for a Broadcom Swarm board
Message-ID: <20090501075730.GC16244@hall.aurel32.net>
References: <49FA27FA.3070408@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <49FA27FA.3070408@debian.org>
X-Mailer: Mutt 1.5.18 (2008-05-17)
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

On Fri, May 01, 2009 at 12:36:42AM +0200, Luk Claes wrote:
> Hi
>
> > | [    0.000000] Broadcom SiByte BCM1250 B2 @ 800 MHz (SB1 rev 2)
> > | [    0.000000] Board type: SiByte BCM91250A (SWARM)
> > | [    0.000000] This kernel optimized for board runs with CFE
> > | [    0.000000] Determined physical RAM map:
> > | [    0.000000]  memory: 000000000fe47e00 @ 0000000000000000 (usable)
> > | [    0.000000] Initrd not found or empty - disabling initrd
> > | [    0.000000] Zone PFN ranges:
> > | [    0.000000]   DMA32    0x00000000 -> 0x00100000
> > | [    0.000000]   Normal   0x00100000 -> 0x00100000
> > | [    0.000000] Movable zone start PFN for each node
> > | [    0.000000] early_node_map[1] active PFN ranges
> > | [    0.000000]     0: 0x00000000 -> 0x0000fe47
> > | [    0.000000] Detected 1 available secondary CPU(s)
> > | [    0.000000] Built 1 zonelists in Zone order, mobility grouping  
> on.  Total
> > pages: 64205
> > | [    0.000000] Kernel command line: root=/dev/hdc1 console=duart0
> > | [    0.000000] Primary instruction cache 32kB, VIVT, 4-way, linesize 
> 32 bytes.
> > | [    0.000000] Primary data cache 32kB, 4-way, PIPT, no aliases,  
> linesize 32
> > bytes
> > | [    0.000000] PID hash table entries: 1024 (order: 10, 8192 bytes)
> >
> > And then it hangs...
>
> The zeros look like there are no timing interrupts happening. It's a  
> pity we don't have hardware to test which kernel version introduced the  
> bug (for instance with git-bisect and reboots).
>

I think the zeros are normal here, on other machines, the values
actually start to change just after this line.

-- 
Aurelien Jarno	                        GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
