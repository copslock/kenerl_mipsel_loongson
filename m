Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0PLiZt28123
	for linux-mips-outgoing; Fri, 25 Jan 2002 13:44:35 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g0PLiXP28117
	for <linux-mips@oss.sgi.com>; Fri, 25 Jan 2002 13:44:33 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id g0PKiT201623;
	Fri, 25 Jan 2002 12:44:29 -0800
Date: Fri, 25 Jan 2002 12:44:29 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: Phil Thompson <phil@river-bank.demon.co.uk>
Cc: linux-mips@oss.sgi.com
Subject: Re: Generic DISCONTIGMEM Support on 32bit MIPS
Message-ID: <20020125124429.A961@dea.linux-mips.net>
References: <3C51838A.174F8712@river-bank.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C51838A.174F8712@river-bank.demon.co.uk>; from phil@river-bank.demon.co.uk on Fri, Jan 25, 2002 at 04:10:50PM +0000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jan 25, 2002 at 04:10:50PM +0000, Phil Thompson wrote:

> I'm working on a port of 32bit MIPS to a board with several large holes
> in the memory map. So I need to re-implement paging_init() and
> mem_init().
> 
> The first question is: has anybody already done this? Particularly as,
> once you've identified where the holes are, the code isn't board
> specific.
> 
> If not then I'll try to work out what needed from the corresponding
> mips64 and ip27 code, but I'd appreciate any pointers.

Great, I was already planning to do this next.  Discontiguous memory is a
common problem on MIPS systems; it's almost standard for systems that
have more than 256mb of memory.

  Ralf
