Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.6/8.11.3) id g31MCtJ01475
	for linux-mips-outgoing; Mon, 1 Apr 2002 14:12:55 -0800
Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by oss.sgi.com (8.11.6/8.11.3) with SMTP id g31MCjo01432;
	Mon, 1 Apr 2002 14:12:45 -0800
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id LAA21785; Mon, 1 Apr 2002 11:39:03 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 623A97F6; Mon,  1 Apr 2002 21:30:22 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 85A573704F; Mon,  1 Apr 2002 21:29:57 +0200 (CEST)
Date: Mon, 1 Apr 2002 21:29:57 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Raoul Borenius <raoul@shuttle.de>
Cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com, devfs@oss.sgi.com
Subject: Re: broken devfs-support in SGI Zilog8530 serial driver
Message-ID: <20020401192957.GA1389@paradigm.rfc822.org>
References: <20020329103244.GA15765@bunny.shuttle.de> <20020329233559.A31160@dea.linux-mips.net> <20020330132856.GA24305@bunny.shuttle.de> <20020331150023.GA30224@bunny.shuttle.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <20020331150023.GA30224@bunny.shuttle.de>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 31, 2002 at 05:00:23PM +0200, Raoul Borenius wrote:
> Thanks for including the changes fr the ttyS's. But it seems you forgot t=
he
> callout-devices:
>=20
> > @@ -1911,7 +1915,11 @@
> >          * major number and the subtype code.
> >          */
> >         callout_driver =3D serial_driver;
> > +#ifdef CONFIG_DEVFS_FS
> > +       callout_driver.name =3D "cua/%d";
> > +#else
> >         callout_driver.name =3D "cua";
> > +#endif
> >         callout_driver.major =3D TTYAUX_MAJOR;
> >         callout_driver.subtype =3D SERIAL_TYPE_CALLOUT;
> >=20
>=20
> Could you commit that too?
>=20

I thought the callout devices are officially "dead" and should disappear
"Real Soon Now(tm)" as beeing a locking hell and unneeded.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8qLU1Uaz2rXW+gJcRAjZpAJ9uVKLMj8Wgx6VQgc9W9IrpM7c+kACeMD0q
BPbPAsgBEFTXxJrcTz2tUeQ=
=QeeF
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
