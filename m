Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBJEtvI25797
	for linux-mips-outgoing; Wed, 19 Dec 2001 06:55:57 -0800
Received: from the-village.bc.nu (lightning.swansea.linux.org.uk [194.168.151.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBJEtso25794
	for <linux-mips@oss.sgi.com>; Wed, 19 Dec 2001 06:55:54 -0800
Received: from alan by the-village.bc.nu with local (Exim 3.22 #1)
	id 16GhG0-0002zb-00; Wed, 19 Dec 2001 13:59:40 +0000
Subject: Re: ISA
To: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 19 Dec 2001 13:59:40 +0000 (GMT)
Cc: macro@ds2.pg.gda.pl (Maciej W. Rozycki), jsun@mvista.com (Jun Sun),
   jim@jtan.com, linux-mips@oss.sgi.com (Linux/MIPS Development)
In-Reply-To: <Pine.GSO.4.21.0112191046380.28694-100000@vervain.sonytel.be> from "Geert Uytterhoeven" at Dec 19, 2001 10:52:47 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16GhG0-0002zb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> You must _not_ use readb()/writeb() and friends with ISA memory space!
> You must use isa_readb()/isa_writeb() and friends!

Linus is saying the reverse. Drivers are moving away from isa_

> But for memory accesses, ISA memory space is not necessarily at `address 0'.

ioremap uses ookies, its up to yoyu what you hide in the cookie from an ISA
ioremap
