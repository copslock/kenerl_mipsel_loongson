Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Oct 2004 16:24:21 +0100 (BST)
Received: from p508B657D.dip.t-dialin.net ([IPv6:::ffff:80.139.101.125]:30255
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225009AbUJWPYR>; Sat, 23 Oct 2004 16:24:17 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i9NFOCxE015840;
	Sat, 23 Oct 2004 17:24:12 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i9NFOAUN015839;
	Sat, 23 Oct 2004 17:24:10 +0200
Date: Sat, 23 Oct 2004 17:24:10 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Bruno Randolf <520066427640-0001@t-online.de>
Cc: linux-mips@linux-mips.org,
	"'Eric DeVolder'" <eric.devolder@amd.com>
Subject: Re: Hi-Speed USB controller and au1500
Message-ID: <20041023152410.GA15788@linux-mips.org>
References: <CECB0B0453C6D511BEB800104B70FA47B4A025@STARBASE> <200410231638.20982.bruno.randolf@4g-systems.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410231638.20982.bruno.randolf@4g-systems.biz>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 23, 2004 at 04:38:15PM +0200, Bruno Randolf wrote:

> would it be possible to use CONFIG_NONCOHERENT_IO=y only for USB, and not PCI? 
> we have PCI cards (prism54) which only work without CONFIG_NONCOHERENT_IO, so 
> at the moment we can either have USB host or prism54 based PCI cards...

At the moment you can use such a partially coherent system with with
CONFIG_NONCOHERENT_IO.  It should work but of course not be overly efficient.
Supporting I/O coherency on a per device base is on the to do list.

  Ralf
