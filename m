Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6VILoRw008414
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 31 Jul 2002 11:21:50 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6VILoYW008413
	for linux-mips-outgoing; Wed, 31 Jul 2002 11:21:50 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft17-f75.dialo.tiscali.de [62.246.17.75])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6VILhRw008404
	for <linux-mips@oss.sgi.com>; Wed, 31 Jul 2002 11:21:45 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6VIMxc05139;
	Wed, 31 Jul 2002 20:22:59 +0200
Date: Wed, 31 Jul 2002 20:22:59 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Kevin D. Kissell" <kevink@mips.com>,
   Carsten Langgaard <carstenl@mips.com>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] MIPS64 R4k TLB refill CP0 hazards
Message-ID: <20020731202259.D4892@dea.linux-mips.net>
References: <005001c23863$e077caa0$10eca8c0@grendel> <Pine.GSO.3.96.1020731133556.10088B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020731133556.10088B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Jul 31, 2002 at 01:49:57PM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 31, 2002 at 01:49:57PM +0200, Maciej W. Rozycki wrote:

>  Hmm, I think that's an overkill, although for debugging purposes, a
> single extremely conservative handler (possibly with some status output to
> the log) might be selectable as an alternative.

Look at the C variation of the exception handler in the mips64 code.  It
was pretty useful to add debugging checks during early mips64 development.

  Ralf
