Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBDIBYp14873
	for linux-mips-outgoing; Thu, 13 Dec 2001 10:11:34 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBDIBNo14867
	for <linux-mips@oss.sgi.com>; Thu, 13 Dec 2001 10:11:23 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 4A62F84A; Thu, 13 Dec 2001 18:11:13 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 6AB4944AF; Thu, 13 Dec 2001 18:10:43 +0100 (CET)
Date: Thu, 13 Dec 2001 18:10:43 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Guido Guenther <agx@sigxcpu.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: Current CVS on Indigo2 fail
Message-ID: <20011213171043.GD25296@paradigm.rfc822.org>
References: <20011213123522.GA32232@paradigm.rfc822.org> <20011213135229.C14699@gandalf.physik.uni-konstanz.de> <20011213134827.GA5630@paradigm.rfc822.org> <20011213150622.A13394@galadriel.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EP0wieDxd4TSJjHq"
Content-Disposition: inline
In-Reply-To: <20011213150622.A13394@galadriel.physik.uni-konstanz.de>
User-Agent: Mutt/1.3.24i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--EP0wieDxd4TSJjHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2001 at 03:06:22PM +0100, Guido Guenther wrote:
> > Definitly ? Mind sending me (the list) the patches too ?
> an old version is at:
>  http://honk.physik.uni-konstanz.de/~agx/linux-mips/unsorted-patches/newp=
ort-dont-crash-i2-2001-03-25.diff
> This currently doesn't apply cleanly due to the arch/mips/kernel/sgi to
> arch/mips/sgi-ip22 movement, but that's just a one line change. I'll
> update it when back home.

It solved the issue ... Here is the patch against current cvs


Index: arch/mips/config.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux/arch/mips/config.in,v
retrieving revision 1.154.2.3
diff -u -r1.154.2.3 config.in
--- arch/mips/config.in	2001/12/11 18:39:48	1.154.2.3
+++ arch/mips/config.in	2001/12/13 18:10:33
@@ -556,11 +556,10 @@
    comment 'SGI Character devices'
    if [ "$CONFIG_VT" =3D "y" ]; then
       tristate 'SGI Newport Console support' CONFIG_SGI_NEWPORT_CONSOLE
-      if [ "$CONFIG_SGI_NEWPORT_CONSOLE" !=3D "y" ]; then
-	 define_bool CONFIG_DUMMY_CONSOLE y
-      else
+      if [ "$CONFIG_SGI_NEWPORT_CONSOLE" =3D "y" ]; then
 	 define_bool CONFIG_FONT_8x16 y
       fi
+      define_bool CONFIG_DUMMY_CONSOLE y
    fi
    endmenu
 fi
Index: arch/mips/sgi-ip22/ip22-setup.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux/arch/mips/sgi-ip22/ip22-setup.c,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 ip22-setup.c
--- arch/mips/sgi-ip22/ip22-setup.c	2001/12/07 15:45:29	1.1.2.1
+++ arch/mips/sgi-ip22/ip22-setup.c	2001/12/13 18:10:33
@@ -182,19 +182,23 @@
=20
 #ifdef CONFIG_VT
 #ifdef CONFIG_SGI_NEWPORT_CONSOLE
-	conswitchp =3D &newport_con;
+	if( mips_machtype =3D=3D MACH_SGI_INDY ) {
+		conswitchp =3D &newport_con;
=20
-	screen_info =3D (struct screen_info) {
-		0, 0,		/* orig-x, orig-y */
-		0,		/* unused */
-		0,		/* orig_video_page */
-		0,		/* orig_video_mode */
-		160,		/* orig_video_cols */
-		0, 0, 0,	/* unused, ega_bx, unused */
-		64,		/* orig_video_lines */
-		0,		/* orig_video_isVGA */
-		16		/* orig_video_points */
-	};
+		screen_info =3D (struct screen_info) {
+			0, 0,		/* orig-x, orig-y */
+			0,		/* unused */
+			0,		/* orig_video_page */
+			0,		/* orig_video_mode */
+			160,		/* orig_video_cols */
+			0, 0, 0,	/* unused, ega_bx, unused */
+			64,		/* orig_video_lines */
+			0,		/* orig_video_isVGA */
+			16		/* orig_video_points */
+		};
+	} else {
+		conswitchp =3D &dummy_con;
+	}
 #else
 	conswitchp =3D &dummy_con;
 #endif

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--EP0wieDxd4TSJjHq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8GOETUaz2rXW+gJcRAvA4AKCVwQFrdj2MdFRviBQJM+u+srNARwCdHMSH
5gXxVmY3oKpTM46h0QoGaoQ=
=Ory0
-----END PGP SIGNATURE-----

--EP0wieDxd4TSJjHq--
