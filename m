Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jun 2004 23:43:58 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:42651 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225800AbUF2Wnx>; Tue, 29 Jun 2004 23:43:53 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id A40CB3E6; Wed, 30 Jun 2004 00:43:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 938B4316; Wed, 30 Jun 2004 00:43:47 +0200 (CEST)
Date: Wed, 30 Jun 2004 00:43:47 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Jun Sun <jsun@mvista.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [patch] Incorrect mapping of serial ports to lines
In-Reply-To: <20040629151313.E6498@mvista.com>
Message-ID: <Pine.LNX.4.55.0406300022290.31801@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0406281513120.23162@jurand.ds.pg.gda.pl>
 <20040628235908.GC5736@linux-mips.org> <Pine.LNX.4.55.0406291345590.31801@jurand.ds.pg.gda.pl>
 <Pine.GSO.4.58.0406291408020.29058@waterleaf.sonytel.be>
 <Pine.LNX.4.55.0406291546480.31801@jurand.ds.pg.gda.pl> <20040629151313.E6498@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 29 Jun 2004, Jun Sun wrote:

> This is why I favor run-time serial port configuration.  My view

 Well, that's certainly a reasonable long-time strategy.

> (maybe a little dramatic) is to remove all static serial port definition
> and push them into board setup routine.  asm/serial.h only needs

 I'm not sure that is the right way of doing it -- note that one problem
is serial drivers can be built as modules and inserted at the run time.

 I haven't looked into the serial I/O subsystem of 2.6, yet, so I don't
know if it offers any support for different wirings of the same U(S)ART.  
In theory I think the most reasonable approach it would be to provide
system-specific frontends to a generic backend for a given U(S)ART (like
an 8250-compatible).  The frontends would handle address mapping, DMA if
available, etc. and be a way to deal with system-specific quirks.

> to define the number serial lines, which itself could be configurable.

 I don't think there needs to be any arbitrary limit here.  With hot-plug
PCI and similar setups ports can appear and disappear from a system at any
time, so the associated resources should be allocated dynamically anyway.

  Maciej
