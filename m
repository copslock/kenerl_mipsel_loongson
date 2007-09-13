Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2007 14:49:46 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:29152 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021881AbXIMNto (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Sep 2007 14:49:44 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8DDniLL018680;
	Thu, 13 Sep 2007 14:49:44 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8DDnhUt018679;
	Thu, 13 Sep 2007 14:49:43 +0100
Date:	Thu, 13 Sep 2007 14:49:43 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [MIPS] SMTC: Fix crash on bootup with idebus= command line
	argument.
Message-ID: <20070913134943.GA11396@linux-mips.org>
References: <Pine.LNX.4.64N.0709111431240.30365@blysk.ds.pg.gda.pl> <20070911.230712.39152979.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64N.0709111509140.30365@blysk.ds.pg.gda.pl> <20070913.001809.106261283.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64N.0709121621200.24030@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0709121621200.24030@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 12, 2007 at 04:54:08PM +0100, Maciej W. Rozycki wrote:

>  I gather the problem is ide_probe_legacy() is called too early for PCI to 
> have been initialised.  With the old code ide_probe_legacy() called 
> pci_get_class(), which in turn triggered PCI initialisation, which enabled 
> interrupts prematurely and the failure scenario happened.  To rectify Ralf 
> resurrected yet older code that reserved the legacy ports unconditionally.  
> You have put the code that calls pci_get_class() back and introduced this 
> call to no_pci_devices() beforehand.  Please correct me if I have been 
> wrong anywhere here.

Pci_get_class doesn't trigger PCI initialization and I don't think it
should ...

  Ralf
