Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2004 22:32:57 +0000 (GMT)
Received: from purplechoc.demon.co.uk ([IPv6:::ffff:80.176.224.106]:46464 "EHLO
	skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225374AbUBBWc4>; Mon, 2 Feb 2004 22:32:56 +0000
Received: from pdh by skeleton-jack.localnet with local (Exim 3.35 #1 (Debian))
	id 1AnmZf-0000gR-00
	for <linux-mips@linux-mips.org>; Mon, 02 Feb 2004 22:29:47 +0000
Date: Mon, 2 Feb 2004 22:29:47 +0000
To: linux-mips@linux-mips.org
Subject: Re: MIPS Kernel size
Message-ID: <20040202222947.GB2513@skeleton-jack>
References: <1075215091.40167af364b77@imp1-a.free.fr> <20040202140925.GB22008@linux-mips.org> <20040202184325.GE913@excalibur.cologne.de> <20040202185726.GB23667@linux-mips.org> <Pine.GSO.4.58.0402022033180.19699@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0402022033180.19699@waterleaf.sonytel.be>
User-Agent: Mutt/1.3.28i
From: Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 02, 2004 at 08:38:18PM +0100, Geert Uytterhoeven wrote:
> 
> > The Cobalt case is special; it's firmware could almost be the definition
> > of the term crap ...
> 
> Can't you use the firmware to load a second stage booter, which can load larger
> kernels?
> 

Yes, but you still have to maintain a old style EXT2 partition just for
the firmware.

Besides, after a while your second stage loader starts to look like a
boot loader anyway, once you've added network booting of large kernels,
kernel command line support and the other things the original firmware
was missing.

P.
