Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jul 2005 18:53:07 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:13580 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226487AbVGKRwq>; Mon, 11 Jul 2005 18:52:46 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j6BHrbmb011727;
	Mon, 11 Jul 2005 18:53:37 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j6BHrbPo011726;
	Mon, 11 Jul 2005 18:53:37 +0100
Date:	Mon, 11 Jul 2005 18:53:37 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050711175337.GN2765@linux-mips.org>
References: <20050711170613Z8226486-3678+2546@linux-mips.org> <20050711173104.GM2765@linux-mips.org> <Pine.LNX.4.61L.0507111840580.22410@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0507111840580.22410@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 11, 2005 at 06:44:31PM +0100, Maciej W. Rozycki wrote:

> > Generally considered a good idea ...
> 
>  Generally most useful for binary-only modules.  Do we have any for the 
> DECstation?  If you update "vmlinux", you can also update modules.  Other 
> platforms get away without versioning by default -- I see no reason to be 
> different here.

If there's a mistake that people can do they will rarely miss that
opportunity.  Desperate users tend to move modules from their
distribution into a kernel built from CVS or change kernel config options
and somehow manage to keep a few modules built with the old options etc.
It's no fun receiving bug reports only to later figure out it was just
a silly pilot error, so for anything that's going to the net I really
keep that option on.

Of course I'd disable it for a closed appliance nor do I keep it turned
on for my own builds.

  Ralf
