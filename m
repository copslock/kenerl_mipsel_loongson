Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2007 15:28:31 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:7896 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022437AbXIKO2X (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Sep 2007 15:28:23 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 2B55940071;
	Tue, 11 Sep 2007 16:28:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id BbZq8BHM3Khq; Tue, 11 Sep 2007 16:28:16 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id A86D1400CE;
	Tue, 11 Sep 2007 16:28:06 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l8BES9dv021528;
	Tue, 11 Sep 2007 16:28:10 +0200
Date:	Tue, 11 Sep 2007 15:28:04 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [MIPS] SMTC: Fix crash on bootup with idebus= command line
 argument.
In-Reply-To: <20070911.230712.39152979.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64N.0709111509140.30365@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0709101406091.25038@blysk.ds.pg.gda.pl>
 <20070911.001819.126573631.anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.64N.0709111431240.30365@blysk.ds.pg.gda.pl>
 <20070911.230712.39152979.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4239/Tue Sep 11 15:08:30 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 11 Sep 2007, Atsushi Nemoto wrote:

> >  Thanks a lot -- it makes things work for my SWARM as expected.  But 
> > doesn't it break systems where there actually is a PCI-(E)ISA bridge and a 
> > legacy IDE interface?
> 
> Yes, it would breaks such systems, but that is exactly we have been
> doing for years, isn't it?

 Not quite so.  The test for the PCI-(E)ISA bridge is there so that they 
are handled.  Now I gather the use of no_pci_devices() in 
ide_probe_legacy() effectively disables the test entirely (thus making it 
a candidate for removal).  Or am I missing something?

> And if such a platform was really exists, mach-specific ide.h could be
> used as final workaround.

 I think Malta qualifies -- it has an onboard PCI IDE interface (coupled 
in a single chip with a PCI-ISA bridge) which uses legacy I/O ports.  No 
ISA slots though, if you are looking for a diehard example. ;-)

  Maciej
