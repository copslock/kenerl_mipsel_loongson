Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0V02Rw28418
	for linux-mips-outgoing; Wed, 30 Jan 2002 16:02:27 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0V02Jd28404
	for <linux-mips@oss.sgi.com>; Wed, 30 Jan 2002 16:02:19 -0800
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g0UN2GX01658
	for <linux-mips@oss.sgi.com>; Wed, 30 Jan 2002 15:02:16 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Linux-MIPS" <linux-mips@oss.sgi.com>
Subject: More data: I've made a CVS build that doesn't crash!
Date: Wed, 30 Jan 2002 15:02:16 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAIAECMCFAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0051_01C1A99F.1B7C26E0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.

------=_NextPart_000_0051_01C1A99F.1B7C26E0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

So, after much trial and error, I've managed to make a build out of
the CVS repository that works and doesn't crash.

I managed to build the linux_2_4_2 tag with the attached patch -- the
patch just fixes up two lines of source code to match new parameter
definitions.  Nothing really fancy.  But this kernel is rock-solid,
and the linux_2_4_3 tag is very crash-prone.

Of course, lots of stuff changed in between all this... so I'm still
pouring over the diffs to see what is causing this.  Anyone with some
helpful suggestions is encouraged to speak up.

Someone with CVS checking authority might want to check in the patch,
just so other people can build 2.4.2 more easily.

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

------=_NextPart_000_0051_01C1A99F.1B7C26E0
Content-Type: application/octet-stream;
	name="fixes-2.4.2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="fixes-2.4.2"

Index: arch/mips/gt64120/momenco_ocelot/reset.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/linux/arch/mips/gt64120/momenco_ocelot/reset.c,v=0A=
retrieving revision 1.2=0A=
diff -u -r1.2 reset.c=0A=
--- arch/mips/gt64120/momenco_ocelot/reset.c	2001/03/11 21:52:24	1.2=0A=
+++ arch/mips/gt64120/momenco_ocelot/reset.c	2002/01/30 23:51:20=0A=
@@ -27,7 +27,7 @@=0A=
 	 * detection stuff.=0A=
 	 */=0A=
 	clear_cp0_status(ST0_BEV | ST0_ERL);=0A=
-	set_cp0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);=0A=
+	set_cp0_config(CONF_CM_UNCACHED);=0A=
 	flush_cache_all();=0A=
 	write_32bit_cp0_register(CP0_WIRED, 0);=0A=
 	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));=0A=
Index: arch/mips/mm/rm7k.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/linux/arch/mips/mm/Attic/rm7k.c,v=0A=
retrieving revision 1.6=0A=
diff -u -r1.6 rm7k.c=0A=
--- arch/mips/mm/rm7k.c	2001/02/20 20:11:08	1.6=0A=
+++ arch/mips/mm/rm7k.c	2002/01/30 23:51:20=0A=
@@ -535,7 +535,7 @@=0A=
 =0A=
 	printk("CPU revision is: %08x\n", read_32bit_cp0_register(CP0_PRID));=0A=
 =0A=
-	set_cp0_config(CONF_CM_CMASK, CONF_CM_CACHABLE_NONCOHERENT);=0A=
+	set_cp0_config(CONF_CM_CACHABLE_NONCOHERENT);=0A=
 =0A=
 	probe_icache(config);=0A=
 	probe_dcache(config);=0A=

------=_NextPart_000_0051_01C1A99F.1B7C26E0--
