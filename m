Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6V0YHw18330
	for linux-mips-outgoing; Mon, 30 Jul 2001 17:34:17 -0700
Received: from solo.franken.de (pD9054444.dip.t-dialin.net [217.5.68.68])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6V0YFV18327
	for <linux-mips@oss.sgi.com>; Mon, 30 Jul 2001 17:34:16 -0700
Received: (from tsbogend@localhost)
	by solo.franken.de (8.9.3/8.9.3) id CAA06404;
	Tue, 31 Jul 2001 02:32:45 +0200
Date: Tue, 31 Jul 2001 02:32:45 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, Dave Airlie <airlied@csn.ul.ie>,
   SGI MIPS list <linux-mips@oss.sgi.com>,
   Debian MIPS list <debian-mips@lists.debian.org>, engel@unix-ag.org
Subject: Re: [long] Lance on DS5k/200
Message-ID: <20010731023245.A6371@solo.franken.de>
References: <Pine.LNX.4.32.0107291413510.11630-100000@skynet> <Pine.GSO.3.96.1010730220512.19618B-100000@delta.ds2.pg.gda.pl> <20010731002421.A19713@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010731002421.A19713@lug-owl.de>; from jbglaw@lug-owl.de on Tue, Jul 31, 2001 at 12:24:21AM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 31, 2001 at 12:24:21AM +0200, Jan-Benedict Glaw wrote:
> Of course. I wouldn't even *try* to do sth other. In fact, I'm looking
> around for various specs of various implementations (as seen from
> the bus) of the LANCE chip to see if I could manage the job to
> unify them all together:

> ./drivers/net/pcnet32.c				none mentioned

even if it's based on the lance design from AMD (and it support a lance
compatible mode), you won't be able to unify this driver with other lance
drivers since the driver uses the 32bit mode of the pcnet32 chip familiy
79C97[0-8]).

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                 [ Alexander Viro on linux-kernel ]
