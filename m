Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Dec 2004 13:51:20 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:55309 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225007AbULCNvL>; Fri, 3 Dec 2004 13:51:11 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 593BBE1C82; Fri,  3 Dec 2004 14:50:56 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24798-10; Fri,  3 Dec 2004 14:50:56 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 9CA30E1C78; Fri,  3 Dec 2004 14:50:55 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iB3Doqgu018230;
	Fri, 3 Dec 2004 14:50:53 +0100
Date: Fri, 3 Dec 2004 13:50:49 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: David Daney <ddaney@avtrex.com>, linux-mips@linux-mips.org
Subject: Re: [Patch] make 2.4 compile with GCC-3.4.3...
In-Reply-To: <20041203064017.GE8714@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.LNX.4.58L.0412031347190.4078@blysk.ds.pg.gda.pl>
References: <69397FFCADEFD94F8D5A0FC0FDBCBBDEF4FA@avtrex-server.hq.avtrex.com>
 <20041203064017.GE8714@rembrandt.csv.ica.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/614/Wed Dec  1 16:44:43 2004
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status: Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 3 Dec 2004, Thiemo Seufer wrote:

> > -fno-unit-at-a-time prevents GCC from rearranging things in its output thus preventing
> > the save_static_function() from being separated from its companion.  As far as I could tell
> > only syscall.c and signal.c need this.
> 
> Ah, I missed that. It's probably better to use the same way as in 2.6,
> that is, to add a jump at the end of save_static_function().

 Note, that I've send a patch for this twice already.  Still no approval, 
though, for whatever (unstated) reason.

> > noinline was not defined for me :( so I removed it.  It seems that in 2.6 it is
> > just #defined to be nothing.  The alternative is to add:
> >  
> > #ifndef noinline
> > #define noinline
> > #endif
> >  
> > to compiler.h as is done in 2.6
> 
> Yes, that's the better idea. gcc-4.0 ff may need it.

 I'll update the patch accordingly and resend.

  Maciej
