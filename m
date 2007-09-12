Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2007 16:54:25 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:9920 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20023190AbXILPyR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Sep 2007 16:54:17 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id CBAC8400BE;
	Wed, 12 Sep 2007 17:54:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id sRgrELBUrlvn; Wed, 12 Sep 2007 17:54:10 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id E6C44400B2;
	Wed, 12 Sep 2007 17:54:09 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l8CFsEYZ007261;
	Wed, 12 Sep 2007 17:54:14 +0200
Date:	Wed, 12 Sep 2007 16:54:08 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [MIPS] SMTC: Fix crash on bootup with idebus= command line
 argument.
In-Reply-To: <20070913.001809.106261283.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64N.0709121621200.24030@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0709111431240.30365@blysk.ds.pg.gda.pl>
 <20070911.230712.39152979.anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.64N.0709111509140.30365@blysk.ds.pg.gda.pl>
 <20070913.001809.106261283.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4255/Wed Sep 12 09:18:47 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 13 Sep 2007, Atsushi Nemoto wrote:

> >  Not quite so.  The test for the PCI-(E)ISA bridge is there so that they 
> > are handled.  Now I gather the use of no_pci_devices() in 
> > ide_probe_legacy() effectively disables the test entirely (thus making it 
> > a candidate for removal).  Or am I missing something?
> 
> Well, I missed your point...  please elaborate?

 I gather the problem is ide_probe_legacy() is called too early for PCI to 
have been initialised.  With the old code ide_probe_legacy() called 
pci_get_class(), which in turn triggered PCI initialisation, which enabled 
interrupts prematurely and the failure scenario happened.  To rectify Ralf 
resurrected yet older code that reserved the legacy ports unconditionally.  
You have put the code that calls pci_get_class() back and introduced this 
call to no_pci_devices() beforehand.  Please correct me if I have been 
wrong anywhere here.

 Now because at the point ide_probe_legacy() is called, PCI has not been 
initialised yet, no_pci_devices() returns true and calls to 
pci_get_class() are skipped preventing PCI initialisation from triggering 
at this point.  But the end result is they are not going to be called, 
because if they were, it would mean no_pci_devices() had returned false 
and would have been unnecessary in the first place.

 I hope I have been clearer now.

  Maciej
