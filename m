Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Jan 2005 01:18:57 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:16905 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225302AbVA3BSm>; Sun, 30 Jan 2005 01:18:42 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id B226AE1CAF; Sun, 30 Jan 2005 02:18:32 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 31909-04; Sun, 30 Jan 2005 02:18:32 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id F04EAE1C6D; Sun, 30 Jan 2005 02:18:31 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j0U1Icui006194;
	Sun, 30 Jan 2005 02:18:38 +0100
Date:	Sun, 30 Jan 2005 01:18:52 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Christoph Hellwig <hch@lst.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: changes to drivers/scsi/sym53c8xx_defs.h in the mips tree
In-Reply-To: <20050129163746.GA21213@lst.de>
Message-ID: <Pine.LNX.4.61L.0501292325490.29728@blysk.ds.pg.gda.pl>
References: <20050129163746.GA21213@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/661/Tue Jan 11 02:44:13 2005
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 29 Jan 2005, Christoph Hellwig wrote:

> Hi Carsten,

 I'm afraid Carsten may no longer be reachable, but I may try to help in 
his stead.

> do you remember what your changes to drivers/scsi/sym53c8xx_defs.h in
> the mips tree are supposed to help with?

 It must have been the MIPS Technologies' Atlas development board which 
has a SYM53C810A incorporated, even though the resulting changes are 
specific to the board.  There appears to have been some sort of confusion 
about the semantics of i/o and mmio operations in mixed-endian 
configurations, which for the MIPS port actually is currently being 
resolved.

> sym53c8xx_defs.h is only used for the ncr53c8xx driver, which despite
> the name is only for NCR53c720 chips these days (supported on parisc,
> and eisa/mca).  It has correct big endian support for parisc alrady.

 I can verify whether the other driver operates correctly in the four 
possible configurations with an Atlas board.

 BTW, that SCSI_NCR_BIG_ENDIAN macro looks scary -- is the chip wired 
incorrectly (i.e. with byte lanes swapped at PCI) or are i/o and/or mmio 
operations simply broken for parisc?

> Also the patch duplicates your changelog and copyright entry that's
> in the file already.

 It looks like some sort of a merging mistake.

  Maciej
