Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4KJ59nC013104
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 20 May 2002 12:05:09 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4KJ58vP013100
	for linux-mips-outgoing; Mon, 20 May 2002 12:05:08 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4KJ55nC013088
	for <linux-mips@oss.sgi.com>; Mon, 20 May 2002 12:05:05 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g4KJ5qE14959;
	Mon, 20 May 2002 12:05:52 -0700
Date: Mon, 20 May 2002 12:05:52 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Jun Sun <jsun@mvista.com>, Daniel Jacobowitz <dan@debian.org>,
   Matthew Dharm <mdharm@momenco.com>, Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: MIPS 64?
Message-ID: <20020520120552.C14066@dea.linux-mips.net>
References: <20020519123059.E20670@dea.linux-mips.net> <Pine.GSO.3.96.1020520120546.19733B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020520120546.19733B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, May 20, 2002 at 12:06:45PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, May 20, 2002 at 12:06:45PM +0200, Maciej W. Rozycki wrote:

> > Int vs. long was a very small issue as I discovered during porting for the
> > first 64-bit machines, the IP22 and IP27.
> 
>  Well, the surprise is going to happen in drivers, I'm afraid...

That depends on how much people were thinking ahead when writing drivers.

  Ralf
