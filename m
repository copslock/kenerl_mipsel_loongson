Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Mar 2005 09:13:05 +0000 (GMT)
Received: from i-83-67-53-76.freedom2surf.net ([IPv6:::ffff:83.67.53.76]:60309
	"EHLO skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225552AbVCZJMu>; Sat, 26 Mar 2005 09:12:50 +0000
Received: from pdh by skeleton-jack.localnet with local (Exim 3.36 #1 (Debian))
	id 1DF7L8-0000fF-00; Sat, 26 Mar 2005 09:12:18 +0000
Date:	Sat, 26 Mar 2005 09:12:18 +0000
To:	Jim Gifford <maillist@jg555.com>
Cc:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Build 64bit on RaQ2
Message-ID: <20050326091218.GA2471@skeleton-jack>
References: <42449F47.8010002@jg555.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42449F47.8010002@jg555.com>
User-Agent: Mutt/1.5.6+20040907i
From:	Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 25, 2005 at 03:31:19PM -0800, Jim Gifford wrote:
>   Has anyone had any luck compiling a 64 bit version on the RaQ2. I can 
> get it to compile but, it locks up during boot up.
> 
> elf64: 00080000 - 0042fd3f (ffffffff,803e6000) (ffffffff,8000000)
> elf64: ffffffff,80080000 (8008000) 3731589t + 134331t
> 
> That's all I got during bootup, no error messages or anything.
> 

As a starting point you need to ensure the "cpu_has_llsc" is false for
64-bit Cobalt kernels. LLD/SCD is broken on RM5230/5231. There is an
experimental patch for 2.6.9 on
http://www.colonel-panic.org/cobalt-mips.

P.
