Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Mar 2007 19:53:09 +0000 (GMT)
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:8701 "EHLO
	rwcrmhc12.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20022826AbXCQTxE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 17 Mar 2007 19:53:04 +0000
Received: from [192.168.1.4] (c-68-34-70-207.hsd1.md.comcast.net[68.34.70.207])
          by comcast.net (rwcrmhc12) with ESMTP
          id <20070317195220m1200fuvcge>; Sat, 17 Mar 2007 19:52:20 +0000
Message-ID: <45FC46F0.3070300@gentoo.org>
Date:	Sat, 17 Mar 2007 15:52:16 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0b2 (Windows/20070116)
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP32 prom crashes due to __pa() funkiness
References: <45D8B070.7070405@gentoo.org> <cda58cb80703010139y3e5bbb8eqa4d25b75ba658a22@mail.gmail.com>
In-Reply-To: <cda58cb80703010139y3e5bbb8eqa4d25b75ba658a22@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

(whoops, reply didn't send to the ML, sorry Frank!)


Franck Bui-Huu wrote:
 > Hi,
 >
[snip]
 >
 > Well, it means that you previously used CONFIG_BUILD_ELF64=y (this
 > implied that PAGE_OFFSET is in XKPHYS) whereas your kernel has CKSEG
 > load address (symbols need PAGE_OFFSET in CKSEG for address
 > translation).
 >
 > So the question is why can't you use CONFIG_BUILD_ELF64=n (and
 > reagarding the current definition of CONFIG_BUILD_ELF64).
 >
[snip]
 >
 > It makes me think that I posted a patch for that a couple of weeks ago:
 >
 > http://marc.theaimsgroup.com/?l=linux-mips&m=117154480225936&w=2
 > http://marc.theaimsgroup.com/?l=linux-mips&m=117154480126802&w=2
 > http://marc.theaimsgroup.com/?l=linux-mips&m=117154587014827&w=2
 >
 > Basically this patch removes CONFIG_BUILD_ELF64 and makes Kbuild to use
 > '-msym32' switch if you really need it. Kbuild makes its choice according
 > the load address of your kernel image.
 >
 > Could you give it a try ? This patch was based on 2.6.20 but it should
 > apply fine on a 2.6.21-rc[12].

Tested, and it still failed.

And I didn't always use CONFIG_BUILD_ELF64.  In fact, for the longest time (up 
until 2.6.17) I built IP32 and 64bit IP22 kernels without CONFIG_BUILD_eLF64, 
passing -mabi=o64 (a.k.a., the binutils hack).  This let me use the plain 
'vmlinux' target w/o the need for an objcopy to boot these systems.  After 
2.6.17, the nature of o64 was mostly neutered, so I switched to using 
CONFIG_BUILD_ELF64 and the 'vmlinux.32' target, as this is apparently the way 
Debian builds their IP32 kernels (and was the way geoman/spbecker said I 
should've been using all along).

So with the changes brought in by __pa(), I suppose a new, RightWay(TM) to build 
IP32 (and conversely, 64bit IP22) kernels needs to be found.  These two systems 
are particularly wacky, hence why they need a bit more special care than more 
traditional, proper, 64bit systems like Origin and Octane.

Also, Peter raises a good point in this case.  It sounds like a re-thinking of 
how all this address stuff is handled will fix not only special cases like 
IP32/IP22, but the really weird systems, like IP28, as well.  Which would be a 
big plus in my opinion.


--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
