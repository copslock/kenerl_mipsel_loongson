Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fASEN4H21324
	for linux-mips-outgoing; Wed, 28 Nov 2001 06:23:04 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fASEMwo21311
	for <linux-mips@oss.sgi.com>; Wed, 28 Nov 2001 06:22:58 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 2F5F5AA2; Wed, 28 Nov 2001 14:22:52 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 701C24127; Wed, 28 Nov 2001 14:19:34 +0100 (CET)
Date: Wed, 28 Nov 2001 14:19:34 +0100
From: Florian Lohoff <flo@rfc822.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>, linux-mips@oss.sgi.com,
   karel@sparta.research.kpn.com, algernon@debian.org
Subject: Re: Decstation /150 kernel (cvs) problems
Message-ID: <20011128141934.B5530@paradigm.rfc822.org>
References: <20011127163602.C9282@paradigm.rfc822.org> <Pine.GSO.3.96.1011127180947.440K-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1011127180947.440K-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.3.23i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2001 at 06:23:11PM +0100, Maciej W. Rozycki wrote:
> On Tue, 27 Nov 2001, Florian Lohoff wrote:
> > This is mostly what i do - As the ext2 code loads in the whole file
> > as a chunk i am loading it after the booloader - Then copy it to the
> > end of the first 8Megs (Which is the minimum memory on a decstation)
> > and then copy the chunks marked PROGBITS to their final location.
>=20
>  That's ugly -- isn't there a possibility to read a file on a
> block-by-block basis?
>=20

I am using the libext2 which basically might do that - i am unshure.
I am currently using=20

retval=3Dext2fs_block_iterate(fs, inode, 0, 0, delo_dump_block, 0);

Which basically loads in all the blocks by calling "delo_dump_block"
for each block with the block on the device to load and the block number
this is in the file.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8BORmUaz2rXW+gJcRArAwAJ9hiyiDm8qXO8R5UI0ziyeqAD9lrgCfc0pb
7Snkmd648LtwSmhcmFwDor4=
=QYi+
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
