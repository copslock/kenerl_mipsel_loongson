Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7L00wEC013428
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 17:00:58 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7L00wVD013427
	for linux-mips-outgoing; Tue, 20 Aug 2002 17:00:58 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sccrmhc02.attbi.com (sccrmhc02.attbi.com [204.127.202.62])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7L00qEC013418
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 17:00:53 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by sccrmhc02.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020820151102.HKPN13899.sccrmhc02.attbi.com@ocean.lucon.org>;
          Tue, 20 Aug 2002 15:11:02 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id BA40F125D9; Tue, 20 Aug 2002 08:10:58 -0700 (PDT)
Date: Tue, 20 Aug 2002 08:10:58 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Daniel Jacobowitz <dan@debian.org>, linux-mips@oss.sgi.com,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: New binutils for kernel
Message-ID: <20020820081058.A29182@lucon.org>
References: <20020819171238.A7457@linux-mips.org> <Pine.GSO.3.96.1020820161204.8700H-100000@delta.ds2.pg.gda.pl> <20020820162959.A26852@linux-mips.org> <20020820145051.GA17311@nevyn.them.org> <20020820165835.B26852@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020820165835.B26852@linux-mips.org>; from ralf@linux-mips.org on Tue, Aug 20, 2002 at 04:58:35PM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Aug 20, 2002 at 04:58:35PM +0200, Ralf Baechle wrote:
> On Tue, Aug 20, 2002 at 10:50:51AM -0400, Daniel Jacobowitz wrote:
> 
> > > So any comments?
> > 
> > Well, I think 2.13's a good idea, but it's very new.  I'd say that was
> > acceptable as long as you're looking at MIPS64 only, not at MIPS32. 
> 
> Such considerations have kept us back at antique levels of binutils.  And
> juggling with several different versions for userland, and two kernel
> flavours is evil ...

I have no problems with binutils 2.13.90.0.4 on Linux/mips. I rebuild
everything, from kernel to rpms, for Linux/mipsel with it. They seem
to run fine.


H.J.
