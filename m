Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBDI2gK14535
	for linux-mips-outgoing; Thu, 13 Dec 2001 10:02:42 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBDI2Xo14489
	for <linux-mips@oss.sgi.com>; Thu, 13 Dec 2001 10:02:34 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 9547784A; Thu, 13 Dec 2001 18:02:23 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id AEA1144AF; Thu, 13 Dec 2001 18:01:44 +0100 (CET)
Date: Thu, 13 Dec 2001 18:01:44 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Subject: [PATCH] add space and change to IP22 in arc/identify.c Was: Wrong /proc/cpuinfo on SGI Indy
Message-ID: <20011213170144.GA25296@paradigm.rfc822.org>
References: <20011213142413.GB12503@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <20011213142413.GB12503@paradigm.rfc822.org>
User-Agent: Mutt/1.3.24i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2001 at 03:24:13PM +0100, Florian Lohoff wrote:
> Hi,
> broken /proc/cpuinfo with current cvs:
>=20
> flo@revamp:~$ cat /proc/cpuinfo=20
> system type             : SGI IndyIndy
> processor               : 0
> cpu model               : R4600 V2.0  FPU V2.0
> BogoMIPS                : 132.71
> wait instruction        : yes
> microsecond timers      : yes
> extra interrupt vector  : no
> hardware watchpoint     : no
> VCED exceptions         : not available
> VCEI exceptions         : not available

Ok - I would suggest putting in this patch - It solves the issue that
the System type is "SGI IP22" and the subtype is "Indy", "Indigo2" or=20
"Challenge S" which would also need a space.

Index: arch/mips/arc/identify.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux/arch/mips/arc/identify.c,v
retrieving revision 1.5.2.1
diff -u -r1.5.2.1 identify.c
--- arch/mips/arc/identify.c	2001/12/12 13:45:57	1.5.2.1
+++ arch/mips/arc/identify.c	2001/12/13 18:00:04
@@ -26,7 +26,7 @@
=20
 static struct smatch mach_table[] =3D {
 	{	"SGI-IP22",
-		"SGI Indy",
+		"SGI IP22 ",
 		MACH_GROUP_SGI,
 		MACH_SGI_INDY,
 		PROM_FLAG_ARCS

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8GN74Uaz2rXW+gJcRApvsAJ9UHeybuuJa20vWzQdyFm2u56SHmgCglEYZ
GW3eCWlSbHBaPJtOdovKXF4=
=OcYT
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
