Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1Q6pml03017
	for linux-mips-outgoing; Mon, 25 Feb 2002 22:51:48 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1Q6ph903014;
	Mon, 25 Feb 2002 22:51:43 -0800
Received: from drow by nevyn.them.org with local (Exim 3.34 #1 (Debian))
	id 16faWY-0001CW-00; Tue, 26 Feb 2002 00:51:38 -0500
Date: Tue, 26 Feb 2002 00:51:38 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Jay Carlson <nop@nop.com>
Cc: Ralf Baechle <ralf@oss.sgi.com>, mad-dev@lists.mars.org,
   Carlo Agostini <carlo.agostini@yacme.com>, linux-mips@oss.sgi.com
Subject: Re: Problems compiling . soft-float
Message-ID: <20020226005138.A4594@nevyn.them.org>
References: <20020226060236.A5293@dea.linux-mips.net> <B843E153-2A79-11D6-AB38-0030658AB11E@nop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B843E153-2A79-11D6-AB38-0030658AB11E@nop.com>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Feb 26, 2002 at 12:28:52AM -0500, Jay Carlson wrote:
> 
> On Tuesday, February 26, 2002, at 12:02 AM, Ralf Baechle wrote:
> 
> >Something for the binutils to-do list - ld should make mixing hard-fp
> >and soft-fp binaries impossible.
> 
> Agreed.  So do we need a special flag/directive for gas to say "I'm 
> using soft float"?

And bit in the ELF header.  We can talk about this in a couple weeks
once binutils 2.12 is out :)

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
