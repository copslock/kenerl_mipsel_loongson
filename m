Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f56EFR818628
	for linux-mips-outgoing; Wed, 6 Jun 2001 07:15:27 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f56EFQh18624
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 07:15:26 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 95815125BA; Wed,  6 Jun 2001 07:15:25 -0700 (PDT)
Date: Wed, 6 Jun 2001 07:15:25 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@oss.sgi.com
Subject: Re: New toolchain for Linux/mips
Message-ID: <20010606071525.A19423@lucon.org>
References: <20010605220605.A10997@lucon.org> <Pine.GSO.3.96.1010606123704.23232B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010606123704.23232B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Jun 06, 2001 at 12:44:04PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jun 06, 2001 at 12:44:04PM +0200, Maciej W. Rozycki wrote:
> On Tue, 5 Jun 2001, H . J . Lu wrote:
> 
> > 2. gdb in RedHat 7.1 has yet to be ported to mips. Without a working
> > gdb, it is very hard to fix 1.
> 
>  Gdb 5.0 works for me (and a few other people, I think).  Check
> 'ftp://ftp.ds2.pg.gda.pl/pub/macro/SRPMS/gdb-5.0-6.src.rpm'.  Most of the
> patches have been submitted.  The only remaining one is the port of 4.17

This is a very old gdb. Since gdb has changed a lot at the same
time, if the patches haven't been installed, we may have to redo them.
I'd like to see Linux/mips as a supported target in gdb. gdb in RedHat
7.1 is quite current. Also, my new toolchain uses stabs, not ecoff.
It may need some work.


H.J.
