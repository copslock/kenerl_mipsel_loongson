Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBDMf6v04729
	for linux-mips-outgoing; Thu, 13 Dec 2001 14:41:06 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBDMf3o04726;
	Thu, 13 Dec 2001 14:41:03 -0800
Received: from drow by nevyn.them.org with local (Exim 3.33 #1 (Debian))
	id 16EdbD-00020X-00; Thu, 13 Dec 2001 16:41:03 -0500
Date: Thu, 13 Dec 2001 16:41:03 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Kip Walker <kwalker@broadcom.com>, linux-mips@oss.sgi.com
Subject: Re: .section problems in entry.S
Message-ID: <20011213164103.A7673@nevyn.them.org>
References: <20011209221835.A11737@dea.linux-mips.net> <Pine.GSO.3.96.1011210165719.24010A-100000@delta.ds2.pg.gda.pl> <20011213184541.A7171@dea.linux-mips.net> <20011213162816.B6983@nevyn.them.org> <20011213193730.A6724@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011213193730.A6724@dea.linux-mips.net>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Dec 13, 2001 at 07:37:30PM -0200, Ralf Baechle wrote:
> Longer than I'd like to see.  Anybody got a sufficiently hacked version
> of ~ 2.11?

Once I get a patch negotiated with Eric to make option parsing
compatible with how we use it now, you'll be able to use 2.12
snapshots...

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
