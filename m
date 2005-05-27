Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 May 2005 07:20:03 +0100 (BST)
Received: from sccrmhc12.comcast.net ([IPv6:::ffff:204.127.202.56]:5809 "EHLO
	sccrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8225987AbVE0GTr>; Fri, 27 May 2005 07:19:47 +0100
Received: from [192.168.1.4] (pcp0011842295pcs.waldrf01.md.comcast.net[69.251.97.45])
          by comcast.net (sccrmhc12) with ESMTP
          id <2005052706194001200ha7i2e>; Fri, 27 May 2005 06:19:40 +0000
Message-ID: <4296BCA3.7040003@gentoo.org>
Date:	Fri, 27 May 2005 02:22:27 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Porting To New System
References: <Pine.GSO.4.10.10505270720390.23050-100000@helios.et.put.poznan.pl>
In-Reply-To: <Pine.GSO.4.10.10505270720390.23050-100000@helios.et.put.poznan.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Stanislaw Skowronek wrote:
> 
> That said, they have really hard work to do - I wish them all the luck
> they need, which is *a lot*. Cracking locked-down systems with proprietary
> formats is incredibly hard. It's hard enough when they aren't proprietary,
> or when they aren't deliberately locked-down.

With this in mind, I'm watching the port of Linux to the Nintendo DS.  They 
apparently just got 2.6 and framebuffer working, so it'll be interesting to see 
where they go with it.  Given the DS is a far more constrained system, and 
Nintendo not very forthcoming on their hardware specs, I'm surprised at the 
speed with which they've gotten things working.

And PSP isn't entirely closed -- it is based to a certain degree off PS2 
hardware, of which Sony release 6 of a supposed 7 total technical documents 
regarding the innards of the system.  Now I imagine alot of the custom hacks 
needed to support the R5900 in PS2 aren't needed in PSP, since it uses a more 
standard CPU, this might have an impact on how fast or slow they wind up porting 
the kernel.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
