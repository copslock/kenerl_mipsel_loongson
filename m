Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Apr 2004 15:11:37 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:63913 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225806AbUDUOLg>; Wed, 21 Apr 2004 15:11:36 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id AFAE14AE0D; Wed, 21 Apr 2004 16:11:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 9E82A4AC7D; Wed, 21 Apr 2004 16:11:29 +0200 (CEST)
Date: Wed, 21 Apr 2004 16:11:29 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <20040420153108.F22846@mvista.com>
Message-ID: <Pine.LNX.4.55.0404211608570.28167@jurand.ds.pg.gda.pl>
References: <20040420163230Z8225288-1530+99@linux-mips.org>
 <20040420105116.C22846@mvista.com> <20040420201128.GC24025@linux-mips.org>
 <20040420153108.F22846@mvista.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 20 Apr 2004, Jun Sun wrote:

> > drivers/pci can do that, you just need to supply a few board specific
> > functions, see for example arch/alpha/kernel/pci.c.  So pci_auto.c isn't
> > only b0rked, it also duplicates code.
> 
> Has anybody succssfully used pci_assign_unassigned_resources() in latest 2.4?
> It was badly broken in early 2.4 kernels while pci_auto was the only 
> option.

 In that case, fixing pci_assign_unassigned_resources() was the right way
to go, instead of implementing a system-specific workaround.  There are no
excuses -- the source is available.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
