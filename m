Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 May 2004 12:23:40 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:7328 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225248AbUESLXj>; Wed, 19 May 2004 12:23:39 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id B63644A074; Wed, 19 May 2004 13:23:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 979C9474C5; Wed, 19 May 2004 13:23:28 +0200 (CEST)
Date: Wed, 19 May 2004 13:23:28 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Kieran Fulke <kieran@pawsoff.org>
Cc: linux-mips@linux-mips.org
Subject: Re: IRQ problem on cobalt / 2.6.6
In-Reply-To: <20040518205914.GA29574@getyour.pawsoff.org>
Message-ID: <Pine.LNX.4.55.0405191318500.22609@jurand.ds.pg.gda.pl>
References: <20040513183059.GA25743@getyour.pawsoff.org>
 <20040518073439.GA6818@skeleton-jack> <20040518205914.GA29574@getyour.pawsoff.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 18 May 2004, Kieran Fulke wrote:

> alas, no joy.
[...]
> VP_IDE: VIA vt82c586a (rev 27) IDE UDMA33 controller on pci0000:00:09.1
>     ide0: BM-DMA at 0x1420-0x1427, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0x1428-0x142f, BIOS settings: hdc:pio, hdd:pio
> spurious 8259A interrupt: IRQ9.

 Hmm, interesting.  As the 8259A can only signal IRQ7 and possibly IRQ15
as spurious interrupts, this smells like a bug in 8259A handlers,
regardless of system-specific problems you have.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
