Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Mar 2005 05:40:58 +0000 (GMT)
Received: from rwcrmhc11.comcast.net ([IPv6:::ffff:204.127.198.35]:2537 "EHLO
	rwcrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8225537AbVCHFkl>; Tue, 8 Mar 2005 05:40:41 +0000
Received: from [192.168.1.4] (pcp05077810pcs.waldrf01.md.comcast.net[68.54.246.193])
          by comcast.net (rwcrmhc11) with ESMTP
          id <2005030805403401300ocl4ke>; Tue, 8 Mar 2005 05:40:35 +0000
Message-ID: <422D3AC9.4020601@gentoo.org>
Date:	Tue, 08 Mar 2005 00:40:25 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Jim Gifford <maillist@jg555.com>
CC:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IPTables 1.3.x fails on RaQ2
References: <422C8D6A.6060904@jg555.com> <422C9142.8090007@gmx.net> <422D0D64.2080402@gentoo.org> <422D2801.2060903@jg555.com>
In-Reply-To: <422D2801.2060903@jg555.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Jim Gifford wrote:
> I just don't understand why iptables needs that file at all, I can't 
> find anything in it that uses it. I'm going to search again, and I will 
> post my results once I figure it out.

iptables doesn't need it.  It's one of those funky #include chains.  include A 
includes B which includes C which includes Q and so on until it tries 
including a file it can't find.  This is because there are a series of mach-* 
machine subdirs in include/asm-mips that each contain headers specific to a 
particular machine type (like spaces.h, among other things).  I haven't delved 
into the specifics (someone else here can explain it more), but when the 
kernel builds, based upon the configuration of the kernel, it knows which 
include/asm-mips/mach-* directory to look in to snag the headers it needs. 
Userland doesn't know this, so for headers used in userland, you need to patch 
things abit.  Otherwise, they break.

http://tinyurl.com/5grah  <-- appCompat patch used in Gentoo's linux-headers 
2.6.10 ebuild.  It lacks mips-specific bits, but you can look at how x86 
handles some of its include/asm-i386/mach-* sections for how we're working 
around these issues.  It's all a hack really, until someone either fixes 
userland to never use kernel headers, or the kernel-side finds a way to create 
userland-friendly headers (but I don't see any of this happening anytime soon).


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: small 
hands do them because they must, while the eyes of the great are elsewhere." 
--Elrond
