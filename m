Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7VIV8U25729
	for linux-mips-outgoing; Fri, 31 Aug 2001 11:31:08 -0700
Received: from MVista.COM (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7VIV3d25726
	for <linux-mips@oss.sgi.com>; Fri, 31 Aug 2001 11:31:03 -0700
Received: (from pmundt@localhost)
	by MVista.COM (8.9.3/8.9.3) id LAA06262;
	Fri, 31 Aug 2001 11:20:07 -0700
Date: Fri, 31 Aug 2001 11:20:07 -0700
From: Paul Mundt <pmundt@MVista.COM>
To: Karsten Merker <karsten@excalibur.cologne.de>
Cc: linux-mips@oss.sgi.com, hkoerfg@web.de
Subject: Re: Patch to make current cvs (20010831) compile again for DECstations
Message-ID: <20010831112007.A5959@mvista.com>
References: <20010831202010.A1334@excalibur.cologne.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline
In-Reply-To: <20010831202010.A1334@excalibur.cologne.de>
User-Agent: Mutt/1.3.19i
Organization: MontaVista Software, Inc.
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--7ZAtKRhVyVSsbBD2
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 31, 2001 at 08:20:10PM +0200, Karsten Merker wrote:
[snip]
> +
> +void __init maxinefb_setup(char *options, int *ints)
> +{
> +}
> +
> =20
[snip]

Since this isn't being used at all, why not just remove it from fbmem.c?

Regards,

--=20
Paul Mundt <pmundt@mvista.com>
MontaVista Software, Inc.


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="maxinefb-nosetup.diff"
Content-Transfer-Encoding: quoted-printable

Index: fbmem.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux/drivers/video/fbmem.c,v
retrieving revision 1.42
diff -u -r1.42 fbmem.c
--- fbmem.c	2001/08/23 22:24:43	1.42
+++ fbmem.c	2001/08/31 18:30:09
@@ -123,7 +123,6 @@
 extern int pmagbbfb_init(void);
 extern int pmagbbfb_setup(char *options, int *ints);
 extern void maxinefb_init(void);
-extern void maxinefb_setup(char *options, int *ints);
 extern int tx3912fb_init(void);
 extern int radeonfb_init(void);
 extern int radeonfb_setup(char*);
@@ -309,7 +308,7 @@
 #endif
=20
 #ifdef CONFIG_FB_MAXINE
-        { "maxinefb", maxinefb_init, maxinefb_setup },
+        { "maxinefb", maxinefb_init, NULL },
 #endif
=20
=20

--mYCpIKhGyMATD0i+--

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7j9VXYLvqhoOEA4ERArQhAJ9dz3AZG8XyXUCSOoZHkFJO+ZHq0wCfey1X
YwP68TjHiH3umAJGbK5eN1I=
=wp6V
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
