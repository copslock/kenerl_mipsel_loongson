Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2009 22:10:15 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:21398 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21103376AbZA0WKN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Jan 2009 22:10:13 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n0RMA95P010941;
	Tue, 27 Jan 2009 22:10:09 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n0RMA338010936;
	Tue, 27 Jan 2009 22:10:03 GMT
Date:	Tue, 27 Jan 2009 22:10:03 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Laurent GUERBY <laurent@guerby.net>
Cc:	Linux MIPS List <linux-mips@linux-mips.org>,
	Debian MIPS <debian-mips@lists.debian.org>
Subject: Re: IP35 Origin 300/3000 support?
Message-ID: <20090127221003.GB2234@linux-mips.org>
References: <1233078550.17541.573.camel@localhost> <20090127185759.GA2234@linux-mips.org> <1233085470.17541.610.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1233085470.17541.610.camel@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 27, 2009 at 08:44:30PM +0100, Laurent GUERBY wrote:

> For the compile farm project I manage I was proposed a donation of the
> exact same hardware (Origin 300 with 4 cpus and 2GB RAM). I'll let
> you know when I have more information.
> 
> BTW, in the SGI/MIPS family, do you know what is the most powerful
> hardware currently supported (hardware not weighting near a ton, more
> like a workstation or a few U)? Bootstraping GCC takes a while these
> days :).

Some R10000-family based workstation that would be then.  That leaves the
choice between the Indigo 2 R10000 (supported in tree), O2 (R10000
version not supported in-tree and external patches not stable afaik) and
the Octane which is only supported by external patches.

If you're just after raw computing power for bootstrapping GCC then maybe
what you want is something like a Broadcom Swarm or Big Sur evaluation
board which have 2 rsp. 4 pretty beefy cores with FPU.  Maybe there is
also something Cavium-based that works reasonably well - my Cavium system
unfortunately has no PATA or SATA controller and no PCI slots thus no
local storage.

My personal wish to eval board developers - design those things to be
usable like workstations or headless servers, with the option of local
storage and a system controller along the lines of an Origins that
allows remote reset etc.  Costs one microcontroller extra, adds alots of
usability.  Malta got that one right (send a break on the serial console
for reset) and Cavium has an extra serial port for that sort of use.

  Ralf
