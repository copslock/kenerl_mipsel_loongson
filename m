Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Feb 2005 00:35:50 +0000 (GMT)
Received: from mail-relay.infostations.net ([IPv6:::ffff:69.19.152.5]:2697
	"EHLO mail-relay.infostations.net") by linux-mips.org with ESMTP
	id <S8225325AbVBBAfd>; Wed, 2 Feb 2005 00:35:33 +0000
Received: from iria.infostations.net (iria.infostations.net [71.4.40.31])
	by mail-relay.infostations.net (Postfix) with ESMTP id 16AD39F718
	for <linux-mips@linux-mips.org>; Tue,  1 Feb 2005 16:35:53 -0800 (PST)
Received: from host-69-19-171-174.rev.o1.com ([69.19.171.174])
	by iria.infostations.net with esmtp (Exim 4.41 #1 (Gentoo))
	id 1Cw8V2-0001yq-GN
	for <linux-mips@linux-mips.org>; Tue, 01 Feb 2005 16:36:06 -0800
Subject: Problems with PCMCIA on AMD Alchemy DB1100
From:	Josh Green <jgreen@users.sourceforge.net>
To:	linux-mips@linux-mips.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-f8rVQ/0GO5hYvE2dZE4M"
Date:	Tue, 01 Feb 2005 16:36:07 -0800
Message-Id: <1107304567.2912.34.camel@SillyPuddy.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Return-Path: <jgreen@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgreen@users.sourceforge.net
Precedence: bulk
X-list: linux-mips


--=-f8rVQ/0GO5hYvE2dZE4M
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I'm using the latest Linux MIPS CVS (2.6.11-rc2) on an AMD Alchemy
DB1100 with a tool chain created with buildroot (gcc 3.4.3, binutils
2.15.91.0.2) and found a bug in drivers/pcmcia/au1000_generic.c that was
causing the following error during initialization (not exact text, close
as I can remember), and subsequently the PCMCIA hardware was unavailable
(pcmcia_register_socket() was failing due to NULL resource_opts field).

au1x00_pcmcia: probe of au1x00-pcmcia0 failed with error -22

Here is a patch:

--- au1000_generic.c.orig       2005-02-01 12:19:29.572617936 -0800
+++ au1000_generic.c    2005-02-01 13:47:08.543132896 -0800
@@ -392,6 +392,7 @@
                memset(skt, 0, sizeof(*skt));

                skt->socket.ops =3D &au1x00_pcmcia_operations;
+               skt->socket.resource_ops =3D &pccard_static_ops;
                skt->socket.owner =3D ops->owner;
                skt->socket.dev.dev =3D dev;


Additionally I noticed that some of the 36 bit constants in
au1000_generic.h (AU1X_SOCK0_IO and AU1X_SOCK1_IO) were causing the
warning "Integer constant too large for long type" (IIRC).  Here is a
patch for this, although I'm not sure if this is the correct way to fix
it, or even if it was causing problems or not, although it does get rid
of the warnings.


--- au1000_generic.h.orig       2005-02-01 12:39:16.371197128 -0800
+++ au1000_generic.h    2005-02-01 12:40:23.405006440 -0800
@@ -34,9 +34,9 @@
 #define AU1000_PCMCIA_IO_SPEED       (255)
 #define AU1000_PCMCIA_MEM_SPEED      (300)

-#define AU1X_SOCK0_IO        0xF00000000
-#define AU1X_SOCK0_PHYS_ATTR 0xF40000000
-#define AU1X_SOCK0_PHYS_MEM  0xF80000000
+#define AU1X_SOCK0_IO        0xF00000000LL
+#define AU1X_SOCK0_PHYS_ATTR 0xF40000000LL
+#define AU1X_SOCK0_PHYS_MEM  0xF80000000LL
 /* pseudo 32 bit phys addresses, which get fixed up to the
  * real 36 bit address in fixup_bigphys_addr() */
 #define AU1X_SOCK0_PSEUDO_PHYS_ATTR 0xF4000000
@@ -46,15 +46,15 @@
  * differs from board to board.
  */
 #if defined(CONFIG_MIPS_PB1000) || defined(CONFIG_MIPS_PB1100) || defined(=
CONFIG_MIPS_PB1500) || defined(CONFIG_MIPS_PB1550)
-#define AU1X_SOCK1_IO        0xF08000000
-#define AU1X_SOCK1_PHYS_ATTR 0xF48000000
-#define AU1X_SOCK1_PHYS_MEM  0xF88000000
+#define AU1X_SOCK1_IO        0xF08000000LL
+#define AU1X_SOCK1_PHYS_ATTR 0xF48000000LL
+#define AU1X_SOCK1_PHYS_MEM  0xF88000000LL
 #define AU1X_SOCK1_PSEUDO_PHYS_ATTR 0xF4800000
 #define AU1X_SOCK1_PSEUDO_PHYS_MEM  0xF8800000
 #elif defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1100) || define=
d(CONFIG_MIPS_DB1500) || defined(CONFIG_MIPS_DB1550)
-#define AU1X_SOCK1_IO        0xF04000000
-#define AU1X_SOCK1_PHYS_ATTR 0xF44000000
-#define AU1X_SOCK1_PHYS_MEM  0xF84000000
+#define AU1X_SOCK1_IO        0xF04000000LL
+#define AU1X_SOCK1_PHYS_ATTR 0xF44000000LL
+#define AU1X_SOCK1_PHYS_MEM  0xF84000000LL
 #define AU1X_SOCK1_PSEUDO_PHYS_ATTR 0xF4400000
 #define AU1X_SOCK1_PSEUDO_PHYS_MEM  0xF8400000
 #endif


Some additional problems that I have been experiencing, but am still
investigating.  If anyone has any ideas of what is causing these, I'd
love to hear them.

I have 2 Senao 802.11b PCMCIA cards and I'm using the hostap_cs driver.
If I initialize pcmcia (cardmgr) with both cards in the PCMCIA slots
only one of them will initialize, the second one causes an error:

Linux Kernel Card Services
  options:  none
hostap_cs: 0.2.6 - 2004-12-25 (Jouni Malinen <jkmaline@cc.hut.fi>)
hostap_cs: Registered netdevice wifi0
hostap_cs: index 0x01: Vcc 3.3, irq 34, io 0xc0000000-0xc000003f
wifi0: NIC: id=3D0x800c v1.0.0
wifi0: PRI: id=3D0x15 v1.1.0
wifi0: STA: id=3D0x1f v1.4.9
0.0: RequestIO: Configuration locked    <--- Second card causes this
0.0: GetNextTuple: No more items
ds: unable to create instance of 'hostap_cs'!


If I bring up PCMCIA without the cards in, and then insert one, and then
the other, both cards initialize fine and I get wlan0 and wlan1.


The other problem I've experienced is a kernel oops when ejecting a
card.  While it isn't a problem for my project (should never be
inserting/ejecting cards) I thought I'd mention it.  Here is the oops
output, I wasn't able to use ksymoops since I'm having trouble building
a cross compiled version (buildroot didn't install libbfd, etc from
binutils), so this may or may not be useful:

Unhandled kernel unaligned access in arch/mips/kernel/unaligned.c::emulate_=
load_store_insn, line 475[#1]:
Cpu 0
$ 0   : 00000000 1000fc00 37312031 3a31303a
$ 4   : 83e6cec8 1000fc01 80300d48 00000031
$ 8   : 8110e080 801fadcc 00000000 80318000
$12   : 00000001 00000000 00000003 00000000
$16   : c0010000 83e6cec0 812b77a0 00000008
$20   : 812b77d0 80223c38 00200200 00100100
$24   : 00000000 801f5c60
$28   : 83dea000 83debe88 80364b60 c000a860
Hi    : 00000280
Lo    : 00000230
epc   : c000a8cc ds_event+0x2a0/0x4ac [pcmcia]     Not tainted
ra    : c000a860 ds_event+0x234/0x4ac [pcmcia]
Status: 1000fc02    KERNEL EXL
Cause : 00800014
BadVA : 3a31303a
PrId  : 02030204
Modules linked in: hostap_cs hostap pcmcia au1x00_ss pcmcia_core
Process pccardd (pid: 775, threadinfo=3D83dea000, task=3D83de67b0)
Stack : c0007f18 8012c328 80364b60 c00137d8 802f0000 c0007efc c0007dcc 8010=
0dd8
        0000003b c0007dcc c0007dcc c00052ec 80131c00 00200200 00000000 1000=
fc01
        c0007dcc 00000008 00000001 c00137d8 802f0000 c0007efc c0007f18 c000=
7f0c
        802ebc88 c00138c4 00000001 00000000 00000003 00000000 c0007dcc 0000=
0000
        c0013000 c0007dcc 80364b60 c0013d80 c0007f18 c0007f0c 00000000 2ab9=
2420
        ...
Call Trace:
 [<8012c328>] do_softirq+0x8c/0xb8
 [<c00137d8>] send_event+0x0/0x204 [pcmcia_core]
 [<80100dd8>] au1000_IRQ+0x118/0x1a0
 [<c00052ec>] au1x00_pcmcia_get_status+0x24/0x44 [au1x00_ss]
 [<80131c00>] msleep+0x48/0x60
 [<c00137d8>] send_event+0x0/0x204 [pcmcia_core]
 [<802ebc88>] __down+0x0/0x15c
 [<c00138c4>] send_event+0xec/0x204 [pcmcia_core]
 [<c0013000>] cs_debug_level+0x0/0x10 [pcmcia_core]
 [<c0013d80>] socket_shutdown+0x44/0x2cc [pcmcia_core]
 [<c0014bc0>] socket_remove+0x1c/0xf4 [pcmcia_core]
 [<c0014f94>] pccardd+0x2fc/0x470 [pcmcia_core]
 [<c00150ec>] pccardd+0x454/0x470 [pcmcia_core]
 [<c0014c98>] pccardd+0x0/0x470 [pcmcia_core]
 [<801208f0>] default_wake_function+0x0/0x20
 [<801208f0>] default_wake_function+0x0/0x20
 [<80104e8c>] kernel_thread_helper+0x10/0x18
 [<80104e7c>] kernel_thread_helper+0x0/0x18


Code: 8c820000  8c830004  2491fff8 <ac620000> ac430004  ac970000  ac960004 =
 8e220020  34420010


Best regards,
	Josh Green


--=-f8rVQ/0GO5hYvE2dZE4M
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCACB2RoMuWKCcbgQRAii7AJ9QgWk0UMO0+30AnARDG/2OXthTOgCcDIcM
ysb51gr4w/AFXQmeS1UskrM=
=6ak2
-----END PGP SIGNATURE-----

--=-f8rVQ/0GO5hYvE2dZE4M--
