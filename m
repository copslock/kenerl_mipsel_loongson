Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jan 2005 14:34:20 +0000 (GMT)
Received: from pD95620DD.dip.t-dialin.net ([IPv6:::ffff:217.86.32.221]:52542
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225224AbVATOeP>; Thu, 20 Jan 2005 14:34:15 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j0KEYEx4004546;
	Thu, 20 Jan 2005 15:34:14 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j0KEYE0C004545;
	Thu, 20 Jan 2005 15:34:14 +0100
Date:	Thu, 20 Jan 2005 15:34:14 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	moreau francis <francis_moreau2000@yahoo.fr>,
	linux-mips@linux-mips.org
Subject: Re: dcache issue...
Message-ID: <20050120143414.GB3684@linux-mips.org>
References: <20050120140025.96779.qmail@web25101.mail.ukl.yahoo.com> <Pine.LNX.4.61L.0501201414250.18294@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0501201414250.18294@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 20, 2005 at 02:18:00PM +0000, Maciej W. Rozycki wrote:

> > > Live is tough, use caches ;-)
> > 
> > oh yes it is. But I would only understand what was
> > my problem using the mixed cache modes...
> 
>  Note that ll/sc sequences don't work as expected on uncached memory, so 
> atomic accesses are not going to work in the kernel memory in your 
> configuration.  This may cause arbitrary corruptions due to an 
> inconsistent state of the kernel.

Uniprocessor systems are usually get away with it but it's not something
real software should rely on.

  Ralf
