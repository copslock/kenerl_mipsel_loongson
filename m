Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Feb 2005 15:13:04 +0000 (GMT)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:45582 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225388AbVBWPMu>; Wed, 23 Feb 2005 15:12:50 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j1NF6I0I018377;
	Wed, 23 Feb 2005 15:06:18 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j1NF6Hfe018376;
	Wed, 23 Feb 2005 15:06:17 GMT
Date:	Wed, 23 Feb 2005 15:06:17 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dan Malek <dan@embeddededge.com>
Cc:	JP Foster <jp.foster@exterity.co.uk>, linux-mips@linux-mips.org
Subject: Re: Big Endian au1550
Message-ID: <20050223150617.GA18290@linux-mips.org>
References: <1109157737.16445.6.camel@localhost.localdomain> <000301c5199d$3154ad40$0300a8c0@Exterity.local> <1109160313.16445.20.camel@localhost.localdomain> <cb80abe539fa80effd786cacc1340de7@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb80abe539fa80effd786cacc1340de7@embeddededge.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 23, 2005 at 10:03:01AM -0500, Dan Malek wrote:

> >Fair enough. Has anyone got big-endian au1xxx working ever?
> 
> The only issues with big endian Au1xxx is the USB and potentially
> PCI.  There have been recent patches posted for USB that could
> fix this.  The PCI problem is with the read/write/in/out macros.
> They were never written properly and I haven't checked to see
> if this was corrected in 2.6.
> 
> That aside, I have worked on several big endian Au1xxx projects
> that are successful.  I never found a way, aside from #ifdefs for
> byte sex in generic files, to make the same source compile in
> either mode.  It's a fairly low priority on my list of other Au1xxx 
> projects :-)
> 
> The Linux sources have worked, and if they currently don't we
> should fix them.

So I guess this would apply to all Alchemy-based platforms and thus I
should offer big endian on all of them again?

  Ralf
