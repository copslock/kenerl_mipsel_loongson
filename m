Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1MIERK16791
	for linux-mips-outgoing; Fri, 22 Feb 2002 10:14:27 -0800
Received: from rwcrmhc52.attbi.com (rwcrmhc52.attbi.com [216.148.227.88])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1MIEO916787
	for <linux-mips@oss.sgi.com>; Fri, 22 Feb 2002 10:14:24 -0800
Received: from ocean.lucon.org ([12.234.16.87]) by rwcrmhc52.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020222171419.YJQL1147.rwcrmhc52.attbi.com@ocean.lucon.org>;
          Fri, 22 Feb 2002 17:14:19 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 6994A125C1; Fri, 22 Feb 2002 09:14:18 -0800 (PST)
Date: Fri, 22 Feb 2002 09:14:17 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Wayne Gowcher <wgowcher@yahoo.com>, Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: pthread support in mipsel-linux
Message-ID: <20020222091417.A17377@lucon.org>
References: <20020222085310.A17035@lucon.org> <Pine.GSO.3.96.1020222175750.5266G-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1020222175750.5266G-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Feb 22, 2002 at 06:06:58PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Feb 22, 2002 at 06:06:58PM +0100, Maciej W. Rozycki wrote:
> On Fri, 22 Feb 2002, H . J . Lu wrote:
> 
> > Mutex is now implemented with spin lock by default. BTW, how many
> 
>  Well, testandset() from linuxthreads/sysdeps/mips/pt-machine.h should
> work fine with -mips1.  As should __pthread_spin_lock() from
> linuxthreads/sysdeps/mips/pspinlock.c. 
> 
> > people have run "make check" on glibc compiled -mips1?
> 
>  No idea.  I may run `./configure && make all && make check' tonight on my
> system as it's going to be idle over the weekend anyway.  It should finish
> by Monday. ;-) 

You should also try "make check" on the current gcc 3.1. I found and
fixed the MIPS II ll/sc bugs by doing that.


H.J.
