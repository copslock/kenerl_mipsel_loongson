Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 May 2005 21:22:56 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:55565 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225991AbVEZUWk>; Thu, 26 May 2005 21:22:40 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 85BBAF5998; Thu, 26 May 2005 22:22:32 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 32293-08; Thu, 26 May 2005 22:22:32 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 37C80E1C8E; Thu, 26 May 2005 22:22:32 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j4QKMahZ009490;
	Thu, 26 May 2005 22:22:37 +0200
Date:	Thu, 26 May 2005 21:22:47 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	maxim@mox.ru, linux-mips@linux-mips.org
Subject: Re: glibc-2.3.4 mips64 compilation failure
In-Reply-To: <20050526201503.GA19015@nevyn.them.org>
Message-ID: <Pine.LNX.4.61L.0505262118310.29423@blysk.ds.pg.gda.pl>
References: <6097c4905052609326a4c1232@mail.gmail.com> <20050526170603.GA13272@nevyn.them.org>
 <Pine.LNX.4.61L.0505261815330.29423@blysk.ds.pg.gda.pl>
 <20050526190554.GA16765@nevyn.them.org> <Pine.LNX.4.61L.0505262023030.29423@blysk.ds.pg.gda.pl>
 <20050526200804.GA18695@nevyn.them.org> <20050526201503.GA19015@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.83/894/Wed May 25 14:53:16 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 26 May 2005, Daniel Jacobowitz wrote:

> > It's buried in:
> >   http://sourceware.org/ml/libc-alpha/2004-12/msg00063.html
> 
> ... not that those will be very useful to you, unless you want to
> suddenly become Fedora.  They'll only be useful to Debian once in a
> blue moon.

 Thanks for the link and indeed -- I don't think we have any setup 
available that would qualify as a "distribution" as referred to by the 
rules.  Especially as for MIPS you'd have to multiply that by three for 
the supported ABIs.

 As a result we have no glibc release that would work for a reasonably 
modern setup of MIPS/Linux.

  Maciej
