Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Apr 2003 17:00:38 +0100 (BST)
Received: from p508B638F.dip.t-dialin.net ([IPv6:::ffff:80.139.99.143]:26788
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225073AbTDUQAe>; Mon, 21 Apr 2003 17:00:34 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3LG0Ve28936
	for linux-mips@linux-mips.org; Mon, 21 Apr 2003 18:00:31 +0200
Date: Mon, 21 Apr 2003 18:00:31 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20030421180031.A25331@linux-mips.org>
References: <20030421125733Z8225073-1272+1478@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030421125733Z8225073-1272+1478@linux-mips.org>; from sjhill@linux-mips.org on Mon, Apr 21, 2003 at 01:57:28PM +0100
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 21, 2003 at 01:57:28PM +0100, sjhill@linux-mips.org wrote:

> Modified files:
> 	drivers/net    : Tag: linux_2_4 au1000_eth.c 
> 
> Log message:
> 	Reserve the ethernet port address, no it's actual virtual address.

That's a kludge on top of a kludge.  This driver like so many others is
mixing up all sort of concepts of I/O in a creative way to the point
where things coincidentally happen to work:

 - Addresses in au1x00_iflist are KSEG1 addresses that is virtual addresses.
   So that is a properly ioremapped address, right?  No ...
 - struct au1if only has an unsigned int.  Decide - if this is a virtual
   address then use unsigned long.
 - au1000_probe1 passes those addresses (with your patch: converted to a
   physical address) to request_resource.  Physical addresses and ports are
   different things.  You're using request_resource, so that address must
   be an I/O port, right?
 - ((unsigned long)AU1000_MAC1_ENABLE) - code like that is treating as
   a virtual address again ...

That's just inconsistenst and seems to have done without much understanding
the difference between memory mappend I/O and I/O ports.  I suggest to use
physical addresses and ioremap only and forget about that pre-8088 I/O port
legacy ...

  Ralf
