Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1BG8U411929
	for linux-mips-outgoing; Mon, 11 Feb 2002 08:08:30 -0800
Received: from aretha.informatik.uni-siegen.de (aretha.informatik.Uni-Siegen.DE [141.99.92.8])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1BG87911925
	for <linux-mips@oss.sgi.com>; Mon, 11 Feb 2002 08:08:23 -0800
Received: (from engel@localhost) by aretha.informatik.uni-siegen.de (Mailhost) id QAA214284; Mon, 11 Feb 2002 16:07:15 +0100 (MET)
Date: Mon, 11 Feb 2002 16:07:15 +0100
From: Michael Engel <engel@informatik.uni-siegen.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Karsten Merker <karsten@excalibur.cologne.de>, linux-mips@oss.sgi.com
Subject: Re: DECstation keyboard mappings and XFree
Message-ID: <20020211160715.A214199@aretha.informatik.uni-siegen.de>
References: <20020211152621.A14342@excalibur.cologne.de> <Pine.GSO.3.96.1020211152428.18917D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.2i
In-Reply-To: <Pine.GSO.3.96.1020211152428.18917D-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Feb 11, 2002 at 03:49:19PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi,

On Mon, Feb 11, 2002 at 03:49:19PM +0100, Maciej W. Rozycki wrote:
> On Mon, 11 Feb 2002, Karsten Merker wrote:
> 
> > >  Hmm, why do you need (sh*tty) PC-compatible keycodes for a keaboard that
> > > barely resembles a PC keyboard?  AFAIK, XFree86 has appropriate LK201
> > > keymaps -- see "/usr/X11R6/lib/X11/xkb/*/digital/*". 
> > 
> > Because the original code does not deliver LK201 keycodes - LK201 keycodes
> > are in the range 0x55 - 0xfb, but the kernel to my knowledge accepts only
> > keycodes in the range 0x01 - 0x7f, so the original code already did a
> > remapping of the LK201 raw codes (it delivered the key numbers from the 
> > top left to the downmost right keys, i.e. F1=1, F2=2, F3=3 etc.).
> 
>  This may be reasonable for the pc_keyb.c driver, but we don't use it, do
> we?

Unfortunately, handle_scancode still uses the 0x80 bit internally 
to indicate key up transisitions (see drivers/char/keyboard.c).
So IMHO only keycodes <= 0x7f are usable. Same problem with Access.Bus
LK501 keyboards, btw.

> > This means that the XFree LK201 mapping did not work, and if we have
> > to remap keycodes anyway into the range 0x01-0x7f, using a PC-compatible 
> > keymap seemed the best solution to me.
> 
>  Then the kernel needs to be fixed -- raw scancodes should be passed as is
> and the translation should be done in kbd_translate().  I'm adding it to
> my to-do list (to be resolved soon, hopefully, together with the annoying
> indefinite timeout when no keyboard is attached). 

Hmmm, this change would probably affect a lot of the console
infrastructure. I'm still waiting for the promised rewritten console
code in 2.5 ;-).

regards,
	Michael
