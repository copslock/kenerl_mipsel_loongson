Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Feb 2005 05:55:04 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:27147 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224855AbVBMFyr>; Sun, 13 Feb 2005 05:54:47 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id DE926E1CB5; Sun, 13 Feb 2005 06:54:40 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 11980-09; Sun, 13 Feb 2005 06:54:40 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 9FA69E1CB0; Sun, 13 Feb 2005 06:54:40 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j1D5sb5S001231;
	Sun, 13 Feb 2005 06:54:42 +0100
Date:	Sun, 13 Feb 2005 05:54:37 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	"Nori, Soma Sekhar" <nsekhar@ti.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Using JR instead of J instruction for jumping to IRQ
 handler.
In-Reply-To: <F6B01C6242515443BB6E5DDD63AE935F046834@dbde2k01.itg.ti.com>
Message-ID: <Pine.LNX.4.61L.0502130538150.23762@blysk.ds.pg.gda.pl>
References: <F6B01C6242515443BB6E5DDD63AE935F046834@dbde2k01.itg.ti.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/700/Fri Feb  4 00:33:15 2005
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 12 Feb 2005, Nori, Soma Sekhar wrote:

> Attached patch attempts to use load address k0, <handler> followed by
> jump register k0 to jump to the MIPS IRQ handler from CAC_BASE + 0x200
> instead of just jump <handler>. This will enable jumping even if IRQ
> handler is linked at high kernel logical address. (like 0x94000000+).
> 
> I have tested this to work fine on my 4kec. (Not sure if the code will
> hold good for MIPS64 though)

 Well, it's where it would actually be especially useful, specifically for 
64-bit kernels loaded at XPHYS addresses.  Given it's generated code and 
this way of handling interrupts aims at improving performance (otherwise 
why bother using a separate vector at all?), it should actually determine 
whether an absolute jump suffices and emit code appropriately.

 That said, with the 4KEc you'd probably be better with using the CP0 
Ebase register instead.

  Maciej
