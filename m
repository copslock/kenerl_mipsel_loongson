Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 May 2003 15:05:31 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:45719 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224861AbTEWOF2>; Fri, 23 May 2003 15:05:28 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA17158;
	Fri, 23 May 2003 16:05:43 +0200 (MET DST)
Date: Fri, 23 May 2003 16:05:43 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Arrow keys on USB keyboards
In-Reply-To: <Pine.GSO.4.21.0305231545030.26586-100000@vervain.sonytel.be>
Message-ID: <Pine.GSO.3.96.1030523155904.14542E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 23 May 2003, Geert Uytterhoeven wrote:

> This patch fixes the arrow keys (and all other keys that generate E0/E1
> scancode prefixes on AT keyboards) by adding support for E0/E1 scancode
> prefixes to the dummy keyboard driver if CONFIG_INPUT=y.
> 
> Rationale: When using the new input layer (i.e. with a USB keyboard or a custom
> input device), the input layer relies on kbd_translate() in the low-level
> keyboard driver to convert from AT-style scancodes to keycodes. If you don't
> have a PS/2 keyboard interface and don't compile in the PS/2 keyboard driver,
> you have to enable the dummy keyboard driver, which naively assumes that
> keycodes and scancodes are interchangeable. This is correct if you do not have
> a keyboard, but fails for prefixed scancodes if you do have a keyboard which
> uses the new input layer.

 Hmm, if the PC/AT keyboard translation is needed by other devices beside
pc_keyb.c, then why isn't the common part put into a separate file to be
used by all devices depending on this translation as needed?  I think
dummy_keyb.c should be kept plain and simple as it is now. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
