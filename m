Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Mar 2007 03:32:47 +0000 (GMT)
Received: from sccrmhc12.comcast.net ([204.127.200.82]:45210 "EHLO
	sccrmhc12.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20022600AbXCXDcq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 Mar 2007 03:32:46 +0000
Received: from [192.168.1.4] (c-69-251-93-234.hsd1.md.comcast.net[69.251.93.234])
          by comcast.net (sccrmhc12) with ESMTP
          id <2007032403320201200004hoe>; Sat, 24 Mar 2007 03:32:02 +0000
Message-ID: <46049BAD.1010705@gentoo.org>
Date:	Fri, 23 Mar 2007 23:31:57 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0b2 (Windows/20070116)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, vagabon.xyz@gmail.com
Subject: Re: Building 64 bit kernel on Cobalt
References: <20070322.020756.25910272.anemo@mba.ocn.ne.jp>	<cda58cb80703211231u68e2f3b0g3a8a490a35f9d07f@mail.gmail.com>	<4603DA74.70707@gentoo.org> <20070324.002440.93023010.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070324.002440.93023010.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> 
> Let me ask again:  Why do you want to use CONFIG_BUILD_ELF64=y ?
> 
> If your board use CKSEG0 load address, I can not see any point setting
> CONFIG_BUILD_ELF64=y.  I think the description in Kconfig (and the
> name of CONFIG_BUILD_ELF64 itself) should be changed to make people
> enable it only if really needed.  And it is already done by Franck's
> pending patchset.

Well, the story, as it's been explained to me a half-dozen times, cause I keep 
forgetting, is that three particular machines, IP22, IP32 (R5K/Nevada/RM7K), and 
apparently cobalt, ran best when built with the old -mabi=o64 hack, because it 
generated less instructions for certain routines (loads, I think).  Especially 
in the case of cobalt, you lack a L2 cache, so you want to squeeze every thing 
possible out of the cpu.

Well, o64 went away as we all know.  It was never a favourable option for very 
good reasons (although I used it right up until it died and I was forced off of 
it).  The replacement for it, that was more preferred and resulted in similar 
code was building a kernel for any of these three systems using 
CONFIG_BUILD_ELF64 + -msym32 (auto selected in the Makefile) + the make 
vmlinux.32 target.  I believe this method is what Debian uses for building their 
mips kernels for SGI systems, but don't quote me on that.  If someone from 
Debian wants to comment, please do.

The idea being to stuff 64bit code into a 32bit object/kernel, since at least 
one of these systems, namely IP22, will only accept a 32bit object for booting. 
  It can't understand 64bit kernel objects.  Cobalt's colo bootloader will 
handle 64bit I believe, but my experience a year or two ago showed that a 
32bit/64bit hybrid kernel ran much faster than a pure 64bit kernel, simply due 
to the decreased overhead.  IP32's prom usually has no problem booting either, 
but I seem to also see a minor improvement in console redraw speed under the 
hyrbid kernel as well.

The issue is, if this method is broken, what's its replacement?  Is this 
replacement capable of generating the same (or near enough) code w/o incurring a 
penalty hit?  I mean, part of the reason for discussion going on for as long as 
it has been is the relative confusion surrounding the proper way to build these 
kernels for these particular systems.  If someone can hash that out, I think 
we'll all figure out what track to get on and get something in the tree that 
works, and works well.



--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
