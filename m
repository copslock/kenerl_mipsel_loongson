Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBFNxNU28294
	for linux-mips-outgoing; Sat, 15 Dec 2001 15:59:23 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBFNxHo28284
	for <linux-mips@oss.sgi.com>; Sat, 15 Dec 2001 15:59:18 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 21CCB842; Sat, 15 Dec 2001 23:59:07 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 37CC94242; Sat, 15 Dec 2001 23:58:24 +0100 (CET)
Date: Sat, 15 Dec 2001 23:58:24 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Karsten Merker <karsten@excalibur.cologne.de>
Cc: debian-mips@lists.debian.org, linux-mips@oss.sgi.com
Subject: Re: DELO problems
Message-ID: <20011215225824.GA3056@paradigm.rfc822.org>
References: <20011215230150.B2636@excalibur.cologne.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <20011215230150.B2636@excalibur.cologne.de>
User-Agent: Mutt/1.3.24i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 15, 2001 at 11:01:50PM +0100, Karsten Merker wrote:
> Hallo everyone,
>=20
> I cannot get delo to boot any recently built kernel - delo loads=20
> /etc/delo.conf, finds the correct kernel image and loads it,
> printing "Loading /boot/vmlinux ....... ok", but when the kernel
> itself should be startet (and print "This DECstation is a ...."),
> I get the firmware prompt again.

Have a look at the elf file with readelf - It shows a section which has
a len > 0 and the load address is "0" - When copieng the sections i
overwrite important stuff - This is actually a binutils fault not a
delos one. Although i have been told that i can heavily optimize the
stuff by not dealing with the sections rather than segments. I will
change that.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8G9WQUaz2rXW+gJcRAuqiAKCTkIGcYMFnfQC+re/3Np5+FGj0HgCgjLp3
kdPrf6gjUDq5sBJAkC1IxPs=
=fn+F
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
