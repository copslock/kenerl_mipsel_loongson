Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Mar 2004 22:52:06 +0000 (GMT)
Received: from p508B7AB1.dip.t-dialin.net ([IPv6:::ffff:80.139.122.177]:18441
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225440AbUCRWwF>; Thu, 18 Mar 2004 22:52:05 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i2IMptMk014714;
	Thu, 18 Mar 2004 23:51:55 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i2IMpseQ014713;
	Thu, 18 Mar 2004 23:51:54 +0100
Date: Thu, 18 Mar 2004 23:51:54 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: cgd@broadcom.com
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Eric Christopher <echristo@redhat.com>,
	linux-mips@linux-mips.org
Subject: Re: gcc support for mips32 release 2]
Message-ID: <20040318225154.GA761@linux-mips.org>
References: <1078525778.3353.2.camel@dzur.sfbay.redhat.com> <Pine.LNX.4.55.0403171714410.14525@jurand.ds.pg.gda.pl> <yov5ish3zar8.fsf@ldt-sj3-010.sj.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yov5ish3zar8.fsf@ldt-sj3-010.sj.broadcom.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 17, 2004 at 08:41:47AM -0800, cgd@broadcom.com wrote:

> At Wed, 17 Mar 2004 17:18:37 +0100 (CET), Maciej W. Rozycki wrote:
> >  Well, I think this can be handled by creating an artificial processor
> > entry (e.g. "PROCESSOR_MIPS64R2" in this case) and replacing it with a
> > real one once an implementation is publicly available.
> 
> yeah.  doing that, but introducing known "to be removed" code bugs me.
> 
> it's probably better than not getting the rest of the infrastructure
> in, though.

It seems a small problem compared to having to answer all the questions
about why Linux tries to optimize for processor X when it's configured
for type Y.  People just love tweaking compiler flags it seems - even if
not necessarily knowing all the consequences ...

  Ralf
