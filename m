Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f56KiM931613
	for linux-mips-outgoing; Wed, 6 Jun 2001 13:44:22 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f56KiMh31610
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 13:44:22 -0700
Received: from nevyn.them.org (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA05049
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 13:44:15 -0700 (PDT)
	mail_from (drow@nevyn.them.org)
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 157jqU-0007GI-00; Wed, 06 Jun 2001 13:24:02 -0700
Date: Wed, 6 Jun 2001 13:24:02 -0700
From: Daniel Jacobowitz <dan@debian.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
Subject: Re: New toolchain for Linux/mips
Message-ID: <20010606132402.A27901@nevyn.them.org>
References: <20010606110019.A23009@nevyn.them.org> <Pine.GSO.3.96.1010606203714.10246B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.GSO.3.96.1010606203714.10246B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Jun 06, 2001 at 08:40:07PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jun 06, 2001 at 08:40:07PM +0200, Maciej W. Rozycki wrote:
> On Wed, 6 Jun 2001, Daniel Jacobowitz wrote:
> 
> > I've actually spent this week porting the gdb CVS head to MIPS; I've
> > got it almost entirely working now.  There's one problem with SIGTRAP
> 
>  Make sure your kernel is flushing the icache right. 

Hmm, thanks, I'll check.  I don't think that's it, though.

> > that I haven't quite figured out yet, and thread attach isn't quite
> > working, and there's a kernel bug I've been repeatedly triggering that
> > I think I just fixed.  I anticipate it all being done in a couple of
> > days - I'll post here and on the GDB list when I have it in slightly
> > better shape.
> 
>  Great!  Did you do you work from scratch -- hopefully not?

Nope.  It's based mostly on the same 4.17 patch from David Miller, and
some bits from Ralf, all marked as assigned to the FSF (though I'm not
sure if that ever actually happened); I'll straighten out copyright
once I've got the whole thing done.

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
Monta Vista Software                              Debian Security Team
