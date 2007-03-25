Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Mar 2007 18:00:18 +0100 (BST)
Received: from alnrmhc13.comcast.net ([204.127.225.93]:16382 "EHLO
	alnrmhc13.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20022653AbXCYRAR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 25 Mar 2007 18:00:17 +0100
Received: from [192.168.1.4] (c-69-251-93-234.hsd1.md.comcast.net[69.251.93.234])
          by comcast.net (alnrmhc13) with ESMTP
          id <20070325165932b13009i1kve>; Sun, 25 Mar 2007 16:59:33 +0000
Message-ID: <4606AA74.3070907@gentoo.org>
Date:	Sun, 25 Mar 2007 12:59:32 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0b2 (Windows/20070116)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, ths@networkno.de, ralf@linux-mips.org
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
References: <20070324.234727.25910303.anemo@mba.ocn.ne.jp>	<20070324231602.GP2311@networkno.de>	<46062400.8080307@gentoo.org> <20070326.011000.75185255.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070326.011000.75185255.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> I can not see why you handle IP22, IP32, Cobalt as so "special".
> There are many other platforms which supports 64-bit and uses CKSEG0
> load address (well, actually all 64-bit platforms except for IP27).

Mainly because, to the best of my knowledge, these are the only three systems 
where things get weird with ckseg0 and this specific Kconfig option.  Afaik with 
other systems, they don't need weird hacks like stuffing 64bit code into 32bit 
objects to work best (or at all).


> So I think Franck's approach, which enables -msym32 and defines
> KBUILD_64BIT_SYM32 automatically if load-y was CKSEG0, is better.  Are
> there any problem with his patchset?

I missed the other two additions to this patch, which is probably why it didn't 
work :)  Taken as a whole, they also boot my O2 now.


--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
