Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Sep 2002 18:10:45 +0200 (CEST)
Received: from noose.gt.owl.de ([62.52.19.4]:58384 "HELO noose.gt.owl.de")
	by linux-mips.org with SMTP id <S1122961AbSI0QKo>;
	Fri, 27 Sep 2002 18:10:44 +0200
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 09DCA873; Fri, 27 Sep 2002 18:10:39 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 5C3FB3717F; Fri, 27 Sep 2002 18:07:37 +0200 (CEST)
Date: Fri, 27 Sep 2002 18:07:37 +0200
From: Florian Lohoff <flo@rfc822.org>
To: William Jhun <wjhun@Oswego.EDU>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] ip22 console selection fixes
Message-ID: <20020927160737.GB6960@paradigm.rfc822.org>
References: <Pine.SOL.4.30.0209170504320.23947-100000@rocky.oswego.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0209170504320.23947-100000@rocky.oswego.edu>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--E39vaYmALEf/7YXx
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
>=20

After trying this patch or better current CVS i see the point - Ralf -
This patch should go in - Otherwise the whole console stuff is broken
on the Indy.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9lIJJUaz2rXW+gJcRAihbAKCtarT2EuE7CtCi9V6zMTupqjRoLQCfTQkU
VkjKcrjQI8Z6mdL0V6r2Qzo=
=wtt+
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
