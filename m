Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2008 13:26:30 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:6648 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20319138AbYISM02 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 19 Sep 2008 13:26:28 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m8JCQOD2030551;
	Fri, 19 Sep 2008 14:26:25 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m8JCQOl9030547;
	Fri, 19 Sep 2008 13:26:24 +0100
Date:	Fri, 19 Sep 2008 13:26:23 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, u1@terran.org,
	linux-mips@linux-mips.org
Subject: Re: MIPS checksum bug
In-Reply-To: <20080919112304.GB13440@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0809191315590.29711@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0809171104290.17103@cliff.in.clinika.pl>
 <20080917.222350.41199051.anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.55.0809171501450.17103@cliff.in.clinika.pl>
 <20080918.002705.78730226.anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.55.0809171917580.17103@cliff.in.clinika.pl>
 <20080918220734.GA19222@linux-mips.org> <Pine.LNX.4.55.0809190112090.22686@cliff.in.clinika.pl>
 <20080919112304.GB13440@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 19 Sep 2008, Ralf Baechle wrote:

> >  Seriously though, I smell a caller somewhere fails to call csum_fold() on
> > the result obtained from csum_partial() where it should, so it would be
> > good to fix the bug rather than trying to cover it.  Bryan, would you be
> > able to track down the caller?
> 
> Not quite.  Internally the IP stack maintains the checksum as a 32-bit
> value for performance sake.  It only folds it to 16-bit when it has to.

 That's been my understanding from my little investigation yesterday
evening, but Bryan's problem has come from somewhere after all and
Atsushi-san's 32-bit addition fix didn't reportedly work while full
folding did, so I have assumed there must be some dependency somewhere
where the final folding does not happen.  I have referred to the original
report concerning SPARC64 now and it seems to narrow the problem down to
the 32 MSBs only, so I would prefer to have any confusion cleared.

 Bryan, can you please verify whether Ralf's fix works for you or not?

  Maciej
