Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g12026P21984
	for linux-mips-outgoing; Fri, 1 Feb 2002 16:02:06 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g12023d21980
	for <linux-mips@oss.sgi.com>; Fri, 1 Feb 2002 16:02:03 -0800
Received: from drow by nevyn.them.org with local (Exim 3.34 #1 (Debian))
	id 16WmgQ-0006BJ-00; Fri, 01 Feb 2002 18:01:26 -0500
Date: Fri, 1 Feb 2002 18:01:26 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "H . J . Lu" <hjl@lucon.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Hiroyuki Machida <machida@sm.sony.co.jp>, libc-alpha@sources.redhat.com,
   linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
Message-ID: <20020201180126.A23740@nevyn.them.org>
Mail-Followup-To: "H . J . Lu" <hjl@lucon.org>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Hiroyuki Machida <machida@sm.sony.co.jp>,
	libc-alpha@sources.redhat.com, linux-mips@oss.sgi.com
References: <20020131231714.E32690@lucon.org> <Pine.GSO.3.96.1020201124328.26449A-100000@delta.ds2.pg.gda.pl> <20020201102943.A11146@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020201102943.A11146@lucon.org>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Feb 01, 2002 at 10:29:43AM -0800, H . J . Lu wrote:
> On Fri, Feb 01, 2002 at 12:45:02PM +0100, Maciej W. Rozycki wrote:
> > On Thu, 31 Jan 2002, H . J . Lu wrote:
> > 
> > > > Gas will fill delay slots. Same object codes will be produced, so I
> > > > think you don't have to do that by hand. 
> > > 
> > > It will make the code more readable. We don't have to guess what
> > > the assembler will do. 
> > 
> >  But you lose a chance for something useful being reordered to the slot.
> > That might not necessarily be a "nop".  Please don't forget of indents
> > anyway.
> > 
> 
> Here is a new patch. I use branch likely to get rid of nops. Please
> tell me which indents I may have missed.

Can you really assume presence of the branch-likely instruction?  I
don't think so.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
