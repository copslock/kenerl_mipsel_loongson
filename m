Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1NKCfT11277
	for linux-mips-outgoing; Sat, 23 Feb 2002 12:12:41 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1NKCZ911274
	for <linux-mips@oss.sgi.com>; Sat, 23 Feb 2002 12:12:35 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id E7BFA850; Sat, 23 Feb 2002 20:12:09 +0100 (CET)
Received: by localhost (Postfix, from userid 1000)
	id BDE9D1A2DF; Sat, 23 Feb 2002 20:11:26 +0100 (CET)
Date: Sat, 23 Feb 2002 20:11:26 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-mips@oss.sgi.com
Subject: Re: Problem with delo
Message-ID: <20020223191126.GA18791@paradigm.rfc822.org>
References: <20020222191734.B15503@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20020222191734.B15503@lug-owl.de>
User-Agent: Mutt/1.3.27i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2002 at 07:17:34PM +0100, Jan-Benedict Glaw wrote:
> 	/dev/sda1	Small Linux/ext2 partition containing
> 	/dev/sda2	Large Linux/ext2 partition containing
> 	/dev/sda3	Linux swap

> >> boot 3/rz1 2/linux
> delo V0.7 Copyright 2000 Florian Lohoff <flo@rfc822.org>
> callv addr a0002f88
> clo: 0 boot
> clo: 1 3/rz1
> clo: 2 2/linux
> Getting partition info
> Partition '2' 2
> bootread returned 512
> DOS disklabel found
>  1  0 83       62    98146
>  2  0 83    98208  5665374

> extfs_open returned Unknown ext2 error(2133571404)
> Couldnt fetch config.file /etc/delo.conf

Hmmm - looks strange ...

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8d+leUaz2rXW+gJcRAuqaAJwNqNdCU0XogQQvdCMRRX/jQen8YQCfd8Ky
BACoV0qbGfM+C5eLY4jx9tw=
=wTlj
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
