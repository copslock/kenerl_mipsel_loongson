Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8OGOT703294
	for linux-mips-outgoing; Mon, 24 Sep 2001 09:24:29 -0700
Received: from linpro.no (qmailr@mail.linpro.no [213.203.57.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8OGONe03288
	for <linux-mips@oss.sgi.com>; Mon, 24 Sep 2001 09:24:23 -0700
Received: (qmail 13296 invoked from network); 24 Sep 2001 16:24:17 -0000
Received: from false.linpro.no (213.203.57.201)
  by mail.linpro.no with SMTP; 24 Sep 2001 16:24:17 -0000
Received: from toffer by false.linpro.no with local (Exim 3.22 #1 (Debian))
	id 15lYWn-0005Xv-00; Mon, 24 Sep 2001 18:24:17 +0200
To: Raoul Borenius <borenius@shuttle.de>
Cc: debian-mips@lists.debian.org, linux-mips@oss.sgi.com
Subject: Re: Need an account on a Linux/Mips box
References: <1f05gge.7bt3xkxllentM@[10.0.12.137]>
	<vzay9n46373.fsf@false.linpro.no>
	<20010924173723.A2203@bunny.shuttle.de>
From: Kristoffer Gleditsch <kristoffer@linpro.no>
Organization: Linpro AS, Oslo, Norway
Date: Mon, 24 Sep 2001 18:24:17 +0200
Message-ID: <vzawv2o4kwe.fsf@false.linpro.no>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

[ Raoul Borenius ]

> Does it run without any problems?

Apart from sshd (OpenSSH), which started dying from SIGFPE (floating
point exception, whatever that means :) a few days ago, it's working
OK.

> What kernel (with what patches?)  are you running. I'm having
> troubles running our R4600-Indy:

We're running 2.4.5 from CVS (~ 2001-08-08) with the sysmips-patch,
self compiled with gcc 2.95.4.

(If you're interested, both the kernel and the patch can be found at
http://www.ping.uio.no/~toffer/linux-mips/.)

> - Perl is seg-faulting (especially when a perl-script is calling
> another)

Hm.  It's not entirely unusual for dist-upgrades to segfault in
various pre- and post-installation scripts.  That doesn't happen very
often, though, and it seems to be the same packages every time
(e.g. zsh), so I'm not sure whether it is a Perl problem or not.  I'll
try to take a closer look at it next time it happens.

> - bind9 hangs after a few days

I installed bind9 on the development box now, to see if I can
reproduce it.

> - occasionally the box just stalls and returns to the bootprom 
> - sometimes it just dies and we have to power-cycle it

Apart from xdm, which oopses all our Indys, I have seen very few
crashes like this on the various Indys I use.  They are great X
terminals.  :)

-- 
Kristoffer.
