Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g120FLM22801
	for linux-mips-outgoing; Fri, 1 Feb 2002 16:15:21 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g120FHd22797
	for <linux-mips@oss.sgi.com>; Fri, 1 Feb 2002 16:15:17 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 37BA2125C3; Fri,  1 Feb 2002 15:15:14 -0800 (PST)
Date: Fri, 1 Feb 2002 15:15:13 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Hiroyuki Machida <machida@sm.sony.co.jp>, libc-alpha@sources.redhat.com,
   linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
Message-ID: <20020201151513.A15913@lucon.org>
References: <20020131231714.E32690@lucon.org> <Pine.GSO.3.96.1020201124328.26449A-100000@delta.ds2.pg.gda.pl> <20020201102943.A11146@lucon.org> <20020201180126.A23740@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020201180126.A23740@nevyn.them.org>; from dan@debian.org on Fri, Feb 01, 2002 at 06:01:26PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Feb 01, 2002 at 06:01:26PM -0500, Daniel Jacobowitz wrote:
> On Fri, Feb 01, 2002 at 10:29:43AM -0800, H . J . Lu wrote:
> > On Fri, Feb 01, 2002 at 12:45:02PM +0100, Maciej W. Rozycki wrote:
> > > On Thu, 31 Jan 2002, H . J . Lu wrote:
> > > 
> > > > > Gas will fill delay slots. Same object codes will be produced, so I
> > > > > think you don't have to do that by hand. 
> > > > 
> > > > It will make the code more readable. We don't have to guess what
> > > > the assembler will do. 
> > > 
> > >  But you lose a chance for something useful being reordered to the slot.
> > > That might not necessarily be a "nop".  Please don't forget of indents
> > > anyway.
> > > 
> > 
> > Here is a new patch. I use branch likely to get rid of nops. Please
> > tell me which indents I may have missed.
> 
> Can you really assume presence of the branch-likely instruction?  I
> don't think so.

Why not? Can you show me a MIPS II or above CPU which doesn't have
branch-likely instruction? From gcc,

/* ISA has branch likely instructions (eg. mips2).  */
/* Disable branchlikely for tx39 until compare rewrite.  They haven't
   been generated up to this point.  */
#define ISA_HAS_BRANCHLIKELY    (mips_isa != 1                          \
                                 /* || TARGET_MIPS3900 */)                      

Did I miss something?


H.J.
