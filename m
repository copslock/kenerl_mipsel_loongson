Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2003 14:50:18 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:51631 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225073AbTE0NuP>; Tue, 27 May 2003 14:50:15 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA25830;
	Tue, 27 May 2003 15:50:59 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 27 May 2003 15:50:59 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Arrow keys on USB keyboards
In-Reply-To: <Pine.GSO.4.21.0305271521210.29405-100000@vervain.sonytel.be>
Message-ID: <Pine.GSO.3.96.1030527154004.24408D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 27 May 2003, Geert Uytterhoeven wrote:

> >  Hmm, as I've understood that's a 2.4-only problem as 2.5 has it solved
> > differently.  And I do think the translation really belong to the drivers
> > that use it -- why can't it be included with the USB keyboard driver or as
> > a library file?  Why an unrelated driver has to be cluttered? 
> 
> It's not really used by a driver, but by the input subsystem itself. You could
> add the translation to drivers/char/keyboard.c, but then it will break if you
> use both the input subsystem (e.g. USB keyboard) and some other non-PS/2
> keyboard driver.

 I don't understand -- the scancode mapping is specific to a keyboard
type.  Both PC/AT and USB keyboards may use the same scancodes by chance,
but others have different ones.  So how can the input subsystem need a
PC/AT specific mapping?  Adding the table to drivers/char/keyboard.c
certainly makes no sense as the file is meant to be generic. 

 BTW, the PS/2 mapping is yet different and doesn't use prefixes. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
