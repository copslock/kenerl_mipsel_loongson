Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g48BmkwJ027944
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 8 May 2002 04:48:46 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g48BmkdU027943
	for linux-mips-outgoing; Wed, 8 May 2002 04:48:46 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g48BmcwJ027940
	for <linux-mips@oss.sgi.com>; Wed, 8 May 2002 04:48:40 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 7242783A; Wed,  8 May 2002 13:50:03 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id EC2DD3711E; Wed,  8 May 2002 13:49:17 +0200 (CEST)
Date: Wed, 8 May 2002 13:49:17 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Szabo Attila <trial@ugyvitelszolgaltato.hu>
Cc: linux-mips@oss.sgi.com
Subject: Re: indy scsi
Message-ID: <20020508114917.GA6625@paradigm.rfc822.org>
References: <20020508095508.A1682@ugyvitelszolgaltato.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <20020508095508.A1682@ugyvitelszolgaltato.hu>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2002 at 09:55:08AM +0200, Szabo Attila wrote:
> Hi !
>=20
> I've put a WD enterprise 4360 Ultra3 scsi disk into my Indy.
> It is the only disk, and I disabled the wide negotiating on the disk.
> But it is too slow.I'm running debian woody and I've tested it
> with hdparm, but the buffered disk reads is just 1.7 MB/sec.
> It is very slow !!
> Is there any way to make it faster ??

Probably no - 1.7MB/s sound not too bad - Remember - That machine
is 10 Years old and was produced at times a i386 was modern which
had 1MB/s memory bandwidth.

SCSI transfers on the indy/I2 are made with DMA so i guess there is=20
no real speedup to expect.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE82RC9Uaz2rXW+gJcRAuVKAKDJ7IHMHY7oPdV+HHNWMypUXGAjmgCgmHPW
NphrmEPazaaFOtAw6B3wEBY=
=OkX9
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
