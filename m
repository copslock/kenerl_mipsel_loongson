Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6GFbNRw000424
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 16 Jul 2002 08:37:23 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6GFbNsb000423
	for linux-mips-outgoing; Tue, 16 Jul 2002 08:37:23 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from rwcrmhc52.attbi.com (rwcrmhc52.attbi.com [216.148.227.88])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6GFbJRw000412
	for <linux-mips@oss.sgi.com>; Tue, 16 Jul 2002 08:37:19 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by rwcrmhc52.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020716154210.TKZF8262.rwcrmhc52.attbi.com@ocean.lucon.org>;
          Tue, 16 Jul 2002 15:42:10 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id CA693125D8; Tue, 16 Jul 2002 08:42:08 -0700 (PDT)
Date: Tue, 16 Jul 2002 08:42:08 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ulrich Drepper <drepper@redhat.com>, linux-mips@oss.sgi.com,
   GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: PATCH: Always use ll/sc for mips
Message-ID: <20020716084208.A21699@lucon.org>
References: <1026781165.3673.11.camel@myware.mynet> <Pine.GSO.3.96.1020716171505.20654S-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020716171505.20654S-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Jul 16, 2002 at 05:22:36PM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 16, 2002 at 05:22:36PM +0200, Maciej W. Rozycki wrote:
> On 15 Jul 2002, Ulrich Drepper wrote:
> 
> > > The ll/sc emulation is implemented in 2.4.0 and above. This patch makes
> > > glibc always use ll/sc.
> > 
> > Since I haven't seen any objections I've checked this patch in.
> 
>  [I must have missed the original mail, sorry.]
> 
>  It sucks performance-wise with no visible gain, so I don't think it is
> really desireable.  Since the no-ll/sc case is handled correctly, I see no

Only <sys/tas.h> is covered by the kernel interface. But it doesn't
cover atomicity.h in glibc and libstdc++.

> reason to remove the code.  The kernel interface is awkward, I admit, but
> it works (and is even handcoded in assembly for performance gain) and we
> may able to develop a better one eventually.
> 


H.J.
