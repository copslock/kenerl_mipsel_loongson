Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1BFK5O10583
	for linux-mips-outgoing; Mon, 11 Feb 2002 07:20:05 -0800
Received: from post.webmailer.de (natwar.webmailer.de [192.67.198.70])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1BFK1910580
	for <linux-mips@oss.sgi.com>; Mon, 11 Feb 2002 07:20:01 -0800
Received: from excalibur.cologne.de (pD9E40306.dip.t-dialin.net [217.228.3.6])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id PAA04904
	for <linux-mips@oss.sgi.com>; Mon, 11 Feb 2002 15:19:52 +0100 (MET)
Received: from karsten by excalibur.cologne.de with local (Exim 3.12 #1 (Debian))
	id 16aHPR-0003jW-00
	for <linux-mips@oss.sgi.com>; Mon, 11 Feb 2002 15:26:21 +0100
Date: Mon, 11 Feb 2002 15:26:21 +0100
From: Karsten Merker <karsten@excalibur.cologne.de>
To: linux-mips@oss.sgi.com
Subject: Re: DECstation keyboard mappings and XFree
Message-ID: <20020211152621.A14342@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@oss.sgi.com
References: <20020210181718.A641@excalibur.cologne.de> <Pine.GSO.3.96.1020211141453.18917B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1020211141453.18917B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Feb 11, 2002 at 03:07:08PM +0100
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Feb 11, 2002 at 03:07:08PM +0100, Maciej W. Rozycki wrote:
> On Sun, 10 Feb 2002, Karsten Merker wrote:
> 
> > I have modified the keycode remapping table in drivers/tc/lk201-remap.c
> > to deliver PC compatible keycodes. Aim of this modification is easier
> > use of XFree86 on DECstations (with the standard PC-keyboard map) and
> > the possibility to use existing loadable national keymaps for i386.
> > In theory, this should work, in practice, it does not :-(.
> 
>  Hmm, why do you need (sh*tty) PC-compatible keycodes for a keaboard that
> barely resembles a PC keyboard?  AFAIK, XFree86 has appropriate LK201
> keymaps -- see "/usr/X11R6/lib/X11/xkb/*/digital/*". 

Because the original code does not deliver LK201 keycodes - LK201 keycodes
are in the range 0x55 - 0xfb, but the kernel to my knowledge accepts only
keycodes in the range 0x01 - 0x7f, so the original code already did a
remapping of the LK201 raw codes (it delivered the key numbers from the 
top left to the downmost right keys, i.e. F1=1, F2=2, F3=3 etc.).
This means that the XFree LK201 mapping did not work, and if we have
to remap keycodes anyway into the range 0x01-0x7f, using a PC-compatible 
keymap seemed the best solution to me.

Regards,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
