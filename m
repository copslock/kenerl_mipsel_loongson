Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0PHEKX08403
	for linux-mips-outgoing; Fri, 25 Jan 2002 09:14:20 -0800
Received: from river-bank.demon.co.uk (river-bank.demon.co.uk [193.237.18.135])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0PHEHP08391
	for <linux-mips@oss.sgi.com>; Fri, 25 Jan 2002 09:14:17 -0800
Received: from river-bank.demon.co.uk(ratty.river-bank.demon.co.uk[192.168.0.4]) (1024 bytes) by river-bank.demon.co.uk
	via smtpd with P:smtp/R:bind_hosts/T:inet_zone_bind_smtp
	(sender: <phil@river-bank.demon.co.uk>) 
	id <m16U8zV-000SVAC@river-bank.demon.co.uk>
	for <linux-mips@oss.sgi.com>; Fri, 25 Jan 2002 16:14:13 +0000 (GMT)
	(Smail-3.2.0.111 2000-Feb-17 #1 built 2001-Jan-12)
Message-ID: <3C51838A.174F8712@river-bank.demon.co.uk>
Date: Fri, 25 Jan 2002 16:10:50 +0000
From: Phil Thompson <phil@river-bank.demon.co.uk>
Organization: At Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Generic DISCONTIGMEM Support on 32bit MIPS
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I'm working on a port of 32bit MIPS to a board with several large holes
in the memory map. So I need to re-implement paging_init() and
mem_init().

The first question is: has anybody already done this? Particularly as,
once you've identified where the holes are, the code isn't board
specific.

If not then I'll try to work out what needed from the corresponding
mips64 and ip27 code, but I'd appreciate any pointers.

Thanks,
Phil
