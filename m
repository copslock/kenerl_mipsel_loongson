Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8OFbU602024
	for linux-mips-outgoing; Mon, 24 Sep 2001 08:37:30 -0700
Received: from bunny.shuttle.de (bunny.shuttle.de [193.174.247.132])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8OFbPe02021
	for <linux-mips@oss.sgi.com>; Mon, 24 Sep 2001 08:37:25 -0700
Received: by bunny.shuttle.de (Postfix, from userid 112)
	id 5DAEF4AC04; Mon, 24 Sep 2001 17:37:23 +0200 (CEST)
Date: Mon, 24 Sep 2001 17:37:23 +0200
From: Raoul Borenius <borenius@shuttle.de>
To: Kristoffer Gleditsch <kristoffer@linpro.no>
Cc: debian-mips@lists.debian.org, linux-mips@oss.sgi.com
Subject: Re: Need an account on a Linux/Mips box
Message-ID: <20010924173723.A2203@bunny.shuttle.de>
References: <1f05gge.7bt3xkxllentM@[10.0.12.137]> <vzay9n46373.fsf@false.linpro.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vzay9n46373.fsf@false.linpro.no>
User-Agent: Mutt/1.3.22i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Kristoffer,

On Mon, Sep 24, 2001 at 05:03:44PM +0200, Kristoffer Gleditsch wrote:
> Hi,
> 
> (Crossposted to the debian-mips list, in case there are others who are
> interested.)
> 
> [ Emmanuel Dreyfus ]
> 
> > I'm working on Linux compatibility on NetBSD/Mips. In order to
> > implement things such as signals, I need a user account on a big
> > endian Linux/Mips system.
> 
> We have an SGI Indy (R4600 100Mhz CPU, 96MB RAM, 6.5GB HD) running
> Debian (Sid) which is available for developers who need access to a
> MIPS computer.  Please email me if you want an account.

Does it run without any problems? What kernel (with what patches?) are you
running. I'm having troubles running our R4600-Indy:

- Perl is seg-faulting (especially when a perl-script is calling another)
- bind9 hangs after a few days
- occasionally the box just stalls and returns to the bootprom
- sometimes it just dies and we have to power-cycle it

I'm using kernel-image-2.4.5 from debian but we've had these problems
all through 2.4.x.

Would be nice to hear if anyone has managed to get 2.4.x running on
an R4600 without problems. R4000 and R5000 seems to be ok according to this
list...

Regards

Raoul

 ---------------------------------------------------------------------
 Raoul Gunnar Borenius		Deutsches Forschungsnetz e.V.
 WiNShuttle			Lindenspürstr.32, 70176 Stuttgart
 Phone  : +49 711 63314-206	FAX: +49 711 63314-133
 E-Mail : borenius@shuttle.de	http://www.shuttle.de
 ---------------------------------------------------------------------
