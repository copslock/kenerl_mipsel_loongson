Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2003 14:56:17 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:60336 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224861AbTFQN4P>; Tue, 17 Jun 2003 14:56:15 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA24162;
	Tue, 17 Jun 2003 15:57:13 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 17 Jun 2003 15:57:13 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] kill prom_printf
In-Reply-To: <20030617123212.GE6353@lug-owl.de>
Message-ID: <Pine.GSO.3.96.1030617154535.22214H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2666
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 17 Jun 2003, Jan-Benedict Glaw wrote:

> If we constantly add (new) kernel arguments, we may at some time face
> the problem that the calling PROM/firmware/whatever cannot handle a
> command line which is *that* long. IIRC DECstations have a quite limited
> prompt length. This hurts for "3/tftp():vmecoff root=/dev/ram
> nfsroot=/nfsroot/decxxxx ip=bootp console=ttyS2 console=tty0
> early_printk=arc"

 That has already been trained by the Alpha people.  I think we simply
need a bootloader capable of handling network boots -- with the REX
firmware it shouldn't be that difficult.  For disk loads I suppose it's
already handled by delo (I haven't checked).  We don't have a tape loader,
do we?

 BTW, you may omit "nfsroot=" above if you send a root path in a BOOTP
reply and also "ip=bootp" shouldn't be necessary if the causing bug was
fixed (I have a temporary patch).  The limit is 37 characters for the
"boot" variable (due to the limitation of the BBU RAM) and a bit higher
for an explicitly typed in command line (I think it's 80 characters, but I
can't remember for sure). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
