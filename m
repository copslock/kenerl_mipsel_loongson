Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2005 11:58:44 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:55560 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8224916AbVDLK63>; Tue, 12 Apr 2005 11:58:29 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j3CAwGJQ019059;
	Tue, 12 Apr 2005 11:58:16 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j3CAwGWZ019058;
	Tue, 12 Apr 2005 11:58:16 +0100
Date:	Tue, 12 Apr 2005 11:58:15 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Paul Chapman <paul.chapman@BrockU.CA>
Cc:	linux-mips@linux-mips.org
Subject: Re: ip27 PCI devices
Message-ID: <20050412105815.GC5573@linux-mips.org>
References: <1113251422.21580.33.camel@paul.dev.brocku.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113251422.21580.33.camel@paul.dev.brocku.ca>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 11, 2005 at 04:30:22PM -0400, Paul Chapman wrote:

> I've been experimenting with trying various PCI cards I have lying
> around in my Origin 200, to see if I can make any of them work.

The current Linux implementation limits IP27 to cards with 64-bit
addressing capability.

> So far, I've had no luck: all of them have resource collisions with the
> IOC3 (presumably because of its address decoding).  They're detected
> fine in /proc/pci.

What kernel version are you trying?

> So: has anyone had any luck with anything they've tried?  In particular,
> I'm looking for an ethernet card that works (and is readily available),
> since the performance of the IOC3 is pretty wretched.

That actually also seems to be more of a limitation of how the IP27 code
is setting up RRBs for PCI devices, so any driver is expected to deliver
a somewhat modest (understatement!) performance.  Fixing fortunately isn't
too hard ...

  Ralf
