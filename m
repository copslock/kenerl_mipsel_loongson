Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g46AQswJ014336
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 6 May 2002 03:26:54 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g46AQsBd014335
	for linux-mips-outgoing; Mon, 6 May 2002 03:26:54 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g46AQgwJ014331
	for <linux-mips@oss.sgi.com>; Mon, 6 May 2002 03:26:48 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id C6CFC844; Mon,  6 May 2002 12:27:57 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 86F4D37115; Mon,  6 May 2002 12:27:32 +0200 (CEST)
Date: Mon, 6 May 2002 12:27:32 +0200
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Subject: RM200 big endian prom ?
Message-ID: <20020506102732.GC27584@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
i yesterday had a try booting my RM200 (Big Endian Sinix firmware)
with a big endian compiled kernel - It immediatly crashes in ArcWrite
as the Bios is not an Arc (Probably a bit similar).

Does anyone have interesting informations about that prom ?

BTW: There are really some funny lines in arc/init.c :)

arch/mips/arc/init.c
     36         if (pb->magic !=3D 0x53435241) {
     37                 prom_printf("Aieee, bad prom vector magic %08lx\n",=
 pb->magic);
     38                 while(1)
     39                         ;
     40         }
     41=20

Calling ArcWrite in case of no Arc ;) At least one knows what happens
if the Firmware is giving out EPC Faulting address (Which in this case
is 0x6c)

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE81lqUUaz2rXW+gJcRAl8dAKCx99Z1+Wa+fLwghWbCTZGYEZG3VACeOdu9
dBjAlhppJ7jPvktsQrEsTgo=
=5oiX
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--
