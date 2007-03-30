Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Mar 2007 06:36:25 +0100 (BST)
Received: from sccrmhc12.comcast.net ([63.240.77.82]:20111 "EHLO
	sccrmhc12.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20021407AbXC3FgY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Mar 2007 06:36:24 +0100
Received: from [192.168.1.4] (c-69-251-93-234.hsd1.md.comcast.net[69.251.93.234])
          by comcast.net (sccrmhc12) with ESMTP
          id <20070330053539012006761ie>; Fri, 30 Mar 2007 05:35:40 +0000
Message-ID: <460CA1AB.1080608@gentoo.org>
Date:	Fri, 30 Mar 2007 01:35:39 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0b2 (Windows/20070116)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, ths@networkno.de, ralf@linux-mips.org,
	vagabon.xyz@gmail.com
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
References: <460A6CED.1070308@gentoo.org>	<20070329.002453.18311528.anemo@mba.ocn.ne.jp>	<460C7404.2020209@gentoo.org> <20070330.120106.96687664.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20070330.120106.96687664.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> This is not Franck's fault.  His patchset does not change behavior if
> kernel load address was CKSEG0 and CONFIG_BUILD_ELF64 was not set
> (unless you are using gcc 3.x).

I wasn't implying it was anyone's fault of any kind.  I actually didn't see your 
last response cause Thunderbird got stupid and stopped checking for new mail for 
some odd reason.


> Let's clarify things a bit: The Franck's patchset is _not_ fix.  It
> just tried to avoid undesirable configuration (CKSEG0 kernel with
> BUILD_ELF64=y), and clarify some namings.

As far as I can tell, the majority of what CONFIG_BUILD_ELF64 did got neutered 
in 2.6.17.  It's pretty much down to those minor #ifdef checks and a few 
references on the defconfigs.  Removing it entirely is probably the best idea, 
and if Frank's patch is one way of doing it, I'm game.  Besides, he's got that 
loadaddr detector thrown in so we don't have to check on a machine-by-machine 
basis if they're loading in CKSEG0 or not.


> So I should ask you again, does current git (or 2.6.20-stable) kernel
> compiled by binutils-2.17/gcc-4.[12] work for IP32 if you disabled
> CONFIG_BUILD_ELF64?
[snip]
> So I had thought CONFIG_BUILD_ELF64=n worked for IP32...


If memory serves, yes, it'll boot, because it's close to the old way I that I 
used to use when building them.  Prior to 2.6.17, I did CONFIG_BUILD_ELF64=n 
with -mabi=o64.  This let me use the plain 'vmlinux' target without any special 
changes.  2.6.17 is when I stopped using gcc-3.x for kernels, moved to 4.x, and 
started using CONFIG_BUILD_ELF64=y w/ -msym32 and friends.  Thus I now use 
vmlinux.32.  I was told that that was the RightWay(TM) to do it.

Hence, the real point of this long chain is mainly to accomplish two things:

1) Finally determine the OneTrueWay(TM) to build 64bit kernels for our three 
main CKSEG0-based systems (ip22, ip32, cobalt), and get that way documented so 
as to avoid confusion in the future.

2) Get a solution into the tree that does #1, and does it well.  So far, Frank's 
patch seems like the leading contender here.



--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
