Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Nov 2002 20:30:44 +0100 (CET)
Received: from noose.gt.owl.de ([62.52.19.4]:39692 "HELO noose.gt.owl.de")
	by linux-mips.org with SMTP id <S1123974AbSKRTan>;
	Mon, 18 Nov 2002 20:30:43 +0100
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 57D0B860; Mon, 18 Nov 2002 20:30:36 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 7A6A7B2A7; Mon, 18 Nov 2002 20:27:20 +0100 (CET)
Date: Mon, 18 Nov 2002 20:27:20 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Brian Murphy <brm@murphy.dk>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 2.4] load average fix for lasat boards (timer interrupt handling fix)
Message-ID: <20021118192720.GD5702@paradigm.rfc822.org>
References: <E18DXAH-0002KJ-00@brian.localnet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
Content-Disposition: inline
In-Reply-To: <E18DXAH-0002KJ-00@brian.localnet>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 17, 2002 at 10:41:13PM +0100, Brian Murphy wrote:
> Hi Florian, Ralf,
> 	it seems the method of calling the new time code changed
> or it was wrong all along, This patch fixes the problem of the
> ksoftirqd running all the time on Lasat systems, can you apply
> Ralf?

Works like a charm - Ralf already applied and i am running the CVS
from an hour after that happily ...

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE92T8YUaz2rXW+gJcRAliTAKDONbnHH35draQCtRlO8jk1ziu4fgCgxhEQ
jC7ETKvFPOeLJYFXeCjc6C0=
=/lYv
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--
