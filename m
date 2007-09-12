Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2007 18:19:46 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:30609 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20023574AbXILRTh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Sep 2007 18:19:37 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id D5FB6400BE;
	Wed, 12 Sep 2007 19:19:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id JBebV8XAoA1I; Wed, 12 Sep 2007 19:19:30 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 8E1DC400B2;
	Wed, 12 Sep 2007 19:19:30 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l8CHJZUi015750;
	Wed, 12 Sep 2007 19:19:35 +0200
Date:	Wed, 12 Sep 2007 18:19:29 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [MIPS] SMTC: Fix crash on bootup with idebus= command line
 argument.
In-Reply-To: <20070913.015520.51867978.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64N.0709121815000.24030@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0709111509140.30365@blysk.ds.pg.gda.pl>
 <20070913.001809.106261283.anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.64N.0709121621200.24030@blysk.ds.pg.gda.pl>
 <20070913.015520.51867978.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4255/Wed Sep 12 09:18:47 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 13 Sep 2007, Atsushi Nemoto wrote:

> The pci_get_class() failure was happened only if ide_probe_legacy() was
> called too early.  That can happen if you specified some IDE boot
> options, such as "idebus=" option.
> 
> So if you do not add any ide boot option, there should be no problem.
> 
> If you meant "ide_probe_legacy() has been broken with ide boot options
> for long years", I agree.

 You mean the point ide_probe_legacy() is called at during bootstrap 
depends on whether some IDE boot options have been specified or not?  
Well, that is an... interesting approach indeed.

> And my recent patch is not to solve this problem.  Just avoid adding
> legacy ide0/ide1 unconditionally in normal usage.

 Of course and it makes perfect sense then.  Thanks for your effort.

  Maciej
