Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f94Flxd14728
	for linux-mips-outgoing; Thu, 4 Oct 2001 08:47:59 -0700
Received: from linpro.no (qmailr@mail.linpro.no [213.203.57.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f94FluD14725
	for <linux-mips@oss.sgi.com>; Thu, 4 Oct 2001 08:47:57 -0700
Received: (qmail 5024 invoked from network); 4 Oct 2001 15:47:54 -0000
Received: from false.linpro.no (213.203.57.201)
  by mail.linpro.no with SMTP; 4 Oct 2001 15:47:54 -0000
Received: from toffer by false.linpro.no with local (Exim 3.22 #1 (Debian))
	id 15pAiy-0007iJ-00; Thu, 04 Oct 2001 17:47:48 +0200
To: Guido Guenther <agx@debian.org>
Cc: debian-mips@lists.debian.org, linux-mips@oss.sgi.com
Subject: Re: Need an account on a Linux/Mips box
References: <1f05gge.7bt3xkxllentM@[10.0.12.137]>
	<vzay9n46373.fsf@false.linpro.no>
	<20010924173723.A2203@bunny.shuttle.de>
	<vzawv2o4kwe.fsf@false.linpro.no>
	<20010929122045.A12811@galadriel.physik.uni-konstanz.de>
From: Kristoffer Gleditsch <toffer@ping.uio.no>
Organization: Millennium Hand And Shrimp Society
Date: Thu, 04 Oct 2001 17:47:48 +0200
Message-ID: <vzabsjnpftn.fsf@false.linpro.no>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

[ Guido Guenther ]

> Toolchain update problem - recompiling fixes this. I've put recompiled
> debs at:
>
> http://honk.physik.uni-konstanz.de/linux-mips/debian/ssl-tmp/

Thanks, they seem to work fine.

Concerning the other R4600 issues: Our R4600 Indy has 11 days of
uptime now, and Bind 9 is still running fine.  When I switched back to
ssh from ssh-nonfree just now, the calls to update-alternatives in the
prerm-file segfaulted repeatedly.  I'm trying to gather the patience
to debug it now.  :)

-- 
Kristoffer.
