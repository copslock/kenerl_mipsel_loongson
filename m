Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5R1XsnC026648
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 26 Jun 2002 18:33:54 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5R1Xs5Q026647
	for linux-mips-outgoing; Wed, 26 Jun 2002 18:33:54 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from shaun.billgotchy.de (dialer11.kel.de.core.tng.de [213.178.65.11])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5R1XhnC026644
	for <linux-mips@oss.sgi.com>; Wed, 26 Jun 2002 18:33:45 -0700
Received: from shaun.billgotchy.de (shaun [127.0.0.1])
	by shaun.billgotchy.de (8.12.4/8.12.4/Debian-4) with ESMTP id g5R1VWF3026384
	for <linux-mips@oss.sgi.com>; Thu, 27 Jun 2002 03:31:32 +0200
Received: (from palic@localhost)
	by shaun.billgotchy.de (8.12.4/8.12.4/Debian-4) id g5R1VW8t026383
	for linux-mips@oss.sgi.com; Thu, 27 Jun 2002 03:31:32 +0200
Date: Thu, 27 Jun 2002 03:31:32 +0200
From: Jan-Hendrik Palic <jan.palic@linux-debian.de>
To: linux-mips@oss.sgi.com
Subject: Indy and Sound ...
Message-ID: <20020627013132.GB16583@billgotchy.de>
Mail-Followup-To: linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Internet: http://www.billgotchy.de
X-gpg-key: http://www.linux-debian.de/bin/m.asc
X-Fingerprint: D146 9433 E94B DD1E AB41  398B 41C3 45C1 331F FF66
X-Key-ID: 331FFF66
X-OS: Linux Debian Unstable
X-Private-Debian-Site: http://www.linux-debian.de
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi ..=20

I just got linux-2.4.18 with gcc-3.1 and sound running.

The only thing I had to change was this to get sound running:

--- linux-2.4/drivers/sound/dmabuf.c~   Sun Jun 17 03:11:43 2007
+++ linux-2.4/drivers/sound/dmabuf.c    Sun Jun 17 21:54:00 2007
@@ -24,6 +24,7 @@
=20
 #define BE_CONSERVATIVE
 #define SAMPLE_ROUNDUP 0
+#define DMA_AUTOINIT 0x010
   =20
 #include "sound_config.h"
 #include <linux/wrapper.h>


All went well .. :)

	Regards
		Jan
--=20
  .''`.    Jan-Hendrik Palic     |
 : :' : ** Debian GNU/ Linux **  |   ** OpenOffice.org **       ,.. ,..
 `. `'   http://www.debian.org   | http://www.openoffice.org  ,: ..`   `
   `-  jan.palic@linux-debian.de |                           '  `  `

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9Gmr0QcNFwTMf/2YRAZw/AKCFodGjncnQIL/dekYrBoU1ZHUfawCeN7gj
2osm01be4R+/i0TYILNBpJI=
=roYx
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--
