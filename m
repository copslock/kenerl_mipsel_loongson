Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBE3aj011959
	for linux-mips-outgoing; Thu, 13 Dec 2001 19:36:45 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBE3ado11953
	for <linux-mips@oss.sgi.com>; Thu, 13 Dec 2001 19:36:40 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 0B955850; Fri, 14 Dec 2001 03:36:29 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 3E06B41FC; Fri, 14 Dec 2001 02:15:25 +0100 (CET)
Date: Fri, 14 Dec 2001 02:15:25 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Subject: [PATCH] complete indy timer fix - one liner missing
Message-ID: <20011214011525.GA25759@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
just a short one liner to let the current cvs compile ... Ralf - You
forgot this one ...:

Index: sgi-ip22/ip22-setup.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux/arch/mips/sgi-ip22/ip22-setup.c,v
retrieving revision 1.1.2.2
diff -u -r1.1.2.2 ip22-setup.c
--- sgi-ip22/ip22-setup.c	2001/12/13 22:14:01	1.1.2.2
+++ sgi-ip22/ip22-setup.c	2001/12/14 02:14:40
@@ -61,7 +61,7 @@
 	   indy_setup wouldn't work since kmalloc isn't initialized yet.  */
 	indy_reboot_setup();
=20
-	return request_irq(SGI_KEYBD_IRQ, handler, 0, "keyboard", NULL);
+	return request_irq(SGI_KEYBOARD_IRQ, handler, 0, "keyboard", NULL);
 }
=20
 static int sgi_aux_request_irq(void (*handler)(int, void *, struct pt_regs=
 *))


Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8GVKtUaz2rXW+gJcRAmoJAJ964zQzX/aSvYNCe8KGwylG5oSk2wCgoN6C
j2IMEX/MX8UN4nFw1YYPvk4=
=CEQ+
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
