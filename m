Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2005 12:52:17 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:2318 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226018AbVDDLwB>; Mon, 4 Apr 2005 12:52:01 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j34Bptdu009847;
	Mon, 4 Apr 2005 12:51:55 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j34Bptau009846;
	Mon, 4 Apr 2005 12:51:55 +0100
Date:	Mon, 4 Apr 2005 12:51:55 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org,
	moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: How to keep uptodate a mips-linux port
Message-ID: <20050404115155.GI6016@linux-mips.org>
References: <20050401075417.14596.qmail@web25106.mail.ukl.yahoo.com> <20050401083147.GQ21175@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050401083147.GQ21175@lug-owl.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 01, 2005 at 10:31:47AM +0200, Jan-Benedict Glaw wrote:

> > I already tried this one, and it doens't seem to be
> > the best one: I sent a patch a couple of months ago
> > to the list, but I didn't get any answers...so I beg
> > for Ralf to look at it on IRC, but he seems to have 
> > not time for it...So now I'm trying to find out a new
> > approach....
> 
> Don't expect that sending a patch once always leads to it's prompt
> acceptance. Pushing a patch *can* involve resending it multiple times,
> over a long period of time. However, if a patch is in acceptable state
> (that is, a half-way readable coding style, no superfluous debugging
> output, ...), Ralf usually takes it quite fast.

Unless he's on vacation and tries to be a happy man by avoiding email
software ;-)

> > Futhermore, this solution can take several months
> > before every patches have been submitted and accepted.
> > During this while I'll need to be synchronised with
> > CVS tree.
> 
> That isn't all that easy, especially with CVS and especially if you want
> to keep patches in nicely separated changesets. With CVS, this
> unfortunately involves some manual work, or clever scripting. But SCM
> systems are a totally different topic. "quilt" may work for you, though.

I recommend Quilt which is availalble from Savannah.  It's done a great
job for me in developping and maintaining a bunch of patches independant
of each other.

  Ralf
