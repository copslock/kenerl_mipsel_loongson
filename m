Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2002 21:34:34 +0200 (CEST)
Received: from noose.gt.owl.de ([62.52.19.4]:34576 "HELO noose.gt.owl.de")
	by linux-mips.org with SMTP id <S1122987AbSIQTee>;
	Tue, 17 Sep 2002 21:34:34 +0200
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 26ED783F; Tue, 17 Sep 2002 21:34:26 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 5363E3717F; Tue, 17 Sep 2002 21:28:33 +0200 (CEST)
Date: Tue, 17 Sep 2002 21:28:33 +0200
From: Florian Lohoff <flo@rfc822.org>
To: William Jhun <wjhun@Oswego.EDU>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] ip22 console selection fixes
Message-ID: <20020917192833.GA11379@paradigm.rfc822.org>
References: <Pine.SOL.4.30.0209170504320.23947-100000@rocky.oswego.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0209170504320.23947-100000@rocky.oswego.edu>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2002 at 05:11:21AM -0400, William Jhun wrote:
> This patch fixes some problems in selecting which console to use on the
> ip22s.
>=20
> - Replace unobvious ttyS with arc for the arc console device name
> - If ARC var console=3Dd*, use serial. If 'g', use Newport only. If
>   neither or not set, default to ARC. Old code was disabling ARC
>   console and using serial console if CONFIG_ARC_CONSOLE was set. (why?!)
> - ArcGetEnvironmentVariable() can conceivably return NULL, so don't
>   blindly dereference.

I would rather like to see the whole ARC console stuff die - There will
never be any REAL ARC console usable in userspace - You can only
redirect kernel output there but has always seem to be unstable.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9h4JhUaz2rXW+gJcRAqitAJ9tW7gzhEb+CFv3FqIu7Uwojab5SACcDTjF
wbTzLI8HTC+G/htJb/QIuy4=
=aE2M
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
