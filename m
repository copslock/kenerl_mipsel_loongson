Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Sep 2002 00:19:05 +0200 (CEST)
Received: from noose.gt.owl.de ([62.52.19.4]:48646 "HELO noose.gt.owl.de")
	by linux-mips.org with SMTP id <S1123906AbSIZWTE>;
	Fri, 27 Sep 2002 00:19:04 +0200
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 9683786B; Fri, 27 Sep 2002 00:18:50 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 702303717F; Fri, 27 Sep 2002 00:17:31 +0200 (CEST)
Date: Fri, 27 Sep 2002 00:17:31 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Alex deVries <adevries@linuxcare.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Format of bootable Indy CDs?
Message-ID: <20020926221731.GA14223@paradigm.rfc822.org>
References: <3D92B80A.3080802@linuxcare.com> <20020926171033.GA13337@paradigm.rfc822.org> <3D935DE6.7020206@linuxcare.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <3D935DE6.7020206@linuxcare.com>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2002 at 03:20:06PM -0400, Alex deVries wrote:
> Florian Lohoff wrote:
> >The firmware loads an ecoff file from a volume header - The volume
> >header is a special partition with a "minimalistic" filesystem
> >in it - This can be modified by "dvhtool".=20
>=20
> Okay.  I see an example of that mentioned in your mail in
> http://lists.debian.org/debian-mips/2002/debian-mips-200204/msg00056.html
> .  That seems to match with an EFS volume header.
>=20
> So making a tool that writes the 8k volume header is easy.  If I=20
> understand properly, that points to a filename on the EFS filesystem=20
> that follows it.
>=20
> What open source tools do we have to create such an EFS filesystem?

None .. Its not EFS - The Volume Header filesystem is MUCH simpler ...

Look into dvhtool to understand it ...

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9k4d7Uaz2rXW+gJcRAlOiAJ4xYMMdlHJmXQ0Lyynj2oeWn4fSlwCguNvZ
im+87WBePnjIgy+M4/GYEZw=
=XksZ
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
