Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2003 04:38:50 +0100 (BST)
Received: from p508B5DEF.dip.t-dialin.net ([IPv6:::ffff:80.139.93.239]:56729
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225301AbTHSDis>; Tue, 19 Aug 2003 04:38:48 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h7J3cj8R007218;
	Tue, 19 Aug 2003 05:38:45 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h7J3ci4u007217;
	Tue, 19 Aug 2003 05:38:44 +0200
Date: Tue, 19 Aug 2003 05:38:43 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@linux-mips.org
Subject: Re: GCCFLAGS for gcc 3.3.x (-march and _MIPS_ISA)
Message-ID: <20030819033843.GA6223@linux-mips.org>
References: <20030812065118.GD23104@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.3.96.1030812155517.7029C-100000@delta.ds2.pg.gda.pl> <20030812140452.GD10792@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030812140452.GD10792@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 12, 2003 at 04:04:52PM +0200, Thiemo Seufer wrote:

> > > #ifdef __mips64
> > > # define MFC0		dmfc0
> > > # define MTC0		dmtc0
> > > #else
> > > # define MFC0		mfc0
> > > # define MTC0		mtc0
> > > #endif
> > 
> >  I'd go for CONFIG_MIPS64 here.
> 
> This would work as well, but I prefer compiler intrinsic defines
> over custom configury.

I agree for this particular header file because it's been copied into
user applications.  So ideally it should be able to live entirely without
CONFIG_* symbols rsp. <linux/config.h>.

  Ralf
