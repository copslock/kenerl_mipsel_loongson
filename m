Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Oct 2004 13:30:15 +0100 (BST)
Received: from p508B7E67.dip.t-dialin.net ([IPv6:::ffff:80.139.126.103]:4126
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225305AbUJGMaK>; Thu, 7 Oct 2004 13:30:10 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i97CS9OH007000;
	Thu, 7 Oct 2004 14:28:09 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i97CS9Lh006999;
	Thu, 7 Oct 2004 14:28:09 +0200
Date: Thu, 7 Oct 2004 14:28:09 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org
Subject: Re: Kernel 2.6 for R4600 Indy
Message-ID: <20041007122809.GB32619@linux-mips.org>
References: <4152D58B.608@longlandclan.hopto.org> <20040923154855.GA2550@paradigm.rfc822.org> <20041002185057.GN21351@rembrandt.csv.ica.uni-stuttgart.de> <20041002204014.GO21351@rembrandt.csv.ica.uni-stuttgart.de> <Pine.LNX.4.58L.0410022213140.18388@blysk.ds.pg.gda.pl> <20041004145244.GB8198@linux-mips.org> <Pine.LNX.4.58L.0410050044510.14763@blysk.ds.pg.gda.pl> <20041005190408.GD2160@linux-mips.org> <Pine.LNX.4.58L.0410052023170.26193@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0410052023170.26193@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 05, 2004 at 08:35:52PM +0100, Maciej W. Rozycki wrote:

>  Well, the nearby comment agrees with me.  Is the handler misused or has
> someone forgotten to fix the comment (yes, I do know of the R4700 and 
> R4640/R4650, with the former being almost identical to the R4600 and the 
> latters being unsupported due to lacking a TLB MMU)?

The names R4000 and R4k are at times used to mean any R4000-ish processor.
What that means in a particular context isn't always well defined.  Even
an oddball processor like the R8000 may be covered ...

R5000 being the faster twin of the R4600 also uses it.  Nevada only got it's
own handler due some processor bug; upto it's workaround this class of
processors also used the R4000 handler.  With hazards.h the need for the
nop-free version for the R10000 family went away also, so it moved over to
the standard R4000 one.  RM7000 was always using it and RM9000 having
slightly different hazards than it's predecessors never had a good reason

> is it worth the hassle?  Or is the "plan" scheduled for around 2.8 or so?

Given the experience with clear_user / copy_user going for the runtime
generated handlers is relativly easy and can be done without alot of
breakage so it's more a question of somebody doing it and I'll not try
to stop any reasonable implementation.

  Ralf
