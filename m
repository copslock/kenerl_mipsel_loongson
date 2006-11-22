Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Nov 2006 22:42:45 +0000 (GMT)
Received: from rex.snapgear.com ([203.143.235.140]:56791 "EHLO
	cyberguard.com.au") by ftp.linux-mips.org with ESMTP
	id S20039404AbWKVWmj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Nov 2006 22:42:39 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by hex.internal.moreton.com.au (Postfix) with ESMTP id BAF1FEBA0C;
	Thu, 23 Nov 2006 08:42:29 +1000 (EST)
Received: from hex.internal.moreton.com.au ([127.0.0.1])
	by localhost (bne.snapgear.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 01494-07; Thu, 23 Nov 2006 08:42:28 +1000 (EST)
Received: from beast (davidm0.sw.moreton.com.au [10.46.1.20])
	by hex.internal.moreton.com.au (Postfix) with ESMTP;
	Thu, 23 Nov 2006 08:42:28 +1000 (EST)
Received: by beast (Postfix, from userid 1012)
	id B1C65161C05D; Thu, 23 Nov 2006 08:43:01 +1000 (EST)
Date:	Thu, 23 Nov 2006 08:43:01 +1000
From:	David McCullough <david_mccullough@au.securecomputing.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Trevor Hamm <Trevor_Hamm@pmc-sierra.com>,
	'Atsushi Nemoto' <anemo@mba.ocn.ne.jp>,
	linux-mips@linux-mips.org
Subject: Re: Problems booting Linux 2.6.18.1 on MIPS34K core
Message-ID: <20061122224301.GA27309@au.securecomputing.com>
References: <E8C8A5231DDE104C816ADF532E0639120194F4EB@bby1exm07.pmc_nt.nt.pmc-sierra.bc.ca> <20061122215803.GA8819@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061122215803.GA8819@linux-mips.org>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: amavisd-new at snapgear.com
Return-Path: <david_mccullough@au.securecomputing.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david_mccullough@au.securecomputing.com
Precedence: bulk
X-list: linux-mips


Jivin Ralf Baechle lays it down ...
> On Wed, Nov 22, 2006 at 12:31:10PM -0800, Trevor Hamm wrote:
> 
> > The source of the problem seems to be with squashfs.  When I compare booting a kernel using squashfs to one using cramfs (which always seems to boot successfully on power-up), both are reading the troublesome page from /lib/ld-uClibc.so, and both are calling flush_dcache_page() on this page.  But in the case of cramfs, flush_dcache_page() causes an immediate cache flush of that page (mapping_mapped(mapping) in __flush_dcache_page() is returning non-zero), while squashfs just marks the page as dirty and defers the cache flush (mapping_mapped(mapping) is returning zero).  I have no idea what causes this difference in behaviour, but right now it appears to be a bug in squashfs rather than the linux-mips kernel.
> 
> There are a few other potencial and real bugs me and Atsushi have found
> in squashfs.  Guess there is a reason why it's not yet in the kernel ...
> I'm still waiting for feedback from the squashfs author.

Not sure if it helps much,  but we run squashfs (with 7zip patch) on
ARM9, ARM10, SuperH and x86 without problems.  I haven't had any issues
with it so far on the au1500 either,

Cheers,
Davidm

-- 
David McCullough,  david_mccullough@securecomputing.com,   Ph:+61 734352815
Secure Computing - SnapGear  http://www.uCdot.org http://www.cyberguard.com
