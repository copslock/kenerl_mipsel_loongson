Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 18:13:23 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:31878 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20023207AbXJYRNO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Oct 2007 18:13:14 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id D7750400CA;
	Thu, 25 Oct 2007 19:12:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id xK6QJTjUvM05; Thu, 25 Oct 2007 19:12:37 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 7E1534007F;
	Thu, 25 Oct 2007 19:12:37 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9PHCdiC028873;
	Thu, 25 Oct 2007 19:12:40 +0200
Date:	Thu, 25 Oct 2007 18:12:34 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Sam Ravnborg <sam@ravnborg.org>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [IDE] Fix build bug
In-Reply-To: <20071025160529.GB24621@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0710251809070.24086@blysk.ds.pg.gda.pl>
References: <20071025135334.GA23272@linux-mips.org> <20071025141305.GA11698@uranus.ravnborg.org>
 <Pine.LNX.4.64N.0710251545300.24086@blysk.ds.pg.gda.pl>
 <20071025160529.GB24621@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4594/Thu Oct 25 14:45:14 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 25 Oct 2007, Ralf Baechle wrote:

> >  Somebody wants to mix up read-only and read/write data in the same 
> > section and GCC quite legitimately complains about it.  You cannot have 
> > both at a time.
> 
> My interpretation is that it would be perfectly ok for a C compiler to
> do minimal handling of const by only throwing errors for attempted
> assignments to const objects but otherwise treating them as if they
> were non-const, that is for example putting them into an r/w section.

 That would probably be valid (any C standard expert please correct me if 
I am wrong), but the approach looks like: since we have the capability in 
the hardware and the OS, then why not actually enforce the rule at the run 
time as well?

  Maciej
