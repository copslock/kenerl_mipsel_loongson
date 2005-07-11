Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jul 2005 08:12:33 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:22283 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226517AbVGLHMM>; Tue, 12 Jul 2005 08:12:12 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j6C7D7mR002013;
	Tue, 12 Jul 2005 08:13:07 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j6BMRtdB002980;
	Mon, 11 Jul 2005 23:27:55 +0100
Date:	Mon, 11 Jul 2005 23:27:55 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: Current SGI Octane status
Message-ID: <20050711222755.GA2952@linux-mips.org>
References: <20050709093403.GB1586@hattusa.textio> <Pine.GSO.4.10.10507091833390.24862-100000@helios.et.put.poznan.pl> <20050709212029.GG1586@hattusa.textio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050709212029.GG1586@hattusa.textio>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jul 09, 2005 at 11:20:29PM +0200, Thiemo Seufer wrote:

> Stanislaw Skowronek wrote:
> > > - IOC3 networking works, with 2MB/s maximum for a 30MB http transfer
> > 
> > This is strange. Ask Ralf.
> 
> Up to 2.5 Mb actually. Still well below wat it should be.

I suspect it may be related to the RRB allocation.  The driver used to be
even slower until I made it use a second RRB by using the BRIDGE virtual
device feature.

Obviously all the funky RRB stuff of the BRIDGE has no public documentation.
However the SN1 / SN2 bits in the kernel tree should be rather close.

  Ralf
