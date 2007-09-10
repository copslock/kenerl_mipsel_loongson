Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Sep 2007 14:28:41 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:33751 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021823AbXIJN2c (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Sep 2007 14:28:32 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id DA784400B5;
	Mon, 10 Sep 2007 15:28:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id Gzq0a6WYMetM; Mon, 10 Sep 2007 15:27:54 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id BE5B9400B3;
	Mon, 10 Sep 2007 15:27:54 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l8ADRvA6000795;
	Mon, 10 Sep 2007 15:27:57 +0200
Date:	Mon, 10 Sep 2007 14:27:54 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] SMTC: Fix crash on bootup with idebus= command line
 argument.
In-Reply-To: <S20024438AbXHGQ1m/20070807162742Z+2733@ftp.linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0709101406091.25038@blysk.ds.pg.gda.pl>
References: <S20024438AbXHGQ1m/20070807162742Z+2733@ftp.linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4226/Mon Sep 10 06:56:31 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 7 Aug 2007, linux-mips@linux-mips.org wrote:

> Author: Ralf Baechle <ralf@linux-mips.org> Tue Aug 7 17:18:28 2007 +0100
> Commit: 00cc123703425aa362b0af75616134cbad4e0689
> Gitweb: http://www.linux-mips.org/g/linux/00cc1237
> Branch: master
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> ---
> 
>  include/asm-mips/mach-generic/ide.h |   76 ++++++++++++-----------------------
>  1 files changed, 25 insertions(+), 51 deletions(-)

 This change breaks the SWARM -- depending on the setting of 
CONFIG_IDE_GENERIC, either a bus error happens because of blind probing or 
the onboard IDE interface gets designated as "ide2".  I cannot really see 
a dependency between "idebus=" (which merely sets a variable somewhere in 
drivers/ide/ide.c) and code affected by this change -- what's the reason 
behind it?

 Also the comment is misleading -- there is almost nothing about IDE in 
the PCI spec; certainly nothing that would make I/O ports at 0x1f0 and 
0x170 special.  They may be special for a IDE controller PCI devices, but 
one cannot simply assume such a device is present somewhere on the bus (or 
that something will subtractively decode unclaimed addresses).

  Maciej
