Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2003 15:06:16 +0100 (BST)
Received: from p508B60E0.dip.t-dialin.net ([IPv6:::ffff:80.139.96.224]:35475
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225202AbTG3OGO>; Wed, 30 Jul 2003 15:06:14 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h6UE5tx6026492;
	Wed, 30 Jul 2003 16:05:55 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h6UE5tZP026491;
	Wed, 30 Jul 2003 16:05:55 +0200
Date: Wed, 30 Jul 2003 16:05:54 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Keith M Wesolowski <wesolows@foobazco.org>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20030730140554.GB26372@linux-mips.org>
References: <20030730031631.GD7366@linux-mips.org> <Pine.GSO.3.96.1030730094741.26733B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030730094741.26733B-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 30, 2003 at 09:55:26AM +0200, Maciej W. Rozycki wrote:

> > >  I hope `uname -m' will continue to report the correct architecture and
> > > that ARCH will be correctly handled (i.e. "mips" selecting a 32-bit build
> > > and "mips64" a 64-bit one) -- have you considered this?
> > 
> > Not intend to change the behaviour of uname.  It actually changed in CVS,
> > for now consider that a bug ...
> 
>  OK, I will.

Fix is in CVS.

> > We should consider changing the behaviour though.  A machine type of
> > mips64 broke lots of software.  Of course that was all 32-bit softare but
> > it raises the question if returning mips64 is really a good idea?
> 
>  Yes it is.  It is the only way to check if the kernel is 32-bit or 64-bit
> and config.guess needs it for guessing the canonical system name.  That,
> plus checking the default ld emulation lets it (or will let, once written)
> select what is the proper default native configuration: 
> mips{,el}-unknown-linux-gnu, mips64{,el}-unknown-linux-gnu-abin32 or
> mips64{,el}-unknown-linux-gnu-abi64. 
> 
> > As for choosing a 32-bit vs. 64-bit kernel, that's now a menu point and can
> > be choosen like every other config option.
> 
>  Well, I liked the `make "ARCH=mips64"' way, but I suppose I'll have to
> live with your change, sigh... 

Well, that was one of the things that were handy at times.  Considering
the patch I sent to Linus yesterday to Linus did remove 41010 lines of code
that was a tiny price to pay.

  Ralf
