Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6NEn6Rw028520
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 23 Jul 2002 07:49:06 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6NEn6bq028519
	for linux-mips-outgoing; Tue, 23 Jul 2002 07:49:06 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft17-f249.dialo.tiscali.de [62.246.17.249])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6NEn0Rw028510
	for <linux-mips@oss.sgi.com>; Tue, 23 Jul 2002 07:49:02 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6NEniB31573;
	Tue, 23 Jul 2002 16:49:44 +0200
Date: Tue, 23 Jul 2002 16:49:44 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux: cpu_probe(): remove 32-bit CPU bits for MIPS64
Message-ID: <20020723164944.A31534@dea.linux-mips.net>
References: <Pine.GSO.3.96.1020722222909.2373P-100000@delta.ds2.pg.gda.pl> <003b01c23256$b262f080$1604c0d8@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <003b01c23256$b262f080$1604c0d8@Ulysses>; from kevink@mips.com on Tue, Jul 23, 2002 at 04:38:58PM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 23, 2002 at 04:38:58PM +0200, Kevin D. Kissell wrote:

> My personal bleief is that the mips and mips64 trees 
> should ultimately be merged, and that creating additional 
> and gratuitous differences should be avoided.

A first attempt at building a unifying 32-bit and 64-bit kernel was so
ugly that I dumped all that as of 2.0.14.

  Ralf
