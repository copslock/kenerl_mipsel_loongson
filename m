Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Jun 2005 04:29:11 +0100 (BST)
Received: from sccrmhc14.comcast.net ([IPv6:::ffff:204.127.202.59]:47542 "EHLO
	sccrmhc14.comcast.net") by linux-mips.org with ESMTP
	id <S8225576AbVFYD2y>; Sat, 25 Jun 2005 04:28:54 +0100
Received: from [192.168.1.4] (pcp0011842295pcs.waldrf01.md.comcast.net[69.251.97.45])
          by comcast.net (sccrmhc14) with ESMTP
          id <20050625032800014004f1pse>; Sat, 25 Jun 2005 03:28:00 +0000
Message-ID: <42BCD015.5030803@gentoo.org>
Date:	Fri, 24 Jun 2005 23:31:33 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Prashant Viswanathan <vprashant@echelon.com>
CC:	linux-mips@linux-mips.org
Subject: Re: glibc based toolchain for mips
References: <5375D9FB1CC3994D9DCBC47C344EEB5905FA4351@miles.echelon.echcorp.com>
In-Reply-To: <5375D9FB1CC3994D9DCBC47C344EEB5905FA4351@miles.echelon.echcorp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Prashant Viswanathan wrote:
> 
> Thanks. But what I am really looking for is to cross-compile on a Linux i386
> host. I think the SDE from MIPS can be customized to do this. But I am not
> sure on how to proceed. Perhaps somebody can point me in the right
> direction...

If you have an x86 box running Gentoo, there's the `sys-devel/crossdev` package 
for generating a wide variety of cross-compilers.  If you're running another 
distribution, you'll want to check out Dan Kegel's `crosstool` package at: 
http://kegel.com/crosstool/


--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
