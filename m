Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1BF7UN10310
	for linux-mips-outgoing; Mon, 11 Feb 2002 07:07:30 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1BF7N910303
	for <linux-mips@oss.sgi.com>; Mon, 11 Feb 2002 07:07:24 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA22256;
	Mon, 11 Feb 2002 15:07:08 +0100 (MET)
Date: Mon, 11 Feb 2002 15:07:08 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Karsten Merker <karsten@excalibur.cologne.de>
cc: linux-mips@oss.sgi.com
Subject: Re: DECstation keyboard mappings and XFree
In-Reply-To: <20020210181718.A641@excalibur.cologne.de>
Message-ID: <Pine.GSO.3.96.1020211141453.18917B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, 10 Feb 2002, Karsten Merker wrote:

> I have modified the keycode remapping table in drivers/tc/lk201-remap.c
> to deliver PC compatible keycodes. Aim of this modification is easier
> use of XFree86 on DECstations (with the standard PC-keyboard map) and
> the possibility to use existing loadable national keymaps for i386.
> In theory, this should work, in practice, it does not :-(.

 Hmm, why do you need (sh*tty) PC-compatible keycodes for a keaboard that
barely resembles a PC keyboard?  AFAIK, XFree86 has appropriate LK201
keymaps -- see "/usr/X11R6/lib/X11/xkb/*/digital/*". 

 Just set up your "Keyboard" section of XF86Config correctly.  E.g.
(completely untested):

Section "Keyboard"
  XkbKeycodes "digital/lk(lk201)"
  XkbSymbols "digital/us(us)"
  XkbGeometry "digital/lk(lk201)"
EndSection

It might be nice to add these values to Xkb rules somewhere
("/usr/X11R6/lib/X11/xkb/rules/digital"?) one day, so you don't need to
specify components separately for default values, but I'm not sure our
XFree86 support is stable enough to consider it now. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
