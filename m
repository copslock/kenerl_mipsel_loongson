Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f95AX9200613
	for linux-mips-outgoing; Fri, 5 Oct 2001 03:33:09 -0700
Received: from mind.be (open.your.mind.be [195.162.205.66])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f95AX3D00600
	for <linux-mips@oss.sgi.com>; Fri, 5 Oct 2001 03:33:04 -0700
Received: (qmail 24982 invoked by uid 500); 5 Oct 2001 10:33:00 -0000
Date: Fri, 5 Oct 2001 12:33:00 +0200
From: Ulrik De Bie <ulrik@mind.be>
To: Kristoffer Gleditsch <toffer@ping.uio.no>
Cc: Guido Guenther <agx@debian.org>, debian-mips@lists.debian.org,
   linux-mips@oss.sgi.com
Subject: Re: Need an account on a Linux/Mips box
Message-ID: <20011005123300.C23786@mind.be>
References: <1f05gge.7bt3xkxllentM@[10.0.12.137]> <vzay9n46373.fsf@false.linpro.no> <20010924173723.A2203@bunny.shuttle.de> <vzawv2o4kwe.fsf@false.linpro.no> <20010929122045.A12811@galadriel.physik.uni-konstanz.de> <vzabsjnpftn.fsf@false.linpro.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <vzabsjnpftn.fsf@false.linpro.no>; from toffer@ping.uio.no on Thu, Oct 04, 2001 at 05:47:48PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Oct 04, 2001 at 05:47:48PM +0200, Kristoffer Gleditsch wrote:
> [ Guido Guenther ]
> 
> > Toolchain update problem - recompiling fixes this. I've put recompiled
> > debs at:
> >
> > http://honk.physik.uni-konstanz.de/linux-mips/debian/ssl-tmp/
> 
> Thanks, they seem to work fine.
> 
> Concerning the other R4600 issues: Our R4600 Indy has 11 days of
> uptime now, and Bind 9 is still running fine.  When I switched back to
> ssh from ssh-nonfree just now, the calls to update-alternatives in the
> prerm-file segfaulted repeatedly.  I'm trying to gather the patience
> to debug it now.  :)

Quick and dirty hack that might work (I had quite a number of segfaults during
installation and this trick did work): change the /bin/sh between bash and
ash.

Kind regards,
Ulrik De Bie
