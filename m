Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6HEv8Rw025391
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 17 Jul 2002 07:57:08 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6HEv7VW025390
	for linux-mips-outgoing; Wed, 17 Jul 2002 07:57:07 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from rwcrmhc53.attbi.com (rwcrmhc53.attbi.com [204.127.198.39])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6HEv3Rw025380
	for <linux-mips@oss.sgi.com>; Wed, 17 Jul 2002 07:57:03 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by rwcrmhc53.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020717150158.LBHW26053.rwcrmhc53.attbi.com@ocean.lucon.org>;
          Wed, 17 Jul 2002 15:01:58 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 502C6125D8; Wed, 17 Jul 2002 08:01:57 -0700 (PDT)
Date: Wed, 17 Jul 2002 08:01:57 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ulrich Drepper <drepper@redhat.com>, linux-mips@oss.sgi.com,
   GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: PATCH: Always use ll/sc for mips
Message-ID: <20020717080157.B10247@lucon.org>
References: <20020716084208.A21699@lucon.org> <Pine.GSO.3.96.1020717095946.13355C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020717095946.13355C-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Jul 17, 2002 at 10:31:13AM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 17, 2002 at 10:31:13AM +0200, Maciej W. Rozycki wrote:
> On Tue, 16 Jul 2002, H. J. Lu wrote:
> 
> > >  It sucks performance-wise with no visible gain, so I don't think it is
> > > really desireable.  Since the no-ll/sc case is handled correctly, I see no
> > 
> > Only <sys/tas.h> is covered by the kernel interface. But it doesn't
> > cover atomicity.h in glibc and libstdc++.
> 
>  Even if nobody bothered fixing these, that doesn't mean some other code
> is useless.  If you don't want to implement these with _test_and_set(),
> then just put equivalent ll/sc code there, which will work thanks to the
> emulation.  Depending on the operation it may even be faster than
> _test_and_set() as ll/sc provides a generic way to perform atomic
> operations, while using _test_and_set() might require a spinlock. 
> 

I am not against reversing the sysdeps/unix/sysv/linux/mips/sys/tas.h
change. But I am not so excited about it to do it myself.


H.J.
