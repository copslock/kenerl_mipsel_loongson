Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 00:03:58 +0000 (GMT)
Received: from p508B6845.dip.t-dialin.net ([IPv6:::ffff:80.139.104.69]:62657
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225199AbTCMAD5>; Thu, 13 Mar 2003 00:03:57 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h2D03n606685;
	Thu, 13 Mar 2003 01:03:49 +0100
Date: Thu, 13 Mar 2003 01:03:49 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Hilik Stein <hilik@netvision.net.il>
Cc: linux-mips@linux-mips.org
Subject: Re: allocating a large memory area
Message-ID: <20030313010349.B29568@linux-mips.org>
References: <438113fe62.3fe6243811@netvision.net.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <438113fe62.3fe6243811@netvision.net.il>; from hilik@netvision.net.il on Wed, Mar 12, 2003 at 01:28:02PM +0200
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 12, 2003 at 01:28:02PM +0200, Hilik Stein wrote:

> i am building a kernel based fast packet handler which runs on kernel 
> 2.4.20. 
> my code resides inside the kernel, which is running on sb1 core. 
> i need to allocate a large memory region for my data (32MB), which is far 
> beyond what kmalloc can provide for me. 
> i do not want to use vmalloc, since it will allocate the memory out of 
> KSEG2, which is too slow and will generate too many exceptions when i 
> have to access my data randomly. 
> i was thinking of limiting the linux from accessing the highest physical 
> 32MB by using "mem=224M" kernel command line parameter. this was i 
> can access my data using 0x8e000000 through KSEG1. 

0x8e000000 a KSEG0 address.  If you care about performance you don't want
to use KSEG1 :)

> is this safe ? anything i need to consider before moving forward with that 
> approach ? 

It's the only sensible approach.  __get_free_pages()'s limit for allocation
is order 10 by default which would like to PAGE_SIZE * 2^10 = 4MB by
default.  Increasing is possible by setting the config symbol
CONFIG_FORCE_MAX_ZONEORDER to the desired value - but that doesn't seem
like a good idea for a one-time allocation as it affects performance and
has heavy fragmentation issues.

kmalloc isn't suitable either.  It's got it's own limit of 128k which could
be raised but that doesn't make much sense for other reasons including the
fact that kmalloc is implemented on top of the gfp so the issues in the
last paragraph apply as well.

  Ralf
