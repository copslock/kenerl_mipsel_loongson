Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Nov 2004 21:51:12 +0000 (GMT)
Received: from hydra.gt.owl.de ([IPv6:::ffff:195.71.99.218]:45018 "EHLO
	hydra.gt.owl.de") by linux-mips.org with ESMTP id <S8225214AbUKAVvH>;
	Mon, 1 Nov 2004 21:51:07 +0000
Received: by hydra.gt.owl.de (Postfix, from userid 104)
	id 1C38C1992CD; Mon,  1 Nov 2004 22:51:05 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 3102C138065; Mon,  1 Nov 2004 22:50:55 +0100 (CET)
Date: Mon, 1 Nov 2004 22:50:55 +0100
From: Florian Lohoff <flo@rfc822.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Dennis Grevenstein <dennis@pcde.inka.de>, linux-mips@linux-mips.org
Subject: Re: unable to handle kernel paging request
Message-ID: <20041101215055.GA27240@paradigm.rfc822.org>
References: <20041031184233.GA11120@aton.pcde.inka.de> <Pine.GSO.4.10.10410311947570.9753-100000@helios.et.put.poznan.pl> <20041031191631.GB11681@aton.pcde.inka.de> <20041031192653.GG2094@lug-owl.de> <20041031195550.GA12397@aton.pcde.inka.de> <20041031201335.GH2094@lug-owl.de> <20041031223612.GA15091@aton.pcde.inka.de> <Pine.LNX.4.58L.0410312354350.22630@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0410312354350.22630@blysk.ds.pg.gda.pl>
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 31, 2004 at 11:59:31PM +0000, Maciej W. Rozycki wrote:
> On Sun, 31 Oct 2004, Dennis Grevenstein wrote:
>=20
> >         struct tty_struct *tty =3D up->port.info->tty;    /* XXX info=
=3D=3DNULL? */
>=20
>  It looks up->port.info is null for some reason (and unhandled as noted=
=20
> in the comment).

I had the same problem and fixed it like this - It fixes some other
break/sysrq based problems ...

Index: drivers/serial/ip22zilog.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/flo/linux-mips-cvs/linux/drivers/serial/ip22zilog.c,v
retrieving revision 1.15
diff -u -r1.15 ip22zilog.c
--- drivers/serial/ip22zilog.c	28 Sep 2004 19:22:07 -0000	1.15
+++ drivers/serial/ip22zilog.c	3 Oct 2004 19:26:06 -0000
@@ -47,8 +47,6 @@
=20
 #include "ip22zilog.h"
=20
-void ip22_do_break(void);
-
 /*
  * On IP22 we need to delay after register accesses but we do not need to
  * flush writes.
@@ -256,17 +254,15 @@
 				   struct zilog_channel *channel,
 				   struct pt_regs *regs)
 {
-	struct tty_struct *tty =3D up->port.info->tty;	/* XXX info=3D=3DNULL? */
+	struct tty_struct *tty =3D NULL;
+
+	if (up->port.info !=3D NULL &&		/* Unopened serial console */
+	    up->port.info->tty !=3D NULL)		/* Keyboard || mouse */
+		tty =3D up->port.info->tty;
=20
 	while (1) {
 		unsigned char ch, r1;
=20
-		if (unlikely(tty->flip.count >=3D TTY_FLIPBUF_SIZE)) {
-			tty->flip.work.func((void *)tty);
-			if (tty->flip.count >=3D TTY_FLIPBUF_SIZE)
-				return;		/* XXX Ignores SysRq when we need it most. Fix. */
-		}
-
 		r1 =3D read_zsreg(channel, R1);
 		if (r1 & (PAR_ERR | Rx_OVR | CRC_ERR)) {
 			writeb(ERR_RES, &channel->control);
@@ -288,24 +284,8 @@
=20
 		ch &=3D up->parity_mask;
=20
-		if (ZS_IS_CONS(up) && (r1 & BRK_ABRT)) {
-			/* Wait for BREAK to deassert to avoid potentially
-			 * confusing the PROM.
-			 */
-			while (1) {
-				ch =3D readb(&channel->control);
-				ZSDELAY();
-				if (!(ch & BRK_ABRT))
-					break;
-			}
-			ip22_do_break();
-			return;
-		}
-
-		/* A real serial line, record the character and status.  */
-		*tty->flip.char_buf_ptr =3D ch;
-		*tty->flip.flag_buf_ptr =3D TTY_NORMAL;
 		up->port.icount.rx++;
+
 		if (r1 & (BRK_ABRT | PAR_ERR | Rx_OVR | CRC_ERR)) {
 			if (r1 & BRK_ABRT) {
 				r1 &=3D ~(PAR_ERR | CRC_ERR);
@@ -319,6 +299,25 @@
 				up->port.icount.frame++;
 			if (r1 & Rx_OVR)
 				up->port.icount.overrun++;
+		}
+
+		if (uart_handle_sysrq_char(&up->port, ch, regs))
+			goto next_char;
+
+		if (!tty)
+			goto next_char;
+
+		if (unlikely(tty->flip.count >=3D TTY_FLIPBUF_SIZE)) {
+			tty->flip.work.func((void *)tty);
+			if (tty->flip.count >=3D TTY_FLIPBUF_SIZE)
+				goto push_tty;		/* XXX We drop characters here - Either read or die */
+		}
+
+		/* A real serial line, record the character and status.  */
+		*tty->flip.char_buf_ptr =3D ch;
+		*tty->flip.flag_buf_ptr =3D TTY_NORMAL;
+
+		if (r1 & (BRK_ABRT | PAR_ERR | Rx_OVR | CRC_ERR)) {
 			r1 &=3D up->port.read_status_mask;
 			if (r1 & BRK_ABRT)
 				*tty->flip.flag_buf_ptr =3D TTY_BREAK;
@@ -327,8 +326,6 @@
 			else if (r1 & CRC_ERR)
 				*tty->flip.flag_buf_ptr =3D TTY_FRAME;
 		}
-		if (uart_handle_sysrq_char(&up->port, ch, regs))
-			goto next_char;
=20
 		if (up->port.ignore_status_mask =3D=3D 0xff ||
 		    (r1 & up->port.ignore_status_mask) =3D=3D 0) {
@@ -350,7 +347,9 @@
 			break;
 	}
=20
-	tty_flip_buffer_push(tty);
+push_tty:
+	if (tty)
+		tty_flip_buffer_push(tty);
 }
=20
 static void ip22zilog_status_handle(struct uart_ip22zilog_port *up,

--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBhq+/Uaz2rXW+gJcRApXvAKCyIrfLx2MkD1s3YjLZ7CWWA0Bb1gCg2tbJ
vpJSQWozcCpETZR2jXpuYpg=
=M8o8
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
