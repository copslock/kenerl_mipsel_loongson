Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Sep 2002 18:12:15 +0200 (CEST)
Received: from p508B4F9D.dip.t-dialin.net ([80.139.79.157]:27008 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122960AbSIHQMO>; Sun, 8 Sep 2002 18:12:14 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g86AEOs05039;
	Fri, 6 Sep 2002 12:14:24 +0200
Date: Fri, 6 Sep 2002 12:14:24 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Daniel Jacobowitz <dan@debian.org>,
	"Kevin D. Kissell" <kevink@mips.com>,
	Tor Arntsen <tor@spacetec.no>,
	Carsten Langgaard <carstenl@mips.com>,
	linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
Message-ID: <20020906121424.E2993@linux-mips.org>
References: <20020905142249.GA15843@nevyn.them.org> <Pine.GSO.3.96.1020905165445.7444D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020905165445.7444D-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Sep 05, 2002 at 05:08:06PM +0200
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 05, 2002 at 05:08:06PM +0200, Maciej W. Rozycki wrote:

>  I see.  But do we need the SGI's traditional n32 in Linux then?  Having
> most experiences in the server world I'd vote for a pure 64-bit setup
> (with an optional ability to execute o32 stuff), but I understand there
> are people who consider it a waste of resources.

In the SGI world o32 basically has been killed - there no more 32-bit
processors shipped since many years.  So most SGI MIPS systems are
running N32 code by standard and N64 is available as an option which only
is used for the small number of applications that actually are going to
gain from it.  O32 is deprecated; at this time it's just historical garbage.

  Ralf
