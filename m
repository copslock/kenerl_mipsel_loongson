Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARCMXs15266
	for linux-mips-outgoing; Tue, 27 Nov 2001 04:22:33 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fARCMLo15262
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 04:22:22 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 24D8F861; Tue, 27 Nov 2001 12:22:15 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 8696B3F47; Tue, 27 Nov 2001 12:21:52 +0100 (CET)
Date: Tue, 27 Nov 2001 12:21:52 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Subject: [PATCH] NONCOHERENT_IO Decstation ?!
Message-ID: <20011127122152.F27987@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XIiC+We3v3zHqZ6Z"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--XIiC+We3v3zHqZ6Z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


My Decstation /150 does not get the point=20


SCSI subsystem driver Revision: 1.00
SCSI ID 7 Clk 25MHz CCF=3D5 TOut 167 NCR53C9x(esp236)
SCSI ID 7 Clk 12MHz CCF=3D3 TOut 139 NCR53C9x(esp236)
SCSI ID 7 Clk 12MHz CCF=3D3 TOut 139 NCR53C9x(esp236)
ESP: Total of 3 ESP hosts found, 3 actually in use.
scsi0 : ESP236 (NCR53C9x)
scsi1 : ESP236 (NCR53C9x)
scsi2 : ESP236 (NCR53C9x)
scsi: unknown type 17
  Vendor:           Model:     >   <   =E8=BD .  Rev:    =20
  Type:   Unknown                            ANSI SCSI revision: 01
resize_dma_pool: unknown device type 17
resize_dma_pool: unknown device type 17


Without:


Index: arch/mips/config.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux/arch/mips/config.in,v
retrieving revision 1.151
diff -u -r1.151 config.in
--- arch/mips/config.in	2001/11/26 12:01:08	1.151
+++ arch/mips/config.in	2001/11/27 12:17:26
@@ -292,6 +292,10 @@
        define_bool CONFIG_PC_KEYB y
 fi                            =20
=20
+if [ "$CONFIG_DECSTATION" =3D "y" ]; then
+       define_bool CONFIG_NONCOHERENT_IO y
+fi
+
 if [ "$CONFIG_ISA" !=3D "y" ]; then
    define_bool CONFIG_ISA n
    define_bool CONFIG_EISA n



Now the current cvs boots until userspace but its not very happy.

-----------------------------------
/etc/init.d/rcS: line 28:    32 Illegal Instruction     grep -qs resync
/proc/mdstat
Starting portmap daemon: portmap.
/etc/init.d/rcS: line 57:    39 Illegal Instruction     ( trap - INT
QUIT TSTP; set start; . $i )

Setting the System Clock using the Hardware Clock as reference...
/etc/init.d/rcS: line 57:    40 Illegal Instruction     ( trap - INT
QUIT TSTP; set start; . $i )
Cleaning: /tmp /var/lock /var/run.
Initializing random number generator... done.
-----------------------------------

Ill dig into this later ...

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--XIiC+We3v3zHqZ6Z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8A3dPUaz2rXW+gJcRAumHAJ9WThrgnJu1pqBFkfhnN1iZjxecnwCeLTIO
n9OTydijVjtSKA9MPwnSm04=
=/0qd
-----END PGP SIGNATURE-----

--XIiC+We3v3zHqZ6Z--
