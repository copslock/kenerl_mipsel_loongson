Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Apr 2004 20:58:47 +0100 (BST)
Received: from NAT.office.mind.be ([IPv6:::ffff:62.166.230.82]:53123 "EHLO
	codecarver.intern.mind.be") by linux-mips.org with ESMTP
	id <S8225747AbUDNT6o>; Wed, 14 Apr 2004 20:58:44 +0100
Received: from p2 by codecarver with local (Exim 3.36 #1 (Debian))
	id 1BDqTd-0001LQ-00
	for <linux-mips@linux-mips.org>; Wed, 14 Apr 2004 21:55:17 +0200
Date: Wed, 14 Apr 2004 21:55:17 +0200
To: linux-mips@linux-mips.org
Subject: TIOCGSERIAL for SB1250 UARTs
Message-ID: <20040414195517.GA1615@mind.be>
Mail-Followup-To: peter.de.schrijver@mind.be, linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline
X-Answer: 42
X-Operating-system: Debian GNU/Linux
X-Message-Flag: Get yourself a real email client. http://www.mutt.org/
X-mate: Mate, man gewoehnt sich an alles
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Peter 'p2' De Schrijver <p2@mind.be>
Return-Path: <p2@mind.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p2@mind.be
Precedence: bulk
X-list: linux-mips


--Bn2rw/3z4jIqBvZU
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

The attached patch implements the TIOCGSERIAL ioctl for the SB1250
DUART.=20

Thanks,

Peter (p2).

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sb1250-serial-patch-1
Content-Transfer-Encoding: quoted-printable

--- linux-2.4.24/drivers/char/sb1250_duart.c	2003-08-25 13:44:41.000000000 =
+0200
+++ linux-qube/linux-2.4.24/linux/drivers/char/sb1250_duart.c	2004-04-03 20=
:40:05.000000000 +0200
@@ -498,9 +498,31 @@
 	duart_set_cflag(us->line, tty->termios->c_cflag);
 }
=20
+static int get_serial_info(uart_state_t *us, struct serial_struct * retinf=
o) {
+
+	struct serial_struct tmp;
+
+	memset(&tmp, 0, sizeof(tmp));
+
+	tmp.type=3DPORT_SB1250;
+	tmp.line=3Dus->line;
+	tmp.port=3DA_DUART_CHANREG(tmp.line,0);
+	tmp.irq=3DK_INT_UART_0 + tmp.line;
+	tmp.xmit_fifo_size=3D16; /* fixed by hw */
+	tmp.baud_base=3D5000000;
+	tmp.io_type=3DSERIAL_IO_MEM;
+
+	if (copy_to_user(retinfo,&tmp,sizeof(*retinfo)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int duart_ioctl(struct tty_struct *tty, struct file * file,
 		       unsigned int cmd, unsigned long arg)
 {
+	uart_state_t *us =3D (uart_state_t *) tty->driver_data;
+
 /*	if (serial_paranoia_check(info, tty->device, "rs_ioctl"))
 	return -ENODEV;*/
 	switch (cmd) {
@@ -517,7 +539,7 @@
 		printk("Ignoring TIOCMSET\n");
 		break;
 	case TIOCGSERIAL:
-		printk("Ignoring TIOCGSERIAL\n");
+		return get_serial_info(us,(struct serial_struct *) arg);
 		break;
 	case TIOCSSERIAL:
 		printk("Ignoring TIOCSSERIAL\n");
--- linux-2.4.24/include/linux/serial.h	2002-08-03 02:39:45.000000000 +0200
+++ linux-qube/linux-2.4.24/linux/include/linux/serial.h	2004-04-03 20:14:3=
7.000000000 +0200
@@ -75,7 +75,8 @@
 #define PORT_16654	11
 #define PORT_16850	12
 #define PORT_RSA	13	/* RSA-DV II/S card */
-#define PORT_MAX	13
+#define PORT_SB1250	14
+#define PORT_MAX	14
=20
 #define SERIAL_IO_PORT	0
 #define SERIAL_IO_HUB6	1

--sm4nu43k4a2Rpi4c--

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAfZclKLKVw/RurbsRAvQzAJoDRsaOVlHuc7qFAgu62kEOv3tgcACfdmQk
SaxGh0AimGqI3r9DpypyH6I=
=uWhe
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
