Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1BGaTi13005
	for linux-mips-outgoing; Mon, 11 Feb 2002 08:36:29 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1BGaN913002
	for <linux-mips@oss.sgi.com>; Mon, 11 Feb 2002 08:36:26 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA24431;
	Mon, 11 Feb 2002 16:36:13 +0100 (MET)
Date: Mon, 11 Feb 2002 16:36:13 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Karsten Merker <karsten@excalibur.cologne.de>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: DECstation keyboard mappings and XFree
In-Reply-To: <Pine.GSO.4.21.0202111604400.13432-100000@vervain.sonytel.be>
Message-ID: <Pine.GSO.3.96.1020211163058.18917G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 11 Feb 2002, Geert Uytterhoeven wrote:

> The keyboard mid-layer assumes keycodes are in the range 1-127 (with some minor
> hack 0 can be made to work, cfr. Amiga keboards). Bit 7 is used to
> differentiate between up and down events. This means you cannot get keyboards
> with more than 128 keys to work (e.g. some specialized keyboards for old
> workstations).

 But the raw scancode should be passed as is.  A brief look at
drivers/char/keyboard.c suggests it's doable without breaking anything. 

 Keycodes seem to be limited to 1 - 127, but it's not a problem -- LK
keyboards do not have that many keys.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
