Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g71HGjRw007880
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 1 Aug 2002 10:16:45 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g71HGjpc007879
	for linux-mips-outgoing; Thu, 1 Aug 2002 10:16:45 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft16-f78.dialo.tiscali.de [62.246.16.78])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g71HGdRw007870
	for <linux-mips@oss.sgi.com>; Thu, 1 Aug 2002 10:16:40 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g71HI4I23624;
	Thu, 1 Aug 2002 19:18:04 +0200
Date: Thu, 1 Aug 2002 19:18:04 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Carsten Langgaard <carstenl@mips.com>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] MIPS64 R4k TLB refill CP0 hazards
Message-ID: <20020801191804.D22824@dea.linux-mips.net>
References: <20020731223158.A6394@dea.linux-mips.net> <Pine.GSO.3.96.1020801171104.8256E-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020801171104.8256E-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Aug 01, 2002 at 05:24:43PM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Aug 01, 2002 at 05:24:43PM +0200, Maciej W. Rozycki wrote:

>  After looking at the generated assembly I discovered the handlers don't
> fit in 128 bytes.  They didn't crash since I have modules disabled for
> now, so the vmalloc path didn't get hit and the user path happened to fit,
> but it was pure luck.  The path got hit before I fixed a bug in gas though
> -- that's the explanation of the false cache error exceptions I used to
> observe. 

Ouch.  It was a known problem but we simply ignored it for a while as that
handler just overwrites the cache error handler which normally should be
used extremly rarely, if at all.  The problem is somewhat itching by now
as we're supporting the SB1 core which in it's revision one may throw
spurious cache errors, so the handler is actually used ...

  Ralf
