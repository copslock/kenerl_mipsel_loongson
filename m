Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Sep 2002 20:49:31 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:19081 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1121744AbSI1Sta>; Sat, 28 Sep 2002 20:49:30 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA11477;
	Sat, 28 Sep 2002 20:49:52 +0200 (MET DST)
Date: Sat, 28 Sep 2002 20:49:52 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Karsten Merker <karsten@excalibur.cologne.de>,
	Florian Lohoff <flo@rfc822.org>
cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] dec_esp.c repair mmu_sglist breakage
In-Reply-To: <20020928103840.GA23300@linuxtag.org>
Message-ID: <Pine.GSO.3.96.1020928203950.10698B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Sat, 28 Sep 2002, Karsten Merker wrote:

> > through the whole issue of the mmu_sglist confusion and the broken
> > reimplantation of mmu_sglist the dec_esp broke. Here is a fix
> > to really remove the mmu_sglist and use scatterlist instead. With
> > this the Decstation on this desk at least finds its partitions
> > again and does not crash.
> 
> I tested the patch on my DS 5000/150 and it works there, too.

 Thanks for the report -- since I have no means to test the SCSI driver I
was going to ask people for testing to have another confirmation.  I'm not
sure why it got broken (I'll check the details to find out) as the changes
were to revert to the original behaviour, but since struct mmu_sglist got
deprecated, I'm happy to see an update to struct scatterlist.  Since the
change works for both of you, I'm checking it in now. 

> Could you please check it into the cvs? Without it the kernel
> is de facto unusable on DECstations.

 Well, it depends on the actual configuration -- I haven't noticed
anything wrong. ;-)

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
