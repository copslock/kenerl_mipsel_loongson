Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 14:25:32 +0000 (GMT)
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:29920 "EHLO
	rwcrmhc13.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20021893AbXCSOZ0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Mar 2007 14:25:26 +0000
Received: from [192.168.1.4] (c-68-34-70-207.hsd1.md.comcast.net[68.34.70.207])
          by comcast.net (rwcrmhc13) with ESMTP
          id <20070319142438m1300e40hke>; Mon, 19 Mar 2007 14:24:42 +0000
Message-ID: <45FE9D22.1030407@gentoo.org>
Date:	Mon, 19 Mar 2007 10:24:34 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0b2 (Windows/20070116)
MIME-Version: 1.0
To:	Franck <vagabon.xyz@gmail.com>
CC:	Linux MIPS List <linux-mips@linux-mips.org>,
	Arnaud Giersch <arnaud.giersch@free.fr>
Subject: Re: IP32 prom crashes due to __pa() funkiness
References: <45D8B070.7070405@gentoo.org>	<cda58cb80703010139y3e5bbb8eqa4d25b75ba658a22@mail.gmail.com>	<45FC46F0.3070300@gentoo.org> <87irczzglc.fsf@groumpf.homeip.net> <45FC9E39.7010506@gentoo.org> <45FE95EE.5030108@innova-card.com>
In-Reply-To: <45FE95EE.5030108@innova-card.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:

> OK that's the reason why the last patch you applied has no effect. If
> you're using 'objcopy' your kernel can still be miss configured.
> 
> BTW, does your gcc support '-sym32' switch ?

I'll have to re-try some runs w/ the straight 64bit vmlinux later on then, but 
AFAICT, __pa() braks IP32 because of the assumption I highlighted.  This, 
cobalt, and IP22 are a bit "special" in their needs, I guess.  Anyone got a 
short yellow bus?


> My current feeling is that __pa() introduction now breaks configs
> which were initialy _broken_, IMHO. CPHYSADDR() hide them because it
> can happily convert any virutal address form both CKSEG0 or XKPHYS.
> 
> It may be a good thing to crash at this point. CONFIG_BUILD_ELF64 is
> used in some others places, where it can introduce some others bugs
> harder to find (if miss configured of course). The sad thing is that
> the kernel does not report any useful messages. That's why I think
> adding some specific sanity checks for 64 bit kernels in boot mem init
> code may be usefull.

A good idea to crash at this point?  Not for users.  Up until this point, I've 
never really seen any bugs produced by CONFIG_BUILD_ELF64, granted I avoided 
using it until ~2.6.17 (when o64 died).  If there were bugs, they were subtle 
and didn't appear to affect the day-to-day running of the system.  At minimum, 
__pa() should recreate this effect, and then we can trace down the bugs and 
hammer them to death later.


> Now it's clear that CONFIG_BUILD_ELF64 is really confusing. I would say
> that whatever the value of CONFIG_BUILD_ELF64, your kernel should run
> fine. BUT it really depends on your kernel load address:
> 
> if CONFIG_BUILD_ELF64=y then kernel load address must be in XKPHYS
> if CONFIG_BUILD_ELF64=n then kernel load address must be in CKSEG0
> 
> All others configs (I think) are buggy...
> 
> That's said, it seems that IPxx kernels are really special
> beasts. Take from MIPS makefile:
> 
> """
> Some machines like the Indy need 32-bit ELF binaries for booting
> purposes.
> """
> 
> So I dunno if this statement is still correct but it sounds that you
> have no other choice thatn CONFIG_BUILD_ELF64=n and load address in
> CKSEG0.


Most of this is because IP22 (Indy/Idigo2 R4xx) and IP32 (O2 R5xxx), while 
supporting 64bit kernels (same for cobalt, since it's a mips4-level CPU), we had 
to "trick" them into accepting 64bit code.  IP32 at one point ran 32bit kernels 
only, but it was later converted to supporting only 64bit kernels, hence the 
hackery involved.  We describe it as wrapping 64bit code into a 32bit object, 
because their proms will only recognize 32bit objects (specifically, IP22 will 
only boot 32bit objects; crash on 64bit; IP32 will take both, but likes 32bit 
better).

So really, CONFIG_BUILD_ELF64 was probably part of this "magic" to stuff 64bit 
code into a candy-coated 32bit wrapper for the Indy (And later the O2) to suck 
down w/o complaint.  Hence, __pa() probably needs to replicate this support, or 
we all need to brainstorm a proper way to get these systems to boot.

Octane, Origin, IP28 (Indigo2 R10000). et al, don't complain, and don't need 
this hacker, because their proms boot proper 64bit binaries only (they reject 
all else).

So probably the following is true (someone correct me if not)

if (CONFIG_BUILD_ELF64=y and (!CONFIG_SGI_IP22 or !CONFIG_SGI_IP32 or 
!CONFIG_COBALT)) then kernel load address must be in XKPHYS
else load address must be in CKSEG0
if CONFIG_BUILD_ELF64=n then kernel load address must be in CKSEG0



> I'm sorry but my IPxx background is 0 ;)

Time to buy an O2 :)


--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
