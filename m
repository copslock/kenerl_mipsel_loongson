Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4RLG4nC016624
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 27 May 2002 14:16:04 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4RLG4jD016623
	for linux-mips-outgoing; Mon, 27 May 2002 14:16:04 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4RLFunC016620;
	Mon, 27 May 2002 14:15:57 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id A00D2852; Mon, 27 May 2002 23:17:15 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 6F50137102; Mon, 27 May 2002 23:15:13 +0200 (CEST)
Date: Mon, 27 May 2002 23:15:13 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Robert Rusek <robru@teknuts.com>
Cc: "'Ralf Baechle'" <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: Executing IRIX binary ?
Message-ID: <20020527211513.GE32064@paradigm.rfc822.org>
References: <20020525154426.A2481@dea.linux-mips.net> <000701c205bd$adaeff40$0a01a8c0@sohotower>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ULyIDA2m8JTe+TiX"
Content-Disposition: inline
In-Reply-To: <000701c205bd$adaeff40$0a01a8c0@sohotower>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2002 at 01:32:43PM -0700, Robert Rusek wrote:
> Ralf,
>=20
> Looks like I have the kernal compiled with the IRIX binary support.  How
> do I go about executing the binaries?  When I try to execute it tells me
> that the file is not found.

Are you shure you have the dynamic loader + libc + other libs of IRIX
installed in your system ?

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--ULyIDA2m8JTe+TiX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE88qHhUaz2rXW+gJcRArFjAJ9u0j878ANVfB096xYPOTkqO8gMewCgjiHS
WUDlvsdAq/aTCA0fZrTRkWY=
=0cxL
-----END PGP SIGNATURE-----

--ULyIDA2m8JTe+TiX--
