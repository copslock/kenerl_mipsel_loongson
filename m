Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Mar 2007 02:05:28 +0000 (GMT)
Received: from rwcrmhc14.comcast.net ([204.127.192.84]:25569 "EHLO
	rwcrmhc14.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20022880AbXCRCF0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 18 Mar 2007 02:05:26 +0000
Received: from [192.168.1.4] (c-68-34-70-207.hsd1.md.comcast.net[68.34.70.207])
          by comcast.net (rwcrmhc14) with ESMTP
          id <20070318020441m1400iqsrbe>; Sun, 18 Mar 2007 02:04:42 +0000
Message-ID: <45FC9E39.7010506@gentoo.org>
Date:	Sat, 17 Mar 2007 22:04:41 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0b2 (Windows/20070116)
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
CC:	Arnaud Giersch <arnaud.giersch@free.fr>
Subject: Re: IP32 prom crashes due to __pa() funkiness
References: <45D8B070.7070405@gentoo.org>	<cda58cb80703010139y3e5bbb8eqa4d25b75ba658a22@mail.gmail.com>	<45FC46F0.3070300@gentoo.org> <87irczzglc.fsf@groumpf.homeip.net>
In-Reply-To: <87irczzglc.fsf@groumpf.homeip.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Arnaud Giersch wrote:
> 
> I don't know if it is the RightWay(TM), but I am running here a fresh
> IP32 kernel (l.m.o git updated yesterday).  It was compiled with
> CONFIG_BUILD_ELF64=n, and I am using vmlinux.
> 
> $ file /boot/vmlinux-2.6.21-rc3-g839fd555 
> /boot/vmlinux-2.6.21-rc3-g839fd555: ELF 64-bit MSB executable, MIPS, MIPS-IV version 1 (SYSV), statically linked, not stripped
> 
> If it makes a difference, I am using arcboot.

I suppose then the question is, which is better for IP32?  CONFIG_BUILD_ELF64=y 
or CONFIG_BUILD_ELF64=n.  The reason the o64 hack used to exist, if my memory 
serves me correctly, was that someone once said that when built and run as a 
pure 64bit binary converted to 32bit via objcopy, 6 extra insns were run every 
cycle (I think), introducing unneeded slowdown.  This changed to 2 insns by 
going the o64 route, which involved CONFIG_BUILD_ELF64=n.  So 4 less insns 
technically resulted in a quicker kernel, though the layman might not notice 
such.  I believe that all changed at some point, which is why 
CONFIG_BUILD_ELF64=y was an A-OK thing prior to the __pa() introduction.

Now I guess we're back to CONFIG_BUILD_ELF64=n?  I guess the real question is, 
which way is the OneWay(TM), RightWay(TM) and OnlyWay(TM)?


Cheers,

--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
