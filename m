Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Oct 2003 17:37:07 +0100 (BST)
Received: from p508B7CAD.dip.t-dialin.net ([IPv6:::ffff:80.139.124.173]:12461
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225550AbTJHQhF>; Wed, 8 Oct 2003 17:37:05 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h98Gb2NK020442;
	Wed, 8 Oct 2003 18:37:02 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h98Gb2In020441;
	Wed, 8 Oct 2003 18:37:02 +0200
Date: Wed, 8 Oct 2003 18:37:02 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: time(2) for mips64
Message-ID: <20031008163702.GC19102@linux-mips.org>
References: <20031002.234116.74756712.anemo@mba.ocn.ne.jp> <Pine.GSO.3.96.1031003211755.5309A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1031003211755.5309A-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 03, 2003 at 09:20:11PM +0200, Maciej W. Rozycki wrote:

> > macro>  time(2) is obsolete (by gettimeofday(2)) and should be removed
> > macro> for new implementations.
> > 
> > Then could you apply these patches?
> 
>  I can, but they need an approval from Ralf.  Ralf, is the change OK? 

Yes, please.

  Ralf
