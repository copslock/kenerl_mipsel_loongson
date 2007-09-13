Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2007 08:06:20 +0100 (BST)
Received: from alnrmhc13.comcast.net ([206.18.177.53]:39581 "EHLO
	alnrmhc13.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20021487AbXIMHGM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Sep 2007 08:06:12 +0100
Received: from [192.168.1.4] (c-69-140-18-238.hsd1.md.comcast.net[69.140.18.238])
          by comcast.net (alnrmhc13) with ESMTP
          id <20070913070524b130008tp5e>; Thu, 13 Sep 2007 07:05:28 +0000
Message-ID: <46E8E134.8000004@gentoo.org>
Date:	Thu, 13 Sep 2007 03:05:24 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
MIME-Version: 1.0
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:	linux-mips@linux-mips.org
Subject: Re: IP22 64bit kernel
References: <20070911213048.GA20579@alpha.franken.de>
In-Reply-To: <20070911213048.GA20579@alpha.franken.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Thomas Bogendoerfer wrote:
> 
> Enabling this for (CONFIG_SGI_IP22 && CONFIG_64BIT) fixes the boot problem.
> It's not big deal to add this, but I'm wondering why we not just always
> use this macro ? What platforms do it break with it ?

Hmm, curious, the CONFIG_ARC64 macro?  Indys and O2s use 32bit versions of the 
ARCS Prom, whereas Octane, Origin, and IP28 systems (and others) use 64bit.  I 
suspect CONFIG_ARC64 is geared for these, but if it works on Indy's too, that's 
curious.


--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
