Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBJ3V6t28776
	for linux-mips-outgoing; Tue, 18 Dec 2001 19:31:06 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fBJ3V2o28773
	for <linux-mips@oss.sgi.com>; Tue, 18 Dec 2001 19:31:02 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBJ2UiK03083;
	Wed, 19 Dec 2001 00:30:44 -0200
Date: Wed, 19 Dec 2001 00:30:44 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: CVS Update@oss.sgi.com: linux
Message-ID: <20011219003044.H2717@dea.linux-mips.net>
References: <200112171934.fBHJYx328839@oss.sgi.com> <Pine.GSO.4.21.0112181044300.15364-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0112181044300.15364-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Tue, Dec 18, 2001 at 11:23:32AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Dec 18, 2001 at 11:23:32AM +0100, Geert Uytterhoeven wrote:

> > Log message:
> > 	Rewrite ffz().  Now compiles into code without any branches.
> 
> Depending on your compiler. Gcc seems to be smarter than GreenHills here :-)

I'd rather call this piece of code to be written around the compiler.
Credits for this nice piece of code btw go to Carsten of MIPS who used
this in the Atlas code where I discovered it two days ago.

The old variant of this routine came from the Origin code and produces
60% longer code with ~ 5 branches.  Probably wrapped around the SGI
compiler.

  Ralf
