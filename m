Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Feb 2004 22:51:02 +0000 (GMT)
Received: from p508B57DC.dip.t-dialin.net ([IPv6:::ffff:80.139.87.220]:12853
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225568AbUBAWvC>; Sun, 1 Feb 2004 22:51:02 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i11Mnxex011574;
	Sun, 1 Feb 2004 23:49:59 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i11MnwLS011573;
	Sun, 1 Feb 2004 23:49:58 +0100
Date: Sun, 1 Feb 2004 23:49:58 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] pg-r4k.c bugs for R4k systems with a secondary cache
Message-ID: <20040201224958.GA11444@linux-mips.org>
References: <Pine.LNX.4.55.0401261731370.26076@jurand.ds.pg.gda.pl> <Pine.LNX.4.55.0401271208040.683@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0401271208040.683@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 27, 2004 at 12:09:49PM +0100, Maciej W. Rozycki wrote:

> >  The patch also removes references to has_scache which currently disable 
> > code for the S-cache line size of 128 bytes as the variable is always 0.
> 
>  Here is a somewhat better version.  It's functionally equivalent.  OK to 
> apply?

Missed your mail and ran over it only now that I had just started to debug
the problem myself - but still before wasting a major amount of time ...

Lemme test it on my R4400 V4.0  I'll report on it later.

  Ralf
