Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3PFbwwJ003125
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 25 Apr 2002 08:37:58 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3PFbwkj003124
	for linux-mips-outgoing; Thu, 25 Apr 2002 08:37:58 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3PFbqwJ003119
	for <linux-mips@oss.sgi.com>; Thu, 25 Apr 2002 08:37:53 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 8CE68845; Thu, 25 Apr 2002 17:38:20 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id D0D5B37049; Thu, 25 Apr 2002 17:36:22 +0200 (CEST)
Date: Thu, 25 Apr 2002 17:36:22 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Maurice Turcotte <turcotte@broadcom.com>
Cc: linux-mips@oss.sgi.com, Maurice Turcotte <mturc@broadcom.com>
Subject: Re: Linux Shared Memory Issue
Message-ID: <20020425153622.GA10683@paradigm.rfc822.org>
References: <NDBBKEAAOJECIDBJKLIHOEDDCDAA.turcotte@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <NDBBKEAAOJECIDBJKLIHOEDDCDAA.turcotte@broadcom.com>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2002 at 05:27:12PM -0400, Maurice Turcotte wrote:
> Greetings:
>=20
> I am having a problem with Linux Kernel 2.4.5 on a mips.
>=20
> I have two processes using share memory for IPC. This same
> code works fine with Kernel 2.4.7 on a x86. The problem is=20
> that the second process reads old data out of the shared
> memory.

This also shows with x-windows on mips with shared pixmaps.

We see this for a long time and did not come to a solution.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8yCJ2Uaz2rXW+gJcRAoLEAJ9smB0DEpS1dzI7Cdc31YlX8QawSQCgx4XU
764m4qJCeS3KSF5VUUXYRvs=
=LW93
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
