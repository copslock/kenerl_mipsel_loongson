Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1BGfLx13099
	for linux-mips-outgoing; Mon, 11 Feb 2002 08:41:21 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1BGf9913094
	for <linux-mips@oss.sgi.com>; Mon, 11 Feb 2002 08:41:10 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA24488;
	Mon, 11 Feb 2002 16:39:27 +0100 (MET)
Date: Mon, 11 Feb 2002 16:39:27 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Michael Engel <engel@informatik.uni-siegen.de>
cc: Karsten Merker <karsten@excalibur.cologne.de>, linux-mips@oss.sgi.com
Subject: Re: DECstation keyboard mappings and XFree
In-Reply-To: <20020211160715.A214199@aretha.informatik.uni-siegen.de>
Message-ID: <Pine.GSO.3.96.1020211163633.18917H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 11 Feb 2002, Michael Engel wrote:

> >  Then the kernel needs to be fixed -- raw scancodes should be passed as is
> > and the translation should be done in kbd_translate().  I'm adding it to
> > my to-do list (to be resolved soon, hopefully, together with the annoying
> > indefinite timeout when no keyboard is attached). 
> 
> Hmmm, this change would probably affect a lot of the console
> infrastructure. I'm still waiting for the promised rewritten console
> code in 2.5 ;-).

 Not at all.  There is only a small bug that needs to be fixed in
drivers/char/keyboard.c. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
