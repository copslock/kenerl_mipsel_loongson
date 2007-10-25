Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 15:48:03 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:57008 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022607AbXJYOry (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Oct 2007 15:47:54 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 1C995400B9;
	Thu, 25 Oct 2007 16:47:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id jOFCs8otLUMI; Thu, 25 Oct 2007 16:47:17 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 432A14007F;
	Thu, 25 Oct 2007 16:47:17 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9PElLai025521;
	Thu, 25 Oct 2007 16:47:21 +0200
Date:	Thu, 25 Oct 2007 15:47:16 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Sam Ravnborg <sam@ravnborg.org>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [IDE] Fix build bug
In-Reply-To: <20071025141305.GA11698@uranus.ravnborg.org>
Message-ID: <Pine.LNX.4.64N.0710251545300.24086@blysk.ds.pg.gda.pl>
References: <20071025135334.GA23272@linux-mips.org> <20071025141305.GA11698@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4594/Thu Oct 25 14:45:14 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 25 Oct 2007, Sam Ravnborg wrote:

> So we can avoid this if we invent a __constinitdata tag that uses
> a new section?

 That would do.

> I ask mainly to understand this error - not that I am that found
> of the idea.

 Somebody wants to mix up read-only and read/write data in the same 
section and GCC quite legitimately complains about it.  You cannot have 
both at a time.

  Maciej
