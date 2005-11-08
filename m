Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2005 00:50:58 +0000 (GMT)
Received: from rwcrmhc14.comcast.net ([204.127.198.54]:45795 "EHLO
	rwcrmhc12.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8133832AbVKHAul (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Nov 2005 00:50:41 +0000
Received: from [192.168.1.15] (pcp04414054pcs.nrockv01.md.comcast.net[69.140.185.48])
          by comcast.net (rwcrmhc14) with ESMTP
          id <20051108005124014006gp59e>; Tue, 8 Nov 2005 00:51:24 +0000
Message-ID: <436FF689.3010308@gentoo.org>
Date:	Mon, 07 Nov 2005 19:51:21 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 1.4.1 (Windows/20051006)
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: MIPS - 64bit woes
References: <436D0061.5070100@jg555.com> <Pine.LNX.4.55.0511071143210.28165@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0511071143210.28165@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> 
>  It must be platform-specific -- I haven't checked 2.6.14, but 64-bit
> 2.6.13 is good enough to boot into multi-user with the SWARM.

2.6.13.4 works on all systems I can test (O2, Octane, Origin*, Indy, I2 Impact), 
but for me, it appears 2.6.14 dies very early in kernel initialization on both 
Octane and Origin.  I have yet to try another, like O2, but I'm going to do that 
shortly in the hopes O2 may initialize an output device and give me an idea of 
what's going on.

* 2.6.13.4 Works on Origin, but can't allocate PCI resources for the scsi 
properly.  2.6.12.5 is what works best for this system.


--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
