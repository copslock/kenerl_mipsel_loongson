Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0QBfH110746
	for linux-mips-outgoing; Sat, 26 Jan 2002 03:41:17 -0800
Received: from river-bank.demon.co.uk (river-bank.demon.co.uk [193.237.18.135])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0QBf5P10722;
	Sat, 26 Jan 2002 03:41:06 -0800
Received: from river-bank.demon.co.uk(ratty.river-bank.demon.co.uk[192.168.0.4]) (1574 bytes) by river-bank.demon.co.uk
	via smtpd with P:smtp/R:bind_hosts/T:inet_zone_bind_smtp
	(sender: <phil@river-bank.demon.co.uk>) 
	id <m16UQGe-000SUwC@river-bank.demon.co.uk>
	for <linux-mips@oss.sgi.com>; Sat, 26 Jan 2002 10:41:04 +0000 (GMT)
	(Smail-3.2.0.111 2000-Feb-17 #1 built 2001-Jan-12)
Message-ID: <3C5286ED.497B2E82@river-bank.demon.co.uk>
Date: Sat, 26 Jan 2002 10:37:34 +0000
From: Phil Thompson <phil@river-bank.demon.co.uk>
Organization: At Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Generic DISCONTIGMEM Support on 32bit MIPS
References: <3C51838A.174F8712@river-bank.demon.co.uk> <20020125124429.A961@dea.linux-mips.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> On Fri, Jan 25, 2002 at 04:10:50PM +0000, Phil Thompson wrote:
> 
> > I'm working on a port of 32bit MIPS to a board with several large holes
> > in the memory map. So I need to re-implement paging_init() and
> > mem_init().
> >
> > The first question is: has anybody already done this? Particularly as,
> > once you've identified where the holes are, the code isn't board
> > specific.
> >
> > If not then I'll try to work out what needed from the corresponding
> > mips64 and ip27 code, but I'd appreciate any pointers.
> 
> Great, I was already planning to do this next.  Discontiguous memory is a
> common problem on MIPS systems; it's almost standard for systems that
> have more than 256mb of memory.

You may still be quicker as I'm starting from a position of almost
complete ignorance.

Phil
