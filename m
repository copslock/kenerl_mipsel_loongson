Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Dec 2003 17:39:39 +0000 (GMT)
Received: from p508B4FE9.dip.t-dialin.net ([IPv6:::ffff:80.139.79.233]:3464
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225384AbTLIRji>; Tue, 9 Dec 2003 17:39:38 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hB9HdaoK005382;
	Tue, 9 Dec 2003 18:39:36 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hB9HdZk0005381;
	Tue, 9 Dec 2003 18:39:35 +0100
Date: Tue, 9 Dec 2003 18:39:35 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Peter Horton <phorton@bitbox.co.uk>
Cc: linux-mips@linux-mips.org
Subject: Re: Kernel 2.4.23 on Cobalt Qube2
Message-ID: <20031209173935.GA3229@linux-mips.org>
References: <3FD5FE41.8040909@bitbox.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD5FE41.8040909@bitbox.co.uk>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 09, 2003 at 04:54:25PM +0000, Peter Horton wrote:

> Has anyone got a 2.4.23 kernel running on the Cobalt Qube 2 ?
> 
> I've cross compiled the latest kernel from CVS (using the default Cobalt 
> config in the tree) on a PC using gcc 2.95.4 and binutils 2.12.90.0.1 
> (both from Debian sources).
> 
> The kernel boots okay from the HD, but I get strange segmentation faults 
> and other errors whilst running Debian's "dpkg" to install packages. If 
> I repeat the installation from scratch I get exactly the same errors in 
> exactly the same places :-(
> 
> I've changed both the memory SIMMs for new ones and the problem is still 
> the same. I've done the same Debian install on an Au1100 board with no 
> problems at all.
> 
> Neither of the on-board ethernet ports work correctly with new kernel 
> either. The primary port seems to work fine pinging single packets back 
> and forth, but seems to stall for periods of approx 20 seconds when 
> performing bulk transfers. I've been using an RTL8139 card in the PCI 
> slot for network access.

I've mentioned it before - the Cobalt kernel is suffering a bit from
bitrot as nobody is taking care of it anymore since a while.  It's a
while since I did consulting work for Cobalt and I don't have production
Cobalt hardware but I think I still have a reasonable understanding of
the machine so I think I can help whoever dares trying - any takers?

  Ralf
