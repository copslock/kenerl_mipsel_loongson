Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1MHvTQ16370
	for linux-mips-outgoing; Fri, 22 Feb 2002 09:57:29 -0800
Received: from rwcrmhc54.attbi.com (rwcrmhc54.attbi.com [216.148.227.87])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1MHvR916367
	for <linux-mips@oss.sgi.com>; Fri, 22 Feb 2002 09:57:27 -0800
Received: from ocean.lucon.org ([12.234.16.87]) by rwcrmhc54.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020222165721.YOMU1214.rwcrmhc54.attbi.com@ocean.lucon.org>;
          Fri, 22 Feb 2002 16:57:21 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 085CD125C1; Fri, 22 Feb 2002 08:57:20 -0800 (PST)
Date: Fri, 22 Feb 2002 08:57:20 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Wayne Gowcher <wgowcher@yahoo.com>, Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: pthread support in mipsel-linux
Message-ID: <20020222085720.B17035@lucon.org>
References: <20020221102503.A28936@lucon.org> <Pine.GSO.3.96.1020222143540.5266C-100000@delta.ds2.pg.gda.pl> <20020222085310.A17035@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020222085310.A17035@lucon.org>; from hjl@lucon.org on Fri, Feb 22, 2002 at 08:53:10AM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Feb 22, 2002 at 08:53:10AM -0800, H . J . Lu wrote:
> On Fri, Feb 22, 2002 at 02:38:53PM +0100, Maciej W. Rozycki wrote:
> > On Thu, 21 Feb 2002, H . J . Lu wrote:
> > 
> > > > Just to clarify, the glibc rpm in your Redhat 7.1 is
> > > > compiled with -mips1 right ? So as it is broken yes ?
> > > 
> > > Yes. -mips1 doesn't work well with thread.
> > 
> >  What's wrong with -mips1 currently?  It used to be OK around glibc 2.2 --
> > has anything changed since then that needs -mips1 to be fixed?
> > 
> 
> Mutex is now implemented with spin lock by default. BTW, how many
> people have run "make check" on glibc compiled -mips1?

Also, how many people have bootstrapped and run "make check" on gcc
3.1 from CVS on Linux/mips with glibc compiled with -mips1?  There are
some thread tests in libstdc++-v3.


H.J.
