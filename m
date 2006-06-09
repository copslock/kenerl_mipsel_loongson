Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jun 2006 02:16:07 +0100 (BST)
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:11409 "EHLO
	rwcrmhc12.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8133646AbWFIBP6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Jun 2006 02:15:58 +0100
Received: from [127.0.0.1] (unknown[69.140.185.142])
          by comcast.net (rwcrmhc12) with ESMTP
          id <20060609011551m1200o6511e>; Fri, 9 Jun 2006 01:15:52 +0000
Message-ID: <4488CBCC.4090405@gentoo.org>
Date:	Thu, 08 Jun 2006 21:15:56 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	"Joseph S. Myers" <joseph@codesourcery.com>
Subject: Re: N32 sigset and __COMPAT_ENDIAN_SWAP__
References: <Pine.LNX.4.64.0606080134480.26638@digraph.polyomino.org.uk> <20060608165136.GA17152@linux-mips.org> <Pine.LNX.4.64.0606081706310.7925@digraph.polyomino.org.uk>
In-Reply-To: <Pine.LNX.4.64.0606081706310.7925@digraph.polyomino.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Joseph S. Myers wrote:
> 
> I might conclude that barely anybody is *yet* using NPTL on 64-bit MIPS at 
> all, for either endianness, given that most of the problems I've been 
> finding, in glibc as well as the kernel, don't seem endian-specific and 
> would probably show up in a glibc testsuite run for either endianness.  
> MIPS64 NPTL is very new and seems to do a good job of showing up bugs in 
> the three syscall interfaces.

I'm actually going to start running some automated builds of a nptl/o32 and 
nptl/n32 userland over the next few days.  If you have any patches that need 
testing to correct known oddities, I can give them a run in these builds.


--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
