Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2007 17:55:17 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:14557 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023566AbXILQzJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 12 Sep 2007 17:55:09 +0100
Received: from localhost (p8044-ipad303funabasi.chiba.ocn.ne.jp [123.217.154.44])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id B3CEDC21E; Thu, 13 Sep 2007 01:53:48 +0900 (JST)
Date:	Thu, 13 Sep 2007 01:55:20 +0900 (JST)
Message-Id: <20070913.015520.51867978.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [MIPS] SMTC: Fix crash on bootup with idebus= command line
 argument.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64N.0709121621200.24030@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0709111509140.30365@blysk.ds.pg.gda.pl>
	<20070913.001809.106261283.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64N.0709121621200.24030@blysk.ds.pg.gda.pl>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 12 Sep 2007 16:54:08 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
>  I gather the problem is ide_probe_legacy() is called too early for PCI to 
> have been initialised.  With the old code ide_probe_legacy() called 
> pci_get_class(), which in turn triggered PCI initialisation, which enabled 
> interrupts prematurely and the failure scenario happened.  To rectify Ralf 
> resurrected yet older code that reserved the legacy ports unconditionally.  
> You have put the code that calls pci_get_class() back and introduced this 
> call to no_pci_devices() beforehand.  Please correct me if I have been 
> wrong anywhere here.

Right.  That's exactly what I did.

>  Now because at the point ide_probe_legacy() is called, PCI has not been 
> initialised yet, no_pci_devices() returns true and calls to 
> pci_get_class() are skipped preventing PCI initialisation from triggering 
> at this point.  But the end result is they are not going to be called, 
> because if they were, it would mean no_pci_devices() had returned false 
> and would have been unnecessary in the first place.

The pci_get_class() failure was happened only if ide_probe_legacy() was
called too early.  That can happen if you specified some IDE boot
options, such as "idebus=" option.

So if you do not add any ide boot option, there should be no problem.

If you meant "ide_probe_legacy() has been broken with ide boot options
for long years", I agree.

And my recent patch is not to solve this problem.  Just avoid adding
legacy ide0/ide1 unconditionally in normal usage.

>  I hope I have been clearer now.

Thank you!

---
Atsushi Nemoto
