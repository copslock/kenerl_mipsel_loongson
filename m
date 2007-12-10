Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Dec 2007 11:58:26 +0000 (GMT)
Received: from host188-210-dynamic.20-79-r.retail.telecomitalia.it ([79.20.210.188]:51899
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20024298AbXLJL6R (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Dec 2007 11:58:17 +0000
Received: from eppesuig3 ([192.168.2.50])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1J1hH2-00014H-ET
	for linux-mips@linux-mips.org; Mon, 10 Dec 2007 12:58:14 +0100
Subject: Re: 2.6.24-rc1 does not boot on SGI
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
In-Reply-To: <1194281699.4192.3.camel@casa>
References: <1193468825.7474.6.camel@scarafaggio>
	 <20071029.000713.59464443.anemo@mba.ocn.ne.jp>
	 <1193599031.14874.1.camel@scarafaggio>
	 <20071029150625.GB4165@linux-mips.org>
	 <1194268551.4842.3.camel@scarafaggio>  <1194281699.4192.3.camel@casa>
Content-Type: text/plain
Date:	Mon, 10 Dec 2007 12:58:49 +0100
Message-Id: <1197287929.17265.6.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

I reply to my own message, providing more details, hoping that anyone
here could give a hint or the solution.

During bootup on ip32, since 2.4.24-rc1, the system loop printing a
message about unexpected interrupt #13. (see transcript below.)

I enabled more debug in the kernel, and studied the code. What I
understood is that interrupt #13 from CRIME means that the system should
check on MACEISA for the real interrupt.

The interrupt start appearing just after executing the code
psmouse_init() that enable ps2 drivers for keyboard and mouse. Keyboard
interrupt #49 is enabled first and mouse interrupt #51 is enabled later.

When initialising the keyboard interrupt (it is a MACEISA interrupt),
the interrupt start appearing, so I am pretty sure that interrupt #13 is
related to the keyboard interrupt.

When the system receive interrupt #13, it correctly detect it is a
MACEISA interrupt, and check for mace->perif.ctrl.istat value. The
problem seems to be that this value is zero instead of having bit #9 on
(that would mean, interrupt #49, keyboard).

So, either the interrupt #49 is not correctly enabled, or maceisa
interrupt aren't correctly checked.

Does this description ring a bell to anyone?

Bye,
Giuseppe

Calling initcall 0xffffffff80496ca0: serport_init+0x0/0x48()
initcall 0xffffffff80496ca0: serport_init+0x0/0x48() returned 0.
initcall 0xffffffff80496ca0 ran for 0 msecs: serport_init+0x0/0x48()
Calling initcall 0xffffffff80496ce8: maceps2_init+0x0/0xe0()
initcall 0xffffffff80496ce8: maceps2_init+0x0/0xe0() returned 0.
initcall 0xffffffff80496ce8 ran for 1 msecs: maceps2_init+0x0/0xe0()
Calling initcall 0xffffffff80496dc8: serio_raw_init+0x0/0x18()
initcall 0xffffffff80496dc8: serio_raw_init+0x0/0x18() returned 0.
initcall 0xffffffff80496dc8 ran for 1 msecs: serio_raw_init+0x0/0x18()
Calling initcall 0xffffffff80496f40: mousedev_init+0x0/0xd0()
mice: PS/2 mouse device common for all mice
initcall 0xffffffff80496f40: mousedev_init+0x0/0xd0() returned 0.
initcall 0xffffffff80496f40 ran for 16 msecs: mousedev_init+0x0/0xd0()
Calling initcall 0xffffffff80497010: atkbd_init+0x0/0x18()
initcall 0xffffffff80497010: atkbd_init+0x0/0x18() returned 0.
initcall 0xffffffff80497010 ran for 0 msecs: atkbd_init+0x0/0x18()
Calling initcall 0xffffffff80497028: psmouse_init+0x0/0x90()
maceisa enable: 49
crime_int 00000020 enabled
*irq 13, crime_int=00002000, crime_mask=003003a0, mace_int=00000000*
irq 13, desc: ffffffff80448390, depth: 1, count: 0, unhandled: 0
->handle_irq():  ffffffff80065eb0, handle_bad_irq+0x0/0x2c0
->chip(): ffffffff8043e320, 0xffffffff8043e320
->action(): 0000000000000000
  IRQ_DISABLED set
