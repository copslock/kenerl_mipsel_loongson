Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 19:22:28 +0100 (BST)
Received: from p508B74B7.dip.t-dialin.net ([IPv6:::ffff:80.139.116.183]:30301
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225971AbUDXSW1>; Sat, 24 Apr 2004 19:22:27 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i3OIM6xT022743
	for <linux-mips@linux-mips.org>; Sat, 24 Apr 2004 20:22:06 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i3OILkmi022742;
	Sat, 24 Apr 2004 20:21:46 +0200
Date: Sat, 24 Apr 2004 20:21:46 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc: linux-mips@linux-mips.org
Subject: Re: pci-ip27 memory ranges
Message-ID: <20040424182146.GD26165@linux-mips.org>
References: <Pine.GSO.4.10.10404241059030.18252-100000@helios.et.put.poznan.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10404241059030.18252-100000@helios.et.put.poznan.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Apr 24, 2004 at 11:00:44AM +0200, Stanislaw Skowronek wrote:

> Why does the pci-ip27 driver register all memory resources (0UL - ~0UL)? I
> had to change it to the appropriate Xtalk window to get the kernel to
> recognize PCI at all.

The IP27 PCI code as it is in CVS is incomplete or even broken - however
fixing isn't entirely trivial.  The current workaround which I use - and
which due to being just an evil hack is not in CVS - to only scan the PCI
code.  The problem is the firmware does a very simple setup which hurts
performance very badly, so eventually Linux will have to do a full PCI
configuration for all PCI busses.

> Now, the IOC3 makes a kernel panic. Will see...

  Ralf
