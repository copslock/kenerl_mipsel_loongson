Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jun 2004 13:10:54 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:41673 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225456AbUF3MKt>; Wed, 30 Jun 2004 13:10:49 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 2EC824762F; Wed, 30 Jun 2004 14:10:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 1AF8E44CD0; Wed, 30 Jun 2004 14:10:43 +0200 (CEST)
Date: Wed, 30 Jun 2004 14:10:43 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jun Sun <jsun@mvista.com>, Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [patch] Incorrect mapping of serial ports to lines
In-Reply-To: <Pine.GSO.4.58.0406301006340.20130@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.55.0406301408010.31801@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0406281513120.23162@jurand.ds.pg.gda.pl>
 <20040628235908.GC5736@linux-mips.org> <Pine.LNX.4.55.0406291345590.31801@jurand.ds.pg.gda.pl>
 <Pine.GSO.4.58.0406291408020.29058@waterleaf.sonytel.be>
 <Pine.LNX.4.55.0406291546480.31801@jurand.ds.pg.gda.pl> <20040629151313.E6498@mvista.com>
 <Pine.LNX.4.55.0406300022290.31801@jurand.ds.pg.gda.pl>
 <Pine.GSO.4.58.0406301006340.20130@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 30 Jun 2004, Geert Uytterhoeven wrote:

> > > (maybe a little dramatic) is to remove all static serial port definition
> > > and push them into board setup routine.  asm/serial.h only needs
> >
> >  I'm not sure that is the right way of doing it -- note that one problem
> > is serial drivers can be built as modules and inserted at the run time.
> 
> The same is true for whatever other type of device (SCSI, IDE, Ethernet, ...).

 Yes and sensible drivers handle it correctly.  A classical example is the 
8390.c Ethernet driver with its various frontends.

> And depending on the order of module loading, the order of the devices will
> change.

 And given the order is fully configurable, it's actually a good thing.

  Maciej
