Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Mar 2005 00:38:55 +0000 (GMT)
Received: from rwcrmhc13.comcast.net ([IPv6:::ffff:204.127.198.39]:56255 "EHLO
	rwcrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8229684AbVCZAil>; Sat, 26 Mar 2005 00:38:41 +0000
Received: from [192.168.1.4] (pcp0011842295pcs.waldrf01.md.comcast.net[69.251.97.45])
          by comcast.net (rwcrmhc13) with ESMTP
          id <2005032600383301500p3gjme>; Sat, 26 Mar 2005 00:38:34 +0000
Message-ID: <4244AEF3.7010201@gentoo.org>
Date:	Fri, 25 Mar 2005 19:38:11 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Jim Gifford <maillist@jg555.com>
CC:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Build 64bit on RaQ2
References: <42449F47.8010002@jg555.com>
In-Reply-To: <42449F47.8010002@jg555.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Jim Gifford wrote:
>   Has anyone had any luck compiling a 64 bit version on the RaQ2. I can 
> get it to compile but, it locks up during boot up.
> 
> elf64: 00080000 - 0042fd3f (ffffffff,803e6000) (ffffffff,8000000)
> elf64: ffffffff,80080000 (8008000) 3731589t + 134331t
> 
> That's all I got during bootup, no error messages or anything.

Peter Horton had some experimental code in the kernel at one point to try 
this.  I managed to get a 2.6.9 (I think, maybe 2.6.10) mips64 kernel to boot 
on cobalt, but it was pretty useless.  Poor machine was slower than molasses 
uphill in winter.

I believe cobalt would run better using the o64 kernel hack than pure n64 
kernel (-mabi=64), but cobalt needs some fixups to its spaces.h before an o64 
kernel will build on it.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: small 
hands do them because they must, while the eyes of the great are elsewhere." 
--Elrond
