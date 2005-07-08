Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2005 14:55:51 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:5907 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226358AbVGHNzV>; Fri, 8 Jul 2005 14:55:21 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j68Dtqt7007446;
	Fri, 8 Jul 2005 14:55:52 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j68Dtq6M007445;
	Fri, 8 Jul 2005 14:55:52 +0100
Date:	Fri, 8 Jul 2005 14:55:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050708135551.GD2816@linux-mips.org>
References: <20050708091711Z8226352-3678+1954@linux-mips.org> <20050708120238.GA2816@linux-mips.org> <Pine.LNX.4.61L.0507081309530.25104@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0507081309530.25104@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 08, 2005 at 01:12:55PM +0100, Maciej W. Rozycki wrote:

> > > 	Protect noat assembly with .set push/pop and make it somewhat readable.
> > 
> > It doesn't need protction.
> 
>  Are you absolutely sure future versions of GCC won't default to ".set 
> noat" for inline asm?  I am not; in fact the opposite is not unlikely.

Indeed - but everybody is free to shoot himself into the foot.  With
uzis even.  Does that make it a good idea?

  Ralf
