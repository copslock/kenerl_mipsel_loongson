Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2005 18:37:09 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:1541 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226009AbVEFRgy>; Fri, 6 May 2005 18:36:54 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id B937CF59E4; Fri,  6 May 2005 19:36:46 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 28279-10; Fri,  6 May 2005 19:36:46 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id D5659E1C6D; Fri,  6 May 2005 19:36:45 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j46HajwP021329;
	Fri, 6 May 2005 19:36:46 +0200
Date:	Fri, 6 May 2005 18:36:56 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Bryan Althouse <bryan.althouse@3phoenix.com>,
	"'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: RE: ATA devices attached to arbitary busses
In-Reply-To: <Pine.LNX.4.62.0505061911220.5272@numbat.sonytel.be>
Message-ID: <Pine.LNX.4.61L.0505061832390.25293@blysk.ds.pg.gda.pl>
References: <200505061709.j46H9L3a021796@nerdnet.nl>
 <Pine.LNX.4.62.0505061911220.5272@numbat.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.83/871/Thu May  5 15:50:45 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 6 May 2005, Geert Uytterhoeven wrote:

> > It looks like the example that Alan contributed does not update
> > HWIF(drive)->io_ports[IDE_IRQ_OFFSET].  Or at least I cant figure out where.
> 
> Indeed, macide passes 0 for ctrlport and irqport to ide_setup_ports(). If you
> need another example, you can look at drivers/ide/legacy/gayle.c.

 Or perhaps at "drivers/ide/mips/swarm.c" which is nice, being for MIPS, 
memory-mapped and wired to an "arbitary bus". ;-)  No DMA, though.

  Maciej
