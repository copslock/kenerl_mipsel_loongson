Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 May 2005 21:24:31 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:984 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225991AbVEZUYR>;
	Thu, 26 May 2005 21:24:17 +0100
Received: from drow by nevyn.them.org with local (Exim 4.50)
	id 1DbOtr-000526-3u; Thu, 26 May 2005 16:24:15 -0400
Date:	Thu, 26 May 2005 16:24:15 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	maxim@mox.ru, linux-mips@linux-mips.org
Subject: Re: glibc-2.3.4 mips64 compilation failure
Message-ID: <20050526202415.GA19298@nevyn.them.org>
References: <6097c4905052609326a4c1232@mail.gmail.com> <20050526170603.GA13272@nevyn.them.org> <Pine.LNX.4.61L.0505261815330.29423@blysk.ds.pg.gda.pl> <20050526190554.GA16765@nevyn.them.org> <Pine.LNX.4.61L.0505262023030.29423@blysk.ds.pg.gda.pl> <20050526200804.GA18695@nevyn.them.org> <20050526201503.GA19015@nevyn.them.org> <Pine.LNX.4.61L.0505262118310.29423@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0505262118310.29423@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, May 26, 2005 at 09:22:47PM +0100, Maciej W. Rozycki wrote:
> On Thu, 26 May 2005, Daniel Jacobowitz wrote:
> 
> > > It's buried in:
> > >   http://sourceware.org/ml/libc-alpha/2004-12/msg00063.html
> > 
> > ... not that those will be very useful to you, unless you want to
> > suddenly become Fedora.  They'll only be useful to Debian once in a
> > blue moon.
> 
>  Thanks for the link and indeed -- I don't think we have any setup 
> available that would qualify as a "distribution" as referred to by the 
> rules.  Especially as for MIPS you'd have to multiply that by three for 
> the supported ABIs.
> 
>  As a result we have no glibc release that would work for a reasonably 
> modern setup of MIPS/Linux.

HEAD does work, however.  I will even get around to the MIPS64 NPTL
bits for HEAD very soon.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
