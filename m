Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1BFxlt11546
	for linux-mips-outgoing; Mon, 11 Feb 2002 07:59:47 -0800
Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1BFxh911537
	for <linux-mips@oss.sgi.com>; Mon, 11 Feb 2002 07:59:43 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id GAA00810
	for <linux-mips@oss.sgi.com>; Mon, 11 Feb 2002 06:55:13 -0800 (PST)
	mail_from (macro@ds2.pg.gda.pl)
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA23152;
	Mon, 11 Feb 2002 15:49:20 +0100 (MET)
Date: Mon, 11 Feb 2002 15:49:19 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Karsten Merker <karsten@excalibur.cologne.de>
cc: linux-mips@oss.sgi.com
Subject: Re: DECstation keyboard mappings and XFree
In-Reply-To: <20020211152621.A14342@excalibur.cologne.de>
Message-ID: <Pine.GSO.3.96.1020211152428.18917D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 11 Feb 2002, Karsten Merker wrote:

> >  Hmm, why do you need (sh*tty) PC-compatible keycodes for a keaboard that
> > barely resembles a PC keyboard?  AFAIK, XFree86 has appropriate LK201
> > keymaps -- see "/usr/X11R6/lib/X11/xkb/*/digital/*". 
> 
> Because the original code does not deliver LK201 keycodes - LK201 keycodes
> are in the range 0x55 - 0xfb, but the kernel to my knowledge accepts only
> keycodes in the range 0x01 - 0x7f, so the original code already did a
> remapping of the LK201 raw codes (it delivered the key numbers from the 
> top left to the downmost right keys, i.e. F1=1, F2=2, F3=3 etc.).

 This may be reasonable for the pc_keyb.c driver, but we don't use it, do
we?

> This means that the XFree LK201 mapping did not work, and if we have
> to remap keycodes anyway into the range 0x01-0x7f, using a PC-compatible 
> keymap seemed the best solution to me.

 Then the kernel needs to be fixed -- raw scancodes should be passed as is
and the translation should be done in kbd_translate().  I'm adding it to
my to-do list (to be resolved soon, hopefully, together with the annoying
indefinite timeout when no keyboard is attached). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
