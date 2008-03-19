Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Mar 2008 12:20:58 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:39871 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20022558AbYCSMUv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 19 Mar 2008 12:20:51 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JbxHm-0008Ju-00; Wed, 19 Mar 2008 13:20:50 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 65662C28E1; Wed, 19 Mar 2008 13:20:42 +0100 (CET)
Date:	Wed, 19 Mar 2008 13:20:42 +0100
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] BCM1480: Init pci controller io_map_base
Message-ID: <20080319122042.GA6194@alpha.franken.de>
References: <20080308185155.BA791E31BE@solo.franken.de> <20080310162825.GE31420@linux-mips.org> <alpine.SOC.1.00.0803191111570.17546@piorun>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.SOC.1.00.0803191111570.17546@piorun>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Wed, Mar 19, 2008 at 11:12:23AM +0000, Maciej W. Rozycki wrote:
> On Mon, 10 Mar 2008, Ralf Baechle wrote:
> 
> > Thanks, applied.  But this patch only solves the problem for the BCM1480's
> > native PCI bus.  Support for PCI behind HT still needs to be fixed and I'm
> > not quite sure where the ports of such devices and busses are getting
> > mapped to.
> 
>  Hmm, A_BCM1480_PHYS_HT_IO_MATCH_BYTES?

we could switch to IO_MATCH_BITS, but then we need to disable software
swapping and use address mangling. I personaly prefer to do swapping
in software.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
