Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Apr 2003 03:25:39 +0100 (BST)
Received: from p508B6CE5.dip.t-dialin.net ([IPv6:::ffff:80.139.108.229]:10452
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225197AbTDMCZi>; Sun, 13 Apr 2003 03:25:38 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3D2PTX20209;
	Sun, 13 Apr 2003 04:25:29 +0200
Date: Sun, 13 Apr 2003 04:25:29 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Erik J. Green" <erik@greendragon.org>
Cc: linux-mips@linux-mips.org
Subject: Re: Where does physical RAM start in kseg0?
Message-ID: <20030413042529.A20034@linux-mips.org>
References: <1050200031.3e98c7df2c227@my.visi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1050200031.3e98c7df2c227@my.visi.com>; from erik@greendragon.org on Sun, Apr 13, 2003 at 02:13:51AM +0000
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Apr 13, 2003 at 02:13:51AM +0000, Erik J. Green wrote:

> 
> A question about kseg0:  Do system designers usually set things up such that
> kseg0 begins at the start of physical memory, regardless of the xkphys
> offset at which RAM starts?

XKPHYS and KSEG0 map the same physical address space so the offsets is
the same.  Keep also in mind that XKPHYS maps the physical address space
8 times due to the 3 bits of the address that encode a caching mode.

> Or is it necessary to add the offset at which RAM starts to the kseg0 base,
> making it possible that the system designers could start RAM addresses high
> enough (above 512M) to make kseg0 unusable?  Does anyone have an
> implementation in which this is the case?  

There is no requirement at all for a system to have physical memory in
KSEG0 - the Octane to my knowledge one example.  What every sane system
needs to have in KSEG0 are exception handlers.  Of course they could also
reside in a ROM but that's insane so you should expect at least a few kb
of RAM at physical address zero.

> If kseg0 provides a window beginning at physical address 0, that means
> I'm going to try using Ralf's mapped kernel option, or I'll have to get
> the kernel up and running in 64 bit only mode (I believe 32 bit compat
> binaries would still work, since kuseg can be mapped).

Due to the Octane's funky address space layout and the current tools
limitations the kernel will have to run in CKSEG2 instead of KSEG0 ...

  Ralf
