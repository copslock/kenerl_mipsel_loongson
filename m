Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2004 15:42:20 +0000 (GMT)
Received: from p508B78F8.dip.t-dialin.net ([IPv6:::ffff:80.139.120.248]:21077
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225226AbUBCPmT>; Tue, 3 Feb 2004 15:42:19 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i13FgIex001381;
	Tue, 3 Feb 2004 16:42:18 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i13FgIBn001380;
	Tue, 3 Feb 2004 16:42:18 +0100
Date: Tue, 3 Feb 2004 16:42:18 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] pg-r4k.c cp0 hazards for R4000/R4400
Message-ID: <20040203154217.GA1018@linux-mips.org>
References: <Pine.LNX.4.55.0401261755460.26076@jurand.ds.pg.gda.pl> <20040202150806.GA27819@linux-mips.org> <Pine.LNX.4.55.0402031504030.16076@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0402031504030.16076@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 03, 2004 at 04:11:43PM +0100, Maciej W. Rozycki wrote:

>  I'm pretty sure the hazard is in both directions -- why?  Because it's 
> marked both in the "CP0 Data Used, Stage Used" and the "CP0 Data Written, 
> Stage Available" column.  I interpret that as a requirement for the CACHE 
> instructions to "start using data" two instructions ahead and "finish 
> writing data" two instructions after itself.  If your assumption was true, 
> I'd put the marking only in the former column.  Of course that does not 
> mean the table is correct, but I'd assume so, for safety, if not anything 
> else.

I was just trying to explain why the PC variants used to work fine.

> > violated this hazard since almost beginning of the time, see
> > http://www.linux-mips.org/cvsweb/linux/arch/mips/mm/Attic/pg-r4k.S?rev=1.9
> > and I've not heared of any problems arising from this.
> 
>  Perhaps it wasn't really tested.  Have you ever run the code on a PC 
> variant?  Has anyone else?

Yes, it has.  Olivetti M700-10, around 2.2 or so.  The code used at that
time in arch/mips/mm/r4xx0.c was not much different from what pg-r4k.c is
generating now that is it violates this hazard.

> > Any DECstations using the R4[04]00PC CPU variant?
> 
>  None.  That would normally be a downgrade in memory throughput as the
> R2k/R3k DECstations used to have 64kB of I-cache + 64kB of D-cache,
> typically, and sometimes (with the 33MHz variant) even 128kB of D-cache.

>  I suppose so -- without the "mips-pg-r4k-scache" patch my system is very
> unstable and the difference is essentially that in addition to
> Create_Dirty_Excl_SD there are additional Create_Dirty_Excl_D ones, that,
> apart from being a performance hit, shouldn't have any effect.  I have to
> investigate it further yet.

Interesting, I was expecting somewhat better performance from the
combination of both.  Anyway, what is now in CVS is tested on R4400SC V4.0.

  Ralf
