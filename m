Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Oct 2004 20:36:00 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:35589 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225195AbUJETfz>; Tue, 5 Oct 2004 20:35:55 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id E170AF596D; Tue,  5 Oct 2004 21:35:47 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27663-08; Tue,  5 Oct 2004 21:35:47 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 6FF54F5977; Tue,  5 Oct 2004 21:35:47 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.12.11/8.12.11) with ESMTP id i95Ja3Fg018118;
	Tue, 5 Oct 2004 21:36:03 +0200
Date: Tue, 5 Oct 2004 20:35:52 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org
Subject: Re: Kernel 2.6 for R4600 Indy
In-Reply-To: <20041005190408.GD2160@linux-mips.org>
Message-ID: <Pine.LNX.4.58L.0410052023170.26193@blysk.ds.pg.gda.pl>
References: <4152D58B.608@longlandclan.hopto.org> <20040923154855.GA2550@paradigm.rfc822.org>
 <20041002185057.GN21351@rembrandt.csv.ica.uni-stuttgart.de>
 <20041002204014.GO21351@rembrandt.csv.ica.uni-stuttgart.de>
 <Pine.LNX.4.58L.0410022213140.18388@blysk.ds.pg.gda.pl>
 <20041004145244.GB8198@linux-mips.org> <Pine.LNX.4.58L.0410050044510.14763@blysk.ds.pg.gda.pl>
 <20041005190408.GD2160@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 5 Oct 2004, Ralf Baechle wrote:

> > 1. The handler is expected to be for R4000/R4400 only.  If it's used for
> 
> You're alone in that believe.  Despite it's name it's being used for
> anything that doesn't need it's own special handler.

 Well, the nearby comment agrees with me.  Is the handler misused or has
someone forgotten to fix the comment (yes, I do know of the R4700 and 
R4640/R4650, with the former being almost identical to the R4600 and the 
latters being unsupported due to lacking a TLB MMU)?

> > 2. The except_vec0_sb1 handler is one with the nop omitted, so it can be
> >    used for these processors.
> 
> Adding more obscurity?

 Just moving it elsewhere. ;-)

> > 3. Correct operation first, only then optimization.
> 
> On of the free software lessons is a bad solution is worse than no solution.

 And another one is anyone is free to provide a better fix.  I suppose 
another alternative with the current implementation is to make a "generic" 
handler separate from the R4000/R4400 one.  This might even be not so 
troublesome maintenance-wise if done properly, but given the "grand plan" 
is it worth the hassle?  Or is the "plan" scheduled for around 2.8 or so?

  Maciej
