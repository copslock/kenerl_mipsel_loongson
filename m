Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2003 15:16:20 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:13745 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225073AbTE0OQS>; Tue, 27 May 2003 15:16:18 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA26198;
	Tue, 27 May 2003 16:16:22 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 27 May 2003 16:16:22 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Arrow keys on USB keyboards
In-Reply-To: <Pine.GSO.4.21.0305271552430.29405-100000@vervain.sonytel.be>
Message-ID: <Pine.GSO.3.96.1030527160058.24408F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 27 May 2003, Geert Uytterhoeven wrote:

> However, the input subsystem converts Linux input keycodes (cfr.
> <linux/input.h>) to PC/AT scancodes, and feeds them to handle_scancode() in
> drivers/char/keyboard.c. handle_scancode() calls kbd_translate() to translate
> scancodes to keycodes, which is keyboard driver specific.

 Oh what a mess! -- why does it do so?  Since as I understand these input
keycodes are already translated from scancodes, why do they need to be
translated "back" to PC/AT scancodes (possibly with private inventions for
keys that do not exist on PC/AT or PS/2 keyboards) only to be translated
to medium-raw keycodes (for a total number of four translations from an
original scancode to a final cooked sequence)?  Why can't the input layer
provide its own kbd_translate() function translating directly from input
keycodes to medium-raw keycodes (or why the input keycodes are different
from medium-raw keycodes at all)?

 After all it looks like the input layer can be treated like a virtual
keyboard driver itself. 

> Since the input subsystem feeds PC/AT scancodes to handle_scancode(),
> kbd_translate() needs to know about PC/AT scancodes. For the PS/2 keyboard
> driver this is OK, for the dummy keyboard driver this is OK after my patch, but
> for any other keyboard driver this will not work.

 Why can't the input layer be fixed instead?  Given the interface between
the input layer and drivers/char/keyboard.c is internal the impact on
backend drivers should be nonexistent, hence no incompatibility problem
for 2.4.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
