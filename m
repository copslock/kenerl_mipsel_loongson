Received:  by oss.sgi.com id <S42392AbQI2JsY>;
	Fri, 29 Sep 2000 02:48:24 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:58544 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S42190AbQI2JsJ>;
	Fri, 29 Sep 2000 02:48:09 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA17417;
	Fri, 29 Sep 2000 11:46:57 +0200 (MET DST)
Date:   Fri, 29 Sep 2000 11:46:57 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Klaus Naumann <spock@mgnet.de>
cc:     Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: Decstation broken Was: CVS Update@oss.sgi.com: linux
In-Reply-To: <20000929075035.A23290@spock>
Message-ID: <Pine.GSO.3.96.1000929113820.16748B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 29 Sep 2000, Klaus Naumann wrote:

> When I call it it's sleeping for several seconds.
> And after that I get
> 
> 29 Sep 07:49:37 ntpdate[10880]: poll(): nfound = 0, error: Operation not
> permitted
> 
> which seems to loop then.
> If I would have a working strace on my box I could tell you more :/

 But gdb works -- try this one instead.

> > I recently found that the Indigo2 apparently has a different realtime
> > clock from the Indy.  If that's true it explains your observation and
> > is unrelated the other problems.
> 
> Yes, it's of course unrelated to the other problem - it's just
> an explanation why ntpdate is of real use.

 Well, all programs from the xntp3 distribution do work for me.  This may
also be a glibc issue -- I'm using glibc 2.2 only and this provides a
better API for NTP (clock_settime() and friends).  I'll double-check that
settimeofday() works right, too.

 But note that my patches do really affect only the DEC tree.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
