Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2003 15:48:28 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:38580 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224861AbTFQOs0>; Tue, 17 Jun 2003 15:48:26 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA24794;
	Tue, 17 Jun 2003 16:49:17 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 17 Jun 2003 16:49:17 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Ladislav Michl <ladis@linux-mips.org>,
	Juan Quintela <quintela@trasno.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] kill prom_printf
In-Reply-To: <Pine.GSO.4.21.0306171637390.17930-100000@vervain.sonytel.be>
Message-ID: <Pine.GSO.3.96.1030617164642.22214J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 17 Jun 2003, Geert Uytterhoeven wrote:

> >  Hmm, calling the firmware for each character separately will certainly be
> > terribly slow, though it may be negligible as normally few messages will
> > be output this way.  And since the call to prom_printf() is so cheap for
> > the DECstation, I'm going to retain the function for real low-level
> > debugging, whether otherwise used or not. 
> 
> kernel/printk.c doesn't call the low-level output routine for each character
> separately, but passes complete strings of characters.

 So I can just call prom_printf("%s", string), right?  This would solve
this shortcoming. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
