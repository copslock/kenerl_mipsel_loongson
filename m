Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2004 16:12:05 +0000 (GMT)
Received: from p508B78F8.dip.t-dialin.net ([IPv6:::ffff:80.139.120.248]:49237
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225226AbUBCQME>; Tue, 3 Feb 2004 16:12:04 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i13GC2ex002026;
	Tue, 3 Feb 2004 17:12:02 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i13GC2ks002025;
	Tue, 3 Feb 2004 17:12:02 +0100
Date: Tue, 3 Feb 2004 17:12:02 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: R4600 V1.7 errata
Message-ID: <20040203161202.GC1018@linux-mips.org>
References: <20040129102215.GC17760@ballina> <4018E322.9030801@gentoo.org> <20040131030435.GA24228@linux-mips.org> <20040131141027.GA11048@ballina> <20040201045258.GA4601@linux-mips.org> <20040203113928.GA28340@linux-mips.org> <20040203114252.GA27810@icm.edu.pl> <20040203115236.GB28340@linux-mips.org> <Pine.LNX.4.55.0402031636210.16076@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0402031636210.16076@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 03, 2004 at 04:43:19PM +0100, Maciej W. Rozycki wrote:

> > 2.0 requires different workarounds which are already in place and functional
> > since quite some time.  We still lacking a fix for one important erratum of
> > the 2.0 but it seems pretty stable without.
> 
>  Well, I can actually see two problems: #4 that is fairly easy to handle
> and #7 which is painful and which is unfortunately present with the R4700
> as well.

If #7 would only affect the R4700 the world would peachy ...  To my
knowledge the dusty box here in a corner is the only R4700 that ever ran
Linux ...

Under a different bug number this bug also affects the R4600 V1.x; it's
fixed in post-2.0 R4600 (which all identify as 2.0) and post-1.1 R4700.
Since a workaround may be a bit performance sensitive I think I'll try if
it can be probed for reliably.

  Ralf
