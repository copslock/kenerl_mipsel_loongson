Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Mar 2005 13:47:09 +0000 (GMT)
Received: from sccrmhc11.comcast.net ([IPv6:::ffff:204.127.202.55]:56986 "EHLO
	sccrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8225750AbVCHNqy>; Tue, 8 Mar 2005 13:46:54 +0000
Received: from [192.168.1.4] (pcp05077810pcs.waldrf01.md.comcast.net[68.54.246.193])
          by comcast.net (sccrmhc11) with ESMTP
          id <20050308134648011005nv4re>; Tue, 8 Mar 2005 13:46:48 +0000
Message-ID: <422DACBF.4040108@gentoo.org>
Date:	Tue, 08 Mar 2005 08:46:39 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IPTables 1.3.x fails on RaQ2
References: <422C8D6A.6060904@jg555.com> <422C9142.8090007@gmx.net> <422D0D64.2080402@gentoo.org> <422D2801.2060903@jg555.com> <422D3AC9.4020601@gentoo.org> <422D4A49.9020504@gmx.net> <422D55B6.4010300@jg555.com>
In-Reply-To: <422D55B6.4010300@jg555.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Jim Gifford wrote:
> I found the culprit, but don't know what the proper fix is.
> 
> File - What to remove or comment out
> /usr/src/linux/include/asm/cpu-features.h - #include 
> <cpu-feature-overrides.h>
> /usr/src/linux/include/asm/addrspace.h -  #include <spaces.h>
> 
> But it still fails, because it looks at the headers in /usr/include and 
> the ones is /usr/src/linux/include, which is what the problem is. Namely 
> socket.h
> 
> What I noticed is some of the mips architectures includes have these 
> files and some do not.
> 
> A workaround for those who use the linux-libc-headers to build iptables 
> with the following commands, but I would still comment out those files 
> to prevent other build issues later
> 
> make KERNEL_DIR=/usr
> 
> But I'm not sure of the stability and the functionality.

You need to patch the headers for these things -- i.e.:

#include <cpu-feature-overrides.h>

becomes

#include <asm/mach-generic/cpu-feature-overrides.h>

Same goes for references to spaces.h, and most other files directly referenced 
as '#include <file.h>' in 'include/asm-mips/*'.  mach-generic is best suited 
for this despite the actual machine because these are geared for userland, and 
userland shouldn't really care about what particular mips machine it's running on.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: small 
hands do them because they must, while the eyes of the great are elsewhere." 
--Elrond
